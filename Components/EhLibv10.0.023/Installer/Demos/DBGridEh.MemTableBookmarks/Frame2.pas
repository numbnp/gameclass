unit Frame2;

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
  DBCtrlsEh, Mask;

type
  TfrFrame2 = class(TFrame)
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
    Panel2: TPanel;
    Memo1: TMemo;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGridEh1SelectionChanged(Sender: TObject);
  private
    { Private declarations }
  protected
    FSelectingUpdated: Boolean;
    FInternalSelection: Boolean;
  public
    constructor Create(AOwner: TComponent); override;

    procedure Grid1SelectedRowsItemChanged(Sender: TCustomDBGridEh; Item: TUniBookmarkEh; Action: TListNotification);
    procedure Grid2SelectedRowsItemChanged(Sender: TCustomDBGridEh; Item: TUniBookmarkEh; Action: TListNotification);

  end;

implementation

uses Unit1;

{$R *.dfm}

{ TfrFrame2 }

constructor TfrFrame2.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Panel1.Height := 36;

  MemTableEh1.DataDriver := nil;
  MemTableEh1.LoadFromMemTableEh(mtSmallData, -1, lmCopy, []);
  DBGridEh1.Columns.AddAllColumns(True);
  MemTableEh2.LoadFromMemTableEh(MemTableEh1, -1, lmCopyStructureOnly, []);

  DBGridEh1.OnSelectedRowsItemChanged := Grid1SelectedRowsItemChanged;
  DBGridEh2.OnSelectedRowsItemChanged := Grid2SelectedRowsItemChanged;
end;

procedure TfrFrame2.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//  if Key = VK_F11 then
//    ShowObjectInspectorForm(ActiveControl, Rect(Left+Width+10, Top, Left+Width+10+300, Top+Height));
end;

procedure TfrFrame2.DBGridEh1SelectionChanged(Sender: TObject);
var
  i, j: Integer;
  Rec: TMemoryRecordEh;
begin
  if FSelectingUpdated then
  begin
    FInternalSelection := True;
    MemTableEh2.DisableControls;
    try
      DBGridEh2.SelectedRows.Clear;
      MemTableEh2.EmptyTable;
      for i := 0 to DBGridEh1.SelectedRows.Count-1 do
      begin
        Rec := MemTableEh1.BookmarkToRec(DBGridEh1.SelectedRows[i]);
        MemTableEh2.Append;
        for j := 0 to MemTableEh2.FieldCount-1 do
          MemTableEh2.Fields[j].Value := Rec.Value[j, dvvValueEh];
        MemTableEh2.Post;
      end;
      MemTableEh2.First;
    finally
      MemTableEh2.EnableControls;
    end;
    FSelectingUpdated := False;
    DBGridEh2.SelectedRows.SelectAll;
    FInternalSelection := False;
  end
end;

procedure TfrFrame2.Grid1SelectedRowsItemChanged(Sender: TCustomDBGridEh;
  Item: TUniBookmarkEh; Action: TListNotification);
var
  Rec: TMemoryRecordEh;
  j: Integer;
begin
  if Action = lnAdded then
  begin
    if not TDBGridEh(Sender).SelectedRows.Updating then
    begin
      Rec := MemTableEh1.BookmarkToRec(Item);
      MemTableEh2.Append;
      for j := 0 to MemTableEh2.FieldCount-1 do
        MemTableEh2.Fields[j].Value := Rec.Value[j, dvvValueEh];
      MemTableEh2.Post;
      FInternalSelection := True;
      try
        DBGridEh2.SelectedRows.CurrentRowSelected := True;
      finally
        FInternalSelection := False;
      end;
    end else
      FSelectingUpdated := True;
  end else if Action = lnDeleted then
  begin
    if not TDBGridEh(Sender).SelectedRows.Updating then
    begin
      Rec := MemTableEh1.BookmarkToRec(Item);
      if MemTableEh2.Locate(MemTableEh2.Fields[0].FieldName, Rec.Value[0, dvvValueEh], []) then
      begin
        FInternalSelection := True;
        try
          DBGridEh2.SelectedRows.CurrentRowSelected := False;
        finally
          FInternalSelection := False;
        end;
        MemTableEh2.Delete;
      end;
    end else
      FSelectingUpdated := True;
  end;
end;

procedure TfrFrame2.Grid2SelectedRowsItemChanged(Sender: TCustomDBGridEh;
  Item: TUniBookmarkEh; Action: TListNotification);
var
  Rec: TMemoryRecordEh;
begin
  if FInternalSelection then
    Exit;
  if Action = lnDeleted then
  begin
    Rec := MemTableEh2.BookmarkToRec(Item);
    if MemTableEh1.Locate(MemTableEh1.Fields[0].FieldName, Rec.Value[0, dvvValueEh], []) then
    begin
      DBGridEh1.SelectedRows.CurrentRowSelected := False;
      DBGridEh2.CancelMode; //Stop Mouse Dragging
    end;
  end;
end;

end.
