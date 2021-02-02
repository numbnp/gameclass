unit FrameOne;

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
  TfrFrameOne = class(TFrame)
    Panel1: TPanel;
    PaintBox1: TPaintBox;
    Label1: TLabel;
    Memo1: TMemo;
    MemTableEh1: TMemTableEh;
    DataSource1: TDataSource;
    DBGridEh1: TDBGridEh;
    procedure PaintBox1Paint(Sender: TObject);
  private
  protected
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses MemoEditUnit1, Unit1;

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
end;

procedure TfrFrameOne.PaintBox1Paint(Sender: TObject);
begin
  Form1.FillFrameTopPanel(PaintBox1.Canvas, Rect(0, 0, PaintBox1.Width, PaintBox1.Height));
end;

end.
