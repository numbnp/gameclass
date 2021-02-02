program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  FrameThree in 'FrameThree.pas' {frFrameThree: TFrame},
  FrameOne in 'FrameOne.pas' {frFrameOne: TFrame},
  FrameTwo in 'FrameTwo.pas' {frFrameTwo: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Grid.CustomizeDrawDataCells';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
