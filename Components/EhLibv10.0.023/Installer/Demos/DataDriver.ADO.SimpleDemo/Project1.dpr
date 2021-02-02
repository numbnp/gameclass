program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  SQLMonForm in 'SQLMonForm.pas' {fSQLMon};

{$R *.RES}

begin
  Application.Initialize;
  fSQLMon := TfSQLMon.Create(Application);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
