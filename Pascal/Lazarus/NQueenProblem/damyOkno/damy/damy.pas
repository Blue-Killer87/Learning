unit damy;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type
  TPoleReseni = array of integer;

  TResitel = class
    private
      N: integer;
      FReseni: TPoleReseni;
      FPocetNalezenychReseni: integer;
      FPocetVolani: QWord;

      function Bezpecna(k, m: integer): boolean;
      function ResOdSloupce(m: integer): TPoleReseni;
      function NajdiDalsiBezpecnouRadku(radka, sloupec: integer): integer;
    public
      constructor Create(pocetDam: integer);
      procedure vypis;
      function NajdiDalsiReseni: Boolean;
      procedure NajdiVsechnaReseni;
      property PocetNalezenychReseni: integer read FPocetNalezenychReseni;
      property PocetVolani: QWord read FPocetVolani;
      property Reseni: TPoleReseni read FReseni;

  end;

implementation

constructor TResitel.Create(pocetDam: integer);
var i: integer;
begin
  N := pocetDam;
  SetLength(FReseni, pocetDam);
  for i := 0 to pocetDam - 1 do
  begin
    FReseni[i] := -1;    // zatím tam nejsou žádné dámy
  end;
end;

function TResitel.Bezpecna(k, m: integer): Boolean;
var i: integer;
begin
  inc(FPocetVolani);
  Result := true;
  if m = 0 then exit;
  i := 0;
  while Result and (i < m) do
  begin
    Result := (FReseni[i] <> k) and
              (FReseni[m - i - 1] <> k - i - 1) and
              (FReseni[m - i - 1] <> k + i + 1);
    //if not Result then exit;
    inc(i);
  end;
end;

function TResitel.NajdiDalsiBezpecnouRadku(radka, sloupec: integer): integer;
begin
  inc(radka);
  while radka < N do
  begin
    if Bezpecna(radka, sloupec) then break;
    inc(radka);
  end;
  result := radka;
end;

function TResitel.ResOdSloupce(m: integer): TPoleReseni;
var k: integer;
begin
  Result := nil;
  while m > -1 do
  begin
    k := NajdiDalsiBezpecnouRadku(reseni[m], m);
    if k < N then
    begin
      FReseni[m] := k;
      inc(m);
      if m = N then
      begin
        Result := reseni;
        exit;
      end;
    end else begin
      FReseni[m] := -1;
      dec(m)
    end;
  end;
end;

procedure TResitel.vypis;
var
   i: integer;
   mezera: string = '';
   result1: string = '(';
begin
  {write('(');
  for i := 0 to N - 1 do
  begin
    if i < N - 1 then mezera := ', ' else mezera := '';
    write(FReseni[i], mezera);
  end;


  writeln(')');}
  for i := 0 to N -1 do begin
      if i < N - 1 then mezera := ', ' else mezera := '';
      result1:=result1+IntToStr(FReseni[i])+mezera;
  end;

  result1:=result1+')';
  writeln(result1);

end;

function TResitel.NajdiDalsiReseni: Boolean;
var
   vysledek: TPoleReseni;
begin
  if PocetNalezenychReseni = 0 then
  begin
    vysledek := ResOdSloupce(0);
  end else begin
    vysledek := ResOdSloupce(N - 1);
  end;
  result := vysledek <> nil;
  if result then inc(FPocetNalezenychReseni);
end;

procedure TResitel.NajdiVsechnaReseni;
begin
  while NajdiDalsiReseni do
  ;
end;

end.

