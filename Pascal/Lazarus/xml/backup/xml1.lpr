program xml1;

uses Classes, sysutils, XMLRead, XMLWrite, DOM;

var
  dokument: TXMLDocument;
  pocet,cislo,barva_car: TDOMNode;
  hodnota, r: integer;
  koren, otec, syn: TDOMNode;
  //barva: TColor;

begin
  hodnota:=16;
  dokument:= TXMLDocument.Create;
  koren:= dokument.CreateElement('nastaveni');
  dokument.AppendChild(koren);
  otec:= dokument.CreateElement('pocetDam');
  koren.AppendChild(otec);
  syn:= dokument.CreateTextNode(IntToStr(hodnota));
  otec.AppendChild(syn);

  otec:=dokument.CreateElement('barvaCar');
  koren.AppendChild(otec);
  TDOMElement(otec).SetAttribute('r', IntToStr(255));

  WriteXML(dokument, 'data.xml');
  dokument.Free;
end.


