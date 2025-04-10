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

procedure aktualizace(jmeno: string);
var
    f: file of integer;
    i: integer;
    pos: integer;
begin
    assign(f, jmeno);
    reset(f);
    while not eof(f) do begin
      read(f, i);
      if odd(i) then begin
        i := 2*i;
        pos:=filepos(f);
        seek(f, pos-1);
        write(f,i);
      end;

    end;
    close(f);
end;

var
    x: integer = 15;
    y: real = 321.1568;


begin
   zapis(jmeno);
   cteni(jmeno);
   writeln;
   aktualizace(jmeno);
   cteni(jmeno);
   writeln;
   write('bylo tam', x:15, ' lidí');
   writeln;
   write('Je to ', y:3, ' miligramů');
 end.






