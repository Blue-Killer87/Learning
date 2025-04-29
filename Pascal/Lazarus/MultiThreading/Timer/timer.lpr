program timer;

uses CThreads, Classes, sysutils, Generics.Collections;

type
  TimerHandler = procedure of object;
  HandlerList = specialize Tlist <TimerHandler>;

  TTimer = class(TThread)
     FInterval: integer;
     FHandler: HandlerList;
     FEnabled: Boolean;
     Signalization: PRTLEvent;
     procedure setEnabled(status: boolean);
     procedure Execute; override;
     procedure startHandlers;
  public
     constructor Create(_interval:integer);
     property interval: integer read FInterval write FInterval;
     property enabled: boolean read FEnabled write setEnabled;
     procedure addHandler(handler: TimerHandler);
  end;

Constructor TTimer.Create(_interval:integer);
begin
    inherited create(false);
    Interval:=_interval;
    FHandler:=HandlerList.create;
    FEnabled:=false;
    signalization:=RTLEventCreate;
end;

procedure TTimer.setEnabled(status: boolean);
begin
    FEnabled := status;
    if FEnabled then begin
      RTLEventSetEvent(Signalization);
    end;
end;

procedure TTimer.addHandler(handler: TimerHandler);
begin
    FHandler.Add(handler);
end;

procedure TTimer.startHandlers;
var i: integer;
begin
    for i:=0 to FHandler.Count-1 do begin
      FHandler[i]();
    end;
end;

procedure TTimer.Execute;
begin
    while True do begin
      Sleep(interval);
      while not enabled do begin
        RTLEventWaitFor(Signalization);
      end;
      startHandlers;
    end;
end;

type
    Thelper = class
       procedure Tick;
    end;

procedure THelper.Tick;
begin
    writeln('Tick');
end;

var
  timer1: TTimer;
  p: THelper;

begin
  p:= THelper.Create;
  timer1:=TTimer.Create(300);
  timer1.addHandler(@p.Tick);
  timer1.enabled:=True;
  readln;
end.

