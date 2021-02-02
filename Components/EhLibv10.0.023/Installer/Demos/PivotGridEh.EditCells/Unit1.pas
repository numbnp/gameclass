unit Unit1;

{$I EHLIB.INC}

interface

uses
  {$IFNDEF EH_LIB_16}
    XPMan,
  {$ENDIF}
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PivotGridToolsEh, StdCtrls, ExtCtrls, MemTableDataEh, Db,
  MemTableEh, PivotGridsEh, EhLibVCL, GridsEh, DBGridEhGrouping,
  ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, DBAxisGridsEh, DBGridEh,
  EhLibMTE,
  ComCtrls, Mask, DBCtrlsEh;

type
  TForm1 = class(TForm)
    PivotGridToolBoxEh1: TPivotGridToolBoxEh;
    Panel1: TPanel;
    bLoadSourceData: TButton;
    bBuildPivotData: TButton;
    Splitter1: TSplitter;
    PivotDataSourceEh1: TPivotDataSourceEh;
    MemTableEh1: TMemTableEh;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    PivotGridEh1: TPivotGridEh;
    DBGridEh1: TDBGridEh;
    DataSource1: TDataSource;
    Label1: TLabel;
    procedure bBuildPivotDataClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DBNumberEditEh1Change(Sender: TObject);
    procedure bLoadSourceDataClick(Sender: TObject);
    procedure PivotGridEh1GetDataCellEditorParams(Grid: TCustomPivotGridEh;
      ACol, ARow: Integer; Params: TPivotDataCellEditorParamsEh);
    procedure PivotGridEh1SetDataCellEditorValue(Grid: TCustomPivotGridEh; ACol,
      ARow: Integer; Params: TPivotDataCellEditorSetValueParamsEh);
  private
    { Private declarations }
  public
    procedure AddFiledsFromDataSet;
    procedure DefinePivotStructure;
    procedure LoadSourceData;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  PivotGridEh1.ShowHint := False;
  PivotGridEh1.ShowToolTips := True;
  PivotGridEh1.DefaultColWidth := 80;
  AddFiledsFromDataSet;
  DefinePivotStructure;
  LoadSourceData;
  bBuildPivotData.Click;
end;

procedure TForm1.AddFiledsFromDataSet;
begin
  MemTableEh1.Open;
  //PivotDataSourceEh1.PivotFields.RebuildPivotFields;
  //bAddFields.Caption := 'Recreate fields from DataSet';
end;

procedure TForm1.DefinePivotStructure;
begin
  PivotDataSourceEh1.ColumnFields.Clear;
  PivotDataSourceEh1.RowFields.Clear;
  PivotDataSourceEh1.ValueFieldDefs.Clear;

  PivotDataSourceEh1.ColumnFields.Add('DeviceID');
  PivotDataSourceEh1.RowFields.Add('Date');
  with PivotDataSourceEh1.ValueFieldDefs.Add do
  begin
    PivotFieldName := 'MaxLoad';
    SumFunction := svtSumEh;
  end;
  //bDefDefaultStruct.Caption := 'Assign default pivot structure'
end;

procedure TForm1.LoadSourceData;
begin
  MemTableEh1.Open;
  PivotDataSourceEh1.CreateAndFillSourceTable;
  //MemTableEh1.Close;
  bLoadSourceData.Caption := 'Reload source data';
  DataSource1.DataSet := PivotDataSourceEh1.SourceTable;
  PageControl1.ActivePage := TabSheet2;
end;

procedure TForm1.bLoadSourceDataClick(Sender: TObject);
begin
  LoadSourceData;
end;

procedure TForm1.bBuildPivotDataClick(Sender: TObject);
begin
  if (PivotDataSourceEh1.ColumnFields.Count = 0) and
     (PivotDataSourceEh1.RowFields.Count = 0)
  then
    ShowMessage('Please, assign Column Fields and/or Row Fields to make Pivot Structure!')
  else
    PivotDataSourceEh1.BuildPivotData;
  PageControl1.ActivePage := TabSheet1;
end;

procedure TForm1.PivotGridEh1GetDataCellEditorParams(Grid: TCustomPivotGridEh;
  ACol, ARow: Integer; Params: TPivotDataCellEditorParamsEh);
begin
  if (Length(Params.RowsAxisPos) = 0) or
     (Length(Params.ColsAxisPos) = 0) or
     VarEquals(Params.RowsAxisPos[Length(Params.RowsAxisPos)-1], Unassigned) or
     VarEquals(Params.ColsAxisPos[Length(Params.ColsAxisPos)-1], Unassigned)
  then
    Params.CanModify := False //Total cell is not allowed to chage
  else
    Params.CanModify := True;
end;

procedure TForm1.PivotGridEh1SetDataCellEditorValue(Grid: TCustomPivotGridEh;
  ACol, ARow: Integer; Params: TPivotDataCellEditorSetValueParamsEh);
var
  KeyFields: String;
  KeyValue: Variant;
begin
  KeyFields := 'DeviceId;Date';
  KeyValue := VarArrayCreate([0, 1], varVariant);
  KeyValue[0] := Params.ColsAxisPos[0];
  KeyValue[1] := Params.RowsAxisPos[0];

  if MemTableEh1.Locate(KeyFields, KeyValue, []) then
  begin
    MemTableEh1.Edit;
    MemTableEh1.FieldByName('MaxLoad').AsString := Params.EditValue;
    MemTableEh1.Post;
  end else
    ShowMessage('Something goes wrong.');

  Params.UpdateInternalTables := True;
end;

procedure TForm1.DBNumberEditEh1Change(Sender: TObject);
begin
  PivotGridEh1.Invalidate;
end;

initialization
  {$IFNDEF EH_LIB_16}
  DefFontData.Name := 'Tahoma';
  {$ENDIF}
//  SetEhLibDebugDraw(True);
//  System.ReportMemoryLeaksOnShutdown := True;
end.

