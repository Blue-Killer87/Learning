program record1;

uses date_u;

var
   today: date = (day: 31; month: 1; year: 2024);
   tmrw: date;

begin
  tmrw := date_u.tmrw(today);
  writeln(tmrw.day);

end.

