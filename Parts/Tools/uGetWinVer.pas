unit uGetWinVer;

interface

uses
  Windows, Messages, SysUtils;

procedure GetWindowsVersionEx(var Major: integer;
  var Minor: integer);

function GetWindowsVersion():integer;

implementation

{$IFDEF WIN32}
function GetVersionEx(lpOs: pointer): BOOL; stdcall;
  external 'kernel32' name 'GetVersionExA';
{$ENDIF}

procedure GetWindowsVersionEx(var Major: integer;
  var Minor: integer);
var
{$IFDEF WIN32}
  lpOS, lpOS2: POsVersionInfo;
{$ELSE}
  l: longint;
{$ENDIF}
begin
{$IFDEF WIN32}
  GetMem(lpOS, SizeOf(TOsVersionInfo));
  lpOs^.dwOSVersionInfoSize := SizeOf(TOsVersionInfo);
  while getVersionEx(lpOS) = false do begin
    GetMem(lpos2, lpos^.dwOSVersionInfoSize + 1);
    lpOs2^.dwOSVersionInfoSize := lpOs^.dwOSVersionInfoSize + 1;
    FreeMem(lpOs, lpOs^.dwOSVersionInfoSize);
    lpOS := lpOs2;
  end;
  Major := lpOs^.dwMajorVersion;
  Minor := lpOs^.dwMinorVersion;
  FreeMem(lpOs, lpOs^.dwOSVersionInfoSize);
{$ELSE}
  l := GetVersion;
  Major := LoByte(LoWord(l));
  Minor := HiByte(LoWord(l));
{$ENDIF}
end;

function GetWindowsVersion():integer;
var
  Major: integer;
  Minor: integer;
begin
  GetWindowsVersionEx(Major,Minor);
  result:=Major;
end;


end.
