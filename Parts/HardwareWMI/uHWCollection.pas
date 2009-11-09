//////////////////////////////////////////////////////////////////////////////
//
// THWCollectionItem - базовый класс для элементов коллекций, содержащих
// информацию об оборудовании, установленном на компьютере.
// Объект класса THWCollectionItem не может быть создан, но все
// классы-элементы коллекций, непосредственно содержащие информацию об
// оборудовании, должны быть унаследованы от этого класса.
//
// THWCollection - базовый класс-коллекция объектов THWCollectionItem.
// Коллекции, содержащие информацию об оборудовании, должны быть
// унаследованы от этого класса.
//
//////////////////////////////////////////////////////////////////////////////

unit uHWCollection;

interface

uses
  // system units
  Classes;


type

  //
  // THWCollectionItem
  //

  THWCollectionItem = class(TCollectionItem)
  public
    // public methods
    function AsString(): String; virtual; abstract;

  end; // THWCollectionItem

  THWCollectionItemClass = class of THWCollectionItem;


  //
  // THWCollection
  //

  THWCollection = class(TCollection)
  private
    // fields
    FstrHWPrefix: String;
    FstrHWGroupTag: String;
    
  protected
    // properties methods
    function GetItem(const AnIndex: Integer): THWCollectionItem;
    procedure SetItem(const AnIndex: Integer;
        const AHWCollectionItem: THWCollectionItem);

    // properties
    property HWPrefix: String read FstrHWPrefix write FstrHWPrefix;
    property HWGroupTag: String read FstrHWGroupTag write FstrHWGroupTag;

  public
    // constructor / destructor
    constructor Create(const AItemClass: THWCollectionItemClass);

    // public methods
    function Add(): THWCollectionItem;
    function AsString(): String; virtual;

    // properties
    property Items[const Index: Integer]: THWCollectionItem
        read GetItem write SetItem; default;

  end; // THWCollection


implementation

uses
  // system units
  sysUtils,
  // project units
  uY2KString,
  uHWConst;


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// THWCollection

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor THWCollection.Create(const AItemClass: THWCollectionItemClass);
begin
  inherited Create(AItemClass);

  FstrHWPrefix := HW_PREFIX;
  FstrHWGroupTag := HW_GROUP_TAG;

end; // THWCollection.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

function THWCollection.Add(): THWCollectionItem;
begin
  Result := THWCollectionItem(inherited Add())
end; // THWCollection.Add


function THWCollection.AsString(): String;
var
  i: Integer;
  strHWIndex: String;
  strParameters: String;
begin
  Result := '';
  for i := 0 to Count - 1 do begin
    strHWIndex := IntToStr(i);
    strParameters := 'Id=' +
        DoubleQuotedStr(strHWIndex) + ' ' + Items[i].AsString();
    Result := Result + TagStr(HWPrefix, strParameters);
  end;

  Result := TagStr(HWGroupTag, '', Result);

end; // THWCollection.AsString


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// properties methods

function THWCollection.GetItem(const AnIndex: Integer): THWCollectionItem;
begin
  ASSERT((0 <= AnIndex) and (AnIndex < Count));

  Result := THWCollectionItem(inherited GetItem(AnIndex));

end; // THWCollection.GetItem


procedure THWCollection.SetItem(const AnIndex: Integer;
    const AHWCollectionItem: THWCollectionItem);
begin
  ASSERT(Assigned(AHWCollectionItem));
  ASSERT((0 <= AnIndex) and (AnIndex < Count));

  SetItem(AnIndex, AHWCollectionItem);

end; // THWCollection.SetItem


end.
