program fce;

var
  n: integer = 99;
  j: integer = 321;
function factorial(n: integer): integer; forward;

procedure conversation();
var
  n: integer;
  m: integer = 123;

  procedure output();
  var n: integer = 5;
  begin
     writeln(fce.n);
     writeln(n);
     writeln(m);
     writeln(j);
  end;

begin
   write('Vložte číslo: ');
   readln(n);
   writeln('Faktoriál daného čísla je ', factorial(n));
end;

function factorial(n: integer): integer;
begin
     result := 1;
     while n > 1 do begin
       result *= n;
       dec(n);
     end;
end;

function factorial(x: real): real;
begin
   result := 1;
   while x > 0 do begin
      result *= x;
      x -= 1;
   end;
end;

procedure swap(var a, b: integer);
var
  c: integer;
begin
   c:=a;
   a:=b;
   b:=c;
end;

procedure show(n: integer; var z: real);
begin
end;

var
  z: single = 5;
  a: integer = 10;
  b: integer = 20;

begin
  writeln(factorial(z));
  writeln(a,',',b);
  swap(a,b);
  writeln(a,',',b);

end.

