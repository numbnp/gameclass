//////////////////////////////////////////////////////////////////////////////
//
// Класс слежения за процессами.
//
// Если заданный процесс отсутсвует в списке процессов,
// то этот процесс запускается заново.
//
//////////////////////////////////////////////////////////////////////////////

unit uBlockingsAndNotifications;
{$IFDEF LINUX}
  {$DEFINE GCCL}
  {$DEFINE GCCLSRV}
{$ENDIF}

interface

uses
  // system units
  Types;
  // project units

const
{$IFDEF MSWINDOWS}
  TIMEOUT_DEF = 30; // пауза в опросе блокировки
{$ENDIF}
{$IFDEF LINUX}
  TIMEOUT_DEF = 1000; // пауза в опросе блокировки
{$ENDIF}

type

  //
  // TBlockingsAndNotifications
  //

  TBlockingsAndNotifications = class(TObject)
  private
    // fields
    FhCheckingThread: THandle;
    FbIsSoundUsed: Boolean;
    FbIsBaloonsUsed: Boolean;
    FbIsTextMessageUsed: Boolean;
    FbWindowsMinimized: Boolean;
    FbDisplayBlocked: Boolean;
    FbIsNMinutesLeftRunScriptUsed: Boolean;

    // threads methods
    procedure _DoChecking();
    // функция перебора всех окон в системе

    // private helper methods

  public
    // constructor / destructor
    constructor Create();
    destructor Destroy(); override;

    // public methods
    procedure StartChecking();
    procedure StopChecking();

  end; // TBlockingsAndNotifications
var
   BlockingsAndNotifications: TBlockingsAndNotifications;
{$IFDEF MSWINDOWS}
   SysTimer:THandle;
{$ENDIF}

implementation

uses
  // system units
  SysUtils,
{$IFDEF MSWINDOWS}
  ShellApi,
  Dialogs,
  Activex,
  uShowTextInAllVideoModes,
  Windows,
{$ENDIF}
{$IFDEF LINUX}
  QDialogs,
  XLib,
{$ENDIF}
  // project units
{$IFDEF GCCL}
  ufrmMain,
  uCrossPlatformBlocking,
  {$IFDEF MSWINDOWS}
    Forms,
    Messages,
    uWinhkg,
    RS_APILib_TLB,
    frmTopMessage,
  {$ENDIF}
  {$IFDEF LINUX}
    QForms,
  {$ENDIF}
  uClientConst,
  uSafeStorage,
  uParseAndReplase,
{$ENDIF}
{$IFDEF GCCLSRV}
  uKillTaskRemoteCommand,
  uLogoffRemoteCommand,
  uRestartRemoteCommand,
  uShutdownRemoteCommand,
  uExecuteCommandRemoteCommand,
  uClientInfoGetRemoteCommand,
  uRemoteCommand,
  uClientScripting,
{$ENDIF}
  uDebugLog,
  uClientOptions,
  uClientOptionsConst,
  uClientInfo,
  uClientInfoConst,
  DateUtils,
  uCompositeRemoteCommand;

{$IFDEF MSWINDOWS}
procedure Timer_SysTimer;
begin
  GClientInfo.NowTime := GClientInfo.NowTime + OneSecond;
{$IFDEF GCCL}
  if GClientOptions.RunPadShowInfoOnDesktop then
    TSafeStorage.Instance().Push(ThreadSafeOperation_RunPadAction,
      Integer(RunPadAction_ShowInfoOnDesktop),
      ParseAndReplase(GClientOptions.RunPadShowInfoOnDesktopText));
{$ENDIF}
end;
{$ENDIF}

// метод используется для прерывания цикла ожидания событий
// см. описание API-функции QueueUserAPC
procedure ExitThreadAPC(AdwParam: DWORD); stdcall;
begin
//
end; // ExitThreadAPC


// по идее это должна быть метод класса, но при попытке запустить
// метод класса в отдельном потоке приложение подвисает
// в варианте с глобальной функцией все работате нормально
function DoChecking(Ap: TBlockingsAndNotifications): DWORD;
begin
  Ap._DoChecking();
  Result := 0;
end; // DoPrintersNotifies
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// TBlockingsAndNotifications

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TBlockingsAndNotifications.Create();
begin
  inherited Create();

  FhCheckingThread := 0;
  FbWindowsMinimized := False;
  FbDisplayBlocked := False;
  FbIsSoundUsed := False;
  FbIsBaloonsUsed := False;
  FbIsTextMessageUsed := False;
  FbIsNMinutesLeftRunScriptUsed := False;
end; // TBlockingsAndNotifications.Create


destructor TBlockingsAndNotifications.Destroy();
begin
  inherited Destroy();
end; // TBlockingsAndNotifications.Destroy


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TBlockingsAndNotifications.StartChecking();
var
  nThreadId: cardinal;
begin
{$IFDEF MSWINDOWS}
  SysTimer := SetTimer(0,0,1000, @Timer_SysTimer);
  FhCheckingThread := BeginThread(
      nil, 0, @DoChecking, Pointer(Self), 0, nThreadId);
  ASSERT(FhCheckingThread <> INVALID_HANDLE_VALUE);
{$ENDIF}
{$IFDEF LINUX}
  FhCheckingThread := BeginThread(
      nil, @DoChecking, Pointer(Self), nThreadId);
{$ENDIF}


end; // TBlockingsAndNotifications.StartThreads


procedure TBlockingsAndNotifications.StopChecking();
begin
{$IFDEF MSWINDOWS}
  KillTimer(0,SysTimer);
  if (FhCheckingThread <> INVALID_HANDLE_VALUE)
      and (FhCheckingThread <> 0) then begin
    QueueUserAPC(@ExitThreadAPC, FhCheckingThread, 0);
    Debug.Trace5('wait...');
    WaitForSingleObject(FhCheckingThread, INFINITE);
    Debug.Trace5('wait complete!');
    CloseHandle(FhCheckingThread);
  end;
{$ENDIF}
{$IFDEF LINUX}
{$ENDIF}
end; // TBlockingsAndNotifications.StopThreads

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// threads methods

procedure TBlockingsAndNotifications._DoChecking();
var
  dwWaitStatus: DWORD;
  bBlocked: Boolean;
{$IFDEF GCCLSRV}
  cmd: TRemoteCommand;
  dt: TDateTime;
  bAfterStopActionneededSave: Boolean;
  i: Integer;
{$ENDIF}
begin
  while(TRUE) do begin
  try
//if(False) then begin
{$IFDEF GCCLSRV}
    GClientInfo.Disconnected := GClientInfo.IsDisconnected;
//      GClientInfo.SaveIfNeeded;
    if GClientOptions.OfflineBlock
        and GClientInfo.IsDisconnected
        and not GClientInfo.IsFirstRun then begin
      case GClientOptions.OfflineBlockType of
        OfflineBlockType_Immediately :begin
          GClientInfo.Blocked := (GClientInfo.NowTime >= IncMinute(GClientInfo.LastPingTime,
              GClientOptions.OfflineBlockTypeImmediatelyMin));
        end;

        OfflineBlockType_AfterSessionStop :begin
          GClientInfo.Blocked := (not GClientInfo.IsSession)
              or (GClientInfo.NowTime >= GClientInfo.Stop);
        end;
      end;

      if (not GClientInfo.IsSession) or (GClientInfo.NowTime >= GClientInfo.Stop) then begin
        if (GClientInfo.ClientState <> ClientState_Blocked) then begin
          dt := GClientInfo.Stop;
          bAfterStopActionneededSave := GClientInfo.AfterStopActionNeeded;
          GClientInfo.Clear(True);
          GClientInfo.Stop := dt;
          GClientInfo.AfterStopActionNeeded := bAfterStopActionneededSave;
          cmd := TClientInfoGetRemoteCommand.Create('Blocked');
          cmd.Execute;
          cmd.Free;
          cmd := TClientInfoGetRemoteCommand.Create('ClientState');
          cmd.Execute;
          cmd.Free;
        end;
      end;
    end;

    if GClientOptions.AfterStop
        and GClientInfo.AfterStopActionNeeded then begin
      if (GClientInfo.NowTime >= IncSecond(GClientInfo.Stop, GClientOptions.AfterStopSec))
          then begin
        GClientInfo.Stop := DEF_STOP;
        case GClientOptions.AfterStopType of
          AfterStopType_KillTask :
            cmd := TKillTaskRemoteCommand.Create;
          AfterStopType_Logoff :
            cmd := TLogoffRemoteCommand.Create;
          AfterStopType_Restart :
            cmd := TRestartRemoteCommand.Create;
          AfterStopType_Shutdown :
            cmd := TShutdownRemoteCommand.Create;
        end;
        GClientInfo.AfterStopActionNeeded := False;
        GClientInfo.SaveIfNeeded;
        RunClientScript(caAfterStopAction);
        cmd.Execute;
        cmd.Free;
      end;
    end;

    if GClientOptions.StartBlock
        and GClientInfo.IsNotConnected
        and not GClientInfo.IsFirstRun then begin
      if (GClientOptions.StartBlockSec = 0) then
//        GClientInfo.Blocked := True
        GClientInfo.Blocked := not GClientOptions.RestoreClientInfo
            or (GClientInfo.Stop < GClientInfo.NowTime)
      else
        GClientInfo.Blocked := (GClientInfo.NowTime <= IncSecond(GClientInfo.LastPingTime,
              GClientOptions.StartBlockSec));
    end;
{$ENDIF}
    bBlocked := GClientInfo.ResultBlocking;
{$IFDEF LINUX}
    // иначе пропадает курсор
    bBlocked := bBlocked and frmMain.AfterFirstFormShow;
{$ENDIF}
{$IFDEF GCCL}
    Block(bBlocked);
{$ENDIF}
{$IFDEF GCCLSRV}
    if GClientOptions.UseSounds
        and ((GClientInfo.ClientState = ClientState_Session)
          or (GClientInfo.ClientState = ClientState_OperatorSession))
        and (MinutesBetween(GClientInfo.Start,GClientInfo.Stop) > 5) then begin
      if (GClientInfo.NowTime >= IncMinute(GClientInfo.Stop,-5{GClientOptions.UseTextMessageMin}))
          then begin
        if (GClientInfo.NowTime < GClientInfo.Stop) and not FbIsSoundUsed then begin
          FbIsSoundUsed := True;
          //Play Sound
          //Пока ничего не проигрываем - сервер играет в принудиловку
        end;
      end else
        FbIsSoundUsed := False;
    end;
{$ENDIF}
{$IFDEF GCCL}
    if GClientOptions.UseBaloons
        and ((GClientInfo.ClientState = ClientState_Session)
          or (GClientInfo.ClientState = ClientState_OperatorSession))
        and (MinutesBetween(GClientInfo.Start,IncSecond(GClientInfo.Stop))
        > GClientOptions.UseTextMessageMin) then begin
      if (GClientInfo.NowTime >= IncMinute(GClientInfo.Stop,-5{GClientOptions.UseTextMessageMin}))
          then begin
        if (GClientInfo.NowTime < GClientInfo.Stop) and not FbIsBaloonsUsed then begin
          FbIsBaloonsUsed := True;
          //Show Baloons
  {$IFDEF MSWINDOWS}
          frmMain.modernTrayIcon.ShowBalloonHint('Предупреждение',
              'Через 5 минут Ваше время истекает!');
  {$ENDIF}
  {$IFDEF LINUX}
    cmd := TExecuteCommandRemoteCommand.Create('./scripts/warn5');
    cmd.Execute;
    cmd.Free;
  {$ENDIF}
        end;
      end else
        FbIsBaloonsUsed := False;
    end;
    if GClientOptions.UseTextMessage
        and ((GClientInfo.ClientState = ClientState_Session)
          or (GClientInfo.ClientState = ClientState_OperatorSession)) then begin
      if  (HourOf(GClientInfo.Stop-GClientInfo.NowTime) = 0) and
        (MinuteOf(GClientInfo.Stop-GClientInfo.NowTime)<GClientOptions.UseTextMessageMin) then
      begin
        if (not FbIsTextMessageUsed) then begin
          FbIsTextMessageUsed := True;
{$IFDEF MSWINDOWS}
          ShowTopMessage('У Вас осталось '
            + IntToStr(GClientOptions.UseTextMessageMin)
            + ' минут.',5);
{$ENDIF}
{$IFDEF LINUX}
          //Show TextMessage
{$ENDIF}
        end;
      end else
        FbIsTextMessageUsed := False;
    end;

{$ENDIF}
{$IFDEF GCCLSRV}
    if GClientOptions.UseTextMessage
        and ((GClientInfo.ClientState = ClientState_Session)
          or (GClientInfo.ClientState = ClientState_OperatorSession))
        and (MinutesBetween(GClientInfo.Start,IncSecond(GClientInfo.Stop))
        > GClientOptions.UseTextMessageMin) then begin
      if (GClientInfo.NowTime >= IncMinute(GClientInfo.Stop,-GClientOptions.UseTextMessageMin))
          then begin
        if (GClientInfo.NowTime < GClientInfo.Stop) and not FbIsTextMessageUsed then begin
          FbIsTextMessageUsed := True;
{$IFDEF MSWINDOWS}
          {//Show TextMessage
          if GClientOptions.UseTextMessageBlinking then
            ShowTextInAllVideoModesBlinking(
                'Через ' + IntToStr(GClientOptions.UseTextMessageMin)
                + ' минут Ваше время истекает!'+Chr(13)+Chr(10)
                + 'Компьютер будет заблокирован! '+Chr(13)+Chr(10),3)
          else
            ShowTextInAllVideoModesSwitchDesktops(
                'Через ' + IntToStr(GClientOptions.UseTextMessageMin)
                + ' минут Ваше время истекает!'+Chr(13)+Chr(10)
                + 'Компьютер будет заблокирован! '+Chr(13)+Chr(10),3);}
{$ENDIF}
{$IFDEF LINUX}
          //Show TextMessage
{$ENDIF}
        end;
      end else
        FbIsTextMessageUsed := False;
    end;
    // RunScript caNMinutLeft
    if ((GClientInfo.ClientState = ClientState_Session)
        or (GClientInfo.ClientState = ClientState_OperatorSession))
        and (MinutesBetween(GClientInfo.Start,IncSecond(GClientInfo.Stop))
        > GClientOptions.UseTextMessageMin) then begin
      if (GClientInfo.NowTime >= IncMinute(GClientInfo.Stop,-GClientOptions.UseTextMessageMin))
          then begin
        if (GClientInfo.NowTime < GClientInfo.Stop)
            and not FbIsNMinutesLeftRunScriptUsed then begin
          FbIsNMinutesLeftRunScriptUsed := True;
          RunClientScript(caNMinutesLeft);
        end;
      end else
        FbIsNMinutesLeftRunScriptUsed := False;
    end;
{$ENDIF}
//end;
  except
    on e: Exception do begin
      Debug.Trace0('_DoChecking Error! ' + e.Message);
    end;
  end;
{$IFDEF MSWINDOWS}
    dwWaitStatus := SleepEx(TIMEOUT_DEF, TRUE);
    if (WAIT_IO_COMPLETION = dwWaitStatus) then begin
      break;
    end;
{$ENDIF}
{$IFDEF LINUX}
  Sleep(TIMEOUT_DEF)
{    dwWaitStatus := SleepEx(TIMEOUT_DEF, TRUE);
    if (WAIT_IO_COMPLETION = dwWaitStatus) then begin
      break;
    end;
}
{$ENDIF}
  end;
end; // TBlockingsAndNotifications._DoChecking



end.
