program repeat_func;

function e(eps: real): real;
var
  scitanec: real = 1.0;
  n: integer = 2;

begin
    result := 2.0;
    repeat
        scitanec := scitanec/n;
        inc(n);
        result := scitanec;

    until scitanec < eps;
end;

begin
     writeln(e(1e-5))
end.

