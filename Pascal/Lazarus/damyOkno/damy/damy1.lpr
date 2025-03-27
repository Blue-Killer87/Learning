program damy1;

uses damy;

const
  pocetdam: integer = 14;

var
  resitel: TResitel;
  i: integer;


begin
  resitel:=TResitel.create(pocetdam);
  {while resitel.NajdiDalsiReseni do begin
    write('(');
    for i in resitel.Reseni do begin
         write(i, ' ');
    end;
    writeln(')');
  end;
  }

  {resitel.NajdiVsechnaReseni;
  writeln('Počet řešení: ', resitel.PocetNalezenychReseni,' Počet pokusů: ', resitel.PocetVolani);}

  while resitel.NajdiDalsiReseni do begin
    resitel.vypis;
  end;
end.

