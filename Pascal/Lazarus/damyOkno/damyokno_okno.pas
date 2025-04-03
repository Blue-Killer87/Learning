unit damyokno_okno;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ExtCtrls,
  ComCtrls, StdCtrls, nastaveni, damy, dialogNastaveni;

type

  { TOkno }

  TOkno = class(TForm)
    hlavnimenu: TMainMenu;
    ImageList1: TImageList;
    Label1: TLabel;
    MenuCelkovyPocet: TMenuItem;
    MenuOProgramu: TMenuItem;
    MenuNapoveda: TMenuItem;
    MenuVychoziNastaveni: TMenuItem;
    MenuUpravit: TMenuItem;
    MenuNastaveni: TMenuItem;
    MenuKonec: TMenuItem;
    MenuNajdiDalsi: TMenuItem;
    MenuNova: TMenuItem;
    menuUloha: TMenuItem;
    Panel1: TPanel;
    ProgressBar1: TProgressBar;
    Separator1: TMenuItem;
    PanelNastroju: TToolBar;
    StavovaRadka: TStatusBar;

    TlacitkoNova: TToolButton;
    TlacitkoDalsiReseni: TToolButton;
    TlacitkoCelkem: TToolButton;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure MenuCelkovyPocetClick(Sender: TObject);
    procedure MenuKonecClick(Sender: TObject);
    procedure MenuNajdiDalsiClick(Sender: TObject);
    procedure MenuNovaClick(Sender: TObject);
    procedure MenuOProgramuClick(Sender: TObject);
    procedure menuUlohaClick(Sender: TObject);
    procedure MenuUpravitClick(Sender: TObject);
    procedure MenuVychoziNastaveniClick(Sender: TObject);
    procedure Panel1Paint(sender: TObject);
    procedure PanelNastrojuClick(Sender: TObject);

private
    var
        resitel: TResitel;
        jeResitel: Boolean;
        jereseni: boolean;
        deltax, deltay: integer;

    procedure nakresliSachovnici(plocha:TCanvas; sirka, vyska: integer);
    procedure nakresliDamy(plocha:TCanvas; sirka, vyska: integer);
public

  end;

var
  Okno: TOkno;

implementation

{$R *.lfm}

{ TOkno }

procedure TOkno.FormCreate(Sender: TObject);
begin
    jeResitel:=False;
    jereseni:=false;

end;

procedure TOkno.Label1Click(Sender: TObject);
begin

end;

procedure TOkno.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if MessageDlg('Dotaz', 'Opravdu chcete ukončit program?', mtConfirmation, mbYesNo, 0) = mrNo then begin
       CanClose:=False;
  end;
end;

procedure TOkno.MenuCelkovyPocetClick(Sender: TObject);
var
  lokalniresitel: TResitel;
  zprava: string;
const
  text1: String = 'Úloha ';
  text2: String = 'dam má ';
  text3: String = 'řešení. #13#10Bylo třeba';
  text4: String = ' pokusů o umístění dámy.';

begin
  lokalniresitel := TResitel.Create(nastaveni.PocetDam);
  lokalniresitel.NajdiDalsiReseni;
  zprava := text1+IntToStr(nastaveni.PocetDam)+text2+IntToStr(lokalniresitel.PocetNalezenychReseni)
         + text3+IntToStr(lokalniresitel.PocetVolani)+text4;
  MessageDlg('Celkový počet řešení', zprava, mtInformation, [mbOK], 0);
  lokalniresitel.free;
end;

procedure TOkno.MenuKonecClick(Sender: TObject);
begin
  Close;
end;

procedure TOkno.MenuNajdiDalsiClick(Sender: TObject);
begin
  if resitel.NajdiDalsiReseni then
  begin
       jereseni:= true;

  end else begin
      jereseni:=false;
      resitel.free;
      jeresitel := false;
      Application.MessageBox('Další řešení neexistují', 'Upozornění');
  end;
  Repaint;
end;

procedure TOkno.MenuNovaClick(Sender: TObject);
begin
    resitel:=TResitel.Create(nastaveni.PocetDam);
    jeResitel:=true;

end;

procedure TOkno.MenuOProgramuClick(Sender: TObject);
begin
  Application.MessageBox('program na řešení úlohy N dam'#13#10#169'Piškvorky software 2025', 'O programu');
end;

procedure TOkno.menuUlohaClick(Sender: TObject);
begin

end;

procedure TOkno.MenuUpravitClick(Sender: TObject);
begin
    if OknoNastaveni.ShowModal = mrOk then begin

    end;
end;

procedure TOkno.MenuVychoziNastaveniClick(Sender: TObject);
begin
  nastaveni.VychoziNastaveni;
end;

procedure TOkno.Panel1Paint(sender: TObject);
begin
    if jeresitel then
    begin
         nakreslisachovnici(Panel1.Canvas, Panel1.Width, Panel1.Height);
         if jereseni then
         begin
              nakresliDamy(panel1.canvas, Panel1.width, panel1.height);
         end;
    end;
end;

procedure TOkno.PanelNastrojuClick(Sender: TObject);
begin

end;

procedure TOkno.nakresliSachovnici(plocha: TCanvas; sirka, vyska: integer);
var
  i: integer;
begin
    deltax := sirka div Nastaveni.PocetDam;
    deltay := vyska div Nastaveni.PocetDam;
    plocha.pen.Width:=1;
    plocha.pen.color:= nastaveni.barvacar;

    for i := 0 to Nastaveni.pocetdam do
    begin
        plocha.Line(0, deltay*i, sirka, deltay*i);
        plocha.Line(i*deltax,0,i*deltax, vyska);
    end;
end;

procedure TOkno.nakresliDamy(plocha:TCanvas; sirka, vyska: integer);
var i, j: integer;
const delta =5;
begin
     plocha.Pen.width:=1;
     plocha.pen.color := nastaveni.BarvaDam;
     for i := 0 to nastaveni.PocetDam -1 do begin
         j := resitel.Reseni[i];
         plocha.Ellipse(i*deltax + delta, j*deltay + delta, (i+1)*deltax - delta, (i+1)*deltay - delta);
     end;
end;

end.

