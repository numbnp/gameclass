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




