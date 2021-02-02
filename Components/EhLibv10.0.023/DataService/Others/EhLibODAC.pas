unit EhLibODAC;

{$I EhLib.Inc}

interface

uses
  DbUtilsEh, DB, sysutils, DBGridEh, Ora, OraSmart, StrUtils, MemTableDataEh;

implementation

uses Classes, ToolCtrlsEh;

type

  TODACSQLDatasetFeaturesEh = class(TSQLDatasetFeaturesEh)
  public
    procedure ApplySorting(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean); override;
    procedure ApplyFilter(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean); override;
    constructor Create; override;
  end;

  TODACTableSQLDatasetFeaturesEh = class(TDatasetFeaturesEh)
  public
    procedure ApplySorting(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean); override;
    procedure ApplyFilter(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean); override;
  end;

function ODACDataSetDriverName(DataSet: TOraDataSet): String;
begin
  Result := 'ORACLE';
end;

function DateValueToODACSQLStringProc(DataSet: TDataSet; Value: Variant): String;
begin
  Result := DateValueToDataBaseSQLString(ODACDataSetDriverName(TOraDataSet(DataSet)), Value)
end;

procedure SortDataInODACDataSet(Grid: TCustomDBGridEh; DataSet: TOraDataSet);
var
  s: String;
  i: Integer;
begin
  s := '';
  for i := 0 to Grid.SortMarkedColumns.Count - 1 do
  begin
    s := s + Grid.SortMarkedColumns[i].FieldName;
    if Grid.SortMarkedColumns[i].Title.SortMarker = smUpEh
      then s := s + ' DESC;'
      else s := s + ';';
  end;

  DataSet.IndexFieldNames := s;
end;


{ TODACSQLDatasetFeaturesEh }

procedure TODACSQLDatasetFeaturesEh.ApplyFilter(Sender: TObject;
  DataSet: TDataSet; IsReopen: Boolean);
begin
  if TDBGridEh(Sender).STFilter.Local
   then DataSet.Filter := GetExpressionAsFilterString(TDBGridEh(Sender), GetOneExpressionAsLocalFilterString, nil)
  else (DataSet as TOraDataSet).FilterSQL := GetExpressionAsFilterString(TDBGridEh(Sender), GetOneExpressionAsSQLWhereString, DateValueToODACSQLStringProc, True)
end;

procedure TODACSQLDatasetFeaturesEh.ApplySorting(Sender: TObject;
  DataSet: TDataSet; IsReopen: Boolean);
begin
  if Sender is TCustomDBGridEh then
    if TCustomDBGridEh(Sender).SortLocal then
      SortDataInODACDataSet(TCustomDBGridEh(Sender), TOraDataSet(DataSet))
    else
      inherited ApplySorting(Sender, DataSet, IsReopen);
end;

constructor TODACSQLDatasetFeaturesEh.Create;
begin
  inherited Create;
  DateValueToSQLString := DateValueToODACSQLStringProc;
  SupportsLocalLike := True;
end;

{ TODACTableSQLDatasetFeaturesEh }

procedure TODACTableSQLDatasetFeaturesEh.ApplyFilter(Sender: TObject;
  DataSet: TDataSet; IsReopen: Boolean);
begin
  if TDBGridEh(Sender).STFilter.Local
   then DataSet.Filter := GetExpressionAsFilterString(TDBGridEh(Sender), GetOneExpressionAsLocalFilterString, nil)
   else (DataSet as TOraDataSet).FilterSQL := GetExpressionAsFilterString(TDBGridEh(Sender), GetOneExpressionAsSQLWhereString, DateValueToODACSQLStringProc, True)
end;

procedure TODACTableSQLDatasetFeaturesEh.ApplySorting(Sender: TObject;
  DataSet: TDataSet; IsReopen: Boolean);
var
  i: Integer;
  sOrderFields: String;
begin
  If Sender is TCustomDBGridEh then
   With TCustomDBGridEh(Sender) do
    begin
     sOrderFields := '';
     If SortMarkedColumns.Count > 0 then
      For i := 0 to SortMarkedColumns.Count - 1 do
       begin
        sOrderFields := sOrderFields + SortMarkedColumns[i].FieldName;
        If SortMarkedColumns[i].Title.SortMarker = smUpEh then
         sOrderFields := sOrderFields + ' DESC';
        sOrderFields := sOrderFields + ','
      end;
     Delete(sOrderFields,Length(sOrderFields),1);
     (DataSet as TOraTable).OrderFields := sOrderFields;
    End
end;

initialization
  RegisterDatasetFeaturesEh(TODACSQLDatasetFeaturesEh, TOraQuery);
  RegisterDatasetFeaturesEh(TODACTableSQLDatasetFeaturesEh, TOraTable);
  RegisterDatasetFeaturesEh(TODACSQLDatasetFeaturesEh, TSmartQuery);
end.

