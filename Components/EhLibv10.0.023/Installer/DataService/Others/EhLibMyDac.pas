{*******************************************************}
{                                                       }
{                        EhLib                          }
{    Copyright (c) 2002 - 2004 by Dmitry V. Bolshakov   }
{                                                       }
{  Register object that sort and filtering data in      }
{ TMyQuery, TMyTable & TVirtualTable from CoreLab MyDac }
{      Copyright (c) 2004 by Andrew Holubovski          }
{                                                       }
{*******************************************************}

{*******************************************************}
{ Add this unit to 'uses' clause of any unit of your    }
{ project to allow TDBGridEh to sort data in TMyQuery   }
{ and TMyTable automatically after sorting markers      }
{ will be changed.                                      }
{*******************************************************}
{                    Attention!!!                       }
{ 1. Limitation for not local filter. In FROM you can't }
{    use table aliases. Sample:                         }
{   Instead                                             }
{     SELECT t1.ID, NAME                                }
{     FROM Table1 t1, Table2 t2                         }
{     WHERE t1.ID=t2.ID                                 }
{   you need                                            }
{     SELECT Table1.ID, NAME                            }
{     FROM Table1, Table2                               }
{     WHERE Table1.ID=Table1.ID                         }
{ 2. TVirtualTable it's impossible to sort              }
{    (only filtering)                                   }
{                                                       }
{ The recommendation.  If you don't use TVirtualTable,  }
{ then remove VirtualTable from uses and                }
{ TVirtualTableSQLDatasetFeaturesEh definition          }
{*******************************************************}

unit EhLibMyDac;

{$I EhLib.Inc}

interface

uses
  DbUtilsEh, DBGridEh, Db, MyAccess, VirtualTable, ToolCtrlsEh,
  Classes, System.SysUtils;
//  ,Vcl.Dialogs;

type

  TMyQuerySQLDatasetFeaturesEh = class(TSQLDatasetFeaturesEh)
  public
    constructor Create; override;
    procedure ApplyFilter(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean); override;
    procedure ApplySorting(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean); override;
    procedure FillSTFilterListDataValues(AGrid: TCustomDBGridEh; AColumn: TColumnEh; AItems: TStrings); override;
  end;

  TVirtualTableSQLDatasetFeaturesEh = class(TDatasetFeaturesEh)
  public
    procedure ApplyFilter(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean); override;
  end;

var
 x : string;


implementation

function DateValueToMyDacSQLStringProc(DataSet: TDataSet; Value: Variant): String;
begin
  //Result := DateValueToDataBaseSQLString('MYSQL', Value);
  Result := '"' + FormatDateTime('yyyy-mm-dd', Value) + '"';

end;

{ TMyQuerySQLDatasetFeaturesEh }

constructor TMyQuerySQLDatasetFeaturesEh.Create;
begin
  inherited Create;
  SortUsingFieldName := True;
  DateValueToSQLString := DateValueToMyDacSQLStringProc;
end;

procedure TMyQuerySQLDatasetFeaturesEh.ApplyFilter(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean);
begin
  if TDBGridEh(Sender).STFilter.Local then
  begin
    DataSet.Filter := GetExpressionAsFilterString(TDBGridEh(Sender), GetOneExpressionAsLocalFilterString, nil);
    DataSet.Filtered := (DataSet.Filter <> '');
  end
  else
    (DataSet as TMyQuery).FilterSQL := GetExpressionAsFilterString(TDBGridEh(Sender), GetOneExpressionAsSQLWhereString, DateValueToMyDacSQLStringProc, True);
end;

procedure TMyQuerySQLDatasetFeaturesEh.ApplySorting(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean);
var
  i: Integer;
  sOrderFields: String;
begin
  If Sender is TCustomDBGridEh then
   With TCustomDBGridEh(Sender) do
    begin
     sOrderFields := '';
     If SortMarkedColumns.Count>0 then
      For i := 0 to SortMarkedColumns.Count - 1 do
       begin
        sOrderFields := sOrderFields + SortMarkedColumns[i].FieldName;
        If SortMarkedColumns[i].Title.SortMarker = smDownEh then
         sOrderFields := sOrderFields + ' DESC';
        sOrderFields := sOrderFields + ','
      end;
     Delete(sOrderFields,Length(sOrderFields),1);

     (DataSet as TMyQuery).IndexFieldNames := sOrderFields;
    End
end;

procedure TMyQuerySQLDatasetFeaturesEh.FillSTFilterListDataValues(AGrid: TCustomDBGridEh;
  AColumn: TColumnEh; AItems: TStrings);
Var
  SourceData : TMyQuery;
  CloneData : TVirtualTable;
  List: TStringList;
begin
  //ShowMessage('xxx');

  SourceData := AGrid.DataSource.DataSet as TMyQuery;

  if (AColumn.STFilter.ListSource = nil) and
    (not SourceData.IsEmpty) then
  begin
    CloneData := TVirtualTable.Create(nil);
    CloneData.Assign(SourceData);
    CloneData.Open;

    List := TStringList.Create;
    List.CaseSensitive := True;
    List.Sorted := True;
    List.Duplicates := dupIgnore;

    try
      while not CloneData.Eof do
      begin
        List.Add(CloneData.FieldByName(AColumn.FieldName).AsString);
        CloneData.Next;
      end;

      List.Sort;
      List.AddObject('-', PopupListboxItemEhLine);
      AItems.AddStrings(List);

    finally
      List.Free;

      CloneData.Close;
      CloneData.Free;
    end;

  end
  else
    inherited FillSTFilterListDataValues(AGrid, AColumn, AItems);

end;

{ TVirtualTableSQLDatasetFeaturesEh }

procedure TVirtualTableSQLDatasetFeaturesEh.ApplyFilter(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean);
begin
  DataSet.Filter := GetExpressionAsFilterString(TDBGridEh(Sender), GetOneExpressionAsLocalFilterString, nil)
end;

initialization
  RegisterDatasetFeaturesEh(TMyQuerySQLDatasetFeaturesEh, TMyQuery);
  RegisterDatasetFeaturesEh(TVirtualTableSQLDatasetFeaturesEh, TVirtualTable);
end.
