//////////////////////////////////////////////////////////////////////////////
//
// Модуль функций для работы с веткой реестра HKCU/Software/Gameclass3
//
// pva
//
//////////////////////////////////////////////////////////////////////////////

unit uSystemRegistryTools;

interface

uses
  Classes,
  Registry;


// registry for HKCU/Software/Gameclass3
procedure GCCommonRegistryWriteStr(param: string; value: string);
function GCCommonRegistryReadStr(param: string):string;
procedure GCCommonRegistryWriteInt(param: string; value: integer);
function GCCommonRegistryReadInt(param: string):integer;
function RegistryReadMultiString(const AKey: TRegistry;
    const AstrParamName: String): TStringList;
function RegistryWriteMultiString(const AKey: TRegistry;
    const AstrParamName: String; const AlstStrings: TStringList): Boolean;

implementation

Uses
  Windows,
  SysUtils;

// registry
procedure GCCommonRegistryWriteStr(param: string; value: string);
var
  reg: TRegistry;
begin
  Reg := TRegistry.Create;
  Reg.RootKey := HKEY_CURRENT_USER;
  if Reg.OpenKey('\Software\GameClass3',False) then
  begin
    Reg.WriteString(param, value);
    Reg.CloseKey;
    Reg.Free;
  end;  
end;

// registry
function GCCommonRegistryReadStr(param: string):string;
var
  reg: TRegistry;
begin
  Reg := TRegistry.Create;
  Reg.RootKey := HKEY_CURRENT_USER;
  if Reg.OpenKey('\Software\GameClass3',False) then
  begin
    try
      GCCommonRegistryReadStr := Reg.ReadString(param);
    except
      GCCommonRegistryReadStr := '';
    end;  
    Reg.CloseKey;
    Reg.Free;
  end;  
end;

// registry
procedure GCCommonRegistryWriteInt(param: string; value: integer);
var
  reg: TRegistry;
begin
  Reg := TRegistry.Create;
  Reg.RootKey := HKEY_CURRENT_USER;
  if Reg.OpenKey('\Software\GameClass3',False) then
  begin
    Reg.WriteInteger(param, value);
    Reg.CloseKey;
    Reg.Free;
  end;  
end;

// registry
function GCCommonRegistryReadInt(param: string):integer;
var
  reg: TRegistry;
begin
  Reg := TRegistry.Create;
  Reg.RootKey := HKEY_CURRENT_USER;
  if Reg.OpenKey('\Software\GameClass3',False) then
  begin
    try
      GCCommonRegistryReadInt := Reg.ReadInteger(param);
    except
      GCCommonRegistryReadInt := -1;
    end;
    Reg.CloseKey;
    Reg.Free;
  end  
  else
    GCCommonRegistryReadInt := -1;
end;

function RegistryReadMultiString(const AKey: TRegistry;
    const AstrParamName: String): TStringList;
var
  buf: Pointer;
  nBufSize: Integer;
  p: PChar;
begin
  Result := Nil;
  try
    nBufSize := AKey.GetDataSize(AstrParamName);
    GetMem(buf, nBufSize);
    AKey.ReadBinaryData(AstrParamName, buf^, nBufSize);
    Result := TStringList.Create;
    p := buf;
    while p^ <> #0 do begin
      Result.Add(p);
      Inc(p, StrLen(p) + 1);
    end;
    FreeMem(buf);
  except
  end;
end;

function RegistryWriteMultiString(const AKey: TRegistry;
    const AstrParamName: String; const AlstStrings: TStringList): Boolean;
var
//  buf: Pointer;
  nBufSize: Integer;
  p, buf: PChar;
  i: Integer;
begin
  Result := False;
  if Not Assigned(AlstStrings) then
    exit;
  nBufSize := 1;
  for i := 0 to AlstStrings.Count - 1 do
    Inc(nBufSize, Length(AlstStrings[i]) + 1);
  try
    GetMem(buf, nBufSize);
    p := buf;
    for i := 0 to AlstStrings.Count - 1 do begin
      CopyMemory(p, PChar(AlstStrings[i]), Length(AlstStrings[i]));
      Inc(p, Length(AlstStrings[i]));
      p^ := #0;
      Inc(p);
    end;
    p^ := #0;
    RegSetValueEx(AKey.CurrentKey, PChar(AstrParamName), 0, REG_MULTI_SZ,
        buf, nBufSize);
//    AKey.WriteExpandString(AstrParamName, buf^, nBufSize);
    Result := True;
    FreeMem(buf);
  except
  end;
end;

end.
