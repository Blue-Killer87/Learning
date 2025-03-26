unit nastaveni;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Graphics;


procedure setPocetDam(pocet: integer);
function getPocetDam: integer;

property PocetDam: integer read getPocetDam write setPocetDam;

procedure VychoziNastaveni;

implementation

var
   FpocetDam: integer;
   FBarvaDam: TColor;
   FBarvaCar: TColor;

const
  vychoziPocetDam = 4;
  vychoziBarvaDam: TColor = clBlack;
  vychoziBarvaCar: Tcolor = clBlack;

procedure setpocetDam(pocet: integer);
begin
  FpocetDam:=pocet;
end;

function getPocetDam: integer;
begin
  result:=FpocetDam;
end;

procedure VychoziNastaveni;
begin
  PocetDam:= vychoziPocetDam;
  FbarvaDam:= vychoziBarvaDam;
  FBarvaCar:= vychoziBarvaCar;
end;

initialization

VychoziNastaveni;

end.

