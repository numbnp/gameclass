{-----------------------------------------------------------------------------
 Unit Name:   uLockComp
 Author:      Yuri Y. Karamani
 Date:        27-июн-2002
 Description: модуль-надстройка над функциями dll блокирования компьютера
              winhbg.dll
 Taganrog Russia
-----------------------------------------------------------------------------}

unit uLockComp;

interface

const
  CMD_MINIMIZE = 0;    // команда минимизации всех видимых окон
  CMD_RESTORE = 1;     // команда восстановления размера всех видимых окон

// загрузка функций из dll с глобальными хуками на мышь и клавиатуру
// (блокирование мыши и клавиатуры)
function LoadHookDll(): boolean;

// функция блокирования клавиатуры
function LockKeyboard():boolean;

// функция блокирования мыши
function LockMouse():boolean;

// функция разблокирования клавиатуры
function UnlockKeyboard():boolean;

// функция разблокирования мыши
function UnlockMouse():boolean;

// функция проверки блокирования клавиатуры
function IsLockKeyboard():boolean;

// функция проверки блокирования мыши
function IsLockMouse():boolean;

// процедура выгрузки динамической библиотеки
procedure FreeHookDll();

// функция перебора всех окон в системе
function EnumWinProc (handle: THandle; Param: LongInt): Boolean; stdcall;

function SetClientHandle(handle: THandle):boolean;

implementation

uses
  Windows,
  SysUtils,
  Dialogs,
  ufrmMain,
  ufrmChangePass,
  ufrmUnblockPassword,
  uDebugLog;

const
  STR_WINHBG = 'winhkg.dll';
//  STR_WINHBG = 'winhbg2.dll';
  STR_LOCKKEYBOARD = 'LockKeyboard';
  STR_UNLOCKKEYBOARD = 'UnlockKeyboard';
  STR_LOCKMOUSE = 'LockMouse';
  STR_UNLOCKMOUSE = 'UnlockMouse';
  STR_ISLOCKKEYBOARD = 'IsLockKeyboard';
  STR_ISLOCKMOUSE = 'IsLockMouse';
  STR_SETCLIENTHANDLE = 'SetClientHandle';

type
  // типы для экспортируемых из winhbg.dll функций
  TLockKeyboardProc = function (H: THandle): boolean; cdecl;
  TUnlockKeyboardProc = function (): boolean; cdecl;
  TLockMouseProc = function (H: THandle): boolean; cdecl;
  TUnlockMouseProc = function (): boolean; cdecl;
  TIsLock = function (): boolean; cdecl;
  TSetClientHandleProc = function (H: THandle): boolean; cdecl;

var
  HookLibHandle : THandle;
  LockKeyboardProc : TLockKeyboardProc;
  UnlockKeyboardProc : TUnlockKeyboardProc;
  LockMouseProc : TLockMouseProc;
  UnlockMouseProc : TUnlockMouseProc;
  IsLockKeyboardProc : TIsLock;
  IsLockMouseProc : TIsLock;
  SetClientHandleProc :  TSetClientHandleProc;
{$WARNINGS OFF}
{-----------------------------------------------------------------------------
  Procedure:   LoadHookDll
  Date:        27-июн-2002
  Arguments:   none
  Result:      boolean
  Description: функция подключения dll блокирования компьютера
-----------------------------------------------------------------------------}
function LoadHookDll(): boolean;
begin
  Debug.Trace0('LoadHookDll started');
 // загружаем библиотеку winhbg.dll
  HookLibHandle := LoadLibrary(PChar(STR_WINHBG));
  Result := (HookLibHandle <> 0);
  // если библиотека загрузилась ...
  if Result then begin
    // LockKeyboard
    @LockKeyboardProc := GetProcAddress(HookLibHandle, PChar(STR_LOCKKEYBOARD));
    Result := Assigned(@LockKeyboardProc);
    // если функция LockKeyboard не найдена ...
    if not Result then begin
      exit;
    end; // if

    // LockMouse
    @LockMouseProc := GetProcAddress(HookLibHandle, PChar(STR_LOCKMOUSE));
    Result := Assigned(@LockMouseProc);
    // если функция LockMouse не найдена ...
    if not Result then begin
      exit;
    end; // if

    // UnlockKeyboard
    @UnlockKeyboardProc := GetProcAddress(HookLibHandle, PChar(STR_UNLOCKKEYBOARD));
    Result := Assigned(@UnlockKeyboardProc);
    // если функция UnlockKeyboard не найдена ...
    if not Result then begin
      exit;
    end; // if

    // UnlockMouse
    @UnlockMouseProc := GetProcAddress(HookLibHandle, PChar(STR_UNLOCKMOUSE));
    Result := Assigned(@UnlockMouseProc);
    // если функция UnlockMouse не найдена ...
    if not Result then begin
      exit;
    end; // if

    // IsLockKeyboard
    @IsLockKeyboardProc := GetProcAddress(HookLibHandle, PChar(STR_ISLOCKKEYBOARD));
    Result := Assigned(@IsLockKeyboardProc);
    // если функция IsLockKeyboard не найдена ...
    if not Result then begin
      exit;
    end; // if

    // IsLockMouse
    @IsLockMouseProc := GetProcAddress(HookLibHandle, PChar(STR_ISLOCKMOUSE));
    Result := Assigned(@IsLockMouseProc);
    // если функция IsLockMouse не найдена ...
    if not Result then begin
      exit;
    end; // if

    // SetClientHandle
    @SetClientHandleProc := GetProcAddress(HookLibHandle, PChar(STR_SETCLIENTHANDLE));
    Result := Assigned(@SetClientHandleProc);
    // если функция SetClientHandle не найдена ...
    if not Result then begin
      exit;
    end; // if
//    FreeLibrary(HookLibHandle);
    Debug.Trace0('LoadHookDll comleted');
  end; // if
end; // function

{-----------------------------------------------------------------------------
  Procedure:   LockKeyboard
  Date:        27-июн-2002
  Arguments:
  Result:      boolean
  Description:
-----------------------------------------------------------------------------}
function LockKeyboard():boolean;
begin
  if HookLibHandle = 0 then
    Result := FALSE
  else begin
    if Assigned(@LockKeyboardProc) then begin
      Result := LockKeyboardProc(HookLibHandle);
      if Result then
        Debug.Trace0('LockKeyboardProc completed');
    end else
      Result := FALSE;
  end; // else
end; // function

{-----------------------------------------------------------------------------
  Procedure:   LockMouse
  Date:        27-июн-2002
  Arguments:
  Result:      boolean
  Description:
-----------------------------------------------------------------------------}
function LockMouse():boolean;
begin
  if HookLibHandle = 0 then
    Result := FALSE
  else begin
    if Assigned(@LockMouseProc) then
      Result := LockMouseProc(HookLibHandle)
    else
      Result := FALSE;
  end // else
end; // function

{-----------------------------------------------------------------------------
  Procedure:   UnlockKeyboard
  Date:        27-июн-2002
  Arguments:
  Result:      boolean
  Description:
-----------------------------------------------------------------------------}
function UnlockKeyboard():boolean;
begin
  if Assigned(@UnlockKeyboardProc) then
    Result := UnlockKeyboardProc()
  else
    Result := FALSE;
end; // function

{-----------------------------------------------------------------------------
  Procedure:   UnlockMouse
  Date:        27-июн-2002
  Arguments:
  Result:      boolean
  Description:
-----------------------------------------------------------------------------}
function UnlockMouse():boolean;
begin
  if Assigned(@UnlockMouseProc) then
    Result := UnlockMouseProc()
  else
    Result := FALSE;
end; // function

{-----------------------------------------------------------------------------
  Procedure:   IsLockKeyboard
  Date:        27-июн-2002
  Arguments:
  Result:      boolean
  Description:
-----------------------------------------------------------------------------}
function IsLockKeyboard():boolean;
begin
  if Assigned(@IsLockKeyboardProc) then
    Result := IsLockKeyboardProc()
  else
    Result := FALSE;
end; // function

{-----------------------------------------------------------------------------
  Procedure:   IsLockMouse
  Date:        27-июн-2002
  Arguments:
  Result:      boolean
  Description:
-----------------------------------------------------------------------------}
function IsLockMouse():boolean;
begin
{$WARNINGS OFF}
  if Assigned(@IsLockMouseProc) then
{$WARNINGS ON}
    Result := IsLockMouseProc()
  else
    Result := FALSE;
end; // function

{-----------------------------------------------------------------------------
  Procedure:   FreeHookDll
  Author:      Yuri Y. Karamani
  Date:        27-июн-2002
  Arguments:
  Result:      None
  Description:
-----------------------------------------------------------------------------}
procedure FreeHookDll();
begin
  if HookLibHandle <> 0 then
    FreeLibrary(HookLibHandle);
end; // procedure

{-----------------------------------------------------------------------------
  Procedure:   EnumMiniProc
  Author:      Yuri Y. Karamani
  Date:        27-июн-2002
  Arguments:   Wd: HWnd; Param: LongInt
  Result:      Boolean
  Description:
-----------------------------------------------------------------------------}
function EnumWinProc (handle: THandle; Param: LongInt): Boolean; stdcall;
var strBufWndName : array[0..MAX_PATH] of char;  // буфер для имени окна
    strWndName : string;
begin

  GetWindowModuleFileName(handle, strBufWndName, MAX_PATH);
  strWndName := AnsiLowerCase(string(strBufWndName));
  //MessageDlg(strWndName, mtWarning, [mbOK], 0); // !!!!
  if (pos(strWndName,'explore.exe') <> 0) or
     (pos(strWndName ,'rshell.exe') <> 0) or
     (pos(strWndName ,'explorer.exe') <> 0) or
     (pos(strWndName,'browseui.dll') <> 0) then begin
    EnumWinProc := TRUE;
    Exit;
  end; // if

  if not (handle = GetDesktopWindow) and
      not (handle = frmMain.Handle)  and
      not (handle = frmChangePass.Handle) and
      not (handle = frmUnblockPassword.Handle) then begin

    if isWindowVisible(handle) then  // если окно видимо
      if (GetWindowLong(handle,GWL_STYLE) and WS_CHILD) = 0 then
        if isWindow(handle) then begin      // и вообще это - окно.
          GetWindowText(handle, strBufWndName, MAX_PATH);
          strWndName := AnsiLowerCase(string(strBufWndName));
          if (strWndName <> 'program') and
             (strWndName <> 'program manager') and
             (strWndName <> 'gc3shell') and
             (strWndName <> 'gameclass') and
             (strWndName <> 'rvsim') and
             (strWndName <> 'shell_traywnd') and
             (length(strWndName) > 0) then
            if (Param = CMD_MINIMIZE) then begin
              if not isIconic(handle) then
                ShowWindow(handle, SW_MINIMIZE);
            end // if
            else if (Param = CMD_RESTORE) then begin
              if isIconic(handle) then
                ShowWindow(handle, SW_RESTORE);
            end; // if
          end; // if
  end; // if
  EnumWinProc := TRUE; // продолжаем перебирать все окна системы.
end; // function

{-----------------------------------------------------------------------------
  Procedure:   SetClientHandle
  Author:      Vladimir A. Paschenko
  Date:        26-фев-2004
  Arguments:   handle of unlockable window
  Result:      boolean
  Description:
-----------------------------------------------------------------------------}
function SetClientHandle(handle: THandle):boolean;
begin
  if Assigned(@SetClientHandleProc) then
    Result := SetClientHandleProc(handle)
  else
    Result := FALSE;
end; // function

{$WARNINGS ON}

end.
