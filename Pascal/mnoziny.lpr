program mnoziny;

type
  znaky = set of char;
  index = 1..5;
  indexy = set of index;

var
  abeceda: znaky;
  c: char;

begin
  abeceda := [];
  abeceda := ['a'..'z'];
  c := 'a';
  if c in abeceda then writeln('Je tam!')
end.

