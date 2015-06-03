//////////////////////////////////////////////////////////////////////////////
//
// TModernToolTip - класс, инкапсулирующий в себе работу со всплывающими
// подсказками в Win 2000. При создании объекта класса создается balloon-
// подсказка c заданными параметрами.
//
//
// Примечания:
// - по умолчанию, сразу после создания, всплывающая подсказка активна;
// - в заголовке всплывающей подсказки не допускается
//   использование переноса строк.
//
//////////////////////////////////////////////////////////////////////////////

unit uModernToolTip;

interface

uses
  // system units
  Windows,
  Messages,
  Controls,
  Graphics,
  CommCtrl;


type

  // иконка возле заголовка всплывающей подсказки
  TToolTipIcon = (
      ToolTipIcon_None,
      ToolTipIcon_Info,
      ToolTipIcon_Warning,
      ToolTipIcon_Error
  );


  //
  // TModernToolTip
  //

  TModernToolTip = class(TObject)
  private
    // fields
    FToolInfo: TToolInfo;
    FhWnd: THandle;
    FhControlWnd: THandle;
    FbActive: Boolean;
    FstrTitle: String;
    FstrText: String;
    FToolTipIcon: TToolTipIcon;
    FclrBackground: TColor;
    FclrText: TColor;
    FnTimeoutMS: Cardinal;

    // private helper methods
    function _ConvertToolTipIconToInteger(
        const AToolTipIcon: TToolTipIcon): Integer;

  protected
    // properties methods
    procedure SetActive(const AbActive: Boolean);

    procedure SetTitle(const AstrTitle: String);

    procedure SetText(const AstrText: String);

    procedure SetToolTipIcon(const AToolTipIcon: TToolTipIcon);

    procedure SetBackgroundColor(const AclrBackground: TColor);

    procedure SetTextColor(const AclrText: TColor);

    procedure SetTimeoutMS(const AnTimeoutMS: Cardinal);

  public
    // constructor / destructor
    constructor Create(const AhControlWnd: THandle;
        const AstrTitle: String; const AstrText: String;
        const AToolTipIcon: TToolTipIcon = ToolTipIcon_None;
        const AnTimeoutMS: Cardinal = 1000);
    destructor Destroy(); override;

    // public methods
    procedure Activate();
    procedure Deactivate();

    // properties
    property Active: Boolean read FbActive write SetActive;
    property Title: String read FstrTitle write SetTitle;
    property Text: String read FstrText write SetText;
    property ToolTipIcon: TToolTipIcon
        read FToolTipIcon write SetToolTipIcon;
    property BackgroundColor: TColor
        read FclrBackground write SetBackgroundColor;
    property TextColor: TColor read FclrText write SetTextColor;
    property TimeoutMS: Cardinal read FnTimeoutMS write SetTimeoutMS;

  end; // TModernToolTip


implementation

const
  // значения по умолчанию
  ACTIVE_DEF = TRUE;


  // константа для наглядности работы с хэндлами
  NULL_HANDLE = 0;


  // ToolTip Icons
  TTI_NONE = 0;
  TTI_INFO = 1;
  TTI_WARNING = 2;
  TTI_ERROR = 3;


  // Константы, описанные в Win 2000 SDK (commctrl.h).
  // Отсутсвуют в стандартных бибилотеках Delphi 7.
  TOOLTIP_CLASS = 'Tooltips_Class32';
  TTS_BALLOON = $40;
  TTM_SETTITLE = (WM_USER + 32);
  TTM_POPUP = (WM_USER + 34);


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// cosnstructor / destructor

constructor TModernToolTip.Create(const AhControlWnd: THandle;
    const AstrTitle: String; const AstrText: String;
    const AToolTipIcon: TToolTipIcon = ToolTipIcon_None;
    const AnTimeoutMS: Cardinal = 1000);
var
  nIcon: Integer;
begin
  inherited Create();

  FbActive := ACTIVE_DEF;
  FstrTitle := AstrTitle;
  FstrText := AstrText;
  FToolTipIcon := AToolTipIcon;
  FnTimeoutMS := AnTimeoutMS;
  FhControlWnd := AhControlWnd;

  FhWnd := CreateWindow(TOOLTIPS_CLASS, nil,
    WS_POPUP or TTS_NOPREFIX or TTS_BALLOON or TTS_ALWAYSTIP,
    0, 0, 0, 0, FhControlWnd, 0, hInstance, nil);

  if FhWnd <> NULL_HANDLE then begin
    SetWindowPos(FhWnd, HWND_TOPMOST, 0, 0, 0, 0,
      SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
    FToolInfo.cbSize := SizeOf(FToolInfo);
    FToolInfo.uFlags := TTF_TRANSPARENT or TTF_SUBCLASS;
    FToolInfo.hWnd := FhControlWnd;
    FToolInfo.lpszText := PChar(FstrText);
    GetClientRect(FhControlWnd, FToolInfo.Rect);
    nIcon := _ConvertToolTipIconToInteger(FToolTipIcon);

    SendMessage(FhWnd, TTM_ADDTOOL, 0, Integer(@FToolInfo));
    SendMessage(FhWnd, TTM_SETDELAYTIME, TTDT_AUTOMATIC, FnTimeoutMS);
    SendMessage(FhWnd, TTM_SETTITLE, nIcon, Integer(PChar(FstrTitle)));
    SendMessage(FhWnd, TTM_ACTIVATE, Integer(FbActive), 0);
  end;
end; // TModernToolTip.Create


destructor TModernToolTip.Destroy();
begin
  if FhWnd <> NULL_HANDLE then begin
    SendMessage(FhWnd, TTM_DELTOOL, 0, Integer(@FToolInfo));
  end;

  inherited Destroy();

end; // TModernToolTip.Destroy


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TModernToolTip.Activate();
begin
  Active := TRUE;
end; // TModernToolTip.Activate


procedure TModernToolTip.Deactivate();
begin
  Active := FALSE;
end; // TModernToolTip.Deactivate


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// properties methods

procedure TModernToolTip.SetActive(const AbActive: Boolean);
begin
  FbActive := AbActive;
  if FhWnd <> NULL_HANDLE then begin
    SendMessage(FhWnd, TTM_ACTIVATE, Integer(FbActive), 0);
  end;
end; // TModernToolTip.SetActive


procedure TModernToolTip.SetTitle(const AstrTitle: String);
var
  nIcon: Integer;
begin
  FstrTitle := AstrTitle;
  if FhWnd <> NULL_HANDLE then begin
    nIcon := _ConvertToolTipIconToInteger(FToolTipIcon);
    SendMessage(FhWnd, TTM_SETTITLE, nIcon, Integer(PChar(FstrTitle)));
  end;
end; // TModernToolTip.SetTitle


procedure TModernToolTip.SetText(const AstrText: String);
begin
  FstrText := AstrText;
  if FhWnd <> NULL_HANDLE then begin
    FToolInfo.lpszText := PChar(FstrText);
    SendMessage(FhWnd, TTM_SETTOOLINFO, 0, Integer(@FToolInfo));
  end;
end; // TModernToolTip.SetText


procedure TModernToolTip.SetToolTipIcon(const AToolTipIcon: TToolTipIcon);
var
  nIcon: Integer;
begin
  FToolTipIcon := AToolTipIcon;
  if FhWnd <> NULL_HANDLE then begin
    nIcon := _ConvertToolTipIconToInteger(FToolTipIcon);
    SendMessage(FhWnd, TTM_SETTITLE, nIcon, Integer(PChar(FstrTitle)));
  end;
end; // TModernToolTip.SetToolTipIcon


procedure TModernToolTip.SetBackgroundColor(const AclrBackground: TColor);
begin
  FclrBackground := AclrBackground;
  if FhWnd <> NULL_HANDLE then begin
    SendMessage(FhWnd, TTM_SETTIPBKCOLOR, FclrBackground, 0);
  end;
end; // TModernToolTip.SetBackgroundColor


procedure TModernToolTip.SetTextColor(const AclrText: TColor);
begin
  FclrText := AclrText;
  if FhWnd <> NULL_HANDLE then begin
    SendMessage(FhWnd, TTM_SETTIPTEXTCOLOR, FclrText, 0);
  end;
end; // TModernToolTip.SetTextColor


procedure TModernToolTip.SetTimeoutMS(const AnTimeoutMS: Cardinal);
begin
  FnTimeoutMS := AnTimeoutMS;
  if FhWnd <> NULL_HANDLE then begin
    SendMessage(FhWnd, TTM_SETDELAYTIME, TTDT_AUTOMATIC, FnTimeoutMS);
  end;
end; // TModernToolTip.SetTimeoutMS


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private helper methods

function TModernToolTip._ConvertToolTipIconToInteger(
    const AToolTipIcon: TToolTipIcon): Integer;
begin
  case AToolTipIcon of
    ToolTipIcon_Info: begin
      Result := TTI_INFO;
    end;

    ToolTipIcon_Warning: begin
      Result := TTI_WARNING;
    end;

    ToolTipIcon_Error: begin
      Result := TTI_ERROR;
    end;

    else begin
      Result := TTI_NONE;
    end;

  end;
end; // TModernToolTip._ConvertToolTipIconToInteger


end.
