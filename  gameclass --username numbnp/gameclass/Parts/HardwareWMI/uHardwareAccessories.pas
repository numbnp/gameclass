//////////////////////////////////////////////////////////////////////////////
//
// THardwareAccessories - класс, содержащий всю информацию об оборудовании,
// установленном на копьютере.
//
//////////////////////////////////////////////////////////////////////////////

unit uHardwareAccessories;

interface

uses
  // project units
  uY2KString,
  uY2KCommon,
  uHWConst,
  uHWProcessors,
  uHWMemories,
  uHWHDDs,
  uHWFloppyDrives,
  uHWNetworkAdapters,
  uHWSoundDevices,
  uHWVideoControllers,
  uHWCDROMs;

type

  //
  // THardwareAccessories
  //

  THardwareAccessories = class(TObject)
  private
    // fields
    FstrComputerName: String;
    FstrNumberOfProcessors: String;
    FstrBIOSVersion: String;
    FstrMBSerialNumber: String;
    FProcessors: TProcessors;
    FMemories: TMemories;
    FVideoController: TVideoController;
    FHDDs: THDDs;
    FFloppyDrives: TFloppyDrives;
    FNetworkAdapters: TNetworkAdapters;
    FSoundDevices: TSoundDevices;
    FCDROMs: TCDROMs;

    // private helper methods
    function _GetSystemInfoAsString(): String;

  public
    // constructor / destructor
    constructor Create();
    destructor Destroy(); override;

    // public methods
    procedure Clear();
    function AsString(): String;

    // properties
    property ComputerName: String
        read FstrComputerName write FstrComputerName;
    property NumberOfProcessors: String
        read FstrNumberOfProcessors write FstrNumberOfProcessors;
    property BIOSVersion: String
        read FstrBIOSVersion write FstrBIOSVersion;
    property MBSerialNumber: String
        read FstrMBSerialNumber write FstrMBSerialNumber;
    property Processors: TProcessors read FProcessors write FProcessors;
    property Memories: TMemories read FMemories write FMemories;
    property VideoController: TVideoController
        read FVideoController write FVideoController;
    property HDDs: THDDs read FHDDs write FHDDs;
    property CDROMs: TCDROMs read FCDROMs write FCDROMs;
    property FloppyDrives: TFloppyDrives
        read FFloppyDrives write FFloppyDrives;
    property NetworkAdapters: TNetworkAdapters
        read FNetworkAdapters write FNetworkAdapters;
    property SoundDevices: TSoundDevices
        read FSoundDevices write FSoundDevices;

  end; // THardwareAccessories


implementation


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor THardwareAccessories.Create();
begin
  inherited Create();

  FstrComputerName := '';
  FstrNumberOfProcessors := '1';
  FstrBIOSVersion := '';
  FstrMBSerialNumber := '';

  FProcessors := TProcessors.Create();
  FMemories := TMemories.Create();
  FVideoController := TVideoController.Create();
  FHDDs := THDDs.Create();
  FFloppyDrives := TFloppyDrives.Create();
  FNetworkAdapters := TNetworkAdapters.Create();
  FSoundDevices := TSoundDevices.Create();
  FCDROMs := TCDROMs.Create();

end; // THardwareAccessories.Create


destructor THardwareAccessories.Destroy();
begin
  FreeAndNilWithAssert(FCDROMs);
  FreeAndNilwithAssert(FSoundDevices);
  FreeAndNilwithAssert(FNetworkAdapters);
  FreeAndNilwithAssert(FFloppyDrives);
  FreeAndNilwithAssert(FHDDs);
  FreeAndNilwithAssert(FVideoController);
  FreeAndNilWithAssert(FMemories);
  FreeAndNilWithAssert(FProcessors);

  inherited Destroy();

end; // THardwareAccessories.Destroy


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure THardwareAccessories.Clear();
begin
  ComputerName := '';
  NumberOfProcessors := '1';
  BIOSVersion := '';
  MBSerialNumber := '';

  FProcessors.Clear();
  FMemories.Clear();
  FVideoController.Clear();
  FHDDs.Clear();
  FFloppyDrives.Clear();
  FNetworkAdapters.Clear();
  FSoundDevices.Clear();
  FCDROMs.Clear();
  
end; // THardwareAccessories.Clear


function THardwareAccessories.AsString(): String;
begin
  Result := _GetSystemInfoAsString()
      + FProcessors.AsString()
      + FMemories.AsString()
      + FVideoController.AsString()
      + FHDDs.AsString()
      + FCDROMs.AsString()
      + FFloppyDrives.AsString()
      + FNetworkAdapters.AsString()
      + FSoundDevices.AsString();
end; // THardwareAccessories.AsString


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private helper methods

function THardwareAccessories._GetSystemInfoAsString(): String;
var
  strParameters: String;
begin
  strParameters := TAG_SYSTEM_COMPUTER_NAME + '='
      + DoubleQuotedStr(ComputerName)
      + DIVIDER_FOR_HW_AS_STRING
      + TAG_SYSTEM_NUMBER_OF_PROCESSORS + '='
      + DoubleQuotedStr(NumberOfProcessors)
      + DIVIDER_FOR_HW_AS_STRING
      + TAG_SYSTEM_BIOS_VERSION + '=' + DoubleQuotedStr(BIOSVersion)
      + DIVIDER_FOR_HW_AS_STRING
      + TAG_SYSTEM_MB_SERIAL_NUMBER + '=' + DoubleQuotedStr(MBSerialNumber);

  Result := TagStr(SYSTEM_TAG, strParameters);

end; // THardwareAccessories._GetSystemInfoAsString


end.
