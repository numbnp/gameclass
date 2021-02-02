unit MainFormUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  ObjectInspectorEh, BaseFormUnit, SettingsKeepersEh,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TMainForm = class(TBaseForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure ReadSettings(Keeper: TSettingsKeeperEh); override;
    procedure WriteSettings(Keeper: TSettingsKeeperEh); override;
  public
    OpenForms: String;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses Unit1, Unit2, Unit3;

procedure TMainForm.Button1Click(Sender: TObject);
begin
  if Form1 = nil then
    Form1 := TForm1.Create(Application)
  else if not Form1.Visible then
    Form1.Show
  else
    Form1.BringToFront;
end;

procedure TMainForm.Button2Click(Sender: TObject);
begin
  if Form2 = nil then
    Form2 := TForm2.Create(Application)
  else if not Form2.Visible then
    Form2.Show
  else
    Form2.BringToFront;
end;

procedure TMainForm.Button3Click(Sender: TObject);
begin
  if Form3 = nil then
    Form3 := TForm3.Create(Application)
  else if not Form3.Visible then
    Form3.Show
  else
    Form3.BringToFront;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  OpenForms := '';
  if (Form1 <> nil) and Form1.Visible then
    OpenForms := OpenForms + 'Form1;';
  if (Form2 <> nil) and Form2.Visible then
    OpenForms := OpenForms + 'Form2;';
  if (Form3 <> nil) and Form3.Visible then
    OpenForms := OpenForms + 'Form3;';
  Delete(OpenForms, Length(OpenForms), 1);
end;

procedure TMainForm.FormShow(Sender: TObject);
var
  Forms: TArray<string>;
  i: Integer;
begin
  if OpenForms <> '' then
  begin
    Forms := OpenForms.Split([';']);
    for i := 0 to Length(Forms) - 1 do
    begin
      if Forms[i] = 'Form1' then
        Button1Click(nil)
      else if Forms[i] = 'Form2' then
        Button2Click(nil)
      else if Forms[i] = 'Form3' then
        Button3Click(nil);
    end;
  end;
end;

procedure TMainForm.ReadSettings(Keeper: TSettingsKeeperEh);
var
  StrValue: String;
begin
  inherited ReadSettings(Keeper);
  if Keeper.TryGetStringValue('OpenForms', StrValue) then
  begin
    OpenForms := StrValue;
  end;
end;

procedure TMainForm.WriteSettings(Keeper: TSettingsKeeperEh);
begin
  inherited WriteSettings(Keeper);
  Keeper.Add('OpenForms', OpenForms);
end;


initialization
  //DefFontData.Name := 'Tahoma';
  System.ReportMemoryLeaksOnShutdown := True;
end.
