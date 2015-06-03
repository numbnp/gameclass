{*******************************************************}
{                                                       }
{                       EhLib v7.0                      }
{                     PivotGridRegEh                    }
{                      Build 7.0.01                     }
{                                                       }
{   Copyright (c) 2014-2014 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit PivotGridRegEh;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, DB,
{$IFDEF EH_LIB_17} System.UITypes, {$ENDIF}
{$IFDEF FPC}
  ComponentEditors,
{$ELSE}
  DesignIntf, DesignEditors, VCLEditors, ToolsAPI, DesignWindows, ColnEdit, EhLibVCL,
{$ENDIF}
  PivotGridsEh, PivotGridToolsEh,
  MemTableEh,
  PivotGridPivotFieldsEditors;

{$IFDEF FPC}
{$ELSE}
type

{ TPivotDataSourceEhEditor }

  TPivotDataSourceEhEditor = class(TComponentEditor)
   public
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
    procedure ExecuteVerb(Index: Integer); override;
  end;
{$ENDIF}

procedure Register;

implementation

{$R PivotGridsEhReg.dcr}

procedure Register;
begin
  RegisterComponents('EhLib Controls', [TPivotGridEh, TPivotGridToolBoxEh]);
  RegisterComponents('EhLib Components', [TPivotDataSourceEh]);

{$IFDEF FPC}
{$ELSE}
  RegisterComponentEditor(TPivotDataSourceEh, TPivotDataSourceEhEditor);
{$ENDIF}
end;

{$IFDEF FPC}
{$ELSE}
procedure TPivotDataSourceEhEditor.ExecuteVerb(Index: Integer);
//var
//  Msg: TCMChanged;
begin
  case Index of
    0:
      ShowCollectionEditorClass(Designer, TPivotGridPivotFieldsEditor, Component,
        TPivotDataSourceEh(Component).PivotFields,  'PivotFields');
//    1:
//      ShowAboutForm;
  end;
end;

function TPivotDataSourceEhEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'PivotFields Editor ...';
//    1: Result := EhLibVerInfo + ' ' + EhLibBuildInfo + ' ' + EhLibEditionInfo;
  end;
end;

function TPivotDataSourceEhEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;
{$ENDIF}

end.
