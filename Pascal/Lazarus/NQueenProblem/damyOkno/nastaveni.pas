unit nastaveni;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Graphics;


procedure setPocetDam(pocet: integer);
function getPocetDam: integer;


procedure setBarvaDam(barva: TColor);
function getBarvaDam: Tcolor;

procedure setBarvaCar(barva: Tcolor);
function getBarvaCar: Tcolor;

property PocetDam: integer read getPocetDam write setPocetDam;
property BarvaDam: integer read getBarvaDam write setBarvaDam;
property BarvaCar: integer read getBarvaCar write setBarvaCar;

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

function getBarvaDam: Tcolor;
begin
  result:=FbarvaDam;
end;

function getBarvaCar: Tcolor;
begin
  result:=FbarvaCar;
end;

procedure setbarvaDam(barva: tcolor);
begin
  FbarvaDam:=barva;
end;

procedure setbarvacar(barva: tcolor);
begin
  Fbarvacar:=barva;
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

