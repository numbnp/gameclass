Dim WshShell, oExec
Set WshShell = CreateObject("WScript.Shell")

Set oExec = WshShell.Exec("delphi32 -ns Client\GCCl.dpr")
WScript.Sleep 15000
Set oExec = WshShell.Exec("delphi32 -ns ClientService\GCClSrv.dpr")
WScript.Sleep 15000
Set oExec = WshShell.Exec("delphi32 -ns Server\GCServer.dpr")
