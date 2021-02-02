{
    EhLib
    IBDAC Features
}

unit EhLibIBDAC;

interface

implementation

uses
 DBUtilsEh, DBGridEh, ToolCtrlsEh, DB, IBC, SysUtils;

type
  TIBDACDatasetFeaturesEh = class(TDatasetFeaturesEh)
  public
    procedure ApplySorting(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean); override;
    procedure ApplyFilter(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean); override;
  end;

function DateValueToIBSQLStringProc(DataSet: TDataSet; Value: Variant): string;
begin
  Result := '''' + FormatDateTime('YYYY-MM-DD', Value) + '''';
end;

procedure TIBDACDatasetFeaturesEh.ApplyFilter(Sender: TObject;
  DataSet: TDataSet; IsReopen: Boolean);
var
  Grid: TCustomDBGridEh;
  Data: TCustomIBCDataSet;
  S: string;
begin
  Grid := TCustomDBGridEh(Sender);
  Data := TCustomIBCDataSet(DataSet);
  if Grid.STFilter.Local then
  begin
    Data := TCustomIBCDataSet(Data);
    Data.Filter := GetExpressionAsFilterString(Grid, GetOneExpressionAsLocalFilterString, nil, False, True);
    Data.Filtered := True;
  end else
  begin
    S := GetExpressionAsFilterString(Grid, GetOneExpressionAsSQLWhereString, DateValueToIBSQLStringProc, True);
    Data.FilterSQL := S;
    Data.Filtered := S <> '';
  end;
end;

procedure TIBDACDatasetFeaturesEh.ApplySorting(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean);
var
  Grid: TCustomDBGridEh;
  I, C: Integer;
  S, F: string;
begin
  Grid := TCustomDBGridEh(Sender);
  if Grid.SortLocal then
  begin
    C := Grid.SortMarkedColumns.Count - 1;
    for I := 0 to C do
    begin
      F := Grid.SortMarkedColumns[I].FieldName;
      if F = '' then Continue;
      if Grid.SortMarkedColumns[I].Title.SortMarker = smDownEh then
        F := F + ' DESC';
      S := S + F + ';';
    end;
    TCustomIBCDataSet(DataSet).IndexFieldNames := S;
  end else ApplySortingForSQLBasedDataSet(Grid, DataSet, True, IsReopen, 'SQL');
end;

initialization

  RegisterDatasetFeaturesEh(TIBDACDatasetFeaturesEh, TCustomIBCDataSet);

end.

