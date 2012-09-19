
; HM NIS Edit Wizard helper defines
!define PRODUCT_NAME "GC3 Viewer"
!define PRODUCT_VERSION "1.0.9"
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
OutFile "c:\Projects\Free\Output\Setup\gc3viewer.${PRODUCT_VERSION}.exe"
InstallDir "$PROGRAMFILES\GameClass3\Viewer"
ShowInstDetails show
ShowUnInstDetails show

InstType "Установка модуля просмотра состояния клуба"

Section "Модуль GC Viewer" SEC01
  SectionIn 1

; Заливаем файлы 
  SetOutPath "$INSTDIR"
  SetOverwrite on
  File "c:\Projects\Free\Install\src\Packages\GCViewer\GCViewer.exe"

  SetOutPath "$INSTDIR"
  SetOverwrite on
  File "c:\Projects\Free\Install\src\Packages\GCViewer\winhkg.dll"


; Делаем нужные записи в реестре
  WriteRegStr HKLM "SOFTWARE\GameClass3\Viewer" "InstallDirectory" "$INSTDIR\Viewer"
  WriteRegStr HKLM "SOFTWARE\GameClass3\Viewer" "CurrentVersion" "${PRODUCT_VERSION}"
  
 
; Делаем ярлык
  CreateShortCut "$SMPROGRAMS\GameClass3\Модуль GC3Viewer.lnk" "$INSTDIR\GCViewer.exe"

  
SectionEnd


LangString DESC_PROG ${LANG_RUSSIAN} "Основная часть модуля"

!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
!insertmacro MUI_DESCRIPTION_TEXT ${SEC01} $(DESC_PROG)
!insertmacro MUI_FUNCTION_DESCRIPTION_END

Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
SectionEnd



Section Uninstall

  RmDir /r "$INSTDIR"

  DeleteRegKey HKLM "SOFTWARE\GameClass3\Viewer"

  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  SetAutoClose true
SectionEnd