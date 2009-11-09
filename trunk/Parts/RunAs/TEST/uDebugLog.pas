//////////////////////////////////////////////////////////////////////////////
//
// TDebugLog - класс журнала отладки.
//
// Ключевые абстракции:
//   - файл журнала отладки,
//   - уровень детализации отладки.
//
//////////////////////////////////////////////////////////////////////////////

unit uDebugLog;

interface

uses
  // system units
  SyncObjs;

type

  // возможные направления вывода сообщений трассировки
  TTraceDirection = (DLTD_FILE, DLTD_SCREEN, DLTD_DEBUG_WINDOW);


  //
  // TDebugLog
  //

  TDebugLog = class(TObject)
  private
    // fields
    FstrFileName: string;
    FnLevel: integer;
    FbEnable: boolean;
    FnStoredLevel: integer;
    FbIsShowDatetime: boolean;
    FTraceDirection: TTraceDirection;

    // private helper methods
    procedure _Init();
    procedure _Trace(const AstrInfo: string);
    procedure _TraceToFile(const AstrInfo: string);
    procedure _TraceToDebugWindow(const AstrInfo: string);
    procedure _TraceToScreen(const AstrInfo: string);

    // properties methods
    // property Level
    procedure SetLevel(const AnValue: integer);
    function GetLevel(): integer;

    // property Enable
    procedure SetEnable(const AbEnable: boolean);
    function GetEnable(): boolean;

  public
    // constructor / destructor
    constructor Create(); reintroduce; overload;
    constructor Create(const AstrFileName: string); reintroduce; overload;

    // public methods
    function GetLogSize(): cardinal;

    procedure Clear();

    procedure StoreLevel();
    procedure RestoreLevel();

    procedure LevelUp();
    procedure LevelDown();

    procedure Trace(const AstrInfo: string;
        AnLevel: integer = 0);
    procedure Trace0(const AstrInfo: string);
    procedure Trace1(const AstrInfo: string);
    procedure Trace2(const AstrInfo: string);
    procedure Trace3(const AstrInfo: string);
    procedure Trace4(const AstrInfo: string);
    procedure Trace5(const AstrInfo: string);
    procedure Trace6(const AstrInfo: string);
    procedure Trace7(const AstrInfo: string);
    procedure Trace8(const AstrInfo: string);
    procedure Trace9(const AstrInfo: string);
    
    procedure TraceDebug(const AstrInfo: string;
        AnLevel: integer = 0);
    procedure TraceDebug0(const AstrInfo: string);
    procedure TraceDebug1(const AstrInfo: string);
    procedure TraceDebug2(const AstrInfo: string);
    procedure TraceDebug3(const AstrInfo: string);
    procedure TraceDebug4(const AstrInfo: string);
    procedure TraceDebug5(const AstrInfo: string);
    procedure TraceDebug6(const AstrInfo: string);
    procedure TraceDebug7(const AstrInfo: string);
    procedure TraceDebug8(const AstrInfo: string);
    procedure TraceDebug9(const AstrInfo: string);

    // properties
    property FileName: string read FstrFileName write FstrFileName;
    property Level: integer read GetLevel write SetLevel;
    property Enable: boolean read GetEnable write SetEnable;
    property IsShowDatetime: boolean
        read FbIsShowDatetime write FbIsShowDatetime;
    property TraceDirection: TTraceDirection
        read FTraceDirection write FTraceDirection;

  end; // TDebugLog


var
  Debug: TDebugLog;
  csWriteDebugLog: TCriticalSection;

implementation

uses
  // system units
  Windows,
  SysUtils,
  Dialogs,
  Registry,
  // project units
  uY2KCommon;


const
  // максимальный и минимальный уровень детализации
  // отладочных сообщений
  MIN_LEVEL = 0;
  MAX_LEVEL = 9;


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TDebugLog.Create();
begin
  inherited Create();

  FstrFileName := '';
  _Init();

end; // TDebugLog.Create

constructor TDebugLog.Create(const AstrFileName: string);
begin
  inherited Create();

  FstrFileName := AstrFileName;
  _Init();

end; // TDebugLog.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

function TDebugLog.GetLogSize(): cardinal;
var
  hFile: THandle;
begin
  Result := 0;
  csWriteDebugLog.Acquire();
  try
    hFile := CreateFile(
        PChar(FstrFileName),
        GENERIC_READ,
        FILE_SHARE_WRITE,
        nil,
        OPEN_ALWAYS,
        FILE_ATTRIBUTE_NORMAL,
        0);

    if hFile <> INVALID_HANDLE_VALUE then begin
      Result := GetFileSize(hFile, nil);
      CloseHandle(hFile);
    end;

  finally
    csWriteDebugLog.Release();
  end;
end; // TDebugLog.GetLogSize


procedure TDebugLog.Clear();
begin
  if FileExists(FstrFileName) then begin
    DeleteFile(FstrFileName);
  end;
end; // TDebugLog.Clear


procedure TDebugLog.StoreLevel();
begin
  ASSERT((MIN_LEVEL <= FnLevel) and (FnLevel <= MAX_LEVEL));

  FnStoredLevel := FnLevel;

end; // TDebugLog.StoreLevel


procedure TDebugLog.RestoreLevel();
begin
  ASSERT((MIN_LEVEL <= FnStoredLevel) and (FnStoredLevel <= MAX_LEVEL));

  FnLevel := FnStoredLevel;

end; // TDebugLog.RestoreLevel


procedure TDebugLog.LevelUp();
begin
  ASSERT(FnLevel < MAX_LEVEL);

  Inc(FnLevel);

end; // TDebugLog.LevelUp


procedure TDebugLog.LevelDown();
begin
  ASSERT(FnLevel > MIN_LEVEL);

  Dec(FnLevel);

end; // TDebugLog.LevelDown


procedure TDebugLog.Trace(const AstrInfo: string;  AnLevel: integer);
begin
  if AnLevel <= FnLevel then begin
    _Trace(AstrInfo);
  end;
end; // TDebugLog.Trace


procedure TDebugLog.Trace0(const AstrInfo: string);
begin
  Trace(AstrInfo, 0);
end; // TDebugLog.Trace0


procedure TDebugLog.Trace1(const AstrInfo: string);
begin
  Trace(AstrInfo, 1);
end; // TDebugLog.Trace1


procedure TDebugLog.Trace2(const AstrInfo: string);
begin
  Trace(AstrInfo, 2);
end; // TDebugLog.Trace2


procedure TDebugLog.Trace3(const AstrInfo: string);
begin
  Trace(AstrInfo, 3);
end; // TDebugLog.Trace3


procedure TDebugLog.Trace4(const AstrInfo: string);
begin
  Trace(AstrInfo, 4);
end; // TDebugLog.Trace4


procedure TDebugLog.Trace5(const AstrInfo: string);
begin
  Trace(AstrInfo, 5);
end; // TDebugLog.Trace5


procedure TDebugLog.Trace6(const AstrInfo: string);
begin
  Trace(AstrInfo, 6);
end; // TDebugLog.Trace6


procedure TDebugLog.Trace7(const AstrInfo: string);
begin
  Trace(AstrInfo, 7);
end; // TDebugLog.Trace7


procedure TDebugLog.Trace8(const AstrInfo: string);
begin
  Trace(AstrInfo, 8);
end; // TDebugLog.Trace8


procedure TDebugLog.Trace9(const AstrInfo: string);
begin
  Trace(AstrInfo, 9);
end; // TDebugLog.Trace9


procedure TDebugLog.TraceDebug(const AstrInfo: string;  AnLevel: integer);
begin
{$IFOPT D+}
  if AnLevel <= FnLevel then begin
    _Trace(AstrInfo);
  end;
{$ENDIF}
end; // TDebugLog.Trace


procedure TDebugLog.TraceDebug0(const AstrInfo: string);
begin
  TraceDebug(AstrInfo, 0);
end; // TDebugLog.TraceDebug0


procedure TDebugLog.TraceDebug1(const AstrInfo: string);
begin
  TraceDebug(AstrInfo, 1);
end; // TDebugLog.TraceDebug1


procedure TDebugLog.TraceDebug2(const AstrInfo: string);
begin
  TraceDebug(AstrInfo, 2);
end; // TDebugLog.TraceDebug2


procedure TDebugLog.TraceDebug3(const AstrInfo: string);
begin
  TraceDebug(AstrInfo, 3);
end; // TDebugLog.TraceDebug3


procedure TDebugLog.TraceDebug4(const AstrInfo: string);
begin
  TraceDebug(AstrInfo, 4);
end; // TDebugLog.TraceDebug4


procedure TDebugLog.TraceDebug5(const AstrInfo: string);
begin
  TraceDebug(AstrInfo, 5);
end; // TDebugLog.TraceDebug5


procedure TDebugLog.TraceDebug6(const AstrInfo: string);
begin
  TraceDebug(AstrInfo, 6);
end; // TDebugLog.TraceDebug6


procedure TDebugLog.TraceDebug7(const AstrInfo: string);
begin
  TraceDebug(AstrInfo, 7);
end; // TDebugLog.TraceDebug7


procedure TDebugLog.TraceDebug8(const AstrInfo: string);
begin
  TraceDebug(AstrInfo, 8);
end; // TDebugLog.TraceDebug8


procedure TDebugLog.TraceDebug9(const AstrInfo: string);
begin
  TraceDebug(AstrInfo, 9);
end; // TDebugLog.TraceDebug9


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// properties methods

// property Level
procedure TDebugLog.SetLevel(const AnValue: integer);
begin
  ASSERT((MIN_LEVEL <= AnValue) and (AnValue <= MAX_LEVEL));

  FnLevel       := AnValue;
  FnStoredLevel := FnLevel;

end; // TDebugLog.SetLevel


function TDebugLog.GetLevel(): integer;
begin
  Result := FnLevel;
end; // TDebugLog.GetLevel


// property Enable
procedure TDebugLog.SetEnable(const AbEnable: boolean);
begin
  FbEnable := AbEnable;
end; // TDebugLog.SetEnable


function TDebugLog.GetEnable(): boolean;
begin
  Result := FbEnable;
end; // TDebugLog.GetEnable


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private helper methods

procedure TDebugLog._Init();
begin
  FbEnable := TRUE;
  FnLevel := 0;
  FnStoredLevel := FnLevel;
  FbIsShowDatetime := TRUE;
  FTraceDirection := DLTD_FILE;
end; // TDebugLog._Init


procedure TDebugLog._Trace(const AstrInfo: string);
begin
  case TraceDirection of
    DLTD_FILE: begin
      _TraceToFile(AstrInfo);
    end;
    DLTD_SCREEN: begin
      _TraceToScreen(AstrInfo);
    end;
    DLTD_DEBUG_WINDOW: begin
      _TraceToDebugWindow(AstrInfo);
    end;
    else begin
      // do nothing
    end;
  end;
end; // TDebugLog._Trace


procedure TDebugLog._TraceToFile(const AstrInfo: string);
var
  hFile: THandle;
  nNumberOfBytesWriten: Cardinal;
  dwFilePointer: DWORD;
  strInfo: String;
begin
  if not Enable then begin
    Exit;
  end;

  csWriteDebugLog.Acquire();
  try
    if IsShowDatetime then begin
      strInfo := DatetimeToStr(Now()) + ' ';
    end;

    strInfo := strInfo + AstrInfo + #13 + #10;

    hFile := CreateFile(
        PChar(FstrFileName),
        GENERIC_WRITE,
        FILE_SHARE_READ,
        nil,
        OPEN_ALWAYS,
        FILE_ATTRIBUTE_NORMAL,
        0);

    if hFile <> INVALID_HANDLE_VALUE then begin
      dwFilePointer := SetFilePointer(hFile, 0, nil, FILE_END);
      if dwFilePointer <> INVALID_SET_FILE_POINTER then begin
        WriteFile(
            hFile,
            strInfo[1],
            Length(strInfo),
            nNumberOfBytesWriten,
            nil);
      end;
      CloseHandle(hFile);
    end;

  finally
    csWriteDebugLog.Release();
  end;

end; // TDebugLog._TraceToFile


procedure TDebugLog._TraceToDebugWindow(const AstrInfo: string);
var
  strMessage: string;
begin
  strMessage := AnsiChar('"') + AstrInfo + AnsiChar('"');
  OutputDebugString(PChar(strMessage));
end; // TDebugLog._TraceToDebugWindow


procedure TDebugLog._TraceToScreen(const AstrInfo: string);
begin
  MessageDlg(AstrInfo, mtInformation, [mbOK], 0);
end; // TDebugLog._TraceToScreen


initialization
  csWriteDebugLog := TCriticalSection.Create();


finalization
  csWriteDebugLog.Free();


end. ////////////////////////// end of file //////////////////////////////////
