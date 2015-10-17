//////////////////////////////////////////////////////////////////////////////
//
// winhkg - DLL, содержащая функции блокировки мыши и клавиатуры.
//
// Блокировка осуществляется установкой ловушек (hooks) на соответствующие
// сообщения.
//
//////////////////////////////////////////////////////////////////////////////

library winhkg;

uses
  // system units
  Windows,
  Messages;

{$R *.res}

const
  // идентификатор для Memory Mapped File
  GLOBAL_MAP_ID = 'Winhkg_gc - {3B9482B0-FF86-4066-9524-C429EDC60ADC}';
  // константы для низкоуровневых хуков, неописанные в Windows.pas
  WH_KEYBOARD_LL = 13;
  WH_MOUSE_LL    = 14;
  LLKHF_ALTDOWN  = $20;

type
  // структура для хранения заголовков ловушек
  PShareInf = ^TShareInf;
  TShareInf = record
    hMouseHook      : HHOOK;
    hKeyboardHook   : HHOOK;
    hLLKeyboardHook : HHOOK;
    hDebugHook      : HHOOK;
    dwProcessId     : DWORD;
  end; // TShareInf

type
  // структура для хранения низкоуровневых событий клавиатуры
  PKBDLLHOOKSTRUCT = ^KBDLLHOOKSTRUCT;
  KBDLLHOOKSTRUCT = record
    vkCode          : DWORD;
    ScanCode        : DWORD;
    Flags           : DWORD;
    Time            : DWORD;
    dwExtraInfo     : DWORD;
  end; // KBDLLHOOKSTRUCT

var
  GhMap        : THandle;   // memory mapped file для хранения
                            // переменных библиотеки
  GShareInf    : PShareInf; // структура, в которую отображается MMF


// callback - функция для обработки WH_DEBUG
function DebugProc(nCode: Integer; nWParam: WPARAM;
    nLParam: LPARAM): LRESULT; stdcall;
begin
{  if nWParam = WH_DEBUG then begin
    Result := -1;
  end else begin
}    Result := CallNextHookEx(GShareInf^.hDebugHook, nCode, nWParam, nLParam);
//  end;
end; // DebugProc


function GetKeyboardAndMouseState(): DWORD;
var
	dwState : DWORD;
begin
  dwState := 0;
	if (GetAsyncKeyState (VK_CONTROL) shr ((SizeOf(SHORT) * 8) - 1))<>0 then begin
		dwState := dwState + MK_CONTROL;
  end;
	if (GetAsyncKeyState (VK_LBUTTON) shr ((SizeOf(SHORT) * 8) - 1))<>0 then begin
		dwState := dwState + MK_LBUTTON;
  end;
	if (GetAsyncKeyState (VK_MBUTTON) shr ((SizeOf(SHORT) * 8) - 1))<>0 then begin
		dwState := dwState + MK_MBUTTON;
  end;
	if (GetAsyncKeyState (VK_RBUTTON) shr ((SizeOf(SHORT) * 8) - 1))<>0 then begin
		dwState := dwState + MK_RBUTTON;
  end;
	if (GetAsyncKeyState (VK_SHIFT) shr ((SizeOf(SHORT) * 8) - 1))<>0 then begin
		dwState := dwState + MK_SHIFT;
  end;

  {if (GetAsyncKeyState (VK_XBUTTON1) shr ((SizeOf(SHORT) * 8) - 1))=1 then begin
		dwState := dwState + MK_XBUTTON1;
  end;
	if (GetAsyncKeyState (VK_XBUTTON2) shr ((SizeOf(SHORT) * 8) - 1))=1 then begin
		dwState := dwState + MK_XBUTTON2;
  end;
	 } //Нет таких констант, а в MSDN'е есть :(((

	Result := dwState;
end; //function

// callback - функция для обработки сообщений от мыши
function MouseProc(nCode: Integer; nWParam: WPARAM;
    nLParam: LPARAM): LRESULT; stdcall;
var
  hWindow : THandle;
	uMessage : UINT;
	lParamMouse : LPARAM;
	wParamMouse : WPARAM;
	rect : TRECT;
	nXCoordinate,nYCoordinate : LongInt;
begin
  if GShareInf^.dwProcessId <> 0 then begin
    hWindow := PMOUSEHOOKSTRUCT(nLParam).hWnd;
    if GetWindowThreadProcessId(hWindow,LPDWORD(nil))
        = GShareInf^.dwProcessId then begin
      uMessage := nwParam;
      case uMessage of    //
        WM_LBUTTONDOWN, WM_MBUTTONDOWN, WM_RBUTTONDOWN, WM_LBUTTONUP,
        WM_MBUTTONUP, WM_RBUTTONUP, WM_MOUSEMOVE:
        begin
            GetWindowRect(hWindow, rect);
				    nXCoordinate := (PMOUSEHOOKSTRUCT(nlParam).pt.x) - rect.left;
				    nYCoordinate := (PMOUSEHOOKSTRUCT(nlParam).pt.y) - rect.top;
				    wParamMouse := GetKeyboardAndMouseState();
				    lParamMouse := MAKELPARAM(nXCoordinate,nYCoordinate);
				    SendMessage(hWindow,WM_SETCURSOR ,WPARAM(hWindow),
                        MAKELPARAM((PMOUSEHOOKSTRUCT(nlParam)).wHitTestCode,
                        uMessage));
        end;

        WM_MOUSEACTIVATE:
        begin
            wParamMouse := PMOUSEHOOKSTRUCT(nlParam).dwExtraInfo;
  			    lParamMouse := PMOUSEHOOKSTRUCT(nlParam).wHitTestCode; //+HIWORD
          end

        else
        begin
          GetWindowRect(hWindow, rect);
			    nXCoordinate := (PMOUSEHOOKSTRUCT(nlParam).pt.x) - rect.left;
			    nYCoordinate := (PMOUSEHOOKSTRUCT(nlParam).pt.y) - rect.top;
		  		wParamMouse := GetKeyboardAndMouseState();
			  	lParamMouse := MAKELPARAM(nXCoordinate,nYCoordinate);
        end;

      end;    // case
      PostMessage(hWindow, uMessage, wParamMouse, lParamMouse);
    end;
  end;
  if nCode < 0 then
    Result := CallNextHookEx(GShareInf^.hMouseHook, nCode, nWParam, nLParam)
  else
    Result := 1;
end; // MouseProc


// callback - функция для обработки сообщений от клавиатуры
function KeyProc(nCode: Integer; nWParam: WPARAM;
    nLParam: LPARAM): LRESULT; stdcall;
var
  uMessage:UINT;
	hWindow:THandle;
begin
  if (nlParam and $80000000) <> 0 then begin
    uMessage := WM_KEYUP;
  end else begin
    uMessage := WM_KEYDOWN;
  end;
  if GShareInf^.dwProcessId <> 0 then begin
    hWindow := GetFocus();
		if (GetWindowThreadProcessId(hWindow,LPDWORD(nil))
        = GShareInf^.dwProcessId) then begin
			PostMessage(hWindow, uMessage, nwParam, nlParam);
    end;
  end;

  if nCode < 0 then
    Result := CallNextHookEx(GShareInf^.hKeyboardHook, nCode, nWParam, nLParam)
  else
    Result := 1;
end; // KeyProc


// callback - функция для обработки низкоуровневых сообщений от клавиатуры
function LLKeyProc(nCode: Integer; nWParam: WPARAM;
    nLParam: LPARAM): LRESULT; stdcall;
var
  bControlKeyDown : BOOL;
  pkbhs : pKBDLLHOOKSTRUCT;
	hWindow: THandle;
  bIsGccl: Boolean;
begin
	//блокируем CTRL+ESC ALT+TAB ALT+ESC Windows
  pkbhs := PKBDLLHOOKSTRUCT(nLparam);
  case nCode of
    HC_ACTION: begin
      // Check to see if the CTRL key is pressed
      bControlKeyDown :=
          (GetAsyncKeyState (VK_CONTROL) shr ((sizeof(SHORT) * 8) - 1) <> 0);

      // Disable CTRL+ESC
      if ((pkbhs^.vkCode = VK_ESCAPE) and bControlKeyDown) then begin
        Result := 1;
        Exit;
      end;

      // Disable ALT+TAB
      if (pkbhs^.vkCode = VK_TAB) and ((pkbhs^.flags and LLKHF_ALTDOWN) <> 0) then begin
        Result := 1;
        Exit;
      end;

      // Disable ALT+ESC
      if (pkbhs^.vkCode = VK_ESCAPE) and ((pkbhs^.flags and LLKHF_ALTDOWN) <> 0)  then begin
        Result := 1;
        Exit;
      end;

      // Disable Windows
      if (pkbhs^.vkCode = VK_LWIN) or (pkbhs.vkCode = VK_RWIN ) then begin
        Result := 1;
        Exit;
      end;

      // Ctrl+Alt+U send message to gccl.exe
    {  if (GdwProcessId <> 0) and (pkbhs^.vkCode = 'U')
          and ((pkbhs^.flags and LLKHF_ALTDOWN) <> 0)
          and bControlKeyDown then begin
        hWindow := GetFocus();
      	if (GetWindowThreadProcessId(hWindow,LPDWORD(nil)) = GdwProcessId) then begin
      		PostMessage(hWindow, uMessage, nwParam, nlParam);
        end;
      end;
            }
    end;
  end;
  bIsGccl := False;
  hWindow := GetForegroundWindow;
 	if (GetWindowThreadProcessId(hWindow,LPDWORD(nil))
      = GShareInf^.dwProcessId) then
    bIsGccl := True;
//  Result := CallNextHookEx(GShareInf^.hLLKeyboardHook, nCode, nwParam, nlParam);
  if (nCode < 0) or bIsGccl then
    Result := CallNextHookEx(GShareInf^.hLLKeyboardHook,
        nCode, nWParam, nLParam)
  else
    Result := 1;
end; // KeyProc


// Проверка: установлен ли хук на клавиатурные сообщения.
// Возвращает TRUE, если установлен низкоуровневый ИЛИ
// обычный клавиатурный хук.
function IsLockKeyboard(): BOOL; stdcall; // export
begin
  if GShareInf <> nil then
    Result := (GShareInf^.hKeyboardHook <> 0)
        or (GShareInf^.hLLKeyboardHook <> 0)
  else
    Result := FALSE;
end; // IsLockKeyboard


// проверка: установлен ли хук на сообщения мыши
function IsLockMouse(): BOOL; stdcall; // export
begin
  if GShareInf <> nil then
    Result := GShareInf^.hMouseHook <> 0
  else
    Result := FALSE;
end; // IsLockMouse


// Установка хука на клавиатурные сообщения.
function LockKeyboard(hModule: HMODULE): BOOL; stdcall; // export
begin
  Result := FALSE;
  if GShareInf <> nil then begin

 {   if GShareInf^.hDebugHook = 0 then
      GShareInf^.hDebugHook :=
          SetWindowsHookEx(WH_DEBUG, @DebugProc, hModule, 0);
   }
    if GShareInf^.hLLKeyboardHook = 0 then
      GShareInf^.hLLKeyboardHook :=
          SetWindowsHookEx(WH_KEYBOARD_LL, @LLKeyProc, hModule, 0);

    // независимо от успеха установки низкоуровневого клавиатурного хука
    // пробуем установить обычный клавиатурный хук
    if GShareInf^.hKeyboardHook = 0 then begin
      GShareInf^.hKeyboardHook :=
          SetWindowsHookEx(WH_KEYBOARD, @KeyProc, hModule, 0);
      Result := GShareInf^.hKeyboardHook <> 0;
    end;

  end;

end; // LockKeyboard


// Снятие хука на клавиатурные сообщения.
// Возвращает TRUE, если удалось снять и низкоуровневый
// и обычный клавиатурный хук.
function UnlockKeyboard(): BOOL; stdcall; // export
var
  bUnhookLLKeySuccess : boolean;
  bUnhookKeySuccess   : boolean;
begin
  bUnhookLLKeySuccess := TRUE;
  bUnhookKeySuccess   := TRUE;

 { if GShareInf^.hDebugHook <> 0 then begin
    bUnhookLLKeySuccess := UnhookWindowsHookEx(GShareInf^.hDebugHook);
   	if bUnhookLLKeySuccess then
      GShareInf^.hDebugHook := 0;
  end;
   }
  if GShareInf^.hLLKeyboardHook <> 0 then begin
    bUnhookLLKeySuccess := UnhookWindowsHookEx(GShareInf^.hLLKeyboardHook);
    if bUnhookLLKeySuccess then
     	GShareInf^.hLLKeyboardHook := 0;
  end;

  if GShareInf^.hKeyboardHook <> 0 then begin
    bUnhookKeySuccess := UnhookWindowsHookEx(GShareInf^.hKeyboardHook);
    if bUnhookKeySuccess then
      GShareInf^.hKeyboardHook := 0;
  end;

  Result := bUnhookKeySuccess and bUnhookLLKeySuccess;

end; // UnlockKeyboard


// Установка хука на сообщения мыши
function LockMouse(hModule: HMODULE): BOOL; stdcall; // export
begin
  Result := FALSE;
  if GShareInf <> nil then
    if GShareInf^.hMouseHook = 0 then begin
      GShareInf^.hMouseHook :=
          SetWindowsHookEx(WH_MOUSE, @MouseProc, hModule, 0);
      Result := GShareInf^.hMouseHook <> 0;
    end;
end; // LockMouse


// Снятие хука на сообщения мыши
function UnlockMouse(): BOOL; stdcall; // export
begin
  Result := UnhookWindowsHookEx(GShareInf^.hMouseHook);
  if Result then
    GShareInf^.hMouseHook := 0;
end; // UnlockMouse


//установка хендла клиентского приложения
function SetClientHandle(hWindow: THandle): BOOL; stdcall; // export
var LPDtemp:LPDWORD;
begin
  LPDtemp:=nil;
  GShareInf^.dwProcessId := GetWindowThreadProcessId(hWindow,LPDtemp);
  Result := True;
end;


procedure DLLEntryPoint(dwReason: DWORD);
begin
  case dwReason Of
    DLL_PROCESS_ATTACH: begin

      //GShareInf^.dwProcessId := 0;
      GhMap := CreateFileMapping(INVALID_HANDLE_VALUE,
          nil, PAGE_READWRITE, 0, SizeOf(TShareInf), GLOBAL_MAP_ID);

      if GhMap <> 0 then
        GShareInf := MapViewOfFile(GhMap,
            FILE_MAP_ALL_ACCESS, 0, 0, SizeOf(TShareInf));
    end;

    DLL_PROCESS_DETACH: begin
      UnmapViewOfFile(GShareInf);
      CloseHandle(GhMap);
    end;

//		DLL_THREAD_ATTACH: ;

//		DLL_THREAD_DETACH: ;

  end; // case

end; // DLLEntryPoint

exports
  IsLockKeyboard,
  IsLockMouse,
  LockKeyboard,
  UnlockKeyboard,
  LockMouse,
  UnlockMouse,
  SetClientHandle;

begin

  DLLProc := @DLLEntryPoint;
  DLLEntryPoint(DLL_PROCESS_ATTACH);

end. ////////////////////////// end of file //////////////////////////////////

