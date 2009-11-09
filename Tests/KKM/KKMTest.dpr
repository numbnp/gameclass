program KKMTest;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  uKKMPlugin in '..\..\KKM\uKKMPlugin.pas',
  uDebugLog in '..\..\Parts\Debug\uDebugLog.pas',
  uY2KString in '..\..\Parts\Y2KCommon\uY2KString.pas',
  uY2KCommon in '..\..\Parts\Y2KCommon\uY2KCommon.pas',
  ufrmDinamicConfig in '..\..\Parts\Config\ufrmDinamicConfig.pas' {frmDinamicConfig},
  ufrmKKMConfig in '..\..\KKM\ufrmKKMConfig.pas' {frmKKMConfig};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfrmKKMConfig, frmKKMConfig);
  Application.Run;
end.
