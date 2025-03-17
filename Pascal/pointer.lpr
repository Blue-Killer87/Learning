program pointer;

type
  uint = ^integer;

procedure swap(a,b: uint);
var c: integer;
  begin
    c:=a^;
    a^:=b^;
    b^:=c

  end;

var
  x,y: integer;
  ux: uint = nil;

begin
  x := 10;
  y := 20;
  new(ux);
  ux^:=11;
  writeln(x,' ',y);
  swap(@x,@y);
  writeln(x,' ',y);
  dispose(ux);
  ux:=new(uint);
end.

