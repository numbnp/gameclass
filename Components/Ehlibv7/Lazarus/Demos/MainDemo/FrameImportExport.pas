unit FrameImportExport;

{$MODE Delphi}

//{$I EhLib.Inc}

interface
uses
  LCLIntf, LCLType, LMessages,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Themes, EhLibLCL,
  {$IFDEF EH_LIB_6} Types, {$ENDIF}
  {$IFDEF EH_LIB_16} System.UITypes, {$ENDIF}
  Dialogs, MemTableDataEh, Db, DBGridEhGrouping, ToolCtrlsEh,
  DBGridEhToolCtrls, ExtCtrls, GridsEh, DBGridsEh, DataDriverEh,
  MemTableEh, DBGridEhImpExp, StdCtrls, DBAxisGridsEh;

type
  TfrImportExport = class(TFrame)
    qrVendors: TMemTableEh;
    ddrVendors: TSQLDataDriverEh;
    DataSource1: TDataSource;
    mtQuery1: TMemTableEh;
    mtQuery1VNo: TFloatField;
    mtQuery1VName: TStringField;
    mtQuery1PNo: TFloatField;
    mtQuery1PDescription: TStringField;
    mtQuery1PCost: TCurrencyField;
    mtQuery1IQty: TIntegerField;
    mtQuery1VName1: TStringField;
    mtQuery1VPreferred: TBooleanField;
    ddrData1: TSQLDataDriverEh;
    DBGridEh1: TDBGridEh;
    SaveDialog1: TSaveDialog;
    Panel1: TPanel;
    RBSaveAll: TRadioButton;
    RadioButton2: TRadioButton;
    btnExportAsTxt: TButton;
    btnExportAsUnicodeText: TButton;
    btnExportAsCSV: TButton;
    btnExportAsHTML: TButton;
    btnExportAsRTF: TButton;
    btnExportAsXLS: TButton;
    btnExportAsOLEXLS: TButton;
    btnImportAsTXT: TButton;
    btnImportAsUnicodeText: TButton;
    OpenDialog1: TOpenDialog;
    Panel2: TPanel;
    PaintBox1: TPaintBox;
    Label1: TLabel;
    procedure btnExportAsTxtClick(Sender: TObject);
    procedure btnExportAsUnicodeTextClick(Sender: TObject);
    procedure btnExportAsCSVClick(Sender: TObject);
    procedure btnExportAsHTMLClick(Sender: TObject);
    procedure btnExportAsRTFClick(Sender: TObject);
    procedure btnExportAsXLSClick(Sender: TObject);
    procedure btnExportAsOLEXLSClick(Sender: TObject);
    procedure btnImportAsTXTClick(Sender: TObject);
    procedure btnImportAsUnicodeTextClick(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses Unit1;

{$R *.lfm}

constructor TfrImportExport.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Panel1.DoubleBuffered := True;
//  if Form1.PixelsPerInch <> 96 then
//    ScaleBy(Form1.PixelsPerInch, 96);
end;

procedure TfrImportExport.btnExportAsCSVClick(Sender: TObject);
begin
  SaveDialog1.Filter := 'Text file|*.csv';
  SaveDialog1.DefaultExt := 'csv';

  if SaveDialog1.Execute then
    begin
      SaveDBGridEhToExportFile(TDBGridEhExportAsCSV, DBGridEh1, SaveDialog1.FileName, RBSaveAll.Checked);

      if MessageDlg('File is saved.'#13'Do you want to open file "' + SaveDialog1.FileName + '" ?',
        mtConfirmation, [mbYes, mbNo], 0) = mrYes
      then
         OpenDocument(PChar(SaveDialog1.FileName)); { *Converted from ShellExecute* }
    end;
end;

procedure TfrImportExport.btnExportAsHTMLClick(Sender: TObject);
begin
  SaveDialog1.Filter := 'Text file|*.html';
  SaveDialog1.DefaultExt := 'html';

  if SaveDialog1.Execute then
    begin
      SaveDBGridEhToExportFile(TDBGridEhExportAsHTML, DBGridEh1, SaveDialog1.FileName, RBSaveAll.Checked);

      if MessageDlg('File is saved.'#13'Do you want to open file "' + SaveDialog1.FileName + '" ?',
        mtConfirmation, [mbYes, mbNo], 0) = mrYes
      then
         OpenDocument(PChar(SaveDialog1.FileName)); { *Converted from ShellExecute* }
    end;
end;

procedure TfrImportExport.btnExportAsOLEXLSClick(Sender: TObject);
begin
  SaveDialog1.Filter := 'Text file|*.xls';
  SaveDialog1.DefaultExt := 'xls';

  if SaveDialog1.Execute then
    begin
      SaveDBGridEhToExportFile(TDBGridEhExportAsOLEXLS, DBGridEh1, SaveDialog1.FileName, RBSaveAll.Checked);

      if MessageDlg('File is saved.'#13'Do you want to open file "' + SaveDialog1.FileName + '" ?',
        mtConfirmation, [mbYes, mbNo], 0) = mrYes
      then
         OpenDocument(PChar(SaveDialog1.FileName)); { *Converted from ShellExecute* }
    end;
end;

procedure TfrImportExport.btnExportAsRTFClick(Sender: TObject);
begin
  SaveDialog1.Filter := 'Text file|*.rtf';
  SaveDialog1.DefaultExt := 'rtf';

  if SaveDialog1.Execute then
    begin
      SaveDBGridEhToExportFile(TDBGridEhExportAsRTF, DBGridEh1, SaveDialog1.FileName, RBSaveAll.Checked);

      if MessageDlg('File is saved.'#13'Do you want to open file "' + SaveDialog1.FileName + '" ?',
        mtConfirmation, [mbYes, mbNo], 0) = mrYes
      then
         OpenDocument(PChar(SaveDialog1.FileName)); { *Converted from ShellExecute* }
    end;
end;

procedure TfrImportExport.btnExportAsTxtClick(Sender: TObject);
begin
  SaveDialog1.Filter := 'Text file|*.txt';
  SaveDialog1.DefaultExt := 'txt';

  if SaveDialog1.Execute then
    begin
      SaveDBGridEhToExportFile(TDBGridEhExportAsText, DBGridEh1, SaveDialog1.FileName, RBSaveAll.Checked);

      if MessageDlg('File is saved.'#13'Do you want to open file "' + SaveDialog1.FileName + '" ?',
        mtConfirmation, [mbYes, mbNo], 0) = mrYes
      then
         OpenDocument(PChar(SaveDialog1.FileName)); { *Converted from ShellExecute* }
    end;
end;

procedure TfrImportExport.btnExportAsUnicodeTextClick(Sender: TObject);
begin
  SaveDialog1.Filter := 'Text file|*.txt';
  SaveDialog1.DefaultExt := 'txt';

  if SaveDialog1.Execute then
    begin
      SaveDBGridEhToExportFile(TDBGridEhExportAsUnicodeText, DBGridEh1, SaveDialog1.FileName, RBSaveAll.Checked);

      if MessageDlg('File is saved.'#13'Do you want to open file "' + SaveDialog1.FileName + '" ?',
        mtConfirmation, [mbYes, mbNo], 0) = mrYes
      then
         OpenDocument(PChar(SaveDialog1.FileName)); { *Converted from ShellExecute* }
    end;
end;

procedure TfrImportExport.btnExportAsXLSClick(Sender: TObject);
begin
  SaveDialog1.Filter := 'Text file|*.xls';
  SaveDialog1.DefaultExt := 'xls';

  if SaveDialog1.Execute then
    begin
      SaveDBGridEhToExportFile(TDBGridEhExportAsXLS, DBGridEh1, SaveDialog1.FileName, RBSaveAll.Checked);

      if MessageDlg('File is saved.'#13'Do you want to open file "' + SaveDialog1.FileName + '" ?',
        mtConfirmation, [mbYes, mbNo], 0) = mrYes
      then
         OpenDocument(PChar(SaveDialog1.FileName)); { *Converted from ShellExecute* }
    end;
end;

procedure TfrImportExport.btnImportAsTXTClick(Sender: TObject);
begin
  OpenDialog1.Filter := 'Text file|*.txt';
  OpenDialog1.DefaultExt := 'txt';

  if OpenDialog1.Execute then
    LoadDBGridEhFromImportFile(TDBGridEhImportAsText, DBGridEh1, OpenDialog1.FileName, RBSaveAll.Checked);
end;

procedure TfrImportExport.btnImportAsUnicodeTextClick(Sender: TObject);
begin
  OpenDialog1.Filter := 'Text file|*.txt';
  OpenDialog1.DefaultExt := 'txt';

  if OpenDialog1.Execute then
    LoadDBGridEhFromImportFile(TDBGridEhImportAsUnicodeText, DBGridEh1, OpenDialog1.FileName, RBSaveAll.Checked);
end;

procedure TfrImportExport.PaintBox1Paint(Sender: TObject);
begin
  Form1.FillFrameTopPanel(PaintBox1.Canvas, Rect(0, 0, PaintBox1.Width, PaintBox1.Height));

  PaintBox1.Canvas.Pen.Color := StyleServices.GetSystemColor(clBtnShadow);
  PaintBox1.Canvas.Polyline(
    [Point(0, PaintBox1.Height-1),
     Point(PaintBox1.Width, PaintBox1.Height-1)]);
end;

end.
