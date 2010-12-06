unit frmInstallLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TformInstallLogin = class(TForm)
    editUser: TEdit;
    editPassword: TEdit;
    labelUser: TLabel;
    labelPassword: TLabel;
    labelInstalLoginTop: TLabel;
    butOk: TButton;
    butCancel: TButton;
    gbPass: TGroupBox;
    procedure FormCreate(Sender: TObject);
    procedure butCancelClick(Sender: TObject);
    procedure butOkClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formInstallLogin: TformInstallLogin;

implementation

uses GCLangUtils;
{$R *.dfm}

procedure TformInstallLogin.FormCreate(Sender: TObject);
begin
  Caption := translate('formInstallLogin');
  labelUser.Caption := translate('labelAdminUser');
  labelPassword.Caption := translate('labelPassword');
  labelInstalLoginTop.Caption := translate('labelInstalLoginTop');
  butCancel.Caption := translate('butCancel');
end;

procedure TformInstallLogin.butCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
//  Close();
end;

procedure TformInstallLogin.butOkClick(Sender: TObject);
begin
  if editPassword.Text = '' then
    Application.MessageBox(PChar(translate('EmptyPasswordWarning')),PChar(''))
  else
    ModalResult := mrOK;
//  Close();
end;

procedure TformInstallLogin.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key=27) then
    ModalResult := mrCancel;
end;

end.
