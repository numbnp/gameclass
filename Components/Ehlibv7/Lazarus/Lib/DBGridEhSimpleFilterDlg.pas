{*******************************************************}
{                                                       }
{                      EhLib v7.0                       }
{                                                       }
{        Find dialog for TDBGridEh component            }
{                     Build 7.0.01                      }
{                                                       }
{     Copyright (c) 2011-12 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit DBGridEhSimpleFilterDlg;

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
{$IFDEF EH_LIB_6} Types, Variants, {$ENDIF}
  {$IFDEF FPC}
    EhLibLCL, LCLType, Win32Extra, DBGridsEh, MaskEdit,
  {$ELSE}
    EhLibVCL, Messages, DBGridEh, Mask,
  {$ENDIF}
  StdCtrls, ExtCtrls, DBCtrlsEh,
  ToolCtrlsEh;

type
  TDBGridEhSimpleFilterDialog = class(TForm)
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Bevel1: TBevel;
    rbAnd: TRadioButton;
    rbOr: TRadioButton;
    Label2: TLabel;
    Label3: TLabel;
    bOk: TButton;
    bCancel: TButton;
    DBComboBoxEh1: TDBComboBoxEh;
    DBComboBoxEh2: TDBComboBoxEh;
    DBDateTimeEditEh1: TDBDateTimeEditEh;
    DBDateTimeEditEh2: TDBDateTimeEditEh;
    DBNumberEditEh1: TDBNumberEditEh;
    DBNumberEditEh2: TDBNumberEditEh;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure DBComboBoxEh1Change(Sender: TObject);
  private
    { Private declarations }
  public
    FieldValueList: IMemTableDataFieldValueListEh;
    Column: TColumnEh;
    procedure Init;
    procedure InitSignComboBox(ComboBox: TComboBox);
    procedure InitValuesComboBox(ComboBox: TDBComboBoxEh; Pos: TPoint);
    procedure FillDialogFromColumnFilter(STFilter: TSTColumnFilterEh);
    procedure FillDialogFromColumnFilter1(Operator: TSTFilterOperatorEh; Operand: Variant; OperatorComboBox: TComboBox; OperandComboBox: TDBComboBoxEh);
    procedure SetFilterFromDialog;
    procedure SetFilterFromDialog1(var FilterString: String; OperatorComboBox: TComboBox; OperandComboBox: TDBComboBoxEh);
  end;

var
  DBGridEhSimpleFilterDialog: TDBGridEhSimpleFilterDialog;

function StartDBGridEhColumnFilterDialog(Column: TColumnEh): Boolean;

implementation

uses DBUtilsEh, EhLibConsts;

{$R *.DFM}

{
0  ''
1  '='        //equals
2  '<>'       //does not equal
3  '>'        //is greate than
4  '>='       //is greate than or equall to
5  '<'        //is less than
6  '<='       //is less than or equall to
7  '%~'       //begins with
8  'Not %~'   //does not begin with
9  '~%'       //ends with
10 'Not ~%'   //does not end with
11 '%~%'      //contains
12 'Not %~%'  //does not contain
13 '~'        //like
14 'Not ~'    //not like
15 'In'       //in list
16 'Not In'   //not in list
17 'Null'     //is blank
18 'Not Null' //is not blank
}

function CharAtPos(S: String; Pos: Integer): Char;
begin
  if (Length(S) < Pos) or (Pos < 1) then
    Result := #0
  else
    Result := S[Pos];
end;

function StartDBGridEhColumnFilterDialog(Column: TColumnEh): Boolean;
begin
  if DBGridEhSimpleFilterDialog = nil then
    DBGridEhSimpleFilterDialog := TDBGridEhSimpleFilterDialog.Create(Application);

  DBGridEhSimpleFilterDialog.Column := Column;
  DBGridEhSimpleFilterDialog.Init;
  Result := False;
  if DBGridEhSimpleFilterDialog.ShowModal = mrOk then
    Result := True;
end;

procedure TDBGridEhSimpleFilterDialog.FormCreate(Sender: TObject);
begin
  Font.Name := String(DefFontData.Name);
end;

procedure TDBGridEhSimpleFilterDialog.FillDialogFromColumnFilter1(
  Operator: TSTFilterOperatorEh; Operand: Variant;
  OperatorComboBox: TComboBox; OperandComboBox: TDBComboBoxEh);
var
  StartMultyChar, EndMultyChar: Boolean;
//  TextOperand: String;
begin
  StartMultyChar := False;
  EndMultyChar := False;
  OperandComboBox.Text :=
    Column.STFilter.GetOperandAsString(Operator, Operand);
  case Operator of
    foNon:
      OperatorComboBox.ItemIndex := OperatorComboBox.Items.IndexOfObject(TObject(0));
    foEqual:
      OperatorComboBox.ItemIndex := OperatorComboBox.Items.IndexOfObject(TObject(1));
    foNotEqual:
      OperatorComboBox.ItemIndex := OperatorComboBox.Items.IndexOfObject(TObject(2));
    foGreaterThan:
      OperatorComboBox.ItemIndex := OperatorComboBox.Items.IndexOfObject(TObject(3));
    foLessThan:
      OperatorComboBox.ItemIndex := OperatorComboBox.Items.IndexOfObject(TObject(5));
    foGreaterOrEqual:
      OperatorComboBox.ItemIndex := OperatorComboBox.Items.IndexOfObject(TObject(4));
    foLessOrEqual:
      OperatorComboBox.ItemIndex := OperatorComboBox.Items.IndexOfObject(TObject(6));
    foLike:
      begin
        OperatorComboBox.ItemIndex := OperatorComboBox.Items.IndexOfObject(TObject(13));
        if (CharAtPos(OperandComboBox.Text, 1) = '%') and
          (CharAtPos(OperandComboBox.Text, 2) <> '%')
        then
          StartMultyChar := True;
        if (CharAtPos(OperandComboBox.Text, Length(OperandComboBox.Text)) = '%') and
          (CharAtPos(OperandComboBox.Text, Length(OperandComboBox.Text)-1) <> '%')
        then
          EndMultyChar := True;
        if StartMultyChar and EndMultyChar then
        begin
          OperatorComboBox.ItemIndex := OperatorComboBox.Items.IndexOfObject(TObject(11));
          OperandComboBox.Text := Copy(OperandComboBox.Text, 2, Length(OperandComboBox.Text)-2);
        end else if StartMultyChar then
        begin
          OperatorComboBox.ItemIndex := OperatorComboBox.Items.IndexOfObject(TObject(9));
          OperandComboBox.Text := Copy(OperandComboBox.Text, 2, Length(OperandComboBox.Text)-1);
        end else if EndMultyChar then
        begin
          OperatorComboBox.ItemIndex := OperatorComboBox.Items.IndexOfObject(TObject(7));
          OperandComboBox.Text := Copy(OperandComboBox.Text, 1, Length(OperandComboBox.Text)-1);
        end;
      end;
    foNotLike:
      begin
        OperatorComboBox.ItemIndex := OperatorComboBox.Items.IndexOfObject(TObject(14));
        if (CharAtPos(OperandComboBox.Text, 1) = '%') and
          (CharAtPos(OperandComboBox.Text, 2) <> '%')
        then
          StartMultyChar := True;
        if (CharAtPos(OperandComboBox.Text, Length(OperandComboBox.Text)) = '%') and
          (CharAtPos(OperandComboBox.Text, Length(OperandComboBox.Text)-1) <> '%')
        then
          EndMultyChar := True;
        if StartMultyChar and EndMultyChar then
        begin
          OperatorComboBox.ItemIndex := OperatorComboBox.Items.IndexOfObject(TObject(12));
          OperandComboBox.Text := Copy(OperandComboBox.Text, 2, Length(OperandComboBox.Text)-2);
        end else if StartMultyChar then
        begin
          OperatorComboBox.ItemIndex := OperatorComboBox.Items.IndexOfObject(TObject(10));
          OperandComboBox.Text := Copy(OperandComboBox.Text, 2, Length(OperandComboBox.Text)-1);
        end else if EndMultyChar then
        begin
          OperatorComboBox.ItemIndex := OperatorComboBox.Items.IndexOfObject(TObject(8));
          OperandComboBox.Text := Copy(OperandComboBox.Text, 1, Length(OperandComboBox.Text)-1);
        end;
      end;
    foIn:
      OperatorComboBox.ItemIndex := OperatorComboBox.Items.IndexOfObject(TObject(15));
    foNotIn:
      OperatorComboBox.ItemIndex := OperatorComboBox.Items.IndexOfObject(TObject(16));
    foNull:
      OperatorComboBox.ItemIndex := OperatorComboBox.Items.IndexOfObject(TObject(17));
    foNotNull:
      OperatorComboBox.ItemIndex := OperatorComboBox.Items.IndexOfObject(TObject(18));
  end;
end;

procedure TDBGridEhSimpleFilterDialog.FillDialogFromColumnFilter(STFilter: TSTColumnFilterEh);
var
  AnExpression: TSTFilterExpressionEh;
begin
  AnExpression := STFilter.Expression;
  if STFilter.ListSource = nil then
    STFilter.CheckRecodeKeyList(AnExpression, False);
  FillDialogFromColumnFilter1(
    AnExpression.Operator1, AnExpression.Operand1,
    ComboBox1, DBComboBoxEh1
    );
  rbOr.Checked := (AnExpression.Relation = foOR);
  rbAnd.Checked := not rbOr.Checked;
  FillDialogFromColumnFilter1(
    AnExpression.Operator2, AnExpression.Operand2,
    ComboBox2, DBComboBoxEh2
    );
end;

procedure TDBGridEhSimpleFilterDialog.InitSignComboBox(ComboBox: TComboBox);
var
  CanLike: Boolean;
begin
  if (Column.Field <> nil) and
     (STFldTypeMapEh[Column.Field.DataType] in [botNumber, botDateTime, botBoolean])
    then CanLike := False
    else CanLike := True;

  ComboBox.Items.Clear;
  ComboBox.Items.AddObject('',                 TObject(0));
  ComboBox.Items.AddObject(SSimpFilter_equals,           TObject(1));
  ComboBox.Items.AddObject(SSimpFilter_does_not_equal,   TObject(2));
  ComboBox.Items.AddObject(SSimpFilter_is_greate_than,   TObject(3));
  ComboBox.Items.AddObject(SSimpFilter_is_greate_than_or_equall_to, TObject(4));
  ComboBox.Items.AddObject(SSimpFilter_is_less_than,     TObject(5));
  ComboBox.Items.AddObject(SSimpFilter_is_less_than_or_equall_to, TObject(6));

  if CanLike then
  begin
    ComboBox.Items.AddObject(SSimpFilter_begins_with,      TObject(7));
    ComboBox.Items.AddObject(SSimpFilter_does_not_begin_with, TObject(8));
    ComboBox.Items.AddObject(SSimpFilter_ends_with,        TObject(9));
    ComboBox.Items.AddObject(SSimpFilter_does_not_end_with,TObject(10));
    ComboBox.Items.AddObject(SSimpFilter_contains,         TObject(11));
    ComboBox.Items.AddObject(SSimpFilter_does_not_contain, TObject(12));
    ComboBox.Items.AddObject(SSimpFilter_like,             TObject(13));
    ComboBox.Items.AddObject(SSimpFilter_not_like,         TObject(14));
  end;

  ComboBox.Items.AddObject(SSimpFilter_in_list,          TObject(15));
  ComboBox.Items.AddObject(SSimpFilter_not_in_list,      TObject(16));
  ComboBox.Items.AddObject(SSimpFilter_is_blank,         TObject(17));
  ComboBox.Items.AddObject(SSimpFilter_is_not_blank,     TObject(18));

  ComboBox.DropDownCount := ComboBox.Items.Count;
end;

procedure TDBGridEhSimpleFilterDialog.InitValuesComboBox(ComboBox: TDBComboBoxEh; Pos: TPoint);
begin
  ComboBox.Left := Pos.X;
  ComboBox.Top := Pos.Y;
  ComboBox.Visible := True;
  ComboBox.Items.Clear;
  if Column.GetCurrentFieldValueList <> nil then
    ComboBox.Items := Column.GetCurrentFieldValueList.GetValues;
  ComboBox.Text := '';
end;

procedure TDBGridEhSimpleFilterDialog.Init;
begin
  InitSignComboBox(ComboBox1);
  InitSignComboBox(ComboBox2);
  InitValuesComboBox(DBComboBoxEh1, Point(Edit1.Left, Edit1.Top));
  InitValuesComboBox(DBComboBoxEh2, Point(Edit2.Left, Edit2.Top));

  FillDialogFromColumnFilter(Column.STFilter);
end;

procedure TDBGridEhSimpleFilterDialog.SetFilterFromDialog1(
  var FilterString: String; OperatorComboBox: TComboBox;
  OperandComboBox: TDBComboBoxEh);
var
  Oper: Integer;
  SValue: String;
begin
  if OperatorComboBox.ItemIndex < 0 then
    OperatorComboBox.ItemIndex := 0;
  Oper := Integer(OperatorComboBox.Items.Objects[OperatorComboBox.ItemIndex]);
  case Oper of
    0: FilterString := '';
    1: FilterString := '=';  // 'equals'
    2: FilterString := '<>'; // 'does not equal'
    3: FilterString := '>';  // 'is greate than'
    4: FilterString := '>='; // 'is greate than or equall to'
    5: FilterString := '<';  // 'is less than'
    6: FilterString := '<='; // 'is less than or equall to'

    7: FilterString := '~';  // 'begins with'
    8: FilterString := '!~'; // 'does not begin with'
    9: FilterString := '~';  // 'ends with'
    10: FilterString := '!~';  // 'does not end with'
    11: FilterString := '~';   // 'contains'
    12: FilterString := '!~';  // 'does not contain'
    13: FilterString := '~';   // 'like'
    14: FilterString := '!~';  // 'not like'

    15: FilterString := 'in';  // 'in list'
    16: FilterString := '!in'; // 'not in list'

    17: FilterString := '=Null';  // 'is blank'
    18: FilterString := '<>Null'; // 'is not blank'
  end;
  SValue := OperandComboBox.Text;
//  SValue := StringReplace(SValue, '''', '''''',[rfReplaceAll]);
//  TSTOperandTypeEh = (botNon, botString, botNumber, botDateTime, botBoolean);
  if ((Column.STFilter.Expression.ExpressionType = botString) and (CharAtPos(SValue, 1) = ' ')) or
     (AnsiPos(')', SValue) > 0) or (AnsiPos('(', SValue) > 0)
  then
    SValue := '''' + SValue + '''';

  if Oper in [7,8,11,12] then
    SValue := SValue + '%';
  if Oper in [9,10,11,12] then
    SValue := '%' + SValue;

  if Oper in [15,16] then
    SValue := '(' + SValue + ')';
  if not (Oper in [17,18]) and (SValue <> '') then
    FilterString := FilterString + SValue;
end;

procedure TDBGridEhSimpleFilterDialog.SetFilterFromDialog;
var
//  Expression: TSTFilterExpressionEh;
  FilterString1, FilterString2: String;
begin
  SetFilterFromDialog1(FilterString1, ComboBox1, DBComboBoxEh1);
  SetFilterFromDialog1(FilterString2, ComboBox2, DBComboBoxEh2);
  if FilterString2 <> '' then
  begin
    if rbOr.Checked
      then Column.STFilter.ExpressionStr := FilterString1 + ' OR ' + FilterString2
      else Column.STFilter.ExpressionStr := FilterString1 + ' AND ' + FilterString2
  end else
    Column.STFilter.ExpressionStr := FilterString1;
end;

procedure TDBGridEhSimpleFilterDialog.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := False;
  if ModalResult = mrOk then
    SetFilterFromDialog;
  CanClose := True;
end;

procedure TDBGridEhSimpleFilterDialog.DBComboBoxEh1Change(Sender: TObject);
begin
//  if (DBComboBoxEh1.Text <> '') and (ComboBox1.ItemIndex = 0) then
end;

end.
