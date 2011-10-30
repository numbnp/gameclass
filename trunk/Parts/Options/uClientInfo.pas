//////////////////////////////////////////////////////////////////////////////
//
// Модуль содержит описание и реализацию класса TClientInfo.
// Класс предоставляет в виде свойств набор опций для настройки работы
// программы GCClient.
//
// Класс реализован по шаблону Singleton.
// Для доступа к свойствам и методам класса используйте вызовы
// TClientInfo.Instance."MethodName" или вспомогательную переменную ClientOptions.
//
//////////////////////////////////////////////////////////////////////////////

unit uClientInfo;
{$IFDEF LINUX}
  {$DEFINE GCCL}
  {$DEFINE GCCLSRV}
{$ENDIF}

interface

uses
  Classes,
  uY2KCommon,
  uClientInfoConst,
{$IFDEF MSWINDOWS}
  uClientOptionsRegistryStorage;
{$ENDIF}
{$IFDEF LINUX}
  uClientOptionsIniStorage;
{$ENDIF}
  // project units

type


  //
  // TClientInfo
  //

  TClientInfo = class(TObject)
  private
    // fields
{$IFDEF LINUX}
    FClientInfoStorage: TClientOptionsIniStorage;
{$ENDIF}
{$IFDEF MSWINDOWS}
    FClientInfoStorage: TClientOptionsRegistryStorage;
{$ENDIF}

    // наличие измененных и не сохраненных значений
    FbDirty: Boolean;

    FbBlocked: Boolean;
    FnClientState: TClientState;
    FstrLogin: String;
    FfBalance: Double;
    FfBalanceLimit: Double;
    FstrBalanceHistory: String;
    FstrInfo: String;
    FstrFullInfo: String;
    FfSum: Double;
    FdtStart: TDateTime;
    FdtStop: TDateTime;
    FdtNowTime: TDateTime;
    FstrTarifName: String;
    FbTrafficSeparatePayment: Boolean;
    FnSecCode: Integer;
    FbIsFirstRun: Boolean;
    FbUnblockedByPassword: Boolean;
{$IFDEF GCCLSRV}
    FdtLastPing: TDateTime;
    FbNotConnected: Boolean;
    FbGCCLNotStarted: Boolean;
    FbDisconnected: Boolean;
{$ENDIF}
{$IFDEF GCCL}
    FdtLastKeyDown: TDateTime;
{$ENDIF}
    FbInternet: Boolean;
    FnInternetAvailableInKB: Integer;
    FnInternetUsedInKB: Integer;
    FlstRunPadHidedTabs: TStringList;
    FstrInstallDirectory: String;
    FstrServerIPAddress: String;
    FstrIPAddress: String;
    FbAfterStopActionNeeded: Boolean;

  protected
    // constructor / destructor
    constructor CreateInstance();

    // class methods
    class function AccessInstance(
        const ARequest: TSingletonOperation): TClientInfo;

    // properties methods
    procedure SetBlocked(const AbBlocked: Boolean);
    procedure SetClientState(
        const AClientState: TClientState);
    procedure SetLogin(const AstrLogin: String);
    procedure SetBalance(const AfBalance: Double);
    procedure SetBalanceLimit(const AfBalanceLimit: Double);
    procedure SetBalanceHistory(const AstrBalanceHistory: String);
    procedure SetInfo(const AstrInfo: String);
    procedure SetFullInfo(const AstrFullInfo: String);
    procedure SetSum(const AfSum: Double);
    procedure SetStart(const AdtStart: TDateTime);
    procedure SetStop(const AdtStop: TDateTime);
    procedure SetNowTime(const AdtStart: TDateTime);
    procedure SetTarifName(const AstrTarifName: String);
    procedure SetTrafficSeparatePayment(
        const AbTrafficSeparatePayment: Boolean);
    procedure SetSecCode(const AnSecCode: Integer);
    procedure SetInternet(const AbInternet: Boolean);
    procedure SetInternetAvailableInKB(const AnInternetAvailableInKB: Integer);
    procedure SetInternetUsedInKB(const AnInternetUsedInKB: Integer);
    procedure SetRunPadHidedTabs(const AlstRunPadHidedTabs: TStringList);

  public
    // constructor / destructor
    constructor Create();
    destructor Destroy(); override;

    // methods
    procedure Clear(AbUseSetState: Boolean);

    procedure Init; //Для СЕРВИСА !!!
    function GetResultBlocking: Boolean; //заблокировано в конце-концов или нет
    function IsSession: Boolean;
{$IFDEF GCCLSRV}
    function IsFirstRun: Boolean;
    function IsDisconnected: Boolean; //отключился
    function IsNotConnected: Boolean; //даже не подключился
    procedure SetLastPing(const AdtValue: TDateTime);
    procedure SetDisconnected(const AbValue: Boolean);
{$ENDIF}
{$IFDEF GCCL}
    function IsStandby: Boolean;
{$ENDIF}
    procedure SetRunPadHidedTabsAsText(const AstrRunPadHidedTabs: String);
    function GetAfterStopActionNeeded: Boolean;
    procedure SetAfterStopActionNeeded(const AbValue: Boolean);
    procedure SetServerIPAddress(const AstrValue: String);


    // class methods
    class function Instance(): TClientInfo;
    class procedure ReleaseInstance();
    procedure Load();
    procedure Save();
    procedure SaveIfNeeded();
    // private helper methods
    function _GetStringOption(const AstrFolder: String;
        const AstrName: String; const AstrDefaultValue: String): String;
    function _GetIntegerOption(const AstrFolder: String;
        const AstrName: String; const AnDefaultValue: Integer): Integer;
    function _GetBooleanOption(const AstrFolder: String;
        const AstrName: String; const AbDefaultValue: Boolean): Boolean;
    function _GetFloatOption(const AstrFolder: String;
        const AstrName: String; const AfDefaultValue: Double): Double;

    // properties
    property Dirty: Boolean
        read FbDirty;
    // блокировка влючена
    property Blocked: Boolean
        read FbBlocked write SetBlocked;
    // состояния авторизации
    property ClientState: TClientState
        read FnClientState write SetClientState;
    // имя клиента
    property Login: String
        read FstrLogin write SetLogin;
    // состояние баланса
    property Balance: Double
        read FfBalance write SetBalance;
    // состояние предела баланса
    property BalanceLimit: Double
        read FfBalanceLimit write SetBalanceLimit;
    // история баланса
    property BalanceHistory: String
        read FstrBalanceHistory write SetBalanceHistory;
    // информация
    property Info: String
        read FstrInfo write SetInfo;
    // полная информация
    property FullInfo: String
        read FstrFullInfo write SetFullInfo;
    // оплаченные деньги сессии
    property Sum: Double
        read FfSum write SetSum;
    // время старта сессии
    property Start: TDateTime
        read FdtStart write SetStart;
    // время окончания сессии
    property Stop: TDateTime
        read FdtStop write SetStop;
    // текущее время сервера
    property NowTime: TDateTime
        read FdtNowTime write SetNowTime;
    // имя тарифа
    property TarifName: String
        read FstrTarifName write SetTarifName;
    // отдельная плата за трафик
    property TrafficSeparatePayment: Boolean
        read FbTrafficSeparatePayment write SetTrafficSeparatePayment;
    // номер дополнительного кода
    property SecCode: Integer
        read FnSecCode write SetSecCode;
    // разблокировано по паролю
    property UnblockedByPassword: Boolean
        read FbUnblockedByPassword write FbUnblockedByPassword;
{$IFDEF GCCLSRV}
    //время последнего пинга
    property LastPingTime: TDateTime
        read FdtLastPing write SetLastPing;
    //запущенность клиента
    property GCCLNotStarted: Boolean
        read FbGCCLNotStarted write FbGCCLNotStarted;
    //дисконнект высавляется в DoCheck по IsDisconnect
    property Disconnected: Boolean
        read FbDisconnected write SetDisconnected;
{$ENDIF}
{$IFDEF GCCL}
    //время нажатия клавиши
    property LastKeyDown: TDateTime
        read FdtLastKeyDown write FdtLastKeyDown;
{$ENDIF}
    //заблокировано в конце-концов или нет
    property ResultBlocking: Boolean
        read GetResultBlocking;
    // есть ли вообще интернет
    property Internet: Boolean
        read FbInternet write SetInternet;
    // трафика доступно в КБ
    property InternetAvailableInKB: Integer
        read FnInternetAvailableInKB write SetInternetAvailableInKB;
    // трафика потрачено в КБ
    property InternetUsedInKB: Integer
        read FnInternetUsedInKB write SetInternetUsedInKB;
    // список скрытых закладок RunPad Shell
    property RunPadHidedTabs: TStringList
        read FlstRunPadHidedTabs write SetRunPadHidedTabs;
    // IP-адрес клиентской машины
    property IPAddress: String
        read FstrIPAddress;
    // нужно или нет делать что-то после стопа
    property AfterStopActionNeeded: Boolean
        read GetAfterStopActionNeeded write SetAfterStopActionNeeded;
    property ServerIPAddress: String
        read FstrServerIPAddress write SetServerIPAddress;


  end; // TClientInfo


var
  GClientInfo: TClientInfo;


implementation

uses
  // system units
  Types,
  uLocalCommandSender,
  uProtocol,
{$IFDEF MSWINDOWS}
  Windows,
  Registry,
{$ENDIF}
{$IFDEF GCCL}
  ufrmMain,
  uClientConst,
  uSafeStorage,
  {$IFDEF MSWINDOWS}
    ActiveX,
    RS_APILib_TLB,
  {$ENDIF}
{$ENDIF}
{$IFDEF GCCLSRV}
  uClientInfoGetRemoteCommand,
{$ENDIF}
  uDebugLog,
  SysUtils,
  // project units
  DateUtils,
  uClientOptions,
  uClientOptionsConst,
  IdIPWatch,
  uClientScripting;

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

// Exceptions: EAssertionFailed
constructor TClientInfo.Create();
begin
  inherited Create();
  ASSERT(FALSE, Format('Access class %s through Instance only', [ClassName]));
  raise Exception.Create('TClientInfo.Create');
end; // TClientInfo.Create

procedure TClientInfo.Clear(AbUseSetState: Boolean);
begin
  TDebugLog.Instance().Trace5('TClientInfo.Clear ' + BoolToStr(AbUseSetState));
  FbBlocked := DEF_BLOCKED;
  FstrLogin := DEF_LOGIN;
  FfBalance := DEF_BALANCE;
  FfBalanceLimit := DEF_BALANCE_LIMIT;
  FstrBalanceHistory := DEF_BALANCE_HISTORY;
  FstrInfo := DEF_INFO;
  FstrFullInfo := DEF_INFO_FULL;
  FdtStart := DEF_START;
  FdtStop := DEF_STOP;
  FdtNowTime := Now;
  FstrTarifName := DEF_TARIF_NAME;
  FbTrafficSeparatePayment := DEF_TRAFIIC_SEPARATE_PAYMENT;
  FnSecCode := DEF_SEC_CODE;
// надо так для отрисовки
  FnClientState := ClientState_NotInitialized;
  if AbUseSetState then
    SetClientState(ClientState_Blocked)
  else
    FnClientState := ClientState_Blocked;
  FbInternet := DEF_INTERNET;
  FnInternetAvailableInKB := DEF_INTERNET_AVAILABLE;
  FnInternetUsedInKB := DEF_INTERNET_USED;
{$IFDEF GCCLSRV}
  FbDisconnected := DEF_DISCONNECTED;
{$ENDIF}
  FbAfterStopActionNeeded := DEF_AFTER_STOP_ACTION_NEEDED;
//  FlstRunPadHidedTabs.Text := DEF_RUNPAD_HIDED_TABS;
//  SetH
end; // TClientInfo.Clear

procedure TClientInfo.Init;
var
  ipw : TIdIPWatch;
begin
  //Клиент должен быть разблокированным только сразу после установки,
  //если не включен GC-сервер (сейчас это правильно работает),
  //но уже после перезагрузки, даже если сервер еще не включен,
  //клиентская машина должна быть заблокированной,
  //при этом должна быть надпись в окне блокировки как в 3.79.
  //"Нет соединения с сервером".
{$IFDEF GCCLSRV}
  FbBlocked := not IsFirstRun;
//  FbBlocked := True;
{$ENDIF}
{$IFDEF GCCL}
  FbBlocked := DEF_BLOCKED;
{$ENDIF}
  try
    ipw := TIdIPWatch.Create(Nil);
    ipw.HistoryEnabled := False;
    FstrIPAddress := ipw.LocalIP;
    ipw.Free;
  except
    on e: Exception do begin
      Debug.Trace0('TIdIPWatch Error! ' + e.Message);
    end;
  end;
  Debug.Trace5('IPAddress:' + FstrIPAddress);
  FstrServerIPAddress := '';
end;

constructor TClientInfo.CreateInstance();
begin
  inherited Create();
  FbDirty := True;
{$IFDEF LINUX}
  FClientInfoStorage := TClientOptionsIniStorage.Create(COMPANY_NAME,
      PRODUCT_NAME);
{$ENDIF}
{$IFDEF MSWINDOWS}
  FClientInfoStorage := TClientOptionsRegistryStorage.Create(COMPANY_NAME,
      PRODUCT_NAME);
{$ENDIF}
  FbUnblockedByPassword := DEF_UNBLOCKED_BY_PASSWORD;
  FbIsFirstRun := False;
  FlstRunPadHidedTabs := TStringList.Create;
{$IFDEF GCCLSRV}
  FdtLastPing := Now;
  FbNotConnected := True;
  {$IFDEF MSWINDOWS}
  FbGCCLNotStarted := True;
  {$ENDIF}
  {$IFDEF LINUX}
  //Считаем что GCCL запущен, т.к. под Линухом его вообще нет
  FbGCCLNotStarted := False;
  {$ENDIF}
{$ENDIF}
{$IFDEF GCCL}
  FdtLastKeyDown := Now;
{$ENDIF}
//  Clear(False);
  Clear(True);
 // FstrInstallDirectory := GetInstallDirectory;
end; // TClientInfo.CreateInstance


destructor TClientInfo.Destroy();
begin
  if AccessInstance(SinglOper_Access) = Self then begin
    AccessInstance(SinglOper_Destroy);
  end;
  FreeAndNilWithAssert(FClientInfoStorage);
  inherited Destroy();
end; // TClientInfo.Destroy


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// class methods

class function TClientInfo.AccessInstance(
    const ARequest: TSingletonOperation): TClientInfo;
// Константа используется для хранения ссылки на единственный
// экземпляр класса. Такая реализация обусловлена отсутсвием
// в классах Delphi статических полей.
// ВНИМАНИЕ! Для корректной работы необходимо включить {$WRITEABLECONST ON}!
{$WRITEABLECONST ON}
const
  FInstance: TClientInfo = nil;
begin
  case ARequest of
    SinglOper_Access: begin
      // do nothing
    end;

    SinglOper_Create: begin
      if not Assigned(FInstance) then begin
        FInstance := CreateInstance();
      end;
    end;

    SinglOper_Destroy: begin
      FInstance := nil;
    end;

    else begin
      ASSERT(FALSE,
          Format('Illegal request %d in AccessInstance', [Ord(ARequest)]));
    end;
  end;

  Result := FInstance;

{$WRITEABLECONST OFF}
end; // TClientInfo.AccessInstance


class function TClientInfo.Instance(): TClientInfo;
const
  FInstance: TClientInfo = nil;
begin
  Result := AccessInstance(SinglOper_Create);
end; // TClientInfo.Instance


class procedure TClientInfo.ReleaseInstance();
begin
  AccessInstance(SinglOper_Access).Free();
end; // TClientInfo.ReleaseInstance


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// properties methods

procedure TClientInfo.SetClientState(
    const AClientState: TClientState);
var
  bStateChanged: Boolean;
begin
  TDebugLog.Instance().Trace5('ClientInfo.SetClientState old:'
      + IntToStr(Integer(FnClientState))
      + ' new:' + IntToStr(Integer(AClientState)));
  if (FnClientState <> AClientState) then begin
    FbDirty := True;
    FnClientState := AClientState;
{$IFDEF GCCL}           //заменить все остальные
    TSafeStorage.Instance().Push(ThreadSafeOperation_DoDesign,0); //frmMain.Show;
    TSafeStorage.Instance().Push(ThreadSafeOperation_UpdateData,0); //frmMain.UpdateData;
    if (AClientState = ClientState_Blocked)
        or (AClientState = ClientState_Authentication) then begin
      TSafeStorage.Instance().Push(ThreadSafeOperation_MainFormAction,
          Integer(FormAction_Show));
    end;
    if AClientState= ClientState_Order then begin
      //Только тут, так как закладка активируется только при изменении
      TSafeStorage.Instance().Push(ThreadSafeOperation_ActivateTabStartStop,0);
      TSafeStorage.Instance().Push(ThreadSafeOperation_ClearMessages,0);
      LocalSendDataTo(STR_CMD_AUTH_QUERYTARIFS_2,False);
    end;
    if AClientState = ClientState_Session then begin
      if GClientOptions.ShowSmallInfo then
        TSafeStorage.Instance().Push(ThreadSafeOperation_SmallInfoFormAction,
            Integer(FormAction_Show));
    end;
    if AClientState = ClientState_OperatorSession then begin
      TSafeStorage.Instance().Push(ThreadSafeOperation_ClearMessages,0);
      TSafeStorage.Instance().Push(ThreadSafeOperation_MainFormAction,
          Integer(FormAction_Hide));
      if GClientOptions.ShowSmallInfo then
        TSafeStorage.Instance().Push(ThreadSafeOperation_SmallInfoFormAction,
            Integer(FormAction_Show));
    end;
{$ENDIF}
{$IFDEF GCCLSRV}
    RunClientScript(caStateChanged);
{$ENDIF}
  end;
end; // TClientInfo.SetClientState

procedure TClientInfo.SetBlocked(const AbBlocked: Boolean);
var
  bBlockChanged: Boolean;
begin
  if FbBlocked <> AbBlocked then begin
    FbDirty := True;
    FbBlocked := AbBlocked;
{$IFDEF GCCLSRV}
{$IFDEF MSWINDOWS}
    LocalSendDataTo(STR_CMD_CLIENT_INFO_SET+'=Blocked/' + BoolToStr(FbBlocked),
        True);
{$ENDIF}
    if bBlockChanged then begin
      if FbBlocked then
        RunClientScript(caBlocking)
      else
        RunClientScript(caUnblocking);
    end;
{$ENDIF}
  end;
end; // TClientInfo.SetBlocked

procedure TClientInfo.SetTarifName(const AstrTarifName: String);
begin
  if FstrTarifName <> AstrTarifName then begin
    FbDirty := True;
    FstrTarifName := AstrTarifName;
{$IFDEF GCCL}
//    TSafeStorage.Instance().Push(ThreadSafeOperation_UpdateControlFromClientInfo,
//        Integer(UpdatedControl_cboTarifs));
  TSafeStorage.Instance().Push(ThreadSafeOperation_UpdateControlFromClientInfo,
      Integer(UpdatedControl_cboTarifs));
{$ENDIF}
{$IFDEF GCCLSRV}
    RunClientScript(caTarifChanged);
{$ENDIF}
  end;
end; // TClientOptions.SetTarifNames

procedure TClientInfo.SetSecCode(const AnSecCode: Integer);
begin
  if FnSecCode <> AnSecCode then begin
    FbDirty := True;
    FnSecCode := AnSecCode;
{$IFDEF GCCL}
    TSafeStorage.Instance().Push(ThreadSafeOperation_DoDesign, 0); //frmMain.Show;
{$ENDIF}
  end;
end;

procedure TClientInfo.SetStart(const AdtStart: TDateTime);
begin
  if FdtStart <> AdtStart then begin
    FbDirty := True;
    FdtStart := AdtStart;
{$IFDEF GCCL}
  TSafeStorage.Instance().Push(ThreadSafeOperation_UpdateControlFromClientInfo,
      Integer(UpdatedControl_edtStart));
  TSafeStorage.Instance().Push(ThreadSafeOperation_UpdateControlFromClientInfo,
      Integer(UpdatedControl_dtpTime));
  if GClientOptions.ShowSmallInfo then
    TSafeStorage.Instance().Push(ThreadSafeOperation_SmallInfoFormAction,
        Integer(FormAction_Update));
{$ENDIF}
  end;
end;

procedure TClientInfo.SetNowTime(const AdtStart: TDateTime);
begin
  if FdtStart <> AdtStart then begin
    FbDirty := True;
    FdtNowTime := AdtStart;
  {$IFDEF GCCL}
{    TSafeStorage.Instance().Push(ThreadSafeOperation_UpdateControlFromClientInfo,
        Integer(UpdatedControl_edtStop)); 
    TSafeStorage.Instance().Push(ThreadSafeOperation_UpdateControlFromClientInfo,
        Integer(UpdatedControl_dtpTime));}
    if GClientOptions.ShowSmallInfo then
      TSafeStorage.Instance().Push(ThreadSafeOperation_SmallInfoFormAction,
          Integer(FormAction_Update));
{$ENDIF}
  end;
end;


procedure TClientInfo.SetSum(const AfSum: Double);
begin
  Debug.Trace5('USetSum 1');
  if FfSum <> AfSum then begin
    FbDirty := True;
    FfSum := AfSum;
  Debug.Trace5('USetSum 2' + FloatToStr(AfSum));
{$IFDEF GCCL}
  Debug.Trace5('USetSum 3');
  TSafeStorage.Instance().Push(ThreadSafeOperation_UpdateControlFromClientInfo,
      Integer(UpdatedControl_edtSum));
  if GClientOptions.ShowSmallInfo then
    TSafeStorage.Instance().Push(ThreadSafeOperation_SmallInfoFormAction,
        Integer(FormAction_Update));
  Debug.Trace5('USetSum 4');
{$ENDIF}
  end;
end;

procedure TClientInfo.SetStop(const AdtStop: TDateTime);
begin
  if FdtStop <> AdtStop then begin
    FbDirty := True;
    FdtStop := AdtStop;
{$IFDEF GCCL}
  TSafeStorage.Instance().Push(ThreadSafeOperation_UpdateControlFromClientInfo,
      Integer(UpdatedControl_edtStop));
  TSafeStorage.Instance().Push(ThreadSafeOperation_UpdateControlFromClientInfo,
      Integer(UpdatedControl_dtpTime));
  if GClientOptions.ShowSmallInfo then
    TSafeStorage.Instance().Push(ThreadSafeOperation_SmallInfoFormAction,
        Integer(FormAction_Update));
{$ENDIF}
  end;
end;

procedure TClientInfo.SetInternet(const AbInternet: Boolean);
begin
  if FbInternet <> AbInternet then begin
    FbDirty := True;
    FbInternet := AbInternet;
{$IFDEF GCCL}
  if GClientOptions.ShowSmallInfo then
    TSafeStorage.Instance().Push(ThreadSafeOperation_SmallInfoFormAction,
        Integer(FormAction_Update));
{$ENDIF}
{$IFDEF GCCLSRV}
  if FbInternet then
    RunClientScript(caEnableInternet)
  else
    RunClientScript(caDisableInternet);
{$ENDIF}
  end;
end;

procedure TClientInfo.SetInternetAvailableInKB(
    const AnInternetAvailableInKB: Integer);
begin
  if FnInternetAvailableInKB <> AnInternetAvailableInKB then begin
    FbDirty := True;
    FnInternetAvailableInKB := AnInternetAvailableInKB;
{$IFDEF GCCL}
  if GClientOptions.ShowSmallInfo then
    TSafeStorage.Instance().Push(ThreadSafeOperation_SmallInfoFormAction,
        Integer(FormAction_Update));
{$ENDIF}
  end;
end;

procedure TClientInfo.SetInternetUsedInKB(const AnInternetUsedInKB: Integer);
begin
  if FnInternetUsedInKB <> AnInternetUsedInKB then begin
    FbDirty := True;
    FnInternetUsedInKB := AnInternetUsedInKB;
{$IFDEF GCCL}
  if GClientOptions.ShowSmallInfo then
    TSafeStorage.Instance().Push(ThreadSafeOperation_SmallInfoFormAction,
        Integer(FormAction_Update));
{$ENDIF}
  end;
end;

procedure TClientInfo.SetTrafficSeparatePayment(
    const AbTrafficSeparatePayment: Boolean);
begin
  if FbTrafficSeparatePayment <> AbTrafficSeparatePayment then begin
    FbDirty := True;
    FbTrafficSeparatePayment := AbTrafficSeparatePayment;
{$IFDEF GCCL}
  TSafeStorage.Instance().Push(ThreadSafeOperation_DoDesign, 0);
{$ENDIF}
  end;
end;

procedure TClientInfo.SetRunPadHidedTabs(
    const AlstRunPadHidedTabs: TStringList);
begin
  if FlstRunPadHidedTabs.Text <> AlstRunPadHidedTabs.Text then begin
    FbDirty := True;
    FlstRunPadHidedTabs.Text := AlstRunPadHidedTabs.Text;
{$IFDEF GCCL}
    TSafeStorage.Instance().Push(ThreadSafeOperation_RunPadAction,
        Integer(RunPadAction_HideTabs));
{$ENDIF}
  end;
end; // TClientInfo.SetRunPadHidedTabs

procedure TClientInfo.SetLogin(const AstrLogin: String);
begin
  if FstrLogin <> AstrLogin then begin
    FbDirty := True;
    FstrLogin := AstrLogin;
  end;
end; // TClientInfo.SetLogin

procedure TClientInfo.SetBalance(const AfBalance: Double);
begin
  if FfBalance <> AfBalance then begin
    FbDirty := True;
    FfBalance := AfBalance;
  end;
end; // TClientInfo.SetBalance

procedure TClientInfo.SetBalanceLimit(const AfBalanceLimit: Double);
begin
  if FfBalanceLimit <> AfBalanceLimit then begin
    FbDirty := True;
    FfBalanceLimit := AfBalanceLimit;
  end;
end; // TClientInfo.Set

procedure TClientInfo.SetBalanceHistory(const AstrBalanceHistory: String);
begin
  if FstrBalanceHistory <> AstrBalanceHistory then begin
    FbDirty := True;
    FstrBalanceHistory := AstrBalanceHistory;
  end;
end; // TClientInfo.SetBalanceHistory

procedure TClientInfo.SetInfo(const AstrInfo: String);
begin
  if FstrInfo <> AstrInfo then begin
    FbDirty := True;
    FstrInfo := AstrInfo;
  end;
end; // TClientInfo.SetInfo

procedure TClientInfo.SetFullInfo(const AstrFullInfo: String);
begin
  if FstrFullInfo <> AstrFullInfo then begin
    FbDirty := True;
    FstrFullInfo := AstrFullInfo;
  end;
end; // TClientInfo.SetFullInfo


{$IFDEF GCCL}
function TClientInfo.IsStandby: Boolean;
begin
  Result := (MinutesBetween(LastKeyDown,Now)>=1);
end;
{$ENDIF}

function TClientInfo.IsSession: Boolean;
begin
  Result := (GClientInfo.ClientState = ClientState_Session)
      or (GClientInfo.ClientState = ClientState_OperatorSession);
end;


{$IFDEF GCCLSRV}
{$IFDEF MSWINDOWS}
//возвращает True только при первом запросе при первом запуске
function TClientInfo.IsFirstRun: Boolean;
var
  Reg: TRegIniFile;
  FstrKey: String;
  AstrValue: String;
begin
  Result := False;
  FstrKey := '\' + 'Software' + '\' + COMPANY_NAME + '\' + PRODUCT_NAME;
  Reg := TRegIniFile.Create();
  if not FbIsFirstRun then
    try
      Reg.RootKey := HKEY_LOCAL_MACHINE;
      Reg.Access := KEY_ALL_ACCESS;
      if Reg.OpenKey(FstrKey, TRUE) then begin
        AstrValue := Reg.ReadString(OPTIONS_GENERAL_FOLDER, 'Installation', '0');
        Result := StrToBool(AstrValue);
        FbIsFirstRun := Result;
        Reg.DeleteKey(OPTIONS_GENERAL_FOLDER,'Installation');
        Reg.CloseKey();
      end;
    finally
      FreeAndNilWithAssert(Reg);
    end
  else
    Result := FbIsFirstRun; //всегда True;
end;
{$ENDIF}
{$IFDEF LINUX}
//возвращает True только при первом запросе при первом запуске
function TClientInfo.IsFirstRun: Boolean;
//var
//  Reg: TRegIniFile;
//  FstrKey: String;
//  AstrValue: String;
begin
  Result := False;
{  FstrKey := '\' + 'Software' + '\' + COMPANY_NAME + '\' + PRODUCT_NAME;
  Reg := TRegIniFile.Create();
  if not FbIsFirstRun then
    try
      Reg.RootKey := HKEY_LOCAL_MACHINE;
      Reg.Access := KEY_ALL_ACCESS;
      if Reg.OpenKey(FstrKey, TRUE) then begin
        AstrValue := Reg.ReadString(OPTIONS_GENERAL_FOLDER, 'Installation', '0');
        Result := StrToBool(AstrValue);
        FbIsFirstRun := Result;
        Reg.DeleteKey(OPTIONS_GENERAL_FOLDER,'Installation');
        Reg.CloseKey();
      end;
    finally
      FreeAndNilWithAssert(Reg);
    end
  else
    Result := FbIsFirstRun; //всегда True;
}    
end;
{$ENDIF}
{$ENDIF}

{$IFDEF GCCLSRV}
function TClientInfo.IsDisconnected: Boolean;
begin
  //если минуту не приходили пинги
  Result := (MinutesBetween(LastPingTime,Now)>=1);
end;

function TClientInfo.IsNotConnected: Boolean;
begin
  Result := FbNotConnected;
end;
{$ENDIF}

function TClientInfo.GetResultBlocking: Boolean;
begin
  //заблокировано в конце-концов или нет
  Result := (GClientInfo.Blocked
      and not(GClientOptions.UnblockPassword
      and GClientInfo.UnblockedByPassword));
end;

procedure TClientInfo.SetRunPadHidedTabsAsText(
    const AstrRunPadHidedTabs: String);
var
   lstRunPadHidedTabs: TStringList;
begin
  lstRunPadHidedTabs := TStringList.Create;
  lstRunPadHidedTabs.Text := AstrRunPadHidedTabs;
  SetRunPadHidedTabs(lstRunPadHidedTabs);
  lstRunPadHidedTabs.Free;
end; // TClientOptions.SetTarifNames


{$IFDEF GCCLSRV}
procedure TClientInfo.SetLastPing(const AdtValue: TDateTime);
begin
  FdtLastPing := AdtValue;
  FbNotConnected := False;
end; // TClientOptions.SetTarifNames
{$ENDIF}

{$IFDEF GCCLSRV}
procedure TClientInfo.SetDisconnected(const AbValue: Boolean);
begin
  if (FbDisconnected <> AbValue) then begin
    FbDisconnected := AbValue;
    if FbDisconnected then
      RunClientScript(caDisconnect);
  end;
end; // TClientOptions.SetDisconnected
{$ENDIF}

function TClientInfo.GetAfterStopActionNeeded: Boolean;
begin
  Result := False;
{$IFDEF GCCLSRV}
  Result := GClientInfo.IsDisconnected
      and not GClientInfo.IsFirstRun
      and (
        //после перезагрузки только при восстановленных значениях
        (GClientInfo.IsNotConnected and GClientOptions.RestoreClientInfo
        and FbAfterStopActionNeeded) or
        //после обрыва связи
        (not GClientInfo.IsNotConnected and FbAfterStopActionNeeded));
{$ENDIF}
end;

procedure TClientInfo.SetAfterStopActionNeeded(const AbValue: Boolean);
begin
  if FbAfterStopActionNeeded <> AbValue then begin
    FbDirty := True;
    FbAfterStopActionNeeded := AbValue;
  end;
end;

procedure TClientInfo.SetServerIPAddress(const AstrValue: String);
begin
  if FstrServerIPAddress <> AstrValue then begin
    FbDirty := True;
    FstrServerIPAddress := AstrValue;
  end;
end;

procedure TClientInfo.Load();
begin
  Debug.Trace5('GCCL service TClientInfo.Load.');
try
    FbBlocked := _GetBooleanOption(
        INFO_GENERAL_FOLDER, 'Blocked', DEF_BLOCKED);
    FnClientState := TClientState(_GetIntegerOption(
      INFO_GENERAL_FOLDER, 'ClientState', Integer(ClientState_Blocked)));
    FstrLogin := _GetStringOption(
      INFO_GENERAL_FOLDER, 'Login', DEF_LOGIN);
    FfBalance := _GetFloatOption(
      INFO_GENERAL_FOLDER, 'Balance', DEF_BALANCE);
    FfBalanceLimit := _GetFloatOption(
      INFO_GENERAL_FOLDER, 'BalanceLimit', DEF_BALANCE_LIMIT);
    FstrBalanceHistory := _GetStringOption(
      INFO_GENERAL_FOLDER, 'BalanceHistory', DEF_BALANCE_HISTORY);
    FstrInfo := _GetStringOption(
      INFO_GENERAL_FOLDER, 'Info', DEF_INFO);
    FstrFullInfo := _GetStringOption(
      INFO_GENERAL_FOLDER, 'FullInfo', DEF_INFO_FULL);
    FfSum := _GetFloatOption(
      INFO_GENERAL_FOLDER, 'Sum', DEF_SUM);
    FdtStart := _GetFloatOption(
      INFO_GENERAL_FOLDER, 'Start', DEF_START);
    FdtStop := _GetFloatOption(
      INFO_GENERAL_FOLDER, 'Stop', DEF_STOP);
    FstrTarifName := _GetStringOption(
      INFO_GENERAL_FOLDER, 'TarifName', DEF_TARIF_NAME);
    FbTrafficSeparatePayment := _GetBooleanOption(
        INFO_GENERAL_FOLDER, 'TrafficSeparatePayment',
        DEF_TRAFIIC_SEPARATE_PAYMENT);
    FnSecCode := _GetIntegerOption(
      INFO_GENERAL_FOLDER, 'SecCode', DEF_SEC_CODE);
    FbInternet := _GetBooleanOption(
        INFO_GENERAL_FOLDER, 'Internet', DEF_INTERNET);
    FnInternetAvailableInKB := _GetIntegerOption(
      INFO_GENERAL_FOLDER, 'InternetAvailableInKB', DEF_INTERNET_AVAILABLE);
    FnInternetUsedInKB := _GetIntegerOption(
      INFO_GENERAL_FOLDER, 'InternetUsedInKB', DEF_INTERNET_USED);
    SetRunPadHidedTabsAsText(_GetStringOption(
      INFO_GENERAL_FOLDER, 'RunPadHidedTabs', DEF_RUNPAD_HIDED_TABS));
    FbAfterStopActionNeeded := _GetBooleanOption(
        INFO_GENERAL_FOLDER, 'AfterStopActionNeeded',
        DEF_AFTER_STOP_ACTION_NEEDED);
  FbDirty := False;
except
  on e: Exception do begin
    Debug.Trace0('TclientInfo load Error! ' + e.Message);
  end;
end;
  Debug.Trace5('GCCL service TClientInfo.Loaded.');
end;

procedure TClientInfo.Save();
begin
  Debug.Trace5('GCCL service TClientInfo.Save.');
try
  with FClientInfoStorage do begin
    SaveOption(INFO_GENERAL_FOLDER, 'Blocked', FbBlocked);
    SaveOption(INFO_GENERAL_FOLDER, 'ClientState', Integer(FnClientState));
    SaveOption(INFO_GENERAL_FOLDER, 'Login', FstrLogin);
    SaveOption(INFO_GENERAL_FOLDER, 'Balance', FfBalance);
    SaveOption(INFO_GENERAL_FOLDER, 'BalanceLimit', FfBalanceLimit);
    SaveOption(INFO_GENERAL_FOLDER, 'BalanceHistory', FstrBalanceHistory);
    SaveOption(INFO_GENERAL_FOLDER, 'Info', FstrInfo);
    SaveOption(INFO_GENERAL_FOLDER, 'FullInfo', FstrFullInfo);
    SaveOption(INFO_GENERAL_FOLDER, 'Sum', FfSum);
    SaveOption(INFO_GENERAL_FOLDER, 'Start', FdtStart);
    SaveOption(INFO_GENERAL_FOLDER, 'Stop', FdtStop);
    SaveOption(INFO_GENERAL_FOLDER, 'TarifName', FstrTarifName);
    SaveOption(INFO_GENERAL_FOLDER, 'TrafficSeparatePayment', FbTrafficSeparatePayment);
    SaveOption(INFO_GENERAL_FOLDER, 'SecCode', FnSecCode);
    SaveOption(INFO_GENERAL_FOLDER, 'Internet', FbInternet);
    SaveOption(INFO_GENERAL_FOLDER, 'InternetAvailableInKB', FnInternetAvailableInKB);
    SaveOption(INFO_GENERAL_FOLDER, 'InternetUsedInKB', FnInternetUsedInKB);
    SaveOption(INFO_GENERAL_FOLDER, 'RunPadHidedTabs', RunPadHidedTabs.Text);
    SaveOption(INFO_GENERAL_FOLDER, 'AfterStopActionNeeded',
        FbAfterStopActionNeeded);
  end;
except
  on e: Exception do begin
    Debug.Trace0('TclientInfo save Error! ' + e.Message);
  end;
end;
  FbDirty := False;
  Debug.Trace5('GCCL service TClientInfo.Saved.');
end;

procedure TClientInfo.SaveIfNeeded();
begin
  if GClientOptions.RestoreClientInfo and FbDirty then
    Save;
end;
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private helper methods

function TClientInfo._GetStringOption(const AstrFolder: String;
    const AstrName: String; const AstrDefaultValue: String): String;
var
  strValue: String;
  FuncRes: TFunctionResult;
begin
  FuncRes := FClientInfoStorage.GetOption(AstrFolder, AstrName, strValue);
  if FuncRes = RES_SUCCESS then begin
    Result := strValue;
  end else begin
    Result := AstrDefaultValue;
  end;
end; // TClientInfo._GetStringOption


function TClientInfo._GetIntegerOption(const AstrFolder: String;
    const AstrName: String; const AnDefaultValue: Integer): Integer;
var
  nValue: Integer;
  FuncRes: TFunctionResult;
begin
  FuncRes := FClientInfoStorage.GetOption(AstrFolder, AstrName, nValue);
  if FuncRes = RES_SUCCESS then begin
    Result := nValue;
  end else begin
    Result := AnDefaultValue;
  end;
end; // TClientInfo._GetIntegerOption


function TClientInfo._GetBooleanOption(const AstrFolder: String;
    const AstrName: String; const AbDefaultValue: Boolean): Boolean;
var
  bValue: Boolean;
  FuncRes: TFunctionResult;
begin
  FuncRes := FClientInfoStorage.GetOption(AstrFolder, AstrName, bValue);
  if FuncRes = RES_SUCCESS then begin
    Result := bValue;
  end else begin
    Result := AbDefaultValue;
  end;
end; // TClientInfo._GetBooleanOption


function TClientInfo._GetFloatOption(const AstrFolder: String;
    const AstrName: String; const AfDefaultValue: Double): Double;
var
  fValue: Double;
  FuncRes: TFunctionResult;
begin
  FuncRes := FClientInfoStorage.GetOption(AstrFolder, AstrName, fValue);
  if FuncRes = RES_SUCCESS then begin
    Result := fValue;
  end else begin
    Result := AfDefaultValue;
  end;
end; // TClientInfo._GetFloatOption

initialization

  GClientInfo := TClientInfo.Instance();

finalization

  TClientInfo.ReleaseInstance();

end.


