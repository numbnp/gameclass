//////////////////////////////////////////////////////////////////////////////
//
// ћодуль содержит описание и реализацию класса TClientOptionsStorage.
//  ласс предназначен дл€ сохранени€ настроек приложени€ каким-либо способом.
//
//////////////////////////////////////////////////////////////////////////////

unit uClientOptionsStorage;

interface

uses
  // project units
  uY2KCommon;


type

  //
  // TClientOptionsStorage
  //

  TClientOptionsStorage = class(TObject)
  protected
    // fields
    FstrCompanyName: String;
    FstrProductName: String;
    FstrKey: String;

    // private helper methods
    function _SaveOption(const AstrFolder: String; const AstrName: String;
        const AstrValue: String): TFunctionResult; virtual; abstract;
    function _GetOption(const AstrFolder: String; const AstrName: String;
        var AstrValue: String): TFunctionResult; virtual; abstract;

  public
    // constructor / destructor
    constructor Create(); overload;
    constructor Create(const AstrCompanyName: String;
        const AstrProductName: String); overload;
    destructor Destroy(); override;

    // public methods
    function SaveOption(const AstrFolder: String; const AstrName: String;
        const AstrValue: String): TFunctionResult; overload;
    function SaveOption(const AstrFolder: String; const AstrName: String;
        const AnValue: Integer): TFunctionResult; overload;
    function SaveOption(const AstrFolder: String; const AstrName: String;
        const AbValue: Boolean): TFunctionResult; overload;
    function SaveOption(const AstrFolder: String; const AstrName: String;
        const AfValue: Double): TFunctionResult; overload;

    function GetOption(const AstrFolder: String; const AstrName: String;
        var AstrValue: String): TFunctionResult; overload;
    function GetOption(const AstrFolder: String; const AstrName: String;
        var AnValue: Integer): TFunctionResult; overload;
    function GetOption(const AstrFolder: String; const AstrName: String;
        var AbValue: Boolean): TFunctionResult; overload;
    function GetOption(const AstrFolder: String; const AstrName: String;
        var AfValue: Double): TFunctionResult; overload;

  end; // TClientOptionsStorage


implementation

uses
  // system units
  SysUtils,
{$IFDEF MSWINDOWS}
  Registry,
{$ENDIF}
  Types;


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

// Exceptions: EAssertionFailed
constructor TClientOptionsStorage.Create();
begin
  ASSERT(FALSE, 'Cannot call constructor w/o parameters!');
end; // TClientOptionsStorage.Create


constructor TClientOptionsStorage.Create(const AstrCompanyName: String;
    const AstrProductName: String);
begin
  inherited Create();

  FstrCompanyName := AstrCompanyName;
  FstrProductName := AstrProductName;
  FstrKey := '\' + 'Software' + '\' + FstrProductName;

end; // TClientOptionsStorage.Create


destructor TClientOptionsStorage.Destroy();
begin
  inherited Destroy();
end; // TClientOptionsStorage.Destroy


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

function TClientOptionsStorage.SaveOption(const AstrFolder: String;
    const AstrName: String; const AstrValue: String): TFunctionResult;
begin
  Result := _SaveOption(AstrFolder, AstrName, AstrValue);
end; // TClientOptionsStorage.SaveOption


function TClientOptionsStorage.SaveOption(const AstrFolder: String;
    const AstrName: String; const AnValue: Integer): TFunctionResult;
begin
  Result := _SaveOption(AstrFolder, AstrName, IntToStr(AnValue));
end; // TClientOptionsStorage.SaveOption


function TClientOptionsStorage.SaveOption(const AstrFolder: String;
    const AstrName: String; const AbValue: Boolean): TFunctionResult;
begin
  Result := _SaveOption(AstrFolder, AstrName, BoolToStr(AbValue));
end; // TClientOptionsStorage.SaveOption


function TClientOptionsStorage.SaveOption(const AstrFolder: String;
    const AstrName: String; const AfValue: Double): TFunctionResult;
begin
  Result := _SaveOption(AstrFolder, AstrName, FloatToStr(AfValue));
end; // TClientOptionsStorage.SaveOption


function TClientOptionsStorage.GetOption(const AstrFolder: String;
    const AstrName: String; var AstrValue: String): TFunctionResult;
var
  strValue: String;
begin
  Result := _GetOption(AstrFolder, AstrName, strValue);
  if Result = RES_SUCCESS then begin
    AstrValue := strValue;
  end;
end; // TClientOptionsStorage.GetOption


// Exceptions: EAssertionFailed
function TClientOptionsStorage.GetOption(const AstrFolder: String;
    const AstrName: String; var AnValue: Integer): TFunctionResult;
var
  strValue: String;
begin
  Result := _GetOption(AstrFolder, AstrName, strValue);
  if Result = RES_SUCCESS then begin
    try
      AnValue := StrToInt(strValue);
    except
      on e: Exception do begin
        Result := RES_ERROR;
        //STUB();
//        ASSERT(FALSE, e.Message);
      end;
    end;
  end;
end; // TClientOptionsStorage.GetOption


// Exceptions: EAssertionFailed
function TClientOptionsStorage.GetOption(const AstrFolder: String;
    const AstrName: String; var AbValue: Boolean): TFunctionResult;
var
  strValue: String;
begin
  Result := _GetOption(AstrFolder, AstrName, strValue);
  if Result = RES_SUCCESS then begin
    try
      AbValue := StrToBool(strValue);
    except
      on e: Exception do begin
        Result := RES_ERROR;
        //ASSERT(FALSE, e.Message);
      end;
    end;
  end;
end; // TClientOptionsStorage.GetOption


// Exceptions: EAssertionFailed
function TClientOptionsStorage.GetOption(const AstrFolder: String;
    const AstrName: String; var AfValue: Double): TFunctionResult;
var
  strValue: String;
begin
  Result := _GetOption(AstrFolder, AstrName, strValue);
  if Result = RES_SUCCESS then begin
    try
      AfValue := StrToFloat(strValue);
    except
      on e: Exception do begin
        Result := RES_ERROR;
        //ASSERT(FALSE, e.Message);
      end;
    end;
  end;
end; // TClientOptionsStorage.GetOption


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private methods

// Exceptions: EAssertionFailed

end.
