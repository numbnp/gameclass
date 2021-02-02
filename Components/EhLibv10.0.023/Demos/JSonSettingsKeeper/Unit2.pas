unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  System.Generics.Collections,
  SettingsKeepersEh, IniFiles, BaseFormUnit,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, DBCtrlsEh;

type
  TForm2 = class(TBaseForm)
    Button1: TButton;
    DBMemoEh1: TDBMemoEh;
    procedure Button1Click(Sender: TObject);
    { Private declarations }
  public

  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

{ TForm1 }

procedure TForm2.Button1Click(Sender: TObject);
var
  SetKeeper: TSettingsKeeperEh;
begin
  SetKeeper := TSettingsKeeperEh.Create;
  WriteSettings(SetKeeper);
  DBMemoEh1.Text := SettingsKeeperToJSONString(SetKeeper);
  SetKeeper.Free;
end;

end.
