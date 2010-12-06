program ProcessSupervisor;

uses
  SvcMgr,
  usrvProcessSupervisor in 'usrvProcessSupervisor.pas' {srvProcessSupervisor: TService},
  uProcessSupervisor in 'uProcessSupervisor.pas',
  uProcessesDescriptions in 'uProcessesDescriptions.pas',
  uY2KRunAs in 'uY2KRunAs.pas',
  uDebugLog in 'uDebugLog.pas',
  uY2KCommon in '..\..\Projects\PrintMonitor 3\Current\Parts\Src\Y2KCommon\uY2KCommon.pas',
  uY2KString in '..\..\Projects\PrintMonitor 3\Current\Parts\Src\Y2KCommon\uY2KString.pas';

{$R *.RES}

begin
  Debug := TDebugLog.Create('c:\ProcessSupervisor.log');
  Application.Initialize;
  Application.CreateForm(TsrvProcessSupervisor, srvProcessSupervisor);
  Application.Run;
end.
