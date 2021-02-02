program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  UnitFrame1 in 'UnitFrame1.pas' {Frame1: TFrame},
  UnitFrame2 in 'UnitFrame2.pas' {Frame2: TFrame},
  UnitTestConn in 'UnitTestConn.pas' {fTestConn},
  SQLMonForm in 'SQLMonForm.pas' {fSQLMon};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfTestConn, fTestConn);
  Application.Run;
end.
