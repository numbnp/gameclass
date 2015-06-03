unit FrameEditControls2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Themes,
  Dialogs, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, GridsEh,
  DBGridEh, MemTableDataEh, Db, ADODB, DataDriverEh, ADODataDriverEh,
  MemTableEh, StdCtrls, ExtCtrls, DBCtrls, DBAxisGridsEh, DynVarsEh,
  EhLibVCL, ComCtrls, DBCtrlsEh, Mask;

type
  TfrEditControls2 = class(TFrame)
    gridFish: TDBGridEh;
    DataSource1: TDataSource;
    MemTableEh1: TMemTableEh;
    ADODataDriverEh1: TADODataDriverEh;
    Panel1: TPanel;
    PaintBox1: TPaintBox;
    Label1: TLabel;
    Panel2: TPanel;
    DBMemoEh1: TDBMemoEh;
    DBMemoEh2: TDBMemoEh;
    DBImageEh1: TDBImageEh;
    DBImageEh2: TDBImageEh;
    DBRichEditEh1: TDBRichEditEh;
    DBRichEditEh2: TDBRichEditEh;
    MemTableEh1ADate: TWideStringField;
    MemTableEh1AnmlClass: TWideStringField;
    MemTableEh1AnmlFamily: TWideStringField;
    MemTableEh1AnmlGenus: TWideStringField;
    MemTableEh1AnmlKingdom: TWideStringField;
    MemTableEh1AnmlOrder: TWideStringField;
    MemTableEh1AnmlPhylum: TWideStringField;
    MemTableEh1AnmlSpecies: TWideStringField;
    MemTableEh1Category: TWideStringField;
    MemTableEh1Common_name: TWideStringField;
    MemTableEh1Graphic: TBlobField;
    MemTableEh1Length: TFloatField;
    MemTableEh1Notes: TMemoField;
    MemTableEh1Ocean: TWideStringField;
    MemTableEh1PngGraphic: TBlobField;
    MemTableEh1RichNotes: TMemoField;
    MemTableEh1Species_Name: TWideStringField;
    MemTableEh1SpeciesId: TAutoIncField;
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

constructor TfrEditControls2.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Align := alClient;
  Panel1.DoubleBuffered := True;
//  if Form1.PixelsPerInch <> 96 then
//    ScaleBy(Form1.PixelsPerInch, 96);
end;

procedure TfrEditControls2.PaintBox1Paint(Sender: TObject);
begin
  Form1.FillFrameTopPanel(PaintBox1.Canvas, Rect(0, 0, PaintBox1.Width, PaintBox1.Height));
end;

end.
