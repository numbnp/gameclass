unit uMail;

interface

uses
  IdGlobal,
  IdSMTP,
  IdMessage,
  IdEMailAddress,
  SysUtils,
  IdCoderMIME,
  IdSSLOpenSSL,
  IdExplicitTLSClientServerBase,
  IdAttachmentFile;

const
  SMTP_PORT_EXPLICIT_TLS = 587;

type
  TSendMail = class
  private
    FSMTP:TIdSMTP;
    FMessage:TIdMessage;
    FsslHandler: TIdSSLIOHandlerSocketOpenSSL;
    procedure _AddLog(str:string);
    procedure LoadSettings();
  public
    AddLog:procedure (str:string);
    property SMTP:TIdSMTP
      read FSMTP;
    property MailMessage:TIdMessage
      read FMessage;


    function AddAttachment(FileName:string):boolean;

    function Send:boolean;

    constructor Create;
    destructor Destroy; override;
  end;
implementation

uses
  uRegistry;

{ TSendMail }

function TSendMail.AddAttachment(FileName: string): boolean;
begin
  if FileExists(FileName) then
  begin
    TIdAttachmentFile.Create(FMessage.MessageParts,FileName);
    Result := True;
  end
  else
    Result := False;
end;

constructor TSendMail.Create;
begin
  FSMTP := TIdSMTP.Create(nil) ;
  FMessage := TIdMessage.Create(nil);
  LoadSettings;
end;

destructor TSendMail.Destroy;
begin
  FMessage.Destroy;
  FSMTP.Destroy;
  if Assigned(FsslHandler) then
    FsslHandler.Destroy;
  inherited;
end;

procedure TSendMail.LoadSettings;
begin
  FSMTP.Host:=GRegistry.Mail.SMTPHost;
  FSMTP.Port:=GRegistry.Mail.SMTPPort;

  if GRegistry.Mail.SMTPUseAuth then
    FSMTP.AuthType:=satDefault  // atLogin
  else
    FSMTP.AuthType:=satNone; // atNone

  FSMTP.Username:=GRegistry.Mail.SMTPUserName;
  FSMTP.Password:=GRegistry.Mail.SMTPPassword;
  FMessage.CharSet := 'UTF-8';
  FMessage.IsEncoded := true;
  FMessage.From.Name:='GameClass';
  FMessage.From.Address:=GRegistry.Mail.MailFrom; // адрес отправителя
  FMessage.Recipients.EMailAddresses:=GRegistry.Mail.MailTo; // получатель + копия
  FMessage.Body.Text:='';

  if GRegistry.Mail.SMTPSSL>0 then
  begin
    FsslHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
    FsslHandler.Destination := FSMTP.Host+':'+IntToStr(FSMTP.Port);
    FsslHandler.Host := FSMTP.Host;
    FsslHandler.Port := FSMTP.Port;
    FsslHandler.DefaultPort := 0;
    FsslHandler.SSLOptions.Method := TIdSSLVersion(GRegistry.Mail.SMTPSSL-1);
    FsslHandler.SSLOptions.Mode := sslmUnassigned;

    FSMTP.IOHandler := FsslHandler;
    if FSMTP.Port = SMTP_PORT_EXPLICIT_TLS then
      SMTP.UseTLS := utUseExplicitTLS
    else
      SMTP.UseTLS := utUseImplicitTLS;
  end;



end;

function TSendMail.Send: boolean;
var
  res:Boolean;
begin
  res := False;
  try
    try
      FSMTP.Connect;
      sleep(200);

      FSMTP.Send(FMessage);
      _AddLog('Письмо отправлено!');
      res := True;

    except on E:Exception do
    begin
      sleep(200);
      _AddLog('Статус отправки: ERROR - '+E.Message);
      _AddLog('Письмо не отправлено!');
      res := false;
    end;
    end;
  finally
    if FSMTP.Connected then FSMTP.Disconnect;
  end;
  Result := res;
end;

procedure TSendMail._AddLog(str: string);
begin
 if @AddLog <> nil then
    AddLog(str);
end;

end.
