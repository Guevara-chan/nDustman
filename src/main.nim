# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
# nDustman junk sites URL generator v0.02   #
# Developed in 2021 by Victoria A. Guevara  #
# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
import random, nativesockets, threadpool, parsecfg, strutils, sequtils, browsers, os, osproc, niup, niupext

# Basic init.
randomize()
getAppDir().setCurrentDir()
const 
    config_file = "config.ini"
    finds_file  = "finds.txt"
config_file.open(fmAppend).close()
var cfg = config_file.loadConfig()

# Aux configuration proc.
proc cfget(key: string, def_val: string): string =
    result = cfg.getSectionValue("", key, def_val)
    cfg.setSectionKey "", key, result

# Config parsing.
let urlimit  = (min: "min_url".cfget("5").parseInt, max: "max_url".cfget("6").parseInt)
let domains  = "domains".cfget(".com .org .net").split(' ')
let charpool = "char_pool".cfget({'a'..'z', '0'..'9'}.toSeq().join("")).toLower().toSeq().deduplicate()

# Fiber body.
proc finder(urlen: int, domain: string, pool: seq[char]; output, supressor: PIhandle) {.gcsafe.} =
    while true:
        if supressor.GetAttribute("VALUE") == "ON":
            var url = "www."
            for i in 1..urlen: url &= sample(pool)
            url &= domain    
            try:
                discard url.getAddrInfo(Port 80, AfUnspec)
                let log = open(finds_file, fmAppend)
                log.writeLine url
                log.close()
                output.SetAttribute "ADDFORMATTAG", "url"
                output.SetAttribute "APPEND", url
            except: discard
        else: sleep(200)

# UI code.
Open()
let 
    area      = Text(nil)
    link      = Link("https://vk.com/guevara_chan", "Developed in 2021 by Guevara-chan") 
    rand_btn  = FlatButton("GO RANDOM")
    resp_btn  = FlatButton("{X}")
    header    = Hbox(rand_btn, link, resp_btn, nil)
    framer    = Vbox(area, nil)
    brake_box = Toggle("Scan new links", "SWITCH")
    cfg_info  = Label("URL length range = " & $urlimit & "\nApplicable domains: " & $domains & "\nCharacter pool: " &
        charpool.join(""))
    cfg_link  = Link(config_file.absolutePath, config_file)
    footer    = Hbox(cfg_info, cfg_link, nil)
    liner     = Vbox(header, Frame(framer), brake_box, footer, nil)
    dlg       = Dialog(liner)
    formattag = User()
include        "./css.nim"

# Callbacks setup and naming.
SetHandle("url", formattag)
niup.SetCallback area, "CARET_CB", proc (ih: PIhandle): cint {.cdecl.} =
    let url = "http://" & ih.GetAttribute("LINEVALUE").`$`
    link.SetAttribute("TITLE", url); link.SetAttribute("URL", url)
niup.SetCallback rand_btn, "FLAT_ACTION", proc (ih: PIhandle): cint {.cdecl.} =
    let url = area.GetAttribute("VALUE").`$`.split('\n').sample()
    if url.len > 0: openDefaultBrowser("http://" & url)
niup.SetCallback resp_btn, "FLAT_ACTION", proc (ih: PIhandle): cint {.cdecl.} =
    discard getAppFilename().startProcess()
    quit()

# Fibers setup.
cfg.writeConfig config_file
for urlen in urlimit.min..urlimit.max:
    for domain in domains:
        spawn finder(urlen, domain, charpool, area, brake_box)

# Finalization.
ShowXY dlg, IUP_CENTER, IUP_CENTER
MainLoop()
Close()