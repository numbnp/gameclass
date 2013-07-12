unit uPingThread;

interface

uses
  Classes,uPingIcmp,gccomputers;

type
  TPingThread = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
  public
    Interval:integer;
    constructor Create(Suspended:Boolean);


  end;

var
  PingThread:TPingThread;

procedure StartPingThread(Interval:integer);
procedure StopPingThread();

implementation

uses SysUtils, TypInfo, uRegistry;

{ TPingThread }

constructor TPingThread.Create(Suspended: Boolean);
begin
  inherited Create(Suspended);
  Interval:=100;
end;

procedure TPingThread.Execute;
var
  i:integer;
begin
  while True do
  begin
    for i:=0 to CompsCount-1 do
    begin
      if Terminated then
        exit;
        Comps[i].RealIcmpPingable := PingICMP(Comps[i].ipaddr);
      if Comps[i].IgnoreOffline then
        Comps[i].IcmpPingable:= true
      else
        Comps[i].IcmpPingable := Comps[i].RealIcmpPingable;
      if Comps[i].RealIcmpPingable then
        Comps[i].CheckState;
      Sleep(Interval);
    end;

    if GRegistry.Options.OperatorTrafficControl
          and GRegistry.Modules.Internet.SummaryAccounting then begin
        GRegistry.Options.OperatorTrafficInbound :=
            GRegistry.Options.OperatorTrafficInbound
            + FProxy.IPTrafficGetIn(GRegistry.Options.OperatorIP);
        GRegistry.Options.OperatorTrafficOutbound :=
            GRegistry.Options.OperatorTrafficOutbound
            + FProxy.IPTrafficGetOut(GRegistry.Options.OperatorIP);
    end;



  end;
end;

procedure StartPingThread(Interval:integer);
begin
  if PingThread=nil then
    PingThread := TPingThread.Create(true);
  PingThread.Interval := Interval;
  PingThread.Resume;
end;

procedure StopPingThread();
begin
  if PingThread <> nil then
  begin
    PingThread.Terminate;
    FreeAndNil(PingThread);
  end;
end;


end.
