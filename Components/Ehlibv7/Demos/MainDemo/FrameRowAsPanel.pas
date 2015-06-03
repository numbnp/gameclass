unit FrameRowAsPanel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, MemTableDataEh, Db,
  ADODB, DataDriverEh, ADODataDriverEh, MemTableEh, GridsEh, DBGridEh, StdCtrls,
  ExtCtrls, DBAxisGridsEh;

type
  TfrRowAsPanel = class(TFrame)
    DBGridEh5: TDBGridEh;
    DataSource1: TDataSource;
    MemTableEh1: TMemTableEh;
    ADODataDriverEh1: TADODataDriverEh;
    Panel1: TPanel;
    PaintBox1: TPaintBox;
    Label2: TLabel;
    procedure PaintBox1Paint(Sender: TObject);
    procedure MemTableEh1AfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses Unit1;

{$R *.dfm}

constructor TfrRowAsPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Align := alClient;
  Panel1.DoubleBuffered := True;
//  if Form1.PixelsPerInch <> 96 then
//    ScaleBy(Form1.PixelsPerInch, 96);
end;

procedure TfrRowAsPanel.PaintBox1Paint(Sender: TObject);
begin
  Form1.FillFrameTopPanel(PaintBox1.Canvas, Rect(0, 0, PaintBox1.Width, PaintBox1.Height));
end;

procedure TfrRowAsPanel.MemTableEh1AfterOpen(DataSet: TDataSet);
begin
  TBlobField(MemTableEh1.FieldByName('Graphic')).BlobType := ftGraphic;
end;

end.
