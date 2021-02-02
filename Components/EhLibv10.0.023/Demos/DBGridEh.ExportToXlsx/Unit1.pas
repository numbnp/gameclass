unit Unit1;

{$I EhLib.Inc}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, ShellAPI,
  Grids, MemTableDataEh, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls,
{$IFDEF EH_LIB_17} System.UITypes, {$ENDIF}
  DBGridEhImpExp, XlsMemFilesEh, DBGridEhXlsMemFileExporters,
  DynVarsEh, Db, MemTableEh, EhLibVCL, GridsEh, DBAxisGridsEh, DBGridEh;

type
  TForm1 = class(TForm)
    Button1: TButton;
    MTE: TMemTableEh;
    DataSource1: TDataSource;
    DBGridEh: TDBGridEh;
    Label1: TLabel;
    Button2: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure DBGridEhColumns4GetCellParams(Sender: TObject; EditMode: Boolean;
      Params: TColCellParamsEh);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses Unit4;

procedure TForm1.Button1Click(Sender: TObject);
var
  Path:string;
begin
  GetDir(0,Path);
  ExportDBGridEhToXlsx(DBGridEh,Path+'\File1.xlsx',[]);
  ShellExecute(Handle, nil, PChar(Path + '\File1.xlsx'), nil, nil, SW_SHOWNORMAL);
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  Path: String;
  FileName: String;
  XlsFile: TXlsMemFileEh;
begin
  GetDir(0, Path);
  FileName := Path + '\DBGridEhAsXlsx.Xlsx';
  XlsFile := TXlsMemFileEh.Create;
  ExportDBGridEhToXlsMemFile(DBGridEh, XlsFile);
  XlsFile.SaveToFile(FileName);
  XlsFile.Free;

  ShellExecute(Handle, nil, PChar(FileName), nil, nil, SW_SHOWNORMAL);
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  Path: String;
  FileName: String;
  XlsFile: TXlsMemFileEh;
  Exporter: TDBGridEhToXlsMemFileExporter;
  cr: IXlsFileCellsRangeEh;
begin
  if (Form4.ShowModal <> mrOk) then Exit;

  GetDir(0, Path);
  FileName := Path + '\DBGridEhAsXlsx.Xlsx';
  XlsFile := TXlsMemFileEh.Create;

  Exporter := TDBGridEhToXlsMemFileExporter.Create;

  if Form4.cbGridCaption.Checked then
  begin
    XlsFile.Workbook.Worksheets[0].Cells[0, 0].Value := Form4.EditCaption.Text;
    cr := XlsFile.Workbook.Worksheets[0].GetCellsRange(0, 0, 0, 0);
    cr.Font.Size := 24;
    cr.ApplyChages;
    Exporter.FromRow := 1;
  end else
  begin
    Exporter.FromRow := 0;
  end;

  Exporter.XlsFile := XlsFile;
  Exporter.Grid := DBGridEh;
  Exporter.ExportOptions.IsExportSelecting := False;

  Exporter.ExportOptions.IsExportTitle := Form4.cbExportTitle.Checked;
  Exporter.ExportOptions.IsExportFooter := Form4.cbExportFooter.Checked;
  Exporter.ExportOptions.IsExportFontFormat := Form4.cbFontFormat.Checked;
  Exporter.ExportOptions.IsExportFillColor := Form4.cbFillColors.Checked;
  Exporter.ExportOptions.IsCreateAutoFilter := Form4.cbAutoFilter.Checked;
  Exporter.ExportOptions.IsExportFreezeZones := Form4.cbFreezeTitleRow.Checked;
  Exporter.ExportOptions.IsFooterSumsAsFormula := Form4.cbSumsAsFormula.Checked;
  Exporter.ExportOptions.IsExportDisplayFormat := Form4.cbDisplayFormat.Checked;

  Exporter.ExportGrid;

  if Form4.cbSubcation.Checked then
  begin
    XlsFile.Workbook.Worksheets[0].Cells[0, Exporter.FinishRow].Value := Form4.EditSubcaption.Text;
  end;

  Exporter.Free;

  XlsFile.SaveToFile(FileName);
  XlsFile.Free;

  ShellExecute(Handle, nil, PChar(FileName), nil, nil, SW_SHOWNORMAL);
end;

procedure TForm1.DBGridEhColumns4GetCellParams(Sender: TObject;
  EditMode: Boolean; Params: TColCellParamsEh);
begin
  if TColumnEh(Sender).Field.AsFloat > 10000000 then
    Params.Font.Style := Params.Font.Style + [fsBold];
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Caption := Caption + ' ' + EhLibVerInfo + ' ' + EhLibBuildInfo;
end;

end.
