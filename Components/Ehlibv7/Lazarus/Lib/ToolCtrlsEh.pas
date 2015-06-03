{*******************************************************}
{                                                       }
{                      EhLib v7.0                       }
{                     Tool controls                     }
{                    (Build 7.0.41)                     }
{                                                       }
{      Copyright (c) 2001-2014 by Dmitry V. Bolshakov   }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit ToolCtrlsEh;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Contnrs, ActnList,
{$IFDEF EH_LIB_6} Variants, Types, {$ENDIF}
{$IFDEF EH_LIB_17} System.Generics.Collections, System.UITypes, {$ENDIF}
{$IFDEF CIL}
  EhLibVCLNET,
{$ELSE}
  {$IFDEF FPC}
   EhLibLCL, LMessages, LCLType, Win32Extra, Calendar,
  {$ELSE}
  EhLibVCL, Mask, ComCtrls,
  {$ENDIF}
{$ENDIF}
  StdCtrls,
  Db, DBCtrls, Buttons, ExtCtrls, Menus, CommCtrl,
  Imglist, StrUtils, DynVarsEh;

const
  CM_IGNOREEDITDOWN = WM_USER + 102;
  InitRepeatPause = 400;  { pause before repeat timer (ms) }
  RepeatPause     = 100;  { pause before hint window displays (ms)}

var
  EhLibRegKey: String = 'EhLib';

type

  TLocateTextOptionEh = (ltoCaseInsensitiveEh, ltoAllFieldsEh, ltoMatchFormatEh,
    ltoIgnoteCurrentPosEh, ltoStopOnEscape, ltoInsideSelection, ltoRestartAfterLastHit);
  TLocateTextOptionsEh = set of TLocateTextOptionEh;
  TLocateTextDirectionEh = (ltdUpEh, ltdDownEh, ltdAllEh);
  TLocateTextMatchingEh = (ltmAnyPartEh, ltmWholeEh, ltmFromBegingEh);
  TLocateTextTreeFindRangeEh = (lttInAllNodesEh, lttInExpandedNodesEh,
    lttInCurrentLevelEh, lttInCurrentNodeEh);
  TSortOrderEh =  (soAscEh, soDescEh);

  TImagePlacementEh = (ipTopLeftEh, ipTopCenterEh, ipTopRightEh,
                       ipCenterLeftEh, ipCenterCenterEh, ipCenterRightEh,
                       ipBottomLeftEh, ipBottomCenterEh, ipBottomRightEh,
                       ipFillEh, ipReduceFitEh, ipFitEh, ipStretchEh, ipTileEh);

  TListNotificationEh = (ListItemAddedEh, ListItemDeletedEh, ListItemChangedEh, ListChangedEh);

  TEditButtonImagesEh = class;
  TEditButtonEh = class;
  TEditButtonControlEh = class;

  IMemTableDataFieldValueListEh = interface
    ['{28F8194C-5FF3-42C4-87A6-8B3E06210FA6}']
    function GetValues: TStrings;
    procedure SetFilter(Filter: String);
  end;

  IComboEditEh = interface
    ['{B64255B5-386A-4524-8BC7-7F49DDB410F4}']
    procedure CloseUp(Accept: Boolean);
  end;

  ICalcFieldEh = interface
    ['{E564FFA8-A1D5-4A02-B64F-9E47F5C8F2DF}']
    function CanModifyWithoutEditMode: Boolean;
  end;

  ISideOwnedComponentEh = interface
    ['{C08052DC-C187-4BD3-B818-F26E7D245600}']
    function IsSideParentedBy(AComponent: TComponent): Boolean;
    procedure SetSideParent(AComponent: TComponent);
  end;

  ISideOwnerEh = interface
    ['{36EE47C7-5E1D-4FA6-91FF-1489151FB90B}']
    function IsSideParentableForProperty(PropertyName: String): Boolean;
    function CanSideOwnClass(ComponentClass: TComponentClass): Boolean;
  end;

  ISimpleChangeNotificationEh = interface
    ['{0880C65D-FAF5-4AEF-AE6B-4C62141DC320}']
    procedure Change(Sender: TObject);
  end;

  TDropDownFormSysParams = class(TPersistent)
  private
    FFreeFormOnClose: Boolean;
  public
    property FreeFormOnClose: Boolean read FFreeFormOnClose write FFreeFormOnClose;
  end;

  TEditControlDropDownFormSysParams = class(TDropDownFormSysParams)
  public
    FEditControl: TControl;
    FEditButton: TEditButtonEh;
    FEditButtonObj: TObject;
  end;

  TDropDownFormCallbackProcEh = procedure(DropDownForm: TCustomForm;
    Accept: Boolean; DynParams: TDynVarsEh; SysParams: TDropDownFormSysParams) of object;

  TSetVarValueProcEh = procedure(const VarValue: Variant) of object;
  TGetVarValueProcEh = procedure(var VarValue: Variant) of object;
  TCheckDataIsReadOnlyEventEh = procedure(var ReadOnly: Boolean) of object;

  TGetDropDownFormEventEh = procedure(var DropDownForm: TCustomForm;
    var FreeFormOnClose: Boolean) of object;

  IDropDownFormEh = interface
    ['{A665F4AE-003C-465E-95E9-B1061E9EAEF4}']
    function Execute(RelativePosControl: TControl; DownStateControl: TControl; Align: TDropDownAlign; DynParams: TDynVarsEh): Boolean;
    function GetReadOnly: Boolean;
    procedure ExecuteNomodal(RelativePosResc: TRect; DownStateControl: TControl; Align: TDropDownAlign; DynParams: TDynVarsEh; SysParams: TDropDownFormSysParams; CallbackProc: TDropDownFormCallbackProcEh);
    procedure Close;
    procedure SetReadOnly(const Value: Boolean);

    property ReadOnly: Boolean read GetReadOnly write SetReadOnly;
//    procedure AssignGlobalDropDownForm(Sender: TCustomForm; var GlobalDropDownForm: TCustomForm);
  end;

  TDropDownPassParamsEh = (pspByFieldNamesEh, pspFieldValueEh, pspRecordValuesEh,
    pspCustomValuesEh);

  TFieldsArrEh = array of TField;
  TVariantArrayEh = array of Variant;

  TAggrFunctionEh = (agfSumEh, agfCountEh, agfAvg, agfMin, agfMax);
  TAggrFunctionsEh = set of TAggrFunctionEh;
  TAggrResultArr = array [TAggrFunctionEh] of Variant;

  TRectangleEdgeEh = (reLeftEh, reTopEh, reRightEh, reBottomEh);
  TRectangleEdgesEh = set of TRectangleEdgeEh;

{ Standard events }

  TButtonClickEventEh = procedure(Sender: TObject; var Handled: Boolean) of object;
  TButtonDownEventEh = procedure(Sender: TObject; TopButton: Boolean;
    var AutoRepeat: Boolean; var Handled: Boolean) of object;
  TCloseUpEventEh = procedure(Sender: TObject; Accept: Boolean) of object;
  TAcceptEventEh = procedure(Sender: TObject; var Accept: Boolean) of object;
  TNotInListEventEh = procedure(Sender: TObject; NewText: String;
    var RecheckInList: Boolean) of object;
  TUpdateDataEventEh = procedure(Sender: TObject; var Handled: Boolean) of object;
  TGetFieldDataEventEh = procedure(Sender: TObject; var Value: Variant; var Handled: Boolean) of object;

{ TOrderByItemEh }

  TOrderByItemEh = class(TObject)
  public
    FieldIndex: Integer;
    MTFieldIndex: Integer;
    Desc: Boolean;
    CaseIns: Boolean;
    ExtObjIndex: Integer;
  end;

{ TOrderByList }

  TOrderByList = class(TObjectList)
  protected
    function GetItem(Index: Integer): TOrderByItemEh;
    procedure SetItem(Index: Integer; const Value: TOrderByItemEh);
    function FindFieldIndex(const FieldName: String): Integer; virtual;
  public
    function GetToken(const Exp: String; var FromIndex: Integer): String;
    procedure ParseOrderByStr(const OrderByStr: String);
    property Items[Index: Integer]: TOrderByItemEh read GetItem write SetItem; default;
  end;

{ TBMListEh }

  TBMListEh = class;

  TBMListSortCompare = function(List: TBMListEh; DataSet: TDataSet; Index1, Index2: Integer): Integer;

  TBMListEh = class
  private
    FCache: TUniBookmarkEh;
    FCacheFind: Boolean;
    FCacheIndex: Integer;
    FLinkActive: Boolean;
    function GetCount: Integer;
    function GetCurrentRowSelected: Boolean;
    function GetItem(Index: Integer): TUniBookmarkEh;
    procedure QuickSort(DataSet: TDataSet; L, R: Integer; SCompare: TBMListSortCompare);
    procedure SetItem(Index: Integer; Item: TUniBookmarkEh);
  protected
{$IFDEF EH_LIB_12}
    FList: array of TBookmark;
{$ELSE}
    FList: TStringList;
{$ENDIF}
    function Compare(const Item1, Item2: TUniBookmarkEh): Integer;
    function CurrentRow: TUniBookmarkEh;
    function GetDataSet: TDataSet; virtual;
    procedure Invalidate; virtual;
    procedure LinkActive(Value: Boolean);
    procedure RaiseBMListError(const S: string); virtual;
    procedure SetCurrentRowSelected(Value: Boolean); virtual;
    procedure ListChanged(Sender: TObject); virtual;
    procedure UpdateState; virtual;
  public
    constructor Create;
    destructor Destroy; override;
    function Find(const Item: TUniBookmarkEh; var Index: Integer): Boolean;
    function IndexOf(const Item: TUniBookmarkEh): Integer;
    function Refresh: Boolean;
    procedure AppendItem(Item: TUniBookmarkEh);
    procedure Clear; virtual;
    procedure CustomSort(DataSet: TDataSet; Compare: TBMListSortCompare); virtual;
    procedure Delete;
    procedure DeleteItem(Index: Integer);
    procedure InsertItem(Index: Integer; Item: TUniBookmarkEh);
    procedure SelectAll;
    property Count: Integer read GetCount;
    property CurrentRowSelected: Boolean read GetCurrentRowSelected write SetCurrentRowSelected;
    property DataSet: TDataSet read GetDataSet;
    property Items[Index: Integer]: TUniBookmarkEh read GetItem write SetItem; default;
  end;

  IMemTableEh = interface
    ['{A8C3C87A-E556-4BDB-B8A7-5B33497D1624}']
    function FetchRecords(Count: Integer): Integer;
    function GetInstantReadCurRowNum: Integer;
    function GetTreeNodeExpanded(RowNum: Integer): Boolean; overload;
    function GetTreeNodeExpanded: Boolean; overload;
    function GetTreeNodeHasChields: Boolean;
    function GetTreeNodeLevel: Integer;
    function GetPrevVisibleTreeNodeLevel: Integer;
    function GetNextVisibleTreeNodeLevel: Integer;
    function GetRecObject: TObject;
    function InstantReadIndexOfBookmark(Bookmark: TUniBookmarkEh): Integer;
    function InstantReadRowCount: Integer;
    function InstantReadViewRow: Integer;
    function MemTableIsTreeList: Boolean;
    function ApplyExtraFilter(FilterStr: String; FilterProc: TFilterRecordEvent): TObject;
    function ResetExtraFilter(FilterObject: TObject; FilterStr: String; FilterProc: TFilterRecordEvent): Boolean;
    function RevokeExtraFilter(FilterObject: TObject): Boolean;
    function ParentHasNextSibling(ParenLevel: Integer): Boolean;
    function SetToRec(Rec: TObject): Boolean;
    function SetTreeNodeExpanded(RowNum: Integer; Value: Boolean): Integer;
    function GetFieldValueList(FieldName: String): IMemTableDataFieldValueListEh;
    function MoveRecords(BookmarkList: TBMListEh; ToRecNo: Longint; TreeLevel: Integer; CheckOnly: Boolean): Boolean;
    function GetLikeWildcardForOneCharacter: String;
    function GetLikeWildcardForSeveralCharacters: String;
    procedure GetAggregatedValuesForRange(FromBM, ToTB: TUniBookmarkEh; FieldName: String; var FieldNaeResultArr: TAggrResultArr; AggrFuncs: TAggrFunctionsEh);
    procedure MTDisableControls;
    procedure MTEnableControls(ForceUpdateState: Boolean);
    procedure InstantReadEnter(RowNum: Integer);
    procedure InstantReadLeave;
    procedure RegisterEventReceiver(AComponent: TComponent);
    procedure UnregisterEventReceiver(AComponent: TComponent);
    property InstantReadCurRowNum: Integer read GetInstantReadCurRowNum;
//    property TreeNodeCollapsed: Boolean read GetTreeNodeCollapsed write SetTreeNodeCollapsed;
  end;

  TMTViewEventTypeEh = (mtRowInsertedEh, mtRowChangedEh, mtRowDeletedEh,
    mtRowMovedEh, mtViewDataChangedEh);

  IMTEventReceiverEh = interface
    ['{60C6C1A2-A817-4043-885A-BDDC750587BD}']
    procedure MTViewDataEvent(RowNum: Integer;
      Event: TMTViewEventTypeEh; OldRowNum: Integer);
  end;

{ TDropDownFormCallParamsEh }

  TEditControlShowDropDownFormEventEh = procedure(EditControl: TControl;
    Button: TEditButtonEh; var DropDownForm: TCustomForm;
    DynParams: TDynVarsEh) of object;

  TEditControlCloseDropDownFormEventEh = procedure(EditControl: TControl;
    Button: TEditButtonEh; Accept: Boolean; DropDownForm: TCustomForm;
    DynParams: TDynVarsEh) of object;

  TDropDownFormCallParamsEh = class(TPersistent)
  private
    FDropDownFormClassName: String;
    FAssignBackFieldNames: String;
    FAlign: TDropDownAlign;
    FPassParams: TDropDownPassParamsEh;
    FPassFieldNames: String;
    FDropDownForm: TCustomForm;
    FFormHeight: Integer;
    FSaveFormSize: Boolean;
    FFormWidth: Integer;
    FOldFormWidth: Integer;
    FOldFormHeight: Integer;
    FOnChanged: TNotifyEvent;
    FOnCheckDataIsReadOnly: TCheckDataIsReadOnlyEventEh;
    procedure SetDropDownForm(const Value: TCustomForm);
    procedure SetDropDownFormClassName(const Value: String);

  protected
    FEditButton: TEditButtonEh;
    FEditButtonControl: TEditButtonControlEh;
    FEditControl: TWinControl;
    FOnOpenDropDownFormProc: TEditControlShowDropDownFormEventEh;
//    FOnDropDownFormCallback: TDropDownFormCallbackProcEh;
    FOnCloseDropDownFormProc: TEditControlCloseDropDownFormEventEh;
    FDataLink: TDataLink;
    FField: TField;
    FOnSetVarValueProc: TSetVarValueProcEh;
    FOnGetVarValueProc: TGetVarValueProcEh;
    FOnGetActualDropDownFormProc: TGetDropDownFormEventEh;

    function GetEditControl: TWinControl; virtual;
    function GetEditButton: TEditButtonEh; virtual;
    function GetEditButtonControl: TEditButtonControlEh; virtual;
    function GetActualDropDownForm(var FreeFormOnClose: Boolean): TCustomForm; virtual;
    function GetOnOpenDropDownFormProc: TEditControlShowDropDownFormEventEh; virtual;
    function GetOnCloseDropDownFormProc: TEditControlCloseDropDownFormEventEh; virtual;
    function GetOnSetVarValueProc: TSetVarValueProcEh; virtual;
    function GetOnGetVarValueProc: TGetVarValueProcEh; virtual;

//    function GetDropDownFormCallbackProc: TDropDownFormCallbackProcEh; virtual;
    function GetDataLink: TDataLink; virtual;
    function GetField: TField; virtual;
    function GetControlValue: Variant; virtual;
    function GetControlReadOnly: Boolean; virtual;

    procedure FillPassParams(DynParams: TDynVarsEh); virtual;
    procedure GetDataFromPassParams(DynParams: TDynVarsEh); virtual;
    procedure Changed;
    procedure CheckShowDropDownForm(var Handled: Boolean); virtual;
    procedure DropDownFormCallbackProc(DropDownForm: TCustomForm; Accept: Boolean; DynParams: TDynVarsEh; SysParams: TDropDownFormSysParams); virtual;
    procedure SetControlValue(const Value: Variant); virtual;

    property OnOpenDropDownFormProc: TEditControlShowDropDownFormEventEh read GetOnOpenDropDownFormProc;
    property OnCloseDropDownFormProc: TEditControlCloseDropDownFormEventEh read GetOnCloseDropDownFormProc;
    property OnGetVarValue: TGetVarValueProcEh read GetOnGetVarValueProc;
    property OnSetVarValue: TSetVarValueProcEh read GetOnSetVarValueProc;
//    property OnGetControlValue
//    property OnDropDownFormCallback: TDropDownFormCallbackProcEh read GetDropDownFormCallbackProc;

  public
    constructor Create;
    property OldFormWidth: Integer read FOldFormWidth write FOldFormWidth;
    property OldFormHeight: Integer read FOldFormHeight write FOldFormHeight;
    property OnChanged: TNotifyEvent read FOnChanged write FOnChanged;
    property OnCheckDataIsReadOnly: TCheckDataIsReadOnlyEventEh read FOnCheckDataIsReadOnly write FOnCheckDataIsReadOnly;
  published
    property DropDownForm: TCustomForm read FDropDownForm write SetDropDownForm;
    property DropDownFormClassName: String read FDropDownFormClassName write SetDropDownFormClassName;
    property Align: TDropDownAlign read FAlign write FAlign default daCenter;
    property PassParams: TDropDownPassParamsEh read FPassParams write FPassParams default pspFieldValueEh;
    property PassFieldNames: String read FPassFieldNames write FPassFieldNames;
    property AssignBackFieldNames: String read FAssignBackFieldNames write FAssignBackFieldNames;
    property FormWidth: Integer read FFormWidth write FFormWidth default -1;
    property FormHeight: Integer read FFormHeight write FFormHeight default -1;
    property SaveFormSize: Boolean read FSaveFormSize write FSaveFormSize default True;
  end;

{ TEditButtonControlEh }

  TEditButtonStyleEh = (ebsDropDownEh, ebsEllipsisEh, ebsGlyphEh, ebsUpDownEh,
    ebsPlusEh, ebsMinusEh, ebsAltDropDownEh, ebsAltUpDownEh);

  TEditButtonStateEh = (ebstNormalEh, ebstControlHotEh, ebstHotEh,
    ebstPressedEh, ebstDisabledEh);

  TEditButtonControlEh = class(TSpeedButton)
  private
    FActive: Boolean;
    FAlwaysDown: Boolean;
    FButtonNum: Integer;
    FNoDoClick: Boolean;
    FOnDown: TButtonDownEventEh;
    FStyle: TEditButtonStyleEh;
    FTimer: TTimer;
    FOnPaint: TNotifyEvent;
    function GetTimer: TTimer;
    procedure ResetTimer(Interval: Cardinal);
    procedure SetActive(const Value: Boolean);
    procedure SetAlwaysDown(const Value: Boolean);
    procedure SetStyle(const Value: TEditButtonStyleEh);
    procedure TimerEvent(Sender: TObject);
    procedure UpdateDownButtonNum(X, Y: Integer);
  protected
    procedure DrawButtonText(Canvas: TCanvas; const Caption: string;
      TextBounds: TRect; State: TButtonState; BiDiFlags: Longint);
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Paint; override;
    property Timer: TTimer read GetTimer;
  public
    FEditButtonImages: TEditButtonImagesEh;
    function GetState: TEditButtonStateEh; virtual;
    procedure Click; override;
    procedure DrawImages(ARect: TRect); virtual;
    procedure DefaultPaint;
    procedure EditButtonDown(TopButton: Boolean; var AutoRepeat: Boolean);
    procedure SetState(NewState: TButtonState; IsActive: Boolean; ButtonNum: Integer);
    procedure SetWidthNoNotify(AWidth: Integer);
    property Canvas;
    property State: TButtonState read FState;
    property MouseInControl;
    property Active: Boolean read FActive write SetActive;
    property AlwaysDown: Boolean read FAlwaysDown write SetAlwaysDown;
    property Style: TEditButtonStyleEh read FStyle write SetStyle default ebsDropDownEh;
    property OnDown: TButtonDownEventEh read FOnDown write FOnDown;
    property OnPaint: TNotifyEvent read FOnPaint write FOnPaint;
  end;

  TCreateEditButtonControlEvent = procedure(var EditButtonControl: TEditButtonControlEh) of object;

{ TSpeedButtonEh }

  TSpeedButtonEh = class(TEditButtonControlEh)
  published
    property Active;
    property Style;
  end;

  TEditButtonControlLineRec = record
    ButtonLine: TShape;
    EditButtonControl: TEditButtonControlEh;
    EditButton: TEditButtonEh;
  end;

  TEditButtonControlList = array of TEditButtonControlLineRec;

{ TEditButtonActionLinkEh }

  TEditButtonActionLinkEh = class(TActionLink)
  protected
    FClient: TEditButtonEh;
    procedure AssignClient(AClient: TObject); override;
    procedure SetEnabled(Value: Boolean); override;
    procedure SetHint(const Value: string); override;
    procedure SetShortCut(Value: TShortCut); override;
    procedure SetVisible(Value: Boolean); override;
    {$IFDEF FPC}
  public
    {$ENDIF}
    function IsEnabledLinked: Boolean; override;
    function IsHintLinked: Boolean; override;
    function IsShortCutLinked: Boolean; override;
    function IsVisibleLinked: Boolean; override;
  end;

  TEditButtonActionLinkEhClass = class of TEditButtonActionLinkEh;

{ TEditButtonImagesEh }

  TEditButtonImagesEh = class(TPersistent)
  private
    FNormalIndex: Integer;
    FHotImages: TCustomImageList;
    FDisabledIndex: Integer;
    FPressedImages: TCustomImageList;
    FHotIndex: Integer;
    FNormalImages: TCustomImageList;
    FPressedIndex: Integer;
    FDisabledImages: TCustomImageList;
    procedure SetDisabledImages(const Value: TCustomImageList);
    procedure SetDisabledIndex(const Value: Integer);
    procedure SetHotImages(const Value: TCustomImageList);
    procedure SetHotIndex(const Value: Integer);
    procedure SetNormalImages(const Value: TCustomImageList);
    procedure SetNormalIndex(const Value: Integer);
    procedure SetPressedImages(const Value: TCustomImageList);
    procedure SetPressedIndex(const Value: Integer);
  protected
    FOwner: TEditButtonEh;
    function GetOwner: TPersistent; override;
  public
    constructor Create(Owner: TEditButtonEh);
    destructor Destroy; override;
    function GetStateImages(EditButtonState: TEditButtonStateEh): TCustomImageList;
    function GetStateIndex(EditButtonState: TEditButtonStateEh): Integer;
    procedure Assign(Source: TPersistent); override;
  published
    property NormalImages: TCustomImageList read FNormalImages write SetNormalImages;
    property HotImages: TCustomImageList read FHotImages write SetHotImages;
    property PressedImages: TCustomImageList read FPressedImages write SetPressedImages;
    property DisabledImages: TCustomImageList read FDisabledImages write SetDisabledImages;

    property NormalIndex: Integer read FNormalIndex write SetNormalIndex default 0;
    property HotIndex: Integer read FHotIndex write SetHotIndex default 0;
    property PressedIndex: Integer read FPressedIndex write SetPressedIndex default 0;
    property DisabledIndex: Integer read FDisabledIndex write SetDisabledIndex default 0;
  end;

  TRefComponentNotifyEventEh = procedure(Sender: TObject; RefComponent: TComponent) of object;

{ TEditButtonEh }

  TEditButtonEh = class(TCollectionItem)
  private
    FActionLink: TEditButtonActionLinkEh;
    FDropDownFormParams: TDropDownFormCallParamsEh;
    FDropdownMenu: TPopupMenu;
    FEditControl: TWinControl;
    FEnabled: Boolean;
    FGlyph: TBitmap;
    FHint: String;
    FImages: TEditButtonImagesEh;
    FNumGlyphs: Integer;
    FOnButtonClick: TButtonClickEventEh;
    FOnButtonDown: TButtonDownEventEh;
    FOnChanged: TNotifyEvent;
    FOnRefComponentChanged: TRefComponentNotifyEventEh;
    FShortCut: TShortCut;
    FStyle: TEditButtonStyleEh;
    FVisible: Boolean;
    FWidth: Integer;
    FDefaultAction: Boolean;
    FDefaultActionStored: Boolean;
    function GetAction: TBasicAction;
    function GetGlyph: TBitmap;
    function IsEnabledStored: Boolean;
    function IsHintStored: Boolean;
    function IsShortCutStored: Boolean;
    function IsVisibleStored: Boolean;
    procedure DoActionChange(Sender: TObject);
    procedure SetAction(const Value: TBasicAction);
    procedure SetDropDownFormParams(const Value: TDropDownFormCallParamsEh);
    procedure SetEnabled(const Value: Boolean);
    procedure SetGlyph(const Value: TBitmap);
    procedure SetHint(const Value: String);
    procedure SetImages(const Value: TEditButtonImagesEh);
    procedure SetNumGlyphs(Value: Integer);
    procedure SetStyle(const Value: TEditButtonStyleEh);
    procedure SetWidth(const Value: Integer);
    procedure SetDefaultAction(const Value: Boolean);
    function IsDefaultActionStored: Boolean;
    function GetDefaultAction: Boolean;
    procedure SetOnButtonClick(const Value: TButtonClickEventEh);
    procedure SetOnButtonDown(const Value: TButtonDownEventEh);
    procedure SetDropdownMenu(const Value: TPopupMenu);
  protected
    FParentDefinedDefaultAction: Boolean;
    function CreateEditButtonControl: TEditButtonControlEh; virtual;
    function CreateDropDownFormParams: TDropDownFormCallParamsEh;
    function GetVisible: Boolean; virtual;

    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); dynamic;
    procedure Changed; overload;
    procedure RefComponentChanged(RefComponent: TComponent);
    procedure SetVisible(const Value: Boolean); virtual;

    property ActionLink: TEditButtonActionLinkEh read FActionLink write FActionLink;
  public
    constructor Create(Collection: TCollection); overload; override;
    constructor Create(EditControl: TWinControl); reintroduce; overload;
    destructor Destroy; override;

    function GetActionLinkClass: TEditButtonActionLinkEhClass; virtual;

    procedure Assign(Source: TPersistent); override;
    procedure Click(Sender: TObject; var Handled: Boolean); virtual;
    procedure InitiateAction; virtual;

    property OnChanged: TNotifyEvent read FOnChanged write FOnChanged;
    property OnRefComponentChanged: TRefComponentNotifyEventEh read FOnRefComponentChanged write FOnRefComponentChanged;
  published
    property Action: TBasicAction read GetAction write SetAction;
    property DefaultAction: Boolean read GetDefaultAction write SetDefaultAction stored IsDefaultActionStored;
    property DropdownMenu: TPopupMenu read FDropdownMenu write SetDropdownMenu;
    property DropDownFormParams: TDropDownFormCallParamsEh read FDropDownFormParams write SetDropDownFormParams;
    property Enabled: Boolean read FEnabled write SetEnabled stored IsEnabledStored default True;
    property Glyph: TBitmap read GetGlyph write SetGlyph;
    property Hint: String read FHint write SetHint stored IsHintStored;
    property Images: TEditButtonImagesEh read FImages write SetImages;
    property NumGlyphs: Integer read FNumGlyphs write SetNumGlyphs default 1;
    property ShortCut: TShortCut read FShortCut write FShortCut stored IsShortCutStored default scNone;
    //property ShortCut: TShortCut read FShortCut write FShortCut default 32808; //Menus.ShortCut(VK_DOWN, [ssAlt]);
    property Style: TEditButtonStyleEh read FStyle write SetStyle default ebsDropDownEh;
    property Visible: Boolean read GetVisible write SetVisible stored IsVisibleStored default False;
    property Width: Integer read FWidth write SetWidth default 0;

    property OnClick: TButtonClickEventEh read FOnButtonClick write SetOnButtonClick;
    property OnDown: TButtonDownEventEh read FOnButtonDown write SetOnButtonDown;
  end;

  TEditButtonEhClass = class of TEditButtonEh;

{ TDropDownEditButtonEh }

  TDropDownEditButtonEh = class(TEditButtonEh)
  public
    constructor Create(Collection: TCollection); overload; override;
    constructor Create(EditControl: TWinControl); overload;
  published
    property ShortCut default 32808; //Menus.ShortCut(VK_DOWN, [ssAlt]);
  end;

{ TVisibleEditButtonEh }

  TVisibleEditButtonEh = class(TEditButtonEh)
  public
    constructor Create(Collection: TCollection); overload; override;
    constructor Create(EditControl: TWinControl); overload;
  published
    property ShortCut default 32808; //Menus.ShortCut(VK_DOWN, [ssAlt]);
    property Visible default True;
  end;

{ TEditButtonsEh }

  TEditButtonsEh = class(TCollection)
  private
    FOnChanged: TNotifyEvent;
    FOnRefComponentChanged: TRefComponentNotifyEventEh;
    function GetEditButton(Index: Integer): TEditButtonEh;
    procedure SetEditButton(Index: Integer; Value: TEditButtonEh);
  protected
    FOwner: TPersistent;
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(Owner: TPersistent; EditButtonClass: TEditButtonEhClass);
    function Add: TEditButtonEh;
    property Items[Index: Integer]: TEditButtonEh read GetEditButton write SetEditButton; default;
    property OnChanged: TNotifyEvent read FOnChanged write FOnChanged;
    property OnRefComponentChanged: TRefComponentNotifyEventEh read FOnRefComponentChanged write FOnRefComponentChanged;
  end;

{ TSpecRowEh }

  TSpecRowEh = class(TPersistent)
  private
    FCellsStrings: TStrings;
    FCellsText: String;
    FColor: TColor;
    FFont: TFont;
    FOnChanged: TNotifyEvent;
    FOwner: TPersistent;
    FSelected: Boolean;
    FShortCut: TShortCut;
    FShowIfNotInKeyList: Boolean;
    FUpdateCount: Integer;
    FValue: Variant;
    FVisible: Boolean;
    function GetCellText(Index: Integer): String;
    function GetColor: TColor;
    function GetFont: TFont;
    function IsColorStored: Boolean;
    function IsFontStored: Boolean;
    function IsValueStored: Boolean;
    procedure FontChanged(Sender: TObject);
    procedure SetCellsText(const Value: String);
    procedure SetColor(const Value: TColor);
    procedure SetFont(const Value: TFont);
    procedure SetShowIfNotInKeyList(const Value: Boolean);
    procedure SetValue(const Value: Variant);
    procedure SetVisible(const Value: Boolean);
  protected
    FColorAssigned: Boolean;
    FFontAssigned: Boolean;
    function GetOwner: TPersistent; override;
    procedure Changed;
  public
    constructor Create(Owner: TPersistent);
    destructor Destroy; override;
    function DefaultColor: TColor;
    function DefaultFont: TFont;
    function LocateKey(KeyValue: Variant): Boolean;
    procedure Assign(Source: TPersistent); override;
    procedure BeginUpdate;
    procedure EndUpdate;
    property CellText[Index: Integer]: String read GetCellText;
    property Selected: Boolean read FSelected write FSelected;
    property UpdateCount: Integer read FUpdateCount;
    property OnChanged: TNotifyEvent read FOnChanged write FOnChanged;
  published
    property CellsText: String read FCellsText write SetCellsText;
    property Color: TColor read GetColor write SetColor stored IsColorStored;
    property Font: TFont read GetFont write SetFont stored IsFontStored;
    property ShortCut: TShortCut read FShortCut write FShortCut default 32814; //Menus.ShortCut(VK_DOWN, [ssAlt]);
    property ShowIfNotInKeyList: Boolean read FShowIfNotInKeyList write SetShowIfNotInKeyList default True;
    property Value: Variant read FValue write SetValue stored IsValueStored;
    property Visible: Boolean read FVisible write SetVisible default False;
  end;

{ TSizeGripEh }

  TSizeGripPosition = (sgpTopLeft, sgpTopRight, sgpBottomRight, sgpBottomLeft);
  TSizeGripChangePosition = (sgcpToLeft, sgcpToRight, sgcpToTop, sgcpToBottom);

  TSizeGripEh = class(TCustomControlEh)
  private
    FInitScreenMousePos: TPoint;
    FInternalMove: Boolean;
    FOldMouseMovePos: TPoint;
    FParentRect: TRect;
    FParentResized: TNotifyEvent;
    FPosition: TSizeGripPosition;
    FTriangleWindow: Boolean;
    FHostControl: TWinControl;
    function GetVisible: Boolean;
    procedure SetPosition(const Value: TSizeGripPosition);
    procedure SetTriangleWindow(const Value: Boolean);
    {$IFDEF FPC}
    procedure SetVisible(const Value: Boolean); reintroduce;
    {$ELSE}
    procedure SetVisible(const Value: Boolean);
    {$ENDIF}
    procedure WMMove(var Message: TWMMove); message WM_MOVE;
    function GetHostControl: TWinControl;
    procedure SetHostControl(const Value: TWinControl);
    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBKGND;
  protected
    procedure CreateHandle; override;
    procedure CreateWnd; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure Paint; override;
    procedure ParentResized; dynamic;
  public
    constructor Create(AOwner: TComponent); override;
    procedure ChangePosition(NewPosition: TSizeGripChangePosition);
    procedure UpdatePosition;
    procedure UpdateWindowRegion;
    property Position: TSizeGripPosition read FPosition write SetPosition default sgpBottomRight;
    property TriangleWindow: Boolean read FTriangleWindow write SetTriangleWindow default True;
    property Visible: Boolean read GetVisible write SetVisible;
    property OnParentResized: TNotifyEvent read FParentResized write FParentResized;
    property HostControl: TWinControl read GetHostControl write SetHostControl;
  end;

{ TPictureEh }

  TPictureEh = class(TPicture)
  public
    constructor Create;
    destructor Destroy; override;
    function GetDestRect(const SrcRect: TRect; Placement: TImagePlacementEh): TRect; virtual;
    procedure PaintTo(Canvas: TCanvas; const DestRect: TRect; Placement: TImagePlacementEh; const ShiftPoint: TPoint; const ClipRect: TRect); virtual;
  end;

const
  cm_SetSizeGripChangePosition = WM_USER + 100;

{ TPopupMonthCalendarEh }

const
  CM_CLOSEUPEH = WM_USER + 101;

type

{$IFDEF FPC}
  TPopupMonthCalendarEh = class(TCalendar)
{$ELSE}
  TPopupMonthCalendarEh = class(TMonthCalendar)
{$ENDIF}
  private
    FBorderWidth: Integer;
    procedure CMCloseUpEh(var Message: TMessage); message CM_CLOSEUPEH;
    {$IFDEF FPC}
    {$ELSE}
    procedure CMCtl3DChanged(var Message: TMessage); message CM_CTL3DCHANGED;
    {$ENDIF}
    procedure CMWantSpecialKey(var Message: TCMWantSpecialKey); message CM_WANTSPECIALKEY;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCPaint(var Message: TWMNCPaint); message WM_NCPAINT;
    function GetDate: TDate;
    procedure SetDate(const Value: TDate);
  protected
    FDownViewType: Integer;
    function CanAutoSize(var NewWidth, NewHeight: Integer): Boolean; override;
    function DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    {$IFDEF FPC}
    {$ELSE}
    function MsgSetDateTime(Value: TSystemTime): Boolean; override;
    {$ENDIF}
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure DrawBorder; virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure PostCloseUp(Accept: Boolean);
    procedure UpdateBorderWidth;
  public
    constructor Create(AOwner: TComponent); override;

    property Date: TDate read GetDate write SetDate;
    property Color;
    {$IFDEF FPC}
    {$ELSE}
    property Ctl3D;
    {$ENDIF}
  end;

  TListGetImageIndexEventEh = procedure(Sender: TObject; ItemIndex: Integer; var ImageIndex: Integer) of object;

{ TMRUList }
type

  TFilterMRUItemEventEh = procedure (Sender: TObject; var Accept: Boolean) of object;
  TSetDropDownEventEh = procedure (Sender: TObject) of object;
  TSetCloseUpEventEh = procedure (Sender: TObject; Accept: Boolean) of object;

  TMRUListEh = class(TPersistent)
  private
    FActive: Boolean;
    FAutoAdd: Boolean;
    FCaseSensitive: Boolean;
    FItems: TStrings;
    FLimit: Integer;
    FOnActiveChanged: TNotifyEvent;
    FOnFilterItem: TFilterMRUItemEventEh;
    FOnSetCloseUpEvent: TSetCloseUpEventEh;
    FOnSetDropDown: TSetDropDownEventEh;
    FOwner: TPersistent;
    FRows: Integer;
    FWidth: Integer;
    FCancelIfKeyInQueue: Boolean;
    procedure SetActive(const Value: Boolean);
    procedure SetItems(const Value: TStrings);
    procedure SetLimit(const Value: Integer);
    procedure SetRows(const Value: Integer);
  protected
    FDroppedDown: Boolean;
    procedure UpdateLimit;
  public
    constructor Create(AOwner: TPersistent);
    destructor Destroy; override;
    procedure Add(s: String);
    procedure Assign(Source: TPersistent); override;
    procedure CloseUp(Accept: Boolean); virtual;
    procedure DropDown; virtual;
    function FilterItemsTo(FilteredItems: TStrings; MaskText: String): Boolean;
    property DroppedDown: Boolean read FDroppedDown write FDroppedDown;
    property Width: Integer read FWidth write FWidth;
    property OnActiveChanged: TNotifyEvent read FOnActiveChanged write FOnActiveChanged;
    property OnSetCloseUp: TSetCloseUpEventEh read FOnSetCloseUpEvent write FOnSetCloseUpEvent;
    property OnSetDropDown: TSetDropDownEventEh read FOnSetDropDown write FOnSetDropDown;
    property OnFilterItem: TFilterMRUItemEventEh read FOnFilterItem write FOnFilterItem;
    property CancelIfKeyInQueue: Boolean read FCancelIfKeyInQueue write FCancelIfKeyInQueue default True;
  published
    property AutoAdd: Boolean read FAutoAdd write FAutoAdd default True;
    property Active: Boolean read FActive write SetActive default False;
    property CaseSensitive: Boolean read FCaseSensitive write FCaseSensitive default False;
    property Items: TStrings read FItems write SetItems;
    property Limit: Integer read FLimit write SetLimit default 100;
    property Rows: Integer read FRows write SetRows default 7;
  end;

   TStringListEh = class(TStringList)
{$IFNDEF EH_LIB_6}
  private
    FCaseSensitive: Boolean;
    function CompareStrings(const S1, S2: string): Integer;
    procedure SetCaseSensitive(const Value: Boolean);
  public
    procedure Sort; override;
    property CaseSensitive: Boolean read FCaseSensitive write SetCaseSensitive;
{$ENDIF}
   end;
{ TDataLinkEh }

{$IFDEF CIL}
  TDataEventEh = procedure (Event: TDataEvent; Info: TObject) of object;
{$ELSE}
  TDataEventEh = procedure (Event: TDataEvent; Info: Longint) of object;
{$ENDIF}

  TDataLinkEh = class(TDataLink)
  private
    FOnDataEvent: TDataEventEh;
  protected
{$IFDEF CIL}
    procedure DataEvent(Event: TDataEvent; Info: TObject); virtual;
{$ELSE}
  {$IFDEF EH_LIB_16}
    procedure DataEvent(Event: TDataEvent; Info: NativeInt); override;
  {$ELSE}
    {$IFDEF FPC}
    procedure DataEvent(Event: TDataEvent; Info: NativeInt); override;
    {$ELSE}
    procedure DataEvent(Event: TDataEvent; Info: Integer); override;
    {$ENDIF}
  {$ENDIF}
{$ENDIF}
  public
    property OnDataEvent: TDataEventEh read FOnDataEvent write FOnDataEvent;
  end;

{ TDatasetFieldValueListEh }

  TDatasetFieldValueListEh = class(TInterfacedObject, IMemTableDataFieldValueListEh)
  private
    FValues: TStringList;
    FDataObsoleted: Boolean;
    FFieldName: String;
    FDataLink: TDataLinkEh;
    FDataSource: TDataSource;
    function GetDataSet: TDataSet;
    function GetDataSource: TDataSource;
    function GetValues: TStrings;
    function GetCaseSensitive: Boolean;
    procedure SetDataSet(const Value: TDataSet);
    procedure SetCaseSensitive(const Value: Boolean);
    procedure SetDataSource(const Value: TDataSource);
    procedure SetFieldName(const Value: String);
  protected
    procedure RefreshValues;
{$IFDEF CIL}
    procedure DataSetEvent(Event: TDataEvent; Info: TObject); virtual;
{$ELSE}
    procedure DataSetEvent(Event: TDataEvent; Info: Integer); virtual;
{$ENDIF}
  public
    constructor Create;
    destructor Destroy; override;
    procedure SetFilter(Filter: String);
    property CaseSensitive: Boolean read GetCaseSensitive write SetCaseSensitive;
    property FieldName: String read FFieldName write SetFieldName;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DataSet: TDataSet read GetDataSet write SetDataSet;
    property Values: TStrings read GetValues;
  end;

{ TDesignControlerEh }

  TDesignControlerEh = class(TInterfacedObject)
  public
    function IsDesignHitTest(Control: TPersistent; X, Y: Integer; AShift: TShiftState): Boolean; virtual; abstract;
    function ControlIsObjInspSelected(Control: TPersistent): Boolean; virtual; abstract;
    function GetObjInspSelectedControl(BaseControl: TPersistent): TPersistent; virtual; abstract;
    function GetDesignInfoItemClass: TCollectionItemClass; virtual; abstract;
    function GetSelectComponentCornerImage: TBitmap; virtual; abstract;
    procedure DesignMouseDown(Control: TPersistent; X, Y: Integer; AShift: TShiftState); virtual; abstract;
    procedure DrawDesignSelectedBorder(Canvas: TCanvas; ARect: TRect); virtual; abstract;
    procedure RegisterChangeSelectedNotification(Control: TPersistent); virtual; abstract;
    procedure UnregisterChangeSelectedNotification(Control: TPersistent); virtual; abstract;
    procedure KeyProperyModified(Control: TControl); virtual; abstract;
    procedure SelectComponent(Component: TComponent; Instance: TPersistent); virtual; abstract;
  end;

  TLocateTextEventEh = function (Sender: TObject;
    const FieldName: string; const Text: String; Options: TLocateTextOptionsEh;
    Direction: TLocateTextDirectionEh; Matching: TLocateTextMatchingEh;
    TreeFindRange: TLocateTextTreeFindRangeEh): Boolean of object;

  TDrawButtonControlStyleEh = (bcsDropDownEh, bcsEllipsisEh, bcsUpDownEh,
    bcsCheckboxEh, bcsPlusEh, bcsMinusEh, bcsAltDropDownEh, bcsAltUpDownEh);
  TTreeElementEh = (tehMinusUpDown, tehMinusUp, tehMinusDown, tehMinus,
                   tehPlusUpDown, tehPlusUp, tehPlusDown, tehPlus,
                   tehCrossUpDown, tehCrossUp, tehCrossDown,
                   tehVLine);


procedure PaintButtonControlEh(Canvas: TCanvas; ARect: TRect; ParentColor: TColor;
  Style: TDrawButtonControlStyleEh; DownButton: Integer;
  Flat, Active, Enabled: Boolean; State: TCheckBoxState);

procedure DrawUserButtonBackground(Canvas: TCanvas; ARect: TRect; ParentColor: TColor;
  Enabled, Active, Flat, Pressed: Boolean);

function GetDefaultFlatButtonWidth: Integer;

function ClientToScreenRect(Control: TControl): TRect;

var
  FlatButtonWidth: Integer;

//type
// TFieldTypes = set of TFieldType;
//Don't declare such types in interface part because of C++ Builder 2010 error:
//E2015 Ambiguity between 'ftSingle' and 'Typinfo::ftSingle'
// as it turn in - typedef Set<Db::TFieldType, ftUnknown, ftStream>  TFieldTypes;

//const
//  ftNumberFieldTypes: TFieldTypes = [ftSmallint, ftInteger, ftWord, ftFloat, ftCurrency,
//    ftBCD{$IFDEF EH_LIB_6}, ftFMTBcd{$ENDIF}];

type

{ TGraphicStreamFormatDetector }
  TGraphicStreamFormatDetector = class(TPersistent)
  public
    function CheckStreamSignature(Stream: TStream): Boolean; virtual;
    function GetGraphicClass(): TGraphicClass; virtual;
  end;

{ TGraphicStreamFormatsEh }

  TGraphicStreamFormatsEh = class(TList)
  private
    function GetGraphicStreamFormatDetector(Index: Integer): TGraphicStreamFormatDetector;
  public
    constructor Create;
    destructor Destroy; override;
    procedure RegisterGraphicStreamFormatDetector(d: TGraphicStreamFormatDetector);
    function FindClassFromStreamHeader(Stream: TStream): TGraphicClass;
    property Items[Index: Integer]: TGraphicStreamFormatDetector read GetGraphicStreamFormatDetector;
  end;

  TTreeViewGlyphStyleEh = (tvgsDefaultEh, tvgsClassicEh, tvgsThemedEh, tvgsExplorerThemedEh);

  TLSAutoFilterTypeEh = (lsftBeginsWithEh, lsftContainsEh);

function IsFieldTypeNumeric(FieldType: TFieldType): Boolean;

procedure GetFieldsProperty(List: TList; DataSet: TDataSet;
  Control: TComponent; const FieldNames: String); overload;

function GetFieldsProperty(DataSet: TDataSet; Control: TComponent;
  const FieldNames: String): TFieldsArrEh; overload;

procedure DataSetSetFieldValues(DataSet: TDataSet; Fields: String; Value: Variant);
procedure DataSetGetFieldValues(DataSet: TDataSet; FKeyFields: TFieldsArrEh; var Value: Variant);

function VarEquals(const V1, V2: Variant): Boolean;
function AnyVarToStrEh(const V: Variant): String;

{$IFNDEF EH_LIB_6}
type
  TVariantRelationship = (vrEqual, vrLessThan, vrGreaterThan, vrNotEqual);
{$ENDIF}

function DBVarCompareValue(const A, B: Variant): TVariantRelationship;

var UseButtonsBitmapCache: Boolean = True;

procedure ClearButtonsBitmapCache;

procedure DrawImage(DC: HDC; ARect: TRect; Images: TCustomImageList;
  ImageIndex: Integer; Selected: Boolean);
procedure DrawTreeElement(Canvas: TCanvas; ARect: TRect;
  TreeElement: TTreeElementEh; BackDot: Boolean; ScaleX, ScaleY: Double;
  RightToLeft: Boolean; Coloured: Boolean; GlyphStyle: TTreeViewGlyphStyleEh);

function AlignDropDownWindowRect(MasterAbsRect: TRect; DropDownWin: TWinControl; Align: TDropDownAlign): TPoint;
function AlignDropDownWindow(MasterWin, DropDownWin: TWinControl; Align: TDropDownAlign): TPoint;

function GetShiftState: TShiftState;

var
  DefaultCheckBoxWidth, DefaultCheckBoxHeight: Integer;
  DefaultFlatCheckBoxWidth, DefaultFlatCheckBoxHeight: Integer;

function AdjustCheckBoxRect(ClientRect: TRect; Alignment: TAlignment;
  Layout: TTextLayout{; Flat: Boolean}): TRect;

function IsDoubleClickMessage(OldPos, NewPos: TPoint; Interval: Longint): Boolean;
function DefaultEditButtonHeight(EditButtonWidth: Integer; Flat: Boolean): Integer;

function KillMouseUp(Control: TControl): Boolean; overload;
function KillMouseUp(Control: TControl; Area: TRect): Boolean; overload;

procedure FillGradientEh(Canvas: TCanvas; ARect: Trect; FromColor, ToColor: TColor); overload;
procedure FillGradientEh(Canvas: TCanvas; TopLeft: TPoint; Points: array of TPoint; FromColor, ToColor: TColor); overload;
function ApproachToColorEh(FromColor, ToColor: TColor; Percent: Integer): TColor;
function ThemesEnabled: Boolean;
function CustomStyleActive: Boolean;

procedure BroadcastPerformMessageFor(Owner: TComponent; ForClass: TControlClass;
  Msg: Cardinal; WParam, LParam: Longint);

{$IFNDEF EH_LIB_8}

(*
{ GradientFill in AGradientDirection using the given colors in the given rect.
  GradientFill requires Windows 98, NT4 or better. }
type
  TGradientDirection = (gdHorizontal, gdVertical);

procedure GradientFillCanvas(const ACanvas: TCanvas;
  const AStartColor, AEndColor: TColor; const ARect: TRect;
  const Direction: TGradientDirection);
*)

{$ENDIF}

type

{ Paradox graphic BLOB header }

  TGraphicHeader = record
    Count: Word;                { Fixed at 1 }
    HType: Word;                { Fixed at $0100 }
    Size: Longint;              { Size not including header }
  end;

  TPictureClass = class of TPicture;

{ TGraphicProviderEh }

  TGraphicProviderEh = class(TPersistent)
  public
{$IFDEF CIL}
    class function GetImageClassForStream(Start: TBytes): TGraphicClass; virtual;
{$ELSE}
    class function GetImageClassForStream(Start: Pointer): TGraphicClass; virtual;
{$ENDIF}
  end;

{ TBMPGraphicProviderEh }

  TBMPGraphicProviderEh = class(TGraphicProviderEh)
  public
    class function GetImageClassForStream(Start: Pointer): TGraphicClass; override;
  end;

{ TIconGraphicProviderEh }

  TIconGraphicProviderEh = class(TGraphicProviderEh)
  public
    class function GetImageClassForStream(Start: Pointer): TGraphicClass; override;
  end;

  TGraphicProviderEhClass = class of TGraphicProviderEh;

procedure RegisterGraphicProviderEh(GraphicProviderClass: TGraphicProviderEhClass);
{$IFDEF CIL}
function GetImageClassForStreamEh(Start: TBytes): TGraphicClass;
{$ELSE}
function GetImageClassForStreamEh(Start: Pointer): TGraphicClass;
{$ENDIF}
function GetGraphicProvidersCount: Integer;
function GetPictureForField(Field: TField): TPicture;
procedure AssignPictureFromImageField(Field: TField; Picture: TPicture);

function FieldValueToDispayValue(const AValue: Variant; Field: TField; const ADisplayFormat: String): String;

function SelectClipRectangleEh(Canvas: TCanvas; var ClipRect: TRect): HRgn;
procedure RestoreClipRectangleEh(Canvas: TCanvas; RecHandle: HRgn);

function ColorToGray(AColor: TColor): TColor;
function GetColorLuminance(AColor: TColor): Integer;

{$IFDEF CIL}
{$ELSE}
{ DrawProgressBarEh }

type
  TProgressBarTextTypeEh = (pbttAsValue, pbttAsPercent);
  TProgressBarFrameFigureTypeEh = (pbfftRectangle, pbfftRoundRect);
  TProgressBarFrameSizeTypeEh = (pbfstFull, pbfstVal);


  TProgressBarParamsEh = record
    ShowText: Boolean;
    TextType: TProgressBarTextTypeEh;
    TextDecimalPlaces: Byte;
    TextAlignment : TAlignment;
    FrameFigureType: TProgressBarFrameFigureTypeEh;
    FrameSizeType: TProgressBarFrameSizeTypeEh;
    Indent: Byte;
    FontName: String;
    FontColor: TColor;
    FontSize: Integer;
    FontStyle: TFontStyles;
  end;

  PProgressBarParamsEh = ^TProgressBarParamsEh;

procedure DrawProgressBarEh(const CurrentValue, MinValue, MaxValue: Double;
  Canvas: TCanvas; const Rect: TRect; Color, FrameColor, BackgroundColor: TColor;
  const PBParPtr: PProgressBarParamsEh = nil);
{$ENDIF}

function GetAllStrEntry(S, SubStr: String; var StartPoses: TIntegerDynArray; CaseInsensitive: Boolean): Boolean;

// Converted from function hilisut
procedure DrawHighlightedSubTextEh(C: TCanvas;AR: TRect;X, Y: Integer;T: string;
  A: TAlignment;La: TTextLayout;ML: Boolean;EE: Boolean;L, R: Integer;rlr: Boolean;
  S: String;CI: Boolean;HC: TColor;Pos: Integer;PosC: TColor);

function CheckRightToLeftFirstCharEh(S: String; RightToLeftIfUncertain: Boolean): Boolean;

{ TPopupMenuEh }

type

  TPopupMenuEh = class(TPopupMenu)
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Popup(X, Y: Integer); override;
  end;

{ TPopupMenuWinEh }

  TPopupMenuWinEh = class(TObject)
  protected
    FMenuHandle: HMENU;
    FPopupWindowHandle: HWND;
    FOrgPopupWindowProc: Pointer;
    FHookedPopupWindowProc: Pointer;
    FSelectedItemID: UINT;
//    FMenuPosSelecting: Boolean;
    procedure PopupWindowProc(var Msg: TMessage);
  end;

  {$IFDEF FPC}
  {$ELSE}
{ TPopupMenuEh }

  TPopupListEh = class(TPopupList)
  protected
    FGetPopupWindowHandle: Boolean;
    FPopupMenuWins: TList;
    FAddingMenuHandle: HMENU;
    procedure MenuSelectPos(MenuHandle: HMENU; ItemPos: UINT; var CanClose: Boolean);
    procedure MenuSelectID(ItemID: UINT; var CanClose: Boolean);
    procedure WndProc(var Message: TMessage); override;
    function AddMenuPopup(MenuPopup: HMENU): TPopupMenuWinEh;
    procedure DeleteWin(WindowHandle: HWND);
    function FindHackedMenuHandle(MenuPopup: HMENU): TPopupMenuWinEh;
  public
    constructor Create;
    destructor Destroy; override;
  end;
  {$ENDIF}

{ TMenuItemEh }

  TMenuItemEh = class(TMenuItem)
  private
    FCloseMenuOnClick: Boolean;
  published
  public
    constructor Create(AOwner: TComponent); override;
    property CloseMenuOnClick: Boolean read FCloseMenuOnClick write FCloseMenuOnClick default True;
  end;

var
  {$IFDEF FPC}
  {$ELSE}
  PopupListEh: TPopupListEh;
  {$ENDIF}
  ExplorerTreeviewTheme: THandle;

type
{$IFDEF EH_LIB_17}
  TListOfFieldsEh = TList<TField>;
{$ELSE}
  TListOfFieldsEh = TList;
{$ENDIF}
  TSortMarkerEh = (smNoneEh, smDownEh, smUpEh);

  TRCRRec = record
    Result: Integer;
    RectRgn: HRGN;
  end;

procedure WriteText(ACanvas: TCanvas; ARect: TRect; DX, DY: Integer;
  const Text: string; Alignment: TAlignment);

procedure WriteTextEh(ACanvas: TCanvas;      // Canvas
                      ARect: TRect;          // Draw rect and ClippingRect
                      FillRect:Boolean;      // Fill rect Canvas.Brash.Color
                      DX, DY: Integer;       // InflateRect(Rect, -DX, -DY) for text
                      Text: string;          // Draw text
                      Alignment: TAlignment; // Text alignment
                      Layout: TTextLayout;   // Text layout
                      MultyL: Boolean;       // Word break
                      EndEllipsis: Boolean;  // Truncate long text by ellipsis
                      LeftMarg,              // Left margin
                      RightMarg: Integer;    // Right margin
                      RightToLeftReading: Boolean;
                      ForceSingleLine: Boolean //#13 #10  do not break the line
                      );

function WriteTextVerticalEh(ACanvas:TCanvas;
                          ARect: TRect;          // Draw rect and ClippingRect
                          FillRect:Boolean;      // Fill rect Canvas.Brash.Color
                          DX, DY: Integer;       // InflateRect(Rect, -DX, -DY) for text
                          Text: string;          // Draw text
                          Alignment: TAlignment; // Text alignment
                          Layout: TTextLayout;   // Text layout
                          EndEllipsis:Boolean;   // Truncate long text by ellipsis
                          CalcTextExtent:Boolean   //
                          ):Integer;

function ApproximateColor(FromColor, ToColor: TColor; Quota: Double): TColor;
function MightierColor(Color1, Color2: TColor): TColor;

procedure DrawClipped(imList: TCustomImageList; Bitmap: TBitmap;
  ACanvas: TCanvas; ARect: TRect; Index,
  ALeftMarg: Integer; Align: TAlignment; const ClipRect: TRect);

function iif(Condition: Boolean; V1, V2: Integer): Integer;
function PointInRect(const P: TPoint; const R: TRect): Boolean;
procedure SwapInt(var a, b: Integer);
procedure SwapForRTLClient(var a, b: Integer; ClientWidth: Integer); overload;
procedure SwapForRTLClient(var ARect: TRect; ClientWidth: Integer); overload;
procedure ShiftForRTLClient(var a: Integer;  ClientWidth: Integer);
function StringsLocate(const StrList: TStrings; const Str: String; const Options: TLocateOptions): Integer;
function FieldsCanModify(Fields: TListOfFieldsEh): Boolean; overload;
function FieldsCanModify(Fields: TFieldsArrEh): Boolean; overload;


procedure ArrayInsertRange(var Extents: TVariantArrayEh; StartIndex, Amount: Longint);
procedure ArrayDeleteRange(var Extents: TVariantArrayEh; StartIndex, Amount: Longint);

implementation

uses
  {$IFDEF FPC}
  DBConst,
  {$ELSE}
  DBConsts,
  {$ENDIF}
   Math,
  {$IFDEF EH_LIB_7} Themes, UxTheme, {$ENDIF}
  {$IFDEF EH_LIB_12} RTLConsts, {$ENDIF}
  DropDownFormEh,
  MultiMon;

type
  TWinControlCracker = class(TWinControl) end;
  TControlCracker = class(TControl) end;
//  TScrollBarCracker = class(TScrollBar) end;

var
  DrawBitmap: TBitmap;
  UserCount: Integer;

procedure UsesBitmap;
begin
  if UserCount = 0 then
    DrawBitmap := TBitmap.Create;
  Inc(UserCount);
end;

procedure ReleaseBitmap;
begin
  Dec(UserCount);
  if UserCount = 0 then FreeAndNil(DrawBitmap);
end;

procedure ArrayInsertRange(var Extents: TVariantArrayEh; StartIndex, Amount: Longint);
var
  I: Integer;
begin
  if Amount < 0 then raise Exception.Create('ArrayInsertRange: (Amount < 0)');
  if StartIndex > Length(Extents) then raise Exception.Create('ArrayInsertRange: StartIndex > Length(Extents)');

  if Length(Extents) = StartIndex then
    SetLength(Extents, Length(Extents)+Amount)
  else
  begin
    SetLength(Extents, Length(Extents)+Amount);
    for I := Length(Extents)- Amount - 1 downto StartIndex do
      Extents[I+Amount] := Extents[I];
  end;
end;

procedure ArrayDeleteRange(var Extents: TVariantArrayEh; StartIndex, Amount: Longint);
var
  I: Integer;
begin
  if Amount < 0 then raise Exception.Create('ArrayDeleteRange: (Amount < 0)');
  if StartIndex + Amount > Length(Extents) then raise Exception.Create('ArrayDeleteRange: StartIndex + Amount > Length(Extents)');

  if StartIndex + Amount < Length(Extents) then
    for I := StartIndex to Length(Extents) - Amount - 1 do
      Extents[I] := Extents[I+Amount];

  SetLength(Extents, Length(Extents)-Amount);
end;

procedure WriteText(ACanvas: TCanvas; ARect: TRect; DX, DY: Integer;
  const Text: string; Alignment: TAlignment);
const
  AlignFlags: array[TAlignment] of Integer =
  (DT_LEFT or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX,
    DT_RIGHT or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX,
    DT_CENTER or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX);
var
  B, R: TRect;
  Left: Integer;
  I: TColorRef;
begin
  I := ColorToRGB(ACanvas.Brush.Color);
  if GetNearestColor(ACanvas.Handle, I) = I then
  begin { Use ExtTextOut for solid colors }
    case Alignment of
      taLeftJustify:
        Left := ARect.Left + DX;
      taRightJustify:
        Left := ARect.Right - ACanvas.TextWidth(Text) - 3;
    else { taCenter }
      Left := ARect.Left + (ARect.Right - ARect.Left) shr 1
        - (ACanvas.TextWidth(Text) shr 1);
    end;
    WindowsExtTextOut(ACanvas.Handle, Left, ARect.Top + DY, ETO_OPAQUE or
      ETO_CLIPPED, ARect, Text, Length(Text));
  end else
  begin { Use FillRect and Drawtext for dithered colors }
    DrawBitmap.Canvas.Lock;
    try
      with DrawBitmap, ARect do { Use offscreen bitmap to eliminate flicker and }
      begin { brush origin tics in painting / scrolling.    }
        Width := Max(Width, Right - Left);
        Height := Max(Height, Bottom - Top);
        R := Rect(DX, DY, Right - Left - 1, Bottom - Top - 1);
        B := Rect(0, 0, Right - Left, Bottom - Top);
      end;
      with DrawBitmap.Canvas do
      begin
        Font := ACanvas.Font;
        Font.Color := ACanvas.Font.Color;
        Brush := ACanvas.Brush;
        Brush.Style := bsSolid;
        FillRect(B);
        SetBkMode(Handle, TRANSPARENT);
        DrawTextEh(Handle, Text, Length(Text), R, AlignFlags[Alignment]);
      end;
      ACanvas.CopyRect(ARect, DrawBitmap.Canvas, B);
    finally
      DrawBitmap.Canvas.Unlock;
    end;
  end;
end;

function MinimizeText(const Text: string; Canvas: TCanvas; MaxWidth: Integer): string;
var
  I: Integer;
begin
  Result := Text;
  I := 1;
  while (I <= Length(Text)) and (Canvas.TextWidth(Result) > MaxWidth) do
  begin
    Inc(I);
    Result := Copy(Text, 1, Max(0, Length(Text) - I)) + '...';
  end;
end;

function GetTextWidth(Canvas: TCanvas; const Text: String): Integer;
var ARect: TRect;
  uFormat: Integer;
begin
  uFormat := DT_CALCRECT or DT_LEFT or DT_NOPREFIX;
  ARect := Rect(0, 0, 1, 0);
  DrawTextEh(Canvas.Handle, Text, Length(Text), ARect, uFormat);
  Result := ARect.Right - ARect.Left;
end;

procedure WriteTextEh(ACanvas: TCanvas; ARect: TRect; FillRect: Boolean; DX, DY: Integer;
  Text: string; Alignment: TAlignment; Layout: TTextLayout; MultyL: Boolean;
  EndEllipsis: Boolean; LeftMarg, RightMarg: Integer; RightToLeftReading: Boolean;
  ForceSingleLine: Boolean);
const
  AlignFlags: array[TAlignment] of Integer =
  (DT_LEFT or DT_EXPANDTABS or DT_NOPREFIX,
    DT_RIGHT or DT_EXPANDTABS or DT_NOPREFIX,
    DT_CENTER or DT_EXPANDTABS or DT_NOPREFIX);
  RTL: array[Boolean] of Integer = (0, DT_RTLREADING);
var
  txth, DrawFlag, Left, TextWidth, TextHeight, Top: Integer;
  lpDTP: TDrawTextParams;
  B: TRect;
//  TM: TTextMetric;
  I: TColorRef;
  BrushStyle: TBrushStyle;
  BrushColor: TColor;

  function RestrictClipRegionAlignment(Canvas: TCanvas; Rect: TRect): TRCRRec;
  var
    RectRgn: HRGN;
  begin
    {if UseRightToLeftAlignment then
    begin
      Rect.Left := ClientWidth - Rect.Left;
      Rect.Right := ClientWidth - Rect.Right;
    end;}
    Result.RectRgn := CreateRectRgn(0, 0, 0, 0);
    Result.Result := GetClipRgn(Canvas.Handle, Result.RectRgn);
    RectRgn := CreateRectRgn(Rect.Left, Rect.Top, Rect.Right, Rect.Bottom);
    ExtSelectClipRgn(Canvas.Handle, RectRgn, RGN_AND);
    DeleteObject(RectRgn);
  end;

  procedure RestoreClipRegion(Canvas: TCanvas; RCR: TRCRRec);
  begin
    if RCR.Result = 0
      then SelectClipRgn(Canvas.Handle, 0)
      else SelectClipRgn(Canvas.Handle, RCR.RectRgn);
    DeleteObject(RCR.RectRgn);
  end;

  procedure DrawTextOnCanvas(ACanvas: TCanvas);
  var
    rect1, rect2: TRect;
    RCR: TRCRRec;
  begin
    DrawFlag := 0;
    if (MultyL = True) then
      DrawFlag := DrawFlag or DT_WORDBREAK
    else if ForceSingleLine then
      DrawFlag := DrawFlag or DT_SINGLELINE;
    if (EndEllipsis = True) then DrawFlag := DrawFlag or DT_END_ELLIPSIS;
    DrawFlag := DrawFlag or AlignFlags[Alignment] or RTL[RightToLeftReading];

    rect1 := B; {}

    lpDTP.cbSize := SizeOf(lpDTP);
    lpDTP.uiLengthDrawn := Length(Text);
    lpDTP.iLeftMargin := LeftMarg;
    lpDTP.iRightMargin := RightMarg;

//    InflateRect(rect1, -DX, -DY);
    rect1.Left := rect1.Left + DX;
    if Alignment = taCenter then
      rect1.Right := rect1.Right - DX;
    rect2 := rect1;

    if (Layout <> tlTop) {and (MultyL = True)} then
      txth := WindowsDrawTextEx(ACanvas.Handle, Text, Length(Text), {}
        rect1, DrawFlag or DT_CALCRECT, lpDTP) // Get rectangle.
    else
      txth := 0;
      
    rect1 := rect2;

    case Layout of
      tlTop: rect1.top := rect1.top + DY;
      tlBottom: rect1.top := rect1.Bottom - txth - DY;
      tlCenter: rect1.top := rect1.top + ((rect1.Bottom - rect1.top) div 2) - (txth div 2);
    end;

    case Alignment of
      taLeftJustify: ;//lpDTP.iLeftMargin := lpDTP.iLeftMargin + DX;
      taRightJustify: lpDTP.iRightMargin := lpDTP.iLeftMargin + DX;
      taCenter: ;
    end;

//    if DX > 0 then rect1.Bottom := rect1.Bottom + 1;
    if rect1.Top < rect2.Top then
      RCR := RestrictClipRegionAlignment(ACanvas, rect2);

    WindowsDrawTextEx(ACanvas.Handle, Text, Length(Text), rect1, DrawFlag, lpDTP);

    if rect1.Top < rect2.Top then
      RestoreClipRegion(ACanvas, RCR);
 end;

begin

  I := ColorToRGB(ACanvas.Brush.Color);
  if (GetNearestColor(ACanvas.Handle, I) = I) then
  begin { Use ExtTextOut for solid colors and single-line text}
    if MultyL or (LeftMarg <> 0) or (RightMarg <> 0) or
       EndEllipsis or (Length(Text) > 32768) or not ForceSingleLine then
    begin
      B := ARect;
      BrushStyle := ACanvas.Brush.Style;
      BrushColor := ACanvas.Brush.Color;
      if FillRect
        then ACanvas.FillRect(B)
        else ACanvas.Brush.Style := bsClear;
      DrawTextOnCanvas(ACanvas);
      if not FillRect then
      begin
        ACanvas.Brush.Style := BrushStyle;
        ACanvas.Brush.Color := BrushColor;
      end;
    end else
    begin
      if EndEllipsis then Text := MinimizeText(Text, ACanvas, ARect.Right - ARect.Left - DX);
      if (Alignment <> taLeftJustify) and (ACanvas.Font.Style * [fsBold, fsItalic] <> []) then
      begin
        TextWidth := GetTextWidth(ACanvas, Text)
      end else
        TextWidth := ACanvas.TextWidth(Text);

      case Alignment of
        taLeftJustify:
          Left := ARect.Left + DX;
        taRightJustify:
          Left := ARect.Right - TextWidth - 3;
      else { taCenter }
        if (ARect.Right > ARect.Left) then
          Left := ARect.Left + (ARect.Right - ARect.Left) shr 1 - (TextWidth shr 1)
        else
          Left := 0;
   //      Left := ARect.Left + (ARect.Right - ARect.Left) shr 1 - (TextWidth shr 1);
      end;

      Top := ARect.Top;
      if Layout <> tlTop then
      begin
        TextHeight := ACanvas.TextHeight(Text);
        if ARect.Bottom - ARect.Top - DY > TextHeight then
        case Layout of
          tlCenter: Top := (ARect.Bottom + ARect.Top - TextHeight) div 2  - DY;
          tlBottom: Top := ARect.Bottom - TextHeight - DY*2;
        end;
      end;

      BrushColor := ACanvas.Brush.Color;
      BrushStyle := ACanvas.Brush.Style;
      if not FillRect then
        ACanvas.Brush.Style := bsClear
      {$IFDEF FPC}
      else
        ACanvas.FillRect(ARect)
      {$ENDIF}
      ;
      ACanvas.TextRect(ARect, Left, Top + DY, Text);
      if not FillRect then
      begin
        ACanvas.Brush.Style := BrushStyle;
        ACanvas.Brush.Color := BrushColor;
      end;
    end;
  end
  else begin
    DrawBitmap.Canvas.Lock;
    try
      DrawBitmap.Width := Max(DrawBitmap.Width, ARect.Right - ARect.Left);
      DrawBitmap.Height := Max(DrawBitmap.Height, ARect.Bottom - ARect.Top);
      B := Rect(0, 0, ARect.Right - ARect.Left, ARect.Bottom - ARect.Top);
      DrawBitmap.Canvas.Font := ACanvas.Font;
      DrawBitmap.Canvas.Font.Color := ACanvas.Font.Color;
      DrawBitmap.Canvas.Brush := ACanvas.Brush;
      DrawBitmap.Canvas.Brush.Style := bsSolid;

      SetBkMode(DrawBitmap.Canvas.Handle, TRANSPARENT);

      {if (FillRect = True) then } DrawBitmap.Canvas.FillRect(B);

      DrawTextOnCanvas(DrawBitmap.Canvas);

      ACanvas.CopyRect(ARect, DrawBitmap.Canvas, B);
    finally
      DrawBitmap.Canvas.Unlock;
    end;
  end;
end;

function CreateVerticalFont(Font: TFont): HFont;
var
  LogFont: TLogFont;
begin
  with LogFont do
  begin
    lfEscapement := 900;
    lfOrientation := 900;

    {$IFDEF FPC}
    if Font.Height <> 0
      then lfHeight := Font.Height
      else lfHeight := -(GetFontSize(Font, nil) * Font.PixelsPerInch) div 72;
    {$ELSE}
    lfHeight := Font.Height;
    {$ENDIF}
    lfWidth := 0; { have font mapper choose }
    if fsBold in Font.Style
      then lfWeight := FW_BOLD
      else lfWeight := FW_NORMAL;
    lfItalic := Byte(fsItalic in Font.Style);
    lfUnderline := Byte(fsUnderline in Font.Style);
    lfStrikeOut := Byte(fsStrikeOut in Font.Style);
    lfCharSet := Byte(Font.Charset);
{$IFDEF CIL}
    if NlsCompareText(Font.Name, 'Default') = 0 // do not localize
      then lfFaceName := DefFontData.Name
      else lfFaceName := Font.Name;
{$ELSE}
{$IFDEF EH_LIB_12}
    if NlsCompareText(Font.Name, 'Default') = 0 // do not localize
      then StrPLCopy(lfFaceName, String(DefFontData.Name), Length(DefFontData.Name))
      else StrPLCopy(lfFaceName, String(Font.Name), Length(Font.Name));
{$ELSE}
    if CompareText(Font.Name, 'Default') = 0 // do not localize
      then StrPCopy(lfFaceName, DefFontData.Name)
      else StrPCopy(lfFaceName, Font.Name);
{$ENDIF}
{$ENDIF}
    lfQuality := DEFAULT_QUALITY;
    { Everything else as default }
    lfOutPrecision := OUT_TT_ONLY_PRECIS; //OUT_DEFAULT_PRECIS;
    lfClipPrecision := CLIP_DEFAULT_PRECIS;
    case Font.Pitch of
      fpVariable: lfPitchAndFamily := VARIABLE_PITCH;
      fpFixed: lfPitchAndFamily := FIXED_PITCH;
    else
      lfPitchAndFamily := DEFAULT_PITCH;
    end;
  end;

  Result := CreateFontIndirect(LogFont);
end;

function WriteTextVerticalEh(ACanvas:TCanvas;
                          ARect: TRect;          // Draw rect and ClippingRect
                          FillRect:Boolean;      // Fill rect Canvas.Brash.Color
                          DX, DY: Integer;       // InflateRect(Rect, -DX, -DY) for text
                          Text: string;          // Draw text
                          Alignment: TAlignment; // Text alignment
                          Layout: TTextLayout;   // Text layout
                          EndEllipsis:Boolean;   // Truncate long text by ellipsis
                          CalcTextExtent:Boolean   //
                          ):Integer;
const
  AlignFlags: array[TAlignment] of Integer =
  (DT_LEFT or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX,
    DT_RIGHT or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX,
    DT_CENTER or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX);
var
  B, R: TRect;
  Left, Top, TextWidth: Integer;
  I: TColorRef;
  tm: Windows.TTextMetric;
  otm: TOutlineTextMetric;
  Overhang: Integer;
  BrushStyle: TBrushStyle;
begin
  I := ColorToRGB(ACanvas.Brush.Color);

  {$WARNINGS OFF}

  {$IFDEF FPC}
  ACanvas.Font.Orientation := 900;
  {$ELSE}
  SwapInt(ARect.Top, ARect.Bottom);
  ACanvas.Font.Handle := CreateVerticalFont(ACanvas.Font);
  {$ENDIF}

  {$WARNINGS ON}
  try
    GetTextMetrics(ACanvas.Handle, tm);
    Overhang := tm.tmOverhang;
    if (tm.tmPitchAndFamily and TMPF_TRUETYPE <> 0) and
      (ACanvas.Font.Style * [fsItalic] <> []) then
    begin
      otm.otmSize := SizeOf(otm);
      WindowsGetOutlineTextMetrics(ACanvas.Handle, otm.otmSize, otm);
      Overhang := (tm.tmHeight - tm.tmInternalLeading) * otm.otmsCharSlopeRun div otm.otmsCharSlopeRise;
    end;

    TextWidth := ACanvas.TextWidth(Text);
    Result := TextWidth + Overhang;
    if CalcTextExtent then Exit;

    if (not FillRect) or (GetNearestColor(ACanvas.Handle, I) = I) then
    begin { Use ExtTextOut for solid colors }
      case Alignment of
        taLeftJustify:
          Left := ARect.Left + DX;
        taRightJustify:
          Left := ARect.Right - ACanvas.TextHeight(Text);
      else { taCenter }
        Left := ARect.Left + (ARect.Right - ARect.Left) shr 1
          - ((ACanvas.TextHeight(Text) + tm.tmOverhang) shr 1);
      end;
      case Layout of
        tlTop: Top := ARect.Bottom + TextWidth + Overhang; // + 3;
        tlBottom: Top := ARect.Top - DY;
      else
        Top := ARect.Top - (ARect.Top - ARect.Bottom) shr 1
          + ((TextWidth + Overhang) shr 1);
      end;
      BrushStyle := ACanvas.Brush.Style;
      if not FillRect then
        ACanvas.Brush.Style := bsClear;
      ACanvas.TextRect(ARect, Left, Top, Text);
      if not FillRect then
        ACanvas.Brush.Style := BrushStyle;
    end else
    begin { Use FillRect and Drawtext for dithered colors }
      DrawBitmap.Canvas.Lock;
      try
        with DrawBitmap, ARect do { Use offscreen bitmap to eliminate flicker and }
        begin { brush origin tics in painting / scrolling.    }
          Width := Max(Width, Right - Left);
          Height := Max(Height, Top - Bottom);
          R := Rect(DX, Top - Bottom - 1, Right - Left - 1, DY);
          B := Rect(0, 0, Right - Left, Top - Bottom);
        end;
        with DrawBitmap.Canvas do
        begin
          Font := ACanvas.Font;
          Font.Color := ACanvas.Font.Color;
          Brush := ACanvas.Brush;
          Brush.Style := bsSolid;
          FillRect(B);
          SetBkMode(Handle, TRANSPARENT);
          DrawTextEh(Handle, Text, Length(Text), R,
            AlignFlags[Alignment]);
        end;
        ACanvas.CopyRect(ARect, DrawBitmap.Canvas, B);
      finally
        DrawBitmap.Canvas.Unlock;
      end;
    end;
  finally
    {$IFDEF FPC}
    {$ELSE}
    ACanvas.Font.Height := ACanvas.Font.Height;
    {$ENDIF}
  end;
end;

procedure DrawClipped(imList: TCustomImageList; Bitmap: TBitmap;
  ACanvas: TCanvas; ARect: TRect; Index,
  ALeftMarg: Integer; Align: TAlignment; const ClipRect: TRect);
var
  CheckedRect, AUnionRect: TRect;
  OldRectRgn, RectRgn: HRGN;
  r, x, y: Integer;
  bmWidth, bmHeight: Integer;
begin
  if not IntersectRect(CheckedRect,  ARect, ClipRect) then Exit;
  if Assigned(imList) then
  begin
    bmWidth := imList.Width;
    bmHeight := imList.Height;
  end else
  begin
    bmWidth := Bitmap.Width;
    bmHeight := Bitmap.Height;
  end;
  case Align of
    taLeftJustify: x := ARect.Left + ALeftMarg;
    taRightJustify: x := ARect.Right - bmWidth + ALeftMarg;
  else
    x := (ARect.Right + ARect.Left - bmWidth) div 2 + ALeftMarg;
  end;
  y := (ARect.Bottom + ARect.Top - bmHeight) div 2;
  CheckedRect := Rect(X, Y, X + bmWidth, Y + bmHeight);
  UnionRect(AUnionRect, CheckedRect, ARect);
  if EqualRect(AUnionRect, ARect) then // ARect containt image
    if Assigned(imList)
      then imList.Draw(ACanvas, X, Y, Index)
      else ACanvas.Draw(X, Y, Bitmap)
  else
  begin // Need clip
    OldRectRgn := CreateRectRgn(0, 0, 0, 0);
    r := GetClipRgn(ACanvas.Handle, OldRectRgn);
    RectRgn := CreateRectRgn(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
    //SelectClipRgn(ACanvas.Handle, RectRgn);
    ExtSelectClipRgn(ACanvas.Handle, RectRgn, RGN_AND);
    DeleteObject(RectRgn);

    if Assigned(imList)
      then imList.Draw(ACanvas, X, Y, Index)
      else ACanvas.Draw(X, Y, Bitmap);

    if r = 0
      then SelectClipRgn(ACanvas.Handle, 0)
      else SelectClipRgn(ACanvas.Handle, OldRectRgn);
    DeleteObject(OldRectRgn);
  end;
end;

function Max(A, B: Longint): Longint;
begin
  if A > B
    then Result := A
    else Result := B;
end;

function Min(A, B: Longint): Longint;
begin
  if A < B
    then Result := A
    else Result := B;
end;

function ApproximateColor(FromColor, ToColor: TColor; Quota: Double): TColor;
var
  r, g, b: Integer;
  r1, g1, b1: Integer;
  rgb, rgb1: Longint;
begin
  rgb := ColorToRGB(FromColor);
  r := (rgb shr 16) and $FF;
  g := (rgb shr 8) and $FF;
  b := rgb and $FF;

  rgb1 := ColorToRGB(ToColor);
  r1 := (rgb1 shr 16) and $FF;
  g1 := (rgb1 shr 8) and $FF;
  b1 := rgb1 and $FF;

  r := Max(0, Min(255, r + Trunc((r1 - r) / 255 * Quota)));
  g := Max(0, Min(255, g + Trunc((g1 - g) / 255 * Quota)));
  b := Max(0, Min(255, b + Trunc((b1 - b) / 255* Quota)));
  Result := TColor((r shl 16) or (g shl 8) or b);
end;

function MightierColor(Color1, Color2: TColor): TColor;
begin
  if GetColorLuminance(Color1) > GetColorLuminance(Color2)
    then Result := Color2
    else Result := Color1;
end;

function iif(Condition: Boolean; V1, V2: Integer): Integer;
begin
  if (Condition) then Result := V1 else Result := V2;
end;

function PointInRect(const P: TPoint; const R: TRect): Boolean;
begin
  with R do
    Result := (Left <= P.X) and (Top <= P.Y) and
      (Right >= P.X) and (Bottom >= P.Y);
end;

procedure SwapInt(var a, b: Integer);
var c: Integer;
begin
  c := a;
  a := b;
  b := c;
end;

procedure SwapForRTLClient(var a, b: Integer; ClientWidth: Integer);
var
  OldA: Integer;
begin
  OldA := a;
  a := ClientWidth - b;
  b := ClientWidth - OldA;
end;

procedure SwapForRTLClient(var ARect: TRect; ClientWidth: Integer);
begin
  SwapForRTLClient(ARect.Left, ARect.Right, ClientWidth);
end;

procedure ShiftForRTLClient(var a: Integer;  ClientWidth: Integer);
begin
  a := ClientWidth - a;
end;

function StringsLocate(const StrList: TStrings; const Str: String; const Options: TLocateOptions): Integer;

  function Compare(const S1, S2: String): Integer;
  begin
    if loCaseInsensitive in Options
      then Result := AnsiCompareText(S1, S2)
      else Result := CompareStr(S1, S2);
  end;

var
  i, len, Str_len: Integer;
  S: String;
begin
  Result := -1;
  Str_len := Length(Str);
  for i := 0 to StrList.Count - 1 do
  begin
    len := Length(StrList[i]);

    if len < Str_len then
      Continue;

    if loPartialKey in Options then 
      S := Copy(StrList.Strings[i], 1, Str_len)
    else
    begin
      if len <> Str_len then
        Continue;
      S := StrList.Strings[i];
    end;

    if Compare(S, Str) = 0 then
    begin
      Result := i;
      Break;
    end;
  end;
end;

function FieldsCanModify(Fields: TListOfFieldsEh): Boolean;
var
  i: Integer;
begin
  Result := True;
  for i := 0 to Fields.Count - 1 do
    if not TField(Fields[i]).CanModify then
    begin
      Result := False;
      Exit;
    end;
end;

function FieldsCanModify(Fields: TFieldsArrEh): Boolean;
var
  i: Integer;
begin
  Result := True;
  for i := 0 to Length(Fields) - 1 do
    if not TField(Fields[i]).CanModify then
    begin
      Result := False;
      Exit;
    end;
end;

function GetAllStrEntry(S, SubStr: String; var StartPoses: TIntegerDynArray; CaseInsensitive: Boolean): Boolean;
var
  Pos: Integer;
begin
  Pos := 1;
  SetLength(StartPoses, 0);
  if CaseInsensitive  then
  begin
    S := NlsUpperCase(S);
    SubStr := NlsUpperCase(SubStr);
  end;
  Result := False;
  while True do
  begin
    Pos := PosEx(SubStr, S, Pos);
    if Pos = 0 then
    begin
      Result := Result or False;
      Exit;
    end;
    SetLength(StartPoses, Length(StartPoses)+1);
    StartPoses[Length(StartPoses)-1] := Pos-1;
    Inc(Pos);
    Result := True;
  end;
end;

function ColorToGray(AColor: TColor): TColor;
var
  Lum: Integer;
  r, g, b, rgb: Integer;
begin
  rgb := ColorToRGB(AColor);
  r := (rgb shr 16) and $FF;
  g := (rgb shr 8) and $FF;
  b := rgb and $FF;
  Lum := (r * 77 + g * 150 + b * 29) shr 8; // div 256
  Result := Lum * $00010101;
end;

function GetColorLuminance(AColor: TColor): Integer;
var
  r, g, b, rgb: Integer;
begin
  rgb := ColorToRGB(AColor);
  r := (rgb shr 16) and $FF;
  g := (rgb shr 8) and $FF;
  b := rgb and $FF;
  Result := (r * 77 + g * 150 + b * 29) shr 8; // div 256
end;

function CheckRightToLeftFirstCharEh(S: String; RightToLeftIfUncertain: Boolean): Boolean;
{$IFDEF EH_LIB_12}
var
  MapLocale: LCID;
  arr: array of Integer;
{$ENDIF}
begin
  Result := False;
  if S = '' then Exit;

{$IFDEF EH_LIB_12}
  if CheckWin32Version(5, 1) then
    MapLocale := LOCALE_INVARIANT
  else
    MapLocale := LOCALE_SYSTEM_DEFAULT;

  SetLength(arr, 1);
  arr[0] := 0;
  GetStringTypeEx(MapLocale, CT_CTYPE2, PWideChar(S), 1, arr[0]);

  if arr[0] in [C2_RIGHTTOLEFT, C2_ARABICNUMBER] then
    Result := True
  else if arr[0] = C2_LEFTTORIGHT then
    Result := False
  else
    Result := RightToLeftIfUncertain;
{$ENDIF}
end;

// hilisut
procedure DrawHighlightedSubTextEh(C: TCanvas; AR: TRect; X, Y: Integer;
  T: string; A: TAlignment; La:TTextLayout; ML:Boolean; EE: Boolean;
  L, R: Integer; rlr: Boolean; S: String; CI: Boolean; HC: TColor; Pos: Integer;
  PosC: TColor);
type
  lire = record
    Start: Longint;
    Length: Longint;
    WidthPxl: Longint;
  end;

  dptr = record
    X, Y: Integer;
    StrStart: Longint;
    StrLength: Longint;
    gtdu: Integer;
    liw: Integer;
    lis: Integer;
  end;

var
  SP: TIntegerDynArray;
  cex: TIntegerDynArray;
  i, nlp, olp, Line, wpxl, sw: Integer;
  lsa: array of lire;
  da: array of dptr;
  ddr: TRect;
  gtdu: Integer;
//  ardu: TRect;
  ufdu: Integer;
  Options: Longint;
  RectWidth: Integer;
  MaxChars: Integer;
  StringSize: TSize;
  OldBColor, OldFColor: TColor;
  RTLS: Boolean;
  flh, TopExtra: Integer;

  function geli(s: String; p0, W: Integer; var WidthPxl: Integer): Integer;
  var
    i, cw, ls0, wpxl: Integer;
  begin
    cw := 0;
    ls0 := -1;
    wpxl := 0;
    for i := p0 to Length(S)-1 do
    begin
      if S[i+1] = ' ' then
      begin
        ls0 := i;
        wpxl := cw;
      end;
      Inc(cw, cex[i]);
      if ML and ((S[i+1] = #13) or (S[i+1] = #10)) then
      begin
        if (i+1 < Length(S)-1) and (S[i+2] = #10) and (S[i+1] = #13)
          then Result := i+1
          else Result := i;
        WidthPxl := cw;
        Exit;
      end else if (cw > W) and (ls0 > -1) then
      begin
        if ML then
        begin
          Result := ls0;
          WidthPxl := wpxl;
        end else
        begin
          Result := i;
          WidthPxl := cw;
        end;
        Exit;
      end;
    end;
    Result := Length(S)-1;
    WidthPxl := cw;
  end;

  function tw(Sp, L: Integer): Integer;
  var
    i: Integer;
  begin
    Result := 0;
    for i := Sp to Sp+L-1 do
      Inc(Result, cex[i]);
  end;

  procedure mdarff(Pos: Integer);
  var
    Len: Integer;
    im: Integer;
//    w: Integer;
    dapos: Integer;
  begin
    Len := Length(S);

    for im := 0 to Length(lsa)-1 do
    begin
      if (lsa[im].Start <= Pos) and (lsa[im].Start + lsa[im].Length > Pos) then
      begin
        SetLength(da, Length(da)+1);
        dapos := Length(da)-1;
//        da[dapos].X := C.TextWidth(Copy(T, lsa[im].Start+1, Pos-lsa[im].Start));
        da[dapos].X := tw(lsa[im].Start, Pos-lsa[im].Start);
        {if A = taRightJustify then
        begin
          w := C.TextWidth(Copy(T, lsa[im].Start+1, lsa[im].Length));
          da[Length(da)-1].X := da[Length(da)-1].X +
            (AR.Right - AR.Left - w - 3 - X);
        end else if A = taCenter then
        begin
          w := C.TextWidth(Copy(T, lsa[im].Start+1, lsa[im].Length));
          da[Length(da)-1].X := da[Length(da)-1].X +
            (AR.Right - AR.Left - w - 3 - X) div 2;
        end;}
        da[dapos].Y := StringSize.cy * im;
        da[dapos].StrStart := Pos;
        da[dapos].StrLength := Len;
        da[dapos].gtdu := gtdu;
        da[dapos].liw := lsa[im].WidthPxl;
        if A = taLeftJustify then
          da[dapos].lis := X
        else if A = taRightJustify then
          da[dapos].lis := AR.Right - AR.Left - lsa[im].WidthPxl - X
        else if A = taCenter then
          da[dapos].lis := (AR.Right - AR.Left - lsa[im].WidthPxl) div 2;
      end;
    end;
  end;

  function IsRTLS: Boolean;
{$IFDEF EH_LIB_12}
  var
    MapLocale: LCID;
    arr: array of Integer;
{$ENDIF}
  begin
    Result := False;
    if T = '' then Exit;

{$IFDEF EH_LIB_12}
    if CheckWin32Version(5, 1) then
      MapLocale := LOCALE_INVARIANT
    else
      MapLocale := LOCALE_SYSTEM_DEFAULT;

    SetLength(arr, 1);
    arr[0] := 0;
    GetStringTypeEx(MapLocale, CT_CTYPE2, PWideChar(T), 1, arr[0]);

    if arr[0] in [C2_RIGHTTOLEFT, C2_ARABICNUMBER] then
      Result := True;
{$ENDIF}
  end;

begin
  if not GetAllStrEntry(T, S, SP, CI) then
    Exit;

  RTLS := IsRTLS;
  ufdu := DT_CALCRECT or DT_LEFT or DT_NOPREFIX;
  ddr := Rect(0, 0, 1, 0);
  DrawTextEh(C.Handle, T, Length(T), ddr, ufdu);
  gtdu := ddr.Right - ddr.Left;

  if La <> tlTop then
  begin
    ddr := Rect(0, 0, AR.Right - AR.Left, 0);
    ufdu := DT_CALCRECT or DT_LEFT or DT_NOPREFIX or DT_WORDBREAK;
    DrawTextEh(C.Handle, T, Length(T), ddr, ufdu);
    flh := ddr.Bottom - ddr.Top;
    TopExtra := ((AR.Bottom - AR.Top) div 2) - (flh div 2);
  end else
    TopExtra := Y;

  RectWidth := AR.Right - AR.Left - X*2;
  SetLength(cex, Length(T));
  GetTextExtentExPoint(C.Handle, PChar(T), Length(T),
   10000, //      RectWidth,
   @MaxChars, @cex[0], StringSize);

  for i := Length(T)-1 downto 1 do cex[i] := cex[i] - cex[i-1];

  olp := 0;
  Line := 0;
  while True do
  begin
    nlp := geli(T, olp, RectWidth, wpxl);
    SetLength(lsa, Line+1);
    lsa[Line].Start := olp;
    lsa[Line].Length := nlp - olp + 1;
    lsa[Line].WidthPxl := wpxl;
    Inc(Line);
    if nlp >= Length(T)-1 then
      Break;
    olp := nlp+1;
    if not ML then Break;
  end;

  for i := 0 to Length(SP)-1 do
    mdarff(SP[i]);

  OldBColor := C.Brush.Color;
  OldFColor := C.Font.Color;
  C.Brush.Color := HC;
  C.Font.Color := clWindowText;
  for i := 0 to Length(da)-1 do
  begin
    Options := ETO_CLIPPED;
    ddr := Rect(da[i].X + AR.Left + da[i].lis, da[i].Y + AR.Top + TopExtra, 0, 0);
//    sw := C.TextWidth(Copy(T, da[i].StrStart+1, da[i].StrLength));
    sw := tw(da[i].StrStart, da[i].StrLength);
    ddr.Right := ddr.Left + sw;

    ddr.Bottom := ddr.Top + StringSize.cy;

    if RTLS then
    begin
      ddr.Left := AR.Left + da[i].lis + da[i].liw - da[i].X - sw;
      ddr.Right := ddr.Left + sw;
    end;

    Windows.ExtTextOut(C.Handle,
      ddr.Left, ddr.Top, Options, @ddr,
      @T[da[i].StrStart+1], da[i].StrLength, nil);

  end;

  C.Brush.Color := OldBColor;
  C.Font.Color := OldFColor;
end;

function FieldValueToDispayValue(const AValue: Variant; Field: TField; const ADisplayFormat: String): String;
var
  FmtStr: string;
  Format: TFloatFormat;
  Digits: Integer;
begin
  if VarIsEmpty(AValue) or VarIsNull(AValue) then
  begin
    Result := '';
    Exit;
  end;
  with Field do
  begin
    case DataType of
      ftSmallint, ftInteger, ftAutoInc, ftWord:
        if ADisplayFormat <> '' then
          Result := FormatFloat(ADisplayFormat, AValue)
        else with Field as TIntegerField do
        begin
          FmtStr := DisplayFormat;
          if FmtStr = ''
            then Result := IntToStr(Integer(AValue))
            else Result := FormatFloat(FmtStr, AValue);
        end;
      ftBCD:
        if ADisplayFormat <> '' then
          Result := FormatFloat(ADisplayFormat, AValue)
        else
        with Field as TBCDField do
        begin
        //if EditFormat = '' then FmtStr := DisplayFormat else FmtStr := EditFormat;
          FmtStr := DisplayFormat;
          if FmtStr = '' then
          begin
            if Currency then
            begin
              Format := ffCurrency;
              Digits := FormatSettings.CurrencyDecimals
            end
            else
            begin
              Format := ffGeneral;
              Digits := 0;
            end;
            Result := CurrToStrF(AValue, Format, Digits);
          end else
            Result := FormatCurr(FmtStr, AValue);
        end;
{$IFDEF EH_LIB_6}
      ftFMTBcd:
        if ADisplayFormat <> '' then
          Result := FormatFloat(ADisplayFormat, AValue)
        else
        with Field as TFMTBCDField do
        begin
        //if EditFormat = '' then FmtStr := DisplayFormat else FmtStr := EditFormat;
          FmtStr := DisplayFormat;
          if FmtStr = '' then
          begin
            if Currency then
            begin
              Format := ffCurrency;
              Digits := FormatSettings.CurrencyDecimals
            end
            else
            begin
              Format := ffGeneral;
              Digits := 0;
            end;
            Result := CurrToStrF(AValue, Format, Digits);
          end else
            Result := FormatCurr(FmtStr, AValue);
        end;
{$ENDIF}
      ftFloat, ftCurrency:
        if ADisplayFormat <> '' then
          Result := FormatFloat(ADisplayFormat, AValue)
        else
        with Field as TFloatField do
        begin
       //if EditFormat = '' then FmtStr := DisplayFormat else FmtStr := EditFormat;
          FmtStr := DisplayFormat;
          if FmtStr = '' then
          begin
            if Currency then
            begin
              Format := ffCurrency;
              Digits := FormatSettings.CurrencyDecimals
            end
            else begin
              Format := ffGeneral;
              Digits := 0;
            end;
            Result := FloatToStrF(Double(AValue), Format, Precision, Digits);
          end else
            Result := FormatFloat(FmtStr, AValue);
        end;
      ftDate, ftTime, ftDateTime:
        begin
          if ADisplayFormat <> '' then
            FmtStr := ADisplayFormat
          else
            case DataType of
              ftDate: FmtStr := FormatSettings.ShortDateFormat;
              ftTime: FmtStr := FormatSettings.LongTimeFormat;
            end;
          DateTimeToString(Result, FmtStr, TDateTime(AValue));
        end;
    else
      Result := VarToStr(AValue);
    end;
  end;
end;

procedure BroadcastPerformMessageFor(Owner: TComponent; ForClass: TControlClass;
  Msg: Cardinal; WParam, LParam: Longint);
var
  i: Integer;
begin
  for i := 0 to Owner.ComponentCount-1 do
  begin
    if Owner.Components[i] is ForClass then
    begin
      TControl(Owner.Components[i]).Perform(Msg, WParam, LParam);
    end;
    BroadcastPerformMessageFor(Owner.Components[i], ForClass, Msg, WParam, LParam);
  end;
end;

function IsDoubleClickMessage(OldPos, NewPos: TPoint; Interval: Longint): Boolean;
begin
  Result := (Interval <= Longint(GetDoubleClickTime)) and
            (Abs(OldPos.X - NewPos.X) <= GetSystemMetrics(SM_CXDOUBLECLK)) and
            (Abs(OldPos.Y - NewPos.Y) <= GetSystemMetrics(SM_CYDOUBLECLK));
end;

procedure GetCheckSize;
begin
  with TBitmap.Create do
    try
      Handle := LoadBitmapEh(0, OBM_CHECKBOXES);
      DefaultCheckBoxWidth := Width div 4;
      DefaultCheckBoxHeight := Height div 3;
      DefaultFlatCheckBoxWidth := DefaultCheckBoxWidth - 1;
      DefaultFlatCheckBoxHeight := DefaultCheckBoxHeight - 1;
    finally
      Free;
    end;
end;

function AdjustCheckBoxRect(ClientRect: TRect; Alignment: TAlignment;
  Layout: TTextLayout{; Flat: Boolean}): TRect;
var
  CheckWidth, CheckHeight: Integer;
begin

  if (ClientRect.Right - ClientRect.Left) > DefaultCheckBoxWidth
    then CheckWidth := DefaultCheckBoxWidth
    else CheckWidth := ClientRect.Right - ClientRect.Left;

  if (ClientRect.Bottom - ClientRect.Top) > DefaultCheckBoxHeight
    then CheckHeight := DefaultCheckBoxHeight
    else CheckHeight := ClientRect.Bottom - ClientRect.Top;


  Result := ClientRect;

  if (ClientRect.Right - ClientRect.Left) > DefaultCheckBoxWidth then
    case Alignment of
      taRightJustify: Result.Left := Result.Right - CheckWidth;
      taCenter: Result.Left := Result.Left + (ClientRect.Right - ClientRect.Left) shr 1 - CheckWidth shr 1;
    end;
  Result.Right := Result.Left + CheckWidth;

  if (ClientRect.Bottom - ClientRect.Top) > DefaultCheckBoxHeight then
    case Layout of
      tlBottom: Result.Top := Result.Bottom - CheckWidth;
      tlCenter: Result.Top := Result.Top + (ClientRect.Bottom - ClientRect.Top) shr 1 - CheckHeight shr 1;
    end;
  Result.Bottom := Result.Top + CheckHeight;
end;

procedure DrawCheck(DC: HDC; R: TRect; AState: TCheckBoxState; AEnabled, AFlat, ADown, AActive: Boolean);
var
  DrawState, OldRgn: Integer;
  DrawRect: TRect;
  Rgn, SaveRgn: HRgn;
{$IFDEF EH_LIB_7}
  ElementDetails: TThemedElementDetails;
  Detail: TThemedButton;
{$ENDIF}
begin
  SaveRgn := 0;
  OldRgn := 0;
  DrawRect := R;
  with DrawRect do
    if (Right - Left) > (Bottom - Top) then
    begin
      Left := Left + ((Right - Left) - (Bottom - Top)) div 2;
      Right := Left + (Bottom - Top);
    end else if (Right - Left) < (Bottom - Top) then
    begin
      Top := Top + ((Bottom - Top) - (Right - Left)) div 2;
      Bottom := Top + (Right - Left);
    end;
  case AState of
    cbChecked:
      DrawState := DFCS_BUTTONCHECK or DFCS_CHECKED;
    cbUnchecked:
      DrawState := DFCS_BUTTONCHECK;
  else // cbGrayed
    DrawState := DFCS_BUTTON3STATE or DFCS_CHECKED;
  end;
  if not AEnabled then
    DrawState := DrawState or DFCS_INACTIVE;
  if ADown then
    DrawState := DrawState or DFCS_PUSHED;
//  with Canvas do
//  begin
  if AFlat then
  begin
      { Remember current clipping region }
    SaveRgn := CreateRectRgn(0, 0, 0, 0);
    OldRgn := GetClipRgn(DC, SaveRgn);
      { Clip 3d-style checkbox to prevent flicker }
    if ThemesEnabled then
      with DrawRect do
        Rgn := CreateRectRgn(Left + 2, Top + 2, Right - 2, Bottom - 2)
    else
      with DrawRect do
        Rgn := CreateRectRgn(Left + 1, Top + 1, Right - 1, Bottom - 1);
    SelectClipRgn(DC, Rgn);
    DeleteObject(Rgn);
  end;
  if AFlat and not ThemesEnabled then InflateRect(DrawRect, 1, 1);

{$IFDEF EH_LIB_7}
  if ThemeServices.ThemesEnabled then
  begin
    case AState of
      cbChecked:
        if AEnabled then
          if ADown then Detail := tbCheckBoxCheckedPressed
          else if AActive then Detail := tbCheckBoxCheckedHot
          else Detail := tbCheckBoxCheckedNormal
        else Detail := tbCheckBoxCheckedDisabled;
      cbUnchecked:
        if AEnabled then
          if ADown then Detail := tbCheckBoxUncheckedPressed
          else if AActive then Detail := tbCheckBoxUncheckedHot
          else Detail := tbCheckBoxUncheckedNormal
        else Detail := tbCheckBoxUncheckedDisabled;
      else // cbGrayed
        if AEnabled then
          if ADown then Detail := tbCheckBoxMixedPressed
          else if AActive then Detail := tbCheckBoxMixedHot
          else Detail := tbCheckBoxMixedNormal
        else Detail := tbCheckBoxMixedDisabled;
    end;
    ElementDetails := ThemeServices.GetElementDetails(Detail);
    ThemeServices.DrawElement(DC, ElementDetails, R);
  end
  else
{$ENDIF}
    DrawFrameControl(DC, DrawRect, DFC_BUTTON, DrawState);

  if AFlat then
  begin
      //SelectClipRgn(Handle, SaveRgn);
    if OldRgn = 0 then
      SelectClipRgn(DC, 0)
    else
      SelectClipRgn(DC, SaveRgn);
    DeleteObject(SaveRgn);
      { Draw flat rectangle in-place of clipped 3d checkbox above }
    if ThemesEnabled then
    begin
      InflateRect(DrawRect, -1, -1);
      FrameRect(DC, DrawRect, GetSysColorBrush(COLOR_BTNSHADOW));
    end else
    begin
      InflateRect(DrawRect, -1, -1);
      if AActive
        then FrameRect(DC, DrawRect, GetSysColorBrush(COLOR_BTNFACE))
        else FrameRect(DC, DrawRect, GetSysColorBrush(COLOR_BTNSHADOW));
    end;

  end;
//  end;
end;

const
  DownFlags: array[Boolean] of Integer = (0, DFCS_PUSHED {? or DFCS_FLAT});
  FlatFlags: array[Boolean] of Integer = (0, DFCS_FLAT);
  EnabledFlags: array[Boolean] of Integer = (DFCS_INACTIVE, 0);
  IsDownFlags: array[Boolean] of Integer = (DFCS_SCROLLUP, DFCS_SCROLLDOWN);
  PressedFlags: array[Boolean] of Integer = (EDGE_RAISED, EDGE_SUNKEN);

procedure DrawUserButtonBackground(Canvas: TCanvas; ARect: TRect; ParentColor: TColor;
  Enabled, Active, Flat, Pressed: Boolean);
var
  ElRect: TRect;
  Brush: HBRUSH;
{$IFDEF EH_LIB_7}
  Button: TThemedButton;
  ToolButton: TThemedToolBar;
  Details: TThemedElementDetails;
{$ENDIF}
begin
  ElRect := ARect;

{$IFDEF EH_LIB_7}
  if ThemeServices.ThemesEnabled then
  begin
    Canvas.Brush.Color := ParentColor;
    Canvas.FillRect(ARect);
    if not Enabled then
      Button := tbPushButtonDisabled
    else
      if Pressed then
        Button := tbPushButtonPressed
      else
        if Active
          then Button := tbPushButtonHot
          else Button := tbPushButtonNormal;

    ToolButton := ttbToolbarDontCare;
    if Flat then
    begin
      case Button of
        tbPushButtonDisabled:
          Toolbutton := ttbButtonDisabled;
        tbPushButtonPressed:
          Toolbutton := ttbButtonPressed;
        tbPushButtonHot:
          Toolbutton := ttbButtonHot;
        tbPushButtonNormal:
//          Toolbutton := ttbButtonNormal;
//          Toolbutton := ttbButtonChecked;
          Toolbutton := ttbButtonHot;
      end;
    end;

    if ToolButton = ttbToolbarDontCare then
    begin
      Details := ThemeServices.GetElementDetails(Button);
      ThemeServices.DrawElement(Canvas.Handle, Details, ARect);

      InflateRect(ElRect, -2, -2);
    end else
    begin
      Details := ThemeServices.GetElementDetails(ToolButton);
      ThemeServices.DrawElement(Canvas.Handle, Details, ARect);
//      InflateRect(ElRect, -1, -1)
      InflateRect(ElRect, -2, -2);
    end;
  end else
{$ENDIF}
  begin
    Brush := GetSysColorBrush(COLOR_BTNFACE);
    if Flat then
    begin
      Windows.FillRect(Canvas.Handle, ElRect, Brush);
      InflateRect(ElRect, -1, -1)
    end else
    begin
      DrawEdge(Canvas.Handle, ElRect, PressedFlags[Pressed], BF_RECT or BF_MIDDLE);
      InflateRect(ElRect, -2, -2);
      //Windows.FillRect(DC, ElRect, Brush);
    end;
  end;
end;

procedure DrawEllipsisButton(Canvas: TCanvas; ARect: TRect; Enabled, Active, Flat, Pressed: Boolean);
var
  InterP, PWid, W, H: Integer;
  ElRect: TRect;
  Brush, SaveBrush: HBRUSH;
{$IFDEF EH_LIB_7}
  Button: TThemedButton;
  ToolButton: TThemedToolBar;
  Details: TThemedElementDetails;
{$ENDIF}
  FromColor, ToColor: TColor;
  Points: array of TPoint;
  i: Integer;
begin
  ElRect := ARect;

{$IFDEF EH_LIB_7}
  if ThemeServices.ThemesEnabled then
  begin
    if not Enabled then
      Button := tbPushButtonDisabled
    else
      if Pressed then
        Button := tbPushButtonPressed
      else
        if Active
          then Button := tbPushButtonHot
          else Button := tbPushButtonNormal;

    ToolButton := ttbToolbarDontCare;
    if Flat then
    begin
      case Button of
        tbPushButtonDisabled:
          Toolbutton := ttbButtonDisabled;
        tbPushButtonPressed:
          Toolbutton := ttbButtonPressed;
        tbPushButtonHot:
          Toolbutton := ttbButtonHot;
        tbPushButtonNormal:
//          Toolbutton := ttbButtonNormal;
//          Toolbutton := ttbButtonChecked;
          Toolbutton := ttbButtonHot;
      end;
    end;

    if ToolButton = ttbToolbarDontCare then
    begin
      Details := ThemeServices.GetElementDetails(Button);
      ThemeServices.DrawElement(Canvas.Handle, Details, ARect);

      InflateRect(ElRect, -2, -2);
    end else
    begin
      Details := ThemeServices.GetElementDetails(ToolButton);
      ThemeServices.DrawElement(Canvas.Handle, Details, ARect);
//      InflateRect(ElRect, -1, -1)
      InflateRect(ElRect, -2, -2);
    end;
  end else
{$ENDIF}
  begin
    Brush := GetSysColorBrush(COLOR_BTNFACE);
    if Flat then
    begin
      Windows.FillRect(Canvas.Handle, ElRect, Brush);
      InflateRect(ElRect, -1, -1)
    end else
    begin
      DrawEdge(Canvas.Handle, ElRect, PressedFlags[Pressed], BF_RECT or BF_MIDDLE);
      InflateRect(ElRect, -2, -2);
      //Windows.FillRect(DC, ElRect, Brush);
    end;
  end;

  InterP := 2;
  PWid := 2;
  W := ElRect.Right - ElRect.Left; //+ Ord(not Active and Flat);
  if W < 12 then InterP := 1;
  if W < 8 then PWid := 1;
  W := ElRect.Left + W div 2 - PWid div 2 + Ord(Pressed); 
  H := ElRect.Top + (ElRect.Bottom - ElRect.Top) div 2 - PWid div 2 + Ord(Pressed);

  if not Enabled then
  begin
    Inc(W); Inc(H);
    Brush := GetSysColorBrush(COLOR_BTNHILIGHT);
    SaveBrush := SelectObject(Canvas.Handle, Brush);
    PatBlt(Canvas.Handle, W, H, PWid, PWid, PATCOPY);
    PatBlt(Canvas.Handle, W - InterP - PWid, H, PWid, PWid, PATCOPY);
    PatBlt(Canvas.Handle, W + InterP + PWid, H, PWid, PWid, PATCOPY);
    Dec(W); Dec(H);
    SelectObject(Canvas.Handle, SaveBrush);
    Brush := GetSysColorBrush(COLOR_BTNSHADOW);
  end else
    Brush := GetSysColorBrush(COLOR_BTNTEXT);

  if ThemesEnabled then
  begin
    if Enabled then
    begin
      FromColor := ApproachToColorEh(cl3DDkShadow, clBlack, 30);
      ToColor := ApproachToColorEh(cl3DDkShadow, clWhite, 00);
    end else
    begin
      FromColor := ApproachToColorEh(clGrayText, clWhite, 00);
      ToColor := ApproachToColorEh(clGrayText, clWhite, 30);
    end;
    SetLength(Points, PWid*2);
    for i := 0 to PWid-1 do
    begin
      Points[i*2] := Point(0,i);
      Points[i*2+1] := Point(PWid,i);
    end;
    FillGradientEh(Canvas, Point(W, H), Points, FromColor, ToColor);
    FillGradientEh(Canvas, Point(W - InterP - PWid, H), Points, FromColor, ToColor);
    FillGradientEh(Canvas, Point(W + InterP + PWid, H), Points, FromColor, ToColor);
  end else
  begin
    SaveBrush := SelectObject(Canvas.Handle, Brush);
    PatBlt(Canvas.Handle, W, H, PWid, PWid, PATCOPY);
    PatBlt(Canvas.Handle, W - InterP - PWid, H, PWid, PWid, PATCOPY);
    PatBlt(Canvas.Handle, W + InterP + PWid, H, PWid, PWid, PATCOPY);
    SelectObject(Canvas.Handle, SaveBrush);
  end;
end;

procedure DrawPlusMinusButton(Canvas: TCanvas; ARect: TRect; Enabled, Active, Flat, Pressed, Plus: Boolean);
var PWid, PHet, W, H, PlusInd, MinWH: Integer;
  ElRect: TRect;
  Brush, SaveBrush: HBRUSH;
{$IFDEF EH_LIB_7}
  Button: TThemedButton;
  ToolButton: TThemedToolBar;
  Details: TThemedElementDetails;
{$ENDIF}
  FromColor, ToColor: TColor;
  Points: array of TPoint;
  i,iv: Integer;
begin
  ElRect := ARect;

{$IFDEF EH_LIB_7}
  if ThemeServices.ThemesEnabled then
  begin
    if not Enabled then
      Button := tbPushButtonDisabled
    else
      if Pressed then
        Button := tbPushButtonPressed
      else
        if Active
          then Button := tbPushButtonHot
          else Button := tbPushButtonNormal;

    ToolButton := ttbToolbarDontCare;
    if Flat then
    begin
      case Button of
        tbPushButtonDisabled:
          Toolbutton := ttbButtonDisabled;
        tbPushButtonPressed:
          Toolbutton := ttbButtonPressed;
        tbPushButtonHot:
          Toolbutton := ttbButtonHot;
        tbPushButtonNormal:
//          Toolbutton := ttbButtonNormal;
//          Toolbutton := ttbButtonChecked;
          Toolbutton := ttbButtonHot;
      end;
    end;

    if ToolButton = ttbToolbarDontCare then
    begin
      Details := ThemeServices.GetElementDetails(Button);
      ThemeServices.DrawElement(Canvas.Handle, Details, ARect);
//      ARect := ThemeServices.ContentRect(DC, Details, ARect);
      InflateRect(ElRect, -2, -2);
    end else
    begin
      Details := ThemeServices.GetElementDetails(ToolButton);
      ThemeServices.DrawElement(Canvas.Handle, Details, ARect);
//      InflateRect(ElRect, -1, -1)
      InflateRect(ElRect, -2, -2);
//      ARect := ThemeServices.ContentRect(DC, Details, ARect);
    end;
  end else
{$ENDIF}
  begin
    Brush := GetSysColorBrush(COLOR_BTNFACE);
    if Flat then
    begin
      Windows.FillRect(Canvas.Handle, ElRect, Brush);
      InflateRect(ElRect, -1, -1)
    end else
    begin
      DrawEdge(Canvas.Handle, ElRect, PressedFlags[Pressed], BF_RECT or BF_MIDDLE);
      InflateRect(ElRect, -2, -2);
      Windows.FillRect(Canvas.Handle, ElRect, Brush);
    end;
  end;

  MinWH := ElRect.Right - ElRect.Left; //+ Ord(not Active and Flat);
  if ElRect.Bottom - ElRect.Top < MinWH then
    MinWH := ElRect.Bottom - ElRect.Top;
  PWid := MinWH * 4 div 7;
  if PWid = 0 then PWid := 1;
  PHet := PWid div 3;
  if PHet = 0 then PHet := 1;
  if Flat then Dec(PWid);
  if PWid mod 2 <> MinWH mod 2 then Inc(PWid);
  if Plus and (PWid mod 2 <> PHet mod 2) then
    if (MinWH < 12) then Inc(PWid) else Dec(PWid);
  PlusInd := PWid div 2 - PHet div 2;

  W := ElRect.Left + (ElRect.Right - ElRect.Left - PWid) div 2; 
  //if W * 2 + PWid > (ElRect.Right - ElRect.Left) then Dec(W);
  Inc(W, Ord(Pressed));
  H := ElRect.Top + (ElRect.Bottom - ElRect.Top - PHet) div 2 + Ord(Pressed);

  if not Enabled then
  begin
    Inc(W); Inc(H);
    Brush := GetSysColorBrush(COLOR_BTNHILIGHT);
    SaveBrush := SelectObject(Canvas.Handle, Brush);
    PatBlt(Canvas.Handle, W, H, PWid, PHet, PATCOPY);
    if Plus then PatBlt(Canvas.Handle, W + PlusInd, H - PlusInd, PHet, PWid, PATCOPY);
    Dec(W); Dec(H);
    SelectObject(Canvas.Handle, SaveBrush);
    Brush := GetSysColorBrush(COLOR_BTNSHADOW);
  end else
    Brush := GetSysColorBrush(COLOR_BTNTEXT);

  if ThemesEnabled then
  begin
    if Enabled then
    begin
      FromColor := ApproachToColorEh(cl3DDkShadow, clBlack, 30);
      ToColor := ApproachToColorEh(cl3DDkShadow, clWhite, 00);
    end else
    begin
      FromColor := ApproachToColorEh(clGrayText, clWhite, 00);
      ToColor := ApproachToColorEh(clGrayText, clWhite, 30);
    end;
    if Plus
      then SetLength(Points, PHet*2+PlusInd*2+PlusInd*2)
      else SetLength(Points, PHet*2);
    iv := -1;
    if Plus then
      for i := 0 to PHet-1 do
      begin
        Points[i*2] := Point(PlusInd, i);
        Points[i*2+1] := Point(PlusInd+PHet, i);
        iv := i;
      end;
    for i := iv+1 to iv+PHet do
    begin
      Points[i*2] := Point(0,i);
      Points[i*2+1] := Point(PWid, i);
      iv := i;
    end;
    if Plus then
      for i := iv+1 to iv+PHet do
      begin
        Points[i*2] := Point(PlusInd,i);
        Points[i*2+1] := Point(PlusInd+PHet, i);
      end;
    if Plus then
      FillGradientEh(Canvas, Point(W, H-PlusInd), Points, FromColor, ToColor)
    else
      FillGradientEh(Canvas, Point(W, H), Points, FromColor, ToColor);
  end else
  begin
    SaveBrush := SelectObject(Canvas.Handle, Brush);
    PatBlt(Canvas.Handle, W, H, PWid, PHet, PATCOPY);
    if Plus then PatBlt(Canvas.Handle, W + PlusInd, H - PlusInd, PHet, PWid, PATCOPY);
    SelectObject(Canvas.Handle, SaveBrush);
  end;
end;

procedure DrawOneCustomButton(Canvas: TCanvas; Style: TDrawButtonControlStyleEh;
  ARect: TRect; Enabled, Active, Flat, Pressed: Boolean; DownDirection: Boolean);
var
  PWid, W, H: Integer;
  AWidth, AHeight, ASize: Integer;
  ElRect: TRect;
  Brush: HBRUSH;
{$IFDEF EH_LIB_7}
  Button: TThemedButton;
  ToolButton: TThemedToolBar;
  Details: TThemedElementDetails;
{$ENDIF}
  FromColor, ToColor, TmpColor: TColor;
  Points: array of TPoint;
  i: Integer;
begin
  if (Style = bcsAltUpDownEh) and ThemesEnabled then
    if DownDirection
      then Dec(ARect.Top)
      else Inc(ARect.Bottom);
  ElRect := ARect;

{$IFDEF EH_LIB_7}
  if ThemeServices.ThemesEnabled then
  begin
    if not Enabled then
      Button := tbPushButtonDisabled
    else
      if Pressed then
        Button := tbPushButtonPressed
      else
        if Active
          then Button := tbPushButtonHot
          else Button := tbPushButtonNormal;

    ToolButton := ttbToolbarDontCare;
    if Flat then
    begin
      case Button of
        tbPushButtonDisabled:
          Toolbutton := ttbButtonDisabled;
        tbPushButtonPressed:
          Toolbutton := ttbButtonPressed;
        tbPushButtonHot:
          Toolbutton := ttbButtonHot;
        tbPushButtonNormal:
//          Toolbutton := ttbButtonNormal;
//          Toolbutton := ttbButtonChecked;
          Toolbutton := ttbButtonHot;
      end;
    end;

    if ToolButton = ttbToolbarDontCare then
    begin
      Details := ThemeServices.GetElementDetails(Button);
      ThemeServices.DrawElement(Canvas.Handle, Details, ARect);

      InflateRect(ElRect, -2, -2);
    end else
    begin
      Details := ThemeServices.GetElementDetails(ToolButton);
      ThemeServices.DrawElement(Canvas.Handle, Details, ARect);
//      InflateRect(ElRect, -1, -1)
      InflateRect(ElRect, -2, -2);
//      ARect := ThemeServices.ContentRect(DC, Details, ARect);
    end;
  end else
{$ENDIF}
  begin
    Brush := GetSysColorBrush(COLOR_BTNFACE);
    if Flat then
    begin
      Windows.FillRect(Canvas.Handle, ElRect, Brush);
      InflateRect(ElRect, -1, -1)
    end else
    begin
      DrawEdge(Canvas.Handle, ElRect, PressedFlags[Pressed], BF_RECT or BF_MIDDLE);
      InflateRect(ElRect, -2, -2);
      //Windows.FillRect(DC, ElRect, Brush);
    end;
  end;

  if ThemesEnabled then
  begin
    if Enabled then
    begin
      FromColor := ApproachToColorEh(cl3DDkShadow, clBlack, 30);
      ToColor := ApproachToColorEh(cl3DDkShadow, clWhite, 00);
    end else
    begin
      FromColor := ApproachToColorEh(clGrayText, clWhite, 00);
      ToColor := ApproachToColorEh(clGrayText, clWhite, 30);
    end;
    if not DownDirection then
    begin
      TmpColor := FromColor;
      FromColor := ToColor;
      ToColor := TmpColor;
    end;
  end else
  begin
    if Enabled then
    begin
      FromColor := clWindowText;
      ToColor := clWindowText;
    end else
    begin
      FromColor := clGrayText;
      ToColor := clGrayText;
    end
  end;

//  if Style = bcsAltDropDownEh then
  begin
    AWidth := ARect.Right-ARect.Left;
    AHeight := ARect.Bottom-ARect.Top;
    if AHeight < AWidth
      then ASize := AHeight
      else ASize := AWidth;
    if ASize >= 19 then
      PWid := 9
    else if ASize >= 16 then
      PWid := 7
    else if ASize >= 12 then
      PWid := 5
    else if not ThemesEnabled then
      PWid := 3
    else
      PWid := 5;

    SetLength(Points, (PWid div 2 + 1)*2);
    for i := 0 to PWid div 2 do
      if DownDirection then
      begin
        Points[i*2] := Point(i,i);
        Points[i*2+1] := Point(PWid-i,i);
      end else
      begin
        Points[i*2] := Point(PWid div 2 - i, i);
        Points[i*2+1] := Point(PWid div 2 + i + 1, i);
      end;
    W := (ARect.Right + ARect.Left - PWid) shr 1;
    H := (ARect.Top + ARect.Bottom - (PWid div 2 + 1)) shr 1;
  end;
  if Pressed then
  begin
    Inc(W); Inc(H);
  end;
  FillGradientEh(Canvas, Point(W, H), Points, FromColor, ToColor);
end;

procedure DrawCustomButton(Canvas: TCanvas; Style: TDrawButtonControlStyleEh;
  ARect: TRect; Enabled, Active, Flat, Pressed, DownDirection: Boolean);
var
  ButtonRect1, ButtonRect2: TRect;
begin
  if Style = bcsAltDropDownEh then
    DrawOneCustomButton(Canvas, Style, ARect, Enabled, Active, Flat, Pressed, True)
  else if Style = bcsAltUpDownEh then
  begin
    ButtonRect1 := ARect;
    ButtonRect1.Bottom := (ARect.Bottom + ARect.Top) div 2;
    if ThemesEnabled then
      Inc(ButtonRect1.Bottom);
    DrawOneCustomButton(Canvas, Style, ButtonRect1, Enabled, Active, Flat, Pressed and not DownDirection, False);
    ButtonRect2 := ARect;
    ButtonRect2.Top := (ARect.Bottom + ARect.Top) div 2 + 1;
    if ThemesEnabled then
      Dec(ButtonRect2.Top);
    DrawOneCustomButton(Canvas, Style, ButtonRect2, Enabled, Active, Flat, Pressed and DownDirection, True);
  end;
end;

procedure DrawDropDownButton(DC: HDC; ARect: TRect; Enabled, Flat, Active, Down: Boolean);
var
  Flags: Integer;
{$IFDEF EH_LIB_7}
  Details: TThemedElementDetails;
{$ENDIF}
begin
{$IFDEF EH_LIB_7}
  if ThemeServices.ThemesEnabled then
  begin
    if not Enabled then
      Details := ThemeServices.GetElementDetails(tcDropDownButtonDisabled)
    else
      if Down then
        Details := ThemeServices.GetElementDetails(tcDropDownButtonPressed)
      else
        if Active
          then Details := ThemeServices.GetElementDetails(tcDropDownButtonHot)
          else Details := ThemeServices.GetElementDetails(tcDropDownButtonNormal);

    ThemeServices.DrawElement(DC, Details, ARect);

  end else
{$ENDIF}
  begin
    Flags := DownFlags[Down] or FlatFlags[Flat] or EnabledFlags[Enabled];
    DrawFrameControl(DC, ARect, DFC_SCROLL, Flags or DFCS_SCROLLCOMBOBOX);
  end;
end;

procedure DrawUpDownButton(Canvas: TCanvas; ARect: TRect; Enabled, Flat, Active, Down, DownDirection: Boolean);
var
  Flags: Integer;
{$IFDEF EH_LIB_7}
  Details: TThemedElementDetails;
{$ENDIF}
begin
{$IFDEF EH_LIB_7}
  if ThemeServices.ThemesEnabled then
  begin
    if DownDirection then
      if not Enabled then
        Details := ThemeServices.GetElementDetails(tsDownDisabled)
      else
        if Down then
          Details := ThemeServices.GetElementDetails(tsDownPressed)
        else
          if Active
            then Details := ThemeServices.GetElementDetails(tsDownHot)
            else Details := ThemeServices.GetElementDetails(tsDownNormal)
    else
      if not Enabled then
        Details := ThemeServices.GetElementDetails(tsUpDisabled)
      else
        if Down then
          Details := ThemeServices.GetElementDetails(tsUpPressed)
        else
          if Active
            then Details := ThemeServices.GetElementDetails(tsUpHot)
            else Details := ThemeServices.GetElementDetails(tsUpNormal);
    ThemeServices.DrawElement(Canvas.Handle, Details, ARect);
  end else
{$ENDIF}
  begin
    Flags := DownFlags[Down] or FlatFlags[Flat] or EnabledFlags[Enabled];
    DrawFrameControl(Canvas.Handle, ARect, DFC_SCROLL, Flags or IsDownFlags[DownDirection]);
  end;
end;

procedure DrawOneButton(Canvas: TCanvas; Style: TDrawButtonControlStyleEh;
  ARect: TRect; Enabled, Flat, Active, Down, DownDirection: Boolean);
var
  Rgn, SaveRgn: HRgn;
  r: Integer;
  IsClipRgn: Boolean;
  DRect: TRect;
begin
  DRect := ARect;
  WindowsLPtoDP(Canvas.Handle, DRect);

{$IFDEF EH_LIB_7}
  IsClipRgn := Flat and Active and not ThemeServices.ThemesEnabled;
{$ELSE}
  IsClipRgn := Flat and Active;
{$ENDIF}
  r := 0; SaveRgn := 0;
  if IsClipRgn then
  begin
    SaveRgn := CreateRectRgn(0, 0, 0, 0);
    r := GetClipRgn(Canvas.Handle, SaveRgn);
    with DRect do
      Rgn := CreateRectRgn(Left + 1, Top + 1, Right - 1, Bottom - 1);
    SelectClipRgn(Canvas.Handle, Rgn);
    DeleteObject(Rgn);
  end;

  if Flat {$IFDEF EH_LIB_7} and not ThemeServices.ThemesEnabled {$ENDIF} then
    if not Active {and not (Style=bcsUpDownEh)}
      then InflateRect(ARect, 2, 2)
      else InflateRect(ARect, 1, 1);
  case Style of
    bcsDropDownEh: DrawDropDownButton(Canvas.Handle, ARect, Enabled, Flat, Active, Down);
    bcsEllipsisEh: DrawEllipsisButton(Canvas, ARect, Enabled, Active, Flat, Down);
    bcsUpDownEh: DrawUpDownButton(Canvas, ARect, Enabled, Flat, Active, Down, DownDirection);
    bcsMinusEh, bcsPlusEh: DrawPlusMinusButton(Canvas, ARect, Enabled, Active, Flat, Down, bcsPlusEh = Style);
    bcsAltDropDownEh: DrawCustomButton(Canvas, Style, ARect, Enabled, Active, Flat, Down, False);
    bcsAltUpDownEh: DrawOneCustomButton(Canvas, Style, ARect, Enabled, Active, Flat, Down, DownDirection);
  end;
  if Flat then
    if not Active {and not (Style=bcsUpDownEh)}
      then InflateRect(ARect, -2, -2)
      else InflateRect(ARect, -1, -1);

  if IsClipRgn then
  begin
    if r = 0
      then SelectClipRgn(Canvas.Handle, 0)
      else SelectClipRgn(Canvas.Handle, SaveRgn);
    DeleteObject(SaveRgn);
    if Down
      then DrawEdge(Canvas.Handle, ARect, BDR_SUNKENOUTER, BF_RECT)
      else DrawEdge(Canvas.Handle, ARect, BDR_RAISEDINNER, BF_RECT)
  end;
end;

type
//  PPoints = ^TPoints;
//  TPoints = array[0..0] of TPoint;

  TButtonBitmapInfoEh = record
    Size: TPoint;
    BitmapType: TDrawButtonControlStyleEh;
    Flat: Boolean;
    Pressed: Boolean;
    Active: Boolean;
    Enabled: Boolean;
    DownDirect: Boolean;
    CheckState: TCheckBoxState;
  end;

  function CompareButtonBitmapInfo(Info1, Info2: TButtonBitmapInfoEh): Boolean;
  begin
    Result := (Info1.Size.X = Info2.Size.X) and (Info1.Size.Y = Info2.Size.Y)
      and (Info1.BitmapType = Info2.BitmapType)
      and (Info1.Flat = Info2.Flat)
      and (Info1.Pressed = Info2.Pressed)
      and (Info1.Active = Info2.Active)
      and (Info1.Enabled = Info2.Enabled)
      and (Info1.DownDirect = Info2.DownDirect)
      and (Info1.CheckState = Info2.CheckState);
  end;

type

  { TButtonsBitmapCache }

  TButtonBitmapInfoBitmapEh = class(TObject)
  public
    BitmapInfo: TButtonBitmapInfoEh;
    Bitmap: TBitmap;
  end;

  TButtonsBitmapCache = class(TObjectList)
  private
    function Get(Index: Integer): TButtonBitmapInfoBitmapEh;
  public
    constructor Create; overload;
    procedure Clear; override;
    function GetButtonBitmap(ButtonBitmapInfo: TButtonBitmapInfoEh): TBitmap;
    property Items[Index: Integer]: TButtonBitmapInfoBitmapEh read Get {write Put}; default;
  end;

var ButtonsBitmapCache: TButtonsBitmapCache;

procedure ClearButtonsBitmapCache;
begin
  ButtonsBitmapCache.Clear;
end;

function RectSize(ARect: TRect): TSize;
begin
  Result.cx := ARect.Right - ARect.Left;
  Result.cy := ARect.Bottom - ARect.Top;
end;

procedure PaintEditButtonBackgroundEh(Canvas: TCanvas; ARect: TRect; ParentColor: TColor;
  Pressed, Flat, Active, Enabled: Boolean; State: TCheckBoxState);
var
  Rgn, SaveRgn: HRgn;
  r: Integer;
  IsClipRgn: Boolean;
  DRect: TRect;
  ElRect: TRect;
  Brush: HBRUSH;
{$IFDEF EH_LIB_7}
  Button: TThemedButton;
  ToolButton: TThemedToolBar;
  Details: TThemedElementDetails;
{$ENDIF}
begin
  DRect := ARect;
  WindowsLPtoDP(Canvas.Handle, DRect);

{$IFDEF EH_LIB_7}
  IsClipRgn := Flat and Active and not ThemeServices.ThemesEnabled;
{$ELSE}
  IsClipRgn := Flat and Active;
{$ENDIF}
  r := 0; SaveRgn := 0;
  if IsClipRgn then
  begin
    SaveRgn := CreateRectRgn(0, 0, 0, 0);
    r := GetClipRgn(Canvas.Handle, SaveRgn);
    with DRect do
      Rgn := CreateRectRgn(Left + 1, Top + 1, Right - 1, Bottom - 1);
    SelectClipRgn(Canvas.Handle, Rgn);
    DeleteObject(Rgn);
  end;

  if Flat {$IFDEF EH_LIB_7} and not ThemeServices.ThemesEnabled {$ENDIF} then
    if not Active {and not (Style=bcsUpDownEh)}
      then InflateRect(ARect, 2, 2)
      else InflateRect(ARect, 1, 1);

  ElRect := ARect;

{$IFDEF EH_LIB_7}
  if ThemeServices.ThemesEnabled then
  begin
    if not Enabled then
      Button := tbPushButtonDisabled
    else
      if Pressed then
        Button := tbPushButtonPressed
      else
        if Active
          then Button := tbPushButtonHot
          else Button := tbPushButtonNormal;

    ToolButton := ttbToolbarDontCare;
    if Flat then
    begin
      case Button of
        tbPushButtonDisabled:
          Toolbutton := ttbButtonDisabled;
        tbPushButtonPressed:
          Toolbutton := ttbButtonPressed;
        tbPushButtonHot:
          Toolbutton := ttbButtonHot;
        tbPushButtonNormal:
          Toolbutton := ttbButtonHot;
      end;
    end;

    if ParentColor <> clNone then
    begin
      Canvas.Brush.Color := ParentColor;
      Canvas.FillRect(ARect);
    end;

    if ToolButton = ttbToolbarDontCare then
    begin
      Details := ThemeServices.GetElementDetails(Button);
      ThemeServices.DrawElement(Canvas.Handle, Details, ARect);

      InflateRect(ElRect, -2, -2);
    end else
    begin
      Details := ThemeServices.GetElementDetails(ToolButton);
      ThemeServices.DrawElement(Canvas.Handle, Details, ARect);
//      InflateRect(ElRect, -1, -1)
      InflateRect(ElRect, -2, -2);
    end;
  end else
{$ENDIF}
  begin
    Brush := GetSysColorBrush(COLOR_BTNFACE);
    if Flat then
    begin
      Windows.FillRect(Canvas.Handle, ElRect, Brush);
      InflateRect(ElRect, -1, -1)
    end else
    begin
      DrawEdge(Canvas.Handle, ElRect, PressedFlags[Pressed], BF_RECT or BF_MIDDLE);
      InflateRect(ElRect, -2, -2);
      //Windows.FillRect(DC, ElRect, Brush);
    end;
  end;

  if Flat then
    if not Active
      then InflateRect(ARect, -2, -2)
      else InflateRect(ARect, -1, -1);

  if IsClipRgn then
  begin
    if r = 0
      then SelectClipRgn(Canvas.Handle, 0)
      else SelectClipRgn(Canvas.Handle, SaveRgn);
    DeleteObject(SaveRgn);
    if Pressed
      then DrawEdge(Canvas.Handle, ARect, BDR_SUNKENOUTER, BF_RECT)
      else DrawEdge(Canvas.Handle, ARect, BDR_RAISEDINNER, BF_RECT)
  end;
end;

procedure PaintButtonControlEh(Canvas: TCanvas; ARect: TRect; ParentColor: TColor;
  Style: TDrawButtonControlStyleEh; DownButton: Integer;
  Flat, Active, Enabled: Boolean; State: TCheckBoxState);
var
  Rgn, SaveRgn: HRgn;
  HalfRect, DRect: TRect;
  ASize: TSize;
  r: Integer;
  Brush: HBRUSH;
  IsClipRgn: Boolean;
  BitmapInfo: TButtonBitmapInfoEh;
  Bitmap: TBitmap;
begin
  SaveRgn := 0; r := 0;
  BitmapInfo.BitmapType := Style;
  BitmapInfo.Flat := Flat;

  if Style = bcsCheckboxEh then
  begin
    ASize := RectSize(ARect);
    if ASize.cx < ASize.cy then
    begin
      ARect.Top := ARect.Top + (ASize.cy - ASize.cx) div 2;
      ARect.Bottom := ARect.Bottom - (ASize.cy - ASize.cx) div 2 - (ASize.cy - ASize.cx) mod 2;
    end else if ASize.cx > ASize.cy then
    begin
      ARect.Left := ARect.Left + (ASize.cx - ASize.cy) div 2;
      ARect.Right := ARect.Right - (ASize.cx - ASize.cy) div 2 - (ASize.cx - ASize.cy) mod 2;
    end;

    if Flat and not ThemesEnabled then InflateRect(ARect, -1, -1);
    if UseButtonsBitmapCache then
    begin
      BitmapInfo.Size := Point(ARect.Right - ARect.Left, ARect.Bottom - ARect.Top);
      BitmapInfo.CheckState := State;
      BitmapInfo.Pressed := DownButton <> 0;
      BitmapInfo.Active := Active;
      BitmapInfo.Enabled := Enabled;
      Bitmap := ButtonsBitmapCache.GetButtonBitmap(BitmapInfo);

      StretchBlt(Canvas.Handle, ARect.Left, ARect.Top, ARect.Right - ARect.Left,
        ARect.Bottom - ARect.Top, Bitmap.Canvas.Handle, 0, 0,
        Bitmap.Width, Bitmap.Height, cmSrcCopy);
    end else
      DrawCheck(Canvas.Handle, ARect, State, Enabled, Flat, DownButton <> 0, Active);

    if Flat then
    begin
      if not ThemesEnabled then
        InflateRect(ARect, 1, 1);
      if Active and not ThemesEnabled then
        DrawEdge(Canvas.Handle, ARect, BDR_SUNKENOUTER, BF_RECT)
      else
      begin
//        FrameRect(DC, ARect, GetCurrentObject(DC, OBJ_BRUSH));
        Brush := CreateSolidBrush(ColorToRGB(ParentColor));
        FrameRect(Canvas.Handle, ARect, Brush);
        DeleteObject(Brush);
      end;
    end;
  end else
  begin
    BitmapInfo.Active := Active;
    BitmapInfo.Enabled := Enabled;

{$IFDEF EH_LIB_7}
    IsClipRgn := Flat and not Active and not ThemeServices.ThemesEnabled;
{$ELSE}
    IsClipRgn := Flat and not Active;
{$ENDIF}
    if IsClipRgn then
    begin
      DRect := ARect;
      WindowsLPtoDP(Canvas.Handle, DRect);
      InflateRect(ARect, -1, -1);
      if not UseButtonsBitmapCache then
      begin
        SaveRgn := CreateRectRgn(0, 0, 0, 0);
        r := GetClipRgn(Canvas.Handle, SaveRgn);
        with DRect do
          Rgn := CreateRectRgn(Left + 1, Top + 1, Right - 1, Bottom - 1);
        SelectClipRgn(Canvas.Handle, Rgn);
        DeleteObject(Rgn);
      end;
    end;

    if Style in [bcsUpDownEh, bcsAltUpDownEh] then
    begin
      if IsClipRgn then InflateRect(ARect, 1, 1);
      HalfRect := ARect;
      with HalfRect do
        Bottom := Top + (Bottom - Top) div 2;
      if IsClipRgn then InflateRect(HalfRect, -1, -1);
      if UseButtonsBitmapCache then
      begin
        BitmapInfo.Size := Point(HalfRect.Right - HalfRect.Left, HalfRect.Bottom - HalfRect.Top);
        BitmapInfo.Pressed := DownButton = 1;
        BitmapInfo.DownDirect := False;
        Bitmap := ButtonsBitmapCache.GetButtonBitmap(BitmapInfo);
        StretchBlt(Canvas.Handle, HalfRect.Left, HalfRect.Top, HalfRect.Right - HalfRect.Left,
          HalfRect.Bottom - HalfRect.Top, Bitmap.Canvas.Handle, 0, 0,
          Bitmap.Width, Bitmap.Height, cmSrcCopy);
      end else
        DrawOneButton(Canvas, Style, HalfRect, Enabled, Flat, Active, DownButton = 1, False);
      if IsClipRgn then InflateRect(HalfRect, 1, 1);
      HalfRect.Bottom := ARect.Bottom;
      with HalfRect do
        Top := Bottom - (Bottom - Top) div 2;
      if IsClipRgn then InflateRect(HalfRect, -1, -1);
      if UseButtonsBitmapCache then
      begin
        BitmapInfo.Size := Point(HalfRect.Right - HalfRect.Left, HalfRect.Bottom - HalfRect.Top);
        BitmapInfo.Pressed := DownButton = 2;
        BitmapInfo.DownDirect := True;
        Bitmap := ButtonsBitmapCache.GetButtonBitmap(BitmapInfo);
        StretchBlt(Canvas.Handle, HalfRect.Left, HalfRect.Top, HalfRect.Right - HalfRect.Left,
          HalfRect.Bottom - HalfRect.Top, Bitmap.Canvas.Handle, 0, 0,
          Bitmap.Width, Bitmap.Height, cmSrcCopy);
      end else
        DrawOneButton(Canvas, Style, HalfRect, Enabled, Flat, Active, DownButton = 2, True);
      if IsClipRgn
        then InflateRect(ARect, -1, -1);
      if ((ARect.Bottom - ARect.Top) mod 2 = 1) or (IsClipRgn) then
      begin
        HalfRect := ARect;
        HalfRect.Top := (HalfRect.Bottom + HalfRect.Top) div 2;
        HalfRect.Bottom := HalfRect.Top;
        if (ARect.Bottom - ARect.Top) mod 2 = 1 then Inc(HalfRect.Bottom);
        if IsClipRgn then InflateRect(HalfRect, 0, 1);
        Brush := CreateSolidBrush(ColorToRGB(ParentColor));
        FillRect(Canvas.Handle, HalfRect, Brush);
        DeleteObject(Brush);
      end;
    end else if UseButtonsBitmapCache then
    begin
      BitmapInfo.Size := Point(ARect.Right - ARect.Left, ARect.Bottom - ARect.Top);
      BitmapInfo.Pressed := DownButton <> 0;
      Bitmap := ButtonsBitmapCache.GetButtonBitmap(BitmapInfo);
      StretchBlt(Canvas.Handle, ARect.Left, ARect.Top, ARect.Right - ARect.Left,
        ARect.Bottom - ARect.Top, Bitmap.Canvas.Handle, 0, 0,
        Bitmap.Width, Bitmap.Height, cmSrcCopy);
    end else
      DrawOneButton(Canvas, Style, ARect, Enabled, Flat, Active, DownButton <> 0, True);

    if IsClipRgn then
    begin
      InflateRect(ARect, 1, 1);
      if not UseButtonsBitmapCache then
      begin
        if r = 0
          then SelectClipRgn(Canvas.Handle, 0)
          else SelectClipRgn(Canvas.Handle, SaveRgn);
        DeleteObject(SaveRgn);
      end;
      Brush := CreateSolidBrush(ColorToRGB(ParentColor));
      FrameRect(Canvas.Handle, ARect, Brush);
      DeleteObject(Brush);
    end;
  end;
end;

function GetDefaultFlatButtonWidth: Integer;
var
  DC: HDC;
  SysMetrics: Windows.TTextMetric;
begin
  DC := GetDC(0);
  GetTextMetrics(DC, SysMetrics);
  ReleaseDC(0, DC);
  Result := Round(SysMetrics.tmHeight / 3 * 2);
  if ThemesEnabled then
  begin
    if Result mod 2 = 1 then Inc(Result);
  end else
  begin
    if Result mod 2 = 0 then Inc(Result);
  end;
  if Result > GetSystemMetrics(SM_CXVSCROLL)
    then Result := GetSystemMetrics(SM_CXVSCROLL);
end;

function ClientToScreenRect(Control: TControl): TRect;
begin
  Result.TopLeft := Control.ClientToScreen(Point(0,0));
  Result.Bottom := Result.Top + Control.Height;
  Result.Right := Result.Left + Control.Width;
end;

function DefaultEditButtonHeight(EditButtonWidth: Integer; Flat: Boolean): Integer;
begin
  if Flat
    then Result := Round(EditButtonWidth * 4 / 3)
    else Result := EditButtonWidth;
end;

//{$DEBUGINFO OFF}
function VarEquals(const V1, V2: Variant): Boolean;
var
  i: Integer;
begin
  Result := not (VarIsArray(V1) xor VarIsArray(V2));
  if not Result then Exit;
  Result := False;
  try
    if VarIsArray(V1) and VarIsArray(V2) and
      (VarArrayDimCount(V1) = VarArrayDimCount(V2)) and
      (VarArrayLowBound(V1, 1) = VarArrayLowBound(V2, 1)) and
      (VarArrayHighBound(V1, 1) = VarArrayHighBound(V2, 1))
      then
      for i := VarArrayLowBound(V1, 1) to VarArrayHighBound(V1, 1) do
      begin
        Result := V1[i] = V2[i];
        if not Result then Exit;
      end
    else
      begin
        Result := not (VarIsEmpty(V1) xor VarIsEmpty(V2));
        if not Result
          then Exit
          else Result := (V1 = V2);
      end;
  except
    Result := False;
  end;
end;
//{$DEBUGINFO ON}

{$IFNDEF EH_LIB_6}

function VarCompareValue(const A, B: Variant): TVariantRelationship;
const
  CTruth: array [Boolean] of TVariantRelationship = (vrNotEqual, vrEqual);
var
  LA, LB: TVarData;
begin
  LA := TVarData(A);
  LB := TVarData(B);
  if LA.VType = varEmpty then
    Result := CTruth[LB.VType = varEmpty]
  else if LA.VType = varNull then
    Result := CTruth[LB.VType = varNull]
  else if LB.VType in [varEmpty, varNull] then
    Result := vrNotEqual
  else if A = B then
    Result := vrEqual
  else if A < B then
    Result := vrLessThan
  else
    Result := vrGreaterThan;
end;

{$ENDIF}

function DBVarCompareOneValue(const A, B: Variant): TVariantRelationship;
begin
  if VarIsNull(A) and VarIsNull(B) then
    Result := vrEqual
  else if VarIsNull(A) then
    Result := vrLessThan
  else if VarIsNull(B) then
    Result := vrGreaterThan
  else Result := VarCompareValue(A, B);
end;

function DBVarCompareValue(const A, B: Variant): TVariantRelationship;
var
  i: Integer;
  IsComparable: Boolean;
begin
  Result := vrNotEqual;
  IsComparable := not (VarIsArray(A) xor VarIsArray(B));
  if not IsComparable then Exit;
  if VarIsArray(A) and VarIsArray(B) and
    (VarArrayDimCount(A) = VarArrayDimCount(B)) and
    (VarArrayLowBound(A, 1) = VarArrayLowBound(B, 1)) and
    (VarArrayHighBound(A, 1) = VarArrayHighBound(B, 1))
    then
    for i := VarArrayLowBound(A, 1) to VarArrayHighBound(A, 1) do
    begin
      Result := DBVarCompareOneValue(A[i], B[i]);
      if Result <> vrEqual then Exit;
    end
  else
    Result := DBVarCompareOneValue(A, B);
end;

function AnyVarToStrEh(const V: Variant): String;
var
  i: Integer;
begin
  Result := '';
  if VarIsArray(V) then
    for i := VarArrayLowBound(V, 1) to VarArrayHighBound(V, 1) do
    begin
      if Result = ''
        then Result := AnyVarToStrEh(V[i])
        else Result := Result + ', ' + AnyVarToStrEh(V[i])
    end
  else
    Result := VarToStr(V);
end;

function GetRGBColor(Value: TColor): DWORD;
begin
  Result := ColorToRGB(Value);
  case Result of
    clNone: Result := CLR_NONE;
    clDefault: Result := CLR_DEFAULT;
  end;
end;

procedure DrawImage(DC: HDC; ARect: TRect; Images: TCustomImageList;
  ImageIndex: Integer; Selected: Boolean);
const
  ImageTypes: array[TImageType] of Longint = (0, ILD_MASK);
  ImageSelTypes: array[Boolean] of Longint = (0, ILD_SELECTED);
var CheckedRect, AUnionRect: TRect;
  OldRectRgn, RectRgn: HRGN;
  r, x, y: Integer;
  procedure DrawIm;
  var ABlendColor: TColor;
  begin
    with Images do
      if HandleAllocated then
      begin
        if Selected then ABlendColor := clHighlight
        else ABlendColor := BlendColor;
        {$WARNINGS OFF}
        ImageList_DrawEx(Handle, ImageIndex, DC, x, y, 0, 0,
          GetRGBColor(BkColor), GetRGBColor(ABlendColor),
          ImageTypes[ImageType] or ImageSelTypes[Selected]);
        {$WARNINGS ON}
      end;
  end;
begin
  with Images do
  begin
    x := (ARect.Right + ARect.Left - Images.Width) div 2;
    y := (ARect.Bottom + ARect.Top - Images.Height) div 2;
    CheckedRect := Rect(X, Y, X + Images.Width, Y + Images.Height);
    UnionRect(AUnionRect, CheckedRect, ARect);
    if EqualRect(AUnionRect, ARect) then // ARect containt image
      DrawIm
    else
    begin // Need clip
      OldRectRgn := CreateRectRgn(0, 0, 0, 0);
      r := GetClipRgn(DC, OldRectRgn);
      RectRgn := CreateRectRgn(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
      SelectClipRgn(DC, RectRgn);
      DeleteObject(RectRgn);

      DrawIm;

      if r = 0
        then SelectClipRgn(DC, 0)
        else SelectClipRgn(DC, OldRectRgn);
      DeleteObject(OldRectRgn);
    end;
  end;
end;

function AlignDropDownWindowRect(MasterAbsRect: TRect; DropDownWin: TWinControl; Align: TDropDownAlign): TPoint;
var
  P: TPoint;
  Y: Integer;
  WorkArea: TRect;
  MonInfo: TMonitorInfo;
begin
  P := MasterAbsRect.TopLeft;
  Y := P.Y + (MasterAbsRect.Bottom - MasterAbsRect.Top);

  MonInfo.cbSize := SizeOf(MonInfo);
{$IFDEF CIL}
  GetMonitorInfo(MonitorFromRect(MasterAbsRect, MONITOR_DEFAULTTONEAREST), MonInfo);
{$ELSE}
  GetMonitorInfo(MonitorFromRect(@MasterAbsRect, MONITOR_DEFAULTTONEAREST), @MonInfo);
{$ENDIF}
  WorkArea := MonInfo.rcWork;
//  SystemParametersInfo(SPI_GETWORKAREA, 0, Pointer(@WorkArea), 0);

  if ((Y + DropDownWin.Height > WorkArea.Bottom) and (P.Y - DropDownWin.Height >= WorkArea.Top)) or
    ((P.Y - DropDownWin.Height < WorkArea.Top) and (WorkArea.Bottom - Y < P.Y - WorkArea.Top))
    then
  begin
    if P.Y - DropDownWin.Height < WorkArea.Top then
      DropDownWin.Height := P.Y - WorkArea.Top;
    Y := P.Y - DropDownWin.Height;
    DropDownWin.Perform(cm_SetSizeGripChangePosition, Ord(sgcpToTop), 0);
  end else
  begin
    if Y + DropDownWin.Height > WorkArea.Bottom then
      DropDownWin.Height := WorkArea.Bottom - Y;
    DropDownWin.Perform(cm_SetSizeGripChangePosition, Ord(sgcpToBottom), 0);
  end;

  case Align of
    daRight: Dec(P.X, DropDownWin.Width - (MasterAbsRect.Right - MasterAbsRect.Left));
    daCenter: Dec(P.X, (DropDownWin.Width - (MasterAbsRect.Right - MasterAbsRect.Left)) div 2);
  end;

  if (DropDownWin.Width > WorkArea.Right - WorkArea.Left) then
    DropDownWin.Width := WorkArea.Right - WorkArea.Left;
  if (P.X + DropDownWin.Width > WorkArea.Right) then
  begin
    P.X := WorkArea.Right - DropDownWin.Width;
    DropDownWin.Perform(cm_SetSizeGripChangePosition, Ord(sgcpToLeft), 0);
  end
  else if P.X < WorkArea.Left then
  begin
    P.X := WorkArea.Left;
    DropDownWin.Perform(cm_SetSizeGripChangePosition, Ord(sgcpToRight), 0);
  end else if Align = daRight then
    DropDownWin.Perform(cm_SetSizeGripChangePosition, Ord(sgcpToLeft), 0)
  else
    DropDownWin.Perform(cm_SetSizeGripChangePosition, Ord(sgcpToRight), 0);

  Result := Point(P.X, Y);
end;

function AlignDropDownWindow(MasterWin, DropDownWin: TWinControl; Align: TDropDownAlign): TPoint;
var
  MasterAbsRect: TRect;
begin
  MasterAbsRect.TopLeft := MasterWin.Parent.ClientToScreen(Point(MasterWin.Left, MasterWin.Top));
  MasterAbsRect.Bottom := MasterAbsRect.Top + MasterWin.Height;
  MasterAbsRect.Right := MasterAbsRect.Left + MasterWin.Width;
  Result := AlignDropDownWindowRect(MasterAbsRect, DropDownWin, Align);
end;

type
  TIntArray = array[0..16384] of Integer;
  PIntArray = ^TIntArray;

procedure DrawDotLine(Canvas: TCanvas; FromPoint: TPoint; ALength: Integer;
  Along: Boolean; BackDot: Boolean);
var
  Points: array of TPoint;
  StrokeList: array of DWORD;
  DotWidth, DotCount, I: Integer;
begin
  if Along then
  begin
    if ((FromPoint.X mod 2) <> (FromPoint.Y mod 2)) xor BackDot then
    begin
      Inc(FromPoint.X);
      Dec(ALength);
    end;
  end else
  begin
    if ((FromPoint.X mod 2) <> (FromPoint.Y mod 2)) xor BackDot then
    begin
      Inc(FromPoint.Y);
      Dec(ALength);
    end;
  end;

  DotWidth := Canvas.Pen.Width;
  DotCount := ALength div (2 * DotWidth);
  if DotCount < 0 then Exit;
  if ALength mod 2 <> 0 then
    Inc(DotCount);
  SetLength(Points, DotCount * 2); // two points per stroke
  SetLength(StrokeList, DotCount);
  for I := 0 to DotCount - 1 do
    StrokeList[I] := 2;
  if Along then
    for I := 0 to DotCount - 1 do
    begin
      Points[I * 2] := Point(FromPoint.X, FromPoint.Y);
      Points[I * 2 + 1] := Point(FromPoint.X + 1, FromPoint.Y);
      Inc(FromPoint.X, (2 * DotWidth));
    end
  else
    for I := 0 to DotCount - 1 do
    begin
      Points[I * 2] := Point(FromPoint.X, FromPoint.Y);
      Points[I * 2 + 1] := Point(FromPoint.X, FromPoint.Y + 1);
      Inc(FromPoint.Y, (2 * DotWidth));
    end;

{$IFDEF CIL}
  PolyPolyLine(Canvas.Handle, Points, StrokeList, DotCount);
{$ELSE}
  PolyPolyLine(Canvas.Handle, PIntArray(Points)^, PIntArray(StrokeList)^, DotCount);
{$ENDIF}
end;

procedure DrawTreeElement(Canvas: TCanvas; ARect: TRect;
  TreeElement: TTreeElementEh; BackDot: Boolean; ScaleX, ScaleY: Double;
  RightToLeft: Boolean; Coloured: Boolean; GlyphStyle: TTreeViewGlyphStyleEh);
var
  ABoxRect: TRect;
  ACenter: TPoint;
  Square: TRect;
  PBoundRect: PRECT;
  DX: Integer;
  X1, X2, X4, Y1, Y2, Y4: Integer;
{$IFDEF EH_LIB_7}
  Details: TThemedElementDetails;
  TreeviewPlus: TThemedTreeview;
{$ENDIF}
  OldBrushColor: TColor;
{$IFDEF EH_LIB_16}
{$ENDIF}

begin
  ACenter.X := (ARect.Right + ARect.Left) div 2;
  ACenter.Y := (ARect.Bottom + ARect.Top) div 2;
  X1 := Trunc(ScaleX);
  X2 := Trunc(ScaleX*2);
  X4 := Trunc(ScaleX*4);
  Y1 := Trunc(ScaleY);
  Y2 := Trunc(ScaleY*2);
  Y4 := Trunc(ScaleY*4);
  OldBrushColor := clNone;
  Square := ARect;
  if ARect.Bottom - ARect.Top < ARect.Right - ARect.Left then
  begin
    Square.Left := (ARect.Right + ARect.Left) div 2 - (ARect.Bottom - ARect.Top) div 2;
    Square.Right := Square.Left + (ARect.Bottom - ARect.Top);
  end else
  begin
    Square.Top := (ARect.Bottom + ARect.Top) div 2 - (ARect.Right - ARect.Left) div 2;
    Square.Bottom := Square.Top + (ARect.Bottom - ARect.Top);
  end;
  if Square.Bottom - Square.Top <= 15 then
  begin
    DX := 17 - (Square.Bottom - Square.Top);
    InflateRect(Square, DX, DX);
    PBoundRect := @ARect;
  end else
    PBoundRect := nil;

  with Canvas do
  begin
    ABoxRect := Rect(ACenter.X-X4, ACenter.Y-Y4, ACenter.X+X4+1, ACenter.Y+Y4+1);
    if TreeElement in [tehMinusUpDown .. tehPlus] then
    begin
      if Coloured then
      begin
        OldBrushColor := Brush.Color;
        Brush.Color := StyleServices.GetSystemColor(clWindow);
        Pen.Color := StyleServices.GetSystemColor(clBtnShadow);
        Pen.Style := psSolid;
      end;
      if GlyphStyle = tvgsClassicEh then
        if RightToLeft
          then Rectangle(ABoxRect.Left-1, ABoxRect.Top, ABoxRect.Right-1, ABoxRect.Bottom)
          else Rectangle(ABoxRect.Left, ABoxRect.Top, ABoxRect.Right, ABoxRect.Bottom);
      if Coloured then
        Pen.Color := StyleServices.GetSystemColor(clWindowText);
{$IFDEF EH_LIB_7}
      if (GlyphStyle in [tvgsThemedEh, tvgsExplorerThemedEh]) and ThemeServices.ThemesEnabled then
      begin
{$IFDEF EH_LIB_16}
// There as a bug in DrawElement for tcbCategoryGlyph that change font color
// and we don't see it in the Canvas.Font.Color
{        if TStyleManager.IsCustomStyleActive then
        begin
          LStyle := StyleServices;
          if TreeElement in [tehPlusUpDown, tehPlusUp, tehPlusDown, tehPlus]
            then CatBut := tcbCategoryGlyphClosed
            else CatBut := tcbCategoryGlyphOpened;
          Details := LStyle.GetElementDetails(CatBut);
          LStyle.DrawElement(Canvas.Handle, Details, ABoxRect);
        end else}
{$ENDIF}
        begin
          if TreeElement in [tehPlusUpDown, tehPlusUp, tehPlusDown, tehPlus]
            then TreeviewPlus := ttGlyphClosed
            else TreeviewPlus := ttGlyphOpened;
          Details := ThemeServices.GetElementDetails(TreeviewPlus);
          if GlyphStyle = tvgsExplorerThemedEh then
            DrawThemeBackground(ExplorerTreeviewTheme, Canvas.Handle,
              Details.Part, Details.State, Square, PBoundRect)
          else
          {$IFDEF FPC}
            ThemeServices.DrawElement(Canvas.Handle, Details, Square);
          {$ELSE}
            ThemeServices.DrawElement(Canvas.Handle, Details, ABoxRect);
          {$ENDIF}
        end;
      end else
{$ENDIF}
      begin
        MoveTo(ABoxRect.Left + X2, ACenter.Y);
        LineTo(ABoxRect.Right - X2, ACenter.Y);

        if TreeElement in [tehPlusUpDown, tehPlusUp, tehPlusDown, tehPlus] then
        begin
          MoveTo(ACenter.X, ABoxRect.Top + Y2);
          LineTo(ACenter.X, ABoxRect.Bottom - Y2);
        end;
      end;

      if Coloured then
        Pen.Color := StyleServices.GetSystemColor(clBtnShadow);
      if not (TreeElement in [tehMinus, tehPlus]) then
        DrawDotLine(Canvas, Point(ABoxRect.Right + X1, ACenter.Y),
         (ARect.Right - ABoxRect.Right), True, False);

      if TreeElement in [tehMinusUpDown, tehMinusUp, tehPlusUpDown, tehPlusUp] then
        DrawDotLine(Canvas, Point(ACenter.X, ARect.Top), (ABoxRect.Top - ARect.Top), False, BackDot);

      if TreeElement in [tehMinusUpDown, tehMinusDown, tehPlusUpDown, tehPlusDown] then
        DrawDotLine(Canvas, Point(ACenter.X, ABoxRect.Bottom + Y1),
          (ARect.Bottom - ABoxRect.Bottom), False, BackDot);

      if Coloured then
        Brush.Color := OldBrushColor;
    end else
    begin
      if Coloured then
      begin
        Pen.Style := psSolid;
        Pen.Color := StyleServices.GetSystemColor(clBtnShadow);
      end;  
      if TreeElement in [tehCrossUpDown, tehVLine] then
        DrawDotLine(Canvas, Point(ACenter.X, ARect.Top),
          (ARect.Bottom - ARect.Top), False, BackDot);
      if TreeElement in [tehCrossUpDown, tehCrossUp, tehCrossDown] then
        DrawDotLine(Canvas, Point(ACenter.X, ACenter.Y), (ARect.Right - ACenter.X), True, False);
      if TreeElement in [tehCrossDown] then
        DrawDotLine(Canvas, Point(ACenter.X, ACenter.Y), (ARect.Bottom - ACenter.Y), False, BackDot);
      if TreeElement in [tehCrossUp] then
        DrawDotLine(Canvas, Point(ACenter.X, ARect.Top), (ACenter.Y - ARect.Top), False, BackDot);
    end;
  end;
end;

{ TButtonsBitmapCache }

function TButtonsBitmapCache.GetButtonBitmap(ButtonBitmapInfo: TButtonBitmapInfoEh): TBitmap;
var
  i: Integer;
  BitmapInfoBitmap: TButtonBitmapInfoBitmapEh;
begin
  if ButtonBitmapInfo.Size.X < 0 then ButtonBitmapInfo.Size.X := 0;
  if ButtonBitmapInfo.Size.Y < 0 then ButtonBitmapInfo.Size.Y := 0;
  for i := 0 to Count - 1 do
    if CompareButtonBitmapInfo(ButtonBitmapInfo, Items[i].BitmapInfo) then
    begin
      Result := Items[i].Bitmap;
      Exit;
    end;
  BitmapInfoBitmap := TButtonBitmapInfoBitmapEh.Create;
  Add(BitmapInfoBitmap);
  BitmapInfoBitmap.BitmapInfo := ButtonBitmapInfo;
  BitmapInfoBitmap.Bitmap := TBitmap.Create;
  BitmapInfoBitmap.Bitmap.Width := ButtonBitmapInfo.Size.X;
  BitmapInfoBitmap.Bitmap.Height := ButtonBitmapInfo.Size.Y;

  case ButtonBitmapInfo.BitmapType of
    bcsCheckboxEh:
      DrawCheck(BitmapInfoBitmap.Bitmap.Canvas.Handle,
        Rect(0, 0, ButtonBitmapInfo.Size.X, ButtonBitmapInfo.Size.Y),
        ButtonBitmapInfo.CheckState,
        ButtonBitmapInfo.Enabled,
        ButtonBitmapInfo.Flat,
        ButtonBitmapInfo.Pressed,
        ButtonBitmapInfo.Active
        );
    bcsEllipsisEh, bcsUpDownEh, bcsDropDownEh, bcsPlusEh, bcsMinusEh,
    bcsAltDropDownEh, bcsAltUpDownEh:
      DrawOneButton(BitmapInfoBitmap.Bitmap.Canvas, ButtonBitmapInfo.BitmapType,
        Rect(0, 0, ButtonBitmapInfo.Size.X, ButtonBitmapInfo.Size.Y),
        ButtonBitmapInfo.Enabled, ButtonBitmapInfo.Flat,
        ButtonBitmapInfo.Active, ButtonBitmapInfo.Pressed,
        ButtonBitmapInfo.DownDirect);
  end;
  Result := BitmapInfoBitmap.Bitmap;
end;

function TButtonsBitmapCache.Get(Index: Integer): TButtonBitmapInfoBitmapEh;
begin
  Result := TButtonBitmapInfoBitmapEh(inherited Items[Index]);
end;

procedure TButtonsBitmapCache.Clear;
var i: Integer;
begin
  for i := 0 to Count - 1 do
  begin
    Items[i].Bitmap.Free;
    Items[i].Free;
    //Dispose(Items[i]);
  end;
  inherited Clear;
end;

constructor TButtonsBitmapCache.Create;
begin
  inherited Create;
  OwnsObjects := False;
end;

{ TEditButtonControlEh }

procedure TEditButtonControlEh.EditButtonDown(TopButton: Boolean; var AutoRepeat: Boolean);
var Handled: Boolean;
begin
  if Assigned(FOnDown) then
    FOnDown(Self, TopButton, AutoRepeat, Handled);
end;

procedure TEditButtonControlEh.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var AutoRepeat: Boolean;
begin
  if Style in [ebsUpDownEh, ebsAltUpDownEh]
    then AutoRepeat := True
    else AutoRepeat := False;
  inherited MouseDown(Button, Shift, X, Y);
  if (Button = mbLeft) then
  begin
    UpdateDownButtonNum(X, Y);
    if FButtonNum > 0 then
    begin
      EditButtonDown(FButtonNum = 1, AutoRepeat);
      if AutoRepeat then ResetTimer(InitRepeatPause);
    end;
  end;
end;

procedure TEditButtonControlEh.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseMove(Shift, X, Y);
  if MouseCapture and (FStyle in [ebsUpDownEh, ebsAltUpDownEh]) and (FState = bsDown) then
  begin
    if ((FButtonNum = 2) and (Y < (Height div 2))) or
      ((FButtonNum = 1) and (Y > (Height - Height div 2))) then
    begin
      FState := bsUp;
      Invalidate;
    end;
  end;
end;

procedure TEditButtonControlEh.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (FStyle in [ebsUpDownEh, ebsAltUpDownEh]) and (FState <> bsDown) then
    FNoDoClick := True;
  try
    inherited MouseUp(Button, Shift, X, Y);
  finally
    FNoDoClick := False;
  end;
  UpdateDownButtonNum(X, Y);
  if (FTimer <> nil) and FTimer.Enabled then
    FTimer.Enabled := False;
end;

procedure TEditButtonControlEh.UpdateDownButtonNum(X, Y: Integer);
var OldButtonNum: Integer;
begin
  OldButtonNum := FButtonNum;
  if FState in [bsDown, bsExclusive] then
    if FStyle in [ebsUpDownEh, ebsAltUpDownEh] then
    begin
      if Y < (Height div 2) then
        FButtonNum := 1
      else if Y > (Height - Height div 2) then
        FButtonNum := 2
      else
        FButtonNum := 0;
    end
    else FButtonNum := 1
  else
    FButtonNum := 0;
  if FButtonNum <> OldButtonNum then
    Invalidate;
end;

procedure TEditButtonControlEh.DrawButtonText(Canvas: TCanvas; const Caption: string;
  TextBounds: TRect; State: TButtonState; BiDiFlags: LongInt);
var
  TextSize: TPoint;
  TextRect: TRect;
begin
  TextRect := TextBounds;
  DrawTextEh(Canvas.Handle, Caption, Length(Caption), TextRect,
    DT_CALCRECT or BiDiFlags);
  TextSize := Point(TextRect.Right - TextRect.Left, TextRect.Bottom - TextRect.Top);
  TextBounds.Top := (TextBounds.Top + TextBounds.Bottom - TextSize.Y + 1) div 2;
  TextBounds.Bottom := TextBounds.Top + TextSize.Y;
  with Canvas do
  begin
    Brush.Style := bsClear;
    SetBkMode(Canvas.Handle, Windows.TRANSPARENT);
    Font := Self.Font;
    if State = bsDisabled then
    begin
      OffsetRect(TextBounds, 1, 1);
      Font.Color := StyleServices.GetSystemColor(clBtnHighlight);
      DrawTextEh(Handle, Caption, Length(Caption), TextBounds,
        DT_CENTER or DT_VCENTER or BiDiFlags);
      OffsetRect(TextBounds, -1, -1);
      Font.Color := StyleServices.GetSystemColor(clBtnShadow);
      DrawTextEh(Handle, Caption, Length(Caption), TextBounds,
        DT_CENTER or DT_VCENTER or BiDiFlags);
    end else
      DrawTextEh(Handle, Caption, Length(Caption), TextBounds,
        DT_CENTER or DT_VCENTER or BiDiFlags);
  end;
end;

{$IFDEF FPC}
{$ELSE}
type
  TSpeedButtonCrack = class(TGraphicControl)
  protected
    FGroupIndex: Integer;
    FGlyph: TObject;
    FDown: Boolean;
    FDragging: Boolean;
    FAllowAllUp: Boolean;
    FLayout: TButtonLayout;
    FSpacing: Integer;
    FTransparent: Boolean;
    FMargin: Integer;
    FFlat: Boolean;
    FMouseInControl: Boolean;
  end;
{$ENDIF}

procedure TEditButtonControlEh.Paint;
begin
  if Assigned(OnPaint)
    then OnPaint(Self)
    else DefaultPaint;
end;

procedure TEditButtonControlEh.DefaultPaint;
const
  StyleFlags: array[TEditButtonStyleEh] of TDrawButtonControlStyleEh =
  (bcsDropDownEh, bcsEllipsisEh, bcsUpDownEh, bcsUpDownEh, bcsPlusEh, bcsMinusEh,
   bcsAltDropDownEh, bcsAltUpDownEh);
  DownStyles: array[Boolean] of Integer = (BDR_RAISEDINNER, BDR_SUNKENOUTER);
var Rgn, SaveRgn: HRgn;
  r: Integer;
  BRect: TRect;
  IsClipRgn: Boolean;
  AButtonNum: Integer;
  AAcitve: Boolean;
{$IFDEF EH_LIB_7}
  Details: TThemedElementDetails;
//  Button: TThemedButton;
  Button: TThemedToolBar;
{$ENDIF}

//  ThemeRect: TRect;
begin
  AButtonNum := FButtonNum;
  if ThemesEnabled
    then AAcitve := MouseInControl
    else AAcitve := FActive;
{$IFDEF EH_LIB_7}
  IsClipRgn := False;
  SaveRgn := 0;
  r := 0;
{$ENDIF}
  if not (FState in [bsDown, bsExclusive]) then
    AButtonNum := 0;
  //else if AButtonNum = 0 then
  //  AButtonNum := 1;
  if (Style = ebsGlyphEh) and
      (FEditButtonImages <> nil) and
      (FEditButtonImages.NormalImages <> nil) then
  begin
    PaintEditButtonBackgroundEh(Canvas, Rect(0, 0, Width, Height),
(*{$IFDEF CIL}
      Color,
{$ELSE}
      TWinControlCracker(Parent).Color,
{$ENDIF}*)
      clWindow,
      AButtonNum > 0, Flat, AAcitve, Enabled, cbUnchecked);
    DrawImages(Rect(0, 0, Width, Height));
  end else if not (Style = ebsGlyphEh) then
    PaintButtonControlEh(Canvas, Rect(0, 0, Width, Height),
(*{$IFDEF CIL}
      Color,
{$ELSE}
      TWinControlCracker(Parent).Color,
{$ENDIF}*)
      clWindow,
      StyleFlags[Style], AButtonNum,
      Flat, AAcitve, Enabled, cbUnchecked)
  else
  begin
{$IFDEF EH_LIB_7}
    if not ThemeServices.ThemesEnabled then
{$ENDIF}
    begin
      IsClipRgn := Flat;
      BRect := BoundsRect;
      r := 0;
      SaveRgn := 0;
      if IsClipRgn then
      begin
        SaveRgn := CreateRectRgn(0, 0, 0, 0);
        r := GetClipRgn(Canvas.Handle, SaveRgn);
        with BRect do
          Rgn := CreateRectRgn(Left + 1, Top + 1, Right - 1, Bottom - 1);
        SelectClipRgn(Canvas.Handle, Rgn);
        DeleteObject(Rgn);
      end;
    end;

{  // May be better to use Scrollbar Thumb Button for custom edit buttons
   // but also need to use Scrollbar Down Button for DropDown edit button
}
{$IFDEF EH_LIB_7}
    if ThemeServices.ThemesEnabled and Flat and not AAcitve and Enabled and
      not Down and Glyph.Empty then
    begin
      PerformEraseBackground(Self, Canvas.Handle);
//      Button := tbGroupBoxNormal;
      Button := ttbButtonHot;
      Details := ThemeServices.GetElementDetails(Button);
      ThemeServices.DrawElement(Canvas.Handle, Details, ClientRect);
      {$IFDEF FPC}
      DrawButtonText(Canvas, Caption, ClientRect, FState, DrawTextBiDiModeFlags(Self, 0));
      {$ELSE}
      DrawButtonText(Canvas, Caption, ClientRect, FState, DrawTextBiDiModeFlags(0));
      {$ENDIF}
    end else
{$ENDIF}
    begin
{$IFDEF CIL}
// CIL not supported
{$ELSE}
{$IFDEF FPC}
{$ELSE}
      if not Glyph.Empty and ThemesEnabled and Flat then
        TSpeedButtonCrack(Self).FMouseInControl := True;
{$ENDIF}
{$ENDIF}
      inherited Paint;
    end;

{$IFDEF EH_LIB_7}
    if not ThemeServices.ThemesEnabled then
{$ENDIF}
    begin
      if IsClipRgn then
      begin
        if r = 0 then
          SelectClipRgn(Canvas.Handle, 0)
        else
          SelectClipRgn(Canvas.Handle, SaveRgn);
        DeleteObject(SaveRgn);
        OffsetRect(BRect, -Left, -Top);
        if FActive then
          DrawEdge(Canvas.Handle, BRect, DownStyles[FState in [bsDown, bsExclusive]], BF_RECT)
        else
        begin
{$IFDEF CIL}
          Canvas.Brush.Color := Color;
{$ELSE}
          Canvas.Brush.Color := TWinControlCracker(Parent).Color;
{$ENDIF}
          Canvas.FrameRect(BRect);
        end;
      end;
    end;

  end;
end;

procedure TEditButtonControlEh.SetState(NewState: TButtonState; IsActive: Boolean; ButtonNum: Integer);
begin
  if (FState <> NewState) or (IsActive <> FActive) or (ButtonNum <> FButtonNum) then
  begin
    FActive := IsActive;
    FState := NewState;
    FButtonNum := ButtonNum;
    //Invalidate;
    Repaint;
  end;
end;

procedure TEditButtonControlEh.SetStyle(const Value: TEditButtonStyleEh);
begin
  if FStyle <> Value then
  begin
    FStyle := Value;
    Invalidate;
  end;
end;

procedure TEditButtonControlEh.SetWidthNoNotify(AWidth: Integer);
begin
  inherited Width := AWidth;
end;

procedure TEditButtonControlEh.SetActive(const Value: Boolean);
begin
  if Active <> Value then
  begin
    FActive := Value;
    Invalidate;
  end;
end;

procedure TEditButtonControlEh.Click;
begin
  if not FNoDoClick then
  begin
    inherited Click;
  end;
end;

function TEditButtonControlEh.GetTimer: TTimer;
begin
  if FTimer = nil then
  begin
    FTimer := TTimer.Create(Self);
    FTimer.Enabled := False;
    FTimer.OnTimer := TimerEvent;
  end;
  Result := FTimer;
end;

procedure TEditButtonControlEh.ResetTimer(Interval: Cardinal);
begin
  if Timer.Enabled = False then
  begin
    Timer.Interval := Interval;
    Timer.Enabled := True;
  end
  else if Interval <> Timer.Interval then
  begin
    Timer.Enabled := False;
    Timer.Interval := Interval;
    Timer.Enabled := True;
  end;
end;

procedure TEditButtonControlEh.TimerEvent(Sender: TObject);
var AutoRepeat: Boolean;
begin
  if Style in [ebsUpDownEh, ebsAltUpDownEh]
    then AutoRepeat := True
    else AutoRepeat := False;
  if not (FState = bsDown) then Exit;
  if Timer.Interval = Cardinal(InitRepeatPause) then
    ResetTimer(RepeatPause);
  if FState = bsDown then
    EditButtonDown(FButtonNum = 1, AutoRepeat);
  if not AutoRepeat then Timer.Enabled := False;
end;

procedure TEditButtonControlEh.SetAlwaysDown(const Value: Boolean);
begin
  if FAlwaysDown <> Value then
  begin
    FAlwaysDown := Value;
    if Value then
    begin
      GroupIndex := 1;
      Down := True;
      AllowAllUp := False;
      FButtonNum := 1;
    end else
    begin
      AllowAllUp := True;
      Down := False;
      GroupIndex := 0;
      FButtonNum := 0;
    end;
  end;
end;

procedure TEditButtonControlEh.DrawImages(ARect: TRect);
var
  ADrawImages: TCustomImageList;
  AImageIndex: Integer;
  ADrawRect: TRect;
begin
  ADrawImages := FEditButtonImages.GetStateImages(GetState);
  AImageIndex := FEditButtonImages.GetStateIndex(GetState);
  if (ADrawImages <> nil) and (AImageIndex >= 0) then
  begin
    ADrawRect := Rect(0,0,ADrawImages.Width,ADrawImages.Height);
    ADrawRect := CenteredRect(ARect, ADrawRect);
    ADrawRect.Bottom := ADrawRect.Bottom;
    if FButtonNum > 0 then
      OffsetRect(ADrawRect,1,1);
    ADrawImages.Draw(Canvas, ADrawRect.Left, ADrawRect.Top, AImageIndex, Enabled);
  end;
end;

function TEditButtonControlEh.GetState: TEditButtonStateEh;
begin
  Result := ebstNormalEh;
  if not Enabled then
    Result := ebstDisabledEh
  else if (FState = bsUp) and not Down and not MouseInControl then
    Result := ebstNormalEh
  else if (FState = bsUp) and not Down and MouseInControl then
    Result := ebstHotEh
  else if (FState = bsDown) or Down then
    Result := ebstPressedEh;
end;

{ TEditButtonEh }

constructor TEditButtonEh.Create(EditControl: TWinControl);
begin
  inherited Create(nil);
  FEditControl := EditControl;
  FEnabled := True;
  FGlyph := TBitmap.Create;
  FGlyph.Transparent := True;
  FShortCut := scNone; //Menus.ShortCut(VK_DOWN, [ssAlt]); //32808
  FNumGlyphs := 1;
  FImages := TEditButtonImagesEh.Create(Self);
  FDropDownFormParams := CreateDropDownFormParams;
end;

function TEditButtonEh.CreateDropDownFormParams: TDropDownFormCallParamsEh;
begin
  Result := TDropDownFormCallParamsEh.Create;
end;

constructor TEditButtonEh.Create(Collection: TCollection);
begin
  if Assigned(Collection) then Collection.BeginUpdate;
  try
    inherited Create(Collection);
    FEditControl := nil;
    FEnabled := True;
    FGlyph := TBitmap.Create;
    FGlyph.Transparent := True;
    FShortCut := scNone; //Menus.ShortCut(VK_DOWN, [ssAlt]); //32808
    FNumGlyphs := 1;
    FImages := TEditButtonImagesEh.Create(Self);
    FDropDownFormParams := TDropDownFormCallParamsEh.Create;
  finally
    if Assigned(Collection) then Collection.EndUpdate;
  end;
end;

destructor TEditButtonEh.Destroy;
begin
{$IFDEF EH_LIB_6}
  FreeAndNil(FActionLink);
{$ENDIF}
  FreeAndNil(FGlyph);
  FreeAndNil(FImages);
  FreeAndNil(FDropDownFormParams);
  inherited Destroy;
end;

procedure TEditButtonEh.Assign(Source: TPersistent);
begin
  if Source is TEditButtonEh then
  begin
{$IFDEF EH_LIB_6}
    Action :=  TEditButtonEh(Source).Action;
{$ENDIF}
    DropdownMenu := TEditButtonEh(Source).DropdownMenu;
    Enabled :=  TEditButtonEh(Source).Enabled;
    Glyph := TEditButtonEh(Source).Glyph;
    Hint := TEditButtonEh(Source).Hint;
    NumGlyphs := TEditButtonEh(Source).NumGlyphs;
    ShortCut := TEditButtonEh(Source).ShortCut;
    Style := TEditButtonEh(Source).Style;
    Visible := TEditButtonEh(Source).Visible;
    Width := TEditButtonEh(Source).Width;
    OnClick := TEditButtonEh(Source).OnClick;
    OnDown := TEditButtonEh(Source).OnDown;
    Images := TEditButtonEh(Source).Images;
  end else
    inherited Assign(Source);
end;

function TEditButtonEh.GetGlyph: TBitmap;
begin
  Result := FGlyph;
end;

procedure TEditButtonEh.SetGlyph(const Value: TBitmap);
begin
  FGlyph.Assign(Value);
  Changed;
end;

procedure TEditButtonEh.SetNumGlyphs(Value: Integer);
begin
  if Value <= 0 then Value := 1
  else if Value > 4 then Value := 4;
  if Value <> FNumGlyphs then
  begin
    FNumGlyphs := Value;
    Changed;
  end;
end;

procedure TEditButtonEh.SetOnButtonClick(const Value: TButtonClickEventEh);
begin
  if @FOnButtonClick <> @Value then
  begin
    FOnButtonClick := Value;
    Changed;
  end;
end;

procedure TEditButtonEh.SetOnButtonDown(const Value: TButtonDownEventEh);
begin
  if @FOnButtonDown <> @Value then
  begin
    FOnButtonDown := Value;
    Changed;
  end;
end;

procedure TEditButtonEh.SetStyle(const Value: TEditButtonStyleEh);
begin
  if FStyle <> Value then
  begin
    FStyle := Value;
    Changed;
  end;
end;

procedure TEditButtonEh.SetWidth(const Value: Integer);
begin
  if FWidth <> Value then
  begin
    FWidth := Value;
    Changed;
  end;
end;

function TEditButtonEh.GetVisible: Boolean;
begin
  Result := FVisible;
end;

procedure TEditButtonEh.SetVisible(const Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    Changed;
  end;
end;

function TEditButtonEh.CreateEditButtonControl: TEditButtonControlEh;
begin
  Result := TEditButtonControlEh.Create(FEditControl);
  with Result do
  begin
    ControlStyle := ControlStyle + [csReplicatable];
    Width := 10;
    Height := 17;
    Visible := True;
    Transparent := False;
    Parent := FEditControl;
  end;
end;

procedure TEditButtonEh.Changed;
begin
  if Assigned(FOnChanged) then
    FOnChanged(Self)
  else if Assigned(Collection) then
    Changed(False)
end;

procedure TEditButtonEh.RefComponentChanged(RefComponent: TComponent);
begin
  if Assigned(FOnRefComponentChanged) then
    FOnRefComponentChanged(Self, RefComponent)
  else if Assigned(Collection) and Assigned(TEditButtonsEh(Collection).FOnRefComponentChanged) then
    TEditButtonsEh(Collection).OnRefComponentChanged(Self, RefComponent);
end;

procedure TEditButtonEh.SetHint(const Value: String);
begin
  if FHint <> Value then
  begin
    FHint := Value;
    Changed;
  end;
end;

procedure TEditButtonEh.SetEnabled(const Value: Boolean);
begin
  if FEnabled <> Value then
  begin
    FEnabled := Value;
    Changed;
  end;
end;

procedure TEditButtonEh.Click(Sender: TObject; var Handled: Boolean);
begin
  if Assigned(OnClick) then
    OnClick(Sender, Handled)
  else if (ActionLink <> nil) then
  begin
{$IFDEF EH_LIB_6}
    if (FEditControl <> nil) then
      ActionLink.Execute(FEditControl)
    else if Collection.Owner is TComponent then
      ActionLink.Execute(Collection.Owner as TComponent)
    else
      ActionLink.Execute(nil);
{$ELSE}
    ActionLink.Execute;
{$ENDIF}
    Handled := True;
  end;
end;

procedure TEditButtonEh.SetAction(const Value: TBasicAction);
begin
  if Value = nil then
  begin
    FActionLink.Free;
    FActionLink := nil;
  end
  else
  begin
    if FActionLink = nil then
      FActionLink := GetActionLinkClass.Create(Self);
    FActionLink.Action := Value;
    FActionLink.OnChange := DoActionChange;
    ActionChange(Value, csLoading in Value.ComponentState);
//    Value.FreeNotification(Self); ?
  end;
end;

function TEditButtonEh.GetAction: TBasicAction;
begin
  if FActionLink <> nil then
    Result := FActionLink.Action else
    Result := nil
end;

function TEditButtonEh.GetActionLinkClass: TEditButtonActionLinkEhClass;
begin
  Result := TEditButtonActionLinkEh;
end;

procedure TEditButtonEh.DoActionChange(Sender: TObject);
begin
  if Sender = Action then ActionChange(Sender, False);
end;

procedure TEditButtonEh.ActionChange(Sender: TObject; CheckDefaults: Boolean);
begin
  if Sender is TCustomAction then
    with TCustomAction(Sender) do
    begin
      if not CheckDefaults or (Self.Enabled = True) then
        Self.Enabled := Enabled;
      if not CheckDefaults or (Self.Hint = '') then
        Self.Hint := Hint;
      if not CheckDefaults or (Self.ShortCut = scNone) then
        Self.ShortCut := ShortCut;
      if not CheckDefaults or (Self.Visible = True) then
        Self.Visible := Visible;
    end;
end;

procedure TEditButtonEh.InitiateAction;
begin
  if FActionLink <> nil then FActionLink.Update;
end;

function TEditButtonEh.IsEnabledStored: Boolean;
begin
  Result := (ActionLink = nil) or not FActionLink.IsEnabledLinked;
end;

function TEditButtonEh.IsHintStored: Boolean;
begin
  Result := (ActionLink = nil) or not FActionLink.IsHintLinked;
end;

function TEditButtonEh.IsShortCutStored: Boolean;
begin
  Result := (ActionLink = nil) or not FActionLink.IsShortCutLinked;
end;

function TEditButtonEh.IsVisibleStored: Boolean;
begin
  Result := (ActionLink = nil) or not FActionLink.IsVisibleLinked;
end;

procedure TEditButtonEh.SetImages(const Value: TEditButtonImagesEh);
begin
  FImages.Assign(Value);
end;

procedure TEditButtonEh.SetDropDownFormParams(const Value: TDropDownFormCallParamsEh);
begin
  FDropDownFormParams.Assign(Value);
end;

procedure TEditButtonEh.SetDropdownMenu(const Value: TPopupMenu);
begin
  if FDropdownMenu <> Value then
  begin
    FDropdownMenu := Value;
    Changed;
  end;
end;

function TEditButtonEh.GetDefaultAction: Boolean;
begin
  if FDefaultActionStored
    then Result := FDefaultAction
    else Result := FParentDefinedDefaultAction;
end;

procedure TEditButtonEh.SetDefaultAction(const Value: Boolean);
begin
  FDefaultAction := Value;
  FDefaultActionStored := True;
end;

function TEditButtonEh.IsDefaultActionStored: Boolean;
begin
  Result := FDefaultActionStored;
end;

{ TEditButtonsEh }

function TEditButtonsEh.Add: TEditButtonEh;
begin
  Result := TEditButtonEh(inherited Add);
end;

constructor TEditButtonsEh.Create(Owner: TPersistent; EditButtonClass: TEditButtonEhClass);
begin
  inherited Create(EditButtonClass);
  FOwner := Owner;
end;

function TEditButtonsEh.GetEditButton(Index: Integer): TEditButtonEh;
begin
  Result := TEditButtonEh(inherited Items[Index]);
end;

function TEditButtonsEh.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

procedure TEditButtonsEh.SetEditButton(Index: Integer; Value: TEditButtonEh);
begin
  inherited Items[Index] := Value;
end;

procedure TEditButtonsEh.Update(Item: TCollectionItem);
begin
  inherited Update(Item);
  if Assigned(FOnChanged) then FOnChanged(Item);
end;

{ TDropDownEditButtonEh }

constructor TDropDownEditButtonEh.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FShortCut := Menus.ShortCut(VK_DOWN, [ssAlt]); //32808
end;

constructor TDropDownEditButtonEh.Create(EditControl: TWinControl);
begin
  inherited Create(EditControl);
  FShortCut := Menus.ShortCut(VK_DOWN, [ssAlt]); //32808
end;

{ TVisibleEditButtonEh }

constructor TVisibleEditButtonEh.Create(EditControl: TWinControl);
begin
  inherited Create(EditControl);
  Visible := True;
  FShortCut := Menus.ShortCut(VK_DOWN, [ssAlt]); //32808
end;

constructor TVisibleEditButtonEh.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  Visible := True;
  FShortCut := Menus.ShortCut(VK_DOWN, [ssAlt]); //32808
end;

{ TSpecRowEh }

constructor TSpecRowEh.Create(Owner: TPersistent);
begin
  inherited Create;
  FOwner := Owner;
  FFont := TFont.Create;
  FFont.Assign(DefaultFont);
  FFont.OnChange := FontChanged;
  FCellsStrings := TStringList.Create;
  FValue := Null;
  FShowIfNotInKeyList := True;
  FShortCut := Menus.ShortCut(VK_DELETE, [ssAlt]); //32814
end;

destructor TSpecRowEh.Destroy;
begin
  FreeAndNil(FCellsStrings);
  FreeAndNil(FFont);
  inherited Destroy;
end;

function TSpecRowEh.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

procedure TSpecRowEh.Changed;
begin
  if (FUpdateCount = 0) and Assigned(FOnChanged) then
    OnChanged(Self);
end;

procedure SetCellsStrings(Strings: TStrings; const Value: String);
const
  Delimiter = ';';
  QuoteChar = '"';
{$IFDEF CIL}
// {$IF Defined(CLX) or Defined(EH_LIB_12) }
var
  P, P1, L: Integer;
  S: string;
begin
  Strings.BeginUpdate;
  try
    Strings.Clear;
    P := 1;
    L := Length(Value);
    while (P <= L) and (Value[P] in [#1..' ']) do
      Inc(P);
    while P <= L do
    begin
      if Value[P] = QuoteChar then
        S := DequotedStr(Value, QuoteChar, P)
      else
      begin
        P1 := P;
        while (P <= L) and (Value[P] > ' ') and (Value[P] <> Delimiter) do
          Inc(P);
        S := Copy(Value, P1, P - P1);
      end;
      Strings.Add(S);
      while (P <= L) and (Value[P] in [#1..' ']) do
        Inc(P);
      if (P <= L) and (Value[P] = Delimiter) then
      begin
        P1 := P;
        Inc(P1);
        if P1 > L then
          Strings.Add('');
        repeat
          Inc(P);
        until (P > L) or (not (Value[P] in [#1..' ']));
      end;
    end;
  finally
    Strings.EndUpdate;
  end;
end;

{$ELSE}
var
  P, P1: PChar;
  S: string;
begin
  Strings.BeginUpdate;
  try
    Strings.Clear;
    P := PChar(Value);
//    while P^ in [#1..' '] do P := CharNext(P);
    while CharInSetEh(P^, [#1..' ']) do P := CharNext(P);
    while P^ <> #0 do
    begin
      if P^ = QuoteChar then
        S := AnsiExtractQuotedStr(P, QuoteChar)
      else
      begin
        P1 := P;
        while (P^ >= ' ') and (P^ <> Delimiter) do P := CharNext(P);
        SetString(S, P1, P - P1);
      end;
      Strings.Add(S);
      while CharInSetEh(P^, [#1..#31]) do P := CharNext(P);
      if P^ = Delimiter then
        repeat
          P := CharNext(P);
        until not CharInSetEh(P^, [#1..#31]);
    end;
  finally
    Strings.EndUpdate;
  end;
end;
{$ENDIF}

procedure TSpecRowEh.SetCellsText(const Value: String);
begin
  if FCellsText <> Value then
  begin
    FCellsText := Value;
    SetCellsStrings(FCellsStrings, Value);
    Changed;
  end;
end;

procedure TSpecRowEh.SetColor(const Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    FColorAssigned := True;
    Changed;
  end;
end;

procedure TSpecRowEh.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
end;

procedure TSpecRowEh.SetValue(const Value: Variant);
begin
  if FValue <> Value then
  begin
    FValue := Value;
    Changed;
  end;
end;

procedure TSpecRowEh.SetVisible(const Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    Changed;
  end;
end;

procedure TSpecRowEh.FontChanged(Sender: TObject);
begin
  Changed;
  FFontAssigned := True;
end;

procedure TSpecRowEh.SetShowIfNotInKeyList(const Value: Boolean);
begin
  if FShowIfNotInKeyList <> Value then
  begin
    FShowIfNotInKeyList := Value;
    Changed;
  end;
end;

procedure TSpecRowEh.Assign(Source: TPersistent);
begin
  if Source is TSpecRowEh then
  begin
    BeginUpdate;
    try
      CellsText := TSpecRowEh(Source).CellsText;
      Color := TSpecRowEh(Source).Color;
      if TSpecRowEh(Source).FFontAssigned then
        Font := TSpecRowEh(Source).Font;
      ShortCut := TSpecRowEh(Source).ShortCut;
      ShowIfNotInKeyList := TSpecRowEh(Source).ShowIfNotInKeyList;
      Value := TSpecRowEh(Source).Value;
      Visible := TSpecRowEh(Source).Visible;
    finally
      EndUpdate;
    end;
  end else
    inherited Assign(Source);
end;

function TSpecRowEh.GetFont: TFont;
var
  Save: TNotifyEvent;
begin
  {$WARNINGS OFF}
  if not FFontAssigned and (FFont.Handle <> DefaultFont.Handle) then
  {$WARNINGS ON}
  begin
    Save := FFont.OnChange;
    FFont.OnChange := nil;
    FFont.Assign(DefaultFont);
    FFont.OnChange := Save;
  end;
  Result := FFont;
end;

function TSpecRowEh.GetColor: TColor;
begin
  if not FColorAssigned
    then Result := DefaultColor
    else Result := FColor;
end;

function TSpecRowEh.DefaultFont: TFont;
begin
  if Assigned(FOwner) and (FOwner is TControl)
{$IFDEF CIL}
    then Result := IControl(FOwner).GetFont
{$ELSE}
    then Result := TControlCracker(FOwner).Font
{$ENDIF}
    else Result := FFont;
end;

function TSpecRowEh.DefaultColor: TColor;
begin
  if Assigned(FOwner) and (FOwner is TCustomControl)
{$IFDEF CIL}
    then Result := TCustomControl(FOwner).Color
{$ELSE}
    then Result := TControlCracker(FOwner).Color
{$ENDIF}
    else Result := FColor;
end;

function TSpecRowEh.GetCellText(Index: Integer): String;
begin
  if (Index < 0) or (Index >= FCellsStrings.Count)
    then Result := ''
    else Result := FCellsStrings[Index];
end;

function TSpecRowEh.IsValueStored: Boolean;
begin
  Result := not VarEquals(FValue, Null);
end;

function TSpecRowEh.IsFontStored: Boolean;
begin
  Result := FFontAssigned;
end;

function TSpecRowEh.IsColorStored: Boolean;
begin
  Result := FColorAssigned;
end;

function TSpecRowEh.LocateKey(KeyValue: Variant): Boolean;
begin
  Result := Visible and VarEquals(Value, KeyValue);
end;

procedure TSpecRowEh.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

procedure TSpecRowEh.EndUpdate;
begin
  Dec(FUpdateCount);
  Changed;
end;

procedure GetFieldsProperty(List: TList; DataSet: TDataSet;
  Control: TComponent; const FieldNames: String);
var
  Pos: Integer;
  Field: TField;
  FieldName: String;
begin
  Pos := 1;
  while Pos <= Length(FieldNames) do
  begin
    FieldName := ExtractFieldName(FieldNames, Pos);
    Field := DataSet.FindField(FieldName);
    if Field = nil then
      DatabaseErrorFmt(SFieldNotFound, [FieldName], Control);
    if Assigned(List) then List.Add(Field);
  end;
end;

function GetFieldsProperty(DataSet: TDataSet; Control: TComponent;
  const FieldNames: String): TFieldsArrEh;
var
  FieldList: TObjectList;
  i: Integer;
begin
  FieldList := TObjectList.Create(False);
  try
    GetFieldsProperty(FieldList, DataSet, Control, FieldNames);
    SetLength(Result, FieldList.Count);
    for i := 0 to FieldList.Count - 1 do
      Result[i] := TField(FieldList[i]);
  finally
    FieldList.Free;
  end;
end;

procedure DataSetSetFieldValues(DataSet: TDataSet; Fields: String; Value: Variant);
var
  FieldList: TListOfFieldsEh;
  i: Integer;
begin
  if VarEquals(Value, Null) then
  begin
    FieldList := TListOfFieldsEh.Create;
    try
      Dataset.GetFieldList(FieldList, Fields);
      for i := 0 to FieldList.Count - 1 do
        TField(FieldList[i]).Clear;
    finally
      FieldList.Free;
    end;
  end else
    DataSet.FieldValues[Fields] := Value;
end;

procedure DataSetGetFieldValues(DataSet: TDataSet; FKeyFields: TFieldsArrEh; var Value: Variant);
var
  i: Integer;
begin
  if Length(FKeyFields) > 1 then
  begin
    Value := VarArrayCreate([0, Length(FKeyFields) - 1], varVariant);
    for i := 0 to Length(FKeyFields) - 1 do
      Value[i] := FKeyFields[i].Value;
  end else
    Value := FKeyFields[0].Value;
end;

{ TSizeGripEh }

constructor TSizeGripEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable, csParentBackground, csCaptureMouse];
  Width := GetSystemMetrics(SM_CXVSCROLL);
  Height := GetSystemMetrics(SM_CYVSCROLL);
  Color := clBtnFace;
  Cursor := crSizeNWSE;
  FTriangleWindow := True;
  FPosition := sgpBottomRight;
end;

procedure TSizeGripEh.CreateHandle;
begin
  if HostControl <> nil then
    ParentWindow := HostControl.Handle;
  inherited CreateHandle;
end;

procedure TSizeGripEh.CreateWnd;
begin
  inherited CreateWnd;
  UpdateWindowRegion;
  //ShowWindow(Handle,SW_SHOW);
end;

procedure TSizeGripEh.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
  FInitScreenMousePos := ClientToScreen(Point(X, Y));
  FParentRect.Right := HostControl.Width;
  FParentRect.Bottom := HostControl.Height;
  FParentRect.Left := HostControl.ClientWidth;
  FParentRect.Top := HostControl.ClientHeight;
end;

procedure TSizeGripEh.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  NewMousePos, ParentWidthHeight: TPoint;
  OldPos, NewClientAmount, OutDelta: Integer;
  WorkArea: TRect;
  MonInfo: TMonitorInfo;
  MasterAbsRect: TRect;
begin
  inherited MouseMove(Shift, X, Y);

  if (ssLeft in Shift) and MouseCapture and not FInternalMove then
  begin
    NewMousePos := ClientToScreen(Point(X, Y));
    ParentWidthHeight.x := HostControl.ClientWidth;
    ParentWidthHeight.y := HostControl.ClientHeight;

    if (FOldMouseMovePos.x = NewMousePos.x) and
      (FOldMouseMovePos.y = NewMousePos.y) then
      Exit;

    MasterAbsRect.TopLeft := HostControl.ClientToScreen(Point(0, 0));
    MasterAbsRect.Bottom := MasterAbsRect.Top + HostControl.Height;
    MasterAbsRect.Right := MasterAbsRect.Left + HostControl.Width;
    MonInfo.cbSize := SizeOf(MonInfo);
{$IFDEF CIL}
    GetMonitorInfo(MonitorFromRect(MasterAbsRect, MONITOR_DEFAULTTONEAREST), MonInfo);
{$ELSE}
    GetMonitorInfo(MonitorFromRect(@MasterAbsRect, MONITOR_DEFAULTTONEAREST), @MonInfo);
{$ENDIF}
    WorkArea := MonInfo.rcWork;
//    SystemParametersInfoEh(SPI_GETWORKAREA, 0, WorkArea, 0);

    if Position in [sgpBottomRight, sgpTopRight] then
    begin
      NewClientAmount := FParentRect.Left + NewMousePos.x - FInitScreenMousePos.x;
      OutDelta := HostControl.Width + NewClientAmount - HostControl.ClientWidth;
      OutDelta := HostControl.ClientToScreen(Point(OutDelta, 0)).x - WorkArea.Right;
      if OutDelta <= 0
        then HostControl.ClientWidth := NewClientAmount
        else HostControl.ClientWidth := NewClientAmount - OutDelta
    end else
    begin
      OldPos := HostControl.Width;

      NewClientAmount := FParentRect.Right + FInitScreenMousePos.x - NewMousePos.x;
      OutDelta := NewClientAmount - HostControl.Width;
      OutDelta := HostControl.ClientToScreen(Point(0, 0)).x - WorkArea.Left - OutDelta;
      if OutDelta >= 0
        then HostControl.Width := NewClientAmount
        else HostControl.Width := NewClientAmount + OutDelta;
//      HostControl.Width := FParentRect.Right + FInitScreenMousePos.x - NewMousePos.x;
      HostControl.Left := HostControl.Left + OldPos - HostControl.Width;
    end;

    if Position in [sgpBottomRight, sgpBottomLeft] then
    begin
      NewClientAmount := FParentRect.Top + NewMousePos.y - FInitScreenMousePos.y;
      OutDelta := HostControl.Height + NewClientAmount - HostControl.ClientHeight;
      OutDelta := HostControl.ClientToScreen(Point(0, OutDelta)).y - WorkArea.Bottom;
      if OutDelta <= 0
        then HostControl.ClientHeight := NewClientAmount
        else HostControl.ClientHeight := NewClientAmount - OutDelta;
    end else
    begin
      OldPos := HostControl.Height;
      NewClientAmount := FParentRect.Bottom + FInitScreenMousePos.y - NewMousePos.y;
      OutDelta := NewClientAmount - HostControl.Height;
      OutDelta := HostControl.ClientToScreen(Point(0, 0)).y - WorkArea.Top - OutDelta;
      if OutDelta >= 0
        then HostControl.Height := NewClientAmount
        else HostControl.Height := NewClientAmount + OutDelta;
      HostControl.Top := HostControl.Top + OldPos - HostControl.Height;
    end;

    FOldMouseMovePos := NewMousePos;
    if (ParentWidthHeight.x <> HostControl.ClientWidth) or
      (ParentWidthHeight.y <> HostControl.ClientHeight) then
      ParentResized;
    UpdatePosition;
  end;
end;

procedure TSizeGripEh.Paint;
{$IFDEF EH_LIB_16}
const  PositionElementDetailsArr: array[TSizeGripPosition] of TThemedScrollBar =
//  (tsSizeBoxRightAlign, tsSizeBoxLeftAlign, tsSizeBoxRightAlign, tsSizeBoxLeftAlign);
  (tsSizeBoxTopLeftAlign, tsSizeBoxTopRightAlign, tsSizeBoxRightAlign, tsSizeBoxLeftAlign);
{$ENDIF}
var
  i, xi, yi: Integer;
  XArray: array of Integer;
  YArray: array of Integer;
  xIdx, yIdx: Integer;
  BtnHighlightColor, BtnShadowColor, BtnFaceColor: TColor;
{$IFDEF EH_LIB_16}
  LColor: TColor;
  LStyle: TCustomStyleServices;
  LDetails: TThemedElementDetails;
{$ENDIF}
{$IFDEF EH_LIB_16}
  ElementDetails: TThemedElementDetails;
{$ENDIF}
begin

{$IFDEF EH_LIB_16}
  if ThemeServices.ThemesEnabled and not CustomStyleActive then
  begin
    ElementDetails := ThemeServices.GetElementDetails(PositionElementDetailsArr[Position]);
    ThemeServices.DrawElement(Canvas.Handle, ElementDetails, Rect(0,0,Width,Height));
    Exit;
  end;
{$ENDIF}

  i := 1;
  SetLength(XArray, 2);
  SetLength(YArray, 2);
  if Position = sgpBottomRight then
  begin
    xi := 1; yi := 1;
    xIdx := 0; yIdx := 1;
    XArray[0] := 0; YArray[0] := Width;
    XArray[1] := Width; YArray[1] := 0;
  end else if Position = sgpBottomLeft then
  begin
    xi := -1; yi := 1;
    xIdx := 1; yIdx := 0;
    XArray[0] := 0; YArray[0] := 1;
    XArray[1] := Width - 1; YArray[1] := Width;
  end else if Position = sgpTopLeft then
  begin
    xi := -1; yi := -1;
    xIdx := 0; yIdx := 1;
    XArray[0] := Width - 1; YArray[0] := -1;
    XArray[1] := -1; YArray[1] := Width - 1;
  end else //  Position = sgpTopRight
  begin
    xi := 1; yi := -1;
    xIdx := 1; yIdx := 0;
    XArray[0] := Width; YArray[0] := Width - 1;
    XArray[1] := 0; YArray[1] := -1;
  end;

  BtnHighlightColor := clBtnHighlight;
  BtnShadowColor := clBtnShadow;
  BtnFaceColor := clBtnFace;
{$IFDEF EH_LIB_16}
  if TStyleManager.IsCustomStyleActive then
  begin
    LStyle := StyleServices;
    if LStyle.Enabled then
    begin
      LDetails := LStyle.GetElementDetails(tpPanelBackground);
      if LStyle.GetElementColor(LDetails, ecFillColor, LColor) and (LColor <> clNone) then
        BtnFaceColor := LColor;
      LDetails := LStyle.GetElementDetails(tpPanelBevel);
      if LStyle.GetElementColor(LDetails, ecEdgeHighLightColor, LColor) and (LColor <> clNone) then
        BtnHighlightColor := LColor;
      if LStyle.GetElementColor(LDetails, ecEdgeShadowColor, LColor) and (LColor <> clNone) then
        BtnShadowColor := LColor;
    end;
  end;
{$ENDIF}

  with Canvas do
    while i < Width do
    begin
      Pen.Color := BtnHighlightColor;
      PolyLine([Point(XArray[0], YArray[0]), Point(XArray[1], YArray[1])]);
      Inc(i); Inc(XArray[xIdx], xi); Inc(YArray[YIdx], yi);

      Pen.Color := BtnShadowColor;
      PolyLine([Point(XArray[0], YArray[0]), Point(XArray[1], YArray[1])]);
      Inc(i); Inc(XArray[xIdx], xi); Inc(YArray[yIdx], yi);
      PolyLine([Point(XArray[0], YArray[0]), Point(XArray[1], YArray[1])]);
      Inc(i); Inc(XArray[xIdx], xi); Inc(YArray[yIdx], yi);

      Pen.Color := BtnFaceColor;
      PolyLine([Point(XArray[0], YArray[0]), Point(XArray[1], YArray[1])]);
      Inc(i); Inc(XArray[xIdx], xi); Inc(YArray[yIdx], yi);
    end;
end;

procedure TSizeGripEh.ParentResized;
begin
  if Assigned(FParentResized) then FParentResized(Self);
end;

procedure TSizeGripEh.SetPosition(const Value: TSizeGripPosition);
begin
  if FPosition = Value then Exit;
  FPosition := Value;
  if HandleAllocated then
  begin
    RecreateWndHandle;
    HandleNeeded;
  end;
end;

procedure TSizeGripEh.SetTriangleWindow(const Value: Boolean);
begin
  if FTriangleWindow = Value then Exit;
  FTriangleWindow := Value;
  UpdateWindowRegion;
end;

procedure TSizeGripEh.UpdatePosition;
begin
  if not HandleAllocated then Exit;
  FInternalMove := True;
  case Position of
    sgpBottomRight: MoveWindow(Handle, HostControl.ClientWidth - Width, HostControl.ClientHeight - Height, Width, Height, True);
    sgpBottomLeft: MoveWindow(Handle, 0, HostControl.ClientHeight - Height, Width, Height, True);
    sgpTopLeft: MoveWindow(Handle, 0, 0, Width, Height, True);
    sgpTopRight: MoveWindow(Handle, HostControl.ClientWidth - Width, 0, Width, Height, True);
  end;
  FInternalMove := False;
end;

procedure TSizeGripEh.WMEraseBkgnd(var Message: TWmEraseBkgnd);
begin
//  Message.Result := 1;
  inherited;
end;

procedure TSizeGripEh.WMMove(var Message: TWMMove);
begin
  if not FInternalMove then UpdatePosition;
  inherited;
end;

procedure TSizeGripEh.ChangePosition(NewPosition: TSizeGripChangePosition);
begin
  if NewPosition = sgcpToLeft then
  begin
    if Position = sgpTopRight then Position := sgpTopLeft
    else if Position = sgpBottomRight then Position := sgpBottomLeft;
  end else if NewPosition = sgcpToRight then
  begin
    if Position = sgpTopLeft then Position := sgpTopRight
    else if Position = sgpBottomLeft then Position := sgpBottomRight
  end else if NewPosition = sgcpToTop then
  begin
    if Position = sgpBottomRight then Position := sgpTopRight
    else if Position = sgpBottomLeft then Position := sgpTopLeft
  end else if NewPosition = sgcpToBottom then
  begin
    if Position = sgpTopRight then Position := sgpBottomRight
    else if Position = sgpTopLeft then Position := sgpBottomLeft
  end
end;

function TSizeGripEh.GetVisible: Boolean;
begin
  Result := IsWindowVisible(Handle);
end;

procedure TSizeGripEh.SetVisible(const Value: Boolean);
begin
  if HandleAllocated then
  begin
    if Value then
      ShowWindow(Handle, SW_SHOW)
    else
      ShowWindow(Handle, SW_HIDE);
  end else
    inherited Visible := Value;
end;

procedure TSizeGripEh.UpdateWindowRegion;
//type
//  PPoints = ^TPoints;
//  TPoints = array[0..0] of TPoint;
const
  PositionArr: array[TSizeGripPosition] of TCursor = (crSizeNWSE, crSizeNESW, crSizeNWSE, crSizeNESW);
var
  Points: array[0..2] of TPoint;
  Region: HRgn;
begin
  if not HandleAllocated then Exit;
  if TriangleWindow then
  begin
    if Position = sgpBottomRight then
    begin
      Points[0] := Point(0, Height);
      Points[1] := Point(Width, Height);
      Points[2] := Point(Width, 0);
    end else if Position = sgpBottomLeft then
    begin
      Points[0] := Point(Width, Height);
      Points[1] := Point(0, Height);
      Points[2] := Point(0, 0);
    end else if Position = sgpTopLeft then
    begin
      Points[0] := Point(Width - 1, 0);
      Points[1] := Point(0, 0);
      Points[2] := Point(0, Height - 1);
    end else if Position = sgpTopRight then
    begin
      Points[0] := Point(Width, Height - 1);
      Points[1] := Point(Width, 0);
      Points[2] := Point(1, 0);
    end;
    Region := WindowsCreatePolygonRgn(Points, 3, WINDING);
    SetWindowRgn(Handle, Region, True);
    UpdatePosition;
  end else
  begin
    SetWindowRgn(Handle, 0, True);
    UpdatePosition;
  end;
  Cursor := PositionArr[Position];
end;

function TSizeGripEh.GetHostControl: TWinControl;
begin
  if FHostControl <> nil
    then Result := FHostControl
    else Result := Parent;
end;

procedure TSizeGripEh.SetHostControl(const Value: TWinControl);
begin
  FHostControl := Value;
end;

{ TPopupMonthCalendarEh }

constructor TPopupMonthCalendarEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable]; //Really not Replicatable, only for CtrlGrid
  AutoSize := True;
  {$IFDEF FPC}
  {$ELSE}
  Ctl3D := True;
  ParentCtl3D := False;
  {$ENDIF}
end;

procedure TPopupMonthCalendarEh.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    {$IFDEF FPC}
    ExStyle := ExStyle or WS_EX_TOOLWINDOW or WS_EX_TOPMOST;
    {$ELSE}
    Style := Style or WS_POPUP;
    if not Ctl3D then Style := Style or WS_BORDER;
    ExStyle := ExStyle or WS_EX_TOOLWINDOW {or WS_EX_TOPMOST};
    {$ENDIF}
    WindowClass.Style := CS_SAVEBITS;
    if CheckWin32Version(5, 1) then
      WindowClass.Style := WindowClass.style or CS_DROPSHADOW;
  end;
end;

procedure TPopupMonthCalendarEh.KeyDown(var Key: Word; Shift: TShiftState);
var
  ComboEdit: IComboEditEh;
begin
  inherited KeyDown(Key, Shift);
  if Key in [VK_RETURN, VK_ESCAPE] then
  begin
    if Supports(Owner, IComboEditEh, ComboEdit) then
      ComboEdit.CloseUp(Key = VK_RETURN);
    Key := 0;
  end;
end;

procedure TPopupMonthCalendarEh.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  ComboEdit: IComboEditEh;
const
    MCM_GETCURRENTVIEW  = MCM_FIRST + 22;
begin
  inherited MouseDown(Button, Shift, X, Y);
  if not PtInRect(Rect(0, 0, Width, Height), Point(X, Y)) then
    if Supports(Owner, IComboEditEh, ComboEdit) then
      ComboEdit.CloseUp(False);
  FDownViewType := SendMessage(Handle, MCM_GETCURRENTVIEW, 0, 0);
end;

procedure TPopupMonthCalendarEh.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
{$IFDEF FPC}
  MCHInfo: TDummyStruct16;
{$ELSE}
  MCHInfo: TMCHitTestInfo;
{$ENDIF}
ComboEdit: IComboEditEh;
begin
  inherited MouseUp(Button, Shift, X, Y);
  if not Supports(Owner, IComboEditEh, ComboEdit) then Exit;
  if not PtInRect(Rect(0, 0, Width, Height), Point(X, Y)) then Exit;

{$IFDEF EH_LIB_16}
  if ThemesEnabled
    then MCHInfo.cbSize := SizeOf(TMCHitTestInfo)
    else MCHInfo.cbSize := System.SizeOf(MCHITTESTINFO) - (System.SizeOf(TRect) + System.SizeOf(Integer) * 3);
{$ELSE}
  {$IFDEF FPC}
  MCHInfo.cbSize := SizeOf(TDummyStruct16);
  {$ELSE}
  MCHInfo.cbSize := SizeOf(TMCHitTestInfo);
  {$ENDIF}
{$ENDIF}

  MCHInfo.pt.x := X;
  MCHInfo.pt.y := Y;
  {$IFDEF FPC}
  MonthCal_HitTest(Handle, @MCHInfo);
  {$ELSE}
  MonthCal_HitTest(Handle, MCHInfo);
  {$ENDIF}
  if ((MCHInfo.uHit and MCHT_CALENDARDATE) > 0) and (MCHInfo.uHit <> MCHT_CALENDARDAY) and
    (MCHInfo.uHit <> MCHT_TITLEBTNNEXT) and (MCHInfo.uHit <> MCHT_TITLEBTNPREV) then
  begin
    if FDownViewType = 0 then
      ComboEdit.CloseUp(True);
  end else if (MCHInfo.uHit and MCHT_NOWHERE > 0) then
    ComboEdit.CloseUp(False)
  else if not ((X >= 0) and (Y >= 0) and (X < Width) and (Y < Height)) then
    ComboEdit.CloseUp(False);
end;

procedure TPopupMonthCalendarEh.CMWantSpecialKey(var Message: TCMWantSpecialKey);
var
  ComboEdit: IComboEditEh;
begin
  if not Supports(Owner, IComboEditEh, ComboEdit) then Exit;
  if (Message.CharCode in [VK_RETURN, VK_ESCAPE]) then
  begin
    ComboEdit.CloseUp(Message.CharCode = VK_RETURN);
    Message.Result := 1;
  end else
    inherited;
end;

procedure TPopupMonthCalendarEh.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  inherited;
  Message.Result := Message.Result or DLGC_WANTARROWS or DLGC_WANTCHARS or DLGC_WANTTAB;
end;

procedure TPopupMonthCalendarEh.WMKillFocus(var Message: TWMKillFocus);
begin
  inherited;
  if (GetParent(Message.FocusedWnd) <> Handle) then
    PostCloseUp(False);
end;

procedure TPopupMonthCalendarEh.PostCloseUp(Accept: Boolean);
begin
  PostMessage(Handle, CM_CLOSEUPEH, Integer(Accept), 0);
end;

procedure TPopupMonthCalendarEh.CMCloseUpEh(var Message: TMessage);
var
  ComboEdit: IComboEditEh;
begin
  if Supports(Owner, IComboEditEh, ComboEdit) then
    ComboEdit.CloseUp(False);
end;

function TPopupMonthCalendarEh.DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  Result := inherited DoMouseWheelDown(Shift, MousePos);
  if not Result then
  begin
    {$IFDEF FPC}
    {$ELSE}
    Date := Date + 1;
    {$ENDIF}
    Result := True;
  end;
end;

function TPopupMonthCalendarEh.DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  Result := inherited DoMouseWheelDown(Shift, MousePos);
  if not Result then
  begin
    {$IFDEF FPC}
    {$ELSE}
    Date := Date - 1;
    {$ENDIF}
    Result := True;
  end;
end;

procedure TPopupMonthCalendarEh.WMNCCalcSize(var Message: TWMNCCalcSize);
{$IFDEF CIL}
var
  r: TNCCalcSizeParams;
begin
  inherited;
  r := Message.CalcSize_Params;
  InflateRect(r.rgrc0, -FBorderWidth, -FBorderWidth);
  Message.CalcSize_Params := r;
end;
{$ELSE}
begin
  inherited;
  with Message.CalcSize_Params^ do
    InflateRect(rgrc[0], -FBorderWidth, -FBorderWidth);
end;
{$ENDIF}

procedure TPopupMonthCalendarEh.UpdateBorderWidth;
begin
  {$IFDEF FPC}
  FBorderWidth := 2
  {$ELSE}
  if Ctl3D
      then FBorderWidth := 2
      else FBorderWidth := 0;
  {$ENDIF}
end;

procedure TPopupMonthCalendarEh.DrawBorder;
var
  DC: HDC;
  R: TRect;
begin
  {$IFDEF FPC}
  {$ELSE}
  if Ctl3D = True then
  {$ENDIF}
  begin
    DC := GetWindowDC(Handle);
    try
      GetWindowRect(Handle, R);
      OffsetRect(R, -R.Left, -R.Top);
      DrawEdge(DC, R, BDR_RAISEDOUTER, BF_RECT);
      InflateRect(R, -1, -1);
      DrawEdge(DC, R, BDR_RAISEDINNER, BF_RECT);
    finally
      ReleaseDC(Handle, DC);
    end;
  end;
end;

procedure TPopupMonthCalendarEh.WMNCPaint(var Message: TWMNCPaint);
begin
  inherited;
  DrawBorder;
end;

{$IFDEF FPC}
{$ELSE}
procedure TPopupMonthCalendarEh.CMCtl3DChanged(var Message: TMessage);
begin
  inherited;
  UpdateBorderWidth;
  RecreateWnd;
end;
{$ENDIF}

procedure TPopupMonthCalendarEh.CreateWnd;
var
  R: TRect;
begin
  inherited CreateWnd;
  MonthCal_GetMinReqRect(Handle, R);
  Width := R.Right - R.Left + FBorderWidth * 2;
  Height := R.Bottom - R.Top + FBorderWidth * 2;
end;

function TPopupMonthCalendarEh.CanAutoSize(var NewWidth, NewHeight: Integer): Boolean;
begin
  Result := inherited CanAutoSize(NewWidth, NewHeight);
  if Result then
  begin
    Inc(NewWidth, FBorderWidth * 2);
    Inc(NewHeight, FBorderWidth * 2);
  end;
end;

{$IFDEF FPC}
{$ELSE}
function TPopupMonthCalendarEh.MsgSetDateTime(Value: TSystemTime): Boolean;
begin
  inherited MsgSetDateTime(Value);
  Result := True;
end;
{$ENDIF}

function TPopupMonthCalendarEh.GetDate: TDate;
var
  ASysDate: TSystemTime;
begin
  if HandleAllocated and
    {$IFDEF FPC}
    MonthCal_GetCurSel(Handle, @ASysDate)
    {$ELSE}
    MonthCal_GetCurSel(Handle, ASysDate)
    {$ENDIF}
  then
  begin
    ASysDate.wHour := 0;
    ASysDate.wMinute := 0;
    ASysDate.wSecond := 0;
    ASysDate.wMilliseconds := 0;
    Result := SystemTimeToDateTime(ASysDate)
  end else
  {$IFDEF FPC}
    Result := inherited DateTime;
  {$ELSE}
    Result := inherited Date;
  {$ENDIF}
end;

procedure TPopupMonthCalendarEh.SetDate(const Value: TDate);
begin
  {$IFDEF FPC}
  inherited DateTime := Value;
  {$ELSE}
  inherited Date := Value;
  {$ENDIF}
end;

{ TMRUListEh }

constructor TMRUListEh.Create(AOwner: TPersistent);
begin
  inherited Create;
  FOwner := AOwner;
  FItems := TStringList.Create;
  FLimit := 100;
  FRows := 7;
  FAutoAdd :=  True;
  FCancelIfKeyInQueue := True;
end;

destructor TMRUListEh.Destroy;
begin
  FreeAndNil(FItems);
  inherited Destroy;
end;

procedure TMRUListEh.DropDown;
begin
  if Assigned(OnSetDropDown) then
    OnSetDropDown(Self);
end;

procedure TMRUListEh.CloseUp(Accept: Boolean);
begin
  if Assigned(OnSetCloseUp) then
    OnSetCloseUp(Self, Accept);
end;

procedure TMRUListEh.SetActive(const Value: Boolean);
begin
  if FActive <> Value then
  begin
    FActive := Value;
    if Assigned(FOnActiveChanged) then
      OnActiveChanged(Self);
  end;
end;

procedure TMRUListEh.SetItems(const Value: TStrings);
begin
  FItems.Assign(Value);
end;

procedure TMRUListEh.SetLimit(const Value: Integer);
begin
  if FLimit <> Value then
  begin
    FLimit := Value;
    UpdateLimit;
  end;
end;

procedure TMRUListEh.UpdateLimit;
begin
  while Items.Count > FLimit do
    Items.Delete(0);
end;

procedure TMRUListEh.SetRows(const Value: Integer);
begin
  FRows := Value;
end;

procedure TMRUListEh.Assign(Source: TPersistent);
begin
  if Source is TMRUListEh then
  begin
    Active := TMRUListEh(Source).Active;
    Items := TMRUListEh(Source).Items;
    Limit := TMRUListEh(Source).Limit;
    Rows := TMRUListEh(Source).Rows;
    CaseSensitive := TMRUListEh(Source).CaseSensitive;
  end else
    inherited Assign(Source);
end;

procedure TMRUListEh.Add(s: String);
var
  i: Integer;
begin
  if Trim(s) = '' then Exit;
  for i := 0 to Items.Count-1 do
    if (CaseSensitive and (s = Items[i])) or
       (not CaseSensitive and (AnsiCompareText(s, Items[i]) = 0)) then
    begin
      Items.Move(i, Items.Count-1);
      Exit;
    end;
  Items.Add(s);
  UpdateLimit;
end;

function TMRUListEh.FilterItemsTo(FilteredItems: TStrings; MaskText: String): Boolean;
var
  i: Integer;
  Accept: Boolean;
  CharMsg: Windows.TMsg;
begin
  Result := True;
  FilteredItems.BeginUpdate;
  try
    FilteredItems.Clear;
    for i := 0 to Items.Count-1 do
    begin
      Accept := False;
      if CaseSensitive
        then Accept := (AnsiCompareStr(Copy(Items[i], 1, Length(MaskText)), MaskText) = 0)
        else Accept := (AnsiCompareText(Copy(Items[i], 1, Length(MaskText)), MaskText) = 0);
      if Assigned(OnFilterItem) then
        OnFilterItem(Self, Accept);
      if Accept then FilteredItems.Add(Items[i]);
      if (i mod 100 = 0) and CancelIfKeyInQueue then
        if PeekMessage(CharMsg, 0, WM_KEYDOWN, WM_KEYDOWN, PM_NOREMOVE) then
        begin
          Result := False;
          Exit;
        end;
    end;
  finally
    FilteredItems.EndUpdate;
  end;
end;

{ TDataLinkEh }

{$IFDEF CIL}
procedure TDataLinkEh.DataEvent(Event: TDataEvent; Info: TObject);
{$ELSE}
  {$IFDEF EH_LIB_16}
procedure TDataLinkEh.DataEvent(Event: TDataEvent; Info: NativeInt);
  {$ELSE}
    {$IFDEF FPC}
procedure TDataLinkEh.DataEvent(Event: TDataEvent; Info: NativeInt);
    {$ELSE}
procedure TDataLinkEh.DataEvent(Event: TDataEvent; Info: Integer);
    {$ENDIF}
  {$ENDIF}
{$ENDIF}
begin
  inherited DataEvent(Event, Info);
  if Assigned(OnDataEvent) then
    OnDataEvent(Event, Info);
end;

{ TDatasetFieldValueListEh }

constructor TDatasetFieldValueListEh.Create;
begin
  inherited Create;
  FValues := TStringList.Create;
  FValues.Sorted := True;
  FValues.Duplicates := dupIgnore;
  FDataSource := TDataSource.Create(nil);
  FDataLink := TDataLinkEh.Create;
  FDataLink.OnDataEvent := DataSetEvent;
end;

destructor TDatasetFieldValueListEh.Destroy;
begin
  FreeAndNil(FValues);
  FDataSource.DataSet := nil;
  FreeAndNil(FDataSource);
  FreeAndNil(FDataLink);
  inherited Destroy;
end;

function TDatasetFieldValueListEh.GetValues: TStrings;
begin
  if FDataObsoleted then
    RefreshValues;
  Result := FValues;
end;

procedure TDatasetFieldValueListEh.SetFieldName(const Value: String);
begin
  if FFieldName <> Value then
  begin
    FDataObsoleted := True;
    FFieldName := Value;
  end;
end;

procedure TDatasetFieldValueListEh.SetDataSet(const Value: TDataSet);
begin
  DataSource := nil;
  FDataLink.DataSource := FDataSource;
  if FDataLink.DataSet <> Value then
  begin
    FDataObsoleted := True;
    FDataSource.DataSet := Value;
  end;
end;

function TDatasetFieldValueListEh.GetDataSet: TDataSet;
begin
  Result := FDataSource.DataSet;
end;

procedure TDatasetFieldValueListEh.SetDataSource(const Value: TDataSource);
begin
  if FDataLink.DataSource <> Value then
  begin
    FDataObsoleted := True;
    FDataLink.DataSource := Value;
  end;
end;

function TDatasetFieldValueListEh.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TDatasetFieldValueListEh.RefreshValues;
var
  Field: TField;
  ABookmark: TUniBookmarkEh;
begin
  FValues.Clear;
  if not FDataLink.Active or (FDataLink.DataSet.FindField(FieldName) = nil) then
    Exit;
  Field := FDataLink.DataSet.FindField(FieldName);
  FDataLink.DataSet.DisableControls;
  try
    ABookmark := FDataLink.DataSet.Bookmark;
    FDataLink.DataSet.First;
    while not FDataLink.DataSet.Eof do
    begin
      FValues.Add(Field.AsString);
      FDataLink.DataSet.Next;
    end;
  finally
    FDataLink.DataSet.Bookmark := ABookmark;
    FDataLink.DataSet.EnableControls;
  end;
  FDataObsoleted := False;
end;

{$IFDEF CIL}
procedure TDatasetFieldValueListEh.DataSetEvent(Event: TDataEvent; Info: TObject);
{$ELSE}
procedure TDatasetFieldValueListEh.DataSetEvent(Event: TDataEvent; Info: Integer);
{$ENDIF}
begin
  if Event in [deDataSetChange, dePropertyChange, deFieldListChange] then
    FDataObsoleted := True;
end;

procedure TDatasetFieldValueListEh.SetFilter(Filter: String);
begin

end;

function TDatasetFieldValueListEh.GetCaseSensitive: Boolean;
begin
  Result := FValues.CaseSensitive;
end;

procedure TDatasetFieldValueListEh.SetCaseSensitive(const Value: Boolean);
begin
  FValues.CaseSensitive := Value;
end;

{$IFNDEF EH_LIB_6}

{ TStringListEh }

function StringListCompareStrings(List: TStringList; Index1, Index2: Integer): Integer;
begin
  Result := TStringListEh(List).CompareStrings(List[Index1], List[Index2]);
end;

procedure TStringListEh.Sort;
begin
  CustomSort(StringListCompareStrings);
end;

procedure TStringListEh.SetCaseSensitive(const Value: Boolean);
begin
  if Value <> FCaseSensitive then
  begin
    FCaseSensitive := Value;
    if Sorted then Sort;
  end;
end;

function TStringListEh.CompareStrings(const S1, S2: string): Integer;
begin
  if CaseSensitive then
    Result := AnsiCompareStr(S1, S2)
  else
    Result := AnsiCompareText(S1, S2);
end;

{$ENDIF}

{ TBMListEh }

constructor TBMListEh.Create;
begin
  inherited Create;
{$IFDEF EH_LIB_12}
  SetLength(FList, 0);
{$ELSE}
  FList := TStringList.Create;
  FList.OnChange := ListChanged;
{$ENDIF}
end;

destructor TBMListEh.Destroy;
begin
  Clear;
  UpdateState;
{$IFDEF EH_LIB_12}
{$ELSE}
  FreeAndNil(FList);
{$ENDIF}
  inherited Destroy;
end;

procedure TBMListEh.Delete;
var
  I: Integer;
begin
  with Dataset do
  begin
    DisableControls;
    try
{$IFDEF EH_LIB_12}
      for I := Length(FList) - 1 downto 0 do
{$ELSE}
      for I := FList.Count - 1 downto 0 do
{$ENDIF}
      begin
        Bookmark := FList[I];
        Delete;
        DeleteItem(I);
      end;
    finally
      EnableControls;
    end;
  end;
  UpdateState;
end;

function TBMListEh.IndexOf(const Item: TUniBookmarkEh): Integer;
begin
  if not Find(Item, Result) then
    Result := -1;
end;

function TBMListEh.GetCount: Integer;
begin
{$IFDEF EH_LIB_12}
  Result := Length(FList);
{$ELSE}
  Result := FList.Count;
{$ENDIF}
end;

function TBMListEh.GetCurrentRowSelected: Boolean;
var
  Index: Integer;
begin
  Result := Find(CurrentRow, Index);
end;

function TBMListEh.GetItem(Index: Integer): TUniBookmarkEh;
begin
  Result := FList[Index];
end;

procedure TBMListEh.SetItem(Index: Integer; Item: TUniBookmarkEh);
begin
  FList[Index] := Item;
end;

function TBMListEh.Refresh: Boolean;
var
  I: Integer;
  BeginUpdated: Boolean;
begin
  Result := False;
  BeginUpdated := False;
  with Dataset do
  try
    CheckBrowseMode;
    if GetCount > 0 then
    begin
{$IFDEF EH_LIB_12}
{$ELSE}
    FList.BeginUpdate;
{$ENDIF}
      BeginUpdated := True;
    end;
    for I := GetCount - 1 downto 0 do
      if not DatasetBookmarkValid(Dataset, FList[I]) then
      begin
        Result := True;
        DeleteItem(I);
      end;
  finally
    UpdateState;
    UpdateCursorPos;
    if BeginUpdated then
{$IFDEF EH_LIB_12}
      if Result then 
        ListChanged(Self);
{$ELSE}
      FList.EndUpdate;
{$ENDIF}
    if Result then Invalidate;
  end;
end;

procedure TBMListEh.SelectAll;
var
  bm: TUniBookmarkEh;
begin
  if not FLinkActive then Exit;
  with Dataset do
  begin
    DisableControls;
    try
      bm := Bookmark;
      First;
      while EOF = False do
      begin
        SetCurrentRowSelected(True);
        Next;
      end;
      Bookmark := bm;
    finally
      EnableControls;
    end;
  end;
end;

procedure TBMListEh.ListChanged(Sender: TObject);
begin
{$IFDEF EH_LIB_12}
  FCache := nil;
{$ELSE}
  FCache := '';
{$ENDIF}
  FCacheIndex := -1;
end;

procedure TBMListEh.SetCurrentRowSelected(Value: Boolean);
var
  Index: Integer;
  Current: TUniBookmarkEh;
begin
  Current := CurrentRow;
  if Find(Current, Index) = Value
    then Exit;
  if Value
    then InsertItem(Index, Current)
    else DeleteItem(Index);
end;

function TBMListEh.CurrentRow: TUniBookmarkEh;
begin
  {$IFDEF FPC}
  if not FLinkActive then RaiseBMListError(SInactiveDataset);
  {$ELSE}
  if not FLinkActive then RaiseBMListError(sDataSetClosed);
  {$ENDIF}
  Result := Dataset.Bookmark;
end;

function TBMListEh.Compare(const Item1, Item2: TUniBookmarkEh): Integer;
begin
  with Dataset do
    Result := DataSetCompareBookmarks(Dataset, Item1, Item2);
end;

procedure TBMListEh.Clear;
begin
{$IFDEF EH_LIB_12}
  if Length(FList) = 0 then Exit;
  SetLength(FList, 0);
{$ELSE}
  if FList.Count = 0 then Exit;
  FList.Clear;
{$ENDIF}
  ListChanged(Self);
//  UpdateState;
  Invalidate;
end;

procedure TBMListEh.CustomSort(DataSet: TDataSet; Compare: TBMListSortCompare);
begin
  if (Count > 1) then
    QuickSort(DataSet, 0, Count - 1, Compare);
end;

procedure TBMListEh.QuickSort(DataSet: TDataSet; L, R: Integer; SCompare: TBMListSortCompare);
var
  I, J, P: Integer;
  T: TUniBookmarkEh;
begin
  repeat
    I := L;
    J := R;
    P := (L + R) shr 1;
    repeat
      while SCompare(Self, DataSet, I, P) < 0 do Inc(I);
      while SCompare(Self, DataSet, J, P) > 0 do Dec(J);
      if I <= J then
      begin
        if I <> J then
        begin
          T := FList[I];
          FList[I] := FList[J];
          FList[J] := T;
//          ExchangeItems(I, J);
        end;
        if P = I then
          P := J
        else if P = J then
          P := I;
        Inc(I);
        Dec(J);
      end;
    until I > J;
    if L < J then QuickSort(DataSet, L, J, SCompare);
    L := I;
  until I >= R;
end;

function TBMListEh.Find(const Item: TUniBookmarkEh; var Index: Integer): Boolean;
var
  L, H, I, C: Integer;
begin
  if (Item = FCache) and (FCacheIndex >= 0) then
  begin
    Index := FCacheIndex;
    Result := FCacheFind;
    Exit;
  end;
  Result := False;
  L := 0;
  H := GetCount - 1;
  while L <= H do
  begin
    I := (L + H) shr 1;
    C := Compare(FList[I], Item);
    if C < 0 then L := I + 1 else
    begin
      H := I - 1;
      if C = 0 then
      begin
        Result := True;
        L := I;
      end;
    end;
  end;
  Index := L;
  FCache := Item;
  FCacheIndex := Index;
  FCacheFind := Result;
end;

procedure TBMListEh.RaiseBMListError(const S: string);
begin
  raise Exception.Create(S);
end;

procedure TBMListEh.LinkActive(Value: Boolean);
begin
  Clear;
  UpdateState;
  FLinkActive := Value;
end;

procedure TBMListEh.UpdateState;
begin
end;

procedure TBMListEh.Invalidate;
begin
end;

function TBMListEh.GetDataSet: TDataSet;
begin
  Result := nil;
end;

procedure TBMListEh.DeleteItem(Index: Integer);
{$IFDEF EH_LIB_12}
var
  Temp: Pointer;
begin
  if (Index < 0) or (Index >= Count) then
    raise EListError.CreateFmt(SListIndexError, [Index]);
  Temp := FList[Index];
  // The Move below will overwrite this slot, so we need to finalize it first
  FList[Index] := nil;
  if Index < Count-1 then
  begin
    System.Move(FList[Index + 1], FList[Index],
      (Count - Index - 1) * SizeOf(Pointer));
    // Make sure we don't finalize the item that was in the last position.
    PPointer(@FList[Count-1])^ := nil;
  end;
  SetLength(FList, Count-1);
  ListChanged(Temp);
end;
{$ELSE}
begin
  FList.Delete(Index);
end;
{$ENDIF}

procedure TBMListEh.InsertItem(Index: Integer; Item: TUniBookmarkEh);
{$IFDEF EH_LIB_12}
begin
  if (Index < 0) or (Index > Count) then
    raise EListError.Create(SListIndexError);
  SetLength(FList, Count + 1);
  if Index < Count - 1 then
  begin
    Move(FList[Index], FList[Index + 1],
      (Count - Index - 1) * SizeOf(Pointer));
    // The slot we opened up with the Move above has a dangling pointer we don't want finalized
    PPointer(@FList[Index])^ := nil;
  end;
  FList[Index] := Item;
  ListChanged(TObject(Item));
end;
{$ELSE}
begin
  FList.Insert(Index, Item)
end;
{$ENDIF}

procedure TBMListEh.AppendItem(Item: TUniBookmarkEh);
{$IFDEF EH_LIB_12}
begin
  InsertItem(GetCount, Item);
end;
{$ELSE}
begin
  FList.Add(Item)
end;
{$ENDIF}

{ TEditButtonActionLinkEh }
procedure TEditButtonActionLinkEh.AssignClient(AClient: TObject);
begin
  FClient := AClient as TEditButtonEh;
end;

function TEditButtonActionLinkEh.IsEnabledLinked: Boolean;
begin
  Result := inherited IsEnabledLinked and
    (FClient.Enabled = (Action as TCustomAction).Enabled);
end;

function TEditButtonActionLinkEh.IsHintLinked: Boolean;
begin
  Result := inherited IsHintLinked and
    (FClient.Hint = (Action as TCustomAction).Hint);
end;

function TEditButtonActionLinkEh.IsShortCutLinked: Boolean;
begin
  Result := inherited IsShortCutLinked and
    (FClient.ShortCut = (Action as TCustomAction).ShortCut);
end;

function TEditButtonActionLinkEh.IsVisibleLinked: Boolean;
begin
  Result := inherited IsVisibleLinked and
    (FClient.Visible = (Action as TCustomAction).Visible);
end;

procedure TEditButtonActionLinkEh.SetEnabled(Value: Boolean);
begin
  if IsEnabledLinked then FClient.Enabled := Value;
end;

procedure TEditButtonActionLinkEh.SetHint(const Value: string);
begin
  if IsHintLinked then FClient.Hint := Value;
end;

procedure TEditButtonActionLinkEh.SetShortCut(Value: TShortCut);
begin
  if IsShortCutLinked then FClient.ShortCut := Value;
end;

procedure TEditButtonActionLinkEh.SetVisible(Value: Boolean);
begin
  if IsVisibleLinked then FClient.Visible := Value;
end;

function KillMouseUp(Control: TControl; Area: TRect): Boolean;
var
  p: TPoint;
  Msg: Windows.TMsg;
  WinControl: TWinControl;
begin
  Result := False;
  if Control is TWinControl
    then WinControl := TWinControl(Control)
    else WinControl := Control.Parent;
  if PeekMessage(Msg, WinControl.Handle, WM_LBUTTONDOWN, WM_LBUTTONDBLCLK, PM_NOREMOVE) then
  begin
    if (Msg.message = WM_LBUTTONDOWN) or (Msg.message = WM_LBUTTONDBLCLK) then
    begin
      P := SmallPointToPointEh(LongintToSmallPoint(Msg.lParam));
      if (WinControl = Control) or
         (WinControl.ControlAtPos(P, True) = Control) then
      begin
        P := Control.ScreenToClient(WinControl.ClientToScreen(P));
        if PtInRect(Control.ClientRect, P) then
        begin
          PeekMessage(Msg, WinControl.Handle, Msg.message, Msg.message, PM_REMOVE);
          Result := True;
        end;
      end;
    end;
  end;
end;

function KillMouseUp(Control: TControl): Boolean;
var
  p: TPoint;
  Msg: Windows.TMsg;
  WinControl: TWinControl;
begin
  Result := False;
  if Control is TWinControl
    then WinControl := TWinControl(Control)
    else WinControl := Control.Parent;
  if PeekMessage(Msg, WinControl.Handle, WM_LBUTTONDOWN, WM_LBUTTONDBLCLK, PM_NOREMOVE) then
  begin
    if (Msg.message = WM_LBUTTONDOWN) or (Msg.message = WM_LBUTTONDBLCLK) then
    begin
      P := SmallPointToPointEh(LongintToSmallPoint(Msg.lParam));
      if WinControl.ControlAtPos(P, True) = Control then
      begin
        PeekMessage(Msg, WinControl.Handle, Msg.message, Msg.message, PM_REMOVE);
        Result := True;
      end;
    end;
  end;
end;

procedure StdFillGradientEh(Canvas: TCanvas; ARect: TRect; FromColor, ToColor: TColor);
var
  h,i: Integer;
  rgb1, rgb2: Integer;
  a1,a2,a3, b1,b2,b3: Integer;
  r, g, b: Double;
  c1, c2, c3: Double;
begin

  rgb1 := ColorToRGB(FromColor);
  a1 := rgb1 and $FF;
  a2 := (rgb1 shr 8) and $FF;
  a3 := (rgb1 shr 16) and $FF;

  rgb2 := ColorToRGB(ToColor);
  b1 := rgb2 and $FF;
  b2 := (rgb2 shr 8) and $FF;
  b3 := (rgb2 shr 16) and $FF;

  h := ARect.Bottom - ARect.Top - 1;

  if h < 0 then
    Exit;

  if h > 0  then
  begin
    c1 := (a1-b1) / h;
    c2 := (a2-b2) / h;
    c3 := (a3-b3) / h;
  end else
  begin
    c1 := a1;
    c2 := a2;
    c3 := a3;
  end;

  for i := 0 to h do
  begin
    r := a1-c1*i;
    g := a2-c2*i;
    b := a3-c3*i;
    Canvas.Pen.Color := TColor((Max(Min(Round(b), 255),0) shl 16)
                            or (Max(Min(Round(g), 255),0) shl 8)
                            or Max(Min(Round(r), 255),0));

    if ARect.Right - ARect.Left <= 1
    then
      Canvas.Polyline([Point(ARect.Left, ARect.Top+i),
                       Point(ARect.Right,ARect.Top+i)])
    else
      Canvas.Rectangle(ARect.Left, ARect.Top+i, ARect.Right, ARect.Top+i+1);
  end;
end;

procedure FillGradientEh(Canvas: TCanvas; TopLeft: TPoint;
  Points: array of TPoint; FromColor, ToColor: TColor);
var
  h,i,h1: Integer;
  rgb1, rgb2: Integer;
  a1,a2,a3, b1,b2,b3: Integer;
  r, g, b: Double;
begin

  rgb1 := ColorToRGB(FromColor);
  a1 := rgb1 and $FF;
  a2 := (rgb1 shr 8) and $FF;
  a3 := (rgb1 shr 16) and $FF;

  rgb2 := ColorToRGB(ToColor);
  b1 := rgb2 and $FF;
  b2 := (rgb2 shr 8) and $FF;
  b3 := (rgb2 shr 16) and $FF;

  h := Length(Points) div 2 - 1;

  for i := 0 to h do
  begin
    h1 := h;
    if h1 = 0 then h1 := 1;
    r := a1-(a1-b1) / h1 * i;
    g := a2-(a2-b2) / h1 * i;
    b := a3-(a3-b3) / h1 * i;
    Canvas.Pen.Color := TColor((Max(Min(Round(b), 255),0) shl 16)
                            or (Max(Min(Round(g), 255),0) shl 8)
                            or Max(Min(Round(r), 255),0));

    Canvas.Polyline(
      [Point(TopLeft.X + Points[i*2].X, TopLeft.Y + Points[i*2].Y),
       Point(TopLeft.X+Points[i*2+1].X, TopLeft.Y + Points[i*2+1].Y)]);
  end;
end;

function ApproachToColorEh(FromColor, ToColor: TColor; Percent: Integer): TColor;
var
  r, g, b: Double;
  rgb: Longint;
  r_c, g_c, b_c: Double;
  rgb_c: Longint;
begin
  rgb := ColorToRGB(FromColor);
  r := rgb and $FF;
  g := (rgb shr 8) and $FF;
  b := (rgb shr 16) and $FF;

  rgb_c := ColorToRGB(ToColor);
  r_c := rgb_c and $FF;
  g_c := (rgb_c shr 8) and $FF;
  b_c := (rgb_c shr 16) and $FF;

  r := r + (r_c - r) * Percent / 100;
  g := g + (g_c - g) * Percent / 100;
  b := b + (b_c - b) * Percent / 100;

  Result := TColor((Max(Min(Round(b), 255),0) shl 16)
                or (Max(Min(Round(g), 255),0) shl 8)
                or Max(Min(Round(r), 255),0));
end;

function ThemesEnabled: Boolean;
begin
{$IFDEF EH_LIB_7}
  Result := ThemeServices.ThemesEnabled;
{$ELSE}
  Result := False;
{$ENDIF}
end;

function CustomStyleActive: Boolean;
begin
{$IFDEF EH_LIB_16}
  Result := TStyleManager.IsCustomStyleActive;
{$ELSE}
  Result := False;
{$ENDIF}
end;

procedure FillGradientEh(Canvas: TCanvas; ARect: TRect; FromColor, ToColor: TColor);
begin
  StdFillGradientEh(Canvas, ARect, FromColor, ToColor);
end;

function GetShiftState: TShiftState;
begin
  Result := [];
  if GetKeyState(VK_SHIFT) < 0 then Include(Result, ssShift);
  if GetKeyState(VK_CONTROL) < 0 then Include(Result, ssCtrl);
  if GetKeyState(VK_MENU) < 0 then Include(Result, ssAlt);
end;

type
 TFieldTypes = set of TFieldType;
//Don't declare such types in interface part because of C++ Builder 2010 error:
//E2015 Ambiguity between 'ftSingle' and 'Typinfo::ftSingle'
// as it turn in - typedef Set<Db::TFieldType, ftUnknown, ftStream>  TFieldTypes;

const
  ftNumberFieldTypes: TFieldTypes = [ftSmallint, ftInteger, ftWord, ftFloat, ftCurrency,
    ftBCD{$IFDEF EH_LIB_6}, ftFMTBcd{$ENDIF}];

function IsFieldTypeNumeric(FieldType: TFieldType): Boolean;
begin
  Result := FieldType in ftNumberFieldTypes;
end;

{ TGraphicStreamFormatsEh }

constructor TGraphicStreamFormatsEh.Create;
begin
  inherited Create;
end;

destructor TGraphicStreamFormatsEh.Destroy;
begin
  inherited Destroy;
end;

function TGraphicStreamFormatsEh.FindClassFromStreamHeader(Stream: TStream): TGraphicClass;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do
  begin
    if Items[i].CheckStreamSignature(Stream) then
    begin
      Result := Items[i].GetGraphicClass;
      Exit;
    end;
  end;
end;

function TGraphicStreamFormatsEh.GetGraphicStreamFormatDetector(
  Index: Integer): TGraphicStreamFormatDetector;
begin
  Result := TGraphicStreamFormatDetector(inherited Items[Index]);
end;

procedure TGraphicStreamFormatsEh.RegisterGraphicStreamFormatDetector(
  d: TGraphicStreamFormatDetector);
begin
  Add(d);
end;

{ TGraphicStreamFormatDetector }

function TGraphicStreamFormatDetector.CheckStreamSignature(Stream: TStream): Boolean;
begin
  Result := False;
end;

function TGraphicStreamFormatDetector.GetGraphicClass: TGraphicClass;
begin
  Result := nil;
end;

var
  GraphicProviders: TList;

procedure InitGraphicProviders;
begin
  GraphicProviders := TList.Create;
  {$IFDEF FPC}
  {$ELSE}
  PopupListEh := TPopupListEh.Create;
  {$ENDIF}
  if UseThemes then
    begin
      ExplorerTreeviewTheme := OpenThemeData(0, 'Explorer::Treeview');
      if ExplorerTreeviewTheme = 0 then
        ExplorerTreeviewTheme := OpenThemeData(0, 'Treeview');
    end;
  RegisterGraphicProviderEh(TBMPGraphicProviderEh);
end;

procedure ReleaseGraphicProviders;
begin
  {$IFDEF FPC}
  {$ELSE}
  FreeAndNil(PopupListEh);
  {$ENDIF}
  FreeAndNil(GraphicProviders);
end;

procedure RegisterGraphicProviderEh(GraphicProviderClass: TGraphicProviderEhClass);
begin
{$IFDEF CIL}
{$ELSE}
  if GraphicProviders.IndexOf(GraphicProviderClass) < 0 then
    GraphicProviders.Insert(0, GraphicProviderClass);
{$ENDIF}
end;

{$IFDEF CIL}
function GetImageClassForStreamEh(Start: TBytes): TGraphicClass;
{$ELSE}
function GetImageClassForStreamEh(Start: Pointer): TGraphicClass;
{$ENDIF}
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to GraphicProviders.Count-1 do
  begin
    Result := TGraphicProviderEhClass(GraphicProviders[i]).GetImageClassForStream(Start);
    if Result <> nil then
      Exit;
  end;
end;

function GetGraphicProvidersCount: Integer;
begin
  Result := GraphicProviders.Count;
end;

function GetGraphicForField(Field: TField): TGraphic;
var
  ms: TMemoryStream;
  BlobField: TBlobField;
  GraphicClass: TGraphicClass;
//  Graphic: TGraphic;
  MemPointer: Pointer;
  {$IFDEF FPC}
  {$ELSE}
  Header: TGraphicHeader;
  msSize: Longint;
  {$ENDIF}
begin
  Result := nil;
  try
  if Assigned(Field) and Field.IsBlob and (Field is TBlobField) then
  begin
    try
    ms := TMemoryStream.Create;
    if GetGraphicProvidersCount > 0 then
    begin
        BlobField := (Field as TBlobField);
        BlobField.SaveToStream(ms);
        ms.Position := 0;
        MemPointer := ms.Memory;
        {$IFDEF FPC}
        {$ELSE}
        if (Field as TBlobField).GraphicHeader then
        begin
          msSize := ms.Size;
          if msSize >= SizeOf(TGraphicHeader) then
          begin
            ms.Read(Header, SizeOf(Header));
            if (Header.Count <> 1) or (Header.HType <> $0100) or
              (Header.Size <> msSize - SizeOf(Header))
            then
              ms.Position := 0
            else
              MemPointer := Pointer(Longint(ms.Memory) + SizeOf(Header));
          end;
        end;
        {$ENDIF}
        GraphicClass := GetImageClassForStreamEh(MemPointer);
        if GraphicClass = nil then
          GraphicClass := TBitmap;

    end else
      GraphicClass := TBitmap;

    Result := GraphicClass.Create;
    try
      Result.LoadFromStream(ms);
    except
      on EInvalidGraphic do ;
    end;

    {$IFDEF FPC}
    {$ELSE}
    if Result is TBitmap then
      (Result as TBitmap).IgnorePalette := True;
    {$ENDIF}

    finally
      FreeAndNil(ms);
    end;
  end;
  except
    FreeAndNil(Result);
    raise;
  end;
end;

procedure AssignPictureFromImageField(Field: TField; Picture: TPicture);
var
  PictureGraphic: TGraphic;
begin
  PictureGraphic := GetGraphicForField(Field);
  Picture.Graphic := PictureGraphic;
  PictureGraphic.Free;
end;

function GetPictureForField(Field: TField): TPicture;
(*var
  ms: TMemoryStream;
  BlobField: TBlobField;
  GraphicClass: TGraphicClass;
  NewGraphic: TGraphic;
  MemPointer: Pointer;
  Header: TGraphicHeader;
  msSize: Longint;*)
begin
  Result := TPicture.Create;
  AssignPictureFromImageField(Field, Result);
(*  try
  if Assigned(Field) and Field.IsBlob and (Field is TBlobField) then
  begin
    if GetGraphicProvidersCount > 0 then
    begin
      try
        ms := TMemoryStream.Create;
        BlobField := (Field as TBlobField);
        BlobField.SaveToStream(ms);
        ms.Position := 0;
        MemPointer := ms.Memory;
        if (Field as TBlobField).GraphicHeader then
        begin
          msSize := ms.Size;
          if msSize >= SizeOf(TGraphicHeader) then
          begin
            ms.Read(Header, SizeOf(Header));
            if (Header.Count <> 1) or (Header.HType <> $0100) or
              (Header.Size <> msSize - SizeOf(Header))
            then
              ms.Position := 0
            else
              MemPointer := Pointer(Longint(ms.Memory) + SizeOf(Header));
          end;
        end;
        GraphicClass := GetImageClassForStreamEh(MemPointer);
        if GraphicClass <> nil then
        begin
          NewGraphic := GraphicClass.Create;
          Result.Graphic := NewGraphic;
          FreeAndNil(NewGraphic);
//          ms.Position := 0;
          Result.Graphic.LoadFromStream(ms);
        end else
          Result.Assign(Field);
      finally
        FreeAndNil(ms);
      end;
    end else
      Result.Assign(Field);
    if Result.Graphic is TBitmap then
      Result.Bitmap.IgnorePalette := True;
  end;
  except
    FreeAndNil(Result);
    raise;
  end;*)
end;

{ TGraphicProviderEh }

{$IFDEF CIL}
class function TGraphicProviderEh.GetImageClassForStream(Start: TBytes): TGraphicClass;
{$ELSE}
class function TGraphicProviderEh.GetImageClassForStream(Start: Pointer): TGraphicClass;
{$ENDIF}
begin
  Result := nil;
end;

{ TBMPGraphicProviderEh }

class function TBMPGraphicProviderEh.GetImageClassForStream(Start: Pointer): TGraphicClass;
begin
  if (Start <> nil) and (Word(Start^) = $4D42)
    then Result := TBitmap
    else Result := nil;
end;

{ TIconGraphicProviderEh }

class function TIconGraphicProviderEh.GetImageClassForStream(Start: Pointer): TGraphicClass;
begin
  Result := nil;
  { TODO :
  Realise check if Pointer Point to Icon Stream
  See -  http://ru.wikipedia.org/wiki/ICO_(%D1%84%D0%BE%D1%80%D0%BC%D0%B0%D1%82_%D1%84%D0%B0%D0%B9%D0%BB%D0%BE%D0%B2) }
end;

function SelectClipRectangleEh(Canvas: TCanvas; var ClipRect: TRect): HRgn;
var
  Rgn, SaveRgn: HRgn;
  Flag: Integer;
begin
  SaveRgn := CreateRectRgn(0, 0, 0, 0);
  Flag := GetClipRgn(Canvas.Handle, SaveRgn);
  with ClipRect do
    Rgn := CreateRectRgn(Left, Top, Right, Bottom);
//  SelectClipRgn(Canvas.Handle, Rgn);
  ExtSelectClipRgn(Canvas.Handle, Rgn, RGN_AND);
  DeleteObject(Rgn);
  if Flag = 0 then
  begin
    Result := 0;
    DeleteObject(SaveRgn);
  end else
    Result := SaveRgn;
end;

procedure RestoreClipRectangleEh(Canvas: TCanvas; RecHandle: HRgn);
begin
  if RecHandle = 0 then
    SelectClipRgn(Canvas.Handle, 0)
  else
  begin
    SelectClipRgn(Canvas.Handle, RecHandle);
    DeleteObject(RecHandle);
  end;
end;

{ TEditButtonImagesEh }

constructor TEditButtonImagesEh.Create(Owner: TEditButtonEh);
begin
  inherited Create;
  FOwner := Owner;
end;

destructor TEditButtonImagesEh.Destroy;
begin
  inherited Destroy;
end;

procedure TEditButtonImagesEh.Assign(Source: TPersistent);
begin
  if Source is TEditButtonImagesEh then
  begin
    NormalImages := TEditButtonImagesEh(Source).NormalImages;
//    ControlHotImages := TEditButtonImagesEh(Source).ControlHotImages;
    HotImages := TEditButtonImagesEh(Source).HotImages;
    PressedImages := TEditButtonImagesEh(Source).PressedImages;
    DisabledImages := TEditButtonImagesEh(Source).DisabledImages;

    NormalIndex := TEditButtonImagesEh(Source).NormalIndex;
//    ControlHotIndex := TEditButtonImagesEh(Source).ControlHotIndex;
    HotIndex := TEditButtonImagesEh(Source).HotIndex;
    PressedIndex := TEditButtonImagesEh(Source).PressedIndex;
    DisabledIndex := TEditButtonImagesEh(Source).DisabledIndex;
  end else
    inherited Assign(Source);
end;

function TEditButtonImagesEh.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

function TEditButtonImagesEh.GetStateImages(
  EditButtonState: TEditButtonStateEh): TCustomImageList;
begin
  case EditButtonState of
    ebstNormalEh:       Result := NormalImages;
//    ebstControlHotEh:   Result := ControlHotImages;
    ebstHotEh:          Result := HotImages;
    ebstPressedEh:      Result := PressedImages;
    ebstDisabledEh:     Result := DisabledImages;
  else
    Result := nil;
  end;
  if (Result = nil) and (EditButtonState <> ebstNormalEh) then
    Result := NormalImages;
end;

function TEditButtonImagesEh.GetStateIndex(
  EditButtonState: TEditButtonStateEh): Integer;
begin
  case EditButtonState of
    ebstNormalEh:       Result := NormalIndex;
//    ebstControlHotEh:   Result := ControlHotIndex;
    ebstHotEh:          Result := HotIndex;
    ebstPressedEh:      Result := PressedIndex;
    ebstDisabledEh:     Result := DisabledIndex;
  else
    Result := -1;
  end;
end;

procedure TEditButtonImagesEh.SetDisabledImages(const Value: TCustomImageList);
begin
  if FDisabledImages <> Value then
  begin
    FDisabledImages := Value;
    FOwner.RefComponentChanged(Value);
  end;
end;

procedure TEditButtonImagesEh.SetDisabledIndex(const Value: Integer);
begin
  if FDisabledIndex <> Value then
  begin
    FDisabledIndex := Value;
    FOwner.Changed;
  end;
end;

procedure TEditButtonImagesEh.SetHotImages(const Value: TCustomImageList);
begin
  if FHotImages <> Value then
  begin
    FHotImages := Value;
    FOwner.RefComponentChanged(Value);
  end;
end;

procedure TEditButtonImagesEh.SetHotIndex(const Value: Integer);
begin
  if FHotIndex <> Value then
  begin
    FHotIndex := Value;
    FOwner.Changed;
  end;
end;

procedure TEditButtonImagesEh.SetNormalImages(const Value: TCustomImageList);
begin
  if FNormalImages <> Value then
  begin
    FNormalImages := Value;
    FOwner.RefComponentChanged(Value);
  end;
end;

procedure TEditButtonImagesEh.SetNormalIndex(const Value: Integer);
begin
  if FNormalIndex <> Value then
  begin
    FNormalIndex := Value;
    FOwner.Changed;
  end;
end;

procedure TEditButtonImagesEh.SetPressedImages(const Value: TCustomImageList);
begin
  if FPressedImages <> Value then
  begin
    FPressedImages := Value;
    FOwner.RefComponentChanged(Value);
  end;
end;

procedure TEditButtonImagesEh.SetPressedIndex(const Value: Integer);
begin
  if FPressedIndex <> Value then
  begin
    FPressedIndex := Value;
    FOwner.Changed;
  end;
end;

{$IFDEF CIL}
{$ELSE}
procedure DrawProgressBarEh(const CurrentValue, MinValue, MaxValue: Double;
  Canvas: TCanvas; const Rect: TRect; Color, FrameColor, BackgroundColor: TColor;
  const PBParPtr: PProgressBarParamsEh = nil);
var
  progressRect : TRect;
  progressPosition : Word;
  progressWidth : Integer;
  progressText : String;

  textSize : TSize;
  textRect : TRect;

  pbp : TProgressBarParamsEh;
begin

  if Assigned(PBParPtr) then
    pbp := PBParPtr^
  else
    begin
      pbp.ShowText := True;
      pbp.TextType := pbttAsPercent;
      pbp.TextDecimalPlaces := 0;
      pbp.Indent := 1;
      pbp.FrameFigureType := pbfftRectangle;
      pbp.FrameSizeType := pbfstVal;
      pbp.FontName := Canvas.Font.Name;
      pbp.FontColor := Canvas.Font.Color;
      pbp.FontSize := GetFontSize(Canvas.Font);
      pbp.FontStyle := Canvas.Font.Style;
      pbp.TextAlignment := taCenter;
    end;

  // background
  if BackgroundColor = clDefault then
    BackgroundColor := Canvas.Brush.Color;
  if BackgroundColor <> clNone then
  begin
    Canvas.Brush.Color := StyleServices.GetSystemColor(BackgroundColor);
    Canvas.FillRect(Rect);
  end;

  // calc progressWidth
  progressWidth := Rect.Right - Rect.Left - (pbp.Indent shl 2);

  // calc progressPosition
  if CurrentValue > 0 then
    progressPosition := trunc(CurrentValue / (MaxValue - MinValue) * progressWidth)
  else
    progressPosition := 0;

  if pbp.ShowText then
    begin
      if pbp.TextType = pbttAsValue then
        progressText := FloatToStr(RoundTo(CurrentValue, -pbp.TextDecimalPlaces))
      else
        progressText := FloatToStr(RoundTo(CurrentValue / (MaxValue - MinValue) * 100, -pbp.TextDecimalPlaces)) + '%';
    end
  else
    progressText := '';

  // indent
  progressRect := Rect;
  Inc(progressRect.Left, pbp.Indent);
  Inc(progressRect.Top, pbp.Indent);
  Dec(progressRect.Bottom, pbp.Indent);

  if CurrentValue >= MaxValue then
    Dec(progressRect.Right, pbp.Indent)
  else
    if progressRect.Left + progressPosition < Rect.Right then
      progressRect.Right := progressRect.Left + progressPosition;


  // paint progress
  Canvas.Brush.Color := Color;
  Canvas.Pen.Color := StyleServices.GetSystemColor(FrameColor);
  if pbp.FrameFigureType = pbfftRectangle then
    begin
      if pbp.FrameSizeType = pbfstFull then
        begin
          Canvas.FillRect(progressRect);
          Canvas.Brush.Color := StyleServices.GetSystemColor(FrameColor);
          progressRect.Right := Rect.Right - pbp.Indent;
          Canvas.FrameRect(progressRect);
        end
      else
        Canvas.Rectangle(progressRect);
    end
  else
    begin
      if pbp.FrameSizeType = pbfstFull then
        begin
          // progress
          Canvas.Pen.Color := Color;
          Canvas.RoundRect(progressRect.Left, progressRect.Top,
            progressRect.Right, progressRect.Bottom, 5, 5);
          // frame
          Canvas.Pen.Color := StyleServices.GetSystemColor(FrameColor);
          Canvas.Brush.Style := bsClear;
          progressRect.Right := Rect.Right - pbp.Indent;
          Canvas.RoundRect(progressRect.Left, progressRect.Top,
            progressRect.Right, progressRect.Bottom, 5, 5);
        end
      else
        Canvas.RoundRect(progressRect.Left, progressRect.Top,
            progressRect.Right, progressRect.Bottom, 10, 5);
    end;


  // paint text
  if pbp.ShowText and (progressText <> '') then
    begin
      Canvas.Font.Name := pbp.FontName;
      Canvas.Font.Color := pbp.FontColor;
      Canvas.Font.Size := pbp.FontSize;
      Canvas.Font.Style := pbp.FontStyle;
      Canvas.Brush.Style := bsClear;

      textSize := Canvas.TextExtent(progressText);
      textRect := Rect;

      if (PBParPtr = nil) and (textSize.cy >= textRect.Bottom - textRect.Top) and (Color <> FrameColor) then
      begin
        Canvas.Font.Size := GetFontSize(Canvas.Font) - 1;
        textSize := Canvas.TextExtent(progressText);
      end;

      case pbp.TextAlignment of
        taLeftJustify :
          textRect.Left := Rect.Left + pbp.Indent + 3;
        taCenter :
          textRect.Left := Rect.Left + ((Rect.Right - Rect.Left) shr 1) - (textSize.cx shr 1);
        taRightJustify :
          textRect.Left := Rect.Right - textSize.cx - pbp.Indent - 3;
      end;

      textRect.Top := Rect.Top + ((Rect.Bottom - Rect.Top) shr 1) - (textSize.cy shr 1);
      textRect.Right := textRect.Left + textSize.cx;
      textRect.Bottom := textRect.Top + textSize.cy;

      if (textRect.Left < Rect.Left) then
        textRect.Left := Rect.Left + 1;

      Canvas.TextRect(textRect, textRect.Left, textRect.Top, progressText);
    end;
end;
{$ENDIF}

{ TPopupMenuEh }

constructor TPopupMenuEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  {$IFDEF FPC}
  {$ELSE}
  PopupListEh.Add(Self);
  {$ENDIF}
end;

destructor TPopupMenuEh.Destroy;
begin
  {$IFDEF FPC}
  {$ELSE}
  PopupListEh.Remove(Self);
  {$ENDIF}
  inherited Destroy;
end;

{$IFDEF FPC}
procedure TPopupMenuEh.Popup(X, Y: Integer);
begin
  inherited Popup(X, Y);
end;
{$ELSE}
procedure TPopupMenuEh.Popup(X, Y: Integer);
var
  OldPopupList: TPopupList;
begin
  OldPopupList := PopupList;
  PopupList := PopupListEh;
  inherited Popup(X, Y);
  PopupList := OldPopupList;
end;
{$ENDIF}

{$IFDEF FPC}
{$ELSE}
{ TPopupListEh }

constructor TPopupListEh.Create;
begin
  inherited Create;
  FPopupMenuWins := TList.Create;;
end;

destructor TPopupListEh.Destroy;
begin
  FreeAndNil(FPopupMenuWins);
  inherited Destroy;
end;

function TPopupListEh.FindHackedMenuHandle(MenuPopup: HMENU): TPopupMenuWinEh;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to FPopupMenuWins.Count-1 do
    if MenuPopup = TPopupMenuWinEh(FPopupMenuWins[i]).FMenuHandle then
    begin
      Result := TPopupMenuWinEh(FPopupMenuWins[i]);
      Exit;
    end;
end;

function TPopupListEh.AddMenuPopup(MenuPopup: HMENU): TPopupMenuWinEh;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to FPopupMenuWins.Count-1 do
    if MenuPopup = TPopupMenuWinEh(FPopupMenuWins[i]).FMenuHandle then
      Exit;
  Result := TPopupMenuWinEh.Create;
  Result.FMenuHandle := MenuPopup;
  FPopupMenuWins.Add(Result);
end;

procedure TPopupListEh.DeleteWin(WindowHandle: HWND);
var
  i: Integer;
  MenuWin: TPopupMenuWinEh;
begin
  for i := 0 to FPopupMenuWins.Count-1 do
    if WindowHandle = TPopupMenuWinEh(FPopupMenuWins[i]).FPopupWindowHandle then
    begin
      MenuWin := FPopupMenuWins[i];
      FreeAndNil(MenuWin);
      FPopupMenuWins.Delete(i);
      Exit;
    end;
end;

procedure TPopupListEh.MenuSelectID(ItemID: UINT; var CanClose: Boolean);
var
  Item: TMenuItem;
  I: Integer;
begin
  CanClose := True;
  Item := nil;
  for I := 0 to Count - 1 do
  begin
    Item := TPopupMenu(Items[I]).FindItem(ItemID, fkCommand);
    if Item <> nil then
      Break;
  end;
//  Item := Menu.FindItem(ItemID, fkCommand);
  if Assigned(Item) and (Item is TMenuItemEh) and not TMenuItemEh(Item).CloseMenuOnClick then
  begin
    // Menu Item is clicked
    Item.Click;
    CanClose := False;
  end;
end;

procedure TPopupListEh.MenuSelectPos(MenuHandle: HMENU; ItemPos: UINT;  var CanClose: Boolean);
var
  ItemID: UINT;
begin
  ItemID := GetMenuItemID(MenuHandle, ItemPos);
  if ItemID <> $FFFFFFFF then
    MenuSelectID(GetMenuItemID(MenuHandle, ItemPos), CanClose);
end;

procedure TPopupListEh.WndProc(var Message: TMessage);
var
  AddedMenuWin: TPopupMenuWinEh;
begin
  case Message.Msg of
    WM_ENTERIDLE:
      if FGetPopupWindowHandle then
      begin
        AddedMenuWin := AddMenuPopup(FAddingMenuHandle);
        FGetPopupWindowHandle := False;

        AddedMenuWin.FPopupWindowHandle := TWMEnterIdle(Message).IdleWnd;

        AddedMenuWin.FHookedPopupWindowProc := classes.MakeObjectInstance(AddedMenuWin.PopupWindowProc);
        AddedMenuWin.FOrgPopupWindowProc := Pointer(GetWindowLong(AddedMenuWin.FPopupWindowHandle, GWL_WNDPROC));
        SetWindowLong(AddedMenuWin.FPopupWindowHandle, GWL_WNDPROC, Longint(AddedMenuWin.FHookedPopupWindowProc));
      end;

    WM_INITMENUPOPUP:
      begin
        if FindHackedMenuHandle(TWMInitMenuPopup(Message).MenuPopup) = nil then
        begin
          FAddingMenuHandle := TWMInitMenuPopup(Message).MenuPopup;
          FGetPopupWindowHandle := True;
        end;
      end;
    WM_MENUSELECT:
      begin
        AddedMenuWin := FindHackedMenuHandle(TWMMenuSelect(Message).Menu);
        if AddedMenuWin <> nil then
          AddedMenuWin.FSelectedItemID := TWMMenuSelect(Message).IDItem;
      end;

  end;

  inherited WndProc(Message)
end;
{$ENDIF}

{ TPopupMenuWinEh }

procedure TPopupMenuWinEh.PopupWindowProc(var Msg: TMessage);
var
  NormalItem: Boolean;
begin
  NormalItem := True;
  case Msg.Msg of
    $01ED, $01F1:
      begin
//        if not FMenuPosSelecting then
        begin
//          FMenuPosSelecting := True;
          try
          {$IFDEF FPC}
          {$ELSE}
          PopupListEh.MenuSelectPos(FMenuHandle, UINT(Msg.WParamLo), NormalItem);
          {$ENDIF}
            if not NormalItem then
            begin
              InvalidateRect(FPopupWindowHandle, nil, False);
              Exit;
            end;
          finally
//            FMenuPosSelecting := False;
          end;
        end;
      end;

    WM_KEYDOWN:
      if Msg.WParam = VK_RETURN then
      begin
        {$IFDEF FPC}
        {$ELSE}
        PopupListEh.MenuSelectID(FSelectedItemID, NormalItem);
        {$ENDIF}
        if not NormalItem then
        begin
          InvalidateRect(FPopupWindowHandle, nil, False);
          Exit;
        end;
      end;

    WM_DESTROY:
      begin
        {$HINTS OFF}
        SetWindowLong(FPopupWindowHandle, GWL_WNDPROC, Longint(FOrgPopupWindowProc));
        {$HINTS ON}
        classes.FreeObjectInstance(FHookedPopupWindowProc);
        Msg.Result := CallWindowProc(FOrgPopupWindowProc, FPopupWindowHandle,
          Msg.Msg, Msg.WParam, Msg.LParam);
        {$IFDEF FPC}
        {$ELSE}
        PopupListEh.DeleteWin(FPopupWindowHandle);
        {$ENDIF}
        Exit;
      end;
  end;

  Msg.Result := CallWindowProc(FOrgPopupWindowProc, FPopupWindowHandle,
      Msg.Msg, Msg.WParam, Msg.LParam);
end;

{ TMenuItemEh }

constructor TMenuItemEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCloseMenuOnClick := True;
end;

{ TDropDownFormCallParamsEh }

constructor TDropDownFormCallParamsEh.Create;
begin
  inherited Create;
  FAlign := daCenter;
  FPassParams := pspFieldValueEh;
  FFormWidth := -1;
  FormHeight := -1;
  FSaveFormSize := True;
end;

procedure TDropDownFormCallParamsEh.FillPassParams(DynParams: TDynVarsEh);
var
  ADataLink: TDataLink;
  AField: TField;
  ADataSet: TDataSet;
  Fields: TList;
  i: Integer;
  AFieldName: String;
begin
  ADataLink := GetDataLink;
  AField := GetField;
  if ADataLink <> nil
    then ADataSet := ADataLink.DataSet
    else ADataSet := nil;

  if (PassFieldNames <> '') and (ADataSet <> nil) then
  begin
    Fields := TList.Create;
    try
      ADataSet.GetFieldList(Fields, AssignBackFieldNames);
      for I := 0 to Fields.Count - 1 do
        DynParams.CreateDynVar(TField(Fields[i]).FieldName, TField(Fields[i]).Value)
    finally
      Fields.Free;
    end;
  end else if PassParams = pspFieldValueEh then
  begin
    if AField <> nil
      then AFieldName := AField.FieldName
      else AFieldName := '';
    DynParams.CreateDynVar(AFieldName, GetControlValue);
  end else if PassParams = pspRecordValuesEh then
  begin
    ADataSet := ADataLink.DataSet;
    for i := 0 to ADataSet.Fields.Count-1 do
      DynParams.CreateDynVar(ADataSet.Fields[i].FieldName, ADataSet.Fields[i].Value);
  end;
end;

procedure TDropDownFormCallParamsEh.GetDataFromPassParams(
  DynParams: TDynVarsEh);
var
  ADataSet: TDataSet;
  DataSetWasInEditState: Boolean;
  Fields: TList;
  i: Integer;
begin
  if (PassParams in [pspFieldValueEh, pspRecordValuesEh]) or
     (AssignBackFieldNames <> '') then
  begin
    if GetDataLink <> nil
      then ADataSet := GetDataLink.DataSet
      else ADataSet := nil;
    DataSetWasInEditState := False;
    if ADataSet <> nil then
    begin
      DataSetWasInEditState := (ADataSet.State in [dsEdit, dsInsert]);
      if not DataSetWasInEditState then
        ADataSet.Edit;
    end;
    if AssignBackFieldNames <> '' then
    begin
      Fields := TList.Create;
      try
        ADataSet.GetFieldList(Fields, AssignBackFieldNames);
        for I := 0 to Fields.Count - 1 do
          TField(Fields[I]).Value := DynParams[TField(Fields[I]).FieldName].Value;
      finally
        Fields.Free;
      end;
    end else
      SetControlValue(DynParams.Items[0].Value);

    if (ADataSet <> nil) and not DataSetWasInEditState then
      ADataSet.Post;
  end;
end;

function TDropDownFormCallParamsEh.GetActualDropDownForm(
  var FreeFormOnClose: Boolean): TCustomForm;
var
  ADropDownFormClass: TCustomDropDownFormClassEh;
begin
  if Assigned(FOnGetActualDropDownFormProc) then
    FOnGetActualDropDownFormProc(Result, FreeFormOnClose)
  else
  begin
    FreeFormOnClose := False;
    Result := nil;
    if DropDownForm <> nil then
      Result := DropDownForm
    else if DropDownFormClassName <> '' then
    begin
      ADropDownFormClass := TCustomDropDownFormClassEh(GetClass(DropDownFormClassName));
      if ADropDownFormClass <> nil then
      begin
        Result := ADropDownFormClass.GetGlobalRef;
        if Result = nil then
        begin
          Result := ADropDownFormClass.Create(GetEditControl);
          if ADropDownFormClass.GetGlobalRef = nil then
            FreeFormOnClose := True;
        end;
      end else
        raise Exception.Create('Class ''' + DropDownFormClassName + ''' is not registered');
    end;
  end;
end;

function TDropDownFormCallParamsEh.GetEditButton: TEditButtonEh;
begin
  Result := FEditButton;
end;

function TDropDownFormCallParamsEh.GetEditButtonControl: TEditButtonControlEh;
begin
  Result := FEditButtonControl;
end;

function TDropDownFormCallParamsEh.GetEditControl: TWinControl;
begin
  Result := FEditControl;
end;

function TDropDownFormCallParamsEh.GetOnCloseDropDownFormProc: TEditControlCloseDropDownFormEventEh;
begin
  Result := FOnCloseDropDownFormProc;
end;

function TDropDownFormCallParamsEh.GetOnOpenDropDownFormProc: TEditControlShowDropDownFormEventEh;
begin
  Result := FOnOpenDropDownFormProc;
end;

function TDropDownFormCallParamsEh.GetOnGetVarValueProc: TGetVarValueProcEh;
begin
  Result := FOnGetVarValueProc;
end;

function TDropDownFormCallParamsEh.GetOnSetVarValueProc: TSetVarValueProcEh;
begin
  Result := FOnSetVarValueProc;
end;

(*function TDropDownFormCallParamsEh.GetDropDownFormCallbackProc: TDropDownFormCallbackProcEh;
begin
  Result := FOnDropDownFormCallback;
end;
*)

function TDropDownFormCallParamsEh.GetDataLink: TDataLink;
begin
  Result := FDataLink;
end;

function TDropDownFormCallParamsEh.GetField: TField;
begin
  Result := FField;
end;

function TDropDownFormCallParamsEh.GetControlValue: Variant;
var
  AOnGetVarValueProc: TGetVarValueProcEh;
begin
  AOnGetVarValueProc := OnGetVarValue;
  if Assigned(AOnGetVarValueProc)
    then AOnGetVarValueProc(Result)
    else Result := Unassigned;
end;

procedure TDropDownFormCallParamsEh.SetControlValue(const Value: Variant);
var
  AOnSetVarValueProc: TSetVarValueProcEh;
begin
  AOnSetVarValueProc := OnSetVarValue;
  if Assigned(AOnSetVarValueProc) then
    AOnSetVarValueProc(Value);
end;

procedure TDropDownFormCallParamsEh.Changed;
begin
  if Assigned(FOnChanged) then
    OnChanged(Self);
end;

procedure TDropDownFormCallParamsEh.SetDropDownForm(const Value: TCustomForm);
begin
  if FDropDownForm <> Value then
  begin
    FDropDownForm := Value;
    Changed;
  end;
end;

procedure TDropDownFormCallParamsEh.SetDropDownFormClassName(const Value: String);
begin
  if FDropDownFormClassName <> Value then
  begin
    FDropDownFormClassName := Value;
    Changed;
  end;
end;

function TDropDownFormCallParamsEh.GetControlReadOnly: Boolean;
var
  AField: TField;
begin
  AField := GetField;
  if (AField <> nil) and AField.ReadOnly
    then Result := True
    else Result := False;
  if Assigned(FOnCheckDataIsReadOnly) then
    FOnCheckDataIsReadOnly(Result);
end;

procedure TDropDownFormCallParamsEh.CheckShowDropDownForm(var Handled: Boolean);
var
  DDParams: TDynVarsEh;
  SysParams: TEditControlDropDownFormSysParams;
  IntDropDownForm: IDropDownFormEh;
  ADropDownForm: TCustomForm;
  TheMsg: Windows.TMsg;
  AFreeFormOnClose: Boolean;
  AEditControl: TWinControl;
  AEditButton: TEditButtonEh;
  AEditButtonControl: TEditButtonControlEh;
  AOnOpenDropDownFormProc: TEditControlShowDropDownFormEventEh;
begin
  ADropDownForm := nil;
  AEditControl := GetEditControl;
  AEditButton := GetEditButton;
  AEditButtonControl := GetEditButtonControl;
  if AEditButtonControl.AlwaysDown then Exit;
  if {(FFixedDownButton = 0) and} PeekMessage(TheMsg, AEditControl.Handle, WM_USER, WM_USER, PM_NOREMOVE) then
  begin
    if (TheMsg.wParam = WPARAM(AEditControl.Handle)) and
       (TheMsg.lParam = LPARAM(AEditControl)) and
       (AEditButton = nil) then
    begin
      Handled := True;
      Exit;
    end;
    if (TheMsg.wParam = WPARAM(AEditControl.Handle)) and (TheMsg.lParam = LPARAM(AEditButton)) then
    begin
      Handled := True;
      Exit;
    end;
  end;

  AFreeFormOnClose := False;
  ADropDownForm := GetActualDropDownForm(AFreeFormOnClose);

  DDParams := TDynVarsEh.Create(AEditControl);
  SysParams := TEditControlDropDownFormSysParams.Create;

  SysParams.FreeFormOnClose := AFreeFormOnClose;
  SysParams.FEditControl := AEditControl;
  SysParams.FEditButton := AEditButton;

  FillPassParams(DDParams);

  if Supports(ADropDownForm, IDropDownFormEh, IntDropDownForm) then
    IntDropDownForm.ReadOnly := False;

  if ADropDownForm <> nil then
      IntDropDownForm.ReadOnly := GetControlReadOnly;

  if Assigned(OnOpenDropDownFormProc) then
  begin
    AOnOpenDropDownFormProc := OnOpenDropDownFormProc;
    AOnOpenDropDownFormProc(AEditControl, AEditButton, ADropDownForm, DDParams);
  end;

  if Supports(ADropDownForm, IDropDownFormEh, IntDropDownForm) then
  begin

    if SaveFormSize then
    begin
      OldFormWidth := ADropDownForm.Width;
      if FormWidth > 0 then
      begin
        ADropDownForm.Width := FormWidth;
      end;
      OldFormHeight := ADropDownForm.Height;
      if FormHeight > 0 then
      begin
        ADropDownForm.Height := FormHeight;
      end;
    end;

    AEditButtonControl.AlwaysDown := True;

    IntDropDownForm.ExecuteNomodal(ClientToScreenRect(AEditControl), nil, Align,
      DDParams, SysParams, DropDownFormCallbackProc);
    Handled := True;
  end else
  begin
    DDParams.Free;
    SysParams.Free;
  end;
end;

procedure TDropDownFormCallParamsEh.DropDownFormCallbackProc(
  DropDownForm: TCustomForm; Accept: Boolean; DynParams: TDynVarsEh;
  SysParams: TDropDownFormSysParams);
var
  ASysParams: TEditControlDropDownFormSysParams;
  AEditControl: TWinControl;
  AOnCloseDropDownFormProc: TEditControlCloseDropDownFormEventEh;
begin
  AEditControl := GetEditControl;

  ASysParams := TEditControlDropDownFormSysParams(SysParams);

  try
  try

  if Accept then
    GetDataFromPassParams(DynParams);

  DropDownForm.Hide;
  if SaveFormSize then
  begin
    FormWidth := DropDownForm.Width;
    if OldFormWidth > 0 then
      DropDownForm.Width := OldFormWidth;
    FormHeight := DropDownForm.Height;
    if OldFormHeight > 0 then
      DropDownForm.Height := OldFormHeight;
  end;

  if Assigned(OnCloseDropDownFormProc) then
  begin
    AOnCloseDropDownFormProc := OnCloseDropDownFormProc;
    AOnCloseDropDownFormProc(AEditControl, nil, Accept, DropDownForm, DynParams);
  end;

  if ASysParams.FEditButton <> nil
    then PostMessage(AEditControl.Handle, WM_USER, WPARAM(AEditControl.Handle), LPARAM(ASysParams.FEditButton))
    else PostMessage(AEditControl.Handle, WM_USER, WPARAM(AEditControl.Handle), LPARAM(AEditControl));

  finally
    DynParams.Free;
    SysParams.Free;
  end;
  except
    TCustomDropDownFormEh(DropDownForm).KeepFormVisible := True;
    Application.HandleException(AEditControl);
    TCustomDropDownFormEh(DropDownForm).KeepFormVisible := False;
  end;

end;

{ TOrderByList }

function TOrderByList.GetToken(const Exp: String; var FromIndex: Integer): String;
var
  Chars: TSysCharSet;
begin
  Result := '';
  if FromIndex > Length(Exp) then Exit;
  while Exp[FromIndex] = ' ' do
  begin
    Inc(FromIndex);
    if FromIndex > Length(Exp) then Exit;
  end;
  if FromIndex > Length(Exp) then Exit;
{$IFDEF EH_LIB_12}
  if CharInSet(Exp[FromIndex], [',', ';']) then
{$ELSE}
  if Exp[FromIndex] in [',', ';'] then
{$ENDIF}
  begin
    Result := Result + Exp[FromIndex];
    Inc(FromIndex);
    Exit;
  end;
  if Exp[FromIndex] = '[' then
  begin
    Chars := [#0, ']'];
    Inc(FromIndex);
  end else
    Chars := [#0, ' ', ',', ';'];
  while not CharInSetEh(Exp[FromIndex], Chars) do
  begin
    Result := Result + Exp[FromIndex];
    Inc(FromIndex);
    if FromIndex > Length(Exp) then Break;
  end;
  if (FromIndex <= Length(Exp)) and (Exp[FromIndex] = ']') then
    Inc(FromIndex);
end;

function TOrderByList.FindFieldIndex(const FieldName: String): Integer;
begin
  Result := -1;
end;

function TOrderByList.GetItem(Index: Integer): TOrderByItemEh;
begin
  Result := TOrderByItemEh(inherited Items[Index]);
end;

procedure TOrderByList.ParseOrderByStr(const OrderByStr: String);
var
  FieldName, Token: String;
  FromIndex: Integer;
  Desc: Boolean;
  OByItem: TOrderByItemEh;
  FieldIndex: Integer;
  OrderByList: TOrderByList;
  i: Integer;
begin
  OrderByList := TOrderByList.Create(False);
  try
    FromIndex := 1;
    FieldName := GetToken(OrderByStr, FromIndex);
    if FieldName = '' then
    begin
      Clear;
      Exit;
    end;
    FieldIndex := FindFieldIndex(FieldName);
    if FieldIndex = -1 then
      raise Exception.Create(' Field - "' + FieldName + '" not found.');
    Desc := False;
    while True do
    begin
      Token := GetToken(OrderByStr, FromIndex);
      if AnsiUpperCase(Token) = 'ASC' then
        Continue
      else if AnsiUpperCase(Token) = 'DESC' then
      begin
        Desc := True;
        Continue
      end else if (Token = ';') or (Token = ',') or (Token = '') then

      else
        raise Exception.Create(' Invalid token - "' + Token + '"');

      OByItem := TOrderByItemEh.Create;
      OByItem.MTFieldIndex := FieldIndex;
      OByItem.FieldIndex := FieldIndex;
      OByItem.Desc := Desc;
      TOrderByList(OrderByList).Add(OByItem);

      FieldName := GetToken(OrderByStr, FromIndex);
      if FieldName = '' then Break;
      FieldIndex := FindFieldIndex(FieldName);
      if FieldIndex = -1 then
        raise Exception.Create(' Field - "' + FieldName + '" not found.');
      Desc := False;
    end;
    Clear;
    for i := 0 to OrderByList.Count-1 do
      Add(OrderByList[i]);
  finally
    OrderByList.Free;
  end;
end;

procedure TOrderByList.SetItem(Index: Integer; const Value: TOrderByItemEh);
begin
  inherited Items[Index] := Value;
end;

{ TPictureEh }

constructor TPictureEh.Create;
begin
  inherited Create;
end;

destructor TPictureEh.Destroy;
begin
  inherited Destroy;
end;

function TPictureEh.GetDestRect(const SrcRect: TRect;
  Placement: TImagePlacementEh): TRect;
var
  w, h, cw, ch: Integer;
  xyaspect: Double;
  ActualPlacement: TImagePlacementEh;
begin
  w := Self.Width;
  h := Self.Height;
  Result := SrcRect;
  cw := Result.Right - Result.Left;
  ch := Result.Bottom - Result.Top;
  if Placement = ipReduceFitEh then
    if (cw >= w) and (ch >= h)
      then ActualPlacement := ipCenterCenterEh
      else ActualPlacement := ipFitEh
    else
      ActualPlacement := Placement;

  case ActualPlacement of
    ipStretchEh :
      begin
        w := cw;
        h := ch;
      end;

    ipFillEh :
      begin
        if (w > 0) and (h > 0) then
        begin
          xyaspect := h / w;
          h := ch;
          w := Trunc(ch / xyaspect);
          if w < cw then
          begin
            w := cw;
            h := Trunc(cw * xyaspect);
          end;
        end
        else
        begin
          w := cw;
          h := ch;
        end;
      end;

    ipFitEh :
      begin
        if (w > 0) and (h > 0) then
        begin
          xyaspect := w / h;
          w := cw;
          h := Trunc(cw / xyaspect);
          if h > ch then
          begin
            h := ch;
            w := Trunc(ch * xyaspect);
          end;
        end
        else
        begin
          w := cw;
          h := ch;
        end;
      end;
  end;

  with Result do
  begin
    Right := Left + w;
    Bottom := Top + h;
  end;

  case ActualPlacement of
    ipTopLeftEh :
      OffsetRect(Result, 0, 0);
    ipTopCenterEh :
      OffsetRect(Result, (cw - w) div 2, 0);
    ipTopRightEh :
      OffsetRect(Result, (cw - w), 0);

    ipCenterLeftEh :
      OffsetRect(Result, 0, (ch - h) div 2);
    ipCenterCenterEh :
      OffsetRect(Result, (cw - w) div 2, (ch - h) div 2);
    ipCenterRightEh :
      OffsetRect(Result, (cw - w), (ch - h) div 2);

    ipBottomLeftEh :
      OffsetRect(Result, 0, (ch - h));
    ipBottomCenterEh :
      OffsetRect(Result, (cw - w) div 2, (ch - h));
    ipBottomRightEh :
      OffsetRect(Result, (cw - w), (ch - h));

    ipFillEh :
      begin
        if h = ch then
        begin
          Inc(Result.Left, (cw - w) div 2);
          Inc(Result.Right, (cw - w) div 2);
        end else
        begin
          Inc(Result.Top, (ch - h) div 2);
          Inc(Result.Bottom, (ch - h) div 2);
        end;
      end;

    ipFitEh :
      begin
        if w = cw then
        begin
          Inc(Result.Top, (ch - h) div 2);
          Inc(Result.Bottom, (ch - h) div 2);
        end else
        begin
          Inc(Result.Left, (cw - w) div 2);
          Inc(Result.Right, (cw - w) div 2);
        end;
      end;
  end;
end;

procedure TPictureEh.PaintTo(Canvas: TCanvas; const DestRect: TRect;
  Placement: TImagePlacementEh; const ShiftPoint: TPoint;
  const ClipRect: TRect);
var
  Rect: TRect;
  MLeft : Integer;
begin
  Rect := GetDestRect(DestRect, Placement);

  if (Placement = ipTileEh) and (Self.Width > 0) and (Self.Height > 0) then
    begin
      MLeft := Rect.Left;
      while Rect.Top < DestRect.Bottom do
        begin
          while Rect.Left < DestRect.Right do
            begin
              Canvas.StretchDraw(Rect, Self.Graphic);
              OffsetRect(Rect, Self.Width, 0);
            end;
          Rect.Left := MLeft;
          Rect.Right := Rect.Left + Self.Width;
          OffsetRect(Rect, 0, Self.Height);
        end;
    end
  else
    Canvas.StretchDraw(Rect, Self.Graphic);
end;

initialization
  FlatButtonWidth := GetDefaultFlatButtonWidth;
  ButtonsBitmapCache := TButtonsBitmapCache.Create;
  GetCheckSize;
  InitGraphicProviders;
  UsesBitmap;
  RegisterClass(TSizeGripEh);
finalization
  FreeAndNil(ButtonsBitmapCache);
  ReleaseGraphicProviders;
  ReleaseBitmap;
end.
