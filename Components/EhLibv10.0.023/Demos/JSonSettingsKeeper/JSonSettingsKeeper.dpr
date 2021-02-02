program JSonSettingsKeeper;

uses
  Vcl.Forms,
  BaseFormUnit in 'BaseFormUnit.pas' {BaseForm},
  MainFormUnit in 'MainFormUnit.pas' {MainForm},
  Unit1 in 'Unit1.pas' {Form1},
  Unit2 in 'Unit2.pas' {Form2},
  Unit3 in 'Unit3.pas' {Form3};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
