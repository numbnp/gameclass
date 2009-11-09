//////////////////////////////////////////////////////////////////////////////
//
//
//
//////////////////////////////////////////////////////////////////////////////

unit uOptionList;

interface

uses
  // system units
  Contnrs,
  // project units
  uOption;


type

  //
  // TOptionList
  //

  TOptionList = class(TObjectList)
  protected
    // properties methods
    function GetItems(const Index: Integer): TOption;
    procedure SetItems(const Index: Integer; AOption: TOption);

  public
    // constructor / destructor
    destructor Destroy(); override;

    // list public methods
    function Add(AOption: TOption): Integer;
    function Extract(AOption: TOption): TOption;
    procedure Insert(const Index: Integer; AOption: TOption);
    function Remove(AOption: TOption): Integer;
    function IndexOf(AOption: TOption): Integer;
    function First(): TOption;
    function Last(): TOption;

    // list properties
    property Items[const Index: Integer]: TOption
        read GetItems write SetItems; default;

  end; // TOptionList


implementation

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

destructor TOptionList.Destroy();
begin
  inherited Destroy();
end; // TOptionList.Destroy


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// list public methods

function TOptionList.Add(AOption: TOption): Integer;
begin
  Result := inherited Add(AOption);
end; // TOptionList.Add


function TOptionList.Extract(AOption: TOption): TOption;
begin
  Result := TOption(inherited Extract(AOption));
end; // TOptionList.Extract


procedure TOptionList.Insert(const Index: Integer; AOption: TOption);
begin
  inherited Insert(Index, AOption);
end; // TOptionList.Insert


function TOptionList.Remove(AOption: TOption): Integer;
begin
  Result := inherited Remove(AOption);
end; // TOptionList.Remove


function TOptionList.IndexOf(AOption: TOption): Integer;
begin
  Result := inherited IndexOf(AOption);
end; // TOptionList.IndexOf


function TOptionList.First(): TOption;
begin
  Result := TOption(inherited First());
end; // TOptionList.First


function TOptionList.Last(): TOption;
begin
  Result := TOption(inherited Last());
end; // TOptionList.Last


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// properties methods

function TOptionList.GetItems(const Index: Integer): TOption;
begin
  Result := TOption(inherited Items[Index]);
end; // TOptionList.GetItems


procedure TOptionList.SetItems(const Index: Integer; AOption: TOption);
begin
  inherited Items[Index] := AOption;
end; // TOptionList.SetItems


end.
