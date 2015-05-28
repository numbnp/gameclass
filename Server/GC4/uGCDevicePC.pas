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
     function GetDiviceType:TDevicetype;

     end;



implementation


{ TGCDevicePC }

function TGCDevicePC.GetDiviceType: TDevicetype;
begin
  Result := DeviceType_PC;
end;

end.
