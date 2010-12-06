@echo off
set Version=3.84
echo Собирается версия %VERSION%
rem ToDo need compile GameClass.chm
del ..\GCServer\GCServer.exe 2>nul
del ..\GCGuard\GCGuard.exe 2>nul
del ..\GCClient\gccl.exe 2>nul
call del_dcu.bat

rem Компиляция
set DelphiPath=C:\Program Files\Borland\Delphi7
set Lib="%DelphiPath%\Lib;%DelphiPath%\Bin;%DelphiPath%\Imports;%DelphiPath%\Projects\Bpl;%DelphiPath%\Rave5\Lib;C:\Projects\Imports\Delphi7\EhLibRus\Common;C:\Projects\Imports\Delphi7\RxLibrary 2.75 d7\Units;C:\Projects\Imports\Delphi7\synedit\Packages;C:\Projects\Imports\Delphi7\Win2KTray;C:\Projects\Imports\Delphi7\y2kControls\Current\Product\Src\dcu;C:\Projects\Imports\Delphi7\synedit\Source;C:\Projects\Imports\Win32API;C:\Projects\Imports\Delphi7\ASP;C:\Projects\Imports\IE;C:\Projects\Imports\Delphi7\y2kControls\Current\Product\Src"
set Flags=GC3SERVER,DEBUG
cd ..\GCServer
"C:\Program Files\Borland\Delphi7\Bin\dcc32" -B -$D+ -$C+ -$L+ -D%Flags% -U%Lib% GCServer>..\GCInstall\GCServer_build.log
cd ..\GCInstall
set Flags=GCCL,DEBUG
cd ..\GCClient
"C:\Program Files\Borland\Delphi7\Bin\dcc32" -B -$D+ -$C+ -$L+ -D%Flags% -U%Lib% gccl>..\GCInstall\gccl_build.log  
cd ..\GCInstall
set Flags=GCCLSRV,DEBUG
cd ..\GCClientService
"C:\Program Files\Borland\Delphi7\Bin\dcc32" -B -$D+ -$C+ -$L+ -D%Flags% -U%Lib% gcclsrv>..\GCInstall\gcclsrv_build.log  
cd ..\GCInstall
set Flags=GCGUARD,DEBUG
cd ..\GCGuard
"C:\Program Files\Borland\Delphi7\Bin\dcc32" -B -$D+ -$C+ -$L+ -D%Flags% -U%Lib% GCGuard>..\GCInstall\GCGuard_build.log  
cd ..\GCInstall

rem Обрабатываем лог-файлы
del ErrorCheck.txt
Set error_check=
grep Fatal GCServer_build.log >>ErrorCheck.txt
grep Fatal gccl_build.log >>ErrorCheck.txt
grep Fatal gcclsrv_build.log >>ErrorCheck.txt
for /f %%i in (ErrorCheck.txt) DO @SET error_check=%%i
if "%error_check%"=="" goto no_error
echo Ошибка компиляции !
more ErrorCheck.txt
pause
exit
:no_error
echo Копмиляция завершена успешно
del ErrorCheck.txt >nul

