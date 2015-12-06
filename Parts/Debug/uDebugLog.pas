//////////////////////////////////////////////////////////////////////////////
//
// TDebugLog - класс журнала отладки.
//
// Ключевые абстракции:
//   - файл журнала отладки,
//   - уровень детализации отладки.
//
// Класс реализован по шаблону Singleton.
// Для доступа к свойствам и методам класса используйте вызовы
// TDebugLog.Instance."MethodName" или вспомогательную переменную GDebug.
//
//////////////////////////////////////////////////////////////////////////////

unit uDebugLog;

interface

uses
  // system units
  SyncObjs,
  uY2KCommon;

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
    FnMaxSizeInKb: Cardinal;

    // private helper methods
    procedure _Init();
    procedure _Trace(const AstrInfo: string);
    procedure _TraceToFile(const AstrInfo: string);
    procedure _TraceToDebugWindow(const AstrInfo: string);
    procedure _TraceToScreen(const AstrInfo: string);
{$IFDEF LINUX}
    procedure _CutFile(var AFile: File);
{$ENDIF}
{$IFDEF MSWINDOWS}
    procedure _CutFile(var AhFile: THandle);
{$ENDIF}

    // properties methods
    // property Level
    procedure SetLevel(const AnValue: integer);
    function GetLevel(): integer;

    // property Enable
    procedure SetEnable(const AbEnable: boolean);
    function GetEnable(): boolean;

  protected
    // constructor / destructor
    constructor CreateInstance();

    // class methods
    class function AccessInstance(
        const ARequest: TSingletonOperation): TDebugLog;

  public
    // constructor / destructor
    constructor Create(); //reintroduce; overload;
//    constructor Create(const AstrFileName: string); reintroduce; overload;
    destructor Destroy(); override;

    // class methods
    class function Instance(): TDebugLog;
    class procedure ReleaseInstance();

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
  SysUtils,
  System.UITypes,
{$IFDEF LINUX}
  QDialogs,
{$ENDIF}
{$IFDEF MSWINDOWS}
  Windows,
  Dialogs,
{$ENDIF}
  // project units
{$IFDEF GCCL}
  uClientInstallDirectory,
{$ENDIF}
  Types;


const
  // максимальный и минимальный уровень детализации
  // отладочных сообщений
  MIN_LEVEL = 0;
  MAX_LEVEL = 9;
  CLINET_DEBUG_LOG_FILENAME = 'gccl_debug.log';
  LINUX_CLINET_DEBUG_LOG_FILENAME = 'gccllin_debug.log';
  SERVICE_DEBUG_LOG_FILENAME = 'gcclsrv_debug.log';
  SERVER_DEBUG_LOG_FILENAME = 'gcserver_debug.log';
  DEFAULT_DEBUG_LOG_FILENAME = 'debug.log';


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TDebugLog.Create();
begin
  inherited Create();
  ASSERT(FALSE, Format('Access class %s through Instance only', [ClassName]));
  _Init();
end; // TDebugLog.Create

constructor TDebugLog.CreateInstance();
begin
  inherited Create();
  FstrFileName := ExtractFilePath(ParamStr(0));
{$IF Defined(LINUX)}
  FstrFileName := FstrFileName + LINUX_CLINET_DEBUG_LOG_FILENAME;
{$ELSEIF Defined(GCCL)}
  FstrFileName := InstallDirectory + '\';
  FstrFileName := FstrFileName + CLINET_DEBUG_LOG_FILENAME;
{$ELSEIF Defined(GCCLSRV)}
  FstrFileName := FstrFileName + SERVICE_DEBUG_LOG_FILENAME;
{$ELSEIF Defined(GC3SERVER)}
  FstrFileName := FstrFileName + SERVER_DEBUG_LOG_FILENAME;
{$ELSE}
  FstrFileName := FstrFileName + DEFAULT_DEBUG_LOG_FILENAME;
{$IFEND}
  _Init();
end; // TDebugLog.CreateInstance

destructor TDebugLog.Destroy();
begin
  if AccessInstance(SinglOper_Access) = Self then begin
    AccessInstance(SinglOper_Destroy);
  end;

  inherited Destroy();
end; // TDebugLog.Destroy

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// class methods

class function TDebugLog.AccessInstance(
    const ARequest: TSingletonOperation): TDebugLog;
// Константа используется для хранения ссылки на единственный
// экземпляр класса. Такая реализация обусловлена отсутсвием
// в классах Delphi статических полей.
// ВНИМАНИЕ! Для корректной работы необходимо включить {$WRITEABLECONST ON}!
{$WRITEABLECONST ON}
const
  FInstance: TDebugLog = nil;
begin
  case ARequest of
    SinglOper_Access: begin
      // do nothing
    end;

    SinglOper_Create: begin
      if not Assigned(FInstance) then begin
        FInstance := CreateInstance();
      end;
    end;

    SinglOper_Destroy: begin
      FInstance := nil;
    end;

    else begin
      ASSERT(FALSE,
          Format('Illegal request %d in AccessInstance', [Ord(ARequest)]));
    end;
  end;

  Result := FInstance;

{$WRITEABLECONST OFF}
end; // TDebugLog.AccessInstance


class function TDebugLog.Instance(): TDebugLog;
const
  FInstance: TDebugLog = nil;
begin
  Result := AccessInstance(SinglOper_Create);
end; // TDebugLog.Instance


class procedure TDebugLog.ReleaseInstance();
begin
  AccessInstance(SinglOper_Access).Free();
end; // TDebugLog.ReleaseInstance


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

{$IFDEF MSWINDOWS}
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
        FILE_SHARE_WRITE or FILE_SHARE_READ,
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
{$ENDIF}

{$IFDEF LINUX}
function TDebugLog.GetLogSize(): cardinal;
var
  f: File;
begin
  Result := 0;
  csWriteDebugLog.Acquire();
  try
    AssignFile(f, FstrFileName);
    Reset(f, 1);
    Result := FileSize(f);
    CloseFile(f);
  finally
    csWriteDebugLog.Release();
  end;
end; // TDebugLog.GetLogSize
{$ENDIF}

{$IFDEF MSWINDOWS}
procedure TDebugLog.Clear();
begin
  if FileExists(FstrFileName) then
    DeleteFile(PChar(FstrFileName));
end; // TDebugLog.Clear
{$ENDIF}

{$IFDEF LINUX}
procedure TDebugLog.Clear();
begin
  if FileExists(FstrFileName) then
    DeleteFile(FstrFileName);
    
end; // TDebugLog.Clear
{$ENDIF}

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
  if AnLevel <= FnLevel then
    _Trace(AstrInfo);
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
  if AnLevel <= FnLevel then
    _Trace(AstrInfo);
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
  FnLevel := MAX_LEVEL;//0;
  FnMaxSizeInKb := 1024;
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


{$IFDEF MSWINDOWS}
procedure TDebugLog._TraceToFile(const AstrInfo: string);
var
  hFile                : THandle;
  nNumberOfBytesWriten : cardinal;
  dwFilePointer        : DWORD;
  strInfo              : AnsiString;
  nLogSize: Cardinal;
  _AstrInfo            : AnsiString;
begin
  if not Enable then begin
    Exit;
  end;

  csWriteDebugLog.Acquire();
  try
    if IsShowDatetime then begin
      strInfo := AnsiString(DatetimeToStr(Now()) + ' ');
    end;

    _AstrInfo := AnsiString(AstrInfo);

    strInfo := strInfo + _AstrInfo + #13 + #10;

    hFile := CreateFile(
        PChar(FstrFileName),
        GENERIC_READ or GENERIC_WRITE,
        FILE_SHARE_READ or FILE_SHARE_WRITE,
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

        if FnMaxSizeInKb > 0 then begin
          nLogSize := GetLogSize();
          if nLogSize > (FnMaxSizeInKb * 1024) then begin
            _CutFile(hFile);
          end;
        end;

      end;
      CloseHandle(hFile);
    end;

  finally
    csWriteDebugLog.Release();
  end;

end; // TDebugLog._TraceToFile
{$ENDIF}

{$IFDEF LINUX}
procedure TDebugLog._TraceToFile(const AstrInfo: string);
var
  f : File;
  nNumberOfBytesWriten : Cardinal;
  dwFilePointer : DWORD;
  strInfo : String;
  nLogSize: Cardinal;
  i: Integer;
begin
  if not Enable then begin
    Exit;
  end;

  try
    csWriteDebugLog.Acquire();
    try
      if IsShowDatetime then begin
        strInfo := DatetimeToStr(Now()) + ' ';
      end;

      strInfo := strInfo + AstrInfo + #13 + #10;

      AssignFile(f, FstrFileName);
      FileMode := 2; // Read-Write Mode
      if FileExists(FstrFileName) then
        Reset(f, 1)
      else
        Rewrite(f, 1);
      if (IOResult = 0) then begin
        Seek(f, FileSize(f));
        if (IOResult = 0) then begin
          BlockWrite(f, strInfo[1], Length(strInfo), nNumberOfBytesWriten);
          if FnMaxSizeInKb > 0 then begin
            nLogSize := FileSize(f);
            if nLogSize > (FnMaxSizeInKb * 1024) then begin
              _CutFile(f);
            end;
          end;
        end;
      end;
      CloseFile(f);
    finally
      csWriteDebugLog.Release();
    end;
  except
  end;
end; // TDebugLog._TraceToFile
{$ENDIF}

{$IFDEF MSWINDOWS}
procedure TDebugLog._TraceToDebugWindow(const AstrInfo: string);
var
  strMessage: string;
begin
  strMessage := AnsiChar('"') + AstrInfo + AnsiChar('"');
  OutputDebugString(PChar(strMessage));
end; // TDebugLog._TraceToDebugWindow
{$ENDIF}

{$IFDEF LINUX}
procedure TDebugLog._TraceToDebugWindow(const AstrInfo: string);
var
  strMessage: string;
begin
  strMessage := AnsiChar('"') + AstrInfo + AnsiChar('"');
//  OutputDebugString(PChar(strMessage));
end; // TDebugLog._TraceToDebugWindow
{$ENDIF}

procedure TDebugLog._TraceToScreen(const AstrInfo: string);
begin
  MessageDlg(AstrInfo, mtInformation, [mbOK], 0);
end; // TDebugLog._TraceToScreen

{$IFDEF MSWINDOWS}
procedure TDebugLog._CutFile(var AhFile: THandle);
var
  dwFilePointer: DWord;
  nSize: Integer;
  nHalfSize: Integer;
  pBuffer: array of Char;
  nSizeOfBuffer: Integer;
  nNumberOfBytesRead: Cardinal;
begin
  nNumberOfBytesRead := 0;
  nSize := GetLogSize();
  nHalfSize := nSize div 2;
  dwFilePointer := SetFilePointer(AhFile, nHalfSize, nil, FILE_BEGIN);
  if dwFilePointer <> INVALID_SET_FILE_POINTER then begin
    nSizeOfBuffer := nSize - nHalfSize;
    try
      SetLength(pBuffer, nSizeOfBuffer);
      if ReadFile(AhFile,	pBuffer[0], nSizeOfBuffer,
          nNumberOfBytesRead, nil) then begin
        dwFilePointer := SetFilePointer(AhFile, 0, nil, FILE_BEGIN);
        if dwFilePointer <> INVALID_SET_FILE_POINTER then begin
          WriteFile(AhFile, pBuffer[0], nSizeOfBuffer, nNumberOfBytesRead, nil);
          SetEndOfFile(AhFile);
        end;
      end;
    finally
      SetLength(pBuffer, 0);
    end;
  end;
end; // TDebugLog._CutFile
{$ENDIF}

{$IFDEF LINUX}
procedure TDebugLog._CutFile(var AFile: File);
var
  dwFilePointer: DWord;
  nSize: Integer;
  nHalfSize: Integer;
  pBuffer: array of Char;
  nSizeOfBuffer: Integer;
  nNumberOfBytesRead: Cardinal;
begin
  try
    nNumberOfBytesRead := 0;
    nSize := FileSize(AFile);
    nHalfSize := nSize div 2;
    Seek(AFile, nHalfSize);
    nSizeOfBuffer := nSize - nHalfSize;
    try
      SetLength(pBuffer, nSizeOfBuffer);
      BlockRead(AFile, pBuffer[0], nSizeOfBuffer);
      if (IOResult = 0) then begin
        Seek(AFile, 0);
        BlockWrite(AFile, pBuffer[0], nSizeOfBuffer);
        Truncate(AFile);
      end;
    finally
      SetLength(pBuffer, 0);
    end;
  except
  end;
end; // TDebugLog._CutFile
{$ENDIF}

initialization
  csWriteDebugLog := TCriticalSection.Create();
  Debug := TDebugLog.Instance();


finalization
  csWriteDebugLog.Free();
  TDebugLog.ReleaseInstance();

end. ////////////////////////// end of file //////////////////////////////////
