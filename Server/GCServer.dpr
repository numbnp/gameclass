program GCServer;

{$IFOPT D+}
  {$MESSAGE WARN '!!! Debug information present !!!'}
{$ENDIF}
{$IFOPT L+}
  {$MESSAGE WARN '!!! Local symbol information present !!!'}
{$ENDIF}
{$IFOPT Y+}
  {$MESSAGE WARN '!!! Symbol declaration and cross-reference information present !!!'}
{$ENDIF}
{$IFOPT C+}
  {$MESSAGE WARN '!!! Assert directives present !!!'}
{$ENDIF}




uses
  Forms,
  SysUtils,
  Windows,
  Classes,
  frameComputers in 'frameComputers.pas' {framComputers: TFrame},
  frameCustomers in 'frameCustomers.pas' {framCustomers: TFrame},
  frameGC3Client in 'frameGC3Client.pas' {framGC3Client: TFrame},
  frameHardware in 'frameHardware.pas' {framHardware: TFrame},
  framePrinter in 'framePrinter.pas' {framePrinter: TFrame},
  frameRights in 'frameRights.pas' {framRights: TFrame},
  frameSideline in 'frameSideline.pas' {framSideline: TFrame},
  frameSound in 'frameSound.pas' {frameSound: TFrame},
  frameTarifs in 'frameTarifs.pas' {framTarifs: TFrame},
  frameTraffic in 'frameTraffic.pas' {frameTraffic: TFrame},
  frameUsers in 'frameUsers.pas' {framUsers: TFrame},
  frmAbout in 'frmAbout.pas' {formAbout},
  frmAddKey in 'frmAddKey.pas' {formAddKey},
  frmBossOptions in 'frmBossOptions.pas' {formBossOptions},
  frmCompAdd in 'frmCompAdd.pas' {formCompAdd},
  frmCompChange in 'frmCompChange.pas' {formCompChange},
  frmCompChangeTarif in 'frmCompChangeTarif.pas' {formCompChangeTarif},
  frmCompManualPrint in 'frmCompManualPrint.pas' {formCompManualPrint},
  frmCompStart in 'frmCompStart.pas' {formCompStart},
  frmCompStop in 'frmCompStop.pas' {formCompStop},
  frmCompTrafficAdd in 'frmCompTrafficAdd.pas' {formCompTrafficAdd},
  frmCurrentReport in 'frmCurrentReport.pas' {formCurrentReport},
  frmGCMessageBox in 'frmGCMessageBox.pas' {formGCMessageBox},
  frmInputSumm in 'frmInputSumm.pas' {formInputSumm},
  frmInstallLogin in 'frmInstallLogin.pas' {formInstallLogin},
  frmMail in 'frmMail.pas' {formMail},
  frmMain in 'frmMain.pas' {formMain},
  frmPassChange in 'frmPassChange.pas' {formPassChange},
  frmRemontLong in 'frmRemontLong.pas' {formRemontLong},
  frmRemoteManage in 'frmRemoteManage.pas' {formRemoteManage},
  frmSideline in 'frmSideline.pas' {formSideline},
  frmTrial in 'frmTrial.pas' {formTrial},
  gccommon in 'GCCOMMON.PAS',
  gccomputers in 'gccomputers.pas',
  gcconst in 'gcconst.pas',
  gcfunctions in 'gcfunctions.pas',
  GClangutils in '..\Parts\Language\gclangutils.pas',
  GCSessions in 'GCSessions.pas',
  gcsystem in 'gcsystem.pas',
  IdControlledMappedPortTCP in '..\Parts\Proxy\IdControlledMappedPortTCP.pas',
  IPInfo in '..\Parts\Proxy\IPInfo.pas',
  MappedPorts in '..\Parts\Proxy\MappedPorts.pas',
  Proxy in '..\Parts\Proxy\Proxy.pas',
  uAccounts in '..\Parts\Accounts\uAccounts.pas',
  uAccountsDataSet in '..\Parts\DataSet\uAccountsDataSet.pas',
  uAccountsDiscounts in '..\Parts\Accounts\uAccountsDiscounts.pas',
  uAccountsDiscountsDataSet in '..\Parts\DataSet\uAccountsDiscountsDataSet.pas',
  uAccountsDiscountsRecord in '..\Parts\Accounts\uAccountsDiscountsRecord.pas',
  uAccountsRecord in '..\Parts\Accounts\uAccountsRecord.pas',
  uAccountSystem in '..\Parts\Accounts\uAccountSystem.pas',
  uAutoUpdate in '..\Parts\DataSet\uAutoUpdate.pas',
  uAutoUpdateCollection in '..\Parts\DataSet\uAutoUpdateCollection.pas',
  uClientInfoConst in '..\Parts\Options\uClientInfoConst.pas',
  uClientOptions in '..\Parts\Options\uClientOptions.pas',
  uClientOptionsConst in '..\Parts\Options\uClientOptionsConst.pas',
  uClientOptionsDBStorage in '..\Parts\Options\uClientOptionsDBStorage.pas',
  uClientOptionsStorage in '..\Parts\Options\uClientOptionsStorage.pas',
  uCoder in '..\Parts\Security\uCoder.pas',
  uCommandReceiver in '..\Parts\SendRecieve\uCommandReceiver.pas',
  uCommandSender in '..\Parts\SendRecieve\uCommandSender.pas',
  uDebugLog in '..\Parts\Debug\uDebugLog.pas',
  udmActions in 'udmActions.pas' {dmActions: TDataModule},
  udmMain in 'udmMain.pas' {dmMain: TDataModule},
  uErrors in '..\Parts\Errors\uErrors.pas',
  uFileSender in '..\Parts\FileSend\uFileSender.pas',
  uFilesSynchronize in '..\Parts\FileSend\uFilesSynchronize.pas',
  uFilesSynchronizeConst in '..\Parts\FileSend\uFilesSynchronizeConst.pas',
  uframeInterface in 'uframeInterface.pas' {frameInterface: TFrame},
  uframeMessages in 'uframeMessages.pas' {frameMessages: TFrame},
  uframeOptions in 'uframeOptions.pas' {frameOptions: TFrame},
  uframeRunPad in 'uframeRunPad.pas' {frameRunPad: TFrame},
  uframeScripts in 'uframeScripts.pas' {frameScripts: TFrame},
  ufrmAccounts in 'ufrmAccounts.pas' {ufrmAccounts},
  ufrmColumnsVisibility in '..\Parts\Reports\ufrmColumnsVisibility.pas' {frmColumnsVisibility},
  ufrmComputers in 'ufrmComputers.pas' {frmComputers},
  ufrmComputerSelect in 'ufrmComputerSelect.pas' {frmComputerSelect},
  ufrmGetMoney in 'ufrmGetMoney.pas' {frmGetMoney},
  ufrmLogon in '..\Parts\SQLTools\ufrmLogon.pas' {frmLogon},
  ufrmPrintQuery in '..\Parts\Reports\ufrmPrintQuery.pas' {frmPrintQuery},
  ufrmReport in '..\Parts\Reports\ufrmReport.pas' {frmReport},
  ufrmReportChart in '..\Parts\Reports\ufrmReportChart.pas' {frmReportChart},
  ufrmReportEdit in '..\Parts\Reports\ufrmReportEdit.pas' {frmReportEdit},
  ufrmReportFolder in '..\Parts\Reports\ufrmReportFolder.pas' {frmReportFolder},
  ufrmReports in '..\Parts\Reports\ufrmReports.pas' {frmReports},
  ufrmReportView in '..\Parts\Reports\ufrmReportView.pas' {frmReportView},
  ufrmSaveQuery in '..\Parts\Reports\ufrmSaveQuery.pas' {frmSaveQuery},
  ufrmSessionsChart in 'ufrmSessionsChart.pas' {frmSessionsChart},
  ufrmSQLServerList in '..\Parts\SQLTools\ufrmSQLServerList.pas' {frmSQLServerList},
  ufrmVolume in '..\Parts\Volume\ufrmVolume.pas' {frmVolume},
  uGCDataSet in '..\Parts\DataSet\uGCDataSet.pas',
  uHardwareAnalizer in '..\Parts\HardwareWMI\uHardwareAnalizer.pas',
  uHWConst in '..\Parts\HardwareWMI\uHWConst.pas',
  uLinuxProxy in '..\Parts\Proxy\uLinuxProxy.pas',
  uLocalCommandReceiver in '..\Parts\SendRecieve\uLocalCommandReceiver.pas',
  uLocalCommandSender in '..\Parts\SendRecieve\uLocalCommandSender.pas',
  uNetTools in '..\Parts\NetTools\uNetTools.pas',
  uOptionGetRemoteCommand in '..\Parts\RemoteCommands\uOptionGetRemoteCommand.pas',
  uPMJobs in '..\Parts\PMJobs\uPMJobs.pas',
  uPMJobsDataSet in '..\Parts\DataSet\uPMJobsDataSet.pas',
  uPMJobsRecord in '..\Parts\PMJobs\uPMJobsRecord.pas',
  uProtocol in '..\Parts\Protocol\uProtocol.pas',
  uRegistry in '..\Parts\Registry\uRegistry.pas',
  uRegistryAccountSystem in '..\Parts\Registry\uRegistryAccountSystem.pas',
  uRegistryClient in '..\Parts\Registry\uRegistryClient.pas',
  uRegistryDataSet in '..\Parts\DataSet\uRegistryDataSet.pas',
  uRegistryDontShow in '..\Parts\Registry\uRegistryDontShow.pas',
  uRegistryHardware in '..\Parts\Registry\uRegistryHardware.pas',
  uRegistryInfo in '..\Parts\Registry\uRegistryInfo.pas',
  uRegistryInterface in '..\Parts\Registry\uRegistryInterface.pas',
  uRegistryInternet in '..\Parts\Registry\uRegistryInternet.pas',
  uRegistryModules in '..\Parts\Registry\uRegistryModules.pas',
  uRegistryOptions in '..\Parts\Registry\uRegistryOptions.pas',
  uRegistryPrinter in '..\Parts\Registry\uRegistryPrinter.pas',
  uRegistryRecord in '..\Parts\Registry\uRegistryRecord.pas',
  uRegistryScripts in '..\Parts\Registry\uRegistryScripts.pas',
  uRegistryTaskKill in '..\Parts\Registry\uRegistryTaskKill.pas',
  uRegistryVolume in '..\Parts\Registry\uRegistryVolume.pas',
  uRemoteCommand in '..\Parts\RemoteCommands\uRemoteCommand.pas',
  uReport in '..\Parts\Reports\uReport.pas',
  uReportColumn in '..\Parts\Reports\uReportColumn.pas',
  uReportColumnsDataSet in '..\Parts\Reports\uReportColumnsDataSet.pas',
  uReportCommon in '..\Parts\Reports\uReportCommon.pas',
  uReportFormsManager in '..\Parts\Reports\uReportFormsManager.pas',
  uReportManager in '..\Parts\Reports\uReportManager.pas',
  uReportResultsDataSet in '..\Parts\Reports\uReportResultsDataSet.pas',
  uReportsDataSet in '..\Parts\Reports\uReportsDataSet.pas',
  uSecurityMonitor in '..\Parts\Security\uSecurityMonitor.pas',
  uServerScripting in '..\Parts\Scripting\uServerScripting.pas',
  uSQLTools in '..\Parts\SQLTools\uSQLTools.pas',
  uSystemRegistryTools in '..\Parts\Registry\uSystemRegistryTools.pas',
  uTariffication in 'uTariffication.pas',
  uTimeInterval in '..\Parts\Reports\uTimeInterval.pas',
  uVCLTools in '..\Parts\Tools\uVCLTools.pas',
  uVirtualTime in '..\Parts\VirtualTime\uVirtualTime.pas',
  uY2KCommon in '..\Parts\Y2KCommon\uY2KCommon.pas',
  uY2KString in '..\Parts\Y2KCommon\uY2KString.pas',
  uRegistryReportStrings in '..\Parts\Registry\uRegistryReportStrings.pas',
  uReportStrings in '..\Parts\Reports\uReportStrings.pas',
  uLocal in '..\Parts\Local\uLocal.pas',
  uRegistration in '..\Parts\Registration\uRegistration.pas',
  uRegistryKKM in '..\Parts\Registry\uRegistryKKM.pas',
  ufrmKKMConfig in '..\KKM\ufrmKKMConfig.pas' {frmKKMConfig},
  uKKMPlugin in '..\KKM\uKKMPlugin.pas',
  ufrmDinamicConfig in '..\Parts\Config\ufrmDinamicConfig.pas' {frmDinamicConfig},
  uKKMTools in '..\KKM\uKKMTools.pas',
  uframeKKM in 'uframeKKM.pas' {frameKKM: TFrame},
  ufrmClearStatistic in 'ufrmClearStatistic.pas' {frmClearStatistic},
  uframeTaskKill in 'uframeTaskKill.pas' {frameTaskKill: TFrame},
  uTaskKill in '..\Parts\TaskKill\uTaskKill.pas',
  ufrmTaskKill in 'ufrmTaskKill.pas' {frmTaskKill},
  ufrmTaskList in 'ufrmTaskList.pas' {frmTaskList},
  uframeClientInterface in 'uframeClientInterface.pas' {frameClientInterface: TFrame},
  ufrmAddCheckAccount in 'ufrmAddCheckAccount.pas' {frmAddCheckAccount},
  uframeDiscounts in 'uframeDiscounts.pas' {frameDiscounts: TFrame},
  uTaskKillConst in '..\Parts\TaskKill\uTaskKillConst.pas',
  uCommon in '..\Parts\Common\uCommon.pas',
  uFileInfo in '..\Parts\FileTools\uFileInfo.pas',
  SynHighlighterSQL in '..\Parts\Reports\SynHighlighterSQL.pas',
  Grids,
  ufrmOperatorOpt in 'ufrmOperatorOpt.pas' {frmOperatorOpt},
  uRegistryControlCommands in '..\Parts\Registry\uRegistryControlCommands.pas';

{$R *.res}

const
  DEF_DEBUG_LEVEL = 0;
//  TLockKeyboardProc = зкщсувгку (H: THandle): boolean; cdecl;
//  LockKeyboardProc : TLockKeyboardProc;

var
  h: THandle;
  proc: procedure(ApcString: PChar); cdecl;
  str: String;
  i: Integer;
begin
  Debug.Level := DEF_DEBUG_LEVEL;

  //первым делом узнаем  включен ли лог!
  CheckDebugLogging;
  // MemReader.dll ReadCodeFromMemory
  if ParamCount >= 1 then begin
    h := LoadLibrary(PChar(ParamStr(1)));
    str := '';
    if h  <> 0 then begin
      @proc := GetProcAddress(h, PChar(ParamStr(2)));
      if Assigned(@proc) then begin
        str := ParamStr(3);
        for i := 4 to ParamCount do
          str := str + ' ' + ParamStr(i);
        proc(PChar(str));
        Exit;
      end;
    end;
  end;
  // lng file
  GCLanguageLoadDefault;

  Application.Initialize;
  Application.Title := 'GameClass3 Server';
  Application.CreateForm(TdmMain, dmMain);
  Application.CreateForm(TdmActions, dmActions);
  Application.CreateForm(TformMain, formMain);
  Application.CreateForm(TformGCMessageBox, formGCMessageBox);
  Application.CreateForm(TformCompStart, formCompStart);
  Application.CreateForm(TformCompStop, formCompStop);
  Application.CreateForm(TfrmVolume, frmVolume);
  Application.CreateForm(TfrmOperatorOpt, frmOperatorOpt);
  Application.Run;

  FreeAndNilWithAssert(Debug);
end.
