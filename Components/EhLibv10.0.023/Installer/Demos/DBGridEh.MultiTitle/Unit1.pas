unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MemTableDataEh, Db, DBGridEhGrouping, ADODB, GridsEh, DBGridEh,
  XPMan,
  MemTableEh, ToolCtrlsEh, DBGridEhToolCtrls, StdCtrls, Mask, DBCtrlsEh,
  DBLookupEh;

type
  TForm1 = class(TForm)
    MemTableEh1: TMemTableEh;
    DBGridEh1: TDBGridEh;
    DataSource1: TDataSource;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  if not DBGridEh1.TitleParams.MultiTitle then
  begin
    DBGridEh1.Columns[0].Title.Caption := 'Master Title|Name';
    DBGridEh1.Columns[1].Title.Caption := 'Master Title|Capital';
    DBGridEh1.TitleParams.MultiTitle := True;
    Button1.Caption := 'MultiTitle (Yes)';
  end else
  begin
    DBGridEh1.Columns[0].Title.Caption := 'Name';
    DBGridEh1.Columns[1].Title.Caption := 'Capital';
    DBGridEh1.TitleParams.MultiTitle := False;
    Button1.Caption := 'MultiTitle (No)';
  end;
end;

initialization
  DefFontData.Name := 'Tahoma';
end.
