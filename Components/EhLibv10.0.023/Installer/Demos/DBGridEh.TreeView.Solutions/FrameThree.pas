unit FrameThree;

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
  TfrFrameThree = class(TFrame)
    Panel1: TPanel;
    PaintBox1: TPaintBox;
    Label1: TLabel;
    ADODataDriverEh1: TADODataDriverEh;
    DataSource1: TDataSource;
    MemTableEh1: TMemTableEh;
    MemTableEh1ExpCount: TAggregateField;
    DBGridEh1: TDBGridEh;
    bReopen: TButton;
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

constructor TfrFrameThree.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  DBGridEh1.FooterParams.Font.Style := [fsBold];
  Memo1.WordWrap := True;
  bReopenClick(nil);
end;

procedure TfrFrameThree.PaintBox1Paint(Sender: TObject);
begin
  Form1.FillFrameTopPanel(PaintBox1.Canvas, Rect(0, 0, PaintBox1.Width, PaintBox1.Height));
end;

procedure TfrFrameThree.bReopenClick(Sender: TObject);
begin
  ADODataDriverEh1.SelectCommand.Parameters[0].Value := 0;
  MemTableEh1.Close;
  MemTableEh1.Open;
  MemTableEh1.OnRecordsViewTreeNodeExpanding := RecordsViewTreeNodeExpanding;

  while not MemTableEh1.Eof do
  begin
    MemTableEh1.RecView.NodeHasVisibleChildren := (MemTableEh1.RecView.Rec.DataValues['ChildrenCount', dvvValueEh] > 0);
    MemTableEh1.Next;
  end;
  MemTableEh1.First;
end;

procedure TfrFrameThree.RecordsViewTreeNodeExpanding(Sender: TObject;
  Node: TMemRecViewEh; var AllowExpansion: Boolean);
var
  i: Integer;
begin
  if Node.NodesCount = 0 then
  begin
    ADODataDriverEh1.SelectCommand.Parameters[0].Value := Node.Rec.DataValues['ID', dvvValueEh];
    ADODataDriverEh1.ProviderEOF := False;
    ADODataDriverEh1.GetDataReader;
    MemTableEh1.FetchRecords(-1);

    for i := 0 to Node.NodesCount-1  do
    begin
      Node.NodeItems[i].NodeHasVisibleChildren :=
        (Node.NodeItems[i].Rec.DataValues['ChildrenCount', dvvValueEh] > 0);
    end;
  end;
end;

end.
