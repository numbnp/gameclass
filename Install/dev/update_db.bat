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
del /q Output\Debug\sql\*.sql 2>nul
del /q Output\Debug\sql\*.log 2>nul
del /q Output\Debug\sql\*.xml 2>nul


for /r DataBase\SQLCode %%i in (GCBase*.sql) do copy "%%~fi" "Output\Debug\sql\%%~ni.sql" | ech .
for /r DataBase\SQLCode %%i in (GCSync*.sql) do copy "%%~fi" "Output\Debug\sql\%%~ni.sql" | ech .
for /r DataBase\Reports %%i in (*.xml) do copy "%%~fi" "Output\Debug\sql\%%~ni.xml" | ech .
for /r DataBase\SQLCode %%i in (mssql_pm*.sql) do copy "%%~fi" "Output\Debug\sql\%%~ni.sql" | ech .


rem Database
copy DataBase\dbconfig.xml Output\Debug\sql >>Output\Debug\sql\sql_to_dev.log| ech .
rem copy Output\Release\GCosql.exe Output\Debug\sql >>Output\Debug\sql\sql_to_dev.log| ech .

cd Output\Debug\sql
GCosql.exe updatedatabase dbconfig.xml
for /l %%i in (1,1,8) do if not exist rootdir cd ..

echo  OK
