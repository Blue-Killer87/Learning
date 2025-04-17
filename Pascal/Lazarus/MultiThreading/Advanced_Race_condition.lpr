program Advanced_Race_condition;
   uses cthreads, classes, damy;

type
  Toutput = class(TThread)
    private
      resitel: TResitel;
      pocetDam: integer;
    public
    constructor Create(_pocetDam: integer);
    procedure Execute; override;
  end;

 constructor Toutput.Create(_pocetDam: integer);
 begin
   pocetDam := _pocetDam;
   resitel:=Tresitel.create(pocetDam);
   FreeOnTerminate:=True;
   inherited create(false);
 end;

procedure Toutput.Execute;
begin
    while resitel.NajdiDalsiReseni do begin
      resitel.vypis;
    end;
end;

const numberofQueens = 8;
var
   output1, output2: Toutput;
begin
  writeln('outputting solution of the ',numberofQueens,'-queen problem');
  //Sleep(3000);
  output1:=Toutput.create(numberofQueens);
  output2:=Toutput.create(numberofQueens);
  output1.waitfor;
  output2.waitfor;
end.

