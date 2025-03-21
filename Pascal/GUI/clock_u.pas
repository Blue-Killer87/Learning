unit clock_u;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Menus;

type

  { TOkno }

  TOkno = class(TForm)
    nabidka: TPopupMenu;
    MenuStop: TMenuItem;
    MenuSpustit: TMenuItem;
    textcas: TLabel;
    Cas: TTimer;
    procedure CasTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MenuSpustitClick(Sender: TObject);
    procedure MenuStopClick(Sender: TObject);
  private
         hod, min, sec, msec: word;
  public

  end;

var
  Okno: TOkno;

implementation

{$R *.lfm}

{ TOkno }

procedure TOkno.FormCreate(Sender: TObject);
var
  txt: string;
begin
  //DecodeTime(Time, hod, min, sec, msec);
  textcas.Caption:=TimeToStr(Time);
end;

procedure TOkno.MenuSpustitClick(Sender: TObject);
begin
  cas.enabled:=true;
  MenuSpustit.Enabled:=false;
  MenuStop.Enabled:=true;
end;

procedure TOkno.MenuStopClick(Sender: TObject);
begin
  cas.enabled:=false;
  MenuSpustit.Enabled:=true;
  MenuStop.Enabled:=false;
end;

procedure TOkno.CasTimer(Sender: TObject);
begin
     textcas.Caption:=TimeToStr(Time);
end;

end.

