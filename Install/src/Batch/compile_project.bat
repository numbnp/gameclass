@echo off
ech "  %DCCProjectName% ..."
cd %DCCProjectPath%
%DCC32% -B -$D- -$C- -$L- -D%DCCFlags% -I%DCCLib% -U%DCCLib% -GD -E%DCCReturnPath%\%DCCOutput% -N%DCCReturnPath%\%DCCDcu% %DCCProjectName% >%DCCReturnPath%\%DCCLogs%\%DCCProjectName%.log
cd %DCCReturnPath%
grep Error: %DCCLogs%\%DCCProjectName%.log >>%DCCLogs%\ErrorCheck.txt
grep Fatal: %DCCLogs%\%DCCProjectName%.log >>%DCCLogs%\ErrorCheck.txt
echo  OK
ech "  Compressing %DCCProjectName% ..."
cd %DCCProjectPath%
if exist "%DCCReturnPath%\%DCCOutput%\%DCCProjectName%.exe" upx.exe -q -9 %DCCReturnPath%\%DCCOutput%\%DCCProjectName%.exe > "%DCCReturnPath%\%DCCLogs%\compress_%DCCProjectName%.log"
if exist "%DCCReturnPath%\%DCCOutput%\%DCCProjectName%.dll" upx.exe -q -9 %DCCReturnPath%\%DCCOutput%\%DCCProjectName%.dll > "%DCCReturnPath%\%DCCLogs%\compress_%DCCProjectName%.log"
cd %DCCReturnPath%
grep Error: %DCCLogs%\%DCCProjectName%.log >>%DCCLogs%\ErrorCheck.txt
grep Fatal: %DCCLogs%\%DCCProjectName%.log >>%DCCLogs%\ErrorCheck.txt
echo  OK
