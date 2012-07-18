unit frameComputers;

interface

uses 
  GCConst, GCComputers, GCCommon, ADODB, GCLangUtils,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ComCtrls, StdCtrls, Buttons, DB, Grids, DBGridEh;

type
  TframComputers = class(TFrame)
    lvComps: TListView;
    gbEditor: TGroupBox;
    editIPaddr: TEdit;
    lblIPaddr: TLabel;
    lblNumber: TLabel;
    editNumber: TEdit;
    butAdd: TButton;
    butUpdate: TButton;
    butDelete: TButton;
    pnGroups: TPanel;
    butGroupAdd: TButton;
    butGroupUpdate: TButton;
    butGroupDelete: TButton;
    cbGroups: TComboBox;
    cbGroup: TComboBox;
    lblGroup: TLabel;
    editMAC: TEdit;
    lblMAC: TLabel;
    SpeedButton1: TSpeedButton;
    pgcComputers: TPageControl;
    tabOld: TTabSheet;
    tabComputers: TTabSheet;
    gridComputers: TDBGridEh;
    dsComputers: TDataSource;
    cdsComputers: TADODataSet;
    procedure butAddClick(Sender: TObject);
    procedure editNumberChange(Sender: TObject);
    procedure butDeleteClick(Sender: TObject);
    procedure lvCompsClick(Sender: TObject);
    procedure butUpdateClick(Sender: TObject);
    procedure butGroupAddClick(Sender: TObject);
    procedure butGroupUpdateClick(Sender: TObject);
    procedure butGroupDeleteClick(Sender: TObject);
    procedure cbGroupsChange(Sender: TObject);
    procedure cbGroupsSelect(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
    nIdGroupSel: Integer;
    procedure ResetFrame;
    procedure UpdateCompsList;
  public
    function GetID: integer;
    procedure Activate(ID: integer);
    { Public declarations }
  end;

implementation

{$R *.dfm}

function TframComputers.GetID: integer;
begin
  GetID := FRAME_COMPUTERS;
end;

procedure TframComputers.UpdateCompsList;
var
  i: integer;
  li: TListItem;
  Comp: TComputer;
  Group: TComputerGroup;
  dts: TADODataSet;
begin
  if lvComps.Items.Count>0 then
    for i:=0 to (lvComps.Items.Count-1) do
    begin
      Comp := lvComps.Items[i].Data;
      Comp.Destroy;
    end;
  lvComps.Clear;
  cbGroups.Items.Clear;
  cbGroup.Items.Clear;
  gridComputers.Columns[FC_COL_GROUP].PickList.Clear;
  Group := TComputerGroup.Create;
  Group.Id := -1;
  Group.Name := translate('CommonComputers');
  i := cbGroups.Items.Add(Group.Name);
  cbGroups.Items.Objects[i] := Group;
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

      i := cbGroups.Items.Add(Group.Name);
      cbGroups.Items.Objects[i] := Group;
      i := cbGroup.Items.Add(Group.Name);
      cbGroup.Items.Objects[i] := Group;
      i := gridComputers.Columns[FC_COL_GROUP].PickList.Add(Group.Name);
      gridComputers.Columns[FC_COL_GROUP].PickList.Objects[i] := Group;
      dts.Recordset.MoveNext;
    end;
    dts.Close;
    dts.Destroy;
    for i:=0 to cbGroups.Items.Count-1 do
      if (TComputerGroup(cbGroups.Items.Objects[i]).Id = nIdGroupSel) then begin
        cbGroups.ItemIndex := i;
        break;
      end;


    dts := TADODataSet.Create(nil);
    dsDoQuery(DS_COMPUTERS_SELECT + ' @idGroup=' + IntToStr(nIdGroupSel), @dts);
    while (dts.Recordset.RecordCount > 0) and (not dts.Recordset.EOF) do
    begin
      Comp := TComputer.Create;
      Comp.id := dts.Recordset.Fields.Item['id'].Value;
      Comp.number := dts.Recordset.Fields.Item['number'].Value;
      Comp.ipaddr := dts.Recordset.Fields.Item['ipaddress'].Value;
      Comp.macaddr := dts.Recordset.Fields.Item['macaddress'].Value;
      Comp.IdGroup := dts.Recordset.Fields.Item['idGroup'].Value;
      for i:=0 to cbGroups.Items.Count-1 do
        if (TComputerGroup(cbGroups.Items.Objects[i]).Id = Comp.IdGroup) then begin
          Comp.GroupName := cbGroups.Items.Strings[i];
          break;
        end;
      li := lvComps.Items.Add;
      li.Caption := IntToStr(Comp.number);
      li.SubItems.Insert(0, Comp.ipaddr);
      li.SubItems.Insert(1, Comp.GroupName);
      li.SubItems.Insert(2, Comp.macaddr);
      li.Data := Comp;
      dts.Recordset.MoveNext;
    end;
    dts.Close;
    dts.Destroy;

    butDelete.Enabled := false;
    butUpdate.Enabled := false;
    editIPaddr.Text := '';
    editNumber.Text := '';
    editMac.Text := '';

    cdsComputers.Close;
    cdsComputers.CreateDataSet;

    dts := TADODataSet.Create(nil);
    dsDoQuery(DS_COMPUTERS_SELECT + ' @idGroup=-1', @dts);
    while (dts.Recordset.RecordCount > 0) and (not dts.Recordset.EOF) do
    begin
      cdsComputers.Append;
      cdsComputers.FieldValues['id'] := dts.Recordset.Fields.Item['id'].Value;
      cdsComputers.FieldValues['number'] :=  dts.Recordset.Fields.Item['number'].Value;
      cdsComputers.FieldValues['ip'] := dts.Recordset.Fields.Item['ipaddress'].Value;
      cdsComputers.FieldValues['group'] := '';
      cdsComputers.FieldValues['mac'] := dts.Recordset.Fields.Item['macaddress'].Value;
      for i:=0 to gridComputers.Columns[FC_COL_GROUP].PickList.Count-1 do
        if (TComputerGroup(gridComputers.Columns[FC_COL_GROUP].PickList.Objects[i]).Id = dts.Recordset.Fields.Item['idGroup'].Value) then begin
          cdsComputers.FieldValues['group'] := gridComputers.Columns[FC_COL_GROUP].PickList.Strings[i];
          break;
        end;



      cdsComputers.Post;
      dts.Recordset.MoveNext;
    end;
    dts.Close;
    dts.Destroy;


//    cbVip.Checked := false;
  end;
end;

// процедура ставит все контролы в исходные позиции
procedure TframComputers.ResetFrame;
begin
  nIdGroupSel := -1;
  UpdateCompsList;
end;

procedure TframComputers.Activate(ID: integer);
var
  i:integer;
begin
  Visible := (GetID = ID);
  if (not Visible) then exit;
  ResetFrame;
  butAdd.Caption := translate('Add');
  butDelete.Caption := translate('Delete');
  butUpdate.Caption := translate('Update');
  butGroupAdd.Caption := translate('Add');
  butGroupDelete.Caption := translate('Delete');
  butGroupUpdate.Caption := translate('Update');
  lblIPaddr.Caption := translate('IP');
  lblNumber.Caption := translate('Number');
  lblGroup.Caption := translate('Group');
  lvComps.Column[0].Caption := translate('Number');
  lvComps.Column[1].Caption := translate('IP');
  for i:= 0 to gridComputers.Columns.Count-1 do
    gridComputers.Columns[i].Title.Caption := translate(gridComputers.Columns[i].FieldName);
end;

procedure TframComputers.butAddClick(Sender: TObject);
begin
  if editMAC.Text='' then editMAC.Text := '00-00-00-00-00-00';
  dsDoCommand(DS_COMPUTERS_ADD + ' @number='+editNumber.Text+', @ipaddress='''+editIPaddr.Text+''', @idGroup='+
  IntToStr(TComputerGroup(cbGroup.Items.Objects[cbGroup.ItemIndex]).Id) +
  ', @macaddress='''+ UpperCase(editMAC.Text)+'''');

  UpdateCompsList;
end;

procedure TframComputers.editNumberChange(Sender: TObject);
begin
  butAdd.Enabled := ((editNumber.Text<>'') and (length(editIPaddr.Text)>6) and (cbGroup.ItemIndex <> -1));
end;

procedure TframComputers.butDeleteClick(Sender: TObject);
var
  Comp: TComputer;
begin
  if (lvComps.ItemIndex = -1) then exit;
  Comp := lvComps.Items[lvComps.ItemIndex].Data;
  dsDoCommand(DS_COMPUTERS_DELETE + ' @idComp=' + IntToStr(Comp.id));
  UpdateCompsList;
end;

procedure TframComputers.lvCompsClick(Sender: TObject);
var
  Comp: TComputer;
  i: Integer;
begin
 if (lvComps.ItemIndex <> -1) then
 begin
   Comp := lvComps.Items[lvComps.ItemIndex].Data;
   butDelete.Enabled := true;
   butUpdate.Enabled := true;
   editNumber.Text := IntToStr(Comp.number);
   editIPaddr.Text := Comp.ipaddr;
   editMAC.Text := Comp.macaddr;
   for i:=0 to cbGroups.Items.Count-1 do
     if (TComputerGroup(cbGroup.Items.Objects[i]).Id = Comp.IdGroup) then begin
       cbGroup.ItemIndex := i;
       break;
     end;
   butAdd.Enabled := False;
 end;
end;

procedure TframComputers.butUpdateClick(Sender: TObject);
var
  Comp: TComputer;
begin
  if (lvComps.ItemIndex <> -1) then
  begin
//    if (cbVip.Checked) then vip:='1' else vip:='0';
    if editMAC.Text='' then editMAC.Text := '00-00-00-00-00-00';
    Comp := lvComps.Items[lvComps.ItemIndex].Data;
    dsDoCommand(DS_COMPUTERS_UPDATE + ' @idComp='+IntToStr(Comp.id)+', @number='+
      editNumber.Text+', @ipaddress='''+editIPaddr.Text+''', @idGroup='+
      IntToStr(TComputerGroup(cbGroup.Items.Objects[cbGroup.ItemIndex]).Id) +
       ', @macaddress='''+UpperCase(editMAC.Text)+'''' );
    UpdateCompsList;
  end;
end;

procedure TframComputers.butGroupAddClick(Sender: TObject);
begin
  //
  if  cbGroups.Items.IndexOf(cbGroups.Text) = -1 then begin
    dsDoCommand(DS_COMPUTERGROUPS_ADD + ' @name='''+cbGroups.Text+'''');
    UpdateCompsList;
  end
  else
    MessageBox(HWND_TOP, PChar(translate('GroupAddNameExistWarning')),
        PChar('GameClass Error'),MB_OK or MB_ICONERROR);
end;

procedure TframComputers.butGroupUpdateClick(Sender: TObject);
begin
  dsDoCommand(DS_COMPUTERGROUPS_UPDATE + ' @idGroup='+IntToStr(nIdGroupSel)+', @name='''+cbGroups.Text+'''');
  UpdateCompsList;
end;

procedure TframComputers.butGroupDeleteClick(Sender: TObject);
begin
  dsDoCommand(DS_COMPUTERGROUPS_DELETE + ' @idGroup=' + IntToStr(nIdGroupSel));
  ResetFrame;
end;

procedure TframComputers.cbGroupsChange(Sender: TObject);
begin
  if (cbGroups.Items.IndexOf(cbGroups.Text) = -1) then begin
//  butGroupAdd.Enabled := True;
    butGroupUpdate.Enabled := True;
    butGroupDelete.Enabled := False;
  end
  else
    cbGroupsSelect(Sender);
end;

procedure TframComputers.cbGroupsSelect(Sender: TObject);
begin
//butGroupAdd.Enabled := False;
  butGroupUpdate.Enabled := False;
  butGroupDelete.Enabled := True;
  nIdGroupSel := TComputerGroup(cbGroups.Items.Objects[cbGroups.Items.IndexOf(cbGroups.Text)]).Id;
  //так сложно, чтобы работало и с вручную введенным текстом
  UpdateCompsList;
end;


procedure TframComputers.SpeedButton1Click(Sender: TObject);
var
  l_ipaddr:PAnsiChar;
begin
  if (editIPaddr.Text<>'') then
  begin
    l_ipaddr:=pchar(editIPaddr.Text);
    editMAC.Text:= GetMacFromIP( l_ipaddr);
  end;
end;

end.

