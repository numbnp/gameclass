unit FramePivotGrid;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, ExtCtrls, DBGridEhGrouping, ToolCtrlsEh,
  DBGridEhToolCtrls, DynVarsEh, MemTableDataEh, Db, MemTableEh,
  PivotGridsEh, DBAxisGridsEh, DBGridEh, EhLibVCL, GridsEh, ComCtrls, Mask,
  DBCtrlsEh, PivotGridToolsEh;

type
  TfrPivotGrid = class(TFrame)
    Panel1: TPanel;
    PaintBox1: TPaintBox;
    Label1: TLabel;
    Splitter1: TSplitter;
    PivotGridToolBoxEh1: TPivotGridToolBoxEh;
    Panel2: TPanel;
    bAddFields: TButton;
    bLoadSourceData: TButton;
    Button4: TButton;
    bDefDefaultStruct: TButton;
    DBNumberEditEh1: TDBNumberEditEh;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    PivotGridEh1: TPivotGridEh;
    TabSheet2: TTabSheet;
    DBGridEh1: TDBGridEh;
    PivotDataSourceEh1: TPivotDataSourceEh;
    MemTableEh1: TMemTableEh;
    DataSource1: TDataSource;
    MemTableEh2: TMemTableEh;
    cbBigData: TDBCheckBoxEh;
    procedure bAddFieldsClick(Sender: TObject);
    procedure bDefDefaultStructClick(Sender: TObject);
    procedure bLoadSourceDataClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure PivotGridEh1DrawDataCell(Grid: TCustomPivotGridEh; ACol,
      ARow: Integer; var Params: TPivotCellDrawParamsEh;
      var Processed: Boolean);
    procedure DBNumberEditEh1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  end;

implementation

{$R *.dfm}

constructor TfrPivotGrid.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Align := alClient;
  Panel1.Height := 36;
  Panel1.DoubleBuffered := True;
  PivotGridEh1.DefaultColWidth := 100;
end;

procedure TfrPivotGrid.bAddFieldsClick(Sender: TObject);
begin
  MemTableEh1.Open;
  PivotDataSourceEh1.PivotFields.RebuildPivotFields;
  bAddFields.Caption := 'Recreate fields from DataSet';
end;

procedure TfrPivotGrid.bDefDefaultStructClick(Sender: TObject);
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

procedure TfrPivotGrid.bLoadSourceDataClick(Sender: TObject);
var
  i: Integer;
begin
  MemTableEh1.Open;
  MemTableEh1.EmptyTable;
  MemTableEh1.LoadFromMemTableEh(MemTableEh2, 0, lmAppend, []);
  if cbBigData.Checked then
  begin
//    MemTableEh1.EmptyTable;
    for i := 0 to 100 do
      MemTableEh1.LoadFromMemTableEh(MemTableEh2, 0, lmAppend, []);
  end;

  PivotDataSourceEh1.CreateAndFillSourceTable;
  MemTableEh1.Close;
  bLoadSourceData.Caption := 'Reload source data';
  DataSource1.DataSet := PivotDataSourceEh1.SourceTable;
  PageControl1.ActivePage := TabSheet2;
end;

procedure TfrPivotGrid.Button4Click(Sender: TObject);
begin
  if (PivotDataSourceEh1.ColumnFields.Count = 0) and
     (PivotDataSourceEh1.RowFields.Count = 0)
  then
    ShowMessage('Please, assign Column Fields and/or Row Fields to make Pivot Structure!')
  else
    PivotDataSourceEh1.BuildPivotData;
  PageControl1.ActivePage := TabSheet1;
end;

procedure TfrPivotGrid.PivotGridEh1DrawDataCell(Grid: TCustomPivotGridEh;
  ACol, ARow: Integer; var Params: TPivotCellDrawParamsEh;
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

procedure TfrPivotGrid.DBNumberEditEh1Change(Sender: TObject);
begin
  PivotGridEh1.Invalidate;
end;

end.
