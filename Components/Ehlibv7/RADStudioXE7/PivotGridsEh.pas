{*******************************************************}
{                                                       }
{                        EhLib v7.0                     }
{                                                       }
{                      PivotGridsEh                     }
{                      Build 7.0.006                    }
{                                                       }
{   Copyright (c) 2014-2014 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit PivotGridsEh;

interface

uses
{$IFDEF EH_LIB_17} System.Generics.Collections, {$ENDIF}
  Windows, SysUtils, Messages, Classes, Controls, Forms, StdCtrls, Dialogs,
{$IFDEF EH_LIB_5} Contnrs, {$ENDIF}
{$IFDEF EH_LIB_6} Variants, Types, {$ENDIF}
{$IFDEF EH_LIB_7} Themes, UxTheme, {$ENDIF}
{$IFDEF EH_LIB_17} System.UITypes, {$ENDIF}
{$IFDEF CIL}
  EhLibVCLNET,
  WinUtils,
{$ELSE}
  {$IFDEF FPC}
  EhLibLCL, DBGridsEh, LMessages, LCLType, Win32Extra,
  {$ELSE}
  EhLibVCL, DBGridEh,
  {$ENDIF}
{$ENDIF}
  MemTableEh, MemTableDataEh, MemTreeEh, TypInfo, DateUtils,
  GridsEh, GridToolCtrlsEh, DBCtrlsEh, ToolCtrlsEh,
  DBAxisGridsEh, DBUtilsEh, FilterDropDownFormsEh,
  DBCtrls, Db, Menus, Registry, Graphics, IniFiles, ImgList, StdActns,
  ActnList, ExtCtrls, DynVarsEh, ToolWin, Comctrls, CommCtrl;

type
  TCustomPivotGridEh = class;
  TPivotFieldsEh = class;
  TPivotFieldEh = class;
  TValueFieldsCollectionEh = class;
  TPivotDataSourceEh = class;
  TPivotGridScrollBarPanelControl = class;
  TPivotAxisTreeNodeEh = class;

  TFieldDateTimeSliceLevelEh = (dtslNonEh, dtslYearEh, dtslQuarterEh, dtslMonthEh, dtslWeekEh,
    dtslDayEh, dtslHourEh, dtslMinEh, dtslSecEh, dtslMSecEh);

//  TDateTimeSliceLevelEh = dtslYearEh..dtslMSecEh;

  TDateTimeSliceLevelsEh = set of TFieldDateTimeSliceLevelEh;

  TPivotValueTypeEh = (svtNonEh, svtSumEh, svtCountEh, svtAvgEh,
    svtMaxEh, svtMinEh, svtCountDistinctEh, svtCustomEh);

  TPivotCelTypeEh = (sctEmptyEh, sctFieldNameForRowEh, sctFieldNameForColEh,
    sctAxisValueEh, sctDataEh, sctHorzAggregateData, sctVertAggregateData,
    sctValuesColCaptionEh);

  TPivotFieldFetchValueEventEh = procedure(DataSource: TPivotDataSourceEh;
    PivotField: TPivotFieldEh; var Value: Variant; var Processed: Boolean) of object;

  IPivotDataSourceNotificationEh = interface
    ['{79ED2D2A-D1EC-4095-80CC-12F6D4D31BC7}']
    procedure PivotFieldsChanged(Sender: TObject);
    procedure PivotStructureChanged(Sender: TObject);
    procedure PivotDataChanged(Sender: TObject);
  end;

{ TAggrValueHolderEh }

  TAggrValueHolderEh = class(TPersistent)
  private
    FAggrFunc: TPivotValueTypeEh;
  public
    Value: Variant;
    SrvVars: TVariantDynArray;
    SrvObj: TObject;

    destructor Destroy; override;

    procedure ResetAggrHolder;
    procedure AggrValue(const AValue: Variant);
    function FinalizeAggregation: Variant;

    property AggrFunc: TPivotValueTypeEh read FAggrFunc write FAggrFunc;
  end;


  TPivotRectCellEh = record
    Rect: TRect;
    PivotArrayCol: Integer;
    PivotArrayRow: Integer;
  end;

  TPivotRectCellDynArrayEh = array of TPivotRectCellEh;

{ TPivotCellEh }

  TPivotCellEh = class(TPersistent)
  private
    FCelType: TPivotCelTypeEh;
  public
    Value: Variant;
    ArrayValue: TVariantDynArray;
    DrawDownLine: Boolean;
    DrawRightLine: Boolean;
    HorzAggrLevelCol: Integer;
    HorzAggrLevelRow: Integer;
    VertAggrLevelCol: Integer;
    VertAggrLevelRow: Integer;
    RowVisible: Boolean;
    ColVisible: Boolean;
    Expanded: Boolean;
    ShowValue: Boolean;
    ShowGroupingSign: Boolean;
    DrawFilterButton: Boolean;
    PivotField: TPivotFieldEh;
    MasterCol: Integer;
    MasterRow: Integer;

    RowsTreeNode: TPivotAxisTreeNodeEh;
    VisRowsGroupFlatNodePos: Integer;

    ColsTreeNode: TPivotAxisTreeNodeEh;
    VisColsGroupFlatNodePos: Integer;

    procedure Clear;
  published
    property CelType: TPivotCelTypeEh read FCelType write FCelType;
  end;

  TPivotArrayItem = record
    PivotValue: Variant;
    AggrValue: Variant;
  end;

  TPivotGridArray = array of array of TPivotCellEh;

  TPivotArray = array of TPivotArrayItem;

{ TPivotFieldDataTypeDefEh }

  TPivotFieldDataTypeDefEh = class(TPersistent)
  private
    FPrecision: Integer;
    FDataType: TFieldType;
    FSize: Integer;
    procedure SetDataType(const Value: TFieldType);
    procedure SetPrecision(const Value: Integer);
    procedure SetSize(const Value: Integer);
  published
    property DataType: TFieldType read FDataType write SetDataType default ftUnknown;
    property Precision: Integer read FPrecision write SetPrecision default 0;
    property Size: Integer read FSize write SetSize default 0;
  end;

{ TPivotFieldEh }

  TPivotFieldEh = class(TCollectionItem)
  private
    FDisplayFormat: String;
    FDisplayName: String;
    FExpression: TSTFilterExpressionEh;
    FExpressionStr: String;
    FFieldName: String;
    FFieldValueList: IMemTableDataFieldValueListEh;
//    FLookupDisplayFieldName: String;
//    FLookupKeyFieldName: String;
//    FLookupList: TDataSet;
    FOnFetchValue: TPivotFieldFetchValueEventEh;
    FSliceLevel: TFieldDateTimeSliceLevelEh;
    FSortOrder: TSortOrderEh;
    FSourceFieldName: String;
    FSumFunction: TPivotValueTypeEh;
    FTypeDef: TPivotFieldDataTypeDefEh;

    function GetExpression: TSTFilterExpressionEh;
    function GetPivotFields: TPivotFieldsEh;
    function IsDisplayNameStored: Boolean;
    procedure SetDisplayFormat(const Value: String);
    procedure SetDisplayName(const Value: String); reintroduce;
    procedure SetExpression(const Value: TSTFilterExpressionEh);
    procedure SetFieldName(const Value: String);
//    procedure SetLookupList(const Value: TDataSet);
    procedure SetSortOrder(const Value: TSortOrderEh);
    procedure SetSumFunction(const Value: TPivotValueTypeEh);
    procedure SetTypeDef(const Value: TPivotFieldDataTypeDefEh);
  protected
    FListValuesCheckingState: TBooleanDynArray;
    FPopupListboxDownIndex: Integer;

    function ParseExpression(const Exp: String): String;
    function GetDisplayName: string; override;

    procedure InternalSetExpressionStr(const Value: String); virtual;
    property FieldValueList: IMemTableDataFieldValueListEh read FFieldValueList write FFieldValueList;

  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;

    function GetValueForSource(SourceDataSet: TDataSet; Field: TField): Variant;
    function ProposedSumFunction: TPivotValueTypeEh;
    function ValueAsDispayText(const Value: Variant): String;

    procedure FillFilterValues(Items: TStrings);
    procedure SetNextSortOrder;
    procedure UpdateFilterFromValuesCheckingState(ss: TStrings; CheckStates: TBooleanDynArray);
    procedure UpdateValuesCheckingStateFromFilter(ss: TStrings; CheckStates: TBooleanDynArray);

    property Expression: TSTFilterExpressionEh read GetExpression write SetExpression;
    property PivotFields: TPivotFieldsEh read GetPivotFields;
    property SortOrder: TSortOrderEh read FSortOrder write SetSortOrder;

//    property LookupDisplayFieldName: String read FLookupDisplayFieldName write FLookupDisplayFieldName;
//    property LookupKeyFieldName: String read FLookupKeyFieldName write FLookupKeyFieldName;
//    property LookupList: TDataSet read FLookupList write SetLookupList;

  published
    property DisplayFormat: String read FDisplayFormat write SetDisplayFormat;
    property DisplayName: String read GetDisplayName write SetDisplayName stored IsDisplayNameStored;
    property FieldName: String read FFieldName write SetFieldName;
    property SliceLevel: TFieldDateTimeSliceLevelEh read FSliceLevel write FSliceLevel default dtslNonEh;
    property SourceFieldName: String read FSourceFieldName write FSourceFieldName;
    property SumFunction: TPivotValueTypeEh read FSumFunction write SetSumFunction default svtNonEh;
    property TypeDef: TPivotFieldDataTypeDefEh read FTypeDef write SetTypeDef;

    property OnFetchValue: TPivotFieldFetchValueEventEh read FOnFetchValue write FOnFetchValue;
  end;

  TPivotFieldEhClass = class of TPivotFieldEh;

{ TPivotFieldsEh }

  TPivotFieldsEh = class(TCollection)
  private
    FPDSource: TPivotDataSourceEh;
    function GetPivotField(Index: Integer): TPivotFieldEh;
    procedure SetPivotField(Index: Integer; Value: TPivotFieldEh);

  protected
    function GetOwner: TPersistent; override;
    procedure Notify(Item: TCollectionItem; Action: TCollectionNotification); override;
    procedure Update(Item: TCollectionItem); override;

  public
    constructor Create(APDSource: TPivotDataSourceEh; AClass: TPivotFieldEhClass);

    function Add: TPivotFieldEh;
    function FindFieldByName(const PivotFieldName: String): TPivotFieldEh;
    function IndexOf(APivotField: TPivotFieldEh): Integer;
    procedure AddAllPivotFields(DeleteExistend: Boolean);
    procedure Assign(Source: TPersistent); override;
    procedure RebuildPivotFields;

    property PDSource: TPivotDataSourceEh read FPDSource;
    property Items[Index: Integer]: TPivotFieldEh read GetPivotField write SetPivotField; default;
  end;

{ TPivotFieldValueInfoEh }

  TPivotFieldValueInfoEh = class(TCollectionItem)
  private
    FDisplayFormat: String;
    FPivotField: TPivotFieldEh;
    FPivotFieldName: String;
    FSumFunction: TPivotValueTypeEh;

    function GetCollection: TValueFieldsCollectionEh;
    procedure SetDisplayFormat(const Value: String);
    procedure SetPivotField(const Value: TPivotFieldEh);
    procedure SetPivotFieldName(const Value: String);
    procedure SetSumFunction(const Value: TPivotValueTypeEh);

  protected
    function UpdatePivotFieldFromPivotFieldName: TPivotFieldEh;

  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;

    procedure Assign(Source: TPersistent); override;

    property Collection: TValueFieldsCollectionEh read GetCollection;
    property DisplayFormat: String read FDisplayFormat write SetDisplayFormat;
    property PivotField: TPivotFieldEh read FPivotField write SetPivotField;
    property PivotFieldName: String read FPivotFieldName write SetPivotFieldName;
    property SumFunction: TPivotValueTypeEh read FSumFunction write SetSumFunction;
  end;

  TPivotFieldValueInfoEhClass = class of TPivotFieldValueInfoEh;

{ TValuePivotFieldsCollectionEh }

  TCollectionChangeEventEh = procedure(Sender: TCollection;
    Item: TCollectionItem; Action: TCollectionNotification) of object;

  TValueFieldsCollectionEh = class(TCollection)
  private
    FOnChangeNotification: TCollectionChangeEventEh;

    function GetPivotFieldValueInfo(Index: Integer): TPivotFieldValueInfoEh;
    procedure SetPivotFieldValueInfo(Index: Integer; Value: TPivotFieldValueInfoEh);
  protected
    FPivotDataSource: TPivotDataSourceEh;

    procedure Notify(Item: TCollectionItem; Action: TCollectionNotification); override;
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(AClass: TPivotFieldValueInfoEhClass);

    function Add: TPivotFieldValueInfoEh;
    function AddForPivotField(APivotField: TPivotFieldEh; Position: Integer): TPivotFieldValueInfoEh;
    function IndexOf(PivotFieldValueInfo: TPivotFieldValueInfoEh): Integer;
    function IndexByPivotFieldName(PivotFieldName: String): Integer;
    function DataLines: Integer;

    procedure Move(CurIndex, NewIndex: Integer);
    procedure UpdatePivotFieldsFromPivotFieldNames;

    property Items[Index: Integer]: TPivotFieldValueInfoEh read GetPivotFieldValueInfo write SetPivotFieldValueInfo; default;
    property PivotDataSource: TPivotDataSourceEh read FPivotDataSource;

    property OnChangeNotification: TCollectionChangeEventEh read FOnChangeNotification write FOnChangeNotification;
  end;
   
{ TPivotDataSourceEh }

  TLogTimeMetricEventEh = procedure(Sender: TObject; MetricName: String; Duration: LongWord) of object;


  TPivotDataSourceEh = class(TComponent)
  private
    FDataSet: TDataSet;
    FDefaultDateTimeSliceLevels: TDateTimeSliceLevelsEh;
    FInternalDefinitionUpdating: Boolean;
    FNotificationConsumers: TInterfaceList;
    FOnLogTimeMetric: TLogTimeMetricEventEh;
    FPivotFields: TPivotFieldsEh;
    FUpdateCount: Integer;

    procedure CreateSourceTableStruct;
    procedure FillSourceTable;
    procedure SetColumnFields(const Value: TStringList);
    procedure SetPivotFields(const Value: TPivotFieldsEh);
    procedure SetRowFields(const Value: TStringList);
    procedure SetValueFieldsInfo(const Value: TValueFieldsCollectionEh);
    procedure UpdateColRowValueFields;

  protected
    BaseTable: TMemTableEh;
    ColsFieldNames: String;
    ColsTable: TMemTableEh;
    FActualColFlds: TStringList;
    FActualRowFlds: TStringList;
    FActualValueFields: TValueFieldsCollectionEh;
    FColumnFields: TStringList;
    FRowFields: TStringList;
    FSourceTable: TMemTableEh;
    FValueFieldsInfo: TValueFieldsCollectionEh;
    ResultAggrTable: TMemTableEh;
    RowsFieldNames: String;
    RowsTable: TMemTableEh;
    TransResultAggrTable: TMemTableEh;

    procedure AggregateBasePivotData;
    procedure BuildGridData;
    procedure BuildGridDataForBaseTable;
    procedure CreateAndFillBaseTable;
    procedure CreateBaseTableStruct;
    procedure FillBasePivotData;
    procedure FillInverseGaussMatrixForLevel(ColsLevel: Integer);
    procedure LogTimeMetric(MetricName: String; Duration: LongWord);
    procedure MakeColsRowsTables;
    procedure MakeColsTable;
    procedure MakeInverseGaussMatrix;
    procedure MakeResultAggrTable;
    procedure MakeRowsTable;

    procedure ClearSourceData; virtual;
    procedure PivotDataChanged; virtual;
    procedure PivotDataSourceChanged; virtual;
    procedure PivotFieldsChanged; virtual;
    procedure PivotStructureChanged(Sender: TObject);
    procedure SetDataFilter; virtual;
    procedure ValueFieldsInfoChangeEvent(Sender: TCollection; Item: TCollectionItem; Action: TCollectionNotification);

    property ActualColFlds: TStringList read FActualColFlds;
    property ActualRowFlds: TStringList read FActualRowFlds;
    property ActualValueFields: TValueFieldsCollectionEh read FActualValueFields;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function DataIsEmpty: Boolean;

    procedure RegisterChanges(Value: IPivotDataSourceNotificationEh);
    procedure UnRegisterChanges(Value: IPivotDataSourceNotificationEh);
    property SourceTable: TMemTableEh read FSourceTable;

    procedure BuildPivotData;
    procedure CreateAndFillSourceTable;
    procedure LoadAndBuildPivotData;
    procedure PivotDataStructBeginUpdate;
    procedure PivotDataStructEndUpdate;

  published
    property DataSet: TDataSet read FDataSet write FDataSet;
    property PivotFields: TPivotFieldsEh read FPivotFields write SetPivotFields;
    property DefaultDateTimeSliceLevels: TDateTimeSliceLevelsEh read  FDefaultDateTimeSliceLevels write FDefaultDateTimeSliceLevels default [dtslYearEh, dtslMonthEh, dtslDayEh];

    property ColumnFields: TStringList read FColumnFields write SetColumnFields;
    property RowFields: TStringList read FRowFields write SetRowFields;
    property ValueFieldDefs: TValueFieldsCollectionEh read FValueFieldsInfo write SetValueFieldsInfo;

    property OnLogTimeMetric: TLogTimeMetricEventEh read FOnLogTimeMetric write FOnLogTimeMetric;
  end;

{ TPivotAxisTreeNodeEh }

  TPivotTreeNodeIterativeEvent = procedure (Sender: TPivotAxisTreeNodeEh; Param: TObject) of object;
  TPivotAxisDirectionEh = (padVerticalEh, padHorizontalEh);

  TPivotAxisTreeNodeEh = class(TBaseTreeNodeEh)
  private
    FAxisPos: Integer;

    function GetItem(const Index: Integer): TPivotAxisTreeNodeEh;
    function GetParent: TPivotAxisTreeNodeEh;
  public
    constructor Create; override;

    property AxisPos: Integer read FAxisPos;
    property Expanded;
    property Items[const Index: Integer]: TPivotAxisTreeNodeEh read GetItem; default;
    property Level;
    property Parent: TPivotAxisTreeNodeEh read GetParent;
    property Text;
  end;

{ TPivotAxisGroupingTreeEh }

  TPivotAxisGroupingTreeEh = class(TTreeListEh)
  private
    FAxisDir: TPivotAxisDirectionEh;
    FCurIncAxisNum: Integer;
    FExpandedStateIterativeLevel: Integer;
    FFlatList: TList;
    FGrid: TCustomPivotGridEh;
    FRowNums: TIntegerDynArray;
    FSortOrder: TSortOrderEh;
    FUpdateCount: Integer;

    function CompareAxisValues(AxisPos1, AxisPos2, OppositeAxisPos: Integer): TVariantRelationship;
    function ComparePivotAxisPoses(Node1, Node2: TBaseTreeNodeEh; ParamSort: TObject): Integer;
    function GetActualAxisFlds: TStrings;
    function GetAxisAggrBeforeData: Boolean;
    function GetAxisTable: TMemTableEh;
    function GetFlatList(Index: Integer): TPivotAxisTreeNodeEh;
    function GetFlatListCount: Integer;
    function GetRoot: TPivotAxisTreeNodeEh;
    procedure SetExpandedState(Sender: TPivotAxisTreeNodeEh; Param: TObject);
    procedure SetVisArrayGridNum(Sender: TPivotAxisTreeNodeEh; Param: TObject);

  protected
    procedure FlatListAddItem(Sender: TBaseTreeNodeEh; Param: TObject);
    procedure ExpandedChanged(Node: TBaseTreeNodeEh); override;

  public
    constructor Create(AGrid: TCustomPivotGridEh; ItemClass: TTreeNodeClassEh; AAxisDir: TPivotAxisDirectionEh);
    destructor Destroy; override;

    function Updating: Boolean; reintroduce;

    procedure BeginUpdate;
    procedure BuildFlatList;
    procedure BuildTree;
    procedure EndUpdate;
    procedure ForAllNode(AProg: TTreeNodeIterativeEvent; Param: TObject; RowAggrBeforeData: Boolean; ConsideCollapsed: Boolean);
    procedure SetGridArrayAxisNums;
    procedure SetLevelExpanded(ALevel: Integer; IsExpanded: Boolean);
    procedure SetNextColNum(Sender: TPivotAxisTreeNodeEh; Param: TObject);
    procedure SetNextRowNum(Sender: TPivotAxisTreeNodeEh; Param: TObject);
    procedure SetVisArrayGridNums;
    procedure SortData(Level, PivotGridAxisLine: Integer; ASortOrder: TSortOrderEh); reintroduce; virtual;
    procedure WriteTree(sl: TStrings; AxisAggrBeforeData: Boolean);
    procedure WriteTreeLine(Sender: TBaseTreeNodeEh; Param: TObject);

    property ActualAxisFlds: TStrings read GetActualAxisFlds;
    property AxisAggrBeforeData: Boolean read GetAxisAggrBeforeData;
    property AxisDir: TPivotAxisDirectionEh read FAxisDir;
    property AxisTable: TMemTableEh read GetAxisTable;
    property FlatList[Index: Integer]: TPivotAxisTreeNodeEh read GetFlatList;
    property FlatListCount: Integer read GetFlatListCount;
    property Grid: TCustomPivotGridEh read FGrid;
    property Root: TPivotAxisTreeNodeEh read GetRoot;
  end;

  TPivotCellSignTypeEh = (pcstNonEh, pcstRectangleEh, pcstCircleEh);

{ TPivotCellDrawParamsEh }

  TPivotCellDrawParamsEh = class(TPersistent)
  private
    FAreaCol: Longint;
    FAreaRow: Longint;
    FCol: Longint;
    FColsAxisPos: TVariantDynArray;
    FColsGroupLevel: Integer;
    FDisplayValue: String;
    FDrawState: TGridDrawState;
    FFillColor: TColor;
    FFont: TFont;
    FRow: Longint;
    FRowsAxisPos: TVariantDynArray;
    FRowsGroupLevel: Integer;
    FSignFillColor: TColor;
    FSignFrameColor: TColor;
    FSignType: TPivotCellSignTypeEh;
    FValue: Variant;

  public
    property AreaCol: Longint read FAreaCol;
    property AreaRow: Longint read FAreaRow;
    property Col: Longint read FCol;
    property ColsAxisPos: TVariantDynArray read FColsAxisPos;
    property ColsGroupLevel: Integer read FColsGroupLevel;
    property DrawState: TGridDrawState read FDrawState;
    property Row: Longint read FRow;
    property RowsAxisPos: TVariantDynArray read FRowsAxisPos;
    property RowsGroupLevel: Integer read FRowsGroupLevel;
    property Value: Variant read FValue;

    property DisplayValue: String read FDisplayValue write FDisplayValue;
    property FillColor: TColor read FFillColor write FFillColor;
    property Font: TFont read FFont write FFont;
    property SignFillColor: TColor read FSignFillColor write FSignFillColor;
    property SignFrameColor: TColor read FSignFrameColor write FSignFrameColor;
    property SignType: TPivotCellSignTypeEh read FSignType write FSignType;
  end;

{ TPivotGridCellParamsEh }

  TPivotGridCellParamsEh = class(TPersistent)
  private
    FParentFieldNameFont: Boolean;
    FAxisColor: TColor;
    FAxisFont: TFont;
    FDataColor: TColor;
    FDataFont: TFont;
    FParentAxisFont: Boolean;
    FParentAxisAggregateFont: Boolean;
    FDataAggregateColor: TColor;
    FParentDataFont: Boolean;
    FDataAggregateFont: TFont;
    FFieldNameColor: TColor;
    FParentDataAggregateFont: Boolean;
    FFieldNameFont: TFont;
    FGrid: TCustomPivotGridEh;
    FAxisAggregateFont: TFont;
    procedure SetDataAggregateColor(const Value: TColor);
    procedure SetDataAggregateFont(const Value: TFont);
    procedure SetDataColor(const Value: TColor);
    procedure SetDataFont(const Value: TFont);
    procedure SetFieldNameColor(const Value: TColor);
    procedure SetFieldNameFont(const Value: TFont);
    procedure SetAxisColor(const Value: TColor);
    procedure SetAxisFont(const Value: TFont);
    procedure SetParentDataAggregateFont(const Value: Boolean);
    procedure SetParentDataFont(const Value: Boolean);
    procedure SetParentFieldNameFont(const Value: Boolean);
    procedure SetParentAxisFont(const Value: Boolean);

    procedure RefreshDefaultDataAggregateFont;
    procedure RefreshDefaultDataFont;
    procedure RefreshDefaultFieldNameFont;
    procedure RefreshDefaultAxisFont;
    procedure RefreshDefaultAxisAggregateFont;
    procedure AssignDefaultFontTo(const AFont: TFont);
    procedure FontChanged(Sender: TObject);
    procedure SetAxisAggregateFont(const Value: TFont);
    procedure SetParentAxisAggregateFont(const Value: Boolean);
    function IsAxisAggregateFontStored: Boolean;
    function IsAxisFontStored: Boolean;
    function IsDataAggregateFontStored: Boolean;
    function IsDataFontStored: Boolean;
    function IsFieldNameFontStored: Boolean;

  public
    constructor Create(AGrid: TCustomPivotGridEh);
    destructor Destroy; override;

    function DefaultFont: TFont; virtual;
    function ActualDataColor: TColor; virtual;
    function ActualDataAggregateColor: TColor; virtual;
    function ActualAxisColor: TColor; virtual;
    function ActualFieldNameColor: TColor; virtual;
    property Grid: TCustomPivotGridEh read FGrid;

  published
    property DataColor: TColor read FDataColor write SetDataColor default clDefault;
    property DataFont: TFont read FDataFont write SetDataFont stored IsDataFontStored;
    property DataAggregateColor: TColor read FDataAggregateColor write SetDataAggregateColor default clDefault;
    property DataAggregateFont: TFont read FDataAggregateFont write SetDataAggregateFont stored IsDataAggregateFontStored;
    property AxisColor: TColor read FAxisColor write SetAxisColor default clDefault;
    property AxisFont: TFont read FAxisFont write SetAxisFont stored IsAxisFontStored;
    property AxisAggregateFont: TFont read FAxisAggregateFont write SetAxisAggregateFont stored IsAxisAggregateFontStored;
    property FieldNameColor: TColor read FFieldNameColor write SetFieldNameColor default clDefault;
    property FieldNameFont: TFont read FFieldNameFont write SetFieldNameFont stored IsFieldNameFontStored;

    property ParentDataFont: Boolean read FParentDataFont write SetParentDataFont default True;
    property ParentDataAggregateFont: Boolean read FParentDataAggregateFont write SetParentDataAggregateFont default True;
    property ParentAxisFont: Boolean read FParentAxisFont write SetParentAxisFont default True;
    property ParentAxisAggregateFont: Boolean read FParentAxisAggregateFont write SetParentAxisAggregateFont default True;
    property ParentFieldNameFont: Boolean read FParentFieldNameFont write SetParentFieldNameFont default True;
  end;


{ TPivotGridLineParamsEh }

  TPivotGridLineParamsEh = class(TGridLineColorsEh)
  published
    property DarkColor;
    property BrightColor;
  end;

{ TCustomPivotGridEh }

  TPivotGridOptionEh = (pgoRowSizingEh, pgoColSizingEh, pgoEditingEh, pgoWantTabEh,
    pgoFieldDraggingEh);
  TPivotGridOptionsEh = set of TPivotGridOptionEh;

  TSpicGridStateEh = (dgsNormal, dgsFilterButtonDown);
  TDropToPosTypeEh = (dtptFieldColsEh, dtptFieldRowsEh);
  TCellAreaEh = (caUnspecifiedEh, caDropDownButtonEh, caSortMarkerEh, caCellBorderEh, caTreeExpandSignEh);

  TCurrentCellMovedEvent = procedure(Grid: TCustomPivotGridEh; OldCurrent: TGridCoord) of object;
  TGetPivotDataCellDrawParamsEventEh = procedure(Grid: TCustomPivotGridEh;
    ACol, ARow: Integer; var Params: TPivotCellDrawParamsEh;
    var Processed: Boolean) of object;

  TCustomPivotGridEh = class(TCustomGridEh, IPivotDataSourceNotificationEh)
  private
    FColsAxisTree: TPivotAxisGroupingTreeEh;
    FDefaultDateTimeSliceLevels: TDateTimeSliceLevelsEh;
    FDragStarted: Boolean;
    FDrawCellParams: TPivotCellDrawParamsEh;
    FOnCurrentCellMoved: TCurrentCellMovedEvent;
    FOnDrawDataCell: TGetPivotDataCellDrawParamsEventEh;
    FOnGridDefinitionChanged: TNotifyEvent;
    FPivotDataSource: TPivotDataSourceEh;
    FRowAggrBeforeData: Boolean;
    FRowsAxisTree: TPivotAxisGroupingTreeEh;
    FOptions: TPivotGridOptionsEh;
    FRowLines: Integer;
    FRowHeight: Integer;
    FGridCellParams: TPivotGridCellParamsEh;

    function CalcDefaultRowHeight: Integer;
    function GetActualColFlds: TStringList;
    function GetActualRowFlds: TStringList;
    function GetActualValueFields: TValueFieldsCollectionEh;
    function GetDefaultColWidth: Integer;
    function GetGridLineParams: TPivotGridLineParamsEh;
    function GetOptions: TPivotGridOptionsEh;
    function GetPivotRowSortedGridArray(ACol, ARow: Integer): TPivotCellEh;
    function GetSourcePivotFields: TPivotFieldsEh;
    function GetValueForInheritedOptions: TGridOptionsEh;
    function GetVisPivotGridArray(ACol, ARow: Integer): TPivotCellEh;

    procedure AdjustContraData;
    procedure DrawAxisValueCellData(ACol, ARow: Integer; ARect: TRect; AState: TGridDrawState; PivotCel: TPivotCellEh; ShowGroupingSign, ShowValue: Boolean);
    procedure DrawSortMarker(var ARect: TRect; AState: TGridDrawState; SortOrder: TSortOrderEh);
    procedure GetTopGroupRowCells(var Cells: TPivotRectCellDynArrayEh);
    procedure PivotDataSourceChanged;
    procedure SetDefaultColWidth(const Value: Integer);
    procedure SetGridLineParams(const Value: TPivotGridLineParamsEh);
    procedure SetOptions(const Value: TPivotGridOptionsEh);
    procedure SetPivotDataSource(const Value: TPivotDataSourceEh);
    procedure SetRowHeight(const Value: Integer);
    procedure SetRowLines(const Value: Integer);
    procedure StartDrag;
    function GetGridCellParams: TPivotGridCellParamsEh;
    procedure SetGridCellParams(const Value: TPivotGridCellParamsEh);

  protected
    DummyPivotField: TPivotFieldEh;
    FVisPivotGridArray: TPivotGridArray;
    PivotGridArray: TPivotGridArray;
    FDrawenCellArr: array of TGridCoord;

    {$IFDEF FPC}
    {$ELSE}
    procedure CMCancelMode(var Message: TCMCancelMode); message CM_CancelMode;
    {$ENDIF}
    procedure CMHintShow(var Message: TCMHintShow); message CM_HINTSHOW;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;

    procedure WMCancelMode(var Message: TWMCancelMode); message WM_CANCELMODE;
    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBKGND;
    procedure WMHScroll(var Message: TWMHScroll); message WM_HSCROLL;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KillFocus;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMVScroll(var Message: TWMVScroll); message WM_VSCROLL;

  protected
    FDataSortColNum: Integer;
    FDataSortSortOrder: TSortOrderEh;
    FDragCell: TPivotCellEh;
    FDragPos: Integer;
    FDropToCell: TPivotCellEh;
    FDropToPos: Integer;
    FHotTrackEditButton: Integer;
    FInTitleFilterListbox: TPopupListboxEh;
    FInTitleFilterListboxVisible: Boolean;
    FInTitleFilterPivotField: TPivotFieldEh;
    FPivotArrayDataColCount: Integer;
    FPivotArrayDataRowCount: Integer;
    FRowsCaptionExpandedState: TBooleanDynArray;
    FShowGrandTotalCols, FShowGrandTotalRows: Boolean;
    FSpicGridState: TSpicGridStateEh;
    FStartDataCol, FStartDataRow: Integer;
    FTrackingStateRect: TRect;
    FValsCapDeltaRow: Integer; 
    FVisPivotColCount: Integer;
    FVisPivotRowCount: Integer;

    function CanHotTackCell(X, Y: Integer): Boolean; override;
    function CreateHorzScrollBarPanelControl: TGridScrollBarPanelControlEh; override;
    function CreateScrollBar(AKind: TScrollBarKind): TGridScrollBarEh; override;
    function FullRedrawOnSroll: Boolean; override;
    function GetEditText(ACol, ARow: Longint): string; override;
    function IsSmoothHorzScroll: Boolean; override;
    function IsSmoothVertScroll: Boolean; override;
    function NeedBufferedPaint: Boolean; override;
    function WMCheckCanSendDoubleClicks(var MouseEvent: TWMMouse): Boolean; override;
    function CreateGridLineColors: TGridLineColorsEh; override;
    function FixedColsSizingAllowed: Boolean; override;

    function CanMouseTrackMode: Boolean;
    function GetInTitleFilterForm: TFilterDropDownForm; virtual;
    function GetInTitleFilterListbox: TPopupListboxEh; virtual;
    function GetMouseHitCellState(Cell: TGridCoord; MousePos: TPoint; CellRect: TRect; var StateRect: TRect): TSpicGridStateEh;
    function GridTextIsVisible: Boolean;

    function GrandTotalColVisible: Boolean;
    function GrandTotalRowVisible: Boolean;

    function DragDropHitTestInfo(X, Y: Integer; var LinePos: TPoint; var LineSize: Integer; var DropToPos: Integer; var FDragToField: TPivotCellEh): Boolean;
    function GetCellHitArea(PivotCel: TPivotCellEh; const ACellRect: TRect; CellMousePos: TPoint): TCellAreaEh;
    function CreateGridCellParams: TPivotGridCellParamsEh; virtual;
    function CheckCellAreaDrawn(ACol, ARow: Integer): Boolean; virtual;

    procedure DoStartDrag(var DragObject: TDragObject); override;
    procedure DragOver(Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean); override;
    procedure DoEndDrag(Target: TObject; X, Y: Integer); override;
    procedure DrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState); override;
    procedure Paint; override;
    procedure SelectionChanged(const OldSel: TGridRect); override;
    procedure CellMouseClick(const Cell: TGridCoord; Button: TMouseButton; Shift: TShiftState; const ACellRect: TRect; const GridMousePos, CellMousePos: TPoint); override;
    procedure CellMouseDown(const Cell: TGridCoord; Button: TMouseButton; Shift: TShiftState; const ACellRect: TRect; const GridMousePos, CellMousePos: TPoint); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure CheckDrawCellBorder(ACol, ARow: Integer; BorderType: TGridCellBorderTypeEh; var IsDraw: Boolean; var BorderColor: TColor; var IsExtent: Boolean); override;
    procedure CurrentCellMoved(OldCurrent: TGridCoord); override;
    procedure CreateWnd; override;

    procedure ColExpandedChanged(Node: TPivotAxisTreeNodeEh);
    procedure DrawAxisValueCell(ACol, ARow: Integer; ARect: TRect; AState: TGridDrawState; PivotCel: TPivotCellEh); virtual;
    procedure DrawCellSign(ACol, ARow: Integer; var ARect: TRect; FDrawCellParams: TPivotCellDrawParamsEh);
    procedure DrawDataCell(ACol, ARow: Integer; ARect: TRect; AState: TGridDrawState; PivotCel: TPivotCellEh); virtual;
    procedure DrawFieldNameCell(ACol, ARow: Integer; ARect: TRect; AState: TGridDrawState; PivotCel: TPivotCellEh); virtual;
    procedure DrawFilterButton(var ARect: TRect; AState: TGridDrawState); virtual;
    procedure DrawTopGroupRowValues; virtual;
    procedure RowExpandedChanged(Node: TPivotAxisTreeNodeEh); virtual;
    procedure SetAxisRowExpandedState(PivotCel: TPivotCellEh; Expanded: Boolean); virtual;
    procedure DoCopyAction; virtual;

    procedure FillDrawCellParams(ADrawCellParams: TPivotCellDrawParamsEh; ACol, ARow: Integer; ARect: TRect; AState: TGridDrawState; PivotCel: TPivotCellEh); virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Resize; override;

    function CheckTopGroupRowMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; virtual;

    procedure FilterFormCloseUp(Accept: Boolean); virtual;
    procedure FilterFormDropDown(Cell: TGridCoord; const CellRect, ButtonRect: TRect);
    procedure FilterListboxCloseUp(Accept: Boolean); virtual;
    procedure FilterListboxDropDown(Cell: TGridCoord; const CellRect, ButtonRect: TRect);
    procedure GetFilterButtonRect(const ACellRect: TRect; var AButtonRect, AGrossRect: TRect; ARightToLeftAlignment: Boolean);
    procedure GetVisPivotGridArrayPosByAxisCell(PivotCel: TPivotCellEh; var VisCellCoord: TPoint);
    procedure GetVisPivotGridArrayPosByAxisTreeNode(RowsTreeNode: TPivotAxisTreeNodeEh; var VisCellCoord: TPoint);
    procedure InTitleFilterDropDownFormCallbackProc(DropDownForm: TCustomForm; Accept: Boolean; DynParams: TDynVarsEh; SysParams: TDropDownFormSysParams);
    procedure InTitleFilterListKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure InTitleFilterListKeyPress(Sender: TObject; var Key: Char);
    procedure InTitleFilterListMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure PaintEmptyDataInfo; virtual;
    procedure PaintInplaceButton(Canvas: TCanvas; ButtonStyle: TEditButtonStyleEh; Rect, ClipRect: TRect; DownButton: Integer; Active, Flat, Enabled: Boolean; ParentColor: TColor; Bitmap: TBitmap; TransparencyPercent: Byte; imList: TCustomImageList; ImageIndex: Integer);
    procedure GridCellParamsChanged; virtual;
    procedure SetCellDrawn(ACol, ARow: Integer); virtual;
    procedure MergeRectForCell(ACol, ARow: Integer; var ARect: TRect; AState: TGridDrawState; PivotCel: TPivotCellEh); virtual;

    procedure SetPivotGridArrayVars;
    procedure BuildGridArrayColsMeasures;
    procedure BuildGridArrayRowsMeasures;
    procedure BuildGridArrayValuesMeasures;

    procedure PivotDataSourceChange(Sender: TObject);
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    property PivotRowSortedGridArray[ACol, ARow: Integer]: TPivotCellEh read GetPivotRowSortedGridArray;

  protected
    { IPivotDataSourceNotificationEh }
    procedure PivotFieldsChanged(Sender: TObject);
    procedure PivotStructureChanged(Sender: TObject);
    procedure PivotDataChanged(Sender: TObject);

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function DataSourceIsEmpty: Boolean; virtual;
    function GrandTotalColCount: Integer;
    function GrandTotalRowCount: Integer;
    function GridIsEmpty: Boolean;

    procedure AggregateGridForColumns;
    procedure AggregateGridForColumnsLevel(ColsLevel: Integer);
    procedure DragDrop(Source: TObject; X, Y: Integer); override;
    procedure EmptyGridData;
    procedure FillGridDataForActualRowFlds;
    procedure FinishDragFrom(Source: TObject); virtual;
    procedure GetValueFieldsInfoFromCommaText(ACommaText: String);
    procedure MakeColSortingTree;
    procedure MakePivotGridArray;
    procedure MakeRowSortingTree;
    procedure MakeVisPivotGridArray;
    procedure MoveAggrRowBeforeData;
    procedure RebuildGrid;
    procedure ResortColSortingTree;
    procedure ResortRowSortingTree;
    procedure SetColLevelExpanded(AColLevel: Integer; IsExpanded: Boolean; const KeyValues: TVariantDynArray);
    procedure SetGridSizes(GridSizeChanged: Boolean);
    procedure SetPivotGridArraySize(AColCount, ARowCount: Integer);
    procedure SetRowHeightsColumnWidths;
    procedure SetRowLevelExpanded(ARowLevel: Integer; IsExpanded: Boolean; const KeyValues: TVariantDynArray);
    procedure VisPivotPosToSrcArrayPos(AVisCol, AVisRow: Integer; var ASrcCol, ASrcRow: Integer);

    property ActualColFlds: TStringList read GetActualColFlds;
    property ActualRowFlds: TStringList read GetActualRowFlds;
    property ActualValueFields: TValueFieldsCollectionEh read GetActualValueFields;
    property Col;
    property ColsAxisTree: TPivotAxisGroupingTreeEh read FColsAxisTree;
    property DefaultDateTimeSliceLevels: TDateTimeSliceLevelsEh read  FDefaultDateTimeSliceLevels write FDefaultDateTimeSliceLevels default [dtslYearEh, dtslMonthEh, dtslDayEh];
    property PivotDataSource: TPivotDataSourceEh read FPivotDataSource write SetPivotDataSource;
    property PivotFields: TPivotFieldsEh read GetSourcePivotFields;
    property Row;
    property RowAggrBeforeData: Boolean read FRowAggrBeforeData write FRowAggrBeforeData;
    property RowsAxisTree: TPivotAxisGroupingTreeEh read FRowsAxisTree;
    property VisPivotGridArray[ACol, ARow: Integer]: TPivotCellEh read GetVisPivotGridArray;
    property GridLineParams: TPivotGridLineParamsEh read GetGridLineParams write SetGridLineParams;
    property GridCellParams: TPivotGridCellParamsEh read GetGridCellParams write SetGridCellParams;
    property Options: TPivotGridOptionsEh read GetOptions write SetOptions default [pgoColSizingEh, pgoEditingEh, pgoWantTabEh, pgoFieldDraggingEh];
    property RowHeight: Integer read FRowHeight write SetRowHeight default 0;
    property RowLines: Integer read FRowLines write SetRowLines default 0;
    property DefaultColWidth: Integer read GetDefaultColWidth write SetDefaultColWidth default 80;

    property OnCellMouseClick;
    property OnCellMouseDown;
    property OnCurrentCellMoved: TCurrentCellMovedEvent read FOnCurrentCellMoved write FOnCurrentCellMoved;
    property OnDrawDataCell: TGetPivotDataCellDrawParamsEventEh read FOnDrawDataCell write FOnDrawDataCell;
    property OnGridDefinitionChanged: TNotifyEvent read FOnGridDefinitionChanged write FOnGridDefinitionChanged;
  end;

{ TPivotGridEh }

  TPivotGridEh = class(TCustomPivotGridEh)
  public
    property Canvas;
    property Col;
//    property DefaultRowHeight;
    property Row;
    property RowCount;

  published
    property PivotDataSource;
    property GridLineParams;
    property GridCellParams;
    property RowHeight;
    property RowLines;
    property DefaultColWidth;
    property Options;

    property OnDrawDataCell;

    property Align;
    property Anchors;
    property BiDiMode;
    property BorderStyle;
    property Color;
    property Constraints;
    property ContraColCount;
    {$IFDEF FPC}
    {$ELSE}
    property Ctl3D;
    {$ENDIF}
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property FixedColor;
    property Flat;
    property Font;
    property HorzScrollBar;
    {$IFDEF FPC}
    {$ELSE}
    property ImeMode;
    property ImeName;
    {$ENDIF}
    property ParentBiDiMode;
    {$IFDEF FPC}
    {$ELSE}
    property ParentCtl3D;
    {$ENDIF}
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property SelectionDrawParams;
    property ShowHint;
    property TabOrder;
    property TabStop;
{$IFDEF EH_LIB_13}
    property Touch;
{$ENDIF}
    property VertScrollBar;
    property Visible;

{$IFDEF EH_LIB_5}
    property OnContextPopup;
{$ENDIF}
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
{$IFDEF EH_LIB_13}
    property OnGesture;
{$ENDIF}
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

{ TPivotGridFilterPopupListboxItemEh }

  TPivotGridFilterPopupListboxItemEh = class(TPopupListboxItemEh)
  protected
    function GetPivotField(Listbox: TCustomListboxEh): TPivotFieldEh;
    function GetGrid(Listbox: TCustomListboxEh): TCustomPivotGridEh;
  end;

{ TPopupListboxItemEhData }

  TPopupListboxItemEhData = class(TPivotGridFilterPopupListboxItemEh)
  protected
    function CanFocus(Sender: TCustomListboxEh; ItemIndex: Integer): Boolean; override;
    procedure DrawItem(Sender: TCustomListboxEh; ItemIndex: Integer; ARect: TRect; State: TGridDrawState); override;
    procedure KeyPress(Sender: TCustomListboxEh; ItemIndex: Integer; var Key: Char; Shift: TShiftState; var IsCloseListbox: Boolean); override;
    procedure MouseDown(Sender: TCustomListboxEh; ItemIndex: Integer; InItemPos: TPoint; Button: TMouseButton; Shift: TShiftState); override;
    procedure MouseMove(Sender: TCustomListboxEh; ItemIndex: Integer; InItemPos: TPoint; Shift: TShiftState); override;
    procedure MouseUp(Sender: TCustomListboxEh; ItemIndex: Integer; InItemPos: TPoint; Button: TMouseButton; Shift: TShiftState; var IsCloseListbox: Boolean); override;

  public
    function CloseOnExecute(Sender: TCustomListboxEh; ItemIndex: Integer): Boolean; override;
    procedure Execute(Sender: TCustomListboxEh; ItemIndex: Integer; InItemPos: TPoint; Shift: TShiftState); override;
  end;

  TPopupListboxItemEhSpecType = (ptFilterSpecSelectAll, ptFilterApply, ptFilterRowLine);

{ TPopupListboxItemEhSpec }

  TPopupListboxItemEhSpec = class(TPivotGridFilterPopupListboxItemEh)
  protected
    FType: TPopupListboxItemEhSpecType;

    function CanFocus(Sender: TCustomListboxEh; ItemIndex: Integer): Boolean; override;
    procedure DrawItem(Sender: TCustomListboxEh; ItemIndex: Integer; ARect: TRect; State: TGridDrawState); override;
    procedure MouseDown(Sender: TCustomListboxEh; ItemIndex: Integer; InItemPos: TPoint; Button: TMouseButton; Shift: TShiftState); override;
    procedure MouseUp(Sender: TCustomListboxEh; ItemIndex: Integer; InItemPos: TPoint; Button: TMouseButton; Shift: TShiftState; var IsCloseListbox: Boolean); override;

  public
    constructor Create(AType: TPopupListboxItemEhSpecType);
    procedure Execute(Sender: TCustomListboxEh; ItemIndex: Integer; InItemPos: TPoint; Shift: TShiftState); override;
  end;

  TPivotGridDrabObj = class(TDragControlObjectEx)
  protected
    function GetDragCursor(Accepted: Boolean; X, Y: Integer): TCursor; override;
  public
    FDragCell: TPivotCellEh;
    FPivotField: TPivotFieldEh;
    FPivotFieldName: String;
    FPivotFieldValueInfo: TPivotFieldValueInfoEh;

    destructor Destroy; override;
  end;

{ TPivotGridSelectionInfoPanel }

  TPivotGridSelectionInfoPanel = class (TCustomControl)
  private
    function GetGrid: TCustomPivotGridEh;
    function InfoWidth: Integer;

  protected
    FAggrText: String;
    procedure GridSelectionChanged;
    procedure Paint; override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function HaveData: Boolean;
    property Grid: TCustomPivotGridEh read GetGrid;
  end;

  { TPivotGridScrollBarPanelControl }

  TPivotGridScrollBarPanelControl = class(TGridScrollBarPanelControlEh)
  private
    FSelInfoPanel: TPivotGridSelectionInfoPanel;

  protected
    procedure Resize; override;
    procedure CreateHandle; override;

  public
    constructor Create(AOwner: TComponent; AKind: TScrollBarKind); reintroduce;
    destructor Destroy; override;
    procedure GridSelectionChanged;
  end;

{ TPivotGridScrollBarEh }

  TPivotGridScrollBarEh = class(TGridScrollBarEh)
  protected
    function CheckScrollBarMustBeShown: Boolean; override;
  end;

  TPivotGridExportAsOLEXLSOptionEh = (pgxlsColoredEh, pgxlsDataAsEditText);
  TPivotGridExportAsOLEXLSOptionsEh = set of TPivotGridExportAsOLEXLSOptionEh;

procedure StartWait;
procedure StopWait;

function ExportPivotGridEhToOleExcel(Grid: TCustomPivotGridEh;
  Options: TPivotGridExportAsOLEXLSOptionsEh
//  ;const FileName: String = ''
  ): Variant;

var
  hcrDropToGarbageEh: HCursor = 0;
  hcrDropToGarbageIndexEh: TCursor;

const
  SliceNames: array[TFieldDateTimeSliceLevelEh] of String =
    ('Non', 'Year', 'Quarter', 'Month', 'Week',
     'Day', 'Hour', 'Min', 'Sec', 'MSec');

  SliceNamesDisplaFormat: array[TFieldDateTimeSliceLevelEh] of String =
    ('', 'YYYY', 'YYYY/MM', 'YYYY/MM', 'YYYY/WW',
     'YYYY/MM/DD', 'YYYY/MM/DD HH', 'YYYY/MM/DD HH:NN', 'YYYY/MM/DD HH:NN:SS', '');

  PivotAggrValueTypes: array[TPivotValueTypeEh] of String = ('Non', 'Sum',
    'Count', 'Avarge', 'Max', 'Min', 'Count Distinct', 'Custom');

implementation

uses Math,
     ComObj,
     StrUtils, ClipBrd,
     EhLibConsts, PivotGridToolsEh;

//{$R SpinGridsEh.Res}

var
  InplaceBitmap: TBitmap;
  PopupListboxItemEhData: TPopupListboxItemEhData;
  PopupListboxItemEhApplyFilter: TPopupListboxItemEhSpec;
  PopupListboxItemEhSelectAll: TPopupListboxItemEhSpec;
  PopupListboxItemEhRowLine: TPopupListboxItemEhSpec;

var
  WaitCount: Integer = 0;
  SaveCursor: TCursor = crDefault;

const
  WaitCursor: TCursor = crHourGlass;

{
procedure SaveToStrFile(const FileName: string; Str: String);
var
  Stream: TStream;
  Buffer: TBytes;
begin
  Stream := TFileStream.Create(FileName, fmCreate);
  try
   Buffer := TEncoding.UTF8.GetBytes(Str);
   Stream.WriteBuffer(Buffer, Length(Buffer));
  finally
    Stream.Free;
  end;
end;
}

function GetCanvasFontOneLineHeight(AControl: TWinControl; ACanvas: TCanvas; AFont: TFont): Integer;
var
  tm: Windows.TTEXTMETRIC;
  RestoreCanvas: Boolean;
begin
  RestoreCanvas := not AControl.HandleAllocated;
  if RestoreCanvas then
    ACanvas.Handle := GetDC(0);
  try
    ACanvas.Font := AFont;
    GetTextMetrics(ACanvas.Handle, tm);
    Result := tm.tmExternalLeading + tm.tmHeight;
  finally
    if RestoreCanvas then
    begin
      ReleaseDC(0, ACanvas.Handle);
      ACanvas.Handle := 0;
    end;
  end;
end;

function VarToDoubleDef(const Val: Variant; const ADefault: Double): Double;
begin
  if VarIsEmpty(Val) or VarIsNull(Val) then
    Result := ADefault
  else
    Result := Val;
end;

procedure StartWait;
begin
  if WaitCount = 0 then
  begin
    SaveCursor := Screen.Cursor;
    Screen.Cursor := WaitCursor;
  end;
  Inc(WaitCount);
end;

procedure StopWait;
begin
  if WaitCount > 0 then
  begin
    Dec(WaitCount);
    if WaitCount = 0 then
      Screen.Cursor := SaveCursor;
  end;
end;

procedure InitPivotGridEh;
var
  i: Integer;
begin
  PopupListboxItemEhData := TPopupListboxItemEhData.Create;
  PopupListboxItemEhApplyFilter := TPopupListboxItemEhSpec.Create(ptFilterApply);
  PopupListboxItemEhSelectAll := TPopupListboxItemEhSpec.Create(ptFilterSpecSelectAll);
  PopupListboxItemEhRowLine := TPopupListboxItemEhSpec.Create(ptFilterRowLine);

  hcrDropToGarbageEh := LoadCursor(hInstance, 'DROPTOGARBAGEEH');
  if hcrDropToGarbageEh = 0 then
    raise EOutOfResources.Create('Cannot load cursor resource');

  for i := 1 to MaxInt do
  {$IFDEF FPC}
  if Screen.Cursors[i] = 0 then
  {$ELSE}
  if Screen.Cursors[i] = Screen.Cursors[0] then
  {$ENDIF}
    begin
      Screen.Cursors[i] := hcrDropToGarbageEh;
      hcrDropToGarbageIndexEh := i;
      Exit;
    end;
end;

procedure FinalyPivotGridEh;
begin
  FreeAndNil(PopupListboxItemEhData);
  FreeAndNil(PopupListboxItemEhApplyFilter);
  FreeAndNil(PopupListboxItemEhSelectAll);
  FreeAndNil(PopupListboxItemEhRowLine);

  FreeAndNil(InplaceBitmap);
  DestroyCursor(hcrDropToGarbageEh);
end;

function GetInplaceBitmap(Width, Height: Integer): TBitmap;
begin
  if InplaceBitmap = nil then
    InplaceBitmap := TBitmap.Create;
  if InplaceBitmap.Width < Width then
    InplaceBitmap.Width := Width;
  if InplaceBitmap.Height < Height then
    InplaceBitmap.Height := Height;
  Result := InplaceBitmap;
end;

function VarArrayEqualLevelForDepth(const V1, V2: TVariantDynArray; Depth: Integer): Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to Length(V1)-1 do
  begin
    Result := i+1;
    if i = Depth then
    begin
      Result := i;
      Break
    end else if not VarSameValue(V1[i], V2[i]) then
    begin
      Result := i;
      Break;
    end;
  end
end;

function VarArrayEqual(const V1, V2: TVariantDynArray): Boolean;
begin
  Result := (VarArrayEqualLevelForDepth(V1, V2, Length(V1)) = Length(V1));
end;

function VarEquals(const V1, V2: TVariantDynArray): Boolean;
var
  i: Integer;
  Val1, Val2: Variant;
begin
  Result := False;
  try
    for i := 0 to Length(V1)-1 do
    begin
      Val1 := V1[i];
      Val2 := V2[i];
      Result := Val1 = Val2;
      if not Result then Exit;
    end
  except
  end;
end;

{ TCustomPivotGridEh }

constructor TCustomPivotGridEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  HorzScrollBar.SmoothStep := True;
  VertScrollBar.SmoothStep := True;

  FOptions := [pgoColSizingEh, pgoEditingEh, pgoWantTabEh, pgoFieldDraggingEh];
  inherited Options := GetValueForInheritedOptions;

  FDefaultDateTimeSliceLevels := [dtslYearEh, dtslMonthEh, dtslDayEh];

  DummyPivotField := TPivotFieldEh.Create(nil);

  EmptyGridData;
  DefaultColWidth := 80;

  FRowsAxisTree := TPivotAxisGroupingTreeEh.Create(Self, TPivotAxisTreeNodeEh, padVerticalEh);
  FColsAxisTree := TPivotAxisGroupingTreeEh.Create(Self, TPivotAxisTreeNodeEh, padHorizontalEh);
  FDrawCellParams := TPivotCellDrawParamsEh.Create;
  FGridCellParams := CreateGridCellParams;
end;

destructor TCustomPivotGridEh.Destroy;
begin
  Destroying;
  PivotDataSource := nil;

  FreeAndNil(DummyPivotField);
  FreeAndNil(FRowsAxisTree);
  FreeAndNil(FColsAxisTree);
  FreeAndNil(FDrawCellParams);
  FreeAndNil(FGridCellParams);

  SetPivotGridArraySize(0, 0);

  inherited Destroy;
end;

procedure TCustomPivotGridEh.CreateWnd;
begin
  inherited CreateWnd;
  SetRowHeightsColumnWidths;
end;

function TCustomPivotGridEh.CreateHorzScrollBarPanelControl: TGridScrollBarPanelControlEh;
begin
  Result := TPivotGridScrollBarPanelControl.Create(Self, sbHorizontal);
end;

function TCustomPivotGridEh.CreateScrollBar(AKind: TScrollBarKind): TGridScrollBarEh;
begin
  if AKind = sbVertical
    then Result := inherited CreateScrollBar(AKind)
    else Result := TPivotGridScrollBarEh.Create(Self, AKind);
end;

procedure TCustomPivotGridEh.SetPivotDataSource(const Value: TPivotDataSourceEh);
begin
  if FPivotDataSource <> Value then
  begin
    if Assigned(FPivotDataSource) then
      FPivotDataSource.UnRegisterChanges(Self);
    FPivotDataSource := Value;
    if Assigned(FPivotDataSource) then
    begin
      FPivotDataSource.RegisterChanges(Self);
      FPivotDataSource.FreeNotification(Self);
    end;
    PivotDataSourceChanged;
  end;
end;

procedure TCustomPivotGridEh.PivotDataSourceChange(Sender: TObject);
begin
  PivotDataSourceChanged;
end;

procedure TCustomPivotGridEh.PivotFieldsChanged(Sender: TObject);
begin
  EmptyGridData;
  if Assigned(FOnGridDefinitionChanged) then
    FOnGridDefinitionChanged(Self);
end;

procedure TCustomPivotGridEh.PivotStructureChanged(Sender: TObject);
begin
  if Assigned(FOnGridDefinitionChanged) then
    FOnGridDefinitionChanged(Self);
end;

procedure TCustomPivotGridEh.PivotDataChanged(Sender: TObject);
begin
  if DataSourceIsEmpty {or FGridIsEmptyStatus} then
    EmptyGridData
  else
    RebuildGrid;
end;

procedure TCustomPivotGridEh.PivotDataSourceChanged;
begin
//  PivotFieldsChanged(nil);
end;

procedure TCustomPivotGridEh.SetPivotGridArraySize(AColCount, ARowCount: Integer);
var
  c,r: Integer;
  OldCC, OldRC: Integer;
begin
  if (Length(PivotGridArray) > 0) then
  begin
    OldRC := Length(PivotGridArray[0]);
    OldCC  := Length(PivotGridArray);
    if ARowCount > OldRC then
    begin
      for c := 0 to OldCC-1 do
      begin
        SetLength(PivotGridArray[c], ARowCount);
        SetLength(FVisPivotGridArray[c], ARowCount);
        for r := OldRC to ARowCount-1 do
          PivotGridArray[c, r] := TPivotCellEh.Create;
      end;
    end else if ARowCount < OldRC then
    begin
      for c := 0 to OldCC-1 do
      begin
        for r := ARowCount to OldRC-1 do
        begin
          PivotGridArray[c, r].Free;
          PivotGridArray[c, r] := nil;
        end;
        SetLength(PivotGridArray[c], ARowCount);
        SetLength(FVisPivotGridArray[c], ARowCount);
      end;
    end;
  end;

  if AColCount > Length(PivotGridArray) then
  begin
    OldCC  := Length(PivotGridArray);
    SetLength(PivotGridArray, AColCount);
    SetLength(FVisPivotGridArray, AColCount);
    for c := OldCC to AColCount-1 do
    begin
      SetLength(PivotGridArray[c], ARowCount);
      SetLength(FVisPivotGridArray[c], ARowCount);
      for r := 0 to ARowCount-1 do
        PivotGridArray[c, r] := TPivotCellEh.Create;
    end;
  end else if AColCount < Length(PivotGridArray) then
  begin
    OldCC  := Length(PivotGridArray);
    for c := AColCount to OldCC-1 do
    begin
      for r := 0 to ARowCount-1 do
      begin
        PivotGridArray[c, r].Free;
        PivotGridArray[c, r] := nil;
      end;
    end;
    SetLength(PivotGridArray, AColCount);
    SetLength(FVisPivotGridArray, AColCount);
  end;

  for c := 0 to AColCount-1 do
  begin
    for r := 0 to ARowCount-1 do
      PivotGridArray[c, r].Clear;
  end;
end;

procedure TCustomPivotGridEh.SetRowHeightsColumnWidths;
var
  i: Integer;
begin
  if csLoading in ComponentState then Exit;

  if (RowHeight = 0) and (RowLines = 0) then
    DefaultRowHeight := CalcDefaultRowHeight
  else
    DefaultRowHeight := GetCanvasFontOneLineHeight(Self, Canvas, Font) * RowLines + RowHeight;
  for i := 0 to FullRowCount-1 do
    RowHeights[i] := DefaultRowHeight;

  for i := 0 to FullColCount-1 do
    ColWidths[i] := DefaultColWidth;
  SetGridSizes(True);
  AdjustContraData;
end;

function TCustomPivotGridEh.CalcDefaultRowHeight: Integer;
begin
  Result := GetCanvasFontOneLineHeight(Self, Canvas, Font) + 4;
end;

procedure TCustomPivotGridEh.RebuildGrid;
var
  ticks: LongWord;
begin
  ticks := GetTickCount;
  
  EmptyGridData;
  MakePivotGridArray;
  AggregateGridForColumns;
  if RowAggrBeforeData then
    MoveAggrRowBeforeData;
  MakeRowSortingTree;
  MakeColSortingTree;
  MakeVisPivotGridArray;
  SetRowHeightsColumnWidths;
  InvalidateGrid;

  PivotDataSource.LogTimeMetric(' RebuildGrid', GetTickCount-ticks);
end;

procedure TCustomPivotGridEh.MakeRowSortingTree;
begin
  RowsAxisTree.BuildTree;
  RowsAxisTree.SetGridArrayAxisNums;
  ResortRowSortingTree;
end;

procedure TCustomPivotGridEh.MakeColSortingTree;
begin
  ColsAxisTree.BuildTree;
  ColsAxisTree.SetGridArrayAxisNums;
  ResortColSortingTree;
end;

procedure TCustomPivotGridEh.ResortRowSortingTree;
var
  i: Integer;
begin
  if FDataSortColNum >= 0 then
    RowsAxisTree.SortData(-1, FDataSortColNum, FDataSortSortOrder)
  else if ActualRowFlds.Objects[0] <> nil then
    for i := 0 to ActualRowFlds.Count-1 do
      RowsAxisTree.SortData(i+1, i, TPivotFieldEh(ActualRowFlds.Objects[i]).SortOrder);
  RowsAxisTree.SetVisArrayGridNums;
  RowsAxisTree.BuildFlatList;
end;

procedure TCustomPivotGridEh.ResortColSortingTree;
begin
  ColsAxisTree.BuildFlatList;
end;

procedure TCustomPivotGridEh.RowExpandedChanged(Node: TPivotAxisTreeNodeEh);
begin
  RowsAxisTree.SetVisArrayGridNums;
  RowsAxisTree.BuildFlatList;
  MakeVisPivotGridArray;
  SetRowHeightsColumnWidths;
  InvalidateGrid;
end;

procedure TCustomPivotGridEh.ColExpandedChanged(Node: TPivotAxisTreeNodeEh);
begin
  ColsAxisTree.SetVisArrayGridNums;
  ColsAxisTree.BuildFlatList;
  MakeVisPivotGridArray;
  SetRowHeightsColumnWidths;
  InvalidateGrid;
end;

procedure TCustomPivotGridEh.SetPivotGridArrayVars;
begin
  if ActualValueFields.Count > 1
    then FValsCapDeltaRow := 1
    else FValsCapDeltaRow := 0;

  FStartDataCol := ActualRowFlds.Count;
  FStartDataRow := 1 + ActualColFlds.Count + FValsCapDeltaRow;

  FPivotArrayDataColCount := PivotDataSource.ColsTable.RecordCount * ActualValueFields.Count;
  FPivotArrayDataRowCount := PivotDataSource.RowsTable.RecordCount;

  FShowGrandTotalCols := PivotDataSource.ColsTable.RecordCount > 2;
  FShowGrandTotalRows := PivotDataSource.RowsTable.RecordCount > 2;

  SetPivotGridArraySize(FPivotArrayDataColCount + FStartDataCol, FPivotArrayDataRowCount + FStartDataRow);

  FDataSortColNum := -1;
end;

procedure TCustomPivotGridEh.BuildGridArrayColsMeasures;
var
  i, j, k: Integer;
  PivotCel: TPivotCellEh;
  AxisKeyValue: Variant;
  AxisCurValue: Variant;
  AggrDeep: Integer;
  MasterRows: TIntegerDynArray;
  ArrayRow: Integer;
begin

  for k := 0 to ActualRowFlds.Count-1 do
  begin
    for j := 0 to ActualColFlds.Count-1 do
    begin
      PivotCel := PivotGridArray[k, j];
      PivotCel.CelType := sctEmptyEh;
      PivotCel.Value := '';
      PivotCel.DrawDownLine := True;
      PivotCel.DrawRightLine := True;
      PivotCel.VertAggrLevelRow := 0;
      PivotCel.RowVisible := True;
      PivotCel.ColVisible := True;
    end;
    PivotCel := PivotGridArray[k, ActualColFlds.Count+FValsCapDeltaRow];
    PivotCel.CelType := sctFieldNameForRowEh;
    PivotCel.PivotField := PivotFields.FindFieldByName(PivotDataSource.RowsTable.Fields[k].FieldName);
    PivotCel.Value := PivotDataSource.RowsTable.Fields[k].FieldName;
    PivotCel.DrawDownLine := True;
    PivotCel.DrawRightLine := True;
    PivotCel.VertAggrLevelRow := ActualRowFlds.Count-1-k;
    PivotCel.RowVisible := True;
    PivotCel.ColVisible := True;
    PivotCel.ShowValue := True;
    PivotCel.DrawFilterButton := (PivotCel.PivotField <> nil);
  end;

  AxisKeyValue := VarArrayCreate([0, ActualRowFlds.Count-1], varVariant);
  for k := 0 to ActualRowFlds.Count-1 do
    AxisKeyValue[k] := Unassigned;
  AxisCurValue := AxisKeyValue;
  SetLength(MasterRows, ActualRowFlds.Count);

// Rows Vertical Axis
  for i := 0 to PivotDataSource.RowsTable.RecordCount-1 do
  begin
    for k := 0 to ActualRowFlds.Count-1 do
    begin
      ArrayRow := i + ActualColFlds.Count + 1 + FValsCapDeltaRow;
      PivotCel := PivotGridArray[k, ArrayRow];
      PivotCel.RowVisible := True;
      PivotCel.ColVisible := True;
      PivotCel.CelType := sctAxisValueEh;
      PivotCel.VertAggrLevelRow := PivotDataSource.RowsTable.RecordsView[i].Value[ActualRowFlds.Count, dvvValueEh];
      PivotCel.VertAggrLevelCol := ActualRowFlds.Count - 1 - k;
      PivotCel.PivotField := TPivotFieldEh(ActualRowFlds.Objects[k]);
      AggrDeep := PivotCel.VertAggrLevelRow;
      AxisCurValue[k] := PivotDataSource.RowsTable.RecordsView[i].Value[k, dvvValueEh];
      if VarArrayEqualLevelForDepth(AxisKeyValue, AxisCurValue, k+1) = k+1 then
      begin
        PivotCel.Value := PivotDataSource.RowsTable.RecordsView[i].Value[k, dvvValueEh];
        if (AggrDeep > 0) and (k = ActualRowFlds.Count - AggrDeep - 1) then
          PivotCel.ShowValue := True
        else
        begin
          PivotCel.ShowValue := False;
          PivotCel.MasterRow := MasterRows[k];
        end;
        PivotCel.DrawDownLine := True;
        PivotGridArray[k, i + ActualColFlds.Count + 1 - 1 + FValsCapDeltaRow].DrawDownLine := False;
      end else
      begin
        PivotCel.Value := PivotDataSource.RowsTable.RecordsView[i].Value[k, dvvValueEh];
        PivotCel.ShowValue := True;
        if (k < ActualRowFlds.Count-1) and (AggrDeep = 0) then
          PivotCel.ShowGroupingSign := True;
        PivotCel.DrawDownLine := True;
        MasterRows[k] := ArrayRow;
        PivotCel.MasterRow := MasterRows[k];
      end;
      if (AggrDeep > 0) and (k >= ActualRowFlds.Count - AggrDeep - 1) and (k < ActualRowFlds.Count-1) then
        PivotCel.DrawRightLine := False
      else
        PivotCel.DrawRightLine := True;
    end;
    for k := 0 to ActualRowFlds.Count-1 do
      AxisKeyValue[k] := PivotDataSource.RowsTable.RecordsView[i].Value[k, dvvValueEh];
  end;
end;

procedure TCustomPivotGridEh.BuildGridArrayRowsMeasures;
var
  i, k, ip, v: Integer;
  PivotCel: TPivotCellEh;
  RestMVCell: TPivotCellEh;
  ShowRowMeasureValues: Boolean;
  AxisKeyValue: Variant;
  AxisCurValue: Variant;
  AggrDeep: Integer;
begin
  ShowRowMeasureValues := (PivotDataSource.RowFields.Count > 0);
  SetLength(FRowsCaptionExpandedState, ActualColFlds.Count);
  for k := 0 to ActualColFlds.Count-1 do
  begin
    PivotCel := PivotGridArray[k + ActualRowFlds.Count, 0];
    PivotCel.CelType := sctFieldNameForColEh;
    PivotCel.Value := PivotDataSource.ColsTable.Fields[k].FieldName;
    PivotCel.ShowValue := PivotDataSource.ColumnFields.Count > 0;
    PivotCel.DrawDownLine := True;
    PivotCel.DrawRightLine := True;
    PivotCel.HorzAggrLevelCol := ActualColFlds.Count-1-k;
    PivotCel.RowVisible := True;
    PivotCel.ColVisible := True;
    PivotCel.Expanded := True;
    PivotCel.PivotField := PivotFields.FindFieldByName(PivotDataSource.ColsTable.Fields[k].FieldName);
    PivotCel.DrawFilterButton := (PivotCel.PivotField <> nil);
    FRowsCaptionExpandedState[k] := True;
  end;

  AxisKeyValue := VarArrayCreate([0, ActualColFlds.Count-1], varVariant);
  for k := 0 to ActualColFlds.Count-1 do
    AxisKeyValue[k] := Unassigned;
  AxisCurValue := AxisKeyValue;

  for i := 0 to PivotDataSource.ColsTable.RecordCount-1 do
  begin
    ip := i * ActualValueFields.Count;
    for k := 0 to ActualColFlds.Count-1 do
    begin
      PivotCel := PivotGridArray[ip+ActualRowFlds.Count, k+1];
      PivotCel.RowVisible := True;
      PivotCel.ColVisible := True;
      PivotCel.CelType := sctAxisValueEh;
      PivotCel.HorzAggrLevelCol := PivotDataSource.ColsTable.RecordsView[i].Value[ActualColFlds.Count, dvvValueEh];
      PivotCel.HorzAggrLevelRow := ActualColFlds.Count - 1 - k;
      PivotCel.PivotField := TPivotFieldEh(ActualColFlds.Objects[k]);
      AxisCurValue[k] := PivotDataSource.ColsTable.RecordsView[i].Value[k, dvvValueEh];
      AggrDeep := PivotDataSource.ColsTable.RecordsView[i].Value[ActualColFlds.Count, dvvValueEh];

      if VarArrayEqualLevelForDepth(AxisKeyValue, AxisCurValue, k+1) = k+1 then
      begin
        PivotCel.Value := PivotDataSource.ColsTable.RecordsView[i].Value[k, dvvValueEh];
        if (AggrDeep > 0) and (k = ActualColFlds.Count - AggrDeep - 1)
          then PivotCel.ShowValue := ShowRowMeasureValues
          else PivotCel.ShowValue := False;
        PivotCel.DrawRightLine := True;
        PivotGridArray[ip+ActualRowFlds.Count-1, k+1].DrawRightLine := False;
      end else
      begin
        PivotCel.Value := PivotDataSource.ColsTable.RecordsView[i].Value[k, dvvValueEh];
        if (k < ActualColFlds.Count-1) and (AggrDeep = 0) then
          PivotCel.ShowGroupingSign := True;
        PivotCel.ShowValue := True; //??ShowRowMeasureValues;
        PivotCel.DrawRightLine := True;
      end;

      AggrDeep := PivotDataSource.ColsTable.RecordsView[i].Value[ActualColFlds.Count, dvvValueEh];
      if (AggrDeep > 0) and (k >= ActualColFlds.Count - AggrDeep - 1) and (k < ActualColFlds.Count-1)
        then PivotCel.DrawDownLine := False
        else PivotCel.DrawDownLine := True;

      for v := 0 to ActualValueFields.Count-1 do
      begin
        RestMVCell := PivotGridArray[ip+ActualRowFlds.Count+v, k+1];
        if (PivotCel.HorzAggrLevelCol = ActualColFlds.Count) and not FShowGrandTotalCols then
          RestMVCell.ColVisible := False;
        if v > 0 then
        begin
          RestMVCell.Value := PivotCel.Value;
          RestMVCell.DrawDownLine := PivotCel.DrawDownLine;
        end;
        if v < ActualValueFields.Count-1 then
          RestMVCell.DrawRightLine := False;
      end;
    end;

    for v := 0 to ActualValueFields.Count-1 do
    begin
      PivotCel := PivotGridArray[ip + ActualRowFlds.Count + v, ActualColFlds.Count + 1];
      PivotCel.CelType := sctValuesColCaptionEh;
      PivotCel.Value := ActualValueFields[v].PivotFieldName;
    end;

    for k := 0 to ActualColFlds.Count-1 do
      AxisKeyValue[k] := PivotDataSource.ColsTable.RecordsView[i].Value[k, dvvValueEh];
  end;

end;

procedure TCustomPivotGridEh.BuildGridArrayValuesMeasures;
var
  i, j, k, v, jp: Integer;
  ColKeyValue, RowKeyValue: TVariantDynArray;
  ResultColKeyValue, ResultRowKeyValue: TVariantDynArray;
  KeyLength: Integer;
  PivotCel: TPivotCellEh;

  procedure SetResultColKeyValue;
  var
    i: Integer;
    fNo: Integer;
  begin
    for i := 0 to ActualRowFlds.Count-1 do
    begin
      fNo := PivotDataSource.ResultAggrTable.Rec.DataStruct.FieldIndex(ActualRowFlds[i]);
      ResultColKeyValue[i] := PivotDataSource.ResultAggrTable.Rec.Value[fNo, dvvValueEh];
    end;
  end;

  procedure SetResultRowKeyValue;
  var
    i: Integer;
    fNo: Integer;
  begin
    for i := 0 to ActualColFlds.Count-1 do
    begin
      fNo := PivotDataSource.ResultAggrTable.Rec.DataStruct.FieldIndex(ActualColFlds[i]);
      ResultRowKeyValue[i] := PivotDataSource.ResultAggrTable.Rec.Value[fNo, dvvValueEh];
    end;
  end;

begin
  SetLength(ResultColKeyValue, ActualRowFlds.Count);
  SetLength(ResultRowKeyValue, ActualColFlds.Count);

  PivotDataSource.ResultAggrTable.First;
  SetResultColKeyValue;
  SetResultRowKeyValue;

  SetLength(ColKeyValue, ActualRowFlds.Count);
  SetLength(RowKeyValue, ActualColFlds.Count);
  KeyLength := ActualRowFlds.Count + ActualColFlds.Count;

  for i := 0 to PivotDataSource.RowsTable.RecordCount-1 do
  begin
    for k := 0 to ActualRowFlds.Count-1 do
      ColKeyValue[k] := PivotDataSource.RowsTable.RecordsView[i].Value[k, dvvValueEh];

    for j := 0 to PivotDataSource.ColsTable.RecordCount-1 do
    begin
      jp := j * ActualValueFields.Count;

      for k := 0 to ActualColFlds.Count-1 do
        RowKeyValue[k] := PivotDataSource.ColsTable.RecordsView[j].Value[k, dvvValueEh];

      if VarArrayEqual(ResultColKeyValue, ColKeyValue) and
         VarArrayEqual(ResultRowKeyValue, RowKeyValue)
      then
      begin

        for v := 0 to ActualValueFields.Count - 1 do //Values cols
        begin

          PivotCel := PivotGridArray[jp + ActualRowFlds.Count + v,
                                   i + ActualColFlds.Count + 1 + FValsCapDeltaRow];

          if PivotDataSource.ColsTable.RecordsView[j].Value[ActualColFlds.Count, dvvValueEh] <> 0 then
            PivotCel.CelType := sctHorzAggregateData
          else if PivotDataSource.RowsTable.RecordsView[i].Value[ActualRowFlds.Count, dvvValueEh] <> 0 then
            PivotCel.CelType := sctVertAggregateData
          else
            PivotCel.CelType := sctDataEh;

          PivotCel.Value := PivotDataSource.ResultAggrTable.Fields[KeyLength + v].Value;

          PivotCel.ShowValue := True;
          PivotCel.DrawDownLine := True;
          PivotCel.DrawRightLine := True;
          PivotCel.RowVisible := True;
          PivotCel.ColVisible := True;
        end;

        PivotDataSource.ResultAggrTable.Next;
        SetResultColKeyValue;
        SetResultRowKeyValue;
      end else
      begin
        
        for v := 0 to ActualValueFields.Count - 1 do 
        begin
          PivotCel := PivotGridArray[jp + ActualRowFlds.Count + v,
                                   i + ActualColFlds.Count + 1 + FValsCapDeltaRow];

          if PivotDataSource.RowsTable.RecordsView[i].Value[ActualRowFlds.Count, dvvValueEh] <> 0 then
            PivotCel.CelType := sctVertAggregateData
          else if PivotDataSource.ColsTable.RecordsView[j].Value[ActualColFlds.Count, dvvValueEh] <> 0 then
            PivotCel.CelType := sctHorzAggregateData
          else
            PivotCel.CelType := sctDataEh;

          PivotCel.Value := Null;
          PivotCel.ShowValue := True;
          PivotCel.DrawDownLine := True;
          PivotCel.DrawRightLine := True;
          PivotCel.RowVisible := True;
          PivotCel.ColVisible := True;
        end;
      end;
    end;
  end;
end;

procedure TCustomPivotGridEh.MakePivotGridArray;
begin
  SetPivotGridArrayVars;
  BuildGridArrayColsMeasures;
  BuildGridArrayRowsMeasures;
  BuildGridArrayValuesMeasures;
end;

procedure TCustomPivotGridEh.AggregateGridForColumns;
var
  i: Integer;
  AggrLevel: Integer;
begin
  PivotDataSource.TransResultAggrTable.First;
  if PivotDataSource.TransResultAggrTable.Eof then Exit;

  for i := ActualColFlds.Count downto 1 do
  begin
    AggrLevel := PivotDataSource.TransResultAggrTable['ForGridAggrLevel'];
    if AggrLevel <> i then
      raise Exception.Create('Algorithmic error: ' +
        'ForGridAggrLevel='+IntToStr(AggrLevel) +
        ': i='+IntToStr(i));
    AggregateGridForColumnsLevel(i);
  end;
end;

procedure TCustomPivotGridEh.AggregateGridForColumnsLevel(ColsLevel: Integer);
var
  i, j, k, v, ip: Integer;
  ColKeyValue, RowKeyValue: TVariantDynArray;
  ResultColKeyValue, ResultRowKeyValue: TVariantDynArray;
  KeyLength: Integer;
  PivotCel: TPivotCellEh;

  procedure SetResultColKeyValue;
  var
    i: Integer;
    fNo: Integer;
  begin
    for i := 0 to ActualColFlds.Count-1 do
    begin
      fNo := PivotDataSource.TransResultAggrTable.Rec.DataStruct.FieldIndex(ActualColFlds[i]);
      ResultColKeyValue[i] := PivotDataSource.TransResultAggrTable.Rec.Value[fNo, dvvValueEh];
    end;
  end;

  procedure SetResultRowKeyValue;
  var
    i: Integer;
    fNo: Integer;
  begin
    for i := 0 to ActualRowFlds.Count-1 do
    begin
      fNo := PivotDataSource.TransResultAggrTable.Rec.DataStruct.FieldIndex(ActualRowFlds[i]);
      ResultRowKeyValue[i] := PivotDataSource.TransResultAggrTable.Rec.Value[fNo, dvvValueEh];
    end;
  end;

begin
  SetLength(ResultColKeyValue, ActualColFlds.Count);
  SetLength(ResultRowKeyValue, ActualRowFlds.Count);

  SetResultColKeyValue;
  SetResultRowKeyValue;

  SetLength(ColKeyValue, ActualColFlds.Count);
  SetLength(RowKeyValue, ActualRowFlds.Count);

  KeyLength := ActualRowFlds.Count + ActualColFlds.Count;

  for i := 0 to PivotDataSource.ColsTable.RecordCount-2 do
  begin
    for k := 0 to ActualColFlds.Count-1 do
      ColKeyValue[k] := PivotDataSource.ColsTable.RecordsView[i].Value[k, dvvValueEh];

    ip := i * ActualValueFields.Count;

    for j := 0 to PivotDataSource.RowsTable.RecordCount-1 do
    begin

      for k := 0 to ActualRowFlds.Count-1 do
        RowKeyValue[k] := PivotDataSource.RowsTable.RecordsView[j].Value[k, dvvValueEh];

      if VarArrayEqual(ResultColKeyValue, ColKeyValue) and
         VarArrayEqual(ResultRowKeyValue, RowKeyValue)
      then
      begin

        for v := 0 to ActualValueFields.Count - 1 do //Values cols
        begin

          PivotCel := PivotGridArray[ip + ActualRowFlds.Count + v,
                                     j + ActualColFlds.Count + 1 + FValsCapDeltaRow];

          if PivotDataSource.RowsTable.RecordsView[j].Value[ActualRowFlds.Count, dvvValueEh] <> 0 then
            PivotCel.CelType := sctHorzAggregateData
          else if PivotDataSource.ColsTable.RecordsView[i].Value[ActualColFlds.Count, dvvValueEh] <> 0 then
            PivotCel.CelType := sctVertAggregateData
          else
            PivotCel.CelType := sctDataEh;

          PivotCel.Value := PivotDataSource.TransResultAggrTable.Fields[KeyLength + v].Value;

          PivotCel.ShowValue := True;
          PivotCel.DrawDownLine := True;
          PivotCel.DrawRightLine := True;
          PivotCel.RowVisible := True;
          PivotCel.ColVisible := True;
        end;

        PivotDataSource.TransResultAggrTable.Next;

        SetResultColKeyValue;
        SetResultRowKeyValue;
      end else
      begin
        
      end;
    end;
  end;
end;

procedure TCustomPivotGridEh.MoveAggrRowBeforeData;
var
  j, k: Integer;
  ColAggrValue: TIntegerDynArray;
  AggrLevel: Integer;

  procedure MoveRowTo(FromRow, ToRow: Integer);
  var
    PivotRow: array of TPivotCellEh;
    i, j: Integer;
  begin
    SetLength(PivotRow, Length(PivotGridArray));
    for i := 0 to Length(PivotGridArray)-1 do
      PivotRow[i] := PivotGridArray[i, FromRow];

    for j := FromRow-1 downto ToRow do
      for i := 0 to Length(PivotGridArray)-1 do
        PivotGridArray[i, j+1] := PivotGridArray[i, j];

    for i := 0 to Length(PivotGridArray)-1 do
      PivotGridArray[i, ToRow] := PivotRow[i];
  end;

begin
  SetLength(ColAggrValue, ActualRowFlds.Count);

  for k := 0 to ActualRowFlds.Count-1 do
    ColAggrValue[k] := ActualColFlds.Count+1;

  for j := ActualColFlds.Count+1 to Length(PivotGridArray[0])-2 do
  begin
    AggrLevel := PivotGridArray[0,j].VertAggrLevelRow;
    if AggrLevel > 0 then
    begin
      PivotGridArray[ActualRowFlds.Count-AggrLevel-1,j].DrawDownLine := False;
      PivotGridArray[ActualRowFlds.Count-AggrLevel-1,j-1].DrawDownLine := True;
      PivotGridArray[ActualRowFlds.Count-AggrLevel-1,ColAggrValue[AggrLevel]+AggrLevel-1].ShowValue := False;
      MoveRowTo(j, ColAggrValue[AggrLevel]);
      ColAggrValue[AggrLevel] := -1;
    end else
      for k := 0 to ActualRowFlds.Count-1 do
        if ColAggrValue[k] = -1 then
          ColAggrValue[k] := j;
  end;
end;

procedure TCustomPivotGridEh.FillGridDataForActualRowFlds;
var
  k: Integer;
  PivotCel: TPivotCellEh;
begin
  if (ActualColFlds.Count = 0) or (ActualColFlds.Objects[0] = DummyPivotField) then
  begin
    PivotCel := PivotGridArray[1, 0];
    PivotCel.CelType := sctFieldNameForColEh;
  end else
  begin
    for k := 0 to ActualColFlds.Count-1 do
    begin
      PivotCel := VisPivotGridArray[k+ActualRowFlds.Count, 0];
      PivotCel.CelType := sctFieldNameForColEh;
      PivotCel.Value := PivotDataSource.ColsTable.Fields[k].FieldName;
      PivotCel.ShowValue := PivotDataSource.ColumnFields.Count > 0;
      PivotCel.DrawDownLine := True;
      PivotCel.DrawRightLine := True;
      PivotCel.HorzAggrLevelCol := ActualColFlds.Count-1-k;
      PivotCel.RowVisible := True;
      PivotCel.ColVisible := True;
      PivotCel.Expanded := FRowsCaptionExpandedState[k];
      PivotCel.PivotField := PivotFields.FindFieldByName(PivotDataSource.ColsTable.Fields[k].FieldName);
      PivotCel.DrawFilterButton := (PivotCel.PivotField <> nil);
    end;
    for k := ActualColFlds.Count + ActualRowFlds.Count to FVisPivotColCount-1 do
    begin
      PivotCel := VisPivotGridArray[k, 0];
      PivotCel.Clear;
    end;
  end;
end;

procedure TCustomPivotGridEh.MakeVisPivotGridArray;
var
  i, j: Integer;
begin

  if DataSourceIsEmpty {or FGridIsEmptyStatus} then
  begin
    for i := 0 to Length(PivotGridArray)-1 do
      for j := 0 to Length(PivotGridArray[i])-1 do
        FVisPivotGridArray[i, j] := PivotGridArray[i, j];
    Exit;
  end;

  FVisPivotRowCount := RowsAxisTree.FlatListCount + FStartDataRow + GrandTotalRowCount;
  FVisPivotColCount := ColsAxisTree.FlatListCount * ActualValueFields.Count + FStartDataCol + GrandTotalColCount;
  FillGridDataForActualRowFlds;
  SetGridSizes(True);
end;

procedure TCustomPivotGridEh.SetColLevelExpanded(AColLevel: Integer;
  IsExpanded: Boolean; const KeyValues: TVariantDynArray);
begin
  RowsAxisTree.SetLevelExpanded(ActualRowFlds.Count-AColLevel, IsExpanded);
end;

procedure TCustomPivotGridEh.SetRowLevelExpanded(ARowLevel: Integer;
  IsExpanded: Boolean; const KeyValues: TVariantDynArray);
begin
  FRowsCaptionExpandedState[ActualColFlds.Count-ARowLevel-1] := IsExpanded;
  ColsAxisTree.SetLevelExpanded(ActualColFlds.Count-ARowLevel, IsExpanded);
end;

procedure TCustomPivotGridEh.DrawSortMarker(var ARect: TRect;
  AState: TGridDrawState; SortOrder: TSortOrderEh);
var
  Style: TDBGridEhStyle;
  smSize: TSize;
  BaseRect, SMRect: TRect;
  FillColor: TColor;
  SortMarker: TSortMarkerEh;
begin
  Style := DBGridEhDefaultStyle;
  smSize := Style.GetSortMarkerSize(Canvas, smstSolidEh);
  SMRect := Rect(0, 0, smSize.cx, smSize.cy);
  BaseRect := Rect(ARect.Right - smSize.cx - 4, ARect.Top, ARect.Right, ARect.Bottom);
  SMRect := CenteredRect(BaseRect, SMRect);
  FillColor := ApproximateColor(FInternalFixedFontColor, FInternalFixedColor, 128);
  FillColor := ApproximateColor(FillColor, clSkyBlue, 128);
  if SortOrder = soAscEh
    then SortMarker := smUpEh
    else SortMarker := smDownEh;
  Style.DrawSortMarkerNew(Canvas, smstSolidEh, SortMarker, False, SMRect, clDefault, clDefault, FillColor);
  ARect.Right := BaseRect.Left;
end;

procedure TCustomPivotGridEh.DrawTopGroupRowValues;
var
  ARect: TRect;
  i: Integer;
  PivotCel, MastPivotCel: TPivotCellEh;
  OldShowValue, ShowGroupingSign: Boolean;
begin
  if GridIsEmpty then Exit;

  if UseRightToLeftAlignment then ChangeGridOrientation(True);
  ARect.Left := HorzAxis.GridClientStart - ColWidths[0];
  ARect.Top := VertAxis.FixedBoundary;
  ARect.Right := ColWidths[0];
  ARect.Bottom := ARect.Top + RowHeights[VertAxis.StartVisCel];
  for i := 0 to ActualRowFlds.Count-2 do
  begin
    OffsetRect(ARect, ColWidths[i], 0);
    PivotCel := VisPivotGridArray[i, VertAxis.StartVisCel];
    if (PivotCel.MasterRow >= 0) and
       (VisPivotGridArray[i, VertAxis.StartVisCel+1].MasterRow >= 0) and
       (PivotCel.VertAggrLevelCol > PivotCel.VertAggrLevelRow) then
    begin
      MastPivotCel := PivotGridArray[i, PivotCel.MasterRow];
      OldShowValue :=  MastPivotCel.ShowValue;
      ShowGroupingSign :=  MastPivotCel.ShowGroupingSign;
      MastPivotCel.ShowValue := True;
      MastPivotCel.ShowGroupingSign := True;
      DrawAxisValueCellData(0, 0, ARect, [], MastPivotCel, True, True);
      MastPivotCel.ShowValue := OldShowValue;
      MastPivotCel.ShowGroupingSign := ShowGroupingSign;
    end;
  end;
  if UseRightToLeftAlignment then ChangeGridOrientation(False);
end;

procedure TCustomPivotGridEh.DrawFieldNameCell(ACol, ARow: Integer; ARect: TRect;
  AState: TGridDrawState; PivotCel: TPivotCellEh);
var
  TreeSignRect: TRect;
  TreeElement: TTreeElementEh;
  s: String;
  Al: TAlignment;
begin
  Canvas.Brush.Color := GridCellParams.ActualFieldNameColor;
  Canvas.Font := GridCellParams.FieldNameFont;
  Canvas.FillRect(ARect);

  if (PivotCel.VertAggrLevelRow > 0) or (PivotCel.HorzAggrLevelCol > 0) then
  begin
    TreeSignRect := ARect;
    TreeSignRect.Right := TreeSignRect.Left + 18;
    if PivotCel.Expanded
      then TreeElement := tehMinus
      else TreeElement := tehPlus;
    DrawTreeElement(Canvas, TreeSignRect, TreeElement, False, 1, 1, False, True,
      tvgsClassicEh);
    ARect.Left := TreeSignRect.Right;
  end;

  if PivotCel.DrawFilterButton then
    DrawFilterButton(ARect, AState);

  if (PivotCel.CelType = sctFieldNameForRowEh) and
     (FDataSortColNum = -1) and
     (PivotCel.PivotField <> nil)
  then
    DrawSortMarker(ARect, AState, PivotCel.PivotField.SortOrder);

  if PivotCel.ShowValue = True then
    s := VarToStr(PivotCel.Value)
  else
    s := '';

  Al := taLeftJustify;
  if PivotCel.ShowValue then
    DrawText(Canvas, ARect, False, 2, 2, s, Al, tlTop, False, False, 0, 0,
      False, UseRightToLeftAlignment);
//    WriteTextEh(Canvas, ARect, False, 2, 2, s, Al, tlTop, False, False, 0, 0,
//      False, True);
end;

procedure TCustomPivotGridEh.DrawAxisValueCellData(ACol, ARow: Integer; ARect: TRect;
  AState: TGridDrawState; PivotCel: TPivotCellEh; ShowGroupingSign, ShowValue: Boolean);
var
  s: String;
  TreeSignRect: TRect;
  TreeElement: TTreeElementEh;
  Al: TAlignment;
  ASrcCol, ASrcRow: Integer;
begin
  Al := taLeftJustify;
  if UseRightToLeftAlignment then ChangeBiDiModeAlignment(Al);

  if not DataSourceIsEmpty and
     GrandTotalRowVisible and
    (PivotCel.VertAggrLevelRow = ActualRowFlds.Count) and
    (PivotCel.VertAggrLevelCol = ActualRowFlds.Count-1)
  then
    s := 'Grand Total'
  else if not DataSourceIsEmpty and
          FShowGrandTotalCols and
          (ACol = FullColCount-1*ActualValueFields.Count) and
          (ARow = ActualColFlds.Count)
  then
    s := 'Grand Total'
  else
  begin
    if ShowValue = True
      then s := VarToStr(PivotCel.Value)
      else s := '';

    if (ARow = Row) or (ACol = Col) then
      Canvas.Brush.Color := ApproximateColor(GridCellParams.ActualAxisColor, clBtnShadow, 85);

    if PivotCel.ShowValue and
      (PivotCel.PivotField <> nil) and
      (PivotCel.VertAggrLevelRow < ActualRowFlds.Count) and
      (PivotCel.HorzAggrLevelCol < ActualColFlds.Count)
    then
      s := PivotCel.PivotField.ValueAsDispayText(PivotCel.Value);

    if ((PivotCel.VertAggrLevelRow > 0) or (PivotCel.HorzAggrLevelCol > 0)) and (s <> '') then
      s := s + ' Total';
  end;

  if ShowGroupingSign then
  begin
    TreeSignRect := ARect;
    TreeSignRect.Right := TreeSignRect.Left + 18;
    TreeElement := tehMinus;
    if PivotCel.RowsTreeNode <> nil then
    begin
      if PivotCel.RowsTreeNode.Expanded
        then TreeElement := tehMinus
        else TreeElement := tehPlus;
    end else if PivotCel.ColsTreeNode <> nil then
    begin
      if PivotCel.ColsTreeNode.Expanded
        then TreeElement := tehMinus
        else TreeElement := tehPlus;
    end;
    Canvas.Pen.Color := GridLineColors.GetDarkColor;
    Canvas.Brush.Color := GridCellParams.ActualAxisColor;
    DrawTreeElement(Canvas, TreeSignRect, TreeElement, False, 1, 1, False, False, tvgsClassicEh);
    ARect.Left := TreeSignRect.Right;
  end;

  VisPivotPosToSrcArrayPos(ACol, ARow, ASrcCol, ASrcRow);
  if {(PivotCel.ColsTreeNode <> nil) and}
     (ActualRowFlds <> nil) and
     (ACol >= ActualRowFlds.Count) and
     (FDataSortColNum = ASrcCol {PivotCel.ColsTreeNode.AxisPos + FStartDataCol}) and
     (ARow = FStartDataRow-1)
  then
    DrawSortMarker(ARect, AState, FDataSortSortOrder);

{  if ShowValue = True then
  begin
    if (PivotCel.PivotField <> nil) then
      s := PivotCel.PivotField.ValueAsDispayText(PivotCel.Value)
    else
      s := VarToStr(PivotCel.Value);
  end else
    s := '';}

  if ShowValue then
    DrawText(Canvas, ARect, False, 2, 2, s, Al, tlTop, False, False, 0, 0, False, UseRightToLeftAlignment);
//    WriteTextEh(Canvas, ARect, False, 2, 2, s, Al, tlTop, False, False, 0, 0, False, True);
end;

procedure TCustomPivotGridEh.MergeRectForCell(ACol, ARow: Integer; var ARect: TRect;
  AState: TGridDrawState; PivotCel: TPivotCellEh);
var
  i: Integer;
  APivotCelForMerge: TPivotCellEh;
begin
  for i := ACol+1 to ColCount-1 do
  begin
    APivotCelForMerge := VisPivotGridArray[i, ARow];
    if (APivotCelForMerge.CelType = sctAxisValueEh) and VarIsClear(APivotCelForMerge.Value) then
    begin
      Inc(ARect.Right, ColWidths[i]);
      SetCellDrawn(i, ARow);
    end else
      Exit;
  end;
end;

procedure TCustomPivotGridEh.DrawAxisValueCell(ACol, ARow: Integer; ARect: TRect;
  AState: TGridDrawState; PivotCel: TPivotCellEh);
var
//  s: String;
  ShowGroupingSign, ShowValue: Boolean;

  function NextRowCellIsLevelSum(): Boolean;
  var
    NextCel: TPivotCellEh;
  begin
    if ARow < FullRowCount-1 then
    begin
      NextCel := VisPivotGridArray[ACol, ARow+1];
      Result := NextCel.VertAggrLevelCol = NextCel.VertAggrLevelRow;
    end else
      Result := False;
  end;

begin
  if CheckCellAreaDrawn(ACol, ARow) then Exit;

  MergeRectForCell(ACol, ARow, ARect, AState, PivotCel);

  Canvas.Brush.Color := GridCellParams.ActualAxisColor;

  if ((PivotCel.VertAggrLevelRow > 0) and (PivotCel.VertAggrLevelRow >= PivotCel.VertAggrLevelCol))
   or
     ((PivotCel.HorzAggrLevelCol > 0) and (PivotCel.HorzAggrLevelCol >= PivotCel.HorzAggrLevelRow))
  then
    Canvas.Font := GridCellParams.AxisAggregateFont
  else
    Canvas.Font := GridCellParams.AxisFont;

  Canvas.FillRect(ARect);

  if //PivotCel.ShowValue and
     (PivotCel.MasterRow >= 0) and
     (PivotCel.DrawDownLine = False) and
     (ARect.Top <= VertAxis.FixedBoundary)
  then
  begin
    if NextRowCellIsLevelSum() then
    begin
      ShowGroupingSign := True;
      ShowValue := True;
    end else
      Exit;
  end else
  begin
    ShowGroupingSign := PivotCel.ShowGroupingSign;
    ShowValue := PivotCel.ShowValue;
  end;

  DrawAxisValueCellData(ACol, ARow, ARect, AState, PivotCel,
    ShowGroupingSign, ShowValue);
end;

procedure TCustomPivotGridEh.FillDrawCellParams(ADrawCellParams: TPivotCellDrawParamsEh;
  ACol, ARow: Integer; ARect: TRect; AState: TGridDrawState; PivotCel: TPivotCellEh);

  function GetStrValue(SFValueInfo: TPivotFieldValueInfoEh; const Val: Variant): String;
  begin
    if VarIsNull(Val) then
      Result := ''
    else if SFValueInfo.SumFunction = svtCountEh then
      Result := FloatToStr(Val)
    else
      Result := FormatFloat('#,##0.00', Val)
  end;

  function GetDisplayValue: String;
  var
    k: Integer;
    ls: String;
  begin
    ls := '';
    if PivotCel.ShowValue then
    begin
      if (ActualValueFields.Count = Length(PivotCel.ArrayValue)) then
      begin
        Result := '';
        for k := 0 to ActualValueFields.Count-1 do
        begin
          Result := Result + GetStrValue(ActualValueFields[k], PivotCel.ArrayValue[k]);
          if (ActualValueFields.Count = 2) and (ActualValueFields[1].SumFunction = svtCountEh) then
          begin
            if k = 0
              then Result := Result + ' ('
              else Result := Result + ')';
          end else
          begin
            ls := ls + PivotAggrValueTypes[ActualValueFields[k].SumFunction];
            if k < ActualValueFields.Count-1 then
            begin
              Result := Result + sLineBreak;
              ls := ls + sLineBreak;
            end;
          end;
        end;
      end else if not VarIsNull(PivotCel.Value) then
        Result := FormatFloat('#,##0.00', PivotCel.Value)
    end else
      Result := '';
  end;

var
  AxisCell: TPivotCellEh;

begin
  ADrawCellParams.FCol := ACol;
  ADrawCellParams.FRow := ARow;
  ADrawCellParams.FAreaCol := ACol - FStartDataCol;
  ADrawCellParams.FAreaRow := ARow - FStartDataRow;

  if (PivotCel.CelType in [sctHorzAggregateData, sctVertAggregateData])
     {and not (gdSelected in AState)}
  then
  begin
    ADrawCellParams.FFillColor := GridCellParams.ActualDataAggregateColor;
    Canvas.Font := GridCellParams.DataAggregateFont;
  end else
  begin
    ADrawCellParams.FFillColor := Canvas.Brush.Color;
  end;

  ADrawCellParams.FFont := Canvas.Font;
  ADrawCellParams.FDrawState := AState;

  ADrawCellParams.FValue := PivotCel.Value;
  ADrawCellParams.FDisplayValue := GetDisplayValue;

  AxisCell := VisPivotGridArray[0, ARow];
  ADrawCellParams.FRowsGroupLevel := AxisCell.VertAggrLevelRow;

  AxisCell := VisPivotGridArray[ACol, 1];
  ADrawCellParams.FColsGroupLevel := AxisCell.HorzAggrLevelCol;

  ADrawCellParams.FSignType := pcstNonEh;
  ADrawCellParams.FSignFillColor := clDefault;
  ADrawCellParams.FSignFrameColor := clDefault;
end;

procedure TCustomPivotGridEh.DrawCellSign(ACol, ARow: Integer; var ARect: TRect;
  FDrawCellParams: TPivotCellDrawParamsEh);
var
  SignRect: TRect;
  OldFillColor: TColor;
  OldPenColor: TColor;
begin
  if FDrawCellParams.SignType in [pcstRectangleEh, pcstCircleEh] then
  begin
    SignRect := ARect;
    ARect.Left := ARect.Left + (ARect.Bottom - ARect.Top) + 1;
    SignRect.Right := ARect.Left;
    if not IsDrawCellSelectionThemed(ACol, ARow, FDrawCellParams.DrawState) then
      Canvas.FillRect(SignRect);
    SignRect.Right := ARect.Left - 1;
    InflateRect(SignRect, -2, -2);
    OldFillColor := Canvas.Brush.Color;
    OldPenColor := Canvas.Pen.Color;
    Canvas.Brush.Color := FDrawCellParams.SignFillColor;
    Canvas.Pen.Color := FDrawCellParams.SignFrameColor;
    if FDrawCellParams.SignType = pcstRectangleEh
      then Canvas.FillRect(SignRect)
      else Canvas.Ellipse(SignRect.Left, SignRect.Top, SignRect.Right, SignRect.Bottom);
    Canvas.Brush.Color := OldFillColor;
    Canvas.Pen.Color := OldPenColor;
  end;
end;

procedure TCustomPivotGridEh.DrawDataCell(ACol, ARow: Integer; ARect: TRect;
  AState: TGridDrawState; PivotCel: TPivotCellEh);
var
  s: String;
  Al: TAlignment;
  IsCellFilled: Boolean;
  Processed: Boolean;
  ACellRect: TRect;
  AHighlightColor: TColor;
begin
  Al := taRightJustify;
//  if UseRightToLeftAlignment then ChangeBiDiModeAlignment(Al);

  Canvas.Brush.Color := GridCellParams.ActualDataColor;
  Canvas.Font := GridCellParams.DataFont;

  FillDrawCellParams(FDrawCellParams, ACol, ARow, ARect, AState, PivotCel);
  if Assigned(OnDrawDataCell) then
  begin
    Processed := False;
    OnDrawDataCell(Self, ACol, ARow, FDrawCellParams, Processed);
    if Processed then Exit;
  end;
  Canvas.Brush.Color := FDrawCellParams.FillColor;

  if (gdSelected in AState) and
    (not (gdFocused in AState) or
    ([goDrawFocusSelectedEh, goRowSelectEh] * inherited Options <> [])) then
  begin
    if not IsDrawCellSelectionThemed(ACol, ARow, AState) then
    begin
      if gdCurrent in AState then
      begin
        Canvas.Brush.Color := clHighlight;
        Canvas.Font.Color := clHighlightText;
      end else
      begin
        if Focused
          then AHighlightColor := clHighlight
          else AHighlightColor := ColorToGray(clHighlight);
        Canvas.Brush.Color := ApproximateColor(Canvas.Brush.Color, AHighlightColor, 256/3)
      end;
    end;
  end;

  s := FDrawCellParams.DisplayValue;

  ACellRect := ARect;

  IsCellFilled := False;
  if IsDrawCellSelectionThemed(ACol, ARow, AState) then
  begin
    if not IsCellFilled then
    begin
      Canvas.FillRect(ARect);
      IsCellFilled := True;
    end;
    DrawCellDataBackground(ACol, ARow, ACellRect, AState);
  end;

  if FDrawCellParams.SignType <> pcstNonEh then
    DrawCellSign(ACol, ARow, ARect, FDrawCellParams);

  DrawText(Canvas, ARect, not IsCellFilled, 2, 2, s, Al, tlTop, False, False, 0, 0, False, UseRightToLeftAlignment);
//  WriteTextEh(Canvas, ARect, not IsCellFilled, 2, 2, s, Al, tlTop, False, False, 0, 0, False, False);
end;

procedure TCustomPivotGridEh.DrawCell(ACol, ARow: Integer; ARect: TRect;
  AState: TGridDrawState);
var
  PivotCel: TPivotCellEh;
//  s: String;
  IsCellSelectionFilledByTheme: Boolean;

begin
//  s := '';
  Canvas.Font := Self.Font;
  IsCellSelectionFilledByTheme := False;

  if (gdFixed in AState) or (ACol >= ColCount) or (ARow >= RowCount) then
    Canvas.Brush.Color := FixedColor
  else
    Canvas.Brush.Color := Color;

  if (ACol < FVisPivotColCount) and (ARow < FVisPivotRowCount) then
  begin
    PivotCel := VisPivotGridArray[ACol, ARow];
//    if PivotCel.ShowValue = True
//      then s := VarToStr(PivotCel.Value)
//      else s := '';
    if PivotCel.CelType in [sctFieldNameForRowEh, sctFieldNameForColEh] then
    begin
      DrawFieldNameCell(ACol, ARow, ARect, AState, PivotCel);
    end else if PivotCel.CelType in [sctDataEh, sctHorzAggregateData, sctVertAggregateData] then
    begin
      DrawDataCell(ACol, ARow, ARect, AState, PivotCel);
      if IsDrawCellSelectionThemed(ACol, ARow, AState) then
        IsCellSelectionFilledByTheme := True;
    end else if PivotCel.CelType in [sctAxisValueEh, sctValuesColCaptionEh] then
    begin
      DrawAxisValueCell(ACol, ARow, ARect, AState, PivotCel);
    end else
    begin
      Canvas.FillRect(ARect);
    end;
  end else
  begin
    Canvas.FillRect(ARect);
  end;

  if not (csDesigning in ComponentState) and
     (gdFocused in AState) and
     ([goEditingEh, goAlwaysShowEditorEh] * inherited Options <> [goEditingEh, goAlwaysShowEditorEh]) and
     not (goRowSelectEh in inherited Options) and
     not IsCellSelectionFilledByTheme then
  begin
    DrawFocusRect(Canvas.Handle, ARect);
  end;
end;

procedure TCustomPivotGridEh.CheckDrawCellBorder(ACol, ARow: Integer;
  BorderType: TGridCellBorderTypeEh; var IsDraw: Boolean;
  var BorderColor: TColor; var IsExtent: Boolean);
var
  PivotCel: TPivotCellEh;
begin
  inherited CheckDrawCellBorder(ACol, ARow, BorderType, IsDraw, BorderColor, IsExtent);
  if (FVisPivotColCount > ACol) and (FVisPivotRowCount > ARow) then
  begin
    PivotCel := VisPivotGridArray[ACol, ARow];
//    if PivotCel = nil then Exit;

//    if PivotCel.CelType = sctAxisValueEh then
    begin
      if BorderType = cbtRightEh then
        IsDraw := PivotCel.DrawRightLine
      else if BorderType = cbtBottomEh then
        IsDraw := PivotCel.DrawDownLine;
    end;
  end;
end;

function TCustomPivotGridEh.IsSmoothHorzScroll: Boolean;
begin
  Result := True;
end;

function TCustomPivotGridEh.IsSmoothVertScroll: Boolean;
begin
  Result := True;
end;

procedure TCustomPivotGridEh.WMHScroll(var Message: TWMHScroll);
begin
  if Message.ScrollCode = SB_THUMBTRACK then
    Perform(Message.Msg, MakeLong(SB_THUMBPOSITION, Word(Message.Pos)), Message.ScrollBar)
  else
    inherited;
end;

procedure TCustomPivotGridEh.WMVScroll(var Message: TWMVScroll);
begin
  if Message.ScrollCode = SB_THUMBTRACK then
    Perform(Message.Msg, MakeLong(SB_THUMBPOSITION, Word(Message.Pos)), Message.ScrollBar)
  else
    inherited;
end;

procedure TCustomPivotGridEh.WMKillFocus(var Message: TWMKillFocus);
begin
  inherited;
  if FInTitleFilterListboxVisible then
    FilterListboxCloseUp(False);
end;

procedure TCustomPivotGridEh.WMCancelMode(var Message: TWMCancelMode);
begin
  inherited;
  if FInTitleFilterListboxVisible then
    FilterListboxCloseUp(False);
end;

function TCustomPivotGridEh.WMCheckCanSendDoubleClicks(
  var MouseEvent: TWMMouse): Boolean;
begin
  Result := False;
end;

procedure TCustomPivotGridEh.WMLButtonDown(var Message: TWMLButtonDown);
begin
  if not CheckTopGroupRowMouseDown(mbLeft, KeysToShiftState(Message.Keys), Message.XPos, Message.YPos) then
    inherited;
end;

function TCustomPivotGridEh.NeedBufferedPaint: Boolean;
begin
  Result := True;
end;

procedure TCustomPivotGridEh.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if AComponent = PivotDataSource then
    PivotDataSource := nil;
end;

procedure TCustomPivotGridEh.WMEraseBkgnd(var Message: TWmEraseBkgnd);
begin
  Message.Result := 1;
end;

function TCustomPivotGridEh.GetCellHitArea(PivotCel: TPivotCellEh;
  const ACellRect: TRect; CellMousePos: TPoint): TCellAreaEh;
var
  SpecRect: TRect;
  RestRect: TRect;
  FilterButtonRect, FilterButtonGrossRect: TRect;
begin
  Result := caUnspecifiedEh;
  if (PivotCel.CelType in [sctFieldNameForRowEh, sctFieldNameForColEh]) then
  begin
    RestRect := ACellRect;
    OffsetRect(RestRect, -RestRect.Left, -RestRect.Top);

    if (PivotCel.VertAggrLevelRow > 0) or (PivotCel.HorzAggrLevelCol > 0) then
    begin
      SpecRect := RestRect;
      if UseRightToLeftAlignment
        then SpecRect.Left := SpecRect.Right - 18
        else SpecRect.Right := SpecRect.Left + 18;
      if PtInRect(SpecRect, CellMousePos) then
      begin
        Result := caTreeExpandSignEh;
        Exit;
      end;
      if UseRightToLeftAlignment
        then RestRect.Right := SpecRect.Left
        else RestRect.Left := SpecRect.Right;
    end;

    if PivotCel.DrawFilterButton then
    begin
      GetFilterButtonRect(RestRect, FilterButtonRect, FilterButtonGrossRect, UseRightToLeftAlignment);
      if PtInRect(FilterButtonGrossRect, CellMousePos) then
      begin
        Result := caDropDownButtonEh;
        Exit;
      end;
    end;
  end;
end;

procedure TCustomPivotGridEh.StartDrag;
begin
  FDragStarted := True;
  BeginDrag(True);
end;

procedure TCustomPivotGridEh.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseMove(Shift, X, Y);
  if MouseCapture and (FDragCell <> nil) and (FGridState = gsNormalEh) then
    StartDrag;
end;

procedure TCustomPivotGridEh.GetTopGroupRowCells(var Cells: TPivotRectCellDynArrayEh);
var
  ARect: TRect;
  i: Integer;
  PivotCel: TPivotCellEh;

begin
  ARect.Left := HorzAxis.GridClientStart - ColWidths[0];
  ARect.Top := VertAxis.FixedBoundary;
  ARect.Right := 0;
  ARect.Bottom := ARect.Top + RowHeights[VertAxis.StartVisCel];
  if (ActualRowFlds = nil) or (ActualRowFlds.Count-1 <= 0) then Exit;
  SetLength(Cells, ActualRowFlds.Count-1);
  for i := 0 to ActualRowFlds.Count-2 do
  begin
    OffsetRect(ARect, ColWidths[i], 0);
    PivotCel := VisPivotGridArray[i, VertAxis.StartVisCel];
    if (PivotCel.MasterRow >= 0) and
       (VisPivotGridArray[i, VertAxis.StartVisCel+1].MasterRow >= 0) and
       (PivotCel.VertAggrLevelCol > PivotCel.VertAggrLevelRow) then
    begin
      Cells[i].Rect := ARect;
      Cells[i].PivotArrayCol := i;
      Cells[i].PivotArrayRow := PivotCel.MasterRow;
    end else
    begin
      Cells[i].Rect := Rect(-1,-1,-1,-1);
      Cells[i].PivotArrayCol := -1;
      Cells[i].PivotArrayRow := -1;
    end;
  end;
end;

procedure TCustomPivotGridEh.GetVisPivotGridArrayPosByAxisCell(PivotCel: TPivotCellEh; var VisCellCoord: TPoint);
var
  i, j: Integer;
begin
  VisCellCoord.X := -1;
  VisCellCoord.Y := -1;
  for i := 0 to FullColCount-1 do
    for j := 0 to FullRowCount-1 do
    begin
      if VisPivotGridArray[i, j] = PivotCel then
      begin
        VisCellCoord.X := i;
        VisCellCoord.Y := j;
        Exit;
      end;
    end;
end;

procedure TCustomPivotGridEh.GetVisPivotGridArrayPosByAxisTreeNode(RowsTreeNode: TPivotAxisTreeNodeEh; var VisCellCoord: TPoint);
var
  i, j: Integer;
begin
  VisCellCoord.X := -1;
  VisCellCoord.Y := -1;
  for i := 0 to FullColCount-1 do
    for j := 0 to FullRowCount-1 do
    begin
      if VisPivotGridArray[i, j].RowsTreeNode = RowsTreeNode then
      begin
        VisCellCoord.X := i;
        VisCellCoord.Y := j;
        Exit;
      end;
    end;
end;

function TCustomPivotGridEh.CheckTopGroupRowMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
var
  TopGroupCells: TPivotRectCellDynArrayEh;
  i: Integer;
  CellMousePos: TPoint;
  PivotCel: TPivotCellEh;
  VisCellCoord: TPoint;
begin
  Result := False;
  SetLength(TopGroupCells, 0);
  GetTopGroupRowCells(TopGroupCells);
  for i := 0 to Length(TopGroupCells)-1 do
  begin
    if PtInRect(TopGroupCells[i].Rect, Point(X, Y)) then
    begin
      CellMousePos := Point(X - TopGroupCells[i].Rect.Left, Y - TopGroupCells[i].Rect.Top);
      if (CellMousePos.X >= 0) and (CellMousePos.X < 18) then
      begin
        PivotCel := PivotGridArray[TopGroupCells[i].PivotArrayCol, TopGroupCells[i].PivotArrayRow];
        SetAxisRowExpandedState(PivotCel, False);
        GetVisPivotGridArrayPosByAxisTreeNode(PivotCel.RowsTreeNode, VisCellCoord);
        SafeSetTopRow(VisCellCoord.Y);
        Result := True;
      end;
      Exit;
    end;
  end;
end;

procedure TCustomPivotGridEh.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
end;

procedure TCustomPivotGridEh.SetAxisRowExpandedState(PivotCel: TPivotCellEh; Expanded: Boolean);
begin
  PivotCel.RowsTreeNode.Expanded := Expanded;
end;

procedure TCustomPivotGridEh.CellMouseDown(const Cell: TGridCoord;
  Button: TMouseButton; Shift: TShiftState; const ACellRect: TRect;
  const GridMousePos, CellMousePos: TPoint);
var
  PivotCel: TPivotCellEh;
  StateRect: TRect;
  GroupingSignRect: TRect;
begin
  FDragStarted := False;
  FDragCell := nil;
  inherited CellMouseDown(Cell, Button, Shift, ACellRect, GridMousePos, CellMousePos);
  if (Cell.X < 0) or (Cell.Y < 0) then Exit;

  GroupingSignRect := ACellRect;
  if UseRightToLeftAlignment
    then GroupingSignRect.Left := GroupingSignRect.Right - 18
    else GroupingSignRect.Right := GroupingSignRect.Left + 18;
  if (FVisPivotColCount > Cell.X) and (FVisPivotRowCount > Cell.Y) then
  begin
    PivotCel := VisPivotGridArray[Cell.X, Cell.Y];
    if GetMouseHitCellState(Cell, GridMousePos, ACellRect, StateRect) = dgsFilterButtonDown then
    begin
        if FInTitleFilterListboxVisible
          then FilterFormCloseUp(False)
          else FilterFormDropDown(Cell, ACellRect, StateRect);
    end
    else if (PivotCel.CelType in [sctFieldNameForRowEh, sctFieldNameForColEh]) and
            ((PivotCel.VertAggrLevelRow > 0) or (PivotCel.HorzAggrLevelCol > 0)) and
//            (CellMousePos.X < 18)
            PtInRect(GroupingSignRect, GridMousePos)
    then
    begin
      VisPivotGridArray[Cell.X, Cell.Y].Expanded := not PivotCel.Expanded;
      if PivotCel.VertAggrLevelRow > 0
        then SetColLevelExpanded(PivotCel.VertAggrLevelRow, PivotCel.Expanded, nil)
        else SetRowLevelExpanded(PivotCel.HorzAggrLevelCol, PivotCel.Expanded, nil);
      Invalidate;
    end
    else if (PivotCel.CelType in [sctFieldNameForRowEh, sctFieldNameForColEh]) then
    begin
      FDragCell := PivotCel;
      if PivotCel.PivotField <> nil then
      begin
        if PivotCel.CelType = sctFieldNameForRowEh
          then FDragPos := ActualRowFlds.IndexOf(PivotCel.PivotField.FieldName)
          else FDragPos := ActualColFlds.IndexOf(PivotCel.PivotField.FieldName);
      end;
    end else if (PivotCel.CelType = sctAxisValueEh) and
           (PivotCel.ShowGroupingSign = True) and
//           (CellMousePos.X < 18) then
           PtInRect(GroupingSignRect, GridMousePos) then
    begin
//      SetAxisRowExpandedState(VisPivotGridArray[Cell.X, Cell.Y], not PivotCel.Expanded);
      if Cell.X < ActualRowFlds.Count then
        SetAxisRowExpandedState(PivotCel, not PivotCel.RowsTreeNode.Expanded)
      else
        PivotCel.ColsTreeNode.Expanded := not PivotCel.ColsTreeNode.Expanded;
      Invalidate;
    end;
  end;
end;

procedure TCustomPivotGridEh.CellMouseClick(const Cell: TGridCoord;
  Button: TMouseButton; Shift: TShiftState; const ACellRect: TRect;
  const GridMousePos, CellMousePos: TPoint);
var
  PivotCel: TPivotCellEh;
  CellArea: TCellAreaEh;
  ActualGridArrayIndex: Integer;
  ActualGridArrayRowIndex: Integer;
begin
  inherited CellMouseClick(Cell, Button, Shift, ACellRect, GridMousePos, CellMousePos);
  if ssDouble in Shift then Exit;
  if GridIsEmpty then Exit;

  PivotCel := VisPivotGridArray[Cell.X, Cell.Y];
  if not FDragStarted then
  begin
    if (PivotCel.CelType in [sctFieldNameForRowEh, sctFieldNameForColEh]) and
       (PivotCel.PivotField <> nil) then
    begin
      CellArea := GetCellHitArea(PivotCel, ACellRect, CellMousePos);
      if CellArea = caUnspecifiedEh then
      begin
        FDataSortColNum := -1;
        PivotCel.PivotField.SetNextSortOrder;
        ResortRowSortingTree;
        MakeVisPivotGridArray;
        InvalidateGrid;
      end;
    end else if Cell.Y = FStartDataRow-1 then
    begin
      VisPivotPosToSrcArrayPos(Cell.X, Cell.Y, ActualGridArrayIndex, ActualGridArrayRowIndex);
      if FDataSortColNum = ActualGridArrayIndex  then
      begin
        if FDataSortSortOrder = soAscEh
          then FDataSortSortOrder := soDescEh
          else FDataSortSortOrder := soAscEh;
      end else
      begin
        FDataSortColNum := ActualGridArrayIndex;
        FDataSortSortOrder := soDescEh;
      end;

      ResortRowSortingTree;
      MakeVisPivotGridArray;
      InvalidateGrid;
    end;
  end;
end;

procedure TCustomPivotGridEh.DoStartDrag(var DragObject: TDragObject);
begin
  inherited DoStartDrag(DragObject);
  DragObject := TPivotGridDrabObj.Create(Self);
  TPivotGridDrabObj(DragObject).FDragCell := FDragCell;
end;

procedure TCustomPivotGridEh.DragOver(Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
var
//  ARect: TRect;
//  CellMousePos: TPoint;
  Cell: TGridCoord;
  SizeLinePos: TPoint;
  LineSize: Integer;
begin
  inherited DragOver(Source, X, Y, State, Accept);

  Accept := False;
  Cell := CalcCoordFromPoint(X, Y);
  if (Cell.X >= 0) and (Cell.Y >= 0) then
  begin
//    ARect := CellRect(Cell.X, Cell.Y);
//    CellMousePos := Point(X - ARect.Left, Y - ARect.Top);
    if DragDropHitTestInfo(X, Y, SizeLinePos, LineSize, FDropToPos, FDropToCell) then
    begin
      Accept := True;

      if GetMoveLineEh.Visible
        then GetMoveLineEh.MoveToFor(Self, SizeLinePos)
        else GetMoveLineEh.StartShow(Self, SizeLinePos, True, LineSize, Self);
    end else
      GetMoveLineEh.Hide;
  end
  else if State = dsDragLeave then
    GetMoveLineEh.Hide;
end;

function TCustomPivotGridEh.DragDropHitTestInfo(X, Y: Integer;
  var LinePos: TPoint; var LineSize, DropToPos: Integer;
  var FDragToField: TPivotCellEh): Boolean;
var
  PivotCel: TPivotCellEh;
  ARect: TRect;
  CellMousePos: TPoint;
  OverCell, TargetCell: TGridCoord;
  AxisStringList: TStringList;
begin
  OverCell := CalcCoordFromPoint(X, Y);
  Result := False;
  if (OverCell.X >= 0) and (OverCell.Y >= 0) then
  begin

    if (OverCell.Y = 0) and (OverCell.X >= ActualRowFlds.Count + ActualColFlds.Count) then
    begin
      TargetCell := GridCoord(ActualRowFlds.Count + ActualColFlds.Count - 1, OverCell.Y);
      ARect := CellRect(TargetCell.X, TargetCell.Y);
      CellMousePos := Point(X - ARect.Left, Y - ARect.Top);
      PivotCel := VisPivotGridArray[TargetCell.X, TargetCell.Y];
    end else if (OverCell.Y = 0) and (OverCell.X < ActualRowFlds.Count) then
    begin
      TargetCell := GridCoord(ActualRowFlds.Count, OverCell.Y);
      ARect := CellRect(TargetCell.X, TargetCell.Y);
      CellMousePos := Point(X - ARect.Left, Y - ARect.Top);
      PivotCel := VisPivotGridArray[TargetCell.X, TargetCell.Y];
    end else
    if (OverCell.Y = ActualColFlds.Count) and (OverCell.X >= ActualRowFlds.Count) then
    begin
      TargetCell := GridCoord(ActualRowFlds.Count - 1, OverCell.Y);
      ARect := CellRect(TargetCell.X, TargetCell.Y);
      CellMousePos := Point(X - ARect.Left, Y - ARect.Top);
      PivotCel := VisPivotGridArray[TargetCell.X, TargetCell.Y];
    end else if (OverCell.Y = 0) and (OverCell.X < 0) then
    begin
      TargetCell := GridCoord(0, OverCell.Y);
      ARect := CellRect(TargetCell.X, TargetCell.Y);
      CellMousePos := Point(X - ARect.Left, Y - ARect.Top);
      PivotCel := VisPivotGridArray[TargetCell.X, TargetCell.Y];
    end else
    begin
      TargetCell := OverCell;
      ARect := CellRect(TargetCell.X, TargetCell.Y);
      CellMousePos := Point(X - ARect.Left, Y - ARect.Top);
      PivotCel := VisPivotGridArray[TargetCell.X, TargetCell.Y];
    end;

    if PivotCel.CelType in [sctFieldNameForRowEh, sctFieldNameForColEh] then
    begin
      AxisStringList := nil;
      if FDragCell <> nil then
        if FDragCell.CelType = sctFieldNameForRowEh
          then AxisStringList := ActualRowFlds
          else AxisStringList := ActualColFlds;

      if (AxisStringList <> nil) and (AxisStringList.Count = 0)
        then Result := False
        else Result := True;

      if not Result then Exit;

      LinePos.Y := ARect.Top;
      if CellMousePos.X > (ARect.Right - ARect.Left) div 2
        then LinePos.X := ARect.Right
        else LinePos.X := ARect.Left;

      LineSize := ARect.Bottom-ARect.Top;
      FDragToField := PivotCel;
      if TargetCell.X < ActualRowFlds.Count then
      begin
        if (LinePos.X = ARect.Left) or (PivotDataSource.RowFields.Count = 0)
          then DropToPos := TargetCell.X
          else DropToPos := TargetCell.X + 1;
      end else
      begin
        if (LinePos.X = ARect.Left) or (PivotDataSource.ColumnFields.Count = 0)
          then DropToPos := TargetCell.X - ActualRowFlds.Count
          else DropToPos := TargetCell.X + 1 - ActualRowFlds.Count;
      end;
    end;

  end;
end;

procedure TCustomPivotGridEh.DragDrop(Source: TObject; X, Y: Integer);
var
  SizeLinePos: TPoint;
  LineSize: Integer;
  AxisStringList: TStringList;
  FPivotField: TPivotFieldEh;
begin
  inherited DragDrop(Source, X, Y);
  DragDropHitTestInfo(X, Y, SizeLinePos, LineSize, FDropToPos, FDropToCell);
  if (Source is TPivotGridDrabObj) and (TPivotGridDrabObj(Source).FPivotField <> nil) then
  begin
    FPivotField := TPivotGridDrabObj(Source).FPivotField;
    if FDropToCell.CelType = sctFieldNameForRowEh
      then AxisStringList := PivotDataSource.RowFields
      else AxisStringList := PivotDataSource.ColumnFields;
    if AxisStringList.IndexOfObject(FPivotField) >= 0 then
      Exit;
    AxisStringList.InsertObject(FDropToPos, FPivotField.FieldName, FPivotField);

    StartWait;
    PivotDataSource.BuildGridData;
    StopWait;

  end else if FDragCell <> FDropToCell then
  begin
    if FDragCell.CelType = FDropToCell.CelType then
    begin
      if FDragCell.CelType = sctFieldNameForRowEh
        then AxisStringList := PivotDataSource.RowFields
        else AxisStringList := PivotDataSource.ColumnFields;

      if FDropToPos < FDragPos then
        AxisStringList.Move(FDragPos, FDropToPos)
      else if FDropToPos > FDragPos then
        AxisStringList.Move(FDragPos, FDropToPos-1);
    end else
    begin
      if FDragCell.CelType = sctFieldNameForRowEh then
      begin
        PivotDataSource.RowFields.Delete(PivotDataSource.RowFields.IndexOf(FDragCell.PivotField.FieldName));
        PivotDataSource.ColumnFields.InsertObject(FDropToPos, FDragCell.PivotField.FieldName, FDragCell.PivotField);
      end else
      begin
        PivotDataSource.ColumnFields.Delete(PivotDataSource.ColumnFields.IndexOf(FDragCell.PivotField.FieldName));
        PivotDataSource.RowFields.InsertObject(FDropToPos, FDragCell.PivotField.FieldName, FDragCell.PivotField);
      end;
    end;

    StartWait;
    PivotDataSource.BuildGridData;
    StopWait;

  end;
end;

procedure TCustomPivotGridEh.DoCopyAction;
var
  Sb: TStringStream;
  i, j: Integer;
  PivotCel: TPivotCellEh;
begin
  Sb := TStringStream.Create('');
  try
    if IsMultiSelected then
    begin
      for j := Selection.Top to Selection.Bottom do
      begin
        for i := Selection.Left to Selection.Right do
        begin
          PivotCel := VisPivotGridArray[i, j];
          Sb.WriteString(VarToStr(PivotCel.Value));
          if i <> Selection.Right then
            Sb.WriteString(#09);
        end;
        if j <> Selection.Bottom  then
          Sb.WriteString(sLineBreak);
      end;
      ClipBoard.AsText := Sb.DataString;
    end else
      ClipBoard.AsText := VarToStr(VisPivotGridArray[Col, Row].Value);

  finally
    Sb.Free;
  end;
end;

procedure TCustomPivotGridEh.DoEndDrag(Target: TObject; X, Y: Integer);
begin
  GetMoveLineEh.Hide;
  FDragCell := nil;
  inherited DoEndDrag(Target, X, Y);
end;

procedure TCustomPivotGridEh.FinishDragFrom(Source: TObject);
begin
  GetMoveLineEh.Hide;
end;

function TCustomPivotGridEh.FullRedrawOnSroll: Boolean;
begin
  Result := True;
end;

procedure TCustomPivotGridEh.CurrentCellMoved(OldCurrent: TGridCoord);
begin
  inherited CurrentCellMoved(OldCurrent);
  InvalidateCol(OldCurrent.X);
  InvalidateCol(Col);
  InvalidateRow(OldCurrent.Y);
  InvalidateRow(Row);
  if Assigned(OnCurrentCellMoved) then
    OnCurrentCellMoved(Self, OldCurrent);
end;

procedure TCustomPivotGridEh.WMSize(var Message: TWMSize);
begin
  inherited;
end;

procedure TCustomPivotGridEh.AdjustContraData;
var
  ACliW, ACliH: Integer;
  i, w: Integer;
  GridSizeLarger: Boolean;
begin
  if HandleAllocated then
  begin
    ACliW := GridClientWidth;
    ACliH := GridClientHeight;
  end else
  begin
    ACliW := WIdth;
    ACliH := Height;
  end;

  w := 0;
  GridSizeLarger := False;
  for i := 0 to FullColCount-1 do
  begin
    Inc(w, ColWidths[i]);
    if w > ACliW then
    begin
      GridSizeLarger := True;
      Break;
    end;
  end;

  if GridSizelarger then
  begin
    ColCount := FVisPivotColCount - GrandTotalColCount;
    ContraColCount := GrandTotalColCount;
  end else
  begin
    ColCount := FVisPivotColCount;
    ContraColCount := 0;
  end;

  w := 0;
  GridSizeLarger := False;
  for i := 0 to FullRowCount-1 do
  begin
    Inc(w, RowHeights[i]);
    if w > ACliH then
    begin
      GridSizeLarger := True;
      Break;
    end;
  end;

  if GridSizelarger then
  begin
    RowCount := FVisPivotRowCount - GrandTotalRowCount;
    ContraRowCount := GrandTotalRowCount;
  end else
  begin
    RowCount := FVisPivotRowCount;
    ContraRowCount := 0;
  end;

end;

procedure TCustomPivotGridEh.SetGridSizes(GridSizeChanged: Boolean);
var
  ACliW, ACliH: Integer;
  i, w: Integer;
  GridSizeLarger: Boolean;
  NewContraCols, NewContraRows: Integer;
  NewRowCount, NewColCount: Integer;
begin
  if HandleAllocated then
  begin
    ACliW := ClientWIdth;
    ACliH := ClientHeight;
  end else
  begin
    ACliW := WIdth;
    ACliH := Height;
  end;

  if GrandTotalColVisible and not GridIsEmpty then
    if (ActualValueFields <> nil) and (ActualValueFields.Count > 0) then
      NewContraCols := ActualValueFields.Count
    else
      NewContraCols := 1
  else
    NewContraCols := 0;

  if GrandTotalRowVisible and not GridIsEmpty then
    NewContraRows := 1
  else
    NewContraRows := 0;

  w := 0;
  GridSizeLarger := False;
  if GridSizeChanged then
  begin
    FixedColCount := 0;
    ContraColCount := 0;
    ColCount := FVisPivotColCount;
  end;

  for i := 0 to FullColCount-1 do
  begin
    Inc(w, ColWidths[i] + GridLineWidth);
    if w > ACliW then
    begin
      GridSizeLarger := True;
      Break;
    end;
  end;

  if GridSizelarger then
  begin
    ContraColCount := NewContraCols;
    if not GridIsEmpty and (FVisPivotColCount - 1 <= FixedColCount) then
      FixedColCount := ActualRowFlds.Count;

    NewColCount := FVisPivotColCount - NewContraCols;
  end else
  begin
    ContraColCount := 0;
    NewColCount := FVisPivotColCount;
  end;

  if not GridIsEmpty and (ActualRowFlds <> nil)
    then FixedColCount := ActualRowFlds.Count
    else FixedColCount := 1;
  ColCount := NewColCount;

  w := 0;
  GridSizeLarger := False;
  for i := 0 to FullRowCount-1 do
  begin
    Inc(w, RowHeights[i] + GridLineWidth);
    if w > ACliH then
    begin
      GridSizeLarger := True;
      Break;
    end;
  end;

  if GridSizelarger then
  begin
    ContraRowCount := NewContraRows;
    NewRowCount := FVisPivotRowCount - NewContraCols;
  end else
  begin
    ContraRowCount := 0;
    NewRowCount := FVisPivotRowCount;
  end;
  if NewRowCount <= FixedRowCount + 1
    then RowCount := FixedRowCount + 1
    else RowCount := NewRowCount;

    FixedRowCount := FStartDataRow;
    RowCount := NewRowCount;
end;

procedure TCustomPivotGridEh.GetFilterButtonRect(const ACellRect: TRect;
  var AButtonRect, AGrossRect: TRect; ARightToLeftAlignment: Boolean);
var
  FilterButtonWidth: Integer;
  InplaceEditorButtonHeight: Integer;
  InplaceEditorButtonWidth: Integer;
  AWidth: Integer;
begin

  if True{Flat} then
  begin
    FilterButtonWidth := FlatButtonWidth;
    if not ThemesEnabled then
      Inc(FilterButtonWidth);
  end{ else
    FilterButtonWidth := GetSystemMetrics(SM_CXVSCROLL)};

  if (ACellRect.Right - ACellRect.Left) div 2 < FilterButtonWidth then
    FilterButtonWidth := (ACellRect.Right - ACellRect.Left) div 2;

  AGrossRect := ACellRect;
  AGrossRect.Right := ACellRect.Right;
  AGrossRect.Left := AGrossRect.Right - FilterButtonWidth;
  AButtonRect := AGrossRect;

  if True{not AState.The3DRect} then
  begin
    OffsetRect(AButtonRect, -1, 0);
    if AButtonRect.Top = ACellRect.Top then
      Inc(AButtonRect.Top);
    if AButtonRect.Bottom = ACellRect.Bottom then
      Dec(AButtonRect.Bottom);
  end;

  if Flat
    then InplaceEditorButtonWidth := FlatButtonWidth// + 1
    else InplaceEditorButtonWidth := GetSystemMetrics(SM_CXVSCROLL);

  if DefaultRowHeight > Round(InplaceEditorButtonWidth * 3 / 2)
    then InplaceEditorButtonHeight := DefaultEditButtonHeight(InplaceEditorButtonWidth,  Flat)
    else InplaceEditorButtonHeight := DefaultRowHeight;

  if AButtonRect.Bottom - AButtonRect.Top > InplaceEditorButtonHeight then
  begin
    AButtonRect.Top := (AButtonRect.Bottom + AButtonRect.Top - InplaceEditorButtonHeight) div 2;
    AButtonRect.Bottom := AButtonRect.Top + InplaceEditorButtonHeight;
  end;

  if ARightToLeftAlignment then
  begin
    AWidth := AButtonRect.Right - AButtonRect.Left;
    AButtonRect.Left := ACellRect.Left + (ACellRect.Right - AButtonRect.Right);
    AButtonRect.Right := AButtonRect.Left + AWidth;

    AWidth := AGrossRect.Right - AGrossRect.Left;
    AGrossRect.Left := ACellRect.Left + (ACellRect.Right - AGrossRect.Right);
    AGrossRect.Right := AGrossRect.Left + AWidth;
  end;
end;

procedure TCustomPivotGridEh.DrawFilterButton(var ARect: TRect; AState: TGridDrawState);
var
  FilterButtonRect: TRect;
  FilterButtonGrossRect: TRect;
//  FilterButtonClipRect: TRect;
  ButtonActive: Boolean;
  EditButtonTransparency: Integer;
  ADownButton: Integer;
begin

  GetFilterButtonRect(ARect, FilterButtonRect, FilterButtonGrossRect, False);

  ARect.Right := FilterButtonRect.Left;

//  FilterButtonClipRect := FilterButtonRect;

  ButtonActive := False;
  ADownButton := 0;

  if csDesigning in ComponentState then
    EditButtonTransparency := 30
  else if ((gdHotTrack in AState) and (FHotTrackEditButton = 0) and CanMouseTrackMode)
  then
  begin
    EditButtonTransparency := 0;
    ButtonActive := True;
  end else if (gdHotTrack in AState) and CanMouseTrackMode then
    EditButtonTransparency := 30
  else
    EditButtonTransparency := 80;

  PaintInplaceButton(Canvas, ebsDropDownEh,
    FilterButtonRect,  FilterButtonRect,
    ADownButton, ButtonActive, Flat, True, Canvas.Brush.Color, nil,
    EditButtonTransparency, nil, 0);
end;

procedure TCustomPivotGridEh.EmptyGridData;
var
  PivotCel: TPivotCellEh;
  i,j: Integer;
begin
  FDataSortColNum := -1;
  FStartDataRow := 2;
  FStartDataCol := 1;
  FShowGrandTotalCols := True;
  FShowGrandTotalRows := True;

  SetPivotGridArraySize(3, 4);

  PivotCel := PivotGridArray[0, 0];
  PivotCel.Clear;

  PivotCel := PivotGridArray[1, 0];
  PivotCel.Clear;
  PivotCel.CelType := sctFieldNameForColEh;

  PivotCel := PivotGridArray[0, 1];
  PivotCel.Clear;
  PivotCel.CelType := sctFieldNameForRowEh;

  PivotCel := PivotGridArray[1, 1];
  PivotCel.Clear;
  PivotCel.CelType := sctAxisValueEh;

  PivotCel := PivotGridArray[0, 2];
  PivotCel.Clear;
  PivotCel.CelType := sctAxisValueEh;

  PivotCel := PivotGridArray[1, 2];
  PivotCel.Clear;
  PivotCel.CelType := sctDataEh;
  PivotCel.ShowValue := False;

  FVisPivotColCount := 3;
  FVisPivotRowCount := 4;

//  MakeVisPivotGridArray;
  for i := 0 to Length(PivotGridArray)-1 do
    for j := 0 to Length(PivotGridArray[i])-1 do
      FVisPivotGridArray[i, j] := PivotGridArray[i, j];
//  SetGridSizes(True);
  ContraColCount := 0;
  ContraRowCount := 0;
  FixedColCount := 1;
  FixedRowCount := 1;
  RolColCount := 2;
  RolRowCount := 3;
  InvalidateGrid;

  if HandleAllocated then
  begin
    Canvas.Font.Size := Font.Size;
    DefaultRowHeight := Canvas.TextHeight('Wg') + 4;
    for i := 0 to FullRowCount-1 do
      RowHeights[i] := DefaultRowHeight;
    for i := 0 to FullColCount-1 do
      ColWidths[i] := DefaultRowHeight * 3;
  end;
end;

function TCustomPivotGridEh.CanMouseTrackMode: Boolean;
begin
  Result := (FGridState = gsNormalEh);
end;

procedure TCustomPivotGridEh.Paint;
begin
  SetLength(FDrawenCellArr, 0);
  inherited Paint;
  DrawTopGroupRowValues;
  if (PivotFields = nil) or (PivotFields.Count = 0) then
    PaintEmptyDataInfo;
end;

procedure TCustomPivotGridEh.PaintEmptyDataInfo;
var
  w, h: Integer;
  ts: TSize;
  AText: String;
  ADrawRect: TRect;
begin
  AText := '<Data is no loaded>';

  w := Width;
  h := Height;

  Canvas.Font := Font;

  ts := Canvas.TextExtent(AText);
  ts.cy := ts.cy + 2;

  ADrawRect := Bounds((w shr 1) - (ts.cx shr 1), (h shr 1) - (ts.cy shr 1), ts.cx, ts.cy);

  InflateRect(ADrawRect, 5, 5);
  Canvas.Brush.Color := Color;
  WriteTextEh(Canvas, ADrawRect, True, 6, 6, AText, taCenter, tlCenter,
    False, False, 0, 0, UseRightToLeftAlignment, True);
end;

procedure TCustomPivotGridEh.PaintInplaceButton(Canvas: TCanvas;
  ButtonStyle: TEditButtonStyleEh; Rect, ClipRect: TRect;
  DownButton: Integer; Active, Flat, Enabled: Boolean; ParentColor: TColor;
  Bitmap: TBitmap; TransparencyPercent: Byte; imList: TCustomImageList;
  ImageIndex: Integer);
const
  ButtonStyleFlags: array[TEditButtonStyleEh] of TDrawButtonControlStyleEh =
  (bcsDropDownEh, bcsEllipsisEh, bcsUpDownEh, bcsUpDownEh, bcsPlusEh, bcsMinusEh,
   bcsAltDropDownEh, bcsAltUpDownEh);
var
  LineRect: TRect;
  Brush: HBRUSH;
  IsClipRgn: Boolean;
  Rgn, SaveRgn: HRgn;
  r: Integer;
  NewBM: TBitmap;
  bf : BLENDFUNCTION;
  DestCanvas: TCanvas;
  IntersectedRect: TRect;
begin
  NewBM := nil;
  IntersectedRect := EmptyRect;
  DestCanvas := Canvas;
  if TransparencyPercent > 0 then
  begin
    NewBM := GetInplaceBitmap(Width, Height);
    DestCanvas := NewBM.Canvas;
    IntersectRect(IntersectedRect, Rect, ClipRect);
    Canvas.Brush.Color := ParentColor;
    Canvas.FillRect(IntersectedRect);
  end;

  IsClipRgn := (Rect.Left < ClipRect.Left) or (Rect.Right > ClipRect.Right) or
    (Rect.Bottom > ClipRect.Bottom) or (Rect.Top < ClipRect.Top);
  r := 0; SaveRgn := 0;
  if IsClipRgn then
  begin
    SaveRgn := CreateRectRgn(0, 0, 0, 0);
    r := GetClipRgn(DestCanvas.Handle, SaveRgn);
    with ClipRect do
      Rgn := CreateRectRgn(Left, Top, Right, Bottom);
    SelectClipRgn(DestCanvas.Handle, Rgn);
    DeleteObject(Rgn);
  end;

  if Flat and not ThemesEnabled then 
  begin
    LineRect := Rect;
    {if AxisBar.UseRightToLeftAlignment then
    begin
      LineRect.Right := LineRect.Left;
      LineRect.Left := LineRect.Left + 1;
    end else}
      LineRect.Right := LineRect.Left + 1;
    Inc(Rect.Left, 1);
    if Active then
      FrameRect(DestCanvas.Handle, LineRect, GetSysColorBrush(COLOR_BTNFACE))
    else
    begin
      Brush := CreateSolidBrush(ColorToRGB(ParentColor));
      FrameRect(DestCanvas.Handle, LineRect, Brush);
      DeleteObject(Brush);
    end;
  end;
  if Self.UseRightToLeftAlignment and (DestCanvas = Canvas) then
  begin
    WindowsLPtoDP(DestCanvas.Handle, Rect);
    SwapInt(Rect.Left, Rect.Right);
    ChangeGridOrientation(False);
  end;

  if ButtonStyle = ebsGlyphEh then
  begin
    if Flat and not ThemesEnabled then
    begin
      Brush := CreateSolidBrush(ColorToRGB(ParentColor));
      FrameRect(DestCanvas.Handle, Rect, Brush);
      DeleteObject(Brush);
      InflateRect(Rect, -1, -1);
      FillRect(DestCanvas.Handle, Rect, GetSysColorBrush(COLOR_BTNFACE));
    end else
    begin
      DrawUserButtonBackground(DestCanvas, Rect, clWindow,
        Enabled, Active, Flat, DownButton<>0);
//      DrawEdge(DestCanvas.Handle, Rect, EDGE_RAISED, BF_RECT or BF_MIDDLE);
      InflateRect(Rect, -2, -2);
    end;
    if  (imList <> nil) then
      DrawClipped(imList, Bitmap, DestCanvas, Rect, ImageIndex, 0, taCenter, Rect)
    else
      DrawClipped(nil, Bitmap, DestCanvas, Rect, 0, 0, taCenter, Rect);
    //DestCanvas.Draw(Rect.Left,Rect.Top,Bitmap)
  end
  else
    PaintButtonControlEh(DestCanvas, Rect, ParentColor, ButtonStyleFlags[ButtonStyle],
      DownButton, Flat, Active, Enabled, cbUnchecked);

  if Self.UseRightToLeftAlignment and (DestCanvas = Canvas) then
    ChangeGridOrientation(True);

  if IsClipRgn then
  begin
    if r = 0
      then SelectClipRgn(DestCanvas.Handle, 0)
      else SelectClipRgn(DestCanvas.Handle, SaveRgn);
    DeleteObject(SaveRgn);
  end;

  if TransparencyPercent > 0 then
  begin
    bf.BlendOp := AC_SRC_OVER;
    bf.BlendFlags := 0;
    bf.SourceConstantAlpha := Trunc(255/100*(100-TransparencyPercent));
    bf.AlphaFormat := 0;
    AlphaBlend(Canvas.Handle,
      IntersectedRect.Left, IntersectedRect.Top,
      IntersectedRect.Right-IntersectedRect.Left, IntersectedRect.Bottom-IntersectedRect.Top,
      NewBM.Canvas.Handle,
      IntersectedRect.Left, IntersectedRect.Top,
      IntersectedRect.Right-IntersectedRect.Left, IntersectedRect.Bottom-IntersectedRect.Top,
      bf);
//    FreeAndNil(NewBM);
  end;
end;

procedure TCustomPivotGridEh.Resize;
begin
  inherited Resize;
  if GridTextIsVisible then
    Invalidate;
  if FGridCellParams <> nil then
    AdjustContraData;
end;

function TCustomPivotGridEh.DataSourceIsEmpty: Boolean;
begin
  Result := (PivotDataSource = nil) or PivotDataSource.DataIsEmpty;
end;

procedure TCustomPivotGridEh.GridCellParamsChanged;
begin
  SetRowHeightsColumnWidths;
end;

function TCustomPivotGridEh.GridIsEmpty: Boolean;
begin
  Result := DataSourceIsEmpty {or FGridIsEmptyStatus};
end;

function TCustomPivotGridEh.GridTextIsVisible: Boolean;
begin
  if PivotFields <> nil
    then Result := (PivotFields.Count = 0)
    else Result := False;
end;

function TCustomPivotGridEh.CanHotTackCell(X, Y: Integer): Boolean;
begin
  Result := True;
end;

function TCustomPivotGridEh.GetMouseHitCellState(Cell: TGridCoord;
  MousePos: TPoint; CellRect: TRect;
  var StateRect: TRect): TSpicGridStateEh;
var
  FilterButtonRect: TRect;
  FilterButtonGrossRect: TRect;
  PivotCel: TPivotCellEh;
begin
  Result := dgsNormal;
  PivotCel := VisPivotGridArray[Cell.X, Cell.Y];
  if PivotCel.CelType in [sctFieldNameForRowEh, sctFieldNameForColEh] then
  begin
    GetFilterButtonRect(CellRect, FilterButtonRect, FilterButtonGrossRect, UseRightToLeftAlignment);
    if PtInRect(FilterButtonRect, MousePos) then
    begin
      Result := dgsFilterButtonDown;
      StateRect := FilterButtonRect;
    end;
  end;
end;

procedure TCustomPivotGridEh.VisPivotPosToSrcArrayPos(AVisCol, AVisRow: Integer;
  var ASrcCol, ASrcRow: Integer);
var
  NewIndex: Integer;
begin
  if DataSourceIsEmpty then
  begin
    ASrcCol := AVisCol;
    ASrcRow := AVIsRow;
    Exit;
  end;

  if AVisCol < FStartDataCol then
    ASrcCol := AVisCol
  else if AVisCol >= ColsAxisTree.FlatListCount * ActualValueFields.Count + FStartDataCol then
  begin
    NewIndex := (AVisCol - (ColsAxisTree.FlatListCount * ActualValueFields.Count + FStartDataCol));
    ASrcCol := Length(PivotGridArray) - GrandTotalColCount + NewIndex;
  end else
    ASrcCol := ColsAxisTree.FlatList[(AVisCol - FStartDataCol) div ActualValueFields.Count].AxisPos +
               FStartDataCol +
               (AVisCol - FStartDataCol) mod ActualValueFields.Count;

  if AVisRow < FStartDataRow then
    ASrcRow := AVisRow
  else if AVisRow >= RowsAxisTree.FlatListCount + FStartDataRow then
    ASrcRow := Length(PivotGridArray[0]) - 1 - (AVisRow - (RowsAxisTree.FlatListCount + FStartDataRow))
  else
    ASrcRow := RowsAxisTree.FlatList[AVisRow-FStartDataRow].AxisPos + FStartDataRow;

end;

function TCustomPivotGridEh.GetVisPivotGridArray(ACol, ARow: Integer): TPivotCellEh;
var
  ANewCol: Integer;
  ANewRow: Integer;
begin
  VisPivotPosToSrcArrayPos(ACol, ARow, ANewCol, ANewRow);
  Result := PivotGridArray[ANewCol, ANewRow];
end;

function TCustomPivotGridEh.GetPivotRowSortedGridArray(ACol,
  ARow: Integer): TPivotCellEh;
var
  ANewRow: Integer;
begin
  if (ARow < FStartDataRow) or (ARow = Length(PivotGridArray[0])-1) then
    ANewRow := ARow
  else
    ANewRow := RowsAxisTree.FlatList[ARow-FStartDataRow].AxisPos + FStartDataRow;
  Result := PivotGridArray[ACol, ANewRow]
end;

function TCustomPivotGridEh.GetSourcePivotFields: TPivotFieldsEh;
begin
  if PivotDataSource <> nil
    then Result := PivotDataSource.PivotFields
    else Result := nil;
end;

function TCustomPivotGridEh.GetActualColFlds: TStringList;
begin
  if PivotDataSource <> nil
    then Result := PivotDataSource.ActualColFlds
    else Result := nil;
end;

function TCustomPivotGridEh.GetActualRowFlds: TStringList;
begin
  if PivotDataSource <> nil
    then Result := PivotDataSource.ActualRowFlds
    else Result := nil;
end;

function TCustomPivotGridEh.GetActualValueFields: TValueFieldsCollectionEh;
begin
  if PivotDataSource <> nil
    then Result := PivotDataSource.ActualValueFields
    else Result := nil;
end;


procedure TCustomPivotGridEh.FilterListboxDropDown(Cell: TGridCoord;
  const CellRect, ButtonRect: TRect);
var
  List: TPopupListboxEh;
  NewWidth: Integer;
  P: TPoint;
  ADropDownAlign: TDropDownAlign;
  ForRect: TRect;
  PivotCel: TPivotCellEh;
begin
  List := GetInTitleFilterListbox;
  NewWidth := 100;
  FTrackingStateRect := ButtonRect;
  PivotCel := VisPivotGridArray[Cell.X, Cell.Y];
  List.Items.Clear;
  if (PivotCel.CelType in [sctFieldNameForRowEh, sctFieldNameForColEh]) and (PivotCel.PivotField <> nil) then
  begin
    PivotCel.PivotField.FillFilterValues(List.Items);
    FInTitleFilterPivotField := PivotCel.PivotField;
    PivotCel.PivotField.UpdateValuesCheckingStateFromFilter(List.Items, PivotCel.PivotField.FListValuesCheckingState);
  end else
    FInTitleFilterPivotField := nil;
  if NewWidth > CellRect.Right-CellRect.Left
    then List.Width := NewWidth
    else List.Width := CellRect.Right-CellRect.Left;
  List.Color := Self.Color;
  List.Font := Self.Font;
  List.ItemHeight := List.GetTextHeight;
  ForRect.TopLeft := Self.ClientToScreen(CellRect.TopLeft);
  ForRect.BottomRight := Self.ClientToScreen(CellRect.BottomRight);
  if UseRightToLeftAlignment
    then ADropDownAlign := daRight
    else ADropDownAlign := daLeft;
  P := AlignDropDownWindowRect(ForRect, List, ADropDownAlign);

  List.SetBounds(P.X, P.Y, List.Width, List.Height);
  List.Visible := True;

  FInTitleFilterListboxVisible := True;
  List.SizeGripResized := False;
end;

procedure TCustomPivotGridEh.FilterListboxCloseUp(Accept: Boolean);
var
  List: TPopupListboxEh;
begin
  if FInTitleFilterListboxVisible then
  begin
    List := FInTitleFilterListbox;
    if GetCapture <> 0 then SendMessage(GetCapture, WM_CANCELMODE, 0, 0);
    SetWindowPos(List.Handle, 0, 0, 0, 0, 0, SWP_NOZORDER or
      SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_HIDEWINDOW);
    List.Visible := False;
    {if List.SizeGripResized then
    begin
      FInTitleFilterListboxColumn.STFilter.FDropDownListRows := List.RowCount;
      FInTitleFilterListboxColumn.STFilter.FDropDownListWidth := List.Width;
    end;}
    if (GetFocus = List.Handle) then
      SetFocus;
    FInTitleFilterListboxVisible := False;
    FTrackingStateRect := EmptyRect;
  end;
end;

function TCustomPivotGridEh.GetInTitleFilterListbox: TPopupListboxEh;
begin
  if FInTitleFilterListbox = nil then
  begin
    FInTitleFilterListbox := TPopupListboxEh.Create(Self);
    FInTitleFilterListbox.UseItemObjects := True;
    FInTitleFilterListbox.Visible := False;
    {$IFDEF FPC}
    {$ELSE}
    FInTitleFilterListbox.Ctl3D := True;
    {$ENDIF}
    FInTitleFilterListbox.Parent := Self; 
    ShowWindow(FInTitleFilterListbox.Handle, SW_HIDE); 
    FInTitleFilterListbox.OnMouseUp := InTitleFilterListMouseUp;
    FInTitleFilterListbox.OnKeyDown := InTitleFilterListKeyDown;
    FInTitleFilterListbox.OnKeyPress := InTitleFilterListKeyPress;
  end;
  Result := FInTitleFilterListbox;
end;

procedure TCustomPivotGridEh.InTitleFilterListKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin

end;

procedure TCustomPivotGridEh.InTitleFilterListKeyPress(Sender: TObject;
  var Key: Char);
begin

end;

procedure TCustomPivotGridEh.InTitleFilterListMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin

end;

function TCustomPivotGridEh.GetInTitleFilterForm: TFilterDropDownForm;
begin
  Result := GetFilterDropDownFormProc();
end;

procedure TCustomPivotGridEh.FilterFormDropDown(Cell: TGridCoord;
  const CellRect, ButtonRect: TRect);
var
  ForRect: TRect;
  PivotCel: TPivotCellEh;
  ADropDownForm: TFilterDropDownForm;
//  ADropDownAlign: TDropDownAlign;
  TheMsg: Windows.TMsg;
  DDParams: TDynVarsEh;
  SysParams: TEditControlDropDownFormSysParams;
  IntDropDownForm: IDropDownFormEh;
  DropDownAlign: TDropDownAlign;
begin
  FTrackingStateRect := ButtonRect;
  PivotCel := VisPivotGridArray[Cell.X, Cell.Y];

  if PeekMessage(TheMsg, Handle, WM_USER, WM_USER, PM_NOREMOVE) then
    if (TheMsg.wParam = WPARAM(Handle)) and
       (TheMsg.lParam = LPARAM(PivotCel))
    then
      Exit;

  ADropDownForm := GetInTitleFilterForm;

  if (PivotCel.CelType in [sctFieldNameForRowEh, sctFieldNameForColEh]) and
     (PivotCel.PivotField <> nil) and
     (PivotCel.PivotField <> DummyPivotField) then
  begin

    ADropDownForm.BaseList.Clear;
    PivotCel.PivotField.FillFilterValues(ADropDownForm.BaseList);
    ADropDownForm.InitDataForBaseList;
    PivotCel.PivotField.UpdateValuesCheckingStateFromFilter(
      ADropDownForm.BaseList, ADropDownForm.ListValuesCheckingState);

    FInTitleFilterPivotField := PivotCel.PivotField;
  end else
    FInTitleFilterPivotField := nil;

  ForRect.TopLeft := Self.ClientToScreen(CellRect.TopLeft);
  ForRect.BottomRight := Self.ClientToScreen(CellRect.BottomRight);

  DDParams := TDynVarsEh.Create(Self);
  SysParams := TEditControlDropDownFormSysParams.Create;

  SysParams.FreeFormOnClose := False;
  SysParams.FEditControl := Self;
  SysParams.FEditButton := nil;
  SysParams.FEditButtonObj := PivotCel;

  if Supports(ADropDownForm, IDropDownFormEh, IntDropDownForm) then
    IntDropDownForm.ReadOnly := False;

  ADropDownForm.BiDiMode := BidiMode;

  if Supports(ADropDownForm, IDropDownFormEh, IntDropDownForm) then
  begin

{    if Column.STFilter.FDropDownFormParams.SaveFormSize then
    begin
      Column.STFilter.FDropDownFormParams.OldFormWidth := ADropDownForm.Width;
      if Column.STFilter.FDropDownFormParams.FormWidth > 0 then
      begin
        ADropDownForm.Width := Column.STFilter.FDropDownFormParams.FormWidth;
      end;
      Column.STFilter.FDropDownFormParams.OldFormHeight := ADropDownForm.Height;
      if Column.STFilter.FDropDownFormParams.FormHeight > 0 then
      begin
        ADropDownForm.Height := Column.STFilter.FDropDownFormParams.FormHeight;
      end;
    end;
}


    if UseRightToLeftAlignment
      then DropDownAlign := daRight
      else DropDownAlign := daLeft;
    IntDropDownForm.ExecuteNomodal(ForRect, nil, DropDownAlign, DDParams, SysParams,
      InTitleFilterDropDownFormCallbackProc);
  end;

end;

procedure TCustomPivotGridEh.FilterFormCloseUp(Accept: Boolean);
begin

end;

procedure TCustomPivotGridEh.InTitleFilterDropDownFormCallbackProc(
  DropDownForm: TCustomForm; Accept: Boolean; DynParams: TDynVarsEh;
  SysParams: TDropDownFormSysParams);
var
  RefButtonObj: TObject;
  PivotCel: TPivotCellEh;
  FilterDropDownForm: TFilterDropDownForm;
begin
  RefButtonObj := TEditControlDropDownFormSysParams(SysParams).FEditButtonObj;
  if RefButtonObj <> nil then
    PostMessage(Handle, WM_USER, WPARAM(Handle), LPARAM(RefButtonObj));
  DynParams.Free;
  SysParams.Free;
  FInTitleFilterListboxVisible := False;

  if Accept then
  begin
    FilterDropDownForm := TFilterDropDownForm(DropDownForm);
    PivotCel := TPivotCellEh(RefButtonObj);
    PivotCel.PivotField.UpdateFilterFromValuesCheckingState(
      FilterDropDownForm.BaseList, FilterDropDownForm.ListValuesCheckingState);
    PivotDataSource.SetDataFilter;
  end;

  Invalidate;
end;

{$IFDEF FPC}
{$ELSE}
procedure TCustomPivotGridEh.CMCancelMode(var Message: TCMCancelMode);

  function CheckDataListChilds: Boolean;
  var i: Integer;
  begin
    Result := False;
    if FInTitleFilterListbox <> nil then
      for i := 0 to FInTitleFilterListbox.ControlCount - 1 do
        if FInTitleFilterListbox.Controls[I] = Message.Sender then
        begin
          Result := True;
          Exit;
        end;
  end;

begin
  inherited;
  if FInTitleFilterListboxVisible then
    if (Message.Sender = Self) then
    begin
      if not PtInRect(FTrackingStateRect, ScreenToClient(SafeGetMouseCursorPos)) then
        FilterListboxCloseUp(False);
    end else if (Message.Sender <> Self) and {not ContainsControl(Message.Sender) and}
      (Message.Sender <> FInTitleFilterListbox) and not CheckDataListChilds
    then
      FilterListboxCloseUp(False);
end;
{$ENDIF}

procedure TCustomPivotGridEh.CMFontChanged(var Message: TMessage);
begin
  inherited;
  GridCellParams.RefreshDefaultDataAggregateFont;
  GridCellParams.RefreshDefaultDataFont;
  GridCellParams.RefreshDefaultFieldNameFont;
  GridCellParams.RefreshDefaultAxisFont;
  GridCellParamsChanged;
end;

function TCustomPivotGridEh.GrandTotalColCount: Integer;
begin
  if FShowGrandTotalCols then
  begin
    if GridIsEmpty
      then Result := 1
      else Result := ActualValueFields.Count;
  end else
    Result := 0;
end;

function TCustomPivotGridEh.GrandTotalRowCount: Integer;
begin
  if FShowGrandTotalRows
    then Result := 1
    else Result := 0;
end;

function TCustomPivotGridEh.GrandTotalColVisible: Boolean;
begin
  Result := FShowGrandTotalCols;
end;

function TCustomPivotGridEh.GrandTotalRowVisible: Boolean;
begin
  Result := FShowGrandTotalRows;
end;

procedure TCustomPivotGridEh.GetValueFieldsInfoFromCommaText(
  ACommaText: String);
begin
{ TODO : Do This }
end;

procedure TCustomPivotGridEh.CMHintShow(var Message: TCMHintShow);
begin
  inherited;
end;

procedure TCustomPivotGridEh.SelectionChanged(const OldSel: TGridRect);
begin
  inherited SelectionChanged(OldSel);
  TPivotGridScrollBarPanelControl(HorzScrollBarPanelControl).GridSelectionChanged;
end;

function TCustomPivotGridEh.GetEditText(ACol, ARow: Integer): string;
var
  PivotCel: TPivotCellEh;
begin
  PivotCel := VisPivotGridArray[ACol, ARow];
  if PivotCel <> nil then
    Result := VarToStrDef(PivotCel.Value, '');
end;

procedure TCustomPivotGridEh.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if ([ssShift, ssAlt, ssCtrl] * Shift = [ssCtrl]) and
      (Key in [VK_INSERT, Word('C')]) then
  begin
    DoCopyAction;
  end;
end;

procedure TCustomPivotGridEh.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  if EditorMode then
    Key := #0;
end;

function TCustomPivotGridEh.CreateGridLineColors: TGridLineColorsEh;
begin
  Result := TPivotGridLineParamsEh.Create(Self);
end;

function TCustomPivotGridEh.GetGridLineParams: TPivotGridLineParamsEh;
begin
  Result := TPivotGridLineParamsEh(inherited GridLineColors);
end;

function TCustomPivotGridEh.GetGridCellParams: TPivotGridCellParamsEh;
begin
  Result := FGridCellParams;
end;

procedure TCustomPivotGridEh.SetGridCellParams(const Value: TPivotGridCellParamsEh);
begin
  FGridCellParams.Assign(Value);
end;

function TCustomPivotGridEh.CreateGridCellParams: TPivotGridCellParamsEh;
begin
  Result := TPivotGridCellParamsEh.Create(Self);
end;

procedure TCustomPivotGridEh.SetGridLineParams(const Value: TPivotGridLineParamsEh);
begin
  GridLineColors := Value;
end;

function TCustomPivotGridEh.GetOptions: TPivotGridOptionsEh;
begin
  Result := FOptions;
end;

procedure TCustomPivotGridEh.SetOptions(const Value: TPivotGridOptionsEh);
begin
  if FOptions <> Value then
  begin
    FOptions := Value;
    inherited Options := GetValueForInheritedOptions;
  end;
end;

function TCustomPivotGridEh.GetValueForInheritedOptions: TGridOptionsEh;
begin
  Result := [
    goFixedVertLineEh, goFixedHorzLineEh, goVertLineEh, goHorzLineEh,
    goDrawFocusSelectedEh,
    goContraVertBoundaryLineEh, goContraHorzBoundaryLineEh,
    goRangeSelectEh];
  if pgoRowSizingEh in Options then
    Result := Result +[goRowSizingEh];
  if pgoColSizingEh in Options then
    Result := Result +[goColSizingEh];
  if pgoEditingEh in Options then
    Result := Result +[goEditingEh];
  if pgoWantTabEh in Options then
    Result := Result +[goTabsEh];
end;

procedure TCustomPivotGridEh.SetRowLines(const Value: Integer);
begin
  if Value <> FRowLines then
  begin
    FRowLines := Value;
    SetRowHeightsColumnWidths;
  end;
end;

procedure TCustomPivotGridEh.SetRowHeight(const Value: Integer);
begin
  if Value <> FRowHeight then
  begin
    FRowHeight := Value;
    SetRowHeightsColumnWidths;
  end;
end;

function TCustomPivotGridEh.GetDefaultColWidth: Integer;
begin
  Result := inherited DefaultColWidth;
end;

procedure TCustomPivotGridEh.SetDefaultColWidth(const Value: Integer);
begin
  inherited DefaultColWidth := Value;
  SetRowHeightsColumnWidths;
end;

function TCustomPivotGridEh.FixedColsSizingAllowed: Boolean;
begin
  Result := True;
end;

function TCustomPivotGridEh.CheckCellAreaDrawn(ACol, ARow: Integer): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to Length(FDrawenCellArr)-1 do
    if (FDrawenCellArr[i].X = ACol) and (FDrawenCellArr[i].Y = ARow) then
    begin
      Result := True;
      Break;
    end;
end;

procedure TCustomPivotGridEh.SetCellDrawn(ACol, ARow: Integer);
var
  NewPos: Integer;
begin
  NewPos := Length(FDrawenCellArr);
  SetLength(FDrawenCellArr, NewPos+1);
  FDrawenCellArr[NewPos].X := ACol;
  FDrawenCellArr[NewPos].Y := ARow;
end;

{ TPivotCellEh }

procedure TPivotCellEh.Clear;
begin
  CelType := sctEmptyEh;
  Value := Unassigned;
  SetLength(ArrayValue, 0);
  DrawDownLine := True;
  DrawRightLine := True;
  HorzAggrLevelCol := 0;
  HorzAggrLevelRow := 0;
  VertAggrLevelCol := 0;
  VertAggrLevelRow := 0;
  RowVisible := True;
  ColVisible := True;
  Expanded := True;
  ShowValue := True;
  ShowGroupingSign := False;
  DrawFilterButton := False;
  PivotField := nil;
  MasterCol := -1;
  MasterRow := -1;
  RowsTreeNode := nil;
  VisRowsGroupFlatNodePos := -1;
  ColsTreeNode := nil;
  VisColsGroupFlatNodePos := -1;
end;

{ TPivotFieldEh }

constructor TPivotFieldEh.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FTypeDef := TPivotFieldDataTypeDefEh.Create;
end;

destructor TPivotFieldEh.Destroy;
begin
  FreeAndNil(FTypeDef);
  inherited Destroy;
end;

function TPivotFieldEh.GetDisplayName: String;
begin
  if FDisplayName = ''
    then Result := FieldName
    else Result := FDisplayName;
end;

procedure TPivotFieldEh.SetDisplayName(const Value: String);
begin
  FDisplayName := Value;
end;

function TPivotFieldEh.IsDisplayNameStored: Boolean;
begin
  Result := (FieldName <> DisplayName);
end;

procedure TPivotFieldEh.SetDisplayFormat(const Value: String);
begin
  if FDisplayFormat <> Value then
  begin
    FDisplayFormat := Value;
    Changed(False);
  end;
end;

procedure TPivotFieldEh.SetFieldName(const Value: String);
begin
  if FFieldName <> Value then
  begin
    FFieldName := Value;
    Changed(False);
  end;
end;

procedure TPivotFieldEh.SetExpression(const Value: TSTFilterExpressionEh);
begin
  FExpression := Value;
end;

function TPivotFieldEh.GetExpression: TSTFilterExpressionEh;
begin
  Result := FExpression;
end;

{
procedure TPivotFieldEh.SetLookupList(const Value: TDataSet);
begin
  if FLookupList <> Value then
  begin
    FLookupList := Value;
    if FLookupList <> nil then
      PivotFields.PDSource.FreeNotification(FLookupList);
  end;
end;
}

function TPivotFieldEh.GetValueForSource(SourceDataSet: TDataSet; Field: TField): Variant;
var
  DataValue: TDateTime;
  AYear, AMonth, ADay, AHour, AMinute, ASecond, AMilliSecond: Word;
begin
  if Field <> nil
    then Result := Field.Value
    else Result := Null;
//    else Result := SourceDataSet.FieldByName(SourceFieldName).Value;
  if (SliceLevel <> dtslNonEh) and not VarIsNull(Result) then
  begin
    DataValue := VarToDateTime(Result);
    DecodeDateTime(DataValue, AYear, AMonth, ADay, AHour, AMinute, ASecond, AMilliSecond);
//    TimeStampValue := DateTimeToSQLTimeStamp(DataValue);
    case SliceLevel of
      dtslYearEh:
      begin
        AMonth := 1;
        ADay := 1;
        AHour := 0;
        AMinute := 0;
        ASecond := 0;
        AMilliSecond := 0;
      end;
      dtslMonthEh:
      begin
        ADay := 1;
        AHour := 0;
        AMinute := 0;
        ASecond := 0;
        AMilliSecond := 0;
      end;
      dtslDayEh:
      begin
        AHour := 0;
        AMinute := 0;
        ASecond := 0;
        AMilliSecond := 0;
      end;
    end;
    Result := EncodeDateTime(AYear, AMonth, ADay, AHour, AMinute, ASecond, AMilliSecond);
//    Result := SQLTimeStampToDateTime(TimeStampValue);
  end;
end;

function TPivotFieldEh.GetPivotFields: TPivotFieldsEh;
begin
  Result := TPivotFieldsEh(Collection);
end;

procedure TPivotFieldEh.InternalSetExpressionStr(const Value: String);
begin
  ParseExpression(Value);
  FExpressionStr := Value;
end;

function TPivotFieldEh.ParseExpression(const Exp: String): String;
var
  DefaultOperator: TSTFilterDefaultOperatorEh;
begin
  Result := '';
  if FieldName <> ''
    then FExpression.ExpressionType := STFldTypeMapEh[PivotFields.PDSource.BaseTable.FieldByName(FieldName).DataType]
    else FExpression.ExpressionType := botNon;
  DefaultOperator := fdoAuto;

  ParseSTFilterExpressionEh(Exp, FExpression, DefaultOperator);
end;

procedure TPivotFieldEh.FillFilterValues(Items: TStrings);
var
  FieldValueList: IMemTableDataFieldValueListEh;
  FieldValues: TStrings;
  i: Integer;
  IntMemTable: IMemTableEh;
begin
  if not Supports(PivotFields.PDSource.BaseTable, IMemTableEh, IntMemTable) then Exit;
  FieldValueList := IntMemTable.GetFieldValueList(FieldName);

  FieldValues := FieldValueList.GetValues;
  for i := 0 to FieldValues.Count - 1 do
    Items.AddObject(FieldValues[i], nil);

  SetLength(FListValuesCheckingState, 0);
  SetLength(FListValuesCheckingState, Items.Count);
end;

procedure TPivotFieldEh.UpdateFilterFromValuesCheckingState(ss: TStrings;
  CheckStates: TBooleanDynArray);
var
  FilterStr: String;
  i,k: Integer;
  DataOpType: TSTOperandTypeEh;
  sv: String;
  IncludeCheckNull: Boolean;
begin
  k := 0;
  FilterStr := '';
  IncludeCheckNull := False;
  if FieldName <> ''
    then DataOpType := STFldTypeMapEh[PivotFields.PDSource.BaseTable.FieldByName(FieldName).DataType]
    else DataOpType := botNon;

  for i := 0 to Length(CheckStates)-1 do
  begin
    if ss.Objects[i] is TDDFormListboxItemEhData then
      if CheckStates[i] = True then
      begin
        sv := StringReplace(ss[i], '''', '''''',[rfReplaceAll]);
        if (DataOpType in [botNumber, botDateTime, botBoolean]) and (sv = '') then
        begin
          IncludeCheckNull := True;
        end else
        begin
          if FilterStr <> '' then FilterStr := FilterStr + ',';
          FilterStr := FilterStr + '''' + sv + '''';
          Inc(k);
        end;
      end;
  end;
  if FilterStr <> '' then
    if k = 1
      then FilterStr := '=' + FilterStr
      else FilterStr := 'in (' + FilterStr + ')';
  if IncludeCheckNull then
    if FilterStr = ''
      then FilterStr := '=Null'
      else FilterStr := FilterStr + ' OR =Null ';
  InternalSetExpressionStr(FilterStr);

end;

procedure TPivotFieldEh.UpdateValuesCheckingStateFromFilter(ss: TStrings;
  CheckStates: TBooleanDynArray);
var
  i, si: Integer;
  v: Variant;
  vs, ssk: String;
begin
  if Expression.Operator1 = foIn then
    if VarIsArray(Expression.Operand1) then
    begin
      v := VarArrayCreate([0, VarArrayHighBound(Expression.Operand1, 1)], varVariant);
      for i := VarArrayLowBound(Expression.Operand1, 1) to VarArrayHighBound(Expression.Operand1, 1) do
        v[i] := Expression.Operand1[i];
    end else
    begin
      v := VarArrayCreate([0, 0], varVariant);
      v[0] := Expression.Operand1;
    end
  else if Expression.Operator1 = foEqual then
  begin
    if (Expression.Relation = foOR) and (Expression.Operator2 = foEqual) then
    begin
      v := VarArrayCreate([0, 1], varVariant);
      v[1] := Expression.Operand2;
    end else
      v := VarArrayCreate([0, 0], varVariant);
    v[0] := Expression.Operand1;
  end;

  if not VarIsArray(v) then Exit;

  for i := 0 to VarArrayHighBound(v, 1) do
  begin
    vs := VarToStr(v[i]);
    for si := 0 to Length(CheckStates)-1 do
    begin
      if ss.Objects[si] is TDDFormListboxItemEhData then
  //      if ss.Objects[si] is TPopupListboxItemEhData then
      begin
        ssk := ss[si];
        if (si < ss.Count) and (ssk = vs) then
          CheckStates[si] := True
      end;
    end;
  end;
end;

function TPivotFieldEh.ValueAsDispayText(const Value: Variant): String;
begin
  if (DisplayFormat = '') or VarIsNull(Value) then
    Result := VarToStr(Value)
  else
    Result := FormatDateTime(DisplayFormat, VarToDateTime(Value));
end;

function TPivotFieldEh.ProposedSumFunction: TPivotValueTypeEh;
var
  Field: TField;
  Summable: Boolean;
begin
  Result := svtCountEh;
  if SumFunction <> svtNonEh then
    Result := SumFunction
  else
  begin
    if PivotFields.PDSource.DataSet <> nil then
    begin
      Field := PivotFields.PDSource.DataSet.FindField(SourceFieldName);
      Summable := (Field is TNumericField) or (Field is TBooleanField);
      if Summable
        then Result := svtSumEh
        else Result := svtCountEh;
    end;
  end;
end;

procedure TPivotFieldEh.SetNextSortOrder;
begin
  if SortOrder = soAscEh
    then SortOrder := soDescEh
    else SortOrder := soAscEh;
end;

procedure TPivotFieldEh.SetSortOrder(const Value: TSortOrderEh);
begin
  if FSortOrder <> Value then
  begin
    FSortOrder := Value;
//    Changed;
  end;
end;

procedure TPivotFieldEh.SetSumFunction(const Value: TPivotValueTypeEh);
begin
  if FSumFunction <> Value then
  begin
    FSumFunction := Value;
//    PivotFields.PDSource.GridDefinitionChanged(Self);
  end;
end;

procedure TPivotFieldEh.SetTypeDef(const Value: TPivotFieldDataTypeDefEh);
begin
  FTypeDef.Assign(Value);
end;

{ TPivotFieldsEh }

constructor TPivotFieldsEh.Create(APDSource: TPivotDataSourceEh; AClass: TPivotFieldEhClass);
begin
  inherited Create(AClass);
  FPDSource := APDSource;
end;

function TPivotFieldsEh.Add: TPivotFieldEh;
begin
  Result := TPivotFieldEh(inherited Add);
end;

procedure TPivotFieldsEh.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
end;

function TPivotFieldsEh.GetOwner: TPersistent;
begin
  Result := FPDSource;
end;

function TPivotFieldsEh.GetPivotField(Index: Integer): TPivotFieldEh;
begin
  Result := TPivotFieldEh(inherited Items[Index]);
end;

procedure TPivotFieldsEh.SetPivotField(Index: Integer; Value: TPivotFieldEh);
begin
  Items[Index] := Value;
end;

procedure TPivotFieldsEh.Notify(Item: TCollectionItem; Action: TCollectionNotification);
begin
  inherited Notify(Item, Action);
end;

procedure TPivotFieldsEh.AddAllPivotFields(DeleteExistend: Boolean);
var
  i: Integer;
  fList: TStringList;
  APivotField: TPivotFieldEh;
  SliceLevel: TFieldDateTimeSliceLevelEh;
begin
  BeginUpdate;
  try
  if DeleteExistend then
    Clear;
  if PDSource.DataSet <> nil then
  begin
    fList := TStringList.Create;
    try
    PDSource.DataSet.GetFieldNames(fList);
    for i := 0 to fList.Count-1 do
    begin
      APivotField := Add;
      APivotField.SourceFieldName := fList[i];
      APivotField.FieldName := fList[i];
      if PDSource.DataSet.FieldByName(fList[i]).DataType in [ftDate, ftDateTime] then
      begin
//        for SliceLevel := Low(TFieldDateTimeSliceLevelEh) to High(TFieldDateTimeSliceLevelEh) do
        for SliceLevel := dtslNonEh to dtslMSecEh do
        begin
          if SliceLevel in PDSource.DefaultDateTimeSliceLevels then
          begin
            APivotField := Add;
            APivotField.SourceFieldName := fList[i];
            APivotField.SliceLevel := SliceLevel;
            APivotField.FieldName := APivotField.SourceFieldName + '.' + SliceNames[SliceLevel];
            APivotField.DisplayFormat := SliceNamesDisplaFormat[SliceLevel];

          end;
        end;
      end;
    end;
    finally
      fList.Free;
    end;
  end;
  finally
    EndUpdate;
  end;
end;

procedure TPivotFieldsEh.RebuildPivotFields;
begin
  AddAllPivotFields(True);
end;

procedure TPivotFieldsEh.Update(Item: TCollectionItem);
begin
  inherited Update(Item);
  PDSource.PivotFieldsChanged;
end;

function TPivotFieldsEh.FindFieldByName(const PivotFieldName: String): TPivotFieldEh;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count-1 do
  begin
    if AnsiCompareText(Items[i].FieldName, PivotFieldName) = 0 then
    begin
      Result := Items[i];
      Exit;
    end;
  end;
end;

function TPivotFieldsEh.IndexOf(APivotField: TPivotFieldEh): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to Count-1 do
  begin
    if APivotField = Items[i] then
    begin
      Result := i;
      Exit;
    end;
  end;
end;

{ TPivotGridFilterPopupListboxItemEh }

function TPivotGridFilterPopupListboxItemEh.GetGrid(
  Listbox: TCustomListboxEh): TCustomPivotGridEh;
begin
  if Listbox.Owner is TCustomPivotGridEh
    then Result := TCustomPivotGridEh(Listbox.Owner)
    else Result := nil;
end;

function TPivotGridFilterPopupListboxItemEh.GetPivotField(
  Listbox: TCustomListboxEh): TPivotFieldEh;
begin
  if Listbox.Owner is TCustomPivotGridEh
    then Result := TCustomPivotGridEh(Listbox.Owner).FInTitleFilterPivotField
    else Result := nil;
end;

{ TPopupListboxItemEhData }

function TPopupListboxItemEhData.CanFocus(Sender: TCustomListboxEh; ItemIndex: Integer): Boolean;
begin
  Result := False;
end;

function TPopupListboxItemEhData.CloseOnExecute(Sender: TCustomListboxEh; ItemIndex: Integer): Boolean;
begin
  Result := False;
end;

procedure TPopupListboxItemEhData.DrawItem(Sender: TCustomListboxEh;
  ItemIndex: Integer; ARect: TRect; State: TGridDrawState);
var
  CBRect: TRect;
  MouseIndex: Integer;
  {IsDown, }OldRigth: Integer;
  CBState: TCheckBoxState;
  IsActive: Boolean;
  PivotField: TPivotFieldEh;
begin
  MouseIndex := Sender.ItemAtPos(Sender.ScreenToClient(SafeGetMouseCursorPos), True);
  PivotField := GetPivotField(Sender);
{  if PivotField.STFilter.FPopupListboxDownIndex = ItemIndex
    then IsDown := -1
    else IsDown := 0;}
  if PivotField.FListValuesCheckingState[ItemIndex] = True
    then CBState := cbChecked
    else CBState := cbUnchecked;
  IsActive := (MouseIndex >= 0) and (MouseIndex = ItemIndex) and (Mouse.Capture = 0);
  CBRect := Rect(ARect.Left, ARect.Top, ARect.Left + DefaultCheckBoxWidth, ARect.Bottom);
  if Sender.UseRightToLeftAlignment then
  begin
    OldRigth := CBRect.Right;
    CBRect.Right := Sender.ClientWidth - CBRect.Left;
    CBRect.Left := Sender.ClientWidth - OldRigth;
  end;
  PaintButtonControlEh(Sender.Canvas, CBRect, Sender.Canvas.Brush.Color,
    bcsCheckboxEh, 0, True, IsActive {odFocused in State}, True, CBState);

  if Sender.UseRightToLeftAlignment
    then ARect.Right := ARect.Right - DefaultCheckBoxWidth - 2
    else ARect.Left := ARect.Left + DefaultCheckBoxWidth + 2;
  Sender.DefaultDrawItem(ItemIndex, ARect, State);
end;

procedure TPopupListboxItemEhData.Execute(Sender: TCustomListboxEh;
  ItemIndex: Integer; InItemPos: TPoint; Shift: TShiftState);
//var
//  i: Integer;
//  PivotField: TPivotFieldEh;
begin
//  PivotField := GetPivotField(Sender);
//  PivotField.FInFilterListBox := True;
  try
{    if not PivotField.FEnterNotClearData then
      for i := 0 to Length(PivotField.FListValuesCheckingState)-1 do
      begin
        PivotField.FListValuesCheckingState[i] := False;
      end;}
//???    PivotField.FListValuesCheckingState[ItemIndex] := not PivotField.FListValuesCheckingState[ItemIndex];
//???    PivotField.UpdateFilterFromValuesCheckingState(Sender.Items);
  finally
//    if PivotField <> nil then
//      PivotField.FInFilterListBox := False;
  end;
  Sender.InvalidateIndex(ItemIndex);
end;

procedure TPopupListboxItemEhData.KeyPress(Sender: TCustomListboxEh;
  ItemIndex: Integer; var Key: Char; Shift: TShiftState;
  var IsCloseListbox: Boolean);
begin
  inherited KeyPress(Sender, ItemIndex, Key, Shift, IsCloseListbox);
end;

procedure TPopupListboxItemEhData.MouseDown(Sender: TCustomListboxEh;
  ItemIndex: Integer; InItemPos: TPoint; Button: TMouseButton;
  Shift: TShiftState);
var
  PivotField: TPivotFieldEh;
begin
  PivotField := GetPivotField(Sender);
  PivotField.FPopupListboxDownIndex := ItemIndex;
  Sender.InvalidateIndex(ItemIndex);
end;

procedure TPopupListboxItemEhData.MouseMove(Sender: TCustomListboxEh;
  ItemIndex: Integer; InItemPos: TPoint; Shift: TShiftState);
var
  PivotField: TPivotFieldEh;
begin
  PivotField := GetPivotField(Sender);
  if (PivotField.FPopupListboxDownIndex >= 0) and
     (PivotField.FPopupListboxDownIndex <> ItemIndex) then
  begin
    Sender.InvalidateIndex(PivotField.FPopupListboxDownIndex);
    PivotField.FPopupListboxDownIndex := -1;
  end;
end;

procedure TPopupListboxItemEhData.MouseUp(Sender: TCustomListboxEh;
  ItemIndex: Integer; InItemPos: TPoint; Button: TMouseButton;
  Shift: TShiftState; var IsCloseListbox: Boolean);
var
  MousePos: TPoint;
  Index: Integer;
  PivotField: TPivotFieldEh;
begin
  PivotField := GetPivotField(Sender);
  if PivotField.FPopupListboxDownIndex = ItemIndex then
  begin
//    PivotField.FEnterNotClearData := True;
    Execute(Sender, ItemIndex, InItemPos, Shift);
    MousePos := Sender.ScreenToClient(SafeGetMouseCursorPos);
    Index := Sender.ItemAtPos(MousePos, True);
    if Index < Sender.Items.Count then Sender.ItemIndex := Index;
//    ColFil.UpdateFilterFromValuesCheckingState(Sender.Items);
  end;
  if PivotField <> nil then
    PivotField.FPopupListboxDownIndex := -1;
  Sender.InvalidateIndex(ItemIndex);
  IsCloseListbox := False;
end;

{ TPopupListboxItemEhSpec }

constructor TPopupListboxItemEhSpec.Create(AType: TPopupListboxItemEhSpecType);
begin
  inherited Create;
  FType := AType;
end;

function TPopupListboxItemEhSpec.CanFocus(Sender: TCustomListboxEh;
  ItemIndex: Integer): Boolean;
begin
  Result := False;
end;

procedure TPopupListboxItemEhSpec.DrawItem(Sender: TCustomListboxEh;
  ItemIndex: Integer; ARect: TRect; State: TGridDrawState);
var
  CBRect: TRect;
  OldColor: TColor;
  OldRigth: Integer;
  CBState: TCheckBoxState;
begin
  if FType = ptFilterRowLine then
  begin
    Sender.Canvas.Pen.Color := clSilver;
    Sender.Canvas.Polyline([Point(ARect.Left, (ARect.Bottom+ARect.Top) div 2),
                          Point(ARect.Right,(ARect.Bottom+ARect.Top) div 2)]);
  end
  else if FType = ptFilterSpecSelectAll then
  begin
    CBState := cbUnchecked;
    CBRect := Rect(ARect.Left, ARect.Top, ARect.Left + DefaultCheckBoxWidth, ARect.Bottom);
    if Sender.UseRightToLeftAlignment then
    begin
      OldRigth := CBRect.Right;
      CBRect.Right := Sender.ClientWidth - CBRect.Left;
      CBRect.Left := Sender.ClientWidth - OldRigth;
    end;
    PaintButtonControlEh(Sender.Canvas, CBRect, Sender.Canvas.Brush.Color,
      bcsCheckboxEh, 0, True, False, True, CBState);

    if Sender.UseRightToLeftAlignment
      then ARect.Right := ARect.Right - DefaultCheckBoxWidth - 2
      else ARect.Left := ARect.Left + DefaultCheckBoxWidth + 2;
    Sender.DefaultDrawItem(ItemIndex, ARect, State);
  end else
  begin
    OldColor := Sender.Canvas.Brush.Color;
    Sender.Canvas.FillRect(Rect(ARect.Left, ARect.Top, ARect.Left + DefaultCheckBoxWidth + 2, ARect.Bottom));
    Sender.Canvas.Brush.Color := OldColor;
    ARect.Left := ARect.Left + DefaultCheckBoxWidth + 2;
    Sender.DefaultDrawItem(ItemIndex, ARect, State);
  end;

end;

procedure TPopupListboxItemEhSpec.Execute(Sender: TCustomListboxEh;
  ItemIndex: Integer; InItemPos: TPoint; Shift: TShiftState);
var
  PivotField: TPivotFieldEh;
begin
  PivotField := GetPivotField(Sender);
  PivotField.PivotFields.PDSource.SetDataFilter;
end;

procedure TPopupListboxItemEhSpec.MouseDown(Sender: TCustomListboxEh;
  ItemIndex: Integer; InItemPos: TPoint; Button: TMouseButton;
  Shift: TShiftState);
var
  PivotField: TPivotFieldEh;
begin
  PivotField := GetPivotField(Sender);
  PivotField.FPopupListboxDownIndex := ItemIndex;
  Sender.InvalidateIndex(ItemIndex);
end;

procedure TPopupListboxItemEhSpec.MouseUp(Sender: TCustomListboxEh;
  ItemIndex: Integer; InItemPos: TPoint; Button: TMouseButton;
  Shift: TShiftState; var IsCloseListbox: Boolean);
var
  MousePos: TPoint;
  Index: Integer;
  PivotField: TPivotFieldEh;
  AllIsSelected: Boolean;
  i: Integer;
begin
  PivotField := GetPivotField(Sender);
  if FType = ptFilterSpecSelectAll then
  begin
    AllIsSelected := True;
    for i := 0 to Length(PivotField.FListValuesCheckingState)-1 do
      if Sender.Items.Objects[i] is TPopupListboxItemEhData then
        if not PivotField.FListValuesCheckingState[i] then
        begin
          AllIsSelected := False;
          Break;
        end;

    for i := 0 to Length(PivotField.FListValuesCheckingState)-1 do
      if Sender.Items.Objects[i] is TPopupListboxItemEhData then
        PivotField.FListValuesCheckingState[i] := not AllIsSelected;

    Sender.Invalidate;
  end else if FType = ptFilterApply then
  begin
    if PivotField.FPopupListboxDownIndex = ItemIndex then
    begin
      Execute(Sender, ItemIndex, InItemPos, Shift);
      MousePos := Sender.ScreenToClient(SafeGetMouseCursorPos);
      Index := Sender.ItemAtPos(MousePos, True);
      if Index < Sender.Items.Count then Sender.ItemIndex := Index;
    end;
    if PivotField <> nil then
      PivotField.FPopupListboxDownIndex := -1;
    Sender.InvalidateIndex(ItemIndex);
    IsCloseListbox := True;
    GetGrid(Sender).FilterListboxCloseUp(True);
  end;
end;

{ TPivotGridDrabObj }

destructor TPivotGridDrabObj.Destroy;
begin
  inherited Destroy;
end;

function TPivotGridDrabObj.GetDragCursor(Accepted: Boolean; X,
  Y: Integer): TCursor;
begin
  Result := inherited GetDragCursor(Accepted, X, Y);
  if Accepted and not (TObject(DragTarget) is TCustomPivotGridEh) then
    if {(Control is TCustomPivotGridEh) and}
       (TObject(DragTarget) is TCustomPivotGridFieldsEh) and
       (TCustomPivotGridFieldsEh(DragTarget).ListType = sgftFieldsListEh)
    then
      Result := hcrDropToGarbageIndexEh;
end;

{ TPivotFieldValueInfoEh }

procedure TPivotFieldValueInfoEh.Assign(Source: TPersistent);
begin
  if Source is TPivotFieldValueInfoEh then
  begin
    PivotField := TPivotFieldValueInfoEh(Source).PivotField;
    DisplayFormat := TPivotFieldValueInfoEh(Source).DisplayFormat;
    SumFunction := TPivotFieldValueInfoEh(Source).SumFunction;
  end else
    inherited Assign(Source);
end;

constructor TPivotFieldValueInfoEh.Create(Collection: TCollection);
begin
  inherited Create(Collection);
end;

destructor TPivotFieldValueInfoEh.Destroy;
begin
  inherited Destroy;
end;

function TPivotFieldValueInfoEh.GetCollection: TValueFieldsCollectionEh;
begin
  Result := TValueFieldsCollectionEh(inherited Collection);
end;

procedure TPivotFieldValueInfoEh.SetDisplayFormat(const Value: String);
begin
  if FDisplayFormat <> Value then
  begin
    FDisplayFormat := Value;
  end;
end;

procedure TPivotFieldValueInfoEh.SetPivotField(const Value: TPivotFieldEh);
begin
  if FPivotField <> Value then
  begin
    FPivotField := Value;
    if FPivotField <> nil then
      FPivotFieldName := FPivotField.FieldName;
    Changed(False);
  end;
end;

procedure TPivotFieldValueInfoEh.SetPivotFieldName(const Value: String);
begin
  if FPivotFieldName <> Value then
  begin
    FPivotFieldName := Value;
    Changed(False);
  end;
end;

procedure TPivotFieldValueInfoEh.SetSumFunction(
  const Value: TPivotValueTypeEh);
begin
  if FSumFunction <> Value then
  begin
    Changed(False);
    FSumFunction := Value;
  end;
end;

function TPivotFieldValueInfoEh.UpdatePivotFieldFromPivotFieldName: TPivotFieldEh;
begin
  if (Collection <> nil) and
     (Collection.PivotDataSource <> nil) and
     (Collection.PivotDataSource.PivotFields <> nil)
  then
    FPivotField := Collection.PivotDataSource.PivotFields.FindFieldByName(PivotFieldName)
  else
    FPivotField := nil;
  Result := FPivotField;
end;

{ TValueFieldsCollectionEh }

constructor TValueFieldsCollectionEh.Create(AClass: TPivotFieldValueInfoEhClass);
begin
  inherited Create(AClass);
end;

function TValueFieldsCollectionEh.Add: TPivotFieldValueInfoEh;
begin
  Result := TPivotFieldValueInfoEh(inherited Add);
end;

procedure TValueFieldsCollectionEh.Notify(Item: TCollectionItem;
  Action: TCollectionNotification);
begin
  inherited Notify(Item, Action);
  if UpdateCount > 0 then Exit;
  if Assigned(OnChangeNotification) then
    OnChangeNotification(Self, Item, Action);
end;

function TValueFieldsCollectionEh.GetPivotFieldValueInfo(
  Index: Integer): TPivotFieldValueInfoEh;
begin
  Result := TPivotFieldValueInfoEh(inherited Items[Index]);
end;

procedure TValueFieldsCollectionEh.SetPivotFieldValueInfo(Index: Integer;
  Value: TPivotFieldValueInfoEh);
begin
  inherited Items[Index] := Value;
end;

procedure TValueFieldsCollectionEh.Update(Item: TCollectionItem);
begin
  inherited Update(Item);
  Notify(nil, cnAdded);
end;

procedure TValueFieldsCollectionEh.UpdatePivotFieldsFromPivotFieldNames;
var
  i: Integer;
begin
  for i := 0 to Count-1 do
    Items[i].PivotField := Items[i].UpdatePivotFieldFromPivotFieldName;
end;

function TValueFieldsCollectionEh.IndexByPivotFieldName(
  PivotFieldName: String): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to Count-1 do
  begin
    if Items[i].PivotFieldName = PivotFieldName then
    begin
      Result := i;
      Exit;
    end;
  end;
end;

function TValueFieldsCollectionEh.IndexOf(
  PivotFieldValueInfo: TPivotFieldValueInfoEh): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to Count-1 do
  begin
    if Items[i] = PivotFieldValueInfo then
    begin
      Result := i;
      Exit;
    end;
  end;
end;

procedure TValueFieldsCollectionEh.Move(CurIndex, NewIndex: Integer);
begin
  Items[CurIndex].Index := NewIndex;
end;

function TValueFieldsCollectionEh.AddForPivotField(
  APivotField: TPivotFieldEh; Position: Integer): TPivotFieldValueInfoEh;
begin
  BeginUpdate;
  Result := Add;
  Result.PivotField := APivotField;
  Result.SumFunction := APivotField.ProposedSumFunction;
  Result.DisplayFormat := APivotField.DisplayFormat;
  Result.Index := Position;
  EndUpdate;
end;

function TValueFieldsCollectionEh.DataLines: Integer;
begin
  if Count <= 1 then
    Result := 1
  else if (Count = 2) and (Items[1].SumFunction = svtCountEh) then
    Result := 1
  else
    Result := Count;
end;

{ TPivotDataSourceEh }

constructor TPivotDataSourceEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDefaultDateTimeSliceLevels := [dtslYearEh, dtslMonthEh, dtslDayEh];

  FPivotFields := TPivotFieldsEh.Create(Self, TPivotFieldEh);
  FNotificationConsumers := TInterfaceList.Create;

  FColumnFields := TStringList.Create;
  FColumnFields.OnChange := PivotStructureChanged;
  FActualColFlds := TStringList.Create;

  FRowFields := TStringList.Create;
  FRowFields.OnChange := PivotStructureChanged;
  FActualRowFlds := TStringList.Create;

  FValueFieldsInfo := TValueFieldsCollectionEh.Create(TPivotFieldValueInfoEh);
  FValueFieldsInfo.OnChangeNotification := ValueFieldsInfoChangeEvent;
  FValueFieldsInfo.FPivotDataSource := Self;

  FActualValueFields := TValueFieldsCollectionEh.Create(TPivotFieldValueInfoEh);
  FActualValueFields.FPivotDataSource := Self;

  FSourceTable := TMemTableEh.Create(nil);
  BaseTable := TMemTableEh.Create(nil);

  ColsTable := TMemTableEh.Create(nil);
  RowsTable := TMemTableEh.Create(nil);
//  ResultTable := TMemTableEh.Create(nil);
//  ResultTable.FilterOptions := ResultTable.FilterOptions;
  ResultAggrTable := TMemTableEh.Create(nil);
  TransResultAggrTable := TMemTableEh.Create(nil);

end;

destructor TPivotDataSourceEh.Destroy;
begin
  FreeAndNil(FNotificationConsumers);
  FreeAndNil(FPivotFields);

  FreeAndNil(FColumnFields);
  FreeAndNil(FActualColFlds);
  FreeAndNil(FActualRowFlds);
  FreeAndNil(FRowFields);
  FreeAndNil(FValueFieldsInfo);
  FreeAndNil(FActualValueFields);

  FreeAndNil(FSourceTable);
  FreeAndNil(BaseTable);
  FreeAndNil(ColsTable);
  FreeAndNil(RowsTable);
  FreeAndNil(ResultAggrTable);
  FreeAndNil(TransResultAggrTable);

  inherited Destroy;
end;

function TPivotDataSourceEh.DataIsEmpty: Boolean;
begin
  Result := ((ActualColFlds.Count = 0) and (ActualRowFlds.Count = 0) and (ActualValueFields.Count = 0)) or
            (PivotFields.Count = 0) or
            not ColsTable.Active or (ColsTable.RecordCount = 0) or
            not RowsTable.Active or (RowsTable.RecordCount = 0);
end;

procedure TPivotDataSourceEh.PivotFieldsChanged;
var
  i: Integer;
begin
  UpdateColRowValueFields;
  ClearSourceData;

  if FNotificationConsumers <> nil then
    for I := 0 to FNotificationConsumers.Count - 1 do
      (FNotificationConsumers[I] as IPivotDataSourceNotificationEh).PivotFieldsChanged(Self);
end;

procedure TPivotDataSourceEh.PivotDataChanged;
var
  i: Integer;
begin
  if FNotificationConsumers <> nil then
    for I := 0 to FNotificationConsumers.Count - 1 do
      (FNotificationConsumers[I] as IPivotDataSourceNotificationEh).PivotDataChanged(Self);
end;

procedure TPivotDataSourceEh.PivotStructureChanged(Sender: TObject);
var
  i: Integer;
begin
  if FInternalDefinitionUpdating then Exit;
//  if FUpdateCount > 0 then Exit;
  UpdateColRowValueFields;
  if FNotificationConsumers <> nil then
    for I := 0 to FNotificationConsumers.Count - 1 do
      (FNotificationConsumers[I] as IPivotDataSourceNotificationEh).PivotStructureChanged(Self);
end;

procedure TPivotDataSourceEh.PivotDataSourceChanged;
begin
end;

procedure TPivotDataSourceEh.PivotDataStructBeginUpdate;
begin
  Inc(FUpdateCount);
end;

procedure TPivotDataSourceEh.PivotDataStructEndUpdate;
begin
  Dec(FUpdateCount);
  if FUpdateCount = 0 then PivotStructureChanged(nil);
end;

procedure TPivotDataSourceEh.SetPivotFields(const Value: TPivotFieldsEh);
begin
  FPivotFields.Assign(Value);
end;

procedure TPivotDataSourceEh.RegisterChanges(Value: IPivotDataSourceNotificationEh);
begin
  if FNotificationConsumers.IndexOf(Value) < 0 then
    FNotificationConsumers.Add(Value);
end;

procedure TPivotDataSourceEh.UnRegisterChanges(Value: IPivotDataSourceNotificationEh);
begin
  FNotificationConsumers.Remove(Value);
end;

procedure TPivotDataSourceEh.ValueFieldsInfoChangeEvent(Sender: TCollection;
  Item: TCollectionItem; Action: TCollectionNotification);
begin
//  GridDefinitionChanged(Sender);
  PivotStructureChanged(Sender);
end;

procedure TPivotDataSourceEh.SetRowFields(const Value: TStringList);
begin
  FRowFields.Assign(Value);
end;

procedure TPivotDataSourceEh.SetColumnFields(const Value: TStringList);
begin
  FColumnFields.Assign(Value)
end;

procedure TPivotDataSourceEh.SetValueFieldsInfo(const Value: TValueFieldsCollectionEh);
begin
  FValueFieldsInfo.Assign(Value);
end;

procedure TPivotDataSourceEh.UpdateColRowValueFields;
var
  i: Integer;
  PivotField: TPivotFieldEh;
begin
  if FInternalDefinitionUpdating then Exit;
  if csDestroying in ComponentState then Exit;

  try
    FInternalDefinitionUpdating := True;

    for i := 0 to RowFields.Count-1 do
    begin
      PivotField := PivotFields.FindFieldByName(RowFields[i]);
      if PivotField <> nil then
        RowFields.Objects[i] := PivotField
      else if PivotFields.Count = 0 then
        RowFields.Objects[i] := nil
      else
        ;
  //     raise Exception.Create('Field name "' + RowFields[i] + '" does'' exist');
    end;

    for i := 0 to ColumnFields.Count-1 do
    begin
      PivotField := PivotFields.FindFieldByName(ColumnFields[i]);
      if PivotField <> nil then
        ColumnFields.Objects[i] := PivotField
      else if PivotFields.Count = 0 then
        ColumnFields.Objects[i] := nil
      else
       ;
  //      raise Exception.Create('Field name "' + ColumnFields[i] + '" does'' exist');
    end;

    ValueFieldDefs.UpdatePivotFieldsFromPivotFieldNames;
  finally
    FInternalDefinitionUpdating := False;
  end;
end;

procedure TPivotDataSourceEh.BuildGridData;
begin
  BaseTable.DisableControls;
  ColsTable.DisableControls;
  RowsTable.DisableControls;
  ResultAggrTable.DisableControls;
  TransResultAggrTable.DisableControls;

  try
    if (ColumnFields.Count = 0) and (RowFields.Count = 0) and (ValueFieldDefs.Count = 0) then
      PivotDataChanged
    else
    begin
      CreateAndFillBaseTable;
      BuildGridDataForBaseTable;
    end;

  finally
    BaseTable.EnableControls;
    ColsTable.EnableControls;
    RowsTable.EnableControls;
    ResultAggrTable.EnableControls;
    TransResultAggrTable.EnableControls;
  end;
end;

procedure TPivotDataSourceEh.ClearSourceData;
begin
  SourceTable.DestroyTable;
  ColsTable.DestroyTable;
  RowsTable.DestroyTable;
end;


procedure TPivotDataSourceEh.LoadAndBuildPivotData;
begin
  CreateAndFillSourceTable;
  BuildPivotData;
end;

procedure TPivotDataSourceEh.LogTimeMetric(MetricName: String;
  Duration: LongWord);
begin
  if Assigned(OnLogTimeMetric) then
    OnLogTimeMetric(Self, MetricName, Duration);   
end;

procedure TPivotDataSourceEh.CreateAndFillSourceTable;
begin
  if DataSet = nil then
    raise Exception.Create(Name+'.DataSet is not assigned');
  SourceTable.DisableControls;
  try
    CreateSourceTableStruct;
    FillSourceTable;
  finally
    SourceTable.EnableControls;
  end;
end;

procedure TPivotDataSourceEh.CreateSourceTableStruct;
var
  i: Integer;
  DataStruct: TMTDataStructEh;
  DataField: TMTDataFieldEh;
  Field: TField;
  PField: TPivotFieldEh;
  ticks: LongWord;
begin
  ticks := GetTickCount;
  SourceTable.DestroyTable;
  for i := 0 to PivotFields.Count-1 do
  begin
    DataStruct := SourceTable.RecordsView.MemTableData.DataStruct;
    PField := PivotFields[i];
    if PField.SourceFieldName <> '' then
    begin
      Field := DataSet.FieldByName(PField.SourceFieldName);
      DataField := DataStruct.BuildDataFieldForField(Field);
      if (DataField is TMTNumericDataFieldEh) and (TMTNumericDataFieldEh(DataField).NumericDataType = fdtAutoIncEh) then
        TMTNumericDataFieldEh(DataField).NumericDataType := fdtLargeintEh;
      DataField.FieldName := PField.FieldName;
      DataField.AssignProps(Field);
    end else
    begin
      DataStruct.BuildDataFieldForDef(PField.FieldName,
        PField.TypeDef.DataType, PField.TypeDef.Size, PField.TypeDef.Precision);
    end;
  end;
  SourceTable.Open;
  LogTimeMetric('CreateSourceTableStruct', GetTickCount-ticks)
end;

procedure TPivotDataSourceEh.FillSourceTable;
var
  FieldMap: TIntegerDynArray;
  i: Integer;
  PivotField: TPivotFieldEh;
  Field: TField;
  Value: Variant;
  Processed: Boolean;
  ticks: LongWord;
  RecordsList: TRecordsListEh;
  Rec: TMemoryRecordEh;
begin
  ticks := GetTickCount;
  SetLength(FieldMap, SourceTable.Fields.Count);
  for i := 0 to SourceTable.Fields.Count-1 do
  begin
    PivotField := PivotFields.FindFieldByName(SourceTable.Fields[i].FieldName);
    Field := DataSet.FindField(PivotField.SourceFieldName);
    if Field <> nil
      then FieldMap[i] := Field.Index
      else FieldMap[i] := -1;
  end;

  DataSet.DisableControls;
  SourceTable.DisableControls;
  if not DataSet.IsUniDirectional then
    DataSet.First;

  RecordsList := SourceTable.RecordsView.MemTableData.RecordsList;
  try

  RecordsList.BeginUpdate;

  while not DataSet.Eof do
  begin
    Rec := RecordsList.NewRecord;

    for i := 0 to Length(FieldMap)-1 do
    begin
      if FieldMap[i] >= 0
        then Field := DataSet.Fields[FieldMap[i]]
        else Field := nil;

      Value := Null;
      Processed := False;
      if Assigned(PivotFields[i].OnFetchValue) then
        PivotFields[i].OnFetchValue(Self, PivotFields[i], Value, Processed);

{      if Processed
        then SourceTable.Fields[i].Value := Value
        else SourceTable.Fields[i].Value := PivotFields[i].GetValueForSource(DataSet, Field);}
      if Processed
        then Rec.Value[i, dvvValueEh] := Value
        else Rec.Value[i, dvvValueEh] := PivotFields[i].GetValueForSource(DataSet, Field);
    end;

    RecordsList.FetchRecord(Rec);
    DataSet.Next;
  end;

  finally
    RecordsList.EndUpdate;
    if not DataSet.IsUniDirectional then
      DataSet.First;
    DataSet.EnableControls;
    SourceTable.EnableControls;
  end;
  LogTimeMetric('FillSourceTable', GetTickCount-ticks)
end;

procedure TPivotDataSourceEh.CreateAndFillBaseTable;
var
  ticks: LongWord;
begin
  ticks := GetTickCount;
  BaseTable.DisableControls;
  try
    CreateBaseTableStruct;
    FillBasePivotData;
  finally
    BaseTable.EnableControls;
  end;
  LogTimeMetric(' CreateAndFillBaseTable', GetTickCount-ticks)
end;

procedure TPivotDataSourceEh.BuildPivotData;
var
  ticks: LongWord;
begin
  ticks := GetTickCount;
  BaseTable.DisableControls;
  ColsTable.DisableControls;
  RowsTable.DisableControls;
  ResultAggrTable.DisableControls;
  TransResultAggrTable.DisableControls;

  try
    if (ColumnFields.Count = 0) and (RowFields.Count = 0) and (ValueFieldDefs.Count = 0) then
      PivotDataChanged
    else
    begin
      CreateAndFillBaseTable;
      BuildGridDataForBaseTable;
    end;

  finally
    BaseTable.EnableControls;
    ColsTable.EnableControls;
    RowsTable.EnableControls;
    ResultAggrTable.EnableControls;
    TransResultAggrTable.EnableControls;
  end;
  LogTimeMetric('BuildPivotData', GetTickCount-ticks)
end;

procedure TPivotDataSourceEh.BuildGridDataForBaseTable;
begin
  MakeColsRowsTables;

  MakeResultAggrTable;
  MakeInverseGaussMatrix;

  PivotDataChanged;
end;

procedure TPivotDataSourceEh.MakeColsRowsTables;
var
  SortFields: String;
  ticks: LongWord;
begin
  ticks := GetTickCount;

  SortFields := FActualColFlds.CommaText;
  BaseTable.SortByFields(SortFields);
  MakeColsTable;

  SortFields := FActualRowFlds.CommaText  + ',' + FActualColFlds.CommaText;
  BaseTable.SortByFields(SortFields);
  MakeRowsTable;

  LogTimeMetric(' MakeColsRowsTables', GetTickCount-ticks)
end;

procedure TPivotDataSourceEh.CreateBaseTableStruct;
var
  i: Integer;
  DataField: TMTDataFieldEh;
  NumDataField: TMTNumericDataFieldEh;
  PivotFieldValue: TPivotFieldValueInfoEh;
  BaseStruct: TMTDataStructEh;
  SourceField: TField;

  function BuildAndCopyDataFieldForField(AField: TField; NewFieldName: String): TMTDataFieldEh;
  var
    DataFieldClass: TMTDataFieldClassEh;
    ADataType: TFieldType;
  begin
    ADataType := AField.DataType;
    if ADataType = ftAutoInc then
      ADataType := ftInteger;
    DataFieldClass := DefaultDataFieldClasses[ADataType];

    Result := BaseTable.RecordsView.MemTableData.DataStruct.CreateField(DataFieldClass);
    Result.AssignDataType(ADataType);
    Result.FieldName := NewFieldName;
  //        Result.Name := DataField.CreateUniqueName(Result.FieldName);
    Result.AssignProps(AField);
    Result.DisplayLabel := NewFieldName;
  end;

  function CreateNewDataField(NewFieldName: String; ADataType: TFieldType): TMTDataFieldEh;
  var
    DataFieldClass: TMTDataFieldClassEh;
  begin
    DataFieldClass := DefaultDataFieldClasses[ADataType];

    Result := BaseTable.RecordsView.MemTableData.DataStruct.CreateField(DataFieldClass);
    Result.AssignDataType(ADataType);
    Result.FieldName := NewFieldName;
    Result.DisplayLabel := NewFieldName;
  end;

begin
  BaseTable.DestroyTable;
  BaseTable.Filter := '';

  FActualRowFlds.Assign(FRowFields);

  BaseStruct := BaseTable.RecordsView.MemTableData.DataStruct;
  if FActualRowFlds.Count > 0 then
    for i := 0 to FActualRowFlds.Count-1 do
    begin
      SourceField := SourceTable.FieldByName(TPivotFieldEh(FActualRowFlds.Objects[i]).SourceFieldName);
      DataField := BaseStruct.BuildAndCopyDataFieldForField(SourceField);
      DataField.FieldName := TPivotFieldEh(FActualRowFlds.Objects[i]).FieldName;
      if RowsFieldNames <> '' then RowsFieldNames := RowsFieldNames + ';';
      RowsFieldNames := RowsFieldNames + FActualRowFlds[i];
    end
  else
  begin
    FActualRowFlds.Append('%Value');

    NumDataField := TMTNumericDataFieldEh(BaseStruct.CreateField(TMTNumericDataFieldEh));
    NumDataField.FieldName := '%Value';
    NumDataField.NumericDataType := fdtIntegerEh;
    RowsFieldNames := FActualRowFlds[0];
  end;

  FActualColFlds.Assign(FColumnFields);

  if FActualColFlds.Count > 0 then
    for i := 0 to FActualColFlds.Count-1 do
    begin
      BuildAndCopyDataFieldForField(
        SourceTable.FieldByName(TPivotFieldEh(FActualColFlds.Objects[i]).SourceFieldName),
        TPivotFieldEh(FActualColFlds.Objects[i]).FieldName);
      if ColsFieldNames <> '' then ColsFieldNames := ColsFieldNames + ';';
      ColsFieldNames := ColsFieldNames + FActualColFlds[i];
    end
  else
  begin
    FActualColFlds.Append('%Value');

    NumDataField := TMTNumericDataFieldEh(BaseStruct.CreateField(TMTNumericDataFieldEh));
    NumDataField.FieldName := '%Value';
    NumDataField.NumericDataType := fdtIntegerEh;
    ColsFieldNames := FActualColFlds[0];
  end;

  ActualValueFields.Assign(ValueFieldDefs);

  if ActualValueFields.Count = 0 then
  begin
    PivotFieldValue := ActualValueFields.Add;
    PivotFieldValue.PivotFieldName := 'Count(*)';
    PivotFieldValue.SumFunction := svtCountEh;
    CreateNewDataField('Count(*)', ftInteger);
  end else
  begin
    for i := 0 to ActualValueFields.Count-1 do
    begin
      SourceField := SourceTable.FieldByName(ActualValueFields[i].PivotField.FieldName);
      BuildAndCopyDataFieldForField(
          SourceField,
          ActualValueFields[i].PivotField.FieldName + '-' +
          PivotAggrValueTypes[ActualValueFields[i].SumFunction]);
    end;
  end;

  BaseTable.Open;
end;

procedure TPivotDataSourceEh.FillBasePivotData;
var
  i: Integer;
  StartPost: Integer;
  RowFieldsMap, ColFieldsMap, ValFieldsMap: TIntegerDynArray;
  Field: TField;
begin
  SourceTable.DisableControls;
  SourceTable.First;

  SetLength(RowFieldsMap, FActualRowFlds.Count);
  for i := 0 to FActualRowFlds.Count-1 do
  begin
    Field := SourceTable.FindField(FActualRowFlds[i]);
    if Field <> nil
      then RowFieldsMap[i] := Field.Index
      else RowFieldsMap[i] := -1;
  end;

  SetLength(ColFieldsMap, FActualColFlds.Count);
  for i := 0 to FActualColFlds.Count-1 do
  begin
    Field := SourceTable.FindField(FActualColFlds[i]);
    if Field <> nil
      then ColFieldsMap[i] := Field.Index
      else ColFieldsMap[i] := -1;
  end;

  SetLength(ValFieldsMap, ActualValueFields.Count);
  for i := 0 to ActualValueFields.Count-1 do
  begin
    Field := SourceTable.FindField(ActualValueFields[i].PivotFieldName);
    if Field <> nil
      then ValFieldsMap[i] := Field.Index
      else ValFieldsMap[i] := -1;
  end;

  while not SourceTable.Eof do
  begin

    BaseTable.Append;

    for i := 0 to FActualRowFlds.Count-1 do
    begin
      if FActualRowFlds.Objects[i] = nil then
        BaseTable.Fields[i].Value := 0
      else
        BaseTable.Fields[i].Value := SourceTable.Fields[RowFieldsMap[i]].Value;
    end;

    StartPost := FActualRowFlds.Count;
    for i := StartPost to StartPost + FActualColFlds.Count-1 do
    begin
      if FActualColFlds.Objects[i-FActualRowFlds.Count] = nil then
        BaseTable.Fields[i].Value := 0
      else
        BaseTable.Fields[i].Value := SourceTable.Fields[ColFieldsMap[i-StartPost]].Value;
    end;

    StartPost := StartPost+FActualColFlds.Count;
    for i := StartPost to StartPost + ActualValueFields.Count-1 do
    begin
      if ActualValueFields[i-StartPost].PivotField <> nil then
        BaseTable.Fields[i].Value := SourceTable.Fields[ValFieldsMap[i-StartPost]].Value
      else
        BaseTable.Fields[i].Value := Null;
    end;

    BaseTable.Post;

    SourceTable.Next;
  end;
  SourceTable.EnableControls;

end;

procedure TPivotDataSourceEh.AggregateBasePivotData;
begin

end;

procedure TPivotDataSourceEh.MakeColsTable;
var
  i, b: Integer;
  CompValue, NewCompValue: TVariantDynArray;
  DataField: TMTNumericDataFieldEh;
  EqLev: Integer;
//  v: Variant;
begin
  ColsTable.DestroyTable;
  for i := 0 to FActualColFlds.Count-1 do
  begin
    ColsTable.RecordsView.MemTableData.DataStruct.
      BuildAndCopyDataFieldForField(BaseTable.FieldByName(FActualColFlds[i]));
  end;

  DataField := TMTNumericDataFieldEh(ColsTable.RecordsView.MemTableData.DataStruct.CreateField(TMTNumericDataFieldEh));
  DataField.FieldName := '%RecType';
  DataField.NumericDataType := fdtIntegerEh;

  ColsTable.Open;

  BaseTable.First;

  SetLength(CompValue, FActualColFlds.Count);
  SetLength(NewCompValue, FActualColFlds.Count);

  for i := 0 to ColsTable.FieldCount-2 do
    NewCompValue[i] := BaseTable.FieldByName(ColsTable.Fields[i].FieldName).Value;

  while not BaseTable.Eof do
  begin

    for i := 0 to ColsTable.FieldCount-2 do
      CompValue[i] := BaseTable.FieldByName(ColsTable.Fields[i].FieldName).Value;

    EqLev := VarArrayEqualLevelForDepth(NewCompValue, CompValue, FActualColFlds.Count);
    if EqLev = FActualColFlds.Count then
    begin
    end else
    begin

      ColsTable.Append;
      for i := 0 to ColsTable.FieldCount-2 do
        ColsTable.Fields[i].Value := NewCompValue[i];
      ColsTable.Fields[ColsTable.FieldCount-1].Value := 0;
      ColsTable.Post;

      for b := FActualColFlds.Count-2 downto EqLev do
      begin
        ColsTable.Append;
        for i := 0 to b do
          ColsTable.Fields[i].Value := NewCompValue[i];
        ColsTable.Fields[ColsTable.FieldCount-1].Value := FActualColFlds.Count-2-b+1;
        ColsTable.Post;
        for i := b+1 to ColsTable.FieldCount-2 do
          ColsTable.Rec.Value[i, dvvValueEh] := Unassigned;
     end;

      NewCompValue := Copy(CompValue);
    end;
    BaseTable.Next;
  end;

  ColsTable.Append;
  for i := 0 to ColsTable.FieldCount-2 do
    ColsTable.Fields[i].Value := CompValue[i];
  ColsTable.Fields[ColsTable.FieldCount-1].Value := 0;
  ColsTable.Post;

  for b := FActualColFlds.Count-2 downto 0 do
  begin
    ColsTable.Append;
    for i := 0 to b do
      ColsTable.Fields[i].Value := NewCompValue[i];
    ColsTable.Fields[ColsTable.FieldCount-1].Value := FActualColFlds.Count-2-b+1;
    ColsTable.Post;
    for i := b+1 to ColsTable.FieldCount-2 do
      ColsTable.Rec.Value[i, dvvValueEh] := Unassigned;
  end;

  ColsTable.Append;
  ColsTable.Fields[ColsTable.FieldCount-1].Value := FActualColFlds.Count;
  ColsTable.Post;
  for i := 0 to ColsTable.FieldCount-2 do
    ColsTable.Rec.Value[i, dvvValueEh] := Unassigned;

end;

procedure TPivotDataSourceEh.MakeRowsTable;
var
  i, b: Integer;
  CompValue, NewCompValue: TVariantDynArray;
  DataField: TMTNumericDataFieldEh;
  EqLev: Integer;
begin

  RowsTable.DestroyTable;
  for i := 0 to FActualRowFlds.Count-1 do
  begin
    RowsTable.RecordsView.MemTableData.DataStruct.
      BuildAndCopyDataFieldForField(BaseTable.FieldByName(FActualRowFlds[i]));
  end;

  DataField := TMTNumericDataFieldEh(RowsTable.RecordsView.MemTableData.DataStruct.CreateField(TMTNumericDataFieldEh));
  DataField.FieldName := '%RecType';
  DataField.NumericDataType := fdtIntegerEh;

  RowsTable.Open;

  BaseTable.First;

  SetLength(CompValue, FActualRowFlds.Count);
  SetLength(NewCompValue, FActualRowFlds.Count);

  for i := 0 to RowsTable.FieldCount-2 do
    NewCompValue[i] := BaseTable.FieldByName(RowsTable.Fields[i].FieldName).Value;

  while not BaseTable.Eof do
  begin

    for i := 0 to RowsTable.FieldCount-2 do
      CompValue[i] := BaseTable.FieldByName(RowsTable.Fields[i].FieldName).Value;

    EqLev := VarArrayEqualLevelForDepth(NewCompValue, CompValue, FActualRowFlds.Count);
    if EqLev = FActualRowFlds.Count then
    begin
    end else
    begin

      RowsTable.Append;
      for i := 0 to RowsTable.FieldCount-2 do
        RowsTable.Fields[i].Value := NewCompValue[i];
      RowsTable.Fields[RowsTable.FieldCount-1].Value := 0;
      RowsTable.Post;

      for b := FActualRowFlds.Count-2 downto EqLev do
      begin
        RowsTable.Append;
        for i := 0 to b do
          RowsTable.Fields[i].Value := NewCompValue[i];
        RowsTable.Fields[RowsTable.FieldCount-1].Value := FActualRowFlds.Count-2-b+1;
        RowsTable.Post;
        for i := b+1 to RowsTable.FieldCount-2 do
          RowsTable.Rec.Value[i, dvvValueEh] := Unassigned;
      end;

      NewCompValue := Copy(CompValue);
    end;
    BaseTable.Next;

  end;

  RowsTable.Append;
  for i := 0 to RowsTable.FieldCount-2 do
    RowsTable.Fields[i].Value := CompValue[i];
  RowsTable.Fields[RowsTable.FieldCount-1].Value := 0;
  RowsTable.Post;

  for b := FActualRowFlds.Count-2 downto 0 do
  begin
    RowsTable.Append;
    for i := 0 to b do
      RowsTable.Fields[i].Value := NewCompValue[i];
    RowsTable.Fields[RowsTable.FieldCount-1].Value := FActualRowFlds.Count-2-b+1;
    RowsTable.Post;
    for i := b+1 to RowsTable.FieldCount-2 do
      RowsTable.Rec.Value[i, dvvValueEh] := Unassigned;
  end;

  RowsTable.Append;
  RowsTable.Fields[RowsTable.FieldCount-1].Value := FActualRowFlds.Count;
  RowsTable.Post;
  for i := 0 to RowsTable.FieldCount-2 do
    RowsTable.Rec.Value[i, dvvValueEh] := Unassigned;

end;

procedure TPivotDataSourceEh.MakeResultAggrTable;
var
  DataField: TMTNumericDataFieldEh;
  i,b,k: Integer;
  CompValue, NewCompValue: TVariantDynArray;
  AggrLevelArrValue: array of array of TAggrValueHolderEh;
  KeyLength, EqualLevel: Integer;
  ticks: LongWord;
begin
  ticks := GetTickCount;
  ResultAggrTable.DestroyTable;
  ResultAggrTable.RecordsView.MemTableData.DataStruct.Assign(
    BaseTable.RecordsView.MemTableData.DataStruct);
  DataField := TMTNumericDataFieldEh(ResultAggrTable.RecordsView.MemTableData.DataStruct.CreateField(TMTNumericDataFieldEh));
  DataField.FieldName := '%RecType';
  DataField.NumericDataType := fdtIntegerEh;

  ResultAggrTable.Open;

  KeyLength := FActualColFlds.Count + FActualRowFlds.Count;

  SetLength(CompValue, KeyLength);
  SetLength(NewCompValue, KeyLength);

  SetLength(AggrLevelArrValue, KeyLength+1);

  for i := 0 to KeyLength do
  begin
    SetLength(AggrLevelArrValue[i], ActualValueFields.Count);
    for k := 0 to ActualValueFields.Count-1 do
    begin
      AggrLevelArrValue[i][k] := TAggrValueHolderEh.Create;
      AggrLevelArrValue[i][k].AggrFunc := ActualValueFields[k].SumFunction;
      AggrLevelArrValue[i][k].ResetAggrHolder;
    end;
  end;

  BaseTable.First;
  for i := 0 to KeyLength-1 do
    CompValue[i] := BaseTable.Fields[i].Value;

  while not BaseTable.Eof do
  begin

    for i := 0 to KeyLength-1 do
      NewCompValue[i] := BaseTable.Fields[i].Value;

    EqualLevel := VarArrayEqualLevelForDepth(CompValue, NewCompValue, KeyLength);

    if EqualLevel < KeyLength then
    begin
      for b := KeyLength downto EqualLevel+1 do
      begin
        ResultAggrTable.Append;
        for i := 0 to b-1 do
          ResultAggrTable.Fields[i].Value := CompValue[i];
        for k := 0 to ActualValueFields.Count-1 do
          ResultAggrTable.Fields[BaseTable.FieldCount-ActualValueFields.Count+k].Value := AggrLevelArrValue[b][k].FinalizeAggregation;
        ResultAggrTable.Fields[BaseTable.FieldCount].Value := 1;
        for k := 0 to ActualValueFields.Count-1 do
          AggrLevelArrValue[b][k].ResetAggrHolder;
        ResultAggrTable.Post;
        for i := b to KeyLength-1 do
          ResultAggrTable.Rec.Value[i, dvvValueEh] := Unassigned;
      end;
    end;

    for i := 0 to KeyLength do
      for k := 0 to ActualValueFields.Count-1 do
        AggrLevelArrValue[i][k].AggrValue(BaseTable.Fields[KeyLength+k].Value);

    CompValue := Copy(NewCompValue);
    BaseTable.Next;
  end;

  for b := KeyLength downto 1 do
  begin
    ResultAggrTable.Append;
    for i := 0 to b-1 do
      ResultAggrTable.Fields[i].Value := CompValue[i];
    for k := 0 to ActualValueFields.Count-1 do
      ResultAggrTable.Fields[BaseTable.FieldCount-ActualValueFields.Count+k].Value := AggrLevelArrValue[b][k].FinalizeAggregation;
    ResultAggrTable.Fields[BaseTable.FieldCount].Value := 1;
    for k := 0 to ActualValueFields.Count-1 do
      AggrLevelArrValue[b][k].ResetAggrHolder;
    ResultAggrTable.Post;
    for i := b to KeyLength-1 do
      ResultAggrTable.Rec.Value[i, dvvValueEh] := Unassigned;
  end;

  ColsTable.First;

  while not ColsTable.Eof do
  begin

    ResultAggrTable.Append;
    ResultAggrTable.Fields[BaseTable.FieldCount].Value := 1;
    ResultAggrTable.Post;

    for i := 0 to FActualColFlds.Count do
      ResultAggrTable.Rec.Value[FActualRowFlds.Count+i, dvvValueEh] := ColsTable.Rec.Value[i, dvvValueEh];  // := Fields[+i].Value;
    for i := 0 to FActualRowFlds.Count-1 do
      ResultAggrTable.Rec.Value[i, dvvValueEh] := Unassigned;

    ColsTable.Next;
  end;

  ResultAggrTable.Edit;
  for i := 0 to ActualValueFields.Count-1 do
    ResultAggrTable.Fields[KeyLength+i].Value := AggrLevelArrValue[0][i].FinalizeAggregation;
  ResultAggrTable.Post;

  for i := 0 to KeyLength do
    for k := 0 to ActualValueFields.Count-1 do
      AggrLevelArrValue[i][k].Free;

  LogTimeMetric(' MakeResultAggrTable', GetTickCount-ticks);
end;

procedure TPivotDataSourceEh.FillInverseGaussMatrixForLevel(ColsLevel: Integer);
var
  i,b,k: Integer;
  CompValue, NewCompValue{, AggrLevelArrValue}: TVariantDynArray;
//  AggrLevelArrValue: array of TVariantDynArray;
  AggrLevelArrValue: array of array of TAggrValueHolderEh;
  KeyLength, EqualLevel: Integer;
  DataFieldIndex: Integer;
//  SkipRow: Boolean;
begin
  BaseTable.First;

  KeyLength := FActualRowFlds.Count + FActualColFlds.Count;

  SetLength(CompValue, KeyLength);
  SetLength(NewCompValue, KeyLength);

  SetLength(AggrLevelArrValue, KeyLength+1);
  for i := 0 to KeyLength do
  begin
    SetLength(AggrLevelArrValue[i], ActualValueFields.Count);
    for k := 0 to ActualValueFields.Count-1 do
    begin
      AggrLevelArrValue[i][k] := TAggrValueHolderEh.Create;
      AggrLevelArrValue[i][k].AggrFunc := ActualValueFields[k].SumFunction;
      AggrLevelArrValue[i][k].ResetAggrHolder;
    end;
  end;

  for i := 0 to KeyLength-1 do
  begin
    if i >= FActualColFlds.Count then
      CompValue[i] := BaseTable.Fields[i].Value
    else if i < ColsLevel then
      CompValue[i] := BaseTable.Fields[i].Value
    else
      CompValue[i] := Unassigned;

    for k := 0 to ActualValueFields.Count-1 do
      AggrLevelArrValue[i][k].ResetAggrHolder;
  end;

  while not BaseTable.Eof do
  begin

    for i := 0 to KeyLength-1 do
    begin
      if i >= FActualColFlds.Count then
        NewCompValue[i] := BaseTable.Fields[i].Value
      else if i < ColsLevel then
        NewCompValue[i] := BaseTable.Fields[i].Value
      else
        NewCompValue[i] := Unassigned;
    end;

    EqualLevel := VarArrayEqualLevelForDepth(CompValue, NewCompValue, KeyLength);

    if EqualLevel <= KeyLength - 2 then
    begin
      for b := KeyLength - 1 downto EqualLevel + 1 do
      begin
        if (b < FActualColFlds.Count) and (b >= ColsLevel) then Continue;

        if (ColsLevel = FActualColFlds.Count) or (b > FActualColFlds.Count) then 
        begin
          TransResultAggrTable.Append;

          for k := 0 to ActualValueFields.Count-1 do
            TransResultAggrTable.Fields[BaseTable.FieldCount-ActualValueFields.Count+k].Value := AggrLevelArrValue[b][k].FinalizeAggregation;
          TransResultAggrTable.Fields[BaseTable.FieldCount].Value := 1;
          TransResultAggrTable['ForGridAggrLevel'] := ColsLevel;

          TransResultAggrTable.Post;

          for i := 0 to b-1 do
          begin
            DataFieldIndex := TransResultAggrTable.Fields[i].FieldNo-1;
            TransResultAggrTable.Rec.Value[DataFieldIndex, dvvValueEh] := CompValue[i];
          end;
          for i := b to KeyLength-1 do
          begin
            DataFieldIndex := TransResultAggrTable.Fields[i].FieldNo-1;
            TransResultAggrTable.Rec.Value[DataFieldIndex, dvvValueEh] := Unassigned;
          end;
        end;

        for k := 0 to ActualValueFields.Count-1 do
          AggrLevelArrValue[b][k].ResetAggrHolder;
      end;
    end;

    for i := 0 to KeyLength-1 do
      for k := 0 to ActualValueFields.Count-1 do
        AggrLevelArrValue[i][k].AggrValue(BaseTable.Fields[KeyLength+k].Value);

    CompValue := Copy(NewCompValue);

    BaseTable.Next;
  end;

  for b := KeyLength - 1 downto 1 do
  begin
    if (b < FActualColFlds.Count) and (b >= ColsLevel) then Continue;

    TransResultAggrTable.Append;

    for k := 0 to ActualValueFields.Count-1 do
      TransResultAggrTable.Fields[BaseTable.FieldCount-ActualValueFields.Count+k].Value := AggrLevelArrValue[b][k].FinalizeAggregation;
    TransResultAggrTable.Fields[BaseTable.FieldCount].Value := 1;
    for k := 0 to ActualValueFields.Count-1 do
      AggrLevelArrValue[b][k].ResetAggrHolder;

    TransResultAggrTable['ForGridAggrLevel'] := ColsLevel;
    TransResultAggrTable.Post;

    for i := 0 to b-1 do
    begin
      DataFieldIndex := TransResultAggrTable.Fields[i].FieldNo-1;
      TransResultAggrTable.Rec.Value[DataFieldIndex, dvvValueEh] := CompValue[i];
    end;

    for i := b to KeyLength-1 do
    begin
      DataFieldIndex := TransResultAggrTable.Fields[i].FieldNo-1;
      TransResultAggrTable.Rec.Value[DataFieldIndex, dvvValueEh] := Unassigned;
    end;
  end;

  for i := 0 to KeyLength do
    for k := 0 to ActualValueFields.Count-1 do
      AggrLevelArrValue[i][k].Free;

end;

procedure TPivotDataSourceEh.MakeInverseGaussMatrix;
var
  DataField: TMTNumericDataFieldEh;
  i: Integer;
  TransDataStruct: TMTDataStructEh;
  SortText: String;
  ticks: LongWord;
  SortFields: String;

  function GetColFldsSortTextForLevel(Level: Integer): String;
  var
    i: Integer;
  begin
    Result := '';
    for i := 0 to Level-1 do
    begin
      Result := Result + FActualColFlds[i];
      if i <> Level-1 then
        Result := Result + ',';
    end;
  end;

begin
  ticks := GetTickCount;
  TransResultAggrTable.DestroyTable;
  TransResultAggrTable.RecordsView.MemTableData.DataStruct.Assign(
    BaseTable.RecordsView.MemTableData.DataStruct);

  TransDataStruct := TransResultAggrTable.RecordsView.MemTableData.DataStruct;
  DataField := TMTNumericDataFieldEh(TransDataStruct.CreateField(TMTNumericDataFieldEh));
  DataField.FieldName := '%RecType';
  DataField.NumericDataType := fdtIntegerEh;

  DataField := TMTNumericDataFieldEh(TransDataStruct.CreateField(TMTNumericDataFieldEh));
  DataField.FieldName := 'ForGridAggrLevel';
  DataField.NumericDataType := fdtIntegerEh;

  TransResultAggrTable.Open;

  for i := 0 to FActualColFlds.Count-1 do
    TransResultAggrTable.Fields[FActualRowFlds.Count + i].Index := i;

  BaseTable.SortByFields(FActualColFlds.CommaText  + ',' + FActualRowFlds.CommaText);
  for i := 0 to FActualColFlds.Count-1 do
    BaseTable.Fields[FActualRowFlds.Count + i].Index := i;

  for i := ActualColFlds.Count downto 1 do
  begin
    SortText := GetColFldsSortTextForLevel(i);
    BaseTable.SortByFields(SortText  + ',' + FActualRowFlds.CommaText);
    FillInverseGaussMatrixForLevel(i);
  end;

  for i := 0 to FActualRowFlds.Count-1 do
    BaseTable.Fields[FActualColFlds.Count + i].Index := i;

  SortFields := FActualRowFlds.CommaText  + ',' + FActualColFlds.CommaText;
  BaseTable.SortByFields(SortFields);

  LogTimeMetric(' MakeTransResultAggrTable', GetTickCount-ticks);
end;

procedure TPivotDataSourceEh.SetDataFilter;
var
  i: Integer;
  s: String;
  PivotField: TPivotFieldEh;
  ConnOp: String;
begin
  s := '';
  for i := 0 to PivotFields.Count-1 do
  begin
    PivotField := PivotFields[i];
    if PivotField.Expression.Operator1 <> foNon then
    begin
      if s = ''
        then ConnOp := ''
        else ConnOp := ' AND ';

      s := s + ConnOp + GetOneExpressionAsLocalFilterString(
        PivotField.Expression.Operator1, PivotField.Expression.Operand1, PivotField.FieldName,
        BaseTable, nil, True, ncsAsIsNullEh, True);
    end;
  end;
  BaseTable.Filter := s;
//  SaveToStrFile('Test.Txt', s);
  BaseTable.Filtered := True;
  BuildGridDataForBaseTable;
end;

{ TPivotGridScrollBarPanelControl }

constructor TPivotGridScrollBarPanelControl.Create(AOwner: TComponent; AKind: TScrollBarKind);
begin
  inherited Create(AOwner, AKind);
  FSelInfoPanel := TPivotGridSelectionInfoPanel.Create(Self);
  FSelInfoPanel.Parent := Self;
end;


destructor TPivotGridScrollBarPanelControl.Destroy;
begin
  FreeAndNil(FSelInfoPanel);
  inherited Destroy;
end;

procedure TPivotGridScrollBarPanelControl.CreateHandle;
begin
  inherited CreateHandle;
end;

procedure TPivotGridScrollBarPanelControl.GridSelectionChanged;
begin
  FSelInfoPanel.GridSelectionChanged;
  Resize;
end;

procedure TPivotGridScrollBarPanelControl.Resize;
begin
  inherited Resize;
  if not HandleAllocated then Exit;

  if FSelInfoPanel.FAggrText <> '' then
  begin
    if UseRightToLeftAlignment then
    begin
      FSelInfoPanel.Width := FSelInfoPanel.InfoWidth;
      ScrollBar.SetBounds(0, ScrollBar.Top, Width - FSelInfoPanel.Width, ScrollBar.Height);
      FSelInfoPanel.SetBounds(Width - FSelInfoPanel.Width, 0, FSelInfoPanel.Width, Height);
    end else
    begin
      FSelInfoPanel.SetBounds(0, 0, FSelInfoPanel.InfoWidth, Height);
      ScrollBar.SetBounds(FSelInfoPanel.Width, ScrollBar.Top, ScrollBar.Width - FSelInfoPanel.Width, ScrollBar.Height);
    end;
    FSelInfoPanel.Visible := True;
  end else
    FSelInfoPanel.Visible := False;
end;

{ TPivotGridSelectionInfoPanel }

constructor TPivotGridSelectionInfoPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

end;

destructor TPivotGridSelectionInfoPanel.Destroy;
begin

  inherited Destroy;
end;

function TPivotGridSelectionInfoPanel.GetGrid: TCustomPivotGridEh;
begin
  Result := TCustomPivotGridEh(Owner.Owner);
end;

procedure TPivotGridSelectionInfoPanel.GridSelectionChanged;
var
  i, j: Integer;
  PivotCel: TPivotCellEh;
  Sel: TGridRect;
  SumVal, CellCountVal, MinVal, MaxVal, AvgVal, CountVal: Variant;
  OldAggrText, DivText: String;
begin
  if not Grid.IsMultiSelected and (FAggrText = '') then
    Exit;

  if Grid.IsMultiSelected then
  begin
    Sel := Grid.Selection;
    SumVal := Null;
    CountVal := Null;
    MinVal := Null;
    MaxVal := Null;
    AvgVal := Null;
    CellCountVal := 0;
    OldAggrText := FAggrText;
    for i := Sel.Left to Sel.Right do
    begin
      for j := Sel.Top to Sel.Bottom do
      begin
        PivotCel := Grid.VisPivotGridArray[i, j];
        CellCountVal := CellCountVal + 1;
        if (PivotCel.ShowValue = True) and
           (VarType(PivotCel.Value) in [varDouble, varSmallint, varInteger, varSingle, varCurrency]) then
        begin
          SumVal := VarToDoubleDef(SumVal, 0) + PivotCel.Value;
          CountVal := VarToDoubleDef(CountVal, 0) + 1;
          if PivotCel.Value >= VarToDoubleDef(MaxVal, PivotCel.Value) then
            MaxVal := PivotCel.Value;
          if PivotCel.Value <= VarToDoubleDef(MinVal, PivotCel.Value) then
            MinVal := PivotCel.Value;
        end;
      end;
    end;
    FAggrText := '';
    DivText := '';
    if not VarIsNull(SumVal) then
    begin
      FAggrText := FAggrText + DivText + 'SUM: ' + FormatFloat(',#.####', SumVal);
      DivText := '    ';
    end;
    if not VarIsNull(CountVal) then
    begin
      FAggrText := FAggrText + DivText + 'COUNT: ' + FormatFloat(',#', CountVal);
      DivText := '    ';
      if SumVal <> 0 then
        AvgVal := SumVal / CountVal;
    end;
    if not VarIsNull(MinVal) then
    begin
      FAggrText := FAggrText + DivText + 'MIN: ' + FormatFloat(',#', MinVal);
      DivText := '    ';
    end;
    if not VarIsNull(MaxVal) then
    begin
      FAggrText := FAggrText + DivText + 'MAX: ' + FormatFloat(',#', MaxVal);
      DivText := '    ';
    end;
    if not VarIsNull(AvgVal) then
    begin
      FAggrText := FAggrText + DivText + 'AVG: ' + FormatFloat(',#', AvgVal);
      DivText := '    ';
    end;
    FAggrText := FAggrText + DivText + 'CELL COUNT: ' + FloatToStr(CellCountVal);
    if OldAggrText <> FAggrText then
      Grid.UpdateBoundaries;
  end else
  begin
    FAggrText := '';
    Grid.UpdateBoundaries;
  end;
  Invalidate;
end;

function TPivotGridSelectionInfoPanel.HaveData: Boolean;
begin
  Result := FAggrText <> '';
end;

procedure TPivotGridSelectionInfoPanel.Paint;
begin
  Canvas.Brush.Color := Grid.FixedColor;
  Canvas.Font := Grid.Font;
  Canvas.TextRect(ClientRect, 2, 2, FAggrText);
end;

function TPivotGridSelectionInfoPanel.InfoWidth: Integer;
begin
  if not HandleAllocated or (FAggrText = '') then
  begin
    Result := 0;
    Exit;
  end;

  Canvas.Font := Grid.Font;
  Result := Canvas.TextWidth(FAggrText) + 6;
end;

{ TPivotGridScrollBarEh }

function TPivotGridScrollBarEh.CheckScrollBarMustBeShown: Boolean;
begin
  if TPivotGridScrollBarPanelControl(TCustomPivotGridEh(Grid).HorzScrollBarPanelControl).FSelInfoPanel.HaveData then
    Result := True
  else
    Result := inherited CheckScrollBarMustBeShown;
end;

{ TPivotRowsGroupingTreeEh }

constructor TPivotAxisGroupingTreeEh.Create(AGrid: TCustomPivotGridEh;
  ItemClass: TTreeNodeClassEh; AAxisDir: TPivotAxisDirectionEh);
begin
  inherited Create(ItemClass);
  FGrid := AGrid;
  FFlatList := TList.Create;
  FAxisDir := AAxisDir;
end;

destructor TPivotAxisGroupingTreeEh.Destroy;
begin
  FreeAndNil(FFlatList);
  inherited Destroy;
end;

procedure TPivotAxisGroupingTreeEh.ForAllNode(AProg: TTreeNodeIterativeEvent;
  Param: TObject; RowAggrBeforeData: Boolean; ConsideCollapsed: Boolean);

  procedure DoForAllNode(CurNode: TPivotAxisTreeNodeEh);
  var
    i: Integer;
  begin
    for i := 0 to CurNode.Count-1 do
    begin
      if RowAggrBeforeData then
      begin
        AProg(CurNode[i], Param);
        if ConsideCollapsed or CurNode[i].Expanded then
          DoForAllNode(TPivotAxisTreeNodeEh(CurNode[i]))
      end else
      begin
        if ConsideCollapsed or CurNode[i].Expanded then
          DoForAllNode(TPivotAxisTreeNodeEh(CurNode[i]));
        AProg(CurNode[i], Param);
      end;
    end;
  end;

var
  i: Integer;
begin
  for i := 0 to Root.Count-1 do
  begin
    if RowAggrBeforeData then
    begin
      AProg(Root[i], Param);
      if ConsideCollapsed or Root[i].Expanded then
        DoForAllNode(TPivotAxisTreeNodeEh(Root[i]))
    end else
    begin
      if ConsideCollapsed or Root[i].Expanded then
        DoForAllNode(TPivotAxisTreeNodeEh(TPivotAxisTreeNodeEh(Root[i])));
      AProg(Root[i], Param);
    end;
  end;
end;

function TPivotAxisGroupingTreeEh.GetRoot: TPivotAxisTreeNodeEh;
begin
  Result := TPivotAxisTreeNodeEh(inherited Root);
end;

procedure TPivotAxisGroupingTreeEh.SetVisArrayGridNum(Sender: TPivotAxisTreeNodeEh; Param: TObject);
var
  i: Integer;
  PivotCell: TPivotCellEh;
  VisAxisGroupFlatNodePos: Integer;
begin
  for i := 0 to ActualAxisFlds.Count-1 do
  begin
    if AxisDir = padVerticalEh then
    begin
      PivotCell := Grid.PivotGridArray[i, Sender.AxisPos+Grid.FStartDataRow];
      PivotCell.VisRowsGroupFlatNodePos := FRowNums[i];
      VisAxisGroupFlatNodePos := PivotCell.VisRowsGroupFlatNodePos;
    end else
    begin
      PivotCell := Grid.PivotGridArray[Sender.AxisPos+Grid.FStartDataCol, i+1];
      PivotCell.VisColsGroupFlatNodePos := FRowNums[i];
      VisAxisGroupFlatNodePos := PivotCell.VisColsGroupFlatNodePos;
    end;

    if (VisAxisGroupFlatNodePos = 0) and
       (Sender.Level-1 >= i) and
       (i < ActualAxisFlds.Count-1) then
    begin
      PivotCell.ShowGroupingSign := True;
      PivotCell.ShowValue := True;
    end else
    begin
      PivotCell.ShowGroupingSign := False;
      if Sender.Level = i+1
        then PivotCell.ShowValue := True
        else PivotCell.ShowValue := False
    end;
  end;

  for i:= 0 to Sender.Level-2 do
    FRowNums[i] := FRowNums[i] + 1;
  for i:= Sender.Level-1 to ActualAxisFlds.Count-1 do
    FRowNums[i] := 0;
end;

procedure TPivotAxisGroupingTreeEh.SetVisArrayGridNums;
var
  AMethod: TPivotTreeNodeIterativeEvent;
  i: Integer;
begin
  SetLength(FRowNums, ActualAxisFlds.Count);
  for i := 0 to ActualAxisFlds.Count-1 do
    FRowNums[i] := 0;
  AMethod := SetVisArrayGridNum;
  ForAllNode(TTreeNodeIterativeEvent(AMethod), nil, AxisAggrBeforeData, False);
end;

procedure TPivotAxisGroupingTreeEh.SetNextRowNum(Sender: TPivotAxisTreeNodeEh; Param: TObject);
var
  i: Integer;
  RowsTreeNode: TPivotAxisTreeNodeEh;
begin
  TPivotAxisTreeNodeEh(Sender).FAxisPos := FCurIncAxisNum;

  for i := Grid.ActualRowFlds.Count-1 downto Sender.Level-1 do
  begin
    Grid.PivotGridArray[i, FCurIncAxisNum + Grid.FStartDataRow].RowsTreeNode := Sender;
  end;

  if Sender.Level-2 >= 0 then
  begin
    RowsTreeNode := Sender.Parent;
    for i := Sender.Level-2 downto 0 do
    begin
      Grid.PivotGridArray[i, FCurIncAxisNum + Grid.FStartDataRow].RowsTreeNode := RowsTreeNode;
      RowsTreeNode := RowsTreeNode.Parent;
    end;
  end;
  Inc(FCurIncAxisNum);
end;

procedure TPivotAxisGroupingTreeEh.SetNextColNum(Sender: TPivotAxisTreeNodeEh; Param: TObject);
var
  i: Integer;
  ColsTreeNode: TPivotAxisTreeNodeEh;
  PivotCel: TPivotCellEh;
  ACol, ARow: Integer;
begin
  TPivotAxisTreeNodeEh(Sender).FAxisPos := FCurIncAxisNum * Grid.ActualValueFields.Count;

  for i := Grid.ActualColFlds.Count-1 downto Sender.Level-1 do
  begin
    Grid.PivotGridArray[FCurIncAxisNum * Grid.ActualValueFields.Count + Grid.FStartDataCol, i + 1].ColsTreeNode := Sender;
  end;

  if Sender.Level-2 >= 0 then
  begin
    ColsTreeNode := Sender.Parent;
    for i := Sender.Level-2 downto 0 do
    begin
      Grid.PivotGridArray[FCurIncAxisNum * Grid.ActualValueFields.Count + Grid.FStartDataCol, i + 1].ColsTreeNode := ColsTreeNode;
      ColsTreeNode := ColsTreeNode.Parent;
    end;
  end;

  if Grid.ActualValueFields.Count > 1 then
  begin
    for i := 0 to Grid.ActualValueFields.Count-1 do
    begin
      ACol := FCurIncAxisNum * Grid.ActualValueFields.Count + Grid.FStartDataCol + i;
      ARow := Grid.ActualColFlds.Count+1;
      PivotCel := Grid.PivotGridArray[ACol, ARow];
      PivotCel.ColsTreeNode := Sender;
    end;
  end;

  Inc(FCurIncAxisNum);
end;

procedure TPivotAxisGroupingTreeEh.SetGridArrayAxisNums;
var
  SetNextAxisNumMethod: TPivotTreeNodeIterativeEvent;
begin
  FCurIncAxisNum := 0;
  if AxisDir = padVerticalEh
    then SetNextAxisNumMethod := SetNextRowNum
    else SetNextAxisNumMethod := SetNextColNum;
  ForAllNode(TTreeNodeIterativeEvent(SetNextAxisNumMethod), nil, AxisAggrBeforeData, True);
end;

function TPivotAxisGroupingTreeEh.CompareAxisValues(AxisPos1, AxisPos2, OppositeAxisPos: Integer): TVariantRelationship;
begin
  if AxisDir = padVerticalEh then
    Result := DBVarCompareValue(
      Grid.PivotGridArray[OppositeAxisPos, AxisPos1 + Grid.FStartDataRow].Value,
      Grid.PivotGridArray[OppositeAxisPos, AxisPos2 + Grid.FStartDataRow].Value
      )
  else
    Result := DBVarCompareValue(
      Grid.PivotGridArray[AxisPos1 + Grid.FStartDataCol, OppositeAxisPos].Value,
      Grid.PivotGridArray[AxisPos2 + Grid.FStartDataCol, OppositeAxisPos].Value
    );
end;

function TPivotAxisGroupingTreeEh.ComparePivotAxisPoses(Node1,
  Node2: TBaseTreeNodeEh; ParamSort: TObject): Integer;
var
  Col, Row1, Row2: Integer;
  Result1: TVariantRelationship;
  BackSign: Integer;
begin
  Result := 0;
  if FSortOrder = soAscEh
    then BackSign := 1
    else BackSign := -1;
  Col := Integer(ParamSort);
  Row1 := TPivotAxisTreeNodeEh(Node1).AxisPos;
  Row2 := TPivotAxisTreeNodeEh(Node2).AxisPos;
  Result1 := CompareAxisValues(Row1, Row2, Col);
  case Result1 of
    vrEqual: Result := 0;
    vrLessThan: Result := -1 * BackSign;
    vrGreaterThan: Result := 1 * BackSign;
    vrNotEqual: raise Exception.Create('Error Message');
  end;
end;

procedure TPivotAxisGroupingTreeEh.SortData(Level, PivotGridAxisLine: Integer; ASortOrder: TSortOrderEh);
var
  CurNode: TPivotAxisTreeNodeEh;
begin
  FSortOrder := ASortOrder;
  if Level = -1 then
    TPivotAxisTreeNodeEh(Root).SortData(ComparePivotAxisPoses, TObject(PivotGridAxisLine), True)
  else
  begin
    if Level = 1 then
      TPivotAxisTreeNodeEh(Root).SortData(ComparePivotAxisPoses, TObject(PivotGridAxisLine), False)
    else
    begin
      CurNode := TPivotAxisTreeNodeEh(GetFirst);
      while CurNode <> nil do
      begin
        if Level-1 = CurNode.Level then
          CurNode.SortData(ComparePivotAxisPoses, TObject(PivotGridAxisLine), False);
        CurNode := TPivotAxisTreeNodeEh(GetNext(CurNode));
      end;
    end;
  end;
end;

procedure TPivotAxisGroupingTreeEh.WriteTree(sl: TStrings; AxisAggrBeforeData: Boolean);
begin
  ForAllNode(WriteTreeLine, sl, AxisAggrBeforeData, True);
end;

procedure TPivotAxisGroupingTreeEh.WriteTreeLine(Sender: TBaseTreeNodeEh; Param: TObject);
var
  Node: TPivotAxisTreeNodeEh;
begin
  Node := TPivotAxisTreeNodeEh(Sender);
  TStrings(Param).Add(DupeString(' ', Node.Level) + Node.Text + ' : ' + IntToStr(Node.AxisPos));
end;

procedure TPivotAxisGroupingTreeEh.BuildTree;
var
  CompValue: TVariantDynArray;
  UpToLevel: Integer;

  procedure ColsTableNext;
  var
    ct: TDataSet;
  begin
    ct := AxisTable;
    ct.Next;

    while not ct.Eof
      and (ct.Fields[ct.FieldCount-1].Value <> 0)
    do
      ct.Next;
  end;

  procedure AssignValue(var CompValue: TVariantDynArray);
  var
    i: Integer;
  begin
    for i := 0 to ActualAxisFlds.Count-1 do
      CompValue[i] := AxisTable.Fields[i].Value;
  end;

  procedure AssignVarArrToVarArr(var FromValue, ToValue: TVariantDynArray);
  var
    i: Integer;
  begin
    for i := 0 to Length(FromValue)-1 do
      ToValue[i] := FromValue[i];
  end;

  procedure BuildNodeTree(Node: TPivotAxisTreeNodeEh; var KeyValue: TVariantDynArray; var UpToLevel: Integer);
  var
    ChNode: TPivotAxisTreeNodeEh;
    NextVals: TVariantDynArray;
    EqLev: Integer;
  begin
    while True do
    begin
      ChNode := TPivotAxisTreeNodeEh(AddChild(VarToStrDef(KeyValue[Node.Level], '<Null>'), Node, nil));
      if ChNode.Level < ActualAxisFlds.Count then
      begin
        BuildNodeTree(ChNode, KeyValue, UpToLevel);
        if AxisTable.Eof then
          Exit;
        if UpToLevel < Node.Level then
          Exit;
      end else if ChNode.Level = ActualAxisFlds.Count then
      begin
        ColsTableNext;
        if AxisTable.Eof then
          Exit;
        SetLength(NextVals, ActualAxisFlds.Count);
        AssignValue(NextVals);
        EqLev := VarArrayEqualLevelForDepth(KeyValue, NextVals, ActualAxisFlds.Count-1);
        AssignVarArrToVarArr(NextVals, KeyValue);
        if EqLev = ActualAxisFlds.Count-1 then
          Continue
        else
        begin
          UpToLevel := EqLev;
          Exit;
        end;
      end;
    end;
  end;

begin
  Clear;

  SetLength(CompValue, ActualAxisFlds.Count);

  AxisTable.First;
  AssignValue(CompValue);
  BuildNodeTree(TPivotAxisTreeNodeEh(Root), CompValue, UpToLevel);
end;

procedure TPivotAxisGroupingTreeEh.BuildFlatList;
begin
  FFlatList.Clear;
  ForAllNode(FlatListAddItem, nil, AxisAggrBeforeData, False);
end;

procedure TPivotAxisGroupingTreeEh.FlatListAddItem(Sender: TBaseTreeNodeEh;
  Param: TObject);
begin
  FFlatList.Add(Sender);
end;

function TPivotAxisGroupingTreeEh.GetActualAxisFlds: TStrings;
begin
  if AxisDir = padVerticalEh
    then Result := Grid.PivotDataSource.ActualRowFlds
    else Result := Grid.PivotDataSource.ActualColFlds;
end;

function TPivotAxisGroupingTreeEh.GetAxisAggrBeforeData: Boolean;
begin
  if AxisDir = padVerticalEh
    then Result := Grid.RowAggrBeforeData
    else Result := False;
end;

function TPivotAxisGroupingTreeEh.GetAxisTable: TMemTableEh;
begin
  if AxisDir = padVerticalEh
    then Result := Grid.PivotDataSource.RowsTable
    else Result := Grid.PivotDataSource.ColsTable;
end;

function TPivotAxisGroupingTreeEh.GetFlatList(Index: Integer): TPivotAxisTreeNodeEh;
begin
  Result := TPivotAxisTreeNodeEh(FFlatList[Index]);
end;

function TPivotAxisGroupingTreeEh.GetFlatListCount: Integer;
begin
  Result := FFlatList.Count;
end;

procedure TPivotAxisGroupingTreeEh.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

procedure TPivotAxisGroupingTreeEh.EndUpdate;
begin
  Dec(FUpdateCount);
end;

procedure TPivotAxisGroupingTreeEh.SetExpandedState(Sender: TPivotAxisTreeNodeEh; Param: TObject);
begin
  if Sender.Level = FExpandedStateIterativeLevel then
    Sender.Expanded := Boolean(Param);
end;

procedure TPivotAxisGroupingTreeEh.SetLevelExpanded(ALevel: Integer; IsExpanded: Boolean);
var
  AMethod: TPivotTreeNodeIterativeEvent;
begin
  BeginUpdate;
  try
    FExpandedStateIterativeLevel := ALevel;
    AMethod := SetExpandedState;
    ForAllNode(TTreeNodeIterativeEvent(AMethod), TObject(IsExpanded), AxisAggrBeforeData, True);
  finally
    EndUpdate;
  end;
  ExpandedChanged(nil);
end;

procedure TPivotAxisGroupingTreeEh.ExpandedChanged(Node: TBaseTreeNodeEh);
begin
  inherited ExpandedChanged(Node);
  if not Updating then
    if AxisDir = padVerticalEh
      then Grid.RowExpandedChanged(TPivotAxisTreeNodeEh(Node))
      else Grid.ColExpandedChanged(TPivotAxisTreeNodeEh(Node));
end;

function TPivotAxisGroupingTreeEh.Updating: Boolean;
begin
  Result := FUpdateCount > 0;
end;

{ TPivotRowsTreeNodeEh }

constructor TPivotAxisTreeNodeEh.Create;
begin
  inherited Create;
  Expanded := True;
end;

function TPivotAxisTreeNodeEh.GetItem(const Index: Integer): TPivotAxisTreeNodeEh;
begin
  Result := TPivotAxisTreeNodeEh(inherited Items[Index]);
end;

function TPivotAxisTreeNodeEh.GetParent: TPivotAxisTreeNodeEh;
begin
  Result := TPivotAxisTreeNodeEh(inherited Parent);
end;

{ TPivotFieldDataTypeDefEh }

procedure TPivotFieldDataTypeDefEh.SetDataType(const Value: TFieldType);
begin
  FDataType := Value;
end;

procedure TPivotFieldDataTypeDefEh.SetPrecision(const Value: Integer);
begin
  FPrecision := Value;
end;

procedure TPivotFieldDataTypeDefEh.SetSize(const Value: Integer);
begin
  FSize := Value;
end;

{ TAggrValueHolderEh }

destructor TAggrValueHolderEh.Destroy;
begin
  FreeAndNil(SrvObj);
  inherited Destroy;
end;

procedure TAggrValueHolderEh.ResetAggrHolder;
begin
  if AggrFunc = svtAvgEh then
  begin
    Value := Null;
    SrvObj := nil;

    SetLength(SrvVars, 2);
    SrvVars[0] := 0;
    SrvVars[1] := Null;
  end else if AggrFunc = svtCountDistinctEh then
  begin
    Value := Null;
    FreeAndNil(SrvObj);
    SrvObj := TStringList.Create;
    TStringList(SrvObj).CaseSensitive := True;
    SetLength(SrvVars, 0);
  end else
  begin
    Value := Null;
    SrvObj := nil;
    SetLength(SrvVars, 0);
  end;
end;

procedure TAggrValueHolderEh.AggrValue(const AValue: Variant);
begin
  if AggrFunc = svtSumEh then
    if VarIsNull(Value) then
      Value := AValue
    else
    begin
      if not VarIsNull(AValue) then
        Value := Value + AValue;
    end
  else if AggrFunc = svtCountEh then
  begin
    if not VarIsNull(AValue) then
    begin
      if VarIsNull(Value)
        then Value := 1
        else Value := Value + 1;
    end;
  end else if AggrFunc = svtCountDistinctEh then
  begin
    TStringList(SrvObj).Add(VarToStr(AValue))
  end else if AggrFunc = svtAvgEh then
  begin
    SrvVars[0] := SrvVars[0] + 1;
    if VarIsNull(SrvVars[1])
      then SrvVars[1] := AValue
      else SrvVars[1] := SrvVars[1] + AValue;
  end else if AggrFunc in [svtMaxEh, svtMinEh] then
  begin
    if VarIsNull(Value) then
      Value := AValue
    else if not VarIsNull(AValue) then
    begin
      if (AggrFunc = svtMaxEh) and (AValue > Value) then
        Value := AValue
      else if (AggrFunc = svtMinEh) and (AValue < Value) then
        Value := AValue
    end;
  end;
end;

function TAggrValueHolderEh.FinalizeAggregation: Variant;
var
  s: String;
  i: Integer;
  DistCnt: Integer;
  r: String;
begin
  if AggrFunc = svtAvgEh then
  begin
    if (SrvVars[0] = 0) or VarIsNull(SrvVars[1]) then
      Value := Null
    else
      Value := SrvVars[1] / SrvVars[0];
  end else if AggrFunc = svtCountDistinctEh then
  begin
    TStringList(SrvObj).Sort;
    s := '';
    r := '';
    DistCnt := 0;
    for i := 0 to TStringList(SrvObj).Count-1 do
    begin
      if s <> TStringList(SrvObj)[i] then
      begin
        Inc(DistCnt);
        s := TStringList(SrvObj)[i];
        r := r + s + sLineBreak;
      end;
    end;
    FreeAndNil(SrvObj);
    Value := DistCnt;
    OutputDebugString(PChar(r));
  end else
  begin
  end;
  Result := Value;
end;

function ExportPivotGridEhToOleExcel(Grid: TCustomPivotGridEh;
  Options: TPivotGridExportAsOLEXLSOptionsEh
//  ;const FileName: String = ''
  ): Variant;
var
  Workbook: Variant;
  FExcelApp: Variant;
  FActiveSheet: Variant;
//  FCurRow: Integer;
//  FDataRowCount: Integer;
//  FDefaultSizeDelta: Integer;
  FVarValues: Variant;
  i, j: Integer;
  STopLeft, SBottomRight: Variant;
  ARange: Variant;
begin
  FExcelApp := CreateOleObject('Excel.Application');

  FExcelApp.Application.EnableEvents := False;
  FExcelApp.Visible := True;
  Workbook := FExcelApp.WorkBooks.Add;
  FActiveSheet := Workbook.ActiveSheet;
//  FCurRow := 1;
//  FDataRowCount := 0;

//  FDefaultSizeDelta := FActiveSheet.Range['A1', 'A1'].Font.Size / GetFontSize(Grid.Font);
  FVarValues := VarArrayCreate([0, Grid.FullRowCount-1, 0, Grid.FullColCount-1], varVariant);

  for i := 0 to Grid.FullColCount-1 do
  begin
    for j := 0 to Grid.FullRowCount-1 do
    begin
      FVarValues[j, i] := Grid.VisPivotGridArray[i, j].Value;
    end;
  end;

  STopLeft := 'A1';
  SBottomRight := FActiveSheet.Cells.Item[Grid.FullRowCount-1, Grid.FullColCount-1];
  ARange := FActiveSheet.Range[STopLeft, SBottomRight];
  ARange.Value := FVarValues;
  ARange.Borders[1].LineStyle:=1;
  ARange.Borders[2].LineStyle:=1;
  ARange.Borders[3].LineStyle:=1;
  ARange.Borders[4].LineStyle:=1;
  ARange.Borders[9].LineStyle:=1;
  ARange.Borders[10].LineStyle:=1;

  SBottomRight := FActiveSheet.Cells.Item[Grid.FixedRowCount, Grid.FullColCount-1];
  ARange := FActiveSheet.Range[STopLeft, SBottomRight];
  ARange.Interior.Color := ColorToRGB(Grid.GridCellParams.ActualAxisColor);

  SBottomRight := FActiveSheet.Cells.Item[Grid.FullRowCount-1, Grid.FixedColCount];
  ARange := FActiveSheet.Range[STopLeft, SBottomRight];
  ARange.Interior.Color := ColorToRGB(Grid.GridCellParams.ActualAxisColor);

  Result := FExcelApp;
end;

{ TPivotGridCellParamsEh }

constructor TPivotGridCellParamsEh.Create(AGrid: TCustomPivotGridEh);
begin
  inherited Create;
  FGrid := AGrid;

  FParentAxisFont := True;
  FAxisFont := TFont.Create;
  FAxisFont.OnChange := FontChanged;
  RefreshDefaultAxisFont;
  FAxisColor := clDefault;

  FParentAxisAggregateFont := True;
  FAxisAggregateFont := TFont.Create;
  FAxisAggregateFont.OnChange := FontChanged;
  RefreshDefaultAxisAggregateFont;

  FParentDataFont := True;
  FDataFont := TFont.Create;
  FDataFont.OnChange := FontChanged;
  RefreshDefaultDataFont;
  FDataColor := clDefault;

  FParentDataAggregateFont := True;
  FDataAggregateFont := TFont.Create;
  FDataAggregateFont.OnChange := FontChanged;
  RefreshDefaultDataAggregateFont;
  FDataAggregateColor := clDefault;

  FParentFieldNameFont := True;
  FFieldNameFont := TFont.Create;
  FFieldNameFont.OnChange := FontChanged;
  RefreshDefaultFieldNameFont;
  FFieldNameColor := clDefault;
end;

destructor TPivotGridCellParamsEh.Destroy;
begin
  FreeAndNil(FAxisFont);
  FreeAndNil(FAxisAggregateFont);
  FreeAndNil(FDataFont);
  FreeAndNil(FDataAggregateFont);
  FreeAndNil(FFieldNameFont);
  inherited Destroy;
end;

function TPivotGridCellParamsEh.DefaultFont: TFont;
begin
  Result := Grid.Font;
end;

procedure TPivotGridCellParamsEh.FontChanged(Sender: TObject);
begin
  if Sender = FAxisFont then
      FParentAxisFont := False
  else if Sender = FAxisAggregateFont then
      FParentAxisAggregateFont := False
  else if Sender = FDataFont then
      FParentDataFont := False
  else if Sender = FDataAggregateFont then
      FParentDataAggregateFont := False
  else if Sender = FFieldNameFont then
      FParentFieldNameFont := False;
  Grid.GridCellParamsChanged;
end;

procedure TPivotGridCellParamsEh.AssignDefaultFontTo(const AFont: TFont);
var
  Save: TNotifyEvent;
begin
  Save := AFont.OnChange;
  AFont.OnChange := nil;
  try
    AFont.Assign(DefaultFont);
  finally
    AFont.OnChange := Save;
  end;
end;

procedure TPivotGridCellParamsEh.RefreshDefaultDataAggregateFont;
begin
  if not FParentDataAggregateFont then Exit;
  AssignDefaultFontTo(FDataAggregateFont);
end;

procedure TPivotGridCellParamsEh.RefreshDefaultDataFont;
begin
  if not FParentDataFont then Exit;
  AssignDefaultFontTo(FDataFont);
end;

procedure TPivotGridCellParamsEh.RefreshDefaultFieldNameFont;
begin
  if not FParentFieldNameFont then Exit;
  AssignDefaultFontTo(FFieldNameFont);
end;

procedure TPivotGridCellParamsEh.RefreshDefaultAxisAggregateFont;
var
  Save: TNotifyEvent;
begin
  if not FParentAxisAggregateFont then Exit;
  Save := FAxisAggregateFont.OnChange;
  FAxisAggregateFont.OnChange := nil;
  try
    FAxisAggregateFont.Assign(DefaultFont);
    FAxisAggregateFont.Style := FAxisAggregateFont.Style + [fsBold];
  finally
    FAxisAggregateFont.OnChange := Save;
  end;
end;

procedure TPivotGridCellParamsEh.RefreshDefaultAxisFont;
begin
  if not FParentAxisFont then Exit;
  AssignDefaultFontTo(FAxisFont);
end;

function TPivotGridCellParamsEh.ActualDataColor: TColor;
begin
  if DataColor = clDefault
    then Result := Grid.Color
    else Result := DataColor;
end;

function TPivotGridCellParamsEh.ActualDataAggregateColor: TColor;
begin
  if DataAggregateColor = clDefault
    then Result := clCream
    else Result := DataAggregateColor;
end;

function TPivotGridCellParamsEh.ActualFieldNameColor: TColor;
begin
  if FieldNameColor = clDefault
    then Result := clSkyBlue
    else Result := FieldNameColor;
end;

function TPivotGridCellParamsEh.ActualAxisColor: TColor;
begin
  if AxisColor = clDefault
    then Result := Grid.FixedColor
    else Result := AxisColor;
end;

procedure TPivotGridCellParamsEh.SetDataAggregateColor(const Value: TColor);
begin
  if FDataAggregateColor <> Value then
  begin
    FDataAggregateColor := Value;
    Grid.GridCellParamsChanged;
  end;
end;

procedure TPivotGridCellParamsEh.SetDataAggregateFont(const Value: TFont);
begin
  FDataAggregateFont.Assign(Value);
end;

procedure TPivotGridCellParamsEh.SetDataColor(const Value: TColor);
begin
  if FDataColor <> Value then
  begin
    FDataColor := Value;
    Grid.GridCellParamsChanged;
  end;
end;

procedure TPivotGridCellParamsEh.SetDataFont(const Value: TFont);
begin
  FDataFont.Assign(Value);
end;

procedure TPivotGridCellParamsEh.SetFieldNameColor(const Value: TColor);
begin
  if FFieldNameColor <> Value then
  begin
    FFieldNameColor := Value;
    Grid.GridCellParamsChanged;
  end;
end;

procedure TPivotGridCellParamsEh.SetFieldNameFont(const Value: TFont);
begin
  FFieldNameFont.Assign(Value);
end;

procedure TPivotGridCellParamsEh.SetAxisAggregateFont(const Value: TFont);
begin
  FAxisAggregateFont.Assign(Value);
end;

procedure TPivotGridCellParamsEh.SetAxisColor(const Value: TColor);
begin
  if FAxisColor <> Value then
  begin
    FAxisColor := Value;
    Grid.GridCellParamsChanged;
  end;
end;

procedure TPivotGridCellParamsEh.SetAxisFont(const Value: TFont);
begin
  FAxisFont.Assign(Value);
end;

procedure TPivotGridCellParamsEh.SetParentDataAggregateFont(const Value: Boolean);
begin
  if FParentDataAggregateFont <> Value then
  begin
    FParentDataAggregateFont := Value;
    RefreshDefaultDataAggregateFont;
    Grid.GridCellParamsChanged;
  end;
end;

procedure TPivotGridCellParamsEh.SetParentDataFont(const Value: Boolean);
begin
  if FParentDataFont <> Value then
  begin
    FParentDataFont := Value;
    RefreshDefaultDataFont;
    Grid.GridCellParamsChanged;
  end;
end;

procedure TPivotGridCellParamsEh.SetParentFieldNameFont(const Value: Boolean);
begin
  if FParentFieldNameFont <> Value then
  begin
    FParentFieldNameFont := Value;
    RefreshDefaultFieldNameFont;
    Grid.GridCellParamsChanged;
  end;
end;

procedure TPivotGridCellParamsEh.SetParentAxisAggregateFont(const Value: Boolean);
begin
  if FParentAxisAggregateFont <> Value then
  begin
    FParentAxisAggregateFont := Value;
    RefreshDefaultAxisAggregateFont;
    Grid.GridCellParamsChanged;
  end;
end;

procedure TPivotGridCellParamsEh.SetParentAxisFont(const Value: Boolean);
begin
  if FParentAxisFont <> Value then
  begin
    FParentAxisFont := Value;
    RefreshDefaultAxisFont;
    Grid.GridCellParamsChanged;
  end;
end;

function TPivotGridCellParamsEh.IsAxisAggregateFontStored: Boolean;
begin
  Result := not ParentAxisAggregateFont;
end;

function TPivotGridCellParamsEh.IsAxisFontStored: Boolean;
begin
  Result := not ParentAxisFont;
end;

function TPivotGridCellParamsEh.IsDataAggregateFontStored: Boolean;
begin
  Result := not ParentDataAggregateFont;
end;

function TPivotGridCellParamsEh.IsDataFontStored: Boolean;
begin
  Result := not ParentDataFont;
end;

function TPivotGridCellParamsEh.IsFieldNameFontStored: Boolean;
begin
  Result := not ParentFieldNameFont;
end;

initialization
  InitPivotGridEh;
finalization
  FinalyPivotGridEh;
end.
