unit uSecurityMonitor;

interface

uses
  ADODB,
  classes;

const
  QUERY_CHECK_TABLE = 'select isnull((max(id)-min(id)+1),0) CalcCount, '
      + 'count(id) RealCount from ';
  QUERY_CHECK_NULL_TIME = 'select '
      + '(select count(*) from Sessions where [started] is null) +'
      + '(select count(*) from SessionsAdd where [Start] is null) +'
      + '(select count(*) from SessionsAdd2 where [moment] is null) +'
      + '(select count(*) from Logs where [moment] is null) as [RecordCount]';
  QUERY_CHECK_GCREMOVER = 'select DetectedMoment from gcrem where '
      + 'DetectedMoment is not null order by DetectedMoment DESC';
  QUERY_EXPIRED_GCREMOVER = 'UPDATE dbo.gcrem Set DetectedMoment = moment '
      + 'where moment <> ''01 jan 1900 0:00:00'''
      + ' UPDATE dbo.gcrem Set moment=''01 jan 1900 0:00:00''';
  QUERY_CHECK_LOGINS = 'EXEC sp_helplogins';
  QUERY_CHECK_NTUSERS = 'EXEC master..xp_logininfo';
  QUERY_CHECK_SERVERROLES = 'EXEC sp_helpsrvrolemember';
  QUERY_CHECK_DBROLES = 'EXEC sp_helprolemember';
  QUERY_CHECK_ACCESS = 'EXEC sp_helprotect';
  QUERY_CHECK_SPECIAL_REPORTS = 'SELECT [id] FROM Reports'
      + ' WHERE dbo.IsSpecialReport([id]) = 1';
  LEAGAL_ACCESS_LIST = '"pm_service" _pm_computers Insert' + Chr(13) + Chr(10)
      + '"pm_service" _pm_computers Select' + Chr(13) + Chr(10)
      + '"pm_service" _pm_jobs Insert' + Chr(13) + Chr(10)
      + '"pm_service" _pm_messages Insert' + Chr(13) + Chr(10)
      + '"pm_service" _pm_printers Insert' + Chr(13) + Chr(10)
      + '"pm_service" _pm_printers Select' + Chr(13) + Chr(10)
      + '"pm_service" _pm_users Insert' + Chr(13) + Chr(10)
      + '"pm_service" _pm_users Select' + Chr(13) + Chr(10)
      + '"public" AccountsDiscountsSelect Execute' + Chr(13) + Chr(10)
      + '"public" AccountsHistorySelect Execute' + Chr(13) + Chr(10)
      + '"public" AccountsMoneyPay Execute' + Chr(13) + Chr(10)
      + '"public" AccountsInsert Execute' + Chr(13) + Chr(10)
      + '"public" AccountsNew Execute' + Chr(13) + Chr(10)
      + '"public" AccountsSelect Execute' + Chr(13) + Chr(10)
      + '"public" AccountsUnblock Execute' + Chr(13) + Chr(10)
      + '"public" AccountsUpdate Execute' + Chr(13) + Chr(10)
      + '"public" AccountsUpdateCodes Execute' + Chr(13) + Chr(10)
      + '"public" AccountsUpdatePhoto Execute' + Chr(13) + Chr(10)
      + '"public" AutoUpadateSelect Execute' + Chr(13) + Chr(10)
      + '"public" AutoUpadateSelectLastId Execute' + Chr(13) + Chr(10)
      + '"public" IsManager Execute' + Chr(13) + Chr(10)
      + '"public" PMJobsSelect Execute' + Chr(13) + Chr(10)
      + '"public" PMJobsSelectUnprocessed Execute' + Chr(13) + Chr(10)
      + '"public" RegestrySelectByKey Execute' + Chr(13) + Chr(10)
      + '"public" RegestryUpdate Execute' + Chr(13) + Chr(10)
      + '"public" Users Select' + Chr(13) + Chr(10)
      + '"public" ComputerGroupsSelect Execute' + Chr(13) + Chr(10)
      + '"public" ComputersSelect Execute' + Chr(13) + Chr(10)
      + '"public" FunctionsSelect Execute' + Chr(13) + Chr(10)
      + '"public" GetLogonInfo Execute' + Chr(13) + Chr(10)
      + '"public" GroupsSelect Execute' + Chr(13) + Chr(10)
      + '"public" HardwareInsert Execute' + Chr(13) + Chr(10)
      + '"public" HardwareSelect Execute' + Chr(13) + Chr(10)
      + '"public" LogsInsert Execute' + Chr(13) + Chr(10)
      + '"public" MappingsAdd Execute' + Chr(13) + Chr(10)
      + '"public" MappingsDelete Execute' + Chr(13) + Chr(10)
      + '"public" MappingsSelect Execute' + Chr(13) + Chr(10)
      + '"pm_service" old_errors Insert' + Chr(13) + Chr(10)
      + '"pm_service" old_information Insert' + Chr(13) + Chr(10)
      + '"pm_service" old_jobs Insert' + Chr(13) + Chr(10)
      + '"pm_service" old_warnings Insert' + Chr(13) + Chr(10)
      + '"public" OnInitDatabase Execute' + Chr(13) + Chr(10)
      + '"public" PrinterScan Execute' + Chr(13) + Chr(10)
      + '"public" RegistryInsert Execute' + Chr(13) + Chr(10)
      + '"public" RegistrySelect Execute' + Chr(13) + Chr(10)
      + '"public" ReportCurrent Execute' + Chr(13) + Chr(10)
      + '"public" ReportCurrentInsert Execute' + Chr(13) + Chr(10)
      + '"public" RightsSelect Execute' + Chr(13) + Chr(10)
      + '"public" secChangePass Execute' + Chr(13) + Chr(10)
      + '"public" ServicesBaseAdd Execute' + Chr(13) + Chr(10)
      + '"public" ServicesBaseSelect Execute' + Chr(13) + Chr(10)
      + '"public" ServiceToSell Execute' + Chr(13) + Chr(10)
      + '"public" SessionsAddMoney Execute' + Chr(13) + Chr(10)
      + '"public" SessionsChangeTariff Execute' + Chr(13) + Chr(10)
      + '"public" SessionsMoveComps Execute' + Chr(13) + Chr(10)
      + '"public" SessionsReadUncontrolState Execute' + Chr(13) + Chr(10)
      + '"public" SessionsSave Execute' + Chr(13) + Chr(10)
      + '"public" SessionsSelect Execute' + Chr(13) + Chr(10)
      + '"public" SessionsStopIt Execute' + Chr(13) + Chr(10)
      + '"public" SessionsTrafficPayment Execute' + Chr(13) + Chr(10)
      + '"public" SessionsUpdate Execute' + Chr(13) + Chr(10)
      + '"public" SessionsUpdatePenalty Execute' + Chr(13) + Chr(10)
      + '"public" spgc_Computers Execute' + Chr(13) + Chr(10)
      + '"public" spgc_Operators Execute' + Chr(13) + Chr(10)
      + '"public" spgc_repDetails Execute' + Chr(13) + Chr(10)
      + '"public" spgc_repGeneral Execute' + Chr(13) + Chr(10)
      + '"public" spgc_repJournalOp Execute' + Chr(13) + Chr(10)
      + '"public" spgc_repLogs Execute' + Chr(13) + Chr(10)
      + '"public" spgc_repRepair Execute' + Chr(13) + Chr(10)
      + '"public" spgc_repServices Execute' + Chr(13) + Chr(10)
      + '"public" spgc_repUncontrol Execute' + Chr(13) + Chr(10)
      + '"public" spgc_repUncontrolClub Execute' + Chr(13) + Chr(10)
      + '"public" syscolumns Select' + Chr(13) + Chr(10)
      + '"public" syscomments Select' + Chr(13) + Chr(10)
      + '"public" sysconstraints Select' + Chr(13) + Chr(10)
      + '"public" sysdepends Select' + Chr(13) + Chr(10)
      + '"public" sysfilegroups Select' + Chr(13) + Chr(10)
      + '"public" sysfiles Select' + Chr(13) + Chr(10)
      + '"public" sysforeignkeys Select' + Chr(13) + Chr(10)
      + '"public" sysfulltextcatalogs Select' + Chr(13) + Chr(10)
      + '"public" sysindexes Select' + Chr(13) + Chr(10)
      + '"public" sysindexkeys Select' + Chr(13) + Chr(10)
      + '"public" sysmembers Select' + Chr(13) + Chr(10)
      + '"public" sysobjects Select' + Chr(13) + Chr(10)
      + '"public" syspermissions Select' + Chr(13) + Chr(10)
      + '"public" sysprotects Select' + Chr(13) + Chr(10)
      + '"public" sysreferences Select' + Chr(13) + Chr(10)
      + '"public" syssegments Select' + Chr(13) + Chr(10)
      + '"public" systypes Select' + Chr(13) + Chr(10)
      + '"public" sysusers Select' + Chr(13) + Chr(10)
      + '"public" TarifsSelect Execute' + Chr(13) + Chr(10)
      + '"public" TarifsVariantsSelect Execute' + Chr(13) + Chr(10)
      + '"public" UnControlClubStart Execute' + Chr(13) + Chr(10)
      + '"public" UnControlClubTimer Execute' + Chr(13) + Chr(10)
      + '"public" UnControlCompStart Execute' + Chr(13) + Chr(10)
      + '"public" UnControlCompTimer Execute' + Chr(13) + Chr(10)
      + '"public" UsageDateSelect Execute' + Chr(13) + Chr(10)
      + '"public" UsersCreate Execute' + Chr(13) + Chr(10)
      + '"public" UsersDelete Execute' + Chr(13) + Chr(10)
      + '"public" UsersSelect Execute' + Chr(13) + Chr(10)
      + '"public" ProcessAdd Execute' + Chr(13) + Chr(10)
      + '"public" AutoUpdateSelect Execute' + Chr(13) + Chr(10)
      + '"public" AutoUpdateSelectLastId Execute' + Chr(13) + Chr(10)
      + '"public" RegistrySelectByKey Execute' + Chr(13) + Chr(10)
      + '"public" RegistryUpdate Execute' + Chr(13) + Chr(10)
      + '"public" CheckFunctionsRight Execute' + Chr(13) + Chr(10)
      + '"public" CustomReportColumnsSelect Execute' + Chr(13) + Chr(10)
      + '"public" CustomReportsSelect Execute' + Chr(13) + Chr(10)
      + '"public" GetCustomReportParentId Execute' + Chr(13) + Chr(10)
      + '"public" GetFreeCheckAccountsName Execute' + Chr(13) + Chr(10)
      + '"public" GetLastOperatorName Execute' + Chr(13) + Chr(10)
      + '"public" GetUserGroup Execute' + Chr(13) + Chr(10)
      + '"public" GetUserGroupName Execute' + Chr(13) + Chr(10)
      + '"public" SessionsInsert Execute' + Chr(13) + Chr(10)
      + '"public" SessionsStop Execute' + Chr(13) + Chr(10)
      + '"public" SessionsUpdateTimeCost Execute' + Chr(13) + Chr(10);

  LEAGAL_SPECIAL_REPORT = '"public" CustomReport%dExecute Execute';

  QUERY_CHANGE_SAPASSWD = 'declare @pass sysname set @pass=CAST(newid()'
      + ' AS sysname) exec master.dbo.sp_password NULL, @pass, ''sa''';


  function CheckRecordsQuantityInTable(const AstrTableName: String;
      var AstrResult: String): Boolean;
  function CheckLogins(var AlstResult: TStringList): Boolean;
  function CheckSecurity(var AlstResult: TStringList): Boolean;
  procedure ChangeSaPassword;

var
 GbEnemyDetected: boolean; // устанавливается в true, если были удаления в табл.

implementation

uses
  SysUtils,
  Registry,
  Windows,
  gccommon,
  gcconst;


// функция с помощью SQL-запроса получает количество записей, которые должны
// быть и реальное количество и делает выводы.
// используется стандартный SQL-запрос
// select
//  (max(id)-min(id)+1) 'mustbe',
//  count(id) 'really'
// from TABLE
function CheckRecordsQuantityInTable(const AstrTableName: String;
    var AstrResult: String): Boolean;
var
  strQuery: String;
  dts: TADODataSet;
  nCalcCount: Integer;
  nRealCount: Integer;
//  bResult: Boolean;
begin
  Result := False;
  strQuery := QUERY_CHECK_TABLE + AstrTableName;
  dts := TADODataSet.Create(nil);
  dsDoQuery(strQuery, @dts);
  nCalcCount := dts.Recordset.Fields.Item['CalcCount'].Value;
  nRealCount := dts.Recordset.Fields.Item['RealCount'].Value;
  AstrResult := 'Таблица ['+AstrTableName+'], '+IntToStr(nCalcCount)+' записей.';
  if (nCalcCount = nRealCount) then begin
    Result := True;
    AstrResult := AstrResult + ' Все нормально.';
    exit;
  end;
  AstrResult := AstrResult + ' !!! Удалено '+IntToStr(nCalcCount-nRealCount)
      + ' записей';
end; // CheckRecordsQuantityInTable

function CheckLogins(var AlstResult: TStringList): Boolean;
var
  dts: TADODataSet;
  nCalcCount: Integer;
//  nRealCount: Integer;
//  bResult: Boolean;
  strTemp: String;
  strLoginName: String;
  lstUsers: TStringList;
  bAdmin: Boolean;
begin
  Result := True;
  lstUsers := TStringList.Create;
  dts := TADODataSet.Create(nil);
  // Получаем всех пользователей GC
  dsDoQuery(DS_USERS_SELECT, @dts);
  while (not dts.Recordset.EOF) do begin
    strLoginName := dts.Recordset.Fields.Item['name'].Value;
    strTemp := dts.Recordset.Fields.Item['group'].Value;
    bAdmin := (strTemp = 'Management');
    lstUsers.AddObject(strLoginName,TObject(bAdmin));
    dts.Recordset.MoveNext;
  end;
  dts.Close;
  lstUsers.AddObject('sa', TObject(True));
  lstUsers.AddObject('BUILTIN\Администраторы', TObject(True));
  lstUsers.AddObject('BUILTIN\Administrators', TObject(True));
  lstUsers.AddObject('gcbackupoperator', TObject(False));
  lstUsers.AddObject('pm_service', TObject(False));
  // Проверяем все ли логины MSSQL есть в GC
  dsDoQuery(QUERY_CHECK_LOGINS, @dts);
  while (not dts.Eof) do begin
    strLoginName := dts.Recordset.Fields.Item['LoginName'].Value;
    if lstUsers.IndexOf(strLoginName)=-1 then begin
      Result := False;
      AlstResult.Add('Незарегистрированный в GameClass логин "' + strLoginName
          +'"!');
    end;
    dts.Next;
  end;
  dts.Close;
  // Проверяем отключенность NT-логинов MSSQL
  dsDoQuery(QUERY_CHECK_NTUSERS, @dts);
  while (not dts.Eof) do begin
    strLoginName := dts.Recordset.Fields.Item['account name'].Value;
    Result := False;
    AlstResult.Add('Аккаунт "' + strLoginName
        + '" должен быть отключен!');
    dts.Next;
  end;
  dts.Close;
  // Проверяем совпадение прав sysadmins c группой Management
  dsDoQuery(QUERY_CHECK_SERVERROLES, @dts);
  while (not dts.Eof) do begin
    strLoginName := dts.Recordset.Fields.Item['MemberName'].Value;
    if (lstUsers.IndexOf(strLoginName) = -1) then begin
      Result := False;
      AlstResult.Add('Права администратора у логина "' + strLoginName
          +'"!');
    end else if not Boolean(lstUsers.Objects[lstUsers.IndexOf(strLoginName)])
          then begin
        Result := False;
        AlstResult.Add('У пользоватея "'+strLoginName
            + '" есть права администратора!');
      end;
    dts.Next;
  end;
  dts.Close;
  // Проверяем отсутствие ролей у пользователей
  dsDoQuery(QUERY_CHECK_DBROLES, @dts);
  while (not dts.Eof) do begin
    strLoginName := dts.Recordset.Fields.Item['MemberName'].Value;
    if (strLoginName <> 'dbo')
        and (strLoginName <> 'gcbackupoperator') then begin
      Result := False;
      AlstResult.Add('Запрещенная роль у пользователя "' + strLoginName
          +'"!');
    end;
    dts.Next;
  end;
  dts.Close;
  // Проверяем отсутствие прав у пользователей
  lstUsers.Clear;
  lstUsers.Text := LEAGAL_ACCESS_LIST;
  dsDoQuery(QUERY_CHECK_SPECIAL_REPORTS, @dts);
  while (not dts.Eof) do begin
    nCalcCount := dts.FieldValues['id'];
    lstUsers.Add(Format(LEAGAL_SPECIAL_REPORT,
        [nCalcCount]));
    dts.Next;
  end;
  dts.Close;

  dsDoQuery(QUERY_CHECK_ACCESS, @dts);
  while (not dts.Eof) do begin
    strLoginName := '"'+ dts.Recordset.Fields.Item['Grantee'].Value
        + '" ' + dts.Recordset.Fields.Item['Object'].Value
        + ' ' + dts.Recordset.Fields.Item['Action'].Value;
    if (lstUsers.IndexOf(strLoginName) = -1) then begin
      Result := False;
      AlstResult.Add('Запрещенные права у пользователя ' + strLoginName
          + '"!');
    end;
    dts.Next;
  end;
  dts.Close;
  dts.Free;
end; // CheckRecordsQuantityInTable

procedure ChangeSaPassword;
begin
  dsDoCommandSQLQuery(QUERY_CHANGE_SAPASSWD);
end;

function CheckNullTime(var AstrResult: String): Boolean;
var
  strQuery: String;
  dts: TADODataSet;
  nRecordCount: Integer;
//  bResult: Boolean;
begin
  Result := False;
  strQuery := QUERY_CHECK_NULL_TIME;
  dts := TADODataSet.Create(nil);
  dsDoQuery(strQuery, @dts);
  nRecordCount := dts.Recordset.Fields.Item['RecordCount'].Value;
  AstrResult := 'В таблицах сессий и логов у '+IntToStr(nRecordCount)
      +' записей обнулена дата.';
  if (nRecordCount = 0) then begin
    Result := True;
    AstrResult := AstrResult + ' Все нормально.';
    exit;
  end;
end; // CheckNullTime

function CheckGCRemover(var AstrResult: String): Boolean;
var
//  strQuery: String;
  dts: TADODataSet;
  dtDetectedMoment: TDateTime;
//  bResult: Boolean;
begin
  Result := False;
  dsDoCommandSQLQuery(QUERY_EXPIRED_GCREMOVER);
  dts := TADODataSet.Create(nil);
  dsDoQuery(QUERY_CHECK_GCREMOVER, @dts);
  if (dts.RecordCount > 0) then begin
    dtDetectedMoment := dts.Recordset.Fields.Item['DetectedMoment'].Value;
    AstrResult := 'Обнаружена программа GCRemover: установлена '
        + DateTimeToStr(dtDetectedMoment)
        +' СМЕНИТЕ ПАРОЛЬ МЕНЕДЖЕРА!!!';
  end else
    Result := True;
end; // CheckRecordsQuantityInTable

function CheckSecurity(var AlstResult: TStringList): Boolean;
var
  strResult: String;
begin
  Result := True;
  AlstResult.Clear;
  AlstResult.Add('Нарушение безопасности на сервере MS SQL!!!');
  AlstResult.Add('');
  if not CheckRecordsQuantityInTable('Logs', strResult) then begin
    Result := False;
    AlstResult.Add(strResult);
  end;
  if not CheckRecordsQuantityInTable('Sessions', strResult) then begin
    Result := False;
    AlstResult.Add(strResult);
  end;
  if not CheckRecordsQuantityInTable('SessionsAdd', strResult) then begin
    Result := False;
    AlstResult.Add(strResult);
  end;
  if not CheckRecordsQuantityInTable('SessionsAdd2', strResult) then begin
    Result := False;
    AlstResult.Add(strResult);
  end;
  if not CheckNullTime(strResult) then begin
    Result := False;
    AlstResult.Add(strResult);
  end;
  if not CheckGCRemover(strResult) then begin
    Result := False;
    AlstResult.Add(strResult);
  end;
  if not CheckLogins(AlstResult) then
    Result := False;
  ChangeSaPassword;
end;


end.
