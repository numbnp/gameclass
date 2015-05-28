//////////////////////////////////////////////////////////////////////////////
//
// TCDROM - класс, содержищий информацию о CDROM.
// TCDROMs - класс-коллекция объектов TCDROM.
//
//////////////////////////////////////////////////////////////////////////////

unit uHWCDROMs;

interface

uses
  // project units
  uHWCollection;


type

  // forwards declarations
  TCDROMs = class;


  //
  // TCDROM
  //

  TCDROM = class(THWCollectionItem)
  private
    // fields
    FstrName: String;
    FstrMediaType: String;

  public
    // constructor / destructor
    constructor Create(const ACDROMs: TCDROMs); reintroduce;

    // public methods
    function AsString(): String; override;

    // properties
    property Name: String read FstrName write FstrName;
    property MediaType: String read FstrMediaType write FstrMediaType;

  end; // TCDROM


  //
  // TCDROMs
  //

  TCDROMs = class(THWCollection)
  protected
    // properties methods
    function GetItem(const AnIndex: Integer): TCDROM;
    procedure SetItem(const AnIndex: Integer; const ACDROM: TCDROM);

  public
    // constructor / destructor
    constructor Create();

    // public methods
    function Add(): TCDROM;

    // properties
    property Items[const Index: Integer]: TCDROM
        read GetItem write SetItem; default;

  end; // TCDROMs


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
// TCDROM

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TCDROM.Create(const ACDROMs: TCDROMs);
begin
  inherited Create(ACDROMs);

  FstrName := '';
  FstrMediaType := '';

end; // TCDROM.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

function TCDROM.AsString(): String;
begin
  Result := TAG_CDROM_NAME + '=' + DoubleQuotedStr(Name)
      + DIVIDER_FOR_HW_AS_STRING
      + TAG_CDROM_MEDIA_TYPE + '=' + DoubleQuotedStr(MediaType);
end; // TCDROM.AsString


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// TCDROMs

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TCDROMs.Create();
begin
  inherited Create(TCDROM);

  HWPrefix := CDROM_TAG;
  HWGroupTag := CDROM_GROUP_TAG;

end; // TCDROMs.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

function TCDROMs.Add(): TCDROM;
begin
  Result := TCDROM(inherited Add());
end; // TCDROMs.Add


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// properties methods

function TCDROMs.GetItem(const AnIndex: Integer): TCDROM;
begin
  ASSERT((0 <= AnIndex) and (AnIndex < Count));

  Result := TCDROM(inherited GetItem(AnIndex));

end; // TCDROMs.GetItem


procedure TCDROMs.SetItem(const AnIndex: Integer; const ACDROM: TCDROM);
begin
  ASSERT(Assigned(ACDROM));
  ASSERT((0 <= AnIndex) and (AnIndex < Count));

  inherited SetItem(AnIndex, ACDROM);

end; // TCDROMs.SetItem


end.
