unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MemTableDataEh, Db, DBGridEhGrouping, ADODB, GridsEh, DBGridEh,
  MemTableEh, ToolCtrlsEh, DBGridEhToolCtrls, StdCtrls, Mask, DBCtrlsEh,
  ObjectInspectorEh,
  ShellAPI,
  DBLookupEh, DynVarsEh, DBAxisGridsEh, EhLibVCL,
  DBVertGridsEh, ImgList;

type
  TForm1 = class(TForm)
    MemTableEh1: TMemTableEh;
    DBGridEh1: TDBGridEh;
    DataSource1: TDataSource;
    ADOTable1: TADOTable;
    ImageList1: TImageList;
    DBVertGridEh1: TDBVertGridEh;
    ImageList2: TImageList;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGridEh1Columns1GetCellParams(Sender: TObject; EditMode: Boolean;
      Params: TColCellParamsEh);
    procedure FormCreate(Sender: TObject);
    procedure DBGridEh1CellClick(Column: TColumnEh);
    procedure DBVertGridEh1Rows0GetCellParams(Sender: TObject;
      EditMode: Boolean; Params: TRowCellParamsEh);
    procedure DBGridEh1Columns4GetCellParams(Sender: TObject; EditMode: Boolean;
      Params: TColCellParamsEh);
    procedure DBGridEh1Columns2GetCellParams(Sender: TObject; EditMode: Boolean;
      Params: TColCellParamsEh);
    procedure DBVertGridEh1Rows2GetCellParams(Sender: TObject;
      EditMode: Boolean; Params: TRowCellParamsEh);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CellLinkClick(Grid: TCustomDBGridEh; Column: TColumnEh);
    procedure VertCellLinkClick(Grid: TCustomDBVertGridEh; Row: TFieldRowEh);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses Unit2;

procedure TForm1.CellLinkClick(Grid: TCustomDBGridEh; Column: TColumnEh);
begin
  if Column.FieldName = 'Capital'then
    ShellExecute(Application.Handle, 'Open',
      PChar(MemTableEh1.FieldByName('CapitalWWWLink').AsString), nil, nil, SW_SHOWNORMAL)
  else if Column.FieldName = 'WikiLinkShow' then
    ShellExecute(Application.Handle, 'Open',
      PChar(MemTableEh1.FieldByName('WikiLinkData').AsString), nil, nil, SW_SHOWNORMAL)
  else
  begin
    Form2.DBVertGridEh1.DataSource := DataSource1;
    Form2.ShowModal;
  end;
end;

procedure TForm1.VertCellLinkClick(Grid: TCustomDBVertGridEh; Row: TFieldRowEh);
begin
  if Row.FieldName = 'WikiLinkShow' then
    ShellExecute(Application.Handle, 'Open',
      PChar(MemTableEh1.FieldByName('WikiLinkData').AsString), nil, nil, SW_SHOWNORMAL)
  else
  begin
    Form2.DBVertGridEh1.DataSource := DataSource1;
    Form2.ShowModal;
  end;
end;

procedure TForm1.DBGridEh1CellClick(Column: TColumnEh);
begin
//  ShowMessage('DBGridEh1CellClick');
{  if (Column = nil) or (Column.FieldName = 'Name') then
  begin
    Form2.DBVertGridEh1.DataSource := DataSource1;
    Form2.ShowModal;
//    Form2.Show;
  end;}
end;

procedure TForm1.DBGridEh1Columns1GetCellParams(Sender: TObject;
  EditMode: Boolean; Params: TColCellParamsEh);
begin
  if TColumnEh(Sender).FieldName = '' then
    Params.Text := 'Edit';
  Params.ImageIndex := 0;
  if MemTableEh1.FieldByName('Continent').AsString = 'North America' then
  begin
    Params.TextIsLink := False;
    Params.Font.Color := clGrayText;
  end;
end;

procedure TForm1.DBGridEh1Columns2GetCellParams(Sender: TObject;
  EditMode: Boolean; Params: TColCellParamsEh);
begin
  Params.ImageIndex := MemTableEh1.FieldByName('FlagIndex').AsInteger;
  Params.TextIsLink := False;
  Params.ImageIsLink := True;
//  Params.Font.Color := clGrayText;
end;

procedure TForm1.DBVertGridEh1Rows2GetCellParams(Sender: TObject;
  EditMode: Boolean; Params: TRowCellParamsEh);
begin
  Params.ImageIndex := MemTableEh1.FieldByName('FlagIndex').AsInteger;
  Params.TextIsLink := False;
  Params.ImageIsLink := True;
end;

procedure TForm1.DBGridEh1Columns4GetCellParams(Sender: TObject;
  EditMode: Boolean; Params: TColCellParamsEh);
begin
  if MemTableEh1.FieldByName('CapitalWWWLink').AsString <> '' then
  begin
    Params.TextIsLink := True;
    Params.Font.Color := clNavy;
    Params.Font.Style := Params.Font.Style + [fsUnderline];
  end;
end;

procedure TForm1.DBVertGridEh1Rows0GetCellParams(Sender: TObject;
  EditMode: Boolean; Params: TRowCellParamsEh);
begin
  Params.Text := 'Edit';
  Params.ImageIndex := 0;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  DBGridEh1.Columns[0].CellDataIsLink := True;
  DBGridEh1.Columns[0].OnCellDataLinkClick := CellLinkClick;

  DBGridEh1.Columns[1].CellDataIsLink := True;
  DBGridEh1.Columns[1].OnCellDataLinkClick := CellLinkClick;

  DBGridEh1.Columns[2].CellDataIsLink := True;
  DBGridEh1.Columns[2].OnCellDataLinkClick := CellLinkClick;

  DBGridEh1.FieldColumns['WikiLinkShow'].CellDataIsLink := True;
  DBGridEh1.FieldColumns['WikiLinkShow'].OnCellDataLinkClick := CellLinkClick;

//  DBGridEh1.FieldColumns['Capital'].CellDataIsLink := True;
  DBGridEh1.FieldColumns['Capital'].OnCellDataLinkClick := CellLinkClick;

  DBVertGridEh1.Rows[0].CellDataIsLink := True;
  DBVertGridEh1.Rows[0].OnCellDataLinkClick := VertCellLinkClick;

  DBVertGridEh1.Rows[1].CellDataIsLink := True;
  DBVertGridEh1.Rows[1].OnCellDataLinkClick := VertCellLinkClick;

  DBVertGridEh1.Rows[2].CellDataIsLink := True;
  DBVertGridEh1.Rows[2].OnCellDataLinkClick := VertCellLinkClick;

  DBVertGridEh1.FieldRows['WikiLinkShow'].CellDataIsLink := True;
  DBVertGridEh1.FieldRows['WikiLinkShow'].OnCellDataLinkClick := VertCellLinkClick;
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F11 then
    ShowObjectInspectorForm(ActiveControl, Rect(Left+Width+10, Top, Left+Width+10+300, Top+Height));
end;

initialization
  DefFontData.Name := 'Tahoma';
end.
