//////////////////////////////////////////////////////////////////////////////
//
// Модуль функций работы со строками
//
//////////////////////////////////////////////////////////////////////////////

unit uY2KString;

interface

const
  DEF_PARAMETER_SEPARATOR = '&';
  DEF_KEY_SEPARATOR = '=';
  DEF_TYPE_SEPARATOR = '/';

  TYPE_INT = 'int';
  TYPE_LIST = 'lst';
  TYPE_BOOL = 'bool';
  TYPE_STRING = 'str';

  DEF_CONFIG_TYPES_EXAMPLE = 'COMPort/Порт/Название COM-порта,'
      + ' к которому подключен ККМ.=lst/COM1/COM2/COM3/COM4'
      + '&Speed/Скорость/Скорость обмена данными=lst/9600/19200/57600/115200'
      +  '&Password/Пароль/Пароль для подключения к ККМ=str';
  DEF_CONFIG_EXAMPLE = 'COMPort=0'
      + '&Speed=0'
      +  '&Password=0000';

  FIRST_DATE = 36526.0;// 01.01.2000

function GetParamCountFromString(AstrData: String;
    AstrDividerSymbol: String = '/'): Integer;
function GetParamFromString(const AstrData: String;
    AnParameterNumber: Integer;
    AstrDividerSymbol: string = '/'): String;
procedure ReplaceParamInString(var AstrData: String;
    const AstrNewValue: String;
    AnParameterNumber: Integer;
    AstrDividerSymbol: String = '/');

function DoubleQuotedStr(const AstrValue: String): String;

function OpenTagStr(const AstrTagName: String;
    const AstrParameters: String = ''): String;
function CloseTagStr(const AstrTagName: String): String;
function TagStr(const AstrTagName: String;
    const AstrParameters: String = '';
    const AstrValue: String = ''): String;

function FindStringInArray(const AstrForSearch: String;
    const AStrings: array of String;
    const AbIsCaseSensitivity: Boolean): Boolean;

function EncodeStringForSQL(AstrString: String): String;
function DecodeStringFromSQL(AstrString: String): String;

function GetShortSizeString(const AstrSize: String): String; overload;
function GetShortSizeString(const AnSize: Int64): String; overload;
function GetShortSizeString(const AfSize: Double): String; overload;
function RemoveBlanks(const AstrSource: String): String;

function StrToFloatDefWithReplace(const S: string;
    const Default: Extended = 0): Extended;

function StrToDateTimeDefWithReplace(const S: string;
    const Default: TDateTime = FIRST_DATE): TDateTime;

function GetValueFromConfig(const AstrConfig:String;
    const AstrKey: String;
    const AstrParameterSeparator: String = DEF_PARAMETER_SEPARATOR;
    const AstrKeySeparator: String = DEF_KEY_SEPARATOR
    ): String;

function ReplaceValueInConfig(var AstrConfig:String;
    const AstrKey: String; const AstrNewValue: String;
    const AstrParameterSeparator: String = DEF_PARAMETER_SEPARATOR;
    const AstrKeySeparator: String = DEF_KEY_SEPARATOR
    ): Boolean;
function FindParamInString(const AstrForSearch: String;
    const AstrParameters: String;
    const AbIsCaseSensitivity: Boolean;
    const AstrDividerSymbol: String = '/'): Boolean;
function ArrayToParameters(const AStrings: array of String;
    const AstrDividerSymbol: String = '/'): String;

implementation

uses
  // system units
  SysUtils,
  StrUtils;


function DoubleQuotedStr(const AstrValue: string): string;
begin
  Result := AnsiQuotedStr(AstrValue, '"');
end; // DoubleQuotedStr


function OpenTagStr(const AstrTagName: String;
    const AstrParameters: String = ''): String;
begin
  if Length(AstrParameters) = 0 then begin
    Result := '<' + AstrTagName + '>';
  end else begin
    Result := '<' + AstrTagName + ' ' + AstrParameters + '>';
  end;
end; // TagStr


function CloseTagStr(const AstrTagName: String): String;
begin
  Result := '</' + AstrTagName + '>';
end; // CloseTagStr


function TagStr(const AstrTagName: String;
    const AstrParameters: String = '';
    const AstrValue: String = ''): String;
begin
  Result := OpenTagStr(AstrTagName, AstrParameters)
      + AstrValue
      + CloseTagStr(AstrTagName);
end; // TagStr


// функция принимает строку вида "name/>=/100/30/20" и возвращает параметр
// от 0 до Х, разделителями являются "/"
function GetParamFromString(const AstrData: String;
    AnParameterNumber: Integer;
    AstrDividerSymbol: String = '/'): String;
var
  i: Integer;
  nPosBegin: Integer;
  nPosEnd: Integer;
  nAdditionalLen: Integer;
  strPart: String;
begin
  ASSERT(AnParameterNumber >= 0);

  strPart := AstrData;

  // бывают разделители не из одного символа, например '; '
  nAdditionalLen := Length(AstrDividerSymbol) - 1;
  nPosBegin := 1;
  for i := 1 to AnParameterNumber do begin
    nPosBegin := PosEx(AstrDividerSymbol, AstrData, nPosBegin) + 1;
    if (nPosBegin = 0) then begin
      Result := '';
      exit;
    end;
  end;

  nPosEnd := PosEx(AstrDividerSymbol, AstrData, nPosBegin);
  if nPosEnd = 0 then begin
    nPosEnd := length(AstrData) + 1;
  end;
  // если не первый параметр
  if (AnParameterNumber > 0) then begin
    nPosBegin := nPosBegin + nAdditionalLen;
  end;

  Result := Copy(AstrData, nPosBegin, nPosEnd - nPosBegin);

end; // GetParamFromString

// процедура принимает строку вида "name/>=/100/30/20" и меняет параметр
// от 0 до Х, разделителями являются "/"
procedure ReplaceParamInString(var AstrData: String;
    const AstrNewValue: String;
    AnParameterNumber: Integer;
    AstrDividerSymbol: String = '/');
var
  i: Integer;
  nPosBegin: Integer;
  nPosEnd: Integer;
  nAdditionalLen: Integer;
  strPart: String;
begin
  ASSERT(AnParameterNumber >= 0);

  strPart := AstrData;

  // бывают разделители не из одного символа, например '; '
  nAdditionalLen := Length(AstrDividerSymbol) - 1;
  nPosBegin := 1;
  for i := 1 to AnParameterNumber do begin
    nPosBegin := PosEx(AstrDividerSymbol, AstrData, nPosBegin) + 1;
    if (nPosBegin = 0) then begin
      exit;
    end;
  end;

  nPosEnd := PosEx(AstrDividerSymbol, AstrData, nPosBegin);
  if nPosEnd = 0 then begin
    nPosEnd := length(AstrData) + 1;
  end;
  // если не первый параметр
  if (AnParameterNumber > 0) then begin
    nPosBegin := nPosBegin + nAdditionalLen;
  end;

//  Result := Copy(AstrData, nPosBegin, nPosEnd - nPosBegin);
  AstrData := StuffString(AstrData, nPosBegin, nPosEnd - nPosBegin,
      AstrNewValue);

end; // ReplaceParamInString

// функция принимает строку вида "name/>=/100/30/20" и
// возвращает количество параметров
function GetParamCountFromString(AstrData: String;
    AstrDividerSymbol: String = '/'): Integer;
var
  nCount: integer;
begin
  nCount := 0;
  Result := 0;
  while True do begin
    // флаг того, что параметров меньше, чем попросили
    if (Pos(AstrDividerSymbol,AstrData) = 0) then begin
      if Length(AstrData) > 0 then
        Inc(nCount);
      Result := nCount;
      exit;
    end;
    Inc(nCount);
    AstrData := Copy(AstrData,Pos(AstrDividerSymbol,AstrData)+1,
        Length(AstrData) + 1);
  end;
end; // GetParamCountFromString


function FindStringInArray(const AstrForSearch: string;
    const AStrings: array of string;
    const AbIsCaseSensitivity: boolean): boolean;
var
  i: integer;
begin
  Result := FALSE;
  for i := 0 to High(AStrings) do
    if AbIsCaseSensitivity then begin
      if CompareStr(AstrForSearch, AStrings[i]) = 0 then begin
        Result := TRUE;
        break;
      end;
    end
    else begin
      if CompareText(AstrForSearch, AStrings[i]) = 0 then begin
        Result := TRUE;
        break;
      end;
    end;
end; // FindStringInArray

function EncodeStringForSQL(AstrString: String): String;
begin
  Result := AnsiReplaceStr(AstrString,'''','''''');
end;

function DecodeStringFromSQL(AstrString: String): String;
begin
  Result := AnsiReplaceStr(AstrString,'''''','''');
end;

function GetShortSizeString(const AnSize: Int64): String;
var
  fSize: Double;
begin
  Result := '';
  if (AnSize > 1073741824) then begin
    fSize := AnSize/1073741824;
    Result := FloatToStrF(fSize, ffNumber, 5, 1) + ' GB';
    Result := AnsiReplaceStr(Result, ',0', '');
    exit;
  end;
  if (AnSize > 1048576) then begin
    fSize := AnSize/1048576;
    Result := FloatToStrF(fSize, ffNumber, 5, 1) + ' MB';
    Result := AnsiReplaceStr(Result, ',0', '');
    exit;
  end;
  if (AnSize > 1024) then begin
    fSize := AnSize/1024;
    Result := FloatToStrF(fSize, ffNumber, 5, 1) + ' KB';
    Result := AnsiReplaceStr(Result, ',0', '');
    exit;
  end;
  Result := IntToStr(AnSize) + ' Byte';
end;

function GetShortSizeString(const AstrSize: String): String;
var
  nSize: Int64;
begin
  Result := '';
  if not TryStrToInt64(AstrSize, nSize) then
    exit;
  Result := GetShortSizeString(nSize);
end;

function GetShortSizeString(const AfSize: Double): String;
begin
  Result := GetShortSizeString(Round(AfSize));
end;

function RemoveBlanks(const AstrSource: String): String;
var
  nStart: Integer;
  nEnd: Integer;
begin
  Result := AstrSource;
  nStart := 1;
  nEnd := Length(AstrSource);
  if (nStart > nEnd) then
    exit;
  while (AstrSource[nStart] = ' ') do
    Inc(nStart);
  while (AstrSource[nEnd] = ' ') do
    Dec(nEnd);
  Result := AnsiMidStr(AstrSource, nStart, nEnd - nStart + 1);
end;

function StrToFloatDefWithReplace(const S: string;
    const Default: Extended = 0): Extended;
var
  str: String;
begin
  str := AnsiReplaceStr(S, '.', DecimalSeparator);
  str := AnsiReplaceStr(str, ',', DecimalSeparator);
  Result := StrToFloatDef(str, Default);
end;

function StrToDateTimeDefWithReplace(const S: string;
    const Default: TDateTime = FIRST_DATE): TDateTime;
var
  str: String;
begin
  str := AnsiReplaceStr(S, '-', DateSeparator);
  str := AnsiReplaceStr(str, '.', DateSeparator);
  Result := StrToDateTimeDef(str, Default);
end;

function GetValueFromConfig(const AstrConfig:String;
    const AstrKey: String;
    const AstrParameterSeparator: String = DEF_PARAMETER_SEPARATOR;
    const AstrKeySeparator: String = DEF_KEY_SEPARATOR
    ): String;
var
  strKey, strValue: String;
  i, nCount: Integer;
begin
  Result := '';
  nCount := GetParamCountFromString(AstrConfig, AstrParameterSeparator);
  for i := 0 to nCount - 1 do begin
    strKey := GetParamFromString(AstrConfig, i ,AstrParameterSeparator);
    strValue := GetParamFromString(strKey, 1, AstrKeySeparator);
    strKey := GetParamFromString(strKey, 0, AstrKeySeparator);
    if (strKey = AstrKey) then begin
      Result := strValue;
      break;
    end;
  end;
end;

function ReplaceValueInConfig(var AstrConfig:String;
    const AstrKey: String; const AstrNewValue: String;
    const AstrParameterSeparator: String = DEF_PARAMETER_SEPARATOR;
    const AstrKeySeparator: String = DEF_KEY_SEPARATOR
    ): Boolean;
var
  strKeyAndValue, strKey, strValue: String;
  i, nCount: Integer;
begin
  Result := False;
  nCount := GetParamCountFromString(AstrConfig, AstrParameterSeparator);
  for i := 0 to nCount - 1 do begin
    strKeyAndValue := GetParamFromString(AstrConfig, i ,AstrParameterSeparator);
    strKey := GetParamFromString(strKeyAndValue, 0, AstrKeySeparator);
    strValue := GetParamFromString(strKeyAndValue, 1, AstrKeySeparator);
    if (strKey = AstrKey) then begin
      ReplaceParamInString(strKeyAndValue, AstrNewValue, 1, AstrKeySeparator);
      ReplaceParamInString(AstrConfig, strKeyAndValue, i, AstrParameterSeparator);
      Result := True;
      break;
    end;
  end;
end;

function FindParamInString(const AstrForSearch: String;
    const AstrParameters: String;
    const AbIsCaseSensitivity: Boolean;
    const AstrDividerSymbol: String = '/'): Boolean;
{var
  i: Integer;}
begin
  Result := False;
  if AbIsCaseSensitivity then
    Result := AnsiContainsStr(AstrDividerSymbol + AstrParameters
        + AstrDividerSymbol, AstrDividerSymbol + AstrForSearch
        + AstrDividerSymbol)
  else
    Result := AnsiContainsText(AstrDividerSymbol + AstrParameters
        + AstrDividerSymbol, AstrDividerSymbol + AstrForSearch
        + AstrDividerSymbol);
end; // FindParamInString

function ArrayToParameters(const AStrings: array of String;
    const AstrDividerSymbol: String = '/'): String;
var
  i: integer;
begin
  Result := '';
  for i := 0 to High(AStrings) do
      if i = 0 then
        Result := AStrings[i]
      else
        Result := Result + AstrDividerSymbol + AStrings[i];
end; // ArrayToParameters

end. ////////////////////////// end of file //////////////////////////////////
