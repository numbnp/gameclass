program Project1;

uses
  Forms,
  Frame3_Options in 'Frame3_Options.pas' {frFrame3_Options: TFrame},
  FrameOne in 'FrameOne.pas' {frFrameOne: TFrame},
  FrameTwo_Grid in 'FrameTwo_Grid.pas' {frFrameTwoGrid: TFrame},
  MainUnit in 'MainUnit.pas' {Form1},
  Unit_ToolsDataModule in 'Unit_ToolsDataModule.pas' {ToolsDataModule: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TToolsDataModule, ToolsDataModule);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
