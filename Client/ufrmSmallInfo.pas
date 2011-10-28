//////////////////////////////////////////////////////////////////////////////
//
//  Класс формы приложения, преднозначеный для отображение интервала
//  времени, оставшегося до конца работы за компъютером.
//
//////////////////////////////////////////////////////////////////////////////

unit ufrmSmallInfo;

interface

uses
  // system units
{$IFDEF MSWINDOWS}
  Windows,
  Messages,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  ExtCtrls,
{$ENDIF}
{$IFDEF LINUX}
  QT,
  QForms,
  QDialogs,
  QStdCtrls,
  QControls,
  QTypes,
  QExtCtrls,
  QGraphics,
{$ENDIF}
  SysUtils,
  Variants,
  Classes,
  SyncObjs;
  // project units


type

  //
  // TfrmSmallInfo
  //

  TfrmSmallInfo = class(TForm)
    tmrRedraw: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure tmrRedrawTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDblClick(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

  private
    // fields
    FbBeforeFirstFormShow: Boolean;
    FdtStart: TDateTime;
    FdtStop: TDateTime;
    FdtNowTime: TDateTime;
    FbUseTraffic: Boolean;
    FnTrafficInKBAvailable: Integer;
    FnTrafficInKBUsed: Integer;
    FbMoving: Boolean;
    FnOldX, FnOldY: Integer;
    // private helper methods
    procedure _DrawTime();
{$IFDEF MSWINDOWSDISABLE}
    procedure _WMLButtonDown(var Msg: TMessage); message WM_LBUTTONDOWN;
    procedure _WMLButtonDBLCLK(var Msg: TMessage); message WM_LBUTTONDBLCLK;
    procedure _WMRButtonDown(var Msg: TMessage); message WM_RBUTTONDOWN;
{$ENDIF}

  public
    // public methods
    procedure Show;
    procedure UpdateInfo(
        const AdtStart: TDateTime; const AdtStop: TDateTime;
        const AdtNowTime: TDateTime;
        const AbUseTraffic: Boolean; const AnTrafficInKBAvailable: Integer;
        const AnTrafficInKBUsed: Integer);
    procedure Clear;

  end; // TfrmSmallInfo

var
  frmSmallInfo: TfrmSmallInfo;

implementation

{$IFDEF MSWINDOWS}
  {$R *.dfm}
{$ENDIF}
{$IFDEF LINUX}
  {$R *.xfm}
{$ENDIF}

uses
  // system units
  Types,
  DateUtils,
  // project units
  uDebugLog,
  Math,
  uSafeStorage,
  uClientConst,
  ufrmMain,
  uCrossPlatformWindow;

const
  DRAW_TIMER_OFFSET = 10;
  SIZE_WND = 80;
  SIZE_CENTER_WND = 40;
  SIZE_SECTOR = 8;

  CIRCLE_X_OFFSET = 7;
  CIRCLE_Y_OFFSET = 2;
  TRAFFIC_INFO_HEIGHT = 22;
  TRAFFIC_INFO_ADD_WIDTH = 10;
  CLIENT_HEIGHT = 80;
  CLIENT_WIDTH = 70;
  TEXT_HEIGHT = 10;
  BAR_OFFSET = 2;
  BAR_HEIGHT = 10;

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// TfrmSmallInfo


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods
procedure TfrmSmallInfo.Show;
begin
  if FbBeforeFirstFormShow then begin
    frmMain.InitializeApplicationWindows;
    Application.NormalizeTopMosts;
{$IFDEF LINUX}
    BorderStyle := fbsNone;
{$ENDIF}
    FormStyle := fsStayOnTop;
    FbBeforeFirstFormShow := False;
  end;
  inherited Show;
{$IFDEF MSWINDOWS}
  ShowWindow(Application.Handle,SW_HIDE);  // Скрываем программу в таскбаре
{$ENDIF}
end;

procedure TfrmSmallInfo.FormCreate(Sender: TObject);
begin
  FbMoving := False;
  FbBeforeFirstFormShow := True;
  Clear;
end; // TfrmSmallInfo.FormCreate


procedure TfrmSmallInfo.FormClose(
    Sender: TObject; var Action: TCloseAction);
begin
  tmrRedraw.Enabled := FALSE;

end; // TfrmSmallInfo.FormClose


procedure TfrmSmallInfo.FormDestroy(Sender: TObject);
begin
//  FreeAndNil(FcsDrawEndOfUptime);
end; // TfrmSmallInfo.FormDestroy


procedure TfrmSmallInfo.FormPaint(Sender: TObject);
begin
  _DrawTime();
end; // TfrmSmallInfo.FormPaint

procedure TfrmSmallInfo.Clear;
begin
  Height := CLIENT_HEIGHT;
  Width := CLIENT_WIDTH;
  FdtStart := 0;
  FdtStop := 0;
  FbUseTraffic := False;
  FnTrafficInKBAvailable := 0;
  FnTrafficInKBUsed := 0;
  tmrRedraw.Enabled := False;
{  Top := GetSystemMetrics(SM_CYFULLSCREEN)
      + GetSystemMetrics(SM_CYCAPTION) - CLIENT_HEIGHT
      - TRAFFIC_INFO_HEIGHT;
  Left  := GetSystemMetrics(SM_CXFULLSCREEN) - CLIENT_WIDTH
      - TRAFFIC_INFO_ADD_WIDTH;
}
  Top := Screen.Height
      - GetTaskBarHeight
      - CLIENT_HEIGHT
      - TRAFFIC_INFO_HEIGHT;
  Left  := Screen.Width - CLIENT_WIDTH
      - TRAFFIC_INFO_ADD_WIDTH;

  Invalidate;
end; // TfrmSmallInfo.FormCreate

procedure TfrmSmallInfo.UpdateInfo(
    const AdtStart: TDateTime; const AdtStop: TDateTime;
    const AdtNowTime: TDateTime;
    const AbUseTraffic: Boolean; const AnTrafficInKBAvailable: Integer;
    const AnTrafficInKBUsed: Integer);
begin

  FdtStart := AdtStart;
  FdtStop := AdtStop;
  FdtNowTime := AdtNowTime;
  FbUseTraffic := AbUseTraffic;
  FnTrafficInKBAvailable := AnTrafficInKBAvailable;
  FnTrafficInKBUsed := AnTrafficInKBUsed;

  if FbUseTraffic then begin
    Height := CLIENT_HEIGHT + TRAFFIC_INFO_HEIGHT;
    Width := CLIENT_WIDTH + TRAFFIC_INFO_ADD_WIDTH;
  end else begin
    Height := CLIENT_HEIGHT;
    Width := CLIENT_WIDTH;
  end;

  if not tmrRedraw.Enabled then begin
    tmrRedraw.Enabled := TRUE;
  end;
  SELF.Invalidate;
end; // TfrmSmallInfo.UpdateTimer


procedure TfrmSmallInfo.tmrRedrawTimer(Sender: TObject);
begin
  SELF.Invalidate;
end; // TfrmSmallInfo.tmrEndOfUptimeSecondTimer


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private helper methods

procedure TfrmSmallInfo._DrawTime();
var
  X1, X2, Y1, Y2: integer;
  rectBorder: TRect;
  rectCircle: TRect;
  pointCenter, pointText: TPoint;
  nHeight, nWidtch: integer;
  AstrInfo, AstrTime: String;
  fAngle: Double;
  nDx, nDy, nRadius: Integer;
  fUsedTimePercent, fUsedTrafficPercent: Double;

begin

  with rectCircle do begin
    if FbUseTraffic then begin
      Left := CIRCLE_X_OFFSET;
      Right := Width - CIRCLE_X_OFFSET;
      Top := TEXT_HEIGHT + CIRCLE_Y_OFFSET;
      Bottom := CLIENT_HEIGHT - CIRCLE_Y_OFFSET;
    end else begin
      Left := CIRCLE_Y_OFFSET + 1;
      Right := Width - CIRCLE_Y_OFFSET - 1;
      Top := TEXT_HEIGHT + CIRCLE_Y_OFFSET + 1;
      Bottom := CLIENT_HEIGHT - CIRCLE_Y_OFFSET - 1;
    end;
  end;
  nHeight := rectCircle.Right - rectCircle.Left;
  nWidtch := rectCircle.Bottom - rectCircle.Top;
  nRadius := nWidtch div 2;
  with pointCenter do begin
    X := rectCircle.Left + nWidtch div 2;
    Y := rectCircle.Top + nHeight div 2;
  end;

  if (FdtStart = 0) then
    fUsedTimePercent := 1
  else begin
    if (FdtNowTime > FdtStop) or (FdtNowTime < FdtStart) then begin
      if (FdtNowTime > FdtStop) then
        fUsedTimePercent := 1
      else
        fUsedTimePercent := 0;
    end else
      fUsedTimePercent := (FdtNowTime-FdtStart)/(FdtStop - FdtStart);
  end;
  if (FnTrafficInKBAvailable > 0) then
    fUsedTrafficPercent := FnTrafficInKBUsed/FnTrafficInKBAvailable
  else
    fUsedTrafficPercent := 0;

  fAngle := fUsedTimePercent*2*Pi;
  nDx := Round(Sin(fAngle)*nRadius);
  nDy := Round(Cos(fAngle)*nRadius);

  // Для того, чтобы в начеале и в конце не моргали круги
  // сдвигаем на пиксел точку на радиусе
  if (fUsedTimePercent > 0) and (fUsedTimePercent < 1)
      and (nDx = 0) and (nDy = nRadius) then begin
    if (fUsedTimePercent > 0.5) then
      nDx := -1
    else
      nDx := 1;
  end;

  X1 := pointCenter.X;
  Y1 := rectCircle.Top;

  X2 := pointCenter.X + nDx;
  Y2 := pointCenter.Y - nDy;
  with Canvas do begin
{$IFDEF LINUX}
//Сделать полупрозрачность
//    Pen.
{$ENDIF}
    Pen.Color := clBlack;
    Brush.Color := clBtnFace;
    Font.Color := clBlack;
    // Рисуем прямоугольную рамку вокруг кругового таймера.
    rectBorder := Rect(0, 0, Width, Height);
    Canvas.Rectangle(rectBorder);
    MoveTo(0, TEXT_HEIGHT - 1);
    LineTo(Width, TEXT_HEIGHT - 1);
    if (FdtStart = 0) then
      AstrInfo := ''
    else begin
      DateTimeToString(AstrInfo,'hh:mm',(FdtNowTime-FdtStart));
      DateTimeToString(AstrTime,'hh:mm',(FdtStop-FdtStart));
      AstrInfo := AstrInfo + ' / ' + AstrTime;
    end;
    rectBorder := Rect(0, 0, Width, TEXT_HEIGHT);
{$IFDEF MSWINDOWS}
    DrawText(Handle,PChar(AstrInfo),Length(AstrInfo),rectBorder,DT_CENTER);
{$ENDIF}
{$IFDEF LINUX}
//    Brush.Color := clWhite;
//    Canvas.TextOut(rectBorder.Left, rectBorder.Top, AstrInfo);
//    Rectangle(rectBorder.Left, rectBorder.Top,
//        rectBorder.Right, rectBorder.Bottom);
    Canvas.TextRect(rectBorder, rectBorder.Left, rectBorder.Top, AstrInfo,
        Integer(AlignmentFlags_AlignHCenter) +
        Integer(AlignmentFlags_AlignVCenter));

{$ENDIF}

    // Рисуем сектор отработанного времени.
    Pen.Color := clPurple;
    Brush.Color := clPurple;
    nRadius := Round(5760 * fUsedTimePercent);
    If (fUsedTimePercent <> 0) then
{$IFDEF MSWINDOWS}
      Pie(rectCircle.Left, rectCircle.Top, rectCircle.Right, rectCircle.Bottom,
          X2, Y2, X1, Y1);
{$ENDIF}
{$IFDEF LINUX}
      Pie(rectCircle.Left, rectCircle.Top, rectCircle.Right - rectCircle.Left,
          rectCircle.Bottom - rectCircle.Top,
          1440, -nRadius);
{$ENDIF}
    Pen.Color := clBlue;
    Brush.Color := clBlue;
    If (fUsedTimePercent <> 1) then
{$IFDEF MSWINDOWS}
      Pie(rectCircle.Left, rectCircle.Top, rectCircle.Right, rectCircle.Bottom,
          X1, Y1, X2, Y2);
{$ENDIF}
{$IFDEF LINUX}
      Pie(rectCircle.Left, rectCircle.Top, rectCircle.Right - rectCircle.Left,
          rectCircle.Bottom - rectCircle.Top,
          1440 - nRadius, -5760 + nRadius);
{$ENDIF}
    // Рисуем условные сектора, делящие круг на четыре части.
    Pen.Color := clBlack;
    Brush.Color := clBtnFace;
    Rectangle(pointCenter.X - 1, rectCircle.Top,
        pointCenter.X + 1, rectCircle.Top + SIZE_SECTOR);
    Rectangle(pointCenter.X - 1, rectCircle.Bottom,
        pointCenter.X + 1, rectCircle.Bottom - SIZE_SECTOR);
    Rectangle(rectCircle.Left, pointCenter.Y - 1,
        rectCircle.Left + SIZE_SECTOR, pointCenter.Y + 1);
    Rectangle(rectCircle.Right, pointCenter.Y - 1,
        rectCircle.Right - SIZE_SECTOR, pointCenter.Y + 1);
    if not FbUseTraffic then
      exit;
    // Рисуем прямоугольную рамку вокруг кругового таймера.
    Pen.Color := clBlack;
    Brush.Color := clBtnFace;
    MoveTo(0,CLIENT_HEIGHT);
    LineTo(Width,CLIENT_HEIGHT);
    MoveTo(0,CLIENT_HEIGHT+TEXT_HEIGHT);
    LineTo(Width,CLIENT_HEIGHT+TEXT_HEIGHT);
    if (FnTrafficInKBAvailable = 0) then begin
      if (FnTrafficInKBUsed <= 999) then
        AstrInfo := IntToStr(FnTrafficInKBUsed)
            + 'KByte'
      else
        AstrInfo := FloatToStrF(FnTrafficInKBUsed/1024,ffNumber,7,1)
            + 'MByte';
    end else begin
      if (FnTrafficInKBAvailable <= 999) then
        AstrInfo := IntToStr(FnTrafficInKBUsed)
            + 'KB / ' + IntToStr(FnTrafficInKBAvailable)
            + 'KB'
      else if (FnTrafficInKBAvailable <= 10240) then
        AstrInfo := FloatToStrF(FnTrafficInKBUsed/1024,ffNumber,7,1)
            + 'MB / ' + FloatToStrF(FnTrafficInKBAvailable/1024,ffNumber,7,1)
            + 'MB'
      else if (FnTrafficInKBAvailable <= 102400) then
        AstrInfo := FloatToStrF(FnTrafficInKBUsed/1024,ffNumber,7,1)
            + ' / ' + FloatToStrF(FnTrafficInKBAvailable/1024,ffNumber,7,1)
            + 'MB'
      else
        AstrInfo := FloatToStrF(FnTrafficInKBUsed/1024,ffNumber,7,1)
            + '/' + FloatToStrF(FnTrafficInKBAvailable/1024,ffNumber,7,1)
            + 'MB';
    end;
//    rectBorder := Rect(0, 0, Width, TIME_HEIGHT);
    rectBorder := Rect(0, CLIENT_HEIGHT+1, Width, CLIENT_HEIGHT+TEXT_HEIGHT);
    Pen.Color := clBlack;
    Brush.Color := clBtnFace;
    Font.Color := clBlack;
{$IFDEF MSWINDOWS}
    DrawText(Handle,PChar(AstrInfo),Length(AstrInfo),rectBorder,DT_CENTER);
{$ENDIF}
{$IFDEF LINUX}
//    Rectangle(rectBorder.Left, rectBorder.Top,
//        rectBorder.Right, rectBorder.Bottom);
//    Canvas.TextOut(rectBorder.Left + 8, rectBorder.Top, AstrInfo);
    Canvas.TextRect(rectBorder, rectBorder.Left, rectBorder.Top, AstrInfo,
        Integer(AlignmentFlags_AlignHCenter) +
        Integer(AlignmentFlags_AlignVCenter));
{$ENDIF}

    nDx := Trunc((Width - 2*BAR_OFFSET)*fUsedTrafficPercent);
    Pen.Color := clBlue;
    Brush.Color := clBlue;
    Rectangle(BAR_OFFSET + nDx, Height - BAR_HEIGHT,
        Width - BAR_OFFSET, Height - BAR_OFFSET);
    Pen.Color := clPurple;
    Brush.Color := clPurple;
    Rectangle(BAR_OFFSET, Height - BAR_HEIGHT,
        BAR_OFFSET + nDx, Height - BAR_OFFSET);
  End;
end; // TfrmSmallInfo._DrawTimer


procedure TfrmSmallInfo.FormDblClick(Sender: TObject);
begin
  TSafeStorage.Instance().Push(ThreadSafeOperation_MainFormAction,
      Integer(FormAction_Show));
end;

procedure TfrmSmallInfo.FormMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FnOldX := X;
  FnOldY := Y;
  if Button = mbLeft then
    FbMoving := true;
end;

procedure TfrmSmallInfo.FormMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  if FbMoving then begin
    Left := Left + X - FnOldX;
    Top  := Top  + Y - FnOldY;
  end;
end;

procedure TfrmSmallInfo.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
    FbMoving := false;
end;

initialization
  frmSmallInfo := Nil;


end. ////////////////////////// end of file //////////////////////////////////
