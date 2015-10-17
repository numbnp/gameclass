rem @echo on
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
call create_directories.cmd

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
rem Client
copy Output\Release\gccl.exe Install\Src\Packages\Client >>Install\Src\Logs\CopyPackagesFiles.log| ech .
copy Output\Release\gcclsrv.exe Install\Src\Packages\Client >>Install\Src\Logs\CopyPackagesFiles.log| ech .
copy Output\Release\ProcUtils.dll Install\Src\Packages\Client >>Install\Src\Logs\CopyPackagesFiles.log| ech .
copy Output\Release\winhkg.dll Install\Src\Packages\Client >>Install\Src\Logs\CopyPackagesFiles.log| ech .
xcopy Install\Src\Files\Client\*.* Install\Src\Packages\Client /E /Y>>Install\Src\Logs\CopyPackagesFiles.log| ech .
xcopy Install\Src\Files\Skins\*.* Install\Src\Packages\Client\Skins\ /E /Y >>Install\Src\Logs\CopyPackagesFiles.log| ech .
rem copy Install\Src\Files\Skins\full\*.* Install\Src\Packages\Client\Skins\full\ >>Install\Src\Logs\CopyPackagesFiles.log| ech .
rem copy Install\Src\Files\Skins\new\*.* Install\Src\Packages\Client\Skins\new\ >>Install\Src\Logs\CopyPackagesFiles.log| ech .

copy Install\Src\Files\Sounds\*.* Install\Src\Packages\Client\Sounds >>Install\Src\Logs\CopyPackagesFiles.log| ech .

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
