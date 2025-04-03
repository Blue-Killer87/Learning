program OperatorOverload;


uses cpl;


var
  z,u,w: complex;

begin
  z.init(1,2);
  w :=-z;
  u:= z+w;
  w:=5.8;
  u:=z+1;
  if w = 5.8 then begin
    writeln('Yes');
  end;

end.

