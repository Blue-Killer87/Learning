program damyokno;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, damyokno_okno, nastaveni, damy, dialogNastaveni;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TOkno, Okno);
  Application.CreateForm(TOknoNastaveni, OknoNastaveni);
  Application.Run;
end.

