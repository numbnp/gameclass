//////////////////////////////////////////////////////////////////////////////
//
// Класс получения файла по TCP.
//
//////////////////////////////////////////////////////////////////////////////

unit uFileReceiver;

interface

uses
  // system units
  IdBaseComponent,
  IdComponent,
  IdTCPServer;

type

  //
  // TFileReceiver
  //

  TFileReceiver = class(TObject)
  private
    // fields
    FnPort: Integer;
    FFileTransferTCPServer: TIdTCPServer;

    // events handlers
    procedure _FileTransferTCPServerExecute(AThread: TIdPeerThread);

    // private helper methods
    function _BuildFullPath(const AstrFileName: String): String;

  public
    // constructor / destructor
    constructor Create();
    destructor Destroy(); override;

    // public methods
    procedure StartReceive();
    procedure StopReceive();

    // properties
    property Port: Integer read FnPort write FnPort;

  end; // TFileReceiver


implementation

uses
  // system units
  Classes,
  SysUtils,
  StrUtils,
  // project units
  uDebugLog,
  uGetExtendedInfoRemoteCommand,
  usrvGCCL,
  uFilesSynchronizeConst;



//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TFileReceiver.Create();
begin
  inherited Create();

  FnPort := FILE_RECEIVER_PORT;

  FFileTransferTCPServer := TIdTCPServer.Create(nil);
  FFileTransferTCPServer.OnExecute := _FileTransferTCPServerExecute;

end; // TFileReceiver.Create


destructor TFileReceiver.Destroy();
begin
  FreeAndNil(FFileTransferTCPServer);

  inherited Destroy();

end; // TFileReceiver.Destroy


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TFileReceiver.StartReceive();
begin
  FFileTransferTCPServer.DefaultPort := Port;
  FFileTransferTCPServer.Active := TRUE;
end; // TFileReceiver.StartReceive


procedure TFileReceiver.StopReceive();
begin
  FFileTransferTCPServer.Active := FALSE;
end; // TFileReceiver.StopReceive


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// events handlers

procedure TFileReceiver._FileTransferTCPServerExecute(AThread: TIdPeerThread);
var
  strPath: String;
  strFileName: String;
  Stream: TStream;
  nSize: Int64;
  cmd: TGetExtendedInfoRemoteCommand;
begin
  try
    Debug.Trace5('_FileTransferTCPServerExecute');
    if AThread.Connection.Connected then begin
      strFileName := AThread.Connection.ReadLn();
      strPath := _BuildFullPath(strFileName);
      nSize := StrToInt(AThread.Connection.ReadLn());
      Stream := TFileStream.Create(strPath, fmCreate);
      try
        AThread.Connection.ReadStream(Stream, nSize);
      finally
        FreeAndNil(Stream);
      end;
      if (strFileName = FILE_INSTALL_FILENAME_DEF) then begin
        cmd := TGetExtendedInfoRemoteCommand.Create(srvGCCL.ServerHost);
        cmd.Execute;
        cmd.Free;
      end;
    end;
  except
    // do nothing
  end;
end; // TFileReceiver._FileTransferTCPServerExecute


function TFileReceiver._BuildFullPath(const AstrFileName: String): String;
var
  strSubdir: String;
begin
  strSubdir := ExtractFilePath(ParamStr(0)) + FILE_RECEIVE_DIR_DEF + '\';

  if not DirectoryExists(strSubdir) then begin
    CreateDir(strSubdir);
  end;

  Result := strSubdir + AstrFileName;

end; // TFileReceiver._BuildFullPath

end.
