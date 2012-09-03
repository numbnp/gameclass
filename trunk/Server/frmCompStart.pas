unit frmCompStart;

interface

uses
  GCLangutils, GCComputers, GCConst, DateUtils, GCCommon, frmGCMessageBox,
  Menus, ExtCtrls, StdCtrls, Controls, ComCtrls, Classes,
  StrUtils, Windows, Messages, SysUtils, Variants, Graphics, Forms,
  Dialogs, Grids, ValEdit, Mask, TeEngine, Series, TeeProcs, Chart,
  TeeFunci, OleCtrls, Chartfx3, VCFI, DB, ADODB, DbChart, GCSessions,
  ToolEdit, CurrEdit,
  ufrmComputers,
  ufrmSessionsChart;

type
  TFormCompStartState =
      (PostPay, Money, TimeLength, EndTime, PacketTarif, Advanced,
      OnlyPrePay, Reserve, FreePacketTarif);

  TformCompStart = class(TForm)
    butOk: TButton;
    butCancel: TButton;
    lblTarif: TLabel;
    timerFrmCompStart: TTimer;
    cbPostPay: TCheckBox;
    popupTimeLengthMinuts: TPopupMenu;
    min10: TMenuItem;
    min15: TMenuItem;
    min20: TMenuItem;
    min25: TMenuItem;
    min30: TMenuItem;
    min40: TMenuItem;
    min45: TMenuItem;
    min50: TMenuItem;
    min35: TMenuItem;
    min55: TMenuItem;
    lvTarifs: TListView;
    cbEndTimeMode: TCheckBox;
    popupTimeLengthHours: TPopupMenu;
    hour1: TMenuItem;
    hour2: TMenuItem;
    hour3: TMenuItem;
    hour4: TMenuItem;
    hour5: TMenuItem;
    hour6: TMenuItem;
    hour7: TMenuItem;
    popupTimeHours: TPopupMenu;
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
    popupTimeMinuts: TPopupMenu;
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
    pnlBottom: TPanel;
    cbReserve: TCheckBox;
    gbMoneyTimeLength: TGroupBox;
    lblSumma: TLabel;
    lblTimeLength: TLabel;
    dtpTimeLength: TDateTimePicker;
    butTimeLengthHours: TButton;
    butTimeLengthMinutes: TButton;
    gbStartTime: TGroupBox;
    dtpStartDate: TDateTimePicker;
    dtpStartTime: TDateTimePicker;
    gbEndTime: TGroupBox;
    dtpEndDate: TDateTimePicker;
    dtpEndTime: TDateTimePicker;
    butEndTimeMinutes: TButton;
    butEndTimeHours: TButton;
    butStartTimeHours: TButton;
    butStartTimeMinutes: TButton;
    lblDescription: TLabel;
    editDescription: TEdit;
    editMoney: TCurrencyEdit;
    popupSession: TPopupMenu;
    mnuCancel: TMenuItem;
    pnlTop: TPanel;
    pnlComputers: TPanel;
    pnlScale: TPanel;
    radio12Hours: TRadioButton;
    radio24Hours: TRadioButton;
    radio48Hours: TRadioButton;
    pnlCost: TPanel;
    pnlTimeLength: TPanel;
    pnlTotalCost: TPanel;
    lblTotalCost: TLabel;
    edtTotalCost: TCurrencyEdit;
    pnlMoney: TPanel;
    pnlHideTotalCost: TPanel;
    procedure butOkClick(Sender: TObject);
    procedure butCancelClick(Sender: TObject);
    procedure editMoneyChange(Sender: TObject);
    procedure timerFrmCompStartTimer(Sender: TObject);
    procedure butTimeLengthMinutesMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure butTimeLengthHoursMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure dtpTimeLengthChange(Sender: TObject);
    procedure lvTarifsClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure butAdvancedClick(Sender: TObject);
    procedure butTimeHoursMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure butTimeMinutesMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure TimeLengthHourClick(Sender: TObject);
    procedure TimeLengthMinClick(Sender: TObject);
    procedure TimeHourClick(Sender: TObject);
    procedure TimeMinClick(Sender: TObject);
    procedure dtpTimeLengthClick(Sender: TObject);
    procedure editMoneyClick(Sender: TObject);
    procedure butEndTimeMinutesClick(Sender: TObject);
    procedure butTimeLengthMinutesClick(Sender: TObject);
    procedure butTimeLengthHoursClick(Sender: TObject);
    procedure butStartTimeMinutesMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure butEndTimeMinutesMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure dtpEndTimeChange(Sender: TObject);
    procedure dtpEndDateChange(Sender: TObject);
    procedure dtpStartTimeChange(Sender: TObject);
    procedure dtpStartDateChange(Sender: TObject);
    procedure cbEndTimeModeMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure cbEndTimeModeKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbEndTimeCheck;
    procedure cbPostPayCcheck;
    procedure cbReserveCheck;
    procedure cbPostPayMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure cbPostPayKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbReserveKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbReserveMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure radioHoursClick(Sender: TObject);
    procedure editDescriptionChange(Sender: TObject);
    procedure frameSessionsChart1chartCompsClickSeries(
      Sender: TCustomChart; Series: TChartSeries; ValueIndex: Integer;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure editMoneyKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);

    procedure lvTarifsKeyPress(Sender: TObject; var Key: Char);

  private
    FfrmComputers: TfrmComputers;
    FfrmSessionsChart: TfrmSessionsChart;
    FState: Set of TFormCompStartState;
    FnHoursInterval: Integer; // интервал времени в часах12/24/48
    FSavedValue: string;
    FCanceledReserveSession: TGCSession;
    FDesignedSession: TGCSession;
    ReserveEditSumm: string;
    FbControlsEnabled: Boolean;
    procedure EnableControls;
    procedure DisableControls;
    procedure UpdateInformation;
    procedure DoDesign(AbSetFocus: Boolean);
    procedure DoDesignSessionChart;
    procedure SaveManualEditValue;
    procedure RestoreManualEditValue;
    procedure CopyDataToGSessions;
    procedure RedrawTarifsList;
    procedure UpdateInformationFromChart(AbUpdateOnlyCompList: Boolean);
    procedure Init;
    procedure _OnSessionsChartSession(const ASender: TObject;
        const ASession: TGCSession;
        const AAction: TGCSessionAction);
    procedure _OnSessionsChartChange(ASender: TObject);
    procedure _OnComputersChange(ASender: TObject);

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ShowModal: Integer; override;
  end;

var
  formCompStart: TformCompStart;

implementation
{$R *.dfm}
uses
  uAccountSystem,
  uClientInfoConst,
  uClientOptions,
  frmMain,
  uVirtualTime,
  uRegistry,
  gcfunctions,
  Math,
  uServerScripting,
  uTariffication,
  uKKMTools,
  uProtocol, uRegistryOptions;

constructor TformCompStart.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FfrmComputers := TfrmComputers.Create(pnlComputers);
  FfrmComputers.Parent := pnlComputers;
  FfrmComputers.Align := alClient;
  FfrmComputers.Show;
  FfrmSessionsChart := TfrmSessionsChart.Create(pnlTop);
  FfrmSessionsChart.Parent := pnlTop;
  FfrmSessionsChart.Align := alClient;
  FfrmSessionsChart.ShowCompCount := 50;
  FfrmSessionsChart.Show;
  FfrmSessionsChart.OnSession := _OnSessionsChartSession;
  FfrmSessionsChart.OnChange := _OnSessionsChartChange;
  FfrmComputers.OnChange := _OnComputersChange;
  FCanceledReserveSession := Nil;
  FDesignedSession := Nil;
end;

destructor TformCompStart.Destroy;
begin
  FfrmSessionsChart.OnSession := Nil;
  FfrmSessionsChart.OnChange := Nil;
  FfrmComputers.OnChange := Nil;
  FreeAndNil(FfrmSessionsChart);
  FreeAndNil(FfrmComputers);
  inherited Destroy;
end;

function TformCompStart.ShowModal: Integer;
begin
  Init;
  Result := inherited ShowModal;
end;

procedure TformCompStart.Init;
var
  i,j: integer;
  li: TListItem;
begin
  FnHoursInterval:=12;
  radio12Hours.Checked := True;
  FState := [Money] + [Advanced];
  FSavedValue := '';
  Caption := translate('formCompStartCaption');
  lblSumma.Caption := translate('lblSumma');
  lblTimeLength.Caption := translate('lblTimeLength');
  lblTarif.Caption := translate('Tarif');
//  lblStop.Caption := translate('lblEndDate');
  butCancel.Caption := translate('butCancel');
  cbPostPay.Caption := translate('cbPostPay');
  butTimeLengthHours.Caption := translate('butHours');
  butTimeLengthMinutes.Caption := translate('butMinutes');
  butEndTimeHours.Caption := translate('butHours');
  butStartTimeHours.Caption := butEndTimeHours.Caption;
  butEndTimeMinutes.Caption := translate('butMinutes');
  butStartTimeMinutes.Caption := butEndTimeMinutes.Caption;
  cbEndTimeMode.Caption := translate('cbEndTimeMode');
  cbReserve.Caption := translate('cbReserve');
  lblDescription.Caption := translate('Description');
  butOk.Enabled := false;
  editMoney.Enabled := True;


  if (FDesignedSession <> nil) then
    FDesignedSession.Destroy;
  FDesignedSession := GCSessions.TGCSession.Create;
  FDesignedSession.IdClient :=0;

  cbReserve.Visible := not GRegistry.Options.ReserveDisable;

    // Set Computer Number
  dtpTimeLength.DateTime := FIRST_DATE; // 01.01.2000 0:00:00
  if (GRegistry.Options.OnlyPrePayMode) then
    FState := FState + [OnlyPrePay];
  if (GRegistry.Options.PostPayMode) then
    FState := FState + [PostPay];
  if Comps[ComputersGetIndex(CompsSel[0])].busy
      and not GRegistry.Options.ReserveDisable then
    FState := FState + [Reserve]
  else
    FState := FState - [Reserve];
  //Если есть сеанс или бронь нужно выставить начало в конец сеанса плюс минута
  if Comps[ComputersGetIndex(CompsSel[0])].busy then begin
    for i:= 0 to GSessions.Count -1 do
      if GSessions.Items[i].IdComp = CompsSel[0] then
        if dtpStartTime.DateTime < GSessions.Items[i].TimeStop then
          dtpStartTime.DateTime := GSessions.Items[i].TimeStop + EncodeTime(0,1,0,0);
{    dtpStartTime.DateTime :=
        Comps[ComputersGetIndex(CompsSel[0])].session.TimeStop
        + EncodeTime(0,1,0,0);}
  end
  else
    dtpStartTime.DateTime := GetVirtualTime;
  dtpStartDate.DateTime := dtpStartTime.DateTime;
  dtpEndTime.DateTime := dtpStartTime.DateTime;
  dtpEndDate.DateTime := dtpStartTime.DateTime;
  RedrawTarifsList;
  if GRegistry.Options.AutoSelectDefaultTarif then
    lvTarifs.ItemIndex := 0;
  lvTarifsClick(Self);
  if Reserve in FState then begin
    CompsSelDeselect(caReserve);
    FfrmComputers.Init(caReserve);
  end else begin
    CompsSelDeselect(caStart);
    FfrmComputers.Init(caStart);
  end;
  DoDesign(False{True});
  DoDesignSessionChart;
  Left := (GetSystemMetrics(SM_CXFULLSCREEN) - Width) div 2;
  Top := (GetSystemMetrics(SM_CYFULLSCREEN) - Height) div 2;
  
  FfrmSessionsChart.Activate;
  FfrmSessionsChart.State := DesignStart;
//  timerFrmCompStartTimer(Sender);
  timerFrmCompStart.Enabled := true;
  editMoney.Text := '';
  EnableControls;
{  frameSessionsChart1.DoDesign;
  frameSessionsChart1.Activate;
  frameSessionsChart1.Invalidate;
  Invalidate;}
end;

procedure TformCompStart.EnableControls;
begin
  FbControlsEnabled := True;
  butOk.Enabled := FbControlsEnabled;
end;

procedure TformCompStart.DisableControls;
begin
  FbControlsEnabled := false;
  butOk.Enabled := FbControlsEnabled;
end;

procedure TformCompStart.DoDesignSessionChart;
begin
  if GRegistry.Options.ReserveDisable
      or (GRegistry.UserInterface.HideSessionChartWithoutReserve
      and not cbReserve.Checked) then begin
    FfrmSessionsChart.Visible := False;
    pnlTop.Visible := False;
    pnlScale.Visible := False;
    Width := 660;
    Height := 273;
  end else begin
    FfrmSessionsChart.Visible := True;
    pnlTop.Visible := True;
    pnlScale.Visible := True;
    Width := 660;
    Height := round(Screen.Height*0.9); //90% от высоты экрана
  end;
end;

procedure TformCompStart.butOkClick(Sender: TObject);
var
  StartSumma: double;
  i: Integer;
  bActionCanceled: Boolean;
  summmax : Real;
  summmin : Real;
  index: integer;
begin
  if not FbControlsEnabled then exit;
  DisableControls;
  timerFrmCompStartTimer(nil);
  Index := TarifsGetIndex(FDesignedSession.IdTarif);

  // проверка, что введена сумма не меньше минимальной
  StartSumma := StrToFloatGC(formCompStart.editMoney.Text);
  if Tarifs[Index].useseparatesumm > 0 then
  begin
    summmax := Tarifs[Index].startmoneymax;
    summmin := Tarifs[Index].startmoneymin;
  end else
  begin
    summmax := GRegistry.Options.StartMoneyMaximum;
    summmin := GRegistry.Options.StartMoneyMinimum;
  end;

  if (StartSumma < summmin) then
  begin
    formGCMessageBox.memoInfo.Text := translate('ErrorCompStart1') + ' '
        + FloatToStr(summmin) + ' '
        + GRegistry.Options.Currency;
    formGCMessageBox.SetDontShowAgain(false);
    formGCMessageBox.ShowModal;
    EnableControls;
    exit;
  end;
  if (StartSumma > summmax) then
  begin
    formGCMessageBox.memoInfo.Text := translate('ErrorCompStart2') + ' '
        + FloatToStr(summmax) + ' '
        + GRegistry.Options.Currency;
    formGCMessageBox.SetDontShowAgain(false);
    formGCMessageBox.ShowModal;
    EnableControls;
    exit;
  end;

  timerFrmCompStart.Enabled := false; //TODO kill
  formMain.StopUpdate;
  for i:=GSessions.Count-1 downto 0 do
    with GSessions.Items[i] do
      if (Status = ssDesigned) then begin
        bActionCanceled := False;
        if GRegistry.Modules.KKM.Active then begin
          bActionCanceled := not PrintCheckStart(GSessions.Items[i])
              and GRegistry.Modules.KKM.DisconnectBlock;
        end;
        if bActionCanceled then
          Console.AddEvent(EVENT_ICON_INFORMATION, LEVEL_1,
              'Операция отменена из-за ошибки ККМ: ' + GKKMPlugin.GetLastError)
        else begin
          if (Reserve in FState) then begin
            Status := ssReserve;
           //TODO сделать событие лога "Сессия добавлена " вместо стартовала
            Console.AddEvent(EVENT_ICON_INFORMATION, LEVEL_1,
                translate('ReservedSessionSaved') + ' ' + ConsoleInfo);
            Save;
          end
          else begin
            // проверка одновременного старта с УЗ
            if (Comps[ComputersGetIndex(IdComp)].a.state
                <> ClientState_Agreement)
                and (Comps[ComputersGetIndex(IdComp)].a.state
                <> ClientState_Session) then begin
              // нужно пересчитать правильный конец сессии, только для не пакетов
              if not IsPacketTarif and not IsFreePacketTarif then begin
                TimeStop := TimeStart
                    + Tarifs[TarifsGetIndex(IdTarif)].CalculateTimeLength(
                    TimeStart,
                    CommonPay, Comps[ComputersGetIndex(GSessions.Items[i].IdComp)].IdGroup,
                    GAccountSystem.Accounts[IdClient].Discount);
              end;
              Status := ssActive;
              if GClientOptions.Agreement then
                State := ClientState_OperatorAgreement
              else
                State := ClientState_OperatorSession;
              Console.AddEvent(EVENT_ICON_INFORMATION, LEVEL_1,
                  translate('ActionStart') + ' ' + ConsoleInfo);
              RunSessionScript(saStart, GSessions.Items[i]);
              if GRegistry.Client.TaskKillBeforeStart then
                UDPSend(Comps[ComputersGetIndex(IdComp)].ipaddr,
                    STR_CMD_KILLTASK + '=');
              SendAllOptionsToClient(ComputersGetIndex(IdComp));
              Save;
            end;
          end;
        end;
      end;
  EnableControls;
  formMain.StartUpdate;
  ModalResult := mrOk;
end;

procedure TformCompStart.butCancelClick(Sender: TObject);
var
  i: Integer;
begin
  timerFrmCompStart.Enabled := false;
  for i:=GSessions.Count-1 downto 0 do
    if (GSessions.Items[i].Status = ssDesigned) then
      GSessions.Delete(i);
  ModalResult := mrCancel;
end;

procedure TformCompStart.editMoneyChange(Sender: TObject);
begin
  SaveManualEditValue;
  UpdateInformation;
end;

procedure TformCompStart.timerFrmCompStartTimer(Sender: TObject);
begin
  if Not FfrmSessionsChart.IsDesigned then
    UpdateInformation;
end;

procedure TformCompStart.butTimeLengthMinutesMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  butTimeLengthMinutes.PopupMenu.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);
end;

procedure TformCompStart.butTimeLengthHoursMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  butTimeLengthHours.PopupMenu.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);
end;

procedure TformCompStart.UpdateInformation;
var
  stop: TDateTime;
  tdMoney: double;
  index: integer;
  tm: TDateTime;
  dtMaxStop: TDateTime;
  d1,d2,d3,d4: Integer;
  maxtrust: Real;
begin
  if not dsConnected then
    exit;
//init session   кроме тарифа
  FDesignedSession.IdComp := CompsSel[0];
  FDesignedSession.PostPay := False;
  //коррекция секунд
  if (TimeLength in FState) then
    dtpTimeLength.DateTime := RecodeMilliSecond(
        RecodeSecond(dtpTimeLength.DateTime, 0), 0);

  if (Reserve in FState) then
    FDesignedSession.TimeStart := dtpStartTime.DateTime
  else
    FDesignedSession.TimeStart := GetVirtualTime;
  FDesignedSession.TimeStop := dtpEndTime.DateTime;
    if (editMoney.Text = '') or (editMoney.Text = '0')
        or (editMoney.Text='0.') then
      FDesignedSession.CommonPay := 0
    else
      FDesignedSession.CommonPay := StrToFloatGC(editMoney.Text);

  if (FreePacketTarif in FState) then begin
    Index := TarifsGetIndex(FDesignedSession.IdTarif);
    tm := Tarifs[Index].GetWholeStartByIndex(FDesignedSession.Whole);
    FDesignedSession.CommonPay := Tarifs[Index].GetWholeCostByIndex(
        FDesignedSession.Whole, FDesignedSession.IdComp);
    if (Reserve in FState) then begin
      if (EndTime in FState) then begin
        if (FDesignedSession.TimeStop < GetVirtualTime
            + Tarifs[Index].GetWholeLengthByIndex(FDesignedSession.Whole)) then
          FDesignedSession.TimeStop := GetVirtualTime
              + Tarifs[Index].GetWholeLengthByIndex(FDesignedSession.Whole);
        FDesignedSession.TimeStart := FDesignedSession.TimeStop
            - Tarifs[Index].GetWholeLengthByIndex(FDesignedSession.Whole);
      end else begin
        if (FDesignedSession.TimeStart < GetVirtualTime) then
            FDesignedSession.TimeStart := GetVirtualTime;
        FDesignedSession.TimeStop := FDesignedSession.TimeStart
            + Tarifs[Index].GetWholeLengthByIndex(FDesignedSession.Whole);
      end;
    end else begin
      FDesignedSession.TimeStart := GetVirtualTime;
      FDesignedSession.TimeStop := FDesignedSession.TimeStart
          + Tarifs[Index].GetWholeLengthByIndex(FDesignedSession.Whole);
    end;
  end
  else if (PacketTarif in FState) then begin
    Index := TarifsGetIndex(FDesignedSession.IdTarif);
    tm := Tarifs[Index].GetWholeStartByIndex(FDesignedSession.Whole);
    if (Tarifs[Index].GetWholePrevDay(FDesignedSession.TimeStart,FDesignedSession.Whole)) then
      FDesignedSession.TimeStart := IncDay(FDesignedSession.TimeStart,-1);
    FDesignedSession.TimeStart := RecodeTime(FDesignedSession.TimeStart, HourOf(tm), MinuteOf(tm),0,0);
    FDesignedSession.TimeStop := FDesignedSession.TimeStart + Tarifs[Index].GetWholeLengthByIndex(FDesignedSession.Whole);;
    FDesignedSession.CommonPay := Tarifs[Index].GetWholeCostByIndex(FDesignedSession.Whole, FDesignedSession.IdComp);
  end
  else if (PostPay in FState) then begin
    FDesignedSession.PostPay := True;
    if Tarifs[TarifsGetIndex(FDesignedSession.IdTarif)].useseparatesumm >0 then
    begin
      maxtrust := Tarifs[TarifsGetIndex(FDesignedSession.IdTarif)].maximumtrust
    end else
      maxtrust := GRegistry.Options.MaximumTrustPostPay;
    begin
    end;
    FDesignedSession.CommonPay := maxtrust;
    tm := Tarifs[TarifsGetIndex(FDesignedSession.IdTarif)].CalculateTimeLength(
        FDesignedSession.TimeStart, maxtrust,
        Comps[ComputersGetIndex(FDesignedSession.IdComp)].IdGroup, 0);
    FDesignedSession.TimeStop := FDesignedSession.TimeStart + tm;
    dtMaxStop := GSessions.GetDesignedMaxStopTime;
    if (FDesignedSession.TimeStop > dtMaxStop) then begin
      FDesignedSession.TimeStop := dtMaxStop;
      FDesignedSession.CommonPay := Tarifs[TarifsGetIndex(FDesignedSession.IdTarif)].CalculateCost(
          FDesignedSession.TimeStart, FDesignedSession.TimeStop,
          Comps[ComputersGetIndex(FDesignedSession.IdComp)].IdGroup, 0, True, True, 0)
    end;
  end
  else if (EndTime in FState) then begin
    FDesignedSession.TimeStop := RecodeSecond(FDesignedSession.TimeStop,0);
    if (FDesignedSession.TimeStart > FDesignedSession.TimeStop) or (HoursBetween(FDesignedSession.TimeStart,FDesignedSession.TimeStop)>23) then begin
      //если резерв то сдвигаем начало относительно конца, но не дальще VirtualTime
      if (Reserve in FState) and (FDesignedSession.TimeStop > GetVirtualTime) then begin
        FDesignedSession.TimeStart:=RecodeDate(FDesignedSession.TimeStart,YearOf(FDesignedSession.TimeStop),MonthOf(FDesignedSession.TimeStop),DayOf(FDesignedSession.TimeStop));
        if (FDesignedSession.TimeStart > FDesignedSession.TimeStop) then
          FDesignedSession.TimeStart := IncDay(FDesignedSession.TimeStart,-1);
        if (FDesignedSession.TimeStart < GetVirtualTime) then
          FDesignedSession.TimeStart := GetVirtualTime;
      end
      else begin
        FDesignedSession.TimeStop:=RecodeDate(FDesignedSession.TimeStop,YearOf(FDesignedSession.TimeStart),MonthOf(FDesignedSession.TimeStart),DayOf(FDesignedSession.TimeStart));
        if (FDesignedSession.TimeStart > FDesignedSession.TimeStop) then
          FDesignedSession.TimeStop := IncDay(FDesignedSession.TimeStop,1);
      end;
    end;
    tdMoney := Tarifs[TarifsGetIndex(FDesignedSession.IdTarif)].CalculateCost(
        FDesignedSession.TimeStart, FDesignedSession.TimeStop,
        Comps[ComputersGetIndex(FDesignedSession.IdComp)].IdGroup, 0, True, True, 0);
//    tdMoney := Tarifs[TarifsGetIndex(FDesignedSession.IdTarif)].fnRoundMoney(tdMoney, Tarifs[TarifsGetIndex(FDesignedSession.IdTarif)].roundmoney, 1);
    FDesignedSession.CommonPay := tdMoney;
  end
  else if (Money in FState) then begin
    tm := Tarifs[TarifsGetIndex(FDesignedSession.IdTarif)].CalculateTimeLength(
        FDesignedSession.TimeStart, FDesignedSession.CommonPay,
        Comps[ComputersGetIndex(FDesignedSession.IdComp)].IdGroup, 0);
    FDesignedSession.TimeStop := FDesignedSession.TimeStart + tm;
  end
  else begin // TimeLength
    FDesignedSession.TimeStop := FDesignedSession.TimeStart + TimeOf(dtpTimeLength.Time);
    tdMoney := Tarifs[TarifsGetIndex(FDesignedSession.IdTarif)].CalculateCost(
        FDesignedSession.TimeStart, FDesignedSession.TimeStop,
        Comps[ComputersGetIndex(FDesignedSession.IdComp)].IdGroup, 0, True, True, 0);
//    tdMoney := Tarifs[TarifsGetIndex(FDesignedSession.IdTarif)].fnRoundMoney(tdMoney, Tarifs[TarifsGetIndex(FDesignedSession.IdTarif)].roundmoney, 1);
    FDesignedSession.CommonPay := tdMoney;
  end;
  with FDesignedSession do begin
    if not dtpStartTime.Focused then
      dtpStartTime.DateTime := TimeStart;
    if not dtpStartDate.Focused then
      dtpStartDate.DateTime := TimeStart;
    if not dtpEndTime.Focused then
      dtpEndTime.DateTime := TimeStop;
    if not dtpEndDate.Focused then
      dtpEndDate.DateTime := TimeStop;
    if not dtpTimeLength.Focused then
      dtpTimeLength.Time := TimeStop - TimeStart;
    if not editMoney.Focused then
      editMoney.Text := FormatFloat('0.00', CommonPay);
    edtTotalCost.Text := FormatFloat('0.00',
        CommonPay * IfThen((CompsSelCount < 1), 1, CompsSelCount));
  end;

  butOk.Enabled := (( HourOf(dtpTimeLength.Time)<>0 )
    or ( MinuteOf(dtpTimeLength.Time) <> 0 ))
    and not GSessions.IsBadDesignedSessions
    and (FDesignedSession.TimeStop>GetVirtualTime) ;
  /////////////////////
  d1 := HourOf(dtpTimeLength.Time);
  d2 := MinuteOf(dtpTimeLength.Time);
  d3 := SecondOf(dtpTimeLength.Time);
  d4 := MillisecondOf(dtpTimeLength.Time);
  ///////////////////
  CopyDataToGSessions;
  FfrmSessionsChart.StartTime := GetVirtualTime ;
  FfrmSessionsChart.StopTime := IncHour(GetVirtualTime,FnHoursInterval);

  FfrmSessionsChart.UpdateData;
end;

procedure TformCompStart.dtpTimeLengthChange(Sender: TObject);
begin
  SaveManualEditValue;
  UpdateInformation;
end;


procedure TformCompStart.lvTarifsClick(Sender: TObject);
var
  Whole: TTarifVariants;
begin
//  editMoney.Text := ReserveEditSumm;
  if (lvTarifs.ItemIndex = -1) then exit;
  if (lvTarifs.Items[lvTarifs.ItemIndex].Data = nil) then begin
    FState := FState - [PacketTarif] - [FreePacketTarif];
    RestoreManualEditValue;
    FDesignedSession.Description := ''; //TODO Оставить или убрать??
    FDesignedSession.IdTarif := TarifsGetId(lvTarifs.Items[lvTarifs.ItemIndex].Caption);
    FDesignedSession.Whole := 0;
    timerFrmCompStart.Enabled := true;
    timerFrmCompStartTimer(Sender);
  end
  else begin


  
    Whole := lvTarifs.Items[lvTarifs.ItemIndex].Data;
    if (Whole.FreePacket) then
      FState := FState + [FreePacketTarif] - [PacketTarif]
    else
      FState := FState + [PacketTarif] - [FreePacketTarif];
    FDesignedSession.Description := Whole.name;
    FDesignedSession.IdTarif := Whole.idTarif;
    FDesignedSession.Whole := Whole.id;
    timerFrmCompStart.Enabled := false;
  end;
  editDescription.Text := FDesignedSession.Description;
  DoDesign(False);
end;

procedure TformCompStart.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key=27) then
    butCancelClick(Nil);
end;

procedure TformCompStart.butAdvancedClick(Sender: TObject);
begin
  if (Advanced in FState) then
    FState := FState - [Advanced]
  else
    FState := FState + [Advanced];
  DoDesign(False);
end;

procedure TformCompStart.DoDesign(AbSetFocus: Boolean);
begin
// editMoney.SetFocus;
  pnlHideTotalCost.Visible := (CompsSelCount <= 1);
  cbReserve.Checked := (Reserve in FState);
  cbPostPay.Enabled := Not((OnlyPrePay in FState) or (Reserve in FState));
  cbPostPay.Checked := (PostPay in FState) and not(PacketTarif in FState)
      and not(FreePacketTarif in FState)
      and not(Reserve in FState);
  cbEndTimeMode.Enabled := not(PacketTarif in FState)
      and not ((FreePacketTarif in FState) and not (Reserve in FState))
      and not(PostPay in FState);
  cbEndTimeMode.Checked := (EndTime in FState) and not(PacketTarif in FState)
      and not ((FreePacketTarif in FState) and not (Reserve in FState))
      and not(PostPay in FState);
  gbMoneyTimeLength.Enabled := not(EndTime in FState)
      and not(PacketTarif in FState)
      and not(FreePacketTarif in FState)
      and not(PostPay in FState);
  editMoney.Enabled := gbMoneyTimeLength.Enabled;
  
  dtpTimeLength.Enabled := gbMoneyTimeLength.Enabled;
  butTimeLengthHours.Enabled := gbMoneyTimeLength.Enabled;
  butTimeLengthMinutes.Enabled := gbMoneyTimeLength.Enabled;
  gbStartTime.Enabled := (Reserve in FState)
      and not (PacketTarif in FState)
      and not ((FreePacketTarif in FState) and (EndTime in FState));
  dtpStartTime.Enabled := gbStartTime.Enabled;
  dtpStartDate.Enabled := gbStartTime.Enabled;
  butStartTimeMinutes.Enabled := gbStartTime.Enabled;
  butStartTimeHours.Enabled := gbStartTime.Enabled;
  gbEndTime.Enabled := cbEndTimeMode.Checked;//((Reserve in FState) or (EndTime in FState)) and not(PacketTarif in FState) and not(PostPay in FState);
  dtpEndTime.Enabled := gbEndTime.Enabled;
  dtpEndDate.Enabled := gbEndTime.Enabled;
  butEndTimeMinutes.Enabled := gbEndTime.Enabled;
  butEndTimeHours.Enabled := gbEndTime.Enabled;
  if (AbSetFocus) and not(PostPay in FState)
      and not(PacketTarif in FState)
      and not((FreePacketTarif in FState) and (not (EndTime in FState)
      or not (Reserve in FState)))
      then begin
    if (EndTime in FState) then
      dtpEndTime.SetFocus
    else
      if (Money in FState) then
        editMoney.SetFocus
      else
        dtpTimeLength.SetFocus;
  end;
  UpdateInformation;
  if (Reserve in FState) then
    FfrmSessionsChart.State := DesignReserve
  else
    FfrmSessionsChart.State := DesignStart;
  FfrmSessionsChart.DoDesign;

end;

procedure TformCompStart.butTimeHoursMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if TButton(Sender).Name = 'butStartTimeHours' then
    TButton(Sender).PopupMenu.Tag := Integer(dtpStartTime);
  if TButton(Sender).Name = 'butEndTimeHours' then
    TButton(Sender).PopupMenu.Tag := Integer(dtpEndTime);
  TButton(Sender).PopupMenu.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);
end;

procedure TformCompStart.TimeLengthHourClick(Sender: TObject);
begin
  FState := FState - [Money] + [TimeLength];
  DoDesign(True);
  formCompStart.dtpTimeLength.Time := StrToTime(TMenuItem(Sender).Caption);
  SaveManualEditValue;
  UpdateInformation;
end;

procedure TformCompStart.TimeLengthMinClick(Sender: TObject);
begin
  FState := FState - [Money] + [TimeLength];
  DoDesign(True);
  formCompStart.dtpTimeLength.Time := RecodeMinute(
    formCompStart.dtpTimeLength.Time,StrToInt(TMenuItem(Sender).Caption));
  SaveManualEditValue;
  UpdateInformation;
end;

procedure TformCompStart.butTimeMinutesMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if TButton(Sender).Name = 'butStartTimeMinutes' then
    TButton(Sender).PopupMenu.Tag := Integer(dtpStartTime);
  if TButton(Sender).Name = 'butEndTimeMinutes' then
    TButton(Sender).PopupMenu.Tag := Integer(dtpEndTime);
  TButton(Sender).PopupMenu.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);
end;

procedure TformCompStart.dtpTimeLengthClick(Sender: TObject);
begin
  FState := FState - [Money] + [TimeLength];
  DoDesign(True);
  SaveManualEditValue;
end;

procedure TformCompStart.editMoneyClick(Sender: TObject);
begin
  FState := FState + [Money] - [TimeLength];
  DoDesign(True);
  SaveManualEditValue;
end;

procedure TformCompStart.SaveManualEditValue;
begin
  if (Not (PostPay in FState)) and not (PacketTarif in Fstate)
      and not(not(FreePacketTarif in FState) and (not(EndTime in FState)
      or not(Reserve in FState))) then begin
    if EndTime in FState then
      FSavedValue := DateTimeToStr(dtpEndTime.DateTime)
    else begin
      if Money in FState then
        FSavedValue := editMoney.Text;
      if TimeLength in FState then
        FSavedValue := DateTimeToStr(dtpTimeLength.Time)
    end;
  end;
end;

procedure TformCompStart.RestoreManualEditValue;
begin
  if FSavedValue = '' then
    exit;
  if EndTime in FState then
    dtpEndTime.DateTime := StrToDateTime(FSavedValue)
  else begin
    if Money in FState then
      editMoney.Text := FSavedValue;
    if TimeLength in FState then
      dtpTimeLength.Time := StrToDateTime(FSavedValue);
  end;
end;

procedure TformCompStart.butEndTimeMinutesClick(Sender: TObject);
begin
  FState := FState + [EndTime];
  DoDesign(True);
end;

procedure TformCompStart.butTimeLengthMinutesClick(Sender: TObject);
begin
  FState := FState - [Money] + [TimeLength];
  DoDesign(True);
end;

procedure TformCompStart.butTimeLengthHoursClick(Sender: TObject);
begin
  FState := FState - [Money] + [TimeLength];
  DoDesign(True);
end;


procedure TformCompStart.CopyDataToGSessions;
var
  i: Integer;
  nIndex: Integer;
begin
  GSessions.PrepareDesignedForDeletion;
  for i:=0 to CompsSelCount-1 do begin
    nIndex := GSessions.IndexDesignedByIdComp(CompsSel[i]);
    if (nIndex <> -1) then begin
      if Not (FfrmSessionsChart.IsDesigned) then
        with GSessions.Items[nIndex] do begin
          IdTarif := FDesignedSession.IdTarif;
          TimeStart := FDesignedSession.TimeStart;
          TimeStop := FDesignedSession.TimeStop;
          PostPay := FDesignedSession.PostPay;
          CommonPay := FDesignedSession.CommonPay;
          CurrentCommonPay := FDesignedSession.CommonPay;
          Whole := FDesignedSession.Whole;
          Description := FDesignedSession.Description;
          Reloaded := True;
        end
    end
    else
      GSessions.Add(0,0,
          CompsSel[i],
        FDesignedSession.IdClient,
        FDesignedSession.TimeStart,
        FDesignedSession.TimeStart,
        FDesignedSession.TimeStop,
        FDesignedSession.IdTarif,
        FDesignedSession.Whole,
        FDesignedSession.PostPay,
        0,
        FDesignedSession.Description,
        FDesignedSession.CommonPay,
        FDesignedSession.CommonPay,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        FDesignedSession.State,
        ssDEsigned);
  end;
  GSessions.DeleteOldDesigned;
end;

procedure TformCompStart.RedrawTarifsList;
var
  i,j: Integer;
  li: TListItem;
  strSelectedTarif: String;
begin
  if (lvTarifs.Items.Count > 0) and (lvTarifs.Selected <> Nil) then
    strSelectedTarif := lvTarifs.Selected.Caption;
  lvTarifs.Clear;
  for i:=1 to (TarifsCount-1) do
    if OperatorSecLevel >= Tarifs[i].operatorlevel then
      if (Tarifs[i].idGroup = Comps[ComputersGetIndex(CompsSel[0])].IdGroup) then begin
        li := lvTarifs.Items.Add;
        li.Caption := Tarifs[i].name;
        li.Data := nil;
        for j:=0 to Tarifs[i].variantscount-1 do
        if (Tarifs[i].tarifvariants[j].IsAvailable(dtpStartTime.DateTime)) then
        begin
          li := lvTarifs.Items.Add;
          li.Caption := Tarifs[i].name + '-' + Tarifs[i].tarifvariants[j].name;
          li.Data := Tarifs[i].tarifvariants[j];
        end;
      end;
  lvTarifs.ItemIndex := 0;
  for i:=1 to lvTarifs.Items.Count-1 do
    if (lvTarifs.Items[i].Caption = strSelectedTarif) then
      lvTarifs.ItemIndex := i;
end;

procedure TformCompStart.UpdateInformationFromChart(AbUpdateOnlyCompList: Boolean);
var
  i,j, nIndex: Integer;
begin
{    for i:=0 to lvComps.Items.Count-1 do
      lvComps.Items.Item[i].Checked := False;
}
    nIndex := -1;
    j := 0;
    for i:=0 to GSessions.Count-1 do
      with GSessions.Items[i] do
        if (Status = ssDesigned) then begin
{          for j:=0 to lvComps.Items.Count-1 do
            if (TComputer(lvComps.Items.Item[j].Data).id = IdComp) then
              lvComps.Items.Item[j].Checked := True;}
          CompsSel[j] := IdComp;
          Inc(j);
          nIndex := i;
        end;
    if ((not AbUpdateOnlyCompList) and (nIndex <> -1)) then
      with GSessions.Items[nIndex] do begin
        dtpStartTime.DateTime := TimeStart;
        dtpEndTime.DateTime := TimeStop;
        dtpEndTime.DateTime := TimeStop;
      end;
end;

// часы и минуты у Start и End времени
procedure TformCompStart.TimeHourClick(Sender: TObject);
var
  dtp: TDateTimePicker;
  dt: TDateTime;
begin
  dtp := TDateTimePicker(TMenuItem(Sender).GetParentMenu.Tag);
  if (dtp <> Nil) then begin
    dt := StrToTime(TMenuItem(Sender).Caption);
    dtp.DateTime := RecodeTime(dtp.DateTime,HourOf(dt),MinuteOf(dt),0,0);
    UpdateInformation;
  end;
end;

procedure TformCompStart.TimeMinClick(Sender: TObject);
var
  dtp: TDateTimePicker;
begin
  dtp := TDateTimePicker(TMenuItem(Sender).GetParentMenu.Tag);
  if (dtp <> Nil) then
    dtp.DateTime := RecodeMinute(dtp.DateTime,StrToInt(TMenuItem(Sender).Caption));
  UpdateInformation;
end;

procedure TformCompStart.butStartTimeMinutesMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  TButton(Sender).PopupMenu.Tag := Integer(dtpStartTime);
  TButton(Sender).PopupMenu.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);
end;

procedure TformCompStart.butEndTimeMinutesMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  TButton(Sender).PopupMenu.Tag := Integer(dtpEndTime);
  TButton(Sender).PopupMenu.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);
end;

procedure TformCompStart.dtpEndTimeChange(Sender: TObject);
begin
  SaveManualEditValue;
  dtpEndDate.DateTime := dtpEndTime.DateTime;
  UpdateInformation;
end;

procedure TformCompStart.dtpEndDateChange(Sender: TObject);
begin
  SaveManualEditValue;
  dtpEndTime.DateTime := dtpEndDate.DateTime;
  UpdateInformation;
end;

procedure TformCompStart.dtpStartTimeChange(Sender: TObject);
begin
  dtpStartDate.DateTime := dtpStartTime.DateTime;
  UpdateInformation;
  RedrawTarifsList;
end;

procedure TformCompStart.dtpStartDateChange(Sender: TObject);
begin
  dtpStartTime.DateTime := dtpStartDate.DateTime;
  UpdateInformation;
  RedrawTarifsList;
end;

// cbEndTimeCheck
procedure TformCompStart.cbEndTimeCheck;
begin
  if (cbEndTimeMode.Checked) then begin
    FState := FState + [EndTime];
//    if dtpEndTime.DateTime <= GetVirtualTime then
//      dtpEndTime.DateTime := IncHour(GetVirtualTime,1);
    if dtpEndTime.DateTime <= dtpStartTime.DateTime then
      dtpEndTime.DateTime := IncHour(dtpStartTime.DateTime,1);
  end
  else
    FState := FState - [EndTime];
  SaveManualEditValue;
  DoDesign(True);
end;

procedure TformCompStart.cbEndTimeModeMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  cbEndTimeCheck;
end;

procedure TformCompStart.cbEndTimeModeKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  cbEndTimeCheck;
end;

//cbPostPayCcheck
procedure TformCompStart.cbPostPayCcheck;
begin
  if (cbPostPay.Checked) then
    FState := FState + [PostPay]
  else begin
    FState := FState - [PostPay];
    RestoreManualEditValue;
  end;
  DoDesign(True);
end;

procedure TformCompStart.cbPostPayMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  cbPostPayCcheck;
end;

procedure TformCompStart.cbPostPayKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  cbPostPayCcheck;
end;

// cbReserveCheck
procedure TformCompStart.cbReserveCheck;
begin
  if GRegistry.UserInterface.HideSessionChartWithoutReserve then
  begin
    DoDesignSessionChart;
    Left := (GetSystemMetrics(SM_CXFULLSCREEN) - Width) div 2;
    Top := (GetSystemMetrics(SM_CYFULLSCREEN) - Height) div 2;
  end;
  if (cbReserve.Checked) then begin
    FState := FState + [Reserve];
    CompsSelDeselect(caReserve);
    FfrmComputers.Init(caReserve);
  end else begin
    FState := FState - [Reserve];
    CompsSelDeselect(caStart);
    FfrmComputers.Init(caStart);
  end;
  DoDesign(False);
end;

procedure TformCompStart.cbReserveKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  cbReserveCheck;
end;

procedure TformCompStart.cbReserveMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  cbReserveCheck;
end;

procedure TformCompStart.radioHoursClick(Sender: TObject);
begin
  try
    FnHoursInterval := StrToInt(TRadioButton(Sender).Caption);
    DoDesign(False);
  except
  end;
end;

procedure TformCompStart.editDescriptionChange(Sender: TObject);
begin
  FDesignedSession.Description := editDescription.Text;
  UpdateInformation;
end;

procedure TformCompStart.frameSessionsChart1chartCompsClickSeries(
  Sender: TCustomChart; Series: TChartSeries; ValueIndex: Integer;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 if (Button = mbRight)
      {and (GetStatusByColor(ValueIndex) = ssReserve)} then begin
    FCanceledReserveSession := TGCSession(GSessions.FindItemID(
        StrToInt(FfrmSessionsChart.Series1.XLabel[ValueIndex])));
    if (FCanceledReserveSession <> nil)
        and (FCanceledReserveSession.Status = ssReserve)
        and FunctionAvailable(FN_RESERVE_CANCEL) then
      popupSession.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);
  end;
  FfrmSessionsChart.chartCompsClickSeries(Sender, Series, ValueIndex,
      Button, Shift, X, Y);

end;

procedure TformCompStart._OnSessionsChartSession(const ASender: TObject;
    const ASession: TGCSession;
    const AAction: TGCSessionAction);
begin
  if (ASession <> Nil) and (AAction = saReserveCancel) then
    ReserveCancel(ASession);
end;

procedure TformCompStart._OnSessionsChartChange(ASender: TObject);
begin
  UpdateInformationFromChart(False);
  UpdateInformation;
  RedrawTarifsList;
end;

procedure TformCompStart._OnComputersChange(ASender: TObject);
begin
  DoDesign(False);
end;


procedure TformCompStart.FormShow(Sender: TObject);
begin
  if editMoney.Enabled then editMoney.SetFocus;
//  ReserveEditSumm := '';
end;

procedure TformCompStart.editMoneyKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 // ReserveEditSumm := editMoney.Text;
end;

procedure TformCompStart.lvTarifsKeyPress(Sender: TObject; var Key: Char);
begin
  lvTarifsClick(Sender);
end;

end.

