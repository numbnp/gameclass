//////////////////////////////////////////////////////////////////////////////
//
// TsrvGCCL - класс сервиса клиентского приложения GameClass.
//
//////////////////////////////////////////////////////////////////////////////

unit usrvGCCL;

interface

uses
  // system units
///  Windows,
  //Messages,
  SysUtils,
  Classes,
  //Graphics,
  //Controls,
  //SvcMgr,
  //Dialogs,
  // project units
  uCommandReceiver,
  uLocalCommandReceiver,
  uServiceRemoteCommandFactory,
  uBlockingsAndNotifications,
  uFileReceiver,
  uClientScripting;


type

  //
  // TsrvGCCL
  //

  TsrvGCCL = class(TObject)
    procedure ServiceStart;
    procedure ServiceStop;

  private
    // fields
    FCommandReceiver: TCommandReceiver;
    FLocalCommandReceiver: TLocalCommandReceiver;
    FFileReceiver: TFileReceiver;
    FCommandFactory: TServiceRemoteCommandFactory;
    FBlockingsAndNotifications: TBlockingsAndNotifications;
    FstrFromHost: String;

    // events handlers
    procedure _CommandReceive(const AstrCommand: String;
        const AstrFromHost: String);
    procedure _LocalCommandReceive(const AstrCommand: String);

    // private helper methods
    procedure _CreateAndInitCommandReceiver();
    procedure _FinalAndDestroyCommandReceiver();

    procedure _CreateAndInitLocalCommandReceiver();
    procedure _FinalAndDestroyLocalCommandReceiver();

    procedure _CreateAndInitFileReceiver();
    procedure _FinalAndDestroyFileReceiver();

    procedure _CreateAndInitCommandFactory();
    procedure _FinalAndDestroyCommandFactory();

    procedure _CreateAndInitBlockingsAndNotifications();
    procedure _FinalAndDestroyBlockingsAndNotifications();

  public
    // public methods
    property ServerHost: String read FstrFromHost;


  end; // TsrvGCCL


var
  srvGCCL: TsrvGCCL;


implementation

uses
  // project units
  uDebugLog,
  uY2KCommon,
  uRemoteCommand,
  uClientOptions,
  uClientInfo;


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// TsrvGCCL

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// events handlers

procedure TsrvGCCL.ServiceStart;
begin
  Debug.Trace5('GCCL service started.');
  RunClientScript(caServiceStart);
//  Debug.Trace0('GCCL service GCOptions.Load.');
//  If GClientInfo.IsFirstRun then
//    GClientOptions.Save();
  _CreateAndInitCommandFactory();
  Debug.Trace5('GCCL service _CreateAndInitCommandFactory.');
  _CreateAndInitCommandReceiver();
  Debug.Trace5('GCCL service _CreateAndInitCommandReceiver.');
// Зачем он нужен в линукс модуле
//  _CreateAndInitLocalCommandReceiver();
//  Debug.Trace0('GCCL service _CreateAndInitLocalCommandReceiver.');
  _CreateAndInitBlockingsAndNotifications;
  Debug.Trace5('GCCL service _CreateAndInitBlockingsAndNotifications.');
//  _CreateAndInitFileReceiver;
//  Debug.Trace0('GCCL service _CreateAndInitFileReceiver.');
end; // TsrvGCCL.ServiceStart


procedure TsrvGCCL.ServiceStop;
begin
  _FinalAndDestroyFileReceiver;
  _FinalAndDestroyCommandFactory();
  _FinalAndDestroyLocalCommandReceiver();
  _FinalAndDestroyCommandReceiver();
  _FinalAndDestroyBlockingsAndNotifications();

  Debug.Trace5('GCCL service stoped.');
  RunClientScript(caServiceStop);

end; // TsrvGCCL.ServiceStop


// обработчик OnDataReceived объекта FCommandReceiver
procedure TsrvGCCL._CommandReceive(const AstrCommand: String;
    const AstrFromHost: String);
var
  cmd: TRemoteCommand;
begin
  FstrFromHost := AstrFromHost;
  GClientInfo.ServerIPAddress := AstrFromHost;
  try
    Debug.Trace1('GCCL service _CommandReceive.'+AstrCommand);
    cmd := FCommandFactory.CreateCommandFromServer(AstrCommand, FstrFromHost);
    try
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
  FCommandReceiver.OnDataReceived := _CommandReceive;
  FCommandReceiver.StartReceiveProcess();
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

initialization
  srvGCCL := TsrvGCCL.Create;

finalization
  FreeAndNil(srvGCCL);


end. ////////////////////////// end of file //////////////////////////////////

