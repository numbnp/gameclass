{*******************************************************}
{                                                       }
{                       EhLib v7.0                      }
{          Register object that sort data in            }
{                TADODataSet, TADOQuery                 }
{                     (Build 7.0.03)                    }
{                                                       }
{   Copyright (c) 2002, 2013 by Dmitry V. Bolshakov     }
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
  DbUtilsEh, ADODB, DB, DBGridEh, ToolCtrlsEh;

implementation

uses Classes;

//type
//  TADODataSetCr ack = class(TADODataSet);

function ADODataSetDriverName(DataSet: TADODataSet): String;
begin
  if  Assigned(DataSet.Connection)  and
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
    function NullComparisonSyntax(AGrid: TCustomDBGridEh; DataSet: TDataSet): TNullComparisonSyntaxEh; override;
    procedure ApplySorting(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean); override;
    procedure SortDataInADODataSet(Grid: TCustomDBGridEh; DataSet: TCustomADODataSet);
    constructor Create; override;
  end;

  TADOCommandTextDatasetFeaturesEh = class(TCommandTextDatasetFeaturesEh)
  public
    function NullComparisonSyntax(AGrid: TCustomDBGridEh; DataSet: TDataSet): TNullComparisonSyntaxEh; override;
    procedure ApplySorting(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean); override;
    procedure SortDataInADODataSet(Grid: TCustomDBGridEh; DataSet: TCustomADODataSet);
    constructor Create; override;
  end;

//implementation

{ TADOSQLDatasetFeaturesEh }

procedure TADOSQLDatasetFeaturesEh.ApplySorting(Sender: TObject;
  DataSet: TDataSet; IsReopen: Boolean);
begin
  if Sender is TCustomDBGridEh then
    if TCustomDBGridEh(Sender).SortLocal then
      SortDataInADODataSet(TCustomDBGridEh(Sender), TCustomADODataSet(DataSet))
    else
      inherited ApplySorting(Sender, DataSet, IsReopen);
end;

constructor TADOSQLDatasetFeaturesEh.Create;
begin
  inherited Create;
  DateValueToSQLString := DateValueToADOSQLStringProc;
  SupportsLocalLike := True;
end;

function TADOSQLDatasetFeaturesEh.NullComparisonSyntax(
  AGrid: TCustomDBGridEh; DataSet: TDataSet): TNullComparisonSyntaxEh;
begin
  if AGrid.STFilter.Local
    then Result := ncsAsEqualToNullEh
    else Result := ncsAsIsNullEh;
end;

procedure TADOSQLDatasetFeaturesEh.SortDataInADODataSet(
  Grid: TCustomDBGridEh; DataSet: TCustomADODataSet);
begin
  DataSet.Sort := BuildSortingString(Grid, DataSet);
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

function TADOCommandTextDatasetFeaturesEh.NullComparisonSyntax(
  AGrid: TCustomDBGridEh; DataSet: TDataSet): TNullComparisonSyntaxEh;
begin
  if AGrid.STFilter.Local
    then Result := ncsAsEqualToNullEh
    else Result := ncsAsIsNullEh;
end;

procedure TADOCommandTextDatasetFeaturesEh.SortDataInADODataSet(
  Grid: TCustomDBGridEh; DataSet: TCustomADODataSet);
begin
  DataSet.Sort := BuildSortingString(Grid, DataSet);
end;

initialization
  RegisterDatasetFeaturesEh(TADOSQLDatasetFeaturesEh, TADOQuery);
  RegisterDatasetFeaturesEh(TADOCommandTextDatasetFeaturesEh, TCustomADODataSet);
end.
