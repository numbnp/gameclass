unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MemTableDataEh, Db, DBGridEhGrouping, ADODB, GridsEh, DBGridEh,
  MemTableEh, ToolCtrlsEh, DBGridEhToolCtrls, StdCtrls, Mask, DBCtrlsEh,
  ObjectInspectorEh,
  DBLookupEh, DynVarsEh, DBAxisGridsEh, EhLibVCL, DBVertGridsEh, PrnDbgeh,
  Vcl.ImgList;

type
  TForm1 = class(TForm)
    DBLookupComboboxEh1: TDBLookupComboboxEh;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBLookupComboboxEh1OpenDropDownForm(EditControl: TControl;
      Button: TEditButtonEh; var DropDownForm: TCustomForm;
      DynParams: TDynVarsEh);
    procedure DBLookupComboboxEh1CloseDropDownForm(EditControl: TControl;
      Button: TEditButtonEh; Accept: Boolean; DropDownForm: TCustomForm;
      DynParams: TDynVarsEh);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses Unit2;

{$R *.dfm}

procedure TForm1.DBLookupComboboxEh1OpenDropDownForm(EditControl: TControl;
  Button: TEditButtonEh; var DropDownForm: TCustomForm; DynParams: TDynVarsEh);
begin
  DropDownForm2.SetSelectedData(DBLookupComboboxEh1.KeyValue);
end;

procedure TForm1.DBLookupComboboxEh1CloseDropDownForm(EditControl: TControl;
  Button: TEditButtonEh; Accept: Boolean; DropDownForm: TCustomForm;
  DynParams: TDynVarsEh);
var
  AText: String;
  AKeyValue: Variant;
begin
  if not Accept then Exit;

  DropDownForm2.GetSelectedData(AText, AKeyValue);
  DBLookupComboboxEh1.Text := AText;
  DBLookupComboboxEh1.KeyValue := AKeyValue;
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F11 then
    ShowObjectInspectorForm(ActiveControl, Rect(Left+Width+10, Top, Left+Width+10+300, Top+Height));
end;

initialization
//  DBGridEhDefaultStyle.IsDrawFocusRect := False;
  DefFontData.Name := 'Tahoma';
//  DBGridEhDebugDraw := True;
//  DefFontData.Height := 20;
end.
