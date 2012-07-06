unit uAccountsReferalsDataSet;


interface
uses uGCDataSet, ADODB;

type
  TAccountsReferalsDataSet = class(TGCDataSet)
  protected
    function DoSelectAll(
        var AdtsResult: TADODataSet): Boolean; override;
    function DoUpdate(const AnId: Integer): Boolean; override;
    function DoDelete (const AnId: Integer): Boolean; override;
    function DoInsert(var AdtsResult: TADODataSet): Boolean; override;
    function DoSelect(const AnId: Integer;
        var AdtsResult: TADODataSet): Boolean; override;
  public
    function LocateByLevel(AfLevel: Integer): Boolean;
  end;

implementation

uses
  uSQLTools,
  SysUtils,
  DB;

function TAccountsReferalsDataSet.DoSelectAll(
    var AdtsResult: TADODataSet): Boolean;
begin
  Result := dsDoQuery(Connection, AdtsResult, 'exec AccountsReferalsSelect');
end;

function TAccountsReferalsDataSet.DoSelect(const AnId: Integer;
  var AdtsResult: TADODataSet): Boolean;
begin
  Result := dsDoQuery(Connection, AdtsResult,
      'exec AccountsReferalsSelect @id=' + IntToStr(AnId));
end;

function TAccountsReferalsDataSet.DoUpdate(const AnId: Integer): Boolean;
var
  cmd: TADOCommand;
begin
  Result := dsDoCommand(Connection,
      'exec AccountsReferalsUpdate @id='+ IntToStr(FieldValues['id'])
      + ', @level=' + FloatToStr(FieldValues['level'])
      + ', @percent=' + IntToStr(FieldValues['percent']));
end;

function TAccountsReferalsDataSet.DoDelete(const AnId: Integer): Boolean;
begin
  Result := dsDoCommand(Connection,
      'exec AccountsReferalsDelete @id=' + IntToStr(AnId));
end;

function TAccountsReferalsDataSet.DoInsert(
    var AdtsResult: TADODataSet): Boolean;
begin
  Result := dsDoQuery(Connection, AdtsResult,
      'exec AccountsReferalsInsert @level=0, @percent=0');
end;

function TAccountsReferalsDataSet.LocateByLevel(AfLevel: Integer): Boolean;
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
  Sort := 'level DESC';
  Filter := 'level = ' + IntToStr(AfLevel);
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
