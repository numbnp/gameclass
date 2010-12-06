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
  MMSystem;

type

  //
  // TControlVolume
  //

  TControlVolume = class(TObject)
  protected
    // protected methods
    function GetMasterMute(AhMixer: HMIXEROBJ;
        var AControl: TMixerControl): MMResult;
    function GetControlID(): Integer;

  public
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

function TControlVolume.GetMainVolume(): Integer;
var
  details: TMixerControlDetails;
  valdets: TMixerControlDetailsUnsigned;
begin
  with Details do begin
    cbStruct := Sizeof(Details);
    dwControlID := GetControlID;
    cChannels := 1;
    cMultipleItems := 0;
    cbDetails := SizeOf(Valdets);
    paDetails := @valdets;
  end;

  MixerGetControlDetails(0, @details, MIXER_GETCONTROLDETAILSF_VALUE);

  Result := Valdets.dwValue;
end; // TControlVolume.GetMainVolume


function TControlVolume.SetMainVolume(const AnVolume: Integer): Boolean;
var
  Details: TMixerControlDetails;
  Valdets: TMixerControlDetailsUnsigned;
begin
  with Details do begin
    cbStruct := SizeOf(Details);
    dwControlID := GetControlID;
    cChannels := 1;
    cMultipleItems := 0;
    cbDetails := SizeOf(Valdets);
    paDetails := @Valdets;
  end;

  valdets.dwValue := AnVolume;

  MixerSetControlDetails(0, @Details, MIXER_SETCONTROLDETAILSF_VALUE);

  Result := TRUE;
end; // TControlVolume.SetMainVolume


function TControlVolume.GetWaveVolume(): Integer;
var
  WaveOutCaps: TWaveOutCaps;
  nLVolume: Integer;
  nRVolume: Integer;
  nVolume: Integer;
begin
  Result := 0;
  if WaveOutGetDevCaps(WAVE_MAPPER, @WaveOutCaps, sizeof(WaveOutCaps))
      = MMSYSERR_NOERROR then begin

    if WaveOutCaps.dwSupport and WAVECAPS_VOLUME = WAVECAPS_VOLUME then begin
      WaveOutGetVolume(WAVE_MAPPER, @nVolume);
      nLVolume := (nVolume shr 16) and $FFFF;
      nRVolume := nVolume and $FFFF;
      Result := IfThen(nLVolume > nRVolume, nLVolume, nRVolume);
    end;

  end;
end; // TControlVolume.GetWaveVolume


function TControlVolume.SetWaveVolume(const AnVolume : Integer): Boolean;
var
  WaveOutCaps: TWaveOutCaps;
  nVolume: Integer;
begin
  Result := FALSE;
  nVolume := (AnVolume shl 16) or AnVolume;

  if WaveOutGetDevCaps(WAVE_MAPPER, @WaveOutCaps, sizeof(WaveOutCaps))
      = MMSYSERR_NOERROR then begin

    if WaveOutCaps.dwSupport and WAVECAPS_VOLUME = WAVECAPS_VOLUME then begin
      WaveOutSetVolume(WAVE_MAPPER, nVolume);
      Result := TRUE;
    end;

  end;

end; // TControlVolume.SetWaveVolume


function TControlVolume.SetMute(const AbIsOn: Boolean): Boolean;
var
  MasterMute: TMixerControl;
  Details: TMixerControlDetails;
  BoolDetails: TMixerControlDetailsBoolean;
  Code: MMResult;
begin
  Code := GetMasterMute(0, MasterMute);
  if Code = MMSYSERR_NOERROR then begin
    with Details do begin
      cbStruct := SizeOf(Details);
      dwControlID := MasterMute.dwControlID;
      cChannels := 1;
      cMultipleItems := 0;
      cbDetails := SizeOf(BoolDetails);
      paDetails := @BoolDetails;
    end;
    LongBool(BoolDetails.fValue) := AbIsOn;
    Code := mixerSetControlDetails(0, @Details,
      MIXER_SETCONTROLDETAILSF_VALUE);
  end;

  Result := (Code = MMSYSERR_NOERROR);

end; // TControlVolume.SetMute


function TControlVolume.SetVolumeLimit(const AnMain: Integer;
    const AnWave: Integer; const AbMute: Boolean;
    const AbSetVolume: Boolean): Boolean;
var
  MasterMute: TMixerControl;
  Code: MMResult;
begin
  Code := GetMasterMute(0, MasterMute);

  if Code <> MMSYSERR_NOERROR then begin
    Result := FALSE;
    exit;
  end;

  if (GetMainVolume() > AnMain) or AbSetVolume then begin
    SetMainVolume(AnMain);
  end;

  if (GetWaveVolume() > AnWave) or AbSetVolume then begin
    SetWaveVolume(AnWave);
  end;

  SetMute(AbMute);

  Result := TRUE;

end; // TControlVolume.SetVolumeLimit


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// protected methods

function TControlVolume.GetMasterMute(AhMixer: HMIXEROBJ;
    var AControl: TMixerControl): MMResult;
var
  Line: TMixerLine;
  Controls: TMixerLineControls;
begin
  ZeroMemory(@Line, SizeOf(Line));
  Line.cbStruct := SizeOf(Line);
  Line.dwComponentType := MIXERLINE_COMPONENTTYPE_DST_SPEAKERS;
  Result := mixerGetLineInfo(
      AhMixer, @Line, MIXER_GETLINEINFOF_COMPONENTTYPE);
  if Result = MMSYSERR_NOERROR then begin
    ZeroMemory(@Controls, SizeOf(Controls));
    Controls.cbStruct := SizeOf(Controls);
    Controls.dwLineID := Line.dwLineID;
    Controls.cControls := 1;
     Controls.dwControlType := MIXERCONTROL_CONTROLTYPE_MUTE;
    Controls.cbmxctrl := SizeOf(AControl);
    Controls.pamxctrl := @AControl;
    Result := mixerGetLineControls(
        AhMixer, @Controls, MIXER_GETLINECONTROLSF_ONEBYTYPE);
  end;
end; // TControlVolume.GetMasterMute


function TControlVolume.GetControlID(): Integer;
var
  hMix: HMIXER;
  i: Integer;
  MixLine: TMixerLine;
  MixLineCtrl: TMixerLineControls;
  MixCtrl: TMixerControl;
  MixCaps: TMixerCaps;
begin
  MixerOpen(@hMix, 0, 0, 0, MIXER_OBJECTF_MIXER or CALLBACK_WINDOW);
  MixerGetDevCaps(0, @mixcaps, SizeOf(MixCaps));
  for i := 0 to MixCaps.cDestinations - 1 do begin
    Mixline.dwDestination := i;
    Mixline.cbStruct := SizeOf(Mixline);
    MixerGetLineInfo(hmix, @mixline, MIXER_GETLINEINFOF_DESTINATION);
    if Mixline.dwComponentType
        = MIXERLINE_COMPONENTTYPE_DST_SPEAKERS then begin

       break;

    end;
  end;

  if Mixline.dwComponentType
      <> MIXERLINE_COMPONENTTYPE_DST_SPEAKERS then begin

    Result := 0;

  end else begin
    with MixLineCtrl do begin
      cbStruct := SizeOf(MixLineCtrl);
      dwControlType := MIXERCONTROL_CONTROLTYPE_VOLUME;
      dwLineID := MixLine.dwLineID;
      cControls := 2;
      cbmxctrl := Sizeof(MixCtrl);
    end;
    MixCtrl.dwControlType := MIXERCONTROL_CONTROLTYPE_VOLUME;
    MixLineCtrl.pamxctrl := @MixCtrl;
    MixerGetLineControls(0, @mixlinectrl, MIXER_GETLINECONTROLSF_ONEBYTYPE);
    Result := MixCtrl.dwControlID;
 end;

end; // TControlVolume.GetControlID


end.

