{*******************************************************}
{                                                       }
{                        EhLib 7.0                      }
{                                                       }
{          Tool Controls for GridsEh component          }
{                      Build 7.0.002                    }
{                                                       }
{   Copyright (c) 2013-2014 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit GridToolCtrlsEh;

interface

uses Windows, SysUtils, Messages, Classes, Controls, Forms, StdCtrls,
{$IFDEF EH_LIB_6} Variants, Types, {$ENDIF}
{$IFDEF EH_LIB_7} Themes, UxTheme, {$ENDIF}
{$IFDEF EH_LIB_17} System.UITypes, {$ENDIF}
{$IFDEF FPC}
  EhLibLCL, LCLType, LMessages, Win32Int,
{$ELSE}
  EhLibVCL,
{$ENDIF}
  ToolCtrlsEh,
  Graphics, DBCtrls,
  ExtCtrls, Buttons, Menus;

type

{ TControlScrollBarEh }

  TControlScrollBarEh = class(TScrollBar)
  private
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMRButtonDown(var Message: TWMRButtonDown); message WM_RBUTTONDOWN;
    procedure WMMButtonDown(var Message: TWMMButtonDown); message WM_MBUTTONDOWN;
    procedure WMMouseActivate(var Message: TMessage); message WM_MOUSEACTIVATE;
    procedure CMDesignHitTest(var Msg: TCMDesignHitTest); message CM_DESIGNHITTEST;
  public
    procedure SetBounds(ALeft: Integer; ATop: Integer; AWidth: Integer; AHeight: Integer); override;
  end;

{ TGridScrollBarPanelControlEh }

  TGridScrollBarPanelControlEh = class(TCustomPanel)
  private
    FScrollBar: TScrollBar;
    FKeepMaxSizeInDefault: Boolean;
//    FTBNavigator: TToolBar;
    function GetOnScroll: TScrollEvent;
    procedure SetOnScroll(const Value: TScrollEvent);
    procedure SetKeepMaxSizeInDefault(const Value: Boolean);

  protected
    FKind: TScrollBarKind;

    function ScrollBatCode: Integer;
    function ChildControlCanMouseDown(AControl: TControl): Boolean; virtual;
    procedure AlignControls(AControl: TControl; var Rect: TRect); override;
    procedure Resize; override;
    procedure CreateHandle; override;
    procedure OnScrollEvent(Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);

  public
    constructor Create(AOwner: TComponent; AKind: TScrollBarKind); reintroduce;
    destructor Destroy; override;

    function MaxSizeForExtraPanel: Integer;
    procedure AdjustSize; override;
    procedure Invalidate; override;
    procedure SetParams(APosition, AMin, AMax, APageSize: Integer);

    property OnScroll: TScrollEvent read GetOnScroll write SetOnScroll;
    property ScrollBar: TScrollBar read FScrollBar;
    property KeepMaxSizeInDefault: Boolean read FKeepMaxSizeInDefault write SetKeepMaxSizeInDefault;
  end;

  TGripActiveStatusEh = (gasNeverEh, gasAutoEh, gasAlwaysEh);

  { TSizeGripPanelEh }

  TSizeGripPanelEh = class(TCustomPanel)
  private
    FTriangleWindow: Boolean;
    FGripActiveStatus: TGripActiveStatusEh;
    FPosition: TSizeGripPosition;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
//    procedure WMSetCursor(var Message: TWMSetCursor); message WM_SetCursor;
    procedure SetTriangleWindow(const Value: Boolean);
    procedure SetPosition(const Value: TSizeGripPosition);
  protected
    FInitFormSize: TPoint;
    FInitFormPos: TPoint;
    FMouseMousePos: TPoint;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Paint; override;
    function CheckInCorner: Boolean;
    function CheckGripActive: Boolean;
    function GetFormSize: TPoint;
    function GetForm: TWinControl;
    procedure UpdateWindowRegion;
    procedure CreateWnd; override;
    procedure Resize; override;
  public
    constructor Create(AOwner: TComponent); override;
    property TriangleWindow: Boolean read FTriangleWindow write SetTriangleWindow default True;
    property GripActiveStatus: TGripActiveStatusEh read FGripActiveStatus write FGripActiveStatus;
    property Position: TSizeGripPosition read FPosition write SetPosition;
  end;

{ TGridDragWinEh }

  TGridDragWinEh = class(TWinControl)
  private
    FAlphaBlendValue: Byte;
    FTransparentColorValue: TColor;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure SetLayeredAttribs;
  public
    constructor Create(AOwner: TComponent); override;
    function Visible: Boolean;
    procedure Show;
    procedure MoveToFor(Control: TControl; NewPos: TPoint); overload; virtual;
    procedure MoveToFor(Control: TControl; NewPos: TPoint; NewWidth, NewHeight: Integer); overload; virtual;
    procedure StartShow(Control: TControl; Pos: TPoint; Width, Height: Integer); overload; virtual;
    procedure StartShow(Control: TControl; Pos: TPoint; Height: Integer); overload; virtual;
    procedure TemporaryHide;

  end;

{ TGridDragBoxEh }

  TGridDragBoxEh = class(TGridDragWinEh)
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

{ TGridMoveLineEh }

  TGridMoveLineEh = class(TGridDragWinEh)
  protected
    sHigh7: TShape;
    sHigh5: TShape;
    sHigh3: TShape;
    sLine: TShape;
    sLow3: TShape;
    sLow5: TShape;
    sLow7: TShape;

    hLeft7: TShape;
    hLeft5: TShape;
    hLeft3: TShape;
    hLine: TShape;
    hRight3: TShape;
    hRight5: TShape;
    hRight7: TShape;

    FIsVert: Boolean;
    procedure CreateParams(var Params: TCreateParams); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure StartShow(Control: TControl; Pos: TPoint; AIsVert: Boolean; Size: Integer; ACaptureControl: TObject); virtual;
    procedure MoveToFor(Control: TControl; NewPos: TPoint); override;
    procedure UpdateOrientationData;
    property IsVert: Boolean read FIsVert;
  end;

  function GetDragBoxEh: TGridDragWinEh;
  function GetMoveLineEh: TGridMoveLineEh;

implementation

uses GridsEh, Dialogs, Clipbrd;

type
//  TWinControlCrack = class(TWinControl);
  TCustomGridCrack = class(TCustomGridEh);

{ TGridScrollBarPanelControlEh }

function TGridScrollBarPanelControlEh.ChildControlCanMouseDown(
  AControl: TControl): Boolean;
var
  Grid: TCustomGridCrack;
begin
  Grid := TCustomGridCrack(Owner);
  Result := Grid.ChildControlCanMouseDown(AControl);
end;

constructor TGridScrollBarPanelControlEh.Create(AOwner: TComponent; AKind: TScrollBarKind);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csSetCaption];
  FKind := AKind;

  FScrollBar := TControlScrollBarEh.Create(Self);
  FScrollBar.Parent := Self;
//  FScrollBar.Align := alClient;
  FScrollBar.Kind := FKind;
  FScrollBar.OnScroll := OnScrollEvent;
  {$IFDEF FPC}
  {$ELSE}
  FScrollBar.Ctl3D := False;
  FScrollBar.ParentCtl3D := False;
  ParentBackground := False;
  {$ENDIF}
  FScrollBar.TabStop := False;
  FScrollBar.DoubleBuffered := False;
{$IFDEF EH_LIB_12}
  FScrollBar.ParentDoubleBuffered := False;
{$ENDIF}

  BevelOuter := bvNone;
  BevelInner := bvNone;
  FKeepMaxSizeInDefault := True;
end;

procedure TGridScrollBarPanelControlEh.CreateHandle;
begin
  inherited CreateHandle;
end;

destructor TGridScrollBarPanelControlEh.Destroy;
begin
  inherited Destroy;
end;

function TGridScrollBarPanelControlEh.GetOnScroll: TScrollEvent;
begin
  Result := FScrollBar.OnScroll;
end;

procedure TGridScrollBarPanelControlEh.Invalidate;
var
  i: Integer;
begin
  inherited Invalidate;
  for i := 0 to ControlCount-1 do
    Controls[i].Invalidate;
end;

function TGridScrollBarPanelControlEh.MaxSizeForExtraPanel: Integer;
begin
  Result := Width - GetSystemMetrics(SM_CYHSCROLL) * 2;
end;

procedure TGridScrollBarPanelControlEh.OnScrollEvent(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
var
  Grid: TCustomGridCrack;
begin
  Grid := TCustomGridCrack(Owner);
  if (FKind = sbHorizontal) and UseRightToLeftAlignment then
  begin
    ScrollPos := ScrollBar.Max - ScrollPos;
    Grid.ScrollBarMessage(ScrollBatCode, Cardinal(ScrollCode), ScrollPos, True);
  end else
    Grid.ScrollBarMessage(ScrollBatCode, Cardinal(ScrollCode), ScrollPos, True);
  ScrollPos := FScrollBar.Position;
end;

function TGridScrollBarPanelControlEh.ScrollBatCode: Integer;
begin
  if FKind = sbHorizontal
    then Result := SB_HORZ
    else Result := SB_VERT;
end;

procedure TGridScrollBarPanelControlEh.SetKeepMaxSizeInDefault(
  const Value: Boolean);
begin
  if FKeepMaxSizeInDefault <> Value then
  begin
    FKeepMaxSizeInDefault := Value;
    Realign;
  end;
end;

procedure TGridScrollBarPanelControlEh.SetOnScroll(const Value: TScrollEvent);
begin
  FScrollBar.OnScroll := Value;
end;

procedure TGridScrollBarPanelControlEh.SetParams(APosition, AMin, AMax, APageSize: Integer);
begin
  FScrollBar.Enabled := True;
  if FScrollBar.PageSize > AMax then
    FScrollBar.PageSize := 0;
  if AMin > AMax then
    AMax := AMin;
  FScrollBar.SetParams(APosition, AMin, AMax);
  FScrollBar.PageSize := APageSize;
  if (AMax <= AMin) or (AMax - AMin < APageSize) then
    FScrollBar.Enabled := False;
end;

procedure TGridScrollBarPanelControlEh.AlignControls(AControl: TControl;
  var Rect: TRect);
begin
  inherited AlignControls(AControl, Rect);
end;

procedure TGridScrollBarPanelControlEh.Resize;
var
  NewWidth, NewHeight: Integer;
begin
  inherited Resize;
  if not HandleAllocated then Exit;
  if FKind = sbHorizontal then
  begin
    NewWidth := Width;
    NewHeight := TCustomGridCrack(Owner).HorzScrollBar.ActualScrollBarBoxSize;
  end else
  begin
    NewWidth := TCustomGridCrack(Owner).VertScrollBar.ActualScrollBarBoxSize;
    NewHeight := Height;
  end;
  FScrollBar.SetBounds(Width - NewWidth, Height - NewHeight, NewWidth, NewHeight);
end;

procedure TGridScrollBarPanelControlEh.AdjustSize;
begin
  {$IFDEF FPC}
  //
  {$ELSE}
  inherited AdjustSize;
  {$ENDIF}
end;

{ TSizeGripPanelEh }

const
  PositionArr: array[TSizeGripPosition] of TCursor = (crSizeNWSE, crSizeNESW, crSizeNWSE, crSizeNESW);

function TSizeGripPanelEh.CheckInCorner: Boolean;
var
  Point1, Point2: TPoint;
  NextParent: TWinControl;
begin
  Result := False;
  if UseRightToLeftAlignment
    then Point1 := ClientToScreen(Point(0, Height))
    else Point1 := ClientToScreen(Point(Width, Height));
  NextParent := GetForm;
  if NextParent <> nil then
  begin
    if (GetWindowLong(NextParent.Handle, GWL_STYLE) and WS_THICKFRAME) <> 0 then
    begin
      if UseRightToLeftAlignment then
        Point2 := NextParent.ClientToScreen(Point(0, NextParent.ClientHeight))
      else
        Point2 := NextParent.ClientToScreen(Point(NextParent.ClientWidth, NextParent.ClientHeight));
      if (Abs(Point2.X - Point1.X) < 4) and (Abs(Point2.Y - Point1.Y) < 4) then
        Result := True;
    end;
  end;
end;

function TSizeGripPanelEh.CheckGripActive: Boolean;
begin
  if GripActiveStatus = gasNeverEh then
    Result := False
  else if GripActiveStatus = gasAutoEh then
    Result := CheckInCorner
  else
    Result := True;
end;

procedure TSizeGripPanelEh.CreateWnd;
begin
  inherited CreateWnd;
  UpdateWindowRegion;
  Invalidate;
end;

procedure TSizeGripPanelEh.Resize;
begin
  inherited Resize;
  if CheckGripActive
    then Cursor := PositionArr[Position]
    else Cursor := crDefault;
end;

function TSizeGripPanelEh.GetForm: TWinControl;
begin
  Result := Parent;
  while Result <> nil do
  begin
    if GetParent(Result.Handle) = GetDesktopWindow then
      Break
    else if (GetWindowLong(Result.Handle, GWL_STYLE) and WS_CHILD) = 0 then
      Break;
    Result := Result.Parent;
  end;
end;

function TSizeGripPanelEh.GetFormSize: TPoint;
var
  NextParent: TWinControl;
begin
  Result := Point(-1, -1);
  NextParent := GetForm;
  if NextParent <> nil then
    Result := NextParent.ClientToScreen(Point(NextParent.Width, NextParent.Height));
end;

procedure TSizeGripPanelEh.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  NextParent: TWinControl;
begin
  inherited MouseDown(Button, Shift, X, Y);
  if MouseCapture and CheckGripActive then
  begin
    NextParent := GetForm;
    FInitFormSize := Point(NextParent.Width, NextParent.Height);
    FInitFormPos := Point(NextParent.Left, NextParent.Top);
    FMouseMousePos := ClientToScreen(Point(X,Y));
  end;
end;

procedure TSizeGripPanelEh.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  NewMousePos: TPoint;
  NextParent: TWinControl;
  NewLeft, NewTop, NewWidth, NewHeight: Integer;
begin
  inherited MouseMove(Shift, X, Y);
  if MouseCapture and not ((FMouseMousePos.X = -1) and (FMouseMousePos.X = -1)) then
  begin
    NewMousePos := ClientToScreen(Point(X,Y));
    if (NewMousePos.X <> FMouseMousePos.X) or (NewMousePos.Y <> FMouseMousePos.Y) then
    begin
      NextParent := GetForm;
(*      if UseRightToLeftAlignment then
      begin
        NewLeft := NextParent.Left + (NewMousePos.X - FMouseMousePos.X);
        NewWidth := NextParent.Width - (NewMousePos.X - FMouseMousePos.X);
      end else
      begin
        NewLeft := NextParent.Left;
        NewWidth := FInitFormSize.X + (NewMousePos.X - FMouseMousePos.X);
      end;*)
      if Position = sgpTopLeft then
      begin
        NewWidth := FInitFormSize.X - (NewMousePos.X - FMouseMousePos.X);
        NewHeight := FInitFormSize.Y - (NewMousePos.Y - FMouseMousePos.Y);
//        TWinControlCrack(NextParent).CanResize(NewWidth, NewHeight);
        NewLeft := FInitFormPos.X + FInitFormSize.X - NewWidth;
        NewTop := FInitFormPos.Y + FInitFormSize.Y - NewHeight;
      end else if Position = sgpTopRight then
      begin
        NewWidth := FInitFormSize.X + (NewMousePos.X - FMouseMousePos.X);
        NewHeight := FInitFormSize.Y - (NewMousePos.Y - FMouseMousePos.Y);
//        TWinControlCrack(NextParent).CanResize(NewWidth, NewHeight);
        NewLeft := FInitFormPos.X;
        NewTop := FInitFormPos.Y + FInitFormSize.Y - NewHeight;
      end else if Position = sgpBottomRight then
      begin
        NewWidth := FInitFormSize.X + (NewMousePos.X - FMouseMousePos.X);
        NewHeight := FInitFormSize.Y + (NewMousePos.Y - FMouseMousePos.Y);
//        TWinControlCrack(NextParent).CanResize(NewWidth, NewHeight);
        NewLeft := FInitFormPos.X;
        NewTop := FInitFormPos.Y;
      end else
      begin //sgpBottomLeft
        NewWidth := FInitFormSize.X - (NewMousePos.X - FMouseMousePos.X);
        NewHeight := FInitFormSize.Y + (NewMousePos.Y - FMouseMousePos.Y);
//        TWinControlCrack(NextParent).CanResize(NewWidth, NewHeight);
        NewLeft := FInitFormPos.X + FInitFormSize.X - NewWidth;
        NewTop := FInitFormPos.Y;
      end;

      NextParent.SetBounds(
        NewLeft,
        NewTop,
        NewWidth,
        NewHeight
      );
//      FInitFormSize := NewFormSize;
      NextParent.Repaint;
    end;
  end;
end;

procedure TSizeGripPanelEh.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
  FMouseMousePos := Point(-1, -1);
end;

procedure TSizeGripPanelEh.Paint;
{$IFDEF FPC}
const
  DFCS_SCROLLSIZEGRIPRIGHT = $0010;
{$ENDIF}
{$IFDEF EH_LIB_16}
const  PositionElementDetailsArr: array[TSizeGripPosition] of TThemedScrollBar =
  (tsSizeBoxTopLeftAlign, tsSizeBoxTopRightAlign, tsSizeBoxRightAlign, tsSizeBoxLeftAlign);
{$ENDIF}
var
  DrawFlags: Integer;
//  tsb: TThemedScrollBar;
{$IFDEF EH_LIB_16}
  Details: TThemedElementDetails;
//  Detail: TThemedScrollBar;
{$ENDIF}
  BM: TBitmap;

  procedure UpendDraw;
  var
    Org: TPoint;
    Ext: TPoint;
  begin
    Org := Point(0, ClientHeight);
    Ext := Point(1,-1);
    SetMapMode(Canvas.Handle, mm_Anisotropic);
    SetWindowOrgEx(Canvas.Handle, Org.X, Org.Y, nil);
    SetViewportExtEx(Canvas.Handle, ClientWidth, ClientHeight, nil);
    SetWindowExtEx(Canvas.Handle, Ext.X*ClientWidth, Ext.Y*ClientHeight, nil);
  end;

  procedure RestoreDraw;
  var
    Org: TPoint;
    Ext: TPoint;
  begin
    Org := Point(0,0);
    Ext := Point(1,1);
    SetMapMode(Canvas.Handle, mm_Anisotropic);
    SetWindowOrgEx(Canvas.Handle, Org.X, Org.Y, nil);
    SetViewportExtEx(Canvas.Handle, ClientWidth, ClientHeight, nil);
    SetWindowExtEx(Canvas.Handle, Ext.X*ClientWidth, Ext.Y*ClientHeight, nil);
  end;

begin
  if CheckGripActive then
  begin
{$IFDEF EH_LIB_16}
    Canvas.Brush.Color := StyleServices.GetSystemColor(clBtnFace);
    Canvas.FillRect(GetClientRect);
    if ThemeServices.ThemesEnabled then
    begin
      Details := ThemeServices.GetElementDetails(PositionElementDetailsArr[Position]);
{      if UseRightToLeftAlignment
        then Detail := tsSizeBoxLeftAlign
        else Detail := tsSizeBoxRightAlign;}
      ThemeServices.DrawElement(Canvas.Handle, Details, Rect(0,0, Width, Height));
    end else
{$ENDIF}
    begin
      if Position in [sgpTopLeft, sgpBottomLeft]
        then DrawFlags := DFCS_SCROLLSIZEGRIPRIGHT
        else DrawFlags := DFCS_SCROLLSIZEGRIP;
      if Position in [sgpTopLeft, sgpTopRight] then
      begin
        UpendDraw;

        BM := TBitmap.Create;
        BM.Width := ClientWidth;
        BM.Height := ClientHeight;
        BM.Canvas.Brush.Color := Color;
        BM.Canvas.FillRect(BM.Canvas.ClipRect);

        DrawFrameControl(BM.Canvas.Handle, Rect(0,0, Width, Height), DFC_SCROLL, DrawFlags);
        Canvas.Draw(0,0, BM);
        BM.Free;
        RestoreDraw;
       end else
         DrawFrameControl(Canvas.Handle, Rect(0,0, Width, Height), DFC_SCROLL, DrawFlags);
    end
  end;
end;

procedure TSizeGripPanelEh.SetTriangleWindow(const Value: Boolean);
begin
  if FTriangleWindow = Value then Exit;
  FTriangleWindow := Value;
  UpdateWindowRegion;
end;

procedure TSizeGripPanelEh.UpdateWindowRegion;
//type
//  PPoints = ^TPoints;
//  TPoints = array[0..0] of TPoint;
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
//    UpdatePosition;
  end else
  begin
    SetWindowRgn(Handle, 0, True);
//    UpdatePosition;
  end;
  if CheckGripActive
    then Cursor := PositionArr[Position]
    else Cursor := crDefault;
end;

procedure TSizeGripPanelEh.WMNCHitTest(var Message: TWMNCHitTest);
begin
//  Message.Result := HTSIZE;
//  Message.Result := HTBOTTOMRIGHT;
  inherited;
end;

{
procedure TSizeGripPanelEh.WMSetCursor(var Message: TWMSetCursor);
begin
  if CheckGripActive then
    if UseRightToLeftAlignment
      then Windows.SetCursor(Screen.Cursors[crSizeNESW])
      else Windows.SetCursor(Screen.Cursors[crSizeNWSE]);
end;
}

procedure TSizeGripPanelEh.SetPosition(const Value: TSizeGripPosition);
begin
  if FPosition <> Value then
  begin
    FPosition := Value;
    UpdateWindowRegion;
  end;
end;

constructor TSizeGripPanelEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Position := sgpBottomRight;
end;

{ TControlScrollBarEh }

procedure TControlScrollBarEh.CMDesignHitTest(var Msg: TCMDesignHitTest);
begin
  Msg.Result := 1;
end;

procedure TControlScrollBarEh.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
end;

procedure TControlScrollBarEh.WMLButtonDown(var Message: TWMLButtonDown);
begin
  if TGridScrollBarPanelControlEh(Parent).ChildControlCanMouseDown(Self) then
    inherited;
end;

procedure TControlScrollBarEh.WMRButtonDown(var Message: TWMRButtonDown);
begin
  if TGridScrollBarPanelControlEh(Parent).ChildControlCanMouseDown(Self) then
    inherited;
end;

procedure TControlScrollBarEh.WMMButtonDown(var Message: TWMMButtonDown);
begin
  if TGridScrollBarPanelControlEh(Parent).ChildControlCanMouseDown(Self) then
    inherited;
end;

procedure TControlScrollBarEh.WMMouseActivate(var Message: TMessage);
begin
  Message.Result := MA_NOACTIVATE;
end;

{ TGridDragWinEh }

constructor TGridDragWinEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Color := cl3DDkShadow;
  FAlphaBlendValue := 200;
  BorderWidth := 0;
  inherited Visible := False;
end;

procedure TGridDragWinEh.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := WS_POPUP {or WS_BORDER};
    WindowClass.Style := WindowClass.Style or CS_SAVEBITS;
    if NewStyleControls then
      ExStyle := WS_EX_TOOLWINDOW;
    // CS_DROPSHADOW requires Windows XP or above
//    if {FShadow and} CheckWin32Version(5, 1) then
//      WindowClass.Style := WindowClass.style or CS_DROPSHADOW;
//    if NewStyleControls then ExStyle := WS_EX_TOOLWINDOW;

{$IFDEF FPC}
{$ELSE}
    AddBiDiModeExStyle(ExStyle);
{$ENDIF}

{$IFNDEF CIL}
    if Assigned(SetLayeredWindowAttributes) then
{$ENDIF}
      Params.ExStyle := Params.ExStyle or WS_EX_LAYERED;
  end;
end;

procedure TGridDragWinEh.CreateWnd;
begin
  inherited CreateWnd;
  SetLayeredAttribs;
end;

procedure TGridDragWinEh.SetLayeredAttribs;
const
  cUseAlpha: array [Boolean] of Integer = (0, LWA_ALPHA);
  cUseColorKey: array [Boolean] of Integer = (0, LWA_COLORKEY);
var
  AStyle: Integer;
begin
  if not (csDesigning in ComponentState) and
{$IFNDEF VER140} //not Delphi6
{$IFNDEF CIL}
    (Assigned(SetLayeredWindowAttributes)) and
{$ENDIF}
{$ENDIF}
    HandleAllocated then
  begin
    AStyle := GetWindowLong(Handle, GWL_EXSTYLE);
    if (FAlphaBlendValue <> 255) or (FTransparentColorValue <> 0) then
    begin
      if (AStyle and WS_EX_LAYERED) = 0 then
        SetWindowLong(Handle, GWL_EXSTYLE, AStyle or WS_EX_LAYERED);
      SetLayeredWindowAttributes(Handle, FTransparentColorValue, FAlphaBlendValue,
        cUseAlpha[FAlphaBlendValue <> 255] or cUseColorKey[FTransparentColorValue <> 0]);
    end
    else
    begin
      SetWindowLong(Handle, GWL_EXSTYLE, AStyle and not WS_EX_LAYERED);
      RedrawWindow(Handle, nil, 0, RDW_ERASE or RDW_INVALIDATE or RDW_FRAME or RDW_ALLCHILDREN);
    end;
  end;
end;

procedure TGridDragWinEh.MoveToFor(Control: TControl; NewPos: TPoint);
var
  AbsPos: TPoint;
begin
  AbsPos := Control.ClientToScreen(NewPos);
  SetBounds(AbsPos.X, AbsPos.Y, Width, Height);
end;

procedure TGridDragWinEh.MoveToFor(Control: TControl; NewPos: TPoint; NewWidth, NewHeight: Integer);
var
  AbsPos: TPoint;
begin
  AbsPos := Control.ClientToScreen(NewPos);
  SetBounds(AbsPos.X, AbsPos.Y, NewWidth, NewHeight);
end;

procedure TGridDragWinEh.StartShow(Control: TControl; Pos: TPoint; Width, Height: Integer);
var
  AbsPos: TPoint;
begin
  AbsPos := Control.ClientToScreen(Pos);
  SetBounds(AbsPos.X, AbsPos.Y, Width, Height);
  inherited Visible := True;
  SetWindowPos(Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE or
    SWP_NOSIZE or SWP_NOACTIVATE);
end;

procedure TGridDragWinEh.StartShow(Control: TControl; Pos: TPoint; Height: Integer);
begin
  StartShow(Control, Pos, Width, Height);
end;

function TGridDragWinEh.Visible: Boolean;
begin
  Result := inherited Visible;
end;

procedure TGridDragWinEh.Show;
begin
//  if
end;

procedure TGridDragWinEh.TemporaryHide;
begin
  SetBounds(Left, Top, 0, 0);
end;

{ TGridDragBoxEh }

constructor TGridDragBoxEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
//  Color := clWhite;
end;

procedure TGridDragBoxEh.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
//  if CheckWin32Version(5, 1) then
//    Params.WindowClass.Style := Params.WindowClass.style or CS_DROPSHADOW;
end;

{ TGridMoveLineEh }

constructor TGridMoveLineEh.Create(AOwner: TComponent);
var
  LineColor: TColor;
begin
  inherited Create(AOwner);
  Color := clWhite;
  Width := 7;
  Height := 7;
  FAlphaBlendValue := 255;
  FTransparentColorValue := clWhite;
  LineColor := clRed;
  FIsVert := True;
//  Visible := False;

// Vertical
  sLine := TShape.Create(Self);
  sLow3 := TShape.Create(Self);
  sLow5 := TShape.Create(Self);
  sLow7 := TShape.Create(Self);
  sHigh3 := TShape.Create(Self);
  sHigh5 := TShape.Create(Self);
  sHigh7 := TShape.Create(Self);

  with sHigh7 do
  begin
    Name := 'sHigh7';
    Parent := Self;
    SetBounds(0,0,7,1);
    Pen.Color := LineColor
  end;
  with sHigh5 do
  begin
    Name := 'sHigh5';
    Parent := Self;
    SetBounds(1,1,5,1);
    Pen.Color := LineColor
  end;
  with sHigh3 do
  begin
    Name := 'sHigh3';
    Parent := Self;
    SetBounds(2,2,3,1);
    Pen.Color := LineColor
  end;
  with sLine do
  begin
    Name := 'sLine';
    Parent := Self;
    SetBounds(3,3,1,1);
    Anchors := [akLeft, akTop, akBottom];
    Pen.Color := LineColor
  end;
  with sLow3 do
  begin
    Name := 'sLow3';
    Parent := Self;
    SetBounds(2,4,3,1);
    Anchors := [akLeft, akBottom];
    Pen.Color := LineColor;
  end;
  with sLow5 do
  begin
    Name := 'sLow5';
    Parent := Self;
    SetBounds(1,5,5,1);
    Anchors := [akLeft, akBottom];
    Pen.Color := LineColor;
  end;
  with sLow7 do
  begin
    Name := 'sLow7';
    Parent := Self;
    SetBounds(0,6,7,1);
    Anchors := [akLeft, akBottom];
    Pen.Color := LineColor;
  end;

// Horizontal
  hLeft7 := TShape.Create(Self);
  hLeft5 := TShape.Create(Self);
  hLeft3 := TShape.Create(Self);
  hLine := TShape.Create(Self);
  hRight3 := TShape.Create(Self);
  hRight5 := TShape.Create(Self);
  hRight7 := TShape.Create(Self);

  with hLeft7 do
  begin
    Name := 'hLeft7';
    Parent := Self;
    SetBounds(0,0,1,7);
    Pen.Color := LineColor
  end;
  with hLeft5 do
  begin
    Name := 'hLeft5';
    Parent := Self;
    SetBounds(1,1,1,5);
    Pen.Color := LineColor
  end;
  with hLeft3 do
  begin
    Name := 'hLeft3';
    Parent := Self;
    SetBounds(2,2,1,3);
    Pen.Color := LineColor
  end;
  with hLine do
  begin
    Name := 'hLine';
    Parent := Self;
    SetBounds(3,3,1,1);
    Anchors := [akLeft, akTop, akRight];
    Pen.Color := LineColor
  end;
  with hRight3 do
  begin
    Name := 'hRight3';
    Parent := Self;
    SetBounds(4,2,1,3);
    Anchors := [akTop, akRight];
    Pen.Color := LineColor;
  end;
  with hRight5 do
  begin
    Name := 'hRight5';
    Parent := Self;
    SetBounds(5,1,1,5);
    Anchors := [akTop, akRight];
    Pen.Color := LineColor;
  end;
  with hRight7 do
  begin
    Name := 'hRight7';
    Parent := Self;
    SetBounds(6,0,1,7);
    Anchors := [akTop, akRight];
    Pen.Color := LineColor;
  end;

end;

procedure TGridMoveLineEh.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
//  if CheckWin32Version(5, 1) then
//    Params.WindowClass.Style := Params.WindowClass.style or CS_DROPSHADOW;
end;

procedure TGridMoveLineEh.StartShow(Control: TControl; Pos: TPoint; AIsVert: Boolean; Size: Integer; ACaptureControl: TObject);
begin
  FIsVert := AIsVert;
  UpdateOrientationData;
  Pos.X := Pos.X - 3;
  Pos.Y := Pos.Y - 4;
  Size := Size + 8;
  if IsVert
    then inherited StartShow(Control, Pos, 7, Size)
    else inherited StartShow(Control, Pos, Size, 7)
end;

procedure TGridMoveLineEh.MoveToFor(Control: TControl; NewPos: TPoint);
begin
  NewPos.X := NewPos.X - 3;
  NewPos.Y := NewPos.Y - 4;
  inherited MoveToFor(Control, NewPos);
end;

procedure TGridMoveLineEh.UpdateOrientationData;
var
  VertVisible, HorzVisible: Boolean;
begin
  if FIsVert then
  begin
    VertVisible := True;
    HorzVisible := False;
  end else
  begin
    VertVisible := False;
    HorzVisible := True;
  end;

  sHigh7.Visible := VertVisible;
  sHigh5.Visible := VertVisible;
  sHigh3.Visible := VertVisible;
  sLine.Visible := VertVisible;
  sLow3.Visible := VertVisible;
  sLow5.Visible := VertVisible;
  sLow7.Visible := VertVisible;

  hLeft7.Visible := HorzVisible;
  hLeft5.Visible := HorzVisible;
  hLeft3.Visible := HorzVisible;
  hLine.Visible := HorzVisible;
  hRight3.Visible := HorzVisible;
  hRight5.Visible := HorzVisible;
  hRight7.Visible := HorzVisible;

end;

var
  FDragBox: TGridDragWinEh;
  FMoveLine: TGridMoveLineEh;

function GetDragBoxEh: TGridDragWinEh;
begin
  if FDragBox = nil then
  begin
    FDragBox := TGridDragBoxEh.Create(Application);
    {$IFDEF FPC}
    FDragBox.ParentWindow := Win32WidgetSet.AppHandle;
    {$ELSE}
    FDragBox.ParentWindow := Application.Handle;
    {$ENDIF}
  end;
  Result := FDragBox;
end;

function GetMoveLineEh: TGridMoveLineEh;
begin
  if FMoveLine = nil then
  begin
    FMoveLine := TGridMoveLineEh.Create(Application);
    {$IFDEF FPC}
    FMoveLine.ParentWindow := GetDesktopWindow;
    {$ELSE}
    FMoveLine.ParentWindow := Application.Handle;
    {$ENDIF}
  end;
  Result := FMoveLine;
end;

end.
