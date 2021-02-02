unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  DropDownFormEh, Dialogs, DynVarsEh, ToolCtrlsEh, MemTableDataEh, Data.DB,
  DBGridEhGrouping, DBGridEhToolCtrls, EhLibVCL, GridsEh, DBAxisGridsEh,
  DBGridEh, MemTableEh, Vcl.StdCtrls;

type
  TDropDownForm2 = class(TCustomDropDownFormEh)
    MemTableEh1: TMemTableEh;
    DataSource1: TDataSource;
    DBGridEh1: TDBGridEh;
    bOk: TButton;
    bCancel: TButton;
    MemTableEh1Id: TAutoIncField;
    MemTableEh1Name: TWideStringField;
    MemTableEh1Capital: TWideStringField;
    MemTableEh1Continent: TWideStringField;
    MemTableEh1Area: TFloatField;
    MemTableEh1Population: TFloatField;
    bClear: TButton;
    Button1: TButton;
    procedure bOkClick(Sender: TObject);
    procedure bCancelClick(Sender: TObject);
    procedure bClearClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure GetSelectedData(var Text: String; var KeyValue: Variant);
    procedure SetSelectedData(const KeyValue: Variant);
  end;

var
  DropDownForm2: TDropDownForm2;

implementation

{$R *.dfm}

procedure TDropDownForm2.bCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
  Close;
end;

procedure TDropDownForm2.bOkClick(Sender: TObject);
begin
  ModalResult := mrOk;
  Close;
end;

procedure TDropDownForm2.bClearClick(Sender: TObject);
begin
  DBGridEh1.SelectedRows.Clear;
end;

procedure TDropDownForm2.Button1Click(Sender: TObject);
begin
  DBGridEh1.SelectedRows.SelectAll;
end;

procedure TDropDownForm2.GetSelectedData(var Text: String;
  var KeyValue: Variant);
var
  i: Integer;
begin
  Text := '[';
  KeyValue := VarArrayCreate([0, DBGridEh1.SelectedRows.Count-1], varVariant);
  for i := 0 to DBGridEh1.SelectedRows.Count-1 do
  begin
    MemTableEh1.Bookmark := DBGridEh1.SelectedRows[i];
    Text := Text + MemTableEh1Name.AsString;
    if i < DBGridEh1.SelectedRows.Count-1 then
      Text := Text + ',';
    KeyValue[i] := MemTableEh1Id.Value;
  end;
  Text := Text + ']';
end;

procedure TDropDownForm2.SetSelectedData(const KeyValue: Variant);
var
  i, Rows: Integer;
begin
  Rows := 0;
  DBGridEh1.SelectedRows.Clear;
  if VarIsArray(KeyValue) then
    Rows := VarArrayHighBound(KeyValue, 1);
  for i := 0 to Rows-1 do
  begin
    if MemTableEh1.Locate('Id', KeyValue[i], []) then
      DBGridEh1.SelectedRows.CurrentRowSelected := True;
  end;
end;

end.