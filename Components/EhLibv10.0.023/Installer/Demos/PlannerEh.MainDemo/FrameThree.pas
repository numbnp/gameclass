unit FrameThree;

{$I EhLib.Inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
{$IFDEF EH_LIB_6} Variants, {$ENDIF}
  Themes, DateUtils, BaseFrame,
  Dialogs, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, ExtCtrls,
  GridsEh, DBGridEh, MemTableDataEh, Db, ADODB, DataDriverEh,
  ADODataDriverEh, MemTableEh, StdCtrls, DynVarsEh, EhLibVCL, DBAxisGridsEh,
  DBCtrlsEh, PlannersEh, PlannerCalendarPickerEh,
  SpreadGridsEh, PlannerDataEh, ComCtrls;

type
  TfrFrameThree = class(TMyBaseFrame)
    Panel1: TPanel;
    PaintBox1: TPaintBox;
    Label1: TLabel;
    Splitter2: TSplitter;
    Panel2: TPanel;
    bFillPlanner: TButton;
    bEditPlanItem: TButton;
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
    bDayRange: TButton;
    bWeekRange: TButton;
    bMonthRange: TButton;
    PlannerDataSource: TDataSource;
    procedure PaintBox1Paint(Sender: TObject);
    procedure bDayRangeClick(Sender: TObject);
    procedure bWeekRangeClick(Sender: TObject);
    procedure bMonthRangeClick(Sender: TObject);
    procedure bVertTimeBand1Click(Sender: TObject);
    procedure bFillPlannerClick(Sender: TObject);
    procedure bVertTimeBand2Click(Sender: TObject);
    procedure bVertTimeBand3Click(Sender: TObject);
    procedure bVertTimeBand4Click(Sender: TObject);
    procedure bHorzTimeBand1Click(Sender: TObject);
    procedure bHorzTimeBand2Click(Sender: TObject);
    procedure bHorzTimeBand3Click(Sender: TObject);
    procedure bHorzTimeBand4Click(Sender: TObject);
    procedure PlannerControlEh1ActivePlannerViewChanged(
      PlannerControl: TPlannerControlEh;
      OldActivePlannerGrid: TCustomPlannerViewEh);
    procedure PlannerDayViewEh1SelectionChanged(Sender: TObject);
    procedure bEditPlanItemClick(Sender: TObject);
    procedure PlannerControlEh1ShowPlanItemDialog(
      PlannerControl: TPlannerControlEh; PlannerView: TCustomPlannerViewEh;
      Item: TPlannerDataItemEh; ChangeMode: TPlanItemChangeModeEh);
    procedure PlannerControlEh1CheckPlannerItemInteractiveChanging(
      PlannerControl: TPlannerControlEh; PlannerView: TCustomPlannerViewEh;
      Item, NewValuesItem: TPlannerDataItemEh; var ChangesAllowed: Boolean;
      var ErrorText: string);
    procedure PlannerControlEh1PlannerItemInteractiveChanged(
      PlannerControl: TPlannerControlEh; PlannerView: TCustomPlannerViewEh;
      Item, OldValuesItem: TPlannerDataItemEh);
  private
  protected
    procedure ReadState(Reader: TReader); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure UpdateButtonsState;
    procedure UpdateSettings; override;
  end;

implementation

uses Unit1, CustomPlannerItemDialog, Unit_ToolsDataModule;

{$R *.dfm}

{ TfrFrameOne }

constructor TfrFrameThree.Create(AOwner: TComponent);
//var
//  OldFontHeight: Integer;
begin
  inherited Create(AOwner);
  Panel1.Height := 36;

  gridResouce.SelectedRows.CurrentRowSelected :=  True;
  mtResource.Next;
  gridResouce.SelectedRows.CurrentRowSelected :=  True;
  mtResource.Next;
  gridResouce.SelectedRows.CurrentRowSelected :=  True;
  mtResource.First;

end;

destructor TfrFrameThree.Destroy;
begin
  inherited Destroy;
end;

procedure TfrFrameThree.bDayRangeClick(Sender: TObject);
begin
  PlannerControlEh1.ActivePlannerView := PlannerDayViewEh1;
end;

procedure TfrFrameThree.bWeekRangeClick(Sender: TObject);
begin
  PlannerControlEh1.ActivePlannerView := PlannerWeekViewEh1;
end;

procedure TfrFrameThree.bEditPlanItemClick(Sender: TObject);
begin
  if PlannerControlEh1.ActivePlannerView.SelectedPlanItem <> nil then
    PlannerControlEh1.ShowModifyPlanItemDialog(PlannerControlEh1.ActivePlannerView.SelectedPlanItem);
//    PlannerControlEh1.ShowNewPlanItemDialog);
end;

procedure TfrFrameThree.bFillPlannerClick(Sender: TObject);
var
  FFilePath: String;
  i: Integer;
  PlanItem: TPlannerDataItemEh;
begin
  if FileExists(ExtractFilePath(ParamStr(0))+'\mtPlannerData.dfm') then
    FFilePath := ExtractFilePath(ParamStr(0))+'\mtPlannerData.dfm'
  else if FileExists(ExtractFilePath(ParamStr(0))+'..\..\mtPlannerData.dfm') then
    FFilePath := ExtractFilePath(ParamStr(0))+'..\..\mtPlannerData.dfm'
  else if FileExists(ExtractFilePath(ParamStr(0))+'..\..\..\mtPlannerData.dfm') then
    FFilePath := ExtractFilePath(ParamStr(0))+'..\..\..\mtPlannerData.dfm';

  if FFilePath <> '' then
    mtPlannerData.LoadFromFile(FFilePath)
  else
  begin
    ShowMessage('File "mtPlannerData.dfm" is not found');
    Exit;
  end;

  PlannerDataSourceEh1.BeginUpdate;

  PlannerDataSourceEh1.Resources.Clear;

// Fill resoursec
  for i := 0 to gridResouce.SelectedRows.Count-1 do
  begin
    with PlannerDataSourceEh1.Resources.Add do
    begin
      mtResource.Bookmark := gridResouce.SelectedRows[i];
      Name := mtResource.FieldByName('Name').AsString;
      ResourceID := i;
      case i mod 4 of
        0: Color := clGreen;
        1: Color := $002684D9; //ORange
        2: Color := clNavy;
        3: Color := clPurple;
      end;
    end;
  end;


  PlannerDataSourceEh1.ClearItems;

  mtPlannerData.First;
  while not mtPlannerData.Eof do
  begin

    if mtPlannerData.FieldByName('InPlanner').AsBoolean = True then
    begin

      PlanItem := PlannerDataSourceEh1.NewItem();

      PlanItem.ItemID := mtPlannerData['Id'];
      PlanItem.StartTime := mtPlannerData['StartTime'];
      PlanItem.EndTime := mtPlannerData['EndTime'];
      PlanItem.Title := VarToStr(mtPlannerData['Title']);
      PlanItem.Body := VarToStr(mtPlannerData['Body']);
      PlanItem.AllDay := mtPlannerData.FieldByName('AllDay').AsBoolean;
      PlanItem.ResourceID := mtPlannerData['ResourceID'];

      PlannerDataSourceEh1.FetchTimePlanItem(PlanItem);

    end;
    mtPlannerData.Next;
  end;

  PlannerDataSourceEh1.EndUpdate;

  PlannerControlEh1.CurrentTime := EncodeDate(2015, 01, 14);
end;

procedure TfrFrameThree.bMonthRangeClick(Sender: TObject);
begin
  PlannerControlEh1.ActivePlannerView := PlannerMonthViewEh1;
end;

procedure TfrFrameThree.bVertTimeBand1Click(Sender: TObject);
begin
  PlannerControlEh1.ActivePlannerView := PlannerVertHourslineViewEh1;
  PlannerVertHourslineViewEh1.TimeRange := hlrDayEh;
end;

procedure TfrFrameThree.bVertTimeBand2Click(Sender: TObject);
begin
  PlannerControlEh1.ActivePlannerView := PlannerVertHourslineViewEh1;
  PlannerVertHourslineViewEh1.TimeRange := hlrWeekEh;
end;

procedure TfrFrameThree.bVertTimeBand3Click(Sender: TObject);
begin
  PlannerControlEh1.ActivePlannerView := PlannerVertDayslineViewEh1;
  PlannerVertDayslineViewEh1.TimeRange := dlrWeekEh;
end;

procedure TfrFrameThree.bVertTimeBand4Click(Sender: TObject);
begin
  PlannerControlEh1.ActivePlannerView := PlannerVertDayslineViewEh1;
  PlannerVertDayslineViewEh1.TimeRange := dlrMonthEh;
end;

procedure TfrFrameThree.bHorzTimeBand1Click(Sender: TObject);
begin
  PlannerControlEh1.ActivePlannerView := PlannerHorzHourslineViewEh1;
  PlannerHorzHourslineViewEh1.TimeRange := hlrDayEh;
end;

procedure TfrFrameThree.bHorzTimeBand2Click(Sender: TObject);
begin
  PlannerControlEh1.ActivePlannerView := PlannerHorzHourslineViewEh1;
  PlannerHorzHourslineViewEh1.TimeRange := hlrWeekEh;
end;

procedure TfrFrameThree.bHorzTimeBand3Click(Sender: TObject);
begin
  PlannerControlEh1.ActivePlannerView := PlannerHorzDayslineViewEh1;
  PlannerHorzDayslineViewEh1.TimeRange := dlrWeekEh;
end;

procedure TfrFrameThree.bHorzTimeBand4Click(Sender: TObject);
begin
  PlannerControlEh1.ActivePlannerView := PlannerHorzDayslineViewEh1;
  PlannerHorzDayslineViewEh1.TimeRange := dlrMonthEh;
end;

procedure TfrFrameThree.PaintBox1Paint(Sender: TObject);
begin
  Form1.FillFrameTopPanel(PaintBox1.Canvas, Rect(0, 0, PaintBox1.Width, PaintBox1.Height));
end;

procedure TfrFrameThree.PlannerControlEh1ActivePlannerViewChanged(
  PlannerControl: TPlannerControlEh;
  OldActivePlannerGrid: TCustomPlannerViewEh);
begin
  UpdateButtonsState;
end;

procedure TfrFrameThree.PlannerControlEh1CheckPlannerItemInteractiveChanging(
  PlannerControl: TPlannerControlEh; PlannerView: TCustomPlannerViewEh; Item,
  NewValuesItem: TPlannerDataItemEh; var ChangesAllowed: Boolean;
  var ErrorText: string);
begin
  if DateOf(NewValuesItem.StartTime) <> DateOf(NewValuesItem.EndTime) then
  begin
    ErrorText := 'Crossing the border of the day is not allowed';
    ChangesAllowed := False;
  end;
end;

procedure TfrFrameThree.PlannerControlEh1PlannerItemInteractiveChanged(
  PlannerControl: TPlannerControlEh; PlannerView: TCustomPlannerViewEh; Item,
  OldValuesItem: TPlannerDataItemEh);
begin
  if mtPlannerData.Locate('Id', Item.ItemID, []) then
  begin
    mtPlannerData.Edit;
    mtPlannerData['StartTime'] := Item.StartTime;
    mtPlannerData['EndTime'] := Item.EndTime;
    mtPlannerData.FieldByName('AllDay').AsBoolean := Item.AllDay;
    mtPlannerData['ResourceID'] := Item.ResourceID;
    mtPlannerData.Post;
  end else
  begin
    ShowMessage('Can''t find PlannerItem with ID: ' + VarToStr(Item.ItemID));
  end;
end;

procedure TfrFrameThree.PlannerControlEh1ShowPlanItemDialog(
  PlannerControl: TPlannerControlEh; PlannerView: TCustomPlannerViewEh;
  Item: TPlannerDataItemEh; ChangeMode: TPlanItemChangeModeEh);
begin
  if ChangeMode = picmModifyEh then
    CustomEditPlanItem(Item, mtPlannerData)
  else
    CustomEditNewItem(PlannerControl, mtPlannerData);
end;

procedure TfrFrameThree.PlannerDayViewEh1SelectionChanged(Sender: TObject);
begin
  UpdateButtonsState;
end;

procedure TfrFrameThree.ReadState(Reader: TReader);
begin
  inherited ReadState(Reader);
end;

procedure TfrFrameThree.UpdateButtonsState;
begin
  bEditPlanItem.Enabled :=
    (PlannerControlEh1.ActivePlannerView <> nil) and
    (PlannerControlEh1.ActivePlannerView.SelectedPlanItem <> nil);
end;

procedure TfrFrameThree.UpdateSettings;
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
