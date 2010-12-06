//////////////////////////////////////////////////////////////////////////////
//
// THDD - класс, содержищий информацию о жеском диске или о накопителе USB.
// THDDs - класс-коллекция объектов THDD.
//
//////////////////////////////////////////////////////////////////////////////

unit uHWHDDs;

interface

uses
  // project units
  uHWCollection;

type

  // forward declaration
  THDDs = class;

  //
  // THDD
  //

  THDD = class(THWCollectionItem)
  private
    // fields
    FstrDeviceId: String;
    FstrCaption: String;
    FstrModel: String;
    FstrName: String;
    FstrSize: String;
    FstrInterfaceType: String;

  public
    // constructor / destructor
    constructor Create(const AHDDs: THDDs); reintroduce;

    // public methods
    function AsString(): String; override;

    // properties
    property DeviceId: String read FstrDeviceId write FstrDeviceId;
    property Caption: String read FstrCaption write FstrCaption;
    property Model: String read FstrModel write FstrModel;
    property Name: String read FstrName write FstrName;
    property Size: String read FstrSize write FstrSize;
    property InterfaceType: String
        read FstrInterfaceType write FstrInterfaceType;

  end; // THDD


  //
  // THDDs
  //

  THDDs = class(THWCollection)
  protected
    // properties methods
    function GetItem(const AnIndex: Integer): THDD;
    procedure SetItem(const AnIndex: Integer; const AHDD: THDD);

  public
    // constructor / destructor
    constructor Create();

    // public methods
    function Add(): THDD;

    // properties
    property Items[const Index: Integer]: THDD
        read GetItem write SetItem; default;

  end; // THDDs



implementation

uses
  // project units
  uY2KString,
  uHWConst;


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// THDD

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor THDD.Create(const AHDDs: THDDs);
begin
  inherited Create(AHDDs);

  FstrDeviceId := '';
  FstrCaption := '';
  FstrModel := '';
  FstrName := '';
  FstrSize := '0';
  FstrInterfaceType := '0';

end; // THDD.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

function THDD.AsString(): String;
begin
  Result := TAG_HDD_DEVICE_ID + '=' + DoubleQuotedStr(DeviceId)
      + DIVIDER_FOR_HW_AS_STRING
      + TAG_HDD_CAPTION + '=' + DoubleQuotedStr(Caption)
      + DIVIDER_FOR_HW_AS_STRING
      + TAG_HDD_MODEL + '=' + DoubleQuotedStr(Model)
      + DIVIDER_FOR_HW_AS_STRING
      + TAG_HDD_NAME + '=' + DoubleQuotedStr(Name)
      + DIVIDER_FOR_HW_AS_STRING
      + TAG_HDD_SIZE + '=' + DoubleQuotedStr(Size)
      + DIVIDER_FOR_HW_AS_STRING
      + TAG_HDD_INTERFACE_TYPE + '=' + DoubleQuotedStr(InterfaceType);

end; // THDD.AsString


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// THDDs

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor THDDs.Create();
begin
  inherited Create(THDD);

  HWPrefix := HDD_TAG;
  HWGroupTag := HDD_GROUP_TAG;  

end; // THDDs.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

function THDDs.Add(): THDD;
begin
  Result := THDD(inherited Add());
end; // THDDs.Add


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// properties methods

function THDDs.GetItem(const AnIndex: Integer): THDD;
begin
  Result := THDD(inherited GetItem(AnIndex));
end; // THDDs.GetItem


procedure THDDs.SetItem(const AnIndex: Integer; const AHDD: THDD);
begin
  inherited SetItem(AnIndex, AHDD);
end; // THDDs.SetItem


end.
