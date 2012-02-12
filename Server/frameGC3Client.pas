unit frameGC3Client;

interface

uses
  GCConst, GCLangUtils, uProtocol, GCComputers, GCCommon,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, ComCtrls, StdCtrls,
  ExtCtrls, frmInstallLogin, Mask, ToolEdit;

type
  TframGC3Client = class(TFrame)
    gbBlocking: TGroupBox;
    cbxKeyboard: TCheckBox;
    cbxMouse: TCheckBox;
    cbxTasks: TCheckBox;
    cbxSyncTime: TCheckBox;
    cbxDisplay: TCheckBox;
    lblSec3: TLabel;
    edtAfterStopSec: TEdit;
    GroupBox1: TPanel;
    edtStartBlockSec: TEdit;
    cbxStartBlock: TCheckBox;
    rbtnStartBlockTime: TRadioButton;
    rbtnStartBlockPermanently: TRadioButton;
    GroupBox2: TPanel;
    rbtnOfflineBlockType_Immediately: TRadioButton;
    rbtnOfflineBlockType_AfterSessionStop: TRadioButton;
    cbxOfflineBlock: TCheckBox;
    lblSec2: TLabel;
    gbBlockAction: TGroupBox;
    cbxUnblockPassword: TCheckBox;
    edtUnblockPassword: TEdit;
    cbxAfterStop: TCheckBox;
    gbSessionStop: TGroupBox;
    rbtnAfterStopType_KillTask: TRadioButton;
    rbtnAfterStopType_Logoff: TRadioButton;
    rbtnAfterStopType_Restart: TRadioButton;
    rbtnAfterStopType_Shutdown: TRadioButton;
    pnlTop1: TPanel;
    pnlTop2: TPanel;
    gbOther: TGroupBox;
    pnlTop1Left: TPanel;
    editOfflineBlock: TEdit;
    lblMin: TLabel;
    GroupBox3: TGroupBox;
    cbxRestoreClientInfo: TCheckBox;
    pnlTop2Right: TPanel;
    gbSessionScript: TGroupBox;
    cbxAutoInstall: TCheckBox;
    editInstallPath: TFilenameEdit;
    gbShell: TGroupBox;
    pnlTop2RightTop: TPanel;
    rbtnShellMode_Runpad: TRadioButton;
    rbtnShellMode_Unknown: TRadioButton;
    cbxTaskKillBeforeStart: TCheckBox;
    pnlBottom: TPanel;
    lblDistribPath: TLabel;
    cbxUseWOL: TCheckBox;
    cbShowSummOnClient: TCheckBox;
    procedure cbxKeyboardClick(Sender: TObject);
    procedure cbxMouseClick(Sender: TObject);
    procedure cbxTasksClick(Sender: TObject);
    procedure cbxSyncTimeClick(Sender: TObject);
    procedure cbxDisplayClick(Sender: TObject);
    procedure edtAfterStopSecChange(Sender: TObject);
    procedure cbxUnblockPasswordClick(Sender: TObject);
    procedure edtUnblockPasswordExit(Sender: TObject);
    procedure edtStartBlockSecChange(Sender: TObject);
    procedure cbxStartBlockClick(Sender: TObject);
    procedure rbtnStartBlockTimeClick(Sender: TObject);
    procedure rbtnStartBlockPermanentlyClick(Sender: TObject);
    procedure cbxOfflineBlockClick(Sender: TObject);
    procedure rbtnOfflineBlockType_AfterSessionStopClick(Sender: TObject);
    procedure rbtnOfflineBlockType_ImmediatelyClick(Sender: TObject);
    procedure cbxAfterStopClick(Sender: TObject);
    procedure rbtnAfterStopType_KillTaskClick(Sender: TObject);
    procedure rbtnAfterStopType_LogoffClick(Sender: TObject);
    procedure rbtnAfterStopType_RestartClick(Sender: TObject);
    procedure rbtnAfterStopType_ShutdownClick(Sender: TObject);
    procedure rbtnShellMode_RunpadClick(Sender: TObject);
    procedure rbtnShellMode_UnknownClick(Sender: TObject);
    procedure edtUnblockPasswordChange(Sender: TObject);
    procedure edtUnblockPasswordEnter(Sender: TObject);
    procedure editOfflineBlockChange(Sender: TObject);
    procedure cbxRestoreClientInfoClick(Sender: TObject);
    procedure editInstallPathChange(Sender: TObject);
    procedure cbxAutoInstallClick(Sender: TObject);
    procedure cbxTaskKillBeforeStartClick(Sender: TObject);
    procedure cbxUseWOLClick(Sender: TObject);
    procedure cbShowSummOnClientClick(Sender: TObject);
  private
    { Private declarations }
//    FbUnblockPasswordNotChanged: Boolean;
    procedure ResetFrame;
    procedure DoDesign;
    // private helper methods
//    procedure _BeforeControlDataChange;
    procedure _AfterControlDataChange(const AbDoDesign: Boolean = False);

  public
    procedure Save;
    function GetID: integer;
    procedure Activate(ID: integer);
    { Public declarations }
  end;

implementation
{$R *.dfm}
uses
  uClientOptions,
  uClientOptionsConst,
  uCoder,
  uRegistry, uRegistryClient;

var
   GbFormGC3ClientLock: Boolean = False;

procedure TframGC3Client.Save;
begin
  GClientOptions.Save;
end;

function TframGC3Client.GetID: integer;
begin
  GetID := FRAME_GC3CLIENT;
end;

procedure TframGC3Client.DoDesign;
begin
  GbFormGC3ClientLock := True;
  // Блокировка
  cbxKeyboard.Checked := GClientOptions.BlockKeyboard;
  cbxMouse.Checked := GClientOptions.BlockMouse;
  cbxTasks.Checked := GClientOptions.BLockTasks;
  cbxDisplay.Checked := GClientOptions.BlockDisplay;
  cbxUnblockPassword.Checked := GClientOptions.UnblockPassword;
  edtUnblockPassword.Enabled := GClientOptions.UnblockPassword;
//  FbUnblockPasswordNotChanged := True;
  if (Length(GClientOptions.UnblockPasswordHash) > 0) then
    edtUnblockPassword.Text := '12345678912345678912'
  else
    edtUnblockPassword.Text := '';


  // Блокировки срабатывают
  cbxStartBlock.Checked := GClientOptions.StartBlock;
  rbtnStartBlockTime.Enabled := GClientOptions.StartBlock;
  rbtnStartBlockPermanently.Enabled := GClientOptions.StartBlock;
  lblSec2.Enabled := GClientOptions.StartBlock;
  if GClientOptions.StartBlock then begin
    rbtnStartBlockPermanently.Checked := (GClientOptions.StartBlockSec = 0);
    rbtnStartBlockTime.Checked := (GClientOptions.StartBlockSec <> 0);
    edtStartBlockSec.Enabled := (GClientOptions.StartBlockSec <> 0);
    edtStartBlockSec.Text := IntToStr(GClientOptions.StartBlockSec);
  end else
    edtStartBlockSec.Enabled := False;
  cbxOfflineBlock.Checked := GClientOptions.OfflineBlock;
  rbtnOfflineBlockType_Immediately.Enabled := GClientOptions.OfflineBlock;
  editOfflineBlock.Enabled := GClientOptions.OfflineBlock
      and (GClientOptions.OfflineBlockType = OfflineBlockType_Immediately);
  rbtnOfflineBlockType_AfterSessionStop.Enabled := GClientOptions.OfflineBlock;
  if GClientOptions.OfflineBlock then begin
    case GClientOptions.OfflineBlockType of
      OfflineBlockType_Immediately:
            rbtnOfflineBlockType_Immediately.Checked := True;
      OfflineBlockType_AfterSessionStop:
            rbtnOfflineBlockType_AfterSessionStop.Checked := True;
    end;
    editOfflineBlock.Text :=
        IntToStr(GClientOptions.OfflineBlockTypeImmediatelyMin);
  end;

  // Завершение сеанса
  cbxAfterStop.Checked := GClientOptions.AfterStop;
  edtAfterStopSec.Enabled := GClientOptions.AfterStop;
  edtAfterStopSec.Text := IntToStr(GClientOptions.AfterStopSec);
  rbtnAfterStopType_KillTask.Enabled := GClientOptions.AfterStop;
  rbtnAfterStopType_Logoff.Enabled := GClientOptions.AfterStop;
  rbtnAfterStopType_Restart.Enabled := GClientOptions.AfterStop;
  rbtnAfterStopType_Shutdown.Enabled := GClientOptions.AfterStop;
  if GClientOptions.AfterStop then
    case GClientOptions.AfterStopType of
      AfterStopType_KillTask:  rbtnAfterStopType_KillTask.Checked := True;
      AfterStopType_Logoff:  rbtnAfterStopType_Logoff.Checked := True;
      AfterStopType_Restart:  rbtnAfterStopType_Restart.Checked := True;
      AfterStopType_Shutdown:  rbtnAfterStopType_Shutdown.Checked := True;
    end;

  // Other
  case GClientOptions.ShellMode of
    ShellMode_Unknown: rbtnShellMode_Unknown.Checked := True;
    ShellMode_Runpad: rbtnShellMode_Runpad.Checked := True;
  end;
  cbxSyncTime.Checked := GClientOptions.SyncTime;
  cbxRestoreClientInfo.Checked := GClientOptions.RestoreClientInfo;
  editInstallPath.FileName := GRegistry.Options.InstallPath;
  cbxAutoInstall.Checked := GRegistry.Options.AutoInstall;
  cbxTaskKillBeforeStart.Checked := GRegistry.Client.TaskKillBeforeStart;
  cbxUseWOL.Checked := GRegistry.Client.UseWOL;
  cbShowSummOnClient.Checked := GRegistry.Client.ShowSumm; 
  GbFormGC3ClientLock := False;
end;

// процедура ставит все контролы в исходные позиции
procedure TframGC3Client.ResetFrame;
begin
//  optClientLoad;
  GClientOptions.Load;
  DoDesign;
end;

procedure TframGC3Client.Activate(ID: integer);
begin
  Visible := (GetID = ID);
  if (not Visible) then exit;
  ResetFrame;

  gbBlocking.Caption := translate('gbBlocking');
  gbBlockAction.Caption := translate('gbBlockAction');
  gbSessionStop.Caption := translate('gbSessionStop');
  gbOther.Caption := translate('gbOther');

  cbxKeyboard.Caption := translate('Keyboard');
  cbxMouse.Caption := translate('Mouse');
  cbxTasks.Caption := translate('MinimizeTasks');
  cbxDisplay.Caption := translate('cbScreenOff');
  cbxUnblockPassword.Caption := translate('cbxUnblockPassword');

  cbxStartBlock.Caption := translate('cbxStartBlock');
  rbtnStartBlockTime.Caption := translate('rbtnStartBlockTime');
  lblSec2.Caption := translate('lblSec');
  rbtnStartBlockPermanently.Caption := translate('rbtnStartBlockPermanently');
  cbxOfflineBlock.Caption := translate('cbxOfflineBlock');
  rbtnOfflineBlockType_Immediately.Caption := translate(
      'rbtnOfflineBlockType_Immediately');
  rbtnOfflineBlockType_AfterSessionStop.Caption := translate(
      'rbtnOfflineBlockType_AfterSessionStop');
  lblMin.Caption := translate('Minutes');

  cbxAfterStop.Caption := translate('cbxAfterStop');
  lblSec3.Caption := translate('lblSec');
  rbtnAfterStopType_KillTask.Caption := translate(
      'rbtnAfterStopType_KillTask');
  rbtnAfterStopType_Logoff.Caption := translate(
      'rbtnAfterStopType_Logoff');
  rbtnAfterStopType_Restart.Caption := translate(
      'rbtnAfterStopType_Restart');
  rbtnAfterStopType_Shutdown.Caption := translate(
      'rbtnAfterStopType_Shutdown');

//  lblShellCurrent.Caption := translate('lblShellCurrent');
  rbtnShellMode_Runpad.Caption := 'RunPad Shell';
  rbtnShellMode_Unknown.Caption := translate('ShellNoneOrUnknown');
  cbxSyncTime.Caption := translate('cbSyncTime');
end;

////////////////////////////////////////////////////////////////////////////////
// Блокировка
////////////////////////////////////////////////////////////////////////////////
procedure TframGC3Client.cbxKeyboardClick(Sender: TObject);
begin
  if GbFormGC3ClientLock then exit;  GbFormGC3ClientLock := True;;
  GClientOptions.BlockKeyboard := cbxKeyboard.Checked;
  _AfterControlDataChange;
end;

procedure TframGC3Client.cbxMouseClick(Sender: TObject);
begin
  if GbFormGC3ClientLock then exit;  GbFormGC3ClientLock := True;;
  GClientOptions.BlockMouse := cbxMouse.Checked;
  _AfterControlDataChange;
end;

procedure TframGC3Client.cbxTasksClick(Sender: TObject);
begin
  if GbFormGC3ClientLock then exit;  GbFormGC3ClientLock := True;;
  GClientOptions.BlockTasks := cbxTasks.Checked;
  _AfterControlDataChange;
end;

procedure TframGC3Client.cbxDisplayClick(Sender: TObject);
begin
  if GbFormGC3ClientLock then exit;  GbFormGC3ClientLock := True;;
  GClientOptions.BlockDisplay := cbxDisplay.Checked;
  _AfterControlDataChange;
end;


procedure TframGC3Client.cbxUnblockPasswordClick(Sender: TObject);
begin
  if GbFormGC3ClientLock then exit;  GbFormGC3ClientLock := True;;
   GClientOptions.UnblockPassword := cbxUnblockPassword.Checked;
  _AfterControlDataChange(True);
end;

procedure TframGC3Client.edtUnblockPasswordExit(Sender: TObject);
begin
  if GbFormGC3ClientLock then exit;
  GbFormGC3ClientLock := True;
  edtUnblockPassword.Text := '12345678912345678912';
//  FbUnblockPasswordNotChanged := False;
  GbFormGC3ClientLock := False;
end;

////////////////////////////////////////////////////////////////////////////////
//   Блокировки срабатывают
////////////////////////////////////////////////////////////////////////////////
procedure TframGC3Client.edtStartBlockSecChange(Sender: TObject);
begin
  if GbFormGC3ClientLock then exit;  GbFormGC3ClientLock := True;;
  GClientOptions.StartBlockSec := StrToIntDef(edtStartBlockSec.Text, 10);
  if (GClientOptions.StartBlockSec <= 0) then begin
    GClientOptions.StartBlockSec := 10;
    edtStartBlockSec.Text := '10';
  end;
  _AfterControlDataChange;
end;


procedure TframGC3Client.cbxStartBlockClick(Sender: TObject);
begin
  if GbFormGC3ClientLock then exit;  GbFormGC3ClientLock := True;;
  GClientOptions.StartBlock := cbxStartBlock.Checked;
  _AfterControlDataChange(True);
end;

procedure TframGC3Client.rbtnStartBlockTimeClick(Sender: TObject);
begin
  if GbFormGC3ClientLock then exit;  GbFormGC3ClientLock := True;;
  GClientOptions.StartBlockSec := StrToIntDef(edtStartBlockSec.Text, 10);
  if (GClientOptions.StartBlockSec <= 0) then begin
    GClientOptions.StartBlockSec := 10{DEF_START_BLOCK_SEC - это 0};
    edtStartBlockSec.Text := IntToStr(GClientOptions.StartBlockSec);
  end;
  _AfterControlDataChange(True);
end;

procedure TframGC3Client.rbtnStartBlockPermanentlyClick(Sender: TObject);
begin
  if GbFormGC3ClientLock then exit;  GbFormGC3ClientLock := True;;
  GClientOptions.StartBlockSec := 0;
  _AfterControlDataChange(True);
end;

procedure TframGC3Client.cbxOfflineBlockClick(Sender: TObject);
begin
  if GbFormGC3ClientLock then exit;  GbFormGC3ClientLock := True;;
  GClientOptions.OfflineBlock := cbxOfflineBlock.Checked;
  _AfterControlDataChange(True);
end;

procedure TframGC3Client.rbtnOfflineBlockType_AfterSessionStopClick(
  Sender: TObject);
begin
  if GbFormGC3ClientLock then exit;  GbFormGC3ClientLock := True;;
  GClientOptions.OfflineBlockType := OfflineBlockType_AfterSessionStop;
  editOfflineBlock.Enabled := False;
  _AfterControlDataChange;
end;


procedure TframGC3Client.rbtnOfflineBlockType_ImmediatelyClick(
  Sender: TObject);
begin
  if GbFormGC3ClientLock then exit;  GbFormGC3ClientLock := True;;
  GClientOptions.OfflineBlockType := OfflineBlockType_Immediately;
  editOfflineBlock.Enabled := True;
  _AfterControlDataChange;
end;

////////////////////////////////////////////////////////////////////////////////
//   Завершение сеанса
////////////////////////////////////////////////////////////////////////////////
procedure TframGC3Client.cbxAfterStopClick(Sender: TObject);
begin
  if GbFormGC3ClientLock then exit;  GbFormGC3ClientLock := True;;
  GClientOptions.AfterStop := cbxAfterStop.Checked;
  _AfterControlDataChange(True);
end;

procedure TframGC3Client.edtAfterStopSecChange(Sender: TObject);
begin
  if GbFormGC3ClientLock then exit;  GbFormGC3ClientLock := True;;
  GClientOptions.AfterStopSec := StrToIntDef(edtAfterStopSec.Text, 10);
  if (GClientOptions.AfterStopSec <= 0) then begin
    GClientOptions.AfterStopSec := DEF_AFTER_STOP_SEC;
    edtAfterStopSec.Text := IntToStr(GClientOptions.AfterStopSec);
  end;
   _AfterControlDataChange;
end;

procedure TframGC3Client.rbtnAfterStopType_KillTaskClick(Sender: TObject);
begin
  if GbFormGC3ClientLock then exit;  GbFormGC3ClientLock := True;;
  GClientOptions.AfterStopType := AfterStopType_KillTask;
  _AfterControlDataChange;
end;

procedure TframGC3Client.rbtnAfterStopType_LogoffClick(Sender: TObject);
begin
  if GbFormGC3ClientLock then exit;  GbFormGC3ClientLock := True;;
  GClientOptions.AfterStopType := AfterStopType_Logoff;
  _AfterControlDataChange;
end;

procedure TframGC3Client.rbtnAfterStopType_RestartClick(Sender: TObject);
begin
  if GbFormGC3ClientLock then exit;  GbFormGC3ClientLock := True;;
  GClientOptions.AfterStopType := AfterStopType_Restart;
  _AfterControlDataChange;
end;

procedure TframGC3Client.rbtnAfterStopType_ShutdownClick(Sender: TObject);
begin
  if GbFormGC3ClientLock then exit;  GbFormGC3ClientLock := True;;
  GClientOptions.AfterStopType := AfterStopType_Shutdown;
  _AfterControlDataChange;
end;

////////////////////////////////////////////////////////////////////////////////
//   Другое
////////////////////////////////////////////////////////////////////////////////

procedure TframGC3Client.rbtnShellMode_RunpadClick(Sender: TObject);
begin
  if GbFormGC3ClientLock then exit;  GbFormGC3ClientLock := True;;
  GClientOptions.ShellMode := ShellMode_Runpad;
  _AfterControlDataChange;
end;

procedure TframGC3Client.rbtnShellMode_UnknownClick(Sender: TObject);
begin
  if GbFormGC3ClientLock then exit;  GbFormGC3ClientLock := True;;
  GClientOptions.ShellMode := ShellMode_Unknown;
  _AfterControlDataChange;
end;

procedure TframGC3Client.cbxSyncTimeClick(Sender: TObject);
begin
  if GbFormGC3ClientLock then exit;  GbFormGC3ClientLock := True;;
   GClientOptions.SyncTime := cbxSyncTime.Checked;
  _AfterControlDataChange;
end;
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private helper methods

procedure TframGC3Client._AfterControlDataChange(const AbDoDesign: Boolean = False);
begin
  if AbDoDesign then
    DoDesign;
  GClientOptions.Save(True);
  GbFormGC3ClientLock := False;
end;

procedure TframGC3Client.edtUnblockPasswordChange(Sender: TObject);
var
  Fcoder : TCoder;
begin
  if GbFormGC3ClientLock then exit;
  GbFormGC3ClientLock := True;
  Fcoder := TCoder.Create;
  GClientOptions.UnblockPasswordHash :=
  FCoder.SimpleEncodeString(edtUnblockPassword.Text);
  _AfterControlDataChange;
  FCoder.Free;
  GbFormGC3ClientLock := False;
end;

procedure TframGC3Client.edtUnblockPasswordEnter(Sender: TObject);
begin
  edtUnblockPassword.Text := '';
end;

procedure TframGC3Client.editOfflineBlockChange(Sender: TObject);
begin
  if GbFormGC3ClientLock then exit;  GbFormGC3ClientLock := True;;
  GClientOptions.OfflineBlockTypeImmediatelyMin :=
      StrToIntDef(editOfflineBlock.Text, 10);
  if (GClientOptions.OfflineBlockTypeImmediatelyMin <= 0) then begin
    GClientOptions.OfflineBlockTypeImmediatelyMin := 0;
    editOfflineBlock.Text := '0';
  end;
  _AfterControlDataChange;
end;

procedure TframGC3Client.cbxRestoreClientInfoClick(Sender: TObject);
begin
  if GbFormGC3ClientLock then exit;  GbFormGC3ClientLock := True;;
   GClientOptions.RestoreClientInfo := cbxRestoreClientInfo.Checked;
  _AfterControlDataChange;
end;

procedure TframGC3Client.editInstallPathChange(Sender: TObject);
begin
  if GbFormGC3ClientLock then exit;  GbFormGC3ClientLock := True;;
  GRegistry.Options.InstallPath := editInstallPath.FileName;
  _AfterControlDataChange;
end;

procedure TframGC3Client.cbxAutoInstallClick(Sender: TObject);
begin
  if GbFormGC3ClientLock then exit;  GbFormGC3ClientLock := True;;
   GRegistry.Options.AutoInstall :=   cbxAutoInstall.Checked;
  _AfterControlDataChange(True);
end;

procedure TframGC3Client.cbxTaskKillBeforeStartClick(Sender: TObject);
begin
  if GbFormGC3ClientLock then exit;  GbFormGC3ClientLock := True;;
   GRegistry.Client.TaskKillBeforeStart := cbxTaskKillBeforeStart.Checked;
  _AfterControlDataChange;
end;

procedure TframGC3Client.cbxUseWOLClick(Sender: TObject);
begin
  if GbFormGC3ClientLock then exit;  GbFormGC3ClientLock := True;;
   GRegistry.Client.UseWOL := cbxUseWOL.Checked;
  _AfterControlDataChange;

end;

procedure TframGC3Client.cbShowSummOnClientClick(Sender: TObject);
begin
  if GbFormGC3ClientLock then exit;  GbFormGC3ClientLock := True;;
   GRegistry.Client.ShowSumm := cbShowSummOnClient.Checked;
  _AfterControlDataChange;
end;

end.
