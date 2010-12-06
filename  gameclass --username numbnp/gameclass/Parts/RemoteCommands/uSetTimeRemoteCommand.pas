//////////////////////////////////////////////////////////////////////////////
//
// TSetTimeRemoteCommand
// Класс команд, поступающих от управляющего сервера, которые предназначены
// для установки параметров даты / времени.
//
//////////////////////////////////////////////////////////////////////////////

unit uSetTimeRemoteCommand;

interface

uses
  // project units
  uRemoteCommand;

type

  //
  // TSetTimeRemoteCommand
  //

  TSetTimeRemoteCommand = class(TRemoteCommand)
  private
    // fields
    FstrTime: String;

  public
    // constructor / destructor
    constructor Create(); overload;
    constructor Create(const AstrTime: String); overload;

    // public methods
    procedure Execute(); override;
  protected
    procedure _SetLocalTimeFromStr(const AstrTime: String);

  end; // TSetTimeRemoteCommand


implementation

uses
  // system units
  SysUtils,
{$IFDEF MSWINDOWS}
  Windows,
{$ENDIF}
{$IFDEF LINUX}
  DateUtils,
  Libc,
{$ENDIF}
  // project units
  uDebugLog,
  uY2KString,
  uClientInfo;

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TSetTimeRemoteCommand.Create();
begin
  ASSERT(FALSE, 'TSetTimeRemoteCommand.Create need AstrTime parameter');
end; // TSetTimeRemoteCommand.Create

constructor TSetTimeRemoteCommand.Create(const AstrTime: String);
begin
  inherited Create();

  FstrTime := AstrTime;

end; // TSetTimeRemoteCommand.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TSetTimeRemoteCommand.Execute();
begin
  _SetLocalTimeFromStr(FstrTime);
  // сбросить это время, т.к. при переводе может получиться разница > 1 мин
  GClientInfo.LastPingTime := Now;

end; // TSetTimeRemoteCommand.Execute

///helprs methods
{$IFDEF MSWINDOWS}
procedure TSetTimeRemoteCommand._SetLocalTimeFromStr(const AstrTime: String);
var
  st: SYSTEMTIME;
  bResultOk: Boolean;
  dwError: DWord;
begin
  st.wYear   := StrToInt(GetParamFromString(AstrTime, 0));
  st.wMonth  := StrToInt(GetParamFromString(AstrTime, 1));
  st.wDay    := StrToInt(GetParamFromString(AstrTime, 2));
  st.wHour   := StrToInt(GetParamFromString(AstrTime, 3));
  st.wMinute := StrToInt(GetParamFromString(AstrTime, 4));
  st.wSecond := StrToInt(GetParamFromString(AstrTime, 5));
  bResultOk := SetLocalTime(st);
  if not bResultOk then begin
    dwError := GetLastError();
    Debug.Trace0('SerLocalTime error: ' + IntToStr(dwError));
  end;

end; // TSetTimeRemoteCommand.Execute
{$ENDIF}
{$IFDEF LINUX}
procedure TSetTimeRemoteCommand._SetLocalTimeFromStr(const AstrTime: String);
var
  timeval: TTimeVal;
  timezone: TTimeZone;
begin
  try
    gettimeofday(timeval, timezone);
    timeval.tv_sec := DateTimeToUnix(IncMinute(
        EncodeDateTime(
        StrToInt(GetParamFromString(AstrTime, 0)),
        StrToInt(GetParamFromString(AstrTime, 1)),
        StrToInt(GetParamFromString(AstrTime, 2)),
        StrToInt(GetParamFromString(AstrTime, 3)),
        StrToInt(GetParamFromString(AstrTime, 4)),
        StrToInt(GetParamFromString(AstrTime, 5)), 0),
        timezone.tz_minuteswest));
    settimeofday(timeval, timezone);
  except
    on e: Exception do begin
      Debug.Trace0('settimeofday Error! ' + e.Message);
    end;
  end;
end; // TSetTimeRemoteCommand.Execute
{$ENDIF}


end. ////////////////////////// end of file //////////////////////////////////

