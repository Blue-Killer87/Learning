unit cpl;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type
  complex = object
    Fre, Fim: real;
    constructor Init(_re, _im: double);
    property re: double read Fre write Fre;
    property im: double read Fim write Fim;
  end;

operator +(z: complex): complex;
operator -(z: complex): complex;

operator +(z,w: complex): complex;
//operator +(z: complex; w: real): complex;
operator :=(x: real): complex;
operator =(z,w: complex) output: boolean;


implementation

constructor complex.Init(_re, _im: double);
begin
  re := _re;
  im := _im;
end;

operator +(z: complex): complex;
begin
  result := z;
end;

operator -(z: complex): complex;
begin
     result.Re := -z.Re;
     result.Im := -z.Im;
end;

operator +(z,w: complex): complex;
begin
     result.Re := z.Re + w.Re;
     result.Im := z.Im + w.Im;
end;

{operator +(z: complex; w: real): complex;
begin
     result.Re := z.Re + w;
     result.Im := z.Im;
end;}

operator :=(x: real): complex;
begin
     result.re := x;
     result.im := 0;
end;

end.

