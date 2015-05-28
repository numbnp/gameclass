//////////////////////////////////////////////////////////////////////////////
//
// TSoundDevice - класс, содержищий информацию о звуковой карте.
// TSoundDevices - класс-коллекция объектов TSoundDevice.
//
//////////////////////////////////////////////////////////////////////////////

unit uHWSoundDevices;

interface

uses
  // project units
  uHWCollection;


type

  // forward declarations
  TSoundDevices = class;


  //
  // TSoundDevice
  //

  TSoundDevice = class(THWCollectionItem)
  private
    // fields
    FstrDeviceId: String;
    FstrName: String;

  public
    // constructor / destructor
    constructor Create(const ASoundDevices: TSoundDevices); reintroduce;

    // public methods
    function AsString(): String; override;

    // properties
    property DeviceId: String read FstrDeviceId write FstrDeviceId;
    property Name: String read FstrName write FstrName;

  end; // TSoundDevices


  //
  // TSoundDevices
  //

  TSoundDevices = class(THWCollection)
  protected
    // properties methods
    function GetItem(const AnIndex: Integer): TSoundDevice;
    procedure SetItem(
        const AnIndex: Integer; const ASoundDevice: TSoundDevice);

  public
    // constructor / destructor
    constructor Create();

    // public methods
    function Add(): TSoundDevice;

    // properties
    property Items[const Index: Integer]: TSoundDevice
        read GetItem write SetItem; default;

  end; // TSoundDevices


implementation

uses
  // project units
  uY2KString,
  System.Classes,
  uHWConst;


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// TSoundDevice

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destuctor

constructor TSoundDevice.Create(const ASoundDevices: TSoundDevices);
begin
  inherited Create(ASoundDevices);

  FstrDeviceId := '';
  FstrName := '';
  
end; // TSoundDevice.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

function TSoundDevice.AsString(): String;
begin
  Result := TAG_SOUND_DEVICE_ID + '=' + DoubleQuotedStr(DeviceId)
      + DIVIDER_FOR_HW_AS_STRING
      + TAG_SOUND_NAME + '=' + DoubleQuotedStr(Name);
end; // TSoundDevice.AsString


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// TSoundDevices

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TSoundDevices.Create();
begin
  inherited Create(TSoundDevice);

  HWPrefix := SOUND_TAG;
  HWGroupTag := SOUND_GROUP_TAG;

end; // TSoundDevices.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

function TSoundDevices.Add(): TSoundDevice;
begin
  Result := TSoundDevice(inherited Add());
end; // TSoundDevices.Add


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// properties methods

function TSoundDevices.GetItem(const AnIndex: Integer): TSoundDevice;
begin
  ASSERT((0 <= AnIndex) and (AnIndex < Count));

  Result := TSoundDevice(inherited GetItem(AnIndex));

end; // TSoundDevices.GetItem


procedure TSoundDevices.SetItem(
    const AnIndex: Integer; const ASoundDevice: TSoundDevice);
begin
  ASSERT(Assigned(ASoundDevice));
  ASSERT((0 <= AnIndex) and (AnIndex < Count));

  inherited SetItem(AnIndex, ASoundDevice);

end; // TSoundDevices.SetIndex


end.
