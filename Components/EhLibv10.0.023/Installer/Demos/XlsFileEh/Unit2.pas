{*******************************************************}
{                                                       }
{  This Demo shows how to use TXlsMemFileEh class       }
{  to create Xlsx files from scratch                    }
{                                                       }
{*******************************************************}

unit Unit2;

{$I EhLib.Inc}

interface

uses
  Windows, Messages, SysUtils, Variants, Graphics,
{$IFDEF EH_LIB_17} System.UITypes, {$ENDIF}
  ShellAPI, XlsMemFilesEh, DBGridEhImpExp, DBVertGridEhImpExp,
  Forms, Dialogs, DBGridEhGrouping, ToolCtrlsEh, EhLibMTE,
  DBGridEhToolCtrls, DynVarsEh, MemTableDataEh, Db, MemTableEh,
  DBVertGridsEh, EhLibVCL, GridsEh, DBAxisGridsEh, DBGridEh, ComCtrls,
  StdCtrls, Controls, ExtCtrls, Classes, DBCtrlsEh, Mask;

type
  TForm2 = class(TForm)
    qrVendors: TMemTableEh;
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
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    DBGridEh1: TDBGridEh;
    DBVertGridEh1: TDBVertGridEh;
    DBEditEh1: TDBEditEh;
    DBEditEh2: TDBEditEh;
    tbSourceCode: TTabSheet;
    DBRichEditEh1: TDBRichEditEh;
    PageControl2: TPageControl;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    Panel2: TPanel;
    PaintBox1: TPaintBox;
    Label1: TLabel;
    btnExportAsXlsx: TButton;
    CheckBox1: TCheckBox;
    Label2: TLabel;
    btnImportModifyExport: TButton;
    CheckBox2: TCheckBox;
    procedure btnExportAsXlsxClick(Sender: TObject);
    procedure btnImportModifyExportClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure ExportWorksheet1(Sheet: TXlsWorksheetEh);
    procedure ExportWorksheet2(Sheet: TXlsWorksheetEh; Index: Integer);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.FormCreate(Sender: TObject);
begin
  PageControl2.ActivePageIndex := 0;
end;

procedure TForm2.btnExportAsXlsxClick(Sender: TObject);
var
  xlsFile: TXlsMemFileEh;
  Path: String;
begin
  GetDir(0, Path);
  Path := Path + '\TestXlsFile.xlsx';
  xlsFile := TXlsMemFileEh.Create;
  xlsFile.Workbook.Worksheets[0].Name := 'DBGrid';
  xlsFile.Workbook.AddWorksheet('VertGrid');

  ExportWorksheet1(xlsFile.Workbook.Worksheets[0]);
  ExportWorksheet2(xlsFile.Workbook.Worksheets[1], 0);

  xlsFile.SaveToFile(Path);

  xlsFile.Free;

  if (CheckBox1.Checked) then
    ShellExecute(Application.Handle, 'Open', PChar(Path), nil, nil, SW_SHOWNORMAL)
  else
    ShellExecute(Application.Handle, 'Open', 'explorer.exe', PChar('/select,"' + Path + '"'), nil, SW_SHOWNORMAL);
end;

procedure TForm2.btnImportModifyExportClick(Sender: TObject);
var
  xlsFile: TXlsMemFileEh;
  Path: String;
  Idx: Integer;
begin
  GetDir(0, Path);
  Path := Path + '\TestXlsFile.xlsx';
  xlsFile := TXlsMemFileEh.Create;
  xlsFile.LoadFromFile(Path);

  Idx := xlsFile.Workbook.WorksheetCount;
  xlsFile.Workbook.AddWorksheet('VertGrid-'+IntToStr(Idx));

  ExportWorksheet2(xlsFile.Workbook.Worksheets[Idx], Idx);

  xlsFile.SaveToFile(Path);

  xlsFile.Free;

  if (CheckBox2.Checked) then
    ShellExecute(Application.Handle, 'Open', PChar(Path), nil, nil, SW_SHOWNORMAL)
  else
    ShellExecute(Application.Handle, 'Open', 'explorer.exe', PChar('/select,"' + Path + '"'), nil, SW_SHOWNORMAL);
end;

procedure TForm2.ExportWorksheet1(Sheet: TXlsWorksheetEh);
var
  i: Integer;
  cr: IXlsFileCellsRangeEh;
  TitleMarix: TDBGridMultiTitleExportNodeMatrixEh;
  ci, ri: Integer;
  ti: TDBGridMultiTitleExportNodeEh;

begin
  Sheet.Columns[0].Width := Sheet.Columns.ScreenToXlsWidth(DBGridEh1.Columns[0].Width);
  Sheet.Columns[1].Width := Sheet.Columns.ScreenToXlsWidth(DBGridEh1.Columns[1].Width);
  Sheet.Columns[2].Width := Sheet.Columns.ScreenToXlsWidth(DBGridEh1.Columns[2].Width);
  Sheet.Columns[3].Width := Sheet.Columns.ScreenToXlsWidth(DBGridEh1.Columns[3].Width);
  Sheet.Columns[4].Width := Sheet.Columns.ScreenToXlsWidth(DBGridEh1.Columns[4].Width);
  Sheet.Columns[5].Width := Sheet.Columns.ScreenToXlsWidth(DBGridEh1.Columns[5].Width);

  if (DBGridEh1.TitleParams.MultiTitle) then
  begin
    CalcMultiTitleMatrix(DBGridEh1, TitleMarix);
    for ci := 0 to Length(TitleMarix)-1 do
    begin
      for ri := 0 to Length(TitleMarix[ci])-1 do
      begin
        ti := TitleMarix[ci, ri];
        if (ti <> nil) then
        begin
          Sheet.Cells[ci, ri + 1].Value := TitleMarix[ci, ri].Text;
          if (ti.MergeColCount > 0) or (ti.MergeRowCount > 0) then
          begin
            Sheet.MergeCell(ci, ri + 1, ti.MergeColCount, ti.MergeRowCount);
          end;
        end;
      end;
    end;
    FreeMultiTitleMatrix(TitleMarix);
  end else
  begin
    Sheet.Cells[0, 3].Value := DBGridEh1.Columns[0].Title.Caption;
    Sheet.Cells[1, 3].Value := DBGridEh1.Columns[1].Title.Caption;
    Sheet.Cells[2, 3].Value := DBGridEh1.Columns[2].Title.Caption;
    Sheet.Cells[3, 3].Value := DBGridEh1.Columns[3].Title.Caption;
    Sheet.Cells[4, 3].Value := DBGridEh1.Columns[4].Title.Caption;
    Sheet.Cells[5, 3].Value := DBGridEh1.Columns[5].Title.Caption;
    Sheet.Cells[6, 3].Value := DBGridEh1.Columns[6].Title.Caption;
  end;

  //Caption
  Sheet.Cells[0, 0].Value := DBEditEh1.Text;
  cr := Sheet.GetCellsRange(0,0,0,0);
  cr.Font.Size := 24;
  cr.HorzAlign := chaCenterEh;
  cr.ApplyChages;
  Sheet.MergeCell(0,0, 6,0);

  //Export Data rows
  i := 0;
  mtQuery1.DisableControls;
  mtQuery1.First;
  while not mtQuery1.Eof do
  begin
    Sheet.Cells[0, i + 4].Value := DBGridEh1.Columns[0].Field.Value;
    Sheet.Cells[1, i + 4].Value := DBGridEh1.Columns[1].Field.Value;
    Sheet.Cells[2, i + 4].Value := DBGridEh1.Columns[2].Field.Value;

    Sheet.Cells[3, i + 4].Value := DBGridEh1.Columns[3].Field.Value;
    Sheet.Cells[4, i + 4].Value := DBGridEh1.Columns[4].Field.Value;
    Sheet.Cells[5, i + 4].Value := DBGridEh1.Columns[5].Field.Value;
    Sheet.Cells[6, i + 4].Value := DBGridEh1.Columns[6].Field.Value;

    i := i + 1;
    mtQuery1.Next;
  end;
  mtQuery1.First;
  mtQuery1.EnableControls;

  // Title formats
  cr := Sheet.GetCellsRange(0,1,6,3);
  cr.Border.Top.Style := clsMediumEh;
  cr.Border.Bottom.Style := clsMediumEh;
  cr.Border.Left.Style := clsMediumEh;
  cr.Border.Right.Style := clsMediumEh;

  cr.Border.InsideHorizontal.Style := clsThinEh;
  cr.Border.InsideVertical.Style := clsThinEh;

  cr.VertAlign := cvaCenterEh;
  cr.HorzAlign := chaCenterEh;

  cr.ApplyChages;

  cr := Sheet.GetCellsRange(6,1,6,1);
  cr.Rotation := 90;
  cr.ApplyChages;

  //Data formats
  cr := Sheet.GetCellsRange(0,4,6,i+4);
  cr.Border.Top.Style := clsMediumEh;
  cr.Border.Bottom.Style := clsMediumEh;
  cr.Border.Left.Style := clsMediumEh;
  cr.Border.Right.Style := clsMediumEh;

  cr.Border.InsideHorizontal.Style := clsThinEh;
  cr.Border.InsideVertical.Style := clsThinEh;

  cr.ApplyChages;

  //Data Columns formats
  cr := Sheet.GetCellsRange(0,4,0,i+4);
  cr.NumberFormat := '"VN "0000';
  cr.ApplyChages;

  cr := Sheet.GetCellsRange(2,4,2,i+4);
  cr.NumberFormat := '"PN-"00000';
  cr.ApplyChages;

  cr := Sheet.GetCellsRange(4,4,4,i+4);
  cr.NumberFormat := '#,##0.0000';
  cr.ApplyChages;

  //Footer values
  Sheet.Cells[0, i+4].Value := 'Sum of cost';
  Sheet.Cells[1, i+4].Formula := 'SUM(E5:' + 'E' + IntToStr(i+3) + ')';
  cr := Sheet.GetCellsRange(1,i+4,1,i+4);
  cr.NumberFormat := '#,##0.0000';
  cr.ApplyChages;

  Sheet.Cells[3, i+4].Value := 'Sum';
  Sheet.Cells[4, i+4].Formula := 'SUM(E5:' + 'E' + IntToStr(i+3) + ')';
  cr := Sheet.GetCellsRange(4,i+4,4,i+4);
  cr.NumberFormat := '#,##0.0000';
  cr.ApplyChages;

  //Footer Format
  cr := Sheet.GetCellsRange(0,i+4,6,i+4);
  cr.Border.Top.Style := clsMediumEh;
  cr.Border.Bottom.Style := clsMediumEh;
  cr.Border.Left.Style := clsMediumEh;
  cr.Border.Right.Style := clsMediumEh;
  cr.Font.IsBold := True;
  cr.ApplyChages;

  //Final
  Sheet.FrozenRowCount := 4;
  Sheet.AutoFilterRange.FromCol := 0;
  Sheet.AutoFilterRange.FromRow := 3;
  Sheet.AutoFilterRange.ToCol := 6;
  Sheet.AutoFilterRange.ToRow := i+4-1;

end;

procedure TForm2.ExportWorksheet2(Sheet: TXlsWorksheetEh; Index: Integer);
var
  cr: IXlsFileCellsRangeEh;
  i: Integer;
  AFont: TFont;
begin
  Sheet.Columns[0].Width := Sheet.Columns.ScreenToXlsWidth(DBVertGridEh1.ColWidths[0]);
  Sheet.Columns[1].Width := Sheet.Columns.ScreenToXlsWidth(DBVertGridEh1.ColWidths[1]);

  Sheet.Cells[0, 0].Value := DBEditEh2.Text;
  if (Index > 0) then
    Sheet.Cells[0, 0].Value := Sheet.Cells[0, 0].Value + ' - ' + IntToStr(Index);

  cr := Sheet.GetCellsRange(0,0,0,0);
  cr.Font.Size := 24;
  cr.ApplyChages;

  for i := 0 to DBVertGridEh1.VisibleFieldRowCount - 1 do
  begin
    //Label Cell
    Sheet.Cells[0, i+1].Value := DBVertGridEh1.VisibleFieldRow[i].RowLabel.Caption;
    cr := Sheet.GetCellsRange(0, i+1, 0, i+1);
    cr.Fill.Color := DBVertGridEh1.VisibleFieldRow[i].RowLabel.Color;

    AFont := DBVertGridEh1.VisibleFieldRow[i].RowLabel.Font;
    cr.Font.Name := AFont.Name;
    cr.Font.Size := AFont.Size;
    cr.Font.Color := AFont.Color;
    cr.Font.IsBold := fsBold in AFont.Style;
    cr.Font.IsItalic := fsItalic in AFont.Style;
    cr.Font.IsUnderline := fsUnderline in AFont.Style;

    cr.ApplyChages;

    //Data Cell
    Sheet.Cells[1, i+1].Value := DBVertGridEh1.VisibleFieldRow[i].Field.Value;
    cr := Sheet.GetCellsRange(1, i+1, 1, i+1);
    cr.Fill.Color := DBVertGridEh1.VisibleFieldRow[i].Color;

    AFont := DBVertGridEh1.VisibleFieldRow[i].Font;
    cr.Font.Name := AFont.Name;
    cr.Font.Size := AFont.Size;
    cr.Font.Color := AFont.Color;
    cr.Font.IsBold := fsBold in AFont.Style;
    cr.Font.IsItalic := fsItalic in AFont.Style;
    cr.Font.IsUnderline := fsUnderline in AFont.Style;

    cr.HorzAlign := AlignmentToXlsFileCellHorzAlign(DBVertGridEh1.VisibleFieldRow[i].Alignment);

    cr.ApplyChages;
  end;

  cr := Sheet.GetCellsRange(0,1,1,DBVertGridEh1.VisibleFieldRowCount);
  cr.Border.Top.Style := clsMediumEh;
  cr.Border.Bottom.Style := clsMediumEh;
  cr.Border.Left.Style := clsMediumEh;
  cr.Border.Right.Style := clsMediumEh;

  cr.Border.InsideHorizontal.Style := clsThinEh;
  cr.Border.InsideVertical.Style := clsThinEh;

  cr.ApplyChages;

  cr := Sheet.GetCellsRange(1,1,1,DBVertGridEh1.VisibleFieldRowCount);
  cr.WrapText := True;
  cr.HorzAlign := chaLeftEh;
  cr.ApplyChages;

  cr.ApplyChages;
end;

initialization
//  System.ReportMemoryLeaksOnShutdown := True;
end.

