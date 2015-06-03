{*******************************************************}
{                                                       }
{                        EhLib v7.0                     }
{                                                       }
{                      DBAxisGridsEh                    }
{                      Build 7.0.165                    }
{                                                       }
{   Copyright (c) 2012-2014 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit DBAxisGridsEh;

//{$R-}

interface

uses
{$IFDEF EH_LIB_17} System.Generics.Collections, {$ENDIF}
  Windows, SysUtils, Messages, Classes, Controls, Forms, StdCtrls,
{$IFDEF EH_LIB_5} Contnrs, {$ENDIF}
{$IFDEF EH_LIB_6} Variants, Types, {$ENDIF}
{$IFDEF EH_LIB_7} Themes, UxTheme, {$ENDIF}
{$IFDEF EH_LIB_17} System.UITypes, {$ENDIF}
{$IFDEF CIL}
  EhLibVCLNET,
  WinUtils,
{$ELSE}

  {$IFDEF FPC}
  EhLibLCL, LMessages, LCLType, Win32Extra,
  {$ELSE}
  EhLibVCL,
  {$ENDIF}

{$ENDIF}
  PropFilerEh,
  DBLookupUtilsEh, DBCtrlsEh,
  Graphics, GridsEh, DBCtrls, Db, Menus,
  ToolCtrlsEh, ImgList, ActnList,
  ExtCtrls, DynVarsEh, ToolWin,
  Comctrls, CommCtrl;

type

  TDBGridBarsState = (csDefault, csCustomized);

  TDrawDataCellEvent = procedure (Sender: TObject; const Rect: TRect; Field: TField;
    State: TGridDrawState) of object;

  TAxisBarEhValue = (cvColor, cvWidth, cvFont, cvAlignment, cvReadOnly, cvTitleColor,
    cvTitleCaption, cvTitleAlignment, cvTitleFont, cvTitleButton, cvTitleEndEllipsis,
    cvTitleToolTips, cvTitleOrientation, cvImeMode, cvImeName, cvWordWrap,
    cvLookupDisplayFields, cvCheckboxes, cvAlwaysShowEditButton, cvEndEllipsis,
    cvAutoDropDown, cvDblClickNextVal, cvToolTips, cvDropDownSizing,
    cvDropDownShowTitles, cvLayout, cvHighlightRequired, cvBiDiMode, cvTextEditing);
  TAxisBarEhValues = set of TAxisBarEhValue;

  TGridEditActionEh = (geaCutEh, geaCopyEh, geaPasteEh, geaDeleteEh, geaSelectAllEh);
  TGridEditActionsEh = set of TGridEditActionEh;

const
  cm_DeferLayout = WM_USER + 100;

  AxisBarEhTitleValues = [cvTitleColor..cvTitleOrientation];

type
  TAxisBarEh = class;
  TBaseColumnEh = class;
  TCustomDBAxisGridEh = class;
  TColumnDropDownBoxEh = class;
  TDBAxisGridEhCenter = class;

{    for lookup drop-down grid    }

  TDBLookupGridEhOption = (dlgColumnResizeEh, dlgColLinesEh, dlgRowLinesEh,
    dlgAutoSortMarkingEh, dlgMultiSortMarkingEh);
  TDBLookupGridEhOptions = set of TDBLookupGridEhOption;

  TDropDownBoxCheckTitleEhBtnEvent = procedure(Sender: TObject; ACol: Longint;
    Column: TBaseColumnEh; var Enabled: Boolean) of object;
  TDropDownBoxDrawColumnEhCellEvent = procedure(Sender: TObject; const Rect: TRect;
    DataCol: Integer; Column: TBaseColumnEh; State: TGridDrawState) of object;
  TDropDownBoxGetCellEhParamsEvent = procedure(Sender: TObject; Column: TBaseColumnEh;
    AFont: TFont; var Background: TColor; State: TGridDrawState) of object;
  TDropDownBoxTitleEhClickEvent = procedure(Sender: TObject; ACol: Longint;
    Column: TBaseColumnEh) of object;

{ ILookupGridOwner interface }

  ILookupGridOwner = interface
    ['{2A1F4552-15C3-4359-ADAB-F2F6719FAA97}']
    procedure SetListSource(AListSource: TDataSource);
    function GetLookupGrid: TCustomDBAxisGridEh;
    function GetOptions: TDBLookupGridEhOptions;
    procedure SetOptions(Value: TDBLookupGridEhOptions);
    property Options: TDBLookupGridEhOptions read GetOptions write SetOptions;
  end;

  TTextOrientationEh = (tohHorizontal, tohVertical);

  TSortMarkerStyleEh = (smstDefaultEh, smstClassicEh, smst3DFrameEh, smstFrameEh, smstSolidEh
    {$IFDEF EH_LIB_7}, smstThemeDefinedEh{$ENDIF});

  TIncludeImageModuleEh = (iimJpegImageModuleEh
    {$IFDEF EH_LIB_11} ,iimGIFImageModuleEh  {$ENDIF}
    {$IFDEF EH_LIB_12} ,iimPNGImageModuleEh {$ENDIF});
  TIncludeImageModulesEh = set of TIncludeImageModuleEh;

{ TAxisBarTitleEh }

  TAxisBarTitleEh = class(TPersistent)
  private
    FAlignment: TAlignment;
    FCaption: string;
    FColor: TColor;
    FAxisBar: TAxisBarEh;
    FEndEllipsis: Boolean;
    FFont: TFont;
    FHint: string;
    FImageIndex: Integer;
    FOrientation: TTextOrientationEh;
    FPopupMenu: TPopupMenu;
    FToolTips: Boolean;
    function GetAlignment: TAlignment;
    function GetCaption: string;
    function GetColor: TColor;
    function GetEndEllipsis: Boolean;
    function GetFont: TFont;
    function GetOrientation: TTextOrientationEh;
    function GetTitleButton: Boolean;
    function GetToolTips: Boolean;
    function IsAlignmentStored: Boolean;
    function IsCaptionStored: Boolean;
    function IsColorStored: Boolean;
    function IsEndEllipsisStored: Boolean;
    function IsFontStored: Boolean;
    function IsOrientationStored: Boolean;
    function IsTitleButtonStored: Boolean;
    function IsToolTipsStored: Boolean;
    procedure FontChanged(Sender: TObject);
    procedure SetAlignment(Value: TAlignment);
    procedure SetColor(Value: TColor);
    procedure SetEndEllipsis(const Value: Boolean);
    procedure SetFont(Value: TFont);
    procedure SetImageIndex(const Value: Integer);
    procedure SetOrientation(const Value: TTextOrientationEh);
    procedure SetPopupMenu(Value: TPopupMenu);
    procedure SetToolTips(const Value: Boolean);
  protected
    FTitleButton: Boolean;
    function DefaultOrientation: TTextOrientationEh;
    procedure RefreshDefaultFont;
    procedure SetCaption(const Value: string); virtual;
    procedure SetTitleButton(Value: Boolean);

    property Orientation: TTextOrientationEh read GetOrientation write SetOrientation stored IsOrientationStored;
    property PopupMenu: TPopupMenu read FPopupMenu write SetPopupMenu;
  public
    constructor Create(AxisBar: TAxisBarEh);
    destructor Destroy; override;

    function DefaultAlignment: TAlignment;
    function DefaultCaption: string;
    function DefaultColor: TColor;
    function DefaultEndEllipsis: Boolean;
    function DefaultFont: TFont;
    function DefaultTitleButton: Boolean;
    function DefaultToolTips: Boolean;
    procedure Assign(Source: TPersistent); override;
    procedure RestoreDefaults; virtual;

    property AxisBar: TAxisBarEh read FAxisBar;
  published
    property Alignment: TAlignment read GetAlignment write SetAlignment stored IsAlignmentStored;
    property Caption: string read GetCaption write SetCaption stored IsCaptionStored;
    property Color: TColor read GetColor write SetColor stored IsColorStored;
    property EndEllipsis: Boolean read GetEndEllipsis write SetEndEllipsis stored IsEndEllipsisStored;
    property Font: TFont read GetFont write SetFont stored IsFontStored;
    property Hint: string read FHint write FHint;
    property ImageIndex: Integer read FImageIndex write SetImageIndex default -1;
    property TitleButton: Boolean read GetTitleButton write SetTitleButton stored IsTitleButtonStored;
    property ToolTips: Boolean read GetToolTips write SetToolTips stored IsToolTipsStored;
  end;

  TAxisBarEhType = (ctCommon, ctPickList, ctLookupField, ctKeyPickList, ctKeyImageList,
    ctCheckboxes, ctGraphicData, ctDataList);
  TCellButtonStyleEh = (cbsAuto, cbsEllipsis, cbsNone, cbsUpDown, cbsDropDown,
    cbsAltUpDown, cbsAltDropDown);

{ TAxisBarCaptionDefValuesEh }

  TAxisBarDefValuesEh = class;

  TAxisBarCaptionDefValuesEhValue = (cvdpTitleColorEh, cvdpTitleAlignmentEh);
  TAxisBarCaptionDefValuesEhValues = set of TAxisBarCaptionDefValuesEhValue;

  TAxisBarCaptionDefValuesEh = class(TPersistent)
  private
    FAlignment: TAlignment;
    FAssignedValues: TAxisBarCaptionDefValuesEhValues;
    FColor: TColor;
    FColumnDefValues: TAxisBarDefValuesEh;
    FEndEllipsis: Boolean;
    FOrientation: TTextOrientationEh;
    FTitleButton: Boolean;
    FToolTips: Boolean;

    function DefaultAlignment: TAlignment;
    function DefaultColor: TColor;
    function GetAlignment: TAlignment;
    function GetColor: TColor;
    function IsAlignmentStored: Boolean;
    function IsColorStored: Boolean;

    procedure SetAlignment(const Value: TAlignment);
    procedure SetColor(const Value: TColor);
    procedure SetEndEllipsis(const Value: Boolean);
    procedure SetOrientation(const Value: TTextOrientationEh);
  protected
    property ColumnDefValues: TAxisBarDefValuesEh read FColumnDefValues;
  public
    constructor Create(AxisBarDefValues: TAxisBarDefValuesEh);
    procedure Assign(Source: TPersistent); override;
    property AssignedValues: TAxisBarCaptionDefValuesEhValues read FAssignedValues;
  protected
    property Alignment: TAlignment read GetAlignment write SetAlignment stored IsAlignmentStored;
    property Color: TColor read GetColor write SetColor stored IsColorStored;
    property EndEllipsis: Boolean read FEndEllipsis write SetEndEllipsis default False;
    property Orientation: TTextOrientationEh read FOrientation write SetOrientation default tohHorizontal;
    property TitleButton: Boolean read FTitleButton write FTitleButton default False;
    property ToolTips: Boolean read FToolTips write FToolTips default False;
  end;

{ TColumnFooterDefValuesEh }

  TColumnFooterDefValuesEh = class(TPersistent)
  private
    FToolTips: Boolean;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property ToolTips: Boolean read FToolTips write FToolTips default False;
  end;

{ TAxisBarDefValuesEh }

  TAxisBarDefValuesEh = class(TPersistent)
  private
    FAlwaysShowEditButton: Boolean;
    FAutoDropDown: Boolean;
    FDblClickNextVal: Boolean;
    FDropDownShowTitles: Boolean;
    FDropDownSizing: Boolean;
    FEndEllipsis: Boolean;
    FLayout: TTextLayout;
    FHighlightRequired: Boolean;
    FGrid: TCustomDBAxisGridEh;
    FTitle: TAxisBarCaptionDefValuesEh;
    FToolTips: Boolean;
    procedure SetAlwaysShowEditButton(const Value: Boolean);
    procedure SetEndEllipsis(const Value: Boolean);
    procedure SetHighlightRequired(Value: Boolean);
    procedure SetLayout(Value: TTextLayout);
    procedure SetTitle(const Value: TAxisBarCaptionDefValuesEh);
  protected
    function CreateAxisBarCaptionDefValues: TAxisBarCaptionDefValuesEh; virtual;

    property AlwaysShowEditButton: Boolean read FAlwaysShowEditButton write SetAlwaysShowEditButton default False;
    property AutoDropDown: Boolean read FAutoDropDown write FAutoDropDown default False;
    property DblClickNextVal: Boolean read FDblClickNextVal write FDblClickNextVal default False;
    property DropDownShowTitles: Boolean read FDropDownShowTitles write FDropDownShowTitles default False;
    property DropDownSizing: Boolean read FDropDownSizing write FDropDownSizing default False;
    property EndEllipsis: Boolean read FEndEllipsis write SetEndEllipsis default False;
    property HighlightRequired: Boolean read FHighlightRequired write SetHighlightRequired default False;
    property Layout: TTextLayout read FLayout write SetLayout default tlTop;
    property Title: TAxisBarCaptionDefValuesEh read FTitle write SetTitle;
    property ToolTips: Boolean read FToolTips write FToolTips default False;
  public
    constructor Create(Grid: TCustomDBAxisGridEh);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;

    property Grid: TCustomDBAxisGridEh read FGrid;
  end;

{ TCustomColumnDefValuesEh }

  TCustomColumnDefValuesEh = class(TAxisBarDefValuesEh)
  public
    property AlwaysShowEditButton;
    property AutoDropDown;
    property DblClickNextVal;
    property DropDownShowTitles;
    property DropDownSizing;
    property EndEllipsis;
    property HighlightRequired;
    property Layout;
    property Title;
    property ToolTips;
  end;

{ TAxisColCellParamsEh }

  TAxisColCellParamsEh = class(TObject)
  protected
    FAlignment: TAlignment;
    FBlankCell: Boolean;
    FBackground: TColor;
    FSuppressActiveCellColor: Boolean;
    FCheckboxState: TCheckBoxState;
    FCol: Longint;
    FFont: TFont;
    FImageIndex: Integer;
    FReadOnly: Boolean;
    FRow: Longint;
    FState: TGridDrawState;
    FText: String;
    FTextEditing: Boolean;
    FCellRect: TRect;
    FThe3DRect: Boolean;
    FXFrameOffs: Byte;
    FYFrameOffs: Byte;
    FDrawCellByThemes: Boolean;
  public
    property Alignment: TAlignment read FAlignment write FAlignment;
    property Background: TColor read FBackground write FBackground;
    property BlankCell: Boolean read FBlankCell write FBlankCell;
    property SuppressActiveCellColor: Boolean read FSuppressActiveCellColor write FSuppressActiveCellColor;
    property CheckboxState: TCheckBoxState read FCheckboxState write FCheckboxState;
    property Col: Longint read FCol write FCol;
    property CellRect: TRect read FCellRect;
    property Font: TFont read FFont write FFont;
    property ImageIndex: Integer read FImageIndex write FImageIndex;
    property ReadOnly: Boolean read FReadOnly write FReadOnly;
    property Row: Longint read FRow write FRow;
    property State: TGridDrawState read FState write FState;
    property Text: String read FText write FText;
    property TextEditing: Boolean read FTextEditing write FTextEditing;
    property DrawCellByThemes: Boolean read FDrawCellByThemes write FDrawCellByThemes;
  end;

{ TAxisBarMainEditButtonEh }

  TAxisBarMainEditButtonEh = class(TEditButtonEh)
  private
    FAxisBar: TAxisBarEh;
    FVisible: Boolean;
    FVisibleStored: Boolean;
    function IsVisibleStored: Boolean;
    procedure SetVisibleStored(const Value: Boolean);
    procedure SetAxisBarButtonStyle(const Value: TCellButtonStyleEh);
    function GetAxisBarButtonStyle: TCellButtonStyleEh;
  protected
    function GetVisible: Boolean; override;
    procedure SetVisible(const Value: Boolean); override;
  public
    constructor Create(AxisBar: TAxisBarEh); overload;
    function DefaultVisible: Boolean; virtual;
    property AxisBarButtonStyle: TCellButtonStyleEh read GetAxisBarButtonStyle write SetAxisBarButtonStyle default cbsAuto;
  published
    property Visible: Boolean read GetVisible write SetVisible stored IsVisibleStored;
    property VisibleStored: Boolean read IsVisibleStored write SetVisibleStored stored False;
  end;

{ TAxisBarEh }

  TDBAxisGridDataHintParamsEh = class(TObject)
  public
    HintPos: TPoint;
    HintMaxWidth: Integer;
    HintColor: TColor;
    HintFont: TFont;
    CursorRect: TRect;
    ReshowTimeout: Integer;
    HideTimeout: Integer;
    HintStr: string;
  end;

  TColCellUpdateDataEventEh = procedure(Sender: TObject; var Text: String;
    var Value: Variant; var UseText: Boolean; var Handled: Boolean) of object;

  TDBAxisGridShowDropDownFormEventEh = procedure(Grid: TCustomDBAxisGridEh;
    Column: TAxisBarEh; Button: TEditButtonEh; var DropDownForm: TCustomForm;
    DynParams: TDynVarsEh) of object;

  TDBAxisGridCloseDropDownFormEventEh = procedure(Grid: TCustomDBAxisGridEh;
    Column: TAxisBarEh; Button: TEditButtonEh; Accept: Boolean;
    DropDownForm: TCustomForm; DynParams: TDynVarsEh) of object;

//  TAxisBarEh = class(TAxisBarEh, ILookupGridOwner {$IFNDEF CIL}, IUnknown {$ENDIF})
  TAxisBarEh = class(TCollectionItem, ILookupGridOwner {$IFNDEF CIL}, IUnknown {$ENDIF})
  private
    FAlignment: TAlignment;
    FAssignedValues: TAxisBarEhValues;
    FBiDiMode: TBiDiMode;
    FButtonStyle: TCellButtonStyleEh;
    FCaseInsensitiveTextSearch: Boolean;
    FCheckboxes: Boolean;
    FColor: TColor;
    FDblClickNextVal: Boolean;
    FDisplayFormat: string;
    FDropDownBox: TColumnDropDownBoxEh;
    FDropDownFormParams: TDropDownFormCallParamsEh;
    FDropDownRows: Cardinal;
    FDropDownShowTitles: Boolean;
    FDropDownSizing: Boolean;
    FDropDownSpecRow: TSpecRowEh;
    FDynProps: TDynVarsEh;
    FEditButton: TAxisBarMainEditButtonEh;
    FEditButtons: TEditButtonsEh;
    FEditMask: string;
    FFieldName: string;
    FFont: TFont;
    FHighlightRequired: Boolean;
    FImageChangeLink: TChangeLink;
    FImageList: TCustomImageList;
    FIncrement: Extended;
    {$IFDEF FPC}
    {$ELSE}
    FImeMode: TImeMode;
    FImeName: TImeName;
    {$ENDIF}
    FKeyList: TStrings;
    FLayout: TTextLayout;
    FLimitTextToListValues: Boolean;
    FLimitTextToListValuesStored: Boolean;
    FLookupParams: TDBLookupDataEh;
    FMRUList: TMRUListEh;
    FNotInKeyListIndex: Integer;
    FPickList: TStrings;
    FPopupMenu: TPopupMenu;
    FReadonly: Boolean;
    FShowImageAndText: Boolean;
    FStored: Boolean;
    FSystemPopupMenu: TPopupMenu;
    FTag: Longint;
    FTextEditing: Boolean;
    FTitle: TAxisBarTitleEh;
    FToolTips: Boolean;
    FVisible: Boolean;

    FOnButtonClick: TButtonClickEventEh;
    FOnButtonDown: TButtonDownEventEh;
    FOnCloseDropDownForm: TDBAxisGridCloseDropDownFormEventEh;
    FOnNotInList: TNotInListEventEh;
    FOnOpenDropDownForm: TDBAxisGridShowDropDownFormEventEh;
    FOnUpdateData: TColCellUpdateDataEventEh;

    {$IFDEF FPC}
    {$ELSE}
    function GetImeMode: TImeMode;
    function GetImeName: TImeName;
    function IsImeModeStored: Boolean;
    function IsImeNameStored: Boolean;
    {$ENDIF}
    function DefaultCheckboxes: Boolean;
    function DefaultLimitTextToListValues: Boolean;
    function GetAlignment: TAlignment;
    function GetAlwaysShowEditButton: Boolean;
    function GetAutoDropDown: Boolean;
    function GetBiDiMode: TBiDiMode;
    function GetButtonStyle: TCellButtonStyleEh;
    function GetCheckboxes: Boolean;
    function GetCheckboxState: TCheckBoxState;
    function GetColor: TColor;
    function GetDataList: TCustomDBAxisGridEh;
    function GetDblClickNextVal: Boolean;
    function GetDropDownShowTitles: Boolean;
    function GetDropDownSizing: Boolean;
    function GetEditButtonPressed: Boolean;
    function GetEndEllipsis: Boolean;
    function GetFont: TFont;
    function GetHighlightRequired: Boolean;
    function GetKeykList: TStrings;
    function GetLayout: TTextLayout;
    function GetLimitTextToListValues: Boolean;
    function GetName: String;
    function GetOnDropDownBoxCheckButton: TDropDownBoxCheckTitleEhBtnEvent;
    function GetOnDropDownBoxDrawColumnCell: TDropDownBoxDrawColumnEhCellEvent;
    function GetOnDropDownBoxGetCellParams: TDropDownBoxGetCellEhParamsEvent;
    function GetOnDropDownBoxSortMarkingChanged: TNotifyEvent;
    function GetOnDropDownBoxTitleBtnClick: TDropDownBoxTitleEhClickEvent;
    function GetPickList: TStrings;
    function GetReadOnly: Boolean;
    function GetShowImageAndText: Boolean;
    function GetTextEditing: Boolean;
    function GetToolTips: Boolean;
    function IsAlignmentStored: Boolean;
    function IsAlwaysShowEditButtonStored: Boolean;
    function IsAutoDropDownStored: Boolean;
    function IsBiDiModeStored: Boolean;
    function IsCheckboxesStored: Boolean;
    function IsColorStored: Boolean;
    function IsDblClickNextValStored: Boolean;
    function IsDropDownShowTitlesStored: Boolean;
    function IsDropDownSizingStored: Boolean;
    function IsEndEllipsisStored: Boolean;
    function IsFontStored: Boolean;
    function IsIncrementStored: Boolean;
    function IsLimitTextToListValuesStored: Boolean;
    function IsReadOnlyStored: Boolean;
    function IsTextEditingStored: Boolean;
    function IsToolTipsStored: Boolean;

    procedure EditButtonChanged(Sender: TObject);
    procedure ImageListChange(Sender: TObject);
    procedure SetBiDiMode(Value: TBiDiMode);
    procedure SetButtonStyle(Value: TCellButtonStyleEh);
    procedure SetCheckboxes(const Value: Boolean);
    procedure SetCheckboxState(const Value: TCheckBoxState);
    procedure SetColor(Value: TColor);
    procedure SetDblClickNextVal(const Value: Boolean);
    procedure SetDisplayFormat(const Value: string);
    procedure SetDropDownBox(const Value: TColumnDropDownBoxEh);
    procedure SetDropDownFormParams(const Value: TDropDownFormCallParamsEh);
    procedure SetDropDownShowTitles(const Value: Boolean);
    procedure SetDropDownSizing(const Value: Boolean);
    procedure SetDropDownSpecRow(const Value: TSpecRowEh);
    procedure SetDynProps(const Value: TDynVarsEh);
    procedure SetEditButton(const Value: TAxisBarMainEditButtonEh);
    procedure SetEditButtonPressed(const Value: Boolean);
    procedure SetEditButtons(const Value: TEditButtonsEh);
    procedure SetEditMask(const Value: string);
    procedure SetFieldName(const Value: String);
    procedure SetFont(Value: TFont);
    procedure SetImageList(const Value: TCustomImageList);
    procedure SetKeykList(const Value: TStrings);
    procedure SetLayout(Value: TTextLayout);
    procedure SetLimitTextToListValues(const Value: Boolean);
    procedure SetLimitTextToListValuesStored(const Value: Boolean);
    procedure SetLookupParams(const Value: TDBLookupDataEh);
    procedure SetMRUList(const Value: TMRUListEh);
    procedure SetNotInKeyListIndex(const Value: Integer);
    procedure SetOnDropDownBoxCheckButton(const Value: TDropDownBoxCheckTitleEhBtnEvent);
    procedure SetOnDropDownBoxDrawColumnCell(const Value: TDropDownBoxDrawColumnEhCellEvent);
    procedure SetOnDropDownBoxGetCellParams(const Value: TDropDownBoxGetCellEhParamsEvent);
    procedure SetOnDropDownBoxSortMarkingChanged(const Value: TNotifyEvent);
    procedure SetOnDropDownBoxTitleBtnClick(const Value: TDropDownBoxTitleEhClickEvent);
    procedure SetPickList(Value: TStrings);
    procedure SetPopupMenu(Value: TPopupMenu);
    procedure SetShowImageAndText(const Value: Boolean);
    procedure SetTextEditing(const Value: Boolean);
    procedure SetTitle(Value: TAxisBarTitleEh);
    procedure SetToolTips(const Value: Boolean);
    procedure SetVisible(const Value: Boolean);

  protected
    FAlwaysShowEditButton: Boolean;
    FAutoDropDown: Boolean;
    FCheckModifyColCellParamsEh: TAxisColCellParamsEh;
    FDataList: TCustomDBAxisGridEh;
    FDropDownWidth: Integer;
    FDTListSource: TDataSource;
    FEndEllipsis: Boolean;
    FInplaceEditorButtonHeight: Integer;
    FLookupDisplayFields: String;
    FWordWrap: Boolean;
    FField: TField;

    function AxisBarRect(const AGridCellRect: TRect): TRect; virtual;
    function CalcInplaceEditorButtonHeight: Integer; virtual;
    function CanEditShow: Boolean;
    function CreateEditButton: TEditButtonEh; virtual;
    function CreateEditButtons: TEditButtonsEh; virtual;
    function CreateFirstEditButton: TAxisBarMainEditButtonEh; virtual;
    function CreateLookupData: TDBLookupDataEh; virtual;
    function CreateTitle: TAxisBarTitleEh; virtual;
    function DefaultAlwaysShowEditButton: Boolean;
    function DefaultAutoDropDown: Boolean;
    function DefaultDblClickNextVal: Boolean;
    function DefaultDropDownShowTitles: Boolean;
    function DefaultDropDownSizing: Boolean;
    function DefaultEndEllipsis: Boolean;
    function DefaultHighlightRequired: Boolean;
    function DefaultLayout: TTextLayout;
    function DefaultLookupDisplayFields: String;
    function DefaultTextEditing: Boolean;
    function DefaultToolTips: Boolean;
    function DefaultWordWrap: Boolean;
    function FullListDataSet: TDataSet;
    function GetDisplayName: string; override;
    function GetEditMask: string;
    function GetEditText: String;
    function GetField: TField; virtual;
    function GetGrid: TCustomDBAxisGridEh;
    function GetLookupDisplayFields: String;
    function GetWordWrap: Boolean;
    function InplaceEditorButtonHeight: Integer; virtual;
    function InplaceEditorButtonWidth: Integer; virtual;
    function IsDrawEditButton(ACol, ARow: Integer): Boolean; virtual;
    function IsEditButtonsBoxRequired: Boolean; virtual;
    function IsHighlightRequiredStored: Boolean;
    function IsLayoutStored: Boolean;
    function IsLookupDisplayFieldsStored: Boolean;
    function IsTabStop: Boolean;
    function IsWordWrapStored: Boolean;
    function SeenPassthrough: Boolean; virtual;
    function UsedLookupDataSet: TDataSet;

    {$IFDEF FPC}
    {$ELSE}
    procedure SetImeMode(Value: TImeMode); virtual;
    procedure SetImeName(Value: TImeName); virtual;
    {$ENDIF}
    procedure Changed(AllItems: Boolean); virtual;
    procedure CheckDataIsReadOnly(var ReadOnly: Boolean); virtual;
    procedure DropDownFormParamsChanged(Sender: TObject);
    procedure EditButtonClick(Sender: TObject); virtual;
    procedure EditButtonDown(Sender: TObject; TopButton: Boolean; var AutoRepeat: Boolean; var Handled: Boolean); virtual;
    procedure EditButtonMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer); virtual;
    procedure EditButtonMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;
    procedure FontChanged(Sender: TObject); virtual;
    procedure LookupStateChanged; virtual;
    procedure RecordChanged(Field: TField); virtual;
    procedure RefreshDefaultFont;
    procedure SetAlignment(Value: TAlignment); virtual;
    procedure SetAlwaysShowEditButton(Value: Boolean);
    procedure SetAutoDropDown(Value: Boolean);
    procedure SetDropDownWidth(Value: Integer);
    procedure SetEditText(const Value: string);
    procedure SetEndEllipsis(const Value: Boolean);
    procedure SetField(Value: TField); virtual;
    procedure SetHighlightRequired(Value: Boolean); virtual;
    procedure SetIndex(Value: Integer); override;
    procedure SetLookupDisplayFields(Value: String); virtual;
    procedure SetNextFieldValue(Increment: Extended);
    procedure SetReadOnly(Value: Boolean); virtual;
    procedure SetTextArea(var CellRect: TRect); virtual;
    procedure SetWordWrap(Value: Boolean); virtual;
    procedure SpecRowChanged(Sender: TObject); virtual;
    procedure UpdateDataValues(Text: String; Value: Variant; UseText: Boolean);
    procedure UpdateEditButtonControlList(AEditButtonsBox: TEditButtonsBoxEh; const AxisBarRect: TRect); virtual;
    procedure UpdateEditButtonControlsState(AEditButtonsBox: TEditButtonsBoxEh; const AxisBarRect: TRect); virtual;
    procedure UpdateEditButtonsBox(AEditButtonsBox: TEditButtonsBoxEh; const AxisBarRect: TRect); virtual;

    property DropDownFormParams: TDropDownFormCallParamsEh read FDropDownFormParams write SetDropDownFormParams;
    property IsStored: Boolean read FStored write FStored default True;

    property OnCloseDropDownForm: TDBAxisGridCloseDropDownFormEventEh read FOnCloseDropDownForm write FOnCloseDropDownForm;
    property OnOpenDropDownForm: TDBAxisGridShowDropDownFormEventEh read FOnOpenDropDownForm write FOnOpenDropDownForm;

  protected
    { ILookupGridOwner }
    function GetLookupGrid: TCustomDBAxisGridEh;
    function GetOptions: TDBLookupGridEhOptions;

    procedure ILookupGridOwner.SetListSource = SetDropDownBoxListSource;
    procedure SetDropDownBoxListSource(AListSource: TDataSource);
    procedure SetOptions(Value: TDBLookupGridEhOptions);
{$IFNDEF CIL}
    { IInterface }
  {$IFDEF FPC}
    function QueryInterface(constref IID: TGUID; out Obj): HResult; virtual; stdcall;
  {$ELSE}
    function QueryInterface(const IID: TGUID; out Obj): HResult; virtual; stdcall;
  {$ENDIF}
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
{$ENDIF}

  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;

  {$IFDEF FPC}
  {$ELSE}
    function DefaultImeMode: TImeMode; virtual;
    function DefaultImeName: TImeName; virtual;
  {$ENDIF}

    function CalcRowHeight: Integer; virtual;
    function CanEditAcceptKey(Key: Char): Boolean;
    function CanModify(TryEdit: Boolean): Boolean;
    function CurLineWordWrap(RowHeight: Integer): Boolean; virtual;
    function DefaultAlignment: TAlignment; virtual;
    function DefaultColor: TColor; virtual;
    function DefaultFont: TFont; virtual;
    function DefaultReadOnly: Boolean; virtual;
    function DisplayText: String; virtual;
    function DrawTextBiDiModeFlagsReadingOnly: Longint;
    function EditButtonsWidth: Integer; virtual;
    function EditText: String; virtual;
    function EditValue: Variant; virtual;
    function GetAcceptableEditText(InputEditText: String): String;
    function GetBarType: TAxisBarEhType; virtual;
    function GetCellHeight(Row: Integer): Integer;
    function GetDataCellHorzOffset: Integer; virtual;
    function GetDropDownBoxListField: String; virtual;
    function GetImageIndex: Integer; virtual;
    function GetPictureFromBlobField: TPicture;
    function GetPopupMenu: TPopupMenu; virtual;
    function GetSystemPopupMenu: TPopupMenu; virtual;
    function LocatePickList(const Str: String; const PartialKey: Boolean): Integer;
    function UseRightToLeftAlignment: Boolean; virtual;
    function UseRightToLeftReading: Boolean; virtual;
    function UseRightToLeftScrollBar: Boolean; virtual;

    procedure Assign(Source: TPersistent); override;
    procedure BindField; virtual;
    procedure ClearValue; virtual;
    procedure CopyValueToClipboard; virtual;
    procedure CutValueToClipboard; virtual;
    procedure DefaultDropDownBoxApplyTextFilter(DataSet: TDataSet; FieldName: String; Operation: TLSAutoFilterTypeEh; FilterText: String);
    procedure DefineProperties(Filer: TFiler); override;
    procedure DropDown;
    procedure DropDownBoxApplyTextFilter(DataSet: TDataSet; FieldName: String; Operation: TLSAutoFilterTypeEh; FilterText: String); virtual;
    procedure FillColCellParams(ColCellParamsEh: TAxisColCellParamsEh);
    procedure FormSystemPopupMenu(APopupMenu: TPopupMenu); virtual;
    procedure GetColCellParams(EditMode: Boolean; ColCellParamsEh: TAxisColCellParamsEh); virtual;
    procedure LoadFromFileDialog; virtual;
    procedure PasteValueFromClipboard; virtual;
    procedure RestoreDefaults; virtual;
    procedure SaveToFileDialog; virtual;
    procedure SetValueAsText(const StrVal: String);
    procedure SetValueAsVariant(VarVal: Variant);

    property AssignedValues: TAxisBarEhValues read FAssignedValues write FAssignedValues;
    property CheckboxState: TCheckBoxState read GetCheckboxState write SetCheckboxState;
    property DataList: TCustomDBAxisGridEh read GetDataList;
    property Field: TField read GetField write SetField;
    property Grid: TCustomDBAxisGridEh read GetGrid;
    property LookupParams: TDBLookupDataEh read FLookupParams write SetLookupParams;
    property Visible: Boolean read FVisible write SetVisible default True;

  protected
  {$IFDEF FPC}
  {$ELSE}
    property ImeMode: TImeMode read GetImeMode write SetImeMode stored IsImeModeStored;
    property ImeName: TImeName read GetImeName write SetImeName stored IsImeNameStored;
  {$ENDIF}

    property Alignment: TAlignment read GetAlignment write SetAlignment stored IsAlignmentStored;
    property AlwaysShowEditButton: Boolean read GetAlwaysShowEditButton write SetAlwaysShowEditButton stored IsAlwaysShowEditButtonStored;
    property AutoDropDown: Boolean read GetAutoDropDown write SetAutoDropDown stored IsAutoDropDownStored;
    property BiDiMode: TBiDiMode read GetBiDiMode write SetBiDiMode stored IsBiDiModeStored;
    property ButtonStyle: TCellButtonStyleEh read GetButtonStyle write SetButtonStyle default cbsAuto;
    property CaseInsensitiveTextSearch: Boolean read FCaseInsensitiveTextSearch write FCaseInsensitiveTextSearch default True;
    property Checkboxes: Boolean read GetCheckboxes write SetCheckboxes stored IsCheckboxesStored;
    property Color: TColor read GetColor write SetColor stored IsColorStored;
    property DblClickNextVal: Boolean read GetDblClickNextVal write SetDblClickNextVal stored IsDblClickNextValStored;
    property DisplayFormat: string read FDisplayFormat write SetDisplayFormat;
    property DropDownBox: TColumnDropDownBoxEh read FDropDownBox write SetDropDownBox;
    property DropDownRows: Cardinal read FDropDownRows write FDropDownRows default 7; // obsolete
    property DropDownShowTitles: Boolean read GetDropDownShowTitles write SetDropDownShowTitles stored IsDropDownShowTitlesStored;
    property DropDownSizing: Boolean read GetDropDownSizing write SetDropDownSizing stored IsDropDownSizingStored;
    property DropDownSpecRow: TSpecRowEh read FDropDownSpecRow write SetDropDownSpecRow;
    property DropDownWidth: Integer read FDropDownWidth write SetDropDownWidth default 0;
    property DynProps: TDynVarsEh read FDynProps write SetDynProps;
    property EditButton: TAxisBarMainEditButtonEh read FEditButton write SetEditButton;
    property EditButtonPressed: Boolean read GetEditButtonPressed write SetEditButtonPressed;
    property EditButtons: TEditButtonsEh read FEditButtons write SetEditButtons;
    property EditMask: string read FEditMask write SetEditMask;
    property EndEllipsis: Boolean read GetEndEllipsis write SetEndEllipsis stored IsEndEllipsisStored;
    property FieldName: String read FFieldName write SetFieldName;
    property Font: TFont read GetFont write SetFont stored IsFontStored;
    property HighlightRequired: Boolean read GetHighlightRequired write SetHighlightRequired stored IsHighlightRequiredStored;
    property ImageList: TCustomImageList read FImageList write SetImageList;
    property Increment: Extended read FIncrement write FIncrement stored IsIncrementStored;
    property KeyList: TStrings read GetKeykList write SetKeykList;
    property Layout: TTextLayout read GetLayout write SetLayout stored IsLayoutStored;
    property LimitTextToListValues: Boolean read GetLimitTextToListValues write SetLimitTextToListValues stored IsLimitTextToListValuesStored;
    property LimitTextToListValuesStored: Boolean read IsLimitTextToListValuesStored write SetLimitTextToListValuesStored stored False;
    property LookupDisplayFields: String read GetLookupDisplayFields write SetLookupDisplayFields stored IsLookupDisplayFieldsStored;
    property MRUList: TMRUListEh read FMRUList write SetMRUList;
    property Name: String read GetName;
    property NotInKeyListIndex: Integer read FNotInKeyListIndex write SetNotInKeyListIndex default -1;
    property PickList: TStrings read GetPickList write SetPickList;
    property PopupMenu: TPopupMenu read FPopupMenu write SetPopupMenu;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly stored IsReadOnlyStored;
    property ShowImageAndText: Boolean read GetShowImageAndText write SetShowImageAndText default False;
    property Tag: Longint read FTag write FTag default 0;
    property TextEditing: Boolean read GetTextEditing write SetTextEditing stored IsTextEditingStored;
    property Title: TAxisBarTitleEh read FTitle write SetTitle;
    property ToolTips: Boolean read GetToolTips write SetToolTips stored IsToolTipsStored;
    property WordWrap: Boolean read GetWordWrap write SetWordWrap stored IsWordWrapStored;

//    property OnGetItemImageIndex: TListGetImageIndexEventEh read FOnGetItemImageIndex write FOnGetItemImageIndex;
    property OnDropDownBoxCheckButton: TDropDownBoxCheckTitleEhBtnEvent read GetOnDropDownBoxCheckButton write SetOnDropDownBoxCheckButton;
    property OnDropDownBoxDrawColumnCell: TDropDownBoxDrawColumnEhCellEvent read GetOnDropDownBoxDrawColumnCell write SetOnDropDownBoxDrawColumnCell;
    property OnDropDownBoxGetCellParams: TDropDownBoxGetCellEhParamsEvent read GetOnDropDownBoxGetCellParams write SetOnDropDownBoxGetCellParams;
    property OnDropDownBoxSortMarkingChanged: TNotifyEvent read GetOnDropDownBoxSortMarkingChanged write SetOnDropDownBoxSortMarkingChanged;
    property OnDropDownBoxTitleBtnClick: TDropDownBoxTitleEhClickEvent read GetOnDropDownBoxTitleBtnClick write SetOnDropDownBoxTitleBtnClick;
    property OnEditButtonClick: TButtonClickEventEh read FOnButtonClick write FOnButtonClick;
    property OnEditButtonDown: TButtonDownEventEh read FOnButtonDown write FOnButtonDown;
    property OnNotInList: TNotInListEventEh read FOnNotInList write FOnNotInList;
    property OnUpdateData: TColCellUpdateDataEventEh read FOnUpdateData write FOnUpdateData;
  end;

  TAxisBarEhClass = class of TAxisBarEh;

  TBaseColumnEh = class(TAxisBarEh)
  protected
    function GetAutoFitColWidth: Boolean; virtual; abstract;
    function GetWidth: Integer; virtual; abstract;
    function GetMinWidth: Integer; virtual; abstract;
    function GetMaxWidth: Integer; virtual; abstract;

    procedure SetAutoFitColWidth(const Value: Boolean); virtual; abstract;
    procedure SetMaxWidth(const Value: Integer); virtual; abstract;
    procedure SetMinWidth(const Value: Integer); virtual; abstract;
    procedure SetWidth(const Value: Integer); virtual; abstract;
  public
  {$IFDEF FPC}
  {$ELSE}
    property ImeMode;
    property ImeName;
  {$ENDIF}

    property Alignment;
    property AutoFitColWidth: Boolean read GetAutoFitColWidth write SetAutoFitColWidth default True;
    property CaseInsensitiveTextSearch;
    property Checkboxes;
    property Color;
    property EndEllipsis;
    property FieldName;
    property Font;
    property ImageList;
    property KeyList;
    property MaxWidth: Integer read GetMaxWidth write SetMaxWidth default 0;
    property MinWidth: Integer read GetMinWidth write SetMinWidth default 0;
    property NotInKeyListIndex;
    property PickList;
    property PopupMenu;
    property ShowImageAndText;
    property Tag;
    property Title;
    property ToolTips;
    property Visible;
    property Width: Integer read GetWidth write SetWidth;
  end;

  TGridAxisBarsNotificationEh = (gabnAddedEh, gabnExtractingEh,
    gabnIndexChangingEh, gabnItemOrdersChangedEh);

{ TGridAxisBarsEh }

  TGridAxisBarsEh = class(TCollection)
  private
    FGrid: TCustomDBAxisGridEh;
    function GetAxisBar(Index: Integer): TAxisBarEh;
    function GetState: TDBGridBarsState;
    function InternalAdd: TAxisBarEh;
    procedure SetAxisBar(Index: Integer; Value: TAxisBarEh);
    procedure SetState(NewState: TDBGridBarsState);
  protected
    function CheckAxisBarsToFieldsNoOrders: Boolean; virtual;
    function GetUpdateCount: Integer;
    function GetOwner: TPersistent; override;
    function IndexSeenPassthrough: Boolean; virtual;
    procedure BarsNotify(Item: TAxisBarEh; Action: TGridAxisBarsNotificationEh); virtual;
{$IFDEF EH_LIB_6}
    procedure Notify(Item: TCollectionItem; Action: TCollectionNotification); override;
{$ENDIF}
    procedure Update(Item: TCollectionItem); override;
    property UpdateCount: Integer read GetUpdateCount;
  public
    constructor Create(Grid: TCustomDBAxisGridEh; ColumnClass: TAxisBarEhClass);

    function Add: TAxisBarEh;
    function CheckItemInList(AxisBar: TAxisBarEh): Boolean;
    function FindBarByName(const ColumnName: String): TAxisBarEh;

    procedure ActiveChanged; virtual;
    procedure AddAllBars(DeleteExisting: Boolean);
    procedure Assign(Source: TPersistent); override;
    procedure GetBarNames(List: TStrings);
    procedure LoadFromFile(const Filename: string);
    procedure LoadFromStream(S: TStream);
    procedure RebuildBars;
    procedure RestoreDefaults;
    procedure SaveToFile(const Filename: string);
    procedure SaveToStream(S: TStream);

    property Grid: TCustomDBAxisGridEh read FGrid;
    property Items[Index: Integer]: TAxisBarEh read GetAxisBar write SetAxisBar; default;
    property State: TDBGridBarsState read GetState write SetState;
  end;

 { TBaseColumnsEh }

  TBaseColumnsEh = class(TGridAxisBarsEh)
  private
    function GetColumn(Index: Integer): TBaseColumnEh;
    procedure SetColumn(Index: Integer; const Value: TBaseColumnEh);
  public
    property Items[Index: Integer]: TBaseColumnEh read GetColumn write SetColumn; default;
  end;

{ TAxisBarsEhList }

  TAxisBarsEhList = class(TObjectList)
  private
    function GetAxisBar(Index: Integer): TAxisBarEh;
    procedure SetAxisBar(Index: Integer; const Value: TAxisBarEh);
  public
    constructor Create; overload;
    property Items[Index: Integer]: TAxisBarEh read GetAxisBar write SetAxisBar; default;
  end;

{ TAxisGridDataLinkEh }

  TAxisGridDataLinkEh = class(TDataLink)
  private
    FFieldCount: Integer;
    FFieldMap: array of Integer;
    FFieldMapSize: Integer;
    FGrid: TCustomDBAxisGridEh;
    FInUpdateData: Boolean;
    FSparseMap: Boolean;

    function GetDefaultFields: Boolean;
    function GetFields(I: Integer): TField;
  protected
    FModified: Boolean;
    FLastBookmark: TUniBookmarkEh;
    FLastDataSetState: TDataSetState;
    function GetMappedIndex(ColIndex: Integer): Integer;
    procedure ActiveChanged; override;
{$IFDEF CIL}
    procedure DataEvent(Event: TDataEvent; Info: TObject); override;
{$ELSE}
  {$IFDEF EH_LIB_16}
    procedure DataEvent(Event: TDataEvent; Info: NativeInt); override;
  {$ELSE}
    procedure DataEvent(Event: TDataEvent; Info: Integer); override;
  {$ENDIF}
{$ENDIF}
    procedure DataSetChanged; override;
    procedure DataSetScrolled(Distance: Integer); override;
    procedure EditingChanged; override;
{$IFDEF CIL}
    procedure FocusControl(const Field: TField); override;
{$ELSE}
    procedure FocusControl(Field: TFieldRef); override;
{$ENDIF}
    procedure LayoutChanged; override;
    procedure RecordChanged(Field: TField); override;
    procedure UpdateData; override;
    procedure CheckBrowseMode; override;
  public
    constructor Create(AGrid: TCustomDBAxisGridEh);
    destructor Destroy; override;

    function AddMapping(const FieldName: string): Boolean;
    function MoveBy(Distance: Integer): Integer; override;

    procedure ClearMapping;
    procedure Modified;
    procedure Reset;

    property DefaultFields: Boolean read GetDefaultFields;
    property FieldCount: Integer read FFieldCount;
    property Fields[I: Integer]: TField read GetFields;
    property Grid: TCustomDBAxisGridEh read FGrid;
    property SparseMap: Boolean read FSparseMap write FSparseMap;
  end;

{ TDBAxisGridLineParamsEh }

  TDBGridLinesColorSchemeEh = (glcsDefaultEh, glcsClassicEh, glcsFlatEh, glcsThemedEh);
  TDrawEmptySpaceStyle = (dessNonEh, dessSolidEh, dessGradiendEh);

  TDBAxisGridLineParamsEh = class(TGridLineColorsEh)
  private
    FColorScheme: TDBGridLinesColorSchemeEh;
    FDataBoundaryColor: TColor;
    FDataHorzLines: Boolean;
    FDataHorzLinesStored: Boolean;
    FDataVertLines: Boolean;
    FDataVertLinesStored: Boolean;
    FGridBoundaries: Boolean;
    FVertEmptySpaceStyle: TDrawEmptySpaceStyle;

    function GetDataHorzLines: Boolean;
    function GetDataVertLines: Boolean;
    function GetGrid: TCustomDBAxisGridEh;
    function GetGridBoundaries: Boolean;
    function IsDataHorzLinesStored: Boolean;
    function IsDataVertLinesStored: Boolean;
    procedure SetDataBoundaryColor(const Value: TColor);

  protected
    function DefaultDataHorzLines: Boolean; virtual;
    function DefaultDataVertLines: Boolean; virtual;

    procedure SetDataHorzLines(const Value: Boolean); virtual;
    procedure SetDataHorzLinesStored(const Value: Boolean); virtual;
    procedure SetDataVertLines(const Value: Boolean); virtual;
    procedure SetDataVertLinesStored(const Value: Boolean); virtual;
    procedure SetGridBoundaries(const Value: Boolean); virtual;
    procedure SetColorScheme(const Value: TDBGridLinesColorSchemeEh); virtual;
    procedure SetVertEmptySpaceStyle(const Value: TDrawEmptySpaceStyle); virtual;

    property Grid: TCustomDBAxisGridEh read GetGrid;
  public
    constructor Create(AGrid: TCustomGridEh);

    function GetDarkColor: TColor; override;
    function GetBrightColor: TColor; override;
    function GetVertAreaContraVertColor: TColor; override;
    function GetActualColorScheme: TDBGridLinesColorSchemeEh; virtual;
    function GetDataBoundaryColor: TColor; virtual;

  public
    property DarkColor;
    property BrightColor;

    property DataVertColor;
    property DataVertLines: Boolean read GetDataVertLines write SetDataVertLines stored IsDataVertLinesStored;
    property DataVertLinesStored: Boolean read IsDataVertLinesStored write SetDataVertLinesStored stored False;

    property DataHorzColor;
    property DataHorzLines: Boolean read GetDataHorzLines write SetDataHorzLines stored IsDataHorzLinesStored;
    property DataHorzLinesStored: Boolean read IsDataHorzLinesStored write SetDataHorzLinesStored stored False;

    property DataBoundaryColor: TColor read FDataBoundaryColor write SetDataBoundaryColor default clDefault;
    property GridBoundaries: Boolean read GetGridBoundaries write SetGridBoundaries default False;

    property ColorScheme: TDBGridLinesColorSchemeEh read FColorScheme write SetColorScheme default glcsDefaultEh;

    property VertEmptySpaceStyle: TDrawEmptySpaceStyle read FVertEmptySpaceStyle write SetVertEmptySpaceStyle default dessGradiendEh;
  end;

{ TControlBorderEh }

  TControlBorderStyleEh = (cbsNoneEh, cbsSingleEh, cbsFlatEh);

  TControlBorderEh = class(TPersistent)
  private
    FColor: TColor;
    FEdgeBorders: TEdgeBorders;
    FExtendedDraw: Boolean;
    FExtendedDrawStored: Boolean;
    FGrid: TCustomDBAxisGridEh;
    FOldExtendedDraw: Boolean;

    function GetCtl3D: Boolean;
    function GetExtendedDraw: Boolean;
    function GetStyle: TBorderStyle;
    procedure SetColor(Value: TColor);
    procedure SetCtl3D(Value: Boolean);
    procedure SetEdgeBorders(Value: TEdgeBorders);
    procedure SetExtendedDraw(const Value: Boolean);
    procedure SetExtendedDrawStored(const Value: Boolean);
    procedure SetStyle(Value: TBorderStyle);
  public

    constructor Create(AGrid: TCustomDBAxisGridEh);
    destructor Destroy; override;

    function IsExtendedDrawStored: Boolean;
    function DefaultExtendedDraw: Boolean;
    procedure UpdateExtendedDraw;
  published

    property Color: TColor read FColor write SetColor default clDefault;
    property Ctl3D: Boolean read GetCtl3D write SetCtl3D stored False;
    property EdgeBorders: TEdgeBorders read FEdgeBorders write SetEdgeBorders default [ebLeft, ebTop, ebRight, ebBottom];
    property ExtendedDraw: Boolean read GetExtendedDraw write SetExtendedDraw stored IsExtendedDrawStored;
    property ExtendedDrawStored: Boolean read IsExtendedDrawStored write SetExtendedDrawStored stored False;
    property Style: TBorderStyle read GetStyle write SetStyle stored False;
  end;

  TGridCellFillStyleEh = (cfstDefaultEh, cfstThemedEh, cfstSolidEh, cfstGradientEh);

{ TCustomDBAxisGridEh }

  TDBGridEhAllowedOperation = (alopInsertEh, alopUpdateEh, alopDeleteEh, alopAppendEh);
  TDBGridEhAllowedOperations = set of TDBGridEhAllowedOperation;

  TCustomDBAxisGridEh = class(TCustomGridEh,
    IInplaceEditHolderEh, ISideOwnerEh{$IFNDEF CIL}, IUnknown {$ENDIF})
  private
    FAllowedOperations: TDBGridEhAllowedOperations;
    FAxisBars: TGridAxisBarsEh;
    FColCellParamsEh: TAxisColCellParamsEh;
    FColumnDefValues: TAxisBarDefValuesEh;
    FDataLink: TAxisGridDataLinkEh;
    FDefaultDrawing: Boolean;
    FDummiFont: TFont;
    FDynProps: TDynVarsEh;
    FIncludeImageModules: TIncludeImageModulesEh;
    FLayoutChangedInUpdateLock: Boolean;
    FLayoutLock: Byte;
    FOnEditButtonClick: TNotifyEvent;
  {$IFDEF FPC}
  {$ELSE}
    FOriginalImeMode: TImeMode;
    FOriginalImeName: TImeName;
  {$ENDIF}
    FReadOnly: Boolean;
    FUpdateLock: Byte;
    FUserChange: Boolean;

    function GetCenter: TDBAxisGridEhCenter;
    function GetDataSource: TDataSource;
    function GetFieldAxisBars(const FieldName: String): TAxisBarEh;
    function GetFieldCount: Integer;
    function GetFields(FieldIndex: Integer): TField;
    function GetGridLineParams: TDBAxisGridLineParamsEh;
    function GetSelectedField: TField;

    procedure ReadColumns(Reader: TReader);
    procedure SetAllowedOperations(const Value: TDBGridEhAllowedOperations);
    procedure SetAxisBars(Value: TGridAxisBarsEh);
    procedure SetColumnDefValues(const Value: TAxisBarDefValuesEh);
    procedure SetDrawGraphicData(const Value: Boolean);
    procedure SetDrawMemoText(const Value: Boolean);
    procedure SetDynProps(const Value: TDynVarsEh);
    procedure SetGridLineParams(const Value: TDBAxisGridLineParamsEh);
    procedure SetIncludeImageModules(const Value: TIncludeImageModulesEh);
    procedure SetReadOnly(const Value: Boolean);
    procedure SetSelectedField(Value: TField);
    procedure WriteColumns(Writer: TWriter);

    procedure CMDeferLayout(var Message: TMessage); message cm_DeferLayout;
    procedure CMDesignHitTest(var Msg: TCMDesignHitTest); message CM_DESIGNHITTEST;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMHintShow(var Message: TCMHintShow); message CM_HINTSHOW;
    procedure CMHintsShowPause(var Message: TCMHintShowPause); message CM_HINTSHOWPAUSE;
    procedure CMParentColorChanged(var Message: TMessage); message CM_PARENTCOLORCHANGED;
    procedure CMParentFontChanged(var Message: TCMParentFontChanged); message CM_PARENTFONTCHANGED;
    {$IFDEF FPC}
    {$ELSE}
    procedure CMSysColorChange(var Message: TMessage); message CM_SYSCOLORCHANGE;
    {$ENDIF}
    procedure CMWantSpecialKey(var Msg: TCMWantSpecialKey); message CM_WANTSPECIALKEY;

    procedure WMChar(var Message: TWMChar); message WM_CHAR;
    procedure WMCommand(var Message: TWMCommand); message WM_COMMAND;
    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBKGND;
    procedure WMIMEStartComp(var Message: TMessage); message WM_IME_STARTCOMPOSITION;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KillFocus;
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCPaint(var Message: TWMNCPaint); message WM_NCPAINT;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SetFOCUS;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message WM_WINDOWPOSCHANGED;

  protected
    { IInplaceEditHolderEh }
    function InplaceEditCanModify(Control: TWinControl): Boolean; virtual;
    procedure GetMouseDownInfo(var Pos: TPoint; var Time: LongInt); virtual;
    procedure InplaceEditKeyDown(Control: TWinControl; var Key: Word; Shift: TShiftState); virtual;
    procedure InplaceEditKeyPress(Control: TWinControl; var Key: Char); virtual;
    procedure InplaceEditKeyUp(Control: TWinControl; var Key: Word; Shift: TShiftState); virtual;
    procedure InplaceEditWndProc(Control: TWinControl; var Message: TMessage); virtual;

  protected
    FAcquireFocus: Boolean;
    FAllowWordWrap: Boolean; 
    FBorder: TControlBorderEh;
    FBorderWidth: Integer;
    FCanvasHandleAllocated: Boolean;
    FDesignInfoCollection: TCollection;
    FDownMouseMessageTime: LongInt;
    FDownMousePos: TPoint;
    FDrawGraphicData: Boolean;
    FDrawMemoText: Boolean;
    FEditButtonsBox: TEditButtonsBoxEh;
    FEditKeyValue: Variant; 
    FEditText: string;
    FHintFont: TFont;
    FInplaceEditorButtonHeight: Integer;
    FInplaceEditorButtonWidth: Integer;
    FInterlinear: Integer;
    FIntMemTable: IMemTableEh;
    FLayoutFromDataset: Boolean;
    FLockEditorCount: Integer;
    FMoveMousePos: TPoint;
    FNoDesigntControler: Boolean;
    FOnTopLeftChanged: TNotifyEvent;
    FPressedCell: TGridCoord;
    FSelectionActive: Boolean;
    FTimerActive: Boolean;
    FTimerInterval: Integer;
    FVisibleAxisBars: TAxisBarsEhList;

    function AcquireFocus: Boolean; virtual;
    function AcquireLayoutLock: Boolean;
    function AllowedOperationUpdate: Boolean; virtual;
    function BoxRect(ALeft, ATop, ARight, ABottom: Longint): TRect;

    function CanEditAcceptKey(Key: Char): Boolean; override;
    function CanEditModify: Boolean; override;
    function CanEditModifyColumn(Index: Integer): Boolean; virtual;
    function CanEditModifyText: Boolean; virtual;
    function CanEditorMode: Boolean; virtual;
    function CanEditShow: Boolean; override;

    function CellHave3DRect(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState): Boolean; virtual;
    function CreateAxisBarDefValues: TAxisBarDefValuesEh; virtual;
    function CreateAxisBars: TGridAxisBarsEh; virtual;
    function CreateEditor: TInplaceEdit; override;
    function CreateGridLineColors: TGridLineColorsEh; override;

    function DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function GetEditLimit: Integer; override;
    function GetEditMask(ACol, ARow: Longint): string; override;
    function GetEditText(ACol, ARow: Longint): string; override;
    function GetDefaultFixedCellFillStyle: TGridCellFillStyleEh; virtual;
    function GetSortMarkerStyle: TSortMarkerStyleEh; virtual;

    function CanSideOwnClass(ComponentClass: TComponentClass): Boolean;
    function GetPictureForField(AxisBar: TAxisBarEh): TPicture;
    function InplaceEditorVisible: Boolean;
    function IsDrawCellBorder(ACol, ARow: Integer; BorderType: TGridCellBorderTypeEh): Boolean;
    function IsSelectionActive: Boolean; virtual;
    function IsSideParentableForProperty(PropertyName: String): Boolean;
    function MemTableSupport: Boolean;
    function NeedBufferedPaint: Boolean; override;
    function StoreColumns: Boolean;
    function ViewScroll: Boolean;

    function AxisColumnsStorePropertyName: String; virtual;
    function CreateColCellParamsEh: TAxisColCellParamsEh; virtual;
    function CreateDataLink: TAxisGridDataLinkEh; virtual;
    function DefaultTitleAlignment: TAlignment; virtual;
    function DefaultTitleColor: TColor; virtual;
    function DesignHitTestObject(XPos, YPos: Integer): TPersistent; virtual;
    function GetBaseGridOptions: TGridOptionsEh;
    function GetColCellParamsEh: TAxisColCellParamsEh; virtual;
    function GetDataCellHorzOffset(AxisBar: TAxisBarEh): Integer; virtual;
    function GetDataEditButtonTransparency(ACol, ARow: Longint; ARect: TRect; Params: TAxisColCellParamsEh): Integer; virtual;
    function GetEditButtonsBox: TEditButtonsBoxEh; virtual;
    function GetRestoreStateControl: TObject; virtual;
    function GetSelectedIndex: Integer; virtual;
    function GetSelectionInactiveColor: TColor; virtual;
    function GetTitleFont: TFont; virtual;
    function IsCustomStyleActive: Boolean; virtual;
    function IsEditButtonsBoxVisible: Boolean; virtual;
    function IsFixed3D: Boolean; virtual;

    procedure BeginUpdate;

    procedure CancelLayout;
    procedure ChangeScale(M, D: Integer); override;

    procedure ClientAreaSizeChanged;

    procedure ColumnDeleting(Item: TAxisBarEh); virtual;
    procedure ColWidthsChanged; override;

    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;

    procedure DataChanged; virtual;
    procedure DeferLayout;
    procedure DefineFieldMap; virtual;
    procedure DefineProperties(Filer: TFiler); override;
    procedure DoEnter; override;
    procedure DoExit; override;

    procedure DrawBorder; virtual;
    procedure DrawEdgeEh(ACanvas: TCanvas; qrc: TRect; IsDown, IsSelected: Boolean; NeedLeft, NeedRight: Boolean; AFlatMode: Boolean); overload;
    procedure DrawEdgeEh(ACanvas: TCanvas; qrc: TRect; IsDown, IsSelected: Boolean; Edges: TRectangleEdgesEh; AFlatMode: Boolean); overload;
    procedure FillCellRect(CellFillStyle: TGridCellFillStyleEh; ARect: TRect; IsDown, IsSelected: Boolean; ClipRect: TRect; Cell3D: Boolean; Focused: Boolean = False; GradSecondColor: TColor = clDefault); virtual;

    procedure DrawGraphicCell(AxisBar: TAxisBarEh; ARect: TRect; Background: TColor; FillBackground: Boolean); virtual;
    procedure EditButtonClick; virtual;

    procedure EndUpdate;
    procedure GetCellParams(AxisBar: TAxisBarEh; AFont: TFont; var Background: TColor; State: TGridDrawState); virtual;
    procedure FlatChanged; override;
    procedure FocusCell(ACol, ARow: Longint; MoveAnchor: Boolean); override;

    procedure GetDatasetFieldList(FieldList: TList); virtual;
    procedure HideEditor; override;
    procedure InvalidateCol(ACol: Longint);
    procedure InvalidateRow(ARow: Longint);
    procedure InvalidateCell(ACol, ARow: Longint);
    procedure InvalidateEditor; override;
    procedure InvalidateGridRect(ARect: TGridRect);
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;

    procedure KeyProperyModified;
    procedure LayoutChanged; virtual;
    procedure LinkActive(Value: Boolean); virtual;
    procedure Loaded; override;

    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;

    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    procedure Paint; override;

    procedure PaintButtonControl(Canvas: TCanvas; ARect: TRect; ParentColor: TColor; Style: TDrawButtonControlStyleEh; DownButton: Integer; Flat, Active, Enabled: Boolean; State: TCheckBoxState);
    procedure SelectionActiveChanged; virtual;
    procedure ResetTimer(Interval: Integer);

    procedure Scroll(Distance: Integer); virtual;

    procedure SetBorder(Value: TControlBorderEh);
    procedure SetColumnAttributes; virtual;

    procedure SetEditText(ACol, ARow: Longint; const Value: string); override;

    procedure ShowEditor; override;
    procedure StopTimer;

    procedure RolPosChanged(OldRowPosX, OldRowPosY: Integer); override;

    procedure UpdateActive; virtual;
    procedure UpdateEdit; override;
    procedure UpdateText; override;

    procedure WndProc(var Message: TMessage); override;
    procedure WriteCellText(AxisBar: TAxisBarEh; ACanvas: TCanvas; ARect: TRect; FillRect: Boolean; DX, DY: Integer; const Text: string; Alignment: TAlignment; Layout: TTextLayout; MultyL: Boolean; EndEllipsis: Boolean; LeftMarg, RightMarg: Integer; ForceSingleLine: Boolean);
    procedure LockEditor;
    procedure UnlockEditor;
    procedure ReadDesignInfoCollection(Reader: TReader);
    procedure WriteDesignInfoCollection(Writer: TWriter);

    procedure CreateEditButtonControl(var EditButtonControl: TEditButtonControlEh); virtual;
    procedure CurrentCellMoved(OldCurrent: TGridCoord); override;
    procedure EditButtonDefaultAction(EditControl: TControl; EditButton: TEditButtonEh; EditButtonControl: TEditButtonControlEh; IsMouseDown: Boolean; var Handled: Boolean); virtual;
    procedure EditingChanged; virtual;
    procedure FillBlankDataCellRect(ARect: TRect; IsSelected: Boolean; Cell3D: Boolean; Params: TAxisColCellParamsEh); virtual;
    procedure FormSystemPopupMenuForAxisBar(AxisBar: TAxisBarEh; APopupMenu: TPopupMenu); virtual;
    procedure GetColRowForAxisCol(AxisBar: TAxisBarEh; var ACol, ARow: Integer); virtual;
    procedure GetCustomStyleFixedColors(var AFillColor, ATextColor, AStartColor, AEndColor: TColor; FillStyle: TGridCellFillStyleEh; IsTrack, IsPressed: Boolean); virtual;
    procedure GetDefaultFixedGradientColor(var AStartColor, AEndColor: TColor; IsTrack, IsPressed: Boolean); virtual;
    procedure GetThemeTitleFillRect(var AFillRect: TRect; IncVerBoundary, IncHorzBoundary: Boolean); virtual;
    procedure HideEditButtonsBox; virtual;
    procedure InternalLayout; virtual;
    procedure LookupStateChanged(AxisBar: TAxisBarEh); virtual;
    procedure PaintInplaceButton(AxisBar: TAxisBarEh; Canvas: TCanvas; ButtonStyle: TEditButtonStyleEh; Rect, ClipRect: TRect; DownButton: Integer; Active, Flat, Enabled: Boolean; ParentColor: TColor; Bitmap: TBitmap; TransparencyPercent: Byte; imList: TCustomImageList; ImageIndex: Integer);
    procedure RecordChanged(Field: TField); virtual;
    procedure SetBaseGridOptions(AOptions: TGridOptionsEh);
    procedure SetDataSource(Value: TDataSource); virtual;
    procedure SetIme; virtual;
    procedure SetSelectedIndex(Value: Integer); virtual;
    procedure SetTitleFont(Value: TFont); virtual;
    procedure UpdateEditButtonsBox; virtual;
    procedure UpdateIme; virtual;

  {$IFDEF FPC}
  {$ELSE}
    property ImeMode;
    property ImeName;
  {$ENDIF}

    property AllowedOperations: TDBGridEhAllowedOperations read FAllowedOperations write SetAllowedOperations default [alopInsertEh, alopUpdateEh, alopDeleteEh, alopAppendEh];
    property Center: TDBAxisGridEhCenter read GetCenter;
    property ColCellParamsEh: TAxisColCellParamsEh read GetColCellParamsEh;
    property ColCount;
    property Color;
    property ColWidths;
    property DataLink: TAxisGridDataLinkEh read FDataLink;
    property DefaultColWidth;
    property DefaultDrawing: Boolean read FDefaultDrawing write FDefaultDrawing default True;
    property GridLineParams: TDBAxisGridLineParamsEh read GetGridLineParams write SetGridLineParams;
    property LayoutLock: Byte read FLayoutLock;
    property OnEditButtonClick: TNotifyEvent read FOnEditButtonClick write FOnEditButtonClick;
    property ParentColor default False;
    property ReadOnly: Boolean read FReadOnly write SetReadOnly default False;
    property RowCount;
    property RowHeights;
    property TitleFont: TFont read GetTitleFont write SetTitleFont stored False;
    property TopRow;
    property UpdateLock: Byte read FUpdateLock;
    property VisibleAxisBars: TAxisBarsEhList read FVisibleAxisBars;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function CellRect(ACol, ARow: Longint; IncludeLine: Boolean = False): TRect;
    function CheckFillDataCell(Cell, AreaCell: TGridCoord; AxisBar: TAxisBarEh; AreaRect: TRect; Params: TAxisColCellParamsEh): Boolean; virtual;
    function DataSetActive: Boolean;
    function FindFieldColumn(const FieldName: String): TAxisBarEh;
    function GetCellTreeElmentsAreaWidth: Integer; virtual;
    function HighlightDataCellColor(DataCol, DataRow: Integer; const Value: string; AState: TGridDrawState; var AColor: TColor; AFont: TFont): Boolean; virtual;
    function IsMouseInRect(ARect: TRect): Boolean;
    function ValidFieldIndex(FieldIndex: Integer): Boolean;

    procedure BeginLayout;
    procedure CancelEditing; virtual;
    procedure DefaultDrawDataCell(Cell, AreaCell: TGridCoord; AxisBar: TAxisBarEh; AreaRect: TRect; Params: TAxisColCellParamsEh); virtual;
    procedure DefaultFillDataHintShowInfo(CursorPos: TPoint; Cell: TGridCoord; AxisBar: TAxisBarEh; Params: TDBAxisGridDataHintParamsEh); virtual;
    procedure DefaultHandler(var Message); override;
    procedure EndLayout;
    procedure Invalidate; override;
    procedure SetFocus; override;
    procedure UpdateData; virtual;

    property Canvas;
    property AxisBarDefValues: TAxisBarDefValuesEh read FColumnDefValues write SetColumnDefValues;
    property AxisBars: TGridAxisBarsEh read FAxisBars write SetAxisBars;
    {$IFDEF FPC}
    {$ELSE}
    property Ctl3D;
    {$ENDIF}
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DynProps: TDynVarsEh read FDynProps write SetDynProps;
    property DrawGraphicData: Boolean read FDrawGraphicData write SetDrawGraphicData default false;
    property DrawMemoText: Boolean read FDrawMemoText write SetDrawMemoText default false;
    property EditorMode;
    property FieldAxisBars[const FieldName: String]: TAxisBarEh read GetFieldAxisBars; default;
    property FieldCount: Integer read GetFieldCount;
    property Fields[FieldIndex: Integer]: TField read GetFields;
    property FixedColor;
    property Font;
    property InplaceEditor;
//    property LeftCol;

    property Row;
    property SelectedField: TField read GetSelectedField write SetSelectedField;
    property SelectedIndex: Integer read GetSelectedIndex write SetSelectedIndex;

//    property VisibleColCount;
//    property VisibleRowCount;

    property IncludeImageModules: TIncludeImageModulesEh read FIncludeImageModules write SetIncludeImageModules default [];
    property Border: TControlBorderEh read FBorder write SetBorder;
  end;

{ TDBAxisGridEhCenter }

  TDBAxisGridEhCenter = class(TPersistent)
  private
  protected
  public
    constructor Create;
    destructor Destroy; override;

    procedure Changed; virtual;
    procedure EditButtonDefaultAction(Grid: TCustomDBAxisGridEh; AxisBar: TAxisBarEh; EditControl: TControl; EditButton: TEditButtonEh; EditButtonControl: TEditButtonControlEh; IsMouseDown: Boolean; var Handled: Boolean); virtual;
    procedure EditButtonDefaultActionForImage(Grid: TCustomDBAxisGridEh; AxisBar: TAxisBarEh; EditControl: TControl; EditButton: TEditButtonEh; EditButtonControl: TEditButtonControlEh; IsMouseDown: Boolean; var Handled: Boolean); virtual;
    procedure EditButtonDefaultActionText(Grid: TCustomDBAxisGridEh; AxisBar: TAxisBarEh; EditControl: TControl; EditButton: TEditButtonEh; EditButtonControl: TEditButtonControlEh; IsMouseDown: Boolean; var Handled: Boolean); virtual;
    procedure FormSystemPopupMenuForColumn(Grid: TCustomDBAxisGridEh; AxisBar: TAxisBarEh; APopupMenu: TPopupMenu); virtual;

    procedure MenuItemCopy(Sender: TObject); virtual;
    procedure MenuItemCut(Sender: TObject); virtual;
    procedure MenuItemPaste(Sender: TObject); virtual;
    procedure MenuItemDelete(Sender: TObject); virtual;
    procedure MenuItemLoad(Sender: TObject); virtual;
    procedure MenuItemSave(Sender: TObject); virtual;

  end;

{ TColumnDropDownBoxEh }

  TColumnDropDownBoxEh = class(TPersistent)
  private
    FAlign: TDropDownAlign;
    FAutoDrop: Boolean;
    FAutoFitColWidths: Boolean;
    FListSource: TDataSource;
    FOwner: TPersistent;
    FRows: Integer;
    FShowTitles: Boolean;
    FSizable: Boolean;
    FSpecRow: TSpecRowEh;
    FUseMultiTitle: Boolean;
    FWidth: Integer;
    FListSourceAutoFilter: Boolean;
    FListSourceAutoFilterType: TLSAutoFilterTypeEh;
    FListFieldNames: String;

    function GetAutoFitColWidths: Boolean;
    function GetColumnDefValues: TCustomColumnDefValuesEh;
    function GetColumns: TBaseColumnsEh;
    function GetListSource: TDataSource;
    function GetOptions: TDBLookupGridEhOptions;
    function GetSortLocal: Boolean;
    function StoreColumns: Boolean;

    procedure SetAutoFitColWidths(const Value: Boolean);
    procedure SetColumnDefValues(const Value: TCustomColumnDefValuesEh);
    procedure SetColumns(const Value: TBaseColumnsEh);
    procedure SetListSource(const Value: TDataSource);
    procedure SetOptions(const Value: TDBLookupGridEhOptions);
    procedure SetSpecRow(const Value: TSpecRowEh);
    procedure SetSortLocal(const Value: Boolean);

  protected
    property Align: TDropDownAlign read FAlign write FAlign default daLeft;
    property AutoDrop: Boolean read FAutoDrop write FAutoDrop default False;
    property Rows: Integer read FRows write FRows default 7;
    property ShowTitles: Boolean read FShowTitles write FShowTitles default False;
    property Sizable: Boolean read FSizable write FSizable default False;
    property SpecRow: TSpecRowEh read FSpecRow write SetSpecRow;
    property Width: Integer read FWidth write FWidth default 0;

  public
    constructor Create(Owner: TPersistent);
    destructor Destroy; override;
    function GetOwner: TPersistent; override;
    procedure Assign(Source: TPersistent); override;
    function GetLikeWildcardForSeveralCharacters: String;
    function GetActualListField: String; virtual;
  published
    property AutoFitColWidths: Boolean read GetAutoFitColWidths write SetAutoFitColWidths default True;
    property ColumnDefValues: TCustomColumnDefValuesEh read GetColumnDefValues write SetColumnDefValues;
    property Columns: TBaseColumnsEh read GetColumns write SetColumns stored StoreColumns;
    property ListFieldNames: String read FListFieldNames write FListFieldNames;
    property ListSource: TDataSource read GetListSource write SetListSource;
    property ListSourceAutoFilter: Boolean read FListSourceAutoFilter write FListSourceAutoFilter default False;
    property ListSourceAutoFilterType: TLSAutoFilterTypeEh read FListSourceAutoFilterType write FListSourceAutoFilterType default lsftBeginsWithEh;
    property Options: TDBLookupGridEhOptions read GetOptions write SetOptions default [dlgColLinesEh];
    property SortLocal: Boolean read GetSortLocal write SetSortLocal default False;
    property UseMultiTitle: Boolean read FUseMultiTitle write FUseMultiTitle default False;
  end;

  TAxisGridDropDownFormSysParams = class(TDropDownFormSysParams)
  public
    FAxisBar: TAxisBarEh;
    FEditButton: TEditButtonEh;
  end;

  TEditStyle = (esSimple, esEllipsis, esPickList, esLookupDataList, esDateCalendar,
    esUpDown, esDropDown, esAltUpDown, esAltDropDown, esAltCalendar,
    esAltPickList, esAltLookupDataList, esDataList, esAltDataList);

{ TDBAxisGridInplaceEdit }

  TDBAxisGridInplaceEdit = class(TInplaceEdit, IComboEditEh {$IFNDEF CIL}, IUnknown {$ENDIF})
  private
    FActiveList: TWinControl;
    FButtonsBox: TEditButtonsBoxEh;
    FCharKeyStr: String;
    FDataList: TCustomControl;
    FDroppedDown: Boolean;
    FEditButtonStyle: TEditStyle;
    FEditStyle: TEditStyle;
    FImageIndex: Integer;
    FListColumnMothed: Boolean;
    FLockCloseList: Boolean;
    FLookupSource: TDatasource;
    FMRUList: TMRUListEh;
    FMRUListControl: TWinControl;
    FNoClickCloseUp: Boolean;
    FPickList: TPopupListboxEh;
    FPopupCalculator: TWinControl;
    FPopupMonthCalendar: TPopupMonthCalendarEh;
    FUserTextChanged: Boolean;
    FWordWrap: Boolean;

    function DeleteSeletedText: String;
    function GetAxisBar: TAxisBarEh;
    function GetEditButtonByShortCut(ShortCut: TShortCut): TEditButtonEh;
    function GetEditButtonPressed: Boolean;
    function GetGrid: TCustomDBAxisGridEh;
    function GetMRUListControl: TWinControl;

    procedure DoDBCSKeyPress(var Key: Char);
    procedure ListColumnMoved(Sender: TObject; FromIndex, ToIndex: Longint);
    procedure ListMouseCloseUp(Sender: TObject; Accept: Boolean);
    procedure ListMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure LocateListText;
    procedure PopupListboxGetImageIndex(Sender: TObject; ItemIndex: Integer; var ImageIndex: Integer);
    procedure SetEditButtonPressed(const Value: Boolean);
    procedure SetEditButtonStyle(const Value: TEditStyle);
    procedure SetEditStyle(Value: TEditStyle);
    procedure SetWordWrap(const Value: Boolean);
    procedure UpdateImageIndex; virtual;
    procedure UpDownClick(Sender: TObject; Button: TUDBtnType);

    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
    {$IFDEF FPC}
    {$ELSE}
    procedure CMCancelMode(var Message: TCMCancelMode); message CM_CancelMode;
    {$ENDIF}

    procedure WMClear(var Message: TMessage); message WM_CLEAR;
    procedure WMCut(var Message: TMessage); message WM_CUT;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KillFocus;
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LButtonDblClk;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMPaste(var Message: TMessage); message WM_PASTE;
    procedure WMSetCursor(var Message: TWMSetCursor); message WM_SetCursor;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;

  protected
    FCanvas: TCanvas;
    FListVisible: Boolean;
    FReadOnlyStored: Boolean;
    FFixedDownButton: Integer;

    function CanDropCalculator: Boolean;
    function CreateMRUListControl: TWinControl; virtual;
    function DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function GetPopupCalculator: TWinControl; virtual;
    function TraceMouseMoveForPopupListbox(Sender: TObject; Shift: TShiftState; X, Y: Integer): Boolean;

    procedure BoundsChanged; override;
    procedure ButtonDown(IsDownButton: Boolean; var Handled: Boolean); virtual;
    procedure CalcEditRect(var ARect: TRect); virtual;
    procedure CheckEditButtonDownForDropDownForm(EditButton: TEditButtonEh; EditButtonControl: TEditButtonControlEh; var Handled: Boolean); virtual;
    procedure CloseUp(Accept: Boolean);
    procedure CreateEditButtonControl(var EditButtonControl: TEditButtonControlEh); virtual;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure DBCSKeyPress(var Key: String); virtual;
    procedure DoDropDownKeys(var Key: Word; Shift: TShiftState);
    procedure DrawEditImage(DC: HDC);
    procedure DropDown; virtual;
    procedure DropDownFormCallbackProc(DropDownForm: TCustomForm; Accept: Boolean; DynParams: TDynVarsEh; SysParams: TDropDownFormSysParams);
    procedure DropDownFormCloseProc(EditControl: TControl; Button: TEditButtonEh; Accept: Boolean; DropDownForm: TCustomForm; DynParams: TDynVarsEh);
    procedure EditButtonClick(Sender: TObject); virtual;
    procedure EditButtonDown(Sender: TObject; TopButton: Boolean; var AutoRepeat: Boolean; var Handled: Boolean); virtual;
    procedure EditButtonMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer); virtual;
    procedure EditButtonMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;
    procedure FilterMRUItem(AText: String; var Accept: Boolean); virtual;
    procedure GetDefaultDropDownForm(var DropDownForm: TCustomForm; var FreeFormOnClose: Boolean); virtual;
    procedure GetVarValue(var VarValue: Variant); virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MRUListCloseUp(Sender: TObject; Accept: Boolean);
    procedure MRUListControlMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure MRUListControlResized(Sender: TObject); virtual;
    procedure MRUListDropDown(Sender: TObject);
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure PaintWindow(DC: HDC); override;
    procedure RecreateWndHandle;
    procedure RefilterDropDownBoxListSource(const FilterText: String);
    procedure SetVarValue(const VarValue: Variant); virtual;
    procedure ShowDropDownForm(EditControl: TControl; Button: TEditButtonEh; var DropDownForm: TCustomForm; DynParams: TDynVarsEh);
    procedure StartDropDownBoxListSourceFilter;
    procedure StopDropDownBoxListSourceFilter;
    procedure UpdateActiveList;
    procedure UpdateContents; override;
    procedure UpdateEditButtonControlList;
    procedure UpdateEditButtonControlsState;
    procedure UpdateEditStyle;
    procedure UserChange; virtual;
    procedure WndProc(var Message: TMessage); override;

    property ActiveList: TWinControl read FActiveList write FActiveList;
    property AxisBar: TAxisBarEh read GetAxisBar;
    property DataList: TCustomControl read FDataList;
    property EditButtonPressed: Boolean read GetEditButtonPressed write SetEditButtonPressed;
    property EditButtonStyle: TEditStyle read FEditButtonStyle write SetEditButtonStyle;
    property EditStyle: TEditStyle read FEditStyle write SetEditStyle;
    property Grid: TCustomDBAxisGridEh read GetGrid;
    property MRUList: TMRUListEh read FMRUList write FMRUList;
    property MRUListControl: TWinControl read GetMRUListControl;
    property PickList: TPopupListboxEh read FPickList;
    property ReadOnly;
    property WordWrap: Boolean read FWordWrap write SetWordWrap;
  public

    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;

    function FirstVisibleButtonIndex: Integer;
    procedure DefaultHandler(var Message); override;
    procedure Invalidate; override;
  end;

  TFontDataEh = record
    Height: Integer;
    Pitch: TFontPitch;
    Style: TFontStyles;
    Charset: TFontCharset;
    Name: TFontName;
    Color: TColor;
  end;

  TAxisBarEhMenuItem = class(TMenuItemEh)
  public
    AxisBar: TAxisBarEh;
  end;

{ TGridToolTipsWindowEh }

type
  TGridToolTipsWindowEh = class(THintWindow)
  protected
  public
    procedure Paint; override;
    procedure ActivateHintData(Rect: TRect; const AHint: string; AData: Pointer); override;
  public
{$IFDEF CIL}
//    function CalcHintRect(MaxWidth: Integer; const AHint: string; AData: TObject): TRect; override;
{$ELSE}
    function CalcHintRect(MaxWidth: Integer; const AHint: string; AData: Pointer): TRect; override;
{$ENDIF}
  end;

function GridRect(ALeft, ATop, ARight, ABottom: Integer): TGridRect;
function GetColumnEditStile(AxisBar: TAxisBarEh): TEditStyle;
function FormatFieldDisplayValue(Field: TField; DisplayFormat: String): String;
function CheckHintTextRect(DrawTextBiDiModeFlagsReadingOnly: Longint;
  Canvas: TCanvas; RightIndent, FInterlinear: Integer; ws: String; ARect: TRect;
  WordWrap, SingleLine: Boolean; var TextWidth, TextHeight: Integer;
  Alignment: TAlignment; EndEllipsis: Boolean): Boolean;
function LightenColorEh(AColor: TColor; GlassColor: TColor; Ungray: Boolean): TColor;

procedure RaiseGridError(const S: string);
procedure GridInvalidateRow(Grid: TCustomDBAxisGridEh; Row: Longint);
procedure GetFontData(Font: TFont; var FontData: TFontDataEh);
procedure SetFontData(var FontData: TFontDataEh; Font: TFont);
procedure ChangeCanvasDrawOrientation(Canvas: TCanvas; RightToLeftOrientation: Boolean; Width, Height: Integer);

procedure SetEhLibDebugDraw(AEhLibDebugDraw: Boolean);

function SetDBAxisGridEhCenter(NewGridCenter: TDBAxisGridEhCenter): TDBAxisGridEhCenter;
function DBAxisGridEhCenter: TDBAxisGridEhCenter;

const
{$IFDEF EH_LIB_10}
  MemoTypes = [ftMemo, ftWideMemo, ftOraClob];
{$ELSE}
  MemoTypes = [ftMemo, ftOraClob];
{$ENDIF}

var
  DBGridEhDebugDraw: Boolean;
  DBGridEhDesigntControler: TDesignControlerEh;

  hcrDownCurEh: HCursor = 0;
  hcrRightCurEh: HCursor = 0;
  hcrLeftCurEh: HCursor = 0;

implementation

uses Dialogs,
 DBGridEhImpExp, DBGridEhFindDlgs,
 CalculatorEh, DBLookupGridsEh,
 Clipbrd, DropDownFormEh, Math,
{$IFDEF EH_LIB_6} MaskUtils, {$ELSE} Mask, {$ENDIF}
{$ifdef eval}
  EhLibEvaluationForm,
{$endif}
  {$IFDEF FPC}
  DBGridsEh,
  {$ELSE}
  DBGridEh, VDBConsts,
  {$ENDIF}
  EhLibConsts, DBUtilsEh,
  PictureEditFormsEh, MemoEditFormsEh,
  ExtDlgs;

{$R DBGRIDEH.RES}

const
  MaxMapSize = (MaxInt div 2) div SizeOf(Integer); { 250 million }

function LightenColorEh(AColor: TColor; GlassColor: TColor; Ungray: Boolean): TColor;
var
  r, g, b: Double;
  rgb: Longint;
  r_c, g_c, b_c: Double;
  rgb_c: Longint;
begin
  rgb := ColorToRGB(AColor);
  r := rgb and $FF;
  g := (rgb shr 8) and $FF;
  b := (rgb shr 16) and $FF;

  rgb_c := ColorToRGB(GlassColor);
  r_c := rgb_c and $FF;
  g_c := (rgb_c shr 8) and $FF;
  b_c := (rgb_c shr 16) and $FF;

  r := r + (r_c - r) * 0.5;
  g := g + (g_c - g) * 0.5;
  b := b + (b_c - b) * 0.5;

  r := r + (225 - r) * 0.6;
  g := g + (225 - g) * 0.6;
  b := b + (225 - b) * 0.6;

  if Ungray then
  begin
    r := r - (integer(122) - r) * 0.25;
    g := g - (integer(122) - g) * 0.25;
    b := b - (integer(122) - b) * 0.25;
  end;

  Result := TColor((Max(Min(Round(b), 255),0) shl 16)
                or (Max(Min(Round(g), 255),0) shl 8)
                or Max(Min(Round(r), 255),0));
end;

procedure SetEhLibDebugDraw(AEhLibDebugDraw: Boolean);
begin
  if AEhLibDebugDraw then
  begin
    DBGridEhDebugDraw := True;
    GridEhDebugDraw := True;
    GdiSetBatchLimit(1);
  end else
  begin
    DBGridEhDebugDraw := False;
    GridEhDebugDraw := False;
    GdiSetBatchLimit(0);
  end;
end;

procedure GetFontData(Font: TFont; var FontData: TFontDataEh);
begin
  FontData.Height := Font.Height;
  FontData.Pitch := Font.Pitch;
  FontData.Style := Font.Style;
  FontData.Charset := Font.Charset;
  FontData.Name := Font.Name;
  FontData.Color := Font.Color;
end;

procedure SetFontData(var FontData: TFontDataEh; Font: TFont);
begin
  if Font.Height <> FontData.Height then
    Font.Height := FontData.Height;
  if Font.Pitch <> FontData.Pitch then
    Font.Pitch := FontData.Pitch;
  if Font.Style <> FontData.Style then
    Font.Style := FontData.Style;
  if Font.Charset <> FontData.Charset then
    Font.Charset := FontData.Charset;
  if Font.Name <> FontData.Name then
    Font.Name := FontData.Name;
  if Font.Color <> FontData.Color then
    Font.Color := FontData.Color;
end;

procedure ChangeCanvasDrawOrientation(Canvas: TCanvas;
  RightToLeftOrientation: Boolean; Width, Height: Integer);
var
  Org: TPoint;
  Ext: TPoint;
begin
  if RightToLeftOrientation then
  begin
    Org := Point(Width, 0);
    Ext := Point(-1, 1);
    SetMapMode(Canvas.Handle, mm_Anisotropic);
    SetWindowOrgEx(Canvas.Handle, Org.X, Org.Y, nil);
    SetViewportExtEx(Canvas.Handle, Width, Height, nil);
    SetWindowExtEx(Canvas.Handle, Ext.X * Width, Ext.Y * Height, nil);
  end else
  begin
    Org := Point(0, 0);
    Ext := Point(1, 1);
    SetMapMode(Canvas.Handle, mm_Anisotropic);
    SetWindowOrgEx(Canvas.Handle, Org.X, Org.Y, nil);
    SetViewportExtEx(Canvas.Handle, Width, Height, nil);
    SetWindowExtEx(Canvas.Handle, Ext.X * Width, Ext.Y * Height, nil);
  end;
end;

function SafeGetFieldAsInteger(Field: TField; ValueOnError: Integer): Integer;
begin
  Result := ValueOnError;
  if (Field.DataType in [ftSmallint, ftInteger, ftWord]) then
    Result := Field.AsInteger
  else if (Field is TLargeintField) and
          (TLargeintField(Field).AsLargeInt >= Low(Integer)) and
          (TLargeintField(Field).AsLargeInt <= MAXINT) then
    Result := TLargeintField(Field).AsLargeInt
  else if (Field.DataType in [ftFloat]) and
          (Field.AsFloat >= Low(Integer)) and
          (Field.AsFloat <= MAXINT) then
    Result := Field.AsInteger
  else if (Field.DataType in [ftCurrency]) and
          (Field.AsCurrency >= Low(Integer)) and
          (Field.AsCurrency <= MAXINT) then
    Result := Field.AsInteger
  else if (Field.DataType in [ftBCD{$IFDEF EH_LIB_6}, ftFMTBcd{$ENDIF}]) and
          not VarIsNull(Field.AsVariant) and
          (Field.AsVariant >= Low(Integer)) and
          (Field.AsVariant <= MAXINT) then
    Result := Field.AsInteger;
end;

function GridRect(ALeft, ATop, ARight, ABottom: Integer): TGridRect;
begin
  Result.Left := ALeft;
  Result.Top := ATop;
  Result.Bottom := ABottom;
  Result.Right := ARight;
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

{ Error reporting }

procedure RaiseGridError(const S: string);
begin
  raise EInvalidGridOperationEh.Create(S);
end;

procedure KillMessage(Wnd: HWnd; Msg: Integer);
// Delete the requested message from the queue, but throw back
// any WM_QUIT msgs that PeekMessage may also return
var
  M: Windows.TMsg;
begin
  M.Message := 0;
  if PeekMessage(M, Wnd, Msg, Msg, pm_Remove) and (M.Message = WM_QUIT) then
    PostQuitMessage(M.wparam);
end;

procedure GridInvalidateRow(Grid: TCustomDBAxisGridEh; Row: Longint);
var
  I: Longint;
begin
  for I := 0 to Grid.FullColCount - 1 do Grid.InvalidateCell(I, Row);
end;

function CheckHintTextRect(DrawTextBiDiModeFlagsReadingOnly: Longint;
  Canvas: TCanvas; RightIndent, FInterlinear: Integer; ws: String; ARect: TRect;
  WordWrap, SingleLine: Boolean; var TextWidth, TextHeight: Integer;
  Alignment: TAlignment; EndEllipsis: Boolean): Boolean;
var
  NewRect: TRect;
  uFormat: Integer;
begin
  Result := False;
  uFormat := DT_LEFT or DT_NOPREFIX or DrawTextBiDiModeFlagsReadingOnly;
  uFormat := uFormat or DT_CALCRECT;
  if WordWrap then
    uFormat := uFormat or DT_WORDBREAK
  else if SingleLine then
    uFormat := uFormat or DT_SINGLELINE;

  NewRect := Rect(0, 0, ARect.Right - ARect.Left - 4 - RightIndent, 0);
  if EndEllipsis and (Alignment <> taLeftJustify) then
    Dec(ARect.Right, 3);
  if NewRect.Right <= 0 then NewRect.Right := 1;
  DrawTextEh(Canvas.Handle, ws, Length(ws), NewRect, uFormat);
  TextWidth := NewRect.Right - NewRect.Left;
  TextHeight := NewRect.Bottom - NewRect.Top;
  if (TextWidth > ARect.Right - ARect.Left - 4 - RightIndent) or
     (TextHeight > ARect.Bottom - ARect.Top - FInterlinear + 1) then
    Result := True;
end;

function PointInGridRect(Col, Row: Longint; const Rect: TGridRect): Boolean;
begin
  Result := (Col >= Rect.Left) and (Col <= Rect.Right) and (Row >= Rect.Top)
    and (Row <= Rect.Bottom);
end;

function ReadOnlyField(Field: TField): Boolean;
var
  MasterFields: TListOfFieldsEh;
  i: Integer;
begin
  Result := Field.ReadOnly;
  if not Result and (Field.FieldKind = fkLookup) and (Field.KeyFields <> '') then
  begin
    Result := True;
    if Field.DataSet = nil then Exit;
    MasterFields := TListOfFieldsEh.Create;
    try
      Field.Dataset.GetFieldList(MasterFields, Field.KeyFields);
      for i := 0 to MasterFields.Count - 1 do
        Result := Result and TField(MasterFields[i]).ReadOnly;
    finally
      MasterFields.Free;
    end;
  end;
end;

{ TDBAxisGridInplaceEdit }

constructor TDBAxisGridInplaceEdit.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  FLookupSource := TDataSource.Create(Self);
  FEditStyle := esSimple;
  FEditButtonStyle := esSimple;
  FCanvas := TControlCanvas.Create;
  TControlCanvas(FCanvas).Control := Self;
  DoubleBuffered := False;
{$IFDEF EH_LIB_12}
  ParentDoubleBuffered := False;
{$ENDIF}

  FButtonsBox := TEditButtonsBoxEh.Create(Self);
  FButtonsBox.SetBounds(0,0,0,0);
  FButtonsBox.Visible := False;
  FButtonsBox.Parent := Self;
  FButtonsBox.OnDown := EditButtonDown;
  FButtonsBox.OnClick := EditButtonClick;
  FButtonsBox.OnMouseMove := EditButtonMouseMove;
  FButtonsBox.OnMouseUp := EditButtonMouseUp;
  FButtonsBox.OnCreateEditButtonControl := CreateEditButtonControl;

end;

destructor TDBAxisGridInplaceEdit.Destroy;
begin
  FreeAndNil(FCanvas);
//  FreeAndNil(FButtonsPanel);
  FreeAndNil(FButtonsBox);
  inherited Destroy;
end;

function TDBAxisGridInplaceEdit.DeleteSeletedText: String;
begin
  Result := Text;
  Delete(Result, SelStart + 1, SelLength);
end;

function GetTextHeight(Canvas: TCanvas; Font: TFont): Integer;
var
  DC: HDC;
  SaveFont: HFont;
  Metrics: Windows.TTextMetric;
begin
  if Canvas = nil
    then DC := GetDC(0)
    else DC := Canvas.Handle;
  {$WARNINGS OFF}
  SaveFont := SelectObject(DC, Font.Handle);
  {$WARNINGS ON}
  GetTextMetrics(DC, Metrics);
  SelectObject(DC, SaveFont);
  if Canvas = nil then
    ReleaseDC(0, DC);
  Result := Metrics.tmHeight;
end;

procedure TDBAxisGridInplaceEdit.CalcEditRect(var ARect: TRect);
var
  TextHeight: Integer;
begin
  if Grid.Flat
    then SetRect(ARect, Grid.GetDataCellHorzOffset(AxisBar), 1, Width - 2, Height - 1)
    else SetRect(ARect, Grid.GetDataCellHorzOffset(AxisBar), 2, Width - 2, Height);
  TextHeight := GetTextHeight(nil, Font);
  if (ARect.Bottom - ARect.Top) <= TextHeight-1 then
    Dec(ARect.Top);
  if ((ARect.Bottom - ARect.Top) < TextHeight) and (ARect.Bottom < Height) then
    Inc(ARect.Bottom);
  if FButtonsBox.ButtonsWidth > 0 then
    if Grid.UseRightToLeftAlignment
      then Inc(ARect.Left, FButtonsBox.ButtonsWidth)
      else Dec(ARect.Right, FButtonsBox.ButtonsWidth);
  if (AxisBar <> nil) and (AxisBar.ImageList <> nil) and AxisBar.ShowImageAndText then
    if Grid.UseRightToLeftAlignment
      then Dec(ARect.Right, AxisBar.ImageList.Width + 5)
      else Inc(ARect.Left, AxisBar.ImageList.Width + 5);
  if (Grid.FIntMemTable <> nil) and (AxisBar = Grid.VisibleAxisBars[0]) and Grid.FIntMemTable.MemTableIsTreeList then
    if Grid.UseRightToLeftAlignment
      then Dec(ARect.Right, Grid.GetCellTreeElmentsAreaWidth)
      else Inc(ARect.Left, Grid.GetCellTreeElmentsAreaWidth);
end;

procedure TDBAxisGridInplaceEdit.BoundsChanged;
var
  R: TRect;
  Msg: Windows.TMsg;
begin
  PeekMessage(Msg, Handle, CM_IGNOREEDITDOWN, CM_IGNOREEDITDOWN, PM_REMOVE);
  UpdateEditButtonControlList;
  UpdateEditButtonControlsState;
  UpdateEditStyle;
  CalcEditRect(R);
  SendStructMessage(Handle, EM_SETRECTNP, 0, R);
  SendMessage(Handle, EM_SCROLLCARET, 0, 0);
  {$IFDEF FPC}
  {$ELSE}
  if SysLocale.FarEast
    then SetImeCompositionWindow(Font, R.Left, R.Top);
  {$ENDIF}
end;

procedure TDBAxisGridInplaceEdit.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  if WordWrap then
    Params.Style := Params.Style and (not ES_AUTOHSCROLL) or ES_MULTILINE or ES_LEFT;
{  if Grid.Flat then
    FButtonsWidth := FlatButtonWidth + 1
  else
    FButtonsWidth := GetSystemMetrics(SM_CXVSCROLL);}
  Params.Style := Params.Style or WS_CLIPCHILDREN;
end;

procedure TDBAxisGridInplaceEdit.DoDropDownKeys(var Key: Word; Shift: TShiftState);
var
  CurColumn: TAxisBarEh;
begin
  case Key of
    VK_UP, VK_DOWN:
      if ssAlt in Shift then
      begin
        if FListVisible then CloseUp(True) else DropDown;
        Key := 0;
      end;
    VK_RETURN, VK_ESCAPE:
      if FListVisible and not (ssAlt in Shift) and not (FActiveList = FPopupCalculator) then
      begin
        CurColumn := Grid.AxisBars[Grid.SelectedIndex];
        if (FActiveList = FDataList) and  // Lookup
           (Key = VK_RETURN) and
            Assigned(CurColumn.OnNotInlist) and
            not CurColumn.UsedLookupDataSet.Locate(
              CurColumn.LookupParams.LookupDisplayFieldName, Self.Text, [loCaseInsensitive])
        then
          CloseUp(False)
        else
          CloseUp(Key = VK_RETURN);
        Key := 0;
      end
      else if not FListVisible and (Key = VK_RETURN) and ([ssCtrl] = Shift) then
      begin
        DropDown;
        Key := 0;
      end;
  end;
end;

procedure TDBAxisGridInplaceEdit.DropDown;
var
  P: TPoint;
  I, J, Y: Integer;
  AxisBar: TAxisBarEh;
  {WorkArea, }R: TRect;
  FLookupDataSet: TDataSet;
  PopupCalculatorIntf: IPopupCalculatorEh;
  ADropDownAlign: TDropDownAlign;
  FDataList: TPopupDataGridEh;
begin
  FDataList := TPopupDataGridEh(Self.FDataList);
  if not FListVisible and Assigned(FActiveList) then
  begin
    FActiveList.Width := Width;
    with Grid do
      AxisBar := AxisBars[SelectedIndex];
//    RowCount := AxisBar.DropDownRows;
    if FActiveList = FDataList then //DataList
      with AxisBar.Field do
      begin
      //for delete FDataList.FSizeGrip.Visible := AxisBar.DropDownSizing;
        FLookupDataSet := AxisBar.UsedLookupDataSet;
        if not Assigned(FLookupDataSet) then Exit;
        FDataList.Color := Color;
        FDataList.Font := Font;
//      FDataList.RowCount := AxisBar.DropDownRows;
        FDataList.SpecRow := AxisBar.DropDownSpecRow;
        if FLookupDataSet.IsSequenced and
          (FLookupDataSet.RecordCount > 0) and
          (Integer(AxisBar.DropDownRows) > FLookupDataSet.RecordCount)
        then
//          RowCount := FLookupDataSet.RecordCount;

          FDataList.RowCount := FLookupDataSet.RecordCount
        else
          FDataList.RowCount := AxisBar.DropDownRows;
        FDataList.ShowTitles := AxisBar.DropDownShowTitles;
        FLookupSource.DataSet := FLookupDataSet;
        if EditStyle in [esDataList, esAltDataList] then
        begin
          FDataList.KeyField := AxisBar.GetDropDownBoxListField;
          FDataList.ListFieldIndex := 0;
          if AxisBar.DropDownBox.ListFieldNames <> ''
            then FDataList.ListField := AxisBar.DropDownBox.ListFieldNames
            else FDataList.ListField := AxisBar.GetDropDownBoxListField;
        end else
        begin
          FDataList.KeyField := AxisBar.LookupParams.LookupKeyFieldNames;
          FDataList.ListFieldIndex := 0;
          FDataList.ListField := AxisBar.LookupDisplayFields; // Assignment ListField must be after ListFieldIndex
        end;
        FDataList.AutoFitColWidths := False; // To avoid fit AxisBars width to editbox width for AxisBar.DropDownWidth = -1
        FDataList.UseMultiTitle := AxisBar.DropDownBox.UseMultiTitle;
        FDataList.ListSource := FLookupSource;
        if (AxisBar.DropDownWidth = -1) then
          FDataList.ClientWidth := FDataList.GetColumnsWidthToFit
        else if AxisBar.DropDownWidth > 0 then
          FDataList.Width := AxisBar.DropDownWidth
        else
          FDataList.Width := Self.Width;
        if (FDataList.Width < Width) then
          FDataList.Width := Self.Width;
        FDataList.KeyValue := Grid.FEditKeyValue {DataSet.FieldByName(KeyFields).Value ddd};
        FListColumnMothed := False;
        FDataList.OnColumnMoved := ListColumnMoved;
        FDataList.TitleParams.SortMarkerStyle := Grid.GetSortMarkerStyle;
//        FDataList.AutoFitColWidths := AxisBar.DropDownBox.AutoFitColWidths;
      end
    else if (FActiveList = FPopupMonthCalendar) then
    begin
        try
        {$IFDEF FPC}
          if Text = '' then
            FPopupMonthCalendar.DateTime := TDate(Date)
          else
            FPopupMonthCalendar.DateTime := TDate(StrToDateTime(Text));
        except
          if AxisBar.Field.AsDateTime = 0 then
            FPopupMonthCalendar.DateTime := TDate(Date)
          else
            FPopupMonthCalendar.DateTime := TDate(AxisBar.Field.AsDateTime);
        {$ELSE}
          if Text = '' then
            FPopupMonthCalendar.Date := TDate(Date)
          else
            FPopupMonthCalendar.Date := TDate(StrToDateTime(Text));
        except
          if AxisBar.Field.AsDateTime = 0 then
            FPopupMonthCalendar.Date := TDate(Date)
          else
            FPopupMonthCalendar.Date := TDate(AxisBar.Field.AsDateTime);
       {$ENDIF}
        end;
        MonthCal_GetMinReqRect(FPopupMonthCalendar.Handle, R);
        FPopupMonthCalendar.Width := R.Right - R.Left;
        FPopupMonthCalendar.Height := R.Bottom - R.Top;
    end else if (FActiveList = FPopupCalculator) then
    begin
      if Supports(FPopupCalculator, IPopupCalculatorEh, PopupCalculatorIntf) then
      begin
        if Text = ''
          then PopupCalculatorIntf.Value := 0
          else PopupCalculatorIntf.Value := StrToFloat(Text);
        PopupCalculatorIntf.Flat := Grid.Flat;
      end;
      HideCaret(Handle);
      SelLength := 0;
    end else
    begin
      //for delete FPickList.FSizeGripResized := False;
      //for delete FPickList.FSizeGrip.Visible := AxisBar.DropDownSizing;
        FPickList.Color := Color;
        FPickList.Font := Font;
        if Assigned(AxisBar.KeyList) and (AxisBar.KeyList.Count > 0) then
        begin
          FPickList.Items.BeginUpdate;
          FPickList.Items.Clear;
          for i := 0 to Min(AxisBar.KeyList.Count, AxisBar.Picklist.Count) - 1 do
            FPickList.Items.AddObject(AxisBar.Picklist.Strings[i], AxisBar.Picklist.Objects[i]);
          FPickList.Items.EndUpdate;
        end else
          FPickList.Items := AxisBar.Picklist;
        if FPickList.Items.Count >= Integer(AxisBar.DropDownRows) then
          FPickList.Height := Integer(AxisBar.DropDownRows) * FPickList.ItemHeight + FPickList.GetBorderSize
        else
          FPickList.Height := FPickList.Items.Count * FPickList.ItemHeight + FPickList.GetBorderSize;
        if AxisBar.DropDownWidth > 0 then
          FPickList.Width := AxisBar.DropDownWidth;
        if AxisBar.Field.IsNull then
          FPickList.ItemIndex := -1
        else if Assigned(AxisBar.KeyList) and (AxisBar.KeyList.Count > 0)
          then FPickList.ItemIndex := AxisBar.PickList.IndexOf(Text)
        else FPickList.ItemIndex := FPickList.Items.IndexOf({dddColumn.Field.Value} Text);
        J := FPickList.ClientWidth;
        for I := 0 to FPickList.Items.Count - 1 do
        begin
          Y := FPickList.Canvas.TextWidth(FPickList.Items[I]);
          if Y > J then J := Y;
        end;
        FPickList.ClientWidth := J + 4;
    end;

    if MRUList.DroppedDown then
      MRUListCloseUp(MRUList, False);

    if BiDiMode = bdRightToLeft
      then ADropDownAlign := daRight
      else ADropDownAlign := daLeft;

    P := AlignDropDownWindow(Self, FActiveList, ADropDownAlign);

    //To avoid overlapping IME windows need to use HWND_NOTOPMOST instead of HWND_TOP
    if FActiveList = FDataList then
    begin
      FDataList.SetBounds(P.X, P.Y, FDataList.Width, FDataList.Height);
      SetWindowPos(FDataList.Handle, {HWND_NOTOPMOST} HWND_TOP, P.X, P.Y, 0, 0,
        SWP_NOSIZE or SWP_NOACTIVATE or SWP_SHOWWINDOW);
//      FDataList.SizeGrip.Visible := AxisBar.DropDownSizing;
      FDataList.SizeGripAlwaysShow := AxisBar.DropDownSizing;
      FDataList.AutoFitColWidths := False;
      FDataList.Visible := True;
      FDataList.AutoFitColWidths := True;
//      FDataList.SizeGrip.Visible := AxisBar.DropDownSizing
//      FDataList.RowCount := FDataList.RowCount;
//      FDataList.RowCount := RowCount; //To update row count for horz scroll bar
    end else
    begin
      {$IFDEF FPC}
      FActiveList.SetBounds(P.X, P.Y, FActiveList.Width, FActiveList.Height);
      {$ELSE}
      {$ENDIF}

      SetWindowPos(FActiveList.Handle, {HWND_NOTOPMOST} HWND_TOP, P.X, P.Y, 0, 0,
        SWP_NOSIZE or SWP_NOACTIVATE or SWP_SHOWWINDOW);
      if FActiveList = FPickList then
      begin
        FPickList.Visible := True; //commment for Tab key
        FPickList.SizeGripAlwaysShow := AxisBar.DropDownSizing;
      end
//        FPickList.SizeGrip.Visible := AxisBar.DropDownSizing
      else if FActiveList = FPopupCalculator then
        FPopupCalculator.Visible := True; //?
    end;

    if FActiveList = FDataList then
      FDataList.SizeGripResized := False
    else if FActiveList = FPickList then
      FPickList.SizeGripResized := False;
    //FActiveList.Visible := True;
    FListVisible := True;
    Invalidate;
    Windows.SetFocus(Handle);
    if FirstVisibleButtonIndex >= 0 then
      FButtonsBox.BtnCtlList[FirstVisibleButtonIndex].EditButtonControl.AlwaysDown := True;
    FDroppedDown := True;
  end;
end;

procedure TDBAxisGridInplaceEdit.CloseUp(Accept: Boolean);
var
  MasterFields: TListOfFieldsEh;
  ListValue: Variant;
  CurColumn: TAxisBarEh;
  CanChange: Boolean;
  PopupCalculatorIntf: IPopupCalculatorEh;
  VarDateTime, OldDateTime: TDateTime;
  FDataList: TPopupDataGridEh;
  KeyLocated: Boolean;
begin
  FDataList := TPopupDataGridEh(Self.FDataList);
  ListValue := Null;
  KeyLocated := False;
  if Grid.SelectedIndex < 0 then Exit;
  CurColumn := Grid.AxisBars[Grid.SelectedIndex];
  if FListVisible then
  begin
    if (FActiveList <> nil) and (FActiveList.HandleAllocated) and
      ((GetFocus = FActiveList.Handle) or
      (GetParent(GetFocus) = FActiveList.Handle))
    then
      SetFocus;
    if FirstVisibleButtonIndex >= 0 then
      FButtonsBox.BtnCtlList[FirstVisibleButtonIndex].EditButtonControl.AlwaysDown := False;
    if FLockCloseList then Exit;
    if GetCapture <> 0 then SendMessage(GetCapture, WM_CANCELMODE, 0, 0);
    if FActiveList = FDataList then
    begin
      ListValue := FDataList.KeyValue;
      KeyLocated := FDataList.LocateKey or FDataList.SpecRow.Selected;
      if FDataList.SizeGripResized then
      begin
        CurColumn.DropDownRows := FDataList.RowCount;
        CurColumn.FDropDownWidth := FDataList.Width; //Assign to FValue to avoid nil FActiveList when Tab
      end;
      if FListColumnMothed then
        CurColumn.DropDownSpecRow.CellsText := FDataList.SpecRow.CellsText;
    end else if FActiveList = FPopupMonthCalendar then
    begin //MonthCalendar
    end else if FPickList = FActiveList then
    begin
      if FPickList.ItemIndex <> -1 then
      begin
        if Assigned(CurColumn.KeyList) and (CurColumn.KeyList.Count > 0)
          then ListValue := CurColumn.KeyList.Strings[FPicklist.ItemIndex]
          else ListValue := FPickList.Items[FPicklist.ItemIndex];
      end;
      if PickList.SizeGripResized then
      begin
        CurColumn.DropDownRows := PickList.ClientHeight div FPickList.ItemHeight;
        CurColumn.FDropDownWidth := PickList.Width; //Assign to FValue to avoid nil FActiveList when Tab
      end;
    end;
    SetWindowPos(FActiveList.Handle, 0, 0, 0, 0, 0, SWP_NOZORDER or
      SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_HIDEWINDOW);
    FActiveList.Visible := False;
    FDroppedDown := False;
    FListVisible := False;
    if Assigned(FDataList) then
    begin
      FDataList.AutoFitColWidths := False;
      FDataList.ListSource := nil;
    end;
    FLookupSource.Dataset := nil;
    Invalidate;
    ShowCaret(Handle);
    if Accept then
    begin
      if FActiveList = FDataList then // Lookup
      begin
        with Grid{, AxisBars[SelectedIndex].Field} do
        begin
          MasterFields := TListOfFieldsEh.Create;
            try
              DataLink.Dataset.GetFieldList(MasterFields, AxisBar.LookupParams.KeyFieldNames {KeyFields});
              if FieldsCanModify(MasterFields) and Grid.CanEditModifyText and
                 CurColumn.CanModify(True) then
              begin
                Grid.DataSource.DataSet.Edit;
                try
                  CanChange := Grid.Datalink.Editing;
                  if CanChange then
                  begin
                    Grid.Datalink.Modified;
                    Grid.FEditKeyValue := ListValue;
                    if KeyLocated then
                      Grid.FEditText := FDataList.SelectedItem;
                  end;
                except
                  on Exception do
                  begin
                    Self.Text := CurColumn.Field.Text + ' '; //May be delphi bag. But without ' ' don't assign
                    raise;
                  end;
                end;
                if KeyLocated then
                  Self.Text := FDataList.SelectedItem;
                SelectAll;
                UpdateData;
              end;
            finally
              MasterFields.Free;
            end;
        end;
        if CurColumn.DropDownBox.ListSourceAutoFilter and
          (CurColumn.DropDownBox.ListSource <> nil) and
          (CurColumn.DropDownBox.ListSource.DataSet <> nil)
        then
          RefilterDropDownBoxListSource('');
      end else if (FActiveList = FPopupMonthCalendar) then
      begin
        with Grid, CurColumn.Field do
          if CurColumn.CanModify(True) and CanEditModifyText then
          begin
            DataSet.Edit;
            try
{$IFDEF EH_LIB_6}
              if not TryStrToTime(Text, OldDateTime) then OldDateTime := 0;
{$ELSE}
              OldDateTime := StrToDateTime(Text);
{$ENDIF}
            except
              OldDateTime := 0;
            end;
            {$IFDEF FPC}
            VarDateTime := Trunc(FPopupMonthCalendar.DateTime) + Frac(OldDateTime);
            CurColumn.UpdateDataValues(DateToStr(Trunc(FPopupMonthCalendar.DateTime)), Variant(VarDateTime) , False);
            {$ELSE}
            VarDateTime := Trunc(FPopupMonthCalendar.Date) + Frac(OldDateTime);
            CurColumn.UpdateDataValues(DateToStr(Trunc(FPopupMonthCalendar.Date)), Variant(VarDateTime) , False);
            {$ENDIF}
            //AsDateTime := FPopupMonthCalendar.Date;
          end;
      end
      else if (FActiveList = FPopupCalculator) then
      begin
        if CurColumn.CanModify(True) and Grid.CanEditModifyText then
        begin
          if Supports(FPopupCalculator, IPopupCalculatorEh, PopupCalculatorIntf) then
            if VarType(PopupCalculatorIntf.Value) in
                 [varDouble, varSmallint, varInteger, varSingle, varCurrency]
            then
            begin
              Text := FloatToStr(PopupCalculatorIntf.Value);
              Grid.FEditText := Text;
              SelectAll;
              Grid.UpdateData;
            end;
        end;
      end
      else if (not VarIsNull(ListValue)) and Grid.CanEditModifyText then
        with Grid, CurColumn.Field do
          if Assigned(CurColumn) and Assigned(CurColumn.KeyList) and (CurColumn.KeyList.Count > 0) then
          begin
            if (FPicklist.ItemIndex >= 0) then
            begin
              Self.Text := FPickList.Items[FPicklist.ItemIndex];
              Grid.FEditText := Self.Text;
              UpdateImageIndex;
              UpdateData;
            end
          end else
          begin
            Self.Text := ListValue;
            Grid.FEditText := ListValue;
            UpdateImageIndex;
            UpdateData;
          end;
    end else if FActiveList = FDataList then
    begin
      Text := Grid.FEditText;
      if CurColumn.DropDownBox.ListSourceAutoFilter and
        (CurColumn.DropDownBox.ListSource <> nil) and
        (CurColumn.DropDownBox.ListSource.DataSet <> nil)
      then
        RefilterDropDownBoxListSource('');
    end else if FActiveList = FPickList then
      if CurColumn.GetBarType = ctKeyPickList then
      begin
        Text := Grid.FEditText;
      end else
        Text := Grid.FEditText;
    if Parent.Visible and not (csDestroying in Grid.ComponentState) then
      Parent.SetFocus;
  end;
end;

procedure TDBAxisGridInplaceEdit.LocateListText;
var
  AColumn: TAxisBarEh;
begin
  with Grid do AColumn := AxisBars[SelectedIndex];
  if not AColumn.CanModify(True) then Exit;
  if (EditStyle in [esLookupDataList, esAltLookupDataList, esDataList, esAltDataList]) then
  begin
    Grid.FEditText := Text;
    if (AColumn.UsedLookupDataSet <> nil) and
       AColumn.UsedLookupDataSet.Locate(AColumn.LookupParams.LookupDisplayFieldName, Text, [loCaseInsensitive])
    then
      Grid.FEditKeyValue :=
        AColumn.UsedLookupDataSet.FieldValues[AColumn.LookupParams.LookupKeyFieldNames]
    else
      Grid.FEditKeyValue := Null;
  end else
    Grid.FEditText := Text;
end;

type
  TAxisBarMainEditButtonEhCrack = class(TAxisBarMainEditButtonEh);
  TDropDownFormCallParamsEhCrack = class(TDropDownFormCallParamsEh);

procedure TDBAxisGridInplaceEdit.KeyDown(var Key: Word; Shift: TShiftState);
var
//  MasterFields: TListOfFieldsEh;
//  Field: TField;
  Y: Integer;
  S: String;
  eb: TEditButtonEh;
  AutoRepeat: Boolean;
  FDataList: TPopupDataGridEh;

  procedure SendToParent;
  begin
    Grid.KeyDown(Key, Shift);
    Key := 0;
  end;

begin
  FDataList := TPopupDataGridEh(Self.FDataList);
  if (EditStyle in [esEllipsis, esDropDown]) and (Key = VK_RETURN) and (Shift = [ssCtrl]) then
  begin
    KillMessage(Handle, WM_CHAR);
    Grid.EditButtonClick;
  end else
    if (Key = VK_DELETE) and (Shift = []) and
       ((AxisBar.GetBarType in [ctLookupField, ctKeyPickList]) or
        ((AxisBar.GetBarType = ctPickList) and AxisBar.LimitTextToListValues)
       )
    {(EditStyle in [esLookupDataList,esPickList])}
    and AxisBar.CanModify(False) then
    begin
      if (SelStart = 0) and (SelLength = Length(Text)) and AxisBar.CanModify(True) then // All text seleted
      begin
        if EditStyle in [esLookupDataList, esAltLookupDataList, esDataList, esAltDataList] then //lookup or DataList
        begin
//          Field := AxisBar.Field;
//          MasterFields := TListOfFieldsEh.Create;
          try
//            Field.Dataset.GetFieldList(MasterFields, Field.KeyFields);
            if FieldsCanModify(AxisBar.LookupParams.KeyFields) then
            begin
              Grid.Datalink.Edit;
              Grid.Datalink.Modified;
              Grid.FEditKeyValue := Null;
              Grid.FEditText := '';
              Text := '';
              if Assigned(FDataList) then FDataList.KeyValue := Grid.FEditKeyValue;
              if FListVisible and AxisBar.DropDownBox.ListSourceAutoFilter then
                RefilterDropDownBoxListSource('');
            end;
          finally
//            MasterFields.Free;
          end;
        end
        else if (EditStyle in [esPickList, esAltPickList]) and
          (AxisBar.GetBarType = ctKeyPickList) then
        begin // keypicklist
          Text := '';
          Grid.FEditText := Text;
        end
      end else if Assigned(AxisBar.OnNotInlist) then
      begin
        S := DeleteSeletedText;
        Y := SelStart;
        if AxisBar.CanModify(True) then
        begin
          Text := S;
          SelStart := Y;
          LocateListText;
          if Assigned(FDataList) then
            FDataList.KeyValue := Grid.FEditKeyValue
          else if Assigned(FPickList) then
            FPickList.ItemIndex :=
//              StringsLocate(FPickList.Items, Grid.FEditText, [loCaseInsensitive]);
              AxisBar.LocatePickList(Grid.FEditText, False);
        end;
      end else
        Key := 0;
    end
    else if (Key = VK_BACK) and
      (AxisBar.GetBarType in [ctPickList, ctKeyPickList, ctDataList, ctLookupField]) then
    begin
      if AxisBar.LimitTextToListValues then
      begin
        Key := VK_LEFT;
        inherited KeyDown(Key, Shift);
      end else if AxisBar.GetBarType in [ctKeyPickList, ctLookupField] then
      begin
        S := DeleteSeletedText;
        Y := SelStart;
        if AxisBar.CanModify(True) then
        begin
          Grid.DataSource.DataSet.Edit;
          Delete(S, Y, 1);
          Text := S;
          SelStart := Y - 1;
          LocateListText;
          if Assigned(FDataList) then
            FDataList.KeyValue := Grid.FEditKeyValue
          else if Assigned(FPickList) then
            FPickList.ItemIndex :=
//              StringsLocate(FPickList.Items, Grid.FEditText, [loCaseInsensitive]);
              AxisBar.LocatePickList(Grid.FEditText, False);
        end;
      end;
    end
    else if WordWrap and (Key in [VK_UP, VK_DOWN]) then
    begin
      if not (goAlwaysShowEditorEh in Grid.Options) then Exit;
      Y := Perform(EM_LINEFROMCHAR, SelStart, 0);
      if (Y = 0) and (Key = VK_UP) then
        inherited KeyDown(Key, Shift)
      else if (Y + 1 = Perform(EM_GETLINECOUNT, 0, 0)) and (Key = VK_DOWN) then
        inherited KeyDown(Key, Shift)
      else if SelLength = Length(Text) then
        inherited KeyDown(Key, Shift);
    end
    else if AxisBar.DropDownSpecRow.Visible and
           (EditStyle in [esLookupDataList, esAltLookupDataList, esDataList, esAltDataList]) and
           (ShortCut(Key, Shift) = AxisBar.DropDownSpecRow.ShortCut) and
           AxisBar.CanModify(False) then
    begin
      if AxisBar.CanModify(True) then
      begin
        Text := AxisBar.DropDownSpecRow.CellText[0];
        Grid.FEditText := Text;
        Grid.FEditKeyValue := AxisBar.DropDownSpecRow.Value;
        FDataList.KeyValue := Grid.FEditKeyValue;
        SelectAll;
      end;
    end
    else if GetEditButtonByShortCut(ShortCut(Key, Shift)) <> nil then
    begin
      eb := GetEditButtonByShortCut(ShortCut(Key, Shift));
      FButtonsBox.BtnCtlList[eb.Index + 1].EditButtonControl.EditButtonDown(False, AutoRepeat);
      FButtonsBox.BtnCtlList[eb.Index + 1].EditButtonControl.Click; //DropDown;
      Key := 0;
    end else
      inherited KeyDown(Key, Shift);
end;

procedure TDBAxisGridInplaceEdit.KeyUp(var Key: Word; Shift: TShiftState);
var
  FDataList: TPopupDataGridEh;
begin
  FDataList := TPopupDataGridEh(Self.FDataList);
  inherited KeyUp(Key, Shift);
  if (EditStyle in [esLookupDataList, esAltLookupDataList, esDataList, esAltDataList]) and
     (FDataList <> nil) and
     FListVisible and
     (Key = VK_CONTROL)
  then
    FDataList.KeyUp(Key, Shift);
end;

procedure TDBAxisGridInplaceEdit.ListMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
    CloseUp(PtInRect(FActiveList.ClientRect, Point(X, Y)));
end;

procedure TDBAxisGridInplaceEdit.ListMouseCloseUp(Sender: TObject; Accept: Boolean);
begin
  CloseUp(Accept);
end;

procedure TDBAxisGridInplaceEdit.PopupListboxGetImageIndex(Sender: TObject; ItemIndex: Integer; var ImageIndex: Integer);
begin
//  if Assigned(AxisBar) and Assigned(AxisBar.OnGetItemImageIndex) then
//    AxisBar.OnGetItemImageIndex(AxisBar, ItemIndex, ImageIndex);
end;

procedure TDBAxisGridInplaceEdit.UpDownClick(Sender: TObject; Button: TUDBtnType);
var Col: TAxisBarEh;
  Znak: Integer;
begin
  Col := Grid.AxisBars[Grid.SelectedIndex];
  if not Col.CanModify(True) then Exit;
  Znak := 1;
  if (Col.GetEditText <> Text) then
  begin
    Col.SetEditText(Text);
    Col.Grid.UpdateData;
  end;
  if Button = btNext then
  begin
    if Col.GetBarType <> ctCommon then Znak := -1;
    Col.SetNextFieldValue(Col.Increment * Znak);
  end else
  begin
    if Col.GetBarType <> ctCommon then Znak := -1;
    Col.SetNextFieldValue(-Col.Increment * Znak);
  end;
end;

procedure TDBAxisGridInplaceEdit.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
  if AxisBar.DblClickNextVal and (ssDouble in Shift) then
    if (ssShift in Shift)
      then AxisBar.SetNextFieldValue(-1)
    else AxisBar.SetNextFieldValue(1);
end;

procedure TDBAxisGridInplaceEdit.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseMove(Shift, X, Y);
end;

procedure TDBAxisGridInplaceEdit.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
end;

procedure TDBAxisGridInplaceEdit.PaintWindow(DC: HDC);
begin
  if (AxisBar <> nil) and (AxisBar.ImageList <> nil) and AxisBar.ShowImageAndText then
    DrawEditImage(DC);
  inherited PaintWindow(DC);
end;

procedure TDBAxisGridInplaceEdit.UpdateActiveList;
var
  FDataList: TPopupDataGridEh;
begin
  FDataList := TPopupDataGridEh(Self.FDataList);
  case EditStyle of
    esPickList, esAltPickList:
      begin
        if FPickList = nil then
        begin
          FPickList := TPopupListboxEh.Create(Self);
          FPickList.Visible := False;
          {$IFDEF FPC}
          {$ELSE}
          FPickList.Parent := Self;
          {$ENDIF}
          FPickList.OnMouseUp := ListMouseUp;
          FPickList.OnGetImageIndex := PopupListboxGetImageIndex;
//            FPickList.IntegralHeight := True;
          FPickList.ItemHeight := FPickList.GetTextHeight;
  {$IFDEF FPC}
  {$ELSE}
          FPickList.Ctl3D := True;
  {$ENDIF}
        end;
        if Assigned(AxisBar) and Assigned(AxisBar.ImageList)
          then FPickList.ImageList := AxisBar.ImageList
          else FPickList.ImageList := nil;
        FActiveList := FPickList;
      end;
    esLookupDataList, esAltLookupDataList, esDataList, esAltDataList:
      begin
        if (FDataList = nil) or (FDataList <> AxisBar.DataList) then
        begin
          FDataList := TPopupDataGridEh(AxisBar.DataList); // TPopupDataGridEh.Create(Self);
          FDataList.Visible := False;
  {$IFDEF FPC}
  {$ELSE}
          FDataList.Ctl3D := True;
          FDataList.ParentCtl3D := False;
          FDataList.Parent := Self;
  {$ENDIF}
          //FDataList.OnMouseUp := ListMouseCloseUp;
          FDataList.OnMouseCloseUp := ListMouseCloseUp;
          //FDataList.OnMouseMove := ListMouseMove;
          //FDataList.OnMouseDown := ListMouseDown;
          FDataList.FreeNotification(Self);
          FDataList.DrawMemoText := AxisBar.Grid.DrawMemoText;
        end;
        FActiveList := FDataList;
        TPopupDataGridEh(Self.FDataList) := FDataList;
      end;
    esDateCalendar, esAltCalendar:
      begin
        if FPopupMonthCalendar = nil then
        begin
          FPopupMonthCalendar := TPopupMonthCalendarEh.Create(Self);
          FPopupMonthCalendar.Visible := False;
//          FPopupMonthCalendar.Parent := Self;
//          FPopupMonthCalendar.ParentWindow := 0;
          FPopupMonthCalendar.ParentWindow := GetDesktopWindow;
  {$IFDEF FPC}
  {$ELSE}
          FPopupMonthCalendar.ParentFont := False;
  {$ENDIF}
        end;
        FActiveList := FPopupMonthCalendar;
      end;
    esUpDown:
      FActiveList := nil;
    esDropDown, esAltDropDown:
      begin
        if Assigned(AxisBar) and Assigned(AxisBar.Field) and (AxisBar.Field is TNumericField) then
        begin
          FActiveList := GetPopupCalculator;
        end else
          FActiveList := nil;
      end;
  else { cbsNone, cbsEllipsis, or read only field }
    FActiveList := nil;
  end;
end;

procedure TDBAxisGridInplaceEdit.SetEditStyle(Value: TEditStyle);
begin
  FEditStyle := Value;
  Repaint;
end;

procedure TDBAxisGridInplaceEdit.SetEditButtonStyle(const Value: TEditStyle);
begin
  FEditButtonStyle := Value;
  UpdateEditStyle;
  Repaint;
end;

procedure TDBAxisGridInplaceEdit.UpdateEditStyle;
var
  MasterFields: TListOfFieldsEh;

  function MasterFieldsCanModify: Boolean;
  var i: Integer;
  begin
    Result := True;
    for i := 0 to MasterFields.Count - 1 do
      if not TField(MasterFields[i]).CanModify then
      begin
        Result := False;
        Exit;
      end;
  end;

begin
  if EditButtonStyle <> esSimple then
    EditStyle := EditButtonStyle
  else if FirstVisibleButtonIndex >= 0 then
  begin
    case FButtonsBox.BtnCtlList[FirstVisibleButtonIndex].EditButtonControl.Style of
      ebsEllipsisEh: EditStyle := esEllipsis;
      ebsDropDownEh, ebsAltDropDownEh:
        if Assigned(AxisBar.Field) then
          with AxisBar.Field do
          begin
          { Show the dropdown button only if the field is editable }
            if AxisBar.LookupParams.LookupIsSetUp {FieldKind = fkLookup} then
            begin
              MasterFields := TListOfFieldsEh.Create;
              try
                Dataset.GetFieldList(MasterFields, AxisBar.LookupParams.KeyFieldNames);
              { AxisBar.DefaultReadonly will always be True for a lookup field.
                Test if AxisBar.ReadOnly has been assigned a value of True }
                if (MasterFields.Count > 0) and MasterFieldsCanModify and
                  not ((cvReadOnly in AxisBar.AssignedValues) and AxisBar.ReadOnly) then
                  with Grid do
                    if not ReadOnly and DataLink.Active and not Datalink.ReadOnly then
                      EditStyle := esLookupDataList;
              finally
                MasterFields.Free;
              end;
            end
            else
              if Assigned(AxisBar.Picklist) and (AxisBar.PickList.Count > 0) and
                not AxisBar.Readonly then
                EditStyle := esPickList
              else if (DataType in [ftDate, ftDateTime{$IFDEF EH_LIB_6}, ftTimeStamp{$ENDIF}]) and not AxisBar.Readonly then
                EditStyle := esDateCalendar
              else
                EditStyle := esSimple;
          end;
      ebsUpDownEh: EditStyle := esUpDown;
      ebsAltUpDownEh: EditStyle := esAltUpDown;
    end;
  end else
    EditStyle := esSimple;

  UpdateActiveList;
end;

function GetColumnEditStile(AxisBar: TAxisBarEh): TEditStyle;
var
//  MasterFields: TListOfFieldsEh;
//  ACanModify: Boolean;
  BarType: TAxisBarEhType;

  function CheckLookup: Boolean;
  begin
    Result := AxisBar.LookupParams.LookupActive;
  end;

begin
  Result := esSimple;
  BarType := AxisBar.GetBarType;
  case AxisBar.ButtonStyle of
    cbsEllipsis: Result := esEllipsis;
    cbsDropDown:
      if CheckLookup then
        Result := esLookupDataList
      else if (BarType in [ctPickList, ctKeyPickList]) and not AxisBar.Readonly then
        Result := esPickList
      else if BarType = ctDataList then
        Result := esDataList
      else
        Result := esDropDown;
    cbsAltDropDown:
      if CheckLookup then
        Result := esAltLookupDataList
      else if (BarType in [ctPickList, ctKeyPickList]) and not AxisBar.Readonly then
        Result := esAltPickList
      else if BarType = ctDataList then
        Result := esAltDataList
      else if Assigned(AxisBar.Field) and
        (AxisBar.Field.DataType in [ftDate, ftDateTime{$IFDEF EH_LIB_6}, ftTimeStamp{$ENDIF}])
      then
        Result := esAltCalendar
      else
        Result := esAltDropDown;
    cbsUpDown: Result := esUpDown;
    cbsAltUpDown: Result := esAltUpDown;
    cbsAuto:
//      if Assigned(AxisBar.Field) then
//        with AxisBar.Field do
        begin
          if CheckLookup then
            Result := esLookupDataList
          else if (BarType in [ctPickList, ctKeyPickList]) and not AxisBar.Readonly then
            Result := esPickList
          else if BarType = ctDataList then
            Result := esDataList
          else if Assigned(AxisBar.Field) and
                 (AxisBar.Field.DataType in [ftDate, ftDateTime{$IFDEF EH_LIB_6}, ftTimeStamp{$ENDIF}]) and
                  not AxisBar.Readonly
          then
            Result := esDateCalendar
          else if (AxisBar.DropDownFormParams.DropDownForm <> nil) or
                  (AxisBar.DropDownFormParams.DropDownFormClassName <> '') then
            Result := esDropDown;
        end;
  end;
end;

procedure TDBAxisGridInplaceEdit.UpdateContents;
var
  AxisBar: TAxisBarEh;
  NewStyle: TEditStyle;
  ColCellParamsReadOnly: Boolean;
  BarType: TAxisBarEhType;

  function CheckLookup: Boolean;
  begin
    Result := AxisBar.LookupParams.LookupActive;
  end;

begin
  FFixedDownButton := -1;
  with Grid do
    AxisBar := AxisBars[SelectedIndex];
  BarType := AxisBar.GetBarType;
  NewStyle := esSimple;
  case AxisBar.ButtonStyle of
    cbsEllipsis: NewStyle := esEllipsis;
    cbsDropDown:
      if CheckLookup then
        NewStyle := esLookupDataList
      else if (BarType in [ctPickList, ctKeyPickList]) and not AxisBar.Readonly then
        NewStyle := esPickList
      else if BarType = ctDataList then
        NewStyle := esDataList
      else
        NewStyle := esDropDown;
    cbsAltDropDown:
      if CheckLookup then
        NewStyle := esAltLookupDataList
      else if (BarType in [ctPickList, ctKeyPickList]) and not AxisBar.Readonly then
        NewStyle := esAltPickList
      else if BarType = ctDataList then
        NewStyle := esAltDataList
      else if Assigned(AxisBar.Field) and
        (AxisBar.Field.DataType in [ftDate, ftDateTime{$IFDEF EH_LIB_6}, ftTimeStamp{$ENDIF}])
      then
        NewStyle := esAltCalendar
      else
        NewStyle := esAltDropDown;
    cbsAuto:
//      if Assigned(AxisBar.Field) then
//        with AxisBar.Field do
        begin
          if CheckLookup then
            NewStyle := esLookupDataList
          else if (BarType in [ctPickList, ctKeyPickList]) and not AxisBar.Readonly then
            NewStyle := esPickList
          else if BarType = ctDataList then
            NewStyle := esDataList
          else if Assigned(AxisBar.Field) and
                  (AxisBar.Field.DataType in [ftDate, ftDateTime{$IFDEF EH_LIB_6}, ftTimeStamp{$ENDIF}]) and
                  not AxisBar.Readonly
          then
            NewStyle := esDateCalendar
          else if (AxisBar.DropDownFormParams.DropDownForm <> nil) or
                  (AxisBar.DropDownFormParams.DropDownFormClassName <> '') then
            NewStyle := esDropDown;
        end;
    cbsUpDown:
      NewStyle := esUpDown;
    cbsAltUpDown:
      NewStyle := esAltUpDown;
  end;
  EditButtonStyle := NewStyle;
  Self.Font.Assign(AxisBar.Font);
  ColCellParamsReadOnly := not AxisBar.CanModify(False);
  AxisBar.FillColCellParams(Grid.FColCellParamsEh);
  with Grid.FColCellParamsEh do
  begin
    FBackground := AxisBar.Color;
    FFont := Self.Font;
    FState := [gdFocused];
    FText := AxisBar.GetEditText;
    FReadOnly := ColCellParamsReadOnly;
    Grid.GetCellParams(AxisBar, FFont, FBackground, FState);
    if not (csLoading in Grid.ComponentState) then
      AxisBar.GetColCellParams(True, Grid.FColCellParamsEh);
    Self.Color := FBackground;
    Self.FImageIndex := FImageIndex;
    if not ColCellParamsReadOnly <> FReadOnly then
    begin
      FReadOnlyStored := True;
      Self.ReadOnly := FReadOnly;
    end else
      FReadOnlyStored := False;
  end;
  WordWrap := AxisBar.CurLineWordWrap(AxisBar.GetCellHeight(Grid.Row));
//  inherited UpdateContents;
  Text := '';
  EditMask := AxisBar.GetEditMask;
  Text := Grid.FColCellParamsEh.FText;
  MaxLength := Grid.GetEditLimit;
  MRUList := AxisBar.MRUList;
  EditButtonPressed := False;
end;

{$IFDEF FPC}
{$ELSE}
procedure TDBAxisGridInplaceEdit.CMCancelMode(var Message: TCMCancelMode);

  function CheckActiveListChilds(Control: TWinControl): Boolean;
  var i: Integer;
  begin
    Result := False;
    if Control <> nil then
      for i := 0 to Control.ControlCount - 1 do
        if Control.Controls[I] = Message.Sender then
        begin
          Result := True;
          Exit;
        end;
  end;
begin
  inherited;
  if (Message.Sender <> Self) and  not ContainsControl(Message.Sender) then
  begin
    if (Message.Sender <> FActiveList) and not CheckActiveListChilds(FActiveList) then
      CloseUp(False);
    if (FMRUListControl <> nil) and (Message.Sender <> FMRUListControl)
      and  not CheckActiveListChilds(FMRUListControl) then
      MRUListCloseUp(MRUList, False);
  end;
end;
{$ENDIF}

procedure TDBAxisGridInplaceEdit.CNCommand(var Message: TWMCommand);
begin
  inherited;
end;

procedure TDBAxisGridInplaceEdit.WMKillFocus(var Message: TWMKillFocus);
begin
  if Grid.FSelectionActive <> Grid.IsSelectionActive then
    Grid.SelectionActiveChanged;
  if not SysLocale.FarEast then inherited
  else
  begin
{    ImeName := Screen.DefaultIme;
    ImeMode := imDontCare;
}
    inherited;
{   This code switches layout to default language. This code is incorrect.
    if HWND(Message.FocusedWnd) <> Grid.Handle then
      ActivateKeyboardLayout(Screen.DefaultKbLayout, KLF_ACTIVATE);
}      
  end;
  if FListVisible and not
    ((Message.FocusedWnd = FActiveList.Handle) or
    (GetParent(Message.FocusedWnd) = FActiveList.Handle)
    )
  then
    CloseUp(False)
  else if MRUList.DroppedDown and not (Message.FocusedWnd = MRUListControl.Handle) then
    MRUListCloseUp(MRUList, False);
// Not a goog idea. To many updates if value write with error raise
//  if not Grid.Datalink.FInUpdateData then
//    Grid.Datalink.UpdateData;
end;

procedure TDBAxisGridInplaceEdit.WMSetFocus(var Message: TWMSetFocus);
begin
  if Grid.FSelectionActive <> Grid.IsSelectionActive then
    Grid.SelectionActiveChanged;
  inherited;
end;

procedure TDBAxisGridInplaceEdit.WMLButtonDblClk(var Message: TWMLButtonDblClk);
begin
  inherited;
end;

procedure TDBAxisGridInplaceEdit.WMPaint(var Message: TWMPaint);
begin
{$IFDEF FPC}
  inherited;
{$ELSE}
  PaintHandler(Message);
{$ENDIF}
end;

procedure TDBAxisGridInplaceEdit.WMSetCursor(var Message: TWMSetCursor);
var
  P: TPoint;
  R: TRect;
begin
  GetCursorPos(P);
  SendStructMessage(Handle, EM_GETRECT, 0, R);
  if PtInRect(Rect(R.Left, 0, R.Right, Height), ScreenToClient(P))
    then inherited
    else Windows.SetCursor(LoadCursor(0, idc_Arrow));
end;

procedure TDBAxisGridInplaceEdit.WndProc(var Message: TMessage);
var
  AColumn: TAxisBarEh;
  ShiftState: TShiftState;
  ACharCode: Word;
  FDataList: TPopupDataGridEh;
begin
  FDataList := TPopupDataGridEh(Self.FDataList);
  case Message.Msg of
    wm_KeyDown, wm_SysKeyDown, wm_Char:
      begin
        if (EditStyle in
            [esPickList, esLookupDataList, esDateCalendar, esAltCalendar, esAltPickList,
             esAltLookupDataList, esDataList, esAltDataList])
          or
            CanDropCalculator
        then
{$IFDEF CIL}
          with TWMKey.Create(Message) do
{$ELSE}
          with TWMKey(Message) do
{$ENDIF}
          begin
            ACharCode := CharCode;
            ShiftState := KeyDataToShiftState(KeyData);
            DoDropDownKeys(ACharCode, ShiftState);
            CharCode := ACharCode;
            AColumn := Grid.AxisBars[Grid.SelectedIndex];
            if (CharCode <> 0) and (Message.Msg = wm_Char) and
               (Char(CharCode) >= #32) and not FListVisible
              and AColumn.AutoDropDown then
            begin
            //AColumn.CanModify(True);
              DropDown;
            end;
            if (CharCode <> 0) and FListVisible then
            begin
              if (FActiveList = FPopupCalculator) and
                 ((CharCode in [8, 13, 27]) or ((CharCode >= 32) and (CharCode < 127))) then
              begin
                SendMessage(FActiveList.Handle, Msg, Message.WParam, Message.LParam);
                Exit;
              end else
                with TMessage(Message) do
                begin
                  if ((CharCode in [VK_UP, VK_DOWN, VK_PRIOR, VK_NEXT]) and not (ssShift in ShiftState)) or
                    ((CharCode in [VK_HOME, VK_END]) and (ssCtrl in ShiftState)) or
                    ((CharCode in [VK_LEFT, VK_RIGHT]) and (EditStyle in [esDateCalendar, esAltCalendar])) then
                  begin
                    SendMessage(FActiveList.Handle, Msg, WParam, LParam);
                    if (EditStyle in [esLookupDataList, esAltLookupDataList, esDataList, esAltDataList]) and (FDataList <> nil) then
                      Text := FDataList.SelectedItem
                    else if (EditStyle in [esPickList, esAltPickList]) then
                      if (FPickList.ItemIndex <> -1) and (Text <> FPickList.Items[FPickList.ItemIndex]) then
                        Text := FPickList.Items[FPickList.ItemIndex];
                    Exit;
                  end;
                end;
            end;
          end;

          if (MRUList <> nil) and MRUList.DroppedDown then
          begin
{$IFDEF CIL}
            with TWMKey.Create(Message) do
{$ELSE}
            with TWMKey(Message) do
{$ENDIF}
            begin
              if (Message.Msg = WM_KEYDOWN) and
                ((CharCode in [VK_UP, VK_DOWN, VK_PRIOR, VK_NEXT]) and not (ssAlt in ShiftState))
                  or ((CharCode in [VK_HOME, VK_END]) and (ssCtrl in ShiftState))
              then
              begin
                SendMessage(MRUListControl.Handle, Msg, Message.WParam, Message.LParam);
                Exit;
              end;
              if (Message.Msg = wm_Char) and (CharCode in [VK_RETURN, VK_ESCAPE]) then
              begin
                MRUListCloseUp(MRUList, CharCode = VK_RETURN);
                Exit;
              end;
            end;
          end;
      end;
  end;
  inherited WndProc(Message);
end;

procedure TDBAxisGridInplaceEdit.DefaultHandler(var Message);
var
  BlankText: String;
  Accept: Boolean;
  R: TRect;
  WinTMessage: TMessage;
begin
  WinTMessage := UnwrapMessageEh(Message);
  case WinTMessage.Msg of
    WM_LBUTTONDBLCLK, WM_LBUTTONDOWN, WM_LBUTTONUP,
      WM_MBUTTONDBLCLK, WM_MBUTTONDOWN, WM_MBUTTONUP,
      WM_RBUTTONDBLCLK, WM_RBUTTONDOWN, WM_RBUTTONUP:
    begin
{$IFDEF CIL}
      with TWMMouse.Create(WinTMessage) do
{$ELSE}
      with TWMMouse(Message) do
{$ENDIF}
        begin
          SendStructMessage(Handle, EM_GETRECT, 0, R);
          if {(EditStyle <> esSimple) and}
            not PtInRect(Rect(R.Left, 0, R.Right, Height), Point(XPos, YPos)) and
            not MouseCapture
            then Exit;
        end;
    end;
  end;  
  inherited DefaultHandler(Message);

  if FUserTextChanged then
  begin
    Accept := False;
    FUserTextChanged := False;
    if IsMasked
      then BlankText := FormatMaskText(EditMask, '')
      else BlankText := '';
    if MRUList.DroppedDown and (Text = BlankText)then
      MRUListCloseUp(MRUList, Accept)
    else if MRUList.Active and Showing and not FDroppedDown and (Text <> BlankText) then
      MRUListDropDown(MRUList);
  end;
end;

procedure TDBAxisGridInplaceEdit.DoDBCSKeyPress(var Key: Char);
var
  CharMsg: Windows.TMsg;
  DBC: Boolean;
begin
  FCharKeyStr := Key;
  DBC := False;
  if  CharInSetEh(Key, LeadBytes) then
    if PeekMessage(CharMsg, Handle, WM_CHAR, WM_CHAR, PM_NOREMOVE) then
      if CharMsg.Message <> WM_Quit then
      begin
{$IFDEF CIL}
//        FCharKeyStr := FCharKeyStr + Char(CharMsg.wParam);
{$ELSE}
        FCharKeyStr := FCharKeyStr + Char(CharMsg.wParam);
{$ENDIF}
        DBC := True;
      end;
  DBCSKeyPress(FCharKeyStr);
  if (FCharKeyStr = '') then Key := #0;
  if DBC and (FCharKeyStr = '') then
    PeekMessage(CharMsg, Handle, WM_CHAR, WM_CHAR, PM_REMOVE);
end;

procedure TDBAxisGridInplaceEdit.DBCSKeyPress(var Key: String);
var
  AAxisBar: TAxisBarEh;
  CurPosition, Idx: Integer;
  FSearchText, AText: String;
  CanChange: Boolean;
  EditKeyValue: Variant;
  S: String;
  FilterStarted: Boolean;
  FDataList: TPopupDataGridEh;
  TextFound: Boolean;

  function IsSpecKey(const Key: String): Boolean;
  begin
    Result := (Length(Key) = 1) and
     not ( (Key[1] = #8) or (Key[1] >= #32));
  end;

begin
  FDataList := TPopupDataGridEh(Self.FDataList);
  if IsSpecKey(Key) then Exit;
  with Grid do AAxisBar := AxisBars[SelectedIndex];
  if (EditStyle in [esLookupDataList, esAltLookupDataList, esDataList, esAltDataList]) and
     Grid.CanEditModifyText and
     Grid.AllowedOperationUpdate and
     (AAxisBar.UsedLookupDataSet <> nil) then // lookUp or DataList
  begin
    if Key = #8 then
    begin
      if FListVisible and AAxisBar.DropDownBox.ListSourceAutoFilter then
        RefilterDropDownBoxListSource(Copy(Text, 1, SelStart));
      if AAxisBar.LimitTextToListValues then
        Key := '';
      Exit;
    end;
    CurPosition := SelStart;
    FSearchText := Copy(Text, 1, CurPosition) + Key;
    TextFound := AAxisBar.UsedLookupDataSet.Locate(
      AAxisBar.GetDropDownBoxListField, FSearchText, [loPartialKey]);
    if not TextFound and AAxisBar.CaseInsensitiveTextSearch then
      TextFound := AAxisBar.UsedLookupDataSet.Locate(
        AAxisBar.GetDropDownBoxListField, FSearchText,
        [loCaseInsensitive, loPartialKey]);
    if TextFound then
    begin
      Key := '';
      AText := AAxisBar.UsedLookupDataSet.FieldByName(AAxisBar.GetDropDownBoxListField).Text;
      if AAxisBar.GetBarType = ctDataList
        then EditKeyValue := AAxisBar.UsedLookupDataSet.FieldValues[AAxisBar.GetDropDownBoxListField]
        else EditKeyValue := AAxisBar.UsedLookupDataSet.FieldValues[AAxisBar.LookupParams.LookupKeyFieldNames];
      Grid.DataLink.Edit;
      CanChange := Grid.Datalink.Editing;
      if CanChange then
      begin
        FilterStarted := False;
        if FListVisible and AAxisBar.DropDownBox.ListSourceAutoFilter then
        begin
          StartDropDownBoxListSourceFilter;
          RefilterDropDownBoxListSource('');
          FilterStarted := True;
        end;
        Grid.Datalink.Modified;
        Text := AText;
        SelStart := Length(Text);
        SelLength := Length(FSearchText) - SelStart;

        Grid.FEditKeyValue := EditKeyValue;
        Grid.FEditText := Text;
        if Assigned(FDataList) then FDataList.KeyValue := Grid.FEditKeyValue;

        if FListVisible and AAxisBar.DropDownBox.ListSourceAutoFilter then
        begin
          S := Copy(Text, 1, SelStart);
          RefilterDropDownBoxListSource(S);
        end;
        if FilterStarted then
          StopDropDownBoxListSourceFilter;
      end;
    end else if not AAxisBar.LimitTextToListValues then
    begin
      Grid.DataLink.Edit;
      CanChange := Grid.Datalink.Editing;
      if CanChange then
      begin
        FilterStarted := False;
        if FListVisible and AAxisBar.DropDownBox.ListSourceAutoFilter then
        begin
          StartDropDownBoxListSourceFilter;
          RefilterDropDownBoxListSource('');
          FilterStarted := True;
        end;

        Grid.Datalink.Modified;
        Text := FSearchText;
        SelStart := Length(Text);
        SelLength := 0;

        Grid.FEditKeyValue := Null;
        Grid.FEditText := Text;
        if Assigned(FDataList) then FDataList.KeyValue := Grid.FEditKeyValue;

        if FListVisible and AAxisBar.DropDownBox.ListSourceAutoFilter then
        begin
          S := Copy(Text, 1, SelStart);
          RefilterDropDownBoxListSource(S);
        end;
        if FilterStarted then
          StopDropDownBoxListSourceFilter;
      end;
    end{ else
    begin
      Grid.FEditKeyValue := Null;
      if Assigned(FDataList) then
        FDataList.KeyValue := Grid.FEditKeyValue;
    end};
//    if AAxisBar.GetBarType <> ctDataList then
      Key := '';
  end
  else if (AxisBar.GetBarType in [ctPickList, ctKeyPickList]) and Grid.CanEditModifyText then // picklist or keypicklist
  begin
    if Key = #8 then
    begin
      if AxisBar.LimitTextToListValues or (AxisBar.GetBarType = ctKeyPickList) then
        Key := '';
      Exit;
    end;
    CurPosition := SelStart;
    FSearchText := Copy(Text, 1, CurPosition) + Key;
    AAxisBar := Grid.AxisBars[Grid.SelectedIndex];
    Idx := AAxisBar.LocatePickList(FSearchText, True);
    if (Idx <> -1) then
    begin
      Key := '';
      AText := AAxisBar.PickList[Idx];

      Grid.DataLink.Edit;
      CanChange := Grid.Datalink.Editing;
      if CanChange then Grid.Datalink.Modified;
      Text := AText;
      SelStart := Length(AText);
      SelLength := Length(FSearchText) - SelStart;

      Grid.FEditText := Text;
      if Assigned(FPickList) and (FPickList.Count > Idx) then
        FPickList.ItemIndex := Idx;
    end
    else if not AxisBar.LimitTextToListValues then
    begin
      Grid.DataLink.Edit;
      CanChange := Grid.Datalink.Editing;
      if CanChange then
      begin
        Grid.Datalink.Modified;
        Text := FSearchText;
        SelStart := Length(Text);
        SelLength := 0;

        Grid.FEditKeyValue := Null;
        Grid.FEditText := Text;
        if Assigned(FPickList) then FPickList.ItemIndex := -1;
        Key := '';
      end;
    end else
      Key := '';
  end;
end;

procedure TDBAxisGridInplaceEdit.KeyPress(var Key: Char);
begin
  if Assigned(AxisBar) and Assigned(AxisBar.Field) and (AxisBar.Field is TNumericField) then
    if CharInSetEh(Key, ['.', ',']) then
      Key := Copy(FormatSettings.DecimalSeparator, 1, 1)[1];
  DoDBCSKeyPress(Key);
  if (Key = #10) and not WordWrap and (GetShiftState = [ssCtrl])
    then Key := #0;
  inherited;
  if (Integer(Key) = VK_BACK) and MRUList.Active and Showing and
   not FDroppedDown and (Text = '')
  then
    MRUListDropDown(MRUList);
end;

procedure TDBAxisGridInplaceEdit.WMPaste(var Message: TMessage);
var
  ClipboardText: String;
  AAxisBar: TAxisBarEh;
  Idx: Integer;
  FSearchText, AText: String;
  CanChange, TextLocated, CanTryEdit: Boolean;
  EditKeyValue: Variant;
  NewSelStart: Integer;
  FDataList: TPopupDataGridEh;
  TextFound: Boolean;
begin
  FDataList := TPopupDataGridEh(Self.FDataList);
  if Grid.AllowedOperationUpdate and AxisBar.CanModify(False) then
    if ((AxisBar.GetBarType in [ctPickList, ctDataList]) and AxisBar.LimitTextToListValues)
      or
       (AxisBar.GetBarType in [ctKeyPickList, ctLookupField]) then
    begin
      if Clipboard.HasFormat(CF_TEXT)
        then ClipboardText := Clipboard.AsText
        else Exit;
      with Grid do AAxisBar := AxisBars[SelectedIndex];
      FSearchText := Copy(Text, 1, SelStart) + ClipboardText + Copy(Text, SelStart + SelLength + 1, MAXINT);
      CanTryEdit := False;
      TextLocated := False;
      AText := FSearchText;
      if (AxisBar.GetBarType in [ctDataList, ctLookupField]) and (AAxisBar.UsedLookupDataSet <> nil) then //lookup
      begin
        EditKeyValue := Null;

        TextFound := AAxisBar.UsedLookupDataSet.Locate(
          AAxisBar.GetDropDownBoxListField, FSearchText, [loPartialKey]);
        if not TextFound and AAxisBar.CaseInsensitiveTextSearch then
          TextFound := AAxisBar.UsedLookupDataSet.Locate(
            AAxisBar.GetDropDownBoxListField, FSearchText,
            [loCaseInsensitive, loPartialKey]);
        if TextFound then
        begin
          AText := AAxisBar.UsedLookupDataSet.FieldByName(AAxisBar.GetDropDownBoxListField).Text;
          if AAxisBar.GetBarType = ctDataList
            then EditKeyValue := AAxisBar.UsedLookupDataSet.FieldValues[AAxisBar.GetDropDownBoxListField]
            else EditKeyValue := AAxisBar.UsedLookupDataSet.FieldValues[AAxisBar.LookupParams.LookupKeyFieldNames];
          TextLocated := True;
          CanTryEdit := True;
        end
        else if not AAxisBar.LimitTextToListValues then
          CanTryEdit := True;

        if CanTryEdit then
        begin
          Grid.DataLink.Edit;
          CanChange := Grid.Datalink.Editing;
          if CanChange then
          begin
            Grid.Datalink.Modified;
            Text := AText;
            SelStart := Length(Text);
            if TextLocated
              then SelLength := Length(FSearchText) - SelStart
              else SelLength := 0;
            Grid.FEditKeyValue := EditKeyValue;
            Grid.FEditText := Text;
            if Assigned(FDataList) then FDataList.KeyValue := Grid.FEditKeyValue;
          end;
        end;
      end else //keypicklist
      begin
//        Idx := StringsLocate(AAxisBar.PickList, FSearchText, LocOpt);
        Idx := AAxisBar.LocatePickList(FSearchText, True);
        if (Idx <> -1) and Grid.CanEditModifyText then
        begin
          AText := AAxisBar.PickList[Idx];
          TextLocated := True;
          CanTryEdit := True;
        end
        else if not AAxisBar.LimitTextToListValues then
          CanTryEdit := True;

        if CanTryEdit then
        begin
          SelStart := Length(AText);
          if TextLocated
            then SelLength := Length(FSearchText) - SelStart
            else SelLength := 0;

          Grid.DataLink.Edit;
          CanChange := Grid.Datalink.Editing;
          if CanChange then Grid.Datalink.Modified;
          Text := AText;

          Grid.FEditText := Text;
          if Assigned(FPickList) then FPickList.ItemIndex := Idx;
        end;
      end;
    end else
    begin
      if EditCanModify and
          ( Clipboard.HasFormat(CF_TEXT) or
            Clipboard.HasFormat(CF_OEMTEXT) or
            Clipboard.HasFormat(CF_UNICODETEXT)
          )  then
      begin
        with Grid do AAxisBar := AxisBars[SelectedIndex];
        ClipboardText := Clipboard.AsText;
        AText := AAxisBar.GetAcceptableEditText(ClipboardText);
        if (MaxLength > 0) and (Length(Text) + Length(AText) - SelLength > MaxLength) then
          AText := Copy(AText, 1, MaxLength - Length(Text) + SelLength);
        FSearchText := Copy(Text, 1, SelStart) + AText + Copy(Text, SelStart + SelLength + 1, MAXINT);
        NewSelStart := Length(Copy(Text, 1, SelStart) + AText);
        Grid.DataLink.Edit;
        if Grid.Datalink.Editing then
        begin
          Grid.Datalink.Modified;
          Text := FSearchText;
          SelStart := NewSelStart;
          Grid.FEditText := Text;
          SendMessage(Handle, EM_SCROLLCARET, 0,0);
        end;
      end else
        inherited;
    end;
end;

procedure TDBAxisGridInplaceEdit.WMClear(var Message: TMessage);
begin
  if AxisBar.LimitTextToListValues then
  begin
   if SelLength = Length(Text)
    then inherited
    else //Skip;
  end else
    inherited;
end;

procedure TDBAxisGridInplaceEdit.WMCut(var Message: TMessage);
begin
  if AxisBar.LimitTextToListValues then
  begin
   if SelLength = Length(Text)
    then inherited
    else //Skip;
  end else
    inherited;
end;

procedure TDBAxisGridInplaceEdit.SetWordWrap(const Value: Boolean);
begin
  if Value <> FWordWrap then
  begin
    FWordWrap := Value;
    RecreateWndHandle;
  end;
end;

function TDBAxisGridInplaceEdit.GetGrid: TCustomDBAxisGridEh;
begin
  Result := TCustomDBAxisGridEh(inherited Grid);
end;

function TDBAxisGridInplaceEdit.GetAxisBar: TAxisBarEh;
begin
  if (Grid <> nil) and (Grid.AxisBars <> nil) and
   (Grid.SelectedIndex >= 0) and (Grid.SelectedIndex < Grid.AxisBars.Count)
    then Result := Grid.AxisBars[Grid.SelectedIndex]
    else Result := nil;
end;

procedure TDBAxisGridInplaceEdit.UpdateEditButtonControlList;
var
  i: Integer;
  AButtonRect: TRect;
begin
  FButtonsBox.BeginLayout;

  FButtonsBox.ButtonsCount := AxisBar.EditButtons.Count + 1;
  FButtonsBox.Flat := Grid.Flat;
  FButtonsBox.MaxButtonHeight := Height;

  FButtonsBox.BtnCtlList[0].EditButton := AxisBar.EditButton;
  for i := 1 to AxisBar.EditButtons.Count do
    FButtonsBox.BtnCtlList[i].EditButton := AxisBar.EditButtons[i - 1];
  FButtonsBox.EndLayout;

  if UseRightToLeftAlignment
    then AButtonRect := Rect(0, 0, FButtonsBox.ButtonsWidth, Height)
    else AButtonRect := Rect(Width-FButtonsBox.ButtonsWidth, 0, Width, Height);

  if FButtonsBox.ButtonsWidth > 0 then
  begin
    FButtonsBox.SetBounds(AButtonRect.Left, AButtonRect.Top, AButtonRect.Right-AButtonRect.Left, AButtonRect.Bottom-AButtonRect.Top);
    FButtonsBox.Visible := True;
    ShowWindow(FButtonsBox.Handle, SW_SHOWNORMAL);
  end else
  begin
    FButtonsBox.Visible := False;
    ShowWindow(FButtonsBox.Handle, SW_HIDE);
  end;
end;

procedure TDBAxisGridInplaceEdit.UpdateEditButtonControlsState;
var
  i: Integer;
  DefaultActionSet: Boolean;
  AEditButton: TAxisBarMainEditButtonEh;
begin
  FButtonsBox.BorderActive := True; { TODO : Check BorderActive }
  FButtonsBox.UpdateEditButtonControlsState;

  DefaultActionSet := False;
  if AxisBar.EditButton.Visible then
  begin
    TAxisBarMainEditButtonEhCrack(AxisBar.EditButton).FParentDefinedDefaultAction :=
      (@AxisBar.OnEditButtonClick = nil) and
      (@AxisBar.OnEditButtonDown = nil );
    DefaultActionSet := TAxisBarMainEditButtonEh(AxisBar.EditButton).FParentDefinedDefaultAction
  end else
    TAxisBarMainEditButtonEh(AxisBar.EditButton).FParentDefinedDefaultAction := False;

  for i := 0 to AxisBar.EditButtons.Count-1 do
  begin
    AEditButton := TAxisBarMainEditButtonEh(AxisBar.EditButtons[i]);
    if not DefaultActionSet then
    begin
      AEditButton.FParentDefinedDefaultAction :=
        (@AEditButton.OnClick = nil) and
        (@AEditButton.OnDown = nil );
      DefaultActionSet := AEditButton.FParentDefinedDefaultAction;
    end else
      AEditButton.FParentDefinedDefaultAction := False;
  end;
end;

procedure TDBAxisGridInplaceEdit.CreateEditButtonControl(
  var EditButtonControl: TEditButtonControlEh);
begin
  EditButtonControl := TEditButtonControlEh.Create(Self);
  with EditButtonControl do
  begin
    ControlStyle := ControlStyle + [csReplicatable];
    Width := 10;
    Height := 17;
    Visible := True;
    Transparent := False;
    Parent := Self;
  end;
end;

procedure TDBAxisGridInplaceEdit.EditButtonClick(Sender: TObject);
var
  Handled: Boolean;
  i: Integer;
  AEditButton: TEditButtonEh;
begin
  Handled := False;
  if (EditStyle in [esEllipsis, esDropDown, esAltDropDown]) and
    (Sender = FButtonsBox.BtnCtlList[0].EditButtonControl)
  then
    Grid.EditButtonClick;

  if Sender = FButtonsBox.BtnCtlList[0].EditButtonControl then
  begin
    if Assigned(AxisBar.OnEditButtonClick) then
      AxisBar.OnEditButtonClick(Sender, Handled);

    if not Handled and
       AxisBar.EditButton.DefaultAction
    then
      Grid.EditButtonDefaultAction(Self, AxisBar.EditButton,
        FButtonsBox.BtnCtlList[0].EditButtonControl, False, Handled);

  end else if (Sender is TEditButtonControlEh) then
    for i := 1 to Length(FButtonsBox.BtnCtlList) - 1 do
      if (Sender = FButtonsBox.BtnCtlList[i].EditButtonControl) then
      begin
        AEditButton := AxisBar.EditButtons[i - 1];
        AEditButton.Click(Sender, Handled);
        if not Handled and
           AEditButton.DefaultAction
        then
          Grid.EditButtonDefaultAction(Self, AEditButton,
            FButtonsBox.BtnCtlList[i].EditButtonControl, False, Handled);
      end;

  if not Handled and FDroppedDown and not FNoClickCloseUp then
    if (Sender = FButtonsBox.BtnCtlList[0].EditButtonControl) then
      CloseUp(False)
    else if (FirstVisibleButtonIndex >= 0) and
            (Sender = FButtonsBox.BtnCtlList[FirstVisibleButtonIndex].EditButtonControl) then
      CloseUp(False);
  FNoClickCloseUp := False;
end;

procedure TDBAxisGridInplaceEdit.EditButtonDown(Sender: TObject;
  TopButton: Boolean; var AutoRepeat: Boolean; var Handled: Boolean);
var
  i: Integer;
  p: TPoint;
  EditButton: TEditButtonEh;
begin
  SetFocus;
  Handled := False;
{  if PeekMessage(Msg, Handle, CM_IGNOREEDITDOWN, CM_IGNOREEDITDOWN, PM_NOREMOVE) then
//    if Msg.wParam = Integer(Sender) then
    if Msg.wParam = Integer(TEditButtonControlEh(Sender).Tag) then
    begin
      PeekMessage(Msg, Handle, CM_IGNOREEDITDOWN, CM_IGNOREEDITDOWN, PM_REMOVE);
      Exit;
    end;}
  if (Sender = FButtonsBox.BtnCtlList[0].EditButtonControl) then
  begin
    if Assigned(AxisBar.OnEditButtonDown) then
      AxisBar.OnEditButtonDown(Sender, TopButton, AutoRepeat, Handled);

    if not Handled then
      CheckEditButtonDownForDropDownForm(nil, FButtonsBox.BtnCtlList[0].EditButtonControl, Handled);

    if not Handled  and
       AxisBar.EditButton.DefaultAction
    then
      ButtonDown(not TopButton, Handled);

    if not Handled and
       AxisBar.EditButton.DefaultAction
    then
      Grid.EditButtonDefaultAction(Self, AxisBar.EditButton,
        FButtonsBox.BtnCtlList[0].EditButtonControl, True, Handled);
  end
  else if (Sender is TEditButtonControlEh) then
    for i := 1 to Length(FButtonsBox.BtnCtlList) - 1 do
      if (Sender = FButtonsBox.BtnCtlList[i].EditButtonControl) then
      begin
        EditButton := AxisBar.EditButtons[i - 1];
        if Assigned(EditButton.OnDown) then
          EditButton.OnDown(Sender, TopButton, AutoRepeat, Handled);
        if not Handled then
          CheckEditButtonDownForDropDownForm(EditButton, FButtonsBox.BtnCtlList[i].EditButtonControl, Handled);
        if not Handled then
          if Assigned(EditButton.DropdownMenu) then
          begin
            P := TControl(Sender).ClientToScreen(Point(0, TControl(Sender).Height));
            if EditButton.DropdownMenu.Alignment = paRight then
              Inc(P.X, TControl(Sender).Width);
            EditButton.DropdownMenu.Popup(p.X, p.y);
//            PostMessage(Handle, CM_IGNOREEDITDOWN, Integer(Sender), 0);
//            PostMessage(Handle, CM_IGNOREEDITDOWN, Integer(TEditButtonControlEh(Sender).Tag), 0);
            KillMouseUp(TControl(Sender));
            TControl(Sender).Perform(WM_LBUTTONUP, 0, 0);
          end else if FirstVisibleButtonIndex >= i then
            ButtonDown(not TopButton, Handled);
      end;
end;

procedure TDBAxisGridInplaceEdit.CheckEditButtonDownForDropDownForm(
  EditButton: TEditButtonEh; EditButtonControl: TEditButtonControlEh;
  var Handled: Boolean);
var
  DDParams: TDynVarsEh;
  SysParams: TAxisGridDropDownFormSysParams;
  IntDropDownForm: IDropDownFormEh;
//  DataSetWasInEditState: Boolean;
  ADropDownForm: TCustomForm;
  ADropDownFormClass: TCustomDropDownFormClassEh;
  TheMsg: Windows.TMsg;
  ADataSet: TDataSet;
  i: Integer;
  Fields: TList;
  DDFormCallParams: TDropDownFormCallParamsEh;
  AFreeFormOnClose: Boolean;
//  GlobalDropDownForm: TCustomForm;
begin
  ADropDownForm := nil;
//  ADropDownFormClass := nil;
  if EditButtonPressed then Exit;
{  if  FFixedDownButton = 0 then
  begin
    FFixedDownButton := -1;
    Exit;
  end; }
  if (FFixedDownButton = 0) and PeekMessage(TheMsg, Handle, WM_USER, WM_USER, PM_NOREMOVE) then
  begin
    if (TheMsg.wParam = WPARAM(Handle)) and (TheMsg.lParam = LPARAM(AxisBar)) and (EditButton = nil) then
    begin
      Handled := True;
      Exit;
    end;
    if (TheMsg.wParam = WPARAM(Handle)) and (TheMsg.lParam = LPARAM(EditButton)) then
    begin
      Handled := True;
      Exit;
    end;
  end;
  if EditButton <> nil then
    DDFormCallParams := EditButton.DropDownFormParams
  else if AxisBar <> nil then
    DDFormCallParams := AxisBar.DropDownFormParams
  else
    DDFormCallParams := nil;

  AFreeFormOnClose := False;
  if DDFormCallParams <> nil then
    if DDFormCallParams.DropDownForm <> nil then
      ADropDownForm := DDFormCallParams.DropDownForm
    else if DDFormCallParams.DropDownFormClassName <> '' then
    begin
      ADropDownFormClass := TCustomDropDownFormClassEh(GetClass(DDFormCallParams.DropDownFormClassName));
      if ADropDownFormClass <> nil then
      begin
        ADropDownForm := ADropDownFormClass.GetGlobalRef;
        if ADropDownForm = nil then
        begin
          ADropDownForm := ADropDownFormClass.Create(Self);
          if ADropDownFormClass.GetGlobalRef = nil then
            AFreeFormOnClose := True;
        end;
      end else
        raise Exception.Create('Class ''' + DDFormCallParams.DropDownFormClassName + ''' is not registered');
    end;

  DDParams := TDynVarsEh.Create(Self);
  SysParams := TAxisGridDropDownFormSysParams.Create;
  ADataSet := Grid.DataLink.DataSet;

  SysParams.FreeFormOnClose := AFreeFormOnClose;
  SysParams.FAxisBar := AxisBar;
  SysParams.FEditButton := EditButton;
//  SysParams.HostIsReadOnly := ReadOnly;

  if DDFormCallParams.PassFieldNames <> '' then
  begin
    Fields := TList.Create;
    try
      ADataSet.GetFieldList(Fields, DDFormCallParams.PassFieldNames);
      for I := 0 to Fields.Count - 1 do
        DDParams.CreateDynVar(TField(Fields[i]).FieldName, TField(Fields[i]).Value)
    finally
      Fields.Free;
    end;
  end else if DDFormCallParams.PassParams = pspFieldValueEh then
    DDParams.CreateDynVar(AxisBar.FieldName, Text)
  else if DDFormCallParams.PassParams = pspRecordValuesEh then
  begin
    ADataSet := Grid.DataLink.DataSet;
    for i := 0 to ADataSet.Fields.Count-1 do
      DDParams.CreateDynVar(ADataSet.Fields[i].FieldName, ADataSet.Fields[i].Value);
  end;

  if Supports(ADropDownForm, IDropDownFormEh, IntDropDownForm) then
    IntDropDownForm.ReadOnly := False;

  if ADropDownForm <> nil then
    if (AxisBar.Field <> nil) and AxisBar.Field.ReadOnly and (IntDropDownForm <> nil) then
      IntDropDownForm.ReadOnly := True;

//  ADropDownForm := DDFormCallParams.DropDownForm;
  if Assigned(AxisBar.OnOpenDropDownForm) then
    AxisBar.OnOpenDropDownForm(Grid, AxisBar, nil, ADropDownForm, DDParams);

  if Supports(ADropDownForm, IDropDownFormEh, IntDropDownForm) then
  begin

    if DDFormCallParams.SaveFormSize then
    begin
      DDFormCallParams.OldFormWidth := ADropDownForm.Width;
      if DDFormCallParams.FormWidth > 0 then
      begin
        ADropDownForm.Width := DDFormCallParams.FormWidth;
      end;
      DDFormCallParams.OldFormHeight := ADropDownForm.Height;
      if DDFormCallParams.FormHeight > 0 then
      begin
        ADropDownForm.Height := DDFormCallParams.FormHeight;
      end;
    end;

    EditButtonControl.AlwaysDown := True;
    FFixedDownButton := 0;

    IntDropDownForm.ExecuteNomodal(ClientToScreenRect(Self), nil,
      DDFormCallParams.Align, DDParams, SysParams, DropDownFormCallbackProc);
    Handled := True;
  end else
  begin
    DDParams.Free;
    SysParams.Free;
  end;
end;

procedure TDBAxisGridInplaceEdit.DropDownFormCallbackProc(DropDownForm: TCustomForm;
  Accept: Boolean; DynParams: TDynVarsEh; SysParams: TDropDownFormSysParams);
var
  ADataSet: TDataSet;
  Fields: TList;
  I: Integer;
  DataSetWasInEditState: Boolean;
  ASysParams: TAxisGridDropDownFormSysParams;
  DDFormCallParams: TDropDownFormCallParamsEh;
begin
//  EditButtonPressed := False;
  for i := 0 to Length(FButtonsBox.BtnCtlList) - 1 do
    FButtonsBox.BtnCtlList[i].EditButtonControl.AlwaysDown := False;

//  DropDownForm.FCallbackProc := nil;
  ASysParams := TAxisGridDropDownFormSysParams(SysParams);
  if ASysParams.FEditButton <> nil then
    DDFormCallParams := ASysParams.FEditButton.DropDownFormParams
  else if AxisBar <> nil then
    DDFormCallParams := ASysParams.FAxisBar.DropDownFormParams
  else
    DDFormCallParams := nil;

  try
  try

  if Accept then
  begin
    if (DDFormCallParams.PassParams in [pspFieldValueEh, pspRecordValuesEh]) or
       (DDFormCallParams.AssignBackFieldNames <> '') then
    begin
      ADataSet := Grid.DataLink.DataSet;
      DataSetWasInEditState := False;
      if ADataSet <> nil then
      begin
        DataSetWasInEditState := (ADataSet.State in [dsEdit, dsInsert]);
        if not DataSetWasInEditState then
          ADataSet.Edit;
      end;
      if DDFormCallParams.AssignBackFieldNames <> '' then
      begin
        Fields := TList.Create;
        try
          ADataSet.GetFieldList(Fields, DDFormCallParams.AssignBackFieldNames);
          for I := 0 to Fields.Count - 1 do
            TField(Fields[I]).Value := DynParams[TField(Fields[I]).FieldName].Value;
        finally
          Fields.Free;
        end;
      end else
        AxisBar.Field.AsString := DynParams.Items[0].AsString;

      if (ADataSet <> nil) and not DataSetWasInEditState then
        ADataSet.Post;
    end;

  end;

  DropDownForm.Hide;
  if DDFormCallParams.SaveFormSize then
  begin
    DDFormCallParams.FormWidth := DropDownForm.Width;
    if DDFormCallParams.OldFormWidth > 0 then
      DropDownForm.Width := DDFormCallParams.OldFormWidth;
    DDFormCallParams.FormHeight := DropDownForm.Height;
    if DDFormCallParams.OldFormHeight > 0 then
      DropDownForm.Height := DDFormCallParams.OldFormHeight;
  end;

  if Assigned(AxisBar.OnCloseDropDownForm) then
    AxisBar.OnCloseDropDownForm(Grid, AxisBar, nil, Accept, DropDownForm, DynParams);

  if ASysParams.FEditButton <> nil
    then PostMessage(Handle, WM_USER, WPARAM(Handle), LPARAM(ASysParams.FEditButton))
    else PostMessage(Handle, WM_USER, WPARAM(Handle), LPARAM(AxisBar));

  finally
    DynParams.Free;
    SysParams.Free;
  end;
  except
    TCustomDropDownFormEh(DropDownForm).KeepFormVisible := True;
    Application.HandleException(Self);
    TCustomDropDownFormEh(DropDownForm).KeepFormVisible := False;
  end;

//  if TDropDownFormSysParams(SysParams).FreeFormOnClose then
//    DropDownForm.Free;
end;

procedure TDBAxisGridInplaceEdit.ShowDropDownForm(EditControl: TControl;
  Button: TEditButtonEh; var DropDownForm: TCustomForm; DynParams: TDynVarsEh);
begin
  if Assigned(AxisBar.OnOpenDropDownForm) then
    AxisBar.OnOpenDropDownForm(Grid, AxisBar, Button, DropDownForm, DynParams);
end;

procedure TDBAxisGridInplaceEdit.DropDownFormCloseProc(EditControl: TControl;
  Button: TEditButtonEh; Accept: Boolean; DropDownForm: TCustomForm;
  DynParams: TDynVarsEh);
var
  I: Integer;
begin
  for i := 0 to Length(FButtonsBox.BtnCtlList) - 1 do
    FButtonsBox.BtnCtlList[i].EditButtonControl.AlwaysDown := False;
  if Assigned(AxisBar.OnCloseDropDownForm) then
    AxisBar.OnCloseDropDownForm(Grid, AxisBar, Button, Accept, DropDownForm, DynParams);
end;

procedure TDBAxisGridInplaceEdit.SetVarValue(const VarValue: Variant);
begin
  Text := VarToStr(VarValue);
  AxisBar.SetValueAsText(Text);
end;

procedure TDBAxisGridInplaceEdit.GetVarValue(var VarValue: Variant);
begin
  VarValue := Text;
end;

procedure TDBAxisGridInplaceEdit.GetDefaultDropDownForm(
  var DropDownForm: TCustomForm; var FreeFormOnClose: Boolean);
begin
  if AxisBar.GetBarType <> ctGraphicData then
  begin
    DropDownForm := DefaultDBEditEhDropDownFormClass.GetGlobalRef;
    if DropDownForm <> nil then
      FreeFormOnClose := False;
  end else
    DropDownForm := nil;
end;

procedure TDBAxisGridInplaceEdit.EditButtonMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if Sender = FButtonsBox.BtnCtlList[0].EditButtonControl then
    TraceMouseMoveForPopupListbox(Sender, Shift, X, Y);
end;

function TDBAxisGridInplaceEdit.TraceMouseMoveForPopupListbox(Sender: TObject;
  Shift: TShiftState; X, Y: Integer): Boolean;
var
  ListPos: TPoint;
  MousePos: Windows.TSmallPoint;
  IsPtInRect: Boolean;
  FDataList: TPopupDataGridEh;
begin
  FDataList := TPopupDataGridEh(Self.FDataList);
  Result := False;
  if FListVisible and (GetCaptureControl = Sender) then
  begin
    ListPos := FActiveList.ScreenToClient(TControl(Sender).ClientToScreen(Point(X, Y)));
    if FActiveList = FDataList
      then IsPtInRect := PtInRect(FDataList.DataRect, ListPos)
      else IsPtInRect := PtInRect(FActiveList.ClientRect, ListPos);
    if IsPtInRect then
    begin
      TControl(Sender).Perform(WM_CANCELMODE, 0, 0);
      MousePos := PointToSmallPoint(ListPos);
      SendStructMessage(FActiveList.Handle, WM_LBUTTONDOWN, 0, MousePos);
      Result := True;
    end;
  end;
end;

procedure TDBAxisGridInplaceEdit.EditButtonMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  DoClick: Boolean;
begin
  DoClick := (X >= 0) and (X < TControl(Sender).ClientWidth) and
    (Y >= 0) and (Y <= TControl(Sender).ClientHeight);
  if not DoClick then
    FNoClickCloseUp := False;
end;

procedure TDBAxisGridInplaceEdit.ButtonDown(IsDownButton: Boolean;
  var Handled: Boolean);
begin
  if EditStyle in [esUpDown, esAltUpDown] then
  begin
    if IsDownButton
      then UpDownClick(nil, btPrev)
      else UpDownClick(nil, btNext);
    Handled := True;
  end else
  begin
    if not FDroppedDown then
    begin
      DropDown;
      if FDroppedDown then
        Handled := True;
      FNoClickCloseUp := True;
    end;
  end;
end;

function TDBAxisGridInplaceEdit.DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  if FListVisible
    then Result := True
    else Result := inherited DoMouseWheelDown(Shift, MousePos);
end;

function TDBAxisGridInplaceEdit.DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  if FListVisible
    then Result := True
    else Result := inherited DoMouseWheelUp(Shift, MousePos);
end;

procedure TDBAxisGridInplaceEdit.ListColumnMoved(Sender: TObject; FromIndex,
  ToIndex: Longint);
begin
  FListColumnMothed := True;
end;

function TDBAxisGridInplaceEdit.GetEditButtonByShortCut(ShortCut: TShortCut): TEditButtonEh;
var
  i: Integer;
begin
  Result := nil;
  if AxisBar <> nil then
    for i := 0 to AxisBar.EditButtons.Count - 1 do
      if (ShortCut = AxisBar.EditButtons[i].ShortCut) then
      begin
        Result := AxisBar.EditButtons[i];
        Exit;
      end;
end;

function TDBAxisGridInplaceEdit.CreateMRUListControl: TWinControl;
begin
  Result := TMRUListboxEh.Create(Self);
  Result.Visible := False;
  {$IFDEF FPC}
  {$ELSE}
  TMRUListboxEh(Result).Ctl3D := False;
  TMRUListboxEh(Result).ParentCtl3D := False;
  {$ENDIF}
  TMRUListboxEh(Result).Sorted := True;
  Result.Parent := Self; // Already set parent in TPopupListboxEh.CreateWnd
  TMRUListboxEh(Result).OnMouseUp := MRUListControlMouseUp;
end;

procedure TDBAxisGridInplaceEdit.FilterMRUItem(AText: String; var Accept: Boolean);
begin
  if MRUList.CaseSensitive
    then Accept := (NlsCompareStr(Copy(AText, 1, Length(Text)), Text) = 0)
    else Accept := (NlsCompareText(Copy(AText, 1, Length(Text)), Text) = 0);
  if Assigned(MRUList.OnFilterItem) then
    MRUList.OnFilterItem(AxisBar, Accept);
end;

function TDBAxisGridInplaceEdit.GetMRUListControl: TWinControl;
begin
  if not Assigned(FMRUListControl) then
    FMRUListControl := CreateMRUListControl;
  Result := FMRUListControl;
end;

procedure TDBAxisGridInplaceEdit.MRUListCloseUp(Sender: TObject; Accept: Boolean);
begin
  if MRUList.DroppedDown then
  begin
    if GetCapture <> 0 then SendMessage(GetCapture, WM_CANCELMODE, 0, 0);
    SetWindowPos(MRUListControl.Handle, 0, 0, 0, 0, 0, SWP_NOZORDER or
      SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_HIDEWINDOW);
    MRUListControl.Visible := False;
{    if TPopupListboxEh(MRUListControl).SizeGripResized then
    begin
      MRUList.Rows := TPopupListboxEh(MRUListControl).RowCount;
      MRUList.Width := TPopupListboxEh(MRUListControl).Width;
    end;}
    if (GetFocus = MRUListControl.Handle) then
      SetFocus;
    MRUList.DroppedDown := False;
    if Accept and not ReadOnly and Grid.DataLink.Edit then
    begin
      with TPopupListboxEh(MRUListControl) do
       if ItemIndex >= 0 then
       begin
         Self.Text := Items[ItemIndex];
         Grid.FEditText := Self.Text;
       end;
      if Focused then SelectAll;
      //////Modified := True;
    end;
  end;
end;

procedure TDBAxisGridInplaceEdit.MRUListControlResized(Sender: TObject);
begin
  if MRUList.DroppedDown then
  begin
    MRUList.Rows := TPopupListboxEh(MRUListControl).RowCount;
    MRUList.Width := TPopupListboxEh(MRUListControl).Width;
  end;
end;

procedure TDBAxisGridInplaceEdit.MRUListControlMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
    MRUListCloseUp(MRUList, PtInRect(MRUListControl.ClientRect, Point(X, Y)));
end;

procedure TDBAxisGridInplaceEdit.MRUListDropDown(Sender: TObject);
{  procedure FilterMRUItems(ss: TStrings; ds: TStrings);
  var
    i: Integer;
    Accept: Boolean;
  begin
    ds.BeginUpdate;
    try
      ds.Clear;
      for i := 0 to ss.Count-1 do
      begin
        Accept := False;
        FilterMRUItem(ss[i], Accept);
        if Accept then ds.Add(ss[i]);
      end;
    finally
      ds.EndUpdate;
    end;
  end;
}
var
  P: TPoint;
  OldSizeGripResized: Boolean;
  EditRect: TRect;
  Accept: Boolean;
begin
  with TPopupListboxEh(MRUListControl) do
  begin
    OldSizeGripResized := TPopupListboxEh(MRUListControl).SizeGripResized;
//    FilterMRUItems(MRUList.Items, Items);
    if not MRUList.FilterItemsTo(Items, Text) then
      MRUList.CloseUp(False);
    if Items.Count < MRUList.Rows
      then RowCount := Items.Count
      else RowCount := MRUList.Rows;
    if MRUList.DroppedDown then
    begin
      SendStructMessage(Self.Handle, EM_GETRECT, 0, EditRect);
      EditRect.TopLeft := Self.ClientToScreen(EditRect.TopLeft);
      EditRect.BottomRight := Self.ClientToScreen(EditRect.BottomRight);
      P := AlignDropDownWindowRect(EditRect, MRUListControl, daLeft);
      SetWindowPos(MRUListControl.Handle, HWND_TOP {MOST}, P.X, P.Y, 0, 0,
        SWP_NOSIZE or SWP_NOACTIVATE or SWP_SHOWWINDOW);
      TPopupListboxEh(MRUListControl).SizeGripResized := OldSizeGripResized;
    end;
    if (Items.Count <= 0) and MRUList.DroppedDown then
    begin
      Accept := False;
      MRUListCloseUp(MRUList, Accept);
    end
    else if not MRUList.DroppedDown and (Items.Count > 0) then
    begin
      Color := Self.Color;
      Font := Self.Font;
      ItemHeight := GetTextHeight;
      ItemIndex := -1;
      //if (Width < Self.Width) then Width := Self.Width;
      if Items.Count < RowCount then RowCount := Items.Count;
      SendStructMessage(Self.Handle, EM_GETRECT, 0, EditRect);
      EditRect.TopLeft := Self.ClientToScreen(EditRect.TopLeft);
      EditRect.BottomRight := Self.ClientToScreen(EditRect.BottomRight);
      if (MRUList.Width > 0) and (MRUList.Width > EditRect.Right-EditRect.Left)
        then Width := MRUList.Width
        else Width := EditRect.Right-EditRect.Left;
      P := AlignDropDownWindowRect(EditRect, MRUListControl, daLeft);
      SetWindowPos(MRUListControl.Handle, HWND_TOP {MOST}, P.X, P.Y, 0, 0,
        SWP_NOSIZE or SWP_NOACTIVATE or SWP_SHOWWINDOW);
      MRUListControl.Visible := True; //commment for Tab key
//      TPopupListboxEh(MRUListControl).SizeGrip.Visible := True;
//      TMRUListboxEh(MRUListControl).ScrollBar.Visible := True;
      MRUList.DroppedDown := True;
      TPopupListboxEh(MRUListControl).SizeGripResized := False;
//      TPopupListboxEh(MRUListControl).SizeGrip.OnParentResized := MRUListControlResized;
    end;
  end;
end;

procedure TDBAxisGridInplaceEdit.UserChange;
begin
  FUserTextChanged := True;
  UpdateImageIndex;
end;

procedure TDBAxisGridInplaceEdit.UpdateImageIndex;
var
  NewImageIndex: Integer;
begin
  NewImageIndex := FImageIndex;
  if Assigned(AxisBar) and Assigned(AxisBar.ImageList) then
  begin
    if AxisBar.PickList.Count > 0 then
      NewImageIndex := AxisBar.PickList.IndexOf(EditText)
    else if Assigned(AxisBar.Field) and IsFieldTypeNumeric(AxisBar.Field.DataType) then
      NewImageIndex := SafeGetFieldAsInteger(AxisBar.Field, -1);
    if NewImageIndex = -1 then
      NewImageIndex := AxisBar.NotInKeyListIndex;
  end;
  if NewImageIndex <> FImageIndex then
  begin
    FImageIndex := NewImageIndex;
    Invalidate;
  end;
end;

function TDBAxisGridInplaceEdit.GetPopupCalculator: TWinControl;
begin
  if FPopupCalculator = nil then
  begin
    FPopupCalculator := TPopupCalculatorEh.Create(Self);
    FPopupCalculator.Visible := False;
//    FPopupCalculator.Parent := Self;
    FPopupCalculator.ParentWindow := GetDesktopWindow;
    if HandleAllocated then
      FPopupCalculator.HandleNeeded;
  end;
  Result := FPopupCalculator;
end;

function TDBAxisGridInplaceEdit.CanDropCalculator: Boolean;
begin
  Result := (EditStyle in [esDropDown, esAltDropDown] ) and Assigned(AxisBar)
    and Assigned(AxisBar.Field) and (AxisBar.Field is TNumericField);
end;

procedure TDBAxisGridInplaceEdit.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FDataList) then
  begin
    FDataList := nil;
    if not (csDestroying in ComponentState) then
      EditStyle := esSimple;
  end;
end;

procedure TDBAxisGridInplaceEdit.DrawEditImage(DC: HDC);

  function ImageRect: TRect;
  begin
    if (Grid.FIntMemTable <> nil) and (AxisBar = Grid.VisibleAxisBars[0]) and
      Grid.FIntMemTable.MemTableIsTreeList
    then
      Result := Rect(Grid.GetCellTreeElmentsAreaWidth+2, 0,
        Grid.GetCellTreeElmentsAreaWidth+AxisBar.ImageList.Width+2, Height)
    else
      Result := Rect(2, 0, AxisBar.ImageList.Width+2, Height);
    if Grid.UseRightToLeftAlignment then
      OffsetRect(Result, ClientWidth - AxisBar.ImageList.Width - 2, 0);
  end;

var
  ImRect: TRect;
begin
  with AxisBar.ImageList do
  begin
    if not Visible or (AxisBar.ImageList = nil) or (FImageIndex < 0) then Exit;
    ImRect := ImageRect;
//    InflateRect(ImRect, -2, -1);
    DrawImage(DC, ImRect, AxisBar.ImageList, FImageIndex, False);
  end;
end;

procedure TDBAxisGridInplaceEdit.Invalidate;
begin
  inherited Invalidate;
end;

function TDBAxisGridInplaceEdit.FirstVisibleButtonIndex: Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to Length(FButtonsBox.BtnCtlList) - 1 do
  begin
    if FButtonsBox.BtnCtlList[i].EditButtonControl.Visible then
    begin
      Result := i;
      Exit;
    end;
  end;
end;

procedure TDBAxisGridInplaceEdit.RefilterDropDownBoxListSource(const FilterText: String);
var
  ListDataSet: TDataSet;
  ListField: String;
  FDataList: TPopupDataGridEh;
begin
  FDataList := TPopupDataGridEh(Self.FDataList);

  if (AxisBar.DropDownBox.ListSource <> nil) and (AxisBar.DropDownBox.ListSource.DataSet <> nil)
    then ListDataSet := AxisBar.DropDownBox.ListSource.DataSet
    else ListDataSet := nil;

  if (FDataList <> nil) and (FDataList.ListFields.Count > 0) and
     (FDataList.ListFields[FDataList.ListFieldIndex] <> nil)
  then
    ListField := TField(FDataList.ListFields[FDataList.ListFieldIndex]).FieldName
  else
    ListField := '';

  AxisBar.DropDownBoxApplyTextFilter(ListDataSet, ListField,
      AxisBar.DropDownBox.ListSourceAutoFilterType, FilterText);

  if AxisBar.DropDownBox.ListSourceAutoFilterType = lsftContainsEh
    then FDataList.ResetHighlightSubstr(FilterText)
    else FDataList.ResetHighlightSubstr('');
end;

procedure TDBAxisGridInplaceEdit.StartDropDownBoxListSourceFilter;
begin
  if (AxisBar.DropDownBox.ListSource <> nil) and (AxisBar.DropDownBox.ListSource.DataSet <> nil) then
    AxisBar.DropDownBox.ListSource.DataSet.DisableControls;
end;

procedure TDBAxisGridInplaceEdit.StopDropDownBoxListSourceFilter;
begin
  if (AxisBar.DropDownBox.ListSource <> nil) and (AxisBar.DropDownBox.ListSource.DataSet <> nil) then
    AxisBar.DropDownBox.ListSource.DataSet.EnableControls;
end;

function TDBAxisGridInplaceEdit.GetEditButtonPressed: Boolean;
begin
  Result := FButtonsBox.BtnCtlList[0].EditButtonControl.AlwaysDown;
end;

procedure TDBAxisGridInplaceEdit.SetEditButtonPressed(const Value: Boolean);
begin
  if Length(FButtonsBox.BtnCtlList) > 0 then
    FButtonsBox.BtnCtlList[0].EditButtonControl.AlwaysDown := Value;
end;

procedure TDBAxisGridInplaceEdit.RecreateWndHandle;
begin
  {$IFDEF FPC}
  RecreateWnd(Self);
  {$ELSE}
  RecreateWnd;
  {$ENDIF}
end;

{ TAxisGridDataLinkEh }

constructor TAxisGridDataLinkEh.Create(AGrid: TCustomDBAxisGridEh);
begin
  inherited Create;
  FGrid := AGrid;
end;

destructor TAxisGridDataLinkEh.Destroy;
begin
  ClearMapping;
  inherited Destroy;
end;

function TAxisGridDataLinkEh.GetDefaultFields: Boolean;
var
  I: Integer;
begin
  Result := True;
  if DataSet <> nil then Result := DataSet.DefaultFields;
  if Result and SparseMap then
    for I := 0 to FFieldCount - 1 do
      if FFieldMap[I] < 0 then
      begin
        Result := False;
        Exit;
      end;
end;

function TAxisGridDataLinkEh.GetFields(I: Integer): TField;
begin
  if (0 <= I) and (I < FFieldCount) and (FFieldMap[I] >= 0)
    then Result := DataSet.Fields[FFieldMap[I]]
    else Result := nil;
end;

function TAxisGridDataLinkEh.AddMapping(const FieldName: string): Boolean;
var
  Field: TField;
  NewSize: Integer;
begin
  Result := True;
  {$IFDEF FPC}
  if FFieldCount >= MaxMapSize then RaiseGridError('STooManyColumns');
  {$ELSE}
  if FFieldCount >= MaxMapSize then RaiseGridError(STooManyColumns);
  {$ENDIF}
  if SparseMap
    then Field := DataSet.FindField(FieldName)
    else Field := DataSet.FieldByName(FieldName);

  if FFieldCount = FFieldMapSize then
  begin
    NewSize := FFieldMapSize;
    if NewSize = 0
      then NewSize := 8
      else Inc(NewSize, NewSize);
    if (NewSize < FFieldCount) then
      NewSize := FFieldCount + 1;
    if (NewSize > MaxMapSize) then
      NewSize := MaxMapSize;
    SetLength(FFieldMap, NewSize);
    FFieldMapSize := NewSize;
  end;
  if Assigned(Field) then
  begin
    FFieldMap[FFieldCount] := Field.Index;
{ TODO : Here is code because of which raise list out of bounds in RemoveNotification }
    Field.FreeNotification(FGrid);
  end else
    FFieldMap[FFieldCount] := -1;
  Inc(FFieldCount);
end;

procedure TAxisGridDataLinkEh.ActiveChanged;
begin
  FGrid.LinkActive(Active);
  FModified := False;
  if Active then FLastBookmark := DataSet.Bookmark;
end;

{$IFDEF CIL}
procedure TAxisGridDataLinkEh.DataEvent(Event: TDataEvent; Info: TObject);
{$ELSE}
  {$IFDEF EH_LIB_16}
procedure TAxisGridDataLinkEh.DataEvent(Event: TDataEvent; Info: NativeInt);
  {$ELSE}
procedure TAxisGridDataLinkEh.DataEvent(Event: TDataEvent; Info: Integer);
  {$ENDIF}
{$ENDIF}
begin
  inherited;
{$IFDEF EH_LIB_7}
//  if Event = deDisabledStateChange then
//    FGrid.AxisBars.ActiveChanged;
{$ENDIF}
end;

procedure TAxisGridDataLinkEh.ClearMapping;
begin
  FFieldMap := nil;
  FFieldMapSize := 0;
  FFieldCount := 0;
end;

procedure TAxisGridDataLinkEh.Modified;
begin
  FModified := True;
end;

procedure TAxisGridDataLinkEh.DataSetChanged;
begin
  FGrid.DataChanged;
  FModified := False;
  if Active then FLastBookmark := DataSet.Bookmark;
end;

procedure TAxisGridDataLinkEh.DataSetScrolled(Distance: Integer);
begin
  FGrid.Scroll(Distance);
  if Active then FLastBookmark := DataSet.Bookmark;
end;

procedure TAxisGridDataLinkEh.LayoutChanged;
var
  SaveState: Boolean;
begin
  { FLayoutFromDataset determines whether default AxisBar width is forced to
    be at least wide enough for the AxisBar title.  }
  SaveState := FGrid.FLayoutFromDataset;
  FGrid.FLayoutFromDataset := True;
  try
    FGrid.LayoutChanged;
  finally
    FGrid.FLayoutFromDataset := SaveState;
  end;
  inherited LayoutChanged;
end;

{$IFDEF CIL}
procedure TAxisGridDataLinkEh.FocusControl(const Field: TField);
begin
  if Assigned(Field) and Assigned(Field) then
  begin
    FGrid.SelectedField := Field;
    if (FGrid.SelectedField = Field) and FGrid.AcquireFocus then
    begin
      FGrid.ShowEditor;
    end;
  end;
end;
{$ELSE}
procedure TAxisGridDataLinkEh.FocusControl(Field: TFieldRef);
begin
  if Assigned(Field) and Assigned(Field^) then
  begin
    FGrid.SelectedField := Field^;
    if (FGrid.SelectedField = Field^) and FGrid.AcquireFocus then
    begin
      Field^ := nil;
      FGrid.ShowEditor;
    end;
  end;
end;
{$ENDIF}

procedure TAxisGridDataLinkEh.EditingChanged;
begin
  if (DataSet <> nil) and (DataSet.State = dsBrowse) then
    FModified := False;
  FGrid.EditingChanged;
end;

procedure TAxisGridDataLinkEh.RecordChanged(Field: TField);
begin
//  if FInUpdateData then Exit;
//  FInUpdateData := True;
  try
    FGrid.RecordChanged(Field);
  finally
//    FInUpdateData := False;
  end;
  FModified := False;
end;

procedure TAxisGridDataLinkEh.UpdateData;
begin
  if FInUpdateData or not Active then Exit;
  FInUpdateData := True;
  try
    if FModified then FGrid.UpdateData;
    FModified := False;
  finally
    FInUpdateData := False;
  end;
end;

function TAxisGridDataLinkEh.GetMappedIndex(ColIndex: Integer): Integer;
begin
  if (0 <= ColIndex) and (ColIndex < FFieldCount)
    then Result := FFieldMap[ColIndex]
    else Result := -1;
end;

procedure TAxisGridDataLinkEh.Reset;
begin
  if FModified
    then RecordChanged(nil)
    else FGrid.CancelEditing;
end;

function TAxisGridDataLinkEh.MoveBy(Distance: Integer): Integer;
begin
  Result := inherited MoveBy(Distance);
end;

procedure TAxisGridDataLinkEh.CheckBrowseMode;
begin
  FLastDataSetState := DataSet.State;
  inherited CheckBrowseMode;
end;

{ TAxisBarTitleEh }

constructor TAxisBarTitleEh.Create(AxisBar: TAxisBarEh);
begin
  inherited Create;
  FAxisBar := AxisBar;
  FFont := TFont.Create;
  FFont.Assign(DefaultFont);
  FFont.OnChange := FontChanged;
  FTitleButton := False;
  ImageIndex := -1;
end;

destructor TAxisBarTitleEh.Destroy;
begin
  FreeAndNil(FFont);
  inherited Destroy;
end;

procedure TAxisBarTitleEh.Assign(Source: TPersistent);
begin
  if Source is TAxisBarTitleEh then
  begin
    if cvTitleAlignment in TAxisBarTitleEh(Source).FAxisBar.FAssignedValues then
      Alignment := TAxisBarTitleEh(Source).Alignment;
    if cvTitleColor in TAxisBarTitleEh(Source).FAxisBar.FAssignedValues then
      Color := TAxisBarTitleEh(Source).Color;
    if cvTitleCaption in TAxisBarTitleEh(Source).FAxisBar.FAssignedValues then
      Caption := TAxisBarTitleEh(Source).Caption;
    if cvTitleFont in TAxisBarTitleEh(Source).FAxisBar.FAssignedValues then
      Font := TAxisBarTitleEh(Source).Font;
    Hint := TAxisBarTitleEh(Source).Hint;
    Orientation := TAxisBarTitleEh(Source).Orientation;
    PopupMenu := TAxisBarTitleEh(Source).PopupMenu;
    ImageIndex := TAxisBarTitleEh(Source).ImageIndex;
    TitleButton := TAxisBarTitleEh(Source).TitleButton;
    EndEllipsis := TAxisBarTitleEh(Source).EndEllipsis;
    ToolTips := TAxisBarTitleEh(Source).ToolTips;
  end else
    inherited Assign(Source);
end;

function TAxisBarTitleEh.DefaultAlignment: TAlignment;
begin
  if FAxisBar.GetGrid <> nil
    then Result := FAxisBar.GetGrid.AxisBarDefValues.Title.Alignment
    else Result := taLeftJustify;
end;

function TAxisBarTitleEh.DefaultColor: TColor;
var
  Grid: TCustomDBAxisGridEh;
begin
  Grid := FAxisBar.GetGrid;
  if Assigned(Grid)
    then Result := Grid.AxisBarDefValues.Title.Color
    else Result := clBtnFace;
end;

function TAxisBarTitleEh.DefaultFont: TFont;
var
  Grid: TCustomDBAxisGridEh;
begin
  Grid := FAxisBar.GetGrid;
  if Assigned(Grid)
    then Result := Grid.TitleFont
    else Result := FAxisBar.Font;
end;

function TAxisBarTitleEh.DefaultCaption: string;
var
  Field: TField;
begin
  Field := FAxisBar.Field;
  {if AxisBar.LookupParams.LookupActive then
    Result := AxisBar.LookupParams.LookupDisplayField.DisplayLabel
  else} if Assigned(Field) then
    Result := Field.DisplayName
  else
    Result := FAxisBar.FieldName;
end;

procedure TAxisBarTitleEh.FontChanged(Sender: TObject);
begin
  Include(FAxisBar.FAssignedValues, cvTitleFont);
  FAxisBar.Changed(True);
end;

function TAxisBarTitleEh.GetAlignment: TAlignment;
begin
  if cvTitleAlignment in FAxisBar.FAssignedValues
    then Result := FAlignment
    else Result := DefaultAlignment;
end;

function TAxisBarTitleEh.GetColor: TColor;
begin
  if cvTitleColor in FAxisBar.FAssignedValues
    then Result := FColor
    else Result := DefaultColor;
end;

function TAxisBarTitleEh.GetCaption: string;
begin
  if cvTitleCaption in FAxisBar.FAssignedValues
    then Result := FCaption
    else Result := DefaultCaption;
end;

function TAxisBarTitleEh.GetFont: TFont;
var
  Save: TNotifyEvent;
  Def: TFont;
begin
  if not (cvTitleFont in FAxisBar.FAssignedValues) then
  begin
    Def := DefaultFont;
    {$WARNINGS OFF}
    if (FFont.Handle <> Def.Handle) or (FFont.Color <> Def.Color) then
    {$WARNINGS ON}
    begin
      Save := FFont.OnChange;
      FFont.OnChange := nil;
      FFont.Assign(DefaultFont);
      FFont.OnChange := Save;
    end;
  end;
  Result := FFont;
end;

function TAxisBarTitleEh.IsAlignmentStored: Boolean;
begin
  Result := (cvTitleAlignment in FAxisBar.FAssignedValues) and (FAlignment <> DefaultAlignment);
end;

function TAxisBarTitleEh.IsColorStored: Boolean;
begin
  Result := (cvTitleColor in FAxisBar.FAssignedValues) and (FColor <> DefaultColor);
end;

function TAxisBarTitleEh.IsFontStored: Boolean;
begin
  Result := (cvTitleFont in FAxisBar.FAssignedValues);
end;

function TAxisBarTitleEh.IsCaptionStored: Boolean;
begin
  Result := (cvTitleCaption in FAxisBar.FAssignedValues) and (FCaption <> DefaultCaption);
end;

procedure TAxisBarTitleEh.RefreshDefaultFont;
var
  Save: TNotifyEvent;
begin
  if (cvTitleFont in FAxisBar.FAssignedValues) then Exit;
  Save := FFont.OnChange;
  FFont.OnChange := nil;
  try
    FFont.Assign(DefaultFont);
  finally
    FFont.OnChange := Save;
  end;
end;

procedure TAxisBarTitleEh.RestoreDefaults;
var
  FontAssigned: Boolean;
begin
  FontAssigned := cvTitleFont in FAxisBar.FAssignedValues;
  FAxisBar.FAssignedValues := FAxisBar.FAssignedValues - AxisBarEhTitleValues;
  FCaption := '';
  RefreshDefaultFont;
  { If font was assigned, changing it back to default may affect grid title
    height, and title height changes require layout and redraw of the grid. }
  FAxisBar.Changed(FontAssigned);
end;

procedure TAxisBarTitleEh.SetAlignment(Value: TAlignment);
begin
  if (cvTitleAlignment in FAxisBar.FAssignedValues) and (Value = FAlignment) then Exit;
  FAlignment := Value;
  Include(FAxisBar.FAssignedValues, cvTitleAlignment);
  FAxisBar.Changed(False);
end;

procedure TAxisBarTitleEh.SetColor(Value: TColor);
begin
  if (cvTitleColor in FAxisBar.FAssignedValues) and (Value = FColor) then Exit;
  FColor := Value;
  Include(FAxisBar.FAssignedValues, cvTitleColor);
  FAxisBar.Changed(False);
end;

procedure TAxisBarTitleEh.SetFont(Value: TFont);
begin
  FFont.Assign(Value);
end;

procedure TAxisBarTitleEh.SetCaption(const Value: string);
var
  Grid: TCustomDBAxisGridEh;
begin
  if not AxisBar.SeenPassthrough then
  begin
    if (cvTitleCaption in FAxisBar.FAssignedValues) and (Value = FCaption) then Exit;
    FCaption := Value;
    Include(AxisBar.FAssignedValues, cvTitleCaption);
    AxisBar.Changed(False);
  end else
  begin
    Grid := AxisBar.GetGrid;
    if Assigned(Grid) and (Grid.Datalink.Active) and Assigned(AxisBar.Field) then
      AxisBar.Field.DisplayLabel := Value;
  end;
end;


procedure TAxisBarTitleEh.SetTitleButton(Value: Boolean);
begin
  if (cvTitleButton in FAxisBar.FAssignedValues) and (Value = FTitleButton) then Exit;
  FTitleButton := Value;
  Include(FAxisBar.FAssignedValues, cvTitleButton);
  FAxisBar.Changed(False);
end;

procedure TAxisBarTitleEh.SetEndEllipsis(const Value: Boolean);
begin
  if (cvTitleEndEllipsis in FAxisBar.FAssignedValues) and (Value = FEndEllipsis) then Exit;
  FEndEllipsis := Value;
  Include(FAxisBar.FAssignedValues, cvTitleEndEllipsis);
  FAxisBar.Changed(False);
end;

procedure TAxisBarTitleEh.SetImageIndex(const Value: Integer);
begin
  FImageIndex := Value;
  if (FAxisBar.GetGrid <> nil) and (TGridAxisBarsEh(FAxisBar.Collection).UpdateCount = 0) then
    FAxisBar.GetGrid.LayoutChanged;
end;

function TAxisBarTitleEh.GetToolTips: Boolean;
begin
  if cvTitleToolTips in FAxisBar.FAssignedValues
    then Result := FToolTips
    else Result := DefaultToolTips;
end;

procedure TAxisBarTitleEh.SetToolTips(const Value: Boolean);
begin
  if (cvTitleToolTips in FAxisBar.FAssignedValues) and (Value = FToolTips) then Exit;
  FToolTips := Value;
  Include(FAxisBar.FAssignedValues, cvTitleToolTips);
end;

procedure TAxisBarTitleEh.SetOrientation(const Value: TTextOrientationEh);
begin
  if (cvTitleOrientation in FAxisBar.FAssignedValues) and (Value = FOrientation) then Exit;
  FOrientation := Value;
  Include(FAxisBar.FAssignedValues, cvTitleOrientation);
  FAxisBar.Changed(False);
end;

procedure TAxisBarTitleEh.SetPopupMenu(Value: TPopupMenu);
begin
  if FPopupMenu <> Value then
    begin
      FPopupMenu := Value;
      if Value <> nil then Value.FreeNotification(AxisBar.GetGrid);
    end;
end;

function TAxisBarTitleEh.GetTitleButton: Boolean;
begin
  if cvTitleButton in FAxisBar.FAssignedValues
    then Result := FTitleButton
    else Result := DefaultTitleButton;
end;

function TAxisBarTitleEh.IsTitleButtonStored: Boolean;
begin
  Result := (cvTitleButton in FAxisBar.FAssignedValues) and (FTitleButton <> DefaultTitleButton);
end;

function TAxisBarTitleEh.DefaultTitleButton: Boolean;
begin
  if FAxisBar.GetGrid <> nil
    then Result := FAxisBar.GetGrid.AxisBarDefValues.Title.TitleButton
    else Result := False;
end;

function TAxisBarTitleEh.GetEndEllipsis: Boolean;
begin
  if cvTitleEndEllipsis in FAxisBar.FAssignedValues
    then Result := FEndEllipsis
    else Result := DefaultEndEllipsis;
end;

function TAxisBarTitleEh.IsEndEllipsisStored: Boolean;
begin
  Result := (cvTitleEndEllipsis in FAxisBar.FAssignedValues) and (FEndEllipsis <> DefaultEndEllipsis);
end;

function TAxisBarTitleEh.DefaultEndEllipsis: Boolean;
begin
  if FAxisBar.GetGrid <> nil
    then Result := FAxisBar.GetGrid.AxisBarDefValues.Title.EndEllipsis
    else Result := False;
end;

function TAxisBarTitleEh.DefaultToolTips: Boolean;
begin
  if FAxisBar.GetGrid <> nil
    then Result := FAxisBar.GetGrid.AxisBarDefValues.Title.ToolTips
    else Result := False;
end;

function TAxisBarTitleEh.IsToolTipsStored: Boolean;
begin
  Result := (cvTitleToolTips in FAxisBar.FAssignedValues) and (FToolTips <> DefaultToolTips);
end;

function TAxisBarTitleEh.DefaultOrientation: TTextOrientationEh;
begin
  if FAxisBar.GetGrid <> nil
    then Result := FAxisBar.GetGrid.AxisBarDefValues.Title.Orientation
    else Result := tohHorizontal;
end;

function TAxisBarTitleEh.GetOrientation: TTextOrientationEh;
begin
  if cvTitleOrientation in FAxisBar.FAssignedValues
    then Result := FOrientation
    else Result := DefaultOrientation;
end;

function TAxisBarTitleEh.IsOrientationStored: Boolean;
begin
  Result := (cvTitleOrientation in FAxisBar.FAssignedValues) and (FOrientation <> DefaultOrientation);
end;

{ TAxisBarMainEditButtonEh }

constructor TAxisBarMainEditButtonEh.Create(AxisBar: TAxisBarEh);
begin
  inherited Create(TWinControl(nil));
  FAxisBar := AxisBar;
  DropDownFormParams.OnCheckDataIsReadOnly := AxisBar.CheckDataIsReadOnly;
end;

function TAxisBarMainEditButtonEh.DefaultVisible: Boolean;
var
  BarType: TAxisBarEhType;
begin
  BarType := FAxisBar.GetBarType;
  if FAxisBar.LookupParams.LookupActive then
    Result := True
  else if (BarType in [ctPickList, ctKeyPickList]) and not FAxisBar.ReadOnly then
    Result := True
  else if BarType = ctDataList then
    Result := True
  else if Assigned(FAxisBar.Field) and
         (FAxisBar.Field.DataType in [ftDate, ftDateTime{$IFDEF EH_LIB_6}, ftTimeStamp{$ENDIF}]) and
          not FAxisBar.Readonly
  then
    Result := True
  else if (FAxisBar.DropDownFormParams.DropDownForm <> nil) or
          (FAxisBar.DropDownFormParams.DropDownFormClassName <> '') then
    Result := True
  else
    Result := False;
end;

function TAxisBarMainEditButtonEh.GetVisible: Boolean;
begin
  if VisibleStored
    then Result := FVisible
    else Result := DefaultVisible;
end;

function TAxisBarMainEditButtonEh.IsVisibleStored: Boolean;
begin
  Result := FVisibleStored;
end;

procedure TAxisBarMainEditButtonEh.SetVisible(const Value: Boolean);
begin
  if VisibleStored and (Value = FVisible) then Exit;
  VisibleStored := True;
  FVisible := Value;
end;

procedure TAxisBarMainEditButtonEh.SetVisibleStored(const Value: Boolean);
begin
  if (Value = True) and (IsVisibleStored = False) then
  begin
    FVisibleStored := True;
    FVisible := DefaultVisible;
  end else if (Value = False) and (IsVisibleStored = True) then
  begin
    FVisibleStored := False;
    FVisible := DefaultVisible;
  end;
end;

function TAxisBarMainEditButtonEh.GetAxisBarButtonStyle: TCellButtonStyleEh;
begin
  if not VisibleStored then
    Result := cbsAuto
  else if not Visible then
    Result := cbsNone
  else if Style = ebsEllipsisEh then
    Result := cbsEllipsis
  else if Style = ebsUpDownEh then
    Result := cbsUpDown
  else if Style = ebsDropDownEh then
    Result := cbsDropDown
  else if Style = ebsAltUpDownEh then
    Result := cbsAltUpDown
  else if Style = ebsAltDropDownEh then
    Result := cbsAltDropDown
  else
    Result := cbsAuto;
end;

procedure TAxisBarMainEditButtonEh.SetAxisBarButtonStyle(
  const Value: TCellButtonStyleEh);
begin
  if AxisBarButtonStyle <> Value then
  begin
    if Value = cbsAuto then
      VisibleStored := False
    else if Value = cbsEllipsis then
    begin
      Visible := True;
      Style := ebsEllipsisEh;
    end else if Value = cbsNone then
    begin
      Visible := False;
      Style := ebsDropDownEh;
    end else if Value = cbsUpDown then
    begin
      Visible := True;
      Style := ebsUpDownEh;
    end else if Value = cbsDropDown then
    begin
      Visible := True;
      Style := ebsDropDownEh;
    end else if Value = cbsAltUpDown then
    begin
      Visible := True;
      Style := ebsAltUpDownEh;
    end else if Value = cbsAltDropDown then
    begin
      Visible := True;
      Style := ebsAltDropDownEh;
    end
  end;
end;

{ TAxisBarEh }

constructor TAxisBarEh.Create(Collection: TCollection);
var
  Grid: TCustomDBAxisGridEh;
  LayoutStarted: Boolean;
begin
  Grid := nil;
  LayoutStarted := False;
  if Assigned(Collection) and (Collection is TGridAxisBarsEh) then
    Grid := TGridAxisBarsEh(Collection).Grid;
  if Grid <> nil
    then FCheckModifyColCellParamsEh := Grid.CreateColCellParamsEh
    else FCheckModifyColCellParamsEh := nil;
  if Assigned(Grid) and (TGridAxisBarsEh(Collection).UpdateCount = 0) then
  begin
    Grid.BeginLayout;
    LayoutStarted := True;
  end;
  try
    inherited Create(Collection);
    FDynProps := TDynVarsEh.Create(Self);
    FDropDownRows := 7;
    FButtonStyle := cbsAuto;
    FFont := TFont.Create;
    FFont.Assign(DefaultFont);
    FFont.OnChange := FontChanged;
  {$IFDEF FPC}
  {$ELSE}
    FImeMode := imDontCare;
    FImeName := Screen.DefaultIme;
  {$ENDIF}
    FTitle := CreateTitle;
    FVisible := True;
    FNotInKeyListIndex := -1;
    FIncrement := 1.0;
    FStored := True;

    FEditButton := CreateFirstEditButton;
    FEditButton.OnChanged := EditButtonChanged;
//    FEditButton.OnRefComponentChanged := EditButtonImagesRefComponentNotifyEvent;

    FEditButtons := CreateEditButtons;
    FEditButtons.OnChanged := EditButtonChanged;
    FDropDownSpecRow := TSpecRowEh.Create(Self);
    FDropDownSpecRow.OnChanged := SpecRowChanged;
    FDropDownBox := TColumnDropDownBoxEh.Create(Self);
    FMRUList := TMRUListEh.Create(Self);
    FImageChangeLink := TChangeLink.Create;
    FImageChangeLink.OnChange := ImageListChange;
    FShowImageAndText := False;
    FDropDownFormParams := TDropDownFormCallParamsEh.Create;
    FDropDownFormParams.OnChanged := DropDownFormParamsChanged;
    FDropDownFormParams.OnCheckDataIsReadOnly := CheckDataIsReadOnly;
    FCaseInsensitiveTextSearch := True;
    FLookupParams := CreateLookupData;
  finally
    if Assigned(Grid) and LayoutStarted then
      Grid.EndLayout;
  end;
end;

destructor TAxisBarEh.Destroy;
begin
  Collection := nil;
  FreeAndNil(FCheckModifyColCellParamsEh);
  FreeAndNil(FDynProps);
  FreeAndNil(FDropDownSpecRow);
  FreeAndNil(FTitle);
  FreeAndNil(FFont);
  FreeAndNil(FPickList);

  FreeAndNil(FKeyList);
  FreeAndNil(FEditButton);
  FreeAndNil(FEditButtons);
  FreeAndNil(FDataList);
  FreeAndNil(FDropDownBox);
  FreeAndNil(FDTListSource);
  FreeAndNil(FMRUList);
  FreeAndNil(FImageChangeLink);
  FreeAndNil(FDropDownFormParams);
  FreeAndNil(FLookupParams);
  FreeAndNil(FSystemPopupMenu);
  inherited Destroy;
end;

procedure TAxisBarEh.Assign(Source: TPersistent);
var
  SourceAxisBar: TAxisBarEh;
begin
  if Source is TAxisBarEh then
  begin
    SourceAxisBar := TAxisBarEh(Source);
    if Assigned(Collection) then Collection.BeginUpdate;
    try
      RestoreDefaults;
      FieldName := SourceAxisBar.FieldName;
      if cvColor in SourceAxisBar.AssignedValues then
        Color := SourceAxisBar.Color;
      if cvFont in SourceAxisBar.AssignedValues then
        Font := SourceAxisBar.Font;
  {$IFDEF FPC}
  {$ELSE}
      if cvImeMode in SourceAxisBar.AssignedValues then
        ImeMode := SourceAxisBar.ImeMode;
      if cvImeName in SourceAxisBar.AssignedValues then
        ImeName := SourceAxisBar.ImeName;
  {$ENDIF}
      if cvAlignment in SourceAxisBar.AssignedValues then
        Alignment := SourceAxisBar.Alignment;
      if cvReadOnly in SourceAxisBar.AssignedValues then
        ReadOnly := SourceAxisBar.ReadOnly;
      CaseInsensitiveTextSearch := SourceAxisBar.CaseInsensitiveTextSearch;
      if not LookupParams.LookupInDataField then
        LookupParams := SourceAxisBar.LookupParams;
      if SourceAxisBar.LimitTextToListValuesStored then
        LimitTextToListValues := SourceAxisBar.LimitTextToListValues;
      Title := SourceAxisBar.Title;
      DropDownRows := SourceAxisBar.DropDownRows;
      ButtonStyle := SourceAxisBar.ButtonStyle;
      PickList := SourceAxisBar.PickList;
      PopupMenu := SourceAxisBar.PopupMenu;
      if cvWordWrap in SourceAxisBar.AssignedValues then
        WordWrap := SourceAxisBar.WordWrap;
      EndEllipsis := SourceAxisBar.EndEllipsis;
      DropDownWidth := SourceAxisBar.DropDownWidth;
      if cvLookupDisplayFields in SourceAxisBar.AssignedValues then
        LookupDisplayFields := SourceAxisBar.LookupDisplayFields;
      AutoDropDown := SourceAxisBar.AutoDropDown;
      AlwaysShowEditButton := SourceAxisBar.AlwaysShowEditButton;
      WordWrap := SourceAxisBar.WordWrap;
      KeyList := SourceAxisBar.KeyList;
      if cvCheckboxes in SourceAxisBar.AssignedValues then
        Checkboxes := SourceAxisBar.Checkboxes;
      Increment := SourceAxisBar.Increment;
      ToolTips := SourceAxisBar.ToolTips;
      Tag := SourceAxisBar.Tag;
      Visible := SourceAxisBar.Visible;
      ImageList := SourceAxisBar.ImageList;
      NotInKeyListIndex := SourceAxisBar.NotInKeyListIndex;
      DblClickNextVal := SourceAxisBar.DblClickNextVal;
      DropDownSizing := SourceAxisBar.DropDownSizing;
      DropDownShowTitles := SourceAxisBar.DropDownShowTitles;
      OnNotInList := SourceAxisBar.OnNotInList;
      OnUpdateData := SourceAxisBar.OnUpdateData;
      OnEditButtonClick := SourceAxisBar.OnEditButtonClick;
      OnEditButtonDown := SourceAxisBar.OnEditButtonDown;
      EditButtons := SourceAxisBar.EditButtons;
      DropDownBox := SourceAxisBar.DropDownBox;
      MRUList := SourceAxisBar.MRUList;
      DisplayFormat := SourceAxisBar.DisplayFormat;
      EditMask := SourceAxisBar.EditMask;
      ShowImageAndText := SourceAxisBar.ShowImageAndText;
      Layout := SourceAxisBar.Layout;
    finally
      if Assigned(Collection) then Collection.EndUpdate;
    end;
  end else
    inherited Assign(Source);
end;

function TAxisBarEh.CreateTitle: TAxisBarTitleEh;
begin
  Result := TAxisBarTitleEh.Create(Self);
end;

function TAxisBarEh.DefaultAlignment: TAlignment;
begin
  if Assigned(Field)
    then Result := FField.Alignment
    else Result := taLeftJustify;
end;

function TAxisBarEh.DefaultColor: TColor;
var
  Grid: TCustomDBAxisGridEh;
begin
  Grid := GetGrid;
  if Assigned(Grid)
    then Result := Grid.Color
    else Result := clWindow;
end;

function TAxisBarEh.DefaultFont: TFont;
var
  Grid: TCustomDBAxisGridEh;
begin
  Grid := GetGrid;
  if Assigned(Grid)
    then Result := Grid.Font
    else Result := FFont;
end;

{$IFDEF FPC}
{$ELSE}
function TAxisBarEh.DefaultImeMode: TImeMode;
var
  Grid: TCustomDBAxisGridEh;
begin
  Grid := GetGrid;
  if Assigned(Grid)
    then Result := Grid.ImeMode
    else Result := FImeMode;
end;

function TAxisBarEh.DefaultImeName: TImeName;
var
  Grid: TCustomDBAxisGridEh;
begin
  Grid := GetGrid;
  if Assigned(Grid)
    then Result := Grid.ImeName
    else Result := FImeName;
end;
{$ENDIF}

function TAxisBarEh.DefaultReadOnly: Boolean;
var
  Grid: TCustomDBAxisGridEh;
begin
  Grid := GetGrid;
  Result := (Assigned(Grid) and Grid.ReadOnly) or (Assigned(FField) and FField.ReadOnly);
end;

procedure TAxisBarEh.FontChanged;
begin
  Include(FAssignedValues, cvFont);
  Title.RefreshDefaultFont;
  Changed(False);
end;

function TAxisBarEh.GetAlignment: TAlignment;
begin
  if cvAlignment in FAssignedValues
    then Result := FAlignment
    else Result := DefaultAlignment;
end;

function TAxisBarEh.GetColor: TColor;
begin
  if cvColor in FAssignedValues
    then Result := FColor
    else Result := DefaultColor;
end;

function TAxisBarEh.GetField: TField;
var
  Grid: TCustomDBAxisGridEh;
begin { Returns Nil if FieldName can't be found in dataset }
  if FField <> nil then
  begin
    Result := FField;
    Exit;
  end;
  Grid := GetGrid;
  if (FField = nil) and (FFieldName <> '') and Assigned(Grid) and
    Assigned(Grid.DataLink.DataSet) then
    with Grid.Datalink.Dataset do
      if Active or (not DefaultFields) then
      begin
      // SetField(FindField(FieldName));
        if FField <> FindField(FieldName) then
        begin
          FField := FindField(FieldName);
          if Assigned(FField) then
          begin
            FFieldName := FField.FieldName;
//          EnsureSumValue;
            FLookupParams.UpdateLookupState;
          end;
        end;
        if Assigned(FField) and (GetGrid <> nil) and
          (csDesigning in GetGrid.ComponentState) then
        begin
          if FDTListSource = nil then
            FDTListSource := TDataSource.Create(nil);
          FDTListSource.DataSet := FField.LookupDataSet;
          DataList.DataSource := FDTListSource;
          TDBLookupGridEh(DataList).KeyField := FField.LookupKeyFields;
          TDBLookupGridEh(DataList).ListField := LookupDisplayFields;
        end;
      end;
  Result := FField;
end;

function TAxisBarEh.GetFont: TFont;
var
  Save: TNotifyEvent;
begin
  {$WARNINGS OFF}
  if not (cvFont in FAssignedValues) and (FFont.Handle <> DefaultFont.Handle) then
  {$WARNINGS ON}
  begin
    Save := FFont.OnChange;
    FFont.OnChange := nil;
    FFont.Assign(DefaultFont);
    FFont.OnChange := Save;
  end;
  Result := FFont;
end;

function TAxisBarEh.GetGrid: TCustomDBAxisGridEh;
begin
  if Assigned(Collection) {and (Collection is TGridAxisBarsEh)}
    then Result := TGridAxisBarsEh(Collection).Grid
    else Result := nil;
end;

function TAxisBarEh.GetDisplayName: string;
begin
  Result := FFieldName;
  if Result = ''
    then Result := inherited GetDisplayName;
end;

{$IFDEF FPC}
{$ELSE}
function TAxisBarEh.GetImeMode: TImeMode;
begin
  if cvImeMode in FAssignedValues
    then Result := FImeMode
    else Result := DefaultImeMode;
end;

function TAxisBarEh.GetImeName: TImeName;
begin
  if cvImeName in FAssignedValues
    then Result := FImeName
    else Result := DefaultImeName;
end;
{$ENDIF}

function TAxisBarEh.GetPickList: TStrings;
begin
  if FPickList = nil then
    FPickList := TStringList.Create;
  Result := FPickList;
end;

function TAxisBarEh.GetReadOnly: Boolean;
begin
  if cvReadOnly in FAssignedValues
    then Result := FReadOnly
    else Result := DefaultReadOnly;
end;

function TAxisBarEh.IsAlignmentStored: Boolean;
begin
  Result := (cvAlignment in FAssignedValues) and (FAlignment <> DefaultAlignment);
end;

function TAxisBarEh.IsColorStored: Boolean;
begin
  Result := (cvColor in FAssignedValues) and (FColor <> DefaultColor);
end;

function TAxisBarEh.IsFontStored: Boolean;
begin
  Result := (cvFont in FAssignedValues);
end;

{$IFDEF FPC}
{$ELSE}
function TAxisBarEh.IsImeModeStored: Boolean;
begin
  Result := (cvImeMode in FAssignedValues) and (FImeMode <> DefaultImeMode);
end;

function TAxisBarEh.IsImeNameStored: Boolean;
begin
  Result := (cvImeName in FAssignedValues) and (FImeName <> DefaultImeName);
end;
{$ENDIF}

function TAxisBarEh.IsReadOnlyStored: Boolean;
begin
  Result := (cvReadOnly in FAssignedValues) and (FReadOnly <> DefaultReadOnly);
end;

procedure TAxisBarEh.RefreshDefaultFont;
var
  Save: TNotifyEvent;
begin
  if cvFont in FAssignedValues then Exit;
  Save := FFont.OnChange;
  FFont.OnChange := nil;
  try
    FFont.Assign(DefaultFont);
  finally
    FFont.OnChange := Save;
  end;
end;

procedure TAxisBarEh.RestoreDefaults;
var
  FontAssigned: Boolean;
begin
  FontAssigned := cvFont in FAssignedValues;
  FTitle.RestoreDefaults;
  FAssignedValues := [];
  RefreshDefaultFont;
  FreeAndNil(FPickList);
  ButtonStyle := cbsAuto;
  Changed(FontAssigned);
  FreeAndNil(FKeyList);
end;

procedure TAxisBarEh.SetAlignment(Value: TAlignment);
var
  Grid: TCustomDBAxisGridEh;
begin
  if not SeenPassthrough then
  begin
    if (cvAlignment in FAssignedValues) and (Value = FAlignment) then Exit;
    FAlignment := Value;
    Include(FAssignedValues, cvAlignment);
    Changed(False);
  end
  else
  begin
    Grid := GetGrid;
    if Assigned(Grid) and (Grid.Datalink.Active) and Assigned(Field)
      then Field.Alignment := Value;
  end;
end;

function TAxisBarEh.GetButtonStyle: TCellButtonStyleEh;
begin
  Result := EditButton.AxisBarButtonStyle;
end;

procedure TAxisBarEh.SetButtonStyle(Value: TCellButtonStyleEh);
begin
  EditButton.AxisBarButtonStyle := Value;
end;

procedure TAxisBarEh.SetColor(Value: TColor);
begin
  if (cvColor in FAssignedValues) and (Value = FColor) then Exit;
  FColor := Value;
  Include(FAssignedValues, cvColor);
  Changed(False);
end;

procedure TAxisBarEh.SetField(Value: TField);
begin
  if FField = Value then Exit;
  FField := Value;
  if Assigned(Value) then
  begin
    FFieldName := Value.FieldName;
    FLookupParams.UpdateLookupState;
  end else if not Assigned(Value) and (FFieldName = '') then
    FLookupParams.UpdateLookupState;

  if SeenPassthrough then
  begin
    if Value = nil then FFieldName := '';
    RestoreDefaults;
//    FInitWidth := Width;
  end;
  if Assigned(Value) and (GetGrid <> nil) and
    (csDesigning in GetGrid.ComponentState) then
  begin
    if FDTListSource = nil then
      FDTListSource := TDataSource.Create(nil);
    FDTListSource.DataSet := Value.LookupDataSet;
    DataList.DataSource := FDTListSource;
    TDBLookupGridEh(DataList).KeyField := FField.LookupKeyFields;
    TDBLookupGridEh(DataList).ListField := LookupDisplayFields;
  end;
//  EnsureSumValue;
  Changed(False);
end;

procedure TAxisBarEh.SetFieldName(const Value: String);
begin
  if FFieldName <> Value then
  begin
    FFieldName := Value;
    BindField;
  end;  
end;

procedure TAxisBarEh.BindField;
var
  AField: TField;
  Grid: TCustomDBAxisGridEh;
begin
  AField := nil;
  Grid := GetGrid;
  if Assigned(Grid) and Assigned(Grid.DataLink.DataSet) and
    not (csLoading in Grid.ComponentState) and (FieldName <> '')
  then
    AField := Grid.DataLink.DataSet.FindField(FieldName); { no exceptions }
  SetField(AField);
end;

procedure TAxisBarEh.SetFont(Value: TFont);
begin
  FFont.Assign(Value);
  Include(FAssignedValues, cvFont);
  Changed(False);
end;

{$IFDEF FPC}
{$ELSE}
procedure TAxisBarEh.SetImeMode(Value: TImeMode);
begin
  if (cvImeMode in FAssignedValues) or (Value <> DefaultImeMode) then
  begin
    FImeMode := Value;
    Include(FAssignedValues, cvImeMode);
  end;
  Changed(False);
end;

procedure TAxisBarEh.SetImeName(Value: TImeName);
begin
  if (cvImeName in FAssignedValues) or (Value <> DefaultImeName) then
  begin
    FImeName := Value;
    Include(FAssignedValues, cvImeName);
  end;
  Changed(False);
end;
{$ENDIF}

procedure TAxisBarEh.SetIndex(Value: Integer);
var
  Grid: TCustomDBAxisGridEh;
  Fld: TField;
  CurIndex: Integer;
begin
  if TGridAxisBarsEh(Collection).IndexSeenPassthrough then
  begin
    Grid := GetGrid;
    if Assigned(Grid) and Grid.Datalink.Active then
    begin
      Fld := Grid.Datalink.Fields[Value];
      if Assigned(Fld) then
        Field.Index := Fld.Index;
    end;
  end;
  CurIndex := Index;
  if (CurIndex >= 0) and (CurIndex <> Value) and
     (Value >= 0) and (Value < TGridAxisBarsEh(Collection).Count)
  then
    TGridAxisBarsEh(Collection).BarsNotify(Self, gabnIndexChangingEh);
  inherited SetIndex(Value);
end;

procedure TAxisBarEh.SetPickList(Value: TStrings);
begin
  if Value = nil then
  begin
    FreeAndNil(FPickList);
    Exit;
  end;
  PickList.Assign(Value);
end;

procedure TAxisBarEh.SetPopupMenu(Value: TPopupMenu);
begin
  if FPopupMenu <> Value then
    begin
      FPopupMenu := Value;
      if Value <> nil then Value.FreeNotification(GetGrid);
    end;
end;

procedure TAxisBarEh.SetReadOnly(Value: Boolean);
var
  Grid: TCustomDBAxisGridEh;
begin
  Grid := GetGrid;
  if SeenPassthrough and Assigned(Grid) and Grid.Datalink.Active and Assigned(Field)
    then Field.ReadOnly := Value
  else
  begin
    if (cvReadOnly in FAssignedValues) and (Value = FReadOnly) then Exit;
    FReadOnly := Value;
    Include(FAssignedValues, cvReadOnly);
    Changed(False);
  end;
end;

procedure TAxisBarEh.SetTitle(Value: TAxisBarTitleEh);
begin
  FTitle.Assign(Value);
end;

procedure TAxisBarEh.SetAlwaysShowEditButton(Value: Boolean);
begin
  if (cvAlwaysShowEditButton in FAssignedValues) and (Value = FAlwaysShowEditButton)
    then Exit;
  FAlwaysShowEditButton := Value;
  Include(FAssignedValues, cvAlwaysShowEditButton);
  Changed(False);
end;

procedure TAxisBarEh.SetWordWrap(Value: Boolean);
begin
  if WordWrap <> Value then
  begin
    Include(FAssignedValues, cvWordWrap);
    FWordWrap := Value;
    Changed(False);
  end else
  begin
    Include(FAssignedValues, cvWordWrap);
    FWordWrap := Value;
  end;
end;

function TAxisBarEh.GetWordWrap: Boolean;
begin
  if cvWordWrap in FAssignedValues
    then Result := FWordWrap
    else Result := DefaultWordWrap;
end;

function TAxisBarEh.IsWordWrapStored: Boolean;
begin
  Result := (cvWordWrap in FAssignedValues) {and (FWordWrap <> DefaultWordWrap)};
end;

function TAxisBarEh.DefaultWordWrap: Boolean;
begin
  if GetGrid = nil then
  begin
    Result := False;
    Exit;
  end;
  with GetGrid do
  begin
    if Assigned(Field) then
    begin
      case Field.DataType of
        ftString, ftMemo, ftFmtMemo, ftWideString, ftOraClob
          {$IFDEF EH_LIB_10} ,ftWideMemo {$ENDIF}: Result := True;
      else
        Result := False;
      end;
    end
    else
      Result := False;
  end;
end;

procedure TAxisBarEh.SetEndEllipsis(const Value: Boolean);
begin
  if (cvEndEllipsis in FAssignedValues) and (Value = FEndEllipsis) then Exit;
  FEndEllipsis := Value;
  Include(FAssignedValues, cvEndEllipsis);
  Changed(False);
end;

procedure TAxisBarEh.SetDropDownWidth(Value: Integer);
begin
  if (Value = FDropDownWidth) then Exit;
  FDropDownWidth := Value;
  Changed(False);
end;

function TAxisBarEh.DefaultLookupDisplayFields: String;
begin
  Result := LookupParams.LookupDisplayFieldName;
end;

function TAxisBarEh.GetLookupDisplayFields: String;
begin
  if cvLookupDisplayFields in FAssignedValues
    then Result := FLookupDisplayFields
    else Result := DefaultLookupDisplayFields;
end;

procedure TAxisBarEh.SetLookupDisplayFields(Value: String);
begin
  if (cvLookupDisplayFields in FAssignedValues) or (Value <> DefaultLookupDisplayFields) then
  begin
    FLookupDisplayFields := Value;
    TDBLookupGridEh(DataList).ListField := FLookupDisplayFields;
    Include(FAssignedValues, cvLookupDisplayFields);
  end;
  Changed(False);
end;

function TAxisBarEh.IsLookupDisplayFieldsStored: Boolean;
begin
  Result := (cvLookupDisplayFields in FAssignedValues) and
    (FLookupDisplayFields <> DefaultLookupDisplayFields);
end;

procedure TAxisBarEh.SetAutoDropDown(Value: Boolean);
begin
  if (cvAutoDropDown in FAssignedValues) and (Value = FAutoDropDown) then Exit;
  FAutoDropDown := Value;
  Include(FAssignedValues, cvAutoDropDown);
end;

procedure TAxisBarEh.SetVisible(const Value: Boolean);
begin
  if (Value = FVisible) then Exit;
  FVisible := Value;
  Changed(True);
end;

function TAxisBarEh.GetKeykList: TStrings;
begin
  if FKeyList = nil then
  begin
    FKeyList := TStringList.Create;
    TStringList(FKeyList).CaseSensitive := True;
  end;
  Result := FKeyList;
end;

procedure TAxisBarEh.SetKeykList(const Value: TStrings);
begin
  if Value = nil then
  begin
    FreeAndNil(FKeyList);
    Exit;
  end;
  KeyList.Assign(Value);
  if GetGrid <> nil then GetGrid.Invalidate;
end;

function TAxisBarEh.GetBarType: TAxisBarEhType;
begin
// ctCommon, ctPickList, ctLookupField, ctKeyPickList, ctKeyImageList
  Result := ctCommon;
  if Checkboxes then
    Result := ctCheckboxes
  else if LookupParams.LookupIsSetUp then
    Result := ctLookupField
  else if DropDownBox.ListSource <> nil then
    Result := ctDataList
  else if Assigned(Field) and Field.IsBlob and (Field is TBlobField) and
          (TBlobField(Field).BlobType = ftGraphic) and Grid.DrawGraphicData
  then
    Result := ctGraphicData
  else if Assigned(FPickList) and (FPickList.Count > 0) and not (Assigned(FKeyList) and (FKeyList.Count > 0)) then
    Result := ctPickList
  else if Assigned(ImageList) and not ShowImageAndText then
    Result := ctKeyImageList
  else if Assigned(FKeyList) and (FKeyList.Count > 0) and Assigned(FPickList) and (FPickList.Count > 0) then
    Result := ctKeyPickList;
end;

procedure TAxisBarEh.SetNotInKeyListIndex(const Value: Integer);
begin
  if (FNotInKeyListIndex = Value) then Exit;
  FNotInKeyListIndex := Value;
  if GetGrid <> nil then
    GetGrid.Invalidate;
end;

procedure TAxisBarEh.SetImageList(const Value: TCustomImageList);
begin
  if FImageList <> nil then FImageList.UnRegisterChanges(FImageChangeLink);
  FImageList := Value;
  if FImageList <> nil then
  begin
    FImageList.RegisterChanges(FImageChangeLink);
    if GetGrid <> nil then
      FImageList.FreeNotification(GetGrid);
  end;
  if GetGrid <> nil then
    GetGrid.Invalidate;
end;

procedure TAxisBarEh.ImageListChange(Sender: TObject);
begin
  if Sender = ImageList then
    GetGrid.Invalidate;
end;

function TAxisBarEh.InplaceEditorButtonHeight: Integer;
begin
  Result := FInplaceEditorButtonHeight;
//  Result := GetGrid.FInplaceEditorButtonHeight;
end;

function TAxisBarEh.CalcInplaceEditorButtonHeight: Integer;
var
  DefHeight: Boolean;
  i: Integer;
  AButtonHeight, MinButtonHeight: Integer;
begin
  DefHeight := True;
  if EditButton.Width <> 0 then
    DefHeight := False;
  if DefHeight then
  begin
    for i := 0 to EditButtons.Count - 1 do
      if EditButtons[i].Width <> 0 then
      begin
        DefHeight := False;
        Break;
      end;
  end;
  if DefHeight then
    Result := GetGrid.FInplaceEditorButtonHeight
  else
  begin
    MinButtonHeight := Round(EditButton.Width * 3 / 2);
    for i := 0 to EditButtons.Count - 1 do
    begin
      AButtonHeight := Round(EditButtons[i].Width * 3 / 2);
      if AButtonHeight < MinButtonHeight then
        MinButtonHeight := AButtonHeight;
    end;

    if MinButtonHeight < GetGrid.FInplaceEditorButtonHeight then
      Result := GetGrid.FInplaceEditorButtonHeight
    else if MinButtonHeight > GetGrid.DefaultRowHeight then
      Result := GetGrid.DefaultRowHeight
    else
      Result := MinButtonHeight;
  end;
end;

function TAxisBarEh.InplaceEditorButtonWidth: Integer;
begin
  if EditButton.Width <> 0 then
    Result := EditButton.Width
  else if GetGrid.Flat then
  begin
    Result := FlatButtonWidth;
    if not ThemesEnabled then
      Inc(Result);
  end else
    Result := GetSystemMetrics(SM_CXVSCROLL);
//  Result := GetGrid.FInplaceEditorButtonWidth;
end;

procedure TAxisBarEh.SetNextFieldValue(Increment: Extended);
var CanEdit: Boolean;
  ki: Integer;
  AColType: TAxisBarEhType;
  AField: TField;
  AFields: TListOfFieldsEh;

  AValue: Variant;
  Text: String;
begin
  CanEdit := True;
  AField := nil;
  if Assigned(Grid) then
    CanEdit := CanEdit and not Grid.ReadOnly
      and Grid.FDatalink.Active and not Grid.FDatalink.ReadOnly;
  CanEdit := CanEdit and not ReadOnly;
  if Assigned(Field) then
    if (Field.FieldKind = fkLookUp) then
    begin
      CanEdit := CanEdit and (Field.KeyFields <> '');
      AFields := TListOfFieldsEh.Create;
      try
        Field.Dataset.GetFieldList(AFields, Field.KeyFields);
        AField := TField(AFields[0]);
        CanEdit := CanEdit and FieldsCanModify(AFields);
      finally
        AFields.Free;
      end;
      //AField := Field.DataSet.FieldByName(Field.KeyFields);
    end else AField := Field
  else CanEdit := False;

  if CanEdit then
    CanEdit := CanEdit and AField.CanModify
      and (not AField.IsBlob or Assigned(AField.OnSetText))
      and Grid.AllowedOperationUpdate;
  if CanEdit then
    with Grid.FColCellParamsEh do 
    begin
      FReadOnly := not CanModify(False);
      GetColCellParams(True, Grid.FColCellParamsEh);
      CanEdit := not FReadOnly;
    end;
  if CanEdit and Assigned(Grid) then
  begin
    Grid.FDatalink.Edit;
    CanEdit := Grid.FDatalink.Editing;
    if CanEdit then Grid.FDatalink.Modified;
  end;

  if not CanEdit then Exit;

  AColType := GetBarType;
  if Grid.InplaceEditorVisible
    then Text := Grid.InplaceEditor.Text
  else Text := Field.Text;
  if (AColType = ctCheckboxes) then
    if CheckboxState = cbChecked
      then CheckboxState := cbUnchecked
      else CheckboxState := cbChecked
  else if (AColType in [ctKeyPickList, ctKeyImageList]) then
  begin
    ki := KeyList.IndexOf(Field.Text);
    if KeyList.Count > 0 then
    begin
      if ((ki = -1) or (ki = KeyList.Count - 1)) and (Increment = 1) then
        UpdateDataValues(Text, KeyList.Strings[0], False)
      else if ((ki = -1) or (ki = 0)) and not (Increment = 1) then
        UpdateDataValues(Text, KeyList.Strings[KeyList.Count - 1], False)
      else if (Increment = 1) then
        UpdateDataValues(Text, KeyList.Strings[ki + 1], False)
      else
        UpdateDataValues(Text, KeyList.Strings[ki - 1], False);
    end;
  end else if AColType = ctPickList then
  begin
    ki := PickList.IndexOf(Field.Text);
    if ((ki = -1) or (ki = PickList.Count - 1)) and (Increment = 1)
      then Field.Text := PickList.Strings[0]
    else if ((ki = -1) or (ki = 0)) and not (Increment = 1)
      then Field.Text := PickList.Strings[PickList.Count - 1]
    else if (Increment = 1) then
      UpdateDataValues(PickList.Strings[ki + 1], PickList.Strings[ki + 1], True)
    else
      UpdateDataValues(PickList.Strings[ki - 1], PickList.Strings[ki - 1], True)
  end else if (AColType = ctLookupField) and (UsedLookupDataSet <> nil) then
  begin
    if AField.IsNull or
      not UsedLookupDataSet.Locate(Field.LookUpKeyFields, Field.DataSet.FieldValues[Field. {LookUp} KeyFields], [])
      then UsedLookupDataSet.First
    else if (Increment = 1) then
    begin //Go Forward
      if not UsedLookupDataSet.EOF then
      begin
        UsedLookupDataSet.Next;
        if UsedLookupDataSet.EOF then UsedLookupDataSet.First;
      end else
        UsedLookupDataSet.First;
    end else
    begin //Go Backward
      if not UsedLookupDataSet.BOF then
      begin
        UsedLookupDataSet.Prior;
        if UsedLookupDataSet.BOF then UsedLookupDataSet.Last;
      end else
        UsedLookupDataSet.Last;
    end;
    UpdateDataValues(Text, UsedLookupDataSet.FieldValues[Field.LookUpKeyFields], False);
//?    Field.Text := UsedLookupDataSet.FieldByName(Field.LookUpResultField).Text;
  end else if Field.DataType in [ftSmallint, ftInteger, ftWord, ftFloat, ftCurrency, ftBCD{$IFDEF EH_LIB_6}, ftFMTBcd{$ENDIF}] then
  begin
    if Field.IsNull
      then AValue := -Increment
      else AValue := Field.Value;
    try
      UpdateDataValues(Text, AValue + Increment, False);
    except
      on EDatabaseError do ; //Noshow RangeError
    else
      raise;
    end;
  end;
end;

function TAxisBarEh.CanEditAcceptKey(Key: Char): Boolean;
begin
  if Assigned(Field) then
  begin
    if Assigned(FKeyList) and (FKeyList.Count > 0)
      then Result := True
      else Result := Field.IsValidChar(Key)
  end
  else if Assigned(FOnUpdateData) then
    Result := True
  else
    Result := False;
end;

function TAxisBarEh.GetAcceptableEditText(InputEditText: String): String;
var
  OutText: String;
  i,k: Integer;
begin
  OutText := InputEditText;
  k := 1;
  for i := 1 to Length(InputEditText) do
    if CanEditAcceptKey(InputEditText[i]) then
    begin
      OutText[k] := InputEditText[i];
      Inc(k);
    end;
  Result := Copy(OutText, 1, k-1);    
end;

function TAxisBarEh.CanModify(TryEdit: Boolean): Boolean;
var
  AField: TField;
  AFields: TListOfFieldsEh;
  Par: TAxisColCellParamsEh;
begin
  Result := True;
  AField := nil;
  if Assigned(Grid) then
    Result := Result and not Grid.ReadOnly
      and Grid.FDatalink.Active and not Grid.FDatalink.ReadOnly;
  Result := Result and not ReadOnly;
  if LookupParams.LookupActive {(Field.FieldKind = fkLookUp)} then
  begin
    Result := Result and (LookupParams.KeyFieldNames <> '');
    AFields := TListOfFieldsEh.Create;
    try
      Grid.DataLink.Dataset.GetFieldList(AFields, LookupParams.KeyFieldNames);
      if AFields.Count > 0 then
      begin
        AField := TField(AFields[0]);
        Result := Result and FieldsCanModify(AFields);
      end else
        Result := False;
    finally
      AFields.Free;
    end;
    //AField := Field.DataSet.FieldByName(Field.KeyFields);
  end else if Assigned(Field) then
    AField := Field
  else
    Result := False;

  if Result then
    Result := Result and AField.CanModify and
      ((not AField.IsBlob or Assigned(AField.OnSetText)) or
      ((Grid.DrawMemoText = True) and (AField.DataType in MemoTypes))) and
      Grid.AllowedOperationUpdate;

//  if Result then
  Par := FCheckModifyColCellParamsEh;
//  with FCheckModifyColCellParamsEh do
  begin
    FillColCellParams(Par);
    Par.FReadOnly := not Result;
    GetColCellParams(True, Par);
    Result := not Par.FReadOnly;
  end;

  if TryEdit and Result and Assigned(Grid) then
  begin
    Grid.FDatalink.Edit;
    Result := Grid.FDatalink.Editing;
    if Result then Grid.FDatalink.Modified;
  end;
end;

function FormatFieldDisplayValue(Field: TField; DisplayFormat: String): String;
begin
  if DisplayFormat = '' then
    Result := Field.DisplayText
  else if Field.IsNull then
    Result := ''
  else if Field is TNumericField then
    Result := FormatFloat(DisplayFormat, Field.AsFloat)
  else if Field is TDateTimeField then
    DateTimeToString(Result, DisplayFormat, Field.AsDateTime)
{$IFDEF FPC}
{$ELSE}
  {$IFDEF EH_LIB_6}
  else if Field is TSQLTImeStampField then
    DateTimeToString(Result, DisplayFormat, Field.AsDateTime)
  {$ENDIF}
  else if (Field is TAggregateField) and (TAggregateField(Field).ResultType in [ftFloat, ftCurrency]) then
     Result := FormatFloat(DisplayFormat, Field.Value)
  else if (Field is TAggregateField) and (TAggregateField(Field).ResultType in [ftDate, ftTime, ftDatetime]) then
    DateTimeToString(Result, DisplayFormat, Field.Value)
{$ENDIF}
  else
    Result := '';
end;

function TAxisBarEh.DisplayText: String;
var KeyIndex: Integer;

  function LocateKey(Field: TField): Boolean;
  begin
    Result := False;
    if (Field.LookupDataSet <> nil) and Field.LookupDataSet.Active then
    begin
      Result := Field.Value <> Null;
    end;
  end;

begin
  Result := '';
  if LookupParams.LookupActive and Grid.DataLink.Active then
  begin
    if DropDownSpecRow.Visible and
      (VarEquals(Grid.DataLink.DataSet.FieldValues[LookupParams.KeyFieldNames], DropDownSpecRow.Value)
      or
      (DropDownSpecRow.ShowIfNotInKeyList and not LocateKey(Field)))
    then
      Result := DropDownSpecRow.CellText[0]
    else
      Result := VarToStr(LookupParams.GetLookupValue);
  end else
  begin
    if not Assigned(Field) then Exit;
    if GetBarType = ctKeyImageList then Exit;
    if Assigned(KeyList) and (KeyList.Count > 0) then
    begin
      KeyIndex := KeyList.IndexOf(Field.Text);
      if (KeyIndex > -1) and (KeyIndex < PickList.Count) then
        Result := PickList.Strings[KeyIndex]
      else if (NotInKeylistIndex >= 0) and (NotInKeylistIndex < PickList.Count) then
        Result := PickList.Strings[NotInKeylistIndex];
    end
    else if Assigned(Grid) and (Grid.DrawMemoText = True) and (Field.DataType in MemoTypes)
      then Result := Field.AsString
    else
      Result := FormatFieldDisplayValue(Field, DisplayFormat);
  end;
end;

function TAxisBarEh.EditText: String;
begin
  Result := '';
//  if not Assigned(Field) then Exit;
  if GetBarType = ctKeyImageList then Exit;
  if Assigned(KeyList) and (KeyList.Count > 0) then
    Result := DisplayText
  else if Assigned(Grid) and (Grid.DrawMemoText = True) and (Field.DataType in MemoTypes)
    then Result := Field.AsString
  else if GetBarType = ctLookupField then
    Result := DisplayText
  else if Field <> nil then
    Result := Field.Text;
end;

function TAxisBarEh.EditValue: Variant;
begin
  Result := Null;
//  if not Assigned(Field) then Exit;
  if Assigned(KeyList) and (KeyList.Count > 0) then
    Result := DisplayText
  else if Assigned(Grid) and (Grid.DrawMemoText = True) and (Field.DataType in MemoTypes) then
    Result := Field.AsString
  else if GetBarType = ctLookupField then
    Result := DisplayText
  else if Field <> nil then
    Result := Field.Value;
end;

procedure TAxisBarEh.CopyValueToClipboard;
var
  Picture: TPicture;
begin
  if GetBarType = ctGraphicData then
  begin
    Picture := Grid.GetPictureForField(Self);
    try
      if Picture.Graphic <> nil then
        Clipboard.Assign(Picture);
    finally
      Picture.Free;
    end;
  end else
    Clipboard.AsText := EditText;
end;

procedure TAxisBarEh.CutValueToClipboard;
begin
  CopyValueToClipboard;
  ClearValue;
end;

procedure TAxisBarEh.PasteValueFromClipboard;
var
  Picture: TPicture;
begin
  if not Assigned(Field) then Exit;

  if GetBarType = ctGraphicData then
  begin
    Picture := TPicture.Create;
    try
      if Clipboard.HasFormat(CF_BITMAP) then
      begin
        Field.DataSet.Edit;
        Picture.Bitmap.Assign(Clipboard);
        Field.Assign(Picture.Graphic);
      end;
    finally
      Picture.Free;
    end;
  end else
  begin
    Field.DataSet.Edit;
    Field.AsString := Clipboard.AsText;
  end;
end;

procedure TAxisBarEh.ClearValue;
begin
  if Assigned(Field) then
  begin
    Field.DataSet.Edit;
    Field.Clear;
  end;
end;

procedure TAxisBarEh.LoadFromFileDialog;
var
  OpenDialog: TOpenPictureDialog;
  Picture: TPicture;
begin
  if not Assigned(Field) then Exit;

  if GetBarType = ctGraphicData then
  begin
    OpenDialog := TOpenPictureDialog.Create(nil);
    try
      OpenDialog.Title := SLoadPictureTitle;
      if OpenDialog.Execute then
      begin
        if Grid.DataLink.Edit then
        begin
          Picture := TPicture.Create;
          try
            Picture.LoadFromFile(OpenDialog.Filename);
            Field.Assign(Picture.Graphic);
          finally
            Picture.Free;
          end;
        end;
      end;
    finally
      OpenDialog.Free;
    end;
  end;
end;

procedure TAxisBarEh.SaveToFileDialog;
begin

end;

function TAxisBarEh.GetCheckboxes: Boolean;
begin
  if cvCheckboxes in FAssignedValues
    then Result := FCheckboxes
    else Result := DefaultCheckboxes;
end;

procedure TAxisBarEh.SetCheckboxes(const Value: Boolean);
begin
  if (cvCheckboxes in FAssignedValues) and (Value = FCheckboxes) then Exit;
  FCheckboxes := Value;
  Include(FAssignedValues, cvCheckboxes);
  Changed(False);
end;

function TAxisBarEh.DefaultCheckboxes: Boolean;
begin
  if Assigned(Field) and (Field.DataType = ftBoolean)
    then Result := True
    else Result := False;
end;

function TAxisBarEh.GetCheckboxState: TCheckBoxState;
var
  Text: string;

  function ValueMatch(const ValueList, Value: string): Boolean;
  var
    Pos: Integer;
  begin
    Result := False;
    if (ValueList = '') and (Value = '') then
    begin
      Result := True;
      Exit;
    end;
    Pos := 1;
    while Pos <= Length(ValueList) do
      if NlsCompareText(ExtractFieldName(ValueList, Pos), Value) = 0 then
      begin
        Result := True;
        Break;
      end;
    if not Result and ((Pos > 1)
                   and (Pos = Length(ValueList) + 1)
                   and (ValueList[Pos-1] = ';'))
    then
      Result := (Value = '');
  end;

begin
  Result := cbGrayed;
  if Field <> nil then
  begin
    if (Field.DataType = ftBoolean) and (KeyList.Count = 0) then
    begin
      if Field.IsNull then
        Result := cbGrayed
      else if Field.DataType = ftBoolean then
        if Field.AsBoolean
          then Result := cbChecked
          else Result := cbUnchecked
    end else if (Field.DataType in
      [ftInteger, ftSmallint, ftFloat, ftBCD, ftCurrency {$IFDEF EH_LIB_6}, ftFMTBcd{$ENDIF} ])
      and (KeyList.Count = 0) then
    begin
      if Field.IsNull then
        Result := cbGrayed
      else if Field.AsFloat = 1
        then Result := cbChecked
        else Result := cbUnchecked
    end else
    begin
      Result := cbGrayed;
      Text := Field.Text;
      if (KeyList.Count > 0) and ValueMatch(KeyList[0], Text) then
        Result := cbChecked
      else if (KeyList.Count > 1) and ValueMatch(KeyList[1], Text) then
        Result := cbUnchecked;
    end;
  end else
    Result := cbUnchecked;
end;

procedure TAxisBarEh.SetCheckboxState(const Value: TCheckBoxState);
var S: String;
  Pos: Integer;
begin
  if not Assigned(Field) then Exit;
  if Value = cbGrayed then
    //Field.Clear
    UpdateDataValues('', Null, False)
  else
    if (Field.DataType = ftBoolean) then
      if Value = cbChecked
        then UpdateDataValues('', True, False)
        else UpdateDataValues('', False, False)
    else if (Field.DataType in
      [ftInteger, ftSmallint, ftFloat, ftBCD, ftCurrency {$IFDEF EH_LIB_6}, ftFMTBcd{$ENDIF} ])
      and (KeyList.Count = 0) then
      if Value = cbChecked
        then UpdateDataValues('', 1, False)
        else UpdateDataValues('', 0, False)
    else
    begin
      if Value = cbChecked then
        if KeyList.Count > 0 then S := KeyList[0] else S := ''
      else
        if KeyList.Count > 1 then S := KeyList[1] else S := '';
      Pos := 1;
      //Field.Text := ExtractFieldName(S, Pos);
      S := ExtractFieldName(S, Pos);
      UpdateDataValues(S, S, True);
    end;
end;

function TAxisBarEh.IsCheckboxesStored: Boolean;
begin
  Result := (cvCheckboxes in FAssignedValues);
end;

function TAxisBarEh.IsIncrementStored: Boolean;
begin
  Result := FIncrement <> 1.0;
end;

function TAxisBarEh.GetToolTips: Boolean;
begin
  if cvToolTips in FAssignedValues
    then Result := FToolTips
    else Result := DefaultToolTips;
end;

procedure TAxisBarEh.SetToolTips(const Value: Boolean);
begin
  if (cvToolTips in FAssignedValues) and (Value = FToolTips) then Exit;
  FToolTips := Value;
  Include(FAssignedValues, cvToolTips);
end;

function TAxisBarEh.GetAlwaysShowEditButton: Boolean;
begin
  if cvAlwaysShowEditButton in FAssignedValues
    then Result := FAlwaysShowEditButton
    else Result := DefaultAlwaysShowEditButton;
end;

function TAxisBarEh.IsAlwaysShowEditButtonStored: Boolean;
begin
  Result := (cvAlwaysShowEditButton in FAssignedValues) and
    (FAlwaysShowEditButton <> DefaultAlwaysShowEditButton);
end;

function TAxisBarEh.DefaultAlwaysShowEditButton: Boolean;
begin
  if GetGrid <> nil
    then Result := GetGrid.AxisBarDefValues.AlwaysShowEditButton
    else Result := False;
end;

function TAxisBarEh.GetEditMask: string;
begin
  Result := '';
  if Grid.Datalink.Active then
    if EditMask <> '' then
      Result := EditMask
    else if Assigned(Field) and not (Assigned(KeyList) and (KeyList.Count > 0)) then
      Result := Field.EditMask;
end;

function TAxisBarEh.GetEditText: String;
var
  KeyIndex: Integer;
  ColCellParamsEh: TAxisColCellParamsEh;

  function LocateKey(AxisBar: TAxisBarEh): Boolean;
  begin
    Result := False;
    if (AxisBar.Field <> nil) and (AxisBar.UsedLookupDataSet <> nil) and
       AxisBar.UsedLookupDataSet.Active then
    begin
      Result := AxisBar.FullListDataSet{UsedLookupDataSet}.Locate(AxisBar.Field.LookupKeyFields,
        AxisBar.Field.DataSet.FieldValues[AxisBar.Field.KeyFields], [loCaseInsensitive]);
    end;
  end;

begin
  Result := '';
  if Grid.Datalink.Active then
  begin
    if LookupParams.LookupIsSetUp and (LookupParams.KeyFieldNames <> '') {(Field.FieldKind = fkLookup) and (Field.KeyFields <> '')} then
    begin
      if DropDownSpecRow.Visible and
        (VarEquals(Grid.Datalink.DataSet.FieldValues[LookupParams.KeyFieldNames], DropDownSpecRow.Value)
        or
        (DropDownSpecRow.ShowIfNotInKeyList and not LocateKey(Self))
        )
        then
      begin
        Grid.FEditKeyValue := DropDownSpecRow.Value;
        Result := DropDownSpecRow.CellText[0];
      end else
        Grid.FEditKeyValue := Grid.DataSource.DataSet.FieldValues[LookupParams.KeyFieldNames];
      Result := DisplayText;
    end else if Assigned(Field) then
    begin
      Grid.FEditKeyValue := Null;
      if Assigned(KeyList) and (KeyList.Count > 0) then
      begin
        KeyIndex := KeyList.IndexOf(Field.Text);
        if (KeyIndex > -1) and (KeyIndex < PickList.Count) then
          Result := PickList.Strings[KeyIndex];
      end
      else if (Grid.DrawMemoText = True) and (Field.DataType in MemoTypes) then
        Result := AdjustLineBreaks(Field.AsString)
      else
        Result := Field.Text;
    end;

    ColCellParamsEh := TAxisColCellParamsEh.Create;
    ColCellParamsEh.FText := Result;
    ColCellParamsEh.FFont := Grid.Canvas.Font;
    GetColCellParams(True, ColCellParamsEh);
    Result := ColCellParamsEh.FText;
    ColCellParamsEh.Free;
  end;
  Grid.FEditText := Result;
end;

procedure TAxisBarEh.SetEditText(const Value: string);
begin
  Grid.FEditText := Value;
end;

function TAxisBarEh.GetEndEllipsis: Boolean;
begin
  if cvEndEllipsis in FAssignedValues
    then Result := FEndEllipsis
    else Result := DefaultEndEllipsis;
end;

function TAxisBarEh.IsEndEllipsisStored: Boolean;
begin
  Result := (cvEndEllipsis in FAssignedValues) and (FEndEllipsis <> DefaultEndEllipsis);
end;

function TAxisBarEh.DefaultEndEllipsis: Boolean;
begin
  if GetGrid <> nil
    then Result := GetGrid.AxisBarDefValues.EndEllipsis
    else Result := False;
end;

function TAxisBarEh.GetAutoDropDown: Boolean;
begin
  if cvAutoDropDown in FAssignedValues
    then Result := FAutoDropDown
    else Result := DefaultAutoDropDown;
end;

function TAxisBarEh.IsAutoDropDownStored: Boolean;
begin
  Result := (cvAutoDropDown in FAssignedValues) and (FAutoDropDown <> DefaultAutoDropDown);
end;

function TAxisBarEh.DefaultAutoDropDown: Boolean;
begin
  if GetGrid <> nil
    then Result := GetGrid.AxisBarDefValues.AutoDropDown
    else Result := False;
end;

function TAxisBarEh.GetDblClickNextVal: Boolean;
begin
  if cvDblClickNextVal in FAssignedValues
    then Result := FDblClickNextVal
    else Result := DefaultDblClickNextVal;
end;

function TAxisBarEh.IsDblClickNextValStored: Boolean;
begin
  Result := (cvDblClickNextVal in FAssignedValues) and (FDblClickNextVal <> DefaultDblClickNextVal);
end;

procedure TAxisBarEh.SetDblClickNextVal(const Value: Boolean);
begin
  if (cvDblClickNextVal in FAssignedValues) and (Value = FDblClickNextVal) then Exit;
  FDblClickNextVal := Value;
  Include(FAssignedValues, cvDblClickNextVal);
end;

function TAxisBarEh.DefaultDblClickNextVal: Boolean;
begin
  if GetGrid <> nil
    then Result := GetGrid.AxisBarDefValues.DblClickNextVal
    else Result := False;
end;

function TAxisBarEh.IsToolTipsStored: Boolean;
begin
  Result := (cvToolTips in FAssignedValues) and (FToolTips <> DefaultToolTips);
end;

function TAxisBarEh.DefaultToolTips: Boolean;
begin
  if GetGrid <> nil
    then Result := GetGrid.AxisBarDefValues.ToolTips
    else Result := False;
end;

function TAxisBarEh.GetDropDownSizing: Boolean;
begin
  if cvDropDownSizing in FAssignedValues
    then Result := FDropDownSizing
    else Result := DefaultDropDownSizing;
end;

function TAxisBarEh.IsDropDownSizingStored: Boolean;
begin
  Result := (cvDropDownSizing in FAssignedValues) and (FDropDownSizing <> DefaultDropDownSizing);
end;

procedure TAxisBarEh.SetDropDownSizing(const Value: Boolean);
begin
  if (cvDropDownSizing in FAssignedValues) and (Value = FDropDownSizing) then Exit;
  FDropDownSizing := Value;
  Include(FAssignedValues, cvDropDownSizing);
//  Changed(False);
end;

function TAxisBarEh.DefaultDropDownSizing: Boolean;
begin
  if GetGrid <> nil
    then Result := GetGrid.AxisBarDefValues.DropDownSizing
    else Result := False;
end;

function TAxisBarEh.GetDropDownShowTitles: Boolean;
begin
  if cvDropDownShowTitles in FAssignedValues
    then Result := FDropDownShowTitles
    else Result := DefaultDropDownShowTitles;
end;

function TAxisBarEh.IsDropDownShowTitlesStored: Boolean;
begin
  Result := (cvDropDownShowTitles in FAssignedValues) and (FDropDownShowTitles <> DefaultDropDownShowTitles);
end;

procedure TAxisBarEh.SetDropDownShowTitles(const Value: Boolean);
begin
  if (cvDropDownShowTitles in FAssignedValues) and (Value = FDropDownShowTitles) then Exit;
  FDropDownShowTitles := Value;
  Include(FAssignedValues, cvDropDownShowTitles);
//  Changed(False);
end;

function TAxisBarEh.DefaultDropDownShowTitles: Boolean;
begin
  if GetGrid <> nil
    then Result := GetGrid.AxisBarDefValues.DropDownShowTitles
    else Result := False;
end;

procedure TAxisBarEh.GetColCellParams(EditMode: Boolean; ColCellParamsEh: TAxisColCellParamsEh);
begin
  raise Exception.Create(' TAxisBarEh.GetColCellParams must be realized in the inherited class.')
end;

procedure TAxisBarEh.FillColCellParams(ColCellParamsEh: TAxisColCellParamsEh);
begin
  with ColCellParamsEh do
  begin
    Grid.GetColRowForAxisCol(Self, FCol, FRow);
    FState := [];
    FFont := Grid.FDummiFont;
    Background := Self.Color;
    Alignment := Self.Alignment;
    ImageIndex := Self.GetImageIndex;
    Text := Self.DisplayText;
    CheckboxState := Self.CheckboxState;
    FReadOnly := Self.ReadOnly;
    FTextEditing := Self.TextEditing;
    FBlankCell := False;
  end;
end;

function TAxisBarEh.GetImageIndex: Integer;
begin
  Result := -1;
  if Assigned(Field) then
  begin
    if KeyList.Count > 0 then
      Result := KeyList.IndexOf(Field.Text)
    else if PickList.Count > 0 then
      Result := PickList.IndexOf(Field.Text)
    else if not Field.IsNull and IsFieldTypeNumeric(Field.DataType) then
      Result := SafeGetFieldAsInteger(Field, -1);
    if Result = -1 then
      Result := NotInKeyListIndex;
  end;
end;

procedure TAxisBarEh.UpdateDataValues(Text: String; Value: Variant; UseText: Boolean);
var
  Processed: Boolean;
  DataLinkInUpdateData: Boolean;
begin
  if Grid <> nil then
  begin
    Processed := False;
    DataLinkInUpdateData := False;
    if not Grid.DataLink.FInUpdateData then
    begin
      DataLinkInUpdateData := True;
      Grid.DataLink.FInUpdateData := True;
    end;
    try
    if Assigned(FOnUpdateData) then FOnUpdateData(Self, Text, Value, UseText, Processed);
    if Processed then
      Exit;
    if (Field = nil) and not LookupParams.LookupActive then
      Exit;
    if not UseText then
    begin
      if LookupParams.LookupActive { (Field.FieldKind = fkLookup) and (Field.KeyFields <> '')}
        then DataSetSetFieldValues(Grid.DataSource.DataSet, LookupParams.KeyFieldNames, Value)
        else Field.Value := Value;
    end else if (Grid.DrawMemoText = True) and (Field.DataType in MemoTypes)
      then Field.AsString := Text
    else
      Field.Text := Text;
    if MRUList.AutoAdd and MRUList.Active and
       Grid.InplaceEditorVisible and Grid.InplaceEditor.Showing
    then
      MRUList.Add(Text);
    finally
      if DataLinkInUpdateData then
        Grid.DataLink.FInUpdateData := False;
    end;
  end;
end;

procedure TAxisBarEh.SetValueAsText(const StrVal: String);
begin
  UpdateDataValues(StrVal, Variant(StrVal), True);
end;

procedure TAxisBarEh.SetValueAsVariant(VarVal: Variant);
begin
  UpdateDataValues('', VarVal, False);
end;

procedure TAxisBarEh.DropDown;
begin
  if Assigned(Grid) and Grid.InplaceEditorVisible and
    (Grid.InplaceEditor is TDBAxisGridInplaceEdit)
  then
    TDBAxisGridInplaceEdit(Grid.InplaceEditor).DropDown;
end;

procedure TAxisBarEh.SetEditButtons(const Value: TEditButtonsEh);
begin
  FEditButtons.Assign(Value);
end;

procedure TAxisBarEh.SetEditButton(const Value: TAxisBarMainEditButtonEh);
begin
  FEditButton.Assign(Value);
end;

function TAxisBarEh.CreateFirstEditButton: TAxisBarMainEditButtonEh;
begin
  Result := TAxisBarMainEditButtonEh.Create(Self);
end;

function TAxisBarEh.CreateEditButton: TEditButtonEh;
begin
  Result := TEditButtonEh.Create(TWinControl(nil));
end;

function TAxisBarEh.CreateEditButtons: TEditButtonsEh;
begin
  Result := TEditButtonsEh.Create(Self, TVisibleEditButtonEh);
end;

procedure TAxisBarEh.EditButtonChanged(Sender: TObject);
begin
  Changed(False);
end;

function TAxisBarEh.EditButtonsWidth: Integer;
var
  i: Integer;
  Flat: Boolean;
begin
  Result := 0;
  if (Grid <> nil) and (Grid.Flat)
    then Flat := True
    else Flat := False;
//  if GetColumnEditStile(Self) <> esSimple then
  if EditButton.Visible then
  begin
    if EditButton.Width <> 0 then
      Result := EditButton.Width
    else if Flat then
    begin
      Inc(Result, FlatButtonWidth);
      if not ThemesEnabled then
        Inc(Result);
    end else
      Inc(Result, GetSystemMetrics(SM_CXVSCROLL));
  end;
  for i := 0 to EditButtons.Count - 1 do
    if EditButtons[i].Visible then
    begin
      if EditButtons[i].Width = 0 then
        if Flat
          then Inc(Result, FlatButtonWidth)
          else Inc(Result, GetSystemMetrics(SM_CXVSCROLL))
      else
        Inc(Result, EditButtons[i].Width);
      if Flat and not ThemesEnabled then Inc(Result, 1);
    end;
end;

procedure TAxisBarEh.SetDropDownSpecRow(const Value: TSpecRowEh);
begin
  FDropDownSpecRow.Assign(Value);
end;

procedure TAxisBarEh.SpecRowChanged(Sender: TObject);
begin
  Changed(False);
  if Assigned(FDataList) then
    TPopupDataGridEh(FDataList).SpecRow := DropDownSpecRow;
end;

function TAxisBarEh.SeenPassthrough: Boolean;
begin
  Result := not IsStored;
end;

function TAxisBarEh.GetDataList: TCustomDBAxisGridEh;
begin
  if FDataList = nil then
  begin
    FDataList := TPopupDataGridEh.Create(nil);
    FDataList.Name := 'DataList'; 
  end;
  Result := FDataList;
end;

{$IFNDEF CIL}
{$IFDEF FPC}
function TAxisBarEh.QueryInterface(constref IID: TGUID; out Obj): HResult;
{$ELSE}
function TAxisBarEh.QueryInterface(const IID: TGUID; out Obj): HResult;
{$ENDIF}
begin
  if GetInterface(IID, Obj)
    then Result := 0
    else Result := E_NOINTERFACE;
end;

function TAxisBarEh._AddRef: Integer;
begin
  Result := -1;
end;

function TAxisBarEh._Release: Integer;
begin
  Result := -1;
end;
{$ENDIF}

procedure TAxisBarEh.SetDropDownBoxListSource(AListSource: TDataSource);
begin
  if AListSource <> nil then AListSource.FreeNotification(GetGrid);
end;

procedure TAxisBarEh.SetDropDownFormParams(const Value: TDropDownFormCallParamsEh);
begin
  FDropDownFormParams.Assign(Value);
end;

function TAxisBarEh.GetLookupGrid: TCustomDBAxisGridEh;
begin
  Result := DataList;
end;

function TAxisBarEh.GetOptions: TDBLookupGridEhOptions;
begin
  Result := TDBLookupGridEh(DataList).Options;
end;

procedure TAxisBarEh.SetOptions(Value: TDBLookupGridEhOptions);
begin
  TDBLookupGridEh(DataList).Options := Value;
end;

procedure TAxisBarEh.SetDropDownBox(const Value: TColumnDropDownBoxEh);
begin
  FDropDownBox.Assign(Value);
end;

function TAxisBarEh.GetOnDropDownBoxCheckButton: TDropDownBoxCheckTitleEhBtnEvent;
begin
  Result := TDropDownBoxCheckTitleEhBtnEvent(TPopupDataGridEh(DataList).OnCheckButton);
end;

function TAxisBarEh.GetOnDropDownBoxDrawColumnCell: TDropDownBoxDrawColumnEhCellEvent;
begin
  Result := TDropDownBoxDrawColumnEhCellEvent(TPopupDataGridEh(DataList).OnDrawColumnCell);
end;

function TAxisBarEh.GetOnDropDownBoxGetCellParams: TDropDownBoxGetCellEhParamsEvent;
begin
  Result := TDropDownBoxGetCellEhParamsEvent(TPopupDataGridEh(DataList).OnGetCellParams);
end;

function TAxisBarEh.GetOnDropDownBoxSortMarkingChanged: TNotifyEvent;
begin
  Result := TPopupDataGridEh(DataList).OnSortMarkingChanged;
end;

function TAxisBarEh.GetOnDropDownBoxTitleBtnClick: TDropDownBoxTitleEhClickEvent;
begin
  Result := TDropDownBoxTitleEhClickEvent(TPopupDataGridEh(DataList).OnTitleBtnClick);
end;

procedure TAxisBarEh.SetOnDropDownBoxCheckButton(const Value: TDropDownBoxCheckTitleEhBtnEvent);
begin
  TPopupDataGridEh(DataList).OnCheckButton := TCheckTitleEhBtnEvent(Value);
end;

procedure TAxisBarEh.SetOnDropDownBoxDrawColumnCell(const Value: TDropDownBoxDrawColumnEhCellEvent);
begin
  TPopupDataGridEh(DataList).OnDrawColumnCell := TDrawColumnEhCellEvent(Value);
end;

procedure TAxisBarEh.SetOnDropDownBoxGetCellParams(const Value: TDropDownBoxGetCellEhParamsEvent);
begin
  TPopupDataGridEh(DataList).OnGetCellParams := TGetCellEhParamsEvent(Value);
end;

procedure TAxisBarEh.SetOnDropDownBoxSortMarkingChanged(const Value: TNotifyEvent);
begin
  TPopupDataGridEh(DataList).OnSortMarkingChanged := Value;
end;

procedure TAxisBarEh.SetOnDropDownBoxTitleBtnClick(const Value: TDropDownBoxTitleEhClickEvent);
begin
  TPopupDataGridEh(DataList).OnTitleBtnClick := TTitleEhClickEvent(Value);
end;

procedure TAxisBarEh.SetMRUList(const Value: TMRUListEh);
begin
  FMRUList.Assign(Value);
end;

function TAxisBarEh.UsedLookupDataSet: TDataSet;
begin
  if Assigned(DropDownBox.ListSource) and Assigned(DropDownBox.ListSource.DataSet) then
    Result := DropDownBox.ListSource.DataSet
  else if LookupParams.LookupIsSetUp {Assigned(Field)} then
    Result := LookupParams.LookupDataSet {Field.LookupDataSet}
  else
    Result := nil;
end;

function TAxisBarEh.FullListDataSet: TDataSet;
begin
  Result := nil;
  if Field <> nil then
    Result := Field.LookupDataSet;
end;

procedure TAxisBarEh.SetDisplayFormat(const Value: string);
begin
  if FDisplayFormat <> Value then
  begin
    FDisplayFormat := Value;
    Changed(False);
  end;
end;

procedure TAxisBarEh.SetEditMask(const Value: string);
begin
  if FEditMask <> Value then
  begin
    FEditMask := Value;
    Changed(False);
  end;
end;

function TAxisBarEh.GetShowImageAndText: Boolean;
begin
  Result := FShowImageAndText;
end;

procedure TAxisBarEh.SetShowImageAndText(const Value: Boolean);
begin
  if FShowImageAndText <> Value then
  begin
    FShowImageAndText := Value;
    Changed(False);
  end;
end;

procedure TAxisBarEh.Changed(AllItems: Boolean);
begin
  inherited Changed(AllItems);
end;

function TAxisBarEh.CalcRowHeight: Integer;
begin
  Result := 0;
end;

function TAxisBarEh.GetLayout: TTextLayout;
begin
  if cvLayout in FAssignedValues
    then Result := FLayout
    else Result := DefaultLayout;
end;

procedure TAxisBarEh.SetLayout(Value: TTextLayout);
begin
  if (cvLayout in FAssignedValues) and (Value = FLayout) then Exit;
  FLayout := Value;
  Include(FAssignedValues, cvLayout);
  Changed(False);
end;

function TAxisBarEh.IsLayoutStored: Boolean;
begin
  Result := (cvLayout in FAssignedValues) and (FLayout <> DefaultLayout);
end;

function TAxisBarEh.DefaultLayout: TTextLayout;
begin
  if GetGrid <> nil
    then Result := GetGrid.AxisBarDefValues.Layout
    else Result := tlTop;
end;

function TAxisBarEh.IsHighlightRequiredStored: Boolean;
begin
  Result := (cvHighlightRequired in FAssignedValues) and (FHighlightRequired <> DefaultHighlightRequired);
end;

function TAxisBarEh.GetHighlightRequired: Boolean;
begin
  if cvHighlightRequired in FAssignedValues
    then Result := FHighlightRequired
    else Result := DefaultHighlightRequired;
end;

procedure TAxisBarEh.SetHighlightRequired(Value: Boolean);
begin
  if (cvHighlightRequired in FAssignedValues) and (Value = FHighlightRequired) then Exit;
  FHighlightRequired := Value;
  Include(FAssignedValues, cvHighlightRequired);
  Changed(False);
end;

function TAxisBarEh.DefaultHighlightRequired: Boolean;
begin
  if GetGrid <> nil
    then Result := GetGrid.AxisBarDefValues.HighlightRequired
    else Result := False;
end;

function TAxisBarEh.GetBiDiMode: TBiDiMode;
begin
  if (cvBiDiMode in FAssignedValues) or (Grid = nil)
    then Result := FBiDiMode
    else Result := Grid.BiDiMode;
end;

procedure TAxisBarEh.SetBiDiMode(Value: TBiDiMode);
begin
  if (cvBiDiMode in FAssignedValues) and (Value = FBiDiMode) then Exit;
  FBiDiMode := Value;
  Include(FAssignedValues, cvBiDiMode);
  Changed(False);
end;

function TAxisBarEh.IsBiDiModeStored: Boolean;
begin
  Result := cvBiDiMode in FAssignedValues;
end;

function TAxisBarEh.DrawTextBiDiModeFlagsReadingOnly: Longint;
begin
  if UseRightToLeftReading
    then Result := DT_RTLREADING
    else Result := 0;
end;

function TAxisBarEh.UseRightToLeftReading: Boolean;
begin
  Result := SysLocale.MiddleEast and (BiDiMode <> bdLeftToRight);
end;

function TAxisBarEh.UseRightToLeftAlignment: Boolean;
begin
  Result := SysLocale.MiddleEast and (BiDiMode = bdRightToLeft);
  if Assigned(Field) then
    Result := Result and OkToChangeFieldAlignment(Field, Alignment);
end;

function TAxisBarEh.UseRightToLeftScrollBar: Boolean;
begin
  Result := SysLocale.MiddleEast and
    (BiDiMode in [bdRightToLeft, bdRightToLeftNoAlign]);
end;

function TAxisBarEh.CurLineWordWrap(RowHeight: Integer): Boolean;
var
  tm: Windows.TTextMetric;
  MinHeight: Integer;
  FontData: TFontDataEh;
  FontChanged: Boolean;
begin
  Result := False;
  if not WordWrap then Exit;

  FontChanged := False;
  {$WARNINGS OFF}
  if Grid.Canvas.Font.Handle <> Font.Handle then
  {$WARNINGS ON}
  begin
    GetFontData(Grid.Canvas.Font, FontData);
    Grid.Canvas.Font := Font;
    FontChanged := True;
  end;
  GetTextMetrics(Grid.Canvas.Handle, tm);
  MinHeight := tm.tmExternalLeading + tm.tmHeight + tm.tmInternalLeading +
    Grid.FInterlinear;
  if (MinHeight < RowHeight)
    then Result := True
    else Result := False;
  if FontChanged then
    SetFontData(FontData, Grid.Canvas.Font);
end;

function TAxisBarEh.GetCellHeight(Row: Integer): Integer;
begin
  Result := Grid.RowHeights[Row];
end;

function TAxisBarEh.GetTextEditing: Boolean;
begin
  if cvTextEditing in FAssignedValues
    then Result := FTextEditing
    else Result := DefaultTextEditing;
end;

procedure TAxisBarEh.SetTextEditing(const Value: Boolean);
begin
  if (cvTextEditing in FAssignedValues) or (Value <> DefaultTextEditing) or
    (Assigned(Grid) and (csLoading in Grid.ComponentState)) then
  begin
    FTextEditing := Value;
    Include(FAssignedValues, cvTextEditing);
  end;
  Changed(False);
end;

function TAxisBarEh.IsTextEditingStored: Boolean;
begin
  Result := (cvTextEditing in FAssignedValues) and (FTextEditing <> DefaultTextEditing);
end;

function TAxisBarEh.DefaultTextEditing: Boolean;
begin
  Result := not (GetBarType in [ctKeyImageList..ctGraphicData]);
end;

function TAxisBarEh.CanEditShow: Boolean;
begin
  FillColCellParams(FCheckModifyColCellParamsEh);
  if not (csLoading in Grid.ComponentState) then
    GetColCellParams(False, FCheckModifyColCellParamsEh);
  Result := FCheckModifyColCellParamsEh.TextEditing;
end;

function TAxisBarEh.IsTabStop: Boolean;
begin
  Result := Visible and not ReadOnly and Grid.DataLink.Active;
  if Result then
    if LookupParams.LookupActive then
      Result := not ReadOnly
    else
      Result := Assigned(Field) and
            not (Field.FieldKind = fkCalculated) and
            not ReadOnlyField(Field);
end;

procedure TAxisBarEh.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
end;

function TAxisBarEh.GetName: String;
begin
  Result := 'Column_' + IntToStr(Index) + '_' + FieldName;
end;

function TAxisBarEh.GetPictureFromBlobField: TPicture;
begin
  Result := nil;
  if Grid <> nil then
    Result := Grid.GetPictureForField(Self);
end;

procedure TAxisBarEh.SetDynProps(const Value: TDynVarsEh);
begin
  FDynProps.Assign(Value);
end;

procedure TAxisBarEh.DropDownBoxApplyTextFilter(DataSet: TDataSet;
  FieldName: String; Operation: TLSAutoFilterTypeEh; FilterText: String);
begin
  DefaultDropDownBoxApplyTextFilter(DataSet, FieldName, Operation, FilterText);
end;

procedure TAxisBarEh.DefaultDropDownBoxApplyTextFilter(DataSet: TDataSet;
  FieldName: String; Operation: TLSAutoFilterTypeEh; FilterText: String);
var
  swc1, swc2: String;
begin
  swc2 := DropDownBox.GetLikeWildcardForSeveralCharacters;
  if Operation = lsftContainsEh
    then swc1 := swc2
    else swc1 := '';
  if DataSet <> nil then
    if FilterText <> '' then
    begin
      DataSet.Filter := '['+FieldName+'] like ''' + swc1 +
        StringReplace(FilterText, '''', '''''', [rfReplaceAll])
        + swc2 + '''';
      DataSet.Filtered := True;
    end else
      DataSet.Filter := '';
end;

function TAxisBarEh.GetDataCellHorzOffset: Integer;
begin
  Result := 3;
end;

function TAxisBarEh.IsDrawEditButton(ACol, ARow: Integer): Boolean;
begin
  Result := False;
  if AlwaysShowEditButton then
    Result := True;
end;

procedure TAxisBarEh.SetTextArea(var CellRect: TRect);
begin
  raise Exception.Create(' TAxisBarEh.SetTextArea must be realized in the inherited class.')
end;

function TAxisBarEh.GetEditButtonPressed: Boolean;
begin
  Result := False;
  if (Grid <> nil) and
     (Grid.InplaceEditor <> nil) and
     (TDBAxisGridInplaceEdit(Grid.InplaceEditor).AxisBar = Self)
  then
    Result := TDBAxisGridInplaceEdit(Grid.InplaceEditor).EditButtonPressed;
end;

procedure TAxisBarEh.SetEditButtonPressed(const Value: Boolean);
begin
  if (Grid <> nil) and
     (Grid.InplaceEditor <> nil) and
     (TDBAxisGridInplaceEdit(Grid.InplaceEditor).AxisBar = Self)
  then
    TDBAxisGridInplaceEdit(Grid.InplaceEditor).EditButtonPressed := Value;
end;

procedure TAxisBarEh.DropDownFormParamsChanged(Sender: TObject);
begin
  if Grid <> nil then
    Grid.Invalidate;
end;

procedure TAxisBarEh.CheckDataIsReadOnly(var ReadOnly: Boolean);
begin
  ReadOnly := not CanModify(False);
end;

function TAxisBarEh.LocatePickList(const Str: String;
  const PartialKey: Boolean): Integer;
var
  LocOpt: TLocateOptions;
begin
  if PartialKey
    then LocOpt := [loPartialKey]
    else LocOpt := [];

  Result := StringsLocate(PickList, Str, LocOpt);
  if (Result < 0) and CaseInsensitiveTextSearch then
  begin
    LocOpt := LocOpt + [loCaseInsensitive];
    Result := StringsLocate(PickList, Str, LocOpt);
  end;
end;

procedure TAxisBarEh.SetLookupParams(const Value: TDBLookupDataEh);
begin
  FLookupParams.Assign(Value);
end;

procedure TAxisBarEh.LookupStateChanged;
begin
  if Grid <> nil then
    Grid.LookupStateChanged(Self);
end;

procedure TAxisBarEh.RecordChanged(Field: TField);
begin
end;

function TAxisBarEh.CreateLookupData: TDBLookupDataEh;
begin
  Result := TDBLookupDataEh.Create(Self);
end;

function TAxisBarEh.GetDropDownBoxListField: String;
begin
  if GetBarType = ctDataList then
  begin
    Result := '';
    if DropDownBox.GetActualListField = '' then
    begin
      if (DropDownBox.ListSource <> nil) and
         (DropDownBox.ListSource.DataSet <> nil) then
      begin
        if (FieldName <> '') and
           (DropDownBox.ListSource.DataSet.FindField(FieldName) <> nil)
        then
          Result := FieldName
        else if DropDownBox.ListSource.DataSet.Fields.Count > 0 then
          Result := DropDownBox.ListSource.DataSet.Fields[0].FieldName;
      end
    end else
      Result := DropDownBox.GetActualListField;
  end else
    Result := LookupParams.LookupDisplayFieldName;
end;

function TAxisBarEh.GetLimitTextToListValues: Boolean;
begin
  if LimitTextToListValuesStored
    then Result := FLimitTextToListValues
    else Result := DefaultLimitTextToListValues;
end;

function TAxisBarEh.IsLimitTextToListValuesStored: Boolean;
begin
  Result := FLimitTextToListValuesStored;
end;

procedure TAxisBarEh.SetLimitTextToListValues(const Value: Boolean);
begin
  if LimitTextToListValuesStored and (Value = FLimitTextToListValues) then Exit;
  LimitTextToListValuesStored := True;
  FLimitTextToListValues := Value;
end;

procedure TAxisBarEh.SetLimitTextToListValuesStored(const Value: Boolean);
begin
  if (Value = True) and (IsLimitTextToListValuesStored = False) then
  begin
    FLimitTextToListValuesStored := True;
    FLimitTextToListValues := DefaultLimitTextToListValues;
  end else if (Value = False) and (IsLimitTextToListValuesStored = True) then
  begin
    FLimitTextToListValuesStored := False;
    FLimitTextToListValues := DefaultLimitTextToListValues;
  end;
end;

function TAxisBarEh.DefaultLimitTextToListValues: Boolean;
begin
  Result := (GetBarType in [ctLookupField, ctKeyPickList]) and not Assigned(OnNotInList);
end;

function TAxisBarEh.IsEditButtonsBoxRequired: Boolean;
begin
  Result := (GetBarType = ctGraphicData) and (TextEditing = False);
end;

function TAxisBarEh.AxisBarRect(const AGridCellRect: TRect): TRect;
begin
  Result := AGridCellRect;
end;

procedure TAxisBarEh.UpdateEditButtonsBox(AEditButtonsBox: TEditButtonsBoxEh;
  const AxisBarRect: TRect);
begin
  if not IsEditButtonsBoxRequired then Exit;
  AEditButtonsBox.OnDown := EditButtonDown;
  AEditButtonsBox.OnClick := EditButtonClick;
  AEditButtonsBox.OnMouseMove := EditButtonMouseMove;
  AEditButtonsBox.OnMouseUp := EditButtonMouseUp;

  UpdateEditButtonControlList(AEditButtonsBox, AxisBarRect);
  UpdateEditButtonControlsState(AEditButtonsBox, AxisBarRect);
end;

procedure TAxisBarEh.UpdateEditButtonControlList(
  AEditButtonsBox: TEditButtonsBoxEh; const AxisBarRect: TRect);
var
  i: Integer;
  AButtonRect: TRect;
begin
  AEditButtonsBox.BeginLayout;

  AEditButtonsBox.ButtonsCount := EditButtons.Count + 1;
  AEditButtonsBox.Flat := Grid.Flat;
  AEditButtonsBox.MaxButtonHeight := AxisBarRect.Bottom - AxisBarRect.Top;

  AEditButtonsBox.BtnCtlList[0].EditButton := EditButton;
  for i := 1 to EditButtons.Count do
    AEditButtonsBox.BtnCtlList[i].EditButton := EditButtons[i - 1];
  AEditButtonsBox.EndLayout;

  AButtonRect := Rect(AxisBarRect.Right-AEditButtonsBox.ButtonsWidth,
                      AxisBarRect.Top,
                      AxisBarRect.Right,
                      AxisBarRect.Bottom);

  if AEditButtonsBox.ButtonsWidth > 0 then
  begin
    AEditButtonsBox.SetBounds(AButtonRect.Left, AButtonRect.Top, AButtonRect.Right-AButtonRect.Left, AButtonRect.Bottom-AButtonRect.Top);
    AEditButtonsBox.Visible := True;
//    ShowWindow(AEditButtonsBox.Handle, SW_SHOWNORMAL);
  end else
  begin
    AEditButtonsBox.Visible := False;
//    ShowWindow(AEditButtonsBox.Handle, SW_HIDE);
  end;
end;

procedure TAxisBarEh.UpdateEditButtonControlsState(
  AEditButtonsBox: TEditButtonsBoxEh; const AxisBarRect: TRect);
var
  i: Integer;
  DefaultActionSet: Boolean;
  AEditButton: TAxisBarMainEditButtonEh;
begin
  AEditButtonsBox.BorderActive := True; { TODO : Check BorderActive }
  AEditButtonsBox.UpdateEditButtonControlsState;

  DefaultActionSet := False;
  if EditButton.Visible then
  begin
    TAxisBarMainEditButtonEh(EditButton).FParentDefinedDefaultAction :=
      (@OnEditButtonClick = nil) and
      (@OnEditButtonDown = nil );
    DefaultActionSet := TAxisBarMainEditButtonEh(EditButton).FParentDefinedDefaultAction
  end else
    TAxisBarMainEditButtonEh(EditButton).FParentDefinedDefaultAction := False;

  for i := 0 to EditButtons.Count-1 do
  begin
    AEditButton := TAxisBarMainEditButtonEh(EditButtons[i]);
    if not DefaultActionSet then
    begin
      AEditButton.FParentDefinedDefaultAction :=
        (@AEditButton.OnClick = nil) and
        (@AEditButton.OnDown = nil );
      DefaultActionSet := EditButton.FParentDefinedDefaultAction;
    end else
      AEditButton.FParentDefinedDefaultAction := False;
  end;
end;

procedure TAxisBarEh.EditButtonClick(Sender: TObject);
var
  Handled: Boolean;
  i: Integer;
  AEditButtonsBox: TEditButtonsBoxEh;
  ABtnCtlList: TEditButtonControlList;
  AEditButton: TEditButtonEh;
begin
  Handled := False;
//  ShowMessage(Sender.ClassName);
  AEditButtonsBox := TControl(Sender).Parent as TEditButtonsBoxEh;
  ABtnCtlList := AEditButtonsBox.BtnCtlList;

  if (ButtonStyle in [cbsEllipsis, cbsDropDown, cbsAltDropDown]) and
    (Sender = ABtnCtlList[0].EditButtonControl)
  then
    Grid.EditButtonClick;

  if Sender = ABtnCtlList[0].EditButtonControl then
  begin
    if Assigned(OnEditButtonClick) then
      OnEditButtonClick(Sender, Handled);
    if not Handled and
       EditButton.DefaultAction
    then
      Grid.EditButtonDefaultAction(Grid, EditButton,
        ABtnCtlList[0].EditButtonControl, False, Handled);

  end else if (Sender is TEditButtonControlEh) then
    for i := 1 to Length(ABtnCtlList) - 1 do
      if (Sender = ABtnCtlList[i].EditButtonControl) then
      begin
        AEditButton := EditButtons[i - 1];
        AEditButton.Click(Sender, Handled);
        if not Handled and
           AEditButton.DefaultAction
        then
          Grid.EditButtonDefaultAction(Grid, AEditButton,
            ABtnCtlList[i].EditButtonControl, False, Handled);
      end;
end;

procedure TAxisBarEh.EditButtonDown(Sender: TObject; TopButton: Boolean;
  var AutoRepeat: Boolean; var Handled: Boolean);
var
  i: Integer;
  p: TPoint;
  AEditButton: TEditButtonEh;
  AEditButtonsBox: TEditButtonsBoxEh;
  ABtnCtlList: TEditButtonControlList;
begin

  Handled := False;
  AEditButtonsBox := TControl(Sender).Parent as TEditButtonsBoxEh;
  ABtnCtlList := AEditButtonsBox.BtnCtlList;
  AEditButtonsBox.Parent.SetFocus;
  if (Sender = ABtnCtlList[0].EditButtonControl) then
  begin
    if Assigned(OnEditButtonDown) then
      OnEditButtonDown(Sender, TopButton, AutoRepeat, Handled);
//    if not Handled then
//      CheckEditButtonDownForDropDownForm(nil, ABtnCtlList[0].EditButtonControl, Handled);
//    if not Handled then
//        ButtonDown(not TopButton);
    if not Handled and
       EditButton.DefaultAction
    then
      Grid.EditButtonDefaultAction(Grid, EditButton,
        ABtnCtlList[0].EditButtonControl, True, Handled);
  end
  else if (Sender is TEditButtonControlEh) then
    for i := 1 to Length(ABtnCtlList) - 1 do
    begin
      if (Sender = ABtnCtlList[i].EditButtonControl) then
      begin
        AEditButton := EditButtons[i - 1];
        if Assigned(AEditButton.OnDown) then
          AEditButton.OnDown(Sender, TopButton, AutoRepeat, Handled);
//        if not Handled then
//          CheckEditButtonDownForDropDownForm(AEditButton, ABtnCtlList[i].EditButtonControl, Handled);
        if not Handled then
          if Assigned(AEditButton.DropdownMenu) then
          begin
            P := TControl(Sender).ClientToScreen(Point(0, TControl(Sender).Height));
            if AEditButton.DropdownMenu.Alignment = paRight then
              Inc(P.X, TControl(Sender).Width);
            AEditButton.DropdownMenu.Popup(p.X, p.y);
            KillMouseUp(TControl(Sender));
            TControl(Sender).Perform(WM_LBUTTONUP, 0, 0);
          end;{ else if FirstVisibleButtonIndex >= i then
            ButtonDown(not TopButton);}
        if not Handled and
           AEditButton.DefaultAction
        then
          Grid.EditButtonDefaultAction(Grid, AEditButton,
            ABtnCtlList[i].EditButtonControl, True, Handled);
      end;
    end;
end;

procedure TAxisBarEh.EditButtonMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
end;

procedure TAxisBarEh.EditButtonMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
end;

function TAxisBarEh.GetPopupMenu: TPopupMenu;
begin
  Result := FPopupMenu;
  if Result = nil then
    Result := GetSystemPopupMenu;
end;

function TAxisBarEh.GetSystemPopupMenu: TPopupMenu;
begin
  if FSystemPopupMenu = nil then
    FSystemPopupMenu := TPopupMenu.Create(nil);
  Result := FSystemPopupMenu;
  FormSystemPopupMenu(Result);
end;

procedure TAxisBarEh.FormSystemPopupMenu(APopupMenu: TPopupMenu);
begin
  APopupMenu.Items.Clear;
  Grid.FormSystemPopupMenuForAxisBar(Self, APopupMenu);
end;

{ TGridAxisBarsEh }

constructor TGridAxisBarsEh.Create(Grid: TCustomDBAxisGridEh; ColumnClass: TAxisBarEhClass);
begin
  inherited Create(ColumnClass);
  FGrid := Grid;
end;

function TGridAxisBarsEh.Add: TAxisBarEh;
begin
  Result := TAxisBarEh(inherited Add);
end;

function TGridAxisBarsEh.GetAxisBar(Index: Integer): TAxisBarEh;
begin
  Result := TAxisBarEh(inherited Items[Index]);
end;

function TGridAxisBarsEh.GetOwner: TPersistent;
begin
  Result := FGrid;
end;

function TGridAxisBarsEh.GetState: TDBGridBarsState;
begin
  if (Count > 0) and Items[0].IsStored
   then Result := csCustomized
   else Result := csDefault;
end;

procedure TGridAxisBarsEh.LoadFromFile(const Filename: string);
var
  S: TFileStream;
begin
  S := TFileStream.Create(Filename, fmOpenRead);
  try
    LoadFromStream(S);
  finally
    S.Free;
  end;
end;

type
  TColumnsWrapper = class(TComponent)
  private
    FAxisBars: TGridAxisBarsEh;
  published
    property AxisBars: TGridAxisBarsEh read FAxisBars write FAxisBars;
  end;

procedure TGridAxisBarsEh.LoadFromStream(S: TStream);
var
  Wrapper: TColumnsWrapper;
begin
  Wrapper := TColumnsWrapper.Create(nil);
  try
    Wrapper.AxisBars := FGrid.CreateAxisBars;
    S.ReadComponent(Wrapper);
    Assign(Wrapper.AxisBars);
  finally
    Wrapper.AxisBars.Free;
    Wrapper.Free;
  end;
end;

procedure TGridAxisBarsEh.RestoreDefaults;
var
  I: Integer;
begin
  BeginUpdate;
  try
    for I := 0 to Count - 1 do
      Items[I].RestoreDefaults;
  finally
    EndUpdate;
  end;
end;

procedure TGridAxisBarsEh.RebuildBars;
begin
  AddAllBars(True);
end;

procedure TGridAxisBarsEh.AddAllBars(DeleteExisting: Boolean);
var
  I: Integer;
  FieldList: TObjectList;
begin
  FieldList := nil;
  if Assigned(FGrid) and Assigned(FGrid.DataSource) and
    Assigned(FGrid.Datasource.Dataset) then
  begin
    FGrid.BeginLayout;
    try
      if DeleteExisting then Clear;
      FieldList := TObjectList.Create(False);
      FGrid.GetDatasetFieldList(FieldList);
      for I := 0 to FieldList.Count - 1 do
        Add.FieldName := TField(FieldList[I]).FieldName
    finally
      FieldList.Free;
      FGrid.EndLayout;
    end
  end
  else
    if DeleteExisting then Clear;
end;

procedure TGridAxisBarsEh.SaveToFile(const Filename: string);
var
  S: TStream;
begin
  S := TFileStream.Create(Filename, fmCreate);
  try
    SaveToStream(S);
  finally
    S.Free;
  end;
end;

procedure TGridAxisBarsEh.SaveToStream(S: TStream);
var
  Wrapper: TColumnsWrapper;
begin
  Wrapper := TColumnsWrapper.Create(nil);
  try
    Wrapper.AxisBars := Self;
    S.WriteComponent(Wrapper);
  finally
    Wrapper.Free;
  end;
end;

procedure TGridAxisBarsEh.SetAxisBar(Index: Integer; Value: TAxisBarEh);
begin
  Items[Index].Assign(Value);
end;

procedure TGridAxisBarsEh.SetState(NewState: TDBGridBarsState);
begin
  if NewState = State then Exit;
  if NewState = csDefault
    then Clear
    else RebuildBars;
end;

procedure TGridAxisBarsEh.Update(Item: TCollectionItem);
begin
// Do it in inehrited class
end;

function TGridAxisBarsEh.InternalAdd: TAxisBarEh;
begin
  Result := Add;
  Result.IsStored := False;
end;

function TGridAxisBarsEh.GetUpdateCount: Integer;
begin
  Result := inherited UpdateCount;
end;

procedure TGridAxisBarsEh.ActiveChanged;
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
  begin
//    Items[i].FieldValueList := nil;
//    Items[i].FField := nil;
    Items[i].LookupParams.UpdateLookupState;
  end;
end;

procedure TGridAxisBarsEh.Assign(Source: TPersistent);
begin
  if Assigned(Grid) then
    Grid.BeginLayout;
  try
    inherited Assign(Source);
  finally
    if Assigned(Grid) then
      Grid.EndLayout;
  end;
end;

function TGridAxisBarsEh.FindBarByName(const ColumnName: String): TAxisBarEh;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count-1 do
  begin
    if Items[i].Name = ColumnName then
    begin
      Result := Items[i];
      Exit;
    end;
  end;
end;

procedure TGridAxisBarsEh.GetBarNames(List: TStrings);
var
  i: Integer;
begin
  for i := 0 to Count-1 do
    List.Add(Items[i].Name);
end;

{$IFDEF EH_LIB_6}
procedure TGridAxisBarsEh.Notify(Item: TCollectionItem; Action: TCollectionNotification);
begin
  if Assigned(Grid) and (Action = cnExtracting) {and (UpdateCount = 0)} then
      Grid.ColumnDeleting(TAxisBarEh(Item));
  if Action = cnAdded then
    BarsNotify(TAxisBarEh(Item), gabnAddedEh)
  else if Action = cnExtracting then
    BarsNotify(TAxisBarEh(Item), gabnExtractingEh);
end;
{$ENDIF}

procedure TGridAxisBarsEh.BarsNotify(Item: TAxisBarEh;
  Action: TGridAxisBarsNotificationEh);
begin

end;

function TGridAxisBarsEh.CheckItemInList(AxisBar: TAxisBarEh): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to Count-1 do
  begin
    if Items[i] = AxisBar then
    begin
      Result := True;
      Exit;
    end;
  end;
end;

function TGridAxisBarsEh.IndexSeenPassthrough: Boolean;
begin
  Result := (State = csDefault);
end;

function TGridAxisBarsEh.CheckAxisBarsToFieldsNoOrders: Boolean;
begin
  Result := True;
end;

{ TGridToolTipsWindowEh }

procedure TGridToolTipsWindowEh.Paint;
var
  R: TRect;
begin
  R := ClientRect;
  Inc(R.Left, 2);
  Inc(R.Top, 2);
  Canvas.Font := Font;
  DrawText(Canvas.Handle, PChar(Caption), -1, R, DT_LEFT or DT_NOPREFIX or
  {$IFDEF FPC}
    DT_WORDBREAK);
  {$ELSE}
    DT_WORDBREAK or DrawTextBiDiModeFlagsReadingOnly);
  {$ENDIF}
end;

procedure TGridToolTipsWindowEh.ActivateHintData(Rect: TRect;
  const AHint: string; AData: Pointer);
begin
  Font := TFont(AData);
  inherited ActivateHintData(Rect, AHint, AData);
end;

function TGridToolTipsWindowEh.CalcHintRect(MaxWidth: Integer; const AHint: string; AData: Pointer): TRect;
begin
  if AData <> nil then
    Canvas.Font.Assign(TFont(AData));
  Canvas.Font.Color := clWindowText;
  Result := inherited CalcHintRect(MaxWidth, AHint, AData);
end;

//{$IFDEF EH_LIB_16}
//class constructor TCustomDBAxisGridEh.Create;
//begin
////  TCustomStyleEngine.RegisterStyleHook(TCustomDBAxisGridEh, TScrollingStyleHook);
//end;
//{$ENDIF}

constructor TCustomDBAxisGridEh.Create(AOwner: TComponent);
begin

  inherited Create(AOwner);
//  inherited DefaultDrawing := False;
  FAcquireFocus := True;
//  VirtualView := True;

  FColumnDefValues := CreateAxisBarDefValues;
  FAxisBars := CreateAxisBars;
  FVisibleAxisBars := TAxisBarsEhList.Create;
  FAllowedOperations := [alopInsertEh, alopUpdateEh, alopDeleteEh, alopAppendEh];

  inherited RowCount := 2;
  inherited ColCount := 2;
  FDataLink := CreateDataLink;
  Color := clWindow;
  ParentColor := False;

  FUserChange := True;
  FDefaultDrawing := True;

  FInterlinear := 4;
  FColCellParamsEh := CreateColCellParamsEh;
  FDummiFont := TFont.Create;

  FDynProps := TDynVarsEh.Create(Self);
  FBorder := TControlBorderEh.Create(Self);

  if (FNoDesigntControler = False) and Assigned(DBGridEhDesigntControler) and (csDesigning in ComponentState) then
  begin
    DBGridEhDesigntControler.RegisterChangeSelectedNotification(Self);
    FDesignInfoCollection := TCollection.Create(DBGridEhDesigntControler.GetDesignInfoItemClass);
  end;

end;

destructor TCustomDBAxisGridEh.Destroy;
begin
  Destroying;
  DataSource := nil;
  FIntMemTable := nil;

  if (FNoDesigntControler = False) and Assigned(DBGridEhDesigntControler) and (csDesigning in ComponentState) then
  begin
    DBGridEhDesigntControler.UnregisterChangeSelectedNotification(Self);
    FreeAndNil(FDesignInfoCollection);
  end;

  FreeAndNil(FColCellParamsEh);
  FreeAndNil(FAxisBars);
  FreeAndNil(FColumnDefValues);
  FreeAndNil(FVisibleAxisBars);
  FreeAndNil(FDataLink);
  FreeAndNil(FDynProps);
  FreeAndNil(FBorder);
  FreeAndNil(FEditButtonsBox);
  inherited Destroy;
  if FHintFont <> nil then FreeAndNil(FHintFont);
  FreeAndNil(FDummiFont);
end;

function TCustomDBAxisGridEh.AcquireFocus: Boolean;
begin
  Result := True;
  if Focused or ((InplaceEditor <> nil) and InplaceEditor.Focused) then
    Exit;
  if FAcquireFocus and CanFocus and not (csDesigning in ComponentState) then
  begin
    SetFocus;
    Result := Focused or ((InplaceEditor <> nil) and InplaceEditor.Focused);
    // VCL Bug is fixed
    if not Result and (Screen.ActiveForm <> nil) and
      (Screen.ActiveForm.FormStyle = fsMDIForm) then
    begin
      Windows.SetFocus(Handle);
      Result := Focused or ((InplaceEditor <> nil) and InplaceEditor.Focused);
    end;
    // VCL Bug is fixed\\
  end;
end;

function TCustomDBAxisGridEh.AcquireLayoutLock: Boolean;
begin
  Result := (FUpdateLock = 0) and (FLayoutLock = 0);
  if Result then BeginLayout;
end;

procedure TCustomDBAxisGridEh.BeginLayout;
begin
  BeginUpdate;
  if FLayoutLock = 0 then AxisBars.BeginUpdate;
  Inc(FLayoutLock);
end;

procedure TCustomDBAxisGridEh.BeginUpdate;
begin
  if FUpdateLock = 0 then
    FLayoutChangedInUpdateLock := False;
  Inc(FUpdateLock);
end;

procedure TCustomDBAxisGridEh.CancelLayout;
begin
  if FLayoutLock > 0 then
  begin
    if FLayoutLock = 1 then
      AxisBars.EndUpdate;
    Dec(FLayoutLock);
    EndUpdate;
  end;
end;

procedure TCustomDBAxisGridEh.EndLayout;
begin
  if FLayoutLock > 0 then
  begin
    try
      try
        if FLayoutLock = 1 then
          InternalLayout;
      finally
        if FLayoutLock = 1 then
        begin
          FAxisBars.EndUpdate;
          FLayoutChangedInUpdateLock := False;
        end;
      end;
    finally
      if FLayoutLock > 0 then
        Dec(FLayoutLock);
      EndUpdate;
      UpdateBoundaries;
    end;
  end;
end;

procedure TCustomDBAxisGridEh.EndUpdate;
begin
  if FUpdateLock > 0
    then Dec(FUpdateLock);
  if (FUpdateLock = 0) and
     FLayoutChangedInUpdateLock and
     not (csDestroying in ComponentState)
  then
  begin
    LayoutChanged;
    FLayoutChangedInUpdateLock := False;
  end;
end;

function TCustomDBAxisGridEh.CanEditAcceptKey(Key: Char): Boolean;
begin
  with AxisBars[SelectedIndex] do
    if FDatalink.Active and Assigned(Field) then
    begin
      if TDBAxisGridInplaceEdit(InplaceEditor).FReadOnlyStored
        then Result := not TDBAxisGridInplaceEdit(InplaceEditor).ReadOnly
        else Result := True;
      if Assigned(KeyList) and (KeyList.Count > 0)
        then Result := Result
        else Result := Result and Field.IsValidChar(Key);
    end else
    begin
      if TDBAxisGridInplaceEdit(InplaceEditor).FReadOnlyStored
        then Result := not TDBAxisGridInplaceEdit(InplaceEditor).ReadOnly
        else Result := False;
    end;
end;

function TCustomDBAxisGridEh.CanEditModifyText: Boolean;

  function FieldCanModify(Field: TField): Boolean;
  var
    AFields: TListOfFieldsEh;
  begin
    if (Field.FieldKind = fkLookUp) then
    begin
      Result := (Field.KeyFields <> '');
      AFields := TListOfFieldsEh.Create;
      try
        Field.Dataset.GetFieldList(AFields, Field.KeyFields);
        Result := Result and FieldsCanModify(AFields);
      finally
        AFields.Free;
      end;
    end else
      Result := Field.CanModify;
  end;

var
  AxisBar: TAxisBarEh;
begin
  Result := False;
  if Assigned(InplaceEditor) and TDBAxisGridInplaceEdit(InplaceEditor).FReadOnlyStored then
  begin
    Result := not TDBAxisGridInplaceEdit(InplaceEditor).ReadOnly;
    if Result then
    begin
      FDatalink.Edit;
      FDatalink.Modified;
    end else
      Exit;
  end;
  if not ReadOnly and FDatalink.Active and not FDatalink.Readonly then
  begin
    AxisBar := AxisBars[SelectedIndex];
    if AxisBar.LookupParams.LookupActive then
      Result := FieldsCanModify(AxisBar.LookupParams.KeyFields)
    else
      Result := Assigned(AxisBar.Field) and
                FieldCanModify(AxisBar.Field)
            and (not AxisBar.Field.IsBlob or
                     Assigned(AxisBar.Field.OnSetText) or
                     ((DrawMemoText = True) and (AxisBar.Field.DataType in MemoTypes))
                 );

    if Result and
      not AxisBar.ReadOnly and
      AxisBar.TextEditing and
      AxisBar.CanModify(False) then
    begin
      FDatalink.Edit;
      Result := FDatalink.Editing;
      if Result then FDatalink.Modified;
    end;
  end;
end;

function TCustomDBAxisGridEh.CanEditModifyColumn(Index: Integer): Boolean;
begin
  Result := False;
end;

function TCustomDBAxisGridEh.CanEditModify: Boolean;
begin
  Result := False;
end;

function TCustomDBAxisGridEh.CanEditShow: Boolean;
begin
  Result := (LayoutLock = 0) and inherited CanEditShow;
  if Result then
  begin
    Result := Result and (SelectedIndex >= 0) and (SelectedIndex < AxisBars.Count);
    Result := Result and AxisBars[SelectedIndex].CanEditShow;
  end;
end;

function TCustomDBAxisGridEh.CanEditorMode: Boolean;
begin
  Result := False;
end;

procedure TCustomDBAxisGridEh.ColumnDeleting(Item: TAxisBarEh);
begin

end;

procedure TCustomDBAxisGridEh.ColWidthsChanged;
begin
  inherited ColWidthsChanged;
end;

function TCustomDBAxisGridEh.CreateAxisBars: TGridAxisBarsEh;
begin
  Result := TGridAxisBarsEh.Create(Self, TAxisBarEh);
end;

function TCustomDBAxisGridEh.CreateAxisBarDefValues: TAxisBarDefValuesEh;
begin
  Result := TAxisBarDefValuesEh.Create(Self);
end;

function TCustomDBAxisGridEh.CreateEditor: TInplaceEdit;
begin
  Result := TDBAxisGridInplaceEdit.Create(Self);
end;

procedure TCustomDBAxisGridEh.CreateWnd;
begin
  BeginUpdate; { prevent updates in WMSize message that follows WMCreate }
  try
    inherited CreateWnd;
  finally
    EndUpdate;
  end;
  if Flat
    then FInplaceEditorButtonWidth := FlatButtonWidth// + 1
    else FInplaceEditorButtonWidth := GetSystemMetrics(SM_CXVSCROLL);
  {$IFDEF FPC}
  {$ELSE}
  FOriginalImeName := ImeName;
  FOriginalImeMode := ImeMode;
  {$ENDIF}
  KeyProperyModified;
  if (FNoDesigntControler = False) and
      Assigned(DBGridEhDesigntControler) and
      (csDesigning in ComponentState)
  then
    DBGridEhDesigntControler.KeyProperyModified(Self);
end;

procedure TCustomDBAxisGridEh.DataChanged;
begin
end;

procedure TCustomDBAxisGridEh.DefaultHandler(var Message);
begin
  inherited DefaultHandler(Message);
end;

procedure TCustomDBAxisGridEh.DeferLayout;
var
  M: Windows.TMsg;
begin
  if    HandleAllocated and
    not PeekMessage(M, Handle, cm_DeferLayout, cm_DeferLayout, pm_NoRemove)
  then
    PostMessage(Handle, cm_DeferLayout, WPARAM(GetRestoreStateControl), 0);
  CancelLayout;
  EndUpdate;
end;

procedure TCustomDBAxisGridEh.DefineFieldMap;
var
  I: Integer;
begin
  if FAxisBars.State = csCustomized then
  begin { Build the AxisBar/field map from the AxisBar attributes }
    DataLink.SparseMap := True;
    for I := 0 to FAxisBars.Count - 1 do
      FDataLink.AddMapping(FAxisBars[I].FieldName);
  end else { Build the AxisBar/field map from the field list order }
  begin
    FDataLink.SparseMap := False;
    with Datalink.Dataset do
      for I := 0 to FieldCount - 1 do
        with Fields[I] do if Visible then Datalink.AddMapping(FieldName);
  end;
end;

procedure TCustomDBAxisGridEh.ReadColumns(Reader: TReader);
begin
  AxisBars.Clear;
  Reader.ReadValue;
  Reader.ReadCollection(AxisBars);
end;

procedure TCustomDBAxisGridEh.WriteColumns(Writer: TWriter);
begin
  Writer.WriteCollection(AxisBars);
end;

procedure TCustomDBAxisGridEh.ReadDesignInfoCollection(Reader: TReader);
begin
  if FDesignInfoCollection <> nil then
  begin
    FDesignInfoCollection.Clear;
    Reader.ReadValue;
    Reader.ReadCollection(FDesignInfoCollection);
  end
{$IFDEF EH_LIB_6}
  else
  {$IFDEF FPC}
     Reader.Driver.SkipValue;
  {$ELSE}
     Reader.SkipValue;
  {$ENDIF}
{$ELSE}
    ;
{$ENDIF}
end;

procedure TCustomDBAxisGridEh.WriteDesignInfoCollection(Writer: TWriter);
begin
  Writer.WriteCollection(FDesignInfoCollection);
end;

procedure TCustomDBAxisGridEh.DefineProperties(Filer: TFiler);
begin
  Filer.DefineProperty(AxisColumnsStorePropertyName,
    ReadColumns, WriteColumns,
    ((AxisBars.State = csCustomized) and (Filer.Ancestor = nil)) or
    ((Filer.Ancestor <> nil) and
    ((AxisBars.State <> TCustomDBAxisGridEh(Filer.Ancestor).AxisBars.State) or
{$IFDEF EH_LIB_6}
    (not CollectionsEqual(AxisBars, TCustomDBAxisGridEh(Filer.Ancestor).AxisBars, Self, TCustomDBAxisGridEh(Filer.Ancestor)))
{$ELSE}
    (not CollectionsEqual(AxisBars, TCustomDBAxisGridEh(Filer.Ancestor).AxisBars))
{$ENDIF}
    )));

  Filer.DefineProperty('DesignInfoCollection', ReadDesignInfoCollection, WriteDesignInfoCollection,
    (FDesignInfoCollection <> nil) and (FDesignInfoCollection.Count > 0));

end;

var
  InplaceBitmap: TBitmap;

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

procedure TCustomDBAxisGridEh.PaintInplaceButton(AxisBar: TAxisBarEh; Canvas: TCanvas;
  ButtonStyle: TEditButtonStyleEh; Rect, ClipRect: TRect;
  DownButton: Integer; Active, Flat, Enabled: Boolean; ParentColor: TColor;
  Bitmap: TBitmap; TransparencyPercent: Byte;
  imList: TCustomImageList; ImageIndex: Integer);
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
    NewBM := GetInplaceBitmap(AxisBar.Grid.Width, AxisBar.Grid.Height);
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

  if Flat and not ThemesEnabled then // Draw left button line
  begin
    LineRect := Rect;
    if AxisBar.UseRightToLeftAlignment then
    begin
      LineRect.Right := LineRect.Left;
      LineRect.Left := LineRect.Left + 1;
    end else
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


procedure TCustomDBAxisGridEh.DefaultDrawDataCell(Cell, AreaCell: TGridCoord;
  AxisBar: TAxisBarEh; AreaRect: TRect; Params: TAxisColCellParamsEh);
const
//  CheckBoxFlags: array[TCheckBoxState] of Integer =
//  (DFCS_BUTTONCHECK, DFCS_BUTTONCHECK or DFCS_CHECKED, DFCS_BUTTON3STATE or DFCS_CHECKED);
  EditToButtonStyle: array[TEditStyle] of TEditButtonStyleEh =
  (ebsDropDownEh, ebsEllipsisEh, ebsDropDownEh, ebsDropDownEh, ebsDropDownEh,
   ebsUpDownEh, ebsDropDownEh, ebsAltUpDownEh, ebsAltDropDownEh, ebsAltDropDownEh,
   ebsAltDropDownEh, ebsAltDropDownEh, ebsDropDownEh, ebsAltDropDownEh);
var
  The3DRect: Boolean;
  IsCellFilled: Boolean;
  ADrawByThemes: Boolean;
  AFrameRect, ARect1, ACellRect: TRect;
  XFrameOffs, YFrameOffs: Integer;
  AEditStyle: TEditStyle;
  AEditLineWidth, AButtonWidth, AButtonsWidth: Integer;
  Highlight: Boolean;
  i: Integer;
  IsWordWrap: Boolean;
  EditButtonTransparency: Byte;
  AIsDrawEditButton: Boolean;

begin
  The3DRect := CellHave3DRect(Cell.X, Cell.Y, AreaRect, Params.State);

  if ColCellParamsEh.BlankCell then
    if not The3DRect then
      The3DRect := IsFixed3D;

  ADrawByThemes := Params.DrawCellByThemes;

  AFrameRect := AreaRect;
  if The3DRect then
  begin
    XFrameOffs := AxisBar.GetDataCellHorzOffset - 1;
    if ADrawByThemes then
    begin
      GetThemeTitleFillRect(AreaRect, True, True);
    end else if Flat then
    begin
      Inc(AreaRect.Left, 1);
      Inc(AreaRect.Top, 1);
    end else
    begin
      InflateRect(AreaRect, -1, -1);
    end;
  end else
    XFrameOffs := AxisBar.GetDataCellHorzOffset;
  YFrameOffs := XFrameOffs;
  if YFrameOffs > 2 then YFrameOffs := 2;
  if Flat and (YFrameOffs > 0) then Dec(YFrameOffs);

  AEditStyle := esSimple;
  if Flat and not ThemesEnabled
    then AEditLineWidth := 1
    else AEditLineWidth := 0;
  AButtonsWidth := 0;
  ACellRect := AreaRect;

  AIsDrawEditButton := AxisBar.IsDrawEditButton(Cell.X, Cell.Y);
  if AIsDrawEditButton and not ColCellParamsEh.BlankCell then // Draw edit button
  begin
    AEditStyle := GetColumnEditStile(AxisBar);
    AButtonsWidth := AxisBar.EditButtonsWidth;
    AreaRect.Right := AreaRect.Right - AButtonsWidth;
  end;

  if not ColCellParamsEh.SuppressActiveCellColor and ColCellParamsEh.BlankCell then
    ColCellParamsEh.FBackground := FixedColor;
  if ColCellParamsEh.SuppressActiveCellColor and
   ((Cell.Y = Row) and ((Cell.X = Col) or (goRowSelectEh in Options)))
   then Highlight := False
   else Highlight := HighlightDataCellColor(AreaCell.X, AreaCell.Y,
            ColCellParamsEh.Text, ColCellParamsEh.State, ColCellParamsEh.FBackground, Canvas.Font);
  if Highlight then
    ColCellParamsEh.State := ColCellParamsEh.State + [gdSelected];
  Canvas.Brush.Color := ColCellParamsEh.FBackground;

  IsCellFilled := CheckFillDataCell(Cell, AreaCell, AxisBar, AreaRect, Params);

  if GridBackgroundFilled and (Canvas.Brush.Color = FInternalColor) then
    IsCellFilled := True;
  if not ColCellParamsEh.BlankCell and DefaultDrawing and (AreaRect.Right > AreaRect.Left) then
  begin
    if Highlight and IsDrawCellSelectionThemed(Cell.X, Cell.Y, Params.State) then
    begin
      if not IsCellFilled then
      begin
        Canvas.FillRect(AreaRect);
        IsCellFilled := True;
      end;
      DrawCellDataBackground(Cell.X, Cell.Y, AreaRect, Params.State);
    end;
    if (AxisBar.ImageList <> nil) and AxisBar.ShowImageAndText then
    begin
      ARect1 := AreaRect;
      ARect1.Right := ARect1.Left + AxisBar.ImageList.Width + 4;
      Canvas.Brush.Color := AxisBar.Color;
      if not IsCellFilled then
        Canvas.FillRect(AreaRect);
      DrawClipped(AxisBar.ImageList, nil, Canvas, ARect1, ColCellParamsEh.FImageIndex, 0, taCenter, ARect1);
      Canvas.Brush.Color := ColCellParamsEh.FBackground;
      AreaRect.Left := ARect1.Right + 1;
    end;
    if AxisBar.GetBarType in [ctCommon..ctKeyPickList] then
    begin
      if ADrawByThemes
        then ARect1 := AFrameRect
        else ARect1 := AreaRect;
      IsWordWrap := AxisBar.WordWrap and AxisBar.CurLineWordWrap(AreaRect.Bottom-AreaRect.Top);
      with ColCellParamsEh do
        WriteCellText(AxisBar, Canvas, ARect1, not IsCellFilled,
          XFrameOffs, YFrameOffs, FText, FAlignment, AxisBar.Layout,
          IsWordWrap, AxisBar.EndEllipsis, 0, 0, not IsWordWrap);

    end else if AxisBar.GetBarType = ctKeyImageList then
    begin
      if not IsCellFilled then
        Canvas.FillRect(AreaRect);
      DrawClipped(AxisBar.ImageList, nil, Canvas, AreaRect, ColCellParamsEh.FImageIndex, 0, taCenter, AreaRect);
    end else if AxisBar.GetBarType = ctCheckboxes then
    begin
      if not IsCellFilled then
        Canvas.FillRect(AreaRect);
      ARect1.Left := AreaRect.Left + iif(AreaRect.Right - AreaRect.Left < DefaultCheckBoxWidth, 0,
        (AreaRect.Right - AreaRect.Left) shr 1 - DefaultCheckBoxWidth shr 1);
      ARect1.Right := iif(AreaRect.Right - AreaRect.Left < DefaultCheckBoxWidth, AreaRect.Right,
        ARect1.Left + DefaultCheckBoxWidth);
      ARect1.Top := AreaRect.Top + iif(AreaRect.Bottom - AreaRect.Top < DefaultCheckBoxHeight, 0,
        (AreaRect.Bottom - AreaRect.Top) shr 1 - DefaultCheckBoxHeight shr 1);
      ARect1.Bottom := iif(AreaRect.Bottom - AreaRect.Top < DefaultCheckBoxHeight, AreaRect.Bottom,
        ARect1.Top + DefaultCheckBoxHeight);
      PaintButtonControl(Canvas, ARect1, Canvas.Brush.Color, bcsCheckboxEh,
        0, Flat, False, True, ColCellParamsEh.FCheckboxState);
    end else if AxisBar.GetBarType = ctGraphicData then
      DrawGraphicCell(AxisBar, AreaRect, Canvas.Brush.Color, not IsCellFilled);
  end;

  if not ColCellParamsEh.BlankCell and AIsDrawEditButton then // Draw edit button
  begin
    EditButtonTransparency := GetDataEditButtonTransparency(Cell.X, Cell.Y, AreaRect, ColCellParamsEh);

    SetRect(ARect1, AreaRect.Right, AreaRect.Top,
      AreaRect.Right + AxisBar.InplaceEditorButtonWidth + AEditLineWidth, AreaRect.Top + AxisBar.InplaceEditorButtonHeight);
    if ARect1.Bottom > ACellRect.Bottom then ARect1.Bottom := ACellRect.Bottom;
    if (AEditStyle <> esSimple) then
    begin
      if The3DRect then OffsetRect(ARect1, 1, -1); // InflateRect(ARect1, -1, -1);
    {if AEditStyle = esUpDown then
      Canvas.Draw(ARect1.Left,ARect1.Top,UpDownBitmap)
    else}
      PaintInplaceButton(AxisBar, Canvas, EditToButtonStyle[AEditStyle], ARect1, ACellRect,
        0, IsMouseInRect(ARect1), Flat, DataLink.Active,
        {ApproximateColor(Canvas.Brush.Color, clBlack, 10)} Canvas.Brush.Color
        , nil, EditButtonTransparency, nil, 0);
      if Flat and The3DRect and not ThemesEnabled then
        Canvas.FillRect(Rect(ARect1.Left - 1, ARect1.Top, ARect1.Left, AreaRect.Bottom));

      Inc(ARect1.Left, AxisBar.InplaceEditorButtonWidth + AEditLineWidth);
    end;
    for i := 0 to AxisBar.EditButtons.Count - 1 do
      if AxisBar.EditButtons[i].Visible then
      begin
        if AxisBar.EditButtons[i].Width > 0
          then AButtonWidth := AxisBar.EditButtons[i].Width + AEditLineWidth
          else AButtonWidth := AxisBar.InplaceEditorButtonWidth;
        ARect1.Right := ARect1.Left + AButtonWidth + AEditLineWidth;
        PaintInplaceButton(AxisBar, Canvas, AxisBar.EditButtons[i].Style,
          ARect1, ACellRect, 0, IsMouseInRect(ARect1), Flat, DataLink.Active,
          Canvas.Brush.Color,
//        ApproximateColor(Canvas.Brush.Color, clBlack, 10),
          AxisBar.EditButtons[i].Glyph, EditButtonTransparency,
          AxisBar.EditButtons[i].Images.NormalImages, AxisBar.EditButtons[i].Images.NormalIndex);
        if Flat and The3DRect and not ThemesEnabled then
          Canvas.FillRect(Rect(ARect1.Left - 1, ARect1.Top, ARect1.Left, AreaRect.Bottom));
        Inc(ARect1.Left, AButtonWidth + AEditLineWidth);
      end;

//    if FInplaceEditorButtonHeight < FStdDefaultRowHeight then
    if AxisBar.InplaceEditorButtonHeight < (AreaRect.Bottom - AreaRect.Top) then
      Canvas.FillRect(Rect(AreaRect.Right, ARect1.Bottom, AreaRect.Right + AButtonsWidth, AreaRect.Bottom));
  end;

//TODO  if not ColCellParamsEh.BlankCell then
//    PaintRequiredState(AxisBar, ColCellParamsEh.Text, AreaRect);
//  if AxisBars.State = csDefault then
//    OldDrawDataCell(AreaRect, AxisBar.Field, ColCellParamsEh.State);
//  DrawColumnCell(AreaRect, AreaCell.X, AxisBar, ColCellParamsEh.State);

//  AreaRect := ACellRect;
//  if not ColCellParamsEh.BlankCell and
//    (FIntMemTable <> nil) and
//    (AreaCell.X = 0) and
//    FIntMemTable.MemTableIsTreeList
//  then
//    AreaRect.Left := AreaRect.Left + 1;

  if not ColCellParamsEh.BlankCell and
         AIsDrawEditButton and
         (AEditStyle <> esSimple) and
         Flat
  then
    AreaRect.Right := AreaRect.Right + AButtonsWidth;

  if ColCellParamsEh.BlankCell then
  begin
    FillBlankDataCellRect(AreaRect, Highlight, The3DRect, Params);
  end;

  if The3DRect then
  begin
    if not ADrawByThemes then
      DrawEdgeEh(Canvas, AFrameRect, False, Highlight, True, not (Flat and ThemesEnabled), Flat);
  end;

end;

function TCustomDBAxisGridEh.CheckFillDataCell(Cell, AreaCell: TGridCoord;
  AxisBar: TAxisBarEh; AreaRect: TRect; Params: TAxisColCellParamsEh): Boolean;
var
  The3DRect, ADrawByThemes: Boolean;
  Highlight: Boolean;
  DefaultFillCellRect: Boolean;
  FillStyle: TGridCellFillStyleEh;
begin
  The3DRect := CellHave3DRect(Cell.X, Cell.Y, AreaRect, Params.State);
  Highlight := gdSelected in FColCellParamsEh.State;
  ADrawByThemes := Params.DrawCellByThemes;

  Result := The3DRect and not (gdSelected in FColCellParamsEh.State) and
    (ADrawByThemes or (Flat and ThemesEnabled));
  DefaultFillCellRect := True;

  if Result and DefaultFillCellRect then
  begin
    if ADrawByThemes
      then FillStyle := cfstThemedEh
      else FillStyle := GetDefaultFixedCellFillStyle;
    FillCellRect(FillStyle, AreaRect, False, Highlight, EmptyRect,
      The3DRect, gdFocused in FColCellParamsEh.State);
  end else if Result then
  begin
    if (gdFocused in FColCellParamsEh.State)
    then
    begin
      Canvas.FillRect(AreaRect);
    end else
      FillGradientEh(Canvas, AreaRect,
      ApproximateColor(Canvas.Brush.Color, clBtnHighlight, 256 div 3),
      Canvas.Brush.Color);
  end;
end;

procedure TCustomDBAxisGridEh.FillCellRect(CellFillStyle: TGridCellFillStyleEh; ARect: TRect;
  IsDown, IsSelected: Boolean; ClipRect: TRect; Cell3D: Boolean; Focused: Boolean = False;
  GradSecondColor: TColor = clDefault);
var
  Details: TThemedElementDetails;
  GradientColor: TColor;
  StartColor, EndColor: TColor;
begin
  if (CellFillStyle = cfstThemedEh) and ThemeServices.ThemesEnabled then
  begin
    if CellFillStyle = cfstGradientEh then
    begin
      FillGradientEh(Canvas, ARect,
        ApproachToColorEh(clBtnFace, clWhite, 10),
        ApproachToColorEh(clBtnFace, clBlack, 5));
      Canvas.Brush.Style := bsClear;
    end else
    begin
      if IsSelected or IsDown
        then Details := ThemeServices.GetElementDetails(thHeaderItemPressed)
        else Details := ThemeServices.GetElementDetails(thHeaderItemNormal);

      if IsRectEmpty(ClipRect) then
      begin
        Canvas.FillRect(ARect);
        ThemeServices.DrawElement(Canvas.Handle, Details, ARect);
      end else
      begin
        Canvas.FillRect(ClipRect);
{$IFDEF CIL}
        ThemeServices.DrawElement(Canvas.Handle, Details, ARect, ClipRect);
{$ELSE}
        ThemeServices.DrawElement(Canvas.Handle, Details, ARect, @ClipRect);
{$ENDIF}
      end
    end
  end else if CellFillStyle = cfstGradientEh then
  begin
    if IsCustomStyleActive then
    begin
      StartColor := clNone;
      EndColor := clNone;
      GetDefaultFixedGradientColor(StartColor, EndColor, IsSelected, IsDown);
      GradientColor := StartColor;
      Canvas.Brush.Color := EndColor;
    end else
    begin
      if IsSelected
        then GradientColor := ApproximateColor(Canvas.Brush.Color, clWindow, 255 div 2)
        else
      begin
        if GradSecondColor = clDefault then
          GradientColor := ColorToGray(ApproximateColor(Canvas.Brush.Color, Self.Color, 240))
        else
          GradientColor := GradSecondColor;
      end;
    end;
    FillGradientEh(Canvas, ARect, GradientColor, Canvas.Brush.Color)
  end else
    Canvas.FillRect(ARect);
end;

procedure TCustomDBAxisGridEh.EditButtonClick;
begin
  if Assigned(FOnEditButtonClick) then FOnEditButtonClick(Self);
end;

procedure TCustomDBAxisGridEh.EditingChanged;
var
  I: Integer;
begin
  if (csDestroying in ComponentState) or
     (DataSource = nil) or
     (DataSource.DataSet = nil)
  then
    Exit;

  for I := 0 to AxisBars.Count - 1 do
    if (DataSource.DataSet.State = dsBrowse) and (DataLink.FLastDataSetState = dsEdit) then
      AxisBars[I].RecordChanged(nil);
end;

function TCustomDBAxisGridEh.GetDataSource: TDataSource;
begin
  Result := DataLink.DataSource;
end;

function TCustomDBAxisGridEh.GetDefaultFixedCellFillStyle: TGridCellFillStyleEh;
begin
  if Flat then
      Result := cfstSolidEh
  else if ThemesEnabled then
    Result := cfstThemedEh
  else
    Result := cfstSolidEh;
end;

function TCustomDBAxisGridEh.GetEditLimit: Integer;
begin
  Result := 0;
  if {not}(Assigned(AxisBars[SelectedIndex].KeyList) and (AxisBars[SelectedIndex].KeyList.Count > 0)) {ddd\\\} then
  else
    if Assigned(SelectedField) and (SelectedField.DataType in [ftString, ftWideString]) then
      Result := SelectedField.Size;
end;

function TCustomDBAxisGridEh.GetEditMask(ACol, ARow: Longint): string;
begin
  Result := 'Must be rewrited in the inherited class';
end;

function TCustomDBAxisGridEh.GetEditText(ACol, ARow: Longint): string;
begin
  Result := 'Must be rewrited in the inherited class';
end;

function TCustomDBAxisGridEh.GetFieldCount: Integer;
begin
  Result := FDatalink.FieldCount;
end;

function TCustomDBAxisGridEh.GetFields(FieldIndex: Integer): TField;
begin
  Result := FDatalink.Fields[FieldIndex];
end;

function TCustomDBAxisGridEh.GetSelectedField: TField;
var
  Index: Integer;
begin
  Index := SelectedIndex;
  if Index <> -1
    then Result := AxisBars[Index].Field
    else Result := nil;
end;

function TCustomDBAxisGridEh.GetSelectedIndex: Integer;
begin
  Result := -1;
end;

procedure TCustomDBAxisGridEh.SetSelectedIndex(Value: Integer);
begin
  raise Exception.Create(' TCustomDBAxisGridEh.SetSelectedIndex must be realized in the inherited class.')
end;

function TCustomDBAxisGridEh.HighlightDataCellColor(DataCol, DataRow: Integer; const Value: string;
   AState: TGridDrawState; var AColor: TColor; AFont: TFont): Boolean;
var
  AFocused: Boolean;
begin
  if CanFillSelectionByTheme then
    Result := False
  else
  begin
    Result := Focused {and (dghHighlightFocus in OptionsEh)} and (gdSelected in AState);
    AFocused := False;
    if Result then
      if IsSelectionActive and not IsDrawCellSelectionThemed(DataCol, DataRow, AState) then
      begin
        AColor := clHighlight;
{$IFDEF EH_LIB_16}
        if IsCustomStyleActive then
          StyleServices.GetElementColor(StyleServices.GetElementDetails(tgClassicCellSelected), ecFillColor, AColor);
{$ENDIF}
        AFont.Color := clHighlightText;
      end
      else if (DataRow  = Row) and
               ((DataCol = Col) or (goRowSelectEh in Options)) and
               AFocused and
               not IsDrawCellSelectionThemed(DataCol, DataRow, AState) then
      begin
        AColor := clBtnShadow;
        AFont.Color := clHighlightText;
      end else
        AColor := clBtnFace;
  end;
end;

procedure TCustomDBAxisGridEh.WMChar(var Message: TWMChar);
begin
  inherited;
end;

{ InternalLayout is called with layout locks and AxisBar locks in effect }
procedure TCustomDBAxisGridEh.InternalLayout;
var
  SeenPassthrough: Boolean;
  I, J, K: Integer;
  AxisBar: TAxisBarEh;
  Fld: TField;

  function FieldIsMapped(F: TField): Boolean;
  var
    X: Integer;
  begin
    Result := False;
    if F = nil then Exit;
    for X := 0 to FDatalink.FieldCount - 1 do
      if FDatalink.Fields[X] = F then
      begin
        Result := True;
        Exit;
      end;
  end;

begin
  if (csLoading in ComponentState) or
     (csDestroying in ComponentState)
  then
    Exit;

  if HandleAllocated then KillMessage(Handle, cm_DeferLayout);

  try
    LockPaint;

  { Check for AxisBars.State flip-flop }
  SeenPassthrough := False;
  for I := 0 to FAxisBars.Count - 1 do
  begin
    if not FAxisBars[I].IsStored then
      SeenPassthrough := True
    else
      if SeenPassthrough then
      begin { We have both custom and passthrough AxisBars. Kill the latter }
        for J := FAxisBars.Count - 1 downto 0 do
        begin
          AxisBar := FAxisBars[J];
          if not AxisBar.IsStored then
            AxisBar.Free;
        end;
        Break;
      end;
  end;

  FDatalink.ClearMapping;

  if FDatalink.Active then DefineFieldMap;
  if FAxisBars.State = csDefault then
  begin
     { Destroy AxisBars whose fields have been destroyed or are no longer
       in field map }
    if (not FDataLink.Active) and (FDatalink.DefaultFields) then
      FAxisBars.Clear
    else
      for J := FAxisBars.Count - 1 downto 0 do
        with FAxisBars[J] do
          if not Assigned(Field)
            or not FieldIsMapped(Field) then Free;

    if not FAxisBars.IndexSeenPassthrough then
    begin
      if not FAxisBars.CheckAxisBarsToFieldsNoOrders then
      begin
        FAxisBars.Clear;
        for I := 0 to FDataLink.FieldCount-1 do
        begin
          AxisBar := FAxisBars.InternalAdd;
          AxisBar.Field := FDatalink.Fields[I];
        end;
      end else if FAxisBars.Count = 0 then
        FAxisBars.InternalAdd;
    end else
    begin
      I := FDataLink.FieldCount;
      if (I = 0) and (FAxisBars.Count = 0) then Inc(I);
      for J := 0 to I - 1 do
      begin
        Fld := FDatalink.Fields[J];
        if Assigned(Fld) then
        begin
          K := J;
           { Pointer compare is valid here because the grid sets matching
             AxisBar.field properties to nil in response to field object
             free notifications.  Closing a dataset that has only default
             field objects will destroy all the fields and set associated
             AxisBar.field props to nil. }
          while (K < FAxisBars.Count) and (FAxisBars[K].Field <> Fld) do
            Inc(K);
          if K < FAxisBars.Count then
            AxisBar := FAxisBars[K]
          else
          begin
            AxisBar := FAxisBars.InternalAdd;
            AxisBar.Field := Fld;
          end;
        end
        else
          AxisBar := FAxisBars.InternalAdd;
        AxisBar.Index := J;
      end;
    end;
  end else
  begin
    { Force AxisBars to reaquire fields (in case dataset has changed) }
    for I := 0 to FAxisBars.Count - 1 do
      if not FDataLink.Active and FDataLink.DefaultFields
        then FAxisBars[I].Field := nil
        else FAxisBars[I].BindField;
  end;
  FVisibleAxisBars.Clear;

  finally
    UnlockPaint;
  end;
end;

procedure TCustomDBAxisGridEh.LayoutChanged;
begin
  if AcquireLayoutLock then
    EndLayout
  else if FUpdateLock > 0 then
    FLayoutChangedInUpdateLock := True;
end;

procedure TCustomDBAxisGridEh.LinkActive(Value: Boolean);
begin
  if not Value then HideEditor;
  LayoutChanged;
  if Value and CanEditorMode then
    ShowEditor;
  if not (csLoading in ComponentState) {and not Value} then
    AxisBars.ActiveChanged;
end;

procedure TCustomDBAxisGridEh.Loaded;
begin
  inherited Loaded;

  LayoutChanged;
  DeferLayout;

end;

procedure TCustomDBAxisGridEh.ChangeScale(M, D: Integer);
var
  {$IFDEF FPC}
  {$ELSE}
  Flags: TScalingFlags;
  {$ENDIF}
  i: Integer;
begin
  if M <> D then
  begin
    {$IFDEF FPC}
    {$ELSE}
    if csLoading in ComponentState
      then Flags := ScalingFlags
      else Flags := [sfFont];
    if not ParentFont and (sfFont in Flags) then
    {$ENDIF}
    begin
      TitleFont.Size := MulDiv(Font.Size, M, D);
    end;
    {$IFDEF FPC}
    {$ELSE}
    if sfFont in Flags then
    {$ENDIF}
    try
      AxisBars.BeginUpdate;
      for i := 0 to AxisBars.Count - 1 do
        with AxisBars[i] do
        begin
          if cvFont in AssignedValues
            then Font.Size := MulDiv(Font.Size, M, D);
          if cvTitleFont in AssignedValues
            then Title.Font.Size := MulDiv(Title.Font.Size, M, D);
        end;
    finally
      AxisBars.EndUpdate;
    end;
  end;
  inherited ChangeScale(M, D);
end;

procedure TCustomDBAxisGridEh.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
end;

procedure TCustomDBAxisGridEh.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseMove(Shift, X, Y);
end;

procedure TCustomDBAxisGridEh.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
end;

procedure TCustomDBAxisGridEh.Notification(AComponent: TComponent; Operation: TOperation);
var
  I: Integer;
  NeedLayout: Boolean;
  AField: TField;
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
  begin
    if (AComponent is TPopupMenu) then
    begin
      for I := 0 to AxisBars.Count - 1 do
        begin
          if AxisBars[I].PopupMenu = AComponent
            then AxisBars[I].PopupMenu := nil;

          if AxisBars[I].Title.PopupMenu = AComponent then
            AxisBars[I].Title.PopupMenu := nil;
        end;
    end
    else if (AComponent is TCustomImageList) then
    begin
      for I := 0 to AxisBars.Count - 1 do
        if AxisBars[I].ImageList = AComponent then
          AxisBars[I].ImageList := nil;
    end else if (AComponent is TDataSource) then
    begin
      for I := 0 to AxisBars.Count - 1 do
        if AxisBars[I].DropDownBox.ListSource = AComponent then
          AxisBars[I].DropDownBox.ListSource := nil;
      if (FDataLink <> nil) and (AComponent = DataSource) then
        DataSource := nil;
    end
    else if (FDataLink <> nil) then
      if (AComponent is TField) then
      begin
        NeedLayout := False;
        for I := 0 to AxisBars.Count - 1 do
        begin
          AField := AxisBars[I].FField;
          if (AField = AComponent) then
            if (FDataLink.DataSet = nil) or
               ( (FDataLink.DataSet <> nil) and not FDataLink.DataSet.ControlsDisabled )
            then
              NeedLayout := True;
        end;
        if NeedLayout then
        begin
          BeginLayout;
          try
            for I := 0 to AxisBars.Count - 1 do
              if AxisBars[I].FField = AComponent then
                AxisBars[I].Field := nil;
          finally
            if Assigned(FDatalink.Dataset)
              and not FDatalink.Dataset.ControlsDisabled then
              EndLayout
            else
              DeferLayout;
          end;
        end;
      end
  end;
end;

procedure TCustomDBAxisGridEh.RecordChanged(Field: TField);
var
  I: Integer;
  CField: TField;
  NeedInvalidateEditor: Boolean;
begin
  if not HandleAllocated then Exit;
  if Field = nil then
    Invalidate
  else
  begin
    for I := 0 to AxisBars.Count - 1 do
    begin
      AxisBars[I].RecordChanged(Field);
      if AxisBars[I].Field = Field then
        //InvalidateCol(DataToRawColumn(I));
      begin
      //  InvalidateCol(DataToRawColumn(I));
        InvalidateRow(Row);
      end;
    end;
  end;
  CField := SelectedField;
  NeedInvalidateEditor := False;
  if ((Field = nil) or (CField = Field)) and Assigned(CField)
  then
    if (DrawMemoText = True) and (CField.DataType in MemoTypes) then
      NeedInvalidateEditor := (AdjustLineBreaks(CField.AsString) <> FEditText)
    else if AxisBars[SelectedIndex].GetBarType = ctKeyPickList then
      NeedInvalidateEditor := (AxisBars[SelectedIndex].DisplayText <> FEditText)
    else
      NeedInvalidateEditor := (CField.Text <> FEditText);
  if NeedInvalidateEditor then
  begin
    InvalidateEditor;
    if InplaceEditor <> nil then
      InplaceEditor.Deselect;
  end;
end;

procedure TCustomDBAxisGridEh.InvalidateEditor;
begin
  if (InplaceEditor <> nil) and TDBAxisGridInplaceEdit(InplaceEditor).FListVisible then
    with TDBAxisGridInplaceEdit(InplaceEditor) do
    begin
      FLockCloseList := True;
      try
        inherited InvalidateEditor;
      finally
        FLockCloseList := False;
      end;
    end
  else
    inherited InvalidateEditor;
end;

procedure TCustomDBAxisGridEh.Scroll(Distance: Integer);
begin
end;

procedure TCustomDBAxisGridEh.SetAxisBars(Value: TGridAxisBarsEh);
begin
  AxisBars.Assign(Value);
end;

procedure TCustomDBAxisGridEh.SetColumnAttributes;
begin
  inherited;
end;

procedure TCustomDBAxisGridEh.SetDataSource(Value: TDataSource);
var
  NiComponentItfs: ISideOwnedComponentEh;
  DoFreeDataSource: TDataSource;
  JustCreatedNiComponentItfs: ISideOwnedComponentEh;
  ModRes: Integer;
begin
  if Value = FDatalink.Datasource then Exit;

  DoFreeDataSource := nil;
  if (csDesigning in ComponentState) and
     not (csLoading in ComponentState) and
     Supports(DataSource, ISideOwnedComponentEh, NiComponentItfs)
  then
    if NiComponentItfs.IsSideParentedBy(Self) then
      DoFreeDataSource := DataSource;

  JustCreatedNiComponentItfs := nil;
  if (csDesigning in ComponentState) and
     not (csLoading in ComponentState) and
     Supports(Value, ISideOwnedComponentEh, JustCreatedNiComponentItfs)
  then
    if not JustCreatedNiComponentItfs.IsSideParentedBy(nil) then
      JustCreatedNiComponentItfs := nil;

  if (DoFreeDataSource <> nil) and
     not (csDestroying in ComponentState) then
  begin
    ModRes :=
      MessageDlg('Component "' + DataSource.Name + '" belongs to "' + Name + '"' +
      'and will be deleted if DataSource property is assigned by a new component or nil.' +  sLineBreak +
        'Do you want to assign new component to the DataSource property and delete "' + DataSource.Name + '" ?',
        mtConfirmation, [mbYes, mbNo], 0);
    if ModRes <> mrYes then
    begin
      if JustCreatedNiComponentItfs <> nil then
        Value.Free;
     Exit;
    end;
  end;

  try
    FDataLink.DataSource := Value;
    if Value <> nil then Value.FreeNotification(Self);
//  LinkActive(FDataLink.Active);
  except
    if JustCreatedNiComponentItfs <> nil then
      Value.Free;
    raise;
  end;

  if JustCreatedNiComponentItfs <> nil then
    JustCreatedNiComponentItfs.SetSideParent(Self);

  if DoFreeDataSource <> nil then
    DoFreeDataSource.Free;
end;

procedure TCustomDBAxisGridEh.KeyProperyModified;
{$IFDEF FPC}
{$ELSE}
var
  Msg: TCMChanged;
{$ENDIF}
begin
{$IFDEF FPC}
{$ELSE}
  if not (csLoading in ComponentState) and (csDesigning in ComponentState) then
  begin
    Msg.Msg := CM_CHANGED;
{$IFDEF CIL}
{$ELSE}
    Msg.Unused := 0;
    Msg.Child := Self;
{$ENDIF}
    Msg.Result := 0;
    Broadcast(Msg);
  end;
{$ENDIF}
end;

procedure TCustomDBAxisGridEh.SetEditText(ACol, ARow: Longint; const Value: string);
begin
  FEditText := Value;
end;

procedure TCustomDBAxisGridEh.SetBaseGridOptions(AOptions: TGridOptionsEh);
begin
  inherited Options := AOptions;
end;

function TCustomDBAxisGridEh.GetBaseGridOptions: TGridOptionsEh;
begin
  Result := inherited Options;
end;

procedure TCustomDBAxisGridEh.SetSelectedField(Value: TField);
var
  I: Integer;
begin
  if Value = nil then Exit;
  for I := 0 to AxisBars.Count - 1 do
    if AxisBars[I].Field = Value then
    begin
      SelectedIndex := I;
      Break;
    end;
end;

procedure TCustomDBAxisGridEh.SetTitleFont(Value: TFont);
begin
  raise Exception.Create('Write TCustomDBAxisGridEh.SetTitleFont in the inherited class');
end;

function TCustomDBAxisGridEh.GetTitleFont: TFont;
begin
  raise Exception.Create('Write TCustomDBAxisGridEh.GetTitleFont in the inherited class');
  Result := nil;
end;

function TCustomDBAxisGridEh.StoreColumns: Boolean;
begin
  Result := AxisBars.State = csCustomized;
end;

procedure TCustomDBAxisGridEh.UpdateActive;
begin
end;

procedure TCustomDBAxisGridEh.UpdateData;
var
  Field: TField;
  KeyIndex: Integer;
  MasterFields: TListOfFieldsEh;
  RecheckInList: Boolean;
  AxisBar: TAxisBarEh;
begin
  Field := SelectedField;
  AxisBar := AxisBars[SelectedIndex];
  if AxisBar.LookupParams.LookupActive then
  begin
    MasterFields := TListOfFieldsEh.Create;
    if VarEquals(FEditKeyValue, Null) and (FEditText <> '') and
      Assigned(AxisBar.OnNotInList) and
      not AxisBar.UsedLookupDataSet.Locate(AxisBar.LookupParams.LookupDisplayFieldName, FEditText, [loCaseInsensitive]) then
    begin
      RecheckInList := False;
      AxisBar.OnNotinList(AxisBar, FEditText, RecheckInList);
      if RecheckInList and AxisBar.UsedLookupDataSet.Locate(AxisBar.LookupParams.LookupDisplayFieldName, FEditText, [loCaseInsensitive]) then
      begin
        FEditKeyValue := AxisBar.UsedLookupDataSet.FieldValues[AxisBar.LookupParams.LookupKeyFieldNames];
      end;
    end;
    try
      DataSource.Dataset.GetFieldList(MasterFields, AxisBar.LookupParams.KeyFieldNames);
      if FieldsCanModify(MasterFields) then
      begin
        DataSource.DataSet.Edit;
        AxisBar.UpdateDataValues(FEditText, FEditKeyValue, False);
      end;
    finally
      MasterFields.Free;
    end;
{    if (DrawMemoText = True) and (Field.DataType in MemoTypes)
      then Field.AsString := FEditText
      else Field.Text := FEditText;}
  end
  else if not Assigned(Field) then
    AxisBar.UpdateDataValues(FEditText, FEditText, True)
  else
  begin
    if (AxisBar.GetBarType = ctPickList) then //PickList
    begin
      if Assigned(AxisBar.OnNotInList) and
//        (StringsLocate(AxisBar.PickList, FEditText, [loCaseInsensitive]) = -1) then
        (AxisBar.LocatePickList(FEditText, False) = -1) then
      begin
        RecheckInList := False;
        AxisBar.OnNotInList(AxisBar, FEditText, RecheckInList);
      end;
      //Field.Text := FEditText;
      AxisBar.UpdateDataValues(FEditText, FEditText, True);
    end
    else if (AxisBar.GetBarType = ctKeyPickList) then //KeyPickList
    begin
      KeyIndex := AxisBar.PickList.IndexOf(FEditText);
      if (KeyIndex > -1) and (KeyIndex < AxisBar.KeyList.Count) then
        FEditKeyValue := AxisBar.KeyList.Strings[KeyIndex]
      else if (KeyIndex = -1) then
        if Assigned(AxisBar.OnNotInList) and (FEditText <> '') then
        begin
          RecheckInList := False;
          AxisBar.OnNotinList(AxisBar, FEditText, RecheckInList);
          if RecheckInList then
          begin
            KeyIndex := AxisBar.PickList.IndexOf(FEditText);
            if (KeyIndex > -1) and (KeyIndex < AxisBar.KeyList.Count)
              then FEditKeyValue := AxisBar.KeyList.Strings[KeyIndex]
              else FEditKeyValue := Null;
          end else
            FEditKeyValue := Null;
        end else if (FEditText = '')
          then FEditKeyValue := Null;
      AxisBar.UpdateDataValues(FEditText, FEditKeyValue, False);
    end
    else if (DrawMemoText = True) and (Field.DataType in MemoTypes) then //Memo
      AxisBar.UpdateDataValues(FEditText, FEditText, True)
    else
      AxisBar.UpdateDataValues(FEditText, FEditText, True);
  end;
end;

function TCustomDBAxisGridEh.ValidFieldIndex(FieldIndex: Integer): Boolean;
begin
  Result := DataLink.GetMappedIndex(FieldIndex) >= 0;
end;

procedure TCustomDBAxisGridEh.SetIme;
{$IFDEF FPC}
{$ELSE}
var
  AxisBar: TAxisBarEh;
{$ENDIF}
begin
  if not SysLocale.FarEast then Exit;
  if AxisBars.Count = 0 then Exit;

{$IFDEF FPC}
{$ELSE}
  ImeName := FOriginalImeName;
  ImeMode := FOriginalImeMode;
  if SelectedIndex >= 0 then
  begin
    AxisBar := AxisBars[SelectedIndex];
    if AxisBar.IsImeNameStored then ImeName := AxisBar.ImeName;
    if AxisBar.IsImeModeStored then ImeMode := AxisBar.ImeMode;
  end;

  if InplaceEditor <> nil then
  begin
{$IFDEF CIL}
//    TDBAxisGridInplaceEdit(InplaceEditor).ImeName := ImeName;
//    TDBAxisGridInplaceEdit(InplaceEditor).ImeMode := ImeMode;
{$ELSE}
    TDBAxisGridInplaceEdit(InplaceEditor).ImeName := ImeName;
    TDBAxisGridInplaceEdit(InplaceEditor).ImeMode := ImeMode;
{$ENDIF}
  end;
{$ENDIF}
end;

procedure TCustomDBAxisGridEh.UpdateIme;
begin
  if not SysLocale.FarEast then Exit;
  SetIme;
  {$IFDEF FPC}
  {$ELSE}
  SetImeName(ImeName);
  SetImeMode(Handle, ImeMode);
  {$ENDIF}
end;

procedure TCustomDBAxisGridEh.Paint;
begin
  inherited Paint;
end;

function TCustomDBAxisGridEh.IsMouseInRect(ARect: TRect): Boolean;
var
  Point: TPoint;
begin
   GetCursorPos(Point);
   Point := ScreenToClient(Point);
   Result := PtInRect(ARect, Point);
end;

function TCustomDBAxisGridEh.IsDrawCellBorder(ACol, ARow: Integer; BorderType: TGridCellBorderTypeEh): Boolean;
var
  IsExtent: Boolean;
  BorderColor: TColor;
begin
  CheckDrawCellBorder(ACol, ARow, BorderType, Result, BorderColor, IsExtent);
end;

procedure TCustomDBAxisGridEh.WriteCellText(AxisBar: TAxisBarEh;
  ACanvas: TCanvas; ARect: TRect; FillRect: Boolean; DX, DY: Integer;
  const Text: string; Alignment: TAlignment; Layout: TTextLayout;
  MultyL, EndEllipsis: Boolean; LeftMarg, RightMarg: Integer;
  ForceSingleLine: Boolean);
var
  IsUseRightToLeftAlignment: Boolean;
begin
  if AxisBar <> nil
    then IsUseRightToLeftAlignment := AxisBar.UseRightToLeftAlignment
    else IsUseRightToLeftAlignment := UseRightToLeftAlignment;
  if Self.UseRightToLeftAlignment then
  begin
    WindowsLPtoDP(Canvas.Handle, ARect);
    SwapInt(ARect.Left, ARect.Right);
    ChangeGridOrientation(False);

    if IsUseRightToLeftAlignment then
      if Alignment = taLeftJustify then
        Alignment := taRightJustify
      else if Alignment = taRightJustify then
        Alignment := taLeftJustify;
    SwapInt(LeftMarg, RightMarg);
  end;
  WriteTextEh(Canvas, ARect, FillRect, DX, DY, Text, Alignment, Layout,
    MultyL, EndEllipsis, LeftMarg, RightMarg, IsUseRightToLeftAlignment, ForceSingleLine);
  if Self.UseRightToLeftAlignment then
    ChangeGridOrientation(True);
end;

procedure TCustomDBAxisGridEh.PaintButtonControl(Canvas: TCanvas; ARect: TRect;
  ParentColor: TColor; Style: TDrawButtonControlStyleEh;
  DownButton: Integer; Flat, Active, Enabled: Boolean;
  State: TCheckBoxState);
begin
  if Self.UseRightToLeftAlignment then
  begin
    WindowsLPtoDP(Canvas.Handle, ARect);
    SwapInt(ARect.Left, ARect.Right);
    ChangeGridOrientation(False);
  end;
  PaintButtonControlEh(Canvas, ARect, ParentColor, Style, DownButton, Flat, Active, Enabled, State);
  if Self.UseRightToLeftAlignment then
    ChangeGridOrientation(True);
end;

function TCustomDBAxisGridEh.FindFieldColumn(const FieldName: String): TAxisBarEh;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to AxisBars.Count - 1 do
    if NlsCompareText(AxisBars[i].FieldName, FieldName) = 0 then
    begin
      Result := AxisBars[i];
      Break;
    end;
end;

function TCustomDBAxisGridEh.GetFieldAxisBars(const FieldName: String): TAxisBarEh;
begin
  Result := FindFieldColumn(FieldName);
  if Result = nil then
    RaiseGridError(Format(SFieldNameNotFoundEh, [FieldName]));
end;

procedure TCustomDBAxisGridEh.SetBorder(Value: TControlBorderEh);
begin
  FBorder.Assign(Value);
end;

procedure TCustomDBAxisGridEh.DrawBorder;
const
  Ctl3DStyles: array[Boolean] of UINT = (BF_MONO, 0);
var
  DC, OldDC: HDC;
  R: TRect;
  grfFlags: UINT;
begin
  if FBorderWidth <> 0 then
//  if Flat and (BorderStyle = bsSingle) and ((Ctl3D = True) or (Border.Color <> clDefault)) then
  begin
    DC := GetWindowDC(Handle);
    try
      GetWindowRect(Handle, R);
      OffsetRect(R, -R.Left, -R.Top);
      //DrawEdge(DC, R,BDR_SUNKENOUTER, BF_TOPLEFT);
      //DrawEdge(DC, R,BDR_SUNKENOUTER, BF_BOTTOMRIGHT);
      if Border.Color <> clDefault then
      begin
        OldDC := Canvas.Handle;
        Canvas.Handle := DC;
        Canvas.Pen.Color := Border.Color;
        if ebLeft in Border.EdgeBorders then
          DrawPolyline([ Point(R.Left, R.Bottom-1), Point(R.Left, R.Top-1) ]);
        if ebTop in Border.EdgeBorders then
          DrawPolyline([ Point(R.Left, R.Top), Point(R.Right, R.Top) ]);
        if ebRight in Border.EdgeBorders then
          DrawPolyline([ Point(R.Right-1, R.Top), Point(R.Right-1, R.Bottom) ]);
        if ebBottom in Border.EdgeBorders then
          DrawPolyline([ Point(R.Right-1, R.Bottom-1), Point(R.Left-1, R.Bottom-1) ]);

        Canvas.Handle := OldDC;
      end else
      begin
        grfFlags := 0;
        if ebLeft in Border.EdgeBorders then
          grfFlags := grfFlags or BF_LEFT;
        if ebTop in Border.EdgeBorders then
          grfFlags := grfFlags or BF_TOP;
        if ebRight in Border.EdgeBorders then
          grfFlags := grfFlags or BF_RIGHT;
        if ebBottom in Border.EdgeBorders then
          grfFlags := grfFlags or BF_BOTTOM;

        DrawEdge(DC, R, BDR_SUNKENOUTER, grfFlags or Ctl3DStyles[Ctl3D]);
      end;

    finally
      ReleaseDC(Handle, DC);
    end;
  end;
end;

function TCustomDBAxisGridEh.CellHave3DRect(ACol, ARow: Integer; ARect: TRect;
  AState: TGridDrawState): Boolean;
begin
  Result := gdFixed in AState;
end;

{ Paradox graphic BLOB header }

type
  TGraphicHeader = record
    Count: Word;                { Fixed at 1 }
    HType: Word;                { Fixed at $0100 }
    Size: Longint;              { Size not including header }
  end;

function TCustomDBAxisGridEh.GetPictureForField(AxisBar: TAxisBarEh): TPicture;
var
  ms: TMemoryStream;
  Field: TBlobField;
  GraphicClass: TGraphicClass;
  NewGraphic: TGraphic;
  MemPointer: Pointer;
  Header: TGraphicHeader;
  msSize: Longint;
begin
  Result := TPicture.Create;
  try
  if Assigned(AxisBar.Field) and AxisBar.Field.IsBlob and (AxisBar.Field is TBlobField) then
  begin
    if GetGraphicProvidersCount > 0 then
    begin
      try
        ms := TMemoryStream.Create;
        Field := (AxisBar.Field as TBlobField);
        Field.SaveToStream(ms);
        ms.Position := 0;
        MemPointer := ms.Memory;
        GraphicClass := GetImageClassForStreamEh(MemPointer);
        if (GraphicClass = nil)
        {$IFDEF FPC}
        {$ELSE}
          and (AxisBar.Field as TBlobField).GraphicHeader
        {$ENDIF}
        then
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
              {$WARNINGS OFF}
              {$HINTS OFF}
              MemPointer := Pointer(Longint(ms.Memory) + SizeOf(Header));
              {$HINTS ON}
              {$WARNINGS ON}
          end;
          GraphicClass := GetImageClassForStreamEh(MemPointer);
        end;
        if GraphicClass <> nil then
        begin
          NewGraphic := GraphicClass.Create;
          Result.Graphic := NewGraphic;
          FreeAndNil(NewGraphic);
//          ms.Position := 0;
          Result.Graphic.LoadFromStream(ms);
        end else if not AxisBar.Field.IsNull then
          Result.Assign(AxisBar.Field);
      finally
        FreeAndNil(ms);
      end;
    end
    else if not AxisBar.Field.IsNull then
      Result.Assign(AxisBar.Field);
    {$IFDEF FPC}
    {$ELSE}
    if Result.Graphic is TBitmap then
      Result.Bitmap.IgnorePalette := True;
    {$ENDIF}
  end;
  except
    FreeAndNil(Result);
    raise;
  end;
end;

procedure TCustomDBAxisGridEh.DrawGraphicCell(AxisBar: TAxisBarEh; ARect: TRect;
  Background: TColor; FillBackground: Boolean);
var
  Size: TSize;
  R: TRect;
  S: string;
  DrawPict: TPicture;
  Pal: HPalette;
  Stretch: Boolean;
  Center: Boolean;
  XRatio, YRatio: Double;
  procedure DrawText(const AText: String);
  begin
    Canvas.Font := Self.Font;
    Size := Canvas.TextExtent(AText);
    R := ARect;
    Canvas.TextRect(R, (R.Left + R.Right - Size.cx) div 2,
      (R.Top + R.Bottom - Size.cy) div 2, AText);
  end;
begin
  with Canvas do
  begin
    if DrawGraphicData then
    begin
      try
      DrawPict := GetPictureForField(AxisBar);
{ TODO : Check if Raise Exception Invalide Image Format and Write it as Text }
      Pal := 0;
      try
        Stretch := (DrawPict.Width > (ARect.Right-Arect.Left))
          or (DrawPict.Height > (ARect.Bottom-Arect.Top));
        Center := True;
        if ((DrawPict.Graphic = nil) or DrawPict.Graphic.Empty) and FillBackground then
          FillRect(ARect)
        else if Stretch then
        begin
          XRatio := DrawPict.Width / (ARect.Right-Arect.Left);
          YRatio := DrawPict.Height / (ARect.Bottom-Arect.Top);
          R := ARect;
          if XRatio > YRatio then
          begin
            R.Bottom := Arect.Top + Round(DrawPict.Height / XRatio);
          end else
          begin
            R.Right := ARect.Left + Round(DrawPict.Width / YRatio);
          end;
        end else
        begin
          SetRect(R, ARect.Left, Arect.Top,
            ARect.Left + DrawPict.Width, Arect.Top + DrawPict.Height);
        end;

        if Center then OffsetRect(R,
          (ARect.Right - Arect.Left - (R.Right-R.Left)) div 2,
          (ARect.Bottom - Arect.Top - (R.Bottom-R.Top)) div 2);
        if FillBackground then
          FillRect(ARect);
        StretchDraw(R, DrawPict.Graphic);
      finally
        if Pal <> 0 then SelectPalette(Handle, Pal, True);
        DrawPict.Free;
      end;
      except
        on E: EInvalidGraphic do DrawText(E.Message + ' - Incorrect image format.');
        else raise;
      end;
    end else
    begin
      Font := Self.Font;
      if AxisBar.Field <> nil
        then S := AxisBar.Field.DisplayText
        else S := '';
      Size := TextExtent(S);
      R := ARect;
      TextRect(R, (R.Left + R.Right - Size.cx) div 2,
        (R.Top + R.Bottom - Size.cy) div 2, S);
    end;
  end;
end;

procedure TCustomDBAxisGridEh.GetDatasetFieldList(FieldList: TList);
var
  i: Integer;
begin
  if Assigned(DataSource) and Assigned(Datasource.Dataset) then
    for i := 0 to Datasource.Dataset.FieldCount - 1 do
      FieldList.Add(Datasource.Dataset.Fields[i]);
end;

procedure TCustomDBAxisGridEh.InvalidateGridRect(ARect: TGridRect);
var
  InvalidRect: TRect;
begin
  if not HandleAllocated then Exit;
  InvalidRect := BoxRect(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
  WindowsInvalidateRect(Handle, InvalidRect, False);
end;

function TCustomDBAxisGridEh.IsSelectionActive: Boolean;
var
  FocusedWin: THandle;
begin
  Result := False;
  if not HandleAllocated then Exit;

  FocusedWin := GetFocus;

  while FocusedWin <> 0 do
  begin
    if FocusedWin = Handle then
    begin
      Result := True;
      Exit;
    end;
    FocusedWin := GetParent(FocusedWin);
  end;
end;

function TCustomDBAxisGridEh.IsSideParentableForProperty(
  PropertyName: String): Boolean;
begin
  if PropertyName = 'DataSource'
    then Result := True
    else Result := False;
end;

function TCustomDBAxisGridEh.CanSideOwnClass(ComponentClass: TComponentClass): Boolean;
begin
  if ComponentClass.InheritsFrom(TDataSource)
    then Result := True
    else Result := False;
end;

procedure TCustomDBAxisGridEh.DoExit;
begin
  inherited DoExit;
  SelectionActiveChanged;
end;

procedure TCustomDBAxisGridEh.DoEnter;
begin
  inherited DoEnter;
  SelectionActiveChanged;
end;

// MemTable Supporting

function TCustomDBAxisGridEh.MemTableSupport: Boolean;
begin
  Result := (FIntMemTable <> nil);
end;

function TCustomDBAxisGridEh.ViewScroll: Boolean;
begin
  Result := MemTableSupport {and (FooterRowCount = 0)};
end;

procedure TCustomDBAxisGridEh.ShowEditor;
begin
  inherited;
end;

procedure TCustomDBAxisGridEh.HideEditor;
begin
  inherited HideEditor;
end;

procedure TCustomDBAxisGridEh.LockEditor;
begin
  Inc(FLockEditorCount);
end;

procedure TCustomDBAxisGridEh.UnlockEditor;
begin
  Dec(FLockEditorCount);
end;

procedure TCustomDBAxisGridEh.UpdateEdit;
begin
  inherited UpdateEdit;
end;

procedure TCustomDBAxisGridEh.UpdateText;
begin
  inherited UpdateText;
end;

//{ IInplaceEditHolderEh }

procedure TCustomDBAxisGridEh.GetMouseDownInfo(var Pos: TPoint; var Time: Integer);
begin
  Pos := ClientToScreen(FDownMousePos);
  Time := FDownMouseMessageTime;
  FDownMouseMessageTime := 0;
end;

function TCustomDBAxisGridEh.InplaceEditCanModify(Control: TWinControl): Boolean;
begin
  Result := True;
end;

procedure TCustomDBAxisGridEh.InplaceEditKeyDown(Control: TWinControl;
  var Key: Word; Shift: TShiftState);

begin
end;

procedure TCustomDBAxisGridEh.InplaceEditKeyPress(Control: TWinControl; var Key: Char);
begin
end;

procedure TCustomDBAxisGridEh.InplaceEditKeyUp(Control: TWinControl;
  var Key: Word; Shift: TShiftState);
begin

end;

procedure TCustomDBAxisGridEh.InplaceEditWndProc(Control: TWinControl; var Message: TMessage);
begin

end;

procedure TCustomDBAxisGridEh.WMPaint(var Message: TWMPaint);
begin
  inherited;
end;

function TCustomDBAxisGridEh.BoxRect(ALeft, ATop, ARight,
  ABottom: Integer): TRect;
begin
  Result := inherited BoxRect(ALeft, ATop, ARight, ABottom);
end;

function TCustomDBAxisGridEh.NeedBufferedPaint: Boolean;
begin
{ TODO : Return back }
  Result := True;
{  Result := DrawTitleByThemes or
            ( MemTableSupport and
              FIntMemTable.MemTableIsTreeList
              and (dgRowLines in Options)) or
            RowPanel.Active or
            UseMultiTitle;}
end;

procedure TCustomDBAxisGridEh.SetDrawMemoText(const Value: Boolean);
begin
  if FDrawMemoText <> Value then
  begin
    FDrawMemoText := Value;
    LayoutChanged;
  end;
end;

procedure TCustomDBAxisGridEh.SetDrawGraphicData(const Value: Boolean);
begin
  if FDrawGraphicData <> Value then
  begin
    FDrawGraphicData := Value;
    LayoutChanged;
  end;
end;

procedure TCustomDBAxisGridEh.GetCellParams(AxisBar: TAxisBarEh; AFont: TFont;
  var Background: TColor; State: TGridDrawState);
begin
end;

function TCustomDBAxisGridEh.CellRect(ACol, ARow: Integer; IncludeLine: Boolean = False): TRect;
begin
  Result := inherited CellRect(ACol, ARow, IncludeLine);
end;

procedure TCustomDBAxisGridEh.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited KeyUp(Key, Shift);
end;

procedure TCustomDBAxisGridEh.RolPosChanged(OldRowPosX, OldRowPosY: Integer);
begin
  inherited RolPosChanged(OldRowPosX, OldRowPosY);
  UpdateEditButtonsBox;
end;

procedure TCustomDBAxisGridEh.StopTimer;
begin
  if FTimerActive then
  begin
    KillTimer(Handle, 1);
    FTimerActive := False;
    FTimerInterval := -1;
  end;
end;

procedure TCustomDBAxisGridEh.ResetTimer(Interval: Integer);
begin
  if FTimerActive = False then
    SetTimer(Handle, 1, Interval, nil)
  else if Interval <> FTimerInterval then
  begin
    StopTimer;
    SetTimer(Handle, 1, Interval, nil);
    FTimerInterval := Interval;
  end;
  FTimerActive := True;
end;


//{CM messages processing}

procedure TCustomDBAxisGridEh.CMWantSpecialKey(var Msg: TCMWantSpecialKey);
begin
  inherited;
  if Assigned(FDataLink.DataSet) and
     FDataLink.DataSet.Modified and
     (Msg.CharCode = VK_ESCAPE) then Msg.Result := 1;
end;

{$IFDEF FPC}
{$ELSE}
procedure TCustomDBAxisGridEh.CMSysColorChange(var Message: TMessage);
begin
  inherited;
  ClearButtonsBitmapCache;
end;
{$ENDIF}

procedure TCustomDBAxisGridEh.CMParentColorChanged(var Message: TMessage);
begin
  inherited;
end;

procedure TCustomDBAxisGridEh.CMHintShow(var Message: TCMHintShow);
begin
  inherited;
end;

procedure TCustomDBAxisGridEh.CMHintsShowPause(var Message: TCMHintShowPause);
begin
  inherited;
end;

procedure TCustomDBAxisGridEh.DefaultFillDataHintShowInfo(CursorPos: TPoint;
  Cell: TGridCoord; AxisBar: TAxisBarEh; Params: TDBAxisGridDataHintParamsEh);
var
  TextWidth, DataRight, RightIndent, HitTestX1, EmptyVar: Integer;
  ARect: TRect;
  s: String;
  AAlignment: TAlignment;
  WordWrap: Boolean;
  IsDoShowHint: Boolean;
  TopIndent: Integer;
  ACellRect: TRect;
  ATextAreaRect: TRect;

  function GetToolTipsColumnText(AxisBar: TAxisBarEh): String;
  var KeyIndex: Integer;
  begin
    Result := '';
    if AxisBar.GetBarType in [ctKeyImageList, ctCheckboxes] then
    begin
      if AxisBar.GetBarType = ctKeyImageList
        then KeyIndex := AxisBar.KeyList.IndexOf(AxisBar.Field.Text)
      else KeyIndex := Integer(AxisBar.CheckboxState);
      if (KeyIndex > -1) and (KeyIndex < AxisBar.PickList.Count)
        then Result := AxisBar.PickList.Strings[KeyIndex];
    end
    else if AxisBar.Field <> nil
      then Result := AxisBar.DisplayText;
  end;

begin
  HitTestX1 := HitTest.X;
  s := GetToolTipsColumnText(AxisBar);
  ARect := Params.CursorRect;
  ACellRect := ARect;

  ATextAreaRect := ACellRect;
  AxisBar.SetTextArea(ATextAreaRect);
  DataRight := ATextAreaRect.Right;
  if AxisBar.AlwaysShowEditButton then
  begin
    if DataRight < ARect.Right then
      ARect.Right := DataRight;
    if HitTestX1 > ARect.Right then s := '';
  end;
  ARect.Left := ATextAreaRect.Left;

  AAlignment := AxisBar.Alignment;
  if AxisBar.GetBarType in [ctKeyImageList, ctCheckboxes] then
    AAlignment := taLeftJustify;
  WordWrap := AxisBar.WordWrap and AxisBar.CurLineWordWrap(ACellRect.Bottom-ACellRect.Top);
  if FHintFont = nil then
    FHintFont := TFont.Create;

  FHintFont.Assign(AxisBar.Font);

  AxisBar.FillColCellParams(ColCellParamsEh);
  with ColCellParamsEh do
  begin
    FBackground := Canvas.Brush.Color;
    FFont := FHintFont;
    FState := [];
    FAlignment := AAlignment;
    FText := s;
    FCol := Cell.X;
    FRow := Cell.Y;
    GetCellParams(AxisBar, FFont, FBackground, FState);
    AxisBar.GetColCellParams(False, ColCellParamsEh);
    FFont.Color := clWindowText;
    s := FText;
    AAlignment := FAlignment;
  end;

  Canvas.Font.Assign(FHintFont);

  if WordWrap then RightIndent := 2 else RightIndent := 0;
  if AxisBar.GetBarType in [ctKeyImageList, ctCheckboxes]
    then IsDoShowHint := True
    {$IFDEF FPC}
    else IsDoShowHint := CheckHintTextRect(0,
    {$ELSE}
    else IsDoShowHint := CheckHintTextRect(Self.DrawTextBiDiModeFlagsReadingOnly,
    {$ENDIF}
                        Self.Canvas, RightIndent, FInterlinear,
                        s, ARect, WordWrap, not WordWrap, TextWidth, EmptyVar,
                        AxisBar.Alignment,  AxisBar.EndEllipsis);

  if Flat then TopIndent := 2 else TopIndent := 1;

  if IsDoShowHint or ((AAlignment = taRightJustify) and (DataRight - 2 > ARect.Right)) then
  begin
    Params.HintStr := s;
    Params.CursorRect := ARect;
    case AAlignment of
      taLeftJustify:
        Params.HintPos := Point(ARect.Left - 1, ARect.Top - TopIndent);
      taRightJustify:
        Params.HintPos := Point(DataRight + 1 - TextWidth - 7, ARect.Top - TopIndent);
      taCenter:
        Params.HintPos := Point(DataRight + 1 - TextWidth - 6 +
          TextWidth div 2 - (DataRight - ARect.Left - 4) div 2, ARect.Top - TopIndent);
    end;
    Params.HintPos.X := Params.HintPos.X + (3 - 2);
    if AxisBar.UseRightToLeftAlignment then
      Params.HintPos.X := ClientWidth - Params.HintPos.X;
    if WordWrap then
      Params.HintMaxWidth := ARect.Right - ARect.Left - 4;
  end
  else
    Params.HintStr := '';
end;

procedure TCustomDBAxisGridEh.CMFontChanged(var Message: TMessage);
var
  I: Integer;
begin
  inherited;
  BeginLayout;
  try
    for I := 0 to AxisBars.Count - 1 do
    begin
      AxisBars[I].RefreshDefaultFont;
      AxisBars[I].Title.RefreshDefaultFont;
    end;
  finally
    EndLayout;
  end;
end;

procedure TCustomDBAxisGridEh.CMParentFontChanged(var Message: TCMParentFontChanged);
begin
  inherited;
end;

procedure TCustomDBAxisGridEh.CMDesignHitTest(var Msg: TCMDesignHitTest);
begin
  inherited;
end;

procedure TCustomDBAxisGridEh.CMDeferLayout(var Message: TMessage);
begin
  if AcquireLayoutLock
    then EndLayout
    else DeferLayout;
end;

//{WM messages processing}

procedure TCustomDBAxisGridEh.WMSize(var Message: TWMSize);
begin
  inherited;
end;

procedure TCustomDBAxisGridEh.WMWindowPosChanged(var Message: TWMWindowPosChanged);
begin
  inherited;
end;

procedure TCustomDBAxisGridEh.WMNCCalcSize(var Message: TWMNCCalcSize);
begin
  inherited;
  with Message.CalcSize_Params^ do
  begin
    if ebLeft in Border.EdgeBorders then
      Inc(rgrc[0].Left, FBorderWidth);
    if ebTop in Border.EdgeBorders then
      Inc(rgrc[0].Top, FBorderWidth);
    if ebRight in Border.EdgeBorders then
      Dec(rgrc[0].Right, FBorderWidth);
    if ebBottom in Border.EdgeBorders then
      Dec(rgrc[0].Bottom, FBorderWidth);
  end;
end;

procedure TCustomDBAxisGridEh.WMNCPaint(var Message: TWMNCPaint);
begin
  inherited;
  DrawBorder;
end;

procedure TCustomDBAxisGridEh.ClientAreaSizeChanged;
begin
  if HandleAllocated then
    SetWindowPos(Handle, 0,0,0,0,0, SWP_NOMOVE or SWP_NOSIZE or SWP_NOZORDER or SWP_FRAMECHANGED);
end;

procedure TCustomDBAxisGridEh.WMCommand(var Message: TWMCommand);
begin
  inherited;
  if Message.NotifyCode = EN_CHANGE then
    with Message do
    begin
      if (InplaceEditor <> nil) and (Ctl = InplaceEditor.Handle) then
        TDBAxisGridInplaceEdit(InplaceEditor).UserChange
    end;
end;

procedure TCustomDBAxisGridEh.WMIMEStartComp(var Message: TMessage);
begin
  inherited;
  ShowEditor;
end;

procedure TCustomDBAxisGridEh.WMSetFocus(var Message: TWMSetFocus);
begin
  if not ((InplaceEditor <> nil) and
    (Message.FocusedWnd = InplaceEditor.Handle)) then SetIme;
  inherited;
  if FSelectionActive <> IsSelectionActive then
    SelectionActiveChanged;
end;

procedure TCustomDBAxisGridEh.WMKillFocus(var Message: TWMKillFocus);
begin
  inherited;
  if FSelectionActive <> IsSelectionActive then
    SelectionActiveChanged;
end;

procedure TCustomDBAxisGridEh.SetFocus;
begin
  inherited SetFocus;
end;

procedure TCustomDBAxisGridEh.WMEraseBkgnd(var Message: TWmEraseBkgnd);
begin
  Message.Result := 1;
//  inherited;
end;

procedure TCustomDBAxisGridEh.WndProc(var Message: TMessage);
begin
  inherited WndProc(Message);

{$IFDEF EH_LIB_16}
  if (Message.Msg = WM_NCPAINT) and Border.ExtendedDraw and not (csOverrideStylePaint in ControlStyle) then
    DrawBorder;
{$ENDIF}
end;

function TCustomDBAxisGridEh.AllowedOperationUpdate: Boolean;
begin
  Result := False;
  if not DataLink.Active then Exit;
  Result := (alopUpdateEh in AllowedOperations) or
   (  not (alopUpdateEh in AllowedOperations) and (DataLink.DataSet.State = dsInsert)  );
  Result := Result and not (DataLink.DataSet.IsEmpty and
    not (alopInsertEh in AllowedOperations) and not (alopAppendEh in AllowedOperations));
end;

function TCustomDBAxisGridEh.DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  Result := inherited DoMouseWheelDown(Shift, MousePos)
end;

function TCustomDBAxisGridEh.DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  Result := inherited DoMouseWheelUp(Shift, MousePos)
end;

procedure TCustomDBAxisGridEh.FlatChanged;
begin
  if Flat
    then FInterlinear := 2
    else FInterlinear := 4;
end;

procedure TCustomDBAxisGridEh.DrawEdgeEh(ACanvas: TCanvas; qrc: TRect;
  IsDown, IsSelected: Boolean; Edges: TRectangleEdgesEh; AFlatMode: Boolean);
begin

end;

procedure TCustomDBAxisGridEh.DrawEdgeEh(ACanvas: TCanvas; qrc: TRect;
  IsDown, IsSelected: Boolean; NeedLeft, NeedRight: Boolean; AFlatMode: Boolean);
var
  ThreeDLine: Integer;
  TopLeftFlag, BottomRightFlag: Integer;
begin
  TopLeftFlag := BF_TOPLEFT;
  BottomRightFlag := BF_BOTTOMRIGHT;
  if Self.UseRightToLeftAlignment then
  begin
    WindowsLPtoDP(Canvas.Handle, qrc);
    SwapInt(qrc.Left, qrc.Right);
    ChangeGridOrientation(False);
    TopLeftFlag := BF_TOPRIGHT;
    BottomRightFlag := BF_BOTTOMLEFT;
  end;

  if AFlatMode then
  begin
    if {IsSelected or} IsDown
      then ThreeDLine := BDR_SUNKENINNER
      else ThreeDLine := BDR_RAISEDINNER;

    Canvas.Pen.Color := Canvas.Brush.Color;
    if Self.UseRightToLeftAlignment then
    begin
      Canvas.Polyline([Point(qrc.Left, qrc.Bottom - 1), Point(qrc.Right, qrc.Bottom - 1)]);
      if NeedRight then
        DrawEdge(Canvas.Handle, qrc, ThreeDLine, BF_LEFT);
      DrawEdge(Canvas.Handle, qrc, ThreeDLine, BF_TOP);
      if NeedLeft
        then Canvas.Polyline([Point(qrc.Right - 1, qrc.Bottom - 1), Point(qrc.Right - 1, qrc.Top - 1)]);
    end else
    begin
      if NeedRight
        then Canvas.Polyline([Point(qrc.Left, qrc.Bottom - 1), Point(qrc.Right - 1, qrc.Bottom - 1), Point(qrc.Right - 1, qrc.Top - 1)])
        else Canvas.Polyline([Point(qrc.Left, qrc.Bottom - 1), Point(qrc.Right, qrc.Bottom - 1)]);
      if NeedLeft
        then DrawEdge(Canvas.Handle, qrc, ThreeDLine, TopLeftFlag)
        else DrawEdge(Canvas.Handle, qrc, ThreeDLine, BF_TOP);
    end;
  end else
  begin
    if {IsSelected or} IsDown
      then ThreeDLine := BDR_SUNKENINNER
      else ThreeDLine := BDR_RAISEDINNER;
    if NeedLeft and NeedRight then
      DrawEdge(Canvas.Handle, qrc, ThreeDLine, BF_RECT)
    else
    begin
      if NeedLeft
        then DrawEdge(Canvas.Handle, qrc, ThreeDLine, TopLeftFlag)
        else DrawEdge(Canvas.Handle, qrc, ThreeDLine, BF_TOP);
      if NeedRight
        then DrawEdge(Canvas.Handle, qrc, ThreeDLine, BottomRightFlag)
        else DrawEdge(Canvas.Handle, qrc, ThreeDLine, BF_BOTTOM);
    end;
  end;
  if Self.UseRightToLeftAlignment then ChangeGridOrientation(True);
end;

procedure TCustomDBAxisGridEh.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    if Border.ExtendedDraw then
//    if Flat and (Ctl3D = True) and not Self.Style.IsCustomStyleActive then
    begin
      Style := Style and not WS_BORDER;
      ExStyle := ExStyle and not WS_EX_CLIENTEDGE;
      if (BorderStyle = bsSingle)
        then FBorderWidth := 1
        else FBorderWidth := 0;
    end else
      FBorderWidth := 0;
    Style := Style or WS_CLIPCHILDREN; //To avoid black box in Inplace editor When BufferedPaint.
  end;
end;

function TCustomDBAxisGridEh.InplaceEditorVisible: Boolean;
begin
  Result := (InplaceEditor <> nil) and (InplaceEditor.Visible);
end;

procedure TCustomDBAxisGridEh.SetReadOnly(const Value: Boolean);
begin
  if Value <> FReadOnly then
  begin
    FReadOnly := Value;
    Invalidate();
    if not (csReading in ComponentState) then
    begin
      SetColumnAttributes;
      DataChanged;
    end;
  end;
end;

procedure TCustomDBAxisGridEh.SetColumnDefValues(const Value: TAxisBarDefValuesEh);
begin
  FColumnDefValues.Assign(Value);
end;

procedure TCustomDBAxisGridEh.InvalidateCol(ACol: Integer);
begin
  inherited InvalidateCol(ACol);
end;

procedure TCustomDBAxisGridEh.InvalidateRow(ARow: Integer);
begin
  inherited InvalidateRow(ARow);
end;

procedure TCustomDBAxisGridEh.Invalidate;
var
  i: Integer;
begin
  if csDestroying in ComponentState then Exit;
  inherited Invalidate;
  for i := 0 to ControlCount-1 do
    Controls[i].Invalidate;
end;

procedure TCustomDBAxisGridEh.InvalidateCell(ACol, ARow: Longint);
begin
  inherited InvalidateCell(ACol, ARow);
end;

{procedure TCustomDBAxisGridEh.ScrollData(DX, DY: Integer);
begin
  inherited ScrollData(DX, DY);
end;
}

procedure TCustomDBAxisGridEh.SetIncludeImageModules(const Value: TIncludeImageModulesEh);
begin
  FIncludeImageModules := Value;
// Recompile project to force Compiler add required Untis to 'uses' clause
end;

procedure TCustomDBAxisGridEh.SetDynProps(const Value: TDynVarsEh);
begin
  FDynProps.Assign(Value);
end;

function TCustomDBAxisGridEh.CreateDataLink: TAxisGridDataLinkEh;
begin
  Result := TAxisGridDataLinkEh.Create(Self);
end;

function TCustomDBAxisGridEh.GetColCellParamsEh: TAxisColCellParamsEh;
begin
  Result := FColCellParamsEh;
end;

function TCustomDBAxisGridEh.CreateColCellParamsEh: TAxisColCellParamsEh;
begin
  Result := TAxisColCellParamsEh.Create;
end;

function TCustomDBAxisGridEh.GetDataCellHorzOffset(AxisBar: TAxisBarEh): Integer;
begin
  Result := 3;
end;

function TCustomDBAxisGridEh.GetCellTreeElmentsAreaWidth: Integer;
begin
  Result := 0;
end;

procedure TCustomDBAxisGridEh.GetColRowForAxisCol(AxisBar: TAxisBarEh;
  var ACol, ARow: Integer);
begin
  ACol := Col;
  ACol := Row;
end;

procedure TCustomDBAxisGridEh.CancelEditing;
begin

end;

function TCustomDBAxisGridEh.DefaultTitleAlignment: TAlignment;
begin
  Result := taLeftJustify;
end;

function TCustomDBAxisGridEh.DefaultTitleColor: TColor;
begin
  Result := FixedColor;
end;

function TCustomDBAxisGridEh.GetSelectionInactiveColor: TColor;
begin
  Result := ColorToGray(clHighlight);
end;

function TCustomDBAxisGridEh.AxisColumnsStorePropertyName: String;
begin
  Result := '<Define property Name>';
end;

function TCustomDBAxisGridEh.IsFixed3D: Boolean;
begin
  Result := True;
end;

procedure TCustomDBAxisGridEh.GetThemeTitleFillRect(var AFillRect: TRect;
  IncVerBoundary, IncHorzBoundary: Boolean);
begin
  if IncHorzBoundary then
    Inc(AFillRect.Bottom, 2);
  if IncVerBoundary then
    Inc(AFillRect.Right, 2);
end;

function TCustomDBAxisGridEh.GetDataEditButtonTransparency(ACol, ARow: Longint; ARect: TRect; Params: TAxisColCellParamsEh): Integer;
begin
  Result := 0;
end;

procedure TCustomDBAxisGridEh.FillBlankDataCellRect(ARect: TRect;
  IsSelected: Boolean; Cell3D: Boolean; Params: TAxisColCellParamsEh);
var
  AClipRec: TRect;  
begin
  AClipRec := ARect;

  if Params.DrawCellByThemes
    then FillCellRect(cfstThemedEh, ARect, False, IsSelected, AClipRec, Cell3D)
    else FillCellRect(GetDefaultFixedCellFillStyle, ARect, False, IsSelected, AClipRec, Cell3D);
end;

procedure TCustomDBAxisGridEh.GetDefaultFixedGradientColor(var AStartColor,
  AEndColor: TColor; IsTrack, IsPressed: Boolean);
var
  DummyFillColor, DummyTextColor: TColor;
begin
  GetCustomStyleFixedColors(DummyFillColor, DummyTextColor,
    AStartColor, AEndColor, cfstGradientEh, IsTrack, IsPressed);
end;

procedure TCustomDBAxisGridEh.GetCustomStyleFixedColors(var AFillColor,
  ATextColor, AStartColor, AEndColor: TColor; FillStyle: TGridCellFillStyleEh;
  IsTrack, IsPressed: Boolean);
{$IFDEF EH_LIB_16}
const
  CFixedStates: array[Boolean, Boolean] of TThemedGrid = (
    (tgFixedCellNormal, tgFixedCellPressed),
    (tgFixedCellHot, tgFixedCellPressed));
  CFixedGradientStates: array[Boolean, Boolean] of TThemedGrid = (
    (tgGradientFixedCellNormal, tgGradientFixedCellPressed),
    (tgGradientFixedCellHot, tgGradientFixedCellPressed));
  CFixedClassicStates: array[Boolean, Boolean] of TThemedGrid = (
    (tgClassicFixedCellNormal, tgClassicFixedCellPressed),
    (tgClassicFixedCellHot, tgClassicFixedCellPressed));
var
  LDetails: TThemedElementDetails;
  LStyle: TCustomStyleServices;
{$ENDIF}
begin
  AFillColor := clNone;
  ATextColor := clNone;
  AStartColor := clNone;
  AEndColor := clNone;
  if not IsCustomStyleActive then
    Exit;
{$IFDEF EH_LIB_16}
  LStyle := StyleServices;
  if FillStyle = cfstThemedEh then
  begin
    LDetails := LStyle.GetElementDetails(CFixedStates[IsTrack, IsPressed]);
    LStyle.GetElementColor(LDetails, ecFillColor, AFillColor);
    LStyle.GetElementColor(LDetails, ecTextColor, ATextColor);
  end else if FillStyle = cfstGradientEh then
  begin
    LDetails := LStyle.GetElementDetails(CFixedGradientStates[IsTrack, IsPressed]);
    LStyle.GetElementColor(LDetails, ecFillColor, AFillColor);
    LStyle.GetElementColor(LDetails, ecTextColor, ATextColor);
    LStyle.GetElementColor(LDetails, ecGradientColor1, AStartColor);
    LStyle.GetElementColor(LDetails, ecGradientColor2, AEndColor);
  end else if FillStyle = cfstSolidEh  then
  begin
    LDetails := LStyle.GetElementDetails(CFixedClassicStates[IsTrack, IsPressed]);
    LStyle.GetElementColor(LDetails, ecFillColor, AFillColor);
    LStyle.GetElementColor(LDetails, ecTextColor, ATextColor);
  end;
{$ENDIF}
end;

function TCustomDBAxisGridEh.IsCustomStyleActive: Boolean;
begin
{$IFDEF EH_LIB_16}
  Result := TStyleManager.IsCustomStyleActive;
{$ELSE}
  Result := False;
{$ENDIF}
end;

function TCustomDBAxisGridEh.DesignHitTestObject(XPos, YPos: Integer): TPersistent;
begin
  Result := nil;
end;

procedure TCustomDBAxisGridEh.FocusCell(ACol, ARow: Longint; MoveAnchor: Boolean);
begin
  inherited FocusCell(ACol, ARow, MoveAnchor);
end;

function TCustomDBAxisGridEh.CreateGridLineColors: TGridLineColorsEh;
begin
  Result := TDBAxisGridLineParamsEh.Create(Self);
end;

function TCustomDBAxisGridEh.GetGridLineParams: TDBAxisGridLineParamsEh;
begin
  Result := TDBAxisGridLineParamsEh(inherited GridLineColors);
end;

procedure TCustomDBAxisGridEh.SetGridLineParams(const Value: TDBAxisGridLineParamsEh);
begin
  inherited GridLineColors := Value;
end;

procedure TCustomDBAxisGridEh.SetAllowedOperations(
  const Value: TDBGridEhAllowedOperations);
begin
  if FAllowedOperations <> Value then
  begin
    FAllowedOperations := Value;
    if not (csDestroying in ComponentState) then
      DataLink.LayoutChanged;
  end;
end;

function TCustomDBAxisGridEh.GetSortMarkerStyle: TSortMarkerStyleEh;
begin
  Result := smstDefaultEh;
end;

procedure TCustomDBAxisGridEh.LookupStateChanged(AxisBar: TAxisBarEh);
begin
end;

function TCustomDBAxisGridEh.IsEditButtonsBoxVisible: Boolean;
begin
  Result := (FEditButtonsBox <> nil) and FEditButtonsBox.Visible;
end;

function TCustomDBAxisGridEh.GetEditButtonsBox: TEditButtonsBoxEh;
begin
  if FEditButtonsBox = nil then
  begin
    FEditButtonsBox := TEditButtonsBoxEh.Create(Self);
    FEditButtonsBox.SetBounds(0,0,0,0);
    FEditButtonsBox.Visible := False;
    FEditButtonsBox.Parent := Self;
    FEditButtonsBox.OnCreateEditButtonControl := CreateEditButtonControl;
  end;
  Result := FEditButtonsBox;
end;

procedure TCustomDBAxisGridEh.CreateEditButtonControl(var EditButtonControl: TEditButtonControlEh);
begin
  EditButtonControl := TEditButtonControlEh.Create(Self);
  with EditButtonControl do
  begin
    ControlStyle := ControlStyle + [csReplicatable];
    Width := 10;
    Height := 17;
    Visible := True;
    Transparent := False;
  end;
end;

procedure TCustomDBAxisGridEh.UpdateEditButtonsBox;
var
  AxisBar: TAxisBarEh;
  ACellRect, AxisBarRect: TRect;
begin
  if (SelectedIndex >= 0) and (SelectedIndex < AxisBars.Count) then
  begin
    AxisBar := AxisBars[SelectedIndex];
    if AxisBar.IsEditButtonsBoxRequired then
    begin
      ACellRect := CellRect(Col, Row);
      AxisBarRect := AxisBar.AxisBarRect(ACellRect);
      AxisBar.UpdateEditButtonsBox(GetEditButtonsBox, AxisBarRect);
    end else
      HideEditButtonsBox;
  end else
    HideEditButtonsBox;
end;

procedure TCustomDBAxisGridEh.HideEditButtonsBox;
begin
  if (FEditButtonsBox <> nil) and FEditButtonsBox.Visible then
    FEditButtonsBox.Hide;
end;

procedure TCustomDBAxisGridEh.CurrentCellMoved(OldCurrent: TGridCoord);
begin
  inherited CurrentCellMoved(OldCurrent);
  UpdateEditButtonsBox;
end;

procedure TCustomDBAxisGridEh.EditButtonDefaultAction(EditControl: TControl;
  EditButton: TEditButtonEh; EditButtonControl: TEditButtonControlEh;
  IsMouseDown: Boolean; var Handled: Boolean);
begin
  Center.EditButtonDefaultAction(Self, AxisBars[SelectedIndex], EditControl,
    EditButton, EditButtonControl, IsMouseDown, Handled);
end;

procedure TCustomDBAxisGridEh.FormSystemPopupMenuForAxisBar(AxisBar: TAxisBarEh; APopupMenu: TPopupMenu);
begin
  Center.FormSystemPopupMenuForColumn(Self, AxisBar, APopupMenu);
end;

function TCustomDBAxisGridEh.GetCenter: TDBAxisGridEhCenter;
begin
  Result := DBAxisGridEhCenter;
end;

{ TAxisBarCaptionDefValuesEh }

procedure TAxisBarCaptionDefValuesEh.Assign(Source: TPersistent);
begin
  if Source is TAxisBarCaptionDefValuesEh then
  begin
    if cvdpTitleAlignmentEh in FAssignedValues then
      Alignment := TAxisBarCaptionDefValuesEh(Source).Alignment;
    if cvdpTitleColorEh in FAssignedValues then
      Color := TAxisBarCaptionDefValuesEh(Source).Color;
    EndEllipsis := TAxisBarCaptionDefValuesEh(Source).EndEllipsis;
    TitleButton := TAxisBarCaptionDefValuesEh(Source).TitleButton;
    ToolTips := TAxisBarCaptionDefValuesEh(Source).ToolTips;
    Orientation := TAxisBarCaptionDefValuesEh(Source).Orientation;
  end else
    inherited Assign(Source);
end;

constructor TAxisBarCaptionDefValuesEh.Create(AxisBarDefValues: TAxisBarDefValuesEh);
begin
  inherited Create;
  FColumnDefValues := AxisBarDefValues;
end;

function TAxisBarCaptionDefValuesEh.DefaultAlignment: TAlignment;
begin
  Result := FColumnDefValues.FGrid.DefaultTitleAlignment;
end;

function TAxisBarCaptionDefValuesEh.DefaultColor: TColor;
begin
  Result := FColumnDefValues.FGrid.DefaultTitleColor
end;

function TAxisBarCaptionDefValuesEh.GetAlignment: TAlignment;
begin
  if cvdpTitleAlignmentEh in FAssignedValues
    then Result := FAlignment
    else Result := DefaultAlignment;
end;

function TAxisBarCaptionDefValuesEh.GetColor: TColor;
begin
  if cvdpTitleColorEh in FAssignedValues
    then Result := FColor
    else Result := DefaultColor;
end;

function TAxisBarCaptionDefValuesEh.IsAlignmentStored: Boolean;
begin
  Result := (cvdpTitleAlignmentEh in FAssignedValues) and (FAlignment <> DefaultAlignment);
end;

function TAxisBarCaptionDefValuesEh.IsColorStored: Boolean;
begin
  Result := (cvdpTitleColorEh in FAssignedValues) and (FColor <> DefaultColor);
end;

procedure TAxisBarCaptionDefValuesEh.SetAlignment(const Value: TAlignment);
begin
  if (cvdpTitleAlignmentEh in FAssignedValues) and (Value = FAlignment) then Exit;
  FAlignment := Value;
  Include(FAssignedValues, cvdpTitleAlignmentEh);
  FColumnDefValues.FGrid.LayoutChanged;
end;

procedure TAxisBarCaptionDefValuesEh.SetColor(const Value: TColor);
begin
  if (cvdpTitleColorEh in FAssignedValues) and (Value = FColor) then Exit;
  FColor := Value;
  Include(FAssignedValues, cvdpTitleColorEh);
  FColumnDefValues.FGrid.Invalidate;
end;

procedure TAxisBarCaptionDefValuesEh.SetEndEllipsis(const Value: Boolean);
begin
  if FEndEllipsis <> Value then
  begin
    FEndEllipsis := Value;
    FColumnDefValues.FGrid.Invalidate;
  end;
end;

procedure TAxisBarCaptionDefValuesEh.SetOrientation(const Value: TTextOrientationEh);
begin
  if FOrientation <> Value then
  begin
    FOrientation := Value;
    FColumnDefValues.FGrid.LayoutChanged;
  end;
end;

{ TColumnFooterDefValuesEh }

procedure TColumnFooterDefValuesEh.Assign(Source: TPersistent);
begin
  if Source is TColumnFooterDefValuesEh then
  begin
    ToolTips := TColumnFooterDefValuesEh(Source).ToolTips;
  end else
    inherited Assign(Source);
end;

{ TAxisBarDefValuesEh }

constructor TAxisBarDefValuesEh.Create(Grid: TCustomDBAxisGridEh);
begin
  inherited Create;
  FGrid := Grid;
  FTitle := CreateAxisBarCaptionDefValues;
  FLayout := tlTop;
end;

destructor TAxisBarDefValuesEh.Destroy;
begin
  FreeAndNil(FTitle);
  inherited;
end;

procedure TAxisBarDefValuesEh.Assign(Source: TPersistent);
begin
  if Source is TAxisBarDefValuesEh then
  begin
    Title := TAxisBarDefValuesEh(Source).Title;
    AlwaysShowEditButton := TAxisBarDefValuesEh(Source).AlwaysShowEditButton;
    EndEllipsis := TAxisBarDefValuesEh(Source).EndEllipsis;
    AutoDropDown := TAxisBarDefValuesEh(Source).AutoDropDown;
    DblClickNextVal := TAxisBarDefValuesEh(Source).DblClickNextVal;
    ToolTips := TAxisBarDefValuesEh(Source).ToolTips;
    DropDownSizing := TAxisBarDefValuesEh(Source).DropDownSizing;
    DropDownShowTitles := TAxisBarDefValuesEh(Source).DropDownShowTitles;
  end else
    inherited Assign(Source);
end;

procedure TAxisBarDefValuesEh.SetAlwaysShowEditButton(const Value: Boolean);
begin
  if FAlwaysShowEditButton <> Value then
  begin
    FAlwaysShowEditButton := Value;
    FGrid.Invalidate;
  end;
end;

procedure TAxisBarDefValuesEh.SetEndEllipsis(const Value: Boolean);
begin
  if FEndEllipsis <> Value then
  begin
    FEndEllipsis := Value;
    FGrid.Invalidate;
  end;
end;

procedure TAxisBarDefValuesEh.SetTitle(const Value: TAxisBarCaptionDefValuesEh);
begin
  FTitle.Assign(Value);
end;

procedure TAxisBarDefValuesEh.SetLayout(Value: TTextLayout);
begin
  if FLayout <> Value then
  begin
    FLayout := Value;
    FGrid.Invalidate;
  end;
end;

procedure TAxisBarDefValuesEh.SetHighlightRequired(Value: Boolean);
begin
  if FHighlightRequired <> Value then
  begin
    FHighlightRequired := Value;
    FGrid.Invalidate;
  end;
end;

function TAxisBarDefValuesEh.CreateAxisBarCaptionDefValues: TAxisBarCaptionDefValuesEh;
begin
  Result := TAxisBarCaptionDefValuesEh.Create(Self);
end;

{ TAxisBarsEhList }

constructor TAxisBarsEhList.Create;
begin
  inherited Create;
  OwnsObjects := False;
end;

function TAxisBarsEhList.GetAxisBar(Index: Integer): TAxisBarEh;
begin
  Result := TAxisBarEh(Get(Index));
end;

procedure TAxisBarsEhList.SetAxisBar(Index: Integer; const Value: TAxisBarEh);
begin
  Put(Index, Value);
end;

{ TColumnDropDownBoxEh }

constructor TColumnDropDownBoxEh.Create(Owner: TPersistent);
begin
  inherited Create;
  FOwner := Owner;
  FSpecRow := TSpecRowEh.Create(Self);
  FAutoFitColWidths := True;
end;

destructor TColumnDropDownBoxEh.Destroy;
begin
  FreeAndNil(FSpecRow);
  inherited;
end;

procedure TColumnDropDownBoxEh.Assign(Source: TPersistent);
begin
  if Source is TColumnDropDownBoxEh then
  begin
    Align := TColumnDropDownBoxEh(Source).Align;
    AutoDrop := TColumnDropDownBoxEh(Source).AutoDrop;
    AutoFitColWidths := TColumnDropDownBoxEh(Source).AutoFitColWidths;
    ColumnDefValues := TColumnDropDownBoxEh(Source).ColumnDefValues;
    if TColumnDropDownBoxEh(Source).Columns.State = csCustomized // To avoid round asign
      then Columns := TColumnDropDownBoxEh(Source).Columns
      else Columns.Clear;
    Options := TColumnDropDownBoxEh(Source).Options;
    Rows := TColumnDropDownBoxEh(Source).Rows;
    Width := TColumnDropDownBoxEh(Source).Width;
    Sizable := TColumnDropDownBoxEh(Source).Sizable;
    ShowTitles := TColumnDropDownBoxEh(Source).ShowTitles;
    UseMultiTitle := TColumnDropDownBoxEh(Source).UseMultiTitle;
    ListSource := TColumnDropDownBoxEh(Source).ListSource;
  end else
    inherited Assign(Source);
end;

procedure TColumnDropDownBoxEh.SetSpecRow(const Value: TSpecRowEh);
begin
  FSpecRow.Assign(Value);
end;

function TColumnDropDownBoxEh.GetColumns: TBaseColumnsEh;
var LookupGridOwner: ILookupGridOwner;
begin
  Result := nil;
  if Supports(FOwner, ILookupGridOwner, LookupGridOwner) then
    Result := TBaseColumnsEh(LookupGridOwner.GetLookupGrid.AxisBars);
end;

procedure TColumnDropDownBoxEh.SetColumns(const Value: TBaseColumnsEh);
var LookupGridOwner: ILookupGridOwner;
begin
  if Supports(FOwner, ILookupGridOwner, LookupGridOwner) then
    LookupGridOwner.GetLookupGrid.AxisBars.Assign(Value);
end;

function TColumnDropDownBoxEh.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

function TColumnDropDownBoxEh.StoreColumns: Boolean;
begin
  Result := Columns.State = csCustomized;
end;

function TColumnDropDownBoxEh.GetAutoFitColWidths: Boolean;
begin
  Result := FAutoFitColWidths;
end;

procedure TColumnDropDownBoxEh.SetAutoFitColWidths(const Value: Boolean);
begin
  FAutoFitColWidths := Value;
end;

function TColumnDropDownBoxEh.GetColumnDefValues: TCustomColumnDefValuesEh;
var
  LookupGridOwner: ILookupGridOwner;
begin
  Result := nil;
  if Supports(FOwner, ILookupGridOwner, LookupGridOwner) then
    Result := TCustomColumnDefValuesEh(LookupGridOwner.GetLookupGrid.AxisBarDefValues);
end;

procedure TColumnDropDownBoxEh.SetColumnDefValues(const Value: TCustomColumnDefValuesEh);
var LookupGridOwner: ILookupGridOwner;
begin
  if Supports(FOwner, ILookupGridOwner, LookupGridOwner) then
    LookupGridOwner.GetLookupGrid.AxisBarDefValues.Assign(Value);
end;

function TColumnDropDownBoxEh.GetOptions: TDBLookupGridEhOptions;
var
  LookupGridOwner: ILookupGridOwner;
begin
  if Supports(FOwner, ILookupGridOwner, LookupGridOwner) then
    Result := LookupGridOwner.Options;
end;

procedure TColumnDropDownBoxEh.SetOptions(const Value: TDBLookupGridEhOptions);
var LookupGridOwner: ILookupGridOwner;
begin
  if Supports(FOwner, ILookupGridOwner, LookupGridOwner) then
    LookupGridOwner.Options := Value;
end;

function TColumnDropDownBoxEh.GetListSource: TDataSource;
begin
  Result := FListSource;
end;

procedure TColumnDropDownBoxEh.SetListSource(const Value: TDataSource);
var
  LookupGridOwner: ILookupGridOwner;
begin
  if FListSource <> Value then
  begin
    FListSource := Value;
    if Supports(FOwner, ILookupGridOwner, LookupGridOwner) then
      LookupGridOwner.SetListSource(Value);
  end;
end;

procedure TColumnDropDownBoxEh.SetSortLocal(const Value: Boolean);
var
  LookupGridOwner: ILookupGridOwner;
begin
  if Supports(FOwner, ILookupGridOwner, LookupGridOwner) then
    TPopupDataGridEh(LookupGridOwner.GetLookupGrid).SortLocal := Value;
end;

function TColumnDropDownBoxEh.GetSortLocal: Boolean;
var
  LookupGridOwner: ILookupGridOwner;
begin
  Result := False;
  if Supports(FOwner, ILookupGridOwner, LookupGridOwner) then
    Result := TPopupDataGridEh(LookupGridOwner.GetLookupGrid).SortLocal;
end;

function TColumnDropDownBoxEh.GetLikeWildcardForSeveralCharacters: String;
var
  IntMemTable: IMemTableEh;
  DatasetFeatures: TDatasetFeaturesEh;
begin
  Result := '*';
  if (ListSource <> nil) and (ListSource.DataSet <> nil) then
  begin
    if Supports(ListSource.DataSet, IMemTableEh, IntMemTable) then
      Result := IntMemTable.GetLikeWildcardForSeveralCharacters
    else
    begin
      DatasetFeatures := GetDatasetFeaturesForDataSet(ListSource.DataSet);
      if DatasetFeatures <> nil then
        Result := DatasetFeatures.GetLikeWildcardForSeveralCharacters;
    end;
  end;
end;

function TColumnDropDownBoxEh.GetActualListField: String;
var
  Pos: Integer;
begin
  Result := '';
  if ListFieldNames <> '' then
  begin
    Pos := 1;
    Result := ExtractFieldName(ListFieldNames, Pos);
  end;
end;

{ TDBAxisGridLineParamsEh }

constructor TDBAxisGridLineParamsEh.Create(AGrid: TCustomGridEh);
begin
  inherited Create(AGrid);
  FDataBoundaryColor := clDefault;
  FVertEmptySpaceStyle := dessGradiendEh;
end;

function TDBAxisGridLineParamsEh.GetActualColorScheme: TDBGridLinesColorSchemeEh;
begin
  raise Exception.Create('Realize GetActualColorScheme in an inherited class');
  Result := glcsDefaultEh;
end;

function TDBAxisGridLineParamsEh.GetBrightColor: TColor;
{$IFDEF EH_LIB_16}
const
  CCellStates: array[TDBGridLinesColorSchemeEh] of TThemedGrid =
    (tgCellNormal, tgClassicCellNormal, tgGradientCellNormal, tgCellNormal);
    //glcsDefaultEh,    glcsClassicEh,            glcsFlatEh,                glcsThemedEh
var
  LStyle: TCustomStyleServices;
{$ENDIF}
begin
{$IFDEF EH_LIB_7}
  if BrightColor = clDefault then
  begin
  {$IFDEF EH_LIB_16}
    if Grid.IsCustomStyleActive then
    begin
      LStyle := StyleServices;
      LStyle.GetElementColor(LStyle.GetElementDetails(CCellStates[GetActualColorScheme]), ecBorderColor, Result);
    end else
  {$ENDIF}
    if {Grid.DrawTitleByThemes and} ThemesEnabled {and (Win32MajorVersion >= 6)} and (GetActualColorScheme = glcsThemedEh) then
      Result := clBtnFace
    else
      Result := inherited GetBrightColor
  end else
    Result := inherited GetBrightColor;
{$ELSE}
  Result := inherited GetBrightColor;
{$ENDIF}
end;

function TDBAxisGridLineParamsEh.GetDarkColor: TColor;
{$IFDEF EH_LIB_16}
const
  CFixedStates: array[TDBGridLinesColorSchemeEh] of TThemedGrid =
    (tgFixedCellNormal, tgClassicFixedCellNormal, tgGradientFixedCellNormal, tgFixedCellNormal);
    //glcsDefaultEh,    glcsClassicEh,            glcsFlatEh,                glcsThemedEh
{$ENDIF}
{$IFDEF FPC}
{$ELSE}
var
  LColorRef: TColorRef;
{$ENDIF}
{$IFDEF EH_LIB_16}
  LStyle: TCustomStyleServices;
{$ENDIF}
begin
  if DarkColor = clDefault then
  begin
  {$IFDEF EH_LIB_7}
  {$IFDEF EH_LIB_16}
    if Grid.IsCustomStyleActive then
    begin
      LStyle := StyleServices;
      LStyle.GetElementColor(LStyle.GetElementDetails(CFixedStates[GetActualColorScheme]), ecBorderColor, Result);
    end else
  {$ENDIF}
    {$IFDEF FPC}
    {$ELSE}
    if {Grid.DrawTitleByThemes and} ThemesEnabled and (Win32MajorVersion >= 6) and (GetActualColorScheme = glcsThemedEh) then
    begin
      GetThemeColor(ThemeServices.Theme[teHeader], HP_HEADERITEM, HIS_NORMAL,
        TMT_EDGEFILLCOLOR, LColorRef);
      Result := LColorRef;
    end else
    {$ENDIF}
  {$ENDIF}
    if GetActualColorScheme = glcsFlatEh then
      Result := clGray
    else if GetActualColorScheme = glcsThemedEh then
      Result := $B8C7CB
    else if ThemesEnabled and (GetActualColorScheme = glcsClassicEh) then
      Result := cl3DDkShadow
    else
      Result := {cl3DDkShadow;//}clBlack;
  end else
    Result := inherited GetDarkColor;
end;

function TDBAxisGridLineParamsEh.GetDataBoundaryColor: TColor;
begin
  if DataBoundaryColor <> clDefault then
    Result := DataBoundaryColor
  else
  begin
    if (GetDataVertColor = GetDataHorzColor) and
       (GetDataVertColor <> clNone)
    then
      Result := GetDarkColor
    else
      Result := MightierColor(GetDataVertColor, GetDataHorzColor);
  end;
end;

function TDBAxisGridLineParamsEh.GetDataHorzLines: Boolean;
begin
  if DataHorzLinesStored
    then Result := FDataHorzLines
    else Result := DefaultDataHorzLines;
end;

function TDBAxisGridLineParamsEh.IsDataHorzLinesStored: Boolean;
begin
  Result := FDataHorzLinesStored;
end;

procedure TDBAxisGridLineParamsEh.SetDataHorzLines(const Value: Boolean);
begin
  if DataHorzLinesStored and (Value = FDataHorzLines) then Exit;
  DataHorzLinesStored := True;
  FDataHorzLines := Value;
  Grid.Invalidate;
end;

procedure TDBAxisGridLineParamsEh.SetDataHorzLinesStored(const Value: Boolean);
begin
  if (Value = True) and (IsDataHorzLinesStored = False) then
  begin
    FDataHorzLinesStored := True;
    FDataHorzLines := DefaultDataHorzLines;
    Grid.Invalidate;
  end else if (Value = False) and (IsDataHorzLinesStored = True) then
  begin
    FDataHorzLinesStored := False;
    FDataHorzLines := DefaultDataHorzLines;
    Grid.Invalidate;
  end;
end;

function TDBAxisGridLineParamsEh.DefaultDataHorzLines: Boolean;
begin
  raise Exception.Create('Realize DefaultDataHorzLines in an inherited class');
  Result := False;
end;

function TDBAxisGridLineParamsEh.GetDataVertLines: Boolean;
begin
  if DataVertLinesStored
    then Result := FDataVertLines
    else Result := DefaultDataVertLines;
end;

function TDBAxisGridLineParamsEh.IsDataVertLinesStored: Boolean;
begin
  Result := FDataVertLinesStored;
end;

procedure TDBAxisGridLineParamsEh.SetDataVertLines(const Value: Boolean);
begin
  if DataVertLinesStored and (Value = FDataVertLines) then Exit;
  DataVertLinesStored := True;
  FDataVertLines := Value;
  Grid.Invalidate;
end;

procedure TDBAxisGridLineParamsEh.SetDataVertLinesStored(const Value: Boolean);
begin
  if (Value = True) and (IsDataVertLinesStored = False) then
  begin
    FDataVertLinesStored := True;
    FDataVertLines := DefaultDataVertLines;
    Grid.Invalidate;
  end else if (Value = False) and (IsDataVertLinesStored = True) then
  begin
    FDataVertLinesStored := False;
    FDataVertLines := DefaultDataVertLines;
    Grid.Invalidate;
  end;
end;

function TDBAxisGridLineParamsEh.DefaultDataVertLines: Boolean;
begin
  raise Exception.Create('Realize DefaultDataVertLines in an inherited class');
  Result := False;
end;

function TDBAxisGridLineParamsEh.GetGrid: TCustomDBAxisGridEh;
begin
  Result := TCustomDBAxisGridEh(inherited Grid);
end;

function TDBAxisGridLineParamsEh.GetVertAreaContraVertColor: TColor;
begin
  Result := inherited GetVertAreaContraVertColor;
end;

procedure TDBAxisGridLineParamsEh.SetColorScheme(const Value: TDBGridLinesColorSchemeEh);
begin
  if Value <> FColorScheme then
  begin
    FColorScheme := Value;
    Grid.Invalidate;
  end;
end;

procedure TDBAxisGridLineParamsEh.SetDataBoundaryColor(const Value: TColor);
begin
  if Value <> FDataBoundaryColor then
  begin
    FDataBoundaryColor := Value;
    Grid.Invalidate;
  end;
end;

function TDBAxisGridLineParamsEh.GetGridBoundaries: Boolean;
begin
  Result := FGridBoundaries;
end;

procedure TDBAxisGridLineParamsEh.SetGridBoundaries(const Value: Boolean);
begin
  if Value <> FGridBoundaries then
  begin
    FGridBoundaries := Value;
    Grid.Invalidate;
  end;
end;

procedure TDBAxisGridLineParamsEh.SetVertEmptySpaceStyle(const Value: TDrawEmptySpaceStyle);
begin
  if Value <> FVertEmptySpaceStyle then
  begin
    FVertEmptySpaceStyle := Value;
    Grid.Invalidate;
  end;
end;

{ TControlBorderEh }

constructor TControlBorderEh.Create(AGrid: TCustomDBAxisGridEh);
begin
  inherited Create;
  FGrid := AGrid;
  FEdgeBorders := [ebLeft, ebTop, ebRight, ebBottom];
  FColor := clDefault;
end;

destructor TControlBorderEh.Destroy;
begin
  inherited Destroy;
end;

function TControlBorderEh.GetCtl3D: Boolean;
begin
  Result := FGrid.Ctl3D;
end;

procedure TControlBorderEh.SetCtl3D(Value: Boolean);
begin
  {$IFDEF FPC}
  {$ELSE}
  FGrid.Ctl3D := Value;
  {$ENDIF}
end;

function TControlBorderEh.GetStyle: TBorderStyle;
begin
  Result := FGrid.BorderStyle;
end;

procedure TControlBorderEh.SetStyle(Value: TBorderStyle);
begin
  FGrid.BorderStyle := Value;
end;

procedure TControlBorderEh.SetColor(Value: TColor);
begin
  if FColor <> Value then
  begin
    FOldExtendedDraw := DefaultExtendedDraw;
    FColor := Value;
    FGrid.ClientAreaSizeChanged;
    UpdateExtendedDraw;
  end;
end;

procedure TControlBorderEh.SetEdgeBorders(Value: TEdgeBorders);
begin
  if FEdgeBorders <> Value then
  begin
    FOldExtendedDraw := DefaultExtendedDraw;
    FEdgeBorders := Value;
    FGrid.ClientAreaSizeChanged;
    UpdateExtendedDraw;
  end;
end;

function TControlBorderEh.DefaultExtendedDraw: Boolean;
begin
  Result := FGrid.Flat and
    ( (Ctl3D = True) or
      ( (Ctl3D = False) and ( (Color <> clDefault) or (EdgeBorders <> [ebLeft, ebTop, ebRight, ebBottom]))
       )
    );
end;

function TControlBorderEh.GetExtendedDraw: Boolean;
begin
  if ExtendedDrawStored
    then Result := FExtendedDraw
    else Result := DefaultExtendedDraw;
end;

procedure TControlBorderEh.SetExtendedDraw(const Value: Boolean);
begin
  if ExtendedDrawStored and (Value = FExtendedDraw) then Exit;
  ExtendedDrawStored := True;
  FExtendedDraw := Value;
  FGrid.RecreateWndHandle;
end;

function TControlBorderEh.IsExtendedDrawStored: Boolean;
begin
  Result := FExtendedDrawStored;
end;

procedure TControlBorderEh.SetExtendedDrawStored(const Value: Boolean);
begin
  if (Value = True) and (IsExtendedDrawStored = False) then
  begin
    FExtendedDrawStored := True;
    FExtendedDraw := DefaultExtendedDraw;
    FGrid.Invalidate;
  end else if (Value = False) and (IsExtendedDrawStored = True) then
  begin
    FExtendedDrawStored := False;
    FExtendedDraw := DefaultExtendedDraw;
    FGrid.Invalidate;
  end;
end;

procedure TControlBorderEh.UpdateExtendedDraw;
begin
  if FOldExtendedDraw <> DefaultExtendedDraw then
    FGrid.RecreateWndHandle;
end;

{ TBaseColumnsEh }

function TBaseColumnsEh.GetColumn(Index: Integer): TBaseColumnEh;
begin
  Result := TBaseColumnEh(inherited Items[Index]);
end;

procedure TBaseColumnsEh.SetColumn(Index: Integer; const Value: TBaseColumnEh);
begin
  inherited Items[Index] := Value;
end;

function TCustomDBAxisGridEh.GetRestoreStateControl: TObject;
begin
  Result := nil;
end;

procedure TCustomDBAxisGridEh.SelectionActiveChanged;
begin
  Invalidate;
  FSelectionActive := IsSelectionActive;
end;

function TCustomDBAxisGridEh.DataSetActive: Boolean;
begin
  Result := (FDataLink <> nil) and FDataLink.Active and
    (FDataLink.DataSet <> nil) and FDataLink.DataSet.Active; 
end;

{ TDBAxisGridEhCenter }

var
  FDBAxisGridEhCenter: TDBAxisGridEhCenter = nil;

function SetDBAxisGridEhCenter(NewGridCenter: TDBAxisGridEhCenter): TDBAxisGridEhCenter;
begin
  Result := FDBAxisGridEhCenter;
  FDBAxisGridEhCenter := NewGridCenter;
  FDBAxisGridEhCenter.Changed;
end;

function DBAxisGridEhCenter: TDBAxisGridEhCenter;
begin
  Result := FDBAxisGridEhCenter;
end;

constructor TDBAxisGridEhCenter.Create;
begin
  inherited Create;
end;

destructor TDBAxisGridEhCenter.Destroy;
begin
  inherited Destroy;
end;

procedure TDBAxisGridEhCenter.EditButtonDefaultAction(Grid: TCustomDBAxisGridEh;
  AxisBar: TAxisBarEh; EditControl: TControl; EditButton: TEditButtonEh;
  EditButtonControl: TEditButtonControlEh; IsMouseDown: Boolean;
  var Handled: Boolean);
begin
  if (AxisBar.GetBarType = ctGraphicData) and (AxisBar.TextEditing = False) then
    EditButtonDefaultActionForImage(Grid, AxisBar, EditControl, EditButton,
      EditButtonControl, IsMouseDown, Handled)
  else if (AxisBar.GetBarType = ctCommon) and
          (AxisBar.Field <> nil) and
          (AxisBar.Field.DataType in
             [ftString, ftMemo, ftFmtMemo, ftFixedChar, ftWideString,
              ftOraClob, ftGuid
              {$IFDEF EH_LIB_10}
                ,ftFixedWideChar, ftWideMemo
              {$ENDIF}])
  then
    EditButtonDefaultActionText(Grid, AxisBar, EditControl, EditButton,
      EditButtonControl, IsMouseDown, Handled);
end;

procedure TDBAxisGridEhCenter.EditButtonDefaultActionForImage(
  Grid: TCustomDBAxisGridEh; AxisBar: TAxisBarEh; EditControl: TControl;
  EditButton: TEditButtonEh; EditButtonControl: TEditButtonControlEh;
  IsMouseDown: Boolean; var Handled: Boolean);
var
  p: TPoint;
  APopupMenu: TPopupMenu;
  APicture: TPicture;
begin
  if (EditButton.Style in [ebsDropDownEh, ebsAltDropDownEh]) and IsMouseDown then
  begin

    APopupMenu := AxisBar.GetPopupMenu;

    if Assigned(APopupMenu) then
    begin
      P := TControl(EditButtonControl).ClientToScreen(Point(0, TControl(EditButtonControl).Height));
      if APopupMenu.Alignment = paRight then
        Inc(P.X, TControl(EditButtonControl).Width);
      APopupMenu.Popup(p.X, p.y);
  //        PostMessage(Handle, CM_IGNOREEDITDOWN, Integer(Sender), 0);
      KillMouseUp(EditButtonControl);
  //        PostMessage(Handle, CM_IGNOREEDITDOWN, Integer(TEditButtonControlEh(Sender).Tag), 0);
      EditButtonControl.Perform(WM_LBUTTONUP, 0, 0);

      Handled := True;
    end;

  end else if not IsMouseDown and (EditButton.Style = ebsEllipsisEh) then
  begin
    APicture := TPicture.Create;
    AssignPictureFromImageField(AxisBar.Field, APicture);
//    APicture.Graphic := DBImageEh.Picture.Graphic;
    try
      if ShowPictureEditDialogEhProg(APicture) then
      begin
        if Grid.DataLink.Edit then
          AxisBar.Field.Assign(APicture.Graphic);
      end;
    finally
      APicture.Free;
    end;
  end;

end;

procedure TDBAxisGridEhCenter.EditButtonDefaultActionText(
  Grid: TCustomDBAxisGridEh; AxisBar: TAxisBarEh; EditControl: TControl;
  EditButton: TEditButtonEh; EditButtonControl: TEditButtonControlEh;
  IsMouseDown: Boolean; var Handled: Boolean);
var
  DBEditControl: TDBAxisGridInplaceEdit;
  ADropDownFormParams: TDropDownFormCallParamsEhCrack;

  Text: String;
  AEmptyRect: TRect;
begin
  DBEditControl := (EditControl as TDBAxisGridInplaceEdit);

  if (EditButton.Style in [ebsDropDownEh, ebsAltUpDownEh]) and IsMouseDown then
  begin
    ADropDownFormParams := TDropDownFormCallParamsEhCrack(EditButton.DropDownFormParams);

    ADropDownFormParams.FEditButton := EditButton;
    ADropDownFormParams.FEditButtonControl := EditButtonControl;
    ADropDownFormParams.FEditControl := DBEditControl;
    ADropDownFormParams.FOnOpenDropDownFormProc := DBEditControl.ShowDropDownForm;
    ADropDownFormParams.FOnCloseDropDownFormProc := DBEditControl.DropDownFormCloseProc;
    ADropDownFormParams.FDataLink := Grid.DataLink;
    ADropDownFormParams.FField := DBEditControl.AxisBar.Field;
    ADropDownFormParams.FOnSetVarValueProc := DBEditControl.SetVarValue;
    ADropDownFormParams.FOnGetVarValueProc := DBEditControl.GetVarValue;
    ADropDownFormParams.FOnGetActualDropDownFormProc := DBEditControl.GetDefaultDropDownForm;

    ADropDownFormParams.CheckShowDropDownForm(Handled);
  end else if (EditButton.Style = ebsEllipsisEh) and not IsMouseDown then
  begin
    Text := DBEditControl.Text;
    AEmptyRect := EmptyRect;
    if ShowMemoEditDialogEhProg(Text, AEmptyRect, not DBEditControl.AxisBar.CanModify(False)) then
    begin
      Grid.DataLink.Edit;
      DBEditControl.Text := Text;
      Grid.UpdateText;
      Grid.UpdateData;
      Handled := True;
    end;
  end;
end;

procedure TDBAxisGridEhCenter.FormSystemPopupMenuForColumn(
  Grid: TCustomDBAxisGridEh; AxisBar: TAxisBarEh; APopupMenu: TPopupMenu);
var
  MenuItem: TAxisBarEhMenuItem;
  CanModify: Boolean;
begin
  CanModify := (AxisBar.Field <> nil) and
               not AxisBar.ReadOnly and
               not Grid.ReadOnly and
               AxisBar.Field.CanModify;

  if CanModify then
  begin
    MenuItem := TAxisBarEhMenuItem.Create(APopupMenu);
    MenuItem.Caption := 'Cut';
    MenuItem.OnClick := MenuItemCut;
    MenuItem.AxisBar := AxisBar;
    APopupMenu.Items.Add(MenuItem);
  end;

  MenuItem := TAxisBarEhMenuItem.Create(APopupMenu);
  MenuItem.Caption := 'Copy';
  MenuItem.AxisBar := AxisBar;
  MenuItem.OnClick := MenuItemCopy;
  APopupMenu.Items.Add(MenuItem);

  if CanModify and Clipboard.HasFormat(CF_BITMAP) then
  begin
    MenuItem := TAxisBarEhMenuItem.Create(APopupMenu);
    MenuItem.Caption := 'Paste';
    MenuItem.AxisBar := AxisBar;
    MenuItem.OnClick := MenuItemPaste;
    APopupMenu.Items.Add(MenuItem);
  end;

  if CanModify then
  begin
    MenuItem := TAxisBarEhMenuItem.Create(APopupMenu);
    MenuItem.Caption := 'Delete';
    MenuItem.AxisBar := AxisBar;
    MenuItem.OnClick := MenuItemDelete;
    APopupMenu.Items.Add(MenuItem);
  end;

  MenuItem := TAxisBarEhMenuItem.Create(APopupMenu);
  MenuItem.Caption := '-';
  APopupMenu.Items.Add(MenuItem);

  if CanModify then
  begin
    MenuItem := TAxisBarEhMenuItem.Create(APopupMenu);
    MenuItem.Caption := 'Load...';
    MenuItem.AxisBar := AxisBar;
    MenuItem.OnClick := MenuItemLoad;
    APopupMenu.Items.Add(MenuItem);
  end;

  if (AxisBar.Field <> nil) and not AxisBar.Field.IsNull then
  begin
    MenuItem := TAxisBarEhMenuItem.Create(APopupMenu);
    MenuItem.Caption := 'Save...';
    MenuItem.AxisBar := AxisBar;
    MenuItem.OnClick := MenuItemSave;
    APopupMenu.Items.Add(MenuItem);
  end;

end;

procedure TDBAxisGridEhCenter.MenuItemCopy(Sender: TObject);
begin
  TAxisBarEhMenuItem(Sender).AxisBar.CopyValueToClipboard;
end;

procedure TDBAxisGridEhCenter.MenuItemCut(Sender: TObject);
begin
  TAxisBarEhMenuItem(Sender).AxisBar.CutValueToClipboard;
end;

procedure TDBAxisGridEhCenter.MenuItemPaste(Sender: TObject);
begin
  TAxisBarEhMenuItem(Sender).AxisBar.PasteValueFromClipboard;
end;

procedure TDBAxisGridEhCenter.MenuItemDelete(Sender: TObject);
begin
  TAxisBarEhMenuItem(Sender).AxisBar.ClearValue;
end;

procedure TDBAxisGridEhCenter.MenuItemLoad(Sender: TObject);
begin
  TAxisBarEhMenuItem(Sender).AxisBar.LoadFromFileDialog;
end;

procedure TDBAxisGridEhCenter.MenuItemSave(Sender: TObject);
begin
  TAxisBarEhMenuItem(Sender).AxisBar.SaveToFileDialog;
end;

procedure TDBAxisGridEhCenter.Changed;
begin

end;

initialization
  DBGridEhDebugDraw := False;
  FDBAxisGridEhCenter := TDBAxisGridEhCenter.Create;

{$IFDEF CIL}
//
{$ELSE}
  hcrDownCurEh := LoadCursor(hInstance, 'DOWNCUREH');
  if hcrDownCurEh = 0 then
    raise EOutOfResources.Create('Cannot load cursor resource');

  hcrRightCurEh := LoadCursor(hInstance, 'RIGHTCUREH');
  if hcrRightCurEh = 0 then
    raise EOutOfResources.Create('Cannot load cursor resource');

  hcrLeftCurEh := LoadCursor(hInstance, 'LEFTCUREH');
  if hcrLeftCurEh = 0 then
    raise EOutOfResources.Create('Cannot load cursor resource');
{$ENDIF}

finalization
  FreeAndNil(InplaceBitmap);
  FreeAndNil(FDBAxisGridEhCenter);
end.
