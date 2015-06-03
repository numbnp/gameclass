unit MemoEditUnit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  DropDownFormEh, Dialogs, Buttons, ExtCtrls, StdCtrls, DynVarsEh, ToolCtrlsEh,
  DBAxisGridsEh;

type
  TDropDownMemoEdit3 = class(TCustomDropDownFormEh)
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

var
  DropDownMemoEdit3: TDropDownMemoEdit3;

implementation

{$R *.dfm}

procedure TDropDownMemoEdit3.CustomDropDownFormEhReturnParams(
  Sender: TCustomDropDownFormEh; DynParams: TDynVarsEh);
begin
  DynParams.Items[0].AsString := Memo1.Lines.Text;
end;

procedure TDropDownMemoEdit3.CustomDropDownFormEhInitForm(
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

class function TDropDownMemoEdit3.GetGlobalRef: TCustomDropDownFormEh;
begin
  if DropDownMemoEdit3 = nil then
    Application.CreateForm(TDropDownMemoEdit3, DropDownMemoEdit3);
  Result := DropDownMemoEdit3;
end;

procedure TDropDownMemoEdit3.sbOkClick(Sender: TObject);
begin
  ModalResult := mrOk;
  Close;
end;

procedure TDropDownMemoEdit3.SpeedButton2Click(Sender: TObject);
begin
  ModalResult := mrCancel;
  Close;
end;

initialization
  RegisterClass(TDropDownMemoEdit3);
end.
