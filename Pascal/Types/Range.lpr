program Range;

type
  index = 1 .. 5;
  den = (po, ut, st, ct, pa, so, ne);
  karta = (sedm, osm, devet, deset);

var
  n: index;
  m: integer;
  dnes: den;
begin
  m := 10;
  //n := m;
  dnes := den(4);
  if dnes < so then writeln('Ještě není víkend... pracuj.');


end.

