//////////////////////////////////////////////////////////////////////////////
//
// TGetExtendedInfoRemoteCommand
//
//////////////////////////////////////////////////////////////////////////////

unit uGetExtendedInfoRemoteCommand;

interface

uses
  // project units
  uRemoteCommand,
  uFilesSynchronizeConst;

type

  //
  // TGetExtendedInfoRemoteCommand
  //

  TGetExtendedInfoRemoteCommand = class(TRemoteCommand)
  private
    // fields
    FstrHostForSend: String;

    // private helper methods
    function _GetOSVersion: String;
    function _GetDiskFreeSpace(AstrDiskLetter: String): String;

  public
    // constructor / destructror
    constructor Create(const AstrHostForSend: String);

    // public methods
    procedure Execute(); override;

    // properties
    property HostForSend: String read FstrHostForSend write FstrHostForSend;

  end; // TGetExtendedInfoRemoteCommand


implementation

uses
  // system units
  SysUtils,
  // project units
{$IFDEF LINUX}
  uSafeStorage,
{$ENDIF}
  uDebugLog,
  uY2KCommon,
  uProtocol,
  uCommandSender,
{$IFDEF MSWINDOWS}
  Windows,
{$ENDIF}
  Types,
  gcconst,
  uFileReceiver,
  uClientOptions,
  uFileInfo;

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TGetExtendedInfoRemoteCommand.Create(const AstrHostForSend: String);
begin
  inherited Create();

  FstrHostForSend := AstrHostForSend;
  
end; // TGetExtendedInfoRemoteCommand.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TGetExtendedInfoRemoteCommand.Execute();
var
  strSendData: String;
begin
{$IFDEF LINUX}
   TSafeStorage.Instance.Push(ThreadSafeOperation_OldServerWarning,
       Integer(FormAction_Show));
{$ENDIF}
//  strTasksList := _GetExtendedInfo();
  //заполнить типа так: "версия винды/версия клиента/свободно на C/свободно на D"
  //заполнить типа так: "/script checksum/install checksum"
  strSendData := _GetOSVersion + '/';
  strSendData := strSendData + APP_VERSION + '/';
  strSendData := strSendData + _GetDiskFreeSpace('c:\') + '/';
  strSendData := strSendData + _GetDiskFreeSpace('d:\');
  try
    strSendData := strSendData + '/' + IntToStr(
        GetCheckSum(ExtractFilePath(ParamStr(0)) + FILE_RECEIVE_DIR_DEF + '\'
        + GClientOptions.ClientScriptFileName));
    strSendData := strSendData + '/' + IntToStr(
        GetCheckSum(ExtractFilePath(ParamStr(0)) + FILE_RECEIVE_DIR_DEF + '\'
        + FILE_INSTALL_FILENAME_DEF));
  except
  end;

  strSendData := STR_CMD_RET_GETEXTENDEDINFO + '=' + strSendData;

  SendDataTo(HostForSend, strSendData);

end; // TGetExtendedInfoRemoteCommand.Execute


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private helper methods
{$IFDEF MSWINDOWS}
function TGetExtendedInfoRemoteCommand._GetOSVersion: String;
var
  osvi: TOSVersionInfo;
  strResult: String;
begin
  osvi.dwOSVersionInfoSize := sizeof (OSVERSIONINFO);
  GetVersionEx (osvi);
  Result := '';

  if (osvi.dwPlatformId = VER_PLATFORM_WIN32s) then
    Result := 'Win32s '+IntToStr(osvi.dwMajorVersion)+'.'+
    IntToStr(osvi.dwMinorVersion) +' Build '+ IntToStr(osvi.dwBuildNumber);

  if (osvi.dwPlatformId = VER_PLATFORM_WIN32_WINDOWS) then
      Result := 'Windows 98 '+IntToStr(osvi.dwMajorVersion)+'.'+
      IntToStr(osvi.dwMinorVersion) +' Build '+ IntToStr(osvi.dwBuildNumber);

  if (osvi.dwPlatformId = VER_PLATFORM_WIN32_NT) then
    Result:= 'Windows XP '+IntToStr(osvi.dwMajorVersion)+'.'+
    IntToStr(osvi.dwMinorVersion) +' Build '+ IntToStr(osvi.dwBuildNumber);

end; // TGetExtendedInfoRemoteCommand._GetWindowsVersion: String;

function TGetExtendedInfoRemoteCommand._GetDiskFreeSpace(
    AstrDiskLetter: String): String;
Var
  SectorsPeCluster : DWORD;
    BytesPerSector : DWORD;
      FreeClusters : DWORD;
       NumClusters : DWORD;
        KBytesTotal : DWORD;
         KBytesFree : DWORD;
Begin
  if (GetDriveType(PChar(AstrDiskLetter)) = DRIVE_CDROM) then begin
    Result := 'CDRom';
    exit;
  end;
  GetDiskFreeSpace(PChar(AstrDiskLetter),
  SectorsPeCluster,BytesPerSector,FreeClusters,NumClusters);
  KBytesTotal:=Round(NumClusters/1024)*SectorsPeCluster*BytesPerSector;
  KBytesFree:=Round(FreeClusters/1024)*SectorsPeCluster*BytesPerSector;

  if (Round(KBytesFree/1024)>1000)
  then
    Result := 'free '+FloatToStr(Round(100*(KBytesFree/1048576))/100)+' GB ('+ FloatToStr(Round(100*(KBytesTotal/1048576))/100) +' GB)'
  else
    Result := 'free '+IntToStr(Round(KBytesFree/1024))+' MB ('+ FloatToStr(Round(100*(KBytesTotal/1048576))/100) +' GB)';
end; // TGetExtendedInfoRemoteCommand._GetDiskFreeSpace(AstrDiskLetter: String): String;
{$ENDIF}
{$IFDEF LINUX}
function TGetExtendedInfoRemoteCommand._GetOSVersion: String;
var
//  osvi: TOSVersionInfo;
  strResult: String;
begin
//  osvi.dwOSVersionInfoSize := sizeof (OSVERSIONINFO);
//  GetVersionEx (osvi);
  Result := 'DemoLinux';
{
  if (osvi.dwPlatformId = VER_PLATFORM_WIN32s) then
    Result := 'Win32s '+IntToStr(osvi.dwMajorVersion)+'.'+
    IntToStr(osvi.dwMinorVersion) +' Build '+ IntToStr(osvi.dwBuildNumber);

  if (osvi.dwPlatformId = VER_PLATFORM_WIN32_WINDOWS) then
      Result := 'Windows 98 '+IntToStr(osvi.dwMajorVersion)+'.'+
      IntToStr(osvi.dwMinorVersion) +' Build '+ IntToStr(osvi.dwBuildNumber);

  if (osvi.dwPlatformId = VER_PLATFORM_WIN32_NT) then
    Result:= 'Windows XP '+IntToStr(osvi.dwMajorVersion)+'.'+
    IntToStr(osvi.dwMinorVersion) +' Build '+ IntToStr(osvi.dwBuildNumber);
}
end; // TGetExtendedInfoRemoteCommand._GetWindowsVersion: String;

function TGetExtendedInfoRemoteCommand._GetDiskFreeSpace(
    AstrDiskLetter: String): String;
{Var
  SectorsPeCluster : DWORD;
    BytesPerSector : DWORD;
      FreeClusters : DWORD;
       NumClusters : DWORD;
        KBytesTotal : DWORD;
         KBytesFree : DWORD;
}
Begin
  Result := '';
  {
  if (GetDriveType(PChar(AstrDiskLetter)) = DRIVE_CDROM) then begin
    Result := 'CDRom';
    exit;
  end;
  GetDiskFreeSpace(PChar(AstrDiskLetter),
  SectorsPeCluster,BytesPerSector,FreeClusters,NumClusters);
  KBytesTotal:=Round(NumClusters/1024)*SectorsPeCluster*BytesPerSector;
  KBytesFree:=Round(FreeClusters/1024)*SectorsPeCluster*BytesPerSector;

  if (Round(KBytesFree/1024)>1000)
  then
    Result := 'free '+FloatToStr(Round(100*(KBytesFree/1048576))/100)+' GB ('+ FloatToStr(Round(100*(KBytesTotal/1048576))/100) +' GB)'
  else
    Result := 'free '+IntToStr(Round(KBytesFree/1024))+' MB ('+ FloatToStr(Round(100*(KBytesTotal/1048576))/100) +' GB)';
  }
end; // TGetExtendedInfoRemoteCommand._GetDiskFreeSpace(AstrDiskLetter: String): String;
{$ENDIF}


end.
