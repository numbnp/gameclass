unit uTimeInterval;

interface

type

  TTimeInterval = record
    dtBegin: TDateTime;
    dtEnd: TDateTime;
  end;

  TDefaultTimeInterval = (
      DefaultDTI_All,
      DefaultDTI_Today,
      DefaultDTI_Yesterday,
      DefaultDTI_Last7Days,
      DefaultDTI_Last30Days,
      DefaultDTI_CurrentWeek,
      DefaultDTI_CurrentMonth,
      DefaultDTI_CurrentQuarter,
      DefaultDTI_CurrentYear,
      DefaultDTI_Quarter1,
      DefaultDTI_Quarter2,
      DefaultDTI_Quarter3,
      DefaultDTI_Quarter4);


procedure SetDefaultDTI(const ADefaultTimeInterval: TDefaultTimeInterval;
    var ATimeInterval: TTimeInterval);



implementation

uses
{$IFDEF GC3SERVER}
  gcconst,
  uTimeShift,
{$ENDIF}
  SysUtils,
  DateUtils;


procedure _SetDTI_All(var ATimeInterval: TTimeInterval);
begin
{$IFDEF GC3SERVER}
//  ATimeInterval.dtBegin := FIRST_DATE;
  ATimeInterval.dtBegin := GetCurrentShiftBegin(now());
  ATimeInterval.dtEnd := LAST_DATE;
{$ELSE}
  ATimeInterval.dtBegin := 0;
  ATimeInterval.dtEnd := MaxDateTime;
{$ENDIF}
end; // _SetDTI_All


procedure _SetDTI_Today(var ATimeInterval: TTimeInterval);
begin
  ATimeInterval.dtBegin := DateOf(Now());
  ATimeInterval.dtEnd := IncDay(ATimeInterval.dtBegin, 1);
  ATimeInterval.dtEnd := IncSecond(ATimeInterval.dtEnd, -1);
end; // _SetDTI_Today


procedure _SetDTI_Yesterday(var ATimeInterval: TTimeInterval);
begin
  ATimeInterval.dtBegin := DateOf(Now());
  ATimeInterval.dtEnd := IncSecond(ATimeInterval.dtBegin, -1);
  ATimeInterval.dtBegin := IncDay(ATimeInterval.dtBegin, -1);
end; // _SetDTI_Yesterday


procedure _SetDTI_Last7Days(var ATimeInterval: TTimeInterval);
begin
  ATimeInterval.dtBegin := DateOf(Now());
  ATimeInterval.dtEnd := IncDay(ATimeInterval.dtBegin, 1);
  ATimeInterval.dtEnd := IncSecond(ATimeInterval.dtEnd, -1);
  ATimeInterval.dtBegin := IncDay(ATimeInterval.dtBegin, -6);
end; // _SetDTI_Last7Days


procedure _SetDTI_Last30Days(var ATimeInterval: TTimeInterval);
begin
  ATimeInterval.dtBegin := DateOf(Now());
  ATimeInterval.dtEnd := IncDay(ATimeInterval.dtBegin, 1);
  ATimeInterval.dtEnd := IncSecond(ATimeInterval.dtEnd, -1);
  ATimeInterval.dtBegin := IncDay(ATimeInterval.dtBegin, -29);
end; // _SetDTI_Last30Days


procedure _SetDTI_CurrentWeek(var ATimeInterval: TTimeInterval);
begin
  ATimeInterval.dtBegin := DateOf(StartOfTheWeek(Now()));
  ATimeInterval.dtEnd := IncDay(ATimeInterval.dtBegin, 7);
  ATimeInterval.dtEnd := IncSecond(ATimeInterval.dtEnd, -1);
end; // _SetDTI_CurrentWeek


procedure _SetDTI_CurrentMonth(var ATimeInterval: TTimeInterval);
begin
  ATimeInterval.dtBegin := DateOf(StartOfTheMonth(Now));
  ATimeInterval.dtEnd := IncDay(ATimeInterval.dtBegin, DaysInMonth(Now));
  ATimeInterval.dtEnd := IncSecond(ATimeInterval.dtEnd, -1);
end; // _SetDTI_CurrentMonth


procedure _SetDTI_CurrentYear(var ATimeInterval: TTimeInterval);
begin
  ATimeInterval.dtBegin := DateOf(StartOfTheYear(Now()));
  ATimeInterval.dtEnd := DateOf(IncDay(ATimeInterval.dtBegin, DaysInYear(Now())));
  ATimeInterval.dtEnd := IncSecond(ATimeInterval.dtEnd, -1);
end; // _SetDTI_CurrentYear


procedure _SetDTI_Quarter1(var ATimeInterval: TTimeInterval);
begin
  ATimeInterval.dtBegin := DateOf(StartOfTheYear(Now()));
  ATimeInterval.dtEnd := IncMonth(ATimeInterval.dtBegin, 3);
  ATimeInterval.dtEnd := IncSecond(ATimeInterval.dtEnd, -1);
end; // _SetDTI_Quarter1


procedure _SetDTI_Quarter2(var ATimeInterval: TTimeInterval);
begin
  ATimeInterval.dtBegin := StartOfTheYear(Now());
  ATimeInterval.dtBegin := DateOf(IncMonth(ATimeInterval.dtBegin, 3));
  ATimeInterval.dtEnd := DateOf(IncMonth(ATimeInterval.dtBegin, 3));
  ATimeInterval.dtEnd := IncSecond(ATimeInterval.dtEnd, -1);
end; // _SetDTI_Quarter2


procedure _SetDTI_Quarter3(var ATimeInterval: TTimeInterval);
begin
  ATimeInterval.dtBegin := StartOfTheYear(Now());
  ATimeInterval.dtBegin := DateOf(IncMonth(ATimeInterval.dtBegin, 6));
  ATimeInterval.dtEnd := DateOf(IncMonth(ATimeInterval.dtBegin, 3));
  ATimeInterval.dtEnd := IncSecond(ATimeInterval.dtEnd, -1);
end; // _SetDTI_Quarter3


procedure _SetDTI_Quarter4(var ATimeInterval: TTimeInterval);
begin
  ATimeInterval.dtBegin := StartOfTheYear(Now());
  ATimeInterval.dtBegin := DateOf(IncMonth(ATimeInterval.dtBegin, 9));
  ATimeInterval.dtEnd := DateOf(IncMonth(ATimeInterval.dtBegin, 3));
  ATimeInterval.dtEnd := IncSecond(ATimeInterval.dtEnd, -1);
end; // _SetDTI_Quarter4


procedure _SetDTI_CurrentQuarter(var ATimeInterval: TTimeInterval);
var
  nMonth: Word;
begin
  nMonth := MonthOf(Now());
  if (1 <= nMonth) and (nMonth <= 3) then begin
    _SetDTI_Quarter1(ATimeInterval);
  end else if (4 <= nMonth) and (nMonth <= 6) then begin
    _SetDTI_Quarter2(ATimeInterval);
  end else if (7 <= nMonth) and (nMonth <= 9) then begin
    _SetDTI_Quarter3(ATimeInterval);
  end else if (10 <= nMonth) and (nMonth <= 12) then begin
    _SetDTI_Quarter4(ATimeInterval);
  end;
end; // _SetDTI_CurrentQuarter


procedure SetDefaultDTI(const ADefaultTimeInterval: TDefaultTimeInterval;
    var ATimeInterval: TTimeInterval);
begin
  case ADefaultTimeInterval of
    DefaultDTI_All: _SetDTI_All(ATimeInterval);
    DefaultDTI_Today: _SetDTI_Today(ATimeInterval);
    DefaultDTI_Yesterday: _SetDTI_Yesterday(ATimeInterval);
    DefaultDTI_Last7Days: _SetDTI_Last7Days(ATimeInterval);
    DefaultDTI_Last30Days: _SetDTI_Last30Days(ATimeInterval);
    DefaultDTI_CurrentWeek: _SetDTI_CurrentWeek(ATimeInterval);
    DefaultDTI_CurrentMonth: _SetDTI_CurrentMonth(ATimeInterval);
    DefaultDTI_CurrentQuarter: _SetDTI_CurrentQuarter(ATimeInterval);
    DefaultDTI_CurrentYear: _SetDTI_CurrentYear(ATimeInterval);
    DefaultDTI_Quarter1: _SetDTI_Quarter1(ATimeInterval);
    DefaultDTI_Quarter2: _SetDTI_Quarter2(ATimeInterval);
    DefaultDTI_Quarter3: _SetDTI_Quarter3(ATimeInterval);
    DefaultDTI_Quarter4: _SetDTI_Quarter4(ATimeInterval);
    else begin
      ASSERT(FALSE, 'Unknown TimeInterval!');
      _SetDTI_All(ATimeInterval);
    end;
  end;
end; // SetDefaultDTI



end.
