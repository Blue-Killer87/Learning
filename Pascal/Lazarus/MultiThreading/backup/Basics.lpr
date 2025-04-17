program Basics;

uses cthreads, classes;

const howMany = 10;

type
  Texter = class(TThread)
    private
      txt: string;
    public
      constructor Create(_txt: string);
      procedure Execute; Override;
  end;

Constructor Texter.Create(_txt:string);
begin
    txt := _txt;
    inherited Create(true);
    FreeOnTerminate:=True;
end;

procedure Texter.Execute;
var i: integer;
begin
     for i := 1 to howMany do
     begin
       writeln(i, ' ', txt);
       Tthread.yield;
     end;
end;

var
  T1, T2: Texter;
  txt1, txt2, txt3: string;

begin
  txt1:= 'Kočka leze dírou';
  txt2:= 'Pes oknem';
  txt3:= 'Nebude-li pršet, nezmoknem';
  T1:= Texter.create(txt1);
  T2:= Texter.create(txt2);
  T1.resume;
  T2.resume;
  t1.waitfor;
  t2.waitfor;
  writeln(txt3);

end.

