unit FrameThree;

{$I EhLib.Inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
{$IFDEF EH_LIB_6} Variants, {$ENDIF}
  Themes,
  Dialogs, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, ExtCtrls,
  GridsEh, DBGridEh, MemTableDataEh, Db, ADODB, DataDriverEh,
  ADODataDriverEh, MemTableEh, StdCtrls;

type
  TfrFrameThree = class(TFrame)
    DBGridEh1: TDBGridEh;
    Panel1: TPanel;
    DataSource1: TDataSource;
    mtQuery1: TMemTableEh;
    ddrData1: TADODataDriverEh;
    qrVendors: TMemTableEh;
    ddrVendors: TADODataDriverEh;
    PaintBox1: TPaintBox;
    Label1: TLabel;
    mtQuery1VendorNo: TAutoIncField;
    mtQuery1VendorName: TWideStringField;
    mtQuery1Address1: TWideStringField;
    mtQuery1Address2: TWideStringField;
    mtQuery1City: TWideStringField;
    mtQuery1State: TWideStringField;
    mtQuery1Zip: TWideStringField;
    mtQuery1Country: TWideStringField;
    mtQuery1Phone: TWideStringField;
    mtQuery1FAX: TWideStringField;
    mtQuery1Preferred: TBooleanField;
    Label2: TLabel;
    procedure PaintBox1Paint(Sender: TObject);
    procedure DBGridEh1Columns2GetCellParams(Sender: TObject;
      EditMode: Boolean; Params: TColCellParamsEh);
    procedure DBGridEh1Columns2AdvDrawDataCell(Sender: TCustomDBGridEh;
      Cell, AreaCell: TGridCoord; Column: TColumnEh; const ARect: TRect;
      var Params: TColCellParamsEh; var Processed: Boolean);
  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    { Public declarations }
  end;

implementation

uses Unit1;

{$R *.dfm}

{ TfrFrameThree }

constructor TfrFrameThree.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Panel1.Height := 36;
  DBGridEh1.TitleParams.SecondColor := ApproximateColor(clBtnFace, clWindow, 170);

  DBGridEh1.FooterParams.Font.Style := [fsBold];
end;

procedure TfrFrameThree.PaintBox1Paint(Sender: TObject);
begin
  Form1.FillFrameTopPanel(PaintBox1.Canvas, Rect(0, 0, PaintBox1.Width, PaintBox1.Height));
end;

procedure TfrFrameThree.DBGridEh1Columns2GetCellParams(Sender: TObject;
  EditMode: Boolean; Params: TColCellParamsEh);
begin
//  if EditMode then
//    Params.CellRect.Left := Params.CellRect.Left + (Params.CellRect.Bottom-Params.CellRect.Top) + 3;
end;

procedure TfrFrameThree.DBGridEh1Columns2AdvDrawDataCell(
  Sender: TCustomDBGridEh; Cell, AreaCell: TGridCoord; Column: TColumnEh;
  const ARect: TRect; var Params: TColCellParamsEh;
  var Processed: Boolean);
var
  OldBrushColor, OldPenColor: TColor;
  TextRect: TRect;
  NewRect: TRect;
begin
  TextRect := ARect;
  TextRect.Left := TextRect.Left + (ARect.Bottom-ARect.Top) + 3;

  if mtQuery1State.AsString = 'CA' then
    Sender.Canvas.Font.Style := [fsBold];

  Sender.DefaultDrawColumnDataCell(Cell, AreaCell, Column, TextRect, Params);

  NewRect := ARect;
  NewRect.Right := TextRect.Left;
  Sender.Canvas.FillRect(NewRect);
  OldPenColor := Sender.Canvas.Pen.Color;
  OldBrushColor := Sender.Canvas.Brush.Color;
  Sender.Canvas.Pen.Color := clBtnShadow;
  Sender.Canvas.Brush.Color := clBtnFace;
  Sender.Canvas.Ellipse(Rect(ARect.Left+1, ARect.Top+1,
    ARect.Left + (ARect.Bottom-ARect.Top)-2, ARect.Bottom-1));
  Sender.Canvas.Pen.Color := OldPenColor;
  Sender.Canvas.Brush.Color := OldBrushColor;
  Processed := True;

{begin
  Sender.DefaultDrawColumnDataCell(Cell, AreaCell, Column, ARect, Params);

  DrawProgressBarEh(DataModule1.mtTable1.FieldByName('ItemsTotal').AsFloat, 0, 50000,
    Sender.Canvas, ARect, clSkyBlue, cl3DDkShadow, clNone);
  Processed := True;
end;}

end;

end.
