unit uServerScripting;

interface

uses
  GCSessions;

type
  TSessionAction = (saStart=0, saStop=1, saChangeTarif=2);

  TServerAction = (
      aLogon        = 2,
      aLogoff       = 3,
      aCloseShift   = 4,
      aService      = 5,
      aMoneyRemoved = 6
  );

  procedure RunSessionScript(const ASessionAction: TSessionAction;
    const ASession: TGCSession);

  procedure RunServerScript(const AServerAction: TServerAction;
      const AstrInfo: String = '');

implementation

uses
  Windows,
  Math,
  ShellAPI,
  SysUtils,
  StrUtils,
  uRegistry, uRegistryScripts;

procedure RunSessionScript(const ASessionAction: TSessionAction;
    const ASession: TGCSession);
var
  strParameters: String;
//  strDateTime: String;
begin
  if GRegistry.Scripts.OnSession then begin
    case ASessionAction of
      saStart: strParameters := 'Start ';
      saStop: strParameters := 'Stop ';
      saChangeTarif: strParameters := 'ChangeTarif ';
    end;
//    DateTimeToString(strDateTime,'dd.mm.yy-hh:mm:ss',GetVirtualTime);
//    strParameters := strParameters + ' ' + strDateTime;
    strParameters := strParameters + ' ' + ASession.GetIPAddress;
    strParameters := strParameters + ' ' + ASession.ShortTarifName;
    strParameters := strParameters + ' "' + ASession.GetStrTarif + '"';
    strParameters := strParameters + ' "' + ASession.GetStrClient + '"';
    strParameters := strParameters + ' '
        + IfThen(ASession.IsInternet, 'Enabled', 'Disabled');
    ShellExecute(0,Nil,PChar(GRegistry.Scripts.OnSessionPath),
        PCHar(strParameters),Nil,
        IfThen(GRegistry.Scripts.OnSessionHideWindow,SW_HIDE,SW_NORMAL));
  end;
end;


procedure RunServerScript(const AServerAction: TServerAction;
    const AstrInfo: String = '');
var
  strParameters: String;
  strDateTime: String;
begin
  if (GRegistry <> nil) then
    if GRegistry.Scripts.OnServer then begin
      DateTimeToString(strDateTime,'dd.mm.yy-hh:mm:ss', Now);
      case AServerAction of
        aLogon: strParameters := 'Logon ' + strDateTime + ' ' + AstrInfo;
        aLogoff: strParameters := 'Logoff ' + strDateTime + ' ' + AstrInfo;
        aCloseShift: strParameters := 'CloseShift ' + strDateTime + ' '
            + AstrInfo;
        aService: strParameters := 'Service ' + strDateTime + ' ' + AstrInfo;
        aMoneyRemoved: strParameters := 'MoneyRemoved ' + strDateTime + ' '
            + AstrInfo;
      end;
      ShellExecute(0,Nil,PChar(GRegistry.Scripts.OnServerPath),
          PCHar(strParameters),Nil,
          IfThen(GRegistry.Scripts.OnServerHideWindow,SW_HIDE,SW_NORMAL));
    end;
end;


end.
