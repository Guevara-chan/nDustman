# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
# nDustman's GUI Cascading Style Sheets     #
# Developed in 2021 by Victoria A. Guevara  #
# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #

withPIhandle(dlg):
    "TITLE"         "nDustman v0.04"
    "MARGIN"        "5x5"
    "SIZE"          "270x190"
    "SHRINK"        "YES"
    "MINSIZE"       "370x270"
    "BGCOLOR"       "31 31 31"
withPIhandle(header):
    "MARGIN"        "0x3"
withPIhandle(rand_btn):
    "BGCOLOR"       "15 15 15"
    "BORDERCOLOR"   "218 165 32"
    "FGCOLOR"       "218 165 32"
    "HLCOLOR"       "61 41 31"
    "TEXTHLCOLOR"   "255 215 0"
    "PSCOLOR"       "255 215 0"
    "BORDER"        "YES"
    "FOCUSFEEDBACK" "NO"
    "PADDING"       "5x2"
withPIhandle(clear_btn):
    "ALIGNMENT"     "ARIGHT"
    "BGCOLOR"       "15 15 15"
    "BORDERCOLOR"   "64 64 64"
    "FGCOLOR"       "128 0 128"
    "HLCOLOR"       "31 31 31"
    "TEXTHLCOLOR"   "218 112 214"
    "PSCOLOR"       "218 112 214"
    "BORDER"        "NO"
    "FOCUSFEEDBACK" "NO"
    "PADDING"       "3x2"
withPIhandle(link):
    "FGCOLOR"       "220 20 60"
    "EXPAND"        "HORIZONTAL"
    "ALIGNMENT"     "ACENTER"
    "PADDING"       "0x3"
    "TIPFONT"       "SYSTEM"
withPIhandle(framer):
    "MARGIN"        "2x2"
    "BGCOLOR"       "15 15 15"
withPIhandle(area):
    "MULTILINE"     "YES"
    "EXPAND"        "YES"
    "NAME"          "MULTITEXT"
    "APPENDNEWLINE" "NO"
    "READONLY"      "YES"
    "BORDER"        "NO"
    "FONT"          "Fixedsys 10"
    "BGCOLOR"       "15 15 15"
    "FORMATTING"    "YES"
withPIhandle(brake_box):
    "VALUE"         "ON"
withPIhandle(brake_txt):
    "FGCOLOR"       "218 112 214"
    "PADDING"       "2x0"
withPIhandle(scan_stat):
    "FGCOLOR"       "255 127 80"
    "ALIGNMENT"     "ACENTER"
    "PADDING"       "0x0"
    "EXPAND"        "HORIZONTAL"
    "RATE"          "0 1"
withPIhandle(aopen_txt):
    "FGCOLOR"       "255 3 62"
    "ALIGNMENT"     "ARIGHT"
    "PADDING"       "2x0"
withPIhandle(aopen_box):
    "RIGHTBUTTON"   "YES"
    "VALUE"         @["OFF", "ON"][cfg.parse("auto_open", "0").parseInt.bool.int]
withPIhandle(middler):
    "MARGIN"        "0x2"
withPihandle(min_hint):
    "FGCOLOR"       "248 248 255"
    "PADDING"       "2x0"
    "EXPAND"        "VERTICALFREE"
withPIhandle(min_spin):
    "SPIN"          "YES"
    "READONLY"      "YES"
    "SPINMIN"       "1"
    "FGCOLOR"       "0 206 209"
    "EXPAND"        "HORIZONTAL"
    "NOHIDESEL"     "NO"
    "VALUE"         $(cfg.urlimit.min)
    "SPINMAX"       $(cfg.urlimit.max)
withPihandle(max_hint):
    "FGCOLOR"       "248 248 255"
    "PADDING"       "2x0"
    "EXPAND"        "VERTICALFREE"
withPIhandle(max_spin):
    "SPIN"          "YES"
    "READONLY"      "YES"
    "SPINMIN"       "1"
    "FGCOLOR"       "0 206 209"
    "EXPAND"        "HORIZONTAL"
    "NOHIDESEL"     "NO"
    "VALUE"         $(cfg.urlimit.max)
    "SPINMIN"       $(cfg.urlimit.min)
withPIhandle(minmaxer):
    "MARGIN"        "0x2"
withPihandle(dom_hint):
    "FGCOLOR"       "248 248 255"
    "PADDING"       "2x0"
    "EXPAND"        "VERTICALFREE"
withPIhandle(dom_ibox):
    "FGCOLOR"       "0 206 209"
    "EXPAND"        "HORIZONTAL"
    "MASK"          "(/./w+ )*(/./w+ ?)"
    "NOHIDESEL"     "NO"
    "VALUE"         cfg.domains.join(" ")
withPIhandle(domainer):
    "MARGIN"        "0x1"
withPihandle(mask_hint):
    "FGCOLOR"       "248 248 255"
    "PADDING"       "2x0"
    "EXPAND"        "VERTICALFREE"
withPIhandle(mask_ibox):
    "FGCOLOR"       "0 206 209"
    "EXPAND"        "HORIZONTAL"
    "MASK"          "(/w|/.|/-)*/*(/w|/./-)*"
    "NOHIDESEL"     "NO"
    "VALUE"         cfg.mask
withPIhandle(masker):
    "MARGIN"        "0x1"
withPihandle(pool_hint):
    "FGCOLOR"       "248 248 255"
    "PADDING"       "2x0"
    "EXPAND"        "VERTICALFREE"
withPIhandle(pool_ibox):
    "FGCOLOR"       "0 206 209"
    "EXPAND"        "HORIZONTAL"
    "MASK"          "(/w|/-)+"
    "NOHIDESEL"     "NO"
    "VALUE"         cfg.charpool.join("")
withPIhandle(pooler):
    "MARGIN"        "0x1"
withPihandle(sum_hint):
    "FGCOLOR"       "248 248 255"
    "PADDING"       "2x0"
    "EXPAND"        "VERTICALFREE"
withPIhandle(sum_spin):
    "SPIN"          "YES"
    "READONLY"      "YES"
    "SPINMIN"       "0"
    "FGCOLOR"       "0 206 209"
    "EXPAND"        "HORIZONTAL"
    "NOHIDESEL"     "NO"
    "VALUE"         "25"
withPIhandle(anote_txt):
    "FGCOLOR"       "248 248 255"
    "ALIGNMENT"     "ARIGHT"
    "PADDING"       "2x0"
    "EXPAND"        "VERTICALFREE"
withPIhandle(anote_box):
    "RIGHTBUTTON"   "YES"
    "VALUE"         "ON"
    "EXPAND"        "VERTICALFREE"
withPIhandle(summator):
    "MARGIN"        "0x1"
withPIhandle(fnd_link):
    "ALIGNMENT"     "ALEFT:ABOTTOM"
    "EXPAND"        "VERTICALFREE"
    "FGCOLOR"       "248 131 121"
withPIhandle(cfg_link):
    "ALIGNMENT"     "ARIGHT:ABOTTOM"
    "EXPAND"        "VERTICALFREE"
    "FGCOLOR"       "33 171 205"
withPIhandle(fnd_span):
    "EXPAND"        "HORIZONTAL"
withPIhandle(cfg_span):
    "EXPAND"        "HORIZONTAL"
withPIhandle(apply_btn):
    "BGCOLOR"       "15 15 15"
    "BORDERCOLOR"   "189 183 107"
    "FGCOLOR"       "189 183 107"
    "HLCOLOR"       "41 41 31"
    "TEXTHLCOLOR"   "240 230 140"
    "PSCOLOR"       "240 230 140"
    "BORDER"        "YES"
    "FOCUSFEEDBACK" "NO"
    "PADDING"       "5x2"
withPIhandle(footer):
    "MARGIN"        "0x3"
withPIhandle(liner):
    "MARGIN"        "3x0"