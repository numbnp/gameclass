unit uGCDevices;

interface

uses Classes,
     uClientInfoConst;
type
  // Тип устройства
  TDevicetype = ( DeviceType_PC,              // Комп
                  DeviceType_SNMP,            // SNMP-железка
                  DeviceType_Uncnoun );

  IGCDevice = interface
    function GetDiviceType:TDevicetype;     // Получение типа устройства
    procedure SetState(State:TClientState); // Установка состояния устройства

    function SendData(data:WideString):boolean;
    function PowerOff: Boolean;
    function PowerOn: Boolean;
    function Reboot: Boolean;
    function Logoff: Boolean;

    function GetOnline:Boolean;
    function GetControled:Boolean;
    function GetIP:string;

    property online:Boolean read GetOnline;
    property controled:Boolean read GetControled;
    property ipaddr:string read GetIP;
  end;

  TGCDevicePC = class(TInterfacedObject, IGCDevice)
    private
      function GetOnline:Boolean;
      function GetControled:Boolean;
      function GetIP:string;
    public
      constructor Create;
      function GetDiviceType:TDevicetype;     // Получение типа устройства
      procedure SetState(State:TClientState); // Установка состояния устройства

      function SendData(data:WideString):boolean;
      function PowerOff: Boolean;
      function PowerOn: Boolean;
      function Reboot: Boolean;
      function Logoff: Boolean;

      property online:Boolean read GetOnline;
      property controled:Boolean read GetControled;
      property ipaddr:string read GetIP;

  end;

implementation

  {
  TGCDevice = class
    public
      online:Boolean;                         // устройство в сети
      controled: Boolean;                     // устройство управляется
      constructor Create;
      function GetDiviceType:TDevicetype;     // Получение типа устройства
      procedure SetState(State:TClientState); // Установка состояния устройства

      function SendData(data:WideString):boolean;
      function PowerOff: Boolean;
      function PowerOn: Boolean;
      function Reboot: Boolean;
      function Logoff: Boolean;
  end;




{ TDevice }
{
constructor TGCDevice.Create;
begin
  online:=false;
  controled:=false;
end;

function TGCDevice.GetDiviceType: TDevicetype;
begin
  result:=DeviceType_Uncnoun;
end;

function TGCDevice.Logoff: Boolean;
begin
  result := false;
end;

function TGCDevice.PowerOff: Boolean;
begin
  result := false;
end;

function TGCDevice.PowerOn: Boolean;
begin
  result := false;
end;

function TGCDevice.Reboot: Boolean;
begin
  result := false;
end;

function TGCDevice.SendData(data: WideString): boolean;
begin
  result := false;
end;

procedure TGCDevice.SetState(State: TClientState);
begin

end;
}
{ TGCDevice }


{ TGCDevicePC }

constructor TGCDevicePC.Create;
begin

end;

function TGCDevicePC.GetControled: Boolean;
begin

end;

function TGCDevicePC.GetDiviceType: TDevicetype;
begin

end;

function TGCDevicePC.GetIP: string;
begin

end;

function TGCDevicePC.GetOnline: Boolean;
begin

end;

function TGCDevicePC.Logoff: Boolean;
begin

end;

function TGCDevicePC.PowerOff: Boolean;
begin

end;

function TGCDevicePC.PowerOn: Boolean;
begin

end;

function TGCDevicePC.Reboot: Boolean;
begin

end;

function TGCDevicePC.SendData(data: WideString): boolean;
begin

end;

procedure TGCDevicePC.SetState(State: TClientState);
begin

end;

end.
