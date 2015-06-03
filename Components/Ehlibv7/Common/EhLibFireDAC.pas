{-----------------------------------------------------------------------------}
{ FireDAC EhLib addon                                                         }
{                                                                             }
{ (c)opyright DA-SOFT Technologies 2004-2013.                                 }
{ All rights reserved.                                                        }
{                                Build 7.0.02                                 }
{ --------------------------------------------------------------------------- }

{ --------------------------------------------------------------------------- }
{ Register object that sort and filtering data in TADQuery, TADStoredProc,    }
{ TSDTable and TADMemTable from FireDAC.                                      }
{ Add this unit to 'uses' clause of any unit of your project to allow         }
{ TDBGridEh to sort data in FireDAC datasets automatically after sorting      }
{ markers will be changed.                                                    }
{ TSQLDatasetFeaturesEh will try to find line in TFDQuery.SQL string that     }
{ begin from 'ORDER BY' phrase and replace line by 'ORDER BY FieldNo1         }
{ [DESC],....' using SortMarkedColumns.                                       }
{ --------------------------------------------------------------------------- }

unit EhLibFireDAC;

{$I EhLib.Inc}

interface

uses
  Classes, Db, SysUtils,
  DbUtilsEh, DBGridEh, ToolCtrlsEh,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFDDatasetFeaturesEh = class(TSQLDatasetFeaturesEh)
  private
    procedure FDDataSetLocalSort(AGrid: TCustomDBGridEh; ADataSet: TFDAdaptedDataSet);
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
  FireDAC.Stan.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Factory, FireDAC.DatS;

function DateValueToFDSQLStringProc(ADataSet: TDataSet; AValue: Variant): String;
begin
  Result := DateValueToDataBaseSQLString(
    C_FD_PhysRDBMSKinds[TFDAdaptedDataSet(ADataSet).PointedConnection.RDBMSKind], AValue);
end;

constructor TFDDatasetFeaturesEh.Create;
begin
  inherited Create;
  DateValueToSQLString := DateValueToFDSQLStringProc;
end;

procedure TFDDatasetFeaturesEh.ApplyFilter(ASender: TObject; ADataSet: TDataSet;
  AIsReopen: Boolean);
begin
  if (ASender is TCustomDBGridEh) and ADataSet.Active then
    if TDBGridEh(ASender).STFilter.Local then begin
      ADataSet.Filter := Trim(GetExpressionAsFilterString(TCustomDBGridEh(ASender),
        GetOneExpressionAsLocalFilterString, DateValueToFDSQLStringProc, False, True));
      ADataSet.Filtered := ADataSet.Filter <> '';
    end
    else
      ApplyFilterSQLBasedDataSet(TCustomDBGridEh(ASender), ADataSet,
        DateValueToFDSQLStringProc, AIsReopen, 'SQL');
end;

procedure TFDDatasetFeaturesEh.FDDataSetLocalSort(AGrid: TCustomDBGridEh;
  ADataSet: TFDAdaptedDataSet);
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

procedure TFDDatasetFeaturesEh.ApplySorting(ASender: TObject; ADataSet: TDataSet;
  AIsReopen: Boolean);
var
  oConn: TFDCustomConnection;
begin
  if (ASender is TCustomDBGridEh) and ADataSet.Active then
    if TCustomDBGridEh(ASender).SortLocal then
      FDDataSetLocalSort(TCustomDBGridEh(ASender), TFDAdaptedDataSet(ADataSet))
    else begin
      oConn := TFDAdaptedDataSet(ADataSet).PointedConnection;
      SortUsingFieldName := (oConn <> nil) and (oConn.RDBMSKind = mkMySQL);
      inherited ApplySorting(ASender, ADataSet, AIsReopen);
    end;
end;

function TFDDatasetFeaturesEh.LocateText(AGrid: TCustomDBGridEh;
  const FieldName: string; const Text: String; AOptions: TLocateTextOptionsEh;
  Direction: TLocateTextDirectionEh; Matching: TLocateTextMatchingEh;
  TreeFindRange: TLocateTextTreeFindRangeEh; TimeOut: LongWord = 0): Boolean;
var
  oDS: TFDAdaptedDataSet;
begin
  Result := inherited LocateText(AGrid, FieldName, Text, AOptions, Direction,
    Matching, TreeFindRange);

  Exit;
// LocateEx in some cases does not work properly
  if (FieldName <> '') or (Assigned(AGrid.SelectedField.OnGetText)) then
    Result := inherited LocateText(AGrid, FieldName, Text, AOptions, Direction,
      Matching, TreeFindRange)
  else if AGrid.SelectedField is TBlobField then
    Result := False
  else
  begin
    oDS := AGrid.DataSource.DataSet as TFDAdaptedDataSet;
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

procedure TFDDatasetFeaturesEh.FillSTFilterListDataValues(AGrid: TCustomDBGridEh;
  AColumn: TColumnEh; AItems: TStrings);
Var
  oDS: TFDAdaptedDataSet;
  oField: TField;
  oData: TStringList;
  i: Integer;
  oCol: TFDDatSColumn;
begin
  oDS := AGrid.DataSource.DataSet as TFDAdaptedDataSet;
  if bFilterWithValues and (AColumn.STFilter.ListSource = nil) and
    (not oDS.IsEmpty) then
  begin
    oField := oDS.FindField(AColumn.FieldName);
    if oField <> nil then
    begin
      oCol := oDS.GetFieldColumn(oField);
      if oCol <> nil then
      begin
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
  end else
    inherited FillSTFilterListDataValues(AGrid, AColumn, AItems);
end;

initialization
  bFilterWithValues := False;
  RegisterDatasetFeaturesEh(TFDDatasetFeaturesEh, TFDQuery);
  RegisterDatasetFeaturesEh(TFDDatasetFeaturesEh, TFDStoredProc);
  RegisterDatasetFeaturesEh(TFDDatasetFeaturesEh, TFDTable);
  RegisterDatasetFeaturesEh(TFDDatasetFeaturesEh, TFDMemTable);
end.
