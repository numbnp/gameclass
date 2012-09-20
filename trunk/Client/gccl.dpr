program gccl;

uses
  Forms,
  Windows,
  ActiveX,
  ComObj,
  DateUtils,
  SysUtils,
  AbsoluteAlone in 'AbsoluteAlone.pas',
  RS_APILib_TLB in '..\Parts\RunPadShell\RS_APILib_TLB.pas',
  uBlockingsAndNotifications in '..\Parts\Blocking\uBlockingsAndNotifications.pas',
  uBlockRemoteCommand in '..\Parts\RemoteCommands\uBlockRemoteCommand.pas',
  uClientAuthenticationCommand in '..\Parts\RemoteCommands\uClientAuthenticationCommand.pas',
  uClientConst in 'uClientConst.pas',
  uClientDoDesignCommand in '..\Parts\RemoteCommands\uClientDoDesignCommand.pas',
  uClientInstallDirectory in '..\Parts\Options\uClientInstallDirectory.pas',
  uClientOptions in '..\Parts\Options\uClientOptions.pas',
  uClientOptionsConst in '..\Parts\Options\uClientOptionsConst.pas',
  uClientOptionsRegistryStorage in '..\Parts\Options\uClientOptionsRegistryStorage.pas',
  uClientOptionsStorage in '..\Parts\Options\uClientOptionsStorage.pas',
  uClientRemoteCommandFactory in '..\Parts\RemoteCommands\uClientRemoteCommandFactory.pas',
  uClientScripting in '..\Parts\Scripting\uClientScripting.pas',
  uCoder in '..\Parts\Security\uCoder.pas',
  uCompositeRemoteCommand in '..\Parts\RemoteCommands\uCompositeRemoteCommand.pas',
  uCrossPlatformBlocking in '..\Parts\CrossPlatform\uCrossPlatformBlocking.pas',
  uCrossPlatformFunctions in '..\Parts\CrossPlatform\uCrossPlatformFunctions.pas',
  uCrossPlatformWindow in '..\Parts\CrossPlatform\uCrossPlatformWindow.pas',
  uDebugLog in '..\parts\Debug\uDebugLog.pas',
  udmMain in 'udmMain.pas' {dmMain: TDataModule},
  uFilesSynchronizeConst in '..\Parts\FileSend\uFilesSynchronizeConst.pas',
  ufrmMain in 'ufrmMain.pas' {frmMain},
  ufrmSmallInfo in 'ufrmSmallInfo.pas' {frmSmallInfo},
  uKillTaskRemoteCommand in '..\Parts\RemoteCommands\uKillTaskRemoteCommand.pas',
  uLocalCommandReceiver in '..\parts\SendRecieve\uLocalCommandReceiver.pas',
  uLocalCommandSender in '..\parts\SendRecieve\uLocalCommandSender.pas',
  uLogoffRemoteCommand in '..\Parts\RemoteCommands\uLogoffRemoteCommand.pas',
  uNullRemoteCommand in '..\Parts\RemoteCommands\uNullRemoteCommand.pas',
  uOptionSetRemoteCommand in '..\Parts\RemoteCommands\uOptionSetRemoteCommand.pas',
  uProtocol in '..\Parts\Protocol\uProtocol.pas',
  uReceiveMessageRemoteCommand in '..\Parts\RemoteCommands\uReceiveMessageRemoteCommand.pas',
  uRemoteCommand in '..\Parts\RemoteCommands\uRemoteCommand.pas',
  uRemoteCommandFactory in '..\Parts\RemoteCommands\uRemoteCommandFactory.pas',
  uRemoteCommandList in '..\Parts\RemoteCommands\uRemoteCommandList.pas',
  uSafeStorage in '..\Parts\SafeStorage\uSafeStorage.pas',
  uSendMessageRemoteCommand in '..\Parts\RemoteCommands\uSendMessageRemoteCommand.pas',
  uShellModeRemoteCommand in '..\Parts\RemoteCommands\uShellModeRemoteCommand.pas',
  uShowTextInAllVideoModes in '..\Parts\Direct3D\uShowTextInAllVideoModes.pas',
  uWinhkg in '..\Parts\Winhkg\uwinhkg.pas',
  uY2KCommon in '..\Parts\Y2KCommon\uY2KCommon.pas',
  uY2KString in '..\parts\Y2KCommon\uY2KString.pas',
  uRunPadTools in '..\Parts\RunPadShell\uRunPadTools.pas',
  uRestartRemoteCommand in '..\Parts\RemoteCommands\uRestartRemoteCommand.pas',
  uTaskKill in '..\Parts\TaskKill\uTaskKill.pas',
  uClientInfo in '..\Parts\Options\uClientInfo.pas',
  uClientInfoConst in '..\Parts\Options\uClientInfoConst.pas',
  uClientInfoConstrainedCommand in '..\Parts\RemoteCommands\uClientInfoConstrainedCommand.pas',
  uClientInfoSetRemoteCommand in '..\Parts\RemoteCommands\uClientInfoSetRemoteCommand.pas',
  uTaskKillConst in '..\Parts\TaskKill\uTaskKillConst.pas',
  frmTopMessage in 'frmTopMessage.pas' {frmMessage},
  uParseAndReplase in '..\Parts\Tools\uParseAndReplase.pas',
  uControlVolume in '..\Parts\ControlVolume\uControlVolume.pas',
  uGetWinVer in '..\Parts\Tools\uGetWinVer.pas',
  uSetVolumeRemoteCommand in '..\Parts\RemoteCommands\uSetVolumeRemoteCommand.pas',
  MMDevApi_tlb in '..\Parts\ControlVolume\MMDevApi_tlb.pas',
  Mixer in '..\Parts\ControlVolume\Mixer.pas',
  uProtocolTcp in '..\Parts\RemoteCommands\uProtocolTcp.pas',
  uWebExec in '..\Parts\Web\uWebExec.pas',
  uWebServer in '..\Parts\Web\uWebServer.pas',
  uClientFunctions in '..\Parts\ClientFunctions\uClientFunctions.pas';

{$R *.res}
const
  DEF_DEBUG_LEVEL = 0;

function CreateLockMutex(const AstrMutex: String;
    var AhMutex: THandle): Boolean;
begin
  Result := FALSE;
  AhMutex := CreateMutex(nil, TRUE, PChar(AstrMutex));
  if GetlastError() = 0 then begin
    Result := TRUE;
  end;
end; // CreateLockMutex

begin
  Debug.Level := DEF_DEBUG_LEVEL;
//  Debug.Level := 9;
  Application.Initialize;
  GWinhkg := TWinhkg.Create(InstallDirectory + '\' + 'winhkg.dll');
  GWinhkg.Init();
  BlockingsAndNotifications := TBlockingsAndNotifications.Create();
  frmMain := Nil;
    GClientOptions.Load;
    if GClientOptions.RestoreClientInfo then
      GClientInfo.Load
    else
      GClientInfo.Init;
  BlockingsAndNotifications.StartChecking();
  Application.Title := 'GCCL';
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmMessage, frmMessage);
  GWinhkg.SetClientHandle(frmMain.Handle);
  Application.CreateForm(TdmMain, dmMain);
  Application.CreateForm(TfrmSmallInfo, frmSmallInfo);
  Application.ShowMainForm := False;

  RegisterHotKey(frmMain.Handle, WM_USER_ACTIVATE_INFO,
      MOD_ALT or MOD_CONTROL or MOD_SHIFT, $49 {I Key});
  RegisterHotKey(frmMain.Handle, WM_USER_UNBLOCK_PASSWORD,
      MOD_ALT or MOD_CONTROL, $55 {U Key});
  frmMain.EnableSafeOperation;
  Application.Run;
  if Assigned(BlockingsAndNotifications) then begin
    BlockingsAndNotifications.StopChecking();
  end;
  FreeAndNilWithAssert(BlockingsAndNotifications);
  UnregisterHotKey(frmMain.Handle, WM_USER_ACTIVATE_INFO);
  UnregisterHotKey(frmMain.Handle, WM_USER_UNBLOCK_PASSWORD);
  FreeAndNilWithAssert(Debug);
  RunClientScript(caClientStop);
end.
