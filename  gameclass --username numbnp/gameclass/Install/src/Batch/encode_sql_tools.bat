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

if -%APP_NAME%==- goto parameter_needed

rem Удаляем старые файлы
del Install\src\Packages\Tools\*.sqp 2>nul

rem Кодирование sql-файлов в sqp
ech "Кодирование sql-файлов в sqp ..."
Output\Release\GCOsql.exe encode "DataBase\SQLCode\Tools\%APP_NAME%.sql" "Install\src\Packages\Tools\%APP_NAME%.sqp" | ech .
echo  OK
goto no_error

:parameter_needed
echo Введите папку\название утилиты в качестве параметра

:no_error