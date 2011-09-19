unit ufrmSessionsChart;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  TeEngine, Series, StdCtrls, ExtCtrls, TeeProcs, Chart, DbChart, DB, ADODB,
  DBClient, GanttCh, GCSessions, Menus;

type
//    Fmm: Boolean;
  TfrmSessionsChartState = (DesignStart, DesignReserve, View);

  TfrmSessionsChart = class(TForm)
    chartComps: TDBChart;
    Series1: TGanttSeries;
    sbarVertical: TScrollBar;
    popupSession: TPopupMenu;
    mnuCancel: TMenuItem;
    procedure chartCompsClickSeries(Sender: TCustomChart;
      Series: TChartSeries; ValueIndex: Integer; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure chartCompsMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure chartCompsMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure chartCompsGetAxisLabel(Sender: TChartAxis;
      Series: TChartSeries; ValueIndex: Integer; var LabelText: String);
    procedure chartCompsClickBackground(Sender: TCustomChart;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure sbarVerticalChange(Sender: TObject);
    procedure mnuCancelClick(Sender: TObject);
  private
    { Private declarations }
    FbDesigned : Boolean;
    FCurrentSeries: THorizBarSeries;
    FCurrentX: Integer;
    FCurrentY: Integer;
    FCurrentIndex: Integer;
    FCurrentSession: TGCSession;
    FStartTime: TDateTime;
    FStopTime: TDateTime;
    FT :TNotifyEvent;
    FnState: TfrmSessionsChartState;
    FfMinCompIndex: Double; //Нужно когда компов >20
    FbScrolling : Boolean;
    FSessionEvent: TGCSessionEvent;
    FChangeEvent: TNotifyEvent;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  { Public declarations }
    procedure Activate;
    procedure UpdateData;
    procedure UpdateGSessions;

    procedure DoDesign;
    procedure SeriesOnGetMarkText( Sender : TChartSeries ;  ValueIndex : Longint ;  Var MarkText : String );
//    property IsDesigned: Boolean read FbIsDesigned write FbIsDesigned;
//    property OnTimer: TNotifyEvent read FT write FT;
    property OnSession: TGCSessionEvent
        read FSessionEvent write FSessionEvent;
    property OnChange: TNotifyEvent
        read FChangeEvent write FChangeEvent;
    function GetGanntColor(Asession: TGCSession):TColor;
    function IsBadDesignedChart:Boolean;
    function GetStatusByColor(nGanntIndex: Integer): TGCSessionStatus;
  published
    property IsDesigned: Boolean read FbDesigned write FbDesigned;
    property State: TfrmSessionsChartState read FnState write FnState;
    property StartTime: TDateTime read FStartTime write FStartTime;
    property StopTime: TDateTime read FStopTime write FStopTime;
    property MinCompIndex: Double read FfMinCompIndex write FfMinCompIndex;
  end;

implementation
uses GCComputers,
     GCLangUtils,
     Variants,
     gccommon,
     DateUtils,
     Math,
     GCConst,
     uVirtualTime,
     GCFunctions;

{$R *.dfm}
constructor TfrmSessionsChart.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FSessionEvent := Nil;
  FChangeEvent := Nil;
  FbDesigned := False;
  FCurrentSeries := Nil;
  FnState := View;
  FfMinCompIndex := -0.5;
  FbScrolling := False;
  FStartTime := GetVirtualTime;
  FStopTime := IncHour(FStartTime,12);
  Series1.GetHorizAxis.Increment := (FStopTime - FStartTime) /12;
end;

destructor TfrmSessionsChart.Destroy;
begin
  inherited Destroy;
end;

procedure TfrmSessionsChart.UpdateData;
var
  nSessionIndex, nGanntIndex, nGanntCount: Integer;
begin
//логика такая: новые сессии добавляются только в конец коллекции, следовательно
//если ID в Gannt не совпадает то элемент надо грохнуть
  nSessionIndex := 0;
  nGanntIndex := 0;
  nGanntCount := Series1.Count;
  while ((nSessionIndex < GSessions.Count) or (nGanntIndex < nGanntCount)) do begin
    if ((nSessionIndex < GSessions.Count) and (nGanntIndex >= nGanntCount)) then begin
      //Add
      with GSessions.Items[nSessionIndex] do
        Series1.AddGanttColor(TimeStart,TimeStop,ComputersGetIndex(IdComp),IntToStr(ID),GetGanntColor(GSessions.Items[nSessionIndex]));
      Inc(nSessionIndex);
    end;
    if ((nSessionIndex >= GSessions.Count) and (nGanntIndex < nGanntCount)) then begin
      //Del
      Series1.Delete(nGanntIndex);
      Dec(nGanntCount);
    end;
    if ((nSessionIndex < GSessions.Count) and (nGanntIndex < nGanntCount)) then begin
      if (GSessions.Items[nSessionIndex].Id = StrToInt(Series1.XLabel[nGanntIndex])) then begin
        //Update
        with GSessions.Items[nSessionIndex] do
          if Not((Status = ssDesigned) and (IsDesigned)) then begin
            Series1.StartValues[nGanntIndex] := TimeStart;
            Series1.EndValues[nGanntIndex] := TimeStop;
            Series1.YValue[nGanntIndex] := ComputersGetIndex(IdComp);
            Series1.ValueColor[nGanntIndex] := GetGanntColor(GSessions.Items[nSessionIndex]);
          end;
        Inc(nSessionIndex);
        Inc(nGanntIndex);
      end
      else begin
        //Del
        Series1.Delete(nGanntIndex);
        Dec(nGanntCount);
      end;
    end;
  end;
end;

procedure TfrmSessionsChart.UpdateGSessions;
var
  nSessionIndex, nGanntIndex, nGanntCount: Integer;
begin
//логика такая: новые сессии добавляются только в конец коллекции, следовательно
//если ID в Gannt не совпадает то элемент надо грохнуть
  for nGanntIndex := 0 to Series1.Count -1 do
{    if ((Series1.ValueColor[FCurrentIndex] = SESSIONS_CHART_COLOR_DESIGNED_BAD) or
       (Series1.ValueColor[FCurrentIndex] = SESSIONS_CHART_COLOR_DESIGNED)) then} begin
    nSessionIndex := GSessions.IndexDesignedByIdCollection(StrToInt(Series1.XLabel[nGanntIndex]));
    if nSessionIndex<>-1 then
      with GSessions.Items[nSessionIndex] do begin
        TimeStart := Series1.StartValues[nGanntIndex];
        TimeStop := Series1.EndValues[nGanntIndex];
        IdComp := Comps[Round(Series1.YValues[nGanntIndex])].id;
    end;
  end;
end;


procedure TfrmSessionsChart.DoDesign;
var min,max:Double;
begin
  chartComps.BottomAxis.Automatic := False;
//  if FStartTime > FStopTime then
//    FStopTime := IncFStartTime
  if FStartTime <= chartComps.BottomAxis.Maximum then begin
    chartComps.BottomAxis.Minimum := FStartTime;
    chartComps.BottomAxis.Maximum := FStopTime;
  end
  else begin
    chartComps.BottomAxis.Maximum := FStopTime;
    chartComps.BottomAxis.Minimum := FStartTime;
  end;
  chartComps.BottomAxis.Increment := (FStopTime - FStartTime) /12;
  chartComps.LeftAxis.Automatic := False;
//'  chartComps.LeftAxis.Minimum := -1;
//'  chartComps.LeftAxis.Maximum := CompsCount;
  chartComps.LeftAxis.Increment := 1;
  chartComps.LeftAxis.SetMinMax(FfMinCompIndex,IfThen(CompsCount<=20,CompsCount-0.5,FfMinCompIndex+20));
//  sbarVertical.SetParams(Round(FfMinCompIndex*10),0,CompsCount*10-210);
  if CompsCount>20 then
    sbarVertical.Position := Round(FfMinCompIndex*10);
  chartComps.LeftAxis.LabelsOnAxis := False;
  chartComps.LeftAxis.DrawAxisLabel(0,1,180,'9');
//	Series1.Pointer.VertSize:=1;
end;

procedure TfrmSessionsChart.chartCompsClickSeries(Sender: TCustomChart;
  Series: TChartSeries; ValueIndex: Integer; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (Button = mbRight)
      {and (GetStatusByColor(ValueIndex) = ssReserve)} then begin
    FCurrentSession := TGCSession(GSessions.FindItemID(
        StrToInt(Series1.XLabel[ValueIndex])));
    if (FCurrentSession <> nil)
        and (FCurrentSession.Status = ssReserve)
        and FunctionAvailable(FN_RESERVE_CANCEL) then
      popupSession.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);
  end;

	FCurrentIndex := ValueIndex;
  FCurrentX:=X;
  FCurrentY:=Y;
  if (((State = DesignReserve) or (State = DesignStart)) and
    (GetStatusByColor(FCurrentIndex) = ssDesigned)) then
    FbDesigned := True;
end;

procedure TfrmSessionsChart.chartCompsMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  fDX,fDY : Double;
  i : Integer;
begin
  if (ssLeft in Shift) and FbDesigned then begin
    fDY:=Series1.YScreenToValue(Y)-Series1.YScreenToValue(FCurrentY);
    Series1.YValues[FCurrentIndex] :=Series1.YValues[FCurrentIndex]+fDY;
    FCurrentY := Y;
    if (State = DesignReserve) then begin
      fDX:=Series1.XScreenToValue(X)-Series1.XScreenToValue(FCurrentX);
      Series1.EndValues[FCurrentIndex] :=Series1.EndValues[FCurrentIndex]+fDX;
      Series1.StartValues[FCurrentIndex] :=Series1.StartValues[FCurrentIndex]+fDX;
      FCurrentX := X;
    end;
    if IsBadDesignedChart then
      Series1.ValueColor[FCurrentIndex] := SESSIONS_CHART_COLOR_DESIGNED_BAD
    else
      Series1.ValueColor[FCurrentIndex] := SESSIONS_CHART_COLOR_DESIGNED;
    for i:=0 to Series1.Count-1 do
      if (FCurrentIndex <> i) and (GetStatusByColor(i) = ssDesigned) then
        with Series1 do begin
          EndValues[i] :=EndValues[FCurrentIndex];
          StartValues[i] :=StartValues[FCurrentIndex];
          ValueColor[i] := ValueColor[FCurrentIndex];
        end;
    Series1.Repaint;
  end;
  if (ssLeft in Shift) and FbScrolling then begin
    fDY:=Series1.YScreenToValue(Y)-Series1.YScreenToValue(FCurrentY);
    FfMinCompIndex :=FfMinCompIndex-fDY;
    if (FfMinCompIndex < -0.5) then
      FfMinCompIndex := -0.5;
    if (FfMinCompIndex > CompsCount-20.5) then
      FfMinCompIndex := CompsCount-20.5;

    FCurrentY := Y;
//'    Series1.Repaint;
    DoDesign;
  end;
end;

procedure TfrmSessionsChart.chartCompsMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  fY: Double;
begin
{  if (Button = mbRight) and not FbDesigned then begin
    Series1.YValues[FCurrentIndex];
    Series1.Repaint;
  end;}
  if (Button = mbLeft) and FbDesigned then begin
    fY := RoundTo(Series1.YValues[FCurrentIndex],0);
    if (fY < 0) then
      fY := 0;
    if (fY >= CompsCount) then
      fY := CompsCount-1;
    Series1.YValues[FCurrentIndex] := fY;
    Series1.Repaint;
  end;
  FbDesigned := false;
  FbScrolling := false;
  if not IsBadDesignedChart then begin
    UpdateGSessions;
    if Assigned(FChangeEvent) then
      FChangeEvent(Self);
  end;
end;



procedure TfrmSessionsChart.chartCompsGetAxisLabel(Sender: TChartAxis;
  Series: TChartSeries; ValueIndex: Integer; var LabelText: String);
var
  nIndex: Integer;
begin
  if ( Sender = chartComps.LeftAxis ) then
    try
      nIndex := trunc(StrToFloat(LabelText));
      if (nIndex>=0) and (nIndex<CompsCount) then
        LabelText := IntToStr(Comps[nIndex].number);
    except;
    end;
end;

procedure TfrmSessionsChart.Activate;
var
  i: Integer;
begin
  DoDesign;
  UpdateData;
  if CompsCount>20 then begin
    sbarVertical.Visible := True;
    sbarVertical.SetParams(-5,-5,CompsCount*10-205);
  end
  else
    sbarVertical.Visible := False;
end;

procedure TfrmSessionsChart.SeriesOnGetMarkText( Sender : TChartSeries ;  ValueIndex : Longint ;  Var MarkText : String );
begin
  if (Series1.Pointer.VertSize<>1) then
    MarkText := 'dfffff';
end;

function TfrmSessionsChart.GetGanntColor(Asession: TGCSession):TColor;
begin
  case Asession.Status of
    ssReserve: Result := SESSIONS_CHART_COLOR_RESERVE;
    ssActive: begin
      Result := SESSIONS_CHART_COLOR_ACTIVE;
      if (Asession.IdTarif = ID_TARIF_REMONT) then
        Result := SESSIONS_CHART_COLOR_REMONT;
    end;
    ssFinished: Result := SESSIONS_CHART_COLOR_FINISHED;
    ssDesigned:
      if GSessions.IsBadDesignedSessions then
        Result := SESSIONS_CHART_COLOR_DESIGNED_BAD
      else
        Result := SESSIONS_CHART_COLOR_DESIGNED;
  end;
end;

function TfrmSessionsChart.IsBadDesignedChart:Boolean;
var
  i,j:Integer;
  bBad:Boolean;
  fInterval : Double;
begin
  bBad := False;
  fInterval := EncodeTime(0,1,0,0);//0.001; //Должно быть 1 минута
  with Series1 do
    for i:=0 to Count-1 do
      if (GetStatusByColor(i) = ssDesigned) then
        for j:=0 to Count-1 do
          if (i<>j) and (Abs(YValue[i] - YValue[j])<0.5) and
            ((GetStatusByColor(j) = ssDesigned) or
             ((GetStatusByColor(j) <> ssDesigned) and
              (
               ((StartValues[i] >= (StartValues[j] + fInterval)) or (EndValues[i] >= (StartValues[j] + fInterval))) and
               ((StartValues[i] <= (EndValues[j] - fInterval)) or (EndValues[i] <= (EndValues[j] - fInterval))))
              )
             ) then
          bBad := True;
  Result := bBad;
end;

function TfrmSessionsChart.GetStatusByColor(nGanntIndex: Integer): TGCSessionStatus;
begin
  case Series1.ValueColor[nGanntIndex] of
    SESSIONS_CHART_COLOR_RESERVE: Result := ssReserve;
    SESSIONS_CHART_COLOR_ACTIVE: Result := ssActive;
    SESSIONS_CHART_COLOR_REMONT: Result := ssActive;
    SESSIONS_CHART_COLOR_FINISHED: Result := ssFinished;
    SESSIONS_CHART_COLOR_DESIGNED: Result := ssDesigned;
    SESSIONS_CHART_COLOR_DESIGNED_BAD: Result := ssDesigned;
  end;
end;

procedure TfrmSessionsChart.chartCompsClickBackground(
  Sender: TCustomChart; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  if CompsCount>20 then begin
    FCurrentX:=X;
    FCurrentY:=Y;
    FbScrolling := True;
  end;
end;

procedure TfrmSessionsChart.sbarVerticalChange(Sender: TObject);
begin
  if CompsCount>20 then begin
    FfMinCompIndex := sbarVertical.Position/10;
    DoDesign;
  end;
end;

procedure TfrmSessionsChart.mnuCancelClick(Sender: TObject);
begin
  if Assigned(FSessionEvent) then
    FSessionEvent(Self, FCurrentSession, saReserveCancel);
end;

end.
