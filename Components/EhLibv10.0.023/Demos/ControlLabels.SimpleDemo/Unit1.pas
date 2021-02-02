unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MemTableDataEh, Db, DBGridEhGrouping, ADODB, GridsEh, DBGridEh,
  MemTableEh, ToolCtrlsEh, DBGridEhToolCtrls, StdCtrls, Mask, DBCtrlsEh,
  ObjectInspectorEh,
  TypInfo,
  DBLookupEh, DynVarsEh, DBAxisGridsEh, EhLibVCL;

type
  TForm1 = class(TForm)
    MemTableEh1: TMemTableEh;
    DBGridEh1: TDBGridEh;
    DataSource1: TDataSource;
    ADOTable1: TADOTable;
    DBEditEh1: TDBEditEh;
    DBEditEh2: TDBEditEh;
    DBEditEh3: TDBEditEh;
    DBNumberEditEh1: TDBNumberEditEh;
    DBNumberEditEh2: TDBNumberEditEh;
    GroupBox1: TGroupBox;
    DBComboBoxEh1: TDBComboBoxEh;
    DBNumberEditEh3: TDBNumberEditEh;
    DBNumberEditEh4: TDBNumberEditEh;
    DBComboBoxEh2: TDBComboBoxEh;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure DBComboBoxEh1Change(Sender: TObject);
    procedure DBNumberEditEh3Change(Sender: TObject);
    procedure DBNumberEditEh4Change(Sender: TObject);
    procedure DBComboBoxEh2Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    DemoControls: array of TCustomDBEditEh;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F11 then
    ShowObjectInspectorForm(ActiveControl, Rect(Left+Width+10, Top, Left+Width+10+300, Top+Height));
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  PropInfo: PPropInfo;
  PropType: PTypeInfo;
  TypeData: PTypeData;
  i: Integer;
begin

  PropInfo := GetPropInfo(DBEditEh1.ControlLabelLocation, 'Position');
  PropType := PropInfo_getPropType(PropInfo);
  TypeData := GetTypeData(PropType);

  for i := TypeData^.MinValue to TypeData^.MaxValue do
    DBComboBoxEh1.Items.Add(GetEnumName(PropType, i));

  DBComboBoxEh1.ItemIndex := DBComboBoxEh1.Items.IndexOf('lpAboveLeftEh');


  PropInfo := GetPropInfo(DBEditEh1.ControlLabelLocation, 'LabelSpacingBound');
  PropType := PropInfo_getPropType(PropInfo);
  TypeData := GetTypeData(PropType);

  for i := TypeData^.MinValue to TypeData^.MaxValue do
    DBComboBoxEh2.Items.Add(GetEnumName(PropType, i));

  DBComboBoxEh2.ItemIndex := DBComboBoxEh2.Items.IndexOf('sbNearBoundEh');


  SetLength(DemoControls, 5);
  DemoControls[0] := DBEditEh1;
  DemoControls[1] := DBEditEh2;
  DemoControls[2] := DBEditEh3;
  DemoControls[3] := DBNumberEditEh1;
  DemoControls[4] := DBNumberEditEh2;
end;

procedure TForm1.DBComboBoxEh1Change(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to Length(DemoControls)-1 do
    if DemoControls[i] <> nil then
      SetOrdProp(DemoControls[i].ControlLabelLocation, 'Position', DBComboBoxEh1.ItemIndex);
end;

procedure TForm1.DBComboBoxEh2Change(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to Length(DemoControls)-1 do
    if DemoControls[i] <> nil then
      SetOrdProp(DemoControls[i].ControlLabelLocation, 'LabelSpacingBound', DBComboBoxEh2.ItemIndex);
end;

procedure TForm1.DBNumberEditEh3Change(Sender: TObject);
var
  i: Integer;
begin
  if VarIsNull(DBNumberEditEh3.Value) then Exit;
  for i := 0 to Length(DemoControls)-1 do
    if DemoControls[i] <> nil then
      SetOrdProp(DemoControls[i].ControlLabelLocation, 'Offset', DBNumberEditEh3.Value);
end;

procedure TForm1.DBNumberEditEh4Change(Sender: TObject);
var
  i: Integer;
begin
  if VarIsNull(DBNumberEditEh4.Value) then Exit;
  for i := 0 to Length(DemoControls)-1 do
    if DemoControls[i] <> nil then
      SetOrdProp(DemoControls[i].ControlLabelLocation, 'Spacing', DBNumberEditEh4.Value);
end;

initialization
//  DBGridEhDefaultStyle.IsDrawFocusRect := False;
  DefFontData.Name := 'Tahoma';
//  DBGridEhDebugDraw := True;
//  DefFontData.Height := 20;
end.
