program IO_Test;



 const
   jmeno: string = 'data.dta';

 procedure zapis(jmeno: string);
 var i: integer;
     f: file of integer;
 begin
     assign(f, jmeno);
      rewrite(f);
      for i := 0 to 10 do
      begin
        write(f, i);
      end;
      close(f);
 end;


procedure cteni(jmeno: string);
var i: integer;
    f: file of integer;
begin
     assign(f, jmeno);
     reset(f);
     while not eof(f) do begin
       read(f, i);
       write(i, ' ');
     end;
     writeln;
     close(f);
end;

begin
   zapis(jmeno);
   cteni(jmeno);
 end.






