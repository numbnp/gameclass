@echo off
ech "  %DCCProjectName% ..."
cd %DCCProjectPath%
%DCC32% -B -$D- -$C- -$L- -D%DCCFlags% -I%DCCLib% -U%DCCLib% -GD -E%DCCReturnPath%\%DCCOutput% -N%DCCReturnPath%\%DCCDcu% %DCCProjectName% >%DCCReturnPath%\%DCCLogs%\%DCCProjectName%.log
cd %DCCReturnPath%
grep Error: %DCCLogs%\%DCCProjectName%.log >>%DCCLogs%\ErrorCheck.txt
grep Fatal: %DCCLogs%\%DCCProjectName%.log >>%DCCLogs%\ErrorCheck.txt
echo  OK
