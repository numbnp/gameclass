@echo off
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

echo Компилируются release-версии:

set DelphiPath=C:\Program Files\Borland\Delphi7
set DCCLib="%DelphiPath%\Lib;%DelphiPath%\Bin;%DelphiPath%\Imports;%DelphiPath%\Projects\Bpl;%DelphiPath%\Rave5\Lib;C:\Projects\Imports\Delphi7\EhLibRus\Common;C:\Projects\Imports\Delphi7\EhLibRus\DataService;C:\Projects\Imports\Delphi7\RxLibrary 2.75 d7\Units;C:\Projects\Imports\Delphi7\synedit\Packages;C:\Projects\Imports\Delphi7\Win2KTray;C:\Projects\Imports\Delphi7\y2kControls\Current\Product\Src\dcu;C:\Projects\Imports\Delphi7\synedit\Source;C:\Projects\Imports\Win32API;C:\Projects\Imports\Delphi7\ASP;C:\Projects\Imports\IE;C:\Projects\Imports\Delphi7\y2kControls\Current\Product\Src;C:\Projects\Imports\Delphi7;C:\Program Files\Balmsoft Polyglot\Delphi 7\Lib;C:\Projects\Imports;C:\Projects\Imports\Virtual Treeview\Source;C:\Projects\Imports\Delphi7\DBImage;c:\Projects\webkitdelphi\src"
set DCCLogs=Install\Src\Logs
set DCCOutput=Output\Release
set DCCDcu=Output\Dcu\Release
set DCC32="C:\Program Files\Borland\Delphi7\Bin\dcc32"

rem Удаляем exe и dcu
del %DCCOutput%\*.* /q 2>nul
del %DCCDcu%\*.* /q 2>nul
rem Инициализация обрабатки лог-файлы
del %DCCLogs%\ErrorCheck.txt 2>nul
Set error_check=

rem Компиляция
set DCCFlags=GC3SERVER,ASPROTECT
set DCCProjectPath=Server
set DCCProjectName=GCServer
set DCCReturnPath=..
call Install\Src\Batch\compile_project.bat
set DCCFlags=GCCL,ASPROTECT
set DCCProjectPath=Client
set DCCProjectName=gccl
call Install\Src\Batch\compile_project.bat

set DCCFlags=GCCLSRV,ASPROTECT
set DCCProjectPath=ClientService
set DCCProjectName=gcclsrv
call Install\Src\Batch\compile_project.bat

set DCCFlags=ASPROTECT
set DCCProjectPath=Security\OSql
set DCCProjectName=GCOsql
set DCCReturnPath=..\..
call Install\Src\Batch\compile_project.bat

set DCCFlags=ASPROTECT
set DCCProjectPath=Parts\winhkg
set DCCProjectName=winhkg
set DCCReturnPath=..\..
call Install\Src\Batch\compile_project.bat

set DCCFlags=ASPROTECT
set DCCProjectPath=BackupRestore
set DCCProjectName=GCBackupRestore
set DCCReturnPath=..
call Install\Src\Batch\compile_project.bat

set DCCFlags=ASPROTECT
set DCCProjectPath=Parts\ProcessSupervisor
set DCCProjectName=ProcUtils
set DCCReturnPath=..\..
call Install\Src\Batch\compile_project.bat
rem Еще компиляция модулей

for /f %%i in (%DCCLogs%\ErrorCheck.txt) DO @SET error_check=%%i
if "%error_check%"=="" goto no_error
echo Ошибка компиляции !
pause
more %DCCLogs%\ErrorCheck.txt
pause
exit
:no_error
echo Копмиляция завершена успешно.
del %DCCLogs%\ErrorCheck.txt >nul
