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

set Version=3.85.Beta.8

echo Собирается версия %VERSION%
rem ToDo need compile GameClass.chm

rem Компиляция exe-файлов
rem call compile_release_gcti.bat


rem Подготовка файлов для создания дистрибутива:
call copy_packages_files_gccllin.bat

ech "  Создание архива tar.gz ..."
set Path="C:\Program Files\UnxUtils\";%GCMakePath%;%Path%
cd Install/src/Packages/gccllin
tar -cvf ..\..\..\..\Output\Setup\gccllin.tar gccllin/libborqt-6.9-qt2.3.so gccllin/Skins gccllin/Sounds readme.txt| ech .
tar --mode=777 -rf ..\..\..\..\Output\Setup\gccllin.tar gccllin/install.sh gccllin/gccllin gccllin/bg_exec | ech .
cd ..\..\..\..\Output\Setup\
gzip -f gccllin.tar| ech .
rename gccllin.tar.gz gccllin.%VERSION%.tar.gz
echo  OK
