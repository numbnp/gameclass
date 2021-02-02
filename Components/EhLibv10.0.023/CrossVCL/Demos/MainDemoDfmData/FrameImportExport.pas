unit FrameImportExport;

{$I EhLib.Inc}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Themes, EhLibVCL,
  {$IFDEF EH_LIB_6} Types, {$ENDIF}
  {$IFDEF EH_LIB_16} System.UITypes, {$ENDIF}
  Dialogs, MemTableDataEh, Db, DBGridEhGrouping, ToolCtrlsEh,
  DBGridEhToolCtrls, ExtCtrls, GridsEh, DBGridEh, DataDriverEh,
  MemTableEh, DBGridEhImpExp, StdCtrls, ShellAPI, DBAxisGridsEh, DynVarsEh;

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
    btnExportAsXlsx: TButton;
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
    procedure btnExportAsXlsxClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses Unit1;

{$R *.dfm}

constructor TfrImportExport.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Panel1.DoubleBuffered := True;
//  if Form1.PixelsPerInch <> 96 then
//    ScaleBy(Form1.PixelsPerInch, 96);

{$IFDEF EH_LIB_16} //- XE2 or higher
//OK
{$ELSE}
  btnExportAsXlsx.Enabled := False;
  btnExportAsXlsx.Caption := 'Xlsx file. For XE2 or higher.'
{$ENDIF}
end;

procedure TfrImportExport.btnExportAsCSVClick(Sender: TObject);
begin
  SaveDialog1.Filter := 'Csv file|*.csv';
  SaveDialog1.DefaultExt := 'csv';

  if SaveDialog1.Execute then
    begin
      SaveDBGridEhToExportFile(TDBGridEhExportAsCSV, DBGridEh1, SaveDialog1.FileName, RBSaveAll.Checked);

      if MessageDlg('File is saved.'#13'Do you want to open file "' + SaveDialog1.FileName + '" ?',
        mtConfirmation, [mbYes, mbNo], 0) = mrYes
      then
        ShellExecute(Handle, nil, PChar(SaveDialog1.FileName), nil, nil, SW_SHOWNORMAL);
    end;
end;

procedure TfrImportExport.btnExportAsHTMLClick(Sender: TObject);
begin
  SaveDialog1.Filter := 'Html file|*.html';
  SaveDialog1.DefaultExt := 'html';

  if SaveDialog1.Execute then
    begin
      SaveDBGridEhToExportFile(TDBGridEhExportAsHTML, DBGridEh1, SaveDialog1.FileName, RBSaveAll.Checked);

      if MessageDlg('File is saved.'#13'Do you want to open file "' + SaveDialog1.FileName + '" ?',
        mtConfirmation, [mbYes, mbNo], 0) = mrYes
      then
        ShellExecute(Handle, nil, PChar(SaveDialog1.FileName), nil, nil, SW_SHOWNORMAL);
    end;
end;

procedure TfrImportExport.btnExportAsOLEXLSClick(Sender: TObject);
begin
  SaveDialog1.Filter := 'Xls file|*.xls';
  SaveDialog1.DefaultExt := 'xls';

  if SaveDialog1.Execute then
    begin
{$IFDEF MSWINDOWS}
      SaveDBGridEhToExportFile(TDBGridEhExportAsOLEXLS, DBGridEh1, SaveDialog1.FileName, RBSaveAll.Checked);
{$ELSE}
      ShowMessage('Export As OLEXLS is not supported in Non Windows OS');
      Exit;
{$ENDIF}
      if MessageDlg('File is saved.'#13'Do you want to open file "' + SaveDialog1.FileName + '" ?',
        mtConfirmation, [mbYes, mbNo], 0) = mrYes
      then
        ShellExecute(Handle, nil, PChar(SaveDialog1.FileName), nil, nil, SW_SHOWNORMAL);
    end;
end;

procedure TfrImportExport.btnExportAsRTFClick(Sender: TObject);
begin
  SaveDialog1.Filter := 'Rtf file|*.rtf';
  SaveDialog1.DefaultExt := 'rtf';

  if SaveDialog1.Execute then
    begin
      SaveDBGridEhToExportFile(TDBGridEhExportAsRTF, DBGridEh1, SaveDialog1.FileName, RBSaveAll.Checked);

      if MessageDlg('File is saved.'#13'Do you want to open file "' + SaveDialog1.FileName + '" ?',
        mtConfirmation, [mbYes, mbNo], 0) = mrYes
      then
        ShellExecute(Handle, nil, PChar(SaveDialog1.FileName), nil, nil, SW_SHOWNORMAL);
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
        ShellExecute(Handle, nil, PChar(SaveDialog1.FileName), nil, nil, SW_SHOWNORMAL);
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
        ShellExecute(Handle, nil, PChar(SaveDialog1.FileName), nil, nil, SW_SHOWNORMAL);
    end;
end;

procedure TfrImportExport.btnExportAsXLSClick(Sender: TObject);
begin
  SaveDialog1.Filter := 'Xls file|*.xls';
  SaveDialog1.DefaultExt := 'xls';

  if SaveDialog1.Execute then
    begin
      SaveDBGridEhToExportFile(TDBGridEhExportAsXLS, DBGridEh1, SaveDialog1.FileName, RBSaveAll.Checked);

      if MessageDlg('File is saved.'#13'Do you want to open file "' + SaveDialog1.FileName + '" ?',
        mtConfirmation, [mbYes, mbNo], 0) = mrYes
      then
        ShellExecute(Handle, nil, PChar(SaveDialog1.FileName), nil, nil, SW_SHOWNORMAL);
    end;
end;

procedure TfrImportExport.btnExportAsXlsxClick(Sender: TObject);
begin
  SaveDialog1.Filter := 'Xlsx file|*.xlsx';
  SaveDialog1.DefaultExt := 'xlsx';

  if SaveDialog1.Execute then
    begin
      SaveDBGridEhToExportFile(TDBGridEhExportAsXlsx, DBGridEh1, SaveDialog1.FileName, RBSaveAll.Checked);

      if MessageDlg('File is saved.'#13'Do you want to open file "' + SaveDialog1.FileName + '" ?',
        mtConfirmation, [mbYes, mbNo], 0) = mrYes
      then
        ShellExecute(Handle, nil, PChar(SaveDialog1.FileName), nil, nil, SW_SHOWNORMAL);
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
