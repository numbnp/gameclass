{*******************************************************}
{                                                       }
{                       EhLib v7.0                      }
{             DBGridEh import/export routines           }
{                      Build 7.0.15                     }
{                                                       }
{   Copyright (c) 1998-2014 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit DBGridEhImpExp;

interface

uses
  Windows, SysUtils, Classes, Graphics, Dialogs, GridsEh, Controls,
{$IFDEF EH_LIB_6} Variants, {$ENDIF}
{$IFDEF EH_LIB_16} System.Zip, {$ENDIF}
{$IFDEF FPC}
  XMLRead, DOM, EhLibXmlConsts,
{$ELSE}
  xmldom, XMLIntf, msxmldom, XMLDoc, EhLibXmlConsts,
{$ENDIF}

{$IFDEF EH_LIB_17} System.UITypes, System.Contnrs, {$ENDIF}
{$IFDEF CIL}
  EhLibVCLNET,
  System.Runtime.InteropServices, System.Reflection,
{$ELSE}
  {$IFDEF FPC}
    EhLibLCL, LCLType, Win32Extra, DBGridsEh,
  {$ELSE}
    EhLibVCL, Messages, SqlTimSt, DBGridEh,
  {$ENDIF}
{$ENDIF}
  DBAxisGridsEh,
  Db, Clipbrd, ComObj, StdCtrls;

const
  TVCLDBIF_TYPE_EOF = 0;
  TVCLDBIF_TYPE_UNASSIGNED = 1;
  TVCLDBIF_TYPE_NULL = 2;
  TVCLDBIF_TYPE_INTEGER32 = 3;
  TVCLDBIF_TYPE_FLOAT64 = 4;
  TVCLDBIF_TYPE_ANSI_STRING = 5;
  TVCLDBIF_TYPE_BINARY_DATA = 6;
  TVCLDBIF_TYPE_WIDE_STRING = 7;

type

  TFooterValues = array of Currency;

{$IFDEF FPC}
{$ELSE}
  TCustomFileZipingProviderEh = class;
{$ENDIF}

  { TDBGridEhExport }

  TDBGridEhExport = class(TObject)
  private
    FColCellParamsEh: TColCellParamsEh;
    FDBGridEh: TCustomDBGridEh;
    FExpCols: TColumnsEhList;
    function GetFooterValue(Row, Col: Integer): String;
  protected
    FStream: TStream;
    FooterValues: TFooterValues;
    procedure CalcFooterValues; virtual;
    procedure WritePrefix; virtual;
    procedure WriteSuffix; virtual;
    procedure WriteTitle(ColumnsList: TColumnsEhList); virtual;
    procedure WriteRecord(ColumnsList: TColumnsEhList); virtual;
    procedure WriteDataCell(Column: TColumnEh; FColCellParamsEh: TColCellParamsEh); virtual;
    procedure WriteFooter(ColumnsList: TColumnsEhList; FooterNo: Integer); virtual;
    procedure WriteFooterCell(DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
      Background: TColor; Alignment: TAlignment; Text: String); virtual;
    property Stream: TStream read FStream write FStream;
    property ExpCols: TColumnsEhList read FExpCols write FExpCols;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure ExportToStream(AStream: TStream; IsExportAll: Boolean); virtual;
    procedure ExportToFile(FileName: String; IsExportAll: Boolean); virtual;
    property DBGridEh: TCustomDBGridEh read FDBGridEh write FDBGridEh;
  end;

  TDBGridEhExportClass = class of TDBGridEhExport;

  { TDBGridEhExportAsText }

  TDBGridEhExportAsText = class(TDBGridEhExport)
  private
    FirstRec: Boolean;
    FirstCell: Boolean;
  protected
    procedure CheckFirstRec; virtual;
    procedure CheckFirstCell; virtual;
    procedure WritePrefix; override;
    procedure WriteSuffix; override;
    procedure WriteTitle(ColumnsList: TColumnsEhList); override;
    procedure WriteFooter(ColumnsList: TColumnsEhList; FooterNo: Integer); override;
    procedure WriteRecord(ColumnsList: TColumnsEhList); override;
    procedure WriteDataCell(Column: TColumnEh; FColCellParamsEh: TColCellParamsEh); override;
    procedure WriteFooterCell(DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
      Background: TColor; Alignment: TAlignment; Text: String); override;
  public
    procedure ExportToStream(Stream: TStream; IsExportAll: Boolean); override;
  end;

  { TDBGridEhExportAsUnicodeText }

  TDBGridEhExportAsUnicodeText = class(TDBGridEhExport)
  private
    FirstRec: Boolean;
    FirstCell: Boolean;
  protected
    procedure CheckFirstRec; virtual;
    procedure CheckFirstCell; virtual;
    procedure WritePrefix; override;
    procedure WriteSuffix; override;
    procedure WriteTitle(ColumnsList: TColumnsEhList); override;
    procedure WriteFooter(ColumnsList: TColumnsEhList; FooterNo: Integer); override;
    procedure WriteRecord(ColumnsList: TColumnsEhList); override;
    procedure WriteDataCell(Column: TColumnEh; FColCellParamsEh: TColCellParamsEh); override;
    procedure WriteFooterCell(DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
      Background: TColor; Alignment: TAlignment; Text: String); override;
  public
    procedure ExportToStream(Stream: TStream; IsExportAll: Boolean); override;
  end;

  { TDBGridEhExportAsCSV }

  TDBGridEhExportAsCSV = class(TDBGridEhExportAsText)
  private
    FSeparator: AnsiChar;
    FQuoteChar: AnsiChar;
  protected
    procedure CheckFirstCell; override;
    procedure WriteTitle(ColumnsList: TColumnsEhList); override;
    procedure WriteDataCell(Column: TColumnEh; FColCellParamsEh: TColCellParamsEh); override;
    procedure WriteFooterCell(DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
      Background: TColor; Alignment: TAlignment; Text: String); override;
  public
    constructor Create; override;
    property Separator: AnsiChar read FSeparator write FSeparator;
    property QuoteChar: AnsiChar read FQuoteChar write FQuoteChar;
  end;

  { TDBGridEhExportAsHTML }

  TDBGridEhExportAsHTML = class(TDBGridEhExport)
  private
    function GetAlignment(Alignment: TAlignment): String;
    function GetColor(Color: TColor): String;
    procedure PutText(Font: TFont; Text: String);
    procedure Put(Text: String);
    procedure PutL(Text: String);
  protected
    procedure WritePrefix; override;
    procedure WriteSuffix; override;
    procedure WriteTitle(ColumnsList: TColumnsEhList); override;
    procedure WriteRecord(ColumnsList: TColumnsEhList); override;
    procedure WriteDataCell(Column: TColumnEh; FColCellParamsEh: TColCellParamsEh); override;
    procedure WriteFooter(ColumnsList: TColumnsEhList; FooterNo: Integer); override;
    procedure WriteFooterCell(DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
      Background: TColor; Alignment: TAlignment; Text: String); override;
  end;

  { TDBGridEhExportAsRTF }

  TDBGridEhExportAsRTF = class(TDBGridEhExport)
  private
    FCacheStream: TMemoryStreamEh;
    ColorTblList: TStrings;
    FontTblList: TStrings;
    function GetFontIndex(FontName: String): Integer;
    function GetColorIndex(Color: TColor): Integer;
    function GetAlignment(Alignment: TAlignment): String;
    function GetDataCellColor(ColumnsList: TColumnsEhList; ColIndex: Integer): TColor;
    function GetFooterCellColor(ColumnsList: TColumnsEhList; ColIndex: Integer; FooterNo: Integer): TColor;

    procedure PutText(Font: TFont; Text: String; Background: TColor);
    procedure Put(Text: String);
    procedure PutL(Text: String);

  protected
    function StringToRtfString(s: String): String;

    procedure WriteCellBorder(LeftBorder, TopBorder, BottomBorder, RightBorder: Boolean);
    procedure WritePrefix; override;
    procedure WriteSuffix; override;
    procedure WriteTitle(ColumnsList: TColumnsEhList); override;
    procedure WriteRecord(ColumnsList: TColumnsEhList); override;
    procedure WriteDataCell(Column: TColumnEh; FColCellParamsEh: TColCellParamsEh); override;
    procedure WriteFooter(ColumnsList: TColumnsEhList; FooterNo: Integer); override;
    procedure WriteFooterCell(DataCol, Row: Integer; Column: TColumnEh; AFont: TFont; Background: TColor; Alignment: TAlignment; Text: String); override;

  public
    procedure ExportToStream(AStream: TStream; IsExportAll: Boolean); override;
  end;

  { TDBGridEhExportAsXLS }

  TDBGridEhExportAsXLS = class(TDBGridEhExport)
  private
    FCol, FRow: Word;
    procedure WriteBlankCell;
    procedure WriteIntegerCell(const AValue: Integer);
    procedure WriteFloatCell(const AValue: Double);
    procedure WriteStringCell(const AValue: String);
    procedure IncColRow;
  protected
    procedure WritePrefix; override;
    procedure WriteSuffix; override;
    procedure WriteTitle(ColumnsList: TColumnsEhList); override;
    procedure WriteDataCell(Column: TColumnEh; FColCellParamsEh: TColCellParamsEh); override;
    procedure WriteFooterCell(DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
      Background: TColor; Alignment: TAlignment; Text: String); override;
  public
    procedure ExportToStream(AStream: TStream; IsExportAll: Boolean); override;
  end;

  { TDBGridEhExportAsVCLDBIF }

  {Internal format for interchange between DataSet based components}

  { BOF (Beginning of File)

   Byte       |  0    1    2    3    4    5    6 |  0 |  0    1    2    3 |
              -------------------------------------------------------------
   Contents   |  V |  C |  L |  D |  B |  I |  F |  1 |  X |  X |  X |  X |
              -------------------------------------------------------------
              |  Signatura                       |Vers|  Columns count    |
              |                                  |ion |                   |


    Fields Names

   Byte       |  0 |  0    1    2    3   ...   X |  0 |  0    1    2    3   ...
              ------------------------------------------------------------- ...
   Contents   |  X |  N |  a |  m |  e |  1 |  0 |  X |  N |  a |  m |  e |  2 | 0
              ------------------------------------------------------------- ...
              |Colu| Null terminated field name  |Colu| Null terminated field name
              |mn  |                             |mn  |
              |visi|                             |visi|
              |ble 1 or 0                        |ble 1 or 0

    Values

  ----------------
    Unassigned, skip value
    ftUnknown,  ftCursor, ftADT, ftArray, ftReference, ftDataSet, ftVariant,
     ftInterface, ftIDispatch,

   Byte       |  0 |
              ------
   Contents   |  1 |
              ------
              |Type|
  ----------------
    NULL

   Byte       |  0 |
              ------
   Contents   |  2 |
              ------
              |Type|
  ----------------
    INTEGER32
    ftSmallint, ftInteger, ftWord, ftBoolean, ftAutoInc

   Byte       |  0 |  0    1    2    3 |
              --------------------------
   Contents   |  3 |  X |  X |  X |  X |
              --------------------------
              |Type|  Intetger value   |
                   |   (Longint)       |
  ----------------
    FLOAT64
    ftFloat, ftCurrency, ftBCD, ftDate, ftTime, ftDateTime,

   Byte       |  0 |  0    1    2    3    4    5    6    7 |
              ----------------------------------------------
   Contents   |  4 |  X |  X |  X |  X |  X |  X |  X |  X |
              ----------------------------------------------
              |Type|  Float value (Double)                 |
  ----------------
    STRING
    ftString, ftMemo, ftFixedChar, ftLargeint, ftOraClob, ftGuid

   Byte       |  0 |  0    1    2    3 |  0    1    2   ...   N |
              ---------------------------------------------------
   Contents   |  5 |  X |  X |  X |  X |  a |  b |  c | ...   0 |
              ---------------------------------------------------
              |Type|  Size (Longint)   |  String body including |
                                       |  null terminator       |
  ----------------
    BINARY DATA
    ftBlob, ftGraphic, ftFmtMemo, ftParadoxOle, ftDBaseOle, ftOraBlob,
     ftBytes, ftTypedBinary, ftVarBytes, ftWideString,

   Byte       |  0 |  0    1    2    3 |  0    1    2   ...   N |
              ---------------------------------------------------
   Contents   |  6 |  X |  X |  X |  X |  a |  b |  c | ...   X |
              ---------------------------------------------------
              |Type|  Size (Longword)   |  data                  |
  ----------------
    EOF (End of File)

   Byte       |  0 |
              ------
   Contents   |  0 |
              ------
              |Type|
  }

  TVCLDBIF_BOF = packed record
    Signatura: array[0..6] of AnsiChar;
    Version: Byte;
    ColCount: Longint;
  end;

  TVCLDBIF_INTEGER32 = packed record
    AType: Byte;
    Value: Longint;
  end;

  TVCLDBIF_FLOAT64 = packed record
    AType: Byte;
    Value: Double;
  end;

  TVCLDBIF_ANSI_STRING = packed record
    AType: Byte;
    Size: Longint;
  end;

  TVCLDBIF_WIDE_STRING = packed record
    AType: Byte;
    Size: Longint;
  end;

  TVCLDBIF_BINARY_DATA = packed record
    AType: Byte;
    Size: Longint;
  end;

  TDBGridEhExportAsVCLDBIF = class(TDBGridEhExport)
  protected
    procedure WritePrefix; override;
    procedure WriteSuffix; override;
    procedure WriteDataCell(Column: TColumnEh; FColCellParamsEh: TColCellParamsEh); override;
  end;

  { TDBGridEhExportAsOLEXLS }

{$IFDEF CIL}
{$ELSE}

  TDBGridEhExportAsOLEXLSOption = (oxlsColoredEh, oxlsDataAsDisplayText,
    oxlsDataAsEditText);
  TDBGridEhExportAsOLEXLSOptions = set of TDBGridEhExportAsOLEXLSOption;

  TDBGridEhExportAsOLEXLS = class(TDBGridEhExport)
  private
    FActiveSheet: Variant;
    FExcelApp: Variant;
    FCurRow: Integer;
    FCurCol: Integer;
    FVarValues: Variant;
    FDataRowCount: Integer;
    FTitleRows: Integer;
    FOptions: TDBGridEhExportAsOLEXLSOptions;
    FDataRowCountMode: Boolean;
    FIsExportAll: Boolean;
    FDefaultSizeDelta: Double;
  protected
    procedure CalcFooterValues; override;
    procedure WritePrefix; override;
    procedure WriteSuffix; override;
    procedure WriteRecord(ColumnsList: TColumnsEhList); override;
    procedure WriteTitle(ColumnsList: TColumnsEhList); override;
    procedure WriteDataCell(Column: TColumnEh; FColCellParamsEh: TColCellParamsEh); override;
    procedure WriteFooter(ColumnsList: TColumnsEhList; FooterNo: Integer); override;
    procedure WriteFooterCell(DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
      Background: TColor; Alignment: TAlignment; Text: String); override;
    procedure SetFontIfNeed(Range: Variant; Font: TFont);
    procedure SetFont(Range: Variant; Font: TFont);
  public
    procedure ExportToStream(AStream: TStream; IsExportAll: Boolean); override;
    procedure ExportToFile(FileName: String; IsExportAll: Boolean); override;
    function ExportToExcel(IsExportAll: Boolean; Options: TDBGridEhExportAsOLEXLSOptions): Variant; virtual;
  end;

{$IFDEF FPC}
{$ELSE}

 { TDBGridEhExportAsXlsx }

  TDBGridEhExportAsXlsxOption = (xlsxColoredEh, xlsxDataAsDisplayText,
    xlsxDataAsEditText);
  TDBGridEhExportAsXlsxOptions = set of TDBGridEhExportAsXlsxOption;

  RStyle=record
    NumFmt: integer;
    NumFont: integer;
    NumAlignment: integer;
    NumBackColor: integer;
    NumBorder: integer;
    Vertical: boolean;
    Wrap: boolean;
  end;

  TDBGridEhExportAsXlsx = class(TDBGridEhExport)
  private
    FBackColor: array of TColor;
    FBorder: array of Integer;
    FCurCol: Integer;
    FCurRow: Integer;
    FDataRowCount: Integer;
    FFmtNode: IXMLNode;
    FFonts: array of TFont;
    FIsExportAll: Boolean;
    FNumFmt: Integer;
    FOptions: TDBGridEhExportAsXlsxOptions;
    FRowNode: IXMLNode;
    FSeparator: char;
    FStyles: array of RStyle;
//    FXMLSheet: IXMLDocument;
    FXMLStyles: IXMLDocument;
//    ZipF: TZipFile;
    FZipFileProvider: TCustomFileZipingProviderEh;
    FSheetStr: TStringStream;
    FSheetMergeStr: TStringStream;
    FSheetMergeCount: Integer;

  protected
    function SetBackColor(Color: TColor): Integer;
    function SetBorder(Border: Integer): Integer;
    function SetFont(Font: TFont): Integer;
    function SetStyle(NumFmt: Integer; Font: TFont; Alignment: Integer; BackColor: TColor; Border: Integer; Vert, Wrap: Boolean): Integer;

    procedure CalcFooterValues; override;
    procedure WritePrefix; override;
    procedure WriteSuffix; override;
    procedure WriteRecord(ColumnsList: TColumnsEhList); override;
    procedure WriteTitle(ColumnsList: TColumnsEhList); override;
    procedure WriteDataCell(Column: TColumnEh; FColCellParamsEh: TColCellParamsEh); override;
    procedure WriteFooter(ColumnsList: TColumnsEhList; FooterNo: Integer); override;
    procedure WriteFooterCell(DataCol, Row: Integer; Column: TColumnEh; AFont: TFont; Background: TColor; Alignment: TAlignment; Text: String); override;

  public
//    function ExportToXlsx(IsExportAll: Boolean; Options: TDBGridEhExportAsXlsxOptions): Variant; virtual;

    procedure ExportToFile(FileName: String; IsExportAll: Boolean); override;
    procedure ExportToStream(AStream: TStream; IsExportAll: Boolean); override;
  end;

{ TCustomFileZipingProviderEh }

  TCustomFileZipingProviderEh = class(TObject)
  public
    class function CreateInstance: TCustomFileZipingProviderEh; virtual;
    function InitZipFile(FileName: String): TStream; virtual; abstract;
    procedure AddFile(Data: TStream; const FilePathAndName: string); virtual; abstract;
    procedure FinalizeZipFile; overload; virtual; abstract;
    procedure FinalizeZipFile(AStream: TStream); overload; virtual; abstract;
  end;

  TCustomFileZipingProviderEhClass = class of TCustomFileZipingProviderEh;

{$IFDEF EH_LIB_16} // XE or higher

{ TSystemZipFileProvider }

  TSystemZipFileProviderEh = class(TCustomFileZipingProviderEh)
  private
    FStream: TStream;
    FZipFile: TZipFile;
  public
    constructor Create;
    destructor Destroy; override;

    class function CreateInstance: TCustomFileZipingProviderEh; override;
    function InitZipFile(FileName: String): TStream; override;
    procedure AddFile(Data: TStream; const FilePathAndName: string); override;
    procedure FinalizeZipFile; override;
    procedure FinalizeZipFile(AStream: TStream); override;

    property Stream: TStream read FStream write FStream;
  end;

{$ENDIF} // XE2 or higher

{$ENDIF} // not Lazarus
{$ENDIF} // ELSE CIL

  { TDBGridEhImport }

  TDBGridEhImport = class(TObject)
  private
    FDBGridEh: TCustomDBGridEh;
    FStream: TStream;
    FImpCols: TColumnsEhList;
  protected
    Eos: Boolean;
    procedure ReadPrefix; virtual;
    procedure ReadSuffix; virtual;
    procedure ReadRecord(ColumnsList: TColumnsEhList); virtual;
    procedure ReadDataCell(Column: TColumnEh); virtual;
    property Stream: TStream read FStream write FStream;
    property ImpCols: TColumnsEhList read FImpCols write FImpCols;
  public
    constructor Create; virtual;
    procedure ImportFromStream(AStream: TStream; IsImportAll: Boolean); virtual;
    procedure ImportFromFile(FileName: String; IsImportAll: Boolean); virtual;
    property DBGridEh: TCustomDBGridEh read FDBGridEh write FDBGridEh;
  end;

  TDBGridEhImportClass = class of TDBGridEhImport;

  { TDBGridEhImportAsText }

  TImportTextSreamState = (itssChar, itssTab, itssNewLine, itssEof);

  TDBGridEhImportAsText = class(TDBGridEhImport)
  private
    FLastChar: AnsiChar;
    FLastState: TImportTextSreamState;
    FLastString: AnsiString;
    FIgnoreAll: Boolean;
    function GetChar(var ch: AnsiChar): Boolean;
    function CheckState: TImportTextSreamState;
    function GetString(var Value: AnsiString): TImportTextSreamState;
  protected
    procedure ReadPrefix; override;
    procedure ReadRecord(ColumnsList: TColumnsEhList); override;
    procedure ReadDataCell(Column: TColumnEh); override;
  public
    procedure ImportFromStream(AStream: TStream; IsImportAll: Boolean); override;
  end;

  { TDBGridEhImportAsUnicodeText }

  TDBGridEhImportAsUnicodeText = class(TDBGridEhImport)
  private
    FLastChar: WideChar;
    FLastState: TImportTextSreamState;
    FLastString: WideString;
    FIgnoreAll: Boolean;
    function GetChar(var ch: WideChar): Boolean;
    function CheckState: TImportTextSreamState;
    function GetString(var Value: WideString): TImportTextSreamState;
  protected
    procedure ReadPrefix; override;
    procedure ReadRecord(ColumnsList: TColumnsEhList); override;
    procedure ReadDataCell(Column: TColumnEh); override;
  public
    procedure ImportFromStream(AStream: TStream; IsImportAll: Boolean); override;
  end;

  { TDBGridEhImportAsVCLDBIF }

  TDBGridEhImportAsVCLDBIF = class(TDBGridEhImport)
  private
    Prefix: TVCLDBIF_BOF;
    FIgnoreAll: Boolean;
    LastValue: Variant;
    FieldNames: TStringList;
    UseFieldNames: Boolean;
    procedure ReadValue;
  protected
    procedure ReadPrefix; override;
    procedure ReadRecord(ColumnsList: TColumnsEhList); override;
    procedure ReadDataCell(Column: TColumnEh); override;
  public
    procedure ImportFromStream(AStream: TStream; IsImportAll: Boolean); override;
  end;

  procedure WriteDataCellToStreamAsVCLDBIFData(Stream: TStream; Column: TAxisBarEh);
  procedure WriteVCLDBIFStreamPrefix(Stream: TStream; BarList: TAxisBarsEhList);
  procedure WriteVCLDBIFStreamSuffix(Stream: TStream);

  function ReadValueFromVCLDBIFStream(Stream: TStream; var Value: Variant): Boolean;
  procedure AssignAsixBarValueFromVCLDBIFStream(var Value: Variant; AxisBar: TAxisBarEh; var IgnoreAssignError: Boolean);
  procedure ReadVCLDBIFStreamPrefix(Stream: TStream; var Prefix: TVCLDBIF_BOF; FieldList: TStringList);

  { Routines to import/export DBGridEh to/from file/stream }

procedure SaveDBGridEhToExportFile(ExportClass: TDBGridEhExportClass;
  DBGridEh: TCustomDBGridEh; const FileName: String; IsSaveAll: Boolean);
procedure WriteDBGridEhToExportStream(ExportClass: TDBGridEhExportClass;
  DBGridEh: TCustomDBGridEh; Stream: TStream; IsSaveAll: Boolean);

procedure LoadDBGridEhFromImportFile(ImportClass: TDBGridEhImportClass;
  DBGridEh: TCustomDBGridEh; const FileName: String; IsLoadToAll: Boolean);
procedure ReadDBGridEhFromImportStream(ImportClass: TDBGridEhImportClass;
  DBGridEh: TCustomDBGridEh; Stream: TStream; IsLoadToAll: Boolean);

  { Routines to support clipboard for DBGridEh }

var
  CF_VCLDBIF: Word;

var
  ExtendedVCLDBIFImpExpRowSelect: Boolean = True;
  DBGridEhImpExpCsvSeparator: Char = ';';
  DBGridEhImpExpCsvQuoteChar: Char = '"';

procedure DBGridEh_DoCutAction(DBGridEh: TCustomDBGridEh; ForWholeGrid: Boolean);
procedure DBGridEh_DoCopyAction(DBGridEh: TCustomDBGridEh; ForWholeGrid: Boolean);
procedure DBGridEh_DoPasteAction(DBGridEh: TCustomDBGridEh; ForWholeGrid: Boolean);
procedure DBGridEh_DoDeleteAction(DBGridEh: TCustomDBGridEh; ForWholeGrid: Boolean);

procedure Clipboard_PutFromStream(Format: Word; ms: TMemoryStream);
procedure Clipboard_GetToStream(Format: Word; ms: TMemoryStream);

{$IFDEF CIL}
{$ELSE}
function ExportDBGridEhToOleExcel(DBGridEh: TCustomDBGridEh;
  Options: TDBGridEhExportAsOLEXLSOptions; IsSaveAll: Boolean = True
//  ;const FileName: String = ''
  ): Variant;

{$IFDEF FPC}
{$ELSE}
  procedure ExportDBGridEhToXlsx(DBGridEh: TCustomDBGridEh;
    const FileName: String;
    Options: TDBGridEhExportAsXlsxOptions; IsSaveAll: Boolean = True);

  function ZipFileProviderClass: TCustomFileZipingProviderEhClass;
  function RegisterZipFileProviderClass(AZipFileProviderClass: TCustomFileZipingProviderEhClass): TCustomFileZipingProviderEhClass;
{$ENDIF}

{$ENDIF}

implementation

uses EhLibConsts,
  {$IFDEF FPC}
//  DbConst,
  {$ELSE}
  DbConsts,
  {$ENDIF}
  ToolCtrlsEh;

  { Routines to import/export DBGridEh to/from file/stream }

procedure WriteDBGridEhToExportStream(ExportClass: TDBGridEhExportClass;
  DBGridEh: TCustomDBGridEh; Stream: TStream; IsSaveAll: Boolean);
var DBGridEhExport: TDBGridEhExport;
begin
  DBGridEhExport := ExportClass.Create;
  try
    DBGridEhExport.DBGridEh := DBGridEh;
    DBGridEhExport.ExportToStream(Stream, IsSaveAll);
  finally
    DBGridEhExport.Free;
  end;
end;

procedure SaveDBGridEhToExportFile(ExportClass: TDBGridEhExportClass;
  DBGridEh: TCustomDBGridEh; const FileName: String; IsSaveAll: Boolean);
var DBGridEhExport: TDBGridEhExport;
begin
  DBGridEhExport := ExportClass.Create;
  try
    DBGridEhExport.DBGridEh := DBGridEh;
    DBGridEhExport.ExportToFile(FileName, IsSaveAll);
  finally
    DBGridEhExport.Free;
  end;
end;

procedure LoadDBGridEhFromImportFile(ImportClass: TDBGridEhImportClass;
  DBGridEh: TCustomDBGridEh; const FileName: String; IsLoadToAll: Boolean);
var DBGridEhImport: TDBGridEhImport;
begin
  DBGridEhImport := ImportClass.Create;
  try
    DBGridEhImport.DBGridEh := DBGridEh;
    DBGridEhImport.ImportFromFile(FileName, IsLoadToAll);
  finally
    DBGridEhImport.Free;
  end;
end;

procedure ReadDBGridEhFromImportStream(ImportClass: TDBGridEhImportClass;
  DBGridEh: TCustomDBGridEh; Stream: TStream; IsLoadToAll: Boolean);
var DBGridEhImport: TDBGridEhImport;
begin
  DBGridEhImport := ImportClass.Create;
  try
    DBGridEhImport.DBGridEh := DBGridEh;
    DBGridEhImport.ImportFromStream(Stream, IsLoadToAll);
  finally
    DBGridEhImport.Free;
  end;
end;

{ Routines to support clipboard with DBGridEh }

var
  CF_CSV: Word;
  CF_RICH_TEXT_FORMAT: Word;
//  CF_BIFF: Word;
//  CF_HTML_FORMAT: Word;

procedure Clipboard_PutFromStream(Format: Word; ms: TMemoryStream);
var
  Data: THandle;
  DataPtr: IntPtr;
{$IFNDEF CIL}
  Buffer: IntPtr;
{$ENDIF}
begin
{$IFNDEF CIL}
  Buffer := ms.Memory;
{$ENDIF}
  ClipBoard.Open;
  try
    Data := GlobalAlloc(GMEM_MOVEABLE + GMEM_DDESHARE, ms.Size);
    try
      DataPtr := GlobalLock(Data);
      try
{$IFDEF CIL}
        Marshal.Copy(ms.Memory, 0, DataPtr, ms.Size);
{$ELSE}
        Move(Buffer^, DataPtr^, ms.Size);
{$ENDIF}
{$IFDEF FPC}
        SetClipboardData(Format, Data);
{$ELSE}
        ClipBoard.SetAsHandle(Format, Data);
{$ENDIF}
      finally
        GlobalUnlock(Data);
      end;
    except
      GlobalFree(Data);
      raise;
    end;
  finally
    ClipBoard.Close;
  end;
end;

procedure Clipboard_GetToStream(Format: Word; ms: TMemoryStream);
var
  Data: THandle;
  DataPtr: IntPtr;
{$IFDEF CIL}
  DataBytes: TBytes;
{$ENDIF}
begin
  ClipBoard.Open;
  try
    {$IFDEF FPC}
    Data := GetClipboardData(Format);
    {$ELSE}
    Data := ClipBoard.GetAsHandle(Format);
    {$ENDIF}
    if Data = 0 then Exit;
    DataPtr := GlobalLock(Data);
    if DataPtr = nil then Exit;
    try
{$IFDEF CIL}
      SetLength(DataBytes, GlobalSize(Data));
      Marshal.Copy(DataPtr, DataBytes, 0, GlobalSize(Data));
      ms.WriteBuffer(DataBytes, Length(DataBytes));
{$ELSE}
      ms.WriteBuffer(DataPtr^, GlobalSize(Data));
{$ENDIF}
    finally
      GlobalUnlock(Data);
    end;
  finally
    ClipBoard.Close;
  end;
end;

procedure DBGridEh_DoCutAction(DBGridEh: TCustomDBGridEh; ForWholeGrid: Boolean);
begin
  DBGridEh_DoCopyAction(DBGridEh, ForWholeGrid);
  DBGridEh_DoDeleteAction(DBGridEh, ForWholeGrid);
end;

procedure DBGridEh_DoDeleteAction(DBGridEh: TCustomDBGridEh; ForWholeGrid: Boolean);
var
  i: Integer;
  ColList: TColumnsEhList;
  ASelectionType: TDBGridEhSelectionType;

  procedure ClearColumns;
  var
    i, j: Integer;
    Field: TField;
    FDataFields: TFieldsArrEh;

    procedure ClearField;
    begin
      if Field.DataSet.CanModify then
      begin
        Field.DataSet.Edit;
        if Field.DataSet.State in [dsEdit, dsInsert] then
          Field.Clear;
      end;
    end;

  begin
    FDataFields := nil;
    for i := 0 to ColList.Count - 1 do
    begin
      if ColList[i].CanModify(False) then
      begin
        if ColList[i].LookupParams.LookupActive then
        begin
          FDataFields := GetFieldsProperty(DBGridEh.DataSource.Dataset,
            nil, ColList[i].LookupParams.KeyFieldNames);
          for j := 0 to Length(FDataFields)-1 do
          begin
            Field := FDataFields[j];
            ClearField;
          end;
        end else
        begin
          Field := ColList[i].Field;
          ClearField;
        end;
      end;
    end;
  end;

  function DeletePrompt: Boolean;
  var
    Msg: string;
  begin
    Result := True;
    if ASelectionType = gstRecordBookmarks then
      if (DBGridEh.Selection.Rows.Count > 1) then
        Msg := Format(SDeleteMultipleRecordsQuestionEh, [DBGridEh.Selection.Rows.Count])
      else
      {$IFDEF FPC}
        Msg :='SDeleteRecordQuestion'
      {$ELSE}
        Msg :=SDeleteRecordQuestion
      {$ENDIF}
    else if ASelectionType = gstAll then
      Msg := SDeleteAllRecordsQuestionEh
    else if ASelectionType = gstRectangle then
      Msg := SClearSelectedCellsEh
    else
      Exit;
    Result := not (dgConfirmDelete in DBGridEh.Options) or
      (MessageDlg(Msg, mtConfirmation, mbOKCancel, 0) <> idCancel);
  end;

begin
  with DBGridEh do
  begin
    if ForWholeGrid then ASelectionType := gstAll else ASelectionType := Selection.SelectionType;
    if (ASelectionType = gstNon) or
      (DataSource = nil) or (DataSource.Dataset = nil) or
      not DeletePrompt then
      Exit;
    with DataSource.Dataset do
    begin
      SaveBookmark;
      DisableControls;
      try
        case ASelectionType of
          gstRecordBookmarks:
            begin
              ColList := VisibleColumns;
              for i := Selection.Rows.Count - 1 downto 0 do
              begin
                Bookmark := Selection.Rows[I];
                Delete;
              end;
              Selection.Clear;
            end;
          gstRectangle:
            begin
              ColList := TColumnsEhList.Create;
              try
                for i := Selection.Rect.LeftCol to Selection.Rect.RightCol do
                  if Columns[i].Visible then
                    ColList.Add(Columns[i]);
                Bookmark := Selection.Rect.TopRow;
                while True do
                begin
                  ClearColumns;
                  if DataSetCompareBookmarks(DBGridEh.DataSource.Dataset,
                    Selection.Rect.BottomRow, Bookmark) = 0 then Break;
                  Next;
                  if Eof then Break;
                end;
              finally
                ColList.Free;
              end;
              RestoreBookmark;
            end;
          gstColumns:
            begin
              ColList := Selection.Columns;
              First;
              while Eof = False do
              begin
                ClearColumns;
                Next;
              end;
              RestoreBookmark;
            end;
          gstAll:
            begin
              ColList := VisibleColumns;
              First;
              while Eof = False do
                Delete;
            end;
        end;
      finally
        EnableControls;
      end;
    end;
  end;
end;

function IsPlatformNT():boolean;
var VI : TOSVersionInfo;
begin
  VI.dwOSVersionInfoSize := sizeof (VI);
  GetVersionEx (VI);
  result := (VI.dwPlatformId = VER_PLATFORM_WIN32_NT);
end;

{$IFNDEF CIL}
procedure Clipboard_PutUnicodeFromStream(ms: TMemoryStream);
var
  Data: THandle;
  DataPtr: IntPtr;
  BufSize: Integer;
  Buffer: IntPtr;
begin
  Buffer := ms.Memory;
  ClipBoard.Open;
  try
    BufSize := MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED, Buffer, ms.Size,
      nil, 0) * 2;
    Data := GlobalAlloc(GMEM_MOVEABLE + GMEM_DDESHARE, BufSize);
    try
      DataPtr := GlobalLock(Data);
      MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED, Buffer, ms.Size, DataPtr,
        BufSize div 2);
      try
        {$IFDEF FPC}
        SetClipboardData(CF_UNICODETEXT, Data);
        {$ELSE}
        ClipBoard.SetAsHandle(CF_UNICODETEXT, Data);
        {$ENDIF}
      finally
        GlobalUnlock(Data);
      end;
    except
      GlobalFree(Data);
      raise;
    end;
  finally
    ClipBoard.Close;
  end;
end;
{$ENDIF}

procedure SreamWriteNullAnsiStr(st: TStream);
begin
{$IFDEF CIL}
    st.WriteBuffer([0,0], 2);
{$ELSE}
  {$IFDEF FPC}
  //???    TO DO : To do
  {$ELSE}
   st.WriteBuffer(PAnsiChar('')^, 1);
  {$ENDIF}
{$ENDIF}
end;

procedure SreamWriteNullWideStr(st: TStream);
const WS: WideString = '';
begin
{$IFDEF CIL}
    st.WriteBuffer([0], 1);
{$ELSE}
    st.WriteBuffer(PWideChar(WS)^, 2);
{$ENDIF}
end;

procedure DBGridEh_DoCopyAction(DBGridEh: TCustomDBGridEh; ForWholeGrid: Boolean);
var
  ms: TMemoryStreamEh;
begin
  ms := nil;
  Clipboard.Open;

  DBGridEh.DataSource.Dataset.DisableControls;
  try
    ms := TMemoryStreamEh.Create;
    ms.HalfMemoryDelta := $10000;

    WriteDBGridEhToExportStream(TDBGridEhExportAsText, DBGridEh, ms, ForWholeGrid);
    SreamWriteNullAnsiStr(ms);
    Clipboard_PutFromStream(CF_TEXT, ms);
(*
{$IFNDEF CIL}
    if IsPlatformNT() then
      Clipboard_PutUnicodeFromStream(ms);
{$ENDIF}
*)
    ms.Clear;

    WriteDBGridEhToExportStream(TDBGridEhExportAsUnicodeText, DBGridEh, ms, ForWholeGrid);
    SreamWriteNullWideStr(ms);
    Clipboard_PutFromStream(CF_UNICODETEXT, ms);
    ms.Clear;

    WriteDBGridEhToExportStream(TDBGridEhExportAsCSV, DBGridEh, ms, ForWholeGrid);
    SreamWriteNullAnsiStr(ms);
    Clipboard_PutFromStream(CF_CSV, ms);
    ms.Clear;

    WriteDBGridEhToExportStream(TDBGridEhExportAsRTF, DBGridEh, ms, ForWholeGrid);
    SreamWriteNullAnsiStr(ms);
    Clipboard_PutFromStream(CF_RICH_TEXT_FORMAT, ms);
    ms.Clear;

    WriteDBGridEhToExportStream(TDBGridEhExportAsVCLDBIF, DBGridEh, ms, ForWholeGrid);
    Clipboard_PutFromStream(CF_VCLDBIF, ms);
    ms.Clear;

    { This version of HTML and Biff export routines don't work under MS Office

    WriteDBGridEhToExportStream(TDBGridEhExportAsHTML,DBGridEh,ms,ForWholeGrid);
    Clipboard_PutFromStream(CF_HTML_FORMAT,ms);
    ms.Clear;

    WriteDBGridEhToExportStream(TDBGridEhExportAsXLS,DBGridEh,ms,ForWholeGrid);
    Clipboard_PutFromStream(CF_BIFF,ms);
    ms.Clear;
    }

  finally
    ms.Free;
    Clipboard.Close;
    DBGridEh.DataSource.Dataset.EnableControls;
  end;
end;

procedure DBGridEh_DoPasteAction(DBGridEh: TCustomDBGridEh; ForWholeGrid: Boolean);
var
  ms: TMemoryStream;
begin
  ms := nil;
  Clipboard.Open;
  try
    ms := TMemoryStream.Create;

    if Clipboard.HasFormat(CF_VCLDBIF) then
    begin
      Clipboard_GetToStream(CF_VCLDBIF, ms);
      ms.Position := 0;
      ReadDBGridEhFromImportStream(TDBGridEhImportAsVCLDBIF, DBGridEh, ms, ForWholeGrid);
    end
    else if Clipboard.HasFormat(CF_UNICODETEXT) then
    begin
      Clipboard_GetToStream(CF_UNICODETEXT, ms);
      ms.Position := 0;
      ReadDBGridEhFromImportStream(TDBGridEhImportAsUnicodeText, DBGridEh, ms, ForWholeGrid);
    end
    else if Clipboard.HasFormat(CF_TEXT) then
    begin
      Clipboard_GetToStream(CF_TEXT, ms);
      ms.Position := 0;
      ReadDBGridEhFromImportStream(TDBGridEhImportAsText, DBGridEh, ms, ForWholeGrid);
    end;

  finally
    ms.Free;
    Clipboard.Close;
  end;
end;

procedure StreamWriteAnsiString(Stream: TStream; S: AnsiString);
{$IFDEF CIL}
var
  b: TBytes;
{$ENDIF}
begin
{$IFDEF CIL}
    b := BytesOf(AnsiString(S));
    Stream.Write(b, Length(b));
{$ELSE}
    Stream.Write(PAnsiChar(S)^, Length(S));
{$ENDIF}
end;

procedure StreamWriteWideString(Stream: TStream; S: WideString);
{$IFDEF CIL}
var
  b: TBytes;
{$ENDIF}
begin
{$IFDEF CIL}
    b := BytesOf(S);
    Stream.Write(b, Length(b));
{$ELSE}
    Stream.Write(PWideChar(S)^, Length(S)*2);
{$ENDIF}
end;

{ TDBGridEhExport }

procedure TDBGridEhExport.ExportToFile(FileName: String; IsExportAll: Boolean);
var
  FileStream: TFileStream;
begin
  FileStream := TFileStream.Create(FileName, fmCreate);
  try
    ExportToStream(FileStream, IsExportAll);
  finally
    FileStream.Free;
  end;
end;

procedure TDBGridEhExport.ExportToStream(AStream: TStream; IsExportAll: Boolean);
var
  i: Integer;
  RCount: Integer;
  ColList: TColumnsEhList;
  IsFreeColList: Boolean;
  ASelectionType: TDBGridEhSelectionType;
begin
  Stream := AStream;
  ColList := nil;
  IsFreeColList := False;
  try
    with DBGridEh do
    begin
      if IsExportAll
        then ASelectionType := gstAll
        else ASelectionType := Selection.SelectionType;
      with DataSource.Dataset do
      begin
        DisableControls;
        SaveBookmark;
        try
          case ASelectionType of
            gstNon:
              begin
                if ( (DataSource <> nil) and (DataSource.DataSet <> nil) and
                      not DataSource.DataSet.IsEmpty )
                then
                  Exit;
                ColList := TColumnsEhList.Create;
                IsFreeColList := True;
                ColList.Add(Columns[SelectedIndex]);
                if ExpCols = nil then
                  ExpCols := ColList;
                WritePrefix;
                WriteRecord(ColList);
              end;
            gstRecordBookmarks:
              begin
                if ExpCols = nil then
                  ExpCols := VisibleColumns;
                SetLength(FooterValues, ExpCols.Count * DBGridEh.FooterRowCount);
                WritePrefix;
                if dgTitles in Options then WriteTitle(VisibleColumns);
                for i := 0 to Selection.Rows.Count - 1 do
                begin
                  Bookmark := Selection.Rows[I];
                  CalcFooterValues;
                  WriteRecord(VisibleColumns);
                end;
                for i := 0 to FooterRowCount - 1 do WriteFooter(VisibleColumns, i);
              end;
            gstRectangle:
              begin
                ColList := TColumnsEhList.Create;
                IsFreeColList := True;
                for i := Selection.Rect.LeftCol to Selection.Rect.RightCol do
                  if Columns[i].Visible then
                    ColList.Add(Columns[i]);
                if ExpCols = nil then
                  ExpCols := ColList;
                SetLength(FooterValues, ExpCols.Count * DBGridEh.FooterRowCount);
                WritePrefix;
                if dgTitles in Options then WriteTitle(ColList);
                Bookmark := Selection.Rect.TopRow;
                while True do
                begin
                  WriteRecord(ColList);
                  CalcFooterValues;
                  if DataSetCompareBookmarks(DBGridEh.DataSource.Dataset, Selection.Rect.BottomRow, Bookmark) = 0 then Break;
                  Next;
                  if Eof then Break;
                end;
                for i := 0 to FooterRowCount - 1 do WriteFooter(ColList, i);
              end;
            gstColumns:
              begin
                if ExpCols = nil then
                  ExpCols := Selection.Columns;
                SetLength(FooterValues, ExpCols.Count * DBGridEh.FooterRowCount);
                WritePrefix;
                if dgTitles in Options then WriteTitle(Selection.Columns);
                RCount := RecordCount;
                First;
                while Eof = False do
                begin
                  WriteRecord(Selection.Columns);
                  CalcFooterValues;

                  if IsSequenced and (RecNo >= RCount) then
                    Break;

                  Next;
                end;
                for i := 0 to FooterRowCount - 1 do WriteFooter(Selection.Columns, i);
              end;
            gstAll:
              begin
                if ExpCols = nil then
                  ExpCols := VisibleColumns;
                SetLength(FooterValues, ExpCols.Count * DBGridEh.FooterRowCount);
                WritePrefix;
                if dgTitles in Options then WriteTitle(VisibleColumns);
                RCount := RecordCount;
                First;
                while Eof = False do
                begin
                  WriteRecord(VisibleColumns);
                  CalcFooterValues;

                  if IsSequenced and (RecNo >= RCount) then
                    Break;

                  Next;
                end;
                for i := 0 to FooterRowCount - 1 do WriteFooter(VisibleColumns, i);
              end;
          end;
        finally
          RestoreBookmark;
          EnableControls;
        end;
      end;
    end;
    WriteSuffix;
  finally
    if IsFreeColList then
      FreeAndNil(ColList);
  end;
end;

procedure TDBGridEhExport.WriteTitle(ColumnsList: TColumnsEhList);
begin
end;

procedure TDBGridEhExport.WriteRecord(ColumnsList: TColumnsEhList);
var i: Integer;
  AFont: TFont;
  NewBackground: TColor;
//    State:TGridDrawState;
begin
  AFont := TFont.Create;
  try
    for i := 0 to ColumnsList.Count - 1 do
    begin
      AFont.Assign(ColumnsList[i].Font);

      with FColCellParamsEh do
      begin
        Row := -1;
        Col := -1;
        State := [];
        Font := AFont;
        Background := ColumnsList[i].Color;
        NewBackground := ColumnsList[i].Color;
        Alignment := ColumnsList[i].Alignment;
        ImageIndex := ColumnsList[i].GetImageIndex;
        Text := ColumnsList[i].DisplayText;
        CheckboxState := ColumnsList[i].CheckboxState;

        if Assigned(DBGridEh.OnGetCellParams) then
          DBGridEh.OnGetCellParams(DBGridEh, ColumnsList[i], Font, NewBackground, State);
        Background := NewBackground;

        ColumnsList[i].GetColCellParams(False, FColCellParamsEh);

        WriteDataCell(ColumnsList[i], FColCellParamsEh);

      end;
    end;
  finally
    AFont.Free;
  end;
end;

procedure TDBGridEhExport.WriteFooter(ColumnsList: TColumnsEhList; FooterNo: Integer);
var i: Integer;
  Font: TFont;
  Background: TColor;
  State: TGridDrawState;
  Alignment: TAlignment;
  Value: String;
begin
  Font := TFont.Create;
  try
    for i := 0 to ColumnsList.Count - 1 do
    begin
      Font.Assign(ColumnsList[i].UsedFooter(FooterNo).Font);
      Background := ColumnsList[i].UsedFooter(FooterNo).Color;
      Alignment := ColumnsList[i].UsedFooter(FooterNo).Alignment;
      if ColumnsList[i].UsedFooter(FooterNo).ValueType in [fvtSum, fvtCount] then
        Value := GetFooterValue(FooterNo, i)
      else
        Value := DBGridEh.GetFooterValue(FooterNo, ColumnsList[i]);
      State := [];
      if Assigned(DBGridEh.OnGetFooterParams) then
        DBGridEh.OnGetFooterParams(DBGridEh, ColumnsList[i].Index, FooterNo,
          ColumnsList[i], Font, Background, Alignment, State, Value);
      WriteFooterCell(i, FooterNo, ColumnsList[i], Font, Background,
        Alignment, Value);
    end;
  finally
    Font.Free;
  end;
end;

procedure TDBGridEhExport.WritePrefix;
begin
end;

procedure TDBGridEhExport.WriteSuffix;
begin
end;

procedure TDBGridEhExport.WriteDataCell(Column: TColumnEh; FColCellParamsEh: TColCellParamsEh);
begin
end;

procedure TDBGridEhExport.WriteFooterCell(DataCol, Row: Integer; Column: TColumnEh;
  AFont: TFont; Background: TColor; Alignment: TAlignment; Text: String);
begin
end;

procedure TDBGridEhExport.CalcFooterValues;
var i, j: Integer;
  Field: TField;
  Footer: TColumnFooterEh;
begin
  for i := 0 to DBGridEh.FooterRowCount - 1 do
    for j := 0 to ExpCols.Count - 1 do
    begin
      Footer := ExpCols[j].UsedFooter(i);
      if Footer.FieldName <> '' then
        Field := DBGridEh.DataSource.DataSet.FindField(Footer.FieldName)
      else
        Field := DBGridEh.DataSource.DataSet.FindField(ExpCols[j].FieldName);
      if Field = nil then Continue;
      case Footer.ValueType of
        fvtSum:
          if (Field.IsNull = False) then
            FooterValues[i * ExpCols.Count + j] := FooterValues[i * ExpCols.Count + j] + Field.AsFloat;
        fvtCount:
          FooterValues[i * ExpCols.Count + j] := FooterValues[i * ExpCols.Count + j] + 1;
      end;
    end;
end;

function TDBGridEhExport.GetFooterValue(Row, Col: Integer): String;
var
  FmtStr: string;
  Format: TFloatFormat;
  Digits: Integer;
  v: Variant;
  Field: TField;
  Footer: TColumnFooterEh;
begin
  Result := '';
  Footer := ExpCols[Col].UsedFooter(Row);
  case Footer.ValueType of
    fvtSum:
      begin
        if ExpCols[Col].UsedFooter(Row).FieldName <> '' then
          Field := DBGridEh.DataSource.DataSet.FindField(ExpCols[Col].UsedFooter(Row).FieldName)
        else
          Field := DBGridEh.DataSource.DataSet.FindField(ExpCols[Col].FieldName);
        if Field = nil then Exit;
        with Field do begin
          v := FooterValues[Row * ExpCols.Count + Col];
          case DataType of
            ftSmallint, ftInteger, ftAutoInc, ftWord:
              with Field as TIntegerField do
              begin
                if Footer.DisplayFormat <> ''
                  then FmtStr := Footer.DisplayFormat
                  else FmtStr := DisplayFormat;
                if FmtStr = ''
                  then Result := IntToStr(Integer(v))
                  else Result := FormatFloat(FmtStr, v);
              end;
            ftBCD:
              with Field as TBCDField do
              begin
              //if EditFormat = '' then FmtStr := DisplayFormat else FmtStr := EditFormat;
                if Footer.DisplayFormat <> ''
                  then FmtStr := Footer.DisplayFormat
                  else FmtStr := DisplayFormat;
                if FmtStr = '' then
                begin
                  if Currency then
                  begin
                    Format := ffCurrency;
                    Digits := FormatSettings.CurrencyDecimals;
                  end else
                  begin
                    Format := ffGeneral;
                    Digits := 0;
                  end;
                  Result := CurrToStrF(v, Format, Digits);
                end else
                  Result := FormatCurr(FmtStr, v);
              end;
{$IFDEF EH_LIB_6}
            ftFMTBcd:
              with Field as TFMTBCDField do
              begin
              //if EditFormat = '' then FmtStr := DisplayFormat else FmtStr := EditFormat;
                if Footer.DisplayFormat <> ''
                  then FmtStr := Footer.DisplayFormat
                  else FmtStr := DisplayFormat;
                if FmtStr = '' then
                begin
                  if Currency then
                  begin
                    Format := ffCurrency;
                    Digits := FormatSettings.CurrencyDecimals;
                  end else
                  begin
                    Format := ffGeneral;
                    Digits := 0;
                  end;
                  Result := CurrToStrF(v, Format, Digits);
                end else
                  Result := FormatCurr(FmtStr, v);
              end;
{$ENDIF}
            ftFloat, ftCurrency:
              with Field as TFloatField do
              begin
             //if EditFormat = '' then FmtStr := DisplayFormat else FmtStr := EditFormat;
                if Footer.DisplayFormat <> ''
                  then FmtStr := Footer.DisplayFormat
                  else FmtStr := DisplayFormat;
                if FmtStr = '' then
                begin
                  if Currency then
                  begin
                    Format := ffCurrency;
                    Digits := FormatSettings.CurrencyDecimals;
                  end else
                  begin
                    Format := ffGeneral;
                    Digits := 0;
                  end;
                  Result := FloatToStrF(Double(v), Format, Precision, Digits);
                end else
                  Result := FormatFloat(FmtStr, v);
              end;
          end;
        end;
      end;
    fvtCount:
      if Footer.DisplayFormat <> ''
        then Result := FormatFloat(Footer.DisplayFormat, FooterValues[Row * ExpCols.Count + Col])
        else Result := FloatToStr(FooterValues[Row * ExpCols.Count + Col]);
  end;
end;


constructor TDBGridEhExport.Create;
begin
  inherited Create;
  FColCellParamsEh := TColCellParamsEh.Create;
end;

destructor TDBGridEhExport.Destroy;
begin
  FreeAndNil(FColCellParamsEh);
  inherited Destroy;
end;

{ TDBGridEhExportAsText }

procedure TDBGridEhExportAsText.WriteTitle(ColumnsList: TColumnsEhList);
var i: Integer;
  s: AnsiString;
begin
  CheckFirstRec;
  for i := 0 to ColumnsList.Count - 1 do
  begin
    s := AnsiString(ColumnsList[i].Title.Caption);
    if i <> ColumnsList.Count - 1 then
      s := s + #09;
    StreamWriteAnsiString(Stream, s);
  end;
end;

procedure TDBGridEhExportAsText.WriteRecord(ColumnsList: TColumnsEhList);
begin
  CheckFirstRec;
  FirstCell := True;
  inherited WriteRecord(ColumnsList);
end;

procedure TDBGridEhExportAsText.WriteFooter(ColumnsList: TColumnsEhList; FooterNo: Integer);
begin
  CheckFirstRec;
  FirstCell := True;
  inherited WriteFooter(ColumnsList, FooterNo);
end;

procedure TDBGridEhExportAsText.WritePrefix;
begin
end;

procedure TDBGridEhExportAsText.WriteSuffix;
begin
end;

procedure TDBGridEhExportAsText.ExportToStream(Stream: TStream;
  IsExportAll: Boolean);
begin
  FirstRec := True;
  inherited ExportToStream(Stream, IsExportAll);
end;

procedure TDBGridEhExportAsText.WriteDataCell(Column: TColumnEh; FColCellParamsEh: TColCellParamsEh);
var
  s: AnsiString;
begin
  CheckFirstCell;
  if Assigned(Column.Field) and
     (Column.Field is TNumericField) and
     Column.Grid.Center.PreferEditFormatForNumberFields
  then
    s := AnsiString(Column.EditText)
  else
    s := AnsiString(FColCellParamsEh.Text);
  StreamWriteAnsiString(Stream, s);
end;

procedure TDBGridEhExportAsText.WriteFooterCell(DataCol, Row: Integer;
  Column: TColumnEh; AFont: TFont; Background: TColor;
  Alignment: TAlignment; Text: String);
var s: AnsiString;
begin
  CheckFirstCell;
  s := AnsiString(Text);
  StreamWriteAnsiString(Stream, s);
end;

procedure TDBGridEhExportAsText.CheckFirstCell;
var s: AnsiString;
begin
  if FirstCell = False then
  begin
    s := #09;
    StreamWriteAnsiString(Stream, s);
  end else
    FirstCell := False;
end;

procedure TDBGridEhExportAsText.CheckFirstRec;
var s: AnsiString;
begin
  if FirstRec = False then
  begin
    s := #13#10;
    StreamWriteAnsiString(Stream, s);
  end else
    FirstRec := False;
end;

{ TDBGridEhExportAsUnicodeText }

procedure TDBGridEhExportAsUnicodeText.WriteTitle(ColumnsList: TColumnsEhList);
var
  i: Integer;
  s: WideString;
begin
  CheckFirstRec;
  for i := 0 to ColumnsList.Count - 1 do
  begin
    s := WideString(ColumnsList[i].Title.Caption);
    if i <> ColumnsList.Count - 1 then
      s := s + #09;
    StreamWriteWideString(Stream, s);
  end;
end;

procedure TDBGridEhExportAsUnicodeText.WriteRecord(ColumnsList: TColumnsEhList);
begin
  CheckFirstRec;
  FirstCell := True;
  inherited WriteRecord(ColumnsList);
end;

procedure TDBGridEhExportAsUnicodeText.WriteFooter(ColumnsList: TColumnsEhList; FooterNo: Integer);
begin
  CheckFirstRec;
  FirstCell := True;
  inherited WriteFooter(ColumnsList, FooterNo);
end;

procedure TDBGridEhExportAsUnicodeText.WritePrefix;
begin
end;

procedure TDBGridEhExportAsUnicodeText.WriteSuffix;
begin
end;

procedure TDBGridEhExportAsUnicodeText.ExportToStream(Stream: TStream;
  IsExportAll: Boolean);
begin
  FirstRec := True;
  inherited ExportToStream(Stream, IsExportAll);
end;

procedure TDBGridEhExportAsUnicodeText.WriteDataCell(Column: TColumnEh; FColCellParamsEh: TColCellParamsEh);
var
  s: WideString;
begin
  CheckFirstCell;
  if Assigned(Column.Field) and
     (Column.Field is TNumericField) and
     Column.Grid.Center.PreferEditFormatForNumberFields
  then
    s := WideString(Column.EditText)
  else
    s := WideString(FColCellParamsEh.Text);
  StreamWriteWideString(Stream, s);
end;

procedure TDBGridEhExportAsUnicodeText.WriteFooterCell(DataCol, Row: Integer;
  Column: TColumnEh; AFont: TFont; Background: TColor;
  Alignment: TAlignment; Text: String);
var
  s: WideString;
begin
  CheckFirstCell;
  s := WideString(Text);
  StreamWriteWideString(Stream, s);
end;

procedure TDBGridEhExportAsUnicodeText.CheckFirstCell;
var
  s: WideString;
begin
  if FirstCell = False then
  begin
    s := #09;
    StreamWriteWideString(Stream, s);
  end else
    FirstCell := False;
end;

procedure TDBGridEhExportAsUnicodeText.CheckFirstRec;
var
  s: WideString;
begin
  if FirstRec = False then
  begin
    s := #13#10;
    StreamWriteWideString(Stream, s);
  end else
    FirstRec := False;
end;

{ TDBGridEhExportAsCVS }

procedure TDBGridEhExportAsCSV.CheckFirstCell;
var
  s: AnsiString;
begin
  if (FirstCell = False) and (Separator > #0) then
  begin
    s := Separator;
    StreamWriteAnsiString(Stream, s);
  end else
    FirstCell := False;
end;

constructor TDBGridEhExportAsCSV.Create;
begin
  inherited Create;
  Separator := AnsiChar(DBGridEhImpExpCsvSeparator);
  QuoteChar := AnsiChar(DBGridEhImpExpCsvQuoteChar);
end;

procedure TDBGridEhExportAsCSV.WriteDataCell(Column: TColumnEh; FColCellParamsEh: TColCellParamsEh);
var s: AnsiString;
begin
  CheckFirstCell;
  if QuoteChar > #0 then
    s := AnsiString(AnsiQuotedStr(FColCellParamsEh.Text, Char(QuoteChar)))
  else
    s := AnsiString(FColCellParamsEh.Text);
  StreamWriteAnsiString(Stream, s);
end;

procedure TDBGridEhExportAsCSV.WriteFooterCell(DataCol, Row: Integer;
  Column: TColumnEh; AFont: TFont; Background: TColor;
  Alignment: TAlignment; Text: String);
var s: AnsiString;
begin
  CheckFirstCell;
  if QuoteChar > #0 then
    s := AnsiString(AnsiQuotedStr(Text, Char(QuoteChar)))
  else
    s := AnsiString(Text);
  StreamWriteAnsiString(Stream, s);
end;

procedure TDBGridEhExportAsCSV.WriteTitle(ColumnsList: TColumnsEhList);
var i: Integer;
  s: AnsiString;
begin
  CheckFirstRec;
  for i := 0 to ColumnsList.Count - 1 do
  begin
    if QuoteChar > #0 then
      s := AnsiString(AnsiQuotedStr(ColumnsList[i].Title.Caption, Char(QuoteChar)))
    else
      s := AnsiString(ColumnsList[i].Title.Caption);
    if (i <> ColumnsList.Count - 1) and (Separator > #0) then
      s := s + Separator;
    StreamWriteAnsiString(Stream, s);
  end;
end;

{ Routines to convert MultiTitle in matrix (List of Lists) }

type
  TTitleExpRec = record
    Height: Integer;
    PTLeafCol: THeadTreeNode;
  end;

//  PTitleExpRec = ^TTitleExpRec;
  TTitleExpArr = array of TTitleExpRec;

procedure CalcSpan(
  ColumnsList: TColumnsEhList; ListOfHeadTreeNodeList: TList;
  Row, Col: Integer;
  var AColSpan: Integer; var ARowSpan: Integer
  );
var Node: THeadTreeNode;
  i, k: Integer;
begin
  AColSpan := 1; ARowSpan := 1;
  Node := THeadTreeNode(TList(ListOfHeadTreeNodeList.Items[Row]).Items[Col]);
  if Node <> nil then
  begin
    for k := Row - 1 downto 0 do
      if THeadTreeNode(TList(ListOfHeadTreeNodeList.Items[k]).Items[Col]) = Node
        then
      begin
        Inc(ARowSpan);
        TList(ListOfHeadTreeNodeList.Items[k]).Items[Col] := nil;
      end else
        Break;

    for i := Col + 1 to ColumnsList.Count - 1 do
      if THeadTreeNode(TList(ListOfHeadTreeNodeList.Items[Row]).Items[i]) = Node
        then
      begin
        Inc(AColSpan);
        TList(ListOfHeadTreeNodeList.Items[Row]).Items[i] := nil;
      end else
        Break;

    for k := Row - 1 downto Row - ARowSpan + 1 do
      for i := Col + 1 to Col + AColSpan - 1 do
        TList(ListOfHeadTreeNodeList.Items[k]).Items[i] := nil;
  end;
end;

procedure CreateMultiTitleMatrix(DBGridEh: TCustomDBGridEh;
  ColumnsList: TColumnsEhList;
  var FPTitleExpArr: TTitleExpArr;
  var ListOfHeadTreeNodeList: TList);
var i: Integer;
  NeedNextStep: Boolean;
  MinHeight: Integer;
  FHeadTreeNodeList: TList;
begin
  ListOfHeadTreeNodeList := nil;
  SetLength(FPTitleExpArr, ColumnsList.Count);
  for i := 0 to ColumnsList.Count - 1 do
  begin
    FPTitleExpArr[i].Height := DBGridEh.LeafFieldArr[ColumnsList[i].Index].FLeaf.Height;
    FPTitleExpArr[i].PTLeafCol := DBGridEh.LeafFieldArr[ColumnsList[i].Index].FLeaf;
  end;
  ListOfHeadTreeNodeList := TList.Create;
  NeedNextStep := True;
  while True do
  begin
    //search min height
    MinHeight := FPTitleExpArr[0].Height;
    for i := 1 to ColumnsList.Count - 1 do
      if FPTitleExpArr[i].Height < MinHeight then
        MinHeight := FPTitleExpArr[i].Height;
    //add NodeList
    FHeadTreeNodeList := TList.Create;
    for i := 0 to ColumnsList.Count - 1 do
    begin
      FHeadTreeNodeList.Add(FPTitleExpArr[i].PTLeafCol);
      if FPTitleExpArr[i].Height = MinHeight then
      begin
        if FPTitleExpArr[i].PTLeafCol.Host <> nil then
        begin
          FPTitleExpArr[i].PTLeafCol := FPTitleExpArr[i].PTLeafCol.Host;
          Inc(FPTitleExpArr[i].Height, FPTitleExpArr[i].PTLeafCol.Height);
          NeedNextStep := True;
        end;
      end;
    end;
    if not NeedNextStep then
    begin
      FreeAndNil(FHeadTreeNodeList);
      Break;
    end;
    ListOfHeadTreeNodeList.Add(FHeadTreeNodeList);
    NeedNextStep := False;
  end;
end;

{ TDBGridEhExportAsHTML }

procedure TDBGridEhExportAsHTML.Put(Text: String);
{$IFDEF EH_LIB_12}
var
  B: RawByteString;
{$ENDIF}
begin
{$IFDEF EH_LIB_12}
  B := UTF8Encode(Text);
  Stream.Write(Pointer(B)^, Length(B));
{$ELSE}

{$IFDEF CIL}
{$ELSE}
  Stream.Write(PChar(Text)^, Length(Text) * SizeOf(Char));
{$ENDIF}

{$ENDIF}
end;

procedure TDBGridEhExportAsHTML.PutL(Text: String);
begin
  Put(Text + #13#10);
end;

procedure TDBGridEhExportAsHTML.WritePrefix;
var s: String;
  CellPaddingInc: String;
begin
  PutL('<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">');
  PutL('<html>');
  PutL('<head>');
  PutL('<title>');
  PutL(DBGridEh.Name);
  PutL('</title>');
{$IFDEF EH_LIB_12}
  PutL('<meta http-equiv="Content-Type" content="text/html; charset=utf-8">');
{$ENDIF}
  PutL('</head>');

  PutL('<body>');

  s := '<table ';
  if DBGridEh.Flat then CellPaddingInc := '1' else CellPaddingInc := '2';
  if DBGridEh.Options * [dgColLines, dgRowLines] <> [] then
    if DBGridEh.Ctl3D then s := s + 'BORDER=1 CELLSPACING=0 CELLPADDING=' + CellPaddingInc
    else s := s + 'BORDER=0 CELLSPACING=1 CELLPADDING=' + CellPaddingInc
  else
    s := s + 'BORDER=0 CELLSPACING=0 CELLPADDING=' + CellPaddingInc;
  s := s + ' BGCOLOR=#' + GetColor(DBGridEh.FixedColor) + '>' + #13#10;
  PutL(s);
end;

procedure TDBGridEhExportAsHTML.WriteSuffix;
begin
  PutL('</table>');
  PutL('</body>');
  PutL('</html>');
end;

procedure TDBGridEhExportAsHTML.WriteTitle(ColumnsList: TColumnsEhList);
var i, k: Integer;
  FPTitleExpArr: TTitleExpArr;
  ListOfHeadTreeNodeList: TList;
  ColSpan, RowSpan: Integer;
begin
  if ColumnsList.Count = 0 then Exit;

  if DBGridEh.UseMultiTitle then
  begin
    try
      CreateMultiTitleMatrix(DBGridEh, ColumnsList, FPTitleExpArr, ListOfHeadTreeNodeList);

      for k := ListOfHeadTreeNodeList.Count - 1 downto 1 do
      begin
        PutL('<TR>');
        for i := 0 to ColumnsList.Count - 1 do
        begin
          if THeadTreeNode(TList(ListOfHeadTreeNodeList.Items[k]).Items[i]) <> nil then
          begin
            Put('  <TD ALIGN="CENTER"');
            CalcSpan(ColumnsList, ListOfHeadTreeNodeList, k, i, ColSpan, RowSpan);
            if ColSpan > 1 then
              Put(' COLSPAN = "' + IntToStr(ColSpan) + '"');
            if RowSpan > 1 then
              Put(' ROWSPAN = "' + IntToStr(RowSpan) + '"');
            Put('>');
            PutText(DBGridEh.TitleFont,
              THeadTreeNode(TList(ListOfHeadTreeNodeList.Items[k]).Items[i]).Text);
            PutL('</TD>');
          end;
        end;
        PutL('</TR>');
      end;

      PutL('<TR>');
      for i := 0 to ColumnsList.Count - 1 do
      begin
        if THeadTreeNode(TList(ListOfHeadTreeNodeList.Items[0]).Items[i]) <> nil then
        begin
          Put('  <TD WIDTH=' + IntToStr(ColumnsList[i].Width) + ' ALIGN="CENTER"');
          CalcSpan(ColumnsList, ListOfHeadTreeNodeList, 0, i, ColSpan, RowSpan);
          if ColSpan > 1 then
            Put(' COLSPAN = "' + IntToStr(ColSpan) + '"');
          if RowSpan > 1 then
            Put(' ROWSPAN = "' + IntToStr(RowSpan) + '"');
          Put('>');
          PutText(ColumnsList[i].Title.Font,
            THeadTreeNode(TList(ListOfHeadTreeNodeList.Items[0]).Items[i]).Text);
          PutL('</TD>');
        end;
      end;
      PutL('</TR>');

    finally
      for i := 0 to ListOfHeadTreeNodeList.Count - 1 do
        TList(ListOfHeadTreeNodeList.Items[i]).Free;
      ListOfHeadTreeNodeList.Free;
    end;
  end else
  begin
    PutL('<TR>');
    for i := 0 to ColumnsList.Count - 1 do
    begin
      Put('  <TD WIDTH=' + IntToStr(ColumnsList[i].Width) +
        ' ALIGN="' + GetAlignment(ColumnsList[i].Title.Alignment) + '"' + '>');
      PutText(ColumnsList[i].Title.Font, ColumnsList[i].Title.Caption);
      PutL('</TD>');
    end;
    PutL('</TR>');
  end;
end;

procedure TDBGridEhExportAsHTML.WriteRecord(ColumnsList: TColumnsEhList);
begin
  PutL('<TR>');
  inherited;
  PutL('</TR>');
end;

procedure TDBGridEhExportAsHTML.WriteDataCell(Column: TColumnEh; FColCellParamsEh: TColCellParamsEh);
begin
  Put('  <TD WIDTH=' + IntToStr(Column.Width) +
    ' ALIGN="' + GetAlignment(FColCellParamsEh.Alignment) + '"' +
    ' BGCOLOR=#' + GetColor(FColCellParamsEh.Background) +
    '>');
  PutText(FColCellParamsEh.Font, FColCellParamsEh.Text);
  PutL('</TD>');
end;

function TDBGridEhExportAsHTML.GetAlignment(Alignment: TAlignment): String;
begin
  case Alignment of
    taLeftJustify: Result := 'LEFT';
    taCenter: Result := 'CENTER';
    taRightJustify: Result := 'RIGHT';
  end;
end;

procedure TDBGridEhExportAsHTML.PutText(Font: TFont; Text: String);
var s: String;
begin
  s := '<FONT STYLE="font-family: ' + Font.Name;
  s := s + '; font-size: ' + IntToStr(GetFontSize(Font));
  s := s + 'pt; color: #' + GetColor(Font.Color) + '">';

  if (fsBold in Font.Style) then s := s + '<B>';
  if (fsItalic in Font.Style) then s := S + '<I>';
  if (fsUnderline in Font.Style) then s := s + '<U>';
  if (fsStrikeOut in Font.Style) then s := s + '<STRIKE>';

  Text := StringReplace(Text, '&', '&amp', [rfReplaceAll]);
  Text := StringReplace(Text, '<', '&lt', [rfReplaceAll]);
  Text := StringReplace(Text, '>', '&gt', [rfReplaceAll]);
  Text := StringReplace(Text, '"', '&quot', [rfReplaceAll]);

  if Text <> '' then
    s := s + Text
  else
    s := s + '&nbsp';

  if (fsBold in Font.Style) then s := s + '</B>';
  if (fsItalic in Font.Style) then s := S + '</I>';
  if (fsUnderline in Font.Style) then s := s + '</U>';
  if (fsStrikeOut in Font.Style) then s := s + '</STRIKE>';
  s := s + '</FONT>';

  Put(s);
end;

function TDBGridEhExportAsHTML.GetColor(Color: TColor): String;
var s: String;
begin
  if Color = clNone then
    s := '000000'
  else
    s := IntToHex(ColorToRGB(Color), 6);
  Result := Copy(s, 5, 2) + Copy(s, 3, 2) + Copy(s, 1, 2);
end;

procedure TDBGridEhExportAsHTML.WriteFooter(ColumnsList: TColumnsEhList;
  FooterNo: Integer);
begin
  PutL('<TR>');
  inherited;
  PutL('</TR>');
end;

procedure TDBGridEhExportAsHTML.WriteFooterCell(DataCol, Row: Integer;
  Column: TColumnEh; AFont: TFont; Background: TColor;
  Alignment: TAlignment; Text: String);
var Footer: TColumnFooterEh;
begin
  Footer := Column.UsedFooter(Row);
  Put('  <TD WIDTH=' + IntToStr(Column.Width) +
    ' ALIGN="' + GetAlignment(Footer.Alignment) + '"' +
    ' BGCOLOR=#' + GetColor(Background) +
    '>');
  PutText(AFont, Text);
  PutL('</TD>');
end;

{ TDBGridEhExportAsRTF }

procedure TDBGridEhExportAsRTF.ExportToStream(AStream: TStream; IsExportAll: Boolean);
var
  i: Integer;
begin
  FCacheStream := TMemoryStreamEh.Create;
  FCacheStream.HalfMemoryDelta := $10000;
  ColorTblList := TStringList.Create;
  FontTblList := TStringList.Create;
  try
    GetColorIndex(clBlack);
    GetColorIndex(clWhite);
    GetColorIndex(clBtnFace);

    inherited ExportToStream(FCacheStream, IsExportAll);

    Stream := AStream;

    PutL('{\rtf0\ansi');

    Put('{\colortbl');
    for i := 0 to ColorTblList.Count - 1 do
      Put('\red' + Trim(Copy(ColorTblList[i], 1, 3)) +
        '\green' + Trim(Copy(ColorTblList[i], 4, 3)) +
        '\blue' + Trim(Copy(ColorTblList[i], 7, 3)) + ';');
    PutL('}');

    Put('{\fonttbl');
    for i := 0 to FontTblList.Count - 1 do
      Put('\f' + IntToStr(i) + '\fnil ' + FontTblList[i] + ';');
    PutL('}');
    FCacheStream.SaveToStream(Stream);
  finally
    FCacheStream.Free;
    ColorTblList.Free;
    FontTblList.Free;
  end;
end;

procedure TDBGridEhExportAsRTF.Put(Text: String);
begin
  StreamWriteAnsiString(Stream, AnsiString(Text));
end;

procedure TDBGridEhExportAsRTF.PutL(Text: String);
begin
  Put(Text + #13#10);
end;

procedure TDBGridEhExportAsRTF.PutText(Font: TFont; Text: String; Background: TColor);
var
  s: String;
begin

  s := '\fs' + IntToStr(GetFontSize(Font) * 2);
  if (fsBold in Font.Style) then s := s + '\b';
  if (fsItalic in Font.Style) then s := s + '\i';
  if (fsStrikeOut in Font.Style) then s := s + '\strike';
  if (fsUnderline in Font.Style) then s := s + '\ul';
  s := s + '\f' + IntToStr(GetFontIndex(Font.Name));
  s := s + '\cf' + IntToStr(GetColorIndex(Font.Color));
  s := s + '\cb' + IntToStr(GetColorIndex(Background));
  Put(s + ' ');
  Text := StringToRtfString(Text);
  Put(Text);
end;

function TDBGridEhExportAsRTF.GetAlignment(Alignment: TAlignment): String;
begin
  case Alignment of
    taLeftJustify: Result := '\ql';
    taCenter: Result := '\qc';
    taRightJustify: Result := '\qr';
  end;
end;

function TDBGridEhExportAsRTF.GetFontIndex(FontName: String): Integer;
begin
  Result := FontTblList.IndexOf(FontName);
  if Result = -1 then
    Result := FontTblList.Add(FontName);
end;

function TDBGridEhExportAsRTF.GetColorIndex(Color: TColor): Integer;
var RGBColor: Longint;
  s: String;
begin
  RGBColor := ColorToRGB(Color);
  s := Format('%3d%3d%3d', [GetRValue(RGBColor), GetGValue(RGBColor), GetBValue(RGBColor)]);
  Result := ColorTblList.IndexOf(s);
  if Result = -1 then
    Result := ColorTblList.Add(s);
end;

procedure TDBGridEhExportAsRTF.WritePrefix;
begin
end;

procedure TDBGridEhExportAsRTF.WriteSuffix;
begin
  Put('}');
end;

procedure TDBGridEhExportAsRTF.WriteTitle(ColumnsList: TColumnsEhList);
var fLogPelsX: Integer;
  i, w, k: Integer;
  FPTitleExpArr: TTitleExpArr;
  ListOfHeadTreeNodeList: TList;
  ColSpan, RowSpan: Integer;
  Text: String;
  LeftBorder, TopBorder, BottomBorder, RightBorder: Boolean;
  ExclLeftBorders, ExclTopBorders, ExclBottomBorders, ExclRightBorders: TStringList;
  Space: String;

  procedure AddExclBorders(Col, Row, ColSpan, RowSpan: Integer);
  var i, k: Integer;
  begin
    for i := Col to Col + ColSpan - 1 do
      for k := Row downto Row - RowSpan + 1 do
      begin
        if i <> Col then
          ExclLeftBorders.Add(Format('%3d%3d', [i, k]));
        if i <> Col + ColSpan - 1 then
          ExclRightBorders.Add(Format('%3d%3d', [i, k]));
        if k <> Row then
          ExclTopBorders.Add(Format('%3d%3d', [i, k]));
        if k <> Row - RowSpan + 1 then
          ExclBottomBorders.Add(Format('%3d%3d', [i, k]));
      end;
  end;

  procedure CalcBorders(Col, Row: Integer);
  begin
    LeftBorder := True; TopBorder := True;
    BottomBorder := True; RightBorder := True;
    if ExclLeftBorders.IndexOf(Format('%3d%3d', [Col, Row])) <> -1 then
      LeftBorder := False;
    if ExclRightBorders.IndexOf(Format('%3d%3d', [Col, Row])) <> -1 then
      RightBorder := False;
    if ExclTopBorders.IndexOf(Format('%3d%3d', [Col, Row])) <> -1 then
      TopBorder := False;
    if ExclBottomBorders.IndexOf(Format('%3d%3d', [Col, Row])) <> -1 then
      BottomBorder := False;
  end;
begin
  fLogPelsX := GetDeviceCaps(DBGridEh.Canvas.Handle, LOGPIXELSX);

  if DBGridEh.UseMultiTitle then
  begin
    Space := IntToStr(Abs(Trunc(DBGridEh.VTitleMargin / 2 / fLogPelsX * 1440 - 20)));
    ExclLeftBorders := nil; ExclTopBorders := nil;
    ExclBottomBorders := nil; ExclRightBorders := nil;
    try
      CreateMultiTitleMatrix(DBGridEh, ColumnsList, FPTitleExpArr, ListOfHeadTreeNodeList);

      ExclLeftBorders := TStringList.Create;
      ExclTopBorders := TStringList.Create;
      ExclBottomBorders := TStringList.Create;
      ExclRightBorders := TStringList.Create;

      //MultiTitle
      for k := ListOfHeadTreeNodeList.Count - 1 downto 1 do
      begin
        Put('\trowd');
        PutL('\trgaph40');

        w := 0;
        for i := 0 to ColumnsList.Count - 1 do
        begin
          CalcSpan(ColumnsList, ListOfHeadTreeNodeList, k, i, ColSpan, RowSpan);
          AddExclBorders(i, k, ColSpan, RowSpan);
          CalcBorders(i, k);

          WriteCellBorder(LeftBorder, TopBorder, BottomBorder, RightBorder);
          Inc(w, Trunc(ColumnsList[i].Width / fLogPelsX * 1440)); // in twips
          Put('\clshdng10000\clcfpat' + IntToStr(GetColorIndex((DBGridEh.FixedColor))));
          PutL('\cellx' + IntToStr(w));
        end;

        PutL('{\trrh0');

        for i := 0 to ColumnsList.Count - 1 do
        begin
          if THeadTreeNode(TList(ListOfHeadTreeNodeList.Items[k]).Items[i]) <> nil then
          begin
            Text := THeadTreeNode(TList(ListOfHeadTreeNodeList.Items[k]).Items[i]).Text;
            Put('\pard\intbl{' + GetAlignment(taCenter) + '\sb' + Space + '\sa' + Space);
          end else
          begin
            Text := '';
            Put('\pard\intbl{' + GetAlignment(taCenter));
          end;

          PutText(DBGridEh.TitleFont, Text, DBGridEh.FixedColor);
          PutL('\cell}');
        end;
        PutL('\pard\intbl\row}');
      end;

      //Bottomest titles
      Put('\trowd');
      PutL('\trgaph40');

      w := 0;
      for i := 0 to ColumnsList.Count - 1 do
      begin
        CalcSpan(ColumnsList, ListOfHeadTreeNodeList, 0, i, ColSpan, RowSpan);
        AddExclBorders(i, 0, ColSpan, RowSpan);
        CalcBorders(i, 0);

        WriteCellBorder(LeftBorder, TopBorder, BottomBorder, RightBorder);

        Inc(w, Trunc(ColumnsList[i].Width / fLogPelsX * 1440)); // in twips
        Put('\clshdng10000\clcfpat' + IntToStr(GetColorIndex((ColumnsList[i].Title.Color))));
        PutL('\cellx' + IntToStr(w));
      end;

      PutL('{\trrh0');

      for i := 0 to ColumnsList.Count - 1 do
      begin
        if THeadTreeNode(TList(ListOfHeadTreeNodeList.Items[0]).Items[i]) <> nil then
        begin
          Text := THeadTreeNode(TList(ListOfHeadTreeNodeList.Items[0]).Items[i]).Text;
          Put('\pard\intbl{' + GetAlignment(taCenter) + '\sb' + Space + '\sa' + Space);
        end else
        begin
          Text := '';
          Put('\pard\intbl{' + GetAlignment(taCenter));
        end;
        CalcSpan(ColumnsList, ListOfHeadTreeNodeList, 0, i, ColSpan, RowSpan);

        PutText(ColumnsList[i].Title.Font, Text, ColumnsList[i].Title.Color);
        PutL('\cell}');

      end;
      PutL('\pard\intbl\row}');

    finally
      for i := 0 to ListOfHeadTreeNodeList.Count - 1 do
        TList(ListOfHeadTreeNodeList.Items[i]).Free;
      ListOfHeadTreeNodeList.Free;

      ExclLeftBorders.Free;
      ExclTopBorders.Free;
      ExclBottomBorders.Free;
      ExclRightBorders.Free;
    end;
  end else
  begin
    Put('\trowd');
    PutL('\trgaph40');

    w := 0;
    for i := 0 to ColumnsList.Count - 1 do
    begin
      WriteCellBorder(True, True, True, True);
      Inc(w, Trunc(ColumnsList[i].Width / fLogPelsX * 1440)); // in twips
      Put('\clshdng10000\clcfpat' + IntToStr(GetColorIndex((ColumnsList[i].Title.Color))));
      PutL('\cellx' + IntToStr(w));
    end;

    PutL('{\trrh0');

    for i := 0 to ColumnsList.Count - 1 do
    begin
      if DBGridEh.Flat then Space := '12' else Space := '24';
      Put('\pard\intbl{' + GetAlignment(ColumnsList[i].Title.Alignment) + '\sb' + Space + '\sa' + Space);
      PutText(ColumnsList[i].Title.Font, ColumnsList[i].Title.Caption, ColumnsList[i].Title.Color);
      PutL('\cell}');
    end;

    PutL('\pard\intbl\row}');
  end;
end;

procedure TDBGridEhExportAsRTF.WriteRecord(ColumnsList: TColumnsEhList);
var fLogPelsX: Integer;
  i, w: Integer;
begin
  Put('\trowd');
  PutL('\trgaph40');

  fLogPelsX := GetDeviceCaps(DBGridEh.Canvas.Handle, LOGPIXELSX);

  w := 0;
  for i := 0 to ColumnsList.Count - 1 do
  begin
    WriteCellBorder(True, True, True, True);
    Inc(w, Trunc(ColumnsList[i].Width / fLogPelsX * 1440)); // in twips
    Put('\clshdng10000\clcfpat' + IntToStr(GetColorIndex(GetDataCellColor(ColumnsList, i))));
    PutL('\cellx' + IntToStr(w));
  end;

  PutL('{\trrh0');

  inherited WriteRecord(ColumnsList);

  PutL('\pard\intbl\row}');
end;

function TDBGridEhExportAsRTF.StringToRtfString(s: String): String;
var
  i: Integer;
begin
  Result := '';
  for i := 1 to Length(S) do
  begin
    if Integer(s[i]) <= $7F then
      Result := Result + s[i]
    else
      Result := Result + '\u' + IntToStr(Integer(s[i])) + '?';
  end;
end;

procedure TDBGridEhExportAsRTF.WriteDataCell(Column: TColumnEh; FColCellParamsEh: TColCellParamsEh);
var
  Space: String;
  Text: String;
begin
  if DBGridEh.Flat then Space := '12' else Space := '24';
  Text := StringReplace(FColCellParamsEh.Text,'\','\\', [rfReplaceAll, rfIgnoreCase]);
  Put('\pard\intbl{' + GetAlignment(FColCellParamsEh.Alignment) + '\sb' + Space + '\sa' + Space);
  PutText(FColCellParamsEh.Font, Text, FColCellParamsEh.Background);
  PutL('\cell}');
end;

procedure TDBGridEhExportAsRTF.WriteCellBorder(LeftBorder, TopBorder, BottomBorder, RightBorder: Boolean);
begin
  if LeftBorder then
  begin
    Put('\clbrdrl');
    Put('\brdrs');
    PutL('\brdrcf0');
  end;

  if TopBorder then
  begin
    Put('\clbrdrt');
    Put('\brdrs');
    PutL('\brdrcf0');
  end;

  if BottomBorder then
  begin
    Put('\clbrdrb');
    Put('\brdrs');
    PutL('\brdrcf0');
  end;

  if RightBorder then
  begin
    Put('\clbrdrr');
    Put('\brdrs');
    PutL('\brdrcf0');
  end;
end;

procedure TDBGridEhExportAsRTF.WriteFooter(ColumnsList: TColumnsEhList;
  FooterNo: Integer);
var fLogPelsX: Integer;
  i, w: Integer;
begin
  Put('\trowd');
  PutL('\trgaph40');

  fLogPelsX := GetDeviceCaps(DBGridEh.Canvas.Handle, LOGPIXELSX);

  w := 0;
  for i := 0 to ColumnsList.Count - 1 do
  begin
    WriteCellBorder(True, True, True, True);
    Inc(w, Trunc(ColumnsList[i].Width / fLogPelsX * 1440)); // in twips
    Put('\clshdng10000\clcfpat' +
      IntToStr(GetColorIndex(GetFooterCellColor(ColumnsList, i, FooterNo))));
    PutL('\cellx' + IntToStr(w));
  end;

  PutL('{\trrh0'); // row auto-height

  inherited WriteFooter(ColumnsList, FooterNo);

  PutL('\pard\intbl\row}');
end;

procedure TDBGridEhExportAsRTF.WriteFooterCell(DataCol, Row: Integer;
  Column: TColumnEh; AFont: TFont; Background: TColor;
  Alignment: TAlignment; Text: String);
var
  Space: String;
begin
  if DBGridEh.Flat then Space := '12' else Space := '24';
  Put('\pard\intbl{' + GetAlignment(Alignment) + '\sb' + Space + '\sa' + Space);
  PutText(AFont, Text, Background);
  PutL('\cell}');
end;

function TDBGridEhExportAsRTF.GetDataCellColor(ColumnsList: TColumnsEhList;
  ColIndex: Integer): TColor;
var Font: TFont;
  State: TGridDrawState;
begin
  Font := TFont.Create;
  try
    Font.Assign(ColumnsList[ColIndex].Font);
    Result := ColumnsList[ColIndex].Color;
    State := [];
    if Assigned(DBGridEh.OnGetCellParams) then
      DBGridEh.OnGetCellParams(DBGridEh, ColumnsList[ColIndex], Font, Result, State);
  finally
    Font.Free;
  end;
end;

function TDBGridEhExportAsRTF.GetFooterCellColor(
  ColumnsList: TColumnsEhList; ColIndex: Integer; FooterNo: Integer): TColor;
var Font: TFont;
  State: TGridDrawState;
  Alignment: TAlignment;
  Value: String;
begin
  Font := TFont.Create;
  try
    Font.Assign(ColumnsList[ColIndex].UsedFooter(FooterNo).Font);
    Result := ColumnsList[ColIndex].UsedFooter(FooterNo).Color;
    Alignment := ColumnsList[ColIndex].UsedFooter(FooterNo).Alignment;
    if ColumnsList[ColIndex].UsedFooter(FooterNo).ValueType in [fvtSum, fvtCount] then
      Value := GetFooterValue(FooterNo, ColIndex)
    else
      Value := DBGridEh.GetFooterValue(FooterNo, ColumnsList[ColIndex]);
    State := [];
    if Assigned(DBGridEh.OnGetFooterParams) then
      DBGridEh.OnGetFooterParams(DBGridEh, ColumnsList[ColIndex].Index, FooterNo,
        ColumnsList[ColIndex], Font, Result, Alignment, State, Value);
  finally
    Font.Free;
  end;
end;

{ TDBGridEhExportAsXLS }

procedure StreamWriteWordArray(Stream: TStream; wr: array of Word);
var
  i: Integer;
begin
  for i := 0 to Length(wr)-1 do
{$IFDEF CIL}
    Stream.Write(wr[i]);
{$ELSE}
    Stream.Write(wr[i], SizeOf(wr[i]));
{$ENDIF}
end;

var
  CXlsBof: array[0..5] of Word = ($809, 8, 0, $10, 0, 0);
  CXlsEof: array[0..1] of Word = ($0A, 00);
  CXlsLabel: array[0..5] of Word = ($204, 0, 0, 0, 0, 0);
  CXlsNumber: array[0..4] of Word = ($203, 14, 0, 0, 0);
  CXlsRk: array[0..4] of Word = ($27E, 10, 0, 0, 0);
  CXlsBlank: array[0..4] of Word = ($201, 6, 0, 0, $17);


procedure TDBGridEhExportAsXLS.WriteBlankCell;
begin
  CXlsBlank[2] := FRow;
  CXlsBlank[3] := FCol;
  StreamWriteWordArray(Stream, CXlsBlank);
//  Stream.WriteBuffer(CXlsBlank, SizeOf(CXlsBlank));
  IncColRow;
end;

procedure TDBGridEhExportAsXLS.WriteFloatCell(const AValue: Double);
begin
  CXlsNumber[2] := FRow;
  CXlsNumber[3] := FCol;
  StreamWriteWordArray(Stream, CXlsNumber);
//  Stream.WriteBuffer(CXlsNumber, SizeOf(CXlsNumber));
  Stream.WriteBuffer(AValue, 8);
  IncColRow;
end;

procedure TDBGridEhExportAsXLS.WriteIntegerCell(const AValue: Integer);
var
  V: Integer;
begin
  CXlsRk[2] := FRow;
  CXlsRk[3] := FCol;
  StreamWriteWordArray(Stream, CXlsRk);
//  Stream.WriteBuffer(CXlsRk, SizeOf(CXlsRk));
  V := (AValue shl 2) or 2;
  Stream.WriteBuffer(V, 4);
  IncColRow;
end;

procedure TDBGridEhExportAsXLS.WriteStringCell(const AValue: string);
var
  L: Word;
  Val255: String;
begin
  Val255 := AValue;
  if Length(Val255) > 255 then
    Val255 := Copy(Val255, 1, 255);
  L := Length(AnsiString(Val255));
  CXlsLabel[1] := 8 + L;
  CXlsLabel[2] := FRow;
  CXlsLabel[3] := FCol;
  CXlsLabel[5] := L;
  StreamWriteWordArray(Stream, CXlsLabel);
//  Stream.WriteBuffer(CXlsLabel, SizeOf(CXlsLabel));
  StreamWriteAnsiString(Stream, AnsiString(Val255));
  IncColRow;
end;

procedure TDBGridEhExportAsXLS.WritePrefix;
begin
  StreamWriteWordArray(Stream, CXlsBof);
end;

procedure TDBGridEhExportAsXLS.WriteSuffix;
begin
  StreamWriteWordArray(Stream, CXlsEof);
end;

procedure TDBGridEhExportAsXLS.WriteTitle(ColumnsList: TColumnsEhList);
var i: Integer;
begin
  for i := 0 to ColumnsList.Count - 1 do
  begin
    WriteStringCell(ColumnsList[i].Title.Caption);
  end;
end;

procedure TDBGridEhExportAsXLS.WriteDataCell(Column: TColumnEh; FColCellParamsEh: TColCellParamsEh);
begin
  if Column.Field = nil then
    WriteBlankCell
  else if Column.GetBarType = ctKeyPickList then
    WriteStringCell(FColCellParamsEh.Text)
  else if Column.Field.IsNull then
    WriteBlankCell
  else
    with Column.Field do
      case DataType of
        ftSmallint, ftInteger, ftWord, ftAutoInc, ftBytes:
          WriteIntegerCell(AsInteger);
        ftFloat, ftCurrency, ftBCD{$IFDEF EH_LIB_6}, ftFMTBcd{$ENDIF}:
          WriteFloatCell(AsFloat);
      else
        WriteStringCell(FColCellParamsEh.Text);
      end;
end;

procedure TDBGridEhExportAsXLS.WriteFooterCell(DataCol, Row: Integer;
  Column: TColumnEh; AFont: TFont; Background: TColor;
  Alignment: TAlignment; Text: String);
begin
  if Column.UsedFooter(Row).ValueType in [fvtSum, fvtCount] then
    WriteFloatCell(FooterValues[Row * ExpCols.Count + DataCol])
  else
    WriteStringCell(Text);
end;

procedure TDBGridEhExportAsXLS.ExportToStream(AStream: TStream;
  IsExportAll: Boolean);
begin
  FCol := 0;
  FRow := 0;
  inherited ExportToStream(AStream, IsExportAll);
end;

procedure TDBGridEhExportAsXLS.IncColRow;
begin
  if FCol = ExpCols.Count - 1 then
  begin
    Inc(FRow);
    FCol := 0;
  end else
    Inc(FCol);
end;

{ TDBGridEhExportAsVCLDBIF }

{$IFDEF CIL}
procedure StreamWriteStruct(Stream: TStream; AStruct: TObject; ASize: Integer);
var
  b: TBytes;
  Mem: IntPtr;
begin
  Mem := Marshal.AllocHGlobal(Marshal.SizeOf(AStruct));
  try
    Marshal.StructureToPtr(AStruct, Mem, False);
    SetLength(b, Marshal.SizeOf(AStruct));
    Marshal.Copy(Mem, b, 0, Length(b));
    Stream.Write(b, Length(b));
  finally
    Marshal.FreeHGlobal(Mem);
  end;
end;
{$ELSE}
procedure StreamWriteStruct(Stream: TStream; var AStruct; ASize: Integer);
begin
  Stream.WriteBuffer(AStruct, ASize);
end;
{$ENDIF}

var
  VCLDBIF_BOF: TVCLDBIF_BOF = (Signatura: ('V', 'C', 'L', 'D', 'B', 'I', 'F'); Version: 1; ColCount: 0);

procedure WriteDataCellToVCLDBIFStreamAsWideString(Stream: TStream; AValue: WideString);
var
  StringValue: TVCLDBIF_WIDE_STRING;
begin
  StringValue.AType := TVCLDBIF_TYPE_WIDE_STRING;
  StringValue.Size := Length(AValue)*2;

  StreamWriteStruct(Stream, StringValue, SizeOf(StringValue));
  StreamWriteWideString(Stream, AValue);
end;

procedure WriteDataCellToVCLDBIFStreamAsAnsiString(Stream: TStream; AValue: AnsiString);
var
  StringValue: TVCLDBIF_ANSI_STRING;
begin
  StringValue.AType := TVCLDBIF_TYPE_ANSI_STRING;
  StringValue.Size := Length(AValue);

  StreamWriteStruct(Stream, StringValue, SizeOf(StringValue));
  StreamWriteAnsiString(Stream, AValue);
end;

procedure WriteDataCellToVCLDBIFStreamAsUnassigned(Stream: TStream);
var
  b: Byte;
begin
  b := TVCLDBIF_TYPE_UNASSIGNED;
  Stream.WriteBuffer(b, SizeOf(Byte));
end;

procedure WriteDataCellToVCLDBIFStreamAsNull(Stream: TStream);
var
  b: Byte;
begin
  b := TVCLDBIF_TYPE_NULL;
  Stream.WriteBuffer(b, SizeOf(Byte));
end;

procedure WriteDataCellToVCLDBIFStreamAsBinaryData(Stream: TStream; AValue: AnsiString);
var
  BinaryValue: TVCLDBIF_BINARY_DATA;
begin
  BinaryValue.AType := TVCLDBIF_TYPE_BINARY_DATA;
  BinaryValue.Size := Length(AValue);

  StreamWriteStruct(Stream, BinaryValue, SizeOf(BinaryValue));
  StreamWriteAnsiString(Stream, AValue);
end;

procedure WriteDataCellToVCLDBIFStreamAsFloat(Stream: TStream; AValue: Double);
var
  FloatValue: TVCLDBIF_FLOAT64;
begin
  FloatValue.AType := TVCLDBIF_TYPE_FLOAT64;
  FloatValue.Value := AValue;

  StreamWriteStruct(Stream, FloatValue, SizeOf(FloatValue));
end;

procedure WriteDataCellToVCLDBIFStreamAsInteger(Stream: TStream; AValue: Integer);
var
  IntValue: TVCLDBIF_INTEGER32;
begin
  IntValue.AType := TVCLDBIF_TYPE_INTEGER32;
  IntValue.Value := AValue;
  StreamWriteStruct(Stream, IntValue, SizeOf(IntValue));
end;

procedure WriteDataCellToStreamAsVCLDBIFData(Stream: TStream; Column: TAxisBarEh);
var
  Field: TField;
  FDataFields: TFieldsArrEh;
  StrList: TStringList;
  i: Integer;
begin
  FDataFields := nil;
  if Column.LookupParams.LookupActive then
  begin
    FDataFields := GetFieldsProperty(Column.Grid.DataSource.DataSet, nil, Column.LookupParams.KeyFieldNames);
    StrList := TStringList.Create;
    try
      for i := 0 to Length(FDataFields)-1 do
        StrList.Add(FDataFields[i].AsString);
      WriteDataCellToVCLDBIFStreamAsWideString(Stream, WideString(StrList.CommaText));
    finally
      FreeAndNil(StrList);
    end;
  end else
  begin
    Field := Column.Field;
    if Field = nil then
      WriteDataCellToVCLDBIFStreamAsUnassigned(Stream)
    else if Field.IsNull then
      WriteDataCellToVCLDBIFStreamAsNull(Stream)
    else
      with Field do
        case DataType of
          ftSmallint, ftInteger, ftWord, ftAutoInc
{$IFDEF EH_LIB_12}, ftShortint, ftByte {$ENDIF}
            :WriteDataCellToVCLDBIFStreamAsInteger(Stream, AsInteger);

          ftFloat, ftCurrency, ftBCD, ftDate, ftTime, ftDateTime
{$IFDEF EH_LIB_6}, ftTimeStamp, ftFMTBcd{$ENDIF}
            :WriteDataCellToVCLDBIFStreamAsFloat(Stream, AsFloat);

          ftString, ftBoolean, ftFixedChar, ftMemo, ftLargeint
{$IFDEF EH_LIB_5}, ftGuid, ftOraClob{$ENDIF}
{$IFDEF EH_LIB_10}, ftOraTimeStamp, ftOraInterval {$ENDIF}
{$IFDEF EH_LIB_12}, ftLongWord , ftExtended {$ENDIF}
{$IFDEF EH_LIB_12}
            :WriteDataCellToVCLDBIFStreamAsAnsiString(Stream, AsAnsiString);
{$ELSE}
            :WriteDataCellToVCLDBIFStreamAsAnsiString(Stream, AsString);
{$ENDIF}

          ftBlob, ftGraphic, ftFmtMemo, ftParadoxOle, ftDBaseOle,
{$IFDEF EH_LIB_5}ftOraBlob, {$ENDIF}
          ftBytes, ftTypedBinary, ftVarBytes
{$IFDEF EH_LIB_12}
            :WriteDataCellToVCLDBIFStreamAsBinaryData(Stream, AsAnsiString);
{$ELSE}
            :WriteDataCellToVCLDBIFStreamAsBinaryData(Stream, AsString);
{$ENDIF}
          ftWideString
{$IFDEF EH_LIB_10}, ftFixedWideChar , ftWideMemo {$ENDIF}
{$IFDEF EH_LIB_12}
            :WriteDataCellToVCLDBIFStreamAsWideString(Stream, AsWideString);
{$ELSE}
            :WriteDataCellToVCLDBIFStreamAsWideString(Stream, TWideStringField(Field).Value);
{$ENDIF}
        else
          WriteDataCellToVCLDBIFStreamAsUnassigned(Stream);
        end;
  end;
end;

procedure WriteVCLDBIFStreamPrefix(Stream: TStream; BarList: TAxisBarsEhList);
var
  i: Integer;
  b: Byte;
begin
  VCLDBIF_BOF.ColCount := BarList.Count; //CalcColCount;
  StreamWriteStruct(Stream, VCLDBIF_BOF, SizeOf(VCLDBIF_BOF));
  for i := 0 to BarList.Count - 1 do
  begin
    if BarList[i].Visible then b := 1 else b := 0;
    Stream.WriteBuffer(b, SizeOf(Byte));
    SreamWriteNullAnsiStr(Stream);
  end;
end;

procedure WriteVCLDBIFStreamSuffix(Stream: TStream);
var
  b: Byte;
begin
  b := TVCLDBIF_TYPE_EOF;
  Stream.WriteBuffer(b, SizeOf(Byte));
end;

procedure TDBGridEhExportAsVCLDBIF.WritePrefix;
begin
  WriteVCLDBIFStreamPrefix(Stream, ExpCols);
end;

procedure TDBGridEhExportAsVCLDBIF.WriteSuffix;
begin
  WriteVCLDBIFStreamSuffix(Stream);
end;

procedure TDBGridEhExportAsVCLDBIF.WriteDataCell(Column: TColumnEh; FColCellParamsEh: TColCellParamsEh);
begin
  WriteDataCellToStreamAsVCLDBIFData(Stream, Column);
end;

{function TDBGridEhExportAsVCLDBIF.CalcColCount: Word;
var i:Integer;
begin
  Result := 0;
  with DBGridEh do
  begin
    if Selection.SelectionType = gstNon then Exit;
    case Selection.SelectionType of
      gstRecordBookmarks:
        Result := VisibleColumns.Count;
      gstRectangle:
        for i := Selection.Rect.LeftCol to Selection.Rect.RightCol do
          if Columns[i].Visible then
            Inc(Result);
      gstColumns:
        Result := Selection.Columns.Count;
      gstAll:
        Result := VisibleColumns.Count;
    end;
  end;
end;}

function StreamReadAnsiString(Stream: TStream; var S: AnsiString; Count: Longint): Longint;
{$IFDEF CIL}
var
  b: TBytes;
{$ENDIF}
begin
{$IFDEF CIL}
    Result := Stream.Read(b, Count);
    S := StringOf(b);
{$ELSE}
    SetString(S, nil, Count);
    if Count = 0 then
    begin
      Result := 0;
      S := '';
    end else
      Result := Stream.Read(S[1], Count);
{$ENDIF}
end;

function StreamReadWideString(Stream: TStream; var S: WideString; Size: Longint): Longint;
{$IFDEF CIL}
var
  b: TBytes;
{$ENDIF}
begin
{$IFDEF CIL}
    Result := Stream.Read(b, Size);
    S := StringOf(b);
{$ELSE}
    SetString(S, nil, Size div 2);
    if Size = 0 then
    begin
      Result := 0;
      S := '';
    end else
      Result := Stream.Read(S[1], Size);
{$ENDIF}
end;

{$IFDEF CIL}
function StreamReadStruct(Stream: TStream; AStruct: TObject; ASize: Integer): Longint;
var
  b: TBytes;
  Mem: IntPtr;
begin
  Mem := Marshal.AllocHGlobal(Marshal.SizeOf(AStruct));
  try
    Result := Stream.Read(b, Marshal.SizeOf(AStruct));
{ TODO : To do finish }
    Marshal.StructureToPtr(AStruct, Mem, False);
    SetLength(b, Marshal.SizeOf(AStruct));
    Marshal.Copy(Mem, b, 0, Length(b));
  finally
    Marshal.FreeHGlobal(Mem);
  end;
end;

{$ELSE}

function StreamReadStruct(Stream: TStream; var AStruct; ASize: Integer): Longint;
begin
  Result := Stream.Read(AStruct, ASize);
end;

{$ENDIF}

{ TDBGridEhImport }

constructor TDBGridEhImport.Create;
begin
  inherited Create;
end;

procedure TDBGridEhImport.ImportFromFile(FileName: String; IsImportAll: Boolean);
var FileStream: TFileStream;
begin
  FileStream := TFileStream.Create(FileName, fmOpenRead);
  try
    ImportFromStream(FileStream, IsImportAll);
  finally
    FileStream.Free;
  end;
end;

procedure TDBGridEhImport.ImportFromStream(AStream: TStream; IsImportAll: Boolean);
var i: Integer;
  ColList: TColumnsEhList;
  Inserting: Boolean;
  Appending: Boolean;
  procedure DoInserting;
  begin
    with DBGridEh.DataSource.Dataset do
      while not Eos do
      begin
        if Appending then Append else Insert;
        ReadRecord(ImpCols);
        Post;
        if not Appending then Next;
      end
  end;
begin
  Stream := AStream;
  Eos := False;
  with DBGridEh do
  begin
    if IsImportAll then
    begin
      Selection.Clear;
      DataSource.Dataset.First;
      if VisibleColumns.Count > 0 then
        SelectedIndex := VisibleColumns.Items[0].Index;
    end;
    with DataSource.Dataset do
    begin
      if Eof then Appending := True else Appending := False;
      if State = dsInsert then Inserting := True else Inserting := False;
      if not Inserting then SaveBookmark;
      DisableControls;
      try
        case Selection.SelectionType of
          gstRecordBookmarks:
            begin
              ImpCols := VisibleColumns;
              ReadPrefix;
              if Inserting then
                DoInserting
              else
                for i := 0 to Selection.Rows.Count - 1 do
                begin
                  Bookmark := Selection.Rows[I];
                  ReadRecord(VisibleColumns);
                end;
            end;
          gstRectangle:
            begin
              ColList := TColumnsEhList.Create;
              try
                for i := Selection.Rect.LeftCol to Selection.Rect.RightCol do
                  if Columns[i].Visible then
                    ColList.Add(Columns[i]);
                ImpCols := ColList;
                ReadPrefix;
                if Inserting then
                  DoInserting
                else
                begin
                  Bookmark := Selection.Rect.TopRow;
                  while True do
                  begin
                    ReadRecord(ColList);
                    if DataSetCompareBookmarks(DBGridEh.DataSource.Dataset, Selection.Rect.BottomRow, Bookmark) = 0 then Break;
                    Next;
                    if Eof then Break;
                  end;
                end;
              finally
                ColList.Free;
              end;
            end;
          gstColumns:
            begin
              ImpCols := Selection.Columns;
              ReadPrefix;
              if Inserting then
                DoInserting
              else
              begin
                First;
                while Eof = False do
                begin
                  ReadRecord(Selection.Columns);
                  Next;
                end;
              end;
            end;
          gstAll:
            begin
              ImpCols := VisibleColumns;
              ReadPrefix;
              if Inserting then
                DoInserting
              else
              begin
                First;
                while Eof = False do
                begin
                  ReadRecord(VisibleColumns);
                  Next;
                end;
              end;
            end;
          gstNon:
            begin
              ColList := TColumnsEhList.Create;
              try
                for i := SelectedIndex to Columns.Count - 1 do
                  if Columns[i].Visible then ColList.Add(Columns[i]);
                ImpCols := ColList;
                ReadPrefix;
                if Inserting then
                  DoInserting
                else
                begin
                  RestoreBookmark;
                  while True do
                  begin
                    ReadRecord(ColList);
                    Next;
                    if Eof or Eos then Break;
                  end;
                  if alopAppendEh in DBGridEh.AllowedOperations then
                  begin
                    Inserting := True;
                    Appending := True;
                    DoInserting;
                  end;
                end;
              finally
                ColList.Free;
              end;
            end;
        end;
      finally
        if not Inserting then RestoreBookmark;
        EnableControls;
      end;
    end;
  end;
  ReadSuffix;
end;

procedure TDBGridEhImport.ReadPrefix;
begin
end;

procedure TDBGridEhImport.ReadRecord(ColumnsList: TColumnsEhList);
var i: Integer;
begin
  for i := 0 to ColumnsList.Count - 1 do
    ReadDataCell(ColumnsList[i]);
end;

procedure TDBGridEhImport.ReadDataCell(Column: TColumnEh);
begin
end;

procedure TDBGridEhImport.ReadSuffix;
begin
end;

{ TDBGridEhImportAsText }

function TDBGridEhImportAsText.CheckState: TImportTextSreamState;
begin
  if GetChar(FLastChar) then
  begin
    if FLastChar = #09 then
      if (FLastState in [itssNewLine,itssTab]) then
      begin
        FLastChar := #00;
        Result := itssChar;
        if Stream.Position >= SizeOf(AnsiChar) then
          Stream.Position := Stream.Position - SizeOf(AnsiChar);
      end else
        Result := itssTab
    else if FLastChar = #13 then
    begin
      if GetChar(FLastChar) and (FLastChar = #10) then
        if (FLastState in [itssNewLine,itssTab]) then
        begin
          FLastChar := #00;
          Result := itssChar;
          if Stream.Position >= SizeOf(AnsiChar)*2 then
            Stream.Position := Stream.Position - SizeOf(AnsiChar) * 2;
        end else
          Result := itssNewLine
      else
        raise Exception.Create('TDBGridEhImportAsText.CheckState: ' + SInvalidTextFormatEh);
    end else if FLastChar = #00 then
    begin
      Result := itssEof;
      Eos := True;
    end else
      Result := itssChar;
  end else
  begin
    Result := itssEof;
    Eos := True;
  end;
  FLastState := Result;
end;

function TDBGridEhImportAsText.GetChar(var ch: AnsiChar): Boolean;
var
  Count: Longint;
begin
  Result := False;
  if Stream.Position = Stream.Size-1 then Exit;
  Count := Stream.Read(ch, SizeOf(AnsiChar));
  if Count = SizeOf(AnsiChar) then Result := True;
end;

function TDBGridEhImportAsText.GetString(var Value: AnsiString): TImportTextSreamState;
begin
  Value := '';
  if FLastState = itssChar then
    Value := FLastChar;
  repeat
    Result := CheckState;
    if not (Result = itssChar) then Break;
    Value := Value + FLastChar;
  until False = True;
end;

procedure TDBGridEhImportAsText.ImportFromStream(AStream: TStream;
  IsImportAll: Boolean);
begin
  FIgnoreAll := False;
  inherited ImportFromStream(AStream, IsImportAll);
end;

procedure TDBGridEhImportAsText.ReadPrefix;
begin
  FLastState := itssNewLine;
  CheckState;
end;

procedure TDBGridEhImportAsText.ReadDataCell(Column: TColumnEh);
var
  ModalResult: Word;
  Field: TField;
  idx: Integer;
begin
  if Column.CanModify(False) then
  begin
    if Column.Field.FieldKind = fkLookUp then
    begin
      if Column.Field.KeyFields <> ''
      then Field := Column.Field
      else Exit;
    end else
      Field := Column.Field;
    if Field.DataSet.CanModify then
    begin
      Field.DataSet.Edit;
      if Field.DataSet.State in [dsEdit, dsInsert] then
      try
        if Column.Field.FieldKind = fkLookUp then
        begin
          if Column.Field.LookupDataSet.Locate(Column.Field.LookupResultField,
            FLastString, [loCaseInsensitive, loPartialKey])
          then
            Column.SetValueAsVariant(
              Column.Field.LookupDataSet[Column.Field.LookupKeyFields]);
        end
        else if Column.GetBarType = ctKeyPickList then
        begin
          idx := Column.PickList.IndexOf(String(FLastString));
          if (idx <> -1) then
            Column.SetValueAsText(Column.KeyList.Strings[idx])
          else
            Column.SetValueAsText('');
        end else
          Column.SetValueAsText(
            Column.GetAcceptableEditText(String(FLastString)));
      except
        on E: Exception do
        begin
          if not FIgnoreAll then
          begin
            ModalResult := MessageDlg(SErrorDuringInsertValueEh + #10 +
              E.Message + #10 + #10 + SIgnoreErrorEh, mtError, [mbYes, mbNo, mbAll], 0);
            case ModalResult of
              mrNo: Abort;
              mrAll: FIgnoreAll := True;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TDBGridEhImportAsText.ReadRecord(ColumnsList: TColumnsEhList);
var
  i: Integer;
begin
  if FLastState = itssEof then Exit;
  i := 0;
  if FLastState = itssChar then
  begin
    GetString(FLastString);
    if i < ColumnsList.Count then ReadDataCell(ColumnsList[i]);
    Inc(i);
  end;
  while not (FLastState in [itssNewLine, itssEof]) do
  begin
    GetString(FLastString);
    if i < ColumnsList.Count then ReadDataCell(ColumnsList[i]);
    Inc(i);
  end;
  CheckState;
end;

{ TDBGridEhImportAsUnicodeText }

function TDBGridEhImportAsUnicodeText.CheckState: TImportTextSreamState;
begin
  if GetChar(FLastChar) then
  begin
    if FLastChar = #09 then
      if (FLastState in [itssNewLine,itssTab]) then
      begin
        FLastChar := #00;
        Result := itssChar;
        if Stream.Position >= SizeOf(WideChar) then
          Stream.Position := Stream.Position - SizeOf(WideChar);
      end else
        Result := itssTab
    else if FLastChar = #13 then
    begin
      if GetChar(FLastChar) and (FLastChar = #10) then
        if (FLastState in [itssNewLine,itssTab]) then
        begin
          FLastChar := #00;
          Result := itssChar;
          if Stream.Position >= SizeOf(WideChar)*2 then
            Stream.Position := Stream.Position - SizeOf(WideChar) * 2;
        end else
          Result := itssNewLine
      else
        raise Exception.Create('TDBGridEhImportAsUnicodeText.CheckState: ' + SInvalidTextFormatEh);
    end else if FLastChar = #00 then
    begin
      Result := itssEof;
      Eos := True;
    end else
      Result := itssChar;
  end else
  begin
    Result := itssEof;
    Eos := True;
  end;
  FLastState := Result;
end;

function TDBGridEhImportAsUnicodeText.GetChar(var ch: WideChar): Boolean;
var
  Count: Longint;
begin
  Result := False;
  if Stream.Position = Stream.Size-1 then Exit;
  Count := Stream.Read(ch, SizeOf(WideChar));
  if Count = SizeOf(WideChar) then Result := True;
end;

function TDBGridEhImportAsUnicodeText.GetString(var Value: WideString): TImportTextSreamState;
begin
  Value := '';
  if FLastState = itssChar then
    Value := FLastChar;
  repeat
    Result := CheckState;
    if not (Result = itssChar) then Break;
    Value := Value + FLastChar;
  until False = True;
end;

procedure TDBGridEhImportAsUnicodeText.ImportFromStream(AStream: TStream;
  IsImportAll: Boolean);
begin
  FIgnoreAll := False;
  inherited ImportFromStream(AStream, IsImportAll);
end;

procedure TDBGridEhImportAsUnicodeText.ReadPrefix;
begin
  FLastState := itssNewLine;
  CheckState;
end;

procedure TDBGridEhImportAsUnicodeText.ReadDataCell(Column: TColumnEh);
var
  ModalResult: Word;
  Field: TField;
  idx: Integer;
begin
  if Column.CanModify(False) then
  begin
    if Column.Field.FieldKind = fkLookUp then
    begin
      if Column.Field.KeyFields <> '' then
        Field := Column.Field
      else
        Exit;
    end else
      Field := Column.Field;
    if Field.DataSet.CanModify then
    begin
      Field.DataSet.Edit;
      if Field.DataSet.State in [dsEdit, dsInsert] then
      try
        if Column.Field.FieldKind = fkLookUp then
        begin
          if Column.Field.LookupDataSet.Locate(Column.Field.LookupResultField,
            FLastString, [loCaseInsensitive, loPartialKey])
          then
            Column.SetValueAsVariant(
              Column.Field.LookupDataSet[Column.Field.LookupKeyFields])
        end
        else if Column.GetBarType = ctKeyPickList then
        begin
          idx := Column.PickList.IndexOf(String(FLastString));
          if (idx <> -1) then
            Column.SetValueAsText(Column.KeyList.Strings[idx])
          else
            Column.SetValueAsText('');
        end else
          Column.SetValueAsText(
            Column.GetAcceptableEditText(String(FLastString)));
      except
        on E: Exception do
        begin
          if not FIgnoreAll then
          begin
            ModalResult := MessageDlg(SErrorDuringInsertValueEh + #10 +
              E.Message + #10 + #10 + SIgnoreErrorEh, mtError, [mbYes, mbNo, mbAll], 0);
            case ModalResult of
              mrNo: Abort;
              mrAll: FIgnoreAll := True;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TDBGridEhImportAsUnicodeText.ReadRecord(ColumnsList: TColumnsEhList);
var
  i: Integer;
begin
  if FLastState = itssEof then Exit;
  i := 0;
  if FLastState = itssChar then
  begin
    GetString(FLastString);
    if i < ColumnsList.Count then ReadDataCell(ColumnsList[i]);
    Inc(i);
  end;
  while not (FLastState in [itssNewLine, itssEof]) do
  begin
    GetString(FLastString);
    if i < ColumnsList.Count then ReadDataCell(ColumnsList[i]);
    Inc(i);
  end;
  CheckState;
end;

{ TDBGridEhImportAsVCLDBIF }

procedure ReadVCLDBIFStreamPrefix(Stream: TStream; var Prefix: TVCLDBIF_BOF; FieldList: TStringList);
var
  Count: Longint;
  i: Integer;
  b: Byte;
  ch: AnsiChar;
  FieldName: String;
begin
//  Count := Stream.Read(Prefix, SizeOf(TVCLDBIF_BOF));
  Count := StreamReadStruct(Stream, Prefix, SizeOf(TVCLDBIF_BOF));
  if Count < SizeOf(TVCLDBIF_BOF) then
    raise Exception.Create('TDBGridEhImportAsVCLDBIF.ReadPrefix: ' + SInvalidVCLDBIFFormatEh);
  if Prefix.Signatura <> 'VCLDBIF' then
    raise Exception.Create('TDBGridEhImportAsVCLDBIF.ReadPrefix: ' + SInvalidVCLDBIFFormatEh);
  for i := 0 to Prefix.ColCount - 1 do
  begin
    Count := Stream.Read(b, SizeOf(Byte));
    if Count < SizeOf(Byte) then
      raise Exception.Create('TDBGridEhImportAsVCLDBIF.ReadPrefix: ' + SInvalidVCLDBIFFormatEh);
    FieldName := '';
    while True do
    begin
      Count := Stream.Read(ch, SizeOf(AnsiChar));
      if Count < SizeOf(Byte) then
        raise Exception.Create('TDBGridEhImportAsVCLDBIF.ReadPrefix: ' + SInvalidVCLDBIFFormatEh);
      if ch <> #0
        then FieldName := FieldName + String(ch)
        else Break;
    end;
//    if FieldName <> '' then UseFieldNames := True;
    FieldList.AddObject(FieldName, TObject(b));
  end;
end;

function ReadValueFromVCLDBIFStream(Stream: TStream; var Value: Variant): Boolean;
var
  AType: Byte;
  Count: Longint;
  LongintValue: Longint;
  DoubleValue: Double;
  StringSize: Longint;
  AnsiStringValue: AnsiString;
  WideStringValue: WideString;
begin
//  if Eos then Exit;
  Result := True;
  Count := Stream.Read(AType, SizeOf(Byte));
  if Count < SizeOf(Byte) then
    raise Exception.Create('TDBGridEhImportAsVCLDBIF.ReadPrefix: ' + SInvalidVCLDBIFFormatEh);
  Value := Unassigned;
  case AType of
    TVCLDBIF_TYPE_EOF:
      Result := False;
    TVCLDBIF_TYPE_NULL:
      Value := Null;
    TVCLDBIF_TYPE_INTEGER32:
      begin
        Count := Stream.Read(LongintValue, SizeOf(Longint));
        if Count < SizeOf(Longint) then
          raise Exception.Create('TDBGridEhImportAsVCLDBIF.ReadPrefix: ' + SInvalidVCLDBIFFormatEh);
        Value := LongintValue;
      end;
    TVCLDBIF_TYPE_FLOAT64:
      begin
        Count := Stream.Read(DoubleValue, SizeOf(Double));
        if Count < SizeOf(Double) then
          raise Exception.Create('TDBGridEhImportAsVCLDBIF.ReadPrefix: ' + SInvalidVCLDBIFFormatEh);
        Value := DoubleValue;
      end;
    TVCLDBIF_TYPE_ANSI_STRING, TVCLDBIF_TYPE_BINARY_DATA:
      begin
        Count := Stream.Read(StringSize, SizeOf(Longint));
        if Count < SizeOf(Longint) then
          raise Exception.Create('TDBGridEhImportAsVCLDBIF.ReadPrefix: ' + SInvalidVCLDBIFFormatEh);
        Count := StreamReadAnsiString(Stream, AnsiStringValue, StringSize);
        if Count < StringSize then
          raise Exception.Create('TDBGridEhImportAsVCLDBIF.ReadPrefix: ' + SInvalidVCLDBIFFormatEh);
        Value := AnsiStringValue;
      end;
    TVCLDBIF_TYPE_WIDE_STRING:
      begin
        Count := Stream.Read(StringSize, SizeOf(Longint));
        if Count < SizeOf(Longint) then
          raise Exception.Create('TDBGridEhImportAsVCLDBIF.ReadPrefix: ' + SInvalidVCLDBIFFormatEh);
        Count := StreamReadWideString(Stream, WideStringValue, StringSize);
        if Count < StringSize then
          raise Exception.Create('TDBGridEhImportAsVCLDBIF.ReadPrefix: ' + SInvalidVCLDBIFFormatEh);
        Value := WideStringValue;
      end;
  else
    raise Exception.Create('ReadValueFromVCLDBIFStream: Unixpected value type: ' + IntToStr(AType));
  end;
end;

procedure AssignAsixBarValueFromVCLDBIFStream(var Value: Variant; AxisBar: TAxisBarEh; var IgnoreAssignError: Boolean);
var
  ModalResult: Word;
  Field: TField;
  FDataFields: TFieldsArrEh;
  StrList: TStringList;
  i: Integer;

  procedure SetValue(SetAsString: Boolean);
  begin
    if Field.DataSet.CanModify then
    begin
      Field.DataSet.Edit;
      if Field.DataSet.State in [dsEdit, dsInsert] then
      try
        if SetAsString then
          AxisBar.SetValueAsText(VarToStr(Value))
        else if (Field is TNumericField) and (VarToStr(Value) = '') then
          AxisBar.SetValueAsVariant(Null)
        else
          AxisBar.SetValueAsVariant(Value);
      except
        on E: Exception do
        begin
          if not IgnoreAssignError then
          begin
            ModalResult := MessageDlg(SErrorDuringInsertValueEh + #10 + E.Message + #10 + #10 +
              SIgnoreErrorEh, mtError, [mbYes, mbNo, mbAll], 0);
            case ModalResult of
              mrNo: Abort;
              mrAll: IgnoreAssignError := True;
            end;
          end;
        end;
      end;
    end;
  end;

begin
  FDataFields := nil;
  if not VarIsEmpty(Value) and Assigned(AxisBar) then
  begin
    if AxisBar.CanModify(False) then
    begin
      if AxisBar.LookupParams.LookupActive then
      begin
        FDataFields := GetFieldsProperty(
          AxisBar.Grid.DataSource.DataSet, nil, AxisBar.LookupParams.KeyFieldNames);
        StrList := TStringList.Create;
        try
          StrList.CommaText := String(Value);
          for i := 0 to Length(FDataFields)-1 do
          begin
            Field := FDataFields[i];
            Value := StrList[i];
            SetValue(False);
          end;
        finally
          FreeAndNil(StrList);
        end;
      end else
      begin
        Field := AxisBar.Field;
        SetValue(False);
      end;
    end;
  end;
//  ReadValue;
end;

procedure TDBGridEhImportAsVCLDBIF.ReadPrefix;
var
  i: Integer;
begin
  ReadVCLDBIFStreamPrefix(Stream, Prefix, FieldNames);

  for i := 0 to FieldNames.Count-1 do
    if FieldNames[i] <> '' then
      UseFieldNames := True;

  ReadValue;
end;

procedure TDBGridEhImportAsVCLDBIF.ReadDataCell(Column: TColumnEh);
begin
  AssignAsixBarValueFromVCLDBIFStream(LastValue, Column, FIgnoreAll);
  ReadValue;
end;

procedure TDBGridEhImportAsVCLDBIF.ReadRecord(ColumnsList: TColumnsEhList);
var
  i: Integer;
begin
  for i := 0 to Prefix.ColCount - 1 do
  begin
    if i < ColumnsList.Count
      then ReadDataCell(ColumnsList[i])
      else ReadDataCell(nil);
  end;
end;

procedure TDBGridEhImportAsVCLDBIF.ImportFromStream(AStream: TStream;
  IsImportAll: Boolean);
begin
  FIgnoreAll := False;
  UseFieldNames := False;
  FieldNames := TStringList.Create;
  try
    inherited ImportFromStream(AStream, IsImportAll);
  finally
    FieldNames.Free;
  end;
end;

procedure TDBGridEhImportAsVCLDBIF.ReadValue;
begin
  if Eos then Exit;

  if not ReadValueFromVCLDBIFStream(Stream, LastValue) then
    Eos := True;
end;

{ TDBGridEhExportAsOLEXLS }

{$IFDEF CIL}
{$ELSE}

var
  XLSAlignment: array[TAlignment] of Integer = (2, 4, 3);

procedure TDBGridEhExportAsOLEXLS.ExportToStream(AStream: TStream; IsExportAll: Boolean);
begin
  FIsExportAll := IsExportAll;
  ExportToExcel(IsExportAll, []);
end;

procedure TDBGridEhExportAsOLEXLS.ExportToFile(FileName: String; IsExportAll: Boolean);
begin
  FIsExportAll := IsExportAll;
  ExportToExcel(IsExportAll, []);
  FExcelApp.DefaultFilePath := GetCurrentDir;
  FExcelApp.ActiveWorkbook.SaveAs(FileName);
end;

procedure TDBGridEhExportAsOLEXLS.CalcFooterValues;
begin
  if FDataRowCountMode then Exit;
  inherited CalcFooterValues;
end;

function TDBGridEhExportAsOLEXLS.ExportToExcel(IsExportAll: Boolean; Options: TDBGridEhExportAsOLEXLSOptions): Variant;
begin
  FOptions := Options;
  FIsExportAll := IsExportAll;
  inherited ExportToStream(nil, IsExportAll);
  Result := FExcelApp;
end;

procedure TDBGridEhExportAsOLEXLS.WriteRecord(ColumnsList: TColumnsEhList);
begin
  if FDataRowCountMode then
  begin
    Inc(FDataRowCount);
  end else
  begin
    FCurCol := 1;
    inherited WriteRecord(ColumnsList);
    Inc(FCurRow);
  end;
end;

procedure TDBGridEhExportAsOLEXLS.WriteDataCell(Column: TColumnEh;
  FColCellParamsEh: TColCellParamsEh);
var
  OleVarValue: OleVariant;
begin
  if Column.Checkboxes then
    if FColCellParamsEh.CheckboxState = cbChecked
      then FVarValues[FCurRow-1-FTitleRows, FCurCol-1] := 'X'
      else FVarValues[FCurRow-1-FTitleRows, FCurCol-1] := ''
  else if (Column.Field <> nil) and Column.Field.Lookup then
    FVarValues[FCurRow-1-FTitleRows, FCurCol-1] := Column.Field.AsString
  else if (Column.Field <> nil) then
  begin
    if oxlsDataAsEditText in FOptions then
      OleVarValue := Column.Field.Text
    else if oxlsDataAsDisplayText in FOptions then
      OleVarValue := FColCellParamsEh.Text
    else if (Column.Field.DataType in [ftDate, ftDateTime]) and // check for minimum date
            (not Column.Field.IsNull) and                       // if date < 01-01-1900 then write as text
            (Column.Field.AsDateTime < EncodeDate(1900, 1, 1)) then
       OleVarValue := FColCellParamsEh.Text
    else
      OleVarValue := Column.Field.Value;

{    AType := VarType(OleVarValue);
    AType1 := VarType(Column.Field.Value);
    if VarType(Column.Field.Value) = VarSQLTimeStamp then
    begin
      OleVarValue := Column.Field.AsDateTime;
      TimeStamp := DateTimeToSQLTimeStamp(Column.Field.AsDateTime);
      TimeStamp1 := DateTimeToSQLTimeStamp(OleVarValue);
    end;}
    FVarValues[FCurRow-1-FTitleRows, FCurCol-1] := OleVarValue;
  end else
    FVarValues[FCurRow-1-FTitleRows, FCurCol-1] := FColCellParamsEh.Text;

  if (oxlsColoredEh in FOptions) and
     (FColCellParamsEh.Background <> TDBGridEh(DBGridEh).Color) then
  begin
    FActiveSheet.Cells.Item[FCurRow, FCurCol].Interior.Color := ColorToRGB(FColCellParamsEh.Background);
  end;

  Inc(FCurCol);
end;

procedure TDBGridEhExportAsOLEXLS.WriteSuffix;
var
  TopLeft: String;
  BottomRight: Variant;
  i: Integer;
  ARange: Variant;
begin
  if FDataRowCountMode then Exit;

  if (FCurCol = 0) and (FDataRowCount = 0) then
    Exit;

  for i := 0 to ExpCols.Count - 1 do
  begin
{    S := FActiveSheet.Range['A1', 'A1'].NumberFormat;
    S := FActiveSheet.Range['A1', 'A1'].NumberFormatLocal;
    S := FExcelApp.International[$0000001A];
    FActiveSheet.Range['A1', 'A1'].NumberFormat := 'Основной';}

    ARange := FActiveSheet.Range[FActiveSheet.Cells.Item[FTitleRows+1, i+1],
                                FActiveSheet.Cells.Item[FTitleRows+FDataRowCount, i+1]];
    if (ExpCols[i].Field = nil) or
       (ExpCols[i].Field.DataType in [ftString, ftMemo, ftFmtMemo, ftWideString])
    then
       ARange.NumberFormat := AnsiString('@');
    if ExpCols[i].Checkboxes then
      ARange.HorizontalAlignment := XLSAlignment[taCenter]
    else
      ARange.HorizontalAlignment := XLSAlignment[ExpCols[i].Alignment];
    SetFontIfNeed(ARange, ExpCols[i].Font);
  end;

  TopLeft := 'A'+IntToStr(FTitleRows+1);
  BottomRight := FActiveSheet.Cells.Item[FTitleRows+FDataRowCount, FCurCol-1];
  ARange := FActiveSheet.Range[TopLeft, BottomRight];
  ARange.Value := FVarValues;

  ARange := FActiveSheet.Range[TopLeft, BottomRight];
  ARange.Value := FVarValues;
  SetFont(ARange, DBGridEh.Font);

  FActiveSheet.Range[TopLeft, BottomRight].Borders[9].LineStyle:=1;
  FActiveSheet.Range[TopLeft, BottomRight].Borders[10].LineStyle:=1;

  if DBGridEh.FooterRowCount > 0 then
  begin
    TopLeft := 'A'+IntToStr(FTitleRows+FDataRowCount+1);
    BottomRight := FActiveSheet.Cells.Item[FTitleRows+FDataRowCount+DBGridEh.FooterRowCount, FCurCol-1];
    FActiveSheet.Range[TopLeft, BottomRight].Borders[9].LineStyle:=1;
    FActiveSheet.Range[TopLeft, BottomRight].Borders[10].LineStyle:=1;
  end;
end;

procedure TDBGridEhExportAsOLEXLS.WritePrefix;
var
  Workbook: Variant;
begin
  if FDataRowCountMode then Exit;
  FExcelApp := CreateOleObject('Excel.Application');

  FExcelApp.Application.EnableEvents := False;
  FExcelApp.Visible := True;
  Workbook := FExcelApp.WorkBooks.Add;
  FActiveSheet := Workbook.ActiveSheet;
  FCurRow := 1;
  FDataRowCount := 0;

  FDataRowCountMode := True;
  inherited ExportToStream(Stream, FIsExportAll);
  FDataRowCountMode := False;
  FDefaultSizeDelta := FActiveSheet.Range['A1', 'A1'].Font.Size / GetFontSize(DBGridEh.Font);

  if FDataRowCount > 0 then
    FVarValues := VarArrayCreate([0, FDataRowCount-1, 0, ExpCols.Count-1], varVariant);
end;

procedure TDBGridEhExportAsOLEXLS.WriteTitle(ColumnsList: TColumnsEhList);
var i, k: Integer;
  FPTitleExpArr: TTitleExpArr;
  ListOfHeadTreeNodeList: TList;
  ColSpan, RowSpan: Integer;
  xf: Double;
begin
  if FDataRowCountMode then Exit;
  if ColumnsList.Count = 0 then Exit;

  if DBGridEh.UseMultiTitle then
  begin
    for i := 0 to ColumnsList.Count - 1 do
    begin
      xf := FActiveSheet.Columns[1+i].ColumnWidth / FActiveSheet.Columns[1+i].Width;
      FActiveSheet.Columns[1+i].ColumnWidth := ColumnsList[i].Width * xf;
    end;

    try
      CreateMultiTitleMatrix(DBGridEh, ColumnsList, FPTitleExpArr, ListOfHeadTreeNodeList);

      for k := ListOfHeadTreeNodeList.Count - 1 downto 0 do
      begin
        for i := 0 to ColumnsList.Count - 1 do
        begin
          if THeadTreeNode(TList(ListOfHeadTreeNodeList.Items[k]).Items[i]) <> nil then
          begin
            CalcSpan(ColumnsList, ListOfHeadTreeNodeList, k, i, ColSpan, RowSpan);
            if k - RowSpan = -1 then
            begin
              FActiveSheet.Range[FActiveSheet.Cells[FCurRow, 1+i], FActiveSheet.Cells[FCurRow+RowSpan-1, 1+i+ColSpan-1]].Select;
              FExcelApp.Selection.MergeCells:=True;
              FActiveSheet.Cells(FCurRow, 1+i) := THeadTreeNode(TList(ListOfHeadTreeNodeList.Items[k]).Items[i]).Text;
              FActiveSheet.Cells[FCurRow, 1+i].HorizontalAlignment := XLSAlignment[ColumnsList[i].Title.Alignment];
              FActiveSheet.Cells[FCurRow, 1+i].WrapText := True;
              SetFontIfNeed(FActiveSheet.Cells[FCurRow, 1+i], ColumnsList[i].Title.Font);
              if ColumnsList[i].Title.Orientation = tohVertical then
                FActiveSheet.Cells[FCurRow, 1+i].Orientation := $FFFFEFB5;
            end else
            begin
              FActiveSheet.Range[FActiveSheet.Cells[FCurRow, 1+i], FActiveSheet.Cells[FCurRow+RowSpan-1, 1+i+ColSpan-1]].Select;
              FExcelApp.Selection.MergeCells:=True;
              FActiveSheet.Cells(FCurRow, 1+i) := THeadTreeNode(TList(ListOfHeadTreeNodeList.Items[k]).Items[i]).Text;
              FActiveSheet.Cells[FCurRow, 1+i].HorizontalAlignment := XLSAlignment[taCenter];
              FActiveSheet.Cells[FCurRow, 1+i].WrapText := True;
              SetFontIfNeed(FActiveSheet.Cells[FCurRow, 1+i], DBGridEh.TitleFont);
            end;
          end;
        end;
        Inc(FCurRow);
      end;

      FTitleRows := FCurRow-1;

    finally
      for i := 0 to ListOfHeadTreeNodeList.Count - 1 do
        TList(ListOfHeadTreeNodeList.Items[i]).Free;
      ListOfHeadTreeNodeList.Free;
    end;
  end else
  begin
    for i := 0 to ColumnsList.Count - 1 do
    begin
      xf := FActiveSheet.Columns[1+i].ColumnWidth / FActiveSheet.Columns[1+i].Width;
{$IFDEF CPUX64}
      FActiveSheet.Columns[1+i].ColumnWidth := Round(ColumnsList[i].Width * xf); // without round ColumnWidth = 0 in excel
{$ELSE}
      FActiveSheet.Columns[1+i].ColumnWidth := ColumnsList[i].Width * xf;
{$ENDIF}
      FActiveSheet.Cells(FCurRow, 1+i) := ColumnsList[i].Title.Caption;
      FActiveSheet.Cells[FCurRow, 1+i].HorizontalAlignment := XLSAlignment[ColumnsList[i].Title.Alignment];
      SetFontIfNeed(FActiveSheet.Cells[FCurRow, 1+i], ColumnsList[i].Title.Font);
      if ColumnsList[i].Title.Orientation = tohVertical then
        FActiveSheet.Cells[FCurRow, 1+i].Orientation := $FFFFEFB5;
    end;
    Inc(FCurRow);
    FTitleRows := 1;
  end;
  FActiveSheet.Range[FActiveSheet.Cells[1, 1], FActiveSheet.Cells[FTitleRows, ColumnsList.Count]].Borders.LineStyle:=1;
end;

procedure TDBGridEhExportAsOLEXLS.WriteFooter(ColumnsList: TColumnsEhList;
  FooterNo: Integer);
begin
  if FDataRowCountMode then Exit;
  FCurCol := 1;
  inherited WriteFooter(ColumnsList, FooterNo);
  Inc(FCurRow);
end;

procedure TDBGridEhExportAsOLEXLS.WriteFooterCell(DataCol, Row: Integer;
  Column: TColumnEh; AFont: TFont; Background: TColor;
  Alignment: TAlignment; Text: String);
var
  Footer: TColumnFooterEh;
  ACell: Variant;
begin
  Footer := Column.UsedFooter(Row);
  FActiveSheet.Cells(FCurRow, FCurCol) := Text;
  ACell := FActiveSheet.Cells[FCurRow, FCurCol];
  ACell.HorizontalAlignment := XLSAlignment[Footer.Alignment];
  SetFontIfNeed(FActiveSheet.Cells[FCurRow, FCurCol], AFont);
  Inc(FCurCol);
end;

procedure TDBGridEhExportAsOLEXLS.SetFontIfNeed(Range: Variant; Font: TFont);
begin
  if (DBGridEh.Font.Style <> Font.Style) or
     (DBGridEh.Font.Color <> Font.Color) or
     (GetFontSize(DBGridEh.Font) <> GetFontSize(Font)) then
    SetFont(Range, Font);
end;

procedure TDBGridEhExportAsOLEXLS.SetFont(Range: Variant; Font: TFont);
begin
  if fsBold in Font.Style then
    Range.Font.Bold := True;
  if fsItalic in Font.Style then
    Range.Font.Italic := True;
  if fsUnderline in Font.Style then
    Range.Font.Underline := $00000002;
  if fsStrikeOut in Font.Style then
    Range.Font.Strikethrough := True;
  Range.Font.Color := ColorToRGB(Font.Color);
  Range.Font.Size := Integer(Round(GetFontSize(Font) * FDefaultSizeDelta));
end;

function ExportDBGridEhToOleExcel(DBGridEh: TCustomDBGridEh;
  Options: TDBGridEhExportAsOLEXLSOptions; IsSaveAll: Boolean = True
// ;const FileName: String = ''
  ): Variant;
var
  OLEXLS: TDBGridEhExportAsOLEXLS;
begin
  OLEXLS := TDBGridEhExportAsOLEXLS.Create;
  try
    OLEXLS.DBGridEh := DBGridEh;
    Result := OLEXLS.ExportToExcel(IsSaveAll, Options);
//    OLEXLS. ImportFromFile(FileName, IsLoadToAll);
  finally
    OLEXLS.Free;
  end;
end;

{$IFDEF FPC}
{$ELSE}

{ TDBGridEhExportAsXlsx }

//const sTestLineBreak = sLineBreak;
const sTestLineBreak = ' ';
const sShortTestLineBreak = '';

function StrToXMLValue(s: String): String;
begin
  Result := StringReplace(s,   '&', '&amp;',[rfReplaceAll]);
  Result := StringReplace(Result, '<', '&lt;',[rfReplaceAll]);
  Result := StringReplace(Result, '>', '&gt;',[rfReplaceAll]);
end;

procedure InitXMLDocument(var XML: IXMLDocument);
begin
//  XML := NewXMLDocument;
  XML.Options := XML.Options-[doNamespaceDecl];
  XML.Encoding := 'UTF-8';
  XML.StandAlone := 'yes';
end;

procedure ToTheme(var Stream: TStream);
var
  XML: IXMLDocument;
begin
  XML := NewXMLDocument;
  XML.LoadFromXML(SThemeEh);
  XML.SaveToStream(Stream);
end;

procedure ToRels(var Stream: TStream);
const
  st = 'http://schemas.openxmlformats.org/package/2006/relationships';
  ArrId: array [1 .. 3] of string = ('rId3', 'rId2', 'rId1');
  ArrType: array [1 .. 3] of string =
    ('http://schemas.openxmlformats.org/officeDocument/2006/relationships/extended-properties',
     'http://schemas.openxmlformats.org/package/2006/relationships/metadata/core-properties',
     'http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument');
  ArrTarget: array [1 .. 3] of string = (
    'docProps/app.xml',
    'docProps/core.xml',
    'xl/workbook.xml');
var
  i: Integer;
  Xml: IXMLDocument;
  Root: IXMLNode;
begin
  Xml := NewXMLDocument;

  InitXMLDocument(Xml);
  Xml.AddChild('Relationships').Attributes['xmlns'] := st;
  for i := 1 to 3 do
  begin
    Root := Xml.CreateElement('Relationship', st);
    Root.Attributes['Id'] := ArrId[i];
    Root.Attributes['Type'] := ArrType[i];
    Root.Attributes['Target'] := ArrTarget[i];
    Xml.DocumentElement.ChildNodes.Add(Root);
  end;
  Xml.SaveToStream(Stream);
end;

procedure ToRelsWorkbook(var Stream: TStream);
const
  st = 'http://schemas.openxmlformats.org/package/2006/relationships';
  ArrId: array [1 .. 3] of string = ('rId3', 'rId2', 'rId1');
  ArrType: array [1 .. 3] of string =
    ('http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles',
    'http://schemas.openxmlformats.org/officeDocument/2006/relationships/theme',
    'http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet');
  ArrTarget: array [1 .. 3] of string = ('styles.xml', 'theme/theme1.xml',
    'worksheets/sheet1.xml');
var
  i: Integer;
  Xml: IXMLDocument;
  Root: IXMLNode;
begin
  Xml := NewXMLDocument;

  InitXMLDocument(Xml);
  Xml.AddChild('Relationships').Attributes['xmlns'] := st;
  for i := 1 to 3 do
  begin
    Root := Xml.CreateElement('Relationship', st);
    Root.Attributes['Id'] := ArrId[i];
    Root.Attributes['Type'] := ArrType[i];
    Root.Attributes['Target'] := ArrTarget[i];
    Xml.DocumentElement.ChildNodes.Add(Root);
  end;
  Xml.SaveToStream(Stream);
end;

procedure ToApp(var Stream: TStream);
const
  st = 'http://schemas.openxmlformats.org/officeDocument/2006/extended-properties';
  ArrElement: array [1 .. 8] of string = ('Application', 'DocSecurity',
    'ScaleCrop', 'Company', 'LinksUpToDate', 'SharedDoc', 'HyperlinksChanged',
    'AppVersion');
  ArrText: array [1 .. 8] of string = ('Microsoft Excel', '0', 'false',
    'SPecialiST RePack, SanBuild', 'false', 'false', 'false', '14.0300');
var
  i: Integer;
  Xml: IXMLDocument;
  Root, Node: IXMLNode;
begin
  Xml := NewXMLDocument;
  InitXMLDocument(Xml);
  Root := Xml.AddChild('Properties');
  Root.Attributes['xmlns'] := st;
  Root.Attributes['xmlns:vt'] := 'http://schemas.openxmlformats.org/officeDocument/2006/docPropsVTypes';

  for i := 1 to 8 do
  begin
    Root := Xml.CreateElement(ArrElement[i], st);
    Root.Text := ArrText[i];
    Xml.DocumentElement.ChildNodes.Add(Root);
  end;

  Root := Xml.CreateElement('HeadingPairs', st);
  Node := Root.AddChild('vt:vector');
  Node.Attributes['size'] := 2;
  Node.Attributes['baseType'] := 'variant';
  Node.AddChild('vt:variant').AddChild('vt:lpstr').Text := 'Sheets';
  Node.AddChild('vt:variant').AddChild('vt:i4').Text := '1';
  Xml.DocumentElement.ChildNodes.Add(Root);

  Root := Xml.CreateElement('TitlesOfParts', st);
  Node := Root.AddChild('vt:vector');
  Node.Attributes['size'] := 1;
  Node.Attributes['baseType'] := 'lpstr';
  Node.AddChild('vt:lpstr').Text := 'Sheet1';
  Xml.DocumentElement.ChildNodes.Add(Root);

  Xml.SaveToStream(Stream);
end;

procedure ToCore(var Stream: TStream);
const
  st = 'http://schemas.openxmlformats.org/package/2006/metadata/core-properties';
  ArrAttribut: array [1 .. 5] of string = ('xmlns:cp', 'xmlns:dc',
    'xmlns:dcterms', 'xmlns:dcmitype', 'xmlns:xsi');
  ArrTextAttribut: array [1 .. 5] of string = (st,
    'http://purl.org/dc/elements/1.1/', 'http://purl.org/dc/terms/',
    'http://purl.org/dc/dcmitype/',
    'http://www.w3.org/2001/XMLSchema-instance');
  ArrCreator: array [1 .. 3] of string = ('dc:creator', 'cp:lastModifiedBy',
    'dcterms:created');
var
  i: Integer;
  Xml: IXMLDocument;
  Root: IXMLNode;
begin
  Xml := NewXMLDocument;
  InitXMLDocument(Xml);
  Root := Xml.AddChild('cp:coreProperties');
  for i := 1 to 5 do
    Root.Attributes[ArrAttribut[i]] := ArrTextAttribut[i];

  for i := 1 to 3 do
  begin
    Root := Xml.CreateElement(ArrCreator[i], '');
    if i < 3 then
      Root.Text := 'EhLib'
    else
      Root.Text := FormatDateTime('yyyy-mm-dd', Date) + 'T' +
        FormatDateTime('hh:mm:ss', Time) + 'Z';
    Xml.DocumentElement.ChildNodes.Add(Root);
  end;
  Root.Attributes['xsi:type'] := 'dcterms:W3CDTF';

  Xml.SaveToStream(Stream);
end;

procedure ToSheet(var Xml: IXMLDocument);
const
  st = 'http://schemas.openxmlformats.org/spreadsheetml/2006/main';
  ArrAttributes: array [1 .. 5] of string = (st,
    'http://schemas.openxmlformats.org/officeDocument/2006/relationships',
    'http://schemas.openxmlformats.org/markup-compatibility/2006', 'x14ac',
    'http://schemas.microsoft.com/office/spreadsheetml/2009/9/ac');
  ArrNameAttributes: array [1 .. 5] of string = ('xmlns', 'xmlns:r', 'xmlns:mc',
    'mc:Ignorable', 'xmlns:x14ac');
var
  i: Integer;
  Root, Node: IXMLNode;
begin
  Xml := NewXMLDocument;
  InitXMLDocument(Xml);
  Root := Xml.AddChild('worksheet');
  for i := 1 to 5 do
    Root.Attributes[ArrNameAttributes[i]] := ArrAttributes[i];

  Root := Xml.CreateElement('dimension', st);
  Root.Attributes['ref'] := 'A1';
  Xml.DocumentElement.ChildNodes.Add(Root);
  Root := Xml.CreateElement('sheetViews', st);
  Node := Root.AddChild('sheetView');
  Node.Attributes['tabSelected'] := '1';
  Node.Attributes['workbookViewId'] := '0';
  Xml.DocumentElement.ChildNodes.Add(Root);
  Root := Xml.CreateElement('sheetFormatPr', st);
  Root.Attributes['defaultRowHeight'] := '15';
  Root.Attributes['x14ac:dyDescent'] := '0.25';
  Xml.DocumentElement.ChildNodes.Add(Root);
  Root := Xml.CreateElement('cols', st);
  Xml.DocumentElement.ChildNodes.Add(Root);
  Root := Xml.CreateElement('sheetData', st);
  Xml.DocumentElement.ChildNodes.Add(Root);
end;

procedure ToSheetStrSm(Stream: TStringStream);
begin
  Stream.WriteString('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>');
  Stream.WriteString(sLineBreak);
  Stream.WriteString('<worksheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main"');
  Stream.WriteString(sTestLineBreak);
  Stream.WriteString('  xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"');
  Stream.WriteString(sTestLineBreak);
  Stream.WriteString('  xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"');
  Stream.WriteString(sTestLineBreak);
  Stream.WriteString('  mc:Ignorable="x14ac"');
  Stream.WriteString(sTestLineBreak);
  Stream.WriteString('  xmlns:x14ac="http://schemas.microsoft.com/office/spreadsheetml/2009/9/ac">');
  Stream.WriteString(sShortTestLineBreak);

  Stream.WriteString('<dimension ref="A1"/>');
  Stream.WriteString(sShortTestLineBreak);

  Stream.WriteString('<sheetViews>');
  Stream.WriteString(sShortTestLineBreak);
  Stream.WriteString('<sheetView tabSelected="1" workbookViewId="0"/>');
  Stream.WriteString(sShortTestLineBreak);
  Stream.WriteString('</sheetViews>');
  Stream.WriteString(sShortTestLineBreak);

  Stream.WriteString('<sheetFormatPr defaultRowHeight="15" x14ac:dyDescent="0.25"/>');
  Stream.WriteString(sShortTestLineBreak);
end;

procedure ToWorkbook(var Stream: TStream);
const
  st = 'http://schemas.openxmlformats.org/spreadsheetml/2006/main';
  ArrAttributes: array [1 .. 11] of string = ('xl', '5', '5', '9303', '480',
    '120', '27795', '12585', 'Sheet1', '1', 'rId1');
  ArrNameAttributes: array [1 .. 11] of string = ('appName', 'lastEdited',
    'lowestEdited', 'rupBuild', 'xWindow', 'yWindow', 'windowWidth',
    'windowHeight', 'name', 'sheetId', 'r:id');
var
  i: Integer;
  Xml: IXMLDocument;
  Root, Node: IXMLNode;
begin
  Xml := NewXMLDocument;
  InitXMLDocument(Xml);
  Root := Xml.AddChild('workbook');
  Root.Attributes['xmlns'] := st;
  Root.Attributes['xmlns:r'] :=
    'http://schemas.openxmlformats.org/officeDocument/2006/relationships';

  Root := Xml.CreateElement('fileVersion', st);
  for i := 1 to 4 do
    Root.Attributes[ArrNameAttributes[i]] := ArrAttributes[i];
  Xml.DocumentElement.ChildNodes.Add(Root);
  Root := Xml.CreateElement('workbookPr', st);
  Root.Attributes['defaultThemeVersion'] := '124226';
  Xml.DocumentElement.ChildNodes.Add(Root);
  Root := Xml.CreateElement('bookViews', st);
  Node := Root.AddChild('workbookView');
  for i := 5 to 8 do
    Node.Attributes[ArrNameAttributes[i]] := ArrAttributes[i];
  Xml.DocumentElement.ChildNodes.Add(Root);
  Root := Xml.CreateElement('sheets', st);
  Node := Root.AddChild('sheet');
  for i := 9 to 11 do
    Node.Attributes[ArrNameAttributes[i]] := ArrAttributes[i];
  Xml.DocumentElement.ChildNodes.Add(Root);
  Root := Xml.CreateElement('calcPr', st);
  Root.Attributes['calcId'] := '145621';
  Xml.DocumentElement.ChildNodes.Add(Root);

  Xml.SaveToStream(Stream);
end;

procedure ToStyles(var Xml: IXMLDocument);
const
  st = 'http://schemas.openxmlformats.org/spreadsheetml/2006/main';
  ArrAttributes: array [1 .. 25] of string = (st,
    'http://schemas.openxmlformats.org/markup-compatibility/2006', 'x14ac',
    'http://schemas.microsoft.com/office/spreadsheetml/2009/9/ac', '11', '1',
    'Calibri', '2', '204', 'minor', '0', '0', '0', '0', '0', '0', '0', '0', '0',
    'Обычный', '0', '0', '0', 'TableStyleMedium2', 'PivotStyleLight16');
  ArrNameAttributes: array [1 .. 25] of string = ('xmlns', 'xmlns:mc',
    'mc:Ignorable', 'xmlns:x14ac', 'val', 'theme', 'val', 'val', 'val', 'val',
    'numFmtId', 'fontId', 'fillID', 'borderId', 'numFmtId', 'fontId', 'fillId',
    'borderId', 'xfId', 'name', 'xfId', 'builtinId', 'count',
    'defaultTableStyle', 'defaultPivotStyle');
  ArrChild: array [5 .. 15] of string = ('sz', 'color', 'name', 'family',
    'charset', 'scheme', 'left', 'right', 'top', 'bottom', 'diagonal');
var
  i: Integer;
  Root, Node: IXMLNode;
begin
  Xml := NewXMLDocument;
  InitXMLDocument(Xml);
  Root := Xml.AddChild('styleSheet');
  for i := 1 to 1 do
    Root.Attributes[ArrNameAttributes[i]] := ArrAttributes[i];

  Root := Xml.CreateElement('fonts', st);
  Root.Attributes['count'] := '1';
  Node := Root.AddChild('font');
  for i := 5 to 10 do
    Node.AddChild(ArrChild[i]).Attributes[ArrNameAttributes[i]] := ArrAttributes[i];
  Xml.DocumentElement.ChildNodes.Add(Root);
  Root := Xml.CreateElement('fills', st);
  Root.Attributes['count'] := '2';
  Root.AddChild('fill').AddChild('patternFill').Attributes['patternType'] := 'none';
  Root.AddChild('fill').AddChild('patternFill').Attributes['patternType'] := 'gray125';
  Xml.DocumentElement.ChildNodes.Add(Root);
  Root := Xml.CreateElement('borders', st);
  Root.Attributes['count'] := '1';
  Node := Root.AddChild('border');
  for i := 11 to 15 do
    Node.AddChild(ArrChild[i]);
  Xml.DocumentElement.ChildNodes.Add(Root);
  Root := Xml.CreateElement('cellStyleXfs', st);
  Root.Attributes['count'] := '1';
  Node := Root.AddChild('xf');
  for i := 11 to 14 do
    Node.Attributes[ArrNameAttributes[i]] := ArrAttributes[i];
  Xml.DocumentElement.ChildNodes.Add(Root);
  Root := Xml.CreateElement('cellXfs', st);
  Root.Attributes['count'] := '1';
  Node := Root.AddChild('xf');
  for i := 15 to 19 do
    Node.Attributes[ArrNameAttributes[i]] := ArrAttributes[i];
  Xml.DocumentElement.ChildNodes.Add(Root);
  Root := Xml.CreateElement('cellStyles', st);
  Root.Attributes['count'] := '1';
  Node := Root.AddChild('cellStyle');
  for i := 20 to 22 do
    Node.Attributes[ArrNameAttributes[i]] := ArrAttributes[i];
  Xml.DocumentElement.ChildNodes.Add(Root);
  Root := Xml.CreateElement('dxfs', st);
  Root.Attributes['count'] := '0';
  Xml.DocumentElement.ChildNodes.Add(Root);
  Root := Xml.CreateElement('tableStyles', st);
  for i := 23 to 25 do
    Root.Attributes[ArrNameAttributes[i]] := ArrAttributes[i];
  Xml.DocumentElement.ChildNodes.Add(Root);
  Root := Xml.CreateElement('extLst', st);
  Node := Root.AddChild('ext');
  Node.Attributes['uri'] := '{EB79DEF2-80B8-43e5-95BD-54CBDDF9020C}';
  Node.Attributes['xmlns:x14'] := 'http://schemas.microsoft.com/office/spreadsheetml/2009/9/main';
  Node.AddChild('x14:slicerStyles').Attributes['defaultSlicerStyle'] := 'SlicerStyleLight1';
  Xml.DocumentElement.ChildNodes.Add(Root);
end;

procedure ToContentTypes(var Stream: TStream);
const
  st = 'http://schemas.openxmlformats.org/package/2006/content-types';
  ArrExtension: array [1 .. 8] of string = ('rels', 'xml', '/xl/workbook.xml',
    '/xl/worksheets/sheet1.xml', '/xl/theme/theme1.xml', '/xl/styles.xml',
    '/docProps/core.xml', '/docProps/app.xml');
  ArrContent: array [1 .. 8] of string =
    ('application/vnd.openxmlformats-package.relationships+xml',
    'application/xml',
    'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet.main+xml',
    'application/vnd.openxmlformats-officedocument.spreadsheetml.worksheet+xml',
    'application/vnd.openxmlformats-officedocument.theme+xml',
    'application/vnd.openxmlformats-officedocument.spreadsheetml.styles+xml',
    'application/vnd.openxmlformats-package.core-properties+xml',
    'application/vnd.openxmlformats-officedocument.extended-properties+xml');
var
  i: Integer;
  Xml: IXMLDocument;
  Root: IXMLNode;
begin
  Xml := NewXMLDocument;
  InitXMLDocument(Xml);
  Root := Xml.AddChild('Types');
  Root.Attributes['xmlns'] := st;

  for i := 1 to 2 do
  begin
    Root := Xml.CreateElement('Default', st);
    Root.Attributes['Extension'] := ArrExtension[i];
    Root.Attributes['ContentType'] := ArrContent[i];
    Xml.DocumentElement.ChildNodes.Add(Root);
  end;

  for i := 3 to 8 do
  begin
    Root := Xml.CreateElement('Override', st);
    Root.Attributes['PartName'] := ArrExtension[i];
    Root.Attributes['ContentType'] := ArrContent[i];
    Xml.DocumentElement.ChildNodes.Add(Root);
  end;

  Xml.SaveToStream(Stream);
end;

procedure TDBGridEhExportAsXlsx.ExportToStream(AStream: TStream; IsExportAll: Boolean);
var
  InternalStream: TStream;
begin
  FIsExportAll := IsExportAll;
  if ZipFileProviderClass = nil then
    raise Exception.Create('ZipFileProviderClass is not assigned');
  FZipFileProvider := ZipFileProviderClass.CreateInstance;
  try
    InternalStream := FZipFileProvider.InitZipFile('');
    inherited ExportToStream(InternalStream, IsExportAll);
  finally
    FZipFileProvider.FinalizeZipFile(AStream);
    FreeAndNil(FZipFileProvider);
  end;
//  inherited ExportToFile(FileName, IsExportAll);
end;

procedure TDBGridEhExportAsXlsx.ExportToFile(FileName: String; IsExportAll: Boolean);
var
  AStream: TStream;
begin
  FIsExportAll := IsExportAll;
  if ZipFileProviderClass = nil then
    raise Exception.Create('ZipFileProviderClass is not assigned');
  FZipFileProvider := ZipFileProviderClass.CreateInstance;
  try
    AStream := FZipFileProvider.InitZipFile(FileName);
    inherited ExportToStream(AStream, IsExportAll);
  finally
    FZipFileProvider.FinalizeZipFile;
    FreeAndNil(FZipFileProvider);
  end;
//  inherited ExportToFile(FileName, IsExportAll);
end;

procedure TDBGridEhExportAsXlsx.CalcFooterValues;
begin
  inherited CalcFooterValues;
end;

{
function TDBGridEhExportAsXlsx.ExportToXlsx(IsExportAll: Boolean; Options: TDBGridEhExportAsXlsxOptions): Variant;
begin
  FOptions := Options;
  FIsExportAll := IsExportAll;
  inherited ExportToStream(nil, IsExportAll);
end;
}

procedure TDBGridEhExportAsXlsx.WriteRecord(ColumnsList: TColumnsEhList);
var
//  Root: IXMLNode;
  n: Integer;
begin
  FCurCol := 1;

  n := FExpCols.Count;

//  Root := FXMLSheet.DocumentElement.ChildNodes.FindNode('sheetData');

//  FRowNode := Root.AddChild('row');
//  FRowNode.Attributes['r'] := IntToStr(FCurRow);
//  FRowNode.Attributes['spans'] := '1:' + IntToStr(n);
//  FRowNode.Attributes['x14ac:dyDescent'] := '0.25';

  FSheetStr.WriteString('<row r="' + IntToStr(FCurRow)+'"');
  FSheetStr.WriteString(' spans="1:' + IntToStr(n)+'"');
  FSheetStr.WriteString(' x14ac:dyDescent="0.25">');

  inherited WriteRecord(ColumnsList);

  FSheetStr.WriteString('</row>');
  Inc(FCurRow);
end;

const
  ZE_STR_ARRAY: array [0..25] of char = (
  'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N',
  'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z');

function ZEGetA1byCol(ColNum: Integer; StartZero: Boolean = True): string;
var
  t, n: Integer;
  S: string;
begin
  t := ColNum;
  if (not StartZero) then
    Dec(t);
  Result := '';
  S := '';
  while t >= 0 do
  begin
    n := t mod 26;
    t := (t div 26) - 1;
    S := S + ZE_STR_ARRAY[n];
  end;
  for t := Length(S) downto 1 do
    Result := Result + S[t];
end;

function IsNumber(st: String): Boolean;
var
  b: Boolean;
  i, n: Integer;
begin
  b := True;
  n := Length(st);
  for i := 1 to n do
    if not CharInSetEh(st[i], ['#', '0', ',', '.']) then
      b := False;
  Result := b;
end;

function ColorToHex(Acolor: TColor): String;
begin
  Result :=
    IntToHex(GetRValue(ColorToRGB(AColor)), 2) +
    IntToHex(GetGValue(ColorToRGB(AColor)), 2) +
    IntToHex(GetBValue(ColorToRGB(AColor)), 2);
end;

procedure TDBGridEhExportAsXlsx.WriteDataCell(Column: TColumnEh;
  FColCellParamsEh: TColCellParamsEh);
var
  t, f: Boolean;
  temp, b, NumFmt: Integer;
  Data: Variant;
//  Node, Node2: IXMLNode;
  Color: TColor;
  Val, rAtr, tAtr, NumFmtVal: String;
begin
  Val := '';
  tAtr := '';
  NumFmtVal := '';
//  Node2 := FRowNode.AddChild('c');
//  Node2.Attributes['r'] := ZEGetA1byCol(FCurCol - 1) + IntToStr(FCurRow);
  rAtr := ZEGetA1byCol(FCurCol - 1) + IntToStr(FCurRow);

  NumFmt := 0;
  b := 0;
  if Column.Grid.GridLineParams.DataHorzLines then
    b := b + 1;
  if Column.Grid.GridLineParams.DataVertLines then
    b := b + 2;

  if dghAutoFitRowHeight in Column.Grid.OptionsEh
    then t := True
    else t := False;

  if xlsxColoredEh in FOptions
    then Color := FColCellParamsEh.Background
    else Color := TDBGridEh(DBGridEh).Color;

  if Column.Field = nil then
    Val := ''
  else if Column.GetBarType = ctKeyPickList then
  begin
    tAtr := 'str';
    Val := FColCellParamsEh.Text;
  end
  else if Column.Field.IsNull then
    Val := ''
  else
  begin
//    with Column.Field do
    begin
      if xlsxDataAsEditText in FOptions then
      begin
        Data := Column.Field.Text;
        tAtr := 'str';
      end
      else if xlsxDataAsDisplayText in FOptions then
      begin
        Data := FColCellParamsEh.Text;
        tAtr := 'str';
      end
      else if (Column.Field.DataType in [ftDate, ftDateTime]) and // check for minimum date
        (not Column.Field.IsNull) and // if date < 01-01-1900 then write as text
        (Column.Field.AsDateTime < EncodeDate(1900, 1, 1)) then
      begin
        Data := FColCellParamsEh.Text;
        tAtr := 'str';
      end
      else
      begin
        if Column.Field.DataType in
          [ftBlob, ftGraphic, ftParadoxOle, ftDBaseOle, ftOraBlob,
           ftBytes, ftTypedBinary, ftVarBytes]
        then
          Data := ''
        else
          Data := Column.Field.Value;
        f := False;
        if (Column.Field.DataType in
             [ftSmallint, ftInteger, ftWord, ftAutoInc, ftBytes, ftFloat, ftCurrency, ftBCD]) and
           (Column.DisplayFormat <> '')
        then
          if IsNumber(Column.DisplayFormat) then
          begin
//            Node := FFmtNode.AddChild('numFmt');
//            Node.Attributes['numFmtId'] := FNumFmt;
            NumFmt := FNumFmt;
            Inc(FNumFmt);
//            Node.Attributes['formatCode'] := Column.DisplayFormat;
          end
          else
            f := True;
        if f or not ( Column.Field.DataType in [ftSmallint, ftInteger, ftWord, ftAutoInc,
          ftBytes, ftFloat, ftCurrency, ftBCD])
        then
          tAtr := 'str';
      end;

//      temp := SetStyle(0, FColCellParamsEh.Font, Integer(FColCellParamsEh.Alignment), Color, b, False, t);
      Val := VarToStr(Data);
    end;
  end;

  temp := SetStyle(NumFmt, FColCellParamsEh.Font, Integer(FColCellParamsEh.Alignment), Color, b, False, t);

  FSheetStr.WriteString('<c ');
    FSheetStr.WriteString('r="'+ rAtr +'"');
    if tAtr <> '' then
      FSheetStr.WriteString(' t="'+ tAtr +'"');
    if temp > 0 then
      FSheetStr.WriteString(' s="'+ IntToStr(temp) +'"');
    FSheetStr.WriteString('>');

    FSheetStr.WriteString('<v>'+StrToXMLValue(Val)+'</v>');
  FSheetStr.WriteString('</c>');

  Inc(FCurCol);
end;

procedure TDBGridEhExportAsXlsx.WriteSuffix;
const
  ArrAttributes: array [1 .. 6] of string = ('0.7', '0.7', '0.75', '0.75',
    '0.3', '0.3');
  ArrNameAttributes: array [1 .. 6] of string = ('left', 'right', 'top',
    'bottom', 'header', 'footer');
var
  i, n: Integer;
  Res: TStream;
  Color: TColor;
  Root, Node, Node2: IXMLNode;
//  ColumnsList: TColumnsEhList;
begin
  FRowNode := nil;

  if (FCurCol = 0) and (FDataRowCount = 0) then
  begin
    FreeAndNil(FSheetStr);
    FreeAndNil(FSheetMergeStr);
    Exit;
  end;

//  Root := FXMLSheet.CreateElement('pageMargins',
//    'http://schemas.openxmlformats.org/spreadsheetml/2006/main');
//  for i := 1 to 6 do
//    Root.Attributes[ArrNameAttributes[i]] := ArrAttributes[i];
//  FXMLSheet.DocumentElement.ChildNodes.Add(Root);
//
//  Root := FXMLSheet.DocumentElement.ChildNodes.FindNode('cols');
//  ColumnsList := ExpCols;

//  for i := 0 to ColumnsList.Count - 1 do
//  begin
//    Node := Root.AddChild('col');
//    Node.Attributes['min'] := i + 1;
//    Node.Attributes['max'] := i + 1;
//    Node.Attributes['width'] := ColumnsList[i].Width / 7;
//    Node.Attributes['customWidth'] := 1;
//  end;

//  Res := TMemoryStream.Create;
//  FXMLSheet.SaveToStream(Res);
//  Res.Seek(0, soFromBeginning);
//  FZipFileProvider.AddFile(Res, 'xl\worksheets\sheet1.xml');
//  Res.Free;

  FSheetStr.WriteString('</sheetData>');
  if FSheetMergeCount > 0 then
  begin
    FSheetStr.WriteString('<mergeCells count="'+IntToStr(FSheetMergeCount)+'">');
    FSheetStr.WriteString(FSheetMergeStr.DataString);
    FSheetStr.WriteString('</mergeCells>');
  end;
  FSheetStr.WriteString('<pageMargins left="0.7" right="0.7" top="0.75" bottom="0.75" header="0.3" footer="0.3"/>');
  FSheetStr.WriteString('</worksheet>');
  FSheetStr.WriteString(sShortTestLineBreak);

  FSheetStr.Seek(0, soFromBeginning);
  FZipFileProvider.AddFile(FSheetStr, 'xl\worksheets\sheet1.xml');

  if FNumFmt > 164 then
    FXMLStyles.DocumentElement.ChildNodes.Insert(0, FFmtNode);

  n := Length(FFonts);
  Root := FXMLStyles.DocumentElement.ChildNodes.FindNode('fonts');
  Root.Attributes['count'] := n;
  FFonts[0].Free;
  for i := 1 to n - 1 do
  begin
    Node := Root.AddChild('font');
    if fsBold in FFonts[i].Style then
      Node.AddChild('b');
    if fsItalic in FFonts[i].Style then
      Node.AddChild('i');
    if fsUnderline in FFonts[i].Style then
      Node.AddChild('u');
    if fsStrikeOut in FFonts[i].Style then
      Node.AddChild('strike');
    Node.AddChild('sz').Attributes['val'] := FFonts[i].Size;
    Node.AddChild('color').Attributes['rgb'] := 'FF' + ColorToHex(FFonts[i].Color);
    Node.AddChild('name').Attributes['val'] := FFonts[i].Name;
    Node.AddChild('family').Attributes['val'] := 2;
    Node.AddChild('charset').Attributes['val'] := 204;
    FFonts[i].Free;
  end;
  SetLength(FFonts, 0);

  n := Length(FBackColor);
  Root := FXMLStyles.DocumentElement.ChildNodes.FindNode('fills');
  Root.Attributes['count'] := n;
  for i := 2 to n - 1 do
  begin
    Node := Root.AddChild('fill').AddChild('patternFill');
    Node.Attributes['patternType'] := 'solid';
    Node.AddChild('fgColor').Attributes['rgb'] := 'FF' + ColorToHex(FBackColor[i]);
    Node.AddChild('bgColor').Attributes['index'] := 0;
  end;
  SetLength(FBackColor, 0);

  n := Length(FBorder);
  Root := FXMLStyles.DocumentElement.ChildNodes.FindNode('borders');
  Root.Attributes['count'] := n;
  for i := 1 to n - 1 do
  begin
    Node := Root.AddChild('border');
    if FBorder[i] div 2 = 1 then
    begin
      Color := DBGridEh.GridLineParams.DataVertColor;
      Node2 := Node.AddChild('left');
      Node2.Attributes['style'] := 'thin';
      Node2.AddChild('color').Attributes['rgb'] := 'FF' + ColorToHex(Color);
      Node2 := Node.AddChild('right');
      Node2.Attributes['style'] := 'thin';
      Node2.AddChild('color').Attributes['rgb'] := 'FF' + ColorToHex(Color);
    end;
    if FBorder[i] mod 2 = 1 then
    begin
      Color := DBGridEh.GridLineParams.DataHorzColor;
      Node2 := Node.AddChild('top');
      Node2.Attributes['style'] := 'thin';
      Node2.AddChild('color').Attributes['rgb'] := 'FF' + ColorToHex(Color);
      Node2 := Node.AddChild('bottom');
      Node2.Attributes['style'] := 'thin';
      Node2.AddChild('color').Attributes['rgb'] := 'FF' + ColorToHex(Color);
    end;
  end;
  SetLength(FBorder, 0);

  n := Length(FStyles);
  Root := FXMLStyles.DocumentElement.ChildNodes.FindNode('cellXfs');
  Root.Attributes['count'] := n;
  for i := 1 to n - 1 do
  begin
    Node := Root.AddChild('xf');
    Node.Attributes['numFmtId'] := FStyles[i].NumFmt;
    Node.Attributes['fontId'] := FStyles[i].NumFont;
    Node.Attributes['fillId'] := FStyles[i].NumBackColor;
    Node.Attributes['borderId'] := FStyles[i].NumBorder;
    Node.Attributes['xfId'] := 0;
    Node.Attributes['applyFont'] := 1;
    Node.Attributes['applyAlignment'] := 1;
    Node.Attributes['applyFill'] := 1;
    Node.Attributes['applyBorder'] := 1;
    Node2 := Node.AddChild('alignment');

    case FStyles[i].NumAlignment of
      0: Node2.Attributes['horizontal'] := 'left';
      1: Node2.Attributes['horizontal'] := 'right';
      2: Node2.Attributes['horizontal'] := 'center';
    end;
    if FStyles[i].Vertical then
      Node2.Attributes['textRotation'] := 90;
    if FStyles[i].Wrap then
      Node2.Attributes['wrapText'] := 1;
  end;
  SetLength(FStyles, 0);

  Res := TMemoryStream.Create;
  FXMLStyles.SaveToStream(Res);
  Res.Seek(0, soFromBeginning);
  FZipFileProvider.AddFile(Res, 'xl\styles.xml');
  Res.Free;
//  ZipF.Close;
//  ZipF.Free;

  FreeAndNil(FSheetStr);
  FreeAndNil(FSheetMergeStr);

  FormatSettings.DecimalSeparator := FSeparator;
end;

procedure TDBGridEhExportAsXlsx.WritePrefix;
const
  Resours: array [1 .. 7] of procedure(var Stream: TStream) =
    (ToTheme, ToRels, ToApp, ToCore, ToRelsWorkbook, ToWorkbook, ToContentTypes);
  ResoursFile: array [1 .. 7] of string = ('xl\theme\theme1.xml', '_rels\.rels',
  'docProps\app.xml', 'docProps\core.xml', 'xl\_rels\workbook.xml.rels',
  'xl\workbook.xml', '[Content_Types].xml');
var
  i: Integer;
  Res: TStream;
begin
  FSeparator := FormatSettings.DecimalSeparator;
  if not(xlsxDataAsEditText in FOptions) and
    not(xlsxDataAsDisplayText in FOptions)
  then
    FormatSettings.DecimalSeparator := '.';

//  ZipF := TZipFile.Create;
//  ZipF.Open(Stream, zmWrite);
  for i := 1 to 7 do
  begin
    Res := TMemoryStream.Create;
    Resours[i](Res);
    Res.Seek(0, soFromBeginning);
    FZipFileProvider.AddFile(Res, ResoursFile[i]);
    Res.Free;
  end;

//  ToSheet(FXMLSheet);

  FSheetStr := TStringStream.Create(''{$IFDEF EH_LIB_13} ,TEncoding.UTF8 {$ENDIF});
  FSheetMergeStr := TStringStream.Create(''{$IFDEF EH_LIB_13} ,TEncoding.UTF8 {$ENDIF});
  ToSheetStrSm(FSheetStr);

  FSheetStr.WriteString('<cols>');
  for i := 0 to FExpCols.Count - 1 do
  begin
    FSheetStr.WriteString('<col ');
    FSheetStr.WriteString('min="'+IntToStr(i + 1)+'"');
    FSheetStr.WriteString(' max="'+IntToStr(i + 1)+'"');
    FSheetStr.WriteString(' width="'+FloatToStr(FExpCols[i].Width / 7)+'"');
    FSheetStr.WriteString(' customWidth="'+IntToStr(1)+'"');
    FSheetStr.WriteString('/>');
  end;
  FSheetStr.WriteString('</cols>');
  FSheetStr.WriteString('<sheetData>');

  SetLength(FFonts, 1);
  FFonts[0] := TFont.Create;
  FFonts[0].Name := 'Calibri';
  FFonts[0].Size := 11;
  SetLength(FBackColor, 2);
  FBackColor[0] := 0;
  FBackColor[1] := 0;
  SetLength(FBorder, 1);
  FBorder[0] := 0;
  SetLength(FStyles, 1);
  FStyles[0].NumFmt := 0;
  FStyles[0].NumFont := 0;
  FStyles[0].NumAlignment := 0;
  FStyles[0].NumBackColor := 0;
  FStyles[0].NumBorder := 0;
  FStyles[0].Vertical := False;
  FStyles[0].Wrap := False;

  ToStyles(FXMLStyles);
  FNumFmt := 164;
  FFmtNode := FXMLStyles.CreateElement('numFmts',
    'http://schemas.openxmlformats.org/spreadsheetml/2006/main');

  FCurRow := 1;
end;

procedure TDBGridEhExportAsXlsx.WriteTitle(ColumnsList: TColumnsEhList);
var
  i, k: Integer;
  t, w: Boolean;
  temp, b: Integer;
  FPTitleExpArr: TTitleExpArr;
  ListOfHeadTreeNodeList: TList;
  ColSpan, RowSpan: Integer;
//  Root, RootMerge, Node: IXMLNode;
  Color: TColor;
  Val, rAtr, sAtr: String;
  SRange: String;
begin
  if ColumnsList.Count = 0 then
    Exit;

//  Root := FXMLSheet.DocumentElement.ChildNodes.FindNode('sheetData');

  if DBGridEh.UseMultiTitle then
  begin
    try
      FSheetMergeCount := 0;
//      RootMerge := FXMLSheet.CreateElement('mergeCells',
//        'http://schemas.openxmlformats.org/spreadsheetml/2006/main');
      CreateMultiTitleMatrix(DBGridEh, ColumnsList, FPTitleExpArr,
        ListOfHeadTreeNodeList);

      for k := ListOfHeadTreeNodeList.Count - 1 downto 0 do
      begin
//        FRowNode := Root.AddChild('row');

        FSheetStr.WriteString('<row r="' + IntToStr(FCurRow) +'"');
        FSheetStr.WriteString(' spans="1:' + IntToStr(ColumnsList.Count) +'"');
        FSheetStr.WriteString(' x14ac:dyDescent="0.25">');

        for i := 0 to ColumnsList.Count - 1 do
        begin
          if (xlsxColoredEh in FOptions) then
            Color := ColumnsList[i].Title.Color
          else
            Color := TDBGridEh(DBGridEh).Color;

  //        Node := FRowNode.AddChild('c');
          rAtr := ZEGetA1byCol(i) + IntToStr(FCurRow);
          if THeadTreeNode(TList(ListOfHeadTreeNodeList.Items[k]).Items[i]) <> nil
          then
          begin
            CalcSpan(ColumnsList, ListOfHeadTreeNodeList, k, i,
              ColSpan, RowSpan);

            b := 0;
            if DBGridEh.TitleParams.HorzLines then
              b := b + 1;
            if DBGridEh.TitleParams.VertLines then
              b := b + 2;
            if dghAutoFitRowHeight in ColumnsList[i].Grid.OptionsEh then
              t := True
            else
              t := False;
            if (FCurRow <> FCurRow + RowSpan - 1) or (i <> i + ColSpan - 1) then
            begin
              Inc(FSheetMergeCount);
              SRange :=
                ZEGetA1byCol(i) + IntToStr(FCurRow) + ':' +
                ZEGetA1byCol(i + ColSpan - 1) + IntToStr(FCurRow + RowSpan - 1);
              FSheetMergeStr.WriteString('<mergeCell ref="'+SRange+'"/>');
//              RootMerge.AddChild('mergeCell').Attributes['ref'] :=
//                ZEGetA1byCol(i) + IntToStr(FCurRow) + ':' +
//                ZEGetA1byCol(i + ColSpan - 1) + IntToStr(FCurRow + RowSpan - 1);
            end;

            if k - RowSpan = -1 then
            begin
              if ColumnsList[i].Title.Orientation = tohVertical then
                w := True
              else
                w := False;
              temp := SetStyle(0, ColumnsList[i].Title.Font,
                Integer(ColumnsList[i].Title.Alignment), Color, b, w, t)
            end
            else
              temp := SetStyle(0, ColumnsList[i].Title.Font,
                Integer(ColumnsList[i].Title.Alignment), Color, b, False, t);

            Val := THeadTreeNode(TList(ListOfHeadTreeNodeList.Items[k]).Items[i]).Text;

            if temp > 0
              then sAtr := IntToStr(temp)
              else sAtr := '';
          end
          else
          begin
            Val := '';
            sAtr := '1';
            rAtr := '';
          end;

          FSheetStr.WriteString('<c ');
            if rAtr <> '' then
              FSheetStr.WriteString('r="'+ rAtr +'"');
            if Val <> '' then
              FSheetStr.WriteString(' t="str"');
            if sAtr <> '' then
              FSheetStr.WriteString(' s="'+ sAtr +'"');
            FSheetStr.WriteString('>');
            if Val <> '' then
              FSheetStr.WriteString('<v>'+StrToXMLValue(Val)+'</v>');
          FSheetStr.WriteString('</c>');
        end;

        FSheetStr.WriteString('</row>');
        Inc(FCurRow);
      end;

//      if CountMerge > 0 then
//      begin
//        FXMLSheet.DocumentElement.ChildNodes.Add(RootMerge);
//        RootMerge.Attributes['count'] := CountMerge;
//      end;

    finally
      for i := 0 to ListOfHeadTreeNodeList.Count - 1 do
        TList(ListOfHeadTreeNodeList.Items[i]).Free;
      ListOfHeadTreeNodeList.Free;
    end;
  end else
  begin
//    FRowNode := Root.AddChild('row');
//    FRowNode.Attributes['r'] := IntToStr(FCurRow);
//    FRowNode.Attributes['spans'] := '1:' + IntToStr(ColumnsList.Count);
//    FRowNode.Attributes['x14ac:dyDescent'] := '0.25';

    FSheetStr.WriteString('<row r="' + IntToStr(FCurRow)+'"');
    FSheetStr.WriteString(' spans="1:' + IntToStr(ColumnsList.Count)+'"');
    FSheetStr.WriteString(' x14ac:dyDescent="0.25">');

    for i := 0 to ColumnsList.Count - 1 do
    begin
      if (xlsxColoredEh in FOptions) then
        Color := ColumnsList[i].Title.Color
      else
        Color := TDBGridEh(DBGridEh).Color;

//      Node := FRowNode.AddChild('c');
//      Node.Attributes['r'] := ZEGetA1byCol(i) + '1';
      b := 0;
      if DBGridEh.TitleParams.HorzLines then
        b := b + 1;
      if DBGridEh.TitleParams.VertLines then
        b := b + 2;
      if dghAutoFitRowHeight in ColumnsList[i].Grid.OptionsEh
        then t := True
        else t := False;
      if ColumnsList[i].Title.Orientation = tohVertical
        then w := True
        else w := False;
      temp := SetStyle(0, ColumnsList[i].Title.Font, Integer(ColumnsList[i].Title.Alignment),
                       Color, b, w, t);
//      if temp > 0 then
//        Node.Attributes['s'] := temp;
//      Node.Attributes['t'] := 'str';
//      Node.AddChild('v').Text := ColumnsList[i].Title.Caption;

      FSheetStr.WriteString('<c ');
        FSheetStr.WriteString('r="'+ZEGetA1byCol(i) + '1"');
        if temp > 0 then
          FSheetStr.WriteString(' s="' + IntToStr(temp) + '"');
        FSheetStr.WriteString(' t="str">');

        FSheetStr.WriteString('<v>'+StrToXMLValue(ColumnsList[i].Title.Caption)+'</v>');
      FSheetStr.WriteString('</c>');
    end;

    FSheetStr.WriteString('</row>');

    Inc(FCurRow);
  end;
end;

procedure TDBGridEhExportAsXlsx.WriteFooter(ColumnsList: TColumnsEhList;
  FooterNo: Integer);
//var
//  Root: IXMLNode;
begin
  FCurCol := 1;

//  Root := FXMLSheet.DocumentElement.ChildNodes.FindNode('sheetData');
//  FRowNode := Root.AddChild('row');
//  FRowNode.Attributes['r'] := IntToStr(FCurRow);
//  FRowNode.Attributes['spans'] := '1:' + IntToStr(ColumnsList.Count);
//  FRowNode.Attributes['x14ac:dyDescent'] := '0.25';
  FSheetStr.WriteString('<row r="' + IntToStr(FCurRow)+'"');
  FSheetStr.WriteString(' spans="1:' + IntToStr(ColumnsList.Count)+'"');
  FSheetStr.WriteString(' x14ac:dyDescent="0.25">');

  inherited WriteFooter(ColumnsList, FooterNo);
  FSheetStr.WriteString('</row>');

  Inc(FCurRow);
end;

procedure TDBGridEhExportAsXlsx.WriteFooterCell(DataCol, Row: Integer;
  Column: TColumnEh; AFont: TFont; Background: TColor; Alignment: TAlignment;
  Text: String);
var
  t: Boolean;
  temp: Integer;
  Footer: TColumnFooterEh;
//  Node2: IXMLNode;
  Color: TColor;
  Val, rAtr, tAtr, sAtr: String;
begin
  Footer := Column.UsedFooter(Row);
  rAtr := '';
  tAtr := '';
  sAtr := '';
  Val := '';

//  Node2 := FRowNode.AddChild('c');
//  Node2.Attributes['r'] := ZEGetA1byCol(FCurCol - 1) + IntToStr(FCurRow);
  rAtr := ZEGetA1byCol(FCurCol - 1) + IntToStr(FCurRow);
  if dghAutoFitRowHeight in Column.Grid.OptionsEh
    then t := True
    else t := False;
  if (xlsxColoredEh in FOptions)
    then Color := Footer.Color
    else Color := TDBGridEh(DBGridEh).Color;

  temp := SetStyle(0, AFont, Integer(Alignment), Color, 3, False, t);
  if temp > 0 then
    sAtr := IntToStr(temp);
  case Footer.ValueType of
    fvtNon:
      Val := '';
    fvtAvg, fvtCount, fvtSum, fvtFieldValue:
      begin
        if not IsNumber(Text) then
          tAtr := 'str';
        Val := Text;
      end;
    fvtStaticText:
      begin
        tAtr := 'str';
        Val := Text;
      end;
  end;

  FSheetStr.WriteString('<c ');
    FSheetStr.WriteString('r="'+ rAtr +'"');
    if tAtr <> '' then
      FSheetStr.WriteString(' t="'+ tAtr +'"');
    if temp > 0 then
      FSheetStr.WriteString(' s="'+ IntToStr(temp) +'"');
    FSheetStr.WriteString('>');

    FSheetStr.WriteString('<v>'+StrToXMLValue(Val)+'</v>');
  FSheetStr.WriteString('</c>');

  Inc(FCurCol);
end;

function TDBGridEhExportAsXlsx.SetStyle(NumFmt: Integer; Font: TFont;
  Alignment: Integer; BackColor: TColor; Border: Integer;
  Vert, Wrap: Boolean): Integer;
var
  i, n, NFont, NBackColor, NBorder: Integer;
begin
  i := 0;
  n := Length(FStyles);
  NFont := SetFont(Font);
  NBackColor := SetBackColor(BackColor);
  NBorder := SetBorder(Border);
  while (i < Length(FStyles)) and
        ( (NumFmt <> FStyles[i].NumFmt) or
          (NFont <> FStyles[i].NumFont) or
          (Alignment <> FStyles[i].NumAlignment) or
          (NBackColor <> FStyles[i].NumBackColor) or
          (NBorder <> FStyles[i].NumBorder) or
          (Vert <> FStyles[i].Vertical) or
          (Wrap <> FStyles[i].Wrap))
  do
    Inc(i);
  if i = n then
  begin
    SetLength(FStyles, n + 1);
    FStyles[n].NumFmt := NumFmt;
    FStyles[n].NumFont := NFont;
    FStyles[n].NumAlignment := Alignment;
    FStyles[n].NumBackColor := NBackColor;
    FStyles[n].NumBorder := NBorder;
    FStyles[n].Vertical := Vert;
    FStyles[n].Wrap := Wrap;
  end;
  Result := i;
end;

function TDBGridEhExportAsXlsx.SetFont(Font: TFont): Integer;
var
  i, n: Integer;
begin
  i := 0;
  n := Length(FFonts);
  while (i < n) and
        ( (Font.Name <> FFonts[i].Name) or
          (Font.Size <> FFonts[i].Size) or
          (Font.Color <> FFonts[i].Color) or
          (Font.Style <> FFonts[i].Style)
        )
  do
    Inc(i);

  if i = n then
  begin
    SetLength(FFonts, n + 1);
    FFonts[n] := TFont.Create;
    FFonts[n].Name := Font.Name;
    FFonts[n].Size := Font.Size;
    FFonts[n].Color := Font.Color;
    FFonts[n].Style := Font.Style;
  end;
  Result := i;
end;

function TDBGridEhExportAsXlsx.SetBackColor(Color: TColor): Integer;
var
  i, n: Integer;
begin
  i := 0;
  n := Length(FBackColor);
  while (i < Length(FBackColor)) and (Color <> FBackColor[i]) do
    Inc(i);
  if i = n then
  begin
    SetLength(FBackColor, n + 1);
    FBackColor[n] := Color;
  end;
  Result := i;
end;

function TDBGridEhExportAsXlsx.SetBorder(Border: Integer): Integer;
var
  i, n: Integer;
begin
  i := 0;
  n := Length(FBorder);
  while (i < Length(FBorder)) and (Border <> FBorder[i]) do
    Inc(i);
  if i = n then
  begin
    SetLength(FBorder, n + 1);
    FBorder[n] := Border;
  end;
  Result := i;
end;

procedure ExportDBGridEhToXlsx(DBGridEh: TCustomDBGridEh;
  const FileName: String; Options: TDBGridEhExportAsXlsxOptions;
  IsSaveAll: Boolean = True);
var
  Xlsx: TDBGridEhExportAsXlsx;
begin
  Xlsx := TDBGridEhExportAsXlsx.Create;
  try
    Xlsx.DBGridEh := DBGridEh;
    Xlsx.FOptions := Options;
    Xlsx.ExportToFile(FileName, IsSaveAll);
  finally
    Xlsx.Free;
  end;
end;

{ TCustomFileZipingProviderEh }

var
  FZipFileProviderClass: TCustomFileZipingProviderEhClass;

function ZipFileProviderClass: TCustomFileZipingProviderEhClass;
begin
  Result := FZipFileProviderClass;
end;

function RegisterZipFileProviderClass(AZipFileProviderClass: TCustomFileZipingProviderEhClass):
  TCustomFileZipingProviderEhClass;
begin
  Result := FZipFileProviderClass;
  FZipFileProviderClass := AZipFileProviderClass;
end;

class function TCustomFileZipingProviderEh.CreateInstance: TCustomFileZipingProviderEh;
begin
  Result := nil;
end;

{$IFDEF EH_LIB_16} // XE2 or higher

{ TSystemZipFileProvider }

constructor TSystemZipFileProviderEh.Create;
begin
  inherited Create;
end;

destructor TSystemZipFileProviderEh.Destroy;
begin
  inherited Destroy;
  FreeAndNil(FZipFile);
  FreeAndNil(FStream);
end;

class function TSystemZipFileProviderEh.CreateInstance: TCustomFileZipingProviderEh;
begin
  Result := TSystemZipFileProviderEh.Create;
end;

function TSystemZipFileProviderEh.InitZipFile(FileName: String): TStream;
begin
  if FStream <> nil then
    raise Exception.Create('ZipFile is already Initialized.');
  if FZipFile <> nil then
    raise Exception.Create('ZipFile is already Initialized.');
  if FileName = '' then
    FStream := TMemoryStream.Create
  else
    FStream := TFileStream.Create(FileName, fmCreate);
  Result := FStream;
  FZipFile := TZipFile.Create;
  FZipFile.Open(Result, zmWrite);
end;

procedure TSystemZipFileProviderEh.AddFile(Data: TStream; const FilePathAndName: string);
begin
  FZipFile.Add(Data, FilePathAndName);
end;

procedure TSystemZipFileProviderEh.FinalizeZipFile;
begin
  if FZipFile <> nil then
    FZipFile.Close;
  FreeAndNil(FZipFile);
  FreeAndNil(FStream);
end;

procedure TSystemZipFileProviderEh.FinalizeZipFile(AStream: TStream);
begin
  if FZipFile <> nil then
    FZipFile.Close;
  AStream.CopyFrom(FStream, 0);
  FreeAndNil(FZipFile);
  FreeAndNil(FStream);
end;

{$ENDIF} // XE2 or higher

{$ENDIF} // not Lazarus

{$ENDIF} // ELSE CIL

{ Global routines }

procedure InitUnit;
begin
  CF_VCLDBIF := RegisterClipboardFormat('VCLDBIF');
  CF_CSV := RegisterClipboardFormat('Csv');
  CF_RICH_TEXT_FORMAT := RegisterClipboardFormat('Rich Text Format');
//  CF_BIFF := RegisterClipboardFormat('Biff');
//  CF_HTML_FORMAT := RegisterClipboardFormat('HTML Format');

{$IFDEF EH_LIB_16} // XE2 or higher
  RegisterZipFileProviderClass(TSystemZipFileProviderEh);
{$ENDIF} // XE or higher
end;

procedure FinalizeUnit;
begin
{$IFDEF EH_LIB_16} // XE2 or higher
  RegisterZipFileProviderClass(nil);
{$ENDIF} // XE or higher
end;

initialization
  InitUnit;
finalization
  FinalizeUnit;
end.
