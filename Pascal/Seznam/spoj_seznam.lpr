program spoj_seznam;


uses seznamU;

var
  s: seznam;

begin
  s.init;
  writeln(s.velikost);
  s.vlozNaZacatek(15);
  writeln(s.velikost);
  s.vypis;
  s.odstranPrvni;
  s.vypis;
  writeln(s.velikost);

  writeln(prvek.Pocetprvku);

  s.done;
end.

