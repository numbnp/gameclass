unit uGCSendRecieve;

interface

uses Classes,
    IdUDPServer,
    IdUDPClient,
    gcconst;

type
  TGCSendRecieve = class
    private
      udpServer:TIdUDPServer;
      udpClient:TIdUDPClient;
    public
      constructor Create(OnRecieveEvent:TUDPReadEvent);
      destructor Destroy; override;
      procedure SendData(AstrIP:string;vport:integer;strData:string);
    end;
var
  GCSendRecieve:TGCSendRecieve;
implementation

uses SysUtils;

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

procedure TGCSendRecieve.SendData(AstrIP:string;vport:integer;strData:string);
begin
  udpClient.Send(AstrIP,vport,strData)
end;

end.
