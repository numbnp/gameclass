unit IdControlledMappedPortTCP;

interface

uses
  Classes, IdTCPClient, IdTCPServer, IPInfo;

{const
  ID_MAPPED_PORT_TCP_PORT = 0;
type
  TIdControlledMappedPortTCPData = class
  public
    OutboundClient: TIdTCPClient;
    ReadList: TList;

    constructor Create;
    destructor Destroy; override;
  end;

  TBeforeClientConnectEvent = procedure(ASender: TComponent; AThread:
    TIdPeerThread;
    AClient: TIdTCPClient) of object;
}
  {TIdControlledMappedPortTCP = class(TIdTCPServer)
  protected
    FMappedPort: integer;
    FMappedHost: string;
    FOnBeforeClientConnect: TBeforeClientConnectEvent;
    FIPList: TIPInfoList;

    procedure DoConnect(AThread: TIdPeerThread); override;
    function DoExecute(AThread: TIdPeerThread): boolean; override;
  public
    constructor Create(AOwner: TComponent; IPList:TIPInfoList);
    procedure DisconnectByIP(IPAddress: String);
    procedure DisconnectAll;
  published
    property MappedHost: string read FMappedHost write FMappedHost;
    property MappedPort: integer read FMappedPort write FMappedPort default
      ID_MAPPED_PORT_TCP_PORT;
    property OnBeforeClientConnect: TBeforeClientConnectEvent read
      FOnBeforeClientConnect
    write FOnBeforeClientConnect;
  end;}

implementation

uses
  IdGlobal, IdStack,
  SysUtils;
{
constructor TIdControlledMappedPortTCP.Create(AOwner: TComponent; IPList:TIPInfoList);
begin
  inherited Create(AOwner);
  FMappedPort := ID_MAPPED_PORT_TCP_PORT;
  FIPList := IPList;
end;

procedure TIdControlledMappedPortTCP.DoConnect(AThread: TIdPeerThread);
begin
   inherited;
   AThread.Data := TIdControlledMappedPortTCPData.Create;
   with TIdControlledMappedPortTCPData(AThread.Data) do
   begin
      OutboundClient := TIdTCPClient.Create(nil);
      with OutboundClient do
      begin
         Port := MappedPort;
         Host := MappedHost;
         if Assigned(FOnBeforeClientConnect) then
         begin
            FOnBeforeClientConnect(Self, AThread, OutboundClient);
         end;
         if (FIPList.MappingEnabled and FIPList.Enabled(AThread.Connection.Socket.Binding.PeerIP)) then
            Connect
         else
            AThread.Connection.Disconnect;
      end;
   end;
end;

function TIdControlledMappedPortTCP.DoExecute(AThread: TIdPeerThread): boolean;
var
  LData: TIdControlledMappedPortTCPData;
  Buf : String;
begin
  result := true;
  LData := TIdControlledMappedPortTCPData(AThread.Data);
  try
    with LData.ReadList do
    begin
      Clear;
      Add(TObject(AThread.Connection.Socket.Binding.Handle));
      Add(TObject(LData.OutboundClient.Socket.Binding.Handle));
      if GStack.WSSelect(LData.ReadList, nil, nil, IdTimeoutInfinite) > 0 then
      begin
        if IndexOf(TObject(AThread.Connection.Socket.Binding.Handle)) > -1 then
        begin
            Buf := AThread.Connection.CurrentReadBuffer;
            FIPList.IncSent(AThread.Connection.Socket.Binding.PeerIP,Length(Buf));
            LData.OutboundClient.Write(Buf);
        end;
        if IndexOf(TObject(LData.OutboundClient.Socket.Binding.Handle)) > -1 then
        begin
            Buf := LData.OutboundClient.CurrentReadBuffer;
            FIPList.IncReceived(AThread.Connection.Socket.Binding.PeerIP,Length(Buf));
            AThread.Connection.Write(Buf);
        end;
      end;
    end;
  finally
    if not LData.OutboundClient.Connected then
    begin
      AThread.Connection.Disconnect;
    end;
  end;
end;

procedure TIdControlledMappedPortTCP.DisconnectByIP(IPAddress: String);
var
   i : Integer;
begin
   with Threads.LockList do
      try
         for i:=0 to Count-1 do
            if Not FIPList.Enabled(TIdPeerThread(Items[i]).Connection.Socket.Binding.PeerIP) then
               if TIdPeerThread(Items[i]).Connection.Connected then
                  TIdPeerThread(Items[i]).Connection.Disconnect;
      finally
         Threads.UnlockList;
      end;
end;

procedure TIdControlledMappedPortTCP.DisconnectAll;
var
   i : Integer;
begin
   with Threads.LockList do
      try
         for i:=0 to Count-1 do
            if TIdPeerThread(Items[i]).Connection.Connected then
               TIdPeerThread(Items[i]).Connection.Disconnect;
      finally
         Threads.UnlockList;
      end;
end;

constructor TIdControlledMappedPortTCPData.Create;
begin
  ReadList := TList.Create;
end;

destructor TIdControlledMappedPortTCPData.Destroy;
begin
  FreeAndNil(ReadList);
  FreeAndNil(OutboundClient);
  inherited;
end;
}
end.
