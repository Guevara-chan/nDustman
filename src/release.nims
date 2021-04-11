mode = ScriptMode.Verbose
exec """nim compile --cc:gcc --app:gui --passl:-s --opt:size --out:"../nDustman.exe" main.nim"""
if existsFile "../test.exe": rmFile "../test.exe"