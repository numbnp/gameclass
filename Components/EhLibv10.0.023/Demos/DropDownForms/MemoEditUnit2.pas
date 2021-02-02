unit MemoEditUnit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  DropDownFormEh, Dialogs, Buttons, ExtCtrls, StdCtrls, DynVarsEh, ToolCtrlsEh,
  DBAxisGridsEh;

type
  TDropDownMemoEdit2 = class(TCustomDropDownFormEh)
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
  end;

var
  DropDownMemoEdit2: TDropDownMemoEdit2;

implementation

{$R *.dfm}

procedure TDropDownMemoEdit2.CustomDropDownFormEhReturnParams(
  Sender: TCustomDropDownFormEh; DynParams: TDynVarsEh);
begin
  DynParams.Items[0].AsString := Memo1.Lines.Text;
end;

procedure TDropDownMemoEdit2.CustomDropDownFormEhInitForm(
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

procedure TDropDownMemoEdit2.sbOkClick(Sender: TObject);
begin
  ModalResult := mrOk;
  Close;
end;

procedure TDropDownMemoEdit2.SpeedButton2Click(Sender: TObject);
begin
  ModalResult := mrCancel;
  Close;
end;

initialization
  RegisterClass(TDropDownMemoEdit2);
end.
