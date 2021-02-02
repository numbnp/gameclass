unit FrameOne;

{$I EhLib.Inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
{$IFDEF EH_LIB_6} Variants, {$ENDIF}
  Themes,
  Dialogs, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, ExtCtrls,
  GridsEh, DBGridEh, MemTableDataEh, Db, ADODB, DataDriverEh,
  ADODataDriverEh, MemTableEh, StdCtrls, DBCtrlsEh, Mask;

type
  TfrFrameOne = class(TFrame)
    Panel1: TPanel;
    PaintBox1: TPaintBox;
    Label1: TLabel;
    DBDateTimeEditEh1: TDBDateTimeEditEh;
    DBDateTimeEditEh2: TDBDateTimeEditEh;
    DBDateTimeEditEh6: TDBDateTimeEditEh;
    DBDateTimeEditEh3: TDBDateTimeEditEh;
    DBDateTimeEditEh4: TDBDateTimeEditEh;
    DBDateTimeEditEh5: TDBDateTimeEditEh;
    DBDateTimeEditEh7: TDBDateTimeEditEh;
    DBDateTimeEditEh8: TDBDateTimeEditEh;
    procedure PaintBox1Paint(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure ReadState(Reader: TReader); override;
  public
    constructor Create(AOwner: TComponent); override;
    { Public declarations }
  end;

implementation

uses MainUnit;

{$R *.dfm}

{ TfrFrameOne }

constructor TfrFrameOne.Create(AOwner: TComponent);
//var
//  OldFontHeight: Integer;
begin
  inherited Create(AOwner);
  Panel1.Height := 36;
end;

procedure TfrFrameOne.PaintBox1Paint(Sender: TObject);
begin
  Form1.FillFrameTopPanel(PaintBox1.Canvas, Rect(0, 0, PaintBox1.Width, PaintBox1.Height));
end;

procedure TfrFrameOne.ReadState(Reader: TReader);
begin
  inherited ReadState(Reader);
//  ScalingFlags := [sfLeft, sfTop, sfWidth, sfHeight];
//  if Form1.Canvas.TextHeight('0') <> 13 then
//    ScaleBy(Form1.Canvas.TextHeight('0'), 13);
end;

end.
