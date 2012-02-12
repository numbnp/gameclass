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

set BASE_VERSION=3.85.2.12
set APP_VERSION=3.85.2.12 Free
set CLIENT_VERSION=3.85.2.12
set SQL_SCRIPT_VERSION=3853

rem Install\src\Batch\gc_replace_versions.vbs "%BASE_VERSION%" "%APP_VERSION%"
echo Собирается версия %APP_VERSION%
rem ToDo need compile GameClass.chm

rem Компиляция exe-файлов
call compile_release_gc.bat

rem Пересборка Russion.lng
echo Пересборка Russion.lng
copy Docs\Russian.lng Output\Release\
Tools\LngRecoder\LngRecoder.exe Output\Release\Russian.lng Server\GCServer.drc

rem Подготовка файлов для создания дистрибутива:
call copy_packages_files.bat

rem Кодирование sql-файлов в sqp
call encode_sql.bat

rem cd Install\Src\INS
rem "c:\Program Files\Inno Setup 5\ISCC.exe" Client.iss
rem "c:\Program Files\Inno Setup 5\ISCC.exe" All.iss
rem cd ..\..\..

rem cd Install\Src\GI
rem "C:\Program Files\Ethalone\Ghost Installer\Bin\GIBuild.exe" gcsetup.gpr
rem cd ..\..\..

cd Install\Src\NSIS
"c:\Program Files\NSIS\makensis.exe" All.nsi

