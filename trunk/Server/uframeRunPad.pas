unit uframeRunPad;

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
  TframeRunPad = class(TFrame)
    cbxHideTabs: TCheckBox;
    cbxInternetControl: TCheckBox;
    gbSessionStop: TGroupBox;
    gbTabs: TGroupBox;
    pnlTop2: TPanel;
    butAddTabToHided: TButton;
    butRemoveFromTabToHided: TButton;
    editTab: TEdit;
    butTabAdd: TButton;
    butTabUpdate: TButton;
    butTabDelete: TButton;
    Panel1: TPanel;
    lblTab: TLabel;
    lbTarifs: TListBox;
    lblTarifs: TLabel;
    lbTabs: TListBox;
    lbHidedTabs: TListBox;
    lblTabsAll: TLabel;
    lblTabsCurrent: TLabel;
    gbInfoOnDesktop: TGroupBox;
    cbxShowInfo: TCheckBox;
    lblShablon: TLabel;
    edtShablon: TEdit;
    procedure lbTarifsClick(Sender: TObject);
    procedure lbTarifsKeyPress(Sender: TObject; var Key: Char);
    procedure lbTabsClick(Sender: TObject);
    procedure lbTabsKeyPress(Sender: TObject; var Key: Char);
    procedure editTabChange(Sender: TObject);
    procedure butTabAddClick(Sender: TObject);
    procedure butTabUpdateClick(Sender: TObject);
    procedure butTabDeleteClick(Sender: TObject);
    procedure butAddTabToHidedClick(Sender: TObject);
    procedure butRemoveFromTabToHidedClick(Sender: TObject);
    procedure lbHidedTabsClick(Sender: TObject);
    procedure lbHidedTabsKeyPress(Sender: TObject; var Key: Char);
    procedure cbxInternetControlClick(Sender: TObject);
    procedure cbxInternetControlKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbxHideTabsClick(Sender: TObject);
    procedure cbxHideTabsKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbxShowInfoClick(Sender: TObject);
    procedure edtShablonChange(Sender: TObject);
  private
    FstrCurrentTarif: String;
    FstrCurrentTab: String;
    FstrCurrentHidedTab: String;
    { Private declarations }
    procedure ResetFrame;
    // private helper methods
    procedure _AfterControlDataChange(const AbDoDesign: Boolean = False);

    procedure _cbxInternetControlChange;
    procedure _cbxHideTabsChange;
    procedure _TarifsCurrentChange;
    procedure _TabsCurrentChange;
    procedure _HidedTabsCurrentChange;
    procedure _cbxShowInfoChange;

  public
    function GetID: integer;
    procedure Activate(ID: integer);
    { Public declarations }
    procedure DoDesign;
    procedure Save;
  end;

implementation
{$R *.dfm}
uses
  uClientOptions,
  gcconst,
  uTariffication;

var
   GbFormGC3ClientLock: Boolean = False;

procedure TframeRunPad.Save;
begin
  GClientOptions.Save;
end;

function TframeRunPad.GetID: integer;
begin
  GetID := FRAME_RUNPAD;
end;

procedure TframeRunPad.DoDesign;
var
  bTarifSelected: Boolean;
  bTabSelected: Boolean;
  bTabNameChanged: Boolean;
  bTabNamePresent: Boolean;
  bCurrentTabNamePresentInHided: Boolean;
  bHidedTabSelected: Boolean;
  i: Integer;
begin
  GbFormGC3ClientLock := True;
  // Блокировка
  cbxInternetControl.Checked := GClientOptions.RunPadInternetControl;
  cbxHideTabs.Checked := GClientOptions.RunPadHideTabs;
  //Отслеживаем редактирование списка табов
  bTabSelected := False;
  bTabNameChanged := False;
  bTarifSelected := (Length(FstrCurrentTarif) > 0);
  if (Length(FstrCurrentTab) > 0) then begin
    bTabSelected := True;
    if (editTab.Text <> FstrCurrentTab) then
      bTabNameChanged := True;
  end else
    if (Length(editTab.Text) > 0) then
      bTabNameChanged := True;
  bTabNamePresent := (lbTabs.Items.IndexOf(editTab.Text) <> -1);
  bCurrentTabNamePresentInHided :=
      (lbHidedTabs.Items.IndexOf(FstrCurrentTab) <> -1);
  bHidedTabSelected := (Length(FstrCurrentHidedTab) > 0);
  butAddTabToHided.Enabled := bTabSelected and bTarifSelected
      and not bCurrentTabNamePresentInHided;
  butRemoveFromTabToHided.Enabled := bHidedTabSelected and bTarifSelected;
  butTabDelete.Enabled := bTabSelected and not bTabNameChanged;
  butTabAdd.Enabled := bTabNameChanged and not bTabNamePresent;
  butTabUpdate.Enabled := bTabSelected and bTabNameChanged and not bTabNamePresent;

  cbxShowInfo.Checked := GClientOptions.RunPadShowInfoOnDesktop;
  edtShablon.Text := GClientOptions.RunPadShowInfoOnDesktopText;
  edtShablon.Enabled := cbxShowInfo.Checked;

  GbFormGC3ClientLock := False;
end;

// процедура ставит все контролы в исходные позиции
procedure TframeRunPad.ResetFrame;
var
  i: Integer;
begin
//  optClientLoad;
  GClientOptions.Load;
  lbTarifs.Clear;
  for i:=0 to TarifsCount-1 do
    lbTarifs.AddItem(Tarifs[i].name, Nil);
  lbTabs.Clear;
  lbTabs.Items := GClientOptions.RunPadTabs;
  lbHidedTabs.Clear;
  FstrCurrentTarif := '';
  FstrCurrentTab := '';
  FstrCurrentHidedTab := '';
  DoDesign;
end;

procedure TframeRunPad.Activate(ID: integer);
begin
  Visible := (GetID = ID);
  if (not Visible) then exit;
  ResetFrame;
//  gb.Caption := translate('gbNotofocation');
end;

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private helper methods

procedure TframeRunPad._AfterControlDataChange(const AbDoDesign: Boolean = False);
begin
  if AbDoDesign then
    DoDesign;
  GClientOptions.Save;
  GbFormGC3ClientLock := False;
end;

procedure TframeRunPad.lbTarifsClick(Sender: TObject);
begin
  _TarifsCurrentChange;
end;

procedure TframeRunPad.lbTarifsKeyPress(Sender: TObject; var Key: Char);
begin
  _TarifsCurrentChange;
end;

procedure TframeRunPad.lbTabsClick(Sender: TObject);
begin
  _TabsCurrentChange;
end;

procedure TframeRunPad.lbTabsKeyPress(Sender: TObject; var Key: Char);
begin
  _TabsCurrentChange;
end;


procedure TframeRunPad.lbHidedTabsClick(Sender: TObject);
begin
  _HidedTabsCurrentChange
end;

procedure TframeRunPad.lbHidedTabsKeyPress(Sender: TObject; var Key: Char);
begin
  _HidedTabsCurrentChange
end;

procedure TframeRunPad._cbxInternetControlChange;
begin
  if GbFormGC3ClientLock then exit;  GbFormGC3ClientLock := True;;
  GClientOptions.RunPadInternetControl := cbxInternetControl.Checked;
  _AfterControlDataChange;
end;

procedure TframeRunPad._cbxHideTabsChange;
begin
  if GbFormGC3ClientLock then exit;  GbFormGC3ClientLock := True;;
  GClientOptions.RunPadHideTabs := cbxHideTabs.Checked;
  _AfterControlDataChange;
end;

procedure TframeRunPad._TarifsCurrentChange;
var
  i: Integer;
begin
  for i:=0 to lbTarifs.Count-1 do
    if (lbTarifs.Selected[i]) then
      FstrCurrentTarif := lbTarifs.Items[i];
  lbHidedTabs.Items.Text :=
      GClientOptions.GetRunPadHidedTabs(FstrCurrentTarif).Text;
  //если не сохранять, то остается ParamNotExists$gdsfgdg4g65
  GClientOptions.SetRunPadHidedTabs(
      FstrCurrentTarif,TStringList(lbHidedTabs.Items));
  DoDesign;
end;

procedure TframeRunPad._TabsCurrentChange;
var
  i: Integer;
begin
  for i:=0 to lbTabs.Count-1 do
    if (lbTabs.Selected[i]) then
      FstrCurrentTab := lbTabs.Items[i];
  editTab.Text := FstrCurrentTab;
  DoDesign;
end;

procedure TframeRunPad._HidedTabsCurrentChange;
var
  i: Integer;
begin
  for i:=0 to lbHidedTabs.Count-1 do
    if (lbHidedTabs.Selected[i]) then
      FstrCurrentHidedTab := lbHidedTabs.Items[i];
  DoDesign;
end;

procedure TframeRunPad.editTabChange(Sender: TObject);
begin
  DoDesign;
end;

procedure TframeRunPad.butTabAddClick(Sender: TObject);
begin
  lbTabs.AddItem(editTab.Text, Nil);
  GClientOptions.RunPadTabs := TStringList(lbTabs.Items);
  GClientOptions.Save;
  DoDesign;
end;

procedure TframeRunPad.butTabUpdateClick(Sender: TObject);
begin
  lbTabs.Items[lbTabs.Items.IndexOf(FstrCurrentTab)] := editTab.Text;
  GClientOptions.RunPadTabs := TStringList(lbTabs.Items);
  GClientOptions.Save;
  FstrCurrentTab := editTab.Text;
  DoDesign;
end;

procedure TframeRunPad.butTabDeleteClick(Sender: TObject);
begin
  lbTabs.Items.Delete(lbTabs.Items.IndexOf(FstrCurrentTab));
  GClientOptions.RunPadTabs := TStringList(lbTabs.Items);
  GClientOptions.Save;
  FstrCurrentTab := '';
  DoDesign;
end;

procedure TframeRunPad.butAddTabToHidedClick(Sender: TObject);
begin
  if (Length(FstrCurrentTab) > 0)
      and (lbHidedTabs.Items.IndexOf(FstrCurrentTab) = -1) then begin
    lbHidedTabs.Items.Add(FstrCurrentTab);
    GClientOptions.SetRunPadHidedTabs(
        FstrCurrentTarif,TStringList(lbHidedTabs.Items));
  end;
  DoDesign;
end;

procedure TframeRunPad.butRemoveFromTabToHidedClick(Sender: TObject);
begin
  if (Length(FstrCurrentHidedTab) > 0)
      and (lbHidedTabs.Items.IndexOf(FstrCurrentHidedTab) <> -1) then begin
    lbHidedTabs.Items.Delete(lbHidedTabs.Items.IndexOf(FstrCurrentHidedTab));
    GClientOptions.SetRunPadHidedTabs(
        FstrCurrentTarif,TStringList(lbHidedTabs.Items));
    FstrCurrentHidedTab := '';
  end;
  DoDesign;
end;

procedure TframeRunPad.cbxInternetControlClick(Sender: TObject);
begin
  _cbxInternetControlChange;
end;

procedure TframeRunPad.cbxInternetControlKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  _cbxInternetControlChange;
end;

procedure TframeRunPad.cbxHideTabsClick(Sender: TObject);
begin
  _cbxHideTabsChange;
end;

procedure TframeRunPad.cbxHideTabsKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  _cbxHideTabsChange;
end;

procedure TframeRunPad._cbxShowInfoChange();
begin
  if GbFormGC3ClientLock then exit;  GbFormGC3ClientLock := True;
  GClientOptions.RunPadShowInfoOnDesktop := cbxShowInfo.Checked;
  edtShablon.Enabled := cbxShowInfo.Checked;
  _AfterControlDataChange;
end;

procedure TframeRunPad.cbxShowInfoClick(Sender: TObject);
begin
  _cbxShowInfoChange;
end;

procedure TframeRunPad.edtShablonChange(Sender: TObject);
begin
  GClientOptions.RunPadShowInfoOnDesktopText := edtShablon.Text;
  _AfterControlDataChange;
end;

end.
