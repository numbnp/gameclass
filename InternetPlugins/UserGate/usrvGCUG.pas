unit usrvGCUG;

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
  TsrvGCUG = class(TService)
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
  srvGCUG: TsrvGCUG;

implementation

uses
  uGCUGOptions,
  uY2KCommon,
  uRemoteCommand,
  uDebugLog,
  Math,
  uIPInformation,
  uUGUtils,
  uCoder,
  uGCUGConst,
  uUGConfig;
{$R *.DFM}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  srvGCUG.Controller(CtrlCode);
end;

function TsrvGCUG.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TsrvGCUG.ServiceStart(Sender: TService; var Started: Boolean);
var
  strErr: String;
  UG: TUGConfig;
begin
  FbFirstReceive := True;;
  Debug.Trace0('GCUG service started.');
  Options.Load;
  Debug.Level := IfThen(Options.Genaral.DebugLog.Value, 9, 0);
  Debug.Trace5('GCUG service Options.Load.');
  IPInformations.SerializedString := Options.Genaral.SerializedString.Value;
  Debug.Trace5('GCUG service IPInformation loaded from Options');
  UG := TUGConfig.Create(Options.Genaral.Path.Value);
//  UG := TUGCommonInterface.Create(Options.Genaral.DecriptedPassword);
//  if GUGConfig.Logon(Options.Genaral.Name.Value,
// Триды !!! Это триды!!
// Должен быть загружен только один экземпляр библиотеки
// и только в одном триде
    if UG.Logon(Options.Genaral.Name.Value,
      Options.Genaral.DecriptedPassword, strErr) then
    Debug.Trace5('GCUG service connected to UserGate')
  else
    Debug.Trace5('GCUG service failed connecting to UserGate: ' + strErr);
  _CreateAndInitCommandFactory();
  Debug.Trace5('GCUG service _CreateAndInitCommandFactory.');
  UGGetMissingInfo(UG);
  Debug.Trace5('GCUG service UGGetMissingInfo.');
  UGCreateMissingUsers(UG);
  Debug.Trace5('GCUG service UGCreateMissingUsers.');
  UGClearCounters(UG);
  Debug.Trace5('GCUG service UGClearCounters.');
  if Options.Genaral.StoppingByStart.Value then begin
    Debug.Trace5('GCUG service before StoppingByStart');
    UGStopUsers(UG, Options.Genaral.StoppingByStartMode.Value
        = Ord(StoppingModeOnlyGC));
    Debug.Trace5('GCUG service StoppingByStart');
  end;
  if UG.Connected then
    UG.Disconnect;
  FreeAndNil(UG);
  _CreateAndInitCommandReceiver();
  Debug.Trace5('GCUG service _CreateAndInitCommandReceiver.');
//  Started := False;
end; // TsrvGCUG.ServiceStart


procedure TsrvGCUG.ServiceStop(Sender: TService; var Stopped: Boolean);
var
  UG: TUGConfig;
begin
  _FinalAndDestroyCommandReceiver();
  Debug.Trace5('GCUG service CommandReceiver stopped.');
//  UG := TUGCommonInterface.Create(Options.Genaral.DecriptedPassword);
  if Options.Genaral.StoppingByStop.Value then begin
    UG := TUGConfig.Create(Options.Genaral.Path.Value,
        Options.Genaral.Name.Value,
        Options.Genaral.DecriptedPassword);
    if UG.Connected then begin
      UGStopUsers(UG, Options.Genaral.StoppingByStopMode.Value
          = Ord(StoppingModeOnlyGC));
      Debug.Trace5('GCUG service StoppingByStop');
      UG.Disconnect;
    end;
    FreeAndNil(UG);
  end;
  _FinalAndDestroyCommandFactory();
//  UG.Free;
  Debug.Trace5('GCUG service TUGCommonInterface destroyed');
  Debug.Trace5('GCUG service CommandFactory stopped.');
  Options.Genaral.SerializedString.Value := IPInformations.SerializedString;
  Debug.Trace5('GCUG service IPInformation saved to Options');
  Options.Save;
  Debug.Trace5('GCUG service Options.Save');
  Debug.Trace0('GCUG service stoped.');
end; // TsrvGCUG.ServiceStop

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private helper methods

function TsrvGCUG._CreateAndInitCommandReceiver(): Boolean;
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


procedure TsrvGCUG._FinalAndDestroyCommandReceiver();
begin
  if Assigned(FCommandReceiver) then begin
    FCommandReceiver.StopReceiveProcess();
  end;
  FreeAndNilWithAssert(FCommandReceiver);
end; // TsrvGCCL._FinalAndDestroyCommandReceiver

function TsrvGCUG._CreateAndInitCommandFactory(): Boolean;
begin
  Result := True;
  try
    FCommandFactory := TInternetPluginRemoteCommandFactory.Create();
  except
    Result := False;
  end;
end; // TsrvGCCL._CreateAndInitCommandFactory


procedure TsrvGCUG._FinalAndDestroyCommandFactory();
begin
  FreeAndNilWithAssert(FCommandFactory);
end; // TsrvGCCL._FinalAndDestroyCommandFactory



procedure TsrvGCUG._CommandReceive(const AstrCommand: String;
    const AstrFromHost: String);
var
  cmd: TRemoteCommand;
  FstrFromHost: String;
begin
  if FbFirstReceive then begin
    FbFirstReceive := False;
//    UG := TUGCommonInterface.Create(Options.Genaral.DecriptedPassword);
    IPInformations.OnInformationAdded := _IPInformationAdded;
  // по-идее это делается в триде
  end;
  FstrFromHost := AstrFromHost;
  try
    Debug.Trace5('GCCL service CommandReceive [' + AstrFromHost + ']:'
        + AstrCommand);
    cmd := FCommandFactory.CreateCommand(AstrCommand, FstrFromHost);
    try
      cmd.Execute();
    finally
      FreeAndNilWithAssert(cmd);
    end;
  except
    on e: Exception do begin
      Debug.Trace0('TsrvGCUG._CommandReceive error! ' + e.Message);
    end;
  end;
end; // TsrvGCUG._CommandReceive

procedure TsrvGCUG._IPInformationAdded(Sender: TObject);
var
  UG: TUGConfig;
begin
  UG := TUGConfig.Create(Options.Genaral.Path.Value,
      Options.Genaral.Name.Value,
      Options.Genaral.DecriptedPassword);
  if UG.Connected then begin
    UGGetMissingInfo(UG);
    UG.Disconnect;
  end;
  FreeAndNil(UG);
end; // TsrvGCUG._IPInformationAdded

end.
