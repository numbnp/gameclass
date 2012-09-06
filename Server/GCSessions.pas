unit GCSessions;

interface

uses
  Classes,
  uClientInfoConst,
  uTariffication;

type

  TGCSessionStatus = (ssReserve=0, ssActive=1, ssFinished=2, ssDesigned=3);
  //0 - забронированный сеанс, 1 - активный (работает), 2 - отработанный, 3-редактируемый
  TGCSession = class(TCollectionItem)
  private
    FnIdSessions: Longword;
    FnIdSessionsAdd: Longword; // почти праймари кей,
                               // кроме случая добавления новых сессий (=0)
    FnIdComp:Longword;
    FnIdClient: Longword;
    FdtStarted: TDateTime;
    FdtStart: TDateTime;
    FdtStop: TDateTime;
    FnIdTarif: Longword;
    FnTarifIndex: Integer;
    FnWhole: Integer;
    FbPostPay: Boolean;
    FnAdditionalMinutes: Integer;
    FstrDescription: String;
    FfCommonPay: Double;
    FfCurrentCommonPay: Double;
    FfSeparateTrafficPay: Double;
    FfCurrentSeparateTrafficPay: Double;
    FfSummaryTraffic: Double;
    FfSummaryTrafficCost: Double;
    FfSummarySeparateTrafficCost: Double;
    FfCurrentTraffic: Double;
    FfCurrentTrafficCost: Double;
    FfCurrentSeparateTrafficCost: Double;
    FfPrintCost: Double;
    FfServiceCost: Double;
    FnState: TClientState;
    FnStatus: TGCSessionStatus;
    FfCurrentTimeCost: Double;

//    FfCurrentCommonPay: Double; // сколько денег стоит текущий интервал времени
    // дополнительные атрибуты
    FbReloaded: Boolean;
  // methods
    function _CurrentTimeCost:Double;
  public
    constructor Create; overload;
    // misc!
    function UID:String;
    // Actions
    procedure StopOnDB(AbAuto: Boolean);
    procedure Stop(AbAuto: Boolean);
    procedure UpdateTraffic(AnTrafficDiff: Longword);
    procedure UpdatePrinted(const AfPrintedCostDiff: Double);

    procedure ChangeTariff(const AnNewTariff: TTarif;
        const AdtCurrentTime: TDateTime; const AdtNewStopTime: TDateTime);
    // Получение данных о сессии
    // для консоли
    function ConsoleInfo: String;
    function GetInfoStop: String;
    // Функции вычисления сумм, остатков, времени и др.
    function Credit: boolean;        // выдает тру, если клиент остался должен
    function GetCostTotal:Double;    // потрачено итого
    function IsTrafficSeparatePayment:Boolean;  //тариф с отдельной оплатой
    function IsInternet:Boolean;  //тариф с интернетом
    function GetCostTime:Double;     // потрачено времени
    function RecalcStopTime: Boolean;  // рассчет нового времени останова
    function RecalcTimeCost: Boolean;  // рассчет стоимости времени
    // строковые значения данных (для отображения)
    function GetStrBalance: String;
    function GetStrClient:String;
    function GetStrClientBalance:String;
    function GetStrTarif: String;
    function GetStrStart: String;
    function GetStrTraffic: String;
    function GetStrStop: String;
    function GetStrBalanceTime: String;
    function GetStrMoneyLeft: String;
    function ShortTarifName: String;
    function GetIPAddress: String;
    function Tariff: TTarif;
    function ComputerGroupId: Integer;

    function RoundMoney(AfMoney: Double): Double;

    function CurrentAdditionalSeparateTraffic: Double;
    function CurrentSeparateTrafficLimit: Double;
    function CurrentFreeSeparateTrafficLimit: Double;

    function GetCostTraffic:Double;  // потрачено по трафику
    function CalculatedCurrentSeparateTrafficCost: Double;

    function ByteTrafficCost: Double; //стоимость 1 байта трафика
    function KBTrafficCost: Double; //стоимость 1 KБ трафика
    function MBTrafficCost: Double; //стоимость 1 MБ трафика

    // методы установки данных
    // другие методы
    procedure UpdateOnDB(  // обновление данных сессии в БД
        AfCommonPayDiff: Double;
        AfSeparateTrafficPayDiff: Double;
        AfTrafficCostDiff: Double;
        AfSeparateTrafficCostDiff: Double;
        AfPrintCostDiff: Double;
        AfServiceCostDiff: Double;
        AfTrafficDiff: Double;
        AnAdditionalMinutesDiff: Integer);
    procedure UpdateTimeCostOnDB;  // обновление стоимости сессии в БД
    procedure UpdateTimeStopOnDB;  // обновление окончания сессии в БД
    procedure Update(
        AnIdSessions: Longword;
        AnIdSessionsAdd: Longword;
        AnIdComp:Longword;
        AnIdClient: Longword;
        AdtStarted: TDateTime;
        AdtStart: TDateTime;
        AdtStop: TDateTime;
        AnIdTarif: Longword;
        AnWhole: Integer;
        AbPostPay: Boolean;
        AnAdditionalMinutes: Integer;
        AstrDescription: String;
        AfCommonPay: Double;
        AfCurrentCommonPay: Double;
        AfSeparateTrafficPay: Double;
        AfCurrentSeparateTrafficPay: Double;
        AfSummaryTraffic: Double;
        AfSummaryTrafficCost: Double;
        AfSummarySeparateTrafficCost: Double;
        AfCurrentTraffic: Double;
        AfCurrentTrafficCost: Double;
        AfCurrentSeparateTrafficCost: Double;
        AfPrintCost: Double;
        AfServiceCost: Double;
        AnState: TClientState;
        AnStatus: TGCSessionStatus);
    procedure Save;    // сохранение сессии в базе данных

    function GetPenalty: Integer;
    function GetMoneyLeft:Double;
    function GetPayedCurrent:Double;
    function IsPacketTarif: Boolean;
    function IsFreePacketTarif: Boolean;
    function IsGuest: Boolean;

    procedure SetStatus(AnStatus : TGCSessionStatus);
    procedure SetState(AnState : TClientState);
    procedure SetIdTarif(AnIdTarif: Longword);


    //потрачено за время, услуги и печать с учетом запрета сдачи
    function CommonCost: Double;
    //потрачено за отдельный трафик с учетом запрета сдачи
    function SeparateTrafficCost: Double;
    // CommonCost + SeparateTrafficCost
    function ResultCostForKKM:Double;
    // сдача
    function Change: Double;
    function TimeAndTrafficInfo: String; // о потраченном времени и трафике
    function MoneyInfo: String; // информация о потраченных денежках
//    function Info: String; // информация о сессии


    property IdSessions: Longword read FnIdSessions;
    property IdSessionsAdd: Longword read FnIdSessionsAdd;
    property IdTarif: Longword read FnIdTarif write SetIdTarif;
    property Started: TDateTime read FdtStarted;
    property PrintCost: Double read FfPrintCost;
    property SummaryTraffic: Double read FfSummaryTraffic;
    property CurrentTraffic: Double read FfCurrentTraffic;
    property State: TClientState read FnState write SetState;
    property Status: TGCSessionStatus read FnStatus write SetStatus;
    property TimeStart: TDateTime read FdtStart write FdtStart;
    property TimeStop: TDateTime read FdtStop write FdtStop;
    property IdClient: Longword read FnIdClient write FnIdClient;
    property IdComp: Longword read FnIdComp write FnIdComp;
    property Whole: Integer read FnWhole write FnWhole;
    property CommonPay: Double read FfCommonPay write FfCommonPay;
    property SeparateTrafficPay: Double read FfSeparateTrafficPay;
    property PostPay: Boolean read FbPostPay write FbPostPay;
    property CurrentCommonPay: Double
        read FfCurrentCommonPay write FfCurrentCommonPay;
    property CurrentSeparateTrafficPay: Double read FfCurrentSeparateTrafficPay;
    property Description: String read FstrDescription write FstrDescription;
    property Reloaded: Boolean read FbReloaded write FbReloaded;
    property ServiceCost: Double
        read FfServiceCost ; //бабки потраченные на услуги
    property CurrentTimeCost: Double
        read FfCurrentTimeCost ; // потрачено за время по текущему интервалу
  private
    function _TrafficInfo(const AfTraffic: Double; const AfTrafficCost: Double;
        const AfSeparateTrafficCost: Double;
        const AbIndention: Boolean): String;

  end;

  TGCSessionAction = (saChanged, saReserveCancel);
  TGCSessionEvent = procedure(const ASender: TObject;
      const ASession: TGCSession;
      const AAction: TGCSessionAction) of object;

  TGCSessions = class(TCollection)
  private
    function GetIsBadDesignedSessions:Boolean;
  public
    constructor Create;
    destructor Destroy; override;

    function Index(AnIdSessionsAdd:Longword):Integer;
    function IndexDesignedByIdComp(AnIdComp: Longword): Integer;
    function IndexDesignedByIdCollection(AnIdCollection: Longword): Integer;
    function Add(
        AnIdSessions: Longword;
        AnIdSessionsAdd: Longword;
        AnIdComp:Longword;
        AnIdClient: Longword;
        AdtStarted: TDateTime;
        AdtStart: TDateTime;
        AdtStop: TDateTime;
        AnIdTarif: Longword;
        AnWhole: Integer;
        AbPostPay: Boolean;
        AnAdditionalMinutes: Integer;
        AstrDescription: String;
        AfCommonPay: Double;
        AfCurrentCommonPay: Double;
        AfSeparateTrafficPay: Double;
        AfCurrentSeparateTrafficPay: Double;
        AfSummaryTraffic: Double;
        AfSummaryTrafficCost: Double;
        AfSummarySeparateTrafficCost: Double;
        AfCurrentTraffic: Double;
        AfCurrentTrafficCost: Double;
        AfCurrentSeparateTrafficCost: Double;
        AfPrintCost: Double;
        AfServiceCost: Double;
        AnState: TClientState;
        AnStatus: TGCSessionStatus): TGCSession;
    function GetItem(Index: Integer): TGCSession ;
    procedure SetItem(Index: Integer; Value: TGCSession);
    property Items[Index: Integer]:TGCSession read GetItem write SetItem; default;
    procedure Load;
    function Check:boolean;
    property IsBadDesignedSessions:Boolean read GetIsBadDesignedSessions;
    function GetDesignedMaxStopTime:TDateTime;
    function GetMaxStopTime(AnIdComp: Integer):TDateTime;
    procedure PrepareDesignedForDeletion;
    procedure DeleteOldDesigned;
    function GetItemByIdSessionsAdd(
        const AnIdSessionsAdd:Longword): TGCSession ;
  end;

resourcestring
  INFO_PREV_TARIF = 'По предыдущим тарифам:';
  INFO_CURRENT_TARIF = 'По текущему тарифу:';
  INFO_TIME = 'Потрачено времени ( %s ) = %m';
  INFO_PRINT = 'Распечатка = %m';
  INFO_TRAFFIC = 'Трафик ( %s ) = %m';
  INFO_SEPARATETRAFFIC = 'Трафик ( %s ) = отдельная оплата %m';
  INFO_MIXEDTRAFFIC = 'Трафик ( %s ) = %m + отдельная оплата %m';
  INFO_COMMONPAY = 'Внесено предоплатой = %m';
  INFO_SEPARATETRAFFICPAY = 'Внесено предоплатой отдельно за трафик = %m';
  INFO_TIMELEFT = 'Времени осталось = %m';
  INFO_SERVICE = 'За услуги = %m';
  INFO_TOTAL = 'Итого = %m';
  INFO_INDENTION = '   ';
var
  GSessions : TGCSessions = Nil;

implementation
uses
  Types,
  GCCommon,
  GCConst,
  GClangutils,
  StdCtrls,
  Dialogs,
  ComCtrls,
  DateUtils,
  frmGCMessageBox,
  Proxy,
  SysUtils,
  DB,
  ADODB,
  StrUtils,
  IdSocketHandle,
  IdUDPServer,
  IdUDPClient,
  IdICMPClient,
  GCComputers,
  uAccountSystem,
  GCFunctions,
  frmMain,
  gcsystem,
  uClientOptions,
  Math,
  uVirtualTime,
  uRegistry,
  uRegistryModules,
  uRegistryPrinter,
  uProtocol,
  uServerScripting,
  udmActions,
  uKKMTools,
  uY2KString;

constructor TGCSession.Create;
begin
  FnIdSessions := 0;
  FnIdSessionsAdd := 0;
  FnIdComp := 0;;
  FnIdClient := 0;
  FdtStarted := 0;
  FdtStart := 0;
  FdtStop := 0;
  FnIdTarif := 0;
  FnTarifIndex := 0;
  FnWhole := 0;
  FbPostPay := False;
  FnAdditionalMinutes := 0;
  FstrDescription := '';
  FfCommonPay := 0;
  FfCurrentCommonPay := 0;
  FfSeparateTrafficPay := 0;
  FfCurrentSeparateTrafficPay := 0;
  FfCurrentTraffic := 0;
  FfCurrentTrafficCost := 0;
  FfPrintCost := 0;
  FfServiceCost := 0;
  FnStatus := ssDesigned;

  if GAccountSystem.Enabled and
     GAccountSystem.AlwaysAllowAuthentication and
     GAccountSystem.AuthenticationIfReserved  then
     FnState := ClientState_Authentication
  else
     FnState := ClientState_Blocked;

//  FfCurrentTimeCost := 0;
  FbReloaded := False;
end;

procedure TGCSession.Save;
var
  dts: TADODataSet;
  query: String;
begin
  if (isManager) then exit;
  // надо получить FnIdSessions & FnIdSessionsAdd
  if (dsConnected) then
  begin
    RecalcStopTime;
    RecalcTimeCost;
    dts := TADODataSet.Create(nil);
    query := 'SessionsInsert'
        + ' @idComp=' + IntToStr(FnIdComp)
        + ', @idClients=' + IntToStr(FnIdClient)
        + ', @TimeCost=' + FloatToStrGC(CurrentTimeCost)
        + ', @start=''' + DateTimeToSql(FdtStart) + ''''
        + ', @stop=''' + DateTimeToSql(FdtStop) + ''''
        + ', @idTarif=' + IntToStr(FnIdTarif)
        + ', @whole=' + IntToStr(FnWhole)
        + ', @postpay=' + IfThen(FbPostPay,'1','0')
        + ', @description=N''' + FstrDescription + ''''
        + ', @CommonPay=' + FloatToStrGC(FfCommonPay)
        + ', @state=' + IntToStr(Integer(State))
        + ', @status=' + IntToStr(Integer(Status))
        + ', @moment=''' + DateTimeToSql(GetVirtualTime) + '''';

    dsDoQuery(query, @dts);

    if (not dts.Recordset.EOF) then
    begin
      FnIdSessions := StrToInt64(dts.Recordset.Fields.Item['idSessions'].Value);
      FnIdSessionsAdd := StrToInt64(dts.Recordset.Fields.Item['idSessionsAdd'].Value);
    end;
    dts.Close;
    dts.Destroy;
  end;
end;

// применяется при изменении значений траффика и распечатки
procedure TGCSession.UpdateOnDB(  // обновление данных сессии в БД
    AfCommonPayDiff: Double;
    AfSeparateTrafficPayDiff: Double;
    AfTrafficCostDiff: Double;
    AfSeparateTrafficCostDiff: Double;
    AfPrintCostDiff: Double;
    AfServiceCostDiff: Double;
    AfTrafficDiff: Double;
    AnAdditionalMinutesDiff: Integer);
begin

  FfCommonPay := FfCommonPay + AfCommonPayDiff;
  FfCurrentCommonPay := FfCurrentCommonPay + AfCommonPayDiff;
  FfSeparateTrafficPay := FfSeparateTrafficPay + AfSeparateTrafficPayDiff;
  FfCurrentSeparateTrafficPay := FfCurrentSeparateTrafficPay
      + AfSeparateTrafficPayDiff;
  FfCurrentTrafficCost := FfCurrentTrafficCost + AfTrafficCostDiff;
  FfPrintCost := FfPrintCost + AfPrintCostDiff;
  FfServiceCost := FfServiceCost + AfServiceCostDiff;
  FfCurrentTraffic := FfCurrentTraffic + AfTrafficDiff;
  FnAdditionalMinutes := FnAdditionalMinutes + AnAdditionalMinutesDiff;

  FfSummarySeparateTrafficCost := FfSummarySeparateTrafficCost + AfSeparateTrafficCostDiff;
  FfSummaryTraffic := FfSummaryTraffic + AfTrafficDiff;

  if (isManager) then exit;
  if (IdTarif = ID_TARIF_REMONT) then exit;

  // тут нужно пересчитать время завершения исходя из новой суммы
  RecalcStopTime;
  RecalcTimeCost;
  dsDoCommand('SessionsUpdate @IdClient=' + IntToStr(FnIdClient)
      + ', @idSessions=' + IntToStr(FnIdSessions)
      + ', @idSessionsAdd=' + IntToStr(FnIdSessionsAdd)
      + ', @TimeCost=' + FloatToStrGC(CurrentTimeCost)
      + ', @CommonPayDiff=' + FloatToStrGC(AfCommonPayDiff)
      + ', @SeparateTrafficPayDiff=' + FloatToStrGC(AfSeparateTrafficPayDiff)
      + ', @TrafficCostDiff=' + FloatToStrGC(AfTrafficCostDiff)
      + ', @SeparateTrafficCostDiff=' + FloatToStrGC(AfSeparateTrafficCostDiff)
      + ', @PrintCostDiff=' + FloatToStrGC(AfPrintCostDiff)
      + ', @ServiceCostDiff=' + FloatToStrGC(AfServiceCostDiff)
      + ', @TrafficDiff=' + FloatToStrGC(AfTrafficDiff)
      + ', @AdditionalMinutesDiff=' + IntToStr(AnAdditionalMinutesDiff)
      + ', @Stop=''' + DateTimeToSql(FdtStop) + ''''
      + ', @Status=' + IntToStr(Integer(FnStatus))
      + ', @State=' + IntToStr(Integer(FnState))
      + ', @Moment=''' + DateTimeToSql(GetVirtualTime) + '''');
end;


procedure TGCSession.UpdateTimeCostOnDB;  // обновление стоимости сессии в БД
begin
  if (isManager) then exit;
  if (IdTarif = ID_TARIF_REMONT) then exit;
  dsDoCommand('SessionsUpdateTimeCost'
      + ' @idSessionsAdd=' + IntToStr(FnIdSessionsAdd)
      + ', @TimeCost=' + FloatToStrGC(CurrentTimeCost));
end;

procedure TGCSession.UpdateTimeStopOnDB;  // обновление окончания сессии в БД
begin
  if (isManager) then exit;
  if (IdTarif = ID_TARIF_REMONT) then exit;
  dsDoCommand('SessionsUpdate @IdClient=' + IntToStr(FnIdClient)
      + ', @idSessions=' + IntToStr(FnIdSessions)
      + ', @idSessionsAdd=' + IntToStr(FnIdSessionsAdd)
      + ', @TimeCost=' + FloatToStrGC(CurrentTimeCost)
      + ', @CommonPayDiff=0'
      + ', @SeparateTrafficPayDiff=0'
      + ', @TrafficCostDiff=0'
      + ', @SeparateTrafficCostDiff=0'
      + ', @PrintCostDiff=0'
      + ', @ServiceCostDiff=0'
      + ', @TrafficDiff=0'
      + ', @AdditionalMinutesDiff=0'
      + ', @Stop=''' + DateTimeToSql(FdtStop) + ''''
      + ', @Status=' + IntToStr(Integer(FnStatus))
      + ', @State=' + IntToStr(Integer(FnState))
      + ', @Moment=''' + DateTimeToSql(GetVirtualTime) + '''');
end;



// останавливаем сессию раньше времени!
procedure TGCSession.StopOnDB(AbAuto: Boolean);
var
  query: String;
  strResultCommonPay: String;
  strResultSeparateTrafficPay: String;
begin
  if (isManager) then exit;
  //Из-за тарифов с доплатой, деньги нужно просчитать до изменения FdtStop
  strResultCommonPay := FloatToStrGC(CommonCost);
  strResultSeparateTrafficPay := FloatToStrGC(SeparateTrafficCost);
  // Отметить текущее время останова (stop)
  if Not AbAuto then
    FdtStop := GetVirtualTime;
  // Вызываем SessionsStopIt
  query := 'SessionsStop @idSessionsAdd='+IntToStr(FnIdSessionsAdd)
      + ', @newstop=''' + DateTimeToSql(FdtStop) + ''''
      + ', @ResultCommonPay=' + strResultCommonPay
      + ', @ResultSeparateTrafficPay=' + strResultSeparateTrafficPay;
  if AbAuto then
    query := query + ', @autostop=1';
  dsDoCommand(query);
end;

procedure TGCSession.Stop(AbAuto: Boolean);
var
  nCompIndex: Integer;
begin
  nCompIndex := ComputersGetIndex(FnIdComp);
  Console.AddEvent(EVENT_ICON_WARNING, LEVEL_1, translate('ActionStop') + ' '
  + GetInfoStop);
  if not(isManager) then begin
    RunSessionScript(saStop, Self);
    if GRegistry.Modules.Internet.SummaryAccounting then
      UpdateTraffic(FProxy.IPTrafficGetTraffic(Comps[nCompIndex].ipaddr));
    if GClientOptions.UseSounds then begin
      if (Not PostPay) then begin
        if (GClientOptions.Language = 2) then
          UDPSend(Comps[nCompIndex].ipaddr,
              STR_CMD_PLAY_SOUND + '='
              + WAVFILE_STOP_PREPAY_RU);
        if (GClientOptions.Language = 1) then
          UDPSend(Comps[nCompIndex].ipaddr,
              STR_CMD_PLAY_SOUND + '='
              + WAVFILE_STOP_PREPAY_ENG);
      end
      else begin
        if (GClientOptions.Language = 2) then
          UDPSend(Comps[nCompIndex].ipaddr,
              STR_CMD_PLAY_SOUND + '='
              + WAVFILE_MAXPOSTPAY_RU);
        if (GClientOptions.Language = 1) then
          UDPSend(Comps[nCompIndex].ipaddr,
              STR_CMD_PLAY_SOUND + '='
              + WAVFILE_MAXPOSTPAY_ENG);
      end;
    end;
  end;
  CompStop(nCompIndex);
  if isManager then exit;
// стоп для ссессии
  StopOnDB(AbAuto);
  Status := ssFinished;
  if GRegistry.UserInterface.SoundEndSession then
    DoSound([NotifyStopSession]);
  if Credit and GRegistry.UserInterface.SoundNegativeBalance then
    DoSound([NotifyStopSessionNegativeBalance]);
{  if (FnIdClient <> 0) then
    asys.accounts[asys.GetIndexByNumber(FnIdClient)].Load;
    }
//my  DoInterfaceComps;
//my  DoEvent(FN_REDRAW_COMPS);  // redraw comps list
end;

function TGCSession.GetStrClient:String;
begin
  if (FnIdClient <> 0) then
    Result := GAccountSystem.Accounts[FnIdClient].Name
  else
    Result := translate('Guest');
end;

function TGCSession.IsGuest: Boolean;
begin
  Result := (FnIdClient = 0);
end;

function TGCSession.GetStrClientBalance:String;
begin
  if (FnIdClient = 0) then
    GetStrClientBalance := '0'
  else
    GetStrClientBalance := FloatToStr(
        GAccountSystem.Accounts[FnIdClient].Balance);
end;

function TGCSession.GetStrTarif: String;
begin
  Result := GetTarifName(FnIdTarif,FnWhole);
end;

function TGCSession.GetStrBalance: String;
var
  str: String;
begin
  str := FormatFloat('0.00',GetCostTotal);
  if (FnIdTarif = ID_TARIF_REMONT) then
    GetStrBalance := ''
  else
  if (FnWhole = 0) then
  begin
    // интервал не цельный
    GetStrBalance := str+'/'+FloatToStr(FfCommonPay);
    if Postpay
      then GetStrBalance := '-'+str;
  end
  else
  begin
    // цельный интервал
    GetStrBalance := FloatToStr(FfCommonPay);
  end;
end;

function TGCSession.GetStrMoneyLeft: String;
var
  str: String;
begin
  str := FormatFloat('0.00',GetMoneyLeft);
  if (FnIdTarif <> ID_TARIF_REMONT) and (FnWhole=0) then
    GetStrMoneyLeft := str
  else
    GetStrMoneyLeft := '';
end;


function TGCSession.GetStrStart: String;
begin
  GetStrStart := TimeToStr(FdtStart);
end;

function TGCSession.GetStrStop: String;
begin
  GetStrStop :=  TimeToStr(FdtStop);
end;

function TGCSession.GetStrBalanceTime: String;
var
  left: TDateTime;
begin
  // вернем значение остатка времени
  left := GetVirtualTime-FdtStop;
  GetStrBalanceTime := TimeToStr(left);
end;

function TGCSession.GetStrTraffic:String;
var
  tarif: TTarif;
  str: String;
begin
  GetStrTraffic := '';
  tarif := Tarifs[FnTarifIndex];
//  GetStrTraffic := FormatFloat('0.00',FnTraffic/Options.TrafficByteInMB) + ' ' + translate('MB');
  str := FormatFloat('0.00',FfCurrentTraffic / tarif.BytesInMB);
  if tarif.GetWholeTrafficSeparatePayment(Whole) then
    str := str + '/' + FormatFloat('0.00', CurrentSeparateTrafficLimit
        / tarif.BytesInMB);
  str := str + ' ' + translate('MB');
  GetStrTraffic := str;
end;

// бабло, ушедшее на оплату ТРАФФИКА
function TGCSession.GetCostTraffic:Double;
var
  tarif: TTarif;
  fCost: Double;
begin
  Result := 0;
  if (FnIdTarif = ID_TARIF_REMONT) then exit;
  tarif := Tarifs[FnTarifIndex];
  if tarif.GetWholeTrafficSeparatePayment(Whole) then exit;
//  GetCostTraffic := tarif.GetWholeTrafficCost(Whole)*FnTraffic/tarif.BytesInMB;
  fCost := tarif.GetWholeTrafficCost(Whole) * FfCurrentTraffic / tarif.BytesInMB;
  fCost := tarif.fnRoundMoney(fCost, tarif.roundmoney, 1);
  Result := fCost;
end;

function TGCSession.CalculatedCurrentSeparateTrafficCost: Double;
var
  fPaidSeparateTraffic: Double;
begin
  Result := 0;
  if IsTrafficSeparatePayment then begin
    fPaidSeparateTraffic := FfCurrentTraffic - CurrentFreeSeparateTrafficLimit;
    if CompareValue(fPaidSeparateTraffic, 0) = GreaterThanValue then
      Result := RoundMoney(fPaidSeparateTraffic * ByteTrafficCost);
  end;
end;

function TGCSession.ByteTrafficCost: Double;
var
  tarif: TTarif;
begin
  Result := 0;
  if (FnIdTarif = ID_TARIF_REMONT) then exit;
  tarif := Tarifs[FnTarifIndex];
  Result := tarif.GetWholeTrafficCost(Whole) / tarif.BytesInMB ;
end;

function TGCSession.KBTrafficCost: Double;
begin
  Result := ByteTrafficCost * 1024;
end;

function TGCSession.MBTrafficCost: Double;
begin
  Result := KBTrafficCost * 1024;
end;


// Истина, если тариф с отдельной оплатой траффика
function TGCSession.IsTrafficSeparatePayment:Boolean;
var
  tarif: TTarif;
begin
  IsTrafficSeparatePayment := False;
  if (FnIdTarif = ID_TARIF_REMONT) then exit;
  tarif := Tarifs[FnTarifIndex];
  IsTrafficSeparatePayment := tarif.GetWholeTrafficSeparatePayment(Whole);
end;

// Истина, если тариф с инетом
function TGCSession.IsInternet:Boolean;
var
  tarif: TTarif;
begin
  Result := False;
  if (FnIdTarif = ID_TARIF_REMONT) then exit;
  tarif := Tarifs[FnTarifIndex];
  Result := (tarif.internet = 1);
end;

// выдает бабло, ушедшее на оплату ВРЕМЕНИ
function TGCSession.GetCostTime:Double;
begin
  Result := 0;
  if (FnIdTarif = ID_TARIF_REMONT) then
    Result := 0
  else begin
    Result := FfCommonPay - FfCurrentCommonPay + CurrentTimeCost;
 end;
end;

// сколько всего потратили
function TGCSession.GetCostTotal:Double;
var
  m: Double;
  idt: Integer;
begin
  m := GetCostTime + PrintCost + GetCostTraffic + ServiceCost;
  idt := FnTarifIndex;
//округление относится к тарифам а не к трафику
//GetCostTotal := Tarifs[idt].fnRoundMoney(m,Tarifs[idt].roundmoney,1);
  Result := m;
end;


function TGCSession.GetPenalty: Integer;
begin
  GetPenalty := - FnAdditionalMinutes;
end;
// возвращает сколько бабла осталось на тарифе
function TGCSession.GetMoneyLeft:Double;
begin
  GetMoneyLeft := FfCurrentCommonPay - CurrentTimeCost;
end;

// возвращает сколько предоплачено бабла
function TGCSession.GetPayedCurrent:Double;
begin
  GetPayedCurrent := FfCurrentCommonPay;
end;

// потрачено за время по текущему интервалу
//будет считать остаток по цене трафика
function TGCSession._CurrentTimeCost:Double;
var
  dtCurrentWithPenalty, dtStopWithPenalty: TDateTime;
  WholePrice: Double;
  BasePrice: Double;
  FullPrice: Double;
  fOverUsedFreeTrafficPrice: Double; // Стоимость перерасходованного
                                     // бесплатного траффика
  fTimeUsagePercent: Double; // Процент потраченного времени (для сдачи по трафику)
  fTrafficUsagePercent: Double; // Процент потраченного трафика (для сдачи по трафику)
  tarif: TTarif;
  fUsedFreeTrafic: Double;
  fTrafficLimit: Double;
begin
  tarif := Tarifs[FnTarifIndex];
  dtCurrentWithPenalty := GetVirtualTime - FnAdditionalMinutes/24/60;
  dtStopWithPenalty := FdtStop - FnAdditionalMinutes/24/60;
  if (dtCurrentWithPenalty > dtStopWithPenalty) then
    dtCurrentWithPenalty := dtStopWithPenalty;
  if (dtCurrentWithPenalty < FdtStart) then dtCurrentWithPenalty := FdtStart;
  if (FnWhole = 0) then begin
    BasePrice := tarif.CalculateCost(FdtStart, dtCurrentWithPenalty,
        Comps[ComputersGetIndex(FnIdComp)].IdGroup,
        GAccountSystem.Accounts[FnIdClient].Discount,
        False, True, 0);
    FullPrice := tarif.CalculateCost(FdtStart, dtStopWithPenalty,
        Comps[ComputersGetIndex(FnIdComp)].IdGroup,
        GAccountSystem.Accounts[FnIdClient].Discount,
        True, True, 0);
  end else begin
    FullPrice := tarif.GetWholeCostByIndex(FnWhole, FnIdComp);
    BasePrice := SecondsBetween(FdtStart, dtCurrentWithPenalty) * FullPrice
        / TotalSeconds(tarif.GetWholeLengthByIndex(FnWhole));
//    BasePrice := tarif.fnRoundMoney(BasePrice, tarif.roundmoney, 1);

  end;
  if tarif.GetWholeTrafficSeparatePayment(Whole) then begin
    fUsedFreeTrafic := FfCurrentTraffic - CurrentAdditionalSeparateTraffic;
    fTrafficLimit := tarif.GetWholeTrafficLimit(Whole, TimeStart  ,
        dtCurrentWithPenalty);
    if CompareValue(fUsedFreeTrafic, fTrafficLimit)
        = GreaterThanValue	then begin
      fOverUsedFreeTrafficPrice := (fUsedFreeTrafic - fTrafficLimit)
          * tarif.GetWholeTrafficCost(Whole) / tarif.BytesInMB;
      if (BasePrice + fOverUsedFreeTrafficPrice < FullPrice) then begin
        BasePrice :=BasePrice + fOverUsedFreeTrafficPrice;
      end else begin
        BasePrice := FullPrice;
      end;
    end;
  end;

  Result := BasePrice;
  // если интервал тарифа - пакетный
  if (FnWhole <> 0) then
  begin
    WholePrice := FfCurrentCommonPay;
    Result := WholePrice;
    if (GRegistry.Options.EnableChangeForPackets) then
      if (BasePrice < WholePrice) then
        Result := BasePrice;
  end;
  Result := tarif.fnRoundMoney(Result, tarif.roundmoney, 1);

end;

// возвращает уникальный идентификатор сессии
function TGCSession.UID:String;
begin
  UID := IntToStr(FnIdSessions);//todo заменить на IdSessionsAdd
end;

// рассчет нового времени останова
// возвращает True если время изменилось
function TGCSession.RecalcStopTime: Boolean;
var
  fSumma: Double;
  nIdGroup: Integer;
  nTarifIndex: Integer;
  dtNewStop: TDateTime;
  dtLength: TDateTime;
begin
  if (FnIdTarif = ID_TARIF_REMONT) then
    exit;
  fSumma := GetPayedCurrent - GetCostTraffic - PrintCost - ServiceCost;
  nIdGroup := Comps[ComputersGetIndex(IdComp)].IdGroup;
  nTarifIndex := FnTarifIndex;
  dtNewStop := FdtStart;
  if (FnWhole = 0) then begin
    dtNewStop := FdtStart + Tarifs[nTarifIndex].CalculateTimeLength(FdtStart,
        fSumma, nIdGroup, GAccountSystem.Accounts[FnIdClient].Discount);
    if FnStatus <> ssReserve then
      if dtNewStop> GSessions.GetMaxStopTime(FnIdComp) then
        dtNewStop := GSessions.GetMaxStopTime (FnIdComp);
  end
  else begin
    dtNewStop := FdtStart;
    if Tarifs[nTarifIndex].GetTarifVariantByWhole(FnWhole,0,0).FreePacket then
//      ReplaceTime(dtNewStop,FdtStart
//      + Tarifs[nTarifIndex].GetWholeLengthByIndex(FnWhole))
      dtNewStop := FdtStart
          + TimeOf(Tarifs[nTarifIndex].GetWholeLengthByIndex(FnWhole))
    else begin
      ReplaceTime(dtNewStop, Tarifs[nTarifIndex].GetWholeStopByIndex(FnWhole));
      if Tarifs[nTarifIndex].GetWholeAtMidnightByIndex(FnWhole) then
        dtNewStop := IncDay(dtNewStop,1);
    end;
  end;
  dtNewStop := IncMinute(dtNewStop, FnAdditionalMinutes);
  Result := (FdtStop <> dtNewStop);
  FdtStop := dtNewStop;
end;

// рассчет стоимости времени
// возвращает True если стоимость изменилось
function TGCSession.RecalcTimeCost: Boolean;
var
  fNewCurrentTimeCost: Double;
begin
  fNewCurrentTimeCost := _CurrentTimeCost;
  Result := (fNewCurrentTimeCost <> FfCurrentTimeCost);
  FfCurrentTimeCost := _CurrentTimeCost;
end;
// для консоли
function TGCSession.ConsoleInfo: String;
var
  str: String;
begin
  Result := '';
  str := Comps[ComputersGetIndex(FnIdComp)].GetStrNumber
      + ' >> ( '+DateTimeToSql(TimeStart) + ' - '
      + DateTimeToSql(TimeStop) +' ) ';
  if PostPay then
    str := str + translate('PostPay') + ', ' + translate('LimitTrust')
        + ' = ' + FormatFloat('0.00', CommonPay)//,Options.MaximumTrustPostPay)
  else
    if (CommonPay = GetPayedCurrent) or (Status = ssReserve) then
      str := str + translate('PrePay')+ '=' + FormatFloat('0.00',CommonPay)
    else
      str := str + translate('PrePayLeft') + '='
          + FormatFloat('0.00',GetPayedCurrent);
  str := str + ' / ' + GetStrTarif + ' / ' + GetStrClient;
  Result := str;
end;

function TGCSession.GetInfoStop:String;
var
  str: String;
  tempMoney: Double;
begin
   str := Comps[ComputersGetIndex(FnIdComp)].GetStrNumber
      + ' >> ' + DateTimeToSql(GetVirtualTime) + ' ';
   str := str + ' / ' + GetStrTarif + ' / ' + GetStrClient + ' / ';
   str := str + FloatToStr(GetCostTotal) + GRegistry.Options.Currency + ' / ';
   str := str + GetStrTraffic + ' / ';

   if PostPay then
      tempMoney := - GetCostTotal
   else
      tempMoney := (CommonPay - GetCostTotal)+ (SeparateTrafficPay - SeparateTrafficCost );

   //Почему-то 0,7-0,7=0.000...1
   tempMoney := RoundTo(tempMoney,-3);
   if (tempMoney > 0)
      and (IdClient = 0) //Для клиентов ВСЕГДА дается скидка
      and GRegistry.Options.DisableChange then
     tempMoney := 0;
   if (Comps[ComputersGetIndex(FnIdComp)].a.number = 0) then begin
      if (tempMoney > 0) then
         str := str + translate('CompStopActionMoneyBack');
      if (tempMoney < 0) then
         str := str + translate('CompStopActionMoneyGet');
   end
   else begin
      if (tempMoney > 0) then
         str := str + translate('CompStopActionCardMoneyBack');
      if (tempMoney < 0) then
         str := str + translate('CompStopActionCardMoneyGet');
   end;
  if (tempMoney > 0) then
    str := str + ' ' + FormatFloat('0.00',tempMoney) + ' '
        + GRegistry.Options.Currency;
  if (tempMoney < 0) then
    str := str + ' ' + FormatFloat('0.00',-tempMoney) + ' '
        + GRegistry.Options.Currency;

  GetInfoStop := str;
end;

//выдает труе если клиент остался должен
function TGCSession.Credit: boolean;
var
  tempMoney: Double;
begin
  if PostPay then
    tempMoney := - GetCostTotal
  else
    tempMoney := CommonPay - GetCostTotal;
  Credit := (tempMoney<0);
end;

procedure TGCSession.ChangeTariff(const AnNewTariff: TTarif;
  const AdtCurrentTime: TDateTime; const AdtNewStopTime: TDateTime);
var
  dts: TADODataSet;
  query: String;
  computer: Tcomputer;
  tarif: TTarif;
begin
  if (isManager) then exit;
  if (FnIdClient <> 0) then exit;
  if (dsConnected) then
  begin
    dts := TADODataSet.Create(nil);
  // Отметить текущее время останова (stop)
  // Вызываем SessionsChange
    query := DS_SESSIONS_CHANGE_TARIFF+ ' @idSessionsAdd='+IntToStr(FnIdSessionsAdd) +
           ', @idTarif=' + IntToStr(AnNewTariff.id) +
           ', @CurrentTime=''' + DateTimeToSql(AdtCurrentTime) + '''' +
           ', @NewTariffStop=''' + DateTimeToSql(AdtNewStopTime) + '''' +
           ', @MoneyLeft=' + FloatToStrGC(GetMoneyLeft)
           + ', @TimeCost=' + FloatToStrGC(CurrentTimeCost);
    dsDoQuery(query, @dts);

    if (not dts.Recordset.EOF) then
      FnIdSessionsAdd := StrToInt64(dts.Recordset.Fields.Item['idSessionsAdd'].Value);
    dts.Close;
    dts.Destroy;


    // Переподключаем интернет
    if (GRegistry.Modules.Internet.LinuxFree) or
       (GRegistry.Modules.Internet.LinuxPro)then begin
      if (AnNewTariff.internet = 1) then
      begin
        computer := Comps[ComputersGetIndex(FnIdComp)];
        FProxy.IPDisable(computer.ipaddr);
        FProxy.IPEnable(computer.ipaddr, AnNewTariff.name);
      end;
    end;
  end;
  DoInterfaceComps;
  dmActions.actRedrawComps.Execute;
end;

procedure TGCSession.Update(
    AnIdSessions: Longword;
    AnIdSessionsAdd: Longword;
    AnIdComp:Longword;
    AnIdClient: Longword;
    AdtStarted: TDateTime;
    AdtStart: TDateTime;
    AdtStop: TDateTime;
    AnIdTarif: Longword;
    AnWhole: Integer;
    AbPostPay: Boolean;
    AnAdditionalMinutes: Integer;
    AstrDescription: String;
    AfCommonPay: Double;
    AfCurrentCommonPay: Double;
    AfSeparateTrafficPay: Double;
    AfCurrentSeparateTrafficPay: Double;
    AfSummaryTraffic: Double;
    AfSummaryTrafficCost: Double;
    AfSummarySeparateTrafficCost: Double;
    AfCurrentTraffic: Double;
    AfCurrentTrafficCost: Double;
    AfCurrentSeparateTrafficCost: Double;
    AfPrintCost: Double;
    AfServiceCost: Double;
    AnState: TClientState;
    AnStatus: TGCSessionStatus);
begin
  if not ComputersCheckIndex(AnIdComp) then
    exit;
  if isManager and (FnIdComp <> AnIdComp)then begin
    CompStop(ComputersGetIndex(FnIdComp));
  end;
  FnIdSessions := AnIdSessions;
  FnIdSessionsAdd := AnIdSessionsAdd;
  FnIdComp := AnIdComp;
  FnIdClient := AnIdClient;
  FdtStarted := AdtStarted;
  FdtStart := AdtStart;
  FdtStop := AdtStop;
  FnIdTarif := AnIdTarif;
  FnTarifIndex := TarifsGetIndex(AnIdTarif);
  FnWhole := AnWhole;
  FbPostPay := AbPostPay;
  FnAdditionalMinutes := AnAdditionalMinutes;
  FstrDescription := AstrDescription;
  FfCommonPay := AfCommonPay;
  FfCurrentCommonPay := AfCurrentCommonPay;
  FfSeparateTrafficPay := AfSeparateTrafficPay;
  FfCurrentSeparateTrafficPay := AfCurrentSeparateTrafficPay;
  FfSummaryTraffic := AfSummaryTraffic;
  FfSummaryTrafficCost := AfSummaryTrafficCost;
  FfSummarySeparateTrafficCost := AfSummarySeparateTrafficCost;
  FfCurrentTraffic := AfCurrentTraffic;
  FfCurrentTrafficCost := AfCurrentTrafficCost;
  FfCurrentSeparateTrafficCost := AfCurrentSeparateTrafficCost;
  FfPrintCost := AfPrintCost;
  FfServiceCost := AfServiceCost;
  State := AnState;
  Status := AnStatus;
  // сразу пересчитываем новое время окончания, потому как могли ввести 1 минуту и посчитать
  // это как 1 рубль. А на самом деле 1 рубль - это 5 минут, так что пересчитываем!
  RecalcStopTime;
  RecalcTimeCost;
  if Comps[ComputersGetIndex(FnIdComp)].session = self then
    if (not GAccountSystem.AuthenticationIfReserved)
        or (Status <> ssReserve)  then begin
      Comps[ComputersGetIndex(FnIdComp)].a.state := AnState;
      Comps[ComputersGetIndex(FnIdComp)].a.number := AnIdClient;
    end;
  FbReloaded := True;
end;

/////////////////////////////////////////////////////////////////////////////////
//                    TGCSessions
/////////////////////////////////////////////////////////////////////////////////

constructor TGCSessions.Create;
begin
   inherited Create(TGCSession);
   Clear;
end;

destructor TGCSessions.Destroy;
begin
   Clear;
   inherited Destroy;
end;

function TGCSessions.Add(
    AnIdSessions: Longword;
    AnIdSessionsAdd: Longword;
    AnIdComp:Longword;
    AnIdClient: Longword;
    AdtStarted: TDateTime;
    AdtStart: TDateTime;
    AdtStop: TDateTime;
    AnIdTarif: Longword;
    AnWhole: Integer;
    AbPostPay: Boolean;
    AnAdditionalMinutes: Integer;
    AstrDescription: String;
    AfCommonPay: Double;
    AfCurrentCommonPay: Double;
    AfSeparateTrafficPay: Double;
    AfCurrentSeparateTrafficPay: Double;
    AfSummaryTraffic: Double;
    AfSummaryTrafficCost: Double;
    AfSummarySeparateTrafficCost: Double;
    AfCurrentTraffic: Double;
    AfCurrentTrafficCost: Double;
    AfCurrentSeparateTrafficCost: Double;
    AfPrintCost: Double;
    AfServiceCost: Double;
    AnState: TClientState;
    AnStatus: TGCSessionStatus): TGCSession;
var
  session : TGCSession;
begin
  if not ComputersCheckIndex(AnIdComp) then
    exit;
  session := TGCSession(inherited Add);

  with session do begin
    FnIdSessions := AnIdSessions;
    FnIdSessionsAdd := AnIdSessionsAdd;
    FnIdComp := AnIdComp;
    FnIdClient := AnIdClient;
    FdtStarted := AdtStarted;
    FdtStart := AdtStart;
    FdtStop := AdtStop;
    FnIdTarif := AnIdTarif;
    FnTarifIndex := TarifsGetIndex(AnIdTarif);
    FnWhole := AnWhole;
    FbPostPay := AbPostPay;
    FnAdditionalMinutes := AnAdditionalMinutes;
    FstrDescription := AstrDescription;
    FfCommonPay := AfCommonPay;
    FfCurrentCommonPay := AfCurrentCommonPay;
    FfSeparateTrafficPay := AfSeparateTrafficPay;
    FfCurrentSeparateTrafficPay := AfCurrentSeparateTrafficPay;
    FfSummaryTraffic := AfSummaryTraffic;
    FfSummaryTrafficCost := AfSummaryTrafficCost;
    FfSummarySeparateTrafficCost := AfSummarySeparateTrafficCost;
    FfCurrentTraffic := AfCurrentTraffic;
    FfCurrentTrafficCost := AfCurrentTrafficCost;
    FfCurrentSeparateTrafficCost := AfCurrentSeparateTrafficCost;
    FfPrintCost := AfPrintCost;
    FfServiceCost := AfServiceCost;
    State := AnState;
    Status := AnStatus;
    FbReloaded := True;
  end;
  Result := session;
end;

function TGCSessions.Index(AnIdSessionsAdd: Longword): Integer;
var
   i : Integer;
begin
   Result := -1;
   for i := 0 to Count-1 do
      if Items[i].FnIdSessionsAdd = AnIdSessionsAdd then
         Result := i;
end;

function TGCSessions.IndexDesignedByIdComp(AnIdComp: Longword): Integer;
var
   i : Integer;
begin
   Result := -1;
   for i := 0 to Count-1 do
      if (Items[i].Status = ssDesigned) and (Items[i].FnIdComp = AnIdComp) then
         Result := i;
end;

function TGCSessions.IndexDesignedByIdCollection(AnIdCollection: Longword): Integer;
var
   i : Integer;
begin
   Result := -1;
   for i := 0 to Count-1 do
      if (Items[i].Status = ssDesigned) and (Items[i].Id = AnIdCollection) then
         Result := i;
end;

function TGCSessions.GetItem(Index: Integer): TGCSession;
begin
  Result := TGCSession(inherited Items[Index]);
end;

function TGCSessions.GetItemByIdSessionsAdd(
    const AnIdSessionsAdd: Longword): TGCSession ;
var
  nIndex: Integer;
begin
  Result := Nil;
  nIndex := Index(AnIdSessionsAdd);
  if (nIndex <> -1) then
    Result := TGCSession(inherited Items[nIndex]);
end;

procedure TGCSessions.SetItem(Index: Integer; Value: TGCSession);
begin
  Items[Index].Assign(Value);
end;

procedure TGCSessions.Load;
var
  dts, dts_d: TADODataSet;
  nIndex, nCount, nCount_d: integer;
  tmp_CurrentSeparateTraffPay, nIdSessionsAdd: Longword;
  query, query_d : string;
begin

  // процедура считывает все сессии, нужные в данный момент
  if (not dsConnected) then exit;

  dts := TADODataSet.Create(nil);
  dts.ParamCheck := false;

  query := 'SessionsSelect @id=NULL, @dt='''
      + DateTimeToSql(GetVirtualTime) + '''';
  dsDoQuery(query, @dts);
  nCount := dts.Recordset.RecordCount;
  for nIndex:=0 to Count-1 do
    Items[nIndex].Reloaded := False;
  while (nCount > 0) and (not dts.Recordset.EOF) do begin
    nIdSessionsAdd := dts.Recordset.Fields.Item['idSessionsAdd'].Value;
    nIndex := Index(nIdSessionsAdd);

    dts_d := TADODataSet.Create(nil);
    dts_d.ParamCheck := false;

    query_d := 'SessionsSeparateTrafficConstSelect @id=' +
      IntToStr(dts.Recordset.Fields.Item['IdSessions'].Value) + '';
    dsDoQuery(query_d, @dts_d);
    nCount_d := dts_d.Recordset.RecordCount;
    tmp_CurrentSeparateTraffPay := 0;
    if (nCount_d > 0) then
      tmp_CurrentSeparateTraffPay := dts_d.Recordset.Fields.Item['CurrentSeparateTrafficPay'].Value;

    dts_d.Close;
    dts_d.Destroy;

    with dts.Recordset.Fields do
      if nIndex = -1 then begin
        nIndex := Item['IdSessions'].Value;

        Add(
            Item['IdSessions'].Value,
            Item['IdSessionsAdd'].Value,
            Item['IdComp'].Value,
            Item['IdClients'].Value,
            Item['Started'].Value,
            Item['Start'].Value,
            Item['Stop'].Value,
            Item['IdTarif'].Value,
            Item['Whole'].Value,
            Item['PostPay'].Value,
            Item['AdditionalMinutes'].Value,
            Item['description'].Value,
            Item['CommonPay'].Value,
            Item['CurrentCommonPay'].Value,
            Item['SeparateTrafficPay'].Value,
            tmp_CurrentSeparateTraffPay,
            Item['SummaryTraffic'].Value,
            Item['SummaryTrafficCost'].Value,
            Item['SummarySeparateTrafficCost'].Value,
            Item['CurrentTraffic'].Value,
            Item['CurrentTrafficCost'].Value,
            Item['SummarySeparateTrafficCost'].Value,
            Item['PrintCost'].Value,
            Item['ServiceCost'].Value,
            Item['State'].Value,
            Item['Status'].Value)
        end
      else
        Items[nIndex].Update(
            Item['IdSessions'].Value,
            Item['IdSessionsAdd'].Value,
            Item['IdComp'].Value,
            Item['IdClients'].Value,
            Item['Started'].Value,
            Item['Start'].Value,
            Item['Stop'].Value,
            Item['IdTarif'].Value,
            Item['Whole'].Value,
            Item['PostPay'].Value,
            Item['AdditionalMinutes'].Value,
            Item['description'].Value,
            Item['CommonPay'].Value,
            Item['CurrentCommonPay'].Value,
            Item['SeparateTrafficPay'].Value,
            tmp_CurrentSeparateTraffPay,
            Item['SummaryTraffic'].Value,
            Item['SummaryTrafficCost'].Value,
            Item['SummarySeparateTrafficCost'].Value,
            Item['CurrentTraffic'].Value,
            Item['CurrentTrafficCost'].Value,
            Item['SummarySeparateTrafficCost'].Value,
            Item['PrintCost'].Value,
            Item['ServiceCost'].Value,
            Item['State'].Value,
            Item['Status'].Value);
    dts.Recordset.MoveNext;
  end; // while

  dts.Close;
  dts.Destroy;

  for nIndex:=Count-1 downto 0 do
      with Items[nIndex] do
        if ((Status = ssActive) or (Status = ssReserve)) and
          (Reloaded = False) then begin
            // заблокировать без связи с ККМ тут не получится
            // потому просто печатаем чек
            if GRegistry.Modules.KKM.Active then begin
              PrintCheckStop(Items[nIndex]);
              GRegistry.Modules.KKM.DisconnectBlock;
            end;
            if (Status = ssActive) or
               ((Status = ssReserve) and (TimeStart>=GetVirtualTime)) then
              //Стопим только если актив или бронь уже наступила
              CompStop(ComputersGetIndex(FnIdComp));
            Delete(nIndex);
          end;
end;

function TGCSessions.Check:boolean ;
var
  i : integer;
  computer: Tcomputer;
  tarif: TTarif;
  bActionCanceled: Boolean;
  ChangeSessions:boolean;
begin
  ChangeSessions := False;

  if (isManager) then begin
    for i:=Count-1 downto 0 do
      with Items[i] do
        if (Status = ssActive)
            and ((TimeStop <= GetVirtualTime) or IsTimeOff) then begin
          Stop(TimeStop <= GetVirtualTime);
          Delete(i);
          ChangeSessions := True;
        end;
    Result := ChangeSessions;
    exit;
  end;
  for i:=Count-1 downto 0 do
    with Items[i] do begin
      if (Status = ssActive) then begin
        if (RecalcStopTime) then begin
          UpdateTimeStopOnDB;
        end;
        if (RecalcTimeCost) then begin
          UpdateTimeCostOnDB;
        end;
        computer := Comps[ComputersGetIndex(FnIdComp)];
//        computer.busy := true;
        tarif := tarifs[FnTarifIndex];
        if(GRegistry.Modules.Internet.SummaryAccounting) then begin
          if (tarif.internet = 1) then begin
            UpdateTraffic(FProxy.IPTrafficGetTraffic(computer.ipaddr));
            //Вообще этому тут не место TODO
            UDPSend(computer.ipaddr, STR_CMD_CLIENT_INFO_SET + '='
                + 'InternetAvailableInKB'
                + '/' + IntToStr(Round(CurrentSeparateTrafficLimit / 1024)));
            UDPSend(computer.ipaddr, STR_CMD_CLIENT_INFO_SET + '='
                + 'InternetUsedInKB'
                + '/' + IntToStr(Round(CurrentTraffic / 1024)));
            // и конец сеанса нужно обновлять, ибо он уменьшается
            UDPSend(computer.ipaddr, STR_CMD_CLIENT_INFO_SET + '='
                + 'Stop'
                + '/' + DateTimeToStr(TimeStop));
            if (not tarif.GetWholeTrafficSeparatePayment(Whole)) or
                (tarif.GetWholeTrafficSeparatePayment(Whole) and
                (CurrentTraffic <= CurrentSeparateTrafficLimit) and
                (CurrentSeparateTrafficLimit > 0)) then begin
              FProxy.IPEnable(computer.ipaddr,GetStrTarif);
              //Т.к. лимит в Кбит а нужно в Кбайт умножаем на 8
              FProxy.IPSetSpeedLimit(computer.ipaddr, tarif.SpeedLimitInKB * 8);
              FProxy.IPSetGroup(computer.ipaddr,tarif.PluginGroupName);
              FProxy.IPSetTrafficLimit(computer.ipaddr,
                  Round(CurrentSeparateTrafficLimit));
            end else
              FProxy.IPDisable(computer.ipaddr);
          end
          else
            FProxy.IPDisable(computer.ipaddr);
        end;
        // забыл про фри модуль
        if(GRegistry.Modules.Internet.LinuxFree) then begin
          if (tarif.internet = 1) then
              FProxy.IPEnable(computer.ipaddr, GetStrTarif)
          else
            FProxy.IPDisable(computer.ipaddr);
        end;

        if (TimeStop <= (GetVirtualTime + EncodeTime (0,0,4,0))) or IsTimeOff then begin
          //formMain.timerGSessionsLoad.Enabled := False;
          bActionCanceled := False;
          if GRegistry.Modules.KKM.Active then begin
            bActionCanceled := not PrintCheckStop(Items[i])
                and GRegistry.Modules.KKM.DisconnectBlock;
          end;
          if bActionCanceled then
            Console.AddEvent(EVENT_ICON_INFORMATION, LEVEL_1,
                'Операция отменена из-за ошибки ККМ: '
                + GKKMPlugin.GetLastError)
          else begin
            Stop(TimeStop <= (GetVirtualTime + EncodeTime (0,0,4,0)));
            if (computer.a.state = ClientState_Session) then
              SendAuthGoState2(index);
          end;
          //formMain.timerGSessionsLoad.Enabled := True;
          ChangeSessions := True;
        end;
      end;
      if (Status = ssReserve) and (TimeStart <= GetVirtualTime) then begin
        if (TimeStop <= GetVirtualTime) then begin
          if (Comps[ComputersGetIndex(FnIdComp)].session = Items[i]) then
            Comps[ComputersGetIndex(FnIdComp)].session := Nil;
          // заблокировать без связи с ККМ тут не получится
          // потому просто печатаем чек
          if GRegistry.Modules.KKM.Active then begin
            PrintCheckStop(Items[i]);
            GRegistry.Modules.KKM.DisconnectBlock;
          end;
          Delete(i);
        end
        else
          Comps[ComputersGetIndex(FnIdComp)].session := Items[i];
      end;
      if Status = ssFinished then
        Delete(i);
    end;
  Result := ChangeSessions;
end;

procedure TGCSession.SetStatus(AnStatus : TGCSessionStatus);
var
  computer: TComputer;
begin
  if (AnStatus = ssActive) then
    with Comps[ComputersGetIndex(FnIdComp)] do begin
      session := Self;
      a.number := FnIdClient;
    end;
  FnStatus := AnStatus;
end;

procedure TGCSession.SetState(AnState : TClientState);
var
  computer: TComputer;
begin
  if (FnStatus = ssActive) then
    Comps[ComputersGetIndex(FnIdComp)].a.state := AnState;
  FnState := AnState;
end;

function TGCSessions.GetIsBadDesignedSessions:Boolean;
var
  i,j:Integer;
  bBad:Boolean;
  fInterval : Double;
begin
  bBad := False;
  fInterval := EncodeTime(0,1,0,0);//0.001; //Должно быть 1 минута
  for i:=0 to Count-1 do
    if (Items[i].Status = ssDesigned) then
      for j:=0 to Count-1 do
        if (i<>j) and (Items[i].IdComp = Items[j].IdComp) and
          (
           (Items[j].Status = ssDesigned) or
           ((Items[j].Status <> ssDesigned) and
            (
             ((Items[i].TimeStart >= (Items[j].TimeStart + fInterval)) or
              (Items[i].TimeStop >= (Items[j].TimeStart + fInterval))) and
             ((Items[i].TimeStart <= (Items[j].TimeStop - fInterval)) or
              (Items[i].TimeStop <= (Items[j].TimeStop - fInterval)))))
          ) then
          bBad := True;
  Result := bBad;
end;

function TGCSessions.GetMaxStopTime(AnIdComp: Integer):TDateTime;
var
  i:Integer;
  fInterval : Double;
  dtMaxStopTime: TDateTime;
begin
  dtMaxStopTime := GetVirtualTime() + + EncodeTime(12,0,0,0)*4; //48 часов хватит
  fInterval := EncodeTime(0,round(GRegistry.Options.MinIntervalBetvenReserved/60),GRegistry.Options.MinIntervalBetvenReserved - (round(GRegistry.Options.MinIntervalBetvenReserved/60)*60),0);//0.001; //Должно быть 1 минута
  for i:=0 to Count-1 do
    if (Items[i].IdComp = AnIdComp) and (Items[i].Status = ssReserve) and
      (dtMaxStopTime > (Items[i].TimeStart + fInterval)) then
      dtMaxStopTime := Items[i].TimeStart - fInterval;
  Result := dtMaxStopTime;
end;

function TGCSessions.GetDesignedMaxStopTime:TDateTime;
var
  i:Integer;
  fInterval : Double;
  dtMaxStopTime: TDateTime;
  dtCurrentMaxStopTime: TDateTime;
begin
  dtMaxStopTime := GetVirtualTime() + EncodeTime(12,0,0,0)*4; //48 часов хватит
  fInterval := EncodeTime(0,1,0,0);//0.001; //Должно быть 1 минута
  for i:=0 to Count-1 do
    if (Items[i].Status = ssDesigned) then begin
      dtCurrentMaxStopTime := GetMaxStopTime(Items[i].IdComp);
      if dtMaxStopTime > dtCurrentMaxStopTime then
        dtMaxStopTime := dtCurrentMaxStopTime;
    end;
  Result := dtMaxStopTime;
end;

function TGCSession.CurrentAdditionalSeparateTraffic: Double;
begin
  Result := 0;
  if not (CompareValue(FfCurrentSeparateTrafficPay, 0) = EqualsValue) then
    Result := RoundTo(FfCurrentSeparateTrafficPay / ByteTrafficCost, 0);
end;

function TGCSession.CurrentFreeSeparateTrafficLimit: Double;
begin
  Result := tarifs[FnTarifIndex].GetWholeTrafficLimit(Whole,
      TimeStart, TimeStop);
end;

function TGCSession.CurrentSeparateTrafficLimit: Double;
begin
  Result := CurrentFreeSeparateTrafficLimit + CurrentAdditionalSeparateTraffic;
end;

function TGCSession.IsPacketTarif: Boolean;
var
  tv: TTarifVariants;
begin
  Result := False;
  tv := tarifs[FnTarifIndex].GetTarifVariantByWhole(Whole,TimeStart,0);
  if (tv <> nil) and tv.ispacket then
    Result := True;
end;

function TGCSession.IsFreePacketTarif: Boolean;
var
  tv: TTarifVariants;
begin
  Result := False;
  tv := tarifs[FnTarifIndex].GetTarifVariantByWhole(Whole,TimeStart,0);
  if (tv <> nil) and tv.ispacket and tv.FreePacket then
    Result := True;
end;


//без названия пакетов
function TGCSession.ShortTarifName: String;
begin
  Result := GetTarifName(FnIdTarif, 0);
end;

function TGCSession.GetIPAddress: String;
begin
  Result := Comps[ComputersGetIndex(IdComp)].ipaddr;
end;

procedure TGCSessions.PrepareDesignedForDeletion;
var
  i: Integer;
begin
  for i:=0 to Count-1 do
    if (Items[i].Status = ssDesigned) then
      Items[i].Reloaded := False;
end;

procedure TGCSessions.DeleteOldDesigned;
var
  i: Integer;
begin
  for i := Count-1 downto 0  do
    if (Items[i].Status = ssDesigned) and not Items[i].Reloaded then
      Delete(i);
end;

function TGCSession.Tariff: TTarif;
begin
  Result := Tarifs[FnTarifIndex];
end;

function TGCSession.ComputerGroupId: Integer;
begin
  Result := Comps[ComputersGetIndex(FnIdComp)].IdGroup;
end;

function TGCSession.CommonCost:Double;
begin
  //Из-за тарифов с доплатой, деньги нужно просчитать до изменения FdtStop
  if (not PostPay and IsGuest //Для клиентов ВСЕГДА дается скидка
      and GRegistry.Options.DisableChange
      and not (GRegistry.Options.EnableChangeForReserveCancel
      and (Status = ssReserve))
      and (CommonPay >= GetCostTotal)) then
    Result := CommonPay
  else
    Result := GetCostTotal;
end;

function TGCSession.SeparateTrafficCost:Double;
begin
  //Из-за тарифов с доплатой, деньги нужно просчитать до изменения FdtStop
  if (not PostPay and IsGuest //Для клиентов ВСЕГДА дается скидка
      and GRegistry.Options.DisableChange
      and not GRegistry.Options.EnableChangeForSeparateTraffic
      and not (GRegistry.Options.EnableChangeForSeparateTraffic
      and GRegistry.Options.EnableChangeForReserveCancel
      and (Status = ssReserve))
      and (FfSeparateTrafficPay >= FfSummarySeparateTrafficCost)) then
    Result := FfSeparateTrafficPay
  else
    Result := FfSummarySeparateTrafficCost;
end;

procedure TGCSession.UpdateTraffic(AnTrafficDiff: Longword);
begin
  if (AnTrafficDiff > 0) then begin
   // FfCurrentTraffic := FfCurrentTraffic + AnTrafficDiff;
    if IsTrafficSeparatePayment then begin
      // т.к. FreeTraffic может увеличиться пересчитываем каждый раз Diff
      UpdateOnDB(0, 0, 0, CalculatedCurrentSeparateTrafficCost
          - FfCurrentSeparateTrafficCost, 0, 0, AnTrafficDiff, 0);
      //FfCurrentTrafficCost := CalculatedCurrentSeparateTrafficCost;
      FfCurrentSeparateTrafficCost := FfSummarySeparateTrafficCost;
    end else begin
      UpdateOnDB(0, 0, (AnTrafficDiff * ByteTrafficCost)
         , 0, 0, 0, AnTrafficDiff, 0);
      FfCurrentTrafficCost := RoundMoney(FfCurrentTraffic * ByteTrafficCost);
    end;
  end;
end;

procedure TGCSession.UpdatePrinted(const AfPrintedCostDiff: Double);
begin
  UpdateOnDB(0, 0, 0, 0, AfPrintedCostDiff, 0, 0, 0);
end;

function TGCSession.ResultCostForKKM: Double;  // CommonCost + SeparateTrafficCost
begin
  Result := CommonCost + SeparateTrafficCost;
end;

function TGCSession.Change: Double;
begin
  if PostPay then
    Result := - CommonCost - SeparateTrafficCost
  else
    Result := CommonPay + SeparateTrafficPay - CommonCost - SeparateTrafficCost;
end;

function TGCSession.MoneyInfo: String;
var
  lstInfo: TStringList;
  tempMoney: double;
  dtStop: TDateTime;
begin
  Result := '';
  lstInfo := TStringList.Create;
  dtStop := GetVirtualTime;
  if (Status = ssReserve) or (IsGuest and not PostPay) then begin
    lstInfo.Add(Format(INFO_COMMONPAY, [CommonPay]));
    if CompareValue(SeparateTrafficPay, 0) = GreaterThanValue	then
      lstInfo.Add(Format(INFO_SEPARATETRAFFICPAY, [SeparateTrafficPay]));
  end;
  if (Status <> ssReserve) then begin
    lstInfo.Text := lstInfo.Text + TimeAndTrafficInfo;
    if CompareValue(PrintCost, 0) = GreaterThanValue	then
      lstInfo.Add(Format(INFO_PRINT, [PrintCost]));
    if CompareValue(ServiceCost, 0) = GreaterThanValue	then
      lstInfo.Add(Format(INFO_SERVICE, [ServiceCost]));
    lstInfo.Add(Format(INFO_TOTAL, [CommonCost + SeparateTrafficCost]));
  end;
  Result := lstInfo.Text;
  FreeAndNil(lstInfo);
end;

function TGCSession._TrafficInfo(const AfTraffic: Double;
    const AfTrafficCost: Double; const AfSeparateTrafficCost: Double;
    const AbIndention: Boolean): String;
var
  lstInfo: TStringList;
  bCost, bSeparateCost: Boolean;
  strIndention: String;
begin
  Result := '';
  lstInfo := TStringList.Create;
  if AbIndention then
    strIndention := INFO_INDENTION
  else
    strIndention := '';
  bCost := (CompareValue(AfTrafficCost, 0) = GreaterThanValue);
  bSeparateCost := (CompareValue(AfSeparateTrafficCost, 0) = GreaterThanValue);
  if bCost and bSeparateCost then
    lstInfo.Text := lstInfo.Text + strIndention + Format(INFO_MIXEDTRAFFIC,
        [GetShortSizeString(AfTraffic), AfTrafficCost, AfSeparateTrafficCost])
  else if bCost then
    lstInfo.Text := lstInfo.Text + strIndention + Format(INFO_TRAFFIC,
        [GetShortSizeString(AfTraffic), AfTrafficCost])
  else if bSeparateCost then
    lstInfo.Text := lstInfo.Text + Format(strIndention + INFO_SEPARATETRAFFIC,
        [GetShortSizeString(AfTraffic), AfSeparateTrafficCost]);
  Result := lstInfo.Text;
  FreeAndNil(lstInfo);
end;

function TGCSession.TimeAndTrafficInfo: String;
var
  lstInfo: TStringList;
  bDiffirence: Boolean;
begin
  Result := '';
  if (Status <> ssReserve) then begin
    lstInfo := TStringList.Create;
    bDiffirence := (CompareValue(CommonPay, CurrentCommonPay) <> EqualsValue)
        or (CompareValue(SummaryTraffic, CurrentTraffic) <> EqualsValue);
    if bDiffirence then begin
      lstInfo.Add(INFO_PREV_TARIF);
      lstInfo.Add(INFO_INDENTION
          + Format(INFO_TIME, [TimeToStr(TimeStart - Started), CommonPay
          - CurrentCommonPay]));
      if (CompareValue(SummaryTraffic - CurrentTraffic, 0)
          = GreaterThanValue)	then
        lstInfo.Text := lstInfo.Text
            + _TrafficInfo(SummaryTraffic - CurrentTraffic,
            FfSummaryTrafficCost - FfCurrentTrafficCost,
            FfSummarySeparateTrafficCost - FfCurrentSeparateTrafficCost,
            bDiffirence);
      lstInfo.Add(INFO_CURRENT_TARIF);
    end;
    lstInfo.Add(IfThen(bDiffirence,INFO_INDENTION,'')
        + Format(INFO_TIME, [TimeToStr(TimeStop - TimeStart),
        CurrentTimeCost]));
    if (CompareValue(CurrentTraffic, 0) = GreaterThanValue)	then
      lstInfo.Text := lstInfo.Text
          + _TrafficInfo(CurrentTraffic, FfCurrentTrafficCost,
          FfCurrentSeparateTrafficCost, bDiffirence);
    Result := lstInfo.Text;
    FreeAndNil(lstInfo);
  end;
end;

function TGCSession.RoundMoney(AfMoney: Double): Double;
var
  tarif: TTarif;
begin
  Result := AfMoney;
  if (FnIdTarif <> ID_TARIF_REMONT) then begin
    tarif := Tarifs[FnTarifIndex];
    Result := tarif.fnRoundMoney(AfMoney, tarif.roundmoney, 1);
  end;
end;

procedure TGCSession.SetIdTarif(AnIdTarif : Longword);
begin
  FnIdTarif := AnIdTarif;
  FnTarifIndex := TarifsGetIndex(AnIdTarif);
end;

end.
