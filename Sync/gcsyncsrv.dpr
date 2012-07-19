program gcsyncsrv;

uses
  SvcMgr,
  usrvGCSync in 'usrvGCSync.pas' {srvGCSync: TService},
  uDebugLog in '..\Parts\Debug\uDebugLog.pas',
  uY2KCommon in '..\Parts\Y2KCommon\uY2KCommon.pas',
  uY2KString in '..\Parts\Y2KCommon\uY2KString.pas',
  uSyncOptions in 'uSyncOptions.pas',
  uDBRegistryOptionsStorage in '..\Parts\OptionsBase\uDBRegistryOptionsStorage.pas',
  uOption in '..\Parts\OptionsBase\uOption.pas',
  uOptionList in '..\Parts\OptionsBase\uOptionList.pas',
  uOptions in '..\Parts\OptionsBase\uOptions.pas',
  uOptionsFolder in '..\Parts\OptionsBase\uOptionsFolder.pas',
  uOptionsFolderList in '..\Parts\OptionsBase\uOptionsFolderList.pas',
  uOptionsStorage in '..\Parts\OptionsBase\uOptionsStorage.pas',
  uSQLTools in '..\Parts\SQLTools\uSQLTools.pas',
  ufrmLogon in '..\Parts\SQLTools\ufrmLogon.pas' {frmLogon},
  uErrors in '..\Parts\Errors\uErrors.pas',
  ufrmSQLServerList in '..\Parts\SQLTools\ufrmSQLServerList.pas' {frmSQLServerList},
  uSystemRegistryTools in '..\Parts\Registry\uSystemRegistryTools.pas',
  uSynchronization in 'uSynchronization.pas',
  uLocalServer in 'uLocalServer.pas',
  uSyncConst in 'uSyncConst.pas',
  udmMain in 'udmMain.pas' {dmMain: TDataModule},
  uGCDBTools in '..\Parts\SQLTools\uGCDBTools.pas',
  uRegistration in '..\Parts\Registration\uRegistration.pas',
  uCommon in '..\Parts\Common\uCommon.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Synchronization service for GameClass 3 Server';
  Application.CreateForm(TdmMain, dmMain);
  Application.CreateForm(TsrvGCSync, srvGCSync);
  Application.Run;
end.
