{*******************************************************}
{                                                       }
{                       EhLib v7.0                      }
{                   DBGridEhGrouping                    }
{                      Build 7.0.05                     }
{                                                       }
{      Copyright (c) 2001-2012 by Dmitry V. Bolshakov   }
{                                                       }
{*******************************************************}

unit DBGridEhGrouping;

{$I EhLib.Inc}

interface

uses SysUtils, Classes, Controls, Forms, Dialogs,
{$IFDEF CIL}
  EhLibVCLNET,
  System.Runtime.InteropServices, System.Reflection,
{$ELSE}
{$IFDEF FPC}
  EhLibLCL, LCLType, Win32Extra,
{$ELSE}
  EhLibVCL, Messages,
{$ENDIF}
{$ENDIF}
{$IFDEF EH_LIB_6} Variants, Types, {$ENDIF}
  Graphics, GridsEh, DBAxisGridsEh,
  DBCtrls, Db, Menus, DBCtrlsEh,
// {PropFilerEh, }
  ToolCtrlsEh, MemTreeEh;

type
  TGridGroupDataTreeEh = class;
  TGridDataGroupsEh = class;
  TGridDataGroupLevelsEh = class;
  TGroupDataTreeNodeEh = class;
  TGridDataGroupFooterColumnItemsEh = class;
  TGridDataGroupFooterEh = class;
  TGridDataGroupFooterColumnItemEh = class;
  TGridDataGroupFootersEh = class;
  TGridDataGroupFootersDefValuesEh = class;
  TGridDataGroupRowDefValuesEh = class;

  TGridDataGroupFooterEhClass = class of TGridDataGroupFooterEh;
  TGridDataGroupFooterColumnItemEhClass = class of TGridDataGroupFooterColumnItemEh;

{  TGroupRowPanelInfoEh = class(TPersistent)
  public
  end;}

  { TGridGroupLinePenEh }

  TGridGroupLinePenEh = class(TPersistent)
  protected
    FOwner: TPersistent;
    FColor: TColor;
    FWidth: Integer;
    function GetColor: TColor; virtual;
    function GetWidth: Integer; virtual;
    procedure SetColor(const Value: TColor); virtual;
    procedure SetWidth(const Value: Integer); virtual;
  public
    constructor Create(ARowDefValues: TGridDataGroupRowDefValuesEh);
    destructor Destroy; override;
  published
    property Color: TColor read GetColor write SetColor default clDefault;
    property Width: Integer read GetWidth write SetWidth default 1;
  end;

{ TGridDataGroupRowDefValuesEh }

  TGridDataGroupRowDefValuesEh = class(TPersistent)
  private
    FFooterInGroupRow: Boolean;
    FRowHeight: Integer;
    FRowLines: Integer;
    FBottomLine: TGridGroupLinePenEh;
    procedure SetFooterInGroupRow(const Value: Boolean);
    procedure SetRowHeight(const Value: Integer);
    procedure SetRowLines(const Value: Integer);
    procedure SetBottomLine(const Value: TGridGroupLinePenEh);
  protected
    FDataGroups: TGridDataGroupsEh;

  public
    procedure Assign(Source: TPersistent); override;
    constructor Create(ADataGroups: TGridDataGroupsEh);
    destructor Destroy; override;

  published
    property FooterInGroupRow: Boolean read FFooterInGroupRow write SetFooterInGroupRow default False;
    property RowHeight: Integer read FRowHeight write SetRowHeight default 0;
    property RowLines: Integer read FRowLines write SetRowLines default 0;
    property BottomLine: TGridGroupLinePenEh read FBottomLine write SetBottomLine;
//    property BottomLineColor: TColor read GetBottomLineColor write SetBottomLineColor;
//    property BottomLineWidth: Integer read GetBottomLineWidth write SetBottomLineWidth;
//    property BottomLineStyle: Integer read GetBottomLineWidth write SetBottomLineWidth;
  end;

{ TGridDataGroupLevelEh }

  TGridDataGroupLevelEh = class(TCollectionItem)
  private
//    FBandPositions: TIntegerDynArray;
    FColor: TColor;
    FColumn: TPersistent;
    FFont: TFont;
    FGroupPanelRect: TRect;
    FOnGetKeyValue: TNotifyEvent;
    FOnGetTitleText: TNotifyEvent;
    FParentColor: Boolean;
    FParentFont: Boolean;
    FRowHeight: Integer;
    FRowLines: Integer;
    FSortOrder: TSortOrderEh;
    FFooters: TGridDataGroupFootersEh;
    FParentFooters: Boolean;
    FFooterInGroupRow: Boolean;
    FFooterInGroupRowStored: Boolean;
    FRowHeightStored: Boolean;
    FRowLinesStored: Boolean;
    function GetColor: TColor;
    function GetFont: TFont;
    function IsColorStored: Boolean;
    function IsFontStored: Boolean;
    procedure SetColor(const Value: TColor);
    procedure SetColumn(const Value: TPersistent);
    procedure SetFont(const Value: TFont);
    procedure SetOnGetKeyValue(const Value: TNotifyEvent);
    procedure SetOnGetTitleText(const Value: TNotifyEvent);
    procedure SetParentColor(const Value: Boolean);
    procedure SetParentFont(const Value: Boolean);
    procedure SetRowHeight(const Value: Integer);
    procedure SetRowLines(const Value: Integer);
    procedure SetSortOrder(const Value: TSortOrderEh);
    procedure SetFooters(const Value: TGridDataGroupFootersEh);
    procedure SetParentFooters(const Value: Boolean);
    function GetVisibleFooter(const Index: Integer): TGridDataGroupFooterEh;
    function GetVisibleFootersCount: Integer;
    procedure SetFooterInGroupRow(const Value: Boolean);
    function DefaultFooterInGroupRow: Boolean;
    function GetFooterInGroupRow: Boolean;
    function IsFooterInGroupRowStored: Boolean;
    procedure SetFooterInGroupRowStored(const Value: Boolean);
    function GetRowHeight: Integer;
    function GetRowLines: Integer;
    function IsRowHeightStored: Boolean;
    procedure SetRowHeightStored(const Value: Boolean);
    function DefaultRowHeight: Integer;
    function IsRowLinesStored: Boolean;
    procedure SetRowLinesStored(const Value: Boolean);
    function DefaultRowLines: Integer;
  protected
    function DefaultColor: TColor;
    function DefaultFooterColor: TColor; virtual;
    function DefaultFooterFont: TFont; virtual;
    function DefaultFont: TFont;
    function GetDisplayName: string; override;
    procedure DrawFormatChanged; virtual;
    procedure FontChanged(Sender: TObject);
    procedure RefreshDefaultFont;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    function GetGroupRowText(GroupDataTreeNode: TGroupDataTreeNodeEh): String; virtual;
    function GetKeyValue: Variant; virtual;
    function GetKeyValueAsText(GroupDataTreeNode: TGroupDataTreeNodeEh): String; virtual;
    function GridDataGroupLevels: TGridDataGroupLevelsEh;
    function UsedFooters: TGridDataGroupFootersEh;
    procedure CollapseNodes;
    procedure ExtractNodes;
    procedure ExpandNodes;
    property Color: TColor read GetColor write SetColor stored IsColorStored;
    property Column: TPersistent read FColumn write SetColumn;
    property Font: TFont read GetFont write SetFont stored IsFontStored;
    property GroupPanelRect: TRect read FGroupPanelRect write FGroupPanelRect;
    property ParentColor: Boolean read FParentColor write SetParentColor default True;
    property ParentFont: Boolean read FParentFont write SetParentFont default True;
    property ParentFooters: Boolean read FParentFooters write SetParentFooters default True;
    property RowHeight: Integer read GetRowHeight write SetRowHeight stored IsRowHeightStored;
    property RowHeightStored: Boolean read IsRowHeightStored write SetRowHeightStored stored False;
    property RowLines: Integer read GetRowLines write SetRowLines stored IsRowHeightStored;
    property RowLinesStored: Boolean read IsRowLinesStored write SetRowLinesStored stored False;
    property SortOrder: TSortOrderEh read FSortOrder write SetSortOrder default soAscEh;

    property VisibleFooter[const Index: Integer]: TGridDataGroupFooterEh read GetVisibleFooter;
    property VisibleFootersCount: Integer read GetVisibleFootersCount;

    property Footers: TGridDataGroupFootersEh read FFooters write SetFooters;
    property FooterInGroupRow: Boolean read GetFooterInGroupRow write SetFooterInGroupRow stored IsFooterInGroupRowStored;
    property FooterInGroupRowStored: Boolean read IsFooterInGroupRowStored write SetFooterInGroupRowStored stored False;

    property OnGetKeyValue: TNotifyEvent read FOnGetKeyValue write SetOnGetKeyValue;
    property OnGetTitleText: TNotifyEvent read FOnGetTitleText write SetOnGetTitleText;
//    property BandPositions: TIntegerDynArray read FBandPositions;
//    property RowPanelInfo: TGroupRowPanelInfoEh read FRowPanelInfo write FRowPanelInfo;
  end;

{ TGridDataGroupLevelsEh }

  TGridDataGroupLevelsEh = class(TCollection)
  private
    FDataGroups: TGridDataGroupsEh;
    function GetDataGroup(Index: Integer): TGridDataGroupLevelEh;
    procedure SetDataGroup(Index: Integer; const Value: TGridDataGroupLevelEh);
    function GetGrid: TComponent;
  protected
    procedure Update(Item: TCollectionItem); override;
    function GetOwner: TPersistent; override;
    procedure RefreshDefaultFont;
    procedure OrderChanged(Item: TGridDataGroupLevelEh); virtual;
  public
    constructor Create(DataGroups: TGridDataGroupsEh; ItemClass: TCollectionItemClass);
    function Add: TGridDataGroupLevelEh;
    function DataGroup: TGridDataGroupsEh;
    property Grid: TComponent read GetGrid;
    property Items[Index: Integer]: TGridDataGroupLevelEh read GetDataGroup write SetDataGroup; default;
  end;

{ TGridDataGroupsEh }

  TGridDataGroupsEh = class(TPersistent)
  private
    FActive: Boolean;
    FActiveGroupColumns: TList;
    FActiveGroupLevels: TList;
    FColor: TColor;
    FFont: TFont;
    FGrid: TComponent;
    FGroupDataTree: TGridGroupDataTreeEh;
    FGroupLevels: TGridDataGroupLevelsEh;
    FGroupPanelVisible: Boolean;
    FInsertingKeyValue: Variant;
    FParentColor: Boolean;
    FParentFont: Boolean;
    FDefaultStateExpanded: Boolean;
    FFooters: TGridDataGroupFootersEh;
    FFootersDefValues: TGridDataGroupFootersDefValuesEh;
    FGroupRowDefValues: TGridDataGroupRowDefValuesEh;
    FShiftFolldataGroupRow: Boolean;
    FColumsLoaded: Boolean;
    function GetActiveGroupLevels(const Index: Integer): TGridDataGroupLevelEh;
    function GetActiveGroupLevelsCount: Integer;
    function GetColor: TColor;
    function GetFont: TFont;
    function IsColorStored: Boolean;
    function IsFontStored: Boolean;
    function IsGroupLevelsStored: Boolean;
    procedure SetActive(const Value: Boolean);
    procedure SetColor(const Value: TColor);
    procedure SetFont(const Value: TFont);
    procedure SetGroupLevels(const Value: TGridDataGroupLevelsEh);
    procedure SetGroupPanelVisible(const Value: Boolean);
    procedure SetParentColor(const Value: Boolean);
    procedure SetParentFont(const Value: Boolean);
    procedure SetFooters(const Value: TGridDataGroupFootersEh);
    function IsFootersStored: Boolean;
    procedure SetFootersDefValues(const Value: TGridDataGroupFootersDefValuesEh);
    procedure SetGroupRowDefValues(const Value: TGridDataGroupRowDefValuesEh);
    procedure SetShiftFolldataGroupRow(const Value: Boolean);
  protected
    function CreateGroupLevels: TGridDataGroupLevelsEh; virtual;
    function DefaultColor: TColor; virtual;
    function DefaultFooterColor: TColor; virtual;
    function DefaultFooterFont: TFont; virtual;
    function DefaultFont: TFont; virtual;
    function GetOwner: TPersistent; override;
    procedure ActiveChanged; virtual;
    procedure ActiveGroupingStructChanged; virtual;
    procedure CheckActiveGroupLevels;
    procedure DrawFormatChanged; virtual;
    procedure FontChanged(Sender: TObject);
    procedure RebuildActiveGroupLevels; virtual;
    procedure RefreshDefaultFont;
    procedure ResortActiveLevel(LevelIndex: Integer; SortOrder: TSortOrderEh); virtual;
  public
    constructor Create(AGrid: TComponent);
    destructor Destroy; override;
    function GetKeyValueForViewRecNo(ViewRecNo: Integer): Variant;
    function IsGroupingWorks: Boolean; virtual;
    procedure Assign(Source: TPersistent); override;
    procedure SetInsertingKeyValue(KeyValue: Variant);
    procedure FooterStructureChanged; virtual;
    procedure FooterValuesChanged; virtual;
    procedure ColumnsChanged; virtual;
    procedure ColumnsLoaded; virtual;
    property ActiveGroupLevels[const Index: Integer]: TGridDataGroupLevelEh read GetActiveGroupLevels;
    property ActiveGroupLevelsCount: Integer read GetActiveGroupLevelsCount;
    property GroupDataTree: TGridGroupDataTreeEh read FGroupDataTree;
  published
    property Active: Boolean read FActive write SetActive default False;
    property Color: TColor read GetColor write SetColor stored IsColorStored;
    property Font: TFont read GetFont write SetFont stored IsFontStored;
    property GroupLevels: TGridDataGroupLevelsEh read FGroupLevels write SetGroupLevels stored IsGroupLevelsStored;
    property Footers: TGridDataGroupFootersEh read FFooters write SetFooters stored IsFootersStored;
    property FootersDefValues: TGridDataGroupFootersDefValuesEh read FFootersDefValues write SetFootersDefValues;
    property GroupPanelVisible: Boolean read FGroupPanelVisible write SetGroupPanelVisible default False;
    property ParentColor: Boolean read FParentColor write SetParentColor default True;
    property ParentFont: Boolean read FParentFont write SetParentFont default True;
    property DefaultStateExpanded: Boolean read FDefaultStateExpanded write FDefaultStateExpanded default False;
    property GroupRowDefValues: TGridDataGroupRowDefValuesEh read FGroupRowDefValues write SetGroupRowDefValues;
    property ShiftFolldataGroupRow: Boolean read FShiftFolldataGroupRow write SetShiftFolldataGroupRow default True;
  end;

  TGroupDataTreeNodeTypeEh = (dntDataSetRecordEh, dntDataGroupEh, dntDataGroupFooterEh);

{ TGroupDataTreeNodeEh }

  TGroupDataTreeNodeEh = class(TBaseTreeNodeEh)
  private
    FDataGroupLevel: TGridDataGroupLevelEh;
    FDataGroupFooter: TGridDataGroupFooterEh;
    FDataSetRecordViewNo: Integer;
    FDisplayValue: String;
    FFooterItemCount: Integer;
    FFooterValue: array of Variant;
    FFullKey: Variant;
    FGroupDataTreeNodeType: TGroupDataTreeNodeTypeEh;
    FKeyValue: Variant;
    FRowHeight: Integer;
    FRowHeightNeedUpdate: Boolean;
    function GetCount: Integer;
    function GetDataItem(const Index: Integer): TGroupDataTreeNodeEh;
    function GetFooterItem(const Index: Integer): TGroupDataTreeNodeEh;
    function GetFooterItemCount: Integer;
    function GetFooterValueCount: Integer;
    function GetFooterValues(const Index: Integer): Variant;
    function GetFullItemCount: Integer;
    function GetParent: TGroupDataTreeNodeEh;
    function GetRowHeight: Integer;
    procedure SetFooterItemCount(const Value: Integer);
    procedure SetRowHeight(const Value: Integer);
  protected
    function GetOwner: TGridGroupDataTreeEh; reintroduce;
    procedure SortData(CompareProg: TCompareNodesEh; ParamSort: TObject; ARecurse: Boolean = True); override;
  public
    function CanAppendDataRec: Boolean;
    function RecordNodeLastInGroup: Boolean;
    procedure AppendDataRec(AIntMemTable: IMemTableEh; ADataSet: TDataSet);
    procedure RowDataChanged;
    procedure UpdateRowHeight;
    procedure ResetFooters;
    property Count read GetCount;
    property DataGroupFooter: TGridDataGroupFooterEh read FDataGroupFooter;
    property DataGroupLevel: TGridDataGroupLevelEh read FDataGroupLevel;
    property DataSetRecordViewNo: Integer read FDataSetRecordViewNo;
    property Expanded;
    property FullKey: Variant read FFullKey;
    property Items[const Index: Integer]: TGroupDataTreeNodeEh read GetDataItem; default;
    property KeyValue: Variant read FKeyValue;
    property DisplayValue: String read FDisplayValue;
    property Level;
    property NodeType: TGroupDataTreeNodeTypeEh read FGroupDataTreeNodeType;
    property Owner: TGridGroupDataTreeEh read GetOwner;
    property Parent: TGroupDataTreeNodeEh read GetParent;
    property RowHeight: Integer read GetRowHeight write SetRowHeight;
    property RowHeightNeedUpdate: Boolean read FRowHeightNeedUpdate;
    property FooterItems[const Index: Integer]: TGroupDataTreeNodeEh read GetFooterItem;
    property FooterItemCount: Integer read GetFooterItemCount write SetFooterItemCount;
    property FullItemCount: Integer read GetFullItemCount;
    property FooterValues[const Index: Integer]: Variant read GetFooterValues;
    property FooterValueCount: Integer read GetFooterValueCount;
  end;

{ TGridGroupDataTreeEh }

  TGridGroupDataTreeEh = class(TTreeListEh)
  private
    FGridDataGroups: TGridDataGroupsEh;
    FlatVisibleList: TList;
    FUpateCount: Integer;
    function GetFlatVisibleItem(const Index: Integer): TGroupDataTreeNodeEh;
    function GetVisibleCount: Integer;
    function GetRoot: TGroupDataTreeNodeEh;
    procedure SetRoot(const Value: TGroupDataTreeNodeEh);
  protected
    procedure ExpandedChanged(Node: TBaseTreeNodeEh); override;
    procedure CollapseLevel(LevelIndex: Integer);
    procedure ExpandLevel(LevelIndex: Integer);
    procedure AggregateValuesForDataNode(Node: TGroupDataTreeNodeEh);
  public
    constructor Create(AGridDataGroups: TGridDataGroupsEh; ItemClass: TTreeNodeClassEh);
    destructor Destroy; override;
    function AddChildDataNode(const Text: string; Parent: TGroupDataTreeNodeEh; Data: TObject): TGroupDataTreeNodeEh;
    function AddRecordNodeForKey(AKey: Variant; RecViewNo: Integer): TGroupDataTreeNodeEh;
    function CompareNodes(Node1, Node2: TBaseTreeNodeEh; ParamSort: TObject): Integer;
    function GetFirstNodeAtLevel(Level: Integer): TGroupDataTreeNodeEh;
    function GetNextNodeAtLevel(Node: TGroupDataTreeNodeEh; Level: Integer): TGroupDataTreeNodeEh;
    function GetNodeByRecordViewNo(RecordViewNo: Integer): TGroupDataTreeNodeEh;
    function GetNodeToInsertForKey1(ParentNode: TGroupDataTreeNodeEh; Key1: Variant; SortOrder: TSortOrderEh; var InsertMode: TNodeAttachModeEh): TGroupDataTreeNodeEh;
    function IndexOfVisibleNode(Node: TGroupDataTreeNodeEh): Integer;
    function IndexOfVisibleRecordViewNo(RecordViewNo: Integer): Integer;
    function GetFirst: TGroupDataTreeNodeEh;
    function GetFirstVisible: TGroupDataTreeNodeEh;
    function GetNext(Node: TGroupDataTreeNodeEh): TGroupDataTreeNodeEh;
    function GetNextVisible(Node: TGroupDataTreeNodeEh; ConsiderCollapsed: Boolean): TGroupDataTreeNodeEh;
    function GetPrevious(Node: TGroupDataTreeNodeEh): TGroupDataTreeNodeEh;
    function GetPathVisible(Node: TGroupDataTreeNodeEh; ConsiderCollapsed: Boolean): Boolean;

    procedure AddDataNode(Node, Destination: TGroupDataTreeNodeEh; Mode: TNodeAttachModeEh; ReIndex: Boolean);
    procedure BeginUpdate;
    procedure DeleteEmptyNodes;
    procedure DeleteRecordNode(RecNode: TGroupDataTreeNodeEh);
    procedure DeleteRecordNodes;
    procedure DeleteRecordNodesUpToLevel(Level: Integer);
    procedure EndUpdate;
    procedure ExpandNodePathToView(Node: TGroupDataTreeNodeEh);
    procedure RebuildFooters;
    procedure RecalculateFootersValues;
    procedure RebuildDataTree(AIntMemTable: IMemTableEh);
    procedure RebuildDataTreeEx(AIntMemTable: IMemTableEh);
    procedure RebuildFlatVisibleList;
    procedure RecordChanged(RecNum: Integer);
    procedure RecordDeleted(RecNum: Integer);
    procedure RecordInserted(RecNum: Integer);
    procedure ResortLevel(LevelIndex: Integer; SortOrder: TSortOrderEh);
    procedure SetDataSetkeyValue;
    procedure UpdateAllDataRowHeights;
    procedure UpdateRecordNodePosInTree(RecNode: TGroupDataTreeNodeEh);
    procedure Collapse(Node: TGroupDataTreeNodeEh; Recurse: Boolean);
    procedure Expand(Node: TGroupDataTreeNodeEh; Recurse: Boolean);

    property FlatVisibleCount: Integer read GetVisibleCount;
    property FlatVisibleItem[const Index: Integer]: TGroupDataTreeNodeEh read GetFlatVisibleItem;
    property GridDataGroups: TGridDataGroupsEh read FGridDataGroups;
    property Root: TGroupDataTreeNodeEh read GetRoot write SetRoot;
    property UpdateCount: Integer read FUpateCount;
  end;

{ TGridDataGroupFootersDefValuesEh }

  TGridDataGroupFootersDefValuesEh = class(TPersistent)
  private
    FShowFunctionName: Boolean;
    FRunTimeCustomizable: Boolean;
    procedure SetRunTimeCustomizable(const Value: Boolean);
    procedure SetShowFunctionName(const Value: Boolean);
  protected
    FDataGroups: TGridDataGroupsEh;
  public
    procedure Assign(Source: TPersistent); override;
  published
    constructor Create(ADataGroups: TGridDataGroupsEh);
    property ShowFunctionName: Boolean read FShowFunctionName write SetShowFunctionName default False;
    property RunTimeCustomizable: Boolean read FRunTimeCustomizable write SetRunTimeCustomizable default False;
  end;

{ TGridDataGroupFootersEh }

  TGridDataGroupFootersEh = class(TCollection)
  private
    FOwner: TPersistent;
    FVisibleFooters: array of TGridDataGroupFooterEh;
    function GetFooter(Index: Integer): TGridDataGroupFooterEh;
    procedure SetFooter(Index: Integer; const Value: TGridDataGroupFooterEh);
    function GetVisibleFooter(Index: Integer): TGridDataGroupFooterEh;
    function GetVisibleItemsCount: Integer;
  protected
    function GetOwner: TPersistent; override;
    function GridComponent: TComponent;
    procedure DrawFormatChanged; virtual;
    procedure StructureChanged; virtual;
    procedure FooterValuesChanged; virtual;
    procedure RefreshDefaultFont;
    procedure RefreshVisibleFooters;
  public
    constructor Create(Owner: TPersistent; FooterClass: TGridDataGroupFooterEhClass);
    function Add: TGridDataGroupFooterEh;
    function GroupLevel: TGridDataGroupLevelEh;
    function Groups: TGridDataGroupsEh;
    function GetMasterGroups: TGridDataGroupsEh;
    property Items[Index: Integer]: TGridDataGroupFooterEh read GetFooter write SetFooter; default;
    property VisibleItems[Index: Integer]: TGridDataGroupFooterEh read GetVisibleFooter;
    property VisibleItemsCount: Integer read GetVisibleItemsCount;
  end;

{ TGridDataGroupFooterEh }

  TGridDataGroupFooterEh = class(TCollectionItem)
  private
    FColumnItems: TGridDataGroupFooterColumnItemsEh;
    FFont: TFont;
    FColor: TColor;
    FParentColor: Boolean;
    FParentFont: Boolean;
    FVisible: Boolean;
    FRowHeightNeedUpdate: Boolean;
//    FShowRowInGridFooter: Boolean;
    FShowFunctionName: Boolean;
    FRunTimeCustomizable: Boolean;
    FRunTimeCustomizableStored: Boolean;
    FShowFunctionNameStored: Boolean;
    function GetColor: TColor;
    function GetColumnItems: TGridDataGroupFooterColumnItemsEh;
    function GetFont: TFont;
//    function GetInGroupRow: Boolean;
//    function GetShowWhenGroupCollapsed: Boolean;
    function GetVisible: Boolean;
    function IsColorStored: Boolean;
    function IsFontStored: Boolean;
    procedure SetColor(const Value: TColor);
    procedure SetColumnItems(const Value: TGridDataGroupFooterColumnItemsEh);
    procedure SetFont(const Value: TFont);
//    procedure SetInGroupRow(const Value: Boolean);
    procedure SetParentColor(const Value: Boolean);
    procedure SetParentFont(const Value: Boolean);
//    procedure SetShowWhenGroupCollapsed(const Value: Boolean);
    procedure SetVisible(const Value: Boolean);
    function GetRowHeight: Integer;
    procedure SetRowHeight(const Value: Integer);
//    function GetShowRowInGridFooter: Boolean;
//    procedure SetShowRowInGridFooter(const Value: Boolean);
    procedure SetShowFunctionName(const Value: Boolean);
    function GetRunTimeCustomizable: Boolean;
    function IsRunTimeCustomizableStored: Boolean;
    procedure SetRunTimeCustomizable(const Value: Boolean);
    procedure SetRunTimeCustomizableStored(const Value: Boolean);
    function IsShowFunctionNameStored: Boolean;
    procedure SetShowFunctionNameStored(const Value: Boolean);
    function GetShowFunctionName: Boolean;
    function StoreColumnItems: Boolean;
  protected
    FAutoCalcHeight: Integer;
    function DefaultColor: TColor;
    function DefaultFont: TFont;
    function CheckColumnsChanged(Columns: TCollection): Boolean; virtual;
    function GetDisplayName: string; override;

    procedure DrawFormatChanged; virtual;
    procedure FontChanged(Sender: TObject);
    procedure RefreshDefaultFont;
    procedure FooterValuesChanged; virtual;
    procedure ColumnsLoaded(Columns: TCollection);

  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function DefaultRunTimeCustomizable: Boolean; virtual;
    function DefaultShowFunctionName: Boolean;
    function FootersCollection: TGridDataGroupFootersEh;
    property RowHeight: Integer read GetRowHeight write SetRowHeight;
    property RowHeightNeedUpdate: Boolean read FRowHeightNeedUpdate;
  published
    property Color: TColor read GetColor write SetColor stored IsColorStored;
    property Font: TFont read GetFont write SetFont stored IsFontStored;
//    property InGroupRow: Boolean read GetInGroupRow write SetInGroupRow;
    property Visible: Boolean read GetVisible write SetVisible;
//    property ShowWhenGroupCollapsed: Boolean read GetShowWhenGroupCollapsed write SetShowWhenGroupCollapsed;
//    property ShowRowInGridFooter: Boolean read GetShowRowInGridFooter write SetShowRowInGridFooter;
    property ColumnItems: TGridDataGroupFooterColumnItemsEh read GetColumnItems write SetColumnItems stored StoreColumnItems;
    property ParentColor: Boolean read FParentColor write SetParentColor default True;
    property ParentFont: Boolean read FParentFont write SetParentFont default True;
    property ShowFunctionName: Boolean read GetShowFunctionName write SetShowFunctionName stored IsShowFunctionNameStored;
    property ShowFunctionNameStored: Boolean read IsShowFunctionNameStored write SetShowFunctionNameStored stored False;
    property RunTimeCustomizable: Boolean read GetRunTimeCustomizable write SetRunTimeCustomizable stored IsRunTimeCustomizableStored;
    property RunTimeCustomizableStored: Boolean read IsRunTimeCustomizableStored write SetRunTimeCustomizableStored stored False;
  end;

{ TGridDataGroupFooterColumnItemsEh }

  TGridDataGroupFooterColumnItemsEh = class(TCollection)
  private
    FOwner: TGridDataGroupFooterEh;
    function GetItem(Index: Integer): TGridDataGroupFooterColumnItemEh;
    procedure SetItem(Index: Integer; const Value: TGridDataGroupFooterColumnItemEh);
  protected
    function Add: TGridDataGroupFooterColumnItemEh;
    function GetOwner: TPersistent; override;
    function Footer: TGridDataGroupFooterEh;
    procedure Update(Item: TCollectionItem); override;
    procedure RefreshDefaultFont;
    procedure ResetItems;
    procedure FooterValuesChanged; virtual;
  public
    function ItemIndexByColumn(Column: TCollectionItem): Integer;
    constructor Create(Owner: TGridDataGroupFooterEh; ItemClass: TGridDataGroupFooterColumnItemEhClass);
    procedure Assign(Source: TPersistent); override;
    property Items[Index: Integer]: TGridDataGroupFooterColumnItemEh read GetItem write SetItem; default;
  end;

{ Every group column item in the footer corresponds to a column in the grid }
{ TGridDataGroupFooterColumnItemEh }

  TGroupFooterValueTypeEh = (gfvNonEh, gfvSumEh, gfvAvgEh, gfvCountEh,
    gfvMaxEh, gfvMinEh, gfvStaticTextEh, gfvCustomEh);

  TGridDataGroupFooterColumnItemEh = class(TCollectionItem)
  private
    FAlignment: TAlignment;
    FFont: TFont;
    FColor: TColor;
    FParentColor: Boolean;
    FParentFont: Boolean;
    FValueType: TGroupFooterValueTypeEh;
    FColumn: TPersistent;
    FFieldName: String;
    FDisplayFormat: String;
    FShowFunctionName: Boolean;
    FShowFunctionNameStored: Boolean;
    FRunTimeCustomizable: Boolean;
    FRunTimeCustomizableStored: Boolean;
    function GetAlignment: TAlignment;
    function GetCollection: TGridDataGroupFooterColumnItemsEh;
    function GetColor: TColor;
    function GetFont: TFont;
    function IsColorStored: Boolean;
    function IsFontStored: Boolean;
    procedure SetColor(const Value: TColor);
    procedure SetFont(const Value: TFont);
    procedure SetParentColor(const Value: Boolean);
    procedure SetParentFont(const Value: Boolean);
    procedure SetValueType(const Value: TGroupFooterValueTypeEh);
    procedure SetAlignment(const Value: TAlignment);
    procedure SetDisplayFormat(const Value: String);
    procedure SetShowFunctionName(const Value: Boolean);
    procedure SetShowFunctionNameStored(const Value: Boolean);
    function GetShowFunctionName: Boolean;
    function GetRunTimeCustomizable: Boolean;
    function IsRunTimeCustomizableStored: Boolean;
    procedure SetRunTimeCustomizable(const Value: Boolean);
    procedure SetRunTimeCustomizableStored(const Value: Boolean);
  protected
    function DefaultColor: TColor;
    function DefaultFont: TFont;
    function DefaultShowFunctionName: Boolean;
    function GetDisplayName: string; override;
    procedure DrawFormatChanged; virtual;
    procedure FontChanged(Sender: TObject);
    procedure RefreshDefaultFont;
    procedure SetCollection(const Value: TGridDataGroupFooterColumnItemsEh); reintroduce;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function Column: TPersistent;
    function CheckCustomAggregateValue(var AValue: Variant; Node: TGroupDataTreeNodeEh): Boolean;
    function CheckCustomFinalizeValue(var AValue: Variant): Boolean;
    function CheckCustomConvertToDisplayText(var AValue: Variant; var DisplayValue: String): Boolean;
    function DefaultRunTimeCustomizable: Boolean; virtual;
    function FieldName: String;
    function AggrValue(FooterNode: TGroupDataTreeNodeEh): Variant;
    function ConvertToDisplayText(AValue: Variant): String;
    function IsShowFunctionNameStored: Boolean; virtual;
    procedure AggregateValue(var AValue: Variant; Node: TGroupDataTreeNodeEh); virtual;
    procedure FinalizeValue(var AValue: Variant); virtual;
    property Collection: TGridDataGroupFooterColumnItemsEh read GetCollection write SetCollection;
  published
    property Alignment: TAlignment read GetAlignment write SetAlignment default taRightJustify;
    property Color: TColor read GetColor write SetColor stored IsColorStored;
    property DisplayFormat: String read FDisplayFormat write SetDisplayFormat;
//    property AverageValDisplayFormat: String read FDisplayFormat write SetDisplayFormat;
//  Aggregation {Type}
    property Font: TFont read GetFont write SetFont stored IsFontStored;
    property ParentColor: Boolean read FParentColor write SetParentColor default True;
    property ParentFont: Boolean read FParentFont write SetParentFont default True;
    property ValueType: TGroupFooterValueTypeEh read FValueType write SetValueType default gfvNonEh;
    property ShowFunctionName: Boolean read GetShowFunctionName write SetShowFunctionName stored IsShowFunctionNameStored;
    property ShowFunctionNameStored: Boolean read IsShowFunctionNameStored write SetShowFunctionNameStored stored False;
    property RunTimeCustomizable: Boolean read GetRunTimeCustomizable write SetRunTimeCustomizable stored IsRunTimeCustomizableStored;
    property RunTimeCustomizableStored: Boolean read IsRunTimeCustomizableStored write SetRunTimeCustomizableStored stored False;
  end;

implementation

{$IFDEF FPC}
uses DBGridsEh;
{$ELSE}
uses DBGridEh;
{$ENDIF}

type
  TCustomDBGridEhCrack = class(TCustomDBGridEh) end;

{ TGridDataGroupLevelsEh }

function TGridDataGroupLevelsEh.Add: TGridDataGroupLevelEh;
begin
  Result := TGridDataGroupLevelEh(inherited Add);
end;

constructor TGridDataGroupLevelsEh.Create(DataGroups: TGridDataGroupsEh; ItemClass: TCollectionItemClass);
begin
  inherited Create(ItemClass);
  FDataGroups := DataGroups;
end;

function TGridDataGroupLevelsEh.DataGroup: TGridDataGroupsEh;
begin
  Result := FDataGroups;
end;

function TGridDataGroupLevelsEh.GetDataGroup(Index: Integer): TGridDataGroupLevelEh;
begin
  Result := TGridDataGroupLevelEh(inherited Items[Index]);
end;

function TGridDataGroupLevelsEh.GetGrid: TComponent;
begin
  Result := FDataGroups.FGrid;
end;

function TGridDataGroupLevelsEh.GetOwner: TPersistent;
begin
  Result := FDataGroups;
end;

procedure TGridDataGroupLevelsEh.OrderChanged(Item: TGridDataGroupLevelEh);
var
  ActiveItemIndex: Integer;
begin
  ActiveItemIndex := FDataGroups.FActiveGroupLevels.IndexOf(Item);
  if ActiveItemIndex >= 0 then
    FDataGroups.ResortActiveLevel(ActiveItemIndex, Item.SortOrder);
end;

procedure TGridDataGroupLevelsEh.RefreshDefaultFont;
var
  i: Integer;
begin
  for i := 0 to Count-1 do
    Items[i].RefreshDefaultFont;
end;

procedure TGridDataGroupLevelsEh.SetDataGroup(Index: Integer; const Value: TGridDataGroupLevelEh);
begin
  Items[Index].Assign(Value);
end;

procedure TGridDataGroupLevelsEh.Update(Item: TCollectionItem);
begin
  inherited Update(Item);
  FDataGroups.CheckActiveGroupLevels;
  TCustomDBGridEhCrack(Grid).UpdateDesigner;
end;

{ TGridDataGroupsEh }

constructor TGridDataGroupsEh.Create(AGrid: TComponent);
begin
  inherited Create;
  FGrid := AGrid;
  FFootersDefValues := TGridDataGroupFootersDefValuesEh.Create(Self);
  FGroupRowDefValues := TGridDataGroupRowDefValuesEh.Create(Self);
  FGroupLevels := CreateGroupLevels;
  FGroupDataTree := TGridGroupDataTreeEh.Create(Self, TGroupDataTreeNodeEh);
  FFooters := TGridDataGroupFootersEh.Create(Self, TGridDataGroupFooterEh);
  FActiveGroupLevels := TList.Create;
  FActiveGroupColumns := TList.Create;
  FFont := TFont.Create;
  FFont.Assign(DefaultFont);
  FFont.OnChange := FontChanged;
  FColor := clWindow;
  FParentFont := True;
  FParentColor := True;
  FShiftFolldataGroupRow := True;
  FColumsLoaded := False;
end;

destructor TGridDataGroupsEh.Destroy;
begin
//  Active := False;
  FGroupDataTree.Clear;
  FreeAndNil(FGroupLevels);
  FreeAndNil(FGroupDataTree);
  FreeAndNil(FFooters);
  FreeAndNil(FActiveGroupLevels);
  FreeAndNil(FActiveGroupColumns);
  FreeAndNil(FFont);
  FreeAndNil(FFootersDefValues);
  FreeAndNil(FGroupRowDefValues);
  inherited Destroy;
end;

function TGridDataGroupsEh.GetActiveGroupLevels(const Index: Integer): TGridDataGroupLevelEh;
begin
  Result := TGridDataGroupLevelEh(FActiveGroupLevels[Index]);
end;

function TGridDataGroupsEh.GetActiveGroupLevelsCount: Integer;
begin
  Result := FActiveGroupLevels.Count;
end;

procedure TGridDataGroupsEh.RebuildActiveGroupLevels;
var
  k: Integer;
begin
  FActiveGroupLevels.Clear;
  FActiveGroupColumns.Clear;
  for k := 0 to GroupLevels.Count-1 do
  begin
    if GroupLevels[k].Column <> nil then
    begin
      FActiveGroupLevels.Add(GroupLevels[k]);
      FActiveGroupColumns.Add(GroupLevels[k].Column);
    end;
  end;
end;

procedure TGridDataGroupsEh.CheckActiveGroupLevels;
var
  k, j: Integer;
  Item: TGridDataGroupLevelEh;
  NeedRebuild: Boolean;
begin
  j := 0;
  NeedRebuild := False;
(*  if GroupLevels.Count < FActiveGroupLevels.Count then
  begin
    NeedRebuild := True;
  end;*)

  for k := 0 to GroupLevels.Count-1 do
  begin
    Item := GroupLevels[k];
    if Item.Column <> nil then
    begin
      if (j >= FActiveGroupLevels.Count) or
         (FActiveGroupLevels[j] <> Item) or
         (FActiveGroupColumns[j] <> Item.Column)then
      begin
        NeedRebuild := True;
        Break;
      end;
      Inc(j);
    end;
  end;

  if NeedRebuild or (FActiveGroupLevels.Count <> j) then
  begin
    GroupDataTree.DeleteRecordNodesUpToLevel(j+1);
    GroupDataTree.BeginUpdate;
    if TCustomDBGridEhCrack(FGrid).MemTableSupport then
      TCustomDBGridEhCrack(FGrid).FIntMemTable.MTDisableControls;
    try
      RebuildActiveGroupLevels;
    finally
      if TCustomDBGridEhCrack(FGrid).MemTableSupport then
        TCustomDBGridEhCrack(FGrid).FIntMemTable.MTEnableControls(True);
      GroupDataTree.EndUpdate;  
    end;
    if Active then
      ActiveGroupingStructChanged;
  end;
end;

procedure TGridDataGroupsEh.ColumnsChanged;
var
  i: Integer;
  FooterStructChanged: Boolean;
begin
  if not FColumsLoaded then Exit;
  if Active then
  begin
    FooterStructChanged := False;
    for i := 0 to Footers.Count-1 do
      if Footers[i].CheckColumnsChanged(TCustomDBGridEhCrack(FGrid).Columns) then
        FooterStructChanged := True;
    if FooterStructChanged then
     GroupDataTree.RebuildFooters;
  end;
end;

procedure TGridDataGroupsEh.ColumnsLoaded;
var
  i: Integer;
begin
  FColumsLoaded := True;
  for i := 0 to Footers.Count-1 do
    Footers[i].ColumnsLoaded(TCustomDBGridEhCrack(FGrid).Columns);
end;

function TGridDataGroupsEh.GetKeyValueForViewRecNo(ViewRecNo: Integer): Variant;
var
  RecordNoChanged: Boolean;
  i: Integer;
begin
  RecordNoChanged := False;
  if TCustomDBGridEhCrack(FGrid).FIntMemTable.GetInstantReadCurRowNum <> ViewRecNo then
  begin
    TCustomDBGridEhCrack(FGrid).FIntMemTable.InstantReadEnter(ViewRecNo);
    RecordNoChanged := True;
  end;
  try
    Result := VarArrayCreate([0, ActiveGroupLevelsCount], varVariant);
    for i := 0 to ActiveGroupLevelsCount-1 do
      Result[i] := ActiveGroupLevels[i].GetKeyValue;
    Result[ActiveGroupLevelsCount] := ViewRecNo;
  finally
    if RecordNoChanged then
      TCustomDBGridEhCrack(FGrid).FIntMemTable.InstantReadLeave;
  end;
end;

procedure TGridDataGroupsEh.SetActive(const Value: Boolean);
begin
  if FActive <> Value then
  begin
    FActive := Value;
    ActiveChanged;
  end;
end;

procedure TGridDataGroupsEh.SetGroupPanelVisible(const Value: Boolean);
begin
  if FGroupPanelVisible <> Value then
  begin
    FGroupPanelVisible := Value;
    TCustomDBGridEhCrack(FGrid).GroupPanelVisibleChanged;
  end;
end;

procedure TGridDataGroupsEh.SetInsertingKeyValue(KeyValue: Variant);
begin
  FInsertingKeyValue := KeyValue;
end;

function TGridDataGroupsEh.CreateGroupLevels: TGridDataGroupLevelsEh;
begin
  Result := TGridDataGroupLevelsEh.Create(Self, TGridDataGroupLevelEh);
end;

procedure TGridDataGroupsEh.ActiveChanged;
begin
end;

procedure TGridDataGroupsEh.ActiveGroupingStructChanged;
begin
end;

procedure TGridDataGroupsEh.Assign(Source: TPersistent);
begin
  if Source is TGridDataGroupsEh then
  begin
    Active := TGridDataGroupsEh(Source).Active;
    GroupLevels := TGridDataGroupsEh(Source).GroupLevels;
    GroupPanelVisible := TGridDataGroupsEh(Source).GroupPanelVisible;
  end else
    inherited Assign(Source);
end;

procedure TGridDataGroupsEh.SetGroupLevels(
  const Value: TGridDataGroupLevelsEh);
begin
  FGroupLevels.Assign(Value);
end;

function TGridDataGroupsEh.GetOwner: TPersistent;
begin
  Result := FGrid;
end;

function TGridDataGroupsEh.IsGroupingWorks: Boolean;
begin
  Result := Active;
end;

function TGridDataGroupsEh.GetFont: TFont;
begin
  {$WARNINGS OFF}
  if ParentFont and (FFont.Handle <> DefaultFont.Handle) then
  {$WARNINGS ON}
    RefreshDefaultFont;
  Result := FFont;
end;

procedure TGridDataGroupsEh.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
//  FParentFont := False;
//  Changed(False);
end;

function TGridDataGroupsEh.IsFontStored: Boolean;
begin
  Result := not ParentFont;
end;

procedure TGridDataGroupsEh.SetParentFont(const Value: Boolean);
begin
  if FParentFont <> Value then
  begin
    FParentFont := Value;
    RefreshDefaultFont;
    DrawFormatChanged;
  end;
end;

function TGridDataGroupsEh.DefaultFont: TFont;
begin
  if Assigned(FGrid)
    then Result := TCustomDBGridEhCrack(FGrid).Font
    else Result := FFont;
end;

function TGridDataGroupsEh.DefaultFooterColor: TColor;
begin
  Result := DefaultColor;
end;

function TGridDataGroupsEh.DefaultFooterFont: TFont;
begin
  Result := DefaultFont;
end;

procedure TGridDataGroupsEh.FontChanged(Sender: TObject);
begin
  FParentFont := False;
  GroupLevels.RefreshDefaultFont;
  Footers.RefreshDefaultFont;
  DrawFormatChanged;
end;

procedure TGridDataGroupsEh.FooterStructureChanged;
begin
  if not Active then
    Exit;
  if GroupDataTree <> nil then
    GroupDataTree.RebuildFooters;
end;

procedure TGridDataGroupsEh.FooterValuesChanged;
begin
  if not IsGroupingWorks then
    Exit;
  GroupDataTree.RecalculateFootersValues;
  GroupDataTree.UpdateAllDataRowHeights;
end;

procedure TGridDataGroupsEh.RefreshDefaultFont;
var
  Save: TNotifyEvent;
begin
  if not ParentFont then Exit;
  Save := FFont.OnChange;
  FFont.OnChange := nil;
  try
    FFont.Assign(DefaultFont);
  finally
    FFont.OnChange := Save;
  end;
  GroupLevels.RefreshDefaultFont;
end;

procedure TGridDataGroupsEh.DrawFormatChanged;
begin
  TCustomDBGridEhCrack(FGrid).Invalidate;
end;

function TGridDataGroupsEh.GetColor: TColor;
begin
  if ParentColor
    then Result := DefaultColor
    else Result := FColor;
end;

function TGridDataGroupsEh.IsColorStored: Boolean;
begin
  Result := not ParentColor;
end;

procedure TGridDataGroupsEh.SetColor(const Value: TColor);
begin
  if not ParentColor and (Value = FColor) then Exit;
  FColor := Value;
  ParentColor := False;
  DrawFormatChanged;
end;

procedure TGridDataGroupsEh.SetParentColor(const Value: Boolean);
begin
  if FParentColor <> Value then
  begin
    FParentColor := Value;
    DrawFormatChanged;
  end;
end;

function TGridDataGroupsEh.DefaultColor: TColor;
begin
  if Assigned(FGrid)
    then Result := TCustomDBGridEhCrack(FGrid).Color
    else Result := FColor;
end;

procedure TGridDataGroupsEh.ResortActiveLevel(LevelIndex: Integer;
  SortOrder: TSortOrderEh);
begin
  GroupDataTree.ResortLevel(LevelIndex, SortOrder);
end;

procedure TGridDataGroupsEh.SetFooters(const Value: TGridDataGroupFootersEh);
begin
  FFooters.Assign(Value);
end;

function TGridDataGroupsEh.IsGroupLevelsStored: Boolean;
begin
  Result := (GroupLevels.Count > 0);
end;

function TGridDataGroupsEh.IsFootersStored: Boolean;
begin
  Result := (Footers.Count > 0);
end;

procedure TGridDataGroupsEh.SetFootersDefValues(const Value: TGridDataGroupFootersDefValuesEh);
begin
  FFootersDefValues.Assign(Value);
end;

procedure TGridDataGroupsEh.SetGroupRowDefValues(
  const Value: TGridDataGroupRowDefValuesEh);
begin
  FGroupRowDefValues.Assign(Value);
end;

procedure TGridDataGroupsEh.SetShiftFolldataGroupRow(const Value: Boolean);
begin
  if FShiftFolldataGroupRow <> Value then
  begin
    FShiftFolldataGroupRow := Value;
    TCustomDBGridEhCrack(FGrid).LayoutChanged;
  end;  
end;

{ TGridDataGroupLevelEh }

constructor TGridDataGroupLevelEh.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FFont := TFont.Create;
  FFont.Assign(DefaultFont);
  FFont.OnChange := FontChanged;
  FColor := clWindow;
  FParentFont := True;
  FParentColor := True;
  FParentFooters := True;
  FFooters := TGridDataGroupFootersEh.Create(Self, TGridDataGroupFooterEh);
end;

destructor TGridDataGroupLevelEh.Destroy;
begin
  FreeAndNil(FFont);
  FreeAndNil(FFooters);
  inherited Destroy;
end;

function TGridDataGroupLevelEh.DefaultColor: TColor;
begin
  if Assigned(Collection)
    then Result := TGridDataGroupLevelsEh(Collection).FDataGroups.Color
    else Result := FColor;
end;

function TGridDataGroupLevelEh.DefaultFont: TFont;
begin
  if Assigned(Collection)
    then Result := TGridDataGroupLevelsEh(Collection).FDataGroups.Font
    else Result := FFont;
end;

function TGridDataGroupLevelEh.DefaultFooterColor: TColor;
begin
  Result := TGridDataGroupLevelsEh(Collection).FDataGroups.DefaultFooterColor
end;

function TGridDataGroupLevelEh.DefaultFooterFont: TFont;
begin
  Result := TGridDataGroupLevelsEh(Collection).FDataGroups.DefaultFooterFont
end;

procedure TGridDataGroupLevelEh.DrawFormatChanged;
begin
  if Assigned(Collection) then
    TCustomDBGridEhCrack(TGridDataGroupLevelsEh(Collection).FDataGroups.FGrid).Invalidate;
end;

procedure TGridDataGroupLevelEh.FontChanged(Sender: TObject);
begin
  FParentFont := False;
  DrawFormatChanged;
end;

function TGridDataGroupLevelEh.GetColor: TColor;
begin
  if ParentColor
    then Result := DefaultColor
    else Result := FColor;
end;

function TGridDataGroupLevelEh.GetFont: TFont;
begin
  {$WARNINGS OFF}
  if ParentFont and (FFont.Handle <> DefaultFont.Handle) then
  {$WARNINGS ON}
    RefreshDefaultFont;
  Result := FFont;
end;

function TGridDataGroupLevelEh.GetGroupRowText(
  GroupDataTreeNode: TGroupDataTreeNodeEh): String;
begin
  Result := '';
end;

function TGridDataGroupLevelEh.GetKeyValue: Variant;
begin
  if Assigned(FOnGetKeyValue) then
    OnGetKeyValue(Self)
  else if Assigned(Column) and Assigned(TColumnEh(Column).Field) and TColumnEh(Column).Field.DataSet.Active then
    Result := TColumnEh(Column).Field.Value;
end;

function TGridDataGroupLevelEh.GetKeyValueAsText(GroupDataTreeNode: TGroupDataTreeNodeEh): String;
begin
  Result := VarToStr(GroupDataTreeNode.KeyValue);
end;

function TGridDataGroupLevelEh.GetVisibleFooter(
  const Index: Integer): TGridDataGroupFooterEh;
begin
  Result := UsedFooters[Index];
end;

function TGridDataGroupLevelEh.GetVisibleFootersCount: Integer;
begin
  Result := UsedFooters.Count;
end;

function TGridDataGroupLevelEh.IsColorStored: Boolean;
begin
  Result := not ParentColor;
end;

function TGridDataGroupLevelEh.IsFontStored: Boolean;
begin
  Result := not ParentFont;
end;

procedure TGridDataGroupLevelEh.RefreshDefaultFont;
var
  Save: TNotifyEvent;
begin
  if not ParentFont then Exit;
  Save := FFont.OnChange;
  FFont.OnChange := nil;
  try
    FFont.Assign(DefaultFont);
  finally
    FFont.OnChange := Save;
  end;
end;

procedure TGridDataGroupLevelEh.SetColor(const Value: TColor);
begin
  if not ParentColor and (Value = FColor) then Exit;
  FColor := Value;
  ParentColor := False;
  DrawFormatChanged;
end;

procedure TGridDataGroupLevelEh.SetColumn(const Value: TPersistent);
begin
  if FColumn <> Value then
  begin
    FColumn := Value;
    Changed(False);
  end;
end;

procedure TGridDataGroupLevelEh.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
end;

procedure TGridDataGroupLevelEh.SetOnGetKeyValue(const Value: TNotifyEvent);
begin
  FOnGetKeyValue := Value;
end;

procedure TGridDataGroupLevelEh.SetOnGetTitleText(const Value: TNotifyEvent);
begin
  FOnGetTitleText := Value;
end;

procedure TGridDataGroupLevelEh.SetParentColor(const Value: Boolean);
begin
  if FParentColor <> Value then
  begin
    FParentColor := Value;
    DrawFormatChanged;
  end;
end;

procedure TGridDataGroupLevelEh.SetParentFont(const Value: Boolean);
begin
  if FParentFont <> Value then
  begin
    FParentFont := Value;
    RefreshDefaultFont;
    DrawFormatChanged;
  end;
end;

procedure TGridDataGroupLevelEh.SetParentFooters(const Value: Boolean);
begin
  FParentFooters := Value;
end;

procedure TGridDataGroupLevelEh.SetSortOrder(const Value: TSortOrderEh);
begin
  if FSortOrder <> Value then
  begin
    FSortOrder := Value;
    GridDataGroupLevels.OrderChanged(Self);
//    Changed(False);
  end;
end;

procedure TGridDataGroupLevelEh.CollapseNodes;
var
  GrIndex: Integer;
begin
  GrIndex := TGridDataGroupLevelsEh(Collection).FDataGroups.FActiveGroupLevels.IndexOf(Self);
  if GrIndex >= 0 then
    TGridDataGroupLevelsEh(Collection).FDataGroups.GroupDataTree.CollapseLevel(GrIndex+1);
end;

procedure TGridDataGroupLevelEh.ExtractNodes;
var
  GrIndex: Integer;
begin
  GrIndex := TGridDataGroupLevelsEh(Collection).FDataGroups.FActiveGroupLevels.IndexOf(Self);
  if GrIndex >= 0 then
    TGridDataGroupLevelsEh(Collection).FDataGroups.GroupDataTree.ExpandLevel(GrIndex+1);
end;

procedure TGridDataGroupLevelEh.ExpandNodes;
begin
  ExtractNodes;
end;

function TGridDataGroupLevelEh.GridDataGroupLevels: TGridDataGroupLevelsEh;
begin
  Result := TGridDataGroupLevelsEh(Collection);
end;

procedure TGridDataGroupLevelEh.SetFooters(const Value: TGridDataGroupFootersEh);
begin
  FFooters.Assign(Value);
end;

function TGridDataGroupLevelEh.UsedFooters: TGridDataGroupFootersEh;
begin
  if ParentFooters
    then Result := TGridDataGroupLevelsEh(Collection).FDataGroups.Footers
    else Result := Footers;
end;

function TGridDataGroupLevelEh.GetDisplayName: string;
begin
  if (Collection <> nil) and (TGridDataGroupLevelsEh(Collection).GetGrid <> nil) then
    Result := TGridDataGroupLevelsEh(Collection).GetGrid.Name + '.DataGrouping';
  if (Column <> nil) and (TColumnEh(Column).FieldName <> '') then
    Result := Result + '[''' + TColumnEh(Column).FieldName + ''']';
end;

function TGridDataGroupLevelEh.GetFooterInGroupRow: Boolean;
begin
  if FooterInGroupRowStored
    then Result := FFooterInGroupRow
    else Result := DefaultFooterInGroupRow;
end;

procedure TGridDataGroupLevelEh.SetFooterInGroupRow(const Value: Boolean);
begin
  if FooterInGroupRowStored and (Value = FFooterInGroupRow) then Exit;
  FooterInGroupRowStored := True;
  FFooterInGroupRow := Value;
  GridDataGroupLevels.FDataGroups.FooterStructureChanged
end;

function TGridDataGroupLevelEh.IsFooterInGroupRowStored: Boolean;
begin
  Result := FFooterInGroupRowStored;
end;

procedure TGridDataGroupLevelEh.SetFooterInGroupRowStored(const Value: Boolean);
begin
  if FooterInGroupRowStored <> Value then
  begin
    FFooterInGroupRowStored := Value;
    FFooterInGroupRow := DefaultFooterInGroupRow;
  end;
end;

function TGridDataGroupLevelEh.DefaultFooterInGroupRow: Boolean;
begin
  Result := False;
  if GridDataGroupLevels <> nil then
    Result := GridDataGroupLevels.FDataGroups.GroupRowDefValues.FooterInGroupRow;
end;

function TGridDataGroupLevelEh.GetRowHeight: Integer;
begin
  if RowHeightStored
    then Result := FRowHeight
    else Result := DefaultRowHeight;
end;

procedure TGridDataGroupLevelEh.SetRowHeight(const Value: Integer);
begin
  if RowHeightStored and (Value = FRowHeight) then Exit;
  RowHeightStored := True;
  FRowHeight := Value;
  GridDataGroupLevels.FDataGroups.FooterStructureChanged
end;

function TGridDataGroupLevelEh.IsRowHeightStored: Boolean;
begin
  Result := FRowHeightStored;
end;

procedure TGridDataGroupLevelEh.SetRowHeightStored(const Value: Boolean);
begin
  if RowHeightStored <> Value then
  begin
    FRowHeightStored := Value;
    FRowHeight := DefaultRowHeight;
  end;
end;

function TGridDataGroupLevelEh.DefaultRowHeight: Integer;
begin
  Result := 0;
  if GridDataGroupLevels <> nil then
    Result := GridDataGroupLevels.FDataGroups.GroupRowDefValues.RowHeight;
end;

function TGridDataGroupLevelEh.GetRowLines: Integer;
begin
  if RowLinesStored
    then Result := FRowLines
    else Result := DefaultRowLines;
end;

procedure TGridDataGroupLevelEh.SetRowLines(const Value: Integer);
begin
  if RowLinesStored and (Value = FRowLines) then Exit;
  RowLinesStored := True;
  FRowLines := Value;
  GridDataGroupLevels.FDataGroups.FooterStructureChanged
end;

function TGridDataGroupLevelEh.IsRowLinesStored: Boolean;
begin
  Result := FRowLinesStored;
end;

procedure TGridDataGroupLevelEh.SetRowLinesStored(const Value: Boolean);
begin
  if RowLinesStored <> Value then
  begin
    FRowLinesStored := Value;
    FRowLines := DefaultRowLines;
  end;
end;

function TGridDataGroupLevelEh.DefaultRowLines: Integer;
begin
  Result := 0;
  if GridDataGroupLevels <> nil then
    Result := GridDataGroupLevels.FDataGroups.GroupRowDefValues.RowLines;
end;

{ TGridGroupDataTreeEh }

function TGridGroupDataTreeEh.AddChildDataNode(const Text: string;
  Parent: TGroupDataTreeNodeEh; Data: TObject): TGroupDataTreeNodeEh;
begin
  if (Parent.FooterItemCount = 0) or (Parent.FullItemCount = 0) then
    Result := TGroupDataTreeNodeEh(AddChild('', Parent, nil))
  else
  begin
    Result := TGroupDataTreeNodeEh(CreateNodeApart('', nil));
    AddNode(Result, Parent.Items[Parent.Count], naInsertEh, True);
  end;
end;

procedure TGridGroupDataTreeEh.AddDataNode(Node, Destination: TGroupDataTreeNodeEh;
  Mode: TNodeAttachModeEh; ReIndex: Boolean);
begin
  if (Mode = naAddChildEh) and (Destination.FooterItemCount > 0) then
    AddNode(Node, Destination.FooterItems[0], naInsertEh, ReIndex)
  else if (Mode = naAddEh) and (TGroupDataTreeNodeEh(Destination.Parent).FooterItemCount > 0) then
    AddNode(Node, TGroupDataTreeNodeEh(Destination.Parent).FooterItems[0], naInsertEh, ReIndex)
  else
    AddNode(Node, Destination, Mode, ReIndex);
end;

function TGridGroupDataTreeEh.AddRecordNodeForKey(AKey: Variant; RecViewNo: Integer): TGroupDataTreeNodeEh;
var
  k: Integer;
  Key1: Variant;
  ParentNode, Node: TGroupDataTreeNodeEh;
  InsertMode: TNodeAttachModeEh;
  TargetNode: TGroupDataTreeNodeEh;
  SortOrder: TSortOrderEh;
begin
  ParentNode := TGroupDataTreeNodeEh(Root);
  TargetNode := ParentNode;
  InsertMode := naAddChildEh;
  for k := 0 to GridDataGroups.ActiveGroupLevelsCount-1 do
  begin
    Key1 := AKey[k];
    SortOrder := GridDataGroups.ActiveGroupLevels[k].SortOrder;
    if (InsertMode = naAddChildEh) and (TargetNode <> nil) then
      TargetNode := GetNodeToInsertForKey1(ParentNode, Key1, SortOrder, InsertMode);
//      naAddEh, naAddChildEh, naInsertEh
    if (InsertMode = naAddChildEh) and (TargetNode <> nil) then
    begin
      ParentNode := TargetNode;
      if ParentNode.FDataSetRecordViewNo = -1 then
        ParentNode.FDataSetRecordViewNo := RecViewNo;
      Continue;
    end else
    begin
      if TargetNode = nil then
        ParentNode := TGroupDataTreeNodeEh(AddChildDataNode('', ParentNode, nil))
      else
      begin
        Node := TGroupDataTreeNodeEh(CreateNodeApart('', nil));
        AddDataNode(Node, TargetNode, InsertMode, True);
        ParentNode := Node;
        TargetNode := nil;
      end;
    end;
    ParentNode.FDataGroupLevel := GridDataGroups.ActiveGroupLevels[k];
    ParentNode.FGroupDataTreeNodeType := dntDataGroupEh;
    ParentNode.FDataSetRecordViewNo := RecViewNo;
    ParentNode.FKeyValue := Key1;
    ParentNode.FDisplayValue := ParentNode.FDataGroupLevel.GetKeyValueAsText(ParentNode);
    ParentNode.Expanded := GridDataGroups.DefaultStateExpanded;
    ParentNode.RowDataChanged;

    ParentNode.ResetFooters;
  end;

  Key1 := AKey[GridDataGroups.ActiveGroupLevelsCount];
  TargetNode := GetNodeToInsertForKey1(ParentNode, Key1, soAscEh, InsertMode);
  if TargetNode = nil then
    Result := TGroupDataTreeNodeEh(AddChildDataNode('', ParentNode, nil))
  else
  begin
    Result := TGroupDataTreeNodeEh(CreateNodeApart('', nil));
    if InsertMode = naAddChildEh then
    begin
//      TargetNode := ParentNode;
      InsertMode := naInsertEh;
    end;
    AddDataNode(Result, TargetNode, InsertMode, True);
  end;
//  Result := TGroupDataTreeNodeEh(AddChild('', ParentNode, nil))
end;

procedure TGridGroupDataTreeEh.AggregateValuesForDataNode(Node: TGroupDataTreeNodeEh);
var
  ParentNode: TGroupDataTreeNodeEh;
  i, j: Integer;
begin
  ParentNode := Node.Parent;
  for i := 0 to ParentNode.FooterItemCount-1 do
  begin
    for j := 0 to ParentNode.FooterItems[i].DataGroupFooter.ColumnItems.Count-1 do
      ParentNode.FooterItems[i].DataGroupFooter.ColumnItems[j].AggregateValue(
        ParentNode.FooterItems[i].FFooterValue[j], Node);
  end;
  if ParentNode.Parent <> nil then
    AggregateValuesForDataNode(ParentNode);
end;

constructor TGridGroupDataTreeEh.Create(AGridDataGroups: TGridDataGroupsEh; ItemClass: TTreeNodeClassEh);
begin
  FGridDataGroups := AGridDataGroups;
  FlatVisibleList := TList.Create;
  inherited Create(ItemClass);
end;

destructor TGridGroupDataTreeEh.Destroy;
begin
  FreeAndNil(FlatVisibleList);
  inherited Destroy;
end;

procedure TGridGroupDataTreeEh.ExpandedChanged(Node: TBaseTreeNodeEh);
begin
  inherited ExpandedChanged(Node);
  if UpdateCount = 0 then
    RebuildFlatVisibleList;
end;

function TGridGroupDataTreeEh.GetFlatVisibleItem(const Index: Integer): TGroupDataTreeNodeEh;
begin
  Result := TGroupDataTreeNodeEh(FlatVisibleList[Index]);
end;

function TGridGroupDataTreeEh.GetNodeByRecordViewNo(RecordViewNo: Integer): TGroupDataTreeNodeEh;
var
  Node: TGroupDataTreeNodeEh;
begin
  Result := nil;
  Node := TGroupDataTreeNodeEh(GetFirst);
  while Node <> nil do
  begin
    if (Node.NodeType = dntDataSetRecordEh) and
       (Node.DataSetRecordViewNo = RecordViewNo) then
    begin
      Result := Node;
      Exit;
    end;  
    Node := TGroupDataTreeNodeEh(GetNext(Node));
  end;
end;

function TGridGroupDataTreeEh.GetNodeToInsertForKey1(
  ParentNode: TGroupDataTreeNodeEh; Key1: Variant; SortOrder: TSortOrderEh;
  var InsertMode: TNodeAttachModeEh): TGroupDataTreeNodeEh;
//BinSearch
var
  CurIndex, NewIndex, AMin, AMax : Integer;
  Relationship: TVariantRelationship;
begin
  if ParentNode.Count = 0 then
  begin
    Result := nil;
    InsertMode := naAddChildEh;
    Exit;
  end;
  Relationship := DBVarCompareValue(ParentNode[0].KeyValue, Key1);
  if (Relationship = vrGreaterThan) and (SortOrder = soAscEh)
   or
     (Relationship = vrLessThan) and (SortOrder = soDescEh) then
  begin
    Result := ParentNode[0];
    InsertMode := naInsertEh;
    Exit;
  end;
  Relationship := DBVarCompareValue(ParentNode[ParentNode.Count-1].KeyValue, Key1);
  if (Relationship = vrLessThan) and (SortOrder = soAscEh)
   or
     (Relationship = vrGreaterThan) and (SortOrder = soDescEh) then
  begin
    Result := ParentNode[ParentNode.Count-1];
    InsertMode := naAddEh;
    Exit;
  end;
  AMin := 0; AMax := ParentNode.Count - 1;
  CurIndex := (AMax - AMin) div 2;
  NewIndex := CurIndex;
  while True do
  begin
    Relationship := DBVarCompareValue(ParentNode[CurIndex].KeyValue, Key1);
    if (Relationship = vrGreaterThan) and (SortOrder = soAscEh)
     or
       (Relationship = vrLessThan) and (SortOrder = soDescEh) then
    begin
      AMax := CurIndex;
      CurIndex := (AMax + AMin) div 2;
    end else if (Relationship = vrLessThan) and (SortOrder = soAscEh)
             or
                (Relationship = vrGreaterThan) and (SortOrder = soDescEh) then
    begin
      AMin := CurIndex;
      CurIndex := (AMax + AMin) div 2;
    end else
    begin
      Result := ParentNode[CurIndex];
      InsertMode := naAddChildEh;
      Exit;
    end;
    if NewIndex = CurIndex then
    begin
      Inc(NewIndex);
      if DBVarCompareValue(ParentNode[NewIndex].KeyValue, Key1) = vrEqual
        then InsertMode := naAddChildEh
        else InsertMode := naInsertEh;
      Result := ParentNode[NewIndex];
      Exit;
    end;
    NewIndex := CurIndex;
  end;
end;

function TGridGroupDataTreeEh.GetRoot: TGroupDataTreeNodeEh;
begin
  Result := TGroupDataTreeNodeEh(inherited Root);
end;

function TGridGroupDataTreeEh.GetVisibleCount: Integer;
begin
  Result := FlatVisibleList.Count;
end;

function TGridGroupDataTreeEh.IndexOfVisibleNode(Node: TGroupDataTreeNodeEh): Integer;
begin
  Result := FlatVisibleList.IndexOf(Node);
end;

procedure TGridGroupDataTreeEh.DeleteEmptyNodes;
var
  Node, DelNode: TGroupDataTreeNodeEh;
begin
//TODO: Optimize
//Not finished if tree deeper than 1.
  Node := TGroupDataTreeNodeEh(GetFirstVisible);
  while Node <> nil do
  begin
    if (Node.NodeType = dntDataGroupEh) and (Node.Count = 0) then
    begin
      DelNode := Node;
      Node := TGroupDataTreeNodeEh(GetPrevious(Node));
      DeleteNode(DelNode, True);
      if Node = nil then
        Node := TGroupDataTreeNodeEh(GetFirstVisible);
    end else
      Node := TGroupDataTreeNodeEh(GetNextVisible(Node, False));
  end;
end;

procedure TGridGroupDataTreeEh.DeleteRecordNodes;
var
  Node, DelNode: TGroupDataTreeNodeEh;
  NodeLevel: Integer;
  GroupLevel: TGridDataGroupLevelEh;
begin
//TODO: Optimize

  Node := TGroupDataTreeNodeEh(GetLast);
  while Node <> nil do
  begin
    if Node.NodeType = dntDataSetRecordEh
      then DelNode := Node
      else DelNode := nil;
    Node := TGroupDataTreeNodeEh(GetPrevious(Node));
    if DelNode <> nil then
      DeleteNode(DelNode, True);
  end;

{  Node := TGroupDataTreeNodeEh(GetFirstVisible);
  while Node <> nil do
  begin
    if Node.NodeType = dntDataSetRecordEh
      then DelNode := Node
      else DelNode := nil;
    Node := TGroupDataTreeNodeEh(GetNextVisible(Node, False));
    if DelNode <> nil then
      DeleteNode(DelNode, True);
  end;}

//Delete expared nodes
  Node := TGroupDataTreeNodeEh(GetFirstVisible);
  while Node <> nil do
  begin
    Node.FDataSetRecordViewNo := -1;
    DelNode := nil;
    if (Node.Count = 0) and (Node.NodeType = dntDataGroupEh) then
    begin
      NodeLevel := Node.Level;
      if FGridDataGroups.ActiveGroupLevelsCount >= NodeLevel
        then GroupLevel := FGridDataGroups.ActiveGroupLevels[NodeLevel-1]
        else GroupLevel := nil;
      if GroupLevel <> Node.DataGroupLevel then
        DelNode := Node;
    end;
    Node := TGroupDataTreeNodeEh(GetNextVisible(Node, False));
    if DelNode <> nil then
      DeleteNode(DelNode, True);
  end;

end;

procedure TGridGroupDataTreeEh.RebuildDataTreeEx(AIntMemTable: IMemTableEh);
var
  i, j: Integer;
  RecNode: TGroupDataTreeNodeEh;
  KeyValue: Variant;
begin
//  if UpdateCount > 0 then
//    Exit;
  BeginUpdate;
  try
    DeleteRecordNodes;
    KeyValue := VarArrayCreate([0, GridDataGroups.ActiveGroupLevelsCount], varVariant);

    for i := 0 to AIntMemTable.InstantReadRowCount-1 do
    begin
      AIntMemTable.InstantReadEnter(i);
      try
        for j := 0 to GridDataGroups.ActiveGroupLevelsCount-1 do
          KeyValue[j] := GridDataGroups.ActiveGroupLevels[j].GetKeyValue;
        KeyValue[GridDataGroups.ActiveGroupLevelsCount] := i;

        RecNode := AddRecordNodeForKey(KeyValue, i);
        RecNode.FDataGroupLevel := nil;
        RecNode.FGroupDataTreeNodeType := dntDataSetRecordEh;
        RecNode.FDataSetRecordViewNo := i;
        RecNode.FFullKey := GridDataGroups.GetKeyValueForViewRecNo(i);
        RecNode.FKeyValue := i;
        RecNode.RowDataChanged;
      finally
        AIntMemTable.InstantReadLeave;
      end;
    end;
    DeleteEmptyNodes;
  finally
    EndUpdate;
  end;
  RecalculateFootersValues;
  RebuildFlatVisibleList;
  UpdateAllDataRowHeights;
end;

procedure TGridGroupDataTreeEh.RebuildDataTree(AIntMemTable: IMemTableEh);
var
  i, j: Integer;
//  Nodes: array of TGroupDataTreeNodeEh;
  RecNode: TGroupDataTreeNodeEh;
//  ValueChanged: Boolean;
  KeyValue: Variant;
begin
  Clear;
//  if AIntMemTable.InstantReadRowCount = 0 then Exit;
  KeyValue := VarArrayCreate([0, GridDataGroups.ActiveGroupLevelsCount], varVariant);

  BeginUpdate;
  try
  for i := 0 to AIntMemTable.InstantReadRowCount-1 do
  begin
    AIntMemTable.InstantReadEnter(i);
    try
      for j := 0 to GridDataGroups.ActiveGroupLevelsCount-1 do
        KeyValue[j] := GridDataGroups.ActiveGroupLevels[j].GetKeyValue;
      KeyValue[GridDataGroups.ActiveGroupLevelsCount] := i;

      RecNode := AddRecordNodeForKey(KeyValue, i);
      RecNode.FDataGroupLevel := nil;
      RecNode.FGroupDataTreeNodeType := dntDataSetRecordEh;
      RecNode.FDataSetRecordViewNo := i;
      RecNode.FFullKey := GridDataGroups.GetKeyValueForViewRecNo(i);
      RecNode.FKeyValue := i;
      RecNode.RowDataChanged;
    finally
      AIntMemTable.InstantReadLeave;
    end;
  end;
  finally
    EndUpdate;
  end;
{
  AIntMemTable.InstantReadEnter(0);
  try
  SetLength(Nodes, GridDataGroups.GroupLevels.Count);
  Node := TGroupDataTreeNodeEh(Root);
  for i := 0 to GridDataGroups.GroupLevels.Count-1 do
  begin
    Node := TGroupDataTreeNodeEh(AddChild('', Node, nil));
    Node.FDataGroup := GridDataGroups.GroupLevels[i];
    Node.FGroupDataTreeNodeType := dntDataGroupEh;
    Node.FKeyValue := GridDataGroups.GroupLevels[i].GetKeyValue;
    Nodes[i] := Node;
  end;
  finally
    AIntMemTable.InstantReadLeave;
  end;

  for i := 0 to AIntMemTable.InstantReadRowCount-1 do
  begin
    AIntMemTable.InstantReadEnter(i);
    try
    ValueChanged := False;
    for j := 0 to GridDataGroups.GroupLevels.Count-1 do
    begin
      if not ValueChanged and
         not VarEquals(Nodes[j].KeyValue, GridDataGroups.GroupLevels[j].GetKeyValue) then
      begin
        Node := TGroupDataTreeNodeEh(Nodes[j].Parent);
        ValueChanged := True;
      end;
      if ValueChanged then
      begin
        Node := TGroupDataTreeNodeEh(AddChild('', Node, nil));
        Node.FDataGroup := GridDataGroups.GroupLevels[j];
        Node.FGroupDataTreeNodeType := dntDataGroupEh;
        Node.FKeyValue := GridDataGroups.GroupLevels[j].GetKeyValue;
        Nodes[j] := Node;
      end;
    end;
    finally
      AIntMemTable.InstantReadLeave;
    end;
    //Data record
    Node := TGroupDataTreeNodeEh(AddChild('', Nodes[Length(Nodes)-1], nil));
    Node.FDataGroup := nil;
    Node.FGroupDataTreeNodeType := dntDataSetRecordEh;
    Node.FDataSetRecordViewNo := i;
    Node.FKeyValue := Null;
  end;
}
  RebuildFlatVisibleList;
  UpdateAllDataRowHeights;
end;

procedure TGridGroupDataTreeEh.RebuildFlatVisibleList;
var
  Node: TGroupDataTreeNodeEh;
begin
  FlatVisibleList.Clear;
  Node := TGroupDataTreeNodeEh(GetFirstVisible);
  while Node <> nil do
  begin
    if not ((Node.NodeType = dntDataGroupFooterEh) and (Node.Parent = Root)) then
      if (Node.NodeType = dntDataGroupFooterEh) and
         Node.Parent.DataGroupLevel.FooterInGroupRow
         and (Node = Node.Parent.FooterItems[0]) then
        //Skip First Footer in Group Row
      else if (Node.NodeType = dntDataGroupFooterEh) and not Node.DataGroupFooter.Visible then
        //Skip First Footer in Group Row
      else
        FlatVisibleList.Add(Node);
    Node := TGroupDataTreeNodeEh(GetNextVisible(Node, True));
  end;
  TCustomDBGridEhCrack(FGridDataGroups.FGrid).DataGroupsVisibleChanged;
end;

procedure TGridGroupDataTreeEh.RebuildFooters;
var
  Node: TGroupDataTreeNodeEh;
begin
  Node := TGroupDataTreeNodeEh(GetFirst);
  while Node <> nil do
  begin
    if Node.NodeType = dntDataGroupEh then
      Node.ResetFooters;
    Node := TGroupDataTreeNodeEh(GetNext(Node));
  end;
  Root.ResetFooters;
  RecalculateFootersValues;
  UpdateAllDataRowHeights;
  RebuildFlatVisibleList;
end;

procedure TGridGroupDataTreeEh.RecalculateFootersValues;
var
  Node: TGroupDataTreeNodeEh;
  i, j, ColCount: Integer;
  HaveFooter: Boolean;
begin
  HaveFooter := False;
  if GridDataGroups.Footers.Count > 0 then
    HaveFooter := True
  else
    for i := 0 to GridDataGroups.GroupLevels.Count-1 do
      if GridDataGroups.GroupLevels[i].Footers.Count > 0 then
      begin
        HaveFooter := True;
        Break;
      end;
  if HaveFooter = False then Exit;

// Init Empty Values
  Node := TGroupDataTreeNodeEh(GetFirst);
  while Node <> nil do
  begin
    if Node.NodeType = dntDataGroupFooterEh then
    begin
      ColCount := Node.DataGroupFooter.GetColumnItems.Count;
//      Node.FFooterValue := VarArrayCreate([0,ColCount-1], varVariant);
      SetLength(Node.FFooterValue, ColCount);
      for i := 0 to Node.DataGroupFooter.GetColumnItems.Count-1 do
        VarClear(Node.FFooterValue[i]);
    end;
    Node := TGroupDataTreeNodeEh(GetNext(Node));
  end;

  for i := 0 to GridDataGroups.Footers.Count - 1 do
  begin
    SetLength(Root.FooterItems[i].FFooterValue,
      GridDataGroups.Footers[i].GetColumnItems.Count);
    for j := 0 to GridDataGroups.Footers[i].GetColumnItems.Count-1 do
      VarClear(Root.FooterItems[i].FFooterValue[j]);
  end;

// Aggregate Values
  Node := TGroupDataTreeNodeEh(GetFirst);
  while Node <> nil do
  begin
    if Node.NodeType = dntDataSetRecordEh then
    begin
      TCustomDBGridEhCrack(FGridDataGroups.FGrid).
        FIntMemTable.InstantReadEnter(Node.DataSetRecordViewNo);
      try
        AggregateValuesForDataNode(Node);
//        AggregateValue(AValue, Node);
//        FinalizeValue(AValue);
      finally
        TCustomDBGridEhCrack(FGridDataGroups.FGrid).FIntMemTable.InstantReadLeave;
      end;
    end;
    Node := TGroupDataTreeNodeEh(GetNext(Node));
  end;

// Finalize Aggregate Values
  Node := TGroupDataTreeNodeEh(GetFirst);
  while Node <> nil do
  begin
    if Node.NodeType = dntDataGroupFooterEh then
    begin
      for i := 0 to Node.DataGroupFooter.GetColumnItems.Count-1 do
        Node.DataGroupFooter.GetColumnItems[i].FinalizeValue(Node.FFooterValue[i]);
    end;
    Node := TGroupDataTreeNodeEh(GetNext(Node));
  end;

  UpdateAllDataRowHeights;
  RebuildFlatVisibleList;
end;

procedure TGridGroupDataTreeEh.RecordChanged(RecNum: Integer);
var
  Node: TGroupDataTreeNodeEh;
  GridRowNum: Integer;
  KeyValue: Variant;
begin
  Node := GridDataGroups.GroupDataTree.GetNodeByRecordViewNo(RecNum);
  KeyValue := GridDataGroups.GetKeyValueForViewRecNo(RecNum);
  if DBVarCompareValue(KeyValue, Node.FullKey) <> vrEqual then
  begin
    Node.FFullKey := KeyValue;
    UpdateRecordNodePosInTree(Node);
    RebuildFlatVisibleList;
    TCustomDBGridEhCrack(FGridDataGroups.FGrid).DataGroupsVisibleChanged;
  end else
  begin
    Node := GridDataGroups.GroupDataTree.GetNodeByRecordViewNo(RecNum);
    GridRowNum := GridDataGroups.GroupDataTree.IndexOfVisibleNode(Node);
    if GridRowNum >= 0 then
      TCustomDBGridEhCrack(FGridDataGroups.FGrid).UpdateDataRowHeight(GridRowNum);
  end;
  RecalculateFootersValues;
end;

procedure TGridGroupDataTreeEh.RecordDeleted(RecNum: Integer);
var
  Node, Parent: TGroupDataTreeNodeEh;
  k: Integer;
begin
  Node := TGroupDataTreeNodeEh(GetFirst);
  while Node <> nil do
  begin
    if (Node.NodeType = dntDataSetRecordEh) and
       (Node.DataSetRecordViewNo = RecNum)
    then
    begin
      Parent := TGroupDataTreeNodeEh(Node.Parent);
      DeleteNode(Node, True);
      for k := GridDataGroups.ActiveGroupLevelsCount-1 downto 0  do
      begin
        if Parent.Count = 0 then
        begin
          Node := Parent;
          Parent := TGroupDataTreeNodeEh(Node.Parent);
          DeleteNode(Node, True);
        end else
          Break;
      end;
      Break;
    end;
    Node := TGroupDataTreeNodeEh(GetNext(Node));
  end;
  Node := TGroupDataTreeNodeEh(GetFirst);
  while Node <> nil do
  begin
    if Node.DataSetRecordViewNo > RecNum
    then
    begin
      Node.FDataSetRecordViewNo := Node.FDataSetRecordViewNo - 1;
      if Node.NodeType = dntDataSetRecordEh then
      begin
        Node.FKeyValue := Node.FDataSetRecordViewNo;
        Node.FFullKey[GridDataGroups.ActiveGroupLevelsCount] := Node.FKeyValue;
      end;
    end;
    Node := TGroupDataTreeNodeEh(GetNext(Node));
  end;
  RecalculateFootersValues;
  RebuildFlatVisibleList;
  TCustomDBGridEhCrack(FGridDataGroups.FGrid).DataGroupsVisibleChanged;
end;

procedure TGridGroupDataTreeEh.SetDataSetkeyValue;
var
//  AGrid: TCustomDBGridEhCrack;
  k: Integer;
begin
//  AGrid := TCustomDBGridEhCrack(FGridDataGroups.FGrid);
  if VarIsEmpty(GridDataGroups.FInsertingKeyValue) then Exit;
  for k := 0 to GridDataGroups.ActiveGroupLevelsCount-1 do
  begin
//    AGrid.DataSource.DataSet.Edit;
    if (GridDataGroups.ActiveGroupLevels[k].Column <> nil) and
        (TColumnEh(GridDataGroups.ActiveGroupLevels[k].Column).Field <> nil) then
    begin
      TColumnEh(GridDataGroups.ActiveGroupLevels[k].Column).Field.Value := GridDataGroups.FInsertingKeyValue[k];
    end;
  end;
end;

procedure TGridGroupDataTreeEh.SetRoot(const Value: TGroupDataTreeNodeEh);
begin
  inherited Root := Value;
end;

procedure TGridGroupDataTreeEh.RecordInserted(RecNum: Integer);
var
  KeyValue: Variant;
  AGrid: TCustomDBGridEhCrack;
  RecNode, Node: TGroupDataTreeNodeEh;
begin
  AGrid := TCustomDBGridEhCrack(FGridDataGroups.FGrid);

  Node := TGroupDataTreeNodeEh(GetFirst);
  while Node <> nil do
  begin
    if Node.DataSetRecordViewNo >= RecNum
    then
    begin
      Node.FDataSetRecordViewNo := Node.FDataSetRecordViewNo + 1;
      if Node.NodeType = dntDataSetRecordEh then
      begin
        Node.FKeyValue := Node.FDataSetRecordViewNo;
        Node.FFullKey[GridDataGroups.ActiveGroupLevelsCount] := Node.FKeyValue;
      end;
    end;
    Node := TGroupDataTreeNodeEh(GetNext(Node));
  end;

  AGrid.FIntMemTable.InstantReadEnter(RecNum);
  try
    KeyValue := GridDataGroups.GetKeyValueForViewRecNo(RecNum);
    if (AGrid.DataSource.DataSet.State = dsInsert) and
       (AGrid.FIntMemTable.InstantReadCurRowNum = RecNum)    then
    begin
      SetDataSetkeyValue;
      if not VarIsEmpty(GridDataGroups.FInsertingKeyValue) then
        KeyValue := FGridDataGroups.FInsertingKeyValue;
      VarClear(FGridDataGroups.FInsertingKeyValue);
    end;
    RecNode := AddRecordNodeForKey(KeyValue, RecNum);
    RecNode.FDataGroupLevel := nil;
    RecNode.FGroupDataTreeNodeType := dntDataSetRecordEh;
    RecNode.FDataSetRecordViewNo := RecNum;
    RecNode.FFullKey := KeyValue;
    RecNode.FKeyValue := RecNum;
    RecNode.RowDataChanged;
  finally
    AGrid.FIntMemTable.InstantReadLeave;
  end;

  if (AGrid.DataSource.DataSet.State = dsInsert) and
     (AGrid.FIntMemTable.InstantReadCurRowNum = RecNum)
  then
    ExpandNodePathToView(RecNode);

  RecalculateFootersValues;
  RebuildFlatVisibleList;
  TCustomDBGridEhCrack(FGridDataGroups.FGrid).DataGroupsVisibleChanged;
end;

procedure TGridGroupDataTreeEh.UpdateAllDataRowHeights;
var
  Node: TGroupDataTreeNodeEh;
begin
  Node := TGroupDataTreeNodeEh(GetFirst);
  while Node <> nil do
  begin
    Node.UpdateRowHeight;
    Node := TGroupDataTreeNodeEh(GetNext(Node));
  end;
end;

procedure TGridGroupDataTreeEh.DeleteRecordNode(RecNode: TGroupDataTreeNodeEh);
var
  Node, Parent: TGroupDataTreeNodeEh;
  k: Integer;
begin
  Parent := TGroupDataTreeNodeEh(RecNode.Parent);
  DeleteNode(RecNode, True);
//  ExtractNode(RecNode, True);
  for k := GridDataGroups.ActiveGroupLevelsCount-1 downto 0  do
  begin
    if Parent.Count = 0 then
    begin
      Node := Parent;
      Parent := TGroupDataTreeNodeEh(Node.Parent);
      DeleteNode(Node, True);
    end else
      Break;
  end;
end;

procedure TGridGroupDataTreeEh.UpdateRecordNodePosInTree(RecNode: TGroupDataTreeNodeEh);
var
  KeyValue: Variant;
  RecordViewNo: Integer;
begin
  KeyValue := RecNode.FullKey;
  RecordViewNo := RecNode.DataSetRecordViewNo;
  DeleteRecordNode(RecNode);
  TCustomDBGridEhCrack(FGridDataGroups.FGrid).FIntMemTable.InstantReadEnter(RecNode.DataSetRecordViewNo);
  try
    RecNode := AddRecordNodeForKey(KeyValue, RecordViewNo);
    RecNode.FDataGroupLevel := nil;
    RecNode.FGroupDataTreeNodeType := dntDataSetRecordEh;
    RecNode.FDataSetRecordViewNo := RecordViewNo;
    RecNode.FFullKey := KeyValue;
    RecNode.RowDataChanged;
  finally
    TCustomDBGridEhCrack(FGridDataGroups.FGrid).FIntMemTable.InstantReadLeave;
  end;
end;

procedure TGridGroupDataTreeEh.ExpandNodePathToView(Node: TGroupDataTreeNodeEh);
var
  ParentNode: TGroupDataTreeNodeEh;
begin
  ParentNode := TGroupDataTreeNodeEh(Node.Parent);
  while ParentNode <> Root do
  begin
    ParentNode.Expanded := True;
    ParentNode := TGroupDataTreeNodeEh(ParentNode.Parent);
  end;
end;

procedure TGridGroupDataTreeEh.BeginUpdate;
begin
  Inc(FUpateCount);
end;

procedure TGridGroupDataTreeEh.EndUpdate;
begin
  Dec(FUpateCount);
end;

procedure TGridGroupDataTreeEh.CollapseLevel(LevelIndex: Integer);
var
  Node: TGroupDataTreeNodeEh;
begin
  BeginUpdate;
  try
  Node := TGroupDataTreeNodeEh(GetFirstVisible);
  while Node <> nil do
  begin
    if Node.Level = LevelIndex then
      Node.Expanded := False;
    Node := TGroupDataTreeNodeEh(GetNextVisible(Node, False));
  end;
  finally
    EndUpdate;
  end;
  RebuildFlatVisibleList;
end;

procedure TGridGroupDataTreeEh.ExpandLevel(LevelIndex: Integer);
var
  Node: TGroupDataTreeNodeEh;
begin
  BeginUpdate;
  try
  Node := TGroupDataTreeNodeEh(GetFirstVisible);
  while Node <> nil do
  begin
    if Node.Level = LevelIndex then
      Node.Expanded := True;
    Node := TGroupDataTreeNodeEh(GetNextVisible(Node, False));
  end;
  finally
    EndUpdate;
  end;
  RebuildFlatVisibleList;
end;

procedure TGridGroupDataTreeEh.ResortLevel(LevelIndex: Integer;
  SortOrder: TSortOrderEh);
var
  Node: TGroupDataTreeNodeEh;
begin
  Node := TGroupDataTreeNodeEh(Root);
  if LevelIndex = 0 then
    Node.SortData(CompareNodes, TObject(SortOrder), False)
  else
  begin
    BeginUpdate;
    try
    Node := TGroupDataTreeNodeEh(GetFirstVisible);
    while Node <> nil do
    begin
      if Node.Level = LevelIndex then
        Node.SortData(CompareNodes, TObject(SortOrder), False);
      Node := TGroupDataTreeNodeEh(GetNextVisible(Node, False));
    end;
    finally
      EndUpdate;
    end;
  end;
  RebuildFlatVisibleList;
end;

function TGridGroupDataTreeEh.CompareNodes(Node1, Node2: TBaseTreeNodeEh;
  ParamSort: TObject): Integer;
var
  GroupNode1, GroupNode2: TGroupDataTreeNodeEh;
  Relationship: TVariantRelationship;
  SortOrder: TSortOrderEh;
begin
  GroupNode1 := TGroupDataTreeNodeEh(Node1);
  GroupNode2 := TGroupDataTreeNodeEh(Node2);
  SortOrder := TSortOrderEh(ParamSort);
  Result := 0;
  if GroupNode1.NodeType = dntDataGroupEh then
  begin
    Relationship := DBVarCompareValue(GroupNode1.KeyValue, GroupNode2.KeyValue);
    if Relationship = vrLessThan then
      Result := -1
    else if Relationship = vrGreaterThan then
      Result := 1;
    if SortOrder = soDescEh then
      Result := -Result;
  end;
end;

procedure TGridGroupDataTreeEh.DeleteRecordNodesUpToLevel(Level: Integer);
var
  Node, DelNode, FirstNode: TGroupDataTreeNodeEh;
begin
//TODO: Optimize
//Not finished if tree deeper than 1.
{  if Level <= 1 then
  begin
    Clear;
    Exit;
  end;}

  Node := GetFirstNodeAtLevel(Level);
  FirstNode := Node;
  while Node <> nil do
  begin
    if (Node.Level = Level) and (Node.NodeType = dntDataGroupEh) then
    begin
      if FirstNode = Node then
      begin
        DeleteNode(Node, True);
        Node := GetFirstNodeAtLevel(Level);
        FirstNode := Node;
      end else
      begin
        DelNode := Node;
        Node := GetNextNodeAtLevel(Node, Level);
        DeleteNode(DelNode, True);
      end;
    end else
    begin
      Node := GetNextNodeAtLevel(Node, Level);
    end;
  end;
end;

function TGridGroupDataTreeEh.GetFirstNodeAtLevel(Level: Integer): TGroupDataTreeNodeEh;
begin
  Result := TGroupDataTreeNodeEh(GetFirstVisible);
  while Result <> nil do
  begin
    if Result.Level = Level then Exit;
    Result := TGroupDataTreeNodeEh(GetNextVisible(Result, False));
  end;
  Result := nil;
end;

function TGridGroupDataTreeEh.GetNextNodeAtLevel(
  Node: TGroupDataTreeNodeEh; Level: Integer): TGroupDataTreeNodeEh;
begin
  Result := Node;
  while Result <> nil do
  begin
    Result := TGroupDataTreeNodeEh(GetNextVisible(Result, False));
    if (Result <> nil) and (Result.Level = Level) then
      Exit;
  end;
  Result := nil;
end;

function TGridGroupDataTreeEh.IndexOfVisibleRecordViewNo(RecordViewNo: Integer): Integer;
var
  i: Integer;
begin
  for i := 0 to FlatVisibleCount-1 do
  begin
    if FlatVisibleItem[i].DataSetRecordViewNo = RecordViewNo then
    begin
      Result := i;
      Exit;
    end;
  end;
  Result := -1;
end;

function TGridGroupDataTreeEh.GetFirst: TGroupDataTreeNodeEh;
begin
  Result := TGroupDataTreeNodeEh(inherited GetFirst);
end;

function TGridGroupDataTreeEh.GetFirstVisible: TGroupDataTreeNodeEh;
begin
  Result := TGroupDataTreeNodeEh(inherited GetFirstVisible);
end;

function TGridGroupDataTreeEh.GetNext(Node: TGroupDataTreeNodeEh): TGroupDataTreeNodeEh;
begin
  Result := TGroupDataTreeNodeEh(inherited GetNext(Node));
end;

function TGridGroupDataTreeEh.GetNextVisible(Node: TGroupDataTreeNodeEh;
  ConsiderCollapsed: Boolean): TGroupDataTreeNodeEh;
begin
  Result := TGroupDataTreeNodeEh(inherited GetNextVisible(Node, ConsiderCollapsed));
end;

function TGridGroupDataTreeEh.GetPathVisible(Node: TGroupDataTreeNodeEh;
  ConsiderCollapsed: Boolean): Boolean;
begin
  Result := inherited GetPathVisible(Node, ConsiderCollapsed);
end;

function TGridGroupDataTreeEh.GetPrevious(Node: TGroupDataTreeNodeEh): TGroupDataTreeNodeEh;
begin
  Result := TGroupDataTreeNodeEh(inherited GetPrevious(Node));
end;

procedure TGridGroupDataTreeEh.Collapse(Node: TGroupDataTreeNodeEh;
  Recurse: Boolean);
begin
  inherited Collapse(Node, Recurse);
end;

procedure TGridGroupDataTreeEh.Expand(Node: TGroupDataTreeNodeEh;
  Recurse: Boolean);
begin
  inherited Expand(Node, Recurse);
end;

{ TGroupDataTreeNodeEh }

procedure TGroupDataTreeNodeEh.AppendDataRec(AIntMemTable: IMemTableEh; ADataSet: TDataSet);
var
  KeyValue: Variant;
  HighBound: Integer;
  ADataGroup: TGridDataGroupsEh;
  TargetNode: TGroupDataTreeNodeEh;
  Bookmark: TUniBookmarkEh;
  AGrid: TCustomDBGridEhCrack;
  UseInternalUpdatingDatasetPos: BOolean;
begin
  if not ( (Count > 0) and (Items[0].NodeType = dntDataSetRecordEh) ) then
    Exit;
  ADataGroup := DataGroupLevel.GridDataGroupLevels.DataGroup;
  TargetNode := Items[Count-1];

  KeyValue := ADataGroup.GetKeyValueForViewRecNo(TargetNode.DataSetRecordViewNo);
  HighBound := VarArrayHighBound(KeyValue, 1);
  KeyValue[HighBound] := MaxInt; //To make record be placed after the last
  ADataGroup.SetInsertingKeyValue(KeyValue);

  AGrid := TCustomDBGridEhCrack(ADataGroup.FGrid);

  UseInternalUpdatingDatasetPos := False;
  if not AGrid.FInternalUpdatingDatasetPos then
  begin
    AGrid.FInternalUpdatingDatasetPos := True;
    UseInternalUpdatingDatasetPos := True;
  end;
  try

  if AIntMemTable.InstantReadRowCount = TargetNode.DataSetRecordViewNo+1 then
    ADataSet.Append
  else
  begin
    AIntMemTable.InstantReadEnter(TargetNode.DataSetRecordViewNo);
    try
      Bookmark := ADataSet.Bookmark;
    finally
      AIntMemTable.InstantReadLeave;
    end;
//    ADataSet.DisableControls;
    try
      ADataSet.Bookmark := Bookmark;
      ADataSet.Next;
    finally
//      ADataSet.EnableControls;
    end;
    ADataSet.Insert;
  end;

  finally
    if UseInternalUpdatingDatasetPos then
    begin
      AGrid.DataGroupsGotoRecordViewNo(AIntMemTable.InstantReadCurRowNum, False);
      AGrid.FInternalUpdatingDatasetPos := False;
    end;
  end;
end;

function TGroupDataTreeNodeEh.CanAppendDataRec: Boolean;
var
  ADataGroup: TGridDataGroupsEh;
  ADataGroupLevel: TGridDataGroupLevelEh;
begin
  Result := False;
  if NodeType in [dntDataGroupEh, dntDataGroupFooterEh] then
  begin
    if NodeType = dntDataGroupEh then
    begin
      ADataGroup := DataGroupLevel.GridDataGroupLevels.DataGroup;
      ADataGroupLevel := DataGroupLevel
    end else
    begin
      ADataGroup := Parent.DataGroupLevel.GridDataGroupLevels.DataGroup;
      ADataGroupLevel := Parent.DataGroupLevel;
    end;
    if ADataGroup.ActiveGroupLevels[ADataGroup.ActiveGroupLevelsCount-1] = ADataGroupLevel then
      if NodeType = dntDataGroupEh then
        Result := True
      else if Parent.FooterItems[0] = Self then
        Result := True
  end;
end;

function TGroupDataTreeNodeEh.GetCount: Integer;
begin
  Result := inherited Count - FooterItemCount;
  if Result < 0 then Result := 0;
end;

function TGroupDataTreeNodeEh.GetDataItem(
  const Index: Integer): TGroupDataTreeNodeEh;
begin
  Result := TGroupDataTreeNodeEh(inherited Items[Index]);
end;

function TGroupDataTreeNodeEh.GetFooterItem(
  const Index: Integer): TGroupDataTreeNodeEh;
begin
  Result := TGroupDataTreeNodeEh(inherited Items[Index + Count]);
end;

function TGroupDataTreeNodeEh.GetFooterItemCount: Integer;
begin
  Result := FFooterItemCount;
end;

function TGroupDataTreeNodeEh.GetFooterValueCount: Integer;
begin
  Result := VarArrayHighBound(FFooterValue, 0);
end;

function TGroupDataTreeNodeEh.GetFooterValues(const Index: Integer): Variant;
begin
  Result := FFooterValue[Index];
end;

function TGroupDataTreeNodeEh.GetFullItemCount: Integer;
begin
  Result := inherited Count;
end;

function TGroupDataTreeNodeEh.GetOwner: TGridGroupDataTreeEh;
begin
  Result := TGridGroupDataTreeEh(inherited Owner);
end;

function TGroupDataTreeNodeEh.GetParent: TGroupDataTreeNodeEh;
begin
  Result := TGroupDataTreeNodeEh(inherited Parent);
end;

{function TGroupDataTreeNodeEh.GetFooterValue(FooterIndex,
  ColumnIndex: Integer): Variant;
var
  AGrid: TCustomDBGridEhCrack;
begin
  AGrid := TCustomDBGridEhCrack(TGridGroupDataTreeEh(Owner).GridDataGroups.FGrid);
  Result := FFooterValue[AGrid.Columns.Count * FooterIndex + ColumnIndex];
end;}

function TGroupDataTreeNodeEh.GetRowHeight: Integer;
begin
  if FRowHeightNeedUpdate then
    UpdateRowHeight;
  Result := FRowHeight;
end;

function TGroupDataTreeNodeEh.RecordNodeLastInGroup: Boolean;
begin
  Result := False;
  if (NodeType = dntDataSetRecordEh) and (Parent.Items[Parent.Count-1] = Self) then
    Result := True;
end;

procedure TGroupDataTreeNodeEh.ResetFooters;
var
  i, j: Integer;
  FooterNode: TGroupDataTreeNodeEh;
begin
  if Self = Owner.Root then
  begin
    FooterItemCount := Owner.GridDataGroups.Footers.Count;
    for i := 0 to FooterItemCount - 1 do
    begin
      FooterNode := FooterItems[i];
      FooterNode.FGroupDataTreeNodeType := dntDataGroupFooterEh;
      FooterNode.FDataGroupFooter := Owner.GridDataGroups.Footers[i];
      SetLength(FooterNode.FFooterValue,
        FooterNode.DataGroupFooter.GetColumnItems.Count);
      for j := 0 to FooterNode.DataGroupFooter.GetColumnItems.Count-1 do
        VarClear(FooterNode.FFooterValue[j]);
    end;
  end else
  begin
    FooterItemCount := DataGroupLevel.VisibleFootersCount;
    for i := 0 to FooterItemCount - 1 do
    begin
      FooterNode := FooterItems[i];
      FooterNode.FGroupDataTreeNodeType := dntDataGroupFooterEh;
      FooterNode.FDataGroupFooter := DataGroupLevel.VisibleFooter[i];
      SetLength(FooterNode.FFooterValue,
        FooterNode.DataGroupFooter.GetColumnItems.Count);
      for j := 0 to FooterNode.DataGroupFooter.GetColumnItems.Count-1 do
        VarClear(FooterNode.FFooterValue[j]);
    end;
  end;
end;

procedure TGroupDataTreeNodeEh.RowDataChanged;
begin
  FRowHeightNeedUpdate := True;
end;

procedure TGroupDataTreeNodeEh.SetFooterItemCount(const Value: Integer);
var
  I: Integer;
begin
  if FFooterItemCount <> Value then
  begin
    if Value > FFooterItemCount then
    begin
      for I := FFooterItemCount to Value - 1 do
        Owner.AddChild('', Self, nil)
    end else
    begin
      for I := FFooterItemCount-1 downto Value do
        Owner.DeleteNode(FooterItems[I], True);
    end;
    FFooterItemCount := Value;
  end;
end;

procedure TGroupDataTreeNodeEh.SetRowHeight(const Value: Integer);
begin
  FRowHeight := Value;
  FRowHeightNeedUpdate := False;
end;

procedure TGroupDataTreeNodeEh.SortData(CompareProg: TCompareNodesEh;
  ParamSort: TObject; ARecurse: Boolean);
var
  i: Integer;
begin
  if Count = 0 then Exit;
  QuickSort(0, Count-1, CompareProg, ParamSort);
  if ARecurse then
    for i := 0 to Count-1  do
      Items[i].SortData(CompareProg, ParamSort, ARecurse);
//  Owner.BuildChildrenIndex(Self, False);
end;

procedure TGroupDataTreeNodeEh.UpdateRowHeight;
var
  AGrid: TCustomDBGridEhCrack;
begin
  AGrid := TCustomDBGridEhCrack(TGridGroupDataTreeEh(Owner).FGridDataGroups.FGrid);
  if NodeType in [dntDataGroupEh, dntDataGroupFooterEh] then
    RowHeight := AGrid.CalcHeightForGroupNode(Self)
  else
  begin
    AGrid.FIntMemTable.InstantReadEnter(DataSetRecordViewNo);
    try
      RowHeight := AGrid.CalcRowForCurRecordHeight;
    finally
      AGrid.FIntMemTable.InstantReadLeave;
    end;
  end;
end;

{ TGridDataGroupFootersEh }

constructor TGridDataGroupFootersEh.Create(Owner: TPersistent;
  FooterClass: TGridDataGroupFooterEhClass);
begin
  inherited Create(FooterClass);
  FOwner := Owner;
end;

procedure TGridDataGroupFootersEh.DrawFormatChanged;
begin
  if GroupLevel <> nil
    then GroupLevel.DrawFormatChanged
    else Groups.DrawFormatChanged;
end;

procedure TGridDataGroupFootersEh.FooterValuesChanged;
begin
  GetMasterGroups.FooterValuesChanged;
end;

function TGridDataGroupFootersEh.Add: TGridDataGroupFooterEh;
begin
  Result := TGridDataGroupFooterEh(inherited Add);
end;

function TGridDataGroupFootersEh.GetFooter(Index: Integer): TGridDataGroupFooterEh;
begin
  Result := TGridDataGroupFooterEh(inherited Items[Index]);
end;

function TGridDataGroupFootersEh.GetMasterGroups: TGridDataGroupsEh;
begin
  Result := nil;
  if FOwner is TGridDataGroupLevelEh then
    Result := TGridDataGroupLevelEh(FOwner).GridDataGroupLevels.DataGroup
  else if FOwner is TGridDataGroupsEh then
    Result := Groups;
end;

function TGridDataGroupFootersEh.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

function TGridDataGroupFootersEh.GridComponent: TComponent;
begin
  Result := nil;
  if FOwner is TGridDataGroupLevelEh then
    Result := TGridDataGroupLevelEh(FOwner).GridDataGroupLevels.Grid
  else if FOwner is TGridDataGroupsEh then
    Result := TGridDataGroupsEh(FOwner).FGrid;
end;

function TGridDataGroupFootersEh.GroupLevel: TGridDataGroupLevelEh;
begin
  Result := nil;
  if FOwner is TGridDataGroupLevelEh then
    Result := TGridDataGroupLevelEh(FOwner);
end;

function TGridDataGroupFootersEh.Groups: TGridDataGroupsEh;
begin
  Result := nil;
  if FOwner is TGridDataGroupsEh then
    Result := TGridDataGroupsEh(FOwner);
end;

procedure TGridDataGroupFootersEh.SetFooter(Index: Integer;
  const Value: TGridDataGroupFooterEh);
begin
  Items[Index].Assign(Value);
end;

procedure TGridDataGroupFootersEh.StructureChanged;
var
  DataGroups: TGridDataGroupsEh;
begin
  DataGroups := nil;
  RefreshVisibleFooters;
  if GetOwner is TGridDataGroupLevelEh then
    DataGroups := TGridDataGroupsEh(
      TGridDataGroupLevelsEh(TGridDataGroupLevelEh(GetOwner).Collection).GetOwner)
  else if GetOwner is TGridDataGroupsEh then
    DataGroups := TGridDataGroupsEh(GetOwner);
  if (DataGroups <> nil) then
    DataGroups.FooterStructureChanged;
end;

procedure TGridDataGroupFootersEh.RefreshDefaultFont;
var
  i: Integer;
begin
  for i := 0 to Count-1 do
    Items[i].RefreshDefaultFont;
end;

function TGridDataGroupFootersEh.GetVisibleFooter(Index: Integer): TGridDataGroupFooterEh;
begin
  Result := FVisibleFooters[Index];
end;

function TGridDataGroupFootersEh.GetVisibleItemsCount: Integer;
begin
  Result := Length(FVisibleFooters);
end;

procedure TGridDataGroupFootersEh.RefreshVisibleFooters;
var
  i,j: Integer;
begin
  SetLength(FVisibleFooters, Count);
  j := 0;
  for i := 0 to Count-1 do
    if Items[i].Visible then
    begin
      FVisibleFooters[j] := Items[i];
      Inc(j);
    end;
  SetLength(FVisibleFooters, j);
end;

{ TGridDataGroupFooterEh }

constructor TGridDataGroupFooterEh.Create(Collection: TCollection);
var
  Grid: TCustomDBGridEh;
begin
  inherited Create(Collection);
  FColumnItems := TGridDataGroupFooterColumnItemsEh.Create(Self, TGridDataGroupFooterColumnItemEh);
  FFont := TFont.Create;
  FFont.Assign(DefaultFont);
  FFont.OnChange := FontChanged;
  FColor := clWindow;
  FParentFont := True;
  FParentColor := True;
  FShowFunctionName := False;
  Grid := TCustomDBGridEh(FootersCollection.GridComponent);
  if not (csLoading in FootersCollection.GridComponent.ComponentState) then
//    ColumnItems.ResetItems;
    CheckColumnsChanged(Grid.Columns);
  FootersCollection.StructureChanged;
end;

destructor TGridDataGroupFooterEh.Destroy;
var
  AFootersCollection: TGridDataGroupFootersEh;
begin
  FreeAndNil(FFont);
  FreeAndNil(FColumnItems);
  AFootersCollection := FootersCollection;
  SetCollection(nil);
  AFootersCollection.StructureChanged;
  inherited Destroy;
end;

procedure TGridDataGroupFooterEh.Assign(Source: TPersistent);
begin
  if Source is TGridDataGroupFooterEh then
  begin
    Color := TGridDataGroupFooterEh(Source).Color;
    Font := TGridDataGroupFooterEh(Source).Font;
    Visible := TGridDataGroupFooterEh(Source).Visible;
    ColumnItems := TGridDataGroupFooterEh(Source).ColumnItems;
    ParentColor := TGridDataGroupFooterEh(Source).ParentColor;
    ParentFont := TGridDataGroupFooterEh(Source).ParentFont;
    ShowFunctionName := TGridDataGroupFooterEh(Source).ShowFunctionName;
    ShowFunctionNameStored := TGridDataGroupFooterEh(Source).ShowFunctionNameStored;
    RunTimeCustomizable := TGridDataGroupFooterEh(Source).RunTimeCustomizable;
    RunTimeCustomizableStored := TGridDataGroupFooterEh(Source).RunTimeCustomizableStored;
  end
  else
    inherited Assign(Source);
end;

function TGridDataGroupFooterEh.CheckColumnsChanged(Columns: TCollection): Boolean;
var
  AColumns: TDBGridColumnsEh;
  i: Integer;
  NewIndex: Integer;
  ColumnItem: TGridDataGroupFooterColumnItemEh;
begin
  Result := False;
  AColumns := TDBGridColumnsEh(Columns);
// Check deleted Columns
  for i := ColumnItems.Count-1 downto 0 do
  begin
     if not AColumns.CheckItemInList(TColumnEh(ColumnItems[i].Column)) then
      ColumnItems[i].Free;
//    AColumns.In
  end;

  for i := 0 to AColumns.Count-1 do
  begin
    NewIndex := ColumnItems.ItemIndexByColumn(AColumns[i]);
    if NewIndex <> i then
    begin
      if NewIndex = -1 then
      begin
        ColumnItem := ColumnItems.Add;
        ColumnItem.FColumn := AColumns[i];
        ColumnItem.FFieldName := AColumns[i].FieldName;
        Result := True;
      end else
      begin
        ColumnItem := ColumnItems[NewIndex];
        ColumnItem.Index := i;
        Result := True;
      end;
    end else if ColumnItems[NewIndex].FieldName <> AColumns[i].FieldName then
    begin
      ColumnItems[NewIndex].FFieldName := AColumns[i].FieldName;
      Result := True;
    end;
  end;
end;

function TGridDataGroupFooterEh.DefaultColor: TColor;
begin
  if FootersCollection.GetOwner is TGridDataGroupLevelEh then
    Result := FootersCollection.GroupLevel.DefaultFooterColor
  else if FootersCollection.GetOwner is TGridDataGroupsEh then
    Result := FootersCollection.Groups.DefaultFooterColor
  else
    Result := FColor;
end;

function TGridDataGroupFooterEh.DefaultFont: TFont;
begin
  if FootersCollection.GetOwner is TGridDataGroupLevelEh then
    Result := FootersCollection.GroupLevel.DefaultFooterFont
  else if FootersCollection.GetOwner is TGridDataGroupsEh then
    Result := FootersCollection.Groups.DefaultFooterFont
  else
    Result := FFont;
end;

procedure TGridDataGroupFooterEh.FontChanged(Sender: TObject);
begin
  FParentFont := False;
  ColumnItems.RefreshDefaultFont;
  DrawFormatChanged;
end;

function TGridDataGroupFooterEh.FootersCollection: TGridDataGroupFootersEh;
begin
  Result := TGridDataGroupFootersEh(Collection);
end;

procedure TGridDataGroupFooterEh.FooterValuesChanged;
begin
  FootersCollection.FooterValuesChanged;
end;

function TGridDataGroupFooterEh.GetColor: TColor;
begin
  if ParentColor
    then Result := DefaultColor
    else Result := FColor;
end;

function TGridDataGroupFooterEh.GetFont: TFont;
begin
  {$WARNINGS OFF}
  if ParentFont and (FFont.Handle <> DefaultFont.Handle) then
  {$WARNINGS ON}
    RefreshDefaultFont;
  Result := FFont;
end;

function TGridDataGroupFooterEh.GetRowHeight: Integer;
begin
  Result := 0;
 { TODO : Finish this }
end;

(*
function TGridDataGroupFooterEh.GetShowWhenGroupCollapsed: Boolean;
begin
  Result := False;
 { TODO : Finish this }
end;

procedure TGridDataGroupFooterEh.SetShowWhenGroupCollapsed(const Value: Boolean);
begin

end;
*)

function TGridDataGroupFooterEh.GetVisible: Boolean;
begin
  Result := FVisible;
end;

function TGridDataGroupFooterEh.IsColorStored: Boolean;
begin
  Result := not ParentColor;
end;

function TGridDataGroupFooterEh.IsFontStored: Boolean;
begin
  Result := not ParentFont;
end;

procedure TGridDataGroupFooterEh.RefreshDefaultFont;
var
  Save: TNotifyEvent;
begin
  if not ParentFont then Exit;
  Save := FFont.OnChange;
  FFont.OnChange := nil;
  try
    FFont.Assign(DefaultFont);
  finally
    FFont.OnChange := Save;
  end;
  ColumnItems.RefreshDefaultFont;
end;

procedure TGridDataGroupFooterEh.SetColor(const Value: TColor);
begin
  if not ParentColor and (Value = FColor) then Exit;
  FColor := Value;
  ParentColor := False;
  DrawFormatChanged;
end;

procedure TGridDataGroupFooterEh.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
end;

{
function TGridDataGroupFooterEh.GetInGroupRow: Boolean;
begin
  Result := False;
end;

procedure TGridDataGroupFooterEh.SetInGroupRow(const Value: Boolean);
begin

end;
}

{
function TGridDataGroupFooterEh.GetShowRowInGridFooter: Boolean;
begin
  Result := FShowRowInGridFooter;
end;

procedure TGridDataGroupFooterEh.SetShowRowInGridFooter(const Value: Boolean);
begin
  if FShowRowInGridFooter <> Value then
  begin
    FShowRowInGridFooter := Value;
    DrawFormatChanged;
  end;
end;
}

procedure TGridDataGroupFooterEh.SetVisible(const Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    FootersCollection.StructureChanged;
  end;
end;

procedure TGridDataGroupFooterEh.DrawFormatChanged;
begin
  FootersCollection.DrawFormatChanged;
end;

procedure TGridDataGroupFooterEh.SetParentColor(const Value: Boolean);
begin
  if FParentColor <> Value then
  begin
    FParentColor := Value;
    DrawFormatChanged;
  end;
end;

procedure TGridDataGroupFooterEh.SetParentFont(const Value: Boolean);
begin
  if FParentFont <> Value then
  begin
    FParentFont := Value;
    RefreshDefaultFont;
    DrawFormatChanged;
  end;
end;

procedure TGridDataGroupFooterEh.SetRowHeight(const Value: Integer);
begin

end;

function TGridDataGroupFooterEh.GetColumnItems: TGridDataGroupFooterColumnItemsEh;
begin
  Result := FColumnItems;
end;

procedure TGridDataGroupFooterEh.SetColumnItems(const Value: TGridDataGroupFooterColumnItemsEh);
begin
  FColumnItems.Assign(Value);
end;

procedure TGridDataGroupFooterEh.ColumnsLoaded(Columns: TCollection);
var
  AColumns: TDBGridColumnsEh;
  i: Integer;
  ColumnItem: TGridDataGroupFooterColumnItemEh;
begin
  AColumns := TDBGridColumnsEh(Columns);
  for i := 0 to ColumnItems.Count-1 do
  begin
    ColumnItem := ColumnItems[i];
    ColumnItem.FColumn := AColumns[i];
    ColumnItem.FFieldName := AColumns[i].FieldName;
  end;
end;

function TGridDataGroupFooterEh.GetDisplayName: string;
var
  Grid: TCustomDBGridEh;
  FootersOwner: TPersistent;
begin
  Grid := TCustomDBGridEh(FootersCollection.GridComponent);
  if Grid <> nil then
    Result := TGridDataGroupLevelsEh(Collection).GetGrid.Name + '.DataGrouping';
  FootersOwner := FootersCollection.GetOwner;

  if FootersOwner is TGridDataGroupLevelEh then
//    Result := TGridDataGroupLevelEh(FootersOwner).GridDataGroupLevels.Grid
  else if FootersOwner is TGridDataGroupsEh then
    Result := Result + '.Footers[' + IntToStr(Index) + ']';
end;

procedure TGridDataGroupFooterEh.SetShowFunctionName(const Value: Boolean);
begin
  if ShowFunctionNameStored and (Value = FShowFunctionName) then Exit;
  ShowFunctionNameStored := True;
  FShowFunctionName := Value;
  DrawFormatChanged;
end;

function TGridDataGroupFooterEh.GetShowFunctionName: Boolean;
begin
  if ShowFunctionNameStored
    then Result := FShowFunctionName
    else Result := DefaultShowFunctionName;
end;

function TGridDataGroupFooterEh.DefaultShowFunctionName: Boolean;
begin
  Result := False;
  if FootersCollection.Groups <> nil then
    Result := FootersCollection.Groups.FootersDefValues.ShowFunctionName
  else if FootersCollection.GroupLevel <> nil then
    Result := FootersCollection.GroupLevel.GridDataGroupLevels.DataGroup.FootersDefValues.ShowFunctionName;
end;

function TGridDataGroupFooterEh.IsShowFunctionNameStored: Boolean;
begin
  Result := FShowFunctionNameStored;
end;

procedure TGridDataGroupFooterEh.SetShowFunctionNameStored(const Value: Boolean);
begin
  if FShowFunctionNameStored <> Value then
  begin
    FShowFunctionNameStored := Value;
    FShowFunctionName := DefaultShowFunctionName;
    FooterValuesChanged;
  end;
end;

function TGridDataGroupFooterEh.GetRunTimeCustomizable: Boolean;
begin
  if IsRunTimeCustomizableStored then
    Result := FRunTimeCustomizable
  else
    Result := DefaultRunTimeCustomizable;
end;

function TGridDataGroupFooterEh.IsRunTimeCustomizableStored: Boolean;
begin
  Result := FRunTimeCustomizableStored;
end;

procedure TGridDataGroupFooterEh.SetRunTimeCustomizable(const Value: Boolean);
begin
  if RunTimeCustomizableStored and (Value = FRunTimeCustomizable) then Exit;
  RunTimeCustomizableStored := True;
  FRunTimeCustomizable := Value;
end;

procedure TGridDataGroupFooterEh.SetRunTimeCustomizableStored(const Value: Boolean);
begin
  if RunTimeCustomizableStored <> Value then
  begin
    FRunTimeCustomizableStored := Value;
    FRunTimeCustomizable := DefaultRunTimeCustomizable;
  end;
end;

function TGridDataGroupFooterEh.DefaultRunTimeCustomizable: Boolean;
begin
  Result := False;
  if FootersCollection.Groups <> nil then
    Result := FootersCollection.Groups.FootersDefValues.RunTimeCustomizable
  else if FootersCollection.GroupLevel <> nil then
    Result := FootersCollection.GroupLevel.GridDataGroupLevels.DataGroup.FootersDefValues.RunTimeCustomizable;
end;

function TGridDataGroupFooterEh.StoreColumnItems: Boolean;
var
  Grid: TCustomDBGridEh;
begin
  Result := False;
  Grid := TCustomDBGridEh(FootersCollection.GridComponent);
  if Grid <> nil then
    Result := (Grid.Columns.State = csCustomized);
end;

{ TGridDataGroupFooterColumnItemEh }

constructor TGridDataGroupFooterColumnItemEh.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FFont := TFont.Create;
  FFont.Assign(DefaultFont);
  FFont.OnChange := FontChanged;
  FColor := clWindow;
  FParentFont := True;
  FParentColor := True;
  FAlignment := taRightJustify;
  FShowFunctionName := False;
  FShowFunctionNameStored := False;
end;

destructor TGridDataGroupFooterColumnItemEh.Destroy;
begin
  inherited Destroy;
  FreeAndNil(FFont);
end;

procedure TGridDataGroupFooterColumnItemEh.Assign(Source: TPersistent);
begin
  if Source is TGridDataGroupFooterColumnItemEh then
  begin
    Alignment := TGridDataGroupFooterColumnItemEh(Source).Alignment;
    Color := TGridDataGroupFooterColumnItemEh(Source).Color;
    DisplayFormat := TGridDataGroupFooterColumnItemEh(Source).DisplayFormat;
    Font := TGridDataGroupFooterColumnItemEh(Source).Font;
    ParentColor := TGridDataGroupFooterColumnItemEh(Source).ParentColor;
    ParentFont := TGridDataGroupFooterColumnItemEh(Source).ParentFont;
    ValueType := TGridDataGroupFooterColumnItemEh(Source).ValueType;
    ShowFunctionName := TGridDataGroupFooterColumnItemEh(Source).ShowFunctionName;
    ShowFunctionNameStored := TGridDataGroupFooterColumnItemEh(Source).ShowFunctionNameStored;
    RunTimeCustomizable := TGridDataGroupFooterColumnItemEh(Source).RunTimeCustomizable;
    RunTimeCustomizableStored := TGridDataGroupFooterColumnItemEh(Source).RunTimeCustomizableStored;
  end
  else
    inherited Assign(Source);
end;

procedure TGridDataGroupFooterColumnItemEh.AggregateValue(var AValue: Variant;
  Node: TGroupDataTreeNodeEh);
var
  AColumn: TColumnEh;
  AddValue: Variant;
begin
  AColumn := TColumnEh(Column);
  if AColumn.Field <> nil
    then AddValue := AColumn.Field.Value
    else AddValue := Null;
  if (ValueType <> gfvNonEh) and CheckCustomAggregateValue(AValue, Node) then
    Exit;
  if VarIsEmpty(AValue) then
    case ValueType of
      gfvNonEh: AValue := Null;
      gfvSumEh: AValue := AddValue;
      gfvAvgEh:
        begin
          AValue := VarArrayCreate([0,1], varVariant);
          AValue[0] := AddValue;
          if VarIsNull(AValue[0])
            then AValue[1] := 0
            else AValue[1] := 1;
        end;
      gfvCountEh:
        if VarIsNull(AddValue)
          then AValue := 0
          else AValue := 1;
      gfvStaticTextEh: AValue := 'StaticText';
      gfvCustomEh: AValue := 'Custom';
      gfvMaxEh: AValue := AddValue;
      gfvMinEh: AValue := AddValue;
    end
  else
    case ValueType of
      gfvNonEh:
        AValue := '';
      gfvSumEh:
        if not VarIsNull(AddValue) then
        begin
          if VarIsNull(AValue)
            then AValue := AddValue
            else AValue := AValue + AddValue;
        end;
      gfvAvgEh:
        if not VarIsNull(AddValue) then
        begin
          if VarIsNull(AValue[0])
            then AValue[0] := AddValue
            else AValue[0] := AValue[0] + AddValue;
          AValue[1] := AValue[1] + 1;
        end;
      gfvCountEh:
        if not VarIsNull(AddValue) then
          AValue := AValue + 1;
      gfvStaticTextEh:
        AValue := 'StaticText';
      gfvCustomEh:
        AValue := 'Custom';
      gfvMaxEh:
        if not VarIsNull(AddValue) and (VarIsNull(AValue) or (AValue < AddValue)) then
          AValue := AddValue;
      gfvMinEh:
        if not VarIsNull(AddValue) and (VarIsNull(AValue) or (AValue > AddValue)) then
          AValue := AddValue;
    end;
end;

function TGridDataGroupFooterColumnItemEh.FieldName: String;
begin
  Result := FFieldName;
end;

procedure TGridDataGroupFooterColumnItemEh.FinalizeValue(var AValue: Variant);
begin
  if (ValueType <> gfvNonEh) and CheckCustomFinalizeValue(AValue) then
    Exit;
  if not VarIsEmpty(AValue) and (ValueType = gfvAvgEh) then
    if AValue[1] = 0
      then AValue := Null
      else AValue := AValue[0] / AValue[1]
  else if VarIsEmpty(AValue) and (ValueType = gfvCountEh) then
    AValue := 0;
end;

function TGridDataGroupFooterColumnItemEh.AggrValue(
  FooterNode: TGroupDataTreeNodeEh): Variant;
begin
  Result := FooterNode.FooterValues[TColumnEh(Column).Index];
end;

function TGridDataGroupFooterColumnItemEh.CheckCustomAggregateValue(
  var AValue: Variant; Node: TGroupDataTreeNodeEh): Boolean;
var
  AColumn: TColumnEh;
  AGroupFooter: TGridDataGroupFooterEh;
  AGrid: TCustomDBGridEhCrack;
begin
  Result := False;
  AColumn := TColumnEh(Column);
  AGroupFooter := Collection.Footer;
  AGrid := TCustomDBGridEhCrack(Collection.Footer.FootersCollection.GridComponent);
  if AGrid <> nil then
    AGrid.DoDataGroupFooterItemAggregateValue(AColumn, AGroupFooter, Self, AValue, Node, Result);
end;

function TGridDataGroupFooterColumnItemEh.CheckCustomFinalizeValue(
  var AValue: Variant): Boolean;
var
  AColumn: TColumnEh;
  AGroupFooter: TGridDataGroupFooterEh;
  AGrid: TCustomDBGridEhCrack;
begin
  Result := False;
  AColumn := TColumnEh(Column);
  AGroupFooter := Collection.Footer;
  AGrid := TCustomDBGridEhCrack(Collection.Footer.FootersCollection.GridComponent);
  if AGrid <> nil then
    AGrid.DoDataGroupFooterItemFinalizeValue(AColumn, AGroupFooter, Self, AValue, Result);
end;

function TGridDataGroupFooterColumnItemEh.Column: TPersistent;
begin
  Result := FColumn;
end;

const
  AggrFuncNames: array[TGroupFooterValueTypeEh] of String = (
    '', 'Sum = ', 'Avg = ', 'Cnt = ',
    'Max = ', 'Min = ', '', '' );

function TGridDataGroupFooterColumnItemEh.ConvertToDisplayText(
  AValue: Variant): String;
var
  ADisplayFormat: String;
  AField: TField;
begin
  Result := '';
  if (ValueType <> gfvNonEh) and CheckCustomConvertToDisplayText(AValue, Result) then
    Exit;
  if DisplayFormat <> '' then
    ADisplayFormat := DisplayFormat
  else
    ADisplayFormat := TColumnEh(Column).DisplayFormat;
  AField := TColumnEh(Column).Field;
  if AField = nil then
  begin
    Result := VarToStr(AValue)
  end else
  begin
    case ValueType of
      gfvNonEh:
        Result := VarToStr(AValue);
      gfvSumEh:
        Result := FieldValueToDispayValue(AValue, AField, ADisplayFormat);
      gfvAvgEh:
        begin
          if DisplayFormat = '' then
            ADisplayFormat := '0.####';
          Result := FieldValueToDispayValue(AValue, AField, ADisplayFormat);
        end;
      gfvCountEh:
        Result := VarToStr(AValue);
      gfvStaticTextEh:
        Result := VarToStr(AValue);
      gfvCustomEh:
        Result := VarToStr(AValue);
      gfvMaxEh:
        Result := FieldValueToDispayValue(AValue, AField, ADisplayFormat);
      gfvMinEh:
        Result := FieldValueToDispayValue(AValue, AField, ADisplayFormat);
    end;
  end;

  if ShowFunctionName and (ValueType in [gfvSumEh, gfvAvgEh, gfvCountEh, gfvMaxEh, gfvMinEh]) then
    Result := AggrFuncNames[ValueType] + Result;
end;

function TGridDataGroupFooterColumnItemEh.CheckCustomConvertToDisplayText(
  var AValue: Variant; var DisplayValue: String): Boolean;
var
  AColumn: TColumnEh;
  AGroupFooter: TGridDataGroupFooterEh;
  AGrid: TCustomDBGridEhCrack;
begin
  Result := False;
  AColumn := TColumnEh(Column);
  AGroupFooter := Collection.Footer;
  AGrid := TCustomDBGridEhCrack(Collection.Footer.FootersCollection.GridComponent);
  if AGrid <> nil then
    AGrid.DoDataGroupFooterItemToDisplayText(AColumn, AGroupFooter, Self, AValue, DisplayValue, Result);
end;

function TGridDataGroupFooterColumnItemEh.DefaultColor: TColor;
begin
  Result := Collection.Footer.Color;
end;

function TGridDataGroupFooterColumnItemEh.DefaultFont: TFont;
begin
  Result := Collection.Footer.Font;
end;

procedure TGridDataGroupFooterColumnItemEh.DrawFormatChanged;
begin
  Collection.Footer.DrawFormatChanged;
end;

procedure TGridDataGroupFooterColumnItemEh.FontChanged(Sender: TObject);
begin
  FParentFont := False;
  DrawFormatChanged;
end;

function TGridDataGroupFooterColumnItemEh.GetAlignment: TAlignment;
begin
  Result := FAlignment;
end;

procedure TGridDataGroupFooterColumnItemEh.SetAlignment(
  const Value: TAlignment);
begin
  if FAlignment <> Value then
  begin
    FAlignment := Value;
    DrawFormatChanged;
  end;
end;

function TGridDataGroupFooterColumnItemEh.GetCollection: TGridDataGroupFooterColumnItemsEh;
begin
  Result := TGridDataGroupFooterColumnItemsEh(inherited Collection);
end;

function TGridDataGroupFooterColumnItemEh.GetColor: TColor;
begin
  if ParentColor
    then Result := DefaultColor
    else Result := FColor;
end;

function TGridDataGroupFooterColumnItemEh.GetFont: TFont;
begin
  {$WARNINGS OFF}
  if ParentFont and (FFont.Handle <> DefaultFont.Handle) then
  {$WARNINGS ON}
    RefreshDefaultFont;
  Result := FFont;
end;

function TGridDataGroupFooterColumnItemEh.IsColorStored: Boolean;
begin
  Result := not ParentColor;
end;

function TGridDataGroupFooterColumnItemEh.IsFontStored: Boolean;
begin
  Result := not ParentFont;
end;

procedure TGridDataGroupFooterColumnItemEh.RefreshDefaultFont;
var
  Save: TNotifyEvent;
begin
  if not ParentFont then Exit;
  Save := FFont.OnChange;
  FFont.OnChange := nil;
  try
    FFont.Assign(DefaultFont);
  finally
    FFont.OnChange := Save;
  end;
end;

procedure TGridDataGroupFooterColumnItemEh.SetCollection(
  const Value: TGridDataGroupFooterColumnItemsEh);
begin
  inherited Collection := Value;
end;

procedure TGridDataGroupFooterColumnItemEh.SetColor(const Value: TColor);
begin
  if not ParentColor and (Value = FColor) then Exit;
  FColor := Value;
  ParentColor := False;
  DrawFormatChanged;
end;

procedure TGridDataGroupFooterColumnItemEh.SetDisplayFormat(const Value: String);
begin
  if FDisplayFormat <> Value then
  begin
    FDisplayFormat := Value;
    DrawFormatChanged;
  end;
end;

procedure TGridDataGroupFooterColumnItemEh.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
end;

procedure TGridDataGroupFooterColumnItemEh.SetParentColor(const Value: Boolean);
begin
  if FParentColor <> Value then
  begin
    FParentColor := Value;
    DrawFormatChanged;
  end;
end;

procedure TGridDataGroupFooterColumnItemEh.SetParentFont(const Value: Boolean);
begin
  if FParentFont <> Value then
  begin
    FParentFont := Value;
    RefreshDefaultFont;
    DrawFormatChanged;
  end;
end;

procedure TGridDataGroupFooterColumnItemEh.SetValueType(
  const Value: TGroupFooterValueTypeEh);
begin
  if FValueType <> Value then
  begin
    FValueType := Value;
    Collection.FooterValuesChanged;
  end;
end;

procedure TGridDataGroupFooterColumnItemEh.SetShowFunctionName(const Value: Boolean);
begin
  if ShowFunctionNameStored and (Value = FShowFunctionName) then Exit;
  ShowFunctionNameStored := True;
  FShowFunctionName := Value;
  DrawFormatChanged;
end;

function TGridDataGroupFooterColumnItemEh.DefaultShowFunctionName: Boolean;
begin
  Result := Collection.Footer.ShowFunctionName;
end;

procedure TGridDataGroupFooterColumnItemEh.SetShowFunctionNameStored(
  const Value: Boolean);
begin
  if FShowFunctionNameStored <> Value then
  begin
    FShowFunctionNameStored := Value;
    FShowFunctionName := DefaultShowFunctionName;
    Collection.FooterValuesChanged;
  end;
end;

function TGridDataGroupFooterColumnItemEh.IsShowFunctionNameStored: Boolean;
begin
  Result := FShowFunctionNameStored;
end;

function TGridDataGroupFooterColumnItemEh.GetShowFunctionName: Boolean;
begin
  if ShowFunctionNameStored
    then Result := FShowFunctionName
    else Result := DefaultShowFunctionName;
end;

function TGridDataGroupFooterColumnItemEh.GetDisplayName: string;
var
  Footer: TGridDataGroupFooterEh;
begin
  if (Collection = nil) or (Collection.GetOwner = nil) then
  begin
    Result := inherited GetDisplayName;
    Exit;
  end;

  Footer := TGridDataGroupFooterEh(Collection.GetOwner);
  Result := Footer.GetDisplayName;

  if (Column <> nil) and (TColumnEh(Column).FieldName <> '') then
    Result := Result + '[' + TColumnEh(Column).FieldName + ']';
end;

function TGridDataGroupFooterColumnItemEh.GetRunTimeCustomizable: Boolean;
begin
  if IsRunTimeCustomizableStored then
    Result := FRunTimeCustomizable
  else
    Result := DefaultRunTimeCustomizable;
end;

function TGridDataGroupFooterColumnItemEh.IsRunTimeCustomizableStored: Boolean;
begin
  Result := FRunTimeCustomizableStored;
end;

procedure TGridDataGroupFooterColumnItemEh.SetRunTimeCustomizable(const Value: Boolean);
begin
  if RunTimeCustomizableStored and (Value = FRunTimeCustomizable) then Exit;
  RunTimeCustomizableStored := True;
  FRunTimeCustomizable := Value;
end;

procedure TGridDataGroupFooterColumnItemEh.SetRunTimeCustomizableStored(const Value: Boolean);
begin
  if RunTimeCustomizableStored <> Value then
  begin
    FRunTimeCustomizableStored := Value;
    FRunTimeCustomizable := DefaultRunTimeCustomizable;
  end;
end;

function TGridDataGroupFooterColumnItemEh.DefaultRunTimeCustomizable: Boolean;
begin
  Result := Collection.Footer.RunTimeCustomizable;
end;

{ TGridDataGroupFooterColumnItemsEh }

constructor TGridDataGroupFooterColumnItemsEh.Create(
  Owner: TGridDataGroupFooterEh;
  ItemClass: TGridDataGroupFooterColumnItemEhClass);
begin
  inherited Create(ItemClass);
  FOwner := Owner;
end;

procedure TGridDataGroupFooterColumnItemsEh.Assign(Source: TPersistent);
var
  I: Integer;
  SrcColn: TCollection;
begin
  if Source is TCollection then
  begin
    SrcColn := TCollection(Source);
    BeginUpdate;
    try
      for I := 0 to SrcColn.Count - 1 do
        Items[I].Assign(SrcColn.Items[I]);
    finally
      EndUpdate;
    end;
  end else
    inherited Assign(Source);
end;

function TGridDataGroupFooterColumnItemsEh.Footer: TGridDataGroupFooterEh;
begin
  Result := TGridDataGroupFooterEh(GetOwner);
end;

procedure TGridDataGroupFooterColumnItemsEh.FooterValuesChanged;
begin
  Footer.FooterValuesChanged;
end;

function TGridDataGroupFooterColumnItemsEh.Add: TGridDataGroupFooterColumnItemEh;
begin
  Result := TGridDataGroupFooterColumnItemEh(inherited Add);
end;

function TGridDataGroupFooterColumnItemsEh.GetItem(
  Index: Integer): TGridDataGroupFooterColumnItemEh;
begin
  Result := TGridDataGroupFooterColumnItemEh(inherited Items[Index]);
end;

function TGridDataGroupFooterColumnItemsEh.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

function TGridDataGroupFooterColumnItemsEh.ItemIndexByColumn(
  Column: TCollectionItem): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to Count-1 do
    if Items[i].Column = Column then
    begin
      Result := i;
      Exit;
    end;
end;

procedure TGridDataGroupFooterColumnItemsEh.SetItem(Index: Integer;
  const Value: TGridDataGroupFooterColumnItemEh);
begin
  Items[Index].Assign(Value);
end;

procedure TGridDataGroupFooterColumnItemsEh.Update(Item: TCollectionItem);
begin
  inherited Update(Item);
end;

procedure TGridDataGroupFooterColumnItemsEh.RefreshDefaultFont;
var
  i: Integer;
begin
  for i := 0 to Count-1 do
    Items[i].RefreshDefaultFont;
end;

procedure TGridDataGroupFooterColumnItemsEh.ResetItems;
var
  Grid: TCustomDBGridEh;
  i: Integer;
  Item: TGridDataGroupFooterColumnItemEh;
begin
  BeginUpdate;
  try
    Clear;
    Grid := TCustomDBGridEh(Footer.FootersCollection.GridComponent);
    for i := 0 to Grid.Columns.Count-1 do
    begin
      Item := Add;
      Item.FColumn := Grid.Columns[i];
    end;
  finally
    EndUpdate;
  end;
end;

{ TGridDataGroupFootersDefValuesEh }

constructor TGridDataGroupFootersDefValuesEh.Create(ADataGroups: TGridDataGroupsEh);
begin
  inherited Create;
  FDataGroups := ADataGroups;
end;

procedure TGridDataGroupFootersDefValuesEh.Assign(Source: TPersistent);
begin
  if Source is TGridDataGroupFootersDefValuesEh then
  begin
    RunTimeCustomizable := TGridDataGroupFootersDefValuesEh(Source).RunTimeCustomizable;
    ShowFunctionName := TGridDataGroupFootersDefValuesEh(Source).ShowFunctionName;
  end else
    inherited Assign(Source);
end;

procedure TGridDataGroupFootersDefValuesEh.SetRunTimeCustomizable(const Value: Boolean);
begin
  if FRunTimeCustomizable <> Value then
  begin
    FRunTimeCustomizable := Value;
  end;
end;

procedure TGridDataGroupFootersDefValuesEh.SetShowFunctionName(const Value: Boolean);
begin
  if FShowFunctionName <> Value then
  begin
    FShowFunctionName := Value;
    FDataGroups.FooterValuesChanged;
  end;
end;

{ TGridDataGroupRowDefValuesEh }

constructor TGridDataGroupRowDefValuesEh.Create(ADataGroups: TGridDataGroupsEh);
begin
  inherited Create;
  FDataGroups := ADataGroups;
  FBottomLine := TGridGroupLinePenEh.Create(Self);
end;

destructor TGridDataGroupRowDefValuesEh.Destroy;
begin
  FreeAndNil(FBottomLine);
  inherited Destroy;
end;

procedure TGridDataGroupRowDefValuesEh.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
end;

procedure TGridDataGroupRowDefValuesEh.SetFooterInGroupRow(
  const Value: Boolean);
begin
  if FFooterInGroupRow <> Value then
  begin
    FFooterInGroupRow := Value;
    FDataGroups.FooterStructureChanged;
  end;
end;

procedure TGridDataGroupRowDefValuesEh.SetBottomLine(const Value: TGridGroupLinePenEh);
begin
  FBottomLine.Assign(Value);
end;

procedure TGridDataGroupRowDefValuesEh.SetRowHeight(const Value: Integer);
begin
  if FRowHeight <> Value then
  begin
    FRowHeight := Value;
    FDataGroups.FooterStructureChanged;
  end;
end;

procedure TGridDataGroupRowDefValuesEh.SetRowLines(const Value: Integer);
begin
  if FRowLines <> Value then
  begin
    FRowLines := Value;
    FDataGroups.FooterStructureChanged;
  end;
end;

{ TGridGroupLinePenEh }

constructor TGridGroupLinePenEh.Create(ARowDefValues: TGridDataGroupRowDefValuesEh);
begin
  inherited Create;
  FOwner := ARowDefValues;
  FColor := clDefault;
  FWidth := 1;
end;

destructor TGridGroupLinePenEh.Destroy;
begin
  inherited Destroy;
end;

function TGridGroupLinePenEh.GetColor: TColor;
begin
  Result := FColor;
end;

procedure TGridGroupLinePenEh.SetColor(const Value: TColor);
begin
  if Color <> Value then
  begin
    FColor := Value;
    TGridDataGroupRowDefValuesEh(FOwner).FDataGroups.DrawFormatChanged;
  end;
end;

function TGridGroupLinePenEh.GetWidth: Integer;
begin
  Result := FWidth;
end;

procedure TGridGroupLinePenEh.SetWidth(const Value: Integer);
begin
  if Width <> Value then
  begin
    FWidth := Value;
    TGridDataGroupRowDefValuesEh(FOwner).FDataGroups.DrawFormatChanged;
  end;
end;

end.
