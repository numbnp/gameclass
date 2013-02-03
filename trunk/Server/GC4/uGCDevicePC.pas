unit uGCDevicePC;

interface

uses Classes,
     uClientInfoConst,
     gcconst,
     uGCDevices,
     uDebugLog,
     uGCSendRecieve;

type
  TGCDevicePC = class(TGCDevice)
    private
      procedure UDPSend(const AstrData: string);
    public


      ip:string;                              // ip компа

      function GetDiviceType:TDevicetype;     // Получение типа устройства
      procedure SetState(State:TClientState); // Установка состояния устройства

      function SendData(data:WideString):boolean; // Отправка данных устройству
      function PowerOff: Boolean;
      function PowerOn: Boolean;
      function Reboot: Boolean;
      function Logoff: Boolean;
    end;


implementation

{ TGCDevicePC }

function TGCDevicePC.GetDiviceType: TDevicetype;
begin
  Result :=DeviceType_PC;
end;

function TGCDevicePC.Logoff: Boolean;
begin
  result:= true;
end;

function TGCDevicePC.PowerOff: Boolean;
begin
  result:= true;
end;

function TGCDevicePC.PowerOn: Boolean;
begin
  result:= true;
end;

function TGCDevicePC.Reboot: Boolean;
begin
  result:= true;
end;

function TGCDevicePC.SendData(data: WideString): boolean;
begin

end;

procedure TGCDevicePC.SetState(State: TClientState);
begin

end;

// посылаем UDP пакет с данными data на адрес ip
procedure TGCDevicePC.UDPSend(const AstrData: string);
var
  strData: String;
  compIndex: integer;
begin
  if IP = '' then exit;
  if not online then exit;
  try
    Debug.Trace1(IP + ' : ' + AstrData);
    strData := AstrData;
    GCSendRecieve.SendData(IP,SENDPORT,strData)
  except
  end;
end;


end.
