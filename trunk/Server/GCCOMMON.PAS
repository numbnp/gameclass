unit gccommon;

interface

uses
  GCConst, frmGCMessageBox, StrUtils,
  DB, ADODB, SysUtils, ShellAPI;

type
  PTADODataSet = ^TADODataSet;
  PTDateTime = ^TDateTime;
  PTDouble = ^double;
  pstring = ^string;

// app version
function GetAppVersion:string;

//вызова файла справки с нужным контекстом
procedure GCHelp(const AstrArticle: String);

procedure dsLoadLogonInfo;

// BaseRegistry functions
//procedure dsRegistrySave(param:string; value:string);
//function dsRegistryLoad(param:string; default: string):string;

// обработчик ошибок
function ProcessLastError:string;

// misc
function BoolToStr01(b_in: boolean):string;
function StrToFloatGC(str: string):double;
function FloatToStrGC(value: double):string;
function GetShortWeekDay(day: integer):string;

//ведение логов
procedure CheckDebugLogging; // проверяет установлен ли HKEY_LOCAL_MACHINE\SOFTWARE\GameClass3\Debug=1

// другие полезные функции, смысл которых понятен из названия
procedure dsSendOptionsToClients;
function dsConnected:boolean;
procedure dsDoQuery(str: string; pdts: PTADODataSet);
function  dsDoCommand(str: string):boolean; overload;
function  dsDoCommand(str: string; AnTimeOut: Integer):boolean; overload;
procedure dsDoCommandChangePass(str: string);
procedure dsDoCommandSQLQuery(str: string);
procedure dsLoadOptions;
procedure dsClearStatistics;
procedure dsLoadFunctionsRights;
procedure dsLoadComputers;
procedure dsLoadComputerGroups;
procedure dsUnloadComputers;
procedure dsLoadTarifs;
procedure dsUnloadTarifs;
procedure dsLoadUncontrolComputers;
//function dsGetCurrentShiftTotal(totalTime, totalService, totalTraffic, totalPrinted: PTDouble; LastShift: PTDateTime):double;
function dsGetCurrentShiftTotal(var AfTime, AfService, AfTraffic, AfPrinted,
    AfAccountsAdded, AfAccountsPayed, AfAccountsReturned: Double;
    var AdtLastShift: TDateTime): Double;
function dsGetCurrentShiftRest:double;
procedure dsCloseCurrentShift(money: double; moment: TDateTime; comment: string);
// computers
procedure dsCompsMove(indexComp1: integer; indexComp2:integer);
// control
procedure dsControlClubStart;
procedure dsControlClubTimer;
procedure dsControlCompStart(idComp: integer);
procedure dsControlCompTimer(idComp: integer);
// new DataBase methods
procedure DBCreateAndOpenQuery(const AstrSQLCode: String;
    var AADOQuery: TADOQuery);
// time functions
function DateTimeToSql(t: TDateTime):string;
function dsGet3LastOpReportPoints(Last1,Last2,Last3,Last4:PTDateTime):string;
function DateTimeToTimeString(AdtTime: TDateTime; AbShowSeconds: Boolean): String;

function dsGetVarBySqlQuery(Query: string):string;

//ф-ии состояния клуба в HTML
procedure GenerateClubInfoName;
procedure GenerateClubInfoState;

{// работа с триалом
function dsCompareTrials:Boolean;
procedure ShowTrialWarning;}

procedure dsProcessAdd(const AbProcessStarted: Boolean;
    const AnIdComputer: Integer;
    const AstrExeFile: String);

function dsGetBaseVersion: String;

function GetOperatorTraffic: Cardinal;


implementation

Uses
  GCLangutils,
  GCFunctions,
  GCComputers,
  uProtocol,
  GCSystem,
  Dialogs,
  frmMain,
  Windows,
  forms,
  ComCtrls,
  ADOInt,
  DateUtils,
  classes,
  Math,
  GCSessions,
  Registry,
  uSystemRegistryTools,
  frmTrial,
  uVirtualTime,
  uRegistry,
  uRegistryPrinter,
  uY2KString,
  uSQLTools,
  uRegistryInternet,
  udmActions,
  udmMain,
  uTariffication,
  uRegistration,
  uDebugLog,
  comobj,
  uGCSidelines;

// errors
function ProcessLastError:string;
var
  sError: string;
begin
  sError := SysErrorMessage(GetLastError);
  Console.AddEvent(EVENT_ICON_ERROR, LEVEL_ERROR,sError);
  ProcessLastError := sError;
end;

// функция возвращает состояние коннекта
function dsConnected:boolean;
begin
  if (dmMain.cnnMain = nil) then begin
    Result := false;
    exit;
  end;
  dsConnected := dmMain.cnnMain.Connected;
end;

procedure dsLoadOptions;
begin
  if (dsConnected) then
  begin
//    Options.Load;
    Sideline.Load;
  end;
end;

procedure dsLoadLogonInfo;
var
  dts: TADODataSet;
  tm: TDateTime;
begin
  if (dsConnected) then
  begin
    dts := TADODataSet.Create(nil);
    dsDoQuery(DS_GET_LOGONINFO, @dts);
    if (not dts.Recordset.EOF) then
    begin
      isManager := (dts.Recordset.Fields.Item['isManager'].Value = 1);
      tm := dts.Recordset.Fields.Item['Date'].Value;
      SetVirtualTime(tm);
      IntTimeShiftReset := IntTimeShift;
    end;
    dts.Close;
    dts.Destroy;
  end;
end;

procedure dsLoadFunctionsRights;
var
  dts: TADODataSet;
  i: integer;
begin
  if (dsConnected) then
  begin
    dts := TADODataSet.Create(nil);
    dsDoQuery(DS_FUNCTIONS_SELECT, @dts);

    // сотрем все функции
    FunctionRightClear;
    i :=  dts.Recordset.RecordCount;
    while (not dts.Recordset.EOF) do
    begin
      FunctionRightYes(dts.Recordset.Fields.Item['name'].Value);
      dts.Recordset.MoveNext;
    end;
    dts.Close;
    dts.Destroy;
    if (StrLen(Registration.UserName) = 0) then begin
      FunctionEnable(FN_CLEAR_STATISTICS, false);
    end;
    if (StrLen(Registration.UserName) = 0) and ((Registration.TrialDaysLeft=0) or (Registration.TrialExLeft=0)) then
    begin
      FunctionEnable(FN_CURRENT_REPORT,false);
      FunctionEnable(FN_CLOSE_SHIFT,false);
      Console.AddEvent(EVENT_ICON_MAIL, LEVEL_2, translate('TrialEnd'));
    end;
    Console.AddEvent(EVENT_ICON_EMPTY, LEVEL_2, translate('dsLoadFunctions')+' ['+IntToStr(i)+']');
    DoInterface;
    DoInterfaceComps;
  end;
end;

procedure dsLoadComputers;
var
  dts: TADODataSet;
  i: integer;
  str: string;
  bLimit: boolean;
begin
  if (dsConnected) then
  begin
    bLimit := False;
    dts := TADODataSet.Create(nil);
    dsDoQuery(DS_COMPUTERS_SELECT + ' @idGroup=-1', @dts);
    CompsCount := dts.Recordset.RecordCount;
    if (CompsCount>Registration.CompsRegs) then
    begin
      //info проверка на регистрацию
      str := translate('WarningLimitComps')+IntToStr(Registration.CompsRegs)+' '+translate('computers') + '. ' + translate('WarningLimitComps2');
      Console.AddEvent(EVENT_ICON_WARNING, LEVEL_0, str);
      CompsCount := Registration.CompsRegs;
      bLimit := True;
    end;
    if (CompsCount>MAX_COMPUTERS) then
    begin
      //info проверка максимально возможное кол-во компов
      str := translate('WarningLimitComps3')+IntToStr(MAX_COMPUTERS);
      Console.AddEvent(EVENT_ICON_WARNING, LEVEL_0, str);
      CompsCount := MAX_COMPUTERS;
      bLimit := True;
    end;
    i := 0;
    while (CompsCount > 0) and (not dts.Recordset.EOF)
      and (i<Registration.CompsRegs)
      and (i<MAX_COMPUTERS) do
    begin
      Comps[i] := TComputer.Create;
      Comps[i].id := dts.Recordset.Fields.Item['id'].Value;
      Comps[i].number := dts.Recordset.Fields.Item['number'].Value;
      Comps[i].ipaddr := dts.Recordset.Fields.Item['ipaddress'].Value;
      Comps[i].IdGroup := dts.Recordset.Fields.Item['idGroup'].Value;
      Comps[i].macaddr  := dts.Recordset.Fields.Item['macaddress'].Value;
      Comps[i].GroupName := ComputerGroupsGetName(Comps[i].IdGroup);
      Comps[i].SNMP_Password := dts.Recordset.Fields.Item['snmp_password'].Value;
      Comps[i].SNMP_MIB_Port := dts.Recordset.Fields.Item['snmp_mib_ports'].Value;
      Comps[i].IgnoreOffline := dts.Recordset.Fields.Item['ignore_offline'].Value;
      Comps[i].ClientType := dts.Recordset.Fields.Item['client_type'].Value;
      i := i + 1;
      dts.Recordset.MoveNext;
    end;
    dts.Close;
    dts.Destroy;
    Console.AddEvent(EVENT_ICON_EMPTY, LEVEL_2, translate('dsLoadComputersOk')+' ['+IntToStr(CompsCount)+']');
    if bLimit then
      MessageBox(HWND_TOP,PChar(str),PChar(translate('lblReadThis')),MB_OK or MB_ICONEXCLAMATION);
  end;
end;

procedure dsLoadComputerGroups;
var
  dts: TADODataSet;
  i: integer;
  str: string;
begin
  if (dsConnected) then
  begin
    dts := TADODataSet.Create(nil);
    dsDoQuery(DS_COMPUTERGROUPS_SELECT, @dts);
    CompGroupsCount := dts.Recordset.RecordCount;
    i := 0;
    while (CompGroupsCount > 0) and (not dts.Recordset.EOF) do
    begin
      CompGroups[i] := TComputerGroup.Create;
      CompGroups[i].Id := dts.Recordset.Fields.Item['id'].Value;
      CompGroups[i].Name := dts.Recordset.Fields.Item['name'].Value;
      i := i + 1;
      dts.Recordset.MoveNext;
    end;
    dts.Close;
    dts.Destroy;
    Console.AddEvent(EVENT_ICON_EMPTY, LEVEL_2, translate('dsLoadComputerGroupsOk')+' ['+IntToStr(CompGroupsCount)+']');
  end;
end;

procedure dsUnloadComputers;
var
  i: integer;
begin
  for i:=1 to CompsCount do
  begin
    Comps[i-1].Destroy;
  end;
  CompsCount := 0;
  CompsSelCount := 0;
end;

procedure dsUnloadTarifs;
var
  i: integer;
begin
  for i:=1 to TarifsCount do
  begin
    Tarifs[i-1].Destroy;
  end;
  TarifsCount := 0;
end;

procedure dsLoadTarifs;
var
  dts,dts2: TADODataSet;
  i: integer;
  bFirstNonPacketTarifVariant: Boolean; //извраты!!! и все ради дублирования отдельной оплаты
  bTrafficSeparatePayment: Boolean; //см.выше
begin
  if (dsConnected) then
  begin
    TarifsCount := 1;
    Tarifs[0] := TTarif.Create;
    Tarifs[0].id := 0;
    Tarifs[0].name := translate('subRemont');
    Tarifs[0].internet := IfThen(GRegistry.Options.EnableInternetRemont,
        Integer(1), Integer(0));
    Tarifs[0].calctraffic := 0;
    Tarifs[0].roundtime := 1;
    Tarifs[0].roundmoney := 1;
    Tarifs[0].hourcost := 0;
    Tarifs[0].BytesInMB := 1048576;
    Tarifs[0].SpeedLimitInKB := 0;
    Tarifs[0].PluginGroupName := '';
    Tarifs[0].userlevel:=0;
    Tarifs[0].operatorlevel:=0;
    Tarifs[0].variantscount := 1;
    Tarifs[0].tarifvariants[0] := TTarifVariants.Create;
    Tarifs[0].tarifvariants[0].id := 0;
    Tarifs[0].tarifvariants[0].idTarif := 0;
    Tarifs[0].tarifvariants[0].name := 'default';
    Tarifs[0].tarifvariants[0].start := EncodeTime(0,0,0,0);
    Tarifs[0].tarifvariants[0].stop := EncodeTime(0,0,0,0);
    Tarifs[0].tarifvariants[0].cost := 0;
    Tarifs[0].tarifvariants[0].ispacket := False;
    Tarifs[0].tarifvariants[0].daysofweek := '1234567';
    Tarifs[0].tarifvariants[0].bCondition := False;
    Tarifs[0].tarifvariants[0].TrafficLimit := 0;
    Tarifs[0].tarifvariants[0].TrafficCost := 0;
    Tarifs[0].tarifvariants[0].TrafficSeparatePayment := False;
    Tarifs[0].tarifvariants[0].FreePacket := False;
    Tarifs[0].tarifvariants[0].ConditionType := '';
    Tarifs[0].tarifvariants[0].ConditionValue := 0;

    dts := TADODataSet.Create(nil);
    dsDoQuery(DS_TARIFS_SELECT+ ' @idGroup=-1', @dts);
    TarifsCount := dts.Recordset.RecordCount + 1;
    i := 1;
    while (TarifsCount > 1) and (not dts.Recordset.EOF) do
    begin
      Tarifs[i] := TTarif.Create;
      Tarifs[i].id := dts.Recordset.Fields.Item['id'].Value;
      Tarifs[i].name := dts.Recordset.Fields.Item['name'].Value;
      Tarifs[i].internet := dts.Recordset.Fields.Item['internet'].Value;
      Tarifs[i].calctraffic := dts.Recordset.Fields.Item['calctraffic'].Value;
      Tarifs[i].roundtime := dts.Recordset.Fields.Item['roundtime'].Value;
      Tarifs[i].roundmoney := dts.Recordset.Fields.Item['roundmoney'].Value;
      Tarifs[i].idGroup := dts.Recordset.Fields.Item['idGroup'].Value;
      Tarifs[i].BytesInMB := dts.Recordset.Fields.Item['BytesInMB'].Value;
      Tarifs[i].SpeedLimitInKB := dts.Recordset.Fields.Item['SpeedLimitInKB'].Value;
      Tarifs[i].PluginGroupName := dts.Recordset.Fields.Item['PluginGroupName'].Value;
      Tarifs[i].userlevel := dts.Recordset.Fields.Item['userlevel'].Value;
      Tarifs[i].operatorlevel := dts.Recordset.Fields.Item['operatorlevel'].Value;
      Tarifs[i].useseparatesumm  := dts.Recordset.Fields.Item['useseparatesumm'].Value;
      Tarifs[i].startmoneymin := dts.Recordset.Fields.Item['startmoneymin'].Value;
      Tarifs[i].startmoneymax := dts.Recordset.Fields.Item['startmoneymax'].Value;
      Tarifs[i].addmoneymin := dts.Recordset.Fields.Item['addmoneymin'].Value;
      Tarifs[i].addmoneymax := dts.Recordset.Fields.Item['addmoneymax'].Value;
      Tarifs[i].maximumtrust := dts.Recordset.Fields.Item['maximumtrust'].Value;

      // подгрузим цельные интервалы TarifsWhole
      Tarifs[i].variantscount := 0;
      dts2 := TADODataSet.Create(nil);
      dsDoQuery(DS_TARIFSVARIANTS_SELECT + ' @idTarifs='+IntToStr(Tarifs[i].id), @dts2);
      bFirstNonPacketTarifVariant := True;
      bTrafficSeparatePayment := False;
      while (dts2.Recordset.RecordCount > 0) and (not dts2.Recordset.EOF) do
      begin
        Tarifs[i].tarifvariants[Tarifs[i].variantscount] := TTarifVariants.Create;
        Tarifs[i].tarifvariants[Tarifs[i].variantscount].id := dts2.Recordset.Fields.Item['id'].Value;
        Tarifs[i].tarifvariants[Tarifs[i].variantscount].idTarif := Tarifs[i].id;
        Tarifs[i].tarifvariants[Tarifs[i].variantscount].name := dts2.Recordset.Fields.Item['name'].Value;
        Tarifs[i].tarifvariants[Tarifs[i].variantscount].start := dts2.Recordset.Fields.Item['start'].Value;
        Tarifs[i].tarifvariants[Tarifs[i].variantscount].stop := dts2.Recordset.Fields.Item['stop'].Value;
        Tarifs[i].tarifvariants[Tarifs[i].variantscount].cost := dts2.Recordset.Fields.Item['cost'].Value;
        Tarifs[i].tarifvariants[Tarifs[i].variantscount].ispacket := (dts2.Recordset.Fields.Item['ispacket'].Value = 1);
        Tarifs[i].tarifvariants[Tarifs[i].variantscount].daysofweek := dts2.Recordset.Fields.Item['daysofweek'].Value;
        Tarifs[i].tarifvariants[Tarifs[i].variantscount].bCondition := (dts2.Recordset.Fields.Item['condition'].Value <> '');
        Tarifs[i].tarifvariants[Tarifs[i].variantscount].TrafficLimit := dts2.Recordset.Fields.Item['TrafficLimit'].Value;
        Tarifs[i].tarifvariants[Tarifs[i].variantscount].TrafficCost := dts2.Recordset.Fields.Item['TrafficCost'].Value;
        Tarifs[i].tarifvariants[Tarifs[i].variantscount].TrafficSeparatePayment := dts2.Recordset.Fields.Item['TrafficSeparatePayment'].Value;
        Tarifs[i].tarifvariants[Tarifs[i].variantscount].FreePacket := dts2.Recordset.Fields.Item['FreePacket'].Value;
        if not Tarifs[i].tarifvariants[Tarifs[i].variantscount].ispacket then begin
          if bFirstNonPacketTarifVariant then begin
            bFirstNonPacketTarifVariant := False;
            bTrafficSeparatePayment := Tarifs[i].tarifvariants[Tarifs[i].variantscount].TrafficSeparatePayment;
          end
          else
            Tarifs[i].tarifvariants[Tarifs[i].variantscount].TrafficSeparatePayment := bTrafficSeparatePayment;
        end
        else
          //все пакетные тарифы с отдельной оплатой траффа
          Tarifs[i].tarifvariants[Tarifs[i].variantscount].TrafficSeparatePayment := True;
        if (Tarifs[i].tarifvariants[Tarifs[i].variantscount].bCondition) then
        begin
          Tarifs[i].tarifvariants[Tarifs[i].variantscount].ConditionType := GetParamFromString(dts2.Recordset.Fields.Item['condition'].Value,0);
          Tarifs[i].tarifvariants[Tarifs[i].variantscount].ConditionValue := StrToIntDef(GetParamFromString(dts2.Recordset.Fields.Item['condition'].Value,1),60);
        end;

        dts2.Recordset.MoveNext;
        Tarifs[i].variantscount := Tarifs[i].variantscount + 1;
      end;
      dts2.Close;
      dts2.Destroy;
      
      
      dts.Recordset.MoveNext;
      i := i + 1;      
    end;
    dts.Close;
    dts.Destroy;
    Console.AddEvent(EVENT_ICON_EMPTY, LEVEL_2, translate('dsLoadTarifsOk')+' ['+IntToStr(TarifsCount-1)+']');
  end;
end;


function MonthToString(m: integer):string;
begin
  case m of
  1: MonthToString := 'jan';
  2: MonthToString := 'feb';
  3: MonthToString := 'mar';
  4: MonthToString := 'apr';
  5: MonthToString := 'may';
  6: MonthToString := 'jun';
  7: MonthToString := 'jul';
  8: MonthToString := 'aug';
  9: MonthToString := 'sep';
  10: MonthToString := 'oct';
  11: MonthToString := 'nov';
  12: MonthToString := 'dec';
  else
    MonthToString := 'oops!';
  end;
end;

// переводит дату/время в формат для SQL-сервака по типу '19 jan 2003 17:00:20'
function DateTimeToSql(t: TDateTime):string;
var
  res: string;
begin
  res := IntToStr(DayOf(t)) + ' ' + MonthToString(MonthOf(t)) + ' ' + IntToStr(YearOf(t)) + ' ';
  res := res + IntToStr(HourOf(t)) + ':';
  res := res + IntToStr(MinuteOf(t)) + ':';
  res := res + IntToStr(SecondOf(t));
  DateTimeToSql := res;
end;

// переводит дату/время в формат  '17:00'
function DateTimeToTimeString(AdtTime: TDateTime; AbShowSeconds: Boolean): String;
var
  res: string;
begin
  if (HourOf(AdtTime)<10) then
    res := '0'
  else
    res := '';
  res := IntToStr(HourOf(AdtTime)) + ':';
  if (MinuteOf(AdtTime)<10) then
    res := res+'0';
  res := res + IntToStr(MinuteOf(AdtTime));
  if (AbShowSeconds) then begin
    if (SecondOf(AdtTime)<10) then
      res := res+':0'
    else
      res := res+':';
    res := res + IntToStr(SecondOf(AdtTime));
  end;
  DateTimeToTimeString := res;
end;

// процедура выполняет хранимую процедуру без возвращение рекордсета
function dsDoCommand(str: string):boolean;
var
  cmd: TADOCommand;
begin
  dsDoCommand := false;
  try
    if (dsConnected) then
    begin
      cmd := TADOCommand.Create(nil);
      cmd.Connection := dmMain.cnnMain;
      cmd.CommandTimeout := 10;//5;
      cmd.CommandType := cmdText;
      cmd.ParamCheck := false;
      cmd.CommandText := 'exec ' + str;
      cmd.execute;
      cmd.Destroy;
      dsDoCommand := true;
    end;
  except
    on E: EOleException do
      Case E.ErrorCode Of
        -2147467259: begin
                        formMain.tmrCyclicCompAction.Enabled := false;
                        formMain.timerCompsList.Enabled := false;
                        formMain.tmrFileSynchronization.Enabled := false;
                        formMain.timerGSessionsLoad.Enabled := false;
                        // блокируем список компов, чтобы бардака не было
                        formMain.gridComps.Enabled := False;
                        MessageBox(HWND_TOP, PChar(translate('msgBaseConnectLost')),
                          PChar('GameClass Error'),MB_OK or MB_ICONERROR);
                        formMain.tmrCyclicCompAction.Enabled := true;
                        formMain.timerCompsList.Enabled := true;
                        ehsExit;
                     end;
        else
          begin
            ShowMessage(E.Message
              + ' Error code : ' + inttostr(E.ErrorCode)
              + ' str = ' + str);
            raise;
          end;
      end;
    // сперва остановим таймер, чтобы бардака не было
{    formMain.tmrCyclicCompAction.Enabled := false;
    formMain.timerCompsList.Enabled := false;
    formMain.tmrFileSynchronization.Enabled := false;
    formMain.timerGSessionsLoad.Enabled := false;
    // блокируем список компов, чтобы бардака не было
    formMain.gridComps.Enabled := False;
    MessageBox(HWND_TOP, PChar(translate('msgBaseConnectLost')),PChar('GameClass Error'),MB_OK or MB_ICONERROR);
    formMain.tmrCyclicCompAction.Enabled := true;
    formMain.timerCompsList.Enabled := true; }
//    ehsExit;
//    raise;
    // ToDo надо вычислить ошибку потери сети и отреагировать как закоментировано ниже
//    MessageBox(HWND_TOP, PChar(translate('msgBaseConnectLost')),PChar('GameClass Error'),MB_OK or MB_ICONERROR);
//    ehsExit;
  end;
end;

// процедура выполняет хранимую процедуру без возвращение рекордсета
function dsDoCommand(str: string; AnTimeOut: Integer):boolean;
var
  cmd: TADOCommand;
begin
  dsDoCommand := false;
  try
    if (dsConnected) then
    begin
      cmd := TADOCommand.Create(nil);
      cmd.Connection := dmMain.cnnMain;
      cmd.CommandTimeout := AnTimeOut;
      cmd.CommandType := cmdText;
      cmd.ParamCheck := false;
      cmd.CommandText := 'exec ' + str;
      cmd.execute;
      cmd.Destroy;
      dsDoCommand := true;
    end;
  except
    // сперва остановим таймер, чтобы бардака не было
    raise;
    // ToDo надо вычислить ошибку потери сети и отреагировать как закоментировано ниже
//    MessageBox(HWND_TOP, PChar(translate('msgBaseConnectLost')),PChar('GameClass Error'),MB_OK or MB_ICONERROR);
//    ehsExit;
  end;
end;

// процедура выполняет SQL запрос
procedure dsDoCommandSQLQuery(str: string);
var
  cmd: TADOCommand;
begin
  try
    if (dsConnected) then
    begin
      cmd := TADOCommand.Create(nil);
      cmd.Connection := dmMain.cnnMain;
      cmd.CommandTimeout := 10;//5;
      cmd.CommandType := cmdText;
      cmd.ParamCheck := false;
      cmd.CommandText := str;
      cmd.execute;
      cmd.Destroy;
    end;
  except
    // сперва остановим таймер, чтобы бардака не было
    raise;
    // ToDo надо вычислить ошибку потери сети и отреагировать как закоментировано ниже
//    MessageBox(HWND_TOP, PChar(translate('msgBaseConnectLost')),PChar('GameClass Error'),MB_OK or MB_ICONERROR);
//    ehsExit;
  end;
end;

// процедура выполняет хранимую процедуру без возвращение рекордсета
procedure dsDoCommandChangePass(str: string);
var
  cmd: TADOCommand;
begin
  if (dsConnected) then
  begin    
    cmd := TADOCommand.Create(nil);
    cmd.Connection := dmMain.cnnMain;
    cmd.CommandTimeout := 10;//5;
    cmd.CommandType := cmdText;
    cmd.ParamCheck := false;
    cmd.CommandText := 'exec ' + str;
    cmd.execute;
    cmd.Destroy;
  end;
end;


procedure dsDoQuery(str: string; pdts: PTADODataSet);
begin
  try
    if (dsConnected) then
    begin
      pdts^.Connection := dmMain.cnnMain;
      pdts^.LockType := ltOptimistic;
      pdts^.CursorLocation := clUseClient;
      pdts^.CursorType := ctStatic;
      pdts^.CommandText := str;
      pdts^.ParamCheck := false;
      pdts^.Open;
    end;
  except
    // сперва остановим таймер, чтобы бардака не было
    formMain.timerCompsList.Enabled := false;
    MessageBox(HWND_TOP, PChar(translate('msgBaseConnectLost')),PChar('GameClass Error'),MB_OK or MB_ICONERROR);
    formMain.timerCompsList.Enabled := true;
    dmActions.actExit.Execute;
  end;
end;

procedure DBCreateAndOpenQuery(const AstrSQLCode: String;
    var AADOQuery: TADOQuery);
begin
  try
    if (dsConnected) then
    begin
      AADOQuery := TADOQuery.Create(Nil);
      with AADOQuery do begin
        Connection := dmMain.cnnMain;
     {   LockType := ltOptimistic;
        CursorLocation := clUseClient;
        CursorType := ctStatic;
        ParamCheck := false;        }
        with SQL do begin
          Clear;
          Add(AstrSQLCode);
        end;
      Open;
      end;
    end;
  except
    // сперва остановим таймер, чтобы бардака не было
    formMain.timerCompsList.Enabled := false;
    MessageBox(HWND_TOP, PChar(translate('msgBaseConnectLost')),PChar('GameClass Error'),MB_OK or MB_ICONERROR);
    formMain.timerCompsList.Enabled := true;
    dmActions.actExit.Execute;
  end;
end;

procedure dsControlClubStart;
begin
  if (isManager) then exit;
  if not GRegistry.Options.WriteUnControlClub then exit;  
  dsDoCommand(DS_CONTROLCLUB_START + ' @now='''+DateTimeToSql(GetVirtualTime) + '''');
end;

procedure dsControlClubTimer;
begin
  if (isManager) then exit;
  if not GRegistry.Options.WriteUnControlClub then exit;
  dsDoCommand(DS_CONTROLCLUB_TIMER + ' @now='''+DateTimeToSql(GetVirtualTime) + '''');
end;

procedure dsControlCompStart(idComp: integer);
begin
  if (isManager) then exit;
  if not GRegistry.Options.WriteUnControlComp then exit;
  dsDoCommand(DS_CONTROLCOMP_START + ' @idComp=' + IntToStr(idComp) + ', @now='''+DateTimeToSql(GetVirtualTime) + '''');
end;

procedure dsControlCompTimer(idComp: integer);
begin
  if (isManager) then exit;
  if not GRegistry.Options.WriteUnControlComp then exit;
  dsDoCommand(DS_CONTROLCOMP_TIMER + ' @idComp=' + IntToStr(idComp) + ', @now='''+DateTimeToSql(GetVirtualTime) + '''');
end;

procedure dsCompsMove(indexComp1: integer; indexComp2:integer);
begin
  if (isManager) then exit;
  if ((Comps[indexComp1].busy) and (Comps[indexComp2].busy)) then
  begin
    dsDoCommand(DS_COMPUTERS_MOVE + ' @idSessionsAdd=' + IntToStr(Comps[indexComp2].session.IdSessionsAdd) + ', @idComp=' + IntToStr(Comps[indexComp1].id));
    dsDoCommand(DS_COMPUTERS_MOVE + ' @idSessionsAdd=' + IntToStr(Comps[indexComp1].session.IdSessionsAdd) + ', @idComp=' + IntToStr(Comps[indexComp2].id));
  end
  else
  if ((Not Comps[indexComp1].busy) and (Comps[indexComp2].busy)) then
    dsDoCommand(DS_COMPUTERS_MOVE + ' @idSessionsAdd=' + IntToStr(Comps[indexComp2].session.IdSessionsAdd) + ', @idComp=' + IntToStr(Comps[indexComp1].id))
  else
  if ((Comps[indexComp1].busy) and (Not Comps[indexComp2].busy)) then
    dsDoCommand(DS_COMPUTERS_MOVE + ' @idSessionsAdd=' + IntToStr(Comps[indexComp1].session.IdSessionsAdd) + ', @idComp=' + IntToStr(Comps[indexComp2].id));
end;

procedure dsRegistrySave(param:string; value:string);
begin
  dsDoCommand(DS_REGISTRY_SAVE + ' @key=N''' + param + ''', @value=N''' + value + '''');
end;

function dsRegistryLoad(param:string; default: string):string;
var
  dts: TADODataSet;
  query: string;
begin
  if (dsConnected) then
  begin
    query := DS_REGISTRY_LOAD + ' @key=''' + param + '''';
    dts := TADODataSet.Create(nil);
    dsDoQuery(query, @dts);
    if (not dts.Recordset.EOF) then
      dsRegistryLoad := dts.Recordset.Fields.Item['value'].Value
    else
    begin
      dsRegistryLoad := default;
      dsRegistrySave(param, default);
    end;
    dts.Close;
    dts.Destroy;
  end;
end;

// возвращает итоговую сумму наличности оператора за его смену
//function dsGetCurrentShiftTotal(totalTime, totalService, totalTraffic, totalPrinted: PTDouble; LastShift: PTDateTime):double;
function dsGetCurrentShiftTotal(var AfTime, AfService, AfTraffic, AfPrinted,
    AfAccountsAdded, AfAccountsPayed, AfAccountsReturned: Double;
    var AdtLastShift: TDateTime): Double;
var
  dts: TADODataSet;
  query: string;
begin
  dsGetCurrentShiftTotal := 0;
  dmMain.dstCurrentReport.Parameters.ParamValues['@NewShiftPoint']
      := GetVirtualTime;
  if ExecuteStoredProc(dmMain.cnnMain, dmMain.dstCurrentReport) then
    with dmMain.dstCurrentReport.Parameters do begin
      AdtLastShift := ParamValues['@LastShiftPoint'];
      AfTime := ParamValues['@Time'];
      AfService := ParamValues['@Serices'];
      AfTraffic := ParamValues['@Internet'];
      AfPrinted := ParamValues['@Print'];
      AfAccountsAdded := ParamValues['@AccountsAdded'];
      AfAccountsPayed := ParamValues['@AccountsPayed'];
      AfAccountsReturned := ParamValues['@AccountsReturned'];
//      AfTime := AfTime - (AfPrinted {+ AfTraffic});
      dsGetCurrentShiftTotal := AfTime + AfService + AfPrinted + AfTraffic
        + AfAccountsAdded - AfAccountsReturned;
    end;
end;

// возвращает 3 последние точки отчетов операторов
function dsGet3LastOpReportPoints(Last1,Last2,Last3,Last4:PTDateTime):string;
var
  dts: TADODataSet;
  query: string;
  res_str: string;
  i: integer;
  tm: TDateTime;
begin
  if (not isManager) then exit;
  res_str := '';
  Last1^ := 0;
  Last2^ := 0;
  Last3^ := 0;
  Last4^ := 0;
  if (dsConnected) then
  begin
    query := DS_JOURNALOP_SELECT;
    dts := TADODataSet.Create(nil);
    dsDoQuery(query, @dts);

    i := 0;
    while (i < 3) and (not dts.Recordset.EOF) do begin
      if (i>0) then res_str := res_str + '/';
      res_str := res_str + dts.Recordset.Fields.Item['operator'].Value;
      tm := dts.Recordset.Fields.Item['moment'].Value;
      if (i = 0) then Last1^ := tm;
      if (i = 1) then Last2^ := tm;
      if (i = 2) then Last3^ := tm;
      if (i = 3) then Last4^ := tm;

      i := i + 1;
      dts.Recordset.MoveNext;
    end;

    dts.Close;
    dts.Destroy;
  end;
  dsGet3LastOpReportPoints := res_str;
end;


procedure dsCloseCurrentShift(money: double; moment: TDateTime; comment: string);
var
  query: string;
begin
  query := DS_REPORT_CURENT_INSERT
      + ' @moment=''' + DateTimeToSql(moment)
      + ''', @summa=' + FloatToStrGC(money)
      + ', @removedMoney=' + FloatToStrGC(GRegistry.Options.RemovedMoney)
      + ', @comment='''+comment
      +''', @traffic=' + IntToStr(GetOperatorTraffic);
  dsDoCommand(query);
  GRegistry.Options.OperatorTrafficInbound := 0;
  GRegistry.Options.OperatorTrafficOutbound := 0;
end;

procedure dsClearStatistics;
begin
  dsDoCommand(DS_CLEAR_STATISTICS,60);
end;

// возвращает сумму, неотработанную текущими клиентами
function dsGetCurrentShiftRest:double;
var
  rest: double;
  i: integer;
begin
  rest := 0;
  for i:=0 to (CompsCount-1) do
    if Comps[i].busy then
      if (Not Comps[i].session.PostPay) and (Comps[i].session.Whole = 0) then
        rest := rest + (Comps[i].session.CommonPay
            - Comps[i].session.GetCostTotal);
  dsGetCurrentShiftRest := rest;
end;

function FloatToStrGC(value: double):string;
var
  str: string;
begin
  str := FloatToStr(RoundTo(value,-3));
  FloatToStrGC := AnsiReplaceStr(str,',','.');
end;

function StrToFloatGC(str: string):double;
begin
  StrToFloatGC := StrToFloatDefWithReplace(str,0);
end;

function GetAppVersion:string;
begin
  GetAppVersion := APP_VERSION;
end;

function GetShortWeekDay(day: integer):string;
begin
  if (day = 1) then GetShortWeekDay := Copy(translate('Monday'),1,3);
  if (day = 2) then GetShortWeekDay := Copy(translate('Tuesday'),1,3);
  if (day = 3) then GetShortWeekDay := Copy(translate('Wednesday'),1,3);
  if (day = 4) then GetShortWeekDay := Copy(translate('Thursday'),1,3);
  if (day = 5) then GetShortWeekDay := Copy(translate('Friday'),1,3);
  if (day = 6) then GetShortWeekDay := Copy(translate('Saturday'),1,3);
  if (day = 7) then GetShortWeekDay := Copy(translate('Sunday'),1,3);
end;

procedure dsLoadUncontrolComputers;
var
  dts: TADODataSet;
  i,index: integer;
begin
  if (dsConnected) then
  begin
    dts := TADODataSet.Create(nil);
    dsDoQuery(DS_SESSIONS_READ_UNCONTROLSTATE + ' @now='''+DateTimeToSql(IncSecond(GetVirtualTime,-READ_UNCONTROLSTATE_TIMEOUT))+'''', @dts);
    for i:=0 to CompsCount-1 do
      Comps[i].control := true;
    dts.First;
    while (not dts.Recordset.EOF) do
    begin
      index := StrToInt(dts.Recordset.Fields.Item['idComputers'].Value);
      if ComputersCheckIndex(index) then
        Comps[ComputersGetIndex(index)].control := false;
      dts.Recordset.MoveNext;
    end;
  
    dts.Close;
    dts.Destroy;
  end;
end;

procedure dsSendOptionsToClients;
var
  i: integer;
begin
  for i:=0 to (CompsCount-1) do begin
   SendAllOptionsToClient(i);
  end;
end;

// вызов файла справки с нужным контекстом
procedure GCHelp(const AstrArticle: String);
var
  strUrl: String;
begin
  strUrl := 'http://www.gameclass.ru/wiki/index.php/';
  if Length(AstrArticle) = 0 then
    strUrl := strUrl + HELP_BEGIN
  else
    strUrl := strUrl + AstrArticle;
  ShellExecute(0, 'open', pChar(strUrl), Nil, Nil, SW_SHOWNORMAL);
end;

function BoolToStr01(b_in: boolean):string;
begin
 BoolToStr01 := '0';
 if b_in then BoolToStr01 := '1';
end;

procedure CheckDebugLogging;
var
  Reg: Registry.TRegistry;
begin
  Reg := Registry.TRegistry.Create;
  Reg.RootKey := HKEY_LOCAL_MACHINE;
   if Reg.OpenKeyReadOnly('\Software\GameClass3') then
      if Reg.ReadString('Debug') = '1' then begin
         Debug.Level := 9;
      end;
  Reg.CloseKey;
  Reg.Free;
end;

function dsGetVarBySqlQuery(Query: string):string;
var
  dts: TADODataSet;
  tm: TDateTime;
begin
  Result := '';
  if (dsConnected) then
  begin
    dts := TADODataSet.Create(nil);
    dsDoQuery(Query, @dts);
    if (not dts.Recordset.EOF) then
    begin
      Result := dts.Recordset.Fields.Item['value'].Value;
    end;
    dts.Close;
    dts.Destroy;
  end;
end;

procedure GenerateClubInfoName;
var
  strFileName : string;
  f: TextFile;
begin
  strFileName := ExtractFilePath(Application.ExeName) + CLUB_INFO_DIRECTORY + '\' + CLUB_INFO_NAME_FILENAME;
  AssignFile(f, strFileName);
  try
    Rewrite(f);
    Writeln(f, CLUB_INFO_NAME_HTML_BEGIN);
    Writeln(f, GRegistry.Options.ClubName + '  ' + DateTimeToTimeString(GetVirtualTime,False));
    Writeln(f, CLUB_INFO_NAME_HTML_END);
    CloseFile(f);
  except
    strFileName := translate('WarningClubInfoFilesAccess') + ExtractFilePath(Application.ExeName) +
      CLUB_INFO_DIRECTORY +translate('WarningClubInfoFilesAccess2');
    Console.AddEvent(EVENT_ICON_ERROR, LEVEL_ERROR,strFileName);
    if (GCCommonRegistryReadStr(DONTSHOW_CLUB_INFO_FILE_ACCESS_ERROR)='') then begin
      formGCMessageBox.memoInfo.Text := strFileName;
      formGCMessageBox.SetDontShowAgain(true);
      formGCMessageBox.ShowModal;
      if (formGCMessageBox.cbNotShowAgain.Checked) then
        GCCommonRegistryWriteStr(DONTSHOW_CLUB_INFO_FILE_ACCESS_ERROR,'1');
    end;
  end;
end;

procedure GenerateClubInfoState;
var
  strFileName : string;
  f: TextFile;
  i: Integer;
begin
  strFileName := ExtractFilePath(Application.ExeName) + CLUB_INFO_DIRECTORY + '\' + CLUB_INFO_STATE_FILENAME;
  AssignFile(f, strFileName);
  try
    Rewrite(f);
    Writeln(f, CLUB_INFO_STATE_HTML_BEGIN);
    Writeln(f, CLUB_INFO_STATE_HTML_BEGIN2);
    for i:=0 to CompsCount-1 do begin
      Writeln(f, '<tr>');
      if Comps[i].control then
        Writeln(f, '  <td> Вкл </td>')
      else
        Writeln(f, '  <td> Выкл </td>');
      Writeln(f, '  <td>' + Comps[i].GetStrNumber + '</td>');
      if Comps[i].busy then begin
        Writeln(f, '  <td>' + DateTimeToSql(Comps[i].session.TimeStop) + '</td>');
        Writeln(f, '  <td>' + DateTimeToTimeString(Comps[i].session.TimeStop - GetVirtualTime, False)+ '</td>');
      end
      else
        Writeln(f, '  <td> </td><td> </td>');
      Writeln(f, '</tr>');
    end;
    Writeln(f, CLUB_INFO_STATE_HTML_END);
    CloseFile(f);
  except
    strFileName := translate('WarningClubInfoFilesAccess') + ExtractFilePath(Application.ExeName) +
      CLUB_INFO_DIRECTORY +translate('WarningClubInfoFilesAccess2');
    Console.AddEvent(EVENT_ICON_ERROR, LEVEL_ERROR,strFileName);
    if (GCCommonRegistryReadStr(DONTSHOW_CLUB_INFO_FILE_ACCESS_ERROR)='') then begin
      formGCMessageBox.memoInfo.Text := strFileName;
      formGCMessageBox.SetDontShowAgain(true);
      formGCMessageBox.ShowModal;
      if (formGCMessageBox.cbNotShowAgain.Checked) then
        GCCommonRegistryWriteStr(DONTSHOW_CLUB_INFO_FILE_ACCESS_ERROR,'1');
    end;
  end;
end;
{
// Функция вычисляет триальное время по базе данных и сравнивает с инфой ASPProtecta
// Корректирует данные TRegistration
// Вовзвращает True, если триал кончился, а ASP об этом не знает, т.е. чистят реестр
function dsCompareTrials:Boolean;
var
  dtMin: TDateTime;
  dtMax: TDateTime;
  dtMoment: TDateTime;
  dstMoment: TADODataSet;
begin
// Под менеджером можно исполнять запросы из клиента (это круче - нельзя заменить процедуру),
// под оператором прав на select нет, поэтому только процедуру.
  Result := False;
  dstMoment := TADODataSet.Create(nil);
  dtMin := GetVirtualTime;
  dtMax := GetVirtualTime;
  if isManager then begin
    dsDoQuery('select top 1 moment from AccountsHistory order by moment asc', @dstMoment);
    if dstMoment.Recordset.RecordCount > 0 then begin
      dtMoment := dstMoment.Recordset.Fields.Item['moment'].Value;
      if dtMoment < dtMin then
        dtMin := dtMoment;
    end;
    dstMoment.Close;
    dsDoQuery('select top 1 moment from AccountsHistory order by moment desc', @dstMoment);
    if dstMoment.Recordset.RecordCount > 0 then begin
      dtMoment := dstMoment.Recordset.Fields.Item['moment'].Value;
      if dtMoment > dtMax then
        dtMax := dtMoment;
    end;
    dstMoment.Close;
    dsDoQuery('select top 1 moment from Hardware order by moment asc', @dstMoment);
    if dstMoment.Recordset.RecordCount > 0 then begin
      dtMoment := dstMoment.Recordset.Fields.Item['moment'].Value;
      if dtMoment < dtMin then
        dtMin := dtMoment;
    end;
    dstMoment.Close;
    dsDoQuery('select top 1 moment from Hardware order by moment desc', @dstMoment);
    if dstMoment.Recordset.RecordCount > 0 then begin
      dtMoment := dstMoment.Recordset.Fields.Item['moment'].Value;
      if dtMoment > dtMax then
        dtMax := dtMoment;
    end;
    dstMoment.Close;
    dsDoQuery('select top 1 moment from JournalOp order by moment asc', @dstMoment);
    if dstMoment.Recordset.RecordCount > 0 then begin
      dtMoment := dstMoment.Recordset.Fields.Item['moment'].Value;
      if dtMoment < dtMin then
        dtMin := dtMoment;
    end;
    dstMoment.Close;
    dsDoQuery('select top 1 moment from JournalOp order by moment desc', @dstMoment);
    if dstMoment.Recordset.RecordCount > 0 then begin
      dtMoment := dstMoment.Recordset.Fields.Item['moment'].Value;
      if dtMoment > dtMax then
        dtMax := dtMoment;
    end;
    dstMoment.Close;
    dsDoQuery('select top 1 moment from SessionsAdd2 order by moment asc', @dstMoment);
    if dstMoment.Recordset.RecordCount > 0 then begin
      dtMoment := dstMoment.Recordset.Fields.Item['moment'].Value;
      if dtMoment < dtMin then
        dtMin := dtMoment;
    end;
    dstMoment.Close;
    dsDoQuery('select top 1 moment from SessionsAdd2 order by moment desc', @dstMoment);
    if dstMoment.Recordset.RecordCount > 0 then begin
      dtMoment := dstMoment.Recordset.Fields.Item['moment'].Value;
      if dtMoment > dtMax then
        dtMax := dtMoment;
    end;
  end else begin
    dsDoQuery(DS_USAGE_DATE_SELECT, @dstMoment);
    dtMoment := dstMoment.Recordset.Fields.Item['dateMin'].Value;
    if dtMoment < dtMin then
      dtMin := dtMoment;
    dtMoment := dstMoment.Recordset.Fields.Item['dateMax'].Value;
    if dtMoment > dtMax then
      dtMax := dtMoment;
    dstMoment.Close;
  end;
  if (DaysBetween(dtMin,dtMax) > Registration.TrialDaysTotal) then begin
    if (Registration.TrialDaysLeft <> 0) then
      Result := True;
    Registration.TrialDaysLeft := 0;
  end;
end;}
{
procedure ShowTrialWarning;
var
  n: integer;
begin
  n := 0;
  if StrLen(Registration.UserName) > 0 then
    formMain.mnuRestrictions.Visible := False;
  if Not (StrLen(Registration.UserName) > n*3) then
  begin
    Application.CreateForm(TformTrial, formTrial);

    if ((Registration.TrialDaysLeft=0) or (Registration.TrialExLeft=0)) then
      formTrial.memoInfo.Text := 'GameClass '+APP_VERSION+''#13#10#13#10+
      translate('TrialEnd')+''#13#10+translate('Unreg6')
    else
      formTrial.memoInfo.Text := 'GameClass '+APP_VERSION+''#13#10#13#10+
      translate('Unreg1')+''#13#10+translate('Unreg2')+IntToStr(Registration.TrialDaysLeft)+translate('Unreg3')+''#13#10+
//      translate('Unreg4')+IntToStr(Registration.TrialExLeft) + translate('Unreg5') + ''#13#10+
      translate('Unreg6')+''#13#10;

    formTrial.pbLeft.Position := Round(((21-Registration.TrialDaysLeft)/21)*100);

    formTrial.ShowModal;
    formTrial.Destroy;
  end;
end;
}
procedure dsProcessAdd(const AbProcessStarted: Boolean;
    const AnIdComputer: Integer;
    const AstrExeFile: String);
var
  strSQLQuery: String;
begin
  // процедура записывает процесс в таблицу
  if (not dsConnected) then exit;

  strSQLQuery := DS_PROCESS_ADD
      + ' @ProcessStarted=' + IfThen(AbProcessStarted,'1','0')
      + ', @IdComputer=' + IntToStr(AnIdComputer)
      + ', @Name=''' + ExtractFileName(AstrExeFile)
      + ''', @ExeFile=''' + AstrExeFile
      + ''', @Moment=''' + DateTimeToSql(GetVirtualTime) + '''';
  dsDoCommand(strSQLQuery);
end;

function dsGetBaseVersion: String;
var
  strSQLQuery: String;
  strBaseVersion: String;
  dsResult: TADODataSet;
begin
  strBaseVersion := '';
  if (not dsConnected) then exit;
  strSQLQuery := 'exec RegistrySelectByKey ''BaseVersion''';
  dsResult := TADODataSet.Create(Nil);
  try
    uSQLTools.dsDoQuery(dmMain.cnnMain, dsResult, strSQLQuery);
    if (dsResult.RecordCount > 0) then
      strBaseVersion := dsResult.FieldValues['value'];
  except
  end;
  dsResult.Free;
  if Length(strBaseVersion) = 0 then begin
    strSQLQuery := 'exec RegistrySelect ''BaseVersion''';
    dsResult := TADODataSet.Create(Nil);
    try
      uSQLTools.dsDoQuery(dmMain.cnnMain, dsResult, strSQLQuery);
      if (dsResult.RecordCount > 0) then
        strBaseVersion := dsResult.FieldValues['value'];
    except
    end;
    dsResult.Free;
  end;
  dsGetBaseVersion := strBaseVersion;
end;

function GetOperatorTraffic: Cardinal;
var
  nInbound, nOutbound: Cardinal;
begin
  Result := 0;
  if GRegistry.Options.OperatorTrafficControl
      and GRegistry.Modules.Internet.SummaryAccounting then begin
    nInbound := GRegistry.Options.OperatorTrafficInbound;
    nOutbound := GRegistry.Options.OperatorTrafficOutbound;
    case GRegistry.Modules.Internet.TariffingMode of
      tmOnlyInbound: Result := nInbound;
      tmSummary: Result := nInbound + nOutbound;
      tmMaximum:
        if (nInbound > nOutbound) then
          Result := nInbound
        else
          Result := nOutbound;
    end;
  end;
end;

end.
