program gcclsrv;

uses
  SvcMgr,
  SysUtils,
  ActiveX,
  ActiveDs_TLB,
  tlhelp32,
  gcconst in '..\Server\gcconst.pas',
  uAnswerRemoteCommand in '..\parts\RemoteCommands\uAnswerRemoteCommand.pas',
  uBlockingsAndNotifications in '..\Parts\Blocking\uBlockingsAndNotifications.pas',
  uClientConst in '..\Client\uClientConst.pas',
  uClientInfo in '..\Parts\Options\uClientInfo.pas',
  uClientInfoConst in '..\Parts\Options\uClientInfoConst.pas',
  uClientInfoConstrainedCommand in '..\Parts\RemoteCommands\uClientInfoConstrainedCommand.pas',
  uClientInfoGetRemoteCommand in '..\Parts\RemoteCommands\uClientInfoGetRemoteCommand.pas',
  uClientInfoSetRemoteCommand in '..\Parts\RemoteCommands\uClientInfoSetRemoteCommand.pas',
  uClientOptions in '..\Parts\Options\uClientOptions.pas',
  uClientOptionsConst in '..\Parts\Options\uClientOptionsConst.pas',
  uClientOptionsRegistryStorage in '..\Parts\Options\uClientOptionsRegistryStorage.pas',
  uClientOptionsStorage in '..\Parts\Options\uClientOptionsStorage.pas',
  uClientScripting in '..\Parts\Scripting\uClientScripting.pas',
  uCloseClientRemoteCommand in '..\parts\RemoteCommands\uCloseClientRemoteCommand.pas',
  uCoder in '..\Parts\Security\uCoder.pas',
  uCommandReceiver in '..\parts\SendRecieve\uCommandReceiver.pas',
  uCommandSender in '..\parts\SendRecieve\uCommandSender.pas',
  uCompositeRemoteCommand in '..\parts\RemoteCommands\uCompositeRemoteCommand.pas',
  uCrossPlatformFunctions in '..\Parts\CrossPlatform\uCrossPlatformFunctions.pas',
  uDebugLog in '..\parts\Debug\uDebugLog.pas',
  uFileReceiver in '..\Parts\FileSend\uFileReceiver.pas',
  uFilesSynchronizeConst in '..\Parts\FileSend\uFilesSynchronizeConst.pas',
  uGetExtendedInfoRemoteCommand in '..\Parts\RemoteCommands\uGetExtendedInfoRemoteCommand.pas',
  uGetHardwareRemoteCommand in '..\Parts\RemoteCommands\uGetHardwareRemoteCommand.pas',
  uGetTasksListRemoteCommand in '..\parts\RemoteCommands\uGetTasksListRemoteCommand.pas',
  uHardwareAccessories in '..\Parts\HardwareWMI\uHardwareAccessories.pas',
  uHardwareManager in '..\Parts\HardwareWMI\uHardwareManager.pas',
  uHWCDROMs in '..\Parts\HardwareWMI\uHWCDROMs.pas',
  uHWCollection in '..\Parts\HardwareWMI\uHWCollection.pas',
  uHWConst in '..\Parts\HardwareWMI\uHWConst.pas',
  uHWFloppyDrives in '..\Parts\HardwareWMI\uHWFloppyDrives.pas',
  uHWHDDs in '..\Parts\HardwareWMI\uHWHDDs.pas',
  uHWMemories in '..\Parts\HardwareWMI\uHWMemories.pas',
  uHWNetworkAdapters in '..\Parts\HardwareWMI\uHWNetworkAdapters.pas',
  uHWProcessors in '..\Parts\HardwareWMI\uHWProcessors.pas',
  uHWSoundDevices in '..\Parts\HardwareWMI\uHWSoundDevices.pas',
  uHWVideoControllers in '..\Parts\HardwareWMI\uHWVideoControllers.pas',
  uKillTaskRemoteCommand in '..\parts\RemoteCommands\uKillTaskRemoteCommand.pas',
  uLocalCommandReceiver in '..\parts\SendRecieve\uLocalCommandReceiver.pas',
  uLocalCommandSender in '..\parts\SendRecieve\uLocalCommandSender.pas',
  uLocalResendRemoteCommand in '..\parts\RemoteCommands\uLocalResendRemoteCommand.pas',
  uLogoffRemoteCommand in '..\Parts\RemoteCommands\uLogoffRemoteCommand.pas',
  uNullRemoteCommand in '..\parts\RemoteCommands\uNullRemoteCommand.pas',
  uOptionGetRemoteCommand in '..\Parts\RemoteCommands\uOptionGetRemoteCommand.pas',
  uOptionSetRemoteCommand in '..\Parts\RemoteCommands\uOptionSetRemoteCommand.pas',
  uPingRemoteCommand in '..\Parts\RemoteCommands\uPingRemoteCommand.pas',
  uPlaySoundRemoteCommand in '..\parts\RemoteCommands\uPlaySoundRemoteCommand.pas',
  uProcessesDescriptions in '..\parts\ProcessSupervisor\uProcessesDescriptions.pas',
  uProcessSupervisor in '..\parts\ProcessSupervisor\uProcessSupervisor.pas',
  uProtocol in '..\parts\Protocol\uProtocol.pas',
  uProtocolReIndexes in '..\Parts\Protocol\uProtocolReIndexes.pas',
  uRemoteCommand in '..\parts\RemoteCommands\uRemoteCommand.pas',
  uRemoteCommandFactory in '..\Parts\RemoteCommands\uRemoteCommandFactory.pas',
  uRemoteCommandList in '..\parts\RemoteCommands\uRemoteCommandList.pas',
  uResendRemoteCommand in '..\parts\RemoteCommands\uResendRemoteCommand.pas',
  uRestartRemoteCommand in '..\parts\RemoteCommands\uRestartRemoteCommand.pas',
  uServiceManager in '..\parts\Y2KCommon\uServiceManager.pas',
  uServiceRemoteCommandFactory in '..\Parts\RemoteCommands\uServiceRemoteCommandFactory.pas',
  uSetTimeRemoteCommand in '..\parts\RemoteCommands\uSetTimeRemoteCommand.pas',
  uSetVolumeRemoteCommand in '..\parts\RemoteCommands\uSetVolumeRemoteCommand.pas',
  uShowTextInAllVideoModes in '..\Parts\Direct3D\uShowTextInAllVideoModes.pas',
  uShutdownRemoteCommand in '..\parts\RemoteCommands\uShutdownRemoteCommand.pas',
  uExecuteCommandRemoteCommand in '..\parts\RemoteCommands\uExecuteCommandRemoteCommand.pas',
  usrvGCCL in 'usrvGCCL.pas' {srvGCCL: TService},
  uUninstallRemoteCommand in '..\parts\RemoteCommands\uUninstallRemoteCommand.pas',
  uWinhkg in '..\Parts\Winhkg\uwinhkg.pas',
  uY2KCommon in '..\parts\Y2KCommon\uY2KCommon.pas',
  uY2KRunAs in '..\Parts\RunAs\uY2KRunAs.pas',
  uY2KString in '..\parts\Y2KCommon\uY2KString.pas',
  WbemScripting_TLB,
  uProcUtils in '..\Parts\ProcessSupervisor\uProcUtils.pas',
  uTaskKillConst in '..\Parts\TaskKill\uTaskKillConst.pas',
  uFileInfo in '..\Parts\FileTools\uFileInfo.pas',
  uParseAndReplase in '..\Parts\Tools\uParseAndReplase.pas',
  uGetWinVer in '..\Parts\Tools\uGetWinVer.pas',
  uControlVolume in '..\Parts\ControlVolume\uControlVolume.pas',
  MMDevApi_tlb in '..\Parts\ControlVolume\MMDevApi_tlb.pas',
  Mixer in '..\Parts\ControlVolume\Mixer.pas';

{$R *.RES}

const
  DEF_DEBUG_LEVEL = 0;


{function GetLogFileName(): string;
begin
  Result := ExtractFilePath(ParamStr(0)) + 'gcclsrv_debug.log';
end; // GetLogFileName
 }

begin
//  Debug := TDebugLog.Create(GetLogFileName());
  Debug.Level := DEF_DEBUG_LEVEL;
  Application.Initialize;
  CoInitialize(Nil);

  Application.Title := 'GameClass Client Service';
  Application.CreateForm(TsrvGCCL, srvGCCL);
  Application.Run;


  CoUninitialize;
  FreeAndNilWithAssert(Debug);

end.
