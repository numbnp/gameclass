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
call Install\src\Batch\compile_osql.bat

set APP_NAME=DeleteUnregisteredUsers
set APP_FULLNAME%=Утилита удаления незарегистрированных в GameClass 3 пользователей
set APP_VERSION%=2.2
set APP_MESSAGE%=Удаление незарегистрированных в GameClass 3 пользователей

call Install\build_tools.bat