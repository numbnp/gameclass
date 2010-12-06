
unit uRegistryReportStrings;

interface

uses
  Classes,
  uRegistryRecord,
  uRegistryDataSet;

type

  TRegistryReportStrings = class(TObject)
  private
    FRegistryDataSet: TRegistryDataSet;
    FRegistryRecord: TRegistryRecord;
    procedure SetValue(AstrKey: String; AstrValue: String);

  public
    constructor Create(ARegistryDataSet: TRegistryDataSet;
        ARegistryRecord: TRegistryRecord);
    destructor Destroy; override;
    procedure Localize;
  end;

implementation

uses
  SysUtils,
  DB,
  uGCDataSet,
  gcconst,
  uReportStrings;

const
  REPORT_STRINGS_PREFIX = 'ReportStrings\';
{*******************************************************************************
                      class  TRegistryReportStrings
*******************************************************************************}
constructor TRegistryReportStrings.Create(ARegistryDataSet: TRegistryDataSet;
        ARegistryRecord: TRegistryRecord);
begin
  FRegistryDataSet := ARegistryDataSet;
  FRegistryRecord := ARegistryRecord;
  Localize;
end;

destructor TRegistryReportStrings.Destroy;
begin
  inherited Destroy;
end;

procedure TRegistryReportStrings.Localize;
begin
  SetValue('CurrentHeader',REPORT_STRINGS_CURRENT_HEADER);
  SetValue('CurrentBegin',REPORT_STRINGS_CURRENT_BEGIN);
  SetValue('CurrentEnd',REPORT_STRINGS_CURRENT_END);
  SetValue('CurrentOperator',REPORT_STRINGS_CURRENT_OPERATOR);
  SetValue('CurrentTotal',REPORT_STRINGS_CURRENT_TOTAL);
  SetValue('CurrentTime',REPORT_STRINGS_CURRENT_TIME);
  SetValue('CurrentServices',REPORT_STRINGS_CURRENT_SERVICES);
  SetValue('CurrentInternet',REPORT_STRINGS_CURRENT_INTERNET);
  SetValue('CurrentPrint',REPORT_STRINGS_CURRENT_PRINT);
  SetValue('CurrentAccountsAdded',REPORT_STRINGS_CURRENT_ACCOUNTS_ADDED);
  SetValue('CurrentAccountsPayed',REPORT_STRINGS_CURRENT_ACCOUNTS_PAYED);
  SetValue('CurrentAccountsReturned',REPORT_STRINGS_CURRENT_ACCOUNTS_RETURNED);
  SetValue('CurrentTotalSum',REPORT_STRINGS_CURRENT_TOTAL_SUM);
  SetValue('CurrentOperatorSum',REPORT_STRINGS_CURRENT_OPERATOR_SUM);
  SetValue('CurrentManagerSum',REPORT_STRINGS_CURRENT_MANAGER_SUM);
  SetValue('CurrentRest',REPORT_STRINGS_CURRENT_REST);
end;

procedure TRegistryReportStrings.SetValue(AstrKey: String; AstrValue: String);
begin
  FRegistryDataSet.LocateByKey(REPORT_STRINGS_PREFIX
      + AstrKey, AstrValue);
  FRegistryRecord.Value := AstrValue;
end;

end.
