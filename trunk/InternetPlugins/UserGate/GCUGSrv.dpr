program GCUGSrv;

uses
  SvcMgr,
  usrvGCUG in 'usrvGCUG.pas' {srvGCUG: TService},
  uBlockRemoteCommand in 'uBlockRemoteCommand.pas',
  uCommandReceiver in '..\..\Parts\SendRecieve\uCommandReceiver.pas',
  uCommandSender in '..\..\Parts\SendRecieve\uCommandSender.pas',
  uCompositeRemoteCommand in '..\..\Parts\RemoteCommands\uCompositeRemoteCommand.pas',
  uDebugLog in '..\..\Parts\Debug\uDebugLog.pas',
  uGCUGConst in 'uGCUGConst.pas',
  uGCUGOptions in 'uGCUGOptions.pas',
  uInternetPluginRemoteCommandFactory in '..\..\Parts\RemoteCommands\uInternetPluginRemoteCommandFactory.pas',
  uIPInformation in '..\..\Parts\InternetControl\uIPInformation.pas',
  uNullRemoteCommand in '..\..\Parts\RemoteCommands\uNullRemoteCommand.pas',
  uOption in '..\..\Parts\OptionsBase\uOption.pas',
  uOptionList in '..\..\Parts\OptionsBase\uOptionList.pas',
  uOptions in '..\..\Parts\OptionsBase\uOptions.pas',
  uOptionsFolder in '..\..\Parts\OptionsBase\uOptionsFolder.pas',
  uOptionsFolderList in '..\..\Parts\OptionsBase\uOptionsFolderList.pas',
  uOptionsStorage in '..\..\Parts\OptionsBase\uOptionsStorage.pas',
  uProtocol in '..\..\Parts\Protocol\uProtocol.pas',
  uRemoteCommand in '..\..\Parts\RemoteCommands\uRemoteCommand.pas',
  uRemoteCommandFactory in '..\..\Parts\RemoteCommands\uRemoteCommandFactory.pas',
  uRemoteCommandList in '..\..\Parts\RemoteCommands\uRemoteCommandList.pas',
  uSendTrafficAnswerRemoteCommand in 'uSendTrafficAnswerRemoteCommand.pas',
  uSetGroupRemoteCommand in 'uSetGroupRemoteCommand.pas',
  uSetLimitRemoteCommand in 'uSetLimitRemoteCommand.pas',
  uSetSpeedRemoteCommand in 'uSetSpeedRemoteCommand.pas',
  uUGUtils in 'uUGUtils.pas',
  uUnblockRemoteCommand in 'uUnblockRemoteCommand.pas',
  uY2KCommon in '..\..\Parts\Y2KCommon\uY2KCommon.pas',
  uY2KString in '..\..\Parts\Y2KCommon\uY2KString.pas',
  uCoder in '..\..\Parts\Security\uCoder.pas',
  uUGConfig in 'uUGConfig.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TsrvGCUG, srvGCUG);
  Application.Run;
end.
