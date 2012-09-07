unit ufrmMailSend;

interface

uses
  inifiles, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdComponent, IdTCPConnection, IdTCPClient, IdMessageClient,IdCoderHeader,
  IdSMTP, ComCtrls, StdCtrls, Buttons, ExtCtrls, IdBaseComponent, IdMessage,Registry,
  uMail;

type
  TfrmMailSend = class(TForm)
    MailMessage: TIdMessage;
    SMTP: TIdSMTP;
    AttachmentDialog: TOpenDialog;
    ledCC: TLabeledEdit;
    ledAttachment: TLabeledEdit;
    Memo2: TMemo;
    Label1: TLabel;
    btnSendMail: TBitBtn;
    Button1: TButton;
    Memo1: TMemo;
    cbFrom: TComboBox;
    lblFrom: TLabel;
    lblTo: TLabel;
    cbTo: TComboBox;
    lblSubject: TLabel;
    cbSubject: TComboBox;

    procedure btnSendMailClick(Sender: TObject);
    procedure SMTPStatus(ASender: TObject; const AStatus: TIdStatus;
      const AStatusText: string);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MRUListsLoad();
    procedure MRUListsSave();
    procedure FormCreate(Sender: TObject);
    procedure MailMessageInitializeISO(var VTransferHeader: TTransfer;
      var VHeaderEncoding: Char; var VCharSet: String);
  private
    FlstFrom: TStringList;
    FlstTo: TStringList;
    FlstSubject: TStringList;
  public
    repFileName: string;

    { Public declarations }
  end;

var
  frmMailSend: TfrmMailSend;

implementation

{$R *.dfm}

uses uRegistry, uRegistryMail, Math;

procedure TfrmMailSend.MRUListsLoad;
var
  Reg: TRegistry;
  i: Integer;
  str: String;
begin
  // Считаем MRU-списки серверов и пользователей из реестра
  Reg := TRegistry.Create;
  Reg.RootKey := HKEY_CURRENT_USER;
  if Reg.OpenKey('\Software\GameClass3',True) then
  begin
    FlstFrom.Clear;
    if (Reg.ReadString('mFrom1')='') then begin
      FlstFrom.Add('GC');
    end else begin
      for i := 1 to 10 do begin
        str := Reg.ReadString('mFrom' + IntToStr(i));
        if str <> '' then
          FlstFrom.Add(str);
      end;
    end;

    FlstTo.Clear;
    if (Reg.ReadString('mTo1')='') then begin
      FlstTo.Add('my');
    end else begin
      for i := 1 to 10 do begin
        str := Reg.ReadString('mTo' + IntToStr(i));
        if str <> '' then
          FlstTo.Add(str);
      end;
    end;

    FlstSubject.Clear;
    if (Reg.ReadString('mSubject1')='') then begin
      FlstSubject.Add('Subject');
    end else begin
      for i := 1 to 10 do begin
        str := Reg.ReadString('mSubject' + IntToStr(i));
        if str <> '' then
          FlstSubject.Add(str);
      end;
    end;

    Reg.CloseKey;
  end;
  Reg.Free;
end;


procedure TfrmMailSend.MRUListsSave;
var
  Reg: TRegistry;
  i: Integer;
  n: Integer;
begin
  n := FlstFrom.IndexOf(cbFrom.Text);
  if n <> -1 then
    FlstFrom.Delete(n);
  FlstFrom.Insert(0,cbFrom.Text);

  n := FlstTo.IndexOf(cbTo.Text);
  if n <> -1 then
    FlstTo.Delete(n);
  FlstTo.Insert(0,cbTo.Text);

  n := FlstSubject.IndexOf(cbSubject.Text);
  if n <> -1 then
    FlstSubject.Delete(n);
  FlstSubject.Insert(0,cbSubject.Text);

  // сохраним в реестре новые значения
  Reg := TRegistry.Create;
  Reg.RootKey := HKEY_CURRENT_USER;
  if Reg.OpenKey('\Software\GameClass3',False) then begin
    for i := 1 to FlstFrom.Count do
      Reg.WriteString('mFrom' + IntToStr(i), FlstFrom[i-1]);
    for i := 1 to FlstTo.Count do
      Reg.WriteString('mTo' + IntToStr(i), FlstTo[i-1]);
   for i := 1 to FlstSubject.Count do
      Reg.WriteString('mSubject' + IntToStr(i), FlstSubject[i-1]);
    Reg.Free;
  end;
end;

procedure TfrmMailSend.btnSendMailClick(Sender: TObject);
begin

 // Проверяем настройку SMTP
 if GRegistry.Mail.SMTPHost='' then
 begin
    Memo1.Lines.Insert(0,'Сервер SMTP не указан в настройка GameClass!!!');
    ShowMessage('Сервер SMTP не указан в настройка GameClass!!!');
    exit;

 end;

 // установка SMTP
 SMTP.Host:=GRegistry.Mail.SMTPHost;
 SMTP.Port:=GRegistry.Mail.SMTPPort;
 // установка сообщения
 If GRegistry.Mail.SMTPUseAuth then
   Smtp.AuthenticationType:=atLogin
 else
   Smtp.AuthenticationType:=atNone;
 Smtp.Username:=GRegistry.Mail.SMTPUserName;
 Smtp.Password:=GRegistry.Mail.SMTPPassword;

 MailMessage.Clear;
 MailMessage.From.Name:=cbFrom.Text;
 MailMessage.Subject:=EncodeSubj(cbSubject.Text); // тема
 MailMessage.From.Address:=cbFrom.Text; // адрес отправителя
 MailMessage.Recipients.EMailAddresses:=cbTo.Text+','+ledCC.Text; // получатель + копия
 MailMessage.Body.Text:=Memo2.Text; // текст сообщения

 if FileExists(ledAttachment.Text) then
    TIdAttachment.Create(MailMessage.MessageParts,ledAttachment.Text);

 // отправка почты
 try
  try
   SMTP.Connect(1000);
   sleep(200);
   Application.ProcessMessages;
   SMTP.Send(MailMessage);
   ShowMessage('Письмо отправлено!');
  except on E:Exception do
   begin
    sleep(200);
    Memo1.Lines.Insert(0,'Статус отправки: ERROR - '+E.Message);
    ShowMessage('Письмо не отправлено!');
   end;
  end;
 finally
  if SMTP.Connected then SMTP.Disconnect;
 end;
 MRUListsSave();
end;

procedure TfrmMailSend.SMTPStatus(ASender: TObject; const AStatus: TIdStatus;
  const AStatusText: string);
begin
 Memo1.Lines.Insert(0,'Статус отправки: '+AStatusText);
end;

procedure TfrmMailSend.Button1Click(Sender: TObject);
begin
 if AttachmentDialog.Execute
 then ledAttachment.Text:=AttachmentDialog.FileName;
end;

procedure TfrmMailSend.FormShow(Sender: TObject);
begin
  ledAttachment.Text := repFileName;
  MRUListsLoad;
  cbFrom.Items := FlstFrom;
  cbFrom.Text := cbFrom.Items.Strings[0];

  cbTo.Items := FlstTo;
  cbTo.Text := cbTo.Items.Strings[0];

  cbSubject.Items := FlstSubject;
  cbSubject.Text := cbSubject.Items.Strings[0];

end;

procedure TfrmMailSend.FormCreate(Sender: TObject);
begin
  FlstFrom := TStringList.Create;
  FlstTo := TStringList.Create;
  FlstSubject := TStringList.Create;
end;

procedure TfrmMailSend.MailMessageInitializeISO(
  var VTransferHeader: TTransfer; var VHeaderEncoding: Char;
  var VCharSet: String);
begin
  VCharSet := 'windows-1251';
end;

end.
