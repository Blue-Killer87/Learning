library DynLibrary;

{$mode objfpc}{$H+}

uses
  Classes
  { you can add units after this };

var
  chyba: integer;

const
  dovoleneMaximum = 12;

function faktorial(n: integer): integer;
begin;
  if n < 0 then chyba:=1;
  if n > dovoleneMaximum then chyba:=2;
  result := 1;
  while n>1 do begin
       result *= n;
       dec(n);
       end;
end;


begin
     chyba := 0
end.

exports chyba, faktorial;
