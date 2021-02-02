unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MemTableDataEh, Db, DBGridEhGrouping, ADODB, GridsEh, DBGridEh,
  MemTableEh, ToolCtrlsEh, DBGridEhToolCtrls, StdCtrls, Mask, DBCtrlsEh,
  ObjectInspectorEh,
  DBLookupEh, DynVarsEh, DBAxisGridsEh, EhLibVCL;

type
  TForm1 = class(TForm)
    MemTableEh1: TMemTableEh;
    DBGridEh1: TDBGridEh;
    DataSource1: TDataSource;
    ADOTable1: TADOTable;
    DBMemoEh1: TDBMemoEh;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGridEh1SelectionChanged(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    function CalcSelectedRows: Double;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.DBGridEh1SelectionChanged(Sender: TObject);
begin
  if (DBGridEh1.SelectedRows.Count = 0) then
  begin
    DBGridEh1.FieldColumns['Area'].Footer.ValueType := fvtSum;
  end else
  begin
    DBGridEh1.FieldColumns['Area'].Footer.ValueType := fvtStaticText;
    DBGridEh1.FieldColumns['Area'].Footer.Value := FloatToStr(CalcSelectedRows);
  end;
end;

function TForm1.CalcSelectedRows: Double;
var
  I: Integer;
  MemRec: TMemoryRecordEh;
begin
  Result := 0;
  for I := 0 to DBGridEh1.SelectedRows.Count - 1 do
  begin
    MemRec := MemTableEh1.BookmarkToRec(DBGridEh1.SelectedRows[i]);
    MemTableEh1.InstantReadEnter(MemRec, -1);
    Result := Result + MemTableEh1.FieldByName('Area').AsFloat;
    MemTableEh1.InstantReadLeave;
  end;
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F11 then
    ShowObjectInspectorForm(ActiveControl, Rect(Left+Width+10, Top, Left+Width+10+300, Top+Height));
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Caption := Caption + ' ' + EhLibVerInfo + ' ' + EhLibBuildInfo;
end;

initialization
//  DBGridEhDefaultStyle.IsDrawFocusRect := False;
  DefFontData.Name := 'Tahoma';
//  DBGridEhDebugDraw := True;
//  DefFontData.Height := 20;
end.
