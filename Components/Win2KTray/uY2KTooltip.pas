unit uY2KTooltip;


interface

uses  
   Commctrl;  


implementation

const  
  TTS_BALLOON    = $40;  
  TTM_SETTITLE = (WM_USER + 32);  

var  
  hTooltip: Cardinal;  
  ti: TToolInfo;  
  buffer : array[0..255] of char;  


procedure CreateToolTips(hWnd: Cardinal);  
begin  
  hToolTip := CreateWindowEx(0, 'Tooltips_Class32', nil, TTS_ALWAYSTIP or TTS_BALLOON,  
    Integer(CW_USEDEFAULT), Integer(CW_USEDEFAULT), Integer(CW_USEDEFAULT),  
    Integer(CW_USEDEFAULT), hWnd, 0, hInstance, nil);  
  if hToolTip <> 0 then  
  begin  
    SetWindowPos(hToolTip, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE or  
      SWP_NOSIZE or SWP_NOACTIVATE);  
    ti.cbSize := SizeOf(TToolInfo);  
    ti.uFlags := TTF_SUBCLASS;  
    ti.hInst  := hInstance;  
  end;  
end;  

procedure AddToolTip(hwnd: DWORD; lpti: PToolInfo; IconType: Integer;  
  Text, Title: PChar);  
var  
  Item: THandle;  
  Rect: TRect;  
begin  
  Item := hWnd;  
  if (Item <> 0) and (GetClientRect(Item, Rect)) then  
  begin  
    lpti.hwnd := Item;  
    lpti.Rect := Rect;  
    lpti.lpszText := Text;  
    SendMessage(hToolTip, TTM_ADDTOOL, 0, Integer(lpti));  
    FillChar(buffer, SizeOf(buffer), #0);  
    lstrcpy(buffer, Title);  
    if (IconType > 3) or (IconType < 0) then IconType := 0;  
    SendMessage(hToolTip, TTM_SETTITLE, IconType, Integer(@buffer));  
  end;  
end;  


procedure ShowBalloonTip(Control: TWinControl; Icon: integer; Title: pchar; Text: PWideChar;  
BackCL, TextCL: TColor);  
const  
  TOOLTIPS_CLASS = 'tooltips_class32';  
  TTS_ALWAYSTIP = $01;  
  TTS_NOPREFIX = $02;  
  TTS_BALLOON = $40;  
  TTF_SUBCLASS = $0010;  
  TTF_TRANSPARENT = $0100;  
  TTF_CENTERTIP = $0002;  
  TTM_ADDTOOL = $0400 + 50;  
  TTM_SETTITLE = (WM_USER + 32);  
  ICC_WIN95_CLASSES = $000000FF;  
type  
  TOOLINFO = packed record  
    cbSize: Integer;  
    uFlags: Integer;  
    hwnd: THandle;  
    uId: Integer;  
    rect: TRect;  
    hinst: THandle;  
    lpszText: PWideChar;  
    lParam: Integer;  
  end;  
var  
  hWndTip: THandle;  
  ti: TOOLINFO;  
  hWnd: THandle;  
begin  
  hWnd    := Control.Handle;  
  hWndTip := CreateWindow(TOOLTIPS_CLASS, nil,  
    WS_POPUP or TTS_NOPREFIX or TTS_BALLOON or TTS_ALWAYSTIP,  
    0, 0, 0, 0, hWnd, 0, HInstance, nil);  
  if hWndTip <> 0 then  
  begin  
    SetWindowPos(hWndTip, HWND_TOPMOST, 0, 0, 0, 0,  
      SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);  
    ti.cbSize := SizeOf(ti);  
    ti.uFlags := TTF_CENTERTIP or TTF_TRANSPARENT or TTF_SUBCLASS;  
    ti.hwnd := hWnd;  
    ti.lpszText := Text;  
    Windows.GetClientRect(hWnd, ti.rect);  
    SendMessage(hWndTip, TTM_SETTIPBKCOLOR, BackCL, 0);  
    SendMessage(hWndTip, TTM_SETTIPTEXTCOLOR, TextCL, 0);  
    SendMessage(hWndTip, TTM_ADDTOOL, 1, Integer(@ti));  
    SendMessage(hWndTip, TTM_SETTITLE, Icon mod 4, Integer(Title));  
  end;  
end;  


end.