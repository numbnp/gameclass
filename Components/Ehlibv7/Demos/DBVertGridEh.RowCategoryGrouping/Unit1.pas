unit Unit1;

{$I EhLib.Inc}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
{$IFDEF EH_LIB_7}
//  {$IFNDEF EH_LIB_16}
    XPMan,
//  {$ENDIF}
{$ENDIF}
  Dialogs, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh,
  MemTableDataEh, Db, ImgList, MemTableEh, DBGridEh, GridsEh,
  DBAxisGridsEh, DBVertGridsEh, ComCtrls, ToolWin, ExtCtrls;

type
  TForm1 = class(TForm)
    Panel2: TPanel;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    tbVerGridSorted: TToolButton;
    ToolButton6: TToolButton;
    ToolButton5: TToolButton;
    ToolButton7: TToolButton;
    DBVertGridEh1: TDBVertGridEh;
    DBGridEh1: TDBGridEh;
    MemTableEh2: TMemTableEh;
    DataSource1: TDataSource;
    ImageList1: TImageList;
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure tbVerGridSortedClick(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure RegroupData;
    procedure UpdateUpDown;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

{ TForm1 }

procedure TForm1.RegroupData;
begin
  DBVertGridEh1.Options := DBVertGridEh1.Options - [dgvhRowMove];
  if ToolButton1.Down then
  begin
    DBVertGridEh1.RowCategories.CategoryGroupingType := cgtFieldRowCategoryNameEh;
    DBVertGridEh1.RowCategories.Active := True;
    DBVertGridEh1.Options := DBVertGridEh1.Options + [dgvhRowMove];
  end else if ToolButton2.Down then
  begin
    DBVertGridEh1.RowCategories.CategoryGroupingType := cgtEmptyNotEmptyValueEh;
    DBVertGridEh1.RowCategories.Active := True;
  end else if ToolButton3.Down then
  begin
    DBVertGridEh1.RowCategories.CategoryGroupingType := cgtFieldDataTypeEh;
    DBVertGridEh1.RowCategories.Active := True;
  end else
    DBVertGridEh1.RowCategories.Active := False;

  if tbVerGridSorted.Down
    then DBVertGridEh1.RowsSortOrder := vgsoByFieldRowCaptionAscEh
    else DBVertGridEh1.RowsSortOrder := vgsoByFieldRowIndexEh;

  UpdateUpDown;
end;

procedure TForm1.UpdateUpDown;
var
  CatNode: TDBVertGridCategoryTreeNodeEh;
begin
  CatNode := DBVertGridEh1.RowCategories.Node;
  ToolButton5.Enabled := (CatNode <> nil) and (CatNode.RowType = vgctCategoryRowEh);
  ToolButton7.Enabled := (CatNode <> nil) and (CatNode.RowType = vgctCategoryRowEh);
end;

procedure TForm1.ToolButton1Click(Sender: TObject);
begin
  RegroupData;
end;

procedure TForm1.ToolButton2Click(Sender: TObject);
begin
  RegroupData;
end;

procedure TForm1.ToolButton3Click(Sender: TObject);
begin
  RegroupData;
end;

procedure TForm1.tbVerGridSortedClick(Sender: TObject);
begin
  RegroupData;
end;

procedure TForm1.ToolButton5Click(Sender: TObject);
var
  CurNode: TDBVertGridCategoryTreeNodeEh;
begin
  if DBVertGridEh1.RowCategories.Active then
  begin
    if DBVertGridEh1.RowCategories.Node.RowType = vgctCategoryRowEh then
    begin
      CurNode := DBVertGridEh1.RowCategories.Node;
      if DBVertGridEh1.RowCategories.Node.Index < DBVertGridEh1.RowCategories.Node.Parent.Count-1 then
        DBVertGridEh1.RowCategories.Node.Index := DBVertGridEh1.RowCategories.Node.Index + 1;
      DBVertGridEh1.RowCategories.Node := CurNode;
    end;
  end;
end;


procedure TForm1.ToolButton7Click(Sender: TObject);
var
  CurNode: TDBVertGridCategoryTreeNodeEh;
begin
  if DBVertGridEh1.RowCategories.Active then
  begin
    if DBVertGridEh1.RowCategories.Node.RowType = vgctCategoryRowEh then
    begin
      CurNode := DBVertGridEh1.RowCategories.Node;
      if DBVertGridEh1.RowCategories.Node.Index > 0 then
        DBVertGridEh1.RowCategories.Node.Index := DBVertGridEh1.RowCategories.Node.Index - 1;
      DBVertGridEh1.RowCategories.Node := CurNode;
    end;
  end;
end;

initialization
  DefFontData.Name := 'Tahoma';
//  DBGridEhDebugDraw := True;
end.
