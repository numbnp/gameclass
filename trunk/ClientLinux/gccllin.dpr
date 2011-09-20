program gccllin;

uses
  Xlib,
  QForms,
  SysUtils,
  DateUtils,
  Types,
  gcconst in '../Server/gcconst.pas',
  uAnswerRemoteCommand in '../Parts/RemoteCommands/uAnswerRemoteCommand.pas',
  uBlockingsAndNotifications in '../Parts/Blocking/uBlockingsAndNotifications.pas',
  uBlockRemoteCommand in '../Parts/RemoteCommands/uBlockRemoteCommand.pas',
  uClientAuthenticationCommand in '../Parts/RemoteCommands/uClientAuthenticationCommand.pas',
  uClientConst in '../Client/uClientConst.pas',
  uClientDoDesignCommand in '../Parts/RemoteCommands/uClientDoDesignCommand.pas',
  uClientInfo in '../Parts/Options/uClientInfo.pas',
  uClientInfoConst in '../Parts/Options/uClientInfoConst.pas',
  uClientInfoConstrainedCommand in '../Parts/RemoteCommands/uClientInfoConstrainedCommand.pas',
  uClientInfoGetRemoteCommand in '../Parts/RemoteCommands/uClientInfoGetRemoteCommand.pas',
  uClientInfoSetRemoteCommand in '../Parts/RemoteCommands/uClientInfoSetRemoteCommand.pas',
  uClientOptions in '../Parts/Options/uClientOptions.pas',
  uClientOptionsConst in '../Parts/Options/uClientOptionsConst.pas',
  uClientOptionsIniStorage in '../Parts/Options/uClientOptionsIniStorage.pas',
  uClientOptionsStorage in '../Parts/Options/uClientOptionsStorage.pas',
  uClientRemoteCommandFactory in '../Parts/RemoteCommands/uClientRemoteCommandFactory.pas',
  uClientScripting in '../Parts/Scripting/uClientScripting.pas',
  uCloseClientRemoteCommand in '../Parts/RemoteCommands/uCloseClientRemoteCommand.pas',
  uCoder in '../Parts/Security/uCoder.pas',
  uCommandReceiver in '../Parts/SendRecieve/uCommandReceiver.pas',
  uCommandSender in '../Parts/SendRecieve/uCommandSender.pas',
  uCompositeRemoteCommand in '../Parts/RemoteCommands/uCompositeRemoteCommand.pas',
  uCrossPlatformBlocking in '../Parts/CrossPlatform/uCrossPlatformBlocking.pas',
  uCrossPlatformFunctions in '../Parts/CrossPlatform/uCrossPlatformFunctions.pas',
  uCrossPlatformWindow in '../Parts/CrossPlatform/uCrossPlatformWindow.pas',
  uCrossPlatformVKCodes in '../Parts/CrossPlatform/uCrossPlatformVKCodes.pas',
  uDebugLog in '../Parts/Debug/uDebugLog.pas',
  udmMain in '../Client/udmMain.pas' {dmMain: TDataModule},
  uFileReceiver in '../Parts/FileSend/uFileReceiver.pas',
  uFilesSynchronizeConst in '../Parts/FileSend/uFilesSynchronizeConst.pas',
  ufrmMain in '../Client/ufrmMain.pas' {frmMain},
  ufrmSmallInfo in '../Client/ufrmSmallInfo.pas' {frmSmallInfo},
  uGetExtendedInfoRemoteCommand in '../Parts/RemoteCommands/uGetExtendedInfoRemoteCommand.pas',
  uGetHardwareRemoteCommand in '../Parts/RemoteCommands/uGetHardwareRemoteCommand.pas',
  uGetTasksListRemoteCommand in '../Parts/RemoteCommands/uGetTasksListRemoteCommand.pas',
  uKillTaskRemoteCommand in '../Parts/RemoteCommands/uKillTaskRemoteCommand.pas',
  uLocal in '../Parts/Local/uLocal.pas',
  uLocalCommandReceiver in '../Parts/SendRecieve/uLocalCommandReceiver.pas',
  uLocalCommandSender in '../Parts/SendRecieve/uLocalCommandSender.pas',
  uLocalResendRemoteCommand in '../Parts/RemoteCommands/uLocalResendRemoteCommand.pas',
  uLogoffRemoteCommand in '../Parts/RemoteCommands/uLogoffRemoteCommand.pas',
  uNullRemoteCommand in '../Parts/RemoteCommands/uNullRemoteCommand.pas',
  uOptionGetRemoteCommand in '../Parts/RemoteCommands/uOptionGetRemoteCommand.pas',
  uOptionSetRemoteCommand in '../Parts/RemoteCommands/uOptionSetRemoteCommand.pas',
  uPingRemoteCommand in '../Parts/RemoteCommands/uPingRemoteCommand.pas',
  uPlaySoundRemoteCommand in '../Parts/RemoteCommands/uPlaySoundRemoteCommand.pas',
  uProtocol in '../Parts/Protocol/uProtocol.pas',
  uReceiveMessageRemoteCommand in '../Parts/RemoteCommands/uReceiveMessageRemoteCommand.pas',
  uRemoteCommand in '../Parts/RemoteCommands/uRemoteCommand.pas',
  uRemoteCommandFactory in '../Parts/RemoteCommands/uRemoteCommandFactory.pas',
  uRemoteCommandList in '../Parts/RemoteCommands/uRemoteCommandList.pas',
  uResendRemoteCommand in '../Parts/RemoteCommands/uResendRemoteCommand.pas',
  uRestartRemoteCommand in '../Parts/RemoteCommands/uRestartRemoteCommand.pas',
  uSafeStorage in '../Parts/SafeStorage/uSafeStorage.pas',
  uSendMessageRemoteCommand in '../Parts/RemoteCommands/uSendMessageRemoteCommand.pas',
  uServiceRemoteCommandFactory in '../Parts/RemoteCommands/uServiceRemoteCommandFactory.pas',
  uSetTimeRemoteCommand in '../Parts/RemoteCommands/uSetTimeRemoteCommand.pas',
  uSetVolumeRemoteCommand in '../Parts/RemoteCommands/uSetVolumeRemoteCommand.pas',
  uShutdownRemoteCommand in '../Parts/RemoteCommands/uShutdownRemoteCommand.pas',
  uTaskKillConst in '../Parts/TaskKill/uTaskKillConst.pas',
  uTaskKill in '../Parts/TaskKill/uTaskKill.pas',
  usrvGCCL in 'usrvGCCL.pas',
  uUninstallRemoteCommand in '../Parts/RemoteCommands/uUninstallRemoteCommand.pas',
  uY2KCommon in '../Parts/Y2KCommon/uY2KCommon.pas',
  uY2KString in '../Parts/Y2KCommon/uY2KString.pas',
  uFileInfo in '../Parts/FileTools/uFileInfo.pas';

{$R *.res}
var
  FhCheckingThread: THandle;
  nThreadId: cardinal;
//  bUnblockPassword: Boolean;
//  bUnblockedByPassword: Boolean;
//  dpy: PDisplay;
//  event: XEvent;

function CheckHotKey(Parameter: Pointer): Integer;
var
  dpy: PDisplay;
  event: XEvent;
begin
  try
    dpy := XOpenDisplay(Nil);
    XGrabKey (dpy,
        XKeysymToKeycode (dpy, XStringToKeysym ('I')),
        //ShiftMask or
        ControlMask or  Mod1Mask,
        XDefaultRootWindow(dpy),
        XFalse, GrabModeAsync, GrabModeAsync);
      while(True) do begin
        try
          XNextEvent(dpy, @event);
          if (event.xtype = XLib.KeyPress) then begin
            if (event.xkey.keycode = 31) then // 'I'
              TSafeStorage.Instance.Push(ThreadSafeOperation_MainFormAction,
                  Integer(FormAction_Show));
          end;
        except
        end;
        Sleep(100);
      end;
  except
    on e: Exception do begin
      Debug.Trace0('gccllin CheckHotKey error! ' + e.Message);
    end;
  end;
  Result := 0;
end; // CheckHotKey


begin
  Application.Initialize;
//  Debug.Level := 9;
  Debug.Level := 9;
  Debug.Trace0('gccllin started');
try
//  if CompareDate(Now, EncodeDate(2010, 1, 1)) = GreaterThanValue then begin
//    Application.MessageBox('Trial period has expired');
//  end else begin
  begin
    FhCheckingThread := BeginThread(nil, @CheckHotKey, Nil, nThreadId);
    Debug.Trace5('After CheckHotKey');
    GClientOptions.Load;
    if GClientOptions.RestoreClientInfo then
      GClientInfo.Load
    else
      GClientInfo.Init;
    Debug.Trace5('Before CreateForm TfrmMain');
    Application.CreateForm(TfrmMain, frmMain);
  Debug.Trace5('After CreateForm TfrmMain');
    Application.CreateForm(TfrmSmallInfo, frmSmallInfo);
    Application.ShowMainForm := False;
    Application.CreateForm(TdmMain, dmMain);
    Debug.Trace5('After CreateForm TdmMain');
    srvGCCL.ServiceStart;
    Debug.Trace5('After ServiceStart');
    frmMain.EnableSafeOperation;
    Debug.Trace5('After EnableSafeOperation');
{    // хак для отмены блокировки на долю секунды
    // для победы над потерей фокуса при старте
    bUnblockPassword :=  GClientOptions.UnblockPassword;
    bUnblockedByPassword := GClientInfo.UnblockedByPassword;
    GClientOptions.UnblockPassword := True;
    GClientInfo.UnblockedByPassword := True;
    Sleep(200);
    GClientOptions.UnblockPassword := bUnblockPassword;
    GClientInfo.UnblockedByPassword := bUnblockedByPassword;
    }
//    Sleep(1000);
    Application.Run;
    srvGCCL.ServiceStop;
  end;
except
  on e: Exception do begin
    Debug.Trace0('gccllin Error! ' + e.Message);
  end;
end;
  Debug.Trace0('gccllin stoped');
end.
