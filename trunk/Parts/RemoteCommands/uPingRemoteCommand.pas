//////////////////////////////////////////////////////////////////////////////
//
// TPingRemoteCommand
// Класс команд, поступающих от управляющего сервера, которые предназначены
// для получения отклика и установки закладки инета и громкости звука.
//
//////////////////////////////////////////////////////////////////////////////

unit uPingRemoteCommand;

interface

uses
  // project units
  uRemoteCommand;

type

  //
  // TPingRemoteCommand
  //

  TPingRemoteCommand = class(TRemoteCommand)
  private
    // fields
    FbEnableInternet: Boolean;
    FnMain: Integer;
    FnWave: Integer;
    FbMute: Boolean;
    FbSetVolume: Boolean;

    // private helper methods
    function _GetIntegerParameFromString(
        const AstrValue: String; const AnParamIndex: Integer;
        const AnDefaultValue: Integer): Integer;

  public
    // constructor / destructor
    constructor Create(const AstrParameters: String);

    // public methods
    procedure Execute(); override;

  end; // TPingRemoteCommand


implementation

uses
  // system units
  SysUtils,
  // project units
  uDebugLog,
  uY2KString,
  uY2KCommon,
  Types,
{$IFDEF MSWINDOWS}
  Windows,
  Messages,
  uControlVolume,
{$ENDIF}
  uClientOptions;


const
  MAIN_DEF = 0;
  {WAVE_DEF = 0;
  MUTE_DEF = 0;}
  SET_VOLUME_DEF = 0;


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TPingRemoteCommand.Create(const AstrParameters: String);
var
  nParameter: Integer;
begin
  inherited Create();

  nParameter := _GetIntegerParameFromString(
      AstrParameters, 0, SET_VOLUME_DEF);
  FbEnableInternet := (nParameter = 0); //если 0 - инет доступен

  {nParameter := _GetIntegerParameFromString(AstrParameters, 1, MAIN_DEF);
  FnMain := nParameter;

  nParameter := _GetIntegerParameFromString(AstrParameters, 2, WAVE_DEF);
  FnWave := nParameter;

  nParameter := _GetIntegerParameFromString(AstrParameters, 3, MUTE_DEF);
  FbMute := (nParameter = 1);

  nParameter := _GetIntegerParameFromString(
      AstrParameters, 4, SET_VOLUME_DEF);
  FbSetVolume := (nParameter = 1);}

end; // TPingRemoteCommand.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TPingRemoteCommand.Execute();

//{$IFDEF MSWINDOWS}
{var
  ControlVolume: TControlVolume;}
//{$ENDIF}
begin
{$IFDEF MSWINDOWS}
  if GClientOptions.RunPadInternetControl then
    try
      if FbEnableInternet then
        PostMessage(FindWindow('_RunpadClass',nil),WM_USER+16,1,0)
      else
        PostMessage(FindWindow('_RunpadClass',nil),WM_USER+16,0,0);
    except
      ASSERT(FALSE, 'RunPad not found!');
    end;
  {ControlVolume := TControlVolume.Create();
  try
    try
      ControlVolume.SetVolumeLimit(FnMain, FnWave, FbMute, FbSetVolume);
    except
      ASSERT(FALSE, 'PingLimit error!');
    end;
  finally
    FreeAndNilWithAssert(ControlVolume);
  end;}
{$ENDIF}
{$IFDEF LINUX}
{  ControlVolume := TControlVolume.Create();
  try
    try
      ControlVolume.SetVolumeLimit(FnMain, FnWave, FbMute, FbSetVolume);
    except
      ASSERT(FALSE, 'PingLimit error!');
    end;
  finally
    FreeAndNilWithAssert(ControlVolume);
  end;
}
{$ENDIF}
end; // TPingRemoteCommand.Execute


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private helper methods

function TPingRemoteCommand._GetIntegerParameFromString(
    const AstrValue: String; const AnParamIndex: Integer;
    const AnDefaultValue: Integer): Integer;
var
  strValue: String;
begin
  try
    strValue := GetParamFromString(AstrValue, AnParamIndex);
    Result := StrToInt(strValue);
  except
    Result := AnDefaultValue;
  end;
end; // TPingRemoteCommand._GetIntegerParameFromString


end.
