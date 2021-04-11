# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
# nDustman junk sites URL generator v0.02   #
# Developed in 2021 by Victoria A. Guevara  #
# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
import random, nativesockets, threadpool, parsecfg, strutils, browsers, os, osproc, niup, niupext

# Basic init.
randomize()
getAppDir().setCurrentDir()
const config_file = "config.ini"
config_file.open(fmAppend).close()
var cfg = config_file.loadConfig()

# Aux configuration proc.
proc cfget(key: string, def_val: string): string =
    result = cfg.getSectionValue("", key, def_val)
    cfg.setSectionKey "", key, result

# Config parsing.
let urlimit = (min: "min_url".cfget("6").parseInt, max: "max_url".cfget("6").parseInt)
let domains = "domains".cfget(".com .org .net").split(' ')

# Fiber body.
proc finder(urlen: int, domain: string, output: PIhandle, pool = {'a'..'z'}) {.gcsafe.} =
    while true:
        var url = "www."
        for i in 1..urlen: url &= sample(pool)
        url &= domain    
        try:
            discard url.getAddrInfo(Port 80, AfUnspec)
            let log = open("finds.txt", fmAppend)
            log.writeLine url
            log.close()
            SetAttribute(output, "ADDFORMATTAG", "url")
            SetAttribute(output, "APPEND", url)
        except: discard

# UI code.
Open()
let area      = Text(nil)
let link      = Link("https://vk.com/guevara_chan", "Developed in 2021 by Guevara-chan") 
let rand_btn  = FlatButton("GO RANDOM")
let resp_btn  = FlatButton("{X}")
let header    = Hbox(rand_btn, link, resp_btn, nil)
let framer    = Vbox(area, nil)
let cfg_info  = Label("URL length range = " & $urlimit & "\nApplicable domains: " & $domains)
let cfg_link  = Link(config_file.absolutePath, config_file)
let footer    = Hbox(cfg_info, cfg_link, nil)
let liner     = Vbox(header, Frame(framer), footer, nil)
let dlg       = Dialog(liner)
let formattag = User()
include       "./css.nim"

# Callbacks setup and naming.
SetHandle("url", formattag)
niup.SetCallback area, "CARET_CB", proc (ih: PIhandle): cint {.cdecl.} =
    let url = "http://" & $GetAttribute(ih, "LINEVALUE")
    SetAttribute(link, "TITLE", url); SetAttribute(link, "URL", url)
niup.SetCallback rand_btn, "FLAT_ACTION", proc (ih: PIhandle): cint {.cdecl.} =
    let url = GetAttribute(area, "VALUE").`$`.split('\n').sample()
    if url.len > 0: openDefaultBrowser("http://" & url)
niup.SetCallback resp_btn, "FLAT_ACTION", proc (ih: PIhandle): cint {.cdecl.} =
    discard getAppFilename().startProcess()
    quit()

# Fibers setup.
cfg.writeConfig(config_file)
for urlen in urlimit.min..urlimit.max:
    for domain in domains:
        spawn finder(urlen, domain, area)

# Finalization.
ShowXY dlg, IUP_CENTER, IUP_CENTER
MainLoop()
Close()