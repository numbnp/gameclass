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

rem Удаляем старые файлы
del Install\src\Packages\DataBase\*.sqp 2>nul
del Install\src\Packages\DataBase\*.sql 2>nul

rem Кодирование sql-файлов в sqp
ech "Кодирование sql-файлов в sqp "
rem for /r DataBase\SQLCode %%i in (GCBase*.sql) do Output\Release\GCOsql.exe encode "%%~fi" "Install\src\Packages\DataBase\%%~ni.sqp" | ech .
rem for /r DataBase\SQLCode %%i in (GCSync*.sql) do Output\Release\GCOsql.exe encode "%%~fi" "Install\src\Packages\DataBase\%%~ni.sqp" | ech .
rem for /r DataBase\SQLCode %%i in (mssql_pm*.sql) do Output\Release\GCOsql.exe encode "%%~fi" "Install\src\Packages\DataBase\%%~ni.sqp" | ech .

for /r DataBase\SQLCode %%i in (GCBase*.sql) do copy "%%~fi" "Install\src\Packages\DataBase\%%~ni.sql" | ech .
for /r DataBase\SQLCode %%i in (GCSync*.sql) do copy "%%~fi" "Install\src\Packages\DataBase\%%~ni.sql" | ech .
for /r DataBase\SQLCode %%i in (mssql_pm*.sql) do copy "%%~fi" "Install\src\Packages\DataBase\%%~ni.sql" | ech .


echo  OK
