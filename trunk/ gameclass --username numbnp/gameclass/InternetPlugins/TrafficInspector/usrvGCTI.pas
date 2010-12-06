unit usrvGCTI;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  SvcMgr,
  Dialogs,
  uCommandReceiver,
  uInternetPluginRemoteCommandFactory;

type
  TsrvGCTI = class(TService)
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
  private
    FCommandReceiver: TCommandReceiver;
    FCommandFactory: TInternetPluginRemoteCommandFactory;
    FbFirstReceive: Boolean;

    function _CreateAndInitCommandReceiver(): Boolean;
    procedure _FinalAndDestroyCommandReceiver();

    function _CreateAndInitCommandFactory(): Boolean;
    procedure _FinalAndDestroyCommandFactory();

    procedure _CommandReceive(const AstrCommand: String;
        const AstrFromHost: String);
    procedure _IPInformationAdded(Sender: TObject);
  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

var
  srvGCTI: TsrvGCTI;

implementation

uses
  uGCTIOptions,
  uY2KCommon,
  uRemoteCommand,
  uDebugLog,
  Math,
  uTICommonInterface,
  uIPInformation,
  uTIUtils,
  uCoder,
  uGCTIConst;
{$R *.DFM}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  srvGCTI.Controller(CtrlCode);
end;

function TsrvGCTI.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TsrvGCTI.ServiceStart(Sender: TService; var Started: Boolean);
begin
  FbFirstReceive := True;;
  Debug.Trace0('GCTI service started.');
  Options.Load;
  Debug.Level := IfThen(Options.Genaral.DebugLog.Value, 9, 0);
  Debug.Trace5('GCTI service Options.Load.');
  IPInformations.SerializedString := Options.Genaral.SerializedString.Value;
  Debug.Trace5('GCTI service IPInformation loaded from Options');
  TI := TTICommonInterface.Create(Options.Genaral.DecriptedPassword);
  Debug.Trace5('GCTI service TTICommonInterface created');
  _CreateAndInitCommandFactory();
  Debug.Trace5('GCTI service _CreateAndInitCommandFactory.');
  TIGetMissingInfo;
  Debug.Trace5('GCTI service TIGetMissingInfo.');
  TICreateMissingUsers;
  Debug.Trace5('GCTI service TICreateMissingUsers.');
  TIClearCounters;
  Debug.Trace5('GCTI service TIClearCounters.');
  if Options.Genaral.StoppingByStart.Value then begin
    Debug.Trace5('GCTI service before StoppingByStart');
    TIStopUsers(Options.Genaral.StoppingByStartMode.Value
        = Ord(StoppingModeOnlyGC));
    Debug.Trace5('GCTI service StoppingByStart');
  end;
  TI.Free;
  _CreateAndInitCommandReceiver();
  Debug.Trace5('GCTI service _CreateAndInitCommandReceiver.');
//  Started := False;
end; // TsrvGCTI.ServiceStart


procedure TsrvGCTI.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  _FinalAndDestroyCommandReceiver();
  Debug.Trace5('GCTI service CommandReceiver stopped.');
  TI := TTICommonInterface.Create(Options.Genaral.DecriptedPassword);
  if Options.Genaral.StoppingByStop.Value then begin
    TIStopUsers(Options.Genaral.StoppingByStopMode.Value
        = Ord(StoppingModeOnlyGC));
    Debug.Trace5('GCTI service StoppingByStop');
  end;
  _FinalAndDestroyCommandFactory();
  TI.Free;
  Debug.Trace5('GCTI service TTICommonInterface destroyed');
  Debug.Trace5('GCTI service CommandFactory stopped.');
  Options.Genaral.SerializedString.Value := IPInformations.SerializedString;
  Debug.Trace5('GCTI service IPInformation saved to Options');
  Options.Save;
  Debug.Trace5('GCTI service Options.Save');
  Debug.Trace0('GCTI service stoped.');
end; // TsrvGCTI.ServiceStop

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private helper methods

function TsrvGCTI._CreateAndInitCommandReceiver(): Boolean;
begin
  Result := True;
  try
    FCommandReceiver := TCommandReceiver.Create(PORT_FOR_UDPRECEIVER, False);
    FCommandReceiver.OnDataReceived := _CommandReceive;
    FCommandReceiver.StartReceiveProcess();
  except
    Result := False;
  end;
end; // TsrvGCCL._CreateAndInitCommandReceiver


procedure TsrvGCTI._FinalAndDestroyCommandReceiver();
begin
  if Assigned(FCommandReceiver) then begin
    FCommandReceiver.StopReceiveProcess();
  end;
  FreeAndNilWithAssert(FCommandReceiver);
end; // TsrvGCCL._FinalAndDestroyCommandReceiver

function TsrvGCTI._CreateAndInitCommandFactory(): Boolean;
begin
  Result := True;
  try
    FCommandFactory := TInternetPluginRemoteCommandFactory.Create();
  except
    Result := False;
  end;
end; // TsrvGCCL._CreateAndInitCommandFactory


procedure TsrvGCTI._FinalAndDestroyCommandFactory();
begin
  FreeAndNilWithAssert(FCommandFactory);
end; // TsrvGCCL._FinalAndDestroyCommandFactory



procedure TsrvGCTI._CommandReceive(const AstrCommand: String;
    const AstrFromHost: String);
var
  cmd: TRemoteCommand;
  FstrFromHost: String;
begin
  if FbFirstReceive then begin
    FbFirstReceive := False;
    TI := TTICommonInterface.Create(Options.Genaral.DecriptedPassword);
    IPInformations.OnInformationAdded := _IPInformationAdded;
  // по-идее это делается в триде
  end;
  FstrFromHost := AstrFromHost;
  try
    Debug.Trace5('GCCL service CommandReceive [' + AstrFromHost + ']:'
        + AstrCommand);
    cmd := FCommandFactory.CreateCommand(AstrCommand, AstrFromHost);
    try
      cmd.Execute();
    finally
      FreeAndNilWithAssert(cmd);
    end;
  except
    on e: Exception do begin
      Debug.Trace0('TsrvGCTI._CommandReceive error! ' + e.Message);
    end;
  end;
end; // TsrvGCTI._CommandReceive

procedure TsrvGCTI._IPInformationAdded(Sender: TObject);
begin
  TIGetMissingInfo;
end; // TsrvGCTI._IPInformationAdded

end.
