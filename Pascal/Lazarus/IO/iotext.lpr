program iotext;

const
  jmeno: string = 'data.txt';

procedure zapis(jmeno: string);
var
  i: integer;
  f: text;
begin
     assign(f, jmeno);
     rewrite(f);
     for i := 1 to 10 do begin
       write(f, i, ' ')
     end;
     writeln(f);
     close(f);
end;

procedure vypis(jmeno:string);
var
  i: integer;
  f: text;
begin
     assign(f, jmeno);
     reset(f);
     while not seekeof(f) do begin
       write(f, i);
       write(i, ' ');
     end;
     writeln(f);
     close(f);

end;

begin
  //zapis(jmeno);
  vypis(jmeno);
end.

