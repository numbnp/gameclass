//////////////////////////////////////////////////////////////////////////////
//
// TBlockRemoteCommand
// Класс поступающих от управляющего сервера команд, которые требуют
// пересылки визуальной части клиента.
//
//
//////////////////////////////////////////////////////////////////////////////

unit uBlockRemoteCommand;

interface

uses
  // project units
  uRemoteCommand;

type

  //
  // TBlockRemoteCommand
  //

  TBlockRemoteCommand = class(TRemoteCommand)
  private
    // fields
    FstrClientIP: String;
    FstrServerIP: String;

  public
    // constructor / destructor
    constructor Create(); overload;
    constructor Create(const AstrClientIP: String;
        const AstrServerIP: String); overload;

    // public methods
    procedure Execute(); override;

    // properties
    property ServerIPAddress: String
        read FstrServerIP write FstrServerIP;

  end; // TBlockRemoteCommand


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

constructor TBlockRemoteCommand.Create();
begin
  ASSERT(FALSE,
      'TResendRemoteCommand.Create need AstrHostForResend parameter');
end; // TBlockRemoteCommand.Create

constructor TBlockRemoteCommand.Create(const AstrClientIP: String;
    const AstrServerIP: String);
begin
  inherited Create();

  FstrClientIP := AstrClientIP;
  FstrServerIP := AstrServerIP;
end; // TBlockRemoteCommand.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TBlockRemoteCommand.Execute();
var
  strErr: String;
  UG: TUGConfig;
begin
  UG := TUGConfig.Create(Options.Genaral.Path.Value,
      Options.Genaral.Name.Value,
      Options.Genaral.DecriptedPassword);
  if UG.Connected then begin
    with IPInformations.GetItemByIP(FstrClientIP) do begin
      Debug.Trace5('TBlockRemoteCommand:' + 'C:' + FstrClientIP + 'S:'
          + FstrServerIP);
      ServerIP := FstrServerIP;
      Disable;
      CurrentBytesSent := 0;
      CurrentBytesReceived := 0;
      if ContainedExtraInfo then begin
        try
          UGEnableUser(UG, FstrClientIP, False);
          UG.SetUserBalance(FstrClientIP, 0, False, strErr);
        except
          on E: Exception do begin
            Debug.Trace5('TBblockRemoteCommand error! ' + e.Message);
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
end; // TBlockRemoteCommand.Execute


end.
