unit ufrmReportChart;

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
  ExtCtrls,
  TeeProcs,
  TeEngine,
  Chart,
  DbChart,
  DB,
  StdCtrls,
  Series,
  BubbleCh,
//  uLanguagesManager,
  ufrmReport,
  uReportCommon,
  uReport,
  uReportColumn;


type

  //
  // TfrmReportChart
  //

  TfrmReportChart = class(TfrmReport)
    dsrcReport: TDataSource;
    chartReport: TDBChart;
    pnlHeader: TPanel;
    lblChartY: TLabel;
    lblChartX: TLabel;
    cboChartX: TComboBox;
    cboChartY: TComboBox;
    Series1: TBarSeries;
    Series2: TAreaSeries;
    Series3: TPieSeries;
    Series4: TLineSeries;
    Series5: TPointSeries;
    btnApply: TButton;
    pnlChartMain: TPanel;
    dlgSave: TSaveDialog;
    procedure btnApplyClick(Sender: TObject);

  private
    // class constants
    RES_QUERY_PRINT_THIS_CHART: String;

    // fields
    FReport: TReport;
    FReportChartStyle: TReportChartStyle;
    FbRandomColors: Boolean;

//    FLanguagesManagerLink: TLanguagesManagerLink;

    // events handlers
//    procedure _LanguageChange(ASender: TObject);

    // private helper methods
    procedure _BuildChart();
    procedure _SetChartStyle(const AReportChartStyle: TReportChartStyle);
//    procedure _SubscribeToLanguagesManagerEvents();

  protected
    // properties methods
    procedure SetReportChartStyle(
        const AReportChartStyle: TReportChartStyle); virtual;

    function GetChart3D(): Boolean; virtual;
    procedure SetChart3D(const AbChart3D: Boolean); virtual;

    function GetRandomColors(): Boolean; virtual;
    procedure SetRandomColors(const AbRandomColors: Boolean); virtual;

  public
    // constructor / destructor
    constructor Create(AOwner: TComponent); override;
    destructor Destroy(); override;

    // public methods
    procedure SetReport(const AReport: TReport); override;
    procedure Storage(); override;
    procedure SaveChart(const AbIsOpenFilesAfterSave: Boolean);
    procedure PrintChart();

    // properties
    property ChartStyle: TReportChartStyle
        read FReportChartStyle write SetReportChartStyle;
    property Chart3D: Boolean read GetChart3D write SetChart3D;
    property RandomColors: Boolean read GetRandomColors write SetRandomColors;

  end; // TfrmReportChart


implementation

uses
  ShellAPI;

{$R *.dfm}

const
  CLASS_NAME = 'TfrmReportChart';


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TfrmReportChart.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  RES_QUERY_PRINT_THIS_CHART := 'Print this chart?';

  FReportChartStyle := ReportChartStyle_Bar;
  FbRandomColors := FALSE;

//  _SubscribeToLanguagesManagerEvents();
//  _LanguageChange(Self);

end; // TfrmReportChart.Create


destructor TfrmReportChart.Destroy();
begin
//  FreeAndNil(FLanguagesManagerLink);

  inherited Destroy();

end; // TfrmReportChart.Destroy


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TfrmReportChart.SetReport(const AReport: TReport);
var
  i: Integer;
  nChartDefaultX: Integer;
  nChartDefaultY: Integer;
begin
  FReport := AReport;

  cboChartX.Items.Clear();
  cboChartY.Items.Clear();

  if not Assigned(FReport) then begin
    exit;
  end;

  chartReport.Title.Text.Text := FReport.ReportName;

  nChartDefaultX := 0;
  nChartDefaultY := 0;

  for i := 0 to AReport.ReportColumns.Count - 1 do begin
    if AReport.ReportColumns[i].ChartRole = ChartRole_X then begin
      cboChartX.AddItem(
          AReport.ReportColumns[i].ColumnName, AReport.ReportColumns[i]);
      if AReport.ReportColumns[i].ChartDefault then begin
        nChartDefaultX := cboChartX.Items.Count - 1;
      end;
    end else if AReport.ReportColumns[i].ChartRole = ChartRole_Y then begin
      cboChartY.AddItem(
          AReport.ReportColumns[i].ColumnName, AReport.ReportColumns[i]);
      if AReport.ReportColumns[i].ChartDefault then begin
        nChartDefaultY := cboChartY.Items.Count - 1;
      end;
    end;
  end;

  if cboChartX.Items.Count > 0 then begin
    cboChartX.ItemIndex := nChartDefaultX;
  end;

  if cboChartY.Items.Count > 0 then begin
    cboChartY.ItemIndex := nChartDefaultY;
  end;

  _BuildChart();

end; // TfrmReportChart.SetReport


procedure TfrmReportChart.Storage();
begin
// do nothing
end; // TfrmReportChart.Storage


procedure TfrmReportChart.SaveChart(const AbIsOpenFilesAfterSave: Boolean);
begin
  if dlgSave.Execute() then begin
    chartReport.SaveToBitmapFile(dlgSave.FileName);
    if AbIsOpenFilesAfterSave then begin
      ShellExecute(0, 'open', PChar(dlgSave.FileName), nil, nil, SW_SHOWNORMAL);
    end;
  end;
end; // TfrmReportChart.SaveChart


procedure TfrmReportChart.PrintChart();
begin
  if MessageDlg(RES_QUERY_PRINT_THIS_CHART,
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
    chartReport.Print();
  end;
end; // TfrmReportChart.PrintChart


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// properties methods

procedure TfrmReportChart.SetReportChartStyle(
    const AReportChartStyle: TReportChartStyle);
begin
  FReportChartStyle := AReportChartStyle;
  _SetChartStyle(AReportChartStyle);
end; // TfrmReportChart.SetReportChartStyle


function TfrmReportChart.GetChart3D(): Boolean;
begin
  Result := chartReport.View3D;
end; // TfrmReportChart.GetChart3D


procedure TfrmReportChart.SetChart3D(const AbChart3D: Boolean);
begin
  chartReport.View3D := AbChart3D;
end; // TfrmReportChart.SetChart3D


function TfrmReportChart.GetRandomColors(): Boolean;
begin
  Result := FbRandomColors;
end; // TfrmReportChart.GetRandomColors


procedure TfrmReportChart.SetRandomColors(const AbRandomColors: Boolean);
var
  i: Integer;
begin
  FbRandomColors := AbRandomColors;
  for i := 0 to chartReport.SeriesCount - 1 do begin
    chartReport.Series[i].ColorEachPoint := AbRandomColors;
    chartReport.Series[i].ShowInLegend := AbRandomColors;
  end;
end; // TfrmReportChart.SetRandomColors


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// events handlers

procedure TfrmReportChart.btnApplyClick(Sender: TObject);
begin
  _BuildChart();
end; // TfrmReportChart.btnApplyClick


{procedure TfrmReportChart._LanguageChange(ASender: TObject);
begin
  with LanguagesManager do begin
    GetString(CLASS_NAME, TButton(btnApply));
    GetString(CLASS_NAME, 'RES_QUERY_PRINT_THIS_CHART',
        '', RES_QUERY_PRINT_THIS_CHART);
  end;
end; // TfrmReportChart._LanguageChange
}

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private helper methods

procedure TfrmReportChart._BuildChart();
var
  i: Integer;
  strXField: String;
  strYField: String;
  ReportColumn: TReportColumn;
begin
  for i := 0 to chartReport.SeriesCount - 1 do begin
    chartReport.Series[i].DataSource := nil;
  end;

  if (cboChartX.Items.Count <= 0) or (cboChartX.Items.Count <= 0) then begin
    exit;
  end;

  ReportColumn := TReportColumn(cboChartX.Items.Objects[cboChartX.ItemIndex]);
  strXField := ReportColumn.Field;

  ReportColumn := TReportColumn(cboChartY.Items.Objects[cboChartY.ItemIndex]);
  strYField := ReportColumn.Field;

  for i := 0 to chartReport.SeriesCount - 1 do begin
    chartReport.Series[i].XLabelsSource := strXField;
    chartReport.Series[i].YValues.ValueSource := strYField;
    chartReport.Series[i].DataSource := FReport.ResultDataSet;
  end;

end; // TfrmReportChart._BuildChart


procedure TfrmReportChart._SetChartStyle(
    const AReportChartStyle: TReportChartStyle);
var
  i: Integer;
begin
  if chartReport.SeriesCount < 5 then begin
    ASSERT(FALSE);
    exit;
  end;

  for i := 0 to chartReport.SeriesCount - 1 do begin
    chartReport.Series[i].Active := FALSE;
  end;

  if AReportChartStyle = ReportChartStyle_Bar then begin
    chartReport.Series[0].Active := TRUE;
  end else if AReportChartStyle = ReportChartStyle_Area then begin
    chartReport.Series[1].Active := TRUE;
  end else if AReportChartStyle = ReportChartStyle_Pie then begin
    chartReport.Series[2].Active := TRUE;
  end else if AReportChartStyle = ReportChartStyle_Line then begin
    chartReport.Series[3].Active := TRUE;
  end else if AReportChartStyle = ReportChartStyle_Point then begin
    chartReport.Series[4].Active := TRUE;
  end else begin
    ASSERT(FALSE, 'Unknown ReportChartStyle!');
    chartReport.Series[0].Active := TRUE;
  end;

end; // TfrmReportChart._SetChartStyle


{procedure TfrmReportChart._SubscribeToLanguagesManagerEvents();
begin
  ASSERT(Assigned(LanguagesManager),
      'TfrmReportChart._SubscribeToLanguagesManagerEvents error! '
      + 'LanguagesManager not created!');

  FLanguagesManagerLink := TLanguagesManagerLink.Create(LanguagesManager);
  FLanguagesManagerLink.OnLanguageChange := _LanguageChange;

end; // TfrmReportChart._SubscribeToLanguagesManagerEvents
}

end.
