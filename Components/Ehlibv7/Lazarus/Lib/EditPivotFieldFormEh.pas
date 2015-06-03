{*******************************************************}
{                                                       }
{                        EhLib v7.0                     }
{                                                       }
{            PivotField Sum function Edit Form          }
{                      Build 7.0.001                    }
{                                                       }
{   Copyright (c) 2014-2014 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

unit EditPivotFieldFormEh;

{$I EhLib.Inc}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
{$IFDEF EH_LIB_17} System.UITypes, {$ENDIF}
  Dialogs, StdCtrls,
  DBCtrlsEh, PivotGridsEh;

type
  TfEditPivotField = class(TForm)
    lFieldName: TLabel;
    fAggrFunc: TLabel;
    ListBox1: TListBox;
    bOk: TButton;
    bCancel: TButton;
    lDisplayFormat: TLabel;
    cbDisplayFormat: TDBComboBoxEh;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fEditPivotField: TfEditPivotField;

function EditPivotField(PivotFieldValueInfo: TPivotFieldValueInfoEh): Boolean;

implementation

{$R *.dfm}

function EditPivotField(PivotFieldValueInfo: TPivotFieldValueInfoEh): Boolean;
var
  f: TfEditPivotField;
begin
  Result := False;
  f := TfEditPivotField.Create(Application);

  f.lFieldName.Caption := 'Pivot field: ' + PivotFieldValueInfo.PivotField.FieldName;
  f.lFieldName.Font.Style := f.Font.Style + [fsBold];
  f.ListBox1.ItemIndex := Ord(PivotFieldValueInfo.SumFunction)-1;
  f.cbDisplayFormat.Text := PivotFieldValueInfo.DisplayFormat;

  if f.ShowModal = mrOk then
  begin
    PivotFieldValueInfo.SumFunction := TPivotValueTypeEh(f.ListBox1.ItemIndex+1);
    PivotFieldValueInfo.DisplayFormat := f.cbDisplayFormat.Text;
    Result := True;
  end;
  f.Free;
end;

end.
