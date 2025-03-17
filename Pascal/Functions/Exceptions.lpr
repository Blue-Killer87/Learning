program forfactorial;
uses sysutils;

var
  n: integer;

function factorial (n: integer): integer;
var
  i: integer;

begin
     if n < 0 then raise EArgumentOutOfRangeException.Create('Záporný parametr faktoriálu.');
     result := 1;
     for i := 2 to n do
     begin
       result := result * i
     end;
end;

var
  m: integer;

begin
  try

  write('Zadej číslo: ');
  readln(n);
  m := factorial(n);
  writeln('Faktoriál čísla ',n, ' je ', m);

  except
    writeln('Něco se nepovedlo, zkuste to znovu...')
  end;



end.
