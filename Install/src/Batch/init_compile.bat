set regpath="hklm\SOFTWARE\Wow6432Node\Embarcadero\BDS\21.0"

for /f "tokens=2,*" %%i in (' reg query "%regpath%" /v "RootDir" ') do set DCCPACTH=%%j

set DelphiPath=%DCCPACTH%
set DCCLib="%DelphiPath%lib\Win32\release"
set DCCLib=%DCCLib%;"%DelphiPath%Imports"
set DCCLib=%DCCLib%;"%DelphiPath%Dcp"
set DCCLib=%DCCLib%;"%DelphiPath%include"
@REM set DCCLib=%DCCLib%;C:\Program Files (x86)\FastReports\LibD21
@REM set DCCLib=%DCCLib%;C:\Program Files (x86)\Raize\CS5\Lib\RS-XE7\Win32
set DCCLib=%DCCLib%;"%PRootDir%\Components\DCEF3\src"
set DCCLib=%DCCLib%;%PRootDir%\Components\FastMM\
set DCCLib=%DCCLib%;%PRootDir%\Components\ExtControll
set DCCLib=%DCCLib%;%PRootDir%\Components\rxlib\units
set DCCLib=%DCCLib%;%PRootDir%\Components\SynEdit\Source
set DCCLib=%DCCLib%;%PRootDir%\Components\VirtualTreeview\Source
@REM set DCCLib=%DCCLib%;"%PRootDir%\Components\y2kControls\Current\Product\Src"
set DCCLib=%DCCLib%;"%PRootDir%\Components\jcl\jcl\lib\d27\win32"
set DCCLib=%DCCLib%;"%PRootDir%\Components\jcl\jcl\source\include"
set DCCLib=%DCCLib%;"%PRootDir%\Components\jvcl\jvcl\lib\D27\win32"
set DCCLib=%DCCLib%;"%PRootDir%\Components\jvcl\jvcl\common"
set DCCLib=%DCCLib%;"%PRootDir%\Components\jvcl\jvcl\Resources"
set DCCLib=%DCCLib%;"%PRootDir%\Components\jwapi\Win32API"
set DCCLib=%DCCLib%;"%PRootDir%\Components\jwapi\Common"
set DCCLib=%DCCLib%;"%DelphiPath%Components\EhLib\Lib\Win32\Release"
set DCCLib=%DCCLib%;"%USERPROFILE%\Documents\Embarcadero\Studio\21.0\Imports"
@REM set DCCLib="%DCCLib%"

set DCCLogs=Install\Src\Logs
set DCCOutput=Output\Release
set DCCDcu=Output\Dcu\Release
set DCC32="%DelphiPath%bin\dcc32.exe"

rem ����塞 exe � dcu
del %DCCOutput%\*.* /q 2>nul
del %DCCDcu%\*.* /q 2>nul
rem ���樠������ ��ࠡ�⪨ ���-䠩��
del %DCCLogs%\ErrorCheck.txt 2>nul
Set error_check=
