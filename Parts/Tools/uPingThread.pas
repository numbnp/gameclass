unit uPingThread;

interface

uses
  Classes,uPingIcmp,gccomputers;

type
  TPingThread = class(TThread)
  private
    ClientPingable:Boolean;
    ClientIndex:Integer;
    { Private declarations }
  protected
    procedure Execute; override;
    procedure SyncClient;
    procedure SyncAll;
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
  ip : string;
begin
  while True do
  begin
    for i:=0 to CompsCount-1 do
    begin
      if Terminated then
        exit;
      ClientPingable := false;
      ClientIndex := i;

      ClientPingable := PingICMP(Comps[i].ipaddr);
      Synchronize(Self,SyncClient);
      Sleep(Interval);
    end;

    Synchronize(Self, SyncAll);
  end;
end;

procedure TPingThread.SyncAll;
begin
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

procedure TPingThread.SyncClient;
begin
  Comps[ClientIndex].RealIcmpPingable := ClientPingable;
  if Comps[ClientIndex].IgnoreOffline then
  begin
    Comps[ClientIndex].IcmpPingable:= true;
    Comps[ClientIndex].control := true;
  end else
    Comps[ClientIndex].IcmpPingable := Comps[ClientIndex].RealIcmpPingable;
  if Comps[ClientIndex].RealIcmpPingable then
    Comps[ClientIndex].CheckState;
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
