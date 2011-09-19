unit frameTarifs;

interface

uses
  GCConst, GCComputers, ADODB, GCCommon, GCLangUtils,
  SysUtils,DateUtils,
  Windows, Messages, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, Spin;

type
  TframTarifs = class(TFrame)
    lvTarifs: TListView;
    butTarifAdd: TButton;
    butTarifUpdate: TButton;
    butTarifDelete: TButton;
    cbInternet: TCheckBox;
    cbCalcTraffic: TCheckBox;
    editRoundMoney: TEdit;
    lblRoundMoney: TLabel;
    lblRoundT: TLabel;
    editRoundTime: TEdit;
    editTarifName: TEdit;
    lblTarifName: TLabel;
    butMoveUp: TButton;
    lblVariantsName: TLabel;
    editVariantsName: TEdit;
    lblVariantsCost: TLabel;
    editVariantsCost: TEdit;
    lblStart: TLabel;
    lblStop: TLabel;
    dtpVariantsStop: TDateTimePicker;
    butVariantsAdd: TButton;
    butVariantsUpdate: TButton;
    butVariantsDelete: TButton;
    cbThursday: TCheckBox;
    cbWednesday: TCheckBox;
    cbTuesday: TCheckBox;
    cbMonday: TCheckBox;
    cbFriday: TCheckBox;
    cbSaturday: TCheckBox;
    cbSunday: TCheckBox;
    lvVariants: TListView;
    gbCondition: TGroupBox;
    seQuantityHours: TSpinEdit;
    lblConditionHours: TLabel;
    checkCondition: TCheckBox;
    checkPacket: TCheckBox;
    dtpVariantsStart: TDateTimePicker;
    panelFuck: TPanel;
    cbConditionType: TEdit;
    cbComputerGroup: TComboBox;
    lblComputerGroup: TLabel;
    editTrafficFree: TEdit;
    lblTrafficFree: TLabel;
    lblKB: TLabel;
    editBytesInMB: TEdit;
    editTrafficCost: TEdit;
    cbTrafficSeparatePayment: TCheckBox;
    lblBytesInMB: TLabel;
    lblTrafficCost: TLabel;
    gbTraffic: TGroupBox;
    pgctrlDetails: TPageControl;
    tabNoTarif: TTabSheet;
    tabTarifSelected: TTabSheet;
    gbInternet: TGroupBox;
    gbTarif: TGroupBox;
    lblSpeedLimitInKB: TLabel;
    editSpeedLimitInKB: TEdit;
    lblPluginGroup: TLabel;
    editPluginGroup: TEdit;
    gbTarifVariants: TGroupBox;
    gbTrafficSeparatePayment: TGroupBox;
    gbPlugin: TGroupBox;
    cbxFreePacket: TCheckBox;
    lblUserLevel: TLabel;
    cbUserLevel: TComboBox;
    gbSum: TGroupBox;
    lblStartMoneyMin: TLabel;
    lblStartMoneyMax: TLabel;
    lblAddMoneyMin: TLabel;
    lblAddMoneyMax: TLabel;
    lblMaximumTrust: TLabel;
    edtStartMoneyMin: TEdit;
    edtStartMoneyMax: TEdit;
    edtAddMoneyMin: TEdit;
    edtAddMoneyMax: TEdit;
    edtMaximumTrust: TEdit;
    cbSumm: TCheckBox;
    procedure lvTarifsClick(Sender: TObject);
    procedure butMoveUpClick(Sender: TObject);
    procedure butTarifAddClick(Sender: TObject);
    procedure butTarifDeleteClick(Sender: TObject);
    procedure butTarifUpdateClick(Sender: TObject);
    procedure lvVariantsClick(Sender: TObject);
    procedure butVariantsDeleteClick(Sender: TObject);
    procedure editVariantsNameChange(Sender: TObject);
    procedure editVariantsCostChange(Sender: TObject);
    procedure dtpVariantsStopChange(Sender: TObject);
    procedure cbMondayClick(Sender: TObject);
    procedure editTarifNameChange(Sender: TObject);
    procedure cbInternetClick(Sender: TObject);
    procedure butVariantsAddClick(Sender: TObject);
    procedure butVariantsUpdateClick(Sender: TObject);
    procedure checkConditionClick(Sender: TObject);
    procedure checkPacketClick(Sender: TObject);
    procedure seQuantityHoursChange(Sender: TObject);
    procedure cbConditionType2Change(Sender: TObject);
    procedure dtpVariantsStartChange(Sender: TObject);
    procedure editRoundMoneyChange(Sender: TObject);
    procedure editRoundTimeChange(Sender: TObject);
    procedure cbComputerGroupSelect(Sender: TObject);
    procedure cbTrafficSeparatePaymentClick(Sender: TObject);
    procedure editBytesInMBExit(Sender: TObject);
    procedure cbxFreePacketClick(Sender: TObject);
    procedure cbUserLevelChange(Sender: TObject);
    procedure cbSummClick(Sender: TObject);
    procedure edtStartMoneyMinKeyPress(Sender: TObject; var Key: Char);
    procedure edtAddMoneyMinKeyPress(Sender: TObject; var Key: Char);
    procedure edtMaximumTrustKeyPress(Sender: TObject; var Key: Char);
    procedure edtStartMoneyMaxKeyPress(Sender: TObject; var Key: Char);
    procedure edtAddMoneyMaxKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    lockwhole: boolean;
    locktarif: boolean;
    procedure UpdateTarifsList;
    procedure UpdateTarifsInterface;
    procedure UpdateVariantsList;
    procedure UpdateVariantsInterface;
    procedure UpdateComputerGroupComboBox;
    procedure ResetFrame;
    function CheckValuesOK: boolean;

  function IsFirstNonPackedTarifVariant(AnTarifVariantIndex: Integer): Boolean;
  function GetTarifSeparatePayment: Boolean;
  procedure TarifCloneSeparatePayment(AbSeparatePayment: Boolean);

  public
    function GetID: integer;
    procedure Activate(ID: integer);
    { Public declarations }
  end;

implementation

uses
  frmMain,
  frmGCMessageBox,
  uProtocol,
  StrUtils,
  uY2KString,
  uRegistry,
  uTariffication;

{$R *.dfm}

procedure TframTarifs.UpdateVariantsList;
var
  TarifVariants: TTarifVariants;
  Tarif: TTarif;
  dts: TADODataSet;
  li: TListItem;
  str: string;
  i: integer;
begin
  lockwhole := true;
  if lvVariants.Items.Count>0 then
    for i:=0 to (lvVariants.Items.Count-1) do
    begin
      TarifVariants := lvVariants.Items[i].Data;
      TarifVariants.Destroy;
    end;
  lvVariants.Clear;

  editVariantsName.Text := '';
  editVariantsCost.Text := '';
  dtpVariantsStart.Time := StrToTime('0:00:00');
  dtpVariantsStop.Time := StrToTime('0:00:00');
  cbMonday.Checked := false;
  cbTuesday.Checked := false;
  cbWednesday.Checked := false;
  cbThursday.Checked := false;
  cbFriday.Checked := false;
  cbSaturday.Checked := false;
  cbSunday.Checked := false;
  checkPacket.Checked := false;
  cbxFreePacket.Checked := false;
  cbxFreePacket.Enabled := false;
  checkCondition.Checked := false;
  checkPacketClick(nil);

  butVariantsAdd.Enabled := false;
  butVariantsUpdate.Enabled := false;
  butVariantsDelete.Enabled := false;
  editTrafficFree.Text := '0';
  editTrafficCost.Text := '0';
  editTrafficFree.Enabled := False;
  lblTrafficCost.Enabled := cbInternet.Checked;
  editTrafficCost.Enabled := cbInternet.Checked;
  cbTrafficSeparatePayment.Enabled := cbInternet.Checked;
  lblTrafficFree.Enabled := cbTrafficSeparatePayment.Checked;
  editTrafficFree.Enabled := cbTrafficSeparatePayment.Checked;
  lblKB.Enabled := cbTrafficSeparatePayment.Checked;

  if (lvTarifs.ItemIndex <> -1) then
  begin
    Tarif := lvTarifs.Items[lvTarifs.ItemIndex].Data;
    if (dsConnected) then
    begin
      dts := TADODataSet.Create(nil);
      dsDoQuery(DS_TARIFSVARIANTS_SELECT + ' @idTarifs='+IntToStr(Tarif.id), @dts);
      while (dts.Recordset.RecordCount > 0) and (not dts.Recordset.EOF) do
      begin
        TarifVariants := TTarifVariants.Create;
        TarifVariants.id := dts.Recordset.Fields.Item['id'].Value;
        TarifVariants.idTarif := Tarif.id;
        TarifVariants.name := dts.Recordset.Fields.Item['name'].Value;
        TarifVariants.start := dts.Recordset.Fields.Item['start'].Value;
        TarifVariants.stop := dts.Recordset.Fields.Item['stop'].Value;
        TarifVariants.cost := dts.Recordset.Fields.Item['cost'].Value;
        TarifVariants.ispacket := (dts.Recordset.Fields.Item['ispacket'].Value = 1);
        TarifVariants.bCondition := (dts.Recordset.Fields.Item['condition'].Value <> '');
        TarifVariants.TrafficLimit := dts.Recordset.Fields.Item['TrafficLimit'].Value;
        TarifVariants.TrafficCost := dts.Recordset.Fields.Item['TrafficCost'].Value;
        TarifVariants.TrafficSeparatePayment := dts.Recordset.Fields.Item['TrafficSeparatePayment'].Value;
        TarifVariants.FreePacket := dts.Recordset.Fields.Item['FreePacket'].Value;
        if (TarifVariants.bCondition) then
        begin
          TarifVariants.ConditionType := GetParamFromString(dts.Recordset.Fields.Item['condition'].Value,0);
          TarifVariants.ConditionValue := StrToIntDef(GetParamFromString(dts.Recordset.Fields.Item['condition'].Value,1),60);
        end;
        str := '';
        TarifVariants.daysofweek := dts.Recordset.Fields.Item['daysofweek'].Value;
        for i:=1 to StrLen(PChar(TarifVariants.daysofweek)) do
          str := str + GetShortWeekDay(StrToInt(TarifVariants.daysofweek[i])) + ' ';
        if (TarifVariants.daysofweek = '1234567') then str := translate('All');

        li := lvVariants.Items.Add;
        li.Caption := TarifVariants.name;
        li.SubItems.Insert(0, FormatDateTime('hh:nn',TarifVariants.Start));
        li.SubItems.Insert(1, FormatDateTime('hh:nn',TarifVariants.Stop));
        li.SubItems.Insert(2, FormatFloat('0.00',TarifVariants.cost));
        if (TarifVariants.ispacket) then li.SubItems.Insert(3,translate('P')) else li.SubItems.Insert(3,translate('H'));

        if (TarifVariants.bCondition) then begin
          li.SubItems.Insert(4,TarifVariants.ConditionType + ' '+ IntToStr(TarifVariants.ConditionValue));
        end
        else
          li.SubItems.Insert(4,'');
        li.SubItems.Insert(5, str);
        li.Data := TarifVariants;
        dts.Recordset.MoveNext;
      end;
      dts.Close;
      dts.Destroy;
    end;
  end;
  lockwhole := false;
end;

procedure TframTarifs.UpdateTarifsList;
var
  i: integer;
  li: TListItem;
  Tarif: TTarif;
  dts: TADODataSet;
begin
  locktarif := true;

  if lvTarifs.Items.Count>0 then
    for i:=0 to (lvTarifs.Items.Count-1) do
    begin
      Tarif := lvTarifs.Items[i].Data;
      Tarif.Destroy;
    end;
  lvTarifs.Clear;

  if (dsConnected) then
  begin
    dts := TADODataSet.Create(nil);
    dsDoQuery(DS_TARIFS_SELECT + ' @idGroup='+
      IntToStr(TComputerGroup(cbComputerGroup.Items.Objects[cbComputerGroup.ItemIndex]).Id), @dts);
    while (dts.Recordset.RecordCount > 0) and (not dts.Recordset.EOF) do
    begin
      Tarif := TTarif.Create;
      Tarif.id := dts.Recordset.Fields.Item['id'].Value;
      Tarif.name := dts.Recordset.Fields.Item['name'].Value;
      Tarif.internet := dts.Recordset.Fields.Item['internet'].Value;
      Tarif.calctraffic := dts.Recordset.Fields.Item['calctraffic'].Value;
      Tarif.roundtime := dts.Recordset.Fields.Item['roundtime'].Value;
      Tarif.roundmoney := dts.Recordset.Fields.Item['roundmoney'].Value;
      Tarif.BytesInMB := dts.Recordset.Fields.Item['BytesInMB'].Value;
      Tarif.SpeedLimitInKB := dts.Recordset.Fields.Item['SpeedLimitInKB'].Value;
      Tarif.PluginGroupName := dts.Recordset.Fields.Item['PluginGroupName'].Value;
      Tarif.userlevel := dts.Recordset.Fields.Item['userlevel'].Value;

      Tarif.useseparatesumm  := dts.Recordset.Fields.Item['useseparatesumm'].Value;
      Tarif.startmoneymin := dts.Recordset.Fields.Item['startmoneymin'].Value;
      Tarif.startmoneymax := dts.Recordset.Fields.Item['startmoneymax'].Value;
      Tarif.addmoneymin := dts.Recordset.Fields.Item['addmoneymin'].Value;
      Tarif.addmoneymax := dts.Recordset.Fields.Item['addmoneymax'].Value;
      Tarif.maximumtrust := dts.Recordset.Fields.Item['maximumtrust'].Value;

      li := lvTarifs.Items.Add;
      li.Caption := Tarif.name;
      li.Data := Tarif;
      dts.Recordset.MoveNext;
    end;
    dts.Close;
    dts.Destroy;

    butTarifAdd.Enabled := false;
    butTarifDelete.Enabled := false;
    butTarifUpdate.Enabled := false;
    butMoveUp.Enabled := false;
    editTarifName.Text := '';
    editRoundMoney.Text := '';
    editRoundTime.Text := '';
    editBytesInMB.Text := '';
    editSpeedLimitInKB.Text := '';
    editPluginGroup.Text := '';
    cbInternet.Checked := false;
    cbCalcTraffic.Checked := false;
    cbUserLevel.Text := '';

    cbSumm.Checked := false; 
    edtStartMoneyMax.Text := '';
    edtStartMoneyMin.Text := '';
    edtAddMoneyMax.Text := '';
    edtAddMoneyMin.Text := '';
    edtMaximumTrust.Text := '';



  end;

  pgctrlDetails.ActivePage := tabNoTarif;
  UpdateVariantsList;
  locktarif := false;

  if not GRegistry.UserInterface.DontShow.InputInTarifs then
  begin
    formGCMessageBox.memoInfo.Text := translate('InputInTarifsOn');
    formGCMessageBox.SetDontShowAgain(true);
    formGCMessageBox.ShowModal;
    GRegistry.UserInterface.DontShow.InputInTarifs :=
        formGCMessageBox.cbNotShowAgain.Checked;
  end;
end;

function TframTarifs.GetID: integer;
begin
  GetID := FRAME_TARIFS;
end;

procedure TframTarifs.UpdateComputerGroupComboBox;
var
  Group: TComputerGroup;
  dts: TADODataSet;
  i: Integer;
begin
  cbComputerGroup.Items.Clear;
  if (dsConnected) then
  begin
    dts := TADODataSet.Create(nil);
    dsDoQuery(DS_COMPUTERGROUPS_SELECT, @dts);
    CompGroupsCount := dts.Recordset.RecordCount;
    while (CompGroupsCount > 0) and (not dts.Recordset.EOF) do
    begin
      Group := TComputerGroup.Create;
      Group.Id := dts.Recordset.Fields.Item['id'].Value;
      Group.Name := dts.Recordset.Fields.Item['name'].Value;

      i := cbComputerGroup.Items.Add(Group.Name);
      cbComputerGroup.Items.Objects[i] := Group;
      dts.Recordset.MoveNext;
    end;
    dts.Close;
    dts.Destroy;
  end;
  cbComputerGroup.ItemIndex := 0;
end;


// процедура ставит все контролы в исходные позиции
procedure TframTarifs.ResetFrame;
begin
  lockwhole := false;
  locktarif := false;
  UpdateTarifsList;
end;

procedure TframTarifs.Activate(ID: integer);
begin
  Visible := (GetID = ID);
  if (not Visible) then exit;
  UpdateComputerGroupComboBox;
  ResetFrame;

  panelFuck.Caption := translate('panelFuck');
  butTarifAdd.Caption := translate('Add');
  butTarifUpdate.Caption := translate('Update');
  butTarifDelete.Caption := translate('Delete');
  butMoveUp.Caption := translate('butMoveUp');
  lblTarifName.Caption := translate('Name');
  lblRoundMoney.Caption := translate('lblRoundMoney');
  lblRoundT.Caption := translate('lblRoundT');
  cbInternet.Caption := translate('Internet');
  cbCalcTraffic.Caption := translate('CalcTraffic');

  lblVariantsName.Caption := translate('Name');
  lblVariantsCost.Caption := translate('Cost');
  lblStart.Caption := translate('From');
  lblStop.Caption := translate('To');
  cbMonday.Caption := translate('MondayShort');
  cbTuesday.Caption := translate('TuesdayShort');
  cbWednesday.Caption := translate('WednesdayShort');
  cbThursday.Caption := translate('ThursdayShort');
  cbFriday.Caption := translate('FridayShort');
  cbSaturday.Caption := translate('SaturdayShort');
  cbSunday.Caption := translate('SundayShort');

  gbTarifVariants.Caption := translate('lblTarifsVariants');
  checkPacket.Caption := translate('checkPacket');

  lvVariants.Columns[0].Caption := translate('Name');
  lvVariants.Columns[1].Caption := translate('From');
  lvVariants.Columns[2].Caption := translate('To');
  lvVariants.Columns[3].Caption := translate('Cost');
  lvVariants.Columns[5].Caption := translate('Condition');
  lvVariants.Columns[6].Caption := translate('DaysOfWeek');

  checkCondition.Caption := translate('Condition');

  cbConditionType.Text := CONDITION_EQUALMORE;
  lblConditionHours.Caption := translate('butMinutes');

  checkPacket.Checked := false;
  checkPacketClick(nil);

  editTrafficFree.Text := '0';
  editTrafficCost.Text := '0';
  editTrafficFree.Enabled := False;
  lblTrafficFree.Caption := translate('Free');
  lblKB.Caption := translate('KB');;

  butVariantsAdd.Caption := translate('Add');
  butVariantsUpdate.Caption := translate('Update');
  butVariantsDelete.Caption := translate('Delete');

  lvTarifs.Columns[0].Caption := translate('Tarif');
  lblComputerGroup.Caption := translate('lblComputerGroup');

  lblBytesInMB.Caption := translate('TrafficByteInMB');
  lblTrafficCost.Caption := translate('Cost');
  cbTrafficSeparatePayment.Caption := translate('SeparatePaymentShort');
  gbPlugin.Caption := translate('TrafficPluginSettings');
  lblSpeedLimitInKB.Caption := translate('SpeedLimitInKB');
  gbTraffic.Caption := translate('Traffic');
  lblPluginGroup.Caption := translate('Group');

  lblTrafficCost.Enabled := cbInternet.Checked;
  editTrafficCost.Enabled := cbInternet.Checked;
  cbTrafficSeparatePayment.Enabled := cbInternet.Checked;
  lblTrafficFree.Enabled := cbInternet.Checked;
  editTrafficFree.Enabled := cbInternet.Checked;
  lblKB.Enabled := cbInternet.Checked;

  pgctrlDetails.ActivePage := tabNoTarif;

end;


procedure TframTarifs.lvTarifsClick(Sender: TObject);
var
  Tarif: TTarif;
begin
 if (lvTarifs.ItemIndex <> -1) then
 begin
   locktarif := true;
   Tarif := lvTarifs.Items[lvTarifs.ItemIndex].Data;
   butTarifDelete.Enabled := true;
   butTarifUpdate.Enabled := false;   
   butMoveUp.Enabled := true;
   editTarifName.Text := Tarif.name;
   editRoundMoney.Text := FloatToStrGC(Tarif.roundmoney);
   editRoundTime.Text := IntToStr(Tarif.roundtime);
   cbInternet.Checked := (Tarif.internet = 1);
   cbCalcTraffic.Checked := (Tarif.calctraffic = 1);
   editBytesInMB.Text := IntToStr(Tarif.BytesInMB);
   editSpeedLimitInKB.Text := IntToStr(Tarif.SpeedLimitInKB);
   editPluginGroup.Text := Tarif.PluginGroupName;
   gbTraffic.Enabled := cbInternet.Checked;
   lblTrafficCost.Enabled := cbInternet.Checked;
   lblTrafficFree.Enabled := cbInternet.Checked;
   lblKB.Enabled := cbInternet.Checked;
   editTrafficFree.Enabled := cbInternet.Checked;
   editTrafficCost.Enabled := cbInternet.Checked;
   cbTrafficSeparatePayment.Enabled := cbInternet.Checked;
   cbUserLevel.Text := IntToStr(Tarif.userlevel); 

   cbSumm.Checked := (Tarif.useseparatesumm = 1);
   edtStartMoneyMin.Text := IntToStr(Tarif.startmoneymin);
   edtStartMoneyMax.Text := IntToStr(Tarif.startmoneymax);
   edtAddMoneyMin.Text := IntToStr(Tarif.addmoneymin);
   edtAddMoneyMax.Text := IntToStr(Tarif.addmoneymax);
   edtMaximumTrust.Text := IntToStr(Tarif.maximumtrust);

   UpdateVariantsList;
   locktarif := false;
   pgctrlDetails.ActivePage := tabTarifSelected;
 end;
end;

procedure TframTarifs.butMoveUpClick(Sender: TObject);
var
  Tarif: TTarif;
begin
  if (lvTarifs.ItemIndex <> -1) then
  begin
    Tarif := lvTarifs.Items[lvTarifs.ItemIndex].Data;
    dsDoCommand(DS_TARIFS_MOVEUP + ' @idTarif='+IntToStr(Tarif.id));
    UpdateTarifsList;
  end;
end;

procedure TframTarifs.butTarifAddClick(Sender: TObject);
var
  internet: string;
  calctraffic: string;
begin
  if (Not CheckValuesOK) then exit;
  if (cbInternet.Checked) then internet := '1' else internet := '0';
  if (cbCalcTraffic.Checked) then calctraffic := '1' else calctraffic := '0';  
  dsDoCommand(DS_TARIFS_ADD + ' @name='''+editTarifName.Text+''', @internet='+internet +
    ', @calctraffic='+calctraffic +', @roundtime='+editRoundTime.Text+', @roundmoney='+
    AnsiReplaceStr(editRoundMoney.Text,',','.') + ', @idGroup='+
    IntToStr(TComputerGroup(cbComputerGroup.Items.Objects[cbComputerGroup.ItemIndex]).Id)+
    ', @BytesInMB='+ editBytesInMB.Text
    + ', @SpeedLimitInKB='+ editSpeedLimitInKB.Text
    + ', @PluginGroupName=''' + editPluginGroup.Text + '''');
  UpdateTarifsList;
end;

procedure TframTarifs.butTarifDeleteClick(Sender: TObject);
var
  Tarif: TTarif;
begin
  if (lvTarifs.ItemIndex <> -1) then
  begin
    Tarif := lvTarifs.Items[lvTarifs.ItemIndex].Data;
    dsDoCommand(DS_TARIFS_DELETE + ' @idTarif='+IntToStr(Tarif.id));
    UpdateTarifsList;
  end;
end;

function TframTarifs.CheckValuesOK: boolean;
var
  nn: double;
  n: integer;
begin
  CheckValuesOK := true;
  nn := StrToFloatGC(editRoundMoney.Text);
  n := StrToIntDef(editRoundTime.Text,1);
  editRoundTime.Text := IntToStr(n);
  if (nn<=0) then begin
    MessageBox(HWND_TOP,PChar(translate('Warning_Int_more_zero')),PChar(translate('Warning')),MB_OK or MB_ICONERROR);
    CheckValuesOK := false;
  end;
end;

procedure TframTarifs.butTarifUpdateClick(Sender: TObject);
var
  internet: string;
  separatesumm: string;
  calctraffic: string;
  Tarif: TTarif;
begin
  if (Not CheckValuesOK) then exit;
  if (lvTarifs.ItemIndex <> -1) then
  begin
    if (cbInternet.Checked) then internet := '1' else internet := '0';
    if (cbSumm.Checked) then separatesumm := '1' else separatesumm := '0';
    if (cbCalcTraffic.Checked) then calctraffic := '1' else calctraffic := '0';
    Tarif := lvTarifs.Items[lvTarifs.ItemIndex].Data;
    dsDoCommand(DS_TARIFS_UPDATE + ' @idTarif='+ IntToStr(Tarif.id)
      + ', @name=''' + editTarifName.Text
      + ''', @internet=' + internet
      + ', @calctraffic=' + calctraffic
      + ', @roundtime=' + editRoundTime.Text
      + ', @roundmoney=' + AnsiReplaceStr(editRoundMoney.Text,',','.')
      + ', @idGroup=' + IntToStr(TComputerGroup(cbComputerGroup.Items.Objects[cbComputerGroup.ItemIndex]).Id)
      + ', @BytesInMB='+editBytesInMB.Text
      + ', @SpeedLimitInKB='+ editSpeedLimitInKB.Text
      + ', @PluginGroupName=''' + editPluginGroup.Text
      + ''', @userlevel=' + cbUserLevel.Text
      + ', @useseparatesumm=' + separatesumm
      + ', @startmoneymin=' + edtStartMoneyMin.Text
      + ', @startmoneymax=' + edtStartMoneyMax.Text
      + ', @addmoneymin=' + edtAddMoneyMin.Text
      + ', @addmoneymax=' + edtAddMoneyMax.Text
      + ', @maximumtrust=' + edtMaximumTrust.Text
      );
    UpdateTarifsList;
  end;
end;

procedure TframTarifs.lvVariantsClick(Sender: TObject);
var
  TarifVariants: TTarifVariants;
  i,day: integer;  
begin
  lockwhole := true;
  if (lvVariants.ItemIndex <> -1) then
  begin
    TarifVariants := lvVariants.Items[lvVariants.ItemIndex].Data;

    cbMonday.Checked := false;
    cbTuesday.Checked := false;
    cbWednesday.Checked := false;
    cbThursday.Checked := false;
    cbFriday.Checked := false;
    cbSaturday.Checked := false;
    cbSunday.Checked := false;

    for i:=1 to StrLen(PChar(TarifVariants.daysofweek)) do
    begin
      day := StrToInt(TarifVariants.daysofweek[i]);
      if (day=1) then cbMonday.Checked := true;
      if (day=2) then cbTuesday.Checked := true;
      if (day=3) then cbWednesday.Checked := true;
      if (day=4) then cbThursday.Checked := true;
      if (day=5) then cbFriday.Checked := true;
      if (day=6) then cbSaturday.Checked := true;
      if (day=7) then cbSunday.Checked := true;
    end;
/////////////////////////////////
   gbTraffic.Enabled := cbInternet.Checked;
   lblTrafficCost.Enabled := cbInternet.Checked;
   lblTrafficFree.Enabled := cbInternet.Checked;
   lblKB.Enabled := cbInternet.Checked;
   editTrafficFree.Enabled := cbInternet.Checked;
   editTrafficCost.Enabled := cbInternet.Checked;
   cbTrafficSeparatePayment.Enabled := cbInternet.Checked;

//////////////////////////////////
    editVariantsName.Text := TarifVariants.name;
    editVariantsCost.Text := FormatFloat('0.00',TarifVariants.cost);
    dtpVariantsStart.Time := TimeOf(TarifVariants.start);
    dtpVariantsStop.Time := TimeOf(TarifVariants.stop);
    checkPacket.Checked := TarifVariants.ispacket;
    cbxFreePacket.Checked := TarifVariants.FreePacket;
    checkCondition.Checked := TarifVariants.bCondition;
    editTrafficFree.Text := IntToStr(TarifVariants.TrafficLimit);
    editTrafficCost.Text := FormatFloat('0.00',TarifVariants.TrafficCost);
    if cbInternet.Checked = True then begin //по халявному траффику и отдельной оплате
      if TarifVariants.ispacket then begin
        cbTrafficSeparatePayment.Checked := True;
        cbTrafficSeparatePayment.Enabled := False;
      end
      else begin
        if IsFirstNonPackedTarifVariant(lvVariants.ItemIndex) then begin
          cbTrafficSeparatePayment.Checked := TarifVariants.TrafficSeparatePayment;
          cbTrafficSeparatePayment.Enabled := True;
        end
        else begin
          cbTrafficSeparatePayment.Checked := GetTarifSeparatePayment;
          cbTrafficSeparatePayment.Enabled := False;
        end;
      end;
      lblTrafficFree.Enabled := cbTrafficSeparatePayment.Checked;
      editTrafficFree.Enabled := cbTrafficSeparatePayment.Checked;
      lblKB.Enabled := cbTrafficSeparatePayment.Checked;
    end;

    if (TarifVariants.bCondition) then begin
      seQuantityHours.Value := TarifVariants.ConditionValue;
    end;
    butVariantsDelete.Enabled := true;
    butVariantsAdd.Enabled := false;
    butVariantsUpdate.Enabled := false;
  end;
  lockwhole := false;
  UpdateVariantsInterface;
end;

procedure TframTarifs.butVariantsDeleteClick(Sender: TObject);
var
  TarifVariants: TTarifVariants;
begin
  if (lvVariants.ItemIndex <> -1) then
  begin
    TarifVariants := lvVariants.Items[lvVariants.ItemIndex].Data;
    dsDoCommand(DS_TARIFSVARIANTS_DELETE + ' @idVariants='+IntToStr(TarifVariants.id));
    UpdateVariantsList;
  end;
end;

// фукнция прикидывает, какие кнопки включать, какие выключать
procedure TframTarifs.UpdateVariantsInterface;
var
  i: integer;
  equal: boolean;
begin
  if lockwhole then exit;
 // if (lvVariants.ItemIndex = -1) then exit;
  equal := false;
  for i:=0 to lvVariants.Items.Count-1 do
   if (lvVariants.Items[i].Caption = editVariantsName.Text) then
     equal := true;

  butVariantsAdd.Enabled := ((editVariantsName.Text<>'') and (editVariantsCost.Text<>'') and (not equal));
  butVariantsUpdate.Enabled := (lvVariants.ItemIndex <> -1);
  cbxFreePacket.Enabled := checkPacket.Checked;
  if (cbxFreePacket.Checked and checkPacket.Checked) then begin
    dtpVariantsStop.Enabled := False;
    lblStop.Enabled := False;
    lblStart.Caption := translate('Time');
  end else begin
    dtpVariantsStop.Enabled := True;
    lblStop.Enabled := True;
    lblStart.Caption := translate('From');;
  end;

end;

procedure TframTarifs.editVariantsNameChange(Sender: TObject);
begin
  UpdateVariantsInterface;
end;

procedure TframTarifs.editVariantsCostChange(Sender: TObject);
begin
  UpdateVariantsInterface;
end;

procedure TframTarifs.dtpVariantsStopChange(Sender: TObject);
begin
  UpdateVariantsInterface;
end;

procedure TframTarifs.cbMondayClick(Sender: TObject);
begin
  UpdateVariantsInterface;
end;

procedure TframTarifs.UpdateTarifsInterface;
var
  i: integer;
  equal: boolean;
begin
  if locktarif then exit;
  equal := false;
  for i:=0 to lvTarifs.Items.Count-1 do
   if (lvTarifs.Items[i].Caption = editTarifName.Text) then
     equal := true;

  butTarifAdd.Enabled := ((editTarifName.Text<>'') and (editRoundMoney.Text<>'') and (editRoundTime.Text<>'') and (not equal));
  butTarifUpdate.Enabled := true;

  edtStartMoneyMax.Enabled := cbSumm.Checked;
  edtStartMoneyMin.Enabled := cbSumm.Checked;
  edtAddMoneyMax.Enabled := cbSumm.Checked;
  edtAddMoneyMin.Enabled := cbSumm.Checked;
  edtMaximumTrust.Enabled := cbSumm.Checked;
end;

procedure TframTarifs.editTarifNameChange(Sender: TObject);
begin
  UpdateTarifsInterface;
end;

procedure TframTarifs.cbInternetClick(Sender: TObject);
begin
  UpdateTarifsInterface;
end;

procedure TframTarifs.butVariantsAddClick(Sender: TObject);
var
  Tarif: TTarif;
  query,str,sCondition,sIsPacket: string;
begin
  if (lvTarifs.ItemIndex <> -1) then
  begin
    Tarif := lvTarifs.Items[lvTarifs.itemindex].Data;
    str := '';
    if (cbMonday.Checked) then str := str + '1';
    if (cbTuesday.Checked) then str := str + '2';
    if (cbWednesday.Checked) then str := str + '3';
    if (cbThursday.Checked) then str := str + '4';
    if (cbFriday.Checked) then str := str + '5';
    if (cbSaturday.Checked) then str := str + '6';
    if (cbSunday.Checked) then str := str + '7';

    sIsPacket := '0';
    if (checkPacket.Checked) then sIsPacket := '1';
    sCondition := '';
    if (checkCondition.Checked) then
      sCondition := cbConditionType.Text + '/' + IntToStr(seQuantityHours.Value);

    query := DS_TARIFSVARIANTS_ADD + ' @idTarifs='+IntToStr(Tarif.id) +
    ', @name='''+editVariantsName.Text+''', @start='''+DateTimeToSql(dtpVariantsStart.Time)+''''+
    ', @stop='''+DateTimeToSql(dtpVariantsStop.Time)+''', @cost='+AnsiReplaceStr(editVariantsCost.Text,',','.')+
    ', @daysofweek='''+str+''', @ispacket='+ sIsPacket + ', @condition=''' + sCondition + '''' +
    ', @TrafficLimit='+editTrafficFree.Text+
    ', @TrafficCost='+AnsiReplaceStr(editTrafficCost.Text,',','.')+
    ', @TrafficSeparatePayment='
    + IfThen(cbTrafficSeparatePayment.Checked,'1','0')+
    ', @FreePacket='+ IfThen(cbxFreePacket.Checked,'1','0');

    dsDoCommand(query);
    UpdateVariantsList;
  end;
end;

procedure TframTarifs.butVariantsUpdateClick(Sender: TObject);
var
  TarifVariants: TTarifVariants;
  query,str,sCondition,sIsPacket: string;
begin
  if (lvVariants.ItemIndex <> -1) then begin
    str := '';
    if (cbMonday.Checked) then str := str + '1';
    if (cbTuesday.Checked) then str := str + '2';
    if (cbWednesday.Checked) then str := str + '3';
    if (cbThursday.Checked) then str := str + '4';
    if (cbFriday.Checked) then str := str + '5';
    if (cbSaturday.Checked) then str := str + '6';
    if (cbSunday.Checked) then str := str + '7';

    TarifVariants := lvVariants.Items[lvVariants.ItemIndex].Data;
    sIsPacket := '0';
    if (checkPacket.Checked) then sIsPacket := '1';
    sCondition := '';
    if (checkCondition.Checked) then
      sCondition := cbConditionType.Text + '/' + IntToStr(seQuantityHours.Value);

    query := DS_TARIFSVARIANTS_UPDATE + ' @idVariants='+IntToStr(TarifVariants.id) +
    ', @name='''+editVariantsName.Text+''', @start='''+DateTimeToSql(dtpVariantsStart.Time)+''''+
    ', @stop='''+DateTimeToSql(dtpVariantsStop.Time)+''', @cost='+AnsiReplaceStr(editVariantsCost.Text,',','.')+
    ', @daysofweek='''+str+''', @ispacket='+ sIsPacket + ', @condition=''' + sCondition + '''' +
    ', @TrafficLimit='+editTrafficFree.Text+
    ', @TrafficCost='+AnsiReplaceStr(editTrafficCost.Text,',','.')+
    ', @TrafficSeparatePayment='
    + IfThen(cbTrafficSeparatePayment.Checked,'1','0')
    + ', @FreePacket='+ IfThen(cbxFreePacket.Checked,'1','0');

    dsDoCommand(query);
    UpdateVariantsList;
  end;
end;

procedure TframTarifs.checkConditionClick(Sender: TObject);
begin
  cbConditionType.Enabled := checkCondition.Checked and checkCondition.Enabled;
  seQuantityHours.Enabled := checkCondition.Checked and checkCondition.Enabled;
  lblConditionHours.Enabled := checkCondition.Checked and checkCondition.Enabled;
  UpdateVariantsInterface;
end;

procedure TframTarifs.checkPacketClick(Sender: TObject);
begin
  checkCondition.Enabled := not checkPacket.Checked;
  editTrafficFree.Enabled := checkPacket.Checked;
  if (checkPacket.Checked = false) then checkCondition.Checked := false;
  checkConditionClick(Sender);
  UpdateVariantsInterface;
end;

procedure TframTarifs.seQuantityHoursChange(Sender: TObject);
begin
  UpdateVariantsInterface;
end;

procedure TframTarifs.cbConditionType2Change(Sender: TObject);
begin
  UpdateVariantsInterface;
end;

procedure TframTarifs.dtpVariantsStartChange(Sender: TObject);
begin
  UpdateVariantsInterface;
end;

procedure TframTarifs.editRoundMoneyChange(Sender: TObject);
begin
  UpdateTarifsInterface;
end;

procedure TframTarifs.editRoundTimeChange(Sender: TObject);
begin
  UpdateTarifsInterface;
end;

procedure TframTarifs.cbComputerGroupSelect(Sender: TObject);
begin
  UpdateTarifsList;
end;

procedure TframTarifs.cbTrafficSeparatePaymentClick(Sender: TObject);
var
  TarifVariants: TTarifVariants;
begin
  if (lvVariants.ItemIndex <> -1) then
  begin
    TarifVariants := lvVariants.Items[lvVariants.ItemIndex].Data;
    TarifVariants.TrafficSeparatePayment := cbTrafficSeparatePayment.Checked;
    If Not TarifVariants.ispacket then
      TarifCloneSeparatePayment(TarifVariants.TrafficSeparatePayment);
  end;
  UpdateVariantsInterface;
end;


function TframTarifs.IsFirstNonPackedTarifVariant(AnTarifVariantIndex: Integer): Boolean;
var
  i: Integer;
  bNonPackedVariant: Boolean;
begin
  IsFirstNonPackedTarifVariant := False;
  bNonPackedVariant := False;
  i:=0;
  while ((not bNonPackedVariant) and (i<=lvVariants.Items.Count-1)) do begin
    if not TTarifVariants(lvVariants.Items[i].Data).ispacket then
      bNonPackedVariant := True;
    Inc(i);
  end;
  if bNonPackedVariant and ((i-1) = AnTarifVariantIndex) then
    IsFirstNonPackedTarifVariant := True;
end;

function TframTarifs.GetTarifSeparatePayment: Boolean;
var
  i: Integer;
  bNonPackedVariant: Boolean;
begin
  GetTarifSeparatePayment := False;
  bNonPackedVariant := False;
  i:=0;
  while ((not bNonPackedVariant) and (i<=lvVariants.Items.Count-1)) do begin
    if not TTarifVariants(lvVariants.Items[i].Data).ispacket then
      bNonPackedVariant := True;
    Inc(i);
  end;
  if bNonPackedVariant and (TTarifVariants(lvVariants.Items[i-1].Data).TrafficSeparatePayment) then
    GetTarifSeparatePayment := True;
end;

procedure TframTarifs.TarifCloneSeparatePayment(AbSeparatePayment: Boolean);
var
  i: Integer;
begin
  for i:=0 to lvVariants.Items.Count-1 do
    if not TTarifVariants(lvVariants.Items[i].Data).ispacket then
      TTarifVariants(lvVariants.Items[i].Data).TrafficSeparatePayment := AbSeparatePayment;
end;

procedure TframTarifs.editBytesInMBExit(Sender: TObject);
var
  nCount: Integer;
begin
  nCount := 0;
  try
    nCount := StrToInt(editBytesInMB.Text);
  except
  end;
  if (nCount <= 0) then begin
    MessageBox(HWND_TOP, PChar(translate('TrafficByteInMBWarning')),PChar('GameClass Error'),MB_OK or MB_ICONERROR);
    editBytesInMB.SetFocus;
  end;
end;

procedure TframTarifs.cbxFreePacketClick(Sender: TObject);
begin
  UpdateVariantsInterface;
end;

procedure TframTarifs.cbUserLevelChange(Sender: TObject);
begin
  UpdateTarifsInterface
end;

procedure TframTarifs.cbSummClick(Sender: TObject);
begin
  UpdateTarifsInterface;
end;

procedure TframTarifs.edtStartMoneyMinKeyPress(Sender: TObject;
  var Key: Char);
begin
  UpdateTarifsInterface;
end;

procedure TframTarifs.edtAddMoneyMinKeyPress(Sender: TObject;
  var Key: Char);
begin
  UpdateTarifsInterface;
end;

procedure TframTarifs.edtMaximumTrustKeyPress(Sender: TObject;
  var Key: Char);
begin
  UpdateTarifsInterface;
end;

procedure TframTarifs.edtStartMoneyMaxKeyPress(Sender: TObject;
  var Key: Char);
begin
  UpdateTarifsInterface;
end;

procedure TframTarifs.edtAddMoneyMaxKeyPress(Sender: TObject;
  var Key: Char);
begin
  UpdateTarifsInterface;
end;

end.
