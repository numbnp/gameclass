{*******************************************************}
{                                                       }
{                     EhLib v7.0                        }
{             TMemTableDataEh component                 }
{                    Build 7.0.27                       }
{                                                       }
{        Copyright (c) 2003-14 by EhLib Team and        }
{                Dmitry V. Bolshakov                    }
{                                                       }
{*******************************************************}

unit MemTableDataEh;// {$IFDEF CIL} platform{$ENDIF};

{$I EhLib.Inc}

interface

uses SysUtils, ComObj, Dialogs,
{$IFDEF CIL}
  EhLibVCLNET,
{$ELSE}
  {$IFDEF FPC}
  EhLibLCL, bufdataset_parser,
  {$ELSE}
  EhLibVCL, SqlTimSt, DBCommon, DBConsts,
{$ENDIF}
{$ENDIF}
{$IFDEF EH_LIB_6}
  Variants, FMTBcd,
{$ELSE}
  ActiveX,
{$ENDIF}
{$IFDEF EH_LIB_17} System.Types, {$ENDIF}
  Classes, Db, Contnrs,
  MemTreeEh, ToolCtrlsEh;

type

  TIntArray = array of Integer;
  TMemTableDataEh = class;
  TMTDataStructEh = class;
  TRecordsViewEh = class;
  TRecordsListNotificatorEh = class;
  TMemoryRecordEh = class;
  TMemRecViewEh = class;


  TRecordsRangeEh = record
    LowIndex: Integer;
    HighIndex: Integer;
  end;

  TRecordsRangesEh = array of TRecordsRangeEh;

{ TAutoIncrementEh }

  TAutoIncrementEh = class(TPersistent)
  private
    FStep: Integer;
    FInitValue: Integer;
    procedure SetInitValue(const Value: Integer);
  protected
    FCurValue: Longint;
  public
    constructor Create;
    procedure Assign(Source: TPersistent); override;
    property CurValue: Longint read FCurValue;
    function Promote: Longint;
    procedure Reset;
  published
    property InitValue: Integer read FInitValue write SetInitValue default -1;
    property Step: Integer read FStep write FStep default -1;
  end;

{ TUpdateErrorEh }

  TUpdateErrorEh = class
  private
    FException: Exception;
  public
    constructor Create(AException: Exception);
    destructor Destroy; override;
    property ExceptionObject: Exception read FException;
  end;

{ TDataSetExprParserEh }

  TDataSetExprParserTypeEh = (dsptFilterEh, dsptAggregateEh);

  TDataSetExprParserEh = class
  private
    FDataSet: TDataSet;
    {$IFDEF FPC}
    FExprData: TBufDatasetParser;
    {$ELSE}
    FExprData: TExprData;
    {$ENDIF}
    FExprDataSize: Integer;
    FExprParserType: TDataSetExprParserTypeEh;
  public
    constructor Create(ADataSet: TDataSet; ExprParserType: TDataSetExprParserTypeEh);
    destructor Destroy; override;
    procedure ParseExpression(const Expr: String);
    function IsCurRecordInFilter(Rec: TMemoryRecordEh): Boolean;
    function IsCurRecordBufInFilter(Buffer: TRecordBuffer): Boolean;
    function CalcAggregateValue(RecordsView: TRecordsViewEh): Variant;
    function HasData: Boolean;
  end;

{ TMTDataFieldEh }

  TMTDataFieldEh = class(TComponent)
  private
    FAlignment: TAlignment;
    FAutoIncrement: Boolean;
    FDataStruct: TMTDataStructEh;
    FDefaultExpression: String;
    FDisplayLabel: String;
    FDisplayWidth: Integer;
    FEditMask: String;
    FFieldId: Largeint;
    FFieldName: String;
    FGUID: String;
    FReadOnly: Boolean;
    FRequired: Boolean;
    FSize: Integer;
    FVisible: Boolean;
    procedure SetDataStruct(const Value: TMTDataStructEh);
    function GetIndex: Integer;
    procedure SetIndex(const Value: Integer);
    function IsDisplayWidthStored: Boolean;
{$IFDEF CIL}
{$ELSE}
    function GetName: String;
{$ENDIF}
  protected
    FVarDataType: TVarType;
    function DefaultSize: Integer; virtual;
    function DefaultAlignment: TAlignment; virtual;
    function DefValueForDefaultExpression: String; virtual;
    function DefaultDisplayLabel: String; virtual;
    function DefaultDisplayWidth: Integer; virtual;
    function DefaultEditMask: String; virtual;
    function DefaultRequired: Boolean; virtual;
    function DefaultVisible: Boolean; virtual;
    function GetAlignment: TAlignment; virtual;
    function GetAutoIncrement: Boolean; virtual;
    function GetDataType: TFieldType; virtual;
    function GetDefaultExpression: String; virtual;
    function GetDefaultWidth: Integer; virtual;
    function GetDisplayLabel: String; virtual;
    function GetDisplayWidth: Integer; virtual;
    function GetEditMask: String; virtual;
    function GetFieldName: String; virtual;
    function GetReadOnly: Boolean; virtual;
    function GetRequired: Boolean; virtual;
    function GetSize: Integer; virtual;
    function GetVisible: Boolean; virtual;
    function CreateUniqueName(const FieldName: string): string;
    procedure SetAlignment(const Value: TAlignment); virtual;
    procedure SetAutoIncrement(const Value: Boolean); virtual;
    procedure SetDefaultExpression(const Value: String); virtual;
    procedure SetDisplayLabel(const Value: String); virtual;
    procedure SetDisplayWidth(const Value: Integer); virtual;
    procedure SetEditMask(const Value: String); virtual;
    procedure SetFieldName(const Value: String); virtual;
    procedure SetReadOnly(const Value: Boolean); virtual;
    procedure SetRequired(const Value: Boolean); virtual;
    procedure SetSize(const Value: Integer); virtual;
    procedure SetVisible(const Value: Boolean); virtual;

    procedure CheckInactive;

{$IFNDEF CIL}
    procedure SetParentComponent(AParent: TComponent); override;
{$ENDIF}
    procedure ReadState(Reader: TReader); override;

    procedure PropertyChanged;
    property GUID: String read FGUID;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function GetParentComponent: TComponent; override;
    function HasParent: Boolean; override;
    function CanDinaSize: Boolean; virtual;
    function GetVarDataType: TVarType; virtual;
    procedure Assign(Source: TPersistent); override;
    procedure AssignDataType(FieldType: TFieldType); virtual;
    procedure AssignProps(Field: TField); virtual;
    procedure AssignPropsTo(Field: TField); virtual;
{$IFDEF CIL}
    procedure SetParentComponent(AParent: TComponent); override;
{$ENDIF}
    procedure WriteDataToWriter(var Value: Variant; Writer: TWriter); virtual;
    procedure ReadDataFromReader(var Value: Variant; Reader: TReader); virtual;

    property DataStruct: TMTDataStructEh read FDataStruct write SetDataStruct;
    property DataType: TFieldType read GetDataType;
    property Size: Integer read GetSize write SetSize;

    property AutoIncrement: Boolean read GetAutoIncrement write SetAutoIncrement;
    property Alignment: TAlignment read GetAlignment write SetAlignment default taLeftJustify;
    property DefaultExpression: String read GetDefaultExpression write SetDefaultExpression;
    property DisplayLabel: String read GetDisplayLabel write SetDisplayLabel;
    property DisplayWidth: Integer read GetDisplayWidth write SetDisplayWidth stored IsDisplayWidthStored;
    property EditMask: String read GetEditMask write SetEditMask;
    property Required: Boolean read GetRequired write SetRequired default False;
    property Visible: Boolean read GetVisible write SetVisible default True;
    property Index: Integer read GetIndex write SetIndex;

  published
{$IFDEF CIL}
{$ELSE}
    property Name: String read GetName;
{$ENDIF}
    property FieldName: String read GetFieldName write SetFieldName;
  end;

  TStringDataFieldTypesEh = (fdtStringEh, fdtFixedCharEh,
    fdtWideStringEh, fdtGuidEh
{$IFDEF EH_LIB_10}
    , fdtFixedWideCharEh, fdtOraIntervalEh
{$ENDIF}
    );

  TMTDataFieldClassEh = class of TMTDataFieldEh;

{ TMTStringDataFieldEh }

  TMTStringDataFieldEh = class(TMTDataFieldEh)
  private
    FFixedChar: Boolean;
    FTransliterate: Boolean;
    FStringDataType: TStringDataFieldTypesEh;
    procedure SetStringDataType(const Value: TStringDataFieldTypesEh);
  protected
    function DefaultSize: Integer; override;
    function GetDataType: TFieldType; override;
  public
    constructor Create(AOwner: TComponent); override;
    function CanDinaSize: Boolean; override;
    function GetDefaultWidth: Integer; override;
    procedure AssignProps(Field: TField); override;
    procedure AssignPropsTo(Field: TField); override;
    procedure AssignDataType(FieldType: TFieldType); override;
    procedure Assign(Source: TPersistent); override;
  published
    property StringDataType: TStringDataFieldTypesEh read FStringDataType write SetStringDataType;
    property Alignment;
    property DefaultExpression;
    property DisplayLabel;
    property DisplayWidth;
    property EditMask;
    property Required;
    property Visible;

    property FixedChar: Boolean read FFixedChar write FFixedChar default False;
    property Size default 20;
    property Transliterate: Boolean read FTransliterate write FTransliterate default False;

  end;

  TNumericDataFieldTypesEh = (fdtSmallintEh, fdtIntegerEh, fdtWordEh,
    fdtFloatEh, fdtCurrencyEh, fdtBCDEh, fdtAutoIncEh, fdtLargeintEh
{$IFDEF EH_LIB_6}
    ,fdtFMTBcdEh
{$ENDIF}
{$IFDEF EH_LIB_12}
    ,fdtLongWordEh, fdtShortintEh, fdtByteEh, fdtExtendedEh
{$ENDIF}
    );

{ TMTNumericDataFieldEh }

  TMTNumericDataFieldEh = class(TMTDataFieldEh)
  private
    FDisplayFormat: string;
    FEditFormat: string;
    FCurrency: Boolean;
    FMaxValue: Double;
    FMinValue: Double;
    FPrecision: Integer;
    FNumericDataType: TNumericDataFieldTypesEh;
    procedure SetCurrency(const Value: Boolean);
    procedure SetDisplayFormat(const Value: string);
    procedure SetEditFormat(const Value: string);
    procedure SetMaxValue(const Value: Double);
    procedure SetMinValue(const Value: Double);
    procedure SetPrecision(const Value: Integer);
    procedure SetNumericDataType(const Value: TNumericDataFieldTypesEh);
    procedure SetScale(const Value: Integer);
    function GetScale: Integer;
    function IsScaleStored: Boolean;
  protected
    function DefaultAlignment: TAlignment; override;
    function GetDataType: TFieldType; override;
    function GetDefaultWidth: Integer; override;
    function DefaultSize: Integer; override;
  public
    constructor Create(AOwner: TComponent); override;
    function CanDinaSize: Boolean; override;
    procedure AssignProps(Field: TField); override;
    procedure AssignPropsTo(Field: TField); override;
    procedure AssignDataType(FieldType: TFieldType); override;
    procedure Assign(Source: TPersistent); override;
  published
    property NumericDataType: TNumericDataFieldTypesEh read FNumericDataType write SetNumericDataType;
    property AutoIncrement;
    property Alignment default taRightJustify;
    property DefaultExpression;
    property DisplayLabel;
    property DisplayWidth;
    property EditMask;
    property Required;
    property Visible;

    property DisplayFormat: string read FDisplayFormat write SetDisplayFormat;
    property EditFormat: string read FEditFormat write SetEditFormat;
    property currency: Boolean read FCurrency write SetCurrency;
    property MaxValue: Double read FMaxValue write SetMaxValue;
    property MinValue: Double read FMinValue write SetMinValue;
    property Precision: Integer read FPrecision write SetPrecision;
    property Scale: Integer read GetScale write SetScale stored IsScaleStored;
  end;

  TDateTimeDataFieldTypesEh = (fdtDateEh, fdtTimeEh, fdtDateTimeEh
//{$IFDEF EH_LIB_6}
//   ,fdtTimeStampEh
//{$ENDIF}
   );

{ TMTDateTimeDataFieldEh }

  TMTDateTimeDataFieldEh = class(TMTDataFieldEh)
  private
    FDisplayFormat: string;
    FDateTimeDataType: TDateTimeDataFieldTypesEh;
    procedure SetDateTimeDataType(const Value: TDateTimeDataFieldTypesEh);
  protected
    function GetDataType: TFieldType; override;
    function GetDefaultWidth: Integer; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure AssignProps(Field: TField); override;
    procedure AssignPropsTo(Field: TField); override;
    procedure AssignDataType(FieldType: TFieldType); override;
    procedure Assign(Source: TPersistent); override;
  published
    property DateTimeDataType: TDateTimeDataFieldTypesEh read FDateTimeDataType write SetDateTimeDataType;
    property Alignment;
    property DefaultExpression;
    property DisplayLabel;
    property DisplayWidth;
    property EditMask;
    property Required;
    property Visible;

    property DisplayFormat: string read FDisplayFormat write FDisplayFormat;
  end;

{ TMTBlobDataFieldEh }

  TMTBlobDataFieldEh = class(TMTDataFieldEh)
  private
    FGraphicHeader: Boolean;
    FTransliterate: Boolean;
    FBlobType: TBlobType;
    procedure SetBlobType(const Value: TBlobType);
    procedure SetGraphicHeader(const Value: Boolean);
    procedure SetTransliterate(const Value: Boolean);
  protected
    function GetDataType: TFieldType; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure AssignProps(Field: TField); override;
    procedure AssignPropsTo(Field: TField); override;
    procedure AssignDataType(FieldType: TFieldType); override;
    procedure Assign(Source: TPersistent); override;
  published
    property Alignment;
    property DefaultExpression;
    property DisplayLabel;
    property DisplayWidth;
    property EditMask;
    property Required;
    property Visible;

    property BlobType: TBlobType read FBlobType write SetBlobType;
    property GraphicHeader: Boolean read FGraphicHeader write SetGraphicHeader;
    property Transliterate: Boolean read FTransliterate write SetTransliterate;
  end;

{ TMTBooleanDataFieldEh }

  TMTBooleanDataFieldEh = class(TMTDataFieldEh)
  private
    FDisplayValues: string;
    procedure SetDisplayValues(const Value: string);
  protected
    function GetDataType: TFieldType; override;
    function GetDefaultWidth: Integer; override;
  public
    procedure AssignProps(Field: TField); override;
    procedure AssignPropsTo(Field: TField); override;
    procedure Assign(Source: TPersistent); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure AssignDataType(FieldType: TFieldType); override;
  published
    property Alignment;
    property DefaultExpression;
    property DisplayLabel;
    property DisplayWidth;
    property EditMask;
    property Required;
    property Visible;

    property DisplayValues: string read FDisplayValues write SetDisplayValues;
  end;

  { TMTInterfaceDataFieldEh }

  TInterfaceDataFieldTypesEh = (fdtInterfaceEh, fdtIDispatchEh);

  TMTInterfaceDataFieldEh = class(TMTDataFieldEh)
  private
    FInterfaceDataType: TInterfaceDataFieldTypesEh;
    procedure SetInterfaceDataType(const Value: TInterfaceDataFieldTypesEh);
  protected
    function GetDataType: TFieldType; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure AssignDataType(FieldType: TFieldType); override;
  published
    property Alignment;
    property DefaultExpression;
    property DisplayLabel;
    property DisplayWidth;
    property InterfaceDataType: TInterfaceDataFieldTypesEh read FInterfaceDataType write SetInterfaceDataType;
    property Required;
    property Visible;
  end;

  { TMTVariantDataFieldEh }

  TVariantDataFieldTypesEh = (fdtVariant, fdtBytes, fdtVarBytes);

  TMTVariantDataFieldEh = class(TMTDataFieldEh)
  private
    FVariantDataType: TVariantDataFieldTypesEh;
    procedure SetVariantDataType(const Value: TVariantDataFieldTypesEh);
  protected
    function GetDataType: TFieldType; override;
  public
    constructor Create(AOwner: TComponent); override;
    function CanDinaSize: Boolean; override;
    function GetDefaultWidth: Integer; override;
    procedure AssignDataType(FieldType: TFieldType); override;
    function IsSizeStored: Boolean;
  published
    property Alignment;
    property DefaultExpression;
    property DisplayLabel;
    property DisplayWidth;
    property VariantDataType: TVariantDataFieldTypesEh read FVariantDataType write SetVariantDataType;
    property Required;
    property Size stored IsSizeStored;
    property Visible;
  end;

  { TMTRefObjectFieldEh }

  TMTRefObjectFieldEh = class(TMTDataFieldEh)
  protected
    function GetDataType: TFieldType; override;
  public
    constructor Create(AOwner: TComponent); override;
    function CanDinaSize: Boolean; override;
    function GetVarDataType: TVarType; override;
    procedure AssignDataType(FieldType: TFieldType); override;
  published
    property Alignment;
    property DisplayLabel;
    property DisplayWidth;
    property Required;
    property Visible;
  end;



{$IFDEF EH_LIB_6}

  TSQLTimeStampDataFieldTypesEh = (fdtTimeStampEh
{$IFDEF EH_LIB_10}
   ,fdtOraTimeStampEh
{$ENDIF}
   );

{ TMTSQLTimeStampDataFieldEh }

  TMTSQLTimeStampDataFieldEh = class(TMTDataFieldEh)
  private
    FDisplayFormat: string;
    FSQLTimeStampDataFieldType: TSQLTimeStampDataFieldTypesEh;
  protected
    function GetDataType: TFieldType; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Assign(Source: TPersistent); override;
    procedure AssignDataType(FieldType: TFieldType); override;
    procedure AssignProps(Field: TField); override;
    procedure AssignPropsTo(Field: TField); override;
  published
    property SQLTimeStampDataFieldType: TSQLTimeStampDataFieldTypesEh read FSQLTimeStampDataFieldType write FSQLTimeStampDataFieldType;
    property Alignment;
    property DefaultExpression;
    property DisplayLabel;
    property DisplayWidth;
    property EditMask;
    property Required;
    property Visible;

    property DisplayFormat: string read FDisplayFormat write FDisplayFormat;
  end;

{$ENDIF}

{ TMTDataStructEh }

  TMTDataStructEh = class(TComponent)
  private
    FList: TObjectList;
    FMemTableData: TMemTableDataEh;
    FNextFieldId: Largeint;
    FStructChanged: Boolean;
    FOnStructChanged: TNotifyEvent;
    FUpdateCount: Integer;
    function GetCount: Integer;
    function GetDataField(Index: Integer): TMTDataFieldEh;
  protected
    function GetChildOwner: TComponent; override;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    procedure FieldPropertyChanged;
    procedure ConvertRecordsData(NewDataStruct: TMTDataStructEh);
  public
    constructor Create(AMemTableData: TMemTableDataEh); reintroduce;
    destructor Destroy; override;
    procedure StructChanged;
    procedure ClearStructChanged;

    function BeginRestructure: TMTDataStructEh;
    function CreateField(FieldClass: TMTDataFieldClassEh): TMTDataFieldEh;
    function ChangeFieldType(const FieldName: string; FieldClass: TMTDataFieldClassEh): TMTDataFieldEh;
    function FieldByName(const FieldName: string): TMTDataFieldEh;
    function FieldIndex(const FieldName: string): Integer;
    function FieldsIndex(const FieldNames: string): TIntArray;
    function FindField(const FieldName: string): TMTDataFieldEh;
    function FindFieldByGIUD(const GUID: string): TMTDataFieldEh;
    function GetCopy: TMTDataStructEh;
    procedure Assign(Source: TPersistent); override;
    procedure BuildFieldDefsFromStruct(FieldDefs: TFieldDefs);
    procedure BuildStructFromFieldDefs(FieldDefs: TFieldDefs);
    procedure BuildStructFromFields(Fields: TFields);
    procedure BeginUpdate;
    procedure EndRestructure(NewStrcuture: TMTDataStructEh; ApplyNewStrcuture: Boolean);
    procedure EndUpdate(AStructChanged: Boolean);
    procedure CheckFieldName(const FieldName: string);
    procedure Clear;
    procedure GetFieldList(List: TObjectList; const FieldNames: string);
    procedure InsertField(Field: TMTDataFieldEh);
    procedure RemoveField(Field: TMTDataFieldEh);
    function BuildAndCopyDataFieldForField(AField: TField): TMTDataFieldEh;
    function BuildDataFieldForField(AField: TField): TMTDataFieldEh;
    function BuildDataFieldForFieldDef(AFieldDef: TFieldDef): TMTDataFieldEh;
    function BuildDataFieldForDef(const Name: string; DataType: TFieldType; Size, Precision: Integer): TMTDataFieldEh;

    property Count: Integer read GetCount;
    property DataFields[Index: Integer]: TMTDataFieldEh read GetDataField; default;
    property MemTableData: TMemTableDataEh read FMemTableData;
    property OnStructChanged: TNotifyEvent read FOnStructChanged write FOnStructChanged;
  end;


  TRecordsListEh = class;

// MemoryRecords

  TRecDataValues = array of Variant;
  PRecValues = ^TRecDataValues;

  TMemBlobData = Variant;
  TCompareRecords = function (Rec1, Rec2: TMemoryRecordEh; ParamSort: TObject): Integer of object;

  TRecordsListNotification =
    (rlnRecAddingEh, rlnRecAddedEh,
     rlnRecChangingEh, rlnRecChangedEh,
     rlnRecDeletingEh, rlnRecDeletedEh,
     rlnListChangingEh, rlnListChangedEh,
     rlnRecMarkingForDelEh, rlnRecMarkedForDelEh);

  TRecordsListNotificatorDataEventEh =
    procedure (MemRec: TMemoryRecordEh; Index: Integer; Action: TRecordsListNotification) of object;

//  TRecIdEh = LongWord;

  TDataValueVersionEh = (dvvOldValueEh, dvvCurValueEh, dvvEditValueEh, dvvValueEh,
    dvvOldestValue, dvvRefreshValue);
  TRecordEditStateEh = (resBrowseEh, resEditEh, resInsertEh, resEditForRefresh);

{ TMemoryRecordEh }

  TMemoryRecordEh = class(TPersistent)
  private
//    FChangeCount: Integer;
//    FMemoryData: TCustomMemTableEh;
    FData: TRecDataValues;
    FEditChanged: Boolean;
    FEditState: TRecordEditStateEh;
    FHashCode: LongWord;
    FIndex: Integer;
    FOldData: TRecDataValues;
    FRecordsList: TRecordsListEh;
    FDataStruct: TMTDataStructEh;
    FTmpOldRecValue: TRecDataValues;
    FUpdateError: TUpdateErrorEh;
    FUpdateIndex: Integer;
    FUpdateStatus: TUpdateStatus;
    function GetAttached: Boolean;
    function GetDataIndexValues(const FieldIndexes: TIntArray; DataValueVersion: TDataValueVersionEh): Variant;
    function GetDataStruct: TMTDataStructEh; {$IFDEF EH_LIB_8} inline;{$ENDIF}
    function GetDataValue(const FieldIndex: Integer; DataValueVersion: TDataValueVersionEh): Variant;
    function GetDataValues(const FieldNames: string; DataValueVersion: TDataValueVersionEh): Variant;
    function GetIndex: Integer;
    procedure SetDataIndexValues(const FieldIndexes: TIntArray; DataValueVersion: TDataValueVersionEh; const VarValue: Variant);
    procedure SetDataValue(const FieldIndex: Integer; DataValueVersion: TDataValueVersionEh; const Value: Variant);
    procedure SetDataValues(const FieldNames: string; DataValueVersion: TDataValueVersionEh; const VarValue: Variant);
    procedure SetUpdateStatus(const Value: TUpdateStatus);
  protected
    procedure ReadData(Reader: TReader);
    procedure SetIndex(Value: Integer);
    procedure WriteData(Writer: TWriter);
    property Data: TRecDataValues read FData;
  public
    constructor Create;
    destructor Destroy; override;
//    procedure BeginEdit;
//    procedure EndEdit(Changed: Boolean);
    function EditState: TRecordEditStateEh;
    procedure Cancel;
    procedure Edit;
    procedure EditForRefresh;
    procedure MergeChanges;
    procedure Post;
    procedure RefreshRecord(Rec: TMemoryRecordEh);
    procedure RevertRecord;
    property Index: Integer read GetIndex;
    property Attached: Boolean read GetAttached;
    property DataValues[const FieldNames: string; DataValueVersion: TDataValueVersionEh]:
      Variant read GetDataValues write SetDataValues;
    property DataIndexValues[const FieldIndexes: TIntArray; DataValueVersion: TDataValueVersionEh]:
      Variant read GetDataIndexValues write SetDataIndexValues;
    property Value[const FieldIndex: Integer; DataValueVersion: TDataValueVersionEh]:
      Variant read GetDataValue write SetDataValue;
//    property MemoryData: TCustomMemTableEh read FMemoryData;
    property DataStruct: TMTDataStructEh read GetDataStruct;
    property HashCode: LongWord read FHashCode;
    property OldData: TRecDataValues read FOldData;
    property RecordsList: TRecordsListEh read FRecordsList;
    property UpdateError: TUpdateErrorEh read FUpdateError write FUpdateError;
    property UpdateIndex: Integer read FUpdateIndex write FUpdateIndex;
    property UpdateStatus: TUpdateStatus read FUpdateStatus write SetUpdateStatus;
  end;

  TMemoryRecordEhClass = class of TMemoryRecordEh;

  TRecordsListFetchRecordsEventEh = function (Count: Integer): Integer of object;
  TRecordsListApplyUpdatesEventEh = procedure (AMemTableData: TMemTableDataEh) of object;
  TRecordsListRecordMovedEventEh = procedure (Item: TMemoryRecordEh; OldIndex, NewIndex: Integer) of object;
  TRecordsListCalcLookupBufferEventEh = procedure (Item: TMemoryRecordEh; RecView: TMemRecViewEh) of object;

{ TRecordsListNotificatorEh }

  TRecordsListNotificatorEh = class(TComponent)
  private
//    FRecordsList: TRecordsListEh;
//    procedure SetRecordsList(const Value: TRecordsListEh);
    FMemTableData: TMemTableDataEh;
    FOnAfterDataEvent: TRecordsListNotificatorDataEventEh;
    FOnApplyUpdates: TRecordsListApplyUpdatesEventEh;
    FOnDataEvent: TRecordsListNotificatorDataEventEh;
    FOnFetchRecords: TRecordsListFetchRecordsEventEh;
    FOnRecordMoved: TRecordsListRecordMovedEventEh;
    FDataObject: TComponent;
    FOnStructChanged: TRecordsListApplyUpdatesEventEh;
    procedure SetMemTableData(const Value: TMemTableDataEh);
    procedure SetDataObject(const Value: TComponent);
  protected
    function FetchRecords(Count: Integer): Integer; virtual;
    procedure AfterDataEvent(MemRec: TMemoryRecordEh; Index: Integer; Action: TRecordsListNotification); virtual;
    procedure ApplyUpdates(AMemTableData: TMemTableDataEh);
    procedure DataEvent(MemRec: TMemoryRecordEh; Index: Integer; Action: TRecordsListNotification); virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure RecordAdded(MemRec: TMemoryRecordEh; Index: Integer); virtual;
    procedure RecordChanged(MemRec: TMemoryRecordEh; Index: Integer); virtual;
    procedure RecordDeleted(MemRec: TMemoryRecordEh; Index: Integer); virtual;
    procedure RecordListChanged; virtual;
    procedure RecordMoved(Item: TMemoryRecordEh; OldIndex, NewIndex: Integer); virtual;
    procedure StructChanged(AMemTableData: TMemTableDataEh); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
//    property RecordsList: TRecordsListEh read FRecordsList write SetRecordsList;
//    property MemTableData: TMemTableDataEh read FMemTableData write SetMemTableData;
    property DataObject: TComponent read FDataObject write SetDataObject;
    property OnAfterDataEvent: TRecordsListNotificatorDataEventEh read FOnAfterDataEvent write FOnAfterDataEvent;
    property OnApplyUpdates: TRecordsListApplyUpdatesEventEh read FOnApplyUpdates write FOnApplyUpdates;
    property OnDataEvent: TRecordsListNotificatorDataEventEh read FOnDataEvent write FOnDataEvent;
    property OnFetchRecords: TRecordsListFetchRecordsEventEh read FOnFetchRecords write FOnFetchRecords;
    property OnRecordMoved: TRecordsListRecordMovedEventEh read FOnRecordMoved write FOnRecordMoved;
    property OnStructChanged: TRecordsListApplyUpdatesEventEh read FOnStructChanged write FOnStructChanged;
  end;

  TMTIndexEh = class;
  TMTIndexesEh = class;

  {TRecordsListEh}

  TRecordsListEh = class(TComponent)
  private
//    FNotificators: TObjectList;
    FCachedUpdates: Boolean;
    FDeletedList: TObjectList;
    FDeltaList: TObjectList;
    FIndexes: TMTIndexesEh;
    FItemClass: TMemoryRecordEhClass;
    FMemTableData: TMemTableDataEh;
    FNewHashCode: LongWord;
    FRecList: TObjectList;
    FUpdateCount: Integer;
    function GeRecValCount: Integer;
    function GetCount: Integer;
    function GetDataStruct: TMTDataStructEh;
    function GetRec(Index: Integer): TMemoryRecordEh;
    function GetValue(RecNo, ValNo: Integer): Variant;
    function IsEmpty: Boolean;
    procedure ReadData(Reader: TReader);
    procedure SetCachedUpdates(const Value: Boolean);
    procedure SetRec(Index: Integer; const Value: TMemoryRecordEh);
    procedure SetValue(RecNo, ValNo: Integer; const Value: Variant);
    procedure WriteData(Writer: TWriter);
  protected
//    procedure AddNotificator(RecordsList: TRecordsListNotificatorEh);
//    procedure RemoveNotificator(RecordsList: TRecordsListNotificatorEh);
    function AddInsertRecord(Rec: TMemoryRecordEh; Index: Integer; Append: Boolean; Fetching: Boolean): Integer;
    function Delete(Index: Integer): TMemoryRecordEh;
    function NewHashCode: LongWord;
    procedure ApplyUpdateFor(Rec: TMemoryRecordEh; UpdateStatus: TUpdateStatus);
    procedure ApplyUpdates(AMemTableData: TMemTableDataEh);
    procedure DefineProperties(Filer: TFiler); override;
    procedure InitRecord(RecValues: TRecDataValues);
    procedure Notify(MemRec: TMemoryRecordEh; Index: Integer; Action: TRecordsListNotification); reintroduce; virtual;
    procedure RecordMoved(Item: TMemoryRecordEh; OldIndex, NewIndex: Integer); virtual;
    procedure ReIndexRecs(FromIndex, ToIndex: Integer);
    procedure CheckForDestroyRecord(Rec: TMemoryRecordEh);
    procedure FreeDeletedRecords;
  public
    constructor Create(AOwner: TComponent); override;
//    constructor Create(AMemTableData: TMemTableDataEh); reintroduce;
    destructor Destroy; override;

    function AddRecord(Rec: TMemoryRecordEh): Integer;
    function FetchRecord(Rec: TMemoryRecordEh): Integer;
    function HasCachedChanges: Boolean;
    function IndexOf(Item: TMemoryRecordEh): Integer;
    function NewRecord: TMemoryRecordEh;
    procedure BeginUpdate; virtual;
    procedure CancelUpdates;
    procedure CleanupChangedRecs;
    procedure Clear;
    procedure DeleteRecord(Index: Integer);
    procedure DeleteRecords(const RecordsRanges: array of TRecordsRangeEh);
    procedure EndUpdate; virtual;
    procedure InsertRecord(Index: Integer; Rec: TMemoryRecordEh);
    procedure MergeChangeLog;
    procedure Move(CurIndex, NewIndex: Integer);
    procedure PersistDeleteRecord(Index: Integer);
    procedure PersistDeleteRecords(const RecordsRanges: array of TRecordsRangeEh);
    procedure PersistRemoveRecord(Index: Integer);
    procedure QuickSort(L, R: Integer; Compare: TCompareRecords; ParamSort: TObject);
    procedure RefreshRecord(Index: Integer; FromRec: TMemoryRecordEh);
    procedure RevertRecord(Index: Integer);
    procedure SetAutoIncValue(Rec: TMemoryRecordEh);
    procedure SortData(Compare: TCompareRecords; ParamSort: TObject);
//    property RecValues[RecNo: Integer]: TRecDataValues read GetRecValues write SetRecValues;
    property CachedUpdates: Boolean read FCachedUpdates write SetCachedUpdates;
    property Count: Integer read GetCount;
    property DataStruct: TMTDataStructEh read GetDataStruct;
    property DeltaList: TObjectList read FDeltaList;
    property Indexes: TMTIndexesEh read FIndexes;
    property MemTableData: TMemTableDataEh read FMemTableData;
    property Rec[Index: Integer]: TMemoryRecordEh read GetRec write SetRec; default;
    property RecValCount: Integer read GeRecValCount;// write SetRecValCount;
    property Value[RecNo, ValNo: Integer]: Variant read GetValue write SetValue;
  end;

{ TMemTableDataEh }

  TMemTableDataEh = class(TComponent)
  private
    FAutoIncrement: TAutoIncrementEh;
    FDataStruct: TMTDataStructEh;
    FIncFieldIndexes: TIntArray;
    FNewDataStruct: TMTDataStructEh;
    FNotificators: TObjectList;
    FRecordsList: TRecordsListEh;
    FRestructMode: Boolean;
    FStoreStructInStream: Boolean;
    FStoreRecordsInStream: Boolean;
    function GetIsEmpty: Boolean;
    procedure AncestorNotFound(Reader: TReader; const ComponentName: string; ComponentClass: TPersistentClass; var Component: TComponent);
    procedure CreateComponent(Reader: TReader; ComponentClass: TComponentClass; var Component: TComponent);
    procedure ReadAutoIncCurValue(Reader: TReader);
    procedure WriteAutoIncCurValue(Writer: TWriter);
  protected
    function CheckApplyUpdatesConsumers: Boolean;
    function GetAutoIncrement: TAutoIncrementEh; virtual;
    function GetDataStruct: TMTDataStructEh; virtual;
    function GetRecordsList: TRecordsListEh; virtual;
    procedure AddNotificator(RecordsList: TRecordsListNotificatorEh); virtual;
    procedure ApplyUpdates(AMemTableData: TMemTableDataEh); virtual;
    procedure CheckInactive;  virtual;
    procedure DefineProperties(Filer: TFiler); override;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    procedure Notify(MemRec: TMemoryRecordEh; Index: Integer; Action: TRecordsListNotification); reintroduce; virtual;
    procedure ReadState(Reader: TReader); override;
    procedure RecordMoved(Item: TMemoryRecordEh; OldIndex, NewIndex: Integer); virtual;
    procedure RemoveNotificator(RecordsList: TRecordsListNotificatorEh);
    procedure Restruct;
    procedure SetAutoIncrement(const Value: TAutoIncrementEh); virtual;
    procedure SetAutoIncValue(Rec: TMemoryRecordEh); virtual;
    procedure StructChanged; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function BeginRestruct: TMTDataStructEh; virtual;
    function FetchRecords(Count: Integer): Integer; virtual;
    procedure CancelRestruct; virtual;
    procedure CommitRestruct; virtual;
    procedure DestroyTable; virtual;
    procedure ResetRecords; virtual;

    property AutoIncrement: TAutoIncrementEh read GetAutoIncrement write SetAutoIncrement;
    property DataStruct: TMTDataStructEh read GetDataStruct;
    property IsEmpty: Boolean read GetIsEmpty;
    property RecordsList: TRecordsListEh read GetRecordsList;
    property StoreStructInStream: Boolean read FStoreStructInStream write FStoreStructInStream;
    property StoreRecordsInStream: Boolean read FStoreRecordsInStream write FStoreRecordsInStream;
  end;

{ TMemTableDataShadowEh }

  TMemTableDataShadowEh = class(TMemTableDataEh)
  private
    FMasterTable: TMemTableDataEh;
  protected
    function GetDataStruct: TMTDataStructEh; override;
    procedure SetAutoIncValue(Rec: TMemoryRecordEh); override;
  public
    constructor Create(AMasterTable: TMemTableDataEh); reintroduce; virtual;
    destructor Destroy; override;
  end;

{ TIndexItemEh }

  TIndexItemEh = class(TObject)
  public
    Value: Variant;
    RecIndex: Integer;
    constructor Create(AValue: Variant; ARecIndex: Integer);
  end;

{ TMTIndexEh }

  EUnicalKeyViolationEh = EDatabaseError;

  TMTIndexEh = class(TCollectionItem)
  private
    FActive: Boolean;
    FFields: String;
    FOldValue: Variant;
    FPrimary: Boolean;
    FRecList: TObjectList;
    FRecordsList: TRecordsListEh;
    FUnical: Boolean;
    function GetItems(Index: Integer): TIndexItemEh;
    function GetKeyValue(Index: Integer): Variant;
    procedure SetActive(const Value: Boolean);
    procedure SetFields(const Value: String);
    procedure SetKeyValue(Index: Integer; const Value: Variant);
    procedure SetPrimary(const Value: Boolean);
    procedure SetUnical(const Value: Boolean);
  protected
    property RecList: TObjectList read FRecList;
    procedure RLDataEvent(MemRec: TMemoryRecordEh; Index: Integer; Action: TRecordsListNotification);
    procedure RecordMoved(Item: TMemoryRecordEh; OldIndex, NewIndex: Integer); virtual;
    procedure InsertIndexItemForValue(InitIndex: Integer; Value: Variant; IndexItem: TIndexItemEh); virtual;
  public
    constructor Create(Collection: TCollection); override;
    constructor CreateApart(ARecordsList: TRecordsListEh);
    destructor Destroy; override;
    function Count: Integer;
    function FindKeyValueIndex(Value: Variant; var Index: Integer): Boolean;
    function FindRecordIndexByKey(Value: Variant; var Index: Integer): Boolean;
    function RecordsList: TRecordsListEh;
    procedure ClearIndex;
    procedure FillMatchedKeyList(Value: Variant; List: TObjectList);
    procedure FillMatchedRecsList(Value: Variant; List: TObjectList);
    procedure QuickSort(L, R: Integer);
    procedure RebuildIndex;
    property Active: Boolean read FActive write SetActive default False;
    property Fields: String read FFields write SetFields;
    property Item[Index: Integer]: TIndexItemEh read GetItems;
    property KeyValue[Index: Integer]: Variant read GetKeyValue;
    property Primary: Boolean read FPrimary write SetPrimary default False;
    property Unical: Boolean read FUnical write SetUnical default False;
  end;

{ TMTIndexesEh }

  TMTIndexesEh = class(TCollection)
  private
    FRecList: TRecordsListEh;
    function GetItem(Index: Integer): TMTIndexEh;
    procedure SetItem(Index: Integer; const Value: TMTIndexEh);
  protected
    procedure RecordMoved(Item: TMemoryRecordEh; OldIndex, NewIndex: Integer); virtual;
    procedure RLDataEvent(MemRec: TMemoryRecordEh; Index: Integer; Action: TRecordsListNotification);
  public
    constructor Create(ARecList: TRecordsListEh);
    destructor Destroy; override;
    function Add: TMTIndexEh;
    function GetIndexForFields(const Fields: String): TMTIndexEh;
    property Items[Index: Integer]: TMTIndexEh read GetItem write SetItem;
  end;

{ TMTAggregateEh }

  TMTAggregatesEh = class;

  TMTAggregateEh = class(TCollectionItem)
  private
    FActive: Boolean;
    FAggrExpr: TDataSetExprParserEh;
    FDataSet: TDataSet;
    FDataType: TFieldType;
    FExpression: string;
    FInUse: Boolean;
    FValue: Variant;
    procedure SetActive(Value: Boolean);
    procedure SetExpression(const Text: string);
  public
    constructor Create(Aggregates: TMTAggregatesEh; ADataSet: TDataSet); reintroduce; overload;
    destructor Destroy; override;
    function Aggregates: TMTAggregatesEh;
    function GetDisplayName: string; override;
    function Value: Variant;
    procedure Assign(Source: TPersistent); override;
    procedure Recalc;
    procedure Reset;
    property DataSet: TDataSet read FDataSet;
    property DataType: TFieldType read FDataType;
  published
    property Active: Boolean read FActive write SetActive default False;
    property Expression: string read FExpression write SetExpression;
  end;

{ TMTAggregatesEh }

  TMTAggregatesEh = class(TCollection)
  private
    FActive: Boolean;
    FOwner: TPersistent;
    function GetItem(Index: Integer): TMTAggregateEh;
    procedure SetActive(const Value: Boolean);
    procedure SetItem(Index: Integer; Value: TMTAggregateEh);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(Owner: TPersistent);
    function Add: TMTAggregateEh;
    function DataSet: TDataSet;
    procedure Clear;
    procedure Recalc;
    procedure Reset;
    property Active: Boolean read FActive write SetActive;
    property Items[Index: Integer]: TMTAggregateEh read GetItem write SetItem; default;
    property UpdateCount;
  end;

  TMemoryTreeListEh = class;

  { TMemoryTreeListOrderByList }

  TMemoryTreeListOrderByList = class(TOrderByList)
  protected
    FTreeList: TMemoryTreeListEh;
    function FindFieldIndex(const FieldName: String): Integer; override;
  public
    constructor Create(ATreeList: TMemoryTreeListEh);
  end;

{ TMemRecViewEh }

  TMemRecViewEh = class(TBaseTreeNodeEh)
  private
    FLookupBuffer: TRecDataValues;
    function GetItem(const Index: Integer): TMemRecViewEh; reintroduce;
    function GetNodeExpanded: Boolean;
    function GetNodeHasChildren: Boolean;
    function GetNodeHasVisibleChildren: Boolean;
    function GetNodeIndex: Integer;
    function GetNodeLevel: Integer;
    function GetNodeOwner: TMemoryTreeListEh;
    function GetNodeParent: TMemRecViewEh;
    function GetNodesCount: Integer;
    function GetNodeVisible: Boolean;
    function GetRec: TMemoryRecordEh; //inline;
    function GetVisibleNodeIndex: Integer;
    function GetVisibleNodeItem(const Index: Integer): TMemRecViewEh;
    function GetVisibleNodesCount: Integer;
    procedure SetNodeExpanded(const Value: Boolean);
    procedure SetNodeHasChildren(const Value: Boolean);
    procedure SetNodeHasVisibleChildren(const Value: Boolean);
    procedure SetNodeParent(const Value: TMemRecViewEh);
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure SetLookupBufferLength(NewLength: Integer);
    procedure SortByFields(const SortByStr: string);

    property LookupBuffer: TRecDataValues read FLookupBuffer;
    property NodeExpanded: Boolean read GetNodeExpanded write SetNodeExpanded;
    property NodeHasChildren: Boolean read GetNodeHasChildren write SetNodeHasChildren;
    property NodeHasVisibleChildren: Boolean read GetNodeHasVisibleChildren write SetNodeHasVisibleChildren;
    property NodeIndex: Integer read GetNodeIndex;
    property NodeItems[const Index: Integer]: TMemRecViewEh read GetItem; default;
    property NodeLevel: Integer read GetNodeLevel;
    property NodeOwner: TMemoryTreeListEh read GetNodeOwner;
    property NodeParent: TMemRecViewEh read GetNodeParent write SetNodeParent;
    property NodesCount: Integer read GetNodesCount;
    property NodeVisible: Boolean read GetNodeVisible;
    property Rec: TMemoryRecordEh read GetRec;
    property VisibleNodeIndex: Integer read GetVisibleNodeIndex;
    property VisibleNodeItems[const Index: Integer]: TMemRecViewEh read GetVisibleNodeItem;
    property VisibleNodesCount: Integer read GetVisibleNodesCount;
  end;

{ TMemoryTreeListEh }

  TMemoryTreeListEh = class(TTreeListEh)
  private
    FDefaultNodeExpanded: Boolean;
    FDefaultNodeHasChildren: Boolean;
    FDefaultParentNode: TMemRecViewEh;
    FFullBuildCheck: Boolean;
    FInsertedNodeStack: TObjectList;
    FVisibleExpandedItems: TObjectList;
    FVisibleItems: TObjectList;
    FVisibleItemsObsolete: Boolean;
    FFilterNodeIfParentVisible: Boolean;
    FSortOrder: String;
    FOrderByList: TMemoryTreeListOrderByList;
    function GetAccountableCount: Integer;
    function GetAccountableItem(const Index: Integer): TMemRecViewEh;
    function GetKeyFieldNames: String;
    function GetParentFieldNames: String;
    function GetSortOrder: String;
    procedure SetSortOrder(const Value: String);
    function GetRoot: TMemRecViewEh;
  protected
    FRecordsViewEh: TRecordsViewEh;
    function GetVisibleCount: Integer;
    function GetVisibleExpandedItem(const Index: Integer): TMemRecViewEh; virtual;
    procedure SetChieldVisibleForVisibleParents(Parent: TMemRecViewEh); virtual;
    procedure SetChieldsVisible(Parent: TMemRecViewEh; Visible: Boolean; ARecurse: Boolean);
    procedure UpdateOrderCaseInsensitive;
  public
    constructor Create(ARecordsViewEh: TRecordsViewEh);
    destructor Destroy; override;
    function AddChild(const Name: string; Parent: TMemRecViewEh; MemRecord: TMemoryRecordEh): TMemRecViewEh;
    function AddChildAtKey(const Name, KeyFieldNames, ParentFieldNames: String; MemRecord: TMemoryRecordEh): TMemRecViewEh;
    function CompareTreeNodes(Rec1, Rec2: TBaseTreeNodeEh; ParamSort: TObject): Integer; override;
    function CheckReferenceLoop(MemRecord: TMemoryRecordEh; NewRefValue: Variant): Boolean;
    function GetChildNodesForKey(StartNode: TMemRecViewEh; const KeyFieldNames: String; const ParentFieldNames: String; MemRecord: TMemoryRecordEh; ChildList: TObjectList): TMemRecViewEh;
    function GetIndexForNode(Rec: TMemoryRecordEh; ParentNode: TMemRecViewEh): Integer;
    function GetNode(StartNode: TMemRecViewEh; MemRecord: TMemoryRecordEh): TMemRecViewEh;
    function GetNodeAtValue(StartNode: TMemRecViewEh; const FieldNames: String; const Value: Variant): TMemRecViewEh;
    function GetParentNodeAtKey(StartNode: TMemRecViewEh; const KeyFieldNames: String; const ParentFieldNames: String; MemRecord: TMemoryRecordEh): TMemRecViewEh;
    function GetParentNodeAtKeyValue(StartNode: TMemRecViewEh; const KeyFieldNames: String; const ParentFieldNames: String; RefKeyValue: Variant): TMemRecViewEh;
    function GetParentNodeForRec(MemRecord: TMemoryRecordEh): TMemRecViewEh;
    function GetParentNodeForRefValue(RefValue: Variant): TMemRecViewEh;
    function UpdateParent(Node: TMemRecViewEh; const KeyFieldNames: String; const ParentFieldNames: String; MemRecord: TMemoryRecordEh; ReIndex: Boolean): TMemRecViewEh;
    function GetNextVisibleSibling(Node: TMemRecViewEh): TMemRecViewEh;
    function GetNext(Node: TMemRecViewEh): TMemRecViewEh;
    function GetPrevious(Node: TMemRecViewEh): TMemRecViewEh;

    procedure BuildVisibleItems;
    procedure GetRecordsList(List: TObjectList; Node: TMemRecViewEh; ARecurse: Boolean = True);
    procedure MoveTo(Node: TBaseTreeNodeEh; Destination: TBaseTreeNodeEh; Mode: TNodeAttachModeEh; ReIndex: Boolean); override;
    procedure Resort; virtual;
    procedure SortData(CompareProg: TCompareNodesEh; ParamSort: TObject; ARecurse: Boolean = True); override;
    procedure UpdateNodesState(Parent: TMemRecViewEh);
    procedure UpdateNodeState(Node: TMemRecViewEh; IsUpdateParent: Boolean);
    procedure VisibleItemsBecomeObsolete;
    procedure Collapse(Node: TMemRecViewEh; Recurse: Boolean);
    procedure Expand(Node: TMemRecViewEh; Recurse: Boolean);

    property AccountableCount: Integer read GetAccountableCount;
    property AccountableItem[const Index: Integer]: TMemRecViewEh read GetAccountableItem;
    property AccountableItems: TObjectList read FVisibleItems;
    property DefaultNodeExpanded: Boolean read FDefaultNodeExpanded write FDefaultNodeExpanded default False;
    property DefaultNodeHasChildren: Boolean read FDefaultNodeHasChildren write FDefaultNodeHasChildren default False;
    property DefaultParentNode: TMemRecViewEh read FDefaultParentNode write FDefaultParentNode;
    property FullBuildCheck: Boolean read FFullBuildCheck write FFullBuildCheck;
    property FilterNodeIfParentVisible: Boolean read FFilterNodeIfParentVisible write FFilterNodeIfParentVisible;
    property KeyFieldNames: String read GetKeyFieldNames;
    property ParentFieldNames: String read GetParentFieldNames;
    property VisibleExpandedCount: Integer read GetVisibleCount;
    property VisibleExpandedItem[const Index: Integer]: TMemRecViewEh read GetVisibleExpandedItem; default;
    property VisibleExpandedItems: TObjectList read FVisibleExpandedItems;
    property VisibleItemsObsolete: Boolean read FVisibleItemsObsolete;
    property SortOrder: String read GetSortOrder write SetSortOrder;
    property Root: TMemRecViewEh read GetRoot;

    property OnExpandedChanged;
    property OnExpandedChanging;
  end;

  { TRecordsViewOrderByList }

  TRecordsViewOrderByList = class(TOrderByList)
  protected
    FRecordsView: TRecordsViewEh;
    function FindFieldIndex(const FieldName: String): Integer; override;
  public
    constructor Create(ARecordsView: TRecordsViewEh);
  end;

{ TRecordsViewEh }
  TRecordsViewFilterEventEh = function (Rec: TMemoryRecordEh; Node: TMemRecViewEh): Boolean of object;
  TParseOrderByStrEventEh = function (const OrderByStr: String): TObject of object;
  TGetPrefilteredListEventEh = function (): TObjectList of object;

//  TRecordsViewEh = class(TPersistent)
  TRecordsViewEh = class(TRecordsListNotificatorEh)
  private
    FAggregates: TMTAggregatesEh;
    FCachedUpdates: Boolean;
    FCachedUpdatesLockCount: Integer;
    FCatchChanged: Boolean;
    FOnCompareRecords: TCompareRecords;
    FOnCompareTreeNode: TCompareNodesEh;
    FOnFilterRecord: TRecordsViewFilterEventEh;
    FOnGetPrefilteredList: TGetPrefilteredListEventEh;
    FOnParseOrderByStr: TParseOrderByStrEventEh;
    FOnViewDataEvent: TRecordsListNotificatorDataEventEh;
    FOnViewRecordMovedEvent: TRecordsListRecordMovedEventEh;
    FOrderByList: TRecordsViewOrderByList;
    FSortOrder: String;
    FTreeViewKeyFieldName: String;
    FTreeViewKeyFields: TIntArray;
    FTreeViewRefParentFieldName: String;
    FTreeViewRefParentFields: TIntArray;
    FViewAsTreeList: Boolean;
    FStatusFilter: TUpdateStatusSet;
    FNotificators: TObjectList;
    FSortOrderCaseInsensitive: Boolean;
    FOnCalcLookupBuffer: TRecordsListCalcLookupBufferEventEh;
    FMemoryTreeList: TMemoryTreeListEh;
    FMemoryViewList: TObjectList;
    function CompareRecords(Rec1, Rec2: TMemoryRecordEh): Integer;
    function GetSortOrder: String;
    function SearchNewPos(SortedList: TObjectList; MemRec: TMemoryRecordEh; OldIndex: Integer): Integer;
    function SearchRec(SortedList: TObjectList; MemRec: TMemoryRecordEh): Integer;
    function GetAccountableRecord(Index: Integer): TMemoryRecordEh;
    function GetCount: Integer;
    function GetOldRecVals(Index: Integer): TRecDataValues;
    function GetRec(Index: Integer): TMemoryRecordEh; //inline;
    function GetStatusFilter: TUpdateStatusSet;
    function GetValue(RecNo, ValNo: Integer): Variant;
    function GetViewAsTreeList: Boolean;
    function GetViewRecord(Index: Integer): TMemoryRecordEh;
    procedure SetRec(Index: Integer; const Value: TMemoryRecordEh);
    procedure SetSortOrder(const Value: String);
    procedure SetStatusFilter(const Value: TUpdateStatusSet);
    procedure SetTreeViewKeyFieldName(const Value: String);
    procedure SetTreeViewRefParentFieldName(const Value: String);
    procedure SetValue(RecNo, ValNo: Integer; const Value: Variant);
    procedure SetViewAsTreeList(const Value: Boolean);
    function GetMemTableData: TMemTableDataEh;
    procedure SetMemTableData(const Value: TMemTableDataEh);
    procedure SetSortOrderCaseInsensitive(const Value: Boolean);
    procedure UpdateOrderCaseInsensitive;
    procedure AddRecInMemoryViewList(Rec: TMemoryRecordEh; Index: Integer; RecView: TMemRecViewEh);
    procedure DelRecInMemoryViewList(Index: Integer);
    function RemoveRecInMemoryViewList(Index: Integer): TMemRecViewEh;
//    procedure UpdateInMemoryViewList(Index: Integer);
    procedure ClearMemoryViewList;
    function GetRecordView(Index: Integer): TMemRecViewEh;
  protected
//    procedure RLDataEvent(MemRec: TMemoryRecordEh; Index: Integer; Action: TRecordsListNotification);

    FDataSet: TDataSet;
    FDisableFilterCount: Integer;

    function  FilterRecord(MemRec: TMemoryRecordEh; Index: Integer; Node: TMemRecViewEh): Boolean; virtual;
    procedure AddNotificator(RecordsList: TRecordsListNotificatorEh); virtual;
    procedure RemoveNotificator(RecordsList: TRecordsListNotificatorEh);
    procedure ClearMemoryTreeList;
    procedure DataEvent(MemRec: TMemoryRecordEh; Index: Integer; Action: TRecordsListNotification); override;
    procedure StructChanged(AMemTableData: TMemTableDataEh); override;
    procedure Notify(MemRec: TMemoryRecordEh; Index: Integer; Action: TRecordsListNotification); virtual;
    procedure NotifyRecordMoved(MemRec: TMemoryRecordEh; OldIndex, NewIndex: Integer); virtual;
//    procedure ViewDataEvent(MemRec: TMemoryRecordEh; Index: Integer; ViewEvent: TRecordsViewEventTypeEh; OldIndex: Integer);
    procedure RecordMoved(Item: TMemoryRecordEh; OldIndex, NewIndex: Integer); override;
//    procedure SetMemTableData(AMemTableData: TMemTableDataEh);
    procedure Resort; virtual;
    procedure UpdateLookupBuffer(RecView: TMemRecViewEh);
  public
    constructor Create(ADataSet: TDataSet); reintroduce;
    destructor Destroy; override;

//    function FetchRecord(Rec: TMemoryRecordEh): Boolean;
//    function FindRecId(RecId: TRecIdEh): Integer;

    function AccountableItemsCount: Integer;
    function AddRecord(Rec: TMemoryRecordEh): Integer;
    function CalcAggrFieldFunc(FieldName, AggrFuncName: String): Variant;
    function IndexOf(Rec: TMemoryRecordEh): Integer;
    function NewRecord: TMemoryRecordEh;
    function ViewItemsCount: Integer;
    procedure CancelUpdates;
    procedure DeleteRecord(Index: Integer);
    procedure InsertRecord(Index: Integer; Rec: TMemoryRecordEh);
    procedure InstantDisableFilter;
    procedure InstantEnableFilter;
    procedure LockCachedUpdates;
    procedure MergeChangeLog;
    procedure RebuildMemoryTreeList;
    procedure RefreshFilteredRecsList;
    procedure RefreshRecord(Index: Integer; Rec: TMemoryRecordEh);
    procedure RevertRecord(Index: Integer);
    procedure UnlockCachedUpdates;
    procedure UpdateAllLookupBuffer;
    procedure UpdateFields; virtual;

    procedure QuickSort(L, R: Integer; Compare: TCompareRecords; ParamSort: TObject);
    procedure SortData(Compare: TCompareRecords; ParamSort: TObject);

//    property MemTableData: TMemTableDataEh read FMemTableData write SetMemTableData;

    property AccountableRecord[Index: Integer]: TMemoryRecordEh read GetAccountableRecord;
    property Aggregates: TMTAggregatesEh read FAggregates;
//    property CachedUpdates: Boolean read FCachedUpdates write SetCachedUpdates;
    property CatchChanged: Boolean read FCatchChanged write FCatchChanged;
    property Count: Integer read GetCount;
    property MemoryTreeList: TMemoryTreeListEh read FMemoryTreeList;
    property MemoryViewList: TObjectList read FMemoryViewList;
    property OldRecVals[Index: Integer]: TRecDataValues read GetOldRecVals;
    property OnCompareRecords: TCompareRecords read FOnCompareRecords write FOnCompareRecords;
    property OnCompareTreeNode: TCompareNodesEh read FOnCompareTreeNode write FOnCompareTreeNode;
    property OnFilterRecord: TRecordsViewFilterEventEh read FOnFilterRecord write FOnFilterRecord;
    property OnGetPrefilteredList: TGetPrefilteredListEventEh read FOnGetPrefilteredList write FOnGetPrefilteredList;
    property OnParseOrderByStr: TParseOrderByStrEventEh read FOnParseOrderByStr write FOnParseOrderByStr;
    property OnViewDataEvent: TRecordsListNotificatorDataEventEh read FOnViewDataEvent write FOnViewDataEvent;
    property OnViewRecordMovedEvent: TRecordsListRecordMovedEventEh read FOnViewRecordMovedEvent write FOnViewRecordMovedEvent;
    property OnCalcLookupBuffer: TRecordsListCalcLookupBufferEventEh read FOnCalcLookupBuffer write FOnCalcLookupBuffer;
    property Rec[Index: Integer]: TMemoryRecordEh read GetRec write SetRec;
    property TreeViewKeyFieldName: String read FTreeViewKeyFieldName write SetTreeViewKeyFieldName;
    property TreeViewKeyFields: TIntArray read FTreeViewKeyFields;
    property TreeViewRefParentFieldName: String read FTreeViewRefParentFieldName write SetTreeViewRefParentFieldName;
    property TreeViewRefParentFields: TIntArray read FTreeViewRefParentFields;
    property Value[RecNo, ValNo: Integer]: Variant read GetValue write SetValue;
    property ViewAsTreeList: Boolean read GetViewAsTreeList write SetViewAsTreeList;
    property ViewRecord[Index: Integer]: TMemoryRecordEh read GetViewRecord; default;
    property RecordView[Index: Integer]: TMemRecViewEh read GetRecordView;
    property SortOrder: String read GetSortOrder write SetSortOrder;
    property SortOrderCaseInsensitive: Boolean read FSortOrderCaseInsensitive write SetSortOrderCaseInsensitive;
    property StatusFilter: TUpdateStatusSet read GetStatusFilter write SetStatusFilter default [usUnmodified, usModified, usInserted];
    property MemTableData: TMemTableDataEh read GetMemTableData write SetMemTableData;
  end;

const
  mrEditStatesEh = [resEditEh, resInsertEh, resEditForRefresh];
  StringDataFieldsToFields: array[TStringDataFieldTypesEh] of TFieldType =
    (ftString, ftFixedChar, ftWideString, ftGuid
{$IFDEF EH_LIB_10}
     , ftFixedWideChar, ftOraInterval
{$ENDIF}
    );
  NumericDataFieldsToFields: array[TNumericDataFieldTypesEh] of TFieldType =
    (ftSmallint, ftInteger, ftWord, ftFloat, ftCurrency, ftBCD, ftAutoInc,
     ftLargeint
{$IFDEF EH_LIB_6}
     ,ftFMTBcd
{$ENDIF}
{$IFDEF EH_LIB_12}
    ,ftLongWord, ftShortint, ftByte, ftExtended
{$ENDIF}
     );
  DateTimeDataFieldsToFields: array[TDateTimeDataFieldTypesEh] of TFieldType =
    (ftDate, ftTime, ftDateTime
//{$IFDEF EH_LIB_6}
//     ,ftTimeStamp
//{$ENDIF}
     );
   InterfaceDataFieldsToFields: array[TInterfaceDataFieldTypesEh] of TFieldType =
    (ftInterface, ftIDispatch);
   VariantDataFieldsToFields: array[TVariantDataFieldTypesEh] of TFieldType =
    (ftVariant, ftBytes, ftVarBytes);
{$IFDEF EH_LIB_6}
  SQLTimeStampDataFieldsToFields: array[TSQLTimeStampDataFieldTypesEh] of TFieldType =
    (ftTimeStamp
{$IFDEF EH_LIB_10}
     ,ftOraTimeStamp
{$ENDIF}
     );
{$ENDIF}

var
  DefaultDataFieldClasses: array[TFieldType] of TMTDataFieldClassEh = (
    TMTRefObjectFieldEh,        { ftUnknown }
    TMTStringDataFieldEh,       { ftString }
    TMTNumericDataFieldEh,      { ftSmallint }
    TMTNumericDataFieldEh,      { ftInteger }
    TMTNumericDataFieldEh,      { ftWord }
    TMTBooleanDataFieldEh,      { ftBoolean }
    TMTNumericDataFieldEh,      { ftFloat }
    TMTNumericDataFieldEh,      { ftCurrency }
    TMTNumericDataFieldEh,      { ftBCD }
    TMTDateTimeDataFieldEh,     { ftDate }
    TMTDateTimeDataFieldEh,     { ftTime }
    TMTDateTimeDataFieldEh,     { ftDateTime }
    TMTVariantDataFieldEh,      { ftBytes }
    TMTVariantDataFieldEh,      { ftVarBytes }
    TMTNumericDataFieldEh,      { ftAutoInc }
    TMTBlobDataFieldEh,         { ftBlob }
    TMTBlobDataFieldEh,         { ftMemo }
    TMTBlobDataFieldEh,         { ftGraphic }
    TMTBlobDataFieldEh,         { ftFmtMemo }
    TMTBlobDataFieldEh,         { ftParadoxOle }
    TMTBlobDataFieldEh,         { ftDBaseOle }
    TMTBlobDataFieldEh,         { ftTypedBinary }
    nil,                        { ftCursor }
    TMTStringDataFieldEh,       { ftFixedChar }
    TMTStringDataFieldEh,       { ftWideString }
    TMTNumericDataFieldEh,      { ftLargeInt }
    nil{TADTField},             { ftADT }
    nil{TArrayField},           { ftArray }
    nil{TReferenceField},       { ftReference }
    nil{TDataSetField},         { ftDataSet }
    TMTBlobDataFieldEh,         { ftOraBlob }
    TMTBlobDataFieldEh,         { ftOraClob }
    TMTVariantDataFieldEh,      { ftVariant }
    TMTInterfaceDataFieldEh,    { ftInterface }
    TMTInterfaceDataFieldEh,    { ftIDispatch }
    TMTStringDataFieldEh        { ftGuid }
{$IFDEF EH_LIB_6}
    ,TMTSQLTimeStampDataFieldEh { ftTimeStamp }
    ,TMTNumericDataFieldEh      { ftFMTBCD }
  {$IFDEF FPC}
    ,nil
    ,nil
  {$ELSE}
  {$ENDIF}
{$ENDIF}
{$IFDEF EH_LIB_10}
    ,TMTStringDataFieldEh       { ftFixedWideChar }
    ,TMTBlobDataFieldEh         { ftWideMemo }
    ,TMTSQLTimeStampDataFieldEh { ftOraTimeStamp }
    ,TMTStringDataFieldEh       { ftOraInterval }
{$ENDIF}
{$IFDEF EH_LIB_12}
    ,TMTNumericDataFieldEh      { ftLongWord }
    ,TMTNumericDataFieldEh      { ftShortint }
    ,TMTNumericDataFieldEh      { ftByte }
    ,TMTNumericDataFieldEh      { ftExtended }
    ,nil { ftConnection }
    ,nil { ftParams }
    ,nil { ftStream}
{$ENDIF}
{$IFDEF EH_LIB_13}
    ,nil                        { ftTimeStampOffset }
    ,nil                        { ftObject }
    ,nil                        { ftSingle }
{$ENDIF}
    );

function CalcAggregateValue(Aggregate: TMTAggregateEh; DataSet: TDataSet; Records: TRecordsViewEh): Variant;
function RecordsRangeEh(LowIndex, HighIndex: Integer): TRecordsRangeEh;

var
  VarArrayOfBytesVarType: TVarType;
  UnuseOneCharLikeWildcardEh: Boolean = False;

implementation

uses
{$IFDEF EH_LIB_6}
  DateUtils, RTLConsts
{$ELSE}
  ,Consts
{$ENDIF}
// ,memtableeh
 ,DbUtilsEh;

type
{$IFNDEF EH_LIB_6}
  PWordBool     = ^WordBool;
{$ENDIF}

  TDataSetCrack = class(TDataSet);
  TWriterCracker = class(TWriter);
  {$IFDEF FPC}
  {$ELSE}
  TReaderCrack = class(TReader);
  {$ENDIF}

procedure VarToVarBytes(var Value, VarBytesValue: Variant);
{$IFDEF CIL}
{$ELSE}
var
  PData: Pointer;
  Len: Longint;
{$ENDIF}
begin
  if VarType(Value) = VarArrayOfBytesVarType then
  begin
    VarBytesValue := Value
  end else if VarType(Value) = varString then
  begin
{$IFDEF CIL}
{$ELSE}
    Len := Length(Value);
    VarBytesValue := VarArrayCreate([0, Len-1], varByte);
    PData := VarArrayLock(VarBytesValue);
    try
      Move(Pointer(AnsiString(Value))^, PData^, Len);
    finally
      VarArrayUnlock(VarBytesValue);
    end;
{$ENDIF}
  end;
end;

procedure VarBytesToVar(const VarBytesValue: Variant; var Value: Variant; AVarType: TVarType);
{$IFDEF CIL}
{$ELSE}
var
  PData: Pointer;
  AnsiS: AnsiString;
  Len: Longint;
{$ENDIF}
begin
  if AVarType = VarArrayOfBytesVarType then
  begin
    Value := VarBytesValue
  end else if AVarType = varString then
  begin
{$IFDEF CIL}
{$ELSE}
    PData := VarArrayLock(VarBytesValue);
    Len := VarArrayHighBound(VarBytesValue, 1) + 1;
    try
      SetString(AnsiS, PAnsiChar(PData), Len);
    finally
      VarArrayUnlock(VarBytesValue);
    end;
    Value := AnsiS;
{$ENDIF}
  end;
end;

function PrepareExpr(const Expr: String): String;
var
  i: Integer;
begin
  Result := '';
  for i := 1 to Length(Expr) do
  begin
    if Expr[i] <> ' ' then
      Result := Result + Expr[i];
  end;
  Result := AnsiUpperCase(Result);
end;

function CalcAggregateValue(Aggregate: TMTAggregateEh; DataSet: TDataSet; Records: TRecordsViewEh): Variant;
var
  AggrExpStr: String;
  FuncName: String;
  FieldName: String;
begin
  Result := Null;
  FieldName := '';
  FuncName := '';
  AggrExpStr := PrepareExpr(Aggregate.Expression);

  //Function
  if Copy(AggrExpStr,1,Length('COUNT(')) = 'COUNT(' then
  begin
    FuncName := 'COUNT';
    AggrExpStr := Copy(AggrExpStr, Length('COUNT(')+1, Length(AggrExpStr));
  end else if Copy(AggrExpStr,1,Length('SUM(')) = 'SUM(' then
  begin
    FuncName := 'SUM';
    AggrExpStr := Copy(AggrExpStr, Length('SUM(')+1, Length(AggrExpStr));
  end else if Copy(AggrExpStr,1,Length('MIN(')) = 'MIN(' then
  begin
    FuncName := 'MIN';
    AggrExpStr := Copy(AggrExpStr, Length('MIN(')+1, Length(AggrExpStr));
  end else if Copy(AggrExpStr,1,Length('MAX(')) = 'MAX(' then
  begin
    FuncName := 'MAX';
    AggrExpStr := Copy(AggrExpStr, Length('MAX(')+1, Length(AggrExpStr));
  end else if Copy(AggrExpStr,1,Length('AVG(')) = 'AVG(' then
  begin
    FuncName := 'AVG';
    AggrExpStr := Copy(AggrExpStr, Length('AVG(')+1, Length(AggrExpStr));
  end;

  //Field
  if (AggrExpStr <> '') and (AggrExpStr[Length(AggrExpStr)] = ')') then
    FieldName := Copy(AggrExpStr, 1, Length(AggrExpStr)-1);

  Result := Records.CalcAggrFieldFunc(FieldName, FuncName);
end;

function RecordsRangeEh(LowIndex, HighIndex: Integer): TRecordsRangeEh;
begin
  Result.LowIndex := LowIndex;
  Result.HighIndex := HighIndex;
end;

procedure DataVarCast(var Dest: Variant; const Source: Variant; AVarType: Integer);
//function DataVarCast(const Source: Variant; AVarType: Integer): Variant;
begin
{$IFDEF CIL}
  if VarIsNull(Source) then
{$ELSE}
  if TVarData(Source).VType = varNull then
{$ENDIF}
    VarSetNull(Dest)
//    Dest := Null
  else if TVarData(Source).VType = varEmpty then
    Dest := Unassigned
  else if AVarType = varVariant then
    Dest := Source
  else if (VarType(Source) = VarArrayOfBytesVarType) and (varString = AVarType) then
    VarBytesToVar(Source, Dest, varString)
  else
    VarCast(Dest, Source, AVarType);
end;

{$IFNDEF EH_LIB_6}

function ReadVariantProp(Reader: TReader): Variant;
const
  ValTtoVarT: array[TValueType] of Integer = (varNull, varError, varByte,
    varSmallInt, varInteger, varDouble, varString, varError, varBoolean,
    varBoolean, varError, varError, varString, varEmpty, varError, varSingle,
    varCurrency, varDate, varOleStr, varError);
var
  Value: Variant;
  ValType: TValueType;
begin
  ValType := Reader.NextValue;
  case ValType of
    vaNil, vaNull:
    begin
      if Reader.ReadValue = vaNil then
        VarClear(Value) else
        Value := NULL;
    end;
    vaInt8: TVarData(Value).VByte := Byte(Reader.ReadInteger);
    vaInt16: TVarData(Value).VSmallint := Smallint(Reader.ReadInteger);
    vaInt32: TVarData(Value).VInteger := Reader.ReadInteger;
    vaExtended: TVarData(Value).VDouble := Reader.ReadFloat;
    vaSingle: TVarData(Value).VSingle := Reader.ReadSingle;
    vaCurrency: TVarData(Value).VCurrency := Reader.ReadCurrency;
    vaDate: TVarData(Value).VDate := Reader.ReadDate;
    vaString, vaLString: Value := Reader.ReadString;
    vaWString: Value := Reader.ReadWideString;
    vaFalse, vaTrue: TVarData(Value).VBoolean := Reader.ReadValue = vaTrue;
  else
    raise EReadError.Create('SReadError');
  end;
  TVarData(Value).VType := ValTtoVarT[ValType];
  Result := Value;
end;

procedure WriteVariantProp(Writer: TWriter; Value: Variant);
var
  VType: Integer;

  procedure WriteValue(Value: TValueType);
  begin
    Writer.Write(Value, SizeOf(Value));
  end;

begin
  if VarIsArray(Value) then raise EWriteError.Create('SWriteError');
  VType := VarType(Value);
  case VType and varTypeMask of
    varEmpty: WriteValue(vaNil);
    varNull: WriteValue(vaNull);
    varOleStr: Writer.WriteWideString(Value);
    varString: Writer.WriteString(Value);
    varByte, varSmallInt, varInteger: Writer.WriteInteger(Value);
    varSingle: Writer.WriteSingle(Value);
    varDouble: Writer.WriteFloat(Value);
    varCurrency: Writer.WriteCurrency(Value);
    varDate: Writer.WriteDate(Value);
    varBoolean:
      if Value then
        WriteValue(vaTrue) else
        WriteValue(vaFalse);
  else
    try
      Writer.WriteString(Value);
    except
      raise EWriteError.Create('SWriteError');
    end;
  end;
end;

{$ENDIF}

{ TRecordsViewOrderByList }

constructor TRecordsViewOrderByList.Create(ARecordsView: TRecordsViewEh);
begin
  inherited Create;
  FRecordsView := ARecordsView;
end;

function TRecordsViewOrderByList.FindFieldIndex(const FieldName: String): Integer;
begin
  Result := FRecordsView.MemTableData.DataStruct.FieldIndex(FieldName);
end;

{ TAutoIncrementEh }

procedure TAutoIncrementEh.Assign(Source: TPersistent);
begin
  if Source is TAutoIncrementEh then
  begin
    Step := TAutoIncrementEh(Source).Step;
    InitValue := TAutoIncrementEh(Source).InitValue;
  end
  else
    inherited Assign(Source);
end;

constructor TAutoIncrementEh.Create;
begin
  inherited Create;
  FStep := -1;
  FInitValue := -1;
  Reset;
end;

function TAutoIncrementEh.Promote: Longint;
begin
  Result := FCurValue;
  Inc(FCurValue, FStep);
end;

procedure TAutoIncrementEh.Reset;
begin
  FCurValue := FInitValue;
end;

procedure TAutoIncrementEh.SetInitValue(const Value: Integer);
begin
  if FInitValue = FCurValue then
    FCurValue := Value;
  FInitValue := Value;
end;

{ TMemTableDataEh }

function TMemTableDataEh.BeginRestruct: TMTDataStructEh;
begin
  if FRestructMode then
    raise Exception.Create('MemTableData already in RestructMode.');
  FNewDataStruct.Assign(FDataStruct);
  FRestructMode := True;
  Result := FNewDataStruct;
end;

procedure TMemTableDataEh.CancelRestruct;
begin
  FRestructMode := False;
  FNewDataStruct.Clear;
end;

procedure TMemTableDataEh.CheckInactive;
begin

end;

procedure TMemTableDataEh.CommitRestruct;
begin
  FRestructMode := False;
  Restruct;
end;

constructor TMemTableDataEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDataStruct := TMTDataStructEh.Create(Self);
  FDataStruct.Name := 'DataStruct';
  FNewDataStruct := TMTDataStructEh.Create(Self);
  FRecordsList := TRecordsListEh.Create(Self);
  FRecordsList.Name := 'RecordsList';
  FAutoIncrement := TAutoIncrementEh.Create;
  FNotificators := TObjectList.Create(False);
end;

destructor TMemTableDataEh.Destroy;
begin
  while FNotificators.Count > 0 do
//    TRecordsListNotificatorEh(FNotificators[0]).MemTableData := nil;
    TRecordsListNotificatorEh(FNotificators[0]).DataObject := nil;
  FreeAndNil(FRecordsList);
  FreeAndNil(FDataStruct);
  FreeAndNil(FNewDataStruct);
  FreeAndNil(FAutoIncrement);
  FreeAndNil(FNotificators);
  inherited Destroy;
end;

procedure TMemTableDataEh.DestroyTable;
begin
  RecordsList.Indexes.Clear;
  RecordsList.Clear;
  AutoIncrement.Reset;
  DataStruct.Clear;
end;

procedure TMemTableDataEh.ResetRecords;
begin
  RecordsList.Indexes.Clear;
  RecordsList.Clear;
  AutoIncrement.Reset;
end;

procedure TMemTableDataEh.AncestorNotFound(Reader: TReader;
  const ComponentName: string; ComponentClass: TPersistentClass;
  var Component: TComponent);
begin
  if (ComponentName = 'DataStruct') and (Reader.Root <> nil) then
    Component := FDataStruct
  else if (ComponentName = 'RecordsList') and (Reader.Root <> nil) then
    Component := FRecordsList;
end;

procedure TMemTableDataEh.CreateComponent(Reader: TReader;
  ComponentClass: TComponentClass; var Component: TComponent);
begin
  if ComponentClass.InheritsFrom(TMTDataStructEh) then
    Component := FDataStruct
  else if ComponentClass.InheritsFrom(TRecordsListEh) then
    Component := FRecordsList;
end;

procedure TMemTableDataEh.ReadState(Reader: TReader);
var
  OldOnCreateComponent: TCreateComponentEvent;
  OldOnAncestorNotFound: TAncestorNotFoundEvent;
begin
//  DestroyTable; //Clear before read

  OldOnCreateComponent := Reader.OnCreateComponent;
  OldOnAncestorNotFound := Reader.OnAncestorNotFound;
  Reader.OnCreateComponent := CreateComponent;
  Reader.OnAncestorNotFound := AncestorNotFound;

  try
    inherited ReadState(Reader);
  finally
    Reader.OnCreateComponent := OldOnCreateComponent;
    Reader.OnAncestorNotFound := OldOnAncestorNotFound;
  end;
end;

procedure TMemTableDataEh.GetChildren(Proc: TGetChildProc; Root: TComponent);
begin
  if StoreStructInStream then
    Proc(DataStruct);
  if StoreRecordsInStream then
    Proc(RecordsList);
end;

procedure TMemTableDataEh.Restruct;

  function FieldId(AFieldId: Longint): TMTDataFieldEh;
  var
    i: Integer;
  begin
    Result := nil;
    for i := 0 to DataStruct.Count-1 do
    begin
      if DataStruct[i].FFieldId = AFieldId then
      begin
        Result := DataStruct[i];
        Exit;
      end;
    end;
  end;

var
  i: Integer;
begin
  for i := 0 to FNewDataStruct.Count-1 do
  begin
    if FieldId(FNewDataStruct[i].FFieldId) <> nil then
    begin
      { TODO : Really do change struct}
    end;
  end;
end;

function TMemTableDataEh.GetIsEmpty: Boolean;
begin
  Result := (DataStruct.Count = 0);
end;

procedure TMemTableDataEh.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('AutoIncCurValue', ReadAutoIncCurValue,
    WriteAutoIncCurValue, AutoIncrement.CurValue <> AutoIncrement.InitValue);
end;

procedure TMemTableDataEh.ReadAutoIncCurValue(Reader: TReader);
begin
  FAutoIncrement.FCurValue := Reader.ReadInteger;
end;

procedure TMemTableDataEh.WriteAutoIncCurValue(Writer: TWriter);
begin
  Writer.WriteInteger(FAutoIncrement.FCurValue);
end;

procedure TMemTableDataEh.AddNotificator(RecordsList: TRecordsListNotificatorEh);
begin
  FNotificators.Add(RecordsList);
end;

procedure TMemTableDataEh.RemoveNotificator(RecordsList: TRecordsListNotificatorEh);
begin
  FNotificators.Remove(RecordsList);
end;

procedure TMemTableDataEh.Notify(MemRec: TMemoryRecordEh; Index: Integer; Action: TRecordsListNotification);
var
  i: Integer;
begin
  if FNotificators <> nil then
    for i := 0 to FNotificators.Count-1 do
      TRecordsListNotificatorEh(FNotificators[i]).DataEvent(MemRec, Index, Action);
end;

function TMemTableDataEh.FetchRecords(Count: Integer): Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to FNotificators.Count-1 do
    Result := Result + TRecordsListNotificatorEh(FNotificators[i]).FetchRecords(Count);
end;

function TMemTableDataEh.GetAutoIncrement: TAutoIncrementEh;
begin
  Result := FAutoIncrement;
end;

function TMemTableDataEh.GetDataStruct: TMTDataStructEh;
begin
  Result := FDataStruct;
end;

function TMemTableDataEh.GetRecordsList: TRecordsListEh;
begin
  Result := FRecordsList;
end;

procedure TMemTableDataEh.SetAutoIncrement(const Value: TAutoIncrementEh);
begin
  FAutoIncrement.Assign(Value);
end;

function TMemTableDataEh.CheckApplyUpdatesConsumers: Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to FNotificators.Count-1 do
    if @TRecordsListNotificatorEh(FNotificators[i]).OnApplyUpdates <> nil then
    begin
      Result := True;
      Exit;
    end;
end;

procedure TMemTableDataEh.ApplyUpdates(AMemTableData: TMemTableDataEh);
var
  i: Integer;
begin
  for i := 0 to FNotificators.Count-1 do
    TRecordsListNotificatorEh(FNotificators[i]).ApplyUpdates(AMemTableData);
end;

procedure TMemTableDataEh.RecordMoved(Item: TMemoryRecordEh; OldIndex, NewIndex: Integer);
var
  i: Integer;
begin
  for i := 0 to FNotificators.Count-1 do
    TRecordsListNotificatorEh(FNotificators[i]).RecordMoved(Item, OldIndex, NewIndex);
end;

procedure TMemTableDataEh.SetAutoIncValue(Rec: TMemoryRecordEh);
var
  I: Integer;
  NewIncValue: Integer;
  AutoIncReceived: Boolean;
begin
  AutoIncReceived := False;
  NewIncValue := 0;
(*  for I := 0 to Length(FIncFieldIndexes)-1 do
  begin
    if not AutoIncReceived then
    begin
      NewIncValue := AutoIncrement.Promote;
      AutoIncReceived := True;
    end;
    Rec.Value[FIncFieldIndexes[I], dvvValueEh] := NewIncValue;
  end;*)
  for I := 0 to DataStruct.Count - 1 do
    if (DataStruct.DataFields[I].DataType = ftAutoInc) or
        DataStruct.DataFields[I].AutoIncrement then
    begin
      if not AutoIncReceived then
      begin
        NewIncValue := AutoIncrement.Promote;
        AutoIncReceived := True;
      end;
      Rec.Value[I, dvvValueEh] := NewIncValue;
    end;
end;

procedure TMemTableDataEh.StructChanged;
var
  I: Integer;
begin
  SetLength(FIncFieldIndexes, 0);
  if DataStruct = nil then Exit;
  for I := 0 to DataStruct.Count-1 do
  begin
    if DataStruct.DataFields[I].DataType = ftAutoInc then
    begin
      SetLength(FIncFieldIndexes, Length(FIncFieldIndexes)+1);
      FIncFieldIndexes[Length(FIncFieldIndexes)-1] := I;
    end;
  end;
  if FNotificators <> nil then
    for i := 0 to FNotificators.Count-1 do
      TRecordsListNotificatorEh(FNotificators[i]).StructChanged(Self);
end;

{ TMemTableDataShadowEh }

constructor TMemTableDataShadowEh.Create(AMasterTable: TMemTableDataEh);
begin
  inherited Create(AMasterTable);
  FMasterTable := AMasterTable;
end;

destructor TMemTableDataShadowEh.Destroy;
begin
  inherited Destroy;
end;

function TMemTableDataShadowEh.GetDataStruct: TMTDataStructEh;
begin
  Result := FMasterTable.DataStruct;
end;

procedure TMemTableDataShadowEh.SetAutoIncValue(Rec: TMemoryRecordEh);
begin
 // Don't set AutoIncValue in shadow MemTable.
end;

{
function TMemTableDataShadowEh.GetAutoIncrement: TAutoIncrementEh;
begin
  Result := FMasterTable.AutoIncrement;
end;

procedure TMemTableDataShadowEh.SetAutoIncrement(
  const Value: TAutoIncrementEh);
begin
  FMasterTable.AutoIncrement := Value;
end;
}

{ TMTDataStructEh }

constructor TMTDataStructEh.Create(AMemTableData: TMemTableDataEh);
begin
  inherited Create(AMemTableData);
  FMemTableData := AMemTableData;
  FList := TObjectList.Create(False);
end;

destructor TMTDataStructEh.Destroy;
begin
  Clear;
  FreeAndNil(FList);
  inherited Destroy;
end;

procedure TMTDataStructEh.Clear;
var
  i: Integer;
begin
  for i := 0 to FList.Count-1 do
    TMTDataFieldEh(FList[i]).Free;
  FList.Clear;
  if FUpdateCount = 0 then
    StructChanged;
end;

function TMTDataStructEh.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TMTDataStructEh.GetDataField(Index: Integer): TMTDataFieldEh;
begin
  Result := TMTDataFieldEh(FList[Index]);
end;

function TMTDataStructEh.CreateField(FieldClass: TMTDataFieldClassEh): TMTDataFieldEh;
begin
  Result := FieldClass.Create(Self);
  Result.DataStruct := Self;
  Result.FFieldId := FNextFieldId;
  Inc(FNextFieldId);
end;

function TMTDataStructEh.ChangeFieldType(const FieldName: string;
  FieldClass: TMTDataFieldClassEh): TMTDataFieldEh;
var
  OldField: TMTDataFieldEh;
begin
  OldField := FieldByName(FieldName);
  Result := CreateField(FieldClass);
  Result.Index := OldField.Index;
  RemoveField(OldField);
  Result.Assign(OldField);
  if OldField.DefaultAlignment <> Result.DefaultAlignment then
    Result.Alignment := Result.DefaultAlignment;
//  OldField.FieldName := '';
  Result.FGUID :=  OldField.FGUID;
  FreeAndNil(OldField);
  Result.FieldName := FieldName;
end;

procedure TMTDataStructEh.InsertField(Field: TMTDataFieldEh);
begin
//  if Field.FDataStruct <> nil then
//    Field.DataStruct.RemoveField(Field);
  FList.Add(Field);
  Field.FDataStruct := Self;
  if FUpdateCount = 0 then
    StructChanged;
end;

procedure TMTDataStructEh.RemoveField(Field: TMTDataFieldEh);
var
  Index: Integer;
begin
  if Field.DataStruct <> Self then Exit;
  Index := FList.IndexOf(Field);
  if Index >= 0 then
  begin
    FList.Delete(Index);
    Field.FDataStruct := nil;
    RemoveComponent(Field);
  end;
  if FUpdateCount = 0 then
    StructChanged;
end;

procedure TMTDataStructEh.CheckFieldName(const FieldName: string);
begin
  if FieldName = '' then DatabaseError('SFieldNameMissing', MemTableData);
  if FindField(FieldName) <> nil then
  {$IFDEF FPC}
    DatabaseErrorFmt('SDuplicateFieldName', [FieldName], MemTableData);
  {$ELSE}
    DatabaseErrorFmt(SDuplicateFieldName, [FieldName], MemTableData);
  {$ENDIF}
end;

function TMTDataStructEh.FindField(const FieldName: string): TMTDataFieldEh;
var
  I: Integer;
begin
  for I := 0 to FList.Count - 1 do
  begin
    Result := TMTDataFieldEh(FList.Items[I]);
    if AnsiCompareText(Result.FFieldName, FieldName) = 0 then Exit;
  end;
  Result := nil;
end;

function TMTDataStructEh.FindFieldByGIUD(const GUID: string): TMTDataFieldEh;
var
  I: Integer;
begin
  for I := 0 to FList.Count - 1 do
  begin
    Result := TMTDataFieldEh(FList.Items[I]);
    if Result.GUID = GUID then Exit;
  end;
  Result := nil;
end;

procedure TMTDataStructEh.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  I: Integer;
  Field: TMTDataFieldEh;
begin
  for I := 0 to Count - 1 do
  begin
    Field := DataFields[I];
    Proc(Field);
  end;
end;

function TMTDataStructEh.GetChildOwner: TComponent;
begin
  Result := Self;
end;

procedure TMTDataStructEh.BuildStructFromFieldDefs(FieldDefs: TFieldDefs);
var
  i: Integer;
//  DataField: TMTDataFieldEh;
begin
  MemTableData.DestroyTable;
  for i := 0 to FieldDefs.Count-1 do
    BuildDataFieldForFieldDef(FieldDefs[i]);
end;

function TMTDataStructEh.BuildDataFieldForFieldDef(AFieldDef: TFieldDef): TMTDataFieldEh;
begin
  Result := CreateField(DefaultDataFieldClasses[AFieldDef.DataType]);
  Result.AssignDataType(AFieldDef.DataType);
  Result.FieldName := AFieldDef.Name;
//    Result.Name := Result.CreateUniqueName(Result.FieldName);
//    property FieldNo: Integer read GetFieldNo write FFieldNo stored False;
//    property InternalCalcField: Boolean read FInternalCalcField write FInternalCalcField;
//    property ParentDef: TFieldDef read GetParentDef;
  Result.Required := AFieldDef.Required;
//    property Attributes: TFieldAttributes read FAttributes write SetAttributes default [];
//    property ChildDefs: TFieldDefs read GetChildDefs write SetChildDefs stored HasChildDefs;
//    property DataType: TFieldType read FDataType write SetDataType default ftUnknown;
  if (Result is TMTNumericDataFieldEh) and (AFieldDef.Precision <> 0) then
    (Result as TMTNumericDataFieldEh).Precision := AFieldDef.Precision;
  if Result.CanDinaSize then
    Result.Size := AFieldDef.Size;
  if AFieldDef.DataType = ftAutoInc then
    Result.AutoIncrement := True;
end;

function TMTDataStructEh.BuildDataFieldForDef(const Name: string;
  DataType: TFieldType; Size: Integer; Precision: Integer): TMTDataFieldEh;
begin
  Result := CreateField(DefaultDataFieldClasses[DataType]);
  Result.FieldName := Name;
  if (Result is TMTNumericDataFieldEh) and (Precision <> 0) then
    (Result as TMTNumericDataFieldEh).Precision := Precision;
  if Result.CanDinaSize then
    Result.Size := Size;
end;

function TMTDataStructEh.BuildDataFieldForField(AField: TField): TMTDataFieldEh;
var
  DataFieldClass: TMTDataFieldClassEh;
  ADataType: TFieldType;
begin
  DataFieldClass := DefaultDataFieldClasses[AField.DataType];
  ADataType := AField.DataType;

  Result := CreateField(DataFieldClass);
  Result.AssignDataType(ADataType);
end;

function TMTDataStructEh.BuildAndCopyDataFieldForField(AField: TField): TMTDataFieldEh;
begin
  Result := BuildDataFieldForField(AField);
  Result.FieldName := AField.FieldName;
//        Result.Name := DataField.CreateUniqueName(Result.FieldName);
  Result.AssignProps(AField);
end;

procedure TMTDataStructEh.BuildStructFromFields(Fields: TFields);
var
  i: Integer;
//  DataField: TMTDataFieldEh;
//  DataFieldClass: TMTDataFieldClassEh;
  DatasetFeatures: TDatasetFeaturesEh;
begin
  MemTableData.DestroyTable;
//  DataFieldClass := nil;
  for i := 0 to Fields.Count-1 do
  begin
    if Fields[i].FieldKind in [fkData, fkInternalCalc] then
    begin
      DatasetFeatures := GetDatasetFeaturesForDataSet(Fields[i].DataSet);
      if DatasetFeatures <> nil then
        {DataField := }DatasetFeatures.CreateAndAsignMTDateField(Self, Fields[i])
      else
        {DataField := }BuildAndCopyDataFieldForField(Fields[i]);
    end;
  end;
end;

procedure TMTDataStructEh.BuildFieldDefsFromStruct(FieldDefs: TFieldDefs);

  procedure CreateFieldDefs(FieldDefs: TFieldDefs);
  var
    I: Integer;
    F: TMTDataFieldEh;
    FieldDef: TFieldDef;
  begin
    for I := 0 to Count - 1 do
    begin
      F := DataFields[I];
      with F do
      begin
        FieldDef := FieldDefs.AddFieldDef;
        FieldDef.Name := F.FieldName;
        FieldDef.DataType := DataType;
        FieldDef.Size := Size;
        if Required then
          FieldDef.Attributes := [faRequired];
//        if ReadOnly then
//          FieldDef.Attributes := FieldDef.Attributes + [faReadonly];
        if F is TMTNumericDataFieldEh then
          FieldDef.Precision := TMTNumericDataFieldEh(F).Precision;
//        if F is TObjectField then
//          CreateFieldDefs(TObjectField(F).Fields, FieldDef.ChildDefs);
      end;
    end;
  end;

begin
  FieldDefs.BeginUpdate;
  FieldDefs.Clear;
  try
    CreateFieldDefs(FieldDefs);
  finally
    FieldDefs.EndUpdate;
  end;
end;

function TMTDataStructEh.FieldIndex(const FieldName: string): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to Count - 1 do
//    if UpperCase(DataFields[I].FieldName) = UpperCase(FieldName) then
    if CompareText(DataFields[I].FieldName, FieldName) = 0 then
    begin
      Result := I;
      Exit;
    end;
//  if Result = -1 then
//    DatabaseErrorFmt(SFieldNotFound, [FieldName], Self);
end;

function TMTDataStructEh.FieldsIndex(const FieldNames: string): TIntArray;
var
  I: Integer;
  Fields: TObjectList;
begin
  if Pos(';', FieldNames) <> 0 then
  begin
    Fields := TObjectList.Create(False);
    try
      GetFieldList(Fields, FieldNames);
      SetLength(Result, Fields.Count);
      for I := 0 to Fields.Count - 1 do
        Result[I] := TMTDataFieldEh(Fields[I]).Index;
    finally
      Fields.Free;
    end;
  end else
  begin
    I := FieldIndex(FieldNames);
    if I >= 0 then
    begin
      SetLength(Result, 1);
      Result[0] := I;
    end;
  end;
end;

procedure TMTDataStructEh.GetFieldList(List: TObjectList; const FieldNames: string);
var
  Pos: Integer;
  Field: TMTDataFieldEh;
begin
  Pos := 1;
  while Pos <= Length(FieldNames) do
  begin
    Field := FieldByName(ExtractFieldName(FieldNames, Pos));
    if Assigned(List) then List.Add(Field);
  end;
end;

function TMTDataStructEh.FieldByName(const FieldName: string): TMTDataFieldEh;
begin
  Result := FindField(FieldName);
  if Result = nil then
  {$IFDEF FPC}
    DatabaseErrorFmt('SFieldNotFound', [FieldName], Self);
  {$ELSE}
    DatabaseErrorFmt(SFieldNotFound, [FieldName], Self);
  {$ENDIF}
end;

procedure TMTDataStructEh.Assign(Source: TPersistent);
var
  i: Integer;
  DataField: TMTDataFieldEh;
  NewDataStruct: TMTDataStructEh;
begin
  if Source is TMTDataStructEh then
  begin
    BeginUpdate;
    try
    NewDataStruct := TMTDataStructEh(Source);
    if MemTableData.RecordsList.Count > 0 then
//      raise Exception.Create('Can not assign a struct for the nonempty list of records');
      ConvertRecordsData(NewDataStruct);
    Clear;
    for i:=0 to TMTDataStructEh(Source).Count-1 do
    begin
      DataField := CreateField(TMTDataFieldClassEh(TMTDataStructEh(Source)[i].ClassType));
      DataField.Assign(TMTDataStructEh(Source)[i]);
//??      InsertField(DataField);
    end;
    finally
      EndUpdate(True);
    end;
  end else
    inherited Assign(Source);
end;

procedure TMTDataStructEh.FieldPropertyChanged;
begin
  if FUpdateCount = 0 then
    StructChanged;
end;

procedure TMTDataStructEh.StructChanged;
begin
  if MemTableData <> nil
    then MemTableData.StructChanged
    else FStructChanged := True;
  if Assigned(OnStructChanged) then
    OnStructChanged(Self);
end;

procedure TMTDataStructEh.ClearStructChanged;
begin
  FStructChanged := False;
end;

function TMTDataStructEh.GetCopy: TMTDataStructEh;
var
  i: Integer;
  DataField: TMTDataFieldEh;
begin
  Result := TMTDataStructEh.Create(nil);
  for i := 0 to Count-1 do
  begin
    DataField := Result.CreateField(TMTDataFieldClassEh(DataFields[i].ClassType));
    DataField.FGUID := DataFields[i].GUID;
    DataField.Assign(DataFields[i]);
  end;
end;

function ConvertData(OldField: TMTDataFieldEh; OldValue: Variant;
  NewField: TMTDataFieldEh): Variant;
begin
  try
    DataVarCast(Result, OldValue, NewField.GetVarDataType);
  except
    on EVariantTypeCastError do
      Result := Null; //Null if can't convert
    else
      raise;
  end;
  if not VarIsNull(Result) then
    if ((NewField is TMTStringDataFieldEh) and (OldField is TMTStringDataFieldEh) and
       (TMTStringDataFieldEh(NewField).Size < TMTStringDataFieldEh(OldField).Size))
       or
       ((NewField is TMTStringDataFieldEh) and not (OldField is TMTStringDataFieldEh))
    then
      if NewField.GetVarDataType = varString then
{ TODO : Rename VarToStr TO VarToAnsiStr }
        Result := Copy(VarToStr(Result), 0, NewField.Size)
      else if NewField.GetVarDataType = varOleStr then
        Result := Copy(VarToWideStr(Result), 0, NewField.Size);
end;

procedure TMTDataStructEh.ConvertRecordsData(NewDataStruct: TMTDataStructEh);
type
  TDataFieldCorrespondence = record
    OldField: TMTDataFieldEh;
    NewField: TMTDataFieldEh;
  end;
var
  DataFieldCorrespondenceArr: array of TDataFieldCorrespondence;
  i,r: Integer;
  NewData: TRecDataValues;
  Rec: TMemoryRecordEh;
begin
  SetLength(DataFieldCorrespondenceArr, NewDataStruct.Count);
  for i := 0 to NewDataStruct.Count-1 do
  begin
    DataFieldCorrespondenceArr[i].NewField := NewDataStruct[i];
    DataFieldCorrespondenceArr[i].OldField := FindFieldByGIUD(NewDataStruct[i].GUID);
  end;

  SetLength(NewData, NewDataStruct.Count);
  for r := 0 to MemTableData.RecordsList.Count-1 do
  begin
    Rec := MemTableData.RecordsList.Rec[r];

    for i := 0 to NewDataStruct.Count-1 do
    begin
      if DataFieldCorrespondenceArr[i].OldField = nil then
        NewData[i] := Null
      else
        NewData[i] :=
          ConvertData(
            DataFieldCorrespondenceArr[i].OldField,
            Rec.FData[DataFieldCorrespondenceArr[i].OldField.Index],
            DataFieldCorrespondenceArr[i].NewField);
    end;
    Rec.FData := Copy(NewData, 0, Length(NewData));

    if Length(Rec.OldData) > 0 then
    begin
      for i := 0 to NewDataStruct.Count-1 do
      begin
        if DataFieldCorrespondenceArr[i].OldField = nil then
          NewData[i] := Null
        else
          NewData[i] :=
            ConvertData(
              DataFieldCorrespondenceArr[i].OldField,
              Rec.OldData[DataFieldCorrespondenceArr[i].OldField.Index],
              DataFieldCorrespondenceArr[i].NewField);
      end;
      Rec.FOldData := Copy(NewData, 0, Length(NewData));
    end;
{ TODO : TmpOldData }
  end;
end;

function TMTDataStructEh.BeginRestructure: TMTDataStructEh;
begin
  Result := GetCopy;
end;

procedure TMTDataStructEh.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

procedure TMTDataStructEh.EndRestructure(NewStrcuture: TMTDataStructEh;
  ApplyNewStrcuture: Boolean);
begin
  try
    if ApplyNewStrcuture then
      Assign(NewStrcuture);
  finally
    FreeAndNil(NewStrcuture);
  end;
end;

procedure TMTDataStructEh.EndUpdate(AStructChanged: Boolean);
begin
  Dec(FUpdateCount);
  if (FUpdateCount = 0) and AStructChanged then
    StructChanged;
end;

{ TMTDataFieldEh }

constructor TMTDataFieldEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FGUID := CreateClassID;
  FVisible := True;
  FVarDataType := GetVarDataType;
end;

destructor TMTDataFieldEh.Destroy;
begin
  inherited Destroy;
end;

function TMTDataFieldEh.DefaultAlignment: TAlignment;
begin
  Result := taLeftJustify;
end;

function TMTDataFieldEh.DefaultDisplayLabel: String;
begin
  Result := Name;
end;

function TMTDataFieldEh.DefaultDisplayWidth: Integer;
begin
  Result := 50;
end;

function TMTDataFieldEh.DefaultEditMask: String;
begin
  Result := '';
end;

function TMTDataFieldEh.DefaultRequired: Boolean;
begin
  Result := False;
end;

function TMTDataFieldEh.DefaultSize: Integer;
begin
  Result := 0;
end;

function TMTDataFieldEh.DefaultVisible: Boolean;
begin
  Result := True;
end;

function TMTDataFieldEh.DefValueForDefaultExpression: String;
begin
  Result := '';
end;

function TMTDataFieldEh.GetAlignment: TAlignment;
begin
  Result := FAlignment;
end;

function TMTDataFieldEh.GetDataType: TFieldType;
begin
  Result := ftUnknown;
end;

function TMTDataFieldEh.GetDefaultExpression: String;
begin
  Result := FDefaultExpression;
end;

function TMTDataFieldEh.GetDisplayLabel: String;
begin
  Result := FDisplayLabel;
end;

function TMTDataFieldEh.GetDisplayWidth: Integer;
begin
  if FDisplayWidth > 0 then
    Result := FDisplayWidth else
    Result := GetDefaultWidth;
end;

function TMTDataFieldEh.GetEditMask: String;
begin
  Result := FEditMask;
end;

function TMTDataFieldEh.GetFieldName: String;
begin
  Result := FFieldName;
end;

function TMTDataFieldEh.GetReadOnly: Boolean;
begin
  Result := FReadOnly;
end;

function TMTDataFieldEh.GetRequired: Boolean;
begin
  Result := FRequired;
end;

function TMTDataFieldEh.GetSize: Integer;
begin
  Result := FSize;
end;

function TMTDataFieldEh.GetVisible: Boolean;
begin
  Result := FVisible;
end;

procedure TMTDataFieldEh.SetAlignment(const Value: TAlignment);
begin
  if FAlignment <> Value then
  begin
    FAlignment := Value;
    PropertyChanged;
  end;
end;

procedure TMTDataFieldEh.SetDataStruct(const Value: TMTDataStructEh);
begin
  if FDataStruct <> nil then
    FDataStruct.RemoveField(Self);
  if Value <> nil then
    Value.InsertField(Self);
//  FList.Add(Field);
//  Field.FDataStruct := Self;
end;

procedure TMTDataFieldEh.SetDefaultExpression(const Value: String);
begin
  if FDefaultExpression <> Value then
  begin
    FDefaultExpression := Value;
    PropertyChanged;
  end;
end;

procedure TMTDataFieldEh.SetDisplayLabel(const Value: String);
begin
  if FDisplayLabel <> Value then
  begin
    FDisplayLabel := Value;
    PropertyChanged;
  end;
end;

procedure TMTDataFieldEh.SetDisplayWidth(const Value: Integer);
begin
  if FDisplayWidth <> Value then
  begin
    FDisplayWidth := Value;
    PropertyChanged;
  end;
end;

procedure TMTDataFieldEh.SetEditMask(const Value: String);
begin
  if FEditMask <> Value then
  begin
    FEditMask := Value;
    PropertyChanged;
  end;
end;

function GenerateName(FieldClass: TMTDataFieldClassEh;
  FieldName: string; Number: Integer): string;
var
  Fmt: string;

  procedure CrunchFieldName;
  var
    I: Integer;
  begin
    I := 1;
    while I <= Length(FieldName) do
    begin
      if CharInSetEh(FieldName[I], ['A'..'Z','a'..'z','_','0'..'9']) then
        Inc(I)
      else if CharInSetEh(FieldName[I], LeadBytes) then
        Delete(FieldName, I, 2)
      else
        Delete(FieldName, I, 1);
    end;
  end;

begin
  CrunchFieldName;
  if (FieldName = '') or CharInSetEh(FieldName[1], ['0'..'9']) then
  begin
    if FieldClass <> nil
      then FieldName := FieldClass.ClassName + FieldName
      else FieldName := 'Field' + FieldName;
    if FieldName[1] = 'T' then Delete(FieldName, 1, 1);
    CrunchFieldName;
  end;
  Fmt := '%s%d';
  if Number < 2 then Fmt := '%s';
  Result := Format(Fmt, [FieldName, Number]);
end;

function TMTDataFieldEh.CreateUniqueName(const FieldName: string): string;
var
  I: Integer;

  function IsUnique(const AName: string): Boolean;
  var
    I: Integer;
    OwnerDataStruct: TMTDataStructEh;
  begin
    Result := False;
    if Owner is TMTDataStructEh
      then OwnerDataStruct := (Owner as TMTDataStructEh)
      else OwnerDataStruct := DataStruct;
    if OwnerDataStruct <> nil then
      for I := 0 to OwnerDataStruct.Count - 1 do
        if AnsiCompareText(OwnerDataStruct[I].Name, AName) = 0 then Exit;
    Result := True;
  end;

begin
  for I := 1 to MaxInt do
  begin
    Result := GenerateName(TMTDataFieldClassEh(ClassType), FieldName, I);
    if IsUnique(Result) then Exit;
  end;
end;

procedure TMTDataFieldEh.SetFieldName(const Value: String);
begin
  if Value = FFieldName then Exit;
  CheckInactive;
  if (DataStruct <> nil) and (AnsiCompareText(Value, FFieldName) <> 0) then
    DataStruct.CheckFieldName(Value);
  FFieldName := Value;
  inherited Name := CreateUniqueName(Value);
  PropertyChanged;
//  Name := CreateUniqueName(Value);
end;

procedure TMTDataFieldEh.SetReadOnly(const Value: Boolean);
begin
  if FReadOnly <> Value then
  begin
    FReadOnly := Value;
    PropertyChanged;
  end;
end;

procedure TMTDataFieldEh.SetRequired(const Value: Boolean);
begin
  if FRequired <> Value then
  begin
    FRequired := Value;
    PropertyChanged;
  end;
end;

procedure TMTDataFieldEh.SetSize(const Value: Integer);
begin
  if not CanDinaSize then
  {$IFDEF FPC}
      DatabaseError('SInvalidFieldSize');
  {$ELSE}
    DatabaseError(SInvalidFieldSize);
  {$ENDIF}
  if FSize <> Value then
  begin
    FSize := Value;
    PropertyChanged;
  end;
end;

procedure TMTDataFieldEh.SetVisible(const Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    PropertyChanged;
  end;
end;

function TMTDataFieldEh.GetParentComponent: TComponent;
begin
  Result := DataStruct;
end;

procedure TMTDataFieldEh.SetParentComponent(AParent: TComponent);
begin
  if not (csLoading in ComponentState) then
    FDataStruct := AParent as TMTDataStructEh;
end;

function TMTDataFieldEh.HasParent: Boolean;
begin
  Result := True;
end;

procedure TMTDataFieldEh.ReadState(Reader: TReader);
begin
  inherited ReadState(Reader);
  DataStruct := TMTDataStructEh(Reader.Parent);
end;

procedure TMTDataFieldEh.Assign(Source: TPersistent);
begin
  if Source is TMTDataFieldEh then
  begin
//    FieldName := CreateUniqueName(TMTDataFieldEh(Source).FieldName);
    FieldName := TMTDataFieldEh(Source).FieldName;
    if CanDinaSize and TMTDataFieldEh(Source).CanDinaSize then
      Size := TMTDataFieldEh(Source).Size;
    Alignment := TMTDataFieldEh(Source).Alignment;
    DefaultExpression := TMTDataFieldEh(Source).DefaultExpression;
    DisplayLabel := TMTDataFieldEh(Source).DisplayLabel;
    DisplayWidth := TMTDataFieldEh(Source).DisplayWidth;
    EditMask := TMTDataFieldEh(Source).EditMask;
    Required := TMTDataFieldEh(Source).Required;
    Visible := TMTDataFieldEh(Source).Visible;
    AutoIncrement  := TMTDataFieldEh(Source).AutoIncrement;
  end else
    inherited Assign(Source);
end;

procedure TMTDataFieldEh.CheckInactive;
begin
  if (DataStruct <> nil) and (DataStruct.MemTableData <> nil) then
    DataStruct.MemTableData.CheckInactive;
end;

function TMTDataFieldEh.CanDinaSize: Boolean;
begin
  Result := False;
end;

procedure TMTDataFieldEh.AssignProps(Field: TField);
begin
  Alignment := Field.Alignment;
  DefaultExpression := Field.DefaultExpression;
  DisplayLabel := Field.DisplayLabel;
  DisplayWidth := Field.DisplayWidth;
  EditMask := Field.EditMask;
  Required := Field.Required;
  {$IFDEF FPC}
  {$ELSE}
  if Field.AutoGenerateValue = arAutoInc then
    AutoIncrement := True;
  {$ENDIF}
  if CanDinaSize then
    Size := Field.Size;
  Visible := Field.Visible;
end;

procedure TMTDataFieldEh.AssignPropsTo(Field: TField);
begin
  Field.Alignment := Alignment;
  Field.DefaultExpression := DefaultExpression;
  Field.DisplayLabel := DisplayLabel;
  Field.DisplayWidth := DisplayWidth;
  Field.EditMask := EditMask;
  Field.Required := Required;
  {$IFDEF FPC}
  {$ELSE}
  if AutoIncrement then
    Field.AutoGenerateValue := arAutoInc;
  {$ENDIF}
  if CanDinaSize then
    Field.Size := Size;
  Field.Visible := Visible;
end;

function TMTDataFieldEh.GetVarDataType: TVarType;
var
  AVarArray: Variant;
begin
  case DataType of
    ftUnknown: Result := varError;
    ftString: Result := varString;
    ftSmallint: Result := varSmallint;
    ftInteger: Result := varInteger;
    ftWord: Result := varInteger;
    ftBoolean: Result := varBoolean;
    ftFloat: Result := varDouble;
    ftCurrency: Result := varCurrency;
    ftBCD: Result := varCurrency;
    ftDate: Result := varDate;
    ftTime: Result := varDate;
    ftDateTime: Result := varDate;
    ftBytes: Result := varArray;
    ftVarBytes: Result := varArray;
    ftAutoInc: Result := varInteger;
{$IFDEF EH_LIB_12}
    ftBlob: Result := varArray;
    ftMemo: Result := varString;
    ftGraphic: Result := varArray;
    ftFmtMemo: Result := varString;
    ftParadoxOle: Result := varArray;
    ftDBaseOle: Result := varArray;
    ftTypedBinary: Result := varArray;
{$ELSE}
    ftBlob: Result := varString;
    ftMemo: Result := varString;
    ftGraphic: Result := varString;
    ftFmtMemo: Result := varString;
    ftParadoxOle: Result := varString;
    ftDBaseOle: Result := varString;
    ftTypedBinary: Result := varString;
{$ENDIF}
    ftCursor: Result := varError;
    ftFixedChar: Result := varString;
    ftWideString: Result := varOleStr;
{$IFDEF EH_LIB_6}
    ftLargeint: Result := varInt64;
{$ELSE}
    ftLargeint: Result := varError;
{$ENDIF}
    ftADT: Result := varError;
    ftArray: Result := varError;
    ftReference: Result := varError;
    ftDataSet: Result := varError;
{$IFDEF EH_LIB_12}
    ftOraBlob: Result := varArray;
{$ELSE}
    ftOraBlob: Result := varString;
{$ENDIF}
    ftOraClob: Result := varString;
    ftVariant: Result := varVariant;
{$IFNDEF CIL}
    ftInterface: Result := varUnknown;
    ftIDispatch: Result := varDispatch;
{$ENDIF}
    ftGuid: Result := varString;
{$IFDEF EH_LIB_6}

    {$IFDEF FPC}
    ftTimeStamp: Result := varString;
    {$ELSE}
    ftTimeStamp: Result := varSQLTimeStamp;
    {$ENDIF}

    ftFMTBcd: Result := varFMTBcd;
{$ENDIF}
{$IFDEF EH_LIB_10}
    ftFixedWideChar: Result := varOleStr;
    ftWideMemo: Result := varOleStr;
    ftOraTimeStamp: Result := VarSQLTimeStamp;
    ftOraInterval: Result := varString;
{$ENDIF}
{$IFDEF EH_LIB_12}
    ftLongWord: Result := varLongWord;
    ftShortint: Result := varShortInt;
    ftByte: Result := varByte;
    ftExtended: Result := varDouble;
    ftConnection: Result := varError;
    ftParams: Result := varError;
    ftStream: Result := varError;
{$ENDIF}
  else
    Result := varEmpty;
  end;
{$IFDEF EH_LIB_12}
  if DataType in [ftBytes, ftVarBytes, ftBlob, ftGraphic, ftParadoxOle,
      ftDBaseOle, ftTypedBinary, ftOraBlob] then
{$ELSE}
  if DataType in [ftBytes, ftVarBytes] then
{$ENDIF}
  begin
    AVarArray := VarArrayCreate([0, 1], varByte);
    Result := VarType(AVarArray);
  end;
end;

procedure TMTDataFieldEh.AssignDataType(FieldType: TFieldType);
begin
  raise Exception.Create('Can''t assign DataType from Field');
end;

function TMTDataFieldEh.GetIndex: Integer;
begin
  Result := DataStruct.FList.IndexOf(Self);
end;

function TMTDataFieldEh.GetAutoIncrement: Boolean;
begin
  Result := FAutoIncrement;
end;

procedure TMTDataFieldEh.SetAutoIncrement(const Value: Boolean);
begin
  if FAutoIncrement <> Value then
  begin
    FAutoIncrement := Value;
    PropertyChanged;
  end;
end;

procedure TMTDataFieldEh.PropertyChanged;
begin
  if DataStruct <> nil then
    DataStruct.FieldPropertyChanged;
end;

procedure TMTDataFieldEh.SetIndex(const Value: Integer);
begin
  DataStruct.FList.Move(Index, Value);
  DataStruct.StructChanged;
end;

function TMTDataFieldEh.IsDisplayWidthStored: Boolean;
begin
  Result := FDisplayWidth > 0;
end;

function TMTDataFieldEh.GetDefaultWidth: Integer;
begin
  Result := 10;
end;

{$IFDEF CIL}
{$ELSE}
function TMTDataFieldEh.GetName: String;
begin
  Result := inherited Name;
end;
{$ENDIF}

const
  ftWriteAsBinaryTypes = [ftBytes, ftVarBytes, ftBlob, ftGraphic,
    ftParadoxOle, ftDBaseOle, ftTypedBinary, ftCursor, ftADT, ftArray,
    ftReference, ftDataSet];

procedure TMTDataFieldEh.ReadDataFromReader(var Value: Variant; Reader: TReader);
var
  v: Variant;
  ReadVal: TValueType;
{$IFDEF CIL}
{$ELSE}
  Count: Longint;
  PData: Pointer;
  VarBytesValue: Variant;
{$ENDIF}
begin
//  if GetVarDataType = VarArrayOfBytesVarType then
  if DataType in ftWriteAsBinaryTypes then
  begin
    ReadVal := Reader.ReadValue;
{$IFDEF CIL}
{$ELSE}
    if ReadVal = vaBinary then
    begin
      Reader.Read(Count, SizeOf(Count));
      VarBytesValue := VarArrayCreate([0,Count-1], varByte);
      PData := VarArrayLock(VarBytesValue);
      try
        Reader.Read(PData^, Count);
      finally
        VarArrayUnlock(VarBytesValue);
      end;
      VarBytesToVar(VarBytesValue, Value, GetVarDataType);
    end else
    begin
      {$IFDEF FPC}
      Reader.Driver.SkipValue;
      {$ELSE}
      TReaderCrack(Reader).SkipValue;
      {$ENDIF}
      raise EReadError.CreateRes(@SInvalidPropertyValue);
    end;
{$ENDIF}
  end else
  begin
    {$IFDEF EH_LIB_6}
    v := Reader.ReadVariant;
    {$ELSE}
    v := ReadVariantProp(Reader);
    {$ENDIF}
    if VarIsEmpty(v) then
      Value := Null
    else
      VarCast(Value, v, GetVarDataType);
  end;
end;

procedure TMTDataFieldEh.WriteDataToWriter(var Value: Variant; Writer: TWriter);
var
  Len: Longint;
{$IFDEF CIL}
{$ELSE}
  PData: Pointer;
  VarBytesValue: Variant;
{$ENDIF}
{$IFDEF FPC}
  b: Byte;
{$ENDIF}

begin
//  if GetVarDataType = VarArrayOfBytesVarType then
  if DataType in ftWriteAsBinaryTypes then
  begin
{$IFDEF CIL}
{$ELSE}
    {$IFDEF FPC}
    b := Byte(vaBinary);
    TWriterCracker(Writer).Write(b, 1);
    {$ELSE}
    TWriterCracker(Writer).WriteValue(vaBinary);
    {$ENDIF}

    if VarIsNull(Value) then
    begin
      Len := 0;
      Writer.Write(Len, SizeOf(Len));
    end else
    begin
      VarToVarBytes(Value, VarBytesValue);
      Len := VarArrayHighBound(VarBytesValue, 1) + 1;
      PData := VarArrayLock(VarBytesValue);
      try
        Writer.Write(Len, SizeOf(Len));
        Writer.Write(PData^, Len);
      finally
        VarArrayUnlock(VarBytesValue);
      end;
    end;
{$ENDIF}
  end else
  begin
    if VarIsNull(Value) then
    {$IFDEF EH_LIB_6}
       Writer.WriteVariant(Unassigned)
    {$ELSE}
       WriteVariantProp(Writer, Unassigned)
    {$ENDIF}
    else if VarIsEmpty(Value) then
      raise Exception.Create('"TMemoryRecordEh.WriteData" - Invalid variant type - varEmpty')
    else
      {$IFDEF EH_LIB_6}
      Writer.WriteVariant(Value);
      {$ELSE}
      WriteVariantProp(Writer, Value);
      {$ENDIF}
  end;
end;

{ TMTBooleanDataFieldEh }

procedure TMTBooleanDataFieldEh.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TMTBooleanDataFieldEh then
  begin
    DisplayValues := TMTBooleanDataFieldEh(Source).DisplayValues;
  end;
end;

procedure TMTBooleanDataFieldEh.AssignDataType(FieldType: TFieldType);
begin
  if DataType <> ftBoolean then
    raise Exception.Create('Can not assign DataType from Field');
end;

procedure TMTBooleanDataFieldEh.AssignProps(Field: TField);
begin
  inherited AssignProps(Field);
  if (Field is TBooleanField) then
    DisplayValues := TBooleanField(Field).DisplayValues;
end;

procedure TMTBooleanDataFieldEh.AssignPropsTo(Field: TField);
begin
  inherited AssignPropsTo(Field);
  if (Field is TBooleanField) then
    TBooleanField(Field).DisplayValues := DisplayValues;
end;

constructor TMTBooleanDataFieldEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FVarDataType := GetVarDataType;
end;

function TMTBooleanDataFieldEh.GetDataType: TFieldType;
begin
  Result := ftBoolean;
end;

function TMTBooleanDataFieldEh.GetDefaultWidth: Integer;
begin
  if Length(STextFalse) > Length(STextTrue) then
    Result := Length(STextFalse) else
    Result := Length(STextTrue);
end;

procedure TMTBooleanDataFieldEh.SetDisplayValues(const Value: string);
begin
  FDisplayValues := Value;
end;

{ TMTStringDataFieldEh }

procedure TMTStringDataFieldEh.AssignDataType(FieldType: TFieldType);
begin
  case FieldType of
    ftString: FStringDataType := fdtStringEh;
    ftFixedChar: FStringDataType := fdtFixedCharEh;
    ftWideString: FStringDataType := fdtWideStringEh;
    ftGuid: FStringDataType := fdtGuidEh;
{$IFDEF EH_LIB_10}
    ftFixedWideChar: FStringDataType := fdtFixedWideCharEh;
    ftOraInterval: FStringDataType := fdtOraIntervalEh;
{$ENDIF}
  else
    raise Exception.Create('Can not assign DataType from Field');
  end;
  FVarDataType := GetVarDataType;
end;

procedure TMTStringDataFieldEh.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TMTStringDataFieldEh then
  begin
    StringDataType := TMTStringDataFieldEh(Source).StringDataType;
    FixedChar := TMTStringDataFieldEh(Source).FixedChar;
    Transliterate := TMTStringDataFieldEh(Source).Transliterate;
  end;
end;

procedure TMTStringDataFieldEh.AssignProps(Field: TField);
begin
  inherited AssignProps(Field);
  if (Field is TStringField) then
  begin
    FixedChar := TStringField(Field).FixedChar;
    Transliterate := TStringField(Field).Transliterate;
  end
end;

procedure TMTStringDataFieldEh.AssignPropsTo(Field: TField);
begin
  inherited AssignPropsTo(Field);
  if (Field is TStringField) then
  begin
    TStringField(Field).FixedChar := FixedChar;
    TStringField(Field).Transliterate := Transliterate;
  end
end;


function TMTStringDataFieldEh.CanDinaSize: Boolean;
begin
  Result := True;
end;

function TMTStringDataFieldEh.DefaultSize: Integer;
begin
  Result := 20;
end;

function TMTStringDataFieldEh.GetDataType: TFieldType;
begin
  Result := StringDataFieldsToFields[FStringDataType];
end;

procedure TMTStringDataFieldEh.SetStringDataType(
  const Value: TStringDataFieldTypesEh);
begin
  if FStringDataType <> Value then
  begin
    FStringDataType := Value;
    PropertyChanged;
    FVarDataType := GetVarDataType;
  end;
end;

function TMTStringDataFieldEh.GetDefaultWidth: Integer;
begin
  Result := Size;
  if Result > 100 then Result := 100;
end;

constructor TMTStringDataFieldEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  if Size = 0 then Size := 20; { Don't reset descendent settings }
  FVarDataType := GetVarDataType;
end;

{ TMTNumericDataFieldEh }

procedure TMTNumericDataFieldEh.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TMTNumericDataFieldEh then
  begin
    NumericDataType := TMTNumericDataFieldEh(Source).NumericDataType;
    DisplayFormat := TMTNumericDataFieldEh(Source).DisplayFormat;
    EditFormat := TMTNumericDataFieldEh(Source).EditFormat;
    currency := TMTNumericDataFieldEh(Source).currency;
    MaxValue := TMTNumericDataFieldEh(Source).MaxValue;
    MinValue := TMTNumericDataFieldEh(Source).MinValue;
    Precision := TMTNumericDataFieldEh(Source).Precision;
    if CanDinaSize then
      Scale := TMTNumericDataFieldEh(Source).Scale;
  end;
end;

procedure TMTNumericDataFieldEh.AssignDataType(FieldType: TFieldType);
begin
  case FieldType of
    ftSmallint: FNumericDataType := fdtSmallintEh;
    ftInteger: FNumericDataType := fdtIntegerEh;
    ftWord: FNumericDataType := fdtWordEh;
    ftFloat: FNumericDataType := fdtFloatEh;
    ftCurrency: FNumericDataType := fdtCurrencyEh;
    ftBCD: FNumericDataType := fdtBCDEh;
    ftAutoInc: FNumericDataType := fdtAutoIncEh;
    ftLargeint: FNumericDataType := fdtLargeintEh;
{$IFDEF EH_LIB_6}
    ftFMTBcd: FNumericDataType := fdtFMTBcdEh;
{$ENDIF}
{$IFDEF EH_LIB_12}
    ftLongWord: FNumericDataType := fdtLongWordEh;
    ftShortint: FNumericDataType := fdtShortintEh;
    ftByte: FNumericDataType := fdtByteEh;
    ftExtended: FNumericDataType := fdtExtendedEh;
{$ENDIF}
  else
    raise Exception.Create('Can not assign DataType from Field');
  end;
  FVarDataType := GetVarDataType;
end;

procedure TMTNumericDataFieldEh.AssignProps(Field: TField);
begin
  inherited AssignProps(Field);
  if (Field is TNumericField) then
  begin
    DisplayFormat := TNumericField(Field).DisplayFormat;
    EditFormat := TNumericField(Field).EditFormat;
    if (Field is TIntegerField) then
    begin
      MaxValue := TIntegerField(Field).MaxValue;
      MinValue := TIntegerField(Field).MinValue;
    end;
    if (Field is TLargeintField) then
    begin
      MaxValue := TLargeintField(Field).MaxValue;
      MinValue := TLargeintField(Field).MinValue;
    end;
    if (Field is TFloatField) then
    begin
      currency := TFloatField(Field).currency;
      MaxValue := TFloatField(Field).MaxValue;
      MinValue := TFloatField(Field).MinValue;
      Precision := TFloatField(Field).Precision;
    end;
    if (Field is TBCDField) then
    begin
      currency := TBCDField(Field).currency;
      MaxValue := TBCDField(Field).MaxValue;
      MinValue := TBCDField(Field).MinValue;
      Precision := TBCDField(Field).Precision;
      Scale := TBCDField(Field).Size;
    end;
{$IFDEF EH_LIB_6}
    if (Field is TFMTBCDField) then
    begin
      currency := TFMTBCDField(Field).currency;
//      MaxValue := TFMTBCDField(Field).MaxValue;
//      MinValue := TFMTBCDField(Field).MinValue;
      Precision := TFMTBCDField(Field).Precision;
      Scale := TFMTBCDField(Field).Size;
    end;
{$ENDIF}
  end
end;

procedure TMTNumericDataFieldEh.AssignPropsTo(Field: TField);
begin
  inherited AssignPropsTo(Field);
  if (Field is TNumericField) then
  begin
    TNumericField(Field).DisplayFormat := DisplayFormat;
    TNumericField(Field).EditFormat := EditFormat;
    if (Field is TIntegerField) then
    begin
      TIntegerField(Field).MaxValue := Trunc(MaxValue);
      TIntegerField(Field).MinValue := Trunc(MinValue);
    end;
    if (Field is TLargeintField) then
    begin
      TLargeintField(Field).MaxValue := Trunc(MaxValue);
      TLargeintField(Field).MinValue := Trunc(MinValue);
    end;
    if (Field is TFloatField) then
    begin
      TFloatField(Field).currency := currency;
      TFloatField(Field).MaxValue := MaxValue;
      TFloatField(Field).MinValue := MinValue;
      TFloatField(Field).Precision := Precision;
    end;
    if (Field is TBCDField) then
    begin
      TBCDField(Field).currency := currency;
      TBCDField(Field).MaxValue := MaxValue;
      TBCDField(Field).MinValue := MinValue;
      TBCDField(Field).Precision := Precision;
      TBCDField(Field).Size := Scale;
    end;
{$IFDEF EH_LIB_6}
    if (Field is TFMTBCDField) then
    begin
      TFMTBCDField(Field).currency := currency;
//      MaxValue := TFMTBCDField(Field).MaxValue;
//      MinValue := TFMTBCDField(Field).MinValue;
      TFMTBCDField(Field).Precision := Precision;
      TFMTBCDField(Field).Size := Scale;
    end;
{$ENDIF}
  end
end;

constructor TMTNumericDataFieldEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Alignment := taRightJustify;
  Precision := 15;
  FVarDataType := GetVarDataType;
end;

function TMTNumericDataFieldEh.GetDataType: TFieldType;
begin
  Result := NumericDataFieldsToFields[FNumericDataType];
end;

function TMTNumericDataFieldEh.GetDefaultWidth: Integer;
begin
  if NumericDataType = fdtLargeintEh then
    Result := 15
  else if (NumericDataType = fdtBCDEh) and (FPrecision > 0) then
    Result := FPrecision + 1
{$IFDEF EH_LIB_6}
  else if (NumericDataType = fdtFMTBcdEh) and (FPrecision > 0) then
    Result := FPrecision + 1
{$ENDIF}
  else
    Result := inherited GetDefaultWidth;
end;

procedure TMTNumericDataFieldEh.SetCurrency(const Value: Boolean);
begin
  if FCurrency <> Value then
  begin
    FCurrency := Value;
    PropertyChanged;
  end;
end;

procedure TMTNumericDataFieldEh.SetDisplayFormat(const Value: string);
begin
  if FDisplayFormat <> Value then
  begin
    FDisplayFormat := Value;
    PropertyChanged;
  end;
end;

procedure TMTNumericDataFieldEh.SetEditFormat(const Value: string);
begin
  if FEditFormat <> Value then
  begin
    FEditFormat := Value;
    PropertyChanged;
  end;
end;

procedure TMTNumericDataFieldEh.SetMaxValue(const Value: Double);
begin
  if FMaxValue <> Value then
  begin
    FMaxValue := Value;
    PropertyChanged;
  end;
end;

procedure TMTNumericDataFieldEh.SetMinValue(const Value: Double);
begin
  if FMinValue <> Value then
  begin
    FMinValue := Value;
    PropertyChanged;
  end;
end;

procedure TMTNumericDataFieldEh.SetNumericDataType(
  const Value: TNumericDataFieldTypesEh);
begin
  if FNumericDataType <> Value then
  begin
    FNumericDataType := Value;
    PropertyChanged;
    FVarDataType := GetVarDataType;
    if CanDinaSize and (FSize = 0) then
      FSize := DefaultSize;
  end;
end;

procedure TMTNumericDataFieldEh.SetPrecision(const Value: Integer);
begin
  if FPrecision <> Value then
  begin
    FPrecision := Value;
    PropertyChanged;
  end;
end;

function TMTNumericDataFieldEh.GetScale: Integer;
begin
  Result := Size;
end;

procedure TMTNumericDataFieldEh.SetScale(const Value: Integer);
begin
  Size := Value;
end;

function TMTNumericDataFieldEh.CanDinaSize: Boolean;
begin
  if NumericDataType in [fdtBCDEh {$IFDEF EH_LIB_6}, fdtFMTBcdEh{$ENDIF}]
    then Result := True
    else Result := False;
end;

function TMTNumericDataFieldEh.IsScaleStored: Boolean;
begin
  Result := CanDinaSize;
end;

function TMTNumericDataFieldEh.DefaultAlignment: TAlignment;
begin
  Result := taRightJustify;
end;

function TMTNumericDataFieldEh.DefaultSize: Integer;
begin
  if CanDinaSize then
    Result := 4
  else
    Result := inherited DefaultSize;
end;

{ TMTDateTimeDataFieldEh }

constructor TMTDateTimeDataFieldEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FVarDataType := GetVarDataType;
end;

procedure TMTDateTimeDataFieldEh.AssignDataType(FieldType: TFieldType);
begin
  case FieldType of
    ftDate: FDateTimeDataType := fdtDateEh;
    ftTime: FDateTimeDataType := fdtTimeEh;
    ftDateTime: FDateTimeDataType := fdtDateTimeEh;
//{$IFDEF EH_LIB_6}
//    ftTimeStamp: FDateTimeDataType := fdtTimeStampEh;
//{$ENDIF}
  else
    raise Exception.Create('Can not assign DataType from Field');
  end;
  FVarDataType := GetVarDataType;
end;

procedure TMTDateTimeDataFieldEh.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TMTDateTimeDataFieldEh then
  begin
    DateTimeDataType := TMTDateTimeDataFieldEh(Source).DateTimeDataType;
    DisplayFormat := TMTDateTimeDataFieldEh(Source).DisplayFormat;
  end;
end;

procedure TMTDateTimeDataFieldEh.AssignProps(Field: TField);
begin
  inherited AssignProps(Field);
  if (Field is TDateTimeField) then
    DisplayFormat := TDateTimeField(Field).DisplayFormat;
end;

procedure TMTDateTimeDataFieldEh.AssignPropsTo(Field: TField);
begin
  inherited AssignPropsTo(Field);
  if (Field is TDateTimeField) then
    TDateTimeField(Field).DisplayFormat := DisplayFormat;
end;

function TMTDateTimeDataFieldEh.GetDataType: TFieldType;
begin
  Result := DateTimeDataFieldsToFields[FDateTimeDataType];
end;

procedure TMTDateTimeDataFieldEh.SetDateTimeDataType(
  const Value: TDateTimeDataFieldTypesEh);
begin
  if FDateTimeDataType <> Value then
  begin
    FDateTimeDataType := Value;
    PropertyChanged;
    FVarDataType := GetVarDataType;
  end;
end;

function TMTDateTimeDataFieldEh.GetDefaultWidth: Integer;
begin
  Result := SizeOf(TDateTime) * 2 + 2;
end;

{ TMTBlobDataFieldEh }

procedure TMTBlobDataFieldEh.AssignDataType(FieldType: TFieldType);
begin
  if FieldType in [Low(TBlobType)..High(TBlobType)] then
    FBlobType := FieldType;
//  if not (Field is TBlobField) then
//    raise Exception.Create('Can not assign DataType from Field');
  FVarDataType := GetVarDataType;
end;

procedure TMTBlobDataFieldEh.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TMTBlobDataFieldEh then
  begin
    BlobType := TMTBlobDataFieldEh(Source).BlobType;
    GraphicHeader := TMTBlobDataFieldEh(Source).GraphicHeader;
    Transliterate := TMTBlobDataFieldEh(Source).Transliterate;
  end;
end;

procedure TMTBlobDataFieldEh.AssignProps(Field: TField);
begin
  inherited AssignProps(Field);
  if (Field is TBlobField) then
  begin
    BlobType := TBlobField(Field).BlobType;
    {$IFDEF FPC}
    {$ELSE}
    GraphicHeader := TBlobField(Field).GraphicHeader;
    {$ENDIF}
    Transliterate := TBlobField(Field).Transliterate;
  end;
end;

procedure TMTBlobDataFieldEh.AssignPropsTo(Field: TField);
begin
  inherited AssignPropsTo(Field);
  if (Field is TBlobField) then
  begin
    TBlobField(Field).BlobType := BlobType;
    {$IFDEF FPC}
    {$ELSE}
    TBlobField(Field).GraphicHeader := GraphicHeader;
    {$ENDIF}
    TBlobField(Field).Transliterate := Transliterate;
  end;
end;

constructor TMTBlobDataFieldEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FVarDataType := GetVarDataType;
end;

function TMTBlobDataFieldEh.GetDataType: TFieldType;
begin
  Result := BlobType;
end;

procedure TMTBlobDataFieldEh.SetBlobType(const Value: TBlobType);
begin
  if FBlobType <> Value then
  begin
    FBlobType := Value;
    PropertyChanged;
    FVarDataType := GetVarDataType;
  end;
end;

procedure TMTBlobDataFieldEh.SetGraphicHeader(const Value: Boolean);
begin
  if FGraphicHeader <> Value then
  begin
    FGraphicHeader := Value;
    PropertyChanged;
  end;
end;

procedure TMTBlobDataFieldEh.SetTransliterate(const Value: Boolean);
begin
  if FTransliterate <> Value then
  begin
    FTransliterate := Value;
    PropertyChanged;
  end;
end;

{ TMTInterfaceDataFieldEh }

procedure TMTInterfaceDataFieldEh.AssignDataType(FieldType: TFieldType);
begin
  case FieldType of
    ftInterface: FInterfaceDataType := fdtInterfaceEh;
    ftIDispatch: FInterfaceDataType := fdtIDispatchEh;
  else
    raise Exception.Create('Can not assign DataType from Field');
  end;
end;

constructor TMTInterfaceDataFieldEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FVarDataType := GetVarDataType;
end;

function TMTInterfaceDataFieldEh.GetDataType: TFieldType;
begin
  Result := InterfaceDataFieldsToFields[FInterfaceDataType];
end;

procedure TMTInterfaceDataFieldEh.SetInterfaceDataType(
  const Value: TInterfaceDataFieldTypesEh);
begin
  if FInterfaceDataType <> Value then
  begin
    FInterfaceDataType := Value;
    FVarDataType := GetVarDataType;
    PropertyChanged;
  end;
end;

{ TMTVariantDataFieldEh }

procedure TMTVariantDataFieldEh.AssignDataType(FieldType: TFieldType);
begin
  case FieldType of
    ftVariant : FVariantDataType := fdtVariant;
    ftBytes : FVariantDataType := fdtBytes;
    ftVarBytes : FVariantDataType := fdtVarBytes
  else
    raise Exception.Create('Can not assign DataType from Field');
  end;
end;

function TMTVariantDataFieldEh.CanDinaSize: Boolean;
begin
  if FVariantDataType in [fdtBytes, fdtVarBytes]
    then Result := True
    else Result := False;
end;

constructor TMTVariantDataFieldEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FVarDataType := GetVarDataType;
end;

function TMTVariantDataFieldEh.GetDataType: TFieldType;
begin
  Result := VariantDataFieldsToFields[FVariantDataType];
end;

function TMTVariantDataFieldEh.GetDefaultWidth: Integer;
begin
  Result := 15;
end;

function TMTVariantDataFieldEh.IsSizeStored: Boolean;
begin
  Result := CanDinaSize and (Size <> 16);
end;

procedure TMTVariantDataFieldEh.SetVariantDataType(
  const Value: TVariantDataFieldTypesEh);
begin
  if FVariantDataType <> Value then
  begin
    FVariantDataType := Value;
    FVarDataType := GetVarDataType;
    PropertyChanged;
  end;
end;

{ TMTRefObjectFieldEh }

function TMTRefObjectFieldEh.CanDinaSize: Boolean;
begin
  Result := True;
end;

constructor TMTRefObjectFieldEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FVarDataType := GetVarDataType;
end;

function TMTRefObjectFieldEh.GetDataType: TFieldType;
begin
  Result := ftUnknown;
end;

function TMTRefObjectFieldEh.GetVarDataType: TVarType;
begin
  Result := varInteger;
end;

procedure TMTRefObjectFieldEh.AssignDataType(FieldType: TFieldType);
begin
  if FieldType <> ftUnknown then
    raise Exception.Create('Can not assign DataType from Field');
end;


{$IFDEF EH_LIB_6}

{ TMTSQLTimeStampDataFieldEh }

constructor TMTSQLTimeStampDataFieldEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FVarDataType := GetVarDataType;
end;

procedure TMTSQLTimeStampDataFieldEh.AssignDataType(FieldType: TFieldType);
begin
  case FieldType of
    ftTimeStamp: FSQLTimeStampDataFieldType := fdtTimeStampEh;
{$IFDEF EH_LIB_10}
    ftOraTimeStamp: FSQLTimeStampDataFieldType := fdtOraTimeStampEh;
{$ENDIF}
  else
    raise Exception.Create('Can not assign DataType from Field');
  end;
  FVarDataType := GetVarDataType;
end;

procedure TMTSQLTimeStampDataFieldEh.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TMTSQLTimeStampDataFieldEh then
  begin
    SQLTimeStampDataFieldType := TMTSQLTimeStampDataFieldEh(Source).SQLTimeStampDataFieldType;
    DisplayFormat := TMTSQLTimeStampDataFieldEh(Source).DisplayFormat;
  end;
end;

procedure TMTSQLTimeStampDataFieldEh.AssignProps(Field: TField);
begin
  inherited AssignProps(Field);
  {$IFDEF FPC}
  {$ELSE}
  if (Field is TSQLTimeStampField) then
    DisplayFormat := TSQLTimeStampField(Field).DisplayFormat;
  {$ENDIF}
end;

procedure TMTSQLTimeStampDataFieldEh.AssignPropsTo(Field: TField);
begin
  inherited AssignPropsTo(Field);
  {$IFDEF FPC}
  {$ELSE}
  if (Field is TSQLTimeStampField) then
    TSQLTimeStampField(Field).DisplayFormat := DisplayFormat;
  {$ENDIF}
end;

function TMTSQLTimeStampDataFieldEh.GetDataType: TFieldType;
begin
  Result := SQLTimeStampDataFieldsToFields[SQLTimeStampDataFieldType];
end;

{$ENDIF}

{ TMemoryRecordEh }

constructor TMemoryRecordEh.Create;
begin
  inherited Create;
  FData := nil;
  FUpdateStatus := usUnmodified;
  FUpdateIndex := -1;
  FEditState := resInsertEh;
  FIndex := -1;
end;

destructor TMemoryRecordEh.Destroy;
var
  i: Integer;
begin
  if Index >= 0 then
    RecordsList.CheckForDestroyRecord(Self);
//  MergeChanges;
  for i := 0 to Length(FData) - 1 do
    FData[i] := Null;
  FData := nil;
  for i := 0 to Length(FOldData) - 1 do
    FOldData[i] := Null;
  FOldData := nil;
  for i := 0 to Length(FTmpOldRecValue) - 1 do
    FTmpOldRecValue[i] := Null;
  FTmpOldRecValue := nil;
  FreeAndNil(FUpdateError);
  inherited Destroy;
end;

function TMemoryRecordEh.GetAttached: Boolean;
begin
  Result := (Index <> -1);
end;

procedure TMemoryRecordEh.Edit;
begin
  if FEditState <> resBrowseEh then Exit;
  FEditState := resEditEh;
  FEditChanged := False;
//  New(FTmpOldRecValue);
  FTmpOldRecValue := Copy(FData, 0, Length(FData));
end;

procedure TMemoryRecordEh.EditForRefresh;
begin
  if FEditState in [resEditEh, resInsertEh] then
    raise Exception.Create('procedure TMemoryRecordEh.EditForRefresh: The MemoryRecord is in resEditEh state.');
  FEditState := resEditForRefresh;
  FEditChanged := False;
end;

procedure TMemoryRecordEh.Post;
begin
  if not (EditState in mrEditStatesEh) then
  {$IFDEF FPC}
    raise EDatabaseError.Create('SNotEditing');
  {$ELSE}
    raise EDatabaseError.Create(SNotEditing);
  {$ENDIF}
  if FEditState = resInsertEh then
  begin
    RecordsList.AddRecord(Self);
  end else if FEditState = resEditEh then
  begin
    RecordsList.Notify(Self, GetIndex, rlnRecChangingEh);
    if RecordsList.CachedUpdates then
    begin
      if FUpdateStatus = usUnmodified then
        FUpdateStatus := usModified;
      if FUpdateIndex = -1 then
        FUpdateIndex := RecordsList.FDeltaList.Add(Self);
      if (FUpdateStatus = usModified) and (FOldData = nil) then
        FOldData := FTmpOldRecValue;
      FTmpOldRecValue := nil;
    end else
    begin
      //Dispose(FTmpOldRecValue);
      RecordsList.ApplyUpdateFor(Self, usModified);
      FTmpOldRecValue := nil;
    end;
    FEditState := resBrowseEh;
    RecordsList.Notify(Self, GetIndex, rlnRecChangedEh);
  end else if FEditState = resEditForRefresh then
  begin
    FEditState := resBrowseEh;
    RecordsList.Notify(Self, GetIndex, rlnRecChangedEh); 
  end else if FEditState = resBrowseEh then
  begin
    raise EDatabaseError.Create('procedure TMemoryRecordEh.Post: The Record not in edit or insert mode');
  end;
end;

procedure TMemoryRecordEh.Cancel;
begin
  if not (EditState in mrEditStatesEh) then
  {$IFDEF FPC}
    EDatabaseError.Create('SNotEditing');
  {$ELSE}
    EDatabaseError.Create(SNotEditing);
  {$ENDIF}
  if FEditState = resInsertEh then
  begin
     Free;
  end else
  begin
//    Dispose(FTmpOldRecValue);
    FData := FTmpOldRecValue;
    FTmpOldRecValue := nil;
  end;
  FEditState := resBrowseEh;
end;

procedure TMemoryRecordEh.MergeChanges;
begin
//  if FOldData = nil then Exit;
  if UpdateStatus = usUnmodified then Exit;
  if UpdateStatus = usDeleted then
    RecordsList.PersistRemoveRecord(Self.Index);
  FOldData := nil;
  FUpdateStatus := usUnmodified;
  if FUpdateIndex >= 0 then
  begin
    RecordsList.DeltaList[FUpdateIndex] := nil;
    FUpdateIndex := -1;
  end;
  if FUpdateError <> nil then
  begin
    FreeAndNil(FUpdateError);
  end;
end;

function TMemoryRecordEh.GetIndex: Integer;
begin
  Result := FIndex;
{  if FRecordsList <> nil then
    Result := FRecordsList.IndexOf(Self) else
    Result := -1;}
end;

procedure TMemoryRecordEh.SetIndex(Value: Integer);
var
  CurIndex: Integer;
begin
  CurIndex := GetIndex;
  if (CurIndex >= 0) and (CurIndex <> Value) then
    FRecordsList.Move(CurIndex, Value);
end;

procedure TMemoryRecordEh.RevertRecord;
begin
  case FUpdateStatus of
    usModified:
      begin
//        Dispose(FData);
        RecordsList.Notify(Self, Index, rlnRecChangingEh);
        FData := FOldData;
        FOldData := nil;
        FUpdateStatus := usUnmodified;
        RecordsList.Notify(Self, Index, rlnRecChangedEh);
      end;
    usDeleted:
      begin
        RecordsList.Notify(Self, Index, rlnRecChangingEh);
        FUpdateStatus := usUnmodified;
        RecordsList.Notify(Self, Index, rlnRecChangedEh);
      end;
  end;
  if FUpdateError <> nil then
  begin
    FreeAndNil(FUpdateError);
  end;
end;

procedure TMemoryRecordEh.RefreshRecord(Rec: TMemoryRecordEh);
begin
  if FUpdateStatus = usModified
    then FOldData := Copy(Rec.Data)
    else FData := Copy(Rec.Data);
end;

procedure TMemoryRecordEh.SetUpdateStatus(const Value: TUpdateStatus);
begin
  FUpdateStatus := Value;
end;

procedure TMemoryRecordEh.ReadData(Reader: TReader);
var
//  v: Variant;
  i: Integer;
begin
  Reader.ReadListBegin;
  for i := 0 to Length(Data)-1 do
  begin
    DataStruct[i].ReadDataFromReader(Data[i], Reader);

(*{$IFDEF EH_LIB_6}
    v := Reader.ReadVariant;
{$ELSE}
    v := ReadVariantProp(Reader);
{$ENDIF}
    if VarIsEmpty(v) then
      Data[i] := Null
    else
      VarCast(Data[i], v, DataStruct[i].GetVarDataType);
*)
  end;
  Reader.ReadListEnd;
end;

procedure TMemoryRecordEh.WriteData(Writer: TWriter);
var
  i: Integer;
begin
  Writer.WriteListBegin;
  for i := 0 to Length(Data)-1 do
  begin
    DataStruct[i].WriteDataToWriter(Data[i], Writer);
(*
    if VarIsNull(Data[i]) then
{$IFDEF EH_LIB_6}
    Writer.WriteVariant(Unassigned)
{$ELSE}
    WriteVariantProp(Writer, Unassigned)
{$ENDIF}
    else if VarIsEmpty(Data[i]) then
      raise Exception.Create('"TMemoryRecordEh.WriteData" - Invalid variant type - varEmpty')
    else
{$IFDEF EH_LIB_6}
      Writer.WriteVariant(Data[i]);
{$ELSE}
      WriteVariantProp(Writer, Data[i]);
{$ENDIF}
*)
  end;
  Writer.WriteListEnd;
end;

function TMemoryRecordEh.GetDataStruct: TMTDataStructEh;
begin
//  Result := RecordsList.DataStruct;
  Result := FDataStruct;
end;

function TMemoryRecordEh.GetDataValues(const FieldNames: string; DataValueVersion: TDataValueVersionEh): Variant;
var
  I: Integer;
  Fields: TObjectList;
begin
  if (DataValueVersion = dvvOldValueEh) and (FOldData = nil) then
    raise Exception.Create('TMemoryRecordEh.GetDataValues: Old values is not accessible.');
  if Pos(';', FieldNames) <> 0 then
  begin
    Fields := TObjectList.Create(False);
    try
      DataStruct.GetFieldList(Fields, FieldNames);
      Result := VarArrayCreate([0, Fields.Count - 1], varVariant);
      for I := 0 to Fields.Count - 1 do
        Result[I] := Value[TMTDataFieldEh(Fields[I]).Index, DataValueVersion];
    finally
      Fields.Free;
    end;
  end else
  begin
    I := DataStruct.FieldIndex(FieldNames);
    if I = -1 then
  {$IFDEF FPC}
      DatabaseErrorFmt('SFieldNotFound', [FieldNames]);
  {$ELSE}
      DatabaseErrorFmt(SFieldNotFound, [FieldNames]);
  {$ENDIF}
    Result := Value[I, DataValueVersion];
  end;
end;

procedure TMemoryRecordEh.SetDataValues(const FieldNames: string;
  DataValueVersion: TDataValueVersionEh; const VarValue: Variant);
var
  I: Integer;
  Fields: TObjectList;
begin
  if Pos(';', FieldNames) <> 0 then
  begin
    Fields := TObjectList.Create(False);
    try
      DataStruct.GetFieldList(Fields, FieldNames);
      for I := 0 to Fields.Count - 1 do
        Value[TMTDataFieldEh(Fields[I]).Index, DataValueVersion] := VarValue[I];
    finally
      Fields.Free;
    end;
  end else
    Value[DataStruct.FieldIndex(FieldNames), DataValueVersion] := VarValue;
end;

function TMemoryRecordEh.GetDataIndexValues(const FieldIndexes: TIntArray; DataValueVersion: TDataValueVersionEh): Variant;
var
  I: Integer;
begin
  for I := 0 to Length(FieldIndexes) - 1 do
    Result := Value[FieldIndexes[I], DataValueVersion];
end;

procedure TMemoryRecordEh.SetDataIndexValues(const FieldIndexes: TIntArray; DataValueVersion: TDataValueVersionEh; const VarValue: Variant);
var
  I: Integer;
begin
  if Length(FieldIndexes) > 1 then
    for I := 0 to Length(FieldIndexes) - 1 do
      Value[FieldIndexes[I], DataValueVersion] := VarValue[I]
  else
    Value[FieldIndexes[0], DataValueVersion] := VarValue;
end;

function TMemoryRecordEh.GetDataValue(const FieldIndex: Integer;
  DataValueVersion: TDataValueVersionEh): Variant;
begin
//dvvOldValueEh, dvvCurValueEh, dvvEditValueEh, dvvValueEh, dvvOldestValue
  if (FieldIndex < 0) or (FieldIndex >= DataStruct.Count) then
    raise EListError.CreateFmt(SListIndexError, [FieldIndex]);
  Result := Unassigned;
  if (DataValueVersion = dvvOldValueEh) and (FOldData = nil) then
    raise Exception.Create('TMemoryRecordEh.GetDataValues: Old values is not accessible.');
  if (DataValueVersion = dvvEditValueEh) and (FTmpOldRecValue = nil) then
    raise Exception.Create('TMemoryRecordEh.GetDataValues: Edit values is not accessible.');

  if DataValueVersion = dvvValueEh then
    Result := Data[FieldIndex]
  else if DataValueVersion = dvvEditValueEh then
    Result := Data[FieldIndex]
  else if DataValueVersion = dvvOldValueEh then
    Result := OldData[FieldIndex]
  else if (DataValueVersion = dvvOldestValue) and (OldData <> nil) then
    if (OldData <> nil)
      then Result := OldData[FieldIndex]
      else Result := Data[FieldIndex]
  else if (DataValueVersion = dvvRefreshValue) then
    if (OldData <> nil)
      then Result := OldData[FieldIndex]
      else Result := Data[FieldIndex]
  else if DataValueVersion in [dvvCurValueEh, dvvOldestValue] then
    if (FTmpOldRecValue <> nil)
      then Result := FTmpOldRecValue[FieldIndex]
      else Result := Data[FieldIndex];
end;

procedure TMemoryRecordEh.SetDataValue(const FieldIndex: Integer;
  DataValueVersion: TDataValueVersionEh; const Value: Variant);
var
  CastDataType: TVarType;
  ADataStruct: TMTDataStructEh;
begin
  ADataStruct := DataStruct;
  if (FieldIndex < 0) or (FieldIndex >= ADataStruct.Count) then
    raise EListError.CreateFmt(SListIndexError, [FieldIndex]);
  if (DataValueVersion = dvvOldValueEh) and (FOldData = nil) then
    raise Exception.Create('TMemoryRecordEh.GetDataValues: Old values is not accessible.');
  if (DataValueVersion = dvvEditValueEh) and (FTmpOldRecValue = nil) then
    raise Exception.Create('TMemoryRecordEh.GetDataValues: Edit values is not accessible.');

{  if ADataStruct[FieldIndex] is TMTRefObjectFieldEh then
    DataVarCastAsObject(Data[FieldIndex], Value)
  else}
  begin
//    CastDataType := ADataStruct[FieldIndex].GetVarDataType;
    CastDataType := ADataStruct[FieldIndex].FVarDataType;
    if DataValueVersion = dvvValueEh then
      DataVarCast(Data[FieldIndex], Value, CastDataType)
    else if DataValueVersion = dvvEditValueEh then
      DataVarCast(Data[FieldIndex], Value, CastDataType)
    else if DataValueVersion = dvvOldValueEh then
      DataVarCast(OldData[FieldIndex], Value, CastDataType)
    else if (DataValueVersion = dvvOldestValue) and (OldData <> nil) then { TODO : (OldData <> nil) ? }
      if (OldData <> nil)
        then DataVarCast(OldData[FieldIndex], Value, CastDataType)
        else DataVarCast(Data[FieldIndex], Value, CastDataType)
    else if (DataValueVersion = dvvRefreshValue) then
      if (OldData <> nil)
        then DataVarCast(OldData[FieldIndex], Value, CastDataType)
        else DataVarCast(Data[FieldIndex], Value, CastDataType)
    else if DataValueVersion in [dvvCurValueEh, dvvOldestValue] then
      if (FTmpOldRecValue <> nil)
        then DataVarCast(FTmpOldRecValue[FieldIndex], Value, CastDataType)
        else DataVarCast(Data[FieldIndex], Value, CastDataType);
  end;
end;

function TMemoryRecordEh.EditState: TRecordEditStateEh;
begin
  Result := FEditState;
end;

{ TRecordsListNotificatorEh }

constructor TRecordsListNotificatorEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TRecordsListNotificatorEh.Destroy;
begin
//  RecordsList := nil;
//  MemTableData := nil;
  DataObject := nil;
  inherited Destroy;
end;

procedure TRecordsListNotificatorEh.DataEvent(MemRec: TMemoryRecordEh;
  Index: Integer; Action: TRecordsListNotification);
begin
  if Assigned(FOnDataEvent) then
    FOnDataEvent(MemRec, Index, Action);
  case Action of
    rlnRecAddedEh: RecordAdded(MemRec, Index);
    rlnRecChangedEh: RecordChanged(MemRec, Index);
    rlnRecDeletedEh: RecordDeleted(MemRec, Index);
    rlnListChangedEh: RecordListChanged;
  end;
end;

procedure TRecordsListNotificatorEh.AfterDataEvent(MemRec: TMemoryRecordEh;
  Index: Integer; Action: TRecordsListNotification);
begin
  if Assigned(FOnAfterDataEvent) then
    FOnAfterDataEvent(MemRec, Index, Action);
end;

procedure TRecordsListNotificatorEh.RecordAdded(MemRec: TMemoryRecordEh; Index: Integer);
begin
end;

procedure TRecordsListNotificatorEh.RecordChanged(MemRec: TMemoryRecordEh; Index: Integer);
begin
end;

procedure TRecordsListNotificatorEh.RecordDeleted(MemRec: TMemoryRecordEh; Index: Integer);
begin
end;

procedure TRecordsListNotificatorEh.RecordListChanged;
begin
end;

{procedure TRecordsListNotificatorEh.SetRecordsList(const Value: TRecordsListEh);
begin
  if Value = FRecordsList then Exit;
  if FRecordsList <> nil then FRecordsList.RemoveNotificator(Self);
  if Value <> nil then Value.AddNotificator(Self);
  FRecordsList := Value;
end;}

procedure TRecordsListNotificatorEh.SetMemTableData(const Value: TMemTableDataEh);
begin
  if Value = FMemTableData then Exit;
  DataEvent(nil, -1, rlnListChangingEh);
  if FMemTableData <> nil then
  begin
    FMemTableData.RemoveNotificator(Self);
    FMemTableData.RemoveFreeNotification(Self);
  end;
  if Value <> nil then
  begin
    Value.AddNotificator(Self);
    Value.FreeNotification(Self);
  end;
  FMemTableData := Value;
  DataEvent(nil, -1, rlnListChangedEh);
end;

procedure TRecordsListNotificatorEh.SetDataObject(const Value: TComponent);
begin
  if Value = FDataObject then Exit;
  DataEvent(nil, -1, rlnListChangingEh);
  if FDataObject <> nil then
  begin
    if FDataObject is TMemTableDataEh then
    begin
      TMemTableDataEh(FDataObject).RemoveNotificator(Self);
      TMemTableDataEh(FDataObject).RemoveFreeNotification(Self);
    end else if FDataObject is TRecordsViewEh then
    begin
      TRecordsViewEh(FDataObject).RemoveNotificator(Self);
      TRecordsViewEh(FDataObject).RemoveFreeNotification(Self);
    end;
  end;
  if Value <> nil then
  begin
    if Value is TMemTableDataEh then
    begin
      TMemTableDataEh(Value).AddNotificator(Self);
      TMemTableDataEh(Value).FreeNotification(Self);
    end else if Value is TRecordsViewEh then
    begin
      TRecordsViewEh(Value).AddNotificator(Self);
      TRecordsViewEh(Value).FreeNotification(Self);
    end;
  end;
  FDataObject := Value;
  DataEvent(nil, -1, rlnListChangedEh);
end;

procedure TRecordsListNotificatorEh.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
//    if MemTableData = AComponent then
//      MemTableData := nil;
    if DataObject = AComponent then
      DataObject := nil;
end;

function TRecordsListNotificatorEh.FetchRecords(Count: Integer): Integer;
begin
  Result := 0;
  if Assigned(FOnFetchRecords) then
    Result := OnFetchRecords(Count);
end;

procedure TRecordsListNotificatorEh.ApplyUpdates(
  AMemTableData: TMemTableDataEh);
begin
  if Assigned(OnApplyUpdates) then
    OnApplyUpdates(AMemTableData);
end;

procedure TRecordsListNotificatorEh.RecordMoved(Item: TMemoryRecordEh;
  OldIndex, NewIndex: Integer);
begin
  if Assigned(OnRecordMoved) then
    OnRecordMoved(Item, OldIndex, NewIndex);
end;

procedure TRecordsListNotificatorEh.StructChanged(AMemTableData: TMemTableDataEh);
begin
  if Assigned(OnStructChanged) then
    OnStructChanged(AMemTableData);
end;

{ TRecordsListEh }

//constructor TRecordsListEh.Create(AMemTableData: TMemTableDataEh);
constructor TRecordsListEh.Create(AOwner: TComponent);
begin
  inherited Create(nil);
  FItemClass := TMemoryRecordEh;
//  FNotificators := TObjectList.Create(False);
  FDeltaList := TObjectList.Create(False);
  FNewHashCode := 1;
  FRecList := TObjectList.Create(False);
  FDeletedList := TObjectList.Create(False);
  if AOwner is TMemTableDataEh then
    FMemTableData :=  TMemTableDataEh(AOwner)
  else if AOwner <> nil then
    raise Exception.Create(AOwner.ClassName);
//    ShowMessage(AOwner.ClassName);
  FCachedUpdates := False;
{  FKeyIndex := TMTIndexEh.CreateApart(Self);
  FKeyIndex.Primary := True;
  FKeyIndex.Unical := True;
  FKeyIndex.Active := True;}
  FIndexes := TMTIndexesEh.Create(Self);
end;

destructor TRecordsListEh.Destroy;
var
  i: Integer;
begin
  for i := 0 to FRecList.Count-1 do
    Rec[i].FUpdateIndex := -1;
//  while FNotificators.Count > 0 do
////    TRecordsListNotificatorEh(FNotificators[0]).RecordsList := nil;
//    TRecordsListNotificatorEh(FNotificators[0]).MemTableData := nil;
//  FNotificators.Free;
  Clear;
  FreeAndNil(FDeltaList);
  FreeAndNil(FRecList);
  FreeDeletedRecords;
  FreeAndNil(FDeletedList);
//  FKeyIndex.Free;
  FreeAndNil(FIndexes);
  inherited Destroy;
end;

function TRecordsListEh.NewRecord: TMemoryRecordEh;
begin
{  if FDeletedList.Count > 0 then
  begin
    Result := TMemoryRecordEh(FDeletedList[FDeletedList.Count-1]);
    FDeletedList.Delete(FDeletedList.Count-1);
    Result.FEditChanged := False;
//    Result.FData :=
    Result.FOldData := nil;
    Result.FRecordsList := nil;
    Result.FTmpOldRecValue := nil;
    Result.FUpdateIndex := -1;
    Result.FUpdateStatus := usUnmodified;
    Result.FHashCode := 0;
    Result.FEditState := resInsertEh;
    Result.FUpdateError := nil;
    Result.FIndex := -1;
  end else}
  Result := TMemoryRecordEh.Create;
  Result.FHashCode := NewHashCode;
  SetLength(Result.FData, RecValCount);
  InitRecord(Result.Data);
  Result.FRecordsList := Self;
  Result.FDataStruct := Self.DataStruct;
end;

procedure TRecordsListEh.SetAutoIncValue(Rec: TMemoryRecordEh);
begin
  MemTableData.SetAutoIncValue(Rec);
end;

function TRecordsListEh.AddInsertRecord(Rec: TMemoryRecordEh; Index: Integer; Append: Boolean; Fetching: Boolean): Integer;
begin
  if Rec.RecordsList <> Self then
    raise Exception.Create('Record.RecordsList is not the same.');
  if Rec.Attached then
    raise Exception.Create('The record is already attached to RecordsList.');

  if Append
    then Result := FRecList.Count
    else Result := Index;

  Notify(Rec, Result, rlnRecAddingEh);

  if not Fetching then
    SetAutoIncValue(Rec);

  if not CachedUpdates and not Fetching and FMemTableData.CheckApplyUpdatesConsumers then
    ApplyUpdateFor(Rec, usInserted);

  if Append then
  begin
    Result := FRecList.Add(Rec);
    Rec.FIndex := Result;
  end else
  begin
    FRecList.Insert(Index, Rec);
    Result := Index;
    Rec.FIndex := Result;
    ReIndexRecs(Index + 1, Count-1);
  end;

  Rec.FRecordsList := Self;
  if CachedUpdates then
  begin
    Rec.FUpdateStatus := usInserted;
    if Rec.FUpdateIndex = -1 then
      Rec.FUpdateIndex := FDeltaList.Add(Rec);
  end else
    Rec.FUpdateStatus := usUnmodified;
  Rec.FEditState := resBrowseEh;
  Notify(Rec, Result, rlnRecAddedEh);
end;

function TRecordsListEh.AddRecord(Rec: TMemoryRecordEh): Integer;
begin
  Result := AddInsertRecord(Rec, -1, True, False);
end;

procedure TRecordsListEh.InsertRecord(Index: Integer; Rec: TMemoryRecordEh);
begin
  AddInsertRecord(Rec, Index, False, False);
end;

procedure TRecordsListEh.DeleteRecord(Index: Integer);
var
  ARec: TMemoryRecordEh;
begin
  if CachedUpdates then
  begin
    ARec := Rec[Index];
    if ARec.FUpdateStatus = usDeleted then
      raise Exception.Create('Can''t MarkDel the Deleted record');

    if ARec.FUpdateStatus = usInserted then
    begin
      if ARec.FUpdateIndex >= 0 then
        FDeltaList.Items[Rec[Index].FUpdateIndex] := nil;
      Rec[Index].FUpdateIndex := -1;
      PersistDeleteRecord(Index);
    end else
    begin
      ARec.MergeChanges;
      ARec.FUpdateStatus := usDeleted;
      if ARec.FUpdateIndex = -1 then
        ARec.FUpdateIndex := FDeltaList.Add(Rec[Index]);
      Notify(ARec, Index, rlnRecMarkedForDelEh);
    end;
  end else
    PersistDeleteRecord(Index);
end;

procedure TRecordsListEh.DeleteRecords(const RecordsRanges: array of TRecordsRangeEh);
begin
  if CachedUpdates then
    raise Exception.Create('Delete a range of record in CachedUpdates mode is not supported')
  else
    PersistDeleteRecords(RecordsRanges);
end;

procedure TRecordsListEh.PersistDeleteRecord(Index: Integer);
var
  DelRec: TMemoryRecordEh;
begin
  DelRec := Rec[Index];
  Notify(DelRec, Index, rlnRecDeletingEh);
  if not CachedUpdates then
    ApplyUpdateFor(DelRec, usDeleted);
  Delete(Index);
  Notify(DelRec, Index, rlnRecDeletedEh);
//  FDeletedList.Add(DelRec);
  FreeAndNil(DelRec);
end;

procedure TRecordsListEh.PersistDeleteRecords(const RecordsRanges: array of TRecordsRangeEh);
var
//  DelRecs: TList;
  DelRec: TMemoryRecordEh;
  i,k: Integer;
begin
//  DelRecs := TList.Create;
  for i := 0 to Length(RecordsRanges) - 1 do
  begin
    for k := RecordsRanges[i].LowIndex to RecordsRanges[i].HighIndex do
    begin
      DelRec := TMemoryRecordEh(FRecList.Items[k]);
      if not CachedUpdates then
        ApplyUpdateFor(DelRec, usDeleted);
      FRecList.Items[k] := nil;
//      DelRecs.Add(DelRec);
      FreeAndNil(DelRec);
    end;
  end;
  FRecList.Pack;
//  FreeAndNil(DelRecs);
  Notify(nil, -1, rlnListChangedEh);
end;

procedure TRecordsListEh.PersistRemoveRecord(Index: Integer);
var
  DelRec: TMemoryRecordEh;
begin
  DelRec := Rec[Index];
  Notify(DelRec, Index, rlnRecDeletingEh);
  FDeletedList.Add(DelRec);
  Delete(Index);
  Notify(DelRec, Index, rlnRecDeletedEh);
end;

function TRecordsListEh.GetValue(RecNo, ValNo: Integer): Variant;
begin
  Result := Rec[RecNo].Data[ValNo];
end;

procedure TRecordsListEh.Notify(MemRec: TMemoryRecordEh; Index: Integer;
  Action: TRecordsListNotification);
begin
  if FUpdateCount = 0 then
  begin
    Indexes.RLDataEvent(MemRec, Index, Action);
    FMemTableData.Notify(MemRec, Index, Action);
  end;
end;

procedure TRecordsListEh.SetValue(RecNo, ValNo: Integer; const Value: Variant);
//var
//  OldRecValue: TRecDataValues;
begin
  Notify(Rec[RecNo], RecNo, rlnRecChangingEh);
//  OldRecValue := Rec[RecNo].Data;
  Rec[RecNo].Data[ValNo] := Value;
  Notify(Rec[RecNo], RecNo, rlnRecChangedEh);
end;

{procedure TRecordsListEh.AddNotificator(RecordsList: TRecordsListNotificatorEh);
begin
  FNotificators.Add(RecordsList);
end;

procedure TRecordsListEh.RemoveNotificator(RecordsList: TRecordsListNotificatorEh);
begin
  FNotificators.Remove(RecordsList);
end;
}

procedure TRecordsListEh.InitRecord(RecValues: TRecDataValues);
var
  i: Integer;
begin
  for i := 0 to RecValCount-1 do
//    RecValues[i] := Null;
    VarSetNull(RecValues[i]);
end;

procedure TRecordsListEh.Clear;
var
  i: Integer;
begin
  FDeletedList.Clear;
  FDeltaList.Clear;
  for i := 0 to FIndexes.Count - 1 do
    FIndexes.Items[i].ClearIndex;
//  CancelUpdates;
  for i := 0 to FRecList.Count - 1 do
  begin
//    FDeletedList.Add(Rec[i]);
    Rec[i].FIndex := -1;
    Rec[i].Free;
  end;
  FRecList.Clear;
  Notify(nil, -1, rlnListChangedEh);
end;

function TRecordsListEh.GetRec(Index: Integer): TMemoryRecordEh;
begin
  Result := TMemoryRecordEh(FRecList.Items[Index]);
end;

procedure TRecordsListEh.SetRec(Index: Integer; const Value: TMemoryRecordEh);
begin
  FRecList.Items[Index] := Value;
end;

procedure TRecordsListEh.SetCachedUpdates(const Value: Boolean);
begin
  FCachedUpdates := Value;
end;

procedure TRecordsListEh.QuickSort(L, R: Integer; Compare: TCompareRecords; ParamSort: TObject);
var
  I, J: Integer;
  P: TMemoryRecordEh;
begin
  repeat
    I := L;
    J := R;
    P := Rec[(L + R) shr 1];
    repeat
      while Compare(Rec[I], P, ParamSort) < 0 do
        Inc(I);
      while Compare(Rec[J], P, ParamSort) > 0 do
        Dec(J);
      if I <= J then
      begin
        FRecList.Exchange(I, J);
        Inc(I);
        Dec(J);
      end;
    until I > J;
    if L < J then
      QuickSort(L, J, Compare, ParamSort);
    L := I;
  until I >= R;
end;

procedure TRecordsListEh.SortData(Compare: TCompareRecords; ParamSort: TObject);
begin
  QuickSort(0, FRecList.Count-1, Compare, ParamSort);
  ReIndexRecs(0, Count-1);
  Notify(nil, -1, rlnListChangedEh);
end;

function TRecordsListEh.NewHashCode: LongWord;
begin
  Result := FNewHashCode;
  Inc(FNewHashCode);
end;

procedure TRecordsListEh.RevertRecord(Index: Integer);
begin
  if Rec[Index].UpdateStatus = usInserted then
    PersistDeleteRecord(Index)
  else
    Rec[Index].RevertRecord;
end;

procedure TRecordsListEh.RefreshRecord(Index: Integer; FromRec: TMemoryRecordEh);
begin
  Rec[Index].RefreshRecord(FromRec);
end;

function TRecordsListEh.IndexOf(Item: TMemoryRecordEh): Integer;
begin
  Result := FRecList.IndexOf(Item);
end;

procedure TRecordsListEh.Move(CurIndex, NewIndex: Integer);
begin
  if CurIndex = NewIndex then Exit;
  FRecList.Move(CurIndex, NewIndex);
  if NewIndex < CurIndex
    then ReIndexRecs(NewIndex, Count-1)
    else ReIndexRecs(CurIndex, Count-1);
  RecordMoved(Rec[NewIndex], CurIndex, NewIndex);
end;

function TRecordsListEh.Delete(Index: Integer): TMemoryRecordEh;
begin
  Result := Rec[Index];
  FRecList.Delete(Index);
  ReIndexRecs(Index, Count-1);
end;

function RecordsListDataEqual(List1, List2: TRecordsListEh): Boolean;
var
  S1, S2: TMemoryStream;

  {$HINTS OFF}
  procedure WriteRecordsList(Stream: TStream; AList1: TRecordsListEh);
  var
    Writer: TWriter;
  begin
    Writer := TWriter.Create(Stream, 1024);
    try
      Writer.DefineProperty('Data', AList1.ReadData, AList1.WriteData, True);
    finally
      Writer.Free;
    end;
  end;
  {$HINTS ON}

begin
  Result := False;
  if List1.ClassType <> List2.ClassType then Exit;
  S1 := TMemoryStream.Create;
  try
    WriteRecordsList(S1, List1);
    S2 := TMemoryStream.Create;
    try
      WriteRecordsList(S2, List2);
      Result := (S1.Size = S2.Size) and CompareMem(S1.Memory, S2.Memory, S1.Size);
    finally
      S2.Free;
    end;
  finally
    S1.Free;
  end;
end;

procedure TRecordsListEh.DefineProperties(Filer: TFiler);
var
  StoreIt: Boolean;
begin
  if Filer.Ancestor = nil then
    StoreIt := not IsEmpty
  else
  begin
    StoreIt := (not RecordsListDataEqual(Self, TRecordsListEh(Filer.Ancestor)));
//    ShowMessage('Filer.Ancestor is ' + Filer.Ancestor.ClassName);
  end;

  Filer.DefineProperty('Data', ReadData, WriteData, StoreIt);
end;

function TRecordsListEh.IsEmpty: Boolean;
begin
  Result := (FRecList.Count = 0);
end;

procedure TRecordsListEh.ReadData(Reader: TReader);
var
  Rec: TMemoryRecordEh;
begin
  { TODO : Lock send notification about changes in RecordsList }
  Clear;
  with Reader do
  begin
    ReadListBegin;
    while not Reader.EndOfList do
    begin
      Rec := NewRecord;
      Rec.ReadData(Reader);
      FetchRecord(Rec);
//      AddRecord(Rec);
    end;
    ReadListEnd;
  end;
end;

procedure TRecordsListEh.WriteData(Writer: TWriter);
var
  i: Integer;
begin
  with Writer do
  begin
    WriteListBegin;
    for i := 0 to FRecList.Count-1 do
    begin
      Rec[i].WriteData(Writer);
    end;
    WriteListEnd;
  end;
end;

function TRecordsListEh.GetDataStruct: TMTDataStructEh;
begin
  Result := MemTableData.DataStruct;
end;

function TRecordsListEh.GetCount: Integer;
begin
  Result := FRecList.Count;
end;

function TRecordsListEh.GeRecValCount: Integer;
begin
  Result := MemTableData.DataStruct.Count;
end;

function TRecordsListEh.HasCachedChanges: Boolean;
begin
  Result := (DeltaList.Count > 0);
end;

procedure TRecordsListEh.CancelUpdates;
var
  i: Integer;
  DeltaIndex: Integer;
begin
  for i := FRecList.Count - 1 downto 0 do
  begin
    with Rec[i] do
      case UpdateStatus of
        usModified:
          begin
            if FOldData = nil then Exit;
            FData := nil;
            FData := FOldData;
            FOldData := nil;
            FUpdateStatus := usUnmodified;
            Rec[i].UpdateIndex := -1;
          end;
        usInserted:
          begin
            DeltaIndex := FDeltaList.IndexOf(Rec[i]);
            if DeltaIndex >= 0 then
              FDeltaList[DeltaIndex] := nil;
            Delete(Index).Free;
          end;
        usDeleted:
          begin
            FUpdateStatus := usUnmodified;
            Rec[i].UpdateIndex := -1;
          end;
      end;
  end;
  FDeltaList.Clear;
  Notify(nil, -1, rlnListChangedEh);
end;

procedure TRecordsListEh.MergeChangeLog;
var
  i: Integer;
begin
  for i := 0 to DeltaList.Count-1 do
    if (TMemoryRecordEh(DeltaList[i]) <> nil) then
      TMemoryRecordEh(DeltaList[i]).MergeChanges;
  FreeDeletedRecords;
  DeltaList.Clear;
end;

procedure TRecordsListEh.CleanupChangedRecs;
begin
  FreeDeletedRecords;
  DeltaList.Pack;
end;

procedure TRecordsListEh.FreeDeletedRecords;
var
  i: Integer;
  Rec: TObject;
begin
  for i := 0 to FDeletedList.Count-1 do
  begin
    Rec := FDeletedList[i];
    FDeletedList[i] := nil;
    Rec.Free;
//    TMemoryRecordEh(FDeletedList[i]).Free;
  end;
  FDeletedList.Clear;
end;

function TRecordsListEh.FetchRecord(Rec: TMemoryRecordEh): Integer;
var
  OldCachedUpdates: Boolean;
begin
  OldCachedUpdates := FCachedUpdates;
  FCachedUpdates := False;
  try
    Result := AddInsertRecord(Rec, -1, True, True);
  finally
    FCachedUpdates := OldCachedUpdates;
  end;
end;

procedure TRecordsListEh.ApplyUpdateFor(Rec: TMemoryRecordEh;
  UpdateStatus: TUpdateStatus);
var
  ShadowTable: TMemTableDataShadowEh;
  ShadowRec: TMemoryRecordEh;
  i: Integer;
begin
  ShadowTable := TMemTableDataShadowEh.Create(MemTableData);
  ShadowTable.RecordsList.CachedUpdates := True;
  case UpdateStatus of
    usInserted:
      begin
        ShadowRec := ShadowTable.RecordsList.NewRecord;
        for i := 0 to ShadowTable.DataStruct.Count-1 do
          ShadowRec.Value[i, dvvValueEh] := Rec.Value[i, dvvValueEh];
        { TODO : Get next auto increment value }
        ShadowRec.Post;
//        ShadowTable.RecordsList.FetchRecord(ShadowRec);
        ApplyUpdates(ShadowTable);
        for i := 0 to ShadowTable.DataStruct.Count-1 do
          Rec.Value[i, dvvValueEh] := ShadowRec.Value[i, dvvValueEh];
      end;
    usModified:
      begin
        ShadowRec := ShadowTable.RecordsList.NewRecord;
        for i := 0 to ShadowTable.DataStruct.Count-1 do
          ShadowRec.Value[i, dvvValueEh] := Rec.Value[i, dvvOldestValue];
        ShadowTable.RecordsList.FetchRecord(ShadowRec);
        ShadowRec.Edit;
        for i := 0 to ShadowTable.DataStruct.Count-1 do
          ShadowRec.Value[i, dvvValueEh] := Rec.Value[i, dvvValueEh];
        ShadowRec.Post;
        ApplyUpdates(ShadowTable);
        for i := 0 to ShadowTable.DataStruct.Count-1 do
          Rec.Value[i, dvvValueEh] := ShadowRec.Value[i, dvvValueEh];
      end;
    usDeleted:
      begin
        ShadowRec := ShadowTable.RecordsList.NewRecord;
        for i := 0 to ShadowTable.DataStruct.Count-1 do
          ShadowRec.Value[i, dvvValueEh] := Rec.Value[i, dvvOldestValue];
        ShadowTable.RecordsList.FetchRecord(ShadowRec);
        ShadowTable.RecordsList.DeleteRecord(0);
        ApplyUpdates(ShadowTable);
      end;
  end;
  ShadowTable.Free;
end;

procedure TRecordsListEh.ApplyUpdates(AMemTableData: TMemTableDataEh);
begin
  FMemTableData.ApplyUpdates(AMemTableData);
end;

procedure TRecordsListEh.ReIndexRecs(FromIndex, ToIndex: Integer);
var
  i: Integer;
begin
  if FromIndex < 0 then FromIndex := 0;
  if (ToIndex < 0) or (ToIndex >= Count) then ToIndex := Count-1;
  for i := FromIndex to ToIndex do
    TMemoryRecordEh(FRecList[i]).FIndex := i;
end;

procedure TRecordsListEh.RecordMoved(Item: TMemoryRecordEh; OldIndex,
  NewIndex: Integer);
begin
  Indexes.RecordMoved(Item, OldIndex, NewIndex);
  FMemTableData.RecordMoved(Item, OldIndex, NewIndex);
end;

procedure TRecordsListEh.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

procedure TRecordsListEh.EndUpdate;
begin
  if FUpdateCount > 0 then
  begin
    Dec(FUpdateCount);
    if FUpdateCount = 0 then
      Notify(nil, -1, rlnListChangedEh);
  end;
end;

procedure TRecordsListEh.CheckForDestroyRecord(Rec: TMemoryRecordEh);
begin
  if FDeletedList.IndexOf(Rec) >= 0 then
    raise Exception.Create('Can not delete Record if it present in DeletedList.');
  if FDeltaList.IndexOf(Rec) >= 0 then
    raise Exception.Create('Can not delete Record if it present in CachedUpdate pending list.');
  if FRecList.IndexOf(Rec) >= 0 then
    raise Exception.Create('Can not delete Record if it present in active list.');
end;

{ TMTAggregatesEh }

constructor TMTAggregatesEh.Create(Owner: TPersistent);
begin
  inherited Create(TMTAggregateEh);
  FOwner := Owner;
end;

function TMTAggregatesEh.Add: TMTAggregateEh;
begin
  Result := TMTAggregateEh.Create(Self, DataSet);
end;

procedure TMTAggregatesEh.Clear;
begin
  inherited Clear;
end;

function TMTAggregatesEh.GetItem(Index: Integer): TMTAggregateEh;
begin
  Result := TMTAggregateEh(inherited GetItem(Index));
end;

function TMTAggregatesEh.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

procedure TMTAggregatesEh.SetItem(Index: Integer; Value: TMTAggregateEh);
begin
  inherited SetItem(Index, Value);
end;

procedure TMTAggregatesEh.SetActive(const Value: Boolean);
begin
  if FActive <> Value then
  begin
    FActive := Value;
    Reset;
  end;
end;

procedure TMTAggregatesEh.Recalc;
var
  I: Integer;
begin
  for I := 0 to Count-1 do
    if
{$IFDEF CIL}
  { TODO : IsCursorOpen? }
{$ELSE}
      TDataSetCrack(DataSet).IsCursorOpen and
{$ENDIF}
      not (csLoading in DataSet.ComponentState) and (UpdateCount = 0)
    then
      Items[I].Recalc
    else
      Items[I].FValue := Null;
end;

function TMTAggregatesEh.DataSet: TDataSet;
begin
  Result := TRecordsViewEh(GetOwner).FDataSet;
end;

procedure TMTAggregatesEh.Reset;
{$IFDEF FPC}
begin
end;
{$ELSE}
var
  I: Integer;
  Aggr: TMTAggregateEh;
  Field: TAggregateField;
begin
  BeginUpdate;
  try
    Clear;
    for I := 0 to DataSet.AggFields.Count-1 do
    begin
      Field := DataSet.AggFields[I] as TAggregateField;
      Aggr := Add;
      Aggr.Assign(Field);
      Aggr.Reset;
{$IFDEF CIL}
      Field.Handle := Aggr;
{$ELSE}
      Field.Handle := Pointer(Aggr);
{$ENDIF}
      Field.ResultType := Aggr.DataType;
    end;
  finally
    EndUpdate;
  end;
  Recalc;
end;
{$ENDIF}

{ TMTAggregateEh }

constructor TMTAggregateEh.Create(Aggregates: TMTAggregatesEh; ADataSet: TDataSet);
begin
  FDataSet := ADataSet;
  inherited Create(Aggregates);
  FValue := Null;
  FInUse := False;
  FAggrExpr := TDataSetExprParserEh.Create(FDataSet, dsptAggregateEh);
end;

destructor TMTAggregateEh.Destroy;
{$IFDEF FPC}
begin
  inherited Destroy;
end;
{$ELSE}
var
  I: Integer;
begin
  if Assigned(FDataSet) and Assigned(FDataSet.AggFields) then
    for I := 0 to FDataSet.AggFields.Count - 1 do
      if TAggregateField(FDataSet.AggFields[I]).Handle = Self then
        TAggregateField(FDataSet.AggFields[I]).Handle := nil;
  FreeAndNil(FAggrExpr);
  inherited Destroy;
end;
{$ENDIF}

procedure TMTAggregateEh.Assign(Source: TPersistent);
begin
  if Source is TMTAggregateEh then
  begin
    Active := TMTAggregateEh(Source).Active;
    Expression := TMTAggregateEh(Source).Expression;
  end
  {$IFDEF FPC}
  {$ELSE}
  else if Source is TAggregateField then
  begin
    Active := TAggregateField(Source).Active;
    Expression := TAggregateField(Source).Expression;
  end
  {$ENDIF}
  else
    inherited Assign(Source);
end;

function TMTAggregateEh.GetDisplayName: string;
begin
  Result := Expression;
  if Result = '' then
    Result := inherited GetDisplayName;
end;

procedure TMTAggregateEh.SetActive(Value: Boolean);
begin
  if Value <> FActive then
  begin
    FActive := Value;
    if (FDataSet <> nil) and (Aggregates.UpdateCount = 0) then
    try
      Recalc;
//      FDataSet.ResetAgg(Self);
    except
      FActive := False;
      raise;
    end;
  end;
end;

procedure TMTAggregateEh.SetExpression(const Text: string);
begin
{  if ( FDataSet <> nil ) and (FExpression <> Text ) and Active
    and not (csLoading in FDataSet.ComponentState)
  then
    DatabaseError(SAggActive, FDataSet);}
  if Text <> FExpression then
  begin
    FExpression := Text;
    Reset;
    if Aggregates.UpdateCount = 0 then
      Recalc;
  end;
end;

function TMTAggregateEh.Value: Variant;
begin
  Result := FValue;
end;

procedure TMTAggregateEh.Recalc;
begin
  if FInUse
  { TODO : For Sergo }
    then FValue := FAggrExpr.CalcAggregateValue(TRecordsViewEh(Aggregates.GetOwner))
//    then FValue := CalcAggregateValue(Self, DataSet, TRecordsViewEh(Aggregates.GetOwner))
    else FValue := Null;
end;

function TMTAggregateEh.Aggregates: TMTAggregatesEh;
begin
  Result := TMTAggregatesEh(Collection);
end;

procedure TMTAggregateEh.Reset;
begin
  FInUse := False;
  if (FDataSet <> nil)
{$IFDEF CIL}
  { TODO : IsCursorOpen? }
{$ELSE}
  and TDataSetCrack(FDataSet).IsCursorOpen
{$ENDIF}
    and Active and (Expression <> '') and Aggregates.Active then
  begin
    FAggrExpr.ParseExpression(Expression);
    FDataType := ftFloat;  { TODO : Check real datatype of expression }
    FInUse := True;
  end else
    FValue := Null;
end;

{ TRecordsViewEh }

constructor TRecordsViewEh.Create(ADataSet: TDataSet);
begin
  inherited Create(nil);
  FDataSet := ADataSet;

//  FRLNotificator := TRecordsListNotificatorEh.Create(nil);
//  FRLNotificator.RecordsList := FMemTableData.RecordsList;
//  FRLNotificator.MemTableData := FMemTableData;
//  FRLNotificator.OnDataEvent := RLDataEvent;
  FMemoryViewList := TObjectList.Create(False);
  FAggregates := TMTAggregatesEh.Create(Self);
  FCachedUpdates := True;
  FMemoryTreeList := TMemoryTreeListEh.Create(Self);
  FOrderByList := TRecordsViewOrderByList.Create(Self);
  FStatusFilter := [usUnmodified, usModified, usInserted];
  FNotificators := TObjectList.Create(False);
end;

destructor TRecordsViewEh.Destroy;
begin
  MemTableData := nil;
  ClearMemoryViewList;
  FreeAndNil(FMemoryViewList);
  while FNotificators.Count > 0 do
    TRecordsListNotificatorEh(FNotificators[0]).DataObject := nil;
  FreeAndNil(FNotificators);

//  FRLNotificator.RecordsList := nil;
//  FRLNotificator.MemTableData := nil;
//  FMemTableData.Free;
//  FRecordsList.Free;
//  FRLNotificator.Free;
  FreeAndNil(FAggregates);
  FreeAndNil(FMemoryTreeList);
  FreeAndNil(FOrderByList);
  inherited Destroy;
end;

function TRecordsViewEh.FilterRecord(MemRec: TMemoryRecordEh; Index: Integer; Node: TMemRecViewEh): Boolean;
begin
  if MemRec.UpdateStatus in StatusFilter
    then Result := True
    else Result := False;
  if Result and Assigned(OnFilterRecord) then
    Result := OnFilterRecord(MemRec, Node);
//    Result := FMemTable.IsRecordInFilter(MemRec.Data);
end;

procedure TRecordsViewEh.Notify(MemRec: TMemoryRecordEh;
  Index: Integer; Action: TRecordsListNotification);
var
  i: Integer;
begin
  FCatchChanged := True;
  FAggregates.Recalc;
  if Assigned(OnViewDataEvent) then
    OnViewDataEvent(MemRec, Index, Action);
  for i := 0 to FNotificators.Count-1 do
    TRecordsListNotificatorEh(FNotificators[i]).DataEvent(MemRec, Index, Action);
end;

procedure TRecordsViewEh.NotifyRecordMoved(MemRec: TMemoryRecordEh; OldIndex, NewIndex: Integer);
var
  i: Integer;
begin
  if Assigned(OnViewRecordMovedEvent) then
    OnViewRecordMovedEvent(MemRec, OldIndex, NewIndex);
  for i := 0 to FNotificators.Count-1 do
    TRecordsListNotificatorEh(FNotificators[i]).RecordMoved(MemRec, OldIndex, NewIndex);
end;

function TRecordsViewEh.SearchRec(SortedList: TObjectList; MemRec: TMemoryRecordEh): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to SortedList.Count-1 do
    if TMemRecViewEh(SortedList[i]).Rec = MemRec then
    begin
      Result := i;
      Break;
    end;
end;

function TRecordsViewEh.SearchNewPos(SortedList: TObjectList;
  MemRec: TMemoryRecordEh; OldIndex: Integer): Integer;
var
  CurIndex, AMin, AMax, CompRes1, CompRes2: Integer;
begin
  if (SortedList.Count = 0) or (CompareRecords(TMemRecViewEh(SortedList[0]).Rec, MemRec)>0) then
  begin
    Result := 0;
    Exit;
  end;
  if (CompareRecords(TMemRecViewEh(SortedList[SortedList.Count-1]).Rec, MemRec)<0) then
  begin
    Result := SortedList.Count;
    Exit;
  end;

// Check the record in same pos
  if (OldIndex >= 0) and (OldIndex <= SortedList.Count) then
  begin
    if OldIndex > 0 then
      CompRes1 := CompareRecords(TMemRecViewEh(SortedList.Items[OldIndex-1]).Rec,
                                      MemRec)
    else
      CompRes1 := 0;

    if OldIndex < SortedList.Count then
      CompRes2 := CompareRecords(TMemRecViewEh(SortedList.Items[OldIndex]).Rec,
                                      MemRec)
    else
      CompRes2 := 0;

    if (CompRes1 <= 0) and (CompRes2 >= 0) then
    begin
      Result := OldIndex;
      Exit;
    end;
  end;

  AMin := 0; AMax := SortedList.Count - 1;
  CurIndex := (AMax - AMin) div 2;
  Result := CurIndex;

  while True do
  begin
    if CompareRecords(TMemRecViewEh(SortedList.Items[CurIndex]).Rec, MemRec) > 0 then
    begin
      AMax := CurIndex;
      CurIndex := (AMax + AMin) div 2;
    end
    else
      if CompareRecords(TMemRecViewEh(SortedList.Items[CurIndex]).Rec, MemRec) < 0 then
      begin
        AMin := CurIndex;
        CurIndex := (AMax + AMin) div 2;
      end
      else
      begin
        Result := CurIndex;
        Exit;
        { TODO -oKostik : check for eq records }
      end;
    if Result = CurIndex then
    begin
      Inc(Result);
      Exit;
    end;
    Result := CurIndex;
  end;

end;

function TRecordsViewEh.CompareRecords(Rec1, Rec2: TMemoryRecordEh): Integer;
begin
  if SortOrder = ''
    then Result := Rec1.Index - Rec2.Index
    else Result := OncompareRecords(Rec1, Rec2, FOrderByList);
end;

procedure TRecordsViewEh.DataEvent(MemRec: TMemoryRecordEh;
  Index: Integer; Action: TRecordsListNotification);
var
  OldIndex:Integer;
  NewIndex: Integer;
  i: Integer;
  Node, Parent: TMemRecViewEh;
  List: TObjectList;
  RecView: TMemRecViewEh;
//  RecordInFilter: Boolean;

  procedure AddToFilterList(RecView: TMemRecViewEh);
  begin
    if NewIndex >= FMemoryViewList.Count
      then AddRecInMemoryViewList(MemRec, FMemoryViewList.Count, RecView)
      else AddRecInMemoryViewList(MemRec, NewIndex, RecView);

{    if NewIndex >= FMemoryViewList.Count
      then FFilteredRecsList.Add(MemRec)
      else FFilteredRecsList.Insert(NewIndex, MemRec);}

//    Notify(MemRec, NewIndex, rlnRecAddedEh);
  end;

begin
  inherited DataEvent(MemRec, Index, Action);

  if FDisableFilterCount > 0 then
    Exit;

  case Action of
    rlnRecAddedEh:
      begin
        if FilterRecord(MemRec, Index, nil) then
        begin
          NewIndex := SearchNewPos(FMemoryViewList, MemRec, -1);
          AddToFilterList(nil);
          Notify(MemRec, NewIndex, rlnRecAddedEh);
        end;
      end;

    rlnRecChangedEh, rlnRecMarkedForDelEh:
      begin
        OldIndex := SearchRec(FMemoryViewList, MemRec);

        if OldIndex >= 0 then  //Was in visible buffer
        begin
          RecView := RemoveRecInMemoryViewList(OldIndex);
//          FFilteredRecsList.Delete(OldIndex);
//          Notify(MemRec, OldIndex, rlnRecDeletedEh);
        end else
          RecView := nil;

        NewIndex := SearchNewPos(FMemoryViewList, MemRec, OldIndex);

        if FilterRecord(MemRec, Index, nil) then
          AddToFilterList(RecView)
        else
        begin
          NewIndex := -1;
          if RecView <> nil then
            FreeAndNil(RecView);
        end;

        if (OldIndex >= 0) and (NewIndex >= 0) then
        begin
          if (NewIndex <> OldIndex) then
            NotifyRecordMoved(MemRec, OldIndex, NewIndex);
          Notify(MemRec, NewIndex, Action);
        end else if (OldIndex < 0) and (NewIndex >= 0) then
          Notify(MemRec, NewIndex, rlnRecAddedEh)
        else if (OldIndex >= 0) and (NewIndex < 0) then
          Notify(MemRec, OldIndex, rlnRecDeletedEh);
      end;

    rlnRecDeletedEh:
      begin
        OldIndex := SearchRec(FMemoryViewList, MemRec);
        if OldIndex >= 0 then //Was in visible buffer
        begin
          DelRecInMemoryViewList(OldIndex);
//          FFilteredRecsList.Delete(OldIndex);
          Notify(MemRec, OldIndex, Action);
        end;
      end;

    rlnListChangedEh:
      begin
        if ViewAsTreeList then
          FMemoryTreeList.Clear;
        RefreshFilteredRecsList;
        //Notify(MemRec, Index, rlnListChangedEh);
      end;

  end;

  if ViewAsTreeList then
  begin
    case Action of
      rlnRecAddingEh:
        if MemoryTreeList.CheckReferenceLoop(MemRec, Unassigned) then
          raise Exception.Create('Reference-loop found');
      rlnRecAddedEh:
        begin
          Node := MemoryTreeList.AddChildAtKey(TreeViewKeyFieldName, TreeViewKeyFieldName,
            TreeViewRefParentFieldName, MemRec);
          MemoryTreeList.UpdateNodeState(Node, True);
        end;
      rlnRecChangingEh://, rlnRecMarkedForDelEh:
        if MemoryTreeList.CheckReferenceLoop(MemRec, Unassigned) then
          raise Exception.Create('Reference-loop found');
      rlnRecChangedEh://, rlnRecMarkedForDelEh:
        begin
          Node := MemoryTreeList.GetNode(nil, MemRec);
          MemoryTreeList.UpdateParent(Node, TreeViewKeyFieldName,
            TreeViewRefParentFieldName, MemRec, True);
          MemoryTreeList.UpdateNodeState(Node, True);
        end;
      rlnRecDeletedEh, rlnRecMarkedForDelEh:
        begin
          Node := MemoryTreeList.GetNode(nil, MemRec);
          if Node = nil then Exit;
          List := TObjectList.Create(False);
          try
            MemoryTreeList.GetRecordsList(List, Node, True);
            Parent := Node.NodeParent;
            MemoryTreeList.DeleteNode(Node, True);
            for i := 0 to List.Count-1 do
              MemoryTreeList.AddChildAtKey(TreeViewKeyFieldName, TreeViewKeyFieldName,
                TreeViewRefParentFieldName, TMemoryRecordEh(List[i]));
            MemoryTreeList.UpdateNodeState(Parent, True);
          finally
            List.Free;
          end;
        end;
      rlnListChangedEh:
        RebuildMemoryTreeList;
    end;
    if MemoryTreeList.VisibleItemsObsolete = True then
      Notify(nil, -1, rlnListChangedEh);
  end;
  if Action in [rlnRecAddedEh, rlnRecChangedEh, rlnRecDeletedEh, rlnListChangedEh,
     rlnRecMarkedForDelEh]
  then
    Aggregates.Recalc;
end;

procedure TRecordsViewEh.StructChanged(AMemTableData: TMemTableDataEh);
begin
  inherited StructChanged(AMemTableData);
  UpdateFields;
end;

procedure TRecordsViewEh.RefreshFilteredRecsList;
var
  i: Integer;
  RList: TObjectList;
begin
  ClearMemoryViewList;
//  FFilteredRecsList.Clear;
  RList := nil;
  if (MemTableData <> nil) and not ViewAsTreeList then
  begin
    if Assigned(OnGetPrefilteredList) then
      RList := OnGetPrefilteredList();
    if not Assigned(RList) then
      RList := MemTableData.RecordsList.FRecList;
    for i := 0 to RList.Count-1 do
      if FilterRecord(TMemoryRecordEh(RList[i]), i, nil) then
        AddRecInMemoryViewList(TMemoryRecordEh(RList[i]), FMemoryViewList.Count, nil)
//        FFilteredRecsList.Add(TMemoryRecordEh(RList[i]));
  end;
  MemoryTreeList.UpdateNodesState(nil);
  if not MemoryTreeList.FilterNodeIfParentVisible then
    MemoryTreeList.SetChieldVisibleForVisibleParents(nil);
  if FSortOrder <> '' then
    Resort
  else
    Notify(nil, -1, rlnListChangedEh);
end;

{function TRecordsViewEh.FetchRecord(Rec: TMemoryRecordEh): Boolean;
begin
  LockCachedUpdates;
  try
    FCatchChanged := False;
    AddRecord(Rec);
    Result := FCatchChanged;
  finally
    UnlockCachedUpdates;
  end;
end;}

procedure TRecordsViewEh.QuickSort(L, R: Integer; Compare: TCompareRecords; ParamSort: TObject);

var
  I, J: Integer;
  P: TMemoryRecordEh;
begin
  if L >= R then Exit;
  repeat
    I := L;
    J := R;
    P := ViewRecord[(L + R) shr 1];
    repeat
      while Compare(ViewRecord[I], P, ParamSort) < 0 do
        Inc(I);
      while Compare(ViewRecord[J], P, ParamSort) > 0 do
        Dec(J);
      if I <= J then
      begin
        FMemoryViewList.Exchange(I, J);
        Inc(I);
        Dec(J);
      end;
    until I > J;
    if L < J then
      QuickSort(L, J, Compare, ParamSort);
    L := I;
  until I >= R;
end;

procedure TRecordsViewEh.SortData(Compare: TCompareRecords; ParamSort: TObject);
begin
  QuickSort(0, FMemoryViewList.Count-1, Compare, ParamSort);
  Notify(nil, -1, rlnListChangedEh);
end;

procedure TRecordsViewEh.LockCachedUpdates;
begin
  Inc(FCachedUpdatesLockCount);
  MemTableData.RecordsList.CachedUpdates := False;
end;

procedure TRecordsViewEh.UnlockCachedUpdates;
begin
  if FCachedUpdatesLockCount > 0 then
    Dec(FCachedUpdatesLockCount);
  if FCachedUpdatesLockCount = 0 then
  begin
    MemTableData.RecordsList.CachedUpdates := FCachedUpdates;
  end;
end;

function TRecordsViewEh.GetCount: Integer;
begin
  if ViewAsTreeList
    then Result := MemoryTreeList.VisibleExpandedCount
    else Result := FMemoryViewList.Count;
//  Result := FFilteredRecsList.Count;
end;

function TRecordsViewEh.NewRecord: TMemoryRecordEh;
begin
  Result := MemTableData.RecordsList.NewRecord;
end;

function TRecordsViewEh.AddRecord(Rec: TMemoryRecordEh): Integer;
begin
  Result := MemTableData.RecordsList.AddRecord(Rec);
end;

procedure TRecordsViewEh.DeleteRecord(Index: Integer);
begin
  if ViewAsTreeList
    then Index := ViewRecord[Index].Index
    else Index := TMemRecViewEh(FMemoryViewList[Index]).Rec.Index;
  MemTableData.RecordsList.DeleteRecord(Index);
end;

procedure TRecordsViewEh.AddRecInMemoryViewList(Rec: TMemoryRecordEh;
  Index: Integer; RecView: TMemRecViewEh);
begin
  if RecView = nil then
    RecView := TMemRecViewEh.Create;
  RecView.Data := Rec;
  FMemoryViewList.Insert(Index, RecView);
  UpdateLookupBuffer(RecView);
end;

procedure TRecordsViewEh.DelRecInMemoryViewList(Index: Integer);
var
  RecView: TMemRecViewEh;
begin
  RecView := TMemRecViewEh(FMemoryViewList[Index]);
  FMemoryViewList.Delete(Index);
  RecView.Free;
end;

function TRecordsViewEh.RemoveRecInMemoryViewList(Index: Integer): TMemRecViewEh;
begin
  Result := TMemRecViewEh(FMemoryViewList[Index]);
  FMemoryViewList.Delete(Index);
end;

{procedure TRecordsViewEh.UpdateInMemoryViewList(Index: Integer);
var
  RecView: TMemRecViewEh;
begin
  RecView := TMemRecViewEh(FMemoryViewList[Index]);
  UpdateLookupBuffer(RecView);
end;}

procedure TRecordsViewEh.ClearMemoryViewList;
var
  i: Integer;
begin
  for i := 0 to FMemoryViewList.Count-1 do
  begin
    FMemoryViewList[I].Free;
    FMemoryViewList[I] := nil;
  end;
  FMemoryViewList.Clear;
end;

function TRecordsViewEh.GetRec(Index: Integer): TMemoryRecordEh;
begin
  if ViewAsTreeList
    then Result := MemoryTreeList.VisibleExpandedItem[Index].Rec
    else Result := TMemRecViewEh(FMemoryViewList[Index]).Rec;

//  Result := TMemoryRecordEh(TMemRecViewEh(FMemoryViewList[Index]).Data)
end;

function TRecordsViewEh.GetValue(RecNo, ValNo: Integer): Variant;
begin
  Result := MemTableData.RecordsList.Value[
              TMemRecViewEh(FMemoryViewList[RecNo]).Rec.Index,
              ValNo];
end;

procedure TRecordsViewEh.SetValue(RecNo, ValNo: Integer; const Value: Variant);
begin
  MemTableData.RecordsList.Value[GetRec(RecNo).Index, ValNo] := Value;
end;

procedure TRecordsViewEh.InsertRecord(Index: Integer; Rec: TMemoryRecordEh);
begin
  if ViewAsTreeList then
  begin
    if Index > 0
      then MemTableData.RecordsList.InsertRecord(
            MemoryTreeList.VisibleExpandedItem[Index-1].Rec.Index + 1, Rec)
      else MemTableData.RecordsList.InsertRecord(0, Rec)
  end
  else if FMemoryViewList.Count = 0 then
    MemTableData.RecordsList.InsertRecord(0, Rec)
  else
    MemTableData.RecordsList.InsertRecord(GetRec(Index).Index, Rec);
end;

procedure TRecordsViewEh.SetRec(Index: Integer; const Value: TMemoryRecordEh);
begin
  MemTableData.RecordsList.Rec[GetRec(Index).Index] := Value;//  SetRec(Integer(FFilteredRecsList[Index]), Value);
end;

function TRecordsViewEh.GetOldRecVals(Index: Integer): TRecDataValues;
begin
  Result := Rec[Index].OldData;
end;

procedure TRecordsViewEh.MergeChangeLog;
begin
  MemTableData.RecordsList.MergeChangeLog;
end;

{procedure TRecordsViewEh.SetCachedUpdates(const Value: Boolean);
begin
  if FCachedUpdates <> Value then
  begin
    FCachedUpdates := Value;
    MemTableData.RecordsList.CachedUpdates := Value;
  end;
end;
}

{function TRecordsViewEh.FindRecId(RecId: TRecIdEh): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to ViewItemsCount - 1 do
//    if MemTableData.RecordsList[Integer(FFilteredRecsList[I])].ID = RecId then
    if ViewRecord[I].ID = RecId then
    begin
      Result := I;
      Exit;
    end;
end;}

procedure TRecordsViewEh.RevertRecord(Index: Integer);
begin
  MemTableData.RecordsList.RevertRecord(GetRec(Index).Index);
end;

procedure TRecordsViewEh.CancelUpdates;
begin
  MemTableData.RecordsList.CancelUpdates;
end;

procedure TRecordsViewEh.RefreshRecord(Index: Integer; Rec: TMemoryRecordEh);
begin
  MemTableData.RecordsList.RefreshRecord(GetRec(Index).Index, Rec);
end;

function TRecordsViewEh.CalcAggrFieldFunc(FieldName, AggrFuncName: String): Variant;
type
  TAggrFunc = (afSUM, afCOUNT, afMIN, afMAX, afAVG);
var
  FIndex, I: Integer;
  AggrFunc: TAggrFunc;
  CurValue: Variant;
begin
  Result := 0;
  CurValue := Null;
  if (FieldName = '*') and (AggrFuncName = 'COUNT') then
  begin
    Result := Count;
    Exit;
  end;
  FIndex := MemTableData.RecordsList.DataStruct.FieldIndex(FieldName);
  if FIndex = -1 then
    raise Exception.Create('Invalid field name: ' + FieldName);

  if AggrFuncName = 'SUM' then AggrFunc := afSUM
  else if AggrFuncName = 'COUNT' then AggrFunc := afCOUNT
  else if AggrFuncName = 'MIN' then AggrFunc := afMIN
  else if AggrFuncName = 'MAX' then AggrFunc := afMAX
  else if AggrFuncName = 'AVG' then AggrFunc := afAVG
  else raise Exception.Create('Unsupported aggrigate function: ' + AggrFuncName);

  for I := 0 to Count-1 do
  begin
    if not VarIsNull(Value[I,FIndex]) then
      case AggrFunc of
        afSUM, afAVG:
          Result := Result + Value[I,FIndex];
        afCOUNT:
          Result := Result + 1;
        afMIN:
          if VarIsNull(CurValue) then
            CurValue := Value[I,FIndex]
          else if Value[I,FIndex] < CurValue then
            CurValue := Value[I,FIndex];
        afMAX:
          if Value[I,FIndex] > CurValue then
            CurValue := Value[I,FIndex];
      end;
  end;

  case AggrFunc of
    afAvg:
      Result := Result / Count;
    afMin, afMax:
      Result := CurValue;
  end;

end;

{$IFDEF FPC}
{$ELSE}
const
{ Field Types (Logical) - Originally from BDE.PAS }
  fldUNKNOWN         = 0;
  fldZSTRING         = 1;               { Null terminated string }
  fldDATE            = 2;               { Date     (32 bit) }
  fldBLOB            = 3;               { Blob }
  fldBOOL            = 4;               { Boolean  (16 bit) }
  fldINT16           = 5;               { 16 bit signed number }
  fldINT32           = 6;               { 32 bit signed number }
  fldFLOAT           = 7;               { 64 bit floating point }
  fldBCD             = 8;               { BCD }
  fldBYTES           = 9;               { Fixed number of bytes }
  fldTIME            = 10;              { Time        (32 bit) }
  fldTIMESTAMP       = 11;              { Time-stamp  (64 bit) }
  fldUINT16          = 12;              { Unsigned 16 bit integer }
  fldUINT32          = 13;              { Unsigned 32 bit integer }
  fldFLOATIEEE       = 14;              { 80-bit IEEE float }
  fldVARBYTES        = 15;              { Length prefixed var bytes }
  fldLOCKINFO        = 16;              { Look for LOCKINFO typedef }
  fldCURSOR          = 17;              { For Oracle Cursor type }
  fldINT64           = 18;              { 64 bit signed number }
  fldUINT64          = 19;              { Unsigned 64 bit integer }
  fldADT             = 20;              { Abstract datatype (structure) }
  fldARRAY           = 21;              { Array field type }
  fldREF             = 22;              { Reference to ADT }
  fldTABLE           = 23;              { Nested table (reference) }
  fldDATETIME        = 24;              { Datetime structure for DBExpress }
  fldFMTBCD          = 25;              { BCD Variant type: required by Midas, same as BCD for DBExpress}
  fldWIDESTRING      = 26;              { UCS2 null terminated string }

{$IFDEF EH_LIB_10}
  MAXLOGFLDTYPES     = 27;              { Number of logical fieldtypes }
{$ELSE}

{$IFDEF EH_LIB_6}
  MAXLOGFLDTYPES     = 26;              { Number of logical fieldtypes }
{$ELSE}
  MAXLOGFLDTYPES     = 24;              { Number of logical fieldtypes }
{$ENDIF}

{$ENDIF}

{ FieldType Mappings }
  FieldTypeMap: TFieldMap = (
    fldUNKNOWN, fldZSTRING, fldINT16, fldINT32, fldUINT16, fldBOOL,
    fldFLOAT, fldFLOAT, fldBCD, fldDATE, fldTIME, fldTIMESTAMP, fldBYTES,
    fldVARBYTES, fldINT32, fldBLOB, fldBLOB, fldBLOB, fldBLOB, fldBLOB,
    fldBLOB, fldBLOB, fldCURSOR, fldZSTRING, fldZSTRING, fldINT64, fldADT,
    fldArray, fldREF, fldTABLE, fldBLOB, fldBLOB, fldUNKNOWN, fldUNKNOWN,
    fldUNKNOWN, fldZSTRING
{$IFDEF EH_LIB_6}
    , fldDATETIME, fldFMTBCD
{$ENDIF}
{$IFDEF FPC}
    , fldUNKNOWN, fldUNKNOWN
{$ELSE}
{$ENDIF}
{$IFDEF EH_LIB_10}
    , fldWIDESTRING, fldBLOB, fldDATETIME, fldZSTRING // 38..41
{$ENDIF}
{$IFDEF EH_LIB_12}
    , fldINT32, fldUNKNOWN, fldUNKNOWN, fldFLOAT,
      fldUnknown, fldUnknown, fldUnknown //42..48
    {$ENDIF}
{$IFDEF EH_LIB_13}
    , fldUnknown, fldUnknown, fldUnknown //49..51
{$ENDIF}
    );

  DataTypeMap: array[0..MAXLOGFLDTYPES - 1] of TFieldType = (
    ftUnknown, ftString, ftDate, ftBlob, ftBoolean, ftSmallint,
    ftInteger, ftFloat, ftBCD, ftBytes, ftTime, ftDateTime,
    ftWord, ftInteger, ftUnknown, ftVarBytes, ftUnknown, ftUnknown,
    ftLargeInt, ftLargeInt, ftADT, ftArray, ftReference, ftDataSet
  {$IFDEF EH_LIB_6}
    , ftTimeStamp, ftFMTBcd
  {$ENDIF}
  {$IFDEF EH_LIB_10}
    , ftWideString
  {$ENDIF}
    );
{$ENDIF}

{$IFDEF FPC}
{$ELSE}
var
  ListBuffer: array of Variant; { container for some function's agruments values }
  ListBufferLength: Integer;
  CurCalcRec: Integer; { Need for store current viewed record number.
                         It's used with agregate functions.}

const
  ErrOpStr: String = 'Operator <%d:%d> not supported.';
  ErrFuncStr: String = 'Function <%s> not supported.';

procedure SetListBufferLength(NewLength: Integer);
begin
  if NewLength > Length(ListBuffer) then
    SetLength(ListBuffer, NewLength);
  ListBufferLength := NewLength;
end;
{$ENDIF}

{$IFNDEF EH_LIB_6}

function DateOf(const AValue: TDateTime): TDateTime;
begin
  Result := Trunc(AValue);
end;

function TimeOf(const AValue: TDateTime): TDateTime;
begin
  Result := Frac(AValue);
end;

function VarToWideStr(const V: Variant): WideString;
begin
  if not VarIsNull(V) then
    Result := V
  else
    Result := '';
end;

{$ENDIF}

function VarCompareStr(vs1, vs2: Variant; CharCount: Integer = 0; CaseInsensitive: Boolean = False): Integer;
begin
{$IFDEF CIL}
   //////////////
{$ELSE}
  if (VarType(vs1) = varOleStr) or (VarType(vs2) = varOleStr){$IFDEF EH_LIB_12}or
    (VarType(vs1) = varUString) or (VarType(vs2) = varUString){$ENDIF} then
    Result := WideStringCompare(VarToWideStr(vs1), VarToWideStr(vs2), CharCount, CaseInsensitive)
  else
    Result := AnsiStringCompare(VarToStr(vs1), VarToStr(vs2), CharCount, CaseInsensitive);
{$ENDIF}
end;

function IsLike(SourceStr: string; LikeExpr: string; IgnoreCase: Boolean): Boolean;

 function InStr(const SourceStr: string; const LikeExpr: string): Integer;
 var
   i, j: Integer;
   Diff: Integer;
 begin
   if not UnuseOneCharLikeWildcardEh then
    begin
       i := Pos('_', LikeExpr);
       if i = 0 then
       begin
         Result := Pos(LikeExpr, SourceStr);
         Exit;
       end;
    end;

   Diff := Length(SourceStr) - Length(LikeExpr);
   if Diff < 0 then
   begin
     Result := 0;
     Exit;
   end;

   for i := 0 to Diff do
   begin
     for j := 1 to Length(LikeExpr) do
     begin
       if (SourceStr[i + j] = LikeExpr[j]) or ((not UnuseOneCharLikeWildcardEh) and (LikeExpr[j] = '_')) then
       begin
         if j = Length(LikeExpr) then
         begin
           Result := i + 1;
           Exit;
         end;
       end
       else Break;
     end;
   end;

   Result := 0;
 end;

var
  LikeCurPos, SourceCurPos, SourceLen, LikeLen: Integer;
  i, iTemp: Integer;
  sTemp: string;
  OneCharWildcard: Boolean;
begin
  if SourceStr = LikeExpr then
  begin
    Result := True;
    Exit;
  end;

  repeat
    i := Pos('%%', LikeExpr);
    if i > 0 then
      LikeExpr := Copy(LikeExpr, 1, i - 1) + '%' + Copy(LikeExpr, i + 2, MaxInt);
  until i = 0;

  if not UnuseOneCharLikeWildcardEh then
    begin
      repeat
        i := Pos('_%', LikeExpr);
        if i > 0 then
          LikeExpr := Copy(LikeExpr, 1, i - 1) + '%' + Copy(LikeExpr, i + 2, MaxInt);
      until i = 0;
      repeat
        i := Pos('%_', LikeExpr);
        if i > 0 then
          LikeExpr := Copy(LikeExpr, 1, i - 1) + '%' + Copy(LikeExpr, i + 2, MaxInt);
      until i = 0;
    end;

  if LikeExpr = '%' then
  begin
    Result := True;
    Exit;
  end;

  SourceLen := Length(SourceStr);
  LikeLen   := Length(LikeExpr);

  if (LikeLen = 0) or (SourceLen = 0) then
  begin
    Result := False;
    Exit;
  end;

  if IgnoreCase then
  begin
    SourceStr := AnsiUpperCase(SourceStr);
    LikeExpr  := AnsiUpperCase(LikeExpr);
  end;

  SourceCurPos := 1;
  LikeCurPos   := 1;
  Result := True;

  repeat
    if SourceStr[SourceCurPos] = LikeExpr[LikeCurPos] then
    begin
      Inc(LikeCurPos);
      Inc(SourceCurPos);
      Continue;
    end;

    if (not UnuseOneCharLikeWildcardEh) and (LikeExpr[LikeCurPos] = '_') then
    begin
      Inc(LikeCurPos);
      Inc(SourceCurPos);
      Continue;
    end;

    if LikeExpr[LikeCurPos] = '%' then
    begin
      sTemp := Copy(LikeExpr, LikeCurPos + 1, LikeLen);
      i := Pos('%', sTemp);
      if i > 0 then sTemp := Copy(sTemp, 1, i - 1);
      iTemp := Length(sTemp);

      if i = 0 then
      begin
        if iTemp = 0 then Exit;

        for i := 0 to iTemp - 1 do
        begin
          OneCharWildcard := not UnuseOneCharLikeWildcardEh and (sTemp[iTemp - i] = '_');
          if (sTemp[iTemp - i] <> SourceStr[SourceLen - i]) and
             not OneCharWildcard then
          begin
            Result := False;
            Exit;
          end;
        end;
        Exit;
      end;
      Inc(LikeCurPos, 1 + iTemp);

      i := InStr(Copy(SourceStr, SourceCurPos, MaxInt), sTemp);
      if i = 0 then
      begin
        Result := False;
        Exit;
      end;
      SourceCurPos := i + iTemp;
      Continue;
    end;

    Result := False;
    Exit;
  until (SourceCurPos > SourceLen) or (LikeCurPos > LikeLen);

  if SourceCurPos <= SourceLen then Result := False;
  if (LikeCurPos <= LikeLen) and (LikeExpr[LikeCurPos] <> '%') then Result := False;
end;

{$IFDEF FPC}
{$ELSE}
function GetNodeResult(DataSet: TDataSet;
                       RecordsView: TRecordsViewEh;
                       Rec: TMemoryRecordEh;
                       FilterData: TExprData;
                       StartPos: Integer): Variant;
{$IFDEF CIL}
begin
  { TODO : Realize GetNodeResult }
  Result := Null;
end;
{$ELSE}
type
  TExprFuncType = (eftSubString, eftUpper, eftLower, eftTrim, eftTrimLeft, eftTrimRight,
                   eftYear, eftMonth, eftDay, eftHour, eftMinute, eftSecond, eftGetDate,
                   eftDate, eftTime, eftSum, eftMin, eftMax, eftAvg, eftCount, eftCountAll);

 function GetLiteralValue(var Dest: TExprData;
                          const Source: TExprData;
                          const StartPos: Integer;
                          const Count: Integer): Integer;
 var
   iCount, iLiteralStart: Integer;
 begin
   iLiteralStart := PWordArray(PByte(Source))^[4];

   if Count = -1 then
   begin
     iCount := 0;
     while Source[iLiteralStart + StartPos + iCount] <> 0 do Inc(iCount);
     Inc(iCount);
   end
   else
     iCount := Count;
   SetLength(Dest, iCount);
   Move(Source[iLiteralStart + StartPos], Dest[0], iCount);

   Result := iCount;
 end;

 function GetValueByType(var Source: TExprData;
                         const DataSize: Integer;
                         const ValueType: TFieldType;
                         const NoteOp: Integer): Variant;
 var
   i, Len: Integer;
   sValue: AnsiString;
   TimeStamp: TTimeStamp;
   curTemp: Currency;
   swValue: WideString;
 begin
   Result := Null;
   try
     case ValueType of
       ftUnknown:
         if NoteOp = $1007 then
         begin
           Len := Word(Pointer(Source)^);
           SetLength(swValue, (Len div 2));
           Move((PWideChar(Source) + 1)^, PWideChar(swValue)^, Len);
           if Len > 0 then
             (PWideChar(swValue) + (Len div 2))^ := #$00;
           Result := swValue;
         end;
       ftSmallInt:
         Result := SmallInt(PInteger(@Source[0])^);
       ftWord:
         Result := Word(PInteger(@Source[0])^);
       ftInteger, ftAutoInc:
         Result := Integer(PInteger(@Source[0])^);
{$IFDEF EH_LIB_6}
       ftLargeInt:
{$IFDEF EH_LIB_7}
         Result := Int64(PInt64(@Source[0])^);
{$ELSE}
         Result := LargeInt(PInteger(@Source[0])^);
{$ENDIF}
{$ENDIF}
       ftFloat, ftCurrency:
         Result := Double(PDouble(@Source[0])^);
       ftString, ftWideString, ftFixedChar, ftGuid:
       begin
         for i := 0 to DataSize - 2 do
//           sValue := sValue + String(AnsiChar(Source[i]));
           sValue := sValue + AnsiChar(Source[i]);
         Result := sValue;
       end;

       ftDate:
       begin
         TimeStamp.Time := 0;
         TimeStamp.Date := Integer(PInteger(@Source[0])^);
         Result := TimeStampToDateTime(TimeStamp);
       end;

       ftTime:
       begin
         TimeStamp.Date := DateDelta;
         TimeStamp.Time := Integer(PInteger(@Source[0])^);
         Result := TimeStampToDateTime(TimeStamp);
       end;

       ftDateTime:
       begin
         TimeStamp := MSecsToTimeStamp(Double(PDouble(@Source[0])^));
         Result := TimeStampToDateTime(TimeStamp);
       end;

{$IFDEF EH_LIB_6}
       ftTimeStamp:
         VarSQLTimeStampCreate(Result, TSQLTimeStamp(PSQLTimeStamp(@Source[0])^));
//         Result := Variant(TSQLTimeStamp(PSQLTimeStamp(@Source[0])^));
{$ENDIF}

       ftBoolean:
         Result := Boolean(PWordBool(@Source[0])^);

       ftBCD {$IFDEF EH_LIB_6}, ftFMTBcd {$ENDIF}:
       begin
         if BCDToCurr(TBcd(PBcd(@Source[0])^), curTemp) = True then
           Result := curTemp
         else
           // I don't know there is right or not
           Result := Null;
       end;

     else
       raise Exception.CreateFmt('Unsupported data type: [%d].', [Integer(ValueType)]);
     end;
   finally
     SetLength(Source, 0);
   end;
 end;

 function TrimChars(const TrimType: TExprFuncType; const S: String; const sCmp: String = ' '): String;
 var
   i: Integer;
 begin
   if TrimType = eftTrim then
     Result := TrimChars(eftTrimRight, TrimChars(eftTrimLeft, S, sCmp), sCmp)
   else
   begin
     i := Length(S);
     if i = 0 then Result := S
     else if TrimType = eftTrimLeft then
     begin
       i := 1;
       while S[i] = sCmp do Inc(i);
       if i = 1 then
         Result := S
       else
         Result := Copy(S, i, MaxInt);
     end else
     begin
       while S[i] = sCmp do Dec(i);
       Result := Copy(S, 1, i);
     end;
   end;
 end;

 function GetParameters(const StartPos: Integer): Integer;
 begin
   if StartPos > 0 then
   begin
     GetNodeResult(DataSet, RecordsView, Rec, FilterData, CANEXPRSIZE + StartPos);
     Result := ListBufferLength;
   end else
     Result := 0;
 end;

var
  Result_Left, Result_Right: Variant;
  i, NodeType, NodeOp, NodeOp1, NodeOp2, NodeOp3, NodeOp4: Integer;
  Year_Hour, Month_Min, Day_Sec, MSec: Word;
  FuncName: String;
  FuncType: TExprFuncType;
  Buffer: TExprData;

begin
  Result := Null;
  NodeType := Integer(PInteger(@FilterData[StartPos + 0])^);
  NodeOp := Integer(PInteger(@FilterData[StartPos + 4])^);

  case NODEClass(NodeType) of
    nodeUNARY:
    begin
      
      NodeOp1 := PWordArray(PAnsiChar(FilterData) + CANHDRSIZE + StartPos)^[0];
//      NodeOp1 := PWordArray(FilterData[CANHDRSIZE + StartPos])^[0];

      Result_Left := GetNodeResult(DataSet, RecordsView, Rec, FilterData, CANEXPRSIZE + NodeOp1);

      case TCANOperator(NodeOp) of
        coISBLANK:
          if VarIsStr(Result_Left) then
            Result := (VarToStr(Result_Left) = '')
          else
            Result := VarIsNull(Result_Left);

        coNOTBLANK:
          if VarIsStr(Result_Left) then
            Result := (VarToStr(Result_Left) <> '')
          else
            Result := not VarIsNull(Result_Left);

        coNOT:
          Result := not Boolean(TVarData(Result_Left).VBoolean);

        {coMINUS: not implemented yet}

        coUPPER:
          if VarIsNull(Result_Left) then
            Result := Null
          else
            Result := AnsiUpperCase(VarToStr(Result_Left));

        coLOWER:
          if VarIsNull(Result_Left) then
            Result := Null
          else
            Result := AnsiLowerCase(VarToStr(Result_Left));
      else
        raise Exception.CreateFmt(ErrOpStr, [NodeType, NodeOp]);
      end;
    end;

    nodeBINARY:
    begin
      
      NodeOp1 := PWordArray(PAnsiChar(FilterData) + StartPos + CANHDRSIZE)^[0];
      
      NodeOp2 := PWordArray(PAnsiChar(FilterData) + StartPos + CANHDRSIZE)^[1];

      Result_Left  := GetNodeResult(DataSet, RecordsView, Rec, FilterData, CANEXPRSIZE + NodeOp1);
      if TCANOperator(NodeOp) <> coIN then
        Result_Right := GetNodeResult(DataSet, RecordsView, Rec, FilterData, CANEXPRSIZE + NodeOp2);

      case TCANOperator(NodeOp) of
        coEQ:
          if VarIsStr(Result_Left) or VarIsStr(Result_Right) then
          begin
            Result := (VarCompareStr(Result_Left,
                                     Result_Right,
                                     0,
                                     foCaseInsensitive in DataSet.FilterOptions) = 0);
          end else
            Result := (Result_Left = Result_Right);

        coNE:
          if VarIsStr(Result_Left) or VarIsStr(Result_Right) then
          begin
            Result := (VarCompareStr(Result_Left,
                                     Result_Right,
                                     0,
                                     foCaseInsensitive in DataSet.FilterOptions) <> 0);
          end else
            Result := (Result_Left <> Result_Right);

        coGT:
          if VarIsStr(Result_Left) or VarIsStr(Result_Right) then
          begin
            Result := (VarCompareStr(Result_Left,
                                     Result_Right,
                                     0,
                                     foCaseInsensitive in DataSet.FilterOptions) > 0);
          end else
            Result := (Result_Left > Result_Right);

        coLT:
          if VarIsStr(Result_Left) or VarIsStr(Result_Right) then
          begin
            Result := (VarCompareStr(Result_Left,
                                     Result_Right,
                                     0,
                                     foCaseInsensitive in DataSet.FilterOptions) < 0);
          end else
            Result := (Result_Left < Result_Right);

        coGE:
          if VarIsStr(Result_Left) or VarIsStr(Result_Right) then
          begin
            Result := (VarCompareStr(Result_Left,
                                     Result_Right,
                                     0,
                                     foCaseInsensitive in DataSet.FilterOptions) >= 0);
          end else
            Result := (Result_Left >= Result_Right);

        coLE:
          if VarIsStr(Result_Left) or VarIsStr(Result_Right) then
          begin
            Result := (VarCompareStr(Result_Left,
                                     Result_Right,
                                     0,
                                     foCaseInsensitive in DataSet.FilterOptions) <= 0);
          end else
            Result := (Result_Left <= Result_Right);

        coAND:
          Result := (Result_Left and Result_Right);

        coOR:
          Result := (Result_Left or Result_Right);

        coADD:
          if VarIsNull(Result_Left) and VarIsNull(Result_Right) then
            Result := Null
          else if VarIsStr(Result_Left) or VarIsStr(Result_Right) then
            Result := VarToStr(Result_Left) + VarToStr(Result_Right)
          else
            Result := (Result_Left + Result_Right);

        coSUB:
          Result := (Result_Left - Result_Right);

        coMUL:
          Result := (Result_Left * Result_Right);

        coDIV:
          Result := (Result_Left / Result_Right);

        {coMOD: not implemented yet}
        {coREM: not implemented yet}

        coLIKE:
          Result := IsLike(VarToStr(Result_Left),
                           VarToStr(Result_Right),
                           (foCaseInsensitive in DataSet.FilterOptions));

        coIN:
          try
            NodeOp3 := GetParameters(NodeOp2);
            Result := False;
            for i := 0 to NodeOp3 - 1 do
            begin
              if Result_Left = ListBuffer[i] then
              begin
                Result := True;
                Exit;
              end;
            end;

          finally
            SetListBufferLength(0);
          end;

      else
        raise Exception.CreateFmt(ErrOpStr, [NodeType, NodeOp]);
      end;
    end;

    nodeCOMPARE:
    begin
      
      NodeOp1 := PWordArray(PAnsiChar(FilterData) + StartPos + CANHDRSIZE)^[0];
      
      NodeOp2 := PWordArray(PAnsiChar(FilterData) + StartPos + CANHDRSIZE)^[1];
      
      NodeOp3 := PWordArray(PAnsiChar(FilterData) + StartPos + CANHDRSIZE)^[2];
      
      NodeOp4 := PWordArray(PAnsiChar(FilterData) + StartPos + CANHDRSIZE)^[3];

      Result_Left  := GetNodeResult(DataSet, RecordsView, Rec, FilterData, CANEXPRSIZE + NodeOp3);
      Result_Right := GetNodeResult(DataSet, RecordsView, Rec, FilterData, CANEXPRSIZE + NodeOp4);

      case TCANOperator(NodeOp) of
        coEQ:
          Result := (VarCompareStr(Result_Left, Result_Right, NodeOp2, (NodeOp1 = 1)) = 0);

        coNE:
          Result := (VarCompareStr(Result_Left, Result_Right, NodeOp2, (NodeOp1 = 1)) <> 0);

        coLIKE:
          Result := IsLike(VarToStr(Result_Left), VarToStr(Result_Right), (NodeOp1 = 1));

      else
        raise Exception.CreateFmt(ErrOpStr, [NodeType, NodeOp]);
      end;
    end;

    nodeFIELD:
      if TCANOperator(NodeOp) = coFIELD2 then
      begin
        // -- Value - Field No
        NodeOp1 := PWordArray(PAnsiChar(FilterData) + CANHDRSIZE + StartPos)^[0];
        // -- Start position of field name in the literal part of storage
        NodeOp2 := PWordArray(PAnsiChar(FilterData) + CANHDRSIZE + StartPos)^[1];
        NodeOp3 := GetLiteralValue(Buffer, FilterData, NodeOp2, -1);

        if Rec <> nil then
          Result := Rec.Value[NodeOp1 - 1, dvvValueEh]
        else if RecordsView = nil then
          Result := Dataset.FieldValues[GetValueByType(Buffer, NodeOp3, ftString, 0)]
        else
//          Result := RecordsView.Value[CurCalcRec, NodeOp1 - 1]
          Result := RecordsView.AccountableRecord[CurCalcRec].Value[NodeOp1 - 1, dvvValueEh]
      end else
        raise Exception.CreateFmt(ErrOpStr, [NodeType, NodeOp]);

    nodeCONST:
      if TCANOperator(NodeOp) = coCONST2 then
      begin
        
        NodeOp1 := PWordArray(PAnsiChar(FilterData) + CANHDRSIZE + StartPos)^[0];
        
        NodeOp2 := PWordArray(PAnsiChar(FilterData) + CANHDRSIZE + StartPos)^[1];
        
        NodeOp3 := PWordArray(PAnsiChar(FilterData) + CANHDRSIZE + StartPos)^[2];

        GetLiteralValue(Buffer, FilterData, NodeOp3, NodeOp2);
        if NodeOp1 < MAXLOGFLDTYPES then
//          if Rec <> nil then
//            Result := Rec.Value[NodeOp1 - 1, dvvValueEh]
//          else
            Result := GetValueByType(Buffer, NodeOp2, DataTypeMap[NodeOp1], NodeOp1)
        else if NodeOp1 = $1007 then
          Result := GetValueByType(Buffer, NodeOp2, ftUnknown, NodeOp1)
        else
          Result := Null;
      end else
        raise Exception.CreateFmt(ErrOpStr, [NodeType, NodeOp]);

    nodeFUNC:
      if TCANOperator(NodeOp) = coFUNC2 then
      begin
        
        NodeOp1 := PWordArray(PAnsiChar(FilterData) + CANHDRSIZE + StartPos)^[0];
        
        NodeOp2 := PWordArray(PAnsiChar(FilterData) + CANHDRSIZE + StartPos)^[1];

        NodeOp3 := GetLiteralValue(Buffer, FilterData, NodeOp1, -1);
//        FuncName := string(TVarData(GetValueByType(Buffer, NodeOp3, ftString, 0)).VString);
        FuncName := VarToStr(GetValueByType(Buffer, NodeOp3, ftString, 0));

        if CompareText(FuncName, 'SUBSTRING')      = 0 then FuncType := eftSubString
        else if CompareText(FuncName, 'UPPER')     = 0 then FuncType := eftUpper
        else if CompareText(FuncName, 'LOWER')     = 0 then FuncType := eftLower
        else if CompareText(FuncName, 'TRIM')      = 0 then FuncType := eftTrim
        else if CompareText(FuncName, 'TRIMLEFT')  = 0 then FuncType := eftTrimLeft
        else if CompareText(FuncName, 'TRIMRIGHT') = 0 then FuncType := eftTrimRight
        else if CompareText(FuncName, 'YEAR')      = 0 then FuncType := eftYear
        else if CompareText(FuncName, 'MONTH')     = 0 then FuncType := eftMonth
        else if CompareText(FuncName, 'DAY')       = 0 then FuncType := eftDay
        else if CompareText(FuncName, 'HOUR')      = 0 then FuncType := eftHour
        else if CompareText(FuncName, 'MINUTE')    = 0 then FuncType := eftMinute
        else if CompareText(FuncName, 'SECOND')    = 0 then FuncType := eftSecond
        else if CompareText(FuncName, 'GETDATE')   = 0 then FuncType := eftGetDate
        else if CompareText(FuncName, 'DATE')      = 0 then FuncType := eftDate
        else if CompareText(FuncName, 'TIME')      = 0 then FuncType := eftTime
        else if CompareText(FuncName, 'SUM')       = 0 then FuncType := eftSum
        else if CompareText(FuncName, 'MIN')       = 0 then FuncType := eftMin
        else if CompareText(FuncName, 'MAX')       = 0 then FuncType := eftMax
        else if CompareText(FuncName, 'AVG')       = 0 then FuncType := eftAvg
        else if CompareText(FuncName, 'COUNT')     = 0 then FuncType := eftCount
        else if CompareText(FuncName, 'COUNT(*)')  = 0 then FuncType := eftCountAll
        else
          raise Exception.CreateFmt('Unsupported function: %s', [FuncName]);

        try
          if FuncType in [eftSubString, eftUpper, eftLower, eftTrim, eftTrimLeft,
                          eftTrimRight, eftYear, eftMonth, eftDay, eftHour, eftMinute,
                          eftSecond, eftGetDate, eftDate, eftTime] then
          begin
            NodeOp3 := GetParameters(NodeOp2);

            { ================================================================ }
            if FuncType = eftSubString then
            begin
              if (NodeOp3 = 2) or (NodeOp3 = 3) then
              begin
                if VarIsNull(ListBuffer[0]) then
                  Result := Null
                else if NodeOp3 = 2 then
                  Result := Copy(VarToStr(ListBuffer[0]),
                                 Integer(ListBuffer[1]), MaxInt)
                else if NodeOp3 = 3 then
                  Result := Copy(VarToStr(ListBuffer[0]),
                                 Integer(ListBuffer[1]),
                                 Integer(ListBuffer[2]) );
              end else
                raise Exception.CreateFmt('Incorrect number of arguments in function <%s>', [FuncName]);
            end
            { ================================================================ }
            else if FuncType = eftUpper then
            begin
              if NodeOp3 = 1 then
              begin
                if VarIsNull(ListBuffer[0]) then
                  Result := Null
                else
                  Result := AnsiUpperCase(VarToStr(ListBuffer[0]));
              end else
                raise Exception.CreateFmt('Incorrect number of arguments in function <%s>', [FuncName]);
            end
            { ================================================================ }
            else if FuncType = eftLower then
            begin
              if NodeOp3 = 1 then
              begin
                if VarIsNull(ListBuffer[0]) then
                  Result := Null
                else
                  Result := AnsiLowerCase(VarToStr(ListBuffer[0]));
              end else
                raise Exception.CreateFmt('Incorrect number of arguments in function <%s>', [FuncName]);
            end
            { ================================================================ }
            else if FuncType in [eftTrim, eftTrimLeft, eftTrimRight] then
            begin
              if (NodeOp3 = 1) or (NodeOp3 = 2) then
              begin
                if VarIsNull(ListBuffer[0]) then
                  Result := Null
                else if NodeOp3 = 1 then
                  Result := TrimChars(FuncType, VarToStr(ListBuffer[0]))
                else
                  Result := TrimChars(FuncType,
                                      VarToStr(ListBuffer[0]),
                                      VarToStr(ListBuffer[1]) );
              end else
                raise Exception.CreateFmt('Incorrect number of arguments in function <%s>', [FuncName]);
            end
            { ================================================================ }
            else if FuncType in [eftYear, eftMonth, eftDay] then
            begin
              if NodeOp3 = 1 then
              begin
                if VarIsNull(ListBuffer[0]) then
                  Result := Null
                else
                begin
                  DecodeDate(TDateTime(TVarData(ListBuffer[0]).VDate),
                             Year_Hour, Month_Min, Day_Sec);
                  case FuncType of
                    eftYear:
                      Result := Year_Hour;
                    eftMonth:
                      Result := Month_Min;
                    eftDay:
                      Result := Day_Sec;
                  end;
                end;
              end else
                raise Exception.CreateFmt('Incorrect number of arguments in function <%s>', [FuncName]);
            end
            { ================================================================ }
            else if FuncType in [eftHour, eftMinute, eftSecond] then
            begin
              if NodeOp3 = 1 then
              begin
                if VarIsNull(ListBuffer[0]) then
                  Result := Null
                else
                begin
                  DecodeTime(TDateTime(TVarData(ListBuffer[0]).VDate), Year_Hour, Month_Min, Day_Sec, MSec);
                  case FuncType of
                    eftHour:
                      Result := Year_Hour;
                    eftMinute:
                      Result := Month_Min;
                    eftSecond:
                      Result := Day_Sec;
                  end;
                end;
              end else
                raise Exception.CreateFmt('Incorrect number of arguments in function <%s>', [FuncName]);
            end
            { ================================================================ }
            else if FuncType = eftGetDate then
            begin
              if NodeOp3 = 0 then
                Result := Now
              else
                raise Exception.CreateFmt('Incorrect number of arguments in function <%s>', [FuncName]);
            end
            { ================================================================ }
            else if FuncType = eftDate then
            begin
              if NodeOp3 = 1 then
                if VarIsNull(ListBuffer[0]) then
                  Result := Null
                else
                  Result := DateOf(TDateTime(TVarData(ListBuffer[0]).VDate))
              else
                raise Exception.CreateFmt('Incorrect number of arguments in function <%s>', [FuncName]);
            end
            { ================================================================ }
            else if FuncType = eftTime then
            begin
              if NodeOp3 = 1 then
                if VarIsNull(ListBuffer[0]) then
                  Result := Null
                else
                  Result := TimeOf(TDateTime(TVarData(ListBuffer[0]).VDate))
              else
                raise Exception.CreateFmt('Incorrect number of arguments in function <%s>', [FuncName]);
            end
          end else
          begin
            { ================================================================ }
            if FuncType = eftCountAll then
            begin
              NodeOp3 := GetParameters(NodeOp2);
              if NodeOp3 = 0 then
                Result := RecordsView.AccountableItemsCount// Count
              else
                raise Exception.CreateFmt('Incorrect number of arguments in function <%s>', [FuncName]);
            end
            { ================================================================ }
            else if RecordsView.AccountableItemsCount > 0 then
            begin
              CurCalcRec := 0;
              NodeOp3 := GetParameters(NodeOp2);

              if NodeOp3 = 1 then
              begin
                case FuncType of
                  eftMin, eftMax:
                    Result_Right := ListBuffer[0];

                  eftSum, eftAvg:
                    if (not VarIsNull(ListBuffer[0])) and
                       (VarType(ListBuffer[0]) in [varSmallint, varInteger,
{$IFDEF EH_LIB_6}
                          varShortInt, varByte, varWord, varLongWord, varInt64,
{$ENDIF}
                          varSingle, varDouble, varCurrency, varDate, varBoolean])
                    then
                      Result := ListBuffer[0]
                    else
                      Result := 0;

                  eftCount:
                    if VarIsNull(ListBuffer[0]) then Result := 0
                    else Result := 1;
                end;
                SetListBufferLength(0);

                for i := 1 to RecordsView.AccountableItemsCount-1 do
                begin
                  CurCalcRec := i;
                  GetParameters(NodeOp2);

                  case FuncType of
                    eftMin:
                      if (VarType(ListBuffer[0]) = varString) or (VarType(Result_Right) = varString) then
                      begin
                        if VarCompareStr(VarToStr(ListBuffer[0]),
                                       VarToStr(Result_Right)) < 0 then
                          Result_Right := ListBuffer[0];
                      end else
                        if ListBuffer[0] < Result_Right then Result_Right := ListBuffer[0];

                    eftMax:
                      if (VarType(ListBuffer[0]) = varString) or (VarType(Result_Right) = varString) then
                      begin
                        if VarCompareStr(VarToStr(ListBuffer[0]),
                                       VarToStr(Result_Right)) > 0 then
                          Result_Right := ListBuffer[0];
                      end else
                       if ListBuffer[0] > Result_Right then Result_Right := ListBuffer[0];

                    eftCount:
                      if not VarIsNull(ListBuffer[0]) then
                        Result := Result + 1;

                    eftSum, eftAvg:
                      if (not VarIsNull(ListBuffer[0])) and
                         (VarType(ListBuffer[0]) in [varSmallint, varInteger,
{$IFDEF EH_LIB_6}
                          varShortInt, varByte, varWord, varLongWord, varInt64,
{$ENDIF}
                            varSingle, varDouble, varCurrency, varDate, varBoolean]) then
                        Result := Result + ListBuffer[0];
                  end;
                  SetListBufferLength(0);
                end;

                case FuncType of
                  eftAvg:
                    Result := Result / RecordsView.AccountableItemsCount;

                  eftMin, eftMax:
                    Result := Result_Right;
                end;
              end else
                raise Exception.CreateFmt('Incorrect number of arguments in function <%s>', [FuncName]);
            end else
              Result := Null;
          end;
        finally
          SetListBufferLength(0);
        end;
      end else
        raise Exception.CreateFmt(ErrOpStr, [NodeType, NodeOp]);

    nodeLISTELEM:
      if TCANOperator(NodeOp) = coLISTELEM2 then
      begin
(*
        
        NodeOp1 := PWordArray(PAnsiChar(FilterData) + CANHDRSIZE + StartPos)^[0];
        
        NodeOp2 := PWordArray(PAnsiChar(FilterData) + CANHDRSIZE + StartPos)^[1];

        Result_Left := GetNodeResult(DataSet, RecordsView, Rec, FilterData, CANEXPRSIZE + NodeOp1);

        NodeOp3 := ListBufferLength;
        SetListBufferLength(NodeOp3 + 1);
        ListBuffer[NodeOp3] := Result_Left;

        // if next node is exist
        if NodeOp2 > 0 then GetNodeResult(DataSet, RecordsView, Rec, FilterData, CANEXPRSIZE + NodeOp2);

        Result := True;
*)
        while True do
        begin

          
          NodeOp1 := PWordArray(PAnsiChar(FilterData) + CANHDRSIZE + StartPos)^[0];
          
          NodeOp2 := PWordArray(PAnsiChar(FilterData) + CANHDRSIZE + StartPos)^[1];

          Result_Left := GetNodeResult(DataSet, RecordsView, Rec, FilterData, CANEXPRSIZE + NodeOp1);

          NodeOp3 := ListBufferLength;
          SetListBufferLength(NodeOp3 + 1);
          ListBuffer[NodeOp3] := Result_Left;

          Result := True;
          // if next node is exist
          if NodeOp2 <= 0 then
          begin
//            GetNodeResult(DataSet, RecordsView, Rec, FilterData, CANEXPRSIZE + NodeOp2);
            Break;
          end else
            StartPos := CANEXPRSIZE + NodeOp2;
        end;

      end
      else
        raise Exception.CreateFmt(ErrOpStr, [NodeType, NodeOp]);
  end;

end;
{$ENDIF} //CIL
{$ENDIF} //FPC

{
function IsCurRecordInFilter(DataSet: TDataSet; ExprParser: TExprParser): Boolean;
begin
  if ExprParser.DataSize > 0 then
  begin
    SetLength(ListBuffer, 0);
//    Result := Boolean(TVarData(GetNodeResult(DataSet, ExprParser.FilterData, CANEXPRSIZE)).VBoolean)
  end
  else
    Result := False;
end;
}

procedure TRecordsViewEh.InstantDisableFilter;
begin
  Inc(FDisableFilterCount);
end;

procedure TRecordsViewEh.InstantEnableFilter;
begin
  Dec(FDisableFilterCount);
end;

function TRecordsViewEh.GetViewAsTreeList: Boolean;
begin
  Result := FViewAsTreeList;
end;

procedure TRecordsViewEh.SetViewAsTreeList(const Value: Boolean);
begin
  if FViewAsTreeList <> Value then
  begin
    FViewAsTreeList := Value;
    if FViewAsTreeList
      then RebuildMemoryTreeList
      else ClearMemoryTreeList;
    RefreshFilteredRecsList;
  end;
end;

procedure TRecordsViewEh.RebuildMemoryTreeList;
var
  I: Integer;
begin
  FMemoryTreeList.Clear;
  if not ViewAsTreeList then Exit;
  for I := 0 to MemTableData.RecordsList.Count-1 do
    FMemoryTreeList.AddChildAtKey('', TreeViewKeyFieldName,
      TreeViewRefParentFieldName, MemTableData.RecordsList[I]);
end;

procedure TRecordsViewEh.ClearMemoryTreeList;
begin
  FMemoryTreeList.Clear;
end;

function TRecordsViewEh.ViewItemsCount: Integer;
begin
  if ViewAsTreeList
    then Result := MemoryTreeList.VisibleExpandedCount
    else Result := Count;
end;

function TRecordsViewEh.AccountableItemsCount: Integer;
begin
  if ViewAsTreeList
    then Result := MemoryTreeList.AccountableCount
    else Result := Count;
end;

function TRecordsViewEh.GetViewRecord(Index: Integer): TMemoryRecordEh;
begin
  if ViewAsTreeList
    then Result := MemoryTreeList.VisibleExpandedItem[Index].Rec
    else Result := Rec[Index];
end;

function TRecordsViewEh.GetRecordView(Index: Integer): TMemRecViewEh;
begin
  if ViewAsTreeList
    then Result := MemoryTreeList.VisibleExpandedItem[Index]
    else Result := TMemRecViewEh(FMemoryViewList[Index]);
end;

function TRecordsViewEh.GetAccountableRecord(Index: Integer): TMemoryRecordEh;
begin
  if ViewAsTreeList
    then Result := MemoryTreeList.AccountableItem[Index].Rec
    else Result := Rec[Index];
end;

function TRecordsViewEh.IndexOf(Rec: TMemoryRecordEh): Integer;
var
  i: Integer;
begin
  Result := -1;

  if ViewItemsCount = 0 then
    Exit;

  if ViewRecord[ViewItemsCount-1] = Rec then
    Result := ViewItemsCount-1
  else
    for i := 0 to ViewItemsCount-1 do
      if ViewRecord[i] = Rec then
      begin
        Result := i;
        Exit;
      end;
end;

{procedure TRecordsViewEh.SetMemTableData(AMemTableData: TMemTableDataEh);
begin
  inherited MemTableData := AMemTableData;
end;}

procedure TRecordsViewEh.RecordMoved(Item: TMemoryRecordEh; OldIndex,
  NewIndex: Integer);
var
  Index, i, iFrom, iTo: Integer;
  Node: TMemRecViewEh;
begin
  iFrom := -1;
  iTo := -1;
  if not ViewAsTreeList then
    if NewIndex < OldIndex then
    begin
      for i := 0 to FMemoryViewList.Count-1 do
      begin
        Index := GetRec(i).Index;
        if Index = NewIndex then
        begin
          iFrom := i;
          Break;
        end else if (Index >= NewIndex) {and (Index < OldIndex)} then
        begin
          if (Index >= NewIndex) and (iTo = -1)  then
            iTo := i;
        end;
      end;
      if iTo = -1 then
        iTo := 0;
    end else
    begin
      for i := 0 to Count-1 do
      begin
        Index := GetRec(i).Index;
        if Index = NewIndex then
        begin
          iFrom := i;
        end else if (Index > NewIndex) and (iTo = -1) then
        begin
          iTo := i-1;
          Break;
        end;
      end;
      if iTo = -1 then
        iTo := Count-1;
    end;

  if iFrom >= 0 then
  begin
    FMemoryViewList.Move(iFrom, iTo);
    Notify(nil, -1, rlnListChangingEh);
  end;

  if ViewAsTreeList then
  begin
    Node := MemoryTreeList.GetNode(nil, Item);
    if Node <> nil then
    begin
      for i := 0 to Node.NodeParent.NodesCount - 1 do
        if Node.NodeParent[i].Rec.Index > Item.Index then
        begin
          MemoryTreeList.MoveTo(Node, Node.Parent[i], naInsertEh, True);
          Exit;
        end;
      MemoryTreeList.MoveTo(Node, Node.Parent, naAddChildEh, True);
    end;
  end;
end;

procedure TRecordsViewEh.UpdateFields;
begin
  if TreeViewKeyFieldName <> ''
    then FTreeViewKeyFields := MemTableData.DataStruct.FieldsIndex(TreeViewKeyFieldName)
    else SetLength(FTreeViewKeyFields, 0);
  if TreeViewRefParentFieldName <> ''
    then FTreeViewRefParentFields := MemTableData.DataStruct.FieldsIndex(TreeViewRefParentFieldName)
    else SetLength(FTreeViewRefParentFields, 0);
end;

procedure TRecordsViewEh.UpdateLookupBuffer(RecView: TMemRecViewEh);
begin
  if Assigned(OnCalcLookupBuffer) then
    OnCalcLookupBuffer(RecView.Rec, RecView);
end;

procedure TRecordsViewEh.UpdateAllLookupBuffer;
var
  i: Integer;
begin
  for i := 0 to Count-1 do
  begin
{$IFDEF CIL}
{$ELSE}
    SetLength(RecordView[i].FLookupBuffer, 0);
{$ENDIF}
    UpdateLookupBuffer(RecordView[i]);
  end;
end;

procedure TRecordsViewEh.SetTreeViewKeyFieldName(const Value: String);
begin
  if FTreeViewKeyFieldName <> Value then
  begin
    FTreeViewKeyFieldName := Value;
    UpdateFields;
  end;
end;

procedure TRecordsViewEh.SetTreeViewRefParentFieldName(const Value: String);
begin
  if TreeViewRefParentFieldName <> Value then
  begin
    FTreeViewRefParentFieldName := Value;
    UpdateFields;
  end;
end;

function TRecordsViewEh.GetSortOrder: String;
begin
  Result := FSortOrder;
end;

procedure TRecordsViewEh.UpdateOrderCaseInsensitive;
var
  I: Integer;
begin
  for I := 0 to FOrderByList.Count - 1 do
    FOrderByList[I].CaseIns := FSortOrderCaseInsensitive;
end;

procedure TRecordsViewEh.SetSortOrder(const Value: String);
begin
  if FSortOrder <> Value then
  begin
    FOrderByList.ParseOrderByStr(Value);
    UpdateOrderCaseInsensitive;
    FSortOrder := Value;
    Resort;
  end;
end;

procedure TRecordsViewEh.SetSortOrderCaseInsensitive(const Value: Boolean);
begin
  if FSortOrderCaseInsensitive <> Value then
  begin
    FSortOrderCaseInsensitive := Value;
    UpdateOrderCaseInsensitive;
    Resort;
  end;
end;

procedure TRecordsViewEh.Resort;
begin
//  if FSortOrder <> '' then
  SortData(OnCompareRecords, FOrderByList);
  if ViewAsTreeList then
    FMemoryTreeList.SortOrder := SortOrder;
end;

function TRecordsViewEh.GetStatusFilter: TUpdateStatusSet;
begin
  Result := FStatusFilter;
end;

procedure TRecordsViewEh.SetStatusFilter(const Value: TUpdateStatusSet);
begin
  if Value <> FStatusFilter then
  begin
    FStatusFilter := Value;
    RefreshFilteredRecsList;
  end;
end;

function TRecordsViewEh.GetMemTableData: TMemTableDataEh;
begin
  Result := TMemTableDataEh(DataObject);
end;

procedure TRecordsViewEh.SetMemTableData(const Value: TMemTableDataEh);
begin
  DataObject := Value;
end;

procedure TRecordsViewEh.AddNotificator(RecordsList: TRecordsListNotificatorEh);
begin
  FNotificators.Add(RecordsList);
end;

procedure TRecordsViewEh.RemoveNotificator(RecordsList: TRecordsListNotificatorEh);
begin
  FNotificators.Remove(RecordsList);
end;

{ TDataSetExprParserEh }

constructor TDataSetExprParserEh.Create(ADataSet: TDataSet; ExprParserType: TDataSetExprParserTypeEh);
begin
  inherited Create;
  FDataSet := ADataSet;
  FExprParserType := ExprParserType;
end;

destructor TDataSetExprParserEh.Destroy;
begin
  {$IFDEF FPC}
  FreeAndNil(FExprData);
  {$ENDIF}
  inherited Destroy;
end;

function TDataSetExprParserEh.HasData: Boolean;
begin
  Result := (FExprDataSize > 0)
end;

procedure TDataSetExprParserEh.ParseExpression(const Expr: String);
{$IFDEF FPC}
begin
  if FExprData = nil then
    FExprData := TBufDatasetParser.Create(FDataSet);
  FExprData.PartialMatch := not (foNoPartialCompare in FDataSet.FilterOptions);
  FExprData.CaseInsensitive := foCaseInsensitive in FDataSet.FilterOptions;
  FExprData.ParseExpression(Expr);
  FExprDataSize := Length(Expr);
end;
{$ELSE}
const
  ParserTypeOptionsArr: array[TDataSetExprParserTypeEh] of TParserOptions =
    ([poExtSyntax], [poExtSyntax, poAggregate]);
var
  ExprParser: TExprParser;
begin
  ExprParser := TExprParser.Create(FDataSet, Expr, FDataSet.FilterOptions,
    ParserTypeOptionsArr[FExprParserType], '', nil, FieldTypeMap);
  FExprDataSize := ExprParser.DataSize;
  FExprData := ExprParser.FilterData;
  FreeAndNil(ExprParser);
end;
{$ENDIF}

function TDataSetExprParserEh.IsCurRecordInFilter(Rec: TMemoryRecordEh): Boolean;
begin
  {$IFDEF FPC}
  Result := True;
  {$ELSE}
  if FExprDataSize > 0 then
  begin
    SetListBufferLength(0);
    Result := GetNodeResult(FDataSet, nil, Rec, FExprData, CANEXPRSIZE)
  end else
    Result := False;
  {$ENDIF}
end;

function TDataSetExprParserEh.IsCurRecordBufInFilter(Buffer: TRecordBuffer): Boolean;
begin
  {$IFDEF FPC}
  if (FExprData <> nil) and (FExprDataSize > 0) then
    Result := Boolean((FExprData.ExtractFromBuffer(Buffer))^)
  else
    Result := False;
  {$ELSE}
  Result := True;
  {$ENDIF}
end;

function TDataSetExprParserEh.CalcAggregateValue(RecordsView: TRecordsViewEh): Variant;
begin
  {$IFDEF FPC}
  Result := Null;
  {$ELSE}
  if FExprDataSize > 0 then
  begin
    SetListBufferLength(0);
    Result := GetNodeResult(FDataSet, RecordsView, nil, FExprData, CANEXPRSIZE)
  end else
    Result := False;
  {$ENDIF}
end;

{ RegisterMemTableClasses }

procedure RegisterMemTableClasses;
var
  VarArray: Variant;
begin
  RegisterClass(TMemTableDataEh);
  RegisterClass(TMTDataStructEh);
  RegisterClass(TRecordsListEh);
  RegisterClasses([TMTDataFieldEh,
                   TMTStringDataFieldEh,
                   TMTNumericDataFieldEh,
                   TMTDateTimeDataFieldEh,
                   TMTBlobDataFieldEh,
                   TMTBooleanDataFieldEh,
                   TMTInterfaceDataFieldEh,
                   TMTVariantDataFieldEh,
                   TMTRefObjectFieldEh
{$IFDEF EH_LIB_6} ,TMTSQLTimeStampDataFieldEh {$ENDIF}
                   ]);

  VarArray := VarArrayCreate([0, 1], varByte);
  VarArrayOfBytesVarType := VarType(VarArray);
end;

procedure UnregisterMemTableClasses;
begin
  UnregisterClass(TMemTableDataEh);
  UnregisterClass(TMTDataStructEh);
  UnregisterClass(TRecordsListEh);
  UnregisterClasses([TMTDataFieldEh,
                   TMTStringDataFieldEh,
                   TMTNumericDataFieldEh,
                   TMTDateTimeDataFieldEh,
                   TMTBlobDataFieldEh,
                   TMTBooleanDataFieldEh,
                   TMTInterfaceDataFieldEh,
                   TMTVariantDataFieldEh,
                   TMTRefObjectFieldEh]);
end;

{ TUpdateErrorEh }

constructor TUpdateErrorEh.Create(AException: Exception);
begin
  inherited Create;
  FException := AException;
end;

destructor TUpdateErrorEh.Destroy;
begin
  inherited Destroy;
  FreeAndNil(FException);
end;

{ TMemoryTreeListEh }

constructor TMemoryTreeListEh.Create(ARecordsViewEh: TRecordsViewEh);
begin
  inherited Create(TMemRecViewEh);
  FVisibleItems := TObjectList.Create(False);
  FVisibleExpandedItems := TObjectList.Create(False);
  FRecordsViewEh := ARecordsViewEh;
  FInsertedNodeStack := TObjectList.Create(False);
  FilterNodeIfParentVisible := True;
  FOrderByList := TMemoryTreeListOrderByList.Create(Self);
end;

destructor TMemoryTreeListEh.Destroy;
begin
  FreeAndNil(FVisibleItems);
  FreeAndNil(FVisibleExpandedItems);
  FreeAndNil(FInsertedNodeStack);
  FreeAndNil(FOrderByList);
  inherited Destroy;
end;

function TMemoryTreeListEh.GetIndexForNode(Rec: TMemoryRecordEh; ParentNode: TMemRecViewEh): Integer;
var
  i: Integer;
  CurIndex, AMin, AMax: Integer;
begin
  if SortOrder <> '' then
  begin
    if ParentNode.NodesCount = 0 then
    begin
      Result := -1;
      Exit;
    end;
    if FRecordsViewEh.CompareRecords(ParentNode[0].Rec, Rec) > 0 then
    begin
      Result := 0;
      Exit;
    end;
    if FRecordsViewEh.CompareRecords(ParentNode[ParentNode.NodesCount-1].Rec, Rec) < 0 then
    begin
      Result := ParentNode.NodesCount;
      Exit;
    end;

    AMin := 0; AMax := ParentNode.NodesCount - 1;
    CurIndex := (AMax - AMin) div 2;
    Result := CurIndex;

    while True do
    begin
      if FRecordsViewEh.CompareRecords(ParentNode[CurIndex].Rec, Rec) > 0 then
      begin
        AMax := CurIndex;
        CurIndex := (AMax + AMin) div 2;
      end
      else
        if FRecordsViewEh.CompareRecords(ParentNode[CurIndex].Rec, Rec) < 0 then
        begin
          AMin := CurIndex;
          CurIndex := (AMax + AMin) div 2;
        end
        else
        begin
          Result := CurIndex;
          Exit;
        end;
      if Result = CurIndex then
      begin
        Inc(Result);
        Exit;
      end;
      Result := CurIndex;
    end;
  end
  else if (ParentNode = nil) or (ParentNode.Count = 0) or (ParentNode[ParentNode.Count-1].Rec.Index < Rec.Index) then
    Result := -1
  else
  begin
    Result := 0;
    for i := ParentNode.Count-1 downto 0 do
      if ParentNode[i].Rec.Index < Rec.Index then
      begin
        Result := i+1;
        Break;
      end;
  end;
end;

function TMemoryTreeListEh.AddChild(const Name: string; Parent: TMemRecViewEh; MemRecord: TMemoryRecordEh): TMemRecViewEh;
var
  i, NewIndex: Integer;


  function SearchNewPos({SortedList: TObjectList;}
    MemRec: TMemoryRecordEh{; OldIndex: Integer}): Integer;
  var
    CurIndex, AMin, AMax: Integer;
  begin
    if (Parent.NodesCount = 0) or (FRecordsViewEh.CompareRecords(Parent[0].Rec, MemRec)>0) then
    begin
      Result := 0;
      Exit;
    end;
    if (Parent.NodesCount > 1) and (FRecordsViewEh.CompareRecords(Parent[Parent.NodesCount-2].Rec, MemRec)<0) then
    begin
      Result := Parent.NodesCount-1;
      Exit;
    end;

    AMin := 0; AMax := Parent.NodesCount - 1;
    CurIndex := (AMax - AMin) div 2;
    Result := CurIndex;

    while True do
    begin
      if FRecordsViewEh.CompareRecords(Parent[CurIndex].Rec, MemRec) > 0 then
      begin
        AMax := CurIndex;
        CurIndex := (AMax + AMin) div 2;
      end
      else
        if FRecordsViewEh.CompareRecords(Parent[CurIndex].Rec, MemRec) < 0 then
        begin
          AMin := CurIndex;
          CurIndex := (AMax + AMin) div 2;
        end
        else
        begin
          Result := CurIndex;
          Exit;
        end;
      if Result = CurIndex then
      begin
        Inc(Result);
        Exit;
      end;
      Result := CurIndex;
    end;

  end;

begin
  if Parent = nil then
    Parent := TMemRecViewEh(Root);
  if MemRecord.Index = MemRecord.RecordsList.Count-1 then
    Result := TMemRecViewEh(inherited AddChild(Name, Parent, MemRecord))
  else
  begin
    Result := nil;
    if Parent = nil then
      Parent := TMemRecViewEh(Root);
    if (Parent.Count = 0) or (Parent = nil) or (Parent[Parent.Count-1].Rec.Index < MemRecord.Index) then
      Result := TMemRecViewEh(inherited AddChild(Name, Parent, MemRecord))
    else if SortOrder = '' then
      for i := Parent.Count-1 downto 0 do
        if Parent[i].Rec.Index < MemRecord.Index then
        begin
          Result := TMemRecViewEh(inherited AddChild(Name, Parent, MemRecord));
          MoveTo(Result, Parent[i+1], naInsertEh, True);
          Break;
        end;
    if Result = nil then
    begin
      Result := TMemRecViewEh(inherited AddChild(Name, Parent, MemRecord));
      if SortOrder = '' then
        MoveTo(Result, Parent[0], naInsertEh, True);
    end;
  end;
  if SortOrder <> '' then
  begin
    NewIndex := SearchNewPos(MemRecord);
    if NewIndex <> Parent.Count-1 then
      MoveTo(Result, Parent[NewIndex], naInsertEh, True);
  end;
  Result.Expanded := DefaultNodeExpanded;
//  Result.HasChildren := DefaultNodeHasChildren;
  Result.HasVisibleChildren := DefaultNodeHasChildren;
  FVisibleItemsObsolete := True;
end;

function TMemoryTreeListEh.GetNode(StartNode: TMemRecViewEh; MemRecord: TMemoryRecordEh): TMemRecViewEh;
begin
  Result := TMemRecViewEh(inherited GetNode(StartNode, MemRecord));
end;

function TMemoryTreeListEh.GetVisibleExpandedItem(const Index: Integer): TMemRecViewEh;
begin
  if FVisibleItemsObsolete then
    BuildVisibleItems;
  if (Index < 0) or (Index > FVisibleExpandedItems.Count-1) then
  begin
    Result := nil;
    Exit;
  end;
  Result := TMemRecViewEh(FVisibleExpandedItems.Items[Index]);
end;

function TMemoryTreeListEh.GetAccountableItem(const Index: Integer): TMemRecViewEh;
begin
  if FVisibleItemsObsolete then
    BuildVisibleItems;
  if (Index < 0) or (Index > FVisibleItems.Count-1) then
  begin
    Result := nil;
    Exit;
  end;
  Result := TMemRecViewEh(FVisibleItems.Items[Index]);
end;

function TMemoryTreeListEh.GetVisibleCount: Integer;
begin
  if FVisibleItemsObsolete then
    BuildVisibleItems;
  Result := FVisibleExpandedItems.Count;
end;

function TMemoryTreeListEh.GetAccountableCount: Integer;
begin
  if FVisibleItemsObsolete then
    BuildVisibleItems;
  Result := FVisibleItems.Count;
end;

function TMemoryTreeListEh.GetNodeAtValue(StartNode: TMemRecViewEh; const FieldNames: String; const Value: Variant): TMemRecViewEh;
var
  I: Integer;
  CurNode: TMemRecViewEh;
  CurMemRec: TMemoryRecordEh;
begin
  Result := nil;
  if StartNode = nil then
    StartNode := TMemRecViewEh(Root);
  for I := 0 to StartNode.Count - 1 do
  begin
    CurNode := StartNode.NodeItems[I];
    CurMemRec := TMemoryRecordEh(CurNode.Data);
    if VarEquals(CurMemRec.DataValues[FieldNames, dvvValueEh],Value) then
    begin
      Result := CurNode;
      Break;
    end
    else
    begin
      Result := GetNodeAtValue(CurNode, FieldNames, Value);
      if Result <> nil then
        Break;
    end;
  end
end;

function TMemoryTreeListEh.GetParentNodeAtKeyValue(StartNode: TMemRecViewEh;
  const KeyFieldNames: String; const ParentFieldNames: String;
  RefKeyValue: Variant): TMemRecViewEh;
var
  I: Integer;
  CurNode: TMemRecViewEh;
  CurMemRec: TMemoryRecordEh;
begin
  Result := TMemRecViewEh(Root);
  if StartNode = nil then
    StartNode := TMemRecViewEh(Root);
  for I := 0 to StartNode.Count - 1 do
  begin
    CurNode := StartNode.NodeItems[I];
    CurMemRec := TMemoryRecordEh(CurNode.Data);
    if VarEquals(CurMemRec.DataValues[KeyFieldNames, dvvValueEh], RefKeyValue) then
    begin
      Result := CurNode;
      Break;
    end
    else
    begin
      Result := GetParentNodeAtKeyValue(CurNode, KeyFieldNames, ParentFieldNames, RefKeyValue);
      if Result <> TMemRecViewEh(Root) then
        Break;
    end;
  end;
end;

function TMemoryTreeListEh.GetParentNodeAtKey(StartNode: TMemRecViewEh;
 const KeyFieldNames: String; const ParentFieldNames: String;
 MemRecord: TMemoryRecordEh): TMemRecViewEh;
var
  I, Index: Integer;
  CurNode: TMemRecViewEh;
  CurMemRec: TMemoryRecordEh;
  MTIndex: TMTIndexEh;
begin
  Result := TMemRecViewEh(Root);
  if StartNode = nil then
    StartNode := TMemRecViewEh(Root);
  MTIndex := MemRecord.RecordsList.Indexes.GetIndexForFields(KeyFieldNames);
  if (StartNode = Root) and (MTIndex <> nil) and MTIndex.Active and (MTIndex.Fields <> '') then
  begin
    Result := TMemRecViewEh(Root);
    if MTIndex.FindRecordIndexByKey(MemRecord.DataIndexValues[FRecordsViewEh.TreeViewRefParentFields, dvvValueEh], Index) then
      Result := GetNode(nil, MemRecord.RecordsList[Index]);
  end else
  begin
    for I := 0 to StartNode.Count - 1 do
    begin
      CurNode := StartNode.NodeItems[I];
      CurMemRec := TMemoryRecordEh(CurNode.Data);
      if VarEquals(CurMemRec.DataIndexValues[FRecordsViewEh.TreeViewKeyFields, dvvValueEh],
                   MemRecord.DataIndexValues[FRecordsViewEh.TreeViewRefParentFields, dvvValueEh]) then
      begin
        Result := CurNode;
        Break;
      end
      else
      begin
        Result := GetParentNodeAtKey(CurNode, KeyFieldNames, ParentFieldNames, MemRecord);
        if Result <> TMemRecViewEh(Root) then
          Break;
      end;
    end;
  end;
end;

function TMemoryTreeListEh.GetParentNodeForRec(MemRecord: TMemoryRecordEh): TMemRecViewEh;
var
  Index: Integer;
  MTIndex: TMTIndexEh;
begin
  Result := nil;

  if FInsertedNodeStack.Count > 0 then
{  if (FLastParentNodeForNewChild <> nil) and (FLastParentNodeForNewChild <> Root) then
    if VarEquals(FLastParentNodeForNewChild.Data.DataValues[KeyFieldNames, dvvValueEh],
         MemRecord.DataValues[ParentFieldNames, dvvValueEh])
    then
      Result := FLastParentNodeForNewChild;}
  if Result = nil then
  begin
    MTIndex := MemRecord.RecordsList.Indexes.GetIndexForFields(KeyFieldNames);
    if (MTIndex <> nil) and MTIndex.Active and (MTIndex.Fields <> '') then
    begin
      Result := nil;
      if MTIndex.FindRecordIndexByKey(MemRecord.DataValues[ParentFieldNames, dvvValueEh], Index) then
        Result := GetNode(nil, MemRecord.RecordsList[Index]);
    end else
      Result := GetParentNodeAtKey(nil, KeyFieldNames, ParentFieldNames, MemRecord);
  end;
end;

function TMemoryTreeListEh.GetChildNodesForKey(StartNode: TMemRecViewEh;
  const KeyFieldNames: String; const ParentFieldNames: String;
  MemRecord: TMemoryRecordEh; ChildList: TObjectList): TMemRecViewEh;
var
  I: Integer;
  CurNode: TMemRecViewEh;
  CurMemRec: TMemoryRecordEh;
begin
  Result := TMemRecViewEh(Root);
  if StartNode = nil then
    StartNode := TMemRecViewEh(Root);
  for I := 0 to StartNode.Count - 1 do
  begin
    CurNode := StartNode.NodeItems[I];
    CurMemRec := TMemoryRecordEh(CurNode.Data);
    if VarEquals(CurMemRec.DataValues[ParentFieldNames, dvvValueEh],
                 MemRecord.DataValues[KeyFieldNames, dvvValueEh])
    then
      ChildList.Add(CurNode)
    else
      Result := GetChildNodesForKey(CurNode, KeyFieldNames, ParentFieldNames, MemRecord, ChildList);
  end;
end;

{$IFDEF CIL}
function CompareNodeByRecInsex(Node1, Node2: TObject): Integer;
begin
  if TMemRecViewEh(Node1).Rec.Index > TMemRecViewEh(Node2).Rec.Index then
    Result := 1
  else if TMemRecViewEh(Node1).Rec.Index < TMemRecViewEh(Node2).Rec.Index then
    Result := -1
  else
    Result := 0;
end;
{$ELSE}
function CompareNodeByRecInsex(Node1, Node2: Pointer): Integer;
begin
  if TMemRecViewEh(Node1).Rec.Index > TMemRecViewEh(Node2).Rec.Index then
    Result := 1
  else if TMemRecViewEh(Node1).Rec.Index < TMemRecViewEh(Node2).Rec.Index then
    Result := -1
  else
    Result := 0;
end;
{$ENDIF}

function TMemoryTreeListEh.AddChildAtKey(const Name, KeyFieldNames , ParentFieldNames: String;
  MemRecord: TMemoryRecordEh): TMemRecViewEh;
var
  ParentNode: TMemRecViewEh;
  ChildNode, LastParent: TMemRecViewEh;
  Index, i: Integer;
  MTIndex: TMTIndexEh;
  ChildList: TObjectList;
//  KeyValue: Variant;
  IsInsertInStack: Boolean;
begin
  ParentNode := nil;
  IsInsertInStack := True;
  if FInsertedNodeStack.Count > 1 then
  begin
    LastParent := TMemRecViewEh(FInsertedNodeStack[FInsertedNodeStack.Count-2]);
//    if VarEquals(LastParent.Data.DataValues[KeyFieldNames, dvvValueEh],
//         MemRecord.DataValues[ParentFieldNames, dvvValueEh]) then
    if VarEquals(LastParent.Rec.DataIndexValues[FRecordsViewEh.TreeViewKeyFields, dvvValueEh],
         MemRecord.DataIndexValues[FRecordsViewEh.TreeViewRefParentFields, dvvValueEh]) then
    begin
      ParentNode := LastParent;
      IsInsertInStack := False;
    end;
    if (ParentNode = nil) then
    begin
      LastParent := TMemRecViewEh(FInsertedNodeStack[FInsertedNodeStack.Count-1]);
//      if VarEquals(LastParent.Data.DataValues[KeyFieldNames, dvvValueEh],
//           MemRecord.DataValues[ParentFieldNames, dvvValueEh])
      if VarEquals(LastParent.Rec.DataIndexValues[FRecordsViewEh.TreeViewKeyFields, dvvValueEh],
           MemRecord.DataIndexValues[FRecordsViewEh.TreeViewRefParentFields, dvvValueEh])
      then
        ParentNode := LastParent;
    end;
    if (ParentNode = nil) and (FInsertedNodeStack.Count > 1) then
    begin
      FInsertedNodeStack.Delete(FInsertedNodeStack.Count-1);
      FInsertedNodeStack.Delete(FInsertedNodeStack.Count-1);
      while FInsertedNodeStack.Count > 0 do
      begin
        LastParent := TMemRecViewEh(FInsertedNodeStack[FInsertedNodeStack.Count-1]);
//        if VarEquals(LastParent.Data.DataValues[KeyFieldNames, dvvValueEh],
//           MemRecord.DataValues[ParentFieldNames, dvvValueEh]) then
        if VarEquals(LastParent.Rec.DataIndexValues[FRecordsViewEh.TreeViewKeyFields, dvvValueEh],
             MemRecord.DataIndexValues[FRecordsViewEh.TreeViewRefParentFields, dvvValueEh]) then
        begin
          ParentNode := LastParent;
          Break;
        end else
          FInsertedNodeStack.Delete(FInsertedNodeStack.Count-1);
      end;
    end;
  end;
{  if (FLastParentNodeForNewChild <> nil) and (FLastParentNodeForNewChild <> Root) then
    if VarEquals(FLastParentNodeForNewChild.Data.DataValues[KeyFieldNames, dvvValueEh],
         MemRecord.DataValues[ParentFieldNames, dvvValueEh])
    then
      ParentNode := FLastParentNodeForNewChild;}
  if ParentNode = nil then
  begin
    MTIndex := MemRecord.RecordsList.Indexes.GetIndexForFields(KeyFieldNames);
    if (MTIndex <> nil) and MTIndex.Active and (MTIndex.Fields <> '') then
    begin
      ParentNode := nil;
      if MTIndex.FindRecordIndexByKey(MemRecord.DataValues[ParentFieldNames, dvvValueEh], Index) then
        ParentNode := GetNode(nil, MemRecord.RecordsList[Index]);
    end else
      ParentNode := GetParentNodeAtKey(nil, KeyFieldNames, ParentFieldNames, MemRecord);
  end;
{
  if (ParentNode = nil) or (ParentNode.Data = nil)
    then KeyValue := Null
//    else KeyValue := ParentNode.Data.DataValues[KeyFieldNames, dvvValueEh];
    else KeyValue := ParentNode.Rec.DataIndexValues[FRecordsViewEh.TreeViewKeyFields, dvvValueEh];
}
  Result := TMemRecViewEh(AddChild(Name, ParentNode, MemRecord));
  // It is very slow appending operations
  if FullBuildCheck then
  begin
    MTIndex := MemRecord.RecordsList.Indexes.GetIndexForFields(ParentFieldNames);
  //  ChildNode := TMemoryTreeNodeEh(Root);
    ChildList := TObjectList.Create(False);
    if (MTIndex <> nil) and MTIndex.Active then
    begin
  //    if Index.FindRecordIndexByKey(MemRecord.DataValues[KeyFieldNames, dvvValueEh], RecIndex) then
      if MTIndex.FindKeyValueIndex(MemRecord.DataValues[KeyFieldNames, dvvValueEh], Index) then
      begin
        i := Index-1;
        while i >= 0  do // Back in Index
        begin
          if MemRecord.DataValues[KeyFieldNames, dvvValueEh] = MTIndex.KeyValue[i] then
          begin
            ChildNode := GetNode(nil, MemRecord.RecordsList[MTIndex.Item[i].RecIndex]);
            if ChildNode <> nil then
              ChildList.Insert(0, ChildNode);
          end else Break;
          Dec(i);
        end;
        while Index < MTIndex.Count do // Forward in Index
        begin
          if MemRecord.DataValues[KeyFieldNames, dvvValueEh] = MTIndex.KeyValue[Index] then
          begin
            ChildNode := GetNode(nil, MemRecord.RecordsList[MTIndex.Item[Index].RecIndex]);
            if ChildNode <> nil then
              ChildList.Add(ChildNode);
          end else Break;
          Inc(Index);
        end;
      end;
    end else
      GetChildNodesForKey(nil, KeyFieldNames, ParentFieldNames, MemRecord, ChildList);
    ChildList.Sort(CompareNodeByRecInsex);
    for i := 0 to ChildList.Count-1 do
      MoveTo(TMemRecViewEh(ChildList[i]), Result, naAddChildEh, True);
    ChildList.Free;
  end;
  if IsInsertInStack
    then FInsertedNodeStack.Add(Result)
    else FInsertedNodeStack[FInsertedNodeStack.Count-1] := Result;
//  FLastParentNodeForNewChild := TMemoryTreeNodeEh(ParentNode);
{ TODO : Clear FLastParentNodeForNewChild if delete is it }
end;

function TMemoryTreeListEh.UpdateParent(Node: TMemRecViewEh; const KeyFieldNames: String;
  const ParentFieldNames: String; MemRecord: TMemoryRecordEh; ReIndex: Boolean): TMemRecViewEh;
var
  Index, OldIndex: Integer;
begin
  Result := GetParentNodeAtKey(nil, KeyFieldNames, ParentFieldNames, MemRecord);
  if Result <> Node.Parent then
  begin
    Index := GetIndexForNode(Node.Rec, Result);
    if Index >= 0
      then MoveTo(Node, Result[Index], naInsertEh, ReIndex)
      else MoveTo(Node, Result, naAddChildEh, ReIndex);
    FVisibleItemsObsolete := True;
  end else if SortOrder <> '' then
  begin
    OldIndex := Node.Index;
    ExtractNode(Node, True);
    Index := GetIndexForNode(Node.Rec, Result);
    if (Index = -1) or (Index = Result.Count)
      then AddNode(Node, Result, naAddChildEh, ReIndex)
      else AddNode(Node, Result[Index], naInsertEh, ReIndex);
    if Index <> OldIndex then
      FVisibleItemsObsolete := True;
  end;
end;

procedure TMemoryTreeListEh.VisibleItemsBecomeObsolete;
begin
  FVisibleItemsObsolete := True;
end;

procedure  TMemoryTreeListEh.BuildVisibleItems;
var
  CurNode: TBaseTreeNodeEh;
begin
  //{ TODO : Can to do at single pass? }
  FVisibleExpandedItems.Clear;
  CurNode := GetFirstVisible;
  while CurNode <> nil do
  begin
    FVisibleExpandedItems.Add(CurNode);
    CurNode := GetNextVisible(CurNode, True);
  end;

  FVisibleItems.Clear;
  CurNode := GetFirstVisible;
  while CurNode <> nil do
  begin
    FVisibleItems.Add(CurNode);
    CurNode := GetNextVisible(CurNode, False);
  end;

  FVisibleItemsObsolete := False;
end;

procedure TMemoryTreeListEh.SortData(CompareProg: TCompareNodesEh; ParamSort:
  TObject; ARecurse: Boolean);
begin
  inherited SortData(CompareProg, ParamSort, ARecurse);
  BuildVisibleItems;
  FRecordsViewEh.Notify(nil, -1, rlnListChangedEh);
end;

procedure TMemoryTreeListEh.Resort;
begin
  SortData(CompareTreeNodes, FOrderByList, True);
  BuildVisibleItems;
end;

procedure TMemoryTreeListEh.UpdateNodeState(Node: TMemRecViewEh; IsUpdateParent: Boolean);
begin
  //                                                    
  FVisibleItemsObsolete := True;  // Optimize
  if Node <> Root then
  begin
    if Node.VisibleCount > 0
      then Node.Visible := True
      else Node.Visible := FRecordsViewEh.FilterRecord(Node.Rec, -1, Node);
    FRecordsViewEh.UpdateLookupBuffer(Node);
  end;
  if IsUpdateParent and (Node.Parent <> nil) and
    (Node.Parent <> Root) and (Node.Visible <> Node.NodeParent.NodeVisible)
    {(Node.Parent.VisibleCount = 0)}
  then
    UpdateNodeState(Node.NodeParent, True);
end;

procedure TMemoryTreeListEh.UpdateNodesState(Parent: TMemRecViewEh);
var
  i: Integer;
begin
  if Parent = nil then
    Parent := TMemRecViewEh(Root);
  for i := 0 to Parent.Count-1 do
  begin
    UpdateNodesState(Parent[i]);
    UpdateNodeState(Parent[i], False);
  end;
end;

procedure TMemoryTreeListEh.SetChieldVisibleForVisibleParents(Parent: TMemRecViewEh);
var
  i: Integer;
begin
  if Parent = nil then
    Parent := TMemRecViewEh(Root);
  for i := 0 to Parent.Count-1 do
  begin
    if Parent[i].Visible and (Parent[i].VisibleCount = 0)  then
      SetChieldsVisible(Parent[i], True, True)
    else if Parent[i].Visible then
      SetChieldVisibleForVisibleParents(Parent[i]);
  end;
end;

procedure TMemoryTreeListEh.SetChieldsVisible(Parent: TMemRecViewEh; Visible: Boolean; ARecurse: Boolean);
var
  i: Integer;
begin
  if Parent = nil then
    Parent := TMemRecViewEh(Root);
  for i := 0 to Parent.Count-1 do
  begin
    Parent[i].Visible := Visible;
    if ARecurse then
      SetChieldsVisible(Parent[i], Visible, ARecurse);
  end;
end;

procedure TMemoryTreeListEh.GetRecordsList(List: TObjectList; Node: TMemRecViewEh;
  ARecurse: Boolean = True);
var
  i: Integer;
begin
  for i := 0 to Node.Count-1 do
  begin
    List.Add(Node[i].Data);
    if ARecurse then
      GetRecordsList(List, Node[i], ARecurse);
  end;
end;

function TMemoryTreeListEh.CheckReferenceLoop(MemRecord: TMemoryRecordEh; NewRefValue: Variant): Boolean;
var
  Parent, ANode: TMemRecViewEh;
  ANewRefValue: Variant;
begin
  Result := False;
  if VarIsEmpty(NewRefValue)
    then ANewRefValue := MemRecord.DataValues[ParentFieldNames, dvvValueEh]
    else ANewRefValue := NewRefValue;
  if VarIsNull(ANewRefValue) then
    Exit;
  Result := True;
  if DBVarCompareValue(ANewRefValue, MemRecord.DataValues[KeyFieldNames, dvvValueEh]) = vrEqual then
    Exit;
  Parent := GetParentNodeForRefValue(ANewRefValue);
  ANode := Parent;
  while (ANode <> nil) and (ANode <> Root) do
  begin
    if ANode.Data = MemRecord then
      Exit;
    ANode := ANode.NodeParent;
  end;
  Result := False;
end;

function TMemoryTreeListEh.GetParentNodeForRefValue(RefValue: Variant): TMemRecViewEh;
var
  Index: Integer;
  MTIndex: TMTIndexEh;
begin
  Result := nil;
{ TODO : To Do }
{  if (FLastParentNodeForNewChild <> nil) and (FLastParentNodeForNewChild <> Root) then
    if VarEquals(FLastParentNodeForNewChild.Data.DataValues[KeyFieldNames, dvvValueEh], RefValue) then
      Result := FLastParentNodeForNewChild;}
  if Result = nil then
  begin
    MTIndex := FRecordsViewEh.MemTableData.RecordsList.Indexes.GetIndexForFields(KeyFieldNames);
    if (MTIndex <> nil) and MTIndex.Active and (MTIndex.Fields <> '') then
    begin
      Result := nil;
      if MTIndex.FindRecordIndexByKey(RefValue, Index) then
        Result := GetNode(nil, FRecordsViewEh.MemTableData.RecordsList[Index]);
    end else
      Result := GetParentNodeAtKeyValue(nil, KeyFieldNames, ParentFieldNames, RefValue);
  end;
end;

function TMemoryTreeListEh.GetKeyFieldNames: String;
begin
  Result := FRecordsViewEh.TreeViewKeyFieldName;
end;

function TMemoryTreeListEh.GetParentFieldNames: String;
begin
  Result := FRecordsViewEh.TreeViewRefParentFieldName;
end;

procedure TMemoryTreeListEh.MoveTo(Node, Destination: TBaseTreeNodeEh;
  Mode: TNodeAttachModeEh; ReIndex: Boolean);
begin
  inherited MoveTo(Node, Destination, Mode, ReIndex);
  FVisibleItemsObsolete := True;
end;

function TMemoryTreeListEh.GetSortOrder: String;
begin
  Result := FSortOrder;
end;

procedure TMemoryTreeListEh.SetSortOrder(const Value: String);
begin
  if FSortOrder <> Value then
  begin
    FOrderByList.ParseOrderByStr(Value);
    UpdateOrderCaseInsensitive;
    FSortOrder := Value;
    Resort;
  end;
end;

function TMemoryTreeListEh.CompareTreeNodes(Rec1, Rec2: TBaseTreeNodeEh; ParamSort: TObject): Integer;
begin
  if Assigned(FRecordsViewEh.OnCompareRecords) then
    Result := FRecordsViewEh.OnCompareRecords(TMemRecViewEh(Rec1).Rec,
                                              TMemRecViewEh(Rec2).Rec, ParamSort)
  else
    Result := inherited CompareTreeNodes(Rec1, Rec2, ParamSort);
end;

{ TMemRecViewEh }

//constructor TMemRecViewEh.Create(AOwner: TComponent);
constructor TMemRecViewEh.Create;
begin
//  inherited Create(AOwner);
  inherited Create;
end;

destructor TMemRecViewEh.Destroy;
begin
  if NodeOwner <> nil then
  begin
    NodeOwner.FVisibleItemsObsolete := True;
    if NodeOwner.FInsertedNodeStack <> nil then
      if NodeOwner.FInsertedNodeStack.IndexOf(Self) >= 0 then
        NodeOwner.FInsertedNodeStack.Clear;
  end;
  inherited Destroy;
end;

function TMemRecViewEh.GetRec: TMemoryRecordEh;
begin
  Result := TMemoryRecordEh(inherited Data);
end;

function TMemRecViewEh.GetItem(const Index: Integer): TMemRecViewEh;
begin
  Result := TMemRecViewEh(inherited Items[Index]);
end;

function TMemRecViewEh.GetNodeOwner: TMemoryTreeListEh;
begin
  Result := TMemoryTreeListEh(inherited Owner);
end;

function TMemRecViewEh.GetNodeParent: TMemRecViewEh;
begin
  Result := TMemRecViewEh(inherited Parent);
end;

procedure TMemRecViewEh.SetNodeParent(const Value: TMemRecViewEh);
begin
  inherited Parent := Value;
end;

procedure TMemRecViewEh.SortByFields(const SortByStr: string);
var
  AParamSort: TObject;
begin
  if Assigned(NodeOwner.FRecordsViewEh.OnParseOrderByStr) then
  begin
    AParamSort := NodeOwner.FRecordsViewEh.OnParseOrderByStr(SortByStr);
    try
      SortData(NodeOwner.FRecordsViewEh.OnCompareTreeNode, AParamSort, False);
    finally
      AParamSort.Free;
    end;
  end;
end;

function TMemRecViewEh.GetNodeLevel: Integer;
begin
  Result := Level;
end;

function TMemRecViewEh.GetVisibleNodeIndex: Integer;
begin
  Result := VisibleIndex;
end;

function TMemRecViewEh.GetVisibleNodeItem(const Index: Integer): TMemRecViewEh;
begin
  Result := TMemRecViewEh(VisibleItem[Index]);
end;

function TMemRecViewEh.GetNodeHasChildren: Boolean;
begin
  Result := HasChildren;
end;

function TMemRecViewEh.GetNodeExpanded: Boolean;
begin
  Result := Expanded;
end;

procedure TMemRecViewEh.SetLookupBufferLength(NewLength: Integer);
begin
  SetLength(FLookupBuffer, NewLength);
end;

procedure TMemRecViewEh.SetNodeExpanded(const Value: Boolean);
begin
  Expanded := Value;
end;

function TMemRecViewEh.GetNodeVisible: Boolean;
begin
  Result := Visible;
end;

function TMemRecViewEh.GetNodeIndex: Integer;
begin
  Result := Index;
end;

function TMemRecViewEh.GetVisibleNodesCount: Integer;
begin
  Result := VisibleCount;
end;

function TMemRecViewEh.GetNodesCount: Integer;
begin
  Result := Count;
end;

procedure TMemRecViewEh.SetNodeHasChildren(const Value: Boolean);
begin
  HasChildren := Value;
end;

procedure TMemoryTreeListEh.UpdateOrderCaseInsensitive;
var
  I: Integer;
begin
  for I := 0 to FOrderByList.Count - 1 do
    FOrderByList[I].CaseIns := FRecordsViewEh.SortOrderCaseInsensitive;
end;

function TMemRecViewEh.GetNodeHasVisibleChildren: Boolean;
begin
  Result := HasVisibleChildren;
end;

procedure TMemRecViewEh.SetNodeHasVisibleChildren(const Value: Boolean);
begin
  HasVisibleChildren := Value;
end;

function TMemoryTreeListEh.GetNextVisibleSibling(
  Node: TMemRecViewEh): TMemRecViewEh;
begin
  Result := TMemRecViewEh(inherited GetNextVisibleSibling(Node));
end;

function TMemoryTreeListEh.GetNext(Node: TMemRecViewEh): TMemRecViewEh;
begin
  Result := TMemRecViewEh(inherited GetNext(Node));
end;

function TMemoryTreeListEh.GetPrevious(Node: TMemRecViewEh): TMemRecViewEh;
begin
  Result := TMemRecViewEh(inherited GetPrevious(Node));
end;

function TMemoryTreeListEh.GetRoot: TMemRecViewEh;
begin
  Result := TMemRecViewEh(inherited Root);
end;

procedure TMemoryTreeListEh.Collapse(Node: TMemRecViewEh;
  Recurse: Boolean);
begin
  inherited Collapse(Node, Recurse);
end;

procedure TMemoryTreeListEh.Expand(Node: TMemRecViewEh; Recurse: Boolean);
begin
  inherited Expand(Node, Recurse);
end;

{ TMemoryTreeListOrderByList }

function TMemoryTreeListOrderByList.FindFieldIndex(const FieldName: String): Integer;
begin
  Result := FTreeList.FRecordsViewEh.MemTableData.DataStruct.FieldIndex(FieldName);
end;

constructor TMemoryTreeListOrderByList.Create(ATreeList: TMemoryTreeListEh);
begin
  inherited Create;
  FTreeList := ATreeList;
end;

{ TMTIndexEh }

constructor TMTIndexEh.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FRecList := TObjectList.Create(False);
end;

constructor TMTIndexEh.CreateApart(ARecordsList: TRecordsListEh);
begin
  inherited Create(nil);
  FRecordsList := ARecordsList;
  FRecList := TObjectList.Create(False);
end;

destructor TMTIndexEh.Destroy;
begin
  ClearIndex;
  FreeAndNil(FRecList);
  inherited Destroy;
end;

procedure TMTIndexEh.ClearIndex;
var
  i: Integer;
begin
  for i := 0 to FRecList.Count-1 do
    TIndexItemEh(FRecList[i]).Free;
  FRecList.Clear;
end;

function TMTIndexEh.FindRecordIndexByKey(Value: Variant; var Index: Integer): Boolean;
begin
  Result := FindKeyValueIndex(Value, Index);
  if Result then
    Index := Item[Index].RecIndex;
end;

function TMTIndexEh.FindKeyValueIndex(Value: Variant; var Index: Integer): Boolean;
var
  L, H, I: Integer;
  C: TVariantRelationship;
begin
  Result := False;
  L := 0;
  H := FRecList.Count - 1;
  while L <= H do
  begin
    I := (L + H) shr 1;
    C := DBVarCompareValue(TIndexItemEh(FRecList[i]).Value, Value);
    if C = vrNotEqual then
      raise Exception.Create('TMTIndexEh.FindKeyValueIndex: values is not comparable.');
    if C = vrLessThan then
      L := I + 1
    else
    begin
      H := I - 1;
      if C = vrEqual then
      begin
        Result := True;
        {if Duplicates <> dupAccept then} L := I;
      end;
    end;
  end;
  Index := L;
end;

procedure TMTIndexEh.FillMatchedKeyList(Value: Variant; List: TObjectList);
var
  Index, BackIndex: Integer;
begin
  if FindKeyValueIndex(Value, Index) then
  begin
    BackIndex := Index-1;
    while BackIndex >= 0  do // Back in Index
    begin
      if DBVarCompareValue(Value, KeyValue[BackIndex]) = vrEqual
        then List.Add(Item[BackIndex])
        else Break;
      Dec(BackIndex);
    end;
    while Index < Count do // Forward in Index
    begin
      if DBVarCompareValue(Value, KeyValue[Index]) = vrEqual
        then List.Add(Item[Index])
        else Break;
      Inc(Index);
    end;
  end;
end;

procedure TMTIndexEh.FillMatchedRecsList(Value: Variant; List: TObjectList);
var
  Index, BackIndex: Integer;
begin
  if FindKeyValueIndex(Value, Index) then
  begin
    BackIndex := Index-1;
    while BackIndex >= 0  do // Back in Index
    begin
      if DBVarCompareValue(Value, KeyValue[BackIndex]) = vrEqual
        then List.Add(RecordsList[Item[BackIndex].RecIndex])
        else Break;
      Dec(BackIndex);
    end;
    while Index < Count do // Forward in Index
    begin
      if DBVarCompareValue(Value, KeyValue[Index]) = vrEqual
        then List.Add(RecordsList[Item[Index].RecIndex])
        else Break;
      Inc(Index);
    end;
  end;
end;

procedure TMTIndexEh.QuickSort(L, R: Integer);
var
  I, J, P: Integer;
begin
  repeat
    I := L;
    J := R;
    P := (L + R) shr 1;
    repeat
      while DBVarCompareValue(
        TIndexItemEh(FRecList[I]).Value,
        TIndexItemEh(FRecList[P]).Value) = vrLessThan
      do Inc(I);
      while DBVarCompareValue(
        TIndexItemEh(FRecList[J]).Value,
        TIndexItemEh(FRecList[P]).Value) = vrGreaterThan
      do Dec(J);
      if I <= J then
      begin
        FRecList.Exchange(I, J);
        if P = I then
          P := J
        else if P = J then
          P := I;
        Inc(I);
        Dec(J);
      end;
    until I > J;
    if L < J then QuickSort(L, J);
    L := I;
  until I >= R;
end;

procedure TMTIndexEh.RebuildIndex;
var
  i: Integer;
begin
  ClearIndex;
  if Fields = '' then Exit;
  for i := 0 to RecordsList.Count-1 do
    FRecList.Add(TIndexItemEh.Create(RecordsList[i].DataValues[Fields, dvvValueEh], i));
  if RecordsList.Count > 0 then
    QuickSort(0, RecordsList.Count-1);
end;

function TMTIndexEh.RecordsList: TRecordsListEh;
begin
  if FRecordsList <> nil
    then Result := FRecordsList
    else Result := TMTIndexesEh(Collection).FRecList;
end;

procedure TMTIndexEh.RLDataEvent(MemRec: TMemoryRecordEh; Index: Integer;
  Action: TRecordsListNotification);
var
  NewIndex, OldIndex, i: Integer;
  KeyFound: Boolean;
begin
  if not Active or (Fields = '') then Exit;
  case Action of
    rlnRecAddingEh:
      begin
        if Unical or Primary  then
        begin
          KeyFound := FindKeyValueIndex(MemRec.DataValues[Fields, dvvValueEh], NewIndex);
          if KeyFound then
            raise EUnicalKeyViolationEh.Create('Unique key violation '#13 +
              ' FieldNames: ' + Fields + #13 +
              ' Value: "' + AnyVarToStrEh(MemRec.DataValues[Fields, dvvValueEh]) + '"');
        end;
      end;
    rlnRecAddedEh:
      begin
        FindKeyValueIndex(MemRec.DataValues[Fields, dvvValueEh], NewIndex);
        if Index < FRecList.Count then
          for i := 0 to Count-1 do
            if Item[i].RecIndex >= Index then
              Inc(Item[i].RecIndex);
        if NewIndex = FRecList.Count
          then FRecList.Add(TIndexItemEh.Create(MemRec.DataValues[Fields, dvvValueEh], Index))
//          else FRecList.Insert(NewIndex, TIndexItemEh.Create(MemRec.DataValues[Fields, dvvValueEh], Index));
          else InsertIndexItemForValue(NewIndex, MemRec.DataValues[Fields, dvvValueEh],
            TIndexItemEh.Create(MemRec.DataValues[Fields, dvvValueEh], Index));
      end;
    rlnRecChangingEh:
      begin
        FOldValue := MemRec.DataValues[Fields, dvvCurValueEh];
        if (Unical or Primary) and (DBVarCompareValue(MemRec.DataValues[Fields, dvvValueEh], FOldValue) <> vrEqual) then
        begin
          KeyFound := FindKeyValueIndex(MemRec.DataValues[Fields, dvvValueEh], NewIndex);
          if KeyFound then
            raise EUnicalKeyViolationEh.Create('Unical key violation ' + VarToStr(MemRec.DataValues[Fields, dvvValueEh]));
        end;
      end;
    rlnRecChangedEh:
      begin
        FindKeyValueIndex(FOldValue, OldIndex);
        FindKeyValueIndex(MemRec.DataValues[Fields, dvvValueEh], NewIndex);
        SetKeyValue(OldIndex, MemRec.DataValues[Fields, dvvValueEh]);
{        SetKeyValue(OldIndex, MemRec.DataValues[Fields, dvvValueEh]);
        FindKeyValueIndex(KeyValue[OldIndex], NewIndex);}
        if NewIndex > OldIndex then Dec(NewIndex);
        FRecList.Move(OldIndex, NewIndex);
      end;
    rlnRecDeletedEh, rlnRecMarkedForDelEh:
      begin
//        if (Action = rlnRecDeletedEh) and (MemRec.UpdateStatus = usDeleted) then
//          Exit;
        if FindKeyValueIndex(MemRec.DataValues[Fields, dvvValueEh], OldIndex) then
        begin
          TIndexItemEh(FRecList[OldIndex]).Free;
          FRecList.Delete(OldIndex);
        end;
        if rlnRecDeletedEh = Action then
          for i := 0 to Count-1 do
            if Item[i].RecIndex >= Index then
              Dec(Item[i].RecIndex);
      end;
    rlnListChangedEh:
      RebuildIndex;
  end;
end;

procedure TMTIndexEh.InsertIndexItemForValue(InitIndex: Integer; Value: Variant; IndexItem: TIndexItemEh);
var
  i: Integer;
begin
  i := InitIndex;
{ TODO : It bring to saving valid ordering inside same values of index BUT slow working }
{ while i >= 0 do
  begin
    if (DBVarCompareValue(TIndexItemEh(FRecList[i]).Value, Value) = vrEqual) and
      (IndexItem.RecIndex < TIndexItemEh(FRecList[i]).RecIndex)
    then
      Dec(i)
    else
      Break;
  end;
  if i = InitIndex then
    while i < Count do
    begin
      if (DBVarCompareValue(TIndexItemEh(FRecList[i]).Value, Value) = vrEqual) and
        (IndexItem.RecIndex > TIndexItemEh(FRecList[i]).RecIndex)
      then
        Inc(i)
      else
        Break;
    end;}
  if i = Count
    then FRecList.Add(IndexItem)
    else FRecList.Insert(i, IndexItem);
end;

procedure TMTIndexEh.SetActive(const Value: Boolean);
begin
  if FActive <> Value then
  begin
    FActive := Value;
    if FActive
      then RebuildIndex
      else ClearIndex;
  end;
end;

procedure TMTIndexEh.SetFields(const Value: String);
begin
  if FFields <> Value then
  begin
    FFields := Value;
    RebuildIndex;
  end
end;

procedure TMTIndexEh.SetPrimary(const Value: Boolean);
begin
  if FPrimary <> Value then
  begin
    FPrimary := Value;
    RebuildIndex;
  end;
end;

procedure TMTIndexEh.SetUnical(const Value: Boolean);
begin
  if FUnical <> Value then
  begin
    FUnical := Value;
    RebuildIndex;
  end;
end;

function TMTIndexEh.GetKeyValue(Index: Integer): Variant;
begin
  Result := TIndexItemEh(FRecList[Index]).Value;
end;

procedure TMTIndexEh.SetKeyValue(Index: Integer; const Value: Variant);
begin
  TIndexItemEh(FRecList[Index]).Value := Value;
end;

function TMTIndexEh.Count: Integer;
begin
  Result := FRecList.Count;
end;

function TMTIndexEh.GetItems(Index: Integer): TIndexItemEh;
begin
  Result := TIndexItemEh(FRecList[Index]);
end;

procedure TMTIndexEh.RecordMoved(Item: TMemoryRecordEh; OldIndex,
  NewIndex: Integer);
var
  i: Integer;
  IndexItem: TIndexItemEh;
begin
  if NewIndex < OldIndex then
  begin
    for i := 0 to Count-1 do
    begin
      IndexItem := TIndexItemEh(FRecList[i]);
      if IndexItem.RecIndex = OldIndex then
        IndexItem.RecIndex := NewIndex
      else if (IndexItem.RecIndex >= NewIndex) and (IndexItem.RecIndex < OldIndex) then
        Inc(IndexItem.RecIndex);
    end;
  end else
  begin
    for i := 0 to Count-1 do
    begin
      IndexItem := TIndexItemEh(FRecList[i]);
      if IndexItem.RecIndex = OldIndex then
        IndexItem.RecIndex := NewIndex
      else if (IndexItem.RecIndex > OldIndex) and (IndexItem.RecIndex <= NewIndex) then
        Dec(IndexItem.RecIndex);
    end;
  end;
end;

{ TIndexItemEh }

constructor TIndexItemEh.Create(AValue: Variant; ARecIndex: Integer);
begin
  inherited Create;
  Value := AValue;
  RecIndex := ARecIndex;
end;

{ TMTIndexesEh }

constructor TMTIndexesEh.Create(ARecList: TRecordsListEh);
begin
  inherited Create(TMTIndexEh);
  FRecList := ARecList;
end;

destructor TMTIndexesEh.Destroy;
begin
  inherited Destroy;
end;

function TMTIndexesEh.Add: TMTIndexEh;
begin
  Result := TMTIndexEh(inherited Add);
end;

function TMTIndexesEh.GetItem(Index: Integer): TMTIndexEh;
begin
  Result := TMTIndexEh(inherited Items[Index]);
end;

procedure TMTIndexesEh.SetItem(Index: Integer; const Value: TMTIndexEh);
begin
  inherited Items[Index] := Value;
end;

procedure TMTIndexesEh.RLDataEvent(MemRec: TMemoryRecordEh; Index: Integer;
  Action: TRecordsListNotification);
var
  i: Integer;
begin
  for i := 0 to Count-1 do
    Items[i].RLDataEvent(MemRec, Index, Action);
end;

function TMTIndexesEh.GetIndexForFields(const Fields: String): TMTIndexEh;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count-1 do
    if CompareText(Items[i].Fields, Fields) = 0 then
//    if UpperCase(Items[i].Fields) = UpperCase(Fields) then
    begin
      Result := Items[i];
      Exit;
    end;
end;

procedure TMTIndexesEh.RecordMoved(Item: TMemoryRecordEh; OldIndex,
  NewIndex: Integer);
var
  i: Integer;
begin
  for i := 0 to Count-1 do
    Items[i].RecordMoved(Item, OldIndex, NewIndex);
end;

initialization
  RegisterMemTableClasses;
finalization
  UnregisterMemTableClasses;
end.
