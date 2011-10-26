//////////////////////////////////////////////////////////////////////////////
//
// Класс команды установки информации клиентского приложения.
//
//////////////////////////////////////////////////////////////////////////////

unit uClientInfoSetRemoteCommand;

interface

uses
  // project units
  uClientInfo,
  uRemoteCommand;


type

  //
  // TClientInfoSetRemoteCommand
  //

  TClientInfoSetRemoteCommand = class(TRemoteCommand)
  private
    // fields
    FstrOptionName: String;
    FstrOptionValue: String;

  public
    // constructor / destructor
    constructor Create(const AstrOptionName: String;
        const AstrOptionValue: String);

    // public methods
    procedure Execute(); override;

  end; // TClientInfoSetRemoteCommand


implementation

uses
  // system units
  SysUtils,
  // project units
  uY2KCommon,
  uClientInfoConst,
  uProtocol,
  uDebugLog,
  uY2KString,
  uClientConst;


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// TClientInfoSetRemoteCommand.Create

constructor TClientInfoSetRemoteCommand.Create(const AstrOptionName: String;
    const AstrOptionValue: String);
begin
  inherited Create();

  FstrOptionName := AstrOptionName;
  FstrOptionValue := AstrOptionValue;

end; // TClientInfoSetRemoteCommand.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TClientInfoSetRemoteCommand.Execute();
begin
try
  if CompareText(FstrOptionName,'Blocked') = 0 then begin
    GClientInfo.Blocked:= StrToBool(FstrOptionValue);

  end else if CompareText(FstrOptionName,'ClientState') = 0 then begin
    GClientInfo.ClientState := TClientState(StrToInt(FstrOptionValue));

  end else if CompareText(FstrOptionName,'Login') = 0 then begin
    GClientInfo.Login:= FstrOptionValue;

  end else if CompareText(FstrOptionName,'Balance') = 0 then begin
    GClientInfo.Balance:= StrToFloatDefWithReplace(FstrOptionValue,
        FIRST_DATE);

  end else if CompareText(FstrOptionName,'BalanceLimit') = 0 then begin
    GClientInfo.BalanceLimit:= StrToFloatDefWithReplace(FstrOptionValue,
        FIRST_DATE);

  end else if CompareText(FstrOptionName,'BalanceHistory') = 0 then begin
    GClientInfo.BalanceHistory:= FstrOptionValue;

  end else if CompareText(FstrOptionName,'Info') = 0 then begin
    GClientInfo.Info:= FstrOptionValue;

  end else if CompareText(FstrOptionName,'FullInfo') = 0 then begin
    GClientInfo.FullInfo:= FstrOptionValue;

  end else if CompareText(FstrOptionName,'Sum') = 0 then begin
    Debug.Trace5('UGClientInfo.Sum:= StrToDateTimeDefWithReplace beg ');
    GClientInfo.Sum:= StrToFloatDefWithReplace(FstrOptionValue);
    Debug.Trace5('UGClientInfo.Sum:= StrToDateTimeDefWithReplace end ' + FstrOptionValue);

  end else if CompareText(FstrOptionName,'Start') = 0 then begin
    GClientInfo.Start:= StrToDateTimeDefWithReplace(FstrOptionValue);

  end else if CompareText(FstrOptionName,'Now') = 0 then begin
    GClientInfo.NowTime:= StrToDateTimeDefWithReplace(FstrOptionValue);


  end else if CompareText(FstrOptionName,'Stop') = 0 then begin
    GClientInfo.Stop:= StrToDateTimeDefWithReplace(FstrOptionValue);

  end else if CompareText(FstrOptionName,'TarifName') = 0 then begin
    GClientInfo.TarifName:= FstrOptionValue;

  end else if CompareText(FstrOptionName,
    'TrafficSeparatePayment') = 0 then begin
    GClientInfo.TrafficSeparatePayment:= StrToBool(FstrOptionValue);

  end else if CompareText(FstrOptionName,'SecCode') = 0 then begin
    GClientInfo.SecCode:= StrToInt(FstrOptionValue);

  end else if CompareText(FstrOptionName,'UnblockedByPassword') = 0 then begin
    GClientInfo.UnblockedByPassword:= StrToBool(FstrOptionValue);

  end else if CompareText(FstrOptionName,'Internet') = 0 then begin
    GClientInfo.Internet:= StrToBool(FstrOptionValue);

  end else if CompareText(FstrOptionName,'InternetAvailableInKB') = 0 then begin
    GClientInfo.InternetAvailableInKB:= StrToInt(FstrOptionValue);

  end else if CompareText(FstrOptionName,'InternetUsedInKB') = 0 then begin
    GClientInfo.InternetUsedInKB:= StrToInt(FstrOptionValue);

  end else if CompareText(FstrOptionName,'RunPadHidedTabs') = 0 then begin
    GClientInfo.SetRunPadHidedTabsAsText(FstrOptionValue);

  end else begin
  //  ASSERT(FALSE, 'ClientInfo Set error! Unknown info type.');
  end;

except
  on e: Exception do begin
    Debug.Trace0(
      'TClientInfoSetRemoteCommand.Execute error! ' + e.Message);
  end;
end;
end; // TClientInfoSetRemoteCommand.Execute

end. ////////////////////////// end of file //////////////////////////////////
