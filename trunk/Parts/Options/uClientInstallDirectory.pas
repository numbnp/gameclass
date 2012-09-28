//////////////////////////////////////////////////////////////////////////////
//
// Модуль содержит процедуру GetInstallDirectory.
//
//////////////////////////////////////////////////////////////////////////////

unit uClientInstallDirectory;

interface

    //Папка в кот. установлен клиент
    function InstallDirectory: String;


implementation
uses
  uClientOptionsConst,
  Windows,
  Registry,
  uY2KCommon;

var
  GstrInstallDirectory: String;


function GetInstallDirectory: String;
var
  Reg: TRegIniFile;
  FstrKey: String;
  AstrValue: String;
begin
  Result := '';
  FstrKey := '\' + 'Software' + '\' + PRODUCT_NAME;
  Reg := TRegIniFile.Create();
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    Reg.Access := KEY_ALL_ACCESS;
    if Reg.OpenKey(FstrKey, TRUE) then begin
      AstrValue := Reg.ReadString(OPTIONS_GENERAL_FOLDER, 'InstallDirectory',
          'C:\Program files\GameClass3\Client');
      Result := AstrValue;
      Reg.CloseKey();
    end;
  finally
    FreeAndNilWithAssert(Reg);
  end
end;

function InstallDirectory: String;
begin
  Result := GstrInstallDirectory;
end;


initialization
  GstrInstallDirectory := GetInstallDirectory;


end.


