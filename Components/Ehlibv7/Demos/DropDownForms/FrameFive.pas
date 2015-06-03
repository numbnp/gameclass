unit FrameFive;

{$I EhLib.Inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
{$IFDEF EH_LIB_6} Variants, {$ENDIF}
  Themes,
  Dialogs, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, ExtCtrls,
  GridsEh, DBGridEh, MemTableDataEh, Db, ADODB, DataDriverEh,
  ADODataDriverEh, MemTableEh, StdCtrls, DBAxisGridsEh, ImgList, DynVarsEh;

type
  TfrFrameFive = class(TFrame)
    Panel1: TPanel;
    PaintBox1: TPaintBox;
    Label1: TLabel;
    ADODataDriverEh1: TADODataDriverEh;
    DataSource1: TDataSource;
    MemTableEh1: TMemTableEh;
    DBGridEh1: TDBGridEh;
    bReopen: TButton;
    ImageList1: TImageList;
    Memo1: TMemo;
    procedure PaintBox1Paint(Sender: TObject);
    procedure bReopenClick(Sender: TObject);
    procedure DBGridEh1Columns0GetCellParams(Sender: TObject;
      EditMode: Boolean; Params: TColCellParamsEh);
    procedure DBGridEh1CellMouseClick(Grid: TCustomGridEh;
      Cell: TGridCoord; Button: TMouseButton; Shift: TShiftState; X,
      Y: Integer; var Processed: Boolean);
  private
  protected
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses Unit1;

{$R *.dfm}

{ TfrFrameOne }

constructor TfrFrameFive.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  DBGridEh1.FooterParams.Font.Style := [fsBold];
  Memo1.WordWrap := True;
  bReopenClick(nil);
  MemTableEh1.TreeList.Active := True;
end;

procedure TfrFrameFive.PaintBox1Paint(Sender: TObject);
begin
  Form1.FillFrameTopPanel(PaintBox1.Canvas, Rect(0, 0, PaintBox1.Width, PaintBox1.Height));
end;

procedure TfrFrameFive.bReopenClick(Sender: TObject);
begin
  MemTableEh1.Close;
  MemTableEh1.Open;
end;

procedure TfrFrameFive.DBGridEh1Columns0GetCellParams(Sender: TObject;
  EditMode: Boolean; Params: TColCellParamsEh);
var
  Checked: Boolean;
  ChildrenCount: Integer;
begin
  Checked := (MemTableEh1.FieldByName('Checked').AsInteger > 0);
  ChildrenCount := MemTableEh1.FieldByName('CheckedChildren').AsInteger;
  if Checked then
    if ChildrenCount > 0
      then Params.ImageIndex := 3
      else Params.ImageIndex := 1
  else
    if ChildrenCount > 0
      then Params.ImageIndex := 2
      else Params.ImageIndex := 0;
end;

procedure TfrFrameFive.DBGridEh1CellMouseClick(Grid: TCustomGridEh;
  Cell: TGridCoord; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer; var Processed: Boolean);
var
  TreeAreaWidth: Integer;

  procedure SetParentNodeState(PanentNode: TMemRecViewEh);
  var
    ChildNode: TMemRecViewEh;
    Val1, Val2: Variant;
    i: Integer;
    CheckedChildren: Integer;
  begin
    if PanentNode.NodeParent = nil then Exit;
    CheckedChildren := 0;
    for i := 0 to PanentNode.NodesCount-1 do
    begin
      ChildNode := PanentNode.NodeItems[i];
      Val1 := ChildNode.Rec.DataValues['Checked', dvvValueEh];
      Val2 := ChildNode.Rec.DataValues['CheckedChildren', dvvValueEh];
      if   (not VarIsClear(Val1) and (Val1 = 1)) //Checked
        or (not VarIsClear(Val2) and (Val2 > 0)) //CheckedChildren
      then
        Inc(CheckedChildren);
    end;
    PanentNode.Rec.Edit;
    PanentNode.Rec.DataValues['CheckedChildren', dvvValueEh] := CheckedChildren;
    PanentNode.Rec.Post;
    SetParentNodeState(PanentNode.NodeParent);  
  end;

begin
  if not (ssDouble in Shift) and (Cell.X = 1) and (Cell.Y = TDBGridEh(Grid).Row) then
  begin
    TreeAreaWidth := MemTableEh1.TreeNodeLevel * 18;
    if (X > TreeAreaWidth) and (X < TreeAreaWidth + ImageList1.Width) then
    begin
      MemTableEh1.Edit;
      if MemTableEh1.FieldByName('Checked').AsInteger = 0
        then MemTableEh1.FieldByName('Checked').AsInteger := 1
        else MemTableEh1.FieldByName('Checked').AsInteger := 0;
      MemTableEh1.Post;
      SetParentNodeState(MemTableEh1.TreeNode.NodeParent);
    end;
  end;
end;

end.
