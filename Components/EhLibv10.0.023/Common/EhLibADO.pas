{*******************************************************}
{                                                       }
{                       EhLib 10.0                      }
{          Register object that sort data in            }
{                TADODataSet, TADOQuery                 }
{                                                       }
{   Copyright (c) 2002-2020 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

{*******************************************************}
{ Add this unit to 'uses' clause of any unit of your    }
{ project to allow TDBGridEh to sort data in            }
{ TADOQuery automatically after sorting markers         }
{ will be changed.                                      }
{ TSQLDatasetFeaturesEh will try to find line in        }
{ TADOQuery.SQL string that begin from 'ORDER BY' phrase}
{ and replace line by 'ORDER BY FieldNo1 [DESC],....'   }
{ using SortMarkedColumns.                              }
{*******************************************************}

unit EhLibADO;

{$I EhLib.Inc}

interface

uses
  Variants, DBUtilsEh, ADODB, DB, DBGridEh, ToolCtrlsEh, MemTableEh, MemTableDataEh;

function WriteADODataSetToMemTable(DataSet: TCustomADODataSet;
  MemTable: TCustomMemTableEh; RecordCount: Integer;
  Mode: TLoadMode; UseCachedUpdates: Boolean): Integer;

implementation

uses Classes;

function ADODataSetDriverName(DataSet: TCustomADODataSet): String;
begin
  if (DataSet = nil) then
    Result := ''
  else if  Assigned(DataSet.Connection)  and
      ((Pos(WideString('SQLOLEDB'),DataSet.Connection.Provider)=1) or
       (Pos(WideString('SQLNCLI'),DataSet.Connection.Provider)=1))
  then
    Result := 'MSSQL'
  else
    Result := 'MSACCESS';
end;

function DateValueToADOSQLStringProc(DataSet: TDataSet; Value: Variant): String;
begin
  Result := DateValueToDataBaseSQLString(ADODataSetDriverName(TADODataSet(DataSet)), Value)
end;

type

  TADOSQLDatasetFeaturesEh = class(TSQLDatasetFeaturesEh)
  public
    function NullComparisonSyntax(AGrid: TCustomDBGridEh; DataSet: TDataSet; IsLocalFilter: Boolean): TNullComparisonSyntaxEh; override;
    procedure ApplySorting(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean); override;
    procedure SortDataInADODataSet(Grid: TCustomDBGridEh; DataSet: TCustomADODataSet);
    function GetSQLFilterMarker(Grid: TCustomDBGridEh; DataSet: TDataSet): String; override;
    function GetServerTypeName(Grid: TCustomDBGridEh; DataSet: TDataSet): String; override;
    function IsInOperatorSupported(Grid: TCustomDBGridEh; DataSet: TDataSet; IsLocalFilter: Boolean): Boolean; override;
    function WriteDataSetToMemTable(DataSet: TDataSet; MemTable: TCustomMemTableEh; RecordCount: Integer; Mode: TLoadMode; UseCachedUpdates: Boolean): Integer; override;
    constructor Create; override;
  end;

  TADOCommandTextDatasetFeaturesEh = class(TCommandTextDatasetFeaturesEh)
  public
    function NullComparisonSyntax(AGrid: TCustomDBGridEh; DataSet: TDataSet; IsLocalFilter: Boolean): TNullComparisonSyntaxEh; override;
    procedure ApplySorting(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean); override;
    procedure SortDataInADODataSet(Grid: TCustomDBGridEh; DataSet: TCustomADODataSet);
    function IsInOperatorSupported(Grid: TCustomDBGridEh; DataSet: TDataSet; IsLocalFilter: Boolean): Boolean; override;
    function WriteDataSetToMemTable(DataSet: TDataSet; MemTable: TCustomMemTableEh; RecordCount: Integer; Mode: TLoadMode; UseCachedUpdates: Boolean): Integer; override;
    constructor Create; override;
  end;

{ TADOSQLDatasetFeaturesEh }

constructor TADOSQLDatasetFeaturesEh.Create;
begin
  inherited Create;
  DateValueToSQLString := DateValueToADOSQLStringProc;
  SupportsLocalLike := True;
end;

function TADOSQLDatasetFeaturesEh.GetServerTypeName(Grid: TCustomDBGridEh;
  DataSet: TDataSet): String;
begin
  if (DataSet <> nil) then
    Result := ADODataSetDriverName(DataSet as TCustomADODataSet)
  else
    Result := '';
end;

function TADOSQLDatasetFeaturesEh.GetSQLFilterMarker(Grid: TCustomDBGridEh;
  DataSet: TDataSet): String;
var
  ServerTypeName: String;
begin
  ServerTypeName := GetServerTypeName(Grid, DataSet);
  if (ServerTypeName = 'MSACCESS') then
    Result := '1=1 AND'
  else
    Result := inherited GetSQLFilterMarker(Grid, DataSet);
end;

procedure TADOSQLDatasetFeaturesEh.ApplySorting(Sender: TObject;
  DataSet: TDataSet; IsReopen: Boolean);
begin
  if Sender is TCustomDBGridEh then
  begin
    if TCustomDBGridEh(Sender).SortLocal then
      SortDataInADODataSet(TCustomDBGridEh(Sender), TCustomADODataSet(DataSet))
    else
      inherited ApplySorting(Sender, DataSet, IsReopen);
  end;
end;

function TADOSQLDatasetFeaturesEh.NullComparisonSyntax(
  AGrid: TCustomDBGridEh; DataSet: TDataSet; IsLocalFilter: Boolean): TNullComparisonSyntaxEh;
begin
  if IsLocalFilter
    then Result := ncsAsEqualToNullEh
    else Result := ncsAsIsNullEh;
end;

procedure TADOSQLDatasetFeaturesEh.SortDataInADODataSet(
  Grid: TCustomDBGridEh; DataSet: TCustomADODataSet);
begin
  DataSet.Sort := BuildSortingString(Grid, DataSet);
end;

function TADOSQLDatasetFeaturesEh.IsInOperatorSupported(Grid: TCustomDBGridEh;
  DataSet: TDataSet; IsLocalFilter: Boolean): Boolean;
begin
  if (IsLocalFilter) then
    Result := False
  else
    Result := inherited IsInOperatorSupported(Grid, DataSet, IsLocalFilter);
end;

function TADOSQLDatasetFeaturesEh.WriteDataSetToMemTable(DataSet: TDataSet;
  MemTable: TCustomMemTableEh; RecordCount: Integer; Mode: TLoadMode;
  UseCachedUpdates: Boolean): Integer;
begin
  Result := WriteADODataSetToMemTable(DataSet as TCustomADODataSet, MemTable, RecordCount, Mode, UseCachedUpdates);
end;

{ TADOCommandTextDatasetFeaturesEh }

procedure TADOCommandTextDatasetFeaturesEh.ApplySorting(Sender: TObject;
  DataSet: TDataSet; IsReopen: Boolean);
begin
  if Sender is TCustomDBGridEh then
    if TCustomDBGridEh(Sender).SortLocal then
      SortDataInADODataSet(TCustomDBGridEh(Sender), TCustomADODataSet(DataSet))
    else
      inherited ApplySorting(Sender, DataSet, IsReopen);
end;

constructor TADOCommandTextDatasetFeaturesEh.Create;
begin
  inherited Create;
  DateValueToSQLString := DateValueToADOSQLStringProc;
  SupportsLocalLike := True;
end;

function TADOCommandTextDatasetFeaturesEh.IsInOperatorSupported(
  Grid: TCustomDBGridEh; DataSet: TDataSet; IsLocalFilter: Boolean): Boolean;
begin
  if (IsLocalFilter) then
    Result := False
  else
    Result := inherited IsInOperatorSupported(Grid, DataSet, IsLocalFilter);
end;

function TADOCommandTextDatasetFeaturesEh.NullComparisonSyntax(
  AGrid: TCustomDBGridEh; DataSet: TDataSet; IsLocalFilter: Boolean): TNullComparisonSyntaxEh;
begin
  if IsLocalFilter
    then Result := ncsAsEqualToNullEh
    else Result := ncsAsIsNullEh;
end;

procedure TADOCommandTextDatasetFeaturesEh.SortDataInADODataSet(
  Grid: TCustomDBGridEh; DataSet: TCustomADODataSet);
begin
  DataSet.Sort := BuildSortingString(Grid, DataSet);
end;

function TADOCommandTextDatasetFeaturesEh.WriteDataSetToMemTable(
  DataSet: TDataSet; MemTable: TCustomMemTableEh; RecordCount: Integer;
  Mode: TLoadMode; UseCachedUpdates: Boolean): Integer;
begin
  Result := WriteADODataSetToMemTable(DataSet as TCustomADODataSet, MemTable, RecordCount, Mode, UseCachedUpdates);
end;

{ EhLibADO }

function WriteADODataSetToMemTable(DataSet: TCustomADODataSet;
  MemTable: TCustomMemTableEh; RecordCount: Integer;
  Mode: TLoadMode; UseCachedUpdates: Boolean): Integer;
var
  Recordset: _Recordset;
  i,j: Integer;
  ar: Variant;
  Rows: Integer;
  Rec: TMemoryRecordEh;
  DataToRecFields: array of Integer;
  MemTableData: TMemTableDataEh;

  function RecordsetFieldIndex(AFieldName: String): Integer;
  var
    i: Integer;
  begin
    Result := -1;
    for i := 0 to Recordset.Fields.Count-1 do
      if AFieldName = Recordset.Fields.Item[i].Name then
      begin
        Result := i;
        Exit;
      end;
  end;
begin
  Recordset := DataSet.Recordset;

  MemTable.DefaultLoadFromDataSet(DataSet, RecordCount, lmCopyStructureOnly, False);

  MemTable.DisableControls;
  MemTableData := MemTable.RecordsView.MemTableData;

  if DataSet.IsEmpty then
  begin
    Result := 0;
    Exit;
  end;

  Recordset.MoveFirst;
  ar := Recordset.GetRows(-1, EmptyParam, EmptyParam);

  Rows := VarArrayHighBound(ar, 2);

  SetLength(DataToRecFields, MemTableData.DataStruct.Count);
  for i := 0 to MemTableData.DataStruct.Count-1 do
    DataToRecFields[i] := RecordsetFieldIndex(MemTableData.DataStruct[i].FieldName);

  try
    for i := 0 to Rows do
    begin
      Rec := MemTableData.RecordsList.NewRecord;
      for j := 0 to MemTableData.DataStruct.Count-1 do
      begin
        if DataToRecFields[j] >= 0 then
          Rec.Value[j, dvvValueEh] := ar[DataToRecFields[j], i];
      end;
      MemTableData.RecordsList.FetchRecord(Rec);
    end;
  finally
  end;
  Result := Rows;
  ar := Null;
  MemTable.EnableControls;
end;

initialization
  RegisterDatasetFeaturesEh(TADOSQLDatasetFeaturesEh, TADOQuery);
  RegisterDatasetFeaturesEh(TADOCommandTextDatasetFeaturesEh, TCustomADODataSet);
end.
