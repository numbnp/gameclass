unit uPlaySoundRemoteCommand;

interface

uses
  // project units
  uRemoteCommand;

type

  //
  // TPlaySoundRemoteCommand
  //

  TPlaySoundRemoteCommand = class(TRemoteCommand)
  private
    // fields
    FstrParameters: String;

  public
    // constructor / destructor
    constructor Create(const AstrParameters: String);

    // public methods
    procedure Execute(); override;

  end; // TPlaySoundRemoteCommand


implementation

uses
  // system units
  Types,
  SysUtils,
{$IFDEF MSWINDOWS}
  MMSystem,
{$ENDIF}
{$IFDEF LINUX}
{$ENDIF}
  // project units
  uY2KCommon,
  uDebugLog,
  uY2KString;


const
  SUBDIRECTORY_GCCL_SOUNDS = 'Sounds';


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TPlaySoundRemoteCommand.Create(const AstrParameters: String);
begin
  inherited Create();

//  FstrSoundFileName := AstrSoundFileName;
  FstrParameters := AstrParameters;

end; // TPlaySoundRemoteCommand.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TPlaySoundRemoteCommand.Execute();
var
  strSoundFileName: String;
  i, nFileCount: Integer;
begin
  nFileCount := GetParamCountFromString(FstrParameters);
{$IFDEF MSWINDOWS}
  PlaySound(nil, NULL_HANDLE, SND_FILENAME);
{$ENDIF}
{$IFDEF LINUX}
{$ENDIF}
{$IFDEF MSWINDOWS}
  for i := 0 to nFileCount-1 do begin
    strSoundFileName := ExtractFilePath(ParamStr(0))
        {+ '\'} + SUBDIRECTORY_GCCL_SOUNDS
        + '\'
        + GetParamFromString(FstrParameters, i);
    PlaySound(PChar(strSoundFileName), NULL_HANDLE, SND_FILENAME or SND_SYNC);
  end;
{$ENDIF}
{$IFDEF LINUX}
{$ENDIF}

end; // TPlaySoundRemoteCommand.Execute


end.
