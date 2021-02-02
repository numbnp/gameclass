unit FrameFour;

{$I EhLib.Inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
{$IFDEF EH_LIB_6} Variants, {$ENDIF}
  Themes, BaseFrame,
  Dialogs, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, ExtCtrls,
  GridsEh, DBGridEh, MemTableDataEh, Db, ADODB, DataDriverEh,
  ADODataDriverEh, MemTableEh, StdCtrls, DynVarsEh, EhLibVCL, DBAxisGridsEh,
  DBCtrlsEh, PlannersEh, PlannerCalendarPickerEh,
  SpreadGridsEh, PlannerDataEh, ComCtrls;

type
  TfrFrameFour = class(TMyBaseFrame)
    Panel1: TPanel;
    PaintBox1: TPaintBox;
    Label1: TLabel;
    Splitter2: TSplitter;
    Panel2: TPanel;
    bFillPlanner: TButton;
    bDayRange: TButton;
    bWeekRange: TButton;
    bMonthRange: TButton;
    CalPickerPanel: TPanel;
    Splitter1: TSplitter;
    gridResouce: TDBGridEh;
    PageControl1: TPageControl;
    tbPlannerSheet: TTabSheet;
    TabSheet2: TTabSheet;
    DBGridEh1: TDBGridEh;
    mtPlannerData: TMemTableEh;
    mtResource: TMemTableEh;
    DataSource2: TDataSource;
    CalendarPickerEh1: TPlannerCalendarPickerEh;
    PlannerControlEh1: TPlannerControlEh;
    PlannerDayViewEh1: TPlannerDayViewEh;
    PlannerWeekViewEh1: TPlannerWeekViewEh;
    PlannerMonthViewEh1: TPlannerMonthViewEh;
    PlannerVertDayslineViewEh1: TPlannerVertDayslineViewEh;
    PlannerVertHourslineViewEh1: TPlannerVertHourslineViewEh;
    PlannerHorzHourslineViewEh1: TPlannerHorzHourslineViewEh;
    PlannerHorzDayslineViewEh1: TPlannerHorzDayslineViewEh;
    PlannerDataSourceEh1: TPlannerDataSourceEh;
    Label2: TLabel;
    Bevel1: TBevel;
    ddrPlannerData: TADODataDriverEh;
    DataSource1: TDataSource;
    ddrPlannerRes: TADODataDriverEh;
    procedure PaintBox1Paint(Sender: TObject);
    procedure bDayRangeClick(Sender: TObject);
    procedure bWeekRangeClick(Sender: TObject);
    procedure bMonthRangeClick(Sender: TObject);
    procedure bFillPlannerClick(Sender: TObject);
    procedure PlannerDataSourceEh1PrepareItemsReader(
      PlannerDataSource: TPlannerDataSourceEh; RequriedStartDate, RequriedFinishDate,
      LoadedBorderDate: TDateTime; var PreparedReadyStartDate,
      PreparedFinishDate: TDateTime);
  private
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function GetResourceFilter: String;
    procedure UpdateSettings; override;
  end;

implementation

uses Unit1, CustomPlannerItemDialog, Unit_ToolsDataModule;

{$R *.dfm}

{ TfrFrameOne }

constructor TfrFrameFour.Create(AOwner: TComponent);
//var
//  OldFontHeight: Integer;
begin
  inherited Create(AOwner);
  Panel1.Height := 36;

  mtResource.Open;
  gridResouce.SelectedRows.CurrentRowSelected :=  True;
  mtResource.Next;
  gridResouce.SelectedRows.CurrentRowSelected :=  True;
  mtResource.Next;
  gridResouce.SelectedRows.CurrentRowSelected :=  True;
  mtResource.First;

end;

destructor TfrFrameFour.Destroy;
begin
  inherited Destroy;
end;

function TfrFrameFour.GetResourceFilter: String;
var
  i: Integer;
  resId: String;
//  f: TField;
begin
  Result := '';
  for i := 0 to gridResouce.SelectedRows.Count-1 do
  begin
    gridResouce.DataSource.DataSet.Bookmark := gridResouce.SelectedRows[i];
    resId := VarToStr(gridResouce.DataSource.DataSet['mid']);
//    f := gridResouce.DataSource.DataSet.FieldByName('PECOLOR');
//    if not f.IsNull then
//      Color := f.AsInteger;
    if Result <> '' then
      Result := Result + ' or ';
    Result := Result + 'res_id='''+resId+'''';
  end;
end;

procedure TfrFrameFour.bDayRangeClick(Sender: TObject);
begin
  PlannerControlEh1.ActivePlannerView := PlannerDayViewEh1;
end;

procedure TfrFrameFour.bWeekRangeClick(Sender: TObject);
begin
  PlannerControlEh1.ActivePlannerView := PlannerWeekViewEh1;
end;

procedure TfrFrameFour.bMonthRangeClick(Sender: TObject);
begin
  PlannerControlEh1.ActivePlannerView := PlannerMonthViewEh1;
end;

procedure TfrFrameFour.bFillPlannerClick(Sender: TObject);
var
  i: Integer;
  s: String;
begin

// Fill resources
  PlannerDataSourceEh1.Resources.Clear;
  for i := 0 to gridResouce.SelectedRows.Count-1 do
  begin
    with PlannerDataSourceEh1.Resources.Add do
    begin
      mtResource.Bookmark := gridResouce.SelectedRows[i];
      Name := mtResource.FieldByName('mname').AsString;
      ResourceID := mtResource.FieldByName('mid').Value;
      case i mod 4 of
        0: Color := clGreen;
        1: Color := $002684D9; //Orange
        2: Color := clNavy;
        3: Color := clPurple;
      end;
    end;
  end;

  s := GetResourceFilter;
  if s = '' then s := '1=1';

  ddrPlannerData.MacroVars.Macros['%Macro1%'] := '(' + s + ')';

//  mtPlannerData.Open;
//  PlannerDataSourceEh1.LoadTimeItems;
  PlannerControlEh1.CurrentTime := EncodeDate(2009, 3, 1);
  PlannerDataSourceEh1.ResetAutoLoadProcess;
end;

procedure TfrFrameFour.PaintBox1Paint(Sender: TObject);
begin
  Form1.FillFrameTopPanel(PaintBox1.Canvas, Rect(0, 0, PaintBox1.Width, PaintBox1.Height));
end;

procedure TfrFrameFour.PlannerDataSourceEh1PrepareItemsReader(
  PlannerDataSource: TPlannerDataSourceEh; RequriedStartDate, RequriedFinishDate,
  LoadedBorderDate: TDateTime; var PreparedReadyStartDate,
  PreparedFinishDate: TDateTime);
var
  PlanItem: TPlannerDataItemEh;
  AColor: TColor;
begin
  mtPlannerData.DataDriver := ddrPlannerData;
  ddrPlannerData.SelectCommand.Parameters[0].Value := RequriedStartDate;
  ddrPlannerData.SelectCommand.Parameters[1].Value := RequriedFinishDate;
  mtPlannerData.Close;
  mtPlannerData.Open;

  PreparedReadyStartDate := RequriedStartDate;
  PreparedFinishDate := RequriedFinishDate;

  PlannerDataSourceEh1.BeginUpdate;

  if  (PlannerDataSourceEh1.LoadedStartDate = 0) and
      (PlannerDataSourceEh1.LoadedFinishDate = 0)
  then
    PlannerDataSourceEh1.ClearItems;

  mtPlannerData.First;
  while not mtPlannerData.Eof do
  begin

    PlanItem := PlannerDataSourceEh1.NewItem();
    PlanItem.ItemID := mtPlannerData['Id'];
    PlanItem.StartTime := mtPlannerData['start_time'];
    PlanItem.EndTime := mtPlannerData['end_time'];
    PlanItem.Title := VarToStr(mtPlannerData['title']);
//      PlanItem.Body := VarToStr(mtPlannerData['Body']);
    PlanItem.AllDay := mtPlannerData.FieldByName('all_day').AsBoolean;
    PlanItem.ResourceID := mtPlannerData['res_id'];

    if VarIsNull(mtPlannerData['color'])
      then AColor := clDefault
      else AColor := mtPlannerData['color'];
    PlanItem.FillColor := ChangeColorLuminance(AColor, GetColorLuminance(clSkyBlue));

    PlannerDataSourceEh1.FetchTimePlanItem(PlanItem);

    mtPlannerData.Next;
  end;

  PlannerDataSourceEh1.EndUpdate;

end;

procedure TfrFrameFour.UpdateSettings;
begin
  inherited UpdateSettings;

  if ToolsDataModule.ShowRefToToday
    then CalendarPickerEh1.Options := CalendarPickerEh1.Options + [pcpoShowRefToTodayEh]
    else CalendarPickerEh1.Options := CalendarPickerEh1.Options - [pcpoShowRefToTodayEh];

  if ToolsDataModule.HighlightToday then
  begin
    CalendarPickerEh1.Options := CalendarPickerEh1.Options + [pcpoHighlightTodayEh];
    PlannerControlEh1.Options := PlannerControlEh1.Options + [pvoHighlightTodayEh];
  end else
  begin
    CalendarPickerEh1.Options := CalendarPickerEh1.Options - [pcpoHighlightTodayEh];
    PlannerControlEh1.Options := PlannerControlEh1.Options - [pvoHighlightTodayEh];
  end;

  if ToolsDataModule.HideNotworkHours then
  begin
    PlannerDayViewEh1.ShowWorkingTimeOnly := True;
    PlannerWeekViewEh1.ShowWorkingTimeOnly := True;
  end else
  begin
    PlannerDayViewEh1.ShowWorkingTimeOnly := False;
    PlannerWeekViewEh1.ShowWorkingTimeOnly := False;
  end;

  PlannerControlEh1.WorkingTimeStart := ToolsDataModule.WorkingTimeStart;
  PlannerControlEh1.WorkingTimeEnd := ToolsDataModule.WorkingTimeEnd;
end;

end.
