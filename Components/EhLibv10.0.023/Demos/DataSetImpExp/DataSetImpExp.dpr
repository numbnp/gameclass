program DataSetImpExp;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {Form1},
  DataMod in 'DataMod.pas' {MainDataModule: TDataModule},
  DataSetTextExporter in 'DataSetTextExporter.pas' {frDataSetExporter: TFrame},
  DataSetTextImporter in 'DataSetTextImporter.pas' {frDataSetImporter: TFrame};

{$R *.res}

begin
  Application.Initialize;
//  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TMainDataModule, MainDataModule);
  Application.Run;
end.
