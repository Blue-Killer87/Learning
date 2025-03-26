program useLibrary;



function faktorial(n: integer): integer; external 'Library.so';

begin
  writeln(faktorial(5));
end.

