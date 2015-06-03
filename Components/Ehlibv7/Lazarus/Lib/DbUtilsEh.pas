{*******************************************************}
{                                                       }
{                       EhLib v7.0                      }
{       Utilities to sort, filter data in DataSet       }
{                      Build 7.0.19                     }
{                                                       }
{      Copyright (c) 2002-2014 by Dmitry V. Bolshakov   }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit DbUtilsEh;

interface

uses
{$IFDEF EH_LIB_6} Variants, {$ENDIF}

{$IFDEF CIL}
  EhLibVCLNET,
  System.Runtime.InteropServices, System.Reflection,
{$ELSE}
{$IFDEF FPC}
  EhLibLCL, LCLType, Win32Extra, DBGridsEh,
{$ELSE}
  EhLibVCL, Messages, DBGridEh, Contnrs,
{$ENDIF}
{$IFDEF EH_LIB_9} WideStrings, {$ENDIF}
{$ENDIF}
  MemTableDataEh,
  Db, SysUtils, Classes, TypInfo, Windows, ToolCtrlsEh;

type

  TDateValueToSQLStringProcEh = function(DataSet: TDataSet; Value: Variant): String;
  TNullComparisonSyntaxEh = (ncsAsIsNullEh, ncsAsEqualToNullEh);

var

  STFilterOperatorsStrMapEh: array[TSTFilterOperatorEh] of String =
  ('', '=', '<>',
    '>', '<', '>=', '<=',
    '~', '!~',
    'In', '!In',
    {=}'Null', {<>}'Null',
    'AND', 'OR',
    '',
    {=}'Null', {<>}'Null');

{$IFDEF FPC}
  LFBr: String = '';
  RFBr: String = '';
{$ELSE}
  LFBr: String = '['; //Left Field Bracket
  RFBr: String = ']'; //Right Field Bracket
{$ENDIF}

const

  STFldTypeMapEh: array[TFieldType] of TSTOperandTypeEh = (
    botNon{ftUnknown}, botString{ftString}, botNumber{ftSmallint}, botNumber{ftInteger}, botNumber{ftWord},
    botBoolean{ftBoolean}, botNumber{ftFloat}, botNumber{ftCurrency}, botNumber{ftBCD}, botDateTime{ftDate}, botDateTime{ftTime}, botDateTime{ftDateTime},
    botNon{ftBytes}, botNon{ftVarBytes}, botNumber{ftAutoInc}, botNon{ftBlob}, botString{ftMemo}, botString{ftGraphic}, botString{ftFmtMemo},
    botString{ftParadoxOle}, botString{ftDBaseOle}, botString{ftTypedBinary}, botString{ftCursor}, botString{ftFixedChar}, botString{ftWideString},
    botNumber{ftLargeint}, botString{ftADT}, botString{ftArray}, botNon{ftReference}, botNon{ftDataSet}
{$IFDEF EH_LIB_5}
    ,botString{ftOraBlob}, botString{ftOraClob}, botString{ftVariant}, botNon{ftInterface}, botNon{ftIDispatch}, botString{ftGuid}
{$ENDIF}
{$IFDEF EH_LIB_6}, botDateTime{ftTimeStamp}, botNumber{ftFMTBcd}{$ENDIF}
{$IFDEF FPC}
    ,botString ,botString
{$ENDIF}
{$IFDEF EH_LIB_10}
    ,botString, botString, botNon, botString
{$ENDIF}
{$IFDEF EH_LIB_12}
    ,botNumber, botNumber, botNumber, botNumber, botNon, botNon, botNon
{$ENDIF}
{$IFDEF EH_LIB_13}
    ,botNon, botNon, botNon
{$ENDIF}
    );

  STFilterOperatorsSQLStrMapEh: array[TSTFilterOperatorEh] of String =
  ('', '=', '<>',
    '>', '<', '>=', '<=',
    'LIKE', 'NOT LIKE',
    'IN', 'NOT IN',
    'IS NULL', 'IS NOT NULL',
    'AND', 'OR',
    '',
    '= NULL', '<> NULL'
    );

procedure InitSTFilterOperatorsStrMap;

{ FilterExpression }

function ParseSTFilterExpressionEh(Exp: String; var FExpression: TSTFilterExpressionEh; DefaultOperator: TSTFilterDefaultOperatorEh): Boolean;
procedure ClearSTFilterExpression(var FExpression: TSTFilterExpressionEh);

type
  TOneExpressionFilterStringProcEh = function(O: TSTFilterOperatorEh; v: Variant;
    FieldName: String; DataSet: TDataSet;
    DateValueToSQLStringProc: TDateValueToSQLStringProcEh;
    SupportsLike: Boolean;
    NullComparisonSyntax: TNullComparisonSyntaxEh;
    InOperIsSupported: Boolean = False): String;

{ Useful routines to form filter string for dataset }

function GetExpressionAsFilterString(AGrid: TCustomDBGridEh;
  OneExpressionProc: TOneExpressionFilterStringProcEh;
  DateValueToSQLStringProc: TDateValueToSQLStringProcEh;
  UseFieldOrigin: Boolean = False;
  SupportsLocalLike: Boolean = False;
  NullComparisonSyntax: TNullComparisonSyntaxEh = ncsAsIsNullEh): String;

function GetOneExpressionAsLocalFilterString(O: TSTFilterOperatorEh;
  v: Variant; FieldName: String; DataSet: TDataSet;
  DateValueToSQLStringProc: TDateValueToSQLStringProcEh;
  SupportsLike: Boolean;
  NullComparisonSyntax: TNullComparisonSyntaxEh;
  InOperIsSupported: Boolean = False): String;

function GetOneExpressionAsSQLWhereString(O: TSTFilterOperatorEh; v: Variant;
  FieldName: String; DataSet: TDataSet;
  DateValueToSQLStringProc: TDateValueToSQLStringProcEh; SupportsLike: Boolean;
  NullComparisonSyntax: TNullComparisonSyntaxEh;
  InOperIsSupported: Boolean = False): String;

function DateValueToDataBaseSQLString(DataBaseName: String; v: Variant): String;

procedure ApplyFilterSQLBasedDataSet(Grid: TCustomDBGridEh; DataSet: TDataSet;
  DateValueToSQLString: TDateValueToSQLStringProcEh; IsReopen: Boolean;
  SQLPropName: String);

{ DatasetFeatures }

type

  TSimpleTextApplyFilterEh = procedure (Sender: TObject; DataSet: TDataSet;
    FieldName: String; Operation: TLSAutoFilterTypeEh; FilterText: String) of object;

  TDataSetClass = class of TDataSet;

  TDatasetFeaturesEh = class
  private
    FDataSetClass: TDataSetClass;
  public
    constructor Create; virtual;
    function BuildSortingString(AGrid: TCustomDBGridEh; DataSet: TDataSet): String; virtual;
    function CanFilterField(Field: TField): Boolean; virtual;
    function CheckFieldForSimpleTextFilter(Field: TField): Boolean; virtual;
    function CreateAndAsignMTDateField(DataStruct: TMTDataStructEh; AField: TField): TMTDataFieldEh; virtual;
    function GetLikeWildcardForSeveralCharacters: String; virtual;
    function LocateText(AGrid: TCustomDBGridEh; const FieldName: string; const Text: String; AOptions: TLocateTextOptionsEh; Direction: TLocateTextDirectionEh; Matching: TLocateTextMatchingEh; TreeFindRange: TLocateTextTreeFindRangeEh; TimeOut: LongWord = 0): Boolean; virtual;
    function MoveRecords(Sender: TObject; BookmarkList: TBMListEh; ToRecNo: Longint; CheckOnly: Boolean): Boolean; virtual;
    function NullComparisonSyntax(AGrid: TCustomDBGridEh; DataSet: TDataSet): TNullComparisonSyntaxEh; virtual;
    procedure ApplyFilter(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean); virtual;
    procedure ApplySimpleTextFilter(DataSet: TDataSet; FieldNames: String; Operation: TLSAutoFilterTypeEh; FilterText: String); virtual;
    procedure ApplySorting(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean); virtual;
    procedure ExecuteFindDialog(Sender: TObject; Text, FieldName: String; Modal: Boolean); virtual;
    procedure FillSTFilterListDataValues(AGrid: TCustomDBGridEh; Column: TColumnEh; Items: TStrings); virtual;
  end;

  TSQLDatasetFeaturesEh = class(TDatasetFeaturesEh)
  private
    FSortUsingFieldName: Boolean;
    FSQLPropName: String;
    FDateValueToSQLString: TDateValueToSQLStringProcEh;
    FSupportsLocalLike: Boolean;
  public
    constructor Create; override;
    procedure ApplySorting(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean); override;
    property SortUsingFieldName: Boolean read FSortUsingFieldName write FSortUsingFieldName;
    procedure ApplyFilter(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean); override;
    property SQLPropName: String read FSQLPropName  write FSQLPropName;
    property DateValueToSQLString: TDateValueToSQLStringProcEh read FDateValueToSQLString write FDateValueToSQLString;
    property SupportsLocalLike: Boolean read FSupportsLocalLike write FSupportsLocalLike;
  end;

  TCommandTextDatasetFeaturesEh = class(TSQLDatasetFeaturesEh)
  public
    constructor Create; override;
  end;

  TDatasetFeaturesEhClass = class of TDatasetFeaturesEh;

{ Register/Unregister DatasetFeatures }

procedure RegisterDatasetFeaturesEh(DatasetFeaturesClass: TDatasetFeaturesEhClass;
  DataSetClass: TDataSetClass);
procedure UnregisterDatasetFeaturesEh(DataSetClass: TDataSetClass);
function GetDatasetFeaturesForDataSet(DataSet: TDataSet): TDatasetFeaturesEh;
function GetDatasetFeaturesForDataSetClass(DataSetClass: TClass): TDatasetFeaturesEh;


function IsSQLBasedDataSet(DataSet: TDataSet; var SQL: TStrings): Boolean;
function IsDataSetHaveSQLLikeProp(DataSet: TDataSet; SQLPropName: String; var SQLPropValue: WideString): Boolean;

procedure ApplySortingForSQLBasedDataSet(Grid: TCustomDBGridEh; DataSet: TDataSet;
  UseFieldName: Boolean; IsReopen: Boolean; SQLPropName: String);

function LocateDatasetTextEh(AGrid: TCustomDBGridEh;
  const FieldName, Text: String; AOptions: TLocateTextOptionsEh;
  Direction: TLocateTextDirectionEh; Matching: TLocateTextMatchingEh;
  TreeFindRange: TLocateTextTreeFindRangeEh): Boolean;

function DefaultLocateDatasetTextEh(AGrid: TCustomDBGridEh;
  const FieldName, Text: String; AOptions: TLocateTextOptionsEh;
  Direction: TLocateTextDirectionEh; Matching: TLocateTextMatchingEh;
  TimeOut: LongWord = 0): Boolean;

function CharAtPos(const S: String; Pos: Integer): Char;

var
  SQLFilterMarker: String = '/*FILTER*/';

resourcestring

  // Filter expression operators
  SNotOperatorEh = 'Not';
  SAndOperatorEh = 'AND';
  SOrOperatorEh = 'OR';
  SLikePredicatEh = ''; // 'Like sign' //Use default sign '~'
  SInPredicatEh = 'In';
  SNullConstEh = 'Null';

implementation

uses
 DBGridEhFindDlgs, EhLibConsts;
  
procedure SetDataSetSQLLikeProp(DataSet: TDataSet; SQLPropName: String; SQLPropValue: WideString);
var
  FPropInfo: PPropInfo;
begin
  FPropInfo := GetPropInfo(DataSet.ClassInfo, SQLPropName);
  if FPropInfo = nil then Exit;
  if PropType_getKind(PropInfo_getPropType(FPropInfo)) = tkString then
    SetStrProp(DataSet, FPropInfo, SQLPropValue)
{$IFDEF EH_LIB_12}
  else if PropType_getKind(PropInfo_getPropType(FPropInfo)) = tkUString then
    SetStrProp(DataSet, FPropInfo, SQLPropValue)
{$ENDIF}
{$IFDEF EH_LIB_6}
  else if PropType_getKind(PropInfo_getPropType(FPropInfo)) = tkWString then
    SetWideStrProp(DataSet, FPropInfo, SQLPropValue)
{$ELSE}
  else if PropType_getKind(PropInfo_getPropType(FPropInfo)) = tkWString then
    SetStrProp(DataSet, FPropInfo, SQLPropValue)
{$ENDIF}
  else if PropType_getKind(PropInfo_getPropType(FPropInfo)) = tkClass then
    if TObject(GetOrdProp(DataSet, FPropInfo)) is TStrings then
      (TObject(GetOrdProp(DataSet, FPropInfo)) as TStrings).Text := SQLPropValue
{$IFDEF CIL}
{$ELSE}
  {$IFDEF EH_LIB_9}
    else if TObject(GetOrdProp(DataSet, FPropInfo)) is TWideStrings then
      (TObject(GetOrdProp(DataSet, FPropInfo)) as TWideStrings).Text := SQLPropValue
  {$ENDIF}
{$ENDIF}
    ;
end;

procedure ClearSTFilterExpression(var FExpression: TSTFilterExpressionEh);
begin
  FExpression.Operator1 := foNon;
  FExpression.Operand1 := Null;
  FExpression.Relation := foNon;
  FExpression.Operator2 := foNon;
  FExpression.Operand2 := Null;
end;

procedure InitSTFilterOperatorsStrMap;
var
  NotOperator: String;
begin
  if SNotOperatorEh <> ''
    then NotOperator := SNotOperatorEh + ' '
    else NotOperator := 'Not ';
  if SLikePredicatEh <> '' then
  begin
    STFilterOperatorsStrMapEh[foLike] := SLikePredicatEh;
    STFilterOperatorsStrMapEh[foNotLike] := NotOperator + SLikePredicatEh;
  end;
  if SInPredicatEh <> '' then
  begin
    STFilterOperatorsStrMapEh[foIn] := SInPredicatEh;
    STFilterOperatorsStrMapEh[foNotIn] := NotOperator + SInPredicatEh;
  end;
  if SNullConstEh <> '' then
  begin
    STFilterOperatorsStrMapEh[foNull] := SNullConstEh;
    STFilterOperatorsStrMapEh[foNotNull] := SNullConstEh;
  end;
  if SAndOperatorEh <> '' then
    STFilterOperatorsStrMapEh[foAND] := SAndOperatorEh;
  if SOrOperatorEh <> '' then
    STFilterOperatorsStrMapEh[foOR] := SOrOperatorEh;
end;

{$IFNDEF EH_LIB_6}
function StrCharLength(const Str: PChar): Integer;
begin
  if SysLocale.FarEast then
    Result := Integer(CharNext(Str)) - Integer(Str)
  else
    Result := 1;
end;

function NextCharIndex(const S: string; Index: Integer): Integer;
begin
  Result := Index + 1;
  assert((Index > 0) and (Index <= Length(S)));
  if SysLocale.FarEast and (S[Index] in LeadBytes) then
    Result := Index + StrCharLength(PChar(S) + Index - 1);
end;
{$ENDIF}

{$IFDEF FPC}
function NextCharIndex(const S: string; Index: Integer): Integer;
begin
  Result := Index + 1;
  assert((Index > 0) and (Index <= Length(S)));
  if SysLocale.FarEast and (S[Index] in LeadBytes) then
    Result := Index + StrCharLength(PChar(S) + Index - 1);
end;
{$ENDIF}

{ ParseSTFilterExpression }

type
  TOperator = (
    opNon, opEqual, opNotEqual,
    opGreaterThan, opLessThan, opGreaterOrEqual, opLessOrEqual,
    opLike,
    opIn,
    opAND, opOR,
    opValue,
    opNot, opComma, opOpenBracket, opCloseBracket, opQuote, opNullConst);

const
  OperatorAdvFilterOperatorMap: array[TOperator] of TSTFilterOperatorEh = (
    foNon, foEqual, foNotEqual,
    foGreaterThan, foLessThan, foGreaterOrEqual, foLessOrEqual,
    foLike,
    foIn,
    foAND, foOR,
    foValue,
    foNon, foNon, foNon, foNon, foNon, foNull);


function GetLexeme(const S: String; var Pos: Integer; var Operator: TSTFilterOperatorEh;
  PreferCommaForList: Boolean): Variant; forward;

function GetOperatorByWord(TheWord: String): TOperator;
begin
  Result := opNon;
  TheWord := AnsiUpperCase(TheWord);
  if (TheWord = 'NOT') or
     ((SNotOperatorEh <> '') and (TheWord = AnsiUpperCase(SNotOperatorEh))) then
    Result := opNot
  else if (TheWord = 'AND') or
          ((SAndOperatorEh <> '') and (TheWord = AnsiUpperCase(SAndOperatorEh))) then
    Result := opAND
  else if (TheWord = 'OR') or
          ((SOrOperatorEh <> '') and (TheWord = AnsiUpperCase(SOrOperatorEh))) then
    Result := opOR
  else if (TheWord = 'LIKE') or
          ((SLikePredicatEh <> '') and (TheWord = AnsiUpperCase(SLikePredicatEh))) then
    Result := opLIKE
  else if (TheWord = 'IN') or
          ((SInPredicatEh <> '') and (TheWord = AnsiUpperCase(SInPredicatEh))) then
    Result := opIN
  else if (TheWord = 'NULL') or
          ((SNullConstEh <> '') and (TheWord = AnsiUpperCase(SNullConstEh))) then
    Result := opNullConst;
end;

procedure ConvertVarStrValues(var v: Variant; ot: TSTOperandTypeEh);
var
  i: Integer;

  function StrToDateTimeEh(const s: String): Variant;
  begin
    if  SameText(s, 'NOW')
      then Result := s
      else Result := StrToDateTime(s);
  end;

begin
  if ot = botNumber then
  begin
    if not VarIsNull(v) then
      if VarIsArray(v) then
        for i := VarArrayLowBound(v, 1) to VarArrayHighBound(v, 1) do
          if SameText(v[i], 'Null') then
            v[i] := Null
          else
            v[i] := StrToFloat(v[i])
      else
        v := StrToFloat(v);
  end
  else if ot = botDateTime then
  begin
    if not VarIsNull(v) then
      if VarIsArray(v) then
        for i := VarArrayLowBound(v, 1) to VarArrayHighBound(v, 1) do
          if SameText(v[i], 'Null') then
            v[i] := Null
          else
            v[i] := StrToDateTimeEh(v[i])
      else
        v := StrToDateTimeEh(v);
  end;
end;

function SkipBlanks(const s: String; Pos: Integer): Integer;
var
  i: Integer;
begin
  Result := Pos;
  for i := Pos to Length(s) do
    if s[i] <> ' ' then
    begin
      Result := i;
      Break;
    end
end;

procedure SetOperatorPos(var Pos: Integer; Increment: Integer; var Op: TOperator; NewOp: TOperator);
begin
  Inc(Pos, Increment);
  Op := NewOp;
end;

function CharAtPos(const S: String; Pos: Integer): Char;
begin
  if (Length(S) < Pos) or (Pos <= 0) then
    Result := #0
  else
    Result := S[Pos];
end;

function ReadValue(const S: String; var Pos: Integer; PreferCommaForList: Boolean): Variant;

  function CheckForOperand(const S: String; Pos: Integer): Boolean;
  var
    Operator: TSTFilterOperatorEh;
  begin
    GetLexeme(S, Pos, Operator, PreferCommaForList);
    if Operator in [foEqual..foOR] then
      Result := True
    else
      Result := False;
  end;

var
  i: Integer;
  InSpecSign: Boolean;
begin
  Result := Null;
  if Pos > Length(S) then
    Exit;
  if S[Pos] = '''' then
  begin
    InSpecSign := False;
    for i := Pos + 1 to Length(S) do
    begin
      if (S[i] = '''') and not InSpecSign then
      begin
        Result := VarToStr(Result) + Copy(S, Pos + 1, i - Pos - 1);
        if CharAtPos(S,i+1) = '''' then
        begin
          Pos := i;
          InSpecSign := True
        end else
        begin
          Pos := i + 1;
          Exit;
        end;
      end else
        InSpecSign := False;
    end;

    raise Exception.Create(SQuoteIsAbsentEh + S);
  end
  else
  begin
    for i := Pos to Length(S) do
    begin
      if ( CharInSetEh(S[i], [' ']) and CheckForOperand(S, SkipBlanks(S, i))) or
        ( CharInSetEh(S[i], [')', '(']) ) or
        (PreferCommaForList and (S[i] = ',')) then
      begin
        Result := Copy(S, Pos, i - Pos);
        Pos := i;
        Exit;
      end;
    end;
    Result := Copy(S, Pos, MAXINT);
    Pos := Length(S) + 1;
  end;
end;

function ReadValues(const S: String; var Pos: Integer; PreferCommaForList: Boolean): Variant;
var
  i: Integer;
  vArr: Variant;
begin
  i := 0;
  vArr := VarArrayCreate([0, 0], varVariant);
  while True do
  begin
    vArr[i] := ReadValue(S, Pos, PreferCommaForList);
    if vArr[i] = Null then
      Break;
    if PreferCommaForList and (CharAtPos(S, Pos) = ',') then
      Inc(Pos)
    else
      Break;
    Inc(i);
    VarArrayRedimEh(vArr, i);
  end;
  if i = 0 then
    Result := vArr[0]
  else
    Result := vArr;
end;

function GetLexeme(const S: String; var Pos: Integer; var Operator: TSTFilterOperatorEh;
  PreferCommaForList: Boolean): Variant;
var
  Oper: TOperator;
  Operator1: TSTFilterOperatorEh;
  TheWord: String;

  function ReadWord(const S: String; Pos: Integer): String;
  var
    c: Char;
    NextPos: Integer;
  begin
    Result := '';
    while True do
    begin
      c := CharAtPos(S, Pos);
      if (c < #32) or CharInSetEh(c, [' ','(',')','>','<','=','!','~','&','|','.',',','''','"','+','-']) then
        Exit;
      NextPos := NextCharIndex(S,Pos);
      Result := Result + Copy(S,Pos,NextPos-Pos);
      Pos := NextPos;
    end;
  end;

begin
  if not (Operator in [foIn, foNotIn]) then
    Operator := foNon;
  Oper := opNon;
  Result := '';
  if Length(S) < Pos then
    Exit;
  if (S[Pos] = '''') or (Operator in [foIn, foNotIn]) then
  begin
    Result := ReadValues(S, Pos, PreferCommaForList);
    if VarIsArray(Result)
      then Operator := foIn
      else Operator := foValue;
  end
  else
  begin
    case S[Pos] of

      '!':
        if CharAtPos(S, Pos + 1) = '=' then
          SetOperatorPos(Pos, 2, Oper, opNotEqual)
        else
          SetOperatorPos(Pos, 1, Oper, opNot);
      '=':
        SetOperatorPos(Pos, 1, Oper, opEqual);
      '(':
        SetOperatorPos(Pos, 1, Oper, opOpenBracket);

      '>':
        if CharAtPos(S, Pos + 1) = '=' then
          SetOperatorPos(Pos, 2, Oper, opGreaterOrEqual)
        else
          SetOperatorPos(Pos, 1, Oper, opGreaterThan);
      '<':
        if CharAtPos(S, Pos + 1) = '=' then
          SetOperatorPos(Pos, 2, Oper, opLessOrEqual)
        else if CharAtPos(S, Pos + 1) = '>' then
          SetOperatorPos(Pos, 2, Oper, opNotEqual)
        else
          SetOperatorPos(Pos, 1, Oper, opLessThan);
      '~':
        SetOperatorPos(Pos, 1, Oper, opLike);
      '&':
        SetOperatorPos(Pos, 1, Oper, opAnd); //And
      '|':
        SetOperatorPos(Pos, 1, Oper, opOr); // Or
    else
      TheWord := ReadWord(S,Pos);
      Oper := GetOperatorByWord(TheWord);
      if Oper <> opNon then
        Inc(Pos, Length(TheWord));
    end; //case

    if Oper = opNon then
    begin
      Result := ReadValues(S, Pos, PreferCommaForList);
      if VarIsNull(Result) then
        Operator := foNon
      else if VarIsArray(Result) then
        Operator := foIn
      else
        Operator := foValue;
      Exit;
    end;

    Pos := SkipBlanks(S, Pos);

    if Oper = opNot then
    begin
      GetLexeme(S, Pos, Operator1, PreferCommaForList);
      case Operator1 of
        foLike: Operator := foNotLike;
        foIn: Operator := foNotIn;
        foNull: Operator := foNotNull;
      end
    end
    else if Oper = opIn then
    begin
      if CharAtPos(S, Pos) = '(' then
        Inc(Pos)
      else
        raise Exception.Create(SLeftBracketExpectedEh + S);
      Operator := foIn;
    end
    else
      Operator := OperatorAdvFilterOperatorMap[Oper];
  end;
end;

function ParseSTFilterExpression(Exp: String; var FExpression: TSTFilterExpressionEh): Boolean;

var
  PreferCommaForList: Boolean;

  procedure ResetPreferCommaForList;
  begin
    if (FExpression.ExpressionType = botNumber) and (FormatSettings.DecimalSeparator = ',') then
      PreferCommaForList := False
    else
      PreferCommaForList := True;
  end;

var
  v: Variant;
  op, op1: TSTFilterOperatorEh;
  p: Integer;
begin
  Result := False;

  ResetPreferCommaForList;

  FExpression.Operator1 := foNon;
  FExpression.Operand1 := Null;
  FExpression.Relation := foNon;
  FExpression.Operator2 := foNon;
  FExpression.Operand2 := Null;

  Exp := Trim(Exp);
  if Exp = '' then
    Exit;
  // 1 [Oper] + Values
  p := SkipBlanks(Exp, 1);
  v := GetLexeme(Exp, p, op, PreferCommaForList);
  if op = foValue then
  begin
    if VarIsArray(v) then
      FExpression.Operator1 := foIn
    else if FExpression.ExpressionType = botString then
      FExpression.Operator1 := foLike
    else
      FExpression.Operator1 := foEqual;
    FExpression.Operand1 := v;
  end
  else if (op = foNon) and (Length(Exp) <> 0) then
    raise Exception.Create(SErrorInExpressionEh + Exp)
  else
  begin
    if op in [foIn, foNotIn] then
      PreferCommaForList := True;
    p := SkipBlanks(Exp, p);
    v := GetLexeme(Exp, p, op1, PreferCommaForList);
    FExpression.Operator1 := op;
    if op1 = foNull then
      if op = foEqual then
        FExpression.Operator1 := foNull
      else if op = foNotEqual then
        FExpression.Operator1 := foNotNull
      else
        raise Exception.Create(SUnexpectedExpressionBeforeNullEh + Exp)
    else if op1 <> foValue then
      raise Exception.Create(SUnexpectedExpressionAfterOperatorEh + Exp);
    FExpression.Operand1 := v;
    if op in [foIn, foNotIn] then
    begin
      p := SkipBlanks(Exp, p);
      if CharAtPos(Exp, p) = ')' then
        Inc(p)
      else
        raise Exception.Create(SRightBracketExpectedEh + Exp);
      ResetPreferCommaForList;
    end;
  end;

  while True do
  begin
    // 2 And or Or
    p := SkipBlanks(Exp, p);
    v := GetLexeme(Exp, p, op, PreferCommaForList);
    if op = foNon then
      if p <> Length(Exp) + 1 then
        raise Exception.Create(SIncorrectExpressionEh + Exp)
      else
        Break;
    if not (op in [foAND, foOR]) then
      raise Exception.Create(SUnexpectedANDorOREh + Exp);
    FExpression.Relation := op;

    // 3 [Oper] + Values
    p := SkipBlanks(Exp, p);
    v := GetLexeme(Exp, p, op, PreferCommaForList);
    if op = foNon then
      if p <> Length(Exp) + 1 then
        raise Exception.Create(SIncorrectExpressionEh + Exp)
      else
        Break;
    if op = foValue then
    begin
      if VarIsArray(v) then
        FExpression.Operator2 := foIn
      else if FExpression.ExpressionType = botString then
        FExpression.Operator2 := foLike
      else
        FExpression.Operator2 := foEqual;
      FExpression.Operand2 := v;
    end
    else if (op = foNon) and (Length(Exp) <> 0) then
      raise Exception.Create(SErrorInExpressionEh + Exp)
    else
    begin
      if op in [foIn, foNotIn] then
        PreferCommaForList := True;
      p := SkipBlanks(Exp, p);
      v := GetLexeme(Exp, p, op1, PreferCommaForList);
      FExpression.Operator2 := op;
      if op1 = foNull then
        if op = foEqual then
          FExpression.Operator2 := foNull
        else if op = foNotEqual then
          FExpression.Operator2 := foNotNull
        else
          raise Exception.Create(SUnexpectedExpressionBeforeNullEh + Exp)
      else if op1 <> foValue then
        raise Exception.Create(SUnexpectedExpressionAfterOperatorEh + Exp);
      FExpression.Operand2 := v;
      ResetPreferCommaForList;
    end;
    Result := True;
    Break;
  end;

  if FExpression.Operator1 in [foEqual..foNotIn] then
    ConvertVarStrValues(FExpression.Operand1, FExpression.ExpressionType)
  else
    FExpression.Operand1 := Null;

  if FExpression.Operator2 in [foEqual..foNotIn] then
    ConvertVarStrValues(FExpression.Operand2, FExpression.ExpressionType)
  else
    FExpression.Operand2 := Null;
end;

function ParseSTFilterExpressionEh(Exp: String;
  var FExpression: TSTFilterExpressionEh;
  DefaultOperator: TSTFilterDefaultOperatorEh): Boolean;
var
  PreferCommaForList: Boolean;

  procedure ResetPreferCommaForList;
  begin
    PreferCommaForList := False
{    if (FExpression.ExpressionType = botNumber) and (FormatSettings.DecimalSeparator = ',') then
      PreferCommaForList := False
    else
      PreferCommaForList := True;}
  end;

  procedure MakeSimpleLike;
  begin
    FExpression.Operator1 := foLike;
    FExpression.Operand1 := Exp;
    FExpression.Relation := foNon;
    FExpression.Operator2 := foNon;
    FExpression.Operand2 := Null;
  end;

const
  OperatorForDefaultOperators: array[TSTFilterDefaultOperatorEh] of
    TSTFilterOperatorEh = (
      foNon, foEqual, foNotEqual,
      foGreaterThan, foLessThan, foGreaterOrEqual, foLessOrEqual,
      foLike, foNotLike,
      foIn, foNotIn,
      foLike, foNotLike,
      foLike, foNotLike,
      foLike, foNotLike);
var
  v: Variant;
  op, op1: TSTFilterOperatorEh;
  p: Integer;
  NoClosedComma: Boolean;
begin
  Result := False;

  ResetPreferCommaForList;

  FExpression.Operator1 := foNon;
  FExpression.Operand1 := Null;
  FExpression.Relation := foNon;
  FExpression.Operator2 := foNon;
  FExpression.Operand2 := Null;

  Exp := Trim(Exp);
  if Exp = '' then
    Exit;
  // 1 [Oper] + Values
  p := SkipBlanks(Exp, 1);
  v := GetLexeme(Exp, p, op, PreferCommaForList);
  if op = foValue then
  begin
    if DefaultOperator <> fdoAuto then
    begin
      FExpression.Operator1 := OperatorForDefaultOperators[DefaultOperator];
      if DefaultOperator in [fdoBeginsWith, fdoContains, fdoDoesntContain] then
      begin
        v := VarToStr(v);
        if CharAtPos(v, 1) <> '%' then
          v := v + '%';
      end;
      if DefaultOperator in [fdoEndsWith, fdoDoesntEndWith, fdoContains, fdoDoesntContain] then
      begin
        v := VarToStr(v);
        if CharAtPos(v, 1) <> '%' then
          v := '%' + v;
      end;
    end else if VarIsArray(v) then
      FExpression.Operator1 := foIn
    else if FExpression.ExpressionType = botString then
      FExpression.Operator1 := foLike
    else
      FExpression.Operator1 := foEqual;
    FExpression.Operand1 := v;
  end
  else if (op = foNon) and (Length(Exp) <> 0) then
    raise Exception.Create(SErrorInExpressionEh + Exp)
  else
  begin
    if op in [foIn, foNotIn] then
      PreferCommaForList := True;
    p := SkipBlanks(Exp, p);
    FExpression.Operator1 := op;
    NoClosedComma := False;
    op1 := op;
    if VarEquals(v, '') then
    begin
      v := GetLexeme(Exp, p, op1, PreferCommaForList);
      if op1 = foNull then
      begin
        if (op in [foIn, foNotIn]) then
          v := Null
        else if op = foEqual then
          FExpression.Operator1 := foNull
        else if op = foNotEqual then
          FExpression.Operator1 := foNotNull
        else
        begin
          MakeSimpleLike;
          Exit;
  //        raise Exception.Create(SUnexpectedExpressionBeforeNullEh + Exp)
        end;
      end else if not (op1 in [foValue, foIn]) then
          raise Exception.Create(SUnexpectedExpressionAfterOperatorEh + Exp);
    end else
      NoClosedComma := True;
    FExpression.Operand1 := v;
    if op in [foIn, foNotIn] then
    begin
      p := SkipBlanks(Exp, p);
      if CharAtPos(Exp, p) = ')' then
        Inc(p)
      else if not NoClosedComma then
      begin
        MakeSimpleLike;
        Exit;
//        raise Exception.Create(SRightBracketExpectedEh + Exp);
      end;
      ResetPreferCommaForList;
    end;
  end;

  while True do
  begin
    // 2 And or Or
    p := SkipBlanks(Exp, p);
    op := foNon;
    v := GetLexeme(Exp, p, op, PreferCommaForList);
    if op = foNon then
      if p <> Length(Exp) + 1 then
      begin
        MakeSimpleLike;
        Exit;
//        raise Exception.Create(SIncorrectExpressionEh + Exp)
      end else
        Break;
    if not (op in [foAND, foOR]) then
      raise Exception.Create(SUnexpectedANDorOREh + Exp);
    FExpression.Relation := op;

    // 3 [Oper] + Values
    p := SkipBlanks(Exp, p);
    v := GetLexeme(Exp, p, op, PreferCommaForList);
    if op = foNon then
      if p <> Length(Exp) + 1 then
        raise Exception.Create(SIncorrectExpressionEh + Exp)
      else
        Break;
    if op = foValue then
    begin
      if VarIsArray(v) then
        FExpression.Operator2 := foIn
      else if FExpression.ExpressionType = botString then
        FExpression.Operator2 := foLike
      else
        FExpression.Operator2 := foEqual;
      FExpression.Operand2 := v;
    end
    else if (op = foNon) and (Length(Exp) <> 0) then
      raise Exception.Create(SErrorInExpressionEh + Exp)
    else
    begin
      if op in [foIn, foNotIn] then
        PreferCommaForList := True;
      p := SkipBlanks(Exp, p);
      v := GetLexeme(Exp, p, op1, PreferCommaForList);
      FExpression.Operator2 := op;
      if op1 = foNull then
        if op = foEqual then
          FExpression.Operator2 := foNull
        else if op = foNotEqual then
          FExpression.Operator2 := foNotNull
        else
          raise Exception.Create(SUnexpectedExpressionBeforeNullEh + Exp)
      else if (op1 <> foValue) and (op1 <> foIn) then
        raise Exception.Create(SUnexpectedExpressionAfterOperatorEh + Exp);
      FExpression.Operand2 := v;
      ResetPreferCommaForList;
    end;
    Result := True;
    Break;
  end;

  if (FExpression.Relation in [foAND, foOR]) and (FExpression.Operator2 = foNon) then
    raise Exception.Create(SErrorInExpressionEh + Exp);

  if FExpression.Operator1 in [foEqual..foNotIn] then
    ConvertVarStrValues(FExpression.Operand1, FExpression.ExpressionType)
  else
    FExpression.Operand1 := Null;

  if FExpression.Operator2 in [foEqual..foNotIn] then
    ConvertVarStrValues(FExpression.Operand2, FExpression.ExpressionType)
  else
    FExpression.Operand2 := Null;
end;

function GetExpressionAsFilterString(AGrid: TCustomDBGridEh;
  OneExpressionProc: TOneExpressionFilterStringProcEh;
  DateValueToSQLStringProc: TDateValueToSQLStringProcEh;
  UseFieldOrigin: Boolean = False;
  SupportsLocalLike: Boolean = False;
  NullComparisonSyntax: TNullComparisonSyntaxEh = ncsAsIsNullEh): String;

  function GetExpressionAsString(Column: TColumnEh): String;
  var
    FieldName: String;
    ADataField: TField;
  begin
    if Column.LookupParams.LookupActive
      then ADataField := Column.LookupParams.KeyFields[0]
      else ADataField := Column.Field;

    if ADataField = nil then
      FieldName := ''
    else if UseFieldOrigin and (ADataField.Origin <> '') and (Column.STFilter.DataField = '') then
      FieldName := Column.Field.Origin
    else
      FieldName := Column.STFilter.GetFilterFieldName;
    Result := '';
    with Column.STFilter do
    begin
      if (Expression.ExpressionType = botNon) or (ADataField = nil) or (Expression.Operator1 = foNon) then
        Exit;
//      if KeyField <> '' then
//        Result := OneExpressionProc(Expression.Operator1, FKeyValues, FieldName, AGrid.DataSource.DataSet, DateValueToSQLStringProc)
//      else
      begin
//        Result := OneExpressionProc(Expression.Operator1, GetOperand1, FieldName,
        Result := OneExpressionProc(Expression.Operator1, Expression.Operand1, FieldName,
          AGrid.DataSource.DataSet, DateValueToSQLStringProc, SupportsLocalLike, NullComparisonSyntax);
        if Expression.Relation <> foNon then
        begin
          Result := Result + ' ' + STFilterOperatorsSQLStrMapEh[Expression.Relation];
//          Result := Result + OneExpressionProc(Expression.Operator2, GetOperand2,
          Result := Result + OneExpressionProc(Expression.Operator2, Expression.Operand2,
            FieldName, AGrid.DataSource.DataSet, DateValueToSQLStringProc, SupportsLocalLike, NullComparisonSyntax);
        end
      end;
      if Expression.Relation = foOR then
        Result := '(' + Result + ')';
    end;
  end;
var
  i: Integer;
  s: String;
begin
  Result := '';
  if (AGrid.DataSource <> nil) and (AGrid.DataSource.DataSet <> nil)
//    and AGrid.DataSource.DataSet.Active KMV #4
  then
  begin
    for i := 0 to AGrid.Columns.Count - 1 do
    begin
      s := GetExpressionAsString(TColumnEh(AGrid.Columns[i]));
      if s <> '' then
        Result := Result + s + ' AND ';
    end;
    Delete(Result, Length(Result) - 3, 4);
  end;
end;

function GetOneExpressionAsLocalFilterString(O: TSTFilterOperatorEh; v: Variant;
  FieldName: String; DataSet: TDataSet;
  DateValueToSQLStringProc: TDateValueToSQLStringProcEh;
  SupportsLike: Boolean;
  NullComparisonSyntax: TNullComparisonSyntaxEh;
  InOperIsSupported: Boolean = False): String;

  function VarValueAsFilterStr(v: Variant): String;
//  var
//    v1: Variant;
  begin
    if VarType(v) = varDouble then
      Result := FloatToStr(v)
    else if VarType(v) = varDate then
      if @DateValueToSQLStringProc <> nil then
        Result := DateValueToSQLStringProc(Dataset, v)
      else
        Result := '''' + DateTimeToStr(v) + ''''
    else
    begin
//      if VarIsArray(v) then
//        v1 := v[0];
      Result := VarToStr(v);
      Result := StringReplace(Result, '''', '''''',[rfReplaceAll]);
      Result := '''' + Result + '''';
    end;
  end;

  function ComposeExpressionForFieldList(FieldNames: String;
    O: TSTFilterOperatorEh; var VarValues: Variant): String;
  var
    Pos, i: Integer;
    FieldName: String;
  begin
    Result := '( ';
    Pos := 1;
    i := 0;
    while Pos <= Length(FieldNames) do
    begin
      if i > 0 then
        Result := Result + ' AND ';
      FieldName := ExtractFieldName(FieldNames, Pos);
      Result := Result +  ' ' + LFBr + FieldName + RFBr + ' ' + STFilterOperatorsSQLStrMapEh[O];
      if not (O in [foNull, foNotNull, foEqualToNull, foNotEqualToNull]) then
        Result := Result + ' ' + VarValueAsFilterStr(VarValues[i]);
      Inc(i);
    end;
    Result := Result + ' )';
  end;

var
  i: Integer;
  vin: Variant;
begin
  Result := '';
  if (O = foNull) and (NullComparisonSyntax = ncsAsEqualToNullEh) then
    O := foEqualToNull;
  if (O = foNotNull) and (NullComparisonSyntax = ncsAsEqualToNullEh) then
    O := foNotEqualToNull;

  if O in [foIn, foNotIn] then
  begin
    Result := Result + ' (';
    if InOperIsSupported then
    begin
      if O = foIn then
        Result := Result +  LFBr + FieldName + RFBr + ' In('
      else
        Result := Result +  LFBr + FieldName + RFBr + ' Not In(';
    end else
    begin
      if O = foNotIn then
        Result := ' NOT' + Result;
    end;
    if VarIsArray(v) then
      for i := VarArrayLowBound(v, 1) to VarArrayHighBound(v, 1) do
        if Pos(';', FieldName) <> 0 then
        begin
          vin := v[i];
          Result := Result + ComposeExpressionForFieldList(FieldName, foEqual, vin)  + ' OR '
        end else if InOperIsSupported then
        begin
          Result := Result + VarValueAsFilterStr(v[i]) + ' ,  '
        end else if VarIsNull(v[i]) then
          Result := Result + LFBr + FieldName + RFBr +' Is Null OR '
        else
          Result := Result + LFBr + FieldName + RFBr +' = ' + VarValueAsFilterStr(v[i]) + ' OR '
    else
      if Pos(';', FieldName) <> 0 then
        Result := ComposeExpressionForFieldList(FieldName, foEqual, v)  + ' OR '
      else
        Result := Result + LFBr + FieldName + RFBr +' = ' + VarValueAsFilterStr(v) + ' OR ';
    Delete(Result, Length(Result) - 3, 4);
    if InOperIsSupported then
      Result := Result + ') ';
    Result := Result + ')';
  end
  else if O in [foLike, foNotLike] then
  begin
    Result := Result +  ' ' + LFBr + FieldName;
    if SupportsLike then
      if O = foLike
        then Result := Result + RFBr + ' Like '
        else Result := ' Not (' + Result + RFBr + ' Like '
    else
      if O = foLike
        then Result := Result + RFBr + ' = '
        else Result := Result + RFBr + ' <> ';
    Result := Result + VarValueAsFilterStr(v);
    if SupportsLike and (O = foNotLike) then
      Result := Result + ')';
  end else
  begin
    if Pos(';', FieldName) <> 0 then
      Result := ComposeExpressionForFieldList(FieldName, O, v)
    else
    begin
      Result := Result +  ' ' + LFBr + FieldName + RFBr + ' ' + STFilterOperatorsSQLStrMapEh[O];
      if not (O in [foNull, foNotNull, foEqualToNull, foNotEqualToNull]) then
        Result := Result + ' ' + VarValueAsFilterStr(v);
    end;
  end;
end;

function GetOneExpressionAsSQLWhereString(O: TSTFilterOperatorEh; v: Variant;
  FieldName: String; DataSet: TDataSet;
  DateValueToSQLStringProc: TDateValueToSQLStringProcEh;
  SupportsLike: Boolean;
  NullComparisonSyntax: TNullComparisonSyntaxEh;
  InOperIsSupported: Boolean = False): String;

  function VarValueAsFilterStr(v: Variant): String;
  var
{$IFDEF CIL}
    OldDecimalSeparator: String;
{$ELSE}
    OldDecimalSeparator: Char;
{$ENDIF}
  begin
    if VarType(v) = varDouble then
    begin
      OldDecimalSeparator := FormatSettings.DecimalSeparator;
      FormatSettings.DecimalSeparator := '.';
      try
        Result := FloatToStr(v);
      finally
        FormatSettings.DecimalSeparator := OldDecimalSeparator;
      end;
    end
    else if VarType(v) = varDate then
      if @DateValueToSQLStringProc <> nil then
        Result := DateValueToSQLStringProc(DataSet, v)
      else
        Result := '''' + VarToStr(v) + ''''
    else
    begin
      Result := VarToStr(v);
      Result := StringReplace(Result, '''', '''''',[rfReplaceAll]);
      Result := '''' + Result + '''';
    end;
  end;

var
  i: Integer;
  theNOT: String;
begin
  Result := '';
  if (O = foNull) and (NullComparisonSyntax = ncsAsEqualToNullEh) then
    O := foEqualToNull;
  if (O = foNotNull) and (NullComparisonSyntax = ncsAsEqualToNullEh) then
    O := foNotEqualToNull;

  if O in [foIn, foNotIn] then
  begin
    if O = foNotIn then
      theNOT := ' NOT'
    else
      theNOT := '';
    Result := Result + FieldName + theNOT + ' IN (';
    if VarIsArray(v) then
      for i := VarArrayLowBound(v, 1) to VarArrayHighBound(v, 1) do
        Result := Result + VarValueAsFilterStr(v[i]) + ','
    else
      Result := Result + VarValueAsFilterStr(v) + ',';
    Delete(Result, Length(Result), 1);
    Result := Result + ')';
  end else
  begin
    Result := Result + ' ' + FieldName + ' ' + STFilterOperatorsSQLStrMapEh[O];
    if not (O in [foNull, foNotNull, foEqualToNull, foNotEqualToNull]) then
      Result := Result + ' ' + VarValueAsFilterStr(v);
  end;
end;

function DateValueToDataBaseSQLString(DataBaseName: String; v: Variant): String;
var
{$IFDEF CIL}
  OldDateSeparator: String;
{$ELSE}
  OldDateSeparator: Char;
{$ENDIF}
begin
  DataBaseName := UpperCase(DataBaseName);
  if DataBaseName = 'STANDARD' then
    Result := '''' + VarToStr(v) + ''''
  else if DataBaseName = 'ORACLE' then
    Result := 'TO_DATE(''' + FormatDateTime(FormatSettings.ShortDateFormat, v) + ''',''' + FormatSettings.ShortDateFormat + ''')'
  else if DataBaseName = 'INTRBASE' then
    Result := '''' + VarToStr(v) + ''''
  else if DataBaseName = 'INFORMIX' then
    Result := '''' + VarToStr(v) + ''''
  else if DataBaseName = 'MSACCESS' then
  begin
    OldDateSeparator := FormatSettings.DateSeparator;
    try
      FormatSettings.DateSeparator := '/';
      Result := '#' + FormatDateTime('MM/DD/YYYY', v) + '#';
    finally
      FormatSettings.DateSeparator := OldDateSeparator;
    end;
  end
  else if DataBaseName = 'MSSQL' then
//    Result := '''' + VarToStr(v) + ''''
//  http://msdn.microsoft.com/en-us/library/aa224042%28v=sql.80%29.aspx
// eight-digit unseparated string are always interpreted as YMD
    Result := QuotedStr(FormatDateTime('yyyymmdd hh:nn:ss', v))
  else if DataBaseName = 'SYBASE' then
    Result := '''' + VarToStr(v) + ''''
  else if DataBaseName = 'DB2' then
    Result := '''' + VarToStr(v) + ''''
  else
    Result := '''' + VarToStr(v) + '''';
end;

procedure ApplyFilterSQLBasedDataSet(Grid: TCustomDBGridEh; DataSet: TDataSet;
  DateValueToSQLString: TDateValueToSQLStringProcEh; IsReopen: Boolean;
  SQLPropName: String);
var
  i, OrderLine: Integer;
  s: String;
  SQL: TStrings;
  SQLPropValue: WideString;
begin
  if not IsDataSetHaveSQLLikeProp(DataSet, SQLPropName, SQLPropValue) then
    raise Exception.Create(DataSet.ClassName + ' is not SQL based dataset');

  SQL := TStringList.Create;
  try
    SQL.Text := SQLPropValue;

    OrderLine := -1;
    for i := 0 to SQL.Count - 1 do
      if UpperCase(Copy(SQL[i], 1, Length(SQLFilterMarker))) = UpperCase(SQLFilterMarker) then
      begin
        OrderLine := i;
        Break;
      end;
    s := GetExpressionAsFilterString(Grid, GetOneExpressionAsSQLWhereString, DateValueToSQLString, True);
    if s = '' then
      s := '1=1';
    if OrderLine = -1 then
      Exit;
    DataSet.DisableControls;
    try
      if DataSet.Active then
        DataSet.Close;
      SQL.Strings[OrderLine] := SQLFilterMarker + ' (' + s + ')';
      SetDataSetSQLLikeProp(DataSet, SQLPropName, SQL.Text);
      if IsReopen then
        DataSet.Open;
    finally
      DataSet.EnableControls;
    end;

  finally
    SQL.Free;
  end;
end;

{ Sorting }

function IsSQLBasedDataSet(DataSet: TDataSet; var SQL: TStrings): Boolean;
var
  FPropInfo: PPropInfo;
begin
  Result := False;
  SQL := nil;
  FPropInfo := GetPropInfo(DataSet.ClassInfo, 'SQL');
  if FPropInfo = nil then Exit;
  if PropType_getKind(PropInfo_getPropType(FPropInfo)) = tkClass then
  try
    SQL := (TObject(GetOrdProp(DataSet, FPropInfo)) as TStrings);
  except // if PropInfo is not TStrings or not inherited of
  end;

  if SQL <> nil then
    Result := True;
end;

function IsDataSetHaveSQLLikeProp(DataSet: TDataSet; SQLPropName: String; var SQLPropValue: WideString): Boolean;
var
  FPropInfo: PPropInfo;
begin
  Result := False;
  SQLPropValue := '';
  FPropInfo := GetPropInfo(DataSet.ClassInfo, SQLPropName);
  if FPropInfo = nil then Exit;
  if PropType_getKind(PropInfo_getPropType(FPropInfo)) = tkString then
    SQLPropValue := GetStrProp(DataSet, FPropInfo)
{$IFDEF EH_LIB_12}
  else if PropType_getKind(PropInfo_getPropType(FPropInfo)) = tkUString then
    SQLPropValue := GetStrProp(DataSet, FPropInfo)
{$ENDIF}
{$IFDEF EH_LIB_6}
  else if PropType_getKind(PropInfo_getPropType(FPropInfo)) = tkWString then
    SQLPropValue := GetWideStrProp(DataSet, FPropInfo)
{$ELSE}
  else if PropType_getKind(PropInfo_getPropType(FPropInfo)) = tkWString then
    SQLPropValue := GetStrProp(DataSet, FPropInfo)
{$ENDIF}
  else if PropType_getKind(PropInfo_getPropType(FPropInfo)) = tkClass then
    try
      if TObject(GetOrdProp(DataSet, FPropInfo)) is TStrings then
        SQLPropValue := (TObject(GetOrdProp(DataSet, FPropInfo)) as TStrings).Text
{$IFDEF CIL}
{$ELSE}
  {$IFDEF EH_LIB_9}
      else if TObject(GetOrdProp(DataSet, FPropInfo)) is TWideStrings then
        SQLPropValue := (TObject(GetOrdProp(DataSet, FPropInfo)) as TWideStrings).Text
  {$ENDIF}
{$ENDIF}
      else
        Exit;
    except // if PropInfo is not TStrings or not inherited of
    end
  else Exit;
  Result := True;
end;

procedure ApplySortingForSQLBasedDataSet(Grid: TCustomDBGridEh; DataSet: TDataSet;
   UseFieldName: Boolean; IsReopen: Boolean; SQLPropName: String);

  function GetDataFieldName(LookUpFieldName : String) : String;
  var
    FieldList: TList;
    i: Integer;
  begin
    Result := DataSet.FieldByName(LookUpFieldName).KeyFields;
    if UseFieldName then
      Result := StringReplace(Result, ';', ', ', [])
    else
    begin
      FieldList := TList.Create;
      try
        DataSet.GetFieldList(FieldList, Result);
        Result := '';
        for i := 0 to FieldList.Count-1 do
        begin
          if i > 0 then
            Result := Result + ', ';
          Result := Result + IntToStr(TField(FieldList[i]).FieldNo);
        end;
      finally
        FreeAndNil(FieldList);
      end;
    end;
  end;

var
  i, OrderLine: Integer;
  s: String;
  SQL: TStrings;
  SQLPropValue: WideString;
  SortOrder: TSortOrderEh;
  Field: TField;
  Fields: String;
begin
  if not IsDataSetHaveSQLLikeProp(DataSet, SQLPropName, SQLPropValue) then
    raise Exception.Create(DataSet.ClassName + ' is not SQL based dataset');

  SQL := TStringList.Create;
  try
    SQL.Text := SQLPropValue;

    s := '';
    for i := 0 to Grid.SortMarkedColumns.Count - 1 do
    begin
      Field := Grid.SortMarkedColumns[i].Field;
      if (Field <> nil) and (Field.FieldKind = fkLookup) then
        Fields := GetDataFieldName(Field.FieldName)
      else if UseFieldName then
        Fields := Grid.SortMarkedColumns[i].FieldName
      else if Field <> nil then
        Fields := IntToStr(Grid.SortMarkedColumns[i].Field.FieldNo);

//      s := s + Fields;

      SortOrder := Grid.Center.GetSortOrderForSortMarker(Grid,
        Grid.SortMarkedColumns[i], Grid.SortMarkedColumns[i].Title.SortMarker);
      if SortOrder = soDescEh
        then s := s + StringReplace(Fields, ',', ' DESC,', []) + ' DESC, '
        else s := s + Fields + ', ';
    end;

    if s <> '' then
      s := 'ORDER BY ' + Copy(s, 1, Length(s) - 2);

    OrderLine := -1;
    for i := 0 to SQL.Count - 1 do
      if UpperCase(Copy(SQL[i], 1, Length('ORDER BY'))) = 'ORDER BY' then
      begin
        OrderLine := i;
        Break;
      end;

    if OrderLine = -1 then
    begin
      if (SQL.Count = 0) or (SQL[SQL.Count-1] <> '') then
        SQL.Add('');
      OrderLine := SQL.Count-1;
    end;

    SQL.Strings[OrderLine] := s;

    DataSet.DisableControls;
    try
      if DataSet.Active then
        DataSet.Close;
      SetDataSetSQLLikeProp(DataSet, SQLPropName, SQL.Text);
      if IsReopen then
        DataSet.Open;
    finally
      DataSet.EnableControls;
    end;

  finally
    SQL.Free;
  end;
end;

function LocateDatasetTextEh(AGrid: TCustomDBGridEh;
  const FieldName, Text: String; AOptions: TLocateTextOptionsEh;
  Direction: TLocateTextDirectionEh; Matching: TLocateTextMatchingEh;
  TreeFindRange: TLocateTextTreeFindRangeEh): Boolean;
var
  DatasetFeatures: TDatasetFeaturesEh;
begin
  if (AGrid.DataSource <> nil) and (AGrid.DataSource.DataSet <> nil) then
  begin
    DatasetFeatures := GetDatasetFeaturesForDataSet(AGrid.DataSource.DataSet);
    if DatasetFeatures <> nil then
      Result := DatasetFeatures.LocateText(AGrid, FieldName, Text, AOptions, Direction, Matching, TreeFindRange)
    else
      Result := DefaultLocateDatasetTextEh(AGrid, FieldName, Text, AOptions, Direction, Matching);
  end else
    Result := DefaultLocateDatasetTextEh(AGrid, FieldName, Text, AOptions, Direction, Matching);
end;

function DefaultLocateDatasetTextEh(AGrid: TCustomDBGridEh;
  const FieldName, Text: String; AOptions: TLocateTextOptionsEh;
  Direction: TLocateTextDirectionEh; Matching: TLocateTextMatchingEh;
  TimeOut: LongWord = 0): Boolean;
var
  FCurInListColIndex: Integer;
  FCurRow: Integer;
  FCheckEof: Boolean;
  FCheckBof: Boolean;
  FFindFromStart: Boolean;
  FFindColList: TColumnsEhList;
  ticks: LongWord;

  function CheckEofBof: Boolean;
  begin
    if (ltoInsideSelection in AOptions) and
        (AGrid.Selection.SelectionType in [gstRecordBookmarks, gstRectangle]) then
      if AGrid.Selection.SelectionType = gstRecordBookmarks then
      begin
        if (Direction = ltdUpEh)
          then Result := FCheckBof
          else Result := FCheckEof;
      end else
      begin
        if (Direction = ltdUpEh)
          then Result := FCheckBof
          else Result := FCheckEof;
      end
    else
      if (Direction = ltdUpEh)
        then Result := AGrid.DataSource.DataSet.Bof
        else Result := AGrid.DataSource.DataSet.Eof;
  end;

  function CheckNextCol: Boolean;
  begin
    Result := FCurInListColIndex < FFindColList.Count-1;
    if Result then
      Inc(FCurInListColIndex);
  end;

  function CheckPrevCol: Boolean;
  begin
    Result := FCurInListColIndex > 0;
    if Result then
      Dec(FCurInListColIndex);
  end;

  procedure ResetCol(ToFirstCol: Boolean);
  begin
    if ToFirstCol then
      if ltoInsideSelection in AOptions then
        case AGrid.Selection.SelectionType of
          gstRecordBookmarks: FCurInListColIndex := 0;
          gstRectangle: FCurInListColIndex := 0;
          gstColumns: FCurInListColIndex := 0; // in AGrid.Selection.Columns
          gstAll: FCurInListColIndex := 0;
          gstNon: FCurInListColIndex := 0;
        end
      else
        FCurInListColIndex := 0
    else
      if ltoInsideSelection in AOptions then
        case AGrid.Selection.SelectionType of
          gstRecordBookmarks: FCurInListColIndex := FFindColList.Count-1;
          gstRectangle: FCurInListColIndex := FFindColList.Count-1;
          gstColumns: FCurInListColIndex := FFindColList.Count-1;
          gstAll: FCurInListColIndex := FFindColList.Count-1;
          gstNon: FCurInListColIndex := FFindColList.Count-1;
        end
      else
        FCurInListColIndex := FFindColList.Count-1
  end;

  procedure NextRec;
  begin
    if (ltoInsideSelection in AOptions) and
      (AGrid.Selection.SelectionType in [gstRecordBookmarks, gstRectangle]) then
      if AGrid.Selection.SelectionType = gstRecordBookmarks then
      begin
        if FCurRow < AGrid.Selection.Rows.Count-1 then
        begin
          Inc(FCurRow);
          AGrid.DataSource.DataSet.Bookmark := AGrid.Selection.Rows[FCurRow];
          FCheckEof := False;
        end else
          FCheckEof := True
      end else
      begin
        if DataSetCompareBookmarks(AGrid.DataSource.DataSet,
            AGrid.DataSource.DataSet.Bookmark, AGrid.Selection.Rect.BottomRow) <> 0 then
        begin
          AGrid.DataSource.DataSet.Next;
          FCheckEof := False;
          if AGrid.DataSource.DataSet.Eof then
            FCheckEof := True;
        end else
          FCheckEof := True;
      end
    else
      AGrid.DataSource.DataSet.Next;
  end;

  procedure PriorRec;
  begin
    if (ltoInsideSelection in AOptions) and
      (AGrid.Selection.SelectionType in [gstRecordBookmarks, gstRectangle]) then
      if AGrid.Selection.SelectionType = gstRecordBookmarks then
      begin
        if FCurRow > 0 then
        begin
          Dec(FCurRow);
          AGrid.DataSource.DataSet.Bookmark := AGrid.Selection.Rows[FCurRow];
          FCheckBof := False;
        end else
          FCheckBof := True;
      end else
      begin
        if DataSetCompareBookmarks(AGrid.DataSource.DataSet,
            AGrid.DataSource.DataSet.Bookmark, AGrid.Selection.Rect.TopRow) <> 0 then
        begin
          AGrid.DataSource.DataSet.Prior;
          FCheckBof := False;
        end else
          FCheckBof := True;
      end
    else
      AGrid.DataSource.DataSet.Prior;
  end;

  procedure ToNextRec;
  begin
    if ltoAllFieldsEh in AOptions then
      if (Direction = ltdUpEh) then
      begin
        if CheckPrevCol then
          //Ok
        else
        begin
          PriorRec;
          ResetCol(False);
        end;
      end else
      begin
        if CheckNextCol then
          // Ok
        else
        begin
          NextRec;
          ResetCol(True);
        end;
      end
    else if (Direction = ltdUpEh) then
      PriorRec
    else
      NextRec;
  end;

  procedure ResetRec(ToFirstRec: Boolean);
  begin
    if ToFirstRec then
      if (ltoInsideSelection in AOptions) and
        (AGrid.Selection.SelectionType in [gstRecordBookmarks, gstRectangle]) then
        case AGrid.Selection.SelectionType of
          gstRecordBookmarks: AGrid.DataSource.DataSet.Bookmark := AGrid.Selection.Rows[0];
          gstRectangle: AGrid.DataSource.DataSet.Bookmark := AGrid.Selection.Rect.TopRow;
        end
      else
        AGrid.DataSource.DataSet.First
    else
      if (ltoInsideSelection in AOptions) and
        (AGrid.Selection.SelectionType in [gstRecordBookmarks, gstRectangle]) then
        case AGrid.Selection.SelectionType of
          gstRecordBookmarks: AGrid.DataSource.DataSet.Bookmark := AGrid.Selection.Rows[AGrid.Selection.Rows.Count-1];
          gstRectangle: AGrid.DataSource.DataSet.Bookmark := AGrid.Selection.Rect.BottomRow;
        end
      else
        AGrid.DataSource.DataSet.Last;
    FCurInListColIndex := 0;
  end;

  function ColText(Col: TColumnEh): String;
  begin
    if ltoMatchFormatEh in AOptions then
      Result := Col.DisplayText
    else
      Result := Col.EditText;
  end;

  function AnsiContainsText(const AText, ASubText: string): Boolean;
  begin
    Result := AnsiPos(AnsiUppercase(ASubText), AnsiUppercase(AText)) > 0;
  end;

  function AnsiContainsStr(const AText, ASubText: string): Boolean;
  begin
    Result := AnsiPos(ASubText, AText) > 0;
  end;

  function IsEscapeInPressed: Boolean;
  var Msg: TMsg;
  begin
    Result := False;
    if PeekMessage(Msg, AGrid.Handle, WM_KEYDOWN, WM_KEYDOWN, PM_NOREMOVE) then
      if Msg.wParam = VK_ESCAPE then
        Result := True;
  end;

  procedure ResetAll;
  begin
    if Direction in [ltdAllEh, ltdDownEh] then
    begin
      ResetRec(True);
      ResetCol(True);
    end else
    begin
      ResetRec(False);
      ResetCol(False);
    end;
    FFindFromStart := True;
    FCheckEof := False;
    FCheckBof := False;
  end;

  procedure SetFoundIndex(Index: Integer);
  begin
    if AGrid.SearchPanel.Active
      then AGrid.SearchPanel.FoundColumnIndex := Index
      else AGrid.SelectedIndex := Index;
  end;

  function GetFoundIndex: Integer;
  begin
    if AGrid.SearchPanel.Active
      then Result := AGrid.SearchPanel.FoundColumnIndex
      else Result := AGrid.SelectedIndex;
    if Result < 0 then
      Result := 0;
  end;

  procedure FillFindColList;
  var
    i: Integer;
  begin
    if FieldName <> '' then
      FFindColList.Add(AGrid.FieldColumns[FieldName])
    else if (ltoInsideSelection in AOptions) and
      (AGrid.Selection.SelectionType in [gstRectangle, gstColumns]) then
    begin
      if AGrid.Selection.SelectionType = gstColumns then
      begin
        for i := 0 to AGrid.Selection.Columns.Count-1 do
          if AGrid.Center.CanColumnValueReadAsText(AGrid, AGrid.Selection.Columns[i]) then
            FFindColList.Add(AGrid.Selection.Columns[i])
      end else
      begin
        for i := AGrid.Selection.Rect.LeftCol to AGrid.Selection.Rect.RightCol do
          if AGrid.Columns[i].Visible and
            AGrid.Center.CanColumnValueReadAsText(AGrid, AGrid.Columns[i]) then
            FFindColList.Add(AGrid.Columns[i])
      end;
    end else if ltoAllFieldsEh in AOptions then
    begin
      for i := 0 to AGrid.VisibleColumns.Count-1 do
        if AGrid.Center.CanColumnValueReadAsText(AGrid, AGrid.VisibleColumns[i]) then
          FFindColList.Add(AGrid.VisibleColumns[i])
    end else
      FFindColList.Add(AGrid.Columns[AGrid.SelectedIndex])
  end;

var
  DataText: String;

begin
  Result := False;
  FCheckEof := False;
  FCheckBof := False;
  FFindFromStart := False;
  ticks := GetTickCount;

  FFindColList := TColumnsEhList.Create;
  FillFindColList;
  try

  if Assigned(AGrid) and
     Assigned(AGrid.DataSource) and
     Assigned(AGrid.DataSource.DataSet) and
     AGrid.DataSource.DataSet.Active and
     not AGrid.DataSource.DataSet.IsEmpty
  then
  begin
    FCurInListColIndex := FFindColList.IndexOf(AGrid.Columns[GetFoundIndex]);
    if FCurInListColIndex < 0 then
      FCurInListColIndex := 0;

    if  (ltoInsideSelection in AOptions) and
        (AGrid.Selection.SelectionType = gstRecordBookmarks) then
    begin
      FCurRow := AGrid.Selection.Rows.IndexOf(AGrid.DataSource.DataSet.Bookmark);
      if FCurRow < 0 then
      begin
        FCurRow := 0;
        AGrid.DataSource.DataSet.Bookmark := AGrid.Selection.Rows[0];
      end;
    end;

    if not AGrid.SearchPanel.Active and (dgRowSelect in AGrid.Options) and (FieldName = '') then
    begin
{      if (Direction = ltdUpEh)
        then FCurInListColIndex := 0
        else FCurInListColIndex := AGrid.VisibleColumns.Count-1;}
//      FCurInListColIndex := AGrid.VisibleColumns.IndexOf(
//          AGrid.Columns[AGrid.LeftCol-AGrid.IndicatorOffset]);
      FCurInListColIndex := 0;
    end;

    if (AGrid.VisibleColumns.Count = 0) then Exit;
    with AGrid do
    begin
      AGrid.DataSource.DataSet.DisableControls;
      try
        SaveBookmark;
//        if (Direction = ltdAllEh) and IsFirstTry then
        if (Direction = ltdAllEh) then
          ResetRec(True)
//        if not IsFirstTry then
//        if ltoIgnoteCurrentPosEh in AOptions then
        else
          ToNextRec;
        while True do
        begin
          if CheckEofBof then
            if FFindFromStart
              then Break
              else ResetAll;

          DataText := ColText(FFindColList[FCurInListColIndex]);

          //CharCase
          if not (ltoCaseInsensitiveEh in AOptions) then
          begin
            //From any part of field
            if ( (Matching = ltmAnyPartEh) and (AnsiContainsStr(DataText, Text) ))
            //Whole field
              or ((Matching = ltmWholeEh) and (DataText = Text))
              or ((Matching = ltmFromBegingEh) and
            //From beging of field
                   (Copy(DataText, 1, Length(Text)) = Text) )
            then
            begin
              Result := True;
              SetFoundIndex(FFindColList[FCurInListColIndex].Index);
//              IsFirstTry := False;
              Break;
            end
          end else //CaseInsensitive
          //From any part of field
          if ( (Matching = ltmAnyPartEh) and (AnsiContainsText(DataText, Text) ))
          //Whole field
           or ((Matching = ltmWholeEh) and (AnsiUpperCase(DataText) = AnsiUpperCase(Text)))
           or ((Matching = ltmFromBegingEh) and
          //From beging of field
            (AnsiUpperCase(Copy(DataText, 1, Length(Text))) = AnsiUpperCase(Text)) ) then
          begin
            Result := True;
            SetFoundIndex(FFindColList[FCurInListColIndex].Index);
//            IsFirstTry := False;
            Break;
          end;
          if (ltoStopOnEscape in AOptions) and
             IsEscapeInPressed
          then
            Break;
          if (TimeOut > 0) and ((GetTickCount - ticks) > TimeOut) then
            Break;
          ToNextRec;
        end;
        if not Result then RestoreBookmark;
      finally
        AGrid.DataSource.DataSet.EnableControls;
      end;
//      if not RecordFounded then
//        ShowMessage(Format(SFindDialogStringNotFoundMessageEh, [cbText.Text]));
    end;
  end;

  finally
    FreeAndNil(FFindColList);
  end;
end;

{ Dataset Features }

var
  DatasetFeaturesList: TStringList;

procedure RegisterDatasetFeaturesEh(DatasetFeaturesClass: TDatasetFeaturesEhClass;
  DataSetClass: TDataSetClass);
var
  DatasetFeatures: TDatasetFeaturesEh;
  ClassIndex: Integer;
begin
  DatasetFeatures := DatasetFeaturesClass.Create;
  DatasetFeatures.FDataSetClass := DataSetClass;
  if DatasetFeatures.FDataSetClass = nil then
    Exit;
  ClassIndex := DatasetFeaturesList.IndexOf(DatasetFeatures.FDataSetClass.ClassName);
  if ClassIndex >= 0
    then DatasetFeaturesList.Objects[ClassIndex] := DatasetFeatures
    else DatasetFeaturesList.AddObject(DatasetFeatures.FDataSetClass.ClassName,
            DatasetFeatures);
end;

procedure UnregisterDatasetFeaturesEh(DataSetClass: TDataSetClass);
var
  idx: Integer;
begin
  idx := DatasetFeaturesList.IndexOf(DataSetClass.ClassName);
  if idx >= 0 then
  begin
//    Dispose(Pointer(DatasetFeaturesList.Objects[idx]));
    TObject(DatasetFeaturesList.Objects[idx]).Free;
    DatasetFeaturesList.Delete(idx);
  end;
end;

function GetDatasetFeaturesForDataSetClass(DataSetClass: TClass): TDatasetFeaturesEh;

  function GetDatasetFeaturesDeep(DataSetClass: TClass; DataSetClassName: String): Integer;
  begin
    Result := 0;
    while True do
    begin
      if UpperCase(DataSetClass.ClassName) = UpperCase(DataSetClassName) then
        Exit;
      Inc(Result);
      DataSetClass := DataSetClass.ClassParent;
      if DataSetClass = nil then
      begin
        Result := MAXINT;
        Exit;
      end;
    end;
  end;

var
  Deep, MeenDeep, i: Integer;
  ClassName: String;
begin
  Result := nil;
  MeenDeep := MAXINT;
  for i := 0 to DatasetFeaturesList.Count - 1 do
  begin
    if DataSetClass.InheritsFrom(TDatasetFeaturesEh(DatasetFeaturesList.Objects[i]).FDataSetClass) then
    begin
      ClassName := TDatasetFeaturesEh(DatasetFeaturesList.Objects[i]).FDataSetClass.ClassName;
      Deep := GetDatasetFeaturesDeep(DataSetClass, ClassName);
      if Deep < MeenDeep then
      begin
        MeenDeep := Deep;
        Result := TDatasetFeaturesEh(DatasetFeaturesList.Objects[i]);
      end;
    end;
  end;
end;

function GetDatasetFeaturesForDataSet(DataSet: TDataSet): TDatasetFeaturesEh;
begin
  Result := GetDatasetFeaturesForDataSetClass(DataSet.ClassType);
end;

procedure DisposeDatasetFeaturesList;
begin
  while DatasetFeaturesList.Count > 0 do
  begin
//    Dispose(Pointer(DatasetFeaturesList.Objects[0]));
    TObject(DatasetFeaturesList.Objects[0]).Free;
    DatasetFeaturesList.Delete(0);
  end;
  FreeAndNil(DatasetFeaturesList);
//  DatasetFeaturesList := nil;
end;

{ TDatasetFeaturesEh }

procedure TDatasetFeaturesEh.ApplyFilter(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean);
begin
end;

procedure TDatasetFeaturesEh.ApplySorting(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean);
begin
end;

constructor TDatasetFeaturesEh.Create;
begin
  inherited Create;
end;

function TDatasetFeaturesEh.CreateAndAsignMTDateField(DataStruct: TMTDataStructEh; AField: TField): TMTDataFieldEh;
begin
  Result := DataStruct.BuildAndCopyDataFieldForField(AField);
end;

function TDatasetFeaturesEh.LocateText(AGrid: TCustomDBGridEh;
  const FieldName, Text: String; AOptions: TLocateTextOptionsEh;
  Direction: TLocateTextDirectionEh; Matching: TLocateTextMatchingEh;
  TreeFindRange: TLocateTextTreeFindRangeEh; TimeOut: LongWord = 0): Boolean;
begin
  Result := DefaultLocateDatasetTextEh(AGrid, FieldName, Text, AOptions, Direction, Matching, TimeOut);
end;

function TDatasetFeaturesEh.MoveRecords(Sender: TObject; BookmarkList: TBMListEh;
  ToRecNo: Integer; CheckOnly: Boolean): Boolean;
var
  va: array of Variant;
  vs: array of Boolean;
//  bm: TBookmarkStr;
  i, j: Integer;
  IsAppend: Boolean;
  DataSet: TDataSet;
  LocBookmarkList: TBMListEh;
begin
  Result := False;
  LocBookmarkList := nil;
  if (Sender is TDBGridEh)
    then DataSet := TDBGridEh(Sender).DataSource.DataSet
    else Exit;
  Result := DataSet.CanModify;
  if CheckOnly or not Result then Exit;
  DataSet.DisableControls;
  try
    LocBookmarkList := TBMListEh.Create;
//    LocBookmarkList.Assign(BookmarkList);
    for I := 0 to BookmarkList.Count - 1 do
//      LocBookmarkList.AppendItem(BookmarkList[i]);
      LocBookmarkList.InsertItem(0, BookmarkList[i]);

    if ToRecNo >= DataSet.RecordCount
      then IsAppend := True
      else IsAppend := False;
//    bm := DataSet.Bookmark;
    SetLength(va, BookmarkList.Count);
    SetLength(vs, BookmarkList.Count);
    for i := 0 to LocBookmarkList.Count-1 do
    begin
      DataSet.Bookmark := LocBookmarkList[i];
      va[i] := VarArrayCreate([0, DataSet.Fields.Count], varVariant);
      for j := 0 to DataSet.Fields.Count-1 do
        va[i][j] := DataSet.Fields[j].Value;
      if (i > 0) and (ToRecNo > DataSet.RecNo) then
        Dec(ToRecNo);
      vs[i] := TDBGridEh(Sender).SelectedRows.CurrentRowSelected;
      TDBGridEh(Sender).SelectedRows.CurrentRowSelected := False;
    end;
    for i := 0 to LocBookmarkList.Count-1 do
    begin
      DataSet.Bookmark := LocBookmarkList[i];
      DataSet.Delete;
    end;
    for i := Length(va)-1 downto 0 do
    begin
      if IsAppend then
        DataSet.Append
      else
      begin
        if i < Length(va)-1
          then DataSet.Next
          else DataSet.RecNo := ToRecNo;
        DataSet.Insert;
      end;
      for j := 0 to DataSet.Fields.Count-1 do
        if DataSet.Fields[j].CanModify then
          DataSet.Fields[j].Value := va[i][j];
      DataSet.Post;
      TDBGridEh(Sender).SelectedRows.CurrentRowSelected := vs[i];
    end;
//    DataSet.Bookmark := bm;
  finally
    LocBookmarkList.Free;
    DataSet.EnableControls;
  end;
end;

procedure TDatasetFeaturesEh.ExecuteFindDialog(Sender: TObject;
  Text, FieldName: String; Modal: Boolean);
begin
  if (Sender is TDBGridEh) then
    ExecuteDBGridEhFindDialogProc(TDBGridEh(Sender), Text, '', nil, Modal);
end;

procedure TDatasetFeaturesEh.FillSTFilterListDataValues(AGrid: TCustomDBGridEh; Column: TColumnEh; Items: TStrings);
begin
  if Assigned(AGrid.Center) then
     AGrid.Center.StandardFillSTFilterListDataValues(AGrid, Column, Items);
end;

procedure TDatasetFeaturesEh.ApplySimpleTextFilter(DataSet: TDataSet;
  FieldNames: String; Operation: TLSAutoFilterTypeEh; FilterText: String);
var
  swc1, swc2: String;
  FieldList: TList;
  i: Integer;
  FilterStr: String;
begin
  swc2 := GetLikeWildcardForSeveralCharacters;
  FieldList := TList.Create;
  try
  if (FieldNames = '') or (FieldNames = '*') then
  begin
    for i := 0 to DataSet.FieldCount-1 do
      if CanFilterField(DataSet.Fields[i]) then
        FieldList.Add(DataSet.Fields[i])
  end else
    DataSet.GetFieldList(FieldList, FieldNames);

  if Operation = lsftContainsEh
    then swc1 := swc2
    else swc1 := '';
  if DataSet <> nil then
    if FilterText <> '' then
    begin
      FilterStr := '';
      for i := 0 to FieldList.Count-1 do
      begin
        if CheckFieldForSimpleTextFilter(TField(FieldList[i])) then
        begin
          FilterStr := FilterStr + LFBr + TField(FieldList[i]).FieldName + RFBr + ' like ''' + swc1 +
            StringReplace(FilterText, '''', '''''', [rfReplaceAll])
            + swc2 + '''';
          FilterStr := FilterStr + ' OR ';
        end;
      end;
      FilterStr := Copy(FilterStr, 1, Length(FilterStr)-4);
      DataSet.Filter := FilterStr;
      DataSet.Filtered := True;
    end else
      DataSet.Filter := '';
  finally
    FreeAndNil(FieldList);
  end;
end;

function TDatasetFeaturesEh.GetLikeWildcardForSeveralCharacters: String;
begin
  Result := '*';
end;

function TDatasetFeaturesEh.CheckFieldForSimpleTextFilter(
  Field: TField): Boolean;
begin
  Result := Field.DataType in [ftString, ftMemo, ftFmtMemo,
    ftFixedChar, ftWideString, ftOraClob, ftGuid{$IFDEF EH_LIB_10}
    , ftFixedWideChar, ftWideMemo, ftOraInterval{$ENDIF}];
end;

function TDatasetFeaturesEh.CanFilterField(Field: TField): Boolean;
begin
  Result := Field.FieldKind in [fkData, fkInternalCalc];
end;

function TDatasetFeaturesEh.BuildSortingString(AGrid: TCustomDBGridEh; DataSet: TDataSet): String;
var
  s: String;
  i: Integer;
  SortOrder: TSortOrderEh;
  Field: TField;
  Fields: String;

  function GetDataFieldName(LookUpFieldName : String) : String;
  var
    FieldList: TList;
    i: Integer;
  begin
    Result := DataSet.FieldByName(LookUpFieldName).KeyFields;
    begin
      FieldList := TList.Create;
      try
        DataSet.GetFieldList(FieldList, Result);
        Result := '';
        for i := 0 to FieldList.Count-1 do
        begin
          if i > 0 then
            Result := Result + ', ';
          Result := '[' + TField(FieldList[i]).FieldName + ']';
        end;
      finally
        FreeAndNil(FieldList);
      end;
    end;
  end;

  begin
  s := '';
  for i := 0 to AGrid.SortMarkedColumns.Count - 1 do
  begin

    Field := AGrid.SortMarkedColumns[i].Field;
    if (Field <> nil) and (Field.FieldKind = fkLookup) then
      Fields := GetDataFieldName(Field.FieldName)
    else
      Fields := '[' + AGrid.SortMarkedColumns[i].FieldName + ']';

    s := s + Fields;

    SortOrder := AGrid.Center.GetSortOrderForSortMarker(AGrid,
      AGrid.SortMarkedColumns[i], AGrid.SortMarkedColumns[i].Title.SortMarker);
    if SortOrder = soDescEh
      then s := s + ' DESC, '
      else s := s + ', ';
  end;
  Result := Copy(s, 1, Length(s) - 2);
end;

function TDatasetFeaturesEh.NullComparisonSyntax(AGrid: TCustomDBGridEh;
  DataSet: TDataSet): TNullComparisonSyntaxEh;
begin
  Result := ncsAsIsNullEh;
end;

{ TSQLDatasetFeaturesEh }

constructor TSQLDatasetFeaturesEh.Create;
begin
  inherited Create;
  SQLPropName := 'SQL';
end;

procedure TSQLDatasetFeaturesEh.ApplyFilter(Sender: TObject;
  DataSet: TDataSet; IsReopen: Boolean);
begin
  if TDBGridEh(Sender).STFilter.Local then
  begin
    TDBGridEh(Sender).DataSource.DataSet.Filter :=
      GetExpressionAsFilterString(TDBGridEh(Sender),
        GetOneExpressionAsLocalFilterString, nil, False,
        SupportsLocalLike, NullComparisonSyntax(TDBGridEh(Sender), DataSet));
    TDBGridEh(Sender).DataSource.DataSet.Filtered := True;
  end else
    ApplyFilterSQLBasedDataSet(TDBGridEh(Sender), DataSet, DateValueToSQLString, IsReopen, SQLPropName);
end;

procedure TSQLDatasetFeaturesEh.ApplySorting(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean);
begin
  if Sender is TCustomDBGridEh then
    if TCustomDBGridEh(Sender).SortLocal then
      raise Exception.Create(Format ('TSQLDatasetFeaturesEh can not sort data ' +
        'in dataset "%s" in local mode', [DataSet.Name]))
    else
      ApplySortingForSQLBasedDataSet(TCustomDBGridEh(Sender), DataSet,
        SortUsingFieldName, IsReopen, SQLPropName);
end;

{ TCommandTextDatasetFeaturesEh }

constructor TCommandTextDatasetFeaturesEh.Create;
begin
  inherited Create;
  SQLPropName := 'CommandText';
end;

initialization
  DatasetFeaturesList := TStringList.Create;
  //  DatasetFeaturesList.CaseSensitive := False;
  DatasetFeaturesList.Duplicates := dupError;
finalization
  DisposeDatasetFeaturesList;
end.
