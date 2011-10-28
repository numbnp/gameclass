//////////////////////////////////////////////////////////////////////////////
//
// Модуль содержит описание и реализацию класса TSafeStorage.
// Класс предоставляет методы передачи и хранилище данных для межтридового
// обмена данными для приложений gccl и gccllin.
//
// Класс реализован по шаблону Singleton.
// Для доступа к свойствам и методам класса используйте вызовы
// TSafeStorage.Instance."MethodName" или вспомогательную переменную ClientOptions.
//
//////////////////////////////////////////////////////////////////////////////

unit uSafeStorage;

interface

uses
  Classes,
  SyncObjs,
  uY2KCommon;
  // project units
//const
  // значения по умолчанию для опций

type

  TThreadSafeOperation = (
      ThreadSafeOperation_NoOperation = 0,
      ThreadSafeOperation_DoDesign = 1,
      ThreadSafeOperation_UpdateData = 2,
      ThreadSafeOperation_NavigateWebBrousers = 3,
      ThreadSafeOperation_TestBlockingInvalidate = 4,
      ThreadSafeOperation_ReceiveMessage = 5,
      ThreadSafeOperation_ClearMessages = 6,
      ThreadSafeOperation_ActivateTabStartStop = 7,
      ThreadSafeOperation_UpdateTarifs = 8,
      ThreadSafeOperation_RecalcCostTime = 9,
      ThreadSafeOperation_RecalcCostAddTraffic = 10,
      ThreadSafeOperation_RecalcCostAddTime = 11,
      ThreadSafeOperation_UpdateCompNumber = 12,
      ThreadSafeOperation_Destroy = 13,
      ThreadSafeOperation_Blocking = 14,
      ThreadSafeOperation_MainFormAction = 15,
      ThreadSafeOperation_WrongPasswordMessage = 16,
      ThreadSafeOperation_SmallInfoFormAction = 17,
      ThreadSafeOperation_RunPadAction = 18,
      ThreadSafeOperation_CtrAltU = 19,
      ThreadSafeOperation_MinimizeWindows = 20,
      ThreadSafeOperation_OldServerWarning = 21,
      ThreadSafeOperation_UpdateControlFromClientInfo = 22
  );

  TFormAction = (
      FormAction_Show,
      FormAction_Hide,
      FormAction_Update
  );

  TRunPadAction = (
      RunPadAction_HideTabs,
      RunPadAction_RestoreVideoMode,
      RunPadAction_EndVipSession,
      RunPadAction_KillTasks,
      RunPadAction_Logoff,
      RunPadAction_VipLogon,
      RunPadAction_VipLogout
  );

  TBlockingAction = (
      BlockingAction_BlockKeyboard,
      BlockingAction_BlockMouse,
      BlockingAction_UnblockKeyboard,
      BlockingAction_UnblockMouse
  );

  TUpdatedControl = (
      UpdatedControl_cboTarifs,
      UpdatedControl_edtSum,
      UpdatedControl_dtpTime,
      UpdatedControl_edtStart,
      UpdatedControl_edtStop
  );

  TSafeOperation = class(TCollectionItem)
  private
    // SESSION
    FOperation: TThreadSafeOperation;
    FnAction: Integer;
    FstrParameters: String;
    FstrExtendedInfo: String;
    FstrInfo3: String;
    FstrInfo4: String;
    function GetActionAsFormAction: TFormAction;
    procedure SetActionAsFormAction(const AAction: TFormAction);
    function GetActionAsRunPadAction: TRunPadAction;
    procedure SetActionAsRunPadAction(const AAction: TRunPadAction);
    function GetActionAsBlockingAction: TBlockingAction;
    procedure SetActionAsBlockingAction(const AAction: TBlockingAction);
    function GetActionAsUpdatedControl: TUpdatedControl;
    procedure SetActionAsUpdatedControl(const AAction: TUpdatedControl);
  public
    constructor Create; overload;
    constructor Create(
        const AOperation: TThreadSafeOperation;
        const AnAction: Integer = 0;
        const AstrParameters: String = '';
        const AstrExtendedInfo: String = '';
        const AstrInfo3: String = '';
        const AstrInfo4: String = '');overload;

    procedure Update(
        const AnAction: Integer = 0;
        const AstrParameters: String = '';
        const AstrExtendedInfo: String = '';
        const AstrInfo3: String = '';
        const AstrInfo4: String = '');

    property Operation: TThreadSafeOperation
        read FOperation write FOperation;
    property FormAction: TFormAction
        read GetActionAsFormAction write SetActionAsFormAction;
    property RunPadAction: TRunPadAction
        read GetActionAsRunPadAction write SetActionAsRunPadAction;
    property BlockingAction: TBlockingAction
        read GetActionAsBlockingAction write SetActionAsBlockingAction;
    property UpdatedControl: TUpdatedControl
        read GetActionAsUpdatedControl write SetActionAsUpdatedControl;
    property Action: Integer
        read FnAction write FnAction;
    property Parameters: String
        read FstrParameters write FstrParameters;
    property ExtendedInfo: String
        read FstrExtendedInfo write FstrExtendedInfo;
    property Info3: String
        read FstrInfo3 write FstrInfo3;
    property Info4: String
        read FstrInfo4 write FstrInfo4;
  end;

  TSafeStorage = class(TCollection)

  protected
    // constructor / destructor
    constructor CreateInstance();

    // class methods
    class function AccessInstance(
        const ARequest: TSingletonOperation): TSafeStorage;

    // properties methods

  public
    // constructor / destructor
    constructor Create();
    destructor Destroy(); override;

    // methods
    procedure Clear;
    procedure Push(const AOperation: TThreadSafeOperation;
        const AnAction: Integer = 0;
        const AstrParameters: String = '';
        const AstrExtendedInfo: String = '');
    procedure ExecuteNextOperation;
    procedure ExecuteOperation(const AOperation: TSafeOperation);
    function IsIrreplaceableOperation(
        const AOperation: TThreadSafeOperation): Boolean;

    // class methods
    class function Instance(): TSafeStorage;
    class procedure ReleaseInstance();

    function Index(const AOperation: TThreadSafeOperation):Integer;
    function GetItem(Index: Integer): TSafeOperation;
    function GetItemByOperation(
        const AOperation: TThreadSafeOperation): TSafeOperation;
    procedure SetItem(Index: Integer; Value: TSafeOperation);
    procedure DeleteOldDesigned;

    property Items[Index: Integer]:TSafeOperation
        read GetItem write SetItem; default;
  end; // TSafeStorage


var
  GcsAddSafeOperation: TCriticalSection;


implementation

uses
  uDebugLog,
  uCrossPlatformWindow,
  // system units
{$IFDEF MSWINDOWS}
  Windows,
  Forms,
  uRunPadTools,
  Controls,
{$ENDIF}
{$IFDEF LINUX}
  Types,
  Qt,
  QForms,
  QControls,
{$ENDIF}
  DateUtils,
  SysUtils,
  // project units
  uClientConst,
  uClientInfo,
  uClientOptions,
  ufrmMain,
  ufrmSmallInfo,
  uY2KString;

function TSafeOperation.GetActionAsFormAction: TFormAction;
begin
  Result := TFormAction(FnAction);
end;

procedure TSafeOperation.SetActionAsFormAction(const AAction: TFormAction);
begin
  FnAction := Integer(AAction);
end;

function TSafeOperation.GetActionAsRunPadAction: TRunPadAction;
begin
  Result := TRunPadAction(FnAction);
end;

procedure TSafeOperation.SetActionAsRunPadAction(const AAction: TRunPadAction);
begin
  FnAction := Integer(AAction);
end;

function TSafeOperation.GetActionAsBlockingAction: TBlockingAction;
begin
  Result := TBlockingAction(FnAction);
end;

procedure TSafeOperation.SetActionAsBlockingAction(
    const AAction: TBlockingAction);
begin
  FnAction := Integer(AAction);
end;

function TSafeOperation.GetActionAsUpdatedControl: TUpdatedControl;
begin
  Result := TUpdatedControl(FnAction);
end;

procedure TSafeOperation.SetActionAsUpdatedControl(
    const AAction: TUpdatedControl);
begin
  FnAction := Integer(AAction);
end;

constructor TSafeOperation.Create;
begin
  FOperation  := ThreadSafeOperation_NoOperation;
  FnAction := 0;
  FstrParameters := '';
  FstrExtendedInfo := '';
  FstrInfo3 := '';
  FstrInfo4 := '';
end;

constructor TSafeOperation.Create(
    const AOperation: TThreadSafeOperation;
    const AnAction: Integer = 0;
    const AstrParameters: String = '';
    const AstrExtendedInfo: String = '';
    const AstrInfo3: String = '';
    const AstrInfo4: String = '');
begin
  FOperation  := AOperation;
  FnAction := AnAction;
  FstrParameters := AstrParameters;
  FstrExtendedInfo := AstrExtendedInfo;
  FstrInfo3 := AstrInfo3;
  FstrInfo4 := AstrInfo4;
end;

procedure TSafeOperation.Update(
    const AnAction: Integer;
    const AstrParameters: String;
    const AstrExtendedInfo: String;
    const AstrInfo3: String;
    const AstrInfo4: String);
begin
  FnAction := AnAction;
  FstrParameters := AstrParameters;
  FstrExtendedInfo := AstrExtendedInfo;
  FstrInfo3 := AstrInfo3;
  FstrInfo4 := AstrInfo4;
end;
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

// Exceptions: EAssertionFailed
constructor TSafeStorage.Create();
begin
  inherited Create(TSafeOperation);
  Clear;
  ASSERT(FALSE, Format('Access class %s through Instance only', [ClassName]));

end; // TSafeStorage.Create


procedure TSafeStorage.Clear;
begin
end; // TSafeStorage.Clear

constructor TSafeStorage.CreateInstance();
begin
  inherited Create(TSafeOperation);
  Clear;
end; // TSafeStorage.CreateInstance

procedure TSafeStorage.Push(const AOperation: TThreadSafeOperation;
    const AnAction: Integer = 0;
    const AstrParameters: String = '';
    const AstrExtendedInfo: String = '');
var
  operation: TSafeOperation;
begin
  GcsAddSafeOperation.Acquire;
  Debug.Trace5('SafeStorage.Push' + IntToStr(Integer(AOperation)) + '\'
      + IntToStr(Integer(AnAction)) + '\' + AstrParameters);
try
  try
    operation := GetItemByOperation(AOperation);
    if IsIrreplaceableOperation(AOperation)
        or (operation = Nil) then
      operation := TSafeOperation(inherited Add);
    with operation do begin
      Operation := AOperation;
      Action := AnAction;
      Parameters := AstrParameters;
      ExtendedInfo := AstrExtendedInfo;
    end;
  finally
    GcsAddSafeOperation.Release();
  end;
except
  on e: Exception do begin
    Debug.Trace0('afeStorage.Push Error! ' + e.Message);
  end;
end;
end;

procedure TSafeStorage.ExecuteNextOperation;
var
  i: Integer;
  str: String;
  dtStart, dtStop: TDateTime;
  operation: TSafeOperation;
begin
  GcsAddSafeOperation.Acquire;
try
  try
    if Count > 0 then begin
      operation := Items[0];
      ExecuteOperation(operation);
      Delete(0);
    end;
  finally
    GcsAddSafeOperation.Release();
  end;
except
  on e: Exception do begin
    Debug.Trace0('ExecuteNextOperation Error! ' + e.Message);
  end;
end;
end;

procedure TSafeStorage.ExecuteOperation(const AOperation: TSafeOperation);
var
  i: Integer;
  str: String;
  dtStart, dtStop: TDateTime;
begin
  Debug.Trace5('SafeStorage.ExecuteOperation'
      + IntToStr(Integer(AOperation.Operation)) + '\'
      + IntToStr(Integer(AOperation.Action)) + '\' + AOperation.Parameters);
  case AOperation.Operation of
    ThreadSafeOperation_DoDesign: begin
      frmMain.DoDesign;
    end;
    ThreadSafeOperation_UpdateData: begin
      frmMain.UpdateData;
    end;
    ThreadSafeOperation_NavigateWebBrousers: begin
      frmMain.NavigateWebBrousers;
    end;
    ThreadSafeOperation_TestBlockingInvalidate: begin
      frmMain.pnlBlocked.Visible := True;
      if GClientInfo.Blocked then begin
        frmMain.pnlBlocked.Caption := 'BLOCKED'
      end else
        frmMain.pnlBlocked.Caption := 'Unblocked';
    end;
    ThreadSafeOperation_ReceiveMessage: begin
      frmMain.memMessages.Lines.Add(
          GetParamFromString(AOperation.Parameters,0)
           + ': '
          + GetParamFromString(AOperation.Parameters,2));
{$IFDEF MSWINDOWS}
      if not frmMain.Visible then
        frmMain.modernTrayIcon.ShowBalloonHint('Сообщение от '
            + GetParamFromString(AOperation.Parameters,0),
            GetParamFromString(AOperation.Parameters,2), 1000);
{$ENDIF}
    end;
    ThreadSafeOperation_ClearMessages: begin
      frmMain.edtLogin.Text := '';
      frmMain.edtPassword.Text := '';
      frmMain.edtSecCode.Text := '';
      frmMain.memMessages.Lines.Clear;
    end;
    ThreadSafeOperation_ActivateTabStartStop: begin
      frmMain.pcFunctions.ActivePage := frmMain.tabStartStop;
    end;
    ThreadSafeOperation_UpdateTarifs: begin
      if frmMain.IsOnChangeEnabled then begin
        frmMain.DisableOnChange;
        str := frmMain.cboTarifs.Text;
        frmMain.cboTarifs.Clear;
        for i:=0 to GetParamCountFromString(AOperation.Parameters)-1 do
          frmMain.cboTarifs.Items.Add(
              GetParamFromString(AOperation.Parameters,i));
        frmMain.EnableOnChange;
        frmMain.cboTarifs.ItemIndex := frmMain.cboTarifs.Items.IndexOf(str);
        frmMain.cboTarifsChange(Nil);
      end;
    end;
    ThreadSafeOperation_RecalcCostTime: begin
      frmMain.DisableOnChange;
      if Not frmMain.EdtSumFocused then
        frmMain.edtSum.Text := GetParamFromString(AOperation.Parameters,0);
      dtStart := StrToDateTimeDefWithReplace(GetParamFromString(
          AOperation.Parameters, 1));
      dtStop := StrToDateTimeDefWithReplace(GetParamFromString(
          AOperation.Parameters, 2));
      DateTimeToString(str, DATE_FORMAT, dtStart);
      frmMain.edtStart.Text := str;
      DateTimeToString(str, DATE_FORMAT, dtStop);
      frmMain.edtStop.Text := str;
      if Not frmMain.DtpTimeFocused then
        frmMain.dtpTime.Time := TimeOf(dtStop - dtStart);
      if StrToBool(GetParamFromString(AOperation.Parameters, 3)) then begin
        frmMain.edtSum.Enabled := False;
        frmMain.dtpTime.Enabled := False;
      end else begin
        frmMain.edtSum.Enabled := True;
        frmMain.dtpTime.Enabled := True;
      end;
      frmMain.EnableOnChange;
      frmMain.DoDesignStartStop;
    end;
    ThreadSafeOperation_RecalcCostAddTraffic: begin
      frmMain.DisableOnChange;
      if Not frmMain.EdtAddTrafficSumFocused then
        frmMain.edtAddTrafficSum.Text := GetParamFromString(
            AOperation.Parameters,0);
      if Not frmMain.EdtAddTrafficSizeFocused then
        frmMain.edtAddTrafficSize.Text := GetParamFromString(
            AOperation.Parameters,1);
      frmMain.EnableOnChange;
    end;
    ThreadSafeOperation_RecalcCostAddTime: begin
      frmMain.DisableOnChange;
      if Not frmMain.EdtAddTimeSumFocused then
        frmMain.edtAddTimeSum.Text := GetParamFromString(
            AOperation.Parameters,0);
      if Not frmMain.DtpAddTimeLengthFocused then
        frmMain.dtpAddTimeLength.Time := StrToDateTimeDefWithReplace(
            GetParamFromString(AOperation.Parameters,1), 0);
      frmMain.EnableOnChange;
    end;
    ThreadSafeOperation_UpdateCompNumber: begin
      frmMain.pnlCompNumber.Caption := GClientOptions.CompNumber;
    end;
    ThreadSafeOperation_MainFormAction:
      case AOperation.FormAction of
        FormAction_Show:
          if not frmMain.Visible then
            frmMain.Show;
        FormAction_Hide:
          if frmMain.Visible then begin
            frmMain.Hide;
        end;
      end;
    ThreadSafeOperation_SmallInfoFormAction:
      case AOperation.FormAction of
        FormAction_Show: begin
          with GClientInfo do
            frmSmallInfo.UpdateInfo(Start, Stop, NowTime, Internet,
                InternetAvailableInKB, InternetUsedInKB);
          if not frmSmallInfo.Visible then
            frmSmallInfo.Show;
        end;
        FormAction_Hide:
          if frmSmallInfo.Visible then begin
            frmSmallInfo.Hide;
        end;
        FormAction_Update:
          with GClientInfo do
            frmSmallInfo.UpdateInfo(Start, Stop, NowTime, Internet,
                InternetAvailableInKB, InternetUsedInKB);
      end;
    ThreadSafeOperation_WrongPasswordMessage: begin
//      Application.MessageBox(PChar(AOperation.Parameters),'Ошибка');
      frmMain.lblWrongNameOrPassword.Caption := AOperation.Parameters;
      frmMain.lblWrongNameOrPassword.Visible := True;
    end;
    ThreadSafeOperation_RunPadAction: begin
{$IFDEF MSWINDOWS}
      RunPadAction(AOperation.RunPadAction, AOperation.Parameters);
{$ENDIF}
    end;
    ThreadSafeOperation_Blocking: begin
{$IFDEF LINUX}
      frmMain.BlockKeyboardAndMouse(
          (AOperation.BlockingAction = BlockingAction_BlockKeyboard)
          or (AOperation.BlockingAction = BlockingAction_BlockMouse));
{$ENDIF}
    end;
    ThreadSafeOperation_CtrAltU: begin
    end;
    ThreadSafeOperation_MinimizeWindows: begin
      MinimizeWindows;
    end;
    ThreadSafeOperation_OldServerWarning: begin
      case AOperation.FormAction of
        FormAction_Show: begin
          frmMain.tmrOldServerWarningShow.Enabled := True;
        end;
        FormAction_Hide: begin
          frmMain.tmrOldServerWarningShow.Enabled := False;
          frmMain.pnlOldServerWarning.Visible := False;
        end;
      end;
    end;
    ThreadSafeOperation_UpdateControlFromClientInfo: begin
      case AOperation.UpdatedControl of
        UpdatedControl_cboTarifs: begin
          if frmMain.IsOnChangeEnabled then begin
            frmMain.DisableOnChange;
            if frmMain.cboTarifs.Text = GClientInfo.TarifName then begin
              //всё правильно - ничего менять не надо
            end else if frmMain.cboTarifs.Items.IndexOf(
                GClientInfo.TarifName) <> -1 then begin
              //тариф есть в списке но не выбран
              frmMain.cboTarifs.ItemIndex :=
                  frmMain.cboTarifs.Items.IndexOf(GClientInfo.TarifName);
            end else begin
              //тарифа нету, нужно добавить
              frmMain.cboTarifs.Items.Add(GClientInfo.TarifName);
              frmMain.cboTarifs.ItemIndex :=
                  frmMain.cboTarifs.Items.IndexOf(GClientInfo.TarifName);
            end;
            frmMain.EnableOnChange;
          end;
        end;
        UpdatedControl_edtSum: begin
          Debug.Trace5('UpdatedControl_edtSum ');
          if frmMain.IsOnChangeEnabled then begin
            frmMain.DisableOnChange;
            frmMain.edtSum.Text := FloatToStr(GClientInfo.Sum);
            Debug.Trace5('UpdatedControl_edtSum ' + FloatToStr(GClientInfo.Sum));
            frmMain.EnableOnChange;
          end;
        end;
        UpdatedControl_dtpTime: begin
          Debug.Trace5('UpdatedControl_dtpTime ');
          if frmMain.IsOnChangeEnabled then begin
            frmMain.DisableOnChange;
            frmMain.dtpTime.Time := TimeOf(GClientInfo.Stop
                - GClientInfo.Start);
            Debug.Trace5('UpdatedControl_dtpTime ' + TimeToStr(TimeOf(GClientInfo.Stop
                - GClientInfo.Start)));
            frmMain.EnableOnChange;
          end;
        end;
        UpdatedControl_edtStart: begin
          Debug.Trace5('UpdatedControl_edtStart ');
          if frmMain.IsOnChangeEnabled then begin
            frmMain.DisableOnChange;
            DateTimeToString(str, DATE_FORMAT, GClientInfo.Start);
            frmMain.edtStart.Text := str;
            Debug.Trace5('UpdatedControl_edtSum ' + str);
          frmMain.EnableOnChange;
          end;
        end;
        UpdatedControl_edtStop: begin
          Debug.Trace5('UpdatedControl_edtStop ');
          if frmMain.IsOnChangeEnabled then begin
            frmMain.DisableOnChange;
            DateTimeToString(str, DATE_FORMAT, GClientInfo.Stop);
            frmMain.edtStop.Text := str;
            Debug.Trace5('UpdatedControl_edtSum ' + str);
            frmMain.EnableOnChange;
          end;
        end;
      end;
    end;
  end;
end;


destructor TSafeStorage.Destroy();
begin
  if AccessInstance(SinglOper_Access) = Self then begin
    AccessInstance(SinglOper_Destroy);
  end;

  inherited Destroy();
end; // TSafeStorage.Destroy


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// class methods

class function TSafeStorage.AccessInstance(
    const ARequest: TSingletonOperation): TSafeStorage;
// Константа используется для хранения ссылки на единственный
// экземпляр класса. Такая реализация обусловлена отсутсвием
// в классах Delphi статических полей.
// ВНИМАНИЕ! Для корректной работы необходимо включить {$WRITEABLECONST ON}!
{$WRITEABLECONST ON}
const
  FInstance: TSafeStorage = nil;
begin
  case ARequest of
    SinglOper_Access: begin
      // do nothing
    end;

    SinglOper_Create: begin
      if not Assigned(FInstance) then begin
      GcsAddSafeOperation := TCriticalSection.Create();
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
end; // TSafeStorage.AccessInstance


class function TSafeStorage.Instance(): TSafeStorage;
const
  FInstance: TSafeStorage = nil;
begin
  Result := AccessInstance(SinglOper_Create);
end; // TSafeStorage.Instance


class procedure TSafeStorage.ReleaseInstance();
begin
  AccessInstance(SinglOper_Access).Free();
end; // TSafeStorage.ReleaseInstance


function TSafeStorage.Index(const AOperation: TThreadSafeOperation): Integer;
var
  i : Integer;
begin
  Result := -1;
  for i := 0 to Count-1 do
    if Items[i].FOperation = AOperation then
      Result := i;
end;

function TSafeStorage.GetItem(Index: Integer): TSafeOperation;
begin
  Result := TSafeOperation(inherited Items[Index]);
end;

function TSafeStorage.GetItemByOperation(
    const AOperation: TThreadSafeOperation): TSafeOperation;
var
  nIndex: Integer;
begin
  Result := Nil;
  nIndex := Index(AOperation);
  if (nIndex <> -1) then
    Result := TSafeOperation(inherited Items[nIndex]);
end;

procedure TSafeStorage.SetItem(Index: Integer; Value: TSafeOperation);
begin
  Items[Index].Assign(Value);
end;

procedure TSafeStorage.DeleteOldDesigned;
var
  i: Integer;
begin
{  for i := Count - 1 downto 0  do
    if (Items[i].Status = ssDesigned) and not Items[i].Reloaded then
      Delete(i);
}
end;

function TSafeStorage.IsIrreplaceableOperation(
   const AOperation: TThreadSafeOperation): Boolean;
begin
  Result := AOperation in [ThreadSafeOperation_ReceiveMessage,
      ThreadSafeOperation_WrongPasswordMessage,
      ThreadSafeOperation_UpdateControlFromClientInfo];
end;

initialization

finalization
  TSafeStorage.ReleaseInstance();
  GcsAddSafeOperation.Free();

end.


