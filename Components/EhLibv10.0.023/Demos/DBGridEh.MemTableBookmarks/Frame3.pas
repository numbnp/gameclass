unit Frame3;

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
  TfrFrame3 = class(TFrame)
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
    Panel2: TPanel;
    Memo1: TMemo;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Panel3Resize(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure DBGridEh1SelectionChanged(Sender: TObject);
  private
    { Private declarations }
  protected
  public
    constructor Create(AOwner: TComponent); override;

  end;

implementation

uses Unit1;

{$R *.dfm}

{ TfrFrame3 }

constructor TfrFrame3.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Panel1.Height := 36;
  MemTableEh1.DataDriver := nil;
  MemTableEh1.LoadFromMemTableEh(mtSmallData, -1, lmCopy, []);
  DBGridEh1.Columns.AddAllColumns(True);

  MemTableEh2.LoadFromMemTableEh(MemTableEh1, -1, lmCopyStructureOnly, []);
end;

procedure TfrFrame3.DBGridEh1SelectionChanged(Sender: TObject);
begin
  SpeedButton1.Enabled := (DBGridEh1.SelectedRows.Count > 0);
  SpeedButton2.Enabled := (DBGridEh2.SelectedRows.Count > 0);
end;

procedure TfrFrame3.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//  if Key = VK_F11 then
//    ShowObjectInspectorForm(ActiveControl, Rect(Left+Width+10, Top, Left+Width+10+300, Top+Height));
end;

procedure TfrFrame3.Panel3Resize(Sender: TObject);
var
  p1: TPoint;
begin
  p1.X := Panel3.Height div 2;
  SpeedButton1.Top := p1.X - 60;
  SpeedButton2.Top := p1.X + 20;
end;

procedure TfrFrame3.SpeedButton1Click(Sender: TObject);
var
  i, j: Integer;
  SrcRec, AddRec: TMemoryRecordEh;
//  ticks:LongWord;
  AddRecList: TRecordsListEh;
begin
//  ticks := GetTickCount;
  MemTableEh1.CachedUpdates := True;
  MemTableEh1.DisableControls;
  MemTableEh2.DisableControls;
  try
    DBGridEh2.SelectedRows.Clear;
    AddRecList := MemTableEh2.RecordsView.MemTableData.RecordsList;
    AddRecList.BeginUpdate;
    for i := 0 to DBGridEh1.SelectedRows.Count-1 do
    begin
      SrcRec := MemTableEh1.BookmarkToRec(DBGridEh1.SelectedRows[i]);
      AddRec := AddRecList.NewRecord;
      for j := 0 to AddRecList.MemTableData.DataStruct.Count-1 do
        AddRec.Value[j, dvvValueEh] := SrcRec.Value[j, dvvValueEh];
      AddRecList.FetchRecord(AddRec);
    end;
    AddRecList.EndUpdate;

    for i := 0 to DBGridEh1.SelectedRows.Count-1 do
    begin
      SrcRec := MemTableEh1.BookmarkToRec(DBGridEh1.SelectedRows[i]);
      SrcRec.RecordsList.DeleteRecord(SrcRec.Index);
    end;

    MemTableEh2.First;
    DBGridEh1.SelectedRows.Clear;
  finally
    MemTableEh2.EnableControls;
    MemTableEh1.EnableControls;
    MemTableEh1.MergeChangeLog;
  end;
//  DBEditEh1.Text := IntToStr((GetTickCount-ticks));
  MemTableEh1.CachedUpdates := False;
end;

procedure TfrFrame3.SpeedButton2Click(Sender: TObject);
var
  i, j: Integer;
  Rec: TMemoryRecordEh;
//  ticks:LongWord;
begin
//  ticks := GetTickCount;
  MemTableEh1.DisableControls;
  MemTableEh2.DisableControls;
  try
    for i := 0 to DBGridEh2.SelectedRows.Count-1 do
    begin
      Rec := MemTableEh1.BookmarkToRec(DBGridEh2.SelectedRows[i]);
      MemTableEh1.Append;
      for j := 0 to MemTableEh1.FieldCount-1 do
        MemTableEh1.Fields[j].Value := Rec.Value[j, dvvValueEh];
      MemTableEh1.Post;
      Rec.RecordsList.DeleteRecord(Rec.Index);
    end;
    MemTableEh1.First;
    DBGridEh2.SelectedRows.Clear;
  finally
    MemTableEh1.EnableControls;
    MemTableEh2.EnableControls;
  end;
//  DBEditEh1.Text := IntToStr((GetTickCount-ticks));
end;


end.
