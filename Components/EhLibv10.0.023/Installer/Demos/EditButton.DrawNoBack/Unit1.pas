unit Unit1;

{$I EhLib.Inc}

interface

uses
{$IFDEF EH_LIB_7}
  {$IFNDEF EH_LIB_16}
    XPMan,
  {$ENDIF}
{$ENDIF}
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MemTableDataEh, Db, DBGridEhGrouping, ADODB, GridsEh, DBGridEh,
  MemTableEh, ToolCtrlsEh, DBGridEhToolCtrls, StdCtrls, Mask, DBCtrlsEh,
  ObjectInspectorEh,
  DBLookupEh, DynVarsEh, DBAxisGridsEh, EhLibVCL, DBVertGridsEh,
  ImgList, ComCtrls;

type
  TForm1 = class(TForm)
    MemTableEh1: TMemTableEh;
    DBGridEh1: TDBGridEh;
    DataSource1: TDataSource;
    ADOTable1: TADOTable;
    ImageList1: TImageList;
    ComboBox1: TComboBox;
    DateTimePicker1: TDateTimePicker;
    Button1: TButton;
    DBEditEh1: TDBEditEh;
    DBDateTimeEditEh1: TDBDateTimeEditEh;
    DBEditEh2: TDBEditEh;
    Button2: TButton;
    DBNumberEditEh1: TDBNumberEditEh;
    DBComboBoxEh1: TDBComboBoxEh;
    DBDateTimeEditEh2: TDBDateTimeEditEh;
    DBNumberEditEh2: TDBNumberEditEh;
    DBComboBoxEh2: TDBComboBoxEh;
    DBEditEh3: TDBEditEh;
    Button3: TButton;
    Button4: TButton;
    DBVertGridEh1: TDBVertGridEh;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure EditButtonSetDrawFaceTime(DrawBackTime: TEditButtonDrawBackTimeEh);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.EditButtonSetDrawFaceTime(DrawBackTime: TEditButtonDrawBackTimeEh);
var
  i: Integer;
//  ci: Integer;
begin
  DBEditEh1.EditButtons[0].DrawBackTime := DrawBackTime;
  DBDateTimeEditEh1.EditButton.DrawBackTime := DrawBackTime;
  DBDateTimeEditEh2.EditButton.DrawBackTime := DrawBackTime;
  DBNumberEditEh1.EditButton.DrawBackTime := DrawBackTime;
  DBNumberEditEh2.EditButton.DrawBackTime := DrawBackTime;
  DBComboBoxEh1.EditButton.DrawBackTime := DrawBackTime;
  DBComboBoxEh2.EditButton.DrawBackTime := DrawBackTime;

  DBDateTimeEditEh1.EditButton.DrawBackTime := DrawBackTime;
  DBDateTimeEditEh1.EditButtons[0].DrawBackTime := DrawBackTime;

  for i := 0 to DBEditEh2.EditButtons.Count-1 do
    DBEditEh2.EditButtons[i].DrawBackTime := DrawBackTime;

  for i := 0 to DBEditEh3.EditButtons.Count-1 do
    DBEditEh3.EditButtons[i].DrawBackTime := DrawBackTime;

  DBVertGridEh1.RowsDefValues.EditButtonDrawBackTime := DrawBackTime;
  DBGridEh1.ColumnDefValues.EditButtonDrawBackTime := DrawBackTime;
//  for ci := 0 to DBVertGridEh1.Rows.Count-1 do
//  begin
//    DBVertGridEh1.Rows[ci].EditButton.DrawBackTime := DrawBackTime;
//    for i := 0 to DBVertGridEh1.Rows[ci].EditButtons.Count-1 do
//      DBVertGridEh1.Rows[ci].EditButtons[i].DrawBackTime := DrawBackTime;
//  end;
//
//
//  for ci := 0 to DBGridEh1.Columns.Count-1 do
//  begin
//    DBGridEh1.Columns[ci].EditButton.DrawBackTime := DrawBackTime;
//    for i := 0 to DBGridEh1.Columns[ci].EditButtons.Count-1 do
//      DBGridEh1.Columns[ci].EditButtons[i].DrawBackTime := DrawBackTime;
//  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  EditButtonSetDrawFaceTime(edbtWhenHotEh);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  EditButtonSetDrawFaceTime(edbtNeverEh);
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  EditButtonSetDrawFaceTime(edbtAlwaysEh);
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  bStyle: TEditButtonStyleEh;
begin
  for bStyle := Low(TEditButtonStyleEh) to High(TEditButtonStyleEh) do
  begin
    if DBEditEh1.EditButtons[0].Style = High(TEditButtonStyleEh) then
    begin
      DBEditEh1.EditButtons[0].Style := Low(TEditButtonStyleEh);
      Break;
    end else if DBEditEh1.EditButtons[0].Style = bStyle then
    begin
      DBEditEh1.EditButtons[0].Style := Succ(DBEditEh1.EditButtons[0].Style);
      Break;
    end;
  end;
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
//  SetEhLibDebugDraw(True);
//  DBGridEhDebugDraw := True;
//  DefFontData.Height := 20;
end.
