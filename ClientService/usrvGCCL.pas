//////////////////////////////////////////////////////////////////////////////
//
// TsrvGCCL - класс сервиса клиентского приложения GameClass.
//
//////////////////////////////////////////////////////////////////////////////

unit usrvGCCL;

interface

uses
  // system units
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  SvcMgr,
  Dialogs,
  // project units
  uCommandReceiver,
  uLocalCommandReceiver,
  uServiceRemoteCommandFactory,
  uProcessSupervisor,
  uBlockingsAndNotifications,
  uFileReceiver,
  uClientScripting;


type

  //
  // TsrvGCCL
  //

  TsrvGCCL = class(TService)
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);

  private
    // fields
    FCommandReceiver: TCommandReceiver;
    FLocalCommandReceiver: TLocalCommandReceiver;
    FFileReceiver: TFileReceiver;
    FCommandFactory: TServiceRemoteCommandFactory;
    FProcessSupervisor: TProcessSupervisor;
    FBlockingsAndNotifications: TBlockingsAndNotifications;
    FstrFromHost: String;

    // events handlers
    procedure _CommandReceive(const AstrCommand: String;
        const AstrFromHost: String);
    procedure _LocalCommandReceive(const AstrCommand: String);

    // private helper methods
    procedure _SetPrivileges();
    procedure _ClearPrivileges();

    procedure _CreateAndInitCommandReceiver();
    procedure _FinalAndDestroyCommandReceiver();

    procedure _CreateAndInitLocalCommandReceiver();
    procedure _FinalAndDestroyLocalCommandReceiver();

    procedure _CreateAndInitFileReceiver();
    procedure _FinalAndDestroyFileReceiver();

    procedure _CreateAndInitCommandFactory();
    procedure _FinalAndDestroyCommandFactory();

    procedure _CreateAndInitProcessSupervisor();
    procedure _FinalAndDestroyProcessSupervisor();

    procedure _CreateAndInitBlockingsAndNotifications();
    procedure _FinalAndDestroyBlockingsAndNotifications();

  public
    // public methods
    function GetServiceController(): TServiceController; override;
    property ServerHost: String read FstrFromHost;
    procedure NeedRescanProcess;


  end; // TsrvGCCL


var
  srvGCCL: TsrvGCCL;


implementation

uses
  // project units
  uDebugLog,
  uY2KCommon,
  uCrossPlatformFunctions,
  uRemoteCommand,
  uClientOptions,
  uClientInfo,
  uProcUtils;


{$R *.DFM}


procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  srvGCCL.Controller(CtrlCode);
end; // ServiceController


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// TsrvGCCL

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

function TsrvGCCL.GetServiceController(): TServiceController;
begin
  Result := ServiceController;
end; // TsrvGCCL.GetServiceController


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// events handlers

procedure TsrvGCCL.ServiceStart(Sender: TService; var Started: Boolean);
begin
  Debug.Trace0('GCCL service started.');

  GProcUtils := TProcUtils.Create;
  GProcUtils.Init();
  Debug.Trace0('GProcUtils created and initialized.');

  _SetPrivileges();
  Debug.Trace0('GCCL service _SetPrivileges.');

  GClientOptions.Load();
  Debug.Trace0('GCCL service GCOptions.Load.');

  GClientInfo.Init();
  if GClientOptions.RestoreClientInfo and not GClientInfo.IsFirstRun then
    GClientInfo.Load;

  RunClientScript(caServiceStart);

  Debug.Trace0('GCCL service GCOptions.Load.');

  If GClientInfo.IsFirstRun then
    GClientOptions.Save();

  _CreateAndInitCommandReceiver();
  Debug.Trace0('GCCL service _CreateAndInitCommandReceiver.');
  _CreateAndInitLocalCommandReceiver();
  Debug.Trace0('GCCL service _CreateAndInitLocalCommandReceiver.');
  _CreateAndInitCommandFactory();
  Debug.Trace0('GCCL service _CreateAndInitCommandFactory.');
  _CreateAndInitProcessSupervisor();
  Debug.Trace0('GCCL service _CreateAndInitProcessSupervisor.');
  _CreateAndInitBlockingsAndNotifications;
  Debug.Trace0('GCCL service _CreateAndInitBlockingsAndNotifications.');
  _CreateAndInitFileReceiver;
  Debug.Trace0('GCCL service _CreateAndInitFileReceiver.');
end; // TsrvGCCL.ServiceStart


procedure TsrvGCCL.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  _FinalAndDestroyFileReceiver;
  _FinalAndDestroyCommandFactory();
  _FinalAndDestroyLocalCommandReceiver();
  _FinalAndDestroyCommandReceiver();
  _FinalAndDestroyProcessSupervisor();
  _FinalAndDestroyBlockingsAndNotifications();

  _ClearPrivileges();

  FreeAndNil(GProcUtils);

  Debug.Trace0('GCCL service stoped.');
  RunClientScript(caServiceStop);

end; // TsrvGCCL.ServiceStop


// обработчик OnDataReceived объекта FCommandReceiver
procedure TsrvGCCL._CommandReceive(const AstrCommand: String;
    const AstrFromHost: String);
var
  cmd: TRemoteCommand;
begin
  FstrFromHost := AstrFromHost;
  try
    Debug.Trace1('GCCL service _CommandReceive.'+AstrCommand);
    cmd := FCommandFactory.CreateCommandFromServer(AstrCommand, FstrFromHost);
    try
      Debug.Trace1('GCCL execute service _CommandReceive.'+AstrCommand);
      cmd.Execute();
    finally
      FreeAndNilWithAssert(cmd);
    end;
  except
    on e: Exception do begin
      Debug.Trace0('TsrvGCCL._CommandReceive error! ' + e.Message);
    end;
  end;
end; // TsrvGCCL._CommandReceive


// обработчик OnDataReceived объекта FLocalCommandReceiver
procedure TsrvGCCL._LocalCommandReceive(const AstrCommand: string);
var
  cmd: TRemoteCommand;
begin
  try
    cmd := FCommandFactory.CreateCommandFromClient(AstrCommand, FstrFromHost);
    try
      cmd.Execute();
    finally
      FreeAndNilWithAssert(cmd);
    end;
  except
    on e: Exception do begin
      Debug.Trace0('TsrvGCCL._LocalCommandReceive error! ' + e.Message);
    end;
  end;
end; // TsrvGCCL._LocalCommandReceive


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private helper methods

procedure TsrvGCCL._CreateAndInitCommandReceiver();
begin
  FCommandReceiver := TCommandReceiver.Create();
  FCommandReceiver.StartReceiveProcess();
  FCommandReceiver.OnDataReceived := _CommandReceive;
end; // TsrvGCCL._CreateAndInitCommandReceiver


procedure TsrvGCCL._FinalAndDestroyCommandReceiver();
begin
  if Assigned(FCommandReceiver) then begin
    FCommandReceiver.StopReceiveProcess();
  end;

  FreeAndNilWithAssert(FCommandReceiver);

end; // TsrvGCCL._FinalAndDestroyCommandReceiver


procedure TsrvGCCL._CreateAndInitLocalCommandReceiver();
begin
  FLocalCommandReceiver := TLocalCommandReceiver.Create();
  FLocalCommandReceiver.StartReceiveProcess();
  FLocalCommandReceiver.OnDataReceived := _LocalCommandReceive;
end; // TsrvGCCL._CreateAndInitLocalCommandReceiver


procedure TsrvGCCL._FinalAndDestroyLocalCommandReceiver();
begin
  if Assigned(FLocalCommandReceiver) then begin
    FLocalCommandReceiver.StopReceiveProcess();
  end;

  FreeAndNilWithAssert(FLocalCommandReceiver);

end; // TsrvGCCL._FinalAndDestroyLocalCommandReceiver

procedure TsrvGCCL._CreateAndInitFileReceiver();
begin
  FFileReceiver := TFileReceiver.Create();
  FFileReceiver.StartReceive();
end; // TsrvGCCL._CreateAndInitFileReceiver


procedure TsrvGCCL._FinalAndDestroyFileReceiver();
begin
  if Assigned(FFileReceiver) then begin
    FFileReceiver.StopReceive();
  end;

  FreeAndNilWithAssert(FFileReceiver);

end; // TsrvGCCL._FinalAndDestroyFileReceiver


procedure TsrvGCCL._CreateAndInitCommandFactory();
begin
  FCommandFactory := TServiceRemoteCommandFactory.Create();
end; // TsrvGCCL._CreateAndInitCommandFactory


procedure TsrvGCCL._FinalAndDestroyCommandFactory();
begin
  FreeAndNilWithAssert(FCommandFactory);
end; // TsrvGCCL._FinalAndDestroyCommandFactory


procedure TsrvGCCL._CreateAndInitProcessSupervisor();
var
  strWorkDirectory: string;
begin
  strWorkDirectory := ExtractFilePath(ParamStr(0));
  FProcessSupervisor := TProcessSupervisor.Create();
  FProcessSupervisor.AddProcessInfo(
      'gccl.exe',  strWorkDirectory + 'gccl.exe');
  FProcessSupervisor.StartSupervision();
end; // TsrvGCCL._CreateAndInitProcessSupervisor


procedure TsrvGCCL._FinalAndDestroyProcessSupervisor();
begin
  if Assigned(FProcessSupervisor) then begin
    FProcessSupervisor.StopSupervision();
  end;

  FreeAndNilWithAssert(FProcessSupervisor);

end; // TsrvGCCL._FinalAndDestroyProcessSupervisor


procedure TsrvGCCL._SetPrivileges();
begin
  EnablePrivilege(SE_SHUTDOWN_NAME, TRUE);
  EnablePrivilege(SE_SYSTEMTIME_NAME, TRUE);
end; // TsrvGCCL._SetPrivileges


procedure TsrvGCCL._ClearPrivileges();
begin
  EnablePrivilege(SE_SHUTDOWN_NAME, FALSE);
  EnablePrivilege(SE_SYSTEMTIME_NAME, FALSE);
end; // TsrvGCCL._ClearPrivileges

procedure TsrvGCCL._CreateAndInitBlockingsAndNotifications();
begin
  FBlockingsAndNotifications := TBlockingsAndNotifications.Create();
  FBlockingsAndNotifications.StartChecking();
end; // TsrvGCCL._CreateAndInitProcessSupervisor


procedure TsrvGCCL._FinalAndDestroyBlockingsAndNotifications();
begin
  if Assigned(FBlockingsAndNotifications) then begin
    FBlockingsAndNotifications.StopChecking();
  end;

  FreeAndNilWithAssert(FBlockingsAndNotifications);

end; // TsrvGCCL._FinalAndDestroyProcessSupervisor


procedure TsrvGCCL.NeedRescanProcess;
begin
  FProcessSupervisor.NeedRescanProcess;
end;


end. ////////////////////////// end of file //////////////////////////////////
