unit frameTraffic;

interface

uses
  GCConst, GCLangUtils, GCComputers, GCCommon,
  Windows, Messages, SysUtils, Classes,
  Graphics, Controls, Forms, Dialogs, ComCtrls, StdCtrls, ExtCtrls;

type
  TframeTraffic = class(TFrame)
    gbTCPMappings: TGroupBox;
    lblListenPort: TLabel;
    editListenPort: TEdit;
    lblProxyIP: TLabel;
    editMappedIP: TEdit;
    lblPort: TLabel;
    Label5: TLabel;
    editMappedPort: TEdit;
    lblReadyMappings: TLabel;
    lvMappings: TListView;
    butAddMapping: TButton;
    butDeleteMapping: TButton;
    cbActiveInnerProxy: TCheckBox;
    gbClientSettings: TGroupBox;
    gbProxyServer: TGroupBox;
    Label6: TLabel;
    lblClientIP: TLabel;
    cbActiveLinuxPro: TCheckBox;
    cbActiveLinuxFree: TCheckBox;
    gbWindows: TGroupBox;
    gbUnixFree: TGroupBox;
    gbUnixPro: TGroupBox;
    gbModuleSettings: TGroupBox;
    lblIPAddress: TLabel;
    lblFrequency: TLabel;
    lblSec: TLabel;
    edtIPAddress: TEdit;
    edtFrequency: TEdit;
    cbActiveOuterPlugIn: TCheckBox;
    gbOuterPlugin: TGroupBox;
    cbOuterPluginSetLimit: TCheckBox;
    cbOuterPluginSetSpeed: TCheckBox;
    cbOuterPluginSetGroup: TCheckBox;
    gbTariffing: TGroupBox;
    rbtnTariffingOnlyIbound: TRadioButton;
    rbtnTariffingSummary: TRadioButton;
    rbtnTariffingMaximum: TRadioButton;
    pnlBottom: TPanel;
    procedure editListenPortChange(Sender: TObject);
    procedure DoDesign;
    procedure UpdateList;
    procedure butAddMappingClick(Sender: TObject);
    procedure butDeleteMappingClick(Sender: TObject);
    procedure editMappedIPChange(Sender: TObject);
    procedure editMappedPortChange(Sender: TObject);
    procedure lvMappingsClick(Sender: TObject);
    procedure cbActiveInnerProxyClick(Sender: TObject);
    procedure cbActiveLinuxProClick(Sender: TObject);
    procedure cbActiveOuterPluginClick(Sender: TObject);
    procedure cbActiveLinuxFreeClick(Sender: TObject);
    procedure edtIPAddressChange(Sender: TObject);
    procedure edtFrequencyChange(Sender: TObject);
    procedure cbOuterPluginSetGroupClick(Sender: TObject);
    procedure cbOuterPluginSetLimitClick(Sender: TObject);
    procedure cbOuterPluginSetSpeedClick(Sender: TObject);
    procedure rbtnTariffingModeClick(Sender: TObject);
  private
    FbControlsEnabled: Boolean;
    { Private declarations }
    procedure ResetFrame;
  public
    function GetID: integer;
    procedure Activate(ID: integer);
    { Public declarations }
    procedure EnableControls;
    procedure DisableControls;
    property ControlsEnabled: Boolean
        read FbControlsEnabled write FbControlsEnabled;
  end;

implementation

uses
  IdIPWatch,
  StrUtils,
  uRegistry,
  uRegistryInternet,
  URegistration;

{$R *.dfm}

function TframeTraffic.GetID: integer;
begin
  GetID := FRAME_TRAFFIC;
end;

// процедура ставит все контролы в исходные позиции
procedure TframeTraffic.ResetFrame;
var
  ipw : TIdIPWatch;
begin
  butAddMapping.Caption := translate('Add');
  butDeleteMapping.Caption := translate('Delete');
  lblReadyMappings.Caption := translate('lblReadyMappings');
  gbTCPMappings.Caption := translate('gbTCPMappings');
  gbClientSettings.Caption := translate('gbClientSettings');
  cbActiveInnerProxy.Caption := translate('GCICActivate');
  gbWindows.Caption := IfThen(Registration.InternetControl,
      translate('infoModuleActivateOn'), translate('infoModuleActivateOff'));
  gbUnixPro.Caption := IfThen(Registration.InternetControlComLinux,
      translate('infoModuleActivateOn'), translate('infoModuleActivateOff'));
  cbActiveInnerProxy.Enabled := Registration.InternetControl;
  cbActiveInnerProxy.Checked := GRegistry.Modules.Internet.InnerProxy;
  cbActiveOuterPlugin.Enabled := Registration.InternetControl;
  cbActiveOuterPlugin.Checked := GRegistry.Modules.Internet.OuterPlugin;
  cbActiveLinuxPro.Enabled := Registration.InternetControlComLinux;
  cbActiveLinuxPro.Checked := GRegistry.Modules.Internet.LinuxPro;
  cbActiveLinuxFree.Checked := GRegistry.Modules.Internet.LinuxFree;
  cbOuterPluginSetLimit.Checked :=
      GRegistry.Modules.Internet.OuterPluginSetLimit;
  cbOuterPluginSetSpeed.Checked :=
      GRegistry.Modules.Internet.OuterPluginSetSpeed;
  cbOuterPluginSetGroup.Checked :=
      GRegistry.Modules.Internet.OuterPluginSetGroup;

  editListenPort.Text := '';
  editMappedIP.Text := '';
  editMappedPort.Text := '';
  UpdateList;
  DoDesign;
  ipw := TIdIPWatch.Create(Self);
  ipw.HistoryEnabled := False;
  lblClientIP.Caption := ipw.LocalIP;
  ipw.Free;
  edtIPAddress.Text := GRegistry.Options.UnixServerIP;
  edtFrequency.Text := IntToStr(GRegistry.Options.UnixServerQueryTime);
  case GRegistry.Modules.Internet.TariffingMode of
    tmOnlyInbound: rbtnTariffingOnlyIbound.Checked := True;
    tmSummary: rbtnTariffingSummary.Checked := True;
    tmMaximum: rbtnTariffingMaximum.Checked := True;
  end;
end;

procedure TframeTraffic.Activate(ID: integer);
begin
  Visible := (GetID = ID);
  if (not Visible) then exit;
  ResetFrame;
end;


procedure TframeTraffic.editListenPortChange(Sender: TObject);
begin
  DoDesign;
end;

procedure TframeTraffic.DoDesign;
begin
  DisableControls;
{  lblClientIP.Enabled := cbActiveInnerProxy.Checked;
  lblListenPort.Enabled := cbActiveInnerProxy.Checked;
  lblProxyIP.Enabled := cbActiveInnerProxy.Checked;
  lblPort.Enabled := cbActiveInnerProxy.Checked;
  editListenPort.Enabled := cbActiveInnerProxy.Checked;
  editMappedIP.Enabled := cbActiveInnerProxy.Checked;
  editMappedPort.Enabled := cbActiveInnerProxy.Checked;
  lvMappings.Enabled := cbActiveInnerProxy.Checked;}
  gbTCPMappings.Visible := cbActiveInnerProxy.Checked;
  gbOuterPlugin.Visible := cbActiveOuterPlugIn.Checked;
  if cbActiveOuterPlugIn.Checked then begin
    cbActiveInnerProxy.Top := 91;
    gbWindows.Height := 116;
  end else if cbActiveInnerProxy.Checked then begin
    cbActiveInnerProxy.Top := 30;
    gbWindows.Height := 226;
  end else begin
    cbActiveInnerProxy.Top := 30;
    gbWindows.Height := 56;
  end;
  butAddMapping.Enabled := cbActiveInnerProxy.Checked
      and ((editListenPort.Text <> '') and (editMappedIP.Text <> '')
      and (editMappedPort.Text <> ''));
  butDeleteMapping.Enabled := cbActiveInnerProxy.Checked
      and (lvMappings.Selected <> nil);
  if cbActiveOuterPlugIn.Checked or cbActiveLinuxPro.Checked
      or cbActiveLinuxFree.Checked then begin
    edtIPAddress.Enabled := True;
    edtIPAddress.Color := clWindow;
    edtFrequency.Enabled := True;
    edtFrequency.Color := clWindow;
  end else begin
    edtIPAddress.Enabled := False;
    edtIPAddress.Color := clBtnFace;
    edtFrequency.Enabled := False;
    edtFrequency.Color := clBtnFace;
  end;
  rbtnTariffingOnlyIbound.Enabled :=
      GRegistry.Modules.Internet.SummaryAccounting;
  rbtnTariffingSummary.Enabled := rbtnTariffingOnlyIbound.Enabled;
  rbtnTariffingMaximum.Enabled := rbtnTariffingOnlyIbound.Enabled;
  EnableControls;
end;

procedure TframeTraffic.UpdateList;
var
  i: integer;
  li: TListItem;
begin
  lvMappings.Clear;
  for i:=0 to (FMappings.count-1) do begin
    li := lvMappings.Items.Add;
    li.Caption := IntToStr(FMappings.LMappings[i].id);
    li.SubItems.Add(IntToStr(FMappings.LMappings[i].listenport));
    li.SubItems.Add(FMappings.LMappings[i].mappedip);
    li.SubItems.Add(IntToStr(FMappings.LMappings[i].mappedport));
  end;
  lvMappings.Columns[0].Width := 0;
  butDeleteMapping.Enabled := false;
end;

procedure TframeTraffic.butAddMappingClick(Sender: TObject);
begin
  FMappings.Add(StrToIntDef(editListenPort.Text,1000),StrToIntDef(editMappedPort.Text,1001),editMappedIP.Text);
  FMappings.Load;
  UpdateList;
end;

procedure TframeTraffic.butDeleteMappingClick(Sender: TObject);
var
  id: string;
begin
  if (lvMappings.Selected <> nil) then begin
    id := lvMappings.Selected.Caption;
    FMappings.Delete(StrToIntDef(id,0));
  end;
  FMappings.Load;
  UpdateList;
end;

procedure TframeTraffic.editMappedIPChange(Sender: TObject);
begin
  DoDesign;
end;

procedure TframeTraffic.editMappedPortChange(Sender: TObject);
begin
  DoDesign;
end;

procedure TframeTraffic.lvMappingsClick(Sender: TObject);
begin
  DoDesign;
end;

procedure TframeTraffic.cbActiveInnerProxyClick(Sender: TObject);
begin
  if not ControlsEnabled then
    exit;
  DisableControls;
  GRegistry.Modules.Internet.InnerProxy := cbActiveInnerProxy.Checked;
  if cbActiveInnerProxy.Checked then begin
    cbActiveOuterPlugIn.Checked := False;
    cbActiveLinuxPro.Checked := False;
    cbActiveLinuxFree.Checked := False;
  end;
  DoDesign;
  EnableControls;
end;

procedure TframeTraffic.cbActiveLinuxProClick(Sender: TObject);
begin
  if not ControlsEnabled then
    exit;
  DisableControls;
  GRegistry.Modules.Internet.LinuxPro := cbActiveLinuxPro.Checked;
  if cbActiveLinuxPro.Checked then begin
    cbActiveInnerProxy.Checked := False;
    cbActiveOuterPlugIn.Checked := False;
    cbActiveLinuxFree.Checked := False;
  end;
  DoDesign;
  EnableControls;
end;

procedure TframeTraffic.cbActiveOuterPluginClick(Sender: TObject);
begin
  if not ControlsEnabled then
    exit;
  DisableControls;
  GRegistry.Modules.Internet.OuterPlugin := cbActiveOuterPlugIn.Checked;
  if cbActiveOuterPlugIn.Checked then begin
    cbActiveInnerProxy.Checked := False;
    cbActiveLinuxPro.Checked := False;
    cbActiveLinuxFree.Checked := False;
  end;
  DoDesign;
  EnableControls;
end;

procedure TframeTraffic.cbActiveLinuxFreeClick(Sender: TObject);
begin
  if not ControlsEnabled then
    exit;
  DisableControls;
  GRegistry.Modules.Internet.LinuxFree := cbActiveLinuxFree.Checked;
  if cbActiveLinuxFree.Checked then begin
    cbActiveInnerProxy.Checked := False;
    cbActiveOuterPlugIn.Checked := False;
    cbActiveLinuxPro.Checked := False;
  end;
  DoDesign;
  EnableControls;
end;

procedure TframeTraffic.edtIPAddressChange(Sender: TObject);
begin
  if not ControlsEnabled then exit;
  GRegistry.Options.UnixServerIP := edtIPAddress.Text;

end;

procedure TframeTraffic.edtFrequencyChange(Sender: TObject);
begin
  if not ControlsEnabled then exit;
  GRegistry.Options.UnixServerQueryTime :=
      StrToIntDef(edtFrequency.Text, 5);
end;

procedure TframeTraffic.EnableControls;
begin
  FbControlsEnabled := True;
end;

procedure TframeTraffic.DisableControls;
begin
  FbControlsEnabled := False;
end;

procedure TframeTraffic.cbOuterPluginSetLimitClick(Sender: TObject);
begin
  if not ControlsEnabled then
    exit;
  DisableControls;
  GRegistry.Modules.Internet.OuterPluginSetLimit :=
    cbOuterPluginSetLimit.Checked;
  EnableControls;
end;

procedure TframeTraffic.cbOuterPluginSetSpeedClick(Sender: TObject);
begin
  if not ControlsEnabled then
    exit;
  DisableControls;
  GRegistry.Modules.Internet.OuterPluginSetSpeed :=
    cbOuterPluginSetSpeed.Checked;
  EnableControls;
end;

procedure TframeTraffic.cbOuterPluginSetGroupClick(Sender: TObject);
begin
  if not ControlsEnabled then
    exit;
  DisableControls;
  GRegistry.Modules.Internet.OuterPluginSetGroup :=
    cbOuterPluginSetGroup.Checked;
  EnableControls;
end;

procedure TframeTraffic.rbtnTariffingModeClick(Sender: TObject);
begin
  if not ControlsEnabled then
    exit;
  DisableControls;
  if rbtnTariffingOnlyIbound.Checked then
    GRegistry.Modules.Internet.TariffingMode := tmOnlyInbound;
  if rbtnTariffingSummary.Checked then
    GRegistry.Modules.Internet.TariffingMode := tmSummary;
  if rbtnTariffingMaximum.Checked then
    GRegistry.Modules.Internet.TariffingMode := tmMaximum;
  EnableControls;
end;

end.
