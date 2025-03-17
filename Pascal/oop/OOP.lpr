program OOP;

type
    number = real;

    napis = object;
    text= string;
    constructor Init(txt: string);
    procedure vypis;
    end;
constructor Napis.Init(txt: string);
begin
     text := txt;
end;

procedure napis.vypis:
begin
    writeln(text);
end;

function factorial(n: integer): number
begin
result := 1;
while n>1 do begin
  result := result * n;
  dec(n)
end;
end;

var
   pozdrav: Napis;
begin
//writeln(factorial(50);
pozdrav.init('Nazdar, lidi')
pozdrav.vypis;
end.

