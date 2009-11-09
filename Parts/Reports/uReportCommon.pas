unit uReportCommon;

interface

type

  TReportData = record
    id: Integer;
    Caption: ShortString;
    IsFolder: Boolean;
  end; // TReportData
  PReportData = ^TReportData;


  TChartRole = (
      ChartRole_None,
      ChartRole_X,
      ChartRole_Y);

  TAggregateFunction = (
      Aggregate_None,
      Aggregate_Sum,
      Aggregate_Avg,
      Aggregate_Count);

  TReportChartStyle = (
      ReportChartStyle_Line,
      ReportChartStyle_Bar,
      ReportChartStyle_Area,
      ReportChartStyle_Pie,
      ReportChartStyle_Point);

  TReportParameters = record
    dtCurrent: TDateTime;
    dtBegin: TDateTime;
    dtEnd: TDateTime;
    dtCurrentShiftBegin: TDateTime;
    dtPrevShiftBegin: TDateTime;
    dtPrevShiftEnd: TDateTime;
  end; // TReportParameters


  // events types
  TModifyReport = procedure(const ASender: TObject) of object;

  
implementation


end.
