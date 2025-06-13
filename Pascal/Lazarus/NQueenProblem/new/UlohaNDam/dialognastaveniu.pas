unit DialogNastaveniU;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls,
  ExtCtrls, Nastaveni;

type

  { TDialogNastaveni }

  TDialogNastaveni = class(TForm)
    dialogBarvy: TColorDialog;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ListBox1: TListBox;
    tlacitkoZmenBarvuDam: TButton;
    TlacitkoZmenBarvuCar: TButton;
    panelBarvaDam: TPanel;
    panelBarvaCar: TPanel;
    stranaPocet: TTabSheet;
    stranaBarvy: TTabSheet;
    tlacitkoOK: TButton;
    tlacitkoStorno: TButton;
    obsah: TPageControl;
    procedure TlacitkoZmenBarvuCarClick(Sender: TObject);
    procedure tlacitkoZmenBarvuDamClick(Sender: TObject);

  private
    function getPocetDam: integer;
    procedure setPocetDam(n: integer);
    procedure setBarvaDam(barva: TColor);
    function getBarvaDam: TColor;
    procedure setBarvaCar(barva: TColor);
    function getBarvaCar: TColor;
  public
    property PocetDam: integer read getPocetDam write setPocetDam;
    property BarvaDam: TColor read getBarvaDam write setBarvaDam;
    property BarvaCar: TColor read getBarvaCar write setBarvaCar;
  end;

var
  DialogNastaveni: TDialogNastaveni;

implementation

{$R *.lfm}

{ TDialogNastaveni }

function TDialogNastaveni.getBarvaDam: TColor;
begin
  Result := panelBarvaDam.Color;
end;

procedure TDialogNastaveni.setBarvaDam(barva: TColor);
begin
  panelBarvaDam.Color:= barva;
end;

function TDialogNastaveni.getBarvaCar: TColor;
begin
  Result := panelBarvaCar.Color;
end;

procedure TDialogNastaveni.setBarvaCar(barva: TColor);
begin
  panelBarvaCar.Color:= barva;
end;

function TDialogNastaveni.getPocetDam: integer;
begin
  Result := ListBox1.ItemIndex + 4;
end;

procedure TDialogNastaveni.setPocetDam(n: integer);
begin
   ListBox1.Selected[n - 4] := true;
end;

procedure TDialogNastaveni.tlacitkoZmenBarvuDamClick(Sender: TObject);
begin
   self.dialogBarvy.Title:='Zvolte barvu dam';
   self.dialogBarvy.Color:=Nastaveni.BarvaDam;
   if dialogBarvy.Execute then
   begin
     self.panelBarvaDam.Color:=self.dialogBarvy.Color;
   end;
end;

procedure TDialogNastaveni.TlacitkoZmenBarvuCarClick(Sender: TObject);
begin
   self.dialogBarvy.Title:='Zvolte barvu čar šachovnice';
   self.dialogBarvy.Color:=Nastaveni.BarvaCar;
   if dialogBarvy.Execute then
   begin
     self.panelBarvaCar.Color:=self.dialogBarvy.Color;
   end;
end;




end.
