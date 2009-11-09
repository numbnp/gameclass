unit uRegistryOptionsStorage;

interface

uses
  Windows,
  uOption,
  uOptionsStorage;

type

  //
  // TRegistryOptionsStorage
  //

  TRegistryOptionsStorage = class(TOptionsStorage)
  private
    // fields
    FHKEY: HKEY;
    FstrPath: String;

    procedure _LoadOption(const AstrFolderName: String;
        var AOption: TStringOption); overload;
    procedure _SaveOption(const AstrFolderName: String;
        const AOption: TStringOption); overload;

    procedure _LoadOption(const AstrFolderName: String;
        var AOption: TIntegerOption); overload;
    procedure _SaveOption(const AstrFolderName: String;
        const AOption: TIntegerOption); overload;

    procedure _LoadOption(const AstrFolderName: String;
        var AOption: TBooleanOption); overload;
    procedure _SaveOption(const AstrFolderName: String;
        const AOption: TBooleanOption); overload;

  public
    // constructor / destructor
    constructor Create(const AHKEY: HKEY; const AstrPath: String);

    // public methods
    procedure LoadOption(const AstrFolderName: String;
        var AOption: TOption); override;
    procedure SaveOption(const AstrFolderName: String;
        const AOption: TOption); override;


  end; // TRegistryOptionsStorage


implementation

uses
  SysUtils,
  Registry;

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TRegistryOptionsStorage.Create(
    const AHKEY: HKEY; const AstrPath: String);
begin
  inherited Create();
  FHKEY := AHKEY;
  FstrPath := AstrPath;
end; // TRegistryOptionsStorage.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TRegistryOptionsStorage.LoadOption(const AstrFolderName: String;
    var AOption: TOption);
begin
  if AOption is TStringOption then begin
    _LoadOption(AstrFolderName, TStringOption(AOption));
  end else if AOption is TIntegerOption then begin
    _LoadOption(AstrFolderName, TIntegerOption(AOption));
  end else if AOption is TBooleanOption then begin
    _LoadOption(AstrFolderName, TBooleanOption(AOption));
  end;
end;


procedure TRegistryOptionsStorage.SaveOption(const AstrFolderName: String;
    const AOption: TOption);
begin
  if AOption is TStringOption then begin
    _SaveOption(AstrFolderName, AOption as TStringOption);
  end else if AOption is TIntegerOption then begin
    _SaveOption(AstrFolderName, AOption as TIntegerOption);
  end else if AOption is TBooleanOption then begin
    _SaveOption(AstrFolderName, AOption as TBooleanOption);
  end;
end;


procedure TRegistryOptionsStorage._LoadOption(const AstrFolderName: String;
    var AOption: TStringOption);
var
  Reg: TRegIniFile;
begin
  Reg := TRegIniFile.Create();
  try
    Reg.RootKey := FHKEY;
    Reg.Access := KEY_READ;
    if Reg.OpenKey(FstrPath, TRUE) then begin
      AOption.Value := Reg.ReadString(AstrFolderName,
          AOption.Name, AOption.DefValue);
      AOption.Update();          
      Reg.CloseKey();
    end;
  finally
    FreeAndNil(Reg);
  end;
end; // TRegistryOptionsStorage._LoadOption


procedure TRegistryOptionsStorage._SaveOption(const AstrFolderName: String;
    const AOption: TStringOption);
var
  Reg: TRegIniFile;
begin
  Reg := TRegIniFile.Create();
  try
    Reg.RootKey := FHKEY;
    Reg.Access := KEY_WRITE;
    if Reg.OpenKey(FstrPath, TRUE) then begin
      Reg.WriteString(AstrFolderName, AOption.Name, AOption.Value);
      AOption.Update();      
      Reg.CloseKey();
    end;
  finally
    FreeAndNil(Reg);
  end;
end; // TRegistryOptionsStorage._SaveOption


procedure TRegistryOptionsStorage._LoadOption(const AstrFolderName: String;
    var AOption: TIntegerOption);
var
  Reg: TRegIniFile;
begin
  Reg := TRegIniFile.Create();
  try
    Reg.RootKey := FHKEY;
    Reg.Access := KEY_READ;
    if Reg.OpenKey(FstrPath, TRUE) then begin
      AOption.Value := Reg.ReadInteger(AstrFolderName,
          AOption.Name, AOption.DefValue);
      AOption.Update();
      Reg.CloseKey();
    end;
  finally
    FreeAndNil(Reg);
  end;
end; // TRegistryOptionsStorage._LoadOption


procedure TRegistryOptionsStorage._SaveOption(const AstrFolderName: String;
    const AOption: TIntegerOption);
var
  Reg: TRegIniFile;
begin
  Reg := TRegIniFile.Create();
  try
    Reg.RootKey := FHKEY;
    Reg.Access := KEY_WRITE;
    if Reg.OpenKey(FstrPath, TRUE) then begin
      Reg.WriteInteger(AstrFolderName, AOption.Name, AOption.Value);
      AOption.Update();
      Reg.CloseKey();
    end;
  finally
    FreeAndNil(Reg);
  end;
end; // TRegistryOptionsStorage._SaveOption


procedure TRegistryOptionsStorage._LoadOption(const AstrFolderName: String;
    var AOption: TBooleanOption);
var
  Reg: TRegIniFile;
begin
  Reg := TRegIniFile.Create();
  try
    Reg.RootKey := FHKEY;
    Reg.Access := KEY_READ;
    if Reg.OpenKey(FstrPath, TRUE) then begin
      AOption.Value := Reg.ReadBool(AstrFolderName,
          AOption.Name, AOption.DefValue);
      AOption.Update();
      Reg.CloseKey();
    end;
  finally
    FreeAndNil(Reg);
  end;
end; // TRegistryOptionsStorage._LoadOption


procedure TRegistryOptionsStorage._SaveOption(const AstrFolderName: String;
    const AOption: TBooleanOption);
var
  Reg: TRegIniFile;
begin
  Reg := TRegIniFile.Create();
  try
    Reg.RootKey := FHKEY;
    Reg.Access := KEY_WRITE;
    if Reg.OpenKey(FstrPath, TRUE) then begin
      Reg.WriteBool(AstrFolderName, AOption.Name, AOption.Value);
      AOption.Update();
      Reg.CloseKey();
    end;
  finally
    FreeAndNil(Reg);
  end;
end; // TRegistryOptionsStorage._SaveOption


end.
