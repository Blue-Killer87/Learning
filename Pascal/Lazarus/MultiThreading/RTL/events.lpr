program events;

uses CThreads, Classes, Sysutils;

const kolik = 3;

var
  muzeKocka,muzePes,muzePrset: PRTLEvent;

type
  Tverse = class(TThread)
    private
      textVerse: string;
      muzuJa, muzeDalsi: PRTLEvent;
    public
      constructor Create(txt: string; moje, dalsi: PRTLEvent);
      procedure Execute; override;

  end;

constructor Tverse.Create(txt: string; moje, dalsi: PRTLEvent);
begin
    textVerse:=txt;
    muzuJa:=moje;
    muzeDalsi:=dalsi;
    FreeOnTerminate:=false;
    inherited create(false);
end;

procedure Tverse.Execute;
var
  i: integer;
begin
     for i:=1 to kolik do begin
       RTLEventWaitFor(muzuJa);
       writeln(textVerse);
       RTLEventSetEvent(muzeDalsi);
     end;
end;

var
  pes, kocka, prset: Tverse;

procedure vytvorUdalosti;
begin
    muzeKocka:=RTLEventCreate;
    muzePes:=RTLEventCreate;
    muzePrset:=RTLEventCreate;
end;

procedure vytvorVlakna;
begin
    kocka := Tverse.Create('Kočka leze dírou #10', muzekocka, muzepes);
    pes := Tverse.Create('pes oknem #10 pes oknem', muzepes, muzeprset);
    prset := Tverse.Create('Nebude-li pršet, nezmoknem', muzeprset, muzekocka);
end;
begin
  vytvorUdalosti;
  vytvorVlakna;
  RTLEventSetEvent(muzekocka);
  kocka.WaitFor;
  pes.WaitFor;
  prset.WaitFor;
end.

