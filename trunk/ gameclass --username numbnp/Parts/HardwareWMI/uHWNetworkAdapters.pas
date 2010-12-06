//////////////////////////////////////////////////////////////////////////////
//
// TNetworkAdapter - класс, содержищий информацию о сетевом адаптере.
// TNetworkAdapters - класс-коллекция объектов TNetworkAdapter.
//
//////////////////////////////////////////////////////////////////////////////

unit uHWNetworkAdapters;

interface

uses
  // project units
  uHWCollection;


type

  // forward declaration
  TNetworkAdapters = class;


  //
  // TNetworkAdapter
  //

  TNetworkAdapter = class(THWCollectionItem)
  private
    // fields
    FstrCaption: String;
    FstrMACAddress: String;

  public
    // constructor / destructor
    constructor Create(const ANetworkAdapters: TNetworkAdapters); reintroduce;

    // public methods
    function AsString(): String; override;

    // properties
    property Caption: String read FstrCaption write FstrCaption;
    property MACAddress: String read FstrMACAddress write FstrMACAddress;

  end; // TNetworkAdapter


  //
  // TNetworkAdapters
  //

  TNetworkAdapters = class(THWCollection)
  protected
    // properties methods
    function GetItem(const AnIndex: Integer): TNetworkAdapter;
    procedure SetItem(
        const AnIndex: Integer; const ANetworkAdapter: TNetworkAdapter);

  public
    // constructor / destructor
    constructor Create();

    // public methods
    function Add(): TNetworkAdapter;
        
    // properties
    property Items[const Index: integer]: TNetworkAdapter
      read GetItem write SetItem; default;

  end; // TNetworkAdapters



implementation

uses
  // project units
  uY2KString,
  uHWConst;


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// TNetworkAdapter

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TNetworkAdapter.Create(const ANetworkAdapters: TNetworkAdapters);
begin
  inherited Create(ANetworkAdapters);

  FstrCaption := '';
  FstrMACAddress := '';

end; // TNetworkAdapter.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

function TNetworkAdapter.AsString(): String;
begin
  Result := TAG_NET_CAPTION + '=' + DoubleQuotedStr(Caption)
      + DIVIDER_FOR_HW_AS_STRING
      + TAG_NET_MAC_ADDRESS + '=' + DoubleQuotedStr(MACAddress);
end; // TNetworkAdapter.AsString


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// TNetworkAdapters

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TNetworkAdapters.Create();
begin
  inherited Create(TNetworkAdapter);

  HWPrefix := NETWORK_TAG;
  HWGroupTag := NETWORK_GROUP_TAG;

end; // TNetworkAdapters.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

function TNetworkAdapters.Add(): TNetworkAdapter;
begin
  Result := TNetworkAdapter(inherited Add());
end; // TNetworkAdapters.Add


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// properties methods

function TNetworkAdapters.GetItem(const AnIndex: Integer): TNetworkAdapter;
begin
  ASSERT((0 <= AnIndex) and (AnIndex < Count));

  Result := TNetworkAdapter(inherited GetItem(AnIndex));

end; // TNetworkAdapters.GetItem


procedure TNetworkAdapters.SetItem(
    const AnIndex: Integer; const ANetworkAdapter: TNetworkAdapter);
begin
  ASSERT(Assigned(ANetworkAdapter));
  ASSERT((0 <= AnIndex) and (AnIndex < Count));

  inherited SetItem(AnIndex, ANetworkAdapter);

end; // TNetworkAdapters.SetItem


end.
