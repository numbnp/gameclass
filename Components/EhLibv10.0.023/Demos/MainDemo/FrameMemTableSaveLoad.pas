unit FrameMemTableSaveLoad;

{$I EhLib.Inc}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Themes, EhLibVCL,
  {$IFDEF EH_LIB_6} Types, {$ENDIF}
  {$IFDEF EH_LIB_16} System.UITypes, {$ENDIF}
  Dialogs, StdCtrls, ExtCtrls, DBGridEh, DBGridEhGrouping, ToolCtrlsEh,
  DBGridEhToolCtrls, GridsEh, MemTableDataEh, Db, MemTableEh, ADODB,
  DBAxisGridsEh;

type
  TfrMemTableSaveLoad = class(TFrame)
    Panel1: TPanel;
    PaintBox1: TPaintBox;
    Label1: TLabel;
    Panel2: TPanel;
    DBGridEh1: TDBGridEh;
    MemTableEh1: TMemTableEh;
    DataSource1: TDataSource;
    bSave: TButton;
    bClearTable: TButton;
    Button1: TButton;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    procedure PaintBox1Paint(Sender: TObject);
    procedure bSaveClick(Sender: TObject);
    procedure bClearTableClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses Unit1, ShellAPI;

{$R *.dfm}

constructor TfrMemTableSaveLoad.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Align := alClient;
  Panel1.DoubleBuffered := True;
  SaveDialog1.InitialDir := ExtractFilePath(ParamStr(0));
  OpenDialog1.InitialDir := ExtractFilePath(ParamStr(0));
  if Form1.PixelsPerInch <> 96 then
    ScaleBy(Form1.PixelsPerInch, 96);
end;

procedure TfrMemTableSaveLoad.PaintBox1Paint(Sender: TObject);
begin
  Form1.FillFrameTopPanel(PaintBox1.Canvas, Rect(0, 0, PaintBox1.Width, PaintBox1.Height));

  PaintBox1.Canvas.Pen.Color := StyleServices.GetSystemColor(clBtnShadow);
  PaintBox1.Canvas.Polyline(
    [Point(0, PaintBox1.Height-1),
     Point(PaintBox1.Width, PaintBox1.Height-1)]);
end;

procedure TfrMemTableSaveLoad.bSaveClick(Sender: TObject);
begin
  if SaveDialog1.Execute then
  begin
    MemTableEh1.SaveToFile(SaveDialog1.FileName);
    if MessageDlg('Table is saved.'#13'Do you want to open file "' + SaveDialog1.FileName + '" in the notepad',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes
    then
      ShellAPI.ShellExecute(Handle, 'open', 'c:\windows\notepad.exe', PChar(SaveDialog1.FileName), nil, SW_SHOWNORMAL);
  end;
end;

procedure TfrMemTableSaveLoad.bClearTableClick(Sender: TObject);
begin
  MemTableEh1.EmptyTable;
end;

procedure TfrMemTableSaveLoad.Button1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    MemTableEh1.LoadFromFile(OpenDialog1.FileName);
  end;
end;

end.
