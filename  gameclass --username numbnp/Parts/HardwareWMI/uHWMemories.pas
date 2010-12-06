//////////////////////////////////////////////////////////////////////////////
//
// TMemory - класс, содержищий информацию о линейке оперативной памяти.
// TMemories - класс-коллекция объектов TMemory.
//
//////////////////////////////////////////////////////////////////////////////

unit uHWMemories;

interface

uses
  // project units
  uHWCollection;


type

  // forward declarations
  TMemories = class;


  //
  // TMemory
  //

  TMemory = class(THWCollectionItem)
  private
    // fields
    FstrBankLabel: String;
    FstrCapacity: String;
    FstrName: String;
    FstrSpeed: String;

  public
    // constructor / destructor
    constructor Create(const AMemories: TMemories); reintroduce;

    // public methods
    function AsString(): String; override;

    // properties
    property BankLabel: String read FstrBankLabel write FstrBankLabel;
    property Capacity: String read FstrCapacity write FstrCapacity;
    property Name: String read FstrName write FstrName;
    property Speed: String read FstrSpeed write FstrSpeed;

  end; // TMemory


  //
  // TMemories
  //

  TMemories = class(THWCollection)
  protected
    // properties methods
    function GetItem(const AnIndex: Integer): TMemory;
    procedure SetItem(const AnIndex: Integer; const AMemory: TMemory);
  public
    // constructor / destructor
    constructor Create();

    // public methods
    function Add(): TMemory;

    // properties
    property Items[const Index: Integer]: TMemory
        read GetItem write SetItem; default;

  end; // TMemories


implementation

uses
  // project units
  uY2KString,
  uHWConst;


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// TMemory

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TMemory.Create(const AMemories: TMemories);
begin
  inherited Create(AMemories);

  FstrBankLabel := '';
  FstrCapacity := '0';
  FstrName := '';
  FstrSpeed := '0';

end; // TMemory.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

function TMemory.AsString(): String;
begin
  Result := TAG_MEMORY_BANK_LABEL + '=' + DoubleQuotedStr(BankLabel)
      + DIVIDER_FOR_HW_AS_STRING
      + TAG_MEMORY_CAPACITY + '=' + DoubleQuotedStr(Capacity)
      + DIVIDER_FOR_HW_AS_STRING
      + TAG_MEMORY_NAME + '=' + DoubleQuotedStr(Name)
      + DIVIDER_FOR_HW_AS_STRING
      + TAG_MEMORY_SPEED + '=' + DoubleQuotedStr(Speed);
end; // TMemory.AsString


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// TMemories

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TMemories.Create();
begin
  inherited Create(TMemory);

  HWPrefix := MEMORY_TAG;
  HWGroupTag := MEMORY_GROUP_TAG;  

end; // TMemories.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

function TMemories.Add(): TMemory;
begin
  Result := TMemory(inherited Add());
end; // TMemories.Add


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// properties methods

function TMemories.GetItem(const AnIndex: Integer): TMemory;
begin
  ASSERT((0 <= AnIndex) and (AnIndex < Count));

  Result := TMemory(inherited GetItem(AnIndex));

end; // TMemories.GetItem


procedure TMemories.SetItem(const AnIndex: Integer; const AMemory: TMemory);
begin
  ASSERT(Assigned(AMemory));
  ASSERT((0 <= AnIndex) and (AnIndex < Count));

  inherited SetItem(AnIndex, AMemory);

end; // TMemories.SetItem


end.
