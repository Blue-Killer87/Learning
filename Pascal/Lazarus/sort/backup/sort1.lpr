program sort1;

uses Classes;

var
  line : string;
  _file: TStringList;

begin
  _file:=TStringList.Create;
  while not EOF do begin
    readln(line);
    _file.Add(line);
  end;
  _file.Sort;
  for line in _file do begin
    writeln(line);
  end;
end.

