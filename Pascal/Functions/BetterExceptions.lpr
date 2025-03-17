program BetterExceptions;
uses sysutils;

var
  n: integer;

function factorial (n: integer): integer;
var
  i: integer;

begin
     if n < 0 then raise EArgumentOutOfRangeException.Create('Záporný parametr faktoriálu: ' + IntToStr(n));
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
     try
        write('Zadej číslo: ');
        readln(n);
        m := factorial(n);
        writeln('Faktoriál čísla ',n, ' je ', m);
     finally
       writeln('Sponzorováno firmou "404 NOT FOUND"');
     end;


  except
    on e1: EArgumentOutOfRangeException do begin
    writeln(e1.Message); end;
  end;



end.
