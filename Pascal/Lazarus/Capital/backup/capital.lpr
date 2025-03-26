program capital;

function na_velke(c:char): char;
var

  d: char;
  n: integer;
begin
   n := integer(c);
   if (n >= integer('a')) and (n<=integer('z')) then begin
     n := n - ord('a') + ord('A');
     result := char(n);
   end
   else begin
     result := char(n);
     end;

end;


var
  c: char = 'b';
begin
  write(na_velke(c));
end.

