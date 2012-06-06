// как всегда крутейшая задумка, типа модуль
// который выполняет сообщения
// здесь можно будет ограничивать функции
// если на них нет прав
// а также делать другие централизованные вещи

unit gcfunctions;

{$IFOPT D+}
  {$MESSAGE WARN '!!! Debug version of GCFunction!!!'}
{$ENDIF}

interface
uses
  GCCommon, GCLangutils, GCComputers, GCConst, frmMail,
  frmPassChange, frmBossOptions, frmRemontLong, frmSideline, frmCompManualPrint,
  frmCompStart, frmCompStop, frmCurrentReport, frmCompAdd, frmGCMessageBox,
  Menus,ComCtrls, SysUtils, Windows, Messages, Variants, Classes, Graphics, Controls,
  DateUtils, ADODB, Shlobj, registry, Proxy,
  IdBaseComponent, IdUDPBase, IdUDPServer, IdSocketHandle,
  IdUDPClient, IdComponent, StdCtrls, gcsessions,uPingIcmp,uPingThread;

// proxy
procedure ProxyInitialize;

// security
function XorCodeString(source,key: string):PChar;
function XorUncodeString(source,key: string):PChar;

procedure DoEvent(idEvent: string);  // run event
procedure DoInterface; // подстройка интерфейса под права и все такое
procedure DoInterfaceComps; // подстройка интерфеса конкретно под список компов

procedure EmptyProc; // заглушка для функций, не имеющих код

procedure MakeCurrentReport(strings: TStrings);
// miscellaneous
procedure MenuRecursive(Menu: TMenuItem);
procedure FunctionRightYes(id:string);
procedure FunctionRightClear;
function  FunctionAmIRight(id:string):boolean;
function FunctionAvailable(id:string):boolean;
procedure FunctionEnable(id:string; value: boolean);

procedure SetBackColor(const AColor: TColor);
procedure SetTableFont(const AFont: TFont);

procedure ehsEvent5Minutes;
procedure ehsAutoKillTasksAfterStop;
// reports
// events
procedure ehsLastLogin;
procedure ehsLogon;
procedure ehsLogout;
procedure ehsExit;
procedure ehsAbout;
procedure ehsHelp;
procedure ehsLangRussian;
procedure ehsLangEnglish;
procedure ehsRedrawComps;
procedure ehsPreLogon;
procedure ehsPassChange;
procedure ehsBossOptions;
procedure ehsSideline;
// functions
procedure ehsCompStart;
procedure ehsCompStop;
procedure ehsCompMove;
procedure ehsCompAdd;
procedure ehsRemont1;
procedure ehsRemontLong;
procedure ehsCurrentReport;
procedure ehsLastSessions;
procedure ehsClearStatistics;
procedure ehsManualPrint;
procedure ehsSendMessage;
procedure ehsRemoteClientsManage;
// network

procedure ehsVolume;
procedure ehsCloseShift;
procedure ehsColor;
procedure ehsPenalty;
procedure ehsNothing;
procedure ehsChangeTarif;
procedure dsLoadSessions;
procedure ehsManualRemoteInstall;
procedure ehsReserveActivate;
procedure ReserveActivate(ASession: TGCSession);
procedure ehsReserveCancel;
procedure ReserveCancel(ASession: TGCSession);

procedure ehsSessionTrafficPayment;
function GetSize: Cardinal;

procedure PingComputer(const AnComputerIndex: Integer);

function WrapProtocol(sdata: string): string;
procedure UnWrapProtocol(sdata: string; protocol, cmd, param: pstring);
function IsTimeOff: Boolean;

function SystemErrorMessage: string;

type
  TUniEvent = record  // универсальный ивЕнт
    id: string;       // имя функции
    enabled: boolean; // disable/enable
    access: boolean;  // наличие права на функцию
    proc: procedure;  // процедура-обработчик
    noclear: boolean; // право не уничтожается при очистке прав
  end;

  TBuf = array [0 .. 4095] of Byte;

// максимальное количество событий в системе
const MAX_EVENTS = 34;

var
events:array[0..MAX_EVENTS] of TUniEvent=
(
 (id:FN_PASS_CHANGE; enabled:true; access:false; proc:ehsPassChange; noclear:false),
 (id:FN_COMP_START; enabled:true; access:false; proc:ehsCompStart; noclear:false),
 (id:FN_COMP_STOP; enabled:true; access:false; proc:ehsCompStop; noclear:false),
 (id:FN_COMP_MOVE; enabled:true; access:false; proc:ehsCompMove; noclear:false),
 (id:FN_COMP_ADD; enabled:true; access:false; proc:ehsCompAdd; noclear:false),
// (id:FN_MAIN_REPORT; enabled:true; access:false; proc:ehsNothing; noclear:false),
 (id:FN_CURRENT_REPORT; enabled:true; access:false; proc:ehsCurrentReport; noclear:false),
 (id:FN_LAST_SESSIONS; enabled:false; access:false; proc:ehsLastSessions; noclear:false),
 (id:FN_CLEAR_STATISTICS; enabled:true; access:false; proc:ehsClearStatistics; noclear:false),
 (id:FN_REMONT_1; enabled:true; access:false; proc:ehsRemont1; noclear:false),
 (id:FN_REMONT_LONG; enabled:true; access:false; proc:ehsRemontLong; noclear:false),
 (id:FN_BOSS_OPTIONS; enabled:true; access:false; proc:ehsBossOptions; noclear:false),
 (id:FN_REMOTE_CONTROL; enabled:true; access:false; proc:EmptyProc; noclear:false),
 (id:FN_SIDELINE; enabled:true; access:false; proc:ehsSideline; noclear:false),
 (id:FN_MANUAL_PRINT; enabled:true; access:false; proc:ehsManualPrint; noclear:false),
 (id:FN_SHELLMODE; enabled:true; access:false; proc:EmptyProc; noclear:false),
 (id:FN_SENDMESSAGE; enabled:true; access:false; proc:ehsSendMessage; noclear:false),
 (id:FN_REMOTECLIENTS_MANAGE; enabled:true; access:false; proc:ehsRemoteClientsManage; noclear:false),
 (id:FN_REMOVE_FROM_TASKS_TEMPLATE; enabled:true; access:false; proc:ehsNothing; noclear:false),
 (id:FN_REMOTE_TASKS_KILLING; enabled:true; access:false; proc:ehsNothing; noclear:false),
 (id:FN_VIEW_FINANCE_ON_SHIFT_REPORT; enabled:true; access:false; proc:ehsNothing; noclear:false),
 (id:FN_VOLUME; enabled:true; access:false; proc:ehsVolume; noclear:false),
 (id:FN_CLOSE_SHIFT; enabled:true; access:false; proc:ehsCloseShift; noclear:false),
 (id:FN_COLOR; enabled:true; access:false; proc:ehsColor; noclear:false),
 (id:FN_PENALTY; enabled:true; access:false; proc:ehsPenalty; noclear:false),
 (id:FN_ACCOUNTS_CREATE; enabled:true; access:false; proc:ehsNothing; noclear:false),
 (id:FN_ACCOUNTS_CLEAR_PASSWORD; enabled:true; access:false; proc:ehsNothing; noclear:false),
 (id:FN_CHANGE_TARIF; enabled:true; access:false; proc:ehsChangeTarif; noclear:false),
// (id:FN_MANUAL_REMOTE_INSTALL; enabled:true; access:false; proc:ehsManualRemoteInstall; noclear:false),
 (id:FN_RESERVE_ACTIVATE; enabled:true; access:false; proc:ehsReserveActivate; noclear:false),
 (id:FN_RESERVE_CANCEL; enabled:true; access:false; proc:ehsReserveCancel; noclear:false),
 (id:FN_ACCOUNTS_CHANGE_MONEY; enabled:true; access:false; proc:ehsNothing; noclear:false),
 (id:FN_SESSION_TRAFFIC_PAYMENT; enabled:true; access:false; proc:ehsSessionTrafficPayment; noclear:false),
 (id:FN_XREPORT; enabled:true; access:false; proc:ehsNothing; noclear:false),
 (id:FN_ZREPORT; enabled:true; access:false; proc:ehsNothing; noclear:false),
 (id:FN_CUSTOMREPORT; enabled:true; access:false; proc:ehsNothing; noclear:false),
 (id:FN_TIMEBONUS; enabled:true; access:false; proc:ehsNothing; noclear:false)
);

implementation
uses
  Types,
  forms,
  frmAbout,
  ufrmLogon,
  frmMain,
  GCSystem,
  frmRemoteManage,
  DBTables,
  DB,
  dbgrideh,
  StrUtils,
  IdGlobal,
  frmCompChange,
  frmCompChangeTarif,
  frmCompTrafficAdd,
  uLinuxProxy,
  uSystemRegistryTools,
  uClientOptions,
  uClientOptionsConst,
  uClientInfoConst,
  uAutoUpdate,
  uAccounts,
  uAccountsDiscounts,
  uRegistry,
  uAccountSystem,
  uVirtualTime,
  ufrmVolume,
  uServerScripting,
  uRegistryOptions,
  uY2KString,
  udmMain,
  udmActions,
  uErrors,
  uProtocol,
  uTariffication,
  uRegistration,
  uKKMTools,
  ufrmClearStatistic,
  uFileInfo;

type
  TMyDBGrid = class(TDBGridEh);

//var
  //NoRestoreCompsGrid:Boolean;

// Функция для предотвращения "прыгания" курсора в сетке с компами на средину
procedure ScrollActiveToRow(Grid : TDBGridEh; ARow : Integer);
 var FTitleOffset, SDistance : Integer;
     NewRect : TRect;
     RowHeight : Integer;
     NewRow : Integer;
begin
 with TMyDBGrid(Grid) do begin
   NewRow:= Row;
   FTitleOffset:= 0;
//   if dgTitles in Options then
     inc(FTitleOffset);
   if ARow = NewRow then Exit;
   with DataLink, DataSet do
    try
      BeginUpdate;
      Scroll(NewRow - ARow);
      if (NewRow - ARow) < 0 then ActiveRecord:= 0
                             else ActiveRecord:= VisibleRowCount - 1;
      SDistance:= MoveBy(NewRow - ARow);
      NewRow:= NewRow - SDistance;
      MoveBy(ARow - ActiveRecord - FTitleOffset);
      RowHeight:= DefaultRowHeight;
      NewRect:= BoxRect(0, FTitleOffset, ColCount - 1, 1000);
      ScrollWindowEx(Handle, 0, - RowHeight * SDistance, @NewRect, @NewRect, 0, nil, SW_Invalidate);
      MoveColRow(Col, NewRow, False, False);
    finally
      EndUpdate;
    end;
 end;
end;


// функция возвращает tru для запрашиваемой функции,
// если на нее есть право и она разблокирована
function FunctionAmIRight(id:string):boolean;
var
  i:integer;
begin
  FunctionAmIRight := false;
  for i:=0 to MAX_EVENTS do
    if (events[i].id = id) then
    begin
      if (events[i].enabled) and(events[i].access) then
       FunctionAmIRight := true
      else
       FunctionAmIRight := false;
      break;
    end;
end;

function FunctionAvailable(id:string):boolean;
var
  i:integer;
begin
  Result := false;
  for i:=0 to MAX_EVENTS do
    if (events[i].id = id) then
    begin
      if (events[i].access) then
       Result := true
      else
       Result := false;
      break;
    end;
end;

// дисейбл или енейбл функции
procedure FunctionEnable(id:string; value: boolean);
var
  i:integer;
begin
  for i:=0 to MAX_EVENTS do
    if (events[i].id = id) then
    begin
      events[i].enabled := value;
      break;
    end;
  DoInterface;
end;

procedure FunctionRightYes(id:string);
var
  i:integer;
begin
  for i:=0 to MAX_EVENTS do
    if (events[i].id = id) then
    begin
      events[i].access := true;
      break;
    end;
  DoInterface;
end;

procedure FunctionRightClear;
var
  i:integer;
begin
  for i:=0 to MAX_EVENTS do
    if (not events[i].noclear) then
      events[i].access := false;
  DoInterface;
end;

// подстройка интерфейса под права и все такое
procedure DoInterface;
var
  result: boolean;
  comp: TComputer;
begin
  // fnCompStart
  result := FunctionAmIRight(FN_COMP_START) and (Not isManager);
  formMain.mnuStart.Enabled := result;
  formMain.tbCompStart.Enabled := result;
  // fnCompStop
  result := FunctionAmIRight(FN_COMP_STOP) and (Not isManager);
  formMain.mnuStop.Enabled := result;
  formMain.tbCompStop.Enabled := result;
  // fnCompMove
  result := FunctionAmIRight(FN_COMP_MOVE) and (Not isManager);
  formMain.mnuMove.Enabled := result;
  formMain.tbCompMove.Enabled := result;
  // fnCompAdd
  result := FunctionAmIRight(FN_COMP_ADD) and (Not isManager);
  formMain.mnuAdd.Enabled := result;
  formMain.tbCompAdd.Enabled := result;
  // fnCompAdd
  result := FunctionAmIRight(FN_SESSION_TRAFFIC_PAYMENT) and (Not isManager);
  formMain.mnuTrafiicAdd.Enabled := result;
  // ChangePass
  result := FunctionAmIRight(FN_PASS_CHANGE);
  formMain.mnuChangePass.Enabled := result;
  // CloseShift
  result := FunctionAmIRight(FN_CLOSE_SHIFT);
  formMain.mnuCloseShift.Enabled := result;
  // ClearStatistics
  result := FunctionAmIRight(FN_CLEAR_STATISTICS);
  formMain.mnuClearStat.Enabled := result;
  // BossOptions
  result := FunctionAmIRight(FN_BOSS_OPTIONS);
  formMain.mnuBossOptions.Enabled := result;
  // LastSessions
  result := FunctionAmIRight(FN_LAST_SESSIONS);
  formMain.mnuSessionLast.Enabled := result;
  // Remont1
  result := FunctionAmIRight(FN_REMONT_1) and (Not isManager);
  formMain.mnuRemont1.Enabled := result;
  // RemontLong
  result := FunctionAmIRight(FN_REMONT_LONG) and (Not isManager);
  formMain.mnuRemontLong.Enabled := result;
  // Sideline
  result := FunctionAmIRight(FN_SIDELINE) and (Not isManager);
  if result and (CompsSelCount = 1) then begin
    comp := Comps[ComputersGetIndex(CompsSel[0])];
    formMain.mnuService.Enabled := comp.Busy
        and ((not comp.session.PostPay and GRegistry.Options.ServiceByPrepay)
        or (comp.session.PostPay and GRegistry.Options.ServiceByPostpay));
  end else
    formMain.mnuService.Enabled := False;
  formMain.mnuSideline.Enabled := result;
  formMain.tbSideline.Enabled := result;
  // ManualPrint
  result := FunctionAmIRight(FN_MANUAL_PRINT) and (Not isManager);
  formMain.mnuManualPrint.Enabled := result;
  // ShellMode
  result := FunctionAmIRight(FN_SHELLMODE) and (Not isManager);
  formMain.mnuShellMode.Enabled := result;
  //----
  formMain.mnuAccounts.Enabled := false;
  formMain.mnuAccounts2.Enabled := false;
  formMain.mnuGetMoney.Enabled := false;
  formMain.mnuXReport.Enabled := false;
  formMain.mnuZReport.Enabled := false;
  formMain.mnuAddCheckAccount.Enabled := false;
  if (dmMain.cnnMain <> nil) then begin
    // ShowTechInfoWin
    if (dmMain.cnnMain.State <> [stOpen]) then formMain.mnuClientInfo.Enabled := false;
    // Accounts menus
    formMain.mnuAccounts.Enabled := ((dmMain.cnnMain.State = [stOpen]) and GAccountSystem.Enabled);
    formMain.mnuAccounts.Enabled := ((dmMain.cnnMain.State = [stOpen]) and GAccountSystem.Enabled and (Not isManager));
    formMain.mnuAccounts2.Enabled := ((dmMain.cnnMain.State = [stOpen]) and GAccountSystem.Enabled and (isManager));
    formMain.mnuGetMoney.Enabled := ((dmMain.cnnMain.State = [stOpen])
        and (isManager));
    formMain.mnuXReport.Enabled := (dmMain.cnnMain.State = [stOpen])
        and FunctionAmIRight(FN_XREPORT);
    formMain.mnuZReport.Enabled := (dmMain.cnnMain.State = [stOpen])
        and FunctionAmIRight(FN_ZREPORT);
    formMain.mnuAddCheckAccount.Enabled := (dmMain.cnnMain.State = [stOpen])
        and Assigned(GAccountSystem)
        and GAccountSystem.UseCheckAccounts
        and Assigned(GRegistry)
        and GRegistry.Modules.KKM.Active;
  end;
  // ehsRemoteClientsManage
  result := FunctionAmIRight(FN_REMOTECLIENTS_MANAGE);
  formMain.mnuRemoteManage.Enabled := result;

  formMain.mnuKillTask.Enabled := (CompsSelCount=1) and FunctionAmIRight(FN_REMOTE_TASKS_KILLING) and (Not isManager);
  formMain.mnuKillTasksTemplate.Enabled := (CompsSelCount=1) and FunctionAmIRight(FN_REMOTE_TASKS_KILLING) and (Not isManager);
  formMain.mnuShutdown.Enabled := (CompsSelCount>0) and (Not isManager);
  formMain.tbCompShutdown.Enabled := formMain.mnuShutdown.Enabled;
  formMain.tbCompWakeUp.Enabled := formMain.mnuShutdown.Enabled;
  formMain.tbCompLogoff.Enabled := formMain.mnuShutdown.Enabled;
  formMain.mnuWakeUp.Enabled := (CompsSelCount>0) and (Not isManager);
  formMain.mnuRestart.Enabled := (CompsSelCount>0) and (Not isManager);
  formMain.tbCompReset.Enabled := formMain.mnuRestart.Enabled;
  formMain.mnuLogoff.Enabled := (CompsSelCount>0) and (Not isManager);
  formMain.tbCompLogoff.Enabled := formMain.mnuLogoff.Enabled;

  formMain.tlbMonOn.Enabled := (CompsSelCount>0) and (Not isManager);
  formMain.tlbMonOff.Enabled := formMain.tlbMonOn.Enabled;
  formMain.tlbStationUnlock.Enabled := formMain.tlbMonOn.Enabled;
  formMain.tlbStationLock.Enabled := formMain.tlbMonOn.Enabled;

  result := FunctionAmIRight(FN_VOLUME) and (Not isManager);
  formMain.mnuVolumes.Enabled := result;
  formMain.mnuCompVolume.Enabled := result;
  result := (CompsSelCount=1) and FunctionAmIRight(FN_PENALTY) and (Not isManager) ;
  formMain.subPenalty.Enabled := result;
  result := (CompsSelCount=1) and FunctionAmIRight(FN_TIMEBONUS)
      and (Not isManager) ;
  formMain.subTimeBonus.Enabled := result;
  dmActions.actTimeBonus.Enabled := result;
  formMain.mnuChangeTarif.Enabled := (CompsSelCount=1) and FunctionAmIRight(FN_CHANGE_TARIF) and (Not isManager);

  formMain.PopupMenuComps.Items.Clear;
  formMain.BuildPopupMenu(formMain.subWork, formMain.PopupMenuComps.Items);
  // ManualRemoteInstall
  result := FunctionAmIRight(FN_MANUAL_REMOTE_INSTALL);
  formMain.mnuInstall.Enabled := result;
  result := FunctionAmIRight(FN_RESERVE_ACTIVATE);
  formMain.mnuActivateReserve.Enabled := result;
  result := FunctionAmIRight(FN_RESERVE_CANCEL);
  formMain.mnuCancelReserve.Enabled := result;
end;

procedure DoInterfaceComps;
var
  result, result2, result3, result4, isRemont: boolean;
  i:Integer;
  tv: TTarifVariants;
  bOneSelected, bTwoSelected, bOneOrMoreSelected, bFewSelected, bRemont: Boolean;
  firstComputer: Tcomputer;
begin
  bOneSelected := (CompsSelCount = 1) and not isManager;
  bTwoSelected := (CompsSelCount = 2) and not isManager;
  bOneOrMoreSelected := (CompsSelCount > 0) and not isManager;
  bFewSelected := (CompsSelCount > 1) and not isManager;
  if bOneOrMoreSelected then begin
    firstComputer := Comps[ComputersGetIndex(CompsSel[0])];
    if firstComputer.Busy then
    bRemont := (firstComputer.session.IdTarif = ID_TARIF_REMONT);
  end;
  FunctionEnable(FN_SHELLMODE, bOneOrMoreSelected);
  // --- authorization ------
  formMain.mnuAllowAuthorization.Enabled := bOneSelected
      and GAccountSystem.Enabled
      and firstComputer.IsFree
      and (firstComputer.a.state = ClientState_Blocked);
  FunctionEnable(FN_REMONT_1, bOneSelected and firstComputer.IsFree);
  FunctionEnable(FN_TIMEBONUS, bOneSelected and (not firstComputer.IsFree));
  FunctionEnable(FN_REMONT_LONG, bOneSelected and firstComputer.IsFree);
  FunctionEnable(FN_MANUAL_PRINT, bOneSelected and firstComputer.Busy);
  FunctionEnable(FN_PENALTY, bOneSelected and firstComputer.Busy
      and not bRemont
      and not firstComputer.session.PostPay);
  FunctionEnable(FN_CHANGE_TARIF, bOneSelected and firstComputer.Busy
      and not bRemont
      and firstComputer.session.IsGuest
      and not firstComputer.session.IsPacketTarif);
  FunctionEnable(FN_SESSION_TRAFFIC_PAYMENT, bOneSelected and firstComputer.Busy
      and not bRemont
      and firstComputer.session.IsGuest
      and firstComputer.session.IsTrafficSeparatePayment
      and not firstComputer.session.PostPay);
  FunctionEnable(FN_COMP_MOVE, (bOneSelected and firstComputer.Busy)
//      and firstComputer.session.IsGuest)
      or (bTwoSelected and (firstComputer.Busy
      or Comps[ComputersGetIndex(CompsSel[1])].Busy)
      and (firstComputer.IdGroup
      = Comps[ComputersGetIndex(CompsSel[1])].IdGroup)
{      and not (firstComputer.a.state = ClientState_Session)
      and not (Comps[ComputersGetIndex(CompsSel[1])].a.state
      = ClientState_Session)}));
  FunctionEnable(FN_COMP_START, bOneOrMoreSelected
      and CompsSelIsLikely(caReserve));
  FunctionEnable(FN_COMP_STOP, bOneOrMoreSelected
      and CompsSelIsLikely(caStop));
  FunctionEnable(FN_COMP_ADD, bOneOrMoreSelected
      and CompsSelIsLikely(caAdd));
  result := True;
  for i := 0 to CompsSelCount-1 do
    with Comps[ComputersGetIndex(CompsSel[i])] do
      if (busy) or (session = Nil) then
        result := False;
  FunctionEnable(FN_RESERVE_ACTIVATE, result);
  FunctionEnable(FN_RESERVE_CANCEL, result);
end;

// собственно самая главная функция
procedure DoEvent(idEvent: string);
var
  i:integer;
begin
  for i:=0 to MAX_EVENTS do
  begin
    if (events[i].id = idEvent) then
    begin
      events[i].proc;
      Break;
    end;
  end;
end;

// logon
procedure ehsLogon;
var
  CurrBaseVersion: string;
  i: integer;
  bNeedShowTrial: Boolean;
  strTemp: String;
  lstTemp: TStringList;
//  info: TFileCheckSumInfo;
  frmLogon: TfrmLogon;
  pMem, pBuf: ^TBuf;
//  pBuf: PByte;
  b: Int64;
  c: Byte;
  s: Boolean;
  mem: TMemoryStream;

begin
//  bNeedShowTrial := False;
  // если же дни еще есть, то подсчет трафа еще работает
  if ((StrLen(Registration.UserName) = 0)
      and (Registration.TrialDaysLeft<>0) and (Registration.TrialExLeft<>0))
      then Registration.InternetControlLinux := True;
  if ((StrLen(Registration.UserName) = 0)
      and (Registration.TrialDaysLeft<>0) and (Registration.TrialExLeft<>0))
      then Registration.InternetControl := True;
  frmLogon := TfrmLogon.Create(formMain, dmMain.cnnMain);
  frmLogon.OnError := formMain.Error;
  if (frmLogon.ShowModal = mrOk) then begin
    Application.ProcessMessages;
    formMain.Caption := FORM_MAIN_CAPTION + ' : ' + frmLogon.ServerName
          + '\' + frmLogon.UserName;
    CurServer := frmLogon.ServerName;
    CurOperatorName := frmLogon.UserName;
    if(dmMain.cnnMain.Connected) then
      Console.AddEvent(EVENT_ICON_INFORMATION,LEVEL_1,
          translate('LoginOK'))
    else
      Console.AddEvent(EVENT_ICON_INFORMATION,LEVEL_1,
          translate('LoginNotOK'));
    CurrBaseVersion := dsGetBaseVersion;//GRegistry.BaseVersion;
    if (CurrBaseVersion <> BASE_VERSION) then
    begin
      dmMain.cnnMain.Close;
      formMain.timerCompsList.Enabled := false;
      formGCMessageBox.memoInfo.Text :=
          translate('ErrorDifferentBaseAndApp');
      formGCMessageBox.memoInfo.Lines.Add('App version = '
          + BASE_VERSION);
      formGCMessageBox.memoInfo.Lines.Add('Base version = '
          + CurrBaseVersion);
      formGCMessageBox.SetDontShowAgain(false);
      formGCMessageBox.ShowModal;
      formMain.Starting := False;
      dmActions.actExit.Execute;
      exit;
    end;
    // Инициализация проверки целостности
    // OnInitDatabase и GetLogonInfo
    with dmMain.dstOnInitDatabase do begin
      Connection := dmMain.cnnMain;
      try
        ExecProc;
      except
        dmActions.actExit.Execute;
        exit;
      end;
      with dmMain.dstGetLogonInfo do begin
        Connection := dmMain.cnnMain;
        try
          Open;
        except
          dmActions.actExit.Execute;
          exit;
        end;
        SetVirtualTime(FieldList[0].AsDateTime);
        IntTimeShiftReset := IntTimeShift;
        isManager := FieldList[1].AsBoolean;
        OperatorSecLevel :=FieldList[2].AsInteger ;
        Close;
      end;
      Close;
    end;
    dsLoadFunctionsRights;
    Application.ProcessMessages;
    GAutoUpdate := TAutoUpdate.Create(dmMain.cnnMain);
    Application.ProcessMessages;
    GAccountsCopy := TAccounts.CreateCopy(GAutoUpdate);
    CurrencyString := GRegistry.Options.Currency;
    // включаем сокеты для оператора
    if not isManager then
      if not formMain.EnableSockets() then begin
          Application.MessageBox(PChar(ERR_SOCKET),
              PChar(ERR_CAPTION), MB_OK or MB_ICONERROR);
          dmActions.actExit.Execute;
      end;
    // ---
    dsLoadComputerGroups;
    Application.ProcessMessages;
    dsLoadOptions;
    Application.ProcessMessages;
    GClientOptions.Load;
    dsLoadComputers;
    Application.ProcessMessages;
    FMappings.Load;
    Application.ProcessMessages;
    ProxyInitialize;
    Application.ProcessMessages;
    KKMPluginStart;
    Application.ProcessMessages;
    dsLoadTarifs;
    Console.AddEvent(EVENT_ICON_EMPTY, LEVEL_2, translate('dsLoadClientsOk')
        +' ['+IntToStr(GAccountSystem.Accounts.RecordCount)+']');
    GSessions := TGCSessions.Create;
    GSessions.Load;
    Application.ProcessMessages;
{    if not isManager then
      dsSendOptionsToClients;}
    Application.ProcessMessages;
    if (not FunctionAmIRight(FN_REMOTE_CONTROL)) then
      dsControlClubStart
    else
    begin
      Console.AddEvent(EVENT_ICON_INFORMATION,LEVEL_1,translate('RemoteModeOn'));
      formMain.Caption := formMain.Caption + ' [ ' + translate('RemoteShort')+' ]';
    end;
    dmActions.actDisconnect.Enabled := True;
    dmActions.actConnect.Enabled := False;
    dmActions.actRedrawComps.Execute;
    //курсор на первый комп
    formMain.gridComps.DataSource.DataSet.First;
    formMain.gridComps.SelectedRows.CurrentRowSelected := True;
    formMain.gridCompsCellClick(Nil);
    Application.ProcessMessages;
    // выводим инфу по ласт логину
    ehsLastLogin;
    Application.ProcessMessages;
      // послать на каждую машину STR_CMD_GETEXTENDEDINFO
    if not isManager then
      for i:=0 to (CompsCount-1) do
        UDPSend(Comps[i].ipaddr,
            STR_CMD_GETEXTENDEDINFO);
    formMain.mnuColor.Enabled := True;
    formMain.mnuFont.Enabled := True;
    formMain.mnuTableOpt.Enabled := True;
{    if bNeedShowTrial then
      ShowTrialWarning;}
    if (FunctionAmIRight(FN_REMOTE_CONTROL)
        and not GRegistry.UserInterface.DontShow.ManagerFirstLogon) then begin
      formGCMessageBox.memoInfo.Text := translate('EventMonitorModeOn');
      formGCMessageBox.SetDontShowAgain(true);
      formGCMessageBox.ShowModal;
      GRegistry.UserInterface.DontShow.ManagerFirstLogon :=
          formGCMessageBox.cbNotShowAgain.Checked;
    end;
    if (FunctionAmIRight(FN_BOSS_OPTIONS)
        and not GRegistry.UserInterface.DontShow.ManagerEmptyPassword)
        then begin
      formGCMessageBox.memoInfo.Text := translate('EventEmptyPassword');
      formGCMessageBox.SetDontShowAgain(true);
      formGCMessageBox.ShowModal;
      GRegistry.UserInterface.DontShow.ManagerEmptyPassword :=
          formGCMessageBox.cbNotShowAgain.Checked;
    end;
    formMain.PageControl.ActivePage := formMain.tabComputers;
    formMain.gridComps.SetFocus;
    Application.ProcessMessages;
    formMain.Starting := False;
    formMain.timerCompsList.Enabled := True;
    if GRegistry.Scripts.OnClientSynchronizeFile then begin
      GnClientScriptFileCheckSum := GetCheckSum(GRegistry.Scripts.OnClientPath);
    end;
    if (GRegistry.Options.InstallPath <> '') then begin
      GnClientInstallFileCheckSum := GetCheckSum(GRegistry.Options.InstallPath);
    end;
    GnServerFileCheckSum := GetCheckSum(ParamStr(0){'GCServer.exe'});

    //Устраняем "Мелькание" клиентов при запуске оператора
    GSessions.Load;
    GSessions.Check;
    Application.ProcessMessages;
    StartPingThread;

    if (CompsCount > 0) then begin
      formMain.tmrCyclicCompAction.Interval := Round
          (GRegistry.Options.ClientQueryTime * 1000 / CompsCount);
      formMain.tmrCyclicCompAction.Enabled := True;
      formMain.tmrFileSynchronization.Interval := Round
          (GRegistry.Options.ClientQueryTime * 1000 * 20 / CompsCount);
      formMain.tmrFileSynchronization.Enabled := True;
    end;
    Application.ProcessMessages;
    //Записываем инфу
    if isManager then begin
      GRegistry.Info.AppVersion := APP_VERSION;
      GRegistry.Info.UserName := Registration.UserName;
      GRegistry.Info.ComputersNumber := Registration.CompsRegs;
      GRegistry.Info.HardwareControl := Registration.HardwareControl;
      GRegistry.Info.PrinterControl := Registration.PrinterControl;
      GRegistry.Info.InternetControl :=
          Registration.InternetControl;
      GRegistry.Info.InternetControlLinux :=
          Registration.InternetControlLinux;
      GRegistry.Info.InternetControlComLinux :=
          Registration.InternetControlComLinux;
      GRegistry.Info.MainCheckSum := GnServerFileCheckSum;
      GRegistry.Info.ClientCheckSum := GnClientScriptFileCheckSum;
      GRegistry.Info.InstallCheckSum := GnClientInstallFileCheckSum;
    end;
    formMain.FfrmReports.InitData;
    // загрузим внешний вид текущего оператора
//    NoRestoreCompsGrid := true;
    OperatorProfile.Load;
//    NoRestoreCompsGrid := false;
    Application.ProcessMessages;
    if not isManager then
      GRegistry.Info.LastOperatorName := CurOperatorName;
    RunServerScript(aLogon, CurOperatorName);
  end;
  frmLogon.Free;

end;

// logout
procedure ehsLogout;
begin
  StopPingThread;
  formMain.tmrCyclicCompAction.Enabled := False;
  formMain.tmrFileSynchronization.Enabled := False;
  formMain.timerCompsList.Enabled := false;
  formMain.DisableSockets();
  RunServerScript(aLogoff, CurOperatorName);
  if dsConnected then begin
    OperatorProfile.Save;
    if ((not isManager) and (FProxy <> nil)) then begin
      FProxy.Stop;
      FProxy.Reset;
      FProxy.Destroy;
      FProxy := nil;
    end;
    FProxy := nil;
    formMain.FfrmReports.DisableReports;
  end;
 // GCPC_Destroy;
  Console.AddEvent(EVENT_ICON_INFORMATION, LEVEL_1,translate('LogoutOk'));
  if (dmMain.cnnMain <> nil) then
    dmMain.cnnMain.Close;

  // сбрасываем профайл (интерфейс) в начальный уровень
  OperatorProfile.Reset;
  OperatorProfile.DoInterface;
  if (GSessions <> Nil) then begin
    GSessions.Free;
    GSessions := Nil;
  end;
  dsUnloadComputers;
  dsUnloadTarifs;
  dmActions.actRedrawComps.Execute;
  FunctionRightClear;
  formMain.Caption := FORM_MAIN_CAPTION;
  dmActions.actConnect.Enabled := True;
  dmActions.actDisconnect.Enabled := False;
  FreeAndNil(GAccountsCopy);

  FreeAndNil(GAutoUpdate);

  isManager := false;
  formMain.mnuColor.Enabled := False;
  formMain.mnuFont.Enabled := False;
  formMain.mnuTableOpt.Enabled := False;
  KKMPluginStop;
end;

// logout
procedure ehsExit;
begin
  formMain.tmrCyclicCompAction.Enabled := False;
  formMain.tmrFileSynchronization.Enabled := False;
  formMain.timerCompsList.Enabled := false;
  formMain.DisableSockets();
  RunServerScript(aLogoff, CurOperatorName);
  if dsConnected then begin
    OperatorProfile.Save;
    if ((not isManager) and (FProxy <> nil)) then begin
      FProxy.Stop;
      FProxy.Reset;
      FProxy.Destroy;
      FProxy := nil;
    end;
    FProxy := nil;
    formMain.FfrmReports.DisableReports;
  end;
 // GCPC_Destroy;

// Не добавляем запись в лог из-за возможного отсутствия связи с базой
//  Console.AddEvent(EVENT_ICON_INFORMATION, LEVEL_1,translate('LogoutOk'));


  if (dmMain.cnnMain <> nil) then
    dmMain.cnnMain.Close;

  // сбрасываем профайл (интерфейс) в начальный уровень
  OperatorProfile.Reset;
  OperatorProfile.DoInterface;
  if (GSessions <> Nil) then begin
    GSessions.Free;
    GSessions := Nil;
  end;
  dsUnloadComputers;
  dsUnloadTarifs;
  dmActions.actRedrawComps.Execute;
  FunctionRightClear;
  formMain.Caption := FORM_MAIN_CAPTION;
  dmActions.actConnect.Enabled := True;
  dmActions.actDisconnect.Enabled := False;
  FreeAndNil(GAccountsCopy);

  FreeAndNil(GAutoUpdate);

  isManager := false;
  formMain.mnuColor.Enabled := False;
  formMain.mnuFont.Enabled := False;
  formMain.mnuTableOpt.Enabled := False;
  KKMPluginStop;
  Application.Terminate;
end;


// about
procedure ehsAbout;
begin
  Application.CreateForm(TformAbout, formAbout);
  formAbout.ShowModal;
  formAbout.Destroy;
end;

// пробегаем все меню и переводим его на текущий язык
procedure MenuRecursive(Menu: TMenuItem);
var
 subMenu: TMenuItem;
 i:integer;
begin
 if Menu = nil then subMenu := formMain.menuMain.Items else subMenu := Menu;
 for i:= 0 to subMenu.Count-1 do
 begin
   if not (subMenu.Items[i].Caption = '-') then
     subMenu.Items[i].Caption := translate(subMenu.Items[i].Name);
   if subMenu.Items[i].Tag = 1 then MenuRecursive(subMenu.Items[i]);
 end;
end;

// выбрали русский язык
procedure ehsLangRussian;
begin
 traLang := 2;
 GCCommonRegistryWriteInt('Lng',traLang);
 MenuRecursive(nil);
 MenuRecursive(formMain.PopupMenuShutdown.Items);
 MenuRecursive(formMain.PopupMenuReset.Items);
 MenuRecursive(formMain.PopupMenuLogoff.Items);
 MenuRecursive(formMain.PopupMenuWakeup.Items);
 formMain.RedrawLanguage;
end;

// выбрали английский
procedure ehsLangEnglish;
begin
 traLang := 1;
 GCCommonRegistryWriteInt('Lng',traLang);
 MenuRecursive(nil);
 MenuRecursive(formMain.PopupMenuShutdown.Items);
 MenuRecursive(formMain.PopupMenuReset.Items);
 MenuRecursive(formMain.PopupMenuLogoff.Items);
 MenuRecursive(formMain.PopupMenuWakeup.Items);
 formMain.RedrawLanguage;
end;

// процедура перерисовывает список с компьютерами
procedure ehsRedrawComps;
var
 i:integer;
 bUpdate : boolean;
 bookmark : TBookmarkStr;
 nNumber: Integer;
 iOldRow: Integer;
begin
//   formMain.gridComps.SaveBookmark;

   iOldRow := TMyDBGrid(formMain.gridComps).Row;
   formMain.cdsComps.DisableControls;
   bookmark := formMain.cdsComps.Bookmark;
   SortDataSet(False);
   if ( CompsCount = 0 ) or (formMain.cdsComps.RecordCount <> CompsCount) then begin
      bUpdate := false;
      formMain.cdsComps.Close;
      formMain.cdsComps.CreateDataSet;
      bookmark := '';
   end
   else begin
      bUpdate := true;
      formMain.cdsComps.First;
   end;
   for i:=0 to CompsCount-1 do begin
      if bUpdate then
         formMain.cdsComps.Edit
      else
         formMain.cdsComps.Append;
      formMain.cdsComps.FieldValues['id'] := Comps[i].id;
      if Comps[i].busy then
        nNumber := 3 //сессия
      else begin
        if Comps[i].session = Nil then
          nNumber := 0 //свободен
        else
          nNumber := 6; //бронь
      end;
      if Not Comps[i].control then
      begin
        Inc(nNumber); //вместо зеленой иконки - красная
        if Comps[i].IcmpPingable  then
          Inc(nNumber); //вместо красной иконки - желтая
      end;
      formMain.cdsComps.FieldValues['Ping'] := IntToStr(nNumber);

      formMain.cdsComps.FieldValues['Computer'] := Comps[i].number;
      if (not Comps[i].busy) then
      begin
         if(Comps[i].a.state = ClientState_Blocked) then
            formMain.cdsComps.FieldValues['SysState'] := 'Blocked';
         if(Comps[i].a.state = ClientState_Authentication) then
            formMain.cdsComps.FieldValues['SysState'] := 'notBusy';
         if(Comps[i].a.state = ClientState_Order) then
            formMain.cdsComps.FieldValues['SysState'] := 'Authenticated';
         if(Comps[i].session <> Nil) then
            formMain.cdsComps.FieldValues['SysState'] := 'Reserve';
      end
      else
         if(Comps[i].a.state = ClientState_Session) then
            formMain.cdsComps.FieldValues['SysState'] := 'Authenticated'
         else
            begin

              formMain.cdsComps.FieldValues['SysState'] := 'Accupied';
              if GClientOptions.UseTextMessage then
                if (MinuteOf(Comps[i].session.TimeStop - GetVirtualTime) <
                  GClientOptions.UseTextMessageMin) and
                  (HourOf(Comps[i].session.TimeStop - GetVirtualTime) = 0)then
                  formMain.cdsComps.FieldValues['SysState'] := 'Prevented';
              if GClientOptions.UseBaloons then
                if (MinuteOf(Comps[i].session.TimeStop - GetVirtualTime) <
                  DEF_USE_TEXT_MESSAGE_MIN) and
                  (HourOf(Comps[i].session.TimeStop - GetVirtualTime) = 0) then
                  formMain.cdsComps.FieldValues['SysState'] := 'Prevented';

            end;
      formMain.cdsComps.FieldValues['State'] := translate(formMain.cdsComps.FieldValues['SysState']);
      formMain.cdsComps.FieldValues['Time'] := Null;
      if (Comps[i].session <> Nil) then
      begin
        formMain.cdsComps.FieldValues['Description'] := Comps[i].session.Description;
        formMain.cdsComps.FieldValues['Tarif'] := Comps[i].session.GetStrTarif;
        formMain.cdsComps.FieldValues['Balance'] := Comps[i].session.GetStrBalance;
        formMain.cdsComps.FieldValues['Start'] := Comps[i].session.GetStrStart;
        formMain.cdsComps.FieldValues['End'] := Comps[i].session.GetStrStop;
        if (Not Comps[i].session.PostPay) then
          formMain.cdsComps.FieldValues['Time'] :=
              DateTimeToTimeString(Comps[i].session.TimeStop
              - Comps[i].session.TimeStart,False)
        else
          formMain.cdsComps.FieldValues['Time'] :=
              DateTimeToTimeString(GetVirtualTime
              - Comps[i].session.TimeStart,False);
      end
      else begin
        formMain.cdsComps.FieldValues['Description'] := Null;
        formMain.cdsComps.FieldValues['Tarif'] := Null;
        formMain.cdsComps.FieldValues['Balance'] := Null;
        formMain.cdsComps.FieldValues['Start'] := Null;
        formMain.cdsComps.FieldValues['End'] := Null;
      end;
      if (Comps[i].busy) then
      begin
        formMain.cdsComps.FieldValues['Printed'] := Comps[i].session.PrintCost;
        formMain.cdsComps.FieldValues['Traffic'] := Comps[i].session.GetStrTraffic;
        formMain.cdsComps.FieldValues['TimeLeft'] := Comps[i].session.GetStrBalanceTime;
      end
      else begin
        formMain.cdsComps.FieldValues['Printed'] := Null;
        formMain.cdsComps.FieldValues['Traffic'] := Null;
        formMain.cdsComps.FieldValues['TimeLeft'] := Null;
      end;

      if(Comps[i].a.state = ClientState_Order)
        or (Comps[i].a.state = ClientState_Session) then
        formMain.cdsComps.FieldValues['Client'] := GetAccountName(Comps[i].a)
      else
        formMain.cdsComps.FieldValues['Client'] := '';
      formMain.cdsComps.Post;
      if bUpdate then
         formMain.cdsComps.Next;
  end;
   SortDataSet(True);
   formMain.cdsComps.Bookmark := bookmark;
   formMain.cdsComps.EnableControls;
//   if not NoRestoreCompsGrid then
//    ScrollActiveToRow(formMain.gridComps,iOldRow);
end;

// PreLogon actions
procedure ehsPreLogon;
begin
  DoInterface;
  formMain.RedrawLanguage;            // for console and computers-list
  Console.AddEvent(EVENT_ICON_EMPTY, LEVEL_2,translate('GameClassStart')+' ' + GetAppVersion);
end;

procedure ehsCompStart;
var
  i: integer;
  index : integer;
  session: TGCSession;
  strMessage: String;
begin
  if (isManager) then exit;
  if (not FunctionAmIRight(FN_COMP_START)) then exit;
  if IsTimeOff then begin
    Application.MessageBox('Операция разрешена только в рабочее время!',
        'Предупреждение!');
    exit;
  end;
  if (formCompStart.ShowModal = mrOK) then
  begin

    dmActions.actLoadSessions.Execute;
    dmActions.actRedrawComps.Execute;
    DoInterfaceComps;
//    ehsPingComputers;
  end;
end;

procedure ehsCompStop;
var
  i: integer;
  session: TGCSession;
  bActionCanceled: Boolean;
begin
  if (isManager) then exit;
  if (not FunctionAmIRight(FN_COMP_STOP)) then exit;
  i := ComputersGetIndex(CompsSel[0]);
  if (formCompStop.ShowModal(caStop,
      Comps[i].session.IdSessionsAdd) = mrOK) then begin
      formMain.StopUpdate;
        for i := 0 to CompsSelCount - 1 do begin
          session := Comps[ComputersGetIndex(CompsSel[i])].session;
          if (session <> nil) and (session.Status <> ssFinished) then begin
            bActionCanceled := False;
            if GRegistry.Modules.KKM.Active then begin
              bActionCanceled := not PrintCheckStop(session)
                and GRegistry.Modules.KKM.DisconnectBlock;
            end;
            if bActionCanceled then
              Console.AddEvent(EVENT_ICON_INFORMATION, LEVEL_1,
                'Операция отменена из-за ошибки ККМ: ' + GKKMPlugin.GetLastError)
            else begin
              session.Stop(False);
              QueryAuthGoState1(ComputersGetIndex(CompsSel[i]));
              end;
          end;

        end;
      formMain.StartUpdate;  
  end;
  dmActions.actLoadSessions.Execute;
  DoInterfaceComps;
  dmActions.actRedrawComps.Execute;
end;

procedure ehsCompMove;
var
  index0, index1: integer;
  a_temp: TAuthorization;
  sessionSwap: TGCSession;
begin
  if (isManager) then exit;
  if (not FunctionAmIRight(FN_COMP_MOVE)) then exit;
  Application.CreateForm(TformCompChange, formCompChange);
  //для совместимости со старым способом обмена
  //меняем местами, т.к. grid выделяет не так как лист
  //но только если первым выбран занятый комп
  if(CompsSelCount = 2) and (Comps[ComputersGetIndex(CompsSel[1])].busy) then begin
    index0 := CompsSel[0];
    CompsSel[0] := CompsSel[1];
    CompsSel[1] := index0;
  end;
  if (formCompChange.ShowModal = mrOK) then begin
    formCompChange.Release;
    index0 := ComputersGetIndex(CompsSel[0]);
    index1 := ComputersGetIndex(TComputer(formCompChange.cbComputer.Items.Objects[formCompChange.cbComputer.ItemIndex]).id);
    // издаем звуки :)
    if (GClientOptions.UseSounds) then begin
    // russian
      if (GClientOptions.Language = 1) then begin // english
        if(Comps[index0].busy) then
          UDPSend(Comps[index0].ipaddr,
              STR_CMD_PLAY_SOUND + '='
              + WAVFILE_MOVETOOTHERCOMP_RU);
        if(Comps[index1].busy) then
          UDPSend(Comps[index1].ipaddr,
              STR_CMD_PLAY_SOUND + '='
              + WAVFILE_MOVETOOTHERCOMP_RU);
      end;
      if (GClientOptions.Language = 1) then begin // english
        if(Comps[index0].busy) then
          UDPSend(Comps[index0].ipaddr,
              STR_CMD_PLAY_SOUND + '='
              + WAVFILE_MOVETOOTHERCOMP_ENG);
        if(Comps[index1].busy) then
          UDPSend(Comps[index1].ipaddr,
              STR_CMD_PLAY_SOUND + '='
              + WAVFILE_MOVETOOTHERCOMP_ENG);
      end;
    end;
    dsCompsMove(index0,index1);
    // ------------ authorization ------------
    a_temp := Comps[index0].a;
    Comps[index0].a := Comps[index1].a;
    Comps[index1].a := a_temp;
    if Comps[index0].session<>Nil then
      Comps[index0].session.IdComp := Comps[index1].id;
    if Comps[index1].session<>Nil then
      Comps[index1].session.IdComp := Comps[index0].id;
    sessionSwap := Comps[index0].session;
    Comps[index0].session := Comps[index1].session;
    Comps[index1].session := sessionSwap;
    // если пересадили в одну сторону, то
    // освободившийся комп должен перегрузиться
    with Comps[index0] do
      if IsFree then begin
        timeStopSession := GetVirtualTime;
        bStopSession := True;
      end;
    with Comps[index1] do
      if IsFree then begin
        timeStopSession := GetVirtualTime;
        bStopSession := True;
      end;
    // ------------ authorization ------------
    dmActions.actLoadSessions.Execute;
    dmActions.actRedrawComps.Execute;
    PingComputer(index0);
    PingComputer(index1);
    SendAllOptionsToClient(index0);
    SendAllOptionsToClient(index1);
    Console.AddEvent(EVENT_ICON_INFORMATION, LEVEL_1,
        DateTimeToSql(GetVirtualTime) + ' ' + translate('MoveComp') + ' '
        + Comps[index0].GetStrNumber + '<->' + Comps[index1].GetStrNumber);
    formMain.gridCompsCellClick(Nil);
  end;
end;

procedure ehsCompAdd;
var
  AddSumma: double;
  index: integer;
begin
  if (isManager) then exit;
  if (not FunctionAmIRight(FN_COMP_ADD)) then exit;
  index := ComputersGetIndex(CompsSel[0]);
  Application.CreateForm(TformCompAdd, formCompAdd);
  if (formCompAdd.ShowModal = mrOK) then begin
    dmActions.actLoadSessions.Execute;
    dmActions.actRedrawComps.Execute;
  end;
  formCompAdd.Destroy;
end;

procedure ehsPassChange;
begin
  if (not FunctionAmIRight(FN_PASS_CHANGE)) then exit;
  Application.CreateForm(TformPassChange, formPassChange);
  formPassChange.ShowModal;
  formPassChange.Destroy;
end;

procedure ehsCurrentReport;
begin
  if (not FunctionAmIRight(FN_CURRENT_REPORT)) then exit;
  Application.CreateForm(TformCurrentReport, formCurrentReport);
  formCurrentReport.ShowModal;
  formCurrentReport.Destroy;
end;

procedure ehsCloseShift;
begin
  if (not FunctionAmIRight(FN_CLOSE_SHIFT)) then exit;
  Application.CreateForm(TformCurrentReport, formCurrentReport);
  formCurrentReport.ShowModal;
  formCurrentReport.Destroy;
end;

procedure ehsBossOptions;
begin
  if (not FunctionAmIRight(FN_BOSS_OPTIONS)) then exit;
  Application.CreateForm(TformBossOptions, formBossOptions);
  formBossOptions.ShowModal;
  formBossOptions.Destroy;
  if not GRegistry.UserInterface.DontShow.FirstOptionsClose then begin
    formGCMessageBox.memoInfo.Text := translate('FirstOptionsClose');
    formGCMessageBox.SetDontShowAgain(false);
    formGCMessageBox.ShowModal;
    GRegistry.UserInterface.DontShow.FirstOptionsClose :=
      formGCMessageBox.cbNotShowAgain.Checked;
  end;
end;

procedure ehsLastSessions;
begin
  if (not FunctionAmIRight(FN_LAST_SESSIONS)) then exit;
  //
end;

procedure ehsClearStatistics;
var
  frmClearStatistic: TfrmClearStatistic;
begin
  if (not FunctionAmIRight(FN_CLEAR_STATISTICS)) then exit;
  frmClearStatistic := TfrmClearStatistic.Create(Application.MainForm);
  frmClearStatistic.ShowModal;
  FreeAndNil(frmClearStatistic);
end;

procedure ehsRemont1;
var
  index: integer;
  session: GCSessions.TGCSession;
begin
  if (isManager) then exit;
  if (not FunctionAmIRight(FN_REMONT_1)) then exit;

  // ToDo смотреть впредь, чтобы не наложиться на другую сессию (если считается)

  index := ComputersGetIndex(CompsSel[0]);

  session := GSessions.Add(0, 0, Comps[index].id, Comps[index].a.number,
      GetVirtualTime, GetVirtualTime, IncMinute(GetVirtualTime,1),
      ID_TARIF_REMONT, 0, False, 0, '',
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      ClientState_OperatorSession, ssActive);
  Console.AddEvent(EVENT_ICON_INFORMATION, LEVEL_1, translate('GoRemont1') + ' >> ' + Comps[ComputersGetIndex(CompsSel[0])].GetStrNumber + ' ' + DateTimeToSql(GetVirtualTime));
  session.Save;
  //session.Destroy;

  DoInterfaceComps;
  dmActions.actLoadSessions.Execute;
  dmActions.actRedrawComps.Execute;
  PingComputer(index);
  SendAllOptionsToClient(index);
end;

procedure ehsManualPrint;
var
  index: integer;
begin
  if (isManager) then exit;
  if (not FunctionAmIRight(FN_MANUAL_PRINT)) then exit;
  //sd
  index := ComputersGetIndex(CompsSel[0]);

  Application.CreateForm(TformCompManualPrint, formCompManualPrint);
  if (formCompManualPrint.ShowModal = mrOK) then begin
    Console.AddEvent(EVENT_ICON_PRINTER, LEVEL_1, DateTimeToSql(GetVirtualTime) + ' > ' + translate('Computer')+ ' ' + Comps[index].GetStrNumber+ ' > ' + translate('Printed') + ' ' + IntToStr(formCompManualPrint.sePages.Value) + ' ' + translate('lblPages'));
    Comps[index].session.UpdateOnDB(0, 0, 0, 0,
        formCompManualPrint.sePages.Value, 0, 0, 0);
    dmActions.actLoadSessions.Execute;
    dmActions.actRedrawComps.Execute;
  end;
  formCompManualPrint.Destroy;
end;

procedure ehsLastLogin;
var
  param, key: string;
begin
  // читаем последнее значение
//  param := 'LastLogon'+CurOperatorName;
//  key := dsRegistryLoad(param, '');
  key := GRegistry.LastLogin;
  // выводим его в консоль
  if (key<>'') then
  begin
    Console.AddEvent(EVENT_ICON_INFORMATION, LEVEL_2,key);
  end;
  // записываем новое значение
//  key := translate('LastLogin')+' '+CurOperatorName+' = '+DateTimeToSql(GetVirtualTime);
//  dsRegistrySave(param, key);
  GRegistry.LastLogin := DateTimeToSql(GetVirtualTime);
end;

procedure ehsRemontLong;
var
  index: integer;
  session: GCSessions.TGCSession;
begin
  if (isManager) then exit;
  if (not FunctionAmIRight(FN_REMONT_LONG)) then exit;
  // ToDo смотреть впредь, чтобы не наложиться на другую сессию (если считается)
  Application.CreateForm(TformRemontLong, formRemontLong);
  if (formRemontLong.ShowModal = mrOK) then
  begin
    index := ComputersGetIndex(CompsSel[0]);
  session := GSessions.Add(0, 0, Comps[index].id, Comps[index].a.number,
      GetVirtualTime, GetVirtualTime,
      IncMinute(GetVirtualTime,GRegistry.Options.MinutsForLongRepair),
      ID_TARIF_REMONT, 0, False, 0,
      FilterString(formRemontLong.editRemontReason.Text),
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      ClientState_OperatorSession, ssActive);

    Console.AddEvent(EVENT_ICON_INFORMATION, LEVEL_1, translate('GoRemontLong') + ' >> ' + Comps[ComputersGetIndex(CompsSel[0])].GetStrNumber + ' ' + DateTimeToSql(GetVirtualTime));
    session.Save;
    //session.Destroy; ?????

    DoInterfaceComps;
    dmActions.actLoadSessions.Execute;
    dmActions.actRedrawComps.Execute;
    PingComputer(index);
    SendAllOptionsToClient(index);
  end;
  formRemontLong.Destroy;
end;

procedure EmptyProc;
begin
//
end;

function XorCodeString(source,key: string):PChar;
var
  i,j: word;
  res: PChar;
  xbyte: integer;
begin
  j:=1;
  GetMem(res,1024);
  FillMemory(res,1024,0);
  for i:=1 to StrLen(PChar(source)) do
  begin
    xbyte := Ord(source[i]) xor Ord(key[j]);
    StrCat(res,PChar(IntToHex(xbyte,2)));
    j := j + 1;
    if (j>strlen(PChar(key))) then j:=1;
  end;
  XorCodeString := res;
end;

function XorUncodeString(source,key: string):PChar;
var
  i,j: word;
  res: PChar;
  xbyte: integer;
  vhex,s: string;
begin
  j:=1;
  GetMem(res,1024);
  FillMemory(res,1024,0);
  for i:=1 to trunc(StrLen(PChar(source))/2)  do
  begin
    vhex := '0x' + source[i*2-1];
    vhex := vhex + source[i*2];
    xbyte := StrToInt(vhex) xor Ord(key[j]);
    s := Chr(xbyte);
    StrCat(res,PChar(s));
    j := j + 1;
    if (j>strlen(PChar(key))) then j:=1;
  end;
  XorUncodeString := res;
end;

procedure ehsSideline;
begin
  if (not FunctionAmIRight(FN_SIDELINE)) then exit;
  // показать форму Sideline
  Application.CreateForm(TformSideline, formSideline);
  formSideline.ShowModal(stcSeparate, Nil);
  formSideline.Destroy;
end;

procedure ehsHelp;
begin
  GCHelp(HELP_BEGIN);
end;

procedure ehsAutoKillTasksAfterStop;
var
  i,j: integer;
  diff: TDateTime;
begin
  if (isManager) then exit;
  for i:=0 to (CompsCount-1) do
    if (Not Comps[i].busy) and (Comps[i].bStopSession) then
      begin
        diff := GetVirtualTime - Comps[i].timeStopSession;
//        if (Options.TasksTemplateAutoKill<>0) and // Почему это нигде не проверялось???
        if (GClientOptions.AfterStop) and // Почему это нигде не проверялось???
        ((60*60*HourOf(diff)+60*MinuteOf(diff)
//            +SecondOf(diff))>Options.TasksTemplateAutoKillMins) then begin
            +SecondOf(diff))>GClientOptions.AfterStopSec) then begin
          Comps[i].bStopSession := false;
          // вызвать удаление задач по шаблону
{          if (Options.TasksTemplateAutoKill = 1) then
            UDPSend(Comps[i].ipaddr,STR_CMD_KILLTASK] + '=KILL');
}
//          if (Options.TasksTemplateAutoKill = 2) then
          case GClientOptions.AfterStopType of
            AfterStopType_KillTask: begin
               UDPSend(Comps[i].ipaddr,STR_CMD_KILLTASK
                    + '=');
            end;
            AfterStopType_Logoff: begin
              UDPSend(Comps[i].ipaddr,STR_CMD_RESTART
                  + '=' + BoolToStr(False));
            end;
            AfterStopType_Restart: begin
              UDPSend(Comps[i].ipaddr,STR_CMD_RESTART
                  + '=' + BoolToStr(True));
            end;
            AfterStopType_Shutdown: begin
              if ((GSessions.GetMaxStopTime(Comps[i].id)- GetVirtualTime) >=
                  EncodeTime(0,10,0,0)) then
                UDPSend(Comps[i].ipaddr,STR_CMD_SHUTDOWN);
            end;
          end;


        end;
      end;
end;

procedure ehsEvent5Minutes;
var
  i: integer;
  diff: TDateTime;
begin
  if (isManager) then exit;
  for i:=0 to (CompsCount-1) do
    if (Comps[i].busy) then
      begin
        diff := Comps[i].session.TimeStop-GetVirtualTime;
        if (HourOf(diff)>0) or (MinuteOf(diff)>4) then
          Comps[i].WarnedTime := False;

        if ((HourOf(diff) = 0) and (MinuteOf(diff)<5) and (not Comps[i].WarnedTime)) then begin
          Comps[i].WarnedTime := True;
          UDPSend(Comps[i].ipaddr,STR_CMD_SHOW_WARNING_TEXT
                  + '='
                  + 'У Вас осталось 5 минут');
          if GClientOptions.UseSounds then begin
          // russian
            if (GClientOptions.Language = 2) then
              UDPSend(Comps[i].ipaddr,STR_CMD_PLAY_SOUND
                  + '='
                  + WAVFILE_5MINSLEFT_RU);
            if (GClientOptions.Language = 1) then
              UDPSend(Comps[i].ipaddr,STR_CMD_PLAY_SOUND
                  + '='
                  + WAVFILE_5MINSLEFT_ENG);
          end;
        end;
      end;
end;

procedure ehsSendMessage;
begin
 if (not FunctionAmIRight(FN_SENDMESSAGE)) then exit;
 formMail.ShowModal;
// MessageBox(HWND_TOP, 'SendMessage function','info', MB_OK);
end;

procedure ehsRemoteClientsManage;
begin
  Application.CreateForm(TformRemoteManage, formRemoteManage);
  formRemoteManage.ShowModal;
  formRemoteManage.Destroy;
end;

// traffic
procedure ProxyInitialize;
var
  i: integer;
begin
  // проверка на пробном этапе
  // если дни кончились, то нет подсчета трафа
  if ((StrLen(Registration.UserName) = 0)
      and ((Registration.TrialDaysLeft=0)
      or (Registration.TrialExLeft=0))) then
    Registration.InternetControl := False;
// если же дни еще есть, то подсчет трафа еще работает
  if ((StrLen(Registration.UserName) = 0)
      and (Registration.TrialDaysLeft<>0)
      and (Registration.TrialExLeft<>0))
    then Registration.InternetControl := True;

  if (isManager) then exit;

  if GRegistry.Modules.Internet.InnerProxy then begin
    // создаем объект прокси
    FProxy := TProxy.Create;

    // добавляем в Proxy ip адреса компьютеров
    for i:=0 to (CompsCount-1) do
      if not FProxy.IPAdded(Comps[i].ipaddr) then
        FProxy.IPAdd(Comps[i].ipaddr);
    if GRegistry.Options.OperatorTrafficControl then
      FProxy.IPAdd(GRegistry.Options.OperatorIP);
    // добавляем маппинги
    for i:=0 to (FMappings.count-1) do
      FProxy.MappingAdd(FMappings.LMappings[i].listenport,FMappings.LMappings[i].mappedip, FMappings.LMappings[i].mappedport);

    // стартуем проксик
    FProxy.Start;
  end;
  if (GRegistry.Modules.Internet.OuterPlugin
      or GRegistry.Modules.Internet.LinuxPro
      or GRegistry.Modules.Internet.LinuxFree) then begin
    // создаем объект прокси
    FProxy := TLinuxProxy.Create;

    // добавляем в Proxy ip адреса компьютеров
    for i:=0 to (CompsCount-1) do
      if not FProxy.IPAdded(Comps[i].ipaddr) then
        FProxy.IPAdd(Comps[i].ipaddr);
    if GRegistry.Options.OperatorTrafficControl then
      FProxy.IPAdd(GRegistry.Options.OperatorIP);
    // стартуем проксик
    FProxy.Start;
  end;
end;

procedure ehsVolume;
begin
  if (not FunctionAmIRight(FN_VOLUME)) then exit;
  Application.CreateForm(TfrmVolume, frmVolume);
  frmVolume.Load;
{  if (frmVolume.ShowModal = mrOK) then
    ehsPingComputers;}
  frmVolume.ShowModal;
  frmVolume.Destroy;
end;

procedure MakeCurrentReport(strings: TStrings);
var
  LastShiftPoint: TDateTime;
  DTstart, DTend: TDateTime;
  strTotal, strRest: string;
  totalTime, totalService, totalTraffic, totalPrinted: double;
  nAccountPayed, nAccountAdded, nAccountReturned: double;
  fTotalMoney, fRestMoney, fRemovedMoney: double;
begin

  DTend := GetVirtualTime;
  fTotalMoney := dsGetCurrentShiftTotal(totalTime, totalService,
      totalTraffic, totalPrinted, nAccountAdded, nAccountPayed,
      nAccountReturned, LastShiftPoint);
  fRemovedMoney := GRegistry.Options.RemovedMoney;
  fRestMoney := fTotalMoney - fRemovedMoney; 

  strTotal := FormatFloat('0.00', fTotalMoney);
  DTstart := LastShiftPoint;
  strRest := FormatFloat('0.00',dsGetCurrentShiftRest);

  strings.Clear;
  strings.Add('>'+translate('lblIntervalShift'));
  strings.Add(translate('lblStartDate')+': '+ DateTimeToSql(DTstart));
  strings.Add(translate('lblEndDate')+': '+ DateTimeToSql(DTend));
  if isManager then
    strings.Add(translate('subOperator')+': -----') // ToDo определить оператора
  else
    strings.Add(translate('subOperator')+': '+CurOperatorName);
  if GRegistry.Options.OperatorTrafficControl
      and GRegistry.Modules.Internet.SummaryAccounting then begin
    strings.Add(translate('Traffic')+' = '
      + GetShortSizeString(GetOperatorTraffic));
  end;
  if(FunctionAmIRight(FN_VIEW_FINANCE_ON_SHIFT_REPORT)) then begin
     strings.Add('');
     strings.Add('>'+translate('lblSummary'));
     strings.Add(translate('lblTimeNal')+' = '+FormatFloat('0.00',totalTime));
     strings.Add(translate('lblServiceNal')+' = '+FormatFloat('0.00',totalService));
//     strings.Add(translate('lblTrafficNal')+' = '+FormatFloat('0.00',totalTraffic));
     strings.Add(translate('lblPrintedNal')+' = '+FormatFloat('0.00',totalPrinted));
     strings.Add(translate('lblAccountAdded')+' = '+FormatFloat('0.00',nAccountAdded));
     strings.Add(translate('lblAccountPayed')+' = '+FormatFloat('0.00',nAccountPayed));
     strings.Add(translate('lblAccountReturned')+' = '+FormatFloat('0.00',nAccountReturned));
     strings.Add('');
     strings.Add('Итого заработано = ' + strTotal + ' , из них:');
     strings.Add({translate('lblItogoNal') + }'  у оператора = '
        + FormatFloat('0.00', fRestMoney));
     strings.Add('  у менеджера = '
        + FormatFloat('0.00', fRemovedMoney));
     strings.Add(translate('lblRestMoney')+' = '+strRest);
   end;
end;

procedure SetBackColor(const AColor: TColor);
begin
  formMain.gridComps.Color := Acolor;
  formMain.lvConsole.Color := Acolor;
  formMain.memoClientInfo.Color := Acolor;
  formMain.FfrmReports.SetBackColor(Acolor);
  if dsConnected then
    GRegistry.UserInterface.BackColor := Acolor;
end;

procedure SetTableFont(const AFont: TFont);
begin
  formMain.gridComps.Font.Assign(AFont);
  formMain.FfrmReports.SetFont(AFont);
  if dsConnected then
    GRegistry.UserInterface.TableFont := AFont;
end;

procedure ehsColor;
begin
  if not formMain.ColorDialog.Execute then exit;
  SetBackColor(formMain.ColorDialog.Color);
end;

procedure ehsPenalty;
var
  nIndex: Integer;
begin
  if (not FunctionAmIRight(FN_PENALTY)) then exit;
  nIndex := ComputersGetIndex(CompsSel[0]);
  Comps[nIndex].session.UpdateOnDB(0, 0, 0, 0, 0, 0, 0, -GnMinPenalty);
  SendAllOptionsToClient(nIndex);
  if GClientOptions.UseSounds then
    UDPSend(Comps[nIndex].ipaddr, STR_CMD_PLAY_SOUND
        + '='
        + IfThen((GClientOptions.Language = 1), WAVFILE_YOUAREPENALIZED_ENG,
        WAVFILE_YOUAREPENALIZED_RU)
        + '/'
        + WAVFILE_FORMINUTE_BEGIN
        + IntToStr(GnMinPenalty)
        + IfThen((GClientOptions.Language = 1), WAVFILE_FORMINUTE_END_ENG,
        WAVFILE_FORMINUTE_END_RU));
  Console.AddEvent(EVENT_ICON_INFORMATION, LEVEL_1, translate('Computer') + ' '
      + Comps[nIndex].GetStrNumber + ' / ' + translate('labelUser') + ' '
      + GetAccountName(Comps[nIndex].a) + ' >> ' + DateTimeToSql(GetVirtualTime)
      + ' / ' + translate('subPenalty') + ' ' + IntToStr(GnMinPenalty) + ' '
      + translate('Minutes'));
  dmActions.actLoadSessions.Execute;
  dmActions.actRedrawComps.Execute;
end;

procedure ehsNothing;
begin
end;

procedure ehsChangeTarif;
var
  index : integer;
begin
  if (isManager) then exit;
  if (not FunctionAmIRight(FN_CHANGE_TARIF)) then exit;
  Application.CreateForm(TformCompChangeTarif, formCompChangeTarif);
  index := ComputersGetIndex(CompsSel[0]);
  if (formCompChangeTarif.ShowModal = mrOK) and
     (formCompChangeTarif.SelectedTarifIndex <> -1) then begin
    Comps[index].session.ChangeTariff(Tarifs[formCompChangeTarif.SelectedTarifIndex],
      formCompChangeTarif.dtpNewStart.DateTime,
      formCompChangeTarif.dtpNewStop.DateTime);
    dmActions.actLoadSessions.Execute;
    dmActions.actRedrawComps.Execute;
    DoInterfaceComps;
    PingComputer(index);
    SendAllOptionsToClient(index);
    Console.AddEvent(EVENT_ICON_INFORMATION, LEVEL_1,
        translate('ActionChangeTariff') + ' '
        + Comps[index].session.ConsoleInfo);
    RunSessionScript(saChangeTarif, Comps[index].session);
  end;
  formCompChangeTarif.Destroy;
end;

procedure dsLoadSessions;
begin
  if GSessions <> Nil then
    GSessions.Load;
end;

procedure ehsManualRemoteInstall;
{var
  GCInstallCl: TGCInstall;
  NameComps : TStringList;
  i:Integer;
}
begin
{  if (not FunctionAmIRight(FN_MANUAL_REMOTE_INSTALL)) then exit;
  NameComps := TStringList.Create;
  GCInstallCl := TGCInstall.Create;

  if not GCInstallCl.IsTrueVersion(FULL_APP_VERSION) then exit;

  if GCInstallCl.SetLogin(formMain) then begin
    try
      GCInstallCl.SaveOperatorLogin;
      for i := 0 to CompsSelCount-1 do
        if Comps[ComputersGetIndex(CompsSel[i])].pingable then begin
          //UDPSend(Comps[ComputersGetIndex(CompsSel[i])].ipaddr, STR_CMD_CLOSECLIENT]);
          // now client closing with command "gcimport gccl.exe" runned on client computer

          if (StrLComp(PChar(Comps[ComputersGetIndex(CompsSel[i])].strInfoWinver), PChar('Windows 98'), 10) <> 0) then
            NameComps.Add(Comps[ComputersGetIndex(CompsSel[i])].ipaddr)
          else
            Console.AddEvent(EVENT_ICON_ERROR, LEVEL_0, 'Install client to computer ('+Comps[ComputersGetIndex(CompsSel[i])].ipaddr+') - Windows 98 not supported!');

        end
        else
          Console.AddEvent(EVENT_ICON_ERROR, LEVEL_0, 'Install client to computer ('+Comps[ComputersGetIndex(CompsSel[i])].ipaddr+') - computer is powered off!');
      GCInstallCl.Install(NameComps, formMain.Handle);
    finally
     NameComps.Free;
    end;
  end;
  GCInstallCl.Free;
}
end;

procedure ehsReserveActivate;
var
  i: integer;
  session: TGCSession;
begin
  if (isManager) then exit;
  if (not FunctionAmIRight(FN_RESERVE_ACTIVATE)) then exit;
  for i := 0 to CompsSelCount-1 do begin
    session := Comps[ComputersGetIndex(CompsSel[i])].session;
    if (session <> Nil) then
      if (session.Status = ssReserve) then begin
        ReserveActivate(session);
      end;
  end;
end;

procedure ReserveActivate(ASession: TGCSession);
begin
  ASession.Status := ssActive;
  if GClientOptions.Agreement then
    ASession.State := ClientState_OperatorAgreement
  else
    ASession.State := ClientState_OperatorSession;
  Console.AddEvent(EVENT_ICON_INFORMATION, LEVEL_1,
      translate('SessionActivated') + ' ' + ASession.ConsoleInfo);
  ASession.UpdateOnDB(0, 0, 0, 0, 0, 0, 0, 0);
  RunSessionScript(saStart, ASession);
  if GRegistry.Client.TaskKillBeforeStart then
    UDPSend(Comps[ComputersGetIndex(ASession.IdComp)].ipaddr,
      STR_CMD_KILLTASK + '=');
  SendAllOptionsToClient(ComputersGetIndex(ASession.IdComp));
end;

procedure ehsReserveCancel;
begin
  if (not FunctionAmIRight(FN_RESERVE_CANCEL)) then exit;
  ReserveCancel(Comps[ComputersGetIndex(CompsSel[0])].session);
end;

procedure ReserveCancel(ASession: TGCSession);
var
  index: integer;
  bActionCanceled: Boolean;
begin
  if (isManager) then exit;
  if (not FunctionAvailable(FN_RESERVE_CANCEL)) then exit;
  index := ComputersGetIndex(CompsSel[0]);
  Application.CreateForm(TformCompStop, formCompStop);
   if (formCompStop.ShowModal(caReserveCancel,
      ASession.IdSessionsAdd) = mrOK) then
  begin
    bActionCanceled := False;
    if GRegistry.Modules.KKM.Active then begin
      bActionCanceled := not PrintCheckStop(ASession)
          and GRegistry.Modules.KKM.DisconnectBlock;
    end;
    if bActionCanceled then
      Console.AddEvent(EVENT_ICON_INFORMATION, LEVEL_1,
          'Операция отменена из-за ошибки ККМ: '
          + GKKMPlugin.GetLastError)
    else begin
      ASession.Stop(False);
      dmActions.actLoadSessions.Execute;
      DoInterfaceComps;
      dmActions.actRedrawComps.Execute;
      PingComputer(index);
    end;
  end;
//  formCompStop.Destroy;
end;

//ehsSessionTrafficPayment
procedure ehsSessionTrafficPayment;
var
  AddSumma: double;
  index: integer;
  bActionCanceled: Boolean;
begin
  if (isManager) then exit;
  if (not FunctionAmIRight(FN_SESSION_TRAFFIC_PAYMENT)) then exit;
  index := ComputersGetIndex(CompsSel[0]);
  Application.CreateForm(TformCompTrafficAdd, formCompTrafficAdd);
  if (formCompTrafficAdd.ShowModal = mrOK) then
  begin
    AddSumma := StrToFloatGC(formCompTrafficAdd.editMoney.Text);
    bActionCanceled := False;
    if GRegistry.Modules.KKM.Active then begin
      bActionCanceled := not PrintAddTraffic(Comps[index].session, AddSumma)
          and GRegistry.Modules.KKM.DisconnectBlock;
    end;
    if bActionCanceled then
      Console.AddEvent(EVENT_ICON_INFORMATION, LEVEL_1,
          'Операция отменена из-за ошибки ККМ: ' + GKKMPlugin.GetLastError)
    else begin
      Comps[index].session.UpdateOnDB(0, AddSumma, 0, 0, 0, 0, 0, 0);
      Console.AddEvent(EVENT_ICON_INFORMATION, LEVEL_1, translate('AddTraffic')
          + ' ' + Comps[index].GetStrNumber + ' >> '
          + DateTimeToSql(GetVirtualTime) + ' / ' + FormatFloat('0.00',AddSumma)
          + ' ' + GRegistry.Options.Currency);
      dmActions.actLoadSessions.Execute;
      dmActions.actRedrawComps.Execute;
    end;
  end;
  formCompTrafficAdd.Destroy;
end;

function GetSize: Cardinal;
begin
  Result := 0;
  if FileExists(Application.ExeName) then
    Result := FileSizeByName(Application.ExeName);
end;

procedure PingComputer(const AnComputerIndex: Integer);
var
  n: integer;
  block_opt: string;
  uncontrol_flag: boolean;
  strParm: String;
begin

  if (isManager) then exit;
  uncontrol_flag := false;
  // считаем количество отправленных пингов

//  Comps[AnComputerIndex].IcmpPingable := PingICMP(Comps[AnComputerIndex].ipaddr);
  Comps[AnComputerIndex].pings := Comps[AnComputerIndex].pings + 1;
  // если уже отправили пакетов больше чем максимум, то считаем что комп
  // НЕ КОНТРОЛИРУЕТСЯ
  if (Comps[AnComputerIndex].pings > MAXIMUM_LOST_PINGS) or
    (not Comps[AnComputerIndex].IcmpPingable) then
  begin
    // 1) было false - gccommon::dsControlCompTimer
    // 2) было true - gccommon::dsControlCompStart
    if (Comps[AnComputerIndex].control = false) then
      dsControlCompTimer(Comps[AnComputerIndex].id)
    else begin
      uncontrol_flag := true;
      dsControlCompStart(Comps[AnComputerIndex].id);
    end;
    // сбрасываем метку в false
    Comps[AnComputerIndex].control := false;
  end;
  if (not FunctionAmIRight(FN_REMOTE_CONTROL)) then begin
    if ((Comps[AnComputerIndex].busy = true) and (Comps[AnComputerIndex].session<>Nil) and (Tarifs[TarifsGetIndex(Comps[AnComputerIndex].session.IdTarif)].internet = 1))
    then
      strParm := '=0/'
    else
      strParm := '=1/';
    if GRegistry.Volume[AnComputerIndex + 1].Custom then
      strParm := strParm +
                 IntToStr(GRegistry.Volume[AnComputerIndex + 1].Main)+'/'+
                 IntToStr(GRegistry.Volume[AnComputerIndex + 1].Wave)+'/'+
                 IfThen(GRegistry.Volume[AnComputerIndex + 1].Mute,'1','0')
    else
      strParm := strParm +
                 IntToStr(GRegistry.Volume[0].Main)+'/'+
                 IntToStr(GRegistry.Volume[0].Wave)+'/'+
                 IfThen(GRegistry.Volume[0].Mute,'1','0');
    strParm := strParm + '/' + IfThen(GRegistry.Volume.OnlyLimit,'0','1');

    UDPSend(Comps[AnComputerIndex].ipaddr, STR_CMD_PING + strParm);
  end;
  // компу надо послать инфу на клиента
  SendAccountAndSessionInfoToClient(AnComputerIndex);
  
  if Comps[AnComputerIndex].Busy
      and not Comps[AnComputerIndex].Agreement then
  begin
    UDPSend(Comps[AnComputerIndex].ipaddr, STR_CMD_BLOCKED);
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
    if (Comps[AnComputerIndex].a.state <> ClientState_Blocked) and (n <> 0) then
       Delete(block_opt,n,1);
    //блокируем всегда, когда не занят
    UDPSend(Comps[AnComputerIndex].ipaddr,
        STR_CMD_BLOCKED + block_opt);
    // всегда блокируем инет, если комп свободен
    //if (Registration.GCInternetControlLinux = 1) then
    if GRegistry.Modules.Internet.OuterPlugin
        or GRegistry.Modules.Internet.LinuxPro
        or GRegistry.Modules.Internet.LinuxFree then
      UDPSend(GRegistry.Options.UnixServerIP,
          STR_CMD_INETBLOCK
          + Comps[AnComputerIndex].ipaddr);
  end;
  //Афвтологофф
  if GClientOptions.AutoLogoff
      and (Comps[AnComputerIndex].a.state = ClientState_Order)
      and (GetVirtualTime >= IncSecond(
      Comps[AnComputerIndex].a.LogonOrStopMoment,
      GClientOptions.AutoLogoffSec)) then begin
    Console.AddEvent(EVENT_ICON_INFORMATION, LEVEL_1,
        translate('AuthenticationLogoff') + ' / ' + translate('Computer')
        + ' ' + Comps[AnComputerIndex].GetStrNumber + ' / '
        + translate('labelUser')
        + ' ' + GetAccountName(Comps[AnComputerIndex].a));
    Comps[AnComputerIndex].a.number := 0;
    QueryAuthGoState1(AnComputerIndex);
  end;
  if (GRegistry.UserInterface.SoundLostLink
      and uncontrol_flag) then
    DoSound([NotifyLostLink]);
end;



// процедура обертки данных протоколом
function WrapProtocol(sdata: string): string;
begin
  WrapProtocol := 'v01.' + sdata;
end;

// процедура разворачивания данных
procedure UnWrapProtocol(sdata: string; protocol, cmd, param: pstring);
begin
  protocol^ := copy(sdata,1,3);
  sdata := copy(sdata,5,8000);
  cmd^ := sdata;
  param^ := '';
  if Pos('=',sdata)<>0 then begin
    cmd^ := copy(sdata,1,Pos('=',sdata)-1);
    param^ := copy(sdata,Pos('=',sdata)+1,8000);
  end;
end;

function IsTimeOff: Boolean;
begin
  with GRegistry.Options do
    Result := OperatingTime
        and (CompareTime(GetVirtualTime, OperatingTimeEnd) = GreaterThanValue)
        or (CompareTime(GetVirtualTime, OperatingTimeBegin) = LessThanValue);
end;

function SystemErrorMessage: string;
var
  P: PChar;
begin
  if FormatMessage(Format_Message_Allocate_Buffer + Format_Message_From_System,
                   nil,
                   GetLastError,
                   0,
                   @P,
                   0,
                   nil) <> 0 then
  begin
    Result := P;
    LocalFree(Integer(P))
  end
  else
    Result := '';
end;


end.
