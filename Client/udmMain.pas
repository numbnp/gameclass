unit udmMain;

interface

uses
  // system units
  SysUtils,
  Classes,
  // project units
  uRemoteCommand,
  uClientRemoteCommandFactory,
  uLocalCommandReceiver;


type

  //
  // TdmMain
  //

  TdmMain = class(TDataModule)
  private
    // fields
    FLocalCommandReceiver: TLocalCommandReceiver;
    FClientRemoteCommandFactory: TClientRemoteCommandFactory;
    // events handlers
  public
    // constructor / destructor
    constructor Create(AOwner: TComponent); override;
    destructor Destroy(); override;
    procedure LocalCommandDataReceived(const AstrData: String);

  end; // TdmMain


var
  dmMain: TdmMain;


implementation


uses
  // project units
  uY2KCommon,
  uLocalCommandSender,
  uDebugLog;



{$R *.dfm}
//var
//  FClientCommandFactory: TClientRemoteCommandFactory;


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TdmMain.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FClientRemoteCommandFactory := TClientRemoteCommandFactory.Create;
{$IFDEF MSWINDOWS}
  FLocalCommandReceiver := TLocalCommandReceiver.Create();
  FLocalCommandReceiver.Port := DEF_PORT_FOR_TCPCLIENT;
  FLocalCommandReceiver.OnDataReceived := LocalCommandDataReceived;
  FLocalCommandReceiver.StartReceiveProcess();
{$ENDIF}
end; // TdmMain.Create


destructor TdmMain.Destroy();
begin
{$IFDEF MSWINDOWS}
  if Assigned(FLocalCommandReceiver) then
    FLocalCommandReceiver.StopReceiveProcess();
  FreeAndNilWithAssert(FLocalCommandReceiver);
{$ENDIF}
  FreeAndNilWithAssert(FClientRemoteCommandFactory);
  inherited Destroy();
end; // TdmMain.Destroy


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// events handlers

procedure TdmMain.LocalCommandDataReceived(const AstrData: String);
var
  cmd: TRemoteCommand;
begin
  try
    cmd := FClientRemoteCommandFactory.CreateCommand(AstrData,
        {FstrFromHost}'127.0.0.1');
    try
      cmd.Execute();
    finally
      if cmd <> nil then FreeAndNilWithAssert(cmd);
    end;
  except
    on e: Exception do begin
      Debug.Trace0('TdmMain._DataReceived error! [' + AstrData
          + ']: ' + e.Message);
    end;
  end;
end; // TdmMain._DataReceived


end. ////////////////////////// end of file //////////////////////////////////
