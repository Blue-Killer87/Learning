program capital_new;

{function na_velke_pismeno(c:char): char;
var
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

end;}


function na_velke_diakritika(c: char): char;
begin
     case c of
          'ě': result := 'Ě';
          'š': result := 'Š';
          'č': result := 'Č';
          'ř': result := 'Ř';
          'ž': result := 'Ž';
          'ý': result := 'Ý';
          'á': result := 'Á';
          'í': resutl := 'Í';
          'é': result := 'É';
          else
            result := c;
     end;
end;

function na_velke_pismeno(c:char): char;
var
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

function na_velka(txt: string): string;
var
  c: char;
begin
     result := '';
     for c in txt do begin
          result := result + na_velke_diakritika(c)
     end;
end;


begin
  writeln(na_velka('text'));
end.


