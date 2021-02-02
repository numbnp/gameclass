unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls,
  MemTableDataEh, Db, MemTableEh, GridsEh, DBGridEh, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    PaintBox1: TPaintBox;
    Label1: TLabel;
    Panel2: TPanel;
    Button1: TButton;
    DBGridEh1: TDBGridEh;
    MemTableEh1: TMemTableEh;
    DataSource1: TDataSource;
    Button2: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    function GetFieldUnicName(InitName: String): String;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  NewStruct: TMTDataStructEh;
  bf: TMTStringDataFieldEh;
begin
  NewStruct := MemTableEh1.RecordsView.MemTableData.DataStruct.BeginRestructure;

  bf := TMTStringDataFieldEh(NewStruct.CreateField(TMTStringDataFieldEh));
  bf.FieldName := GetFieldUnicName('StringField');

  MemTableEh1.RecordsView.MemTableData.DataStruct.EndRestructure(NewStruct, True);
end;

function TForm1.GetFieldUnicName(InitName: String): String;
var
  i: Integer;
begin
  i := 1;
  while True do
  begin
    Result := InitName + IntToStr(i);
    if MemTableEh1.RecordsView.MemTableData.DataStruct.FindField(Result) <> nil then
      Inc(i)
    else
      Break;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  NewStruct: TMTDataStructEh;
begin
  NewStruct := MemTableEh1.RecordsView.MemTableData.DataStruct.BeginRestructure;

  NewStruct.ChangeFieldType('IntField', TMTStringDataFieldEh);

  MemTableEh1.RecordsView.MemTableData.DataStruct.EndRestructure(NewStruct, True);
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  NewStruct: TMTDataStructEh;
  DataField: TMTDataFieldEh;
begin
  NewStruct := MemTableEh1.RecordsView.MemTableData.DataStruct.BeginRestructure;

  DataField := NewStruct.FindField('StringField');
  if DataField <> nil then
  begin
    NewStruct.RemoveField(DataField);
    DataField.Free;
  end;

  MemTableEh1.RecordsView.MemTableData.DataStruct.EndRestructure(NewStruct, True);
end;

end.
