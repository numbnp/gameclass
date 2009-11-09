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
  uTICommonInterface,
  uIPInformation,
  uGCTIOptions,
  uTIUtils,
  uGCTIConst,
  TrafInspTLB;


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
begin
  with IPInformations.GetItemByIP(FstrClientIP) do begin
    ServerIP := FstrServerIP;
    TrafficLimit := FnLimit;
    if ContainedExtraInfo then begin
      try
        if (FnLimit = 0) then begin
          TI.APISetAttr(3, ExtraInfo, User_BillMode, 2, True);
        end else begin
          TI.APISetAttr(3, ExtraInfo, User_BillMode, 1, False);
          TI.APISetAttr(3, ExtraInfo, User_BillDefault, False, False);
          fCash := FnLimit/1048576;
          if Options.Genaral.TariffingMode.Value
              = Ord(TariffingModeTraffic) then begin
            TI.APISetAttr(3, ExtraInfo, User_TrafExclude, fCash, False);
            TI.APISetAttr(3, ExtraInfo, User_Cash, 0, True);
          end else if Options.Genaral.TariffingMode.Value
              = Ord(TariffingModeCost) then begin
            TI.APISetAttr(3, ExtraInfo, User_TrafExclude, 0, False);
            TI.APISetAttr(3, ExtraInfo, User_Cash, fCash, True);
          end;
        end;
      except
        on E: Exception do begin
          Debug.Trace5('TSetLimitRemoteCommand error! ' + e.Message);
        end;
      end;
    end else begin
      if not Options.Genaral.NoAddUsers.Value then
        TICreateMissingUsers;
    end;
  end;
end; // TSetLimitRemoteCommand.Execute


end.
