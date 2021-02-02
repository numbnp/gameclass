unit Unit1;

{$I EhLib.Inc}

interface

uses
{$IFDEF EH_LIB_7}
  {$IFNDEF EH_LIB_16}
    XPMan,
  {$ENDIF}
{$ENDIF}
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MemTableDataEh, Db, DBGridEhGrouping, ADODB, GridsEh, DBGridEh,
  MemTableEh, ToolCtrlsEh, DBGridEhToolCtrls, StdCtrls, Mask, DBCtrlsEh,
  ObjectInspectorEh,
  DBLookupEh, DynVarsEh, DBAxisGridsEh, EhLibVCL, Menus, ImgList,
  CompoMansEh;

type
  TForm1 = class(TForm)
    MemTableEh1: TMemTableEh;
    DBGridEh1: TDBGridEh;
    DataSource1: TDataSource;
    ADOTable1: TADOTable;
    CompoManEh1: TCompoManEh;
    PopupMenu1: TPopupMenu;
    Append1: TMenuItem;
    Edit1: TMenuItem;
    Delete1: TMenuItem;
    Button1: TButton;
    ImageList1: TImageList;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGridEh1Columns2GetCellParams(Sender: TObject; EditMode: Boolean;
      Params: TColCellParamsEh);
    procedure Button1Click(Sender: TObject);
    procedure Append1Click(Sender: TObject);
    procedure Edit1Click(Sender: TObject);
    procedure Delete1Click(Sender: TObject);
    procedure DBGridEh1Columns2DataHintShow(Sender: TCustomDBGridEh;
      CursorPos: TPoint; Cell: TGridCoord; InCellCursorPos: TPoint;
      Column: TColumnEh; var Params: TDBGridEhDataHintParams;
      var Processed: Boolean);
    procedure DBGridEh1Columns2CellButtons0Draw(Grid: TCustomDBGridEh;
      Column: TColumnEh; CellButton: TDBGridCellButtonEh; Canvas: TCanvas; Cell,
      AreaCell: TGridCoord; const ARect: TRect;
      ButtonDrawParams: TCellButtonDrawParamsEh; var Handled: Boolean);
    procedure DBGridEh1Columns2CellButtons0GetEnabledState(
      Grid: TCustomDBGridEh; Column: TColumnEh; CellButton: TDBGridCellButtonEh;
      var ButtonEnabled: Boolean);
    procedure DBGridEh1Columns2CellButtons0MouseClick(Grid: TCustomDBGridEh;
      Column: TColumnEh; CellButton: TDBGridCellButtonEh;
      MouseButton: TMouseButton; Shift: TShiftState; InButtonPos: TPoint;
      ButtonMouseParams: TCellButtonMouseParamsEh; var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Append1Click(Sender: TObject);
var
  RecNo: Integer;
begin
  RecNo := MemTableEh1.RecNo;
  MemTableEh1.Next;
  if RecNo = MemTableEh1.RecNo
    then MemTableEh1.Append
    else MemTableEh1.Insert;
end;

procedure TForm1.Button1Click(Sender: TObject);
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

procedure TForm1.DBGridEh1Columns2CellButtons0Draw(Grid: TCustomDBGridEh;
  Column: TColumnEh; CellButton: TDBGridCellButtonEh; Canvas: TCanvas; Cell,
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

procedure TForm1.DBGridEh1Columns2CellButtons0GetEnabledState(
  Grid: TCustomDBGridEh; Column: TColumnEh; CellButton: TDBGridCellButtonEh;
  var ButtonEnabled: Boolean);
begin
  if MemTableEh1.Active and
    (MemTableEh1.FieldByName('Zip').AsString = '')
  then
    ButtonEnabled := False;
end;

procedure TForm1.DBGridEh1Columns2CellButtons0MouseClick(Grid: TCustomDBGridEh;
  Column: TColumnEh; CellButton: TDBGridCellButtonEh; MouseButton: TMouseButton;
  Shift: TShiftState; InButtonPos: TPoint;
  ButtonMouseParams: TCellButtonMouseParamsEh; var Handled: Boolean);
begin
  MemTableEh1.Edit;
  MemTableEh1.FieldByName('ReadyState').AsInteger := CellButton.Index + 1;
  MemTableEh1.Post;
  Handled := True;
end;

procedure TForm1.DBGridEh1Columns2DataHintShow(Sender: TCustomDBGridEh;
  CursorPos: TPoint; Cell: TGridCoord; InCellCursorPos: TPoint;
  Column: TColumnEh; var Params: TDBGridEhDataHintParams;
  var Processed: Boolean);
begin
  if Params.EditButtonControl <> nil then
  begin
    if MemTableEh1.FieldByName('Zip').AsString = '' then
      // Down't show for Disabled Status
      Params.HintStr := '';
  end;
end;

procedure TForm1.DBGridEh1Columns2GetCellParams(Sender: TObject;
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

procedure TForm1.Delete1Click(Sender: TObject);
begin
  MemTableEh1.Delete;
end;

procedure TForm1.Edit1Click(Sender: TObject);
begin
  ShowMessage('Show edit dialog here');
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F11 then
    ShowObjectInspectorForm(ActiveControl, Rect(Left+Width+10, Top, Left+Width+10+300, Top+Height));
end;

initialization
//  DBGridEhDefaultStyle.IsDrawFocusRect := False;
  DefFontData.Name := 'Tahoma';
//  DBGridEhDebugDraw := True;
//  DefFontData.Height := 20;
end.
