unit prepravka;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type
  Tprepravka = class
    private
      x,y,z: real;
      iteration: integer;
      lock: TRTLCriticalSection;
    public
      constructor Create;
      destructor Destroy; override;
      procedure accept(gama1, gama2: real);
      function data: string;
      procedure check;
      property text: string read data;
  end;



implementation
const
  epsilon = 1e-11;

constructor Tprepravka.create;
begin
  x:=1; y:=0; z:=0;
  iteration:=0;
  InitCriticalSection(lock);
end;

destructor Tprepravka.Destroy;
begin
  DoneCriticalSection(lock);
end;

procedure Tprepravka.accept(gama1, gama2: real);
var
  fi, costheta, sintheta: real;
begin
    costheta:=2*gama1-1;
    sintheta:=Sqrt(1-Sqr(costheta));
    fi:= 2*gama2*Pi;
    EnterCriticalSection(lock);
    try
      x:=sintheta*cos(fi);
      y:=sintheta*sin(fi);
      z:= costheta;

      inc(iteration);

    finally
      LeaveCriticalSection(lock);
    end;
end;

procedure TPrepravka.check;
var
  error: real;
  txt: string;

begin
    error:=sqr(x)+sqr(y)+sqr(z) - 1.0;
    if error > epsilon then begin
      txt:='Inconsistent Data after '+ IntToStr(iteration)+ 'iterations';
      writeln(txt);
      halt; //kill the process
    end;
end;

function TPrepravka.data: string;
begin
    EnterCriticalSection(lock);
    try
          check;
          result:='(' + FloatToStr(x) + ', ' + FloatToStr(y) + ', ' + FloatToStr(z) + ', '+ ')';
    finally
      LeaveCriticalSection(lock);
    end;

end;
end.
initialization
   prepravka := Tprepravka.create;
finalization
   prepravka.free;

end.

