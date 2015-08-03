//////////////////////////////////////////////////////////////////////////////
//
// TCommandReceiver
//  ласс - получатель команд от управл€ющего сервера.
//
//////////////////////////////////////////////////////////////////////////////

unit uCommandReceiver;

interface

uses
  // system units
  Classes,
  IdSocketHandle,
  IdUDPServer,
  IdGlobal;

const
  DEF_PORT_FOR_UDPSERVER = 3774;

type

  // messages types
  TDataReceivedProc = procedure (const AstrData: string;
      const AstrFromHost: string) of object;

  //
  // TCommandReceiver
  //

  TCommandReceiver = class(TObject)
  private
    // fields
    FUDPServer: TIdUDPServer;
    FOnDataReceived: TDataReceivedProc;
    FbCheckProtocol: Boolean;

    // events handlers
    procedure _UDPServerRead(AThread: TIdUDPListenerThread;
        const AData: TIdBytes; ABinding: TIdSocketHandle);
  //(Sender: TObject; AData: TStream;
  //      ABinding: TIdSocketHandle);

    // private helper methods
    procedure _SendDataReceiveEvent(const AstrData: string;
        const AstrFromHost: string);
    function _ExtractProtocolInfo(const AstrData: string): string;
    function _IsValidProtocol(const AstrProtocol: string): boolean;
    procedure _CleanProtocolInfoFromData(var AstrData: string);

  protected
    // properties methods
    // Port
    procedure SetPort(const AnPort: integer); virtual;
    function GetPort(): integer; virtual;

  public
    // constructor / destructor
    constructor Create(); overload;
    constructor Create(const AnPort: Integer;
        const AbCheckProtocol: Boolean); overload;
    destructor Destroy(); override;

    // public methods
    procedure StartReceiveProcess();
    procedure StopReceiveProcess();

    // properties
    property OnDataReceived: TDataReceivedProc
        read FOnDataReceived write FOnDataReceived;
    property Port: Integer
        read GetPort write SetPort;

  end; // TCommandReceiver


implementation

uses
  // system units
  SysUtils,
  // project units
  uProtocol,
  uDebugLog,
  uY2KCommon,
{$IFDEF MSWINDOWS}
  Activex,
  Messages,
{$ENDIF}
  Types;




//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TCommandReceiver.Create();
begin
  inherited Create();
  FUDPServer := TIdUDPServer.Create(nil);
  FbCheckProtocol := True;
//  FUDPServer.BufferSize := 64000;//8192;
  FUDPServer.DefaultPort := DEF_PORT_FOR_UDPSERVER;
  FUDPServer.ThreadedEvent := TRUE;
{$IFDEF LINUX}
///  FUDPServer.ThreadedEvent := False;
{$ENDIF}
  FUDPServer.OnUDPRead := _UDPServerRead;
  FUDPServer.ReceiveTimeout := 1000;
end; // TCommandReceiver.Create

constructor TCommandReceiver.Create(const AnPort: Integer;
    const AbCheckProtocol: Boolean);
begin
  Create();
  FUDPServer.DefaultPort := AnPort;
  FbCheckProtocol := AbCheckProtocol;
end; // TCommandReceiver.Create

destructor TCommandReceiver.Destroy();
begin
  FreeAndNilWithAssert(FUDPServer);
  inherited Destroy();

end; // TCommandReceiver.Destroy


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TCommandReceiver.StartReceiveProcess();
begin
  try
    FUDPServer.Active := TRUE;
  except
    on e: Exception do begin
      Debug.Trace0('TCommandReceiver.StopReceiveProcess error! ' + e.Message);
    end;
  end;
end; // TCommandReceiver.StartReceiveProcess


procedure TCommandReceiver.StopReceiveProcess();
begin
  try
    FUDPServer.Active := FALSE;
{$IFDEF MSWINDOWS}
    CoUninitialize;
{$ENDIF}
  except
    on e: Exception do begin
      Debug.Trace0(
          'TCommandReceiver.StopReceiveProcess error! ' + e.Message);
    end;
  end;
end; // TCommandReceiver.StopReceiveProcess


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// properties methods

// Port
procedure TCommandReceiver.SetPort(const AnPort: integer);
var
  IsUDPServerStarted: boolean;
begin
  try
    IsUDPServerStarted := FUDPServer.Active;
    FUDPServer.Active := FALSE;
    FUDPServer.DefaultPort := AnPort;
    FUDPServer.Active := IsUDPServerStarted;
  except
    on e: Exception do begin
      Debug.Trace0('TCommandReceiver.SetPort error! ' + e.Message);
    end;
  end;
end; // TCommandReceiver.SetPort


function TCommandReceiver.GetPort(): integer;
begin
  Result := FUDPServer.DefaultPort;
end; // TCommandReceiver.GetPort


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// events handlers

procedure TCommandReceiver._UDPServerRead(AThread: TIdUDPListenerThread;
  const AData: TIdBytes; ABinding: TIdSocketHandle);

//procedure TCommandReceiver._UDPServerRead(Sender: TObject; AData: TStream;
//    ABinding: TIdSocketHandle);
var
//  DataStringStream: TStringStream;
  strData: string;
  strProtocol: string;
begin
  try
//    DataStringStream := TStringStream.Create('');
    try
//      DataStringStream.CopyFrom(AData, AData.Size);
      strData := TrimLeft(TrimRight(BytesToString(AData,IndyTextEncoding_OSDefault)));

      strProtocol := _ExtractProtocolInfo(strData);
      if not FbCheckProtocol or _IsValidProtocol(strProtocol) then begin
        if FbCheckProtocol then
          _CleanProtocolInfoFromData(strData);
        _SendDataReceiveEvent(strData, ABinding.PeerIP);
      end;

    finally
//    FreeAndNilWithAssert(DataStringStream);
    end;

  except
    on e: Exception do begin
      Debug.Trace0('TCommandReceiver._UDPServerRead error! ' + e.Message);
    end;
  end;

end; // TCommandReceiver._UDPServerRead


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private helper methods

procedure TCommandReceiver._SendDataReceiveEvent(const AstrData: string;
    const AstrFromHost: string);
begin
  if Assigned(OnDataReceived) then begin
    OnDataReceived(AstrData, AstrFromHost);
  end;
end; // TCommandReceiver._SendDataReceiveEvent


function TCommandReceiver._ExtractProtocolInfo(
    const AstrData: string): string;
begin
  Result := Copy(AstrData, 1, length(PROTOCOL_V01+'.'));
end; // TCommandReceiver._ExtractProtocolInfo


procedure TCommandReceiver._CleanProtocolInfoFromData(var AstrData: string);
begin
  ASSERT(not FbCheckProtocol or _IsValidProtocol(_ExtractProtocolInfo(AstrData)));

  Delete(AstrData, 1, length(PROTOCOL_V01+'.'));

end; // TCommandReceiver._CleanProtocolInfoFromData


function TCommandReceiver._IsValidProtocol(
    const AstrProtocol: string): boolean;
begin
  Result := (CompareText(AstrProtocol, PROTOCOL_V01+'.') = 0);
end; // TCommandReceiver._IsValidProtocol


end. ////////////////////////// end of file //////////////////////////////////
