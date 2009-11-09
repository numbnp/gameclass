//////////////////////////////////////////////////////////////////////////////
//
// Модуль содержит описание и реализацию класса TClientOptionsIniStorage.
// Класс предназначен для сохранения настроек приложения в INI-файле.
//
//////////////////////////////////////////////////////////////////////////////

unit uClientOptionsIniStorage;

interface

uses
  // project units
  SyncObjs,
  uY2KCommon,
  uClientOptionsStorage;


type

  //
  // TClientOptionsIniStorage
  //

  TClientOptionsIniStorage = class(TClientOptionsStorage)
  private

    // private helper methods
    function _SaveOption(const AstrFolder: String; const AstrName: String;
        const AstrValue: String): TFunctionResult; override;
    function _GetOption(const AstrFolder: String; const AstrName: String;
        var AstrValue: String): TFunctionResult; override;

  public

  end; // TClientOptionsIniStorage

var  
  csReadWriteIniFile: TCriticalSection;


implementation


uses
  // system units
  uDebugLog,
  StrUtils,
  SysUtils,
  IniFiles,
  Types;

const
  NOT_DEFAULT_VALUE = '{AB0AEBB0-F24C-49E8-883D-B0A20432729E}';
  DEF_INI_FILENAME = 'gccllin.ini';

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private methods

// Exceptions: EAssertionFailed
function TClientOptionsIniStorage._SaveOption(const AstrFolder: String;
    const AstrName: String; const AstrValue: String): TFunctionResult;
var
  Reg: TIniFile;
  strValue: String;
begin
  Result := RES_ERROR;
  csReadWriteIniFile.Acquire();
  try
    try
      Reg := TIniFile.Create(ExtractFilePath(ParamStr(0))+ DEF_INI_FILENAME);
      try
        strValue := AnsiReplaceStr(AstrValue, #13#10, #10);
        strValue := AnsiReplaceStr(strValue, #13, #10);
        strValue := AnsiReplaceStr(strValue, #10, #09#09#09);
        Reg.WriteString(AstrFolder, AstrName, strValue);
        Result := RES_SUCCESS;
      finally
        FreeAndNilWithAssert(Reg);
      end;
    finally
      csReadWriteIniFile.Release();
    end;
  except
    on e: Exception do begin
      Debug.Trace0('IniStorage._SaveOption error! ' + e.Message);
    end;
  end;

end; // TClientOptionsStorage._SaveOption


// Exceptions: EAssertionFailed
function TClientOptionsIniStorage._GetOption(const AstrFolder: String;
    const AstrName: String; var AstrValue: String): TFunctionResult;
var
  Reg: TIniFile;
begin
  Result := RES_ERROR;
  csReadWriteIniFile.Acquire();
  try
    try
      Reg := TIniFile.Create(ExtractFilePath(ParamStr(0)) + DEF_INI_FILENAME);
      try
        if Reg.ValueExists(AstrFolder, AstrName) then begin
          AstrValue := Reg.ReadString(AstrFolder, AstrName, NOT_DEFAULT_VALUE);
          AstrValue := AnsiReplaceStr(AstrValue, #09#09#09, #10);
          Result := RES_SUCCESS;
        end else
          Result := RES_ERROR;
      finally
        FreeAndNilWithAssert(Reg);
      end;
    finally
      csReadWriteIniFile.Release();
    end;
  except
    on e: Exception do begin
      Debug.Trace0('IniStorage._GetOption error! ' + e.Message);
    end;
  end;
end; // TClientOptionsStorage._GetOption

initialization
  csReadWriteIniFile := TCriticalSection.Create();

finalization
  csReadWriteIniFile.Free();

end.
