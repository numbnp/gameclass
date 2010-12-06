//////////////////////////////////////////////////////////////////////////////
//
// TSetVolumeRemoteCommand
//  ласс команд, поступающих от управл€ющего сервера, которые предназначены
// дл€ установки звуковых параметров компьютера.
//
//////////////////////////////////////////////////////////////////////////////

unit uSetVolumeRemoteCommand;

interface

uses
  // project units
  uRemoteCommand;

type

  //
  // TSetVolumeRemoteCommand
  //

  TSetVolumeRemoteCommand = class(TRemoteCommand)
  private
    // fields
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

  end; // TSetVolumeRemoteCommand


implementation

uses
  // system units
  SysUtils,
  // project units
{$IFDEF MSWINDOWS}
  uControlVolume,
{$ENDIF}
{$IFDEF LINUX}
//  uControlVolume,
{$ENDIF}
  uDebugLog,
  uY2KString,
  uY2KCommon;


const
  MAIN_DEF = 0;
  WAVE_DEF = 0;
  MUTE_DEF = 0;
  SET_VOLUME_DEF = 0;


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TSetVolumeRemoteCommand.Create(const AstrParameters: String);
var
  nParameter: Integer;
begin
  inherited Create();

  nParameter := _GetIntegerParameFromString(AstrParameters, 0, MAIN_DEF);
  FnMain := nParameter;

  nParameter := _GetIntegerParameFromString(AstrParameters, 1, WAVE_DEF);
  FnWave := nParameter;

  nParameter := _GetIntegerParameFromString(AstrParameters, 2, MUTE_DEF);
  FbMute := (nParameter = 1);

  nParameter := _GetIntegerParameFromString(
      AstrParameters, 3, SET_VOLUME_DEF);
  FbSetVolume := (nParameter = 1);

end; // TSetVolumeRemoteCommand.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods
{$IFDEF MSWINDOWS}
procedure TSetVolumeRemoteCommand.Execute();
var
  ControlVolume: TControlVolume;
begin
  ControlVolume := TControlVolume.Create();
  try
    try
      ControlVolume.SetVolumeLimit(FnMain, FnWave, FbMute, FbSetVolume);
    except
      ASSERT(FALSE, 'SetVolumeLimit error!');
    end;
  finally
    FreeAndNilWithAssert(ControlVolume);
  end;
end; // TSetVolumeRemoteCommand.Execute
{$ENDIF}
{$IFDEF LINUX}
procedure TSetVolumeRemoteCommand.Execute();
//var
//  ControlVolume: TControlVolume;
begin
//  ControlVolume := TControlVolume.Create();
  try
    try
  //    ControlVolume.SetVolumeLimit(FnMain, FnWave, FbMute, FbSetVolume);
    except
      ASSERT(FALSE, 'SetVolumeLimit error!');
    end;
  finally
//    FreeAndNilWithAssert(ControlVolume);
  end;
end; // TSetVolumeRemoteCommand.Execute
{$ENDIF}

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private helper methods

function TSetVolumeRemoteCommand._GetIntegerParameFromString(
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
end; // TSetVolumeRemoteCommand._GetIntegerParameFromString


end.
