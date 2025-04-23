program Advanced2_Race_condition;

uses cthreads, classes, dodavatel, odberatel, prepravka, Ender;

type


begin
  writeln('Stikněte Enter pro ukončení programu');
  sleep(2000)
  Ender:= TEnder.create(dodavatel, odberatel);
  dodavatel.waitfor;
  odberatel.waitfor;
  writeln('Ending...');
  ender.free;

end.

