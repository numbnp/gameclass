unit FrameMainGrid;

{$I EhLib.Inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
{$IFDEF EH_LIB_6} Variants, {$ENDIF}
  Themes,
  Dialogs, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, ExtCtrls,
  GridsEh, DBGridEh, MemTableDataEh, Db, DataDriverEh, AppLangConsts,
  MemTableEh, StdCtrls, DBAxisGridsEh, DynVarsEh, EhLibVCL, Vcl.Menus;

type
  TfrMainGrid = class(TFrame)
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
    ddrData1: TSQLDataDriverEh;
    qrVendors: TMemTableEh;
    ddrVendors: TSQLDataDriverEh;
    PaintBox1: TPaintBox;
    Label1: TLabel;
    Image1: TImage;
    PopupMenu1: TPopupMenu;
    Menu1: TMenuItem;
    MenuwithSubMenu1: TMenuItem;
    SubMenu1: TMenuItem;
    procedure PaintBox1Paint(Sender: TObject);
  private
    procedure WMSettingChange(var Message: TMessage); message WM_SETTINGCHANGE;
    procedure ResourceLanguageChanged;
  protected
    procedure ReadState(Reader: TReader); override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses Unit1;

{$R *.dfm}

{ TfrMainGrid }

constructor TfrMainGrid.Create(AOwner: TComponent);
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
  Panel1.DoubleBuffered := True;
  ResourceLanguageChanged;

  qrVendors.Open;
  mtQuery1.Open;

//  DBGridEh1.TitleParams.SecondColor := clBtnFace;
end;

procedure TfrMainGrid.PaintBox1Paint(Sender: TObject);
begin
  Form1.FillFrameTopPanel(PaintBox1.Canvas, Rect(0, 0, PaintBox1.Width, PaintBox1.Height));
end;

procedure TfrMainGrid.ReadState(Reader: TReader);
begin
  inherited ReadState(Reader);
//  ScalingFlags := [sfLeft, sfTop, sfWidth, sfHeight];
//  if Form1.Canvas.TextHeight('0') <> 13 then
//    ScaleBy(Form1.Canvas.TextHeight('0'), 13);
end;

procedure TfrMainGrid.WMSettingChange(var Message: TMessage);
begin
  inherited;
  ResourceLanguageChanged;
end;

procedure TfrMainGrid.ResourceLanguageChanged;
begin
  Label1.Caption := ApplicationLanguageConsts.VertMenuMainGrid;
  DBGridEh1.Columns[0].Title.Caption := ApplicationLanguageConsts.DBGridEh1VendorNumber;
  DBGridEh1.Columns[1].Title.Caption := ApplicationLanguageConsts.DBGridEh1VendorName;
  DBGridEh1.Columns[2].Title.Caption := ApplicationLanguageConsts.DBGridEh1PartNo;
  DBGridEh1.Columns[3].Title.Caption := ApplicationLanguageConsts.DBGridEh1PartDesc;
  DBGridEh1.Columns[4].Title.Caption := ApplicationLanguageConsts.DBGridEh1PartCost;
  DBGridEh1.Columns[5].Title.Caption := ApplicationLanguageConsts.DBGridEh1PartQty;
  DBGridEh1.Columns[6].Title.Caption := ApplicationLanguageConsts.DBGridEh1Preferred;
  DBGridEh1.Columns[3].Footers[0].Value := ApplicationLanguageConsts.DBGridEh1Sum;
end;

end.
