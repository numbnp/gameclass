// Основной модуль главной формы приложения
// приложение то у нас простое :)
// 2 января 2003
unit frmMain;

interface

uses
  GCCommon,
  GCLangUtils,
  GCFunctions,
  GCComputers,
  GCConst,
  frmGCMessageBox,
  registry,
  Dialogs,
  DB,
  ADODB,
  Menus,
  ExtCtrls,
  ImgList,
  Controls,
  Forms,
  StdCtrls,
  ComCtrls,
  Grids,
  DBGridEh,
  ToolWin,
  Classes,
  ufrmTaskKill,
  Proxy,
  ShellAPI,
  Messages,
  DateUtils,
  IdBaseComponent,
  IdUDPBase,
  IdUDPServer,
  IdSocketHandle,
  IdUDPClient,
  IdICMPClient,
  IdComponent,
  DBTables,
  DBClient,
  Provider,
  SqlExpr,
  DBLocal,
  Types,
  uframeMessages,
  bsPolyglotUn,
  udmActions,
  ufrmReports,
  udmMain,
  Graphics, XPMan,
  ufrmOperatorOpt;

type
  TformMain = class(TForm)
    menuMain: TMainMenu;
    subSystem: TMenuItem;
    mnuLogon: TMenuItem;
    sep1: TMenuItem;
    mnuExit: TMenuItem;
    subHelp: TMenuItem;
    mnuAbout: TMenuItem;
    mnuLanguage: TMenuItem;
    mnuLangRussian: TMenuItem;
    mnuLangEnglish: TMenuItem;
    mnuLogout: TMenuItem;
    ilActions: TImageList;
    subWork: TMenuItem;
    mnuStart: TMenuItem;
    mnuStop: TMenuItem;
    mnuMove: TMenuItem;
    ilSmall: TImageList;
    sep2: TMenuItem;
    mnuChangePass: TMenuItem;
    timerCompsList: TTimer;
    subOperator: TMenuItem;
    mnuCloseShift: TMenuItem;
    sep3: TMenuItem;
    mnuSessionLast: TMenuItem;
    PopupMenuComps: TPopupMenu;
    subBoss: TMenuItem;
    N1: TMenuItem;
    mnuClearStat: TMenuItem;
    mnuAdd: TMenuItem;
    N2: TMenuItem;
    mnuRemont1: TMenuItem;
    mnuRemontLong: TMenuItem;
    ilEvents: TImageList;
    mnuBossOptions: TMenuItem;
    mnuSideline: TMenuItem;
    PopupMenuTray: TPopupMenu;
    cmnRestore: TMenuItem;
    mnuManualPrint: TMenuItem;
    N4: TMenuItem;
    mnuHelp: TMenuItem;
    mnuShellMode: TMenuItem;
    mnuShellModeOn: TMenuItem;
    mnuShellModeOff: TMenuItem;
    subExtendedFunctions: TMenuItem;
    mnuRestart: TMenuItem;
    mnuShutdown: TMenuItem;
    mnuKillTask: TMenuItem;
    mnuKillTasksTemplate: TMenuItem;
    mnuRemoteManage: TMenuItem;
    N3: TMenuItem;
    N5: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    pnlTop: TPanel;
    tbActions: TToolBar;
    tbCompStart: TToolButton;
    tbCompAdd: TToolButton;
    tbCompStop: TToolButton;
    tbCompMove: TToolButton;
    ToolButton9: TToolButton;
    tbSideline: TToolButton;
    ToolButton1: TToolButton;
    pnlTimer: TPanel;
    dtpIntTime: TDateTimePicker;
    dtpIntDate: TDateTimePicker;
    tmrIntDate: TTimer;
    butResetTime: TButton;
    pnlBottom: TPanel;
    lvConsole: TListView;
    memoClientInfo: TMemo;
    N9: TMenuItem;
    mnuClientInfo: TMenuItem;
    tmrShowFormKillTasks: TTimer;
    mnuAccounts: TMenuItem;
    N6: TMenuItem;
    mnuAccounts2: TMenuItem;
    mnuAllowAuthorization: TMenuItem;
    N11: TMenuItem;
    gridComps: TDBGridEh;
    dsComps: TDataSource;
    cdsComps: TADODataSet;
    PageControl: TPageControl;
    tabComputers: TTabSheet;
    splitComps: TSplitter;
    mnuVolumes: TMenuItem;
    N10: TMenuItem;
    mnuCompVolume: TMenuItem;
    ilReports: TImageList;
    ColorDialog: TColorDialog;
    mnuColor: TMenuItem;
    subPenalty: TMenuItem;
    mnuPenalty1: TMenuItem;
    mnuPenalty2: TMenuItem;
    mnuPenalty5: TMenuItem;
    mnuPenalty10: TMenuItem;
    mnuPenalty15: TMenuItem;
    mnuRestrictions: TMenuItem;
    mnuChangeTarif: TMenuItem;
    mnuInstall: TMenuItem;
    tmrFileSynchronization: TTimer;
    tmrCyclicCompAction: TTimer;
    timerGSessionsLoad: TTimer;
    N12: TMenuItem;
    mnuActivateReserve: TMenuItem;
    mnuCancelReserve: TMenuItem;
    mnuTrafiicAdd: TMenuItem;
    N13: TMenuItem;
    mnuRunPadShell: TMenuItem;
    tabMessages: TTabSheet;
    frameMessages: TframeMessages;
    tbCompReset: TToolButton;
    N14: TMenuItem;
    mnuService: TMenuItem;
    mnuGetMoney: TMenuItem;
    FontDialog: TFontDialog;
    mnuFont: TMenuItem;
    tabReports: TTabSheet;
    pnlReports: TPanel;
    bsPolyglotTranslator1: TbsPolyglotTranslator;
    N15: TMenuItem;
    mnuXReport: TMenuItem;
    mnuZReport: TMenuItem;
    mnuAddCheckAccount: TMenuItem;
    subTimeBonus: TMenuItem;
    mnuTimeBonus1: TMenuItem;
    mnuTimeBonus2: TMenuItem;
    mnuTimeBonus5: TMenuItem;
    mnuTimeBonus10: TMenuItem;
    mnuTimeBonus15: TMenuItem;
    mnuWakeUp: TMenuItem;
    tbCompShutdown: TToolButton;
    PopupMenuShutdown: TPopupMenu;
    cmnShutdownAll: TMenuItem;
    cmnShutdownFree: TMenuItem;
    ToolButton2: TToolButton;
    tbCompWakeUp: TToolButton;
    tbCompLogoff: TToolButton;
    PopupMenuReset: TPopupMenu;
    cmnResetAll: TMenuItem;
    cmnResetFree: TMenuItem;
    PopupMenuWakeup: TPopupMenu;
    cmnWakeupAll: TMenuItem;
    cmnWakeFree: TMenuItem;
    cmnWakeupNoFree: TMenuItem;
    mnuTableOpt: TMenuItem;
    mnuLogoff: TMenuItem;
    PopupMenuLogoff: TPopupMenu;
    cmnLogoffAll: TMenuItem;
    cmnLogoffFree: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    // when change language
    procedure RedrawListCompsLanguage;
    procedure RedrawListConsoleLanguage;
    procedure RedrawLanguage;

    procedure UpdateSelectedCompList;

    procedure timerCompsListTimer(Sender: TObject);
    procedure mnuStartClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tbCompStartClick(Sender: TObject);
    procedure tbCompStopClick(Sender: TObject);
    procedure tbCompMoveClick(Sender: TObject);
    procedure mnuStopClick(Sender: TObject);
    procedure mnuCloseShiftClick(Sender: TObject);
    procedure tbCurrentReportClick(Sender: TObject);
    procedure mnuSessionLastClick(Sender: TObject);
    procedure BuildPopupMenu(AMenuItem:TMenuItem; APopupItem:TMenuItem);
    procedure mnuRemont1Click(Sender: TObject);
    procedure mnuRemontLongClick(Sender: TObject);
    procedure mnuAddClick(Sender: TObject);
    procedure tbCompAddClick(Sender: TObject);
    procedure mnuMoveClick(Sender: TObject);
    procedure mnuChangePassClick(Sender: TObject);
    procedure mnuBossOptionsClick(Sender: TObject);
    procedure mnuClearStatClick(Sender: TObject);
    procedure mnuSidelineClick(Sender: TObject);
    procedure tbSidelineClick(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure cmnRestoreClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

    procedure MinimizeToTray(Sender: TObject);
    procedure RestoreMainForm;
    procedure ShowThePopup;
    procedure mnuManualPrintClick(Sender: TObject);
    procedure mnuShellModeOnClick(Sender: TObject);
    procedure mnuShellModeOffClick(Sender: TObject);
    procedure mnuKillTaskClick(Sender: TObject);
    procedure mnuRestartClick(Sender: TObject);
    procedure mnuShutdownClick(Sender: TObject);
    procedure mnuKillTasksTemplateClick(Sender: TObject);
    procedure mnuRemoteManageClick(Sender: TObject);
    procedure subMessagesClick(Sender: TObject);
    procedure tmrIntDateTimer(Sender: TObject);
    procedure dtpIntDateChange(Sender: TObject);
    procedure butResetTimeClick(Sender: TObject);
    procedure mnuClientInfoClick(Sender: TObject);
    procedure udpServer_UDPRead(Sender: TObject; AData: TStream;
      ABinding: TIdSocketHandle);
    function EnableSockets: Boolean;
    procedure DisableSockets;
    procedure tmrShowFormKillTasksTimer(Sender: TObject);
    procedure mnuAccountsClick(Sender: TObject);
    procedure mnuAccounts2Click(Sender: TObject);
    procedure mnuAllowAuthorizationClick(Sender: TObject);
    procedure gridCompsSortMarkingChanged(Sender: TObject);
    procedure gridCompsCellClick(Column: TColumnEh);
    procedure gridCompsDblClick(Sender: TObject);
    procedure gridCompsContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure mnuVolumesClick(Sender: TObject);
    procedure mnuCompVolumeClick(Sender: TObject);
    procedure mnuColorClick(Sender: TObject);
    procedure mnuPenalty1Click(Sender: TObject);
    procedure mnuPenalty10Click(Sender: TObject);
    procedure mnuPenalty15Click(Sender: TObject);
    procedure mnuPenalty2Click(Sender: TObject);
    procedure mnuPenalty5Click(Sender: TObject);
    procedure mnuRestrictionsClick(Sender: TObject);
    procedure mnuChangeTarifClick(Sender: TObject);
    procedure mnuInstallClick(Sender: TObject);
    procedure tmrFileSynchronizationTimer(Sender: TObject);
    procedure gridCompsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tmrCyclicCompActionTimer(Sender: TObject);
    procedure gridCompsMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure timerGSessionsLoadTimer(Sender: TObject);
    procedure mnuActivateReserveClick(Sender: TObject);
    procedure mnuCancelReserveClick(Sender: TObject);
    procedure mnuTrafiicAddClick(Sender: TObject);
    procedure mnuRunPadShellClick(Sender: TObject);
    procedure frameMessagesbtnSendClick(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PageControlChange(Sender: TObject);
    procedure tbCompResetClick(Sender: TObject);
    procedure mnuServiceClick(Sender: TObject);
    procedure mnuGetMoneyClick(Sender: TObject);
    procedure mnuFontClick(Sender: TObject);
    procedure Error(const Sender: TObject;
    const AnErrorNumber: Integer; const AlstError: TStringList);
    procedure mnuXReportClick(Sender: TObject);
    procedure mnuZReportClick(Sender: TObject);
    procedure mnuTimeBonus1Click(Sender: TObject);
    procedure mnuTimeBonus2Click(Sender: TObject);
    procedure mnuTimeBonus5Click(Sender: TObject);
    procedure mnuTimeBonus10Click(Sender: TObject);
    procedure mnuTimeBonus15Click(Sender: TObject);
    procedure gridCompsKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mnuLogoutClick(Sender: TObject);
    procedure mnuWakeUpClick(Sender: TObject);
    procedure gridCompsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure tbCompShutdownClick(Sender: TObject);
    procedure cmnShutdownAllClick(Sender: TObject);
    procedure cmnShutdownFreeClick(Sender: TObject);
    procedure tbCompWakeUpClick(Sender: TObject);
    procedure cmnResetAllClick(Sender: TObject);
    procedure cmnResetFreeClick(Sender: TObject);
    procedure cmnWakeupAllClick(Sender: TObject);
    procedure cmnWakeFreeClick(Sender: TObject);
    procedure cmnWakeupNoFreeClick(Sender: TObject);
    procedure gridCompsGetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure mnuTableOptClick(Sender: TObject);
    procedure tbCompLogoffClick(Sender: TObject);
    procedure mnuLogoffClick(Sender: TObject);
    procedure cmnLogoffAllClick(Sender: TObject);
    procedure cmnLogoffFreeClick(Sender: TObject);

  private
    { Private declarations }
    FTrayIcon: TNotifyIconData;
    FbStarting: Boolean; // True если FormActivate вызывается первывй раз
                         // убить когда избавллюсь от Event'ов
//    FfrmReports: TfrmReports;
    FstrHotNumber: String;
    FdtHotNumberEntered: TDateTime;
  public
    // constructor / destructor
    FfrmReports: TfrmReports;
    Timer2 : TTimer;            // timer for threads forms
    ShowFormKillTasks_param: string;
    ShowFormKillTasks_index: integer;
//    cnnMain: TADOConnection;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy(); override;

    procedure icmpClient_OnReply(ASender: TComponent;
      const AReplyStatus: TReplyStatus);
    property Starting: Boolean read FbStarting write FbStarting;
  end;

//procedure UDPSend(const AstrIP: string; const AstrData: string);
procedure ShowFormKillTasks(listtasks: string; compindex: integer);
procedure QueryAuthGoState1(AnCompIndex: Integer);
procedure SendAuthGoState1(nCompIndex:Integer; bNewSecCode:Boolean);
procedure SendAuthGoState2(CompIndex:Integer);
procedure SortDataSet(bMakeSorting: boolean);
procedure ResetDataSetBookmark;
procedure IcmpPing;

function GetIdColumnByFieldName(Grid:TDBGridEh; FieldName: String):integer;

var
  formMain: TformMain;

implementation

uses
  Math,
  StrUtils,
  ufrmAccounts,
  EhLibADO,
  uCoder ,
  GCSessions,
  SysUtils,
  Windows,
  uClientOptions,
  uClientOptionsConst,
  uDebugLog,
  uClientInfoConst,
  uSecurityMonitor,
  uHardwareAnalizer,
  uVirtualTime,
  uAccountSystem,
  uAccountsRecord,
  uRegistry,
  uRegistryTaskKill,
  uProtocol,
  uFilesSynchronize,
  uServerScripting,
  frmSideline,
  ufrmGetMoney,
  uErrors,
  uTariffication,
  gcsystem,
  uY2KString,
  uRegistration,
  uKKMTools, Variants;

{$R *.dfm}


////////////////////////////////////////////////////////////////
// рекурсивное копирование менюшек
// AMenuItem - меню, которое добавляем
// APopupItem - меню, в которое добавляем
// примеры вызова:
// 1)    BuildPopupMenu(N1, PopupMenu1.Items);
// 2)    BuildPopupMenu(AMenuItem.Items[i], PopupMenu1.Items[i]);
////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TformMain.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FfrmReports := TfrmReports.Create(pnlReports, dmMain.ReportManager);
  FfrmReports.Parent := pnlReports;
  FfrmReports.Align := alClient;
  FfrmReports.Show();
end; // TformMain.Create


destructor TformMain.Destroy();
begin
  FreeAndNil(FfrmReports);

  inherited Destroy();
end; // TformMain.Destroy

procedure TformMain.BuildPopupMenu(AMenuItem:TMenuItem; APopupItem:TMenuItem);
var
//  index: Integer;
  NewItem: TMenuItem;
  i: integer;
begin
  try
    for i:=0 to AMenuItem.Count-1 do
      begin
        NewItem := TMenuItem.Create(PopupMenuComps);
        NewItem.Caption := AMenuItem.Items[i].Caption;
        NewItem.OnClick := AMenuItem.Items[i].OnClick;
        NewItem.Enabled := AMenuItem.Items[i].Enabled;
        APopupItem.Add(NewItem);
        if AMenuItem.Items[i].Count > 0 then
          begin
            BuildPopupMenu(AMenuItem.Items[i], APopupItem.Items[i]);
          end
      end;
  except
    // ну тут не совсем корректная обработка
    // я подошел с той точки зрения, что те пункты меню,
    // которые удалось создать до возникновения ошибки,
    // я не грохаю.
    // может быть рубить надо все?
    //NewItem.Free();
    //NewItem := nil;
    raise;
  end;
end;

// тут инициализируем все наши переменные
procedure TformMain.FormCreate(Sender: TObject);
var
//  info: TFileCheckSumInfo;
  key: TKeyArray;
begin
  timerCompsList.Interval := GLOBAL_TIMER * 1000;
  FstrHotNumber := '';
  FdtHotNumberEntered := Now;
  FProxy := nil;
  udpClient := nil;
  udpServer := nil;
  icmpClient := nil;
  OperatorProfile := TOperatorProfile.Create;
  Console := TConsole.Create;
  Sideline := TSideline.Create;
//  asys := TAccountSystem.Create;
  FMappings := TMappings.Create;

  FTrayIcon.cbSize := SizeOf(FTrayIcon);
  FTrayIcon.Wnd := Self.Handle;
  FTrayIcon.uID := 0;
  FTrayIcon.uFlags := NIF_ICON or NIF_TIP or NIF_MESSAGE;
  FTrayIcon.uCallbackMessage := WM_MOUSEMOVE;
  FTrayIcon.hIcon := Application.Icon.Handle;
  FTrayIcon.szTip := FORM_MAIN_CAPTION;
  Application.OnMinimize := MinimizeToTray;
  Randomize;
  formMain.cdsComps.CreateDataSet;
  FbStarting := True;
end;

// When Main Form activate then settings default language
procedure TformMain.FormActivate(Sender: TObject);
begin
  if Starting then begin
    dmActions.actPreLogon.Execute;
    dmActions.actConnect.Execute;        // do Logon
  end;
end;

// Обновляем список выделеных компов
procedure TformMain.UpdateSelectedCompList;
var
  i,j: integer;
  index: integer;
  bookmark: TBookmarkStr;
begin
   if (not dsConnected) then exit;

   cdsComps.DisableControls;
   bookmark := cdsComps.Bookmark;
   cdsComps.First;
   while (not cdsComps.Eof) do begin
      cdsComps.Edit;
      cdsComps.FieldValues['Selection'] := DS_SELECTION_UNSELECTED;
      cdsComps.Next;
   end;

   cdsComps.Bookmark := bookmark;
   cdsComps.Edit;
   cdsComps.FieldValues['Selection'] := DS_SELECTION_CLICK;

   j:=1; //0 индекс оставим для текущей записи
   for i := 0 to gridComps.SelectedRows.Count-1 do begin
      cdsComps.GotoBookmark(pointer(gridComps.SelectedRows.Items[i]));
      cdsComps.Edit;
      if cdsComps.FieldValues['Selection'] = DS_SELECTION_CLICK then
         begin
           cdsComps.FieldValues['Selection'] := DS_SELECTION_CURSOR;
         end
      else begin
         cdsComps.FieldValues['Selection'] := DS_SELECTION_SELECTED;
         CompsSel[j] := cdsComps.FieldValues['id'];
         Inc(j);
      end;
   end;
   cdsComps.Bookmark := bookmark;
   CompsSel[0] := cdsComps.FieldValues['id'];
   cdsComps.EnableControls;

  // считаем количество выделенных строк
  CompsSelCount := j;

  DoInterfaceComps;
  // отображаем доп.информацию
  if (OperatorProfile.bShowTechCompsInfo) then begin
    memoClientInfo.Clear;
    if (CompsSelCount=1) then begin
      index := ComputersGetIndex(formMain.cdsComps.FieldValues['id']);
      memoClientInfo.Lines.Add('Computer '+Comps[index].GetStrNumber);
      memoClientInfo.Lines.Add('-----------');
      memoClientInfo.Lines.Add('Disk C: '+Comps[index].strInfoFreespaceC);
      memoClientInfo.Lines.Add('Disk D: '+Comps[index].strInfoFreespaceD);
      memoClientInfo.Lines.Add('WinVer: '+Comps[index].strInfoWinver);
      memoClientInfo.Lines.Add('ClientVer: '+Comps[index].strInfoClientver);
    end;
  end;

end;

// call every time when change language
procedure TformMain.RedrawLanguage;
begin
  // call for every components
  MenuRecursive(nil);
  MenuRecursive(PopupMenuShutdown.Items);
  MenuRecursive(PopupMenuReset.Items);
  MenuRecursive(PopupMenuLogoff.Items);
  MenuRecursive(PopupMenuWakeup.Items);
  RedrawListCompsLanguage;
  RedrawListConsoleLanguage;
  tbCompStart.Caption := translate('tbStart');
  tbCompAdd.Caption := translate('tbAdd');
  tbCompStop.Caption := translate('tbStop');
  tbCompMove.Caption := translate('tbMove');
  tbSideline.Caption := translate('Sideline');
  tbCompReset.Caption := translate('mnuRestart');
  tbCompLogoff.Caption := translate('mnuLogoff');
  tbCompShutdown.Caption := translate('mnuShutdown');
  tbCompWakeUp.Caption := translate('mnuWakeUp');
//  tbCurrentReport.Caption := translate('tbCurrent');
  PageControl.Pages[0].Caption := translate('Computers');
  PageControl.Pages[1].Caption := translate('Reports');
end;

// call when change language
procedure  TformMain.RedrawListCompsLanguage;
begin
  formMain.gridComps.Columns[COL_COMPUTER+1].Title.Caption := translate('Computer');
  formMain.gridComps.Columns[COL_STATE+1].Title.Caption := translate('State');
  formMain.gridComps.Columns[COL_TARIF+1].Title.Caption := translate('Tarif');
  formMain.gridComps.Columns[COL_BALANCE+1].Title.Caption := translate('Balance');
  formMain.gridComps.Columns[COL_START+1].Title.Caption := translate('Start');
  formMain.gridComps.Columns[COL_STOP+1].Title.Caption := translate('End');
  formMain.gridComps.Columns[COL_TIME+1].Title.Caption := translate('Time');
  formMain.gridComps.Columns[COL_TIMELEFT+1].Title.Caption := translate('Time left');
  formMain.gridComps.Columns[COL_PRINTED+1].Title.Caption := translate('Printed');
  formMain.gridComps.Columns[COL_TRAFFIC+1].Title.Caption := translate('Traffic');
  formMain.gridComps.Columns[COL_CLIENT+1].Title.Caption := translate('Client');
  formMain.gridComps.Columns[COL_DESCRIPTION+1].Title.Caption := translate('Description');
end;

// call when change language
procedure  TformMain.RedrawListConsoleLanguage;
begin formMain.lvConsole.Column[0].Caption := translate('lvConsoleColumn0');end;

procedure TformMain.timerCompsListTimer(Sender: TObject);
var
  i: integer;
begin
  if not dsConnected then
    exit;
  // исключаем режим мониторинга
  if (Not isManager) then
    dsControlClubTimer        // control all club
  else
    dsLoadUncontrolComputers;

  if not dsConnected then    // Проверяем подключение к базе для
    exit;                    // для стабильности

   // Включаем выключеные компы с оплаченым временем
  if GRegistry.Client.UseWOL then
    for i:=0 to CompsCount-1 do
      if (not Comps[i].control) and Comps[i].Busy then
        WakeUPComputer(Comps[i].macaddr);

  if not dsConnected then    // Проверяем подключение к базе для
    exit;                    // для стабильности

//  ehsPingComputers;        // ping all computers
  ehsEvent5Minutes;          // event "5 minutes left"
  ehsAutoKillTasksAfterStop; // после N секунд, если компьютер не заняли
 {
  if Not isManager then
    PrinterScan;      }

  if not dsConnected then    // Проверяем подключение к базе для
    exit;                    // для стабильности

  if (GSessions <> Nil) then // Обновление информации о сессия
  begin
    GSessions.Check;
//    GSessions.Load;
  end;

  if GRegistry.Options.ReserveAutoActivate then     // Автоактивация брони
    for i:=0 to CompsCount-1 do
      if (Comps[i].session <> nil) then
        if Comps[i].session.Status = ssReserve then
          ReserveActivate(Comps[i].session);

  dmActions.actRedrawComps.Execute;
end;

procedure TformMain.mnuStartClick(Sender: TObject);
begin
  UpdateSelectedCompList;
  DoEvent(FN_COMP_START);
end;

procedure TformMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
{$IFOPT D-}
  if (MessageBox(HWND_TOP,'Are you sure on to exit?',FORM_MAIN_CAPTION,MB_YESNO
    or MB_ICONQUESTION) <> IDYES) then
  begin
    Action := caNone;
    exit;
  end
  else
{$ENDIF}
  begin
    dmActions.actExit.Execute;
  end;
end;

procedure TformMain.tbCompStartClick(Sender: TObject);
begin
  UpdateSelectedCompList;
  DoEvent(FN_COMP_START);
end;

procedure TformMain.tbCompStopClick(Sender: TObject);
begin
  UpdateSelectedCompList;
  DoEvent(FN_COMP_STOP);
end;

procedure TformMain.tbCompMoveClick(Sender: TObject);
begin
  DoEvent(FN_COMP_MOVE);
end;

procedure TformMain.mnuStopClick(Sender: TObject);
begin
  UpdateSelectedCompList;
  DoEvent(FN_COMP_STOP);
end;

procedure TformMain.mnuCloseShiftClick(Sender: TObject);
begin
  DoEvent(FN_CURRENT_REPORT);
end;

procedure TformMain.tbCurrentReportClick(Sender: TObject);
begin
  DoEvent(FN_CURRENT_REPORT);
end;

{// посылаем UDP пакет с данными data на адрес ip
procedure UDPSend(const AstrIP: string; const AstrData: string);
var
  vport: integer;
  strData: String;
begin
  if (isManager) then exit;
  if AstrIP = '' then exit;
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
      udpClient.Send(AstrIP,vport,strData)
  except
  end;
end;}

procedure TformMain.mnuSessionLastClick(Sender: TObject);
begin
  DoEvent(FN_LAST_SESSIONS);
end;

procedure TformMain.mnuRemont1Click(Sender: TObject);
begin
  DoEvent(FN_REMONT_1);
end;

procedure TformMain.mnuRemontLongClick(Sender: TObject);
begin
  DoEvent(FN_REMONT_LONG);
end;

procedure TformMain.mnuAddClick(Sender: TObject);
begin
  UpdateSelectedCompList;
  DoEvent(FN_COMP_ADD);
end;

procedure TformMain.tbCompAddClick(Sender: TObject);
begin
  DoEvent(FN_COMP_ADD);
end;

procedure TformMain.mnuMoveClick(Sender: TObject);
begin
  DoEvent(FN_COMP_MOVE);
end;

procedure TformMain.mnuChangePassClick(Sender: TObject);
begin
  DoEvent(FN_PASS_CHANGE);
end;

procedure TformMain.mnuBossOptionsClick(Sender: TObject);
begin
  DoEvent(FN_BOSS_OPTIONS);
end;

procedure TformMain.mnuClearStatClick(Sender: TObject);
begin
  DoEvent(FN_CLEAR_STATISTICS);
end;

procedure TformMain.mnuSidelineClick(Sender: TObject);
begin
  DoEvent(FN_SIDELINE);
end;

procedure TformMain.tbSidelineClick(Sender: TObject);
begin
  DoEvent(FN_SIDELINE);
end;

procedure TformMain.MinimizeToTray(Sender: TObject);
begin
  if Assigned(GRegistry) then begin
    if Not GRegistry.UserInterface.DontHideIntosysTray then begin
      Shell_notifyIcon(NIM_ADD, @FTrayIcon);
      Visible := false;
      ShowWindow(Application.Handle,SW_HIDE);  // Скрываем программу в таскбаре
    end;
  end;
end;

procedure TformMain.RestoreMainForm;
begin
  Visible := true;
  Application.BringToFront;
  Application.Restore;
  Shell_notifyIcon(NIM_DELETE, @FTrayIcon);
end;


procedure TformMain.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if X = 515 then       // double click left
    RestoreMainForm
  else if X = 517 then  // single click right
    ShowThePopup;
end;

procedure TformMain.ShowThePopup;
var
  CurPos: TPoint;
begin
  GetCursorPos(CurPos);
  PopupMenuTray.Popup(CurPos.x, CurPos.y);
  PostMessage(Self.Handle, WM_NULL, 0, 0);
end;

procedure TformMain.cmnRestoreClick(Sender: TObject);
begin
  RestoreMainForm;
end;

procedure TformMain.FormDestroy(Sender: TObject);
begin
  Shell_notifyIcon(NIM_DELETE, @FTrayIcon);
end;

procedure TformMain.mnuManualPrintClick(Sender: TObject);
begin
   DoEvent(FN_MANUAL_PRINT);
end;

procedure TformMain.mnuShellModeOnClick(Sender: TObject);
var
  index,i: integer;
begin
  for i:=0 to (CompsSelCount-1) do begin
    index := ComputersGetIndex(CompsSel[i]);
    if (GClientOptions.ShellMode = ShellMode_Runpad) then
      UDPSend(Comps[index].ipaddr,STR_CMD_SHELLMODE + '=RunPad1');
    if (GClientOptions.ShellMode = ShellMode_Unknown) then
      UDPSend(Comps[index].ipaddr,STR_CMD_SHELLMODE + '=1');
  end;
end;

procedure TformMain.mnuShellModeOffClick(Sender: TObject);
var
  index,i: integer;
begin
  for i:=0 to (CompsSelCount-1) do begin
    index := ComputersGetIndex(CompsSel[i]);
    if (GClientOptions.ShellMode = ShellMode_Runpad) then
      UDPSend(Comps[index].ipaddr,STR_CMD_SHELLMODE + '=RunPad0');
    if (GClientOptions.ShellMode = ShellMode_Unknown) then
      UDPSend(Comps[index].ipaddr,STR_CMD_SHELLMODE + '=0');
  end;
end;

procedure TformMain.mnuKillTaskClick(Sender: TObject);
var
  index: integer;
begin
  if (isManager) then exit;
  index := ComputersGetIndex(CompsSel[0]);
  // послать команду запроса задач на выбранном компе
  UDPSend(Comps[index].ipaddr,STR_CMD_GETTASKSLIST);
end;

// процедура показывает форму снятия задач для компа Comps[compindex]
// listtasks - список задач, полученных командой STR_CMD_GETTASKSLIST
procedure ShowFormKillTasks(listtasks: string; compindex: integer);
var
  i: integer;
  curTask: AnsiString;
  li: TListItem;
  result: integer;
  frmTaskKill: TfrmTaskKill;
  lstTasks: TStringList;
begin
  lstTasks := TStringList.Create;
  for i := 0 to GetParamCountFromString(listtasks) - 1 do
    lstTasks.Add(GetParamFromString(listtasks, i));
  frmTaskKill := TfrmTaskKill.Create(formMain, lstTasks.Text, False,
      Comps[compindex].GetStrNumber, Comps[compindex].ipaddr);
  FreeAndNil(lstTasks);
  frmTaskKill.ShowModal;
  FreeAndNil(frmTaskKill);
end;

procedure TformMain.mnuRestartClick(Sender: TObject);
var
  index: integer;
  bookmark: TBookmarkStr;
begin
   if (not dsConnected) then exit;
   cdsComps.DisableControls;
   bookmark := cdsComps.Bookmark;
   cdsComps.First;
   while (not cdsComps.Eof) do begin
      if (cdsComps.FieldValues['Selection'] <> DS_SELECTION_UNSELECTED) then
      begin
         index := ComputersGetIndex(cdsComps.FieldValues['id']);
         Comps[index].Reboot; 
      end;
      cdsComps.Next;
   end;
   cdsComps.Bookmark := bookmark;
   cdsComps.EnableControls;
end;


procedure TformMain.mnuShutdownClick(Sender: TObject);
var
  index: integer;
  bookmark: TBookmarkStr;
begin
   if (not dsConnected) then exit;
   cdsComps.DisableControls;
   bookmark := cdsComps.Bookmark;
   cdsComps.First;
   while (not cdsComps.Eof) do begin
      if (cdsComps.FieldValues['Selection'] <> DS_SELECTION_UNSELECTED) then
      begin
         index := ComputersGetIndex(cdsComps.FieldValues['id']);
         Comps[index].PowerOff;
      end;
      cdsComps.Next;
   end;
   cdsComps.Bookmark := bookmark;
   cdsComps.EnableControls;
end;



procedure TformMain.mnuKillTasksTemplateClick(Sender: TObject);
var
  index,i: integer;
begin
  index := ComputersGetIndex(CompsSel[0]);
  for i:=0 to (GRegistry.TaskKill.Template.Count-1) do
    UDPSend(Comps[index].ipaddr,
        STR_CMD_KILLTASK + '='
        + GRegistry.TaskKill.Template.Strings[i]);
end;

procedure TformMain.mnuRemoteManageClick(Sender: TObject);
begin
  DoEvent(FN_REMOTECLIENTS_MANAGE);
end;

procedure TformMain.subMessagesClick(Sender: TObject);
begin
  DoEvent(FN_SENDMESSAGE);
end;

procedure TformMain.tmrIntDateTimer(Sender: TObject);
begin
  if not dsConnected then begin
    dtpIntTime.Enabled := false;
    dtpIntDate.Enabled := false;
    butResetTime.Enabled := false;
    dtpIntTime.Time := EncodeTime(0,0,0,0);
    dtpIntDate.Date := EncodeDate(2003,1,1);
    exit;
  end;

  dtpIntTime.Enabled := isManager;
  dtpIntDate.Enabled := isManager;
  butResetTime.Enabled := isManager;

  dtpIntTime.DateTime := Now - IntTimeShift;
  dtpIntDate.DateTime := Now - IntTimeShift;
end;

procedure TformMain.dtpIntDateChange(Sender: TObject);
var
  nt: TDateTime;
begin
  // Здесь мы забабахаем новое значение нового времени
  nt := EncodeDate(YearOf(dtpIntDate.Date), MonthOf(dtpIntDate.Date), DayOf(dtpIntDate.Date));
  nt := nt + EncodeTime(HourOf(dtpIntTime.Time), MinuteOf(dtpIntTime.Time), SecondOf(dtpIntTime.Time),0);
  // и перейдем на него
  SetVirtualTime(nt);
end;

procedure TformMain.butResetTimeClick(Sender: TObject);
begin
  dsLoadLogonInfo;
  tmrIntDateTimer(Sender);
end;

procedure TformMain.mnuClientInfoClick(Sender: TObject);
begin
  OperatorProfile.bShowTechCompsInfo := not OperatorProfile.bShowTechCompsInfo;
  OperatorProfile.DoInterface;
  OperatorProfile.Save;
end;

function TformMain.EnableSockets: Boolean;
begin
  Result := False;
  try
    udpServer := TIdUdpServer.Create(self);
    udpServer.DefaultPort := READPORT;
    udpServer.OnUDPRead := udpServer_UDPRead;
    udpServer.Active := True;
    udpClient := TIdUdpClient.Create(self);
    udpClient.Port := READPORT;
    udpClient.Active := True;
    Result := True;
  except
  end;
end;

procedure TformMain.DisableSockets;
begin
  FreeAndNil(udpServer);
  FreeAndNil(udpClient);
  //tmrIcmpPing.Enabled := False;
  FreeAndNil(icmpClient);
end;

// принимаем пакет на UDP порт 3773 и делаем что надо
procedure TformMain.udpServer_UDPRead(Sender: TObject; AData: TStream; ABinding: TIdSocketHandle);
var
  DataStringStream: TStringStream;
  strData: string;
  index: integer;
  protocol, cmd, param: string;
  // authorize
  aLogin, aPass, aCode : string;
  nAccountId: integer;
  rettarifs: string;
  i,j: integer;
  qTarif: string;
  qnTarif, qnTarifWhole: integer;
  qSumma: double;
  StartTime, TimeLength, tStart, tStop: TDateTime;
  strStartTime, strStopTime: string;
  session: GCSessions.TGCSession;
  qWhole: integer;
  ii: integer;
  bAlreadyAuth: boolean;
  bNamechecked: boolean;
  bPositiveBalance: boolean;
  strSendData: String;
  strTarifName: String;
  nTarifIndex: Integer;
  nTarifVariantIndex: Integer;
  bIsPacketTarif: Boolean;
  fSumma: double;
  nTraffic: Integer;
  dtTime: TDateTime;
  dtStart, dtStop: TDateTime;
  strParam: String;
  strParam2: String;
  bCalcBySum: Boolean;
  state: TClientState;
  lstStringList: TStringList;
  iUserLevel:Integer;

begin
  DataStringStream := TStringStream.Create('');
  try
  try
    DataStringStream.CopyFrom(AData, AData.Size);
    strData := TrimLeft(TrimRight(DataStringStream.DataString));
    // распаковываем пакет
    UnWrapProtocol(strData, @protocol, @cmd, @param);
     
    if (ABinding.PeerIP = GRegistry.Options.UnixServerIP)
        and (protocol = PROTOCOL_V01) then begin
    //Здесь обработка линксовых пакетов
      if (cmd = STR_CMD_GETTRAFFICVALUEANSWER) then begin
          if (GRegistry.Modules.Internet.OuterPlugin
              or GRegistry.Modules.Internet.LinuxPro) and (FProxy <> Nil) then
            FProxy.MappingAdd(0,param, 0); //функция перегружена - на самом деле это парсинг ответа линукс-сервера
      end;
    end
    else begin
    index := ComputersGetIndexByIp(ABinding.PeerIP);
    // обрабатываем протокол первой версии
    if (protocol = PROTOCOL_V01) and (index <> -1)
        and Comps[index].Licensed then begin
      // -----------------------------
      if (cmd = STR_CMD_RET_PINGANSWER) then begin
        Comps[index].pings := 0; // если пинг вернулся, то сбрасываем в ноль
        // 1) было true - ничего не делаем
        // 2) было false - gccommon::dsControlCompTimer
        if (Comps[index].control = false) then begin
           dsControlCompTimer(Comps[index].id);
           //если была только аутентификация - стоит все запретить
           //если введен тариф - восстановить
           //TODO Восстановление.
           SendAllOptionsToClient(index);
        end;
        // теперь ставим метку true
        Comps[index].control := true;
      end; // STR_CMD_PINGANSWER
      // ------------------------------
      if (cmd = STR_CMD_RET_RESTARTING) then begin
        SendAllOptionsToClient(index);
        if Registration.HardwareControl then
          if ((Not isManager) and GRegistry.Modules.Hardware.Active) then
            UDPSend(Comps[index].ipaddr, STR_CMD_GETHARDWARE);
        if (Not isManager) then UDPSend(Comps[index].ipaddr, STR_CMD_GETEXTENDEDINFO);
      end;
      // ------------------------------
      if ((cmd = STR_CMD_RET_GETHARDWARE)
          and Registration.HardwareControl) then begin
        if (Not isManager) then AnalyzeHardware(param, index);
      end;
      // ------------------------------
      if (cmd = STR_CMD_RET_GETEXTENDEDINFO) then begin
        with Comps[index] do begin
          strInfoWinver := GetParamFromString(param, 0);
          if Pos('Linux', strInfoWinver) > 0 then
            LinuxClient := True;
          strInfoClientver := GetParamFromString(param, 1);
          strInfoFreespaceC := GetParamFromString(param, 2);
          strInfoFreespaceD := GetParamFromString(param, 3);
          ScriptCheckSumm := StrToInt64Def(GetParamFromString(param, 4), 0);
          InstallCheckSumm := StrToInt64Def(GetParamFromString(param, 5), 0);
          if LinuxClient then
            UDPSend(Comps[index].ipaddr,
                STR_CMD_OPTION_SET + '='
                  + 'ServerVersion'
                  + '/' + APP_VERSION);
        end;
      end;
      // ------------------------------
      if (cmd = STR_CMD_RET_INFO) then // вывести в консоль инфу
        Console.AddEvent(EVENT_ICON_COMPUTER,LEVEL_2,Comps[index].GetStrNumber + ' > ' + param);
      // ------------------------------
      if (cmd = STR_CMD_RET_TASKSLIST) then // снять задачи, если выберут че надо
      begin
        ShowFormKillTasks_param := param;
        ShowFormKillTasks_index := index;
        tmrShowFormKillTasks.Enabled := true;
      end;
      // --- authorization
      if (cmd = STR_CMD_AUTH_QUERYSTATE_1) then begin
        QueryAuthGoState1(index);
      end;
      if (cmd = STR_CMD_AUTH_QUERYSTATE_2) then begin
        aLogin := GetParamFromString(param,0);
        aPass :=  GetParamFromString(param,1);
        aCode :=  GetParamFromString(param,2);
        // check
        bAlreadyAuth := false;
        bNamechecked := GAccountSystem.Accounts.CheckLogon(aLogin, aPass, aCode,
            Comps[index].a.secCode-1, nAccountId);
        if bNamechecked then begin
          // защита от повторной авторизации
          // проверяем среди STATE_2 (у компов)
          for ii:=0 to CompsCount-1 do
            if (Comps[ii].a.number = nAccountId) then
              bAlreadyAuth := true;
          // а также среди работающих сессий
          for ii:=0 to CompsCount-1 do
            if (Comps[ii].busy) then
              if (Comps[ii].session.IdClient = nAccountId) then
                bAlreadyAuth := true;
          //проверка балланса
          bPositiveBalance:=GAccountSystem.Accounts[nAccountId].Opened;
        end;


        if (bNamechecked and (Not bAlreadyAuth)) and bPositiveBalance then begin
          Comps[index].a.state := ClientState_Order;
          Comps[index].a.number := nAccountId;
          // послать клиенту GOSTATE_2
          SendAuthGoState2(index);
          Console.AddEvent(EVENT_ICON_INFORMATION, LEVEL_1,
              translate('AuthenticationSucced') + ' / ' + translate('Computer')
              + ' ' + Comps[index].GetStrNumber + ' / ' + translate('labelUser')
              + ' ' + aLogin);
        end
        else begin
          // послать клиенту STR_CMD_AUTH_FAILEDLOGGING_2
           if not bNamechecked then
              if GAccountSystem.Accounts[nAccountId].SecurityBlocked then begin
                 UDPSend(Comps[index].ipaddr,
                    STR_CMD_AUTH_FAILEDLOGGING_2 + '='
                    + translate('AuthenticationFailedIsBlocked'));
                 Console.AddEvent(EVENT_ICON_INFORMATION, LEVEL_1,
                    translate('AuthenticationFailedIsBlocked') + ' / '
                    + translate('Computer') + ' ' + Comps[index].GetStrNumber
                    + ' / ' + translate('labelUser') + ' ' + aLogin);
              end
              else begin
                 UDPSend(Comps[index].ipaddr,
                    STR_CMD_AUTH_FAILEDLOGGING_2 + '='
                    + translate('AuthenticationFailedIncorrectNameOrPassword'));
                 Console.AddEvent(EVENT_ICON_INFORMATION, LEVEL_1,
                    translate('AuthenticationFailedIncorrectNameOrPassword')
                    + ' / ' + translate('Computer') + ' '
                    + Comps[index].GetStrNumber + ' / '
                    + translate('labelUser') + ' ' +aLogin);
              end
           else
              if (bAlreadyAuth) then begin
                UDPSend(Comps[index].ipaddr,
                    STR_CMD_AUTH_FAILEDLOGGING_2 + '='
                    + translate('AuthenticationFailedAlreadyLogged'));
                Console.AddEvent(EVENT_ICON_INFORMATION, LEVEL_1,
                    translate('AuthenticationFailedAlreadyLogged') + ' / '
                    + translate('Computer') + ' ' + Comps[index].GetStrNumber
                    + ' / ' + translate('labelUser') + ' ' + aLogin);
              end
              else begin
                UDPSend(Comps[index].ipaddr,
                    STR_CMD_AUTH_FAILEDLOGGING_2 + '='
                    + translate('AuthenticationFailedNegativeBalance'));
                Console.AddEvent(EVENT_ICON_INFORMATION, LEVEL_1,
                    translate('AuthenticationFailedNegativeBalance') + ' / '
                    + translate('Computer') + ' ' + Comps[index].GetStrNumber
                    + ' / ' + translate('labelUser') + ' ' + aLogin);
              end;
           Comps[index].a.nFailedAuthentication :=
              Comps[index].a.nFailedAuthentication + 1;
            if (GRegistry.AccountSystem.BlockIfLogonFailed3Times) and
                (Comps[index].a.nFailedAuthentication
                >= MAXIMUM_FAILED_AUTHENTICATIONS) then begin
                // тут неплохо какое-нибудь предупреждающее окно вывести
              Comps[index].a.state := ClientState_Blocked;
              UDPSend(Comps[index].ipaddr,
                  STR_CMD_AUTH_GOSTATE_0 + '='
                  + BoolToStr(True));
              Console.AddEvent(EVENT_ICON_INFORMATION, LEVEL_0,
                  translate('AuthenticationFailedMaximum') + ' / '
                  + translate('Computer') + ' ' + Comps[index].GetStrNumber
                  + ' / ' + translate('labelUser') + ' ' + aLogin);
            end;

        end;
      end;
{      if (cmd = STR_CMD_AUTH_QUERYTARIFS_2) then begin
        rettarifs := '';
        for i:=1 to (TarifsCount-1) do
          if (Tarifs[i].idGroup = Comps[index].IdGroup) then begin
            rettarifs := rettarifs + Tarifs[i].name + '/';
            for j:=0 to Tarifs[i].variantscount-1 do
              if (Tarifs[i].tarifvariants[j].IsAvailable(GetVirtualTime)) then
                rettarifs := rettarifs + Tarifs[i].name + '-' + Tarifs[i].tarifvariants[j].name + '/';
          end;
        rettarifs := MidStr(rettarifs,1,strlen(PChar(rettarifs))-1);
        UDPSend(Comps[index].ipaddr, STR_CMD_AUTH_RETTARIFS_2+ '='+rettarifs);
      end; // STR_CMD_AUTH_QUERYTARIFS_2 }

      if (cmd = STR_CMD_AUTH_QUERYTARIFS_2) then begin
        rettarifs := '';
        if Comps[index].a.state <> ClientState_Authentication then
        if GAccountSystem.Accounts[Comps[index].a.number].IsTarifsLimit then
          begin
            iUserLevel:=GAccountSystem.Accounts[Comps[index].a.number].UserLevel;
            for i:=1 to (TarifsCount-1) do
              if (Tarifs[i].idGroup = Comps[index].IdGroup) and
              (Tarifs[i].userlevel <= iUserLevel) then begin
                rettarifs := rettarifs + Tarifs[i].name + '/';
                for j:=0 to Tarifs[i].variantscount-1 do
                  if (Tarifs[i].tarifvariants[j].IsAvailable(GetVirtualTime)) then
                    rettarifs := rettarifs + Tarifs[i].name + '-' + Tarifs[i].tarifvariants[j].name + '/';
              end;
          end
          else
          for i:=1 to (TarifsCount-1) do
            if (Tarifs[i].idGroup = Comps[index].IdGroup) then begin
              rettarifs := rettarifs + Tarifs[i].name + '/';
              for j:=0 to Tarifs[i].variantscount-1 do
                if (Tarifs[i].tarifvariants[j].IsAvailable(GetVirtualTime)) then
                  rettarifs := rettarifs + Tarifs[i].name + '-' + Tarifs[i].tarifvariants[j].name + '/';
            end;
        rettarifs := MidStr(rettarifs,1,strlen(PChar(rettarifs))-1);
        UDPSend(Comps[index].ipaddr, STR_CMD_AUTH_RETTARIFS_2+ '='+rettarifs);
      end; // STR_CMD_AUTH_QUERYTARIFS_2

      if (cmd = STR_CMD_AUTH_QUERYCOSTTIME_2) then begin
        strTarifName := GetParamFromString(param,0);
        strParam := GetParamFromString(param,1);
        strParam2 := GetParamFromString(param,2);
        if (Length(strParam) > 0) then begin
          fSumma := StrToFloat(strParam);
          bCalcBySum := True;
        end else if (Length(strParam2)>0) then begin
          dtTime := StrToDateTime(strParam2);
          bCalcBySum := False;
        end else begin
          fSumma := 0;
          bCalcBySum := True;
        end;
        dtStart := GetVirtualTime;
        if CalculateTarif(strTarifName, dtStart, dtTime, fSumma, bCalcBySum,
            index, GAccountSystem.Accounts[Comps[index].a.number].Discount) then begin
          GetTarifByName(strTarifName, nTarifIndex, nTarifVariantIndex,
              bIsPacketTarif);
          dtStop := dtStart + dtTime;
          UDPSend(Comps[index].ipaddr,
              STR_CMD_AUTH_RETCOSTTIME_2 + '='
              + FloatToStr(fSumma) + '/' +  DateTimeToStr(dtStart) + '/'
              + DateTimeToStr(dtStop) + '/' + BoolToStr(bIsPacketTarif));
        end else
          // сбой в определении тарифа (или тариф успел кончиться)
          SendAuthGoState2(index);
      end; // STR_CMD_AUTH_QUERYCOSTTIME_2

      if (cmd = STR_CMD_AUTH_QUERYCOSTTRAFFIC_3)
          then begin
        strParam := GetParamFromString(param,0);
        strParam2 := GetParamFromString(param,1);
        if (Length(strParam) > 0) then begin
          fSumma := StrToFloat(strParam);
          nTraffic := 0;
          bCalcBySum := True;
        end else if (Length(strParam2)>0) then begin
          fSumma := 0;
          nTraffic := StrToInt(strParam2);
          bCalcBySum := False;
        end else begin
          fSumma := 0;
          nTraffic := 0;
          bCalcBySum := True;
        end;
        session := Comps[index].session;
        if session <> Nil then begin
          with session do
            try
            if bCalcBySum then
              nTraffic := Round(fSumma / KBTrafficCost)
            else
              fSumma := RoundTo(nTraffic * KBTrafficCost, -2);
            except
              on e: Exception do begin
                Debug.Trace0('TformMain.udpServer_UDPRead! ' + e.Message);
              end;
            end;
          UDPSend(Comps[index].ipaddr,
              STR_CMD_AUTH_RETCOSTTRAFFIC_3 + '='
              + FloatToStr(fSumma) + '/' +  IntToStr(nTraffic));
          end;
      end; // STR_CMD_AUTH_QUERYCOSTTRAFFIC_3

      if (cmd = STR_CMD_AUTH_QUERYCOSTTIME_3) then begin
        strParam := GetParamFromString(param,0);
        strParam2 := GetParamFromString(param,1);
        if (Length(strParam) > 0) then begin
          fSumma := StrToFloat(strParam);
          dtTime := 0;
          bCalcBySum := True;
        end else if (Length(strParam2)>0) then begin
          fSumma := 0;
          dtTime := StrToDateTimeDef(strParam2, 0);
          bCalcBySum := False;
        end else begin
          fSumma := 0;
          dtTime := 0;
          bCalcBySum := True;
        end;
        session := Comps[index].session;
        if session <> Nil then begin
          with session do
            try
              if bCalcBySum then
                dtTime := Tariff.CalculateTimeLength(session.TimeStop, fSumma,
                    session.ComputerGroupId, 0)
              else begin
                dtTime := IncHour(IncMinute(0, MinuteOf(dtTime)),
                    HourOf(dtTime)) + session.TimeStop;
                fSumma := session.Tariff.CalculateCost(
                  session.TimeStop, dtTime, session.ComputerGroupId, 0, True);
              end;
            except
              on e: Exception do begin
                Debug.Trace0('TformMain.udpServer_UDPRead! ' + e.Message);
              end;
            end;
          UDPSend(Comps[index].ipaddr,STR_CMD_AUTH_RETCOSTTIME_3 + '='
              + FloatToStr(fSumma) + '/' +  DateTimeToStr(dtTime));
          end;
      end; // STR_CMD_AUTH_QUERYCOSTTIME_3

      if (cmd = STR_CMD_AUTH_QUERYSTATE_3)
          and (Comps[index].a.state <> ClientState_Agreement)
          and (Comps[index].a.state <> ClientState_Session)
          // блокировка одновременного запуска с оператором
          and (Comps[index].a.state <> ClientState_OperatorAgreement)
          and (Comps[index].a.state <> ClientState_OperatorSession
          ) then begin
        // сперва вынимаем что за тариф и сколько платит
        strTarifName := GetParamFromString(param,0);
        fSumma := StrToFloatGC(GetParamFromString(param,1));
        dtStart := GetVirtualTime;
        if(GAccountSystem.Accounts[Comps[index].a.number].Discount=100) then
          qSumma := 0;
        if CalculateTarif(strTarifName, dtStart, dtTime, fSumma, True,
            index, GAccountSystem.Accounts[Comps[index].a.number].Discount) then begin
          GetTarifByName(strTarifName, nTarifIndex, nTarifVariantIndex,
              bIsPacketTarif);
          if bIsPacketTarif then
            qWhole := Tarifs[nTarifIndex].tarifvariants[nTarifVariantIndex].id
          else
            qWhole := 0;
          dtStop := dtStart + dtTime;
          if GClientOptions.Agreement then
            state := ClientState_Agreement
          else
            state := ClientState_Session;
          session := GSessions.Add(0, 0, Comps[index].id, Comps[index].a.number,
              dtStart, dtStart, dtStart+dtTime,
              Tarifs[nTarifIndex].id, qWhole, False, 0, '',
              fSumma, fSumma, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, state, ssActive);
          Console.AddEvent(EVENT_ICON_INFORMATION, LEVEL_1,
              translate('ActionStart') + ' ' + session.ConsoleInfo);
          RunSessionScript(saStart, session);
          if GClientOptions.Agreement then
            Comps[index].a.state := ClientState_Agreement
          else
            Comps[index].a.state := ClientState_Session;
          Console.AddEvent(EVENT_ICON_INFORMATION, LEVEL_1, TimeToStr(session.TimeStop ));
          session.Save;
          Console.AddEvent(EVENT_ICON_INFORMATION, LEVEL_1, TimeToStr(session.TimeStop ));
          UDPSend(Comps[index].ipaddr, STR_CMD_AUTH_GOSTATE_3
                  + '=' + Comps[index].session.GetStrTarif + '/'
                  + DateTimeToStr(Comps[index].session.TimeStart) + '/'
                  + DateTimeToStr(Comps[index].session.TimeStop) + '/'
                  + Comps[index].session.GetStrClientBalance+ '/'
                  + BoolToStr(Comps[index].session.IsTrafficSeparatePayment)
                  + '/' + BoolToStr(True));
          dmActions.actLoadSessions.Execute;
          dmActions.actRedrawComps.Execute;
          DoInterfaceComps;
          PingComputer(index);
//          asys.accounts[asys.GetIndexByNumber(Comps[index].a.number)].Load;
          SendAllOptionsToClient(index);
        end;
      end; // STR_CMD_AUTH_QUERYSTATE_3

      //остановка сесии или логофф при неостановленной сессии
      if ((cmd = STR_CMD_AUTH_QUERYSTOP_3) or
         ((cmd = STR_CMD_AUTH_QUERYLOGOFF)
            and(Comps[index].a.state = ClientState_Session))) and
         (Comps[index].session <> nil) then begin
         UDPSend(Comps[index].ipaddr, STR_CMD_AUTH_STOPSTATE_3);
         // перейти в состояние 2
         Comps[index].a.state := ClientState_Order;
         Comps[index].a.number := Comps[index].session.IdClient;
         // послать клиенту GOSTATE_2 , только если это останов
         if (cmd = STR_CMD_AUTH_QUERYSTOP_3) then begin
            SendAuthGoState2(index);
         end;
         // traffic
         if ((Not isManager)
            and (tarifs[TarifsGetIndex(Comps[index].session.IdTarif)].internet
            = 1) and GRegistry.Modules.Internet.SummaryControl) then begin
           FProxy.IPDisable(Comps[index].ipaddr);
           FProxy.IPTrafficReset(Comps[index].ipaddr);
         end;
         Comps[index].session.Stop(False);
         dmActions.actLoadSessions.Execute;
         DoInterfaceComps;
         dmActions.actRedrawComps.Execute;
         PingComputer(index);
//         asys.accounts[asys.GetIndexByNumber(Comps[index].a.number)].Load;
         UDPSend(Comps[index].ipaddr,
             STR_CMD_CLIENT_INFO_SET + '='
             + 'Balance' + '/'
             + FloatToStr(GetAccountBalance(Comps[index].a)));
       end; //STR_CMD_AUTH_QUERYSTOP_3

      if (cmd = STR_CMD_AUTH_QUERYLOGOFF) then begin
        Console.AddEvent(EVENT_ICON_INFORMATION, LEVEL_1,
            translate('AuthenticationLogoff') + ' / ' + translate('Computer')
            + ' ' + Comps[index].GetStrNumber + ' / ' + translate('labelUser')
            + ' ' + GetAccountName(Comps[index].a));
        Comps[index].a.number := 0;
        QueryAuthGoState1(index);
      end; //STR_CMD_AUTH_QUERYLOGOFF

      if (cmd = STR_CMD_AUTH_QUERYCHANGEPASS) then begin
        aLogin := GetParamFromString(param,0); //OldPass
        aPass :=  GetParamFromString(param,1); //NewPass
        nAccountId := Comps[index].a.number;
        if (GAccountSystem.Accounts[nAccountId].Password = aLogin) then begin
          GAccountSystem.Accounts[nAccountId].Password := aPass;
//          asys.accounts[clientLogged].Save;
          UDPSend(Comps[index].ipaddr, STR_CMD_AUTH_PASSCHANGED + '=Password is changed ...');
          Console.AddEvent(EVENT_ICON_INFORMATION, LEVEL_1, translate('PasswordIsChanged') + ' / ' + translate('Computer') + ' ' + Comps[index].GetStrNumber + ' / ' + translate('labelUser') + ' ' +aLogin);
        end
        else begin
          UDPSend(Comps[index].ipaddr, STR_CMD_AUTH_PASSCHANGED + '=Wrong old password ...');
          Console.AddEvent(EVENT_ICON_INFORMATION, LEVEL_1, translate('WrongOldPassword') + ' / ' + translate('Computer') + ' ' + Comps[index].GetStrNumber + ' / ' + translate('labelUser') + ' ' +aLogin);
        end;
      end;

      if (cmd = STR_CMD_AUTH_ADDTRAFFIC_3) then begin
        qSumma := StrToFloatGC(GetParamFromString(param,0));
        Comps[index].session.UpdateOnDB(0, qSumma, 0, 0, 0, 0, 0, 0);
        Console.AddEvent(EVENT_ICON_INFORMATION, LEVEL_1,
          translate('AddTraffic') + ' ' + Comps[index].GetStrNumber
          + ' >> ' + DateTimeToSql(GetVirtualTime) + ' / '
          + FormatFloat('0.00',qSumma) + ' ' + GRegistry.Options.Currency);
        //asys.accounts[asys.GetIndexByNumber(Comps[index].a.number)].Load;
        UDPSend(Comps[index].ipaddr,
            STR_CMD_CLIENT_INFO_SET + '='
            + 'Balance' + '/' + FloatToStr(GetAccountBalance(Comps[index].a)));

      end; //STR_CMD_AUTH_ADDTRAFFIC

      if (cmd = STR_CMD_AUTH_ADDTIME_3) then begin
        qSumma := StrToFloatGC(GetParamFromString(param,0));
        Comps[index].session.UpdateOnDB(qSumma, 0, 0, 0, 0, 0, 0, 0);
        Console.AddEvent(EVENT_ICON_INFORMATION, LEVEL_1, translate('AddComp')
            + ' ' + Comps[index].GetStrNumber + ' >> '
            + DateTimeToSql(GetVirtualTime) + ' / '
            + FormatFloat('0.00',qSumma) + ' ' + GRegistry.Options.Currency);
        //asys.accounts[asys.GetIndexByNumber(Comps[index].a.number)].Load;
        UDPSend(Comps[index].ipaddr,
            STR_CMD_CLIENT_INFO_SET + '='
            + 'Balance' + '/' + FloatToStr(GetAccountBalance(Comps[index].a)));

      end; //STR_CMD_AUTH_ADDTRAFFIC

      if (cmd = STR_CMD_SENDMESSAGE) then begin
        strSendData := GetAccountName(Comps[index].a) + '('
            + IntToStr(Comps[index].number)
            + '): ' + GetParamFromString(param,2);
        frameMessages.memMessages.Lines.Add(strSendData);
        if GRegistry.UserInterface.ActivateMessageTab then
          tabMessages.Show;
      end; //STR_CMD_SENDMESSAGE

      if (cmd = STR_CMD_CLIENT_INFO_SET) then begin
        strParam := GetParamFromString(param,0); //Option
        strParam2 :=  GetParamFromString(param,1); //Value
        if CompareText(strParam, 'ClientState') = 0 then begin
          case TClientState(StrToInt(strParam2)) of
            ClientState_OperatorAgreementAccepted: begin
              if (Comps[index].session.State
                  = ClientState_OperatorAgreement) then begin
                Comps[index].session.State := ClientState_OperatorSession;
                Comps[index].session.UpdateOnDB(0, 0, 0, 0, 0, 0, 0, 0);
              end;
            end;
            ClientState_AgreementAccepted: begin
              if (Comps[index].session.State
                  = ClientState_Agreement) then begin
                Comps[index].session.State := ClientState_Session;
                Comps[index].session.UpdateOnDB(0, 0, 0, 0, 0, 0, 0, 0);
              end;
            end;
          end;
          UDPSend(Comps[index].ipaddr,
              STR_CMD_CLIENT_INFO_SET + '='
              + 'ClientState' + '/' + IntToStr(GetClientState(index)));
        end;

      end; //IDX_CMD_CLIENT_INFO_SET

      //Отключили слежение за процессами, высокая нагрузка на базу

      if (cmd = STR_CMD_RET_PROCESSLIST) and
         GRegistry.Options.WriteProcessList then begin
        //bCalcBySum := StrToBool(GetParamFromString(param,0));
        // Bool говорит что забили на старые процессы, пока не нужен
        lstStringList := TStringList.Create;
        //запущенные процессы
        lstStringList.Text := GetParamFromString(param,1);
        for i:=0 to lstStringList.Count-1 do
          dsProcessAdd(True, Comps[index].id, lstStringList.Strings[i]);
        //завершенные процессы
        lstStringList.Text := GetParamFromString(param,2);
        for i:=0 to lstStringList.Count-1 do
          dsProcessAdd(False, Comps[index].id, lstStringList.Strings[i]);
        lstStringList.Free;
      end; //STR_CMD_SENDMESSAGE

      if (cmd = STR_CMD_GUESTSESSION) and GRegistry.Client.GuestSession
          and (Comps[index].a.state = ClientState_Authentication) then begin
        Comps[index].a.state := ClientState_Blocked;
        //защита от двойного нажатия кнопки
        strTarifName := GRegistry.Client.GuestSessionTarifName;
        fSumma := GRegistry.Options.MaximumTrustPostPay;
        dtStart := GetVirtualTime;
        if CalculateTarif(strTarifName, dtStart, dtTime, fSumma, True,
            index, 0)
            and GetTarifByName(strTarifName, nTarifIndex, nTarifVariantIndex,
              bIsPacketTarif) and not bIsPacketTarif then begin
          qWhole := 0;
          dtStop := dtStart + dtTime;
          if GClientOptions.Agreement then
            state := ClientState_OperatorAgreement
          else
            state := ClientState_OperatorSession;
          session := GSessions.Add(0, 0, Comps[index].id, Comps[index].a.number,
              dtStart, dtStart, dtStart+dtTime,
              Tarifs[nTarifIndex].id, qWhole, True, 0, '',
              fSumma, fSumma, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, state, ssActive);
          Console.AddEvent(EVENT_ICON_INFORMATION, LEVEL_1,
              translate('ActionStart') + ' ' + session.ConsoleInfo);
          if GRegistry.UserInterface.SoundGuestSession then
            DoSound([NotifyGuestSession]);
          RunSessionScript(saStart, session);
          if GClientOptions.Agreement then
            Comps[index].a.state := ClientState_OperatorAgreement
          else
            Comps[index].a.state := ClientState_OperatorSession;
          session.Save;
          dmActions.actLoadSessions.Execute;
          dmActions.actRedrawComps.Execute;
          DoInterfaceComps;
          PingComputer(index);
          SendAllOptionsToClient(index);
        end else
          Comps[index].a.state := ClientState_Authentication;
      end; // STR_CMD_GUESTSESSION

    end;
    end;
  finally
    DataStringStream.Free;
  end; // try-finally
  except
  end;
end;

procedure TformMain.tmrShowFormKillTasksTimer(Sender: TObject);
begin
  tmrShowFormKillTasks.Enabled := false;
  ShowFormKillTasks(ShowFormKillTasks_param, ShowFormKillTasks_index);
end;

procedure TformMain.mnuAccountsClick(Sender: TObject);
begin
  Application.CreateForm(TfrmAccounts, frmAccounts);
  frmAccounts.ShowModal;
  frmAccounts.Destroy;
end;

procedure TformMain.mnuAccounts2Click(Sender: TObject);
begin
  Application.CreateForm(TfrmAccounts, frmAccounts);
  frmAccounts.ShowModal;
  frmAccounts.Destroy;
end;

procedure TformMain.mnuAllowAuthorizationClick(Sender: TObject);
var
  i, index: integer;
begin
  for i:=0 to CompsSelCount-1 do
  begin
     index := ComputersGetIndex(CompsSel[i]);
     if ((Comps[index].a.state = ClientState_Blocked)
        and (Not Comps[index].busy)) then
     begin
       Comps[index].a.state := ClientState_Authentication;
       Comps[index].a.nFailedAuthentication := 0;
       SendAuthGoState1(index,True);
     end;
     WakeUPComputer(Comps[index].macaddr)
  end;
end;

procedure QueryAuthGoState1(AnCompIndex:Integer);
begin
  Comps[AnCompIndex].a.number := 0;
  if GAccountSystem.Enabled
      and GAccountSystem.AlwaysAllowAuthentication
      and not Comps[AnCompIndex].Reserved then begin
    Comps[AnCompIndex].a.state := ClientState_Authentication;
    SendAuthGoState1(AnCompIndex,True);
  end else begin
    Comps[AnCompIndex].a.state := ClientState_Blocked;
    UDPSend(Comps[AnCompIndex].ipaddr, STR_CMD_AUTH_GOSTATE_0+'='+BoolToStr(True));
  end;
end;




procedure SendAuthGoState1(nCompIndex:Integer; bNewSecCode:Boolean);
begin
//Нестабильность получается, клиент не успевает ввести доп.код, а тот уже изменился :))
   if bNewSecCode then begin
      Randomize;
      if (GAccountSystem.UseSecurityCodes) then
         Comps[nCompIndex].a.secCode := random(20)+1
      else
         Comps[nCompIndex].a.secCode := 0;
   end;
   UDPSend(Comps[nCompIndex].ipaddr,STR_CMD_AUTH_GOSTATE_1+'='+IntToStr(Comps[nCompIndex].a.secCode));
{   if (Comps[nCompIndex].a.number <> 0) then
     asys.accounts[asys.GetIndexByNumber(Comps[nCompIndex].a.number)].Load;
     }
end;

procedure SendAuthGoState2(CompIndex:Integer);
begin
   // загрузить данные клиента
   if (Comps[CompIndex].a.number = 0) then exit;
//   asys.accounts[asys.GetIndexByNumber(Comps[CompIndex].a.number)].Load;
   Comps[CompIndex].a.state := ClientState_Order;
   Comps[CompIndex].a.LogonOrStopMoment := GetVirtualTime;
   with GAccountSystem.Accounts[Comps[CompIndex].a.number] do begin
   UDPSend(Comps[CompIndex].ipaddr, STR_CMD_AUTH_GOSTATE_2+'='
      + Name + '/'
      + FloatToStr(Balance) + '/'
      + FloatToStr(LimitBalance));
   UDPSend(Comps[CompIndex].ipaddr,
      STR_CMD_AUTH_SENDBALANCEHISTORY+ '='
      + History);
   end;
end;



procedure TformMain.gridCompsSortMarkingChanged(Sender: TObject);
begin
   formMain.cdsComps.DisableControls;
   SortDataSet(True);
   ResetDataSetBookmark;
   formMain.cdsComps.EnableControls;
end;

procedure ResetDataSetBookmark;
begin
   formMain.gridComps.SelectedRows.Clear;
   formMain.cdsComps.First;
   while (not formMain.cdsComps.Eof) do begin
      if formMain.cdsComps.FieldValues['Selection'] <> DS_SELECTION_UNSELECTED then
         formMain.gridComps.SelectedRows.CurrentRowSelected := True;
      formMain.cdsComps.Next;
   end;
   formMain.cdsComps.Locate('Selection',DS_SELECTION_CURSOR,[]);
end;

procedure SortDataSet(bMakeSorting: boolean);
var
   i :Integer;
   strSort :String;
begin
   strSort := '';
   if (bMakeSorting) then begin
      for i := 0 to formMain.gridComps.SortMarkedColumns.Count-1 do
         strSort := strSort + formMain.gridComps.SortMarkedColumns[i].FieldName +
            IfThen(formMain.gridComps.SortMarkedColumns[i].Title.SortMarker = smUpEh,
                ' DESC , ',
                ' ASC , ');
      formMain.cdsComps.Sort := Copy(strSort,1,Length(strSort)-2);
   end
   else
      formMain.cdsComps.Sort := '';
end;

procedure TformMain.tmrFileSynchronizationTimer(Sender: TObject);
begin
  if (isManager) then exit;
  if CompsCount > 0 then begin
    if GnFileSynchronizationCounter >= CompsCount then
      GnFileSynchronizationCounter := 0;
    SyncFile(GnFileSynchronizationCounter);
    Inc(GnFileSynchronizationCounter);
  end;


{  GCInstallCl := TGCInstall.Create;
  if isManager then
    exit;
  if ( not GClientOptions.bRemoteInstallClient) then
    exit;

  if not GCInstallCl.IsTrueVersion(FULL_APP_VERSION) then exit;

  try
  NameComps := TStringList.Create;

  for i := 0 to CompsCount-1 do
  begin
    if Comps[i].pingable and ((Comps[i].strInfoClientver <> FULL_APP_VERSION) or Not Comps[i].control) then begin
      UDPSend(Comps[i].ipaddr, STR_CMD_CLOSECLIENT]);
      NameComps.Add(Comps[i].ipaddr);
    end;
  end;
  GCInstallCl.LoadAutoLogin();
  GCInstallCl.Install(NameComps, self.Handle);

  finally  NameComps.Free;
  end;
  GCInstallCl.Free;
}
end;

procedure TformMain.gridCompsCellClick(Column: TColumnEh);
begin
  UpdateSelectedCompList;
end;

procedure TformMain.gridCompsDblClick(Sender: TObject);
begin
  if mnuAdd.Enabled then
    DoEvent(FN_COMP_ADD)
  else
    DoEvent(FN_COMP_START);
end;

procedure TformMain.gridCompsContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
begin
   if cdsComps.FieldValues['Selection'] = DS_SELECTION_UNSELECTED then
    gridComps.SelectedRows.Clear;
   formMain.gridCompsCellClick(Nil);
end;


procedure TformMain.mnuVolumesClick(Sender: TObject);
var
  nSavedCompsSelCount: Integer;
begin
  nSavedCompsSelCount := CompsSelCount; //изврат для различия вызова для оного компа и для всех
  CompsSelCount := 0;
  DoEvent(FN_VOLUME);
  CompsSelCount := nSavedCompsSelCount;
end;

procedure TformMain.mnuCompVolumeClick(Sender: TObject);
begin
  DoEvent(FN_VOLUME);
end;

procedure TformMain.mnuColorClick(Sender: TObject);
begin
  DoEvent(FN_COLOR);
end;

procedure TformMain.mnuPenalty1Click(Sender: TObject);
begin
  GnMinPenalty := 1;

  DoEvent(FN_PENALTY);
end;

procedure TformMain.mnuPenalty10Click(Sender: TObject);
begin
  GnMinPenalty := 10;
  DoEvent(FN_PENALTY);
end;

procedure TformMain.mnuPenalty15Click(Sender: TObject);
begin
  GnMinPenalty := 15;
  DoEvent(FN_PENALTY);
end;

procedure TformMain.mnuPenalty2Click(Sender: TObject);
begin
  GnMinPenalty := 2;
  DoEvent(FN_PENALTY);
end;

procedure TformMain.mnuPenalty5Click(Sender: TObject);
begin
  GnMinPenalty := 5;
  DoEvent(FN_PENALTY);
end;

procedure TformMain.mnuRestrictionsClick(Sender: TObject);
begin
  formGCMessageBox.memoInfo.Text := translate('Restrictions');
  formGCMessageBox.SetDontShowAgain(false);
  formGCMessageBox.ShowModalCustom(translate('mnuRestrictions'),185,440);
end;

procedure TformMain.mnuChangeTarifClick(Sender: TObject);
begin
  DoEvent(FN_CHANGE_TARIF);
end;

procedure TformMain.icmpClient_OnReply(ASender: TComponent; const AReplyStatus: TReplyStatus);
var
  i: Integer;
begin
  for i:=0 to CompsCount-1 do
    if Comps[i].ipaddr = AReplyStatus.FromIpAddress then
      if AReplyStatus.ReplyStatusType = rsEcho then begin
        Comps[i].IcmpPings := 0; // если пинг вернулся, то сбрасываем в ноль
        Comps[i].Pingable := True;
      end;
end;

procedure TformMain.mnuInstallClick(Sender: TObject);
begin
    DoEvent(FN_MANUAL_REMOTE_INSTALL);
end;

procedure TformMain.gridCompsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  nKey, nRowBlock : Integer;
begin
  if (Shift=[ssAlt]) and (Key>=Ord('1')) and (Key<=Ord('9')) then begin
    nKey := Key-Ord('0'); //число от 0 до 8
    nRowBlock := gridComps.VisibleRowCount; //количество компов на экране
    if (CompsCount div nRowBlock) > 9 then
      nRowBlock := CompsCount div 9; //если компов больше 9-ти экранов распределяем равномерно
     gridComps.DataSource.DataSet.DisableControls;
     gridComps.DataSource.DataSet.First;
     gridComps.DataSource.DataSet.MoveBy(nRowBlock*nKey -1);
     gridComps.DataSource.DataSet.MoveBy(-nRowBlock div 2);
     gridComps.DataSource.DataSet.EnableControls;
  end else if (Key>=Ord('0')) and (Key<=Ord('9')) then begin
    if SecondsBetween(Now, FdtHotNumberEntered) < 2 then
      FstrHotNumber := FstrHotNumber + Char(Key)
    else
      FstrHotNumber := Char(Key);
    FdtHotNumberEntered := Now;
    nKey := StrToIntDef(FstrHotNumber, 0);
    if nKey > 0 then
      gridComps.DataSource.DataSet.Locate('Computer', FstrHotNumber,
          [loCaseInsensitive	]);
  end;

  if (Key=VK_RETURN) or (Key=VK_ADD) then
    if mnuAdd.Enabled then
      begin
        UpdateSelectedCompList;
        DoEvent(FN_COMP_ADD);
      end
    else
      begin
        UpdateSelectedCompList;
        DoEvent(FN_COMP_START);
      end;

   if (Key=VK_SUBTRACT) then
    begin
      UpdateSelectedCompList;
      DoEvent(FN_COMP_STOP);
    end


{  if (Shift=[ssCtrl]) and (Key=Ord('U')) then
    mnuInstallClick(Sender);}
end;

procedure TformMain.tmrCyclicCompActionTimer(Sender: TObject);
begin
  if (isManager) then exit;
  if CompsCount > 0 then begin
    if GnCyclicCompActionCounter >= CompsCount then begin
      GnCyclicCompActionCounter := 0;
      if GRegistry.Options.OperatorTrafficControl
          and GRegistry.Modules.Internet.SummaryAccounting then begin
        GRegistry.Options.OperatorTrafficInbound :=
            GRegistry.Options.OperatorTrafficInbound
            + FProxy.IPTrafficGetIn(GRegistry.Options.OperatorIP);
        GRegistry.Options.OperatorTrafficOutbound :=
            GRegistry.Options.OperatorTrafficOutbound
            + FProxy.IPTrafficGetOut(GRegistry.Options.OperatorIP);
      end;
    end;
    PingComputer(GnCyclicCompActionCounter);
    Inc(GnCyclicCompActionCounter);
  end;
end;

procedure TformMain.gridCompsMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  gridCompsCellClick(Nil);

end;

procedure TformMain.timerGSessionsLoadTimer(Sender: TObject);
begin
  if (GSessions <> Nil) and dsConnected then
    GSessions.Load;
end;

procedure TformMain.mnuActivateReserveClick(Sender: TObject);
begin
  DoEvent(FN_RESERVE_ACTIVATE);
end;

procedure TformMain.mnuCancelReserveClick(Sender: TObject);
begin
  DoEvent(FN_RESERVE_CANCEL);
end;

procedure TformMain.mnuTrafiicAddClick(Sender: TObject);
begin
  DoEvent(FN_SESSION_TRAFFIC_PAYMENT);
end;

procedure TformMain.mnuRunPadShellClick(Sender: TObject);
begin
  ShellExecute(0, 'open', pChar('http://nodasoft.com/products/gc/shell/'),
      NIL, NIL, SW_SHOWNORMAL);
end;

procedure TformMain.frameMessagesbtnSendClick(Sender: TObject);
begin
  frameMessages.btnSendClick(Sender);
  frameMessages.edtMessage.Text := '';
end;

procedure TformMain.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var i:integer;
begin
  Application.MessageBox('SDF','SDF');
  i := 0;

end;

procedure TformMain.PageControlChange(Sender: TObject);
var
  lstResult: TStringList;
begin
  lstResult := TStringList.Create;
  if IsManager and (PageControl.ActivePage = tabReports)
      and (Random(3) = 0) then begin
    GRegistry.Info.MainSize := GetSize;
    if not CheckSecurity(lstResult) then begin
      formGCMessageBox.memoInfo.Lines := lstResult;
      formGCMessageBox.SetDontShowAgain(false);
      formGCMessageBox.ShowModal;
    end;
  end;
  lstResult.Free;
end;



procedure TformMain.tbCompResetClick(Sender: TObject);
begin
  mnuRestartClick(Sender);
end;

procedure IcmpPing; //старый код
begin
    Comps[GnCyclicCompActionCounter].IcmpPings := Comps[GnCyclicCompActionCounter].IcmpPings + 1;
    if (Comps[GnCyclicCompActionCounter].IcmpPings > MAXIMUM_LOST_PINGS) then
      Comps[GnCyclicCompActionCounter].Pingable := False;
    icmpClient.Host := Comps[GnCyclicCompActionCounter].ipaddr;
    try
      icmpClient.Ping;
    except
      if not GRegistry.UserInterface.DontShow.RawSocketWarning then begin
        formGCMessageBox.memoInfo.Text := translate('RawSocketWarning');
        formGCMessageBox.SetDontShowAgain(true);
        formGCMessageBox.ShowModal;
        GCHelp(HELP_ACCOUNTS);
        GRegistry.UserInterface.DontShow.RawSocketWarning :=
            formGCMessageBox.cbNotShowAgain.Checked;
      end;
//      tmrIcmpPing.Enabled := False;
    end;
end;

procedure TformMain.mnuServiceClick(Sender: TObject);
var
  session: TGCSession;
begin
  if (not FunctionAmIRight(FN_SIDELINE)) or (CompsSelCount <> 1) then
    exit;
  session := Comps[ComputersGetIndex(CompsSel[0])].session;
  if (session = Nil) then
    exit;
  // показать форму Sideline
  Application.CreateForm(TformSideline, formSideline);
  if session.PostPay then
    formSideline.ShowModal(stcPostpay, session)
  else
    formSideline.ShowModal(stcPrepay, session);
  formSideline.Destroy;
end;

procedure TformMain.mnuGetMoneyClick(Sender: TObject);
begin
  frmGetMoney := TfrmGetMoney.Create(Self);
  frmGetMoney.ShowModal;
  frmGetMoney.Free;
end;

procedure TformMain.mnuFontClick(Sender: TObject);
begin
  if not formMain.FontDialog.Execute then exit;
  SetTableFont(formMain.FontDialog.Font);
end;

procedure TformMain.Error(const Sender: TObject;
    const AnErrorNumber: Integer; const AlstError: TStringList);
var
  i: Integer;
begin
  case AnErrorNumber of
    ERRNUM_SQLSERVER_NOT_EXIST:
      AlstError.Text := ERR_SQLSERVER_NOT_EXIST;
    ERRNUM_SQLSERVER_PASSWORD_INCORRECT:
      AlstError.Text := ERR_SQLSERVER_PASSWORD_INCORRECT;
  end;
  for i := 0 to AlstError.Count - 1 do
    Console.AddEvent(EVENT_ICON_ERROR, LEVEL_ERROR,
        AlstError[i]);
  Application.MessageBox(PChar(AlstError.Text), Pchar(ERR_CAPTION),
      MB_OK or MB_ICONERROR);
end;

procedure TformMain.mnuXReportClick(Sender: TObject);
begin
  if GRegistry.Modules.KKM.Active then begin
    if not GKKMPlugin.XReport then
      Console.AddEvent(EVENT_ICON_INFORMATION, LEVEL_1,
          'Операция отменена из-за ошибки ККМ: ' + GKKMPlugin.GetLastError);
  end;
end;

procedure TformMain.mnuZReportClick(Sender: TObject);
begin
  if GRegistry.Modules.KKM.Active then begin
    if GKKMPlugin.ZReport then
      Console.AddEvent(EVENT_ICON_INFORMATION, LEVEL_1,
          'Напечатан Z-отчет.')
    else
      Console.AddEvent(EVENT_ICON_INFORMATION, LEVEL_1,
          'Операция отменена из-за ошибки ККМ: ' + GKKMPlugin.GetLastError);
  end;
end;

procedure TformMain.mnuTimeBonus1Click(Sender: TObject);
begin
  GnMinPenalty := 1;
  dmActions.actTimeBonus.Execute;
end;

procedure TformMain.mnuTimeBonus2Click(Sender: TObject);
begin
  GnMinPenalty := 2;
  dmActions.actTimeBonus.Execute;
end;

procedure TformMain.mnuTimeBonus5Click(Sender: TObject);
begin
  GnMinPenalty := 5;
  dmActions.actTimeBonus.Execute;
end;

procedure TformMain.mnuTimeBonus10Click(Sender: TObject);
begin
  GnMinPenalty := 10;
  dmActions.actTimeBonus.Execute;
end;

procedure TformMain.mnuTimeBonus15Click(Sender: TObject);
begin
  GnMinPenalty := 15;
  dmActions.actTimeBonus.Execute;
end;

procedure TformMain.gridCompsKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key=VK_UP) or (Key=VK_DOWN) or (Key=VK_HOME) or
     (Key=VK_END) or (Key=VK_PRIOR) or (Key=VK_NEXT) then
    UpdateSelectedCompList;
  if (Key = ord('A'))  and (ssCtrl in Shift) then
  begin
    gridComps.SelectedRows.SelectAll;
    UpdateSelectedCompList;
  end;
end;

procedure TformMain.mnuLogoutClick(Sender: TObject);
begin
  ehsLogout;
end;

procedure TformMain.mnuWakeUpClick(Sender: TObject);
var
  index: integer;
  bookmark: TBookmarkStr;
begin
   if (not dsConnected) then exit;
   cdsComps.DisableControls;
   bookmark := cdsComps.Bookmark;
   cdsComps.First;
   while (not cdsComps.Eof) do begin
      if (cdsComps.FieldValues['Selection'] <> DS_SELECTION_UNSELECTED) then
      begin
        index := ComputersGetIndex(cdsComps.FieldValues['id']);
        Comps[index].PowerOn;
      end;
      cdsComps.Next;
   end;
   cdsComps.Bookmark := bookmark;
   cdsComps.EnableControls;
end;


procedure TformMain.gridCompsMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 // if mbRight = Button then gridComps.SelectedRows.Clear;  
end;

procedure TformMain.tbCompShutdownClick(Sender: TObject);
begin
  mnuShutdownClick(nil);
end;

procedure TformMain.cmnShutdownAllClick(Sender: TObject);
var
  index : integer;

begin
  if (MessageBox(HWND_TOP, PChar(translate('AreYouSureOnShutdownAll'))
    ,FORM_MAIN_CAPTION,MB_YESNO or MB_ICONQUESTION) <> IDYES) then exit;
  for index := 0 to CompsCount-1 do
    Comps[index].PowerOff;
end;

procedure TformMain.cmnShutdownFreeClick(Sender: TObject);
var
  index : integer;
begin
  for index := 0 to CompsCount-1 do
    if Comps[index].IsFree then
      Comps[index].PowerOff;
end;

procedure TformMain.tbCompWakeUpClick(Sender: TObject);
begin
  mnuWakeUpClick(Nil);
end;

procedure TformMain.cmnResetAllClick(Sender: TObject);
var
  index : integer;
begin
  if (MessageBox(HWND_TOP, PChar(translate('AreYouSureOnResetAll'))
    ,FORM_MAIN_CAPTION,MB_YESNO or MB_ICONQUESTION) <> IDYES) then exit;
  for index := 0 to CompsCount-1 do
    Comps[index].Reboot;
end;

procedure TformMain.cmnResetFreeClick(Sender: TObject);
var
  index : integer;
begin
  for index := 0 to CompsCount-1 do
    if Comps[index].IsFree then
      Comps[index].Reboot;
end;

procedure TformMain.cmnWakeupAllClick(Sender: TObject);
var
  index : integer;
begin
  for index := 0 to CompsCount-1 do
    Comps[index].PowerOn;
end;

procedure TformMain.cmnWakeFreeClick(Sender: TObject);
var
  index : integer;
begin
  for index := 0 to CompsCount-1 do
    if Comps[index].IsFree then
      Comps[index].PowerOn;
end;

procedure TformMain.cmnWakeupNoFreeClick(Sender: TObject);
var
  index : integer;
begin
  for index := 0 to CompsCount-1 do
    if not Comps[index].IsFree then
      WakeUPComputer(Comps[index].macaddr);
end;

procedure TformMain.gridCompsGetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
var
  tmp_value:string;
begin
  if (not dsConnected) then exit; // Если еще не подключились то и нечего отображать

  if cdsComps.FieldByName('SysState').Value <> Null then
    tmp_value := cdsComps.FieldByName('SysState').Value
  else
    tmp_value := '';

  if tmp_value = 'Blocked' then
    AFont.Assign( OperatorProfile.ComputerListBlockedFont);
  if tmp_value = 'notBusy' then
    AFont.Assign( OperatorProfile.ComputerListNotBusyFont);
  if tmp_value = 'Authenticated' then
    AFont.Assign( OperatorProfile.ComputerListAuthenticatedFont);
  if tmp_value = 'Reserve' then
    AFont.Assign( OperatorProfile.ComputerListReserveFont);
  if tmp_value = 'Accupied' then
    AFont.Assign( OperatorProfile.ComputerListAccupiedFont);
  if tmp_value = 'Prevented'then
    AFont.Assign( OperatorProfile.ComputerListPreventedFont);

end;

procedure TformMain.mnuTableOptClick(Sender: TObject);
begin
  Application.CreateForm(TfrmOperatorOpt, frmOperatorOpt);
  frmOperatorOpt.ShowModal;
  OperatorProfile.Load;  
  frmOperatorOpt.Destroy;
end;

procedure TformMain.tbCompLogoffClick(Sender: TObject);
begin
  mnuLogoffClick(nil);
end;

procedure TformMain.mnuLogoffClick(Sender: TObject);
var
  index: integer;
  bookmark: TBookmarkStr;
begin
   if (not dsConnected) then exit;
   cdsComps.DisableControls;
   bookmark := cdsComps.Bookmark;
   cdsComps.First;
   while (not cdsComps.Eof) do begin
      if (cdsComps.FieldValues['Selection'] <> DS_SELECTION_UNSELECTED) then
      begin
         index := ComputersGetIndex(cdsComps.FieldValues['id']);
         Comps[index].Logoff; 
      end;
      cdsComps.Next;
   end;
   cdsComps.Bookmark := bookmark;
   cdsComps.EnableControls;
end;

procedure TformMain.cmnLogoffAllClick(Sender: TObject);
var
  index : integer;
begin
  if (MessageBox(HWND_TOP, PChar(translate('AreYouSureOnLogoffAll'))
    ,FORM_MAIN_CAPTION,MB_YESNO or MB_ICONQUESTION) <> IDYES) then exit;
  for index := 0 to CompsCount-1 do
    Comps[index].Logoff
end;

procedure TformMain.cmnLogoffFreeClick(Sender: TObject);
var
  index : integer;
begin
  for index := 0 to CompsCount-1 do
    if Comps[index].IsFree then
      Comps[index].Logoff
end;

function GetIdColumnByFieldName(Grid:TDBGridEh; FieldName: String):integer;
var
  i: integer;
  IdColumn: integer;
begin
  IdColumn := -1;
  for i:=0 to Grid.Columns.Count - 1 do
    if Grid.Columns[i].FieldName = FieldName Then
    begin
      IdColumn := i;
      Break;
    end;

  Result := IdColumn;
end;

end.

