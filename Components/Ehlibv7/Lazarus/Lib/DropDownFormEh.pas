{*******************************************************}
{                                                       }
{                       EhLib v7.0                      }
{                   DropingDown Forms                   }
{                      Build 7.0.07                     }
{                                                       }
{        Copyright (c) 2013 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

unit DropDownFormEh;

{$I EhLib.Inc}

interface

uses
  Windows, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  {$IFDEF FPC}
    EhLibLCL, LCLType,
  {$ELSE}
    EhLibVCL, Messages,
  {$ENDIF}
  {$IFDEF EH_LIB_6} Types, {$ENDIF}
{$IFDEF EH_LIB_7} Themes, UxTheme, {$ENDIF}
{$IFDEF EH_LIB_17} System.UITypes, {$ENDIF}
  Dialogs, ToolCtrlsEh, DynVarsEh, DBCtrls, Buttons, ExtCtrls;

type
  TCustomDropDownFormEh = class;
  TDDFCloseButtonEh = class;
  TDDFSizingBarEh = class;

  TDropLayoutEh = (dlAboveControlEh, dlUnderControlEh);
  TDropDownFormElementEh = (ddfeLeftGripEh, ddfeRightGripEh, ddfeCloseButtonEh, ddfeSizingBarEh);
  TDropDownFormElementsEh = set of TDropDownFormElementEh;

  TInitDropDownFormEventEh = procedure(Sender: TCustomDropDownFormEh; DynParams: TDynVarsEh) of object;
  TPutBackFormParamsEventEh = procedure(Sender: TCustomDropDownFormEh; DynParams: TDynVarsEh) of object;

//  TAssignGlobalDropDownFormEventEh = procedure(Sender: TCustomForm; var GlobalDropDownForm: TCustomForm) of object;

//  TCustomDropDownFormEh = class(TCustomForm, IDropDownFormEh)
  TCustomDropDownFormEh = class(TForm, IDropDownFormEh, IDynParamsInteractableEh)
  private
    FSizeGrip: TSizeGripEh;
    FSizeGrip2: TSizeGripEh;
    FOnReturnParams: TPutBackFormParamsEventEh;
    FOnInitForm: TInitDropDownFormEventEh;
    FBorderWidth: Integer;
    FCallbackProc: TDropDownFormCallbackProcEh;
    FKeepFormVisible: Boolean;
    FFormElements: TDropDownFormElementsEh;
    FReadOnly: Boolean;
    FDropDownMode: Boolean;
//    FOnAssignGlobalDropDownForm: TAssignGlobalDropDownFormEventEh;

    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCPaint(var Message: TWMNCPaint); message WM_NCPAINT;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message WM_WINDOWPOSCHANGED;
    procedure WMActivate(var msg: TWMActivate); message WM_ACTIVATE;
    function GetReadOnly: Boolean;
    procedure SetReadOnly(const Value: Boolean);
    function GetBorderStyle: TFormBorderStyle;
    procedure SetDropDownMode(const Value: Boolean);

  protected
    FDropLayout: TDropLayoutEh;
    FDynParams: TDynVarsEh;
    FSysParams: TDropDownFormSysParams;
    FModalMode: Boolean;
    FActivateClosing: Boolean;
    FCloseButton: TDDFCloseButtonEh;
    FSizingBar: TDDFSizingBarEh;
    FMasterForm: TCustomForm;
{$IFDEF EH_LIB_14}
    procedure GetBorderStyles(var Style, ExStyle, ClassStyle: Cardinal); override;
{$ENDIF}
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure CreateHandle; override;
    procedure DrawBorder; virtual;
    procedure Loaded; override;
    procedure DoHide; override;
    procedure DoClose(var Action: TCloseAction); override;
//    procedure AssignGlobalDropDownForm(Sender: TCustomForm; var GlobalDropDownForm: TCustomForm);
    procedure InitializeNewForm; {$IFDEF EH_LIB_12} override; {$ENDIF}
    function DoHandleStyleMessage(var Message: TMessage): Boolean; {$IFDEF EH_LIB_16} override; {$ENDIF}

    procedure SetInDynParams(DynParams: TDynVarsEh); virtual;
    procedure GetOutDynParams(var DynParams: TDynVarsEh); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    constructor CreateNew(AOwner: TComponent; Dummy: Integer = 0); override;
    destructor Destroy; override;
    function Execute(RelativePosControl: TControl; DownStateControl: TControl; Align: TDropDownAlign; DynParams: TDynVarsEh): Boolean; virtual;
    procedure ExecuteNomodal(RelativePosRect: TRect; DownStateControl: TControl; Align: TDropDownAlign; DynParams: TDynVarsEh; SysParams: TDropDownFormSysParams; CallbackProc: TDropDownFormCallbackProcEh);
    procedure InitForm(Host: TComponent; DynParams: TDynVarsEh); virtual;
    procedure InitElements; virtual;
    procedure Show;
    function ShowModal: Integer; override;
    procedure ReturnParams(Host: TComponent; DynParams: TDynVarsEh); virtual;

    class function GetGlobalRef: TCustomDropDownFormEh; virtual;

    property BorderWidth: Integer read FBorderWidth write FBorderWidth;
    property KeepFormVisible: Boolean read FKeepFormVisible write FKeepFormVisible;
    property CallbackProc: TDropDownFormCallbackProcEh read FCallbackProc;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly;

  published
    property FormElements: TDropDownFormElementsEh read FFormElements write FFormElements default [ddfeLeftGripEh, ddfeRightGripEh, ddfeCloseButtonEh, ddfeSizingBarEh];

    property OnInitForm: TInitDropDownFormEventEh read FOnInitForm write FOnInitForm;
    property OnReturnParams: TPutBackFormParamsEventEh read FOnReturnParams write FOnReturnParams;
//    property OnAssignGlobalDropDownForm: TAssignGlobalDropDownFormEventEh read FOnAssignGlobalDropDownForm write FOnAssignGlobalDropDownForm;
// TForm
//    property BorderIcons;
    property BorderStyle: TFormBorderStyle read GetBorderStyle stored False;
    property DropDownMode: Boolean read FDropDownMode write SetDropDownMode;

//    property BorderStyle;
//    property BorderWidth;
//    property UseDockManager;
//    property DefaultMonitor;
//    property DockSite;
//    property DragKind;
//    property DragMode;
//    property Enabled;
//    property FormStyle;
//    property Position;
//    property ScreenSnap default False;
//    property SnapBuffer default 10;
//    property WindowState;
//    property WindowMenu;

//    property OnDockDrop;
//    property OnDockOver;
//    property OnDragDrop;
//    property OnDragOver;
//    property OnEndDock;
//    property OnGetSiteInfo;

//    property OnStartDock;
//    property OnUnDock;
  end;

  TCustomDropDownFormClassEh = class of TCustomDropDownFormEh;

{ TDDFCloseButtonEh }

  TDDFCloseButtonEh = class(TWinControl)
  private
    FButtonControl: TSpeedButtonEh;
    procedure PaintHandler(Sender: TObject);
    procedure ClickHandler(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

{ TDDFSizingBarEh }

  TDDFSizingBarEh = class(TCustomPanel)
  private
    FHostControl: TWinControl;
    FMouseDownPos: TPoint;
    FSizingArea: Integer;
    procedure WMSetCursor(var Msg: TWMSetCursor); message WM_SETCURSOR;
  protected
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure Resize; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property HostControl: TWinControl read FHostControl write FHostControl;
  end;

//var
//  CustomDropDownFormEh: TCustomDropDownFormEh;

var
  OpenDropDownFormProc: procedure(DDFCallParam: TDropDownFormCallParamsEh) = nil;

implementation

//{$R *.dfm}

procedure OpenDropDownForm(DDFCallParam: TDropDownFormCallParamsEh);
begin

end;

procedure RegisterClasses;
begin
  RegisterClass(TCustomDropDownFormEh);
  OpenDropDownFormProc := OpenDropDownForm;
end;

procedure UnregisterClasses;
begin
  UnregisterClass(TCustomDropDownFormEh);
end;

function AdjustDropDownForm(AControl: TControl; HostRect: TRect; Align: TDropDownAlign): TDropLayoutEh;
var
   WorkArea: TRect;
   HostP{, PDelpta}: TPoint;
begin

  Result := dlUnderControlEh;

  SystemParametersInfo(SPI_GETWORKAREA,0,@WorkArea,0);
//  HostP := HostControl.ClientToScreen(Point(0,0));
  HostP := HostRect.TopLeft;

//  PDelpta := AControl.ClientToScreen(Point(0,0));

  AControl.Left := HostP.x;
  AControl.Top := HostP.y + (HostRect.Bottom - HostRect.Top) + 1;

  case Align of
    daRight: AControl.Left := AControl.Left - (AControl.Width - (HostRect.Right - HostRect.Left) );
    daCenter: AControl.Left := AControl.Left - ((AControl.Width - (HostRect.Right - HostRect.Left)) div 2);
  end;

  if (AControl.Width > WorkArea.Right - WorkArea.Left) then
    AControl.Width := WorkArea.Right - WorkArea.Left;

  if (AControl.Left + AControl.Width > WorkArea.Right) then
    AControl.Left := WorkArea.Right - AControl.Width;
  if (AControl.Left < WorkArea.Left) then
    AControl.Left := WorkArea.Left;

  if (AControl.Top + AControl.Height > WorkArea.Bottom) then
  begin
    if (HostP.y - WorkArea.Top > WorkArea.Bottom - HostP.y - (HostRect.Bottom - HostRect.Top)) then
    begin
      Result := dlAboveControlEh;
      AControl.Top := HostP.y - AControl.Height;
    end;
  end;

  if (AControl.Top < WorkArea.Top) then
  begin
    AControl.Height := AControl.Height - (WorkArea.Top - AControl.Top);
    AControl.Top := WorkArea.Top;
  end;
  if (AControl.Top + AControl.Height > WorkArea.Bottom) then
  begin
    AControl.Height := WorkArea.Bottom - AControl.Top;
  end;
end;

{ TCustomDropDownFormEh }

{procedure TCustomDropDownFormEh.AssignGlobalDropDownForm(Sender: TCustomForm;
  var GlobalDropDownForm: TCustomForm);
begin
  if Assigned(OnAssignGlobalDropDownForm) then
    OnAssignGlobalDropDownForm(Sender, GlobalDropDownForm);
end;
}

constructor TCustomDropDownFormEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDropDownMode := True;
end;

constructor TCustomDropDownFormEh.CreateNew(AOwner: TComponent; Dummy: Integer = 0);
begin
  inherited CreateNew(AOwner);
{$IFNDEF EH_LIB_12}
  InitializeNewForm;
{$ENDIF}
end;

destructor TCustomDropDownFormEh.Destroy;
begin
  FreeAndNil(FCloseButton);
  FreeAndNil(FSizingBar);
  FreeAndNil(FSizeGrip);
  FreeAndNil(FSizeGrip2);
  inherited Destroy;
end;

procedure TCustomDropDownFormEh.InitializeNewForm;
begin
{$IFDEF EH_LIB_12}
  inherited InitializeNewForm;
{$ENDIF}

  FCloseButton := TDDFCloseButtonEh.Create(nil);
  FCloseButton.Parent := Self;
  FCloseButton.Visible := False;

  FSizingBar := TDDFSizingBarEh.Create(nil);
  FSizingBar.Parent := Self;
  FSizingBar.Visible := False;
  FSizingBar.HostControl := Self;

  FSizeGrip := TSizeGripEh.Create(nil);
  with FSizeGrip do
  begin
//    Parent := Self;
    HostControl := Self;
//    ParentWindow := Self.Handle;
    TriangleWindow := True;
    Visible := False;
  end;
  FSizeGrip2 := TSizeGripEh.Create(nil);
  with FSizeGrip2 do
  begin
//    Parent := Self;
    HostControl := Self;
//    ParentWindow := Self.Handle;
    TriangleWindow := True;
    Position := sgpBottomLeft;
    Visible := False;
  end;

  //  FCloseButton.Width := 5;
//  FCloseButton.Height := 5;
  FCloseButton.Anchors := [akTop, akRight];
  FFormElements := [ddfeLeftGripEh, ddfeRightGripEh, ddfeCloseButtonEh, ddfeSizingBarEh];
  BorderIcons := [];
  inherited BorderStyle := bsNone;
  FDropDownMode := True;
//  BorderStyle := bsNone;
//  FormStyle := fsStayOnTop;
{$IFDEF FPC}
  inherited BorderStyle := bsSingle;
  BorderIcons := [];
{$ENDIF}
end;

function TCustomDropDownFormEh.Execute(RelativePosControl: TControl;
  DownStateControl: TControl; Align: TDropDownAlign; DynParams: TDynVarsEh): Boolean;
begin
  FModalMode := True;
  FDynParams := DynParams;

  if Visible then
    Visible := False;

  FDropLayout := AdjustDropDownForm(Self, ClientToScreenRect(RelativePosControl), Align);
  if Self.ClientToScreen(Point(0,0)).Y < RelativePosControl.ClientToScreen(Point(0,0)).Y then
  begin
    FSizeGrip.Position := sgpTopRight;
    FSizeGrip2.Position := sgpTopLeft;
  end else
  begin
    FSizeGrip.Position := sgpBottomRight;
    FSizeGrip2.Position := sgpBottomLeft;
  end;

  InitForm(nil, DynParams);

  ModalResult := mrNone;
  Visible := True;

  while Active and (ModalResult = mrNone) do
    Application.HandleMessage;

  Visible := False;
  Result := False;
  if ModalResult = mrOk then
  begin
    Result := True;
    ReturnParams(nil, DynParams);
  end;
end;

procedure TCustomDropDownFormEh.ExecuteNomodal(RelativePosRect: TRect;
  DownStateControl: TControl; Align: TDropDownAlign; DynParams: TDynVarsEh;
  SysParams: TDropDownFormSysParams; CallbackProc: TDropDownFormCallbackProcEh);
begin
  {$IFDEF FPC}
  {$ELSE}
  inherited BorderStyle := bsNone;
  {$ENDIF}
  DropDownMode := True;
  FModalMode := False;
  FDynParams := DynParams;
  FSysParams := SysParams;
  FMasterForm := Screen.ActiveCustomForm;

  if Visible then
    Visible := False;

  FDropLayout := AdjustDropDownForm(Self, RelativePosRect, Align);
  if Self.ClientToScreen(Point(0,0)).Y < RelativePosRect.Top then
  begin
    FSizeGrip.Position := sgpTopRight;
    FSizeGrip2.Position := sgpTopLeft;
  end else
  begin
    FSizeGrip.Position := sgpBottomRight;
    FSizeGrip2.Position := sgpBottomLeft;
  end;

  InitElements;

//  ReadOnly := FSysParams.HostIsReadOnly;

  InitForm(nil, DynParams);

  ModalResult := mrNone;
  Visible := True;

  FCallbackProc := CallbackProc;
end;

{$IFDEF EH_LIB_14}
procedure TCustomDropDownFormEh.GetBorderStyles(var Style, ExStyle,
  ClassStyle: Cardinal);
begin
  inherited GetBorderStyles(Style, ExStyle, ClassStyle);
//  Style := Style or WS_BORDER;
end;
{$ENDIF}

procedure TCustomDropDownFormEh.CreateParams(var Params: TCreateParams);
//const
//  BorderStyles: array[TBorderStyle] of DWORD = (0, WS_BORDER);
begin
  inherited CreateParams(Params);
  with Params do
  begin
//    Style := Style or BorderStyles[BorderStyle];
    {$IFDEF FPC}
//    Style := Style or WS_BORDER;
    {$ENDIF}
    if CheckWin32Version(5, 1) then
      WindowClass.Style := WindowClass.style or CS_DROPSHADOW;
  end;
end;

procedure TCustomDropDownFormEh.CreateWnd;
begin
  if CheckWin32Version(6, 0)
    then FBorderWidth := 3
    else FBorderWidth := 2;
  inherited CreateWnd;
end;

procedure TCustomDropDownFormEh.CreateHandle;
begin
  inherited CreateHandle;
  if not (csDesigning in ComponentState) then
  begin
    FSizeGrip.UpdatePosition;
    FSizeGrip.Visible := True;
    FSizeGrip.BringToFront;
    FSizeGrip2.UpdatePosition;
    FSizeGrip2.Visible := True;
    FSizeGrip2.BringToFront;
  end;
end;

function TCustomDropDownFormEh.DoHandleStyleMessage(
  var Message: TMessage): Boolean;
begin
  if Message.Msg = WM_NCPAINT
    then Result := False
{$IFDEF EH_LIB_16}
    else Result := inherited DoHandleStyleMessage(Message);
{$ELSE}
    else Result := True;
{$ENDIF}
end;

procedure TCustomDropDownFormEh.DoHide;
begin
  inherited DoHide;
end;

procedure TCustomDropDownFormEh.DoClose(var Action: TCloseAction);
var
  ACallbackProc: TDropDownFormCallbackProcEh;
begin
  if not (csDesigning in ComponentState) then
  begin
    if (FSysParams <> nil) and FSysParams.FreeFormOnClose then
      Action := caFree;
    if not FModalMode and Assigned(CallbackProc) then
    begin
      if ModalResult = mrOk then
        ReturnParams(nil, FDynParams);
      ACallbackProc := CallbackProc;
      FCallbackProc := nil;
      ACallbackProc(Self, ModalResult = mrOk, FDynParams, FSysParams);
      FSysParams := nil;
      FDynParams := nil;
      FCallbackProc := nil;
    end;
  end;
  inherited DoClose(Action);
  if (FMasterForm <> nil) and not FActivateClosing then
    FMasterForm.SetFocus;
  FMasterForm := nil;
end;

procedure TCustomDropDownFormEh.DrawBorder;
var
  DC: HDC;
  R, RTop: TRect;
  Details: TThemedElementDetails;
  ABrush: TBrush;
begin
  DC := GetWindowDC(Handle);
  try
    GetWindowRect(Handle, R);
    OffsetRect(R, -R.Left, -R.Top);

    ExcludeClipRect(DC,
      R.Left+FBorderWidth, R.Top+FBorderWidth, R.Right-FBorderWidth, R.Bottom-FBorderWidth);

    if CustomStyleActive or not ThemesEnabled then
    begin
      ABrush := TBrush.Create;
      ABrush.Color := StyleServices.GetSystemColor(cl3DDkShadow);
      {$WARNINGS OFF}
      Windows.FrameRect(DC, R, ABrush.Handle);
      {$WARNINGS ON}
      ABrush.Color := StyleServices.GetSystemColor(cl3DLight);
      InflateRect(R, -1, -1);
      {$WARNINGS OFF}
      Windows.FrameRect(DC, R, ABrush.Handle);
      {$WARNINGS ON}
      InflateRect(R, -1, -1);
      {$WARNINGS OFF}
      Windows.FrameRect(DC, R, ABrush.Handle);
      {$WARNINGS ON}
      ABrush.Free;
    end else
    begin
      RTop := Rect(R.Left, R.Top, R.Right, R.Top + FBorderWidth);
      Details := ThemeServices.GetElementDetails(twSmallCaptionActive);
      ThemeServices.DrawElement(DC, Details, RTop);

      R.Top := R.Top + FBorderWidth;
      Details := ThemeServices.GetElementDetails(twSmallFrameBottomActive);
      ThemeServices.DrawElement(DC, Details, R);
    end;
  finally
    ReleaseDC(Handle, DC);
  end;
end;

procedure TCustomDropDownFormEh.WMSize(var Message: TWMSize);
begin
  inherited;
  if DropDownMode then
    Repaint;
end;

procedure TCustomDropDownFormEh.WMWindowPosChanged(var Message: TWMWindowPosChanged);
begin
  inherited;
  if (FSizeGrip <> nil) and FSizeGrip.Visible then
  begin
    FSizeGrip.UpdatePosition;
    FSizeGrip.BringToFront;
  end;
  if (FSizeGrip2 <> nil) and FSizeGrip2.Visible then
  begin
    FSizeGrip2.UpdatePosition;
    FSizeGrip2.BringToFront;
  end;
end;

procedure TCustomDropDownFormEh.WMActivate(var msg: TWMActivate);
begin
  inherited;
  if DropDownMode and not (csDesigning in ComponentState) then
    if not FModalMode and
           (msg.Active = WA_INACTIVE) and
       not FKeepFormVisible and
       not FActivateClosing then
    begin
      FActivateClosing := True;
      try
        Close;
      finally
        FActivateClosing := False;
      end;
    end;
end;

procedure TCustomDropDownFormEh.WMNCCalcSize(var Message: TWMNCCalcSize);
begin
  inherited;
  if DropDownMode and not (csDesigning in ComponentState) then
    with Message.CalcSize_Params^ do
    begin
      Inc(rgrc[0].Left, FBorderWidth);
      Inc(rgrc[0].Top, FBorderWidth);
      Dec(rgrc[0].Right, FBorderWidth);
      Dec(rgrc[0].Bottom, FBorderWidth);
    end;
end;

procedure TCustomDropDownFormEh.WMNCPaint(var Message: TWMNCPaint);
begin
  inherited;
  if DropDownMode then
    DrawBorder;
end;

procedure TCustomDropDownFormEh.InitForm(Host: TComponent;
  DynParams: TDynVarsEh);
begin
  if Assigned(OnInitForm) then
    OnInitForm(Self, DynParams);
end;

procedure TCustomDropDownFormEh.ReturnParams(Host: TComponent;
  DynParams: TDynVarsEh);
begin
  if Assigned(OnReturnParams) then
    OnReturnParams(Self, DynParams);
end;

function TCustomDropDownFormEh.GetBorderStyle: TFormBorderStyle;
begin
  Result := inherited BorderStyle;
end;

class function TCustomDropDownFormEh.GetGlobalRef: TCustomDropDownFormEh;
begin
  Result := nil;
end;

procedure TCustomDropDownFormEh.Loaded;
begin
  inherited Loaded;
  if not (csDesigning in ComponentState) and (FSizeGrip <> nil) then
  begin
    FSizeGrip.UpdatePosition;
    FSizeGrip.Visible := True;
    FSizeGrip.BringToFront;
  end;

  if not (csDesigning in ComponentState) and (FSizeGrip2 <> nil) then
  begin
    FSizeGrip2.UpdatePosition;
    FSizeGrip2.Visible := True;
    FSizeGrip2.BringToFront;
  end;
end;

procedure TCustomDropDownFormEh.InitElements;
begin

  if ddfeSizingBarEh in FormElements then
  begin
    FSizingBar.Visible := False;
    FSizingBar.BringToFront;
    if FDropLayout = dlUnderControlEh then
    begin
      FSizingBar.Top := Height + 1;
      FSizingBar.Align := alBottom;
      {$IFDEF FPC}
      {$ELSE}
      FSizingBar.BevelEdges := [beTop];
      {$ENDIF}
    end else
    begin
      FSizingBar.Top := -1;
      FSizingBar.Align := alTop;
      {$IFDEF FPC}
      {$ELSE}
      FSizingBar.BevelEdges := [beBottom];
      {$ENDIF}
    end;
    FSizingBar.Height := GetSystemMetrics(SM_CYVSCROLL) + 3;
    FSizingBar.Visible := True;
  end else
    FSizingBar.Visible := False;

  if ddfeCloseButtonEh in FormElements then
  begin
    FCloseButton.BringToFront;
    FCloseButton.Top := 2;
    FCloseButton.Left := ClientWidth - FCloseButton.Width - 3;
    FCloseButton.Visible := True;
    if FDropLayout = dlUnderControlEh then
      if ddfeSizingBarEh in FormElements then
      begin
        if ddfeLeftGripEh in FormElements
          then FCloseButton.Left := 17
          else FCloseButton.Left := 2;
        FCloseButton.Top := ClientHeight - FCloseButton.Height - 1;
        FCloseButton.Anchors := [akBottom, akLeft];
      end else
      begin
        FCloseButton.Left := ClientWidth - FCloseButton.Width - 3;
        FCloseButton.Anchors := [akTop, akRight];
      end
    else
    begin
      FCloseButton.Left := ClientWidth - FCloseButton.Width - 17;
      FCloseButton.Top := 1;
      FCloseButton.Anchors := [akTop, akRight];
    end;
  end else
    FCloseButton.Visible := False;

  FSizeGrip.Visible := ddfeRightGripEh in FormElements;
  FSizeGrip2.Visible := ddfeLeftGripEh in FormElements;
end;

{ TDDFCloseButtonEh }

constructor TDDFCloseButtonEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FButtonControl := TSpeedButtonEh.Create(Self);
  FButtonControl.Parent := Self;
  FButtonControl.Align := alClient;
  FButtonControl.OnPaint := PaintHandler;
  FButtonControl.OnClick := ClickHandler;
  if not ThemeServices.ThemesEnabled then
  begin
    Width := GetSystemMetrics(SM_CYSMSIZE);
    Height := GetSystemMetrics(SM_CYSMSIZE);
  end else
  begin
    Width := 17;
    Height := 16;
  end;
end;

destructor TDDFCloseButtonEh.Destroy;
begin
  FreeAndNil(FButtonControl);
  inherited Destroy;
end;

procedure TDDFCloseButtonEh.ClickHandler(Sender: TObject);
var
  AForm: TCustomForm;
begin
  AForm := GetParentForm(Self);
  if AForm <> nil then
    AForm.Close;
end;

procedure TDDFCloseButtonEh.PaintHandler(Sender: TObject);
var
  Details: TThemedElementDetails;
  ARect, AFaceRect: TRect;
  bw: Integer;
  AState: Integer;
begin
  ARect := Rect(0, 0, Width, Height);
  if not ThemeServices.ThemesEnabled then
  begin
    bw := GetSystemMetrics(SM_CYSMSIZE);

    if FButtonControl.State = bsDown then
      AState := DFCS_CHECKED
    else if FButtonControl.MouseInControl then
      AState := DFCS_HOT
    else
      AState := 0;

    AFaceRect := CenteredRect(ARect, Rect(0,0,bw,bw));
    DrawFrameControl(FButtonControl.Canvas.Handle, AFaceRect,
      DFC_CAPTION, DFCS_CAPTIONCLOSE or DFCS_FLAT or AState);
  end else
  begin
    if CustomStyleActive then
    begin
      if FButtonControl.State = bsDown then
        Details := ThemeServices.GetElementDetails(twSmallCloseButtonPushed)
      else if FButtonControl.MouseInControl then
        Details := ThemeServices.GetElementDetails(twSmallCloseButtonHot)
      else
        Details := ThemeServices.GetElementDetails(twSmallCloseButtonNormal);
    end else
    begin
      if FButtonControl.State = bsDown then
        Details := ThemeServices.GetElementDetails(tttClosePressed)
      else if FButtonControl.MouseInControl then
        Details := ThemeServices.GetElementDetails(tttCloseHot)
      else
        Details := ThemeServices.GetElementDetails(tttCloseNormal);
    end;
    ThemeServices.DrawElement(FButtonControl.Canvas.Handle, Details, ARect);
  end;
end;

{ TDDFSizingBarEh }

constructor TDDFSizingBarEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csCaptureMouse];
  BevelOuter := bvNone;
  {$IFDEF FPC}
  {$ELSE}
  BevelEdges := [beTop];
  BevelKind := bkTile;
  {$ENDIF}
end;

destructor TDDFSizingBarEh.Destroy;
begin
  inherited Destroy;
end;

procedure TDDFSizingBarEh.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
  FMouseDownPos := Point(-1,-1);
  if Align = alBottom then
  begin
    if Y > Height - FSizingArea then
      FMouseDownPos := Point(X, Y);
  end else
  begin
    if Y < FSizingArea then
      FMouseDownPos := Point(X, Y);
  end;
end;

procedure TDDFSizingBarEh.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  Delta: Integer;
begin
  inherited MouseMove(Shift, X, Y);
  if (ssLeft in Shift) and MouseCapture and (FMouseDownPos.X <> -1) and (FMouseDownPos.Y <> -1) then
    if Align = alBottom then
      HostControl.Height := HostControl.Height + (Y - FMouseDownPos.Y)
    else
    begin
      Delta := FMouseDownPos.Y - Y;
      HostControl.SetBounds(HostControl.Left, HostControl.Top - Delta, HostControl.Width, HostControl.Height + Delta);
    end;
end;

procedure TDDFSizingBarEh.Resize;
begin
  inherited Resize;
  if Height * 2 < 20
    then FSizingArea := Height div 2
    else FSizingArea := 10;
end;

procedure TDDFSizingBarEh.WMSetCursor(var Msg: TWMSetCursor);
var
  P: TPoint;
begin
  P := Point(LoWord(GetMessagePos), HiWord(GetMessagePos));
  P := ScreenToClient(P);

  if Msg.HitTest = HTCLIENT then
    if Align = alBottom then
    begin
      if P.Y > Height - FSizingArea then
      begin
        Windows.SetCursor(Screen.Cursors[crSizeNS]);
        Msg.Result := 1;
      end else
        inherited;
    end else
    begin
      if P.Y < FSizingArea then
      begin
        Windows.SetCursor(Screen.Cursors[crSizeNS]);
        Msg.Result := 1;
      end else
        inherited;
    end
  else
    inherited;
end;

function TCustomDropDownFormEh.GetReadOnly: Boolean;
begin
  Result := FReadOnly;
end;

procedure TCustomDropDownFormEh.SetDropDownMode(const Value: Boolean);
begin
  if FDropDownMode <> Value then
  begin
    FDropDownMode := Value;
    {$IFDEF FPC}
    RecreateWnd(Self);
    {$ELSE}
    RecreateWnd;
    {$ENDIF}
  end;
end;

procedure TCustomDropDownFormEh.SetInDynParams(DynParams: TDynVarsEh);
begin
  FDynParams := DynParams;
end;

procedure TCustomDropDownFormEh.GetOutDynParams(var DynParams: TDynVarsEh);
begin
  DynParams := FDynParams;
end;

procedure TCustomDropDownFormEh.SetReadOnly(const Value: Boolean);
begin
  FReadOnly := Value;
end;

procedure TCustomDropDownFormEh.Show;
begin
  DropDownMode := False;
  inherited Show;
end;

function TCustomDropDownFormEh.ShowModal: Integer;
begin
  DropDownMode := False;
  inherited BorderStyle := bsDialog;
  Position := poScreenCenter;
  BorderIcons := [biSystemMenu, biMinimize, biMaximize];
  InitForm(nil, FDynParams);
  Result := inherited ShowModal;
  if Result = mrOk then
    ReturnParams(nil, FDynParams);
end;

initialization
  RegisterClasses;
finalization
  UnregisterClasses;
end.

