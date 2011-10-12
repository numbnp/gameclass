//////////////////////////////////////////////////////////////////////////////
//
// Модуль содержит процедуры и функции для вывода на экран.
//
//////////////////////////////////////////////////////////////////////////////

unit uShowTextInAllVideoModes;

interface

  procedure ShowTextInAllVideoModesSwitchDesktops(AstrMessage : String; AnSec : Integer);
  procedure ShowTextInAllVideoModesBlinking(AstrMessage : String; AnSec : Integer);


//  procedure ShowText(AstrMessage : String);

implementation

uses
{$IFDEF MSWINDOWS}
  ExtCtrls,
  Controls,
  Windows,
  Graphics,
  Messages,
  Forms,
{$ENDIF}
{$IFDEF LINUX}
  QForms,
  QExtCtrls,
  QControls,
//    Windows,
  QGraphics,
{$ENDIF}
//  uDebugLog,
  Types;

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
{procedure ShowText(AstrMessage : String);
var
  hwndWindow:HWND;
  dcWindow:HDC;
  textMetric: TextMetricA;
  font: HWND;
  rectText: TRect;
  rectWindow: Trect;
  nHeigth, nWidtch: Integer;

begin
  rectText.Left := 0;
  rectText.Top := 0;
  rectText.Bottom := 0;
  rectText.Right := 0;

//  hwndWindow := GetForegroundWindow;
  hwndWindow := GetDesktopWindow;
//  HForegW := GetActiveWindow;
  GetWindowRect(hwndWindow,rectWindow);
  rectWindow.Left := (rectWindow.Right - rectWindow.Left) div 2 - 160;
  rectWindow.Right := rectWindow.Right - rectWindow.Left;
  rectWindow.Top := (rectWindow.Bottom - rectWindow.Top) div 2 - 120;
  rectWindow.Bottom := rectWindow.Bottom - rectWindow.Top;
  dcWindow := GetWindowDC(hwndWindow);
  font := CreateFont(20,6,0,0,0,0,0,0,RUSSIAN_CHARSET,OUT_DEFAULT_PRECIS,
      CLIP_DEFAULT_PRECIS,DEFAULT_QUALITY,DEFAULT_PITCH,Nil );
  SelectObject(dcWindow, font);
  if GetTextMetrics(dcWindow,TextMetric) then begin
    TextMetric.tmHeight := 20;//12;
//    SetTextM
  end;

  //SelectObject(HForegDC,GV_UAPIMFont);
  FillRect(dcWindow,rectWindow,0);
  DrawText(dcWindow,PChar(AstrMessage),Length(AstrMessage),rectText,DT_CALCRECT);
  nWidtch := ((rectWindow.Right - rectWindow.Left) -  rectText.Right) div 2;
  nHeigth := ((rectWindow.Bottom - rectWindow.Top) - rectText.Bottom) div 2;
  rectText.Left := rectWindow.Left + nWidtch;
  rectText.Top := rectWindow.Top + nHeigth;
  rectText.Right := rectWindow.Right - nWidtch;
  rectText.Bottom := rectWindow.Bottom - nHeigth;
  DrawText(dcWindow,PChar(AstrMessage),Length(AstrMessage),rectText,DT_CENTER);
end;}

{procedure ShowTextInAllVideoModesSwitchDesktops(AstrMessage : String;
    AnSec : Integer);
var
  input, desk: HDESK;
begin
  input := OpenInputDesktop(DF_ALLOWOTHERACCOUNTHOOK,FALSE,GENERIC_ALL);
  desk := CreateDesktop('test_d',0,0,DF_ALLOWOTHERACCOUNTHOOK,GENERIC_ALL,0);
  SwitchDesktop(desk);
  SetThreadDesktop(desk);
  ShowText(AstrMessage);
  Sleep(AnSec*1000);
  SwitchDesktop(input);
  CloseDesktop(desk);
  CloseDesktop(input);
end;}

{procedure ShowTextInAllVideoModesBlinking(AstrMessage : String; AnSec : Integer);
var
  i: Integer;
  hwndWindow:HWND;
  rectWorkArea: TRect;
begin
  hwndWindow := GetDesktopWindow;
  //показываем 25 раз в сек.
  for i := 0 to AnSec*25 do begin
    ShowText(AstrMessage);
    Sleep(40);
  end;
  rectWorkArea := Rect(0, 0, GetSystemMetrics(SM_CXSCREEN), GetSystemMetrics(SM_CYSCREEN));
  RedrawWindow(0, @rectWorkArea, 0,
      RDW_FRAME + RDW_INVALIDATE + RDW_ALLCHILDREN + RDW_NOINTERNALPAINT);
end;}

procedure WriteDC(s: string);
var
  c: TCanvas;
begin
  c := TCanvas.Create;
  c.Brush.Color := clBlue;
  c.Font.color := clYellow;
  c.Font.name := 'Arial';
  c.Font.Size := 32;
  c.Handle := GetDC(0);
  c.TextOut(round((screen.Width - c.TextWidth(s))/2), round((screen.Height - c.TextHeight(s))/2), s);
  c.free;
end;

procedure ShowTextInAllVideoModesSwitchDesktops(AstrMessage : String;
    AnSec : Integer);
begin
  ShowTextInAllVideoModesBlinking(AstrMessage, AnSec);
end;

procedure ShowTextInAllVideoModesBlinking(AstrMessage : String; AnSec : Integer);
var
  i: Integer;
begin
  for i := 0 to AnSec*50 do begin
    WriteDC(AstrMessage);
    Sleep(20);
  end;
end;



end.
