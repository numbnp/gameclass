unit usrvGCSync;

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
  uSynchronization;

type
  TsrvGCSync = class(TService)
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
    procedure _FinalAndDestroySynchronization();
  private
    { Private declarations }
    FSynchronization: TSynchronization;
    procedure _CreateAndInitSynchronization();
  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

var
  srvGCSync: TsrvGCSync;

implementation

uses
  uDebugLog,
  uSyncOptions,
  uSyncConst,
  Math;

{$R *.DFM}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  srvGCSync.Controller(CtrlCode);
end;

function TsrvGCSync.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TsrvGCSync.ServiceStart(Sender: TService; var Started: Boolean);
begin
  Debug.Level := 0;
  Debug.Trace0('gcsyncsrv service started.');
  if Registration.Sync then begin
    _CreateAndInitSynchronization();
    Debug.Trace5('gcsyncsrv service _CreateAndInitSynchronization');
  end else begin
    Debug.Trace0(UNREGISTERED_WARNING);
    Started := False;
  end;
end;

procedure TsrvGCSync.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  _FinalAndDestroySynchronization();
  Debug.Trace5('gcsyncsrv service CommandReceiver stopped.');
  Debug.Trace0('gcsyncsrv service stoped.');
end;

procedure TsrvGCSync._CreateAndInitSynchronization();
begin
  FSynchronization := TSynchronization.Create();
  FSynchronization.StartChecking();
end; // TsrvGCCL._CreateAndInitProcessSupervisor


procedure TsrvGCSync._FinalAndDestroySynchronization();
begin
  if Assigned(FSynchronization) then begin
    FSynchronization.StopChecking();
  end;
  FreeAndNil(FSynchronization);
end; // TsrvGCCL._FinalAndDestroyProcessSupervisor


end.
