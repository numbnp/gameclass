unit uRunPadTools;

interface

uses
  uRemoteCommand,
  uLogoffRemoteCommand,
  uKillTaskRemoteCommand,
  uClientInfo,
  uClientOptions,
  RS_APILib_TLB,
  uSafeStorage,
  SysUtils,
  uDebugLog,
  uY2KString;

  procedure RunPadAction(ARunPadAction: TRunPadAction;
      const AstrParameters: String = '');
implementation

var
  LocalRunPadHideTabs: string;

procedure  DoSingleAction_My(Param:Integer);
var
  rpShell : IRunpadShell;
   rpShell2 : IRunpadShell2;
   rpPro : IRunpadProShell;
begin
  try
    rpShell2 := CoRunpadShell2.Create;
    rpShell2.DoSingleAction(Param);
  except
    Debug.Trace0('DoSingleAction RPS failed');
  end;
  try
    rpPro := CoRunpadProShell.Create;
    rpPro.DoSingleAction(Param);
  except
    Debug.Trace0('DoSingleAction RPP failed');
  end;
end;


procedure RunPadAction(ARunPadAction: TRunPadAction;
    const AstrParameters: String = '');
var
   rpShell : IRunpadShell;
   rpShell2 : IRunpadShell2;
   rpPro : IRunpadProShell;
   i: Integer;
   cmd: TRemoteCommand;
begin
  try
    rpShell := CoRunpadShell.Create;
    case ARunPadAction of
      RunPadAction_HideTabs:
        try
//          rpShell2 := CoRunpadShell2.Create;
          if GClientOptions.RunPadHideTabs then begin
            if GClientInfo.RunPadHidedTabs.Text <> LocalRunPadHideTabs then begin
             LocalRunPadHideTabs := GClientInfo.RunPadHidedTabs.Text;
             for i := 0 to GClientOptions.RunPadTabs.Count-1 do
               if (GClientInfo.RunPadHidedTabs.IndexOf(
                    GClientOptions.RunPadTabs[i]) <> -1) then
                 rpShell.EnableSheets(PChar(GClientOptions.RunPadTabs[i]),0)
               else
               rpShell.EnableSheets(PChar(GClientOptions.RunPadTabs[i]),1);
            end;
          end;
        except
          Debug.Trace0('Hide tabs failed');
        end;
      RunPadAction_RestoreVideoMode:
        DoSingleAction_My(RSA_RESTOREVMODE);
      RunPadAction_EndVipSession:
        DoSingleAction_My(RSA_ENDVIPSESSION);
      RunPadAction_MonitorOn:
        DoSingleAction_My(RSA_TURNMONITORON);
      RunPadAction_MonitorOff:
        DoSingleAction_My(RSA_TURNMONITOROFF);
      RunPadAction_LockStation:
        DoSingleAction_My(RSA_RUNPROGRAMDISABLE);
      RunPadAction_UnlockStation:
        DoSingleAction_My(RSA_RUNPROGRAMENABLE);


      RunPadAction_KillTasks:
        if rpShell.DoSingleAction(RSA_KILLALLTASKS) <> S_OK then begin
          cmd := TKillTaskRemoteCommand.Create;
          cmd.Execute;
          cmd.Free;
        end;
      RunPadAction_Logoff:
        if rpShell.DoSingleAction(RSA_LOGOFFFORCE) <> S_OK then begin
          cmd := TLogoffRemoteCommand.Create;
          cmd.Execute;
          cmd.Free;
        end;
      RunPadAction_VipLogon:
        try
          rpShell2 := CoRunpadShell2.Create;
          rpShell2.VipLogin(
            PChar(GetParamFromString(AstrParameters, 0)),
            PChar(GetParamFromString(AstrParameters, 1)), 0);
        //  rpShell._Release;
        except
          Debug.Trace0('RP VIP Login failed');
        end;
      RunPadAction_VipLogout:
        try
          rpShell2 := CoRunpadShell2.Create;
          rpShell2.VipLogout(0);
     //   rpShell2._Release;
        except
          Debug.Trace0('RP VIP Logout failed');
        end;
      RunPadAction_ShowInfoOnDesktop:
        begin
          try
            rpShell2 := CoRunpadShell2.Create;
            rpShell2.ShowInfoMessage(PAnsiChar(AstrParameters),$00000002);
          except
            Debug.Trace0('Show info on desktop RPS failed');
          end;
          try
            rpPro := CoRunpadProShell.Create;
            rpPro.ShowInfoMessage(PAnsiChar(AstrParameters),$00000002);
          except
            Debug.Trace0('Show info on desktop RPP failed');
          end;
        end;
    end;
  //  rpShell._Release;
//    sh.RegisterClient('GameClass Client',PChar(ParamStr(0)),0);
  except
    on e: Exception do begin
      Debug.Trace0('_RunPadAction FAILED: ' + e.Message);
    end;
  end;
  {
        FormAction_HideTabs:
          if not frmSmallInfo.Visible then
            frmSmallInfo.Show;
        FormAction_EnableInternet:
          if frmSmallInfo.Visible then
            frmSmallInfo.Hide;
        FormAction_DisableInternet:
          with GClientInfo do
            frmSmallInfo.UpdateInfo(Start, Stop, Internet,
                InternetAvailableInKB, InternetUsedInKB);
  }
end;


end.
