//////////////////////////////////////////////////////////////////////////////
// CtrlVolume.pas - description
//
// begin            : 13 may 2004
// copyright        : (c) 2004 by Semeshko Alexey
// email            : dromoc@mail.ru
//////////////////////////////////////////////////////////////////////////////

unit uControlVolume;

interface

uses
  // system units
  Windows,
  Messages,
  Classes,
  ExtCtrls,
  ComCtrls,
  MMSystem,
  Mixer,
  ActiveX;

type

  //
  // TControlVolume
  //

  TControlVolume = class(TObject)
  protected
    FMixer: Tmixer;
    // protected methods
  public
    constructor Create();
    function GetMainVolume(): Integer;
    function SetMainVolume(const AnVolume : Integer): Boolean;
    function GetWaveVolume(): Integer;
    function SetWaveVolume(const AnVolume: Integer): Boolean;
    function SetMute(const AbIsOn: Boolean): Boolean;

    function SetVolumeLimit(const AnMain: Integer;
        const AnWave: Integer; const AbMute: Boolean;
        const AbSetVolume: Boolean): Boolean;

  end; // TControlVolume


implementation

uses
  // system units
  Math,
  SysUtils,
  // project units
  uDebugLog;


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

constructor TControlVolume.Create();
begin
  inherited Create();
  FMixer:= g_mixer;
end;


function TControlVolume.GetMainVolume(): Integer;
begin
  Result := FMixer.volume;
end; // TControlVolume.GetMainVolume


function TControlVolume.SetMainVolume(const AnVolume: Integer): Boolean;

begin
  FMixer.volume := AnVolume;

  Result := TRUE;
end; // TControlVolume.SetMainVolume


function TControlVolume.GetWaveVolume(): Integer;
begin
  Result := 0;
end; // TControlVolume.GetWaveVolume


function TControlVolume.SetWaveVolume(const AnVolume : Integer): Boolean;
begin
  Result := TRUE;
end; // TControlVolume.SetWaveVolume


function TControlVolume.SetMute(const AbIsOn: Boolean): Boolean;
begin
  FMixer.muted := AbIsOn;
  Result := true;
end; // TControlVolume.SetMute


function TControlVolume.SetVolumeLimit(const AnMain: Integer;
    const AnWave: Integer; const AbMute: Boolean;
    const AbSetVolume: Boolean): Boolean;
begin

  if (GetMainVolume() > AnMain) or AbSetVolume then begin
    SetMainVolume(AnMain);
  end;

  if (GetWaveVolume() > AnWave) or AbSetVolume then begin
    SetWaveVolume(AnWave);
  end;

  SetMute(AbMute);

  Result := TRUE;

end; // TControlVolume.SetVolumeLimit

end.


