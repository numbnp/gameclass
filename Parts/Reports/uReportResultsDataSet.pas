unit uReportResultsDataSet;

interface

uses
  Classes,
  ADODB,
  uReportCommon;

type

  //
  // TReportResultsDataSet
  //

  TReportResultsDataSet = class(TADODataSet)
  private
    // fields
    FReportParameters: TReportParameters;

    // private helper methods
    procedure _DefaultReportParameters();
    procedure _ParametersSubstitution(const AbUsingSP: Boolean);

  public
    // constructor / destructor
    constructor Create(AOwner: TComponent); override;

    // public methods
    procedure Open();
    procedure OpenReport(const AReportParameters: TReportParameters;
        const AbUsingSP: Boolean);

    // properties
    property ReportParameters: TReportParameters
        read FReportParameters write FReportParameters;

  end; // TReportResultsDataSet


implementation

uses
{$IFDEF GC3SERVER}
  uVirtualTime,
{$ENDIF}
  SysUtils,
  StrUtils,
  Windows,
  DB;


const
  CURRENT_DATETIME = '%TIME-CURRENT%';
  BEGIN_DATETIME = '%TIME-START%';
  END_DATETIME = '%TIME-STOP%';
  CURRENT_SHIFT_BEGIN = '%SHIFT-BEGIN%';
  PREV_SHIFT_BEGIN = '%SHIFT2-BEGIN%';
  PREV_SHIFT_END = '%SHIFT2-END%';


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TReportResultsDataSet.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  _DefaultReportParameters();

end; // TReportResultsDataSet.Create



//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TReportResultsDataSet.Open();
begin
  raise Exception.Create('Error! Instead of this method use OpenReport!');
end; // TReportResultsDataSet.Open


procedure TReportResultsDataSet.OpenReport(
    const AReportParameters: TReportParameters; const AbUsingSP: Boolean);
begin
  FReportParameters := AReportParameters;
  _ParametersSubstitution(AbUsingSP);
  inherited Open();
end; // TReportResultsDataSet.OpenReport


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private helper methods

procedure TReportResultsDataSet._DefaultReportParameters();
begin
{$IFDEF GC3SERVER}
  FReportParameters.dtCurrent := GetVirtualTime;
{$ELSE}
  FReportParameters.dtCurrent := Now();
{$ENDIF}
  FReportParameters.dtBegin := MinDateTime;
  FReportParameters.dtEnd := MaxDateTime;
  FReportParameters.dtCurrentShiftBegin := Now();
  FReportParameters.dtPrevShiftBegin := Now();
  FReportParameters.dtPrevShiftEnd := Now();
end; // TReportResultsDataSet._DefaultReportParameters


procedure TReportResultsDataSet._ParametersSubstitution(
    const AbUsingSP: Boolean);
const
  DATETIME_FORMAT = 'dd-mmm-yyyy hh:nn:ss';
var
  strCommandText: String;
  strParameterCurrent: String;
  strParameterBegin: String;
  strParameterEnd: String;
  strParameterCurrentShiftBegin: String;
  strParameterPrevShiftBegin: String;
  strParameterPrevShiftEnd: String;
  FormatSettings: TFormatSettings;
begin
  //GetLocaleFormatSettings(LANG_ENGLISH, FormatSettings);
  GetLocaleFormatSettings(MAKELCID(MAKELANGID(LANG_ENGLISH, SUBLANG_ENGLISH_US),0)  , FormatSettings);

  DateTimeToString(strParameterCurrent,
      DATETIME_FORMAT, FReportParameters.dtCurrent, FormatSettings);
  strParameterCurrent := QuotedStr(strParameterCurrent);

  DateTimeToString(strParameterBegin,
      DATETIME_FORMAT, FReportParameters.dtBegin, FormatSettings);
  strParameterBegin := QuotedStr(strParameterBegin);

  DateTimeToString(strParameterEnd,
      DATETIME_FORMAT, FReportParameters.dtEnd, FormatSettings);
  strParameterEnd := QuotedStr(strParameterEnd);

  DateTimeToString(strParameterCurrentShiftBegin,
      DATETIME_FORMAT, FReportParameters.dtCurrentShiftBegin, FormatSettings);
  strParameterCurrentShiftBegin := QuotedStr(strParameterCurrentShiftBegin);

  DateTimeToString(strParameterPrevShiftBegin,
      DATETIME_FORMAT, FReportParameters.dtPrevShiftBegin, FormatSettings);
  strParameterPrevShiftBegin := QuotedStr(strParameterPrevShiftBegin);

  DateTimeToString(strParameterPrevShiftEnd,
      DATETIME_FORMAT, FReportParameters.dtPrevShiftEnd, FormatSettings);
  strParameterPrevShiftEnd := QuotedStr(strParameterPrevShiftEnd);

  if not AbUsingSP then begin
    strCommandText := CommandText;
    strCommandText := AnsiReplaceText(strCommandText,
        CURRENT_DATETIME, strParameterCurrent);
    strCommandText := AnsiReplaceText(strCommandText,
        BEGIN_DATETIME, strParameterBegin);
    strCommandText := AnsiReplaceText(strCommandText,
        END_DATETIME, strParameterEnd);
    strCommandText := AnsiReplaceText(strCommandText,
        CURRENT_SHIFT_BEGIN, strParameterCurrentShiftBegin);
    strCommandText := AnsiReplaceText(strCommandText,
        PREV_SHIFT_BEGIN, strParameterPrevShiftBegin);
    strCommandText := AnsiReplaceText(strCommandText,
        PREV_SHIFT_END, strParameterPrevShiftEnd);
    CommandText := strCommandText;
  end else begin
    CommandText := CommandText + strParameterCurrent
        + ',' + strParameterBegin
        + ',' + strParameterEnd
        + ',' + strParameterCurrentShiftBegin
        + ',' + strParameterPrevShiftBegin
        + ',' + strParameterPrevShiftEnd;
  end;

end; // TReportResultsDataSet._ParametersSubstitution


end.
