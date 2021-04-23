# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
# nDustman junk sites URL generator v0.03   #
# Developed in 2021 by Victoria A. Guevara  #
# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
import random, nativesockets, threadpool, parsecfg, strutils, sequtils # (terminal) legacy
import locks, browsers, os, osproc, httpclient, niup, niupext # Actual.

# Basic init.
randomize()
getAppDir().setCurrentDir()
const 
    config_file = "config.ini"
    finds_file  = "finds.txt"
config_file.open(fmAppend).close()
var 
    cfg = config_file.loadConfig()
    stat_lock, output_lock: Lock
stat_lock.initLock(); output_lock.initLock()

# Aux configuration proc.
proc cfget(key: string, def_val: string): string =
    result = cfg.getSectionValue("", key, def_val)
    cfg.setSectionKey "", key, result

# Config parsing.
let 
    urlimit  = (min: "min_url".cfget("5").parseInt, max: "max_url".cfget("6").parseInt)
    domains  = "domains".cfget(".com .org .net").split(' ')
    charpool = "char_pool".cfget({'a'..'z', '0'..'9'}.toSeq().join("")).toLower().toSeq().deduplicate()
    mask     = "mask".cfget("www.*")

# Fiber body.
proc finder(urlen: int; mask, domain: string; pool: seq[char]; output, supressor, stats, autoopen: PIhandle) =
    let 
        client = newHttpClient()
        decor  = mask.split("*", 1)
    while true:
        if supressor.GetAttribute("VALUE") == "ON":
            var 
                url = decor[0]
                success = 0
            for i in 1..urlen: url &= sample(pool)
            url &= decor[1] & domain
            try:
                discard url.getAddrInfo(Port 80, AfUnspec)
                if client.head("http://" & url).status == "200 OK":                
                    success = 1                    
                    let log = open(finds_file, fmAppend)
                    log.writeLine url
                    log.close()
                    output_lock.withLock:
                        output.SetAttribute "ADDFORMATTAG", "url"
                        output.SetAttribute "APPEND", url
                    if autoopen.GetAttribute("VALUE") == "ON": openDefaultBrowser("http://" & url)
            except: discard
            statlock.withLock:
                var rate = stats.GetAttribute("RATE").`$`.split(' ').map(parseInt)
                rate[0] += 1; rate[1] += success
                stats.SetAttribute "TITLE", $(rate[1]/rate[0] * 100).formatFloat(ffDecimal, 3) & "% success rate"
                stats.SetAttribute "RATE",  $rate[0] & " " & $rate[1]
        else: sleep(200)

# UI code.
Open()
let 
    area      = Text(nil)
    link      = Link("https://vk.com/guevara_chan", "Developed in 2021 by Guevara-chan") 
    rand_btn  = FlatButton("GO RANDOM")
    clear_btn = FlatButton("{X}")
    header    = Hbox(rand_btn, link, clear_btn, nil)
    framer    = Vbox(area, nil)
    brake_box = Toggle("", "SWITCH")
    brake_txt = Label("Scan new links")
    aopen_box = Toggle("", "SWITCH")
    aopen_txt = Label("Auto-open finds")
    scan_stat = Label("Creating fibers...")
    middler   = Hbox(brake_box, brake_txt, scan_stat, aopen_txt, aopen_box, nil)
    min_hint  = Label("Min URL length:")
    min_spin  = Text(nil)
    max_hint  = Label("Max URL length:")
    max_spin  = Text(nil)
    minmaxer  = Hbox(min_hint, min_spin, max_hint, max_spin, nil)
    dom_hint  = Label("Applicable domains:")
    dom_ibox  = Text(nil)
    domainer  = HBox(dom_hint, dom_ibox, nil)
    mask_hint = Label("Generation mask:")
    mask_ibox = Text(nil)
    masker    = HBox(mask_hint, mask_ibox, nil)
    pool_hint = Label("Character pool:")
    pool_ibox = Text(nil)
    pooler    = HBox(pool_hint, pool_ibox, nil)
    cfg_link  = Link(config_file.absolutePath, config_file)
    apply_btn = FlatButton("APPLY CONFIG")
    fnd_link  = Link(finds_file.absolutePath, finds_file)
    footer    = Hbox(fnd_link, apply_btn, cfg_link, nil)
    liner     = Vbox(header, Frame(framer), middler, minmaxer, domainer, masker, pooler, footer, nil)
    dlg       = Dialog(liner)
    formattag = User()
include        "./css.nim"

# Callbacks setup & small stuff.
SetHandle("url", formattag)
niup.SetCallback area, "CARET_CB", proc (ih: PIhandle): cint {.cdecl.} =
    let url = "http://" & ih.GetAttribute("LINEVALUE").`$`
    link.SetAttribute("TITLE", url); link.SetAttribute("URL", url)
niup.SetCallback rand_btn, "FLAT_ACTION", proc (ih: PIhandle): cint {.cdecl.} =
    let url = area.GetAttribute("VALUE").`$`.split('\n').sample()
    if url.len > 0: openDefaultBrowser("http://" & url)
niup.SetCallback apply_btn, "FLAT_ACTION", proc (ih: PIhandle): cint {.cdecl.} =
    for feed in @[("min_url", min_spin), ("max_url", max_spin), ("domains", dom_ibox), ("char_pool", pool_ibox), 
    ("mask", mask_ibox)]:
        cfg.setSectionKey "", feed[0], feed[1].GetAttribute("VALUE").`$`.strip()
    cfg.writeConfig config_file
    discard getAppFilename().startProcess()
    quit()
niup.SetCallback aopen_box, "ACTION", proc (ih: PIhandle): cint {.cdecl.} =
    cfg.setSectionKey "", "auto_open", (aopen_box.GetAttribute("VALUE") == "ON").int.`$`
    cfg.writeConfig config_file
niup.SetCallback clear_btn, "FLAT_ACTION", proc (ih: PIhandle): cint {.cdecl.} = 
    output_lock.withLock:
        area.SetAttribute "CLIPBOARD", "CLEAR"
niup.SetCallback min_spin, "VALUECHANGED_CB", proc (ih: PIhandle): cint {.cdecl.} = 
    max_spin.SetAttribute "SPINMIN", ih.GetAttribute("VALUE")
niup.SetCallback max_spin, "VALUECHANGED_CB", proc (ih: PIhandle): cint {.cdecl.} =
    min_spin.SetAttribute "SPINMAX", ih.GetAttribute("VALUE")

# Fibers setup.
cfg.writeConfig config_file
for urlen in urlimit.min..urlimit.max:
    for domain in domains:
        spawn finder(urlen, mask, domain, charpool, area, brake_box, scan_stat, aopen_box)

# Finalization.
ShowXY dlg, IUP_CENTER, IUP_CENTER
MainLoop()
Close()