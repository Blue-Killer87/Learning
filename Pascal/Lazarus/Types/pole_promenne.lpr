program pole_promenne;

var
  pole: array of integer;
  //matice: array[1..3, 1..3] of real;
  matice: array[1..3] of array[1..3] of real;
  bod: array[1..3] of real = (1.0, 3.0, 3.5);
  bod1: array[1..3] of real;

begin
  SetLength(pole, 10);
  pole[0] := 10;
  SetLength(pole, 20);
  matice[1,1] := 0.7;
  bod1 := bod;
  bod[2] := 9;

  matice[2] := bod;
  bod1 := matice[1];

end.

