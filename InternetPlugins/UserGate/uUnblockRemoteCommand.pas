//////////////////////////////////////////////////////////////////////////////
//
// TUnblockRemoteCommand
// Класс поступающих от управляющего сервера команд, которые требуют
// пересылки визуальной части клиента.
//
//
//////////////////////////////////////////////////////////////////////////////

unit uUnblockRemoteCommand;

interface

uses
  // project units
  uRemoteCommand;

type

  //
  // TUnblockRemoteCommand
  //

  TUnblockRemoteCommand = class(TRemoteCommand)
  private
    // fields
    FstrClientIP: String;
    FstrServerIP: String;
    FstrTarifName: String;

  public
    // constructor / destructor
    constructor Create(); overload;
    constructor Create(const AstrClientIP: String;
        const AstrTarifName: String; const AstrServerIP: String); overload;

    // public methods
    procedure Execute(); override;

    // properties
    property ServerIPAddress: String
        read FstrServerIP write FstrServerIP;

  end; // TUnblockRemoteCommand


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

constructor TUnblockRemoteCommand.Create();
begin
  ASSERT(FALSE,
      'TResendRemoteCommand.Create need AstrHostForResend parameter');
end; // TUnblockRemoteCommand.Create

constructor TUnblockRemoteCommand.Create(const AstrClientIP: String;
    const AstrTarifName: String; const AstrServerIP: String);
begin
  inherited Create();

  FstrClientIP := AstrClientIP;
  FstrServerIP := AstrServerIP;
  FstrTarifName := AstrTarifName;
end; // TUnblockRemoteCommand.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TUnblockRemoteCommand.Execute();
var
  UG: TUGConfig;
begin
  UG := TUGConfig.Create(Options.Genaral.Path.Value,
      Options.Genaral.Name.Value,
      Options.Genaral.DecriptedPassword);
  if UG.Connected then begin
    with IPInformations.GetItemByIP(FstrClientIP) do begin
      ServerIP := FstrServerIP;
      Tarif := FstrTarifName;
      Enable;
      if ContainedExtraInfo then begin
        try
          UGEnableUser(UG, FstrClientIP, True);
        except
          on E: Exception do begin
            Debug.Trace5('TUnblockRemoteCommand error! ' + e.Message);
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
end; // TUnblockRemoteCommand.Execute


end.
