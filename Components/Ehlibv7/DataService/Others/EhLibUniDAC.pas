{*******************************************************}
{                                                       }
{                       EhLib v5.5                      }
{   Register object that sort data in UniDAC DataSets   }
{                                                       }
{    Copyright (c) 2011 by Dmitry V. Bolshakov          }
{                                                       }
{*******************************************************}

{*******************************************************}
{ Add this unit to 'uses' clause of any unit of your    }
{ project to allow TDBGridEh to sort data in            }
{ TUniQuery and TTniTable automatically after sorting   }
{ markers  will be changed.                             }
{*******************************************************}

unit EhLibUniDAC;

{$I EhLib.Inc}

interface

uses
{$IFDEF EH_LIB_6} Variants, {$ENDIF}
  DbUtilsEh, DBGridEh, DBTables, Db, Uni, SysUtils, ToolCtrlsEh;

implementation

uses Classes;

function UniDataSetDriverName(DataSet: TBDEDataSet): String;
begin
end;

function DateValueToBDESQLStringProc(DataSet: TDataSet; Value: Variant): String;
begin
//  Result := DateValueToDataBaseSQLString(, Value)
  Result := '';
end;

type
  TUniDatasetFeaturesEh = class(TSQLDatasetFeaturesEh)
  public
    procedure ApplyFilter(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean); override;
    procedure ApplySorting(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean); override;
  end;

{ TBDEDatasetFeaturesEh }

procedure TUniDatasetFeaturesEh.ApplyFilter(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean);
begin
  if TDBGridEh(Sender).STFilter.Local then
  begin
    TDBGridEh(Sender).DataSource.DataSet.Filter :=
      GetExpressionAsFilterString(TDBGridEh(Sender),
        GetOneExpressionAsLocalFilterString, nil);
    TDBGridEh(Sender).DataSource.DataSet.Filtered := True;
  end else
    TCustomUniDataSet(DataSet).FilterSQL := GetExpressionAsFilterString(TDBGridEh(Sender),
        GetOneExpressionAsLocalFilterString, nil);
end;

procedure TUniDatasetFeaturesEh.ApplySorting(Sender: TObject; DataSet: TDataSet;
  IsReopen: Boolean);
var
  OrderByStr: String;
  i: Integer;
begin
  for i := 0 to TCustomDBGridEh(Sender).SortMarkedColumns.Count - 1 do
  begin
    OrderByStr := OrderByStr + TCustomDBGridEh(Sender).SortMarkedColumns[i].FieldName + ' ';
    if TCustomDBGridEh(Sender).SortMarkedColumns[i].Title.SortMarker = smUpEh then
      OrderByStr := OrderByStr + ' DESC';
    OrderByStr := OrderByStr + ',';
  end;
  Delete(OrderByStr, Length(OrderByStr), 1);

  if TDBGridEh(Sender).SortLocal then
    TCustomUniDataSet(TDBGridEh(Sender).DataSource.DataSet).IndexFieldNames := OrderByStr
  else if DataSet is TUniTable then
    TUniTable(DataSet).OrderFields := OrderByStr
  else
    inherited ApplySorting(Sender, DataSet, IsReopen);
end;

initialization
  RegisterDatasetFeaturesEh(TUniDatasetFeaturesEh, TUniQuery);
  RegisterDatasetFeaturesEh(TUniDatasetFeaturesEh, TUniTable);
end.
