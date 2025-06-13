unit dialogNastaveni;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  Menus, ExtCtrls;

type

  { TOknoNastaveni }

  TOknoNastaveni = class(TForm)
    LabelBarvaDam: TLabel;
    LabelBarvaCar: TLabel;
    menuPocetDam: TTabSheet;
    menuBarva: TTabSheet;
    panelBarvaDam: TPanel;
    panelbarvacar: TPanel;
    TlacitkoOk: TButton;
    TlacitkoStorno: TButton;
    volicPoctuDam: TListBox;
    PageControl1: TPageControl;




       procedure setPocetDam(pocet: integer);
       function getPocetDam: integer;

  public
    property PocetDam: integer read getPocetDam write setPocetDam;
  end;

var
  OknoNastaveni: TOknoNastaveni;

implementation


{$R *.lfm}

{ TOknoNastaveni }


procedure TOknoNastaveni.setPocetDam(pocet: integer);
begin
   volicPoctuDam.Selected[pocet - 4] := True;
end;

function TOknoNastaveni.getPocetDam: integer;
begin
     result := volicPoctuDam.itemindex;
end;


end.

