unit uGCBackupRestore;

interface

uses
  ADODB,
  Classes;

function GCBackup(const AcnnMain: TADOConnection;
    const AstrFileName: String; var lstMessages: TStringList): Boolean;
function GCRestore(const AccnMain: TADOConnection;
    const AstrFileName: String): Boolean;
function SQLConnect(server:string; login: string; pass: string):string;
function dsDoCommand(str: string):string;

type

  TRegistration = class
  public
    constructor Create;
  public
    RegisteredUserName  : PChar;
    TrialDaysTotal : Integer;
    TrialDaysLeft  : Integer;
    TrialExTotal : Integer;
    TrialExLeft   : Integer;
    LocalHardwareID: PChar;
    Key : Pointer;
    CompsRegs: integer;
    GCHardwareControl: integer;
    GCInternetControl: integer;
    GCPrinterControl: integer;
    GCInternetControlLinux: integer;
  end;


var
  users: array of string;
  Registration: TRegistration;

implementation

uses
  SysUtils,
  Registry,
  Windows;

type
  PTADODataSet = ^TADODataSet;

var
 cnnMain: TADOConnection;

constructor TRegistration.Create;
begin
  RegisteredUserName := '';
  TrialDaysTotal := -1;
  TrialDaysLeft := -1;
  TrialExTotal := -1;
  TrialExLeft := -1;
  CompsRegs := 100;
  GCHardwareControl := 0;
  GCInternetControl := 0;
  GCPrinterControl := 0;
end;

function dsDoCommand(str: string):string;
var
  cmd: TADOCommand;
begin
  try
    if (cnnMain.Connected) then
    begin
      cmd := TADOCommand.Create(nil);
      cmd.Connection := cnnMain;
      cmd.CommandTimeout := 300;
      cmd.CommandType := cmdText;
      cmd.ParamCheck := false;
      cmd.CommandText := str;
      cmd.execute;
      cmd.Destroy;
      dsDoCommand := 'OK';
    end;
  except
    dsDoCommand := 'Error!';
    if (cnnMain.Errors.Count >0) then
     dsDoCommand := cnnMain.Errors[0].Description;
  end;
end;

procedure dsDoQuery(str: string; pdts: PTADODataSet);
begin
  try
    pdts^.Connection := cnnMain;
    pdts^.LockType := ltOptimistic;
    pdts^.CursorLocation := clUseClient;
    pdts^.CursorType := ctStatic;
    pdts^.CommandText := str;
    pdts^.ParamCheck := false;
    pdts^.Open;
  except
    raise;
  end;
end;


function SQLConnect(server:string; login: string; pass: string):string;
begin
 try
  if (cnnMain <> nil) then cnnMain.Destroy;
  cnnMain := TADOConnection.Create(nil);
  cnnMain.CommandTimeout := 300;
  cnnMain.ConnectionTimeout := 300;
  cnnMain.ConnectOptions := coConnectUnspecified;
  cnnMain.CursorLocation := clUseClient;
  cnnMain.IsolationLevel := ilUnspecified;
  cnnMain.KeepConnection := True;
  cnnMain.LoginPrompt := false;
  cnnMain.Mode := cmReadWrite;
  cnnMain.Provider := 'SQLOLEDB.1';
  cnnMain.ConnectionString := 'Provider=SQLOLEDB.1;Persist Security Info=True;User ID='+login+
  ';Initial Catalog=master;Data Source =' + server + ';Password=' + pass;
  cnnMain.Open;
  SQLConnect := 'OK';
 except
  if cnnMain.Errors.Count>0 then
    SQLConnect := 'Ошибка подключения к SQL-серверу: ' + cnnMain.Errors[0].Description;
  end;
end;

function GCBackup(const AcnnMain: TADOConnection;
    const AstrFileName: String; var lstMessages: TStringList): Boolean;
var
  fullname: string;
  res: string;
  sql: string;
  res_backup: string;
begin
  Result := False;
  lstMessages := TStringList.Create;
  if Assigned(AcnnMain) and AcnnMain.Connected then begin
    if dsDoCommand(sql);

  end else
    lstMessages.Add(SQL_TOOLS_ERR_NO_CONNECTION);

  sql := 'BACKUP DATABASE [GameClass] TO DISK = N''' + fullname + ''' WITH  INIT, NOUNLOAD, NAME=N''GameClass backup'', NOSKIP, STATS=10, NOFORMAT';
  res_backup := dsDoCommand(sql);
  if (res_backup <> 'OK') then begin
    GCBackup := 'Неизвестная ошибка при резервном копировании базы';
    if cnnMain.Errors.Count>0 then
     GCBackup := 'Ошибка резервного копирования базы: ' + res_backup;
    exit;
  end;
 // 3. result
 GCBackup :=  'Резервное копирование в '+fullname+' выполнено успешно!';
end;

function GCRestore(const AccnMain: TADOConnection;
    const AstrFileName: String): Boolean;
var
  dts: TADODataSet;
  dtsManagement: TADODataSet;
  res: string;
  sql: string;
  datapath: string;
  i: integer;
  user: string;
  res_restore: string;
begin
  // 0. connect под SA с нашим паролем
{  res := SQLConnect(sqlserver,'sa','gjgfkbkbdctnfrb');
  if (res <> 'OK') then begin
    GCRestore := 'Не обнаружен установленный GameClass! Вначале проведите полную инсталляцию!';
    exit;
  end;
}
  // 1. connect
{  res := SQLConnect(sqlserver,login,pass);
  if (res <> 'OK') then begin
    GCRestore :=  res;
    exit;
  end;
  // 2. prepare
  datapath := GCRegistryReadStr('SQLDataRoot') + '\Data\';
  // 3. restore
  sql := 'RESTORE DATABASE [GameClass] FROM DISK = N''' + fname + ''' WITH REPLACE, ' +
        'MOVE ''GameClass'' TO N''' + datapath + 'GameClass.mdf'','+
        'MOVE ''GameClass_log'' TO N''' + datapath + 'GameClass_log.ldf''';
  res_restore := dsDoCommand(sql);
  if (res_restore <> 'OK') then begin
    GCRestore := 'Неизвестная ошибка при восстановлении базы';
    if cnnMain.Errors.Count>0 then
     GCRestore := 'Ошибка восстановления базы: ' + res_restore;
    exit;
  end;
  // 4. recovery logins
  dts := TADODataSet.Create(nil);
  dsDoQuery('exec GameClass.dbo.sp_change_users_login "Report"', @dts);
  // цикл по каждому подозрительному логину
  SetLength(users,0);
  i := 0;
  while (not dts.Recordset.EOF) do
  begin
    user := dts.Recordset.Fields.Item['UserName'].Value;
    sql := 'exec GameClass.dbo.sp_change_users_login "Auto_Fix", ''' + user + '''';
    res_restore := dsDoCommand(sql);
    if (res_restore <> 'OK') then begin
      if cnnMain.Errors.Count>0 then begin
        if (user = 'gcbackupoperator') then begin
          dsDoCommand('exec GameClass.dbo.sp_dropuser N''' + user + '''');
          dsDoCommand('exec sp_droplogin N''' + user + '''');
          dsDoCommand('exec master.dbo.sp_addlogin N''gcbackupoperator''');
          dsDoCommand('exec sp_adduser ''gcbackupoperator'', ''gcbackupoperator'', ''db_backupoperator''');
          dsDoCommand('exec master.dbo.sp_password @new=''j4hhf6kd'', @loginame=''gcbackupoperator''');
          dsDoCommand('use master');
        end
        else begin
          // хорошо бы прошарить по номерам ошибок, пока что просто их напишем,
          // а реагировать будем одинаково на все типы:
          // 1. Нет логина = -2147217900
          // 2. Русский логин =
          // 3. Просто не восстанавливается =
          dsDoCommand('exec GameClass.dbo.sp_dropuser N''' + user + '''');
          dsDoCommand('exec sp_droplogin N''' + user + '''');
          dsDoCommand('exec master.dbo.sp_addlogin N''' + user + '''');
          dsDoCommand('exec GameClass.dbo.sp_adduser N''' + user + ''', N''' + user + ''', ''public''');
          // для некоторых хитрых пользователей установим пароли
          if (user = 'pm_service') then begin
            dsDoCommand('exec master.dbo.sp_password @new=''rfnfgekmnf'',@loginame=''pm_service''');
            dsDoCommand('use GameClass');
            dsDoCommand('GRANT  INSERT  ON [dbo].[Errors]  TO [pm_service]');
            dsDoCommand('GRANT  INSERT  ON [dbo].[Information]  TO [pm_service]');
            dsDoCommand('GRANT  INSERT  ON [dbo].[Jobs]  TO [pm_service]');
            dsDoCommand('GRANT  INSERT  ON [dbo].[Warnings]  TO [pm_service]');
            dsDoCommand('use master');
          end
          else begin
            i := i + 1;
            SetLength(users,i);
            users[i-1] := user;
          end;
        end;
        sql := 'select * from GameClass.dbo.Users AS U inner join GameClass.dbo.UsersGroup AS UG '
            + 'on U.idUsersGroup = UG.id where U.Name = N''' + user + ''' and UG.Name=''Management''';
        dtsManagement := TADODataSet.Create(nil);
        dsDoQuery(sql, @dtsManagement);
        if dtsManagement.Recordset.RecordCount >0 then
          dsDoCommand('exec master.dbo.sp_addsrvrolemember N''' + user + ''', ''sysadmin''');
        dtsManagement.Close;
        dtsManagement.Destroy;
      end;
    end;
    dts.Recordset.MoveNext;
  end;
  dts.Close;
  dts.Destroy;
  // 5. result
  GCRestore :=  'Восстановление базы данных из '+fname+' в ' + datapath + 'GameClass.mdf и GameClass_log.ldf выполнено успешно!';
}end;

end.
