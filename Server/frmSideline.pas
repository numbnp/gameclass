unit frmSideline;

interface

uses
  StrUtils,
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  ExtCtrls,
  StdCtrls,
  Spin,
  ComCtrls,
  GCComputers,
  GCSessions;

type
  TformSideline = class(TForm)
    lvSideline: TListView;
    seQuantity: TSpinEdit;
    editMoney: TEdit;
    lblQuantity: TLabel;
    lblSummary: TLabel;
    butCancel: TButton;
    butSel: TButton;
    editFilterCode: TEdit;
    lblFilterCode: TLabel;
    Panel1: TPanel;
    Image1: TImage;
    butHelp: TButton;
    Label1: TLabel;
    edtAccountName: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    lblTypeCost: TLabel;
    Label5: TLabel;
    cboComputerNumber: TComboBox;
    cboComputerIP: TComboBox;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lvSidelineClick(Sender: TObject);
    procedure seQuantityChange(Sender: TObject);
    procedure butCancelClick(Sender: TObject);
    procedure butSelClick(Sender: TObject);
    procedure editFilterCodeChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure butHelpClick(Sender: TObject);
    function ShowModal(ATypeCost: TSidelineTypeCost;
        ASession: TGCSession): Integer;
    procedure cboComputerNumberChange(Sender: TObject);
    procedure cboComputerIPChange(Sender: TObject);
    procedure editFilterCodeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lvSidelineKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure seQuantityKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    procedure UpdateInformation;
    procedure FillList;
  private
    FbControlsEnabled: Boolean;
    FnServiceId: Integer;
    FTypeCost: TSidelineTypeCost;
    FSession: TGCSession;
  public
    procedure EnableControls;
    procedure DisableControls;
    property ControlsEnabled: Boolean
        read FbControlsEnabled write FbControlsEnabled;
    property TypeCost: TSidelineTypeCost
        read FTypeCost write FTypeCost;
    property Session: TGCSession
        read FSession write FSession;

    { Public declarations }
  end;

var
  formSideline: TformSideline;

implementation

uses
  GCLangUtils,
  GCConst,
  GCCommon,
  uRegistry;

{$R *.dfm}

procedure TformSideline.FormActivate(Sender: TObject);
begin
  Caption := translate('fnSidelineName');
  butCancel.Caption := translate('butCancel');
  butSel.Caption := translate('butSel');
  ModalResult := mrCancel;

  lvSideline.Columns[0].Caption := translate('ServiceName');
  lvSideline.Columns[1].Caption := translate('Price');
  lvSideline.Columns[2].Caption := translate('Code');

  lblQuantity.Caption := translate('lblQuantity');
  lblSummary.Caption := translate('lblSummary');
  lblFilterCode.Caption := translate('CodeFilter');

  butHelp.Caption := translate('subHelp');

  lblTypeCost.Caption := Sideline.GetTypeCostInfo(TypeCost);

  FillList;
end;

procedure TformSideline.FormCreate(Sender: TObject);
begin
  FbControlsEnabled := False;
  seQuantity.Value := 1;
  UpdateInformation;
end;

procedure TformSideline.UpdateInformation;
var
  nServiceId: Integer;
begin
  butSel.Enabled := (lvSideline.ItemIndex <> -1) or (editFilterCode.Text <> '');
  if (lvSideline.ItemIndex <> -1) then begin
    FnServiceId := StrToIntDef(
        lvSideline.Items[lvSideline.ItemIndex].SubItems[1], -1);
    editMoney.Text := FormatFloat('0.00',
        Sideline.GetPrice(FnServiceId) * seQuantity.value)
        + ' ' + GRegistry.Options.Currency;
  end;
end;

procedure TformSideline.lvSidelineClick(Sender: TObject);
begin
  UpdateInformation;
end;

procedure TformSideline.seQuantityChange(Sender: TObject);
begin
  UpdateInformation;
end;

procedure TformSideline.butCancelClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TformSideline.butSelClick(Sender: TObject);
var
  nComputerIndex: Integer;
  str: String;
begin
  if not GRegistry.Options.ServiceNoClose then ModalResult := mrOk;
  if (TypeCost = stcSeparate) then begin
    nComputerIndex := StrToIntDef(cboComputerNumber.Text, -1);
    if (nComputerIndex <> -1) then
      nComputerIndex := ComputersGetIndex(nComputerIndex) + 1;
    Sideline.ToSell(FnServiceId, seQuantity.Value, FTypeCost, nComputerIndex);
  end else
    Sideline.ToSell(FnServiceId, seQuantity.Value, FTypeCost,
        Session.IdComp, Session.IdClient);

  if GRegistry.Options.ServiceNoClose then
  begin
    cboComputerNumber.Text := '';
    cboComputerIP.Text := '';
    edtAccountName.Text := '';
    editFilterCode.Text := '';
    editMoney.Text := '';
    seQuantity.Value := 1; 
  end;
end;

procedure TformSideline.editFilterCodeChange(Sender: TObject);
begin
  butSel.Enabled := (lvSideline.ItemIndex <> -1) and (editFilterCode.Text <> '');
  FillList;
end;

procedure TformSideline.FillList;
var
  i, n: integer;
  li: TListItem;
  noFilter: boolean;
begin
  FbControlsEnabled := False;
  lvSideline.Clear;
  noFilter := (editFilterCode.Text = '');
  for i:=0 to (Sideline.count-1) do 
  if ((noFilter) or ((Sideline.goods[i].id = StrToIntDef(editFilterCode.Text,-1)) or (Pos(editFilterCode.Text,Sideline.goods[i].name)>0))) then
  begin
    li := lvSideline.Items.Add;
    li.Caption := Sideline.goods[i].name;
    li.SubItems.Add(AnsiReplaceStr(FormatFloat('0.00',Sideline.goods[i].price),',','.'));
    li.SubItems.Add(IntToStr(Sideline.goods[i].id));
{    if (not noFilter) then begin
      li.Selected := true;
      UpdateInformation;
      break;
    end;}
  end;
  cboComputerNumber.Enabled := (TypeCost = stcSeparate);
  cboComputerIP.Enabled := (TypeCost = stcSeparate);
  if (TypeCost = stcSeparate) then begin
    with cboComputerNumber.Items do begin
      Clear;
      Add('');
    end;
    with cboComputerIP.Items do begin
      Clear;
      Add('');
    end;
    for i:=0 to (CompsCount-1) do
      if Comps[i].Busy and Comps[i].IsGuestSession then begin
        with cboComputerNumber.Items do begin
          n := Add(Comps[i].GetStrNumber);
          Objects[n] := Comps[i];
        end;
        with cboComputerIP.Items do begin
          n := Add(Comps[i].ipaddr);
          Objects[n] := Comps[i];
        end;
    end;
    edtAccountName.Text := translate('Guest');
  end else begin
    edtAccountName.Text := Session.GetStrClient;
    with cboComputerNumber.Items do begin
      Clear;
      Add(IntToStr(Comps[ComputersGetIndex(Session.IdComp)].number));
    end;
    with cboComputerIP.Items do begin
      Clear;
      Add(Session.GetIPAddress);
    end;
  end;
  cboComputerNumber.ItemIndex := 0;
  cboComputerIP.ItemIndex := 0;
  FbControlsEnabled := True;
end;

procedure TformSideline.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  // if ESC or F9 then quit
  if ((key=27) or (Key = 120)) then ModalResult := mrOk;
end;

procedure TformSideline.butHelpClick(Sender: TObject);
begin
  GCHelp(HELP_SERVICES);
end;

function TformSideline.ShowModal(ATypeCost: TSidelineTypeCost;
    ASession: TGCSession): Integer;
begin
  FTypeCost := ATypeCost;
  FSession := ASession;
  Result := inherited ShowModal;
end;

procedure TformSideline.cboComputerNumberChange(Sender: TObject);
begin
  if not ControlsEnabled then exit;
  DisableControls;
  cboComputerIP.ItemIndex := cboComputerNumber.ItemIndex;
  EnableControls;
end;

procedure TformSideline.EnableControls;
begin
  FbControlsEnabled := True;
end;

procedure TformSideline.DisableControls;
begin
  FbControlsEnabled := False;
end;


procedure TformSideline.cboComputerIPChange(Sender: TObject);
begin
  if not ControlsEnabled then exit;
  DisableControls;
  cboComputerNumber.ItemIndex := cboComputerIP.ItemIndex;
  EnableControls;
end;

procedure TformSideline.editFilterCodeKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_DOWN Then
    if lvSideline.Items.Count >0 then
    begin
      lvSideline.ItemFocused := lvSideline.Items[0];
      lvSideline.ItemIndex :=0;
      lvSideline.SetFocus;
    end;
  if Key = VK_RETURN Then
  begin
    if lvSideline.Items.Count >0 then
    begin
      lvSideline.ItemFocused := lvSideline.Items[0];
      lvSideline.ItemIndex :=0;
      lvSideline.SetFocus;
      UpdateInformation;
    end;
    if lvSideline.Items.Count = 1 then
      seQuantity.SetFocus;
  end;
end;

procedure TformSideline.lvSidelineKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_UP: UpdateInformation;
    VK_DOWN: UpdateInformation;
    VK_RETURN: seQuantity.SetFocus;
  end;
end;

procedure TformSideline.seQuantityKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_RETURN:butSelClick(sender);
  end;
end;

end.
