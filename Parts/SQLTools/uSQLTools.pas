unit uSQLTools;

interface
uses
  ADODB,
  Windows,
  Classes;

resourcestring
  SQL_TOOLS_NO_CONNECTION =
      'Не удалось установить подключение к SQL-серверу!';
  SQL_TOOLS_BACKUP_UNKNOWN_ERROR =
      'Неизвестная ошибка при резервном копировании базы';
  SQL_TOOLS_BACKUP_ERROR = 'Ошибка резервного копирования базы: ';
  SQL_TOOLS_BACKUP_SUCCESSFULL_START = 'Резервное копирование в ';
  SQL_TOOLS_SUCCESSFULL_END = ' выполнено успешно!';
  SQL_TOOLS_NO_DATAROOT = 'Не удалось определить путь к файлам базы данных!';
  SQL_TOOLS_RESTORE_SUCCESSFULL_START = 'Восстановление базы данных из ';
  SQL_TOOLS_RESTORE_UNKNOWN_ERROR ='Неизвестная ошибка при восстановлении базы';
  SQL_TOOLS_RESTORE_ERROR = 'Ошибка восстановления базы: ';
  SQL_TOOLS_EMPTY_PASSWORD_USERS =
      'Внимание! Для следующих пользователей были установлены пустые пароли:';
  SQL_TOOLS_NEED_SYSADMIN =
      'Внимание! Требуется пользователь с полными правами к базе данных!';

const
  SQL_TOOLS_CONNECTION_TIMEOUT = 5;
  SQL_TOOLS_COMMAND_TIMEOUT = 15;
  SQL_TOOLS_BACKUP_RESTORE_TIMEOUT = 300;
  SQL_LOCAL_NAME = '(LOCAL)';
  SQL_TOOLS_SET_LANGUGE = 'SET LANGUAGE us_english';
  SQL_TOOLS_SERVER_NAME_VALUE = 'Data Source';
  SQL_TOOLS_REGISTRY_SQLSERVER_DEFAULT_INSTANCE =
      '\SOFTWARE\Microsoft\MSSQLServer';
  SQL_TOOLS_REGISTRY_SQLSERVER =
      '\SOFTWARE\Microsoft\Microsoft SQL Server';
  SQL_TOOLS_REGISTRY_SETUP = 'Setup';
  SQL_TOOLS_REGISTRY_DATAROOT = 'SQLDataRoot';
  SQL_TOOLS_REGISTRY_INSTANCES = 'InstalledInstances';
  SQL_TOOLS_REGISTRY_NET = 'MSSQLServer\SuperSocketNetLib';
  SQL_TOOLS_REGISTRY_TCP_KEY = 'Tcp';
  SQL_TOOLS_REGISTRY_TCP_VALUE = 'tcp';
  SQL_TOOLS_REGISTRY_TCP_IPALL = 'IPAll';
  SQL_TOOLS_REGISTRY_PROTOCOLLIST = 'ProtocolList';
  SQL_TOOLS_REGISTRY_CLIENT_SQL2000 = 'Client\SuperSocketNetLib';
  SQL_TOOLS_REGISTRY_CLIENT_SQL2005 = 'Client\SNI9.0';
  SQL_TOOLS_REGISTRY_PROTOCOORDER = 'ProtocolOrder';
  SQL_TOOLS_REGISTRY_ENABLED = 'Enabled';
  SQL_TOOLS_REGISTRY_PORT = 'TcpPort';
  SQL_TOOLS_REGISTRY_NAME = 'Name';
  SQL_TOOLS_REGISTRY_VALUE = 'Value';
  SQL_TOOLS_REGISTRY_DEFAULT_PORT_2000 = 'DefaultPort';
  SQL_TOOLS_REGISTRY_DEFAULT_PORT_2005 = 'Default Port';
  SQL_TOOLS_DEF_PORT = '1433';
  SQL_TOOLS_DEF_PORT_INT = 1433;


  SQL_TOOLS_BACKUP_CODE_START = 'BACKUP DATABASE [GameClass] TO DISK = N''';
  SQL_TOOLS_BACKUP_CODE_END = ''' WITH  INIT, NOUNLOAD, '
      + 'NAME=N''GameClass backup'', NOSKIP, STATS=10, NOFORMAT';
  SQL_TOOLS_DATA_DIRECTORY = 'Data';
  SQL_TOOLS_RESTORE_CODE_1 = 'RESTORE DATABASE [GameClass] FROM DISK = N''';
  SQL_TOOLS_RESTORE_CODE_2 = ''' WITH REPLACE, MOVE ''GameClass'' TO N''';
  SQL_TOOLS_RESTORE_CODE_3 = 'GameClass.mdf'', MOVE ''GameClass_log'' TO N''';
  SQL_TOOLS_RESTORE_CODE_4 = 'GameClass_log.ldf''';

  SQL_TOOLS_REMOVE_LOGINS_CODE_COUNT = 10;
  SQL_TOOLS_REMOVE_LOGINS_CODE: array[1..SQL_TOOLS_REMOVE_LOGINS_CODE_COUNT]
      of PChar = (
      'exec sp_denylogin ''NT AUTHORITY\SYSTEM''',
      'exec sp_denylogin ''BUILTIN\Administrators''',
      'exec sp_denylogin ''BUILTIN\Администраторы''',
      'exec sp_denylogin ''BUILTIN\Users''',
      'exec sp_denylogin ''BUILTIN\Пользователи''',
      'exec sp_revokelogin ''NT AUTHORITY\SYSTEM''',
      'exec sp_revokelogin ''BUILTIN\Administrators''',
      'exec sp_revokelogin ''BUILTIN\Администраторы''',
      'exec sp_revokelogin ''BUILTIN\Users''',
      'exec sp_revokelogin ''BUILTIN\Пользователи''');


type
  TMSSQLServerVersion = (
    MSSQL2000 = 8,
    MSSQL2005 = 9);

function dsDoCommand(const AcnnMain: TADOConnection;
    const AstrSQLCode: String;
    const AnCommandTimeout: Integer = SQL_TOOLS_COMMAND_TIMEOUT): Boolean;
function dsDoQuery(const AcnnMain: TADOConnection;
    var AdtsResult: TADODataSet; const AstrSQLCode: String): Boolean;
function ExecuteStoredProc(const AcnnMain: TADOConnection;
    const AdtsResult: TADOStoredProc): Boolean;

function FloatToSQLStr(AfValue: Double): String;
function SQLStrToFloat(AstrValue: String): Double;
function DateTimeToSQLStr(AdtValue: TDateTime): String;
function MonthToStr(AnNumber: Integer): String;
function StrToQuotedSQLValue(AstrValue: String): String;
function ADOConnect(const AcnnResult: TADOConnection;
    var AlstErrors: TStringList;
    var AnErrorNumber: Integer;
    const AbSQLAuthorizationMode: Boolean;
    const AstrServer: String;
    const AstrDataBase: String = '';
    const AstrLogin: String = '';
    const AstrPassword: String = ''): Boolean;
function ConfigureServerWithLogon(var AstrServerName,dbUserName,dbPassword: String): Boolean;
function ConfigureServer(const AstrServerName: String): Boolean;
function DetectInstance(const AcnnMain: TADOConnection;
    var AstrInstanceName: String): Boolean; overload;
function DetectInstance(const AstrServerName: String;
    var AstrInstanceName: String): Boolean; overload;
function SQLServerDataRootPath(const AstrInstanceName: String = ''): String;
function GCBackup(const AcnnMain: TADOConnection;
    const AstrFileName: String; const lstMessages: TStringList): Boolean;
function GCRestore(const AcnnMain: TADOConnection;
    const AstrFileName: String; const lstMessages: TStringList): Boolean;
function EnableTcp(var AbRestartNeeded: Boolean;
    const AstrServerName: String = ''): Boolean;
function EnableTcpForClient(const AMSSQLServerVersion: TMSSQLServerVersion):
    Boolean;
function SetSAPassword(const ADmo: OleVariant): Boolean;
procedure RestoreUser(const AcnnMain: TADOConnection; const AstrUser: String;
    const lstMessages: TStringList; const AbForce: Boolean = False);
procedure RestoreSpecialUsers(const AcnnMain: TADOConnection;
    const lstMessages: TStringList);
function LoginExists(const AcnnMain: TADOConnection;
    const AstrLogin: String; const lstMessages: TStringList): Boolean;
function SQLServerVersion(const AcnnMain: TADOConnection): Integer;
function IsSysadmin(const AcnnMain: TADOConnection): Boolean;
function GenerateUniqueBackupFileName: String;

implementation

uses
  SysUtils,
  DateUtils,
  StrUtils,
  uY2KString,
  ComObj,
  Variants,
  ufrmLogon,
  Controls,
  Registry,
  uSystemRegistryTools,
  ADOInt,
  uErrors,
  DB,
  uCommon;

function dsDoCommand(const AcnnMain: TADOConnection;
    const AstrSQLCode: String;
    const AnCommandTimeout: Integer = SQL_TOOLS_COMMAND_TIMEOUT): Boolean;
var
  cmd: TADOCommand;
begin
  dsDoCommand := false;
  if (AcnnMain <> nil)  and AcnnMain.Connected then begin
    cmd := TADOCommand.Create(nil);
    cmd.Connection := AcnnMain;
    cmd.CommandTimeout := AnCommandTimeout;
    cmd.CommandType := cmdText;
    cmd.ParamCheck := false;
    cmd.CommandText := AstrSQLCode;
    cmd.ExecuteOptions := [eoExecuteNoRecords];
    try
      cmd.execute;
      dsDoCommand := true;
    except
    end;
    cmd.Free;
  end;
end;

function dsDoQuery(const AcnnMain: TADOConnection;
    var AdtsResult: TADODataSet; const AstrSQLCode: String): Boolean;
begin
  Result := False;
  try
    if (AcnnMain <> nil)  and AcnnMain.Connected then begin
      AdtsResult.Connection := AcnnMain;
      AdtsResult.LockType := ltOptimistic;
      AdtsResult.CursorLocation := clUseClient;
      AdtsResult.CursorType := ctStatic;
      AdtsResult.CommandText := AstrSQLCode;
      AdtsResult.ParamCheck := false;
      AdtsResult.Open;
      Result := True;
    end;
  except
  end;
end;

function ExecuteStoredProc(const AcnnMain: TADOConnection;
    const AdtsResult: TADOStoredProc): Boolean;
begin
  Result := False;
  try
    if (AcnnMain <> nil)  and AcnnMain.Connected then begin
      AdtsResult.Connection := AcnnMain;
      AdtsResult.LockType := ltOptimistic;
      AdtsResult.CursorLocation := clUseClient;
      AdtsResult.CursorType := ctStatic;
      AdtsResult.ExecProc;
      Result := True;
    end;
  except
  end;
end;

function FloatToSQLStr(AfValue: Double): String;
var
  str: string;
begin
  str := FloatToStr(AfValue);
  FloatToSQLStr := AnsiReplaceStr(str,',','.');
end;

function SQLStrToFloat(AstrValue: String): Double;
begin
  SQLStrToFloat := StrToFloatDefWithReplace(AstrValue,0);
end;

// переводит дату/время в формат для SQL-сервака по типу '19 jan 2003 17:00:20'
function DateTimeToSQLStr(AdtValue: TDateTime): String;
begin
  Result := IntToStr(DayOf(AdtValue)) + ' '
      + MonthToStr(MonthOf(AdtValue)) + ' '
      + IntToStr(YearOf(AdtValue)) + ' ';
  Result := Result + IntToStr(HourOf(AdtValue)) + ':';
  Result := Result + IntToStr(MinuteOf(AdtValue)) + ':';
  Result := Result + IntToStr(SecondOf(AdtValue));
end;

function MonthToStr(AnNumber: Integer): String;
begin
  case AnNumber of
  1: Result := 'jan';
  2: Result := 'feb';
  3: Result := 'mar';
  4: Result := 'apr';
  5: Result := 'may';
  6: Result := 'jun';
  7: Result := 'jul';
  8: Result := 'aug';
  9: Result := 'sep';
  10: Result := 'oct';
  11: Result := 'nov';
  12: Result := 'dec';
  else
    Assert(True, 'Число месяца больше 12!');
  end;
end;

// Если успешно подключается - возвращает True
// подключает AConnection к базе,
// добавляет в AlstErrors ошибки
// Если возникаеит ошибка - возвращает False
function ADOConnect(const AcnnResult: TADOConnection;
    var AlstErrors: TStringList;
    var AnErrorNumber: Integer;
    const AbSQLAuthorizationMode: Boolean;
    const AstrServer: String;
    const AstrDataBase: String = '';
    const AstrLogin: String = '';
    const AstrPassword: String = ''): Boolean;
var
  i: Integer;
begin
  Result := False;
  AnErrorNumber := ERRNUM_DEFAULT;
  ASSERT(Assigned(AcnnResult));
  ASSERT(Assigned(AlstErrors));
  if Assigned(AcnnResult) then
    with AcnnResult do begin
      CommandTimeout := 15;
      ConnectionTimeout := 5;
      ConnectOptions := coConnectUnspecified;
      CursorLocation := clUseClient;
      IsolationLevel := ilCursorStability;
      KeepConnection := True;
      LoginPrompt := false;
      Mode := cmReadWrite;
      Provider := 'SQLOLEDB.1';
      ConnectionString := 'Provider=SQLOLEDB.1;' + 'Persist Security Info=';
      if AbSQLAuthorizationMode then
        ConnectionString := ConnectionString + 'True;'
            + 'User ID=' + StrToQuotedSQLValue(AstrLogin) + ';'
            + 'Password=' + StrToQuotedSQLValue(AstrPassword) + ';'
      else
        ConnectionString := ConnectionString + 'False;Integrated Security=SSPI;';
      ConnectionString := ConnectionString
          + 'Data Source =' + StrToQuotedSQLValue(AstrServer);
      if AstrDataBase <> '' then
        ConnectionString := ConnectionString + ';'
            + 'Initial Catalog=' + StrToQuotedSQLValue(AstrDataBase);
      try
        AcnnResult.Open;
        if(AcnnResult.Connected) then begin
          Result := dsDoCommand(AcnnResult, SQL_TOOLS_SET_LANGUGE);
        end;
      except
        if Assigned(AlstErrors) and (Errors.Count > 0) then begin
          if Errors[0].Number = -2147467259 then
            AnErrorNumber := ERRNUM_SQLSERVER_NOT_EXIST;
          if Errors[0].Number = -2147217843 then
            AnErrorNumber := ERRNUM_SQLSERVER_PASSWORD_INCORRECT;
          for i := 0 to Errors.Count - 1 do
            AlstErrors.Add(Errors[i].Description);
        end;
      end;
    end;
end;

function StrToQuotedSQLValue(AstrValue: String): String;
begin
  // было pass"w4 стало "pass""w4"
  Result := '"' + AnsiReplaceStr(AstrValue, '"', '""') + '"';
end;

function ConfigureServer(const AstrServerName: String): Boolean;
var
  dmo: OleVariant;
  bRestartNeeded: Boolean;
  i: Integer;
  str: String;
begin
  Result := False;
  try
    dmo := CreateOleObject('SQLDMO.SQLServer');
  except
     MessageBox(0, 'SQL-сервер не установлен!' + Char(13)
        + 'Смотрите раздел помощи "Инсталляция GameClass"', 'Ошибка',
        MB_ICONERROR + MB_OK);
     exit;
  end;
  dmo.Name := AstrServerName;
  try
    EnableTcp(bRestartNeeded, AstrServerName);
    if dmo.Status <> 1 then
      dmo.Start(False, AstrServerName)
    else if bRestartNeeded then begin
      dmo.Stop;
      repeat
      until dmo.Status = 	3; {SQLDMOSvc_Stopped}
      dmo.Start(False, AstrServerName);
    end;
    while dmo.Status <>1 do
    begin
    if (dmo.Status = 0)
      or (dmo.Status = 2)
      or (dmo.Status = 3) then
      raise Exception.Create('');
    end;
  except
     MessageBox(0, 'Невозможно запустить SQL-сервер!' , 'Ошибка',
        MB_ICONERROR + MB_OK);
     exit;
  end;
  dmo.LoginTimeout := 300;
  dmo.LoginSecure := False;
  try
    dmo.Connect(AstrServerName, 'sa', '1');
    Result := True;
  except
  end;
  if not Result then try
    dmo.Connect(AstrServerName, 'sa', '');
    SetSAPassword(dmo);
    dmo.DisConnect;
    dmo.Connect(AstrServerName, 'sa', '1');
    Result := True;
  except
  end;
  if not Result then try
    dmo.LoginSecure := True;
    dmo.Connect(AstrServerName);
    SetSAPassword(dmo);
    if dmo.IntegratedSecurity.SecurityMode = 2 {SQLDMOSecurity_Mixed}  then
      dmo.DisConnect
    else begin
      dmo.IntegratedSecurity.SecurityMode := 2; {SQLDMOSecurity_Mixed}
      dmo.DisConnect;
      dmo.Stop;
      repeat
      until dmo.Status = 	3; {SQLDMOSvc_Stopped}
      dmo.Start(False, AstrServerName);
    end;
    dmo.Connect(AstrServerName, 'sa', '1');
    Result := True;
  except
  end;
  if Result then begin
    //Отключим любую возможность зайти на SQL-сервер с Windows-авторизацией
    for i := 1 to SQL_TOOLS_REMOVE_LOGINS_CODE_COUNT do
      try
        str := SQL_TOOLS_REMOVE_LOGINS_CODE[i];
        dmo.ExecuteImmediate(str);
      except
      end;
    dmo.DisConnect;
  end;
  dmo := null;
end;

function ConfigureServerWithLogon(var AstrServerName,dbUserName,dbPassword: String): Boolean;
var
  dmo: OleVariant;
  frmLogon: TfrmLogon;
  bRestartNeeded: Boolean;
  i: Integer;
  str: String;
begin
  Result := False;
  try
    dmo := CreateOleObject('SQLDMO.SQLServer');
  except
     MessageBox(0, 'SQL-сервер не установлен!' + Char(13)
        + 'Смотрите раздел помощи "Инсталляция GameClass"', 'Ошибка',
        MB_ICONERROR + MB_OK);
     exit;
  end;
  frmLogon := TfrmLogon.Create(Nil, Nil, True);
  repeat
    if frmLogon.ShowModal = mrOk then begin
      dmo.Name := frmLogon.ServerName;
      try
        EnableTcp(bRestartNeeded, frmLogon.ServerName);
        if dmo.Status <> 1 then
          dmo.Start(False, frmLogon.ServerName)
        else if bRestartNeeded then begin
          dmo.Stop;
          repeat
          until dmo.Status = 	3; {SQLDMOSvc_Stopped}
          dmo.Start(False, frmLogon.ServerName);
        end;
        if dmo.Status <> 1 then
          raise Exception.Create('');
      except
         MessageBox(0, 'Невозможно запустить SQL-сервер!' , 'Ошибка',
            MB_ICONERROR + MB_OK);
         exit;
      end;
      dmo.LoginTimeout := 300;
      if frmLogon.WindowsAuthentication then try
        dmo.LoginSecure := True;
        dmo.Connect(frmLogon.ServerName);
//        SetSAPassword(dmo);
        if dmo.IntegratedSecurity.SecurityMode = 2 {SQLDMOSecurity_Mixed} then
          dmo.DisConnect
        else begin
          dmo.IntegratedSecurity.SecurityMode := 2; {SQLDMOSecurity_Mixed}
          dmo.DisConnect;
          dmo.Stop;
          repeat
          until dmo.Status = 	3; {SQLDMOSvc_Stopped}
          dmo.Start(False, frmLogon.ServerName);
        end;
        dmo.Connect(frmLogon.ServerName,frmLogon.UserName,
            frmLogon.Password);
        Result := True;
      except
      end else begin//try
        dmo.LoginSecure := False;
        dmo.Connect(frmLogon.ServerName, frmLogon.UserName,
            frmLogon.Password);
        dbUserName := frmLogon.UserName;
        dbPassword := frmLogon.Password; 
{        SetSAPassword(dmo);
        dmo.DisConnect;
        dmo.Connect(frmLogon.ServerName, 'sa', '1');}
        Result := True;
     // except
      end;
    end;
  until Result or (frmLogon.ModalResult = mrCancel);
  if Result then begin
    AstrServerName := frmLogon.ServerName;
    //Отключим любую возможность зайти на SQL-сервер с Windows-авторизацией
    for i := 1 to SQL_TOOLS_REMOVE_LOGINS_CODE_COUNT do
      try
        str := SQL_TOOLS_REMOVE_LOGINS_CODE[i];
        dmo.ExecuteImmediate(str);
      except
      end;
    dmo.DisConnect;

  end;
  dmo := null;
end;

function DetectInstance(const AcnnMain: TADOConnection;
    var AstrInstanceName: String): Boolean; overload;
var
  str: String;
begin
  Result := False;
  if (AcnnMain <> nil) and AcnnMain.Connected then begin
    str := AcnnMain.ConnectionString;
    str := AnsiReplaceStr(str, ' =', '=');
    str := AnsiReplaceStr(str, '= ', '=');
    if AnsiContainsText(str, SQL_TOOLS_SERVER_NAME_VALUE) then begin
      str := AnsiRightStr(str, Length(str)
          - AnsiPos(SQL_TOOLS_SERVER_NAME_VALUE, str)
          - Length(SQL_TOOLS_SERVER_NAME_VALUE));
      if AnsiPos(';', str) <> 0 then
        str := AnsiLeftStr(str, AnsiPos(';', str) - 1);
      str := AnsiDequotedStr(str, '''');
      str := AnsiDequotedStr(str, '"');
      if AnsiContainsText(str, '\') then begin
        AstrInstanceName := AnsiRightStr(str, Length(str) - AnsiPos('\', str));
        Result := True;
      end;
    end;
  end;
end;

function DetectInstance(const AstrServerName: String;
    var AstrInstanceName: String): Boolean; overload;
begin
  Result := False;
  if AnsiContainsText(AstrServerName, '\') then begin
    AstrInstanceName := AnsiRightStr(AstrServerName,
        Length(AstrServerName) - AnsiPos('\', AstrServerName));
    Result := True;
  end;
end;

function SQLServerDataRootPath(const AstrInstanceName: String = ''): String;
var
  reg: TRegistry;
  strInstanceName: String;
  i: Integer;
  lstStrings: TStringList;
begin
  // Есть три варианта, где находится параметр SQLDataRoot
  // 1. SQL 2000 Установка по-умолчанию без instance
  //    HKLM\SOFTWARE\Microsoft\MSSQLServer\Setup\SQLDataRoot
  //
  // 2. SQL 2005
  //    HKLM\SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL.x\Setup\SQLDataRoot
  //    причем в
  //        HKLM\SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL.x\По умолчанию
  //    лежит имя из
  //        HKLM\SOFTWARE\Microsoft\Microsoft SQL Server\InstalledInstances
  //
  // 3. SQL 2000 Установка с instance
  //    HKLM\SOFTWARE\Microsoft\Microsoft SQL Server\XXX\Setup\SQLDataRoot
  //    причем в
  //        HKLM\SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL.x\По умолчанию
  //    лежит имя из
  //        HKLM\SOFTWARE\Microsoft\Microsoft SQL Server\InstalledInstances
  Result := '';
  Reg := TRegistry.Create;
  Reg.RootKey := HKEY_LOCAL_MACHINE;

  if Reg.OpenKey(SQL_TOOLS_REGISTRY_SQLSERVER, False) then
  begin
    strInstanceName := '';
    try
      //Получаем/проверяем имя instance
      lstStrings := RegistryReadMultiString(Reg,
          SQL_TOOLS_REGISTRY_INSTANCES);
      if (lstStrings <> Nil) and (lstStrings.Count > 0) then begin
        if (AstrInstanceName <> '') then begin
          for i := 0 to lstStrings.Count - 1 do
            if AnsiCompareText(lstStrings[i],
                AstrInstanceName) = 0 then
              strInstanceName := lstStrings[i]
        end else
          strInstanceName := lstStrings[0];
        lstStrings.Free;
      end;
    except
    end;
    Reg.CloseKey;
    if (strInstanceName <> '') then begin
      if (AstrInstanceName = '') and Reg.OpenKey(
          SQL_TOOLS_REGISTRY_SQLSERVER_DEFAULT_INSTANCE + '\'
          + SQL_TOOLS_REGISTRY_SETUP, False) then begin
        // 1-й вариант
        try
          Result := Reg.ReadString(SQL_TOOLS_REGISTRY_DATAROOT);
        except
        end;
      Reg.CloseKey;
      end;
      if (Result = '') and Reg.OpenKey(SQL_TOOLS_REGISTRY_SQLSERVER,
          False) then begin
        // 2-й и 3-й вариант
        try
          lstStrings := TStringList.Create;
          Reg.GetKeyNames(lstStrings);
          if lstStrings.Count > 0 then begin
            for i := 0 to lstStrings.Count - 1 do begin
              if lstStrings[i] = strInstanceName then begin
                // 3-й вариант
                reg.CloseKey;
                if Reg.OpenKey(SQL_TOOLS_REGISTRY_SQLSERVER + '\'
                    + strInstanceName + '\' + SQL_TOOLS_REGISTRY_SETUP ,
                    False) then
                  try
                    Result := reg.ReadString(SQL_TOOLS_REGISTRY_DATAROOT);
                    if (Result <> '') then
                      Break;
                  except
                  end;
              end else begin
                // 2-й вариант
                Reg.CloseKey;
                if Reg.OpenKey(SQL_TOOLS_REGISTRY_SQLSERVER + '\'
                    + lstStrings[i], False) then begin
                  try
                    if reg.ReadString('') = strInstanceName then begin
                      reg.CloseKey;
                      if Reg.OpenKey(SQL_TOOLS_REGISTRY_SQLSERVER + '\'
                          + lstStrings[i] + '\' + SQL_TOOLS_REGISTRY_SETUP,
                          False) then begin
                        Result := reg.ReadString(SQL_TOOLS_REGISTRY_DATAROOT);
                        if (Result <> '') then
                          Break;
                      end;
                    end;
                  except
                  end;
                end
              end;
            end;
            lstStrings.Free;
          end;
        except
        end;
        Reg.CloseKey;
      end;
    end;
    Reg.Free;
  end;
end;

function GCBackup(const AcnnMain: TADOConnection;
    const AstrFileName: String; const lstMessages: TStringList): Boolean;
var
  i: Integer;
begin
  Result := False;
  ASSERT(Assigned(AcnnMain));
  ASSERT(Assigned(lstMessages));
  if Assigned(AcnnMain) and AcnnMain.Connected then begin
    Result := dsDoCommand(AcnnMain, SQL_TOOLS_BACKUP_CODE_START + AstrFileName
        + SQL_TOOLS_BACKUP_CODE_END, SQL_TOOLS_BACKUP_RESTORE_TIMEOUT);
    if Result then
      lstMessages.Add(SQL_TOOLS_BACKUP_SUCCESSFULL_START + AstrFileName
          + SQL_TOOLS_SUCCESSFULL_END)
    else begin
      if AcnnMain.Errors.Count > 0 then begin
        lstMessages.Add(SQL_TOOLS_BACKUP_ERROR);
        for i := 0 to AcnnMain.Errors.Count - 1 do
          lstMessages.Add(AcnnMain.Errors[i].Description);
      end else
        lstMessages.Add(SQL_TOOLS_BACKUP_UNKNOWN_ERROR);
    end;
  end else
    lstMessages.Add(SQL_TOOLS_NO_CONNECTION);
end;

function GCRestore(const AcnnMain: TADOConnection;
    const AstrFileName: String; const lstMessages: TStringList): Boolean;
var
  dts: TADODataSet;
  i: Integer;
  strInstanceName, strDataPath: String;
begin
  Result := False;
  ASSERT(Assigned(AcnnMain));
  ASSERT(Assigned(lstMessages));
  if Assigned(AcnnMain) and AcnnMain.Connected then begin
    DetectInstance(AcnnMain, strInstanceName);
    strDataPath := SQLServerDataRootPath(strInstanceName);
    if strDataPath <> '' then begin
      strDataPath := strDataPath + '\' + SQL_TOOLS_DATA_DIRECTORY + '\';
      Result := dsDoCommand(AcnnMain, SQL_TOOLS_RESTORE_CODE_1 + AstrFileName
          + SQL_TOOLS_RESTORE_CODE_2 + strDataPath + SQL_TOOLS_RESTORE_CODE_3
          + strDataPath + SQL_TOOLS_RESTORE_CODE_4,
          SQL_TOOLS_BACKUP_RESTORE_TIMEOUT);
      if not Result then begin
        if AcnnMain.Errors.Count > 0 then begin
          lstMessages.Add(SQL_TOOLS_RESTORE_ERROR);
          for i := 0 to AcnnMain.Errors.Count - 1 do
            lstMessages.Add(AcnnMain.Errors[i].Description);
        end else
          lstMessages.Add(SQL_TOOLS_RESTORE_UNKNOWN_ERROR);
      end;
    end else
      lstMessages.Add(SQL_TOOLS_NO_DATAROOT);
  end else
    lstMessages.Add(SQL_TOOLS_NO_CONNECTION);
  if Result then begin
    // восстановление логинов
    dts := TADODataSet.Create(nil);
    dsDoQuery(AcnnMain, dts,
        'exec GameClass.dbo.sp_change_users_login "Report"');
    // цикл по каждому подозрительному логину
    lstMessages.Add(SQL_TOOLS_EMPTY_PASSWORD_USERS);
    i := 0;
    while (not dts.Recordset.EOF) do begin
      RestoreUser(AcnnMain, dts.Recordset.Fields.Item['UserName'].Value,
          lstMessages);
    dts.Recordset.MoveNext;
    end;
    dts.Close;
    FreeAndNil(dts);
    if i = 0 then
      lstMessages.Delete(lstMessages.Count - 1);
    RestoreSpecialUsers(AcnnMain, lstMessages);
    lstMessages.Add(SQL_TOOLS_RESTORE_SUCCESSFULL_START + AstrFileName
        + SQL_TOOLS_SUCCESSFULL_END)
  end;
end;

function EnableTcp(var AbRestartNeeded: Boolean;
    const AstrServerName: String = ''): Boolean;
var
  reg: TRegistry;
  strInstanceName, str: String;
  i, nEnabled: Integer;
  lstStrings: TStringList;
  bKeyFound: Boolean;
  lstProtocols: TStringList;
begin
  // Есть три варианта, где находится параметр SQLDataRoot
  // 1. SQL 2000 по-умолчанию
  //    HKLM\SOFTWARE\Microsoft\MSSQLServer\MSSQLServer\SuperSocketNetLib
  //       ProtocolList=hex(7):74,00,63,00,70,00,20,00,6e,00,70,00,00,00,00,00
  //       \Tcp\TcpPort='1433'
  //
  // 2. SQL 2005 Повторная установка по-умолчанию без instance либо SQL 2005
  //    HKLM\SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL.x\SuperSocketNetLib
  //       \Tcp\Enabled=dword:00000001
  //       \Tcp\IPAll\TcpPort='1433'
  //    причем в
  //        HKLM\SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL.x\По умолчанию
  //    лежит первое имя из
  //        HKLM\SOFTWARE\Microsoft\Microsoft SQL Server\InstalledInstances
  //    т.е. InstanceName сервера по-умолчанию
  //
  // 3. Установка с instance
  //    HKLM\SOFTWARE\Microsoft\Microsoft SQL Server\XXX\Setup\SQLDataRoot
  //       ProtocolList=hex(7):74,00,63,00,70,00,20,00,6e,00,70,00,00,00,00,00
  //       \Tcp\TcpPort='1433'
  //    причем в
  //        HKLM\SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL.x\По умолчанию
  //    лежит первое имя из
  //        HKLM\SOFTWARE\Microsoft\Microsoft SQL Server\InstalledInstances
  //    т.е. InstanceName сервера по-умолчанию
  Result := False;
  AbRestartNeeded := False;
  Reg := TRegistry.Create;
  Reg.RootKey := HKEY_LOCAL_MACHINE;
  DetectInstance(AstrServerName, str);

  if Reg.OpenKey(SQL_TOOLS_REGISTRY_SQLSERVER, False) then begin
    strInstanceName := '';
    try
      //Получаем/проверяем имя instance
      lstStrings := RegistryReadMultiString(Reg,
          SQL_TOOLS_REGISTRY_INSTANCES);
      if (lstStrings <> Nil) and (lstStrings.Count > 0) then begin
        if (str <> '') then begin
          for i := 0 to lstStrings.Count - 1 do
            if AnsiCompareText(lstStrings[i],
                str) = 0 then
              strInstanceName := lstStrings[i]
        end else
          strInstanceName := lstStrings[0];
        lstStrings.Free;
      end;
    except
    end;
    Reg.CloseKey;
    bKeyFound := False;
    if (strInstanceName <> '') then begin
      if (str = '') and Reg.OpenKey(
          SQL_TOOLS_REGISTRY_SQLSERVER_DEFAULT_INSTANCE + '\'
          + SQL_TOOLS_REGISTRY_NET, False) then begin
        // 1-й вариант
        try
          lstProtocols := RegistryReadMultiString(Reg,
              SQL_TOOLS_REGISTRY_PROTOCOLLIST);
          bKeyFound := True;
          if lstProtocols.IndexOf(SQL_TOOLS_REGISTRY_TCP_VALUE) = -1 then begin
            lstProtocols.Add(SQL_TOOLS_REGISTRY_TCP_VALUE);
            RegistryWriteMultiString(Reg,
              SQL_TOOLS_REGISTRY_PROTOCOLLIST, lstProtocols);
            AbRestartNeeded := True;
          end else
            AbRestartNeeded := False;
          FreeAndNil(lstProtocols);
          //Теперь устанавливаем порт по умолчанию 1433
          Reg.CloseKey;
          if Reg.OpenKey(SQL_TOOLS_REGISTRY_SQLSERVER_DEFAULT_INSTANCE + '\'
              + SQL_TOOLS_REGISTRY_NET + '\'
              + SQL_TOOLS_REGISTRY_TCP_KEY , False) then begin
            if Reg.ReadString(SQL_TOOLS_REGISTRY_PORT) <> SQL_TOOLS_DEF_PORT
                then begin
              Reg.WriteString(SQL_TOOLS_REGISTRY_PORT, SQL_TOOLS_DEF_PORT);
              AbRestartNeeded := True;
            end;
          end;
          Result := True;
          EnableTcpForClient(MSSQL2000);
        except
        end;
        Reg.CloseKey;
      end;
      if not bKeyFound and Reg.OpenKey(SQL_TOOLS_REGISTRY_SQLSERVER,
          False) then begin
        // 2-й и 3-й вариант
        try
          lstStrings := TStringList.Create;
          Reg.GetKeyNames(lstStrings);
          if lstStrings.Count > 0 then begin
            for i := 0 to lstStrings.Count - 1 do begin
              if lstStrings[i] = strInstanceName then begin
                // 3-й вариант
                reg.CloseKey;
                if Reg.OpenKey(SQL_TOOLS_REGISTRY_SQLSERVER + '\'
                    + strInstanceName + '\'
                    + SQL_TOOLS_REGISTRY_NET ,
                    False) then
                  try
                    lstProtocols := RegistryReadMultiString(Reg,
                        SQL_TOOLS_REGISTRY_PROTOCOLLIST);
                    bKeyFound := True;
                    if lstProtocols.IndexOf(SQL_TOOLS_REGISTRY_TCP_VALUE) = -1 then begin
                      lstProtocols.Add(SQL_TOOLS_REGISTRY_TCP_VALUE);
                      RegistryWriteMultiString(Reg,
                        SQL_TOOLS_REGISTRY_PROTOCOLLIST, lstProtocols);
                      AbRestartNeeded := True;
                    end else
                      AbRestartNeeded := False;
                    FreeAndNil(lstProtocols);
                    //Теперь устанавливаем порт по умолчанию 1433
                    Reg.CloseKey;
                    if Reg.OpenKey(SQL_TOOLS_REGISTRY_SQLSERVER + '\'
                        + strInstanceName + '\'
                        + SQL_TOOLS_REGISTRY_NET + '\'
                        + SQL_TOOLS_REGISTRY_TCP_KEY , False) then begin
                      if Reg.ReadString(SQL_TOOLS_REGISTRY_PORT)
                          <> SQL_TOOLS_DEF_PORT then begin
                        Reg.WriteString(SQL_TOOLS_REGISTRY_PORT,
                            SQL_TOOLS_DEF_PORT);
                        AbRestartNeeded := True;
                      end;
                    end;
                    Result := True;
                    EnableTcpForClient(MSSQL2000);
                    Break;
                  except
                  end;
              end else begin
                // 2-й вариант
                Reg.CloseKey;
                if Reg.OpenKey(SQL_TOOLS_REGISTRY_SQLSERVER + '\'
                    + lstStrings[i], False) then begin
                  try
                    if reg.ReadString('') = strInstanceName then begin
                      reg.CloseKey;
                      if Reg.OpenKey(SQL_TOOLS_REGISTRY_SQLSERVER + '\'
                          + lstStrings[i] + '\'
                          + SQL_TOOLS_REGISTRY_NET + '\'
                          + SQL_TOOLS_REGISTRY_TCP_KEY,
                          False) then begin
                        nEnabled := reg.ReadInteger(
                            SQL_TOOLS_REGISTRY_ENABLED);
                        if nEnabled <> 1 then begin
                          reg.WriteInteger(SQL_TOOLS_REGISTRY_ENABLED, 1);
                          AbRestartNeeded := True;
                        end else
                          AbRestartNeeded := False;
                        //Теперь устанавливаем порт по умолчанию 1433
                        Reg.CloseKey;
                        if Reg.OpenKey(
                            SQL_TOOLS_REGISTRY_SQLSERVER + '\'
                            + lstStrings[i] + '\'
                            + SQL_TOOLS_REGISTRY_NET + '\'
                            + SQL_TOOLS_REGISTRY_TCP_KEY + '\'
                            + SQL_TOOLS_REGISTRY_TCP_IPALL , False) then begin
                          if Reg.ReadString(SQL_TOOLS_REGISTRY_PORT)
                              <> SQL_TOOLS_DEF_PORT then begin
                            Reg.WriteString(SQL_TOOLS_REGISTRY_PORT,
                                SQL_TOOLS_DEF_PORT);
                            AbRestartNeeded := True;
                          end;
                        end;
                        Result := True;
                        EnableTcpForClient(MSSQL2005);
                        Break;
                      end;
                    end;
                  except
                  end;
                end
              end;
            end;
            lstStrings.Free;
          end;
        except
        end;
        Reg.CloseKey;
      end;
    end;
    Reg.Free;
  end;
end;

function EnableTcpForClient(const AMSSQLServerVersion: TMSSQLServerVersion):
    Boolean;
var
  reg: TRegistry;
  strInstanceName, str: String;
  i, nEnabled: Integer;
  bKeyFound: Boolean;
  lstProtocols, lstStrings: TStringList;
begin
  // Есть два варианта, где находится параметр SQLDataRoot
  // 1. SQL 2000
  //    HKLM\SOFTWARE\Microsoft\MSSQLServer\Client\SuperSocketNetLib
  //       ProtocolOrder='tcp ...'
  //       \Tcp\DefaultPort=1433
  //
  // 2. SQL 2005
  //    HKLM\SOFTWARE\Microsoft\MSSQLServer\Client\SNI9.0
  //       ProtocolOrder='tcp ...'
  //       \tcp\PropertyX\Name='Default Port'
  //       \tcp\PropertyX\Value=dword:1433
  Result := False;
  Reg := TRegistry.Create;
  Reg.RootKey := HKEY_LOCAL_MACHINE;
  case AMSSQLServerVersion of
    MSSQL2000:
      if Reg.OpenKey(SQL_TOOLS_REGISTRY_SQLSERVER_DEFAULT_INSTANCE
          + '\' + SQL_TOOLS_REGISTRY_CLIENT_SQL2000, False) then begin
        //ставим tcp первым в список
        Result := True;
        try
          lstProtocols := RegistryReadMultiString(Reg,
              SQL_TOOLS_REGISTRY_PROTOCOORDER);
          with lstProtocols do begin
            if IndexOf(SQL_TOOLS_REGISTRY_TCP_VALUE) <> -1 then
              Delete(IndexOf(SQL_TOOLS_REGISTRY_TCP_VALUE));
            Insert(0, SQL_TOOLS_REGISTRY_TCP_VALUE);
          end;
          RegistryWriteMultiString(Reg, SQL_TOOLS_REGISTRY_PROTOCOORDER,
              lstProtocols);
          lstProtocols.Free;
          Reg.CloseKey;
          if Reg.OpenKey(SQL_TOOLS_REGISTRY_SQLSERVER_DEFAULT_INSTANCE
              + '\' + SQL_TOOLS_REGISTRY_CLIENT_SQL2000 + '\'
              + SQL_TOOLS_REGISTRY_TCP_KEY, False) then begin
            Reg.WriteInteger(SQL_TOOLS_REGISTRY_DEFAULT_PORT_2000,
                SQL_TOOLS_DEF_PORT_INT);
            Reg.CloseKey;
          end;
        except
          Result := False;
        end
      end;
    MSSQL2005: begin
      if Reg.OpenKey(SQL_TOOLS_REGISTRY_SQLSERVER_DEFAULT_INSTANCE
          + '\' + SQL_TOOLS_REGISTRY_CLIENT_SQL2005, False) then begin
        //ставим tcp первым в список
        Result := True;
        try
          lstProtocols := RegistryReadMultiString(Reg,
              SQL_TOOLS_REGISTRY_PROTOCOORDER);
          with lstProtocols do begin
            if IndexOf(SQL_TOOLS_REGISTRY_TCP_VALUE) <> -1 then
              Delete(IndexOf(SQL_TOOLS_REGISTRY_TCP_VALUE));
            Insert(0, SQL_TOOLS_REGISTRY_TCP_VALUE);
          end;
          RegistryWriteMultiString(Reg, SQL_TOOLS_REGISTRY_PROTOCOORDER,
              lstProtocols);
          lstProtocols.Free;
          Reg.CloseKey;
          if Reg.OpenKey(SQL_TOOLS_REGISTRY_SQLSERVER_DEFAULT_INSTANCE
              + '\' + SQL_TOOLS_REGISTRY_CLIENT_SQL2005
              + '\' + SQL_TOOLS_REGISTRY_TCP_VALUE, False) then begin
            lstStrings := TStringList.Create;
            Reg.GetKeyNames(lstStrings);
            Reg.CloseKey;
            if lstStrings.Count > 0 then begin
              for i := 0 to lstStrings.Count - 1 do begin
                if Reg.OpenKey(SQL_TOOLS_REGISTRY_SQLSERVER_DEFAULT_INSTANCE
                    + '\' + SQL_TOOLS_REGISTRY_CLIENT_SQL2005
                    + '\' + SQL_TOOLS_REGISTRY_TCP_VALUE
                    + '\' + lstStrings[i], False) then begin
                  if Reg.ReadString(SQL_TOOLS_REGISTRY_NAME)
                      = SQL_TOOLS_REGISTRY_DEFAULT_PORT_2005 then
                    Reg.WriteInteger(SQL_TOOLS_REGISTRY_VALUE,
                        SQL_TOOLS_DEF_PORT_INT);
                  Reg.CloseKey;
                end;
              end;
            end;
          end;
        except
          Result := False;
        end;
      end;
    end;
  end;
end;

function SetSAPassword(const ADmo: OleVariant): Boolean;
begin
  Result := False;
  try
    ADmo.ExecuteImmediate(
        'exec master.dbo.sp_password @new=''1'', @loginame=''sa''');
    Result := True;
  except
  end;
//  if not Result then  //убрал т.к. первый код на 2005 отрабатывает
//                        // а логин не энейблится
  try
    ADmo.ExecuteImmediate(
        'ALTER LOGIN sa WITH PASSWORD = ''1'' ,CHECK_POLICY = OFF, '
        + 'CHECK_EXPIRATION = OFF');
    ADmo.ExecuteImmediate(
        'ALTER LOGIN sa ENABLE');
    Result := True;
  except
  end;
end;

procedure RestoreUser(const AcnnMain: TADOConnection; const AstrUser: String;
    const lstMessages: TStringList; const AbForce: Boolean = False);
var
  i, nVersion: Integer;
  dtsManagement: TADODataSet;
begin
  if AbForce or not dsDoCommand(AcnnMain,
      'exec GameClass.dbo.sp_change_users_login "Auto_Fix", '''
      + AstrUser + '''') then begin
    // на все ошибки реагируем одинаково: убиваем логин и создаем новый
    dsDoCommand(AcnnMain, 'exec GameClass..sp_dropuser N''' + AstrUser
        + '''');
    dsDoCommand(AcnnMain, 'exec master..sp_droplogin N''' + AstrUser
        + '''');
    nVersion := SQLServerVersion(AcnnMain);
    if nVersion = 8 then
      dsDoCommand(AcnnMain, 'exec master..sp_addlogin N''' + AstrUser
          + '''');
    if nVersion = 9 then
      dsDoCommand(AcnnMain, 'CREATE LOGIN ' + AstrUser
          +' WITH PASSWORD = '''' ,'
          + 'CHECK_POLICY = OFF, CHECK_EXPIRATION = OFF');
    // для некоторых хитрых пользователей установим пароли
    if (AstrUser = 'gcbackupoperator') then begin
      dsDoCommand(AcnnMain, 'exec master..sp_adduser '
          + '''gcbackupoperator'', ''gcbackupoperator'', '
          + '''db_backupoperator''');
      dsDoCommand(AcnnMain, 'exec master..sp_password '
          + '@new=''j4hhf6kd'', @loginame=''gcbackupoperator''');
    end else if (AstrUser = 'pm_service') then begin
      dsDoCommand(AcnnMain, 'exec GameClass.dbo.sp_adduser '
          + 'N''pm_service'', N''pm_service'', ''public''');
      dsDoCommand(AcnnMain, 'exec master.dbo.sp_password '
          + '@new=''rfnfgekmnf'', @loginame=''pm_service''');
      dsDoCommand(AcnnMain, 'use GameClass');
      dsDoCommand(AcnnMain, 'GRANT INSERT ON _pm_computers'
          + ' TO pm_service');
      dsDoCommand(AcnnMain, 'GRANT SELECT ON _pm_computers'
          + ' TO pm_service');
      dsDoCommand(AcnnMain, 'GRANT INSERT ON _pm_printers'
          + ' TO pm_service');
      dsDoCommand(AcnnMain, 'GRANT SELECT ON _pm_printers'
          + ' TO pm_service');
      dsDoCommand(AcnnMain, 'GRANT INSERT ON _pm_users TO'
          + ' pm_service');
      dsDoCommand(AcnnMain, 'GRANT SELECT ON _pm_users TO'
          + ' pm_service');
      dsDoCommand(AcnnMain, 'GRANT INSERT ON _pm_messages'
          + ' TO pm_service');
      dsDoCommand(AcnnMain, 'GRANT INSERT ON _pm_jobs TO'
          + ' pm_service');
      dsDoCommand(AcnnMain, 'GRANT EXEC ON'
          +' ServicesRunpadInsert TO pm_service');
      dsDoCommand(AcnnMain, 'use master');
    end else begin
      dsDoCommand(AcnnMain, 'exec GameClass.dbo.sp_adduser N''' + AstrUser
          + ''', N''' + AstrUser + ''', ''public''');
      Inc(i);
      lstMessages.Add('  ' + IntToStr(i) + ') ' + AstrUser);
      //Если логин имеет группу Management устнавом ему роль sysadmin
      dtsManagement := TADODataSet.Create(nil);
      dsDoQuery(AcnnMain, dtsManagement,
          'select * from GameClass.dbo.Users AS U'
          + ' inner join GameClass.dbo.UsersGroup AS UG '
          + 'on U.idUsersGroup = UG.id '
          + 'where U.Name = N''' + AstrUser
          + ''' and UG.Name=''Management''');
      if dtsManagement.Recordset.RecordCount > 0 then
        dsDoCommand(AcnnMain, 'exec master.dbo.sp_addsrvrolemember N'''
            + AstrUser + ''', ''sysadmin''');
      dtsManagement.Close;
      dtsManagement.Free;
    end;
  end;
end;

procedure RestoreSpecialUsers(const AcnnMain: TADOConnection;
    const lstMessages: TStringList);
begin
  if not LoginExists(AcnnMain, 'gcbackupoperator', lstMessages) then
      RestoreUser(AcnnMain, 'gcbackupoperator', lstMessages, True);
  if not LoginExists(AcnnMain, 'pm_service', lstMessages) then
      RestoreUser(AcnnMain, 'pm_service', lstMessages, True);
end;

function LoginExists(const AcnnMain: TADOConnection;
    const AstrLogin: String; const lstMessages: TStringList): Boolean;
var
  dts: TADODataSet;
begin
  Result := False;
  dts := TADODataSet.Create(nil);
  dsDoQuery(AcnnMain, dts,
      'SELECT name FROM syslogins WHERE name = ''' + AstrLogin + '''');
  if dts.Recordset.RecordCount = 1 then
    Result := True;
  dts.Close;
  FreeAndNil(dts);
end;

function SQLServerVersion(const AcnnMain: TADOConnection): Integer;
var
  dts: TADODataSet;
  strVersion: String;
begin
  Result := 0;
  dts := TADODataSet.Create(nil);
  dsDoQuery(AcnnMain, dts,
      'exec master..xp_msver ProductVersion');
  if dts.Recordset.RecordCount = 1 then begin
    strVersion := dts.FieldValues['Character_Value'];
    Result := StrToIntDef(LeftStr(strVersion, 1), 0);
  end;
  dts.Close;
  FreeAndNil(dts);
end;

function IsSysadmin(const AcnnMain: TADOConnection): Boolean;
var
  dts: TADODataSet;
begin
  Result := False;
  dts := TADODataSet.Create(nil);
  dsDoQuery(AcnnMain, dts,
      'SELECT ISNULL(IS_SRVROLEMEMBER (''sysadmin'') , 0) Result');
  if dts.Recordset.RecordCount = 1 then begin
    Result := (dts.FieldValues['Result'] = 1);
  end;
  dts.Close;
  FreeAndNil(dts);
end;

function GenerateUniqueBackupFileName: String;
begin
  Result := 'GCBackup-' + GenerateUniqueName + '.gcb';
end;


end.
