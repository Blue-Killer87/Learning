program obj;

type
  bod = object
    x,y: integer;
    constructor Init(_x, _y: integer);
    procedure draw;
    destructor Done;
  end;

  constructor bod.init(_x, _y: integer); begin
    x := _x;
    y := _y;
  end;

  destructor bod.Done;
  begin
    writeln('Bod zaniká...')
  end;

procedure bod.draw;
begin
  writeln('(', x, ' ', y, ')');
end;

var
  b: bod;

begin
  b.init(3,5);
  b.draw;
  b.done;
end.

