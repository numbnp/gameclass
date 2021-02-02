unit FrameTwo;

{$I EhLib.Inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
{$IFDEF EH_LIB_6} Variants, {$ENDIF}
  Themes,
  Dialogs, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, ExtCtrls,
  GridsEh, DBGridEh, MemTableDataEh, Db, ADODB, DataDriverEh,
  ADODataDriverEh, MemTableEh, StdCtrls, DBAxisGridsEh, DynVarsEh;

type
  TfrFrameTwo = class(TFrame)
    Panel1: TPanel;
    PaintBox1: TPaintBox;
    Label1: TLabel;
    Memo1: TMemo;
    DBGridEh1: TDBGridEh;
    DataSource1: TDataSource;
    MemTableEh1: TMemTableEh;
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

constructor TfrFrameTwo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  DBGridEh1.FooterParams.Font.Style := [fsBold];
  Memo1.WordWrap := True;
end;

procedure TfrFrameTwo.PaintBox1Paint(Sender: TObject);
begin
  Form1.FillFrameTopPanel(PaintBox1.Canvas, Rect(0, 0, PaintBox1.Width, PaintBox1.Height));
end;

end.
