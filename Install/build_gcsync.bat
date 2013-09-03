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

set Version=1.0.5
echo Собирается версия %VERSION%
rem ToDo need compile GameClass.chm

rem Компиляция exe-файлов
call compile_release_gcsync.bat

rem Подготовка файлов для создания дистрибутива:
call copy_packages_files_gcsync.bat

rem Кодирование sql-файлов в sqp
call encode_sql_gcsync.bat


cd Install\Src\NSIS
"c:\Program Files\NSIS\makensis.exe" gcsync.nsi
cd ..\..\..
