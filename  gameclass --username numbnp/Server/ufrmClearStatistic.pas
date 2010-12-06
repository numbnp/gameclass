unit ufrmClearStatistic;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  ComCtrls,
  ExtCtrls,
  udmMain,
  ADODB;

type
  TfrmClearStatistic = class(TForm)
    cbxLogs: TCheckBox;
    cbxJournalOp: TCheckBox;
    dtpBefore: TDateTimePicker;
    rbtnAll: TRadioButton;
    rbtnBefore: TRadioButton;
    btnClear: TButton;
    cbxSessions: TCheckBox;
    cbxUnControl: TCheckBox;
    cbxHardware: TCheckBox;
    cbxServices: TCheckBox;
    cbxPrinter: TCheckBox;
    cbxAutoUpdate: TCheckBox;
    cbxProcesses: TCheckBox;
    cbxAccountsHistory: TCheckBox;
    pnlWarning: TGroupBox;
    Memo1: TMemo;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    rbtnModeFull: TRadioButton;
    rbtnModeExcludeLastMonth: TRadioButton;
    rbtnModeExcludeLastYear: TRadioButton;
    rbtnModeCustom: TRadioButton;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Panel2: TPanel;
    Panel3: TPanel;
    btnCancel: TButton;
    Panel4: TPanel;
    cmdLogs: TADOCommand;
    lblLogs: TLabel;
    lblJournalOp: TLabel;
    lblSessions: TLabel;
    lblUnControl: TLabel;
    lblHardware: TLabel;
    lblServices: TLabel;
    lblPrinter: TLabel;
    lblAutoUpdate: TLabel;
    lblProcesses: TLabel;
    lblAccountsHistory: TLabel;
    cmdJournalOp: TADOCommand;
    cmdSessions: TADOCommand;
    cmdUnControl: TADOCommand;
    cmdHardware: TADOCommand;
    cmdServices: TADOCommand;
    cmdPrinter: TADOCommand;
    cmdAutoUpdate: TADOCommand;
    cmdProcesses: TADOCommand;
    cmdAccountsHistory: TADOCommand;
    lblInclusive: TLabel;
    cmdShrinkDatabase: TADOCommand;
    cbxShrinkDatabase: TCheckBox;
    lblShrinkDatabase: TLabel;
    cbxRemovedMoney: TCheckBox;
    lblRemovedMoney: TLabel;
    cmdRemovedMoney: TADOCommand;
    procedure btnClearClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure rbtnModeClick(Sender: TObject);
  private
    procedure _TryCommandAndShowResult(
        const AcbxResult: TCheckBox; const AcmdResult: TADOCommand;
        const AlblResult: TLabel);
  public
    { Public declarations }
  end;

var
  frmClearStatistic: TfrmClearStatistic;

implementation

uses
  Math,
  StrUtils,
  gcconst,
  DateUtils,
  gccomputers;

resourcestring
  WARNING = 'Внимание!';
  MESSAGE_STR = 'Сообщение!';
  AFFIRMATION = 'Возможно, Вам стоит еще раз все взвесить, прежде чем выполнять'
      + #13#10'операцию очистки статистики. '
      + ' Вы точно уверены, что хотите это сделать?';
  CLEAR_COMPLETE_BY_USER = 'Статистика была очищена пользователем';
  CLEAR_COMPLETE = 'Статистика очищена!';
{$R *.dfm}

procedure TfrmClearStatistic.btnClearClick(Sender: TObject);
var
  cur: TCursor;
begin
  if Application.MessageBox(PChar(AFFIRMATION), PChar(WARNING),
      MB_YESNO) = IDYES then begin
    cur := Screen.Cursor;
    Screen.Cursor := crHourGlass;
    _TryCommandAndShowResult(cbxLogs, cmdLogs, lblLogs);
    _TryCommandAndShowResult(cbxJournalOp, cmdJournalOp, lblJournalOp);
    _TryCommandAndShowResult(cbxSessions, cmdSessions, lblSessions);
    _TryCommandAndShowResult(cbxRemovedMoney, cmdRemovedMoney, lblRemovedMoney);
    _TryCommandAndShowResult(cbxUnControl, cmdUnControl, lblUnControl);
    _TryCommandAndShowResult(cbxHardware, cmdHardware, lblHardware);
    _TryCommandAndShowResult(cbxServices, cmdServices, lblServices);
    _TryCommandAndShowResult(cbxPrinter, cmdPrinter, lblPrinter);
    _TryCommandAndShowResult(cbxAutoUpdate, cmdAutoUpdate, lblAutoUpdate);
    _TryCommandAndShowResult(cbxProcesses, cmdProcesses, lblProcesses);
    _TryCommandAndShowResult(cbxAccountsHistory, cmdAccountsHistory,
        lblAccountsHistory);
    _TryCommandAndShowResult(cbxShrinkDatabase, cmdShrinkDatabase,
        lblShrinkDatabase);
    Console.AddEvent(EVENT_ICON_INFORMATION, LEVEL_0,
        CLEAR_COMPLETE_BY_USER + ' ' + CurOperatorName);
    Screen.Cursor := cur;
    Application.MessageBox(PChar(CLEAR_COMPLETE), PChar(MESSAGE_STR), MB_OK);
    ModalResult := mrOk;
  end;
end;

procedure TfrmClearStatistic.btnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmClearStatistic.FormCreate(Sender: TObject);
begin
  lblLogs.Visible := False;
  lblJournalOp.Visible := False;
  lblSessions.Visible := False;
  lblRemovedMoney.Visible := False;
  lblUnControl.Visible := False;
  lblHardware.Visible := False;
  lblServices.Visible := False;
  lblPrinter.Visible := False;
  lblAutoUpdate.Visible := False;
  lblProcesses.Visible := False;
  lblAccountsHistory.Visible := False;
  lblShrinkDatabase.Visible := False;
  rbtnModeClick(rbtnModeFull);
end;

procedure TfrmClearStatistic._TryCommandAndShowResult(
    const AcbxResult: TCheckBox; const AcmdResult: TADOCommand;
    const AlblResult: TLabel);
var
  bResult: Boolean;
begin
  if AcbxResult.Checked then begin
    if rbtnAll.Checked then
      AcmdResult.Parameters[0].Value := LAST_DATE
    else if rbtnBefore.Checked then
      AcmdResult.Parameters[0].Value := RecodeTime(dtpBefore.Date,
          23, 59, 59, 99)
    else
      exit;
    try
      AcmdResult.Execute;
      bResult := True;
    except
      bResult := False;
    end;
    AlblResult.Caption := IfThen(bResult, 'Готово', 'Ошибка');
    AlblResult.Font.Color := IfThen(bResult, clGreen, clMaroon);
    AlblResult.Visible := True;
    Application.ProcessMessages;
  end;
end;

procedure TfrmClearStatistic.rbtnModeClick(Sender: TObject);
begin
  if rbtnModeCustom.Checked then begin
    cbxLogs.Enabled := True;
    cbxJournalOp.Enabled := True;
    cbxSessions.Enabled := True;
    cbxRemovedMoney.Enabled := True;
    cbxUnControl.Enabled := True;
    cbxHardware.Enabled := True;
    cbxServices.Enabled := True;
    cbxPrinter.Enabled := True;
    cbxAutoUpdate.Enabled := True;
    cbxProcesses.Enabled := True;
    cbxAccountsHistory.Enabled := True;
    cbxShrinkDatabase.Enabled := True;
    rbtnAll.Enabled := True;
    rbtnBefore.Enabled := True;
    dtpBefore.Enabled := True;
    lblInclusive.Enabled := True;
  end else begin
    cbxLogs.Enabled := False;
    cbxJournalOp.Enabled := False;
    cbxSessions.Enabled := False;
    cbxRemovedMoney.Enabled := False;
    cbxUnControl.Enabled := False;
    cbxHardware.Enabled := False;
    cbxServices.Enabled := False;
    cbxPrinter.Enabled := False;
    cbxAutoUpdate.Enabled := False;
    cbxProcesses.Enabled := False;
    cbxAccountsHistory.Enabled := False;
    cbxShrinkDatabase.Enabled := False;
    rbtnAll.Enabled := False;
    rbtnBefore.Enabled := False;
    dtpBefore.Enabled := False;
    lblInclusive.Enabled := False;
    cbxLogs.Checked := True;
    cbxJournalOp.Checked := True;
    cbxSessions.Checked := True;
    cbxRemovedMoney.Checked := False;
    cbxUnControl.Checked := True;
    cbxHardware.Checked := True;
    cbxServices.Checked := True;
    cbxPrinter.Checked := True;
    cbxAutoUpdate.Checked := False;
    cbxProcesses.Checked := True;
    cbxAccountsHistory.Checked := False;
    cbxShrinkDatabase.Checked := True;
    rbtnAll.Checked := True;
  end;
  if rbtnModeFull.Checked then begin
    rbtnAll.Checked := True;
    cbxRemovedMoney.Checked := True;
  end else if rbtnModeExcludeLastMonth.Checked then begin
    rbtnBefore.Checked := True;
    dtpBefore.DateTime := IncMonth(DateOf(Now), -1);
  end else if rbtnModeExcludeLastYear.Checked then begin
    rbtnBefore.Checked := True;
    dtpBefore.DateTime := EncodeDate(YearOf(Now), 1, 1);
  end;
end;

end.
