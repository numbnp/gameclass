// модуль Computer
// тут опишем класс компьютер, который будет инкапсулировать
// в себе все, что относится к компу
// где-нибудь у нас будет массив компьютеров и это правильно
unit gccomputers;

interface

uses
  GCCommon, GCConst, GClangutils, Classes, StdCtrls,
  Dialogs, ComCtrls, DateUtils, frmGCMessageBox, Proxy,
  SysUtils, DB, ADODB, StrUtils, IdSocketHandle,
  IdUDPServer, IdUDPClient, IdICMPClient,
  GCSessions, uClientInfoConst, JwaIpHlpApi, JwaWinsock2, Graphics, uGCSendRecieve,
  uGCDevices;{,
  IdBaseComponent,IdComponent,IdUDPBase,IdGlobal;}


procedure SendAllOptionsToClient(index: integer);
procedure SendAccountAndSessionInfoToClient(AnComputerIndex: Integer);

function ComputersGetIndex(id:longword):integer;
function ComputersCheckIndex(id:longword):Boolean;
function ComputersGetIndexByIp(ip:string):integer;
function ComputerGroupsGetName(AnId: Integer):String;
function TarifsGetId(name: string): longword;
function TarifsGetIndex(id: longword): integer;
function GetTarifName(AnTarifId,AnWhole:Integer): string;
function CalculateTarif(AstrTarifName: String;
    var AdtStart: TDateTime; var AdtTime: TDateTime;
    var AfSum: Double; AbCalcBySum: Boolean;
    AnComputerIndex: Integer; AnDiscount: Integer):Boolean;
function IsBetween(AdtMoment, AdtStart, AdtEnd: TDateTime):Boolean;
function GetTarifByName(AstrTarifName: String;
    var AnTarifIndex: Integer; var AnTarifVariantIndex: Integer;
    var AbIsPacketTarif: Boolean):Boolean;
function GetTarifNames: TStringList;

procedure CompStop(AnComputerIndex: Integer);

function GetClientState(AnComputerIndex: Integer): Integer;

// Получение Mac адреса по свойсву ip
function GetMacFromIP(IPAddr:PAnsichar):string;
// Процедура для посылки WOL пакета
procedure WakeUPComputer(aMacAddress: string);

// посылаем UDP пакет с данными data на адрес ip
procedure UDPSend(const AstrIP: string; const AstrData: string);


const
  MAX_DOUBLE = 1700000000000000000000000000000000000000000.0;
type
  TAuthorization = record
//    state: integer;     // 0 - blocked, 1-authorizing, 2-authorized and not order, 3 - authorized and ordered
    state: TClientState;     // 0 - blocked, 1-authorizing, 2-authorized and not order, 3 - authorized and ordered
    number: integer;    // id клиента, 0 - гость
//    name: string;       // имя клиента
//    balance: Double;    // баланс, если подключились
//    limitBalance: double;  // порог отключения (по умолчанию 0), если подключились
    secCode: integer;  // номер запрашиваемого сек.кода. Если 0, то нет сек.кода
    nFailedAuthentication: integer;  // количество неверных логинов
    LogonOrStopMoment: TDateTime;  // момент залогинивания
  end;

  TMacAddress = array [0..5] of byte;

  PInteger = ^integer;

  THardware = record
    t: string; // type
    v: string; // value
    used: boolean; //flag
  end;

  TMapping
   = record
    id: word;
    listenport: word;
    mappedip: string;
    mappedport: word;
  end;

  TMappings = class
  public
    constructor Create;
    procedure Load;
    procedure Add(listenport,mappedport:word; mappedip:string);
    procedure Delete(id: word);
  public
    count: integer;
    LMappings: array of TMapping;
  end;

  TComputerAction = (
    caStart = 1,
    caReserve = 2,
    caStop = 3,
    caAdd = 4,
    caReserveCancel = 5,
    caDec = 6
  );


  // класс компьютера
  TComputer = class
  // methods
  private
    FnIdGroup: Integer;
    FstrGroupName: String;
    FbPingable: Boolean;  //пингуется ICMP
    FbWarnedTime: Boolean;    //предупрежден об окончании времени
    FnIcmpPings: integer;     // quantity of unsuccessfull ICMP pings
    FnScriptCheckSumm: Int64;  //контрольная сумма скрипт-файла
    FnInstallCheckSumm: Int64;  //контрольная сумма инсталляхи клиента
    FbLinuxClient: Boolean;
    Device:IGCDevice;

    function GetBusy: Boolean;
    function GetReserved: Boolean;
    function GetRealyPingable: Boolean;

  public
    constructor Create;
    function GetStrNumber:string;
    function GetInfo:string; // выдача краткой инфы на табло клиента на время когда комп свободен
    function GetInfoFull:string; // выдача полной инфы на табло клиента в первые 10 сек после завершения и в систрее во время работы
    function IsLikely(const AAction: TComputerAction): Boolean;
  // properties
  public
    id: longword;        // id computer
    number: integer;    // number computer

    IndexInSystem:integer; //Индекс в системе       { TODO : Удалить позже }
    ClientType: integer;
    ipaddr: string;     // ip address
    macaddr: string;    // mac address
    control: boolean;   // if controlled;
    pings: integer;     // quantity of unsuccessfull pings
//    busy: boolean;      // free or busy
    st:TStringList;     // для метода GetInfoFull
    session: TGCSession;
    // misc
    For_dsLoadSessions: boolean;
    timeStopSession: TDateTime; // момент, когда завершилась сессия
    bStopSession: boolean; // если true, то время кончилось, но задачи еще не сняли
    // misc2
    strInfoWinver: string; // версия виндовс на машине
    strInfoClientver: string; // версия GC3 клиента на машине
    strInfoFreespaceC: string; // свободно места на диске С
    strInfoFreespaceD: string; // свободно места на диске D

    IcmpPingable: Boolean;
    RealIcmpPingable: Boolean;

    SNMP_Password: String;
    SNMP_MIB_Port: String;

    IgnoreOffline: boolean;

    // authorize
    a: TAuthorization;
    function IsGuestSession: Boolean;
    property IdGroup: Integer read FnIdGroup write FnIdGroup;
    property GroupName: String read FstrGroupName write FstrGroupName;
    property Pingable: Boolean read FbPingable write FbPingable;
    // Пингуется действительно, а не значение true при старте
    property WarnedTime: Boolean read FbWarnedTime write FbWarnedTime;
    property RealyPingable: Boolean read GetRealyPingable;
    property IcmpPings: Integer read FnIcmpPings write FnIcmpPings;
    property Busy: Boolean read GetBusy;
    property Reserved: Boolean read GetReserved;
    property ScriptCheckSumm: Int64
        read FnScriptCheckSumm write FnScriptCheckSumm;
    property InstallCheckSumm: Int64
        read FnInstallCheckSumm write FnInstallCheckSumm;
    function IsFree: Boolean;
    property LinuxClient: Boolean
        read FbLinuxClient write FbLinuxClient;

    function Agreement: Boolean;

    function PowerOff: Boolean;
    function PowerOn: Boolean;
    function Reboot: Boolean;
    function Logoff: Boolean;

    function InitDev:Boolean;

    procedure CheckState();

    procedure RunPadMonitorOff (state:Boolean);
    procedure RunPadLockStation (state:Boolean);

  end;

  TComputerGroup = class
  // methods
  private
    nId: Integer;        // id group
    strName: string;     // name
  public
  // properties
    property Id: Integer read nId write nId;
    property Name: String read strName write strName;
  end;

  // класс клиента
  TClient = class
  public
    constructor Create;
  public
    id: longword;
    name: string;
  end;


  // настройки конкретного оператора
  TOperatorProfile = class
  public
    constructor Create;
    procedure Reset;
    procedure Load;
    procedure Save;
    procedure DoInterface;
  public
    bShowTechCompsInfo: boolean; // показывать техническую информацию?
    ComputerListBlockedFont: TFont;
    ComputerListNotBusyFont: TFont;
    ComputerListAuthenticatedFont: TFont;
    ComputerListReserveFont: TFont;
    ComputerListAccupiedFont: TFont;
    ComputerListPreventedFont: TFont;
  end;


  // класс консоли
  TConsole = class
  public
    constructor Create;
    procedure AddEvent(event_type: integer; level: integer; str: string);
  public
    //
  end;

  // единица данных кеша тарифа
  TCache = record
    mins: integer; // количество минут
    money: double; // количество денег
    mins_free: integer; // количество бесплатных минут
  end;

//  function TotalSeconds(length: TDateTime): longword;
  function GetAccountName(const AAuthorization: TAuthorization): String;
  function GetAccountBalance(const AAuthorization: TAuthorization): Double;
  function GetAccountSummary(const AAuthorization: TAuthorization): Double;
  function GetAccountBalanceLimit(const AAuthorization: TAuthorization): Double;

  procedure CompsSelDeselect(const AAction: TComputerAction);
  function CompsSelIsLikely(const AAction: TComputerAction): Boolean;
  function SelCompsAsText: String;

var
  Comps: array[0..(MAX_COMPUTERS-1)] of TComputer;
  CompsCount: integer = 0;   // текущее количество компов

  CompGroups: array[0..(MAX_GROUPS-1)] of TComputerGroup;
  CompGroupsCount: integer = 0;   // текущее количество групп

  CompsSelCount: integer = 0; // количество выделенных в списке компов
  CompsSel: array[0..(MAX_COMPUTERS-1)] of integer; // выделенные в списке компы

  CurOperatorName: string; // текущий оператор
  isManager: boolean;      // текущий юзер - менеджер!
  OperatorSecLevel: integer;      // Уровень допуска текущего пользователя
  IntTimeShift: TDateTime; // сдвиг между временем сервера и локальным
  IntTimeShiftReset: TDateTime; // время без дополнительных сдвигов
  CurServer: string; //нигде не используется

  Console : TConsole;

  OperatorProfile: TOperatorProfile; // настройки текущего оператора

//  udpServer: TIdUDPServer;
//  udpClient: TIdUDPClient;
  icmpClient: TIdICMPClient;
  GnCyclicCompActionCounter: Integer;
  GnFileSynchronizationCounter: Integer;

  FMappings: TMappings;
  FProxy: TProxy;

//  FGuardStrings: THighGuardStrings;
  GnMinPenalty: Integer; //глобальный параметр :(( а че делать?!?!

  GbInexpensiveTarifVariantNotExistsMessageShowed: Boolean;
  GbUnregisteredLinuxClinentMessageShowed: Boolean;

  GnClientScriptFileCheckSum: Int64 = 0;
  GnClientInstallFileCheckSum: Int64 = 0;
  GnServerFileCheckSum: Int64 = 0;

implementation

uses
  frmMain,
  Windows,
  GCFunctions,
  uAccountSystem,
//  Graphics,
  Math,
  uClientOptions,
  uY2KCommon,
  uOptionGetRemoteCommand,
  Types,
  Forms,
  ShellAPI,
  uVirtualTime,
  uAccountsRecord,
  uRegistry,
  uRegistryInterface,
  uRegistryScripts,
  uServerScripting,
  udmActions,
  uProtocol,
  uTariffication,
  uRegistration,
  uKKMTools, DBGridEh,
  uDebugLog, uSnmp,
  gcsystem;

const
  UNREGISTERED_LINUX_CLIENTS_1 =
      'Количество подключенных Linux-компьютеров больше,'
      + ' чем указано в Вашей лицензии.'#13#10
      + 'Вы обладаете лицензией на контроль ';
  UNREGISTERED_LINUX_CLIENTS_2 =
      ' компьютеров по управлением ОС Linux.'#13#10
      + 'Вам необходима лицензия на большее количество компьютеров.'#13#10
      + 'Более подробная информация находится на сайте http://www.gameclass.ru';


constructor TOperatorProfile.Create;
begin
  Reset;
end;

constructor TMappings.Create;
begin
  count := 0;
  SetLength(LMappings, count);
end;

procedure TMappings.Load;
var
  dts: TADODataSet;
begin
  if (Not dsConnected) then exit;

  dts := TADODataSet.Create(nil);
  dsDoQuery(DS_MAPPINGS_SELECT, @dts);

  count := 0;
  SetLength(LMappings,count);
  while (not dts.Recordset.EOF) do begin
    inc(count);
    SetLength(LMappings,count);
    LMappings[count-1].id := dts.Recordset.Fields.Item['id'].Value;
    LMappings[count-1].listenport := dts.Recordset.Fields.Item['listenport'].Value;
    LMappings[count-1].mappedport := dts.Recordset.Fields.Item['mappedport'].Value;
    LMappings[count-1].mappedip := dts.Recordset.Fields.Item['mappedip'].Value;
    dts.Recordset.MoveNext;
  end;
  dts.Close;
  dts.Destroy;
end;

procedure TMappings.Add(listenport,mappedport:word; mappedip:string);
begin
  // запихнуть в базу маппинг
  dsDoCommand(DS_MAPPINGS_ADD + ' @listenport='+IntToStr(listenport)+', @mappedport='+IntToStr(mappedport)+', @mappedip=N'''+ mappedip+'''');
end;

procedure TMappings.Delete(id: word);
begin
  dsDoCommand(DS_MAPPINGS_DELETE + ' @id='+IntToStr(id));
end;

procedure TOperatorProfile.Reset;
begin
  bShowTechCompsInfo := false;
  formMain.gridComps.Columns.Items[0].Width := 14;
  formMain.gridComps.Columns.Items[1].Width := 75;
  formMain.gridComps.Columns.Items[2].Width := 80;
  formMain.gridComps.Columns.Items[3].Width := 100;
  formMain.gridComps.Columns.Items[4].Width := 110;
  formMain.gridComps.Columns.Items[5].Width := 55;
  formMain.gridComps.Columns.Items[6].Width := 55;
  formMain.gridComps.Columns.Items[7].Width := 65;
  formMain.gridComps.Columns.Items[8].Width := 75;
  formMain.gridComps.Columns.Items[9].Width := 75;
  formMain.gridComps.Columns.Items[10].Width := 75;
  formMain.gridComps.Columns.Items[11].Width := 75;
  formMain.gridComps.Columns.Items[12].Width := 150;
//  formMain.gridComps.Columns.Items[11].AutoFitColWidth := True;
  formMain.mnuPanelRunPad.Checked := False;
  SetBackColor(clWindow);
  SetTableFont(formMain.Font);
  ComputerListBlockedFont := formMain.Font;
  ComputerListNotBusyFont := formMain.Font;
  ComputerListAuthenticatedFont := formMain.Font;
  ComputerListReserveFont := formMain.Font;
  ComputerListAccupiedFont := formMain.Font;
  ComputerListPreventedFont := formMain.Font;

end;

// загружаем опции оператора из базы
procedure TOperatorProfile.Load;
var
   i: Integer;
   ColumnId: Integer;
begin
  bShowTechCompsInfo := GRegistry.UserInterface.ShowCopmTechInfo;
  ComputerListBlockedFont := GRegistry.UserInterface.BlockedFont;
  ComputerListNotBusyFont := GRegistry.UserInterface.NotBusyFont;
  ComputerListAuthenticatedFont := GRegistry.UserInterface.AuthenticatedFont;
  ComputerListReserveFont := GRegistry.UserInterface.ReserveFont;
  ComputerListAccupiedFont := GRegistry.UserInterface.AccupiedFont;
  ComputerListPreventedFont := GRegistry.UserInterface.PreventedFont;
  formMain.mnuPanelRunPad.Checked := GRegistry.UserInterface.ShowRunPadPanel;

// Загружаем из реестра ГК настройки колонок gridComps, колонки ищутся не по индексу а по содержимому FieldName
  for i:=0 to formMain.gridComps.Columns.Count-1 do
  begin
    ColumnId := GetIdColumnByFieldName(
                  formMain.gridComps,GRegistry.UserInterface.ColumnFieldName[i]);
    if ColumnId > -1 then
    begin
      formMain.gridComps.Columns.Items[ColumnId].Width :=
        GRegistry.UserInterface.ColumnWidth[i];
      formMain.gridComps.Columns.Items[ColumnId].Index := i;
    end;
  end;

  SetBackColor(GRegistry.UserInterface.BackColor);
  SetTableFont(GRegistry.UserInterface.TableFont);
  DoInterface; // TOperatorProfile.
end;

// сохраняем опции оператора в базе
procedure TOperatorProfile.Save;
var
   s: string;
   i: Integer;
begin
  GRegistry.UserInterface.ShowRunPadPanel := formMain.mnuPanelRunPad.Checked;
  GRegistry.UserInterface.ShowCopmTechInfo := bShowTechCompsInfo;
  for i:=0 to formMain.gridComps.Columns.Count-1 do
  begin
    GRegistry.UserInterface.ColumnWidth[i] :=
        formMain.gridComps.Columns.Items[i].Width;
    GRegistry.UserInterface.ColumnFieldName[i] :=
        formMain.gridComps.Columns.Items[i].FieldName;
  end;
end;

procedure TOperatorProfile.DoInterface;
var
  n: integer;
begin
  if (bShowTechCompsInfo and not isManager) then n:=WIDTH_COMPINFO_WINDOW else n:=0;
  formMain.memoClientInfo.Width := n;
  formMain.mnuClientInfo.Enabled := not isManager;
  formMain.mnuClientInfo.Checked := OperatorProfile.bShowTechCompsInfo;
  formMain.tbRunPad.Visible := formMain.mnuPanelRunPad.Checked;
end;

constructor TComputer.Create;
begin
  control := false; // по умолчанию комп контролируется :)
//  busy := false;   // по умолчанию комп свободен :)
  bStopSession := false;
  pings := 0;      // по умолчанию пингуется в норме!
  IdGroup := 0;    // default not VIP
  st := TStringList.Create;
  st.Text := '';
  session := nil;
  FbPingable := true; // по умолчанию комп контролируется :)
  FbWarnedTime := false; 
  FnIcmpPings := 0;      // по умолчанию пингуется в норме!

  strInfoWinver := '...'; // версия виндовс на машине
  strInfoClientver := '...'; // версия GC3 клиента на машине
  strInfoFreespaceC := '...'; // свободно места на диске С
  strInfoFreespaceD := '...'; // свободно места на диске D
  ScriptCheckSumm := 0;
  InstallCheckSumm := 0;
  FbLinuxClient := False;

  //теперь по умолчанию можно логиниться если разрешена аутентификация
  if GAccountSystem.Enabled and
     GAccountSystem.AlwaysAllowAuthentication then
     a.state := ClientState_Authentication
  else
     a.state := ClientState_Blocked;
  a.number := -1;
//  a.name := asys.GetNameByNumber(0);
//  a.balance := 0;
  a.secCode := 0;
  if (GAccountSystem.UseSecurityCodes) then a.secCode := random(20)+1;
  a.nFailedAuthentication := 0;
end;


function TComputer.GetStrNumber:string;
var
  str:string;
begin
  str := IntToStr(number);
  GetStrNumber := str;
end;

// выдача краткой инфы на табло клиента на время когда комп свободен
function TComputer.GetInfo:string;
begin
//  GetInfo := optClient.sInfo;
//  STUB();
    GetInfo := GetInfoFull;
end;

// выдача полной инфы на табло клиента в первые 10 сек после завершения и в систрее во время работы
function TComputer.GetInfoFull:string;
var
  tempMoney: double;
  strTraffic: String;
begin
  st.Clear;
  GetInfoFull := st.Text;
  if ((session <> nil) and busy) then begin
    st.Add(translate('Client') + ': ' + session.GetStrClient);
    st.Add(translate('Tarif') + ': ' + session.GetStrTarif);
    st.Add(translate('Start') + ': ' + TimeToStr(session.TimeStart));
//    st.Add(translate('End') + ': ' + TimeToStr(GetVirtualTime));
      st.Add(translate('End') + ': ' + TimeToStr(session.TimeStop));
    //---
    st.Add(translate('frmCompStop1')
        + TimeToStr(GetVirtualTime-session.Started) + ' ) = '
        + FormatFloat('0.00',session.GetCostTime) + ' '
        + GRegistry.Options.Currency);
    if (session.PrintCost > 0 ) then
      st.Add(translate('frmCompStop2')
          + translate('frmCompStop3')
          + FloatToStr(session.PrintCost) + ' '
          + GRegistry.Options.Currency);
    if (session.ServiceCost > 0 ) then
      st.Add(translate('frmCompStop8')
          + FloatToStr(session.ServiceCost) + ' '
          + GRegistry.Options.Currency);
    if (session.CurrentTraffic > 0 ) then begin
      strTraffic := translate('frmCompStop4') + session.GetStrTraffic+' )';
      if (session.CurrentSeparateTrafficLimit = 0 ) then
        strTraffic := strTraffic + ' = '
            + FormatFloat('0.00',session.GetCostTraffic) + ' '
            + GRegistry.Options.Currency;
      st.Add(strTraffic);
    end;
    st.Add(translate('frmCompStop7') + TimeToStr(session.TimeStop
        - GetVirtualTime));
    st.Add(translate('frmCompStop5') + FormatFloat('0.00',session.GetCostTotal)
        + ' ' + GRegistry.Options.Currency);
    // дальше в зависимости от того, была ли предоплата или нет
    // но для карточек дальнейшее не актуально
    if (a.number = 0) then begin
       if (Not session.PostPay) then
         st.Add(translate('frmCompStop6') + FormatFloat('0.00',session.CommonPay)
            + ' ' + GRegistry.Options.Currency);

{       if session.PostPay then
         tempMoney := - session.GetCostTotal
       else
         tempMoney := session.CommonPay - session.GetCostTotal;

      if (tempMoney > 0)
          and (Session.IdClient = 0) //Для клиентов ВСЕГДА дается скидка
          and GRegistry.Options.DisableChange then
        tempMoney := 0;}
       tempMoney := Session.Change;
       if (tempMoney >=0) then
         st.Add(translate('CompStopActionMoneyBackClient') + ': '
            + FormatFloat('0.00',tempMoney) + ' ' + GRegistry.Options.Currency)
       else
         st.Add(translate('CompStopActionMoneyGetClient') + ': '
            + FormatFloat('0.00',-tempMoney) + ' ' + GRegistry.Options.Currency);
    end;

    GetInfoFull := st.Text;
    //
  end;
end;


function TComputer.GetBusy: Boolean;
begin
  Result := False;
  if (session <> Nil) and (session.Status = ssActive) then
    Result := True;
end; //function TComputer.GetBusy: Boolean;

function TComputer.IsGuestSession: Boolean;
begin
  Result := False;
  if (session <> Nil)
      and (session.Status = ssActive)
      and (session.IsGuest) then
    Result := True;
end; //function TComputer.IsOperatorSession: Boolean;

function TComputer.IsFree: Boolean;
begin
  Result := (session = Nil);
end;

function TComputer.GetReserved: Boolean;
begin
  Result := False;
  if (session <> Nil) and (session.Status = ssReserve) then
    Result := True;
end; //function TComputer.GetReserved: Boolean;


function TComputer.GetRealyPingable: Boolean;
begin
  Result := (strInfoWinver <> '...') and Pingable;
end; //function TComputer.GetRealyPingable: Boolean;

function TComputer.IsLikely(const AAction: TComputerAction): Boolean;
var
  computer: TComputer;
begin
  Result := False;
  case AAction of
    caStart:
      Result := (CompsSelCount > 0) and IsFree
          and (idGroup = Comps[ComputersGetIndex(CompsSel[0])].IdGroup);
    caReserve:
      Result := (CompsSelCount > 0)
          and (idGroup = Comps[ComputersGetIndex(CompsSel[0])].IdGroup);
    caStop:
      if (CompsSelCount > 0) then begin
        computer := Comps[ComputersGetIndex(CompsSel[0])];
        Result := computer.Busy and Busy
            and (GRegistry.UserInterface.MultiActionsFullControl
            or (session.TimeStart
            = Comps[ComputersGetIndex(CompsSel[0])].session.TimeStart));
      end;
    caAdd:
      if (CompsSelCount > 0) then begin
        computer := Comps[ComputersGetIndex(CompsSel[0])];
        Result := computer.Busy and Busy
            and (GRegistry.UserInterface.MultiActionsFullControl
            or (session.TimeStart
            = Comps[ComputersGetIndex(CompsSel[0])].session.TimeStart))
            and session.IsGuest
            and not session.PostPay
            and not session.IsPacketTarif
            and not (session.IdTarif = ID_TARIF_REMONT);
      end;
  end;
end; //function TComputer.GetRealyPingable: Boolean;

constructor TClient.Create;
begin
  id := 0;
  name := '';
end;

// функция вычисляет количество секунд ваще, ВАЩЕ В СУММЕ!
function TotalSeconds(length: TDateTime):longword;
begin
//  TotalSeconds := HourOf(length)*3600 + MinuteOf(length)*60 + SecondOf(length);
// Неправильно считает
//  Result := MinutesBetween(0,length)*60 + SecondOf(length);
  Result := Round(length*24*60*60);
end;


procedure SendAllOptionsToClient(index: integer);
var
  dt: TDateTime;
  sdb, curtime: string;
  cmd: TOptionGetRemoteCommand;
  strParm: string;
  ClientState: integer;
begin
  // Если комп не пингуется то выходим
  if not Comps[index].IcmpPingable then exit;
  if Comps[index].ClientType = CT_GAMECLASS then
  begin
    if (GClientOptions.SyncTime) then begin
      dt := GetVirtualTime;
      curtime := IntToStr(YearOf(dt)) + '/' + IntToStr(MonthOf(dt)) + '/'
        + IntToStr(DayOf(dt)) + '/' + IntToStr(HourOf(dt)) + '/'
        + IntToStr(MinuteOf(dt)) + '/' + IntToStr(SecondOf(dt));
      UDPSend(Comps[index].ipaddr, STR_CMD_SETTIME + '='
        + curtime);
    end;
    cmd := TOptionGetRemoteCommand.Create('all',Comps[index].ipaddr);
    cmd.Execute;
    SendAccountAndSessionInfoToClient(index);
  end;
  if Comps[index].ClientType = CT_SNMP then
  begin
    if  ((Comps[index].busy = true) and (Comps[index].session<>Nil)) then
      ClientState:=1
    else
      ClientState:=0;
    SetSnmpIntegerValue(Comps[Index],ClientState);
  end;
end;

procedure SendAccountAndSessionInfoToClient(AnComputerIndex: Integer);
var
  sdb, curtime, strParm: string;
  CompMainVolume,CompWaveVolume:integer;
  CompMuteVolume,CompOnlyLimitVolume:Boolean;
begin
  strParm := '';

  if GRegistry.Volume[AnComputerIndex + 1].Custom then
  begin
    CompMainVolume := GRegistry.Volume[AnComputerIndex + 1].Main;
    CompWaveVolume := GRegistry.Volume[AnComputerIndex + 1].Wave;
    CompMuteVolume := GRegistry.Volume[AnComputerIndex + 1].Mute;
  end else begin
    CompMainVolume := GRegistry.Volume[0].Main;
    CompWaveVolume := GRegistry.Volume[0].Wave;
    CompMuteVolume := GRegistry.Volume[0].Mute;
  end;
  CompOnlyLimitVolume := GRegistry.Volume.OnlyLimit;
  if Comps[AnComputerIndex].Busy then
    if Comps[AnComputerIndex].session.Tariff.forcedvolume>=0 then
    begin
      CompMainVolume := round((VOLUME_MAX *Comps[AnComputerIndex].session.Tariff.forcedvolume)/100);
      CompWaveVolume := round((VOLUME_MAX *Comps[AnComputerIndex].session.Tariff.forcedvolume)/100);
      if CompMainVolume=0 then
        CompMuteVolume := true
      else
        CompMuteVolume := False;
      CompOnlyLimitVolume := False;
    end;

   strParm := strParm +
              IntToStr(CompMainVolume)+'/'+
              IntToStr(CompWaveVolume)+'/'+
              IfThen(CompMuteVolume,'1','0');

   strParm := strParm + '/' + IfThen(CompOnlyLimitVolume,'0','1');

  UDPSend(Comps[AnComputerIndex].ipaddr,STR_CMD_SETVOLUME + '=' + strParm);

  with Comps[AnComputerIndex] do begin
    UDPSend(ipaddr, STR_CMD_CLIENT_INFO_SET + '='
        + 'ClientState'
        + '/' + IntToStr(GetClientState(AnComputerIndex)));
    UDPSend(ipaddr, STR_CMD_CLIENT_INFO_SET + '='
        + 'SecCode'
        + '/' + IntToStr(a.secCode));
    if (session <> Nil) or (a.state = ClientState_Order) then begin
      UDPSend(ipaddr, STR_CMD_CLIENT_INFO_SET + '='
          + 'Login'
          + '/' + GetAccountName(a));
          UDPSend(ipaddr, STR_CMD_CLIENT_INFO_SET + '='
            + 'Balance'
            + '/' + FloatToStr(GetAccountBalance(a)));
      if GRegistry.Client.ShowSumm then
          UDPSend(ipaddr, STR_CMD_CLIENT_INFO_SET + '='
            + 'Spent'
            + '/' + FloatToStr(GetAccountSummary(a)))
        else
          UDPSend(ipaddr, STR_CMD_CLIENT_INFO_SET + '='
            + 'Spent/0');

      UDPSend(ipaddr, STR_CMD_CLIENT_INFO_SET + '='
          + 'BalanceLimit'
          + '/' + FloatToStr(GetAccountBalanceLimit(a)));
    end;
    if session <> Nil then begin
      if (a.number <> 0) then
        UDPSend(ipaddr, STR_CMD_CLIENT_INFO_SET + '='
            + 'BalanceHistory' + '/'
            + GAccountSystem.Accounts[a.number].History);
      UDPSend(ipaddr, STR_CMD_INFO + '=' + GetInfo);
      UDPSend(ipaddr, STR_CMD_INFO_FULL + '=' + GetInfoFull);
      UDPSend(ipaddr, STR_CMD_CLIENT_INFO_SET + '='
          + 'Sum'
          + '/' + FloatToStr(session.GetPayedCurrent));
      UDPSend(ipaddr, STR_CMD_CLIENT_INFO_SET + '='
          + 'Start'
          + '/' + DateTimeToStr(session.TimeStart));
      UDPSend(ipaddr, STR_CMD_CLIENT_INFO_SET + '='
          + 'Stop'
          + '/' + DateTimeToStr(session.TimeStop));
      UDPSend(ipaddr, STR_CMD_CLIENT_INFO_SET + '='
          + 'Now'
          + '/' + DateTimeToStr(GetVirtualTime));
      UDPSend(ipaddr, STR_CMD_CLIENT_INFO_SET + '='
          + 'TarifName'
          + '/' + session.GetStrTarif);
      UDPSend(ipaddr, STR_CMD_CLIENT_INFO_SET + '='
          + 'TrafficSeparatePayment'
          + '/' + BoolToStr(session.IsTrafficSeparatePayment));
      UDPSend(ipaddr, STR_CMD_CLIENT_INFO_SET + '='
          + 'Internet'
          + '/' + BoolToStr(session.IsInternet));
      UDPSend(ipaddr, STR_CMD_CLIENT_INFO_SET + '='
          + 'InternetAvailableInKB'
          + '/' + IntToStr(Round(session.CurrentSeparateTrafficLimit / 1024)));
      UDPSend(ipaddr, STR_CMD_CLIENT_INFO_SET + '='
          + 'InternetUsedInKB'
          + '/' + IntToStr(Round(session.CurrentTraffic / 1024)));
      UDPSend(ipaddr, STR_CMD_CLIENT_INFO_SET + '='
          + 'RunPadHidedTabs' + '/'
          + GClientOptions.GetRunPadHidedTabs(session.ShortTarifName).Text);
    end else begin
      UDPSend(ipaddr, STR_CMD_CLIENT_INFO_SET + '='
          + 'Stop'
          + '/' + DateTimeToStr(FIRST_DATE));
    end;
  end;
end;

constructor TConsole.Create;
begin
 //
end;

procedure TConsole.AddEvent(event_type: integer; level: integer; str: string);
var
  li: TListItem;
  strSQLCode: String;
begin
  li := formMain.lvConsole.Items.Add;
  li.Caption := str;
  li.ImageIndex := event_type;
  // в зависимости от level писать в базу
  if (level=0) or (level=1) then
  begin
    strSQLCode := DS_LOGS_INSERT + ' @prioritet=' + IntToStr(level) + ', @message=N'''
        + str + ''', @moment=''' + DateTimeToSql(GetVirtualTime) + '''';
    try
      dsDoCommand(strSQLCode);
    except
    end;
    if dsConnected and (GRegistry<>Nil)
        and GRegistry.UserInterface.SwitchToGC3Win then
      formMain.RestoreMainForm;
  end;
  formMain.lvConsole.Scroll(0,100);
  Application.ProcessMessages;
end;

// процедура ищет по имени тариф возвращает True и параметры если находит
// возвращает индекс тарифа, индекс подтарифа, признак пакета
function GetTarifByName(AstrTarifName: String;
    var AnTarifIndex: Integer; var AnTarifVariantIndex: Integer;
    var AbIsPacketTarif: Boolean):Boolean;
var
  i,j: integer;
begin
  Result := False;
  for i:=1 to (TarifsCount-1) do
  begin
    if (AstrTarifName = Tarifs[i].name) then begin
      AnTarifIndex := i;
      AnTarifVariantIndex := 0;
      AbIsPacketTarif := False;
      Result := True;
      exit;
    end;
    for j:=0 to Tarifs[i].variantscount-1 do
      if (Tarifs[i].tarifvariants[j].IsAvailable(GetVirtualTime)) then
        if (AstrTarifName = (Tarifs[i].name + '-' + Tarifs[i].tarifvariants[j].name)) then begin
          AnTarifIndex := i;
          AnTarifVariantIndex := j;
          AbIsPacketTarif := True;
          Result := True;
          exit;
        end;
  end;
end;

// процедура рассчитывает по имени тарифа стоимость и время
// возвращает True если все получилось
// возвращает стоимость, продолжительность и начало сеанса
function CalculateTarif(AstrTarifName: String;
    var AdtStart: TDateTime; var AdtTime: TDateTime;
    var AfSum: Double; AbCalcBySum: Boolean;
    AnComputerIndex: Integer; AnDiscount: Integer):Boolean;
var
  nTarifIndex: Integer;
  nTarifVariantIndex: Integer;
  bIsPacketTarif: Boolean;
  dtStop: TDateTime;
  dtStart: TDateTime;
  TarifVariant: TTarifVariants;
  nComputerGroup: Integer;
begin
  Result := False;
  // если есть вообще такой тариф
  if GetTarifByName(AstrTarifName, nTarifIndex, nTarifVariantIndex,
      bIsPacketTarif) then begin
    nComputerGroup := Comps[AnComputerIndex].IdGroup;
    if (bIsPacketTarif) then begin
      // цельный интервал - Стоимость/Начало/Конец
      TarifVariant := Tarifs[nTarifIndex].tarifvariants[
          nTarifVariantIndex];
      if TarifVariant.FreePacket then begin
        dtStart := GetVirtualTime;
        dtStop := dtStart + TimeOf(TarifVariant.start);
      end else begin
        dtStop := DateOf(AdtStart) + TimeOf(TarifVariant.stop);
        dtStart := DateOf(AdtStart) + TimeOf(TarifVariant.start);
        if (TimeOf(TarifVariant.start) > TimeOf(TarifVariant.stop)) then begin
          if (TimeOf(AdtStart) > TimeOf(TarifVariant.start)) then
            dtStop := IncDay(dtStop, 1)
          else
            dtStart := IncDay(dtStart, -1)
        end;
      end;
      AdtStart := dtStart;
      AfSum := TarifVariant.cost;
      if GRegistry.AccountSystem.DiscountForPacketsEnabled then
        AfSum := Tarifs[nTarifIndex].CorrectedMoney(TarifVariant.cost,
        AnDiscount);
    end else begin
      // простой интервал - Начало/Конец/0
      if (AbCalcBySum) then begin
        //это продолжительность
        dtStop := Tarifs[nTarifIndex]
            .CalculateTimeLength(
            AdtStart, AfSum, nComputerGroup,
            AnDiscount);
        //теперь это время останова
        dtStop := AdtStart + dtStop;
      end else begin
        dtStop := AdtStart + TimeOf(AdtTime);
        AfSum := Tarifs[nTarifIndex].CalculateCost(
            AdtStart, dtStop, nComputerGroup,
            AnDiscount, True, True, 0);
        // нужно пересчитать правильный конец сессии
        dtStop := AdtStart
            + Tarifs[nTarifIndex].CalculateTimeLength(AdtStart,
            AfSum, nComputerGroup, AnDiscount);
      end;
      if (dtStop > GSessions.GetMaxStopTime(Comps[AnComputerIndex].Id)) then begin
        dtStop := GSessions.GetMaxStopTime(Comps[AnComputerIndex].Id);
        AfSum := Tarifs[nTarifIndex].CalculateCost(
            AdtStart, dtStop, nComputerGroup,
            AnDiscount, True, True, 0);
      end;
      if (dtStop < AdtStart) then
        dtStop := IncDay(dtStop,1);
    end;
    AdtTime := dtStop - AdtStart;
    Result := True;
  end;
end; // CalculateTarif

function TarifsGetId(name: string): longword;
var
  i:integer;
  res: boolean;
begin
  res := false;
  TarifsGetId := 0;
  for i:=0 to (TarifsCount-1) do 
    if (Tarifs[i].name = name) then
    begin
      res := true;
      TarifsGetId := Tarifs[i].id;
      break;
    end;
  if (res = false) then
  begin
    Console.AddEvent(EVENT_ICON_ERROR, LEVEL_ERROR, 'TarifsGetId: Lost name of tarif');    
    formGCMessageBox.memoInfo.Text := translate('HighCryticalError');
    formGCMessageBox.SetDontShowAgain(false);
    formGCMessageBox.ShowModal;
{$IFOPT D-}
    dmActions.actExit.Execute;
{$ENDIF}
  end;
end;

function TarifsGetIndex(id: longword): integer;
var 
  i:integer;
  res: boolean;
begin
  res := false;
  TarifsGetIndex := -1;
  for i:=0 to (TarifsCount-1) do
    if (Tarifs[i].id = id) then
    begin
      res := true;
      TarifsGetIndex := i;
      break;
    end;
  if (res = false) then
  begin
    Console.AddEvent(EVENT_ICON_ERROR, LEVEL_ERROR,
        'TarifsGetIndex: Lost id of tarif');
{$IFOPT D-}
    formGCMessageBox.memoInfo.Text := translate('HighCryticalError');
    formGCMessageBox.SetDontShowAgain(false);
    formGCMessageBox.ShowModal;
    dmActions.actExit.Execute;
{$ENDIF}
  end;
end;


function ComputersGetIndex(id:longword):integer;
var
  i: integer;
  res: boolean;
begin
  res := false;
  ComputersGetIndex := -1;
  for i:=0 to CompsCount-1 do
    if (Comps[i].id = id) then
    begin
      res := true;
      ComputersGetIndex := i;
      break; 
    end;  
  if (res = false) then
  begin
    Console.AddEvent(EVENT_ICON_ERROR, LEVEL_ERROR, 'ComputersGetIndex: Lost id of computer');
    formGCMessageBox.memoInfo.Text := translate('HighCryticalError');
    formGCMessageBox.SetDontShowAgain(false);
    formGCMessageBox.ShowModal;
{$IFOPT D-}
    dmActions.actExit.Execute;
{$ENDIF}
  end;
end;

function ComputersCheckIndex(id:longword):Boolean;
var
  i: integer;
begin
  ComputersCheckIndex := False;
  for i:=0 to CompsCount-1 do
    if (Comps[i].id = id) then begin
      ComputersCheckIndex := True;
      break;
    end;
end;

function ComputersGetIndexByIp(ip:string):integer;
var
  i: integer;
  res: boolean;
begin
  res := false;
  ComputersGetIndexByIp := -1;
  for i:=0 to CompsCount-1 do
    if (Comps[i].ipaddr = ip) then
    begin
      res := true;
      ComputersGetIndexByIp := i;
      break;
    end;
 { if (res = false) then
  begin
    Console.AddEvent(EVENT_ICON_ERROR, LEVEL_ERROR, 'ComputersGetIndexByIp: unknown sender-ip ('+ip+')!');
    //formGCMessageBox.memoInfo.Text := translate('HighCryticalError');
    //formGCMessageBox.SetDontShowAgain(false);
    //formGCMessageBox.ShowModal;
    //DoEvent(FN_EXIT);
  end;}
end;

function ComputerGroupsGetName(AnId: Integer):String;
var
  i: integer;
  res: boolean;
begin
  ComputerGroupsGetName := '';
  if (AnId = -1) then
    ComputerGroupsGetName := translate('CommonComputers')
  else
    for i:=0 to CompGroupsCount-1 do
      if (CompGroups[i].Id = AnId) then begin
        ComputerGroupsGetName := CompGroups[i].Name;
        break;
      end;
end;





function GetTarifNames: TStringList;
var
  i,j: integer;
  lstTarifNames: TStringList;
begin
  Result := Nil;
  lstTarifNames := TStringList.Create;
  for i:=1 to (TarifsCount-1) do
  begin
    lstTarifNames.Add(Tarifs[i].name);
    for j:=0 to Tarifs[i].variantscount-1 do
      if Tarifs[i].tarifvariants[j].ispacket then
        lstTarifNames.Add(Tarifs[i].name + '-'
            + Tarifs[i].tarifvariants[j].name);
  end;
  Result := lstTarifNames;
end;

function GetTarifName(AnTarifId,AnWhole:Integer): string;
begin
  if (AnTarifId = ID_TARIF_REMONT) then
    GetTarifName := translate('subRemont')
  else
  begin
    if (AnWhole = 0) then
      GetTarifName := Tarifs[TarifsGetIndex(AnTarifId)].name
    else
      GetTarifName := Tarifs[TarifsGetIndex(AnTarifId)].name + '-' + Tarifs[TarifsGetIndex(AnTarifId)].GetWholeNameByIndex(AnWhole);
  end;
end;

//возвращает True если время попадает в интервал
function IsBetween(AdtMoment, AdtStart, AdtEnd: TDateTime):Boolean;
begin
  IsBetween := False;
  If (AdtStart < AdtEnd) and (AdtStart <= AdtMoment) and (AdtEnd >= AdtMoment) then
    IsBetween := True;
  If (AdtStart > AdtEnd) and ((AdtMoment >= AdtStart) and (AdtMoment >= AdtEnd)) then
    IsBetween := True;
  If (AdtStart > AdtEnd) and ((AdtMoment <= AdtStart) and (AdtMoment <= AdtEnd)) then
    IsBetween := True;
  If (AdtStart = AdtEnd) then
    IsBetween := True;
end;

procedure CompStop(AnComputerIndex: Integer);
begin
// стоп для компа (TODO Вынести позже в элемент коллекции TComputer)
  Comps[AnComputerIndex].timeStopSession := GetVirtualTime;
  Comps[AnComputerIndex].bStopSession := true;
  Comps[AnComputerIndex].session := nil;
  if isManager then exit;
  // traffic
  if Comps[AnComputerIndex].ClientType = CT_GAMECLASS then
  begin
    if GRegistry.Modules.Internet.SummaryControl then
      FProxy.IPDisable(Comps[AnComputerIndex].ipaddr);
    if (Comps[AnComputerIndex].a.state <> ClientState_Session)
      and (Comps[AnComputerIndex].a.state <> ClientState_Order) then begin
      QueryAuthGoState1(AnComputerIndex);
    end;
    if (Comps[AnComputerIndex].a.state = ClientState_Session) then
      // Случай для автоостанова карточек
      SendAuthGoState2(AnComputerIndex);
  end;
  if Comps[AnComputerIndex].ClientType = CT_SNMP then
  begin
    Comps[AnComputerIndex].a.state := ClientState_Blocked;
    { TODO : '0' to gccons.pas }
    SetSnmpIntegerValue(Comps[AnComputerIndex],0);
  end;

end;

function GetClientState(AnComputerIndex: Integer): Integer;
var
  nClientState :Integer;
begin
  nClientState := 0; //Blocked
  if (Comps[AnComputerIndex].a.state = ClientState_Authentication)
      and Comps[AnComputerIndex].Reserved then
    Comps[AnComputerIndex].a.state := ClientState_Blocked;
  GetClientState := Integer(Comps[AnComputerIndex].a.state);
end;

function GetAccountName(const AAuthorization: TAuthorization): String;
begin
  if (AAuthorization.number <> 0) then
    Result := GAccountSystem.Accounts[AAuthorization.number].Name
  else
    Result := translate('Guest');
{  Result := asys.GetNameByNumber(AAuthorization.number);
  if (AAuthorization.number <> 0) then begin
    Result := asys.accounts[asys.GetIndexByNumber(AAuthorization.number)].name;
  end;
  }
end;

function GetAccountBalance(const AAuthorization: TAuthorization): Double;
begin
  Result := 0;
  if (AAuthorization.number <> 0) then begin
    Result := GAccountSystem.Accounts[AAuthorization.number].Balance;
  end;
end;

function GetAccountSummary(const AAuthorization: TAuthorization): Double;
begin
  Result := 0;
  if (AAuthorization.number <> 0) then begin
    Result := GAccountSystem.Accounts[AAuthorization.number].Summary ;
  end;
end;

function GetAccountBalanceLimit(const AAuthorization: TAuthorization): Double;
begin
  Result := 0;
  if (AAuthorization.number <> 0) then begin
    Result := GAccountSystem.Accounts[AAuthorization.number].LimitBalance;
  end;
end;

procedure CompsSelDeselect(const AAction: TComputerAction);
var
  i,j: Integer;
begin
  j := 0;
  for i := 0 to CompsSelCount-1 do
    if Comps[ComputersGetIndex(CompsSel[i])].IsLikely(AAction) then begin
      CompsSel[j] := CompsSel[i];
      Inc(j);
    end;
  CompsSelCount := j;
end; // SelCompsDeselect

function CompsSelIsLikely(const AAction: TComputerAction): Boolean;
var
  i: Integer;
begin
  Result := True;
  for i := 0 to CompsSelCount-1 do
    if not Comps[ComputersGetIndex(CompsSel[i])].IsLikely(AAction) then
      Result := False;
end; // CompsSelIsLikely

function SelCompsAsText: String;
var
  i: Integer;
begin
  Result := '';
  for i:=0 to CompsSelCount-1 do
    Result := Result + Comps[ComputersGetIndex(CompsSel[i])].GetStrNumber
        + ', ';
  if Length(Result)>0 then
    SetLength(Result, Length(Result)-2);
end; // SelCompsAsText

function TComputer.Agreement: Boolean;
begin
  Result := False;
  if (session <> Nil) and (session.Status = ssActive)
      and ((session.State = ClientState_Agreement)
      or (session.State = ClientState_OperatorAgreement)) then
    Result := True;
end; //function TComputer.Agreement: Boolean;

function TComputer.PowerOff: Boolean;
var
  Result_loc: Boolean;
begin
  Result_loc := False;
  try
    if LinuxClient then
      UDPSend(ipaddr,STR_CMD_SHUTDOWN)
    else
      if GRegistry.ControlCommands.WindowsShutdownCommand = '' then
        UDPSend(ipaddr,STR_CMD_SHUTDOWN)
      else
        UDPSend(ipaddr,STR_CMD_EXECUTE_COMMAND_SRV + '=' + GRegistry.ControlCommands.WindowsShutdownCommand);
    Result_loc := true;
  except
    Debug.Trace1('Shutdown error :' + ipaddr);
  end;
  Result := result_loc;
end;

function TComputer.PowerOn: Boolean;
var
  Result_loc: Boolean;
begin
  Result_loc := False;
  try
    WakeUPComputer(macaddr);
    Result_loc := true;
  except
    Debug.Trace1('WakeOnLan error :' + ipaddr + ' ' + macaddr);
  end;
  Result := result_loc;
end;

function TComputer.Reboot: Boolean;
var
  Result_loc: Boolean;
begin
  Result_loc := False;
  try
    if LinuxClient then
      UDPSend(ipaddr,STR_CMD_RESTART + '=' + BoolToStr(True))
    else
      if GRegistry.ControlCommands.WindowsRebootCommand = '' then
        UDPSend(ipaddr,STR_CMD_RESTART + '=' + BoolToStr(True))
      else
        UDPSend(ipaddr,STR_CMD_EXECUTE_COMMAND_SRV + '=' + GRegistry.ControlCommands.WindowsRebootCommand);
    Result_loc := true;
  except
    Debug.Trace1('Reboot error :' + ipaddr);
  end;
  Result := result_loc;
end;

function TComputer.LogOff: Boolean;
var
  Result_loc: Boolean;
begin
  Result_loc := False;
  try
    if LinuxClient then
      UDPSend(ipaddr,STR_CMD_RESTART + '=' + BoolToStr(False))
    else
      if GRegistry.ControlCommands.WindowsLogoffCommand = '' then
        UDPSend(ipaddr,STR_CMD_RESTART + '=' + BoolToStr(False))
      else
        UDPSend(ipaddr,STR_CMD_EXECUTE_COMMAND_CLIENT + '=' + GRegistry.ControlCommands.WindowsLogoffCommand);
    Result_loc := true;
  except
    Debug.Trace1('LogOff error :' + ipaddr);
  end;
  Result := result_loc;
end;

procedure TComputer.RunPadMonitorOff (state:Boolean);
begin
  if state then
    UDPSend(ipaddr,STR_CMD_OPTION_SET + '=' + 'RunPadMonitorOff' + '/1')
  else
    UDPSend(ipaddr,STR_CMD_OPTION_SET + '=' + 'RunPadMonitorOff' + '/0');
end;

procedure TComputer.RunPadLockStation (state:Boolean);
begin
  if state then
    UDPSend(ipaddr,STR_CMD_OPTION_SET + '=' + 'RunPadLockStation' + '/1')
  else
    UDPSend(ipaddr,STR_CMD_OPTION_SET + '=' + 'RunPadLockStation' + '/0');
end;

function GetMAC(Value: TMacAddress; Length: integer): String;
var
  I: Integer;
begin
  if Length = 0 then Result := '00-00-00-00-00-00' else
  begin
    Result := '';
    for i:= 0 to Length - 2 do
      Result := Result + IntToHex(Value[i], 2) + '-';
    Result := Result + IntToHex(Value[Length-1], 2);
  end;
end;

// Получение Mac адреса по свойсву ip
function GetMacFromIP(IPAddr:PAnsichar):string;
var
  DestIP, SrcIP: ULONG;
  pMacAddr: TMacAddress;
  PhyAddrLen: ULONG;
begin
  DestIP := inet_addr(IPAddr);
  PhyAddrLen := 6;
  SendArp(DestIP, 0, @pMacAddr, PhyAddrLen);
  Result := GetMAC(pMacAddr, PhyAddrLen);
end;

// Процедура для посылки WOL пакета
procedure WakeUPComputer(aMacAddress: string);
type
     TMacAddress = array [1..6] of byte;

     TWakeRecord = packed record
       Waker : TMACAddress;
       MAC   : array[0..15] of TMACAddress;
     end;

var i : integer;
    WR : TWakeRecord;
    MacAddress : TMacAddress;
    UDP : TIdUDPClient;
    sData : string;
begin
  // Convert MAC string into MAC array
  fillchar(MacAddress,SizeOf(TMacAddress),0); 
  sData := trim(AMacAddress);

  if length(sData) = 17 then begin 
    for i := 1 to 6 do begin 
      MacAddress[i] := StrToIntDef('$' + copy(sData,1,2),0); 
      sData := copy(sData,4,17); 
    end;
  end; 

  for i := 1 To 6 do WR.Waker[i] := $FF; 
  for i := 0 to 15 do WR.MAC[i] := MacAddress; 
  // Create UDP and Broadcast data structure
  try
    UDP := TIdUDPClient.Create(nil);
    UDP.Host := '255.255.255.255';
    UDP.Port := 32767;
    UDP.BroadCastEnabled := true;
    UDP.SendBuffer(WR,SizeOf(TWakeRecord));
  except
    Console.AddEvent(EVENT_ICON_ERROR, LEVEL_ERROR,SystemErrorMessage + ' >> ' +
      aMacAddress );
  end;
    UDP.BroadcastEnabled := false;
    UDP.Free;
end;

// посылаем UDP пакет с данными data на адрес ip
procedure UDPSend(const AstrIP: string; const AstrData: string);
var
  vport: integer;
  strData: String;
  compIndex: integer;
begin
  if (isManager) then exit;
  if AstrIP = '' then exit;
  compIndex := ComputersGetIndexByIp(AstrIP);

  if compIndex > -1 then
    if not Comps[ComputersGetIndexByIp(AstrIP)].IcmpPingable then exit;
  try
    Debug.Trace1(AstrIP + ' : ' + AstrData);
    strData := AstrData;
    vport := SENDPORT;
    if (AstrIP = GRegistry.Options.UnixServerIP) then
      vport := SENDPORT_UNIXSERVER;
    if ((Pos(STR_CMD_INETBLOCK, strData)=0)
        and (Pos(STR_CMD_INETUNBLOCK, strData) = 0)
        and (Pos(STR_CMD_INETSETSPEEDFORIP, strData)=0)
        and (Pos(STR_CMD_GETTRAFFICVALUE, strData) = 0)
        and (Pos(STR_CMD_INETSETSPEEDFORIP, strData) = 0)
        and (Pos(STR_CMD_INETSETGROUP, strData) = 0))
        then strData := WrapProtocol(strData);
//    udpClient.Send(AstrIP,vport,strData)
    GCSendRecieve.SendData(AstrIP,vport,strData);

  except
  end;
end;

function TComputer.InitDev: Boolean;
begin
  InitDev:= true;
end;

procedure TComputer.CheckState;
var
  n: integer;
  block_opt: string;
  uncontrol_flag: boolean;
  strParm: String;

  Idx: Integer;
  SnmpResult: integer;
  ClientState: integer;

  CompMainVolume,CompWaveVolume:integer;
  CompMuteVolume,CompOnlyLimitVolume:Boolean;

begin

  if (isManager) then exit;
  uncontrol_flag := false;
  // считаем количество отправленных пингов

  if Self.ClientType = CT_GAMECLASS then
  begin
    Self.pings := Self.pings + 1;
    // если уже отправили пакетов больше чем максимум, то считаем что комп
    // НЕ КОНТРОЛИРУЕТСЯ
    if (Self.pings > MAXIMUM_LOST_PINGS) or
      (not Self.IcmpPingable) then
    begin
      // 1) было false - gccommon::dsControlCompTimer
      // 2) было true - gccommon::dsControlCompStart
      if (Self.control = false) then
        dsControlCompTimer(Self.id)
      else begin
        uncontrol_flag := true;
        dsControlCompStart(Self.id);
      end;
      // сбрасываем метку в false
      Self.control := false;
    end;

    //if Self.control then
    //begin
      if (not FunctionAmIRight(FN_REMOTE_CONTROL)) then begin
        if ((Self.busy = true) and (Self.session<>Nil) and (Tarifs[TarifsGetIndex(Self.session.IdTarif)].internet = 1))
        then
          strParm := '=0/'
        else
          strParm := '=1/';

        if GRegistry.Volume[Self.IndexInSystem + 1].Custom then
        begin
          CompMainVolume := GRegistry.Volume[Self.IndexInSystem + 1].Main;
          CompWaveVolume := GRegistry.Volume[Self.IndexInSystem + 1].Wave;
          CompMuteVolume := GRegistry.Volume[Self.IndexInSystem + 1].Mute;
        end else begin
          CompMainVolume := GRegistry.Volume[0].Main;
          CompWaveVolume := GRegistry.Volume[0].Wave;
          CompMuteVolume := GRegistry.Volume[0].Mute;
        end;
        CompOnlyLimitVolume := GRegistry.Volume.OnlyLimit;
        if Self.Busy then
          if Self.session.Tariff.forcedvolume>=0 then
          begin
            CompMainVolume := round((VOLUME_MAX *Self.session.Tariff.forcedvolume)/100);
            CompWaveVolume := round((VOLUME_MAX *Self.session.Tariff.forcedvolume)/100);
            if CompMainVolume=0 then
              CompMuteVolume := true
            else
              CompMuteVolume := False;
            CompOnlyLimitVolume := False;
          end;

        strParm := strParm +
                   IntToStr(CompMainVolume)+'/'+
                   IntToStr(CompWaveVolume)+'/'+
                   IfThen(CompMuteVolume,'1','0');

        strParm := strParm + '/' + IfThen(CompOnlyLimitVolume,'0','1');



        UDPSend(Self.ipaddr, STR_CMD_PING + strParm);
      end;
      // компу надо послать инфу на клиента
      SendAccountAndSessionInfoToClient(Self.IndexInSystem);

      if Self.Busy
          and not Self.Agreement then
      begin
        UDPSend(Self.ipaddr, STR_CMD_BLOCKED);
      end else begin
        // если комп свободен, то блокируем его
        // берем настройки блокировок для клиента
        block_opt := '=';
        if (GClientOptions.BlockKeyboard) then block_opt := block_opt + 'k';
        if (GClientOptions.BlockMouse) then block_opt := block_opt + 'm';
        if (GClientOptions.BLockTasks) then block_opt := block_opt + 't';
        if (GClientOptions.BlockDisplay) then block_opt := block_opt + 'd';
        if (block_opt = '=') then block_opt := '=km';
        //При авторизации, блокируем что угодно, но не выключаем экран
        n := Pos('d',block_opt);
        if (Self.a.state <> ClientState_Blocked) and (n <> 0) then
          Delete(block_opt,n,1);
        //блокируем всегда, когда не занят
        UDPSend(Self.ipaddr,
            STR_CMD_BLOCKED + block_opt);
        // всегда блокируем инет, если комп свободен
        //if (Registration.GCInternetControlLinux = 1) then
        if GRegistry.Modules.Internet.OuterPlugin
            or GRegistry.Modules.Internet.LinuxPro
            or GRegistry.Modules.Internet.LinuxFree then
          UDPSend(GRegistry.Options.UnixServerIP,
              STR_CMD_INETBLOCK
              + Self.ipaddr);
      //end;
    end;
    //Афвтологофф
    if GClientOptions.AutoLogoff
        and (Self.a.state = ClientState_Order)
        and (GetVirtualTime >= IncSecond(
        Self.a.LogonOrStopMoment,
        GClientOptions.AutoLogoffSec)) then begin
      Console.AddEvent(EVENT_ICON_INFORMATION, LEVEL_1,
          translate('AuthenticationLogoff') + ' / ' + translate('Computer')
          + ' ' + Self.GetStrNumber + ' / '
          + translate('labelUser')
          + ' ' + GetAccountName(Self.a));
      Self.a.number := -1;
      QueryAuthGoState1(Self.IndexInSystem);
    end;
  end;
  if Self.ClientType = CT_SNMP then
  begin
    if  ((Self.busy = true) and (Self.session<>Nil)) then
      ClientState:=1
    else
      ClientState:=0;
    Self.control := Self.IcmpPingable;
    uncontrol_flag := not Self.control;
    if Self.control and Self.RealIcmpPingable then
    begin
      SnmpResult :=GetSnmpIntegerValue(Self) ;
      if ClientState<>SnmpResult Then
        SetSnmpIntegerValue(Self,ClientState);
    end;
  end;

  if (GRegistry.UserInterface.SoundLostLink
      and uncontrol_flag) then
    DoSound([NotifyLostLink]);
end;

initialization
  GbUnregisteredLinuxClinentMessageShowed := False;

end.
