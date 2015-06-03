unit FrameFishFact;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Themes,
  Dialogs, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, GridsEh,
  DBGridEh, MemTableDataEh, Db, ADODB, DataDriverEh, ADODataDriverEh,
  MemTableEh, StdCtrls, ExtCtrls, DBCtrls, DBAxisGridsEh, DynVarsEh,
  EhLibVCL;

type
  TfrFishFact = class(TFrame)
    gridFish: TDBGridEh;
    DataSource1: TDataSource;
    MemTableEh1: TMemTableEh;
    ADODataDriverEh1: TADODataDriverEh;
    MemTableEh1Category: TWideStringField;
    MemTableEh1Common_name: TWideStringField;
    MemTableEh1Graphic: TBlobField;
    MemTableEh1Length: TFloatField;
    MemTableEh1Notes: TMemoField;
    MemTableEh1Species_Name: TWideStringField;
    MemTableEh1SpeciesId: TAutoIncField;
    Panel1: TPanel;
    PaintBox1: TPaintBox;
    Label1: TLabel;
    procedure PaintBox1Paint(Sender: TObject);
  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses Unit1;

{$R *.dfm}

{ TfrFishFact }

constructor TfrFishFact.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Align := alClient;
  Panel1.DoubleBuffered := True;
//  if Form1.PixelsPerInch <> 96 then
//    ScaleBy(Form1.PixelsPerInch, 96);
end;

procedure TfrFishFact.PaintBox1Paint(Sender: TObject);
begin
  Form1.FillFrameTopPanel(PaintBox1.Canvas, Rect(0, 0, PaintBox1.Width, PaintBox1.Height));
end;

end.
