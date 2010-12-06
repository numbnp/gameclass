//////////////////////////////////////////////////////////////////////////////
//
// Модуль общих функций GameClass
//
//////////////////////////////////////////////////////////////////////////////

unit uCommon;

interface

function StrToXoredHex(const AstrText, AstrKey: String): String;
function XoredHexToStr(const AstrXoredHex, AstrKey: String): String;
function GenerateUniqueName: String;

implementation

uses
  SysUtils,
  StrUtils;

function StrToXoredHex(const AstrText, AstrKey: String): String;
var
  i,j: Integer;
begin
  Result := '';
  if (Length(AstrKey) > 0) and (Length(AstrText) > 0) then begin
    j := 1;
    for i := 1 to Length(AstrText) do begin
      Result := Result
          + AnsiRightStr(
          IntToHex(Integer(Byte(AstrText[i]) xor Byte(AstrKey[j])), 2), 2);
      Inc(j);
      if (j > Length(AstrKey)) then
        j := 1;
    end;
  end;
end;

function XoredHexToStr(const AstrXoredHex, AstrKey: String): String;
var
  i,j: Integer;
begin
  Result := '';
  if (Length(AstrKey) > 0) and (Length(AstrXoredHex) > 0) then begin
    j := 1;
    for i := 1 to (Length(AstrXoredHex) div 2) do begin
      Result := Result
          + AnsiChar(Byte(StrToIntDef('0x' + AstrXoredHex[i*2-1]
          + AstrXoredHex[i*2], 0)) xor Byte(AstrKey[j]));
      Inc(j);
      if (j > Length(AstrKey)) then
        j := 1;
    end;
  end;
end;

function GenerateUniqueName: String;
begin
  DateTimeToString(Result, 'yymmdd-hhmmss', Now);
end;

end.
