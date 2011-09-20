////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Главная форма клиентского приложения GameClass.
//
//////////////////////////////////////////////////////////////////////////////

unit ufrmMain;
                         
interface                                                     

uses
{$IFDEF MSWINDOWS}
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
  ToolEdit,
  CurrEdit,
  ieConst,
  IEDocHostUIHandler,
  Menus,
  uModernTrayIcon,
{$ENDIF}
{$IFDEF LINUX}
  Xlib,
  Qt,
  QForms,
  QDialogs,
  QStdCtrls,
  QControls,
  QTypes,
  QExtCtrls,
  QMask,
  uDateTimePicker,
  uCurrencyEdit,
  QComCtrls,
  uWebBrowser,
uCrossPlatformBlocking,
uCrossPlatformVKCodes,  
{$ENDIF}
  uSafeStorage,
  SysUtils,
  Variants,
  Classes,
  Types,
  // system units
  uBlockingsAndNotifications,
  uClientConst,
  ufrmSmallInfo;

type                               

  //
  // TformMain
  //

  TfrmMain = class(TForm)
    pnlTop: TPanel;
    pnlCompNumber: TPanel;
    pnlScreenLogin: TPanel;
{$IFDEF MSWINDOWS}
    modernTrayIcon: TModernTrayIcon;
{$ENDIF}
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
    edtSum: TCurrencyEdit;
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
    edtAddTrafficSum: TCurrencyEdit;
    edtAddTrafficSize: TCurrencyEdit;
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
    edtAddTimeSum: TCurrencyEdit;
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
    Label1: TLabel;
    edtUnblockPassword: TEdit;
    lblWrongUnblockPassword: TLabel;
    btnUnblock: TButton;
    btnBlock: TButton;
    tmrUnblockByPasswordHide: TTimer;
    pnlUnblockByPassword: TPanel;
    btnUnblockCancel: TButton;
    pnlChangePassword: TPanel;
    lblChangePasswordError: TLabel;
    lblOldPass: TLabel;
    lblNewPass: TLabel;
    lblRepeat: TLabel;
    editOldPass: TEdit;
    editNewPass: TEdit;
    editRepeat: TEdit;
    btnChangePasswordOk: TButton;
    btnChangePasswordCancel: TButton;
    tmrChangePasswordHide: TTimer;
    pnlOldServerWarning: TPanel;
    lblWarning: TLabel;
    tmrOldServerWarningShow: TTimer;
    Label2: TLabel;
    Label3: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure btnSendMessageClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure modernTrayIconDblClick(Sender: TObject);
    procedure butLogonClick(Sender: TObject);
    procedure butAgreeClick(Sender: TObject);
    procedure butNotAgreeClick(Sender: TObject);
    procedure butLogoffClick(Sender: TObject);
    procedure butChangePassClick(Sender: TObject);
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
{$IFDEF MSWINDOWS}
    procedure wbAccountNavigateComplete2(Sender: TObject;
      const pDisp: IDispatch; var URL: OleVariant);
    procedure wbAccountCompFreeNavigateComplete2(Sender: TObject;
      const pDisp: IDispatch; var URL: OleVariant);
    procedure wbTopNavigateComplete2(Sender: TObject;
      const pDisp: IDispatch; var URL: OleVariant);
    procedure wbAgreementNavigateComplete2(Sender: TObject;
      const pDisp: IDispatch; var URL: OleVariant);
    procedure wbCompFreeNavigateComplete2(Sender: TObject;
      const pDisp: IDispatch; var URL: OleVariant);
{$ENDIF}
    procedure btnGuestClick(Sender: TObject);
    procedure btnAddTimeClick(Sender: TObject);
    procedure edtAddTimeSumEnter(Sender: TObject);
    procedure edtAddTimeSumExit(Sender: TObject);
    procedure dtpAddTimeLengthEnter(Sender: TObject);
    procedure dtpAddTimeLengthExit(Sender: TObject);
    procedure edtAddTimeSumChange(Sender: TObject);
    procedure dtpAddTimeLengthChange(Sender: TObject);
    procedure tmrSafeOpearationTimer(Sender: TObject);
    procedure tmrUnblockByPasswordHideTimer(Sender: TObject);
    procedure btnUnblockClick(Sender: TObject);
    procedure btnBlockClick(Sender: TObject);
    procedure btnUnblockCancelClick(Sender: TObject);
    procedure tmrChangePasswordHideTimer(Sender: TObject);
    procedure editNewPassChange(Sender: TObject);
    procedure btnChangePasswordOkClick(Sender: TObject);
    procedure btnChangePasswordCancelClick(Sender: TObject);
    procedure tmrOldServerWarningShowTimer(Sender: TObject);
    procedure edtLoginKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtPasswordKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure editOldPassKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure editNewPassKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure editRepeatKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
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
{$IFDEF LINUX}
    FbBlocked: Boolean;
{$ENDIF}
  protected
    procedure _PasswordHotKey;
    procedure _ChangePasswordHide;
  public
    { Public declarations }
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

{$IFDEF MSWINDOWS}
    procedure ActivateInfo(var Message: TMessage);
        message WM_USER_ACTIVATE_INFO;
    procedure HotKey(var Message: TMessage);
        message WM_HOTKEY;
{$ENDIF}
{$IFDEF LINUX}
    procedure BlockKeyboardAndMouse(AbLock: Boolean);
{$ENDIF}
    procedure EnableSafeOperation;

  end;        // TformMain

var
  frmMain: TfrmMain;
{$IFDEF MSWINDOWS}
  GDocHostUIHandler: TDocHostUIHandler;
{$ENDIF}

implementation
{$IFDEF MSWINDOWS}
  {$R *.dfm}
{$ENDIF}
{$IFDEF LINUX}
  {$R *.xfm}
{$ENDIF}

uses
{$IFDEF MSWINDOWS}
  ActiveX,
  uRunPadTools,
  uClientInstallDirectory,
{$ENDIF}
{$IFDEF LINUX}
  QGraphics,
{$ENDIF}
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
  uCoder;

const
  DATE_FORMAT = 'dd mmm yy hh:mm:ss';
  MSG_ENTER_PASSWORD: AnsiString = 'Введите пароль разблокирования';
  MSG_UNBLOCKED: AnsiString = 'Компьютер разблокирован!';
  MSG_UNBLOCK_PASSWORD_NEEDED: AnsiString =
      'Нужно ввести пароль разблокирования!';
  MSG_UNBLOCK_BY_PASSWORD_DISABLED: AnsiString =
      'Разблокирование по паролю отключено!';
procedure TfrmMain.Show;
begin
  Debug.Trace5('Show 0');
  if FbBeforeFirstFormShow then begin
    Debug.Trace5('Show 1');
    FbBeforeFirstFormShow := False;
{$IFDEF LINUX}
    Application.NormalizeTopMosts;
    FormStyle := fsStayOnTop;
{$ENDIF}
  end;
 // Изза Position не работает WebBrouser
 // Position := poScreenCenter;
//  Left := (GetSystemMetrics(SM_CXFULLSCREEN) - Width) div 2;
//  Top := (GetSystemMetrics(SM_CYFULLSCREEN) - Height) div 2;
  Left := (Screen.Width - Width) div 2;
  Top := (Screen.Height - Height) div 2;
  inherited Show;
{$IFDEF MSWINDOWS}
  ShowWindow(Application.Handle,SW_HIDE);  // Скрываем программу в таскбаре
{$ENDIF}
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
//    Left := GetSystemMetrics(SM_CXSCREEN);
    Left := Screen.Width;
    inherited Show;
{$IFDEF MSWINDOWS}
    ShowWindow(Application.Handle,SW_HIDE);  // Скрываем программу в таскбаре
{$ENDIF}
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
  //SendDataTo('v01.'+STR_CMD_SENDMESSAGE+'=a/b/'+edtMessage.Text,False);
  memMessages.Lines.Add(GClientInfo.Login + ': ' + edtMessage.Text);
  strSendData := STR_CMD_SENDMESSAGE + '=//' + edtMessage.Text;
  LocalSendDataTo(strSendData,False);
  edtMessage.Text := '';
end;

{$IFDEF MSWINDOWS}
procedure TfrmMain.ActivateInfo(var Message: TMessage);
begin
  TSafeStorage.Instance().Push(ThreadSafeOperation_MainFormAction,
      Integer(FormAction_Show));
end;
{$ENDIF}

{$IFDEF MSWINDOWS}
procedure TfrmMain.HotKey(var Message: TMessage);
begin
  GClientInfo.LastKeyDown := Now;
  if Message.LParam = MakeLong(MOD_ALT or MOD_CONTROL or MOD_SHIFT, $49{I}) then
    TSafeStorage.Instance().Push(ThreadSafeOperation_MainFormAction,
        Integer(FormAction_Show));
  if (Message.LParam = MakeLong(MOD_ALT or MOD_CONTROL, $55{U})) then
      _PasswordHotKey;
end;
{$ENDIF}


procedure TfrmMain.NavigateWebBrousers;
begin
{$IFDEF LINUX}
  wbTop.Picture.LoadFromFile(
      FstrURLPath + 'Top.bmp');
  wbAgreement.Picture.LoadFromFile(
      FstrURLPath + 'Agreement.bmp');
  wbCompFree.Picture.LoadFromFile(
      FstrURLPath + 'CompFree.bmp');
  wbAccountCompFree.Picture.LoadFromFile(
      FstrURLPath + 'AccountCompFree.bmp');
  wbAccount.Picture.LoadFromFile(
      FstrURLPath + 'Account.bmp');
{$ENDIF}
{$IFDEF MSWINDOWS}
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

  wbTop.Enabled := False;
  wbAgreement.Enabled := False;
  wbCompFree.Enabled := False;
  wbAccountCompFree.Enabled := False;
  wbAccount.Enabled := False;
{$ENDIF}
end;

procedure TfrmMain.UpdateData;
begin
  FbOnChangeEnabled := False;
  lblLoggedAs.Caption := GClientInfo.Login;
  lblBalance.Caption := FloatToStr(GClientInfo.Balance);
  memInfo.Text := GClientInfo.FullInfo;
  memBalanceHistory.Text := GClientInfo.BalanceHistory;
  FbOnChangeEnabled := True;
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
  Debug.Trace5('DoDesign 2');
  Debug.Trace5('DoDesign State' + IntToStr(Integer(GClientInfo.ClientState)));
  case GClientInfo.ClientState of
    ClientState_Blocked: pgctrlMain.ActivePage := tabScreenCompFree;
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
    end;
    ClientState_Order: begin
      pgctrlMain.ActivePage := tabScreenClientInfo;
      pnlClientInfoAccount.Visible := True;
      tabAccountInfo.TabVisible := True;
      tabStartStop.TabVisible := True;
      tabSendMess.TabVisible := True;
      tabAccountInfo.TabVisible := True;
      cboTarifs.Enabled := True;
      DoDesignStartStop;
    end;
    ClientState_Session: begin
      pgctrlMain.ActivePage := tabScreenClientInfo;
      tabAccountInfo.TabVisible := True;
      tabAdd.TabVisible := True;
      gbTraffic.Visible := GClientInfo.TrafficSeparatePayment;
      tabStartStop.TabVisible := True;
      pnlClientInfoAccount.Visible := True;
      btnSessionStart.Enabled := False;
      btnSessionStop.Enabled := True;
      edtSum.Enabled := False;
      dtpTime.Enabled := False;
      cboTarifs.Enabled := False;
    end;
    ClientState_Agreement: begin
      pgctrlMain.ActivePage := tabScreenAgreement;
      butNotAgree.Enabled := True;
    end;
    ClientState_OperatorSession: begin
      pgctrlMain.ActivePage := tabScreenClientInfo;
      pnlClientInfoAccount.Visible := False;
      tabAccountInfo.TabVisible := False;
      tabStartStop.TabVisible := False;
      tabAdd.TabVisible := False;
    end;
    ClientState_OperatorAgreement: begin
      pgctrlMain.ActivePage := tabScreenAgreement;
      butNotAgree.Enabled := False;
    end;
  end;
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
      and (fSum > 0) and (fSum <= GClientInfo.Balance
      - GClientInfo.BalanceLimit);
//  edtSum.E
  btnSessionStop.Enabled := False;
  tabAdd.TabVisible := False;
  if (Length(cboTarifs.Text)=0) then begin
    edtSum.Enabled := False;
    dtpTime.Enabled := False;
  end;
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
  EnableOnChange;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var                                       
  size: TSize;
begin
  //PixelsPerInch := Screen.PixelsPerInch;
//  PixelsPerInch := 75;
{$IFDEF LINUX}
  FbBlocked := False;
  QWidget_size(Handle, @size);
  QWidget_setBaseSize(Handle, @size);
  QWidget_setFixedSize(Handle, @size);
{$ENDIF}
  FbBeforeFirstFormShow := True;
  FbAfterFirstFormShow := False;
{$IFDEF MSWINDOWS}
  GDocHostUIHandler := TDocHostUIHandler.Create;
{$ENDIF}
  FbOnChangeEnabled := True;
{$IFDEF MSWINDOWS}
  FstrURLPath := InstallDirectory + '\Skins\';
{$ENDIF}
{$IFDEF LINUX}
  FstrURLPath := ExtractFilePath(ParamStr(0)) + '/Skins/';
{$ENDIF}
{$IFDEF MSWINDOWS}
  LocalSendDataTo(STR_CMD_OPTION_GET+'=all',False);
  LocalSendDataTo(STR_CMD_CLIENT_INFO_GET+'=all',False);
{$ENDIF}
//{$IFDEF LINUX}                    Убираем всякие триалы
//  if YearOf(Now) > 2009 then      Из-за этого я ломал голову 2 дня
//    Application.Terminate;
//{$ENDIF}
  TSafeStorage.Instance().Push(ThreadSafeOperation_UpdateCompNumber, 0);
{$IFDEF MSWINDOWS}
  TSafeStorage.Instance().Push(ThreadSafeOperation_RunPadAction,
      Integer(RunPadAction_HideTabs));
{$ENDIF}
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
var
  bUnblockPassword: Boolean;
  bUnblockedByPassword: Boolean;
begin
  lblWrongNameOrPassword.Visible := False;
  LocalSendDataTo(STR_CMD_AUTH_QUERYSTATE_2 + '=' + edtLogin.Text
      + '/' + edtPassword.Text + '/' + edtSecCode.Text, False);
{$IFDEF MSWINDOWS}
  if (GClientOptions.ShellMode = ShellMode_Runpad) then begin
    TSafeStorage.Instance().Push(ThreadSafeOperation_RunPadAction,
        Integer(RunPadAction_VipLogon), edtLogin.Text + '/'
        + edtPassword.Text);
  end;
{$ENDIF}
end;

procedure TfrmMain.butAgreeClick(Sender: TObject);
begin
  case GClientInfo.ClientState of
    ClientState_Agreement: begin
      // принимаем соглашение - шлем ClientState_AgreementAccepted
      LocalSendDataTo(STR_CMD_CLIENT_INFO_SET +'=ClientState/'
          + IntToStr(Integer(ClientState_AgreementAccepted)),False);
      Hide;
    end;
    ClientState_OperatorAgreement: begin
      // принимаем соглашение - шлем ClientState_OperatorAgreementAccepted
      LocalSendDataTo(STR_CMD_CLIENT_INFO_SET +'=ClientState/'
      + IntToStr(Integer(ClientState_OperatorAgreementAccepted)), False);
    end;
  end;
end;

procedure TfrmMain.butNotAgreeClick(Sender: TObject);
begin
  LocalSendDataTo(STR_CMD_AUTH_QUERYSTOP_3, False);
end;

procedure TfrmMain.butLogoffClick(Sender: TObject);
begin
  memMessages.Lines.Clear;
  edtLogin.Text := '';
  edtPassword.Text := '';
  edtSecCode.Text := '';
  LocalSendDataTo(STR_CMD_AUTH_QUERYLOGOFF, False);
{  SendMessage(frmMain.Handle,WM_USER_THREADSAFE_UPDATE,
      lParam(ThreadSafeOperation_RunPadAction),
      wParam(RunPadAction_EndVipSession));}
{$IFDEF MSWINDOWS}
  if (GClientOptions.ShellMode = ShellMode_Runpad) then begin
    TSafeStorage.Instance().Push(ThreadSafeOperation_RunPadAction,
        Integer(RunPadAction_VipLogout));
  end;
{$ENDIF}
end;

procedure TfrmMain.butChangePassClick(Sender: TObject);
begin
  pnlChangePassword.Visible := True;
  tmrChangePasswordHide.Enabled := True;
end;

procedure TfrmMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  GClientInfo.LastKeyDown := Now;
{$IFDEF MSWINDOWS}
  if (Key = VK_ESCAPE)
{$ENDIF}
{$IFDEF LINUX}
  if (Key = Key_Escape)
{$ENDIF}
      and Visible and not GClientInfo.ResultBlocking then
    Hide;
{$IFDEF MSWINDOWS}
  if not (ssShift in Shift)
      and (ssAlt in Shift)
      and (ssCtrl in Shift)
      and (Key = $55{U}) then begin
{$ENDIF}
{$IFDEF LINUX}
  if not (ssShift in Shift)
      and (ssAlt in Shift)
      and (ssCtrl in Shift)
      and (Key = Key_U) then begin
{$ENDIF}
    _PasswordHotKey;
  end;
end;

procedure TfrmMain.cboTarifsChange(Sender: TObject);
begin
  if IsOnChangeEnabled then begin
    edtSum.Text := '1,00';
    dtpTime.Time := FIRST_DATE; // 01.01.2000 0:00:00
    DoDesignStartStop;
    edtSumChange(Sender); //Отослать сумму, чтобы узнать пакетность
  end;
end;

procedure TfrmMain.edtSumChange(Sender: TObject);
begin
  if IsOnChangeEnabled then begin
    LocalSendDataTo(STR_CMD_AUTH_QUERYCOSTTIME_2 + '=' + cboTarifs.Text + '/'
        + edtSum.Text + '/',False);
    DoDesignStartStop;
  end;
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
  LocalSendDataTo(STR_CMD_AUTH_QUERYSTATE_3 + '=' + cboTarifs.Text + '/'
      + edtSum.Text ,False);
end;

procedure TfrmMain.btnSessionStopClick(Sender: TObject);
begin
  LocalSendDataTo(STR_CMD_AUTH_QUERYSTOP_3, False);
end;

procedure TfrmMain.edtAddTrafficSumChange(Sender: TObject);
begin
  if IsOnChangeEnabled then begin
    LocalSendDataTo(STR_CMD_AUTH_QUERYCOSTTRAFFIC_3 + '=' + edtAddTrafficSum.Text
       + '/',False);
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
    LocalSendDataTo(STR_CMD_AUTH_ADDTRAFFIC_3 + '=' + edtAddTrafficSum.Text,
       False);
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
{$IFDEF LINUX}
{$ENDIF}
{$IFDEF MSWINDOWS}
  GDocHostUIHandler.Free;
{$ENDIF}
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


{$IFDEF MSWINDOWS}
procedure TfrmMain.wbAccountNavigateComplete2(Sender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
var
  hr: HResult;
  CustDoc: ICustomDoc;
begin
  hr := wbAccount.Document.QueryInterface(ICustomDoc, CustDoc);
  if hr = S_OK then CustDoc.SetUIHandler(GDocHostUIHandler);
end;

procedure TfrmMain.wbAccountCompFreeNavigateComplete2(Sender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
var
  hr: HResult;
  CustDoc: ICustomDoc;
begin
  hr := wbAccountCompFree.Document.QueryInterface(ICustomDoc, CustDoc);
  if hr = S_OK then CustDoc.SetUIHandler(GDocHostUIHandler);
end;

procedure TfrmMain.wbTopNavigateComplete2(Sender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
var
  hr: HResult;
  CustDoc: ICustomDoc;
begin
  hr := wbTop.Document.QueryInterface(ICustomDoc, CustDoc);
  if hr = S_OK then CustDoc.SetUIHandler(GDocHostUIHandler);
end;

procedure TfrmMain.wbAgreementNavigateComplete2(Sender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
var
  hr: HResult;
  CustDoc: ICustomDoc;
begin
  hr := wbAgreement.Document.QueryInterface(ICustomDoc, CustDoc);
  if hr = S_OK then CustDoc.SetUIHandler(GDocHostUIHandler);
end;

procedure TfrmMain.wbCompFreeNavigateComplete2(Sender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
var
  hr: HResult;
  CustDoc: ICustomDoc;
begin
  hr := wbCompFree.Document.QueryInterface(ICustomDoc, CustDoc);
  if hr = S_OK then CustDoc.SetUIHandler(GDocHostUIHandler);
end;
{$ENDIF}

procedure TfrmMain.btnGuestClick(Sender: TObject);
begin
  lblWrongNameOrPassword.Visible := False;
  LocalSendDataTo(STR_CMD_GUESTSESSION, False);
end;

procedure TfrmMain.btnAddTimeClick(Sender: TObject);
begin
  if IsOnChangeEnabled then begin
    FbOnChangeEnabled := False;
    LocalSendDataTo(STR_CMD_AUTH_ADDTIME_3 + '=' + edtAddTimeSum.Text,
       False);
    btnAddTime.Enabled := False;
    edtAddTimeSum.Enabled := False;
    dtpAddTimeLength.Enabled := False;
    edtAddTimeSum.Text := '0';
    dtpAddTimeLength.Time := 0;
    FbOnChangeEnabled := True;
  end;
end;

procedure TfrmMain.edtAddTimeSumChange(Sender: TObject);
begin
  if IsOnChangeEnabled then begin
    LocalSendDataTo(STR_CMD_AUTH_QUERYCOSTTIME_3 + '=' + edtAddTimeSum.Text
       + '/', False);
    DoDesignAdd;
  end;
end;

procedure TfrmMain.dtpAddTimeLengthChange(Sender: TObject);
begin
  if IsOnChangeEnabled then begin
    LocalSendDataTo(STR_CMD_AUTH_QUERYCOSTTIME_3 + '=/'
        + DateTimeToStr(dtpAddTimeLength.Time), False);
    DoDesignAdd;
  end;
end;

{$IFDEF LINUX}
procedure TfrmMain.BlockKeyboardAndMouse(AbLock: Boolean);
var
  event: XEvent;
  nThreadId: cardinal;
  wndMain : TWindow;
begin
  FbBlocked := AbLock;
  if AbLock then begin
    wndMain := QWidget_WinID(QApplication_desktop);
    XGrabPointer(Application.Display, wndMain,
        XTrue,
        ButtonPressMask or ButtonReleaseMask or PointerMotionMask,
        GrabModeAsync,
        GrabModeAsync, None, None, CurrentTime);
    XGrabKeyboard(Application.Display,
        wndMain,
        XTrue,
        GrabModeAsync, GrabModeAsync, CurrentTime);
  end else begin
    XUngrabPointer(Application.Display, CurrentTime);
    XUngrabKeyboard(Application.Display, CurrentTime);
  end;
end;
{$ENDIF}


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

procedure TfrmMain.tmrUnblockByPasswordHideTimer(Sender: TObject);
begin
  tmrUnblockByPasswordHide.Enabled := False;
  pnlUnblockByPassword.Visible := False;
end;

procedure TfrmMain.btnUnblockClick(Sender: TObject);
var
  Fcoder : TCoder;
  bUnblockedByPassword: Boolean;
  strPassword: String;
begin
  if GClientOptions.UnblockPassword and btnUnblock.Enabled then begin
    bUnblockedByPassword := False;
    try
      Fcoder := TCoder.Create;
      strPassword := edtUnblockPassword.Text;
      bUnblockedByPassword := (GClientOptions.UnblockPasswordHash =
          FCoder.SimpleEncodeString(PChar(strPassword)));
      FCoder.Free;
    except
      on e: Exception do begin
        Debug.Trace0('2 error! ' + e.Message);
      end;
    end;
    edtUnblockPassword.Text := '';
    if bUnblockedByPassword then begin
      btnUnblock.Enabled := False;
      btnBlock.Enabled := True;
      lblWrongUnblockPassword.Caption := MSG_UNBLOCKED;
      lblWrongUnblockPassword.Font.Color := clGreen;
      GClientInfo.UnblockedByPassword := True;
      pnlUnblockByPassword.Visible := False;
     end else begin
      lblWrongUnblockPassword.Caption := MSG_UNBLOCK_PASSWORD_NEEDED;
      lblWrongUnblockPassword.Font.Color := clRed;
      GClientInfo.UnblockedByPassword := False;
     end;
{$IFDEF MSWINDOWS}
      //надо поменять на SetUnblockedByPassword
      LocalSendDataTo(STR_CMD_CLIENT_INFO_SET+'=UnblockedByPassword/'
          + BoolToStr(GClientInfo.UnblockedByPassword), False);
{$ENDIF}
  end;
end;

procedure TfrmMain.btnBlockClick(Sender: TObject);
begin
  if GClientOptions.UnblockPassword and btnBlock.Enabled then begin
    btnUnblock.Enabled := True;
    btnBlock.Enabled := False;
    lblWrongUnblockPassword.Caption := MSG_UNBLOCK_BY_PASSWORD_DISABLED;
    lblWrongUnblockPassword.Font.Color := clGreen;
    GClientInfo.UnblockedByPassword := False;
{$IFDEF MSWINDOWS}
    //надо поменять на SetUnblockedByPassword
    LocalSendDataTo(STR_CMD_CLIENT_INFO_SET+'=UnblockedByPassword/'
        + BoolToStr(GClientInfo.UnblockedByPassword), False);
{$ENDIF}
    pnlUnblockByPassword.Visible := False;
  end;
end;

procedure TfrmMain.btnUnblockCancelClick(Sender: TObject);
begin
  pnlUnblockByPassword.Visible := False;
end;

procedure TfrmMain.EnableSafeOperation;
begin
  tmrSafeOpearation.Enabled := True;
end;

procedure TfrmMain._ChangePasswordHide;
begin
  tmrChangePasswordHide.Enabled := False;
  pnlChangePassword.Visible := False;
end;

procedure TfrmMain.tmrChangePasswordHideTimer(Sender: TObject);
begin
  _ChangePasswordHide;
end;

procedure TfrmMain.editNewPassChange(Sender: TObject);
begin
   if (editNewPass.Text <> editRepeat.Text) then
      btnChangePasswordOk.Enabled := False
   else
      btnChangePasswordOk.Enabled := True;
end;

procedure TfrmMain.btnChangePasswordOkClick(Sender: TObject);
begin
  LocalSendDataTo(STR_CMD_AUTH_QUERYCHANGEPASS + '='
      + editOldPass.Text+'/'+editNewPass.Text,
      False);
  editNewPass.Text := '';
  editOldPass.Text := '';
  editRepeat.Text := '';
  _ChangePasswordHide;
end;

procedure TfrmMain.btnChangePasswordCancelClick(Sender: TObject);
begin
  _ChangePasswordHide;
end;

procedure TfrmMain.tmrOldServerWarningShowTimer(Sender: TObject);
begin
  pnlOldServerWarning.Visible := True;
end;

procedure TfrmMain._PasswordHotKey;
begin
  if GClientInfo.UnblockedByPassword then
    lblWrongUnblockPassword.Caption := ''
  else
    lblWrongUnblockPassword.Caption := MSG_ENTER_PASSWORD;
  lblWrongUnblockPassword.Font.Color := clWindowText;
  edtUnblockPassword.Text := '';
  pnlUnblockByPassword.Visible := True;
  tmrUnblockByPasswordHide.Enabled := True;
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

procedure TfrmMain.editOldPassKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_RETURN then  editNewPass.SetFocus;
  if key = VK_ESCAPE then  btnChangePasswordCancelClick(nil);
end;

procedure TfrmMain.editNewPassKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_RETURN then  editRepeat.SetFocus;
  if key = VK_ESCAPE then  btnChangePasswordCancelClick(nil);
end;

procedure TfrmMain.editRepeatKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_RETURN then btnChangePasswordOkClick(nil);
  if key = VK_ESCAPE then  btnChangePasswordCancelClick(nil);
end;

end. ////////////////////////// end of file //////////////////////////////////


