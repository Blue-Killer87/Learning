unit Ender;

{$mode ObjFPC}{$H+}

interface

uses
  CThreads, Classes, SysUtils, dodavatel, odberatel;

type
  TEnder = class(TThread)
    private
        dodavatel: TDodavatel;
        odberatel: TOdberatel;
    public
        constructor Create(_dodavatel: TDodavatel, _odberatel: TOdberatel);
        procedure Execute; override;
  end;

var
  theEnd: boolean;
  ender: TEnder;
implementation

constructor TEnder.Create(_dodavatel: TDodavatel, _odberatel: TOdberatel);
begin
    dodavatel:= _dodavatel;
    odberatel:= _odberatel;
    inherited create(false);
end;

procedure TEnder.Execute;
begin
    readln;
    dodavatel.Terminate;
    odberatel.Terminate;
    writeln('Stikněte Enter pro ukončení programu');
end;
end.

