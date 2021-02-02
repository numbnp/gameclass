program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Unit4 in 'Unit4.pas' {Form4};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm4, Form4);
  Application.Run;
end.
