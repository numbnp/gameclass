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
set PRootDir=k:\Projects\gameclass
rem -------------------- Конец шапки ------------------------------------

set BASE_VERSION=3.85.7
set APP_VERSION=3.85.7 Alpha
set CLIENT_VERSION=3.85.7
set SQL_SCRIPT_VERSION=3857

rem Install\src\Batch\gc_replace_versions.vbs "%BASE_VERSION%" "%APP_VERSION%"
echo Собирается версия %APP_VERSION%
rem ToDo need compile GameClass.chm

rem Компиляция exe-файлов
call compile_release_gc_client.bat


rem Подготовка файлов для создания дистрибутива:
call copy_packages_files_client.bat
cd Install\Src\NSIS
"c:\Program Files (x86)\NSIS\makensis.exe" gc_client.nsi

pause