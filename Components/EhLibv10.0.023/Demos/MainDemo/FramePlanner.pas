unit FramePlanner;

{$I EhLib.Inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
{$IFDEF EH_LIB_6} Variants, {$ENDIF}
  Themes, DateUtils,
  Dialogs, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, ExtCtrls,
  GridsEh, DBGridEh, MemTableDataEh, Db, ADODB, DataDriverEh,
  ADODataDriverEh, MemTableEh, StdCtrls, DynVarsEh, EhLibVCL, DBAxisGridsEh,
  DBCtrlsEh, PlannersEh, PlannerCalendarPickerEh,
  SpreadGridsEh, PlannerDataEh, ComCtrls, CompoMansEh, YearPlannersEh;

type
  TfrPlanner = class(TFrame)
    Panel1: TPanel;
    PaintBox1: TPaintBox;
    Label1: TLabel;
    Splitter2: TSplitter;
    Panel2: TPanel;
    bFillPlanner: TButton;
    bDayRange: TButton;
    bWeekRange: TButton;
    bMonthRange: TButton;
    NewPlanItem: TButton;
    DBCheckBoxEh1: TDBCheckBoxEh;
    bVertTimeBand1: TButton;
    bHorzTimeBand1: TButton;
    bVertTimeBand2: TButton;
    bVertTimeBand3: TButton;
    bVertTimeBand4: TButton;
    bHorzTimeBand2: TButton;
    bHorzTimeBand3: TButton;
    bHorzTimeBand4: TButton;
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
    DataSource1: TDataSource;
    CompoManEh1: TCompoManEh;
    PlannerHorzYearViewEh1: TPlannerHorzYearViewEh;
    bYearRange: TButton;
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
    procedure PlannerControlEh1CheckPlannerItemInteractiveChanging(
      PlannerControl: TPlannerControlEh; PlannerView: TCustomPlannerViewEh;
      Item, NewValuesItem: TPlannerDataItemEh; var ChangesAllowed: Boolean;
      var ErrorText: string);
    procedure PlannerDataSourceEh1ApplyUpdateToDataStorage(
      PlannerDataSource: TPlannerDataSourceEh; PlanItem: TPlannerDataItemEh;
      UpdateStatus: TUpdateStatus);
    procedure NewPlanItemClick(Sender: TObject);
    procedure bYearRangeClick(Sender: TObject);
  private
    FButtons: TList;
  {$IFDEF EH_LIB_26} //10.3
  {$ELSE}
    FScaleFactor: Single;
  {$ENDIF}
  protected
    procedure ReadState(Reader: TReader); override;
    procedure ResetButtons(ActiveButton: TButton);
    procedure ChangeScale(M, D: Integer {$IFDEF EH_LIB_24}; isDpiChange: Boolean {$ENDIF}); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

  {$IFDEF EH_LIB_26} //10.3
  {$ELSE}
    property ScaleFactor: Single read FScaleFactor;
  {$ENDIF}
  end;

implementation

uses Unit1;

{$R *.dfm}

{ TfrFrameOne }

constructor TfrPlanner.Create(AOwner: TComponent);
//var
//  OldFontHeight: Integer;
begin
  inherited Create(AOwner);
  Panel1.Height := 36;

  FButtons := TList.Create;
  FButtons.Add(bDayRange);
  FButtons.Add(bWeekRange);
  FButtons.Add(bMonthRange);
  FButtons.Add(bYearRange);
  FButtons.Add(bVertTimeBand1);
  FButtons.Add(bVertTimeBand2);
  FButtons.Add(bVertTimeBand3);
  FButtons.Add(bVertTimeBand4);
  FButtons.Add(bHorzTimeBand1);
  FButtons.Add(bHorzTimeBand2);
  FButtons.Add(bHorzTimeBand3);
  FButtons.Add(bHorzTimeBand4);
  ResetButtons(bDayRange);

  gridResouce.SelectedRows.CurrentRowSelected :=  True;
  mtResource.Next;
  gridResouce.SelectedRows.CurrentRowSelected :=  True;
  mtResource.Next;
  gridResouce.SelectedRows.CurrentRowSelected :=  True;
  mtResource.First;

end;

destructor TfrPlanner.Destroy;
begin
  FreeAndNil(FButtons);
  inherited Destroy;
end;

procedure TfrPlanner.ChangeScale(M, D: Integer {$IFDEF EH_LIB_24}; isDpiChange: Boolean {$ENDIF});
begin
  if M <> D then
  begin
  {$IFNDEF EH_LIB_26} //10.3
    FScaleFactor := FScaleFactor * M / D;
  {$ENDIF}
  end;
  inherited ChangeScale(M, D {$IFDEF EH_LIB_24}, isDpiChange{$ENDIF});
end;

procedure TfrPlanner.ResetButtons(ActiveButton: TButton);
var
  i :Integer;
  Pos: Integer;
  ButWidth: Integer;
begin
  Pos := TButton(FButtons[0]).Left;
  ButWidth := Round(30 * ScaleFactor);
  for i := 0 to FButtons.Count-1 do
  begin
    TButton(FButtons[i]).Left := Pos;
    if FButtons[i] = ActiveButton then
      TButton(FButtons[i]).Width := Round(100 * ScaleFactor)
    else
      TButton(FButtons[i]).Width := ButWidth;
    Pos := Pos + TButton(FButtons[i]).Width;
  end;
end;

procedure TfrPlanner.PlannerDataSourceEh1ApplyUpdateToDataStorage(
  PlannerDataSource: TPlannerDataSourceEh; PlanItem: TPlannerDataItemEh;
  UpdateStatus: TUpdateStatus);
begin
  if UpdateStatus = usModified then
  begin
    if mtPlannerData.Locate('Id', PlanItem.ItemID, []) then
    begin
      mtPlannerData.Edit;
      mtPlannerData['StartTime'] := PlanItem.StartTime;
      mtPlannerData['EndTime'] := PlanItem.EndTime;
      mtPlannerData['Title'] := PlanItem.Title;
      mtPlannerData['Body'] := PlanItem.Body;
      mtPlannerData['AllDay'] := PlanItem.AllDay;
      mtPlannerData['ResourceID'] := PlanItem.ResourceID;
      mtPlannerData.Post;
    end else
      raise Exception.Create('Can'' locate record with "Id"='+VarToStrDef(PlanItem.ItemID, '<Null>'));
  end else if UpdateStatus = usInserted then
  begin
    mtPlannerData.Append;
    mtPlannerData['StartTime'] := PlanItem.StartTime;
    mtPlannerData['EndTime'] := PlanItem.EndTime;
    mtPlannerData['Title'] := PlanItem.Title;
    mtPlannerData['Body'] := PlanItem.Body;
    mtPlannerData['AllDay'] := PlanItem.AllDay;
    mtPlannerData['ResourceID'] := PlanItem.ResourceID;
    mtPlannerData.Post;
    PlanItem.ItemID := mtPlannerData['Id'];
  end else if UpdateStatus = usDeleted then
  begin
    if mtPlannerData.Locate('Id', PlanItem.ItemID, []) then
    begin
      mtPlannerData.Delete;
    end else
      raise Exception.Create('Can'' locate record with "Id"='+VarToStrDef(PlanItem.ItemID, '<Null>'));
  end;
end;

procedure TfrPlanner.bDayRangeClick(Sender: TObject);
begin
  PlannerControlEh1.ActivePlannerView := PlannerDayViewEh1;
  ResetButtons(TButton(Sender));
end;

procedure TfrPlanner.bWeekRangeClick(Sender: TObject);
begin
  PlannerControlEh1.ActivePlannerView := PlannerWeekViewEh1;
  ResetButtons(TButton(Sender));
end;

procedure TfrPlanner.bFillPlannerClick(Sender: TObject);
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
        1: Color := $002684D9; //Orange
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
  PageControl1.ActivePageIndex := 0;
end;

procedure TfrPlanner.bMonthRangeClick(Sender: TObject);
begin
  PlannerControlEh1.ActivePlannerView := PlannerMonthViewEh1;
  ResetButtons(TButton(Sender));
end;

procedure TfrPlanner.bYearRangeClick(Sender: TObject);
begin
  PlannerControlEh1.ActivePlannerView := PlannerHorzYearViewEh1;
  ResetButtons(TButton(Sender));
end;

procedure TfrPlanner.bVertTimeBand1Click(Sender: TObject);
begin
  PlannerControlEh1.ActivePlannerView := PlannerVertHourslineViewEh1;
  PlannerVertHourslineViewEh1.TimeRange := hlrDayEh;
  ResetButtons(TButton(Sender));
end;

procedure TfrPlanner.bVertTimeBand2Click(Sender: TObject);
begin
  PlannerControlEh1.ActivePlannerView := PlannerVertHourslineViewEh1;
  PlannerVertHourslineViewEh1.TimeRange := hlrWeekEh;
  ResetButtons(TButton(Sender));
end;

procedure TfrPlanner.bVertTimeBand3Click(Sender: TObject);
begin
  PlannerControlEh1.ActivePlannerView := PlannerVertDayslineViewEh1;
  PlannerVertDayslineViewEh1.TimeRange := dlrWeekEh;
  ResetButtons(TButton(Sender));
end;

procedure TfrPlanner.bVertTimeBand4Click(Sender: TObject);
begin
  PlannerControlEh1.ActivePlannerView := PlannerVertDayslineViewEh1;
  PlannerVertDayslineViewEh1.TimeRange := dlrMonthEh;
  ResetButtons(TButton(Sender));
end;

procedure TfrPlanner.bHorzTimeBand1Click(Sender: TObject);
begin
  PlannerControlEh1.ActivePlannerView := PlannerHorzHourslineViewEh1;
  PlannerHorzHourslineViewEh1.TimeRange := hlrDayEh;
  ResetButtons(TButton(Sender));
end;

procedure TfrPlanner.bHorzTimeBand2Click(Sender: TObject);
begin
  PlannerControlEh1.ActivePlannerView := PlannerHorzHourslineViewEh1;
  PlannerHorzHourslineViewEh1.TimeRange := hlrWeekEh;
  ResetButtons(TButton(Sender));
end;

procedure TfrPlanner.bHorzTimeBand3Click(Sender: TObject);
begin
  PlannerControlEh1.ActivePlannerView := PlannerHorzDayslineViewEh1;
  PlannerHorzDayslineViewEh1.TimeRange := dlrWeekEh;
  ResetButtons(TButton(Sender));
end;

procedure TfrPlanner.bHorzTimeBand4Click(Sender: TObject);
begin
  PlannerControlEh1.ActivePlannerView := PlannerHorzDayslineViewEh1;
  PlannerHorzDayslineViewEh1.TimeRange := dlrMonthEh;
  ResetButtons(TButton(Sender));
end;

procedure TfrPlanner.PaintBox1Paint(Sender: TObject);
begin
  Form1.FillFrameTopPanel(PaintBox1.Canvas, Rect(0, 0, PaintBox1.Width, PaintBox1.Height));
end;

procedure TfrPlanner.PlannerControlEh1CheckPlannerItemInteractiveChanging(
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

procedure TfrPlanner.ReadState(Reader: TReader);
begin
  inherited ReadState(Reader);
end;

procedure TfrPlanner.NewPlanItemClick(Sender: TObject);
begin
  PlannerControlEh1.ShowNewPlanItemDialog;
end;

end.
