//////////////////////////////////////////////////////////////////////////////
//
// Класс команды запроса настроек клиентского приложения.
//
//////////////////////////////////////////////////////////////////////////////

unit uOptionGetRemoteCommand;

interface

uses
  // project units
  uRemoteCommand;


type

  //
  // TOptionGetRemoteCommand
  //

  TOptionGetRemoteCommand = class(TRemoteCommand)
  private
    // fields
    FbLocalResend: Boolean; //локальная пересылка
    FstrHostForResend: String;
    FstrOptionName: String;

    // private helper methods
    procedure _SendOption(const AstrOptionName: String;
        const AstrOptionValue: String);

  public
    // constructor / destructor
    // локальная отсылка опций
    constructor Create(const AstrOptionName: String); overload;
    // отсылка опций на клиент
    constructor Create(const AstrOptionName: String;
        const AstrHostForResend: String); overload;

    // public methods
    procedure Execute(); override;

  end; // TOptionGetRemoteCommand


implementation

uses
  // system units
  SysUtils,
  Classes,
  // project units
{$IFDEF GC3SERVER}
  gccomputers,
  uAccountSystem,
{$ENDIF}
  uY2KCommon,
  uProtocol,
  uDebugLog,
  uClientOptions,
  uClientOptionsConst,
  uLocalCommandSender,
  uCommandSender;


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// TOptionGetRemoteCommand.Create

constructor TOptionGetRemoteCommand.Create(const AstrOptionName: String);
begin
  inherited Create();

  FbLocalResend := True;
  FstrOptionName := AstrOptionName;

end; // TOptionGetRemoteCommand.Create

constructor TOptionGetRemoteCommand.Create(const AstrOptionName: String;
    const AstrHostForResend: String);
begin
  inherited Create();

  FbLocalResend := False;
  FstrHostForResend := AstrHostForResend;
  FstrOptionName := AstrOptionName;

end; // TOptionGetRemoteCommand.Create

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TOptionGetRemoteCommand.Execute();
var
  bAll: Boolean;
  strDefaultBlock: String;
  lstTarifNames: TStringList;
begin
  bAll := False;
  if CompareText(FstrOptionName,'All') = 0 then
    bAll := True;

  if bAll or (CompareText(FstrOptionName,'CompNumber') = 0) then
{$IFDEF GC3SERVER}
    _SendOption('CompNumber',
        Comps[ComputersGetIndexByIp(FstrHostForResend)].GetStrNumber);
{$ELSE}
    _SendOption('CompNumber', GClientOptions.CompNumber);
{$ENDIF}
  if bAll or (CompareText(FstrOptionName,'DefaultBlock') = 0) then begin
    strDefaultBlock := '';
    if GClientOptions.BlockKeyboard then
      strDefaultBlock := strDefaultBlock + 'k';
    if GClientOptions.BlockMouse then
      strDefaultBlock := strDefaultBlock + 'm';
    if GClientOptions.BlockTasks then
      strDefaultBlock := strDefaultBlock + 't';
    if GClientOptions.BlockDisplay then
      strDefaultBlock := strDefaultBlock + 'd';
    _SendOption('DefaultBlock', strDefaultBlock);
  end;

  if bAll or (CompareText(FstrOptionName,'BlockDisplayByStandby') = 0) then
    _SendOption('BlockDisplayByStandby',
        BoolToStr(GClientOptions.BlockDisplayByStandby));

  if bAll or (CompareText(FstrOptionName,'StartBlock') = 0) then
    _SendOption('StartBlock', BoolToStr(GClientOptions.StartBlock));

  if bAll or (CompareText(FstrOptionName,'StartBlockSec') = 0) then
    _SendOption('StartBlockSec', IntToStr(GClientOptions.StartBlockSec));

  if bAll or (CompareText(FstrOptionName,'OfflineBlock') = 0) then
    _SendOption('OfflineBlock', BoolToStr(GClientOptions.OfflineBlock));

  if bAll or (CompareText(FstrOptionName,'OfflineBlockType') = 0) then
    case GClientOptions.OfflineBlockType of
      OfflineBlockType_Immediately: _SendOption('OfflineBlockType',
          'Immediately');
      OfflineBlockType_AfterSessionStop: _SendOption('OfflineBlockType',
          'AfterSessionStop');
    end;

  if bAll or (CompareText(FstrOptionName,
      'OfflineBlockTypeImmediatelyMin') = 0) then
    _SendOption('OfflineBlockTypeImmediatelyMin',
        IntToStr(GClientOptions.OfflineBlockTypeImmediatelyMin));

  if bAll or (CompareText(FstrOptionName,'UnblockPassword') = 0) then
    _SendOption('UnblockPassword', BoolToStr(GClientOptions.UnblockPassword));

  if bAll or (CompareText(FstrOptionName,'UnblockPasswordHash') = 0) then
    _SendOption('UnblockPasswordHash', GClientOptions.UnblockPasswordHash);

  if bAll or (CompareText(FstrOptionName,'AutoLogoff') = 0) then
    _SendOption('AutoLogoff', BoolToStr(GClientOptions.AutoLogoff));

  if bAll or (CompareText(FstrOptionName,'AutoLogoffSec') = 0) then
    _SendOption('AutoLogoffSec', IntToStr(GClientOptions.AutoLogoffSec));

  if bAll or (CompareText(FstrOptionName,'AfterStop') = 0) then
    _SendOption('AfterStop', BoolToStr(GClientOptions.AfterStop));

  if bAll or (CompareText(FstrOptionName,'AfterStopSec') = 0) then
    _SendOption('AfterStopSec', IntToStr(GClientOptions.AfterStopSec));

  if bAll or (CompareText(FstrOptionName,'AfterStopType') = 0) then
  case GClientOptions.AfterStopType of
    AfterStopType_KillTask: _SendOption('AfterStopType', 'KillTask');
    AfterStopType_Logoff: _SendOption('AfterStopType', 'Logoff');
    AfterStopType_Restart: _SendOption('AfterStopType', 'Restart');
    AfterStopType_Shutdown: _SendOption('AfterStopType', 'Shutdown');
  end;

  if bAll or (CompareText(FstrOptionName,'RunPadShowInfoOnDesktop') = 0) then
    _SendOption('RunPadShowInfoOnDesktop', BoolToStr(GClientOptions.RunPadShowInfoOnDesktop));

  if bAll or (CompareText(FstrOptionName,'RunPadShowInfoOnDesktopText') = 0) then
    _SendOption('RunPadShowInfoOnDesktopText', GClientOptions.RunPadShowInfoOnDesktopText);

  if bAll or (CompareText(FstrOptionName,'SyncTime') = 0) then
    _SendOption('SyncTime', BoolToStr(GClientOptions.SyncTime));

  if bAll or (CompareText(FstrOptionName,'ShellMode') = 0) then
    case GClientOptions.ShellMode of
      ShellMode_Runpad:  _SendOption('ShellMode', 'Runpad');
      ShellMode_Unknown: _SendOption('ShellMode', 'Unknown');
    end;

  if bAll or (CompareText(FstrOptionName,'UseSounds') = 0) then
    _SendOption('UseSounds', BoolToStr(GClientOptions.UseSounds));

  if bAll or (CompareText(FstrOptionName,'UseBaloons') = 0) then
    _SendOption('UseBaloons', BoolToStr(GClientOptions.UseBaloons));

  if bAll or (CompareText(FstrOptionName,'UseTextMessage') = 0) then
    _SendOption('UseTextMessage', BoolToStr(GClientOptions.UseTextMessage));

  if bAll or (CompareText(FstrOptionName,'UseTextMessageBlinking') = 0) then
    _SendOption('UseTextMessageBlinking',
        BoolToStr(GClientOptions.UseTextMessageBlinking));

  if bAll or (CompareText(FstrOptionName,'UseTextMessageMin') = 0) then
    _SendOption('UseTextMessageMin', IntToStr(GClientOptions.UseTextMessageMin));

  if bAll or (CompareText(FstrOptionName,'URLCompFree') = 0) then
    _SendOption('URLCompFree', GClientOptions.URLCompFree);

  if bAll or (CompareText(FstrOptionName,'URLLogonCompFree') = 0) then
    _SendOption('URLLogonCompFree', GClientOptions.URLLogonCompFree);

  if bAll or (CompareText(FstrOptionName,'URLTop') = 0) then
    _SendOption('URLTop', GClientOptions.URLTop);

  if bAll or (CompareText(FstrOptionName,'URLAccount') = 0) then
    _SendOption('URLAccount', GClientOptions.URLLogonHelp);

  if bAll or (CompareText(FstrOptionName,'URLAgreement') = 0) then
    _SendOption('URLAgreement', GClientOptions.URLAgreement);

  if bAll or (CompareText(FstrOptionName,'Agreement') = 0) then
    _SendOption('Agreement', BoolToStr(GClientOptions.Agreement));

  if bAll or (CompareText(FstrOptionName,'AllowCardsSupport') = 0) then begin
{$IFDEF GC3SERVER}
    _SendOption('AllowCardsSupport', BoolToStr(GAccountSystem.Enabled));
{$ELSE}
    _SendOption('AllowCardsSupport', BoolToStr(GClientOptions.AllowCardsSupport));
{$ENDIF}
  end;

  if bAll or (CompareText(FstrOptionName,'Language') = 0) then
    _SendOption('Language', IntToStr(GClientOptions.Language));

  if bAll or (CompareText(FstrOptionName,'TarifNames') = 0) then begin
{$IFDEF GC3SERVER}
  lstTarifNames := GetTarifNames;
  if lstTarifNames <> Nil then
    GClientOptions.TarifNames := lstTarifNames
  else
    GClientOptions.TarifNames.Text := '';
{$ENDIF}
    _SendOption('TarifNames', GClientOptions.TarifNames.Text);
  end;

  if bAll or (CompareText(FstrOptionName,'ShowSmallInfo') = 0) then
    _SendOption('ShowSmallInfo', BoolToStr(GClientOptions.ShowSmallInfo));

  if bAll or (CompareText(FstrOptionName,'RunPadHideTabs') = 0) then
    _SendOption('RunPadHideTabs',
        BoolToStr(GClientOptions.RunPadHideTabs));

  if bAll or (CompareText(FstrOptionName,'RunPadTabs') = 0) then
    _SendOption('RunPadTabs', GClientOptions.RunPadTabs.Text);

  if bAll or (CompareText(FstrOptionName,'RunPadInternetControl') = 0) then
    _SendOption('RunPadInternetControl',
        BoolToStr(GClientOptions.RunPadInternetControl));

  if bAll or (CompareText(FstrOptionName,'ClientScriptFileName') = 0) then
    _SendOption('ClientScriptFileName', GClientOptions.ClientScriptFileName);

  if bAll or (CompareText(FstrOptionName,'ClientScript') = 0) then
    _SendOption('ClientScript', BoolToStr(GClientOptions.ClientScript));

  if bAll or (CompareText(FstrOptionName,'ClientScriptHideWindow') = 0) then
    _SendOption('ClientScriptHideWindow',
        BoolToStr(GClientOptions.ClientScriptHideWindow));

  if bAll or (CompareText(FstrOptionName,'RestoreClientInfo') = 0) then
    _SendOption('RestoreClientInfo',
        BoolToStr(GClientOptions.RestoreClientInfo));

 { if bAll or (CompareText(FstrOptionName,'AutoInstall') = 0) then
    _SendOption('AutoInstall',
        BoolToStr(GClientOptions.AutoInstall));}

  if bAll or (CompareText(FstrOptionName,'TaskList') = 0) then
    _SendOption('TaskList', GClientOptions.TaskList.Text);

  if bAll or (CompareText(FstrOptionName,'TaskKillMode') = 0) then
    _SendOption('TaskKillMode', IntToStr(Integer(GClientOptions.TaskKillMode)));

  if bAll or (CompareText(FstrOptionName,'GuestSession') = 0) then
    _SendOption('GuestSession', BoolToStr(GClientOptions.GuestSession));

  if bAll or (CompareText(FstrOptionName,'ShutdownButton') = 0) then
    _SendOption('ShutdownButton', IntToStr(GClientOptions.ShutdownButton));


  if bAll or (CompareText(FstrOptionName,'DebugLog') = 0) then
    _SendOption('DebugLog', BoolToStr(GClientOptions.DebugLog));

end; // TOptionGetRemoteCommand.Execute


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private helpers methods

procedure TOptionGetRemoteCommand._SendOption(const AstrOptionName: String;
    const AstrOptionValue: String);
begin
{$IFDEF GC3SERVER}
    SendDataTo(FstrHostForResend, STR_CMD_OPTION_SET + '='
      + AstrOptionName + '/' + AstrOptionValue, False);
{$ELSE}
{$IFDEF MSWINDOWS}
    LocalSendDataTo(STR_CMD_OPTION_SET + '=' + AstrOptionName + '/'
      + AstrOptionValue);
{$ENDIF}
{$ENDIF}
end; // TOptionGetRemoteCommand._OptionNameIs


end. ////////////////////////// end of file //////////////////////////////////
