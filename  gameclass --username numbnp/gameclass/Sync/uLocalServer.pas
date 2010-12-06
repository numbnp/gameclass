unit uLocalServer;

interface

function ReadLocalServerName: String;
procedure WriteLocalServerName(const AstrServerName: String);
function ReadBeepOnFailedConnect: Boolean;
procedure WriteBeepOnFailedConnect(const AbBeepOnFailedConnect: Boolean);

implementation

uses
  Windows,
  Registry,
  SysUtils;

const
  GC_OPTIONS_KEY = '\Software\GameClass3';
  GC_OPTIONS_NAME = 'Logon_server1';
  GCSYNC_OPTIONS_KEY = '\Software\Nodasoft\GCSync';
  GCSYNC_OPTIONS_NAME = 'LocalServerName';
  GCSYNC_OPTIONS_BEEP = 'BeepOnFailedConnect';


function ReadLocalServerName: String;
var
  reg: TRegistry;
  bTryHKCU: Boolean;
begin
  Result := '127.0.0.1';
  reg := TRegistry.Create;
  bTryHKCU := False;
  reg.RootKey := HKEY_LOCAL_MACHINE;
  if reg.OpenKey(GCSYNC_OPTIONS_KEY, False) then begin
    try
      Result := reg.ReadString(GCSYNC_OPTIONS_NAME);
    except
      bTryHKCU := True;
    end;
    reg.CloseKey;
  end;
  // пытаемся взять значение из логина GC
  if bTryHKCU then begin
    reg.RootKey := HKEY_CURRENT_USER;
    if reg.OpenKey(GC_OPTIONS_KEY, False) then begin
      try
        Result := reg.ReadString(GC_OPTIONS_NAME);
      except
      end;
      reg.CloseKey;
    end;
  end;
  FreeAndNil(reg);
end;

procedure WriteLocalServerName(const AstrServerName: String);
var
  reg: TRegistry;
begin
  Reg := TRegistry.Create;
  Reg.RootKey := HKEY_LOCAL_MACHINE;
  if Reg.OpenKey(GCSYNC_OPTIONS_KEY, True) then
  begin
    Reg.WriteString(GCSYNC_OPTIONS_NAME, AstrServerName);
    Reg.CloseKey;
    Reg.Free;
  end;
end;

function ReadBeepOnFailedConnect: Boolean;
var
  reg: TRegistry;
begin
  Result := False;
  reg := TRegistry.Create;
  reg.RootKey := HKEY_LOCAL_MACHINE;
  if reg.OpenKey(GCSYNC_OPTIONS_KEY, False) then begin
    try
      Result := StrToBoolDef(reg.ReadString(GCSYNC_OPTIONS_BEEP), False);
    except
    end;
    reg.CloseKey;
  end;
  FreeAndNil(reg);
end;

procedure WriteBeepOnFailedConnect(const AbBeepOnFailedConnect: Boolean);
var
  reg: TRegistry;
begin
  Reg := TRegistry.Create;
  Reg.RootKey := HKEY_LOCAL_MACHINE;
  if Reg.OpenKey(GCSYNC_OPTIONS_KEY, True) then
  begin
    Reg.WriteString(GCSYNC_OPTIONS_BEEP, BoolToStr(AbBeepOnFailedConnect));
    Reg.CloseKey;
    Reg.Free;
  end;
end;
end.
