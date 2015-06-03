//////////////////////////////////////////////////////////////////////////////
//
// TTimerThread - класс-поток, генерирующий событие TTimeMark через
// заданный интервал времени (замена TTimer, не использующая WM_TIMER).
//
//////////////////////////////////////////////////////////////////////////////

unit uTimerThread;

interface

uses
  // system units
  Classes;


type

  // событие этого типа генерируется через определенный интервал времени
  TTimeMark = procedure (Sender: TObject) of object;


  //
  // TTimerThread
  //

  TTimerThread = class(TThread)
  private
    // fields
    FnInterval: Cardinal;
    FOnTimeMark: TTimeMark;

    // private helper methods
    procedure _TimeMark();

  protected
    // protected methods
    procedure Execute(); override;

  public
    // constructor / destructor
    constructor Create(const AbCreateSuspended: Boolean);

    // properties
    property Interval: Cardinal read FnInterval write FnInterval;
    property OnTimeMark: TTimeMark read FOnTimeMark write FOnTimeMark;

  end; // TTimerThread


implementation

uses
  // system units
  Windows;


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TTimerThread.Create(const AbCreateSuspended: Boolean);
begin
  inherited Create(AbCreateSuspended);
  FnInterval := 150;
  FreeOnTerminate := TRUE;
end; // TTimerThread.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// protected methods

procedure TTimerThread.Execute();
begin
  while not Terminated do begin
    if SleepEx(FnInterval, FALSE) = 0 then begin
      _TimeMark();
    end;
  end;
end; // TTimerThread.Execute


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private helper methods

procedure TTimerThread._TimeMark();
begin
  if Assigned(OnTimeMark) then begin
    OnTimeMark(Self);
  end;
end; // TTimerThread._TimeMark


end.
