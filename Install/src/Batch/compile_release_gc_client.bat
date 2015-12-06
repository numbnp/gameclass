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
set DCCFlags=GCCL,ASPROTECT
set DCCProjectPath=Client
set DCCProjectName=gccl
set DCCPType=exe
set DCCReturnPath=..
call Install\Src\Batch\compile_project.bat

set DCCFlags=GCCLSRV,ASPROTECT
set DCCProjectPath=ClientService
set DCCProjectName=gcclsrv
set DCCPType=exe
set DCCReturnPath=..
call Install\Src\Batch\compile_project.bat

set DCCFlags=WINHKG
set DCCProjectPath=Parts\Winhkg
set DCCProjectName=winhkg
set DCCPType=dll
set DCCReturnPath=..\..
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
