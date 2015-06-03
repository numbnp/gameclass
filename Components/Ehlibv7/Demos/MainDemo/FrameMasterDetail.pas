unit FrameMasterDetail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Themes,
  Dialogs, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, ExtCtrls,
  DBCtrls, GridsEh, DBGridEh, MemTableDataEh, Db, ADODB, DataDriverEh,
  ADODataDriverEh, MemTableEh, StdCtrls, DBAxisGridsEh;

type
  TfrMasterDetail = class(TFrame)
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    mtTable1: TMemTableEh;
    mtTable2: TMemTableEh;
    ddrOrders: TADODataDriverEh;
    ddrItems: TADODataDriverEh;
    Panel1: TPanel;
    DBGridEh3: TDBGridEh;
    DBNavigator2: TDBNavigator;
    Panel2: TPanel;
    DBGridEh4: TDBGridEh;
    DBNavigator3: TDBNavigator;
    Splitter1: TSplitter;
    Panel3: TPanel;
    PaintBox1: TPaintBox;
    Label1: TLabel;
    Bevel1: TBevel;
    procedure PaintBox1Paint(Sender: TObject);
  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses Unit1;

{$R *.dfm}

constructor TfrMasterDetail.Create(AOwner: TComponent);
//var
//  OldFontHeight: Integer;
begin
  inherited Create(AOwner);
  Panel1.Height := 36;
  Panel1.DoubleBuffered := True;
{  if Form1.PixelsPerInch <> 96 then
  begin
    OldFontHeight := Font.Height;
    ScaleBy(Form1.PixelsPerInch, 96);
    Font.Height := MulDiv(OldFontHeight, Screen.PixelsPerInch, 96);
  end;}
end;

procedure TfrMasterDetail.PaintBox1Paint(Sender: TObject);
begin
  Form1.FillFrameTopPanel(PaintBox1.Canvas, Rect(0, 0, PaintBox1.Width, PaintBox1.Height));
end;

end.
