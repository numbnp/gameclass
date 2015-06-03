unit MemoEditUnit;

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, LMessages, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  DropDownFormEh, Dialogs, Buttons, ExtCtrls, StdCtrls, DynVarsEh, ToolCtrlsEh,
  DBAxisGridsEh;

type

  { TDropDownMemoEdit }

  TDropDownMemoEdit = class(TCustomDropDownFormEh)
    Memo1: TMemo;
    Panel1: TPanel;
    sbOk: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Bevel1: TBevel;
    procedure FormCreate(Sender: TObject);
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

var
  DropDownMemoEdit: TDropDownMemoEdit;

implementation

{$R *.lfm}

procedure TDropDownMemoEdit.FormCreate(Sender: TObject);
begin
  OnInitForm := CustomDropDownFormEhInitForm;
  OnReturnParams := CustomDropDownFormEhReturnParams;
end;

procedure TDropDownMemoEdit.CustomDropDownFormEhReturnParams(
  Sender: TCustomDropDownFormEh; DynParams: TDynVarsEh);
begin
  DynParams.Items[0].AsString := Memo1.Lines.Text;
end;

procedure TDropDownMemoEdit.CustomDropDownFormEhInitForm(
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

class function TDropDownMemoEdit.GetGlobalRef: TCustomDropDownFormEh;
begin
  if DropDownMemoEdit = nil then
    Application.CreateForm(TDropDownMemoEdit, DropDownMemoEdit);
  Result := DropDownMemoEdit;
end;

procedure TDropDownMemoEdit.sbOkClick(Sender: TObject);
begin
  ModalResult := mrOk;
  Close;
end;

procedure TDropDownMemoEdit.SpeedButton2Click(Sender: TObject);
begin
  ModalResult := mrCancel;
  Close;
end;

initialization
  RegisterClass(TDropDownMemoEdit);
end.
