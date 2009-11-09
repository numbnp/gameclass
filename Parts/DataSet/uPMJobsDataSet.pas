unit uPMJobsDataSet;


interface
uses uGCDataSet, ADODB;

type
  TPMJobsDataSet = class(TGCDataSet)
  protected
    function DoSelectAll(
        var AdtsResult: TADODataSet): Boolean; override;
    function DoUpdate(const AnId: Integer): Boolean; override;
    function DoDelete (const AnId: Integer): Boolean; override;
    function DoInsert(var AdtsResult: TADODataSet): Boolean; override;
    function DoSelect(const AnId: Integer;
        var AdtsResult: TADODataSet): Boolean; override;
  public
  end;

implementation

uses
  uSQLTools,
  SysUtils,
  DB;

function TPMJobsDataSet.DoSelectAll(
    var AdtsResult: TADODataSet): Boolean;
begin
  Result := dsDoQuery(Connection, AdtsResult, 'exec PMJobsSelectUnprocessed');
end;

function TPMJobsDataSet.DoSelect(const AnId: Integer;
  var AdtsResult: TADODataSet): Boolean;
begin
  Result := dsDoQuery(Connection, AdtsResult,
      'exec PMJobsSelect @id=' + IntToStr(AnId));
end;

function TPMJobsDataSet.DoUpdate(const AnId: Integer): Boolean;
begin
  Result := False;
end;

function TPMJobsDataSet.DoDelete(const AnId: Integer): Boolean;
begin
  Result := False;
end;

function TPMJobsDataSet.DoInsert(
    var AdtsResult: TADODataSet): Boolean;
begin
  Result := False;
end;

end.
