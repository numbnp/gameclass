program gcsynccfg;

uses
  Forms,
  Controls,
  SysUtils,
  Windows,
  ufrmMain in 'ufrmMain.pas' {frmMain},
  uServiceManager in '..\Parts\Y2KCommon\uServiceManager.pas',
  uOption in '..\Parts\OptionsBase\uOption.pas',
  uOptionList in '..\Parts\OptionsBase\uOptionList.pas',
  uOptions in '..\Parts\OptionsBase\uOptions.pas',
  uOptionsFolder in '..\Parts\OptionsBase\uOptionsFolder.pas',
  uOptionsFolderList in '..\Parts\OptionsBase\uOptionsFolderList.pas',
  uOptionsStorage in '..\Parts\OptionsBase\uOptionsStorage.pas',
  uSyncOptions in 'uSyncOptions.pas',
  uY2KString in '..\Parts\Y2KCommon\uY2KString.pas',
  uY2KCommon in '..\Parts\Y2KCommon\uY2KCommon.pas',
  udmMain in 'udmMain.pas' {dmMain: TDataModule},
  ufrmServerName in 'ufrmServerName.pas' {frmServerName},
  uGCDBTools in '..\Parts\SQLTools\uGCDBTools.pas',
  ufrmSQLServerList in '..\Parts\SQLTools\ufrmSQLServerList.pas' {frmSQLServerList},
  uSQLTools in '..\Parts\SQLTools\uSQLTools.pas',
  uSystemRegistryTools in '..\Parts\Registry\uSystemRegistryTools.pas',
  uLocalServer in 'uLocalServer.pas',
  uDBRegistryOptionsStorage in '..\Parts\OptionsBase\uDBRegistryOptionsStorage.pas',
  ufrmLogon in '..\Parts\SQLTools\ufrmLogon.pas' {frmLogon},
  uErrors in '..\Parts\Errors\uErrors.pas',
  uSyncConst in 'uSyncConst.pas',
  uRegistration in '..\Parts\Registration\uRegistration.pas',
  uCommon in '..\Parts\Common\uCommon.pas',
  uSynchronization in 'uSynchronization.pas';

{$R *.res}

var
  frmLogon: TfrmLogon;

begin
  if Registration.Sync then begin
    Application.Initialize;
    Application.Title :=
        'Настройки сервиса синхронизации серверов GameClass';
    Application.CreateForm(TdmMain, dmMain);
  frmLogon := TfrmLogon.Create(frmMain, dmMain.cnnMain);
    frmLogon.ServerName := ReadLocalServerName;
    if (frmLogon.ShowModal = mrOk) then begin
      Application.ProcessMessages;
      LogInsert(dmMain.cnnMain, 1, MSG_SYNC_CONNECTED);
      if dmMain.IsManager(dmMain.cnnMain) then begin
        Options.SetConnection(dmMain.cnnMain);
        WriteLocalServerName(frmLogon.ServerName);
        Options.Load;
        dmMain.dstSyncServersSelect.Open;
        Application.CreateForm(TfrmMain, frmMain);
        Application.ProcessMessages;
        Application.Run;
      end else begin
        Application.MessageBox(PChar(ISMANAGER_WARNING), PChar(WARNING),
            MB_OK or MB_ICONWARNING);
      end;
      LogInsert(dmMain.cnnMain, 1, MSG_SYNC_DISCONNECTED);
    end;
    FreeAndNil(frmLogon);
    dmMain.Free;
    Application.Terminate;

  end else begin
    Application.MessageBox(PChar(UNREGISTERED_WARNING), PChar(WARNING),
        MB_OK or MB_ICONWARNING);
  end;
  halt;
end.
