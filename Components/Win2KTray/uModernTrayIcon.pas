//////////////////////////////////////////////////////////////////////////////
//
// «а основу класса TModernTrayIcon, реализованного в данном модуле,
// вз€т класс TRxTrayIcon из модул€ RXShell библиотеки RXLib 2.75.
// ¬есь функционал класса TRxTrayIcon сохранен в полном объеме.
// ƒобавлена возможность выводить balloon-подсказки.
// ƒобавлены свойства:
//    BalloonTitle: String;
//    BalloonText: String;
//    BalloonIcon: TBalloonIcon;
// ƒобавлен метод:
//    ShowBalloonHint.
//
//////////////////////////////////////////////////////////////////////////////

unit uModernTrayIcon;

interface

uses
  // system units
  Windows,
  Messages,
  Classes,
  Graphics,
  SysUtils,
  Forms,
  Controls,
  Menus,
  ShellAPI,
  // project units
  uTimerThread,
  uIconList;


const
  // константы иконок всплывающей подсказки дл€ иконки в трее
  NIF_INFO = $00000010;
  NIIF_NONE = $00000000;
  NIIF_INFO = $00000001;
  NIIF_WARNING = $00000002;
  NIIF_ERROR = $00000003;

  TRAY_CALLBACK_MSG = WM_USER + $1958;


type

  // —труктура NotifyIconData бала изменена в Win 2000.
  // “ак как в модуле ShellApi.pas описан ее старый вариант,
  // не поддерживающий Balloon-подсказки, то пришлось описать
  // новую структуру TNotifyIconDataEx дл€ передачи в функцию
  // Shell_NotifyIcon.
  TNotifyIconDataEx = record
    cbSize: DWORD;
    Wnd: HWND;
    uID: UINT;
    uFlags: UINT;
    uCallbackMessage: UINT;
    hIcon: HICON;
    szTip: array[0..127] of AnsiChar;
    dwState: DWORD;
    dwStateMask: DWORD;
    szInfo: array[0..255] of AnsiChar;
    uTimeout: UINT;
    szInfoTitle: array[0..63] of AnsiChar;
    dwInfoFlags: DWORD;
    {$IFDEF _WIN32_IE_600}
    guidItem: TGUID; // Reserved for XP
    {$ENDIF}
  end; // TNotifyIconDataEx


  // множество кнопок мыши
  TMouseButtons = set of TMouseButton;


  // перечисление стилей всплывающих подсказок
  TBalloonIcon = (
      BalloonIcon_None,        // без иконки
      BalloonIcon_Information, // иконка показа обычной информации
      BalloonIcon_Warning,     // иконка предупреждени€
      BalloonIcon_Error        // иконка ошибки
  );


  //
  // TModernTrayIcon
  //

  TModernTrayIcon = class(TComponent)
  private
    // fields
    FhSelf: HWnd;
    FbActive: Boolean;
    FbAdded: Boolean;
    FbAnimated: Boolean;
    FbEnabled: Boolean;
    FClicked: TMouseButtons;
    FnIconIndex: Integer;
    FdwInterval: DWord;
    FIconData: TNotifyIconDataEx;
    FIcon: TIcon;
    FIconList: TIconList;
    FTimer: TTimerThread;
    FstrHint: String;
    FstrBalloonTitle: String;
    FstrBalloonText: String;
    FBalloonIcon: TBalloonIcon;
    FbShowDesign: Boolean;
    FPopupMenu: TPopupMenu;
    FOnClick: TMouseEvent;
    FOnDblClick: TNotifyEvent;
    FOnMouseMove: TMouseMoveEvent;
    FOnMouseDown: TMouseEvent;
    FOnMouseUp: TMouseEvent;

    // процедура обработки оконных событий
    procedure _WndProc(var AMessage: TMessage);

    // events handlers
    procedure _IconChanged(ASender: TObject);
    procedure _TimeMark(ASender: TObject);

    // private helper methods
    procedure _Activate();
    procedure _Deactivate();
    procedure _ChangeIcon();
    function _CheckDefaultMenuItem(): Boolean;
    procedure _SendCancelMode();
    function _CheckMenuPopup(const AnX: Integer; const AnY: Integer): Boolean;
    function _GetInfoFlagsFromBalloonIcon(
        const ABalloonIcon: TBalloonIcon): DWord;
    procedure _SwitchToWindow(const AhWnd: HWnd; const AbRestore: Boolean);

  protected
    // protected methods
    procedure DblClick(); dynamic;
    procedure DoClick(const AButton: TMouseButton; const AShift: TShiftState;
        const AnX, AnY: Integer); dynamic;
    procedure MouseDown(const AButton: TMouseButton;
        const AShift: TShiftState; const AnX, AnY: Integer); dynamic;
    procedure MouseMove(const AShift: TShiftState;
        const AnX, AnY: Integer); dynamic;
    procedure MouseUp(const AButton: TMouseButton; const AShift: TShiftState;
        const AnX, AnY: Integer); dynamic;
    procedure Loaded(); override;
    procedure Notification(AComponent: TComponent;
        AOperation: TOperation); override;
    procedure UpdateNotifyData(); virtual;

    // properties methods
    procedure SetHint(const AstrHint: String);

    procedure SetIcon(const AIcon: TIcon);

    procedure SetIconList(const AIconList: TIconList);

    procedure SetPopupMenu(const APopupMenu: TPopupMenu);

    procedure SetActive(const AbActive: Boolean);

    procedure SetShowDesign(const AbShowDesign: Boolean);

    procedure SetInterval(const AdwInterval: DWord);

    function GetActiveIcon(): TIcon;

    function GetAnimated(): Boolean;
    procedure SetAnimated(const AbAnimated: Boolean);

  public
    // constructor / destructor
    constructor Create(AOwner: TComponent); override;
    destructor Destroy(); override;

    // public methods
    procedure Hide();
    procedure Show();
    function ShowBalloonHint(
        const AstrTitle: String; const AstrText: String;
        const ABalloonIcon: TBalloonIcon;
        const AnTimeoutMS: Cardinal = 1000): Boolean; overload;
    function ShowBalloonHint(
        const AstrTitle: String; const AstrText: String;
        const AnTimeoutMS: Cardinal = 1000): Boolean; overload;
    function ShowBalloonHint(
        const AnTimeoutMS: Cardinal = 1000): Boolean; overload;

    // properties
    property Handle: HWnd read FhSelf;

  published
    // properties
    property Active: Boolean read FbActive write SetActive default TRUE;
    property Enabled: Boolean read FbEnabled write FbEnabled default TRUE;
    property Hint: string read FstrHint write SetHint;
    property BalloonTitle: String
        read FstrBalloonTitle write FstrBalloonTitle;
    property BalloonText: String
        read FstrBalloonText write FstrBalloonText;
    property BalloonIcon: TBalloonIcon
        read FBalloonIcon write FBalloonIcon;
    property Icon: TIcon read FIcon write SetIcon;
    property Icons: TIconList read FIconList write SetIconList;
    property Animated: Boolean
        read GetAnimated write SetAnimated default FALSE;
    property Interval: DWord read FdwInterval write SetInterval default 150;
    property PopupMenu: TPopupMenu read FPopupMenu write SetPopupMenu;
    property ShowDesign: Boolean
        read FbShowDesign write SetShowDesign stored FALSE;
    property OnClick: TMouseEvent read FOnClick write FOnClick;
    property OnDblClick: TNotifyEvent read FOnDblClick write FOnDblClick;
    property OnMouseMove: TMouseMoveEvent
        read FOnMouseMove write FOnMouseMove;
    property OnMouseDown: TMouseEvent read FOnMouseDown write FOnMouseDown;
    property OnMouseUp: TMouseEvent read FOnMouseUp write FOnMouseUp;

  end; // TModernTrayIcon



implementation

uses
  // system units
  Math;


const
  CM_TRAYICON = CM_BASE + 84;


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// TRxTrayIcon

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TModernTrayIcon.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FhSelf := Classes.AllocateHWnd(_WndProc);
  FIcon := TIcon.Create();
  FIcon.OnChange := _IconChanged;
  FIconList := TIconList.Create();
  FIconList.OnChange := _IconChanged;
  FnIconIndex := -1;
  FbEnabled := TRUE;
  FdwInterval := 150;
  FbActive := TRUE;
end; // TModernTrayIcon.Create


destructor TModernTrayIcon.Destroy();
begin
  Destroying();
  FbEnabled := FALSE;
  FIconList.OnChange := nil;
  FIcon.OnChange := nil;
  SetAnimated(FALSE);
  _Deactivate();
  Classes.DeallocateHWnd(FhSelf);
  FreeAndNil(FIcon);
  FreeAndNil(FIconList);
  inherited Destroy();
end; // TModernTrayIcon.Destroy


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TModernTrayIcon.Show();
begin
  Active := TRUE;
end; // TModernTrayIcon.Show


procedure TModernTrayIcon.Hide();
begin
  Active := FALSE;
end; // TModernTrayIcon.Hide


function TModernTrayIcon.ShowBalloonHint(const AstrTitle: String;
    const AstrText: string; const ABalloonIcon: TBalloonIcon;
    const AnTimeoutMS: Cardinal = 1000): Boolean;
begin
  BalloonTitle := AstrTitle;
  BalloonText := AstrText;
  BalloonIcon := ABalloonIcon;
  Result := ShowBalloonHint(AnTimeoutMS);
end; // TModernTrayIcon.ShowBalloonHint


function TModernTrayIcon.ShowBalloonHint(const AstrTitle: String;
    const AstrText: String; const AnTimeoutMS: Cardinal = 1000): Boolean;
begin
  BalloonTitle := AstrTitle;
  BalloonText := AstrText;
  Result := ShowBalloonHint(AnTimeoutMS);
end; // TModernTrayIcon.ShowBalloonHint


function TModernTrayIcon.ShowBalloonHint(
    const AnTimeoutMS: Cardinal = 1000): Boolean;
begin
  with FIconData do begin
    cbSize := SizeOf(FIconData);
    uFlags := uFlags or NIF_INFO;
    StrLCopy(szInfo, PAnsiChar(AnsiString(BalloonText)), SizeOf(szInfo)-1);
    StrLCopy(szInfoTitle, PAnsiChar(AnsiString(BalloonTitle)), SizeOf(szInfoTitle)-1);
    uTimeout := AnTimeoutMS;
    dwInfoFlags := _GetInfoFlagsFromBalloonIcon(BalloonIcon);
  end;
  Result := Shell_NotifyIcon(NIM_MODIFY, @FIconData)
end; // TModernTrayIcon.ShowBalloonHint


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// protected methods

procedure TModernTrayIcon.Loaded();
begin
  inherited Loaded;
  if FbActive and not (csDesigning in ComponentState) then begin
    _Activate();
  end;
end; // TModernTrayIcon.Loaded


procedure TModernTrayIcon.Notification(AComponent: TComponent;
    AOperation: TOperation);
begin
  inherited Notification(AComponent, AOperation);
  if (AComponent = PopupMenu) and (AOperation = opRemove) then begin
    PopupMenu := nil;
  end;
end; // TModernTrayIcon.Notification


procedure TModernTrayIcon.UpdateNotifyData();
var
  Icon: TIcon;
begin
  with FIconData do begin
    cbSize := SizeOf(TNotifyIconData);
    Wnd := FhSelf;
    uFlags := NIF_MESSAGE or NIF_ICON or NIF_TIP;
    Icon := GetActiveIcon;
    if Icon <> nil then begin
      hIcon := Icon.Handle
    end else begin
      hIcon := INVALID_HANDLE_VALUE;
    end;
    StrPLCopy(szTip, GetShortHint(FstrHint), SizeOf(szTip) - 1);
    uCallbackMessage := CM_TRAYICON;
    uID := 0;
  end;
end; // TModernTrayIcon.UpdateNotifyData


procedure TModernTrayIcon.MouseMove(const AShift: TShiftState;
    const AnX, AnY: Integer);
begin
  if Assigned(FOnMouseMove) then begin
    FOnMouseMove(Self, AShift, AnX, AnY);
  end;
end; // TModernTrayIcon.MouseMove


procedure TModernTrayIcon.MouseDown(const AButton: TMouseButton;
    const AShift: TShiftState; const AnX, AnY: Integer);
begin
  if Assigned(FOnMouseDown) then begin
    FOnMouseDown(Self, AButton, AShift, AnX, AnY);
  end;
end; // TModernTrayIcon.MouseDown


procedure TModernTrayIcon.MouseUp(const AButton: TMouseButton;
    const AShift: TShiftState; const AnX, AnY: Integer);
begin
  if Assigned(FOnMouseUp) then begin
    FOnMouseUp(Self, AButton, AShift, AnX, AnY);
  end;
end; // TModernTrayIcon.MouseUp


procedure TModernTrayIcon.DblClick();
begin
  if not _CheckDefaultMenuItem() and Assigned(FOnDblClick) then begin
    FOnDblClick(Self);
  end;
end; // TModernTrayIcon.DblClick


procedure TModernTrayIcon.DoClick(const AButton: TMouseButton;
  const AShift: TShiftState; const AnX, AnY: Integer);
begin
  if (AButton = mbRight) and _CheckMenuPopup(AnX, AnY) then begin
    Exit;
  end;
  if Assigned(FOnClick) then begin
    FOnClick(Self, AButton, AShift, AnX, AnY);
  end;
end; // TModernTrayIcon.DoClick


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// properties methods

procedure TModernTrayIcon.SetIcon(const AIcon: TIcon);
begin
  FIcon.Assign(AIcon);
end; // TModernTrayIcon.SetIcon


procedure TModernTrayIcon.SetIconList(const AIconList: TIconList);
begin
  FIconList.Assign(AIconList);
end; // TModernTrayIcon.SetIconList


function TModernTrayIcon.GetActiveIcon(): TIcon;
begin
  Result := FIcon;
  if (FIconList <> nil) and (FIconList.Count > 0) and Animated then begin
    Result := FIconList[Max(Min(FnIconIndex, FIconList.Count - 1), 0)];
  end;
end; // TModernTrayIcon.GetActiveIcon


function TModernTrayIcon.GetAnimated(): Boolean;
begin
  Result := FbAnimated;
end; // TModernTrayIcon.GetAnimated


procedure TModernTrayIcon.SetAnimated(const AbAnimated: Boolean);
var
  bAnimated: Boolean;
begin
  bAnimated := AbAnimated and Assigned(FIconList) and (FIconList.Count > 0);
  if bAnimated <> Animated then begin
    if bAnimated then begin
      FTimer := TTimerThread.Create(not FbAdded);
      FTimer.Interval := Interval;
      FTimer.OnTimeMark := _TimeMark;
      FbAnimated := TRUE;
    end else begin
      FbAnimated := FALSE;
      while FTimer.Suspended do begin
        FTimer.Resume;
      end;
      FTimer.Terminate;
    end;
    FnIconIndex := 0;
    _ChangeIcon();
  end;
end; // TModernTrayIcon.SetAnimated


procedure TModernTrayIcon.SetActive(const AbActive: Boolean);
begin
  if (AbActive <> FbActive) then begin
    FbActive := AbActive;
    if not (csDesigning in ComponentState) then begin
      if FbActive then begin
        _Activate();
      end else begin
        _Deactivate();
      end;
    end;
  end;
end; // TModernTrayIcon.SetActive


procedure TModernTrayIcon.SetShowDesign(const AbShowDesign: Boolean);
begin
  if (csDesigning in ComponentState) then begin
    if AbShowDesign then begin
      _Activate()
    end else begin
      _Deactivate();
    end;
    FbShowDesign := FbAdded;
  end;
end; // TModernTrayIcon.SetShowDesign


procedure TModernTrayIcon.SetInterval(const AdwInterval: DWord);
begin
  if FdwInterval <> AdwInterval then begin
    FdwInterval := AdwInterval;
    if Assigned(FTimer) then begin
      FTimer.Interval := AdwInterval;
    end;
  end;
end; // TModernTrayIcon.SetInterval


procedure TModernTrayIcon.SetHint(const AstrHint: String);
begin
  if FstrHint <> AstrHint then begin
    FstrHint := AstrHint;
    _ChangeIcon();
  end;
end; // TModernTrayIcon.SetHint


procedure TModernTrayIcon.SetPopupMenu(const APopupMenu: TPopupMenu);
begin
  FPopupMenu := APopupMenu;
  if Assigned(APopupMenu) then begin
    APopupMenu.FreeNotification(Self);
  end;
end; // TModernTrayIcon.SetPopupMenu


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// events handlers

procedure TModernTrayIcon._IconChanged(ASender: TObject);
begin
  _ChangeIcon();
end; // TModernTrayIcon._IconChanged


procedure TModernTrayIcon._TimeMark(ASender: TObject);
begin
  if not (csDestroying in ComponentState) and Animated then begin
    Inc(FnIconIndex);
    if (FIconList = nil) or (FnIconIndex >= FIconList.Count) then begin
      FnIconIndex := 0;
    end;
    _ChangeIcon();
  end;
end; // TModernTrayIcon.Timer


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private methods

procedure TModernTrayIcon._WndProc(var AMessage: TMessage);

  function GetShiftState: TShiftState;
  begin
    Result := [];
    if GetKeyState(VK_SHIFT) < 0 then Include(Result, ssShift);
    if GetKeyState(VK_CONTROL) < 0 then Include(Result, ssCtrl);
    if GetKeyState(VK_MENU) < 0 then Include(Result, ssAlt);
  end;

var
  ptCursorPos: TPoint;
  Shift: TShiftState;
begin
  try
    with AMessage do begin
      if (Msg = CM_TRAYICON) and Self.FbEnabled then begin
        case lParam of
          WM_LBUTTONDBLCLK: begin
            DblClick();
            GetCursorPos(ptCursorPos);
            MouseDown(mbLeft, GetShiftState + [ssDouble],
                ptCursorPos.X, ptCursorPos.Y);
          end;

          WM_RBUTTONDBLCLK: begin
            GetCursorPos(ptCursorPos);
            MouseDown(mbRight, GetShiftState + [ssDouble],
                ptCursorPos.X, ptCursorPos.Y);
          end;

          WM_MBUTTONDBLCLK: begin
            GetCursorPos(ptCursorPos);
            MouseDown(mbMiddle, GetShiftState + [ssDouble],
                ptCursorPos.X, ptCursorPos.Y);
          end;

          WM_MOUSEMOVE: begin
            GetCursorPos(ptCursorPos);
            MouseMove(GetShiftState, ptCursorPos.X, ptCursorPos.Y);
          end;

          WM_LBUTTONDOWN: begin
            GetCursorPos(ptCursorPos);
            MouseDown(mbLeft, GetShiftState + [ssLeft],
                ptCursorPos.X, ptCursorPos.Y);
            Include(FClicked, mbLeft);
          end;

          WM_LBUTTONUP: begin
            Shift := GetShiftState + [ssLeft];
            GetCursorPos(ptCursorPos);
            if mbLeft in FClicked then begin
              Exclude(FClicked, mbLeft);
              DoClick(mbLeft, Shift, ptCursorPos.X, ptCursorPos.Y);
            end;
            MouseUp(mbLeft, Shift, ptCursorPos.X, ptCursorPos.Y);
          end;

          WM_RBUTTONDOWN: begin
            GetCursorPos(ptCursorPos);
            MouseDown(mbRight, GetShiftState + [ssRight],
                ptCursorPos.X, ptCursorPos.Y);
            Include(FClicked, mbRight);
          end;

          WM_RBUTTONUP: begin
            Shift := GetShiftState + [ssRight];
            GetCursorPos(ptCursorPos);
            if mbRight in FClicked then begin
              Exclude(FClicked, mbRight);
              DoClick(mbRight, Shift, ptCursorPos.X, ptCursorPos.Y);
            end;
            MouseUp(mbRight, Shift, ptCursorPos.X, ptCursorPos.Y);
          end;

          WM_MBUTTONDOWN: begin
            GetCursorPos(ptCursorPos);
            MouseDown(mbMiddle, GetShiftState + [ssMiddle],
                ptCursorPos.X, ptCursorPos.Y);
          end;

          WM_MBUTTONUP: begin
            GetCursorPos(ptCursorPos);
            MouseUp(mbMiddle, GetShiftState + [ssMiddle],
                ptCursorPos.X, ptCursorPos.Y);
          end;

          else begin
            Result := DefWindowProc(FhSelf, Msg, wParam, lParam);
          end;

        end; // case

      end else begin
        Result := DefWindowProc(FhSelf, Msg, wParam, lParam);
      end; // if
    end; // with
  except
    Application.HandleException(Self);
  end;
end; // TModernTrayIcon._WndProc


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private helper methods

function TModernTrayIcon._CheckMenuPopup(
    const AnX: Integer; const AnY: Integer): Boolean;
begin
  Result := FALSE;
  if not (csDesigning in ComponentState) and Active and
    (PopupMenu <> nil) and PopupMenu.AutoPopup then
  begin
    PopupMenu.PopupComponent := Self;
    _SendCancelMode();
    _SwitchToWindow(FhSelf, FALSE);
    Application.ProcessMessages;
    try
      PopupMenu.Popup(AnX, AnY);
    finally
      _SwitchToWindow(FhSelf, FALSE);
    end;
    Result := TRUE;
  end;
end; // TModernTrayIcon._CheckMenuPopup


function TModernTrayIcon._CheckDefaultMenuItem(): Boolean;
var
  Item: TMenuItem;
  i: Integer;
begin
  Result := FALSE;
  if not (csDesigning in ComponentState) and Active and
    (PopupMenu <> nil) and (PopupMenu.Items <> nil) then
  begin
    i := 0;
    while (i < PopupMenu.Items.Count) do begin
      Item := PopupMenu.Items[i];
      if Item.Default and Item.Enabled then begin
        Item.Click;
        Result := TRUE;
        Break;
      end;
      Inc(i);
    end;
  end;
end; // TModernTrayIcon.CheckDefaultMenuItem


procedure TModernTrayIcon._Activate();
var
  Icon: TIcon;
begin
  _Deactivate;
  Icon := GetActiveIcon;
  if (Icon <> nil) and not Icon.Empty then begin
    FClicked := [];
    UpdateNotifyData;
    FbAdded := Shell_NotifyIcon(NIM_ADD, @FIconData);
    if (GetShortHint(FstrHint) = '') and FbAdded then
      Shell_NotifyIcon(NIM_MODIFY, @FIconData);
    if Animated then begin
      while FTimer.Suspended do begin
        FTimer.Resume();
      end;
    end;
  end;
end; // TModernTrayIcon._Activate


procedure TModernTrayIcon._Deactivate;
begin
  Shell_NotifyIcon(NIM_DELETE, @FIconData);
  FbAdded := FALSE;
  FClicked := [];
  if Animated and not FTimer.Suspended then begin
    FTimer.Suspend();
  end;
end; // TModernTrayIcon._Deactivate


procedure TModernTrayIcon._SendCancelMode();
var
  frm: TForm;
begin
  if not (csDestroying in ComponentState) then begin
    frm := Screen.ActiveForm;
    if not Assigned(frm) then begin
      frm := Application.MainForm;
    end;
    if Assigned(frm) then begin
      frm.SendCancelMode(nil);
    end;
  end;
end; // TModernTrayIcon._SendCancelMode


procedure TModernTrayIcon._ChangeIcon();
var
  Icon: TIcon;
begin
  if (not Assigned(FIconList)) or (FIconList.Count = 0) then begin
    SetAnimated(FALSE);
  end;

  if FbAdded then begin
    Icon := GetActiveIcon();
    if (Assigned(Icon)) and not Icon.Empty then begin
      UpdateNotifyData();
      Shell_NotifyIcon(NIM_MODIFY, @FIconData);
    end else begin
      _Deactivate();
    end;
  end else begin
    if ((csDesigning in ComponentState) and FbShowDesign) or
        (not (csDesigning in ComponentState) and FbActive) then begin
      _Activate();
    end;
  end;
end; // TModernTrayIcon._ChangeIcon


procedure TModernTrayIcon._SwitchToWindow(const AhWnd: HWnd;
    const AbRestore: Boolean);
begin
  if IsWindowEnabled(AhWnd) then begin
    SetForegroundWindow(AhWnd);
    if AbRestore and IsWindowVisible(AhWnd) then begin
      if not IsZoomed(AhWnd) then
        SendMessage(AhWnd, WM_SYSCOMMAND, SC_RESTORE, 0);
      SetFocus(AhWnd);
    end;
  end;
end; // TModernTrayIcon._SwitchToWindow


function TModernTrayIcon._GetInfoFlagsFromBalloonIcon(
    const ABalloonIcon: TBalloonIcon): DWord;
begin
  case ABalloonIcon of
    BalloonIcon_Information: begin
      Result := NIIF_INFO;
    end;

    BalloonIcon_Warning: begin
      Result := NIIF_WARNING;
    end;

    BalloonIcon_Error: begin
      Result := NIIF_ERROR;
    end;

    else begin
      Result := NIIF_NONE;
    end;

  end;

end; // TModernTrayIcon._GetInfoFlagsFromBalloonIcon


end.
