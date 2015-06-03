unit Unit1;

{$I EHLIB.INC}

interface

uses
//  {$IFNDEF EH_LIB_16}
    XPMan,
//  {$ENDIF}
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PivotGridToolsEh, StdCtrls, ExtCtrls, MemTableDataEh, Db,
  MemTableEh, PivotGridsEh, EhLibVCL, GridsEh, DBGridEhGrouping,
  ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, DBAxisGridsEh, DBGridEh,
  ComCtrls, Mask, DBCtrlsEh;

type
  TForm1 = class(TForm)
    PivotGridToolBoxEh1: TPivotGridToolBoxEh;
    Panel1: TPanel;
    bAddFields: TButton;
    bLoadSourceData: TButton;
    Button4: TButton;
    bDefDefaultStruct: TButton;
    Splitter1: TSplitter;
    PivotDataSourceEh1: TPivotDataSourceEh;
    MemTableEh1: TMemTableEh;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    PivotGridEh1: TPivotGridEh;
    DBGridEh1: TDBGridEh;
    DataSource1: TDataSource;
    DBNumberEditEh1: TDBNumberEditEh;
    procedure bAddFieldsClick(Sender: TObject);
    procedure bDefDefaultStructClick(Sender: TObject);
    procedure bLoadSourceDataClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PivotGridEh1DrawDataCell(Grid: TCustomPivotGridEh; ACol,
      ARow: Integer; var Params: TPivotCellDrawParamsEh;
      var Processed: Boolean);
    procedure DBNumberEditEh1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.bAddFieldsClick(Sender: TObject);
begin
  MemTableEh1.Open;
  PivotDataSourceEh1.PivotFields.RebuildPivotFields;
  bAddFields.Caption := 'Recreate fields from DataSet';
end;

procedure TForm1.bDefDefaultStructClick(Sender: TObject);
begin
  PivotDataSourceEh1.ColumnFields.Clear;
  PivotDataSourceEh1.RowFields.Clear;
  PivotDataSourceEh1.ValueFieldDefs.Clear;

  PivotDataSourceEh1.ColumnFields.Add('PaymentMethod');
  PivotDataSourceEh1.RowFields.Add('ShipVIA');
  PivotDataSourceEh1.RowFields.Add('SaleDate.Year');
  with PivotDataSourceEh1.ValueFieldDefs.Add do
  begin
    PivotFieldName := 'AmountPaid';
    SumFunction := svtSumEh;
  end;
  bDefDefaultStruct.Caption := 'Assign default pivot structure'
end;

procedure TForm1.bLoadSourceDataClick(Sender: TObject);
begin
  MemTableEh1.Open;
  PivotDataSourceEh1.CreateAndFillSourceTable;
  MemTableEh1.Close;
  bLoadSourceData.Caption := 'Reload source data';
  DataSource1.DataSet := PivotDataSourceEh1.SourceTable;
  PageControl1.ActivePage := TabSheet2;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  if (PivotDataSourceEh1.ColumnFields.Count = 0) and
     (PivotDataSourceEh1.RowFields.Count = 0)
  then
    ShowMessage('Please, assign Column Fields and/or Row Fields to make Pivot Structure!')
  else
    PivotDataSourceEh1.BuildPivotData;
  PageControl1.ActivePage := TabSheet1;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  PivotGridEh1.DefaultColWidth := 100;
end;

procedure TForm1.PivotGridEh1DrawDataCell(Grid: TCustomPivotGridEh; ACol,
  ARow: Integer; var Params: TPivotCellDrawParamsEh;
  var Processed: Boolean);
begin
  if (Params.RowsGroupLevel = 0) and
     (Params.ColsGroupLevel = 0) and
     VarIsNumeric(Params.Value) and
     (Params.Value > DBNumberEditEh1.Value) then
  begin
    Params.SignType := pcstCircleEh;
    Params.SignFillColor := ApproachToColorEh(clRed, TPivotGridEh(Grid).Color, 50);
    Params.SignFrameColor := Params.SignFillColor;
  end;
end;

procedure TForm1.DBNumberEditEh1Change(Sender: TObject);
begin
  PivotGridEh1.Invalidate;
end;

initialization
  {$IFNDEF EH_LIB_16}
  DefFontData.Name := 'Tahoma';
  {$ENDIF}
end.

