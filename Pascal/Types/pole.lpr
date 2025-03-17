program pole1;

type
  index = 1..3;
  pole = array[index] of integer;

var
  a: pole;
  b: pole;



begin
     a[1] := 10;
     b := a;
end.

