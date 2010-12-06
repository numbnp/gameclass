unit uVirtualTime;

interface

  function GetVirtualTime:TDateTime;
  function GetVirtualTimeReset:TDateTime;
  procedure SetVirtualTime(newTime: TDateTime);
  function IsBetween(AdtMoment, AdtStart, AdtEnd: TDateTime):Boolean;
  function TotalSeconds(length: TDateTime): longword;

implementation

uses
  DateUtils,
  SysUtils,
  gccomputers,
  frmMain;

function GetVirtualTime:TDateTime;
begin
  GetVirtualTime := Now - IntTimeShift;
end;

function GetVirtualTimeReset:TDateTime;
begin
  GetVirtualTimeReset := Now - IntTimeShiftReset;
end;


procedure SetVirtualTime(newTime: TDateTime);
begin
  IntTimeShift := now - newTime;
  formMain.dtpIntTime.DateTime := newTime;
  formMain.dtpIntDate.DateTime := newTime;
end;

//возвращает True если время попадает в интервал
function IsBetween(AdtMoment, AdtStart, AdtEnd: TDateTime):Boolean;
begin
  IsBetween := False;
  If (AdtStart < AdtEnd) and (AdtStart <= AdtMoment) and (AdtEnd >= AdtMoment) then
    IsBetween := True;
  If (AdtStart > AdtEnd) and ((AdtMoment >= AdtStart) and (AdtMoment >= AdtEnd)) then
    IsBetween := True;
  If (AdtStart > AdtEnd) and ((AdtMoment <= AdtStart) and (AdtMoment <= AdtEnd)) then
    IsBetween := True;
  If (AdtStart = AdtEnd) then
    IsBetween := True;
end;

// функция вычисляет количество секунд ваще, ВАЩЕ В СУММЕ!
function TotalSeconds(length: TDateTime):longword;
begin
//  TotalSeconds := HourOf(length)*3600 + MinuteOf(length)*60 + SecondOf(length);
// Неправильно считает
//  Result := MinutesBetween(0,length)*60 + SecondOf(length);
  Result := Round(length*24*60*60);
end;

end.
