unit frameMail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, ExtCtrls;

type
  TframMail = class(TFrame)
    gbSMTP: TGroupBox;
    ledHost: TLabeledEdit;
    ledPort: TLabeledEdit;
    chbAuthentication: TCheckBox;
    ledUserName: TLabeledEdit;
    ledPassword: TLabeledEdit;
    procedure chbAuthenticationClick(Sender: TObject);
    procedure ledHostChange(Sender: TObject);
    procedure ledPortChange(Sender: TObject);
    procedure ledUserNameChange(Sender: TObject);
    procedure ledPasswordChange(Sender: TObject);
  private
    FbControlsEnabled: Boolean;
    procedure ResetFrame;
    procedure DoDesign;
  public
    function GetID: integer;
    procedure Activate(ID: integer);
    procedure EnableControls;
    procedure DisableControls;
    property ControlsEnabled: Boolean
        read FbControlsEnabled write FbControlsEnabled;
  end;

implementation

{$R *.dfm}

uses
  uClientOptions,
  gcconst,
  gccomputers,
  uRegistry,
  uRegistryOptions,
  uRegistryInterface,
  uY2KString, uRegistryModules, uRegistryInternet,
  uTariffication, uRegistryControlCommands, uRegistryMail,
  GClangutils,StdConvs;

function TframMail.GetID: integer;
begin
  GetID := FRAME_MAIL;
end;

procedure TframMail.EnableControls;
begin
  FbControlsEnabled := True;
end;

procedure TframMail.DisableControls;
begin
  FbControlsEnabled := false;
end;

// процедура ставит все контролы в исходные позиции
procedure TframMail.ResetFrame;
begin
  DisableControls;
  gbSMTP.Caption := translate('SMTP_param');
  ledHost.EditLabel.Caption := translate('host');
  ledPort.EditLabel.Caption := translate('port');
  chbAuthentication.Caption := translate('use_authentication');
  ledUserName.EditLabel.Caption := translate('login');
  ledPassword.EditLabel.Caption := translate('password');

  ledHost.Text :='';
  ledPort.Text :='';
  ledUserName.Text :='';
  ledPassword.Text := '';
  chbAuthentication.State := cbUnchecked;
  ledUserName.Enabled := (chbAuthentication.State = cbChecked);
  ledPassword.Enabled := (chbAuthentication.State = cbChecked);
  EnableControls;
end;

procedure TframMail.Activate(ID: integer);
begin
  Visible := (GetID = ID);
  if (not Visible) then exit;
  ResetFrame;

  DoDesign;
end;


procedure TframMail.DoDesign;
begin

//GRegistry.Options.
  ledHost.Text := GRegistry.Mail.SMTPHost;
  ledPort.Text := IntToStr(GRegistry.Mail.SMTPPort);
  chbAuthentication.Checked:= GRegistry.Mail.SMTPUseAuth;
  ledUserName.Text := GRegistry.Mail.SMTPUserName;
  ledPassword.Text := GRegistry.Mail.SMTPPassword;
  ledUserName.Enabled := (chbAuthentication.State = cbChecked);
  ledPassword.Enabled := (chbAuthentication.State = cbChecked);
end;

procedure TframMail.chbAuthenticationClick(Sender: TObject);
begin
  if not FbControlsEnabled then exit;
  GRegistry.Mail.SMTPUseAuth := chbAuthentication.Checked;
  ledUserName.Enabled := chbAuthentication.Checked;
  ledPassword.Enabled := chbAuthentication.Checked;
end;



procedure TframMail.ledHostChange(Sender: TObject);
begin
  if not FbControlsEnabled then exit;
  GRegistry.Mail.SMTPHost:=ledHost.Text;
end;

procedure TframMail.ledPortChange(Sender: TObject);
begin
  if not FbControlsEnabled then exit;
  GRegistry.Mail.SMTPPort:=StrToIntDef(ledPort.Text,0) ;
end;

procedure TframMail.ledUserNameChange(Sender: TObject);
begin
  if not FbControlsEnabled then exit;
  GRegistry.Mail.SMTPUserName:=ledUserName.Text;
end;

procedure TframMail.ledPasswordChange(Sender: TObject);
begin
  if not FbControlsEnabled then exit;
  GRegistry.Mail.SMTPPassword:=ledPassword.Text;
end;

end.
