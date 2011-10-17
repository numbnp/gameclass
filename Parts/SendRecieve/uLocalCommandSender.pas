{$A8,B-,C+,D+,E-,F-,G+,H+,I+,J-,K-,L+,M-,N+,O-,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
{$WARN SYMBOL_DEPRECATED ON}
{$WARN SYMBOL_LIBRARY ON}
{$WARN SYMBOL_PLATFORM ON}
{$WARN UNIT_LIBRARY ON}
{$WARN UNIT_PLATFORM ON}
{$WARN UNIT_DEPRECATED ON}
{$WARN HRESULT_COMPAT ON}
{$WARN HIDING_MEMBER ON}
{$WARN HIDDEN_VIRTUAL ON}
{$WARN GARBAGE ON}
{$WARN BOUNDS_ERROR ON}
{$WARN ZERO_NIL_COMPAT ON}
{$WARN STRING_CONST_TRUNCED ON}
{$WARN FOR_LOOP_VAR_VARPAR ON}
{$WARN TYPED_CONST_VARPAR ON}
{$WARN ASG_TO_TYPED_CONST ON}
{$WARN CASE_LABEL_RANGE ON}
{$WARN FOR_VARIABLE ON}
{$WARN CONSTRUCTING_ABSTRACT ON}
{$WARN COMPARISON_FALSE ON}
{$WARN COMPARISON_TRUE ON}
{$WARN COMPARING_SIGNED_UNSIGNED ON}
{$WARN COMBINING_SIGNED_UNSIGNED ON}
{$WARN UNSUPPORTED_CONSTRUCT ON}
{$WARN FILE_OPEN ON}
{$WARN FILE_OPEN_UNITSRC ON}
{$WARN BAD_GLOBAL_SYMBOL ON}
{$WARN DUPLICATE_CTOR_DTOR ON}
{$WARN INVALID_DIRECTIVE ON}
{$WARN PACKAGE_NO_LINK ON}
{$WARN PACKAGED_THREADVAR ON}
{$WARN IMPLICIT_IMPORT ON}
{$WARN HPPEMIT_IGNORED ON}
{$WARN NO_RETVAL ON}
{$WARN USE_BEFORE_DEF ON}
{$WARN FOR_LOOP_VAR_UNDEF ON}
{$WARN UNIT_NAME_MISMATCH ON}
{$WARN NO_CFG_FILE_FOUND ON}
{$WARN MESSAGE_DIRECTIVE ON}
{$WARN IMPLICIT_VARIANTS ON}
{$WARN UNICODE_TO_LOCALE ON}
{$WARN LOCALE_TO_UNICODE ON}
{$WARN IMAGEBASE_MULTIPLE ON}
{$WARN SUSPICIOUS_TYPECAST ON}
{$WARN PRIVATE_PROPACCESSOR ON}
{$WARN UNSAFE_TYPE ON}
{$WARN UNSAFE_CODE ON}
{$WARN UNSAFE_CAST ON}
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
