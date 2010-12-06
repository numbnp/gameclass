//////////////////////////////////////////////////////////////////////////////
//
// Класс команды установки настроек клиентского приложения.
//
//////////////////////////////////////////////////////////////////////////////

unit uSetOptionsRemoteCommand;

interface

uses
  // project units
  uClientOptions,
  uRemoteCommand;


type

  //
  // TSetOptionsRemoteCommand
  //

  TSetOptionsRemoteCommand = class(TRemoteCommand)
  private
    // fields
    FstrOptionName: String;
    FstrOptionValue: String;

    // private helper methods
    function _OptionNameIs(const AstrOptionName: String): Boolean;

  public
    // constructor / destructor
    constructor Create(const AstrOptionName: String;
        const AstrOptionValue: String);

    // public methods
    procedure Execute(); override;

  end; // TSetOptionsRemoteCommand


implementation

uses
  // system units
  SysUtils,
  // project units
  uY2KCommon,
  uProtocol, uDebugLog;


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// TSetOptionsRemoteCommand.Create

constructor TSetOptionsRemoteCommand.Create(const AstrOptionName: String;
    const AstrOptionValue: String);
begin
  inherited Create();

  FstrOptionName := AstrOptionName;
  FstrOptionValue := AstrOptionValue;

end; // TSetOptionsRemoteCommand.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TSetOptionsRemoteCommand.Execute();
begin
 { if _OptionNameIs(STR_CMD_OPT_DOSESSIONWITHOUTSERVER) then begin
    GClientOptions.DoSessionWithoutServer := StrToBool(FstrOptionValue);

  end else if _OptionNameIs(STR_CMD_OPT_COMPNUMBER) then begin
    GClientOptions.CompNumber := FstrOptionValue;

  end else if _OptionNameIs(STR_CMD_OPT_COMPSTOPMESS) then begin
    GClientOptions.CompStopMessage := FstrOptionValue;

  end else if _OptionNameIs(STR_CMD_OPT_COMPFREEMESS) then begin
    GClientOptions.CompFreeMessage := FstrOptionValue;

  end else if _OptionNameIs(STR_CMD_OPT_DEFAULTBLOCK) then begin
    GClientOptions.DefaultBlock := StrToBool(FstrOptionValue);

  end else if _OptionNameIs(STR_CMD_OPT_AUTOBLOCK) then begin
    GClientOptions.AutoBlock := StrToBool(FstrOptionValue);

  end else if _OptionNameIs(STR_CMD_OPT_AUTOBLOCKMINS) then begin
    GClientOptions.AutoBlockMinuts := StrToIntDef(FstrOptionValue, 10);

  end else if _OptionNameIs(STR_CMD_OPT_AUTOBLOCKNONORDER) then begin
    GClientOptions.AutoBlockNonOrder := StrToBool(FstrOptionValue);

  end else if _OptionNameIs(STR_CMD_OPT_AUTOBLOCKNONORDERSEC) then begin
    GClientOptions.AutoBlockNonOrderSec := StrToIntDef(FstrOptionValue, 30);

  end else if _OptionNameIs(STR_CMD_OPT_USESOUNDS) then begin
    GClientOptions.UseSounds := StrToBool(FstrOptionValue);

  end else if _OptionNameIs(STR_CMD_OPT_STIMESTOP) then begin
    GClientOptions.IndependentlyStop := StrToBool(FstrOptionValue);

  end else if _OptionNameIs(STR_CMD_OPT_TIMESTOP) then begin
    GClientOptions.StopTime := StrToTimeDef(FstrOptionValue, 0);

  end else if _OptionNameIs(STR_CMD_OPT_ALLOWCARDSSUPPORT) then begin
    GClientOptions.AllowCardsSupport := StrToBool(FstrOptionValue);

  end else if _OptionNameIs(STR_CMD_OPT_AUTORESTARTWHENSTOP) then begin
    GClientOptions.AutoRestartWhenStop := StrToBool(FstrOptionValue);

  end else if _OptionNameIs(STR_CMD_OPT_AUTORESTARTWHENSTOPSEC) then begin
    GClientOptions.AutoRestartWhenStopSec := StrToIntDef(FstrOptionValue, 60);

  end else if _OptionNameIs(STR_CMD_OPT_STARTMONEYMINIMUM) then begin
    GClientOptions.StartMoneyMinimum := StrToFloat(FstrOptionValue);

  end else if _OptionNameIs(STR_CMD_OPT_DEFAULTSTARTBLOCK) then begin
    GClientOptions.DefaultStartBlock := StrToBool(FstrOptionValue);

  end else if _OptionNameIs(STR_CMD_OPT_FIRSTTIMEBLOCK) then begin
    GClientOptions.FirstTimeBlock := StrToBool(FstrOptionValue);

  end else if _OptionNameIs(STR_CMD_OPT_FIRSTTIMEBLOCKSEC) then begin
    GClientOptions.FirstTimeBlockSeconds := StrToIntDef(FstrOptionValue, 30);

 // end else if _OptionNameIs(STR_CMD_OPT_)  
  end else begin
    //STUB();

  end;
   }
  GClientOptions.Save();

end; // TSetOptionsRemoteCommand.Execute


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private helpers methods

function TSetOptionsRemoteCommand._OptionNameIs(
    const AstrOptionName: String): Boolean;
begin
  Result := CompareText(FstrOptionName, AstrOptionName) = 0;
end; // TSetOptionsRemoteCommand._OptionNameIs


end. ////////////////////////// end of file //////////////////////////////////
