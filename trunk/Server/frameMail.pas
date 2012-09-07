unit frameMail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, ExtCtrls, uMail, IdSMTP;

type
  TframMail = class(TFrame)
    gbSMTP: TGroupBox;
    ledHost: TLabeledEdit;
    ledPort: TLabeledEdit;
    chbAuthentication: TCheckBox;
    ledUserName: TLabeledEdit;
    ledPassword: TLabeledEdit;
    ledFrom: TLabeledEdit;
    ledTo: TLabeledEdit;
    butTest: TButton;
    procedure chbAuthenticationClick(Sender: TObject);
    procedure ledHostChange(Sender: TObject);
    procedure ledPortChange(Sender: TObject);
    procedure ledUserNameChange(Sender: TObject);
    procedure ledPasswordChange(Sender: TObject);
    procedure ledFromChange(Sender: TObject);
    procedure ledToChange(Sender: TObject);
    procedure butTestClick(Sender: TObject);
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

Procedure AddLog(str:string);

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
  ledFrom.EditLabel.Caption := translate('mail_from');
  ledTo.EditLabel.Caption := translate('mail_to');
  butTest.Caption := translate('test');


  ledHost.Text :='';
  ledPort.Text :='';
  ledUserName.Text :='';
  ledPassword.Text := '';
  ledFrom.Text :='GameClass@GameClass.ru';
  ledTo.Text := '';
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
  ledFrom.Text := GRegistry.Mail.MailFrom;
  ledTo.Text := GRegistry.Mail.MailTo;
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

procedure TframMail.ledFromChange(Sender: TObject);
begin
  if not FbControlsEnabled then exit;
  GRegistry.Mail.MailFrom:=ledFrom.Text;
end;

procedure TframMail.ledToChange(Sender: TObject);
begin
  if not FbControlsEnabled then exit;
  GRegistry.Mail.MailTo:=ledTo.Text;
end;

procedure TframMail.butTestClick(Sender: TObject);
var
  SendMail:TSendMail;
begin
  SendMail:= TSendMail.Create;
  SendMail.AddLog := @AddLog;

  SendMail.SMTP.Host:=GRegistry.Mail.SMTPHost;
  SendMail.SMTP.Port:=GRegistry.Mail.SMTPPort;
  // установка сообщения
  if GRegistry.Mail.SMTPUseAuth then
    SendMail.Smtp.AuthenticationType:=atLogin  // atLogin
  else
    SendMail.Smtp.AuthenticationType:=atNone; // atNone
  SendMail.Smtp.Username:=GRegistry.Mail.SMTPUserName;
  SendMail.Smtp.Password:=GRegistry.Mail.SMTPPassword;
  SendMail.MailMessage.From.Name:='GameClass';
  SendMail.MailMessage.Subject:=('Тест'); // тема
  SendMail.MailMessage.From.Address:=GRegistry.Mail.MailFrom; // адрес отправителя
  SendMail.MailMessage.Recipients.EMailAddresses:=GRegistry.Mail.MailTo; // получатель + копия
  SendMail.MailMessage.Body.Text:='Это тестовое сообщение.' + #13 + #10 + #13 + #10 + #13 + #10
                                  + 'Для тех кто щедр :-)' + #13 + #10
                                  + 'R132190888483 Web money wmr' + #13 + #10
                                  + 'Z119160413439 Web money wmz' + #13 + #10
                                  + '410011118323719 Яндекс деньги' + #13 + #10
                                  + '89094029393 QIWI' + #13 + #10
                                  + '40817810952450033835 Счет Сбербанк' + #13 + #10
                                  + '4276852037570655 Карта Сбербанк' + #13 + #10
                                  + '                                     numb)';
  SendMail.Send;
  SendMail.Destroy;
end;

Procedure AddLog(str:string);
begin
  ShowMessage(str);
end;

end.
