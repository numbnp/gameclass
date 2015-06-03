{*******************************************************}
{                                                       }
{                       EhLib 7.0                       }
{           FilterDropDownFormsEh component             }
{                    (Build 7.0.02)                     }
{                                                       }
{     Copyright (c) 2014-2014 by Dmitry V. Bolshakov    }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit FilterDropDownFormsEh;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
{$IFDEF EH_LIB_17} System.UITypes, {$ENDIF}
{$IFDEF EH_LIB_7} Themes, UxTheme, Types, {$ENDIF}
  {$IFDEF FPC}
  EhLibLCL, DBGridsEh, LMessages, LCLType, Win32Extra,
  {$ELSE}
  EhLibVCL, DBGridEh,
  {$ENDIF}
  DropDownFormEh, Dialogs, DynVarsEh, ToolCtrlsEh, DBCtrlsEh, GridsEh,
  StdCtrls, ExtCtrls,
  DBGridEhGrouping,
  StrUtils, Buttons;

type
  TFilterDropDownForm = class;

{ TMenuButtonEh }

  TMenuButtonEh = class(TBitBtn)
  private
    FActionItem: TCustomListboxItemEh;
    procedure CNDrawItem(var Message: TWMDrawItem); message CN_DRAWITEM;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
  protected
    FMouseInControl: Boolean;
    FCanvas: TCanvas;
    procedure Paint(const DrawItemStruct: TDrawItemStruct); virtual;
//    procedure Paint; override;
  public
    FCaptionMargin: Integer;
    FDropDownForm: TFilterDropDownForm;

    function IsLine: Boolean;
    property ActionItem: TCustomListboxItemEh read FActionItem write FActionItem;
  end;

{ TFilterDropDownForm }

  TFilterDropDownForm = class(TCustomDropDownFormEh)
    Panel1: TPanel;
    bOk: TButton;
    bCancel: TButton;
    procedure bOkClick(Sender: TObject);
    procedure bCancelClick(Sender: TObject);
    procedure CustomDropDownFormEhInitForm(Sender: TCustomDropDownFormEh; DynParams: TDynVarsEh);
    procedure CustomDropDownFormEhCreate(Sender: TObject);
    procedure CustomDropDownFormEhDestroy(Sender: TObject);
  private

    FSearchEdit: TDBEditEh;
    FFilterList: TCustomListboxEh;

    FInternalChanging: Boolean;
    FBaseList: TStringList;

    FPopupListboxDownIndex: Integer;
    FPopupListboxDragHoverIndex: Integer;
    FSelectAllState: TCheckBoxState;
    FListValuesCheckingState: TBooleanDynArray;
    FListRefCheckingState: array of Integer;
    FEnterNotClearData: Boolean;
    FInFilterListBox: Boolean;

    procedure SearchEditChanged(Sender: TObject);
    procedure RefilterList; virtual;
    procedure UpdateFilterFromValuesCheckingState(ss: TStrings);
    procedure UpdateSelectAllState;

  protected
    FMenuItemHeight: Integer;
    FLeftMargin: Integer;
//    bOkLeft: Integer;
//    bCancelLeft: Integer;

    procedure DrawBorder; override;
    procedure SearchEditButtonClick(Sender: TObject; var Handled: Boolean); virtual;
    procedure FilterListKeyPress(Sender: TObject; var Key: Char); virtual;
  public
    procedure Init; virtual;
    procedure InitDataForBaseList; virtual;

    procedure RealignControls; virtual;

    property SearchEdit: TDBEditEh read FSearchEdit;
    property FilterList: TCustomListboxEh read FFilterList;

    property BaseList: TStringList read FBaseList;
    property ListValuesCheckingState: TBooleanDynArray read FListValuesCheckingState;

  end;

{ TDDFormFilterPopupListboxItemEh }

  TDDFormFilterPopupListboxItemEh = class(TCustomListboxItemEh)
  protected
    function FilterForm(Listbox: TCustomListboxEh): TFilterDropDownForm;
  end;

{ TDDFormListboxItemEhData }

  TDDFormListboxItemEhSelectAll = class(TDDFormFilterPopupListboxItemEh)
  protected
    function CanFocus(Sender: TCustomListboxEh; ItemIndex: Integer): Boolean; override;
    procedure DrawItem(Sender: TCustomListboxEh; ItemIndex: Integer; ARect: TRect; State: TGridDrawState); override;
    procedure MouseDown(Sender: TCustomListboxEh; ItemIndex: Integer; InItemPos: TPoint; Button: TMouseButton; Shift: TShiftState); override;
    procedure MouseMove(Sender: TCustomListboxEh; ItemIndex: Integer; InItemPos: TPoint; Shift: TShiftState); override;
    procedure MouseUp(Sender: TCustomListboxEh; ItemIndex: Integer; InItemPos: TPoint; Button: TMouseButton; Shift: TShiftState); override;
    procedure KeyPress(Sender: TCustomListboxEh; ItemIndex: Integer; var Key: Char; Shift: TShiftState; var IsCloseListbox: Boolean); override;
  public
//    function CloseOnExecute(Sender: TCustomListboxEh; ItemIndex: Integer): Boolean; override;
    function IsDataItem: Boolean; override;
    procedure Execute(Sender: TCustomListboxEh; ItemIndex: Integer; InItemPos: TPoint; Shift: TShiftState); override;
  end;

{ TDDFormListboxItemEhData }

  TDDFormListboxItemEhData = class(TDDFormFilterPopupListboxItemEh)
  protected
    function CanFocus(Sender: TCustomListboxEh; ItemIndex: Integer): Boolean; override;
    function GetDisplayText(Sender: TCustomListboxEh; ItemIndex: Integer): String; override;

    procedure DrawItem(Sender: TCustomListboxEh; ItemIndex: Integer; ARect: TRect; State: TGridDrawState); override;
    procedure MouseDown(Sender: TCustomListboxEh; ItemIndex: Integer; InItemPos: TPoint; Button: TMouseButton; Shift: TShiftState); override;
    procedure MouseMove(Sender: TCustomListboxEh; ItemIndex: Integer; InItemPos: TPoint; Shift: TShiftState); override;
    procedure MouseUp(Sender: TCustomListboxEh; ItemIndex: Integer; InItemPos: TPoint; Button: TMouseButton; Shift: TShiftState); override;
    procedure KeyPress(Sender: TCustomListboxEh; ItemIndex: Integer; var Key: Char; Shift: TShiftState; var IsCloseListbox: Boolean); override;
  public
//    function CloseOnExecute(Sender: TCustomListboxEh; ItemIndex: Integer): Boolean; override;
    procedure Execute(Sender: TCustomListboxEh; ItemIndex: Integer; InItemPos: TPoint; Shift: TShiftState); override;
  end;

var
  FilterDropDownForm: TFilterDropDownForm;

  ListboxItemEhData: TDDFormListboxItemEhData;
  ListboxItemEhSelectAll: TDDFormListboxItemEhSelectAll;

  GetFilterDropDownFormProc: function : TFilterDropDownForm = nil;

function GetDefaultFilterDropDownForm: TFilterDropDownForm;

implementation

uses DBGridEhToolCtrls, EhLibConsts, Menus;

{$R *.dfm}

type
  TCustomListboxEhCrack = class(TCustomListboxEh);

function GetDefaultFilterDropDownForm: TFilterDropDownForm;
begin
  if FilterDropDownForm = nil then
    FilterDropDownForm := TFilterDropDownForm.Create(Application);
  Result := FilterDropDownForm;
end;

procedure TFilterDropDownForm.bCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
  Close;
end;

procedure TFilterDropDownForm.bOkClick(Sender: TObject);
begin
//  ModalResult := mrOk;
//  ListboxItemEhApplyFilter.Execute(FFilterList, -1, Point(0,0), []);
  Close;
end;

procedure TFilterDropDownForm.CustomDropDownFormEhCreate(Sender: TObject);
var
  EditButton: TEditButtonEh;
begin
//  bOkLeft := bOk.Left;
//  bCancelLeft := bCancel.Left;

  FMenuItemHeight := GetSystemMetrics(SM_CYMENU) + 2;
  FLeftMargin := FMenuItemHeight;

  FSearchEdit := TDBEditEh.Create(Self);
  FSearchEdit.Parent := Self;
  FSearchEdit.Top := 0; //FLineMenuButton2.Top + FLineMenuButton2.Height + 5;
  FSearchEdit.Left := FLeftMargin;
  FSearchEdit.Width := ClientWidth - 5 - FSearchEdit.Left;
  FSearchEdit.Anchors := [akLeft, akTop, akRight];
  FSearchEdit.OnChange := SearchEditChanged;
  FSearchEdit.Flat := True;

  EditButton := FSearchEdit.EditButtons.Add;
  EditButton.Style := ebsGlyphEh;
  if ThemesEnabled then
    EditButton.Images.NormalImages := DBGridEhRes.IMList10
  else
    EditButton.Images.NormalImages := DBGridEhRes.IMList10Bmp;
  EditButton.Images.NormalIndex := 10;
  EditButton.Images.HotIndex := 10;
  EditButton.Images.PressedIndex := 10;
  EditButton.Images.DisabledIndex := 10;
  EditButton.OnClick := SearchEditButtonClick;
  EditButton.Enabled := False;

  FFilterList := TCustomListboxEh.Create(Self);
  FFilterList.Parent := Self;
  FFilterList.SizeGripAlwaysShow := False;
  FFilterList.Top := FSearchEdit.Top + FSearchEdit.Height + 5;
  FFilterList.Left := FLeftMargin;
  FFilterList.Width := ClientWidth - 5 - FSearchEdit.Left;
  FFilterList.Height := Panel1.Top - FFilterList.Top;
  FFilterList.UseItemObjects := True;

  FFilterList.Anchors := [akLeft, akTop, akRight,akBottom];
  TCustomListboxEhCrack(FFilterList).OnKeyPress := FilterListKeyPress;

  FBaseList := TStringList.Create;
end;

procedure TFilterDropDownForm.RealignControls;
var
  FLTop: Integer;
begin

  if UseRightToLeftAlignment then
  begin
    if akRight in  bOk.Anchors then
      Panel1.FlipChildren(True);
    bOk.Anchors := [akLeft, akTop];
    bCancel.Anchors := [akLeft, akTop];

    FSearchEdit.SetBounds(
      5, 5, // FLineMenuButton2.Top + FLineMenuButton2.Height + 5,
      ClientWidth - FLeftMargin - 5, FSearchEdit.Height);

    FLTop := FSearchEdit.Top + FSearchEdit.Height + 5;
    FFilterList.SetBounds(
      5, FLTop,
      ClientWidth - FLeftMargin - FSearchEdit.Left, Panel1.Top - FLTop);
  end else
  begin
    if akLeft in  bOk.Anchors then
      Panel1.FlipChildren(True);
    bOk.Anchors := [akRight, akTop];
    bCancel.Anchors := [akRight, akTop];

    FSearchEdit.SetBounds(
      FLeftMargin, 5, // FLineMenuButton2.Top + FLineMenuButton2.Height + 5,
      ClientWidth - 5 - FSearchEdit.Left, FSearchEdit.Height);

    FLTop := FSearchEdit.Top + FSearchEdit.Height + 5;
    FFilterList.SetBounds(
      FLeftMargin, FLTop,
      ClientWidth - 5 - FSearchEdit.Left, Panel1.Top - FLTop);
  end;
end;

procedure TFilterDropDownForm.CustomDropDownFormEhDestroy(Sender: TObject);
begin
  FreeAndNil(FBaseList);
end;

procedure TFilterDropDownForm.CustomDropDownFormEhInitForm(
  Sender: TCustomDropDownFormEh; DynParams: TDynVarsEh);
//var
//  i: Integer;
begin
  FFilterList.ItemHeight := FFilterList.GetTextHeight + 1;
//  AList := FFilterList.Items;

(*
  FBaseList.Clear;
  FColumn := TColumnEh(DynParams.Items[0].AsRefObject);
  FColumn.Grid.DefaultFillSTFilterListDataValues(FColumn, FBaseList);
  FBaseList.BeginUpdate;
  try
    for i := 0 to FBaseList.Count - 1 do
      if FBaseList.Objects[i] = nil then
        FBaseList.Objects[i] := ListboxItemEhData;
  finally
    FBaseList.EndUpdate;
  end;

//  FBaseList.Assign(AList);
  SetLength(FListValuesCheckingState, FBaseList.Count);
  for i := 0 to Length(FListValuesCheckingState)-1 do
    FListValuesCheckingState[i] := False;

  SetLength(FListRefCheckingState, FBaseList.Count+1);

  TSTColumnFilterEhCrack(FColumn.STFilter).UpdateValuesCheckingStateFromFilter(FBaseList, FListValuesCheckingState);
 *)

  RefilterList;
  FPopupListboxDownIndex := -1;

(*
  if (dghAutoSortMarking in FColumn.Grid.OptionsEh) and FColumn.Title.TitleButton then
  begin
    FSortButton1.Visible := True;
    FSortButton2.Visible := True;
    FLineMenuButton1.Visible := True;
  end else
  begin
    FSortButton1.Visible := False;
    FSortButton2.Visible := False;
    FLineMenuButton1.Visible := False;
  end;
*)

  RealignControls;
  Init;
end;

procedure TFilterDropDownForm.DrawBorder;
var
{$IFDEF EH_LIB_16}
  Details: TThemedElementDetails;
  AMenuStyle: TThemedMenu;
{$ELSE}
  FaceBrush: HBRUSH;
{$ENDIF}
  DC: HDC;
  R: TRect;
begin
  DC := GetWindowDC(Handle);
  try
    GetWindowRect(Handle, R);
    OffsetRect(R, -R.Left, -R.Top);

    ExcludeClipRect(DC, R.Left+BorderWidth, R.Top+BorderWidth, R.Right-BorderWidth, R.Bottom-BorderWidth);

{$IFDEF EH_LIB_16}
    AMenuStyle := tmPopupBorders;
    Details := ThemeServices.GetElementDetails(AMenuStyle);
    ThemeServices.DrawElement(DC, Details, R);
{$ELSE}
    DrawEdge(DC, R, BDR_SUNKENOUTER, BF_RECT or BF_FLAT);
    FaceBrush := GetSysColorBrush(COLOR_MENU);
    InflateRect(R, -1, -1);
    FrameRect(DC, R, FaceBrush);
    InflateRect(R, -1, -1);
    FrameRect(DC, R, FaceBrush);
{$ENDIF}

  finally
    ReleaseDC(Handle, DC);
  end;
end;

procedure TFilterDropDownForm.FilterListKeyPress(Sender: TObject;
  var Key: Char);
var
  ItemIndex: Integer;
  Item: TCustomListboxItemEh;
begin
  if Key = ' ' then
  begin
    ItemIndex := TCustomListboxEh(Sender).ItemIndex;
    if (ItemIndex >= 0) and
       (TCustomListboxEh(Sender).Items.Objects[ItemIndex] is TCustomListboxItemEh)
    then
    begin
      FEnterNotClearData := True;
      Item := TCustomListboxItemEh(TCustomListboxEh(Sender).Items.Objects[ItemIndex]);
      Item.Execute(TCustomListboxEh(Sender), ItemIndex, Point(-1,-1), GetShiftState);
    end;
    Key := #0;
  end;
end;

procedure TFilterDropDownForm.Init;
begin
  ActiveControl := FFilterList;
  SearchEdit.Clear;
end;

procedure TFilterDropDownForm.InitDataForBaseList;
var
  i: Integer;
begin
  BaseList.BeginUpdate;
  try
    for i := 0 to BaseList.Count - 1 do
      if BaseList.Objects[i] = nil then
        BaseList.Objects[i] := ListboxItemEhData;
  finally
    BaseList.EndUpdate;
  end;

  SetLength(FListValuesCheckingState, BaseList.Count);
  for i := 0 to Length(ListValuesCheckingState)-1 do
    ListValuesCheckingState[i] := False;

  SetLength(FListRefCheckingState, BaseList.Count+1);
end;

procedure TFilterDropDownForm.RefilterList;
var
  AList: TStrings;
  i,k: Integer;
  CharMsg: Windows.TMsg;
begin
  AList := FFilterList.Items;
  AList.BeginUpdate;
  AList.Clear;
  k := 0;
  SetLength(FListRefCheckingState, FBaseList.Count+1);

  AList.AddObject(SSTFilterListItem_SelectAll, ListboxItemEhSelectAll);
  FListRefCheckingState[k] := -1;
  Inc(k);

  try
    for i := 0 to FBaseList.Count-1 do
    begin
      if PeekMessage(CharMsg, FSearchEdit.Handle, WM_KEYDOWN, WM_KEYDOWN, PM_NOREMOVE) then
//        ShowMessage('Ggg');
        Break;
      if (FSearchEdit.Text = '') or AnsiContainsText(FBaseList[i], FSearchEdit.Text) then
      begin
        AList.AddObject(FBaseList[i], ListboxItemEhData);
        FListRefCheckingState[k] := i;
        Inc(k);
      end;
    end;
  finally
    AList.EndUpdate;
  end;

  SetLength(FListRefCheckingState, k);
end;

procedure TFilterDropDownForm.SearchEditButtonClick(Sender: TObject;
  var Handled: Boolean);
begin
  SearchEdit.Clear;
end;

procedure TFilterDropDownForm.SearchEditChanged(Sender: TObject);
begin
  if not FInternalChanging then
  begin
    RefilterList;
    UpdateSelectAllState;
    SearchEdit.EditButtons[0].Enabled := (SearchEdit.Text <> '');
  end;
end;

procedure TFilterDropDownForm.UpdateFilterFromValuesCheckingState(ss: TStrings);
begin
  UpdateSelectAllState;
end;

procedure TFilterDropDownForm.UpdateSelectAllState;
var
  i: Integer;
  Items: TStrings;
  AllCount, CheckedCount: Integer;
begin
  Items := FilterList.Items;
  AllCount := 0;
  CheckedCount := 0;
  for i := 0 to Items.Count-1 do
  begin
    if (Items.Objects[i] is TDDFormListboxItemEhData) then
    begin
      Inc(AllCount);
      if FListValuesCheckingState[FListRefCheckingState[i]] = True then
        Inc(CheckedCount);
    end;
  end;
  if CheckedCount = 0 then
    FSelectAllState := cbUnchecked
  else if CheckedCount = AllCount then
    FSelectAllState := cbChecked
  else
    FSelectAllState := cbGrayed;
end;

{ TMenuButtonEh }

procedure TMenuButtonEh.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  if {$IFDEF EH_LIB_16} StyleServices.Enabled and {$ENDIF}
     not FMouseInControl and
     not (csDesigning in ComponentState) then
  begin
    FMouseInControl := True;
    Repaint;
  end;
end;

procedure TMenuButtonEh.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  if {$IFDEF EH_LIB_16} StyleServices.Enabled and {$ENDIF}
     FMouseInControl then
  begin
    FMouseInControl := False;
    Repaint;
  end;
end;

function TMenuButtonEh.IsLine: Boolean;
begin
  Result := Caption = cLineCaption;
end;

procedure TMenuButtonEh.CNDrawItem(var Message: TWMDrawItem);
begin
  FCanvas := TCanvas.Create;
  {$IFDEF FPC}
  FCanvas.Handle := Message.DrawItemStruct.hDC;
  {$ELSE}
  FCanvas.Handle := Message.DrawItemStruct.hDC;
  {$ENDIF}
  try
    Paint(TDrawItemStruct(Message.DrawItemStruct{$IFNDEF CLR}^{$ENDIF}));
  finally
    FCanvas.Free;
  end;
end;

procedure TMenuButtonEh.Paint(const DrawItemStruct: TDrawItemStruct);
var
  AAcitve: Boolean;
{$IFDEF EH_LIB_16}
  Details: TThemedElementDetails;
  AMenuStyle: TThemedMenu;
{$ENDIF}
  PaintRect: TRect;
  S: String;
  TextRect: TRect;
  Alignment: TAlignment;
//  ACanvas: TCanvas;
begin
  PaintRect := ClientRect;
  FCanvas.Font.Color := Font.Color;
  if ThemesEnabled then
{$IFDEF EH_LIB_16}
    StyleServices.DrawParentBackground(0, FCanvas.Handle, nil, True)
{$ELSE}
    ThemeServices.DrawParentBackground(0, FCanvas.Handle, nil, True)
{$ENDIF}
  else
    PerformEraseBackground(Self, FCanvas.Handle);

  if IsLine then
  begin
{$IFDEF EH_LIB_16}
    AMenuStyle := tmPopupSeparator;
    Details := ThemeServices.GetElementDetails(AMenuStyle);
    ThemeServices.DrawElement(FCanvas.Handle, Details, PaintRect);
{$ELSE}
    FCanvas.Pen.Color := clBtnShadow;
    FCanvas.Polyline([Point(PaintRect.Left, (PaintRect.Top + PaintRect.Bottom) div 2),
                      Point(PaintRect.Right, (PaintRect.Top + PaintRect.Bottom) div 2)]);
{$ENDIF}
  end else
  begin
    AAcitve := FMouseInControl;
    if AAcitve or Focused then
    begin
{$IFDEF EH_LIB_16}
      if ThemesEnabled then
      begin
        AMenuStyle := tmPopupCheckBackgroundNormal;
        Details := ThemeServices.GetElementDetails(AMenuStyle);
        ThemeServices.DrawElement(FCanvas.Handle, Details, PaintRect)
      end else
{$ENDIF}
      begin
        FCanvas.Brush.Color := clHighlight;
        FCanvas.Font.Color := clHighlightText;
        FCanvas.FillRect(PaintRect);
      end;
    end;

    S := Caption;
    TextRect := PaintRect;
    if Parent.UseRightToLeftAlignment then
    begin
      TextRect.Right := TextRect.Right - FCaptionMargin;
      Alignment := taRightJustify;
    end else
    begin
      TextRect.Left := TextRect.Left + FCaptionMargin;
      Alignment := taLeftJustify;
    end;

    WriteTextEh(FCanvas, TextRect, False, 0, 0, S, Alignment, tlCenter, False, False, 0, 0, False, True);

//    if FSortState <> smNoneEh then
//      DrawSortMarket(Rect(0, 0, Height, Height));

  end;
end;

{ TDDFormFilterPopupListboxItemEh }

function TDDFormFilterPopupListboxItemEh.FilterForm(Listbox: TCustomListboxEh): TFilterDropDownForm;
begin
  Result := TFilterDropDownForm(Listbox.Owner);
end;

{ TDDFormListboxItemEhData }

procedure TDDFormListboxItemEhData.DrawItem(Sender: TCustomListboxEh;
  ItemIndex: Integer; ARect: TRect; State: TGridDrawState);
var
  CBRect: TRect;
  MouseIndex: Integer;
  IsDown{, OldRigth}: Integer;
  CBState: TCheckBoxState;
  IsActive: Boolean;
  DownIndex, DragHoverIndex: Integer;
  SMFillRect: TRect;
  sText, DrawText: String;
begin
  MouseIndex := Sender.ItemAtPos(Sender.ScreenToClient(SafeGetMouseCursorPos), True);
  IsDown := 0;
  if FilterForm(Sender).FPopupListboxDownIndex >= 0 then
  begin
    DownIndex := FilterForm(Sender).FPopupListboxDownIndex;
    DragHoverIndex := FilterForm(Sender).FPopupListboxDragHoverIndex;
    if (DragHoverIndex >= DownIndex) and (DragHoverIndex >= ItemIndex) and (DownIndex <= ItemIndex) then
      IsDown := -1
    else if (DragHoverIndex <= DownIndex) and (DragHoverIndex <= ItemIndex) and (DownIndex >= ItemIndex) then
      IsDown := -1;
  end;

//  if GetColumn(Sender).STFilter.FPopupListboxDownIndex > ItemIndex
//    then IsDown := -1
//    else IsDown := 0;
//  CBState := GetColumn(Sender).STFilter.FListValuesCheckingState[ItemIndex];
  if FilterForm(Sender).FListValuesCheckingState[FilterForm(Sender).FListRefCheckingState[ItemIndex]] = True
    then CBState := cbChecked
    else CBState := cbUnchecked;
  IsActive := (MouseIndex >= 0) and (MouseIndex = ItemIndex) and (Mouse.Capture = 0);
  CBRect := Rect(ARect.Left, ARect.Top, ARect.Left + DefaultCheckBoxWidth, ARect.Bottom);
//  if Sender.UseRightToLeftAlignment and not Sender.CanvasRightToLeftReflected then
//  begin
//    OldRigth := CBRect.Right;
//    CBRect.Right := Sender.ClientWidth - CBRect.Left;
//    CBRect.Left := Sender.ClientWidth - OldRigth;
//  end;
  if IsDown = -1 then
  begin
    State := State + [gdSelected];
    Sender.Canvas.Brush.Color := clHighlight;
    Sender.Canvas.Font.Color := clHighlightText;
  end else
    Sender.Canvas.Brush.Color := Sender.Color;

{  if IsDown = -1 then
    if CBState = cbUnchecked
      then CBState := cbChecked
      else CBState := cbUnchecked;}

  SMFillRect := ARect;
  SMFillRect.Right := SMFillRect.Left + DefaultCheckBoxWidth + 2;
  Sender.Canvas.FillRect(SMFillRect);

  if Sender.UseRightToLeftAlignment then
  begin
    WindowsLPtoDP(Sender.Canvas.Handle, CBRect);
    SwapInt(CBRect.Left, CBRect.Right);
    SetLayout(Sender.Canvas.Handle, LAYOUT_RTL_EH);
  end;

  PaintButtonControlEh(Sender.Canvas, CBRect, Sender.Canvas.Brush.Color,
    bcsCheckboxEh, IsDown, True, IsActive {odFocused in State}, True, CBState);

  if Sender.UseRightToLeftAlignment then
    SetLayout(Sender.Canvas.Handle, 0);

//  if Sender.UseRightToLeftAlignment and not Sender.CanvasRightToLeftReflected
//    then ARect.Right := ARect.Right - DefaultCheckBoxWidth - 2
//    else
  ARect.Left := ARect.Left + DefaultCheckBoxWidth + 2;

  DrawText := Sender.Items[ItemIndex];
  if DrawText = '' then
    DrawText := SSTFilterListItem_Empties;

  Sender.DefaultDrawItem(ItemIndex, ARect, State);

  sText := FilterForm(Sender).FSearchEdit.Text;
  if sText <> '' then
  begin
    DrawHighlightedSubTextEh(Sender.Canvas, ARect, 2, 0, DrawText,
      taLeftJustify, tlTop, False, False, 0, 0, False, sText, True, RGB(255,255,150), 0, clYellow);
  end;
end;

function TDDFormListboxItemEhData.CanFocus(Sender: TCustomListboxEh;
  ItemIndex: Integer): Boolean;
begin
  Result := False;
end;

procedure TDDFormListboxItemEhData.MouseDown(Sender: TCustomListboxEh; ItemIndex: Integer;
  InItemPos: TPoint; Button: TMouseButton; Shift: TShiftState);
begin
  if Button = mbLeft then
  begin
    FilterForm(Sender).FPopupListboxDownIndex := ItemIndex;
    FilterForm(Sender).FPopupListboxDragHoverIndex := ItemIndex;
    Sender.InvalidateIndex(ItemIndex);
  end;
end;

procedure TDDFormListboxItemEhData.MouseMove(Sender: TCustomListboxEh; ItemIndex: Integer;
  InItemPos: TPoint; Shift: TShiftState);
begin
  if (FilterForm(Sender).FPopupListboxDownIndex >= 0) and
     (FilterForm(Sender).FPopupListboxDragHoverIndex <> ItemIndex) then
  begin
    Sender.InvalidateIndex(FilterForm(Sender).FPopupListboxDownIndex);
    FilterForm(Sender).FPopupListboxDragHoverIndex := ItemIndex;
    Sender.Invalidate;
//    GetColumn(Sender).STFilter.FPopupListboxDownIndex := -1;
  end;
end;

procedure TDDFormListboxItemEhData.MouseUp(Sender: TCustomListboxEh;
  ItemIndex: Integer; InItemPos: TPoint; Button: TMouseButton;
  Shift: TShiftState);
var
  MousePos: TPoint;
  Index: Integer;
//  ACol: TColumnEh;
  FormIdx, ToIdx: Integer;
  CheckState: Boolean;
  i: Integer;
  AFilterForm: TFilterDropDownForm;
begin
  AFilterForm := FilterForm(Sender);
  if AFilterForm.FPopupListboxDownIndex = ItemIndex then
  begin
    AFilterForm.FEnterNotClearData := True;
    Execute(Sender, ItemIndex, InItemPos, Shift);
    MousePos := Sender.ScreenToClient(SafeGetMouseCursorPos);
    Index := Sender.ItemAtPos(MousePos, True);
    if Index < Sender.Items.Count then Sender.ItemIndex := Index;
  end else if (AFilterForm.FPopupListboxDownIndex >= 0) and
              (AFilterForm.FPopupListboxDragHoverIndex >= 0) then
  begin
    CheckState := not AFilterForm.FListValuesCheckingState
      [AFilterForm.FListRefCheckingState[AFilterForm.FPopupListboxDownIndex]];
    if AFilterForm.FPopupListboxDragHoverIndex > AFilterForm.FPopupListboxDownIndex then
    begin
      FormIdx := AFilterForm.FPopupListboxDownIndex;
      ToIdx := AFilterForm.FPopupListboxDragHoverIndex;
    end else
    begin
      FormIdx := AFilterForm.FPopupListboxDragHoverIndex;
      ToIdx := AFilterForm.FPopupListboxDownIndex;
    end;
    for i := FormIdx to ToIdx do
      AFilterForm.FListValuesCheckingState[AFilterForm.FListRefCheckingState[i]] := CheckState;
    AFilterForm.UpdateFilterFromValuesCheckingState(Sender.Items);
    Sender.Invalidate;
  end;
//  ACol := GetColumn(Sender);
//  if ACol <> nil then
    AFilterForm.FPopupListboxDownIndex := -1;
  Sender.Invalidate;//Index(ItemIndex);
end;

procedure TDDFormListboxItemEhData.Execute(Sender: TCustomListboxEh;
  ItemIndex: Integer; InItemPos: TPoint; Shift: TShiftState);
var
  i: Integer;
  AFilterForm: TFilterDropDownForm;
begin
  AFilterForm := FilterForm(Sender);
  AFilterForm.FInFilterListBox := True;
  try
    if not AFilterForm.FEnterNotClearData then
      for i := 0 to Length(AFilterForm.FListValuesCheckingState)-1 do
      begin
        AFilterForm.FListValuesCheckingState[i] := False;
      end;
    AFilterForm.FListValuesCheckingState[AFilterForm.FListRefCheckingState[ItemIndex]] :=
      not AFilterForm.FListValuesCheckingState[AFilterForm.FListRefCheckingState[ItemIndex]];
    AFilterForm.UpdateFilterFromValuesCheckingState(Sender.Items);
  finally
//    if GetColumn(Sender) <> nil then
      AFilterForm.FInFilterListBox := False;
  end;
  Sender.Invalidate;
end;

function TDDFormListboxItemEhData.GetDisplayText(Sender: TCustomListboxEh;
  ItemIndex: Integer): String;
begin
  if Sender.Items[ItemIndex] = '' then
    Result := SSTFilterListItem_Empties
  else
    Result := inherited GetDisplayText(Sender, ItemIndex);
end;

procedure TDDFormListboxItemEhData.KeyPress(Sender: TCustomListboxEh;
  ItemIndex: Integer; var Key: Char; Shift: TShiftState; var IsCloseListbox: Boolean);
begin

end;

{ TDDFormListboxItemEhSelectAll }

function TDDFormListboxItemEhSelectAll.CanFocus(Sender: TCustomListboxEh;
  ItemIndex: Integer): Boolean;
begin
  Result := False;
end;

procedure TDDFormListboxItemEhSelectAll.DrawItem(Sender: TCustomListboxEh;
  ItemIndex: Integer; ARect: TRect; State: TGridDrawState);
var
  CBRect: TRect;
  MouseIndex: Integer;
  IsDown{, OldRigth}: Integer;
  CBState: TCheckBoxState;
  IsActive: Boolean;
  DownIndex, DragHoverIndex: Integer;
  SMFillRect: TRect;
begin
  MouseIndex := Sender.ItemAtPos(Sender.ScreenToClient(SafeGetMouseCursorPos), True);
  IsDown := 0;
  if FilterForm(Sender).FPopupListboxDownIndex >= 0 then
  begin
    DownIndex := FilterForm(Sender).FPopupListboxDownIndex;
    DragHoverIndex := FilterForm(Sender).FPopupListboxDragHoverIndex;
    if (DragHoverIndex >= DownIndex) and (DragHoverIndex >= ItemIndex) and (DownIndex <= ItemIndex) then
      IsDown := -1
    else if (DragHoverIndex <= DownIndex) and (DragHoverIndex <= ItemIndex) and (DownIndex >= ItemIndex) then
      IsDown := -1;
  end;

  CBState := FilterForm(Sender).FSelectAllState;
  IsActive := (MouseIndex >= 0) and (MouseIndex = ItemIndex) and (Mouse.Capture = 0);
  CBRect := Rect(ARect.Left, ARect.Top, ARect.Left + DefaultCheckBoxWidth, ARect.Bottom);
//  if Sender.UseRightToLeftAlignment and not Sender.CanvasRightToLeftReflected then
//  begin
//    OldRigth := CBRect.Right;
//    CBRect.Right := Sender.ClientWidth - CBRect.Left;
//    CBRect.Left := Sender.ClientWidth - OldRigth;
//  end;
  if IsDown = -1 then
  begin
    State := State + [gdSelected];
    Sender.Canvas.Brush.Color := clHighlight;
    Sender.Canvas.Font.Color := clHighlightText;
  end else
    Sender.Canvas.Brush.Color := Sender.Color;

  SMFillRect := ARect;
  SMFillRect.Right := SMFillRect.Left + DefaultCheckBoxWidth + 2;
  Sender.Canvas.FillRect(SMFillRect);

  if Sender.UseRightToLeftAlignment then
  begin
    WindowsLPtoDP(Sender.Canvas.Handle, CBRect);
    SwapInt(CBRect.Left, CBRect.Right);
    SetLayout(Sender.Canvas.Handle, LAYOUT_RTL_EH);
  end;

  PaintButtonControlEh(Sender.Canvas, CBRect, Sender.Canvas.Brush.Color,
    bcsCheckboxEh, IsDown, True, IsActive {odFocused in State}, True, CBState);

  if Sender.UseRightToLeftAlignment then
    SetLayout(Sender.Canvas.Handle, 0);                          							            // By Khalid Dawood

//  if Sender.UseRightToLeftAlignment and not Sender.CanvasRightToLeftReflected
//    then ARect.Right := ARect.Right - DefaultCheckBoxWidth - 2
//    else
  ARect.Left := ARect.Left + DefaultCheckBoxWidth + 2;
  Sender.DefaultDrawItem(ItemIndex, ARect, State);
end;

procedure TDDFormListboxItemEhSelectAll.KeyPress(Sender: TCustomListboxEh;
  ItemIndex: Integer; var Key: Char; Shift: TShiftState;
  var IsCloseListbox: Boolean);
begin
  inherited;
end;

procedure TDDFormListboxItemEhSelectAll.MouseDown(Sender: TCustomListboxEh;
  ItemIndex: Integer; InItemPos: TPoint; Button: TMouseButton;
  Shift: TShiftState);
begin
  if Button = mbLeft then
  begin
    FilterForm(Sender).FPopupListboxDownIndex := ItemIndex;
    FilterForm(Sender).FPopupListboxDragHoverIndex := ItemIndex;
    Sender.InvalidateIndex(ItemIndex);
  end;
end;

procedure TDDFormListboxItemEhSelectAll.MouseMove(Sender: TCustomListboxEh;
  ItemIndex: Integer; InItemPos: TPoint; Shift: TShiftState);
begin
end;

procedure TDDFormListboxItemEhSelectAll.MouseUp(Sender: TCustomListboxEh;
  ItemIndex: Integer; InItemPos: TPoint; Button: TMouseButton;
  Shift: TShiftState);
var
  MousePos: TPoint;
  Index: Integer;
//  ACol: TColumnEh;
  AFilterForm: TFilterDropDownForm;
begin
  AFilterForm := FilterForm(Sender);
  if AFilterForm.FPopupListboxDownIndex = ItemIndex then
  begin
    AFilterForm.FEnterNotClearData := True;
    Execute(Sender, ItemIndex, InItemPos, Shift);
    MousePos := Sender.ScreenToClient(SafeGetMouseCursorPos);
    Index := Sender.ItemAtPos(MousePos, True);
    if Index < Sender.Items.Count then Sender.ItemIndex := Index;
  end;
//  ACol := GetColumn(Sender);
//  if ACol <> nil then
    AFilterForm.FPopupListboxDownIndex := -1;
  Sender.Invalidate;
end;

procedure TDDFormListboxItemEhSelectAll.Execute(Sender: TCustomListboxEh;
  ItemIndex: Integer; InItemPos: TPoint; Shift: TShiftState);
var
  i: Integer;
  NewState: Boolean;
  Form: TFilterDropDownForm;
begin
  Form := FilterForm(Sender);
  if Form.FSelectAllState = cbUnchecked then
  begin
    NewState := True;
    Form.FSelectAllState := cbChecked;
  end else
  begin
    NewState := False;
    Form.FSelectAllState := cbUnchecked;
  end;
  for i := 0 to Length(Form.FListRefCheckingState)-1 do
    if Form.FListRefCheckingState[i] >= 0 then
      Form.FListValuesCheckingState[Form.FListRefCheckingState[i]] := NewState;
  Sender.Invalidate;
end;

function TDDFormListboxItemEhSelectAll.IsDataItem: Boolean;
begin
  Result := False;
end;

initialization
  ListboxItemEhData := TDDFormListboxItemEhData.Create;
  ListboxItemEhSelectAll := TDDFormListboxItemEhSelectAll.Create;

  GetFilterDropDownFormProc := @GetDefaultFilterDropDownForm;

finalization
  FreeAndNil(ListboxItemEhData);
  FreeAndNil(ListboxItemEhSelectAll);
end.
