unit uTaskKillConst;

interface

const
  EXCLUDED_TASK_LIST = #13#10
      + '[system process]'#13#10
      + 'system'#13#10
      + 'smss.exe'#13#10
      + 'csrss.exe'#13#10
      + 'winlogon.exe'#13#10
      + 'services.exe'#13#10
      + 'lsass.exe'#13#10
      + 'svchost.exe'#13#10
      + 'spoolsv.exe'#13#10
      + 'inetinfo.exe'#13#10
      + 'ctfmon.exe'#13#10
      + 'gccl.exe'#13#10
      + 'gcclsrv.exe'#13#10
      + 'gc3shell.exe'#13#10
      + 'rshell.exe'#13#10
      + 'rfmserver.exe'#13#10
      + 'rsrdserver.exe'#13#10
      + 'rshell_svc.exe'#13#10;


type
  TTaskKillMode = (
    Include = 0,
    Exclude = 1,
    RunPad = 2,
    Nothing = 3);

implementation

end.
