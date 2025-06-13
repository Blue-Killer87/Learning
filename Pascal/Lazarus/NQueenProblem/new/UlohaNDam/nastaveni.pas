unit Nastaveni;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Graphics, Dialogs, XMLWrite, XMLRead, DOM, XPath;

var
  PocetDam: integer;
  BarvaDam: TColor;
  BarvaCar: TColor;


procedure ObnovVychozi;


implementation

const
  VychoziPocetDam =  6 ;
  VychoziBarvaDam: TColor = clRed;
  VychoziBarvaCar: TColor = clBlack;
  jmenoKonfSouboru: string = 'damy.conf';
  jmenoKonfSouboruXML = 'damy.xml';

var
  dokument: TXMLDocument;

procedure ObnovVychozi;
begin
  PocetDam := VychoziPocetDam;
  BarvaDam := VychoziBarvaDam;
  BarvaCar:=VychoziBarvaCar;
end;

procedure ulozNastaveni;
var
  f: file of integer;
begin
  assign(f, jmenoKonfSouboru);
  Rewrite(f);
  write(f, PocetDam, BarvaDam, BarvaCar);
  close(f);
end;

procedure UlozNastaveniXML;
var
  koren, otec, syn: TDOMNode;
  i: integer;
begin
  dokument := TXMLDocument.Create;
  koren := dokument.CreateElement('nastaveni');
  dokument.AppendChild(koren);
  otec := dokument.CreateElement('pocetDam');
  TDomElement(otec).SetAttribute('pocet', IntToStr(pocetDam));
  koren.AppendChild(otec);
  otec := dokument.CreateElement('barvy');
  koren.AppendChild(otec);
  syn := dokument.CreateElement('barvaDam');
  syn.AppendChild(dokument.CreateTextNode(IntToStr(barvaDam)));
  otec.AppendChild(syn);
  syn := dokument.CreateElement('barvaCar');
  syn.AppendChild(dokument.CreateTextNode(IntToStr(barvaCar)));
  otec.AppendChild(syn);
  WriteXMLFile(dokument, jmenoKonfSouboruXML);
  dokument.Free;
end;

procedure NactiNastaveni;
var
  f: file of integer;
begin
  Assign(f, jmenoKonfSouboru);
  Reset(f);
  read(f, PocetDam, BarvaDam, BarvaCar);
  close(f);
end;

procedure NactiNastaveniXML;
var
  nastaveni, pocet, barvy, barva_dam, barva_car: TDOMNode;
  text: string;
  kod: integer;
  vysledek: TXpathVariable;
begin
  {
  ReadXMLFile(dokument, jmenoKonfSouboruXML);
  //nastaveni := dokument.DocumentElement.FindNode('nastaveni');
  pocet :=  dokument.DocumentElement.FindNode('pocetDam');
  text := pocet.Attributes.Item[0].NodeValue;
  Val(text, PocetDam, kod);
  barvy := dokument.DocumentElement.FindNode('barvy');
  barva_dam := barvy.FindNode('barvaDam');
  text := barva_dam.FirstChild.NodeValue;
  Val(text, barvaDam, kod);
  barva_car := barvy.FindNode('barvaCar');
  text := barva_car.FirstChild.NodeValue;
  Val(text, barvaCar, kod);
  dokument.Free;
  }
  ReadXMLFile(dokument, jmenoKonfSouboruXML);
  vysledek := EvaluateXPathExpression('pocetDam/@pocet', dokument.DocumentElement);
  Val(vysledek.AsText, PocetDam, kod);
  vysledek.Free;
  vysledek := EvaluateXPathExpression('/nastaveni/barvy/barvaDam', dokument.DocumentElement);
  Val(vysledek.AsText, BarvaDam, kod);
  vysledek.Free;
  vysledek := EvaluateXPathExpression('/nastaveni/barvy/barvaCar', dokument.DocumentElement);
  Val(vysledek.AsText, BarvaCar, kod);
  vysledek.Free;
  dokument.Free;
end;

initialization
 try
   NactiNastaveniXML;
 except
   MessageDlg('Upozornění', 'Nepodařilo se načíst nastavení,'#13#10'použiji výchozí', mtInformation, [mbOK], 0);
   ObnovVychozi;
 end;
finalization
 try
   //ulozNastaveni;
   UlozNastaveniXML;
 except
   MessageDlg('Upozornění', 'Nepodařilo se uložit nastavení,'#13#10'příště použiji výchozí', mtInformation, [mbOK], 0);
 end;
end.

