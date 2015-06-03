//////////////////////////////////////////////////////////////////////////////
//
// Невизуальный компонент TY2KSysInfo - получение системной информации.
// Ссобщает информацию своим подписчикам (observer).
//
//////////////////////////////////////////////////////////////////////////////

unit uY2KSysInfo;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes;

const
  STR_WINNT = 'Windows NT';
  STR_WIN95 = 'Windows 95';
  STR_WIN32 = 'Win32';

type

  //
  // TY2KSysInfo
  //

  TY2KSysInfo = class(TComponent)
  private
    // attributes
    FstrUserName      : string;
    FstrComputerName  : string;
    FstrWindowsDir    : string;
    FstrSystemDir     : string;
    FstrTempDir       : string;
    FstrOS            : string;
    FstrOSBuildNumber : string;

    // properties methods
    function GetOS(): string;
    function GetOSBuildNumber(): string;
    function GetUserName(): string;
    function GetComputerName(): string;
    function GetWindowsDir(): string;
    function GetSystemDir(): string;
    function GetTempDir(): string;
    function GetAvailMemory(): string;
    function GetTotalMemory(): string;
    function GetTotalPageFile(): string;
    function GetAvailPageFile(): string;
    function GetTotalVirtual(): string;
    function GetAvailVirtual(): string;
  public
    // constructor / destructor
    constructor Create(AOwner:TComponent);override;
  published
    // properties
    property OS: string read FstrOS;
    property OSBuildNumber: string read FstrOSBuildNumber;
    property UserName: string read FstrUserName;
    property ComputerName: string read FstrComputerName;
    property WindowsDir: string read FstrWindowsDir;
    property SystemDir: string read FstrSystemDir;
    property TempDir: string read FstrTempDir;
    property AvailMem: string read GetAvailMemory;
    property TotalMem: string read GetTotalMemory;
    property AvailPageFile: string read GetAvailPageFile;
    property TotalPageFile: string read GetTotalPageFile;
    property AvailVirtual: string read GetAvailVirtual;
    property TotalVirtual: string read GetTotalVirtual;
  end; // TY2KSysInfo

function SIGetOS(): string;
function SIGetOSBuildNumber(): string;
function SIGetUserName(): string;
function SIGetComputerName(): string;
function SIGetTempDir(): string;
function SIGetWindowsDir(): string;
function SIGetSystemDir(): string;
function SIGetTotalMemory(): string;
function SIGetAvailMemory(): string;
function SIGetTotalPageFile:string;
function SIGetAvailPageFile:string;
function SIGetTotalVirtual:string;
function SIGetAvailVirtual:string;


implementation

function SIGetOS(): string;
var os:TOSVersionInfo;
begin
  os.dwOSVersionInfoSize:=sizeof(os);
  GetVersionEx(os);
  case os.dwPlatformId of
      VER_PLATFORM_WIN32S : Result:=STR_WIN32;
    VER_PLATFORM_WIN32_NT : Result:=STR_WINNT;
    else
      Result:= STR_WIN95;
  end;
end; // SIGetOS

function SIGetOSBuildNumber(): string;
var os:TOSVersionInfo;
begin
  os.dwOSVersionInfoSize:=sizeof(os);
  GetVersionEx(os);
  Result := IntToStr(os.dwMajorVersion) + '.' +
     IntToStr(os.dwMinorVersion) + '.' + IntToStr(os.dwBuildNumber);
end; // SIGetOSBuildNumber

function SIGetUserName(): string;
var strtmp: Pchar;
    size: DWORD;
begin
  size:=1024;
  strtmp:=stralloc(size);
  Windows.GetUserName(strtmp,size);
  Result:=strtmp;
  strdispose(strtmp);
end; // SIGetUserName

function SIGetComputerName(): string;
var strtmp: Pchar;
    size: DWORD;
begin
  size:=MAX_COMPUTERNAME_LENGTH+1;
  strtmp:=stralloc(size);
  Windows.GetComputerName(strtmp,size);
  Result:=strtmp;
  strdispose(strtmp);
end; // SIGetComputerName

function SIGetTempDir(): string;
var strtmp:Pchar;
begin
  strtmp:=stralloc(MAX_PATH+1);
  Windows.GetTempPath(MAX_PATH+1,strtmp);
  Result:=strtmp;
  strdispose(strtmp);
end; // SIGetTempDir

function SIGetWindowsDir(): string;
var strtmp:Pchar;
begin
  strtmp:=stralloc(MAX_PATH+1);
  Windows.GetWindowsDirectory(strtmp,MAX_PATH+1);
  Result:=strtmp;
  strdispose(strtmp);
end; // SIGetWindowsDir

function SIGetSystemDir(): string;
var strtmp:Pchar;
begin
  strtmp:=stralloc(MAX_PATH+1);
  Windows.GetSystemDirectory(strtmp,MAX_PATH+1);
  Result:=strtmp;
  strdispose(strtmp);
end; // SIGetSystemDir

function SIGetTotalMemory(): string;
var mem:TMemoryStatus;
begin
  GlobalMemoryStatus(mem);
  Result:=IntToStr(mem.dwTotalPhys);
end; // SIGetTotalMemory

function SIGetAvailMemory(): string;
var mem:TMemoryStatus;
begin
  GlobalMemoryStatus(mem);
  Result:=IntToStr(mem.dwAvailPhys);
end; // SIGetAvailMemory

function SIGetTotalPageFile(): string;
var mem:TMemoryStatus;
begin
  GlobalMemoryStatus(mem);
  Result:=IntToStr(mem.dwTotalPageFile);
end; // SIGetTotalPageFile

function SIGetAvailPageFile(): string;
var mem:TMemoryStatus;
begin
  GlobalMemoryStatus(mem);
  Result:=InttoStr(mem.dwAvailPageFile);
end; // SIGetAvailPageFile

function SIGetTotalVirtual(): string;
var mem:TMemoryStatus;
begin
  GlobalMemoryStatus(mem);
  Result:=IntToStr(mem.dwTotalVirtual);
end; // SIGetTotalVirtual

function SIGetAvailVirtual(): string;
var mem:TMemoryStatus;
begin
  GlobalMemoryStatus(mem);
  Result:=InttoStr(mem.dwAvailVirtual);
end; // SIGetAvailVirtual


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// TY2KSysInfo


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TY2KSysInfo.Create(AOwner:TComponent); // override
begin
  inherited Create(AOwner);
  FstrUserName      := GetUserName();
  FstrComputerName  := GetComputerName();
  FstrWindowsDir    := GetWindowsDir();
  FstrSystemDir     := GetSystemDir();
  FstrTempDir       := GetTempDir();
  FstrOS            := GetOS;
  FstrOSBuildNumber := GetOSBuildNumber();
end; // TY2KSysInfo.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// properties methods

function TY2KSysInfo.GetOS(): string;
begin
  Result := SIGetOS();
end; // TY2KSysInfo.GetOS

function TY2KSysInfo.GetOSBuildNumber(): string;
begin
  Result := SIGetOSBuildNumber();
end; // TY2KSysInfo.GetOSBuildNumber

function TY2KSysInfo.GetUserName(): string;
begin
  Result := SIGetUserName();
end; // TY2KSysInfo.GetUserName

function TY2KSysInfo.GetComputerName(): string;
begin
  Result := SIGetComputerName();
end; // TY2KSysInfo.GetComputerName

function TY2KSysInfo.GetTempDir(): string;
begin
  Result := SIGetTempDir();
end; // TY2KSysInfo.GetTempDir

function TY2KSysInfo.GetWindowsDir(): string;
begin
  Result := SIGetWindowsDir();
end; // TY2KSysInfo.GetWindowsDir

function TY2KSysInfo.GetSystemDir(): string;
begin
  Result := SIGetSystemDir();
end; // TY2KSysInfo.GetSystemDir

function TY2KSysInfo.GetTotalMemory(): string;
begin
  Result := SIGetTotalMemory();
end; // TY2KSysInfo.GetTotalMemory

function TY2KSysInfo.GetAvailMemory(): string;
begin
  Result := SIGetAvailMemory();
end; // TY2KSysInfo.GetAvailMemory

function TY2KSysInfo.GetTotalPageFile(): string;
begin
  Result := SIGetTotalPageFile();
end; // TY2KSysInfo.GetTotalPageFile

function TY2KSysInfo.GetAvailPageFile(): string;
begin
  Result := SIGetAvailPageFile();
end; // TY2KSysInfo.GetAvailPageFile

function TY2KSysInfo.GetTotalVirtual(): string;
begin
  Result := SIGetTotalVirtual();
end; // TY2KSysInfo.GetTotalVirtual

function TY2KSysInfo.GetAvailVirtual(): string;
begin
  Result := SIGetAvailVirtual();
end; // TY2KSysInfo.GetAvailVirtual

end. /////////////////////////// end of file /////////////////////////////////
