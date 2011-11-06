//////////////////////////////////////////////////////////////////////////////
//
// ћодуль кроссплатформенных функций с основными окнами процессов
//
//////////////////////////////////////////////////////////////////////////////
unit uCrossPlatformWindow;

interface
{$IFDEF MSWINDOWS}
{$ENDIF}
{$IFDEF LINUX}
uses
  XLib;
{$ENDIF}

procedure ModifyAllWindows(const AbMinimize: Boolean = True);
procedure StayOnTop(AnWindow: THandle);
function GetTaskBarHeight: Integer;
procedure MinimizeWindows;

implementation


uses
{$IFDEF MSWINDOWS}
  Windows,
  Tlhelp32,
  Messages,
{$ENDIF}
{$IFDEF LINUX}
  uSafeStorage,
  ufrmMain,
  Qt,
  QForms,
{$ENDIF}
  uDebugLog,
  SysUtils;

{$IFDEF MSWINDOWS}
const
  CMD_MINIMIZE = 0;    // команда минимизации всех видимых окон
  CMD_RESTORE = 1;     // команда восстановлени€ размера всех видимых окон
{$ENDIF}

{$IFDEF LINUX}
type
  TWindowManager = (
      TWindowManager_Unknown = 0,
      TWindowManager_KDE = 1,
      TWindowManager_Gnome = 2);
var
  GWindowManager: TWindowManager;
{$ENDIF}

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private helper methods

{$IFDEF MSWINDOWS}
function _GetProcessFileName(AnHandle: THandle): String;
var
  ProcessEntry32: TProcessEntry32;
  hSnapshot: THandle;
  strProcessName: String;
  bIsProcessPresent: Boolean;
begin
  Result := '';

  hSnapshot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  if hSnapshot = INVALID_HANDLE_VALUE then begin
    Exit;
  end;

  ProcessEntry32.dwSize := sizeof(ProcessEntry32);

  bIsProcessPresent := Process32First(hSnapshot, ProcessEntry32);
  while bIsProcessPresent do begin

    if (ProcessEntry32.th32ProcessID=AnHandle) then begin
      Result := ExtractFileName(ProcessEntry32.szExeFile);
      break;
    end;
    bIsProcessPresent := Process32Next(hSnapshot, ProcessEntry32);
  end; // while
  CloseHandle(hSnapshot);
end; // TProcessSupervisor._GetProcessHandle
{$ENDIF}
{$IFDEF LINUX}
function _GetProcessFileName(AnHandle: THandle): String;
var
//  ProcessEntry32: TProcessEntry32;
  hSnapshot: THandle;
  strProcessName: String;
  bIsProcessPresent: Boolean;
begin
  Result := '';
{
  hSnapshot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  if hSnapshot = INVALID_HANDLE_VALUE then begin
    Exit;
  end;

  ProcessEntry32.dwSize := sizeof(ProcessEntry32);

  bIsProcessPresent := Process32First(hSnapshot, ProcessEntry32);
  while bIsProcessPresent do begin

    if (ProcessEntry32.th32ProcessID=AnHandle) then begin
      Result := ExtractFileName(ProcessEntry32.szExeFile);
      break;
    end;
    bIsProcessPresent := Process32Next(hSnapshot, ProcessEntry32);
  end; // while
  CloseHandle(hSnapshot);
}
end; // TProcessSupervisor._GetProcessHandle
{$ENDIF}
{$IFDEF MSWINDOWS}
function _EnumWinProc(handle: THandle; Param: LongInt): Boolean; stdcall;
var
  strBufFileName : array[0..MAX_PATH] of char;  // буфер дл€ имени процесса
  strBufWndName : array[0..MAX_PATH] of char;  // буфер дл€ имени окна
  strFileName : String;
  strWndName : String;
  nProcHandle: Cardinal;
begin

  {if (handle = GetDesktopWindow)
      or not isWindow(handle) // и вообще это - окно.
      or not isWindowVisible(handle)  // если окно видимо
      or not ((GetWindowLong(handle,GWL_STYLE) and WS_CHILD) = 0) then begin
  end; // if}

  if (GetParent(handle) <> 0) or (not IsWindowVisible(handle)) then
  begin
    _EnumWinProc := TRUE;
    Exit;
  end;

  GetWindowThreadProcessId(handle, nProcHandle);
  GetWindowText(handle, strBufWndName, MAX_PATH);
  strFileName := _GetProcessFileName(nProcHandle);
  strFileName := AnsiLowerCase(strFileName);
  strWndName := strBufWndName;
  strWndName := AnsiLowerCase(strWndName);
  if (strFileName = 'rshell.exe')
      or (strFileName = 'gccl.exe')
      or (strWndName = 'program')
      or (strWndName = 'program manager')
      or (strWndName = 'gc3shell')
      or (strWndName = 'gameclass')
      or (strWndName = 'GameClass3 Client')
      or (strWndName = 'rvsim')
      or (strWndName = 'shell_traywnd')
      or (length(strWndName) = 0)
      then begin
    _EnumWinProc := TRUE;
    Exit;
  end;
  if (Param = CMD_MINIMIZE) then begin
    if not isIconic(handle) then
//      ShowWindow(handle, SW_MINIMIZE);
        PostMessage(handle, WM_SYSCOMMAND, SC_MINIMIZE, 0);
  end;
  if (Param = CMD_RESTORE) then begin
    if isIconic(handle) then
//      ShowWindow(handle, SW_RESTORE);
        PostMessage(handle, WM_SYSCOMMAND, SC_RESTORE, 0);
  end; // if
  _EnumWinProc := TRUE; // продолжаем перебирать все окна системы.
end; // function
{$ENDIF}
{$IFDEF LINUX}
function _EnumWinProc(handle: THandle; Param: LongInt): Boolean; stdcall;
begin
  _EnumWinProc := TRUE; // продолжаем перебирать все окна системы.
end; // function
{$ENDIF}


procedure StayOnTop(AnWindow: THandle);
begin{
        if(sdlg->isVisible ())
                XRaiseWindow( qt_xdisplay(), sdlg->winId());
        else
                XRaiseWindow( qt_xdisplay(), winId());
}
end;

{$IFDEF LINUX}

function _GetTaskBarHeight(dpy: PDisplay; top:Window): Integer;
var
	children: array of Window;
  dummy: Window;
	i, nchildren: Integer;
	window_name: PChar;
  attributes: XWindowAttributes;
  rx, ry: Integer;
begin
	Result := 0;
	if (XFetchName(dpy, top, @window_name) = XTrue)
      and ((StrComp(window_name, 'kicker') = 0)
      or (StrComp(window_name, 'gnome-panel') = 0))
      and (XGetWindowAttributes(dpy, top, @attributes) = XTrue)
      and (XTranslateCoordinates (dpy, top, attributes.root,
      attributes.x, attributes.y, @rx, @ry, @dummy) = XTrue)
      and (attributes.height + ry = Screen.Height) then begin
    Result := attributes.height;
  end	else if XQueryTree(
      dpy, top, @dummy, @dummy, @children, @nchildren) = XTrue then begin

  	for i:=0 to nchildren - 1 do begin
	  	Result := _GetTaskBarHeight(dpy, children[i]);
		  if (Result <> 0) then
		    break;
    end;

	  if (Pointer(children) <> Nil) then
      XFree(PChar(children));
  end;
// Ќужно, чтобы делфи не освобождал освобожденную пам€ть.
  Pointer(children) := Nil;
end;

function MinimizeNamedWindows(ADisplay: PDisplay; ARootWindow:Window;
    AstrExcludedWaindowName: String): Boolean;
var
	children: array of Window;
  dummy: Window;
	i, nchildren: Integer;
  attributes: XWindowAttributes;
  bChild: Boolean;
  strWindowName: String;
	pWindowName: PChar;
begin
	Result := True;
	if (XFetchName(ADisplay, ARootWindow, @pWindowName) = XTrue) then
     strWindowName := pWindowName
   else
     strWindowName := '';
	if AstrExcludedWaindowName = strWindowName then begin
    Result := False;
    exit;
  end	else if XQueryTree(
      ADisplay, ARootWindow, @dummy, @dummy, @children, @nchildren) = XTrue then begin
    bChild := True;
  	for i:=0 to nchildren - 1 do begin
       bChild := bChild and
	     MinimizeNamedWindows(ADisplay, children[i], AstrExcludedWaindowName);
    end;
    if (XGetWindowAttributes(ADisplay, ARootWindow, @attributes) = XTrue)
        and (strWindowName <> '') then begin
      if (attributes.map_state = IsViewable) then
        XIconifyWindow(ADisplay, ARootWindow, 0);
    end;
	  if (Pointer(children) <> Nil) then
      XFree(PChar(children));
  end;
// Ќужно, чтобы делфи не освобождал освобожденную пам€ть.
  Pointer(children) := Nil;
end;
{$ENDIF}
procedure MinimizeWindows;
{$IFDEF LINUX}
var
 rootWindow: Window;
{$ENDIF}
begin
{$IFDEF LINUX}
  Application.Display;
  rootWindow := XDefaultRootWindow(Application.Display);
  if (rootWindow <> 0) then
    MinimizeNamedWindows( Application.Display, rootWindow, frmMain.Caption);
{$ENDIF}
end;

function GetTaskBarHeight: Integer;
{$IFDEF MSWINDOWS}
{$ENDIF}
{$IFDEF LINUX}
  var
    dpy: PDisplay;
    root, kicker: Window;
    win_attrs: XWindowAttributes;
    junkwin:Window ;
    rx, ry: Integer;
{$ENDIF}
begin
  Result := 0;
{$IFDEF MSWINDOWS}
  Result := GetSystemMetrics(SM_CYCAPTION);
{$ENDIF}
{$IFDEF LINUX}
  try
    dpy := Application.Display;
    root := XDefaultRootWindow(dpy);
    Result := _GetTaskBarHeight(dpy, root);
{    if (root <> 0) then begin
      kicker := Window_With_Name( dpy, root, 'kicker');
      if (kicker <> 0)
          and (XGetWindowAttributes(dpy,kicker,@win_attrs) = XTrue) then begin
        XTranslateCoordinates (dpy, kicker, win_attrs.root,
        		-win_attrs.border_width,
    		    -win_attrs.border_width,
            @rx, @ry, @junkwin);
        Result := Screen.Height - ry;
        GWindowManager := TWindowManager_KDE;
      end else begin
        kicker := Window_With_Name( dpy, root, 'Trash Applet');
        if (kicker <> 0)
            and (XGetWindowAttributes(dpy,kicker,@win_attrs) = XTrue) then begin
          XTranslateCoordinates (dpy, kicker, win_attrs.root,
          		- win_attrs.border_width,
    		      - win_attrs.border_width,
              @rx, @ry, @junkwin);
          Result := Screen.Height - ry;
          GWindowManager := TWindowManager_Gnome;
        end;
      end;
    end; }
  except
    on e: Exception do begin
      Debug.Trace0('GetTaskBarHeight error! ' + e.Message);
    end;
  end;
{$ENDIF}
end;

procedure ModifyAllWindows(const AbMinimize: Boolean = True);
begin
  if AbMinimize then begin
{$IFDEF MSWINDOWS}
    EnumWindows(@_EnumWinProc, CMD_MINIMIZE)
{$ENDIF}
{$IFDEF LINUX}
    TSafeStorage.Instance().Push(ThreadSafeOperation_MinimizeWindows, 0);
{$ENDIF}
  end else begin
{$IFDEF MSWINDOWS}
    EnumWindows(@_EnumWinProc, CMD_RESTORE);
{$ENDIF}
{$IFDEF LINUX}
{$ENDIF}
  end;
end;

{$IFDEF LINUX}
initialization
  GWindowManager := TWindowManager_Unknown;
{$ENDIF}

end.


