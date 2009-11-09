program GCUGCfg;

uses
  Forms,
  uGCUGConst in 'uGCUGConst.pas',
  uGCUGOptions in 'uGCUGOptions.pas',
  uY2KString in '..\..\Parts\Y2KCommon\uY2KString.pas',
  uY2KCommon in '..\..\Parts\Y2KCommon\uY2KCommon.pas',
  uOptionsStorage in '..\..\Parts\OptionsBase\uOptionsStorage.pas',
  uOption in '..\..\Parts\OptionsBase\uOption.pas',
  uOptions in '..\..\Parts\OptionsBase\uOptions.pas',
  uOptionsFolder in '..\..\Parts\OptionsBase\uOptionsFolder.pas',
  uOptionList in '..\..\Parts\OptionsBase\uOptionList.pas',
  uOptionsFolderList in '..\..\Parts\OptionsBase\uOptionsFolderList.pas',
  uServiceManager in '..\..\Parts\Y2KCommon\uServiceManager.pas',
  uCoder in '..\..\Parts\Security\uCoder.pas',
  uDebugLog in '..\..\Parts\Debug\uDebugLog.pas',
  ufrmLogin in 'ufrmLogin.pas' {frmLogin},
  uIPInformation in '..\..\Parts\InternetControl\uIPInformation.pas',
  ufrmMain in 'ufrmMain.pas' {frmMain},
  uUGConfig in 'uUGConfig.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Настройки';
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.Run;
end.
