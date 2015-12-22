set regpath="hklm\SOFTWARE\Wow6432Node\Embarcadero\BDS\15.0"

for /f "tokens=2,*" %%i in (' reg query "%regpath%" /v "RootDir" ') do set DCCPACTH=%%j

set DelphiPath=%DCCPACTH%
set DCCLib=%DelphiPath%\lib\Win32\release
set DCCLib=%DCCLib%;%DelphiPath%\Imports
set DCCLib=%DCCLib%;%DelphiPath%\Dcp
set DCCLib=%DCCLib%;%DelphiPath%\include
set DCCLib=%DCCLib%;C:\Program Files (x86)\FastReports\LibD21
set DCCLib=%DCCLib%;C:\Program Files (x86)\Raize\CS5\Lib\RS-XE7\Win32
set DCCLib=%DCCLib%;%PRootDir%\Components\github\DCEF3\src
set DCCLib=%DCCLib%;%PRootDir%\Components\FastMM\
set DCCLib=%DCCLib%;%PRootDir%\Components\Ehlibv7\RADStudioXE7
set DCCLib=%DCCLib%;%PRootDir%\Components\ExtControll
set DCCLib=%DCCLib%;%PRootDir%\Components\rxlib\units
set DCCLib=%DCCLib%;%PRootDir%\Components\SynEdit\Source
set DCCLib=%DCCLib%;%PRootDir%\Components\VirtualTreeviewV5.3.0\Source
set DCCLib=%DCCLib%;%PRootDir%\Components\y2kControls\Current\Product\Src
set DCCLib=%DCCLib%;%PRootDir%\Components\github\jcl\jcl\lib\d21\win32
set DCCLib=%DCCLib%;%PRootDir%\Components\github\jcl\jcl\source\include
set DCCLib=%DCCLib%;%PRootDir%\Components\github\jvcl\jvcl\lib\D21\win32
set DCCLib=%DCCLib%;%PRootDir%\Components\github\jvcl\jvcl\common
set DCCLib=%DCCLib%;%PRootDir%\Components\github\jvcl\jvcl\Resources
set DCCLib=%DCCLib%;%PRootDir%\Components\jwapi\Win32API
set DCCLib=%DCCLib%;%PRootDir%\Components\jwapi\Common
set DCCLib=%DCCLib%;%PRootDir%\Components\Ehlibv7\RADStudioXE7\Win32\Release
set DCCLib=%DCCLib%;%USERPROFILE%\Documents\Embarcadero\Studio\15.0\Imports
set DCCLib="%DCCLib%"

set DCCLogs=Install\Src\Logs
set DCCOutput=Output\Release
set DCCDcu=Output\Dcu\Release
set DCC32="%DelphiPath%\bin\dcc32.exe"

rem Удаляем exe и dcu
del %DCCOutput%\*.* /q 2>nul
del %DCCDcu%\*.* /q 2>nul
rem Инициализация обрабатки лог-файлы
del %DCCLogs%\ErrorCheck.txt 2>nul
Set error_check=
