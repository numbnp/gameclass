unit uGCSendRecieve;

interface

uses Classes,
    IdUDPServer,
    IdUDPClient,
    gcconst,
    IdGlobal;

type
  TGCSendRecieve = class
    private
      udpServer:TIdUDPServer;
      udpClient:TIdUDPClient;
    public
      constructor Create(OnRecieveEvent:TUDPReadEvent);
      destructor Destroy; override;
      procedure SendData(AstrIP:string;vport:TIdPort;strData:string);
    end;
var
  GCSendRecieve:TGCSendRecieve;
implementation

uses SysUtils, Windows;

{ TGCSendRecieve }

constructor TGCSendRecieve.Create(OnRecieveEvent: TUDPReadEvent);
begin
    udpServer := TIdUdpServer.Create(nil);
    udpServer.DefaultPort := READPORT;
    udpServer.OnUDPRead := OnRecieveEvent;
    udpServer.Active := True;
    udpClient := TIdUdpClient.Create(nil);
    udpClient.Port := READPORT;
    udpClient.Active := True;
end;

destructor TGCSendRecieve.Destroy;
begin
  FreeAndNil(udpServer);
  FreeAndNil(udpClient);
  inherited;
end;

procedure TGCSendRecieve.SendData(AstrIP:string;vport:TIdPort;strData:string);
var
  Buffer : TidBytes;
  len:integer;
  astr:String;
begin
  astr := ansistring(strData);
//  astr := 'ololo_ололоl';
 {len := Length(astr);
  SetLength(Buffer,len);
  Move(astr,Buffer , len);}

//  Buffer := BytesOf(astr,len);
  udpClient.Host := AstrIP;
  udpClient.Port := vport;
  udpClient.Send(astr, Indy8BitEncoding);
//  udpClient.SendBuffer(AstrIP,vport,Buffer);

{  MyStringBuilder := TStringBuilder.Create('');
  try
    Price := 1.49;
    Label1.Caption := MyStringBuilder.Append('The apples are $').Append(Price).
             ÄAppend(' a pound.').ToString;
  finally
    MyStringBuilder.Free;
  end;}
end;

end.
