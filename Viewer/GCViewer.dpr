program GCViewer;

uses
  Forms,
  Controls,
  SysUtils,
  Windows,
  ufrmMain in 'ufrmMain.pas' {frmMain},
  udmMain in 'udmMain.pas' {dmMain: TDataModule},
  ufrmLogon in '..\Parts\SQLTools\ufrmLogon.pas' {frmLogon},
  uErrors in '..\Parts\Errors\uErrors.pas',
  ufrmSQLServerList in '..\Parts\SQLTools\ufrmSQLServerList.pas' {frmSQLServerList},
  uSQLTools in '..\Parts\SQLTools\uSQLTools.pas',
  uY2KString in '..\Parts\Y2KCommon\uY2KString.pas',
  uSystemRegistryTools in '..\Parts\Registry\uSystemRegistryTools.pas',
  uGCDBTools in '..\Parts\SQLTools\uGCDBTools.pas',
  uRegistration in '..\Parts\Registration\uRegistration.pas',
  ufrmSettings in 'ufrmSettings.pas' {frmSettings},
  uViewerOptions in 'uViewerOptions.pas',
  uY2KCommon in '..\Parts\Y2KCommon\uY2KCommon.pas',
  uDBRegistryOptionsStorage in '..\Parts\OptionsBase\uDBRegistryOptionsStorage.pas',
  uOptionsStorage in '..\Parts\OptionsBase\uOptionsStorage.pas',
  uOption in '..\Parts\OptionsBase\uOption.pas',
  uOptionList in '..\Parts\OptionsBase\uOptionList.pas',
  uOptions in '..\Parts\OptionsBase\uOptions.pas',
  uOptionsFolder in '..\Parts\OptionsBase\uOptionsFolder.pas',
  uOptionsFolderList in '..\Parts\OptionsBase\uOptionsFolderList.pas',
  uWinhkg in '..\Parts\Winhkg\uwinhkg.pas',
  uCoder in '..\Parts\Security\uCoder.pas',
  ufrmUnblockPassword in 'ufrmUnblockPassword.pas' {frmUnblockPassword},
  ufrmAbout in 'ufrmAbout.pas' {frmAbout},
  uCommon in '..\Parts\Common\uCommon.pas',
  framCompStatesList in 'framCompStatesList.pas' {CompStatesList: TFrame};

resourcestring
  MSG_VIEWER_CONNECTED =
    'Программа просмотра состояния клуба подключилась к базе данных';
  MSG_VIEWER_DISCONNECTED =
    'Программа просмотра состояния клуба отключилась от базы данных';
  UNREGISTERED_WARNING =
    'Ключ GameClass должен поддерживать работу модуля GCViewer';

{$R *.res}

begin
  if Registration.Viewer then begin
    Application.Initialize;
    Application.Title := 'Просмотр состояния клуба';
    Application.CreateForm(TdmMain, dmMain);
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmUnblockPassword, frmUnblockPassword);
  RegisterHotKey(frmMain.Handle, WM_USER_UNBLOCK_PASSWORD,
          MOD_ALT or MOD_CONTROL, $55 {U Key});
    GWinhkg := TWinhkg.Create(ExtractFilePath(ParamStr(0))
        + '\' + 'winhkg.dll');
    GWinhkg.Init();
    GWinhkg.SetClientHandle(frmMain.Handle);
    frmLogon := TfrmLogon.Create(frmMain, dmMain.cnnMain);
    if (frmLogon.ShowModal = mrOk) then begin
      Application.ProcessMessages;
      frmMain.Caption := Format(FORM_MAIN_CAPTION, [dmMain.GetClubName,
          frmLogon.UserName]);
      LogInsert(dmMain.cnnMain, 1, MSG_VIEWER_CONNECTED);
      Options.SetConnection(dmMain.cnnMain);
      Options.Load;
      frmMain.tmrMain.Enabled := True;
      Application.ProcessMessages;
      Application.Run;
      LogInsert(dmMain.cnnMain, 1, MSG_VIEWER_DISCONNECTED);
    end;
    UnregisterHotKey(frmMain.Handle, WM_USER_UNBLOCK_PASSWORD);
  end else begin
    Application.MessageBox(PChar(UNREGISTERED_WARNING), 'Предупреждение');
  end;
end.
