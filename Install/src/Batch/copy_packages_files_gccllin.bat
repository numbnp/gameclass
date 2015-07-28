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
call create_directories.cmd

rem Инициализация обрабатки лог-файлы
del Install\Src\Logs\CopyPackagesFiles.log >nul 2>nul
Set error_check=

ech "  Копирование файлов для инсталляции "
rem Сложная конструкция с for чтобы не копировать файлы vssver.scc
copy Output\Debug\gccllin Install\Src\Packages\gccllin\gccllin >>Install\Src\Logs\CopyPackagesFiles.log| ech .
copy Docs\ClientLinux\readme.txt Install\Src\Packages\gccllin >>Install\Src\Logs\CopyPackagesFiles.log| ech .
copy Install\Src\Files\ClientLinux\*.* Install\Src\Packages\gccllin\gccllin\ >>Install\Src\Logs\CopyPackagesFiles.log| ech .
copy Install\Src\Files\SkinsLinux\*.* Install\Src\Packages\gccllin\gccllin\Skins >>Install\Src\Logs\CopyPackagesFiles.log| ech .
copy Install\Src\Files\Sounds\*.* Install\Src\Packages\gccllin\gccllin\Sounds >>Install\Src\Logs\CopyPackagesFiles.log| ech .

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
