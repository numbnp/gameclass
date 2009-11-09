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
  uTICommonInterface,
  uIPInformation,
  uGCTIOptions,
  uTIUtils,
  uGCTIConst;


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
begin
  with IPInformations.GetItemByIP(FstrClientIP) do begin
    ServerIP := FstrServerIP;
    Tarif := FstrTarifName;
    Enable;
    if ContainedExtraInfo then begin
      try
        TI.APISetUserState(ExtraInfo, 0, 2, OPERATOR_NAME, 'Разблокировка IP');
      except
        on E: Exception do begin
          Debug.Trace5('TUnblockRemoteCommand error! ' + e.Message);
        end;
      end;
    end else begin
      if not Options.Genaral.NoAddUsers.Value then
        TICreateMissingUsers;
    end;
  end;
end; // TUnblockRemoteCommand.Execute


end.
