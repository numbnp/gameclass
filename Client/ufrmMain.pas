
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Главная форма клиентского приложения GameClass.
//
//////////////////////////////////////////////////////////////////////////////

unit ufrmMain;

interface

uses
  Windows,
  Messages,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  ComCtrls,
  OleCtrls,
  SHDocVw,
  ExtCtrls,
  Buttons,
  Mask,
  ieConst,
  Menus,
  uClientWebInterface,
  cefvcl,ceflib,
  uSafeStorage,
  SysUtils,
  Variants,
  Classes,
  Types,
  // system units
  uBlockingsAndNotifications,
  uClientConst,
  ufrmSmallInfo, ImgList, ToolWin,
  uClientFunctions;

type

  //
  // TformMain
  //

  TfrmMain = class(TForm)
    pnlTop: TPanel;
    pnlScreenLogin: TPanel;

    wbTop: TWebBrowser;
    wbAccountCompFree: TWebBrowser;
    wbAgreement: TWebBrowser;
    wbAccount: TWebBrowser;
    wbCompFree: TWebBrowser;
    gbLogon: TGroupBox;
    lblLogin: TLabel;
    lblPassword: TLabel;
    edtLogin: TEdit;
    edtPassword: TEdit;
    butLogon: TButton;
    edtSecCode: TEdit;
    lblSecCode: TLabel;
    pnlClock: TPanel;
    pnlScreenAgreement: TPanel;
    butAgree: TButton;
    butNotAgree: TButton;
    pnlScreenCompFree: TPanel;
    pnlScreenClientInfo: TPanel;
    pcFunctions: TPageControl;
    tabStartStop: TTabSheet;
    tabAdd: TTabSheet;
    tabSendMess: TTabSheet;
    lblTariff: TLabel;
    cboTarifs: TComboBox;
    lblSumma: TLabel;
    btnSessionStart: TButton;
    btnSessionStop: TButton;
    memInfo: TMemo;
    gbAccount: TGroupBox;
    lblLoggedAsCaption: TLabel;
    lblLoggedAs: TLabel;
    lblBalance: TLabel;
    lblBalanceCaption: TLabel;
    butLogoff: TButton;
    butChangePass: TButton;
    lblTime: TLabel;
    memMessages: TMemo;
    tabAccountInfo: TTabSheet;
    pnlSendMessageBottom: TPanel;
    edtMessage: TEdit;
    btnSendMessage: TButton;
    pnlSendMessageClient: TPanel;
    pnlAccountInfoClient: TPanel;
    memBalanceHistory: TMemo;
    dtpTime: TDateTimePicker;
    lblStart: TLabel;
    lblStop: TLabel;
    lblTrafficSum: TLabel;
    lblTraffic: TLabel;
    lblMB3: TLabel;
    butAddTraffic: TButton;
    pnlClientInfoLeft: TPanel;
    pnlClientInfoMiddle: TPanel;
    pnlClientInfoAccount: TPanel;
    pnlBlocked: TPanel;
    tmrClock: TTimer;
    pgctrlMain: TPageControl;
    tabScreenAgreement: TTabSheet;
    tabScreenClientInfo: TTabSheet;
    tabScreenCompFree: TTabSheet;
    tabScreenLogin: TTabSheet;
    pnl: TPanel;
    pnlButtonsLeft: TPanel;
    pnlButtonsLogon: TPanel;
    pnlButtonsGuest: TPanel;
    btnGuest: TButton;
    gbTime: TGroupBox;
    gbTraffic: TGroupBox;
    lblTimeSum: TLabel;
    lblTimeLength: TLabel;
    btnAddTime: TButton;
    dtpAddTimeLength: TDateTimePicker;
    edtStart: TEdit;
    edtStop: TEdit;
    pnlAgreement: TPanel;
    pnlAccount: TPanel;
    pnlAccountCompFree: TPanel;
    pnlMain: TPanel;
    tmrSafeOpearation: TTimer;
    lblWrongNameOrPassword: TLabel;
    lblSpentCaption: TLabel;
    lblSpent: TLabel;
    tbActions: TToolBar;
    tbCompShutdown: TToolButton;
    ilActions: TImageList;
    popShutDown: TPopupMenu;
    mnuShutdown: TMenuItem;
    mnuReboot: TMenuItem;
    mnuLogoff: TMenuItem;
    edtSum: TEdit;
    edtAddTimeSum: TEdit;
    edtAddTrafficSum: TEdit;
    edtAddTrafficSize: TEdit;
    pnlWeb: TPanel;
    procedure FormActivate(Sender: TObject);
    procedure btnSendMessageClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure modernTrayIconDblClick(Sender: TObject);
    procedure butLogonClick(Sender: TObject);
    procedure butAgreeClick(Sender: TObject);
    procedure butNotAgreeClick(Sender: TObject);
    procedure butLogoffClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cboTarifsChange(Sender: TObject);
    procedure edtSumChange(Sender: TObject);
    procedure dtpTimeChange(Sender: TObject);
    procedure btnSessionStartClick(Sender: TObject);
    procedure btnSessionStopClick(Sender: TObject);
    procedure edtAddTrafficSumChange(Sender: TObject);
    procedure edtAddTrafficSizeChange(Sender: TObject);
    procedure butAddTrafficClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure edtMessageKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tmrClockTimer(Sender: TObject);
    procedure edtSumEnter(Sender: TObject);
    procedure edtSumExit(Sender: TObject);
    procedure dtpTimeEnter(Sender: TObject);
    procedure dtpTimeExit(Sender: TObject);
    procedure edtAddTrafficSumEnter(Sender: TObject);
    procedure edtAddTrafficSumExit(Sender: TObject);
    procedure edtAddTrafficSizeEnter(Sender: TObject);
    procedure edtAddTrafficSizeExit(Sender: TObject);
    procedure memInfoChange(Sender: TObject);
    procedure btnGuestClick(Sender: TObject);
    procedure btnAddTimeClick(Sender: TObject);
    procedure edtAddTimeSumEnter(Sender: TObject);
    procedure edtAddTimeSumExit(Sender: TObject);
    procedure dtpAddTimeLengthEnter(Sender: TObject);
    procedure dtpAddTimeLengthExit(Sender: TObject);
    procedure edtAddTimeSumChange(Sender: TObject);
    procedure dtpAddTimeLengthChange(Sender: TObject);
    procedure tmrSafeOpearationTimer(Sender: TObject);
    procedure edtLoginKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtPasswordKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mnuShutdownClick(Sender: TObject);
    procedure mnuRebootClick(Sender: TObject);
    procedure mnuLogoffClick(Sender: TObject);
    procedure pnlClockClick(Sender: TObject);
    procedure pnlCompNumberClick(Sender: TObject);
    procedure tbCompShutdownClick(Sender: TObject);
    procedure pnlBlockedClick(Sender: TObject);
  private
    { Private declarations }
    FstrURLPath: String;
    FbOnChangeEnabled: Boolean;
//    FBlockingsAndNotifications: TBlockingsAndNotifications;
    FbEdtSumFocused: Boolean;
    FbDtpTimeFocused: Boolean;
    FbEdtAddTrafficSumFocused: Boolean;
    FbEdtAddTrafficSizeFocused: Boolean;
    FbEdtAddTimeSumFocused: Boolean;
    FbDtpAddTimeLengthFocused: Boolean;
    FbBeforeFirstFormShow: Boolean;
    FbAfterFirstFormShow: Boolean;
    FbShutdownAlt:integer;
  protected
    procedure _PasswordHotKey;
  public
    { Public declarations }
    GCClientWebInterface: TWebInterface;
    procedure InitializeApplicationWindows;
    procedure Show;
    procedure NavigateWebBrousers;
    procedure UpdateData;
    procedure DoDesign;
    procedure DoDesignStartStop;
    procedure DoDesignAdd;
    procedure DisableOnChange;
    procedure EnableOnChange;
    function IsOnChangeEnabled: Boolean;

    property EdtSumFocused: Boolean read FbEdtSumFocused;
    property DtpTimeFocused: Boolean read FbDtpTimeFocused;
    property EdtAddTrafficSumFocused: Boolean read FbEdtAddTrafficSumFocused;
    property EdtAddTrafficSizeFocused: Boolean read FbEdtAddTrafficSizeFocused;
    property EdtAddTimeSumFocused: Boolean read FbEdtAddTimeSumFocused;
    property DtpAddTimeLengthFocused: Boolean read FbDtpAddTimeLengthFocused;
    property AfterFirstFormShow: Boolean read FbAfterFirstFormShow;
    procedure ActivateInfo(var Message: TMessage);
        message WM_USER_ACTIVATE_INFO;
    procedure HotKey(var Message: TMessage);
        message WM_HOTKEY;
    procedure EnableSafeOperation;

    procedure WIActionLogoff(Sender: TObject);
    procedure WIActionClientSessionStop(Sender: TObject);
    procedure WIActionLoadComplete(Sender: TObject);
    procedure WIActionAgreeEula(Sender: TObject);
    procedure WIActionNotAgreeEula(Sender: TObject);
    procedure WIActionSysLogoff(Sender: TObject);
    procedure WIActionSysReboot(Sender: TObject);
    procedure WIActionSysShutdown(Sender: TObject);

    procedure WIActionChangePassword(Sender: TObject;OldPassword,NewPassword:string);
    procedure WIActionChangeTariff(Sender: TObject;sTariff:string);
    procedure WIActionLogon(Sender: TObject;sLogin,sPassword,sSecCode:string);
    procedure WIActionQueryCostTime (Sender: TObject;sTariff,sSumm:string);
    procedure WIActionStartSession (Sender: TObject;sTariff,sSumm:string);
    procedure WIActionQueryAddTimeCost( Sender: TObject;sSumm:string);
    procedure WIActionAddMoney (Sender: TObject;sSumm:string);
    procedure WIActionUnblock (Sender: TObject;Code:string);
    procedure WIParceAndReplaceLine (Sender: TObject; var sBuf:String);


  end;        // TformMain

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses
  ActiveX,
  uRunPadTools,
  uClientInstallDirectory,
  uLocalCommandSender,
  uProtocol,
  uRemoteCommand,
  uClientInfoConst,
  uClientInfo,
  uClientOptions,
  uClientOptionsConst,
  uY2KCommon,
  uY2KString,
  DateUtils,
  uDebugLog,
  uClientScripting,
  uKillTaskRemoteCommand,
  uLogoffRemoteCommand,
  uParseAndReplase;

const
  DATE_FORMAT = 'dd mmm yy hh:mm:ss';
procedure TfrmMain.Show;
begin
  Debug.Trace5('Show 0');
  if FbBeforeFirstFormShow then begin
    Debug.Trace5('Show 1');
    FbBeforeFirstFormShow := False;
  end;
  Left := (Screen.Width - Width) div 2;
  Top := (Screen.Height - Height) div 2;
  inherited Show;
  ShowWindow(Application.Handle,SW_HIDE);  // Скрываем программу в таскбаре
  Debug.Trace5('Show 2');
  if not FbAfterFirstFormShow then begin
    SetFocus;
    FbAfterFirstFormShow := True;
  end;
end;

procedure TfrmMain.InitializeApplicationWindows;
var
  nLeft : Integer;
begin
  if FbBeforeFirstFormShow then begin
    nLeft := Left;
    Left := Screen.Width;
    inherited Show;
    ShowWindow(Application.Handle,SW_HIDE);  // Скрываем программу в таскбаре
    Hide;
    Left := nLeft;
    FbBeforeFirstFormShow := False;
  end;
end;

procedure TfrmMain.FormActivate(Sender: TObject);
begin
  //DoDesign;
  //UpdateData;
end;

procedure TfrmMain.btnSendMessageClick(Sender: TObject);
var
  strSendData: String;
begin
  memMessages.Lines.Add(GClientInfo.Login + ': ' + edtMessage.Text);
  strSendData := STR_CMD_SENDMESSAGE + '=//' + edtMessage.Text;
  LocalSendDataTo(strSendData,False);
  edtMessage.Text := '';
end;

procedure TfrmMain.ActivateInfo(var Message: TMessage);
begin
  TSafeStorage.Instance().Push(ThreadSafeOperation_MainFormAction,
      Integer(FormAction_Show));
end;

procedure TfrmMain.HotKey(var Message: TMessage);
begin
  GClientInfo.LastKeyDown := Now;
  if Message.LParam = MakeLong(MOD_ALT or MOD_CONTROL or MOD_SHIFT, $49{I}) then
    TSafeStorage.Instance().Push(ThreadSafeOperation_MainFormAction,
        Integer(FormAction_Show));
  if (Message.LParam = MakeLong(MOD_ALT or MOD_CONTROL, $55{U})) then
      _PasswordHotKey;
end;


procedure TfrmMain.NavigateWebBrousers;
begin
  if pnlMain.Visible then
  begin
    //wbFullScreen.Stop;
    wbTop.Enabled := True;
    wbAgreement.Enabled := True;
    wbCompFree.Enabled := True;
    wbAccountCompFree.Enabled := True;
    wbAccount.Enabled := True;

    try

    if not wbTop.Busy and (Length(GClientOptions.URLTop)>0) then begin

      if Pos('\',GClientOptions.URLTop)=0 then
        wbTop.Navigate(FstrURLPath + GClientOptions.URLTop)
      else
        wbTop.Navigate(GClientOptions.URLTop)
    end;
    if not wbAgreement.Busy and (Length(GClientOptions.URLAgreement)>0) then begin
      if Pos('\',GClientOptions.URLAgreement)=0 then
        wbAgreement.Navigate(FstrURLPath + GClientOptions.URLAgreement)
      else
        wbAgreement.Navigate(GClientOptions.URLAgreement);
    end;
    if not wbCompFree.Busy and (Length(GClientOptions.URLCompFree)>0) then begin
      if Pos('\',GClientOptions.URLCompFree)=0 then
        wbCompFree.Navigate(FstrURLPath + GClientOptions.URLCompFree)
      else
        wbCompFree.Navigate(GClientOptions.URLCompFree);
    end;
    if not wbAccountCompFree.Busy
        and (Length(GClientOptions.URLLogonCompFree)>0) then begin
      if Pos('\',GClientOptions.URLLogonCompFree)=0 then
        wbAccountCompFree.Navigate(FstrURLPath + GClientOptions.URLLogonCompFree)
      else
        wbAccountCompFree.Navigate(GClientOptions.URLLogonCompFree);
    end;
    if not wbAccount.Busy and (Length(GClientOptions.URLLogonHelp)>0) then begin
      if Pos('\',GClientOptions.URLLogonHelp)=0 then
        wbAccount.Navigate(FstrURLPath + GClientOptions.URLLogonHelp)
      else
        wbAccount.Navigate(GClientOptions.URLLogonHelp);
    end;

    except
    end;

    wbTop.Enabled := False;
    wbAgreement.Enabled := False;
    wbCompFree.Enabled := False;
    wbAccountCompFree.Enabled := False;
    wbAccount.Enabled := False;

  end;
end;

procedure TfrmMain.UpdateData;
begin
  FbOnChangeEnabled := False;
  lblLoggedAs.Caption := GClientInfo.Login;
  lblBalance.Caption := FloatToStr(GClientInfo.Balance);
  if Assigned(GCClientWebInterface) then
  begin
    GCClientWebInterface.SetInterfaceData('{"login": "' + GClientInfo.Login +'"}');
    GCClientWebInterface.SetInterfaceData('{"balance": "' + FloatToStr(GClientInfo.Balance) +'"}');
    GCClientWebInterface.SetInterfaceData('{"balance_limit": "' + FloatToStr(GClientInfo.BalanceLimit) +'"}');
    GCClientWebInterface.SetInterfaceData('{"accumulated": "' + FloatToStr(GClientInfo.Spent) +'"}');
    GCClientWebInterface.SetInterfaceData('{"session_info": "' + GClientInfo.FullInfo +'"}');
  end;
  if GClientInfo.Spent > 0 then
  begin
    lblSpent.Visible := True;
    lblSpentCaption.Visible := True;
    lblSpent.Caption := FloatToStr(GClientInfo.Spent);
  end else begin
    lblSpent.Visible := False;
    lblSpentCaption.Visible := False;
  end;
  memInfo.Text := GClientInfo.FullInfo;
  memBalanceHistory.Text := GClientInfo.BalanceHistory;
  FbOnChangeEnabled := True;
end;

procedure TfrmMain.WIActionAddMoney(Sender: TObject; sSumm: string);
begin
  if IsOnChangeEnabled then begin
    FbOnChangeEnabled := False;
    SessionAddMoney(sSumm);
    btnAddTime.Enabled := False;
    edtAddTimeSum.Enabled := False;
    dtpAddTimeLength.Enabled := False;
    edtAddTimeSum.Text := '0';
    dtpAddTimeLength.Time := 0;

    GCClientWebInterface.AddTimeSum := 0;
    FbOnChangeEnabled := True;

    WIActionQueryAddTimeCost(Sender,FloatToStr(GCClientWebInterface.AddTimeSum));
  end;
end;

procedure TfrmMain.WIActionAgreeEula(Sender: TObject);
begin
  AgreeEula;
end;

procedure TfrmMain.WIActionChangePassword(Sender: TObject; OldPassword,
  NewPassword: string);
begin
  ChangePassword(OldPassword,NewPassword);
end;

procedure TfrmMain.WIActionChangeTariff(Sender: TObject; sTariff: string);
begin
  if IsOnChangeEnabled then begin
    edtSum.Text := '1,00';
    GCClientWebInterface.Sum := 1;
    dtpTime.Time := FIRST_DATE; // 01.01.2000 0:00:00
    DoDesignStartStop;
    WIActionQueryCostTime(Sender,sTariff,FloatToStr(GCClientWebInterface.Sum));
  end;
end;

procedure TfrmMain.WIActionClientSessionStop(Sender: TObject);
begin
  ClientSessionStop;
end;

procedure TfrmMain.WIActionLoadComplete(Sender: TObject);
begin
  TSafeStorage.Instance().Push(ThreadSafeOperation_DoDesign,0);
  TSafeStorage.Instance().Push(ThreadSafeOperation_UpdateData,0);
  TSafeStorage.Instance().Push(ThreadSafeOperation_UpdateCompNumber,0);
end;

procedure TfrmMain.WIActionLogoff(Sender: TObject);
begin
  memMessages.Lines.Clear;
  edtLogin.Text := '';
  edtPassword.Text := '';
  edtSecCode.Text := '';
  ClientLogoff;
{  SendMessage(frmMain.Handle,WM_USER_THREADSAFE_UPDATE,
      lParam(ThreadSafeOperation_RunPadAction),
      wParam(RunPadAction_EndVipSession));}
  if (GClientOptions.ShellMode = ShellMode_Runpad) then begin
    TSafeStorage.Instance().Push(ThreadSafeOperation_RunPadAction,
        Integer(RunPadAction_VipLogout));
  end;
end;

procedure TfrmMain.WIActionLogon(Sender: TObject; sLogin, sPassword,
  sSecCode: string);
begin
  ClientLogon(sLogin, sPassword, sSecCode);
end;

procedure TfrmMain.WIActionNotAgreeEula(Sender: TObject);
begin
  NotAgreeEula;
end;

procedure TfrmMain.WIActionQueryAddTimeCost(Sender: TObject; sSumm: string);
begin
  if IsOnChangeEnabled then begin
    QueryCostAddTime(sSumm);
    DoDesignAdd;
  end;

end;

procedure TfrmMain.WIActionQueryCostTime(Sender: TObject; sTariff,
  sSumm: string);
begin
  if IsOnChangeEnabled then begin
    QueryCostTime(sTariff,sSumm);
    DoDesignStartStop;
  end;
end;

procedure TfrmMain.WIActionStartSession(Sender: TObject; sTariff,
  sSumm: string);
begin
  ClientSessionStart(sTariff,sSumm);
end;

procedure TfrmMain.WIActionSysLogoff(Sender: TObject);
begin
  QuerySysLogoff;
end;

procedure TfrmMain.WIActionSysReboot(Sender: TObject);
begin
  QuerySysReboot;
end;

procedure TfrmMain.WIActionSysShutdown(Sender: TObject);
begin
  QuerySysShutdown;
end;

procedure TfrmMain.WIActionUnblock(Sender: TObject; Code: string);
begin
  UnblockedByPassword(Code);
  if GClientInfo.UnblockedByPassword then
  begin
    GCClientWebInterface.HideUnblock;
    GCClientWebInterface.ShowMessages('Разблокировано');
  end else
    GCClientWebInterface.ShowMessages('Ошибка');

end;

procedure TfrmMain.WIParceAndReplaceLine(Sender: TObject; var sBuf: String);
begin
  sBuf:=ParseAndReplase(sBuf);
end;

procedure TfrmMain.DoDesign;
begin
try
  Debug.Trace5('DoDesign 1');
  if (frmSmallInfo.Visible
      and (GClientInfo.ClientState <> ClientState_Session)
      and (GClientInfo.ClientState <> ClientState_OperatorSession))
      or not(GClientOptions.ShowSmallInfo) then begin
    frmSmallInfo.Hide;
  end else if not(frmSmallInfo.Visible)
      and ((GClientInfo.ClientState = ClientState_Session)
      or (GClientInfo.ClientState = ClientState_OperatorSession))
      and GClientOptions.ShowSmallInfo then begin
    frmSmallInfo.Show;
//    frmSmallInfo.Hide;
  end;

  if GClientOptions.ShutdownButton > -1 then
        GCClientWebInterface.SetInterfaceData('{ "show_shutdown_button": "1" }')
      else
        GCClientWebInterface.SetInterfaceData('{ "show_shutdown_button": "0" }');

  Debug.Trace5('DoDesign 2');
  Debug.Trace5('DoDesign State' + IntToStr(Integer(GClientInfo.ClientState)));

  case GClientInfo.ClientState of
    ClientState_Blocked: begin
      pgctrlMain.ActivePage := tabScreenCompFree;
      GCClientWebInterface.SetClientState(0);
    end;
    ClientState_Authentication: begin
      Debug.Trace5('DoDesign a1');
      pgctrlMain.ActivePage := tabScreenLogin;
      Debug.Trace5('DoDesign a2');
      lblSecCode.Visible := (GClientInfo.SecCode <> 0);
      edtSecCode.Visible := (GClientInfo.SecCode <> 0);
      Debug.Trace5('DoDesign a3');
      lblSecCode.Caption := 'Code #'+ IntToStr(GClientInfo.SecCode);
      Debug.Trace5('DoDesign a4');
      pnlButtonsGuest.Visible := GClientOptions.GuestSession;
      pnlButtonsLeft.Visible := not pnlButtonsGuest.Visible;
      Debug.Trace5('DoDesign a5');
      GCClientWebInterface.SetClientState(1);
    end;
    ClientState_Order: begin
      pgctrlMain.ActivePage := tabScreenClientInfo;
      pnlClientInfoAccount.Visible := True;
      tabAccountInfo.TabVisible := True;
      tabStartStop.TabVisible := True;
      tabSendMess.TabVisible := True;
      tabAccountInfo.TabVisible := True;
      cboTarifs.Enabled := True;
      GCClientWebInterface.SetClientState(2);
      DoDesignStartStop;

    end;
    ClientState_Session: begin
      pgctrlMain.ActivePage := tabScreenClientInfo;
      tabAccountInfo.TabVisible := True;
      tabAdd.TabVisible := True;
      gbTraffic.Visible := GClientInfo.TrafficSeparatePayment;
      if GClientInfo.TrafficSeparatePayment then
        GCClientWebInterface.SetInterfaceData('{ "show_add_traffic_block": "1" }')
      else
        GCClientWebInterface.SetInterfaceData('{ "show_add_traffic_block": "0" }');
      tabStartStop.TabVisible := True;
      pnlClientInfoAccount.Visible := True;
      btnSessionStart.Enabled := False;
      btnSessionStop.Enabled := True;
      edtSum.Enabled := False;
      dtpTime.Enabled := False;
      cboTarifs.Enabled := False;
      GCClientWebInterface.SetClientState(3);
    end;
    ClientState_Agreement: begin
      pgctrlMain.ActivePage := tabScreenAgreement;
      butNotAgree.Enabled := True;
      GCClientWebInterface.SetClientState(4);
    end;
    ClientState_OperatorSession: begin
      pgctrlMain.ActivePage := tabScreenClientInfo;
      pnlClientInfoAccount.Visible := False;
      tabAccountInfo.TabVisible := False;
      tabStartStop.TabVisible := False;
      tabAdd.TabVisible := False;
      GCClientWebInterface.SetClientState(5);
    end;
    ClientState_OperatorAgreement: begin
      pgctrlMain.ActivePage := tabScreenAgreement;
      butNotAgree.Enabled := False;
      GCClientWebInterface.SetClientState(6);
    end;
  end;

  if (GClientInfo.ClientState = ClientState_Blocked)
      or (GClientInfo.ClientState = ClientState_Authentication) then
  begin
    //if pnlMain.Visible then
    begin
      pnlMain.Visible := True;
      frmMain.BorderStyle := bsSingle;
      frmMain.WindowState := wsNormal;
    end;
  end;


  Debug.Trace5('DoDesign 3');
  tbActions.Visible := GClientOptions.ShutdownButton > -1;
  if GClientOptions.ShutdownButton >0 then
    tbCompShutdown.ImageIndex := GClientOptions.ShutdownButton -1
  else
    tbCompShutdown.ImageIndex := 0;

except
  on e: Exception do begin
    Debug.Trace0('DoDesign Error! ' + e.Message);
  end;
end;
  Debug.Trace5('DoDesign 3');
end;

procedure TfrmMain.DoDesignStartStop;
var
  fSum: Double;
begin
  DisableOnChange;
  fSum := StrToFloatDefWithReplace(edtSum.Text, 0);
  btnSessionStart.Enabled := (Length(cboTarifs.Text)>0)
      and (fSum > 0)
      and (fSum <= GClientInfo.Balance - GClientInfo.BalanceLimit)
      and (not ((HourOf(frmMain.dtpTime.Time) = 0 ) and (MinuteOf(frmMain.dtpTime.Time)=0)));
  btnSessionStop.Enabled := False;
  tabAdd.TabVisible := False;
  if (Length(cboTarifs.Text)=0) then begin
    edtSum.Enabled := False;
    dtpTime.Enabled := False;
  end;

  fSum := GCClientWebInterface.Sum;
  if (Length(GCClientWebInterface.TarifName)>0) and (fSum > 0)
      and (fSum <= GClientInfo.Balance - GClientInfo.BalanceLimit) then
    GCClientWebInterface.SetInterfaceData('{ "enable_start_session": "1" }')
  else
    GCClientWebInterface.SetInterfaceData('{ "enable_start_session": "0" }');

  EnableOnChange;
end;

procedure TfrmMain.DoDesignAdd;
var
  fSumTraffic, fSumTime: Double;
begin
  DisableOnChange;
  fSumTime := StrToFloatDefWithReplace(edtAddTimeSum.Text, 0);
  fSumTraffic := StrToFloatDefWithReplace(edtAddTrafficSum.Text, 0);
  btnAddTime.Enabled := (fSumTime > 0)
      and (fSumTime <= GClientInfo.Balance - GClientInfo.BalanceLimit);
  butAddTraffic.Enabled := (fSumTraffic > 0)
      and (fSumTraffic <= GClientInfo.Balance - GClientInfo.BalanceLimit);

  fSumTime := GCClientWebInterface.AddTimeSum;
  if (fSumTime > 0)
      and (fSumTime <= GClientInfo.Balance - GClientInfo.BalanceLimit) then
    GCClientWebInterface.SetInterfaceData('{ "enable_add_money": "1" }')
  else
    GCClientWebInterface.SetInterfaceData('{ "enable_add_money": "0" }');

  EnableOnChange;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  FbBeforeFirstFormShow := True;
  FbAfterFirstFormShow := False;
//  GDocHostUIHandler := TDocHostUIHandler.Create;
  FbOnChangeEnabled := True;
  FstrURLPath := InstallDirectory + '\Skins\';
  LocalSendDataTo(STR_CMD_OPTION_GET+'=all',False);
  LocalSendDataTo(STR_CMD_CLIENT_INFO_GET+'=all',False);
//  GCClientWebInterface.ReloadSkin;
  GCClientWebInterface := TWebInterface.Create(self.pnlWeb);
  GCClientWebInterface.ActionLogoff := WIActionLogoff;
  GCClientWebInterface.ActionChangePassword := WIActionChangePassword;
  GCClientWebInterface.ActionChangeTariff := WIActionChangeTariff;
  GCClientWebInterface.ActionLogon := WIActionLogon;
  GCClientWebInterface.ActionQueryCostTime := WIActionQueryCostTime;
  GCClientWebInterface.ActionStartSession := WIActionStartSession;
  GCClientWebInterface.ActionStopSession := WIActionClientSessionStop;
  GCClientWebInterface.ActionLoadComplete := WIActionLoadComplete;
  GCClientWebInterface.ActionQueryAddTimeCost := WIActionQueryAddTimeCost;
  GCClientWebInterface.ActionAddMoney := WIActionAddMoney;
  GCClientWebInterface.ActionUnblock := WIActionUnblock;
  GCClientWebInterface.ParceAndReplaceLine := WIParceAndReplaceLine;
  GCClientWebInterface.ActionAgreeEula := WIActionAgreeEula;
  GCClientWebInterface.ActionNotAgreeEula := WIActionNotAgreeEula;
  GCClientWebInterface.ActionSysLogoff := WIActionSysLogoff;
  GCClientWebInterface.ActionSysReboot := WIActionSysReboot;
  GCClientWebInterface.ActionSysShutdown := WIActionSysShutdown;

  GCClientWebInterface.Start;

    TSafeStorage.Instance().Push(ThreadSafeOperation_UpdateCompNumber, 0);
  TSafeStorage.Instance().Push(ThreadSafeOperation_RunPadAction,
      Integer(RunPadAction_HideTabs));

  RunClientScript(caClientStart);
end;

procedure TfrmMain.modernTrayIconDblClick(Sender: TObject);
begin
  TSafeStorage.Instance().Push(ThreadSafeOperation_MainFormAction,
      Integer(FormAction_Show));
  TSafeStorage.Instance().Push(ThreadSafeOperation_DoDesign,0);
  TSafeStorage.Instance().Push(ThreadSafeOperation_UpdateData,0);
end;

procedure TfrmMain.butLogonClick(Sender: TObject);
begin
  //lblWrongNameOrPassword.Visible := False;
  WIActionLogon(Sender,edtLogin.Text, edtPassword.Text, edtPassword.Text );
end;

procedure TfrmMain.butAgreeClick(Sender: TObject);
begin
  WIActionAgreeEula(Sender);;
end;

procedure TfrmMain.butNotAgreeClick(Sender: TObject);
begin
  WIActionNotAgreeEula(Sender);
end;

procedure TfrmMain.butLogoffClick(Sender: TObject);
begin
  WIActionLogoff(Sender);
end;

procedure TfrmMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  GClientInfo.LastKeyDown := Now;
  if (Key = VK_ESCAPE)
      and Visible and not GClientInfo.ResultBlocking then
    Hide;
  if not (ssShift in Shift)
      and (ssAlt in Shift)
      and (ssCtrl in Shift)
      and (Key = $55{U}) then begin
    _PasswordHotKey;
  end;
end;

procedure TfrmMain.cboTarifsChange(Sender: TObject);
begin
  WIActionChangeTariff(Sender,cboTarifs.Text);
end;

procedure TfrmMain.edtSumChange(Sender: TObject);
begin
  WIActionQueryCostTime(Sender,GCClientWebInterface.TarifName,edtSum.Text);
end;

procedure TfrmMain.dtpTimeChange(Sender: TObject);
begin
  if IsOnChangeEnabled then begin
    LocalSendDataTo(STR_CMD_AUTH_QUERYCOSTTIME_2 + '=' + cboTarifs.Text + '//'
        + DateTimeToStr(dtpTime.Time),False);
    DoDesignStartStop;
  end;
end;

procedure TfrmMain.btnSessionStartClick(Sender: TObject);
begin
  WIActionStartSession(Sender,cboTarifs.Text,edtSum.Text);
end;

procedure TfrmMain.btnSessionStopClick(Sender: TObject);
begin
  WIActionClientSessionStop(Sender);
end;

procedure TfrmMain.edtAddTrafficSumChange(Sender: TObject);
begin
  if IsOnChangeEnabled then begin
    QueryCostTrafficAdd(edtAddTrafficSum.Text);
    DoDesignAdd;
  end;
end;

procedure TfrmMain.edtAddTrafficSizeChange(Sender: TObject);
begin
  if IsOnChangeEnabled then begin
    LocalSendDataTo(STR_CMD_AUTH_QUERYCOSTTRAFFIC_3 + '=/' + edtAddTrafficSize.Text,
       False);
    DoDesignAdd;
  end;
end;

procedure TfrmMain.DisableOnChange;
begin
  FbOnChangeEnabled := False;
end;

procedure TfrmMain.EnableOnChange;
begin
  FbOnChangeEnabled := True;
end;

function TfrmMain.IsOnChangeEnabled: Boolean;
begin
  Result := FbOnChangeEnabled;
end;

procedure TfrmMain.butAddTrafficClick(Sender: TObject);
begin
  if IsOnChangeEnabled then begin
    FbOnChangeEnabled := False;
    SessionAddTraffic(edtAddTrafficSum.Text);
    butAddTraffic.Enabled := False;
    edtAddTrafficSum.Enabled := False;
    edtAddTrafficSize.Enabled := False;
    edtAddTrafficSum.Text := '0';
    edtAddTrafficSize.Text := '0';
    FbOnChangeEnabled := True;
  end;
end;


procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caNone;
  if not GClientInfo.ResultBlocking then
    Hide;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  tmrSafeOpearation.Enabled := False;
//  GDocHostUIHandler.Free;
end;

procedure TfrmMain.edtMessageKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = 13{Enter}) then
    btnSendMessageClick(Sender);
end;

procedure TfrmMain.tmrClockTimer(Sender: TObject);

begin
  pnlClock.Caption := TimeToStr(Time);
  //modernTrayIcon.Active := FindWindow('Shell_TrayWnd','')<>0;
//  modernTrayIcon.Active := false;
//  modernTrayIcon.Active := true;
//  GClientInfo.NowTime := GClientInfo.NowTime + OneSecond;
  if (SecondOf(Time) mod 10) = 0 then
    GClientInfo.SaveIfNeeded;
end;

procedure TfrmMain.edtSumEnter(Sender: TObject);
begin
  //Такая ботва нужна из-за тридов, т.к. Focused порет чушь
  FbEdtSumFocused := True;
end;

procedure TfrmMain.edtSumExit(Sender: TObject);
begin
  FbEdtSumFocused := False;
end;

procedure TfrmMain.dtpTimeEnter(Sender: TObject);
begin
  FbDtpTimeFocused := True;
end;

procedure TfrmMain.dtpTimeExit(Sender: TObject);
begin
  FbDtpTimeFocused := False;
end;

procedure TfrmMain.edtAddTrafficSumEnter(Sender: TObject);
begin
  FbEdtAddTrafficSumFocused := True;
end;

procedure TfrmMain.edtAddTrafficSumExit(Sender: TObject);
begin
  FbEdtAddTrafficSumFocused := False;
end;

procedure TfrmMain.edtAddTrafficSizeEnter(Sender: TObject);
begin
  FbEdtAddTrafficSizeFocused := True;
end;

procedure TfrmMain.edtAddTrafficSizeExit(Sender: TObject);
begin
  FbEdtAddTrafficSizeFocused := False;
end;

procedure TfrmMain.edtAddTimeSumEnter(Sender: TObject);
begin
  FbEdtAddTimeSumFocused := True;
end;

procedure TfrmMain.edtAddTimeSumExit(Sender: TObject);
begin
  FbEdtAddTimeSumFocused := False;
end;

procedure TfrmMain.dtpAddTimeLengthEnter(Sender: TObject);
begin
  FbDtpAddTimeLengthFocused := True;
end;

procedure TfrmMain.dtpAddTimeLengthExit(Sender: TObject);
begin
  FbDtpAddTimeLengthFocused := False;
end;


procedure TfrmMain.memInfoChange(Sender: TObject);
begin
  edtAddTrafficSum.Enabled := True;
  edtAddTrafficSize.Enabled := True;
  edtAddTimeSum.Enabled := True;
  dtpAddTimeLength.Enabled := True;
  DoDesignAdd;
end;

procedure TfrmMain.btnGuestClick(Sender: TObject);
begin
  lblWrongNameOrPassword.Visible := False;
  LocalSendDataTo(STR_CMD_GUESTSESSION, False);
end;

procedure TfrmMain.btnAddTimeClick(Sender: TObject);
begin
  WIActionAddMoney(Sender,edtAddTimeSum.Text);
end;

procedure TfrmMain.edtAddTimeSumChange(Sender: TObject);
begin
  WIActionQueryAddTimeCost(Sender,edtAddTimeSum.Text);
end;

procedure TfrmMain.dtpAddTimeLengthChange(Sender: TObject);
begin
  if IsOnChangeEnabled then begin
    LocalSendDataTo(STR_CMD_AUTH_QUERYCOSTTIME_3 + '=/'
        + DateTimeToStr(dtpAddTimeLength.Time), False);
    DoDesignAdd;
  end;
end;

procedure TfrmMain.tmrSafeOpearationTimer(Sender: TObject);
begin
  try
    TSafeStorage.Instance().ExecuteNextOperation;
  except
    on e: Exception do begin
      Debug.Trace0('ExecuteNextOperation error! ' + e.Message);
    end;
  end;

end;

procedure TfrmMain.EnableSafeOperation;
begin
  tmrSafeOpearation.Enabled := True;
end;

procedure TfrmMain._PasswordHotKey;
begin
  if GClientInfo.UnblockedByPassword then
  begin
    BlockedByPassword();
    GCClientWebInterface.ShowMessages('Заблокировано');
  end else begin
    GCClientWebInterface.ShowUnblock;
  end;

end;

procedure TfrmMain.edtLoginKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_RETURN then  edtPassword.SetFocus;
end;

procedure TfrmMain.edtPasswordKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_RETURN then butLogonClick(nil);
end;

procedure TfrmMain.mnuShutdownClick(Sender: TObject);
begin
  WIActionSysShutdown(Sender);
end;

procedure TfrmMain.mnuRebootClick(Sender: TObject);
begin
  WIActionSysReboot(Sender);
end;

procedure TfrmMain.mnuLogoffClick(Sender: TObject);
begin
  WIActionSysLogoff(Sender);
end;

procedure TfrmMain.pnlBlockedClick(Sender: TObject);
begin
//GCClientWebInterface.ReloadSkin;
//Chromium1.Load('http://127.0.0.1:5068/main.html');
end;

procedure TfrmMain.pnlClockClick(Sender: TObject);
begin
  FbShutdownAlt := 1;
end;

procedure TfrmMain.pnlCompNumberClick(Sender: TObject);
begin
  if FbShutdownAlt = 3 then inc(FbShutdownAlt);
end;

procedure TfrmMain.tbCompShutdownClick(Sender: TObject);
begin
  if GClientOptions.ShutdownButton> 0 then
    LocalSendDataTo(STR_CMD_GET_SHUTDOWN + '=' + inttostr(GClientOptions.ShutdownButton), False);
end;

end. ////////////////////////// end of file //////////////////////////////////


