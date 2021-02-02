program PlannerEh_MainDemo;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  FrameOne in 'FrameOne.pas' {frFrameOne: TFrame},
  CustomPlannerItemDialog in 'CustomPlannerItemDialog.pas' {CustomPlannerItemForm},
  FrameFour in 'FrameFour.pas' {frFrameFour: TFrame},
  FrameThree in 'FrameThree.pas' {frFrameThree: TFrame},
  FrameTwo in 'FrameTwo.pas' {frFrameTwo: TFrame},
  BaseFrame in 'BaseFrame.pas' {MyBaseFrame: TFrame},
  FrameOptions in 'FrameOptions.pas' {frFrameOptions: TFrame},
  Unit_ToolsDataModule in 'Unit_ToolsDataModule.pas' {ToolsDataModule: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Test Demo';
  Application.CreateForm(TToolsDataModule, ToolsDataModule);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
