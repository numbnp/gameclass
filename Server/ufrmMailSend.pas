unit ufrmMailSend;

interface

uses
  inifiles, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdComponent, IdTCPConnection, IdTCPClient, IdMessageClient,IdCoderHeader,
  IdSMTP, ComCtrls, StdCtrls, Buttons, ExtCtrls, IdBaseComponent, IdMessage,Registry;

type
  TfrmMailSend = class(TForm)
    AttachmentDialog: TOpenDialog;
    ledCC: TLabeledEdit;
    ledAttachment: TLabeledEdit;
    Memo2: TMemo;
    Label1: TLabel;
    btnSendMail: TBitBtn;
    Button1: TButton;
    cbFrom: TComboBox;
    lblFrom: TLabel;
    lblTo: TLabel;
    cbTo: TComboBox;
    lblSubject: TLabel;
    cbSubject: TComboBox;

    procedure btnSendMailClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MRUListsLoad();
    procedure MRUListsSave();
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
{    procedure MailMessageInitializeISO(var VTransferHeader: TTransfer;
      var VHeaderEncoding: Char; var VCharSet: String);}
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

uses
  uRegistry,
  uRegistryMail,
  Math,
  uMail;

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
var
  SendMail:TSendMail;
begin
 SendMail := TSendMail.Create;
 SendMail.MailMessage.Clear;
 SendMail.MailMessage.From.Name:=cbFrom.Text;
 SendMail.MailMessage.Subject:=cbSubject.Text; // тема
 SendMail.MailMessage.From.Address:=cbFrom.Text; // адрес отправителя
 SendMail.MailMessage.Recipients.EMailAddresses:=cbTo.Text+','+ledCC.Text; // получатель + копия
 SendMail.MailMessage.Body.Text:=Memo2.Text; // текст сообщения

 if FileExists(ledAttachment.Text) then
    SendMail.AddAttachment(ledAttachment.Text);
  // отправка почты
  if SendMail.Send then
    ShowMessage('Письмо отправлено!')
  else
    ShowMessage('Письмо не отправлено!');
  SendMail.Destroy;
  MRUListsSave();

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

procedure TfrmMailSend.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FlstFrom);
  FreeAndNil(FlstTo);
  FreeAndNil( FlstSubject);
end;

end.
