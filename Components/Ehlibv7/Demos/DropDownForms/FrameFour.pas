unit FrameFour;

{$I EhLib.Inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
{$IFDEF EH_LIB_6} Variants, {$ENDIF}
  Themes,
  Dialogs, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, ExtCtrls,
  GridsEh, DBGridEh, MemTableDataEh, Db, ADODB, DataDriverEh,
  ADODataDriverEh, MemTableEh, StdCtrls, DBAxisGridsEh, ImgList, DynVarsEh;

type
  TfrFrameFour = class(TFrame)
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
    procedure PaintBox1Paint(Sender: TObject);
  private
  protected
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses Unit1;

{$R *.dfm}

{ TfrFrameOne }

constructor TfrFrameFour.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Memo1.WordWrap := True;

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

procedure TfrFrameFour.PaintBox1Paint(Sender: TObject);
begin
  Form1.FillFrameTopPanel(PaintBox1.Canvas, Rect(0, 0, PaintBox1.Width, PaintBox1.Height));
end;

end.
