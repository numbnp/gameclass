unit uframeOptions;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  ComCtrls,
  StdCtrls,
  ExtCtrls;

type
  TframeOptions = class(TFrame)
    gbPayment: TGroupBox;
    gbChange: TGroupBox;
    cbxDisableChange: TCheckBox;
    cbxEnableChangeForPackets: TCheckBox;
    lblStartMoneyMin: TLabel;
    lblStartMoneyMax: TLabel;
    gbSum: TGroupBox;
    lblAddMoneyMin: TLabel;
    lblAddMoneyMax: TLabel;
    lblMaximumTrust: TLabel;
    edtStartMoneyMin: TEdit;
    edtStartMoneyMax: TEdit;
    edtAddMoneyMin: TEdit;
    edtAddMoneyMax: TEdit;
    edtMaximumTrust: TEdit;
    lblCurrency: TLabel;
    edtCurrency: TEdit;
    gbOthers: TGroupBox;
    lblClubName: TLabel;
    edtClubName: TEdit;
    cbxEnableInternetRemont: TCheckBox;
    lblMinutsForLongRepair: TLabel;
    edtMinutsForLongRepair: TEdit;
    pnlTopLeft: TPanel;
    pnlTopRight: TPanel;
    gbOperator: TGroupBox;
    edtOperatorIP: TEdit;
    gbRepair: TGroupBox;
    gbCurrency: TGroupBox;
    lblMin: TLabel;
    lblIPAddress: TLabel;
    cbxPrinterControl: TCheckBox;
    cbxInternetControl: TCheckBox;
    Panel1: TPanel;
    gbGuest: TGroupBox;
    cbxGuestSession: TCheckBox;
    lblTarif: TLabel;
    cboGuestSessionTarif: TComboBox;
    cbxEnableChangeForReserveCancel: TCheckBox;
    Panel2: TPanel;
    gbPaymentMode: TGroupBox;
    cbxPrepayOnly: TCheckBox;
    gbPaymentModeDefault: TGroupBox;
    rbtnPrepay: TRadioButton;
    rbtnPostpay: TRadioButton;
    cbxReserveDisable: TCheckBox;
    pnlOperatingTime: TGroupBox;
    lblOperatingTimeBegin: TLabel;
    lblOperatingTimeEnd: TLabel;
    dtpOperatingTimeBegin: TDateTimePicker;
    dtpOperatingTimeEnd: TDateTimePicker;
    cbxOperatingTime: TCheckBox;
    cbxEnableChangeForSeparateTraffic: TCheckBox;
    cbxDebugLog: TCheckBox;
    cbxReserveAutoActivate: TCheckBox;
    gbOptimize: TGroupBox;
    cbxWriteProcessList: TCheckBox;
    cbxWriteUnControlComp: TCheckBox;
    cbxWriteUnControlClub: TCheckBox;
    procedure cbxPrepayOnlyClick(Sender: TObject);
    procedure rbtnPrepayClick(Sender: TObject);
    procedure rbtnPostpayClick(Sender: TObject);
    procedure edtStartMoneyMinChange(Sender: TObject);
    procedure edtStartMoneyMaxChange(Sender: TObject);
    procedure edtAddMoneyMinChange(Sender: TObject);
    procedure edtAddMoneyMaxChange(Sender: TObject);
    procedure edtMaximumTrustChange(Sender: TObject);
    procedure cbxDisableChangeClick(Sender: TObject);
    procedure cbxEnableChangeForPacketsClick(Sender: TObject);
    procedure edtClubNameChange(Sender: TObject);
    procedure edtCurrencyChange(Sender: TObject);
    procedure edtMinutsForLongRepairChange(Sender: TObject);
    procedure cbxEnableInternetRemontClick(Sender: TObject);
    procedure cbxReserveDisableClick(Sender: TObject);
    procedure edtOperatorIPChange(Sender: TObject);
    procedure cbxPrinterControlClick(Sender: TObject);
    procedure cbxInternetControlClick(Sender: TObject);
    procedure cbxGuestSessionClick(Sender: TObject);
    procedure cboGuestSessionTarifChange(Sender: TObject);
    procedure cbxEnableChangeForReserveCancelClick(Sender: TObject);
    procedure cbxOperatingTimeClick(Sender: TObject);
    procedure dtpOperatingTimeBeginChange(Sender: TObject);
    procedure dtpOperatingTimeEndChange(Sender: TObject);
    procedure cbxEnableChangeForSeparateTrafficClick(Sender: TObject);
    procedure cbxDebugLogClick(Sender: TObject);
    procedure cbxReserveAutoActivateClick(Sender: TObject);
    procedure cbxWriteProcessListClick(Sender: TObject);
    procedure cbxWriteUnControlCompClick(Sender: TObject);
    procedure cbxWriteUnControlClubClick(Sender: TObject);
  private
    FbControlsEnabled: Boolean;
    { Private declarations }
    procedure ResetFrame;
    procedure RedrawTarifsList;

  public
    function GetID: integer;
    procedure Activate(ID: integer);
    { Public declarations }
    procedure DoDesign;
    procedure Save;
    procedure EnableControls;
    procedure DisableControls;
    property ControlsEnabled: Boolean
        read FbControlsEnabled write FbControlsEnabled;
  end;

implementation
{$R *.dfm}
uses
  uClientOptions,
  gcconst,
  gccomputers,
  uRegistry,
  uRegistryOptions,
  uRegistryInterface,
  uY2KString, uRegistryModules, uRegistryInternet,
  uTariffication;

procedure TframeOptions.Save;
begin
  GClientOptions.Save;
end;

function TframeOptions.GetID: integer;
begin
  GetID := FRAME_OPTIONS;
end;

procedure TframeOptions.DoDesign;
begin
  FbControlsEnabled := False;
  cbxPrepayOnly.Checked := GRegistry.Options.OnlyPrePayMode;
  rbtnPostpay.Checked := GRegistry.Options.PostPayMode;
    //  and not cbxPrepayOnly.Checked;
  rbtnPrepay.Checked := not rbtnPostpay.Checked or cbxPrepayOnly.Checked;
  cbxReserveDisable.Checked := GRegistry.Options.ReserveDisable;
  cbxReserveAutoActivate.Checked := GRegistry.Options.ReserveAutoActivate;
  cbxReserveAutoActivate.Enabled := not cbxReserveDisable.Checked;
  cbxDisableChange.Checked := GRegistry.Options.DisableChange;
  cbxEnableChangeForPackets.Checked := GRegistry.Options.EnableChangeForPackets
      and not cbxDisableChange.Checked;
  cbxEnableChangeForReserveCancel.Checked :=
      GRegistry.Options.EnableChangeForReserveCancel
      or not cbxDisableChange.Checked;
  cbxEnableChangeForSeparateTraffic.Checked :=
      GRegistry.Options.EnableChangeForSeparateTraffic
      and not cbxDisableChange.Checked;
  edtStartMoneyMin.Text := FloatToStr(GRegistry.Options.StartMoneyMinimum);
  edtStartMoneyMax.Text := FloatToStr(GRegistry.Options.StartMoneyMaximum);
  edtAddMoneyMin.Text := FloatToStr(GRegistry.Options.AddMoneyMinimum);
  edtAddMoneyMax.Text := FloatToStr(GRegistry.Options.AddMoneyMaximum);
  edtMaximumTrust.Text := FloatToStr(GRegistry.Options.MaximumTrustPostPay);
  edtCurrency.Text := GRegistry.Options.Currency;
  edtClubName.Text := GRegistry.Options.ClubName;
  cbxEnableInternetRemont.Checked := GRegistry.Options.EnableInternetRemont;
  edtMinutsForLongRepair.Text := IntToStr(GRegistry.Options.MinutsForLongRepair);
  rbtnPostpay.Enabled := not cbxPrepayOnly.Checked;
  rbtnPrepay.Enabled := not cbxPrepayOnly.Checked;
  cbxEnableChangeForPackets.Enabled := not cbxDisableChange.Checked;
  cbxEnableChangeForReserveCancel.Enabled := cbxDisableChange.Checked;
  cbxEnableChangeForSeparateTraffic.Enabled := not cbxDisableChange.Checked;
  edtOperatorIP.Text := GRegistry.Options.OperatorIP;
  cbxPrinterControl.Checked := GRegistry.Options.OperatorPrinterControl;
  cbxInternetControl.Checked := GRegistry.Options.OperatorTrafficControl;
  cbxPrinterControl.Enabled := GRegistry.Modules.Printer.Active;
  cbxInternetControl.Enabled := GRegistry.Modules.Internet.SummaryAccounting;
  cbxGuestSession.Enabled := not cbxPrepayOnly.Checked;
  cbxGuestSession.Checked := GRegistry.Client.GuestSession;
  cboGuestSessionTarif.Enabled := cbxGuestSession.Checked
      and not cbxPrepayOnly.Checked;
  cbxOperatingTime.Checked := GRegistry.Options.OperatingTime;
  dtpOperatingTimeBegin.Enabled := cbxOperatingTime.Checked;
  dtpOperatingTimeEnd.Enabled := cbxOperatingTime.Checked;
  dtpOperatingTimeBegin.Time := GRegistry.Options.OperatingTimeBegin;
  dtpOperatingTimeEnd.Time := GRegistry.Options.OperatingTimeEnd;
  cbxDebugLog.Checked := GRegistry.Options.DebugLog;
  cbxWriteProcessList.Checked := GRegistry.Options.WriteProcessList;
  cbxWriteUnControlComp.Checked := GRegistry.Options.WriteUnControlComp;
  cbxWriteUnControlClub.Checked := GRegistry.Options.WriteUnControlClub;
  FbControlsEnabled := True;
end;

// процедура ставит все контролы в исходные позиции
procedure TframeOptions.ResetFrame;
begin
  GClientOptions.Load;
  RedrawTarifsList;
  DoDesign;
end;

procedure TframeOptions.RedrawTarifsList;
var
  i,j: Integer;
  li: TListItem;
  strSelectedTarif: String;
begin
  strSelectedTarif := GRegistry.Client.GuestSessionTarifName;
  cboGuestSessionTarif.Clear;
  if (CompsCount > 0) and (CompGroupsCount > 0) and (TarifsCount > 0) then begin
    for i := 1 to (TarifsCount - 1) do
      if (Tarifs[i].idGroup = CompGroups[0].Id) then
        cboGuestSessionTarif.Items.Add(Tarifs[i].name);
    for i := 0 to cboGuestSessionTarif.Items.Count - 1 do
      if (cboGuestSessionTarif.Items[i] = strSelectedTarif) then
        cboGuestSessionTarif.ItemIndex := i;
  end;
  cboGuestSessionTarifChange(Self);
end;

procedure TframeOptions.Activate(ID: integer);
begin
  Visible := (GetID = ID);
  if (not Visible) then exit;
  ResetFrame;
end;

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private helper methods
procedure TframeOptions.EnableControls;
begin
  FbControlsEnabled := True;
end;

procedure TframeOptions.DisableControls;
begin
  FbControlsEnabled := False;
end;

procedure TframeOptions.cbxPrepayOnlyClick(Sender: TObject);
begin
  if not ControlsEnabled then exit;
  DisableControls;
  GRegistry.Options.OnlyPrePayMode := cbxPrepayOnly.Checked;
  DoDesign;
  EnableControls;
end;

procedure TframeOptions.rbtnPrepayClick(Sender: TObject);
begin
  if not ControlsEnabled then exit;
  GRegistry.Options.PostPayMode := rbtnPostpay.Checked;
end;

procedure TframeOptions.rbtnPostpayClick(Sender: TObject);
begin
  if not ControlsEnabled then exit;
  GRegistry.Options.PostPayMode := rbtnPostpay.Checked;
end;

procedure TframeOptions.edtStartMoneyMinChange(Sender: TObject);
begin
  if not ControlsEnabled then exit;
  GRegistry.Options.StartMoneyMinimum :=
      StrToFloatDefWithReplace(edtStartMoneyMin.Text, 1);
end;

procedure TframeOptions.edtStartMoneyMaxChange(Sender: TObject);
begin
  if not ControlsEnabled then exit;
  GRegistry.Options.StartMoneyMaximum :=
      StrToFloatDefWithReplace(edtStartMoneyMax.Text, 1);
end;

procedure TframeOptions.edtAddMoneyMinChange(Sender: TObject);
begin
  if not ControlsEnabled then exit;
  GRegistry.Options.AddMoneyMinimum :=
      StrToFloatDefWithReplace(edtAddMoneyMin.Text, 1);
end;

procedure TframeOptions.edtAddMoneyMaxChange(Sender: TObject);
begin
  if not ControlsEnabled then exit;
  GRegistry.Options.AddMoneyMaximum :=
      StrToFloatDefWithReplace(edtAddMoneyMax.Text, 1);
end;

procedure TframeOptions.edtMaximumTrustChange(Sender: TObject);
begin
  if not ControlsEnabled then exit;
  GRegistry.Options.MaximumTrustPostPay :=
      StrToFloatDefWithReplace(edtMaximumTrust.Text, 1);
end;

procedure TframeOptions.cbxDisableChangeClick(Sender: TObject);
begin
  if not ControlsEnabled then exit;
  DisableControls;
  GRegistry.Options.DisableChange := cbxDisableChange.Checked;
  DoDesign;
  EnableControls;
end;

procedure TframeOptions.cbxEnableChangeForPacketsClick(Sender: TObject);
begin
  if not ControlsEnabled then exit;
  GRegistry.Options.EnableChangeForPackets := cbxEnableChangeForPackets.Checked;
end;

procedure TframeOptions.edtClubNameChange(Sender: TObject);
begin
  if not ControlsEnabled then exit;
  GRegistry.Options.ClubName := edtClubName.Text;
end;

procedure TframeOptions.edtCurrencyChange(Sender: TObject);
begin
  if not ControlsEnabled then exit;
  GRegistry.Options.Currency := edtCurrency.Text;
end;

procedure TframeOptions.edtMinutsForLongRepairChange(Sender: TObject);
begin
  if not ControlsEnabled then exit;
  GRegistry.Options.MinutsForLongRepair :=
      StrToIntDef(edtMinutsForLongRepair.Text, 360);
end;

procedure TframeOptions.cbxEnableInternetRemontClick(Sender: TObject);
begin
  if not ControlsEnabled then exit;
  GRegistry.Options.EnableInternetRemont := cbxEnableInternetRemont.Checked;
end;

procedure TframeOptions.cbxReserveDisableClick(Sender: TObject);
begin
  if not ControlsEnabled then exit;
  GRegistry.Options.ReserveDisable := cbxReserveDisable.Checked;
  cbxReserveAutoActivate.Enabled := not cbxReserveDisable.Checked;
end;

procedure TframeOptions.edtOperatorIPChange(Sender: TObject);
begin
  if not ControlsEnabled then exit;
  GRegistry.Options.OperatorIP := edtOperatorIP.Text;
end;

procedure TframeOptions.cbxPrinterControlClick(Sender: TObject);
begin
  if not ControlsEnabled then exit;
  GRegistry.Options.OperatorPrinterControl :=
      cbxPrinterControl.Checked;
end;

procedure TframeOptions.cbxInternetControlClick(Sender: TObject);
begin
  if not ControlsEnabled then exit;
  GRegistry.Options.OperatorTrafficControl :=
      cbxInternetControl.Checked;
end;

procedure TframeOptions.cbxGuestSessionClick(Sender: TObject);
begin
  if not ControlsEnabled then exit;
  DisableControls;
  GRegistry.Client.GuestSession := cbxGuestSession.Checked;
  DoDesign;
  EnableControls;
end;

procedure TframeOptions.cboGuestSessionTarifChange(Sender: TObject);
begin
  GRegistry.Client.GuestSessionTarifName := cboGuestSessionTarif.Text;
end;

procedure TframeOptions.cbxEnableChangeForReserveCancelClick(
  Sender: TObject);
begin
  if not ControlsEnabled then exit;
  GRegistry.Options.EnableChangeForReserveCancel :=
      cbxEnableChangeForReserveCancel.Checked;
end;

procedure TframeOptions.dtpOperatingTimeBeginChange(Sender: TObject);
begin
  if not ControlsEnabled then exit;
  GRegistry.Options.OperatingTimeBegin :=
      dtpOperatingTimeBegin.Time;
end;

procedure TframeOptions.dtpOperatingTimeEndChange(Sender: TObject);
begin
  if not ControlsEnabled then exit;
  GRegistry.Options.OperatingTimeEnd :=
      dtpOperatingTimeEnd.Time;

end;

procedure TframeOptions.cbxOperatingTimeClick(Sender: TObject);
begin
  if not ControlsEnabled then exit;
  GRegistry.Options.OperatingTime := cbxOperatingTime.Checked;
  DoDesign;
end;

procedure TframeOptions.cbxEnableChangeForSeparateTrafficClick(
  Sender: TObject);
begin
  if not ControlsEnabled then exit;
  GRegistry.Options.EnableChangeForSeparateTraffic :=
      cbxEnableChangeForSeparateTraffic.Checked;
end;

procedure TframeOptions.cbxDebugLogClick(Sender: TObject);
begin
  if not ControlsEnabled then exit;
  GRegistry.Options.DebugLog := cbxDebugLog.Checked;
end;

procedure TframeOptions.cbxReserveAutoActivateClick(Sender: TObject);
begin
  if not ControlsEnabled then exit;
  GRegistry.Options.ReserveAutoActivate := cbxReserveAutoActivate.Checked;
end;

procedure TframeOptions.cbxWriteProcessListClick(Sender: TObject);
begin
  if not ControlsEnabled then exit;
  GRegistry.Options.WriteProcessList := cbxWriteProcessList.Checked;
end;

procedure TframeOptions.cbxWriteUnControlCompClick(Sender: TObject);
begin
  if not ControlsEnabled then exit;
  GRegistry.Options.WriteUnControlComp := cbxWriteUnControlComp.Checked;
end;

procedure TframeOptions.cbxWriteUnControlClubClick(Sender: TObject);
begin
  if not ControlsEnabled then exit;
  GRegistry.Options.WriteUnControlClub := cbxWriteUnControlClub.Checked;
end;

end.
