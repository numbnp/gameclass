unit uMail;

interface

uses
  IdSMTP,
  IdMessage,
  SysUtils;

type
  TSendMail = class
  private
    FSMTP:TIdSMTP;
    FMessage:TIdMessage;
    procedure _AddLog(str:string);
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

{ TSendMail }

function TSendMail.AddAttachment(FileName: string): boolean;
begin
  if FileExists(FileName) then
  begin
    TIdAttachment.Create(FMessage.MessageParts,FileName);
    Result := True;
  end
  else
    Result := False;
end;

constructor TSendMail.Create;
begin
  FSMTP := TIdSMTP.Create(nil) ;
  FMessage := TIdMessage.Create(nil);
end;

destructor TSendMail.Destroy;
begin
  FMessage.Destroy;
  FSMTP.Destroy;
  inherited;
end;

function TSendMail.Send: boolean;
var
  res:Boolean;
begin
  res := False;
  try
    try
      FSMTP.Connect(1000);
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
