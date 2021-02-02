unit FrameTwo_Grid;

{$I EhLib.Inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
{$IFDEF EH_LIB_6} Variants, {$ENDIF}
  Themes,
  Dialogs, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, ExtCtrls,
  GridsEh, DBGridEh, MemTableDataEh, Db, ADODB, DataDriverEh,
  ADODataDriverEh, MemTableEh, StdCtrls, DynVarsEh, DBVertGridsEh, EhLibVCL,
  DBAxisGridsEh;

type
  TfrFrameTwoGrid = class(TFrame)
    Panel1: TPanel;
    PaintBox1: TPaintBox;
    Label1: TLabel;
    DBGridEh1: TDBGridEh;
    MemTableEh1: TMemTableEh;
    DataSource1: TDataSource;
    DBVertGridEh1: TDBVertGridEh;
    Splitter1: TSplitter;
    procedure PaintBox1Paint(Sender: TObject);
    procedure DBGridEh1Columns3GetCellParams(Sender: TObject; EditMode: Boolean;
      Params: TColCellParamsEh);
    procedure DBVertGridEh1Rows3GetCellParams(Sender: TObject;
      EditMode: Boolean; Params: TRowCellParamsEh);
  private
    { Private declarations }
  protected
    procedure ReadState(Reader: TReader); override;
  public
    constructor Create(AOwner: TComponent); override;
    { Public declarations }
  end;

implementation

uses MainUnit;

{$R *.dfm}

{ TfrFrameOne }

constructor TfrFrameTwoGrid.Create(AOwner: TComponent);
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

procedure TfrFrameTwoGrid.DBGridEh1Columns3GetCellParams(Sender: TObject;
  EditMode: Boolean; Params: TColCellParamsEh);
begin
  if EditMode then
    if not (Sender as TColumnEh).Field.IsNull then
      Params.Text := FormatDateTime((Sender as TColumnEh).DisplayFormat,
                                    (Sender as TColumnEh).Field.AsDateTime);
end;

procedure TfrFrameTwoGrid.DBVertGridEh1Rows3GetCellParams(Sender: TObject;
  EditMode: Boolean; Params: TRowCellParamsEh);
begin
  if EditMode then
    if not (Sender as TFieldRowEh).Field.IsNull then
      Params.Text := FormatDateTime((Sender as TFieldRowEh).DisplayFormat,
                                    (Sender as TFieldRowEh).Field.AsDateTime);
end;

procedure TfrFrameTwoGrid.PaintBox1Paint(Sender: TObject);
begin
  Form1.FillFrameTopPanel(PaintBox1.Canvas, Rect(0, 0, PaintBox1.Width, PaintBox1.Height));
end;

procedure TfrFrameTwoGrid.ReadState(Reader: TReader);
begin
  inherited ReadState(Reader);
//  ScalingFlags := [sfLeft, sfTop, sfWidth, sfHeight];
//  if Form1.Canvas.TextHeight('0') <> 13 then
//    ScaleBy(Form1.Canvas.TextHeight('0'), 13);
end;

end.
