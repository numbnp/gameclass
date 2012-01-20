//////////////////////////////////////////////////////////////////////////////
//
// Модуль содержит описание и реализацию класса TClientOptionsRegistryStorage.
// Класс предназначен для сохранения настроек приложения в реестре ОС.
//
//////////////////////////////////////////////////////////////////////////////

unit uClientOptionsRegistryStorage;

interface

uses
  // project units
  uY2KCommon, uClientOptionsStorage;


type

  //
  // TClientOptionsRegistryStorage
  //

  TClientOptionsRegistryStorage = class(TClientOptionsStorage)
  private

    // private helper methods
    function _SaveOption(const AstrFolder: String; const AstrName: String;
        const AstrValue: String): TFunctionResult; override;
    function _GetOption(const AstrFolder: String; const AstrName: String;
        var AstrValue: String): TFunctionResult; override;

  public

  end; // TClientOptionsRegistryStorage


implementation


uses
  // system units
  SysUtils,
  Windows,
  Registry;

const
  NOT_DEFAULT_VALUE = '{AB0AEBB0-F24C-49E8-883D-B0A20432729E}';

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private methods

// Exceptions: EAssertionFailed
function TClientOptionsRegistryStorage._SaveOption(const AstrFolder: String;
    const AstrName: String; const AstrValue: String): TFunctionResult;
var
  Reg: TRegIniFile;
begin
  Result := RES_ERROR;

  Reg := TRegIniFile.Create();
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    Reg.Access := KEY_WRITE;
    if Reg.OpenKey(FstrKey, TRUE) then begin
      Reg.WriteString(AstrFolder, AstrName, AstrValue);
      Result := RES_SUCCESS;
      Reg.CloseKey();
    end;
  finally
    FreeAndNilWithAssert(Reg);
  end;

end; // TClientOptionsStorage._SaveOption


// Exceptions: EAssertionFailed
function TClientOptionsRegistryStorage._GetOption(const AstrFolder: String;
    const AstrName: String; var AstrValue: String): TFunctionResult;
var
  Reg: TRegIniFile;
begin
  Result := RES_ERROR;

  Reg := TRegIniFile.Create();
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    Reg.Access := KEY_READ;
    if Reg.OpenKey(FstrKey, TRUE) then begin
      AstrValue := Reg.ReadString(AstrFolder, AstrName, NOT_DEFAULT_VALUE);
      if (AstrValue <> NOT_DEFAULT_VALUE) then
        Result := RES_SUCCESS
      else
        Result := RES_ERROR;
      Reg.CloseKey();
    end;
  finally
    FreeAndNilWithAssert(Reg);
  end;

end; // TClientOptionsStorage._GetOption


end.
