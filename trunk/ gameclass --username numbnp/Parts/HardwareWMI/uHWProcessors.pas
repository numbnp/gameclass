//////////////////////////////////////////////////////////////////////////////
//
// TProcessor - класс, содержищий информацию о центральном процессоре.
// TProcessors - класс-коллекция объектов TProcessor.
//
//////////////////////////////////////////////////////////////////////////////

unit uHWProcessors;

interface

uses
  // system units
  Classes,
  // project units
  uHWCollection;


type

  // forward declarations
  TProcessors = class;


  //
  // TProcessor
  //

  TProcessor = class(THWCollectionItem)
  private
    FstrDeviceId: String;
    FstrName: String;
    FstrId: String;
    FstrMaxClockSpeed: String;
    FstrVersion: String;

  public
    // constructor / destructor
    constructor Create(const AProcessors: TProcessors); reintroduce;

    // public methods
    function AsString(): String; override;

    // properties
    property DeviceId: String read FstrDeviceId write FstrDeviceId;
    property Name: String read FstrName write FstrName;
    property ProcessorId: String read FstrId write FstrId;
    property MaxClockSpeed: String
        read FstrMaxClockSpeed write FstrMaxClockSpeed;
    property Version: String read FstrVersion write FstrVersion;

  end; // TProcessor


  //
  // TProcessors
  //

  TProcessors = class(THWCollection)
  protected
    // properties methods
    function GetItem(const AnIndex: Integer): TProcessor;
    procedure SetItem(const AnIndex: Integer; const AProcessor: TProcessor);

  public
    // constructor / destructor
    constructor Create();

    // public methods
    function Add(): TProcessor;

    // properties
    property Items[const AnIndex: Integer]: TProcessor
        read GetItem write SetItem; default;

  end; // TProcessors


implementation

uses
  // project units
  uY2KString,
  uHWConst;


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// TProcessor

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TProcessor.Create(const AProcessors: TProcessors);
begin
  inherited Create(AProcessors);

  FstrDeviceId := '';
  FstrName := '';
  FstrId := '';
  FstrMaxClockSpeed := '';
  FstrVersion := '';

end; // TProcessor.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

function TProcessor.AsString(): String;
begin
  Result := TAG_CPU_DEVICE_ID + '=' + DoubleQuotedStr(DeviceId)
      + DIVIDER_FOR_HW_AS_STRING
      + TAG_CPU_NAME + '=' + DoubleQuotedStr(Name)
      + DIVIDER_FOR_HW_AS_STRING
      + TAG_CPU_PROCESSOR_ID + '=' + DoubleQuotedStr(ProcessorId)
      + DIVIDER_FOR_HW_AS_STRING
      + TAG_CPU_MAX_CLOCK_SPEED + '=' + DoubleQuotedStr(MaxClockSpeed)
      + DIVIDER_FOR_HW_AS_STRING
      + TAG_CPU_VERSION + '=' + DoubleQuotedStr(Version);
end; // TProcessor.AsString


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// TProcessors

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TProcessors.Create();
begin
  inherited Create(TProcessor);

  HWPrefix := CPU_TAG;
  HWGroupTag := CPU_GROUP_TAG;

end; // TProcessors.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

function TProcessors.Add(): TProcessor;
begin
  Result := TProcessor(inherited Add());
end; // TProcessors.Add


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// properties methods

function TProcessors.GetItem(const AnIndex: Integer): TProcessor;
begin
  ASSERT((0 <= AnIndex) and (AnIndex < Count));

  Result := TProcessor(inherited GetItem(AnIndex));

end; // TProcessors.GetItem


procedure TProcessors.SetItem(
    const AnIndex: Integer; const AProcessor: TProcessor);
begin
  ASSERT(Assigned(AProcessor));
  ASSERT((0 <= AnIndex) and (AnIndex < Count));

  inherited SetItem(AnIndex, AProcessor);

end; // TProcessors.SetItem


end.
