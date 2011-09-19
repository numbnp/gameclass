unit frmCompAdd;

interface

uses
  GCLangUtils, GCComputers, GCCommon,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Menus, GCSessions, Mask, ToolEdit,
  CurrEdit, Grids,
  ufrmComputers;

type
  TFormCompAddState = (casMoney, casSummaryMoney, casTimeLength, casEndTime,
      casSummaryEndTime);

  TformCompAdd = class(TForm)
    btnOk: TButton;
    btnCancel: TButton;
    tmrCheck: TTimer;
    popupTimeLengthHours: TPopupMenu;
    hour1: TMenuItem;
    hour2: TMenuItem;
    hour3: TMenuItem;
    hour4: TMenuItem;
    hour5: TMenuItem;
    hour6: TMenuItem;
    hour7: TMenuItem;
    popupTimeLengthMinuts: TPopupMenu;
    min10: TMenuItem;
    min15: TMenuItem;
    min20: TMenuItem;
    min25: TMenuItem;
    min30: TMenuItem;
    min35: TMenuItem;
    min40: TMenuItem;
    min45: TMenuItem;
    min50: TMenuItem;
    min55: TMenuItem;
    popupEndTimeHours: TPopupMenu;
    hours0: TMenuItem;
    hours1: TMenuItem;
    hours2: TMenuItem;
    hours3: TMenuItem;
    hours4: TMenuItem;
    hours5: TMenuItem;
    hours6: TMenuItem;
    hours7: TMenuItem;
    hours8: TMenuItem;
    hours9: TMenuItem;
    hours10: TMenuItem;
    hours11: TMenuItem;
    hours12: TMenuItem;
    hours13: TMenuItem;
    hours14: TMenuItem;
    hours15: TMenuItem;
    hours16: TMenuItem;
    hours17: TMenuItem;
    hours18: TMenuItem;
    hours19: TMenuItem;
    hours20: TMenuItem;
    hours21: TMenuItem;
    hours22: TMenuItem;
    hours23: TMenuItem;
    popupEndTimeMinuts: TPopupMenu;
    EndTimeMinuts10: TMenuItem;
    EndTimeMinuts15: TMenuItem;
    EndTimeMinuts20: TMenuItem;
    EndTimeMinuts25: TMenuItem;
    EndTimeMinuts30: TMenuItem;
    EndTimeMinuts35: TMenuItem;
    EndTimeMinuts40: TMenuItem;
    EndTimeMinuts45: TMenuItem;
    EndTimeMinuts50: TMenuItem;
    EndTimeMinuts55: TMenuItem;
    pnlComputers: TPanel;
    pnlMoney: TPanel;
    gbMoneyTimeLength: TGroupBox;
    pnlTotalCost: TPanel;
    lblTotalCost: TLabel;
    edtTotalCost: TCurrencyEdit;
    pnlCost: TPanel;
    lblSumma: TLabel;
    edtMoney: TCurrencyEdit;
    pnlTimeLength: TPanel;
    lblTimeLength: TLabel;
    butTimeLengthHours: TButton;
    butTimeLengthMinutes: TButton;
    dtpTimeLength: TDateTimePicker;
    pnlHideTotalCost: TPanel;
    gbStartTime: TGroupBox;
    dtpStartDate: TDateTimePicker;
    dtpStartTime: TDateTimePicker;
    gbEndTime: TGroupBox;
    dtpEndDate: TDateTimePicker;
    dtpEndTime: TDateTimePicker;
    butEndTimeMinutes: TButton;
    butEndTimeHours: TButton;
    cbxEndTimeMode: TCheckBox;
    cbxSummaryEndTime: TCheckBox;
    grdDetailInfo: TStringGrid;
    pnlTop: TPanel;
    pnlBottom: TPanel;
    pnlShowTotalCost: TPanel;
    pnlStartTime: TPanel;
    pnlEndTime: TPanel;
    pnlSessionInfo: TPanel;
    lblStart: TLabel;
    dtpStart: TDateTimePicker;
    edtTarif: TEdit;
    lblTarif: TLabel;
    pnlMiddle: TPanel;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure tmrCheckTimer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dtpTimeLengthClick(Sender: TObject);
    procedure Change(Sender: TObject);
    procedure butTimeMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure TimeLengthHourClick(Sender: TObject);
    procedure TimeLengthMinClick(Sender: TObject);
    procedure EndTimeHourClick(Sender: TObject);
    procedure EndTimeMinClick(Sender: TObject);
    procedure cbxEndTimeModeClick(Sender: TObject);
    procedure cbxSummaryEndTimeClick(Sender: TObject);
    procedure edtMoneyEnter(Sender: TObject);
    procedure dtpEndDateChange(Sender: TObject);
    procedure dtpEndTimeChange(Sender: TObject);
    procedure butTimeLengthClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FState: TFormCompAddState;
    FfrmComputers: TfrmComputers;
    FbControlsEnabled: Boolean;
    procedure UpdateInformation;
    procedure DoDesign(AbSetFocus: Boolean);
    procedure _OnComputersChange(ASender: TObject);
    procedure Init;
    procedure EnableControls;
    procedure DisableControls;
    property ControlsEnabled: Boolean
        read FbControlsEnabled write FbControlsEnabled;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ShowModal: Integer; override;
  end;

var
  formCompAdd: TformCompAdd;

implementation

uses
  Types,
  frmGCMessageBox,
  DateUtils,
  uVirtualTime,
  uAccountSystem,
  uRegistry,
  gcconst,
  uVCLTools,
  uTariffication,
  uKKMTools, uRegistryOptions;

{$R *.dfm}

constructor TformCompAdd.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FfrmComputers := TfrmComputers.Create(pnlComputers);
  FfrmComputers.Parent := pnlComputers;
  FfrmComputers.Align := alClient;
  FfrmComputers.Show;
  FfrmComputers.ComputerAction := caStop;
  FfrmComputers.OnChange := _OnComputersChange;
end;

destructor TformCompAdd.Destroy;
begin
  FfrmComputers.OnChange := Nil;
  FreeAndNil(FfrmComputers);
  inherited Destroy;
end;

function TformCompAdd.ShowModal: Integer;
begin
  Init;
  Result := inherited ShowModal;
end;


procedure TformCompAdd.Init;
begin
  Caption := translate('mnuAdd');
  FState := casMoney;
  lblSumma.Caption := translate('lblSumma');
  lblTimeLength.Caption := translate('lblTimeLength');
  lblTarif.Caption := translate('Tarif');
  btnCancel.Caption := translate('butCancel');
  butTimeLengthHours.Caption := translate('butHours');
  butTimeLengthMinutes.Caption := translate('butMinutes');
  butEndTimeHours.Caption := translate('butHours');
  butEndTimeMinutes.Caption := translate('butMinutes');
  cbxEndTimeMode.Caption := translate('cbEndTimeMode');
  btnOk.Enabled := false;
  edtMoney.Enabled := True;
  edtMoney.Text := '';
  dtpTimeLength.DateTime := FIRST_DATE; // 01.01.2000 0:00:00
  dtpEndTime.DateTime := IncHour(GetVirtualTime, 1);
  dtpEndDate.DateTime := dtpEndTime.DateTime;
  cbxSummaryEndTime.Checked := False;
  with grdDetailInfo do begin
    Cells[0,0] := '№ ';
    Cells[1,0] := 'Тариф ';
    Cells[2,0] := 'Начало ';
    Cells[3,0] := 'Конец ';
    Cells[4,0] := 'Доплата ';
    Cells[5,0] := 'Доп.время ';
  end;
  CompsSelDeselect(caAdd);
  FfrmComputers.Init(caAdd);
  tmrCheckTimer(Self);
  tmrCheck.Enabled := true;
  DoDesign(True);
end;

procedure TformCompAdd.btnOkClick(Sender: TObject);
var
  fAddSumma: Double;
  session: TGCSession;
  i, nCompIndex: Integer;
  bActionCanceled: Boolean;
  summmax: Real;
  summmin: Real;
begin
  // проверка, что введена сумма не меньше минимальной
  if (CompsSelCount > 1) then
    fAddSumma := edtTotalCost.Value
  else
    fAddSumma := edtMoney.Value;
  if Comps[ComputersGetIndex(CompsSel[0])].session.Tariff.useseparatesumm >0 then
  begin
    summmin := Comps[ComputersGetIndex(CompsSel[0])].session.Tariff.addmoneymin;
    summmax := Comps[ComputersGetIndex(CompsSel[0])].session.Tariff.addmoneymax;
  end else
  begin
    summmin := GRegistry.Options.AddMoneyMinimum;
    summmax := GRegistry.Options.AddMoneyMaximum;
  end;

  if (fAddSumma < summmin)
      or (fAddSumma > summmax) then begin
    formGCMessageBox.memoInfo.Text := translate('ErrorCompAdd1') + ' '
        + FloatToStr(summmin) + ' ' +
    translate('ErrorCompAdd2') + ' '
        + FloatToStr(summmax);
    formGCMessageBox.SetDontShowAgain(false);
    formGCMessageBox.ShowModal;
    exit;
  end;
  tmrCheck.Enabled := False;
  UpdateInformation;
  bActionCanceled := False;
  if GRegistry.Modules.KKM.Active then begin
    bActionCanceled := not PrintAddMoney(
        Comps[ComputersGetIndex(CompsSel[0])].session, fAddSumma)
        and GRegistry.Modules.KKM.DisconnectBlock;
  end;
  if bActionCanceled then begin
    Console.AddEvent(EVENT_ICON_INFORMATION, LEVEL_1,
        'Операция отменена из-за ошибки ККМ: ' + GKKMPlugin.GetLastError);
    ModalResult := mrCancel;
  end else begin
    if (CompsSelCount >= 1) then begin
      for i := 1 to CompsSelCount do begin
        nCompIndex := ComputersGetIndex(CompsSel[i - 1]);
        session := Comps[nCompIndex].session;
        fAddSumma := StrToFloatDef(grdDetailInfo.Cells[4,i], 0);
        session.UpdateOnDB(fAddSumma, 0, 0, 0, 0, 0, 0, 0);
        SendAllOptionsToClient(nCompIndex);
        Console.AddEvent(EVENT_ICON_INFORMATION, LEVEL_1, translate('AddComp')
            + ' ' + Comps[nCompIndex].GetStrNumber + ' >> '
            + DateTimeToSql(GetVirtualTime) + ' / '
            + FormatFloat('0.00',fAddSumma) + ' ' + GRegistry.Options.Currency);
      end;
    end;
    if (CompsSelCount > 1) then begin
      Console.AddEvent(EVENT_ICON_INFORMATION, LEVEL_1, translate('AddComp')
            + ' : ' + translate('lblSummary') + ' '
            + FormatFloat('0.00',edtTotalCost.Value) + ' '
            + GRegistry.Options.Currency);
    end;
    ModalResult := mrOk;
  end;
end;

procedure TformCompAdd.btnCancelClick(Sender: TObject);
begin
  tmrCheck.Enabled := False;
  ModalResult := mrCancel;
end;

procedure TformCompAdd.tmrCheckTimer(Sender: TObject);
var
  session: TGCSession;
begin
  session := Comps[ComputersGetIndex(CompsSel[0])].session;
  if (session = nil) or (session.Status = ssFinished) then begin
    btnCancelClick(nil);
  end else
    UpdateInformation;
end;

procedure TformCompAdd.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key=27) then
    btnCancelClick(Nil);
end;

procedure TformCompAdd.UpdateInformation;
var
//  stop: TDateTime;
//  tdMoney: Double;
  i: Integer;
  session: TGCSession;
  dtCurrent, dtLength, dtStop: TDateTime;
  dtMeanTimeStop, dtAddLength: TDateTime;
  fMoney, fSummaryMoney: Double;
  bOkEnabled: Boolean;
begin
  DisableControls;
  bOkEnabled := True;
  dtCurrent := GetVirtualTime;
  if (CompsSelCount >= 1) then begin
    case FState of
      casMoney: begin
        fMoney := edtMoney.Value;
        fSummaryMoney := fMoney * CompsSelCount;
        dtAddLength := 0;
      end;
      casSummaryMoney: begin
        fSummaryMoney := edtTotalCost.Value;
        fMoney := fSummaryMoney / CompsSelCount;
        dtAddLength := 0;
      end;
      casTimeLength: begin
        fSummaryMoney := 0;
        fMoney := 0;
        dtAddLength := dtpTimeLength.Time;
      end;
      casEndTime: begin
        fSummaryMoney := 0;
        fMoney := 0;
        dtAddLength := 0;
        dtpEndTime.DateTime := RecodeSecond(RecodeMilliSecond(
            dtpEndTime.DateTime,0),0);
      end;
      casSummaryEndTime: begin
        dtMeanTimeStop := 0;
        fSummaryMoney := edtTotalCost.Value;
        for i := 0 to CompsSelCount - 1 do begin
          session := Comps[ComputersGetIndex(CompsSel[i])].session;
          if (session = nil) or (session.Status = ssFinished) then
            btnCancelClick(nil);
          dtMeanTimeStop := dtMeanTimeStop
              + session.Tariff.CalculateTimeLength(
              session.TimeStop, fSummaryMoney / CompsSelCount,
              session.ComputerGroupId, 0) + session.TimeStop;
        end;
        dtMeanTimeStop := dtMeanTimeStop / CompsSelCount;
        dtpEndTime.DateTime := dtMeanTimeStop;
        fSummaryMoney := 0;
      end;
    end;

    grdDetailInfo.RowCount := CompsSelCount + 1;
    for i := 1 to CompsSelCount do begin
      session := Comps[ComputersGetIndex(CompsSel[i - 1])].session;
      if (session = nil) or (session.Status = ssFinished) then
        btnCancelClick(nil);
      if (i = 1) then begin
        edtTarif.Text := session.GetStrTarif;
      end;
      with grdDetailInfo do begin
        Cells[0,i] := Comps[ComputersGetIndex(
            session.IdComp)].GetStrNumber;
        Cells[1,i] := session.GetStrTarif;
        Cells[2,i] := TimeToStr(session.TimeStart);
        case FState of
          casMoney, casSummaryMoney: begin
            dtLength := session.Tariff.CalculateTimeLength(
                session.TimeStop, fMoney, session.ComputerGroupId, 0);
            dtStop := session.TimeStop + dtLength;
            dtAddLength := dtAddLength + dtLength;
          end;
          casTimeLength: begin
            dtLength := IncHour(IncMinute(0, MinuteOf(dtpTimeLength.Time)),
                HourOf(dtpTimeLength.Time));
            dtStop := session.TimeStop + dtLength;
            fMoney := session.Tariff.CalculateCost(
                session.TimeStop, dtStop, session.ComputerGroupId, 0, True);
            fSummaryMoney := fSummaryMoney + fMoney;
          end;
          casEndTime: begin
            if (CompareDateTime(session.TimeStop, dtpEndTime.DateTime)
                = GreaterThanValue) then begin
              dtStop := session.TimeStop;
              fMoney := 0;
              dtLength := 0;
            end else begin
              dtStop := dtpEndTime.DateTime;
              // Сделать пересчет от старта за вычетом TimeCost
              fMoney := session.Tariff.CalculateCost(
                  session.TimeStop, dtpEndTime.DateTime,
                  Comps[ComputersGetIndex(session.IdComp)].IdGroup, 0, True);
              dtLength := dtpEndTime.DateTime - session.TimeStop;
            end;
            fSummaryMoney := fSummaryMoney + fMoney;
            dtAddLength := dtAddLength + dtLength;
          end;
          casSummaryEndTime: begin
            if (CompareDateTime(session.TimeStop, dtpEndTime.DateTime)
                = GreaterThanValue) then begin
              dtStop := session.TimeStop;
              fMoney := 0;
              dtLength := 0;
            end else begin
              dtStop := dtpEndTime.DateTime;
              // Сделать пересчет от старта за вычетом TimeCost
              fMoney := session.Tariff.CalculateCost(
                  session.TimeStop, dtpEndTime.DateTime,
                  Comps[ComputersGetIndex(session.IdComp)].IdGroup, 0, True);
              dtLength := dtpEndTime.DateTime - session.TimeStop;
            end;
            fSummaryMoney := fSummaryMoney + fMoney;
            dtAddLength := dtAddLength + dtLength;
          end;
        end;
        if (CompareDateTime(GSessions.GetMaxStopTime(session.IdComp),
            dtStop) = LessThanValue) then
          bOkEnabled := False;
        Cells[3,i] := TimeToStr(dtStop);
        Cells[4,i] := FormatFloat('0.00', fMoney);
        Cells[5,i] := TimeToStr(dtLength);
      end;
    end;
    case FState of
      casMoney: begin
        edtTotalCost.Text := FormatFloat('0.00', fMoney * CompsSelCount);
        dtpTimeLength.Time := dtAddLength / CompsSelCount;
      end;
      casSummaryMoney: begin
        edtMoney.Text := FormatFloat('0.00', fSummaryMoney / CompsSelCount);
        dtpTimeLength.Time := dtAddLength / CompsSelCount;
      end;
      casTimeLength: begin
        edtMoney.Text := FormatFloat('0.00', fSummaryMoney / CompsSelCount);
        edtTotalCost.Text := FormatFloat('0.00', fSummaryMoney);
      end;
      casEndTime: begin
        edtMoney.Text := FormatFloat('0.00', fSummaryMoney / CompsSelCount);
        edtTotalCost.Text := FormatFloat('0.00', fSummaryMoney);
        dtpTimeLength.Time := dtAddLength / CompsSelCount;
      end;
      casSummaryEndTime: begin
        // коррекция сумм по общей сумме
        for i := 1 to CompsSelCount do begin
          session := Comps[ComputersGetIndex(CompsSel[i - 1])].session;
          if (session = nil) or (session.Status = ssFinished) then
            btnCancelClick(nil);
          with grdDetailInfo do begin
            fMoney := StrToFloatDef(Cells[4,i], 0) / fSummaryMoney
                * edtTotalCost.Value;
            Cells[4,i] := FormatFloat('0.00', fMoney);
          end;
        end;
        edtMoney.Text := FormatFloat('0.00', edtTotalCost.Value
            / CompsSelCount);
        dtpTimeLength.Time := dtAddLength / CompsSelCount;
      end;
    end;
    StringGridAutoResizeColums(grdDetailInfo);
  end else begin
  end;
{  dtpStartTime.DateTime := GetSession.TimeStart;
  if (EndTime in FState) then begin
    dtpEndTime.DateTime := RecodeSecond(dtpEndTime.DateTime,0);
    stop := GetSession.TimeStop;
    ReplaceTime(stop,dtpEndTime.DateTime);
    if TimeOf(GetSession.TimeStop) > TimeOf(stop) then
        stop := IncDay(stop,1);
    dtpEndTime.DateTime := stop;
    dtpTimeLength.Time := TimeOf(stop-GetSession.TimeStop);
    tdMoney := Tarifs[TarifsGetIndex(GetSession.IdTarif)].CalculateCost(
        GetSession.TimeStop, stop,
        Comps[ComputersGetIndex(GetSession.IdComp)].IdGroup, 0, True);
    edtMoney.Text := FormatFloat('0.00',tdMoney);
  end
  else if (Money in FState) then begin
    dtpTimeLength.Time :=
        Tarifs[TarifsGetIndex(GetSession.IdTarif)].CalculateTimeLength(
        GetSession.TimeStop, StrToFloatGC(edtMoney.Text),
        Comps[ComputersGetIndex(GetSession.IdComp)].IdGroup, 0);
    dtpEndTime.DateTime := GetSession.TimeStop + TimeOf(dtpTimeLength.Time);
  end
  else begin // TimeLength
    stop := GetSession.TimeStop;
    stop := IncHour(stop,HourOf(dtpTimeLength.Time));
    stop := IncMinute(stop,MinuteOf(dtpTimeLength.Time));
    dtpEndTime.DateTime := stop;
    tdMoney := Tarifs[TarifsGetIndex(GetSession.IdTarif)].CalculateCost(
        GetSession.TimeStop, stop,
        Comps[ComputersGetIndex(GetSession.IdComp)].IdGroup, 0, True);
    edtMoney.Text := FormatFloat('0.00',tdMoney);
  end;
  btnOk.Enabled := (( HourOf(dtpTimeLength.Time)<>0 ) or ( MinuteOf(dtpTimeLength.Time) <> 0 )) and
    (dtpEndTime.DateTime <= GSessions.GetMaxStopTime(GetSession.IdComp));
  }
  if (fSummaryMoney <= 0.00) then
    bOkEnabled := False;
  btnOk.Enabled := bOkEnabled;
   EnableControls;
end;

procedure TformCompAdd.DoDesign(AbSetFocus: Boolean);
var
  bMulti, bEndTime, bSummaryEndTime: Boolean;
  nHeight: Integer;
begin
  DisableControls;
  bMulti := (CompsSelCount > 1);
  if bMulti then begin
    nHeight := 285 + CompsSelCount * 17;
    if nHeight > 455 then                                  //to do сделать параметр регулируемым
      nHeight := 455;
    Width := 454;
  end else begin
    nHeight := 230;
    Width := 473;
  end;
  Height := nHeight;
  pnlHideTotalCost.Visible := not bMulti;
  cbxSummaryEndTime.Visible := bMulti;
  pnlStartTime.Visible := bMulti
      and not GRegistry.UserInterface.MultiActionsFullControl;
  pnlShowTotalCost.Visible := bMulti;
  pnlHideTotalCost.Visible := not bMulti;
  pnlEndTime.Visible := bMulti;
  if bMulti then begin
    gbEndTime.Parent := pnlEndTime;
    cbxEndTimeMode.Parent := pnlEndTime;
  end else begin
    gbEndTime.Parent := pnlHideTotalCost;
    cbxEndTimeMode.Parent := pnlHideTotalCost;
  end;
  pnlSessionInfo.Visible := not bMulti;
  bEndTime := (FState = casEndTime);
  bSummaryEndTime := (FState = casSummaryEndTime);
  edtMoney.Enabled := not bEndTime and not bSummaryEndTime;
  edtTotalCost.Enabled := not bEndTime;
  dtpTimeLength.Enabled := not bEndTime and not bSummaryEndTime;
  dtpEndTime.Enabled := bEndTime and not bSummaryEndTime;
  dtpEndDate.Enabled := bEndTime and not bSummaryEndTime;
  butTimeLengthHours.Enabled := not bEndTime and not bSummaryEndTime;
  butTimeLengthMinutes.Enabled := not bEndTime and not bSummaryEndTime;
  butEndTimeMinutes.Enabled := bEndTime and not bSummaryEndTime;
  butEndTimeHours.Enabled := bEndTime and not bSummaryEndTime;
  cbxEndTimeMode.Enabled := not bSummaryEndTime;
  cbxSummaryEndTime.Enabled := not bEndTime;
  if bSummaryEndTime or bEndTime then begin
    lblSumma.Caption := 'Среднее значение';
    lblTimeLength.Caption := 'Среднее время';
  end else begin
    lblSumma.Caption := 'Сумма';
    lblTimeLength.Caption := 'Время';
  end;
{  if AbSetFocus then
    case FState of
      casEndTime:
        dtpEndTime.SetFocus;
      casMoney:
        edtMoney.SetFocus;
      casSummaryMoney:
        edtTotalCost.SetFocus;
      casTimeLength:
        dtpTimeLength.SetFocus;
      casSummaryEndTime:
        edtTotalCost.SetFocus;
    end;
}
  UpdateInformation;
  EnableControls;
end;

procedure TformCompAdd.Change(Sender: TObject);
begin
  exit;
  if not ControlsEnabled then exit;
  UpdateInformation;
end;

procedure TformCompAdd.dtpTimeLengthClick(Sender: TObject);
begin
  FState := casTimeLength;
  DoDesign(False);
end;

procedure TformCompAdd.butTimeMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  TButton(Sender).PopupMenu.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);
end;

procedure TformCompAdd.TimeLengthHourClick(Sender: TObject);
begin
  FState := casTimeLength;
  DoDesign(True);
  formCompAdd.dtpTimeLength.Time := StrToTime(TMenuItem(Sender).Caption);
  UpdateInformation;
end;

procedure TformCompAdd.TimeLengthMinClick(Sender: TObject);
begin
  FState := casTimeLength;
  DoDesign(False);
  formCompAdd.dtpTimeLength.Time := RecodeMinute(
    formCompAdd.dtpTimeLength.Time,StrToInt(TMenuItem(Sender).Caption));
  UpdateInformation;
end;

procedure TformCompAdd.EndTimeHourClick(Sender: TObject);
begin
  FState :=casEndTime;
  DoDesign(False);
  formCompAdd.dtpEndTime.DateTime := StrToTime(TMenuItem(Sender).Caption);
  UpdateInformation;
end;

procedure TformCompAdd.EndTimeMinClick(Sender: TObject);
begin
  FState := casEndTime;
  DoDesign(False);
  formCompAdd.dtpEndTime.DateTime := RecodeMinute(
    formCompAdd.dtpEndTime.DateTime,StrToInt(TMenuItem(Sender).Caption));
  UpdateInformation;
end;

procedure TformCompAdd._OnComputersChange(ASender: TObject);
begin
  DoDesign(False);
end;

procedure TformCompAdd.cbxEndTimeModeClick(Sender: TObject);
begin
  DisableControls;
  if (cbxEndTimeMode.Checked) then begin
    FState := casEndTime;
    if dtpEndTime.DateTime <= GetVirtualTime then
      dtpEndTime.DateTime := IncHour(GetVirtualTime,1);
    dtpEndDate.DateTime := dtpEndTime.DateTime;
  end
  else
    FState := casMoney;
  DoDesign(True);
  EnableControls;
end;

procedure TformCompAdd.cbxSummaryEndTimeClick(Sender: TObject);
begin
  if cbxSummaryEndTime.Checked then
    FState := casSummaryEndTime
  else
    FState := casSummaryMoney;
  DoDesign(False);
end;

procedure TformCompAdd.edtMoneyEnter(Sender: TObject);
begin
  FState := casMoney;
  DoDesign(False);
end;

procedure TformCompAdd.dtpEndDateChange(Sender: TObject);
begin
  if not ControlsEnabled then exit;
  DisableControls;
  dtpEndTime.DateTime := dtpEndDate.DateTime;
  UpdateInformation;
  EnableControls;
end;

procedure TformCompAdd.EnableControls;
begin
  FbControlsEnabled := True;
end;

procedure TformCompAdd.DisableControls;
begin
  FbControlsEnabled := False;
end;

procedure TformCompAdd.dtpEndTimeChange(Sender: TObject);
begin
  if not ControlsEnabled then exit;
  DisableControls;
  dtpEndDate.DateTime := dtpEndTime.DateTime;
  UpdateInformation;
  EnableControls;
end;

procedure TformCompAdd.butTimeLengthClick(Sender: TObject);
begin
  FState := casTimeLength;
  DoDesign(True);
end;

procedure TformCompAdd.FormShow(Sender: TObject);
begin
  if edtMoney.Enabled then edtMoney.SetFocus;
end;

end.
