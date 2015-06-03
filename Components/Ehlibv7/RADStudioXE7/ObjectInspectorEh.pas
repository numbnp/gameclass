{*******************************************************}
{                                                       }
{                        EhLib v7.0                     }
{                                                       }
{                  TDBVertGrid component                }
{                      Build 7.0.002                    }
{                                                       }
{       Copyright (c) 2013 by Dmitry V. Bolshakov       }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit ObjectInspectorEh;

interface

uses
  SysUtils, Classes, Controls, Windows, Graphics, Messages,
  MemTreeEh, Contnrs,
  {$IFDEF FPC}
  EhLibLCL, LMessages, LCLType, Win32Extra,
  {$ELSE}
  EhLibVCL, StdCtrls,
  {$ENDIF}
  TypInfo, DBAxisGridsEh, GridsEh, ToolCtrlsEh,
{$IFDEF EH_LIB_7} Themes, UxTheme, {$ENDIF}
{$IFDEF EH_LIB_16} System.UITypes, {$ENDIF}
  Variants, Forms;

type
  TPropTreeListEh = class;
  TObjectInspectorEh = class;
  TInspectorInplaceEditEh = class;

{ TPropTreeNodeEh }

  TPropTreeNodeEh = class(TBaseTreeNodeEh)
  private
    FPropName: String;
    FPropStrValue: String;
    FPropInfo: PPropInfo;
    FTypeInfo: PTypeInfo;
    FIsSetValue: Boolean;
    FInstance: TObject;
    FSetIndex: Integer;
    FColorList: TStrings;
    FIsCompmentSubrops: Boolean;
    function GetItem(const Index: Integer): TPropTreeNodeEh; reintroduce;
    function GetNodeOwner: TPropTreeListEh;
    function GetNodeParent: TPropTreeNodeEh;
    function GetVisibleItem(const Index: Integer): TPropTreeNodeEh;
    procedure SetNodeParent(const Value: TPropTreeNodeEh);

  protected
    procedure GetColorStrProc(const S: string);
  public
    constructor Create; override;
    destructor Destroy; override;

    function GetFontStyle: TFontStyles;
    function GetEditStyle: TEditStyle;
    procedure Collapse;
    procedure Expand;
    procedure GetListValues(Items: TStrings);
    procedure SetValueAsString(SValue: String);
    procedure RefreshValue;

    property Items[const Index: Integer]: TPropTreeNodeEh read GetItem; default;
    property Owner: TPropTreeListEh read GetNodeOwner;
    property Parent: TPropTreeNodeEh read GetNodeParent write SetNodeParent;

    property VisibleItem[const Index: Integer]: TPropTreeNodeEh read GetVisibleItem;

    property Expanded;
    property HasChildren;

    property PropInfo: PPropInfo read FPropInfo write FPropInfo;
    property TypeInfo: PTypeInfo read FTypeInfo write FTypeInfo;
    property PropName: String read FPropName write FPropName;
    property PropStrValue: String read FPropStrValue write FPropStrValue;
    property Instance: TObject read FInstance write FInstance;

    property IsSetValue: Boolean read FIsSetValue write FIsSetValue;
    property SetIndex: Integer read FSetIndex write FSetIndex;
    property IsCompmentSubrops: Boolean read FIsCompmentSubrops;
  end;

  TPropTreeNodeClassEh = class of TPropTreeNodeEh;

{ TPropTreeListEh }

  TPropTreeListEh = class(TTreeListEh)
  private
//    FVisibleItems: TObjectList;
    FVisibleExpandedItems: TObjectList;
    FVisibleItemsObsolete: Boolean;
    FObjInspector: TObjectInspectorEh;
    function GetRoot: TPropTreeNodeEh;

  protected
    function GetVisibleCount: Integer;
    function GetVisibleExpandedItem(const Index: Integer): TPropTreeNodeEh; virtual;

  public
    constructor Create(ItemClass: TPropTreeNodeClassEh; ObjInspector: TObjectInspectorEh);
    destructor Destroy; override;
    procedure BuildVisibleItems;
    procedure VisibleItemsBecomeObsolete;
    procedure RefreshAllValues;

    property ObjectInspector: TObjectInspectorEh read FObjInspector;

    property VisibleExpandedCount: Integer read GetVisibleCount;
    property VisibleExpandedItem[const Index: Integer]: TPropTreeNodeEh read GetVisibleExpandedItem; default;
    property VisibleExpandedItems: TObjectList read FVisibleExpandedItems;
    property VisibleItemsObsolete: Boolean read FVisibleItemsObsolete;

    property Root: TPropTreeNodeEh read GetRoot;
  end;

{ TObjectInspectorEh }

  TObjectInspectorEh = class(TCustomGridEh)
  private
    FLabelColWidth: Integer;
    FLayoutLock: Integer;
    FObservableObject: TObject;
    FPropTreeList: TPropTreeListEh;
    FRowCaptionFont: TFont;
    FEditChangedThroughEnChangeCode: Boolean;

    function GetComponent: TObject;
    function GetLabelColWidth: Integer;
    function GetInplaceEdit: TInspectorInplaceEditEh;
    procedure SetComponent(const Value: TObject);
    procedure SetLabelColWidth(const Value: Integer);

    procedure CMHintShow(var Message: TCMHintShow); message CM_HINTSHOW;
    procedure CMHintsShowPause(var Message: TCMHintShowPause); message CM_HINTSHOWPAUSE;

    procedure WMCommand(var Message: TWMCommand); message WM_COMMAND;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
  protected
    function CreateEditor: TInplaceEdit; override;
    function AcquireLayoutLock: Boolean;
    function IsSmoothVertScroll: Boolean; override;
    procedure ScrollBarMessage(ScrollBar, ScrollCode, Pos: Integer; UseRightToLeft: Boolean); override;
    procedure BeginLayout;
    procedure CellMouseClick(const Cell: TGridCoord; Button: TMouseButton; Shift: TShiftState; const ACellRect: TRect; const GridMousePos, CellMousePos: TPoint); override;
    procedure CellMouseDown(const Cell: TGridCoord; Button: TMouseButton; Shift: TShiftState; const ACellRect: TRect; const GridMousePos, CellMousePos: TPoint); override;
    procedure CalcSizingState(X, Y: Integer; var State: TGridStateEh; var Index: Longint; var SizingPos, SizingOfs: Integer); override;
    procedure ColWidthsChanged; override;
    procedure DrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState); override;
    procedure DrawDataCell(ACol, ARow: Longint; AreaCol, AreaRow: Longint; ARect: TRect; AState: TGridDrawState); virtual;
    procedure DrawLabelCell(ACol, ARow: Longint; AreaCol, AreaRow: Longint; ARect: TRect; AState: TGridDrawState); virtual;
    procedure EndLayout;
    procedure InternalLayout;
    procedure LayoutChanged;
    procedure RowCaptionFontChanged(Sender: TObject);
    procedure UpdateRowCount;
    procedure UpdateRowHeights;
    procedure ComponentChanged;

{ Inplace Editor }
//    function GetEditLimit: Integer; override;
//    function GetEditMask(ACol, ARow: Longint): string; override;
    function GetEditStyle(ACol, ARow: Longint): TEditStyle; override;
    function GetEditText(ACol, ARow: Longint): string; override;
    procedure SetEditText(ACol, ARow: Longint; const Value: string); override;
    procedure CurrentCellMoved(OldCurrent: TGridCoord); override;
    procedure UpdateText; override;

    procedure EditButtonClick;
    procedure GetPickListItems(ACol, ARow: Integer; Items: TStrings);

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function GetTreeNodeAt(ARow: Integer): TPropTreeNodeEh;

    property LabelColWidth: Integer read GetLabelColWidth write SetLabelColWidth default 64;
    property PropTreeList: TPropTreeListEh read FPropTreeList;
    property InplaceEditor: TInspectorInplaceEditEh read GetInplaceEdit;

  published
    property Component: TObject read GetComponent write SetComponent;
    property ParentFont;
    property Options;
  end;

{ TInspectorInplaceEditEh }

  TOnGetPickListItems = procedure(ACol, ARow: Integer; Items: TStrings) of Object;

  TInspectorInplaceEditEh = class(TInplaceEdit)
  private
    FButtonWidth: Integer;
    FPickList: TCustomListboxEh;
    FActiveList: TWinControl;
    FEditStyle: TEditStyle;
    FDropDownRows: Integer;
    FListVisible: Boolean;
    FTracking: Boolean;
    FPressed: Boolean;
    FPickListLoaded: Boolean;
    FOnGetPickListitems: TOnGetPickListItems;
    FOnEditButtonClick: TNotifyEvent;
    FMouseInControl: Boolean;
    function GetPickList: TCustomListboxEh;

    {$IFDEF FPC}
    {$ELSE}
    procedure CMCancelMode(var Message: TCMCancelMode); message CM_CANCELMODE;
    {$ENDIF}
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure WMCancelMode(var Message: TWMCancelMode); message WM_CANCELMODE;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMSetCursor(var Message: TWMSetCursor); message WM_SETCURSOR;
    function GetGrid: TObjectInspectorEh;

  protected
    function ButtonRect: TRect;
    function OverButton(const P: TPoint): Boolean;

    procedure BoundsChanged; override;
    procedure CloseUp(Accept: Boolean); dynamic;
    procedure DblClick; override;
    procedure DoDropDownKeys(var Key: Word; Shift: TShiftState); virtual;
    procedure DoEditButtonClick; virtual;
    procedure DoGetPickListItems; dynamic;
    procedure DropDown; dynamic;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure ListMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure PaintWindow(DC: HDC); override;
    procedure StopTracking;
    procedure TrackButton(X,Y: Integer);
    procedure UpdateContents; override;
    procedure WndProc(var Message: TMessage); override;
    procedure Change; override;
  public
    constructor Create(Owner: TComponent); override;
    procedure RestoreContents;
    property ActiveList: TWinControl read FActiveList write FActiveList;
    property ButtonWidth: Integer read FButtonWidth write FButtonWidth;
    property DropDownRows: Integer read FDropDownRows write FDropDownRows;
    property EditStyle: TEditStyle read FEditStyle;
    property ListVisible: Boolean read FListVisible write FListVisible;
    property PickList: TCustomListboxEh read GetPickList;
    property PickListLoaded: Boolean read FPickListLoaded write FPickListLoaded;
    property Pressed: Boolean read FPressed;
    property OnEditButtonClick: TNotifyEvent read FOnEditButtonClick write FOnEditButtonClick;
    property OnGetPickListitems: TOnGetPickListItems read FOnGetPickListitems write FOnGetPickListitems;
    property Grid: TObjectInspectorEh read GetGrid;
  end;

//procedure Register;

procedure ShowObjectInspectorForm(Component: TObject; FormBounds: TRect;
  NewForm: Boolean = False);

var
  ObjectInspectorForm: TCustomForm;

implementation

uses Types, DBCtrls;

{
procedure Register;
begin
  RegisterComponents('EhLib', [TObjectInspectorEh]);
end;
}

function GetPropValueAsString(Instance: TObject; APropInfo: PPropInfo): String;
var
  APropType: PTypeInfo;
  ATypeKind: TTypeKind;

  function SetAsString(Value: Longint): String;
  var
    I: Integer;
    BaseType: PTypeInfo;
  begin
{$IFDEF CIL}
    BaseType := GetTypeData(APropType).CompType;
{$ELSE}
  {$IFDEF FPC}
    BaseType := GetTypeData(APropType)^.CompType;
  {$ELSE}
    BaseType := GetTypeData(APropType)^.CompType^;
  {$ENDIF}
{$ENDIF}
    Result := '[';
    for I := 0 to SizeOf(TIntegerSet) * 8 - 1 do
      if I in TIntegerSet(Value) then
      begin
        if Length(Result) <> 1 then Result := Result + ',';
        Result := Result + GetEnumName(BaseType, I);
      end;
    Result := Result + ']';
  end;


  function IntPropAsString(IntType: PTypeInfo; Value: Longint): String;
{$IFDEF EH_LIB_5}
  var
    Ident: string;
    IntToIdent: TIntToIdent;
{$ENDIF}
  begin
{$IFDEF EH_LIB_5}
    IntToIdent := FindIntToIdent(IntType);
    if Assigned(IntToIdent) and IntToIdent(Value, Ident) then
      Result := Ident
    else
{$ENDIF}
      Result := IntToStr(Value);
  end;

  function CollectionAsString(Collection: TCollection): String;
  begin
    Result := '(' + Collection.ClassName + ')';
  end;

  function OrdPropAsString: String;
  var
    Value: Longint;
  begin
    Value := GetOrdProp(Instance, APropInfo);
    case PropType_GetKind(APropType) of
      tkInteger:
        Result := IntPropAsString(PropInfo_getPropType(APropInfo), Value);
      tkChar:
        Result := Chr(Value);
      tkSet:
        Result := SetAsString(Value);
      tkEnumeration:
        Result := GetEnumName(APropType, Value);
    end;
  end;

  function FloatPropAsString: String;
  var
    Value: Extended;
  begin
    Value := GetFloatProp(Instance, APropInfo);
    Result := FloatToStr(Value);
  end;

  function Int64PropAsString: String;
  var
    Value: Int64;
  begin
    Value := GetInt64Prop(Instance, APropInfo);
    Result := IntToStr(Value);
  end;

  function StrPropAsString: String;
  begin
    Result := GetWideStrProp(Instance, APropInfo);
  end;

  function MethodPropAsString: String;
  var
    Value: TMethod;
  begin
    Value := GetMethodProp(Instance, APropInfo);
    if Value.Code = nil then
      Result := ''
    else
      Result := Instance.MethodName(Value.Code);
  end;

  function ObjectPropAsString: String;
  var
    Value: TObject;
  begin
    Value := GetObjectProp(Instance, APropInfo);
    if Value = nil
      then Result := ''
      else Result := '(' + Value.ClassName + ')';
  end;

  function VariantPropAsString: String;
  var
    Value: Variant;
  begin
    Value := GetVariantProp(Instance, APropInfo);
    Result := VarToStr(Value);
  end;

(*  function GetComponentValue(Component: TComponent): string;
  begin
    if Component.Owner = Instance then //LookupRoot then
      Result := Component.Name
    else if Component = Instance then //LookupRoot then
      Result := 'Owner'                                                       { Do not translate }
    else if (Component.Owner <> nil) and (Component.Owner.Name <> '') and
      (Component.Name <> '') then
      if OwnedBy(Component.Owner, Root) then//LookupRoot) then
        Result := GetComponentValue(Component.Owner) + '.' + Component.Name
      else
        Result := Component.Owner.Name + '.' + Component.Name
    else if Component.Name <> '' then
      Result := Component.Name + '.Owner'                                     { Do not translate }
    else Result := '';
  end;*)

  function InterfacePropAsString: String;
  var
    Intf: IInterface;
    Value: TComponent;
    SR: IInterfaceComponentReference;
  begin
    Intf := GetInterfaceProp(Instance, APropInfo);
    if Intf = nil then
    begin
      Result := '';
    end
    else if Supports(Intf, IInterfaceComponentReference, SR) then
    begin
      Value := SR.GetComponent;
      Result := Value.Name;
    end;
  end;

  function StrPropAsBool: String;
  var
    Value: Longint;
  begin
    Value := GetOrdProp(Instance, APropInfo);
    Result := BooleanIdents[Boolean(Value)];
  end;

begin

  APropType := PropInfo_getPropType(APropInfo);
  ATypeKind := PropType_getKind(APropType);
  case ATypeKind of
    tkInteger, tkChar, tkEnumeration, tkSet:
      Result := OrdPropAsString;
    tkFloat:
      Result := FloatPropAsString;
    tkString, tkLString, tkWString:
      Result := StrPropAsString;
    tkClass:
      Result := ObjectPropAsString;
    tkMethod:
      Result := MethodPropAsString;
    tkVariant:
      Result := VariantPropAsString;
    tkInt64:
      Result := Int64PropAsString;
{$IFDEF EH_LIB_6}
    tkInterface:
      Result := InterfacePropAsString;
{$ENDIF}
{$IFDEF EH_LIB_12}
    tkUString:
      Result := StrPropAsString;
{$ENDIF}
{$IFDEF FPC}
    tkBool:
       Result := StrPropAsBool;
{$ELSE}
{$ENDIF}
  end;
end;

type
  TObjectInspectorFormEh = class(TCustomForm)
    procedure DoClose(var Action: TCloseAction); override;
  end;

procedure TObjectInspectorFormEh.DoClose(var Action: TCloseAction);
begin
  Action := caFree;
  if Self = ObjectInspectorForm then
    ObjectInspectorForm := nil;
end;

procedure ShowObjectInspectorForm(Component: TObject; FormBounds: TRect;
  NewForm: Boolean = False);
var
  Form: TObjectInspectorFormEh;
  FObjIns: TObjectInspectorEh;
begin
  if NewForm or (ObjectInspectorForm = nil) then
  begin
    Form := TObjectInspectorFormEh.CreateNew(Application);
    Form.ParentFont := True;

    FObjIns := TObjectInspectorEh.Create(Form);
    FObjIns.Parent := Form;
    FObjIns.Left := 100;
    FObjIns.Top := 100;
    FObjIns.Anchors := [akLeft, akTop, akRight, akBottom];
    FObjIns.Flat := True;
    FObjIns.ParentFont := True;
    FObjIns.LabelColWidth := 100;
    FObjIns.Options := [goFixedVertLineEh, goVertLineEh, goEditingEh, goAlwaysShowEditorEh];
    FObjIns.Align := alClient;
    FObjIns.Name := 'ObjectInspectorEh';
    if not NewForm then
      ObjectInspectorForm := Form;
  end else
    Form := TObjectInspectorFormEh(ObjectInspectorForm);

  TObjectInspectorEh(Form.FindComponent('ObjectInspectorEh')).Component := Component;
  if Component <> nil then
  begin
    if Component is TComponent then
      Form.Caption := TComponent(Component).Name + ': ';
    Form.Caption := Form.Caption + Component.ClassName
  end else
    Form.Caption := '';
  Form.SetBounds(FormBounds.Left, FormBounds.Top,
    FormBounds.Right-FormBounds.Left, FormBounds.Bottom-FormBounds.Top);
  Form.Show;
end;

{ TObjectInspectorEh }

constructor TObjectInspectorEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FDesignOptionsBoost := [goColSizingEh];
  FRowCaptionFont := TFont.Create;
  FRowCaptionFont.OnChange := RowCaptionFontChanged;

  FPropTreeList := TPropTreeListEh.Create(TPropTreeNodeEh, Self);

//  ScrollBars := ssBoth;
//  DefaultDrawing := False;
  BeginLayout;
//  VirtualView := True;
//  ScrollBars := ssBoth;
  FixedRowCount := 0;
  inherited RowCount := 1;
  inherited ColCount := 2;
//  Options := [dgvhEditing, dgvhAlwaysShowEditor, dgvhCaptionsCol,
//              dgvhRowResize, dgvhColLines, dgvhRowLines,
//              dgvhTabs, dgvhConfirmDelete, dgvhCancelOnExit];
  LabelColWidth := 64;
  EndLayout;
  ShowHint := True;
end;

destructor TObjectInspectorEh.Destroy;
begin
  FreeAndNil(FRowCaptionFont);
  FreeAndNil(FPropTreeList);
  inherited Destroy;
end;

procedure TObjectInspectorEh.DrawCell(ACol, ARow: Integer; ARect: TRect; AState: TGridDrawState);
var
  AreaCol, AreaRow: Integer;
begin
  AreaCol := ACol;
  AreaRow := ARow;
  if ACol = 0 then
    DrawLabelCell(ACol, ARow, AreaCol, AreaRow, ARect, AState)
  else
  begin
    Dec(AreaCol);
    DrawDataCell(ACol, ARow, AreaCol, AreaRow, ARect, AState);
  end;
end;

procedure TObjectInspectorEh.DrawDataCell(ACol, ARow, AreaCol,
  AreaRow: Integer; ARect: TRect; AState: TGridDrawState);
var
  S: String;
  VFrameOffs: Byte;
  HFrameOffs: Byte;
  TreeNode: TPropTreeNodeEh;
begin
  Canvas.Brush.Color := Color; 
  Canvas.FillRect(ARect);
  if AreaRow < PropTreeList.VisibleExpandedCount then
  begin
    Canvas.Font := Font;
    TreeNode := PropTreeList.VisibleExpandedItem[AreaRow];
    S := TreeNode.PropStrValue;

    HFrameOffs := 2;
    if Flat
      then VFrameOffs := 1
      else VFrameOffs := 2;

    if (TreeNode.Parent.Instance <> nil) and
       (TreeNode.PropInfo <> nil) and
       IsStoredProp(TreeNode.Parent.Instance, TreeNode.PropInfo)
    then
    {$IFDEF FPC}
      ;
    {$ELSE}
      if not IsDefaultPropertyValue(TreeNode.Parent.Instance, TreeNode.PropInfo, nil) then
         Canvas.Font.Style := Canvas.Font.Style + [fsBold];
    {$ENDIF}

    WriteTextEh(Canvas, ARect, False, HFrameOffs, VFrameOffs,
      S, taLeftJustify, tlCenter, False,
      False, 0, 0, False, True);
  end;
end;

procedure TObjectInspectorEh.DrawLabelCell(ACol, ARow, AreaCol,
  AreaRow: Integer; ARect: TRect; AState: TGridDrawState);
var
  S: String;
  VFrameOffs: Byte;
  HFrameOffs: Byte;
  TextRect: TRect;
  TreeSignRect: TRect;
  TreeNode: TPropTreeNodeEh;
  TreeElement: TTreeElementEh;
begin
  if Row = ARow
    then Canvas.Brush.Color := cl3DLight
    else Canvas.Brush.Color := Color; 
  Canvas.FillRect(ARect);
  TextRect := ARect;
  if AreaRow < PropTreeList.VisibleExpandedCount then
  begin
    Canvas.Font := Font;
    TreeNode := PropTreeList.VisibleExpandedItem[AreaRow];
    S := TreeNode.PropName;
    Inc(TextRect.Left, DefaultRowHeight * TreeNode.Level);

    if TreeNode.HasChildren then
    begin
      TreeSignRect := TextRect;
      TreeSignRect.Right := TreeSignRect.Left;
      TreeSignRect.Left := TreeSignRect.Left - DefaultRowHeight;
      if TreeNode.Expanded
        then TreeElement := tehMinus
        else TreeElement := tehPlus;
      Canvas.Pen.Color := clWindowText;
      DrawTreeElement(Canvas, TreeSignRect, TreeElement, False, 1, 1,
        UseRightToLeftAlignment, False, tvgsThemedEh);
    end;

    HFrameOffs := 0;
    if Flat
      then VFrameOffs := 1
      else VFrameOffs := 2;

    if TreeNode.Instance is TComponent then
      Canvas.Font.Color := clMaroon
    else if TreeNode.IsCompmentSubrops then
      Canvas.Font.Color := clGreen;

    WriteTextEh(Canvas, TextRect, False, HFrameOffs, VFrameOffs,
      S, taLeftJustify, tlCenter, False,
      False, 0, 0, False, True);
  end;
end;

procedure TObjectInspectorEh.BeginLayout;
begin
  Inc(FLayoutLock);
end;

procedure TObjectInspectorEh.EndLayout;
begin
  if FLayoutLock > 0 then
  begin
    try
      try
        if FLayoutLock = 1 then
          InternalLayout;
      finally
      end;
    finally
      if FLayoutLock > 0 then
        Dec(FLayoutLock);
    end;
  end;
end;

procedure TObjectInspectorEh.RowCaptionFontChanged(Sender: TObject);
begin
  LayoutChanged;
end;

function TObjectInspectorEh.GetLabelColWidth: Integer;
begin
  Result := FLabelColWidth;
end;

procedure TObjectInspectorEh.SetLabelColWidth(const Value: Integer);
begin
  if Value <> FLabelColWidth then
  begin
    FLabelColWidth := Value;
    LayoutChanged;
  end;
end;

procedure TObjectInspectorEh.InternalLayout;
var
  WinWidth: Integer;
begin
  if (csLoading in ComponentState) or
     (csDestroying in ComponentState)
  then
    Exit;

  try
    LockPaint;

    if ([csLoading, csDestroying] * ComponentState) <> [] then Exit;

    ColCount := 2;
    inherited FixedColCount := 1;

    ColWidths[0] := LabelColWidth;

    WinWidth := HorzAxis.GridClientLen;

    ColWidths[1] := WinWidth - ColWidths[0]-2;

    UpdateRowCount;
    UpdateRowHeights;

  //  UpdateActive;
    InvalidateEditor;
    Invalidate;

  finally
    UnlockPaint;
    UpdateBoundaries;
  end;
end;

procedure TObjectInspectorEh.LayoutChanged;
begin
  if AcquireLayoutLock then
    EndLayout;
end;

function TObjectInspectorEh.AcquireLayoutLock: Boolean;
begin
  Result := FLayoutLock = 0;
  if Result then BeginLayout;
end;

procedure TObjectInspectorEh.UpdateRowCount;
begin
  if Component = nil
    then RowCount := 1
    else RowCount := PropTreeList.VisibleExpandedCount;
end;

procedure TObjectInspectorEh.UpdateRowHeights;
var
  CanvasHandleAllocated: Boolean;
  i: Integer;
begin
  CanvasHandleAllocated := True;
  if not Canvas.HandleAllocated then
  begin
    Canvas.Handle := GetDC(0);
    CanvasHandleAllocated := False;
  end;
  try

    DefaultRowHeight := Canvas.TextHeight('Wg') + 2;
    for i := 0 to RowCount-1 do
      RowHeights[i] := DefaultRowHeight;

  finally
    if not CanvasHandleAllocated then
    begin
      ReleaseDC(0, Canvas.Handle);
      Canvas.Handle := 0;
    end;
  end;
end;

function TObjectInspectorEh.GetComponent: TObject;
begin
  Result := FObservableObject;
end;

procedure TObjectInspectorEh.SetComponent(const Value: TObject);
begin
  if Value <> FObservableObject then
  begin
    FObservableObject := Value;
    ComponentChanged;
  end;
end;

procedure TObjectInspectorEh.WMSize(var Message: TWMSize);
begin
  inherited;
  LayoutChanged;
  UpdateEdit;
end;

procedure TObjectInspectorEh.CalcSizingState(X, Y: Integer;
  var State: TGridStateEh; var Index, SizingPos, SizingOfs: Integer);
begin
  inherited CalcSizingState(X, Y, State, Index, SizingPos, SizingOfs);
  if (HorzAxis.FixedBoundary - 4 {- VertLineWidth} < X) and (HorzAxis.FixedBoundary + 4 > X) then
  begin
    State := gsColSizingEh;
    SizingPos := HorzAxis.FixedBoundary;
    SizingOfs := HorzAxis.FixedBoundary - X - 1;
    Index := 0;
  end;
end;

procedure TObjectInspectorEh.ColWidthsChanged;
begin
  inherited ColWidthsChanged;
  if AcquireLayoutLock then
  try
    if LabelColWidth <> ColWidths[0] then
    begin
      LabelColWidth := ColWidths[0];
      LayoutChanged;
    end;

  finally
    EndLayout;
    UpdateEdit;
  end;
end;

procedure TObjectInspectorEh.ComponentChanged;
var
  PropList: TPropListArray;
  NewNode: TPropTreeNodeEh;
  i: Integer;
begin
  PropList := nil;
  PropTreeList.Clear;
  PropTreeList.Root.Instance := Component;

  if Component <> nil then
  begin
    PropList := GetPropListAsArray(Component.ClassInfo, tkProperties);

    for i := 0 to Length(PropList)-1 do
    begin
      NewNode := TPropTreeNodeEh(PropTreeList.AddChild('', nil, nil));
      NewNode.PropInfo := PropList[i];
      NewNode.TypeInfo := PropInfo_getPropType(NewNode.PropInfo);
      NewNode.PropName := String(PropList[i].Name);
      NewNode.PropStrValue := GetPropValueAsString(Component, PropList[i]);
      if (NewNode.TypeInfo.Kind = tkSet) or
         ((NewNode.TypeInfo.Kind = tkClass) and (NewNode.PropStrValue <> ''))
      then
        NewNode.HasChildren := True
      else
        NewNode.HasChildren := False;
      if NewNode.TypeInfo.Kind = tkClass then
        NewNode.Instance := GetObjectProp(Component, NewNode.PropInfo);

      PropTreeList.VisibleItemsBecomeObsolete;
    end;

  end;

  LayoutChanged;
end;

function TObjectInspectorEh.IsSmoothVertScroll: Boolean;
begin
  Result := True;
end;

procedure TObjectInspectorEh.ScrollBarMessage(ScrollBar, ScrollCode,
  Pos: Integer; UseRightToLeft: Boolean);
begin
  if ScrollCode = SB_THUMBTRACK then
    ScrollCode := SB_THUMBPOSITION;
  inherited ScrollBarMessage(ScrollBar, ScrollCode, Pos, UseRightToLeft);
end;

procedure TObjectInspectorEh.CellMouseClick(const Cell: TGridCoord;
  Button: TMouseButton; Shift: TShiftState; const ACellRect: TRect;
  const GridMousePos, CellMousePos: TPoint);
var
  TreeNode: TPropTreeNodeEh;
begin
  inherited CellMouseClick(Cell, Button, Shift, ACellRect, GridMousePos, CellMousePos);

  if (Cell.Y < PropTreeList.VisibleExpandedCount) and (Cell.X = 0) and (ssDouble in Shift) then
  begin
    TreeNode := PropTreeList.VisibleExpandedItem[Cell.Y];

    if TreeNode.HasChildren then
    begin
      if TreeNode.Expanded
        then TreeNode.Collapse
        else TreeNode.Expand;
    end;
  end;
end;

procedure TObjectInspectorEh.CellMouseDown(const Cell: TGridCoord;
  Button: TMouseButton; Shift: TShiftState; const ACellRect: TRect;
  const GridMousePos, CellMousePos: TPoint);
var
  TreeNode: TPropTreeNodeEh;
  LeftTreeBorder, RightTreeBorder: Integer;
begin
  inherited CellMouseDown(Cell, Button, Shift, ACellRect, GridMousePos, CellMousePos);

  if (Cell.Y < PropTreeList.VisibleExpandedCount) and (Cell.X = 0) then
  begin
    Row := Cell.Y;
    TreeNode := PropTreeList.VisibleExpandedItem[Cell.Y];

    if TreeNode.HasChildren then
    begin
      LeftTreeBorder := DefaultRowHeight * (TreeNode.Level-1);
      RightTreeBorder := DefaultRowHeight * (TreeNode.Level);

      if (CellMousePos.X > LeftTreeBorder) and (CellMousePos.X < RightTreeBorder) then
        if TreeNode.Expanded
          then TreeNode.Collapse
          else TreeNode.Expand;
    end;
  end;
end;

function TObjectInspectorEh.GetEditStyle(ACol, ARow: Integer): TEditStyle;
var
  TreeNode: TPropTreeNodeEh;
begin
  Result := esSimple;
  if ARow < PropTreeList.VisibleExpandedCount then
  begin
    TreeNode := PropTreeList.VisibleExpandedItem[ARow];
    Result := TreeNode.GetEditStyle;
  end;
end;

function TObjectInspectorEh.GetEditText(ACol, ARow: Integer): string;
var
  TreeNode: TPropTreeNodeEh;
begin
  if ARow < PropTreeList.VisibleExpandedCount then
  begin
    TreeNode := PropTreeList.VisibleExpandedItem[ARow];
    Result := TreeNode.PropStrValue;
  end;
end;

procedure TObjectInspectorEh.SetEditText(ACol, ARow: Integer; const Value: string);
var
  TreeNode: TPropTreeNodeEh;
begin
  if ARow < PropTreeList.VisibleExpandedCount then
  begin
    TreeNode := PropTreeList.VisibleExpandedItem[ARow];
    if TreeNode.PropStrValue <> Value then
    begin
      TreeNode.SetValueAsString(Value);
      PropTreeList.RefreshAllValues;
      InplaceEditor.UpdateContents;
      Invalidate;
    end;
  end;
end;

function TObjectInspectorEh.CreateEditor: TInplaceEdit;
begin
  Result := TInspectorInplaceEditEh.Create(Self);
end;

procedure TObjectInspectorEh.EditButtonClick;
begin

end;

procedure TObjectInspectorEh.GetPickListItems(ACol, ARow: Integer; Items: TStrings);
var
  TreeNode: TPropTreeNodeEh;
begin
  Items.Clear;
  if ARow < PropTreeList.VisibleExpandedCount then
  begin
    TreeNode := PropTreeList.VisibleExpandedItem[ARow];
    TreeNode.GetListValues(Items);
  end;
end;

procedure TObjectInspectorEh.CurrentCellMoved(OldCurrent: TGridCoord);
begin
  InvalidateRow(OldCurrent.Y);
  InvalidateRow(Row);
end;

function TObjectInspectorEh.GetTreeNodeAt(ARow: Integer): TPropTreeNodeEh;
begin
  if ARow < PropTreeList.VisibleExpandedCount
    then Result := PropTreeList.VisibleExpandedItem[ARow]
    else Result := nil;
end;

procedure TObjectInspectorEh.WMCommand(var Message: TWMCommand);
begin
  if Message.NotifyCode = EN_CHANGE then
    FEditChangedThroughEnChangeCode := True;
  try
    inherited;
  finally
    FEditChangedThroughEnChangeCode := False;
  end;
end;

procedure TObjectInspectorEh.UpdateText;
begin
  if not FEditChangedThroughEnChangeCode then
    inherited UpdateText;
end;

function TObjectInspectorEh.GetInplaceEdit: TInspectorInplaceEditEh;
begin
  Result := TInspectorInplaceEditEh(inherited InplaceEditor);
end;

procedure TObjectInspectorEh.CMHintShow(var Message: TCMHintShow);
var
  Cell: TGridCoord;
  S: String;
  ACellRect, TextRect: TRect;
  TreeNode: TPropTreeNodeEh;
  ATextWidth: Integer;

begin
  with Message do
  begin
    Cell := MouseCoord(HitTest.X, HitTest.Y);
    if (Cell.X < 0) or (Cell.Y < 0) then Exit;
    if Cell.X = 0 then
    begin
      if Cell.Y < PropTreeList.VisibleExpandedCount then
      begin
        ACellRect := CellRect(Cell.X, Cell.Y);
        TreeNode := PropTreeList.VisibleExpandedItem[Cell.Y];
        S := TreeNode.PropName;
        TextRect := ACellRect;
        Inc(TextRect.Left, DefaultRowHeight * TreeNode.Level);
        Canvas.Font := Font;
        ATextWidth := Canvas.TextWidth(S);
        if TextRect.Right < TextRect.Left + ATextWidth then
          with PHintInfo(Message.HintInfo)^ do
          begin
            CursorRect := ACellRect;
            HintPos := ClientToScreen(TextRect.TopLeft);
            HintPos.X := HintPos.X - 3;
            HintPos.Y := HintPos.Y - 3;
            HintStr := S;
          end;
      end;
    end else
      inherited;
  end;
end;

procedure TObjectInspectorEh.CMHintsShowPause(var Message: TCMHintShowPause);
var
  Cell: TGridCoord;
begin
  with Message do
  begin
    Cell := MouseCoord(HitTest.X, HitTest.Y);
    if (Cell.X < 0) or (Cell.Y < 0) then Exit;
    if Cell.X = 0 then
      Message.Pause^ := 0
    else
      inherited;
  end;
end;

{ TPropTreeNodeEh }

constructor TPropTreeNodeEh.Create;
begin
  inherited Create;
end;

destructor TPropTreeNodeEh.Destroy;
begin
  inherited Destroy;
end;

procedure TPropTreeNodeEh.Collapse;
begin
  Expanded := False;
  Owner.VisibleItemsBecomeObsolete;
  Owner.ObjectInspector.LayoutChanged;
end;

procedure TPropTreeNodeEh.Expand;
var
  PropList: TPropListArray;
  NewNode: TPropTreeNodeEh;
  i: Integer;
  Component: TObject;

  ASetTypeData: PTypeData;
  SetAsIntValue: Longint;

  Coll: TCollection;
//  AColTypeInfo: PTypeData;
//  SetAsIntSet: TIntegerSet;

begin
  PropList := nil;
  if Count = 0 then
  begin
    if (TypeInfo.Kind = tkClass) and (PropStrValue <> '') then
    begin
      if Parent.Instance is TCollection
        then Component := Instance
        else Component := GetObjectProp(Parent.Instance, PropInfo);
      if Component is TCollection then
      begin
        Coll := Component as TCollection;
        for i := 0 to Coll.Count-1 do
        begin
          NewNode := TPropTreeNodeEh(Owner.AddChild('', Self, nil));
          NewNode.PropInfo := nil;
          NewNode.TypeInfo := Coll.ItemClass.ClassInfo;
          NewNode.PropName := 'Item['+IntToStr(i)+']';
          NewNode.PropStrValue := '('+Coll.ItemClass.ClassName+')';
          NewNode.HasChildren := True;
          NewNode.Instance := Coll.Items[i];
        end;
      end else if Component <> nil then
      begin
        PropList := GetPropListAsArray(Component.ClassInfo, tkProperties);

        for i := 0 to Length(PropList)-1 do
        begin
          NewNode := TPropTreeNodeEh(Owner.AddChild('', Self, nil));
          NewNode.PropInfo := PropList[i];
          NewNode.TypeInfo := PropInfo_getPropType(NewNode.PropInfo);
          NewNode.PropName := String(PropList[i].Name);
          NewNode.PropStrValue := GetPropValueAsString(Component, PropList[i]);
          if (NewNode.TypeInfo.Kind = tkSet) or
             ((NewNode.TypeInfo.Kind = tkClass) and (NewNode.PropStrValue <> ''))
          then
            NewNode.HasChildren := True
          else
            NewNode.HasChildren := False;
          if NewNode.TypeInfo.Kind = tkClass then
            NewNode.Instance := GetObjectProp(Component, NewNode.PropInfo);
          if Component is TComponent then
            NewNode.FIsCompmentSubrops := True;
        end;
      end;
    end else if TypeInfo.Kind = tkSet then
    begin
      {$IFDEF FPC}
      ASetTypeData := GetTypeData(GetTypeData(TypeInfo)^.CompType);
      {$ELSE}
      ASetTypeData := GetTypeData(GetTypeData(TypeInfo)^.CompType^);
      {$ENDIF}
      SetAsIntValue := GetOrdProp(Parent.Instance, PropInfo);

      for I := ASetTypeData.MinValue to ASetTypeData.MaxValue do
      begin
        NewNode := TPropTreeNodeEh(Owner.AddChild('', Self, nil));
        NewNode.PropInfo := nil;
        NewNode.TypeInfo := nil;
        {$IFDEF FPC}
        NewNode.PropName := GetEnumName(GetTypeData(TypeInfo)^.CompType, I);
        {$ELSE}
        NewNode.PropName := GetEnumName(GetTypeData(TypeInfo)^.CompType^, I);
        {$ENDIF}
        NewNode.PropStrValue := BooleanIdents[I in TIntegerSet(SetAsIntValue)];
        NewNode.HasChildren := False;
        NewNode.IsSetValue := True;
        NewNode.SetIndex := I;
      end;
      
    end;
  end;
  Expanded := True;
  Owner.VisibleItemsBecomeObsolete;
  Owner.ObjectInspector.LayoutChanged;
end;

function TPropTreeNodeEh.GetItem(const Index: Integer): TPropTreeNodeEh;
begin
  Result := TPropTreeNodeEh(inherited Items[Index]);
end;

function TPropTreeNodeEh.GetNodeOwner: TPropTreeListEh;
begin
  Result := TPropTreeListEh(inherited Owner);
end;

function TPropTreeNodeEh.GetNodeParent: TPropTreeNodeEh;
begin
  Result := TPropTreeNodeEh(inherited Parent);
end;

function TPropTreeNodeEh.GetVisibleItem(const Index: Integer): TPropTreeNodeEh;
begin
  Result := TPropTreeNodeEh(inherited VisibleItems[Index])
end;

procedure TPropTreeNodeEh.SetNodeParent(const Value: TPropTreeNodeEh);
begin
  Parent := Value;
end;

function TPropTreeNodeEh.GetEditStyle: TEditStyle;
begin
  Result := esSimple;
  if (TypeInfo <> nil) and (TypeInfo.Kind = tkEnumeration) then
    Result := esPickList
  else if IsSetValue then
    Result := esPickList
  else if TypeInfo = System.TypeInfo(TColor) then
    Result := esPickList
  {$IFDEF FPC}
  else if (TypeInfo <> nil) and (TypeInfo.Kind = tkBool) then
    Result := esPickList;
  {$ELSE}
  ;
  {$ENDIF}
end;

procedure TPropTreeNodeEh.GetListValues(Items: TStrings);
var
  ASetTypeData: PTypeData;
  I: Integer;
  S: String;
begin
  if IsSetValue then
  begin
    Items.Add('True');
    Items.Add('False');
  {$IFDEF FPC}
  end else if TypeInfo.Kind in [tkEnumeration, tkBool] then
  {$ELSE}
  end else if TypeInfo.Kind = tkEnumeration then
  {$ENDIF}
  begin
    ASetTypeData := GetTypeData(TypeInfo);

    for I := ASetTypeData.MinValue to ASetTypeData.MaxValue do
    begin
      S := GetEnumName(TypeInfo, I);
      Items.Add(S);
    end;
  end else if TypeInfo = System.TypeInfo(TColor) then
  begin
    FColorList := Items;
    GetColorValues(GetColorStrProc);
  end;
end;

function TPropTreeNodeEh.GetFontStyle: TFontStyles;
begin
  Result := [];
  {$IFDEF FPC}
  {$ELSE}
  if (Parent.Instance <> nil) and
     (PropInfo <> nil) and
     IsStoredProp(Parent.Instance, PropInfo)
     and not IsDefaultPropertyValue(Parent.Instance, PropInfo, nil)
  then
    Result := [fsBold];
  {$ENDIF}
end;

procedure TPropTreeNodeEh.SetValueAsString(SValue: String);
var
  S: TIntegerSet;
  NewValue: Longint;
begin
  if IsSetValue then
  begin
    Integer(S) :=  StringToSet(Parent.PropInfo, Parent.PropStrValue);
    if CompareText(SValue, BooleanIdents[True]) = 0 then
      Include(S, SetIndex)
    else
      Exclude(S, SetIndex);
    Parent.SetValueAsString(SetToString(Parent.PropInfo, Integer(S)));
  end else if TypeInfo = System.TypeInfo(TColor) then
  begin
    if IdentToColor(SValue, NewValue) then
      SetPropValue(Parent.Instance, PropName, NewValue)
    else
      SetPropValue(Parent.Instance, PropName, StrToInt(SValue))
  end else if TypeInfo.Kind in [tkInteger, tkInt64] then
    SetPropValue(Parent.Instance, PropName, StrToInt(SValue))
  else if TypeInfo.Kind in [tkFloat] then
    SetPropValue(Parent.Instance, PropName, StrToFloat(SValue))
  else
    SetPropValue(Parent.Instance, PropName, SValue);

  PropStrValue := SValue;
end;

procedure TPropTreeNodeEh.GetColorStrProc(const S: string);
begin
  FColorList.Add(S);
end;

procedure TPropTreeNodeEh.RefreshValue;
begin
  if IsSetValue then
  else if PropInfo <> nil then
    PropStrValue := GetPropValueAsString(Parent.Instance, PropInfo);
end;

{ TPropTreeListEh }

constructor TPropTreeListEh.Create(ItemClass: TPropTreeNodeClassEh;
  ObjInspector: TObjectInspectorEh);
begin
  inherited Create(ItemClass);
  FObjInspector := ObjInspector;
  FVisibleExpandedItems := TObjectList.Create(False);
end;

destructor TPropTreeListEh.Destroy;
begin
  FreeAndNil(FVisibleExpandedItems);
  inherited Destroy;
end;

procedure TPropTreeListEh.BuildVisibleItems;
var
  CurNode: TBaseTreeNodeEh;
begin
  FVisibleExpandedItems.Clear;
  CurNode := GetFirstVisible;
  while CurNode <> nil do
  begin
    FVisibleExpandedItems.Add(CurNode);
    CurNode := GetNextVisible(CurNode, True);
  end;

  FVisibleItemsObsolete := False;
end;

function TPropTreeListEh.GetVisibleCount: Integer;
begin
  if FVisibleItemsObsolete then
    BuildVisibleItems;
  Result := FVisibleExpandedItems.Count;
end;

function TPropTreeListEh.GetVisibleExpandedItem(const Index: Integer): TPropTreeNodeEh;
begin
  if FVisibleItemsObsolete then
    BuildVisibleItems;
  if (Index < 0) or (Index > FVisibleExpandedItems.Count-1) then
  begin
    Result := nil;
    Exit;
  end;
  Result := TPropTreeNodeEh(FVisibleExpandedItems.Items[Index]);
end;

procedure TPropTreeListEh.VisibleItemsBecomeObsolete;
begin
  FVisibleItemsObsolete := True;
end;

function TPropTreeListEh.GetRoot: TPropTreeNodeEh;
begin
  Result := TPropTreeNodeEh(inherited Root);
end;

procedure TPropTreeListEh.RefreshAllValues;
var
  CurNode: TBaseTreeNodeEh;
begin
  CurNode := GetFirst;
  while CurNode <> nil do
  begin
    TPropTreeNodeEh(CurNode).RefreshValue;
    CurNode := GetNext(CurNode);
  end;
end;

{ TInspectorInplaceEditEh }

constructor TInspectorInplaceEditEh.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  FButtonWidth := GetSystemMetrics(SM_CXVSCROLL);
  FEditStyle := esSimple;
end;

procedure TInspectorInplaceEditEh.BoundsChanged;
var
  R: TRect;
begin
  SetRect(R, 2, 1, Width - 2, Height);
  if EditStyle <> esSimple then
    if not Grid.UseRightToLeftAlignment then
      Dec(R.Right, ButtonWidth)
    else
      Inc(R.Left, ButtonWidth - 2);
  SendStructMessage(Handle, EM_SETRECTNP, 0, R);
  SendMessage(Handle, EM_SCROLLCARET, 0, 0);
  {$IFDEF FPC}
  {$ELSE}
  if SysLocale.FarEast then
    SetImeCompositionWindow(Font, R.Left, R.Top);
  {$ENDIF}
end;

procedure TInspectorInplaceEditEh.DoDropDownKeys(var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_UP, VK_DOWN:
      if ssAlt in Shift then
      begin
        if ListVisible then CloseUp(True) else DropDown;
        Key := 0;
      end;
    VK_RETURN, VK_ESCAPE:
      if ListVisible and not (ssAlt in Shift) then
      begin
        CloseUp(Key = VK_RETURN);
        Key := 0;
      end;
  end;
end;

procedure TInspectorInplaceEditEh.DoEditButtonClick;
begin
//  if Assigned(FOnEditButtonClick) then
//    FOnEditButtonClick(Grid);
  Grid.EditButtonClick;
end;

procedure TInspectorInplaceEditEh.DoGetPickListItems;
begin
  if not PickListLoaded then
  begin
//    if Assigned(OnGetPickListItems) then
//      OnGetPickListItems(Grid.Col, Grid.Row, PickList.Items);
    Grid.GetPickListItems(Grid.Col, Grid.Row, PickList.Items);
    PickListLoaded := (PickList.Items.Count > 0);
  end;
end;

function TInspectorInplaceEditEh.GetPickList: TCustomListboxEh;
var
  PopupListbox: TPopupListboxEh;
begin
  if not Assigned(FPickList) then
  begin
    PopupListbox := TPopupListboxEh.Create(Self);
    PopupListbox.Visible := False;
    {$IFDEF FPC}
    {$ELSE}
    PopupListbox.Parent := Self;
    {$ENDIF}
    PopupListbox.OnMouseUp := ListMouseUp;
//    PopupListbox.IntegralHeight := True;
    PopupListbox.ItemHeight := 11;
    FPickList := PopupListBox;
  end;
  Result := FPickList;
end;

procedure TInspectorInplaceEditEh.DropDown;
var
  P: TPoint;
//  I,J: Integer;
//  Y: Integer;
begin
  if not ListVisible then
  begin
    ActiveList.Width := Width;
    if ActiveList = FPickList then
    begin
      DoGetPickListItems;
      TPopupListboxEh(PickList).Color := Color;
      TPopupListboxEh(PickList).Font := Font;
      TPopupListboxEh(PickList).ItemHeight := TPopupListboxEh(PickList).GetTextHeight;
      if (DropDownRows > 0) and (PickList.Items.Count >= DropDownRows) then
        PickList.Height := DropDownRows * TPopupListboxEh(PickList).ItemHeight + 4
      else
        PickList.Height := PickList.Items.Count * TPopupListboxEh(PickList).ItemHeight + 4;
      if Text = '' then
        PickList.ItemIndex := -1
      else
        PickList.ItemIndex := PickList.Items.IndexOf(Text);
      {J := PickList.ClientWidth;
      for I := 0 to PickList.Items.Count - 1 do
      begin
        Y := PickList.Canvas.TextWidth(PickList.Items[I]);
        if Y > J then J := Y;
      end;
      PickList.ClientWidth := J;}
    end;
    P := AlignDropDownWindow(Self, ActiveList, daLeft);

{    P := Parent.ClientToScreen(Point(Left, Top));
    Y := P.Y + Height;
    if Y + ActiveList.Height > Screen.Height then Y := P.Y - ActiveList.Height;}

    {$IFDEF FPC}
    ActiveList.SetBounds(P.X, P.Y, ActiveList.Width, ActiveList.Height);
    ActiveList.Visible := True;
    {$ELSE}
    SetWindowPos(ActiveList.Handle, HWND_TOP, P.X, P.Y, 0, 0,
      SWP_NOSIZE or SWP_NOACTIVATE or SWP_SHOWWINDOW);
    {$ENDIF}

    FListVisible := True;
    Invalidate;
    Windows.SetFocus(Handle);
  end;
end;

procedure TInspectorInplaceEditEh.CloseUp(Accept: Boolean);
var
  ListValue: Variant;
begin
  if ListVisible and (ActiveList = FPickList) then
  begin
    if GetCapture <> 0 then SendMessage(GetCapture, WM_CANCELMODE, 0, 0);
    if PickList.ItemIndex <> -1 then
{$IF DEFINED(CLR)}
      ListValue := PickList.Items[PickList.ItemIndex]
    else
      ListValue := Unassigned;
{$ELSE}
      ListValue := PickList.Items[PickList.ItemIndex];
{$IFEND}
    SetWindowPos(ActiveList.Handle, 0, 0, 0, 0, 0, SWP_NOZORDER or
      SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_HIDEWINDOW);
    FListVisible := False;
    Invalidate;
    if Accept then
      if (not VarIsEmpty(ListValue) or VarIsNull(ListValue))
         and (VarToStr(ListValue) <> Text) then
      begin
        { Here we store the new value directly in the edit control so that
          we bypass the CMTextChanged method on TCustomMaskedEdit.  This
          preserves the old value so that we can restore it later by calling
          the Reset method. }
{$IF DEFINED(CLR)}
        Perform(WM_SETTEXT, 0, VarToStr(ListValue));
{$ELSE}
        Perform(WM_SETTEXT, 0, LPARAM(String(ListValue)));
{$IFEND}
        Modified := True;
        with Grid do
          SetEditText(Col, Row, VarToStr(ListValue));
      end;
  end;
end;

procedure TInspectorInplaceEditEh.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if (EditStyle = esEllipsis) and (Key = VK_RETURN) and (Shift = [ssCtrl]) then
  begin
    DoEditButtonClick;
    KillMessage(Handle, WM_CHAR);
  end
  else
    inherited KeyDown(Key, Shift);
  if (Key = VK_RETURN) and (Shift = []) then
    Grid.UpdateText;
end;

procedure TInspectorInplaceEditEh.ListMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
    CloseUp(PtInRect(ActiveList.ClientRect, Point(X, Y)));
end;

procedure TInspectorInplaceEditEh.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  if (Button = mbLeft) and (EditStyle <> esSimple) and
    OverButton(Point(X,Y)) then
  begin
    if ListVisible then
      CloseUp(False)
    else
    begin
      MouseCapture := True;
      FTracking := True;
      TrackButton(X, Y);
      if Assigned(ActiveList) then
        DropDown;
    end;
  end;
  inherited MouseDown(Button, Shift, X, Y);
end;

procedure TInspectorInplaceEditEh.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  ListPos: TPoint;
begin
  if FTracking then
  begin
    TrackButton(X, Y);
    if ListVisible then
    begin
      ListPos := ActiveList.ScreenToClient(ClientToScreen(Point(X, Y)));
      if PtInRect(ActiveList.ClientRect, ListPos) then
      begin
        StopTracking;
        SendMessage(ActiveList.Handle, WM_LBUTTONDOWN, 0, PointToLParam(ListPos));
        Exit;
      end;
    end;
  end;
  inherited MouseMove(Shift, X, Y);
end;

procedure TInspectorInplaceEditEh.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  WasPressed: Boolean;
begin
  WasPressed := Pressed;
  StopTracking;
  if (Button = mbLeft) and (EditStyle = esEllipsis) and WasPressed then
    DoEditButtonClick;
  inherited MouseUp(Button, Shift, X, Y);
end;

procedure TInspectorInplaceEditEh.PaintWindow(DC: HDC);
var
  R: TRect;
  Flags: Integer;
  W, X, Y: Integer;
  Details: TThemedElementDetails;
begin
  if EditStyle <> esSimple then
  begin
    R := ButtonRect;
    Flags := 0;
    case EditStyle of
      esPickList:
        begin
          if ThemeServices.ThemesEnabled then
          begin
            if ActiveList = nil then
              Details := ThemeServices.GetElementDetails(tcDropDownButtonDisabled)
            else
              if Pressed then
                Details := ThemeServices.GetElementDetails(tcDropDownButtonPressed)
              else
                if FMouseInControl then
                  Details := ThemeServices.GetElementDetails(tcDropDownButtonHot)
                else
                  Details := ThemeServices.GetElementDetails(tcDropDownButtonNormal);
            ThemeServices.DrawElement(DC, Details, R);
          end
          else
          begin
            if ActiveList = nil then
              Flags := DFCS_INACTIVE
            else if Pressed then
              Flags := DFCS_FLAT or DFCS_PUSHED;
            DrawFrameControl(DC, R, DFC_SCROLL, Flags or DFCS_SCROLLCOMBOBOX);
          end;
        end;
      esEllipsis:
        begin
          if ThemeServices.ThemesEnabled then
          begin
            if Pressed then
              Details := ThemeServices.GetElementDetails(tbPushButtonPressed)
            else
              if FMouseInControl then
                Details := ThemeServices.GetElementDetails(tbPushButtonHot)
              else
                Details := ThemeServices.GetElementDetails(tbPushButtonNormal);
            ThemeServices.DrawElement(DC, Details, R);
          end
          else
          begin
            if Pressed then Flags := BF_FLAT;
            DrawEdge(DC, R, EDGE_RAISED, BF_RECT or BF_MIDDLE or Flags);
          end;

          X := R.Left + ((R.Right - R.Left) shr 1) - 1 + Ord(Pressed);
          Y := R.Top + ((R.Bottom - R.Top) shr 1) - 1 + Ord(Pressed);
          W := ButtonWidth shr 3;
          if W = 0 then W := 1;
          PatBlt(DC, X, Y, W, W, BLACKNESS);
          PatBlt(DC, X - (W * 2), Y, W, W, BLACKNESS);
          PatBlt(DC, X + (W * 2), Y, W, W, BLACKNESS);
        end;
    end;
    ExcludeClipRect(DC, R.Left, R.Top, R.Right, R.Bottom);
  end;
  inherited PaintWindow(DC);
end;

procedure TInspectorInplaceEditEh.StopTracking;
begin
  if FTracking then
  begin
    TrackButton(-1, -1);
    FTracking := False;
    MouseCapture := False;
  end;
end;

procedure TInspectorInplaceEditEh.TrackButton(X,Y: Integer);
var
  NewState: Boolean;
  R: TRect;
begin
  R := ButtonRect;
  NewState := PtInRect(R, Point(X, Y));
  if Pressed <> NewState then
  begin
    FPressed := NewState;
    InvalidateRect(Handle, @R, False);
  end;
end;

procedure TInspectorInplaceEditEh.UpdateContents;
var
  TreeNode: TPropTreeNodeEh;
begin
  ActiveList := nil;
  PickListLoaded := False;
  FEditStyle := Grid.GetEditStyle(Grid.Col, Grid.Row);
  if EditStyle = esPickList then
    ActiveList := PickList;

  TreeNode := Grid.GetTreeNodeAt(Grid.Row);
  if TreeNode <> nil then
  begin
    Font.Style := TreeNode.GetFontStyle;
  end;
  inherited UpdateContents;
end;

procedure TInspectorInplaceEditEh.RestoreContents;
begin
  Reset;
  Grid.UpdateText;
end;

{$IFDEF FPC}
{$ELSE}
procedure TInspectorInplaceEditEh.CMCancelMode(var Message: TCMCancelMode);
begin
  if (Message.Sender <> Self) and (Message.Sender <> ActiveList) then
    CloseUp(False);
end;
{$ENDIF}

procedure TInspectorInplaceEditEh.WMCancelMode(var Message: TWMCancelMode);
begin
  StopTracking;
  inherited;
end;

procedure TInspectorInplaceEditEh.WMKillFocus(var Message: TWMKillFocus);
begin
  if not SysLocale.FarEast then
  begin
    inherited;
  end else
  begin
    {$IFDEF FPC}
    inherited;
    {$ELSE}
    ImeName := Screen.DefaultIme;
    ImeMode := imDontCare;
    inherited;
    if HWND(Message.FocusedWnd) <> Grid.Handle then
      ActivateKeyboardLayout(Screen.DefaultKbLayout, KLF_ACTIVATE);
    {$ENDIF}
  end;
  CloseUp(False);
end;

function TInspectorInplaceEditEh.ButtonRect: TRect;
begin
  if not Grid.UseRightToLeftAlignment then
    Result := Rect(Width - ButtonWidth, 0, Width, Height)
  else
    Result := Rect(0, 0, ButtonWidth, Height);
end;

function TInspectorInplaceEditEh.OverButton(const P: TPoint): Boolean;
begin
  Result := PtInRect(ButtonRect, P);
end;

procedure TInspectorInplaceEditEh.WMLButtonDblClk(var Message: TWMLButtonDblClk);
begin
  with Message do
  if (EditStyle <> esSimple) and OverButton(Point(XPos, YPos)) then
    Exit;
  inherited;
end;

procedure TInspectorInplaceEditEh.WMPaint(var Message: TWMPaint);
begin
  {$IFDEF FPC}
  inherited;
  {$ELSE}
  PaintHandler(Message);
  {$ENDIF}
end;

procedure TInspectorInplaceEditEh.WMSetCursor(var Message: TWMSetCursor);
var
  P: TPoint;
begin
  GetCursorPos(P);
  P := ScreenToClient(P);
  if (EditStyle <> esSimple) and OverButton(P) then
    Windows.SetCursor(LoadCursor(0, idc_Arrow))
  else
    inherited;
end;

procedure TInspectorInplaceEditEh.WndProc(var Message: TMessage);
var
  TheChar: Word;
begin
  case Message.Msg of
    wm_KeyDown, wm_SysKeyDown, wm_Char:
      if EditStyle = esPickList then
      with TWMKey(Message) do
      begin
        TheChar := CharCode;
        DoDropDownKeys(TheChar, KeyDataToShiftState(KeyData));
        CharCode := TheChar;
        if (CharCode <> 0) and ListVisible then
        begin
          with Message do
            SendMessage(ActiveList.Handle, Msg, WParam, LParam);
          Exit;
        end;
      end
  end;
  inherited;
end;

procedure TInspectorInplaceEditEh.Change;
begin
  Grid.FEditChangedThroughEnChangeCode := True;
  try
    inherited Change;
  finally
    Grid.FEditChangedThroughEnChangeCode := False;
  end;
end;

procedure TInspectorInplaceEditEh.DblClick;
var
  Index: Integer;
  ListValue: string;
begin
  if (EditStyle = esSimple) or Assigned(Grid.OnDblClick) then
    inherited
  else if (EditStyle = esPickList) and (ActiveList = PickList) then
  begin
    DoGetPickListItems;
    if PickList.Items.Count > 0 then
    begin
      Index := PickList.Items.IndexOf(Text);
      if Index >= 0
        then PickList.ItemIndex := Index
        else PickList.ItemIndex := 0;
      Index := PickList.ItemIndex + 1;
      if Index >= PickList.Items.Count then
        Index := 0;
      PickList.ItemIndex := Index;
      ListValue := PickList.Items[PickList.ItemIndex];
{$IF DEFINED(CLR)}
      Perform(WM_SETTEXT, 0, ListValue);
{$ELSE}
      Perform(WM_SETTEXT, 0, LPARAM(ListValue));
{$IFEND}
      Modified := True;
      with Grid do
        SetEditText(Col, Row, ListValue);
      SelectAll;
    end;
  end
  else if EditStyle = esEllipsis then
    DoEditButtonClick;
end;

procedure TInspectorInplaceEditEh.CMMouseEnter(var Message: TMessage);
begin
  inherited;

  if ThemeServices.ThemesEnabled and not FMouseInControl then
  begin
    FMouseInControl := True;
    Invalidate;
  end;
end;

procedure TInspectorInplaceEditEh.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  if ThemeServices.ThemesEnabled and FMouseInControl then
  begin
    FMouseInControl := False;
    Invalidate;
  end;
end;

function TInspectorInplaceEditEh.GetGrid: TObjectInspectorEh;
begin
  Result := TObjectInspectorEh(inherited Grid);
end;

end.
