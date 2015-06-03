unit gcsystem;

interface

Uses Classes;

Type
  TNotifySet = set of (NotifyStopSessionNegativeBalance, NotifyLostLink
      ,NotifyGuestSession,NotifyStopSession );
  TMegaThread = class(TThread)
  private
    // Private declarations
  public
    typeDo: TNotifySet;
  protected
    procedure Execute; override;
  end;

procedure DoSound(s_type: TNotifySet);

var
  GdtLastDoSound: TDateTime;
  GLastDoSoundType: TNotifySet;


implementation

Uses
  Windows,
  DateUtils,
  uRegistry,
  uVirtualTime;

procedure TMegaThread.Execute;
var
  f,l,p: integer;
begin
  if (typeDo = [NotifyStopSessionNegativeBalance]) then begin
    f := 1700;
    l := 30;
    p := 50;
    Windows.Beep(f,l);
    sleep(p);
    Windows.Beep(f,l);
    sleep(p);
    Windows.Beep(f,l);
    sleep(200);
    Windows.Beep(f,l);
    sleep(p);
    Windows.Beep(f,l);
    sleep(p);
    Windows.Beep(f,l);
    exit;
  end;
  if (typeDo = [NotifyStopSession]) then begin
    f := 2000;
    l := 100;
    p := 30;
    Windows.Beep(f,l);
    sleep(p);
    Windows.Beep(f,l);
    sleep(p);
    Windows.Beep(f,l);
    sleep(200);
    Windows.Beep(f,l);
    sleep(p);
    Windows.Beep(f,l);
    sleep(p);
    Windows.Beep(f,l);
    exit;
  end;
  if (typeDo = [NotifyLostLink]) then begin
    f := 900;
    l := 50;
    Windows.Beep(f,l);
    sleep(200);
    Windows.Beep(f,l);
    exit;
  end;
  if (typeDo = [NotifyGuestSession]) then begin
    f := 400;
    l := 200;
    Windows.Beep(f,l);
    exit;
  end;
end;

procedure DoSound(s_type: TNotifySet);
Var
  megaThread: TMegaThread;
begin
  if (s_type = GLastDoSoundType)
      and (SecondsBetween(GetVirtualTime, GdtLastDoSound)
      < GRegistry.Options.ClientQueryTime) then
    exit;
  GLastDoSoundType := s_type;
  GdtLastDoSound := GetVirtualTime;
  megaThread := TMegaThread.Create(True);
  megaThread.Priority := tpNormal;
  megaThread.typeDo := s_type;
  if megaThread.Suspended then megaThread.Start;
end;

end.
