{*******************************************************}
{                                                       }
{                        EhLib                          }
{    Copyright (c) 2002 - 2010 by Dmitry V. Bolshakov   }
{                                                       }
{  Register object that sort and filtering data in      }
{  TSDQuery, TSDMacroQuery and TSDTable from SQLDirect  }
{                                                       }
{  v 3.0 Copyright (c) 2003-2010 by Andrew Holubovski   }
{                                                       }
{*******************************************************}

{*******************************************************}
{ Add this unit to 'uses' clause of any unit of your    }
{ project to allow TDBGridEh to sort data in            }
{ TSDQuery and TSDMacroQuery automatically after        }
{ sorting markers will be changed.                      }
{ TSQLDatasetFeaturesEh will try to find line in        }
{ TSDQuery.SQL and TSDMacroQuery.SQL string that begin  }
{ from 'ORDER BY' phrase and replace line by 'ORDER BY  }
{  FieldNo1 [DESC],....' using SortMarkedColumns        }
{                   Attention!!!                        }
{ For TSDTable sorting and filter work only locally     }
{*******************************************************}

{*******************************************************}
{ History                                               }
{ v3.0                                                  }
{  + Lookup fields are sorted by a key field            }
{  - Removed TypInfo and GetEnumName                    }
{  + LocateText function (base on version from Stalker) }
{  + Automatic filling of the filter with values from a }
{    column (establish bFilterWithValues: = True)       }
{ v2.0                                                  }
{  + Support TSDMacroQuery for SQLDirect 3.0            }
{  + Support Local sorting for SQLDirect 4.1            }
{  + Support TSDTable for SQLDirect 3.0                 }
{*******************************************************}

unit EhLibSD;

{$I EhLib.Inc}

interface

uses
  Classes, DbUtilsEh, DBGridEh, ToolCtrlsEh, SDEngine, Db, SysUtils;

type
  TSDSQLDatasetFeaturesEh = class(TSQLDatasetFeaturesEh)
  private
   Procedure SDDataSetLocalSort(Grid: TCustomDBGridEh; DataSet: TSDDataSet); // Delete procedure "SDDataSetLocalSort" for SQLDirect < v4.1
  public
   constructor Create; override;
   procedure ApplyFilter(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean); override;
   procedure ApplySorting(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean); override;
   function LocateText(AGrid: TCustomDBGridEh; const FieldName: string; const Text: String;
                       AOptions: TLocateTextOptionsEh; Direction: TLocateTextDirectionEh;
                       Matching: TLocateTextMatchingEh; TreeFindRange: TLocateTextTreeFindRangeEh): Boolean; override;
   procedure FillSTFilterListDataValues(AGrid: TCustomDBGridEh; Column: TColumnEh; Items: TStrings); override;
  end;

Var
 bFilterWithValues: Boolean;

implementation

function DateValueToSDSQLStringProc(DataSet: TDataSet; Value: Variant): String;
begin
 Result := DateValueToDataBaseSQLString(GetServerTypeName(TSDDataSet(DataSet).Database.ServerType), Value)
end;

{ TSDSQLDatasetFeaturesEh }

constructor TSDSQLDatasetFeaturesEh.Create;
begin
 inherited Create;
 DateValueToSQLString := DateValueToSDSQLStringProc;
end;

procedure TSDSQLDatasetFeaturesEh.ApplyFilter(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean);
begin
 If (Sender is TCustomDBGridEh) and DataSet.Active then
  if TDBGridEh(Sender).STFilter.Local
    or (DataSet is TSDTable) // delete for SQLDirect < v3.0
   then begin
    DataSet.Filter   := Trim(GetExpressionAsFilterString(TCustomDBGridEh(Sender), GetOneExpressionAsLocalFilterString, DateValueToSDSQLStringProc));
    DataSet.Filtered := DataSet.Filter<>'';
   end
   else ApplyFilterSQLBasedDataSet(TCustomDBGridEh(Sender), DataSet, DateValueToSDSQLStringProc, IsReopen, 'SQL');
end;

Procedure TSDSQLDatasetFeaturesEh.SDDataSetLocalSort(Grid: TCustomDBGridEh; DataSet: TSDDataSet);
 Var
  iColumn: Integer;
  sFields, sAscOrder, sCaseSensitive, sFieldName: String;
begin
 If Grid.SortMarkedColumns.Count>0 then
  Try
   sFields := '';
   sAscOrder := '';
   sCaseSensitive := '';
   For iColumn := 0 to Grid.SortMarkedColumns.Count-1 do
    begin
     sFieldName := Grid.SortMarkedColumns[iColumn].FieldName;
     If (Grid.DataSource.DataSet.FieldByName(sFieldName).FieldKind = fkLookup) and (Pos(';', Grid.DataSource.DataSet.FieldByName(sFieldName).KeyFields)=0) then
      sFieldName := Grid.DataSource.DataSet.FieldByName(sFieldName).KeyFields;
     sFields := sFields + sFieldName +';';
     If Grid.SortMarkedColumns[iColumn].Title.SortMarker = smUpEh
      then sAscOrder := sAscOrder + 'Desc;'
      else sAscOrder := sAscOrder + 'Asc;';
//     sCaseSensitive := sCaseSensitive + 'False;'; // if you wants case insensitive
     sCaseSensitive := sCaseSensitive + 'True;'; // if you wants case sensitive
    end;
   Delete(sFields, Length(sFields), 1);
   Delete(sAscOrder, Length(sAscOrder), 1);
   Delete(sCaseSensitive, Length(sCaseSensitive), 1);
   DataSet.SortRecords(sFields, sAscOrder, sCaseSensitive);
  Except
  End;
end;

procedure TSDSQLDatasetFeaturesEh.ApplySorting(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean);
begin
  If (Sender is TCustomDBGridEh) and DataSet.Active then
   if TCustomDBGridEh(Sender).SortLocal // delete for SQLDirect < v4.1
      or (DataSet is TSDTable)          // delete for SQLDirect < v3.0
    then
     SDDataSetLocalSort(TCustomDBGridEh(Sender), TSDDataSet(DataSet)) // delete for SQLDirect < v4.1
    else begin
     SortUsingFieldName := TSDDataSet(DataSet).Database.ServerType = stMySQL;
     inherited ApplySorting(Sender, DataSet, IsReopen);
    end;
end;

function TSDSQLDatasetFeaturesEh.LocateText(AGrid: TCustomDBGridEh; const FieldName: string; const Text: String;
                    AOptions: TLocateTextOptionsEh; Direction: TLocateTextDirectionEh;
                    Matching: TLocateTextMatchingEh; TreeFindRange: TLocateTextTreeFindRangeEh): Boolean;
begin
 If (FieldName <> '') or (Assigned(AGrid.SelectedField.OnGetText))
  then Result := inherited LocateText(AGrid, FieldName, Text, AOptions, Direction, Matching, TreeFindRange)
  else if AGrid.SelectedField is TBlobField
        then Result := False
        else case Direction of
              ltdDownEh: Result := (AGrid.DataSource.DataSet as TSDDataSet).LocateNext(AGrid.SelectedField.FieldName, Text, [loCaseInsensitive, loPartialKey]);
              ltdUpEh  : Result := (AGrid.DataSource.DataSet as TSDDataSet).LocatePrior(AGrid.SelectedField.FieldName, Text, [loCaseInsensitive, loPartialKey]);
              else Result := (AGrid.DataSource.DataSet as TSDDataSet).Locate(AGrid.SelectedField.FieldName, Text, [loCaseInsensitive, loPartialKey])
             end;
end;

procedure TSDSQLDatasetFeaturesEh.FillSTFilterListDataValues(AGrid: TCustomDBGridEh; Column: TColumnEh; Items: TStrings);
 Var
  ds: TSDDataSet;
  Field: TField;
  bm: TBookmark;
  slData, slTemp: TStringList;
  sFilter: String;
  i: Integer;
begin
 ds := TSDDataSet(AGrid.DataSource.DataSet);
 If bFilterWithValues and (Column.STFilter.ListSource = nil) and (not ds.IsEmpty) then
  begin
   Field := ds.FindField(Column.FieldName);
   If Field <> nil then
    Try
     slTemp := TStringList.Create;
     For i := 0 to Items.Count - 1 do
      slTemp.AddObject(Items.Strings[i], Items.Objects[i]);
     slData := TStringList.Create;
     slData.Sorted := True;
     slData.CaseSensitive := True;
     ds.DisableControls;
     bm := ds.GetBookmark;
     sFilter := ds.Filter;
     ds.Filter := '';
     ds.FetchAll;
     ds.First;
     While not ds.Eof do
      begin
       slData.Add(Field.AsString);
       ds.Next;
      end;
    Finally
     ds.Filter := sFilter;
     ds.GotoBookmark(bm);
     ds.FreeBookmark(bm);
     ds.EnableControls;
     For i := 0 to slTemp.Count - 1 do
      Items.AddObject(slTemp.Strings[i], slTemp.Objects[i]);
     slTemp.Free;
     Items.AddObject('-', PopupListboxItemEhLine);
     Items.AddStrings(slData);
     slData.Free;
    End;
  end;
end;

initialization
 bFilterWithValues := False;
 RegisterDatasetFeaturesEh(TSDSQLDatasetFeaturesEh, TSDQuery);
 RegisterDatasetFeaturesEh(TSDSQLDatasetFeaturesEh, TSDMacroQuery); // delete for SQLDirect < v3.0
 RegisterDatasetFeaturesEh(TSDSQLDatasetFeaturesEh, TSDTable);      // delete for SQLDirect < v3.0
end.
