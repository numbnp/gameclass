rem @echo off
rem -------------------- Начало шапки ------------------------------------
rem ВЫход в корневую директорию проета
for /l %%i in (1,1,8) do if not exist rootdir cd ..
rem Начальный рабочий каталог для всех пакетных файлов - корневая 
rem директория проекта (Current\ или 3.XX\)
rem Добаволение в путь поиска Install\Src\Batch
if not -%GCMakePath%==- goto PathAlreadySet
for /d %%i in (Install\Src\Batch\) do set GCMakePath=%%~dpi
set Path=%GCMakePath%;%Path%
:PathAlreadySet
rem -------------------- Конец шапки ------------------------------------
echo Подготовка файлов для создания дистрибутива:
ech "  Удаление старых файлов ..."
del /s /q Install\Src\Packages\*.* >nul 2>nul
echo  OK
ech "  Создание структуры каталогов ..."
if not exist Install\Src\Packages\Presetup md Install\Src\Packages\Presetup| ech .
if not exist Install\Src\Packages\Database md Install\Src\Packages\Database| ech .
if not exist Install\Src\Packages\Client md Install\Src\Packages\Client| ech .
if not exist Install\Src\Packages\Client\Skins md Install\Src\Packages\Client\Skins| ech .
if not exist Install\Src\Packages\Client\Sounds md Install\Src\Packages\Client\Sounds| ech .
if not exist Install\Src\Packages\Client\Files md Install\Src\Packages\Client\Files| ech .
if not exist Install\Src\Packages\Server md Install\Src\Packages\Server| ech .
if not exist Install\Src\Packages\Server\Scripts md Install\Src\Packages\Server\Scripts| ech .
if not exist "Install\Src\Packages\Server\Traffic Inspector Plug-In" md "Install\Src\Packages\Server\Traffic Inspector Plug-In"| ech .
if not exist "Install\Src\Packages\Server\UserGate Plug-In" md "Install\Src\Packages\Server\UserGate Plug-In"| ech .
if not exist Install\Src\Packages\Presetup md Install\Src\Packages\Presetup| ech .
echo  OK

rem Инициализация обрабатки лог-файлы
del Install\Src\Logs\CopyPackagesFiles.log >nul 2>nul
Set error_check=

ech "  Копирование файлов для инсталляции "
rem Сложная конструкция с for чтобы не копировать файлы vssver.scc устарела
rem for /r Install\Src\Files\Presetup %%i in (*.*) do if not -%%~xi==-.scc copy "%%~fi" Install\Src\Packages\Presetup >>Install\Src\Logs\CopyPackagesFiles.log| ech .
rem Сложеная конструкция с for /f не прокатила
rem for /f "usebackq tokens=*" %%i in (`dir /b DataBase\Reports\*.xml`) do copy "%%~fi" Install\Src\Packages\DataBase >>Install\Src\Logs\CopyPackagesFiles.log| ech .
rem Presetup
copy Install\Src\Files\Presetup\*.* Install\Src\Packages\Presetup >>Install\Src\Logs\CopyPackagesFiles.log| ech .
copy Docs\License.txt Install\Src\Packages\Presetup >>Install\Src\Logs\CopyPackagesFiles.log| ech .
rem Database
copy DataBase\dbconfig.xml Install\Src\Packages\DataBase >>Install\Src\Logs\CopyPackagesFiles.log| ech .
copy DataBase\Reports\*.xml Install\Src\Packages\DataBase >>Install\Src\Logs\CopyPackagesFiles.log| ech .
copy Output\Release\GCosql.exe Install\Src\Packages\DataBase >>Install\Src\Logs\CopyPackagesFiles.log| ech .
rem Client
copy Output\Release\gccl.exe Install\Src\Packages\Client >>Install\Src\Logs\CopyPackagesFiles.log| ech .
copy Output\Release\gcclsrv.exe Install\Src\Packages\Client >>Install\Src\Logs\CopyPackagesFiles.log| ech .
copy Output\Release\ProcUtils.dll Install\Src\Packages\Client >>Install\Src\Logs\CopyPackagesFiles.log| ech .
rem copy Tools\Packer\Packer.exe Install\Src\Packages\Client >>Install\Src\Logs\CopyPackagesFiles.log| ech .
rem copy Tools\Packer\DelZip179.dll Install\Src\Packages\Client >>Install\Src\Logs\CopyPackagesFiles.log| ech .
rem Tools\Packer\Packer.exe a Install\Src\Packages\Client\gcclsrv.zip Output\Release\gcclsrv.exe antivir >>Install\Src\Logs\CopyPackagesFiles.log| ech .
copy Output\Release\winhkg.dll Install\Src\Packages\Client >>Install\Src\Logs\CopyPackagesFiles.log| ech .
copy Install\Src\Files\Client\*.* Install\Src\Packages\Client >>Install\Src\Logs\CopyPackagesFiles.log| ech .
copy Install\Src\Files\Skins\*.* Install\Src\Packages\Client\Skins >>Install\Src\Logs\CopyPackagesFiles.log| ech .
copy Install\Src\Files\Skins\full\*.* Install\Src\Packages\Client\Skins\full >>Install\Src\Logs\CopyPackagesFiles.log| ech .
copy Install\Src\Files\Sounds\*.* Install\Src\Packages\Client\Sounds >>Install\Src\Logs\CopyPackagesFiles.log| ech .
rem Server
copy Output\Release\GCServer.exe Install\Src\Packages\Server >>Install\Src\Logs\CopyPackagesFiles.log| ech .
copy Output\Release\GCKern.dll Install\Src\Packages\Server >>Install\Src\Logs\CopyPackagesFiles.log| ech .
copy Output\Release\GCBackupRestore.exe Install\Src\Packages\Server >>Install\Src\Logs\CopyPackagesFiles.log| ech .
copy Output\Debug\GCServer.lng Install\Src\Packages\Server >>Install\Src\Logs\CopyPackagesFiles.log| ech .
copy Output\Release\Russian.lng Install\Src\Packages\Server >>Install\Src\Logs\CopyPackagesFiles.log| ech .
copy Docs\Help\GameClass.chm Install\Src\Packages\Server\GCServerRus.chm >>Install\Src\Logs\CopyPackagesFiles.log| ech .
copy Docs\Help\GameClass.chm Install\Src\Packages\Server\GCServerEng.chm >>Install\Src\Logs\CopyPackagesFiles.log| ech .
copy Install\Src\Files\Server\*.* Install\Src\Packages\Server >>Install\Src\Logs\CopyPackagesFiles.log| ech .
copy Install\Src\Files\Scripts\*.* Install\Src\Packages\Server\Scripts >>Install\Src\Logs\CopyPackagesFiles.log| ech .
copy Docs\WhatsNew.txt Install\Src\Packages\Server >>Install\Src\Logs\CopyPackagesFiles.log| ech .
copy Docs\readme.txt Install\Src\Packages\Server >>Install\Src\Logs\CopyPackagesFiles.log| ech .
copy Output\Setup\gcti.2.0.5.exe "Install\Src\Packages\Server\Traffic Inspector Plug-In" >>Install\Src\Logs\CopyPackagesFiles.log| ech .
copy "Install\Src\Files\UserGate Plug-In"\*.* "Install\Src\Packages\Server\UserGate Plug-In" >>Install\Src\Logs\CopyPackagesFiles.log| ech .

:lab

find "Системе не удается найти указанный путь" <Install\Src\Logs\CopyPackagesFiles.log >Install\Src\Logs\CopyPackagesFiles.txt
find "System cannot find the path specified" <Install\Src\Logs\CopyPackagesFiles.log >>Install\Src\Logs\CopyPackagesFiles.txt
for /f %%i in (Install\Src\Logs\CopyPackagesFiles.txt) DO @SET error_check=%%i 
if "%error_check%"=="" goto no_error
echo  Ошибка
pause
more Install\Src\Logs\CopyPackagesFiles.txt
pause
exit
:no_error
echo  OK
del Install\Src\Logs\CopyPackagesFiles.txt >nul 2>nul
del Install\Src\Logs\CopyPackagesFiles.log >nul 2>nul
