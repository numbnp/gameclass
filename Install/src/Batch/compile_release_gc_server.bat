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

call init_compile.bat

rem Компиляция
set DCCFlags=GC3SERVER,ASPROTECT
set DCCProjectPath=Server
set DCCProjectName=GCServer.dpr
set DCCPType=exe
set DCCReturnPath=..
call Install\Src\Batch\compile_project

set DCCFlags=ASPROTECT
set DCCProjectPath=Security\OSql
set DCCProjectName=GCOsql
set DCCPType=exe
set DCCReturnPath=..\..
call Install\Src\Batch\compile_project.bat

set DCCFlags=ASPROTECT
set DCCProjectPath=BackupRestore
set DCCProjectName=GCBackupRestore
set DCCPType=exe
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
