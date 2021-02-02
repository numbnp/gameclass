unit FrameRowDetailPanel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, MemTableDataEh, Db,
  ADODB, DataDriverEh, ADODataDriverEh, MemTableEh, DBCtrlsEh, StdCtrls, Mask,
  ComCtrls, GridsEh, DBGridEh, ExtCtrls, DBAxisGridsEh;

type
  TfrRowDetailPanel = class(TFrame)
    DBGridEh7: TDBGridEh;
    PageControl2: TPageControl;
    TabSheet8: TTabSheet;
    DBGridEh8: TDBGridEh;
    TabSheet9: TTabSheet;
    ScrollBox1: TScrollBox;
    Label1: TStaticText;
    Label25: TStaticText;
    Label26: TStaticText;
    Label27: TStaticText;
    Label28: TStaticText;
    Label29: TStaticText;
    Label30: TStaticText;
    DBEditEh3: TDBEditEh;
    DBEditEh4: TDBEditEh;
    DBEditEh5: TDBEditEh;
    DBEditEh6: TDBEditEh;
    DBEditEh7: TDBEditEh;
    DBEditEh8: TDBEditEh;
    DBDateTimeEditEh3: TDBDateTimeEditEh;
    dsCustomersRDP: TDataSource;
    mtCustomersRDP: TMemTableEh;
    ADODataDriverEh1: TADODataDriverEh;
    dsOrdersRDP: TDataSource;
    mtOrdersRDP: TMemTableEh;
    ADODataDriverEh2: TADODataDriverEh;
    Panel1: TPanel;
    PaintBox1: TPaintBox;
    Label2: TLabel;
    procedure PaintBox1Paint(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses Unit1;

{$R *.dfm}

constructor TfrRowDetailPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Align := alClient;
  Panel1.Height := 36;
  Panel1.DoubleBuffered := True;
//  if Form1.PixelsPerInch <> 96 then
//    ScaleBy(Form1.PixelsPerInch, 96);
end;

procedure TfrRowDetailPanel.PaintBox1Paint(Sender: TObject);
begin
  Form1.FillFrameTopPanel(PaintBox1.Canvas, Rect(0, 0, PaintBox1.Width, PaintBox1.Height));
end;

end.
