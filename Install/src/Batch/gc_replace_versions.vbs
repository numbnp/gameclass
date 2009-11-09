Set objArgs = WScript.Arguments  ' Создаем объект WshArguments

if objArgs.Count() <> 2 then
  WScript.Echo "Введите BASE_VERSION и APP_VERSION в качестве параметров"
Else
  strBaseVersion = objArgs.Unnamed.Item(0)
  strAppVersion = objArgs.Unnamed.Item(1)
  Set objFSO=CreateObject("Scripting.FileSystemObject")
  set objWSH=Wscript.CreateObject("Wscript.Shell")
  
  while not objFSO.FileExists("rootdir")
    objWSH.CurrentDirectory = ".."
  wend
  'Для инсталляционного файла нужны точки вместо пробелов
  strAppVersionDot = Replace(strAppVersion, " ", ".")

  strCmd = "wscript Install\src\Batch\ReplaceStringInFile.vbs "  
  Set objExec = objWSH.Exec(strCmd + "Server\gcserver.dof" + " ProductVersion " + """ProductVersion=" + strAppVersion + """" )
  While objExec.Status = 0
  WEnd
  Set objExec = objWSH.Exec(strCmd + "Client\gccl.dof" + " ProductVersion " + """ProductVersion=" + strAppVersion + """" )
  While objExec.Status = 0
  WEnd
  Set objExec = objWSH.Exec(strCmd + "ClientService\gcclsrv.dof" + " ProductVersion " + """ProductVersion=" + strAppVersion + """" )
  While objExec.Status = 0
  WEnd
  Set objExec = objWSH.Exec(strCmd + "ClientLinux\gccllin.dof" + " ProductVersion " + """ProductVersion=" + strAppVersion + """" )
  While objExec.Status = 0
  WEnd
' Корректируем gcconst.pas
  Set objExec = objWSH.Exec(strCmd + "Server\gcconst.pas" + " BASE_VERSION " + """  BASE_VERSION = '" + strBaseVersion + "';""" )
  While objExec.Status = 0
  WEnd

  Set objExec = objWSH.Exec(strCmd + "Server\gcconst.pas" + " APP_VERSION " + """  APP_VERSION = '" + strAppVersion + "';""" )
  While objExec.Status = 0
  WEnd
'  <var name="AppVersion" value="3.85"/>
  Set objExec = objWSH.Exec(strCmd + "Install\src\GI\gcsetup.gi2" + " 'AppVersion'  ""  <var name='AppVersion' value='" + strAppVersionDot + "'/>""")
  While objExec.Status = 0
  WEnd
'  <var name='AppName' value="GameClass3 v3.85"/>
  Set objExec = objWSH.Exec(strCmd + "Install\src\GI\gcsetup.gi2" + " 'AppName'  ""  <var name='AppName' value='GameClass3 " + strBaseVersion + "'/>""")
  While objExec.Status = 0
  WEnd
' Меняем имя дистрибутива и версии для цифровой подписи
  Set objExec = objWSH.Exec(strCmd + "Install\src\Batch\sign_gc.bat" + " ""set AppVersion=""  ""set AppVersion=GameClass3 " + strAppVersion + """")
  While objExec.Status = 0
  WEnd
  Set objExec = objWSH.Exec(strCmd + "Install\src\Batch\sign_gc.bat" + " ""set InstallFileName=""  ""set InstallFileName=gc3setup." + strAppVersionDot + ".exe""")
  While objExec.Status = 0
  WEnd

'set InstallFileName=

' Корректируем res-файлы
  strCmd = "Tools\ReplaceVerInfo\ReplaceVerInfo.exe " 
  strParameters = " ProductVersion """ + strAppVersion + """"
  Set objExec = objWSH.Exec(strCmd + "Server\gcserver.res" + strParameters)
  While objExec.Status = 0
  WEnd
  Set objExec = objWSH.Exec(strCmd + "Client\gccl.res" + strParameters)
  While objExec.Status = 0
  WEnd
  Set objExec = objWSH.Exec(strCmd + "ClientService\gcclsrv.res" + strParameters)
  While objExec.Status = 0
  WEnd
'  Set objExec = objWSH.Exec(strCmd + "ClientLinux\gccllin.res" + strParameters)
'  While objExec.Status = 0
'  WEnd
End If
