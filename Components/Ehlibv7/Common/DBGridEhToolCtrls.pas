{*******************************************************}
{                                                       }
{                        EhLib v7.0                     }
{                                                       }
{          Tool Controls for DBGridEh component         }
{                      Build 7.0.027                    }
{                                                       }
{   Copyright (c) 2011-2014 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit DBGridEhToolCtrls;

interface

uses Windows, SysUtils, Classes, Controls, Forms, StdCtrls,
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
  EhLibVCL, Messages, SqlTimSt,
  {$ENDIF}
{$ENDIF}
  GridsEh, GridToolCtrlsEh, DBGridEhGrouping, DBCtrlsEh, ToolCtrlsEh,
  Graphics, DBCtrls, ExtCtrls, Db, Buttons, ImgList, Menus;

type

  TDBGridEhRes = class(TDataModule)
    IMList10: TImageList;
    IMList10D: TImageList;
    IMList12_D: TImageList;
    IMList12: TImageList;
    PopupMenu1: TPopupMenu;
    Copy1: TMenuItem;
    IMList10Bmp: TImageList;
    IMList10DBmp: TImageList;
    procedure Copy1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TDBGridEhNavigatorPanel = class;
  TNavButtonEh = class;
  TNavDataLinkEh = class;
  TNavFindButtonEh = class;
  TDBGridSearchPanelControlEh = class;

  TSearchPanelLocationEh = (splGridTopEh, splHorzScrollBarExtraPanelEh, splExternal);  //splHSBExtraPanelEh

  TSelectionInfoPanelDataItemEh = record
    Text: String;
    Start: Integer;
    Finish: Integer;
  end;

  { TDBGridEhScrollBarPanelControl }

  TDBGridEhScrollBarPanelControl = class(TGridScrollBarPanelControlEh)
  private
    FExtraPanel: TDBGridEhNavigatorPanel;
    function GetOnScroll: TScrollEvent;
    procedure SetOnScroll(const Value: TScrollEvent);

  protected
    function ScrollBatCode: Integer;
    procedure AlignControls(AControl: TControl; var Rect: TRect); override;
    procedure Resize; override;
    procedure CreateHandle; override;
    procedure OnScrollEvent(Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);

  public
    constructor Create(AOwner: TComponent; AKind: TScrollBarKind); reintroduce;
    destructor Destroy; override;
    function MaxSizeForExtraPanel: Integer;
    procedure Invalidate; override;
    procedure GridSelectionChanged;
    procedure DataSetChanged; virtual;
    procedure SetParams(APosition, AMin, AMax, APageSize: Integer);
    property OnScroll: TScrollEvent read GetOnScroll write SetOnScroll;
    property ExtraPanel: TDBGridEhNavigatorPanel read FExtraPanel;
  end;

  { TNavFindEditEh }

  TNavFindEditEh = class(TDBComboBoxEh)
  private
    FGrid: TCustomGridEh;
    FInternalChanging: Boolean;
    FIsEmptyState: Boolean;
    FMiniHeight: Boolean;
    FOnUpdateModified: TNotifyEvent;
    FTextAppliedAsFilter: Boolean;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMWantSpecialKey(var Message: TCMWantSpecialKey); message CM_WANTSPECIALKEY;
    procedure SetIsEmptyState(const Value: Boolean);
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMNCPaint(var Message: TWMNCPaint); message WM_NCPAINT;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;

  protected
    function CalcAutoHeight: Integer;
    procedure CalcEditRect(var ARect: TRect); override;
    procedure Change; override;
    procedure CheckAddTextToList;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure DoEnter; override;
    procedure DoExit; override;
    procedure DrawNonClientBorder; virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure SpecInternalSetText(AText: String);
    procedure UpdateModified;
    procedure WndProc(var Message: TMessage); override;
    property IsEmptyState: Boolean read FIsEmptyState write SetIsEmptyState;
    property Grid: TCustomGridEh read FGrid write FGrid;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure ApplySearchFilter;
    procedure CancelSearchEditorMode;

    property MiniHeight: Boolean read FMiniHeight write FMiniHeight;
    property OnUpdateModified: TNotifyEvent read FOnUpdateModified write FOnUpdateModified;
    property TextAppliedAsFilter: Boolean read FTextAppliedAsFilter write FTextAppliedAsFilter;
  end;

{ TDBGridEhNavigatorPanel }

  TGridSBItemEh = (gsbiRecordsInfoEh, gsbiNavigator, {gsbiFindEditorEh, }gsbiSelAggregationInfoEh);
  TGridSBItemsEh = set of TGridSBItemEh;

  TNavigateBtnEh = (nbFirstEh, nbPriorEh, nbNextEh, nbLastEh,
                  nbInsertEh, nbDeleteEh, nbEditEh, nbPostEh, nbCancelEh, nbRefreshEh);
  TNavButtonSetEh = set of TNavigateBtnEh;

  TDBGridEhNavigatorFindBtn = (gnfbCancelSearchFilterEh, gnfbFindNextEh, gnfbFindPrevEh, gnfbOptionsEh);
  TDBGridEhNavigatorFindBtns = set of TDBGridEhNavigatorFindBtn;

  TNavClickEh = procedure (Sender: TObject; Button: TNavigateBtnEh) of object;

  TDBGridEhNavigatorPanel = class (TCustomControl)
  private
    FDataLink: TNavDataLinkEh;
    FVisibleButtons: TNavButtonSetEh;
    FHints: TStrings;
    FDefHints: TStrings;
    ButtonWidth: Integer;
    MinBtnSize: TPoint;
    FOnNavClick: TNavClickEh;
    FBeforeAction: TNavClickEh;
    FocusedButton: TNavigateBtnEh;
    FFlat: Boolean;
    FDisabledImages: TCustomImageList;
    FImages: TCustomImageList;
    FBorderColor: TColor;
    FSelectionInfoPanelText: String;
    FVisibleItems: TGridSBItemsEh;
    FSearchPanelControl: TDBGridSearchPanelControlEh;

    function GetDataSource: TDataSource;
    function GetHints: TStrings;

    procedure BtnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ClickHandler(Sender: TObject);
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMParentFontChanged(var Message: TMessage); message CM_PARENTFONTCHANGED;
    procedure HintsChanged(Sender: TObject);
    procedure InitHints;
    procedure InitItems;
    procedure SetBorderColor(const Value: TColor);
    procedure SetDataSource(Value: TDataSource);
    procedure SetDisabledImages(const Value: TCustomImageList);
    procedure SetFlat(Value: Boolean);
    procedure SetHints(Value: TStrings);
    procedure SetImages(const Value: TCustomImageList);
    procedure SetSearchPanelControl(const Value: TDBGridSearchPanelControlEh);
    procedure SetSize(var W: Integer; var H: Integer);
    procedure SetVisibleButtons(Value: TNavButtonSetEh);
    procedure SetVisibleItems(const Value: TGridSBItemsEh);

    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMNCPaint(var Message: TWMNCPaint); message WM_NCPAINT;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMSize(var Message: TWMSize);  message WM_SIZE;
    procedure WMWindowPosChanging(var Message: TWMWindowPosChanging); message WM_WINDOWPOSCHANGING;
    function GetVisible: Boolean;
    procedure SetVisible(const Value: Boolean); {$IFDEF FPC} reintroduce; {$ENDIF}
  protected
    FindEditDivider: TNavButtonEh;
    NavButtons: array[TNavigateBtnEh] of TNavButtonEh;
    NavButtonsDivider: TNavButtonEh;
    RecordsInfoPanel: TNavButtonEh;
    SelectionInfoDivider: TNavButtonEh;
    SelectionInfoPanel: TNavButtonEh;
    SelectionInfoPanelDataEh: array of TSelectionInfoPanelDataItemEh;

    function CalcWidthForRecordsInfoPanel: Integer;
    function CalcWidthSelectionInfoPanel: Integer;
    function CanAutoSize(var NewWidth, NewHeight: Integer): Boolean; override;

    procedure ActiveChanged;
    procedure CalcMinSize(var W, H: Integer);
    procedure CreateWnd; override;
    procedure DataChanged;
    procedure DrawNonClientBorder;
    procedure EditingChanged;
    procedure GridSelectionChanged;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Paint; override;
    procedure PaintDivider(Sender: TObject);
    procedure PaintRecordsInfo(Sender: TObject);
    procedure ResetVisibleControls;
    procedure Resize; override;
    procedure SelectionInfoPanelMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function CheckConfirmDelete: Boolean;
    function DividerWidth: Integer; virtual;
    function GetSelectionInfoPanelText: String;
    function OptimalWidth: Integer;

    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    procedure NavBtnClick(Index: TNavigateBtnEh); virtual;
    procedure ResetWidth;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;

    property BeforeAction: TNavClickEh read FBeforeAction write FBeforeAction;
    property BorderColor: TColor read FBorderColor write SetBorderColor;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DisabledImages: TCustomImageList read FDisabledImages write SetDisabledImages;
    property Flat: Boolean read FFlat write SetFlat default False;
    property Hints: TStrings read GetHints write SetHints;
    property Images: TCustomImageList read FImages write SetImages;
    property SearchPanelControl: TDBGridSearchPanelControlEh read FSearchPanelControl write SetSearchPanelControl;
    property VisibleButtons: TNavButtonSetEh read FVisibleButtons write SetVisibleButtons default [nbFirstEh, nbPriorEh, nbNextEh, nbLastEh, nbInsertEh, nbDeleteEh, nbEditEh, nbPostEh, nbCancelEh, nbRefreshEh];
    property VisibleItems: TGridSBItemsEh read FVisibleItems write SetVisibleItems default [gsbiRecordsInfoEh, gsbiNavigator, gsbiSelAggregationInfoEh];
    property Visible: Boolean read GetVisible write SetVisible;
  end;

{ TNavButtonEh }

{$IFDEF FPC}
  TNavButtonStyle = set of (nsAllowTimer, nsFocusRect);
{$ENDIF}

  TNavButtonEh = class(TSpeedButton)
  private
    FDisabledImages: TCustomImageList;
    FImageIndex: Integer;
    FImages: TCustomImageList;
    FIndex: TNavigateBtnEh;
    FNavStyle: TNavButtonStyle;
    FOnPaint: TNotifyEvent;
    FRepeatTimer: TTimer;

    procedure SetDisabledImages(const Value: TCustomImageList);
    procedure SetImageIndex(const Value: Integer);
    procedure SetImages(const Value: TCustomImageList);
    procedure TimerExpired(Sender: TObject);

  protected
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Paint; override;

  public
    constructor Create(AOwner: TComponent); reintroduce;
    destructor Destroy; override;

    property DisabledImages: TCustomImageList read FDisabledImages write SetDisabledImages;
    property ImageIndex: Integer read FImageIndex write SetImageIndex;
    property Images: TCustomImageList read FImages write SetImages;
    property Index: TNavigateBtnEh read FIndex write FIndex;
    property NavStyle: TNavButtonStyle read FNavStyle write FNavStyle;
    property OnPaint: TNotifyEvent read FOnPaint write FOnPaint;
  end;

  TNavFindButtonEh = class(TNavButtonEh)
  private
    FIndex: TDBGridEhNavigatorFindBtn;
  public
    property Index: TDBGridEhNavigatorFindBtn read FIndex write FIndex;
  end;

{ TNavDataLink }

  TNavDataLinkEh = class(TDataLink)
  private
    FNavigator: TDBGridEhNavigatorPanel;
  protected
    procedure ActiveChanged; override;
    procedure DataSetChanged; override;
    procedure EditingChanged; override;
  public
    constructor Create(ANav: TDBGridEhNavigatorPanel);
    destructor Destroy; override;
  end;

{ TDBGridSearchPanelControlEh }

  TDBGridSearchPanelControlEh = class(TCustomControl)
  private
    ButtonWidth: Integer;
    FFindEditor: TNavFindEditEh;
    FGrid: TCustomGridEh;
    FindButtons: array[TDBGridEhNavigatorFindBtn] of TNavFindButtonEh;
    FLocation: TSearchPanelLocationEh;
    MinBtnSize: TPoint;

    procedure SetLocation(const Value: TSearchPanelLocationEh);
    procedure WMNCPaint(var Message: TWMNCPaint); message WM_NCPAINT;
    procedure WMSize(var Message: TWMSize);  message WM_SIZE;

  protected
    procedure BtnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ClickHandler(Sender: TObject);
    procedure CreateWnd; override;
    procedure DrawNonClientBorder; virtual;
    procedure FindBtnClick(Index: TDBGridEhNavigatorFindBtn); virtual;
    procedure FindEditorUpdateModified(Sender: TObject);
    procedure FindNext;
    procedure FindPrev;
    procedure Paint; override;
    procedure Resize; override;
    procedure SetSize(var W: Integer; var H: Integer);

  public
    constructor Create(AGrid: TCustomGridEh); reintroduce;
    destructor Destroy; override;

    function CalcAutoHeight: Integer;
    function CalcAutoWidthForHeight(ANewHeight: Integer): Integer;
    function GetSearchingText: String;
    function IsSearchingState: Boolean;

    procedure InitItems;
    procedure ResetVisibleControls;

    property FindEditor: TNavFindEditEh read FFindEditor;
    property Location: TSearchPanelLocationEh read FLocation write SetLocation default splGridTopEh;
  end;

var
  DBGridEhRes: TDBGridEhRes;

implementation

{$R *.dfm}

uses Math, Dialogs,
{$IFDEF FPC}
  DBGridsEh,
{$ELSE}
  DBGridEh, VDBConsts,
{$ENDIF}
  DBGridEhImpExp, DBAxisGridsEh,

  EhLibConsts, Clipbrd;

procedure InitRes;
begin
  DBGridEhRes := TDBGridEhRes.CreateNew(nil, -1);
  InitInheritedComponent(DBGridEhRes, TDataModule);
end;

procedure FinRes;
begin
  FreeAndNil(DBGridEhRes);
end;

type
  TCustomDBGridEhCrack = class(TCustomDBGridEh);
  TWinControlCrack = class(TWinControl);
  TDBGridSearchPanelEhCrack = class(TDBGridSearchPanelEh);

{ TDBGridEhRes }

procedure TDBGridEhRes.Copy1Click(Sender: TObject);
begin
  Clipboard.AsText := Copy1.Hint;
end;

{ TDBGridEhScrollBarPanelControl }

procedure TDBGridEhScrollBarPanelControl.AlignControls(AControl: TControl;
  var Rect: TRect);
begin
  inherited AlignControls(AControl, Rect);
end;

procedure TDBGridEhScrollBarPanelControl.Resize;
begin
  inherited Resize;
  if not HandleAllocated then Exit;
  if ExtraPanel.Visible then
  begin
    if UseRightToLeftAlignment then
    begin
      ExtraPanel.ResetWidth;
      ScrollBar.SetBounds(0, ScrollBar.Top, ClientWidth - ExtraPanel.Width, ScrollBar.Height);
      ExtraPanel.SetBounds(ScrollBar.Width, 0, ExtraPanel.Width, Height);
    end else
    begin
      ExtraPanel.SetBounds(0, 0, ExtraPanel.Width, Height);
      ExtraPanel.ResetWidth;
      ScrollBar.SetBounds(ExtraPanel.Width, ScrollBar.Top, ScrollBar.Width - ExtraPanel.Width, ScrollBar.Height);
    end;
  end;
end;

constructor TDBGridEhScrollBarPanelControl.Create(AOwner: TComponent; AKind: TScrollBarKind);
begin
  inherited Create(AOwner, AKind);

  FExtraPanel := TDBGridEhNavigatorPanel.Create(Self);
  FExtraPanel.Parent := Self;
  {$IFDEF FPC}
  {$ELSE}
  FExtraPanel.BevelEdges := [beTop, beRight];
  FExtraPanel.BevelInner := bvNone;
  FExtraPanel.BevelOuter := bvRaised;
  FExtraPanel.BevelKind := bkFlat;
  {$ENDIF}
  FExtraPanel.Visible := (AKind = sbHorizontal);
  FExtraPanel.Flat := True;
  if ThemesEnabled then
  begin
    FExtraPanel.Images := DBGridEhRes.IMList10;
    FExtraPanel.DisabledImages := DBGridEhRes.IMList10D;
  end else
  begin
    FExtraPanel.Images := DBGridEhRes.IMList10Bmp;
    FExtraPanel.DisabledImages := DBGridEhRes.IMList10DBmp;
  end;
  FExtraPanel.ParentColor := True;

  FExtraPanel.DoubleBuffered := True;

  {$IFDEF FPC}
  {$ELSE}
  ParentBackground := False;
  {$ENDIF}
  BevelOuter := bvNone;
  BevelInner := bvNone;
end;

procedure TDBGridEhScrollBarPanelControl.CreateHandle;
begin
  inherited CreateHandle;
end;

destructor TDBGridEhScrollBarPanelControl.Destroy;
begin
  inherited Destroy;
end;

function TDBGridEhScrollBarPanelControl.GetOnScroll: TScrollEvent;
begin
  Result := ScrollBar.OnScroll;
end;

procedure TDBGridEhScrollBarPanelControl.GridSelectionChanged;
begin
  ExtraPanel.GridSelectionChanged;
  Resize;
end;

procedure TDBGridEhScrollBarPanelControl.DataSetChanged;
begin
  ExtraPanel.DataChanged;
end;

procedure TDBGridEhScrollBarPanelControl.Invalidate;
var
  i: Integer;
begin
  inherited Invalidate;
  for i := 0 to ControlCount-1 do
    Controls[i].Invalidate;
end;

function TDBGridEhScrollBarPanelControl.MaxSizeForExtraPanel: Integer;
begin
  Result := Width - GetSystemMetrics(SM_CYHSCROLL) * 2;
end;

procedure TDBGridEhScrollBarPanelControl.OnScrollEvent(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
var
  Grid: TCustomDBGridEhCrack;
begin
  Grid := TCustomDBGridEhCrack(Owner);
  if UseRightToLeftAlignment then
  begin
    ScrollPos := ScrollBar.Max - ScrollPos;
    Grid.ScrollBarMessage(ScrollBatCode, Cardinal(ScrollCode), ScrollPos, True);
  end else
    Grid.ScrollBarMessage(ScrollBatCode, Cardinal(ScrollCode), ScrollPos, True);
  ScrollPos := ScrollBar.Position;
end;

function TDBGridEhScrollBarPanelControl.ScrollBatCode: Integer;
begin
  if FKind = sbHorizontal
    then Result := SB_HORZ
    else Result := SB_VERT;
end;

procedure TDBGridEhScrollBarPanelControl.SetOnScroll(const Value: TScrollEvent);
begin
  ScrollBar.OnScroll := Value;
end;

procedure TDBGridEhScrollBarPanelControl.SetParams(APosition, AMin, AMax, APageSize: Integer);
begin
  if (AMax <= AMin) or (AMax - AMin < APageSize) then
  begin
    ScrollBar.Enabled := False
  end else
  begin
    ScrollBar.Enabled := True;
    ScrollBar.PageSize := APageSize;
    ScrollBar.SetParams(APosition, AMin, AMax);
    ScrollBar.PageSize := APageSize;
  end;
end;

{ TDBGridEhNavigatorPanel }

var
  BtnHintId: array[TNavigateBtnEh] of String = (SFirstRecordEh, SPriorRecordEh,
    SNextRecordEh, SLastRecordEh, SInsertRecordEh, SDeleteRecordEh, SEditRecordEh,
    SPostEditEh, SCancelEditEh, SRefreshRecordEh);

constructor TDBGridEhNavigatorPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF EH_LIB_13}
  ControlStyle := ControlStyle - [csAcceptsControls, csSetCaption, csGestures] + [csOpaque, csNoDesignVisible];
{$ELSE}
  ControlStyle := ControlStyle - [csAcceptsControls, csSetCaption] + [csOpaque, csNoDesignVisible];
{$ENDIF}
  if not NewStyleControls then
    ControlStyle := ControlStyle + [csFramed];
  FDataLink := TNavDataLinkEh.Create(Self);
  FVisibleButtons := [nbFirstEh, nbPriorEh, nbNextEh, nbLastEh, nbInsertEh,
    nbDeleteEh, nbEditEh, nbPostEh, nbCancelEh, nbRefreshEh];
  FHints := TStringList.Create;
  TStringList(FHints).OnChange := HintsChanged;
  InitItems;
  InitHints;
  ButtonWidth := 0;
  FocusedButton := nbFirstEh;
  FVisibleItems := [gsbiRecordsInfoEh, gsbiNavigator, gsbiSelAggregationInfoEh];
  AutoSize := True;
end;

destructor TDBGridEhNavigatorPanel.Destroy;
begin
  FDefHints.Free;
  FDataLink.Free;
  FHints.Free;
  FDataLink := nil;
  inherited Destroy;
end;

procedure TDBGridEhNavigatorPanel.InitItems;
var
  I: TNavigateBtnEh;
  Btn: TNavButtonEh;
  X: Integer;
begin
  MinBtnSize := Point(10, 10);
  X := 0;

  RecordsInfoPanel := TNavButtonEh.Create(Self);
  RecordsInfoPanel.Flat := Flat;
  RecordsInfoPanel.Enabled := True;
  RecordsInfoPanel.SetBounds (X, 0, 0, 0);
  RecordsInfoPanel.Parent := Self;
  RecordsInfoPanel.OnPaint := PaintRecordsInfo;
  X := X + 24;

  NavButtonsDivider := TNavButtonEh.Create(Self);
  NavButtonsDivider.Flat := Flat;
  NavButtonsDivider.Enabled := True;
  NavButtonsDivider.SetBounds (X, 0, 0, 0);
  NavButtonsDivider.Parent := Self;
  NavButtonsDivider.OnPaint := PaintDivider;
  X := X + 7;

  for I := Low(NavButtons) to High(NavButtons) do
  begin
    Btn := TNavButtonEh.Create(Self);
    Btn.Flat := Flat;
    Btn.Index := I;
    Btn.ImageIndex := Ord(I);
    Btn.Visible := I in FVisibleButtons;
    Btn.Enabled := True;
    Btn.SetBounds (X, 0, 0, 0);
    Btn.Enabled := False;
    Btn.Enabled := True;
    Btn.OnClick := ClickHandler;
    Btn.OnMouseDown := BtnMouseDown;
    Btn.Parent := Self;
    NavButtons[I] := Btn;
    X := X + MinBtnSize.X;
  end;
  NavButtons[nbPriorEh].NavStyle := NavButtons[nbPriorEh].NavStyle + [nsAllowTimer];
  NavButtons[nbNextEh].NavStyle  := NavButtons[nbNextEh].NavStyle + [nsAllowTimer];

  FindEditDivider := TNavButtonEh.Create(Self);
  FindEditDivider.Flat := Flat;
//  FindEditDivider.Visible := False;
  FindEditDivider.Enabled := True;
  FindEditDivider.SetBounds (X, 0, 0, 0);
//  FindEditDivider.NumGlyphs := 2;
  FindEditDivider.Parent := Self;
  FindEditDivider.OnPaint := PaintDivider;
  X := X + 7;

  SelectionInfoDivider := TNavButtonEh.Create(Self);
  SelectionInfoDivider.Flat := Flat;
  SelectionInfoDivider.Enabled := True;
  SelectionInfoDivider.SetBounds (X, 0, 0, 0);
  SelectionInfoDivider.Parent := Self;
  SelectionInfoDivider.OnPaint := PaintDivider;
  X := X + 7;

  SelectionInfoPanel := TNavButtonEh.Create(Self);
  SelectionInfoPanel.Flat := Flat;
  SelectionInfoPanel.Enabled := True;
  SelectionInfoPanel.SetBounds (X, 0, 0, 0);
  SelectionInfoPanel.Parent := Self;
  SelectionInfoPanel.OnPaint := PaintRecordsInfo;
  SelectionInfoPanel.OnMouseUp := SelectionInfoPanelMouseUp;

end;

procedure TDBGridEhNavigatorPanel.GridSelectionChanged;
var
  OldWidth: Integer;
begin
  if RecordsInfoPanel.Visible and HandleAllocated then
  begin
    OldWidth := RecordsInfoPanel.Width;
    RecordsInfoPanel.Width := CalcWidthForRecordsInfoPanel;
    RecordsInfoPanel.Invalidate;
    if OldWidth <> RecordsInfoPanel.Width then
      TDBGridEhScrollBarPanelControl(Parent).Resize;
  end;

  if (gsbiSelAggregationInfoEh in VisibleItems) and HandleAllocated then
  begin
    FSelectionInfoPanelText := GetSelectionInfoPanelText;
    if FSelectionInfoPanelText <> ''
      then SelectionInfoPanel.Visible := True
      else SelectionInfoPanel.Visible := False;
    SelectionInfoDivider.Visible := SelectionInfoPanel.Visible;

    SelectionInfoPanel.Width := CalcWidthSelectionInfoPanel;
    SelectionInfoPanel.Invalidate;

    ResetWidth;
  end else
  begin
    SelectionInfoPanel.Visible := False;
    SelectionInfoDivider.Visible := SelectionInfoPanel.Visible;
    SelectionInfoPanel.Invalidate;
  end;
end;

function TDBGridEhNavigatorPanel.GetSelectionInfoPanelText: String;
var
  ResultArr: TAggrResultArr;
  Grid: TCustomDBGridEhCrack;
  FromBM, ToTB: TUniBookmarkEh;
  FieldName: String;
  PaintControl: TNavButtonEh;

  procedure SetSelectionInfoPanelData(var Item: TSelectionInfoPanelDataItemEh; Text1, Text2: String);
  begin
    Result := Result + Text1;
    Item.Text := Text2;
    Item.Start := PaintControl.Canvas.TextWidth(Result);
    Result := Result + Text2;
    Item.Finish := PaintControl.Canvas.TextWidth(Result);
  end;
  
begin
  SetLength(SelectionInfoPanelDataEh, 0);
  Grid := TCustomDBGridEhCrack(Parent.Parent);
  Result := '';
  if (Grid.Selection.SelectionType in [gstRectangle, gstColumns]) and
      (Grid.FIntMemTable <> nil) then
  begin
    if Grid.Selection.SelectionType = gstRectangle then
    begin
      FromBM := Grid.Selection.Rect.TopRow;
      ToTB := Grid.Selection.Rect.BottomRow;
      FieldName := Grid.Columns[Grid.Selection.Rect.LeftCol].FieldName;
    end else
    begin
      FromBM := NilBookmarkEh;
      ToTB := NilBookmarkEh;
      FieldName := Grid.Selection.Columns[0].FieldName;
    end;
    if FieldName = '' then Exit;
    Grid.FIntMemTable.GetAggregatedValuesForRange(
      FromBM, ToTB, FieldName, ResultArr, [agfSumEh, agfCountEh, agfAvg, agfMin, agfMax]);
    PaintControl := RecordsInfoPanel;
    PaintControl.Canvas.Font := Grid.Font;
    PaintControl.Canvas.Font.Size := GetFontSize(PaintControl.Canvas.Font, PaintControl.Canvas);
    if not VarIsNull(ResultArr[agfSumEh]) then
    begin
      SetLength(SelectionInfoPanelDataEh, Length(SelectionInfoPanelDataEh)+1);
      SetSelectionInfoPanelData(SelectionInfoPanelDataEh[Length(SelectionInfoPanelDataEh)-1],
         ' '+SGridSelectionInfo_Sum+': ', VarToStr(ResultArr[agfSumEh]));
    end;
    if not VarIsNull(ResultArr[agfCountEh]) then
    begin
      if Result <> '' then Result := Result + '   ';
      SetLength(SelectionInfoPanelDataEh, Length(SelectionInfoPanelDataEh)+1);
      SetSelectionInfoPanelData(SelectionInfoPanelDataEh[Length(SelectionInfoPanelDataEh)-1],
         ' '+SGridSelectionInfo_Cnt+': ', VarToStr(ResultArr[agfCountEh]));
    end;
    if not VarIsNull(ResultArr[agfAvg]) then
    begin
      if Result <> '' then Result := Result + '   ';
      SetLength(SelectionInfoPanelDataEh, Length(SelectionInfoPanelDataEh)+1);
      SetSelectionInfoPanelData(SelectionInfoPanelDataEh[Length(SelectionInfoPanelDataEh)-1],
         ' '+SGridSelectionInfo_Evg+': ', VarToStr(ResultArr[agfAvg]));
    end;
    if not VarIsNull(ResultArr[agfMin]) then
    begin
      if Result <> '' then Result := Result + '   ';
      SetLength(SelectionInfoPanelDataEh, Length(SelectionInfoPanelDataEh)+1);
      SetSelectionInfoPanelData(SelectionInfoPanelDataEh[Length(SelectionInfoPanelDataEh)-1],
         ' '+SGridSelectionInfo_Min+': ', VarToStr(ResultArr[agfMin]));
    end;
    if not VarIsNull(ResultArr[agfMax]) then
    begin
      if Result <> '' then Result := Result + '   ';
      SetLength(SelectionInfoPanelDataEh, Length(SelectionInfoPanelDataEh)+1);
      SetSelectionInfoPanelData(SelectionInfoPanelDataEh[Length(SelectionInfoPanelDataEh)-1],
         ' '+SGridSelectionInfo_Max+': ', VarToStr(ResultArr[agfMax]));
    end;
    if Result <> '' then Result := Result + ' ';
  end;
end;

procedure TDBGridEhNavigatorPanel.InitHints;
var
  I: Integer;
  J: TNavigateBtnEh;
begin
  if not Assigned(FDefHints) then
  begin
    FDefHints := TStringList.Create;
    for J := Low(NavButtons) to High(NavButtons) do
      FDefHints.Add(BtnHintId[J]);
  end;
  for J := Low(NavButtons) to High(NavButtons) do
    NavButtons[J].Hint := FDefHints[Ord(J)];
  J := Low(NavButtons);
  for I := 0 to (FHints.Count - 1) do
  begin
    if FHints.Strings[I] <> '' then NavButtons[J].Hint := FHints.Strings[I];
    if J = High(NavButtons) then Exit;
    Inc(J);
  end;
end;

procedure TDBGridEhNavigatorPanel.HintsChanged(Sender: TObject);
begin
  InitHints;
end;

procedure TDBGridEhNavigatorPanel.SetFlat(Value: Boolean);
var
  I: TNavigateBtnEh;
begin
  if FFlat <> Value then
  begin
    FFlat := Value;
    for I := Low(NavButtons) to High(NavButtons) do
      NavButtons[I].Flat := Value;
  end;
end;

procedure TDBGridEhNavigatorPanel.SetHints(Value: TStrings);
begin
  if Value.Text = FDefHints.Text then
    FHints.Clear else
    FHints.Assign(Value);
end;

function TDBGridEhNavigatorPanel.GetHints: TStrings;
begin
  if (csDesigning in ComponentState) and not (csWriting in ComponentState) and
     not (csReading in ComponentState) and (FHints.Count = 0) then
    Result := FDefHints else
    Result := FHints;
end;

procedure TDBGridEhNavigatorPanel.GetChildren(Proc: TGetChildProc; Root: TComponent);
begin
end;

procedure TDBGridEhNavigatorPanel.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

procedure TDBGridEhNavigatorPanel.CalcMinSize(var W, H: Integer);
var
  Count: Integer;
  I: TNavigateBtnEh;
begin
  if (csLoading in ComponentState) then Exit;
  if NavButtons[nbFirstEh] = nil then Exit;

  Count := 0;
  for I := Low(NavButtons) to High(NavButtons) do
    if NavButtons[I].Visible then
      Inc(Count);
  if Count = 0 then Inc(Count);

  W := Max(W, Count * MinBtnSize.X);
  H := Max(H, MinBtnSize.Y);

  if Align = alNone then W := (W div Count) * Count;
end;

function TDBGridEhNavigatorPanel.OptimalWidth: Integer;
var
  I: TNavigateBtnEh;
  SPanW, SPanH: Integer;
begin
  Result := 0;
  if not HandleAllocated then Exit;

  if RecordsInfoPanel.Visible then
    Inc(Result, RecordsInfoPanel.Width);
  if NavButtonsDivider.Visible then
    Inc(Result, NavButtonsDivider.Width);

  for I := Low(NavButtons) to High(NavButtons) do
    if NavButtons[I].Visible then
      Inc(Result, ClientHeight);

  if SelectionInfoPanel.Visible then
  begin
    Inc(Result, SelectionInfoDivider.Width);
    Inc(Result, SelectionInfoPanel.Width);
  end;

  if (FSearchPanelControl <> nil) and FSearchPanelControl.Visible then
  begin
    SPanW := FSearchPanelControl.CalcAutoWidthForHeight(ClientHeight);
    SPanH := FSearchPanelControl.Height;
    FSearchPanelControl.SetSize(SPanW, SPanH);
    Inc(Result, SPanW);
  end;

  Result := Result + (Width - ClientWidth);
end;

procedure TDBGridEhNavigatorPanel.ResetWidth;
var
  NewWidth: Integer;
begin
  NewWidth := OptimalWidth;
  if Parent is TDBGridEhScrollBarPanelControl  then
  begin
    if NewWidth > TDBGridEhScrollBarPanelControl(Parent).MaxSizeForExtraPanel then
      NewWidth := TDBGridEhScrollBarPanelControl(Parent).MaxSizeForExtraPanel;
  end;
  if NewWidth < 0 then NewWidth := 0;
  Width := NewWidth;
end;

procedure TDBGridEhNavigatorPanel.SetSearchPanelControl(const Value: TDBGridSearchPanelControlEh);
begin
  if FSearchPanelControl <> Value then
  begin
    if FSearchPanelControl <> nil then
      FSearchPanelControl.Parent := nil;
    FSearchPanelControl := Value;
    if FSearchPanelControl <> nil then
      FSearchPanelControl.Parent := Self;
  end;
end;

procedure TDBGridEhNavigatorPanel.Resize;
var
  NewWidth, NewHeight: Integer;
begin
  if not HandleAllocated then Exit;
  NewWidth := Width-1;
  NewHeight := Height-1;
  SetSize(NewWidth, NewHeight);
end;

procedure TDBGridEhNavigatorPanel.SetSize(var W: Integer; var H: Integer);
var
  I: TNavigateBtnEh;
  Space{, Temp, Remain}: Integer;
  X: Integer;

  procedure SetNavButton(NavB: TNavButtonEh);
  begin
    if NavB.Visible then
    begin
      Space := 0;
      if UseRightToLeftAlignment then
        Dec(X, ButtonWidth + Space);
      NavB.SetBounds(X, 0, ButtonWidth + Space, H);
      if not UseRightToLeftAlignment then
        Inc(X, ButtonWidth + Space);
    end
    else
      NavB.SetBounds(Width + 1, 0, ButtonWidth, Height);
  end;

begin
  if (csLoading in ComponentState) then Exit;
  if NavButtons[nbFirstEh] = nil then Exit;

  ButtonWidth := H;

  if UseRightToLeftAlignment
    then X := ClientWidth
    else X := 0;

  if RecordsInfoPanel.Visible then
  begin
    if UseRightToLeftAlignment then
      Dec(X, RecordsInfoPanel.Width);
    RecordsInfoPanel.SetBounds(X, 0, RecordsInfoPanel.Width, H);
    if not UseRightToLeftAlignment then
      Inc(X, RecordsInfoPanel.Width);
  end else
    RecordsInfoPanel.SetBounds(0, 0, 0, 0);

  if NavButtonsDivider.Visible then
  begin
    if UseRightToLeftAlignment then
      Dec(X, DividerWidth);
    NavButtonsDivider.SetBounds(X, 0, DividerWidth, H);
    if not UseRightToLeftAlignment then
      Inc(X, NavButtonsDivider.Width);
  end else
    NavButtonsDivider.SetBounds(0, 0, 0, 0);

  if UseRightToLeftAlignment then
    for I := nbLastEh downto nbFirstEh do
      SetNavButton(NavButtons[I])
  else
    for I := nbFirstEh to nbLastEh do
      SetNavButton(NavButtons[I]);

  for I := nbInsertEh to High(NavButtons) do
    SetNavButton(NavButtons[I]);

  if (FSearchPanelControl <> nil) then
    if FSearchPanelControl.Visible then
    begin
      if UseRightToLeftAlignment then
        Dec(X, FSearchPanelControl.CalcAutoWidthForHeight(H));
      FSearchPanelControl.SetBounds(X, 0, FSearchPanelControl.CalcAutoWidthForHeight(H), H);
      if not UseRightToLeftAlignment then
        Inc(X, FSearchPanelControl.Width);
    end else
      FSearchPanelControl.SetBounds(0, 0, 0, 0);

  if SelectionInfoDivider.Visible then
  begin
    if UseRightToLeftAlignment then
      Dec(X, SelectionInfoDivider.Width);
    SelectionInfoDivider.SetBounds(X, 0, SelectionInfoDivider.Width, H);
    if not UseRightToLeftAlignment then
      Inc(X, SelectionInfoDivider.Width);
  end else
    SelectionInfoDivider.SetBounds(0, 0, 0, 0);

  if SelectionInfoDivider.Visible then
  begin
    if UseRightToLeftAlignment then
      Dec(X, SelectionInfoPanel.Width);
    SelectionInfoPanel.SetBounds(X, 0, SelectionInfoPanel.Width, H);
    if not UseRightToLeftAlignment then
      Inc(X, SelectionInfoPanel.Width);
  end else
    SelectionInfoPanel.SetBounds(0, 0, 0, 0);

  if UseRightToLeftAlignment
    then W := ClientWidth - X
    else W := X;
end;

procedure TDBGridEhNavigatorPanel.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  W, H: Integer;
begin
  W := AWidth;
  H := AHeight;
//  if not HandleAllocated then SetSize(W, H);

  inherited SetBounds(ALeft, ATop, W, H);
end;

procedure TDBGridEhNavigatorPanel.WMSize(var Message: TWMSize);
begin
  inherited;
end;

procedure TDBGridEhNavigatorPanel.WMWindowPosChanging(var Message: TWMWindowPosChanging);
begin
  inherited;
end;

procedure TDBGridEhNavigatorPanel.ClickHandler(Sender: TObject);
begin
  NavBtnClick(TNavButtonEh(Sender).Index);
end;

procedure TDBGridEhNavigatorPanel.BtnMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  OldFocus: TNavigateBtnEh;
  Grid: TCustomDBGridEhCrack;
begin
  OldFocus := FocusedButton;
  Grid := TCustomDBGridEhCrack(Parent.Parent);
  Grid.AcquireFocus;
  FocusedButton := TNavButtonEh(Sender).Index;
  if TabStop and (GetFocus <> Handle) and CanFocus then
  begin
    SetFocus;
    if (GetFocus <> Handle) then
      Exit;
  end
  else if TabStop and (GetFocus = Handle) and (OldFocus <> FocusedButton) then
  begin
    NavButtons[OldFocus].Invalidate;
    NavButtons[FocusedButton].Invalidate;
  end;
end;

procedure TDBGridEhNavigatorPanel.NavBtnClick(Index: TNavigateBtnEh);
var
  Grid: TCustomDBGridEhCrack;
  DS: TDataSet;
  Processed: Boolean;
begin
  Grid := TCustomDBGridEhCrack(Parent.Parent);
  if (DataSource <> nil) and (DataSource.State <> dsInactive) then
  begin
    if not (csDesigning in ComponentState) and Assigned(FBeforeAction) then
      FBeforeAction(Self, Index);
    Processed := False;
    TCustomDBGridEhCrack(Parent.Parent).NavigatorPanelButtonClick(Index, Processed);
    if not Processed then
    begin
      DS := DataSource.DataSet;
      begin
        case Index of
          nbPriorEh: DS.Prior;
          nbNextEh: DS.Next;
          nbFirstEh: DS.First;
          nbLastEh: DS.Last;
          nbInsertEh:
            if alopInsertEh in Grid.AllowedOperations
              then DS.Insert
              else DS.Append;
          nbEditEh: DS.Edit;
          nbCancelEh: DS.Cancel;
          nbPostEh: DS.Post;
          nbRefreshEh: DS.Refresh;
          nbDeleteEh:
            if Grid.Selection.SelectionType in [gstRecordBookmarks, gstAll] then
              DBGridEh_DoDeleteAction(Grid, False)
            else if not CheckConfirmDelete or
               {$IFDEF FPC}
                        (MessageDlg('SDeleteRecordQuestion', mtConfirmation, mbOKCancel, 0) <> idCancel)
               {$ELSE}
                        (MessageDlg(SDeleteRecordQuestion, mtConfirmation, mbOKCancel, 0) <> idCancel)
               {$ENDIF}
            then
             DS. Delete;
        end;
      end;
    end;
  end;
  if not (csDesigning in ComponentState) and Assigned(FOnNavClick) then
    FOnNavClick(Self, Index);
end;

procedure TDBGridEhNavigatorPanel.WMSetFocus(var Message: TWMSetFocus);
begin
  NavButtons[FocusedButton].Invalidate;
end;

procedure TDBGridEhNavigatorPanel.WMKillFocus(var Message: TWMKillFocus);
begin
  NavButtons[FocusedButton].Invalidate;
end;

procedure TDBGridEhNavigatorPanel.KeyDown(var Key: Word; Shift: TShiftState);
var
  NewFocus: TNavigateBtnEh;
  OldFocus: TNavigateBtnEh;
begin
  OldFocus := FocusedButton;
  case Key of
    VK_RIGHT:
      begin
        if OldFocus < High(NavButtons) then
        begin
          NewFocus := OldFocus;
          repeat
            NewFocus := Succ(NewFocus);
          until (NewFocus = High(NavButtons)) or (NavButtons[NewFocus].Visible);
          if NavButtons[NewFocus].Visible then
          begin
            FocusedButton := NewFocus;
            NavButtons[OldFocus].Invalidate;
            NavButtons[NewFocus].Invalidate;
          end;
        end;
      end;
    VK_LEFT:
      begin
        NewFocus := FocusedButton;
        repeat
          if NewFocus > Low(NavButtons) then
            NewFocus := Pred(NewFocus);
        until (NewFocus = Low(NavButtons)) or (NavButtons[NewFocus].Visible);
        if NewFocus <> FocusedButton then
        begin
          FocusedButton := NewFocus;
          NavButtons[OldFocus].Invalidate;
          NavButtons[FocusedButton].Invalidate;
        end;
      end;
    VK_SPACE:
      begin
        if NavButtons[FocusedButton].Enabled then
          NavButtons[FocusedButton].Click;
      end;
  end;
end;

procedure TDBGridEhNavigatorPanel.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  Message.Result := DLGC_WANTARROWS;
end;

procedure TDBGridEhNavigatorPanel.DataChanged;
var
  UpEnable, DnEnable: Boolean;
  Grid: TCustomDBGridEhCrack;
  CanModify: Boolean;
  OnDataRow{, OnGroupCaptionRow, OnGroupFotterTopRow, OnGroupFotterNotTopRow}: Boolean;
begin
  if csDestroying in ComponentState then Exit;
  Grid := TCustomDBGridEhCrack(Parent.Parent);
  if not Grid.HandleAllocated then Exit;
  UpEnable := Enabled and FDataLink.Active and (FDataLink.DataSet <> nil) and not FDataLink.DataSet.BOF;
  DnEnable := Enabled and FDataLink.Active and (FDataLink.DataSet <> nil) and not FDataLink.DataSet.EOF;
  CanModify := Enabled and FDataLink.Active and (FDataLink.DataSet <> nil) and
    FDataLink.DataSet.CanModify and not Grid.ReadOnly;
  if Grid.DataGrouping.IsGroupingWorks and
     (Grid.DataGrouping.CurDataNode <> nil)then
  begin
    OnDataRow := (Grid.DataGrouping.CurDataNode.NodeType = dntDataSetRecordEh);
  end else
  begin
    OnDataRow := True;
  end;
  NavButtons[nbFirstEh].Enabled := UpEnable;
  NavButtons[nbPriorEh].Enabled := UpEnable;
  NavButtons[nbNextEh].Enabled := DnEnable;
  NavButtons[nbLastEh].Enabled := DnEnable;
  NavButtons[nbDeleteEh].Enabled := CanModify and
    (alopDeleteEh in Grid.AllowedOperations) and
    not (FDataLink.DataSet.BOF and FDataLink.DataSet.EOF) and OnDataRow;
  NavButtons[nbEditEh].Enabled := CanModify and not FDataLink.Editing and
    not FDataLink.Editing and (alopUpdateEh in Grid.AllowedOperations) and OnDataRow;
  NavButtons[nbInsertEh].Enabled := CanModify and
   ( (alopInsertEh in Grid.AllowedOperations) or (alopAppendEh in Grid.AllowedOperations) )
   and OnDataRow;
  if not NavButtons[nbInsertEh].Enabled and (FDataLink.DataSet <> nil) and FDataLink.DataSet.IsEmpty then
    NavButtons[nbEditEh].Enabled := False;

  NavButtons[nbPostEh].Enabled := CanModify and FDataLink.Editing;
  NavButtons[nbCancelEh].Enabled := CanModify and FDataLink.Editing;
  NavButtons[nbRefreshEh].Enabled := True;

  GridSelectionChanged;
end;

procedure TDBGridEhNavigatorPanel.EditingChanged;
begin
  DataChanged;
end;

procedure TDBGridEhNavigatorPanel.ActiveChanged;
var
  I: TNavigateBtnEh;
begin
  if not (Enabled and FDataLink.Active) then
    for I := Low(NavButtons) to High(NavButtons) do
      NavButtons[I].Enabled := False
  else
  begin
    DataChanged;
    EditingChanged;
  end;
end;

procedure TDBGridEhNavigatorPanel.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  if not (csLoading in ComponentState) then
    ActiveChanged;
end;

procedure TDBGridEhNavigatorPanel.SetDataSource(Value: TDataSource);
begin
  if FDataLink.DataSource <> Value then
  begin
    FDataLink.DataSource := Value;
    if not (csLoading in ComponentState) then
      ActiveChanged;
    if Value <> nil then Value.FreeNotification(Self);
  end;  
end;

function TDBGridEhNavigatorPanel.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TDBGridEhNavigatorPanel.Loaded;
var
  W, H: Integer;
begin
  inherited Loaded;
  W := Width-1;
  H := Height-1;
  SetSize(W, H);
  if (W <> Width) or (H <> Height) then
    inherited SetBounds (Left, Top, W, H);
  InitHints;
  ActiveChanged;
end;

procedure TDBGridEhNavigatorPanel.SetDisabledImages(const Value: TCustomImageList);
begin
  FDisabledImages := Value;
  ResetVisibleControls;
end;

procedure TDBGridEhNavigatorPanel.SetImages(const Value: TCustomImageList);
begin
  FImages := Value;
  ResetVisibleControls;
end;

procedure TDBGridEhNavigatorPanel.DrawNonClientBorder;
var
  DC, OldDC: HDC;
  R, R1: TRect;

  procedure DrawPolyline(Points: array of TPoint);
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

begin
  if True {Flat and (BorderStyle = bsSingle) and (Ctl3D = True} then
  begin
    DC := GetWindowDC(Handle);
    try
      GetWindowRect(Handle, R);
      OffsetRect(R, -R.Left, -R.Top);

      begin
        R1 := R;
        OldDC := Canvas.Handle;
        Canvas.Handle := DC;
        Canvas.Pen.Color := BorderColor;
        DrawPolyline([Point(R1.Left, R1.Top),
                      Point(R1.Right-1, R1.Top),
                      Point(R1.Right-1, R1.Bottom)]);
        Canvas.Handle := OldDC;
      end;
    finally
      ReleaseDC(Handle, DC);
    end;
  end;
end;

procedure TDBGridEhNavigatorPanel.WMNCPaint(var Message: TWMNCPaint);
begin
  DrawNonClientBorder;
end;

procedure TDBGridEhNavigatorPanel.SelectionInfoPanelMouseUp(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var
  i: Integer;
  p: TPoint;
begin
  for i := 0 to Length(SelectionInfoPanelDataEh)-1 do
  begin
    if (X >= SelectionInfoPanelDataEh[i].Start) and (X <= SelectionInfoPanelDataEh[i].Finish) then
    begin
      p := SelectionInfoPanel.ClientToScreen(Point(X, Y));
      DBGridEhRes.PopupMenu1.Items[0].Hint := SelectionInfoPanelDataEh[i].Text;
      DBGridEhRes.PopupMenu1.Popup(p.X, p.y);
      Exit;
    end;
  end;
end;

procedure TDBGridEhNavigatorPanel.CMParentFontChanged(var Message: TMessage);
var
  Grid: TCustomDBGridEhCrack;
begin
  inherited;
  Grid := TCustomDBGridEhCrack(Parent.Parent);
  if Grid = nil then Exit;
  if SearchPanelControl <> nil then
  begin
    SearchPanelControl.FindEditor.Font.Name := Grid.Font.Name;
    SearchPanelControl.FindEditor.Font.Charset := Grid.Font.Charset;
  end;
end;

procedure TDBGridEhNavigatorPanel.PaintDivider(Sender: TObject);
var
  R: TRect;
begin
  TNavButtonEh(Sender).Canvas.Pen.Color := BorderColor;
  R := Rect(0, 0, TNavButtonEh(Sender).Width, TNavButtonEh(Sender).Height);
  TNavButtonEh(Sender).Canvas.Polyline([Point(R.Left, R.Top), Point(R.Left, R.Bottom)]);
end;

procedure TDBGridEhNavigatorPanel.PaintRecordsInfo(Sender: TObject);
var
  Grid: TCustomDBGridEhCrack;
  PaintControl: TNavButtonEh;
  R: TRect;
  Text: String;
begin
  Grid := TCustomDBGridEhCrack(Parent.Parent);
  if Grid.DataLink.Active then
  begin
    PaintControl := TNavButtonEh(Sender);
    if PaintControl = RecordsInfoPanel then
    begin
      PaintControl.Canvas.Font.Name := Grid.Font.Name;
      PaintControl.Canvas.Font.Size := GetFontSize(Font, PaintControl.Canvas) - 1;
      PaintControl.Canvas.Font.Color := Grid.FInternalFontColor;
      if Grid.DataLink.Active and Grid.DataLink.DataSet.Active then
        Text := IntToStr(Grid.DataLink.DataSet.RecordCount);
      if Grid.SelectedRows.Count > 0 then
        Text := Text + ' (' + IntToStr(Grid.SelectedRows.Count) + ')';
      R := Rect(0, 0, PaintControl.Width, PaintControl.Height);
      WriteTextEh(PaintControl.Canvas, R, False, 0, 0, Text,
        taCenter, tlCenter, False, False, 1, 1, UseRightToLeftReading, False);
    end else if PaintControl = SelectionInfoPanel then
    begin
      PaintControl.Canvas.Font.Name := Grid.Font.Name;
      PaintControl.Canvas.Font.Size := GetFontSize(Font, PaintControl.Canvas);
      PaintControl.Canvas.Font.Color := Grid.FInternalFontColor;
      R := Rect(0, 0, PaintControl.Width, PaintControl.Height);
      WriteTextEh(PaintControl.Canvas, R, False, 0, 0, FSelectionInfoPanelText,
        taCenter, tlCenter, False, False, 0, 0, UseRightToLeftReading, False);
    end;
  end;
end;

function TDBGridEhNavigatorPanel.CalcWidthForRecordsInfoPanel: Integer;
var
  Grid: TCustomDBGridEhCrack;
  PaintControl: TNavButtonEh;
  Text: String;
begin
  Result := 0;
  Grid := TCustomDBGridEhCrack(Parent.Parent);
  if Grid.DataLink.Active and Grid.DataLink.DataSet.Active then
  begin
    PaintControl := RecordsInfoPanel;
    PaintControl.Canvas.Font := Grid.Font;
    PaintControl.Canvas.Font.Size := GetFontSize(PaintControl.Canvas.Font, PaintControl.Canvas) - 1;
    Text := IntToStr(Grid.DataLink.DataSet.RecordCount);
    if Grid.SelectedRows.Count > 0 then
      Text := Text + ' (' + IntToStr(Grid.SelectedRows.Count) + ')';
    Result := PaintControl.Canvas.TextWidth(' ' + Text + ' ');
    if Grid.IndicatorColVisible and (Result < Grid.CalcIndicatorColWidth) then
      Result := Grid.CalcIndicatorColWidth;
  end;
end;

function TDBGridEhNavigatorPanel.CalcWidthSelectionInfoPanel: Integer;
var
  Grid: TCustomDBGridEhCrack;
  PaintControl: TNavButtonEh;
//  R: TRect;
  Text: String;
begin
  Result := 0;
  Grid := TCustomDBGridEhCrack(Parent.Parent);
  if Grid.DataLink.Active then
  begin
    PaintControl := RecordsInfoPanel;
    PaintControl.Canvas.Font := Grid.Font;
    PaintControl.Canvas.Font.Size := GetFontSize(PaintControl.Canvas.Font, PaintControl.Canvas);
    Text := FSelectionInfoPanelText;
    Result := PaintControl.Canvas.TextWidth(' ' + Text + ' ');
    if Grid.IndicatorColVisible and (Result < Grid.CalcIndicatorColWidth) then
      Result := Grid.CalcIndicatorColWidth;
  end;
end;

function TDBGridEhNavigatorPanel.CanAutoSize(var NewWidth,
  NewHeight: Integer): Boolean;
var
  W, H: Integer;
begin
  W := NewWidth-1;
  H := NewHeight-1;
  SetSize(W, H);
  Result := True;
end;

procedure TDBGridEhNavigatorPanel.CreateWnd;
var
  W, H: Integer;
begin
  inherited CreateWnd;
  GridSelectionChanged;
  W := Width-1;
  H := Height-1;
  SetSize(W, H);
  TDBGridEhScrollBarPanelControl(Owner).Resize;
end;

procedure TDBGridEhNavigatorPanel.Paint;
var
  Grid: TCustomDBGridEhCrack;
  ARect: TRect;
begin
  Grid := TCustomDBGridEhCrack(Parent.Parent);
  if Grid.Flat then
  begin
    Grid.SetInternalColors;
    ARect := GetClientRect;
    FillGradientEh(Canvas, ARect, Grid.FInternalColor, Grid.FInternalFixedColor)
  end else
    inherited Paint;
end;

procedure TDBGridEhNavigatorPanel.SetVisibleItems(const Value: TGridSBItemsEh);
var
  Grid: TCustomDBGridEhCrack;
begin
  if FVisibleItems <> Value then
  begin
    FVisibleItems := Value;
    ResetVisibleControls;
    if (Parent <> nil) and (Parent.Parent <> nil) then
    begin
      Grid := TCustomDBGridEhCrack(Parent.Parent);
      Grid.Invalidate;
    end;
  end;
end;

procedure TDBGridEhNavigatorPanel.SetVisibleButtons(Value: TNavButtonSetEh);
begin
  if FVisibleButtons <> Value then
  begin
    FVisibleButtons := Value;
    ResetVisibleControls;
  end;
end;

procedure TDBGridEhNavigatorPanel.ResetVisibleControls;
var
  I: TNavigateBtnEh;
  NeedSeparator, NeedSeparator1: Boolean;
begin

  NeedSeparator1 := False;
  RecordsInfoPanel.Visible := gsbiRecordsInfoEh in VisibleItems;
  NeedSeparator := RecordsInfoPanel.Visible;
  NavButtonsDivider.Visible := False;

  for I := Low(NavButtons) to High(NavButtons) do
  begin
    NavButtons[I].Visible := (I in FVisibleButtons) and (gsbiNavigator in VisibleItems);
    if NavButtons[I].Visible then
      NeedSeparator1 := True;
    if NeedSeparator and NavButtons[I].Visible then
      NavButtonsDivider.Visible := True;
    NavButtons[I].Images := Images;
    NavButtons[I].DisabledImages := DisabledImages;
  end;

  if NeedSeparator1 then NeedSeparator := True;

  if (SearchPanelControl <> nil) and NeedSeparator
    then FindEditDivider.Visible := True
    else FindEditDivider.Visible := False;

  GridSelectionChanged;

  TDBGridEhScrollBarPanelControl(Owner).Resize;
  Invalidate;
end;

function TDBGridEhNavigatorPanel.DividerWidth: Integer;
begin
  Result := 7;
end;

procedure TDBGridEhNavigatorPanel.SetBorderColor(const Value: TColor);
begin
  if Value <> FBorderColor then
  begin
    FBorderColor := Value;
    if HandleAllocated then
      Invalidate;
  end;
end;

function TDBGridEhNavigatorPanel.CheckConfirmDelete: Boolean;
var
  Grid: TCustomDBGridEhCrack;
begin
  Grid := TCustomDBGridEhCrack(Parent.Parent);
  Result := dgConfirmDelete in Grid.Options;
end;

procedure TDBGridEhNavigatorPanel.SetVisible(const Value: Boolean);
begin
  if Visible <> Value then
  begin
    inherited Visible := Value;
    TDBGridEhScrollBarPanelControl(Owner).Resize;
  end;
end;

function TDBGridEhNavigatorPanel.GetVisible: Boolean;
begin
  Result := inherited Visible;
end;

{TNavButtonEh}

constructor TNavButtonEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
//    ControlStyle := ControlStyle + [csOpaque];
  Color := clMenu;
end;

destructor TNavButtonEh.Destroy;
begin
  if FRepeatTimer <> nil then
    FRepeatTimer.Free;
  inherited Destroy;
end;

procedure TNavButtonEh.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited MouseDown (Button, Shift, X, Y);
  if nsAllowTimer in FNavStyle then
  begin
    if FRepeatTimer = nil then
      FRepeatTimer := TTimer.Create(Self);

    FRepeatTimer.OnTimer := TimerExpired;
    FRepeatTimer.Interval := InitRepeatPause;
    FRepeatTimer.Enabled  := True;
  end;
end;

procedure TNavButtonEh.MouseUp(Button: TMouseButton; Shift: TShiftState;
                                  X, Y: Integer);
begin
  inherited MouseUp (Button, Shift, X, Y);
  if FRepeatTimer <> nil then
    FRepeatTimer.Enabled  := False;
end;

procedure TNavButtonEh.TimerExpired(Sender: TObject);
begin
  FRepeatTimer.Interval := RepeatPause;
  if (FState = bsDown) and MouseCapture then
  begin
    try
      Click;
    except
      FRepeatTimer.Enabled := False;
      raise;
    end;
  end;
end;

procedure TNavButtonEh.Paint;
const
  DownStyles: array[Boolean] of Integer = (BDR_RAISEDINNER, BDR_SUNKENOUTER);
  FillStyles: array[Boolean] of Integer = (BF_MIDDLE, 0);
var
  R: TRect;
  PaintRect: TRect;
  DrawFlags: Integer;
  Offset: TPoint;
  Button: TThemedButton;
  ToolButton: TThemedToolBar;
  Details: TThemedElementDetails;
  DrawImages: TCustomImageList;
begin
  if Assigned(FOnPaint) then
  begin
    FOnPaint(Self);
    Exit;
  end;
  if not Enabled then
  begin
    FState := bsDisabled;
//    Dragging := False;
  end
  else if FState = bsDisabled then
    if Down and (GroupIndex <> 0) then
      FState := bsExclusive
    else
      FState := bsUp;
  Canvas.Font := Self.Font;

  if ThemeServices.ThemesEnabled then
  begin
//    PerformEraseBackground(Self, Canvas.Handle);

    if not Enabled then
      Button := tbPushButtonDisabled
    else
      if FState in [bsDown, bsExclusive] then
        Button := tbPushButtonPressed
      else
        if MouseInControl then
          Button := tbPushButtonHot
        else
          Button := tbPushButtonNormal;

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
          Toolbutton := ttbButtonNormal;
      end;
    end;

    PaintRect := ClientRect;
    if ToolButton = ttbToolbarDontCare then
    begin
      Details := ThemeServices.GetElementDetails(Button);
      ThemeServices.DrawElement(Canvas.Handle, Details, PaintRect);
      PaintRect := ThemeServices.ContentRect(Canvas.Handle, Details, PaintRect);
    end
    else
    begin
      Details := ThemeServices.GetElementDetails(ToolButton);
      ThemeServices.DrawElement(Canvas.Handle, Details, PaintRect);
      PaintRect := ThemeServices.ContentRect(Canvas.Handle, Details, PaintRect);
    end;

    if Button = tbPushButtonPressed then
    begin
      // A pressed speed button has a white text. This applies however only to flat NavButtons.
      if ToolButton <> ttbToolbarDontCare then
        Canvas.Font.Color := StyleServices.GetSystemColor(clHighlightText);
      Offset := Point(1, 0);
    end
    else
      Offset := Point(0, 0);

    if Enabled
      then DrawImages := Images
      else DrawImages := DisabledImages;

    DrawClipped(DrawImages, nil, Canvas, PaintRect, ImageIndex, Offset.X, taCenter, PaintRect);

  end else // not ThemeServices.ThemesEnabled
  begin
    PaintRect := Rect(0, 0, Width, Height);
    if not Flat then
    begin
      DrawFlags := DFCS_BUTTONPUSH or DFCS_ADJUSTRECT;
      if FState in [bsDown, bsExclusive] then
        DrawFlags := DrawFlags or DFCS_PUSHED;
      DrawFrameControl(Canvas.Handle, PaintRect, DFC_BUTTON, DrawFlags);
    end
    else
    begin
      if (FState in [bsDown, bsExclusive]) or
        (MouseInControl and (FState <> bsDisabled)) or
        (csDesigning in ComponentState) then
        DrawEdge(Canvas.Handle, PaintRect, DownStyles[FState in [bsDown, bsExclusive]],
          FillStyles[Transparent] or BF_RECT)
      else if not Transparent then
      begin
        Canvas.Brush.Color := Color;
        Canvas.FillRect(PaintRect);
      end;
      InflateRect(PaintRect, -1, -1);
    end;
    if FState in [bsDown, bsExclusive] then
    begin
      if (FState = bsExclusive) and (not Flat or not MouseInControl) then
      begin
        {$IFDEF FPC}
        {$ELSE}
        Canvas.Brush.Bitmap := AllocPatternBitmap(clBtnFace, clBtnHighlight);
        {$ENDIF}
        Canvas.FillRect(PaintRect);
      end;
      Offset.X := 1;
      Offset.Y := 1;
    end
    else
    begin
      Offset.X := 0;
      Offset.Y := 0;
    end;

    if Enabled
      then DrawImages := Images
      else DrawImages := DisabledImages;
    DrawClipped(DrawImages, nil, Canvas, PaintRect, ImageIndex, Offset.X, taCenter, PaintRect);

  end;

  if (GetFocus = Parent.Handle) and
     (FIndex = TDBGridEhNavigatorPanel (Parent).FocusedButton) then
  begin
    R := Bounds(0, 0, Width, Height);
    InflateRect(R, -3, -3);
    if FState = bsDown then
      OffsetRect(R, 1, 1);
    Canvas.Brush.Style := bsSolid;
    Font.Color := clBtnShadow;
    DrawFocusRect(Canvas.Handle, R);
  end;
end;

procedure TNavButtonEh.SetImageIndex(const Value: Integer);
begin
  if FImageIndex <> Value then
  begin
    FImageIndex := Value;
    Invalidate;
  end;
end;

procedure TNavButtonEh.SetDisabledImages(const Value: TCustomImageList);
begin
  FDisabledImages := Value;
end;

procedure TNavButtonEh.SetImages(const Value: TCustomImageList);
begin
  FImages := Value;
end;

{ TNavDataLinkEh }

constructor TNavDataLinkEh.Create(ANav: TDBGridEhNavigatorPanel);
begin
  inherited Create;
  FNavigator := ANav;
  VisualControl := True;
end;

destructor TNavDataLinkEh.Destroy;
begin
  FNavigator := nil;
  inherited Destroy;
end;

procedure TNavDataLinkEh.EditingChanged;
begin
  if FNavigator <> nil then FNavigator.EditingChanged;
end;

procedure TNavDataLinkEh.DataSetChanged;
begin
  if FNavigator <> nil then FNavigator.DataChanged;
end;

procedure TNavDataLinkEh.ActiveChanged;
begin
  if FNavigator <> nil then FNavigator.ActiveChanged;
end;

{ TNavFindEditEh }

constructor TNavFindEditEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  TStringList(Items).Duplicates := dupIgnore;
  TStringList(Items).Sorted := True;
  TextAppliedAsFilter := True;
  CaseInsensitiveTextSearch := False;
end;

destructor TNavFindEditEh.Destroy;
begin
  inherited Destroy;
end;

procedure TNavFindEditEh.Change;
var
  AGrid: TCustomDBGridEhCrack;
begin
  inherited Change;
  if FInternalChanging then Exit;
  AGrid := TCustomDBGridEhCrack(Grid);
  TDBGridSearchPanelEhCrack(AGrid.SearchPanel).InterSetSearchingText(Text);
  if not FInternalChanging {and (Text <> '')} then
    AGrid.SearchPanel.RestartFind(DBGridEhSearchPanelInitFindTimeOut);
  TextAppliedAsFilter := False;
  UpdateModified;
end;

procedure TNavFindEditEh.CMMouseEnter(var Message: TMessage);
begin
  Color := StyleServices.GetSystemColor(clWindow);
  inherited;
end;

procedure TNavFindEditEh.CMMouseLeave(var Message: TMessage);
begin
  if not Focused then
    Color := ApproximateColor(
      StyleServices.GetSystemColor(TWinControlCrack(Parent).Color),
      StyleServices.GetSystemColor(clWindow), 256 div 3 * 2);
  inherited;
end;

procedure TNavFindEditEh.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  {$IFDEF FPC}
  Params.Style := Params.Style or WS_BORDER;
  Params.ExStyle := Params.ExStyle and not WS_EX_CLIENTEDGE;
  {$ELSE}
  {$ENDIF}
end;

procedure TNavFindEditEh.CreateWnd;
begin
  inherited CreateWnd;
  Color := ApproximateColor(StyleServices.GetSystemColor(TWinControlCrack(Parent).Color),
    StyleServices.GetSystemColor(clWindow), 256 div 3 * 2);
end;

procedure TNavFindEditEh.DoEnter;
begin
  Color := StyleServices.GetSystemColor(clWindow);
  Font.Color := StyleServices.GetSystemColor(clWindowText);
  if IsEmptyState then
    SpecInternalSetText('');
  inherited DoEnter;
end;

procedure TNavFindEditEh.DoExit;
begin
  Color := ApproximateColor(TWinControlCrack(Parent).Color, clWindow, 256 div 3 * 2);
  if Text = ''
    then IsEmptyState := True
    else IsEmptyState := False;
  inherited DoEnter;
end;

procedure TNavFindEditEh.DrawNonClientBorder;
var
  DC, OldDC: HDC;
  R, R1: TRect;
begin
  if True {Flat and (BorderStyle = bsSingle) and (Ctl3D = True} then
  begin
    DC := GetWindowDC(Handle);
    try
      GetWindowRect(Handle, R);
      OffsetRect(R, -R.Left, -R.Top);

      begin
        R1 := R;
        OldDC := Canvas.Handle;
        Canvas.Handle := DC;
//        Canvas.Brush.Color := $00C5DEE2;//Parent.;
        Canvas.Brush.Color := TCustomDBGridEhCrack(Grid).GridLineParams.GetDarkColor;
        Canvas.FrameRect(R1);
        Canvas.Handle := OldDC;
      end;
    finally
      ReleaseDC(Handle, DC);
    end;
  end;
end;

procedure TNavFindEditEh.SetIsEmptyState(const Value: Boolean);
begin
  FIsEmptyState := Value;
  if FIsEmptyState then
  begin
//    SpecInternalSetText('Search');
//    Font.Color := clGrayText;
  end;
end;

procedure TNavFindEditEh.WMNCPaint(var Message: TWMNCPaint);
begin
  DrawNonClientBorder;
end;

procedure TNavFindEditEh.WMSetFocus(var Message: TWMSetFocus);
begin
  if not TCustomDBGridEhCrack(Grid).SearchEditorMode then
    TCustomDBGridEhCrack(Grid).SetFocus
  else
    inherited;
  if Grid is TCustomDBGridEh then
    TCustomDBGridEhCrack(Grid).Invalidate;
end;

procedure TNavFindEditEh.WMKillFocus(var Message: TWMKillFocus);
begin
  inherited;
  if Grid is TCustomDBGridEh then
    TCustomDBGridEhCrack(Grid).Invalidate;
end;

procedure TNavFindEditEh.WMLButtonDown(var Message: TWMLButtonDown);
begin
  if CanFocus and (Grid is TCustomDBGridEh) then
      TCustomDBGridEhCrack(Grid).SearchEditorMode := True;
  inherited;
end;

procedure TNavFindEditEh.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
end;

procedure TNavFindEditEh.KeyPress(var Key: Char);
begin
  if (Key = #27) and not ListVisible then
  begin
{    if CanUndo then
    begin
      Undo;
      ClearUndo;
      Modified := False;
      UpdateModified;
    end else}
      CancelSearchEditorMode;
    Key := #0;
  end else if (Key = #13) and not ListVisible then
  begin
    if TCustomDBGridEhCrack(Grid).SearchPanel.FilterEnabled then
      ApplySearchFilter
    else
    begin
      if GetKeyState(VK_SHIFT) < 0
        then TDBGridSearchPanelControlEh(Parent).FindPrev
        else TDBGridSearchPanelControlEh(Parent).FindNext;
    end;
    Key := #0;
  end;
  inherited KeyPress(Key);
end;

procedure TNavFindEditEh.KeyDown(var Key: Word; Shift: TShiftState);
var
  KeyProcessed: Boolean;
begin
  KeyProcessed := False;
  if Parent is TDBGridSearchPanelControlEh then
    if (Shift = []) and (Key = VK_DOWN) then
    begin
      TDBGridSearchPanelControlEh(Parent).FindNext;
      KeyProcessed := True;
    end else if (Shift = []) and (Key = VK_UP) then
    begin
      TDBGridSearchPanelControlEh(Parent).FindPrev;
      KeyProcessed := True;
    end else if (Shift = []) and (Key = VK_TAB) then
    begin
      TCustomDBGridEhCrack(Grid).SearchEditorMode := False;
      KeyProcessed := True;
      Key := 0;
    end;
  if not KeyProcessed then
    inherited KeyDown(Key, Shift);
end;

procedure TNavFindEditEh.SpecInternalSetText(AText: String);
begin
  FInternalChanging := True;
  try
    Text := AText;
    Modified := False;
    UpdateModified;
  finally
    FInternalChanging := False;
  end;
end;

procedure TNavFindEditEh.CalcEditRect(var ARect: TRect);
begin
  inherited CalcEditRect(ARect);
  Inc(ARect.Left, 2);
  Dec(ARect.Right, 2);
  if not MiniHeight then
  begin
    Inc(ARect.Top);
    Dec(ARect.Bottom);
  end;
end;

procedure TNavFindEditEh.CancelSearchEditorMode;
begin
  SpecInternalSetText('');
  TDBGridSearchPanelEhCrack(TCustomDBGridEhCrack(Grid).SearchPanel).InterSetSearchingText(Text);
  TCustomDBGridEhCrack(Grid).SearchEditorMode := False;
  TCustomDBGridEhCrack(Grid).ClearSearchFilter;
  Modified := False;
  TextAppliedAsFilter := True;
  UpdateModified;
end;

procedure TNavFindEditEh.ApplySearchFilter;
begin
  TCustomDBGridEhCrack(Grid).SetSearchFilter(Text);
  Modified := False;
  TextAppliedAsFilter := True;
  UpdateModified;
  CheckAddTextToList;
end;

procedure TNavFindEditEh.UpdateModified;
begin
  if Assigned(OnUpdateModified) then
    OnUpdateModified(Self);
end;

function TNavFindEditEh.CalcAutoHeight: Integer;
var
  DC: HDC;
  SaveFont: HFont;
  I: Integer;
  Metrics: Windows.TTextMetric;
begin
  DC := GetDC(0);
  {$WARNINGS OFF}
  SaveFont := SelectObject(DC, Font.Handle);
  {$WARNINGS ON}
  GetTextMetrics(DC, Metrics);
  SelectObject(DC, SaveFont);
  ReleaseDC(0, DC);
  I := Metrics.tmHeight;

  I := I + 2; //Border
  I := I + 1; //Button margin
  {$IFDEF FPC}
  I := I + 1; //Button margin
  {$ELSE}
  {$ENDIF}
  if not MiniHeight then
    I := I + 2; //Button+Top margin

  Result := I;
end;

procedure TNavFindEditEh.CheckAddTextToList;
begin
  Items.Add(Text);
end;

procedure TNavFindEditEh.CMWantSpecialKey(var Message: TCMWantSpecialKey);
begin
  inherited;
  if (Message.CharCode = VK_TAB) then
    Message.Result := 1;
end;

procedure TNavFindEditEh.WndProc(var Message: TMessage);
var
  ShiftState: TShiftState;
  AGrid: TCustomDBGridEhCrack;
begin
  inherited WndProc(Message);
  case Message.Msg of
    WM_CHAR:
{$IFDEF CIL}
      with TWMKey.Create(Message) do
{$ELSE}
      with TWMKey(Message) do
{$ENDIF}
      begin
        ShiftState := KeyDataToShiftState(KeyData);
        AGrid := TCustomDBGridEhCrack(FGrid);
        if AGrid.SearchPanel.FilterOnTyping and AGrid.SearchPanel.FilterEnabled then
          if ((CharCode > 32) or (CharCode = VK_BACK)) and (ShiftState * [ssAlt, ssCtrl] = [])  then
            if Text = ''
              then TCustomDBGridEhCrack(Grid).ClearSearchFilter
              else ApplySearchFilter;
      end;
  end;
end;

{ TDBGridSearchPanelControlEh }

procedure TDBGridSearchPanelControlEh.BtnMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Grid: TCustomDBGridEhCrack;
begin
  Grid := TCustomDBGridEhCrack(FGrid);
  Grid.AcquireFocus;
  if TabStop and (GetFocus <> Handle) and CanFocus then
  begin
    SetFocus;
    if (GetFocus <> Handle) then
      Exit;
  end;
end;

function TDBGridSearchPanelControlEh.CalcAutoHeight: Integer;
begin
  Result := FindEditor.CalcAutoHeight + 6 + 1;
end;

function TDBGridSearchPanelControlEh.CalcAutoWidthForHeight(ANewHeight: Integer): Integer;
begin
  Result := 100 + ANewHeight + ANewHeight + ANewHeight + ANewHeight;
end;

procedure TDBGridSearchPanelControlEh.ClickHandler(Sender: TObject);
begin
  if Sender is TNavFindButtonEh then
    FindBtnClick(TNavFindButtonEh(Sender).Index);
end;

constructor TDBGridSearchPanelControlEh.Create(AGrid: TCustomGridEh);
begin
  inherited Create(AGrid);
  ControlStyle := ControlStyle - [csSetCaption];
  FGrid := AGrid;
  InitItems;
  DoubleBuffered := True;
  Caption := '';
end;

destructor TDBGridSearchPanelControlEh.Destroy;
begin
  inherited Destroy;
end;

procedure TDBGridSearchPanelControlEh.CreateWnd;
begin
  inherited CreateWnd;
end;

procedure TDBGridSearchPanelControlEh.DrawNonClientBorder;
var
  DC, OldDC: HDC;
  R, R1: TRect;
begin
  if True {Flat and (BorderStyle = bsSingle) and (Ctl3D = True} then
  begin
    DC := GetWindowDC(Handle);
    try
      GetWindowRect(Handle, R);
      OffsetRect(R, -R.Left, -R.Top);
      begin
        R1 := R;
        OldDC := Canvas.Handle;
        Canvas.Handle := DC;
        Canvas.Brush.Color := $00C5DEE2;//Parent.;
        Canvas.FrameRect(R1);
        Canvas.Handle := OldDC;
      end;
    finally
      ReleaseDC(Handle, DC);
    end;
  end;
end;

procedure TDBGridSearchPanelControlEh.FindBtnClick(Index: TDBGridEhNavigatorFindBtn);
var
  Grid: TCustomDBGridEhCrack;
begin
  Grid := TCustomDBGridEhCrack(FGrid);
  if (Grid.DataSource <> nil) and (Grid.DataSource.State <> dsInactive) then
  begin
    if Grid.SearchEditorMode = False then
      Grid.SearchEditorMode := True;
    case Index of
      gnfbCancelSearchFilterEh:
        if not FFindEditor.TextAppliedAsFilter
          then FFindEditor.ApplySearchFilter
          else FFindEditor.CancelSearchEditorMode;
      gnfbFindNextEh:
        FindNext;
      gnfbFindPrevEh:
        FindPrev;
      gnfbOptionsEh: ;
    end;
  end;
end;

procedure TDBGridSearchPanelControlEh.FindEditorUpdateModified(Sender: TObject);
var
  Grid: TCustomDBGridEhCrack;
begin
  if Parent = nil then Exit;
  Grid := TCustomDBGridEhCrack(FGrid);
  if not FFindEditor.TextAppliedAsFilter then
  begin
    FindButtons[gnfbCancelSearchFilterEh].ImageIndex := 14;
    FindButtons[gnfbCancelSearchFilterEh].Enabled := True;
    FindButtons[gnfbCancelSearchFilterEh].Hint := SSearchPanelApplyFilterEh;
  end else
  begin
    FindButtons[gnfbCancelSearchFilterEh].ImageIndex := 10;
    FindButtons[gnfbCancelSearchFilterEh].Enabled :=
      Grid.SearchEditorMode or (Grid.FFilterObj <> nil);
    {$IFDEF FPC}
    {$ELSE}
    FFindEditor.ClearUndo;
    {$ENDIF}
    FindButtons[gnfbCancelSearchFilterEh].Hint := SSearchPanelCancelFilterEh;
  end;
end;

procedure TDBGridSearchPanelControlEh.FindNext;
var
  Grid: TCustomDBGridEhCrack;
begin
  Grid := TCustomDBGridEhCrack(FGrid);
  Grid.SearchPanel.FindNext;
  FFindEditor.Modified := False;
  {$IFDEF FPC}
  {$ELSE}
  FFindEditor.ClearUndo;
  {$ENDIF}
end;

procedure TDBGridSearchPanelControlEh.FindPrev;
var
  Grid: TCustomDBGridEhCrack;
begin
  Grid := TCustomDBGridEhCrack(FGrid);
  Grid.SearchPanel.FindPrev;
  FFindEditor.Modified := False;
  {$IFDEF FPC}
  {$ELSE}
  FFindEditor.ClearUndo;
  {$ENDIF}
end;

function TDBGridSearchPanelControlEh.GetSearchingText: String;
begin
  Result := FFindEditor.Text;
end;

procedure TDBGridSearchPanelControlEh.InitItems;
var
  FI: TDBGridEhNavigatorFindBtn;
  FindBtn: TNavFindButtonEh;
  X: Integer;
//  ResName: string;
begin
  MinBtnSize := Point(10, 10);
  X := 0;

  FFindEditor := TNavFindEditEh.Create(Self);
  FFindEditor.Flat := True;
  FFindEditor.SetBounds(X, 1, 100, MinBtnSize.Y-1);
  {$IFDEF FPC}
  {$ELSE}
  FFindEditor.BevelEdges := [beLeft, beTop, beRight, beBottom];
  FFindEditor.BevelInner := bvNone;
  FFindEditor.BevelKind := bkFlat;
  FFindEditor.BorderStyle := bsNone;
  FFindEditor.Ctl3D := True;
  {$ENDIF}
  FFindEditor.TabStop := False;
//  FFindEditor.SpecInternalSetText('Search');
  FFindEditor.EmptyDataInfo.Text := SSearchPanelEditorPromptText;
  FFindEditor.Parent := Self;
  FFindEditor.AutoSize := False;
  FFindEditor.IsEmptyState := True;
  FFindEditor.Font.Color := clGrayText;
  FFindEditor.Grid := FGrid;
  FFindEditor.OnUpdateModified := FindEditorUpdateModified;
  FFindEditor.EditButton.Visible := False;
//  FFindEditor.EditButton.Style := ebsAltDropDownEh;

  X := X + 85;

  for FI := Low(FindButtons) to High(FindButtons) do
  begin
    FindBtn := TNavFindButtonEh.Create(Self);
    FindBtn.Flat := True;
    FindBtn.Index := FI;
    FindBtn.ImageIndex := Ord(FI)+10;
    FindBtn.Enabled := True;
    FindBtn.SetBounds (X, 0, MinBtnSize.X, MinBtnSize.Y);
    FindBtn.Enabled := False;
    FindBtn.Enabled := True;
    FindBtn.OnClick := ClickHandler;
    FindBtn.OnMouseDown := BtnMouseDown;
    FindBtn.Parent := Self;
    FindButtons[FI] := FindBtn;
    X := X + MinBtnSize.X;
  end;

  FindButtons[gnfbCancelSearchFilterEh].Hint := SSearchPanelApplyFilterEh;
  FindButtons[gnfbFindNextEh].Hint := SSearchPanelFindNextEh;
  FindButtons[gnfbFindPrevEh].Hint := SSearchPanelFindPrevEh;
  FindButtons[gnfbOptionsEh].Hint := SSearchPanelOptionsEh;

  ResetVisibleControls;
end;

function TDBGridSearchPanelControlEh.IsSearchingState: Boolean;
begin
  if FFindEditor.Focused and (FFindEditor.Text <> '')
    then Result := True
    else Result := False;
end;

procedure TDBGridSearchPanelControlEh.Paint;
var
  Grid: TCustomDBGridEhCrack;
  ARect, FillRect: TRect;
  FromColor, ToColor, HighlightColor: TColor;
begin
  Grid := TCustomDBGridEhCrack(FGrid);
//  if Grid.Flat then
  begin
    Grid.SetInternalColors;
    ARect := GetClientRect;
    if Location = splGridTopEh then
      Dec(ARect.Bottom);
    FillRect := ARect;
    Dec(FillRect.Right);
//    Dec(FillRect.Bottom);
    FromColor := Grid.FInternalColor;
    ToColor := Grid.FInternalFixedColor;
    if FindEditor.Focused then
    begin
      HighlightColor := StyleServices.GetSystemColor(clHighlight);
{$IFDEF EH_LIB_16}
      if Grid.Style.IsCustomStyleActive then
      begin
        StyleServices.GetElementColor(StyleServices.GetElementDetails(tgClassicCellSelected), ecFillColor, HighlightColor);
      end;
{$ENDIF}
      FromColor := GetNearestColor(Canvas.Handle, Grid.Style.LightenColor(Grid.FInternalColor, HighlightColor, True));
      ToColor := GetNearestColor(Canvas.Handle, Grid.Style.LightenColor(Grid.FInternalColor, HighlightColor, True));
      
    end;
    if not ThemesEnabled then
      FromColor := ToColor;
    FillGradientEh(Canvas, FillRect, FromColor, ToColor);

    if Location = splGridTopEh then
    begin
      Canvas.Pen.Color := Grid.GridLineParams.GetDarkColor;
      Canvas.Polyline([Point(ARect.Left, ARect.Bottom),
                       Point(ARect.Right-1, ARect.Bottom),
                       Point(ARect.Right-1, ARect.Top-1)
                       ]);
    end;
  end;
{  end else
    inherited Paint;}
end;

procedure TDBGridSearchPanelControlEh.ResetVisibleControls;
var
  FI: TDBGridEhNavigatorFindBtn;
  W, H: Integer;
begin
  for FI := Low(FindButtons) to High(FindButtons) do
  begin
//    FindButtons[FI].Visible := gsbiFindEditorEh in VisibleItems;
    if ThemesEnabled then
    begin
      FindButtons[FI].Images := DBGridEhRes.IMList10;
      FindButtons[FI].DisabledImages := DBGridEhRes.IMList10D;
    end else
    begin
      FindButtons[FI].Images := DBGridEhRes.IMList10Bmp;
      FindButtons[FI].DisabledImages := DBGridEhRes.IMList10DBmp;
    end;
  end;
  if FindButtons[gnfbCancelSearchFilterEh].Visible <> TCustomDBGridEhCrack(FGrid).SearchPanel.FilterEnabled then
  begin
    FindButtons[gnfbCancelSearchFilterEh].Visible := TCustomDBGridEhCrack(FGrid).SearchPanel.FilterEnabled;
    W := Width;
    H := Height;
    SetSize(W, H);
  end;
  FindButtons[gnfbOptionsEh].Visible := False; // Options to Realize
end;

procedure TDBGridSearchPanelControlEh.SetLocation(const Value: TSearchPanelLocationEh);
begin
  if FLocation <> Value then
  begin
    FLocation := Value;
    FindEditor.MiniHeight := (FLocation = splHorzScrollBarExtraPanelEh);
  end;
end;

procedure TDBGridSearchPanelControlEh.Resize;
var
  NewW, NewH: Integer;
begin
  inherited Resize;
  if not HandleAllocated then Exit;
  NewW := Width;
  NewH := Height;
  SetSize(NewW, NewH);
end;

procedure TDBGridSearchPanelControlEh.SetSize(var W, H: Integer);
var
  X: Integer;
  FI: TDBGridEhNavigatorFindBtn;
  EditorHeight, EditorTop: Integer;
  EditorBound: TRect;
begin
  if (csLoading in ComponentState) then Exit;

  ButtonWidth := H-1;

  X := ClientWidth-3;
  if UseRightToLeftAlignment then
    X := 3;

  for FI := High(FindButtons) downto Low(FindButtons) do
  begin
    if FindButtons[FI].Visible then
    begin
      if UseRightToLeftAlignment then
        Inc(X, ButtonWidth);
      FindButtons[FI].SetBounds(X-ButtonWidth, 0, ButtonWidth, ButtonWidth);
      if not UseRightToLeftAlignment then
        Dec(X, ButtonWidth);
    end else
      FindButtons[FI].SetBounds(0, 0, 0, 0);
  end;

  if Location = splGridTopEh then
  begin
    EditorHeight := H-7;
    EditorTop := 3;
  end else
  begin
    EditorHeight := FFindEditor.CalcAutoHeight;
    if EditorHeight < H then
      EditorTop := (EditorHeight + H) div 2 - EditorHeight
    else
      EditorTop := 0;
  end;

  if UseRightToLeftAlignment then
  begin
    if Location = splGridTopEh then
      EditorBound := Rect(X+1, 3, ClientWidth-X-5, H-7)
    else
      EditorBound := Rect(X, EditorTop, ClientWidth-X-4, EditorHeight);
  end else
  begin
    if Location = splGridTopEh then
      EditorBound := Rect(3, EditorTop, X-4, EditorHeight)
    else
    begin
      if CustomStyleActive then
        Inc(EditorHeight);
      EditorBound := Rect(3, EditorTop, X-4, EditorHeight);
    end;
  end;

  if EditorBound.Right < 0 then EditorBound.Right := 0;
  if EditorBound.Bottom < 0 then EditorBound.Bottom := 0;

  FFindEditor.SetBounds(EditorBound.Left, EditorBound.Top, EditorBound.Right, EditorBound.Bottom);
end;

procedure TDBGridSearchPanelControlEh.WMNCPaint(var Message: TWMNCPaint);
begin
  DrawNonClientBorder;
end;

procedure TDBGridSearchPanelControlEh.WMSize(var Message: TWMSize);
var
  W, H: Integer;
begin
  inherited;
  W := ClientWidth;
  H := ClientHeight;
  SetSize(W, H);
end;

initialization
  InitRes;
finalization
  FinRes;
end.
