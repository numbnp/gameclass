//////////////////////////////////////////////////////////////////////////////
//
// Модуль содержит описание и реализацию класса TClientOptionsDBStorage.
// Класс предназначен для сохранения настроек приложения в реестре ОС.
//
//////////////////////////////////////////////////////////////////////////////

unit uClientOptionsDBStorage;

interface

uses
  // project units
  uY2KCommon,
  uClientOptionsStorage;


type

  //
  // TClientOptionsStorage
  //

  TClientOptionsDBStorage = class(TClientOptionsStorage)
  private

    // private helper methods
    function _SaveOption(const AstrFolder: String; const AstrName: String;
        const AstrValue: String): TFunctionResult; override;
    function _GetOption(const AstrFolder: String; const AstrName: String;
        var AstrValue: String): TFunctionResult; override;

  public

  end; // TClientOptionsStorage


implementation

uses
  // system units
  SysUtils,
  Windows,
  Registry,
  GCConst,
  uY2KString,
  uRegistry;


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private methods

// Exceptions: EAssertionFailed
function TClientOptionsDBStorage._SaveOption(const AstrFolder: String;
    const AstrName: String; const AstrValue: String): TFunctionResult;
begin
//  Result := RES_ERROR;
  GRegistry[AstrFolder + '_' + AstrName].Value := EncodeStringForSQL(AstrValue);
//  dsRegistrySave(AstrFolder + '_' + AstrName, EncodeStringForSQL(AstrValue));
  Result := RES_SUCCESS;
end; // TClientOptionsStorage._SaveOption


// Exceptions: EAssertionFailed
function TClientOptionsDBStorage._GetOption(const AstrFolder: String;
    const AstrName: String; var AstrValue: String): TFunctionResult;
begin
  Result := RES_ERROR;
  if GRegistry.IsPresent(AstrFolder + '_' + AstrName) then begin
    AstrValue := DecodeStringFromSQL(
        GRegistry[AstrFolder + '_' + AstrName].Value);
    Result := RES_SUCCESS;
  end;
{  AstrValue := DecodeStringFromSQL(dsRegistryLoad(AstrFolder + '_' + AstrName,
      PARAM_NOT_EXISTS));
  if AstrValue <> PARAM_NOT_EXISTS then
    Result := RES_SUCCESS;
}
end; // TClientOptionsStorage._GetOption


end.
