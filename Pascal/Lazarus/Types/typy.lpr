program typy;

type
  cislo = real;

function faktorial(n: cislo):cislo;

  begin
    result :=1;
    while n > 1 do begin
      result := result*n;
      n -= 1;
    end;

  end;

var
  n: integer;
begin
  write('Vlože číslo: ');
  readln(n);
  writeln('Faktoriál čísla ',n, ' je ', faktorial(n))
end.

