//////////////////////////////////////////////////////////////////////////////
//
// TBlockRemoteCommand
//  ласс блокировок, поступающих от управл€ющего сервера.
//
//////////////////////////////////////////////////////////////////////////////

unit uBlockRemoteCommand;

interface

uses
  // project units
  uRemoteCommand;

type

  //
  // TBlockRemoteCommand
  //

  TBlockRemoteCommand = class(TRemoteCommand)
  private
    // fields
    FstrParameters: String;

  public
    // constructor / destructor
    constructor Create(); overload;
    constructor Create(const AstrParameters: String); overload;

    // public methods
    procedure Execute(); override;

    // properties
    property Parameters: String read FstrParameters write FstrParameters;
  end; // TBlockRemoteCommand


implementation

uses
  // project units
  uDebugLog,
  uClientInfo;

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TBlockRemoteCommand.Create();
begin
  ASSERT(FALSE,
      'TBlockRemoteCommand.Create need AstrParameters parameter');
end; // TBlockRemoteCommand.Create

constructor TBlockRemoteCommand.Create(const AstrParameters: String);
begin
  inherited Create();
  FstrParameters := AstrParameters;
end; // TBlockRemoteCommand.Create



//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TBlockRemoteCommand.Execute();
begin
  if Length(FstrParameters)>0 then
    GClientInfo.Blocked := True
  else
    GClientInfo.Blocked := False;
end; // TBlockRemoteCommand.Execute

{
   end else if CompareText(FstrOptionName,'DefaultBlock') = 0 then begin
    GClientOptions.BlockKeyboard := (Pos('k',FstrOptionValue) <> 0);
    GClientOptions.BlockMouse := (Pos('m',FstrOptionValue) <> 0);
    GClientOptions.BlockTasks := (Pos('t',FstrOptionValue) <> 0);
    GClientOptions.BlockDisplay := (Pos('d',FstrOptionValue) <> 0);
----
  if bAll or (CompareText(FstrOptionName,'DefaultBlock') = 0) then begin
    strDefaultBlock := '';
    if GClientOptions.BlockKeyboard then
      strDefaultBlock := strDefaultBlock + 'k';
    if GClientOptions.BlockMouse then
      strDefaultBlock := strDefaultBlock + 'm';
    if GClientOptions.BlockTasks then
      strDefaultBlock := strDefaultBlock + 't';
    if GClientOptions.BlockDisplay then
      strDefaultBlock := strDefaultBlock + 'd';

}

end. ////////////////////////// end of file //////////////////////////////////

