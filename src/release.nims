mode = ScriptMode.Verbose
exec """nim compile --app:gui --opt:speed --cpu:ia64 -t:-m64 -l:-m64 --out:"../nDustman.exe" main.nim"""
if existsFile "../test.exe": rmFile "../test.exe"