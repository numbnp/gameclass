unit ufrmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Registry,
  Dialogs, StdCtrls, ExtCtrls, DateUtils, ufrmLogon,
  Mask, ToolEdit;

resourcestring
  MSG_SELECT_FOLDER = 'Выберите папку ...';
  MSG_SELECT_FILE_FOR_RESTORE = 'Выберите файл для восстановления ...';
  MSG_SELECT_FOLDER_FOR_BACKUP =
      'Выберите папку для резервного копирования ...';
  MSG_REGISTRATION_NEDED = 'Функция восстановления базы доступна '
      + 'только в зарегистрированной версии программы!';
  MSG_SELECT_ACTION = 'Выберите действие, затем файл или папку ...';
  MSG_FOLDER_NOT_SELECTED = 'Вы забыли выбрать папку!';
  MSG_RESTORE_STARTED = 'Началось резервное копирование ...';
  MSG_FILE_NOT_SELECTED = 'Вы забыли выбрать файл!';
  MSG_RESTORE_WARNING = 'Если вы восстанавливаете базу поверх существующей, '
      + 'то существующая'#10'база будет удалена, а вместо нее будет создана '
      + 'выбранная вами'#10'версия базы данных GameClass! Продолжить???';
  MSG_ATTENTION = 'Внимание!';
  MSG_BACKUP_STARTED = 'Началось восстановление ...';
  MSG_SERVER_TUNING_FAILED = 'Невозможно запустить или настроить SQL-сервер!';
  MSG_SERVER_CONNECT_FAILED = 'Невозможно подключиться к SQL-серверу!';
  MSG_CREATE_BASE_STARTED = 'Началось создание базы данных ...';
  MSG_CREATE_BASE_FAILED = 'При создании базы данных возникла ошибка!';
  MSG_CREATE_BASE_SUCCESSFUL = 'Создание базы данных завершено успешно!';

const
  MANAGER = 'manager';
  SQL_CODE_CREATE_LOGINS1 = 'if exists (select * from dbo.sysobjects '
      + 'where id = object_id(N''[tempdb]..[#msver]'') )'
	    + #10#13 + 'drop table #msver';

	SQL_CODE_CREATE_LOGINS2 = 'DECLARE @MSSQLVERSION int'
	    + #10#13 + 'create table #msver ([Index] int PRIMARY KEY, '
      + '[Name] varchar(200), Internal_Value int, Character_Value varchar(200))'
	    + #10#13 + 'insert into #msver exec master..xp_msver ProductVersion'
	    + #10#13 + 'select @MSSQLVERSION=CAST(LEFT(Character_Value,1) AS int) '
      + 'from #msver'
	    + #10#13 + 'drop table #msver'
	    + #10#13
	    + #10#13 + 'IF (@MSSQLVERSION = 8) BEGIN'
	    + #10#13 + '  exec master.dbo.sp_addlogin ''operator'', ''operator'''
	    + #10#13 + '  exec master.dbo.sp_addlogin ''manager'', ''manager'''
	    + #10#13 + '  exec master.dbo.sp_addlogin ''pm_service'', ''rfnfgekmnf'''
      + #10#13 + '  exec master.dbo.sp_addlogin ''gcbackupoperator'', '
      + '''j4hhf6kd'''
	    + #10#13 + 'END'
	    + #10#13
	    + #10#13 + 'IF (@MSSQLVERSION = 9) BEGIN'
	    + #10#13 + '  exec sp_executesql N''CREATE LOGIN operator '
      + 'WITH PASSWORD = ''''operator'''' ,CHECK_POLICY = OFF, '
      + 'CHECK_EXPIRATION = OFF'''
	    + #10#13 + '  exec sp_executesql N''CREATE LOGIN manager '
      + 'WITH PASSWORD = ''''manager'''' ,CHECK_POLICY = OFF, '
      + 'CHECK_EXPIRATION = OFF'''
	    + #10#13 + '  exec sp_executesql N''CREATE LOGIN pm_service '
      + 'WITH PASSWORD = ''''rfnfgekmnf'''' ,CHECK_POLICY = OFF, '
      + 'CHECK_EXPIRATION = OFF'''
      + #10#13 + '  exec sp_executesql N''CREATE LOGIN gcbackupoperator '
      + 'WITH PASSWORD = ''''j4hhf6kd'''' ,CHECK_POLICY = OFF, '
      + 'CHECK_EXPIRATION = OFF'''
	    + #10#13 + 'END'
	    + #10#13
	    + #10#13 + 'exec sp_adduser ''operator'', ''operator'', ''public'''
	    + #10#13 + 'exec sp_adduser ''manager'', ''manager'', ''public'''
	    + #10#13 + 'exec sp_addsrvrolemember ''manager'',''sysadmin'''
	    + #10#13 + 'exec sp_adduser ''pm_service'', ''pm_service'', ''public'''
      + #10#13 + 'exec sp_adduser ''gcbackupoperator'', ''gcbackupoperator'', '
      + '''db_backupoperator''';

type

  TfrmMain = class(TForm)
    butClose: TButton;
    RadioGroup1: TRadioGroup;
    rbtnRestore: TRadioButton;
    rbtnBackup: TRadioButton;
    Panel1: TPanel;
    lblCaptionFile: TLabel;
    edtBackupPath: TEdit;
    butBrowse: TButton;
    openDialog: TOpenDialog;
    butBackup: TButton;
    butRestore: TButton;
    memInfo: TMemo;
    lblBackupFilename: TLabel;
    edtBackupName: TEdit;
    tmrName: TTimer;
    editVersion: TEdit;
    directoryEdit: TDirectoryEdit;
    btnCreateEmptyDB: TButton;
    procedure butCloseClick(Sender: TObject);
    procedure butBrowseClick(Sender: TObject);
    procedure rbtnBackupClick(Sender: TObject);
    procedure rbtnRestoreClick(Sender: TObject);
    procedure butBackupClick(Sender: TObject);
    procedure butRestoreClick(Sender: TObject);
    procedure tmrNameTimer(Sender: TObject);
    procedure btnCreateEmptyDBClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FbCustomMode: Boolean;
  public
    procedure SetCustomeMode(const AbCustomMode: Boolean = False);
    procedure DoDesign;
  end;

var
  frmMain: TfrmMain;
  bLogonCorrect: boolean;       // введены верные имя и пароль к SQL-серверу

implementation

uses
  ADODB,
  uCommon,
  uSQLTools,
  uRegistration;
{$R *.dfm}

procedure TfrmMain.SetCustomeMode(const AbCustomMode: Boolean = False);
begin
  FbCustomMode := AbCustomMode;
end;

procedure TfrmMain.DoDesign;
begin
  butBackup.Enabled := rbtnBackup.Checked;
  butRestore.Enabled := rbtnRestore.Checked;
  if butBackup.Enabled then begin
    lblCaptionFile.Caption := MSG_SELECT_FOLDER;
    edtBackupName.Color := clWindow;
    lblBackupFilename.Enabled := true;
  end;
  if butRestore.Enabled then begin
    lblCaptionFile.Caption := MSG_SELECT_FILE_FOR_RESTORE;
    edtBackupName.Color := cl3DLight;
    edtBackupName.Text := '';
    lblBackupFilename.Enabled := false;
    openDialog.Title := MSG_SELECT_FILE_FOR_RESTORE;
  end;
end;

procedure TfrmMain.butCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.butBrowseClick(Sender: TObject);
begin
  if butRestore.Enabled then begin
   if openDialog.Execute then begin
    edtBackupPath.Text := openDialog.FileName;
   end;
  end;
  if butBackup.Enabled then begin
    directoryEdit.DialogText := MSG_SELECT_FOLDER_FOR_BACKUP;
    directoryEdit.DoClick;
   edtBackupPath.Text := directoryEdit.EditText;
  end;
end;

procedure TfrmMain.rbtnBackupClick(Sender: TObject);
begin
  tmrName.Enabled := true;
  tmrNameTimer(Sender);
  edtBackupPath.Text := '';
  DoDesign;
end;

procedure TfrmMain.rbtnRestoreClick(Sender: TObject);
begin
  tmrName.Enabled := false;
  edtBackupPath.Text := '';
  DoDesign;
  butBrowseClick(Sender);
end;

procedure TfrmMain.butBackupClick(Sender: TObject);
var
  frmLogon: TfrmLogon;
  lstMessages: TStringList;
  i: Integer;
  cnnResult: TADOConnection;
begin
  if (Length(edtBackupPath.Text) <= 2) then begin
    memInfo.Lines.Add(MSG_FOLDER_NOT_SELECTED);
    Exit;
  end;
  cnnResult := TADOConnection.Create(Nil);
  lstMessages := TStringList.Create;
  frmLogon := TfrmLogon.Create(Nil, cnnResult);
  frmLogon.UserName := MANAGER;
  if (frmLogon.ShowModal = mrOk) then begin
    memInfo.Lines.Add(MSG_RESTORE_STARTED);
    butBackup.Enabled := false;
    Application.ProcessMessages;
    GCBackup(cnnResult, edtBackupPath.Text + '\' + edtBackupName.Text,
        lstMessages);
    for i := 0 to lstMessages.Count - 1 do
      memInfo.Lines.Add(lstMessages[i]);
    butBackup.Enabled := true;
  end;
  FreeAndNil(cnnResult);
  FreeAndNil(lstMessages);
  FreeAndNil(frmLogon);
end;

procedure TfrmMain.butRestoreClick(Sender: TObject);
var
  lstMessages: TStringList;
  i: Integer;
  cnnResult: TADOConnection;
begin
  if (Length(edtBackupPath.Text) <= 2) then begin
    memInfo.Lines.Add(MSG_FILE_NOT_SELECTED);
    Exit;
  end;
  if (StrLen(Registration.UserName)=0) then begin
    memInfo.Lines.Add(MSG_REGISTRATION_NEDED);
    exit;
  end;
  if MessageBox(Handle, PChar(MSG_RESTORE_WARNING), PChar(MSG_ATTENTION),
      MB_YESNO or MB_ICONWARNING) = IDNO then exit;
  cnnResult := TADOConnection.Create(Nil);
  lstMessages := TStringList.Create;
  frmLogon := TfrmLogon.Create(Application, cnnResult, True, '');
  frmLogon.UserName := MANAGER;
  if (frmLogon.ShowModal = mrOk) then begin
    memInfo.Lines.Add(MSG_BACKUP_STARTED);
    butRestore.Enabled := False;
    Application.ProcessMessages;
    GCRestore(cnnResult, edtBackupPath.Text,
         lstMessages);
    for i := 0 to lstMessages.Count - 1 do
      memInfo.Lines.Add(lstMessages[i]);
    butRestore.Enabled := True;
  end;
  FreeAndNil(cnnResult);
  FreeAndNil(lstMessages);
  FreeAndNil(frmLogon);
end;

procedure TfrmMain.tmrNameTimer(Sender: TObject);
begin
  edtBackupName.Text := GenerateUniqueBackupFileName;
end;

procedure TfrmMain.btnCreateEmptyDBClick(Sender: TObject);
var
  cnnMain: TADOConnection;
  Mess: string;
  strServer: String;
  bResult: Boolean;
  lstErrors: TStringList;
  i: Integer;
  dbUserName,dbPassword: String;
begin
  dbUserName := 'sa';
  dbPassword := '1';
  cnnMain := TADOConnection.Create(Nil);
  lstErrors := TStringList.Create;
  bResult := False;
  memInfo.Lines.Add(MSG_CREATE_BASE_STARTED);
  if FbCustomMode then
    bResult := ConfigureServerWithLogon(strServer,dbUserName,dbPassword)
  else begin
    strServer := SQL_LOCAL_NAME;
    bResult := ConfigureServer(strServer);
  end;
  Invalidate;
  if bResult then begin
    if ADOConnect(cnnMain, lstErrors, i, True,
        strServer, '', dbUserName, dbPassword) then begin
      try
        cnnMain.Execute('create database GameClass');
        cnnMain.Execute('use GameClass');

        cnnMain.Execute(SQL_CODE_CREATE_LOGINS1);
        cnnMain.Execute(SQL_CODE_CREATE_LOGINS2);

        //Установим сложный случайный пароль на sa
        //cnnMain.Execute('declare @pass sysname set @pass=CAST(newid()'
        //    + ' AS sysname) exec master.dbo.sp_password NULL, @pass, ''sa''');
        memInfo.Lines.Add(MSG_CREATE_BASE_SUCCESSFUL);
      except
        memInfo.Lines.Add(MSG_CREATE_BASE_FAILED);
        for i := 0 to cnnMain.Errors.Count - 1 do
          memInfo.Lines.Add(cnnMain.Errors[i].Description);
      end;
      cnnMain.Close;
    end else begin
      memInfo.Lines.Add(MSG_SERVER_CONNECT_FAILED);
      for i := 0 to lstErrors.Count - 1 do
        memInfo.Lines.Add(lstErrors[i]);
    end;
  end else
    memInfo.Lines.Add(MSG_SERVER_TUNING_FAILED);
  FreeAndNil(cnnMain);
  FreeAndNil(lstErrors);
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  rbtnBackupClick(Sender);
  //В предыдущих версиях тут предупреждение не выдавалось
  {
  if (StrLen(Registration.UserName)=0) then begin
    memInfo.Lines.Add(MSG_REGISTRATION_NEDED);
  end;
  }
  memInfo.Lines.Add(MSG_SELECT_ACTION);

end;

end.
