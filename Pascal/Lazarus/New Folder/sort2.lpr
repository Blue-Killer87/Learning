program sort2;

uses Classes;

const
  helpText = 'Filter sort sorts lines of a text file.'#13#10+
         'Usage: sort [choice] < [input-file] > [output-file]'#13#10+
         'Possible parameters:'#13#10+
         '-l : Lexigographical order'#13#10 +
         '-n : Numerical order';



function NumericalSort(_file: TStringList; index1, index2: integer): integer; forward;
function LexicographicSort(_file: TStringList; index1, index2: integer): integer; forward;

procedure FHelp;
begin
     writeln(stderr, helpText);
     Halt;
end;

function AnalyseTerminal: TStringListSortCompare;
begin
     result:=nil;
     if ParamCount = 1 then begin
           if ParamStr(1)='-n' then result:=@NumericalSort
           else if ParamStr(1)='-l' then result:=@LexicographicSort;

     end;
     if result = nil then FHelp;
end;



procedure loadFile(var fileName: text; var where: TStringList);
var _line: string;
begin
     while not EOF(fileName) do begin
       readln(fileName, _line);
       where.Add(_line);
     end;
end;

function NumberOfFirstLine(_line:string):integer;
var
  returncode: integer;
  i: integer;
  substring: string = '';

const
  numbers: set of char = ['0'..'9'];
  whiteSpaces: set of char= [' ', #9, #11];
begin
    i := 1;
    while (i <= length(_line)) and (_line[i] in whiteSpaces) do inc(i);
    while (i <= length(_line)) and (_line[i] in numbers) do begin
      substring:= substring+_line[i];
      inc(i);
    end;
    Val(substring, Result, returncode);
    if returncode <> 0 then Result := -1;

end;

procedure writeFile(var fileName: text; var source: TStringList);
var _line: string;
begin
   for _line in source do begin
         writeln(fileName, _line);
     end;
end;

var
  _file: TStringList;
  comparator: TStringListSortCompare;


function NumericalSort(_file: TStringList; index1, index2: integer): integer;
var
  na, nb: integer;
begin
   na := NumberOfFirstLine(_file.Strings[index1]);
   nb := NumberOfFirstLine(_file.Strings[index2]);
   if (na>0) and (nb>0) then begin
       result := na-nb;
   end else if na >0 then begin
     result:=1;
   end else if nb>0 then begin
      result:=-1;
   end else begin
      result:=0;
   end;
end;

function LexicographicSort(_file: TStringList; index1, index2: integer): integer;
begin
    if _file.Strings[index1] > _file.Strings[index2] then begin
      result:=1;
    end else if _file.Strings[index1] = _file.Strings[index2] then begin
        result:=0;
     end else begin
        result:=-1;
    end;
end;


begin
  comparator:= AnalyseTerminal;
  _file:=TStringList.Create;

  loadFile(input, _file);

  _file.CustomSort(comparator);

  writeFile(output, _file);
  _file.Free;

end.

