unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MemTableDataEh, Db, DBGridEhGrouping, ADODB, GridsEh, DBGridEh,
  MemTableEh, ToolCtrlsEh, DBGridEhToolCtrls, StdCtrls, Mask, DBCtrlsEh,
  DBLookupEh, DynVarsEh, EhLibVCL, DBAxisGridsEh,
  EhLibMTE, Menus;

type
  TForm1 = class(TForm)
    MemTableEh1: TMemTableEh;
    DBGridEh1: TDBGridEh;
    DataSource1: TDataSource;
    ADOTable1: TADOTable;
    PopupMenu1: TPopupMenu;
    M11: TMenuItem;
    M21: TMenuItem;
    N1: TMenuItem;
    M31: TMenuItem;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure DBImageEh1ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure Button1Click(Sender: TObject);
    procedure M11Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
  end;

var
  Form1: TForm1;

type
  TMyDBGridEhCenter = class(TDBGridEhCenter)
  public
    procedure BuildCellPopupMenu(Grid: TCustomDBGridEh; PopupMenu: TPopupMenu; const MousePos: TPoint; const Cell: TGridCoord; const InCellMousePos: TPoint; const CellAreaType: TCellAreaTypeEh; InAreaCell: TGridCoord; const InplaceEditorVisible: Boolean; const AColumn: TColumnEh; const AGroupDataNode: TGroupDataTreeNodeEh); override;
    procedure MenuFilterTextClick(Sender: TObject);
    procedure MenuClearColumnFilter(Sender: TObject);
  end;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  if DBGridEh1.PopupMenuParams.BuildMenuOnPopup then
  begin
    DBGridEh1.PopupMenuParams.BuildMenuOnPopup := False;
    Button1.Caption := 'BuildMenuOnPopup "No"'
  end else
  begin
    DBGridEh1.PopupMenuParams.BuildMenuOnPopup := True;
    Button1.Caption := 'BuildMenuOnPopup "Yes"'
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if DBGridEh1.PopupMenuParams.UseGlobalMenu then
  begin
    DBGridEh1.PopupMenuParams.UseGlobalMenu := False;
    Button2.Caption := 'UseGlobalMenu "No"'
  end else
  begin
    DBGridEh1.PopupMenuParams.UseGlobalMenu := True;
    Button2.Caption := 'UseGlobalMenu "Yes"'
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  if DBGridEh1.PopupMenuParams.UseIndicatorMenu then
  begin
    DBGridEh1.PopupMenuParams.UseIndicatorMenu := False;
    Button3.Caption := 'UseIndicatorMenu "No"'
  end else
  begin
    DBGridEh1.PopupMenuParams.UseIndicatorMenu := True;
    Button3.Caption := 'UseIndicatorMenu "Yes"'
  end;
end;

procedure TForm1.DBImageEh1ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin
//
end;

procedure TForm1.M11Click(Sender: TObject);
begin
  ShowMessage('M1 item was selected');
end;

{ TMyDBGridEhCenter }

procedure TMyDBGridEhCenter.BuildCellPopupMenu(Grid: TCustomDBGridEh;
  PopupMenu: TPopupMenu; const MousePos: TPoint; const Cell: TGridCoord;
  const InCellMousePos: TPoint; const CellAreaType: TCellAreaTypeEh;
  InAreaCell: TGridCoord; const InplaceEditorVisible: Boolean;
  const AColumn: TColumnEh; const AGroupDataNode: TGroupDataTreeNodeEh);
var
  MenuColItem: TColumnEhMenuItem;
  MenuItem: TMenuItem;
begin
  inherited BuildCellPopupMenu(Grid, PopupMenu, MousePos, Cell, InCellMousePos,
    CellAreaType, InAreaCell, InplaceEditorVisible, AColumn, AGroupDataNode);

  if Grid.PopupMenuParams.UseGlobalMenu and (AColumn <> nil) and (CellAreaType.VertType = vctDataEh) then
  begin
    if PopupMenu.Items.Count > 0 then
    begin
      MenuItem := TMenuItem.Create(PopupMenu);
      MenuItem.Caption := '-';
      PopupMenu.Items.Add(MenuItem);
    end;

    MenuColItem := TColumnEhMenuItem.Create(PopupMenu);
    MenuColItem.OnClick := MenuClearColumnFilter;
    MenuColItem.Caption := 'Clear filter in ' + AColumn.Title.Caption;
    MenuColItem.ColumnEh := AColumn;
    MenuColItem.Enabled := AColumn.STFilter.ExpressionStr <> '';
    PopupMenu.Items.Add(MenuColItem);

    MenuColItem := TColumnEhMenuItem.Create(PopupMenu);
    MenuColItem.OnClick := MenuFilterTextClick;
    MenuColItem.Caption := 'Equal "' + AColumn.DisplayText +'"';
    MenuColItem.ColumnEh := AColumn;
    PopupMenu.Items.Add(MenuColItem);
  end;

end;

procedure TMyDBGridEhCenter.MenuClearColumnFilter(Sender: TObject);
var
  Col: TColumnEh;
begin
  Col := TColumnEhMenuItem(Sender).ColumnEh;
  Col.STFilter.ExpressionStr := '';
  Col.Grid.ApplyFilter;
end;

procedure TMyDBGridEhCenter.MenuFilterTextClick(Sender: TObject);
var
  Col: TColumnEh;
begin
  Col := TColumnEhMenuItem(Sender).ColumnEh;
  Col.STFilter.ExpressionStr := '=''' + Col.DisplayText + '''';
  Col.Grid.ApplyFilter;
end;

initialization
//  DBGridEhDefaultStyle.IsDrawFocusRect := False;
  DefFontData.Name := 'Tahoma';
  SetDBGridEhCenter(TMyDBGridEhCenter.Create).Free;
//  DBGridEhDebugDraw := True;
//  DefFontData.Height := 20;
end.
