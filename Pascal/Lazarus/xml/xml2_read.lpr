program xml2_read;

uses Classes, sysutils, XMLRead, DOM;

var
  dokument: TXMLDocument;
  pocet, cislo, barvacar: TDOMNode;
  hodnota, r: integer;

begin
  ReadXMLFile(dokument, 'data.xml');
  pocet:= dokument.DocumentElement.FindNode('pocetDam');
  cislo:= pocet.FirstChild;
  hodnota:= strtoint(trim(cislo.NodeValue));
  Writeln('Počet dam: ',hodnota);

  barvacar:= dokument.DocumentElement.FindNode('barvaCar');
  r:=strtoint(trim(barvacar.Attributes[0].NodeValue));
  writeln('Barva čar: ', r)
end.

