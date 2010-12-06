unit MappedPorts;

interface

uses Classes, IPInfo, IdControlledMappedPortTCP;

type
   TMappedPort = class(TCollectionItem)
   public
      FPort: TIdControlledMappedPortTCP;
   //конструктор/деструктор - это наверное самый нужный комментарий :))
      constructor Create(Collection: TCollection); override;
      destructor Destroy; override;
   end;

   TMappedPorts = class(TCollection)  //класс редиректа, содержит два сокета перекидывающих
   public
      FIPList: TIPInfoList;

      constructor Create(IPList:TIPInfoList);
      destructor Destroy; override;

      procedure Add(ListenPort:Integer; MappedAddress:String; MappedPort:Integer);
                         //добавить новую запись или не добавить если есть
      function GetItem(Index: Integer): TMappedPort ;
      procedure SetItem(Index: Integer; Value: TMappedPort);
      procedure DisconnectByIP(IPAddress: String);
      procedure DisconnectAll;
   private
      property Items[Index: Integer]:TMappedPort read GetItem write SetItem; default;
   end;

implementation
////////////////////////////////////////////////////////////////////////////////
//                               TMappedPort
////////////////////////////////////////////////////////////////////////////////
constructor TMappedPort.Create(Collection: TCollection);
begin
   inherited Create(Collection);
   FPort := TIdControlledMappedPortTCP.Create(Nil,TMappedPorts(Collection).FIPList);
end;
destructor TMappedPort.Destroy;
begin
   FPort.Free;
   inherited Destroy;
end;

////////////////////////////////////////////////////////////////////////////////
//                               TMappedPorts
////////////////////////////////////////////////////////////////////////////////
constructor TMappedPorts.Create(IPList:TIPInfoList);
begin
   inherited Create(TMappedPort);
   FIPList := IPList;
end;

destructor TMappedPorts.Destroy;
begin
   inherited Destroy;
end;

procedure TMappedPorts.Add(ListenPort:Integer; MappedAddress:String; MappedPort:Integer);
var
   i : Integer;
   ReCreate : Boolean;
   Port : TMappedPort;
begin
   ReCreate := False;
   for i:=0 to Count-1 do
      if Items[i].FPort.DefaultPort = ListenPort then
         ReCreate := True;
   if Not ReCreate then begin
      Port := TMappedPort(inherited Add);
      Port.FPort.DefaultPort := ListenPort;
      Port.FPort.MappedHost := MappedAddress;
      Port.FPort.MappedPort := MappedPort;
      Port.FPort.Active := True;
   end;
end;

function TMappedPorts.GetItem(Index: Integer): TMappedPort;
begin
  Result := TMappedPort(inherited Items[Index]);
end;

procedure TMappedPorts.SetItem(Index: Integer; Value: TMappedPort);
begin
  Items[Index].Assign(Value);
end;

procedure TMappedPorts.DisconnectByIP(IPAddress: String);
var
   i : Integer;
begin
   for i:=0 to Count-1 do
      Items[i].FPort.DisconnectByIP(IPAddress);
end;

procedure TMappedPorts.DisconnectAll;
var
   i : Integer;
begin
   for i:=0 to Count-1 do
      Items[i].FPort.DisconnectAll;
end;


end.
