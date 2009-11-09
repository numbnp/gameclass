unit frameUsers;

interface

uses 
  GCConst, ADODB, GCLangUtils, GCCommon, GCComputers,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls;

type

  TUser = class
  public
    constructor Create;
  public
    id: integer;
    name: string;
    namegroup: string;
    idgroup: integer;
  end;

  TGroup = class
  public
    constructor Create;
  public
    id: integer;
    name: string;
  end;

  
  TframUsers = class(TFrame)
    lvUsers: TListView;
    gbEditor: TGroupBox;
    lblGroup: TLabel;
    lblLogin: TLabel;
    editLogin: TEdit;
    cmbGroups: TComboBox;
    editPassRepeate: TEdit;
    lblRepeatPassword: TLabel;
    lblPassword: TLabel;
    editPass: TEdit;
    butAdd: TButton;
    butDelete: TButton;
    butChangePass: TButton;
    procedure lvUsersClick(Sender: TObject);
    procedure editLoginChange(Sender: TObject);
    procedure butDeleteClick(Sender: TObject);
    procedure butAddClick(Sender: TObject);
    procedure editPassChange(Sender: TObject);
    procedure editPassRepeateChange(Sender: TObject);
    procedure butChangePassClick(Sender: TObject);
  private
    { Private declarations }
    pass_equal: boolean;
    procedure ResetFrame;
    procedure UpdateUsersList;
  public
    function GetID: integer;
    procedure Activate(ID: integer); 
    { Public declarations }
  end;

implementation

{$R *.dfm}

constructor TUser.Create;
begin
  //
end;

constructor TGroup.Create;
begin
  //
end;

function TframUsers.GetID: integer;
begin
  GetID := FRAME_USERS;
end;

// процедура ставит все контролы в исходные позиции
procedure TframUsers.ResetFrame;
begin
  UpdateUsersList;
end;

procedure TframUsers.Activate(ID: integer);
begin
  Visible := (GetID = ID);
  if (not Visible) then exit;
  ResetFrame;
  butAdd.Caption := translate('Add');
  butDelete.Caption := translate('Delete');
  butChangePass.Caption := translate('mnuChangePass');
  lblGroup.Caption := translate('Group');
  lblLogin.Caption := translate('Login');
  lblPassword.Caption := translate('lblNewPassword');
  lblRepeatPassword.Caption := translate('lblRepeatPassword');

  lvUsers.Column[0].Caption := translate('Login');
  lvUsers.Column[1].Caption := translate('Group');
end;

procedure TframUsers.UpdateUsersList;
var
  i: integer;
  li: TListItem;
  User: TUser;
  Group: TGroup;
  dts: TADODataSet;
begin
  if lvUsers.Items.Count>0 then
    for i:=0 to (lvUsers.Items.Count-1) do
    begin
      User := lvUsers.Items[i].Data;
      User.Destroy;
    end;  
  lvUsers.Clear;

  if (dsConnected) then
  begin
    dts := TADODataSet.Create(nil);
    dsDoQuery(DS_USERS_SELECT, @dts);
    while (dts.Recordset.RecordCount > 0) and (not dts.Recordset.EOF) do
    begin
      User := TUser.Create;
      User.id := dts.Recordset.Fields.Item['id'].Value;
      User.name := dts.Recordset.Fields.Item['name'].Value;
      User.namegroup := dts.Recordset.Fields.Item['group'].Value;
      User.idgroup := dts.Recordset.Fields.Item['idUsersGroup'].Value;

      li := lvUsers.Items.Add;
      li.Caption := User.name;
      li.SubItems.Insert(0, User.namegroup);
      li.Data := User;            
      dts.Recordset.MoveNext;
    end;
    dts.Close;
    dsDoQuery(DS_GROUPS_SELECT, @dts);
    cmbGroups.Clear;
    while (dts.Recordset.RecordCount > 0) and (not dts.Recordset.EOF) do
    begin
      Group := TGroup.Create;
      Group.id := dts.Recordset.Fields.Item['id'].Value;
      Group.name := dts.Recordset.Fields.Item['name'].Value;

      cmbGroups.items.Add(Group.Name);
      dts.Recordset.MoveNext;
    end;
    dts.Destroy;   

    butChangePass.Enabled := false;
    butAdd.Enabled := false;
    butDelete.Enabled := false;
    editLogin.Text := '';
    cmbGroups.ItemIndex := 0;
    editPass.Text := '';
    editPassRepeate.Text := '';
    pass_equal := true;
  end;
end;

procedure TframUsers.lvUsersClick(Sender: TObject);
var
  User: TUser;
  i: integer;
begin
 if (lvUsers.ItemIndex <> -1) then
 begin
   User := lvUsers.Items[lvUsers.ItemIndex].Data;
   butDelete.Enabled := true;
   butChangePass.Enabled := true;
   editLogin.Text := User.name;
   editPassRepeate.Text := '';
   editPass.Text := '';
   for i:=0 to cmbGroups.Items.Count-1 do
     if cmbGroups.Items.Strings[i] = User.namegroup then
       cmbGroups.ItemIndex := i;
   butDelete.Enabled := (User.name <> CurOperatorName);
 end;
end;

procedure TframUsers.editLoginChange(Sender: TObject);
var
  f1, f2: boolean;
  i: integer;
begin
  f1 := (length(editLogin.Text)>2);
  f2 := true;
  for i:=0 to lvUsers.Items.Count-1 do
    if (lvUsers.Items[i].Caption = editLogin.Text) then
      f2 := false;

  butAdd.Enabled := (f1 and f2);
  cmbGroups.Enabled := butAdd.Enabled;
  butChangePass.Enabled := ((not f2) and pass_equal);
  butDelete.Enabled := ((not f2) and ((editLogin.Text <> CurOperatorName)));
end;

procedure TframUsers.butDeleteClick(Sender: TObject);
var
  User: TUser;
begin
  if (lvUsers.ItemIndex = -1) then exit;
  User := lvUsers.Items[lvUsers.ItemIndex].Data;
  dsDoCommand(DS_USERS_DELETE + ' @idUsers=' + IntToStr(User.id));
  UpdateUsersList;
end;

procedure TframUsers.butAddClick(Sender: TObject);
begin
  dsDoCommand(DS_USERS_CREATE + ' @login_name='''+editLogin.Text+''', @group_name='''+cmbGroups.Text+''', @password='''+editPass.Text + '''');
  UpdateUsersList;
end;

procedure TframUsers.editPassChange(Sender: TObject);
begin
  pass_equal := (editPassRepeate.Text = editPass.Text);
  editLoginChange(Sender);
end;

procedure TframUsers.editPassRepeateChange(Sender: TObject);
begin
  pass_equal := (editPassRepeate.Text = editPass.Text);
  editLoginChange(Sender);  
end;

procedure TframUsers.butChangePassClick(Sender: TObject);
begin
  if (dsDoCommand(DS_USERS_CHANGEPASS + ' @login_name='''+editLogin.Text+''', @pw='''+editPass.Text + '''')) then
  begin
    MessageBox(HWND_TOP, PChar(translate('PassChanged')+' '+editLogin.Text),PChar('GameClass'),MB_OK or MB_ICONINFORMATION);
    editPassRepeate.Text := '';
    editPass.Text := '';
  end;
end;

end.
