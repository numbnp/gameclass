echo Подготовка файлов:
ech "  Удаление старых файлов ..."
del /s /q Install\Src\Packages\*.* >nul 2>nul
echo  OK
ech "  Создание структуры каталогов ..."
if not exist "Install\Src\Packages\Presetup" md Install\Src\Packages\Presetup| ech .
if not exist "Install\Src\Packages\Database" md Install\Src\Packages\Database| ech .

if not exist "Install\Src\Packages\Client" md Install\Src\Packages\Client| ech .
if not exist "Install\Src\Packages\Client\Skins" md Install\Src\Packages\Client\Skins| ech .
if not exist "Install\Src\Packages\Client\Sounds" md Install\Src\Packages\Client\Sounds| ech .
if not exist "Install\Src\Packages\Client\Files" md Install\Src\Packages\Client\Files| ech .

if not exist "Install\Src\Packages\Server" md Install\Src\Packages\Server| ech .
if not exist "Install\Src\Packages\Server\Scripts" md Install\Src\Packages\Server\Scripts| ech .
if not exist "Install\Src\Packages\Server\Traffic Inspector Plug-In" md "Install\Src\Packages\Server\Traffic Inspector Plug-In"| ech .
if not exist "Install\Src\Packages\Server\UserGate Plug-In" md "Install\Src\Packages\Server\UserGate Plug-In"| ech .

if not exist "Install\Src\Packages\Tools" md "Install\Src\Packages\Tools"| ech .
if not exist "Install\Src\Packages\GCViewer" md "Install\Src\Packages\GCViewer"| ech .
if not exist "Install\Src\Packages\GCUG" md "Install\Src\Packages\GCUG"| ech .
if not exist "Install\Src\Packages\GCTI" md "Install\Src\Packages\GCTI"| ech .
if not exist "Install\Src\Packages\GCSync" md "Install\Src\Packages\GCSync"| ech .

if not exist "Install\src\Logs" md "Install\src\Logs"| ech .

if not exist "Output\Debug\server" md "Output\Debug\server"| ech .
if not exist "Output\dcu\Release" md "Output\dcu\Release"| ech .
if not exist "Output\Release" md "Output\Release"| ech .
if not exist "Output\Setup" md "Output\Setup"| ech .

echo  OK

exit /bit /b