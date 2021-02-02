program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  FrameFive in 'FrameFive.pas' {frFrameFive: TFrame},
  SQLMonForm in 'SQLMonForm.pas' {fSQLMon},
  FrameThree in 'FrameThree.pas' {frFrameThree: TFrame},
  FrameOne in 'FrameOne.pas' {frFrameOne: TFrame},
  FrameTwo in 'FrameTwo.pas' {frFrameTwo: TFrame},
  FrameFour in 'FrameFour.pas' {frFrameFour: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Test Demo';
  fSQLMon := TfSQLMon.Create(Application);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
