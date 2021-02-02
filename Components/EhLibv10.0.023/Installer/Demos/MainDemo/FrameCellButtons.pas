unit FrameCellButtons;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh,
  MemTableDataEh, Db, StdCtrls, ExtCtrls, ImgList, Menus, MemTableEh,
  EhLibVCL, GridsEh, DBAxisGridsEh, DBGridEh;

type
  TfrCellButtons = class(TFrame)
    DBGridEh1: TDBGridEh;
    MemTableEh1: TMemTableEh;
    DataSource1: TDataSource;
    PopupMenu1: TPopupMenu;
    Append1: TMenuItem;
    Edit1: TMenuItem;
    Delete1: TMenuItem;
    ImageList1: TImageList;
    Panel1: TPanel;
    PaintBox1: TPaintBox;
    Label1: TLabel;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure DBGridEh1Columns2CellButtons0Draw(Grid: TCustomDBGridEh;
      Column: TColumnEh; CellButton: TDBGridCellButtonEh; Canvas: TCanvas;
      Cell, AreaCell: TGridCoord; const ARect: TRect;
      ButtonDrawParams: TCellButtonDrawParamsEh; var Handled: Boolean);
    procedure DBGridEh1Columns2CellButtons0GetEnabledState(
      Grid: TCustomDBGridEh; Column: TColumnEh;
      CellButton: TDBGridCellButtonEh; var ButtonEnabled: Boolean);
    procedure DBGridEh1Columns2CellButtons0MouseClick(
      Grid: TCustomDBGridEh; Column: TColumnEh;
      CellButton: TDBGridCellButtonEh; MouseButton: TMouseButton;
      Shift: TShiftState; InButtonPos: TPoint;
      ButtonMouseParams: TCellButtonMouseParamsEh; var Handled: Boolean);
    procedure DBGridEh1Columns2DataHintShow(Sender: TCustomDBGridEh;
      CursorPos: TPoint; Cell: TGridCoord; InCellCursorPos: TPoint;
      Column: TColumnEh; var Params: TDBGridEhDataHintParams;
      var Processed: Boolean);
    procedure DBGridEh1Columns2GetCellParams(Sender: TObject;
      EditMode: Boolean; Params: TColCellParamsEh);
    procedure Append1Click(Sender: TObject);
    procedure Edit1Click(Sender: TObject);
    procedure Delete1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TfrCellButtons.Button1Click(Sender: TObject);
begin
  if dgRowSelect in DBGridEh1.Options then
  begin
    DBGridEh1.Options := DBGridEh1.Options - [dgRowSelect];
    DBGridEh1.Options := DBGridEh1.Options + [dgEditing];
    Button1.Caption := 'CellSelect';
  end else
  begin
    DBGridEh1.Options := DBGridEh1.Options + [dgRowSelect];
    Button1.Caption := 'RowSelect';
  end;
end;

procedure TfrCellButtons.DBGridEh1Columns2CellButtons0Draw(
  Grid: TCustomDBGridEh; Column: TColumnEh;
  CellButton: TDBGridCellButtonEh; Canvas: TCanvas; Cell,
  AreaCell: TGridCoord; const ARect: TRect;
  ButtonDrawParams: TCellButtonDrawParamsEh; var Handled: Boolean);
begin
  if not ButtonDrawParams.Enabled then
      ButtonDrawParams.ImageIndex := 9
  else
  begin
    if MemTableEh1.FieldByName('ReadyState').AsInteger <> CellButton.Index + 1 then
      ButtonDrawParams.ImageIndex := 8;
  end;
end;

procedure TfrCellButtons.DBGridEh1Columns2CellButtons0GetEnabledState(
  Grid: TCustomDBGridEh; Column: TColumnEh;
  CellButton: TDBGridCellButtonEh; var ButtonEnabled: Boolean);
begin
  if MemTableEh1.Active and
    (MemTableEh1.FieldByName('Zip').AsString = '')
  then
    ButtonEnabled := False;
end;

procedure TfrCellButtons.DBGridEh1Columns2CellButtons0MouseClick(
  Grid: TCustomDBGridEh; Column: TColumnEh;
  CellButton: TDBGridCellButtonEh; MouseButton: TMouseButton;
  Shift: TShiftState; InButtonPos: TPoint;
  ButtonMouseParams: TCellButtonMouseParamsEh; var Handled: Boolean);
begin
  MemTableEh1.Edit;
  MemTableEh1.FieldByName('ReadyState').AsInteger := CellButton.Index + 1;
  MemTableEh1.Post;
  Handled := True;
end;

procedure TfrCellButtons.DBGridEh1Columns2DataHintShow(
  Sender: TCustomDBGridEh; CursorPos: TPoint; Cell: TGridCoord;
  InCellCursorPos: TPoint; Column: TColumnEh;
  var Params: TDBGridEhDataHintParams; var Processed: Boolean);
begin
  if Params.EditButtonControl <> nil then
  begin
    if MemTableEh1.FieldByName('Zip').AsString = '' then
      // Down't show for Disabled Status
      Params.HintStr := '';
  end;
end;

procedure TfrCellButtons.DBGridEh1Columns2GetCellParams(Sender: TObject;
  EditMode: Boolean; Params: TColCellParamsEh);
begin
  if MemTableEh1.Active then
  begin
    if (MemTableEh1.FieldByName('Zip').AsString = '')  then
    begin
      Params.Text := 'Disabled (Zip is Empty)';
      Params.Font.Color := clMedGray;
      Params.Background := $00F5F5F5;
    end else if MemTableEh1.FieldByName('ReadyState').AsInteger = 1 then
    begin
      Params.Text := 'Red State';
      Params.Font.Color := $001B1BD8;
    end else if MemTableEh1.FieldByName('ReadyState').AsInteger = 2 then
    begin
      Params.Text := 'Yellow State';
      Params.Font.Color := $000091F0;
    end else if MemTableEh1.FieldByName('ReadyState').AsInteger = 3 then
    begin
      Params.Text := 'Green State';
      Params.Font.Color := $0025BC3C;
    end;
  end;
end;

procedure TfrCellButtons.Append1Click(Sender: TObject);
var
  RecNo: Integer;
begin
  RecNo := MemTableEh1.RecNo;
  MemTableEh1.Next;
  if RecNo = MemTableEh1.RecNo
    then MemTableEh1.Append
    else MemTableEh1.Insert;
end;

procedure TfrCellButtons.Edit1Click(Sender: TObject);
begin
  ShowMessage('Show edit dialog here');
end;

procedure TfrCellButtons.Delete1Click(Sender: TObject);
begin
  MemTableEh1.Delete;
end;

end.
