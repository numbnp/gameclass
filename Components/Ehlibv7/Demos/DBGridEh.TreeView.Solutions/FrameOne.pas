unit FrameOne;

{$I EhLib.Inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
{$IFDEF EH_LIB_6} Variants, {$ENDIF}
  Themes,
  Dialogs, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, ExtCtrls,
  GridsEh, DBGridEh, MemTableDataEh, Db, ADODB, DataDriverEh,
  ADODataDriverEh, MemTableEh, StdCtrls, DBAxisGridsEh;

type
  TfrFrameOne = class(TFrame)
    Panel1: TPanel;
    PaintBox1: TPaintBox;
    Label1: TLabel;
    ADODataDriverEh1: TADODataDriverEh;
    DataSource1: TDataSource;
    MemTableEh1: TMemTableEh;
    MemTableEh1ExpCount: TAggregateField;
    DBGridEh1: TDBGridEh;
    bReopen: TButton;
    ADOQuery1: TADOQuery;
    Memo1: TMemo;
    procedure PaintBox1Paint(Sender: TObject);
    procedure bReopenClick(Sender: TObject);
  private
  protected
  public
    constructor Create(AOwner: TComponent); override;
    procedure RecordsViewTreeNodeExpanding(Sender: TObject; Node: TMemRecViewEh; var AllowExpansion: Boolean);
  end;

implementation

uses Unit1;

{$R *.dfm}

{ TfrFrameOne }

constructor TfrFrameOne.Create(AOwner: TComponent);
//var
//  OldFontHeight: Integer;
begin
  inherited Create(AOwner);
//  Panel1.Height := 36;

  DBGridEh1.FooterParams.Font.Style := [fsBold];
  Memo1.WordWrap := True;
  ADOQuery1.Connection := Form1.ADOConnectionProviderEh1.InlineConnection.Connection;
  ADOQuery1.Parameters.Refresh;
  bReopenClick(nil);
end;

procedure TfrFrameOne.PaintBox1Paint(Sender: TObject);
begin
  Form1.FillFrameTopPanel(PaintBox1.Canvas, Rect(0, 0, PaintBox1.Width, PaintBox1.Height));
end;

procedure TfrFrameOne.bReopenClick(Sender: TObject);
begin
  MemTableEh1.Close;
  MemTableEh1.Open;
  MemTableEh1.OnRecordsViewTreeNodeExpanding := RecordsViewTreeNodeExpanding;
end;

procedure TfrFrameOne.RecordsViewTreeNodeExpanding(Sender: TObject;
  Node: TMemRecViewEh; var AllowExpansion: Boolean);
var
  i: Integer;
begin
  if Node.NodesCount = 0 then
  begin
    ADOQuery1.Parameters[0].Value := Node.Rec.DataValues['ID', dvvValueEh];
    ADOQuery1.Open;
    MemTableEh1.LoadFromDataSet(ADOQuery1, -1, lmAppend, False);
    ADOQuery1.Close;

    Node.NodeHasVisibleChildren := (Node.NodesCount > 0);

  end;
end;

end.
