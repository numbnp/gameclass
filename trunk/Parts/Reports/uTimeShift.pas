unit uTimeShift;

interface

function GetCurrentShiftBegin(NowTime:Tdatetime):tdatetime;

implementation

uses
{$IFDEF GC3SERVER}
  gcconst,
  gccommon,
{$ENDIF}
  Windows,
  SysUtils,
  DateUtils;

function GetCurrentShiftBegin(NowTime:Tdatetime):tdatetime;
var
  FormatSettings: TFormatSettings;
  sDate:string;
  sQuery:string;
  sResultQuery:string;
begin
  GetLocaleFormatSettings(LANG_ENGLISH, FormatSettings);
  DateTimeToString(sDate,'dd-mmm-yyyy hh:nn:ss',NowTime,FormatSettings);
  sQuery :='EXEC '+DS_SHIFT_TIME + ' ' +QuotedStr (sDate);
  sResultQuery:=dsGetVarBySqlQuery( sQuery );
  if sResultQuery = '' then 
    Result := NowTime
  else
    Result := strtodatetime(sResultQuery);
end;

end.
