{*******************************************************}
{                                                       }
{                       EhLib 10.0                      }
{          Register object that sort data in            }
{                TCustomClientDataSet                   }
{                                                       }
{   Copyright (c) 2002-2020 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

{*******************************************************}
{ Add this unit to 'uses' clause of any unit of your    }
{ project to allow TDBGridEh to sort data in            }
{ TClientDataSet automatically  after sorting markers   }
{ will be changed.                                      }
{ TCDSDatasetFeaturesEh determine if                    }
{ TDBGridEh.SortLocal = True then it will create index  }
{ w ith name 'SortIndexEh' using SortMarkedColumns       }
{ else if SortLocal = False and CDS connected to other  }
{ DataSet via DataSetProvider it will try to sord data  }
{ in this DataSet using GetDatasetFeaturesForDataSet    }
{ function                                              }
{*******************************************************}

unit EhLibCDS;

{$I EhLib.Inc}

interface

uses
  Variants,
  DBUtilsEh, DBGridEh, Db, DBClient, Provider, SysUtils, Classes;

type

  TCDSDatasetFeaturesEh = class(TDatasetFeaturesEh)
  public
    function GetLikeWildcardForSeveralCharacters: String; override;
    function GetProviderDataSet(DataSet: TDataSet): TDataSet; virtual;
    procedure ApplySorting(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean); override;
    procedure ApplyFilter(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean); override;
    procedure FillSTFilterListDataValues(AGrid: TCustomDBGridEh; Column: TColumnEh; Items: TStrings); override;
    procedure FillSTFilterListCommandValues(AGrid: TCustomDBGridEh; Column: TColumnEh; Items: TStrings); override;
  end;

implementation

uses ToolCtrlsEh;

type
  TCustomClientDataSetCrack = class(TCustomClientDataSet);

{ TCDSDatasetFeaturesEh }

function TCDSDatasetFeaturesEh.GetProviderDataSet(DataSet: TDataSet): TDataSet;
var
{$IFDEF CIL}
  CDS: TClientDataSet;
{$ELSE}
  CDS: TCustomClientDataSetCrack;
{$ENDIF}
  ProvComp: TComponent;
  DS: TObject;
begin
  Result := nil;
  if not (DataSet is TCustomClientDataSet) then Exit;
{$IFDEF CIL}
{ TODO : How to get ProviderName for TCustomDataSet under CIL }
  if DataSet is TClientDataSet
    then CDS := TClientDataSet(DataSet)
    else Exit;
{$ELSE}
  CDS := TCustomClientDataSetCrack(DataSet);
{$ENDIF}
  if (CDS.ProviderName <> '') and Assigned(CDS.Owner) then
  begin
    ProvComp := CDS.Owner.FindComponent(CDS.ProviderName);
    if Assigned(ProvComp) and (ProvComp is TCustomProvider) then
    begin
      DS := GetObjectProperty(ProvComp, 'DataSet');
      if Assigned(DS) and (DS is TDataSet) then
        Result := TDataSet(DS);
    end;
  end;
end;

procedure TCDSDatasetFeaturesEh.ApplySorting(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean);
var
  DS: TDataSet;
  CDS: TCustomClientDataSetCrack;
  DatasetFeatures: TDatasetFeaturesEh;
  i: Integer;
  IndexFields, IndexDescFields, MasterFields: String;
  SortOrder: TSortOrderEh;
  grid: TCustomDBGridEh;
begin
  if Sender is TCustomDBGridEh then
    if TCustomDBGridEh(Sender).SortLocal then
    begin
      grid := TCustomDBGridEh(Sender);
      IndexFields := '';
      IndexDescFields := '';
      for i := 0 to grid.SortMarkedColumns.Count - 1 do
      begin
        if (TCustomClientDataSetCrack(DataSet).FieldByName(grid.SortMarkedColumns[i].FieldName).FieldKind = fkLookup) then
        begin
          IndexFields := IndexFields + TCustomClientDataSetCrack(DataSet).FieldByName(grid.SortMarkedColumns[i].FieldName).KeyFields + ';';
          if grid.SortMarkedColumns[i].Title.SortMarker = smUpEh then
            IndexDescFields := IndexDescFields + TCustomClientDataSetCrack(DataSet).FieldByName(grid.SortMarkedColumns[i].FieldName).KeyFields + ';';
        end else
        begin
          IndexFields := IndexFields + grid.SortMarkedColumns[i].FieldName + ';';
          SortOrder := grid.Center.GetSortOrderForSortMarker(TCustomDBGridEh(Sender),
            grid.SortMarkedColumns[i], grid.SortMarkedColumns[i].Title.SortMarker);
          if SortOrder = soDescEh then
            IndexDescFields := IndexDescFields + grid.SortMarkedColumns[i].FieldName + ';'
        end;
      end;
      Delete(IndexFields,Length(IndexFields),1);
      Delete(IndexDescFields,Length(IndexDescFields),1);
      if (DataSet is TCustomClientDataSet) then
      begin
        CDS := TCustomClientDataSetCrack(DataSet);
        if CDS.MasterSource <> Nil then
        begin
          if (CDS.IndexFieldNames <> '') then  
          begin                                
            CDS.IndexDefs.Update;
            CDS.AddIndex('MasterFieldsIndexEh', CDS.IndexFieldNames, []);
            CDS.IndexDefs.Update;
          end;
          i := CDS.IndexDefs.IndexOf('MasterFieldsIndexEh');

          MasterFields := CDS.IndexDefs[i].Fields;
          if IndexFields <> '' Then MasterFields := MasterFields + ';';
          IndexFields := MasterFields + IndexFields;
          CDS.IndexName := 'MasterFieldsIndexEh'; 
        end;

        CDS.IndexDefs.Update;
        if CDS.IndexDefs.IndexOf('SortIndexEh') >= 0 then
          CDS.DeleteIndex('SortIndexEh');
        if IndexFields > '' then
        begin
          CDS.AddIndex('SortIndexEh', IndexFields, [], IndexDescFields);
          CDS.IndexDefs.Update;
          CDS.IndexName := 'SortIndexEh';
        end else
          CDS.IndexName := '';
      end;
    end else
    begin
      DS := GetProviderDataSet(DataSet);
      if DS <> nil then
      begin
        DatasetFeatures := GetDatasetFeaturesForDataSet(DS);
        if DatasetFeatures <> nil then
          DatasetFeatures.ApplySorting(Sender, DS, False);
        DataSet.Close;
        DataSet.Open;
      end;
    end;
end;

procedure TCDSDatasetFeaturesEh.ApplyFilter(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean);
var
  DS: TDataSet;
  DatasetFeatures: TDatasetFeaturesEh;
begin
  if TDBGridEh(Sender).STFilter.Local then
  begin
    TDBGridEh(Sender).DataSource.DataSet.Filter :=
      GetExpressionAsFilterString(TDBGridEh(Sender),
        GetOneExpressionAsLocalFilterString, nil, False, True);
    
    if TDBGridEh(Sender).DataSource.DataSet.Filter = '' then
      TDBGridEh(Sender).DataSource.DataSet.Filter := '1=1';
    TDBGridEh(Sender).DataSource.DataSet.Filtered := True;
  end else if (DataSet is TCustomClientDataSet) then
  begin
    DS := GetProviderDataSet(TCustomClientDataSet(DataSet));
    if DS <> nil then
    begin
      DatasetFeatures := GetDatasetFeaturesForDataSet(TDataSet(DS));
      if (DatasetFeatures <> nil) then
        DatasetFeatures.ApplyFilter(TDBGridEh(Sender), TDataSet(DS), False);
      DataSet.Close;
      DataSet.Open;
    end;
  end;
end;

function TCDSDatasetFeaturesEh.GetLikeWildcardForSeveralCharacters: String;
begin
  Result := '%';
end;

procedure TCDSDatasetFeaturesEh.FillSTFilterListCommandValues(
  AGrid: TCustomDBGridEh; Column: TColumnEh; Items: TStrings);
begin
  if Assigned(AGrid.Center) then
     AGrid.Center.StandardFillSTFilterListCommandValues(AGrid, Column, Items, False, True);
end;

procedure TCDSDatasetFeaturesEh.FillSTFilterListDataValues(
  AGrid: TCustomDBGridEh; Column: TColumnEh; Items: TStrings);
var
  Clone: TClientDataSet;
  SrcCDS: TClientDataSet;
  s: String;
  f: TField;
  i: Integer;
  k: Integer;
begin
  if Column.LookupParams.LookupActive or
     (Column.STFilter.ListSource <> nil) then
  begin
    AGrid.Center.StandardFillSTFilterListDataValues(AGrid, Column, Items);
    Exit;
  end;

  if (Column.FieldName = '') or (Column.Field = nil) then Exit;

  SrcCDS := AGrid.DataSource.DataSet as TClientDataSet;
  Clone := TClientDataSet.Create(nil);
  try
    Clone.CloneCursor(SrcCDS, True);
    Clone.IndexFieldNames := Column.FieldName;
    f := Clone.FieldByName(Column.FieldName);

    Clone.First;
    if not Clone.Eof then
    begin
      s := f.AsString;
      Items.AddObject(s, nil);
    end;

    while not Clone.Eof do
    begin
      if s <> f.AsString then
      begin
        s := f.AsString;
        Items.AddObject(s, nil);
      end;
      Clone.Next;
    end;
  finally
    Clone.Free;
  end;

  if Column.STFilter.ListSource = nil then
  begin
    if (Column.KeyList.Count > 0) and (Column.PickList.Count > 0) then
    begin
      for i := 0 to Items.Count - 1 do
      begin
        k := Column.KeyList.IndexOf(Items[i]);
        if k >= 0 then
          Items[i] := Column.PickList[k];
      end;
    end;
  end;

end;

initialization
  RegisterDatasetFeaturesEh(TCDSDatasetFeaturesEh, TCustomClientDataSet);
end.
