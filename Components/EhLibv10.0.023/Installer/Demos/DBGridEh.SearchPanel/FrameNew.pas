unit FrameNew;

{$I EhLib.Inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
{$IFDEF EH_LIB_6} Variants, {$ENDIF}
  Themes,
  Dialogs, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, ExtCtrls,
  GridsEh, DBGridEh, MemTableDataEh, Db, ADODB, DataDriverEh,
  ADODataDriverEh, MemTableEh, StdCtrls, DynVarsEh, EhLibVCL, DBAxisGridsEh;

type
  TfrFrameNew = class(TFrame)
    DBGridEh1: TDBGridEh;
    Panel1: TPanel;
    DataSource1: TDataSource;
    mtQuery1: TMemTableEh;
    mtQuery1VNo: TFloatField;
    mtQuery1VName: TStringField;
    mtQuery1PNo: TFloatField;
    mtQuery1PDescription: TStringField;
    mtQuery1PCost: TCurrencyField;
    mtQuery1IQty: TIntegerField;
    mtQuery1VName1: TStringField;
    mtQuery1VPreferred: TBooleanField;
    ddrData1: TADODataDriverEh;
    qrVendors: TMemTableEh;
    ddrVendors: TADODataDriverEh;
    PaintBox1: TPaintBox;
    Label1: TLabel;
    procedure PaintBox1Paint(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure ReadState(Reader: TReader); override;
  public
    constructor Create(AOwner: TComponent); override;
    { Public declarations }
  end;

implementation

uses Unit1;

{$R *.dfm}

{ TfrFrame1 }

constructor TfrFrameNew.Create(AOwner: TComponent);
//var
//  OldFontHeight: Integer;
begin
  inherited Create(AOwner);
  Panel1.Height := 36;
  DBGridEh1.FooterParams.VertLineColor := DBGridEh1.GridLineParams.DarkColor;
  DBGridEh1.FooterParams.HorzLineColor := DBGridEh1.GridLineParams.DarkColor;
  DBGridEh1.FooterParams.Color := ApproximateColor(DBGridEh1.FixedColor, clWindow, 128);
//  if not DBGridEh1.TitleParams.SecondColorStored then
    DBGridEh1.TitleParams.SecondColor := ApproximateColor(clBtnFace, clWindow, 170);
{  if Form1.PixelsPerInch <> 96 then
  begin
    OldFontHeight := Font.Height;
    ScaleBy(Form1.PixelsPerInch, 96);
    Font.Height := MulDiv(OldFontHeight, Screen.PixelsPerInch, 96);
  end;}

  DBGridEh1.FooterParams.Font.Style := [fsBold];

//  DBGridEh1.TitleParams.SecondColor := clBtnFace;
end;

procedure TfrFrameNew.PaintBox1Paint(Sender: TObject);
begin
  Form1.FillFrameTopPanel(PaintBox1.Canvas, Rect(0, 0, PaintBox1.Width, PaintBox1.Height));
end;

procedure TfrFrameNew.ReadState(Reader: TReader);
begin
  inherited ReadState(Reader);
//  ScalingFlags := [sfLeft, sfTop, sfWidth, sfHeight];
//  if Form1.Canvas.TextHeight('0') <> 13 then
//    ScaleBy(Form1.Canvas.TextHeight('0'), 13);
end;

end.
