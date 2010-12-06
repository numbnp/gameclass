//////////////////////////////////////////////////////////////////////////////
//
// Коллекция описаний процессов
//
//////////////////////////////////////////////////////////////////////////////

unit uProcessesDescriptions;

interface

uses
  // system units
  Classes;

const
  PROCESS_DESCRIPTION_NOT_FOUND = -1;

type

  //
  // TProcessDescription
  //

  TProcessDescription = class(TCollectionItem)
  private
    // fields
    FstrName: String;
    FstrExeFile: String;
    FstrParameters: String;
    FstrWorkDir: String;

  public
    // constructor / destructor
    constructor Create(ACollection: TCollection); override;
    destructor Destroy(); override;

    // properties
    property Name: String read FstrName write FstrName;
    property ExeFile: String read FstrExeFile write FstrExeFile;
    property Parameters: String read FstrParameters write FstrParameters;
    property WorkDir: String read FstrWorkDir write FstrWorkDir;

  end; // TProcessDescription


  //
  // TProcessesDescriptions
  //

  TProcessesDescriptions = class(TCollection)
  protected
    // properties methods
    function GetItem(const AnIndex: Integer): TProcessDescription;
    procedure SetItem(const AnIndex: Integer;
        const AValue: TProcessDescription);

  public
    // constructor / destructor
    constructor Create();

    // public methods
    function Add(): TProcessDescription;
    function FindByName(const AstrName: String): Integer;

    // properties
    property Items[const Index: Integer]: TProcessDescription
        read GetItem write SetItem; default;

  end; // TProcessesDescriptions


implementation

uses
  // system units
  SysUtils;

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// TProcessDescription

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TProcessDescription.Create(ACollection: TCollection);
begin
  inherited Create(ACollection);

  FstrName := '';
  FstrExeFile := '';
  FstrParameters := '';
  FstrWorkDir := '';

end; // TProcessDescription.Create


destructor TProcessDescription.Destroy();
begin
  inherited Destroy();
end; // TProcessDescription.Destroy


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// TProcessesDescriptions

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TProcessesDescriptions.Create();
begin
  inherited Create(TProcessDescription);
end; // TProcessesDescriptions.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

function TProcessesDescriptions.Add(): TProcessDescription;
begin
  Result := TProcessDescription(inherited Add);
end; // TProcessesDescriptions.Add


function TProcessesDescriptions.FindByName(const AstrName: String): Integer;
var
  i: Integer;
begin
  Result := PROCESS_DESCRIPTION_NOT_FOUND;
  for i := 0 to Count - 1 do begin
    if CompareText(Items[i].Name, astrName) = 0 then begin
      Result := i;
      break;
    end;
  end;
end; // TProcessesDescriptions.IsFound


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// properties methods

function TProcessesDescriptions.GetItem(
    const AnIndex: Integer): TProcessDescription;
begin
  Result := TProcessDescription(inherited GetItem(AnIndex));
end; // TProcessesDescriptions.GetItem


procedure TProcessesDescriptions.SetItem(
    const AnIndex: Integer; const AValue: TProcessDescription);
begin
  inherited SetItem(AnIndex, AValue);
end; // TProcessesDescriptions.SetItem


end. ////////////////////////// end of file //////////////////////////////////
