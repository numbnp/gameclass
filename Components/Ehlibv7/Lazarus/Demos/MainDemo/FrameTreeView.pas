unit FrameTreeView;

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, LMessages, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, GridsEh, DBGridsEh,
  StdCtrls, ExtCtrls, MemTableDataEh, Db, MemTableEh, MaskEdit, DBCtrlsEh,
  DBAxisGridsEh;

type
  TfrTreeView = class(TFrame)
    Panel1: TPanel;
    PaintBox1: TPaintBox;
    Label1: TLabel;
    DBGridEh9: TDBGridEh;
    mtTreeView: TMemTableEh;
//    mtTreeViewExpCount: TAggregateField;
    dsTreeView: TDataSource;
    Panel2: TPanel;
    CheckBox1: TCheckBox;
    DBComboBoxEh1: TDBComboBoxEh;
    Label2: TLabel;
    procedure PaintBox1Paint(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure DBComboBoxEh1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses Unit1;

{$R *.lfm}

constructor TfrTreeView.Create(AOwner: TComponent);
var
  Path: String;
begin
  inherited Create(AOwner);
  Align := alClient;
  Panel1.Height := 36;
//  if Form1.PixelsPerInch <> 96 then
//    ScaleBy(Form1.PixelsPerInch, 96);
  DBGridEh9.Border.Color := DBGridEh9.GridLineParams.GetDarkColor;
  DBGridEh9.TitleParams.SecondColor := ApproximateColor(clBtnFace, clWindow, 125);
  Panel1.DoubleBuffered := True;

  GetDir(0, Path);

  mtTreeView.LoadFromFile(Path+'\FrameTreeView-mtTreeView.dfm' );
  mtTreeView.Open;
end;

procedure TfrTreeView.PaintBox1Paint(Sender: TObject);
begin
  Form1.FillFrameTopPanel(PaintBox1.Canvas, Rect(0, 0, PaintBox1.Width, PaintBox1.Height));
end;

procedure TfrTreeView.CheckBox1Click(Sender: TObject);
begin
  DBGridEh9.TreeViewParams.ShowTreeLines := CheckBox1.Checked;
end;

procedure TfrTreeView.DBComboBoxEh1Change(Sender: TObject);
begin
  case DBComboBoxEh1.ItemIndex of
    0: DBGridEh9.TreeViewParams.GlyphStyle := tvgsClassicEh;
    1: DBGridEh9.TreeViewParams.GlyphStyle := tvgsThemedEh;
    2: DBGridEh9.TreeViewParams.GlyphStyle := tvgsExplorerThemedEh;
  end;
end;

end.
