unit Frame4;

{$I EhLib.Inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
{$IFDEF EH_LIB_6} Variants, {$ENDIF}
  Themes,
  ObjectInspectorEh, EhLibMTE,
  Dialogs, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, ExtCtrls,
  GridsEh, DBGridEh, MemTableDataEh, Db, ADODB, DataDriverEh,
  ADODataDriverEh, MemTableEh, StdCtrls, DynVarsEh, EhLibVCL, DBAxisGridsEh,
  DBCtrlsEh, Buttons, Mask;

type
  TfrFrame4 = class(TFrame)
    Panel1: TPanel;
    PaintBox1: TPaintBox;
    Label1: TLabel;
    MemTableEh1: TMemTableEh;
    DBGridEh1: TDBGridEh;
    DataSource1: TDataSource;
    mtSmallData: TMemTableEh;
    Splitter1: TSplitter;
    DBGridEh2: TDBGridEh;
    MemTableEh2: TMemTableEh;
    DataSource2: TDataSource;
    Panel3: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Panel4: TPanel;
    Memo1: TMemo;
    procedure SpeedButton1Click(Sender: TObject);
    procedure Panel3Resize(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure DBGridEh1SelectionChanged(Sender: TObject);
  private
    { Private declarations }
  protected
  public
    constructor Create(AOwner: TComponent); override;

    procedure OptimizeAllColsWidth;
    procedure AddSelectionFields;
  end;

implementation

uses Unit1;

{$R *.dfm}

{ TfrFrame4 }

constructor TfrFrame4.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Panel1.Height := 36;

  MemTableEh1.Filter := '';
  MemTableEh2.Filter := '';
  MemTableEh2.Close;
  MemTableEh1.DataDriver := nil;
  MemTableEh1.LoadFromMemTableEh(mtSmallData, -1, lmCopy, []);
  AddSelectionFields;

  DBGridEh1.Columns.AddAllColumns(True);

  MemTableEh2.Open;

  MemTableEh1.Filter := '_RowSelected <> True';
  MemTableEh2.Filter := '_RowSelected = True';
  MemTableEh1.Filtered := True;
  MemTableEh2.Filtered := True;
end;

procedure TfrFrame4.OptimizeAllColsWidth;
var
  i: Integer;
begin
  DBGridEh1.OptimizeAllColsWidth(-1, 1000);
  DBGridEh2.Columns.BeginUpdate;
  for i := 0 to DBGridEh1.Columns.Count-1 do
    DBGridEh2.Columns[i].Width := DBGridEh1.Columns[i].Width;
  DBGridEh2.Columns.EndUpdate;
end;

procedure TfrFrame4.DBGridEh1SelectionChanged(Sender: TObject);
begin
  SpeedButton1.Enabled := (DBGridEh1.SelectedRows.Count > 0);
  SpeedButton2.Enabled := (DBGridEh2.SelectedRows.Count > 0);
end;

procedure TfrFrame4.AddSelectionFields;
var
  NewStruct: TMTDataStructEh;
  bf: TMTStringDataFieldEh;
begin
  NewStruct := MemTableEh1.RecordsView.MemTableData.DataStruct.BeginRestructure;

  bf := TMTStringDataFieldEh(NewStruct.CreateField(TMTBooleanDataFieldEh));
  bf.FieldName := '_RowSelected';

  MemTableEh1.RecordsView.MemTableData.DataStruct.EndRestructure(NewStruct, True);
end;

procedure TfrFrame4.Panel3Resize(Sender: TObject);
var
  p1: TPoint;
begin
  p1.X := Panel3.Height div 2;
  SpeedButton1.Top := p1.X - 60;
  SpeedButton2.Top := p1.X + 20;
end;

procedure TfrFrame4.SpeedButton1Click(Sender: TObject);
var
  i: Integer;
  SrcRec: TMemoryRecordEh;
//  ticks:LongWord;
  RecList: TRecordsListEh;
begin
//  ticks := GetTickCount;
  MemTableEh1.DisableControls;
  MemTableEh2.DisableControls;
  try
    DBGridEh2.SelectedRows.Clear;

    RecList := MemTableEh1.RecordsView.MemTableData.RecordsList;
    RecList.BeginUpdate;

    for i := 0 to DBGridEh1.SelectedRows.Count-1 do
    begin
      SrcRec := MemTableEh1.BookmarkToRec(DBGridEh1.SelectedRows[i]);
      SrcRec.Edit;
      SrcRec.DataValues['_RowSelected', dvvValueEh] := True;
      SrcRec.Post;
    end;

    RecList.EndUpdate;

    MemTableEh2.First;
    DBGridEh1.SelectedRows.Clear;
  finally
    MemTableEh2.EnableControls;
    MemTableEh1.EnableControls;
  end;
//  DBEditEh1.Text := IntToStr((GetTickCount-ticks));
end;

procedure TfrFrame4.SpeedButton2Click(Sender: TObject);
var
  i: Integer;
  SrcRec: TMemoryRecordEh;
//  ticks:LongWord;
  RecList: TRecordsListEh;
begin
//  ticks := GetTickCount;
  MemTableEh1.DisableControls;
  MemTableEh2.DisableControls;
  try
    DBGridEh1.SelectedRows.Clear;
    RecList := MemTableEh1.RecordsView.MemTableData.RecordsList;
    RecList.BeginUpdate;

    for i := 0 to DBGridEh2.SelectedRows.Count-1 do
    begin
      SrcRec := MemTableEh2.BookmarkToRec(DBGridEh2.SelectedRows[i]);
      SrcRec.Edit;
      SrcRec.DataValues['_RowSelected', dvvValueEh] := False;
      SrcRec.Post;
    end;

    RecList.EndUpdate;
    MemTableEh1.First;
    DBGridEh2.SelectedRows.Clear;
  finally
    MemTableEh2.EnableControls;
    MemTableEh1.EnableControls;
  end;
//  DBEditEh1.Text := IntToStr((GetTickCount-ticks));
end;


end.
