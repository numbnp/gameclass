unit usrvSync;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, SvcMgr, Dialogs;

type
  TsrvSync = class(TService)
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
  private
    { Private declarations }
  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

var
  srvSync: TsrvSync;

implementation

{$R *.DFM}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  srvSync.Controller(CtrlCode);
end;

function TsrvSync.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TsrvSync.ServiceStart(Sender: TService; var Started: Boolean);
begin
  FbFirstReceive := True;;
  Debug.Trace0('GCTI service started.');
  Options.Load;
  Debug.Level := IfThen(Options.Genaral.DebugLog.Value, 9, 0);
  Debug.Trace5('GCTI service Options.Load.');
  IPInformations.SerializedString := Options.Genaral.SerializedString.Value;
  Debug.Trace5('GCTI service IPInformation loaded from Options');
  TI := TTICommonInterface.Create(Options.Genaral.DecriptedPassword);
  Debug.Trace5('GCTI service TTICommonInterface created');
  _CreateAndInitCommandFactory();
  Debug.Trace5('GCTI service _CreateAndInitCommandFactory.');
  TIGetMissingInfo;
  Debug.Trace5('GCTI service TIGetMissingInfo.');
  TICreateMissingUsers;
  Debug.Trace5('GCTI service TICreateMissingUsers.');
  TIClearCounters;
  Debug.Trace5('GCTI service TIClearCounters.');
  if Options.Genaral.StoppingByStart.Value then begin
    Debug.Trace5('GCTI service before StoppingByStart');
    TIStopUsers(Options.Genaral.StoppingByStartMode.Value
        = Ord(StoppingModeOnlyGC));
    Debug.Trace5('GCTI service StoppingByStart');
  end;
  TI.Free;
  _CreateAndInitCommandReceiver();
  Debug.Trace5('GCTI service _CreateAndInitCommandReceiver.');
//  Started := False;
end;

procedure TsrvSync.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  _FinalAndDestroyCommandReceiver();
  Debug.Trace5('GCTI service CommandReceiver stopped.');
  TI := TTICommonInterface.Create(Options.Genaral.DecriptedPassword);
  if Options.Genaral.StoppingByStop.Value then begin
    TIStopUsers(Options.Genaral.StoppingByStopMode.Value
        = Ord(StoppingModeOnlyGC));
    Debug.Trace5('GCTI service StoppingByStop');
  end;
  _FinalAndDestroyCommandFactory();
  TI.Free;
  Debug.Trace5('GCTI service TTICommonInterface destroyed');
  Debug.Trace5('GCTI service CommandFactory stopped.');
  Options.Genaral.SerializedString.Value := IPInformations.SerializedString;
  Debug.Trace5('GCTI service IPInformation saved to Options');
  Options.Save;
  Debug.Trace5('GCTI service Options.Save');
  Debug.Trace0('GCTI service stoped.');
end;

end.
