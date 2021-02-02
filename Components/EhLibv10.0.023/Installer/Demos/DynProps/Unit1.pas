unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, DBCtrlsEh, DynVarsEh, DBGridEh, DBLookupEh, MemTableEh,
  DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, MemTableDataEh, Db,
  ADODB, GridsEh, ComCtrls;

type
  TForm1 = class(TForm)
    DBGridEh1: TDBGridEh;
    MemTableEh1: TMemTableEh;
    DataSource1: TDataSource;
    Button6: TButton;
    Label1: TLabel;
    Button8: TButton;
    procedure bNumber5Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.bNumber5Click(Sender: TObject);
var
  i, i5: Integer;
begin
  i5 := 0;
  for I := 0 to ControlCount-1 do
  begin
    if (Controls[i] is TCustomDBEditEh) then
      if TCustomDBEditEh(Controls[i]).DynProps['Number5'].AsInteger = 5 then
        i5 := i5 + 1;
  end;
  ShowMessage('Controls with Number5 var is ' + VarToStr(i5));
end;

procedure TForm1.Button8Click(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to DBGridEh1.Columns.Count-1 do
  begin
    if DBGridEh1.Columns[i].DynProps['V2'].AsInteger = 5 then
      DBGridEh1.Columns[i].Color := clSkyBlue
    else
      DBGridEh1.Columns[i].Color := DBGridEh1.Color
  end;
end;

procedure TForm1.Button6Click(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to DBGridEh1.Columns.Count-1 do
  begin
    if DBGridEh1.Columns[i].DynProps['V1'].AsInteger = 1 then
      DBGridEh1.Columns[i].Color := clMoneyGreen
    else
      DBGridEh1.Columns[i].Color := DBGridEh1.Color
  end;
end;

end.
