unit FrameSearchPanel;

{$MODE Delphi}

//{$I EhLib.Inc}

interface

uses
  LCLIntf, LCLType, LMessages,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  {$IFDEF EH_LIB_6} Types, {$ENDIF}
  {$IFDEF EH_LIB_16} System.UITypes, {$ENDIF}
  Dialogs, StdCtrls, ExtCtrls, MemTableDataEh, Db, DBGridEhGrouping,
  ToolCtrlsEh, DBGridEhToolCtrls, GridsEh, DBGridsEh, MemTableEh,
  DBAxisGridsEh, DataDriverEh;

type

  { TfrSearchPanel }

  TfrSearchPanel = class(TFrame)
    Panel1: TPanel;
    PaintBox1: TPaintBox;
    Label1: TLabel;
    DataSource1: TDataSource;
    MemTableEh1: TMemTableEh;
    DBGridEh1: TDBGridEh;
    Panel2: TPanel;
    bFilerOnTyping: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    SQLDataDriverEh1: TSQLDataDriverEh;
    procedure PaintBox1Paint(Sender: TObject);
    procedure bFilerOnTypingClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Panel2Click(Sender: TObject);
  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses Unit1;

{$R *.lfm}

procedure TfrSearchPanel.bFilerOnTypingClick(Sender: TObject);
begin
  DBGridEh1.SearchPanel.FilterOnTyping := not DBGridEh1.SearchPanel.FilterOnTyping;
  if DBGridEh1.SearchPanel.FilterOnTyping
    then bFilerOnTyping.Caption := 'FilterOnTyping (Yes)'
    else bFilerOnTyping.Caption := 'FilterOnTyping (No)';
end;

procedure TfrSearchPanel.Button4Click(Sender: TObject);
begin
  DBGridEh1.SearchPanel.PersistentShowing := not DBGridEh1.SearchPanel.PersistentShowing;
  if DBGridEh1.SearchPanel.PersistentShowing
    then Button4.Caption := 'Persistent Show (Yes)'
    else Button4.Caption := 'Persistent Show (No)';
end;

procedure TfrSearchPanel.Button5Click(Sender: TObject);
begin
  DBGridEh1.SearchPanel.FilterEnabled := not DBGridEh1.SearchPanel.FilterEnabled;
  if DBGridEh1.SearchPanel.FilterEnabled
    then Button5.Caption := 'Filter Enabled (Yes)'
    else Button5.Caption := 'Filter Enabled (No)';
end;

procedure TfrSearchPanel.Button6Click(Sender: TObject);
begin
  if DBGridEh1.SearchPanel.Location = splGridTopEh then
  begin
    DBGridEh1.SearchPanel.Location := splHorzScrollBarExtraPanelEh;
    DBGridEh1.HorzScrollBar.ExtraPanel.Visible := True;
    Button6.Caption := 'FilterPanel in the Top (No)';
  end else
  begin
    DBGridEh1.SearchPanel.Location := splGridTopEh;
    DBGridEh1.HorzScrollBar.ExtraPanel.Visible := False;
    Button6.Caption := 'FilterPanel in the Top (Yes)';
  end;
end;

procedure TfrSearchPanel.Panel2Click(Sender: TObject);
begin

end;

constructor TfrSearchPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Align := alClient;
  Panel1.Height := 36;
  Panel1.DoubleBuffered := True;
  MemTableEh1.Open;
//  if Form1.PixelsPerInch <> 96 then
//    ScaleBy(Form1.PixelsPerInch, 96);
end;

procedure TfrSearchPanel.PaintBox1Paint(Sender: TObject);
begin
  Form1.FillFrameTopPanel(PaintBox1.Canvas, Rect(0, 0, PaintBox1.Width, PaintBox1.Height));

  PaintBox1.Canvas.Pen.Color := clBtnShadow;
  PaintBox1.Canvas.Polyline(
    [Point(0, PaintBox1.Height-1),
     Point(PaintBox1.Width, PaintBox1.Height-1)]);
end;

end.
