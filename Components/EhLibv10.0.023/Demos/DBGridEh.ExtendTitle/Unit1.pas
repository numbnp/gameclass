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
  DBLookupEh, DynVarsEh, DBAxisGridsEh, EhLibVCL;

type
  TForm1 = class(TForm)
    MemTableEh1: TMemTableEh;
    DBGridEh1: TDBGridEh;
    DataSource1: TDataSource;
    ADOTable1: TADOTable;
    Button3: TButton;
    Button4: TButton;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure DBGridEh1GetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure MemTableEh1BeforeScroll(DataSet: TDataSet);
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
var
  NewVisible: Boolean;
  i: Integer;
begin
//  i := DBGridEh1.Col;
//  i := DBGridEh1.Row;
//  DBGridEh1.Selection

  if DBGridEh1.Columns[0].Visible then
    NewVisible := False
  else
    NewVisible := True;

  for i := 0 to DBGridEh1.Columns.Count-2 do
    DBGridEh1.Columns[i].Visible := NewVisible;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if DBGridEhDebugDraw
    then SetEhLibDebugDraw(False)
    else SetEhLibDebugDraw(True);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  if DBGridEh1.GridLineParams.HorzEmptySpaceStyle = deshNonEh then
  begin
    DBGridEh1.GridLineParams.HorzEmptySpaceStyle := deshExtendTitleWideSpaceEh;
    Button3.Caption := 'HorzEmptySpaceStyle = deshExtendTitleWideSpaceEh'
  end
  else if DBGridEh1.GridLineParams.HorzEmptySpaceStyle = deshExtendTitleWideSpaceEh then
  begin
    DBGridEh1.GridLineParams.HorzEmptySpaceStyle := deshExtendGridWideSpaceEh;
    Button3.Caption := 'HorzEmptySpaceStyle = deshExtendGridWideSpaceEh'
  end
  else
  begin
    DBGridEh1.GridLineParams.HorzEmptySpaceStyle := deshNonEh;
    Button3.Caption := 'HorzEmptySpaceStyle = deshNonEh'
  end;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  if dgRowSelect in DBGridEh1.Options then
    DBGridEh1.Options := DBGridEh1.Options - [dgRowSelect]
  else
    DBGridEh1.Options := DBGridEh1.Options + [dgRowSelect];
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  DBGridEh1.GridLineParams.HorzEmptySpaceStyle := deshExtendTitleWideSpaceEh;
end;

procedure TForm1.DBGridEh1GetCellParams(Sender: TObject; Column: TColumnEh;
  AFont: TFont; var Background: TColor; State: TGridDrawState);
begin
//  if MemTableEh1.FieldByName('Population').AsFloat > 21600000 then
//    Background := $00E6F0E6;
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F11 then
    ShowObjectInspectorForm(ActiveControl, Rect(Left+Width+10, Top, Left+Width+10+300, Top+Height));
end;

procedure TForm1.MemTableEh1BeforeScroll(DataSet: TDataSet);
begin
//  Abort;
end;

initialization
//  DBGridEhDefaultStyle.IsDrawFocusRect := False;
  DefFontData.Name := 'Tahoma';
//  SetEhLibDebugDraw(True);
//  DBGridEhDebugDraw := True;
//  DefFontData.Height := 20;
end.
