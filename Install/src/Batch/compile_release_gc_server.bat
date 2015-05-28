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

echo Компилируются release-версии:

set DelphiPath=c:\Program Files (x86)\Embarcadero\Studio\15.0
rem set DCCLib="%DelphiPath%\Lib\Debug";"%DelphiPath%\lib\Win32\release";"C:\Users\max\Documents\RAD Studio\11.0\Imports";"%DelphiPath%\Imports";"C:\Users\Public\Documents\RAD Studio\11.0\Dcp";"%DelphiPath%\include";"C:\Program Files\FastReports\LibD18";"C:\Program Files\Raize\CS5\Lib\RS-XE4\Win32";"%DelphiPath%\Components\EhLib\Lib\Win32\Release";C:\Project\Imports\y2kControls\Current\Product\Src\dcu;C:\Project\Imports\Win32API;c:\Project\Imports\Rxlib\units;C:\Project\Imports\ExtControll;C:\Project\Imports\y2kControls\Current\Product\Src;c:\Project\Imports\VirtualTreeView\Source;c:\Project\Imports\SynEdit\Source;c:\Project\Imports\FastMM;c:\Project\Imports\dcef3-4888ed525e22\packages;"c:\Program Files\madCollection\madBasic\BDS11\win32";c:\Project\Imports\dcef3-4888ed525e22\packages\Win32\Debug;c:\Project\Imports\Win2KTray;"C:\Program Files\madCollection\madBasic\BDS11\win32";"C:\Program Files\madCollection\madDisAsm\BDS11\win32";"C:\Program Files\madCollection\madExcept\BDS11\win32";"C:\Program Files\madCollection\madExcept\..\Plugins\win32";"C:\Program Files\madCollection\madKernel\BDS11\win32";"C:\Program Files\madCollection\madSecurity\BDS11\win32";"C:\Program Files\madCollection\madShell\BDS11\win32";c:\Project\Imports
set DCCLib="%DelphiPath%\lib\Win32\release;%DelphiPath%\Imports;%DelphiPath%\Dcp;%DelphiPath%\include;C:\Program Files (x86)\FastReports\LibD21;C:\Program Files (x86)\Raize\CS5\Lib\RS-XE7\Win32;K:\DelphiComponents\dcef3\src;k:\DelphiComponents\FastMM\;K:\DelphiComponents\Ehlibv7\RADStudioXE7;K:\DelphiComponents\ExtControll;K:\DelphiComponents\FastMM;K:\DelphiComponents\rxlib\units;K:\DelphiComponents\SynEdit\Source;K:\DelphiComponents\VirtualTreeviewV5.3.0\Source;K:\DelphiComponents\y2kControls\Current\Product\Src"
set DCCLogs=Install\Src\Logs
set DCCOutput=Output\Release
set DCCDcu=Output\Dcu\Release
set DCC32="%DelphiPath%\bin\dcc32.exe"

rem Удаляем exe и dcu
del %DCCOutput%\*.* /q 2>nul
del %DCCDcu%\*.* /q 2>nul
rem Инициализация обрабатки лог-файлы
del %DCCLogs%\ErrorCheck.txt 2>nul
Set error_check=

rem Компиляция
set DCCFlags=GC3SERVER,ASPROTECT
set DCCProjectPath=Server
set DCCProjectName=GCServer.dpr
set DCCReturnPath=..
call Install\Src\Batch\compile_project

set DCCFlags=ASPROTECT
set DCCProjectPath=Security\OSql
set DCCProjectName=GCOsql
set DCCReturnPath=..\..
call Install\Src\Batch\compile_project.bat

set DCCFlags=ASPROTECT
set DCCProjectPath=BackupRestore
set DCCProjectName=GCBackupRestore
set DCCReturnPath=..
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
