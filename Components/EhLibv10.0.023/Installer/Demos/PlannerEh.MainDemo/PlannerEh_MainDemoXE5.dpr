program PlannerEh_MainDemoXE5;

uses
  Vcl.Forms,
  CustomPlannerItemDialog in 'CustomPlannerItemDialog.pas' {CustomPlannerItemForm},
  FrameFour in 'FrameFour.pas' {frFrameFour: TFrame},
  FrameOne in 'FrameOne.pas' {frFrameOne: TFrame},
  FrameThree in 'FrameThree.pas' {frFrameThree: TFrame},
  FrameTwo in 'FrameTwo.pas' {frFrameTwo: TFrame},
  Unit1 in 'Unit1.pas' {Form1},
  Vcl.Themes,
  Vcl.Styles,
  FrameOptions in 'FrameOptions.pas' {frFrameOptions: TFrame},
  Unit_ToolsDataModule in 'Unit_ToolsDataModule.pas' {ToolsDataModule: TDataModule},
  BaseFrame in 'BaseFrame.pas' {MyBaseFrame: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Amakrits');
  Application.CreateForm(TToolsDataModule, ToolsDataModule);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
