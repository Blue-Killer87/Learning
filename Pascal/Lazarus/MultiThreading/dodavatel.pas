unit dodavatel;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, prepravka, odberatel;


type
  Tdodavatel = class(TThread)
    constructor Create;
    procedure Execute; Override;
  end;

var
  dodavatel:Tdodavatel;

implementation
constructor Tdodavatel.Create;
begin
    inherited create(false);
end;

procedure Tdodavatel.Execute;
begin
    while not Terminated do begin
      prepravka.accept(Random, Random);
      Sleep(20);
    end;
end;

initialization
              dodavatel := Tdodavatel.create;
finalization
              dodavatel.free;

end.

