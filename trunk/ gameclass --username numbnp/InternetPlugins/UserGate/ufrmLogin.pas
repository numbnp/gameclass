unit ufrmLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmLogin = class(TForm)
    edtPassword: TEdit;
    Label1: TLabel;
    Button1: TButton;
    Label2: TLabel;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

uses
  uGCUGOptions;

{$R *.dfm}

procedure TfrmLogin.Button1Click(Sender: TObject);
begin
  if (edtPassword.Text = Options.Genaral.DecriptedPassword) then
    ModalResult := mrOk
  else
    Application.MessageBox('Неправильный пароль! Попробуйте еще раз!',
        'Предупреждение', MB_OK);
end;

procedure TfrmLogin.Button2Click(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

end.
