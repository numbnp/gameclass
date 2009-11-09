unit Proxy;

interface
uses Dialogs, MappedPorts, IPInfo;

type


   TProxy = class
   protected
   //протектед вэриэйблс
      FIPList : TIPInfoList;  //Список ip-адресов
      FMappedPorts: TMappedPorts;      //коллекция "мапперов", слушающих сокет
//                                     //(listen) и создающих редирект

   public
   //конструктор/деструктор - это наверное самый нужный комментарий :))
      constructor Create;
      destructor Destroy; override;

      procedure Start; virtual;  //Включить прокси (существующие мапперы начинают работу)
      procedure Stop; virtual;  //Выключить прокси (существующие мапперы останавливают
                        // работу, редиректы закрываются)
      procedure Reset; virtual; //Сброс настроек (и мапперы и редиректы и список IP)
      procedure IPAdd(Addr : String);  //Добавить IP (disabled)
      procedure IPEnable(AstrAddr: String; AstrTarifName: String); virtual; //Включить IP
      procedure IPDisable(Addr : String); virtual;//Выключить IP
      function IPEnabled(Addr : String):Boolean;  //Состояние IP
      function IPAdded(Addr : String):Boolean;  //Существует ли в списке?
      procedure MappingAdd(ServerPort : Word; MappedAddr : String;
         MappedPort : Word); virtual; //Добавить маппинг
      procedure IPTrafficReset(Addr : String); // сбросить весь трафик в ноль
      function IPTrafficGetIn(Addr : String) : Cardinal; // получить значение
                                                //входящего трафика в байтах
      function IPTrafficGetOut(Addr : String) : Cardinal;// получить значение
                                                //исходящего трафика в байтах
      // получить результирующее значение
      function IPTrafficGetTraffic(Addr : String) : Cardinal;
      procedure IPSetSpeedLimit(AstrAddr: String;
          AnSpeedLimit: Integer); virtual;
      procedure IPSetGroup(AstrAddr: String; AstrGroup: String); virtual;
      procedure IPSetTrafficLimit(AstrAddr: String;
          AnTrafficLimit: Integer); virtual;

   end;

implementation

uses
  uRegistry,
  uRegistryInternet;
////////////////////////////////////////////////////////////////////////////////
//                                   TProxy
////////////////////////////////////////////////////////////////////////////////
constructor TProxy.Create;
begin
   inherited Create;
   FIPList := TIPInfoList.Create;
   FMappedPorts := TMappedPorts.Create(FIPList);
end;

destructor TProxy.Destroy;
begin
   FMappedPorts.Free;
   FIPList.Free;
   inherited Destroy;
end;

procedure TProxy.Start;
begin
   FIPList.EnableMapping;
end;

procedure TProxy.Stop;
begin
   FIPList.DisableMapping;
   FMappedPorts.DisconnectAll;
end;

procedure TProxy.Reset;
begin
   FIPList.DisableMapping;
   FMappedPorts.DisconnectAll;
   FMappedPorts.Clear;
   FIPList.Clear;
end;

procedure TProxy.IPAdd(Addr : String);
begin
   FIPList.Add(Addr);
end;

procedure TProxy.IPEnable(AstrAddr: String; AstrTarifName: String);  //Включить IP
begin
   FIPList.Enable(AstrAddr);
end;

procedure TProxy.IPDisable(Addr : String);
begin
   FIPList.Disable(Addr);
   FMappedPorts.DisconnectByIP(Addr);
end;

procedure TProxy.MappingAdd(ServerPort : Word; MappedAddr : String; MappedPort : Word);
begin
   FMappedPorts.Add(ServerPort,MappedAddr,MappedPort);
end;

procedure TProxy.IPTrafficReset(Addr : String); // сбросить весь (исх/вход) траффик в ноль
begin
   FIPList.IPTrafficReset(Addr);
end;

function TProxy.IPTrafficGetIn(Addr : String) : Cardinal; // получить значение входящего траффика в байтах
begin
  Result := FIPList.IPTrafficGetIn(Addr);
end;

function TProxy.IPTrafficGetOut(Addr : String) : Cardinal;
begin
  Result := FIPList.IPTrafficGetOut(Addr);
end;

function TProxy.IPTrafficGetTraffic(Addr : String) : Cardinal;
var
  nInbound, nOutbound: Cardinal;
begin
  Result := 0;
  nInbound := FIPList.IPTrafficGetIn(Addr);
  nOutbound := FIPList.IPTrafficGetOut(Addr);
  case GRegistry.Modules.Internet.TariffingMode of
    tmOnlyInbound: Result := nInbound;
    tmSummary: Result := nInbound + nOutbound;
    tmMaximum:
      if (nInbound > nOutbound) then
        Result := nInbound
      else
        Result := nOutbound;
  end;
end;

function TProxy.IPAdded(Addr : String):Boolean;
begin
   if FIPList.Index(Addr)= -1 then
      Result := False
   else
      Result := True;
end;

function TProxy.IPEnabled(Addr : String):Boolean;
begin
   Result := FIPList.Enabled(Addr);
end;

procedure TProxy.IPSetSpeedLimit(AstrAddr: String; AnSpeedLimit: Integer);
begin
   FIPList.SetSpeedLimit(AstrAddr,AnSpeedLimit);
end;

procedure TProxy.IPSetGroup(AstrAddr: String; AstrGroup: String);
begin
   FIPList.SetGroup(AstrAddr, AstrGroup);
end;

procedure TProxy.IPSetTrafficLimit(AstrAddr: String; AnTrafficLimit: Integer);
begin
   FIPList.SetTrafficLimit(AstrAddr, AnTrafficLimit);
end;
end.
