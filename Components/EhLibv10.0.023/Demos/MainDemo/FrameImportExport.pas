unit FrameImportExport;

{$I EhLib.Inc}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Themes, EhLibVCL,
  {$IFDEF EH_LIB_6} Types, {$ENDIF}
  {$IFDEF EH_LIB_16} System.UITypes, {$ENDIF}
  Dialogs, MemTableDataEh, Db, ADODB, DBGridEhGrouping, ToolCtrlsEh,
  DBGridEhToolCtrls, ExtCtrls, GridsEh, DBGridEh, DataDriverEh, ADODataDriverEh,
  MemTableEh, DBGridEhImpExp, StdCtrls, ShellAPI, DBAxisGridsEh, DynVarsEh;

type
  TfrImportExport = class(TFrame)
    qrVendors: TMemTableEh;
    ddrVendors: TADODataDriverEh;
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
    ddrData1: TADODataDriverEh;
    DBGridEh1: TDBGridEh;
    SaveDialog1: TSaveDialog;
    Panel1: TPanel;
    RBSaveAll: TRadioButton;
    RadioButton2: TRadioButton;
    btnExportAsTxt: TButton;
    btnExportAsHTML: TButton;
    btnExportAsRTF: TButton;
    btnExportAsOLEXLS: TButton;
    btnImportAsTXT: TButton;
    btnImportAsUnicodeText: TButton;
    OpenDialog1: TOpenDialog;
    Panel2: TPanel;
    PaintBox1: TPaintBox;
    Label1: TLabel;
    btnExportAsXlsx: TButton;
    procedure btnExportAsTxtClick(Sender: TObject);
    procedure btnExportAsHTMLClick(Sender: TObject);
    procedure btnExportAsRTFClick(Sender: TObject);
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

uses Unit1,
     UnitDBGridEhTextExportOptions,
     DBGridEhXlsMemFileExporters,
     UnitXlsxExportOptions;

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

procedure TfrImportExport.btnExportAsHTMLClick(Sender: TObject);
var
  Path: string;
  FileName: string;
begin
  GetDir(0,Path);
  FileName := Path + '\DBGridEh1Export.Html';

  SaveDBGridEhToExportFile(TDBGridEhExportAsHTML, DBGridEh1, FileName, RBSaveAll.Checked);
  ShellExecute(Handle, nil, PChar(FileName), nil, nil, SW_SHOWNORMAL);
end;

procedure TfrImportExport.btnExportAsRTFClick(Sender: TObject);
var
  Path: string;
  FileName: string;
begin
  GetDir(0,Path);
  FileName := Path + '\DBGridEh1Export.Rtf';

  SaveDBGridEhToExportFile(TDBGridEhExportAsRTF, DBGridEh1, FileName, RBSaveAll.Checked);
  ShellExecute(Handle, nil, PChar(FileName), nil, nil, SW_SHOWNORMAL);
end;

procedure TfrImportExport.btnExportAsOLEXLSClick(Sender: TObject);
var
  Path: string;
  FileName: string;
begin
  GetDir(0,Path);
  FileName := Path + '\DBGridEh1Export.Xlsx';

  SaveDBGridEhToExportFile(TDBGridEhExportAsOLEXLS, DBGridEh1, FileName, RBSaveAll.Checked);
end;

procedure TfrImportExport.btnExportAsTxtClick(Sender: TObject);
var
  Grid: TDBGridEh;
  Path: string;
  FileName: string;
  ExportOptions: TDBGridEhTextExportOptions;
  eForm: TFormDBGridEhTextExportOptions;
begin
  Grid := DBGridEh1;

  if (FormDBGridEhTextExportOptions = nil) then
    FormDBGridEhTextExportOptions := TFormDBGridEhTextExportOptions.Create(Application);

  if (FormDBGridEhTextExportOptions.ShowModal <> mrOk) then Exit;

  eForm := FormDBGridEhTextExportOptions;
  ExportOptions := TDBGridEhTextExportOptions.Create;

  ExportOptions.IsExportTitle := eForm.CheBoxExportTitle.Checked;
  ExportOptions.IsExportFooter := eForm.CheBoxExportFooter.Checked;
  ExportOptions.Encoding := eForm.GetEncoding;
  ExportOptions.WriteBOM := eForm.CheBoxWriteBOM.Checked;
  ExportOptions.QuoteChar := eForm.GetTextQuoteChar;
  ExportOptions.CellDelimiter := eForm.GetCellDelimiter;
  ExportOptions.LineDelimiter := eForm.GetLineDelimiter;
  ExportOptions.TrailingLineDelimiter := eForm.CheBoxTrailingLineDelimiter.Checked;
  ExportOptions.UseEditFormat := eForm.GetUseEditFormat;

  GetDir(0,Path);
  FileName := Path + '\DBGridEh1Export.Txt';

  SaveDBGridEhToTextFile(Grid, FileName, ExportOptions);
  ExportOptions.Free;

  ShellExecute(Handle, nil, PChar(FileName), nil, nil, SW_SHOWNORMAL);
end;

procedure TfrImportExport.btnExportAsXlsxClick(Sender: TObject);
var
  Path: String;
  FileName: String;
  ExportOptions: TDBGridEhXlsMemFileExportOptions;
begin

  if (FormXlsxExportOptions = nil) then
    FormXlsxExportOptions := TFormXlsxExportOptions.Create(Application);

  if (FormXlsxExportOptions.ShowModal <> mrOk) then Exit;

  GetDir(0, Path);
  FileName := Path + '\DBGridEhAsXlsx.Xlsx';

  ExportOptions := TDBGridEhXlsMemFileExportOptions.Create;
  ExportOptions.IsExportSelecting := False;
  ExportOptions.IsExportTitle := FormXlsxExportOptions.cbExportTitle.Checked;
  ExportOptions.IsExportFooter := FormXlsxExportOptions.cbExportFooter.Checked;
  ExportOptions.IsExportFontFormat := FormXlsxExportOptions.cbFontFormat.Checked;
  ExportOptions.IsExportFillColor := FormXlsxExportOptions.cbFillColors.Checked;
  ExportOptions.IsCreateAutoFilter := FormXlsxExportOptions.cbAutoFilter.Checked;
  ExportOptions.IsExportFreezeZones := FormXlsxExportOptions.cbFreezeTitleRow.Checked;
  ExportOptions.IsFooterSumsAsFormula := FormXlsxExportOptions.cbSumsAsFormula.Checked;
  ExportOptions.IsExportDisplayFormat := FormXlsxExportOptions.cbDisplayFormat.Checked;
  ExportOptions.IsExportDataGrouping := FormXlsxExportOptions.cbDataGrouping.Checked;
  ExportOptions.SheetName := FormXlsxExportOptions.EditSheetName.Text;

  if FormXlsxExportOptions.cbGridCaption.Checked then
  begin
    ExportOptions.GridHeaderText := FormXlsxExportOptions.EditCaption.Text;
    ExportOptions.GridHeaderFont := DBGridEh1.Font;
    ExportOptions.GridHeaderFont.Size := 24;
  end;

  if FormXlsxExportOptions.cbSubcation.Checked then
  begin
    ExportOptions.GridFooterText := FormXlsxExportOptions.EditSubcaption.Text
  end;

  ExportDBGridEhToXlsx(DBGridEh1, FileName, ExportOptions);

  ExportOptions.Free;

  if IsOLEObjectAvailable('Excel.Application') then
  begin
    ShellExecute(Handle, nil, PChar(FileName), nil, nil, SW_SHOWNORMAL)
  end else
  begin
    ShowMessage('Looks like MS Excel is not installed.');
    ShellExecute(0, nil, PChar('explorer.exe'), PChar('/select,' + FileName), nil, SW_SHOWNORMAL)
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
