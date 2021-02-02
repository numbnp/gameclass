program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Frame1 in 'Frame1.pas' {frFrame1: TFrame},
  Frame2 in 'Frame2.pas' {frFrame2: TFrame},
  Frame3 in 'Frame3.pas' {frFrame3: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Test Demo';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
