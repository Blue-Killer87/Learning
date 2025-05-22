program UlohaNDam;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, Okno, Nastaveni, DialogNastaveniU
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TOknoProgramu, OknoProgramu);
  Application.CreateForm(TDialogNastaveni, DialogNastaveni);
  Application.Run;
end.

