
; HM NIS Edit Wizard helper defines
!define PRODUCT_NAME "GameClass3"
!define PRODUCT_VERSION "3.85.3.2"
!define PRODUCT_PUBLISHER "numb"
!define PRODUCT_WEB_SITE "http://forum.nodasoft.ru"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

SetCompressor lzma

; MUI 1.67 compatible ------
!include "MUI.nsh"

; MUI Settings
!define MUI_ABORTWARNING
!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\modern-install.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"

!define MUI_WELCOMEFINISHPAGE_BITMAP "c:\Projects\Free\Res\Installer.bmp"

; Welcome page
!insertmacro MUI_PAGE_WELCOME

; Directory page
!insertmacro MUI_PAGE_DIRECTORY
; Select components
!insertmacro MUI_PAGE_COMPONENTS
; Instfiles page
!insertmacro MUI_PAGE_INSTFILES
; Finish page
!insertmacro MUI_PAGE_FINISH

; Uninstaller pages
!insertmacro MUI_UNPAGE_INSTFILES

; Language files
!insertmacro MUI_LANGUAGE "Russian"

; Reserve files
!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS

; MUI end ------

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "c:\Projects\Free\Output\Setup\gc3setup.${PRODUCT_VERSION}.exe"
InstallDir "$PROGRAMFILES\GameClass3"
ShowInstDetails show
ShowUnInstDetails show

InstType "Клиентское рабочее место"
InstType "Рабочее место менеджера"
InstType "Главный компьютер установка"
InstType "Главный компьютер обновление"

Section "Клиентская часть GameClass" SEC01
  SectionIn 1

; На случай обновления останавливаем клиент и удаляем службу
  ExecWait 'net stop srvgccl'
  ExecWait '$INSTDIR\Client\gcclsrv.exe -uninstall -silent'
  ExecWait 'taskkill /IM gccl.exe /F'
  ExecWait 'tskill gccl /A'

; Заливаем файлы клиента
  SetOutPath "$INSTDIR\Client"
  SetOverwrite on
  File "c:\Projects\Free\Install\src\Packages\Client\*.*"
  SetOutPath "$INSTDIR\Client\Skins"
  SetOverwrite on
  File "c:\Projects\Free\Install\src\Packages\Client\Skins\*.*"
  SetOutPath "$INSTDIR\Client\Sounds"
  SetOverwrite on
  File "c:\Projects\Free\Install\src\Packages\Client\Sounds\*.*"
  SetOutPath "$INSTDIR\Client\Files"

; Делаем нужные записи в реестре
  WriteRegStr HKLM "SOFTWARE\GameClass3\Client" "InstallDirectory" "$INSTDIR\Client"
  WriteRegStr HKLM "SOFTWARE\GameClass3\Client" "CurrentVersion" "${PRODUCT_VERSION}"
  
; Прописываемся в автозагрузку
  WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Run" "GameClass Client" "$INSTDIR\Client\gccl.exe"

; Прописываемся в фаерволе
  ExecWait 'netsh firewall add allowedprogram "$INSTDIR\Client\gccl.exe" GCClient ENABLE'
  ExecWait 'netsh firewall add allowedprogram "$INSTDIR\Client\gcclsrv.exe" GCClientService ENABLE'
  
; Регистрируем службу и запускаем ее
  ExecWait '$INSTDIR\Client\gcclsrv.exe -install -silent'
  ExecWait 'net start srvgccl'
  
SectionEnd

Section "Сервер GameClass" SEC02
  SectionIn 2 3 4
  SetOutPath "$INSTDIR"
  SetOverwrite ifnewer
  File "C:\Projects\Free\Install\src\Packages\Server\*.*"
  SetOutPath "$INSTDIR\Scripts"
  SetOverwrite ifnewer
  File "C:\Projects\Free\Install\src\Packages\Server\Scripts\*.*"
  SetOutPath "$INSTDIR\Traffic Inspector Plug-In"
  SetOverwrite ifnewer
  File "C:\Projects\Free\Install\src\Packages\Server\Traffic Inspector Plug-In\*.*"
  SetOutPath "$INSTDIR\UserGate Plug-In"
  SetOverwrite ifnewer
  File "C:\Projects\Free\Install\src\Packages\Server\UserGate Plug-In\*.*"

; Делаем нужные записи в реестре
  WriteRegStr HKLM "SOFTWARE\GameClass3\Server" "InstallDirectory" "$INSTDIR"
  WriteRegStr HKLM "SOFTWARE\GameClass3\Server" "CurrentVersion" "${PRODUCT_VERSION}"

  SetOutPath "$INSTDIR"
  WriteIniStr "$INSTDIR\${PRODUCT_NAME}.url" "InternetShortcut" "URL" "${PRODUCT_WEB_SITE}"
  CreateDirectory "$SMPROGRAMS\GameClass3"
  CreateShortCut "$SMPROGRAMS\GameClass3\GameClass3.lnk" "$INSTDIR\GCServer.exe"
  CreateShortCut "$SMPROGRAMS\GameClass3\Website.lnk" "$INSTDIR\${PRODUCT_NAME}.url"
  CreateShortCut "$SMPROGRAMS\GameClass3\Uninstall.lnk" "$INSTDIR\uninst.exe"
  CreateShortCut "$SMPROGRAMS\GameClass3\Backup and Restore database.lnk" "$INSTDIR\GCBackupRestore.exe"
  CreateShortCut "$SMPROGRAMS\GameClass3\Traffic Inspector Plug-In Installation.lnk" "$INSTDIR\Traffic Inspector Plug-In\gcti.2.0.5.exe"
  CreateShortCut "$SMPROGRAMS\GameClass3\UserGate 2.8 Plug-In.lnk" "$INSTDIR\UserGate Plug-In\gcugate.exe"
SectionEnd

Section "Создание БД" SEC03
  SectionIn 3
  SetOutPath "$INSTDIR\SQL"
  SetOverwrite ifnewer
  File "c:\Projects\Free\Install\src\Packages\Database\*.sqp"
  SetOutPath "$INSTDIR\SQL"
  SetOverwrite ifnewer
  File "c:\Projects\Free\Install\src\Packages\Database\*.xml"
  SetOutPath "$INSTDIR\SQL"
  SetOverwrite ifnewer
  File "c:\Projects\Free\Install\src\Packages\Database\GCosql.exe"
  
  ExecWait "$INSTDIR\SQL\GCosql.exe customcreatedatabase dbconfig.xml"
  
;  Delete "$INSTDIR\SQL\*.*"
  RMDir /r "$INSTDIR\SQL"

SectionEnd

Section "Обновление БД" SEC04
  SectionIn 4
  SetOutPath "$INSTDIR\SQL"
  SetOverwrite ifnewer
  File "c:\Projects\Free\Install\src\Packages\Database\*.sqp"
  SetOutPath "$INSTDIR\SQL"
  SetOverwrite ifnewer
  File "c:\Projects\Free\Install\src\Packages\Database\*.xml"
  SetOutPath "$INSTDIR\SQL"
  SetOverwrite ifnewer
  File "c:\Projects\Free\Install\src\Packages\Database\GCosql.exe"

  ExecWait "$INSTDIR\SQL\GCosql.exe updatedatabase dbconfig.xml"

;  Delete "$INSTDIR\SQL\*.*"
  RMDir /r "$INSTDIR\SQL"

SectionEnd

LangString DESC_OPERATOR ${LANG_RUSSIAN} "Основная часть комплекса"
LangString DESC_CLIENT ${LANG_RUSSIAN} "Часть комплекса устанавливаемая на клиентские компьюторы"
LangString DESC_CREATEDB ${LANG_RUSSIAN} "Создание новой базы данных"
LangString DESC_UPDATEDB ${LANG_RUSSIAN} "Обновление базы данных"

!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
!insertmacro MUI_DESCRIPTION_TEXT ${SEC02} $(DESC_OPERATOR)
!insertmacro MUI_DESCRIPTION_TEXT ${SEC01} $(DESC_CLIENT)
!insertmacro MUI_DESCRIPTION_TEXT ${SEC03} $(DESC_CREATEDB)
!insertmacro MUI_DESCRIPTION_TEXT ${SEC04} $(DESC_UPDATEDB)
!insertmacro MUI_FUNCTION_DESCRIPTION_END

Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
SectionEnd


;Function un.onUninstSuccess
;  HideWindow
;  MessageBox MB_ICONINFORMATION|MB_OK "Удаление программы $(^Name) было успешно завершено."
;FunctionEnd

;Function un.onInit
;  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "Вы уверены в том, что желаете удалить $(^Name) и все компоненты программы?" IDYES +2
;  Abort
;FunctionEnd

Section Uninstall

  ExecWait 'net stop srvgccl'
  ExecWait '$INSTDIR\Client\gcclsrv.exe -uninstall -silent'
  ExecWait 'taskkill /IM gccl.exe /F'
  ExecWait 'tskill gccl /A'

;  Delete "$INSTDIR\Client\Skins\*.*"
;  RmDir "$INSTDIR\Client\Skins"
;  Delete "$INSTDIR\Client\Sounds\*.*"
;  RmDir "$INSTDIR\Client\Sounds"
;  Delete "$INSTDIR\Client\Files\*.*"
;  RmDir "$INSTDIR\Client\Files"
;  Delete "$INSTDIR\Client\*.*"
  RmDir /r "$INSTDIR\Client"

  DeleteRegValue HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Run" "GameClass Client"

;  Delete "$INSTDIR\${PRODUCT_NAME}.url"
;  Delete "$INSTDIR\uninst.exe"
;  Delete "$INSTDIR\Scripts\*.*"
;  Delete "$INSTDIR\Traffic Inspector Plug-In\*.*"
;  Delete "$INSTDIR\UserGate Plug-In\*.*"

;  Delete  "$INSTDIR\*.*"

;  Delete "$SMPROGRAMS\GameClass3\Uninstall.lnk"
;  Delete "$SMPROGRAMS\GameClass3\Website.lnk"
;  Delete "$SMPROGRAMS\GameClass3\GameClass3.lnk"
;  Delete "$SMPROGRAMS\GameClass3\Website.lnk"
;  Delete "$SMPROGRAMS\GameClass3\Uninstall.lnk"
;  Delete "$SMPROGRAMS\GameClass3\Backup and Restore database.lnk"
;  Delete "$SMPROGRAMS\GameClass3\Traffic Inspector Plug-In Installation.lnk"
;  Delete "$SMPROGRAMS\GameClass3\UserGate 2.8 Plug-In.lnk"

  RMDir /r "$SMPROGRAMS\GameClass3"
  
;  RMDir "$INSTDIR\Scripts"
;  RMDir "$INSTDIR\Traffic Inspector Plug-In"
;  RMDir "$INSTDIR\UserGate Plug-In"
  RMDir /r "$INSTDIR"

  DeleteRegKey HKLM "SOFTWARE\GameClass3"

  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  SetAutoClose true
SectionEnd