program dedeni;

type
  graphicObject = object
    color: integer;
      constructor init(_color: integer);
    procedure draw;
    procedure setColor(_color: integer);
    function getColor:integer;
  end;

  constructor graphicObject.init(_color: integer);
  begin
    setColor:=_color;
  end;

procedure graphicObject.setColor(_color: integer);
begin
    color := _color;
end;

function graphicObject.getColor: integer;
begin
    result:=color;
end;

procedure graphicObject.draw;
begin
    writeln('[', color, ']')

    end;
var
  go: graphicObject;

begin
  go.init(10);
  go.draw;
  go.setColor(22);
  go.draw;


end.

