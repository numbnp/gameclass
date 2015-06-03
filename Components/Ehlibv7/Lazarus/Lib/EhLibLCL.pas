{*******************************************************}
{                                                       }
{                       EhLib v7.0                      }
{            Specific routines for VCL.Win32            }
{                      Build 7.0.11                     }
{                                                       }
{     Copyright (c) 2004-13 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit EhLibLCL;

interface

uses
  Windows, Forms, SysUtils, Classes, DB, TypInfo, Controls, Graphics,
{$IFDEF EH_LIB_6}
  Variants, Types,
{$ELSE}
  Consts,
{$ENDIF}

{$IFDEF FPC}
  LCLProc,
{$ELSE}
  RTLConsts, 
{$ENDIF}
  Messages, Math;

{$I EhlibVerInfo.Inc}
{$I EhLibEditionInfo.Inc}

type
  TCMParentFontChanged = TMessage;
  IntPtr = Pointer;
{$IFDEF EH_LIB_12}
  TUniBookmarkEh = TBookmark;
{$ELSE}
  TBytes = array of Byte;
  {$WARNINGS OFF}
  TUniBookmarkEh = TBookmarkStr;
  {$WARNINGS ON}
{$ENDIF}

{$IFNDEF EH_LIB_11}
  TRecordBuffer = PChar;
{$ENDIF}

  TVariantDynArray = array of Variant;
  TRectDynArray = array of TRect;

const
{$IFDEF EH_LIB_12}
  NilBookmarkEh = nil;
{$ELSE}
  NilBookmarkEh = '';
{$ENDIF}

LAYOUT_RTL_EH = $00000001;

{$IFDEF FPC}
const
  STextTrue: String = 'True';
  STextFalse: String = 'False';
  FilerSignature: array[1..4] of Char = 'TPF0';

type
  TStreamOriginalFormat = (sofUnknown, sofBinary, sofText);

  TDropDownAlign = (daLeft, daRight, daCenter);

{ TWinControlEh }

  TWinControlEh = class(TWinControl)
  protected
    procedure RecreateWndHandle;
  end;

{ TCustomControlEh }

  TCustomControlEh = class(TCustomControl)
  protected
    procedure RecreateWndHandle;
  end;

function DrawTextBiDiModeFlags(Control: TControl; Flags: Longint): Longint;
procedure PerformEraseBackground(Control: TControl; DC: HDC);

function WindowsScrollWindowEx(hWnd: HWND; dx, dy: Integer;
  var prcScroll,  prcClip: TRect;
  hrgnUpdate: HRGN; {prcUpdate: TRect; }flags: UINT): longint;

function DBUseRightToLeftAlignment(AControl: TControl; AField: TField): Boolean;
function OkToChangeFieldAlignment(AField: TField; Alignment: TAlignment): Boolean;

function VarTypeToDataType(VarType: Integer): TFieldType;
function TestStreamFormat(Stream: TStream): TStreamOriginalFormat;
function GetFieldProperty(DataSet: TDataSet; Control: TComponent; const FieldName: string): TField;


{$ELSE}
type

{ TWinControlEh }

  TWinControlEh = class(TWinControl)
  protected
    procedure RecreateWndHandle;
  end;

{ TCustomControlEh }

  TCustomControlEh = class(TCustomControl)
  protected
    procedure RecreateWndHandle;
  end;

function WindowsScrollWindowEx(hWnd: HWND; dx, dy: Integer;
  var prcScroll,  prcClip: TRect;
  hrgnUpdate: HRGN; {prcUpdate: TRect; }flags: UINT): BOOL;

{$ENDIF}

function CharInSetEh(C: Char; const CharSet: TSysCharSet): Boolean;
function VarToAnsiStr(const V: Variant): AnsiString;

procedure FillDWord(var Dest; Count, Value: Integer);

function DataSetCompareBookmarks(DataSet: TDataSet; Bookmark1, Bookmark2: TUniBookmarkEh): Integer;
function DataSetBookmarkValid(DataSet: TDataSet; Bookmark: TUniBookmarkEh): Boolean;

function GetMasterDataSet(FDataSet: TDataSet; APropInfo: PPropInfo): TDataSet;

function DrawTextEh(hDC: HDC; const Text: String; nCount: Integer;
  var lpRect: TRect; uFormat: UINT): Integer;
function WindowsDrawTextEx(DC: HDC; const lpchText: String; cchText: Integer;
  var p4: TRect;  dwDTFormat: UINT; DTParams: TDrawTextParams): Integer; overload;
function WindowsDrawTextEx(DC: HDC; const lpchText: String; cchText: Integer;
  var p4: TRect;  dwDTFormat: UINT): Integer; overload;

{function DrawTextEh(hDC: HDC; Text: WideString; nCount: Integer;
  var lpRect: TRect; uFormat: UINT): Integer; overload;
function WindowsDrawTextEx(DC: HDC; lpchText: WideString; cchText: Integer;
  var p4: TRect;  dwDTFormat: UINT; DTParams: TDrawTextParams): Integer; overload;
function WindowsDrawTextEx(DC: HDC; lpchText: WideString; cchText: Integer;
  var p4: TRect;  dwDTFormat: UINT): Integer; overload;
}

function WindowsExtTextOut(DC: HDC; X, Y: Integer; Options: Longint;
  var Rect: TRect; const Str: String; Count: Longint{; Dx: PInteger}): BOOL;

function WindowsGetOutlineTextMetrics(DC: HDC; p2: UINT; var OTMetricStructs: TOutlineTextMetric): UINT;

//function SendStructlParamMessage(hWnd: HWND; Msg: UINT; wParam: WPARAM; var lParam): LRESULT;
function SendStructMessage(hWnd: HWND; Msg: UINT; wParam: WPARAM; var lParam): LRESULT;
function SendTextMessage(hWnd: HWND; Msg: UINT; wParam: WPARAM; const lParam: string): LRESULT;
function SendGetTextMessage(hWnd: HWND; Msg: UINT; wParam: WPARAM; var lParam: string; BufferSize: Integer): LRESULT;

function SystemParametersInfoEh(uiAction, uiParam: UINT; var pvParam; fWinIni: UINT): BOOL;
function WindowsInvalidateRect(hWnd: HWND; var Rect: TRect; bErase: BOOL): BOOL;
function WindowsValidateRect(hWnd: HWND; var Rect: TRect): BOOL;
function WindowsScrollWindow(hWnd: HWND; dx, dy: Integer; var prcScroll, prcClip: TRect): BOOL;
function FindWindowEh(lpClassName, lpWindowName: String): HWND;

function WindowsLPtoDP(DC: HDC; var ARect: TRect): BOOL;
function WindowsCreatePolygonRgn(Points: array of TPoint; Count, FillMode: Integer): HRGN;
function GetFontSize(Font: TFont; Canvas: TCanvas = nil): Integer;
// WindowsSetStdCursor

function IsObjectAndIntegerRefSame(AObject: TObject; IntRef: Integer): Boolean;
function IntPtrToObject(AIntPtr: Integer): TObject;
function ObjectToIntPtr(AObject: TObject): Integer;
function IntPtrToString(AIntPtr: Integer): String;

procedure VarToMessage(var VarMessage; var Message: TMessage);
function MessageToTMessage(var Message): TMessage;
function MessageToTWMMouse(var Message): TWMMouse;
function MessageToTWMKey(var Message): TWMKey;
function UnwrapMessageEh(var Message): TMessage;

function SmallPointToInteger(SmallPoint: Windows.TSmallPoint): Integer;
function LongintToSmallPoint(Value: Longint): TSmallPoint;

procedure MessageSendGetSel(hWnd: HWND; var SelStart, SelEnd: Integer);

function NlsUpperCase(const S: String): String;
function NlsLowerCase(const S: String): String;
function NlsCompareStr(const S1, S2: String): Integer;
function NlsCompareText(const S1, S2: String): Integer;

function WideStringCompare(ws1, ws2: WideString; CharCount: Integer = 0; CaseInsensitive: Boolean = False): Integer;
function AnsiStringCompare(s1, s2: String; CharCount: Integer = 0; CaseInsensitive: Boolean = False): Integer;

procedure BitmapLoadFromResourceName(Bmp: TBitmap; Instance: THandle; const ResName: String);
function LoadBitmapEh(hInstance: HINST; lpBitmapID: Integer): HBITMAP;

//procedure Clipboard_SetBuffer(AClipboard: TClipboard; Format: Word; Buffer: TBytes; Size: Integer);

type
  TPropListArray = array of PPropInfo;

function GetPropListAsArray(ATypeInfo: PTypeInfo; TypeKinds: TTypeKinds): TPropListArray;

function HexToBinEh(Text: Pointer; var Buffer: TBytes; Count: Integer): Integer;
procedure BinToHexEh(Buffer: TBytes; var Text: String; Count: Integer);

procedure StreamWriteBytes(Stream: TStream; Buffer: TBytes);
procedure StreamReadBytes(Stream: TStream; var Buffer: TBytes; Count: Integer);

{$IFNDEF EH_LIB_12}
function BytesOf(S: String): TBytes; overload;
{$ENDIF}

{$IFNDEF EH_LIB_17}
function BytesOf(const Val: Pointer; const Len: integer): TBytes; overload;
{$ENDIF}

function PropInfo_getPropType(APropInfo: PPropInfo): PTypeInfo;
function PropInfo_getName(APropInfo: PPropInfo): String;
function PropType_getKind(APropType: PTypeInfo): TTypeKind;

procedure VarArrayRedimEh(var A : Variant; HighBound: Integer);

{$IFNDEF EH_LIB_5}

function GetObjectProp(Instance: TObject; PropInfo: PPropInfo): TObject;
function GetObjectPropClass(Instance: TObject; PropInfo: PPropInfo): TClass;
procedure SetObjectProp(Instance: TObject; PropInfo: PPropInfo; Value: TObject);

{$ENDIF}

function GetUltimateOwner(APersistent: TPersistent): TPersistent;

function LongMulDiv(Mult1, Mult2, Div1: Longint): Longint; stdcall;
function EmptyRect: TRect;
function IsRectEmptyEh(const Rect: TRect): Boolean;

function VariantToRefObject(Value: Variant): TObject;
function RefObjectToVariant(Value: TObject): Variant;
procedure DataVarCastAsObject(var Dest: Variant; const Source: Variant);

type

{ TFilerAccess }

  TFilerAccess = class(TInterfacedObject) // Same as TFilerAccess in D8.
  private
    FPersistent: TPersistent;
  public
    constructor Create(APersistent: TPersistent);
    procedure DefineProperties(AFiler: TFiler);
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent);
    function GetChildOwner: TComponent;
    function GetChildParent: TComponent;
    procedure SetAncestor(Value: Boolean);
    procedure SetChildOrder(Child: TComponent; Order: Integer);
    procedure Updated;
    procedure Updating;
  end;

{ TMemoryStreamEh }

  TMemoryStreamEh = class(TMemoryStream)
  private
    FHalfMemoryDelta: Integer;
  protected
    {$IFDEF FPC}
    function Realloc(var NewCapacity: NativeInt): Pointer; override;
    {$ELSE}
    function Realloc(var NewCapacity: Integer): Pointer; override;
    {$ENDIF}
  public
    constructor Create;
    property HalfMemoryDelta: Integer read FHalfMemoryDelta write FHalfMemoryDelta;
  end;

{$IFNDEF EH_LIB_6}

type
  IInterface = IUnknown;

  IInterfaceComponentReference = interface
    ['{E28B1858-EC86-4559-8FCD-6B4F824151ED}']
    function GetComponent: TComponent;
  end;

  TDragObjectEx = class(TDragObject)
  public
    procedure BeforeDestruction; override;
  end;

{$IFDEF EH_LIB_7}
{$ELSE}
  TSetLayeredWindowAttributes = function (Hwnd: THandle; crKey: COLORREF; bAlpha: Byte; dwFlags: DWORD): Boolean; stdcall;

const
  {$EXTERNALSYM WS_EX_LAYERED}
  WS_EX_LAYERED = $00080000;
{$EXTERNALSYM LWA_ALPHA}
  LWA_ALPHA = $00000002;
{$EXTERNALSYM LWA_COLORKEY}
  LWA_COLORKEY = $00000001;

  clSkyBlue = TColor($F0CAA6);

var
  SetLayeredWindowAttributes: TSetLayeredWindowAttributes = nil;

function CheckWin32Version(AMajor: Integer; AMinor: Integer = 0): Boolean;

{$ENDIF}

{$IFDEF EH_LIB_7}
{$ELSE}
const
//Delphi 5 or 6
  {$EXTERNALSYM CS_DROPSHADOW}
  CS_DROPSHADOW = $20000;
{$ENDIF}

const
  sLineBreak = {$IFDEF LINUX} #10 {$ELSE} #13#10 {$ENDIF};

function VarToWideStr(const V: Variant): WideString;

{$ENDIF}

function ExplicitLongwordToLongInt(v: Longword): LongInt;
function WStrCopy(Dest: PWideChar; const Source: PWideChar): PWideChar;

function SafeGetMouseCursorPos: TPoint;

procedure VarSetNull(var V: Variant); {$IFDEF EH_LIB_8} inline;{$ENDIF}
function VarIsNullEh(const V: Variant): Boolean; {$IFDEF EH_LIB_8} inline;{$ENDIF}

{$IFNDEF EH_LIB_13}
function CenteredRect(const SourceRect: TRect; const ACenteredRect: TRect): TRect;
{$ENDIF}

{$IFNDEF EH_LIB_14}
function PointToLParam(P: TPoint): LPARAM;
{$ENDIF}

{$IFDEF EH_LIB_6}
{$ELSE}
type
 TRoundToRange = -37..37;

function RoundTo(const AValue: Double; const ADigit: TRoundToRange): Double;

function VarIsStr(const V: Variant): Boolean;
{$ENDIF}

{$IFNDEF EH_LIB_16}

type

{ TCustomStyleServicesProxyEh }

  TCustomStyleServicesProxyEh = class(TObject)
  public
    function GetSystemColor(Color: TColor): TColor;
  end;

function StyleServices: TCustomStyleServicesProxyEh;

{$ENDIF}

{$IFNDEF EH_LIB_17}

type

{ TFormatSettingsProxyEh }

  TFormatSettingsProxyEh = class(TObject)
  private
    function GetDecimalSeparator: Char;
    function GetDateSeparator: Char;
    function GetTimeSeparator: Char;
    function GetThousandSeparator: Char;
    function GetShortDateFormat: String;
    function GetLongDateFormat: String;
    function GetLongTimeFormat: String;
    function GetCurrencyDecimals: Byte;
    function GetShortMonthNames(Index: Integer) : String;
    function GetLongMonthNames(Index: Integer) : String;
    function GetShortDayNames(Index: Integer) : String;
    function GetLongDayNames(Index: Integer) : String;
    function GetTwoDigitYearCenturyWindow: Word;

    procedure SetDecimalSeparator(Value: Char);
    procedure SetShortDateFormat(Value: String);
    procedure SetLongDateFormat(Value: String);
    procedure SetLongTimeFormat(Value: String);
    procedure SetDateSeparator(Value: Char);
    procedure SetTimeSeparator(Value: Char);
    procedure SetThousandSeparator(Value: Char);
    procedure SetCurrencyDecimals(Value: Byte);
    procedure SetShortMonthNames(Index: Integer; Value: String);
    procedure SetLongMonthNames(Index: Integer; Value: String);
    procedure SetShortDayNames(Index: Integer; Value: String);
    procedure SetLongDayNames(Index: Integer; Value: String);
    procedure SetTwoDigitYearCenturyWindow(Value: Word);
  public
    property DecimalSeparator: Char read GetDecimalSeparator write SetDecimalSeparator;
    property DateSeparator: Char read GetDateSeparator write SetDateSeparator;
    property TimeSeparator: Char read GetTimeSeparator write SetTimeSeparator;
    property CurrencyDecimals: Byte read GetCurrencyDecimals write SetCurrencyDecimals;
    property ThousandSeparator: Char read GetThousandSeparator write SetThousandSeparator;
    property ShortDateFormat: String read GetShortDateFormat write SetShortDateFormat;
    property LongDateFormat: String read GetLongDateFormat write SetLongDateFormat;
    property LongTimeFormat: String read GetLongTimeFormat write SetLongTimeFormat;

    property ShortMonthNames[Value: Integer] : String read GetShortMonthNames write SetShortMonthNames;
    property LongMonthNames[Value: Integer] : String read GetLongMonthNames write SetLongMonthNames;
    property ShortDayNames[Value: Integer] : String read GetShortDayNames write SetShortDayNames;
    property LongDayNames[Value: Integer] : String read GetLongDayNames write SetLongDayNames;

    property TwoDigitYearCenturyWindow: Word read GetTwoDigitYearCenturyWindow write SetTwoDigitYearCenturyWindow;
  end;

function FormatSettings: TFormatSettingsProxyEh;

{$ENDIF}

function SetLayout(hdc: HDC; dwLayout: DWORD): DWORD; stdcall;
  external gdi32 name 'SetLayout';

procedure KillMessage(Wnd: HWnd; Msg: Integer);
function SmallPointToPointEh(const P: TSmallPoint): TPoint;

implementation

function SmallPointToPointEh(const P: TSmallPoint): TPoint;
begin
  Result.X := P.X;
  Result.Y := P.Y;
end;

procedure KillMessage(Wnd: HWnd; Msg: Integer);
// Delete the requested message from the queue, but throw back
// any WM_QUIT msgs that PeekMessage may also return
var
  M: TMsg;
begin
  M.Message := 0;
  if PeekMessage(M, Wnd, Msg, Msg, pm_Remove) and (M.Message = WM_QUIT) then
    PostQuitMessage(M.wparam);
end;

{$IFNDEF EH_LIB_17}

{ TFormatSettingsProxyEh }

function TFormatSettingsProxyEh.GetTwoDigitYearCenturyWindow: Word;
begin
{$IFDEF EH_LIB_17}
    Result := System.SysUtils.FormatSettings.TwoDigitYearCenturyWindow;
{$ELSE}
    Result := SysUtils.TwoDigitYearCenturyWindow;
{$ENDIF}
end;

procedure TFormatSettingsProxyEh.SetTwoDigitYearCenturyWindow(Value: Word);
begin
{$IFDEF EH_LIB_17}
    System.SysUtils.FormatSettings.TwoDigitYearCenturyWindow := Value;
{$ELSE}
    SysUtils.TwoDigitYearCenturyWindow := Value;
{$ENDIF}
end;

function TFormatSettingsProxyEh.GetShortMonthNames(Index : Integer) : String;
begin
{$IFDEF EH_LIB_17}
  Result := System.SysUtils.FormatSettings.ShortMonthNames[Index];
{$ELSE}
  {$IFDEF FPC}
  Result := DefaultFormatSettings.ShortMonthNames[Index];
  {$ELSE}
  Result := SysUtils.ShortMonthNames[Index];
  {$ENDIF}
{$ENDIF}
end;

procedure TFormatSettingsProxyEh.SetShortMonthNames(Index: Integer; Value: String);
begin
{$IFDEF EH_LIB_17}
    System.SysUtils.FormatSettings.ShortMonthNames[Index] := Value;
{$ELSE}
  {$IFDEF FPC}
  DefaultFormatSettings.ShortMonthNames[Index] := Value;
  {$ELSE}
  SysUtils.ShortMonthNames[Index] := Value;
  {$ENDIF}
{$ENDIF}
end;

function TFormatSettingsProxyEh.GetLongMonthNames(Index : Integer) : String;
begin
{$IFDEF EH_LIB_17}
    Result := System.SysUtils.FormatSettings.LongMonthNames[Index];
{$ELSE}
  {$IFDEF FPC}
  Result := DefaultFormatSettings.LongMonthNames[Index];
  {$ELSE}
  Result := SysUtils.LongMonthNames[Index];
  {$ENDIF}
{$ENDIF}
end;

procedure TFormatSettingsProxyEh.SetLongMonthNames(Index: Integer; Value: String);
begin
{$IFDEF EH_LIB_17}
  System.SysUtils.FormatSettings.LongMonthNames[Index] := Value;
{$ELSE}
  {$IFDEF FPC}
  DefaultFormatSettings.LongMonthNames[Index] := Value;
  {$ELSE}
  SysUtils.LongMonthNames[Index] := Value;
  {$ENDIF}
{$ENDIF}
end;

function TFormatSettingsProxyEh.GetShortDayNames(Index : Integer) : String;
begin
{$IFDEF EH_LIB_17}
  Result := System.SysUtils.FormatSettings.ShortDayNames[Index];
{$ELSE}
  {$IFDEF FPC}
  Result := DefaultFormatSettings.ShortDayNames[Index];
  {$ELSE}
  Result := SysUtils.ShortDayNames[Index];
  {$ENDIF}
{$ENDIF}
end;

procedure TFormatSettingsProxyEh.SetShortDayNames(Index: Integer; Value: String);
begin
{$IFDEF EH_LIB_17}
  System.SysUtils.FormatSettings.ShortDayNames[Index] := Value;
{$ELSE}
  {$IFDEF FPC}
  DefaultFormatSettings.ShortDayNames[Index] := Value;
  {$ELSE}
  SysUtils.ShortDayNames[Index] := Value;
  {$ENDIF}
{$ENDIF}
end;

function TFormatSettingsProxyEh.GetlongDayNames(Index : Integer) : String;
begin
{$IFDEF EH_LIB_17}
  Result := System.SysUtils.FormatSettings.longDayNames[Index];
{$ELSE}
  {$IFDEF FPC}
  Result := DefaultFormatSettings.LongDayNames[Index];
  {$ELSE}
  Result := SysUtils.LongDayNames[Index];
  {$ENDIF}
{$ENDIF}
end;

procedure TFormatSettingsProxyEh.SetlongDayNames(Index: Integer; Value: String);
begin
{$IFDEF EH_LIB_17}
  System.SysUtils.FormatSettings.longDayNames[Index] := Value;
{$ELSE}
  {$IFDEF FPC}
  DefaultFormatSettings.LongDayNames[Index] := Value;
  {$ELSE}
  SysUtils.LongDayNames[Index] := Value;
  {$ENDIF}
{$ENDIF}
end;

function TFormatSettingsProxyEh.GetDecimalSeparator: Char;
begin
{$IFDEF EH_LIB_17}
  Result := System.SysUtils.FormatSettings.DecimalSeparator;
{$ELSE}
  {$IFDEF FPC}
  Result := DefaultFormatSettings.DecimalSeparator;
  {$ELSE}
  Result := SysUtils.DecimalSeparator;
  {$ENDIF}
{$ENDIF}
end;

procedure TFormatSettingsProxyEh.SetDecimalSeparator(Value: Char);
begin
{$IFDEF EH_LIB_17}
  System.SysUtils.FormatSettings.DecimalSeparator := Value;
{$ELSE}
  {$IFDEF FPC}
  DefaultFormatSettings.DecimalSeparator := Value;
  {$ELSE}
  SysUtils.DecimalSeparator := Value;
  {$ENDIF}
{$ENDIF}
end;

function TFormatSettingsProxyEh.GetDateSeparator: Char;
begin
{$IFDEF EH_LIB_17}
  Result := System.SysUtils.FormatSettings.DateSeparator;
{$ELSE}
  {$IFDEF FPC}
  Result := DefaultFormatSettings.DateSeparator;
  {$ELSE}
  Result := SysUtils.DateSeparator;
  {$ENDIF}
{$ENDIF}
end;

procedure TFormatSettingsProxyEh.SetDateSeparator(Value: Char);
begin
{$IFDEF EH_LIB_17}
  System.SysUtils.FormatSettings.DateSeparator := Value;
{$ELSE}
  {$IFDEF FPC}
  DefaultFormatSettings.DateSeparator := Value;
  {$ELSE}
  SysUtils.DateSeparator := Value;
  {$ENDIF}
{$ENDIF}
end;

function TFormatSettingsProxyEh.GetTimeSeparator: Char;
begin
{$IFDEF EH_LIB_17}
  Result := System.SysUtils.FormatSettings.TimeSeparator;
{$ELSE}
  {$IFDEF FPC}
  Result := DefaultFormatSettings.TimeSeparator;
  {$ELSE}
  Result := SysUtils.TimeSeparator;
  {$ENDIF}
{$ENDIF}
end;

procedure TFormatSettingsProxyEh.SetTimeSeparator(Value: Char);
begin
{$IFDEF EH_LIB_17}
  System.SysUtils.FormatSettings.TimeSeparator := Value;
{$ELSE}
  {$IFDEF FPC}
  DefaultFormatSettings.TimeSeparator := Value;
  {$ELSE}
  SysUtils.TimeSeparator := Value;
  {$ENDIF}
{$ENDIF}
end;

function TFormatSettingsProxyEh.GetThousandSeparator: Char;
begin
{$IFDEF EH_LIB_17}
  Result := System.SysUtils.FormatSettings.ThousandSeparator;
{$ELSE}
  {$IFDEF FPC}
  Result := DefaultFormatSettings.ThousandSeparator;
  {$ELSE}
  Result := SysUtils.ThousandSeparator;
  {$ENDIF}
{$ENDIF}
end;

procedure TFormatSettingsProxyEh.SetThousandSeparator(Value: Char);
begin
{$IFDEF EH_LIB_17}
  System.SysUtils.FormatSettings.ThousandSeparator := Value;
{$ELSE}
  {$IFDEF FPC}
  DefaultFormatSettings.ThousandSeparator := Value;
  {$ELSE}
  SysUtils.ThousandSeparator := Value;
  {$ENDIF}
{$ENDIF}
end;

function TFormatSettingsProxyEh.GetShortDateFormat: String;
begin
{$IFDEF EH_LIB_17}
  Result := System.SysUtils.FormatSettings.ShortDateFormat;
{$ELSE}
  {$IFDEF FPC}
  Result := DefaultFormatSettings.ShortDateFormat;
  {$ELSE}
  Result := SysUtils.ShortDateFormat;
  {$ENDIF}
{$ENDIF}
end;

procedure TFormatSettingsProxyEh.SetShortDateFormat(Value: String);
begin
{$IFDEF EH_LIB_17}
  System.SysUtils.FormatSettings.ShortDateFormat := Value;
{$ELSE}
  {$IFDEF FPC}
  DefaultFormatSettings.ShortDateFormat := Value;
  {$ELSE}
  SysUtils.ShortDateFormat := Value;
  {$ENDIF}
{$ENDIF}
end;

function TFormatSettingsProxyEh.GetLongDateFormat: String;
begin
{$IFDEF EH_LIB_17}
  Result := System.SysUtils.FormatSettings.LongDateFormat;
{$ELSE}
  {$IFDEF FPC}
  Result := DefaultFormatSettings.LongDateFormat;
  {$ELSE}
  Result := SysUtils.LongDateFormat;
  {$ENDIF}
{$ENDIF}
end;

procedure TFormatSettingsProxyEh.SetLongDateFormat(Value: String);
begin
{$IFDEF EH_LIB_17}
  System.SysUtils.FormatSettings.LongDateFormat := Value;
{$ELSE}
  {$IFDEF FPC}
  DefaultFormatSettings.LongDateFormat := Value;
  {$ELSE}
  SysUtils.LongDateFormat := Value;
  {$ENDIF}
{$ENDIF}
end;

function TFormatSettingsProxyEh.GetLongTimeFormat: String;
begin
{$IFDEF EH_LIB_17}
  Result := System.SysUtils.FormatSettings.LongTimeFormat;
{$ELSE}
  {$IFDEF FPC}
  Result := DefaultFormatSettings.LongTimeFormat;
  {$ELSE}
  Result := SysUtils.LongTimeFormat;
  {$ENDIF}
{$ENDIF}
end;

procedure TFormatSettingsProxyEh.SetLongTimeFormat(Value: String);
begin
{$IFDEF EH_LIB_17}
  System.SysUtils.FormatSettings.LongTimeFormat := Value;
{$ELSE}
  {$IFDEF FPC}
  DefaultFormatSettings.LongTimeFormat := Value;
  {$ELSE}
  SysUtils.LongTimeFormat := Value;
  {$ENDIF}
{$ENDIF}
end;

function TFormatSettingsProxyEh.GetCurrencyDecimals: Byte;
begin
{$IFDEF EH_LIB_17}
  Result := System.SysUtils.FormatSettings.CurrencyDecimals;
{$ELSE}
  {$IFDEF FPC}
  Result := DefaultFormatSettings.CurrencyDecimals;
  {$ELSE}
  Result := SysUtils.CurrencyDecimals;
  {$ENDIF}
{$ENDIF}
end;

procedure TFormatSettingsProxyEh.SetCurrencyDecimals(Value: Byte);
begin
{$IFDEF EH_LIB_17}
  System.SysUtils.FormatSettings.CurrencyDecimals:= Value;
{$ELSE}
  {$IFDEF FPC}
  DefaultFormatSettings.CurrencyDecimals := Value;
  {$ELSE}
  SysUtils.CurrencyDecimals := Value;
  {$ENDIF}
{$ENDIF}
end;

{ FormatSettingsEh }

var
  FFormatSettings: TFormatSettingsProxyEh;

function FormatSettings: TFormatSettingsProxyEh;
begin
  if FFormatSettings = nil then
    FFormatSettings := TFormatSettingsProxyEh.Create;
  Result := FFormatSettings;
end;

{$ENDIF}

{ Functions }

{$IFNDEF EH_LIB_16}

var
  FStyleServices: TCustomStyleServicesProxyEh;

function StyleServices: TCustomStyleServicesProxyEh;
begin
  if FStyleServices = nil then
    FStyleServices := TCustomStyleServicesProxyEh.Create;
  Result := FStyleServices;
end;

{$ENDIF}

{$IFNDEF EH_LIB_13}
function CenteredRect(const SourceRect: TRect; const ACenteredRect: TRect): TRect;
var
  Width, Height: Integer;
  X, Y: Integer;
begin
  Width := ACenteredRect.Right - ACenteredRect.Left;
  Height := ACenteredRect.Bottom - ACenteredRect.Top;
  X := (SourceRect.Right + SourceRect.Left) div 2;
  Y := (SourceRect.Top + SourceRect.Bottom) div 2;
  Result := Rect(X - Width div 2, Y - Height div 2, X + (Width + 1) div 2, Y + (Height + 1) div 2);
end;
{$ENDIF}

{$IFNDEF EH_LIB_14}
function PointToLParam(P: TPoint): LPARAM;
begin
  Result := LPARAM((P.X and $0000ffff) or (P.Y shl 16));
end;
{$ENDIF}

function VarIsNullEh(const V: Variant): Boolean;
begin
{$IFDEF CIL}
  Result := VarIsNull(V);
{$ELSE}
  Result := TVarData(V).VType = varNull;
{$ENDIF}
end;

procedure VarSetNull(var V: Variant);
const
  varDeepData = $BFE8;
begin
  if (TVarData(V).VType and varDeepData) = 0 then
    TVarData(V).VType := varNull
  else
  begin
    VarClear(V);
    TVarData(V).VType := varNull;
  end;
end;

{$IFDEF EH_LIB_6}
{$ELSE}
//Delphi 5
function CheckWin32Version(AMajor: Integer; AMinor: Integer = 0): Boolean;
begin
  Result := (AMajor > Win32MajorVersion) or
            ((AMajor = Win32MajorVersion) and
             (AMinor >= Win32MinorVersion));
end;
{$ENDIF}

function LongMulDiv(Mult1, Mult2, Div1: Longint): Longint; stdcall;
{$IFDEF LINUX}
  external 'libwine.borland.so' name 'MulDiv';
{$ELSE}
  external 'kernel32.dll' name 'MulDiv';
{$ENDIF}

function CharInSetEh(C: Char; const CharSet: TSysCharSet): Boolean;
begin
{$IFDEF EH_LIB_12}
  Result := CharInSet(C, CharSet);
{$ELSE}
  Result := C in CharSet;
{$ENDIF}
end;

function VarToAnsiStr(const V: Variant): AnsiString;
begin
  if not VarIsNull(V)
    then Result := AnsiString(V)
    else Result := AnsiString('');
end;

function WideStringCompare(ws1, ws2: WideString; CharCount: Integer = 0; CaseInsensitive: Boolean = False): Integer;
var
  dwCmpFlags: LongWord;
  cchCount: Integer;
begin
  if CaseInsensitive
    then dwCmpFlags := NORM_IGNORECASE
    else dwCmpFlags := 0;

  if CharCount = 0
    then cchCount := -1
    else cchCount := CharCount;

  Result := CompareStringW(LOCALE_USER_DEFAULT, dwCmpFlags, PWideChar(ws1),
      cchCount, PWideChar(ws2), cchCount) - 2;
end;

function AnsiStringCompare(s1, s2: String; CharCount: Integer = 0; CaseInsensitive: Boolean = False): Integer;
var
  dwCmpFlags: LongWord;
  cchCount: Integer;
begin
  if CaseInsensitive
    then dwCmpFlags := NORM_IGNORECASE
    else dwCmpFlags := 0;

  if CharCount = 0
    then cchCount := -1
    else cchCount := CharCount;

  Result := CompareString(LOCALE_USER_DEFAULT, dwCmpFlags, PChar(s1),
      cchCount, PChar(s2), cchCount) - 2;
end;

function IsObjectAndIntegerRefSame(AObject: TObject; IntRef: Integer): Boolean;
begin
  Result := (Integer(AObject) = IntRef);
end;

function IntPtrToObject(AIntPtr: Integer): TObject;
begin
  Result := TObject(AIntPtr);
end;

function ObjectToIntPtr(AObject: TObject): Integer;
begin
  Result := Integer(AObject);
end;

function IntPtrToString(AIntPtr: Integer): String;
begin
{$HINTS OFF}
  Result := String(PChar(AIntPtr));
{$HINTS ON}
end;

procedure FillDWord(var Dest; Count, Value: Integer); register;
{$IFDEF FPC}
var
  I: Integer;
  P: PInteger;
begin
  P := PInteger(@Dest);
  for I := 0 to Count - 1 do
    P[I] := Value;
end;
{$ELSE}
{$IFDEF EH_LIB_16}
{$POINTERMATH ON}
var
  I: Integer;
  P: PInteger;
begin
  P := PInteger(@Dest);
  for I := 0 to Count - 1 do
    P[I] := Value;
end;
{$POINTERMATH OFF}
{$ELSE}
asm
  XCHG  EDX, ECX
  PUSH  EDI
  MOV   EDI, EAX
  MOV   EAX, EDX
  REP   STOSD
  POP   EDI
end;
{$ENDIF}
{$ENDIF}

function DataSetCompareBookmarks(DataSet: TDataSet; Bookmark1, Bookmark2: TUniBookmarkEh): Integer;
begin
  Result := DataSet.CompareBookmarks(TBookmark(Bookmark1), TBookmark(Bookmark2));
end;

function DataSetBookmarkValid(DataSet: TDataSet; Bookmark: TUniBookmarkEh): Boolean;
begin
  Result := DataSet.BookmarkValid(TBookmark(Bookmark));
end;

function GetMasterDataSet(FDataSet: TDataSet; APropInfo: PPropInfo): TDataSet;
var PropValue: TDataSource;
begin
  Result := nil;
  PropValue := nil;
  if (APropInfo <> nil) then
  begin
    if APropInfo^.PropType^.Kind = tkClass then
    try
      PropValue := (GetObjectProp(FDataSet, APropInfo) as TDataSource);
    except // if PropInfo is not TDataSource or not inherited of
    end;
  end;
  if (PropValue <> nil)
    then Result := PropValue.DataSet;
end;

function DrawTextEh(hDC: HDC; const Text: String; nCount: Integer;
  var lpRect: TRect; uFormat: UINT): Integer;
{$IFDEF FPC}
var
  w: WideString;
{$ELSE}
{$ENDIF}
begin
{$IFDEF FPC}
  w := UTF8ToUTF16(Text);
  Result := Windows.DrawTextW(hDC, PWideChar(w), Length(w), lpRect, uFormat);
{$ELSE}
  Result := DrawText(hDC, PChar(Text), nCount, lpRect, uFormat);
{$ENDIF}
end;

function WindowsDrawTextEx(DC: HDC; const lpchText: String; cchText: Integer;
  var p4: TRect;  dwDTFormat: UINT; DTParams: TDrawTextParams): Integer;
begin
  Result := DrawTextEx(DC, PChar(lpchText), cchText, p4, dwDTFormat, @DTParams);
end;

function WindowsDrawTextEx(DC: HDC; const lpchText: String; cchText: Integer;
  var p4: TRect;  dwDTFormat: UINT): Integer; overload;
begin
  Result := DrawTextEx(DC, PChar(lpchText), cchText, p4, dwDTFormat, nil);
end;

{
function DrawTextEh(hDC: HDC; Text: WideString; nCount: Integer;
  var lpRect: TRect; uFormat: UINT): Integer; overload;
begin
  Result := DrawTextW(hDC, PWideChar(Text), nCount, lpRect, uFormat);
end;

function WindowsDrawTextEx(DC: HDC; lpchText: WideString; cchText: Integer;
  var p4: TRect;  dwDTFormat: UINT; DTParams: TDrawTextParams): Integer; overload;
begin
  Result := DrawTextExW(DC, PWideChar(lpchText), cchText, p4, dwDTFormat, @DTParams);
end;

function WindowsDrawTextEx(DC: HDC; lpchText: WideString; cchText: Integer;
  var p4: TRect;  dwDTFormat: UINT): Integer; overload;
begin
  Result := DrawTextExW(DC, PWideChar(lpchText), cchText, p4, dwDTFormat, nil);
end;
}

function WindowsExtTextOut(DC: HDC; X, Y: Integer; Options: Longint;
  var Rect: TRect; const Str: String; Count: Longint{; Dx: PInteger}): BOOL;
begin
  Result := ExtTextOut(DC, X, Y, Options,
    @Rect, PChar(Str), Count, nil);
end;

function WindowsGetOutlineTextMetrics(DC: HDC; p2: UINT; var OTMetricStructs: TOutlineTextMetric): UINT;
begin
  Result := GetOutlineTextMetrics(DC, p2, @OTMetricStructs);
end;

{function SendStructlParamMessage(hWnd: HWND; Msg: UINT; wParam: WPARAM; var lParam): LRESULT;
begin
  Result := SendMessage(hWnd, Msg, wParam, Integer(@lParam));
end;}

function SendStructMessage(hWnd: HWND; Msg: UINT; wParam: WPARAM; var lParam): LRESULT;
begin
{$HINTS OFF}
  Result := SendMessage(hWnd, Msg, wParam, Integer(@lParam));
{$HINTS ON}
end;

function SendTextMessage(hWnd: HWND; Msg: UINT; wParam: WPARAM; const lParam: string): LRESULT;
begin
{$HINTS OFF}
  Result := SendMessage(hWnd, Msg, wParam, Integer(PChar(lParam)));
{$HINTS ON}
end;

function SendGetTextMessage(hWnd: HWND; Msg: UINT; wParam: WPARAM; var lParam: String; BufferSize: Integer): LRESULT;
var
  Text: array[0..4095] of Char;
begin
  Word((@Text)^) := SizeOf(Text);
  {$HINTS OFF}
  Result := SendMessage(hWnd, HWND, wParam, Longint(@Text));
  {$HINTS ON}
  SetString(lParam, Text, Result);
end;

function SystemParametersInfoEh(uiAction, uiParam: UINT; var pvParam; fWinIni: UINT): BOOL;
begin
  Result := SystemParametersInfo(uiAction, uiParam, @pvParam, fWinIni);
end;

function WindowsInvalidateRect(hWnd: HWND; var Rect: TRect; bErase: BOOL): BOOL;
begin
  Result := InvalidateRect(hWnd, @Rect, bErase);
end;

function WindowsValidateRect(hWnd: HWND; var Rect: TRect): BOOL;
begin
  Result := ValidateRect(hWnd, @Rect);
end;

function WindowsScrollWindowEx(hWnd: HWND; dx, dy: Integer;
  var prcScroll,  prcClip: TRect;
  hrgnUpdate: HRGN; {prcUpdate: TRect; }flags: UINT): 
  {$IFDEF FPC}
longint;
  {$ELSE}
BOOL;
  {$ENDIF}
begin
  Result := ScrollWindowEx(hWnd, dx, dy, @prcScroll, @prcClip,
    hrgnUpdate, nil, flags);
end;

function WindowsScrollWindow(hWnd: HWND; dx, dy: Integer; var prcScroll, prcClip: TRect): BOOL;
begin
  Result := ScrollWindow(hWnd, dx, dy, @prcScroll, @prcClip);
end;

function FindWindowEh(lpClassName, lpWindowName: String): HWND;
begin

  Result := FindWindow(PChar(lpClassName), PChar(lpWindowName));
end;

procedure VarToMessage(var VarMessage; var Message: TMessage);
begin
  Message := TMessage(VarMessage);
end;

function MessageToTMessage(var Message): TMessage;
begin
  Result := TMessage(Message);
end;

function MessageToTWMMouse(var Message): TWMMouse;
begin
  Result := TWMMouse(Message);
end;

function MessageToTWMKey(var Message): TWMKey;
begin
  Result := TWMKey(Message);
end;

function UnwrapMessageEh(var Message): TMessage;
begin
  Result := TMessage(Message);
end;

function SmallPointToInteger(SmallPoint: Windows.TSmallPoint): Integer;
begin
  Result := Integer(SmallPoint);
end;

function LongintToSmallPoint(Value: Longint): TSmallPoint;
begin
  Result := TSmallPoint(Value);
end;

function WindowsLPtoDP(DC: HDC; var ARect: TRect): BOOL;
begin
  Result := LPtoDP(DC, ARect, 2);
end;

function WindowsCreatePolygonRgn(Points: array of TPoint; Count, FillMode: Integer): HRGN;
begin
  Result := CreatePolygonRgn(Points, Count, FillMode);
end;

function GetFontSize(Font: TFont; Canvas: TCanvas): Integer;
{$IFDEF FPC}
var
  Metrics: Windows.TTextMetric;
  Height: Integer;
{$ELSE}
{$ENDIF}
begin
{$IFDEF FPC}
  if Canvas = nil
     then GetTextMetrics(GetDC(0), Metrics)
     else GetTextMetrics(Canvas.Handle, Metrics);
  Height := GetFontData(Font.Reference.Handle).Height;
  Result := -MulDiv(Height, 72, Metrics.tmDigitizedAspectY);
{$ELSE}
  Result := Font.Size;
{$ENDIF}
end;

procedure MessageSendGetSel(hWnd: HWND; var SelStart, SelEnd: Integer);
begin
{$HINTS OFF}
  SendMessage(hWnd, EM_GETSEL, WPARAM(@SelStart), LPARAM(@SelEnd));
{$HINTS ON}
end;

function NlsUpperCase(const S: String): String;
begin
  Result := AnsiUpperCase(S);
end;

function NlsLowerCase(const S: String): String;
begin
  Result := AnsiLowerCase(S);
end;

function NlsCompareStr(const S1, S2: String): Integer;
begin
  Result := AnsiCompareStr(S1, S2);
end;

function NlsCompareText(const S1, S2: String): Integer;
begin
  Result := AnsiCompareText(S1, S2);
end;

procedure BitmapLoadFromResourceName(Bmp: TBitmap; Instance: THandle; const ResName: String);
begin
  Bmp.LoadFromResourceName(Instance, ResName);
end;

function LoadBitmapEh(hInstance: HINST; lpBitmapID: Integer): HBITMAP;
begin
{$HINTS OFF}
  Result := LoadBitmap(hInstance, PChar(lpBitmapID));
{$HINTS ON}
end;

function GetPropListAsArray(ATypeInfo: PTypeInfo; TypeKinds: TTypeKinds): TPropListArray;
var
  PropCount: Integer;
{  PropList: PPropList;
  PropCount, FSize, i: Integer;}
begin
  PropCount := GetPropList(ATypeInfo, tkProperties, nil);
//  FSize := PropCount * SizeOf(Pointer);
  SetLength(Result, PropCount);
  GetPropList(ATypeInfo, tkProperties, PPropList(Result));

{  GetMem(PropList, FSize);
  GetPropList(ATypeInfo, tkProperties, PropList);
  SetLength(Result, PropCount);
  for i := 0 to PropCount-1 do
    Result[i] := PropList[i];
}
end;

function HexToBinEh(Text: Pointer; var Buffer: TBytes; Count: Integer): Integer;
begin
  SetLength(Buffer, 0);
  SetLength(Buffer, Count div 2);
  Result := HexToBin(PAnsiChar(Text), PAnsiChar(Buffer), Count);
end;

procedure BinToHexEh(Buffer: TBytes; var Text: String; Count: Integer);
var
  AnsiText: AnsiString;
begin
  SetString(AnsiText, nil, Count*2);
  BinToHex(PAnsiChar(Buffer), PAnsiChar(AnsiText), Count);
  Text := String(AnsiText);
end;

procedure StreamWriteBytes(Stream: TStream; Buffer: TBytes);
begin
  Stream.Write(Pointer(Buffer)^, Length(Buffer));
end;

procedure StreamReadBytes(Stream: TStream; var Buffer: TBytes; Count: Integer);
var
  bs: AnsiString;
  i: Integer;
begin
  SetLength(Buffer, Count);
  SetString(bs, nil, Count);
  Stream.Read(Pointer(bs)^, Count);
  for i := 0 to Length(bs)-1 do
    Buffer[i] := Byte(bs[i+1]);
end;

{$IFNDEF EH_LIB_13}
function BytesOf(S: String): TBytes; overload;
var
  i: Integer;
begin
  SetLength(Result, Length(S));
  for i := 0 to Length(S)-1 do
    Result[i] := Byte(AnsiChar(S[i+1]));
end;
{$ENDIF}

{$IFNDEF EH_LIB_17}
function BytesOf(const Val: Pointer; const Len: integer): TBytes; overload;
begin
  SetLength(Result, Len);
  Move(PByte(Val)^, Result[0], Len);
end;
{$ENDIF}

function PropInfo_getPropType(APropInfo: PPropInfo): PTypeInfo;
begin
  {$IFDEF FPC}
  Result := APropInfo^.PropType;
  {$ELSE}
  Result := APropInfo^.PropType^;
  {$ENDIF}
end;

function PropInfo_getName(APropInfo: PPropInfo): String;
begin
  Result := String(APropInfo^.Name);
end;

function PropType_getKind(APropType: PTypeInfo): TTypeKind;
begin
  Result := APropType^.Kind;
end;

procedure VarArrayRedimEh(var A : Variant; HighBound: Integer);
begin
  VarArrayRedim(A, HighBound);
end;

function EmptyRect: TRect;
begin
  Result := Rect(0, 0, 0, 0);
end;

function IsRectEmptyEh(const Rect: TRect): Boolean;
begin
  Result := (Rect.Right <= Rect.Left) or (Rect.Bottom <= Rect.Top);
end;

{$IFNDEF EH_LIB_5}

function GetObjectProp(Instance: TObject; PropInfo: PPropInfo): TObject;
begin
  Result := TObject(GetOrdProp(Instance, PropInfo));
end;

function GetObjectPropClass(Instance: TObject; PropInfo: PPropInfo): TClass;
var
  TypeData: PTypeData;
begin
  TypeData := GetTypeData(PropInfo^.PropType^);
  if TypeData = nil then
    raise Exception.Create('SUnknownProperty');
//    raise EPropertyError.CreateRes(@SUnknownProperty);
  Result := TypeData^.ClassType;
end;

procedure SetObjectProp(Instance: TObject; PropInfo: PPropInfo;
  Value: TObject);
begin
  if (Value is GetObjectPropClass(Instance, PropInfo)) or
     (Value = nil) then
    SetOrdProp(Instance, PropInfo, Integer(Value));
end;

{$ENDIF}

type
  TPersistentCracker = class(TPersistent);
  TComponentCracker = class(TComponent);

function GetUltimateOwner(APersistent: TPersistent): TPersistent;
begin
  Result := TPersistentCracker(APersistent).GetOwner;
end;

{ TFilerAccess }

constructor TFilerAccess.Create(APersistent: TPersistent);
begin
  inherited Create;
  FPersistent := APersistent;
end;

procedure TFilerAccess.DefineProperties(AFiler: TFiler);
begin
  TPersistentCracker(FPersistent).DefineProperties(AFiler);
end;

function TFilerAccess.GetChildOwner: TComponent;
begin
  Result := TComponentCracker(FPersistent).GetChildOwner;
end;

function TFilerAccess.GetChildParent: TComponent;
begin
  Result := TComponentCracker(FPersistent).GetChildParent;
end;

procedure TFilerAccess.GetChildren(Proc: TGetChildProc; Root: TComponent);
begin
  TComponentCracker(FPersistent).GetChildren(Proc, Root);
end;

procedure TFilerAccess.SetAncestor(Value: Boolean);
begin
  TComponentCracker(FPersistent).SetAncestor(Value);
end;

procedure TFilerAccess.SetChildOrder(Child: TComponent; Order: Integer);
begin
  TComponentCracker(FPersistent).SetChildOrder(Child, Order);
end;

procedure TFilerAccess.Updated;
begin
  TComponentCracker(FPersistent).Updated;
end;

procedure TFilerAccess.Updating;
begin
  TComponentCracker(FPersistent).Updating;
end;

{ TMemoryStream }

constructor TMemoryStreamEh.Create;
begin
  inherited Create;
  HalfMemoryDelta := $1000;
end;

{$IFDEF FPC}
function TMemoryStreamEh.Realloc(var NewCapacity: NativeInt): Pointer;
begin
  Result := inherited Realloc(NewCapacity);
end;
{$ELSE}
function TMemoryStreamEh.Realloc(var NewCapacity: Integer): Pointer;
var
  MemoryDelta: Integer;
begin
  MemoryDelta := HalfMemoryDelta * 2;
  if (NewCapacity > 0) and (NewCapacity <> Size) then
    NewCapacity := (NewCapacity + (MemoryDelta - 1)) and not (MemoryDelta - 1);
  Result := Memory;
  if NewCapacity <> Capacity then
  begin
    if NewCapacity = 0 then
    begin
  {$IFDEF MSWINDOWS}
      GlobalFreePtr(Memory);
  {$ELSE}
      FreeMem(Memory);
  {$ENDIF}
      Result := nil;
    end else
    begin
  {$IFDEF MSWINDOWS}
{$WARNINGS OFF}
      if Capacity = 0 then
        Result := GlobalAllocPtr(HeapAllocFlags, NewCapacity)
      else
        Result := GlobalReallocPtr(Memory, NewCapacity, HeapAllocFlags);
{$WARNINGS ON}
  {$ELSE}
      if Capacity = 0 then
        GetMem(Result, NewCapacity)
      else
        ReallocMem(Result, NewCapacity);
  {$ENDIF}
  {$IFDEF EH_LIB_5}
      if Result = nil then raise EStreamError.CreateRes(@SMemoryStreamError);
  {$ELSE}
      if Result = nil then raise EStreamError.Create(SMemoryStreamError);
  {$ENDIF}
    end;
  end;
end;
{$ENDIF}

{$IFNDEF EH_LIB_6}

{ TDragObjectEx }

procedure TDragObjectEx.BeforeDestruction;
begin
  // Do not call inherited here otherwise DragSave will be cleared and thus
  // we will be unable to automatically free the dragobject.
end;

{$ENDIF}

procedure DataVarCast(var Dest: Variant; const Source: Variant; AVarType: Integer);
//function DataVarCast(const Source: Variant; AVarType: Integer): Variant;
begin
  if VarIsNull(Source) then
    Dest := Null
  else if AVarType = varVariant then
    Dest := Source
  else
    VarCast(Dest, Source, AVarType);
end;

function VariantToRefObject(Value: Variant): TObject;
begin
  Result := TObject(Integer(Value));
end;

function RefObjectToVariant(Value: TObject): Variant;
begin
  Result := Integer(Value);
end;

procedure DataVarCastAsObject(var Dest: Variant; const Source: Variant);
begin
  DataVarCast(Dest, Source, varVariant);
end;

function WStrCopy(Dest: PWideChar; const Source: PWideChar): PWideChar;
var
  Src : PWideChar;
begin
  Result := Dest;
  Src := Source;
  while (Src^ <> #$00) do
  begin
    Dest^ := Src^;
    Inc(Src);
    Inc(Dest);
  end;
  Dest^ := #$00;
end;

{$RANGECHECKS OFF}
// Here and below all routins work without rangecheck

function ExplicitLongwordToLongInt(v: Longword): LongInt;
begin
  Result := LongInt(v);
end;

function VarToWideStr(const V: Variant): WideString;
begin
  if not VarIsNull(V) then
    Result := V
  else
    Result := '';
end;

function SafeGetMouseCursorPos: TPoint;
begin
  if not Windows.GetCursorPos(Result) then
    Result := Point(0, 0);
end;

{$IFDEF EH_LIB_6}
{$ELSE}
function RoundTo(const AValue: Double; const ADigit: TRoundToRange): Double;
var
  LFactor: Double;
begin
  LFactor := IntPower(10, ADigit);
  Result := Round(AValue / LFactor) * LFactor;
end;

type TVarType = Word;

function FindVarData(const V: Variant): PVarData;
begin
  Result := @TVarData(V);
  while Result.VType = varByRef or varVariant do
    Result := PVarData(Result.VPointer);
end;

function VarTypeIsStr(const AVarType: TVarType): Boolean;
begin
  Result := (AVarType = varOleStr) or (AVarType = varString);
end;

function VarIsStr(const V: Variant): Boolean;
begin
  Result := VarTypeIsStr(FindVarData(V)^.VType);
end;
{$ENDIF}

{$IFNDEF EH_LIB_16}

{ TCustomStyleServicesProxyEh }

function TCustomStyleServicesProxyEh.GetSystemColor(Color: TColor): TColor;
begin
  Result := Color;
end;

{$ENDIF}

{$IFDEF FPC}

function TestStreamFormat(Stream: TStream): TStreamOriginalFormat;
var
  Pos: Integer;
  Signature: Integer;
begin
  Pos := Stream.Position;
  Signature := 0;
  Stream.Read(Signature, sizeof(Signature));
  Stream.Position := Pos;
  if (Byte(Signature) = $FF) or (Signature = Integer(FilerSignature)) then
    Result := sofBinary
    // text format may begin with "object", "inherited", or whitespace
  else if Char(Signature) in ['o','O','i','I',' ',#13,#11,#9] then
    Result := sofText
  else
    Result := sofUnknown;
end;

function VarTypeToDataType(VarType: Integer): TFieldType;
begin
  case VarType of
    varSmallint: Result := ftSmallInt;
    varShortInt: Result := ftSmallInt;
    varByte: Result := ftSmallInt;
    varWord: Result := ftWord;
    varInteger: Result := ftInteger;
    varCurrency: Result := ftBCD;
    varLongWord: Result := ftWord;
    varSingle: Result := ftFloat;
    varDouble: Result := ftFloat;
    varDate: Result := ftDateTime;
    varBoolean: Result := ftBoolean;
    varString: Result := ftString;
    varUString, varOleStr: Result := ftWideString;
    varInt64: Result := ftLargeInt;
  else
    if ((VarType and varArray) = varArray) and ((VarType and varTypeMask) = varByte) then
      Result := ftBlob
    else
      Result := ftUnknown;
  end;
end;

function DBUseRightToLeftAlignment(AControl: TControl; AField: TField): Boolean;
var
  AAlignment: TAlignment;
begin
  Result := False;
  if Assigned(AField) then
    AAlignment := AField.Alignment
  else
    AAlignment := taLeftJustify;
  Result := (SysLocale.MiddleEast) and (AControl.BiDiMode = bdRightToLeft) and
    (OkToChangeFieldAlignment(AField, AAlignment));
end;

function OkToChangeFieldAlignment(AField: TField; Alignment: TAlignment): Boolean;
begin
  Result := True;
end;

procedure PerformEraseBackground(Control: TControl; DC: HDC);
var
  LastOrigin: TPoint;
begin
  GetWindowOrgEx(DC, LastOrigin);
  SetWindowOrgEx(DC, LastOrigin.X + Control.Left, LastOrigin.Y + Control.Top, nil);
  Control.Parent.Perform(WM_ERASEBKGND, DC, DC);
  SetWindowOrgEx(DC, LastOrigin.X, LastOrigin.Y, nil);
end;

function DrawTextBiDiModeFlags(Control: TControl; Flags: Longint): Longint;
begin
  Result := Flags;
  { do not change center alignment }
  if Control.UseRightToLeftAlignment then
    if Result and DT_RIGHT = DT_RIGHT then
      Result := Result and not DT_RIGHT { removing DT_RIGHT, makes it DT_LEFT }
    else if not (Result and DT_CENTER = DT_CENTER) then
      Result := Result or DT_RIGHT;
  {$IFDEF FPC}
  Result := Result; // TODO : To do when BiDiMode works
  {$ELSE}
  Result := Result or Control.DrawTextBiDiModeFlagsReadingOnly;
  {$ENDIF}
end;

function GetFieldProperty(DataSet: TDataSet; Control: TComponent;
  const FieldName: string): TField;
begin
  Result := DataSet.FindField(FieldName);
  if Result = nil then
    DatabaseErrorFmt('SFieldNotFound', [FieldName], Control);
end;

{ TWinControlEh }

procedure TWinControlEh.RecreateWndHandle;
begin
  RecreateWnd(Self);
end;

{ TCustomControlEh }

procedure TCustomControlEh.RecreateWndHandle;
begin
  RecreateWnd(Self);
end;

{ initialization/finalization }
procedure InitEhLibLCL;
begin
  NewStyleControls := True; //Little too rude but what to do.
end;

procedure FinalEhLibLCL;
begin

end;

{$ELSE}

{ TWinControlEh }

procedure TWinControlEh.RecreateWndHandle;
begin
  RecreateWnd;
end;

{ TCustomControlEh }

procedure TCustomControlEh.RecreateWndHandle;
begin
  RecreateWnd;
end;

{ initialization/finalization }
procedure InitEhLibVCL;
begin
end;

procedure FinalEhLibVCL;
begin
{$IFNDEF EH_LIB_16}
  FreeAndNil(FStyleServices);
{$ENDIF}

{$IFNDEF EH_LIB_17}
  FreeAndNil(FFormatSettings);
{$ENDIF}
end;
{$ENDIF}

{$IFDEF FPC}
initialization
  InitEhLibLCL;
finalization
  FinalEhLibLCL;
{$ELSE}
initialization
  InitEhLibVCL;
finalization
  FinalEhLibVCL;
{$ENDIF}
end.

