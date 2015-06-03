unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MemTableDataEh, Db, DBGridEhGrouping, ADODB, GridsEh, DBGridEh,
  MemTableEh, ToolCtrlsEh, DBGridEhToolCtrls, XPMan, EhLibMTE;

type
  TForm1 = class(TForm)
    MemTableEh1: TMemTableEh;
    DataSource1: TDataSource;
    ScrollBox1: TScrollBox;
    DBGridEh1: TDBGridEh;
    DBGridEh2: TDBGridEh;
    DBGridEh3: TDBGridEh;
    DBGridEh4: TDBGridEh;
    DBGridEh5: TDBGridEh;
    DBGridEh6: TDBGridEh;
    DBGridEh7: TDBGridEh;
    DBGridEh8: TDBGridEh;
    procedure DBGridEh1SortMarkingChanged(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.DBGridEh1SortMarkingChanged(Sender: TObject);
var
  i: Integer;
  Grid: TDBGridEh;
begin
  Grid := TDBGridEh(Sender);
  Grid.DefaultApplySorting;
  for i := 0 to Grid.Columns.Count - 1 do
  begin
    if Grid.Columns[i].Title.SortMarker <> smNoneEh then
      Grid.Columns[i].Color := $00FBF7F2
    else
      Grid.Columns[i].Color := Grid.Color;
  end;
end;

initialization
//  DBGridEhDefaultStyle.IsDrawFocusRect := False;
  DefFontData.Name := 'Tahoma';
//  DBGridEhDebugDraw := True;
//  DefFontData.Height := 20;
end.

