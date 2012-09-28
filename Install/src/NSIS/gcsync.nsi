
; HM NIS Edit Wizard helper defines
!define PRODUCT_NAME "GC3 Sync"
!define PRODUCT_VERSION "1.0.3"
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
OutFile "c:\Projects\Free\Output\Setup\gc3sync.${PRODUCT_VERSION}.exe"
InstallDir "$PROGRAMFILES\GameClass3\Sync"
ShowInstDetails show
ShowUnInstDetails show

InstType "Установка модуля синхронизации"

Section "Модуль синхронизации" SEC01
  SectionIn 1

; На случай обновления останавливаем клиент и удаляем службу
  ExecWait 'net stop srvGCSync'
  ExecWait '$INSTDIR\gcsyncsrv.exe -uninstall -silent'

; Заливаем файлы клиента
  SetOutPath "$INSTDIR"
  SetOverwrite on
  File "c:\Projects\Free\Install\src\Packages\GCSync\GCSyncCfg.exe"

  SetOutPath "$INSTDIR"
  SetOverwrite on
  File "c:\Projects\Free\Install\src\Packages\GCSync\GCSyncSrv.exe"



; Делаем нужные записи в реестре
  WriteRegStr HKLM "SOFTWARE\GameClass\GCSync" "InstallDirectory" "$INSTDIR\GCSync"
  WriteRegStr HKLM "SOFTWARE\GameClass\GCSync" "CurrentVersion" "${PRODUCT_VERSION}"
  
 
; Регистрируем службу и запускаем ее
  ExecWait '$INSTDIR\gcsyncsrv.exe -install -silent'
  ExecWait 'net start srvGCSync'

  CreateShortCut "$SMPROGRAMS\GameClass3\Настройка GC3Sync.lnk" "$INSTDIR\GCSyncCfg.exe"

  
SectionEnd

Section "Обновление БД" SEC02
  SectionIn 1
  SetOutPath "$INSTDIR\SQL"
  SetOverwrite ifnewer
  File "c:\Projects\Free\Install\src\Packages\GCSync\*.sqp"
  SetOutPath "$INSTDIR\SQL"
  SetOverwrite ifnewer
  File "c:\Projects\Free\Install\src\Packages\GCSync\*.xml"
  SetOutPath "$INSTDIR\SQL"
  SetOverwrite ifnewer
  File "c:\Projects\Free\Install\src\Packages\GCSync\GCosql.exe"

  ExecWait "$INSTDIR\SQL\GCosql.exe updatedatabase dbsync.xml"

;  Delete "$INSTDIR\SQL\*.*"
  RMDir /r "$INSTDIR\SQL"

SectionEnd



LangString DESC_PROG ${LANG_RUSSIAN} "Основная часть модуля"
LangString DESC_UPDATEDB ${LANG_RUSSIAN} "Обновление базы данных"

!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
!insertmacro MUI_DESCRIPTION_TEXT ${SEC01} $(DESC_PROG)
!insertmacro MUI_DESCRIPTION_TEXT ${SEC02} $(DESC_UPDATEDB)
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

  ExecWait 'net stop srvGCSync'
  ExecWait '$INSTDIR\gcsyncsrv.exe -uninstall -silent'

;  Delete "$INSTDIR\Client\Skins\*.*"
;  RmDir "$INSTDIR\Client\Skins"
;  Delete "$INSTDIR\Client\Sounds\*.*"
;  RmDir "$INSTDIR\Client\Sounds"
;  Delete "$INSTDIR\Client\Files\*.*"
;  RmDir "$INSTDIR\Client\Files"
;  Delete "$INSTDIR\Client\*.*"
  RmDir /r "$INSTDIR"



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

  
;  RMDir "$INSTDIR\Scripts"
;  RMDir "$INSTDIR\Traffic Inspector Plug-In"
;  RMDir "$INSTDIR\UserGate Plug-In"

  DeleteRegKey HKLM "SOFTWARE\GameClass\GCSync"

  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  SetAutoClose true
SectionEnd