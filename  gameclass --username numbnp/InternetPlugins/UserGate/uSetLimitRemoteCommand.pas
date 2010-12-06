//////////////////////////////////////////////////////////////////////////////
//
// TSetLimitRemoteCommand
// Класс поступающих от управляющего сервера команд, которые требуют
// пересылки визуальной части клиента.
//
//
//////////////////////////////////////////////////////////////////////////////

unit uSetLimitRemoteCommand;

interface

uses
  // project units
  uRemoteCommand;

type

  //
  // TSetLimitRemoteCommand
  //

  TSetLimitRemoteCommand = class(TRemoteCommand)
  private
    // fields
    FstrClientIP: String;
    FstrServerIP: String;
    FnLimit: Integer;

  public
    // constructor / destructor
    constructor Create(); overload;
    constructor Create(const AstrClientIP: String;
        const AnLimit: Integer; const AstrServerIP: String); overload;

    // public methods
    procedure Execute(); override;

    // properties
    property ServerIPAddress: String
        read FstrServerIP write FstrServerIP;

  end; // TSetLimitRemoteCommand


implementation

uses
  // system units
  SysUtils,
  // project units
  uY2KCommon,
  uDebugLog,
  uUGConfig,
  uIPInformation,
  uGCUGOptions,
  uUGUtils,
  uGCUGConst;


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TSetLimitRemoteCommand.Create();
begin
  ASSERT(FALSE,
      'TResendRemoteCommand.Create need AstrHostForResend parameter');
end; // TSetLimitRemoteCommand.Create

constructor TSetLimitRemoteCommand.Create(const AstrClientIP: String;
    const AnLimit: Integer; const AstrServerIP: String);
begin
  inherited Create();

  FstrClientIP := AstrClientIP;
  FnLimit := AnLimit;
  FstrServerIP := AstrServerIP;
end; // TSetLimitRemoteCommand.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TSetLimitRemoteCommand.Execute();
var
  fCash: Double;
  strErr: String;
var
  UG: TUGConfig;
begin
  UG := TUGConfig.Create(Options.Genaral.Path.Value,
      Options.Genaral.Name.Value,
      Options.Genaral.DecriptedPassword);
  if UG.Connected then begin
    with IPInformations.GetItemByIP(FstrClientIP) do begin
      ServerIP := FstrServerIP;
      TrafficLimit := FnLimit;
      if ContainedExtraInfo then begin
        try
          if (FnLimit = 0) then begin
            fCash := FnLimit/1048576;
            UG.SetUserBalance(FstrClientIP, fCash, False, strErr);
          end;
        except
          on E: Exception do begin
            Debug.Trace5('TSetLimitRemoteCommand error! ' + e.Message);
          end;
        end;
      end else begin
        if not Options.Genaral.NoAddUsers.Value then
          UGCreateMissingUsers(UG);
      end;
    end;
    UG.Disconnect;
  end;
  FreeAndNil(UG);
end; // TSetLimitRemoteCommand.Execute


end.
