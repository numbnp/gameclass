unit usrvProcessSupervisor;

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
  uProcessSupervisor;


type

  //
  // TsrvProcessSupervisor
  //

  TsrvProcessSupervisor = class(TService)
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
  private
    // fields
    FProcessSupervisor: TProcessSupervisor;

  public
    // public methods
    function GetServiceController(): TServiceController; override;

  end; // TsrvProcessSupervisor


var
  srvProcessSupervisor: TsrvProcessSupervisor;

implementation

{$R *.DFM}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  srvProcessSupervisor.Controller(CtrlCode);
end; // ServiceController


function TsrvProcessSupervisor.GetServiceController(): TServiceController;
begin
  Result := ServiceController;
end; // TsrvProcessSupervisor.GetServiceController


procedure TsrvProcessSupervisor.ServiceStart(Sender: TService;
  var Started: Boolean);
begin
  FProcessSupervisor := TProcessSupervisor.Create();
  FProcessSupervisor.AddProcessInfo('test.exe',
      'C:\Temp\Test\test.exe');
  FProcessSupervisor.StartSupervision();
end; // TsrvProcessSupervisor.ServiceStart


procedure TsrvProcessSupervisor.ServiceStop(Sender: TService;
  var Stopped: Boolean);
begin
  if Assigned(FProcessSupervisor) then begin
    FProcessSupervisor.StopSupervision();
  end;
  FreeAndNil(FProcessSupervisor);
end; // TsrvProcessSupervisor.ServiceStop


end.
