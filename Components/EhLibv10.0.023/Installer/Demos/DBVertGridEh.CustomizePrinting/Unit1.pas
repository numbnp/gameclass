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
  ObjectInspectorEh, PrintUtilsEh,
  DBLookupEh, DynVarsEh, DBAxisGridsEh, CompoMansEh, EhLibVCL, ComCtrls,
  DBVertGridsEh, ExtCtrls;

type
  TForm1 = class(TForm)
    MemTableEh1: TMemTableEh;
    DBGridEh1: TDBGridEh;
    DataSource1: TDataSource;
    DBVertGridEh1: TDBVertGridEh;
    DBRichEditEh1: TDBRichEditEh;
    DBRichEditEh2: TDBRichEditEh;
    Button1: TButton;
    cbFillPageBack: TDBCheckBoxEh;
    cbFillPageFront: TDBCheckBoxEh;
    cbFillContentBack: TDBCheckBoxEh;
    cbFillContentFront: TDBCheckBoxEh;
    DBImageEh1: TDBImageEh;
    cbRichTextBeforeGrid: TDBCheckBoxEh;
    cbRichTextAfterGrid: TDBCheckBoxEh;
    cbPrintCustDataBeforeGrid: TDBCheckBoxEh;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
    procedure DBVertGridEh1PrintServiceBeforePrintPage(Sender: TObject);
    procedure DBVertGridEh1PrintServiceAfterPrintPage(Sender: TObject);
    procedure DBVertGridEh1PrintServiceBeforePrintPageContent(
      Sender: TObject);
    procedure DBVertGridEh1PrintServiceAfterPrintPageContent(
      Sender: TObject);
    procedure DBVertGridEh1PrintServiceCalcLayoutDataBeforeGrid(
      PrintService: TBaseGridPrintServiceEh; var BeforeGridHeight,
      FullHeight: Integer; var Processed: Boolean);
    procedure DBVertGridEh1PrintServicePrintDataBeforeGrid(
      PrintService: TBaseGridPrintServiceEh; var BeforeGridHeight,
      FullHeight: Integer; var Processed: Boolean);
  private
    { Private declarations }
  public
    procedure FillPageText;
    procedure FillContentText;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F11 then
    ShowObjectInspectorForm(ActiveControl, Rect(Left+Width+10, Top, Left+Width+10+300, Top+Height));
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if cbRichTextBeforeGrid.Checked then
    DBVertGridEh1.PrintService.TextBeforeContent := DBRichEditEh1.RtfText
  else
    DBVertGridEh1.PrintService.TextBeforeContent := '';

  if cbRichTextAfterGrid.Checked then
    DBVertGridEh1.PrintService.TextAfterContent := DBRichEditEh2.RtfText
  else
    DBVertGridEh1.PrintService.TextAfterContent := '';

  DBVertGridEh1.PrintService.Preview;
end;

procedure TForm1.FillPageText;
const
  AText = 'Page background text  ';
var
  xPos, yPos: Integer;
  TextW, TextH: Integer;
begin
  yPos := 0;
  DBVertGridEh1.PrintService.Canvas.Font.Size := 30;
  DBVertGridEh1.PrintService.Canvas.Font.Color := RGB(240, 240, 240); // clGray;
  TextW := DBVertGridEh1.PrintService.Canvas.TextWidth(AText);
  TextH := DBVertGridEh1.PrintService.Canvas.TextHeight(AText);
  while True do
  begin
    xPos := 0;
    while True do
    begin
      DBVertGridEh1.PrintService.Canvas.TextOut(xPos, yPos, AText);
      if xPos > DBVertGridEh1.PrintService.PageWidth then Break;
      Inc(xPos, TextW);
    end;
    if yPos > DBVertGridEh1.PrintService.PageHeight then Break;
    Inc(yPos, TextH);
  end;
end;

procedure TForm1.FillContentText;
const
  AText = 'Page content background text  ';
var
  xPos, yPos: Integer;
  TextW, TextH: Integer;
  InRect: TRect;
begin
  yPos := 0;
  DBVertGridEh1.PrintService.Canvas.Font.Size := 30;
  DBVertGridEh1.PrintService.Canvas.Font.Color := RGB(240, 240, 240); // clGray;
  DBVertGridEh1.PrintService.Canvas.Brush.Style := bsClear;
  TextW := DBVertGridEh1.PrintService.Canvas.TextWidth(AText);
  TextH := DBVertGridEh1.PrintService.Canvas.TextHeight(AText);
  InRect := DBVertGridEh1.PrintService.LogDataPrintRec;
  while True do
  begin
    xPos := 0;
    while True do
    begin
//      DBVertGridEh1.PrintService.Canvas.TextOut(xPos, yPos, AText);
      DBVertGridEh1.PrintService.Canvas.TextRect(InRect, xPos, yPos, AText);
      if xPos > InRect.Right then Break;
      Inc(xPos, TextW);
    end;
    if yPos > InRect.Bottom then Break;
    Inc(yPos, TextH);
  end;
end;

procedure TForm1.DBVertGridEh1PrintServiceBeforePrintPage(Sender: TObject);
begin
  if cbFillPageBack.Checked then
    FillPageText;
end;

procedure TForm1.DBVertGridEh1PrintServiceAfterPrintPage(Sender: TObject);
begin
  if cbFillPageFront.Checked then
    FillPageText;
end;

procedure TForm1.DBVertGridEh1PrintServiceBeforePrintPageContent(
  Sender: TObject);
begin
  if cbFillContentBack.Checked then
    FillContentText;
end;

procedure TForm1.DBVertGridEh1PrintServiceAfterPrintPageContent(
  Sender: TObject);
begin
  if cbFillContentFront.Checked then
    FillContentText;
end;

procedure TForm1.DBVertGridEh1PrintServiceCalcLayoutDataBeforeGrid(
  PrintService: TBaseGridPrintServiceEh; var BeforeGridHeight,
  FullHeight: Integer; var Processed: Boolean);
begin
  if not cbPrintCustDataBeforeGrid.Checked then Exit;
  PrintService.DefaultCalcLayoutDataBeforeGrid(BeforeGridHeight, FullHeight);
  BeforeGridHeight := BeforeGridHeight + 500;
  FullHeight := FullHeight + 500;
  Processed := True;
end;

procedure TForm1.DBVertGridEh1PrintServicePrintDataBeforeGrid(
  PrintService: TBaseGridPrintServiceEh; var BeforeGridHeight,
  FullHeight: Integer; var Processed: Boolean);
begin
  if not cbPrintCustDataBeforeGrid.Checked then Exit;

  PrintService.DefaultPrintDataBeforeGrid(BeforeGridHeight, FullHeight);

  DBImageEh1.Picture.PaintTo(DBVertGridEh1.PrintService.Canvas,
    Rect(0, BeforeGridHeight, 500, BeforeGridHeight+500), ipFitEh,
    Point(0,0), Rect(0, BeforeGridHeight, 500, BeforeGridHeight+500));

  BeforeGridHeight := BeforeGridHeight + 500;
  FullHeight := FullHeight + 500;

  Processed := True;
end;

initialization
//  DBGridEhDefaultStyle.IsDrawFocusRect := False;
  DefFontData.Name := 'Tahoma';
//  DBGridEhDebugDraw := True;
end.
