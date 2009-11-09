//////////////////////////////////////////////////////////////////////////////
//
// TBlockRemoteCommand
//  ласс поступающих от управл€ющего сервера команд, которые требуют
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
  uTICommonInterface,
  uIPInformation,
  uGCTIOptions,
  uTIUtils,
  uGCTIConst;


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
begin
  with IPInformations.GetItemByIP(FstrClientIP) do begin
    Debug.Trace5('TBlockRemoteCommand:' + 'C:' + FstrClientIP + 'S:'
        + FstrServerIP);
    ServerIP := FstrServerIP;
    Disable;
    TotalBytesSent := 0;
    TotalBytesReceived := 0;
    CurrentBytesSent := 0;
    CurrentBytesReceived := 0;
    if ContainedExtraInfo then begin
      try
        TI.APISetUserState(ExtraInfo, -1, 0, OPERATOR_NAME, 'Ѕлокировка IP');
      except
        on E: Exception do begin
          Debug.Trace5('TBblockRemoteCommand error! ' + e.Message);
        end;
      end;
    end else begin
      if not Options.Genaral.NoAddUsers.Value then
        TICreateMissingUsers;
    end;
  end;
end; // TBlockRemoteCommand.Execute


end.
