unit odberatel;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, prepravka;

type
  TOdberatel = class(TThread)
    constructor Create;
    procedure Execute; override;
  end;



implementation

constructor TOdberatel.create;
begin
    inherited create(false)
end;

procedure TOdberatel.Execute;
begin
    while not terminated do
    begin
        writeln(odberatel.text);
        Sleep(10);
    end;
end;
end.
initialization
    odberatel := Todberatel.create;

finalization
    odberatel.free;


