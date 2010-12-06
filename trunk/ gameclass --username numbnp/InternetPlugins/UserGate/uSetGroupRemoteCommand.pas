//////////////////////////////////////////////////////////////////////////////
//
// TSetGroupRemoteCommand
// Класс поступающих от управляющего сервера команд, которые требуют
// пересылки визуальной части клиента.
//
//
//////////////////////////////////////////////////////////////////////////////

unit uSetGroupRemoteCommand;

interface

uses
  // project units
  uRemoteCommand;

type

  //
  // TSetGroupRemoteCommand
  //

  TSetGroupRemoteCommand = class(TRemoteCommand)
  private
    // fields
    FstrClientIP: String;
    FstrServerIP: String;
    FstrGroup: String;

  public
    // constructor / destructor
    constructor Create(); overload;
    constructor Create(const AstrClientIP: String;
        const AstrGroup: String; const AstrServerIP: String); overload;

    // public methods
    procedure Execute(); override;

    // properties
    property ServerIPAddress: String
        read FstrServerIP write FstrServerIP;

  end; // TSetGroupRemoteCommand


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

constructor TSetGroupRemoteCommand.Create();
begin
  ASSERT(FALSE,
      'TResendRemoteCommand.Create need AstrHostForResend parameter');
end; // TSetGroupRemoteCommand.Create

constructor TSetGroupRemoteCommand.Create(const AstrClientIP: String;
    const AstrGroup: String; const AstrServerIP: String);
begin
  inherited Create();

  FstrClientIP := AstrClientIP;
  FstrGroup := AstrGroup;
  FstrServerIP := AstrServerIP;
end; // TSetGroupRemoteCommand.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TSetGroupRemoteCommand.Execute();
var
  UG: TUGConfig;
begin
  UG := TUGConfig.Create(Options.Genaral.Path.Value,
      Options.Genaral.Name.Value,
      Options.Genaral.DecriptedPassword);
  if UG.Connected then begin
    with IPInformations.GetItemByIP(FstrClientIP) do begin
      ServerIP := FstrServerIP;
      Group := FstrGroup;
      if ContainedExtraInfo then begin
        try
          UGSetGroup(UG, FstrClientIP, FstrGroup);
        except
          on E: Exception do begin
            Debug.Trace5('TSetGroupRemoteCommand error! ' + e.Message);
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
end; // TSetGroupRemoteCommand.Execute


end.
