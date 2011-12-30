
//////////////////////////////////////////////////////////////////////////////
//
// TLocalCommandSender - класс посылающий команды приложению,
// запущенному на локальном компьютере.
//
//////////////////////////////////////////////////////////////////////////////

unit uLocalCommandSender;

interface

uses   IdTCPClient;

type

  //
  // TLocalCommandSender
  //

  TLocalCommandSender = class(TObject)
  private
    // fields
    FstrHost: String;
    FnPort: Integer;
    tcpClient: TIdTCPClient;

  protected
    // properties methods
    // Port
    function GetPort(): Integer;
    procedure SetPort(const AnPort: Integer);

  public
    // constructor / destructor
    constructor Create();
    destructor Destroy(); override;

    // public methods
    function SendCommand(const AstrData: String): Boolean;

    // properties
    property Port: Integer read GetPort write SetPort;

  end; // TLocalCommandSender

const
  DEF_HOST_FOR_TCPCLIENT = '127.0.0.1';
  DEF_PORT_FOR_TCPCLIENT = 3777;

function LocalSendDataTo(const AstrData: String; AbToClient: Boolean = True): Boolean;


implementation


uses
  // system units
  SysUtils,
//  Dialogs,
  // project units
  uY2KCommon,
  uDebugLog,
{$IFDEF LINUX}
  uCommandSender,
  uClientInfo,
{$ENDIF}
  uLocalCommandReceiver;

var
  CommandSender: TLocalCommandSender;


function LocalSendDataTo(const AstrData: String; AbToClient: Boolean = True): Boolean;
begin
{$IFDEF MSWINDOWS}
  Result := TRUE;
   try
    if CommandSender = nil then
      CommandSender := TLocalCommandSender.Create();
    if Not AbToClient then
      CommandSender.Port := DEF_PORT_FOR_TCPSERVER;
    try
      CommandSender.SendCommand(AstrData);
    finally
//      FreeAndNilWithAssert(CommandSender);
    end;
  except
    on e: Exception do begin
      Result := FALSE;
      Debug.Trace0('SendDataToGCClient Error! ' + e.Message);
    end;
  end;
{$ENDIF}
{$IFDEF LINUX}
    SendDataTo(GClientInfo.ServerIPAddress, AstrData);
{$ENDIF}
end; // SendDataToGCClient


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// TLocalCommandSender

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TLocalCommandSender.Create();
begin
  inherited Create();

  FnPort := DEF_PORT_FOR_TCPCLIENT;
  FstrHost := DEF_HOST_FOR_TCPCLIENT;

end; // TLocalCommandSender.Create


destructor TLocalCommandSender.Destroy();
begin
  inherited Destroy();
end; // TLocalCommandSender.Destroy


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

// Result: TRUE  - send commsnd success
//         FALSE - send command error
function TLocalCommandSender.SendCommand(const AstrData: String): boolean;
begin
  Result := TRUE;
  if tcpClient = nil then
    tcpClient := TIdTCPClient.Create(nil);
  try
    try
      begin
        if not tcpClient.Connected then
        begin
          tcpClient.Host := Self.FstrHost;
          tcpClient.Port := Self.Port;
          tcpClient.Connect();
        end;
        if tcpClient.Connected then begin
          tcpClient.WriteInteger(length(AstrData));
          tcpClient.WriteLn(AstrData);
//          tcpClient.Disconnect();
        end else begin
          Result := FALSE;
        end;
      end;
    finally
//      FreeAndNilWithAssert(tcpClient);
    end;

  except
    on e: Exception do begin
      Debug.Trace0('SendCommand(' + IntToStr(Port)
          +  '): [' + FstrHost + ']:' + AstrData);
      Debug.Trace0('LocalCommandSender.SendCommand error! ' + e.Message);
      Result := FALSE;
    end;
  end;

end; // TLocalCommandSender.SendCommand


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// properties methods

// Port
function TLocalCommandSender.GetPort(): Integer;
begin
  Result := FnPort;
end; // TLocalCommandSender.GetPort


procedure TLocalCommandSender.SetPort(const AnPort: Integer);
begin
  if tcpClient <> nil then
    if tcpClient.Port <> AnPort then
    begin
      if tcpClient.Connected then
        tcpClient.Disconnect;
      FreeAndNilWithAssert(tcpClient);
    end;
  FnPort := AnPort;
end; // TLocalCommandSender.SetPort


end.
