Set objArgs = WScript.Arguments  ' Создаем объект WshArguments
if objArgs.Count() <> 3 then
  WScript.Echo "Введите название файла, подстроку поиска и троку замены в качестве параметров"
Else
  FileName=objArgs.Unnamed.Item(0)
  Set FSO=CreateObject("Scripting.FileSystemObject")
  set WSHShell=Wscript.CreateObject("Wscript.Shell")
  
  while not FSO.FileExists("rootdir")
    WshShell.CurrentDirectory = ".."
  wend

  If FSO.FileExists(FileName+".bak") Then
    FSO.DeleteFile FileName+".bak"
  End If
  FSO.MoveFile FileName, FileName+".bak"
  Set InFile=FSO.OpenTextFile(FileName+".bak", 1)
  Set OutFile=FSO.OpenTextFile(FileName, 2, true)
  
  while not InFile.AtEndOfStream
    line=InFile.Readline()
    ' --- convert -----
    if InStr(line, objArgs.Unnamed.Item(1)) then line = objArgs.Unnamed.Item(2)
    ' -----------------
    OutFile.WriteLine(line)
  wend

  InFile.Close()
  OutFile.Close()
  FSO.DeleteFile FileName+".bak"
End If
