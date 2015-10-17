//////////////////////////////////////////////////////////////////////////////
//
// THardwareManager - класс, получающий информацию об оборудовании,
// установлнном на компьютере, с помощью WMI.
// Для хранения и передачи собранной информации используются
// объекты класса THardwareAccessories.
//
// THardwareManager реализован как Singleton.
// Для доступа к методам и свойствам класса следует использовать
// обращение через "классовый" метод Instance().
// К примеру: THardwareManager.Instance().GetHardwareAsString()
//
//////////////////////////////////////////////////////////////////////////////

unit uHardwareManager;

interface

uses
  // system units
  OleServer,
  ActiveX,
  ComCtrls,
  WbemScripting_TLB,
  // project units
  uY2KCommon,
  uHardwareAccessories;


type

  //
  // THardwareManager
  //

  THardwareManager = class(TObject)
  private
    // private helper methods
    function _IsValidValue(const AvarValue: OleVariant): Boolean;
    function _GetFirstObjectFromSWbemObjectSet(
        const AObjectSet: ISWbemObjectSet): SWBemObject;
    function _GetPropertyValue(const ASWbemObject: ISWbemObject;
        const AstrPropName: String; const AstrDefaultValue: String): String;

    procedure _GetSystemInfo(const AWMIServices: ISWbemServices;
        var AHardwareAccessories: THardwareAccessories);
    procedure _GetProcessorInfo(const AWMIServices: ISWbemServices;
        var AHardwareAccessories: THardwareAccessories);
    procedure _GetMotherboardInfo(const AWMIServices: ISWbemServices;
        var AHardwareAccessories: THardwareAccessories);
    procedure _GetBIOSInfo(const AWMIServices: ISWbemServices;
        var AHardwareAccessories: THardwareAccessories);
    procedure _GetMemoryInfo(const AWMIServices: ISWbemServices;
        var AHardwareAccessories: THardwareAccessories);
    procedure _GetDiskDrivesInfo(const AWMIServices: ISWbemServices;
        var AHardwareAccessories: THardwareAccessories);
    procedure _GetCDROMDrivesInfo(const AWMIServices: ISWbemServices;
        var AHardwareAccessories: THardwareAccessories);
    procedure _GetVideoControllerInfo(const AWMIServices: ISWbemServices;
        var AHardwareAccessories: THardwareAccessories);
    procedure _GetSoundDevicesInfo(const AWMIServices: ISWbemServices;
        var AHardwareAccessories: THardwareAccessories);
    procedure _GetFloppyDrivesInfo(const AWMIServices: ISWbemServices;
        var AHardwareAccessories: THardwareAccessories);
    procedure _GetNetworkAdaptersInfo(const AWMIServices: ISWbemServices;
        var AHardwareAccessories: THardwareAccessories);

  protected
    // constructor / destructor
    constructor CreateInstance();

    // class methods
    class function AccessInstance(
        const ARequest: TSingletonOperation): THardwareManager;

  public
    // constructor / destructor
    constructor Create();
    destructor Destroy(); override;

    // class methods
    class function Instance(): THardwareManager;
    class procedure ReleaseInstance();

    // public methods
    procedure GetHardware(var AHardwareAccessories: THardwareAccessories);
    function GetHardwareAsString(): String;

  end; // THardwareManager


implementation

uses
  // system units
  SysUtils,
  Variants;


const
  // язык запросов к WMI
  LNG_WQL = 'WQL';


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

// Exceptions: EAssertionFailed
constructor THardwareManager.Create();
begin
  inherited Create();
  ASSERT(FALSE, Format('Access class %s through Instance only', [ClassName]));

end; // THardwareManager.Create


constructor THardwareManager.CreateInstance();
begin
  inherited Create();

end; // THardwareManager.CreateInstance


destructor THardwareManager.Destroy();
begin
  if AccessInstance(SinglOper_Access) = Self then begin
    AccessInstance(SinglOper_Destroy);
  end;

  inherited Destroy();

end; // THardwareManager.Destroy


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// class methods

// Exceptions: EAssertionFailed
class function THardwareManager.AccessInstance(
    const ARequest: TSingletonOperation): THardwareManager;
// Константа используется для хранения ссылки на единственный
// экземпляр класса. Такая реализация обусловлена отсутсвием
// в классах Delphi статических полей.
// ВНИМАНИЕ! Для корректной работы необходимо включить {$WRITEABLECONST ON}!
{$WRITEABLECONST ON}
const
  FInstance: THardwareManager = nil;
begin
  case ARequest of
    SinglOper_Access: begin
      // do nothing
    end;

    SinglOper_Create: begin
      if not Assigned(FInstance) then begin
        FInstance := CreateInstance();
      end;
    end;

    SinglOper_Destroy: begin
      FInstance := nil;
    end;

    else begin
      ASSERT(FALSE,
          Format('Illegal request %d in AccessInstance', [Ord(ARequest)]));
    end;
  end;

  Result := FInstance;

{$WRITEABLECONST OFF}
end; // THardwareManager.AccessInstance


class function THardwareManager.Instance(): THardwareManager;
begin
  Result := AccessInstance(SinglOper_Create);
end; // THardwareManager.Instance


class procedure THardwareManager.ReleaseInstance();
begin
  AccessInstance(SinglOper_Access).Free();
end; // THardwareManager.ReleaseInstance


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure THardwareManager.GetHardware(
    var AHardwareAccessories: THardwareAccessories);
const
  WMI_SERVER = '.';
  WMI_NAMESPACE = 'root\CIMV2';
var
//  SWbemLocator: TSWbemLocator;
  WMIServices: ISWbemServices;
begin

  ASSERT(Assigned(AHardwareAccessories));

  AHardwareAccessories.Clear();

  exit;
  //SWbemLocator := TSWbemLocator.Create(nil);
  try
    //WMIServices := SWbemLocator.ConnectServer(WMI_SERVER,
    //    WMI_NAMESPACE, '', '', '', '', 0, nil);

    if Assigned(WMIServices) then begin
      _GetSystemInfo(WMIServices, {in/out}AHardwareAccessories);
      _GetProcessorInfo(WMIServices, {in/out}AHardwareAccessories);
      _GetMotherboardInfo(WMIServices, {in/out}AHardwareAccessories);
      _GetBIOSInfo(WMIServices, {in/out}AHardwareAccessories);
      _GetMemoryInfo(WMIServices, {in/out}AHardwareAccessories);
      _GetDiskDrivesInfo(WMIServices, {in/out}AHardwareAccessories);
      _GetCDROMDrivesInfo(WMIServices, {in/out}AHardwareAccessories);
      _GetVideoControllerInfo(WMIServices, {in/out}AHardwareAccessories);
      _GetSoundDevicesInfo(WMIServices, {in/out}AHardwareAccessories);
      _GetFloppyDrivesInfo(WMIServices, {in/out}AHardwareAccessories);
      _GetNetworkAdaptersInfo(WMIServices, {in/out}AHardwareAccessories);
//      SWbemLocator.Disconnect();
    end;
  finally
//    FreeAndNil(SWbemLocator);
  end;

end; // THardwareManager.GetHardware


// Exceptions: EAssertionFailed
function THardwareManager.GetHardwareAsString(): String;
var
  HardwareAccessories: THardwareAccessories;
begin
  Result := '';
  HardwareAccessories := THardwareAccessories.Create();
  try
    try
      GetHardware({in/out}HardwareAccessories);
      Result := HardwareAccessories.AsString();
    except
      on e: Exception do begin
        ASSERT(FALSE, e.Message);
        Result := '';
      end;
    end;
  finally
    FreeAndNilWithAssert(HardwareAccessories);
  end;
end; // THardwareManager.GetHardwareAsString


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private helper methods

function THardwareManager._IsValidValue(const AvarValue: OleVariant): Boolean;
begin
  Result := (not VarIsNull(AvarValue)) and (not VarIsArray(AvarValue));
end; // THardwareManager._IsValidValue


function THardwareManager._GetFirstObjectFromSWbemObjectSet(
    const AObjectSet: ISWbemObjectSet): SWBemObject;
var
  ObjEnum: IEnumVariant;
  varObj: OleVariant;
  nFetched: Cardinal;
begin
  ObjEnum := (AObjectSet._NewEnum) as IEnumVariant;
  ObjEnum.Next(1, varObj, nFetched);

  Result := IUnknown(varObj) as SWBemObject;

end; // THardwareManager._GetFirstObjectFromSWbemObjectSet


function THardwareManager._GetPropertyValue(const ASWbemObject: ISWbemObject;
    const AstrPropName: String; const AstrDefaultValue: String): String;
var
  Prop: ISWbemProperty;
  varValue: OleVariant;
begin
  Result := AstrDefaultValue;
  try
    Prop := ASWbemObject.Properties_.Item(AstrPropName, 0);
    if Assigned(Prop) then begin
      varValue := Prop.Get_Value();
      if _IsValidValue(varValue) then begin
        Result := varValue;
      end;
    end;
  except
    Result := AstrDefaultValue;
  end;
end; // THardwareManager._GetPropertyValue


procedure THardwareManager._GetSystemInfo(
    const AWMIServices: ISWbemServices;
    var AHardwareAccessories: THardwareAccessories);
const
  QUERY_TO_WMI = 'Win32_ComputerSystem';
  PROP_NAME = 'Name';
  PROP_NUMBER_OF_PROCESSORS = 'NumberOfProcessors';
var
  AllComputerSystems: ISWbemObject;
  ComputerSystem: ISWbemObject;
  ObjectSet: ISWbemObjectSet;
begin
  AllComputerSystems := AWMIServices.Get(QUERY_TO_WMI,
      wbemFlagUseAmendedQualifiers, nil);

  ObjectSet := AllComputerSystems.Instances_(0, nil);
  ComputerSystem := _GetFirstObjectFromSWbemObjectSet(ObjectSet);

  with AHardwareAccessories do begin
    NumberOfProcessors := _GetPropertyValue(
        ComputerSystem, PROP_NUMBER_OF_PROCESSORS, '1');
    ComputerName := _GetPropertyValue(ComputerSystem, PROP_NAME, '');
  end;

end; // THardwareManager._GetSystemInfo


procedure THardwareManager._GetProcessorInfo(
    const AWMIServices: ISWbemServices;
    var AHardwareAccessories: THardwareAccessories);
const
  QUERY_TO_WMI = 'select * from Win32_Processor';
  PROP_DEVICE_ID = 'DeviceID';
  PROP_NAME = 'Name';
  PROP_ID = 'ProcessorId';
  PROP_MAX_CLOCK_SPEED = 'MaxClockSpeed';
  PROP_VERSION = 'Version';
var
  ObjectSet: ISWbemObjectSet;
  Processor: ISWbemObject;
  ObjEnum: IEnumVariant;
  varObj: OleVariant;
  nFetched: Cardinal;
begin
  ObjectSet := AWMIServices.ExecQuery(QUERY_TO_WMI, LNG_WQL,
      wbemFlagUseAmendedQualifiers, nil);

  ObjEnum := (ObjectSet._NewEnum) as IEnumVariant;
  while (ObjEnum.Next(1, varObj, nFetched) = S_OK) do begin

    Processor := IUnknown(varObj) as SWBemObject;

    with AHardwareAccessories.Processors.Add() do begin
      DeviceId := _GetPropertyValue(Processor, PROP_DEVICE_ID, '');
      Name := _GetPropertyValue(Processor, PROP_NAME, '');
      ProcessorId := _GetPropertyValue(Processor, PROP_ID, '');
      MaxClockSpeed := _GetPropertyValue(
          Processor, PROP_MAX_CLOCK_SPEED, '');
      Version := _GetPropertyValue(Processor, PROP_VERSION, '');
    end;

  end;

end; // THardwareManager._GetProcessorInfo


procedure THardwareManager._GetMotherboardInfo(
    const AWMIServices: ISWbemServices;
    var AHardwareAccessories: THardwareAccessories);
const
  QUERY_TO_WMI = 'Win32_BaseBoard';
  PROP_SERIAL_NUMBER = 'SerialNumber';
var
  AllMotherboards: ISWbemObject;
  Motherboard: ISWbemObject;
  ObjectSet: ISWbemObjectSet;
begin
  AllMotherboards := AWMIServices.Get(QUERY_TO_WMI,
      wbemFlagUseAmendedQualifiers, nil);

  ObjectSet := AllMotherboards.Instances_(0, nil);
  Motherboard := _GetFirstObjectFromSWbemObjectSet(ObjectSet);

  with AHardwareAccessories do begin
    MBSerialNumber := _GetPropertyValue(Motherboard, PROP_SERIAL_NUMBER, '');
  end;

end; // THardwareManager._GetMotherboardInfo


procedure THardwareManager._GetBIOSInfo(
    const AWMIServices: ISWbemServices;
    var AHardwareAccessories: THardwareAccessories);
const
  QUERY_TO_WMI = 'Win32_BIOS';
  PROP_BIOS_VERSION = 'SMBIOSBIOSVersion';
var
  AllBIOS: ISWbemObject;
  BIOS: ISWbemObject;
  ObjectSet: ISWbemObjectSet;
begin
  AllBIOS := AWMIServices.Get(QUERY_TO_WMI,
      wbemFlagUseAmendedQualifiers, nil);

  ObjectSet := AllBIOS.Instances_(0, nil);
  BIOS := _GetFirstObjectFromSWbemObjectSet(ObjectSet);

  with AHardwareAccessories do begin
    BIOSVersion := _GetPropertyValue(BIOS, PROP_BIOS_VERSION, '');
  end;

end; // THardwareManager._GetBIOSInfo


procedure THardwareManager._GetMemoryInfo(
    const AWMIServices: ISWbemServices;
    var AHardwareAccessories: THardwareAccessories);
const
  QUERY_TO_WMI = 'select * from Win32_PhysicalMemory';
  PROP_BANK_LABEL = 'BankLabel';
  PROP_CAPACITY = 'Capacity';
  PROP_NAME = 'Name';
  PROP_SPEED = 'Speed';
var
  Memory: ISWbemObject;
  ObjectSet: ISWbemObjectSet;
  ObjEnum: IEnumVariant;
  varObj: OleVariant;
  nFetched: Cardinal;
begin
  ObjectSet := AWMIServices.ExecQuery(QUERY_TO_WMI, LNG_WQL,
      wbemFlagUseAmendedQualifiers, nil);

  ObjEnum := (ObjectSet._NewEnum) as IEnumVariant;
  while (ObjEnum.Next(1, varObj, nFetched) = S_OK) do begin

    Memory := IUnknown(varObj) as SWBemObject;

    with AHardwareAccessories.Memories.Add() do begin
      Name := _GetPropertyValue(Memory, PROP_NAME, '');
      BankLabel := _GetPropertyValue(Memory, PROP_BANK_LABEL, '');
      Capacity := _GetPropertyValue(Memory, PROP_CAPACITY, '');
      Speed := _GetPropertyValue(Memory, PROP_SPEED, '');
    end;

  end;

end; // THardwareManager._GetMemoryInfo


procedure THardwareManager._GetDiskDrivesInfo(
    const AWMIServices: ISWbemServices;
    var AHardwareAccessories: THardwareAccessories);
const
  QUERY_TO_WMI = 'select * from Win32_DiskDrive';
  PROP_DEVICE_ID = 'DeviceID';
  PROP_CAPTION = 'Caption';
  PROP_MODEL = 'Model';
  PROP_NAME = 'Name';
  PROP_SIZE = 'Size';
  PROP_INTERFACE_TYPE = 'InterfaceType';
var
  HDD: SWBemObject;
  ObjectSet: ISWbemObjectSet;
  ObjEnum: IEnumVariant;
  varObj: OleVariant;
  nFetched: Cardinal;
begin
  ObjectSet := AWMIServices.ExecQuery(QUERY_TO_WMI, LNG_WQL,
      wbemFlagUseAmendedQualifiers, nil);

  ObjEnum := (ObjectSet._NewEnum) as IEnumVariant;
  while (ObjEnum.Next(1, varObj, nFetched) = S_OK) do begin

    HDD := IUnknown(varObj) as SWBemObject;

    with AHardwareAccessories.HDDs.Add() do begin
      Name := _GetPropertyValue(HDD, PROP_NAME, '');
      DeviceId := _GetPropertyValue(HDD, PROP_DEVICE_ID, '');
      Caption := _GetPropertyValue(HDD, PROP_CAPTION, '');
      Model := _GetPropertyValue(HDD, PROP_MODEL, '');
      Size := _GetPropertyValue(HDD, PROP_SIZE, '');
      InterfaceType := _GetPropertyValue(HDD, PROP_INTERFACE_TYPE, '');
    end;

  end;

end; // THardwareManager._GetDiskDrivesInfo


procedure THardwareManager._GetCDROMDrivesInfo(
    const AWMIServices: ISWbemServices;
    var AHardwareAccessories: THardwareAccessories);
const
  QUERY_TO_WMI = 'select * from Win32_CDROMDrive';
  PROP_NAME = 'Name';
  PROP_MEDIA_TYPE = 'MediaType';
var
  CDROM: ISWbemObject;
  ObjectSet: ISWbemObjectSet;
  ObjEnum: IEnumVariant;
  varObj: OleVariant;
  nFetched: Cardinal;
begin
  ObjectSet := AWMIServices.ExecQuery(QUERY_TO_WMI, LNG_WQL,
      wbemFlagUseAmendedQualifiers, nil);

  ObjEnum := (ObjectSet._NewEnum) as IEnumVariant;
  while (ObjEnum.Next(1, varObj, nFetched) = S_OK) do begin

    CDROM := IUnknown(varObj) as SWBemObject;

    with AHardwareAccessories.CDROMs.Add() do begin
      Name := _GetPropertyValue(CDROM, PROP_NAME, '');
      MediaType := _GetPropertyValue(CDROM, PROP_MEDIA_TYPE, '');
    end;

  end;

end; // THardwareManager._GetCDROMDrivesInfo


procedure THardwareManager._GetVideoControllerInfo(
    const AWMIServices: ISWbemServices;
    var AHardwareAccessories: THardwareAccessories);
const
  QUERY_TO_WMI = 'Win32_VideoController';
  PROP_NAME = 'Name';
  PROP_VIDEO_PROCESSOR = 'VideoProcessor';
  PROP_RAM_CAPACITY = 'AdapterRAM';
var
  AllVideoControllers: ISWbemObject;
  VideoController: ISWbemObject;
  ObjectSet: ISWbemObjectSet;
begin
  AllVideoControllers := AWMIServices.Get(QUERY_TO_WMI,
      wbemFlagUseAmendedQualifiers, nil);

  ObjectSet := AllVideoControllers.Instances_(0, nil);
  VideoController := _GetFirstObjectFromSWbemObjectSet(ObjectSet);

  with AHardwareAccessories.VideoController do begin
    Name := _GetPropertyValue(VideoController, PROP_NAME, '');
    VideoProcessor := _GetPropertyValue(
        VideoController, PROP_VIDEO_PROCESSOR, '');
    RAMCapacity := _GetPropertyValue(
        VideoController, PROP_RAM_CAPACITY, '0');
  end;

end; // THardwareManager._GetVideoControllerInfo


procedure THardwareManager._GetSoundDevicesInfo(
    const AWMIServices: ISWbemServices;
    var AHardwareAccessories: THardwareAccessories);
const
  QUERY_TO_WMI = 'select * from Win32_SoundDevice';
  PROP_NAME = 'Name';
  PROP_DEVICE_ID = 'DeviceID';
var
  SoundDevice: ISWbemObject;
  ObjectSet: ISWbemObjectSet;
  ObjEnum: IEnumVariant;
  varObj: OleVariant;
  nFetched: Cardinal;
begin
  ObjectSet := AWMIServices.ExecQuery(QUERY_TO_WMI, LNG_WQL,
      wbemFlagUseAmendedQualifiers, nil);

  ObjEnum := (ObjectSet._NewEnum) as IEnumVariant;
  while (ObjEnum.Next(1, varObj, nFetched) = S_OK) do begin

    SoundDevice := IUnknown(varObj) as SWBemObject;

    with AHardwareAccessories.SoundDevices.Add() do begin
      Name := _GetPropertyValue(SoundDevice, PROP_NAME, '');
      DeviceId := _GetPropertyValue(SoundDevice, PROP_DEVICE_ID, '');
    end;

  end;

end; // THardwareManager._GetSoundDevicesInfo


procedure THardwareManager._GetFloppyDrivesInfo(
    const AWMIServices: ISWbemServices;
    var AHardwareAccessories: THardwareAccessories);
const
  QUERY_TO_WMI = 'select * from Win32_FloppyDrive';
  PROP_NAME = 'Name';
  PROP_DEVICE_ID = 'DeviceID';
var
  Floppy: ISWbemObject;
  ObjectSet: ISWbemObjectSet;
  ObjEnum: IEnumVariant;
  varObj: OleVariant;
  nFetched: Cardinal;
begin
  ObjectSet := AWMIServices.ExecQuery(QUERY_TO_WMI, LNG_WQL,
      wbemFlagUseAmendedQualifiers, nil);

  ObjEnum := (ObjectSet._NewEnum) as IEnumVariant;
  while (ObjEnum.Next(1, varObj, nFetched) = S_OK) do begin

    Floppy := IUnknown(varObj) as SWBemObject;

    with AHardwareAccessories.FloppyDrives.Add() do begin
      Name := _GetPropertyValue(Floppy, PROP_NAME, '');
      DeviceId := _GetPropertyValue(Floppy, PROP_DEVICE_ID, '');
    end;

  end;

end; // THardwareManager._GetFloppyControllerInfo


procedure THardwareManager._GetNetworkAdaptersInfo(
    const AWMIServices: ISWbemServices;
    var AHardwareAccessories: THardwareAccessories);
const
  QUERY_TO_WMI = 'select * from Win32_NetworkAdapterConfiguration '
      + 'where IPEnabled=true';
  PROP_CAPTION = 'Caption';
  PROP_MAC_ADDRESS = 'MACAddress';
var
  NetworkAdapter: ISWbemObject;
  ObjectSet: ISWbemObjectSet;
  ObjEnum: IEnumVariant;
  varObj: OleVariant;
  nFetched: Cardinal;
begin
  ObjectSet := AWMIServices.ExecQuery(QUERY_TO_WMI, LNG_WQL,
      wbemFlagUseAmendedQualifiers, nil);

  ObjEnum := (ObjectSet._NewEnum) as IEnumVariant;
  while (ObjEnum.Next(1, varObj, nFetched) = S_OK) do begin

    NetworkAdapter := IUnknown(varObj) as SWBemObject;

    with AHardwareAccessories.NetworkAdapters.Add() do begin
      Caption := _GetPropertyValue(NetworkAdapter, PROP_CAPTION, '');
      MACAddress := _GetPropertyValue(NetworkAdapter, PROP_MAC_ADDRESS, '');
    end;

  end;

end; // THardwareManager._GetNetworkAdaptersInfo


initialization

finalization

  THardwareManager.ReleaseInstance();

end.
