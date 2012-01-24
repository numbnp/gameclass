unit uClientScripting;

interface

type
  TClientAction = (
      caServiceStart    = 0,
      caServiceStop     = 1,
      caClientStart     = 2,
      caClientStop      = 3,
      caBlocking        = 4,
      caUnblocking      = 5,
      caEnableInternet   = 6,
      caDisableInternet  = 7,
      caAfterStopAction = 8,
      caDisconnect      = 9,
      caNMinutesLeft    = 10,
      caStateChanged    = 11,
      caTarifChanged    = 12,
      caTaskKill        = 13
  );

  procedure RunClientScript(const AClientAction: TClientAction);

implementation

uses
{$IFDEF MSWINDOWS}
  Windows,
  ShellAPI,
{$ENDIF}
  Types,
  Math,
  SysUtils,
  uClientOptions,
  uClientOptionsConst,
  uClientInfo,
  uDebugLog,
  uFilesSynchronizeConst,
  uCrossPlatformFunctions;

procedure RunClientScript(const AClientAction: TClientAction);
var
  strParameters: String;
  strDateTime: String;
begin
  if GClientOptions.ClientScript then begin
    DateTimeToString(strDateTime,'dd.mm.yy-hh:mm:ss', Now);
    case AClientAction of
      caServiceStart: strParameters := 'ServiceStart ' + strDateTime;
      caServiceStop: strParameters := 'ServiceStop ' + strDateTime;
      caClientStart: strParameters := 'ClientStart ' + strDateTime;
      caClientStop: strParameters := 'ClientStop ' + strDateTime;
      caBlocking: strParameters := 'Blocking ' + strDateTime;
      caUnblocking: strParameters := 'Unblocking ' + strDateTime;
      caEnableInternet: begin
        strParameters := 'EnableInternet ' + strDateTime + ' '
            + GClientInfo.IPAddress;
      end;
      caDisableInternet: begin
        strParameters := 'DisableInternet ' + strDateTime + ' '
            + GClientInfo.IPAddress;
      end;
      caAfterStopAction: begin
        strParameters := 'AfterStopAction ' + strDateTime + ' ';
        case GClientOptions.AfterStopType of
          AfterStopType_KillTask: strParameters := strParameters + 'KillTask';
          AfterStopType_Logoff: strParameters := strParameters + 'Logoff';
          AfterStopType_Restart: strParameters := strParameters + 'Restart';
          AfterStopType_Shutdown: strParameters := strParameters + 'Shutdown';
        end;
      end;
      caDisconnect: strParameters := 'Disconnect ' + strDateTime;
      caNMinutesLeft: strParameters := 'NMinutLeft ' + strDateTime + ' '
          + IntToStr(GClientOptions.UseTextMessageMin);
      caStateChanged: strParameters := 'StateChanged ' + strDateTime + ' '
          + IntToStr(Integer(GClientInfo.ClientState));
      caTarifChanged: strParameters := 'TarifChanged ' + strDateTime + ' '
          + GClientInfo.TarifName;
      caTaskKill: strParameters := 'TaskKill ' + strDateTime;
    end;
{$IFDEF MSWINDOWS}
    ShellExecute(0,Nil,PChar(ExtractFilePath(ParamStr(0))
        + FILE_RECEIVE_DIR_DEF + '\'
        + GClientOptions.ClientScriptFileName),
        PCHar(strParameters),Nil,
        IfThen(GClientOptions.ClientScriptHideWindow,SW_HIDE,SW_NORMAL));
{$ENDIF}
{$IFDEF LINUX}
{    ShellExecute(0,Nil,PChar(ExtractFilePath(ParamStr(0))
        + FILE_RECEIVE_DIR_DEF + '\'
        + GClientOptions.ClientScriptFileName),
        PCHar(strParameters),Nil,
        IfThen(GClientOptions.ClientScriptHideWindow,SW_HIDE,SW_NORMAL));
}
      ExecuteCommandLine('./' + FILE_RECEIVE_DIR_DEF + '/'
        + GClientOptions.ClientScriptFileName + ' ' + strParameters);
{$ENDIF}
  end;
end;


end.
