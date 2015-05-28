//////////////////////////////////////////////////////////////////////////////
//
// TFloppyDrive - класс, содержищий информацию о дисководе.
// TFloppyDrives - класс-коллекция объектов TFloppyDrive.
//
//////////////////////////////////////////////////////////////////////////////

unit uHWFloppyDrives;

interface

uses
  // project units
  uHWCollection;


type

  // forward declarations
  TFloppyDrives = class;


  //
  // TFloppyDrive
  //

  TFloppyDrive = class(THWCollectionItem)
  private
    // fields
    FstrDeviceId: String;
    FstrName: String;

  public
    // constructor / destructor
    constructor Create(const AFloppyDrives: TFloppyDrives); reintroduce;

    // public methods
    function AsString(): String; override;

    // properties
    property DeviceId: String read FstrDeviceId write FstrDeviceId;
    property Name: String read FstrName write FstrName;

  end; // TFloppyDrive


  //
  // TFloppyDrives
  //

  TFloppyDrives = class(THWCollection)
  protected
    // properties methods
    function GetItem(const AnIndex: Integer): TFloppyDrive;
    procedure SetItem(
        const AnIndex: Integer; const AFloppyDrive: TFloppyDrive);

  public
    // constructor / destructor
    constructor Create();

    // public methods
    function Add(): TFloppyDrive;

    // properties
    property Items[const Index: Integer]: TFloppyDrive
        read GetItem write SetItem; default;

  end; // TFloppyDrives


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
// TFloppyDrive

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TFloppyDrive.Create(const AFloppyDrives: TFloppyDrives);
begin
  inherited Create(AFloppyDrives);

  FstrDeviceId := '';
  FstrName := '';
  
end; // TFloppyDrive.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

function TFloppyDrive.AsString(): String;
begin
  Result := TAG_FLOPPY_DEVICE_ID + '=' + DoubleQuotedStr(DeviceId)
      + DIVIDER_FOR_HW_AS_STRING
      + TAG_FLOPPY_NAME + '=' + DoubleQuotedStr(Name);
end; // TFloppyDrive.AsString


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// TFloppyDrives

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TFloppyDrives.Create();
begin
  inherited Create(TFloppyDrive);

  HWPrefix := FLOPPY_TAG;
  HWGroupTag := FLOPPY_GROUP_TAG;

end; // TFloppyDrives.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

function TFloppyDrives.Add(): TFloppyDrive;
begin
  Result := TFloppyDrive(inherited Add());
end; // TFloppyDrives.Add


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// properties methods

function TFloppyDrives.GetItem(const AnIndex: Integer): TFloppyDrive;
begin
  ASSERT((0 <= AnIndex) and (AnIndex < Count));

  Result := TFloppyDrive(inherited GetItem(AnIndex));

end; // TFloppyDrives.GetItem


procedure TFloppyDrives.SetItem(
    const AnIndex: Integer; const AFloppyDrive: TFloppyDrive);
begin
  ASSERT(Assigned(AFloppyDrive));
  ASSERT((0 <= AnIndex) and (AnIndex < Count));

  SetItem(AnIndex, AFloppyDrive);

end; // TFloppyDrives.SetItem


end.
