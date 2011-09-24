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

set APP_VERSION=1.0.7
Install\src\Batch\gcviewer_replace_versions.vbs "%APP_VERSION%"
echo Собирается версия %APP_VERSION%


rem Компиляция exe-файлов
call compile_release_gcviewer.bat

rem Подготовка файлов для создания дистрибутива:
call copy_packages_files_gcviewer.bat

cd Install\Src\GI
"C:\Program Files\Ethalone\Ghost Installer\Bin\GIBuild.exe" gcviewer.gpr
cd ..\..\..
