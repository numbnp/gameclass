program tstHook;

uses
  Forms,
  ufrmMain in 'ufrmMain.pas' {frmMain},
  uWinhkg in '..\..\include\uwinhkg.pas',
  DirectInput8 in 'DirectInput8.pas',
  DirectXGraphics in 'DirectXGraphics.pas',
  DXCommon in 'dxcommon.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
