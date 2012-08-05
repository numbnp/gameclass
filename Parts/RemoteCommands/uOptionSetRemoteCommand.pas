//////////////////////////////////////////////////////////////////////////////
//
// Класс команды установки настроек клиентского приложения.
//
//////////////////////////////////////////////////////////////////////////////

unit uOptionSetRemoteCommand;

interface

uses
  // project units
  uClientOptions,
  uRemoteCommand;


type

  //
  // TOptionSetRemoteCommand
  //

  TOptionSetRemoteCommand = class(TRemoteCommand)
  private
    // fields
    FstrOptionName: String;
    FstrOptionValue: String;

  public
    // constructor / destructor
    constructor Create(const AstrOptionName: String;
        const AstrOptionValue: String);

    // public methods
    procedure Execute(); override;

  end; // TOptionSetRemoteCommand


implementation

uses
  // system units
  SysUtils,
  // project units
{$IFDEF LINUX}
  uSafeStorage,
{$ENDIF}
  uY2KCommon,
  uProtocol,
  uClientOptionsConst,
  uDebugLog,
  uTaskKillConst;


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// TOptionSetRemoteCommand.Create

constructor TOptionSetRemoteCommand.Create(const AstrOptionName: String;
    const AstrOptionValue: String);
begin
  inherited Create();

  FstrOptionName := AstrOptionName;
  FstrOptionValue := AstrOptionValue;

end; // TOptionSetRemoteCommand.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TOptionSetRemoteCommand.Execute();
begin
try
  if CompareText(FstrOptionName,'CompNumber') = 0 then begin
    GClientOptions.CompNumber := FstrOptionValue;

  end else if CompareText(FstrOptionName,'DefaultBlock') = 0 then begin
    GClientOptions.BlockKeyboard := (Pos('k',FstrOptionValue) <> 0);
    GClientOptions.BlockMouse := (Pos('m',FstrOptionValue) <> 0);
    GClientOptions.BlockTasks := (Pos('t',FstrOptionValue) <> 0);
    GClientOptions.BlockDisplay := (Pos('d',FstrOptionValue) <> 0);

  end else if CompareText(FstrOptionName,'BlockDisplayByStandby') = 0 then begin
    GClientOptions.BlockDisplayByStandby := StrToBool(FstrOptionValue);

  end else if CompareText(FstrOptionName,'StartBlock') = 0 then begin
    GClientOptions.StartBlock := StrToBool(FstrOptionValue);

  end else if CompareText(FstrOptionName,'StartBlockSec') = 0 then begin
    GClientOptions.StartBlockSec := StrToInt(FstrOptionValue);

  end else if CompareText(FstrOptionName,'OfflineBlock') = 0 then begin
    GClientOptions.OfflineBlock := StrToBool(FstrOptionValue);

  end else if CompareText(FstrOptionName,'OfflineBlockType') = 0 then begin
    if CompareText(FstrOptionValue,'Immediately') = 0  then
      GClientOptions.OfflineBlockType := OfflineBlockType_Immediately
    else if CompareText(FstrOptionValue,'AfterSessionStop') = 0  then
      GClientOptions.OfflineBlockType := OfflineBlockType_AfterSessionStop;

  end else if CompareText(FstrOptionName,
      'OfflineBlockTypeImmediatelyMin') = 0 then begin
    GClientOptions.OfflineBlockTypeImmediatelyMin := StrToInt(FstrOptionValue);

  end else if CompareText(FstrOptionName,'UnblockPassword') = 0 then begin
    GClientOptions.UnblockPassword := StrToBool(FstrOptionValue);

  end else if CompareText(FstrOptionName,'UnblockPasswordHash') = 0 then begin
    GClientOptions.UnblockPasswordHash := FstrOptionValue;

  end else if CompareText(FstrOptionName,'AutoLogoff') = 0 then begin
    GClientOptions.AutoLogoff := StrToBool(FstrOptionValue);

  end else if CompareText(FstrOptionName,'AutoLogoffSec') = 0 then begin
    GClientOptions.AutoLogoffSec := StrToInt(FstrOptionValue);

  end else if CompareText(FstrOptionName,'AfterStop') = 0 then begin
    GClientOptions.AfterStop := StrToBool(FstrOptionValue);

  end else if CompareText(FstrOptionName,'AfterStopSec') = 0 then begin
    GClientOptions.AfterStopSec := StrToInt(FstrOptionValue);

  end else if CompareText(FstrOptionName,'AfterStopType') = 0 then begin
    if CompareText(FstrOptionValue,'KillTask') = 0  then
      GClientOptions.AfterStopType := AfterStopType_KillTask
    else if CompareText(FstrOptionValue,'Logoff') = 0  then
      GClientOptions.AfterStopType := AfterStopType_Logoff
    else if CompareText(FstrOptionValue,'Restart') = 0  then
      GClientOptions.AfterStopType := AfterStopType_Restart
    else if CompareText(FstrOptionValue,'Shutdown') = 0  then
      GClientOptions.AfterStopType := AfterStopType_Shutdown;

  end else if CompareText(FstrOptionName,'SyncTime') = 0 then begin
    GClientOptions.SyncTime := StrToBool(FstrOptionValue);

  end else if CompareText(FstrOptionName,'ShellMode') = 0 then begin
    if CompareText(FstrOptionValue,'Runpad') = 0  then
      GClientOptions.ShellMode := ShellMode_Runpad
    else if CompareText(FstrOptionValue,'Unknown') = 0  then
      GClientOptions.ShellMode := ShellMode_Unknown;

  end else if CompareText(FstrOptionName,'UseSounds') = 0 then begin
    GClientOptions.UseSounds := StrToBool(FstrOptionValue);

  end else if CompareText(FstrOptionName,'UseBaloons') = 0 then begin
    GClientOptions.UseBaloons := StrToBool(FstrOptionValue);

  end else if CompareText(FstrOptionName,'UseTextMessage') = 0 then begin
    GClientOptions.UseTextMessage := StrToBool(FstrOptionValue);

  end else if CompareText(FstrOptionName,'UseTextMessageBlinking') = 0
      then begin
    GClientOptions.UseTextMessageBlinking := StrToBool(FstrOptionValue);

  end else if CompareText(FstrOptionName,'UseTextMessageMin') = 0 then begin
    GClientOptions.UseTextMessageMin := StrToInt(FstrOptionValue);

  end else if CompareText(FstrOptionName,'URLCompFree') = 0 then begin
    GClientOptions.URLCompFree := FstrOptionValue;

  end else if CompareText(FstrOptionName,'URLLogonCompFree') = 0 then begin
    GClientOptions.URLLogonCompFree := FstrOptionValue;

  end else if CompareText(FstrOptionName,'URLTop') = 0 then begin
    GClientOptions.URLTop := FstrOptionValue;

  end else if CompareText(FstrOptionName,'URLAccount') = 0 then begin
    GClientOptions.URLLogonHelp := FstrOptionValue;

  end else if CompareText(FstrOptionName,'URLAgreement') = 0 then begin
    GClientOptions.URLAgreement := FstrOptionValue;

  end else if CompareText(FstrOptionName,'Agreement') = 0 then begin
    GClientOptions.Agreement:= StrToBool(FstrOptionValue);

  end else if CompareText(FstrOptionName,'AllowCardsSupport') = 0 then begin
    GClientOptions.AllowCardsSupport:= StrToBool(FstrOptionValue);

  end else if CompareText(FstrOptionName,'Language') = 0 then begin
    GClientOptions.Language:= StrToInt(FstrOptionValue);

  end else if CompareText(FstrOptionName,'TarifNames') = 0 then begin
    GClientOptions.SetTarifNamesAsText(FstrOptionValue);

  end else if CompareText(FstrOptionName,'ShowSmallInfo') = 0 then begin
    GClientOptions.ShowSmallInfo:= StrToBool(FstrOptionValue);

  end else if CompareText(FstrOptionName,'RunPadHideTabs') = 0 then begin
    GClientOptions.RunPadHideTabs:= StrToBool(FstrOptionValue);

  end else if CompareText(FstrOptionName,'RunPadTabs') = 0 then begin
    GClientOptions.SetRunPadTabsAsText(FstrOptionValue);

  end else if CompareText(FstrOptionName,'RunPadInternetControl') = 0 then begin
    GClientOptions.RunPadInternetControl:= StrToBool(FstrOptionValue);

  end else if CompareText(FstrOptionName,'RunPadShowInfoOnDesktop') = 0 then begin
    GClientOptions.RunPadShowInfoOnDesktop:= StrToBool(FstrOptionValue);

  end else if CompareText(FstrOptionName,'RunPadShowInfoOnDesktopText') = 0 then begin
    GClientOptions.RunPadShowInfoOnDesktopText:= FstrOptionValue;

  end else if CompareText(FstrOptionName,'RunPadMonitorOff') = 0 then begin
    GClientOptions.RunPadMonitorOff := StrToBool(FstrOptionValue);

  end else if CompareText(FstrOptionName,'RunPadLockStation') = 0 then begin
    GClientOptions.RunPadLockStation := StrToBool(FstrOptionValue);

  end else if CompareText(FstrOptionName,'ClientScriptFileName') = 0 then begin
    GClientOptions.ClientScriptFileName := FstrOptionValue;

  end else if CompareText(FstrOptionName,'ClientScript') = 0 then begin
    GClientOptions.ClientScript := StrToBool(FstrOptionValue);

  end else if CompareText(FstrOptionName,'ClientScriptHideWindow') = 0 then begin
    GClientOptions.ClientScriptHideWindow := StrToBool(FstrOptionValue);

  end else if CompareText(FstrOptionName,'RestoreClientInfo') = 0
      then begin GClientOptions.RestoreClientInfo := StrToBool(FstrOptionValue);

  end else if CompareText(FstrOptionName,'TaskList') = 0 then begin
    GClientOptions.SetTaskListAsText(FstrOptionValue);

  end else if CompareText(FstrOptionName,'TaskKillMode') = 0 then begin
    GClientOptions.TaskKillMode := TTaskKillMode(StrToInt(FstrOptionValue));

  end else if CompareText(FstrOptionName,'GuestSession') = 0
      then begin
    GClientOptions.GuestSession := StrToBool(FstrOptionValue);

  end else if CompareText(FstrOptionName,'ShutdownButton') = 0
      then begin
    GClientOptions.ShutdownButton := StrToIntDef(FstrOptionValue,-1);


  end else if CompareText(FstrOptionName,'ServerVersion') = 0
      then begin
{$IFDEF LINUX}
    TSafeStorage.Instance().Push(ThreadSafeOperation_OldServerWarning,
        Integer(FormAction_Hide));
{$ENDIF}

  end else if CompareText(FstrOptionName,'DebugLog') = 0 then begin
    GClientOptions.DebugLog := StrToBool(FstrOptionValue);

  end else begin
    ASSERT(FALSE, 'Option Set error! Unknown option type.');
  end;

  GClientOptions.Save();
except
  on e: Exception do begin
    Debug.Trace0(
      'TOptionSetRemoteCommand.Execute error! ' + e.Message);
  end;
end;
end; // TOptionSetRemoteCommand.Execute

end. ////////////////////////// end of file //////////////////////////////////
