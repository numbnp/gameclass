//////////////////////////////////////////////////////////////////////////////
//
// Класс отправки файла по TCP.
//
//////////////////////////////////////////////////////////////////////////////

unit uFileSender;

interface

uses
  // system units
  Windows;


type

  //
  // TFileSender
  //

  TFileSender = class(TObject)
  private
    // fields
    // fields
    FhThreadFileSend: THandle;    // заголовок потока пересылки журнала
    FnTimeOut: Integer;
    FstrHost: String;
    FnPort: Integer;
    FstrSendedFilePath: String;
    FstrReceivedFileName: String;

    // private helper methods
    procedure _FileSend();

    function _SendOneFile(const AstrSendedFilePath: String;
        const AstrReceivedFileName: String): Boolean;
    function _GetFileSize(const AstrFileName: String): DWORD;
    function _SendFileToServer(const AstrSendedFilePath: String;
        const AdwFileSize: DWORD; const AstrReceivedFileName: String): Boolean;

  public
    // constructor / destructor
    constructor Create();
    destructor Destroy(); override;

    // public methods
    procedure StartSendThread();
    procedure StopSendThread();

    // properties
    property Host: String read FstrHost write FstrHost;
    property Port: Integer read FnPort write FnPort;
    property Timeout: Integer read FnTimeOut write FnTimeOut;
    property SendedFilePath: String
        read FstrSendedFilePath write FstrSendedFilePath;
    property ReceivedFileName: String
        read FstrReceivedFileName write FstrReceivedFileName;
  end; // TFileSender


implementation

uses
  // system units
  SysUtils,
  IdTCPConnection,
  IdTCPClient,
//  jwaWinBase,
//  jwaWinNT,
//  jwaWinType,
  Tlhelp32,
  // project units
  uDebugLog;


const
  TIMEOUT_DEF = 120000;
  HOST_DEF = '127.0.0.1';
  PORT_DEF = 2150;
  FILE_NAME_DEF = '';
  ARCHIVE_FILES_DEF = TRUE;

  ZIP_EXT = '.zip';
  SHD_EXT = '.shd';
  SPL_EXT = '.spl';


// метод используется для прерывания цикла ожидания событий
// см. описание API-функции QueueUserAPC
procedure ExitThreadAPC(AdwParam: DWORD); stdcall;
begin
  // do nothing
end; // ExitThreadAPC


// по идее это должна быть метод класса, но при попытке запустить
// метод класса в отдельном потоке приложение подвисает
// в варианте с глобальной функцией все работате нормально
function DoFileSend(Ap: TFileSender): DWORD;
begin
  Ap._FileSend();
  Result := 0;
end; // DoLogSend


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TFileSender.Create();
begin
  inherited Create();

  FstrHost := HOST_DEF;
  FnPort := PORT_DEF;
  FnTimeOut := TIMEOUT_DEF;
  FstrSendedFilePath := FILE_NAME_DEF;
  FstrReceivedFileName := FILE_NAME_DEF;

end; // TFileSender.Create


destructor TFileSender.Destroy();
begin
  inherited Destroy();

end; // TFileSender.Destroy


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TFileSender.StartSendThread();
var
  nThreadId: Cardinal;
begin
  FhThreadFileSend := BeginThread(
      nil,
      0,
      @DoFileSend,
      Pointer(Self),
      0,
      nThreadId);
end; // TFileSender.StartSendThread


procedure TFileSender.StopSendThread();
begin
  if (FhThreadFileSend <> INVALID_HANDLE_VALUE)
      and (FhThreadFileSend <> 0) then begin
    QueueUserAPC(@ExitThreadAPC, FhThreadFileSend, 0);
    WaitForSingleObject(FhThreadFileSend, INFINITE);
    CloseHandle(FhThreadFileSend);
  end;
end; // TFileSender.StopSendThread


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private helper methods

procedure TFileSender._FileSend();
var
  dwWaitStatus: DWORD;
begin
  while(TRUE) do begin

    Debug.Trace1('FileSend activate');
    if FileExists(SendedFilePath) then
      _SendOneFile(SendedFilePath, ReceivedFileName);
    dwWaitStatus := SleepEx(Timeout, TRUE);

    // пришло сообщение об окончании цикла
    if (WAIT_IO_COMPLETION = dwWaitStatus) then begin
      break;
    end;
  end;

end; // TFileSender._FileSend

function TFileSender._SendOneFile(const AstrSendedFilePath: String;
    const AstrReceivedFileName: String): Boolean;
var
  dwSize: DWORD;
begin
  Result := FALSE;
  dwSize := _GetFileSize(AstrSendedFilePath);
  ASSERT(dwSize <> INVALID_FILE_SIZE);
  if dwSize <> INVALID_FILE_SIZE then begin
    Result := _SendFileToServer(AstrSendedFilePath, dwSize,
        AstrReceivedFileName);
  end;
end; // TFileSender._SendOneFile


function TFileSender._GetFileSize(const AstrFileName: String): DWORD;
var
  hFile: THandle;
begin
  Result := INVALID_FILE_SIZE;

  hFile := CreateFile(PChar(AstrFileName), GENERIC_READ,
      FILE_SHARE_READ	or FILE_SHARE_WRITE,
      nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
  ASSERT((hFile <> INVALID_HANDLE_VALUE) and (hFile <> 0));
	if (hFile <> INVALID_HANDLE_VALUE) and (hFile <> 0) then begin
    Result := GetFileSize(hFile, nil);
    CloseHandle(hFile);
  end;

end; // TFileSender._GetFileSize

function TFileSender._SendFileToServer(const AstrSendedFilePath: String;
    const AdwFileSize: DWORD; const AstrReceivedFileName: String): Boolean;
var
  TCPClientFileTransfer: TIdTCPClient;
  strPath: String;
begin
  Result := FALSE;

  strPath := AstrSendedFilePath;
  TCPClientFileTransfer := TIdTCPClient.Create(nil);
  try
    try
      TCPClientFileTransfer.Host := Host;
      TCPClientFileTransfer.Port := Port;
      TCPClientFileTransfer.Connect();
      try
        TCPClientFileTransfer.IOHandler.WriteLn(AstrReceivedFileName);
        TCPClientFileTransfer.IOHandler.WriteLn(IntToStr(AdwFileSize));
        TCPClientFileTransfer.IOHandler.WriteFile(strPath);
      finally
        TCPClientFileTransfer.Disconnect();
      end;
      Result := TRUE;
    except
      // do nothing
    end;
  finally
    FreeAndNil(TCPClientFileTransfer);
  end;

end; // TFileSender._SendFile


end.
