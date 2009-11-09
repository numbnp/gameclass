//////////////////////////////////////////////////////////////////////////////
//
// TCompositeRemoteCommand
// Класс - контейнер для нескольких команд.
//
// Карамани Юрий - 05.2005
//
//////////////////////////////////////////////////////////////////////////////

unit uCompositeRemoteCommand;

interface

uses
  // project units
  uRemoteCommand,
  uRemoteCommandList;

type

  //
  // TCompositeRemoteCommand
  //

  TCompositeRemoteCommand = class(TRemoteCommand)
  private
    // fields
    FlstCommands : TRemoteCommandList;

  public
    // constructor / destructor
    constructor Create();
    destructor Destroy(); override;

    // public methods
    procedure Execute(); override;

    // properties
    property Commands: TRemoteCommandList
        read FlstCommands write FlstCommands;
        
  end; // TCompositeRemoteCommand


implementation

uses
  // project units
  uY2KCommon;


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TCompositeRemoteCommand.Create();
begin
  inherited Create();

  FlstCommands := TRemoteCommandList.Create();

end; // TCompositeRemoteCommand.Create

destructor TCompositeRemoteCommand.Destroy();
begin
  FreeAndNilWithAssert(FlstCommands);

  inherited Destroy();

end; // TCompositeRemoteCommand.Destroy


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TCompositeRemoteCommand.Execute();
var
  i: integer;
begin
  ASSERT(Assigned(FlstCommands));

  for i := 0 to FlstCommands.Count - 1 do
    FlstCommands[i].Execute();

end; // TCompositeRemoteCommand.Execute


end. ////////////////////////// end of file //////////////////////////////////
