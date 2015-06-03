unit FrameDataGrouping;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Themes,
  Dialogs, StdCtrls, ExtCtrls, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls,
  GridsEh, DBGridEh, MemTableDataEh, Db, ADODB, DataDriverEh, ADODataDriverEh,
  MemTableEh, DBAxisGridsEh;

type
  TfrDataGrouping = class(TFrame)
    Panel1: TPanel;
    PaintBox1: TPaintBox;
    Label1: TLabel;
    DBGridEh1: TDBGridEh;
    DataSource1: TDataSource;
    mtTable1: TMemTableEh;
    ADODataDriverEh1: TADODataDriverEh;
    Panel2: TPanel;
    CheckBox1: TCheckBox;
    procedure PaintBox1Paint(Sender: TObject);
    procedure DBGridEh1ActiveGroupingStructChanged(
      Sender: TCustomDBGridEh);
    procedure CheckBox1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses Unit1;

{$R *.dfm}

constructor TfrDataGrouping.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Align := alClient;
  Panel1.DoubleBuffered := True;
//  if Form1.PixelsPerInch <> 96 then
//    ScaleBy(Form1.PixelsPerInch, 96);
  DBGridEh1.DataGrouping.GroupDataTree.Root[0].Expanded := True;
end;

procedure TfrDataGrouping.PaintBox1Paint(Sender: TObject);
begin
  Form1.FillFrameTopPanel(PaintBox1.Canvas, Rect(0, 0, PaintBox1.Width, PaintBox1.Height));
end;

procedure TfrDataGrouping.DBGridEh1ActiveGroupingStructChanged(
  Sender: TCustomDBGridEh);
var
  BaseColor{, NewColor}: TColor;
  i: Integer;
begin
  BaseColor := clGradientInactiveCaption;
  for I := 0 to DBGridEh1.DataGrouping.ActiveGroupLevelsCount - 1 do
  begin
    DBGridEh1.DataGrouping.ActiveGroupLevels[i].Color :=
      ApproximateColor(BaseColor, DBGridEh1.Color,
        Round(I / DBGridEh1.DataGrouping.ActiveGroupLevelsCount * 255));
    DBGridEh1.DataGrouping.ActiveGroupLevels[i].Font.Style := [fsBold];
  end;
end;

procedure TfrDataGrouping.CheckBox1Click(Sender: TObject);
begin
  DBGridEh1.DataGrouping.GroupRowDefValues.FooterInGroupRow := CheckBox1.Checked;
//  if DBGridEh1.DataGrouping.GroupRowDefValues.FooterInGroupRow then
//    DBGridEh1.DataGrouping.FootersDefValues.Color := cl
end;

end.
