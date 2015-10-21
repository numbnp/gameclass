//////////////////////////////////////////////////////////////////////////////
//
// TCommandSender
// Класс - отправитель команд.
//
//////////////////////////////////////////////////////////////////////////////

unit uCommandSender;

interface

uses
  // system units
  SyncObjs,
  Classes,
  IdSocketHandle,
  IdUDPClient,
  IdGlobal;


type

  //
  // TCommandSender
  //

  TCommandSender = class(TObject)
  private
    // fields
    FstrHost: string;
    FnPort: integer;

    // private helper methods
    function _AddProtocolInfoToData(const AstrData: string): string;

  protected
    // properties methods
    // Host
    procedure SetHost(const AstrHost: string); virtual;
    function GetHost(): string; virtual;

    // Port
    procedure SetPort(const AnPort: integer); virtual;
    function GetPort(): integer; virtual;

  public
    // constructor / destructor
    constructor Create();
    destructor Destroy(); override;

    // public methods
    procedure SendCommand(const AstrData: string);

    // properties
    property Host: string read GetHost write SetHost;
    property Port: integer read GetPort write SetPort;

  end; // TCommandSender


procedure SendDataTo(const AstrHostForSend: String;
    const AstrData: String; AbToServer: Boolean = True);

var
  csSendData: TCriticalSection;



implementation

uses
  // system units
  SysUtils,
  StrUtils,
  // project units
  uY2KCommon,
  uProtocol,
  uDebugLog,
  uCommandReceiver;


const
  DEF_HOST_FOR_UDPCLIENT = '127.0.0.1';
  DEF_PORT_FOR_UDPCLIENT = 3773;


procedure SendDataTo(const AstrHostForSend: String;
    const AstrData: String; AbToServer: Boolean = True);
var
  CommandSender: TCommandSender;
begin
  Debug.Trace5('SendDataTo' + IfThen(AbToServer, 'Server', 'Local')
      +  ': [' + AstrHostForSend + ']:' + AstrData);
  if Length(AstrHostForSend) > 0 then
    try
      CommandSender := TCommandSender.Create();
      if Not AbToServer then
        CommandSender.Port := DEF_PORT_FOR_UDPSERVER;
      try
        CommandSender.Host := AstrHostForSend;
        CommandSender.SendCommand(AstrData);
      finally
        FreeAndNilWithAssert(CommandSender);
      end;
    except
      on e: Exception do begin
        Debug.Trace0('SendDataTo' +IfThen(AbToServer, 'Server', 'Local')
            +  ': [' + AstrHostForSend + ']:' + AstrData);
        Debug.Trace0('SendDataToGCServer error! ' + e.Message);
      end;
    end;
end; // SendDataToGCServer


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// TCommandSender

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TCommandSender.Create();
begin
  inherited Create();

  FstrHost := DEF_HOST_FOR_UDPCLIENT;
  FnPort := DEF_PORT_FOR_UDPCLIENT;

end; // TCommandSender.Create


destructor TCommandSender.Destroy();
begin
  inherited Destroy();
end; // TCommandSender.Destroy


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TCommandSender.SendCommand(const AstrData: string);
var
  UDPClient: TIdUDPClient;
  strData: string;
begin
  strData := _AddProtocolInfoToData(AstrData);
  Debug.Trace1('SendCommand:' + AstrData);
  try
    csSendData.Acquire();
    try
      UDPClient := TIdUDPClient.Create(nil);
      try
        with UDPClient do begin
          Host := Self.Host;
          Port := self.Port;
          Send(strData,IndyTextEncoding_OSDefault);
        end;
      finally
        FreeAndNilWithAssert(UDPClient)
      end;
    finally
      csSendData.Release();
    end;
  except
    on e: Exception do begin
      Debug.Trace0('SendCommand(' + IntToStr(Port)
          +  '): [' + Host + ']:' + AstrData);
      Debug.Trace0('TCommandSender.SendCommand error! ' + e.Message);
    end;
  end;
end; // TCommandSender.SendCommand


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// properties methods

// Host
procedure TCommandSender.SetHost(const AstrHost: string);
begin
  FstrHost := AstrHost;
end; // TCommandSender.SetHost


function TCommandSender.GetHost(): string;
begin
  Result := FstrHost;
end; // TCommandSender.GetHost


// Port
procedure TCommandSender.SetPort(const AnPort: integer);
begin
  FnPort := AnPort;
end; // TCommandSender.SetPort


function TCommandSender.GetPort(): integer;
begin
  Result := FnPort;
end; // TCommandSender.GetPort


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private helper methods

function TCommandSender._AddProtocolInfoToData(
    const AstrData: string): string;
begin
  Result := PROTOCOL_V01 + '.' + AstrData;
end; // TCommandSender._AddProtocolInfoToData

initialization
  csSendData := TCriticalSection.Create();

finalization
  csSendData.Free();

end.
