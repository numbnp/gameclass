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

if "-%APP_NAME%"=="-" goto parameter_needed
if "-%APP_FULLNAME%"=="-" goto parameter_needed
if "-%APP_VERSION%"=="-" goto parameter_needed
if "-%APP_MESSAGE%"=="-" goto parameter_needed

echo Собирается утилита %APP_NAME% (%APP_FULLNAME%) Версия %APP_VERSION%

rem Подготовка файлов для создания дистрибутива:
call copy_packages_files_tools.bat

rem Кодирование sql-файлов в sqp
call encode_sql_tools.bat

ech "Создание проекта gpr на основе tools.gpr ... "
Create_gpr_for_Tools.vbs  %APP_NAME% "%APP_FULLNAME%" %APP_VERSION% "%APP_MESSAGE%"
echo Ok


cd Install\Src\GI
"C:\Program Files\Ethalone\Ghost Installer\Bin\GIBuild.exe" %APP_NAME%.gpr
cd ..\..\..

pause

:parameter_needed
echo Необходимо правильно установить переменные APP_NAME, APP_FULLNAME, APP_VERSION, APP_MESSAGE