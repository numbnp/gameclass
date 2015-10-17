rem @echo off
echo "  %DCCProjectName% ..."
cd %DCCProjectPath%
%DCC32% -$O- -$D- -$L- -$Y- --no-config -B -Q -TX.%DCCPType%  -D%DCCFlags% -U%DCCLib% -I%DCCLib% -O%DCCLib% -R%DCCLib% -K00400000 -GD -E%DCCReturnPath%\%DCCOutput%\ -NU%DCCReturnPath%\%DCCDcu%\ -NO%DCCReturnPath%\%DCCDcu%\  -AGenerics.Collections=System.Generics.Collections;Generics.Defaults=System.Generics.Defaults;WinTypes=Windows;WinProcs=Windows;DbiTypes=BDE;DbiProcs=BDE;DbiErrs=BDE -LE"%DelphiPath%\Bpl" -LN"%DelphiPath%\Dcp" -NSDatasnap.Win;Web.Win;Soap.Win;Xml.Win;Vcl;Vcl.Imaging;Vcl.Touch;Vcl.Samples;Vcl.Shell;System;Xml;Data;Datasnap;Web;Soap;Winapi;Data.Win;System.Win;VclTee;Bde; -NB"%DelphiPath%\Dcp" -NH"%DelphiPath%\hpp" -W-UNSAFE_CODE -W-UNSAFE_CAST %DCCProjectName%  >%DCCReturnPath%\%DCCLogs%\%DCCProjectName%.log
cd %DCCReturnPath%
grep Error: %DCCLogs%\%DCCProjectName%.log >>%DCCLogs%\ErrorCheck.txt
grep Fatal: %DCCLogs%\%DCCProjectName%.log >>%DCCLogs%\ErrorCheck.txt
echo  OK

