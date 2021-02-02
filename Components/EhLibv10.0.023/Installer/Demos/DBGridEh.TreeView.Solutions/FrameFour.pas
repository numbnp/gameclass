unit FrameFour;

{$I EhLib.Inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
{$IFDEF EH_LIB_6} Variants, {$ENDIF}
  Themes,
  Dialogs, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, ExtCtrls,
  GridsEh, DBGridEh, MemTableDataEh, Db, ADODB, DataDriverEh,
  ADODataDriverEh, MemTableEh, StdCtrls, DBAxisGridsEh, ImgList;

type
  TfrFrameFour = class(TFrame)
    Panel1: TPanel;
    PaintBox1: TPaintBox;
    Label1: TLabel;
    ADODataDriverEh1: TADODataDriverEh;
    DataSource1: TDataSource;
    MemTableEh1: TMemTableEh;
    DBGridEh1: TDBGridEh;
    bReopen: TButton;
    ImageList1: TImageList;
    Memo1: TMemo;
    procedure PaintBox1Paint(Sender: TObject);
    procedure bReopenClick(Sender: TObject);
    procedure DBGridEh1Columns0GetCellParams(Sender: TObject;
      EditMode: Boolean; Params: TColCellParamsEh);
    procedure DBGridEh1CellMouseClick(Grid: TCustomGridEh;
      Cell: TGridCoord; Button: TMouseButton; Shift: TShiftState; X,
      Y: Integer; var Processed: Boolean);
  private
  protected
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses Unit1;

{$R *.dfm}

{ TfrFrameOne }

constructor TfrFrameFour.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  DBGridEh1.FooterParams.Font.Style := [fsBold];
  Memo1.WordWrap := True;
  bReopenClick(nil);
  MemTableEh1.TreeList.Active := True;
end;

procedure TfrFrameFour.PaintBox1Paint(Sender: TObject);
begin
  Form1.FillFrameTopPanel(PaintBox1.Canvas, Rect(0, 0, PaintBox1.Width, PaintBox1.Height));
end;

procedure TfrFrameFour.bReopenClick(Sender: TObject);
begin
  MemTableEh1.Close;
  MemTableEh1.Open;
end;

procedure TfrFrameFour.DBGridEh1Columns0GetCellParams(Sender: TObject;
  EditMode: Boolean; Params: TColCellParamsEh);
begin
  Params.ImageIndex := MemTableEh1.FieldByName('ImageIndex').AsInteger;
end;

procedure TfrFrameFour.DBGridEh1CellMouseClick(Grid: TCustomGridEh;
  Cell: TGridCoord; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer; var Processed: Boolean);
var
  TreeAreaWidth: Integer;
begin
  if not (ssDouble in Shift) and (Cell.X = 1) and (Cell.Y = TDBGridEh(Grid).Row) then
  begin
    TreeAreaWidth := MemTableEh1.TreeNodeLevel * 18;
    if (X > TreeAreaWidth) and (X < TreeAreaWidth + ImageList1.Width) then
    begin
      MemTableEh1.Edit;
      if MemTableEh1.FieldByName('ImageIndex').AsInteger = 0
        then MemTableEh1.FieldByName('ImageIndex').AsInteger := 1
        else MemTableEh1.FieldByName('ImageIndex').AsInteger := 0;
      MemTableEh1.Post;
    end;
  end;
end;

end.
