//////////////////////////////////////////////////////////////////////////////
//
// Класс команды запроса информации клиентского приложения.
//
//////////////////////////////////////////////////////////////////////////////

unit uClientInfoGetRemoteCommand;

interface

uses
  // project units
  uClientInfo,
  uRemoteCommand;


type

  //
  // TClientInfoGetRemoteCommand
  //

  TClientInfoGetRemoteCommand = class(TRemoteCommand)
  private
    // fields
    FbLocalResend: Boolean; //локальная пересылка
    FstrHostForResend: String;
    FstrClientInfoName: String;

    // private helper methods
    procedure _SendClientInfo(const AstrClientInfoName: String;
        const AstrClientInfoValue: String);

  public
    // constructor / destructor
    // локальная отсылка опций
    constructor Create(const AstrClientInfoName: String); overload;
    // отсылка опций на клиент
    constructor Create(const AstrClientInfoName: String;
        const AstrHostForResend: String); overload;

    // public methods
    procedure Execute(); override;

  end; // TClientInfoGetRemoteCommand


implementation

uses
  // system units
  SysUtils,
  // project units
  uY2KCommon,
  uProtocol,
  uDebugLog,
  uLocalCommandSender,
  uCommandSender;


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// TClientInfoGetRemoteCommand.Create

constructor TClientInfoGetRemoteCommand.Create(const AstrClientInfoName: String);
begin
  inherited Create();

  FbLocalResend := True;
  FstrClientInfoName := AstrClientInfoName;

end; // TClientInfoGetRemoteCommand.Create

constructor TClientInfoGetRemoteCommand.Create(const AstrClientInfoName: String;
    const AstrHostForResend: String);
begin
  inherited Create();

  FbLocalResend := False;
  FstrHostForResend := AstrHostForResend;
  FstrClientInfoName := AstrClientInfoName;

end; // TClientInfoGetRemoteCommand.Create

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TClientInfoGetRemoteCommand.Execute();
var
  bAll: Boolean;
begin
  bAll := False;
  if CompareText(FstrClientInfoName,'All') = 0 then
    bAll := True;

  if bAll or (CompareText(FstrClientInfoName,'Blocked') = 0) then begin
    _SendClientInfo('Blocked', BoolToStr(GClientInfo.Blocked));
  end;

  if bAll or (CompareText(FstrClientInfoName,'ClientState') = 0) then
   { case GClientInfo.ClientState of
      ClientState_Blocked: _SendClientInfo('ClientState', '0');
      ClientState_Authentication: _SendClientInfo('ClientState', '1');
      ClientState_Order: _SendClientInfo('ClientState', '2');
      ClientState_Session: _SendClientInfo('ClientState', '3');
      ClientState_Agreement: _SendClientInfo('ClientState', '4');
      ClientState_OperatorSession: _SendClientInfo('ClientState', '5');
      ClientState_OperatorAgreement: _SendClientInfo('ClientState', '6');
      ClientState_OperatorAgreementAccepted: _SendClientInfo('ClientState',
          '7');
      ClientState_AgreementAccepted: _SendClientInfo('ClientState', '8');
    end;}
    _SendClientInfo('ClientState', IntToStr(Integer(GClientInfo.ClientState)));


  if bAll or (CompareText(FstrClientInfoName,'Login') = 0) then begin
    _SendClientInfo('Login', GClientInfo.Login);
  end;

  if bAll or (CompareText(FstrClientInfoName,'Balance') = 0) then
    _SendClientInfo('Balance', FloatToStr(GClientInfo.Balance));

  if bAll or (CompareText(FstrClientInfoName,'Spent') = 0) then
    _SendClientInfo('Spent', FloatToStr(GClientInfo.Spent));

  if bAll or (CompareText(FstrClientInfoName,'BalanceLimit') = 0) then
    _SendClientInfo('BalanceLimit', FloatToStr(GClientInfo.BalanceLimit));

  if bAll or (CompareText(FstrClientInfoName,'BalanceHistory') = 0) then
    _SendClientInfo('BalanceHistory', GClientInfo.BalanceHistory);

  if bAll or (CompareText(FstrClientInfoName,'Info') = 0) then
    _SendClientInfo('Info', GClientInfo.Info);

  if bAll or (CompareText(FstrClientInfoName,'FullInfo') = 0) then
    _SendClientInfo('FullInfo', GClientInfo.FullInfo);

  if bAll or (CompareText(FstrClientInfoName,'Start') = 0) then
    _SendClientInfo('Start', DateTimeToStr(GClientInfo.Start));

  if bAll or (CompareText(FstrClientInfoName,'Stop') = 0) then
    _SendClientInfo('Stop', DateTimeToStr(GClientInfo.Stop));

  if bAll or (CompareText(FstrClientInfoName,'TarifName') = 0) then
    _SendClientInfo('TarifName', GClientInfo.TarifName);

  if bAll or (CompareText(FstrClientInfoName,'TrafficSeparatePayment') = 0) then
    _SendClientInfo('TrafficSeparatePayment',
      BoolToStr(GClientInfo.TrafficSeparatePayment));

  if bAll or (CompareText(FstrClientInfoName,'SecCode') = 0) then
    _SendClientInfo('SecCode', IntToStr(GClientInfo.SecCode));

  //Это наверное не надо
//  if bAll or (CompareText(FstrClientInfoName,'UnblockedByPassword') = 0) then
//    _SendClientInfo('UnblockedByPassword',
//        BoolToStr(GClientInfo.UnblockedByPassword));

  if bAll or (CompareText(FstrClientInfoName,'Internet') = 0) then
    _SendClientInfo('Internet', BoolToStr(GClientInfo.Internet));

  if bAll or (CompareText(FstrClientInfoName,'InternetAvailableInKB') = 0) then
    _SendClientInfo('InternetAvailableInKB',
        IntToStr(GClientInfo.InternetAvailableInKB));

  if bAll or (CompareText(FstrClientInfoName,'InternetUsedInKB') = 0) then
    _SendClientInfo('InternetUsedInKB', IntToStr(GClientInfo.InternetUsedInKB));

  if bAll or (CompareText(FstrClientInfoName,'RunPadHidedTabs') = 0) then
    _SendClientInfo('RunPadHidedTabs', GClientInfo.RunPadHidedTabs.Text);

end; // TClientInfoGetRemoteCommand.Execute


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private helpers methods

procedure TClientInfoGetRemoteCommand._SendClientInfo(const AstrClientInfoName: String;
    const AstrClientInfoValue: String);
begin
  if FbLocalResend then begin
{$IFDEF MSWINDOWS}
    LocalSendDataTo(STR_CMD_CLIENT_INFO_SET + '=' + AstrClientInfoName + '/'
      + AstrClientInfoValue)
{$ENDIF}
  end else
    SendDataTo(FstrHostForResend, STR_CMD_CLIENT_INFO_SET + '='
      + AstrClientInfoName + '/' + AstrClientInfoValue, False)
end; // TClientInfoGetRemoteCommand._ClientInfoNameIs


end. ////////////////////////// end of file //////////////////////////////////
