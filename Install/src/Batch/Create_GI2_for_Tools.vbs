Set objArgs = WScript.Arguments  ' —оздаем объект WshArguments
if objArgs.Count() <> 4 then
  WScript.Echo "¬ведите название, полное название, версию и сообщение дл€ утилиты в качестве параметров"
Else
  FileName=objArgs.Unnamed.Item(0)
  Set FSO=CreateObject("Scripting.FileSystemObject")
  set WSHShell=Wscript.CreateObject("Wscript.Shell")
  
  while not FSO.FileExists("rootdir")
    WshShell.CurrentDirectory = ".."
  wend
  
  Set InFile=FSO.OpenTextFile("Install\src\GI\tools.gi2",1)
  Set OutFile=FSO.OpenTextFile("Install\src\GI\" + FileName + ".gi2",2,true)
  
  while not InFile.AtEndOfStream
    line=InFile.Readline()
    ' --- convert -----
    if InStr(line,"<var name=""AppName"" value=") then line = "  <var name=""AppName"" value=""" + objArgs.Unnamed.Item(1) + """/>"
    if InStr(line,"<var name=""AppVersion"" value=") then line = "  <var name=""AppVersion"" value=""" + objArgs.Unnamed.Item(2) + """/>"
    if InStr(line,"<var name=""Message"" value=") then line = "  <var name=""Message"" value=""" + objArgs.Unnamed.Item(3) + """/>"
    if InStr(line,"<var name=""Tool"" value=") then line = "  <var name=""Tool"" value=""" + objArgs.Unnamed.Item(0) + """/>"
    ' -----------------
    OutFile.WriteLine(line)
  wend

  InFile.Close()
  OutFile.Close()
End If
