program go;

uses graph_objects, bodU, useckau;


  var
    g: grafickyObjekt;
    b: bod;
    ug: ^grafickyObjekt;

begin
  g.init(10);
  writeln(g.Fbarva);
  g.Fbarva := 11;
  g.nakresli;
  b.Init(6,7,8);
  writeln;
  {g := b;
  b.nakresli;
  writeln;
  g.nakresli}

  ug := @g;
  ug^.nakresli;
  ug := @b;
  ug^.nakresli;
  ug := new(pusecka, Init(3, b, b));
  writeln;
  ug^.nakresli;


end.

