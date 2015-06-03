unit FrameEditControls;

{$MODE Delphi}

//{$I EhLib.Inc}

interface

uses
  LCLIntf, LCLType, LMessages,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Themes,
  {$IFDEF EH_LIB_6} Types, {$ENDIF}
  {$IFDEF EH_LIB_16} System.UITypes, {$ENDIF}
  Dialogs, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, ExtCtrls,
  StdCtrls, DBCtrlsEh, DBCtrls, DBLookupEh, GridsEh, MaskEdit, MemTableDataEh, Db,
  MemTableEh, DataDriverEh, ImgList, DBAxisGridsEh, DBGridsEh;

type

  { TfrEditControls }

  TfrEditControls = class(TFrame)
    DBComboBoxEh1: TDBComboBoxEh;
    DBNumberEditEh1: TDBNumberEditEh;
    DBGridEh6: TDBGridEh;
    DBLookupComboboxEh3: TDBLookupComboboxEh;
    Label24: TLabel;
    Label23: TLabel;
    DBDateTimeEditEh1: TDBDateTimeEditEh;
    DBEditEh1: TDBEditEh;
    DBNavigator1: TDBNavigator;
    DBComboBoxEh2: TDBComboBoxEh;
    DBCheckBoxEh2: TDBCheckBoxEh;
    DBCheckBoxEh1: TDBCheckBoxEh;
    DBDateTimeEditEh2: TDBDateTimeEditEh;
    DBLookupComboboxEh4: TDBLookupComboboxEh;
    DBEditEh2: TDBEditEh;
    DBNumberEditEh2: TDBNumberEditEh;
    Label22: TLabel;
    Label12: TLabel;
    Label6: TLabel;
    Label14: TLabel;
    Label13: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    Label19: TLabel;
    Label18: TLabel;
    Label21: TLabel;
    Label20: TLabel;
    Label16: TLabel;
    Label15: TLabel;
    Label17: TLabel;
    Bevel1: TBevel;
    DataSource2: TDataSource;
    RowDetailData: TRowDetailPanelControlEh;
    SQLDataDriverEh1: TSQLDataDriverEh;
    mtTable1: TMemTableEh;
    dstCustomer: TDataSource;
    MemTableEh1: TMemTableEh;
    SQLDataDriverEh2: TSQLDataDriverEh;
    ilPaymentType: TImageList;
    ilYesNo: TImageList;
    Panel1: TPanel;
    PaintBox1: TPaintBox;
    Label1: TLabel;
    procedure DBComboBoxEh1GetItemImageIndex(Sender: TObject;
      ItemIndex: Integer; var ImageIndex: Integer);
    procedure DBGridEh6Columns0AdvDrawDataCell(Sender: TCustomDBGridEh; Cell,
      AreaCell: TGridCoord; Column: TColumnEh; const ARect: TRect;
      var Params: TColCellParamsEh; var Processed: Boolean);
    procedure DBGridEh6Columns0DataHintShow(Sender: TCustomDBGridEh;
      CursorPos: TPoint; Cell: TGridCoord; InCellCursorPos: TPoint;
      Column: TColumnEh; var Params: TDBGridEhDataHintParams;
      var Processed: Boolean);
    procedure DBGridEh6Columns0GetCellParams(Sender: TObject; EditMode: Boolean;
      Params: TColCellParamsEh);
    procedure DBGridEh6Columns3AdvDrawDataCell(Sender: TCustomDBGridEh; Cell,
      AreaCell: TGridCoord; Column: TColumnEh; const ARect: TRect;
      var Params: TColCellParamsEh; var Processed: Boolean);
    procedure Button1Click(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    procedure UpdateLabels;
  end;

implementation

uses Unit1;

{$R *.lfm}

constructor TfrEditControls.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Align := alClient;
  Panel1.Height := 36;
  Panel1.DoubleBuffered := True;
  mtTable1.Open;
  MemTableEh1.Open;


//  if Form1.PixelsPerInch <> 96 then
//    ScaleBy(Form1.PixelsPerInch, 96);
end;

procedure TfrEditControls.DBComboBoxEh1GetItemImageIndex(Sender: TObject;
  ItemIndex: Integer; var ImageIndex: Integer);
begin
  ImageIndex := -1;
  case ItemIndex of
   2: ImageIndex := 1;
   5: ImageIndex := 3;
   6: ImageIndex := 0;
   4: ImageIndex := 2;
  end;
end;

procedure TfrEditControls.DBGridEh6Columns0AdvDrawDataCell(
  Sender: TCustomDBGridEh; Cell, AreaCell: TGridCoord; Column: TColumnEh;
  const ARect: TRect; var Params: TColCellParamsEh; var Processed: Boolean);
var
  OldBrushColor, OldPenColor: TColor;
begin
  Sender.DefaultDrawColumnDataCell(Cell, AreaCell, Column, ARect, Params);
  OldPenColor := Sender.Canvas.Pen.Color;
  OldBrushColor := Sender.Canvas.Brush.Color;
  Sender.Canvas.Pen.Color := clBtnShadow;
  Sender.Canvas.Brush.Color := clBtnFace;
  Sender.Canvas.Ellipse(Rect(ARect.Left+1, ARect.Top+1,
    ARect.Left + (ARect.Bottom-ARect.Top)-2, ARect.Bottom-1));
  Sender.Canvas.Pen.Color := OldPenColor;
  Sender.Canvas.Brush.Color := OldBrushColor;
  Processed := True;
end;

procedure TfrEditControls.DBGridEh6Columns0DataHintShow(Sender: TCustomDBGridEh;
  CursorPos: TPoint; Cell: TGridCoord; InCellCursorPos: TPoint;
  Column: TColumnEh; var Params: TDBGridEhDataHintParams;
  var Processed: Boolean);
begin
  if InCellCursorPos.X <= (Params.CursorRect.Bottom-Params.CursorRect.Top) then
  begin
    Params.HintStr := 'Example shows how to paint custom data and show hint data in the cell.' + #13 +
     'The CustNo is ' + Column.Field.AsString + '.';
    Params.CursorRect.Right := Params.CursorRect.Left + (Params.CursorRect.Bottom-Params.CursorRect.Top);
    Params.HintFont.Size := 12;
    Params.HintColor := TColor($F0CAA6);
    Params.HideTimeout := 5000;
  end else
  begin
    Params.CursorRect.Left := Params.CursorRect.Left +
      (Params.CursorRect.Bottom-Params.CursorRect.Top);
    Sender.DefaultFillDataHintShowInfo(CursorPos, Cell, Column, Params);
  end;
  Processed := True;
end;

procedure TfrEditControls.DBGridEh6Columns0GetCellParams(Sender: TObject;
  EditMode: Boolean; Params: TColCellParamsEh);
begin
  Params.TextEditing := False;
end;

procedure TfrEditControls.DBGridEh6Columns3AdvDrawDataCell(
  Sender: TCustomDBGridEh; Cell, AreaCell: TGridCoord; Column: TColumnEh;
  const ARect: TRect; var Params: TColCellParamsEh; var Processed: Boolean);
begin
  Sender.DefaultDrawColumnDataCell(Cell, AreaCell, Column, ARect, Params);

  DrawProgressBarEh(mtTable1.FieldByName('ItemsTotal').AsFloat, 0, 50000,
    Sender.Canvas, ARect, clSkyBlue, cl3DDkShadow, clNone);
  Processed := True;
end;

procedure TfrEditControls.Button1Click(Sender: TObject);
begin
  UpdateLabels;
end;

procedure TfrEditControls.UpdateLabels;
var
  i: Integer;
begin
  for i := 0 to ControlCount-1 do
  begin
    if Controls[i] is TLabel then
    begin
      TLabel(Controls[i]).Visible := False;
      TLabel(Controls[i]).Visible := True;
    end;
  end;
end;

procedure TfrEditControls.PaintBox1Paint(Sender: TObject);
begin
  Form1.FillFrameTopPanel(PaintBox1.Canvas, Rect(0, 0, PaintBox1.Width, PaintBox1.Height));

//  PaintBox1.Canvas.Pen.Color := StyleServices.GetSystemColor(clBtnShadow);
  PaintBox1.Canvas.Polyline(
    [Point(0, PaintBox1.Height-1),
     Point(PaintBox1.Width, PaintBox1.Height-1)]);
end;

end.
