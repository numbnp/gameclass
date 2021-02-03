//////////////////////////////////////////////////////////////////////////////
//
// Модуль функций общего назначения
//
// Карамани Юрий
//
//////////////////////////////////////////////////////////////////////////////

unit uY2KCommon;

interface

uses
  // system units

{$IFDEF MSWINDOWS}
//  Windows,
  Graphics,
{$ENDIF}
{$IFDEF LINUX}
  QGraphics,
{$ENDIF}
  Types;

const
  // В SDK константа описана в WinBase.h,
  // для Delphi пришлось определять самому.
  INVALID_SET_FILE_POINTER = DWORD(-1);


  // Нулевой заголовок.
  NULL_HANDLE = 0;


  // пустая строка
  EMPTY_STRING = '';


  // Константы для адекватного представления временных задержек
  // виесто значения в миллисекундах можно указать значение
  // в секундах или в минутах умноженные на константы.
  // К примеру: PAUSE = 10 * SECONDS {10 секунд}
  SECONDS = 1000;
  MINUTES = 60000;
  HOURS = 3600000;


type
  // Результат выполнения функции
  // (замена булевому типу, сигнализирующему об ошибке).
  TFunctionResult = (RES_SUCCESS, RES_ERROR);


  // перечисление вспомогательных операций класса
  // для реализации шаблона Singleton
  TSingletonOperation = (
      SinglOper_Access,
      SinglOper_Create,
      SinglOper_Destroy
  );


// метод заглушка, вызывающий в release-сборке ошибку на этапе компиляции
{$IFOPT D+}
procedure STUB();
{$ENDIF}

// Вызов метода Free объекта, присвоение объектной переменной nil.
// Генерация ASSERT исключения, если в качестве параметра передается nil.
procedure FreeAndNilWithAssert(var Aobj);

// увеличить значение указателя
function IncPointer(const Aptr: Pointer; const AnValue: Integer = 1): Pointer;

// уменьшить значение указателя
function DecPointer(const Aptr: Pointer; const AnValue: Integer = 1): Pointer;

// преобразовать указатель в строку
function PointerToStr(const Aptr: Pointer): String;

// IsNull для OleVariant
function IsNull(Parameter: OleVariant; Replacement: OleVariant): OleVariant;

// преобразовать строку в шрифт
function StrToFont(const AstrFont: String): TFont;

// преобразовать шрифт в строку
function FontToStr(const AFont: TFont): String;

implementation

uses
  // system units
  Variants,
  SysUtils,
  // project units
  uY2KString,
  System.UITypes;



{$IFOPT D+}
procedure STUB();
begin
end; // STUB
{$ENDIF}


procedure FreeAndNilWithAssert(var Aobj);
begin
  ASSERT(Assigned(Pointer(Aobj)));
  FreeAndNil(TObject(Aobj));
end; // FreeAndNilWithAssert


function IncPointer(const Aptr: Pointer; const AnValue: Integer = 1): Pointer;
begin
  PAnsiChar(Result) := PAnsiChar(Aptr) + AnValue;
end; // IncPointer


function DecPointer(const Aptr: Pointer; const AnValue: Integer = 1): Pointer;
begin
  PAnsiChar(Result) := PAnsiChar(Aptr) - AnValue;
end; // DecPointer


function PointerToStr(const Aptr: Pointer): String;
begin
  Result := IntToStr(LongInt(Aptr));
end; // PointerToStr



function IsNull(Parameter: OleVariant; Replacement: OleVariant): OleVariant;
begin
  IsNull := Replacement;
  if not VarIsNull(Parameter) then
    IsNull := Parameter;
end;

function FontToStr(const AFont: TFont): String;
begin
  with AFont do begin
    Result := IntToStr(Integer(Charset))
        + '/' + IntToStr(Color)
        + '/'+ IntToStr(Height)
        + '/'+ Name
        + '/'+ IntToStr(Integer(Pitch))
        + '/'+ IntToStr(Size)
        + '/S';
    if fsBold	in Style then
      Result := Result + 'B';
    if fsItalic	in Style then
      Result := Result + 'I';
    if fsUnderline in Style then
      Result := Result + 'U';
    if fsStrikeOut in Style then
      Result := Result + 'O';
  end;
end;

function StrToFont(const AstrFont: String): TFont;
var
  strStyle: String;
begin
  Result := Nil;
  if (GetParamCountFromString(AstrFont) <> 7) then
    exit;
  Result := TFont.Create;
  Result.Charset := TFontCharset(StrToInt(GetParamFromString(AstrFont, 0)));
  Result.Color := StrToInt(GetParamFromString(AstrFont, 1));
  Result.Height := StrToInt(GetParamFromString(AstrFont, 2));
  Result.Name := GetParamFromString(AstrFont, 3);
  Result.Pitch := TFontPitch(StrToInt(GetParamFromString(AstrFont, 4)));
  Result.Size := StrToInt(GetParamFromString(AstrFont, 5));
  strStyle := GetParamFromString(AstrFont, 6);
  if (Pos('B', strStyle) <> 0) then
    Result.Style := Result.Style + [fsBold];
  if (Pos('I', strStyle) <> 0) then
    Result.Style := Result.Style + [fsItalic];
  if (Pos('U', strStyle) <> 0) then
    Result.Style := Result.Style + [fsUnderline];
  if (Pos('O', strStyle) <> 0) then
    Result.Style := Result.Style + [fsStrikeOut];
end;


end. ////////////////////////// end of file //////////////////////////////////
