unit FrameCellDataIsLink;

{$MODE Delphi}

//{$I EhLib.Inc}

interface

uses
  Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Themes, Types,
  Dialogs, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, GridsEh,
  DBGridsEh, LCLIntf,
  MemTableDataEh, Db, DataDriverEh,
  MemTableEh, StdCtrls, ExtCtrls, DBCtrls, DBAxisGridsEh, DBVertGridsEh,
  DynVarsEh, ImgList, ComCtrls, ToolWin;

type

  { TfrCellDataIsLink }

  TfrCellDataIsLink = class(TFrame)
    Panel1: TPanel;
    PaintBox1: TPaintBox;
    Label1: TLabel;
    Panel2: TPanel;
    DBGridEh1: TDBGridEh;
    DBVertGridEh1: TDBVertGridEh;
    MemTableEh1: TMemTableEh;
    DataSource1: TDataSource;
    ImageList1: TImageList;
    ImageList2: TImageList;
    Splitter1: TSplitter;
    procedure PaintBox1Paint(Sender: TObject);
    procedure DBGridEh1Columns0GetCellParams(Sender: TObject;
      EditMode: Boolean; Params: TColCellParamsEh);
    procedure DBGridEh1Columns0CellDataLinkClick(Grid: TCustomDBGridEh;
      Column: TColumnEh);
    procedure DBGridEh1Columns1GetCellParams(Sender: TObject;
      EditMode: Boolean; Params: TColCellParamsEh);
    procedure DBGridEh1Columns1CellDataLinkClick(Grid: TCustomDBGridEh;
      Column: TColumnEh);
    procedure DBGridEh1Columns2GetCellParams(Sender: TObject;
      EditMode: Boolean; Params: TColCellParamsEh);
    procedure DBGridEh1Columns2CellDataLinkClick(Grid: TCustomDBGridEh;
      Column: TColumnEh);
    procedure DBGridEh1Columns3CellDataLinkClick(Grid: TCustomDBGridEh;
      Column: TColumnEh);
    procedure DBGridEh1Columns4GetCellParams(Sender: TObject;
      EditMode: Boolean; Params: TColCellParamsEh);
    procedure DBGridEh1Columns4CellDataLinkClick(Grid: TCustomDBGridEh;
      Column: TColumnEh);
    procedure DBVertGridEh1Rows0GetCellParams(Sender: TObject;
      EditMode: Boolean; Params: TRowCellParamsEh);
    procedure DBVertGridEh1Rows0CellDataLinkClick(
      Grid: TCustomDBVertGridEh; Row: TFieldRowEh);
    procedure DBVertGridEh1Rows1CellDataLinkClick(
      Grid: TCustomDBVertGridEh; Row: TFieldRowEh);
    procedure DBVertGridEh1Rows2CellDataLinkClick(
      Grid: TCustomDBVertGridEh; Row: TFieldRowEh);
    procedure DBVertGridEh1Rows7CellDataLinkClick(
      Grid: TCustomDBVertGridEh; Row: TFieldRowEh);
    procedure DBVertGridEh1Rows2GetCellParams(Sender: TObject;
      EditMode: Boolean; Params: TRowCellParamsEh);
  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    procedure CellLinkClick(Grid: TCustomDBGridEh; Column: TColumnEh);
    procedure VertCellLinkClick(Grid: TCustomDBVertGridEh; Row: TFieldRowEh);
    procedure EditDialog;
  end;

implementation

uses Unit1, UnitEditDialogForCellDataIsLink;

{$R *.lfm}

{ TfrVertGrid }

constructor TfrCellDataIsLink.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Align := alClient;
  Panel1.DoubleBuffered := True;

  Label1.Font := Form1.FrameTitleFont;
  Label1.Left := Form1.FrameTitlePos.X;
  Label1.Top := Form1.FrameTitlePos.Y;
end;

procedure TfrCellDataIsLink.PaintBox1Paint(Sender: TObject);
begin
  Form1.FillFrameTopPanel(PaintBox1.Canvas, Rect(0, 0, PaintBox1.Width, PaintBox1.Height));
end;

procedure TfrCellDataIsLink.DBGridEh1Columns0GetCellParams(Sender: TObject;
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

procedure TfrCellDataIsLink.CellLinkClick(Grid: TCustomDBGridEh;
  Column: TColumnEh);
begin
  if Column.FieldName = 'Capital'then
    OpenURL(MemTableEh1.FieldByName('CapitalWWWLink').AsString)
  else if Column.FieldName = 'WikiLinkShow' then
    OpenURL(MemTableEh1.FieldByName('WikiLinkData').AsString)
  else
  begin
    EditDialog;
  end;
end;

procedure TfrCellDataIsLink.DBGridEh1Columns0CellDataLinkClick(
  Grid: TCustomDBGridEh; Column: TColumnEh);
begin
  CellLinkClick(Grid, Column);
end;

procedure TfrCellDataIsLink.DBGridEh1Columns1GetCellParams(Sender: TObject;
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

procedure TfrCellDataIsLink.DBGridEh1Columns1CellDataLinkClick(
  Grid: TCustomDBGridEh; Column: TColumnEh);
begin
  CellLinkClick(Grid, Column);
end;

procedure TfrCellDataIsLink.DBGridEh1Columns2GetCellParams(Sender: TObject;
  EditMode: Boolean; Params: TColCellParamsEh);
begin
  Params.ImageIndex := MemTableEh1.FieldByName('FlagIndex').AsInteger;
  Params.TextIsLink := False;
  Params.ImageIsLink := True;
end;

procedure TfrCellDataIsLink.DBGridEh1Columns2CellDataLinkClick(
  Grid: TCustomDBGridEh; Column: TColumnEh);
begin
  CellLinkClick(Grid, Column);
end;

procedure TfrCellDataIsLink.DBGridEh1Columns3CellDataLinkClick(
  Grid: TCustomDBGridEh; Column: TColumnEh);
begin
  CellLinkClick(Grid, Column);
end;

procedure TfrCellDataIsLink.DBGridEh1Columns4GetCellParams(Sender: TObject;
  EditMode: Boolean; Params: TColCellParamsEh);
begin
  if MemTableEh1.FieldByName('CapitalWWWLink').AsString <> '' then
  begin
    Params.TextIsLink := True;
    Params.Font.Color := clNavy;
    Params.Font.Style := Params.Font.Style + [fsUnderline];
  end;
end;

procedure TfrCellDataIsLink.DBGridEh1Columns4CellDataLinkClick(
  Grid: TCustomDBGridEh; Column: TColumnEh);
begin
  CellLinkClick(Grid, Column);
end;

procedure TfrCellDataIsLink.DBVertGridEh1Rows0GetCellParams(
  Sender: TObject; EditMode: Boolean; Params: TRowCellParamsEh);
begin
  Params.Text := 'Edit';
  Params.ImageIndex := 0;
end;

procedure TfrCellDataIsLink.VertCellLinkClick(Grid: TCustomDBVertGridEh;
  Row: TFieldRowEh);
begin
  if Row.FieldName = 'WikiLinkShow' then
    OpenURL(MemTableEh1.FieldByName('WikiLinkData').AsString)
  else
  begin
    EditDialog;
  end;
end;

procedure TfrCellDataIsLink.DBVertGridEh1Rows0CellDataLinkClick(
  Grid: TCustomDBVertGridEh; Row: TFieldRowEh);
begin
  VertCellLinkClick(Grid, Row);
end;

procedure TfrCellDataIsLink.DBVertGridEh1Rows1CellDataLinkClick(
  Grid: TCustomDBVertGridEh; Row: TFieldRowEh);
begin
  VertCellLinkClick(Grid, Row);
end;

procedure TfrCellDataIsLink.DBVertGridEh1Rows2CellDataLinkClick(
  Grid: TCustomDBVertGridEh; Row: TFieldRowEh);
begin
  VertCellLinkClick(Grid, Row);
end;

procedure TfrCellDataIsLink.DBVertGridEh1Rows7CellDataLinkClick(
  Grid: TCustomDBVertGridEh; Row: TFieldRowEh);
begin
  VertCellLinkClick(Grid, Row);
end;

procedure TfrCellDataIsLink.DBVertGridEh1Rows2GetCellParams(
  Sender: TObject; EditMode: Boolean; Params: TRowCellParamsEh);
begin
  Params.ImageIndex := MemTableEh1.FieldByName('FlagIndex').AsInteger;
  Params.TextIsLink := False;
  Params.ImageIsLink := True;
end;

procedure TfrCellDataIsLink.EditDialog;
begin
  if FormEditDialogForCellDataIsLink = nil then
    FormEditDialogForCellDataIsLink := TFormEditDialogForCellDataIsLink.Create(Application);
  FormEditDialogForCellDataIsLink.DBVertGridEh1.DataSource := DataSource1;
  FormEditDialogForCellDataIsLink.ShowModal;
end;

end.
