unit frameComputers;

interface

uses 
  GCConst, GCComputers, GCCommon, ADODB, GCLangUtils,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ComCtrls, StdCtrls, Buttons, DB, Grids, DBGridEh;

type
  TframComputers = class(TFrame)
    pnGroups: TPanel;
    butGroupAdd: TButton;
    butGroupUpdate: TButton;
    butGroupDelete: TButton;
    pgcComputers: TPageControl;
    tabGroups: TTabSheet;
    tabComputers: TTabSheet;
    gridComputers: TDBGridEh;
    dsComputers: TDataSource;
    cdsComputers: TADODataSet;
    GroupBox1: TGroupBox;
    butAdd1: TButton;
    butDelete1: TButton;
    lbGroups: TListBox;
    editGroups: TEdit;


    procedure butGroupAddClick(Sender: TObject);
    procedure butGroupUpdateClick(Sender: TObject);
    procedure butGroupDeleteClick(Sender: TObject);

    procedure dsComputersDataChange(Sender: TObject; Field: TField);
    procedure gridComputersExit(Sender: TObject);
    procedure gridComputersColExit(Sender: TObject);
    procedure gridComputersColumns3EditButtonClick(Sender: TObject;
      var Handled: Boolean);
    procedure butAdd1Click(Sender: TObject);
    procedure butDelete1Click(Sender: TObject);
    procedure editGroupsChange(Sender: TObject);
    procedure lbGroupsClick(Sender: TObject);
  private
    { Private declarations }
    FbControlsEnabled: Boolean;
    FbUpdateInDB: Boolean;
    nUpdateInDBId: Integer;
    nIdGroupSel: Integer;
    procedure ResetFrame;
    procedure UpdateCompsList;
  public
    function GetID: integer;
    procedure Activate(ID: integer);
    procedure EnableControls;
    procedure DisableControls;
    procedure UpdateInDB(id:integer);
    { Public declarations }
  end;

implementation


{$R *.dfm}

procedure TframComputers.EnableControls;
begin
  FbControlsEnabled := True;
end;

procedure TframComputers.DisableControls;
begin
  FbControlsEnabled := false;
end;

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
  DisableControls;

  lbGroups.Items.Clear;
  gridComputers.Columns[FC_COL_GROUP].PickList.Clear;

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

      i := lbGroups.Items.Add(Group.Name);
      lbGroups.Items.Objects[i] := Group;

      i := gridComputers.Columns[FC_COL_GROUP].PickList.Add(Group.Name);
      gridComputers.Columns[FC_COL_GROUP].PickList.Objects[i] := Group;
      dts.Recordset.MoveNext;
    end;
    dts.Close;
    dts.Destroy;

    if cdsComputers.Recordset<>nil then
    cdsComputers.Close;
    cdsComputers.CreateDataSet;

    dts := TADODataSet.Create(nil);
    dsDoQuery(DS_COMPUTERS_SELECT + ' @idGroup=-1', @dts);
    while (dts.Recordset.RecordCount > 0) and (not dts.Recordset.EOF) do
    begin
      cdsComputers.Append;
      cdsComputers.FieldValues['chek'] := 0;
      cdsComputers.FieldValues['id'] := dts.Recordset.Fields.Item['id'].Value;
      cdsComputers.FieldValues['number'] :=  dts.Recordset.Fields.Item['number'].Value;
      cdsComputers.FieldValues['ip'] := dts.Recordset.Fields.Item['ipaddress'].Value;
      cdsComputers.FieldValues['group'] := '';
      cdsComputers.FieldValues['mac'] := dts.Recordset.Fields.Item['macaddress'].Value;
      cdsComputers.FieldValues['snmp_password'] := dts.Recordset.Fields.Item['snmp_password'].Value;
      cdsComputers.FieldValues['mib_port'] := dts.Recordset.Fields.Item['snmp_mib_ports'].Value;
      cdsComputers.FieldValues['ignore_offline'] := dts.Recordset.Fields.Item['ignore_offline'].Value;
      cdsComputers.FieldValues['client_type'] := gridComputers.Columns[FC_COL_CLIENT_TYPE].PickList.Strings[dts.Recordset.Fields.Item['client_type'].Value];

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
    nUpdateInDBId := -1;
    FbUpdateInDB := False;


//    cbVip.Checked := false;
  end;
  EnableControls;
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
  butAdd1.Caption := translate('Add');
  butDelete1.Caption := translate('Delete');

  butGroupAdd.Caption := translate('Add');
  butGroupDelete.Caption := translate('Delete');
  butGroupUpdate.Caption := translate('Update');

  for i:= 0 to gridComputers.Columns.Count-1 do
    if gridComputers.Columns[i].FieldName<>'' then
      gridComputers.Columns[i].Title.Caption := translate(gridComputers.Columns[i].FieldName);
end;

procedure TframComputers.butGroupAddClick(Sender: TObject);
begin
  //
  if  lbGroups.Items.IndexOf(editGroups.Text) = -1 then begin
    dsDoCommand(DS_COMPUTERGROUPS_ADD + ' @name='''+editGroups.Text+'''');
    UpdateCompsList;
  end
  else
    MessageBox(HWND_TOP, PChar(translate('GroupAddNameExistWarning')),
        PChar('GameClass Error'),MB_OK or MB_ICONERROR);
end;

procedure TframComputers.butGroupUpdateClick(Sender: TObject);
begin
  dsDoCommand(DS_COMPUTERGROUPS_UPDATE + ' @idGroup='+IntToStr(nIdGroupSel)+', @name='''+editGroups.Text+'''');
  UpdateCompsList;
end;

procedure TframComputers.butGroupDeleteClick(Sender: TObject);
begin
  dsDoCommand(DS_COMPUTERGROUPS_DELETE + ' @idGroup=' + IntToStr(nIdGroupSel));
  ResetFrame;
end;

procedure TframComputers.dsComputersDataChange(Sender: TObject;
  Field: TField);
begin
  if not FbControlsEnabled then exit;
  if dsComputers.State <> dsBrowse then
    begin
      FbUpdateInDB:=True;
      nUpdateInDBId:=dsComputers.DataSet.FieldValues['id'];
    end
  else
    if FbUpdateInDB then
      begin
        UpdateInDB(nUpdateInDBId);
      end;
end;

procedure TframComputers.gridComputersExit(Sender: TObject);
begin
  if not FbControlsEnabled then exit;
  if FbUpdateInDB then
    begin
      UpdateInDB(nUpdateInDBId);
    end;
end;

procedure TframComputers.gridComputersColExit(Sender: TObject);
var
  a:integer;
begin
  if not FbControlsEnabled then exit;
  if FbUpdateInDB then
    begin
      UpdateInDB(nUpdateInDBId);
    end;
end;

procedure TframComputers.UpdateInDB(id:integer);
var
  Comp:TComputer;
  bookmark: TBookmarkStr;
  i:integer;
  DoUpdate:Boolean;
begin
  DoUpdate:=False;
  if not FbControlsEnabled then exit;
  DisableControls;

  Comp := TComputer.Create;

  bookmark := cdsComputers.Bookmark;
  cdsComputers.First;
  while (not cdsComputers.Eof) do begin
    if cdsComputers.FieldValues['id'] = id then
    begin
      Comp.id := id;
      Comp.number := strtoint(cdsComputers.FieldValues['number']);
      Comp.ipaddr := cdsComputers.FieldValues['ip'];
      Comp.macaddr := cdsComputers.FieldValues['mac'];
      Comp.SNMP_Password := cdsComputers.FieldValues['snmp_password'];
      Comp.SNMP_MIB_Port := cdsComputers.FieldValues['mib_port'];
      Comp.IgnoreOffline := cdsComputers.FieldValues['ignore_offline'];

      for i:=0 to gridComputers.Columns[FC_COL_GROUP].PickList.Count-1 do
        if (TComputerGroup(gridComputers.Columns[FC_COL_GROUP].PickList.Objects[i]).Name = cdsComputers.FieldValues['group']) then begin
          Comp.IdGroup := TComputerGroup(gridComputers.Columns[FC_COL_GROUP].PickList.Objects[i]).Id;
          break;
        end;
      for i:=0 to gridComputers.Columns[FC_COL_CLIENT_TYPE].PickList.Count-1 do
        if gridComputers.Columns[FC_COL_CLIENT_TYPE].PickList.Strings[i] =
          cdsComputers.FieldValues['client_type'] then
            Comp.ClientType := i;

    end;
    cdsComputers.Next;
  end;
  cdsComputers.Bookmark := bookmark;
  if Comp.macaddr='' then Comp.macaddr := '00-00-00-00-00-00';
  try
    dsDoCommand(DS_COMPUTERS_UPDATE +
              ' @idComp=' + IntToStr(Comp.id)+
              ', @number=' + IntToStr(Comp.number) +
              ', @client_type=' + IntToStr(Comp.ClientType) +
              ', @idGroup=' + IntToStr(Comp.IdGroup) +
              ', @ipaddress=''' + Comp.ipaddr + '''' +
              ', @macaddress=''' + UpperCase(Comp.macaddr) + '''' +
              ', @snmp_password=''' + Comp.SNMP_Password + '''' +
              ', @mib_port=''' + Comp.SNMP_MIB_Port + '''' +
              ', @ignore_offline=' + BoolToStr(Comp.IgnoreOffline));
  except
    DoUpdate := True;
  end;
  Comp.Destroy;
  FbUpdateInDB:=false;
  EnableControls;
  if DoUpdate then
    UpdateCompsList;
end;


procedure TframComputers.gridComputersColumns3EditButtonClick(
  Sender: TObject; var Handled: Boolean);
var
  ipaddr: String;
  l_ipaddr:PAnsiChar;
begin
  if (cdsComputers.FieldValues['ip']<>'') then
  begin
    ipaddr:=cdsComputers.FieldValues['ip'];
    l_ipaddr:=pchar(ipaddr);
    cdsComputers.Edit;
    cdsComputers.FieldValues['mac']:= GetMacFromIP( l_ipaddr);
    FbUpdateInDB:=True;
    nUpdateInDBId:=cdsComputers.FieldValues['id'];
    UpdateInDB(nUpdateInDBId);
  end;
end;

procedure TframComputers.butAdd1Click(Sender: TObject);
var
  NextNum:integer;
begin
  if not FbControlsEnabled then exit;
  DisableControls;
  NextNum := 0;

  cdsComputers.First;
  while (not cdsComputers.Eof) do begin
    if strtoint(cdsComputers.FieldValues['number']) > NextNum then
      NextNum := strtoint(cdsComputers.FieldValues['number']);
    cdsComputers.Next;
  end;
  inc(NextNum);
  dsDoCommand(DS_COMPUTERS_ADD + ' @number=' + inttostr(NextNum) +
    ', @ipaddress=''0.0.0.0'', @idGroup=1, @macaddress=''00-00-00-00-00-00''');
  EnableControls;
  UpdateCompsList;
end;

procedure TframComputers.butDelete1Click(Sender: TObject);
var
  i:integer;
begin
  if not FbControlsEnabled then exit;
  DisableControls;
  cdsComputers.First;
  while (not cdsComputers.Eof) do begin
    i:= cdsComputers.FieldValues['chek'];
    if cdsComputers.FieldValues['chek'] = -1 then
      dsDoCommand(DS_COMPUTERS_DELETE + ' @idComp=' + inttostr(cdsComputers.FieldValues['id']));
    cdsComputers.Next;
  end;

  EnableControls;
  UpdateCompsList;
end;

procedure TframComputers.editGroupsChange(Sender: TObject);
begin
  if editGroups.Text <> '' then
  begin
    butGroupAdd.Enabled := True;
    butGroupUpdate.Enabled := True;
    butGroupDelete.Enabled := False;
  end;
  if editGroups.Text = lbGroups.Items.Strings[lbGroups.ItemIndex] then
  begin
    nIdGroupSel := TComputerGroup(lbGroups.Items.Objects[lbGroups.Items.IndexOf(editGroups.Text)]).Id;
    butGroupAdd.Enabled := False;
    butGroupUpdate.Enabled := False;
    butGroupDelete.Enabled := True;
  end;
end;

procedure TframComputers.lbGroupsClick(Sender: TObject);
begin
  editGroups.Text := lbGroups.Items.Strings[lbGroups.ItemIndex];
  nIdGroupSel := TComputerGroup(lbGroups.Items.Objects[lbGroups.ItemIndex]).Id;
end;

end.

