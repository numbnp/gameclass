unit uAccountsDiscountsDataSet;


interface
uses uGCDataSet, ADODB;

type
  TAccountsDiscountsDataSet = class(TGCDataSet)
  protected
    function DoSelectAll(
        var AdtsResult: TADODataSet): Boolean; override;
    function DoUpdate(const AnId: Integer): Boolean; override;
    function DoDelete (const AnId: Integer): Boolean; override;
    function DoInsert(var AdtsResult: TADODataSet): Boolean; override;
    function DoSelect(const AnId: Integer;
        var AdtsResult: TADODataSet): Boolean; override;
  public
    function LocateBySummary(AfSummary: Double): Boolean;
  end;

implementation

uses
  uSQLTools,
  SysUtils,
  DB;

function TAccountsDiscountsDataSet.DoSelectAll(
    var AdtsResult: TADODataSet): Boolean;
begin
  Result := dsDoQuery(Connection, AdtsResult, 'exec AccountsDiscountsSelect');
end;

function TAccountsDiscountsDataSet.DoSelect(const AnId: Integer;
  var AdtsResult: TADODataSet): Boolean;
begin
  Result := dsDoQuery(Connection, AdtsResult,
      'exec AccountsDiscountsSelect @id=' + IntToStr(AnId));
end;

function TAccountsDiscountsDataSet.DoUpdate(const AnId: Integer): Boolean;
var
  cmd: TADOCommand;
begin
  Result := dsDoCommand(Connection,
      'exec AccountsDiscountsUpdate @id='+ IntToStr(FieldValues['id'])
      + ', @summary=' + FloatToStr(FieldValues['summary'])
      + ', @discount=' + IntToStr(FieldValues['discount']));
end;

function TAccountsDiscountsDataSet.DoDelete(const AnId: Integer): Boolean;
begin
  Result := dsDoCommand(Connection,
      'exec AccountsDiscountsDelete @id=' + IntToStr(AnId));
end;

function TAccountsDiscountsDataSet.DoInsert(
    var AdtsResult: TADODataSet): Boolean;
begin
  Result := dsDoQuery(Connection, AdtsResult,
      'exec AccountsDiscountsInsert @summary=0, @discount=0');
end;

function TAccountsDiscountsDataSet.LocateBySummary(AfSummary: Double): Boolean;
var
  AnId: Integer;
  AstrSort: String;
  AstrFilter: String;
  AbFiltered: Boolean;
begin
  Result := False;
  AstrSort := Sort;
  AstrFilter := Filter;
  AbFiltered := Filtered;
  Sort := 'summary DESC';
  Filter := 'summary <= ' + FloatToSQLStr(AfSummary);
  Filtered := True;
  First;
  if (RecordCount > 0) then begin
    AnId := FieldValues['id'];
    Result := True;
  end;
  Filter := AstrFilter;
  Filtered := AbFiltered;
  Sort := AstrSort;
  if Result then
    Result := Locate('id', AnId, []);
end;

end.
