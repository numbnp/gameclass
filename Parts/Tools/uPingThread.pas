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
  end;

var
  PingThread:TPingThread;

procedure StartPingThread();
procedure StopPingThread();

implementation

uses SysUtils, TypInfo;

{ Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure TPingThread.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

{ TPingThread }

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
      if Comps[i].IgnoreOffline then
        Comps[i].IcmpPingable:= true
      else
        Comps[i].IcmpPingable := PingICMP(Comps[i].ipaddr);
      Sleep(100);
    end;

  end;
end;

procedure StartPingThread();
begin
  if PingThread=nil then
    PingThread := TPingThread.Create(true);

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
