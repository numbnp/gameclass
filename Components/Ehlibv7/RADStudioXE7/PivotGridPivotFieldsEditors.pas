{*******************************************************}
{                                                       }
{                       EhLib v7.0                      }
{         Design time TPivotGridPivotFieldsEditor       }
{                      Build 7.0.01                     }
{                                                       }
{   Copyright (c) 2014-2014 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit PivotGridPivotFieldsEditors;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  {$IFDEF FPC}
  {$ELSE}
  ColnEdit, ActnPopup,
  {$ENDIF}
  Menus, ComCtrls, StdCtrls, ExtCtrls, DB, ActnList, ImgList, ToolWin;

{$IFDEF FPC}
{$ELSE}
type
  TPivotGridPivotFieldsEditor = class(TCollectionEditor)
    AddAllFields1: TMenuItem;
    Restoredefaults1: TMenuItem;
    AddAllFieldsCmd: TAction;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    N1: TMenuItem;
    procedure AddAllFieldsClick(Sender: TObject);
    procedure AddAllFieldsCmdUpdate(Sender: TObject);
    procedure ListView1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
  protected
    function CanAdd(Index: Integer): Boolean; override;
  public
    function CanAddAllFields: Boolean;
  end;
{$ENDIF}

implementation

uses TypInfo, PivotGridsEh;

{$R *.dfm}

{$IFDEF FPC}
{$ELSE}
function TPivotGridPivotFieldsEditor.CanAddAllFields: Boolean;
begin
  Result := False;
  if Component = nil then Exit;
  if Component is TPivotDataSourceEh then
    Result := (TPivotDataSourceEh(Component).DataSet <> nil)
      and (TPivotDataSourceEh(Component).DataSet.FieldCount > 0);
end;

procedure TPivotGridPivotFieldsEditor.AddAllFieldsClick(Sender: TObject);
var
  Result: Integer;
begin
  Result := idYes;
  if Collection.Count > 0 then
    Result := MessageDlg('sDeleteColumnsQuestion', mtConfirmation, mbYesNoCancel, 0);

  LockState;
  try
    case Result of
      idCancel: Exit;
      idYes: (Collection as TPivotFieldsEh).RebuildPivotFields;
      idNo: (Collection as TPivotFieldsEh).AddAllPivotFields(False);
    end;
  finally
    UnlockState;
    UpdateListbox;
    SetSelection;
    Designer.Modified;
  end;
end;

procedure TPivotGridPivotFieldsEditor.AddAllFieldsCmdUpdate(Sender: TObject);
begin
  inherited;
  AddAllFieldsCmd.Enabled := CanAddAllFields;
end;

function TPivotGridPivotFieldsEditor.CanAdd(Index: Integer): Boolean;
begin
  Result := Collection <> nil;
end;

procedure TPivotGridPivotFieldsEditor.ListView1DragOver(Sender, Source: TObject;
  X, Y: Integer; State: TDragState; var Accept: Boolean);
var
  Item: TListItem;
begin
  inherited ListView1DragOver(Sender, Source, X, Y, State, Accept);
  if not Accept then Exit;
  Item := Listview1.GetItemAt(X,Y);
  Accept := Item <> nil;
end;
{$ENDIF}

end.
