unit Okno;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ComCtrls,
  ExtCtrls, LazHelpHTML, damy, Nastaveni, DialogNastaveniU, HelpIntfs;

type

  { TOknoProgramu }

  TOknoProgramu = class(TForm)
    databazeNapovedy: THTMLHelpDatabase;
    prohlizecNapovedy: THTMLBrowserHelpViewer;
    menuIndex: TMenuItem;
    casovac: TTimer;
    type
       TPocetCelkem = class(TThread)
         procento: integer;
         text: string;
         stav: TStatusBar;
         constructor Create(_stav: TStatusBar);
         procedure Execute; override;
         procedure nastavProcenta;
         //procedure smazProcenta;
         procedure zobrazVysledek(Sender: TObject);
       end;
    var
    kresliciPanel: TPanel;
    seznamObrazku: TImageList;
    mebnuNova: TMenuItem;
    menuNova: TMenuItem;
    menuDalsiReseni: TMenuItem;
    menuCelkovyPocet: TMenuItem;
    menuOProgramu: TMenuItem;
    menuNapoveda: TMenuItem;
    menuUpravit: TMenuItem;
    menuObnovitVychozi: TMenuItem;
    menuNastaveni: TMenuItem;
    MenuKonec: TMenuItem;
    Seprator1: TMenuItem;
    menuUloha: TMenuItem;
    nabidka: TMainMenu;
    panelNastroju: TToolBar;
    StatusBar1: TStatusBar;
    tlacitkoNovaUloha: TToolButton;
    tlacitkoDalsiReseni: TToolButton;
    tlacitkoCekovyPocet: TToolButton;
    procedure casovacTimer(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure kresliciPanelPaint(Sender: TObject);
    procedure menuCelkovyPocetClick(Sender: TObject);
    procedure menuDalsiReseniClick(Sender: TObject);
    procedure menuIndexClick(Sender: TObject);
    procedure MenuKonecClick(Sender: TObject);
    procedure menuNovaClick(Sender: TObject);
    procedure menuOProgramuClick(Sender: TObject);
    procedure menuUpravitClick(Sender: TObject);
    procedure tlacitkoNovaUlohaClick(Sender: TObject);
  private
    resitel: TResitel;
    jeReseni: Boolean;
    procedure NakresliSachovnici(Platno: TCanvas; sirka, vyska: integer);
    procedure NakresliDamy(Platno: TCanvas; sirka, vyska: integer);
    procedure ZmenPovoleni(jak: Boolean);
  public

  end;

var
  OknoProgramu: TOknoProgramu;

implementation

{$R *.lfm}

{ TPocetCelkem }
constructor TOknoProgramu.TPocetCelkem.Create(_stav: TStatusBar);
begin
  stav := _stav;
  procento:=0;
  Inherited Create(false);
  OnTerminate:=@zobrazVysledek;
end;

procedure TOknoProgramu.TPocetCelkem.zobrazVysledek(Sender: TObject);
begin
   stav.SimpleText:='100 %';
   MessageDlg('Celkový počet řešení', text, mtInformation, [mbOK], 0);
   stav.SimpleText:='';
end;

procedure TOknoProgramu.TPocetCelkem.nastavProcenta;
begin
   stav.SimpleText:=IntToStr(procento) + ' %';
end;

procedure TOknoProgramu.TPocetCelkem.Execute;
var
  lokalniResitel: TResitel;
  text1: string = 'Úloha ';
  aktualni: integer = 0;
begin
  lokalniResitel:=TResitel.Create(Nastaveni.PocetDam);
  procento := 0;
  Synchronize(@nastavProcenta);
  while lokalniResitel.NajdiDalsiReseni do
  begin
    if lokalniResitel.Reseni[0] <> aktualni then
    begin
       aktualni:=lokalniResitel.Reseni[0];
       procento := 100*aktualni div Nastaveni.PocetDam;
       Synchronize(@nastavProcenta);
    end;
  end;
  text := 'Úloha ' + IntToStr(Nastaveni.PocetDam) + ' dam má '
          + IntToStr(lokalniResitel.PocetNalezenychReseni)
          + ' řešení '#13#10'a bylo třeba ' + IntToStr(lokalniResitel.PocetVolani)
          +  ' pokusů o umístění dámy';
  lokalniResitel.Free;
end;

{ TOknoProgramu }

procedure TOknoProgramu.menuNovaClick(Sender: TObject);
begin
  resitel := TResitel.Create(Nastaveni.PocetDam);
end;

procedure TOknoProgramu.menuOProgramuClick(Sender: TObject);
begin
  MessageDlg('O programu', 'Program na řešení úlohy N dam'#13#10'© 2024 Piškvorky software, s.b.r.',mtInformation, [mbYes], '');
end;

procedure TOknoProgramu.menuUpravitClick(Sender: TObject);
begin
  DialogNastaveni.PocetDam:=Nastaveni.PocetDam;
  DialogNastaveni.BarvaDam:=Nastaveni.BarvaDam;
  DialogNastaveni.BarvaCar:=Nastaveni.BarvaCar;
  if DialogNastaveniU.DialogNastaveni.ShowModal = mrOK then
  begin
     Nastaveni.PocetDam:=DialogNastaveni.PocetDam;
     Nastaveni.BarvaDam:=DialogNastaveni.BarvaDam;
     Nastaveni.BarvaCar:=DialogNastaveni.BarvaCar;
     jeReseni:=false;
     if resitel <> nil then
     begin
        resitel.Free;
        resitel := nil;
     end;
     ZmenPovoleni(false);
  end;
end;

procedure TOknoProgramu.tlacitkoNovaUlohaClick(Sender: TObject);
begin
   ZmenPovoleni(true);
   resitel := TResitel.Create(Nastaveni.PocetDam);
   Invalidate;
end;

procedure TOknoProgramu.MenuKonecClick(Sender: TObject);
begin
  Close
end;

procedure TOknoProgramu.kresliciPanelPaint(Sender: TObject);
begin
   NakresliSachovnici(kresliciPanel.Canvas, kresliciPanel.Width, kresliciPanel.Height);
   if jeReseni then
   begin
      NakresliDamy(kresliciPanel.Canvas, kresliciPanel.Width, kresliciPanel.Height);
   end;
end;

procedure TOknoProgramu.menuCelkovyPocetClick(Sender: TObject);
var
  vlakno: TPocetCelkem;
begin
  vlakno := TPocetCelkem.Create(StatusBar1);
end;

procedure TOknoProgramu.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if MessageDlg('Dotaz', 'Opravdu chceš skončit?', mtConfirmation, mbYesNo, 0) = mrNo then
  begin
     CanClose:=false;
  end;
end;

procedure TOknoProgramu.casovacTimer(Sender: TObject);
begin
  jeReseni:=True;
  if not resitel.NajdiDalsiReseni then do begin
    resitel.free;
    resitel := Tresitel.create(nastaveni.PocetDam);
    resitel.NajdiDalsiReseni;
  end;
  Repaint;
end;

procedure TOknoProgramu.menuDalsiReseniClick(Sender: TObject);
begin
  if resitel.NajdiDalsiReseni then
  begin
     jeReseni:=true;
  end else begin
    MessageDlg('Upozornění', 'Další řešení neexistují', mtInformation, [mbOK],0);
    jeReseni:=false;
    ZmenPovoleni(false);
    resitel.Free;
    resitel := nil;
  end;
  Invalidate;
end;

procedure TOknoProgramu.menuIndexClick(Sender: TObject);
var path: string;
begin
  Path:= ExtractFilePath(Application.ExeName) + 'html/index.html'
  openUrl(path);

end;

procedure TOknoProgramu.NakresliSachovnici(Platno: TCanvas; sirka, vyska: integer);
var
  deltaX, deltaY: integer;
  i: integer;
begin
  deltaX := sirka div Nastaveni.PocetDam;
  deltaY := vyska div Nastaveni.PocetDam;
  Platno.Pen.Color:=Nastaveni.BarvaCar;
  Platno.Pen.Width:=1;
  Platno.Line(0,0, sirka, 0);
  for i := 1 to Nastaveni.PocetDam - 1 do
  begin
    Platno.Line(0, i*deltaY, sirka, i*deltaY);
    Platno.Line(i*deltaX, 0, i*deltaX, vyska);
  end;
end;

procedure TOknoProgramu.NakresliDamy(Platno: TCanvas; sirka, vyska: integer);
var
  deltaX, deltaY, x, y: integer;
  i: integer;
const
  delta = 5;
begin
  deltaX := sirka div Nastaveni.PocetDam;
  deltaY := vyska div Nastaveni.PocetDam;
  Platno.Pen.Color:=Nastaveni.BarvaDam;
  Platno.Pen.Width:=3;
  for i := 0 to Nastaveni.PocetDam do
  begin
    y := i * deltaY + delta;
    x := resitel.Reseni[i]*deltaX + delta;
    Platno.Ellipse(x, y, x + deltaX - 2*delta, y + deltaY - 2*delta);
  end;

end;

procedure TOknoProgramu.ZmenPovoleni(jak: Boolean);
begin
  menuDalsiReseni.Enabled:=jak;
  menuCelkovyPocet.Enabled:=jak;
  tlacitkoDalsiReseni.Enabled:=jak;
  tlacitkoCekovyPocet.Enabled:=jak;
end;

end.

