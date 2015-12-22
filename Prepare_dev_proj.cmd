rem @echo off
rem -------------------- Начало шапки ------------------------------------
rem ВЫход в корневую директорию проета
for /l %%i in (1,1,8) do if not exist rootdir cd ..
rem -------------------- Конец шапки ------------------------------------

mkdir Install\src\Logs
mkdir Output\dcu\Release
mkdir Output\Release
mkdir Output\Setup
mkdir Output\Debug\server

copy Install\Src\Files\Server\*.* Output\Debug\server

rem Удаляем старые файлы
del Install\src\Packages\DataBase\*.sqp 2>nul
del Install\src\Packages\DataBase\*.sql 2>nul

rem Кодирование sql-файлов в sqp
ech "Кодирование sql-файлов в sqp "

for /r DataBase\SQLCode %%i in (GCBase*.sql) do copy "%%~fi" "Output\Debug\sql\%%~ni.sql" 
for /r DataBase\SQLCode %%i in (GCSync*.sql) do copy "%%~fi" "Output\Debug\sql\%%~ni.sql" 
for /r DataBase\SQLCode %%i in (mssql_pm*.sql) do copy "%%~fi" "Output\Debug\sql\%%~ni.sql" 
copy "DataBase\dbconfig.xml" "Output\Debug\sql\" 



