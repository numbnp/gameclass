{*******************************************************}
{                                                       }
{                       EhLib 7.0                       }
{                TCustomGridEh component                }
{                    (Build 7.0.32)                     }
{                                                       }
{     Copyright (c) 2013-2014 by Dmitry V. Bolshakov    }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit GridsEh;

interface

uses {$IFDEF LINUX} WinUtils, {$ENDIF} Windows, SysUtils, Classes,
{$IFDEF EH_LIB_6} Types, {$ENDIF}
{$IFDEF EH_LIB_7} Themes, UxTheme, {$ENDIF}
{$IFDEF EH_LIB_17} System.UITypes, {$ENDIF}
{$IFDEF CIL}
  EhLibVCLNET,
{$ELSE}
  {$IFDEF FPC}
  EhLibLCL, LMessages, LCLType, Win32Extra, Maskedit,
  {$ELSE}
  EhLibVCL, Mask, Messages,
  {$ENDIF}
{$ENDIF}
  Graphics, Menus, Controls, Forms, StdCtrls, Imglist,
  GridToolCtrlsEh, ToolCtrlsEh,
  Dialogs, ExtCtrls, Contnrs;

type
  EInvalidGridOperationEh = class(Exception);

  TPointArray = array of TPoint;
  TDWORDArray = array of DWORD;
  TCustomGridEh = class;
  TGridDrawStyleEh = class;

  TScrollBarPropEh = (sbpRangeEh, sbpPageEh, sbpPosEh);
  TScrollBarPropsEh = set of TScrollBarPropEh;

  TScrollStepTypeEh = (sstByPixelEh, sstByCellEh);

  TGridCoord = record
    X: Integer;
    Y: Integer;
  end;

  TGridRect = record
    case Integer of
      0: (Left, Top, Right, Bottom: Integer);
      1: (TopLeft, BottomRight: TGridCoord);
  end;

  { TInplaceEdit }

  { The inplace editor is not intended to be used outside the grid }

  TInplaceEdit = class(TCustomMaskEdit)
  private
    FGrid: TCustomGridEh;
    FClickTime: Longint;
    procedure InternalMove(const Loc: TRect; Redraw: Boolean);
    procedure SetGrid(Value: TCustomGridEh);
    procedure CMShowingChanged(var Message: TMessage); message CM_SHOWINGCHANGED;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMPaste(var Message: TMessage); message WM_PASTE;
    procedure WMCut(var Message: TMessage); message WM_CUT;
    procedure WMClear(var Message: TMessage); message WM_CLEAR;
  protected
    function DoMouseWheel(Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint): Boolean; override;
    function EditCanModify: Boolean; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure DblClick; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
  {$IFDEF FPC}
    procedure BoundsChanged; virtual; reintroduce;
  {$ELSE}
    procedure BoundsChanged; virtual;
  {$ENDIF}
    procedure UpdateContents; virtual;
    procedure WndProc(var Message: TMessage); override;
    {$IFDEF FPC}
    function ChildClassAllowed(ChildClass: TClass): boolean; override;
    {$ENDIF}

    procedure Change; override;
    property  Grid: TCustomGridEh read FGrid;
  public
    constructor Create(AOwner: TComponent); override;

    function PosEqual(const Rect: TRect): Boolean;
    function Visible: Boolean;

    procedure Deselect;
    procedure Hide;
    procedure Invalidate; override;
    procedure Move(const Loc: TRect);
    procedure SetFocus; reintroduce;
    procedure UpdateLoc(const Loc: TRect);

    property MaxLength;
  end;

  { TGridLineColorsEh }

  TGridLineColorsEh = class(TPersistent)
  private
    FBrightColor: TColor;
    FDarkColor: TColor;
    FDataHorzColor: TColor;
    FDataVertColor: TColor;
    FFixedHorzColor: TColor;
    FFixedVertColor: TColor;
    FGrid: TCustomGridEh;
    FHorzAreaContraBorderColor: TColor;
    FHorzAreaContraHorzColor: TColor;
    FHorzAreaContraVertColor: TColor;
    FHorzAreaFrozenBorderColor: TColor;
    FHorzAreaFrozenHorzColor: TColor;
    FHorzAreaFrozenVertColor: TColor;
    FVertAreaContraBorderColor: TColor;
    FVertAreaContraHorzColor: TColor;
    FVertAreaContraVertColor: TColor;
    FVertAreaFrozenBorderColor: TColor;
    FVertAreaFrozenHorzColor: TColor;
    FVertAreaFrozenVertColor: TColor;

    procedure SetBrightColor(const Value: TColor);
    procedure SetDarkColor(const Value: TColor);
    procedure SetDataHorzColor(const Value: TColor);
    procedure SetDataVertColor(const Value: TColor);
  protected
    property Grid: TCustomGridEh read FGrid;

    function GetCellColor(ACol, ARow: Longint): TColor; virtual;
    function GetLeftBorderCellColor(ACol, ARow: Longint): TColor; virtual;
    function GetTopBorderCellColor(ACol, ARow: Longint): TColor; virtual;
    function GetRightBorderCellColor(ACol, ARow: Longint): TColor; virtual;
    function GetDownBorderCellColor(ACol, ARow: Longint): TColor; virtual;

    function GetVertAreaFrozenVertColor: TColor; virtual;
    function GetVertAreaFrozenHorzColor: TColor; virtual;
    function GetHorzAreaFrozenVertColor: TColor; virtual;
    function GetHorzAreaFrozenHorzColor: TColor; virtual;
    function GetVertAreaFrozenBorderColor: TColor; virtual;
    function GetHorzAreaFrozenBorderColor: TColor; virtual;
    function GetDataVertColor: TColor; virtual;
    function GetDataHorzColor: TColor; virtual;

    property FixedVertColor: TColor read FFixedVertColor write FFixedVertColor default clDefault;
    property FixedHorzColor: TColor read FFixedHorzColor write FFixedHorzColor default clDefault;
    property VertAreaFrozenVertColor: TColor read FVertAreaFrozenVertColor write FVertAreaFrozenVertColor default clDefault;
    property VertAreaFrozenHorzColor: TColor read FVertAreaFrozenHorzColor write FVertAreaFrozenHorzColor default clDefault;
    property HorzAreaFrozenVertColor: TColor read FHorzAreaFrozenVertColor write FHorzAreaFrozenVertColor default clDefault;
    property HorzAreaFrozenHorzColor: TColor read FHorzAreaFrozenHorzColor write FHorzAreaFrozenHorzColor default clDefault;
    property VertAreaFrozenBorderColor: TColor read FVertAreaFrozenBorderColor write FVertAreaFrozenBorderColor default clDefault;
    property HorzAreaFrozenBorderColor: TColor read FHorzAreaFrozenBorderColor write FHorzAreaFrozenBorderColor default clDefault;
    property DataVertColor: TColor read FDataVertColor write SetDataVertColor default clDefault;
    property DataHorzColor: TColor read FDataHorzColor write SetDataHorzColor default clDefault;
    property VertAreaContraVertColor: TColor read FVertAreaContraVertColor write FVertAreaContraVertColor default clDefault;
    property VertAreaContraHorzColor: TColor read FVertAreaContraHorzColor write FVertAreaContraHorzColor default clDefault;
    property HorzAreaContraVertColor: TColor read FHorzAreaContraVertColor write FHorzAreaContraVertColor default clDefault;
    property HorzAreaContraHorzColor: TColor read FHorzAreaContraHorzColor write FHorzAreaContraHorzColor default clDefault;
    property VertAreaContraBorderColor: TColor read FVertAreaContraBorderColor write FVertAreaContraBorderColor default clDefault;
    property HorzAreaContraBorderColor: TColor read FHorzAreaContraBorderColor write FHorzAreaContraBorderColor default clDefault;
  public
    constructor Create(AGrid: TCustomGridEh);

    function GetDarkColor: TColor; virtual;
    function GetBrightColor: TColor; virtual;

    function GetFixedVertColor: TColor; virtual;
    function GetFixedHorzColor: TColor; virtual;
    function GetVertAreaContraVertColor: TColor; virtual;
    function GetVertAreaContraHorzColor: TColor; virtual;
    function GetHorzAreaContraVertColor: TColor; virtual;
    function GetHorzAreaContraHorzColor: TColor; virtual;
    function GetVertAreaContraBorderColor: TColor; virtual;
    function GetHorzAreaContraBorderColor: TColor; virtual;

    property DarkColor: TColor read FDarkColor write SetDarkColor default clDefault;
    property BrightColor: TColor read FBrightColor write SetBrightColor default clDefault;
  end;

  {TDBGridEhScrollBar}

  TScrollBarVisibleModeEh = (sbAlwaysShowEh, sbNeverShowEh, sbAutoShowEh);

  TGridScrollBarEh = class(TPersistent)
  private
    FGrid: TCustomGridEh;
    FKind: TScrollBarKind;
    FTracking: Boolean;
    FVisibleMode: TScrollBarVisibleModeEh;
    FSmoothStep: Boolean;
    FSize: Integer;
    function GetSmoothStep: Boolean;
    procedure SetSmoothStep(Value: Boolean);
    procedure SetVisibleMode(const Value: TScrollBarVisibleModeEh);
    function GetSize: Integer;
    procedure SetSize(const Value: Integer);
    function GetVisible: Boolean;
    procedure SetVisible(const Value: Boolean);
  protected
    procedure SmoothStepChanged; virtual;
    procedure ScrollBarPanelChanged; virtual;
    procedure SetParams(APosition, AMin, AMax, APageSize: Integer);
    function CheckScrollBarMustBeShown: Boolean;  virtual;
  public
    constructor Create(AGrid: TCustomGridEh; AKind: TScrollBarKind);
    destructor Destroy; override;

    function ActualScrollBarBoxSize: Integer; virtual;
    function ActualSize: Integer; virtual;
    function CheckHideScrollBar: Boolean;
    function Grid: TCustomGridEh;
    function IsKeepMaxSizeInDefault: Boolean; virtual;
    function IsScrollBarShowing: Boolean; virtual;
    function ScrollBarPanel: Boolean; virtual;

    procedure Assign(Source: TPersistent); override;
    procedure GetScrollBarParams(var APosition, AMin, AMax, APageSize: Integer);

    property Kind: TScrollBarKind read FKind;
    property Size: Integer read GetSize write SetSize default 0;
    property SmoothStep: Boolean read GetSmoothStep write SetSmoothStep default False;
    property VisibleMode: TScrollBarVisibleModeEh read FVisibleMode write SetVisibleMode default sbAutoShowEh;

  published
    property Tracking: Boolean read FTracking write FTracking default True;
    property Visible: Boolean read GetVisible write SetVisible default True;
  end;

{ TGridOutBoundaryDataEh }

  TGridCellBorderTypeEh = (cbtTopEh, cbtLeftEh, cbtBottomEh, cbtRightEh);
  TCornerDrawPriorityEh = (crpHorizontalDataPriorityEh, crpVerticalDataPriorityEh);

  TGridOutBoundaryDataEh = class(TPersistent)
  private
    FLeftIndent: Integer;
    FTopIndent: Integer;
    FRightIndent: Integer;
    FBottomIndent: Integer;
    FLeftTopDrawPriority: TCornerDrawPriorityEh;
    FRightTopDrawPriority: TCornerDrawPriorityEh;
    FLeftBottomDrawPriority: TCornerDrawPriorityEh;
    FRightBottomDrawPriority: TCornerDrawPriorityEh;
    FGrid: TCustomGridEh;

    procedure SetBottomIndent(const Value: Integer);
    procedure SetLeftBottomDrawPriority(const Value: TCornerDrawPriorityEh);
    procedure SetLeftIndent(const Value: Integer);
    procedure SetLeftTopDrawPriority(const Value: TCornerDrawPriorityEh);
    procedure SetRightBottomDrawPriority(const Value: TCornerDrawPriorityEh);
    procedure SetRightIndent(const Value: Integer);
    procedure SetRightTopDrawPriority(const Value: TCornerDrawPriorityEh);
    procedure SetTopIndent(const Value: Integer);
  protected
    property Grid: TCustomGridEh read FGrid;
  public
    constructor Create(AGrid: TCustomGridEh);

    function GetOutBoundaryRect(var ARect: TRect; OutBoundaryType: TGridCellBorderTypeEh): Boolean;
    procedure InvalidateOutBoundary(OutBoundaryType: TGridCellBorderTypeEh);

    property BottomIndent: Integer read FBottomIndent write SetBottomIndent;
    property LeftBottomDrawPriority: TCornerDrawPriorityEh read FLeftBottomDrawPriority write SetLeftBottomDrawPriority;
    property LeftIndent: Integer read FLeftIndent write SetLeftIndent;
    property LeftTopDrawPriority: TCornerDrawPriorityEh read FLeftTopDrawPriority write SetLeftTopDrawPriority;
    property RightBottomDrawPriority: TCornerDrawPriorityEh read FRightBottomDrawPriority write SetRightBottomDrawPriority;
    property RightIndent: Integer read FRightIndent write SetRightIndent;
    property RightTopDrawPriority: TCornerDrawPriorityEh read FRightTopDrawPriority write SetRightTopDrawPriority;
    property TopIndent: Integer read FTopIndent write SetTopIndent;
  end;

{ TGridHotTrackSpotEh }

  TGridHotTrackSpotEh = class(TPersistent)
  private
    FCol: Integer;
    FRow: Integer;
    FInCellX: Integer;
    FInCellY: Integer;
  public
    procedure Assign(Source: TPersistent); override;
    property Col: Integer read FCol write FCol;
    property Row: Integer read FRow write FRow;
    property InCellX: Integer read FInCellX write FInCellX;
    property InCellY: Integer read FInCellY write FInCellY;
  end;

{ TGridAxisDataEh }

  TGridAxisDataEh = class(TPersistent)
  private
    FContraCelCount: Integer;
    FContraCelLens: TIntegerDynArray;
    FContraLen: Integer;
    FContraStart: Integer;
    FDefaultCelLen: Integer;
    FFixedBoundary: Integer;
    FFixedCelCount: Integer;
    FFixedCelLens: TIntegerDynArray;
    FFrozenCelCount: Integer;
    FFrozenLen: Integer;
    FGrid: TCustomGridEh;
    FGridClientStart: Integer;
    FGridClientStop: Integer;
    FRolCelCount: Integer;
    FRolCelLens: TIntegerDynArray;
    FRolLastFullVisCel: Integer;
    FRolLastVisCel: Integer;
    FRolLocCelPosArr: TInt64DynArray;
    FRolLocCelPosArrObsolete: Boolean;
    FRolStartVisCel: Integer;
    FRolStartVisCelOfst: Integer;
    FRolStartVisPos: Int64;
    FWinClientBoundSta: Integer;
    FWinClientBoundSto: Integer;

    function GetCelCount: Integer;
    function GetCelLens(Index: Integer): Integer;
    function GetContraCelLens(Index: Integer): Integer;
    function GetFixedCelLens(Index: Integer): Integer;
    function GetFullCelCount: Integer;
    function GetGridClientLen: Integer;
    function GetGridClientStart: Integer;
    function GetGridClientStop: Integer;
    function GetRolCelLens(Index: Integer): Integer;
    function GetRolClientLen: Integer;
    function GetRolInClientBoundary: Integer;
    function GetRolLastFullVisCel: Integer;
    function GetRolLastVisCel: Integer;
    function GetRolLen: Int64;
    function GetRolLocCelPosArr(Index: Integer): Int64;
    function GetRolStopVisPos: Int64;
    function GetStartVisCel: Integer;

    procedure SetCelLens(Index: Integer; const Value: Integer);
    procedure SetContraCelCount(const Value: Integer);
    procedure SetContraCelLens(Index: Integer; const Value: Integer);
    procedure SetDefaultCelLen(const Value: Integer);
    procedure SetFixedCelLens(Index: Integer; const Value: Integer);
    procedure SetFrozenCelCount(const Value: Integer);
    procedure SetRolCelCount(const Value: Integer);
    procedure SetRolCelLens(Index: Integer; const Value: Integer);
    procedure SetRolLocCelPosArr(Index: Integer; const Value: Int64);
    procedure SetRolStartVisPos(const Value: Int64);

  protected
    procedure GetLastVisibleCell(var LastVisCell, LastFullVisCell: Integer);
    procedure UpdateRolCelPosArr;
    procedure InsertRolCels(const Pos, Count: Integer);
    procedure DeleteRolCels(const Pos, Count: Integer);

  public
    constructor Create(AGrid: TCustomGridEh);
    destructor Destroy; override;

    function CheckRolStartVisPos(const ARolStartVisPos: Int64): Int64;
    function GetScrollStep: Integer;
    function SafeSetRolStartVisCel(NewStartCell: Integer; ScrollStepType: TScrollStepTypeEh = sstByPixelEh): Integer;
    function CalcMaxStartCellFor(RolFinishCell: Integer): Integer;
    procedure RolCellAtPos(Pos: Int64; var ACel, ACelOffset: Integer);
    procedure CheckUpdateRolCelPosArr;
    procedure CheckUpdateAxises;
    procedure MoveCel(FromIndex, ToIndex: Integer);
    procedure SwapRightToLeftPoses(var Pos1, Pos2: Integer);
    function RightToLeftReflect(const APos: Integer): Integer;
    procedure UpdateVisCells;

    property Grid: TCustomGridEh read FGrid;

    property FixedCelCount: Integer read FFixedCelCount;
    property FrozenCelCount: Integer read FFrozenCelCount write SetFrozenCelCount;
    property RolCelCount: Integer read FRolCelCount write SetRolCelCount;
    property ContraCelCount: Integer read FContraCelCount write SetContraCelCount;

    property CelCount: Integer read GetCelCount;
    property FullCelCount: Integer read GetFullCelCount;

    property WinClientBoundSta: Integer read FWinClientBoundSta;
    property WinClientBoundSto: Integer read FWinClientBoundSto;
    property GridClientStart: Integer read GetGridClientStart;
    property GridClientStop: Integer read GetGridClientStop;
    property GridClientLen: Integer read GetGridClientLen;

    property FixedBoundary: Integer read FFixedBoundary;
    property RolClientLen: Integer read GetRolClientLen;

    property ContraStart: Integer read FContraStart;
    property ContraLen: Integer read FContraLen;

    property FrozenLen: Integer read FFrozenLen;

    property RolStartVisPos: Int64 read FRolStartVisPos write SetRolStartVisPos;
    property RolStopVisPos: Int64 read GetRolStopVisPos;

    property RolLen: Int64 read GetRolLen;
    property RolInClientBoundary: Integer read GetRolInClientBoundary;

    property RolStartVisCel: Integer read FRolStartVisCel;
    property RolStartVisCelOfst: Integer read  FRolStartVisCelOfst;
    property RolLastVisCel: Integer read GetRolLastVisCel;
    property RolLastFullVisCel: Integer read GetRolLastFullVisCel;

    property StartVisCel: Integer read GetStartVisCel;

    property FixedCelLens[Index: Longint]: Integer read GetFixedCelLens write SetFixedCelLens;
    property RolCelLens[Index: Longint]: Integer read GetRolCelLens write SetRolCelLens;
    property ContraCelLens[Index: Longint]: Integer read GetContraCelLens write SetContraCelLens;

    property CelLens[Index: Longint]: Integer read GetCelLens write SetCelLens;
    property DefaultCelLen: Integer read FDefaultCelLen write SetDefaultCelLen;
    property RolLocCelPosArr[Index: Longint]: Int64 read GetRolLocCelPosArr write SetRolLocCelPosArr;

  end;

{ TGridBackgroundDataEh }

  TGridBackgroundDataEh = class(TPersistent)
  private
    FGrid: TCustomGridEh;
    FImageHorzMargin: Integer;
    FImagePlacement: TImagePlacementEh;
    FImageVertMargin: Integer;
    FPicture: TPicture;
    FVisible: Boolean;

    procedure SetPicture(Value: TPicture);
    procedure SetImagePlacement(Value: TImagePlacementEh);
    procedure SetImageHorzMargin(const Value: Integer);
    procedure SetImageVertMargin(const Value: Integer);
    procedure SetVisible(const Value: Boolean);

  protected
    function DestRect: TRect;
    procedure PictureChanged(Sender: TObject);
  public
    constructor Create(AGrid: TCustomGridEh);
    destructor Destroy; override;
    function Showing: Boolean; virtual;
    function BoundRect: TRect; virtual;
    procedure PaintBackgroundData; virtual;
    property Grid: TCustomGridEh read FGrid;
  published
    property HorzMargin: Integer read FImageHorzMargin write SetImageHorzMargin default 0;
    property Picture: TPicture read FPicture write SetPicture;
    property Placement: TImagePlacementEh read FImagePlacement write SetImagePlacement default ipCenterCenterEh;
    property VertMargin: Integer read FImageVertMargin write SetImageVertMargin default 0;
    property Visible: Boolean read FVisible write SetVisible default False;
  end;

{ TGridSelectionParamsEh }

  TGridSelectionDrawStyleEh = (gsdsDefaultEh, gsdsClassicEh, gsdsGridThemedEh,
    gsdsListViewThemedEh);

  TGridSelectionDrawParamsEh = class(TPersistent)
  private
    FGrid: TCustomGridEh;
    FSelectionStyle: TGridSelectionDrawStyleEh;
    FDrawFocusFrame: Boolean;
    FDrawFocusFrameStored: Boolean;
    function GetDrawFocusFrame: Boolean;
    procedure SetDrawFocusFrame(const Value: Boolean);
    procedure SetSelectionStyle(const Value: TGridSelectionDrawStyleEh);
    function IsDrawFocusFrameStored: Boolean;
    procedure SetDrawFocusFrameStored(const Value: Boolean);
  public
    constructor Create(AGrid: TCustomGridEh);
    destructor Destroy; override;
    function GetActualSelectionStyle: TGridSelectionDrawStyleEh;
    function DefaultDrawFocusFrame: Boolean; virtual;
    property Grid: TCustomGridEh read FGrid;
  published
    property SelectionStyle: TGridSelectionDrawStyleEh read FSelectionStyle write SetSelectionStyle default gsdsDefaultEh;
    property DrawFocusFrame: Boolean read GetDrawFocusFrame write SetDrawFocusFrame stored IsDrawFocusFrameStored;
    property DrawFocusFrameStored: Boolean read IsDrawFocusFrameStored write SetDrawFocusFrameStored default False;
  end;

{ TCustomGridEh }

  TGridDrawState = set of (gdSelected, gdFocused, gdCurrent, gdFixed, gdRowSelected, gdHotTrack, gdPressed);

  TGridStateEh = (gsNormalEh, gsSelectingEh, gsRowSizingEh, gsColSizingEh,
    gsRowMovingEh, gsColMovingEh);

  TGridOptionEh = (
    goFixedVertLineEh, goFixedHorzLineEh, goVertLineEh, goHorzLineEh,
    goDrawFocusSelectedEh, goRowSizingEh, goColSizingEh, goRowMovingEh,
    goColMovingEh, goEditingEh, goTabsEh, goRowSelectEh,
    goAlwaysShowEditorEh, goThumbTrackingEh, goExtendVertLinesEh,
    goContraVertBoundaryLineEh, goContraHorzBoundaryLineEh, goRangeSelectEh);
  TGridOptionsEh = set of TGridOptionEh;
  TGridScrollDirection = set of (sdLeft, sdRight, sdUp, sdDown);

  TEditStyle =  (esSimple, esEllipsis, esPickList);

  TSelectCellEvent = procedure (Sender: TObject; ACol, ARow: Longint;
    var CanSelect: Boolean) of object;
  TDrawCellEvent = procedure (Sender: TObject; ACol, ARow: Longint;
    Rect: TRect; State: TGridDrawState) of object;
  TGridEhCellMouseEvent = procedure (Grid: TCustomGridEh; Cell: TGridCoord;
    Button: TMouseButton; Shift: TShiftState; X, Y: Integer; var Processed: Boolean) of object;

  TCustomGridEh = class(TCustomControlEh)
  private
    FAnchorCell: TGridCoord;
    FBackgroundData: TGridBackgroundDataEh;
    FBorderStyle: TBorderStyle;
    FBufferedPaint: Boolean;
    FCanEditModify: Boolean;
    FCanvasRightToLeftReflected: Boolean;
    FCornerScrollBarPanelControl: TSizeGripPanelEh;
    FCurCell: TGridCoord;
    FDrawStyle: TGridDrawStyleEh;
    FEditorMode: Boolean;
    FExtraSizeGripControl: TSizeGripPanelEh;
    FFixedColor: TColor;
    FFlat: Boolean;
    FGridLineColors: TGridLineColorsEh;
    FGridLineWidth: Integer;
    FHitTest: TPoint;
    FHorzAxis: TGridAxisDataEh;
    FHorzScotllingLockCount: Integer;
    FHorzScrollBar: TGridScrollBarEh;
    FHorzScrollBarIsShowing: Boolean;
    FHorzScrollBarPanelControl: TGridScrollBarPanelControlEh;
    FInplaceCol, FInplaceRow: Longint;
    FInplaceEdit: TInplaceEdit;
    FOptions: TGridOptionsEh;
{$IFDEF EH_LIB_13}
    FPanPoint: TPoint;
{$ENDIF}
    FScrollBarSize: Integer;
    FSelectionDrawParams: TGridSelectionDrawParamsEh;
    FSizeGripAlwaysShow: Boolean;
    FSizeGripPostion: TSizeGripPosition;
    FVertAxis: TGridAxisDataEh;
    FVertScrollBar: TGridScrollBarEh;
    FVertScrollBarIsShowing: Boolean;
    FVertScrollBarPanelControl: TGridScrollBarPanelControlEh;
    FWinClientBoundary: TRect;

    FOnCellMouseClick: TGridEhCellMouseEvent;
    FOnCellMouseDown: TGridEhCellMouseEvent;
    FOutBoundaryData: TGridOutBoundaryDataEh;

    function GetColCount: Integer;
    function GetColWidths(Index: Integer): Integer;
    function GetContraColCount: Integer;
    function GetContraRowCount: Integer;
    function GetDefaultColWidth: Integer;
    function GetDefaultRowHeight: Integer;
    function GetFixedColCount: Integer;
    function GetFixedRowCount: Integer;
    function GetFrozenColCount: Longint;
    function GetFrozenRowCount: Longint;
    function GetFullColCount: Integer;
    function GetFullRowCount: Integer;
    function GetGridClientHeight: Integer;
    function GetGridClientWidth: Integer;
    function GetLastFullVisibleCol: Integer;
    function GetLastFullVisibleRow: Integer;
    function GetLeftCol: Longint;
    function GetLeftColOffset: Longint;
    function GetRolColCount: Integer;
    function GetRolRowCount: Integer;
    function GetRolStartVisPosX: Int64;
    function GetRolStartVisPosY: Int64;
    function GetRowCount: Integer;
    function GetRowHeights(Index: Integer): Integer;
    function GetSelection: TGridRect;
    function GetTopRow: Longint;
    function GetTopRowOffset: Longint;
    function GetVisibleColCount: Integer;
    function GetVisibleRowCount: Integer;
    function GetWinClientBoundary: TRect;

    procedure DrawMove; virtual;
    procedure HideMove; virtual;
    procedure GridRectToScreenRect(GridRect: TGridRect; var ScreenRect: TRect; CutOutbounds: Boolean = True);
    procedure GridRectToScreenRectAbs(GridRect: TGridRect; var ScreenRect: TRect; IncludeLine: Boolean);
    procedure Initialize;
    procedure InvalidateRect(ARect: TGridRect);
    procedure MoveCurrent(ACol, ARow: Longint; ShowX, ShowY: Boolean);
    procedure MoveAndScroll(Mouse, CellHit: Integer; Axis: TGridAxisDataEh; Scrollbar: Integer; const MousePt: TPoint);
    procedure ReadColWidths(Reader: TReader);
    procedure ReadRowHeights(Reader: TReader);
  {$IFDEF FPC}
    procedure SetBorderStyle(const Value: TBorderStyle); reintroduce;
  {$ELSE}
    procedure SetBorderStyle(const Value: TBorderStyle);
  {$ENDIF}
    procedure SetCol(const Value: Longint);
    procedure SetColCount(const Value: Integer);
    procedure SetColWidths(Index: Integer; const Value: Integer);
    procedure SetContraColCount(const Value: Integer);
    procedure SetContraRowCount(const Value: Integer);
    procedure SetDefaultColWidth(const Value: Integer);
    procedure SetDefaultRowHeight(const Value: Integer);
    procedure SetDrawStyle(const Value: TGridDrawStyleEh);
    procedure SetEditorMode(Value: Boolean);
    procedure SetFixedColCount(const Value: Integer);
    procedure SetFixedColor(Value: TColor);
    procedure SetFixedRowCount(const Value: Integer);
    procedure SetFlat(const Value: Boolean);
    procedure SetFrozenColCount(const Value: Longint);
    procedure SetFrozenRowCount(const Value: Longint);
    procedure SetGridLineColors(const Value: TGridLineColorsEh);
    procedure SetGridLineWidth(Value: Integer);
    procedure SetHorzScrollBar(const Value: TGridScrollBarEh);
    procedure SetLeftCol(Value: Longint);
    procedure SetOptions(Value: TGridOptionsEh);
    procedure SetRolColCount(const Value: Integer);
    procedure SetRolRowCount(const Value: Integer);
    procedure SetRolStartVisPosX(const Value: Int64);
    procedure SetRolStartVisPosY(const Value: Int64);
    procedure SetRow(const Value: Longint);
    procedure SetRowCount(const Value: Integer);
    procedure SetRowHeights(Index: Integer; const Value: Integer);
    procedure SetScrollBarSize(const Value: Integer);
    procedure SetSelection(const Value: TGridRect);
    procedure SetSelectionDrawParams(const Value: TGridSelectionDrawParamsEh);
    procedure SetSizeGripAlwaysShow(const Value: Boolean);
    procedure SetSizeGripPostion(const Value: TSizeGripPosition);
    procedure SetTopRow(Value: Longint);
    procedure SetVertScrollBar(const Value: TGridScrollBarEh);
    procedure WriteColWidths(Writer: TWriter);
    procedure WriteRowHeights(Writer: TWriter);

{$IFNDEF FPC}
    procedure CMCancelMode(var Msg: TCMCancelMode); message CM_CANCELMODE;
    procedure CMCtl3DChanged(var Message: TMessage); message CM_CTL3DCHANGED;
{$ENDIF}
    procedure CMDesignHitTest(var Msg: TCMDesignHitTest); message CM_DESIGNHITTEST;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMShowingChanged(var Message: TMessage); message CM_SHOWINGCHANGED;
    procedure CMWantSpecialKey(var Msg: TCMWantSpecialKey); message CM_WANTSPECIALKEY;
{$IFDEF EH_LIB_16}
    procedure CMStyleChanged(var Message: TMessage); message CM_STYLECHANGED;
{$ENDIF}

    procedure WMCancelMode(var Msg: TWMCancelMode); message WM_CANCELMODE;
    procedure WMChar(var Msg: TWMChar); message WM_CHAR;
    procedure WMCommand(var Message: TWMCommand); message WM_COMMAND;
    procedure WMGetDlgCode(var Msg: TWMGetDlgCode); message WM_GETDLGCODE;
//    procedure WMHScroll(var Msg: TWMHScroll); message WM_HSCROLL;
    procedure WMKillFocus(var Msg: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure WMRButtonDblClk(var Message: TWMRButtonDblClk); message WM_RBUTTONDBLCLK;
    procedure WMMButtonDblClk(var Message: TWMMButtonDblClk); message WM_MBUTTONDBLCLK;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMRButtonDown(var Message: TWMRButtonDown); message WM_RBUTTONDOWN;
    procedure WMMButtonDown(var Message: TWMMButtonDown); message WM_MBUTTONDOWN;
    procedure WMLButtonUp(var Message: TWMLButtonUp); message WM_LBUTTONUP;
    procedure WMRButtonUp(var Message: TWMRButtonUp); message WM_RBUTTONUP;
    procedure WMMButtonUp(var Message: TWMMButtonUp); message WM_MBUTTONUP;
    procedure WMNCHitTest(var Msg: TWMNCHitTest); message WM_NCHITTEST;
    procedure WMNCMouseMove(var Message: TWMMouseMove); message WM_NCMOUSEMOVE;
    procedure WMSetCursor(var Msg: TWMSetCursor); message WM_SETCURSOR;
{$IFNDEF FPC}
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
{$ENDIF}
    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBKGND;
    procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
    procedure WMSize(var Msg: TWMSize); message WM_SIZE;
    procedure WMTimer(var Msg: TWMTimer); message WM_TIMER;
//    procedure WMVScroll(var Msg: TWMVScroll); message WM_VSCROLL;

//{$IFDEF EH_LIB_16}
//    class constructor Create;
//{$ENDIF}
  protected
    FBoundariesUpdateCount: Integer;
    FDesignOptionsBoost: TGridOptionsEh;
    FFixedLineColor: TColor;
    FGridState: TGridStateEh;
    FHotTrackCell: TGridCoord;
    FHotTrackInCellPos: TPoint;
    FInternalColor: TColor;
    FInternalFixedColor: TColor;
    FInternalFixedFontColor: TColor;
    FInternalFontColor: TColor;
    FLockPaint: Integer;
    FMouseDownCell: TGridCoord;
    FMoveIndex, FMovePos: Longint;
    FMovePosRightSite: Boolean;
    FNewHotTrackSpot: TGridHotTrackSpotEh;
    FOldHotTrackSpot: TGridHotTrackSpotEh;
    FSaveCellExtents: Boolean;
    FSizingIndex: Integer;
    FSizingPos, FSizingOfs: Integer;

{$IFDEF EH_LIB_13}
    function IsTouchPropertyStored(AProperty: TTouchProperty): Boolean; override;
{$ENDIF}
    function BoundariesUpdating: Boolean;
    function BoxRect(ALeft, ATop, ARight, ABottom: Longint; IncludeLine: Boolean = False): TRect;
    function BoxRectAbs(ALeft, ATop, ARight, ABottom: Longint; IncludeLine: Boolean = False): TRect;
    function CalcColRangeWidth(FromCol, RangeColCount: Integer): Int64;
    function CalcCoordFromPoint(X, Y: Integer): TGridCoord;
    function CalcRowRangeHeight(FromRow, RangeRowCount: Integer): Int64;
    function CanEditAcceptKey(Key: Char): Boolean; virtual;
    function CanEditModify: Boolean; virtual;
    function CanEditShow: Boolean; virtual;
    function CanFillSelectionByTheme: Boolean;
    function CanGridAcceptKey(Key: Word; Shift: TShiftState): Boolean; virtual;
    function CanHotTackCell(X, Y: Integer): Boolean; virtual;
    function CellEditRect(ACol, ARow: Longint): TRect; virtual;
    function CellRect(ACol, ARow: Longint; IncludeLine: Boolean = False): TRect;
    function CellRectAbs(ACol, ARow: Longint; IncludeLine: Boolean = False): TRect;
    function CheckBeginColumnDrag(var Origin, Destination: Integer; const MousePt: TPoint): Boolean; virtual;
    function CheckBeginRowDrag(var Origin, Destination: Integer; const MousePt: TPoint): Boolean; virtual;
    function CheckCellCanSendDoubleClicks(CellHit: TGridCoord; Button: TMouseButton; ShiftState: TShiftState; MousePos, InCellMousePos: TPoint): Boolean; virtual;
    function CheckCellLine(ACol, ARow: Integer; BorderType: TGridCellBorderTypeEh): Boolean;
    function CheckCellMouseClick(var Message: TWMLButtonUp): Boolean; virtual;
    function CheckColumnDrag(var Origin, Destination: Integer; const MousePt: TPoint): Boolean; virtual;
    function CheckPersistentContraLine(LineType: TGridCellBorderTypeEh): Boolean; virtual;
    function CheckRowDrag(var Origin, Destination: Integer; const MousePt: TPoint): Boolean; virtual;
    function CheckSizingState(X, Y: Integer): TGridStateEh; virtual;
    function CheckStartTmpCancelCanvasRTLReflecting(var ADrawRect: TRect): Boolean;
    function ChildControlCanMouseDown(AControl: TControl): Boolean; virtual;
    function CreateBackgroundData: TGridBackgroundDataEh; virtual;
    function CreateEditor: TInplaceEdit; virtual;
    function CreateGridLineColors: TGridLineColorsEh; virtual;
    function CreateHorzScrollBarPanelControl: TGridScrollBarPanelControlEh; virtual;
    function CreateHotTrackSpot: TGridHotTrackSpotEh; virtual;
    function CreateScrollBar(AKind: TScrollBarKind): TGridScrollBarEh; virtual;
    function CreateSizeGripPanel: TSizeGripPanelEh; virtual;
    function CreateVertScrollBarPanelControl: TGridScrollBarPanelControlEh; virtual;
    function DefaultDrawFocusFrame: Boolean; virtual;
    function DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function DoMouseWheelDownEvent(Shift: TShiftState; MousePos: TPoint): Boolean;
    function DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function DoMouseWheelUpEvent(Shift: TShiftState; MousePos: TPoint): Boolean;
    function EmptyColWidth: Integer;
    function EmptyRowHeight: Integer;
    function EndColumnDrag(var Origin, Destination: Integer; const MousePt: TPoint): Boolean; virtual;
    function EndRowDrag(var Origin, Destination: Integer; const MousePt: TPoint): Boolean; virtual;
    function EnsureInplaceEditCreated: Boolean;
    function FixedColsSizingAllowed: Boolean; virtual;
    function FixedRowsSizingAllowed: Boolean; virtual;
    function FullRedrawOnSroll: Boolean; virtual;
    function GetDefaultSelectionStyle: TGridSelectionDrawStyleEh; virtual;
    function GetEditLimit: Integer; virtual;
    function GetEditMask(ACol, ARow: Longint): string; virtual;
    function GetEditStyle(ACol, ARow: Longint): TEditStyle; virtual;
    function GetEditText(ACol, ARow: Longint): string; virtual;
    function GetHorzScrollStep: Integer; virtual;
    function GetTabStops(Index: Longint): Boolean; virtual;
    function GetVertScrollStep: Integer; virtual;
    function GridBackgroundFilled: Boolean; virtual;
    function HorzLineWidth: Integer;
    function HorzScotllingLockCount: Integer;
    function HotTrackSpotsEqual(OldHTSpot, NewHTSpot: TGridHotTrackSpotEh): Boolean; virtual;
    function IsActiveControl: Boolean;
    function IsDrawCellSelectionThemed(ACol, ARow: Integer; State: TGridDrawState): Boolean; virtual;
    function IsMultiSelected: Boolean; virtual;
    function IsSmoothHorzScroll: Boolean; virtual;
    function IsSmoothVertScroll: Boolean; virtual;
    function NeedBufferedPaint: Boolean; virtual;
    function PaintLocked: Boolean;
    function ResizeLine(Axis: TGridAxisDataEh): Integer;
    function RolSizeValid: Boolean;
    function SelectCell(ACol, ARow: Longint): Boolean; virtual;
    function Sizing(X, Y: Integer): Boolean; virtual;
    function VertLineWidth: Integer;
    function WantInplaceEditorKey(Key: Word; Shift: TShiftState): Boolean; virtual;
    function WMCheckCanSendDoubleClicks(var MouseEvent: TWMMouse): Boolean; virtual;

    {$IFDEF FPC}
    procedure BoundsChanged; override;
    {$ELSE}
    {$ENDIF}

    {$IFDEF EH_LIB_13}
    procedure DoGesture(const EventInfo: TGestureEventInfo; var Handled: Boolean); override;
    {$ENDIF}

    procedure AdjustMaxTopLeft(AdjustLeft, AdjustTop, LeftBindToCell, TopBindToCell: Boolean); virtual;
    procedure AxisMoved(Axis: TGridAxisDataEh; FromIndex, ToIndex: Integer); virtual;
    procedure BeginUpdateBoundaries;
    procedure CalcMaxRolTopLeft(var AMaxLeftPos, AMaxTopPos: Integer; LeftBindToCell, TopBindToCell: Boolean); virtual;
    procedure CalcSizingState(X, Y: Integer; var State: TGridStateEh; var Index: Longint; var SizingPos, SizingOfs: Integer); virtual;
    procedure CancelMode; virtual;
    procedure CellCountChanged; virtual;
    procedure CelLenChanged(Axis: TGridAxisDataEh; Index, OldLen: Integer); virtual;
    procedure CellMouseClick(const Cell: TGridCoord; Button: TMouseButton; Shift: TShiftState; const ACellRect: TRect; const GridMousePos, CellMousePos: TPoint); virtual;
    procedure CellMouseDown(const Cell: TGridCoord; Button: TMouseButton; Shift: TShiftState; const ACellRect: TRect; const GridMousePos, CellMousePos: TPoint); virtual;
    procedure ChangeGridOrientation(RightToLeftOrientation: Boolean);
    procedure CheckDrawCellBorder(ACol, ARow: Integer; BorderType: TGridCellBorderTypeEh; var IsDraw: Boolean; var BorderColor: TColor; var IsExtent: Boolean); virtual;
    procedure CheckUpdateAxises; virtual;
    procedure ClampInView(const Coord: TGridCoord; CheckX, CheckY: Boolean);
    procedure ColumnMoved(FromIndex, ToIndex: Longint); virtual;
    procedure ColWidthsChanged; virtual;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CurrentCellMoved(OldCurrent: TGridCoord); virtual;
    procedure DefineProperties(Filer: TFiler); override;
    procedure DeleteColumn(ACol: Longint); virtual;
    procedure DeleteRow(ARow: Longint); virtual;
    procedure DoExit; override;
    procedure DrawBordersForCellArea(ACol, ARow: Integer; var ARect: TRect; State: TGridDrawState); virtual;
    procedure DrawBottomOutBoundaryData(ARect: TRect); virtual;
    procedure DrawCell(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState); virtual;
    procedure DrawCellArea(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState); virtual;
    procedure DrawCellDataBackground(ACol, ARow: Integer; AreaRect: TRect; State: TGridDrawState); virtual;
    procedure DrawEdgeEh(ACanvas: TCanvas; qrc: TRect; IsDown, IsSelected, NeedLeft, NeedRight: Boolean);
    procedure DrawEmptyAreaCell(ACol, ARow: Integer; ARect: TRect); virtual;
    procedure DrawLeftOutBoundaryData(ARect: TRect); virtual;
    procedure DrawOutBoundaryData; virtual;
    procedure DrawPolyline(Points: array of TPoint);
    procedure DrawPolyPolyline(PointsList: TPointArray; StrokeList: TDWORDArray; VCount: Integer);
    procedure DrawRightOutBoundaryData(ARect: TRect); virtual;
    procedure DrawSizingLine; virtual;
    procedure DrawText(ACanvas: TCanvas; ARect: TRect; FillRect: Boolean; DX, DY: Integer; const Text: string; Alignment: TAlignment; Layout: TTextLayout; MultyL: Boolean; EndEllipsis: Boolean; LeftMarg, RightMarg: Integer; ForceSingleLine: Boolean; UseRightToLeftAlignment: Boolean);
    procedure DrawTopOutBoundaryData(ARect: TRect); virtual;
    procedure DrawWideLine(X1, Y1, X2, Y2, Width: Integer);
    procedure EndUpdateBoundaries;
    procedure FastInvalidate;
    procedure FillGradient(Canvas: TCanvas; ARect: TRect; FromColor, ToColor: TColor);
    procedure FlatChanged; virtual;
    procedure FocusCell(ACol, ARow: Longint; MoveAnchor: Boolean); virtual;
    procedure GetDataForHorzScrollBar(var APosition, AMin, AMax, APageSize: Integer); virtual;
    procedure GetDataForVertScrollBar(var APosition, AMin, AMax, APageSize: Integer); virtual;
    procedure GetDrawSizingLineBound(var StartPos, FinishPos: Integer); virtual;
    procedure HideEdit;
    procedure HideEditor; virtual;
    procedure HorzScrollBarMessage(ScrollCode, Pos: Integer); virtual;
    procedure InvalidateCell(ACol, ARow: Longint);
    procedure InvalidateCol(ACol: Longint);
    procedure InvalidateEditor; virtual;
    procedure InvalidateGrid;
    procedure InvalidateRow(ARow: Longint);
    procedure InvalidateSpot(HTSpot: TGridHotTrackSpotEh); virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Loaded; override;
    procedure LockGridHorzScotlling;
    procedure LockPaint;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MoveAnchorCell(ACol, ARow: Integer; Show: Boolean); virtual;
    procedure MoveColRow(ACol, ARow: Longint; ShowX, ShowY: Boolean);
    procedure MoveColumn(FromIndex, ToIndex: Longint);
    procedure MoveRow(FromIndex, ToIndex: Longint);
    procedure OutBoundaryDataChanged; virtual;
    procedure Paint; override;
    procedure RegetDefaultStyle;
    procedure Resize; override;
    procedure RolPosAxisChanged(Axis: TGridAxisDataEh; OldRowPos: Integer);
    procedure RolPosChanged(OldRowPosX, OldRowPosY: Integer); virtual;
    procedure RolSizeUpdated; virtual;
    procedure RowHeightsChanged; virtual;
    procedure RowMoved(FromIndex, ToIndex: Longint); virtual;
    procedure SafeScrollData(DX, DY: Integer);
    procedure SafeSetTopRow(ANewTopRow: Integer);
    procedure ScrollBarMessage(ScrollBar, ScrollCode, Pos: Integer; UseRightToLeft: Boolean); virtual;
    procedure ScrollBarShowingChanged; virtual;
    procedure ScrollBarSizeChanged(ScrollBar: TGridScrollBarEh); virtual;
    procedure SelectionChanged(const OldSel: TGridRect); virtual;
    procedure SetEditText(ACol, ARow: Longint; const Value: string); virtual;
    procedure SetHotTrackSpotInfo(HTSpot: TGridHotTrackSpotEh; X, Y: Integer); virtual;
    procedure SetInternalColors;
    procedure ShowEditor; virtual;
    procedure ShowEditorChar(Ch: Char);
    procedure StartColMoving(ColIndex: Integer; X, Y: Integer); virtual;
    procedure StartRowDrag(StartRow: Integer; const MousePt: TPoint); virtual;
    procedure StopTmpCancelCanvasRTLReflecting;
    procedure StyleEhChanged; virtual;
    procedure TimedScroll(Direction: TGridScrollDirection); virtual;
    procedure TopLeftChanged; virtual;
    procedure UnlockGridHorzScotlling;
    procedure UnlockPaint;
    procedure UpdateBoundaries; virtual;
    procedure UpdateDesigner;
    procedure UpdateEdit; virtual;
    procedure UpdateFixedLineColor; virtual;
    procedure UpdateHotTackInfo(X, Y: Integer); virtual;
    procedure UpdateScrollBarPanels; virtual;
    procedure UpdateScrollBars; virtual;
    procedure UpdateText; virtual;
    procedure ValidateRolSize;
    procedure VertScrollBarMessage(ScrollCode, Pos: Integer); virtual;
    procedure WndProc(var Message: TMessage); override;

    property BackgroundData: TGridBackgroundDataEh read FBackgroundData write FBackgroundData;
    property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle default bsSingle;
    property Col: Longint read FCurCell.X write SetCol;
    property ColCount: Integer read GetColCount write SetColCount;
    property Color default clWindow;
    property ColWidths[Index: Longint]: Integer read GetColWidths write SetColWidths;
    property ContraColCount: Integer read GetContraColCount write SetContraColCount;
    property ContraRowCount: Integer read GetContraRowCount write SetContraRowCount;
    property CornerScrollBarPanelControl: TSizeGripPanelEh read FCornerScrollBarPanelControl;
    property DefaultColWidth: Integer read GetDefaultColWidth write SetDefaultColWidth;
    property DefaultRowHeight: Integer read GetDefaultRowHeight write SetDefaultRowHeight;
    property DrawStyle: TGridDrawStyleEh read FDrawStyle write SetDrawStyle;
    property EditorMode: Boolean read FEditorMode write SetEditorMode;
    property FixedColCount: Integer read GetFixedColCount write SetFixedColCount;
    property FixedColor: TColor read FFixedColor write SetFixedColor default clBtnFace;
    property FixedRowCount: Integer read GetFixedRowCount write SetFixedRowCount;
    property FrozenColCount: Longint read GetFrozenColCount write SetFrozenColCount;
    property FrozenRowCount: Longint read GetFrozenRowCount write SetFrozenRowCount;
    property FullColCount: Integer read GetFullColCount;
    property FullRowCount: Integer read GetFullRowCount;
    property GridLineColors: TGridLineColorsEh read FGridLineColors write SetGridLineColors;
    property GridLineWidth: Integer read FGridLineWidth write SetGridLineWidth default 1;
    property HitTest: TPoint read FHitTest;
    property HorzAxis: TGridAxisDataEh read FHorzAxis;
    property HorzScrollBar: TGridScrollBarEh read FHorzScrollBar write SetHorzScrollBar;
    property HorzScrollBarPanelControl: TGridScrollBarPanelControlEh read FHorzScrollBarPanelControl;
    property InplaceEditor: TInplaceEdit read FInplaceEdit;
    property LastFullVisibleCol: Integer read GetLastFullVisibleCol;
    property LastFullVisibleRow: Integer read GetLastFullVisibleRow;
    property LeftCol: Longint read GetLeftCol write SetLeftCol;
    property LeftColOffset: Longint read GetLeftColOffset;
    property Options: TGridOptionsEh read FOptions write SetOptions default [];
    property OutBoundaryData: TGridOutBoundaryDataEh read FOutBoundaryData;
    property RolColCount: Integer read GetRolColCount write SetRolColCount;
    property RolRowCount: Integer read GetRolRowCount write SetRolRowCount;
    property RolStartVisPosX: Int64 read GetRolStartVisPosX write SetRolStartVisPosX;
    property RolStartVisPosY: Int64 read GetRolStartVisPosY write SetRolStartVisPosY;
    property Row: Longint read FCurCell.Y write SetRow;
    property RowCount: Integer read GetRowCount write SetRowCount;
    property RowHeights[Index: Longint]: Integer read GetRowHeights write SetRowHeights;
    property ScrollBarSize: Integer read FScrollBarSize write SetScrollBarSize;
    property Selection: TGridRect read GetSelection write SetSelection;
    property SelectionDrawParams: TGridSelectionDrawParamsEh read FSelectionDrawParams write SetSelectionDrawParams;
    property SizeGripAlwaysShow: Boolean read FSizeGripAlwaysShow write SetSizeGripAlwaysShow;
    property SizeGripPostion: TSizeGripPosition read FSizeGripPostion write SetSizeGripPostion default sgpBottomRight;
    property TabStops[Index: Longint]: Boolean read GetTabStops;
    property TopRow: Longint read GetTopRow write SetTopRow;
    property TopRowOffset: Longint read GetTopRowOffset;
    property VertAxis: TGridAxisDataEh read FVertAxis;
    property VertScrollBar: TGridScrollBarEh read FVertScrollBar write SetVertScrollBar;
    property VertScrollBarPanelControl: TGridScrollBarPanelControlEh read FVertScrollBarPanelControl;
    property VisibleColCount: Integer read GetVisibleColCount;
    property VisibleRowCount: Integer read GetVisibleRowCount;
    property WinClientBoundary: TRect read GetWinClientBoundary;

    property OnCellMouseClick: TGridEhCellMouseEvent read FOnCellMouseClick write FOnCellMouseClick;
    property OnCellMouseDown: TGridEhCellMouseEvent read FOnCellMouseDown write FOnCellMouseDown;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function MouseCoord(X, Y: Integer): TGridCoord;
    {$IFDEF FPC}
    function Ctl3D: Boolean;
    {$ENDIF}

    procedure DefaultCellMouseClick(const Cell: TGridCoord; Button: TMouseButton; Shift: TShiftState; const ACellRect: TRect; const GridMousePos, CellMousePos: TPoint); virtual;
    procedure DefaultCellMouseDown(const Cell: TGridCoord; Button: TMouseButton; Shift: TShiftState; const ACellRect: TRect; const GridMousePos, CellMousePos: TPoint); virtual;
    procedure SetLeftPos(ALeftPos: Integer);
    procedure SetTopPos(ATopPos: Integer);

    property BufferedPaint: Boolean read FBufferedPaint write FBufferedPaint;
    property CanvasRightToLeftReflected: Boolean read FCanvasRightToLeftReflected;
    property Flat: Boolean read FFlat write SetFlat default False;
    property GridClientHeight: Integer read GetGridClientHeight; 
    property GridClientWidth: Integer read GetGridClientWidth; 

  published
    property TabStop default True;
  end;

{ TDrawGridScrollBar }

  TDrawGridScrollBarEh = class(TGridScrollBarEh)
  published
    property SmoothStep;
    property Visible stored False;
    property VisibleMode;
  end;

{ TDrawGridScrollBar }

  TDrawGridHorzScrollBarEh = class(TGridScrollBarEh)
  public
    constructor Create(AGrid: TCustomGridEh; AKind: TScrollBarKind);
  published
    property SmoothStep default True;
    property Visible stored False;
    property VisibleMode;
  end;

  { TCustomDrawGridEh }

  TGetEditEvent = procedure (Sender: TObject; ACol, ARow: Longint; var Value: string) of object;
  TSetEditEvent = procedure (Sender: TObject; ACol, ARow: Longint; const Value: string) of object;
  TMovedEvent = procedure (Sender: TObject; FromIndex, ToIndex: Longint) of object;

  TCustomDrawGridEh = class(TCustomGridEh)
  private
    FOnColumnMoved: TMovedEvent;
    FOnDrawCell: TDrawCellEvent;
    FOnGetEditMask: TGetEditEvent;
    FOnGetEditText: TGetEditEvent;
    FOnRowMoved: TMovedEvent;
    FOnSelectCell: TSelectCellEvent;
    FOnSetEditText: TSetEditEvent;
    FOnTopLeftChanged: TNotifyEvent;

  protected
    function CreateScrollBar(AKind: TScrollBarKind): TGridScrollBarEh; override;
    function GetEditMask(ACol, ARow: Longint): string; override;
    function GetEditText(ACol, ARow: Longint): string; override;
    function SelectCell(ACol, ARow: Longint): Boolean; override;

    procedure ColumnMoved(FromIndex, ToIndex: Longint); override;
    procedure DrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState); override;
    procedure RowMoved(FromIndex, ToIndex: Longint); override;
    procedure SetEditText(ACol, ARow: Longint; const Value: string); override;
    procedure TopLeftChanged; override;

    property OnColumnMoved: TMovedEvent read FOnColumnMoved write FOnColumnMoved;
    property OnDrawCell: TDrawCellEvent read FOnDrawCell write FOnDrawCell;
    property OnGetEditMask: TGetEditEvent read FOnGetEditMask write FOnGetEditMask;
    property OnGetEditText: TGetEditEvent read FOnGetEditText write FOnGetEditText;
    property OnRowMoved: TMovedEvent read FOnRowMoved write FOnRowMoved;
    property OnSelectCell: TSelectCellEvent read FOnSelectCell write FOnSelectCell;
    property OnSetEditText: TSetEditEvent read FOnSetEditText write FOnSetEditText;
    property OnTopLeftChanged: TNotifyEvent read FOnTopLeftChanged write FOnTopLeftChanged;
  public
    function CellRect(ACol, ARow: Longint): TRect;

    procedure MouseToCell(X, Y: Integer; var ACol, ARow: Longint);

    property Canvas;
    property Col;
    property ColCount;
    property ColWidths;
    property ContraColCount;
    property ContraRowCount;
    property EditorMode;
    property Flat;
    property FrozenColCount;
    property FrozenRowCount;
    property FullColCount;
    property FullRowCount;
    property LeftCol;
    property OutBoundaryData;
    property Row;
    property RowCount;
    property RowHeights;
    property SizeGripAlwaysShow;
    property TopRow;
  end;

{ TDrawGridEh }

  TDrawGridEh = class(TCustomDrawGridEh)
  published
    property Align;
    property Anchors;
    property BiDiMode;
    property BorderStyle;
    property Col;
    property ColCount;
    property Color;
    property ContraColCount;
    property ContraRowCount;
    property FixedColCount;
    property FixedRowCount;
    property FrozenColCount;
    property FrozenRowCount;
    property GridLineWidth;
    property HorzAxis;
    property HorzScrollBar;
    property Options;
    property RolColCount;
    property RolRowCount;
    property Row;
    property RowCount;
    property VertAxis;
    property VertScrollBar;
  end;

{ TCustomListboxEh }

  TCustomListboxEh = class(TCustomGridEh)
  private
    FItems: TStrings;
    {$IFDEF FPC}
    {$ELSE}
    FOnData: TLBGetDataEvent;
    FOnDataObject: TLBGetDataObjectEvent;
    {$ENDIF}
    FSorted: Boolean;
    FVirtualItems: Boolean;
    FVirtualRowCount: Integer;
    FItemHeight: Integer;
    FRowSeleced: Boolean;
    FImageList: TCustomImageList;
    FUseItemObjects: Boolean;
    FOnGetImageIndex: TListGetImageIndexEventEh;

    function GetCount: Integer;
    function GetItemHeight: Integer;
    function GetItemIndex: Integer;
    function GetTopIndex: Integer;

    procedure SetCount(const Value: Integer);
    procedure SetImageList(const Value: TCustomImageList);
    procedure SetItemHeight(const Value: Integer);
    procedure SetItemIndex(const Value: Integer);
    procedure SetSorted(const Value: Boolean);
    procedure SetTopIndex(const Value: Integer);
    procedure SetVirtualItems(const Value: Boolean);
  protected
    function ItemRect(Index: Integer): TRect;
    function GetItems: TStrings; virtual;
    function GetDisplayText(Index: Integer): String; virtual;

    procedure DrawCell(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState); override;
    procedure DrawItem(Index: Integer; ARect: TRect; State: TGridDrawState); virtual;
    procedure FocusCell(ACol, ARow: Longint; MoveAnchor: Boolean); override;
    procedure GetData(Index: Integer; var Data: string); virtual;
    procedure ItemsChanged(Sender: TObject);
    procedure KeyPress(var Key: Char); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Resize; override;
    procedure SetItems(const Value: TStrings); virtual;
    procedure UpdateRowCount;

    property Sorted: Boolean read FSorted write SetSorted default False;
    property TopIndex: Integer read GetTopIndex write SetTopIndex;

    {$IFDEF FPC}
    {$ELSE}
    property OnData: TLBGetDataEvent read FOnData write FOnData;
    property OnDataObject: TLBGetDataObjectEvent read FOnDataObject write FOnDataObject;
    {$ENDIF}
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure DefaultDrawItem(Index: Integer; ARect: TRect; State: TGridDrawState); virtual;
    procedure InvalidateIndex(AItemIndex: Integer);

    function ItemAtPos(Pos: TPoint; Existing: Boolean): Integer;
    function GetTextHeight: Integer; virtual;
    function StrictIndexToClient(X, Y: Integer): Integer;

    property Canvas;
    property Color;
    property Count: Integer read GetCount write SetCount;
    property ImageList: TCustomImageList read FImageList write SetImageList;
    property ItemHeight: Integer read GetItemHeight write SetItemHeight default 16;
    property ItemIndex: Integer read GetItemIndex write SetItemIndex;
    property Items: TStrings read GetItems write SetItems;
    property SizeGripAlwaysShow;
    property UseItemObjects: Boolean read FUseItemObjects write FUseItemObjects;
    property VirtualItems: Boolean read FVirtualItems write SetVirtualItems;

    property OnGetImageIndex: TListGetImageIndexEventEh read FOnGetImageIndex write FOnGetImageIndex;
  end;

{ TCustomListboxItemEh }

  TCustomListboxItemEh = class(TObject)
  private
  protected
    function CanFocus(Sender: TCustomListboxEh; ItemIndex: Integer): Boolean; virtual;
    function GetDisplayText(Sender: TCustomListboxEh; ItemIndex: Integer): String; virtual;

    procedure DrawItem(Sender: TCustomListboxEh; ItemIndex: Integer; ARect: TRect; State: TGridDrawState); virtual;
    procedure MouseDown(Sender: TCustomListboxEh; ItemIndex: Integer; InItemPos: TPoint; Button: TMouseButton; Shift: TShiftState); virtual;
    procedure MouseMove(Sender: TCustomListboxEh; ItemIndex: Integer; InItemPos: TPoint; Shift: TShiftState); virtual;
    procedure MouseUp(Sender: TCustomListboxEh; ItemIndex: Integer; InItemPos: TPoint; Button: TMouseButton; Shift: TShiftState); virtual;
    procedure KeyPress(Sender: TCustomListboxEh; ItemIndex: Integer; var Key: Char; Shift: TShiftState; var IsCloseListbox: Boolean); virtual;
  public
    function IsDataItem: Boolean; virtual;
    procedure Execute(Sender: TCustomListboxEh; ItemIndex: Integer; InItemPos: TPoint; Shift: TShiftState); virtual;
  end;

{ TPopupListboxEh }

  TPopupListboxEh = class(TCustomListboxEh)
  private
    FBorderWidth: Integer;
    FExtItems: TStrings;
    FMouseIndex: Integer;
    FMousePos: TPoint;
    FRowCount: Integer;
    FSearchText: String;
    FSearchTickCount: Longint;
    FSizeGripResized: Boolean;

    function CheckNewSize(var NewWidth, NewHeight: Integer): Boolean;
    function GetExtItems: TStrings;
    {$IFDEF FPC}
    {$ELSE}
    procedure CMCtl3DChanged(var Message: TMessage); message CM_CTL3DCHANGED;
    {$ENDIF}
    procedure CMSetSizeGripChangePosition(var Message: TMessage); message cm_SetSizeGripChangePosition;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure SetExtItems(Value: TStrings);
    procedure SetRowCount(Value: Integer);

    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCPaint(var Message: TWMNCPaint); message WM_NCPAINT;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMWindowPosChanging(var Message: TWMWindowPosChanging); message WM_WINDOWPOSCHANGING;

  protected
    FIsMouseUpCloseListbox: Boolean;

    function DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function GetItems: TStrings; override;

    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure DrawBorder; virtual;
    procedure GetData(Index: Integer; var Data: string); override;
    procedure KeyPress(var Key: Char); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure SelfOnGetDataObject(Control: TWinControl; Index: Integer; var DataObject: TObject); virtual;
    procedure SetItems(const Value: TStrings); override;
    procedure UpdateBorderWidth;
  public
    constructor Create(Owner: TComponent); override;

    function CanFocus: Boolean; override;
    function GetBorderSize: Integer;

    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;

    property BorderWidth: Integer read FBorderWidth;
    property Color;
    {$IFDEF FPC}
    {$ELSE}
    property Ctl3D;
    {$ENDIF}
    property Font;
    property ItemHeight;
    property IsMouseUpCloseListbox: Boolean read FIsMouseUpCloseListbox;
    property RowCount: Integer read FRowCount write SetRowCount;
    property ExtItems: TStrings read GetExtItems write SetExtItems;
    property SizeGripAlwaysShow;
    property SizeGripResized: Boolean read FSizeGripResized write FSizeGripResized;

    property OnMouseDown;
    property OnMouseUp;
    property OnKeyDown;
    property OnKeyUp;
    property OnKeyPress;
  end;

{ TPopupListboxItemEh }

  TPopupListboxItemEh = class(TCustomListboxItemEh)
  private
  protected
    procedure MouseUp(Sender: TCustomListboxEh; ItemIndex: Integer; InItemPos: TPoint; Button: TMouseButton; Shift: TShiftState; var IsCloseListbox: Boolean); reintroduce; virtual;
  public
    function CloseOnExecute(Sender: TCustomListboxEh; ItemIndex: Integer): Boolean; virtual;
    procedure Execute(Sender: TCustomListboxEh; ItemIndex: Integer; InItemPos: TPoint; Shift: TShiftState); override;
  end;

{ TMRUListboxEh }

  TMRUListboxEh = class(TPopupListboxEh)
  private
  protected
  public
    constructor Create(Owner: TComponent); override;
    {$IFDEF FPC}
    {$ELSE}
    property ParentCtl3D;
    {$ENDIF}
    property Sorted;
    property OnMouseUp;
  end;

{ TGridDrawStyleEh }

  TGridDrawStyleEh = class(TComponent)
  private
    FDrawFocusFrame: Boolean;
    FDrawFocusFrameStored: Boolean;
    FGrids: TObjectList;
    FSelectionStyle: TGridSelectionDrawStyleEh;

    function GetDrawFocusFrame: Boolean;
    function IsDrawFocusFrameStored: Boolean;
    procedure SetDrawFocusFrame(const Value: Boolean);
    procedure SetDrawFocusFrameStored(const Value: Boolean);
    procedure SetSelectionStyle(const Value: TGridSelectionDrawStyleEh);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function DefaultDrawFocusFrame: Boolean; virtual;
    function GetActualSelectionStyle: TGridSelectionDrawStyleEh;
    function GetDefaultActualSelectionStyle: TGridSelectionDrawStyleEh; virtual;
    function GridInChangeNotification(Grid: TCustomGridEh): Boolean;
    function IsCustomStyleActive: Boolean;

    procedure AddChangeNotification(Grid: TCustomGridEh);
    procedure Changed;
    procedure RemoveChangeNotification(Grid: TCustomGridEh);
  published

    property DrawFocusFrame: Boolean read GetDrawFocusFrame write SetDrawFocusFrame;
    property DrawFocusFrameStored: Boolean read IsDrawFocusFrameStored write SetDrawFocusFrameStored default False;
    property SelectionStyle: TGridSelectionDrawStyleEh read FSelectionStyle write SetSelectionStyle default gsdsDefaultEh;
  end;

function GridCoord(X, Y: Longint): TGridCoord;
function GridDefaultDrawStyleEh: TGridDrawStyleEh;
function SetGridDefaultDrawStyleEh(NewGridDefaultDrawStyle: TGridDrawStyleEh): TGridDrawStyleEh;

procedure BinarySearch(Poses: TInt64DynArray; TargetPos: Int64; var ACol, AColOffset: Integer);
procedure FillArray(Arr: TIntegerDynArray; const Pos, Count, Value: Integer);

var
  GridEhDebugDraw: Boolean;
  DummyPopupListboxItemEh: TPopupListboxItemEh;

implementation

uses Math
{$IFNDEF FPC}
, Consts
{$ENDIF}
;

type
  TScrollBarCracker = class(TScrollBar) end;

procedure SwapInteger(var a, b: Integer);
var
  c: Integer;
begin
  c := a;
  a := b;
  b := c;
end;

function GridCoord(X, Y: Longint): TGridCoord;
begin
  Result.X := X;
  Result.Y := Y;
end;

procedure ArrayMove(var Extents: TIntegerDynArray; FromIndex, ToIndex: Longint);
var
  Extent, I: Integer;
begin
  if Length(Extents) <> 0 then
  begin
    Extent := Extents[FromIndex];
    if FromIndex < ToIndex then
      for I := FromIndex + 1 to ToIndex do
        Extents[I - 1] := Extents[I]
    else if FromIndex > ToIndex then
      for I := FromIndex - 1 downto ToIndex do
        Extents[I + 1] := Extents[I];
    Extents[ToIndex] := Extent;
  end;
end;

function CompareAxisSize(Ax1, Ax2: TGridAxisDataEh): Boolean;
var
  I: Integer;
begin
  Result := False;
  if Ax1.FullCelCount = Ax2.FullCelCount then
  begin
    for I := 0 to Ax1.FullCelCount do
      if Ax1.CelLens[I] <> Ax2.CelLens[I] then Exit;
    Result := True;
  end;
end;

procedure ArrayInsertRange(var Extents: TIntegerDynArray; StartIndex, Amount: Longint);
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

procedure ArrayDeleteRange(var Extents: TIntegerDynArray; StartIndex, Amount: Longint);
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

procedure FillArray(Arr: TIntegerDynArray; const Pos, Count, Value: Integer);
var
  i: Integer;
begin
  for i := Pos to Pos + Count - 1 do
    Arr[i] := Value;
end;

procedure BinarySearch(Poses: TInt64DynArray; TargetPos: Int64; var ACol, AColOffset: Integer);
var
  AMin, AMax: Integer;
  ArrSize, AIdx, ANewIdx: Integer;
begin
  ArrSize := Length(Poses);
  AMin := 0;
  AMax := ArrSize-1;
  if Poses[AMin] >= TargetPos then
  begin
    ACol := AMin;
    AColOffset := TargetPos - Poses[AMin];
    Exit;
  end else if Poses[AMax] <= TargetPos then
  begin
    ACol := AMax;
    AColOffset := TargetPos - Poses[AMax];
    Exit;
  end;

  AIdx := (AMax - AMin) div 2;
  ANewIdx := AIdx;

  while True do
  begin
    if Poses[AIdx] > TargetPos then
    begin
      AMax := AIdx;
      AIdx := (AMax + AMin) div 2;
    end else if Poses[AIdx] < TargetPos then
    begin
      AMin := AIdx;
      AIdx := (AMax + AMin) div 2;
    end else
    begin
      ACol := AIdx;
      AColOffset := 0;
      Exit;
    end;
    if ANewIdx = AIdx then
    begin
      ACol := AIdx;
      AColOffset := TargetPos - Poses[AIdx];
      Break;
    end;
    ANewIdx := AIdx;
  end;
end;

function GridRect(Coord1, Coord2: TGridCoord): TGridRect;
begin
  with Result do
  begin
    if Coord1.X < Coord2.X then
    begin
      Left := Coord1.X;
      Right := Coord2.X;
    end else
    begin
      Left := Coord2.X;
      Right := Coord1.X;
    end;
    if Coord1.Y < Coord2.Y then
    begin
      Top := Coord1.Y;
      Bottom := Coord2.Y;
    end else
    begin
      Top := Coord2.Y;
      Bottom := Coord1.Y;
    end
  end;
end;

function PointInGridRect(Col, Row: Longint; const Rect: TGridRect): Boolean;
begin
  Result := (Col >= Rect.Left) and (Col <= Rect.Right) and (Row >= Rect.Top)
    and (Row <= Rect.Bottom);
end;

type
  TSelection = record
    StartPos, EndPos: Integer;
  end;

{ TInplaceEdit }

constructor TInplaceEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFNDEF FPC}
  ParentCtl3D := False;
  Ctl3D := False;
{$ENDIF}
  TabStop := False;
  BorderStyle := bsNone;
  DoubleBuffered := False;
  AutoSize := False;
end;

procedure TInplaceEdit.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style or ES_MULTILINE; //CTRL-A won't work.
end;

procedure TInplaceEdit.SetGrid(Value: TCustomGridEh);
begin
  FGrid := Value;
end;

procedure TInplaceEdit.CMShowingChanged(var Message: TMessage);
begin
  { Ignore showing using the Visible property }
end;

procedure TInplaceEdit.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  inherited;
  if goTabsEh in Grid.Options then
    Message.Result := Message.Result or DLGC_WANTTAB;
end;

procedure TInplaceEdit.WMPaste(var Message: TMessage);
begin
  if not EditCanModify then Exit;
  inherited
end;

procedure TInplaceEdit.WMClear(var Message: TMessage);
begin
  if not EditCanModify then Exit;
  inherited;
end;

procedure TInplaceEdit.WMCut(var Message: TMessage);
begin
  if not EditCanModify then Exit;
  inherited;
end;

procedure TInplaceEdit.DblClick;
begin
{$IFDEF CIL}
//  Grid.DblClick;
{$ELSE}
  Grid.DblClick;
{$ENDIF}
end;

function TInplaceEdit.DoMouseWheel(Shift: TShiftState; WheelDelta: Integer;
  MousePos: TPoint): Boolean;
begin
{$IFDEF CIL}
//  Result := Grid.DoMouseWheel(Shift, WheelDelta, MousePos);
{$ELSE}
  Result := Grid.DoMouseWheel(Shift, WheelDelta, MousePos);
{$ENDIF}
end;

function TInplaceEdit.EditCanModify: Boolean;
begin
  Result := Grid.CanEditModify;
end;

procedure TInplaceEdit.KeyDown(var Key: Word; Shift: TShiftState);

  procedure SendToParent;
  begin
    Grid.KeyDown(Key, Shift);
    Key := 0;
  end;

  procedure ParentEvent;
  var
    GridKeyDown: TKeyEvent;
  begin
{$IFDEF CIL}
//    GridKeyDown := Grid.OnKeyDown;
{$ELSE}
    GridKeyDown := Grid.OnKeyDown;
{$ENDIF}
    if Assigned(GridKeyDown) then GridKeyDown(Grid, Key, Shift);
  end;

  function ForwardMovement: Boolean;
  begin
    Result := goAlwaysShowEditorEh in Grid.Options;
  end;

  function Ctrl: Boolean;
  begin
    Result := [ssCtrl] = Shift;
  end;

  function Selection: TSelection;
  begin
//    SendMessage(Handle, EM_GETSEL, Longint(@Result.StartPos), Longint(@Result.EndPos));
    MessageSendGetSel(Handle, Result.StartPos, Result.EndPos);
  end;

  function CaretPos: Integer;
  var
    P: TPoint;
  begin
    Windows.GetCaretPos(P);
    Result := SendMessage(Handle, EM_CHARFROMPOS, 0, MakeLong(P.X, P.Y));
  end;

  function RightSide: Boolean;
  begin
    with Selection do
      Result := (CaretPos = GetTextLen) and
        ((StartPos = 0) or (EndPos = StartPos)) and (EndPos = GetTextLen);
   end;

  function LeftSide: Boolean;
  begin
    with Selection do
    begin
      Result := (CaretPos = 0) and (StartPos = 0) and
        ((EndPos = 0) or (EndPos = GetTextLen));
      Result := Result or
        ((CaretPos = GetTextLen) and (StartPos = 0) and (EndPos = GetTextLen));
    end;
  end;

begin
  if Grid.WantInplaceEditorKey(Key, Shift) then
    SendToParent;
  case Key of
    VK_INSERT:
      if (Shift = [ssShift]) and not Grid.CanEditModify then Key := 0;
    VK_F2:
      begin
        ParentEvent;
        if Key = VK_F2 then
        begin
          Deselect;
          Exit;
        end;
      end;
    VK_DELETE:
      if not Grid.CanEditModify then Key := 0;
    Integer('A'):
      if Ctrl then
        SelectAll;
  end;
  if Key <> 0 then
  begin
    ParentEvent;
    inherited KeyDown(Key, Shift);
  end;
end;

procedure TInplaceEdit.KeyPress(var Key: Char);
var
  Selection: TSelection;
begin
  Grid.KeyPress(Key);
  if (Key >= #32) and not Grid.CanEditAcceptKey(Key) then
  begin
    Key := #0;
    MessageBeep(0);
  end;
  case Key of
    #9, #27: Key := #0;
    #13:
      begin
        MessageSendGetSel(Handle, Selection.StartPos, Selection.EndPos);
//        SendMessage(Handle, EM_GETSEL, Longint(@Selection.StartPos), Longint(@Selection.EndPos));
        if (Selection.StartPos = 0) and (Selection.EndPos = GetTextLen) then
          Deselect else
          SelectAll;
        Key := #0;
      end;
    ^H, ^V, ^X, #32..High(Char):
      if not Grid.CanEditModify then Key := #0;
  end;
  if Key <> #0 then inherited KeyPress(Key);
end;

procedure TInplaceEdit.KeyUp(var Key: Word; Shift: TShiftState);
begin
{$IFDEF CIL}
//  Grid.KeyUp(Key, Shift);
{$ELSE}
  Grid.KeyUp(Key, Shift);
{$ENDIF}
end;

procedure TInplaceEdit.WndProc(var Message: TMessage);
begin
  case Message.Msg of
    WM_SETFOCUS:
      begin
        if (GetParentForm(Self) = nil) or GetParentForm(Self).SetFocusedControl(Grid) then
          Dispatch(Message);
        Exit;
      end;
    WM_LBUTTONDOWN:
      begin
        if UINT(GetMessageTime - FClickTime) < GetDoubleClickTime then
          Message.Msg := WM_LBUTTONDBLCLK;
        FClickTime := 0;
      end;
  end;
  inherited WndProc(Message);
end;

procedure TInplaceEdit.Deselect;
begin
  SendMessage(Handle, EM_SETSEL, $7FFFFFFF, LPARAM($FFFFFFFF));
end;

procedure TInplaceEdit.Invalidate;
var
  Cur: TRect;
begin
  if not HandleAllocated then Exit;
  ValidateRect(Handle, nil);
  InvalidateRect(Handle, nil, True);
  Windows.GetClientRect(Handle, Cur);
  MapWindowPoints(Handle, Grid.Handle, Cur, 2);
  WindowsValidateRect(Grid.Handle, Cur);
  WindowsInvalidateRect(Grid.Handle, Cur, False);
end;

procedure TInplaceEdit.Hide;
begin
  if HandleAllocated and IsWindowVisible(Handle) then
  begin
    Invalidate;
    SetWindowPos(Handle, 0, 0, 0, 0, 0, SWP_HIDEWINDOW or SWP_NOZORDER or
      SWP_NOREDRAW);
    if Focused then Windows.SetFocus(Grid.Handle);
  end;
end;

function TInplaceEdit.PosEqual(const Rect: TRect): Boolean;
var
  Cur: TRect;
begin
  GetWindowRect(Handle, Cur);
  MapWindowPoints(HWND_DESKTOP, Grid.Handle, Cur, 2);
  Result := EqualRect(Rect, Cur);
end;

procedure TInplaceEdit.InternalMove(const Loc: TRect; Redraw: Boolean);
begin
  if IsRectEmpty(Loc) then Hide
  else
  begin
    CreateHandle;
    Redraw := Redraw or not IsWindowVisible(Handle);
    Invalidate;
    with Loc do
      SetWindowPos(Handle, HWND_TOP, Left, Top, Right - Left, Bottom - Top,
        SWP_SHOWWINDOW or SWP_NOREDRAW);
    BoundsChanged;
    if Redraw then Invalidate;
    if Grid.Focused then
      Windows.SetFocus(Handle);
  end;
end;

procedure TInplaceEdit.BoundsChanged;
var
  R: TRect;
begin
  R := Rect(2, 2, Width - 2, Height);
//  SendMessage(Handle, EM_SETRECTNP, 0, LongInt(@R));
  SendStructMessage(Handle, EM_SETRECTNP, 0, R);
  SendMessage(Handle, EM_SCROLLCARET, 0, 0);
end;

procedure TInplaceEdit.UpdateLoc(const Loc: TRect);
begin
  InternalMove(Loc, False);
end;

function TInplaceEdit.Visible: Boolean;
begin
  Result := IsWindowVisible(Handle);
end;

procedure TInplaceEdit.Move(const Loc: TRect);
begin
  InternalMove(Loc, True);
end;

procedure TInplaceEdit.SetFocus;
begin
  if IsWindowVisible(Handle) then
    Windows.SetFocus(Handle);
end;

procedure TInplaceEdit.UpdateContents;
begin
  EditMask := Grid.GetEditMask(Grid.Col, Grid.Row);
  Text := Grid.GetEditText(Grid.Col, Grid.Row);
  MaxLength := Grid.GetEditLimit;
end;

{$IFDEF FPC}
function TInplaceEdit.ChildClassAllowed(ChildClass: TClass): boolean;
begin
  Result := True;
end;
{$ENDIF}

procedure TInplaceEdit.Change;
begin
  inherited Change;
  if (FGrid <> nil) and Visible then
    FGrid.UpdateText;
end;

{ TCustomGridEh }

//{$IFDEF EH_LIB_16}
//class constructor TCustomGridEh.Create;
//begin
//  TCustomStyleEngine.RegisterStyleHook(TCustomGridEh, TScrollingStyleHook);
//end;
//{$ENDIF}

constructor TCustomGridEh.Create(AOwner: TComponent);
const
  GridStyle = [csCaptureMouse, csOpaque, csDoubleClicks
              {$IFDEF EH_LIB_13}
              , csGestures
              {$ENDIF}
              ];
begin
  inherited Create(AOwner);
  if NewStyleControls then
    ControlStyle := GridStyle
  else
    ControlStyle := GridStyle + [csFramed];
{$IFDEF EH_LIB_7}
  ControlStyle := ControlStyle + [csNeedsBorderPaint];
{$ENDIF}
  RegetDefaultStyle;

  FHorzAxis := TGridAxisDataEh.Create(Self);
  FVertAxis := TGridAxisDataEh.Create(Self);
  FHorzScrollBar := CreateScrollBar(sbHorizontal);
  FVertScrollBar := CreateScrollBar(sbVertical);
  FScrollBarSize := GetSystemMetrics(SM_CYHSCROLL);

  DefaultColWidth := 50;
  DefaultRowHeight := 20;
  FCanEditModify := True;

  FOptions := [
    goFixedVertLineEh, goFixedHorzLineEh, goVertLineEh, goHorzLineEh,
    goDrawFocusSelectedEh, goEditingEh,
    goRowSizingEh, goColSizingEh, goRowMovingEh, goColMovingEh,
    goContraVertBoundaryLineEh, goContraHorzBoundaryLineEh];

  FDesignOptionsBoost := [goColSizingEh, goRowSizingEh, goColMovingEh];

  FGridLineWidth := 1;
  FFixedColor := clBtnFace;

  FBorderStyle := bsSingle;

  FEditorMode := False;
  Color := clWindow;
  ParentColor := False;
  TabStop := True;

  Initialize;
  FFixedLineColor := clBlack;
  FGridLineColors := CreateGridLineColors;
  FOutBoundaryData := TGridOutBoundaryDataEh.Create(Self);
  FMouseDownCell := MouseCoord(-1, -1);

  FHotTrackCell.X := -1;
  FHotTrackCell.Y := -1;
  FHotTrackInCellPos.X := -1;
  FHotTrackInCellPos.Y := -1;
  FOldHotTrackSpot := CreateHotTrackSpot;
  FNewHotTrackSpot := CreateHotTrackSpot;
  FBackgroundData :=  CreateBackgroundData;
  FSizeGripPostion := sgpBottomRight;

  FHorzScrollBarPanelControl := CreateHorzScrollBarPanelControl;
  with FHorzScrollBarPanelControl do
  begin
    Name := 'HorzScrollBarPanelControl';
    Parent := Self;
    Visible := False;
    SetBounds(0,0,0,0);
    {$IFNDEF FPC}
    ParentBackground := False;
    {$ENDIF}
    Caption := '';
  end;

  FVertScrollBarPanelControl := CreateVertScrollBarPanelControl;
  with FVertScrollBarPanelControl do
  begin
    Name := 'VertScrollBarPanelControl';
    Parent := Self;
    Visible := False;
    SetBounds(0,0,0,0);
    {$IFNDEF FPC}
    ParentBackground := False;
    {$ENDIF}
    Caption := '';
  end;

  FCornerScrollBarPanelControl := CreateSizeGripPanel;
  with FCornerScrollBarPanelControl do
  begin
    Name := 'CornerScrollBarPanelControl';
    Parent := Self;
    Visible := False;
    SetBounds(0,0,0,0);
    {$IFNDEF FPC}
    ParentBackground := False;
    {$ENDIF}
  end;

  FExtraSizeGripControl := TSizeGripPanelEh.Create(Self);
  with FExtraSizeGripControl do
  begin
//    Name := '';
    Parent := Self;
    Visible := False;
    SetBounds(0,0,0,0);
    {$IFNDEF FPC}
    ParentBackground := False;
    {$ENDIF}
    FExtraSizeGripControl.GripActiveStatus := gasNeverEh;
  end;


  RolColCount := 5;
  RolRowCount := 5;
  FixedColCount := 1;
  FixedRowCount := 1;
  SetBounds(Left, Top, ColCount * DefaultColWidth, RowCount * DefaultRowHeight);

{$IFDEF EH_LIB_13}
  Touch.InteractiveGestures := [igPan, igPressAndTap];
  Touch.InteractiveGestureOptions := [igoPanInertia,
    igoPanSingleFingerHorizontal, igoPanSingleFingerVertical,
    igoPanGutter, igoParentPassthrough];
{$ENDIF}
  FSelectionDrawParams := TGridSelectionDrawParamsEh.Create(Self);
end;

destructor TCustomGridEh.Destroy;
begin
  if FDrawStyle <> nil then
    FDrawStyle.RemoveChangeNotification(Self);
  FreeAndNil(FInplaceEdit);
  FreeAndNil(FSelectionDrawParams);

  FreeAndNil(FHorzAxis);
  FreeAndNil(FVertAxis);
  FreeAndNil(FOutBoundaryData);
  FreeAndNil(FHorzScrollBar);
  FreeAndNil(FVertScrollBar);
  FreeAndNil(FGridLineColors);

  FreeAndNil(FHorzScrollBarPanelControl);
  FreeAndNil(FVertScrollBarPanelControl);
  FreeAndNil(FCornerScrollBarPanelControl);
  FreeAndNil(FExtraSizeGripControl);

  FreeAndNil(FOldHotTrackSpot);
  FreeAndNil(FNewHotTrackSpot);
  inherited Destroy;
  FreeAndNil(FBackgroundData);
end;

function TCustomGridEh.CreateBackgroundData: TGridBackgroundDataEh;
begin
  Result := TGridBackgroundDataEh.Create(Self);
end;

function TCustomGridEh.BoxRect(ALeft, ATop, ARight, ABottom: Integer;
  IncludeLine: Boolean): TRect;
var
  GridRect: TGridRect;
begin
  GridRect.Left := ALeft;
  GridRect.Right := ARight;
  GridRect.Top := ATop;
  GridRect.Bottom := ABottom;
  GridRectToScreenRect(GridRect, Result);
end;

function TCustomGridEh.BoxRectAbs(ALeft, ATop, ARight, ABottom: Integer;
  IncludeLine: Boolean): TRect;
var
  GridRect: TGridRect;
begin
  GridRect.Left := ALeft;
  GridRect.Right := ARight;
  GridRect.Top := ATop;
  GridRect.Bottom := ABottom;
  GridRectToScreenRectAbs(GridRect, Result, IncludeLine);
end;

procedure TCustomGridEh.DoExit;
begin
  inherited DoExit;
  if not (goAlwaysShowEditorEh in Options) then HideEditor;
end;

function TCustomGridEh.CellRect(ACol, ARow: Integer; IncludeLine: Boolean): TRect;
begin
  Result := BoxRect(ACol, ARow, ACol, ARow, IncludeLine);
end;

function TCustomGridEh.CellRectAbs(ACol, ARow: Integer;
  IncludeLine: Boolean): TRect;
begin
  Result := BoxRectAbs(ACol, ARow, ACol, ARow, IncludeLine);
end;

function TCustomGridEh.CellEditRect(ACol, ARow: Longint): TRect;
begin
  Result := CellRect(ACol, ARow, False);

  if CheckCellLine(ACol, ARow, cbtRightEh) and (Result.Left + ColWidths[ACol] <= Result.Right) then
  begin
    if UseRightToLeftAlignment
      then Inc(Result.Left, GridLineWidth)
      else Dec(Result.Right, GridLineWidth)
  end;

  if CheckCellLine(ACol, ARow, cbtBottomEh) then
    Dec(Result.Bottom, GridLineWidth)

//  if CheckPersistentContraLine(cbtLeftEh) and (ACol >= ColCount) then
//    Dec(Result.Bottom, GridLineWidth)
end;

function TCustomGridEh.CanEditAcceptKey(Key: Char): Boolean;
begin
  Result := True;
end;

function TCustomGridEh.CanGridAcceptKey(Key: Word; Shift: TShiftState): Boolean;
begin
  Result := True;
end;

function TCustomGridEh.CanEditModify: Boolean;
begin
  Result := FCanEditModify;
end;

function TCustomGridEh.CanEditShow: Boolean;
begin
  Result := ([goRowSelectEh, goEditingEh] * Options = [goEditingEh]) and
    FEditorMode and not (csDesigning in ComponentState) and HandleAllocated and
    ((goAlwaysShowEditorEh in Options) or IsActiveControl);
end;

function TCustomGridEh.CanFillSelectionByTheme: Boolean;
begin
//  Result := ThemesEnabled and (Win32MajorVersion >= 6);
  Result := False;
end;

function TCustomGridEh.IsActiveControl: Boolean;
var
  H: Hwnd;
  ParentForm: TCustomForm;
begin
  Result := False;
  ParentForm := GetParentForm(Self);
  if Assigned(ParentForm) then
  begin
    if (ParentForm.ActiveControl = Self) then
      Result := True
  end
  else
  begin
    H := GetFocus;
    while IsWindow(H) and (Result = False) do
    begin
      if H = WindowHandle then
        Result := True
      else
        H := GetParent(H);
    end;
  end;
end;

function TCustomGridEh.GetEditMask(ACol, ARow: Longint): string;
begin
  Result := '';
end;

function TCustomGridEh.GetEditText(ACol, ARow: Longint): string;
begin
  Result := '';
end;

procedure TCustomGridEh.SetEditText(ACol, ARow: Longint; const Value: string);
begin
end;

function TCustomGridEh.GetEditLimit: Integer;
begin
  Result := 0;
end;

function TCustomGridEh.GetEditStyle(ACol, ARow: Longint): TEditStyle;
begin
  Result := esSimple;
end;

procedure TCustomGridEh.HideEditor;
begin
  FEditorMode := False;
  HideEdit;
end;

procedure TCustomGridEh.ShowEditor;
begin
  FEditorMode := True;
  UpdateEdit;
end;

procedure TCustomGridEh.ShowEditorChar(Ch: Char);
begin
  ShowEditor;
  if (FInplaceEdit <> nil) and FInplaceEdit.Visible then
    PostMessage(FInplaceEdit.Handle, WM_CHAR, Ord(Ch), 0);
end;

procedure TCustomGridEh.InvalidateEditor;
begin
  FInplaceCol := -1;
  FInplaceRow := -1;
  UpdateEdit;
end;

procedure TCustomGridEh.ReadColWidths(Reader: TReader);
var
  I: Integer;
begin
  with Reader do
  begin
    ReadListBegin;
    for I := 0 to ColCount - 1 do ColWidths[I] := ReadInteger;
    ReadListEnd;
  end;
end;

procedure TCustomGridEh.ReadRowHeights(Reader: TReader);
var
  I: Integer;
begin
  with Reader do
  begin
    ReadListBegin;
    for I := 0 to RowCount - 1 do RowHeights[I] := ReadInteger;
    ReadListEnd;
  end;
end;

procedure TCustomGridEh.WriteColWidths(Writer: TWriter);
var
  I: Integer;
begin
  with Writer do
  begin
    WriteListBegin;
    for I := 0 to ColCount - 1 do WriteInteger(ColWidths[I]);
    WriteListEnd;
  end;
end;

procedure TCustomGridEh.WriteRowHeights(Writer: TWriter);
var
  I: Integer;
begin
  with Writer do
  begin
    WriteListBegin;
    for I := 0 to RowCount - 1 do WriteInteger(RowHeights[I]);
    WriteListEnd;
  end;
end;

procedure TCustomGridEh.DefineProperties(Filer: TFiler);

  function DoColWidths: Boolean;
  begin
    if Filer.Ancestor <> nil then
      Result := not CompareAxisSize(TCustomGridEh(Filer.Ancestor).HorzAxis, HorzAxis)
    else
      Result := HorzAxis.FullCelCount <> 0;
  end;

  function DoRowHeights: Boolean;
  begin
    if Filer.Ancestor <> nil then
      Result := not CompareAxisSize(TCustomGridEh(Filer.Ancestor).VertAxis, VertAxis)
    else
      Result := HorzAxis.FullCelCount <> 0;
  end;

begin
  inherited DefineProperties(Filer);
  if FSaveCellExtents then
    with Filer do
    begin
      DefineProperty('ColWidths', ReadColWidths, WriteColWidths, DoColWidths);
      DefineProperty('RowHeights', ReadRowHeights, WriteRowHeights, DoRowHeights);
    end;
end;

procedure TCustomGridEh.AxisMoved(Axis: TGridAxisDataEh; FromIndex, ToIndex: Integer);
begin
  Invalidate;  
  if Axis = HorzAxis
    then ColumnMoved(FromIndex, ToIndex)
    else RowMoved(FromIndex, ToIndex);
end;

procedure TCustomGridEh.ColumnMoved(FromIndex, ToIndex: Longint);
var
  AOldCell: TGridCoord;
begin
  AOldCell := FCurCell;
  if FCurCell.X = FromIndex then
    FCurCell.X := ToIndex
  else if (FromIndex < FCurCell.X) and (ToIndex >= FCurCell.X) then
    FCurCell.X := FCurCell.X - 1
  else if (FromIndex > FCurCell.X) and (ToIndex <= FCurCell.X) then
    FCurCell.X := FCurCell.X + 1;
  if (AOldCell.X = FAnchorCell.X) and (AOldCell.Y = FAnchorCell.Y) then
    FAnchorCell := FCurCell;
end;

procedure TCustomGridEh.RowMoved(FromIndex, ToIndex: Longint);
begin
end;

function TCustomGridEh.MouseCoord(X, Y: Integer): TGridCoord;
begin
  Result := CalcCoordFromPoint(X, Y);
  if Result.X < 0 then Result.Y := -1
  else if Result.Y < 0 then Result.X := -1;
end;

procedure TCustomGridEh.MoveColRow(ACol, ARow: Longint; ShowX, ShowY: Boolean);
begin
  MoveCurrent(ACol, ARow, ShowX, ShowY);
end;

function TCustomGridEh.SelectCell(ACol, ARow: Integer): Boolean;
begin
  Result := True;
end;

function TCustomGridEh.Sizing(X, Y: Integer): Boolean;
begin
  Result := CheckSizingState(X, Y) <> gsNormalEh;
end;

function TCustomGridEh.CheckSizingState(X, Y: Integer): TGridStateEh;
var
  State: TGridStateEh;
  Index: Longint;
  Pos, Ofs: Integer;
begin
  State := FGridState;
  if State = gsNormalEh then
  begin
    CalcSizingState(X, Y, State, Index, Pos, Ofs);
  end;
  Result := State;
end;

function TCustomGridEh.ChildControlCanMouseDown(AControl: TControl): Boolean;
begin
  Result := True;
  if CanFocus then
    SetFocus;
end;

procedure TCustomGridEh.TopLeftChanged;
begin
end;

function TCustomGridEh.GridBackgroundFilled: Boolean;
begin
  Result := BackgroundData.Showing;
end;

function TCustomGridEh.GetDefaultSelectionStyle: TGridSelectionDrawStyleEh;
begin
  Result := DrawStyle.GetActualSelectionStyle;
end;

function TCustomGridEh.DefaultDrawFocusFrame: Boolean;
begin
  Result := DrawStyle.DrawFocusFrame;
end;

function TCustomGridEh.IsDrawCellSelectionThemed(ACol, ARow: Integer; State: TGridDrawState): Boolean;
var
  SelStyle: TGridSelectionDrawStyleEh;
begin
  SelStyle := SelectionDrawParams.GetActualSelectionStyle;
  if ThemesEnabled then
  begin
    if (SelStyle = gsdsGridThemedEh) and
       (gdFocused in State)
    then
      Result := True
    else if (SelStyle = gsdsListViewThemedEh) and
            ([gdFocused, gdCurrent] * State <> [])
    then
      Result := True
    else if (SelStyle in [gsdsListViewThemedEh, gsdsGridThemedEh]) and
            (goRowSelectEh in Options) and
            ([gdSelected, gdRowSelected] * State <> [])
    then
      Result := True
    else
      Result := False;
  end else
    Result := False;
end;

function TCustomGridEh.IsMultiSelected: Boolean;
begin
  Result := (FAnchorCell.X <> FCurCell.X) or (FAnchorCell.Y <> FCurCell.Y);
end;

procedure TCustomGridEh.DrawCellDataBackground(ACol, ARow: Integer;
  AreaRect: TRect; State: TGridDrawState);
var
{$IFDEF EH_LIB_16}
  Style: TCustomStyleServices;
{$ELSE}
  Style: TThemeServices;
{$ENDIF}
  ThemDet: TThemedElementDetails;
  ClipRect: TRect;
  SelStyle: TGridSelectionDrawStyleEh;
begin
{$IFDEF EH_LIB_16}
  Style := StyleServices;
{$ELSE}
  Style := ThemeServices;
{$ENDIF}
//  if not (gdFocused in State) then
//    Exit;

  SelStyle := SelectionDrawParams.GetActualSelectionStyle;

  if SelStyle = gsdsListViewThemedEh then
  begin
    if ([gdSelected, gdFocused] * State <> []) and Focused then
    begin
{$IFDEF EH_LIB_16}
      ThemDet := Style.GetElementDetails(tlGroupHeaderCloseSelected)
{$ELSE}
      ThemDet.Element := teListView;
      ThemDet.Part := 6;
      ThemDet.State := 11;
{$ENDIF}
    end else if [gdSelected, gdCurrent] * State <> [] then
    begin
{$IFDEF EH_LIB_16}
      ThemDet := Style.GetElementDetails(tlGroupHeaderCloseSelectedNotFocused);
{$ELSE}
      ThemDet.Element := teListView;
      ThemDet.Part := 6;
      ThemDet.State := 13;
{$ENDIF}
    end
  end else if SelStyle = gsdsGridThemedEh then
  begin
{$IFDEF EH_LIB_16}
    ThemDet := Style.GetElementDetails(tgCellSelected);
{$ELSE}
      ThemDet.Element := teListView;
      ThemDet.Part := 6;
      ThemDet.State := 11;
{$ENDIF}
  end;

  if goRowSelectEh in Options then
  begin
    ClipRect := AreaRect;
    if ACol > FixedColCount then
      Dec(AreaRect.Left, 10);
    if ACol < ColCount -1 then
    begin
      Inc(AreaRect.Right, 10);
      if CheckCellLine(ACol, ARow, cbtRightEh) then
        Inc(ClipRect.Right, 1);
    end;
    Style.DrawElement(Canvas.Handle, ThemDet, AreaRect, @ClipRect);
  end else
    Style.DrawElement(Canvas.Handle, ThemDet, AreaRect, nil);
end;

procedure TCustomGridEh.CheckDrawCellBorder(ACol, ARow: Integer;
  BorderType: TGridCellBorderTypeEh; var IsDraw: Boolean;
  var BorderColor: TColor; var IsExtent: Boolean);
begin
  if BorderType in [cbtLeftEh, cbtRightEh] then
  begin
    if (ACol < FixedColCount) or (ARow < FixedRowCount)
      then IsDraw := goFixedVertLineEh in Options
      else IsDraw := goVertLineEh in Options;
    IsExtent := True;
  end else
  begin
    if (ACol < FixedColCount) or (ARow < FixedRowCount)
      then IsDraw := goFixedHorzLineEh in Options
      else IsDraw := goHorzLineEh in Options;
    IsExtent := True;
  end;

  if (BorderType in [cbtTopEh, cbtLeftEh]) and ((ACol = ColCount) or (ARow = RowCount)) then
    BorderColor := GridLineColors.GetDarkColor
  else if (ACol < FixedColCount-FrozenColCount) or (ARow < FixedRowCount-FrozenRowCount) then
    BorderColor := GridLineColors.GetDarkColor
  else if (ACol = FixedColCount-1) and (BorderType = cbtRightEh) then
    BorderColor := GridLineColors.GetDarkColor
  else if (ARow = FixedRowCount-1) and (BorderType = cbtBottomEh) then
    BorderColor := GridLineColors.GetDarkColor
  else
    BorderColor := GridLineColors.GetBrightColor;
end;

procedure TCustomGridEh.Paint;
var
  ColI, RowI: Integer;
  ACellRect: TRect;
  RestRgn: HRgn;
  RestRect: TRect;
  HorzAxisContraBoundary: Integer;
  VertAxisContraBoundary: Integer;
  Sel: TGridRect;

  procedure DrawCells(ACol, ARow: Integer;
    StopCol, StopRow: Integer;
    StartX, StartY, StopX, StopY: Integer;
    CellTypeState: TGridDrawState);
  var
    CurCol, CurRow: Longint;
    Where: TRect;
    CellState: TGridDrawState;
    ControlFocused: Boolean;
  begin
    CurRow := ARow;
    Where.Top := StartY;
    while (Where.Top < StopY) and (CurRow < StopRow) do
    begin
      CurCol := ACol;
      Where.Left := StartX;
      Where.Bottom := Where.Top + RowHeights[CurRow];
      while (Where.Left < StopX) and (CurCol < StopCol) do
      begin
        Where.Right := Where.Left + ColWidths[CurCol];
        if (Where.Right > Where.Left) {and RectVisible(Canvas.Handle, Where)} then
        begin
          CellState := CellTypeState;
          ControlFocused := Focused;
          if (CurRow = Row) and (CurCol = Col) then
          begin
            Include(CellState, gdCurrent);
            Include(CellState, gdSelected);
          end;
          if (CurCol = FHotTrackCell.X) and (CurRow = FHotTrackCell.Y) then
            Include(CellState, gdHotTrack);
          if ControlFocused and (gdCurrent in CellState) then
            Include(CellState, gdFocused);
          if (goRowSelectEh in Options) and (CurRow = Row) then
            Include(CellState, gdRowSelected);
          if PointInGridRect(CurCol, CurRow, Sel) then
            Include(CellState, gdSelected);
          DrawCellArea(CurCol, CurRow, Where, CellState);
        end;
        Where.Left := Where.Right;
        Inc(CurCol);
      end;
      Where.Top := Where.Bottom;
      Inc(CurRow);
    end;
  end;

  procedure DrawContraBorder(CellBorder: TGridCellBorderTypeEh; ContraPoint: Boolean;
    ACol, ARow, StopCell: Integer;
    StartX, StartY, StopPos: Integer);
  var
    IsDraw: Boolean;
    BorderColor: TColor;
    IsExtent: Boolean;
    i: Integer;
    Where: TRect;
  begin
    if ContraPoint then
    begin
      CheckDrawCellBorder(ACol, ACol, CellBorder, IsDraw, BorderColor, IsExtent);
      if IsDraw then
      begin
        Canvas.Pen.Color := BorderColor;
        DrawPolyline([Point(StartX, StartY), Point(StartX+1, StartY)]);
      end;
    end else if CellBorder = cbtLeftEh then
    begin
      Where.Top := StartY;
      Where.Left := StartX;
      Where.Right := StartX;
      for i := ARow to StopCell-1 do
      begin
        Where.Bottom := Where.Top + RowHeights[i];
        if Where.Top >= StopPos then
          Exit;
        CheckDrawCellBorder(ACol, i, CellBorder, IsDraw, BorderColor, IsExtent);
        if IsDraw then
        begin
          Canvas.Pen.Color := BorderColor;
          DrawPolyline([Point(Where.Left, Where.Top), Point(Where.Left, Where.Bottom)]);
        end;
        Where.Top := Where.Bottom;
      end;
    end else if CellBorder = cbtTopEh then
    begin
      Where.Left := StartX;
      Where.Top := StartY;
      Where.Bottom := StartY;
      for i := ACol to StopCell-1 do
      begin
        Where.Right := Where.Left + ColWidths[i];
        if Where.Left >= StopPos then
          Exit;
        CheckDrawCellBorder(i, ARow, CellBorder, IsDraw, BorderColor, IsExtent);
        if IsDraw then
        begin
          Canvas.Pen.Color := BorderColor;
          DrawPolyline([Point(Where.Left, Where.Top), Point(Where.Right, Where.Top)]);
        end;
        Where.Left := Where.Right;
      end;
    end;
  end;

begin
  if PaintLocked then Exit;
  if UseRightToLeftAlignment then ChangeGridOrientation(True);

  Sel := Selection;
  if not RolSizeValid then
    ValidateRolSize;

  SetInternalColors;

  if FBackgroundData.Showing then
    FBackgroundData.PaintBackgroundData;

  DrawOutBoundaryData;

// Fixed Top-left area
  DrawCells(0, 0,
    ColCount, RowCount,
    HorzAxis.GridClientStart, VertAxis.GridClientStart,
    HorzAxis.FixedBoundary, VertAxis.FixedBoundary,
    [gdFixed]);

// Fixed top area
  RestRect := Rect(HorzAxis.FixedBoundary, 0, HorzAxis.ContraStart, VertAxis.ContraStart);
  if UseRightToLeftAlignment then
  begin
    RestRect.Left := HorzAxis.RightToLeftReflect(RestRect.Left);
    RestRect.Right := HorzAxis.RightToLeftReflect(RestRect.Right);
  end;
  RestRgn := SelectClipRectangleEh(Canvas, RestRect);

  DrawCells(FixedColCount + HorzAxis.RolStartVisCel, 0,
    ColCount, RowCount,
    HorzAxis.FixedBoundary - HorzAxis.RolStartVisCelOfst, VertAxis.GridClientStart,
    HorzAxis.ContraStart, VertAxis.FixedBoundary,
    [gdFixed]);

  RestoreClipRectangleEh(Canvas, RestRgn);

// Fixed left area
  RestRect := Rect(0, VertAxis.FixedBoundary, HorzAxis.ContraStart, VertAxis.ContraStart);
  if UseRightToLeftAlignment then
  begin
    RestRect.Left := HorzAxis.RightToLeftReflect(RestRect.Left);
    RestRect.Right := HorzAxis.RightToLeftReflect(RestRect.Right);
  end;
  RestRgn := SelectClipRectangleEh(Canvas, RestRect);

  DrawCells(0, FixedRowCount + VertAxis.RolStartVisCel,
    ColCount, RowCount,
    HorzAxis.GridClientStart, VertAxis.FixedBoundary - VertAxis.RolStartVisCelOfst,
    HorzAxis.FixedBoundary, VertAxis.ContraStart,
    [gdFixed]);

  RestoreClipRectangleEh(Canvas, RestRgn);

// Scrol Area

  RestRect := Rect(HorzAxis.FixedBoundary, VertAxis.FixedBoundary,
                   HorzAxis.ContraStart, VertAxis.ContraStart);
  if UseRightToLeftAlignment then
  begin
    RestRect.Left := HorzAxis.RightToLeftReflect(RestRect.Left);
    RestRect.Right := HorzAxis.RightToLeftReflect(RestRect.Right);
  end;
  RestRgn := SelectClipRectangleEh(Canvas, RestRect);

  DrawCells(
    FixedColCount + HorzAxis.RolStartVisCel, FixedRowCount + VertAxis.RolStartVisCel,
    ColCount, RowCount,
    HorzAxis.FixedBoundary - HorzAxis.RolStartVisCelOfst, VertAxis.FixedBoundary - VertAxis.RolStartVisCelOfst,
    HorzAxis.ContraStart, VertAxis.ContraStart,
    []);

  RestoreClipRectangleEh(Canvas, RestRgn);

// ContraColCount

  HorzAxisContraBoundary := HorzAxis.ContraStart;
  if ContraColCount > 0 then
  begin

    if goContraVertBoundaryLineEh in Options then
      Inc(HorzAxisContraBoundary);

    if goContraVertBoundaryLineEh in Options then
    begin
      DrawContraBorder(cbtLeftEh, False,
        ColCount, 0, ColCount,
        HorzAxis.ContraStart,
        VertAxis.GridClientStart, VertAxis.FixedBoundary);
    end;

  // Contra Area Right // Fixed top

    DrawCells(
      ColCount, 0,
      FullColCount, RowCount,
      HorzAxisContraBoundary, VertAxis.GridClientStart,
      HorzAxis.GridClientStop, VertAxis.FixedBoundary,
      [gdFixed]);

  // Contra Area Right // Scoll

    RestRect := Rect(HorzAxis.ContraStart, VertAxis.FixedBoundary,
                     HorzAxis.GridClientStop, VertAxis.ContraStart);
    if UseRightToLeftAlignment then
    begin
      RestRect.Left := HorzAxis.RightToLeftReflect(RestRect.Left);
      RestRect.Right := HorzAxis.RightToLeftReflect(RestRect.Right);
    end;
    RestRgn := SelectClipRectangleEh(Canvas, RestRect);

    if goContraVertBoundaryLineEh in Options then
    begin
      DrawContraBorder(cbtLeftEh, False,
        ColCount, FixedRowCount + VertAxis.RolStartVisCel, RowCount,
        HorzAxis.ContraStart,
        VertAxis.FixedBoundary - VertAxis.RolStartVisCelOfst, VertAxis.ContraStart);
    end;

    DrawCells(
      ColCount, FixedRowCount + VertAxis.RolStartVisCel,
      FullColCount, RowCount,
      HorzAxisContraBoundary, VertAxis.FixedBoundary - VertAxis.RolStartVisCelOfst,
      HorzAxis.GridClientStop, VertAxis.ContraStart,
      [gdFixed]);

    RestoreClipRectangleEh(Canvas, RestRgn);

  end;

// ContraRowCount

  VertAxisContraBoundary := VertAxis.ContraStart;
  if ContraRowCount > 0 then
  begin
  // Contra Area Bottom Fixed Left

    if goContraHorzBoundaryLineEh in Options then
      Inc(VertAxisContraBoundary);

    if goContraHorzBoundaryLineEh in Options then
    begin
      DrawContraBorder(cbtTopEh, False,
        0, RowCount, ColCount,
        HorzAxis.GridClientStart,
        VertAxis.ContraStart, HorzAxis.FixedBoundary);
    end;

    DrawCells(0, RowCount,
      ColCount, FullRowCount,
      HorzAxis.GridClientStart, VertAxisContraBoundary,
      HorzAxis.FixedBoundary, VertAxis.GridClientStop,
      [gdFixed]);

  // Contra Area Bottom Scroll Left

    RestRect := Rect(HorzAxis.FixedBoundary, VertAxis.ContraStart,
                     HorzAxis.ContraStart, VertAxis.GridClientStop);
    if UseRightToLeftAlignment then
    begin
      RestRect.Left := HorzAxis.RightToLeftReflect(RestRect.Left);
      RestRect.Right := HorzAxis.RightToLeftReflect(RestRect.Right);
    end;
    RestRgn := SelectClipRectangleEh(Canvas, RestRect);

    if goContraHorzBoundaryLineEh in Options then
    begin
      DrawContraBorder(cbtTopEh, False,
        FixedColCount + HorzAxis.RolStartVisCel, RowCount, ColCount,
        HorzAxis.FixedBoundary - HorzAxis.RolStartVisCelOfst,
        VertAxis.ContraStart, HorzAxis.ContraStart);
    end;

    DrawCells(
      FixedColCount + HorzAxis.RolStartVisCel, RowCount,
      ColCount, FullRowCount,
      HorzAxis.FixedBoundary - HorzAxis.RolStartVisCelOfst, VertAxisContraBoundary,
      HorzAxis.ContraStart, VertAxis.GridClientStop,
      [gdFixed]);

    RestoreClipRectangleEh(Canvas, RestRgn);
  end;

// Contra Bottom-Right

  if (ContraRowCount > 0) and (ContraColCount > 0) then
  begin

    if goContraVertBoundaryLineEh in Options then
    begin
      DrawContraBorder(cbtLeftEh, False,
        ColCount, RowCount, FullRowCount,
        HorzAxis.ContraStart,
        VertAxisContraBoundary, VertAxis.GridClientStop);
    end;

    if goContraHorzBoundaryLineEh in Options then
    begin
      DrawContraBorder(cbtTopEh, False,
        ColCount, RowCount, FullColCount,
        HorzAxisContraBoundary,
        VertAxis.ContraStart, HorzAxis.GridClientStop);
    end;

    if (goContraVertBoundaryLineEh in Options) and (goContraHorzBoundaryLineEh in Options) then
    begin
      DrawContraBorder(cbtTopEh, True,
        ColCount, RowCount, FullColCount,
        HorzAxis.ContraStart,
        VertAxis.ContraStart, HorzAxis.ContraStart+1);
    end;

    DrawCells(ColCount, RowCount,
      FullColCount, FullRowCount,
      HorzAxisContraBoundary, VertAxisContraBoundary,
      HorzAxis.GridClientStop, VertAxis.GridClientStop,
      [gdFixed]);
  end;

// Empty Area Left + NO + Bottom for Contra

  if HorzAxis.RolInClientBoundary < HorzAxis.ContraStart then
  begin
    if FixedRowCount > 0 then
    begin
      ACellRect.Left := HorzAxis.RolInClientBoundary;
//      ACellRect.Top := 0;
      ACellRect.Right := HorzAxis.ContraStart;
      ACellRect.Bottom := VertAxis.GridClientStart;

      for RowI := 0 to FixedRowCount - 1 do
      begin
        ACellRect.Top := ACellRect.Bottom;
        ACellRect.Bottom := ACellRect.Top + RowHeights[RowI];
        DrawEmptyAreaCell(-1, RowI, ACellRect);
//        OffsetRect(ACellRect, 0,  RowHeights[RowI]);
      end;
    end;

    ACellRect.Left := HorzAxis.RolInClientBoundary;
    ACellRect.Bottom := VertAxis.FixedBoundary - VertAxis.RolStartVisCelOfst;
    ACellRect.Right := HorzAxis.ContraStart;
//    ACellRect.Bottom := ACellRect.Top + VertAxis.RolCelLens[VertAxis.RolStartVisCel] - 1 ;

    for RowI := FixedRowCount+VertAxis.RolStartVisCel to RowCount - 1 do
    begin
      ACellRect.Top := ACellRect.Bottom;
      ACellRect.Bottom := ACellRect.Top + RowHeights[RowI];
      if ACellRect.Top > VertAxis.ContraStart then
        Break;
      DrawEmptyAreaCell(-1, RowI, ACellRect);
//      OffsetRect(ACellRect, 0,  RowHeights[RowI]);
    end;

    ACellRect.Left := HorzAxis.RolInClientBoundary;
    ACellRect.Top := VertAxis.RolInClientBoundary;
    ACellRect.Right := HorzAxis.ContraStart;
    ACellRect.Bottom := VertAxis.ContraStart;
    DrawEmptyAreaCell(-1, -1, ACellRect);

    ACellRect.Left := HorzAxis.RolInClientBoundary;
    ACellRect.Bottom := VertAxis.ContraStart;
    ACellRect.Right := HorzAxis.ContraStart;
    for RowI := RowCount to FullRowCount - 1 do
    begin
      ACellRect.Top := ACellRect.Bottom;
      ACellRect.Bottom := ACellRect.Top + RowHeights[RowI];
      if (RowI = RowCount) and (goContraHorzBoundaryLineEh in Options) then
        Inc(ACellRect.Bottom);
      DrawEmptyAreaCell(-1, RowI, ACellRect);
//      OffsetRect(ACellRect, 0,  RowHeights[RowI]);
    end;

  end;

// Empty Area Bottom

  if VertAxis.RolInClientBoundary < VertAxis.ContraStart then
  begin
    if FixedColCount > 0 then
    begin
//      ACellRect.Left := 0;
      ACellRect.Top := VertAxis.RolInClientBoundary;
      ACellRect.Right := HorzAxis.GridClientStart;
      ACellRect.Bottom := VertAxis.ContraStart;

      for ColI := 0 to FixedColCount - 1 do
      begin
        ACellRect.Left := ACellRect.Right;
        ACellRect.Right := ACellRect.Left + ColWidths[ColI];
        DrawEmptyAreaCell(ColI, -1, ACellRect);
//        OffsetRect(ACellRect, ColWidths[ColI], 0);
      end;
    end;

    RestRect := Rect(HorzAxis.FixedBoundary, VertAxis.GridClientStart,
                     HorzAxis.ContraStart, VertAxis.GridClientStop);
    if UseRightToLeftAlignment then
    begin
      RestRect.Left := HorzAxis.RightToLeftReflect(RestRect.Left);
      RestRect.Right := HorzAxis.RightToLeftReflect(RestRect.Right);
    end;
    RestRgn := SelectClipRectangleEh(Canvas, RestRect);
//    ACellRect.Left := HorzAxis.RolBoundSt - HorzAxis.RolStartVisCelOfst;
    ACellRect.Top := VertAxis.RolInClientBoundary;
    ACellRect.Right := HorzAxis.FixedBoundary - HorzAxis.RolStartVisCelOfst;
    ACellRect.Bottom := VertAxis.ContraStart;

    for ColI := HorzAxis.StartVisCel to ColCount - 1 do
    begin
      ACellRect.Left := ACellRect.Right;
      ACellRect.Right := ACellRect.Left + ColWidths[ColI];
      if ACellRect.Left > HorzAxis.ContraStart then
        Break;
      DrawEmptyAreaCell(ColI, -1, ACellRect);
//      OffsetRect(ACellRect, ColWidths[ColI], 0);
    end;
    RestoreClipRectangleEh(Canvas, RestRgn);

    ACellRect.Top := VertAxis.RolInClientBoundary;
    ACellRect.Right := HorzAxis.ContraStart;
    ACellRect.Bottom := VertAxis.ContraStart;
    for ColI := ColCount to FullColCount - 1 do
    begin
      ACellRect.Left := ACellRect.Right;
      ACellRect.Right := ACellRect.Left + ColWidths[ColI];
      if (ColI = ColCount) and (goContraVertBoundaryLineEh in Options) then
        Inc(ACellRect.Right);
      DrawEmptyAreaCell(ColI, -1, ACellRect);
    end;

  end;

  if UseRightToLeftAlignment then ChangeGridOrientation(False);
end;

function TCustomGridEh.CheckCellLine(ACol, ARow: Longint; BorderType: TGridCellBorderTypeEh): Boolean;
var
  IsDraw: Boolean;
  BorderColor: TColor;
  IsExtent: Boolean;
begin
{  if IsVert
    then BorderType := cbtRightEh
    else BorderType := cbtBottomEh;}
  BorderColor := 0;
  IsExtent := False;
  CheckDrawCellBorder(ACol, ARow, BorderType, IsDraw, BorderColor, IsExtent);
  Result := IsDraw;
end;

procedure TCustomGridEh.DrawOutBoundaryData;
var
  DrawRect: TRect;
begin
  if OutBoundaryData.GetOutBoundaryRect(DrawRect, cbtTopEh) then
    DrawTopOutBoundaryData(DrawRect);
  if OutBoundaryData.GetOutBoundaryRect(DrawRect, cbtLeftEh) then
    DrawLeftOutBoundaryData(DrawRect);
  if OutBoundaryData.GetOutBoundaryRect(DrawRect, cbtBottomEh) then
    DrawBottomOutBoundaryData(DrawRect);
  if OutBoundaryData.GetOutBoundaryRect(DrawRect, cbtRightEh) then
    DrawRightOutBoundaryData(DrawRect);
end;

procedure TCustomGridEh.DrawTopOutBoundaryData(ARect: TRect);
begin
  Canvas.Brush.Color := FixedColor;
  Canvas.FillRect(ARect);
end;

procedure TCustomGridEh.DrawLeftOutBoundaryData(ARect: TRect);
begin
  Canvas.Brush.Color := FixedColor;
  Canvas.FillRect(ARect);
end;

procedure TCustomGridEh.DrawBottomOutBoundaryData(ARect: TRect);
begin
  Canvas.Brush.Color := FixedColor;
  Canvas.FillRect(ARect);
end;

procedure TCustomGridEh.DrawRightOutBoundaryData(ARect: TRect);
begin
  Canvas.Brush.Color := FixedColor;
  Canvas.FillRect(ARect);
end;

function TCustomGridEh.CalcCoordFromPoint(X, Y: Integer): TGridCoord;
//var
//  XWinPos: Integer;

  procedure CalcXAxis;
  var
    i: Integer;
    Pos: Integer;
  begin
//    if UseRightToLeftAlignment then
    //    Result.X := DoCalc(DrawInfo.Horz, X)
//    else
    begin
      if X < HorzAxis.GridClientStart then
        Result.X := -1
      else if X < HorzAxis.FixedBoundary then
      begin
        Pos := HorzAxis.GridClientStart;
        for i := 0 to FixedColCount-1 do
          if Pos + ColWidths[i] > X then
          begin
            Result.X := i;
            Exit;
          end else
            Pos := Pos + ColWidths[i];
      end else if X <= HorzAxis.ContraStart then
      begin
        Pos := HorzAxis.FixedBoundary - HorzAxis.RolStartVisCelOfst;
        for i := HorzAxis.RolStartVisCel + FixedColCount to ColCount-1 do
          if Pos + ColWidths[i] > X then
          begin
            Result.X := i;
            Exit;
          end else
            Pos := Pos + ColWidths[i];
      end else if X < HorzAxis.GridClientStop then
      begin
        Pos := HorzAxis.ContraStart;
        for i := ColCount to FullColCount-1 do
          if Pos + ColWidths[i] > X then
          begin
            Result.X := i;
            Exit;
          end else
            Pos := Pos + ColWidths[i];
      end;

    end;
  end;

  procedure CalcYAxis;
  var
    i: Integer;
    Pos: Integer;
  begin
    if Y < VertAxis.GridClientStart then
      Result.Y := -1
    else if Y < VertAxis.FixedBoundary then
    begin
      Pos := VertAxis.GridClientStart;
      for i := 0 to FixedRowCount-1 do
        if Pos + RowHeights[i] > Y then
        begin
          Result.Y := i;
          Exit;
        end else
          Pos := Pos + RowHeights[i];
    end else if Y < VertAxis.ContraStart then
    begin
      Pos := VertAxis.FixedBoundary - VertAxis.RolStartVisCelOfst;
      for i := VertAxis.RolStartVisCel + FixedRowCount to RowCount-1 do
        if Pos + RowHeights[i] > Y then
        begin
          Result.Y := i;
          Exit;
        end else
          Pos := Pos + RowHeights[i];
    end else if Y < VertAxis.GridClientStop  then
    begin
      Pos := VertAxis.ContraStart;
      for i := RowCount to FullRowCount-1 do
        if Pos + RowHeights[i] > Y then
        begin
          Result.Y := i;
          Exit;
        end else
          Pos := Pos + RowHeights[i];
    end;
  end;

begin
  Result.X := -1;
  Result.Y := -1;
  if UseRightToLeftAlignment then
    X := HorzAxis.RightToLeftReflect(X);
  CalcXAxis;
  CalcYAxis;
end;

procedure TCustomGridEh.CalcSizingState(X, Y: Integer;
  var State: TGridStateEh; var Index: Longint; var SizingPos, SizingOfs: Integer);

  procedure CalcAxisState(Axis: TGridAxisDataEh; Pos: Integer;
    NewState: TGridStateEh; SizingAreaSize: Integer; FixedCellSizingAllowed: Boolean);
  var
    I, Line, Back, Range: Integer;
    LeftSizingBound: Integer;
    LeftSizingCell: Integer;
  begin
    if (NewState = gsColSizingEh) and UseRightToLeftAlignment then
      Pos := ClientWidth - Pos;

    Range := 0;
    Back := 0;
    if Range < SizingAreaSize then
    begin
      Range := SizingAreaSize;
      Back := Range shr 1;
    end;

    if FixedCellSizingAllowed then
    begin
      LeftSizingBound := Axis.GridClientStart;
      LeftSizingCell := 0;
    end else
    begin
      LeftSizingBound := Axis.FixedBoundary - Axis.FrozenLen;
      LeftSizingCell := Axis.FixedCelCount - Axis.FrozenCelCount;
    end;

    Line := LeftSizingBound;
    for I := LeftSizingCell to Axis.FixedCelCount - 1 do
    begin
      Inc(Line, Axis.CelLens[I]);
      if Line >= Axis.GridClientStop then Break;
      if (Pos >= Line - Back) and (Pos <= Line - Back + Range) then
      begin
        State := NewState;
        SizingPos := Line;
        SizingOfs := Line - Pos;
        Index := I;
        Exit;
      end;
//      Inc(Line, EffectiveLineWidth);
    end;

    //Data
    Line := Axis.FixedBoundary - Axis.RolStartVisCelOfst;
    for I := Axis.RolStartVisCel + Axis.FixedCelCount to Axis.CelCount - 1 do
    begin
      Inc(Line, Axis.CelLens[I]);
      if Line >= Axis.ContraStart then Break;
      if (Pos >= Line - Back) and (Pos <= Line - Back + Range) then
      begin
        State := NewState;
        SizingPos := Line;
        SizingOfs := Line - Pos;
        Index := I;
        Exit;
      end;
//      Inc(Line, EffectiveLineWidth);
    end;
    if (Axis.ContraStart = Axis.RolInClientBoundary) and (Pos >= Axis.RolInClientBoundary - Back)
      and (Pos <= Axis.RolInClientBoundary) then
    begin
      State := NewState;
      SizingPos := Axis.RolInClientBoundary;
      SizingOfs := Axis.RolInClientBoundary - Pos;
      if Axis.FixedBoundary > Axis.ContraStart
        then Index := Axis.RolLastVisCel + Axis.FixedCelCount
        else Index := Axis.RolLastVisCel + Axis.FixedCelCount;
      Exit;
    end;

    //Contra
    if (Axis.ContraCelCount > 0) and (Pos >= Axis.ContraStart)
      and (Pos <= Axis.ContraStart + Back) then
    begin
      State := NewState;
      SizingPos := Axis.ContraStart;
      SizingOfs := Axis.ContraStart - Pos;
      Index := Axis.CelCount;
      Exit;
    end;

    Line := Axis.ContraStart;
    for I := Axis.CelCount to Axis.CelCount + Axis.ContraCelCount - 2 do
    begin
      Inc(Line, Axis.CelLens[I]);
      if Line >= Axis.GridClientStop then Break;
      if (Pos >= Line - Back) and (Pos <= Line - Back + Range) then
      begin
        State := NewState;
        SizingPos := Line;
        SizingOfs := Line - Pos;
        Index := I + 1;
        Exit;
      end;
//      Inc(Line, EffectiveLineWidth);
    end;
  end;

  function XOutsideHorzFixedBoundary: Boolean;
  var
    LeftSizingBound: Integer;
  begin
    if FixedColsSizingAllowed
      then LeftSizingBound := HorzAxis.GridClientStart
      else LeftSizingBound := HorzAxis.FixedBoundary - HorzAxis.FrozenLen;
    if not UseRightToLeftAlignment then
      Result := X > LeftSizingBound
    else
      Result := X < ClientWidth - LeftSizingBound; //FixedBoundary;
  end;

  function XOutsideOrEqualHorzFixedBoundary: Boolean;
  begin
    if not UseRightToLeftAlignment then
      Result := X >= HorzAxis.FixedBoundary - HorzAxis.FrozenLen // FixedBoundary
    else
      Result := X <= ClientWidth - (HorzAxis.FixedBoundary - HorzAxis.FrozenLen); // FixedBoundary;
  end;

var
  EffectiveOptions: TGridOptionsEh;
begin
  State := gsNormalEh;
  Index := -1;
  EffectiveOptions := Options;
  if csDesigning in ComponentState then
    EffectiveOptions := EffectiveOptions + FDesignOptionsBoost;
  if [goColSizingEh, goRowSizingEh] * EffectiveOptions <> [] then
  begin
//      Vert.GridExtent := ClientHeight;     //? Why need this line.
//      Horz.GridExtent := ClientWidth;      //? Why need this line.
    if (XOutsideHorzFixedBoundary) and (goColSizingEh in EffectiveOptions) then
    begin
      if (Y >= VertAxis.FixedBoundary - VertAxis.FrozenLen) or (Y < VertAxis.GridClientStart) then Exit;
      CalcAxisState(HorzAxis, X, gsColSizingEh, 7, FixedColsSizingAllowed);
    end
    else if (Y > VertAxis.FixedBoundary - VertAxis.FrozenLen) and (goRowSizingEh in EffectiveOptions) then
    begin
      if XOutsideOrEqualHorzFixedBoundary then Exit;
      CalcAxisState(VertAxis, Y, gsRowSizingEh, 5, FixedRowsSizingAllowed);
    end;
  end;
end;

function TCustomGridEh.FixedColsSizingAllowed: Boolean;
begin
  Result := False;
end;

function TCustomGridEh.FixedRowsSizingAllowed: Boolean;
begin
  Result := False;
end;

procedure TCustomGridEh.ChangeGridOrientation(RightToLeftOrientation: Boolean);
var
  Org: TPoint;
  Ext: TPoint;
begin
  if RightToLeftOrientation then
  begin
    Org := Point(ClientWidth,0);
    Ext := Point(-1,1);
    SetMapMode(Canvas.Handle, mm_Anisotropic);
    SetWindowOrgEx(Canvas.Handle, Org.X, Org.Y, nil);
    SetViewportExtEx(Canvas.Handle, ClientWidth, ClientHeight, nil);
    SetWindowExtEx(Canvas.Handle, Ext.X*ClientWidth, Ext.Y*ClientHeight, nil);
    FCanvasRightToLeftReflected := True;
  end
  else
  begin
    Org := Point(0,0);
    Ext := Point(1,1);
    SetMapMode(Canvas.Handle, mm_Anisotropic);
    SetWindowOrgEx(Canvas.Handle, Org.X, Org.Y, nil);
    SetViewportExtEx(Canvas.Handle, ClientWidth, ClientHeight, nil);
    SetWindowExtEx(Canvas.Handle, Ext.X*ClientWidth, Ext.Y*ClientHeight, nil);
    FCanvasRightToLeftReflected := False;
  end;
end;

function TCustomGridEh.CheckStartTmpCancelCanvasRTLReflecting(var ADrawRect: TRect): Boolean;
var
  OldRigth: Integer;
begin
  if CanvasRightToLeftReflected then
  begin
    OldRigth := ADrawRect.Right;
    ADrawRect.Right := ClientWidth - ADrawRect.Left;
    ADrawRect.Left := ClientWidth - OldRigth;

    ChangeGridOrientation(False);
    Result := True;
  end else
    Result := False;
end;

procedure TCustomGridEh.StopTmpCancelCanvasRTLReflecting;
begin
  ChangeGridOrientation(True);
end;

procedure TCustomGridEh.DrawText(ACanvas: TCanvas; ARect: TRect;
  FillRect: Boolean; DX, DY: Integer; const Text: string; Alignment: TAlignment;
  Layout: TTextLayout; MultyL: Boolean;
  EndEllipsis: Boolean; LeftMarg, RightMarg: Integer; ForceSingleLine: Boolean;
  UseRightToLeftAlignment: Boolean);
var
  CancelReflectingStarted: Boolean;
begin
  CancelReflectingStarted := CheckStartTmpCancelCanvasRTLReflecting(ARect);
  WriteTextEh(Canvas, ARect, FillRect, DX, DY, Text, Alignment, Layout,
    MultyL, EndEllipsis, LeftMarg, RightMarg, UseRightToLeftAlignment, ForceSingleLine);
  if CancelReflectingStarted then
    ChangeGridOrientation(True);
end;

{ Will move TopLeft so that Coord is in view }
procedure TCustomGridEh.ClampInView(const Coord: TGridCoord; CheckX, CheckY: Boolean);
var
//  DrawInfo: TGridDrawInfoEh;
{  MaxTopLeft: TGridCoordEh;
  OldTopLeft: TGridCoordEh;
  OldDataOffset: TSize;
  LastPartialVisibleSize: TSize;}
  NewRolStartPos: TPoint;
  LocCol, LocRow: Integer;
  RolBoundWidth, RolBoundHeight: Integer;
  NewCel, NewPosInCell: Integer;
begin
  if not HandleAllocated then Exit;
  NewRolStartPos := Point(RolStartVisPosX, RolStartVisPosY);

  if CheckX and (Coord.X >= FixedColCount) and (Coord.X < ColCount) then
  begin
    LocCol := Coord.X - FixedColCount;
    RolBoundWidth := HorzAxis.ContraStart - HorzAxis.FixedBoundary;
    if HorzAxis.RolLocCelPosArr[LocCol] < RolStartVisPosX then
      NewRolStartPos.X := HorzAxis.RolLocCelPosArr[LocCol]
    else if HorzAxis.RolLocCelPosArr[LocCol] + HorzAxis.RolCelLens[LocCol] > RolStartVisPosX + RolBoundWidth then
    begin
      NewRolStartPos.X := (HorzAxis.RolLocCelPosArr[LocCol] + HorzAxis.RolCelLens[LocCol]) - RolBoundWidth;
      if HorzAxis.RolLocCelPosArr[LocCol] < NewRolStartPos.X then
        NewRolStartPos.X := HorzAxis.RolLocCelPosArr[LocCol];
    end;
  end;

  if CheckY and (Coord.Y >= FixedRowCount) and (Coord.Y < RowCount) then
  begin
    LocRow := Coord.Y - FixedRowCount;
    RolBoundHeight := VertAxis.ContraStart - VertAxis.FixedBoundary;
    if VertAxis.RolLocCelPosArr[LocRow] < RolStartVisPosY then
      NewRolStartPos.Y := VertAxis.RolLocCelPosArr[LocRow]
    else if VertAxis.RolLocCelPosArr[LocRow] + VertAxis.RolCelLens[LocRow] > RolStartVisPosY + RolBoundHeight then
    begin
      NewRolStartPos.Y := (VertAxis.RolLocCelPosArr[LocRow] + VertAxis.RolCelLens[LocRow]) - RolBoundHeight;
      if VertAxis.RolLocCelPosArr[LocRow] < NewRolStartPos.Y then
        NewRolStartPos.Y := VertAxis.RolLocCelPosArr[LocRow];
    end;
  end;

  if IsSmoothHorzScroll then
    RolStartVisPosX := NewRolStartPos.X
  else
  begin
    HorzAxis.RolCellAtPos(NewRolStartPos.X, NewCel, NewPosInCell);
    RolStartVisPosX := NewRolStartPos.X - NewPosInCell;
  end;

  if IsSmoothVertScroll then
    RolStartVisPosY := NewRolStartPos.Y
  else
  begin
    VertAxis.RolCellAtPos(NewRolStartPos.Y, NewCel, NewPosInCell);
    if NewPosInCell = 0 then
      RolStartVisPosY := NewRolStartPos.Y
    else
      RolStartVisPosY := NewRolStartPos.Y - NewPosInCell + VertAxis.RolCelLens[NewCel];
  end;

end;

procedure TCustomGridEh.GetDrawSizingLineBound(var StartPos, FinishPos: Integer);
begin
  if FGridState = gsRowSizingEh then
    if UseRightToLeftAlignment then
    begin
      StartPos := HorzAxis.GridClientStop;
      FinishPos := HorzAxis.GridClientStop - HorzAxis.GridClientStop;
    end else
    begin
      StartPos := HorzAxis.GridClientStart;
      FinishPos := HorzAxis.GridClientStop;
    end
  else
  begin
    StartPos := VertAxis.GridClientStart;
    if goExtendVertLinesEh in Options
      then FinishPos := VertAxis.GridClientStop
      else FinishPos := VertAxis.GridClientStop;
  end;
end;

procedure TCustomGridEh.DrawSizingLine;
var
  OldPen: TPen;
  StartPos, FinishPos: Integer;
begin
  OldPen := TPen.Create;
  try
    OldPen.Assign(Canvas.Pen);
//      Pen.Style := psDot;
    Canvas.Pen.Color := clWindow;
    Canvas.Pen.Mode := pmXor;
    Canvas.Pen.Width := 1;
    try
      GetDrawSizingLineBound(StartPos, FinishPos);
      if FGridState = gsRowSizingEh then
      begin
        Canvas.MoveTo(StartPos, FSizingPos);
        Canvas.LineTo(FinishPos, FSizingPos);
      end
      else
      begin
        Canvas.MoveTo(FSizingPos, StartPos);
        Canvas.LineTo(FSizingPos, FinishPos);
     end;
    finally
      Canvas.Pen := OldPen;
    end;
  finally
    OldPen.Free;
  end;
end;

procedure TCustomGridEh.DrawMove;
var
  OldPen: TPen;
  Pos: Integer;
  R: TRect;
  MoveSize: Integer;
begin
  OldPen := TPen.Create;
  try
    with Canvas do
    begin
      OldPen.Assign(Pen);
      try
        if FGridState = gsRowMovingEh then
        begin
          Pen.Style := psDot;
          Pen.Mode := pmXor;
          Pen.Width := 5;
          Pen.Color := clWhite;

          R := CellRect(0, FMovePos);
          if FMovePos > FMoveIndex then
            Pos := R.Bottom else
            Pos := R.Top;
//          MoveTo(0, Pos);
//          LineTo(ClientWidth, Pos);
          MoveSize := HorzAxis.GridClientLen;

          if GetMoveLineEh.Visible then
            GetMoveLineEh.MoveToFor(Self, Point(HorzAxis.GridClientStart, Pos))
          else
            GetMoveLineEh.StartShow(Self,
                                    Point(HorzAxis.GridClientStart, Pos),
                                    False,
                                    MoveSize, Self);
        end
        else // gsColMovingEh
        begin
          R := CellRect(FMovePos, 0);
          if {FMovePos > FMoveIndex}FMovePosRightSite then
            if not UseRightToLeftAlignment then
              Pos := R.Right
            else
              Pos := R.Left
          else
            if not UseRightToLeftAlignment then
              Pos := R.Left-1
            else
              Pos := R.Right;
//          MoveTo(Pos, 0);
//          LineTo(Pos, ClientHeight);
          if goExtendVertLinesEh in Options
            then MoveSize := VertAxis.RolInClientBoundary - VertAxis.GridClientStart
            else MoveSize := VertAxis.GridClientLen;
          if GetMoveLineEh.Visible then
            GetMoveLineEh.MoveToFor(Self, Point(Pos, VertAxis.GridClientStart))
          else
            GetMoveLineEh.StartShow(Self,
                                    Point(Pos, VertAxis.GridClientStart),
                                    True,
                                    MoveSize, Self);
        end;
      finally
        Canvas.Pen := OldPen;
      end;
    end;
  finally
    OldPen.Free;
  end;
end;

procedure TCustomGridEh.HideMove;
begin
  GetMoveLineEh.Hide;
end;

procedure TCustomGridEh.FocusCell(ACol, ARow: Longint; MoveAnchor: Boolean);
begin
  MoveCurrent(ACol, ARow, True, True);
  UpdateEdit;
  Click;
end;

procedure TCustomGridEh.GridRectToScreenRect(GridRect: TGridRect;
 var ScreenRect: TRect; CutOutbounds: Boolean = True);
var
  LocCol, LocRow: Integer;
begin
  ScreenRect := EmptyRect;
  if (GridRect.Left > GridRect.Right) or (GridRect.Top > GridRect.Bottom) then
    Exit;

// Left
  if GridRect.Left < FixedColCount then
    ScreenRect.Left := HorzAxis.GridClientStart + CalcColRangeWidth(0, GridRect.Left)
  else if GridRect.Left < ColCount then
  begin
    LocCol := GridRect.Left - FixedColCount;
    ScreenRect.Left := HorzAxis.RolLocCelPosArr[LocCol] - RolStartVisPosX;
    if CutOutbounds and (ScreenRect.Left < 0)
      then ScreenRect.Left := HorzAxis.FixedBoundary
      else ScreenRect.Left := ScreenRect.Left + HorzAxis.FixedBoundary;
  end else
    ScreenRect.Left := HorzAxis.ContraStart + CalcColRangeWidth(ColCount, GridRect.Left - ColCount);

// Top
  if GridRect.Top < FixedRowCount then
    ScreenRect.Top := VertAxis.GridClientStart + CalcRowRangeHeight(0, GridRect.Top)
  else if GridRect.Top < RowCount then
  begin
    LocRow := GridRect.Top - FixedRowCount;
    ScreenRect.Top := VertAxis.RolLocCelPosArr[LocRow] - RolStartVisPosY;
    if CutOutbounds  and (ScreenRect.Top < 0)
      then ScreenRect.Top := VertAxis.FixedBoundary
      else ScreenRect.Top := ScreenRect.Top + VertAxis.FixedBoundary;
  end else
    ScreenRect.Top := VertAxis.ContraStart + CalcRowRangeHeight(RowCount, GridRect.Top - RowCount);

// Right
  if GridRect.Right < FixedColCount then
  begin
    ScreenRect.Right := HorzAxis.GridClientStart + CalcColRangeWidth(0, GridRect.Right + 1);
    if ScreenRect.Right > HorzAxis.ContraStart then
      ScreenRect.Right := HorzAxis.ContraStart;
  end else if GridRect.Right < ColCount then
  begin
    LocCol := GridRect.Right - FixedColCount;
    ScreenRect.Right :=
      HorzAxis.RolLocCelPosArr[LocCol] + HorzAxis.RolCelLens[LocCol] - RolStartVisPosX;
    if CutOutbounds and (ScreenRect.Right < 0)
      then ScreenRect.Right := HorzAxis.FixedBoundary - 1
      else ScreenRect.Right := ScreenRect.Right + HorzAxis.FixedBoundary;
    if CutOutbounds and (ScreenRect.Right > HorzAxis.ContraStart) then
      ScreenRect.Right := HorzAxis.ContraStart;
  end else
    ScreenRect.Right := HorzAxis.ContraStart + CalcColRangeWidth(ColCount, GridRect.Right - ColCount + 1);

// Bottom
  if GridRect.Bottom < FixedRowCount then
  begin
    ScreenRect.Bottom := VertAxis.GridClientStart + CalcRowRangeHeight(0, GridRect.Bottom + 1);
    if ScreenRect.Bottom > VertAxis.ContraStart then
      ScreenRect.Bottom := VertAxis.ContraStart;
  end else if GridRect.Bottom < RowCount then
  begin
    LocRow := GridRect.Bottom - FixedRowCount;
    ScreenRect.Bottom :=
      VertAxis.RolLocCelPosArr[LocRow] + VertAxis.RolCelLens[LocRow] - RolStartVisPosY;
    if CutOutbounds and (ScreenRect.Bottom < 0)
      then ScreenRect.Bottom := VertAxis.FixedBoundary - 1
      else ScreenRect.Bottom := ScreenRect.Bottom + VertAxis.FixedBoundary;
    if CutOutbounds and (ScreenRect.Bottom > VertAxis.ContraStart) then
      ScreenRect.Bottom := VertAxis.ContraStart;
  end else
    ScreenRect.Bottom := VertAxis.ContraStart + CalcRowRangeHeight(RowCount, GridRect.Bottom - RowCount + 1);

  if (ScreenRect.Left > ScreenRect.Right) or (ScreenRect.Top > ScreenRect.Bottom) then
    ScreenRect := EmptyRect;

{$IFDEF FPC}
  if UseRightToLeftAlignment then
{$ELSE}
  if UseRightToLeftAlignment and (Canvas.CanvasOrientation = coLeftToRight) then
{$ENDIF}
  begin
    HorzAxis.SwapRightToLeftPoses(ScreenRect.Left, ScreenRect.Right);
//    ScreenRect.Left := HorzAxis.RightToLeftReflect(ScreenRect.Left);
//    ScreenRect.Right := HorzAxis.RightToLeftReflect(ScreenRect.Right);
  end;
end;

procedure TCustomGridEh.GridRectToScreenRectAbs(GridRect: TGridRect;
  var ScreenRect: TRect; IncludeLine: Boolean);
begin
  GridRectToScreenRect(GridRect, ScreenRect, False);
end;

procedure TCustomGridEh.Initialize;
begin
//  FTopLeft.X := FixedCols;
//  FTopLeft.Y := FixedRows;
//  FCurrent := FTopLeft;
//  FAnchor := FCurrent;
//  if goRowSelectEh in Options then
//    FAnchor.X := ColCount - 1;
end;

procedure TCustomGridEh.InvalidateCell(ACol, ARow: Longint);
var
  Rect: TGridRect;
begin
  Rect.Top := ARow;
  Rect.Left := ACol;
  Rect.Bottom := ARow;
  Rect.Right := ACol;
  InvalidateRect(Rect);
end;

procedure TCustomGridEh.InvalidateCol(ACol: Longint);
var
  Rect: TGridRect;
begin
  if not HandleAllocated then Exit;
  Rect.Top := 0;
  Rect.Left := ACol;
  Rect.Bottom := VertAxis.FixedCelCount + VertAxis.RolLastVisCel;
  Rect.Right := ACol;
  InvalidateRect(Rect);
  if ContraRowCount > 0 then
  begin
    Rect.Top := RowCount;
    Rect.Left := ACol;
    Rect.Bottom := FullRowCount-1;
    Rect.Right := ACol;
    InvalidateRect(Rect);
  end;
end;

procedure TCustomGridEh.InvalidateRow(ARow: Longint);
var
  Rect: TGridRect;
begin
  if not HandleAllocated then Exit;
  Rect.Top := ARow;
  Rect.Left := 0;
  Rect.Bottom := ARow;
  Rect.Right := HorzAxis.FixedCelCount + HorzAxis.RolLastVisCel;
  InvalidateRect(Rect);
  if ContraColCount > 0 then
  begin
    Rect.Top := ARow;
    Rect.Left := ColCount;
    Rect.Bottom := ARow;
    Rect.Right := FullColCount-1;
    InvalidateRect(Rect);
  end;
end;

procedure TCustomGridEh.InvalidateGrid;
begin
  Invalidate;
end;

procedure TCustomGridEh.InvalidateRect(ARect: TGridRect);
var
  InvalidRect: TRect;
begin
  if not HandleAllocated then Exit;
  GridRectToScreenRect(ARect, InvalidRect);
  if not EqualRect(EmptyRect, InvalidRect) then
    WindowsInvalidateRect(Handle, InvalidRect, False);
end;

procedure TCustomGridEh.ScrollBarMessage(ScrollBar, ScrollCode, Pos: Integer;
  UseRightToLeft: Boolean);
var
  APosition, AMin, AMax, APageSize: Integer;
begin
  if ScrollBar = SB_HORZ then
  begin
    if (not UseRightToLeftAlignment) or (not UseRightToLeft) then
      //OK;RTLFactor := 1
    else
    begin
      case ScrollCode of
        SB_LINEUP: ScrollCode := SB_LINEDOWN;
        SB_LINEDOWN: ScrollCode := SB_LINEUP;
        SB_PAGEUP: ScrollCode := SB_PAGEDOWN;
        SB_PAGEDOWN: ScrollCode := SB_PAGEUP;
        SB_THUMBPOSITION,
        SB_THUMBTRACK:
          begin
//            if not UseRightToLeftAlignment
//              then Pos := Integer(Pos) - 1
//              else Pos := 1 - Integer(Pos);
            if UseRightToLeftAlignment then
            begin
              GetDataForHorzScrollBar(APosition, AMin, AMax, APageSize);
              Pos := AMax - Integer(Pos) - APageSize + 1;
            end else
              Pos := Integer(Pos) - 1;
          end;
        SB_BOTTOM: ScrollCode := SB_TOP;
        SB_TOP: ScrollCode := SB_BOTTOM;
      end;
    end;

    HorzScrollBarMessage(ScrollCode, Pos);
  end else
    VertScrollBarMessage(ScrollCode, Pos);
end;

procedure TCustomGridEh.ScrollBarShowingChanged;
begin
end;

procedure ModifySmoothScrollBar(Code, Pos: Cardinal; Axis: TGridAxisDataEh;
  ScrollBar: TGridScrollBarEh);
var
  NewOffset: Integer;
begin
  NewOffset := 0;
  case Code of
    SB_LINEUP: NewOffset := -Axis.GetScrollStep;
    SB_LINEDOWN: NewOffset := Axis.GetScrollStep;
    SB_PAGEUP: NewOffset := -Axis.RolClientLen;
    SB_PAGEDOWN: NewOffset := Axis.RolClientLen;
    SB_THUMBPOSITION,
    SB_THUMBTRACK:
      if ScrollBar.Tracking  or (Code = SB_THUMBPOSITION) then
      begin
        NewOffset := Integer(Pos) - Axis.RolStartVisPos;
      end;
    SB_BOTTOM: NewOffset := Axis.RolStopVisPos - Axis.RolStartVisPos;
    SB_TOP: NewOffset := -Axis.RolStartVisPos;
  end;
  Axis.RolStartVisPos := Axis.CheckRolStartVisPos(Axis.RolStartVisPos + NewOffset);
end;

procedure ModifyDiscreteScrollBar(Code, Pos: Cardinal; Axis: TGridAxisDataEh;
  ScrollBar: TGridScrollBarEh);
var
  NewCelOffset, NewCell: Integer;
//  PageSize: Integer;
begin
  NewCell := -1;
  case Code of
    SB_LINEUP:
      if Axis.RolStartVisCelOfst > 0
        then NewCell := Axis.RolStartVisCel
        else NewCell := Axis.RolStartVisCel-1;
    SB_LINEDOWN:
      NewCell := Axis.RolStartVisCel+1;
    SB_PAGEUP:
      begin
        Axis.RolCellAtPos(Integer(Pos)-Axis.RolClientLen, NewCell, NewCelOffset);
        if NewCelOffset > 0 then
          Inc(NewCell);
      end;
    SB_PAGEDOWN:
      if Axis.RolLastFullVisCel = Axis.RolLastVisCel
        then NewCell := Axis.RolLastVisCel + 1
        else NewCell := Axis.RolLastVisCel;
    SB_THUMBPOSITION,
    SB_THUMBTRACK:
      if ScrollBar.Tracking or (Code = SB_THUMBPOSITION) then
      begin
        if Pos = Axis.RolLen-Axis.RolClientLen then
          NewCell := Axis.RolCelCount-1
        else
        begin
          Axis.RolCellAtPos(Pos, NewCell, NewCelOffset);
          if NewCelOffset > Axis.RolCelLens[NewCell] div 2 then
            Inc(NewCell);
        end;
      end;
    SB_BOTTOM:
      NewCell := Axis.RolCelCount;
    SB_TOP:
      NewCell := 0;
  end;
  if NewCell <> -1 then
    Axis.SafeSetRolStartVisCel(NewCell);
end;

procedure TCustomGridEh.HorzScrollBarMessage(ScrollCode, Pos: Integer);
begin
  if HorzScrollBar.SmoothStep then
    ModifySmoothScrollBar(ScrollCode, Pos, HorzAxis, HorzScrollBar)
  else
    ModifyDiscreteScrollBar(ScrollCode, Pos, HorzAxis, HorzScrollBar);
end;

procedure TCustomGridEh.VertScrollBarMessage(ScrollCode, Pos: Integer);
begin
  if VertScrollBar.SmoothStep then
    ModifySmoothScrollBar(ScrollCode, Pos, VertAxis, VertScrollBar)
  else
    ModifyDiscreteScrollBar(ScrollCode, Pos, VertAxis, VertScrollBar);
end;

procedure TCustomGridEh.MoveCurrent(ACol, ARow: Integer; ShowX, ShowY: Boolean);
var
  OldCurCell: TGridCoord;
  OldMultiselected: Boolean;
  OldSel: TGridRect;
begin
  if (ACol < 0) or (ARow < 0) or (ACol >= ColCount) or (ARow >= RowCount) then
    raise EInvalidGridOperationEh.Create('Grid index out of range');

  if SelectCell(ACol, ARow) then
  begin
    OldSel := Selection;
    OldCurCell := FCurCell;
    OldMultiselected := IsMultiSelected;
    FCurCell.X := ACol;
    FCurCell.Y := ARow;
    if not (goAlwaysShowEditorEh in Options) then HideEditor;
    FAnchorCell := FCurCell;
{    if MoveAnchor or not (goRangeSelect in Options) then
    begin
      FAnchor := FCurrent;
      if goRowSelectEh in Options then FAnchor.X := ColCount - 1;
    end;}
//    if goRowSelectEh in Options then FCurrent.X := FixedCols;
    if ShowX or ShowY then
      ClampInView(FCurCell, {not (goRowSelectEh in Options) and }ShowX, ShowY);
//    SelectionMoved(OldSel);
    if OldMultiselected <> IsMultiSelected then
    begin
      InvalidateGrid;
    end else
    begin
      InvalidateCell(OldCurCell.X, OldCurCell.Y);
      InvalidateCell(ACol, ARow);
    end;
    SelectionChanged(OldSel);
    CurrentCellMoved(OldCurCell);
  end;
end;

procedure TCustomGridEh.CurrentCellMoved(OldCurrent: TGridCoord);
begin
end;

function TCustomGridEh.IsSmoothHorzScroll: Boolean;
begin
  Result := HorzScrollBar.SmoothStep;
end;

function TCustomGridEh.IsSmoothVertScroll: Boolean;
begin
  Result := VertScrollBar.SmoothStep;
end;

{$IFDEF EH_LIB_13}
function TCustomGridEh.IsTouchPropertyStored(AProperty: TTouchProperty): Boolean;
begin
  Result := inherited IsTouchPropertyStored(AProperty);
  case AProperty of
    tpInteractiveGestures:
      Result := Touch.InteractiveGestures <> [igPan, igPressAndTap];
    tpInteractiveGestureOptions:
      Result := Touch.InteractiveGestureOptions <> [igoPanInertia,
        igoPanSingleFingerHorizontal, igoPanSingleFingerVertical,
        igoPanGutter, igoParentPassthrough];
  end;
end;
{$ENDIF}

function TCustomGridEh.GetHorzScrollStep: Integer;
begin
  Result := (VertAxis.ContraStart - VertAxis.FixedBoundary) div 20;
  if Result = 0 then
    Result := 1;
end;

function TCustomGridEh.GetVertScrollStep: Integer;
begin
  Result := (VertAxis.ContraStart - VertAxis.FixedBoundary) div 20;
  if Result = 0 then
    Result := 1;
end;


procedure TCustomGridEh.SetInternalColors;
{$IFDEF EH_LIB_16}
var
  LStyle: TCustomStyleServices;
{$ENDIF}
begin
  FInternalColor := Color;
  FInternalFontColor := Font.Color;
  FInternalFixedColor := FixedColor;
  FInternalFixedFontColor := Font.Color;
{$IFDEF EH_LIB_16}
  LStyle := StyleServices;
  if TStyleManager.IsCustomStyleActive then
  begin
    LStyle.GetElementColor(LStyle.GetElementDetails(tgCellNormal), ecFillColor, FInternalColor);
    if FInternalColor = clNone then
      FInternalColor := Color;
    LStyle.GetElementColor(LStyle.GetElementDetails(tgCellNormal), ecTextColor, FInternalFontColor);
    if FInternalFontColor = clNone then
      FInternalFontColor := Font.Color;

    LStyle.GetElementColor(LStyle.GetElementDetails(tgClassicFixedCellNormal), ecFillColor, FInternalFixedColor);
    if FInternalFixedColor = clNone then
      FInternalFixedColor := FixedColor;
    LStyle.GetElementColor(LStyle.GetElementDetails(tgClassicFixedCellNormal), ecTextColor, FInternalFixedFontColor);
    if FInternalFixedFontColor = clNone then
      FInternalFixedFontColor := Font.Color;
  end;
{$ENDIF}
end;

function TCustomGridEh.CreateEditor: TInplaceEdit;
begin
  Result := TInplaceEdit.Create(Self);
end;

function TCustomGridEh.EnsureInplaceEditCreated: Boolean;
begin
  Result := False;
  if FInplaceEdit = nil then
  begin
    FInplaceEdit := CreateEditor;
    FInplaceEdit.SetGrid(Self);
    FInplaceEdit.Parent := Self;
    Result := True;
  end
end;

function TCustomGridEh.WantInplaceEditorKey(Key: Word; Shift: TShiftState): Boolean;

  function CaretPos: Integer;
  var
    P: TPoint;
  begin
    Windows.GetCaretPos(P);
    Result := SendMessage(InplaceEditor.Handle, EM_CHARFROMPOS, 0, MakeLong(P.X, P.Y));
  end;

  function Selection: TSelection;
  begin
//    SendMessage(Handle, EM_GETSEL, Longint(@Result.StartPos), Longint(@Result.EndPos));
    MessageSendGetSel(InplaceEditor.Handle, Result.StartPos, Result.EndPos);
  end;

  function ForwardMovement: Boolean;
  begin
    Result := goAlwaysShowEditorEh in Options;
  end;

  function Ctrl: Boolean;
  begin
    Result := ssCtrl in Shift;
  end;

  function RightSide: Boolean;
  begin
    with Selection do
      Result := (CaretPos = InplaceEditor.GetTextLen) and
        ((StartPos = 0) or (EndPos = StartPos)) and (EndPos = InplaceEditor.GetTextLen);
   end;

  function LeftSide: Boolean;
  begin
    with Selection do
    begin
      Result := (CaretPos = 0) and (StartPos = 0) and
        ((EndPos = 0) or (EndPos = InplaceEditor.GetTextLen));
      Result := Result or
        ((CaretPos = InplaceEditor.GetTextLen) and (StartPos = 0) and (EndPos = InplaceEditor.GetTextLen));
    end;
  end;

begin
  Result := False;
  case Key of
    VK_UP, VK_DOWN, VK_PRIOR, VK_NEXT, VK_ESCAPE: Result := True;
    VK_INSERT:
      if Shift = [] then
        Result := True;
    VK_LEFT: if ForwardMovement and (Ctrl or LeftSide) then Result := True;
    VK_RIGHT: if ForwardMovement and (Ctrl or RightSide) then Result := True;
    VK_HOME: if ForwardMovement and (Ctrl or LeftSide) then Result := True;
    VK_END: if ForwardMovement and (Ctrl or RightSide) then Result := True;
    VK_TAB: if not (ssAlt in Shift) then Result := True;
    VK_DELETE:
      if Ctrl then
        Result := True;
  end;
end;

procedure TCustomGridEh.SafeScrollData(DX, DY: Integer);
begin
  if DX <> 0 then
    HorzAxis.RolStartVisPos :=
      HorzAxis.CheckRolStartVisPos(HorzAxis.RolStartVisPos + DX);
  if DY <> 0 then
    VertAxis.RolStartVisPos :=
      VertAxis.CheckRolStartVisPos(VertAxis.RolStartVisPos + DY);
end;

procedure TCustomGridEh.SafeSetTopRow(ANewTopRow: Integer);
begin
  VertAxis.SafeSetRolStartVisCel(ANewTopRow-VertAxis.FixedCelCount);
end;

procedure TCustomGridEh.AdjustMaxTopLeft(AdjustLeft, AdjustTop,
  LeftBindToCell, TopBindToCell: Boolean);
var
  AMaxLeftPos, AMaxTopPos: Integer;
begin
  AMaxLeftPos := HorzAxis.RolLen;
  AMaxTopPos := VertAxis.RolLen;
  CalcMaxRolTopLeft(AMaxLeftPos, AMaxTopPos, LeftBindToCell, TopBindToCell);

  if AMaxLeftPos < HorzAxis.RolStartVisPos then
    RolStartVisPosX := AMaxLeftPos;
  if AMaxTopPos < RolStartVisPosY then
    RolStartVisPosY := AMaxTopPos;
end;

procedure TCustomGridEh.CalcMaxRolTopLeft(var AMaxLeftPos, AMaxTopPos: Integer;
  LeftBindToCell, TopBindToCell: Boolean);
var
  ACel, ACelOffset: Integer;
begin
  AMaxLeftPos := AMaxLeftPos - HorzAxis.RolClientLen;
  if AMaxLeftPos < 0 then
    AMaxLeftPos := 0;

  if LeftBindToCell then
  begin
    HorzAxis.RolCellAtPos(AMaxLeftPos, ACel, ACelOffset);
    if (ACelOffset > 0) and (ACel < HorzAxis.RolCelCount-1) then
      Inc(ACel);
    AMaxLeftPos := HorzAxis.RolLocCelPosArr[ACel];
  end;

  AMaxTopPos := AMaxTopPos - VertAxis.RolClientLen;
  if AMaxTopPos < 0 then
    AMaxTopPos := 0;

  if TopBindToCell then
  begin
    VertAxis.RolCellAtPos(AMaxTopPos, ACel, ACelOffset);
    if (ACelOffset > 0) and (ACel < VertAxis.RolCelCount-1) then
      Inc(ACel);
    AMaxTopPos := VertAxis.RolLocCelPosArr[ACel];
  end;

end;

procedure TCustomGridEh.FastInvalidate;
var
  I: Integer;
begin
  if HandleAllocated then
  begin
    Windows.InvalidateRect(Handle, nil, not (csOpaque in ControlStyle));
    { Invalidate child windows which use the parentbackground when themed }
    if ThemeServices.ThemesEnabled then
      for I := 0 to ControlCount - 1 do
        if csParentBackground in Controls[I].ControlStyle then
          Controls[I].Invalidate;
  end;
end;


procedure TCustomGridEh.DrawBordersForCellArea(ACol, ARow: Integer;
  var ARect: TRect; State: TGridDrawState);
var
  RIsDraw, BIsDraw: Boolean;
  RBorderColor, BBorderColor: TColor;
  RIsExtent, BIsExtent: Boolean;
  RBorderRect, BBorderRect: TRect;
begin
  CheckDrawCellBorder(ACol, ARow, cbtRightEh, RIsDraw, RBorderColor, RIsExtent);
  CheckDrawCellBorder(ACol, ARow, cbtBottomEh, BIsDraw, BBorderColor, BIsExtent);

  if RIsDraw and RIsExtent and BIsDraw and BIsExtent then
  begin
    if RBorderColor <> BBorderColor then
      if GetColorLuminance(RBorderColor) >
         GetColorLuminance(BBorderColor)
      then
        RIsExtent := False
      else
        BIsExtent := False;
  end;

  if RIsDraw then
  begin
    RBorderRect := ARect;
    if RIsExtent then
      Inc(RBorderRect.Bottom);
    Canvas.Pen.Color := RBorderColor;
    DrawPolyline([Point(RBorderRect.Right-1, RBorderRect.Top), Point(RBorderRect.Right-1, RBorderRect.Bottom-1)]);
  end;

  if BIsDraw then
  begin
    BBorderRect := ARect;
    if BIsExtent then
      Inc(BBorderRect.Right);
    Canvas.Pen.Color := BBorderColor;
    DrawPolyline([Point(BBorderRect.Left, BBorderRect.Bottom-1), Point(BBorderRect.Right-1, BBorderRect.Bottom-1)]);
  end;

  if RIsDraw then
    Dec(ARect.Right);
  if BIsDraw then
    Dec(ARect.Bottom);
end;

procedure TCustomGridEh.DrawCellArea(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState);
begin
  DrawBordersForCellArea(ACol, ARow, ARect, State);
  DrawCell(ACol, ARow, ARect, State);
end;

procedure TCustomGridEh.DrawCell(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState);
var
  AFillRect: TRect;
begin
  Canvas.Font.Color := clWindowText;
  Canvas.Brush.Color := clMoneyGreen;
  if (ACol >= FixedColCount-FrozenColCount) and (ARow >= FixedRowCount-FrozenRowCount) then
    Canvas.Brush.Color := clWindow;

  if gdSelected in State then
  begin
    Canvas.Font.Color := clHighlightText;
    if IsActiveControl then
      Canvas.Brush.Color := clHighlight
    else
      Canvas.Brush.Color := clBtnShadow;
  end;

  AFillRect := ARect;
//  Inc(AFillRect.Right);
//  Inc(AFillRect.Bottom);
  Canvas.FillRect(AFillRect);
  Canvas.TextRect(AFillRect, AFillRect.Left+2, AFillRect.Top+2, IntToStr(ACol) + ':' + IntToStr(ARow));
end;

procedure TCustomGridEh.DrawEmptyAreaCell(ACol, ARow: Integer; ARect: TRect);
var
  AFillRect: TRect;
begin
  AFillRect := ARect;
  Canvas.Brush.Color := Color;
//  Inc(AFillRect.Right);
//  Inc(AFillRect.Bottom);
  Canvas.FillRect(AFillRect);
end;

procedure TCustomGridEh.WMSize(var Msg: TWMSize);
begin
  inherited;
end;

procedure TCustomGridEh.Resize;
begin
  inherited;
  {$IFDEF FPC}
  {$ELSE}
  UpdateBoundaries;
  {$ENDIF}
end;

{$IFDEF FPC}
procedure TCustomGridEh.BoundsChanged;
begin
  inherited BoundsChanged;
  UpdateBoundaries;
end;
{$ELSE}
{$ENDIF}

function TCustomGridEh.GetFullColCount: Integer;
begin
  Result := ColCount + ContraColCount;
end;

function TCustomGridEh.GetFullRowCount: Integer;
begin
  Result := RowCount + ContraRowCount;
end;

function TCustomGridEh.GetWinClientBoundary: TRect;
begin
  Result := FWinClientBoundary;
end;

function TCustomGridEh.GetGridClientHeight: Integer;
begin
  Result := VertAxis.GridClientStop - VertAxis.GridClientStart;
end;

function TCustomGridEh.GetGridClientWidth: Integer;
begin
  Result := HorzAxis.GridClientStop - HorzAxis.GridClientStart;
end;

function TCustomGridEh.GetContraColCount: Integer;
begin
  Result := HorzAxis.ContraCelCount;
end;

procedure TCustomGridEh.SetContraColCount(const Value: Integer);
begin
  HorzAxis.ContraCelCount := Value;
end;

function TCustomGridEh.GetContraRowCount: Integer;
begin
  Result := VertAxis.ContraCelCount;
end;

procedure TCustomGridEh.SetContraRowCount(const Value: Integer);
begin
  VertAxis.ContraCelCount := Value;
end;


function TCustomGridEh.GetFixedColCount: Integer;
begin
  Result := HorzAxis.FFixedCelCount;
end;

procedure TCustomGridEh.SetFixedColCount(const Value: Integer);
var
  Delta: Integer;
begin
  if HorzAxis.FFixedCelCount <> Value then
  begin
    if Value < 0 then
      raise Exception.Create('RolColCount can be less then 0');
    Delta := Value - HorzAxis.FFixedCelCount;
    SetLength(HorzAxis.FFixedCelLens, Value);
    if Delta > 0 then
      FillArray(HorzAxis.FFixedCelLens, HorzAxis.FFixedCelCount, Delta, DefaultColWidth);
    HorzAxis.FFixedCelCount := Value;
    CellCountChanged;
    UpdateBoundaries;
  end;
end;

function TCustomGridEh.GetFixedRowCount: Integer;
begin
  Result := VertAxis.FFixedCelCount;
end;

procedure TCustomGridEh.SetFixedRowCount(const Value: Integer);
var
  Delta: Integer;
begin
  if VertAxis.FFixedCelCount <> Value then
  begin
    if Value < 0 then
      raise Exception.Create('RolRowCount can be less then 0');
    Delta := Value - VertAxis.FFixedCelCount;
    SetLength(VertAxis.FFixedCelLens, Value);
    if Delta > 0 then
      FillArray(VertAxis.FFixedCelLens, VertAxis.FFixedCelCount, Delta, DefaultRowHeight);
    VertAxis.FFixedCelCount := Value;
    CellCountChanged;
    UpdateBoundaries;
  end;
end;

function TCustomGridEh.GetRolColCount: Integer;
begin
  Result := HorzAxis.RolCelCount;
end;

procedure TCustomGridEh.SetRolColCount(const Value: Integer);
begin
  HorzAxis.RolCelCount := Value;
end;

function TCustomGridEh.GetRolRowCount: Integer;
begin
  Result :=  VertAxis.FRolCelCount;
end;

procedure TCustomGridEh.SetRolRowCount(const Value: Integer);
begin
  VertAxis.RolCelCount := Value;
end;

function TCustomGridEh.GetRolStartVisPosX: Int64;
begin
  Result := HorzAxis.RolStartVisPos;
end;

procedure TCustomGridEh.SetRolStartVisPosX(const Value: Int64);
begin
  HorzAxis.RolStartVisPos := Value;
end;

function TCustomGridEh.GetRolStartVisPosY: Int64;
begin
  Result := VertAxis.RolStartVisPos;
end;

procedure TCustomGridEh.SetRolStartVisPosY(const Value: Int64);
begin
  VertAxis.RolStartVisPos := Value;
end;

procedure TCustomGridEh.SetDefaultColWidth(const Value: Integer);
begin
  HorzAxis.DefaultCelLen := Value;
end;

function TCustomGridEh.GetDefaultColWidth: Integer;
begin
  Result := HorzAxis.DefaultCelLen;
end;

procedure TCustomGridEh.SetDefaultRowHeight(const Value: Integer);
begin
  VertAxis.DefaultCelLen := Value;
end;

function TCustomGridEh.GetDefaultRowHeight: Integer;
begin
  Result := VertAxis.DefaultCelLen;
end;

procedure TCustomGridEh.SetColWidths(Index: Integer; const Value: Integer);
begin
  HorzAxis.CelLens[Index] := Value;
end;

procedure TCustomGridEh.SetRowHeights(Index: Integer; const Value: Integer);
begin
  VertAxis.CelLens[Index] := Value;
end;

procedure TCustomGridEh.SetScrollBarSize(const Value: Integer);
begin
  if FScrollBarSize <> Value then
  begin
    FScrollBarSize := Value;
    UpdateBoundaries;
  end;
end;

procedure TCustomGridEh.SetSizeGripAlwaysShow(const Value: Boolean);
begin
  if FSizeGripAlwaysShow <> Value then
  begin
    FSizeGripAlwaysShow := Value;
    UpdateScrollBarPanels;
  end;
end;

procedure TCustomGridEh.SetSizeGripPostion(const Value: TSizeGripPosition);
begin
  if FSizeGripPostion <> Value then
  begin
    FSizeGripPostion := Value;
    UpdateScrollBarPanels;
  end;
end;

function TCustomGridEh.GetColCount: Integer;
begin
  Result := FixedColCount + RolColCount;
end;

procedure TCustomGridEh.SetColCount(const Value: Integer);
begin
  RolColCount := Value - FixedColCount;
end;

function TCustomGridEh.GetRowCount: Integer;
begin
  Result := FixedRowCount + RolRowCount;
end;

procedure TCustomGridEh.SetRowCount(const Value: Integer);
begin
  RolRowCount := Value - FixedRowCount;
end;

procedure TCustomGridEh.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := Style or WS_TABSTOP;
//    if FScrollBars in [ssVertical, ssBoth] then Style := Style or WS_VSCROLL;
//    if FScrollBars in [ssHorizontal, ssBoth] then Style := Style or WS_HSCROLL;
    WindowClass.style := CS_DBLCLKS;
    if FBorderStyle = bsSingle then
      if NewStyleControls and Ctl3D then
      begin
        Style := Style and not WS_BORDER;
        ExStyle := ExStyle or WS_EX_CLIENTEDGE;
      end
      else
        Style := Style or WS_BORDER;
    Style := Style or WS_CLIPCHILDREN; //To avoid black box in Inplace editor When BufferedPaint.
  end;
end;

{$IFDEF EH_LIB_13}
procedure TCustomGridEh.DoGesture(const EventInfo: TGestureEventInfo; var Handled: Boolean);
const
  VertScrollFlags: array[Boolean] of Integer = (SB_LINEDOWN, SB_LINEUP);
  HorizScrollFlags: array[Boolean] of Integer = (SB_LINERIGHT, SB_LINELEFT);
var
  I, LColWidth, LCols, LRowHeight, LRows, DeltaX, DeltaY: Integer;
begin
  if EventInfo.GestureID = igiPan then
  begin
    Handled := True;
    if gfBegin in EventInfo.Flags then
      FPanPoint := EventInfo.Location
    else if not (gfEnd in EventInfo.Flags) then
    begin
      // Vertical panning
      DeltaY := EventInfo.Location.Y - FPanPoint.Y;
      if Abs(DeltaY) > 1 then
      begin
        LRowHeight := RowHeights[TopRow];
        LRows := Abs(DeltaY) div LRowHeight;
        if (Abs(DeltaY) mod LRowHeight = 0) or (LRows > 0) then
        begin
          for I := 0 to LRows - 1 do
            ScrollBarMessage(SB_VERT, VertScrollFlags[DeltaY > 0], 0, True);
          FPanPoint := EventInfo.Location;
          Inc(FPanPoint.Y, DeltaY mod LRowHeight);
        end;
      end
      else
      begin
        // Horizontal panning
        DeltaX := EventInfo.Location.X - FPanPoint.X;
        if Abs(DeltaX) > 1 then
        begin
          LColWidth := ColWidths[LeftCol];
          LCols := Abs(DeltaX) div LColWidth;
          if (Abs(DeltaX) mod LColWidth = 0) or (LCols > 0) then
          begin
            for I := 0 to LCols - 1 do
              ScrollBarMessage(SB_HORZ, HorizScrollFlags[DeltaX > 0], 0, True);
            FPanPoint := EventInfo.Location;
            Inc(FPanPoint.X, DeltaX mod LColWidth);
          end;
        end;
      end;

    end;
  end;
end;
{$ENDIF}

procedure TCustomGridEh.KeyDown(var Key: Word; Shift: TShiftState);
var
  {NewTopLeft, }NewCurrent: TGridCoord;
//  DrawInfo: TGridDrawInfo;
  PageWidth{, PageHeight}: Integer;
  NextPageRow, PrevPageRow: Integer;
  RTLFactor: Integer;
  NeedsInvalidating: Boolean;
  NewAnchor: TGridCoord;

  procedure CalcPageExtents;
  var
    NewPos, NewCel, NewCelOff, i: Integer;
  begin
    NewPos := VertAxis.RolStartVisPos + VertAxis.RolClientLen;
    NextPageRow := RolRowCount - 1;
    if NewPos < VertAxis.RolLen then
    begin
      BinarySearch(VertAxis.FRolLocCelPosArr, NewPos, NewCel, NewCelOff);
      if NewCel < RolRowCount then
      begin
        for i := NewCel to RolRowCount-1 do
        begin
          NextPageRow := i-1;
          if VertAxis.RolLocCelPosArr[i] + VertAxis.RolCelLens[i] > NewPos + VertAxis.RolClientLen then
            Break;
        end;
      end;
    end;  
    NextPageRow := NextPageRow + FixedRowCount;
    if (NextPageRow <= Row) and (NextPageRow < RowCount) then
      NextPageRow := Row + 1;

    NewPos := VertAxis.RolStartVisPos - VertAxis.RolClientLen;
    BinarySearch(VertAxis.FRolLocCelPosArr, NewPos, NewCel, NewCelOff);
    if NewCelOff > 0 then
      Inc(NewCel);
    PrevPageRow := NewCel + FixedRowCount;
    if (PrevPageRow >= Row) and (PrevPageRow > 0) then
      PrevPageRow := Row - 1;
  end;

  procedure Restrict(var Coord: TGridCoord; MinX, MinY, MaxX, MaxY: Longint);
  begin
    if Coord.X > MaxX then
      Coord.X := MaxX
    else if Coord.X < MinX then
      Coord.X := MinX;

    if Coord.Y > MaxY then
      Coord.Y := MaxY
    else if Coord.Y < MinY then
      Coord.Y := MinY;
  end;

begin
  inherited KeyDown(Key, Shift);
  NeedsInvalidating := False;
//  if not CanGridAcceptKey(Key, Shift) then Key := 0;
  if not UseRightToLeftAlignment then
    RTLFactor := 1
  else
    RTLFactor := -1;
  NewCurrent := FCurCell;
//  NewTopLeft := FTopLeft;
  PageWidth := 0;
//  PageHeight := 0;
  CalcPageExtents;
  if (ssShift in Shift) and (goRangeSelectEh in Options) then
  begin
    NewAnchor := FAnchorCell;
    case Key of
      VK_UP: Dec(NewAnchor.Y);
      VK_DOWN: Inc(NewAnchor.Y);
      VK_LEFT: Dec(NewAnchor.X);
      VK_RIGHT: Inc(NewAnchor.X);
    end;
    Restrict(NewAnchor,
      FixedColCount-FrozenColCount, FixedRowCount-FrozenRowCount,
      FullColCount - 1, FullRowCount - 1);
    MoveAnchorCell(NewAnchor.X, NewAnchor.Y, True);
  end else
  begin
    if ssCtrl in Shift then
      case Key of
        VK_UP: {Dec(NewTopLeft.Y)};
        VK_DOWN: {Inc(NewTopLeft.Y)};
        VK_LEFT:
  //        if not (goRowSelectEh in Options) then
          begin
            Dec(NewCurrent.X, PageWidth * RTLFactor);
  //          Dec(NewTopLeft.X, PageWidth * RTLFactor);
          end;
        VK_RIGHT:
  //        if not (goRowSelectEh in Options) then
          begin
            Inc(NewCurrent.X, PageWidth * RTLFactor);
  //          Inc(NewTopLeft.X, PageWidth * RTLFactor);
          end;
        VK_PRIOR: NewCurrent.Y := TopRow;
  //      VK_NEXT: NewCurrent.Y := DrawInfo.Vert.LastFullVisibleCell;
        VK_HOME:
          begin
            NewCurrent.X := FixedColCount;
            NewCurrent.Y := FixedRowCount;
            NeedsInvalidating := UseRightToLeftAlignment;
          end;
        VK_END:
          begin
            NewCurrent.X := ColCount - 1;
            NewCurrent.Y := RowCount - 1;
            NeedsInvalidating := UseRightToLeftAlignment;
          end;
      end
    else
      case Key of
        VK_UP: Dec(NewCurrent.Y);
        VK_DOWN: Inc(NewCurrent.Y);
        VK_LEFT:
          {if goRowSelectEh in Options
            then Dec(NewCurrent.Y, RTLFactor)
            else}
            Dec(NewCurrent.X, RTLFactor);
        VK_RIGHT:
          {if goRowSelectEh in Options
            then Inc(NewCurrent.Y, RTLFactor)
            else}
            Inc(NewCurrent.X, RTLFactor);
        VK_NEXT:
          begin
            NewCurrent.Y := NextPageRow;
  //          Inc(NewTopLeft.Y, PageHeight);
          end;
        VK_PRIOR:
          begin
            NewCurrent.Y := PrevPageRow;
  //          Dec(NewCurrent.Y, PageHeight);
  //          Dec(NewTopLeft.Y, PageHeight);
          end;
        VK_HOME:
          {if goRowSelectEh in Options then
            NewCurrent.Y := FixedRows else}
            NewCurrent.X := FixedColCount;
        VK_END:
          {if goRowSelectEh in Options then
            NewCurrent.Y := RowCount - 1 else}
            NewCurrent.X := ColCount - 1;
        VK_TAB:
          if not (ssAlt in Shift) then
          repeat
            if ssShift in Shift then
            begin
              Dec(NewCurrent.X);
              if NewCurrent.X < FixedColCount then
              begin
                NewCurrent.X := ColCount - 1;
                Dec(NewCurrent.Y);
                if NewCurrent.Y < FixedRowCount then NewCurrent.Y := RowCount - 1;
              end;
              Shift := [];
            end
            else
            begin
              Inc(NewCurrent.X);
              if NewCurrent.X >= ColCount then
              begin
                NewCurrent.X := FixedColCount;
                Inc(NewCurrent.Y);
                if NewCurrent.Y >= RowCount then NewCurrent.Y := FixedRowCount;
              end;
            end;
          until TabStops[NewCurrent.X] or (NewCurrent.X = FCurCell.X);
        VK_F2: EditorMode := True;
      end;
  //  MaxTopLeft.X := ColCount - 1;
  //  MaxTopLeft.Y := RowCount - 1;

  //  MaxTopLeft := CalcMaxTopLeft(MaxTopLeft, DrawInfo);
  //  Restrict(NewTopLeft, FixedColCount, FixedRowCount, ColCount - 1, RowCount - 1);
  //  if (NewTopLeft.X <> LeftCol) or (NewTopLeft.Y <> TopRow) then
  //    MoveTopLeft(NewTopLeft.X, NewTopLeft.Y);
    Restrict(NewCurrent,
      FixedColCount-FrozenColCount, FixedRowCount-FrozenRowCount,
      ColCount - 1, RowCount - 1);
    if (NewCurrent.X <> Col) or (NewCurrent.Y <> Row) then
      FocusCell(NewCurrent.X, NewCurrent.Y, not (ssShift in Shift));

    if NeedsInvalidating then Invalidate;
  //  MoveCurrent(NewCurrent.X, NewCurrent.Y, True, True);
  end;
end;

procedure TCustomGridEh.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  if not (goAlwaysShowEditorEh in Options) and (Key = #13) and (goEditingEh in Options) then
  begin
    if FEditorMode then
      HideEditor else
      ShowEditor;
    Key := #0;
  end;
end;

function TCustomGridEh.CanHotTackCell(X, Y: Integer): Boolean;
begin
  Result := False;
end;

procedure TCustomGridEh.UpdateHotTackInfo(X, Y: Integer);
var
  CellHit: TGridCoord;
  ACellRect: TRect;

  procedure SafeInvalidateCell(ACol, ARow: Longint);
  begin
    if (ACol >= 0) and (ACol < FullColCount) and
       (ARow >= 0) and (ARow < FullRowCount)
    then
      InvalidateCell(ACol, ARow);
  end;

begin
  if (csDesigning in ComponentState) then
    Exit;
  CellHit := CalcCoordFromPoint(X, Y);
  if CanHotTackCell(CellHit.X, CellHit.Y) then
  begin
//        if (FHotTrackCell.X <> -1) or (FHotTrackCell.Y <> -1) then
//          InvalidateCell(FHotTrackCell.X, FHotTrackCell.Y);
    if (CellHit.X <> FHotTrackCell.X) or (CellHit.Y <> FHotTrackCell.Y) then
    begin
      if (FHotTrackCell.X >= 0) and
         (FHotTrackCell.X < FullColCount) and
         (FHotTrackCell.Y >= 0) and
         (FHotTrackCell.Y < FullRowCount)
      then
        InvalidateCell(FHotTrackCell.X, FHotTrackCell.Y);
      FHotTrackCell := CellHit;
      if (FHotTrackCell.X >= 0) and (FHotTrackCell.Y >= 0) then
        InvalidateCell(FHotTrackCell.X, FHotTrackCell.Y);
    end;
  end else
  if (FHotTrackCell.X <> -1) or (FHotTrackCell.Y <> -1) then
  begin
    SafeInvalidateCell(FHotTrackCell.X, FHotTrackCell.Y);
    FHotTrackCell.X := -1;
    FHotTrackCell.Y := -1;
  end;
  if (FHotTrackCell.X >= 0) and (FHotTrackCell.Y >= 0) then
  begin
    ACellRect := CellRect(FHotTrackCell.X, FHotTrackCell.Y);
    FHotTrackInCellPos.X := X - ACellRect.Left;
    FHotTrackInCellPos.Y := Y - ACellRect.Top;
  end;


  SetHotTrackSpotInfo(FNewHotTrackSpot, X, Y);
  if not HotTrackSpotsEqual(FOldHotTrackSpot, FNewHotTrackSpot) then
  begin
    if (FNewHotTrackSpot.Col >= 0) and (FNewHotTrackSpot.Row >= 0) then
      InvalidateSpot(FNewHotTrackSpot);
    if (FOldHotTrackSpot.Col >= 0) and (FOldHotTrackSpot.Row >= 0) then
      InvalidateSpot(FOldHotTrackSpot);
    FOldHotTrackSpot.Assign(FNewHotTrackSpot);
  end;
end;

function TCustomGridEh.CreateHotTrackSpot: TGridHotTrackSpotEh;
begin
  Result := TGridHotTrackSpotEh.Create;
  Result.Col := -1;
  Result.Row := -1;
end;

function TCustomGridEh.HotTrackSpotsEqual(OldHTSpot, NewHTSpot: TGridHotTrackSpotEh): Boolean;
begin
  Result := (OldHTSpot.Col = NewHTSpot.Col) and (OldHTSpot.Row = NewHTSpot.Row);
end;

procedure TCustomGridEh.SetHotTrackSpotInfo(HTSpot: TGridHotTrackSpotEh; X, Y: Integer);
var
  CellHit: TGridCoord;
  ACellRect: TRect;
begin
  if (csDesigning in ComponentState) then
    Exit;
  CellHit := CalcCoordFromPoint(X, Y);
  if CanHotTackCell(CellHit.X, CellHit.Y) then
  begin
    HTSpot.Col := CellHit.X;
    HTSpot.Row := CellHit.Y;
    if (CellHit.X >= 0) and (CellHit.Y >= 0) then
    begin
      ACellRect := CellRect(CellHit.X, CellHit.Y);
      HTSpot.InCellX := X - ACellRect.Left;
      if CellHit.X = HorzAxis.FixedCelCount + HorzAxis.RolStartVisCel then
        HTSpot.InCellX := HTSpot.InCellX + HorzAxis.RolStartVisCelOfst;
      HTSpot.InCellY := Y - ACellRect.Top;
      if CellHit.Y = VertAxis.FixedCelCount + VertAxis.RolStartVisCel then
        HTSpot.InCellY := HTSpot.InCellY + VertAxis.RolStartVisCelOfst;
    end;
  end else
  begin
    HTSpot.Col := -1;
    HTSpot.Row := -1;
  end;
end;

procedure TCustomGridEh.InvalidateSpot(HTSpot: TGridHotTrackSpotEh);
begin
  if (HTSpot.Col < FullColCount) and (HTSpot.Row < FullRowCount) then
    InvalidateCell(HTSpot.Col, HTSpot.Row);
end;

procedure TCustomGridEh.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  CellHit: TGridCoord;
  MoveDrawn: Boolean;
  AMoveIndex: Integer;
begin
  MoveDrawn := False;
  HideEdit;
  if not (csDesigning in ComponentState) and
    (CanFocus or (GetParentForm(Self) = nil)) then
  begin
    SetFocus;
    if {not Focused}not IsActiveControl then
    begin
      MouseCapture := False;
      Exit;
    end;
  end;
  if (Button = mbLeft) and (ssDouble in Shift) then
    DblClick
  else if Button = mbLeft then
  begin
    { Check grid sizing }
    CalcSizingState(X, Y, FGridState, FSizingIndex, FSizingPos, FSizingOfs);
    if FGridState <> gsNormalEh then
    begin
      if (FGridState = gsColSizingEh) and UseRightToLeftAlignment then
        FSizingPos := ClientWidth - FSizingPos;
      DrawSizingLine;
      Exit;
    end;
    CellHit := CalcCoordFromPoint(X, Y);
    if (CellHit.X >= FixedColCount-FrozenColCount) and (CellHit.Y >= FixedRowCount-FrozenRowCount) and
       (CellHit.X < ColCount) and (CellHit.Y < RowCount) then
    begin
      if goEditingEh in Options then
      begin
        if (CellHit.X = FCurCell.X) and (CellHit.Y = FCurCell.Y) then
          ShowEditor
        else
        begin
          if goRangeSelectEh in Options then
          begin
            FGridState := gsSelectingEh;
            SetTimer(Handle, 1, 60, nil);
            if ssShift in Shift then
              MoveAnchorCell(CellHit.X, CellHit.Y, True)
            else
              MoveCurrent(CellHit.X, CellHit.Y, True, True);
          end else
            MoveCurrent(CellHit.X, CellHit.Y, True, True);
          UpdateEdit;
        end;
        Click;
      end
      else
      begin
        FGridState := gsSelectingEh;
        SetTimer(Handle, 1, 60, nil);
        if ssShift in Shift then
          MoveAnchorCell(CellHit.X, CellHit.Y, True)
        else
          MoveCurrent(CellHit.X, CellHit.Y, True, True);
      end;
    end
    else if (goRowMovingEh in Options) and (CellHit.X >= 0) and (CellHit.X < FixedColCount)
        and (CellHit.Y >= FixedRowCount) and (CellHit.Y < RowCount) then
    begin
      FMoveIndex := CellHit.Y;
      FMovePos := FMoveIndex;
      if CheckBeginRowDrag(FMoveIndex, FMovePos, Point(X,Y)) then
      begin
        FGridState := gsRowMovingEh;
        Update;
        DrawMove;
        MoveDrawn := True;
        SetTimer(Handle, 1, 60, nil);
      end;
    end
    else if (goColMovingEh in Options) and (CellHit.Y >= 0) and (CellHit.Y < FixedRowCount)
        and (CellHit.X >= FixedColCount) and (CellHit.X < ColCount) then
    begin
      AMoveIndex := CellHit.X;
      if CheckBeginColumnDrag(AMoveIndex, AMoveIndex, Point(X,Y)) then
        StartColMoving(AMoveIndex, X, Y);
    end;
  end;
  try
    inherited MouseDown(Button, Shift, X, Y);
  except
    if MoveDrawn then HideMove;
  end;
end;

procedure TCustomGridEh.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  CellHit: TGridCoord;
  CheckMoveAndScroll: Boolean;
  MinCell, MaxCell: TGridCoord;
begin
  case FGridState of
    gsSelectingEh, gsColMovingEh, gsRowMovingEh:
      begin
        CellHit := CalcCoordFromPoint(X, Y);
        if csDesigning in ComponentState then
          CheckMoveAndScroll := True
        else
        begin
{          CheckMoveAndScroll :=
            (CellHit.X >= FixedColCount-FrozenColCount) and (CellHit.Y >= FixedRowCount-FrozenRowCount) and
            (CellHit.X <= Min(HorzAxis.RolLastFullVisCel+HorzAxis.FixedCelCount, HorzAxis.CelCount-1)) and
            (CellHit.Y <= Min(VertAxis.RolLastFullVisCel+VertAxis.FixedCelCount, VertAxis.CelCount-1));
}
          CheckMoveAndScroll := False;

          MinCell.X := FixedColCount-FrozenColCount;
          MaxCell.X := Min(HorzAxis.RolLastFullVisCel+HorzAxis.FixedCelCount, HorzAxis.CelCount-1);

          MinCell.Y := FixedRowCount-FrozenRowCount;
          MaxCell.Y := Min(VertAxis.RolLastFullVisCel+VertAxis.FixedCelCount, VertAxis.CelCount-1);

          if (CellHit.X >= MinCell.X) and (CellHit.X <= MaxCell.X) then
          begin
            CheckMoveAndScroll := True;
            if (CellHit.Y < MinCell.Y) or (CellHit.Y > MaxCell.Y) then
              CellHit.Y := FAnchorCell.Y;
          end else
          begin
            if (CellHit.Y >= MinCell.Y) and (CellHit.Y <= MaxCell.Y) then
            begin
              CheckMoveAndScroll := True;
              if (CellHit.X < MinCell.X) or (CellHit.X > MaxCell.X) then
                CellHit.X := FAnchorCell.X;
            end;
          end;
        end;

        if CheckMoveAndScroll then
        begin
          case FGridState of
            gsSelectingEh:
              if ((CellHit.X <> FAnchorCell.X) or (CellHit.Y <> FAnchorCell.Y)) then
                MoveAnchorCell(CellHit.X, CellHit.Y, True);
            gsColMovingEh:
              MoveAndScroll(X, CellHit.X, HorzAxis, SB_HORZ, Point(X,Y));
            gsRowMovingEh:
              MoveAndScroll(Y, CellHit.Y, VertAxis, SB_VERT, Point(X,Y));
          end;
        end;
      end;
    gsRowSizingEh, gsColSizingEh:
      begin
        DrawSizingLine; { XOR it out }
        if FGridState = gsRowSizingEh then
          FSizingPos := Y + FSizingOfs else
          FSizingPos := X + FSizingOfs;
        DrawSizingLine; { XOR it back in }
      end;
    else
    begin
      UpdateHotTackInfo(X, Y);
    end;
  end;
  inherited MouseMove(Shift, X, Y);
end;

procedure TCustomGridEh.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  NewSize: Integer;
begin
  try
    case FGridState of
      gsSelectingEh:
        begin
          MouseMove(Shift, X, Y);
          KillTimer(Handle, 1);
          UpdateEdit;
          Click;
        end;
      gsRowSizingEh, gsColSizingEh:
        begin
          DrawSizingLine;
          if (FGridState = gsColSizingEh) and UseRightToLeftAlignment then
            FSizingPos := ClientWidth - FSizingPos;
          if FGridState = gsColSizingEh then
          begin
            NewSize := ResizeLine(HorzAxis);
            if NewSize > 1 then
            begin
              ColWidths[FSizingIndex] := NewSize;
              UpdateDesigner;
            end;
          end
          else
          begin
            NewSize := ResizeLine(VertAxis);
            if NewSize > 1 then
            begin
              RowHeights[FSizingIndex] := NewSize;
              UpdateDesigner;
            end;
          end;
        end;
      gsColMovingEh:
        begin
//          DrawMove;
          HideMove;
          KillTimer(Handle, 1);
          if EndColumnDrag(FMoveIndex, FMovePos, Point(X,Y))
            and (FMoveIndex <> FMovePos) then
          begin
            MoveColumn(FMoveIndex, FMovePos);
            UpdateDesigner;
          end;
          UpdateEdit;
        end;
      gsRowMovingEh:
        begin
//          DrawMove(DrawInfo);
          HideMove;
          KillTimer(Handle, 1);
          if EndRowDrag(FMoveIndex, FMovePos, Point(X,Y))
            and (FMoveIndex <> FMovePos) then
          begin
            MoveRow(FMoveIndex, FMovePos);
            UpdateDesigner;
          end;
          UpdateEdit;
        end;
    else
      UpdateEdit;
    end;
    inherited MouseUp(Button, Shift, X, Y);
  finally
    FGridState := gsNormalEh;
  end;
end;

procedure TCustomGridEh.CellMouseClick(const Cell: TGridCoord;
  Button: TMouseButton; Shift: TShiftState; const ACellRect: TRect;
  const GridMousePos, CellMousePos: TPoint);
var
  Processed: Boolean;
begin
  Processed := False;
  if Assigned(FOnCellMouseClick) then
    FOnCellMouseClick(Self, Cell, Button, Shift, CellMousePos.X, CellMousePos.Y, Processed);
  if not Processed then
    DefaultCellMouseClick(Cell, Button, Shift, ACellRect, GridMousePos, CellMousePos);
end;

procedure TCustomGridEh.DefaultCellMouseClick(const Cell: TGridCoord;
  Button: TMouseButton; Shift: TShiftState; const ACellRect: TRect;
  const GridMousePos, CellMousePos: TPoint);
begin
end;

procedure TCustomGridEh.CellMouseDown(const Cell: TGridCoord;
  Button: TMouseButton; Shift: TShiftState; const ACellRect: TRect;
  const GridMousePos, CellMousePos: TPoint);
var
  Processed: Boolean;
begin
  Processed := False;
  if Assigned(FOnCellMouseDown) then
    FOnCellMouseDown(Self, Cell, Button, Shift, CellMousePos.X, CellMousePos.Y, Processed);
  if not Processed then
    DefaultCellMouseDown(Cell, Button, Shift, ACellRect, GridMousePos, CellMousePos);
end;

procedure TCustomGridEh.DefaultCellMouseDown(const Cell: TGridCoord; Button: TMouseButton;
  Shift: TShiftState; const ACellRect: TRect; const GridMousePos, CellMousePos: TPoint);
begin
end;

function TCustomGridEh.CheckCellMouseClick(var Message: TWMLButtonUp): Boolean;
begin
  Result := (FGridState in [gsNormalEh, gsSelectingEh]) and (Message.XPos >= 0) and (Message.YPos >= 0);
end;

function TCustomGridEh.WMCheckCanSendDoubleClicks(var MouseEvent: TWMMouse): Boolean;
var
  CellHit: TGridCoord;
  MouseX, MouseY: Integer;
  Button: TMouseButton;
  ShiftState: TShiftState;
  ACellRect: TRect;
  MousePos, InCellMousePos: TPoint;
begin
  with MouseEvent do
  begin
    Button := mbLeft;
    case Msg of
      WM_LBUTTONDBLCLK: Button := mbLeft;
      WM_RBUTTONDBLCLK: Button := mbRight;
      WM_MBUTTONDBLCLK: Button := mbMiddle;
    end;
{$IFDEF EH_LIB_13}
    ShiftState := KeysToShiftState(Keys) + MouseOriginToShiftState;
{$ELSE}
    ShiftState := KeysToShiftState(Keys);
{$ENDIF}
{$IFDEF EH_LIB_13}
    if (Width > 32768) or (Height > 32768) then
      with CalcCursorPos do
      begin
        MouseX := X;
        MouseY := Y;
      end
    else
{$ENDIF}
    begin
      MouseX := XPos;
      MouseY := YPos;
    end;
  end;
  CellHit := CalcCoordFromPoint(MouseX, MouseY);
  if (CellHit.X >= 0) and (CellHit.Y >= 0) then
  begin
    ACellRect := CellRect(CellHit.X, CellHit.Y);
    MousePos := Point(MouseX, MouseY);
    InCellMousePos := Point(MouseX - ACellRect.Left, MouseY - ACellRect.Top);
    Result := CheckCellCanSendDoubleClicks(CellHit, Button, ShiftState, MousePos, InCellMousePos);
  end else
    Result := True;
end;

function TCustomGridEh.CheckCellCanSendDoubleClicks(CellHit: TGridCoord;
  Button: TMouseButton; ShiftState: TShiftState;
  MousePos, InCellMousePos: TPoint): Boolean;
begin
  Result := True;
end;

procedure TCustomGridEh.MoveAndScroll(Mouse, CellHit: Integer;
  Axis: TGridAxisDataEh; Scrollbar: Integer; const MousePt: TPoint);
var
  R: TRect;
  AMovePosRightSite: Boolean;

  function SkipHidenCells(AIndex: Integer): Integer;
  var
    i: Integer;
  begin
    Result := 0;
    for i := AIndex to ColCount-1  do
    begin
      if ColWidths[i] > 0 then Exit;
      Inc(Result);
    end;
  end;

begin
  if UseRightToLeftAlignment and (ScrollBar = SB_HORZ) then
    Mouse := ClientWidth - Mouse;

  if Axis = HorzAxis
    then R := CellRect(CellHit, 0)
    else R := CellRect(0, CellHit);

  if (FGridState = gsColMovingEh) and
     (ColWidths[FMoveIndex] <= 0) and
     (CellHit = FMoveIndex + 1 + SkipHidenCells(FMoveIndex + 1)) and
     (R.Left + (ColWidths[CellHit] div 2) > Mouse)
  then
    AMovePosRightSite := False
  else if FMovePos > FMoveIndex then
    AMovePosRightSite := True
  else
    AMovePosRightSite := False;

  if ((CellHit <> FMovePos) or (AMovePosRightSite <> FMovePosRightSite)) and
  not((Axis.RolStartVisCelOfst = 0) and (FMovePos = Axis.FixedCelCount) and (Mouse < Axis.FixedBoundary)) and
  not((FMovePos = Axis.CelCount-1) and (Mouse > Axis.ContraStart)) then
  begin
//    DrawMove(DrawInfo);   // hide the drag line
    if (Mouse < Axis.FixedBoundary) then
    begin
      if (FMovePos > Axis.FixedCelCount) or (Axis.RolStartVisCelOfst > 0) then
      begin
        ScrollBarMessage(ScrollBar, SB_LINEUP, 0, False);
//        SafeSmoothScrollData(-2, 0);
        Update;
//        CalcDrawInfo(DrawInfo);    // this changes contents of Axis var
      end;
      CellHit := Axis.StartVisCel;
    end
    else if (Mouse >= Axis.GridClientStop) then
    begin
      if (FMovePos = Axis.RolLastFullVisCel+Axis.FixedCelCount) and
        (FMovePos < Axis.CelCount -1) then
      begin
        ScrollBarMessage(Scrollbar, SB_LINEDOWN, 0, False);
//        SafeSmoothScrollData(2, 0);
        Update;
//        CalcDrawInfo(DrawInfo);    // this changes contents of Axis var
      end;
      CellHit := Axis.RolLastFullVisCel + Axis.FixedCelCount;
    end
    else if (CellHit = -1) and (Mouse > HorzAxis.RolInClientBoundary) then
      CellHit := HorzAxis.CelCount - 1
    else if CellHit < 0 then
      CellHit := FMovePos;
    if ((FGridState = gsColMovingEh) and CheckColumnDrag(FMoveIndex, CellHit, MousePt))
      or ((FGridState = gsRowMovingEh) and CheckRowDrag(FMoveIndex, CellHit, MousePt)) then
    begin
      FMovePos := CellHit;
      FMovePosRightSite := AMovePosRightSite;
    end;
    DrawMove;
  end;
end;

function TCustomGridEh.GetColWidths(Index: Integer): Integer;
begin
  Result := HorzAxis.CelLens[Index];
end;

function TCustomGridEh.GetRowHeights(Index: Integer): Integer;
begin
  Result := VertAxis.CelLens[Index];
end;

procedure TCustomGridEh.SetCol(const Value: Longint);
begin
  if Col <> Value then
    FocusCell(Value, Row, True);
end;

procedure TCustomGridEh.SetRow(const Value: Longint);
begin
  if Row <> Value then
    FocusCell(Col, Value, True);
end;

function TCustomGridEh.GetLeftCol: Longint;
begin
  Result := HorzAxis.RolStartVisCel + HorzAxis.FixedCelCount;
end;

procedure TCustomGridEh.SetLeftCol(Value: Longint);
begin
  RolStartVisPosX := HorzAxis.RolLocCelPosArr[Value - HorzAxis.FixedCelCount];
end;

function TCustomGridEh.GetTopRow: Longint;
begin
  Result := VertAxis.RolStartVisCel + VertAxis.FixedCelCount;
end;

procedure TCustomGridEh.SetTopRow(Value: Longint);
begin
  RolStartVisPosY := VertAxis.RolLocCelPosArr[Value - VertAxis.FixedCelCount];
end;

procedure TCustomGridEh.SetVertScrollBar(const Value: TGridScrollBarEh);
begin
  FVertScrollBar.Assign(Value);
end;

procedure TCustomGridEh.SetHorzScrollBar(const Value: TGridScrollBarEh);
begin
  FHorzScrollBar.Assign(Value);
end;

procedure TCustomGridEh.SetLeftPos(ALeftPos: Integer);
begin
  HorzAxis.RolStartVisPos := HorzAxis.CheckRolStartVisPos(ALeftPos);
end;

procedure TCustomGridEh.SetTopPos(ATopPos: Integer);
begin
  VertAxis.RolStartVisPos := VertAxis.CheckRolStartVisPos(ATopPos);
end;

function TCustomGridEh.GetTopRowOffset: Longint;
begin
  Result := VertAxis.RolStartVisCelOfst;
end;

function TCustomGridEh.GetLeftColOffset: Longint;
begin
  Result := HorzAxis.RolStartVisCelOfst;
end;

function TCustomGridEh.GetLastFullVisibleCol: Integer;
begin
  Result := HorzAxis.RolLastFullVisCel + HorzAxis.FixedCelCount;
end;

function TCustomGridEh.GetLastFullVisibleRow: Integer;
begin
  Result := VertAxis.RolLastFullVisCel + VertAxis.FixedCelCount;
end;

function TCustomGridEh.GetVisibleColCount: Integer;
begin
  Result := HorzAxis.RolLastFullVisCel - HorzAxis.RolStartVisCel + 1;
end;

function TCustomGridEh.GetVisibleRowCount: Integer;
begin
  Result := VertAxis.RolLastFullVisCel - VertAxis.RolStartVisCel + 1;
end;

function TCustomGridEh.GetTabStops(Index: Longint): Boolean;
begin
  Result := True;
end;

procedure TCustomGridEh.WMEraseBkgnd(var Message: TWmEraseBkgnd);
begin
  Message.Result := 1;
//  inherited;
end;

{$IFNDEF FPC}
procedure TCustomGridEh.WMPaint(var Message: TWMPaint);
var
  DC, MemDC: HDC;
  MemBitmap, OldBitmap: HBITMAP;
  PS: TPaintStruct;
  ClipRgn: HRGN;
  MemDCLi: Longint;
begin
  if PaintLocked then Exit;
  if (NeedBufferedPaint or DoubleBuffered) and not GridEhDebugDraw then
    BufferedPaint := True;
  if not FBufferedPaint or (Message.DC <> 0) then
  begin
    if not (csCustomPaint in ControlState) and (ControlCount = 0) then
      inherited
    else
      PaintHandler(Message);
  end
  else
  begin
    DC := GetDC(0);
    MemBitmap := CreateCompatibleBitmap(DC, ClientWidth, ClientHeight);
    ReleaseDC(0, DC);
    MemDC := CreateCompatibleDC(0);
    OldBitmap := SelectObject(MemDC, MemBitmap);
    try
      DC := BeginPaint(Handle, PS);
      ClipRgn := CreateRectRgn(PS.rcPaint.Left, PS.rcPaint.Top, PS.rcPaint.Right, PS.rcPaint.Bottom);
      MemDCLi := ExplicitLongwordToLongInt(MemDC);
      Perform(WM_ERASEBKGND, WPARAM(MemDCLi), LPARAM(MemDCLi));
      SelectClipRgn(MemDC, ClipRgn);
      DeleteObject(ClipRgn);
      Message.DC := MemDC;
      WMPaint(Message);
      Message.DC := 0;
      BitBlt(DC, 0, 0, ClientRect.Right, ClientRect.Bottom, MemDC, 0, 0, SRCCOPY);
      EndPaint(Handle, PS);
    finally
      SelectObject(MemDC, OldBitmap);
      DeleteDC(MemDC);
      DeleteObject(MemBitmap);
    end;
  end;
end;
{$ENDIF}

procedure TCustomGridEh.SetFixedColor(Value: TColor);
begin
  if FFixedColor <> Value then
  begin
    FFixedColor := Value;
    InvalidateGrid;
  end;
end;

procedure TCustomGridEh.SetEditorMode(Value: Boolean);
begin
  if not Value then
    HideEditor
  else
  begin
    ShowEditor;
    if FInplaceEdit <> nil then FInplaceEdit.Deselect;
  end;
end;

procedure TCustomGridEh.SetGridLineWidth(Value: Integer);
begin
  if FGridLineWidth <> Value then
  begin
    FGridLineWidth := Value;
    InvalidateGrid;
  end;
end;

function TCustomGridEh.VertLineWidth: Integer;
begin
  if [goFixedVertLineEh, goVertLineEh] * Options = []
    then Result := 0
    else Result := GridLineWidth;
end;

function TCustomGridEh.HorzLineWidth: Integer;
begin
  if [goFixedHorzLineEh, goHorzLineEh] * Options = []
    then Result := 0
    else Result := GridLineWidth;
end;

procedure TCustomGridEh.SetBorderStyle(const Value: TBorderStyle);
begin
  if FBorderStyle <> Value then
  begin
    FBorderStyle := Value;
    RecreateWndHandle;
  end;
end;

function TCustomGridEh.CalcColRangeWidth(FromCol, RangeColCount: Integer): Int64;
var
  i: Integer;
  InFixedToCol, InRolToCol, InContraFormCol: Integer;
  InRolStart: Integer;
begin
  Result := 0;
  if RangeColCount <= 0 then Exit;

  if FromCol < FixedColCount then
  begin
    if FromCol + RangeColCount <= FixedColCount
      then InFixedToCol := FromCol + RangeColCount
      else InFixedToCol := FixedColCount;

    for i := FromCol to InFixedToCol-1 do
      Inc(Result, ColWidths[i]);
  end;

  if (FromCol < ColCount) and (FromCol + RangeColCount > FixedColCount) then
  begin
    if (FromCol > FixedColCount - 1)
      then InRolStart := HorzAxis.RolLocCelPosArr[FromCol]
      else InRolStart := 0;

    if FromCol + RangeColCount <= ColCount
      then InRolToCol := FromCol + RangeColCount - 1
      else InRolToCol := ColCount - FixedColCount - 1;

    Inc(Result, HorzAxis.RolLocCelPosArr[InRolToCol] - InRolStart);
  end;

  if FromCol + RangeColCount > ColCount then
  begin
    if FromCol > ColCount
      then InContraFormCol := FromCol
      else InContraFormCol := ColCount;

    for i := InContraFormCol to FromCol + RangeColCount - 1 do
      Inc(Result, ColWidths[i]);
  end;
end;

function TCustomGridEh.CalcRowRangeHeight(FromRow, RangeRowCount: Integer): Int64;
var
  i: Integer;
  InFixedToRow, InRolToRow, InContraFormRow: Integer;
  InRolStart: Integer;
begin
  Result := 0;
  if RangeRowCount = 0 then Exit;

  if FromRow < FixedRowCount then
  begin
    if FromRow + RangeRowCount <= FixedRowCount
      then InFixedToRow := FromRow + RangeRowCount
      else InFixedToRow := FixedRowCount;

    for i := FromRow to InFixedToRow-1 do
      Inc(Result, RowHeights[i]);
  end;

  if (FromRow < RowCount) and (FromRow + RangeRowCount > FixedRowCount) then
  begin
    if (FromRow > FixedRowCount - 1)
      then InRolStart := VertAxis.RolLocCelPosArr[FromRow]
      else InRolStart := 0;

    if FromRow + RangeRowCount <= RowCount
      then InRolToRow := FromRow + RangeRowCount - 1
      else InRolToRow := RowCount - FixedRowCount - 1;

    Inc(Result, VertAxis.RolLocCelPosArr[InRolToRow] - InRolStart);
  end;

  if FromRow + RangeRowCount > RowCount then
  begin
    if FromRow > RowCount
      then InContraFormRow := FromRow
      else InContraFormRow := RowCount;

    for i := InContraFormRow to FromRow + RangeRowCount - 1 do
      Inc(Result, RowHeights[i]);
  end;
end;

procedure TCustomGridEh.SetOptions(Value: TGridOptionsEh);
begin
  if FOptions <> Value then
  begin
    if goRowSelectEh in Value then
      Exclude(Value, goAlwaysShowEditorEh);
    FOptions := Value;
    if not FEditorMode then
      if goAlwaysShowEditorEh in Value then
        ShowEditor else
        HideEditor;
    if goRowSelectEh in Value then
    begin
      MoveCurrent(Col, Row,  True, False);
//      UpdateGridDataWidth;
//      UpdateGridDataHeight;
    end;
    if HandleAllocated then
      UpdateBoundaries;
    InvalidateGrid;
  end;
end;

procedure TCustomGridEh.HideEdit;
begin
  if FInplaceEdit <> nil then
    try
      UpdateText;
    finally
      FInplaceCol := -1;
      FInplaceRow := -1;
      FInplaceEdit.Hide;
    end;
end;

procedure TCustomGridEh.UpdateEdit;

  procedure UpdateEditor;
  begin
    FInplaceCol := Col;
    FInplaceRow := Row;
    FInplaceEdit.UpdateContents;
    if FInplaceEdit.MaxLength = -1
      then FCanEditModify := False
      else FCanEditModify := True;
    FInplaceEdit.SelectAll;
  end;

begin
  if CanEditShow then
  begin
    if EnsureInplaceEditCreated then
      UpdateEditor
    else
    begin
      if (Col <> FInplaceCol) or (Row <> FInplaceRow) then
      begin
        HideEdit;
        UpdateEditor;
      end;
    end;
    if CanEditShow then
      FInplaceEdit.Move(CellEditRect(Col, Row));
  end else
    HideEdit;
end;

procedure TCustomGridEh.UpdateText;
begin
  if (FInplaceCol <> -1) and (FInplaceRow <> -1) then
    SetEditText(FInplaceCol, FInplaceRow, FInplaceEdit.Text);
end;

procedure TCustomGridEh.WMChar(var Msg: TWMChar);
begin
  if (goEditingEh in Options) and (CharInSetEh(Char(Msg.CharCode), [^H]) or
     (Char(Msg.CharCode) >= #32)) and CanEditModify then
    ShowEditorChar(Char(Msg.CharCode))
  else
    inherited;
end;

procedure TCustomGridEh.WMCommand(var Message: TWMCommand);
begin
  inherited;
{  with Message do
  begin
    if (FInplaceEdit <> nil) and (Ctl = FInplaceEdit.Handle) then
      case NotifyCode of
        EN_CHANGE: UpdateText;
      end
    else
      inherited;
  end;
}
end;

procedure TCustomGridEh.WMGetDlgCode(var Msg: TWMGetDlgCode);
begin
  Msg.Result := DLGC_WANTARROWS;
  if goRowSelectEh in Options then Exit;
  if goTabsEh in Options then Msg.Result := Msg.Result or DLGC_WANTTAB;
  if goEditingEh in Options then Msg.Result := Msg.Result or DLGC_WANTCHARS;
end;

procedure TCustomGridEh.WMKillFocus(var Msg: TWMKillFocus);
begin
  inherited;
//  InvalidateRect(Selection);
  InvalidateGrid;
  if (FInplaceEdit <> nil) and (Msg.FocusedWnd <> FInplaceEdit.Handle) then
    HideEdit;
end;

procedure TCustomGridEh.WMLButtonDown(var Message: TWMLButtonDown);
var
  ARect: TRect;
  GridMousePos, CellMousePos: TPoint;
begin
  inherited;
  if FInplaceEdit <> nil then FInplaceEdit.FClickTime := GetMessageTime;
  FMouseDownCell := CalcCoordFromPoint(Message.XPos, Message.YPos);
  if (FMouseDownCell.X < 0) and (FMouseDownCell.Y < 0) then
    FMouseDownCell := MouseCoord(-1, -1)
  else
  begin
    ARect := CellRect(FMouseDownCell.X, FMouseDownCell.Y);
    GridMousePos := Point(Message.XPos, Message.YPos);
    CellMousePos := Point(Message.XPos - ARect.Left, Message.YPos - ARect.Top);
    CellMouseDown(FMouseDownCell, mbLeft, KeysToShiftState(Message.Keys), ARect, GridMousePos, CellMousePos);
  end;
end;

procedure TCustomGridEh.WMRButtonDown(var Message: TWMRButtonDown);
var
  ARect: TRect;
  GridMousePos, CellMousePos: TPoint;
begin
  inherited;
  if FInplaceEdit <> nil then FInplaceEdit.FClickTime := GetMessageTime;
  FMouseDownCell := CalcCoordFromPoint(Message.XPos, Message.YPos);
  if (FMouseDownCell.X < 0) and (FMouseDownCell.Y < 0) then
    FMouseDownCell := MouseCoord(-1, -1)
  else
  begin
    ARect := CellRect(FMouseDownCell.X, FMouseDownCell.Y);
    GridMousePos := Point(Message.XPos, Message.YPos);
    CellMousePos := Point(Message.XPos - ARect.Left, Message.YPos - ARect.Top);
    CellMouseDown(FMouseDownCell, mbRight, KeysToShiftState(Message.Keys), ARect, GridMousePos, CellMousePos);
  end;
end;

procedure TCustomGridEh.WMMButtonDown(var Message: TWMMButtonDown);
var
  ARect: TRect;
  GridMousePos, CellMousePos: TPoint;
begin
  inherited;
  if FInplaceEdit <> nil then FInplaceEdit.FClickTime := GetMessageTime;
  FMouseDownCell := CalcCoordFromPoint(Message.XPos, Message.YPos);
  if (FMouseDownCell.X < 0) and (FMouseDownCell.Y < 0) then
    FMouseDownCell := MouseCoord(-1, -1)
  else
  begin
    ARect := CellRect(FMouseDownCell.X, FMouseDownCell.Y);
    GridMousePos := Point(Message.XPos, Message.YPos);
    CellMousePos := Point(Message.XPos - ARect.Left, Message.YPos - ARect.Top);
    CellMouseDown(FMouseDownCell, mbMiddle, KeysToShiftState(Message.Keys), ARect, GridMousePos, CellMousePos);
  end;
end;

procedure TCustomGridEh.WMLButtonUp(var Message: TWMLButtonUp);
var
  CellHit: TGridCoord;
  ARect: TRect;
  CheckCellMouse: Boolean;
  GridMousePos, CellMousePos: TPoint;
begin
  CheckCellMouse := CheckCellMouseClick(Message);
  inherited;
  if CheckCellMouse then
  begin
    CellHit := CalcCoordFromPoint(Message.XPos, Message.YPos);
    if (FMouseDownCell.X >= 0) and (FMouseDownCell.Y >= 0) and
      (FMouseDownCell.X = CellHit.X) and (FMouseDownCell.Y = CellHit.Y) then
    begin
      ARect := CellRect(CellHit.X, CellHit.Y);
      GridMousePos := Point(Message.XPos, Message.YPos);
      CellMousePos := Point(Message.XPos - ARect.Left, Message.YPos - ARect.Top);
      CellMouseClick(CellHit, mbLeft, KeysToShiftState(Message.Keys), ARect, GridMousePos, CellMousePos);
    end;
  end;
end;

procedure TCustomGridEh.WMRButtonUp(var Message: TWMRButtonUp);
var
  CellHit: TGridCoord;
  ARect: TRect;
  CheckCellMouse: Boolean;
  GridMousePos, CellMousePos: TPoint;
begin
  CheckCellMouse := CheckCellMouseClick(Message);
  inherited;
  if CheckCellMouse then
  begin
    CellHit := CalcCoordFromPoint(Message.XPos, Message.YPos);
    if (FMouseDownCell.X >= 0) and (FMouseDownCell.Y >= 0) and
      (FMouseDownCell.X = CellHit.X) and (FMouseDownCell.Y = CellHit.Y) then
    begin
      ARect := CellRect(CellHit.X, CellHit.Y);
      GridMousePos := Point(Message.XPos, Message.YPos);
      CellMousePos := Point(Message.XPos - ARect.Left, Message.YPos - ARect.Top);
      CellMouseClick(CellHit, mbRight, KeysToShiftState(Message.Keys), ARect, GridMousePos, CellMousePos);
    end;
  end;
end;

procedure TCustomGridEh.WMMButtonUp(var Message: TWMMButtonUp);
var
  CellHit: TGridCoord;
  ARect: TRect;
  CheckCellMouse: Boolean;
  GridMousePos, CellMousePos: TPoint;
begin
  CheckCellMouse := CheckCellMouseClick(Message);
  inherited;
  if CheckCellMouse then
  begin
    CellHit := CalcCoordFromPoint(Message.XPos, Message.YPos);
    if (FMouseDownCell.X >= 0) and (FMouseDownCell.Y >= 0) and
      (FMouseDownCell.X = CellHit.X) and (FMouseDownCell.Y = CellHit.Y) then
    begin
      ARect := CellRect(CellHit.X, CellHit.Y);
      GridMousePos := Point(Message.XPos, Message.YPos);
      CellMousePos := Point(Message.XPos - ARect.Left, Message.YPos - ARect.Top);
      CellMouseClick(CellHit, mbMiddle, KeysToShiftState(Message.Keys), ARect, GridMousePos, CellMousePos);
    end;
  end;
end;

procedure TCustomGridEh.WMLButtonDblClk(var Message: TWMLButtonDblClk);
var
  CellHit: TGridCoord;
  ARect: TRect;
  CheckCellMouse: Boolean;
  ShiftState: TShiftState;
  GridMousePos, CellMousePos: TPoint;
begin
  CheckCellMouse := CheckCellMouseClick(Message);
  inherited;
  if CheckCellMouse then
  begin
    CellHit := CalcCoordFromPoint(Message.XPos, Message.YPos);
    if (FMouseDownCell.X >= 0) and (FMouseDownCell.Y >= 0) and
      (FMouseDownCell.X = CellHit.X) and (FMouseDownCell.Y = CellHit.Y) then
    begin
      ARect := CellRect(CellHit.X, CellHit.Y);
      ShiftState := KeysToShiftState(Message.Keys);
      Include(ShiftState, ssDouble);
      GridMousePos := Point(Message.XPos, Message.YPos);
      CellMousePos := Point(Message.XPos - ARect.Left, Message.YPos - ARect.Top);
      CellMouseClick(CellHit, mbLeft, ShiftState, ARect, GridMousePos, CellMousePos);
    end;
  end;
end;

procedure TCustomGridEh.WMRButtonDblClk(var Message: TWMRButtonDblClk);
var
  CellHit: TGridCoord;
  ARect: TRect;
  CheckCellMouse: Boolean;
  ShiftState: TShiftState;
  GridMousePos, CellMousePos: TPoint;
begin
  CheckCellMouse := CheckCellMouseClick(Message);
  inherited;
  if CheckCellMouse then
  begin
    CellHit := CalcCoordFromPoint(Message.XPos, Message.YPos);
    if (FMouseDownCell.X >= 0) and (FMouseDownCell.Y >= 0) and
      (FMouseDownCell.X = CellHit.X) and (FMouseDownCell.Y = CellHit.Y) then
    begin
      ARect := CellRect(CellHit.X, CellHit.Y);
      ShiftState := KeysToShiftState(Message.Keys);
      Include(ShiftState, ssDouble);
      GridMousePos := Point(Message.XPos, Message.YPos);
      CellMousePos := Point(Message.XPos - ARect.Left, Message.YPos - ARect.Top);
      CellMouseClick(CellHit, mbRight, ShiftState, ARect, GridMousePos, CellMousePos);
    end;
  end;
end;

procedure TCustomGridEh.WMMButtonDblClk(var Message: TWMMButtonDblClk);
var
  CellHit: TGridCoord;
  ARect: TRect;
  CheckCellMouse: Boolean;
  ShiftState: TShiftState;
  GridMousePos, CellMousePos: TPoint;
begin
  CheckCellMouse := CheckCellMouseClick(Message);
  inherited;
  if CheckCellMouse then
  begin
    CellHit := CalcCoordFromPoint(Message.XPos, Message.YPos);
    if (FMouseDownCell.X >= 0) and (FMouseDownCell.Y >= 0) and
      (FMouseDownCell.X = CellHit.X) and (FMouseDownCell.Y = CellHit.Y) then
    begin
      ARect := CellRect(CellHit.X, CellHit.Y);
      ShiftState := KeysToShiftState(Message.Keys);
      Include(ShiftState, ssDouble);
      GridMousePos := Point(Message.XPos, Message.YPos);
      CellMousePos := Point(Message.XPos - ARect.Left, Message.YPos - ARect.Top);
      CellMouseClick(CellHit, mbMiddle, ShiftState, ARect, GridMousePos, CellMousePos);
    end;
  end;
end;

procedure TCustomGridEh.WMNCHitTest(var Msg: TWMNCHitTest);
begin
  DefaultHandler(Msg);
  FHitTest := ScreenToClient(SmallPointToPoint(Msg.Pos));
end;

procedure TCustomGridEh.WMNCMouseMove(var Message: TWMMouseMove);
{$IFNDEF FPC}
var
  CurPos: TPoint;
{$ENDIF}
begin
  inherited;
{$IFNDEF FPC}

  if not (csNoStdEvents in ControlStyle) then
  begin
    with Message do
      if (Width > 32768) or (Height > 32768) then
        CurPos := CalcCursorPos
      else
      begin
        CurPos.X := Pos.x;
        CurPos.Y := Pos.y;
      end;
    UpdateHotTackInfo(CurPos.X, CurPos.Y);
  end;
{$ENDIF}
end;

//{$IFNDEF FPC}
procedure TCustomGridEh.WMSetCursor(var Msg: TWMSetCursor);
var
  State: TGridStateEh;
  Index: Longint;
  Pos, Ofs: Integer;
  Cur: HCURSOR;
begin
  Cur := 0;
  with Msg do
  begin
    if HitTest = HTCLIENT then
    begin
      if FGridState = gsNormalEh then
      begin
        CalcSizingState(FHitTest.X, FHitTest.Y, State, Index, Pos, Ofs);
      end else
        State := FGridState;
      if State = gsRowSizingEh then
        Cur := Screen.Cursors[crVSplit]
      else if State = gsColSizingEh then
        Cur := Screen.Cursors[crHSplit]
    end;
  end;
  if Cur <> 0 then
  begin
     Windows.SetCursor(Cur);
{$IFDEF FPC}
     Msg.Result := 1;
{$ENDIF}
  end else
    inherited;
end;
//{$ENDIF}

procedure TCustomGridEh.WMSetFocus(var Msg: TWMSetFocus);
begin
  inherited;
  if (FInplaceEdit = nil) or (Msg.FocusedWnd <> FInplaceEdit.Handle) then
  begin
//    InvalidateRect(Selection);
    Invalidate;
    UpdateEdit;
  end;
end;

function TCustomGridEh.NeedBufferedPaint: Boolean;
begin
  Result := False;
end;

procedure TCustomGridEh.WndProc(var Message: TMessage);
var
  OldControlStyle: TControlStyle;
  AWMMouse: TWMMouse;
begin
  OldControlStyle := ControlStyle;
  case Message.Msg of
    WM_LBUTTONDBLCLK, WM_RBUTTONDBLCLK, WM_MBUTTONDBLCLK:
    begin
{$IFDEF CIL}
{$ELSE}
      AWMMouse.Msg := Message.Msg;
      AWMMouse.Keys := Message.wParam;
      AWMMouse.XPos := Message.lParamlo;
      AWMMouse.YPos := Message.lParamhi;
      if not WMCheckCanSendDoubleClicks(AWMMouse) then
        ControlStyle := ControlStyle - [csDoubleClicks];
{$ENDIF}
    end;
  end;
  try
    inherited WndProc(Message);
  finally
    if OldControlStyle <> ControlStyle then
      ControlStyle := OldControlStyle;
  end;
end;

procedure TCustomGridEh.CancelMode;
begin
  try
    case FGridState of
      gsSelectingEh:
        KillTimer(Handle, 1);
      gsRowSizingEh, gsColSizingEh:
        begin
          DrawSizingLine;
        end;
      gsColMovingEh, gsRowMovingEh:
        begin
//          DrawMove;
          HideMove;
          KillTimer(Handle, 1);
        end;
    end;
  finally
    FGridState := gsNormalEh;
  end;
end;

procedure TCustomGridEh.WMCancelMode(var Msg: TWMCancelMode);
begin
  inherited;
  CancelMode;
end;

{$IFNDEF FPC}
procedure TCustomGridEh.CMCancelMode(var Msg: TCMCancelMode);
{$IFDEF CIL}
var
  OrigMsg: TMessage;
{$ENDIF}
begin
  if Assigned(FInplaceEdit) then
{$IFDEF CIL}
  begin
    OrigMsg := Msg.OriginalMessage;
    FInplaceEdit.WndProc(OrigMsg);
  end;
{$ELSE}
    FInplaceEdit.WndProc(TMessage(Msg));
{$ENDIF}
  inherited;
  CancelMode;
end;
{$ENDIF}

procedure TCustomGridEh.CMFontChanged(var Message: TMessage);
begin
  if FInplaceEdit <> nil then FInplaceEdit.Font := Font;
  inherited;
end;

{$IFNDEF FPC}
procedure TCustomGridEh.CMCtl3DChanged(var Message: TMessage);
begin
  inherited;
  RecreateWndHandle;
end;
{$ENDIF}

procedure TCustomGridEh.CMDesignHitTest(var Msg: TCMDesignHitTest);
begin
  Msg.Result := LRESULT(BOOL(Sizing(Msg.Pos.X, Msg.Pos.Y)));
end;

procedure TCustomGridEh.CMWantSpecialKey(var Msg: TCMWantSpecialKey);
begin
  inherited;
  if (goEditingEh in Options) and (Char(Msg.CharCode) = #13) then Msg.Result := 1;
end;

procedure TCustomGridEh.CMMouseLeave(var Message: TMessage);
var
  MousePos: TPoint;
begin
  inherited;
  MousePos := ScreenToClient(SafeGetMouseCursorPos);
  UpdateHotTackInfo(MousePos.X, MousePos.Y);
end;

{$IFDEF EH_LIB_16}
procedure TCustomGridEh.CMStyleChanged(var Message: TMessage);
begin
  ClearButtonsBitmapCache;
  SetInternalColors;
end;
{$ENDIF}

procedure TCustomGridEh.TimedScroll(Direction: TGridScrollDirection);
var
  MaxAnchor, NewAnchor: TGridCoord;
begin
  NewAnchor := FAnchorCell;
  MaxAnchor.X := ColCount - 1;
  MaxAnchor.Y := RowCount - 1;
  if (sdLeft in Direction) and (FAnchorCell.X > FixedColCount) then Dec(NewAnchor.X);
  if (sdRight in Direction) and (FAnchorCell.X < MaxAnchor.X) then Inc(NewAnchor.X);
  if (sdUp in Direction) and (FAnchorCell.Y > FixedRowCount) then Dec(NewAnchor.Y);
  if (sdDown in Direction) and (FAnchorCell.Y < MaxAnchor.Y) then Inc(NewAnchor.Y);
  if (FAnchorCell.X <> NewAnchor.X) or (FAnchorCell.Y <> NewAnchor.Y) then
    MoveAnchorCell(NewAnchor.X, NewAnchor.Y, True);
end;

procedure TCustomGridEh.WMTimer(var Msg: TWMTimer);
var
  APoint: TPoint;
  ScrollDirection: TGridScrollDirection;
  CellHit: TGridCoord;
  LeftSide: Integer;
  RightSide: Integer;
  OldLeftCol, OldHorzSmoothPos: Integer;

  procedure ResetScrollTimer(Mouse, CellHit: Integer;
    Axis: TGridAxisDataEh; ScrollBar: Integer; const MousePt: TPoint);
  var
    Distance, MaxSize, Delay: Integer;
    ScreenPt, ScreenBrd: TPoint;
  begin
    if FMovePos >= Axis.FixedCelCount then
    begin
      if Mouse < Axis.FixedBoundary then
      begin
        ScreenPt := ClientToScreen(MousePt);
        ScreenBrd := ClientToScreen(Point(Axis.FixedBoundary, MousePt.Y));
        MaxSize := ScreenBrd.X;
        if MaxSize > 200 then
          MaxSize := 200;
        Distance := ScreenBrd.X - ScreenPt.X;
        if Distance > MaxSize then
          Distance := MaxSize;
        if (Distance <= 10)
          then Distance := 1
          else Distance := Distance - 10;
        Delay := 60 + Trunc( MaxSize / Distance * 1.5);
//        Delay := Trunc( MaxSize / Distance * 1.5 / 10);
        SetTimer(Handle, 1, Delay, nil);
        Exit;
      end else if (Mouse < Axis.ContraStart) and
         ( (OldLeftCol < LeftCol) or (OldHorzSmoothPos < HorzAxis.RolStartVisPos) ) then
      begin
        Delay := 60 + Trunc(200 * 1.5);
        SetTimer(Handle, 1, Delay, nil);
        Exit;
      end else if Mouse > Axis.ContraStart then
      begin
        ScreenPt := ClientToScreen(MousePt);
        ScreenBrd := ClientToScreen(Point(Axis.ContraStart, MousePt.Y));
        MaxSize := Screen.DesktopWidth - ScreenBrd.X;
        if MaxSize > 200 then
          MaxSize := 200;
        Distance := ScreenPt.X - ScreenBrd.X;
        if Distance > MaxSize then
          Distance := MaxSize;
        if (Distance <= 10)
          then Distance := 1
          else Distance := Distance - 10;
        Delay := 60 + Trunc( MaxSize / Distance * 1.5);
//        Delay := Trunc( MaxSize / Distance * 1.5 / 10);
        SetTimer(Handle, 1, Delay, nil);
        Exit;
      end
    end;
    SetTimer(Handle, 1, 60, nil);
  end;


begin
  if not (FGridState in [gsSelectingEh, gsRowMovingEh, gsColMovingEh]) then Exit;
  GetCursorPos(APoint);
  APoint := ScreenToClient(APoint);
  ScrollDirection := [];
  begin
    CellHit := CalcCoordFromPoint(APoint.X, APoint.Y);
    case FGridState of
      gsColMovingEh:
        begin
          OldLeftCol := LeftCol;
          OldHorzSmoothPos := HorzAxis.RolStartVisPos;
          MoveAndScroll(APoint.X, CellHit.X, HorzAxis, SB_HORZ, APoint);
          ResetScrollTimer(APoint.X, CellHit.X, HorzAxis, SB_HORZ, APoint);
        end;
      gsRowMovingEh:
        MoveAndScroll(APoint.Y, CellHit.Y, VertAxis, SB_VERT, APoint);
      gsSelectingEh:
      begin
        if not UseRightToLeftAlignment then
        begin
          if APoint.X < HorzAxis.FixedBoundary then
            Include(ScrollDirection, sdLeft)
          else if APoint.X > HorzAxis.ContraStart then
            Include(ScrollDirection, sdRight);
        end else
        begin
          LeftSide := ClientWidth - HorzAxis.ContraStart;
          RightSide := ClientWidth - HorzAxis.FixedBoundary;
          if APoint.X < LeftSide then Include(ScrollDirection, sdRight)
          else if APoint.X > RightSide then Include(ScrollDirection, sdLeft);
        end;
        if APoint.Y < VertAxis.FixedBoundary then
          Include(ScrollDirection, sdUp)
        else if APoint.Y > VertAxis.ContraStart then
          Include(ScrollDirection, sdDown);
        if ScrollDirection <> [] then  TimedScroll(ScrollDirection);
      end;
    end;
  end;
end;

procedure TCustomGridEh.ColWidthsChanged;
begin
//  UpdateScrollRange;
  if RolSizeValid then
    UpdateEdit;
end;

procedure TCustomGridEh.RowHeightsChanged;
begin
//  UpdateScrollRange;
  if RolSizeValid then
    UpdateEdit;
end;

procedure TCustomGridEh.DeleteColumn(ACol: Longint);
begin
  MoveColumn(ACol, FullColCount-1);
  ColCount := ColCount - 1;
end;

procedure TCustomGridEh.DeleteRow(ARow: Longint);
//var
//  CurRow: Integer;
begin
  LockPaint;
  try
//    if (Row = ARow) and (ARow > 0) then
//    if ARow = RowCount-1 then
//      Row := Row - 1;
//    CurRow := Row;
//    MoveRow(ARow, FullRowCount - 1);
//    Row := CurRow;
//    RowCount := RowCount - 1;
    VertAxis.DeleteRolCels(ARow-VertAxis.FixedCelCount, 1);
  finally
    UnlockPaint;
  end;
end;

procedure TCustomGridEh.UpdateDesigner;
var
  ParentForm: TCustomForm;
begin
  if (csDesigning in ComponentState) and HandleAllocated and
    not (csUpdating in ComponentState) then
  begin
    ParentForm := GetParentForm(Self);
    if Assigned(ParentForm) and Assigned(ParentForm.Designer) then
      ParentForm.Designer.Modified;
  end;
end;

function TCustomGridEh.DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  Result := DoMouseWheelDownEvent(Shift, MousePos);
  if not Result then
  begin
    if IsSmoothVertScroll then
    begin
      if ssCtrl in Shift then
        SetTopPos(RolStartVisPosY + VertAxis.RolClientLen)
      else
        SetTopPos(RolStartVisPosY + GetVertScrollStep);
    end else
    begin
      if ssCtrl in Shift then
        if VertAxis.RolLastFullVisCel = VertAxis.RolLastVisCel
          then VertAxis.SafeSetRolStartVisCel(VertAxis.RolLastVisCel + 1, sstByCellEh)
          else VertAxis.SafeSetRolStartVisCel(VertAxis.RolLastVisCel, sstByCellEh)
      else
        VertAxis.SafeSetRolStartVisCel(VertAxis.RolStartVisCel+1, sstByCellEh);
    end;
    Result := True;
  end;
end;

function TCustomGridEh.DoMouseWheelDownEvent(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  Result := False;
  if Assigned(OnMouseWheelDown) then
    OnMouseWheelDown(Self, Shift, MousePos, Result);
end;

function TCustomGridEh.DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean;
var
  NewCell, NewCelOffset: Integer;
begin
  Result := DoMouseWheelUpEvent(Shift, MousePos);
  if not Result then
  begin
    if IsSmoothVertScroll then
    begin
      if ssCtrl in Shift then
        SetTopPos(RolStartVisPosY - VertAxis.RolClientLen)
      else
        SetTopPos(RolStartVisPosY - GetVertScrollStep);
    end else
    begin
      if ssCtrl in Shift then
      begin
        VertAxis.RolCellAtPos(VertAxis.RolStartVisPos-VertAxis.RolClientLen, NewCell, NewCelOffset);
        if NewCelOffset > 0 then
          Inc(NewCell);
        VertAxis.SafeSetRolStartVisCel(NewCell);
      end else
        if VertAxis.RolStartVisCelOfst > 0
          then VertAxis.SafeSetRolStartVisCel(VertAxis.RolStartVisCel)
          else VertAxis.SafeSetRolStartVisCel(VertAxis.RolStartVisCel-1);
    end;
    Result := True;
  end;
end;

function TCustomGridEh.DoMouseWheelUpEvent(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  Result := False;
  if Assigned(OnMouseWheelUp) then
    OnMouseWheelUp(Self, Shift, MousePos, Result);
end;

function TCustomGridEh.CheckColumnDrag(var Origin,
  Destination: Integer; const MousePt: TPoint): Boolean;
begin
  Result := True;
end;

function TCustomGridEh.CheckRowDrag(var Origin,
  Destination: Integer; const MousePt: TPoint): Boolean;
begin
  Result := True;
end;

function TCustomGridEh.CheckBeginColumnDrag(var Origin, Destination: Integer; const MousePt: TPoint): Boolean;
begin
  Result := True;
end;

function TCustomGridEh.CheckBeginRowDrag(var Origin, Destination: Integer; const MousePt: TPoint): Boolean;
begin
  Result := True;
end;

procedure TCustomGridEh.StartColMoving(ColIndex: Integer; X, Y: Integer);
var
  CellHit: TGridCoord;
  R: TRect;

  function SkipHidenCells(AIndex: Integer): Integer;
  var
    i: Integer;
  begin
    Result := 0;
    for i := AIndex to ColCount-1  do
    begin
      if ColWidths[i] > 0 then Exit;
      Inc(Result);
    end;
  end;

begin
  FMoveIndex := ColIndex;
  CellHit := CalcCoordFromPoint(X, Y);
  R := CellRect(CellHit.X, 0);
  FMovePos := CellHit.X;
  if (CellHit.X = -1) and (X > HorzAxis.RolInClientBoundary) then
    FMovePos := HorzAxis.CelCount - 1
  else if CellHit.X < HorzAxis.RolStartVisCel + HorzAxis.FixedCelCount then
    FMovePos := HorzAxis.RolStartVisCel + HorzAxis.FixedCelCount;

  if (FGridState = gsColMovingEh) and
     (ColWidths[FMoveIndex] <= 0) and
     (CellHit.X = FMoveIndex + 1 + SkipHidenCells(FMoveIndex + 1)) and
     (R.Left + (ColWidths[CellHit.X] div 2) > X)
  then
    FMovePosRightSite := False
  else if FMovePos > FMoveIndex then
    FMovePosRightSite := True
  else
    FMovePosRightSite := False;

//  if CheckBeginColumnDrag(FMoveIndex, FMovePos, Point(X,Y)) then
//  begin
    FGridState := gsColMovingEh;
    Update;
    DrawMove;
//    MoveDrawn := True;
    SetTimer(Handle, 1, 60, nil);
//  end;
end;

procedure TCustomGridEh.StartRowDrag(StartRow: Integer; const MousePt: TPoint);
begin
  FMoveIndex := StartRow;
  FMovePos := FMoveIndex;
  FGridState := gsRowMovingEh;
  Update;
  DrawMove;
  SetTimer(Handle, 1, 60, nil);
end;

function TCustomGridEh.EmptyColWidth: Integer;
begin
  if [goFixedVertLineEh, goVertLineEh] * Options <> []
    then Result := -1
    else Result := 0;
end;

function TCustomGridEh.EmptyRowHeight: Integer;
begin
  if [goFixedHorzLineEh, goHorzLineEh] * Options <> []
    then Result := -1
    else Result := 0;
end;

function TCustomGridEh.EndColumnDrag(var Origin, Destination: Integer; const MousePt: TPoint): Boolean;
begin
  Result := True;
  if (Destination > Origin) and not FMovePosRightSite then
    Dec(Destination);
end;

function TCustomGridEh.EndRowDrag(var Origin, Destination: Integer; const MousePt: TPoint): Boolean;
begin
  Result := True;
end;

procedure TCustomGridEh.CMShowingChanged(var Message: TMessage);
begin
  inherited;
//  if Showing then UpdateScrollRange;
end;

procedure TCustomGridEh.SetFlat(const Value: Boolean);
begin
  if FFlat <> Value then
  begin
    FFlat := Value;
    UpdateFixedLineColor;
    FlatChanged;
    Invalidate;
  end;
end;

procedure TCustomGridEh.UpdateFixedLineColor;
begin
  if Flat
    then FFixedLineColor := clGray
    else FFixedLineColor := clBlack;
end;

function TCustomGridEh.GetFrozenColCount: Longint;
begin
  Result := HorzAxis.FrozenCelCount;
end;

procedure TCustomGridEh.SetFrozenColCount(const Value: Longint);
begin
  HorzAxis.FrozenCelCount := Value;
end;

procedure TCustomGridEh.SetFrozenRowCount(const Value: Longint);
begin
  VertAxis.FrozenCelCount := Value;
end;

function TCustomGridEh.GetFrozenRowCount: Longint;
begin
  Result := VertAxis.FrozenCelCount;
end;

function TCustomGridEh.CreateGridLineColors: TGridLineColorsEh;
begin
  Result := TGridLineColorsEh.Create(Self);
end;

procedure TCustomGridEh.DrawEdgeEh(ACanvas: TCanvas; qrc: TRect;
  IsDown, IsSelected: Boolean; NeedLeft, NeedRight: Boolean);
var
  ThreeDLine: Integer;
  TopLeftFlag, BottomRightFlag: Integer;
begin
  TopLeftFlag := BF_TOPLEFT;
  BottomRightFlag := BF_BOTTOMRIGHT;
  if UseRightToLeftAlignment then
  begin
    WindowsLPtoDP(Canvas.Handle, qrc);
    SwapInteger(qrc.Left, qrc.Right);
    ChangeGridOrientation(False);
    TopLeftFlag := BF_TOPRIGHT;
    BottomRightFlag := BF_BOTTOMLEFT;
  end;

  if Flat then
  begin
    if IsSelected or IsDown
      then ThreeDLine := BDR_SUNKENINNER
      else ThreeDLine := BDR_RAISEDINNER;

    Canvas.Pen.Color := Canvas.Brush.Color;
    if UseRightToLeftAlignment then
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
    if IsSelected or IsDown
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
  if UseRightToLeftAlignment then ChangeGridOrientation(True);
end;

procedure TCustomGridEh.FlatChanged;
begin

end;

function TCustomGridEh.ResizeLine(Axis: TGridAxisDataEh): Integer;
var
  I: Integer;
begin
  if FSizingIndex >= Axis.CelCount then
  begin
    Result := Axis.ContraStart;
    for I := Axis.CelCount to FSizingIndex do
      Inc(Result, Axis.CelLens[I]);
    Result := Result - FSizingPos;
  end else
  begin
    if FSizingIndex < Axis.FixedCelCount then
    begin
      Result := 0;
      for I := 0 to FSizingIndex - 1 do
        Inc(Result, Axis.CelLens[I]);
    end else
    begin
      Result := Axis.FixedBoundary - Axis.RolStartVisCelOfst;
      for I := Axis.StartVisCel to FSizingIndex - 1 do
        Inc(Result, Axis.CelLens[I]);
    end;
    Result := FSizingPos - Result;
  end;
end;

procedure TCustomGridEh.DrawPolyPolyline(PointsList: TPointArray;
  StrokeList: TDWORDArray; VCount: Integer);
var
  i: Integer;
begin
  if UseRightToLeftAlignment then
  begin
    for i := 0 to VCount-1 do
    begin
      PointsList[i].X := PointsList[i].X + 1;
    end;
  end;
{$IFDEF CIL}
  PolyPolyLine(Canvas.Handle, PointsList, StrokeList, VCount shr 1);
{$ELSE}
  PolyPolyLine(Canvas.Handle, Pointer(PointsList)^, Pointer(StrokeList)^, VCount shr 1);
{$ENDIF}
end;

procedure TCustomGridEh.FillGradient(Canvas: TCanvas;
  ARect: TRect; FromColor, ToColor: TColor);
begin
  if UseRightToLeftAlignment and (ARect.Left+1 = ARect.Right) then
  begin
    Inc(ARect.Left);
    Inc(ARect.Right);
  end;
  FillGradientEh(Canvas, ARect, FromColor, ToColor);
end;

procedure TCustomGridEh.DrawPolyline(Points: array of TPoint);
var
  i: Integer;
begin
  if UseRightToLeftAlignment then
  begin
    for i := 0 to Length(Points)-1 do
    begin
      Points[i].X := Points[i].X + 1;
    end;
  end;
  Canvas.Polyline(Points);
end;

procedure TCustomGridEh.DrawWideLine(X1, Y1, X2, Y2, Width: Integer);
var
  i: Integer;
  Points: TPointArray;
  StrokeList: TDWORDArray;
  YDelta, XDelta: Integer;
begin
  SetLength(Points, 2*Width);
  SetLength(StrokeList, 2);
  StrokeList[0] := 2;
  StrokeList[1] := 2;
  if X1 <> X2
    then YDelta := 1
    else YDelta := 0;
  if Y1 <> Y2
    then XDelta := 1
    else XDelta := 0;
  for i := 0 to Width-1 do
  begin
    Points[i*2].X := X1 + i*XDelta;
    Points[i*2].Y := Y1 + i*YDelta;
    Points[i*2+1].X := X2 + i*XDelta;
    Points[i*2+1].Y := Y2 + i*YDelta;
  end;
  DrawPolyPolyline(Points, StrokeList, 2 * Width);

//  DrawPolyline(Points);
end;

procedure TCustomGridEh.UpdateScrollBars;
var
  APosition, AMin, AMax, APageSize: Integer;
begin
//  FHorzAxis.GetLastVisibleCell(FHorzAxis.FRolLastVisCel, FHorzAxis.FRolLastFullVisCel);
//  FVertAxis.GetLastVisibleCell(FVertAxis.FRolLastVisCel, FVertAxis.FRolLastFullVisCel);

  HorzScrollBar.GetScrollBarParams(APosition, AMin, AMax, APageSize);
  GetDataForHorzScrollBar(APosition, AMin, AMax, APageSize);
  HorzScrollBar.SetParams(APosition, AMin, AMax, APageSize);

  VertScrollBar.GetScrollBarParams(APosition, AMin, AMax, APageSize);
  GetDataForVertScrollBar(APosition, AMin, AMax, APageSize);
  VertScrollBar.SetParams(APosition, AMin, AMax, APageSize);

  UpdateScrollBarPanels;
end;

procedure TCustomGridEh.GetDataForHorzScrollBar(var APosition, AMin, AMax, APageSize: Integer);
begin
  APosition := HorzAxis.RolStartVisPos;
  AMin := 0;
  if HorzAxis.RolLen > 0
    then AMax := HorzAxis.RolLen-1
    else AMax := 0;
  APageSize := HorzAxis.RolClientLen;
  if UseRightToLeftAlignment then
    APosition := APosition + APageSize;
end;

procedure TCustomGridEh.GetDataForVertScrollBar(var APosition, AMin, AMax, APageSize: Integer);
begin
  APosition := VertAxis.RolStartVisPos;
  AMin := 0;
  AMax := VertAxis.RolLen-1;
  APageSize := VertAxis.RolClientLen;
end;

function TCustomGridEh.CreateHorzScrollBarPanelControl: TGridScrollBarPanelControlEh;
begin
  Result := TGridScrollBarPanelControlEh.Create(Self, sbHorizontal);
end;

function TCustomGridEh.CreateVertScrollBarPanelControl: TGridScrollBarPanelControlEh;
begin
  Result := TGridScrollBarPanelControlEh.Create(Self, sbVertical);
end;

function TCustomGridEh.CreateSizeGripPanel: TSizeGripPanelEh;
begin
  Result := TSizeGripPanelEh.Create(Self);
end;

procedure TCustomGridEh.UpdateScrollBarPanels;
var
  SHeight, SWidth, SizeGripWidth, SizeGripHeight: Integer;
  SBLeftStartOffset: Integer;
  SBTopStartOffset: Integer;
  AScrollBarShowingChanged: Boolean;
begin
  if not HandleAllocated then Exit;

  if VertScrollBar.IsScrollBarShowing
    then SWidth := VertScrollBar.ActualSize
    else SWidth := 0;

  if HorzScrollBar.IsScrollBarShowing
    then SHeight := HorzScrollBar.ActualSize
    else SHeight := 0;

//  OutBoundaryData.RightIndent := SWidth;
//  OutBoundaryData.BottomIndent := SHeight;

  SBLeftStartOffset := 0;
  SBTopStartOffset := 0;
  if SizeGripPostion = sgpBottomRight then
  begin
    FExtraSizeGripControl.Visible := False;
    if SizeGripAlwaysShow
      then FCornerScrollBarPanelControl.GripActiveStatus := gasAlwaysEh
      else FCornerScrollBarPanelControl.GripActiveStatus := gasAutoEh;
    if not UseRightToLeftAlignment and
       (((SHeight > 0) and (SWidth > 0)) or SizeGripAlwaysShow) then
    begin
      SizeGripWidth := VertScrollBar.ActualSize;
      SizeGripHeight := HorzScrollBar.ActualScrollBarBoxSize;
    end else
    begin
      SizeGripWidth := 0;
      SizeGripHeight := 0;
    end;
  end else
  begin
    SizeGripWidth := 0;
    SizeGripHeight := 0;
    FCornerScrollBarPanelControl.GripActiveStatus := gasNeverEh;
    if SizeGripPostion = sgpTopLeft then
    begin
      FExtraSizeGripControl.SetBounds(0, 0, HorzScrollBar.ActualSize, VertScrollBar.ActualSize);
      FExtraSizeGripControl.TriangleWindow := True;
    end else if SizeGripPostion = sgpTopRight then
    begin
      SBTopStartOffset := VertScrollBar.ActualSize;
      FExtraSizeGripControl.SetBounds(ClientWidth - HorzScrollBar.ActualSize, 0, HorzScrollBar.ActualSize, VertScrollBar.ActualSize);
      FExtraSizeGripControl.TriangleWindow := (SWidth = 0);
    end else //sgpBottomLeft
    begin
      SBLeftStartOffset := VertScrollBar.ActualSize;
      FExtraSizeGripControl.SetBounds(0, ClientHeight - VertScrollBar.ActualSize, HorzScrollBar.ActualSize, VertScrollBar.ActualSize);
      FExtraSizeGripControl.TriangleWindow := (SHeight = 0);
      if UseRightToLeftAlignment and
         (((SHeight > 0) and (SWidth > 0)) or SizeGripAlwaysShow) then
      begin
        SizeGripWidth := VertScrollBar.ActualSize;
        SizeGripHeight := HorzScrollBar.ActualScrollBarBoxSize;
        FExtraSizeGripControl.TriangleWindow := (SWidth = 0);
      end;
    end;
    FExtraSizeGripControl.GripActiveStatus := gasAlwaysEh;
    FExtraSizeGripControl.Position := SizeGripPostion;
    FExtraSizeGripControl.Visible := True;
  end;

  if UseRightToLeftAlignment then
  begin
    FVertScrollBarPanelControl.SetBounds(0, 0, SWidth, ClientHeight - SizeGripHeight - SHeight);
    FHorzScrollBarPanelControl.SetBounds(SWidth, ClientHeight - SHeight,
      ClientWidth - SWidth, SHeight);
    FCornerScrollBarPanelControl.SetBounds(0, ClientHeight - SHeight, SWidth, SHeight);
  end else
  begin
    FVertScrollBarPanelControl.SetBounds(ClientWidth - SWidth, SBTopStartOffset, SWidth, ClientHeight - SizeGripHeight - SBTopStartOffset);
    FHorzScrollBarPanelControl.SetBounds(SBLeftStartOffset, ClientHeight - SHeight, ClientWidth - SizeGripWidth - SBTopStartOffset, SHeight);
    FCornerScrollBarPanelControl.SetBounds(ClientWidth - SizeGripWidth, ClientHeight - SizeGripHeight, SizeGripWidth, SizeGripHeight);
  end;

  FVertScrollBarPanelControl.Visible := True;
  FVertScrollBarPanelControl.KeepMaxSizeInDefault := VertScrollBar.IsKeepMaxSizeInDefault;

  FHorzScrollBarPanelControl.Visible := True;
  FHorzScrollBarPanelControl.KeepMaxSizeInDefault := HorzScrollBar.IsKeepMaxSizeInDefault;

  FCornerScrollBarPanelControl.Visible := True;
  FCornerScrollBarPanelControl.TriangleWindow := (SHeight = 0) and (SWidth = 0) and SizeGripAlwaysShow;

  AScrollBarShowingChanged := False;
  if FVertScrollBarIsShowing <> VertScrollBar.IsScrollBarShowing then
  begin
    FVertScrollBarIsShowing := VertScrollBar.IsScrollBarShowing;
    AScrollBarShowingChanged := True;
  end;

  if FHorzScrollBarIsShowing <> HorzScrollBar.IsScrollBarShowing then
  begin
    FHorzScrollBarIsShowing := HorzScrollBar.IsScrollBarShowing;
    AScrollBarShowingChanged := True;
  end;
  if AScrollBarShowingChanged then
    ScrollBarShowingChanged;
end;

function TCustomGridEh.CreateScrollBar(AKind: TScrollBarKind): TGridScrollBarEh;
begin
  Result := TGridScrollBarEh.Create(Self, AKind)
end;

procedure TCustomGridEh.Loaded;
begin
  inherited Loaded;
  UpdateBoundaries;
end;

procedure TCustomGridEh.LockPaint;
begin
  Inc(FLockPaint);
end;

procedure TCustomGridEh.UnlockPaint;
begin
  if FLockPaint > 0 then
    Dec(FLockPaint);
end;

function TCustomGridEh.PaintLocked: Boolean;
begin
  Result := (FLockPaint > 0);
end;

procedure TCustomGridEh.OutBoundaryDataChanged;
begin
  UpdateBoundaries;
end;

procedure TCustomGridEh.SetGridLineColors(const Value: TGridLineColorsEh);
begin
  FGridLineColors.Assign(Value);
end;

function TCustomGridEh.HorzScotllingLockCount: Integer;
begin
  Result := FHorzScotllingLockCount;
end;

procedure TCustomGridEh.LockGridHorzScotlling;
begin
  Inc(FHorzScotllingLockCount);
end;

procedure TCustomGridEh.UnlockGridHorzScotlling;
begin
  Dec(FHorzScotllingLockCount);
end;

{procedure TCustomGridEh.RolSizeInvalidated;
begin
  FastInvalidate;
end;
}

procedure TCustomGridEh.RolSizeUpdated;
begin
  UpdateBoundaries;
end;

procedure TCustomGridEh.CheckUpdateAxises;
begin
  HorzAxis.CheckUpdateRolCelPosArr;
  VertAxis.CheckUpdateRolCelPosArr;
end;

procedure TCustomGridEh.RolPosAxisChanged(Axis: TGridAxisDataEh; OldRowPos: Integer);
begin
  if Axis = HorzAxis then
    RolPosChanged(OldRowPos, VertAxis.RolStartVisPos)
  else
    RolPosChanged(HorzAxis.RolStartVisPos, OldRowPos);
end;

function TCustomGridEh.FullRedrawOnSroll: Boolean;
begin
  Result := FBackgroundData.Showing;
end;

procedure TCustomGridEh.RolPosChanged(OldRowPosX, OldRowPosY: Integer);
var
  ScrollArea: TRect;
  ScrollFlags: LongWord;
  DX, DY: Integer;
  MousePos: TPoint;
  OldRight: Integer;
begin
  UpdateScrollBars;
  if not HandleAllocated then
    Exit;

  if FEditorMode and (FInplaceEdit <> nil) and CanEditShow then
    FInplaceEdit.UpdateLoc(CellEditRect(Col, Row));

  MousePos := ScreenToClient(SafeGetMouseCursorPos);
  UpdateHotTackInfo(MousePos.X, MousePos.Y);

  if FullRedrawOnSroll then
  begin
    InvalidateGrid;
    Exit;
  end;

//  InvalidateGrid;
//  Exit;

  ScrollFlags := SW_INVALIDATE;

  DX := OldRowPosX - HorzAxis.RolStartVisPos;
  DY := OldRowPosY - VertAxis.RolStartVisPos;

  { Scroll the grid area }
  if DY = 0 then
  begin
    { Scroll both the column titles and data area at the same time }
    if not UseRightToLeftAlignment then
      ScrollArea := Rect(HorzAxis.FixedBoundary, VertAxis.GridClientStart,
                         HorzAxis.RolInClientBoundary, VertAxis.GridClientStop)
    else
    begin
      ScrollArea := Rect(ClientWidth - HorzAxis.GridClientStop, VertAxis.GridClientStart,
                         ClientWidth - HorzAxis.FixedBoundary, VertAxis.GridClientStop);
      DX := -DX;
    end;
    WindowsScrollWindowEx(Handle, DX, 0, ScrollArea, ScrollArea, 0, ScrollFlags);
  end
  else if DX = 0 then
  begin
    { Scroll both the row titles and data area at the same time }
    ScrollArea := Rect(HorzAxis.GridClientStart, VertAxis.FixedBoundary,
                       HorzAxis.GridClientStop, VertAxis.ContraStart);
    if UseRightToLeftAlignment then
    begin
      OldRight := ScrollArea.Right;
      ScrollArea.Right := HorzAxis.RightToLeftReflect(ScrollArea.Left);
      ScrollArea.Left := HorzAxis.RightToLeftReflect(OldRight);
    end;
    WindowsScrollWindowEx(Handle, 0, DY, ScrollArea, ScrollArea, 0, ScrollFlags);
  end
  else
  begin
    Invalidate;
    { Scroll titles and data area separately }
(*
    { Column titles }
    ScrollArea := Rect(HorzAxis.FixedBoundary, VertAxis.NullBorderIndent,
                       HorzAxis.GridExtent, VertAxis.FixedBoundary);
    WindowsScrollWindowEx(Handle, DX, 0, ScrollArea, ScrollArea, 0, ScrollFlags);
    { Row titles }
    ScrollArea := Rect(HorzAxis.NullBorderIndent, VertAxis.FixedBoundary,
                       HorzAxis.FixedBoundary, VertAxis.GridExtent);
    WindowsScrollWindowEx(Handle, 0, DY, ScrollArea, ScrollArea, 0, ScrollFlags);
    { Data area }
    ScrollArea := Rect(HorzAxis.FixedBoundary, VertAxis.FixedBoundary,
                       HorzAxis.GridExtent, VertAxis.GridExtent);
    WindowsScrollWindowEx(Handle, DX, DY, ScrollArea, ScrollArea, 0, ScrollFlags);
    { Contra Columns }
    ScrollArea := Rect(HorzAxis.FixedBoundary, VertAxis.GridExtent,
                       HorzAxis.GridExtent, VertAxis.FullGridExtent);
    WindowsScrollWindowEx(Handle, DX, 0, ScrollArea, ScrollArea, 0, ScrollFlags);
    { Contra Rows }
    ScrollArea := Rect(HorzAxis.GridExtent, VertAxis.FixedBoundary,
                       HorzAxis.FullGridExtent, VertAxis.GridExtent);
    WindowsScrollWindowEx(Handle, 0, DY, ScrollArea, ScrollArea, 0, ScrollFlags);
*)
  end;

  TopLeftChanged;
end;

function TCustomGridEh.RolSizeValid: Boolean;
begin
  Result := not HorzAxis.FRolLocCelPosArrObsolete and not VertAxis.FRolLocCelPosArrObsolete
end;

procedure TCustomGridEh.CelLenChanged(Axis: TGridAxisDataEh; Index, OldLen: Integer);
begin
  if True then

  if (Index < Axis.FixedCelCount) or (Index >= Axis.CelCount) then
    UpdateBoundaries;
  if Axis = HorzAxis
    then ColWidthsChanged
    else RowHeightsChanged;
end;

procedure TCustomGridEh.ValidateRolSize;
begin
  HorzAxis.CheckUpdateRolCelPosArr;
  VertAxis.CheckUpdateRolCelPosArr;
end;

procedure TCustomGridEh.MoveColumn(FromIndex, ToIndex: Integer);
begin
  HorzAxis.MoveCel(FromIndex, ToIndex);
end;

procedure TCustomGridEh.MoveRow(FromIndex, ToIndex: Integer);
begin
  VertAxis.MoveCel(FromIndex, ToIndex);
end;

procedure TCustomGridEh.BeginUpdateBoundaries;
begin
  Inc(FBoundariesUpdateCount);
end;

procedure TCustomGridEh.EndUpdateBoundaries;
begin
  Dec(FBoundariesUpdateCount);
end;

function TCustomGridEh.BoundariesUpdating: Boolean;
begin
  Result := (FBoundariesUpdateCount > 0);
end;

procedure TCustomGridEh.UpdateBoundaries;
var
  i: Integer;
begin

  if BoundariesUpdating or (csLoading in ComponentState) then Exit;
  BeginUpdateBoundaries;
  try

  if HandleAllocated then
  begin
    FWinClientBoundary.Left := 0;
    FWinClientBoundary.Top := 0;
    FWinClientBoundary.Right := ClientWidth;
    FWinClientBoundary.Bottom := ClientHeight;
  end else
  begin
    FWinClientBoundary.Left := 0;
    FWinClientBoundary.Top := 0;
    FWinClientBoundary.Right := Width;
    FWinClientBoundary.Bottom := Height;
  end;

//  FGridClientBoundary := FWinClientBoundary;
//  FGridScrolBoundary := FGridClientBoundary;

  FHorzAxis.FWinClientBoundSta := FWinClientBoundary.Left;
  FHorzAxis.FWinClientBoundSto := FWinClientBoundary.Right;
  FVertAxis.FWinClientBoundSta := FWinClientBoundary.Top;
  FVertAxis.FWinClientBoundSto := FWinClientBoundary.Bottom;

  FHorzAxis.FGridClientStart := FHorzAxis.FWinClientBoundSta + OutBoundaryData.LeftIndent;
  FHorzAxis.FGridClientStop := FHorzAxis.FWinClientBoundSto - OutBoundaryData.RightIndent;
  FVertAxis.FGridClientStart := FVertAxis.FWinClientBoundSta + OutBoundaryData.TopIndent;
  FVertAxis.FGridClientStop := FVertAxis.FWinClientBoundSto - OutBoundaryData.BottomIndent;

  FHorzAxis.FContraLen := 0;
  for i := 0 to ContraColCount-1 do
    Inc(FHorzAxis.FContraLen, HorzAxis.ContraCelLens[i]);
  if (ContraColCount > 0) and (goContraVertBoundaryLineEh in Options) then
    Inc(FHorzAxis.FContraLen, GridLineWidth);
  FHorzAxis.FContraStart := FHorzAxis.FGridClientStop - FHorzAxis.ContraLen;

  FVertAxis.FContraLen := 0;
  for i := 0 to ContraRowCount-1 do
    Inc(FVertAxis.FContraLen, FVertAxis.ContraCelLens[i]);
  if (ContraRowCount > 0) and (goContraHorzBoundaryLineEh in Options) then
    Inc(FVertAxis.FContraLen, GridLineWidth);
  FVertAxis.FContraStart := FVertAxis.FGridClientStop - FVertAxis.ContraLen;

  FHorzAxis.FFixedBoundary := FHorzAxis.FGridClientStart;
  FVertAxis.FFixedBoundary := FVertAxis.FGridClientStart;

  for i := 0 to FixedColCount-1 do
    Inc(FHorzAxis.FFixedBoundary, HorzAxis.FixedCelLens[i]);

  for i := 0 to FixedRowCount-1 do
    Inc(FVertAxis.FFixedBoundary, VertAxis.FixedCelLens[i]);

  FHorzAxis.FFrozenLen := 0;
  for i := FixedColCount-FrozenColCount to FixedColCount-1 do
    Inc(FHorzAxis.FFrozenLen, HorzAxis.FixedCelLens[i]);

  FVertAxis.FFrozenLen := 0;
  for i := FixedRowCount-FrozenRowCount to FixedRowCount-1 do
    Inc(FVertAxis.FFrozenLen, VertAxis.FixedCelLens[i]);

  if HorzScrollBar.IsScrollBarShowing {FHorzAxis.RolLen > FHorzAxis.RolClientLen} then
  begin
    Dec(FVertAxis.FGridClientStop, HorzScrollBar.ActualSize);
    Dec(FVertAxis.FContraStart, HorzScrollBar.ActualSize);
    if VertScrollBar.IsScrollBarShowing {FVertAxis.RolLen > FVertAxis.RolClientLen} then
    begin
      Dec(FHorzAxis.FGridClientStop, VertScrollBar.ActualSize);
      Dec(FHorzAxis.FContraStart, VertScrollBar.ActualSize);
    end;
  end else if VertScrollBar.IsScrollBarShowing {FVertAxis.RolLen > FVertAxis.RolClientLen} then
  begin
    Dec(FHorzAxis.FGridClientStop, VertScrollBar.ActualSize);
    Dec(FHorzAxis.FContraStart, VertScrollBar.ActualSize);
    if HorzScrollBar.IsScrollBarShowing {FHorzAxis.RolLen > FHorzAxis.RolClientLen} then
    begin
      Dec(FVertAxis.FGridClientStop, HorzScrollBar.ActualSize);
      Dec(FVertAxis.FContraStart, HorzScrollBar.ActualSize);
    end;
  end;

  AdjustMaxTopLeft(True, True, not IsSmoothHorzScroll, not IsSmoothVertScroll);

  FHorzAxis.GetLastVisibleCell(FHorzAxis.FRolLastVisCel, FHorzAxis.FRolLastFullVisCel);
  FVertAxis.GetLastVisibleCell(FVertAxis.FRolLastVisCel, FVertAxis.FRolLastFullVisCel);
  UpdateScrollBars;
  if FInplaceEdit <> nil then
    UpdateEdit;

  finally
    EndUpdateBoundaries;
  end;
  Invalidate;
end;

procedure TCustomGridEh.CellCountChanged;
begin
  Invalidate;
  if FCurCell.X >= ColCount then
    FCurCell.X := ColCount-1;

  if FCurCell.X < FixedColCount-FrozenColCount then
    FCurCell.X := FixedColCount-FrozenColCount;

  if FCurCell.Y >= RowCount then
    FCurCell.Y := RowCount-1;

  if FCurCell.Y < FixedRowCount-FrozenRowCount then
    FCurCell.Y := FixedRowCount-FrozenRowCount;

  FAnchorCell := FCurCell;
end;

function TCustomGridEh.CheckPersistentContraLine(LineType: TGridCellBorderTypeEh): Boolean;
begin
  if LineType = cbtTopEh
    then Result := ([goFixedVertLineEh, goVertLineEh] * Options) <> []
    else Result := ([goFixedHorzLineEh, goHorzLineEh] * Options) <> [];
end;

procedure TCustomGridEh.SetDrawStyle(const Value: TGridDrawStyleEh);
begin
  if FDrawStyle = Value then Exit;
  if FDrawStyle <> nil then
    FDrawStyle.RemoveChangeNotification(Self);
  FDrawStyle := Value;
  if Value <> nil
    then FDrawStyle.AddChangeNotification(Self)
    else RegetDefaultStyle;
end;

procedure TCustomGridEh.StyleEhChanged;
begin
  Invalidate;
end;

procedure TCustomGridEh.RegetDefaultStyle;
begin
  if FDrawStyle = GridDefaultDrawStyleEh then Exit;
  FDrawStyle := GridDefaultDrawStyleEh;
  if FDrawStyle <> nil
    then FDrawStyle.AddChangeNotification(Self)
    else StyleEhChanged;
end;

procedure TCustomGridEh.SetSelectionDrawParams(const Value: TGridSelectionDrawParamsEh);
begin
  FSelectionDrawParams.Assign(Value);
end;

{$IFDEF FPC}
function TCustomGridEh.Ctl3D: Boolean;
begin
  Result := True;
end;
{$ENDIF}

procedure TCustomGridEh.ScrollBarSizeChanged(ScrollBar: TGridScrollBarEh);
begin
  UpdateBoundaries;
end;

function TCustomGridEh.GetSelection: TGridRect;
begin
  Result := GridRect(FCurCell, FAnchorCell);
end;

procedure TCustomGridEh.SetSelection(const Value: TGridRect);
var
  OldSel: TGridRect;
begin
  OldSel := Selection;
  FAnchorCell.X := Value.Left;
  FAnchorCell.Y := Value.Top;
  FCurCell.X := Value.Right;
  FCurCell.Y := Value.Bottom;
  SelectionChanged(OldSel);
end;

procedure TCustomGridEh.MoveAnchorCell(ACol, ARow: Integer; Show: Boolean);
var
  OldSel: TGridRect;
begin
  if (FAnchorCell.X = ACol) and (FAnchorCell.Y = ARow) then Exit;
  if (ACol < 0) or (ARow < 0) or (ACol >= FullColCount) or (ARow >= FullRowCount) then
    raise EInvalidGridOperationEh.Create('TCustomGridEh.SetAnchorCell: Grid index out of range');
  OldSel := Selection;
  FAnchorCell.X := ACol;
  FAnchorCell.Y := ARow;
  ClampInView(FAnchorCell, True, True);
  SelectionChanged(OldSel);
end;

procedure TCustomGridEh.SelectionChanged(const OldSel: TGridRect);
begin
  InvalidateGrid;
end;

{ TCustomDrawGridEh }

function TCustomDrawGridEh.CellRect(ACol, ARow: Longint): TRect;
begin
  Result := inherited CellRect(ACol, ARow);
end;

procedure TCustomDrawGridEh.MouseToCell(X, Y: Integer; var ACol, ARow: Longint);
var
  Coord: TGridCoord;
begin
  Coord := MouseCoord(X, Y);
  ACol := Coord.X;
  ARow := Coord.Y;
end;

procedure TCustomDrawGridEh.ColumnMoved(FromIndex, ToIndex: Longint);
begin
  if Assigned(FOnColumnMoved) then FOnColumnMoved(Self, FromIndex, ToIndex);
end;

function TCustomDrawGridEh.CreateScrollBar(AKind: TScrollBarKind): TGridScrollBarEh;
begin
  if AKind = sbHorizontal
    then Result := TDrawGridHorzScrollBarEh.Create(Self, AKind)
    else Result := TDrawGridScrollBarEh.Create(Self, AKind);
end;

function TCustomDrawGridEh.GetEditMask(ACol, ARow: Longint): string;
begin
  Result := '';
  if Assigned(FOnGetEditMask) then FOnGetEditMask(Self, ACol, ARow, Result);
end;

function TCustomDrawGridEh.GetEditText(ACol, ARow: Longint): string;
begin
  Result := '';
  if Assigned(FOnGetEditText) then FOnGetEditText(Self, ACol, ARow, Result);
end;

procedure TCustomDrawGridEh.RowMoved(FromIndex, ToIndex: Longint);
begin
  if Assigned(FOnRowMoved) then FOnRowMoved(Self, FromIndex, ToIndex);
end;

function TCustomDrawGridEh.SelectCell(ACol, ARow: Longint): Boolean;
begin
  Result := True;
  if Assigned(FOnSelectCell) then FOnSelectCell(Self, ACol, ARow, Result);
end;

procedure TCustomDrawGridEh.SetEditText(ACol, ARow: Longint; const Value: string);
begin
  if Assigned(FOnSetEditText) then FOnSetEditText(Self, ACol, ARow, Value);
end;

procedure TCustomDrawGridEh.DrawCell(ACol, ARow: Longint; ARect: TRect;
  AState: TGridDrawState);
var
  Hold: Integer;
begin
  if Assigned(FOnDrawCell) then
  begin
    if UseRightToLeftAlignment then
    begin
      ARect.Left := ClientWidth - ARect.Left;
      ARect.Right := ClientWidth - ARect.Right;
      Hold := ARect.Left;
      ARect.Left := ARect.Right;
      ARect.Right := Hold;
      ChangeGridOrientation(False);
    end;
    FOnDrawCell(Self, ACol, ARow, ARect, AState);
    if UseRightToLeftAlignment then ChangeGridOrientation(True);
  end else
    inherited DrawCell(ACol, ARow, ARect, AState);
end;

procedure TCustomDrawGridEh.TopLeftChanged;
begin
  inherited TopLeftChanged;
  if Assigned(FOnTopLeftChanged) then FOnTopLeftChanged(Self);
end;

{ TGridLineColorsEh }

constructor TGridLineColorsEh.Create(AGrid: TCustomGridEh);
begin
  inherited Create;
  FGrid := AGrid;
  FBrightColor := clDefault;
  FDarkColor := clDefault;

  FDataHorzColor := clDefault;
  FDataVertColor := clDefault;
  FFixedHorzColor := clDefault;
  FFixedVertColor := clDefault;

  FHorzAreaContraBorderColor := clDefault;
  FHorzAreaContraHorzColor := clDefault;
  FHorzAreaContraVertColor := clDefault;
  FHorzAreaFrozenBorderColor := clDefault;
  FHorzAreaFrozenHorzColor := clDefault;
  FHorzAreaFrozenVertColor := clDefault;
  FVertAreaContraBorderColor := clDefault;
  FVertAreaContraHorzColor := clDefault;
  FVertAreaContraVertColor := clDefault;
  FVertAreaFrozenBorderColor := clDefault;
  FVertAreaFrozenHorzColor := clDefault;
  FVertAreaFrozenVertColor := clDefault;

end;

function TGridLineColorsEh.GetBrightColor: TColor;
begin
  if BrightColor = clDefault then
    if Grid.CanFillSelectionByTheme then
    begin
      if ColorToRGB(Grid.Color) = $F0F0F0
        then Result := clGray
        else Result := $F0F0F0
    end else if ColorToRGB(Grid.Color) = clSilver
      then Result := clGray
      else Result := clSilver
  else
    Result := BrightColor;
end;

function TGridLineColorsEh.GetDarkColor: TColor;
begin
  if DarkColor = clDefault then
    if Grid.Flat
      then Result := clGray
      else Result := clGray{cl3DDkShadow//clBlack}
  else
    Result := DarkColor;
end;

function TGridLineColorsEh.GetCellColor(ACol, ARow: Integer): TColor;
begin
  with Grid do
  begin
    if (ACol < FixedColCount - FrozenColCount) or (ARow < FixedRowCount - FrozenRowCount) then
      Result := GetDarkColor
    else if (ACol < ColCount) and (ARow < RowCount) then
      Result := GetBrightColor
    else if (ACol < ColCount) and (ARow >= RowCount) then
      Result := GetVertAreaContraVertColor
    else if (ACol >= ColCount) and (ARow < RowCount) then
      Result := GetHorzAreaContraHorzColor
    else
      Result := GetVertAreaContraVertColor;
  end;
end;

function TGridLineColorsEh.GetLeftBorderCellColor(ACol, ARow: Integer): TColor;
begin
  with Grid do
  begin
    if (ACol = ColCount)
      then Result := GetVertAreaContraBorderColor
      else Result := GetBrightColor;
  end;
end;

function TGridLineColorsEh.GetRightBorderCellColor(ACol, ARow: Integer): TColor;
begin
  with Grid do
  begin
    if (FrozenColCount > 0) and (ACol = FixedColCount-1)
      then Result := GetVertAreaFrozenBorderColor
      else Result := GetBrightColor;
  end;
end;

function TGridLineColorsEh.GetTopBorderCellColor(ACol, ARow: Integer): TColor;
begin
  with Grid do
  begin
    if (ARow = RowCount)
      then Result := GetHorzAreaContraBorderColor
      else Result := GetBrightColor;
  end;
end;

function TGridLineColorsEh.GetDownBorderCellColor(ACol, ARow: Integer): TColor;
begin
  with Grid do
  begin
    if (FrozenRowCount > 0) and (ARow = FixedRowCount-1)
      then Result := GetDarkColor
      else Result := GetBrightColor;
  end;
end;

function TGridLineColorsEh.GetDataHorzColor: TColor;
begin
  if DataHorzColor = clDefault
    then Result := GetBrightColor
    else Result := DataHorzColor;
end;

function TGridLineColorsEh.GetDataVertColor: TColor;
begin
  if DataVertColor = clDefault
    then Result := GetBrightColor
    else Result := DataVertColor;
end;

function TGridLineColorsEh.GetFixedHorzColor: TColor;
begin
  if FixedHorzColor = clDefault
    then Result := GetDarkColor
    else Result := FixedHorzColor;
end;

function TGridLineColorsEh.GetFixedVertColor: TColor;
begin
  if FixedVertColor = clDefault
    then Result := GetDarkColor
    else Result := FixedVertColor;
end;

function TGridLineColorsEh.GetHorzAreaContraBorderColor: TColor;
begin
  if HorzAreaContraBorderColor = clDefault
    then Result := GetDarkColor
    else Result := HorzAreaContraBorderColor;
end;

function TGridLineColorsEh.GetHorzAreaContraHorzColor: TColor;
begin
  if HorzAreaContraHorzColor = clDefault
    then Result := GetBrightColor
    else Result := HorzAreaContraHorzColor;
end;

function TGridLineColorsEh.GetHorzAreaContraVertColor: TColor;
begin
  if HorzAreaContraVertColor = clDefault
    then Result := GetBrightColor
    else Result := HorzAreaContraVertColor;
end;

function TGridLineColorsEh.GetHorzAreaFrozenBorderColor: TColor;
begin
  if HorzAreaFrozenBorderColor = clDefault
    then Result := GetDarkColor
    else Result := HorzAreaFrozenBorderColor;
end;

function TGridLineColorsEh.GetHorzAreaFrozenHorzColor: TColor;
begin
  if HorzAreaFrozenHorzColor = clDefault
    then Result := GetBrightColor
    else Result := HorzAreaFrozenHorzColor;
end;

function TGridLineColorsEh.GetHorzAreaFrozenVertColor: TColor;
begin
  if HorzAreaFrozenVertColor = clDefault
    then Result := GetBrightColor
    else Result := HorzAreaFrozenVertColor;
end;

function TGridLineColorsEh.GetVertAreaContraBorderColor: TColor;
begin
  if VertAreaContraBorderColor = clDefault
    then Result := GetDarkColor
    else Result := VertAreaContraBorderColor;
end;

function TGridLineColorsEh.GetVertAreaContraHorzColor: TColor;
begin
  if VertAreaContraHorzColor = clDefault
    then Result := GetBrightColor
    else Result := VertAreaContraHorzColor;
end;

function TGridLineColorsEh.GetVertAreaContraVertColor: TColor;
begin
  if VertAreaContraVertColor = clDefault
    then Result := GetBrightColor
    else Result := VertAreaContraVertColor;
end;

function TGridLineColorsEh.GetVertAreaFrozenBorderColor: TColor;
begin
  if VertAreaFrozenBorderColor = clDefault
    then Result := GetDarkColor
    else Result := VertAreaFrozenBorderColor;
end;

function TGridLineColorsEh.GetVertAreaFrozenHorzColor: TColor;
begin
  if VertAreaFrozenHorzColor = clDefault
    then Result := GetBrightColor
    else Result := VertAreaFrozenHorzColor;
end;

function TGridLineColorsEh.GetVertAreaFrozenVertColor: TColor;
begin
  if VertAreaFrozenVertColor = clDefault
    then Result := GetBrightColor
    else Result := VertAreaFrozenVertColor;
end;

procedure TGridLineColorsEh.SetBrightColor(const Value: TColor);
begin
  if FBrightColor <> Value then
  begin
    FBrightColor := Value;
    Grid.Invalidate;
  end;
end;

procedure TGridLineColorsEh.SetDarkColor(const Value: TColor);
begin
  if FDarkColor <> Value then
  begin
    FDarkColor := Value;
    Grid.Invalidate;
  end;
end;

procedure TGridLineColorsEh.SetDataHorzColor(const Value: TColor);
begin
  if FDataHorzColor <> Value then
  begin
    FDataHorzColor := Value;
    Grid.Invalidate;
  end;
end;

procedure TGridLineColorsEh.SetDataVertColor(const Value: TColor);
begin
  if FDataVertColor <> Value then
  begin
    FDataVertColor := Value;
    Grid.Invalidate;
  end;
end;

{ TGridOutBoundaryDataEh }

constructor TGridOutBoundaryDataEh.Create(AGrid: TCustomGridEh);
begin
  inherited Create;
  FGrid := AGrid;
end;

procedure TGridOutBoundaryDataEh.SetBottomIndent(const Value: Integer);
begin
  if FBottomIndent <> Value then
  begin
    FBottomIndent := Value;
    Grid.OutBoundaryDataChanged;
  end;
end;

procedure TGridOutBoundaryDataEh.SetLeftBottomDrawPriority(
  const Value: TCornerDrawPriorityEh);
begin
  FLeftBottomDrawPriority := Value;
end;

procedure TGridOutBoundaryDataEh.SetLeftIndent(const Value: Integer);
begin
  if FLeftIndent <> Value then
  begin
    FLeftIndent := Value;
    Grid.OutBoundaryDataChanged;
  end;
end;

procedure TGridOutBoundaryDataEh.SetLeftTopDrawPriority(
  const Value: TCornerDrawPriorityEh);
begin
  if FLeftTopDrawPriority <> Value then
  begin
    FLeftTopDrawPriority := Value;
    Grid.OutBoundaryDataChanged;
  end;
end;

procedure TGridOutBoundaryDataEh.SetRightBottomDrawPriority(
  const Value: TCornerDrawPriorityEh);
begin
  if FRightBottomDrawPriority <> Value then
  begin
    FRightBottomDrawPriority := Value;
    Grid.OutBoundaryDataChanged;
  end;
end;

procedure TGridOutBoundaryDataEh.SetRightIndent(const Value: Integer);
begin
  if FRightIndent <> Value then
  begin
    FRightIndent := Value;
    Grid.OutBoundaryDataChanged;
  end;
end;

procedure TGridOutBoundaryDataEh.SetRightTopDrawPriority(
  const Value: TCornerDrawPriorityEh);
begin
  if FRightTopDrawPriority <> Value then
  begin
    FRightTopDrawPriority := Value;
    Grid.OutBoundaryDataChanged;
  end;
end;

procedure TGridOutBoundaryDataEh.SetTopIndent(const Value: Integer);
begin
  if FTopIndent <> Value then
  begin
    FTopIndent := Value;
    Grid.OutBoundaryDataChanged;
  end;
end;

function TGridOutBoundaryDataEh.GetOutBoundaryRect(
  var ARect: TRect; OutBoundaryType: TGridCellBorderTypeEh): Boolean;
begin
  Result := False; //cbtTopEh, cbtLeftEh, cbtBottomEh, cbtRightEh
  if (OutBoundaryType = cbtTopEh) and (TopIndent > 0) then
  begin
    ARect.Top := 0;
    ARect.Bottom := TopIndent;
    if LeftTopDrawPriority = crpHorizontalDataPriorityEh
      then ARect.Left := 0
      else ARect.Left := LeftIndent;
    if RightTopDrawPriority = crpHorizontalDataPriorityEh
      then ARect.Right := Grid.ClientWidth
      else ARect.Right := Grid.ClientWidth - RightIndent;
    Result := True;
  end;
  if (OutBoundaryType = cbtBottomEh) and (BottomIndent > 0) then
  begin
    ARect.Top := Grid.ClientHeight - BottomIndent;
    ARect.Bottom := Grid.ClientHeight;
    if LeftBottomDrawPriority = crpHorizontalDataPriorityEh
      then ARect.Left := 0
      else ARect.Left := LeftIndent;
    if RightBottomDrawPriority = crpHorizontalDataPriorityEh
      then ARect.Right := Grid.ClientWidth
      else ARect.Right := Grid.ClientWidth - RightIndent;
    Result := True;
  end;
  if (OutBoundaryType = cbtLeftEh) and (LeftIndent > 0) then
  begin
    ARect.Left := 0;
    ARect.Right := LeftIndent;
    if LeftTopDrawPriority = crpHorizontalDataPriorityEh
      then ARect.Top := TopIndent
      else ARect.Top := 0;
    if LeftBottomDrawPriority = crpHorizontalDataPriorityEh
      then ARect.Bottom := Grid.ClientHeight - BottomIndent
      else ARect.Bottom := Grid.ClientHeight;
    Result := True;
  end;
  if (OutBoundaryType = cbtRightEh) and (RightIndent > 0) then
  begin
    ARect.Left := Grid.ClientWidth - RightIndent;
    ARect.Right := Grid.ClientWidth;
    if RightTopDrawPriority = crpHorizontalDataPriorityEh
      then ARect.Top := TopIndent
      else ARect.Top := 0;
    if RightBottomDrawPriority = crpHorizontalDataPriorityEh
      then ARect.Bottom := Grid.ClientHeight - BottomIndent
      else ARect.Bottom := Grid.ClientHeight;
    Result := True;
  end;
end;

procedure TGridOutBoundaryDataEh.InvalidateOutBoundary(
  OutBoundaryType: TGridCellBorderTypeEh);
var
  BoundaryRect: TRect;
begin
  if GetOutBoundaryRect(BoundaryRect, OutBoundaryType) then
    WindowsInvalidateRect(Grid.Handle, BoundaryRect, False);
end;

{ TGridHotTrackSpotEh }

procedure TGridHotTrackSpotEh.Assign(Source: TPersistent);
begin
  Col := TGridHotTrackSpotEh(Source).Col;
  Row := TGridHotTrackSpotEh(Source).Row;
  InCellX := TGridHotTrackSpotEh(Source).InCellX;
  InCellY := TGridHotTrackSpotEh(Source).InCellY;
end;

{ TGridBackgroundDataEh }

constructor TGridBackgroundDataEh.Create(AGrid: TCustomGridEh);
begin
  inherited Create;
  FGrid := AGrid;
  Visible := False;
  Placement := ipCenterCenterEh;
  HorzMargin := 0;
  VertMargin := 0;

  FPicture := TPicture.Create;
  FPicture.OnChange := PictureChanged;
end;

destructor TGridBackgroundDataEh.Destroy;
begin
  FreeAndNil(FPicture);
  inherited Destroy;
end;

procedure TGridBackgroundDataEh.SetPicture(Value: TPicture);
begin
  FPicture.Assign(Value);
end;

procedure TGridBackgroundDataEh.SetImagePlacement(Value: TImagePlacementEh);
begin
  if FImagePlacement <> Value then
  begin
    FImagePlacement := Value;
    PictureChanged(Self);
  end;
end;

{
procedure TGridBackgroundDataEh.SetImages(const Value: TCustomImageList);
begin
  if FImages <> Value then
  begin
    FImages := Value;
    FGrid.Invalidate;
    if FGrid <> nil then
    begin
      if Value <> nil then Value.FreeNotification(FGrid);
    end;
  end;
end;

procedure TGridBackgroundDataEh.SetImageIndex(const Value: Integer);
begin
  if FImageIndex <> Value then
  begin
    FImageIndex := Value;
    PictureChanged(Self);
  end;
end;

procedure TGridBackgroundDataEh.SetExcludeTitle(const Value: Boolean);
begin
  if FExcludeTitle <> Value then
  begin
    FExcludeTitle := Value;
    PictureChanged(Self);
  end;
end;

procedure TGridBackgroundDataEh.SetExcludeFooter(const Value: Boolean);
begin
  if FExcludeFooter <> Value then
  begin
    FExcludeFooter := Value;
    PictureChanged(Self);
  end;
end;
}

procedure TGridBackgroundDataEh.SetImageHorzMargin(const Value: Integer);
begin
  if FImageHorzMargin <> Value then
  begin
    FImageHorzMargin := Value;
    PictureChanged(Self);
  end;
end;

procedure TGridBackgroundDataEh.SetImageVertMargin(const Value: Integer);
begin
  if FImageVertMargin <> Value then
  begin
    FImageVertMargin := Value;
    PictureChanged(Self);
  end;
end;

procedure TGridBackgroundDataEh.PictureChanged(Sender: TObject);
begin
  FGrid.Invalidate;
end;

function TGridBackgroundDataEh.Showing: Boolean;
begin
  Result := Visible;
end;

function TGridBackgroundDataEh.BoundRect: TRect;
begin
  Result.Left := Grid.HorzAxis.GridClientStart;
  Result.Top := Grid.VertAxis.GridClientStart;
  Result.Right := Grid.HorzAxis.GridClientStop;
  Result.Bottom := Grid.VertAxis.GridClientStop;
end;

function TGridBackgroundDataEh.DestRect: TRect;
var
  w, h, cw, ch: Integer;
  xyaspect: Double;
begin
  w := Picture.Width;
  h := Picture.Height;
  Result := BoundRect;
  cw := Result.Right - Result.Left;
  ch := Result.Bottom - Result.Top;

  Inc(Result.Left, FImageHorzMargin);
  Inc(Result.Top, FImageVertMargin);

  case FImagePlacement of
    ipStretchEh :
      begin
        w := cw;
        h := ch;
      end;

    ipFillEh :
      begin
        if (w > 0) and (h > 0) then
        begin
          xyaspect := w / h;
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

  case FImagePlacement of
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

procedure TGridBackgroundDataEh.PaintBackgroundData;
var
  Rect: TRect;
  MLeft : Integer;
begin
  with FGrid.Canvas do
  begin
    Pen.Style := psSolid;
    Brush.Color := FGrid.Color;
    Brush.Style := bsSolid;
    Rectangle(0, 0, FGrid.Width, FGrid.Height);
  end;

  try
    with FGrid.Canvas do
      begin
        Rect := DestRect;

        if (FImagePlacement = ipTileEh) and (Picture.Width > 0) and (Picture.Height > 0) then
          begin
            MLeft := Rect.Left;
            while Rect.Top < FGrid.ClientHeight do
              begin
                while Rect.Left < FGrid.ClientWidth do
                  begin
                    StretchDraw(Rect, Picture.Graphic);
                    OffsetRect(Rect, Picture.Width, 0);
                  end;
                Rect.Left := MLeft;
                Rect.Right := Rect.Left + Picture.Width;
                OffsetRect(Rect, 0, Picture.Height);
              end;
          end
        else
          StretchDraw(Rect, Picture.Graphic);
      end;
  finally
//    FDrawing := Save;
  end;
end;

procedure TGridBackgroundDataEh.SetVisible(const Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    PictureChanged(Self);
  end;
end;

{ TGridAxisDataEh }

constructor TGridAxisDataEh.Create(AGrid: TCustomGridEh);
begin
  inherited Create;
  FGrid := AGrid;
end;

destructor TGridAxisDataEh.Destroy;
begin
  inherited Destroy;
end;

procedure TGridAxisDataEh.CheckUpdateAxises;
begin
  Grid.CheckUpdateAxises;
end;

procedure TGridAxisDataEh.CheckUpdateRolCelPosArr;
begin
  if FRolLocCelPosArrObsolete then
  begin
    UpdateRolCelPosArr;
    Grid.RolSizeUpdated;
  end;
end;

procedure TGridAxisDataEh.UpdateRolCelPosArr;
var
  i: Integer;
begin
  FRolLocCelPosArr[0] := 0;
  for i := 1 to RolCelCount-1 do
    FRolLocCelPosArr[i] := FRolLocCelPosArr[i-1] + FRolCelLens[i-1];
  UpdateVisCells;
  FRolLocCelPosArrObsolete := False;
end;

function TGridAxisDataEh.GetCelLens(Index: Integer): Integer;
begin
  if Index < FixedCelCount then
    Result := FixedCelLens[Index]
  else if Index < CelCount then
    Result := FRolCelLens[Index-FixedCelCount]
  else
    Result := FContraCelLens[Index-CelCount];
end;

procedure TGridAxisDataEh.SetCelLens(Index: Integer; const Value: Integer);
begin
  if Index < FixedCelCount then
    FixedCelLens[Index] := Value
  else if Index < CelCount then
    RolCelLens[Index-FixedCelCount] := Value
  else
    ContraCelLens[Index-CelCount] := Value;
end;

function TGridAxisDataEh.GetFixedCelLens(Index: Integer): Integer;
begin
  Result := FFixedCelLens[Index];
end;

procedure TGridAxisDataEh.SetFixedCelLens(Index: Integer; const Value: Integer);
var
  OldLen: Integer;
begin
  if FFixedCelLens[Index] <> Value then
  begin
    OldLen := FFixedCelLens[Index];
    FFixedCelLens[Index] := Value;
    Grid.CelLenChanged(Self, Index, OldLen);
  end;
end;

function TGridAxisDataEh.GetContraCelLens(Index: Integer): Integer;
begin
  Result := FContraCelLens[Index];
end;

procedure TGridAxisDataEh.SetContraCelCount(const Value: Integer);
var
  Delta: Integer;
begin
  if FContraCelCount <> Value then
  begin
    if Value < 0 then
      raise Exception.Create('ContraCelCount can''t be less then 0');
    Delta := Value - FContraCelCount;
    SetLength(FContraCelLens, Value);
    if Delta > 0 then
      FillArray(FContraCelLens, FContraCelCount, Delta, DefaultCelLen);
    FContraCelCount := Value;
    Grid.CellCountChanged;
    Grid.UpdateBoundaries;
  end;
end;

procedure TGridAxisDataEh.SetContraCelLens(Index: Integer; const Value: Integer);
var
  OldLen: Integer;
begin
  if FContraCelLens[Index] <> Value then
  begin
    OldLen := FContraCelLens[Index];
    FContraCelLens[Index] := Value;
    Grid.CelLenChanged(Self, Index + CelCount, OldLen + CelCount);
  end;
end;

function TGridAxisDataEh.GetRolCelLens(Index: Integer): Integer;
begin
  Result := FRolCelLens[Index];
end;

procedure TGridAxisDataEh.SetRolCelLens(Index: Integer; const Value: Integer);
var
  OldLen: Integer;
begin
  if FRolCelLens[Index] <> Value then
  begin
    OldLen := FRolCelLens[Index];
    FRolCelLens[Index] := Value;
    FRolLocCelPosArrObsolete := True;
    Grid.CelLenChanged(Self, Index + FixedCelCount, OldLen + FixedCelCount);
    Grid.CellCountChanged;
  end;
end;

function TGridAxisDataEh.GetRolClientLen: Integer;
begin
  Result := ContraStart - FixedBoundary;
  if Result < 0 then Result := 0;
end;

function TGridAxisDataEh.GetRolLocCelPosArr(Index: Integer): Int64;
begin
  CheckUpdateRolCelPosArr;
  Result := FRolLocCelPosArr[Index];
end;

procedure TGridAxisDataEh.SetRolLocCelPosArr(Index: Integer; const Value: Int64);
begin
  FRolLocCelPosArr[Index] := Value;
end;

function TGridAxisDataEh.GetCelCount: Integer;
begin
  Result := FixedCelCount + RolCelCount;
end;

function TGridAxisDataEh.GetFullCelCount: Integer;
begin
  Result := FixedCelCount + RolCelCount + ContraCelCount;
end;

function TGridAxisDataEh.GetRolLastFullVisCel: Integer;
begin
  CheckUpdateRolCelPosArr;
  Result := FRolLastFullVisCel;
end;

function TGridAxisDataEh.GetRolLastVisCel: Integer;
begin
  CheckUpdateRolCelPosArr;
  Result := FRolLastVisCel;
end;

function TGridAxisDataEh.GetRolLen: Int64;
begin
  Result := RolLocCelPosArr[Length(FRolLocCelPosArr)-1] + RolCelLens[Length(FRolCelLens)-1];
end;

function TGridAxisDataEh.GetRolInClientBoundary: Integer;
begin
  Result := FixedBoundary - RolStartVisPos + RolLen;
  if Result > ContraStart then
    Result := ContraStart;
end;

function TGridAxisDataEh.GetRolStopVisPos: Int64;
begin
  Result := RolStartVisPos + RolLen;
end;

function TGridAxisDataEh.GetGridClientLen: Integer;
begin
  Result := GridClientStop - GridClientStart;
end;

function TGridAxisDataEh.GetGridClientStart: Integer;
begin
  CheckUpdateAxises;
  Result := FGridClientStart;
end;

function TGridAxisDataEh.GetGridClientStop: Integer;
begin
  CheckUpdateAxises;
  Result := FGridClientStop;
end;

procedure TGridAxisDataEh.GetLastVisibleCell(var LastVisCell, LastFullVisCell: Integer);
var
  i, Pos: Integer;
  ATargetPos, {ATargetCel, }ATargetCelOfst: Integer;
begin
  LastVisCell := -1;
  LastFullVisCell := -1;
  if FixedBoundary >= ContraStart then
  begin
    Pos := 0;
    for i := 0 to FixedCelCount-1 do
    begin
      Inc(Pos, CelLens[i]);
      if Pos >= ContraStart then
      begin
        LastFullVisCell := i;
        if (Pos > ContraStart) and (i < FixedCelCount-1)
          then LastVisCell := i+1
          else LastVisCell := i;
        Exit;
      end;
    end;
  end else
  begin
    ATargetPos := RolStartVisPos + RolClientLen - 1;
    BinarySearch(FRolLocCelPosArr, ATargetPos, LastVisCell, ATargetCelOfst);
    if (ATargetCelOfst < RolCelLens[LastVisCell]-1) and (LastVisCell > RolStartVisCel)
      then LastFullVisCell := LastVisCell - 1
      else LastFullVisCell := LastVisCell;
//    Inc(LastVisCell, FixedCelCount);
//    Inc(LastFullVisCell, FixedCelCount);
  end;
end;

procedure TGridAxisDataEh.SetRolCelCount(const Value: Integer);
var
  Delta: Integer;
begin
  if FRolCelCount <> Value then
  begin
    if Value < 1 then
      raise Exception.Create('RolCelCount can''t be less then 1');
    Delta := Value - FRolCelCount;
    if Delta > 0 then
      InsertRolCels(FRolCelCount, Delta)
    else if Delta < 0 then
      DeleteRolCels(FRolCelCount+Delta, -Delta);
  end;
end;

procedure TGridAxisDataEh.InsertRolCels(const Pos, Count: Integer);
begin
//  if Pos <> RolCelCount then
//    raise Exception.Create('TGridAxisDataEh.InsertRolCels - Pos <> RolCelCount');

  ArrayInsertRange(FRolCelLens, Pos, Count);
  FillArray(FRolCelLens, Pos, Count, DefaultCelLen);

  SetLength(FRolLocCelPosArr, Length(FRolCelLens));

  FRolCelCount := Length(FRolCelLens);
  FRolLocCelPosArrObsolete := True;
  Grid.CellCountChanged;
//  Grid.RolSizeInvalidated;
end;

procedure TGridAxisDataEh.DeleteRolCels(const Pos, Count: Integer);
begin
//  if Pos+Count <> RolCelCount then
//    raise Exception.Create('TGridAxisDataEh.DeleteRolCels - Pos <> RolCelCount');

  ArrayDeleteRange(FRolCelLens, Pos, Count);
  SetLength(FRolLocCelPosArr, Length(FRolCelLens));
  FRolCelCount := Length(FRolCelLens);
  FRolLocCelPosArrObsolete := True;
  Grid.CellCountChanged;
end;

procedure TGridAxisDataEh.MoveCel(FromIndex, ToIndex: Integer);
begin
  if (FromIndex <= FixedCelCount-1) and (ToIndex <= FixedCelCount-1)  then
    ArrayMove(FFixedCelLens, FromIndex, ToIndex)
  else if (FromIndex >= FixedCelCount) and (FromIndex <= CelCount-1) and
          (ToIndex >= FixedCelCount) and (ToIndex <= CelCount-1) then
  begin
    ArrayMove(FRolCelLens, FromIndex-FixedCelCount, ToIndex-FixedCelCount);
    FRolLocCelPosArrObsolete := True;
//    Grid.RolSizeInvalidated;
  end else if (FromIndex >= CelCount) and (FromIndex <= FullCelCount-1) and
          (ToIndex >= CelCount) and (ToIndex <= FullCelCount-1) then
    ArrayMove(FContraCelLens, FromIndex-CelCount, ToIndex-CelCount)
  else
    raise Exception.Create(
      Format('MoveCel in different areas[FromIndex:%D, ToIndex:%D', [FromIndex, ToIndex]));
  Grid.AxisMoved(Self, FromIndex, ToIndex);
end;

procedure TGridAxisDataEh.SetDefaultCelLen(const Value: Integer);
begin
  if FDefaultCelLen <> Value then
  begin
    FDefaultCelLen := Value;
  end;
end;

function TGridAxisDataEh.GetScrollStep: Integer;
begin
  Result := (ContraStart - FixedBoundary) div 20;
  if Result = 0 then
    Result := 1;
end;

function TGridAxisDataEh.GetStartVisCel: Integer;
begin
  Result := RolStartVisCel + FixedCelCount;
end;

procedure TGridAxisDataEh.SetRolStartVisPos(const Value: Int64);
var
  OldRolStartVisPos: Integer;
begin
  if FRolStartVisPos <> Value then
  begin
    if Value > RolLen then
      raise Exception.Create('RolStartVisPos can''t be > RolLen');
    OldRolStartVisPos := FRolStartVisPos;
    FRolStartVisPos := Value;
    CheckUpdateRolCelPosArr;
    UpdateVisCells;
    Grid.RolPosAxisChanged(Self, OldRolStartVisPos);
  end;
end;

procedure TGridAxisDataEh.UpdateVisCells;
begin
  BinarySearch(FRolLocCelPosArr, FRolStartVisPos, FRolStartVisCel, FRolStartVisCelOfst);
  GetLastVisibleCell(FRolLastVisCel, FRolLastFullVisCel);
end;

procedure TGridAxisDataEh.SwapRightToLeftPoses(var Pos1, Pos2: Integer);
var
  TmpVal: Integer;
begin
  TmpVal := Pos2;
  Pos2  := WinClientBoundSto - WinClientBoundSta - Pos1;
  Pos1  := WinClientBoundSto - WinClientBoundSta - TmpVal;
end;

function TGridAxisDataEh.RightToLeftReflect(const APos: Integer): Integer;
begin
  Result := WinClientBoundSto - WinClientBoundSta - APos;
end;

function TGridAxisDataEh.CheckRolStartVisPos(const ARolStartVisPos: Int64): Int64;
begin
  Result := ARolStartVisPos;
  if Result > RolLen - RolClientLen then
    Result := RolLen - RolClientLen;
  if Result < 0 then
    Result := 0;
end;

function TGridAxisDataEh.SafeSetRolStartVisCel(NewStartCell: Integer;
  ScrollStepType: TScrollStepTypeEh = sstByPixelEh): Integer;
begin
  if NewStartCell < 0 then NewStartCell := 0;
  if NewStartCell >= RolCelCount then NewStartCell := RolCelCount-1;

  Result := RolLocCelPosArr[NewStartCell];
  if Result > RolLen - RolClientLen then
  begin
    if ScrollStepType = sstByPixelEh then
    begin
      Result := RolLen - RolClientLen;
      RolStartVisPos := CheckRolStartVisPos(Result);
    end else
    begin
      NewStartCell := CalcMaxStartCellFor(RolCelCount-1);
      RolStartVisPos := RolLocCelPosArr[NewStartCell];
    end;
  end else
    RolStartVisPos := CheckRolStartVisPos(Result);
end;

function TGridAxisDataEh.CalcMaxStartCellFor(RolFinishCell: Integer): Integer;
var
  i: Integer;
begin
  Result := RolFinishCell;
  for i := RolFinishCell downto 0 do
  begin
    if ((RolLocCelPosArr[RolFinishCell] + RolCelLens[RolFinishCell]) - RolLocCelPosArr[i]) > RolClientLen then
      Break;
    Result := i;
  end;

end;

procedure TGridAxisDataEh.RolCellAtPos(Pos: Int64; var ACel, ACelOffset: Integer);
begin
  BinarySearch(FRolLocCelPosArr, Pos, ACel, ACelOffset);
end;

procedure TGridAxisDataEh.SetFrozenCelCount(const Value: Integer);
begin
  if FFrozenCelCount <> Value then
  begin
    FFrozenCelCount := Value;
    Grid.UpdateBoundaries;
  end;
end;

{ TControlScrollBarEh }

constructor TGridScrollBarEh.Create(AGrid: TCustomGridEh;
  AKind: TScrollBarKind);
begin
  inherited Create;
  FGrid := AGrid;
  FKind := AKind;
//  FVisible := True;
  FVisibleMode := sbAutoShowEh;
  FTracking := True;
//  FKeepMaxSizeInDefault := True;
end;

destructor TGridScrollBarEh.Destroy;
begin
  inherited Destroy;
end;

procedure TGridScrollBarEh.Assign(Source: TPersistent);
begin
  if Source is TGridScrollBarEh then
    Tracking := TGridScrollBarEh(Source).Tracking
  else
    inherited Assign(Source);
end;

function TGridScrollBarEh.IsKeepMaxSizeInDefault: Boolean;
begin
  Result := False;
end;

function TGridScrollBarEh.IsScrollBarShowing: Boolean;
begin
  Result := CheckScrollBarMustBeShown;
end;

function TGridScrollBarEh.CheckScrollBarMustBeShown: Boolean;
var
  APosition, AMin, AMax, APageSize: Integer;
begin
  if VisibleMode = sbAlwaysShowEh then
    Result := True
  else if VisibleMode = sbNeverShowEh then
    Result := False
  else //sbAutoShowEh
  begin
    if Kind = sbHorizontal
      then Grid.GetDataForHorzScrollBar(APosition, AMin, AMax, APageSize)
      else Grid.GetDataForVertScrollBar(APosition, AMin, AMax, APageSize);
    if (AMax <= AMin) or (AMax - AMin < APageSize) {or not SBEnabled}
    then
      Result := False
    else
      Result := True;
  end;
end;

function TGridScrollBarEh.CheckHideScrollBar: Boolean;
begin
  Result := not IsScrollBarShowing;
end;

procedure TGridScrollBarEh.SetVisibleMode(const Value: TScrollBarVisibleModeEh);
begin
  if FVisibleMode <> Value then
  begin
    FVisibleMode := Value;
    FGrid.UpdateBoundaries;
  end;
end;

procedure TGridScrollBarEh.ScrollBarPanelChanged;
begin
  if Assigned(FGrid) then
    FGrid.UpdateScrollBars;
end;

(*?
function TDBGridEhScrollBar.GetScrollInfo(var ScrollInfo: TScrollInfo;
  var SBEnabled: Boolean): Boolean;
const
  ScrollKindWinConsts: array[TScrollBarKind] of Integer = (SB_HORZ, SB_VERT);
var
  Handle: THandle;
begin
  if Kind = sbHorizontal then
  begin
    Handle := FGrid.FHorzScrollBarPanelControl.ScrollBar.Handle;
    SBEnabled := FGrid.FHorzScrollBarPanelControl.ScrollBar.Enabled;
  end else
  begin
    Handle := FGrid.FVertScrollBarPanelControl.ScrollBar.Handle;
    SBEnabled := FGrid.FVertScrollBarPanelControl.ScrollBar.Enabled;
  end;
  Result := Windows.GetScrollInfo(Handle, SB_CTL, ScrollInfo);
end;
*)

procedure TGridScrollBarEh.GetScrollBarParams(var APosition, AMin, AMax, APageSize: Integer);
var
  sb: TScrollBar;
begin
  if Kind = sbHorizontal
    then sb := Grid.FHorzScrollBarPanelControl.ScrollBar
    else sb := Grid.FVertScrollBarPanelControl.ScrollBar;

  APosition := sb.Position;
  AMin := sb.Min;
  AMax := sb.Max;
  APageSize := sb.PageSize;
end;

{procedure TGridScrollBarEh.SetKeepMaxSizeInDefault(const Value: Boolean);
begin
  if FKeepMaxSizeInDefault <> Value then
  begin
    FKeepMaxSizeInDefault := Value;
    ScrollBarPanelChanged;
  end;
end;}

procedure TGridScrollBarEh.SetParams(APosition, AMin, AMax, APageSize: Integer);
begin
  if Kind = sbHorizontal
    then Grid.FHorzScrollBarPanelControl.SetParams(APosition, AMin, AMax, APageSize)
    else Grid.FVertScrollBarPanelControl.SetParams(APosition, AMin, AMax, APageSize);
end;

function TGridScrollBarEh.GetSmoothStep: Boolean;
begin
  Result := FSmoothStep;
end;

function TGridScrollBarEh.GetVisible: Boolean;
begin
  if FVisibleMode = sbNeverShowEh
    then Result := False
    else Result := True;
end;

procedure TGridScrollBarEh.SetVisible(const Value: Boolean);
begin
  if Value
    then SetVisibleMode(sbAutoShowEh)
    else SetVisibleMode(sbNeverShowEh);
//  UpdateExtScrollBar;
end;

procedure TGridScrollBarEh.SetSmoothStep(Value: Boolean);
begin
  if FSmoothStep <> Value then
  begin
    FSmoothStep := Value;
    SmoothStepChanged;
  end;
end;

procedure TGridScrollBarEh.SmoothStepChanged;
begin
end;

function TGridScrollBarEh.Grid: TCustomGridEh;
begin
  Result := FGrid;
end;

function TGridScrollBarEh.ScrollBarPanel: Boolean;
begin
  Result := True;
end;

function TGridScrollBarEh.GetSize: Integer;
begin
  Result := FSize;
end;

procedure TGridScrollBarEh.SetSize(const Value: Integer);
begin
  if FSize <> Value then
  begin
    FSize := Value;
    FGrid.ScrollBarSizeChanged(Self);
  end;
end;

function TGridScrollBarEh.ActualSize: Integer;
begin
  if Size > 0
    then Result := Size
    else Result := FGrid.ScrollBarSize;
end;

function TGridScrollBarEh.ActualScrollBarBoxSize: Integer;
begin
  Result := ActualSize;
  if IsKeepMaxSizeInDefault then
  begin
    if Result > GetSystemMetrics(SM_CYHSCROLL) then
      Result := GetSystemMetrics(SM_CYHSCROLL);
  end;
end;

{ TDrawGridHorzScrollBarEh }

constructor TDrawGridHorzScrollBarEh.Create(AGrid: TCustomGridEh;
  AKind: TScrollBarKind);
begin
  inherited Create(AGrid, AKind);
  SmoothStep := True;
end;

{ TGridDrawStyleEh }

var
  FGridDefaultStyleEh: TGridDrawStyleEh = nil;

function SetGridDefaultDrawStyleEh(NewGridDefaultDrawStyle: TGridDrawStyleEh): TGridDrawStyleEh;
var
  i: Integer;
begin
  Result := FGridDefaultStyleEh;
  FGridDefaultStyleEh := NewGridDefaultDrawStyle;
  for i := 0 to Result.FGrids.Count-1 do
  begin
    TCustomGridEh(Result.FGrids[i]).DrawStyle := FGridDefaultStyleEh;
  end;
end;

function GridDefaultDrawStyleEh: TGridDrawStyleEh;
begin
  Result := FGridDefaultStyleEh;
end;

constructor TGridDrawStyleEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FGrids := TObjectList.Create(False);
end;

destructor TGridDrawStyleEh.Destroy;
var
  i: Integer;
begin
  if FGridDefaultStyleEh = Self then
    FGridDefaultStyleEh := nil;
  for i := FGrids.Count-1 downto 0 do
    TCustomGridEh(FGrids[i]).DrawStyle := nil;
  FreeAndNil(FGrids);
  inherited Destroy;
end;

procedure TGridDrawStyleEh.Changed;
var
  i: Integer;
begin
  for i := 0 to FGrids.Count-1 do
    TCustomGridEh(FGrids[i]).StyleEhChanged;
end;

procedure TGridDrawStyleEh.AddChangeNotification(Grid: TCustomGridEh);
begin
  if not GridInChangeNotification(Grid) then
    FGrids.Add(Grid);
end;

procedure TGridDrawStyleEh.RemoveChangeNotification(Grid: TCustomGridEh);
begin
  FGrids.Remove(Grid);
end;

function TGridDrawStyleEh.GridInChangeNotification(Grid: TCustomGridEh): Boolean;
begin
  Result := (FGrids.IndexOf(Grid) >= 0);
end;

function TGridDrawStyleEh.GetDefaultActualSelectionStyle: TGridSelectionDrawStyleEh;
begin
  if ThemesEnabled and CustomStyleActive then
    Result := gsdsGridThemedEh
  else if ThemesEnabled and CheckWin32Version(6, 0) then
    Result := gsdsListViewThemedEh
  else
    Result := gsdsClassicEh;
end;

function TGridDrawStyleEh.GetActualSelectionStyle: TGridSelectionDrawStyleEh;
begin
  if (SelectionStyle <> gsdsDefaultEh) then
    if (SelectionStyle = gsdsListViewThemedEh) and not (ThemesEnabled and CheckWin32Version(6, 0))
      then Result := GetDefaultActualSelectionStyle
      else Result := SelectionStyle
  else
    Result := GetDefaultActualSelectionStyle;
end;

procedure TGridDrawStyleEh.SetSelectionStyle(const Value: TGridSelectionDrawStyleEh);
begin
  if FSelectionStyle <> Value then
  begin
    FSelectionStyle := Value;
    Changed;
  end;
end;

function TGridDrawStyleEh.GetDrawFocusFrame: Boolean;
begin
  if DrawFocusFrameStored
    then Result := FDrawFocusFrame
    else Result := DefaultDrawFocusFrame;
end;

procedure TGridDrawStyleEh.SetDrawFocusFrame(const Value: Boolean);
begin
  if DrawFocusFrameStored and (Value = FDrawFocusFrame) then Exit;
  DrawFocusFrameStored := True;
  FDrawFocusFrame := Value;
  Changed;
end;

function TGridDrawStyleEh.DefaultDrawFocusFrame: Boolean;
begin
  Result := (GetActualSelectionStyle in [gsdsClassicEh]) and
            not IsCustomStyleActive;
end;

function TGridDrawStyleEh.IsDrawFocusFrameStored: Boolean;
begin
  Result := FDrawFocusFrameStored;
end;

procedure TGridDrawStyleEh.SetDrawFocusFrameStored(const Value: Boolean);
begin
  if FDrawFocusFrameStored <> Value then
  begin
    FDrawFocusFrameStored := Value;
    FDrawFocusFrame := DefaultDrawFocusFrame;
    Changed;
  end;
end;

function TGridDrawStyleEh.IsCustomStyleActive: Boolean;
begin
{$IFDEF EH_LIB_16}
  Result := TStyleManager.IsCustomStyleActive;
{$ELSE}
  Result := False;
{$ENDIF}
end;

{ TGridSelectionParamsEh }

constructor TGridSelectionDrawParamsEh.Create(AGrid: TCustomGridEh);
begin
  inherited Create;
  FGrid := AGrid;
end;

destructor TGridSelectionDrawParamsEh.Destroy;
begin
  inherited Destroy;
end;

function TGridSelectionDrawParamsEh.GetDrawFocusFrame: Boolean;
begin
  if DrawFocusFrameStored
    then Result := FDrawFocusFrame
    else Result := DefaultDrawFocusFrame;
end;

procedure TGridSelectionDrawParamsEh.SetDrawFocusFrame(const Value: Boolean);
begin
  if DrawFocusFrameStored and (Value = FDrawFocusFrame) then Exit;
  DrawFocusFrameStored := True;
  FDrawFocusFrame := Value;
  Grid.Invalidate;
end;

function TGridSelectionDrawParamsEh.IsDrawFocusFrameStored: Boolean;
begin
  Result := FDrawFocusFrameStored;
end;

procedure TGridSelectionDrawParamsEh.SetDrawFocusFrameStored(const Value: Boolean);
begin
  if FDrawFocusFrameStored <> Value then
  begin
    FDrawFocusFrameStored := Value;
    FDrawFocusFrame := DefaultDrawFocusFrame;
    Grid.Invalidate;
  end;
end;

function TGridSelectionDrawParamsEh.DefaultDrawFocusFrame: Boolean;
begin
  if SelectionStyle = gsdsDefaultEh
    then Result := Grid.DefaultDrawFocusFrame
    else Result := (GetActualSelectionStyle = gsdsClassicEh);
end;

function TGridSelectionDrawParamsEh.GetActualSelectionStyle: TGridSelectionDrawStyleEh;
begin
  if SelectionStyle <> gsdsDefaultEh then
    if (SelectionStyle = gsdsListViewThemedEh) and not (ThemesEnabled and CheckWin32Version(6, 0))
      then Result := Grid.GetDefaultSelectionStyle
      else Result := SelectionStyle
  else
    Result := Grid.GetDefaultSelectionStyle;
end;

procedure TGridSelectionDrawParamsEh.SetSelectionStyle(const Value: TGridSelectionDrawStyleEh);
begin
  if FSelectionStyle <> Value then
  begin
    FSelectionStyle := Value;
    Grid.Invalidate;
  end;
end;

{ TMRUListboxEh }

constructor TMRUListboxEh.Create(Owner: TComponent);
begin
  inherited Create(Owner);
end;

{ TCustomListboxEh }

constructor TCustomListboxEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Options := [goDrawFocusSelectedEh];
  FItems := TStringList.Create;
  TStringList(FItems).OnChange := ItemsChanged;
  FixedColCount := 0;
  ColCount := 1;
  FixedRowCount := 0;
  RowCount := 1;
  FVirtualRowCount := 0;
  HorzScrollBar.Visible := False;
  SizeGripAlwaysShow := True;
  FRowSeleced := False;
end;

destructor TCustomListboxEh.Destroy;
begin
  FItems.Free;
  inherited Destroy;
end;

procedure TCustomListboxEh.DrawCell(ACol, ARow: Integer; ARect: TRect;
  State: TGridDrawState);
begin
  if ItemIndex < 0 then
    Exclude(State,  gdSelected);
  if Count = 0 then
    Canvas.FillRect(ARect)
  else
  begin
    DrawItem(ARow, ARect, State);
  end;
end;

procedure TCustomListboxEh.DrawItem(Index: Integer; ARect: TRect;
  State: TGridDrawState);
begin
  if UseItemObjects and
     (Index < Items.Count) and
     (Integer(Items.Objects[Index]) > 255) and
     (Items.Objects[Index] is TCustomListboxItemEh)
  then
    TCustomListboxItemEh(Items.Objects[Index]).DrawItem(Self, Index, ARect, State)
  else
    DefaultDrawItem(Index, ARect, State);
end;

procedure TCustomListboxEh.FocusCell(ACol, ARow: Integer; MoveAnchor: Boolean);
begin
  inherited FocusCell(ACol, ARow, MoveAnchor);
  FRowSeleced := True;
end;

procedure TCustomListboxEh.DefaultDrawItem(Index: Integer; ARect: TRect;
  State: TGridDrawState);
var
  X: Integer;
  ImRect: TRect;
  ImageIndex: Integer;
  s: String;
begin
  if ImageList = nil then
  begin
    s := GetDisplayText(Index);
    Canvas.Font := Font;
    if (Index = ItemIndex) or (gdSelected in State)  then
    begin
      Canvas.Font.Color := clHighlightText;
      Canvas.Brush.Color := clHighlight
    end else
    begin
      Canvas.Font.Color := Font.Color;
      Canvas.Brush.Color := Color;
    end;
    Canvas.FillRect(ARect);
    Canvas.TextOut(ARect.Left + 2, ARect.Top, s);
  end else
  begin
    CheckStartTmpCancelCanvasRTLReflecting(ARect);
    Canvas.Font := Font;
    if gdSelected in State then
    begin
      Canvas.Brush.Color := clHighlight;
      Canvas.Font.Color := clHighlightText;
    end else
    begin
      Canvas.Font.Color := Font.Color;
      Canvas.Brush.Color := Color;
    end;
    if UseRightToLeftAlignment
      then ImRect := Rect(ARect.Right, ARect.Top, ARect.Right - ImageList.Width - 4, ARect.Bottom)
      else ImRect := Rect(0, ARect.Top, ImageList.Width + 4, ARect.Bottom);
    ImageIndex := Index;
    if Assigned(OnGetImageIndex) then
      OnGetImageIndex(Owner, Index, ImageIndex);
    Canvas.FillRect(ImRect);
    DrawImage(Canvas.Handle, ImRect, ImageList, ImageIndex, gdSelected in State);
    if UseRightToLeftAlignment
      then Dec(ARect.Right, ImageList.Width + 4)
      else Inc(ARect.Left, ImageList.Width + 4);
//    Canvas.FillRect(ARect);
    if UseRightToLeftAlignment
      then X := ARect.Right - Canvas.TextWidth(Items[Index]) - 2
      else X := ImageList.Width + 5;
    if Index = Row  then
    begin
      Canvas.Font.Color := clHighlightText;
      Canvas.Brush.Color := clHighlight
    end;
    s := GetDisplayText(Index);
    if Index < Items.Count then
      WindowsExtTextOut(Canvas.Handle, X, ARect.Top, ETO_OPAQUE or ETO_CLIPPED,
        ARect, s, Length(s));
//      DrawText(Canvas.Handle, PChar(Items[Index]), Length(Items[Index]), ARect,
//        DT_SINGLELINE or DT_VCENTER or DT_NOPREFIX);
    StopTmpCancelCanvasRTLReflecting;
  end;
end;

function TCustomListboxEh.GetCount: Integer;
begin
  if VirtualItems
    then Result := FVirtualRowCount
    else Result := Items.Count;
end;

procedure TCustomListboxEh.GetData(Index: Integer; var Data: string);
begin
  Data := Items[Index];
end;

function TCustomListboxEh.GetDisplayText(Index: Integer): String;
begin
  if UseItemObjects and
     (Index < Items.Count) and
     (Integer(Items.Objects[Index]) > 255) and
     (Items.Objects[Index] is TCustomListboxItemEh)
  then
    Result := TCustomListboxItemEh(Items.Objects[Index]).GetDisplayText(Self, Index)
  else
    GetData(Index, Result);
end;

procedure TCustomListboxEh.SetCount(const Value: Integer);
begin
  if VirtualItems then
  begin
    FVirtualRowCount := Value;
    UpdateRowCount;
  end else
    raise Exception.Create('Can''t assign Count when list is not virtual');
end;

function TCustomListboxEh.GetItemHeight: Integer;
begin
  Result := FItemHeight;
end;

procedure TCustomListboxEh.SetItemHeight(const Value: Integer);
begin
  if Value <> FItemHeight then
  begin
    FItemHeight := Value;
    DefaultRowHeight := Value;
    UpdateRowCount;
  end;
end;

function TCustomListboxEh.GetItemIndex: Integer;
begin
  if FRowSeleced
    then Result := Row
    else Result := -1;
end;

procedure TCustomListboxEh.SetItemIndex(const Value: Integer);
begin
  if Value >= 0 then
  begin
    Row := Value;
    FRowSeleced := True;
  end else
  begin
//    Row := 0;
    FRowSeleced := False;
  end;
end;

function TCustomListboxEh.GetTextHeight: Integer;
var
  DC: HDC;
  SaveFont: HFont;
  Metrics: Windows.TTextMetric;
begin
  DC := GetDC(0);
  {$IFDEF FPC}
  SaveFont := SelectObject(DC, Font.Reference.Handle);
  {$ELSE}
  SaveFont := SelectObject(DC, Font.Handle);
  {$ENDIF}
  GetTextMetrics(DC, Metrics);
  SelectObject(DC, SaveFont);
  ReleaseDC(0, DC);
  Result := Metrics.tmHeight + Metrics.tmExternalLeading + Metrics.tmInternalLeading;
end;

function TCustomListboxEh.GetTopIndex: Integer;
begin
  Result := TopRow;
end;

procedure TCustomListboxEh.SetTopIndex(const Value: Integer);
begin
  TopRow := Value;
end;

function TCustomListboxEh.ItemAtPos(Pos: TPoint; Existing: Boolean): Integer;
begin
  Result := MouseCoord(Pos.X, Pos.Y).Y;
end;

function TCustomListboxEh.ItemRect(Index: Integer): TRect;
begin
  Result := CellRect(0, Index);
end;

procedure TCustomListboxEh.ItemsChanged(Sender: TObject);
begin
  if not VirtualItems then
  begin
    UpdateRowCount;
    Invalidate;
  end;
end;

procedure TCustomListboxEh.KeyPress(var Key: Char);
var
  IsCloseListbox: Boolean;
begin
  IsCloseListbox := False;
  if (ItemIndex >= 0) and
     UseItemObjects and
     (Integer(Items.Objects[ItemIndex]) > 255) and
     (Items.Objects[ItemIndex] is TCustomListboxItemEh)
  then
    TCustomListboxItemEh(Items.Objects[ItemIndex]).
      KeyPress(Self, ItemIndex, Key, GetShiftState, IsCloseListbox);
  inherited KeyPress(Key);
end;

procedure TCustomListboxEh.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Index: Integer;
begin
  inherited MouseDown(Button, Shift, X, Y);
  Index := ItemAtPos(Point(X, Y), True);
  if (Index >= 0) and
     UseItemObjects and
     (Integer(Items.Objects[Index]) > 255) and
     (Items.Objects[Index] is TCustomListboxItemEh) then
    TCustomListboxItemEh(Items.Objects[Index]).MouseDown(Self, Index, Point(X,Y), Button, Shift);
end;

procedure TCustomListboxEh.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  Index: Integer;
begin
  inherited MouseMove(Shift, X, Y);
  Index := ItemAtPos(Point(X, Y), True);
  if (Index >= 0) and
     UseItemObjects and
     (Integer(Items.Objects[Index]) > 255) and
     (Items.Objects[Index] is TCustomListboxItemEh)
  then
    TCustomListboxItemEh(Items.Objects[Index]).MouseMove(Self, Index, Point(X,Y), Shift);
end;

procedure TCustomListboxEh.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Index: Integer;
begin
  Index := ItemAtPos(Point(X, Y), True);
  if Index = -1 then
    Index := StrictIndexToClient(X, Y);

  if (Index >= 0) and
     UseItemObjects and
     (Integer(Items.Objects[Index]) > 255) and
     (Items.Objects[Index] is TCustomListboxItemEh)
  then
    TCustomListboxItemEh(Items.Objects[Index]).MouseUp(Self, Index, Point(X,Y), Button, Shift);
  inherited MouseUp(Button, Shift, X, Y);
end;

procedure TCustomListboxEh.Resize;
begin
  inherited Resize;
  if HandleAllocated
    then ColWidths[0] := GridClientWidth
    else ColWidths[0] := Width-1;
end;

procedure TCustomListboxEh.SetItems(const Value: TStrings);
begin
  FItems.Assign(Value);
end;

function TCustomListboxEh.GetItems: TStrings;
begin
  Result := FItems;
end;

procedure TCustomListboxEh.SetSorted(const Value: Boolean);
begin
  FSorted := Value;
end;

procedure TCustomListboxEh.SetVirtualItems(const Value: Boolean);
begin
  if FVirtualItems <> Value then
  begin
    FVirtualItems := Value;
    UpdateRowCount;
  end;
end;

procedure TCustomListboxEh.UpdateRowCount;
var
  i: Integer;
begin
  if VirtualItems then
    if FVirtualRowCount = 0
      then RowCount := 1
      else RowCount := FVirtualRowCount
  else
    if Items.Count = 0
      then RowCount := 1
      else RowCount := Items.Count;

  for I := 0 to RowCount - 1 do
    RowHeights[i] := DefaultRowHeight;
end;

procedure TCustomListboxEh.SetImageList(const Value: TCustomImageList);
begin
  FImageList := Value;
end;

procedure TCustomListboxEh.InvalidateIndex(AItemIndex: Integer);
var
  AItemRect: TRect;
begin
  if AItemIndex >= 0 then
  begin
    AItemRect := ItemRect(AItemIndex);
    WindowsInvalidateRect(Handle, AItemRect, False);
  end;
end;

function TCustomListboxEh.StrictIndexToClient(X, Y: Integer): Integer;
begin
  if (X < 0) or (X >= ClientWidth) then X := 0;
  Result := ItemAtPos(Point(X, Y), True);
  if Y < 0 then Result := TopIndex;
  if Y >= ClientHeight then
  begin
    Y := ClientHeight-1;
    Result := ItemAtPos(Point(X, Y), True);
  end;
end;

{ TCustomListboxItemEh }

procedure TCustomListboxItemEh.DrawItem(Sender: TCustomListboxEh;
  ItemIndex: Integer; ARect: TRect; State: TGridDrawState);
begin
  Sender.DefaultDrawItem(ItemIndex, ARect, State);
end;

procedure TCustomListboxItemEh.Execute(Sender: TCustomListboxEh;
  ItemIndex: Integer; InItemPos: TPoint; Shift: TShiftState);
begin
end;

function TCustomListboxItemEh.GetDisplayText(Sender: TCustomListboxEh;
  ItemIndex: Integer): String;
begin
  Sender.GetData(ItemIndex, Result);
end;

function TCustomListboxItemEh.IsDataItem: Boolean;
begin
  Result := True;
end;

procedure TCustomListboxItemEh.MouseDown(Sender: TCustomListboxEh;
  ItemIndex: Integer; InItemPos: TPoint; Button: TMouseButton;
  Shift: TShiftState);
begin
end;

procedure TCustomListboxItemEh.MouseMove(Sender: TCustomListboxEh;
  ItemIndex: Integer; InItemPos: TPoint; Shift: TShiftState);
begin
end;

procedure TCustomListboxItemEh.MouseUp(Sender: TCustomListboxEh;
  ItemIndex: Integer; InItemPos: TPoint; Button: TMouseButton;
  Shift: TShiftState);
begin
end;

function TCustomListboxItemEh.CanFocus(Sender: TCustomListboxEh;
  ItemIndex: Integer): Boolean;
begin
  Result := True;
end;

procedure TCustomListboxItemEh.KeyPress(Sender: TCustomListboxEh;
  ItemIndex: Integer; var Key: Char; Shift: TShiftState;
  var IsCloseListbox: Boolean);
begin
end;

{ TPopupListboxEh }

constructor TPopupListboxEh.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  ControlStyle := ControlStyle + [csReplicatable]; //Really not Replicatable, only for CtrlGrid
  {$IFDEF FPC}
//???  Style := lbStandard;
  {$ELSE}
//???  Style := lbOwnerDrawFixed;
  {$ENDIF}
 { FSizeGrip := TSizeGripEh.Create(Self);
  TabStop := False;
  with FSizeGrip do
  begin
    Parent := Self;
    TriangleWindow := True;
  end;}
  FMousePos := Point(-1,-1);
  FMouseIndex := -1;
{$IFDEF EH_LIB_6}
{$IFDEF FPC}
{$ELSE}
//  OnData := SelfOnGetData;
  OnDataObject := SelfOnGetDataObject;
//???  AutoComplete := False;
{$ENDIF}
{$ENDIF}
end;

procedure TPopupListboxEh.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := Style or WS_CLIPCHILDREN;
//    Style := WS_CLIPCHILDREN or WS_POPUP;
{$IFDEF EH_LIB_16}
    if TStyleManager.IsCustomStyleActive then
      Style := Style or WS_BORDER
    else
{$ENDIF}
{$IFDEF FPC}
{$ELSE}
    if not Ctl3D then
{$ENDIF}
      Style := Style or WS_BORDER;
    ExStyle := (ExStyle or WS_EX_TOOLWINDOW or WS_EX_TOPMOST) and not WS_EX_CLIENTEDGE;
    WindowClass.Style := CS_SAVEBITS;
    if CheckWin32Version(5, 1) then
      WindowClass.Style := WindowClass.style or CS_DROPSHADOW;
    {$IFDEF FPC}
    Params.WndParent := GetDesktopWindow;
    {$ENDIF}
  end;
end;

procedure TPopupListboxEh.CreateWnd;
begin
  inherited CreateWnd;
  {$IFDEF FPC}
  ParentWindow := GetDesktopWindow;
  {$ELSE}
  Windows.SetParent(Handle, 0);
  {$ENDIF}
  CallWindowProc(DefWndProc, Handle, wm_SetFocus, 0, 0);
end;

function TPopupListboxEh.CheckNewSize(var NewWidth, NewHeight: Integer): Boolean;
begin
  Result := True;
  if NewWidth < GetSystemMetrics(SM_CXVSCROLL) then
    NewWidth := GetSystemMetrics(SM_CXVSCROLL);
  if NewHeight < GetSystemMetrics(SM_CYVSCROLL) then
    NewHeight := GetSystemMetrics(SM_CYVSCROLL);
end;

function TPopupListboxEh.GetBorderSize: Integer;
var
  Params: TCreateParams;
  R: TRect;
begin
  if HandleAllocated then
    Result := (Height - ClientHeight)
  else
  begin
    CreateParams(Params);
    SetRect(R, 0, 0, 0, 0);
    AdjustWindowRectEx(R, Params.Style, False, Params.ExStyle);
    Result := R.Bottom - R.Top + FBorderWidth * 2;
  end;
end;

procedure TPopupListboxEh.KeyPress(var Key: Char);
var
  TickCount: Integer;
begin
  inherited KeyPress(Key);
  case Key of
    #8, #27: FSearchText := '';
    #32..High(Char):
      begin
        TickCount := GetTickCount;
        if TickCount - FSearchTickCount > 2000 then FSearchText := '';
        FSearchTickCount := TickCount;
        if Length(FSearchText) < 32 then FSearchText := FSearchText + Key;
        SendTextMessage(Handle, LB_SelectString, WORD(-1), FSearchText);
        Key := #0;
      end;
  end;
end;

procedure TPopupListboxEh.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  Index: Integer;
begin
  inherited MouseMove(Shift, X, Y);
  Index := ItemAtPos(Point(X, Y), True);
  if Index = -1 then
    Index := StrictIndexToClient(X, Y);
  if (FMousePos.X <> X) or (FMousePos.Y <> Y) then
  begin
    if Index >= 0 then ItemIndex := Index;
    if ([ssLeft, ssRight, ssMiddle] * Shift = [])  and (FMouseIndex <> Index) then
    begin
      if FMouseIndex < Items.Count then
        InvalidateIndex(FMouseIndex);
      FMouseIndex := Index;
      InvalidateIndex(FMouseIndex);
    end;
  end;
  FMousePos := Point(X, Y);
end;

procedure TPopupListboxEh.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FIsMouseUpCloseListbox := True;
  inherited MouseDown(Button, Shift, X, Y);
end;

procedure TPopupListboxEh.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Index: Integer;
begin
  FIsMouseUpCloseListbox := True;
  Index := ItemAtPos(Point(X, Y), True);
  if Index = -1 then
    Index := StrictIndexToClient(X, Y);

  if (Index >= 0) and
     UseItemObjects and
     (Integer(Items.Objects[Index]) > 255) and
     (Items.Objects[Index] is TPopupListboxItemEh)
  then
  begin
    TPopupListboxItemEh(Items.Objects[Index]).
      MouseUp(Self, Index, Point(X,Y), Button, Shift, FIsMouseUpCloseListbox);
    if FGridState <> gsNormalEh then
      CancelMode;
    if Assigned(OnMouseUp) then OnMouseUp(Self, Button, Shift, X, Y);
  end else
    inherited MouseUp(Button, Shift, X, Y);
end;

procedure TPopupListboxEh.CMSetSizeGripChangePosition(var Message: TMessage);
var
  NewPosition: TSizeGripChangePosition;
begin
  NewPosition := TSizeGripChangePosition(Message.WParam);
  if NewPosition = sgcpToLeft then
  begin
    if SizeGripPostion = sgpTopRight then SizeGripPostion := sgpTopLeft
    else if SizeGripPostion = sgpBottomRight then SizeGripPostion := sgpBottomLeft;
  end else if NewPosition = sgcpToRight then
  begin
    if SizeGripPostion = sgpTopLeft then SizeGripPostion := sgpTopRight
    else if SizeGripPostion = sgpBottomLeft then SizeGripPostion := sgpBottomRight
  end else if NewPosition = sgcpToTop then
  begin
    if SizeGripPostion = sgpBottomRight then SizeGripPostion := sgpTopRight
    else if SizeGripPostion = sgpBottomLeft then SizeGripPostion := sgpTopLeft
  end else if NewPosition = sgcpToBottom then
  begin
    if SizeGripPostion = sgpTopRight then SizeGripPostion := sgpBottomRight
    else if SizeGripPostion = sgpTopLeft then SizeGripPostion := sgpBottomLeft
  end
end;

{$IFDEF FPC}
{$ELSE}
procedure TPopupListboxEh.CMCtl3DChanged(var Message: TMessage);
begin
  inherited;
  UpdateBorderWidth;
  RecreateWnd;
end;
{$ENDIF}

procedure TPopupListboxEh.CMMouseEnter(var Message: TMessage);
var
  AItemRect: TRect;
begin
  inherited;
  if ItemIndex >= 0 then
  begin
    AItemRect := ItemRect(ItemIndex);
    WindowsInvalidateRect(Handle, AItemRect, False);
  end;
end;

procedure TPopupListboxEh.CMMouseLeave(var Message: TMessage);
var
  AItemRect: TRect;
begin
  inherited;
  if ItemIndex >= 0 then
  begin
    AItemRect := ItemRect(ItemIndex);
    WindowsInvalidateRect(Handle, AItemRect, False);
  end;
end;

procedure TPopupListboxEh.SetRowCount(Value: Integer);
begin
  if Value < 1 then Value := 1;
  Height := Value * ItemHeight + GetBorderSize;
end;

procedure TPopupListboxEh.WMSize(var Message: TWMSize);
begin
  inherited;
//  FSizeGrip.UpdatePosition;
  FSizeGripResized := True;
  if UseRightToLeftAlignment then Invalidate;
end;

procedure TPopupListboxEh.WMNCCalcSize(var Message: TWMNCCalcSize);
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
{$IFDEF EH_LIB_16}
  if not TStyleManager.IsCustomStyleActive then
{$ENDIF}
    with Message.CalcSize_Params^ do
      InflateRect(rgrc[0], -FBorderWidth, -FBorderWidth);
end;
{$ENDIF}

procedure TPopupListboxEh.WMNCPaint(var Message: TWMNCPaint);
begin
  inherited;
  DrawBorder;
end;

procedure TPopupListboxEh.DrawBorder;
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

procedure TPopupListboxEh.WMWindowPosChanging(var Message: TWMWindowPosChanging);
{$IFDEF CIL}
var
  r: TWindowPos;
begin
  r := Message.WindowPos;
  if ComponentState * [csReading, csDestroying] = [] then
    with r do
      if (flags and SWP_NOSIZE = 0) and not CheckNewSize(cx, cy) then
        flags := flags or SWP_NOSIZE;
  Message.WindowPos := r;
  inherited;
end;
{$ELSE}
begin
  if ComponentState * [csReading, csDestroying] = [] then
    with Message.WindowPos^ do
      if (flags and SWP_NOSIZE = 0) and not CheckNewSize(cx, cy) then
        flags := flags or SWP_NOSIZE;
  inherited;
end;
{$ENDIF}

procedure TPopupListboxEh.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  BorderSize, TextHeight, Rows: Integer;
begin
  BorderSize := GetBorderSize;
  TextHeight := ItemHeight;
  if TextHeight = 0 then TextHeight := GetTextHeight;
  Rows := (AHeight - BorderSize) div TextHeight;
  if Rows < 1 then Rows := 1;
  FRowCount := Rows;
  inherited SetBounds(ALeft, ATop, AWidth, Rows * TextHeight + BorderSize);
end;

function TPopupListboxEh.DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  Result := inherited DoMouseWheelDown(Shift, MousePos);
  if not Result then
  begin
    TopIndex := TopIndex + 1;
    Result := True;
  end;
end;

function TPopupListboxEh.DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  Result := inherited DoMouseWheelUp(Shift, MousePos);
  if not Result then
  begin
    TopIndex := TopIndex - 1;
    Result := True;
  end;
end;

procedure TPopupListboxEh.UpdateBorderWidth;
begin
  {$IFDEF FPC}
  FBorderWidth := 2;
  {$ELSE}
  if Ctl3D
      then FBorderWidth := 2
      else FBorderWidth := 0;
  {$ENDIF}
end;

function TPopupListboxEh.CanFocus: Boolean;
begin
  Result := False;
end;

function TPopupListboxEh.GetExtItems: TStrings;
begin
  Result := FExtItems;
end;

procedure TPopupListboxEh.SetExtItems(Value: TStrings);
begin
  if FExtItems <> Value then
  begin
    FExtItems := Value;
    VirtualItems := (FExtItems <> nil);
  end;
end;

procedure TPopupListboxEh.GetData(Index: Integer; var Data: string);
begin
  if FExtItems <> nil then
    Data := FExtItems[Index]
  else
    inherited GetData(Index, Data);
end;

procedure TPopupListboxEh.SelfOnGetDataObject(Control: TWinControl;
  Index: Integer; var DataObject: TObject);
begin
  if FExtItems <> nil then
    DataObject := FExtItems.Objects[Index];
end;

function TPopupListboxEh.GetItems: TStrings;
begin
  if ExtItems <> nil
    then Result := ExtItems
    else Result := inherited GetItems;
end;

procedure TPopupListboxEh.SetItems(const Value: TStrings);
begin
  if ExtItems <> nil
    then ExtItems.Assign(Value)
    else inherited SetItems(Value);
end;

{ TPopupListboxItemEh }

procedure TPopupListboxItemEh.MouseUp(Sender: TCustomListboxEh;
  ItemIndex: Integer; InItemPos: TPoint; Button: TMouseButton;
  Shift: TShiftState; var IsCloseListbox: Boolean);
begin
  IsCloseListbox := CloseOnExecute(Sender, ItemIndex);
end;

function TPopupListboxItemEh.CloseOnExecute(Sender: TCustomListboxEh; ItemIndex: Integer): Boolean;
begin
  Result := True;
end;

procedure TPopupListboxItemEh.Execute(Sender: TCustomListboxEh;
  ItemIndex: Integer; InItemPos: TPoint; Shift: TShiftState);
begin
end;

{ Global routines }

procedure InitUnit;
begin
{$IFDEF EH_LIB_16}
  TCustomStyleEngine.RegisterStyleHook(TCustomGridEh, TScrollingStyleHook);
{$ENDIF}
  FGridDefaultStyleEh := TGridDrawStyleEh.Create(nil);
  {$IFDEF FPC}
  {$ELSE}
  DummyPopupListboxItemEh := TPopupListboxItemEh.Create;
  {$ENDIF}
end;

procedure FinalizeUnit;
begin
  FreeAndNil(FGridDefaultStyleEh);
  {$IFDEF FPC}
  {$ELSE}
  FreeAndNil(DummyPopupListboxItemEh);
  {$ENDIF}
//  TCustomStyleEngine.UnRegisterStyleHook(TCustomGridEh, TScrollingStyleHook);
end;

initialization
  InitUnit;
finalization
  FinalizeUnit;
end.
