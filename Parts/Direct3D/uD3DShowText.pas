//////////////////////////////////////////////////////////////////////////////
//
//   Вывод текстового сообщения в Direct3D режиме
//
//////////////////////////////////////////////////////////////////////////////

unit uD3DShowText;

interface

procedure UAPIMessageBoxOut;
procedure UAPIMessageBox(mess:string;Left,Top,FrameCount:integer);

implementation
  uses
    // system units
    Controls,
    Windows,ExtCtrls;

var
  GV_UAPIMRegion: TRect;
  GV_UAPIMRegionS: TRect;
  GV_UAPIMBrush: HBRUSH;
  GV_UAPIMFont: HFONT;
  GV_UAPIMMessage: String = 'Test';
  Timer_UAPIMess: TTimer = Nil;
   GV_UAPIMCount: Integer;
procedure Timer_UAPIMessTimer(Sender: TObject);
begin
  dec(GV_UAPIMCount);
  Timer_UAPIMess.Enabled := (GV_UAPIMCount>0);
  UAPIMessageBoxOut;
end;


procedure UAPIMessageBoxOut;
var
  HForegW:HWND;
  HForegDC:HDC;
begin
  GV_UAPIMRegion.Left := 0;
  GV_UAPIMRegion.Top := 0;
  GV_UAPIMRegion.Bottom := 200;
  GV_UAPIMRegion.Right := 600;
  GV_UAPIMRegionS.Left := 0;
  GV_UAPIMRegionS.Top := 0;
  GV_UAPIMRegionS.Bottom := 200;
  GV_UAPIMRegionS.Right := 600;
  HForegW := GetForegroundWindow;
  HForegW := GetDesktopWindow;
  HForegDC := GetWindowDC(HForegW);
  GetClipBox(HForegDC,GV_UAPIMRegion);
  GetClipBox(HForegDC,GV_UAPIMRegions);
  FillRect(HForegDC,GV_UAPIMRegion,0);

  FrameRect(HForegDC,GV_UAPIMRegion,GV_UAPIMBrush);
  FrameRect(HForegDC,GV_UAPIMRegionS,GV_UAPIMBrush);
  SelectObject(HForegDC,GV_UAPIMFont);
  DrawText(HForegDC,PChar(GV_UAPIMMessage),Length(GV_UAPIMMessage),GV_UAPIMRegionS,DT_CENTER+DT_VCENTER+DT_SINGLELINE);
end;

procedure UAPIMessageBox(mess:string;Left,Top,FrameCount:integer);
begin
 { if Timer_UAPIMess = Nil then begin
    Timer_UAPIMess := TTimer.Create(Nil);
    Timer_UAPIMess.OnTimer := Timer_UAPIMessTimer;
  end;}
  GV_UAPIMBrush := CreateSolidBrush(RGB(255,0,0));
  GV_UAPIMCount := FrameCount;
  GV_UAPIMMessage := mess;
//  Timer_UAPIMess.Enabled := (GV_UAPIMMessage<>'');
end;






end.
