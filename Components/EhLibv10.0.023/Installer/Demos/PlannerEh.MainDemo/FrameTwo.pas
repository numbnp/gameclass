unit FrameTwo;

{$I EhLib.Inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
{$IFDEF EH_LIB_6} Variants, {$ENDIF}
  Themes,
  Dialogs, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, ExtCtrls,
  GridsEh, DBGridEh, MemTableDataEh, Db, ADODB, DataDriverEh,
  ADODataDriverEh, MemTableEh, StdCtrls, DynVarsEh, EhLibVCL, DBAxisGridsEh,
  DBCtrlsEh, PlannersEh, PlannerCalendarPickerEh, BaseFrame,
  SpreadGridsEh, PlannerDataEh, ComCtrls, CompoMansEh;

type
  TfrFrameTwo = class(TMyBaseFrame)
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
    ADODataDriverEh1: TADODataDriverEh;
    DataSource1: TDataSource;
    ADODataDriverEh2: TADODataDriverEh;
    CompoManEh1: TCompoManEh;
    procedure PaintBox1Paint(Sender: TObject);
    procedure bDayRangeClick(Sender: TObject);
    procedure bWeekRangeClick(Sender: TObject);
    procedure bMonthRangeClick(Sender: TObject);
    procedure bFillPlannerClick(Sender: TObject);
    procedure PlannerDataSourceEh1TPlannerItemSourceParamsEhFieldMap6ReadValue(
      DataSource: TPlannerDataSourceEh; MapItem: TItemSourceFieldsMapItemEh;
      const DataItem: TPlannerDataItemEh; var Processed: Boolean);
  private
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure UpdateSettings; override;
  end;

implementation

uses Unit1, CustomPlannerItemDialog, Unit_ToolsDataModule;

{$R *.dfm}

{ TfrFrameOne }

constructor TfrFrameTwo.Create(AOwner: TComponent);
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

destructor TfrFrameTwo.Destroy;
begin
  inherited Destroy;
end;

procedure TfrFrameTwo.bDayRangeClick(Sender: TObject);
begin
  PlannerControlEh1.ActivePlannerView := PlannerDayViewEh1;
end;

procedure TfrFrameTwo.bWeekRangeClick(Sender: TObject);
begin
  PlannerControlEh1.ActivePlannerView := PlannerWeekViewEh1;
end;

procedure TfrFrameTwo.bMonthRangeClick(Sender: TObject);
begin
  PlannerControlEh1.ActivePlannerView := PlannerMonthViewEh1;
end;

procedure TfrFrameTwo.bFillPlannerClick(Sender: TObject);
var
//  MapItem: TItemSourceFieldsMapItemEh;
  i: Integer;
begin
// Fill resoursec
  for i := 0 to gridResouce.SelectedRows.Count-1 do
  begin
    with PlannerDataSourceEh1.Resources.Add do
    begin
      mtResource.Bookmark := gridResouce.SelectedRows[i];
      Name := mtResource.FieldByName('mName').AsString;
      ResourceID := mtResource.FieldByName('mid').AsString;
      case i mod 4 of
        0: Color := clGreen;
        1: Color := $002684D9; //Orange
        2: Color := clNavy;
        3: Color := clPurple;
      end;
    end;
  end;


  mtPlannerData.Open;

//  PlannerDataSourceEh1.ItemSourceParams.FieldMap.BuildItems(PlannerDataSourceEh1.TimePlanItemClass);
//  PlannerDataSourceEh1.ItemSourceParams.FieldMap.Clear;

  PlannerDataSourceEh1.LoadTimeItems;
  PlannerControlEh1.CurrentTime := EncodeDate(2009, 3, 1);
end;

procedure TfrFrameTwo.PaintBox1Paint(Sender: TObject);
begin
  Form1.FillFrameTopPanel(PaintBox1.Canvas, Rect(0, 0, PaintBox1.Width, PaintBox1.Height));
end;

procedure TfrFrameTwo.PlannerDataSourceEh1TPlannerItemSourceParamsEhFieldMap6ReadValue(
  DataSource: TPlannerDataSourceEh; MapItem: TItemSourceFieldsMapItemEh;
  const DataItem: TPlannerDataItemEh; var Processed: Boolean);
var
  AColor: TColor;
begin
  if MapItem.Field.IsNull
    then AColor := clDefault
    else AColor := MapItem.Field.AsInteger;
  DataItem.FillColor := ChangeColorLuminance(AColor, GetColorLuminance(clSkyBlue));
  Processed := True;
end;

procedure TfrFrameTwo.UpdateSettings;
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
