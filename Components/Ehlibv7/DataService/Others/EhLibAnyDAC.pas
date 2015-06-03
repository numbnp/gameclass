{-----------------------------------------------------------------------------}
{ AnyDAC EhLib addon                                                          }
{                                                                             }
{ (c)opyright DA-SOFT Technologies 2004-2013.                                 }
{ All rights reserved.                                                        }
{ --------------------------------------------------------------------------- }
{$I uAD.inc}

{ --------------------------------------------------------------------------- }
{ Register object that sort and filtering data in TADQuery, TADStoredProc,    }
{ TSDTable and TADMemTable from AnyDAC.                                       }
{ Add this unit to 'uses' clause of any unit of your project to allow         }
{ TDBGridEh to sort data in AnyDAC datasets automatically after sorting       }
{ markers will be changed.                                                    }
{ TSQLDatasetFeaturesEh will try to find line in TADQuery.SQL string that     }
{ begin from 'ORDER BY' phrase and replace line by 'ORDER BY FieldNo1         }
{ [DESC],....' using SortMarkedColumns.                                       }
{ --------------------------------------------------------------------------- }

unit EhLibAnyDAC;

{$I EhLib.Inc}

interface

uses
  Classes, Db, SysUtils,
  DbUtilsEh, DBGridEh, ToolCtrlsEh,
  uADCompDataSet, uADCompClient;

type
  TADDatasetFeaturesEh = class(TSQLDatasetFeaturesEh)
  private
    procedure ADDataSetLocalSort(AGrid: TCustomDBGridEh; ADataSet: TADAdaptedDataSet);
  public
    constructor Create; override;
    function LocateText(AGrid: TCustomDBGridEh; const FieldName: string; const Text: String; AOptions: TLocateTextOptionsEh; Direction: TLocateTextDirectionEh; Matching: TLocateTextMatchingEh; TreeFindRange: TLocateTextTreeFindRangeEh; TimeOut: LongWord = 0): Boolean; override;
    procedure ApplyFilter(ASender: TObject; ADataSet: TDataSet; AIsReopen: Boolean); override;
    procedure ApplySorting(ASender: TObject; ADataSet: TDataSet; AIsReopen: Boolean); override;
    procedure FillSTFilterListDataValues(AGrid: TCustomDBGridEh; AColumn: TColumnEh; AItems: TStrings); override;
  end;

var
  bFilterWithValues: Boolean;

implementation

uses
  Variants,
  uADStanIntf, uADPhysIntf, uADDatSManager;

{-------------------------------------------------------------------------------}
function DateValueToADSQLStringProc(ADataSet: TDataSet; AValue: Variant): String;
begin
  Result := DateValueToDataBaseSQLString(
    C_AD_PhysRDBMSKinds[TADAdaptedDataSet(ADataSet).PointedConnection.RDBMSKind], AValue);
end;

{-------------------------------------------------------------------------------}
{ TADDatasetFeaturesEh                                                          }
{-------------------------------------------------------------------------------}
constructor TADDatasetFeaturesEh.Create;
begin
  inherited Create;
  DateValueToSQLString := DateValueToADSQLStringProc;
end;

{-------------------------------------------------------------------------------}
procedure TADDatasetFeaturesEh.ApplyFilter(ASender: TObject; ADataSet: TDataSet;
  AIsReopen: Boolean);
begin
  if (ASender is TCustomDBGridEh) and ADataSet.Active then
    if TDBGridEh(ASender).STFilter.Local then begin
      ADataSet.Filter := Trim(GetExpressionAsFilterString(TCustomDBGridEh(ASender),
        GetOneExpressionAsLocalFilterString, DateValueToADSQLStringProc, False, True));
      ADataSet.Filtered := ADataSet.Filter <> '';
    end
    else
      ApplyFilterSQLBasedDataSet(TCustomDBGridEh(ASender), ADataSet, 
        DateValueToADSQLStringProc, AIsReopen, 'SQL');
end;

{-------------------------------------------------------------------------------}
procedure TADDatasetFeaturesEh.ADDataSetLocalSort(AGrid: TCustomDBGridEh; ADataSet: TADAdaptedDataSet);
var
  i: Integer;
  sIndex, sFieldName: String;
  oField: TField;
begin
  try
    if AGrid.SortMarkedColumns.Count > 0 then begin
      sIndex := '';
      for i := 0 to AGrid.SortMarkedColumns.Count - 1 do begin
        sFieldName := AGrid.SortMarkedColumns[i].FieldName;
        oField := AGrid.DataSource.DataSet.FieldByName(sFieldName);
        if (oField.FieldKind = fkLookup) and (Pos(';', oField.KeyFields) = 0) then
          sFieldName := oField.KeyFields;
        if sIndex <> '' then
          sIndex := sIndex + ';';
        sIndex := sIndex + sFieldName;
        if AGrid.SortMarkedColumns[i].Title.SortMarker = smUpEh then
          sIndex := sIndex + ':D';
        // sIndex := sIndex + ':N'; // if you wants case insensitive
      end;
      ADataSet.IndexFieldNames := sIndex;
    end
    else
      ADataSet.IndexFieldNames := '';
  except
  end;
end;

{-------------------------------------------------------------------------------}
procedure TADDatasetFeaturesEh.ApplySorting(ASender: TObject; ADataSet: TDataSet;
  AIsReopen: Boolean);
var
  oConn: TADCustomConnection;
begin
  if (ASender is TCustomDBGridEh) and ADataSet.Active then
    if TCustomDBGridEh(ASender).SortLocal then
      ADDataSetLocalSort(TCustomDBGridEh(ASender), TADAdaptedDataSet(ADataSet))
    else begin
      oConn := TADAdaptedDataSet(ADataSet).PointedConnection;
      SortUsingFieldName := (oConn <> nil) and (oConn.RDBMSKind = mkMySQL);
      inherited ApplySorting(ASender, ADataSet, AIsReopen);
    end;
end;

{-------------------------------------------------------------------------------}
function TADDatasetFeaturesEh.LocateText(AGrid: TCustomDBGridEh;
  const FieldName: string; const Text: String; AOptions: TLocateTextOptionsEh;
  Direction: TLocateTextDirectionEh; Matching: TLocateTextMatchingEh;
  TreeFindRange: TLocateTextTreeFindRangeEh; TimeOut: LongWord = 0): Boolean;
var
  oDS: TADAdaptedDataSet;
begin
  if (FieldName <> '') or (Assigned(AGrid.SelectedField.OnGetText)) then
    Result := inherited LocateText(AGrid, FieldName, Text, AOptions, Direction,
      Matching, TreeFindRange)
  else if AGrid.SelectedField is TBlobField then
    Result := False
  else
  begin
    oDS := AGrid.DataSource.DataSet as TADAdaptedDataSet;
    case Direction of
    ltdDownEh:
      Result := oDS.LocateEx(AGrid.SelectedField.FieldName, Text,
        [lxoCaseInsensitive, lxoPartialKey, lxoFromCurrent]);
    ltdUpEh:
      Result := oDS.LocateEx(AGrid.SelectedField.FieldName, Text,
        [lxoCaseInsensitive, lxoPartialKey, lxoFromCurrent, lxoBackward]);
    else
      Result := oDS.LocateEx(AGrid.SelectedField.FieldName, Text,
        [lxoCaseInsensitive, lxoPartialKey]);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TADDatasetFeaturesEh.FillSTFilterListDataValues(AGrid: TCustomDBGridEh;
  AColumn: TColumnEh; AItems: TStrings);
Var
  oDS: TADAdaptedDataSet;
  oField: TField;
  oData: TStringList;
  i: Integer;
  oCol: TADDatSColumn;
begin
  oDS := AGrid.DataSource.DataSet as TADAdaptedDataSet;
  if bFilterWithValues and (AColumn.STFilter.ListSource = nil) and (not oDS.IsEmpty) then begin
    oField := oDS.FindField(AColumn.FieldName);
    if oField <> nil then begin
      oCol := oDS.GetFieldColumn(oField);
      if oCol <> nil then begin
        oData := TStringList.Create;
        oData.CaseSensitive := True;
        oData.Sorted := True;
        oData.Duplicates := dupIgnore;
        try
          for i := 0 to oDS.Table.Rows.Count - 1 do
            oData.Add(VarToStr(oDS.Table.Rows[i].ValueI[oCol.Index]));
          oData.Sort;
          AItems.AddObject('-', PopupListboxItemEhLine);
          AItems.AddStrings(oData);
        finally
          oData.Free;
        end;
      end;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
initialization
  bFilterWithValues := False;
  RegisterDatasetFeaturesEh(TADDatasetFeaturesEh, TADQuery);
  RegisterDatasetFeaturesEh(TADDatasetFeaturesEh, TADStoredProc);
  RegisterDatasetFeaturesEh(TADDatasetFeaturesEh, TADTable);
  RegisterDatasetFeaturesEh(TADDatasetFeaturesEh, TADMemTable);

end.
