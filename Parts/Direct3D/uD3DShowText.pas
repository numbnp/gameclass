//////////////////////////////////////////////////////////////////////////////
//
//   Вывод текстового сообщения в Direct3D режиме
//
//////////////////////////////////////////////////////////////////////////////

unit uD3DShowText;

interface

procedure UAPIMessageBox(mess:string;FrameCount:integer);
procedure WriteDC(s: string);

var
  Flag:Boolean;

implementation
  uses
    // system units
    Controls,
    Windows,
    ExtCtrls,
    Graphics,
    Forms;

var
  GV_UAPIMMessage: String = 'Test';
  Timer_UAPIMess: TTimer = Nil;
  GV_UAPIMCount: Integer;

  BlikTimer: THandle;  //Таймер отрисовки
  MainTimer: THandle;  //Таймер слежения

  TextCanvas: TCanvas;


procedure MainTimer_UAPIMessTimer;
begin
  dec(GV_UAPIMCount);
  if GV_UAPIMCount<1 then
  begin
    KillTimer(0,BlikTimer);
    TextCanvas.free;
    KillTimer(0,MainTimer);
    Flag:= True;
  end;
end;

procedure Timer_UAPIMessTimer;
begin
  WriteDC(GV_UAPIMMessage);
end;

procedure WriteDC(s: string);
begin
  // Выводим текст
  //  c.TextOut(round((screen.Width - TextCanvas.TextWidth(s))/2), round((screen.Height - TextCanvas.TextHeight(s))/2), s);
  TextCanvas.TextOut(round((screen.Width - TextCanvas.TextWidth(s))/2), 2, s);
end;

procedure UAPIMessageBox(mess:string;FrameCount:integer);
begin
  //Подготавливаем надпись
  TextCanvas := TCanvas.Create;
  TextCanvas.Brush.Color := clBlue;
  TextCanvas.Font.color := clYellow;
  TextCanvas.Font.name := 'Arial';
  TextCanvas.Font.Size := 32;
  TextCanvas.Handle := GetDC(GetParent(GetDesktopWindow));

  GV_UAPIMCount := FrameCount;
  GV_UAPIMMessage := mess;

  Flag := False;

  //Запускаем таймеры
  BlikTimer := SetTimer(0,0,1,@Timer_UAPIMessTimer);
  MainTimer := SetTimer(0,0,1000,@MainTimer_UAPIMessTimer);
end;


end.

