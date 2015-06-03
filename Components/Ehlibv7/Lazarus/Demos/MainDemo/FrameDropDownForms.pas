unit FrameDropDownForms;

{$MODE Delphi}

//{$I EhLib.Inc}

interface

uses
  LCLIntf, LCLType, LMessages,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Variants,
  Themes,
  Dialogs, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, ExtCtrls,
  GridsEh, DBGridsEh, MemTableDataEh, Db, DataDriverEh,
  MemTableEh, StdCtrls, DBAxisGridsEh, ImgList, DynVarsEh;

type

  { TfrFrameDropDownForms }

  TfrFrameDropDownForms = class(TFrame)
    Panel1: TPanel;
    PaintBox1: TPaintBox;
    Label1: TLabel;
    Memo1: TMemo;
    mtVendors: TMemTableEh;
    MemTableEh1: TMemTableEh;
    MemTableEh1Cost: TFloatField;
    MemTableEh1Description: TWideStringField;
    MemTableEh1ListPrice: TFloatField;
    MemTableEh1OnHand: TFloatField;
    MemTableEh1OnOrder: TFloatField;
    MemTableEh1PartNo: TAutoIncField;
    MemTableEh1VendorNo: TIntegerField;
    MemTableEh1VandorName: TStringField;
    DataSource1: TDataSource;
    DBGridEh1: TDBGridEh;
    SQLDataDriverEh1: TSQLDataDriverEh;
    SQLDataDriverEh2: TSQLDataDriverEh;
    procedure DBGridEh1ActiveGroupingStructChanged(Sender: TCustomDBGridEh);
    procedure PaintBox1Paint(Sender: TObject);
  private
  protected
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses Unit1, DDFVendorsUnit, MemoEditUnit;

{$R *.lfm}

{ TfrFrameOne }

constructor TfrFrameDropDownForms.Create(AOwner: TComponent);
var
  Path: String;
begin
  inherited Create(AOwner);

  GetDir(0, Path);

//  mtVendors.LoadFromFile(Path+'\FrameDropDownForms-mtVendors.dfm' );
  mtVendors.Open;

//  MemTableEh1.LoadFromFile(Path+'\FrameDropDownForms-MemTableEh1.dfm');
  MemTableEh1.Open;

  Memo1.WordWrap := True;
  Panel1.DoubleBuffered := True;
  Memo1.DoubleBuffered := True;

  while not MemTableEh1.Eof do
  begin
    MemTableEh1.Edit;
    if mtVendors.Locate('VendorNo', MemTableEh1['VendorNo'], []) then
      MemTableEh1['VendorName'] :=
        VarToStr(mtVendors['VendorName']) + ' (' + VarToStr(mtVendors['Address1']) + ')';
    MemTableEh1.Post;
    MemTableEh1.Next;
  end;
  MemTableEh1.First;

end;

procedure TfrFrameDropDownForms.PaintBox1Paint(Sender: TObject);
begin
  Form1.FillFrameTopPanel(PaintBox1.Canvas, Rect(0, 0, PaintBox1.Width, PaintBox1.Height));
end;

procedure TfrFrameDropDownForms.DBGridEh1ActiveGroupingStructChanged(
  Sender: TCustomDBGridEh);
begin

end;

end.
