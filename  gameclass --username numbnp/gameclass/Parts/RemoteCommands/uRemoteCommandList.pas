//////////////////////////////////////////////////////////////////////////////
//
// TRemoteCommandList
// Класс - список объектов TRemoteCommand. Наследник от TObjectList.
//
// Карамани Юрий - 05.2005
//
//////////////////////////////////////////////////////////////////////////////

unit uRemoteCommandList;

interface

uses
  // system units
  Contnrs,
  // project units
  uRemoteCommand;

type

  //
  // TRemoteCommandList
  //

  TRemoteCommandList = class(TObjectList)
  protected
    // properties methods
    // Items[index: integer]
    function GetItems(AnIndex: Integer): TRemoteCommand;
    procedure SetItems(AnIndex: Integer; ARemoteCommand: TRemoteCommand);

  public
    // public methods
    function Add(ARemoteCommand: TRemoteCommand): integer;
    function Extract(AItem: TRemoteCommand): TRemoteCommand;
    function Remove(ARemoteCommand: TRemoteCommand): integer;
    function IndexOf(ARemoteCommand: TRemoteCommand): integer;
    function First(): TRemoteCommand;
    function Last(): TRemoteCommand;
    procedure Insert(AnIndex: integer; ARemoteCommand: TRemoteCommand);

    // properties
    property Items[index: integer]: TRemoteCommand
        read GetItems write SetItems; default;

  end; // TRemoteCommandList


implementation

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

function TRemoteCommandList.Add(ARemoteCommand: TRemoteCommand): integer;
begin
  Result := inherited Add(ARemoteCommand);
end; // TRemoteCommandList.Add

function TRemoteCommandList.Extract(AItem: TRemoteCommand): TRemoteCommand;
begin
  Result := TRemoteCommand(inherited Extract(AItem));
end; // TRemoteCommandList.Extract

function TRemoteCommandList.First(): TRemoteCommand;
begin
  Result := TRemoteCommand(inherited First);
end; // TRemoteCommandList.First

function TRemoteCommandList.IndexOf(ARemoteCommand: TRemoteCommand): integer;
begin
  Result := inherited IndexOf(ARemoteCommand);
end; // TRemoteCommandList.IndexOf

procedure TRemoteCommandList.Insert(AnIndex: integer;
    ARemoteCommand: TRemoteCommand);
begin
  inherited Insert(AnIndex, ARemoteCommand);
end; // TRemoteCommandList.Insert

function TRemoteCommandList.Last(): TRemoteCommand;
begin
  Result := TRemoteCommand(inherited Last);
end; // TRemoteCommandList.Last

function TRemoteCommandList.Remove(ARemoteCommand: TRemoteCommand): integer;
begin
  Result := inherited Remove(ARemoteCommand);
end; // TRemoteCommandList.Remove


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// properties methods

// Items[index: integer]
function TRemoteCommandList.GetItems(AnIndex: integer): TRemoteCommand;
begin
  Result := TRemoteCommand(inherited Items[AnIndex]);
end; // TRemoteCommandList.GetItems

procedure TRemoteCommandList.SetItems(AnIndex: integer;
    ARemoteCommand: TRemoteCommand);
begin
  inherited Items[AnIndex] := ARemoteCommand;
end; // TRemoteCommandList.SetItems


end. ////////////////////////// end of file //////////////////////////////////
