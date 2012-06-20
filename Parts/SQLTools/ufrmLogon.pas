// Новый вариант формы подключения
// Обработка ошибок в OnError, по умолчанию выводятся MessageBox'ами
// GCServer может выводить в консоль и в GCMessageBox
unit ufrmLogon;

interface

uses
  Messages,
  Forms,
  StdCtrls,
  Controls,
  Graphics,
  ExtCtrls,
  Classes,
  Registry,
  ComCtrls,
  SysUtils,
  Windows,
  ADODB,
  uErrors;

const
  MRU_SERVERS_MAX = 5;
  MRU_USERS_MAX = 10;
  DEF_DBNAME = 'GameClass';

type

  TfrmLogon = class(TForm)
    lblUser: TLabel;
    cboUserName: TComboBox;
    lblPassword: TLabel;
    edtPassword: TEdit;
    labelServer: TLabel;
    cboServerName: TComboBox;
    cbxOtherServer: TCheckBox;
    btnLogon: TButton;
    btnCancel: TButton;
    imgKeys: TImage;
    btnServerList: TButton;
    cbxWinAuthentication: TCheckBox;
    procedure cbxOtherServerClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnLogonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnServerListClick(Sender: TObject);
    procedure cbxWinAuthenticationClick(Sender: TObject);
  private
    FcnnResult: TADOConnection;
    FstrServerName: String;
    FstrDBName: String;
    FstrUserName: String;
    FlstServers: TStringList;
    FlstUsers: TStringList;
    FOnError: TErrorEvent;
    FbSaveConnectedServer: Boolean;
//    FbUseOtherServer: Boolean;
    FbNeedAdminRights: Boolean;
//    FbCreateConnection: Boolean;
    procedure MRUListsLoad;
    procedure MRUListsSave;
    procedure Error(const Sender: TObject;
      const AnErrorNumber: Integer; const AlstError: TStringList);
    function GetWindowsAuthentication: Boolean;
    procedure SetWindowsAuthentication(AbValue: Boolean);
    procedure SetServerName(AbValue: String);
    function GetPassword: String;
    procedure SetLogin(const AstrLogin: String);
  public
    constructor Create(const AOwner: TComponent;
        const AcnnResult: TADOConnection = Nil; //при Nil коннекшн не создается
        const AbWindowsAuthenticationAvailable: Boolean = False;
        const AstrDBName: String = DEF_DBNAME;
        const AbSaveConnectedServer: Boolean = True;
        const AbUseOtherServer: Boolean = False;
        const AbNeedAdminRights: Boolean = False); reintroduce;
    destructor Destroy; override;
//    procedure FreeWithConnection;
//    property Connection: TADOConnection read FcnnResult;
    property ServerName: String
        read FstrServerName write SetServerName;
    property Password: String
        read GetPassword;
    property UserName: String
        read FstrUserName write SetLogin;
    property OnError: TErrorEvent
        read FOnError write FOnError;
    property WindowsAuthentication: Boolean
        read GetWindowsAuthentication write SetWindowsAuthentication;
  end;

var
  frmLogon: TfrmLogon;

implementation

uses
  ufrmSQLServerList,
  uSQLTools;
//  uSystemRegistryTools,
//  psAPI,
//  uY2KString;

{$R *.dfm}

constructor TfrmLogon.Create(const AOwner: TComponent;
    const AcnnResult: TADOConnection = Nil; //при Nil коннекшн не создается
    const AbWindowsAuthenticationAvailable: Boolean = False;
    const AstrDBName: String = DEF_DBNAME;
    const AbSaveConnectedServer: Boolean = True;
    const AbUseOtherServer: Boolean = False;
    const AbNeedAdminRights: Boolean = False);
begin
//  ASSERT(Assigned(AcnnResult));
  inherited Create(AOwner);
  FcnnResult := AcnnResult;
  FOnError := Error;
  FstrDBName := AstrDBName;
  FlstServers := TStringList.Create;
  FlstUsers := TStringList.Create;
  FbSaveConnectedServer := AbSaveConnectedServer;
  cbxOtherServer.Checked := AbUseOtherServer;
  FbNeedAdminRights := AbNeedAdminRights;
  MRUListsLoad;
  cboServerName.Items := FlstServers;
  cboUserName.Items := FlstUsers;
  cboUserName.Text := cboUserName.Items.Strings[0];
  cboServerName.Text := cboServerName.Items.Strings[0];
  edtPassword.text := '';
  cbxWinAuthentication.Visible := AbWindowsAuthenticationAvailable;
//  FbCreateConnection := AbCreateConnection;
//  edtPassword.SetFocus;
end;

destructor TfrmLogon.Destroy;
begin
  FreeAndNil(FlstServers);
  FreeAndNil(FlstUsers);
  inherited Destroy;
end;

procedure TfrmLogon.MRUListsLoad;
var
  Reg: TRegistry;
  i: Integer;
  str: String;
begin
  // Считаем MRU-списки серверов и пользователей из реестра
  Reg := TRegistry.Create;
  Reg.RootKey := HKEY_CURRENT_USER;
  if Reg.OpenKey('\Software\GameClass3',True) then
  begin
    FlstServers.Clear;
    if (Reg.ReadString('Logon_server1')='') then begin
      FlstServers.Add('(LOCAL)');
    end else begin
      for i := 1 to MRU_SERVERS_MAX do begin
        str := Reg.ReadString('Logon_server' + IntToStr(i));
        if str <> '' then
          FlstServers.Add(str);
      end;
    end;
    FlstUsers.Clear;
    if (Reg.ReadString('Logon_user1')='') then begin
      FlstUsers.Add('manager');
      FlstUsers.Add('operator');
    end else begin
      for i := 1 to MRU_USERS_MAX do begin
        str := Reg.ReadString('Logon_user' + IntToStr(i));
        if str <> '' then
          FlstUsers.Add(str);
      end;
    end;
    Reg.CloseKey;
  end;
  Reg.Free;
end;

procedure TfrmLogon.MRUListsSave;
var
  Reg: TRegistry;
  i: Integer;
begin
  // сохраним в реестре новые значения
  Reg := TRegistry.Create;
  Reg.RootKey := HKEY_CURRENT_USER;
  if Reg.OpenKey('\Software\GameClass3',False) then begin
    for i := 1 to FlstServers.Count do
      Reg.WriteString('Logon_server' + IntToStr(i), FlstServers[i-1]);
    for i := 1 to FlstUsers.Count do
      Reg.WriteString('Logon_user' + IntToStr(i), FlstUsers[i-1]);
    Reg.CloseKey;
    Reg.Free;
  end;
end;

procedure TfrmLogon.cbxOtherServerClick(Sender: TObject);
begin
  cboServerName.Enabled := cbxOtherServer.Checked;
  btnServerList.Enabled := cbxOtherServer.Checked;
  if Visible and (cbxOtherServer.Checked) then
    cboServerName.SetFocus;
end;

procedure TfrmLogon.btnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmLogon.btnLogonClick(Sender: TObject);
var
  lstErrors: TStringList;
  n, nError: Integer;
  bConnected: Boolean;
begin
  if Assigned(FcnnResult) then begin
    lstErrors := TStringList.Create;
    if cbxWinAuthentication.Checked then
      bConnected := ADOConnect(FcnnResult, lstErrors, nError, False,
          cboServerName.Text, FstrDBName)
    else
      bConnected := ADOConnect(FcnnResult, lstErrors, nError, True,
          cboServerName.Text, FstrDBName, cboUserName.Text, edtPassword.Text);
    if bConnected then begin
      FstrServerName := cboServerName.Text;
      n := FlstServers.IndexOf(FstrServerName);
      if n <> -1 then
        FlstServers.Delete(n);
      FlstServers.Insert(0,FstrServerName);
      if not cbxWinAuthentication.Checked then begin
        FstrUserName := cboUserName.Text;
        edtPassword.Text := '';
        n := FlstUsers.IndexOf(FstrUserName);
        if n <> -1 then
          FlstUsers.Delete(n);
        FlstUsers.Insert(0,FstrUserName);
      end;
      if FbNeedAdminRights and not IsSysadmin(FcnnResult) then begin
        Application.MessageBox(PChar(SQL_TOOLS_NEED_SYSADMIN),
            PChar(ERR_CAPTION));
      end else begin
        if FbSaveConnectedServer then
          MRUListsSave;
        ModalResult := mrOk;
      end;
    end else begin
      if Assigned(FOnError) then
        FOnError(Self, nError, lstErrors);
      //ModalResult := mrCancel;
    end;
    FreeAndNil(lstErrors);
  end else begin
    FstrServerName := cboServerName.Text;
    if not cbxWinAuthentication.Checked then
      FstrUserName := cboUserName.Text;
    ModalResult := mrOk;
  end;
end;

procedure TfrmLogon.FormShow(Sender: TObject);
begin
{$IFDEF GC3SERVER}
{  UpdateWindow(formMain.Handle);
  SendMessage(formMain.Handle, WM_PAINT,1,1)
}
{$ENDIF}
end;

procedure TfrmLogon.btnServerListClick(Sender: TObject);
var
  frmSQLServerList: TfrmSQLServerList;
begin
  frmSQLServerList := TfrmSQLServerList.Create(Self);
  if frmSQLServerList.ShowModal = mrOk then
    cboServerName.Text := frmSQLServerList.SelectedServer;
  FreeAndNil(frmSQLServerList);
end;

procedure TfrmLogon.cbxWinAuthenticationClick(Sender: TObject);
begin
  cboUserName.Enabled := not cbxWinAuthentication.Checked;
  edtPassword.Enabled := not cbxWinAuthentication.Checked;
  lblUser.Enabled := not cbxWinAuthentication.Checked;
  lblPassword.Enabled := not cbxWinAuthentication.Checked;
  if cbxWinAuthentication.Checked then begin
    cboUserName.Color := clBtnFace;
    edtPassword.Color := clBtnFace;
  end else begin
    cboUserName.Color := clWindow;
    edtPassword.Color := clWindow;
  end;
end;

procedure TfrmLogon.Error(const Sender: TObject;
    const AnErrorNumber: Integer; const AlstError: TStringList);
var
  i: Integer;
begin
  for i := 0 to AlstError.Count - 1 do
    MessageBox(Handle, PChar(AlstError[i]),
      'Ошибка', MB_OK or MB_ICONERROR);
end;

function TfrmLogon.GetWindowsAuthentication: Boolean;
begin
  Result := cbxWinAuthentication.Checked;
end;

procedure TfrmLogon.SetWindowsAuthentication(AbValue: Boolean);
begin
  cbxWinAuthentication.Checked := AbValue;
end;

procedure TfrmLogon.SetServerName(AbValue: String);
begin
  cboServerName.Text := AbValue;
end;

function TfrmLogon.GetPassword: String;
begin
  Result := edtPassword.Text;
end;

{procedure TfrmLogon.FreeWithConnection;
begin
  FreeAndNil(FcnnResult);
  Free;
end;
}
procedure TfrmLogon.SetLogin(const AstrLogin: String);
begin
  cboUserName.Text := AstrLogin;
end;

end.
