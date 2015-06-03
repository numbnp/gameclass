{*******************************************************}
{                                                       }
{                       EhLib v7.0                      }
{                    MemoEdit Dialog                    }
{                     (Build 7.0.01)                    }
{                                                       }
{     Copyright (c) 2013-2014 by Dmitry V. Bolshakov    }
{                                                       }
{*******************************************************}

unit MemoEditFormsEh;

interface

uses
  SysUtils, Variants, Classes, Graphics, Controls, Forms, Types,
  DropDownFormEh, Dialogs, Buttons, ExtCtrls, StdCtrls, DynVarsEh, ToolCtrlsEh;

type
  TMemoEditWinEh = class(TCustomDropDownFormEh)
    Memo1: TMemo;
    Panel1: TPanel;
    sbOk: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Bevel1: TBevel;
    procedure sbOkClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure CustomDropDownFormEhReturnParams(Sender: TCustomDropDownFormEh;
      DynParams: TDynVarsEh);
    procedure CustomDropDownFormEhInitForm(Sender: TCustomDropDownFormEh;
      DynParams: TDynVarsEh);
  private
    FPassParams: TDropDownPassParamsEh;
    { Private declarations }
  public
    class function GetGlobalRef: TCustomDropDownFormEh; override;
  end;

function DefaultShowMemoEditDialogEh(var Text: String; var FormPos: TRect; ReadOnly: Boolean): Boolean;

type
  TShowMemoEditDialogEhProg = function(var Text: String; var FormPos: TRect; ReadOnly: Boolean): Boolean;

var
  MemoEditWinEh: TMemoEditWinEh;

//  DefaultMemoEditDialogClassEh: TCustomForm;
  ShowMemoEditDialogEhProg: TShowMemoEditDialogEhProg;

  DefaultMemoEditDropDownFormClassEh: TCustomDropDownFormEh;
//  ShowMemoEditDropDownFormEhProg: TShowMemoEditDialogEhProg;

implementation

{$R *.dfm}

function DefaultShowMemoEditDialogEh(var Text: String; var FormPos: TRect; ReadOnly: Boolean): Boolean;
var
  AForm: TMemoEditWinEh;
  FDynParamsInteractorItfs: IDynParamsInteractableEh;
  DDParams: TDynVarsEh;
  OutDDParams: TDynVarsEh;
begin
  Result := False;
  AForm := TMemoEditWinEh(TMemoEditWinEh.GetGlobalRef);

  if Supports(AForm, IDynParamsInteractableEh, FDynParamsInteractorItfs) then
  begin
    DDParams := TDynVarsEh.Create(nil);
    try
    DDParams.CreateDynVar('', Text);
    FDynParamsInteractorItfs.SetInDynParams(DDParams);
    AForm.ReadOnly := ReadOnly;

    if TMemoEditWinEh.GetGlobalRef.ShowModal = mrOk then
    begin
      FDynParamsInteractorItfs.GetOutDynParams(OutDDParams);
      Text := VarToStr(OutDDParams.Items[0].Value);
      Result := True;
    end;
    finally
      DDParams.Free;
    end;
  end;
end;

procedure TMemoEditWinEh.CustomDropDownFormEhReturnParams(
  Sender: TCustomDropDownFormEh; DynParams: TDynVarsEh);
begin
  DynParams.Items[0].AsString := Memo1.Lines.Text;
end;

procedure TMemoEditWinEh.CustomDropDownFormEhInitForm(
  Sender: TCustomDropDownFormEh; DynParams: TDynVarsEh);
begin
  if DynParams.Count = 0 then
    FPassParams := pspByFieldNamesEh
  else if DynParams.Count = 1 then
  begin
    FPassParams := pspFieldValueEh;
    Memo1.Lines.Text := DynParams.Items[0].AsString;
  end else
  begin
    FPassParams := pspRecordValuesEh;
    Memo1.Lines.Text := DynParams.Items[0].AsString;
  end;

  sbOk.Enabled := not ReadOnly;
  Memo1.ReadOnly := ReadOnly;
end;

class function TMemoEditWinEh.GetGlobalRef: TCustomDropDownFormEh;
begin
  if MemoEditWinEh = nil then
    Application.CreateForm(TMemoEditWinEh, MemoEditWinEh);
  Result := MemoEditWinEh;
end;

procedure TMemoEditWinEh.sbOkClick(Sender: TObject);
begin
  ModalResult := mrOk;
  if DropDownMode then
    Close;
end;

procedure TMemoEditWinEh.SpeedButton2Click(Sender: TObject);
begin
  ModalResult := mrCancel;
  if DropDownMode then
    Close;
end;

initialization
  RegisterClass(TMemoEditWinEh);
  ShowMemoEditDialogEhProg := @DefaultShowMemoEditDialogEh;
end.
