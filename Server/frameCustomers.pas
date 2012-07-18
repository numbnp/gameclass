unit frameCustomers;

interface

uses  
  GCConst, GCLangUtils, GCComputers, ADODB, GCCommon,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, ComCtrls, StdCtrls,
  ExtCtrls, Grids, DBGridEh, DB, DBCtrlsEh;

type
  TframCustomers = class(TFrame)
    cbActive: TCheckBox;
    gbOptions: TGroupBox;
    cbAutoBlockComp: TCheckBox;
    butGoAccounts: TButton;
    cbSecCodes: TCheckBox;
    gbBalanceOptions: TGroupBox;
    lblMinAddedSumma: TLabel;
    lblWarningAddedSumma: TLabel;
    editWarningAddedSumma: TEdit;
    editMinAddedSumma: TEdit;
    cbAlwaysAllowAuthentication: TCheckBox;
    cbxAutoLogoff: TCheckBox;
    edtAutoLogoffSec: TEdit;
    lblSec1: TLabel;
    cbxBlockDisplayByStandby: TCheckBox;
    pnlButtons: TPanel;
    panelTop: TPanel;
    cbxUseCheckAccounts: TCheckBox;
    pnlOptions: TPanel;
    cbxUsePeriodOfValidity: TCheckBox;
    pnlCheckAccounts: TGroupBox;
    edtPeriodOfValidityInDays: TEdit;
    lblDays: TLabel;
    cbAuthenticationIfReserved: TCheckBox;
    lblUserLevel: TLabel;
    cbTarifsLimit: TDBCheckBoxEh;
    cbUserLevel: TComboBox;
    procedure cbActiveClick(Sender: TObject);
    procedure cbAutoBlockCompClick(Sender: TObject);
    procedure cbSecCodesClick(Sender: TObject);
    procedure editMinAddedSummaChange(Sender: TObject);
    procedure editWarningAddedSummaChange(Sender: TObject);
    procedure butGoAccountsClick(Sender: TObject);
    procedure cbAlwaysAllowAuthenticationClick(Sender: TObject);
    procedure cbxAutoLogoffClick(Sender: TObject);
    procedure edtAutoLogoffSecChange(Sender: TObject);
    procedure cbxBlockDisplayByStandbyClick(Sender: TObject);
    procedure cbxUseCheckAccountsClick(Sender: TObject);
    procedure cbxUsePeriodOfValidityClick(Sender: TObject);
    procedure edtPeriodOfValidityInDaysChange(Sender: TObject);
    procedure cbAuthenticationIfReservedClick(Sender: TObject);
    procedure cbTarifsLimitClick(Sender: TObject);
    procedure cbUserLevelChange(Sender: TObject);
  private
  { Private declarations }
    FbControlsEnabled: Boolean;
    procedure ResetFrame;
    procedure DoDesign;
  public
    function GetID: integer;
    procedure Activate(ID: integer);
    procedure EnableControls;
    procedure DisableControls;
    property ControlsEnabled: Boolean
        read FbControlsEnabled write FbControlsEnabled;
    { Public declarations }
  end;

implementation

uses
  frmMain,
  uProtocol,
  frmGCMessageBox,
  uClientOptions,
  uAccountSystem,
  uAccountsDiscounts,
  uGCDataSet,
  uY2KString;

{$R *.dfm}

function TframCustomers.GetID: integer;
begin
  GetID := FRAME_CLIENTS;
end;

// процедура ставит все контролы в исходные позиции
procedure TframCustomers.ResetFrame;
begin
  DisableControls;
  cbActive.Checked := GAccountSystem.Enabled;
  cbSecCodes.Checked := GAccountSystem.UseSecurityCodes;
  cbAutoBlockComp.Checked := GAccountSystem.BlockIfLogonFailed3Times;
  cbAlwaysAllowAuthentication.Checked :=
      GAccountSystem.AlwaysAllowAuthentication;
  cbAuthenticationIfReserved.Checked :=
      GAccountSystem.AuthenticationIfReserved;
  cbxBlockDisplayByStandby.Checked :=
      GClientOptions.BlockDisplayByStandby;
  editMinAddedSumma.Text := FloatToStr(GAccountSystem.MinAddedSumma);
  editWarningAddedSumma.Text := FloatToStr(GAccountSystem.WarningAddedSumma);
  cbxAutoLogoff.Checked := GClientOptions.AutoLogoff;
  edtAutoLogoffSec.Enabled := GClientOptions.AutoLogoff;
  edtAutoLogoffSec.Text := IntToStr(GClientOptions.AutoLogoffSec);
  lblSec1.Enabled := GClientOptions.AutoLogoff;
  cbxUsePeriodOfValidity.Checked := GAccountSystem.UsePeriodOfValidity;
  cbxUseCheckAccounts.Checked := GAccountSystem.UseCheckAccounts;
  edtPeriodOfValidityInDays.Text := IntToStr(
      GAccountSystem.PeriodOfValidityInDays);
  cbTarifsLimit.Checked := GAccountSystem.UseDefaultUserLevel;
  cbUserLevel.Text := inttostr(GAccountSystem.DefaultUserLevel);
  cbUserLevel.Enabled := cbTarifsLimit.Checked;
  EnableControls;
end;

procedure TframCustomers.Activate(ID: integer);
begin
  Visible := (GetID = ID);
  if (not Visible) then exit;
  ResetFrame;
  DoDesign;
end;

procedure TframCustomers.cbActiveClick(Sender: TObject);
begin
  if not ControlsEnabled then exit;
  DisableControls;
  GAccountSystem.Enabled := cbActive.Checked;
  formMain.mnuAccounts2.Enabled := GAccountSystem.Enabled;
  DoDesign;
  EnableControls;
end;

procedure TframCustomers.cbAutoBlockCompClick(Sender: TObject);
begin
  if not ControlsEnabled then exit;
  DisableControls;
  GAccountSystem.BlockIfLogonFailed3times := cbAutoBlockComp.Checked;
  EnableControls;
end;

procedure TframCustomers.cbSecCodesClick(Sender: TObject);
begin
  if not ControlsEnabled then exit;
  DisableControls;
  GAccountSystem.UseSecurityCodes := cbSecCodes.Checked;
  EnableControls;
end;

procedure TframCustomers.editMinAddedSummaChange(Sender: TObject);
begin
  if not ControlsEnabled then exit;
  DisableControls;
  GAccountSystem.MinAddedSumma := StrToFloatDefWithReplace(
      editMinAddedSumma.Text, 10);
  EnableControls;
end;

procedure TframCustomers.editWarningAddedSummaChange(Sender: TObject);
begin
  if not ControlsEnabled then exit;
  DisableControls;
  GAccountSystem.WarningAddedSumma := StrToFloatDefWithReplace(
      editWarningAddedSumma.Text, 100);
  if (GAccountSystem.WarningAddedSumma = 0) then
    GAccountSystem.WarningAddedSumma := 100;
  EnableControls;
end;

procedure TframCustomers.DoDesign;
var
  bEnabled: Boolean;
begin
  bEnabled := GAccountSystem.Enabled;
  cbAutoBlockComp.Enabled := bEnabled;
  cbSecCodes.Enabled := bEnabled;
  cbAlwaysAllowAuthentication.Enabled := bEnabled;
  cbxBlockDisplayByStandby.Enabled := bEnabled;
  cbxAutoLogoff.Enabled := bEnabled;
  edtAutoLogoffSec.Enabled := cbxAutoLogoff.Checked and bEnabled;
  editMinAddedSumma.Enabled := bEnabled;
  editWarningAddedSumma.Enabled := bEnabled;
  butGoAccounts.Enabled := bEnabled;
  cbxUseCheckAccounts.Enabled := bEnabled;
  editWarningAddedSumma.Enabled := bEnabled;
  editMinAddedSumma.Enabled := bEnabled;
  lblMinAddedSumma.Enabled := bEnabled;
  lblWarningAddedSumma.Enabled := bEnabled;
  lblSec1.Enabled := bEnabled;
  cbxUsePeriodOfValidity.Enabled := bEnabled and cbxUseCheckAccounts.Checked;
  edtPeriodOfValidityInDays.Enabled := bEnabled and cbxUseCheckAccounts.Checked;
  lblDays.Enabled := bEnabled;

end;

procedure TframCustomers.butGoAccountsClick(Sender: TObject);
begin
  formMain.mnuAccounts2Click(Sender);
end;

procedure TframCustomers.cbAlwaysAllowAuthenticationClick(Sender: TObject);
begin
  if not ControlsEnabled then exit;
  DisableControls;
  GAccountSystem.AlwaysAllowAuthentication :=
      cbAlwaysAllowAuthentication.Checked;
  EnableControls;
end;

procedure TframCustomers.cbxAutoLogoffClick(Sender: TObject);
begin
  if not ControlsEnabled then exit;
  DisableControls;
  GClientOptions.AutoLogoff := cbxAutoLogoff.Checked;
  GClientOptions.Save;
  DoDesign;
  EnableControls;
end;

procedure TframCustomers.edtAutoLogoffSecChange(Sender: TObject);
begin
  if not ControlsEnabled then exit;
  DisableControls;
  GClientOptions.AutoLogoffSec := StrToIntDef(edtAutoLogoffSec.Text, 10);
  if (GClientOptions.AutoLogoffSec <= 0) then begin
    GClientOptions.AutoLogoffSec := 10;
    edtAutoLogoffSec.Text := '10';
  end;
  GClientOptions.Save;
  EnableControls;
end;

procedure TframCustomers.EnableControls;
begin
  FbControlsEnabled := True;
end;

procedure TframCustomers.DisableControls;
begin
  FbControlsEnabled := False;
end;

procedure TframCustomers.cbxBlockDisplayByStandbyClick(Sender: TObject);
begin
  if not ControlsEnabled then exit;
  DisableControls;
  GClientOptions.BlockDisplayByStandby :=
      cbxBlockDisplayByStandby.Checked;
  EnableControls;

end;

procedure TframCustomers.cbxUseCheckAccountsClick(Sender: TObject);
begin
  if not ControlsEnabled then exit;
  DisableControls;
  GAccountSystem.UseCheckAccounts :=
      cbxUseCheckAccounts.Checked;
  DoDesign;
  EnableControls;
end;

procedure TframCustomers.cbxUsePeriodOfValidityClick(Sender: TObject);
begin
  if not ControlsEnabled then exit;
  DisableControls;
  GAccountSystem.UsePeriodOfValidity :=
      cbxUsePeriodOfValidity.Checked;
  EnableControls;
end;

procedure TframCustomers.edtPeriodOfValidityInDaysChange(Sender: TObject);
begin
  if not ControlsEnabled then exit;
  DisableControls;
  GAccountSystem.PeriodOfValidityInDays := StrToIntDef(
      edtPeriodOfValidityInDays.Text, 30);
  EnableControls;
end;

procedure TframCustomers.cbAuthenticationIfReservedClick(Sender: TObject);
begin
  if not ControlsEnabled then exit;
  DisableControls;
  GAccountSystem.AuthenticationIfReserved :=
      cbAuthenticationIfReserved.Checked;
  EnableControls;
end;

procedure TframCustomers.cbTarifsLimitClick(Sender: TObject);
begin
  if not ControlsEnabled then exit;
  DisableControls;
  GAccountSystem.UseDefaultUserLevel :=
      cbTarifsLimit.Checked;
  cbUserLevel.Enabled := GAccountSystem.UseDefaultUserLevel;
  EnableControls;
end;

procedure TframCustomers.cbUserLevelChange(Sender: TObject);
begin
  if not ControlsEnabled then exit;
  DisableControls;
  GAccountSystem.DefaultUserLevel := StrToIntDef(cbUserLevel.Text,1);
  EnableControls;
end;

end.
