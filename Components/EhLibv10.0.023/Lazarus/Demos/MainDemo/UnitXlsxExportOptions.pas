unit UnitXlsxExportOptions;

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, LMessages, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, ExtCtrls,
  DBCtrlsEh, DBGridsEh, DBGridEhXlsMemFileExporters,
  MaskEdit;

type
  TFormXlsxExportOptions = class(TForm)
    cbExportTitle: TDBCheckBoxEh;
    Button1: TButton;
    Button2: TButton;
    Bevel1: TBevel;
    cbFontFormat: TDBCheckBoxEh;
    cbFillColors: TDBCheckBoxEh;
    cbAutoFilter: TDBCheckBoxEh;
    cbExportFooter: TDBCheckBoxEh;
    cbFreezeTitleRow: TDBCheckBoxEh;
    EditCaption: TDBEditEh;
    EditSubcaption: TDBEditEh;
    cbGridCaption: TDBCheckBoxEh;
    cbSubcation: TDBCheckBoxEh;
    cbSumsAsFormula: TDBCheckBoxEh;
    cbDisplayFormat: TDBCheckBoxEh;
    EditSheetName: TDBEditEh;
    cbDataGrouping: TDBCheckBoxEh;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure InitContolsState(Grid: TCustomDBGridEh; Options: TDBGridEhXlsMemFileExportOptions);
  end;

var
  FormXlsxExportOptions: TFormXlsxExportOptions;

implementation

{$R *.lfm}

{ TForm4 }

procedure TFormXlsxExportOptions.InitContolsState(Grid: TCustomDBGridEh; Options: TDBGridEhXlsMemFileExportOptions);
begin
//  cbExportTitle.Checked := Options.IsExportTitle;
//  cbDisplayFormat.Checked := Options.IsExportDisplayFormat;
//  cbFontFormat.Checked := Options.IsExportFontFormat;
//  cbFillColors.Checked := Options.IsExportFillColor;
//  cbAutoFilter.Checked := Options.IsCreateAutoFilter;
//  cbFreezeTitleRow.Checked := Options.IsExportFreezeZones;
//  cbExportFooter.Checked := Options.IsExportFooter;
//  cbSumsAsFormula.Checked := Options.IsFooterSumsAsFormula;
//  cbDataGrouping.Checked := Options.IsExportDataGrouping;
//  EditCaption.Text := Options.GridHeaderText;
//  EditSubcaption.Text := Options.GridFooterText;
//  EditSheetName.Text := Options.SheetName;
end;

end.
