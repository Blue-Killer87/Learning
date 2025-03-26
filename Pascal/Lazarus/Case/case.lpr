program case_test;

var
  n: integer;
procedure pozdrav(n: integer);
begin
  case n of
  1: writeln('Ahoj');
  2..4,6: writeln('Nazdar');
  5,7..9: writeln('Sbohem...');
  end;
end;

begin
     writeln('Zadej číslo');
     readln(n);
     writeln('Díky');
     pozdrav(n);
end.

