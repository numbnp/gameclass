//////////////////////////////////////////////////////////////////////////////
//
//
//
//////////////////////////////////////////////////////////////////////////////

unit uOptionsFolderList;

interface

uses
  // system units
  Contnrs,
  // project units
  uOptionsFolder;


type

  //
  // TOptionsFolderList
  //

  TOptionsFolderList = class(TObjectList)
  protected
    // properties methods
    function GetItems(const Index: Integer): TOptionsFolder;
    procedure SetItems(const Index: Integer; AOptionsFolder: TOptionsFolder);

  public
    // constructor / destructor
    destructor Destroy(); override;

    // list public methods
    function Add(AOptionsFolder: TOptionsFolder): Integer;
    function Extract(AOptionsFolder: TOptionsFolder): TOptionsFolder;
    procedure Insert(const Index: Integer; AOptionsFolder: TOptionsFolder);
    function Remove(AOptionsFolder: TOptionsFolder): Integer;
    function IndexOf(AOptionsFolder: TOptionsFolder): Integer;
    function First(): TOptionsFolder;
    function Last(): TOptionsFolder;

    // list properties
    property Items[const Index: Integer]: TOptionsFolder
        read GetItems write SetItems; default;

  end; // TOptionsFolderList


implementation

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

destructor TOptionsFolderList.Destroy();
begin
  inherited Destroy();
end; // TOptionsFolderList.Destroy


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// list public methods

function TOptionsFolderList.Add(AOptionsFolder: TOptionsFolder): Integer;
begin
  Result := inherited Add(AOptionsFolder);
end; // TOptionsFolderList.Add


function TOptionsFolderList.Extract(AOptionsFolder: TOptionsFolder): TOptionsFolder;
begin
  Result := TOptionsFolder(inherited Extract(AOptionsFolder));
end; // TOptionsFolderList.Extract


procedure TOptionsFolderList.Insert(
    const Index: Integer; AOptionsFolder: TOptionsFolder);
begin
  inherited Insert(Index, AOptionsFolder);
end; // TOptionsFolderList.Insert


function TOptionsFolderList.Remove(AOptionsFolder: TOptionsFolder): Integer;
begin
  Result := inherited Remove(AOptionsFolder);
end; // TOptionsFolderList.Remove


function TOptionsFolderList.IndexOf(AOptionsFolder: TOptionsFolder): Integer;
begin
  Result := inherited IndexOf(AOptionsFolder);
end; // TOptionsFolderList.IndexOf


function TOptionsFolderList.First(): TOptionsFolder;
begin
  Result := TOptionsFolder(inherited First());
end; // TOptionsFolderList.First


function TOptionsFolderList.Last(): TOptionsFolder;
begin
  Result := TOptionsFolder(inherited Last());
end; // TOptionsFolderList.Last


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// properties methods

function TOptionsFolderList.GetItems(const Index: Integer): TOptionsFolder;
begin
  Result := TOptionsFolder(inherited Items[Index]);
end; // TOptionsFolderList.GetItems


procedure TOptionsFolderList.SetItems(
    const Index: Integer; AOptionsFolder: TOptionsFolder);
begin
  inherited Items[Index] := AOptionsFolder;
end; // TOptionsFolderList.SetItems


end.
