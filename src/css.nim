# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
# nDustman's GUI Cascading Style Sheets       #
# Developed in 20218 by Victoria A. Guevara   #
# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #

withPIhandle(dlg):
    "TITLE"         "nDustman v0.02"
    "MARGIN"        "5x5"
    "SIZE"          "250x150"
    "SHRINK"        "YES"
    "MINSIZE"       "270x150"
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
withPIhandle(resp_btn):
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
    "LINK"          "NO"
    "PADDING"       "0x3"
withPIhandle(framer):
    "MARGIN"        "2x2"
    "BGCOLOR"       "15 15 15"
withPIhandle(area):
    "MULTILINE"     "YES"
    "EXPAND"        "YES"
    "NAME"          "MULTITEXT"
    "APPENDNEWLINE" "YES"
    "READONLY"      "YES"
    "BORDER"        "NO"
    "FONT"          "Fixedsys 10"
    "BGCOLOR"       "15 15 15"
    "FORMATTING"    "YES"
withPIhandle(cfg_info):
    "FGCOLOR"       "248 248 255"
    "EXPAND"        "HORIZONTAL"
withPIhandle(cfg_link):
    "ALIGNMENT"     "ARIGHT:ABOTTOM"
    "FGCOLOR"       "33 171 205"
withPIhandle(footer):
    "MARGIN"        "0x3"
withPIhandle(liner):
    "MARGIN"        "3x0"
withPIhandle(formattag):
    "FGCOLOR"       "248 131 121"
    "SELECTION"     "ALL"
