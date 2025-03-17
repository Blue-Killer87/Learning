program seznam2;

uses seznam2_u;

var
  seznam: TSeznam;

begin
  seznam := TSeznam.Create;
  seznam.Vypis;
  seznam.VlozNaZacatek(6);
  seznam.VlozNaZacatek(8);
  seznam.Vypis;
  writeln;
  seznam.OdstranPrvni;
  seznam.Vypis;
  writeln(TPrvek.pocet);
  seznam.Vyprazdni;
  seznam.vypis;
  writeln;

  seznam.Free;


end.


