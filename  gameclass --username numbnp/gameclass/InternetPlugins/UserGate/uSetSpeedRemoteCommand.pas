//////////////////////////////////////////////////////////////////////////////
//
// TSetSpeedRemoteCommand
// Класс поступающих от управляющего сервера команд, которые требуют
// пересылки визуальной части клиента.
//
//
//////////////////////////////////////////////////////////////////////////////

unit uSetSpeedRemoteCommand;

interface

uses
  // project units
  uRemoteCommand;

type

  //
  // TSetSpeedRemoteCommand
  //

  TSetSpeedRemoteCommand = class(TRemoteCommand)
  private
    // fields
    FstrClientIP: String;
    FstrServerIP: String;
    FnSpeed: Integer;

  public
    // constructor / destructor
    constructor Create(); overload;
    constructor Create(const AstrClientIP: String;
        const AnSpeed: Integer; const AstrServerIP: String); overload;

    // public methods
    procedure Execute(); override;

    // properties
    property ServerIPAddress: String
        read FstrServerIP write FstrServerIP;

  end; // TSetSpeedRemoteCommand


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

constructor TSetSpeedRemoteCommand.Create();
begin
  ASSERT(FALSE,
      'TResendRemoteCommand.Create need AstrHostForResend parameter');
end; // TSetSpeedRemoteCommand.Create

constructor TSetSpeedRemoteCommand.Create(const AstrClientIP: String;
    const AnSpeed: Integer; const AstrServerIP: String);
begin
  inherited Create();

  FstrClientIP := AstrClientIP;
  FnSpeed := AnSpeed;
  FstrServerIP := AstrServerIP;
end; // TSetSpeedRemoteCommand.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TSetSpeedRemoteCommand.Execute();
begin
{  with IPInformations.GetItemByIP(FstrClientIP) do begin
    ServerIP := FstrServerIP;
    SpeedLimit := FnSpeed;
    if ContainedExtraInfo then begin
      try
        if (FnSpeed = 0) then begin
          UG.APISetAttr(3, ExtraInfo, User_BandwidthDef, True, True);
        end else begin
          UG.APISetAttr(3, ExtraInfo, User_BandwidthDef, False, True);
          UG.APISetAttr(3, ExtraInfo, User_InBandwidth, FnSpeed, True);
        end;
      except
        on E: Exception do begin
          Debug.Trace5('TSetSpeedRemoteCommand error! ' + e.Message);
        end;
      end;
    end else begin
      if not Options.Genaral.NoAddUsers.Value then
        UGCreateMissingUsers;
    end;
  end;
}end; // TSetSpeedRemoteCommand.Execute


end.
