unit correios.xml;

interface

uses Classes, XMLDoc, xmldom, XMLIntf, SysUtils, StrUtils;

type
  TDadosRetorno = packed record
    valor: double;
    valorMaoPropria: double;
    valorAvisoRecebimento: double;
    valorDeclarado: double;
    prazoEntraga: String;
    entregaDomiciliar: String;
    entregaSabado: String;
    valorSemAdicionais: double;
    codigoServico: String;
    descricaoServico: String;
  end;

type
  TDadosRetornoErro = packed record
     codigo: integer;
     mensagemErro: String;
  end;

type
  TRetorno = packed record
    dados: TDadosRetorno;
    dadosErro: TDadosRetornoErro;
  end;

type
  TXMLEnvio = class
  private
    xmlDocumento: IXMLDocument;
    dadosRetorno: TDadosRetorno;
    retornoXML: TRetorno;
    xmlCarregado: Boolean;
    function carregarXMLResposta(path: String): boolean;
    procedure lerXml;
  public
    constructor create(xmlPath: String);
    function retornarDados: TRetorno;
  end;

implementation

constructor TXMLEnvio.create(xmlPath: string);
begin
  self.xmlDocumento := TXMLDocument.Create(nil);
  self.xmlCarregado := carregarXMLResposta(xmlPath)
end;

function TXMLEnvio.carregarXMLResposta(path: String): boolean;
begin
   try
      self.xmlDocumento.LoadFromFile(path);
      self.xmlDocumento.Active := true;
      result := true;
   except
      on E:Exception do
      begin
         result := false;
      end;
   end;
end;

procedure TXMLEnvio.lerXml;
var
  Node: IXMLNode;
  i: integer;
begin
  Node := self.xmlDocumento.DocumentElement.ChildNodes.FindNode('Servicos');
  for i := 0 to Node.ChildNodes.Count - 1 do
  begin
    with Node.ChildNodes[i] do
    begin
       if (ChildNodes['Erro'].Text) <> '0' then
       begin
         self.retornoXML.dadosErro.codigo := StrToInt(ChildNodes['Erro'].Text);
         self.retornoXML.dadosErro.mensagemErro := ChildNodes['MsgErro'].Text;
       end
       else
       begin
         if (ChildNodes['Codigo'].Text.Equals('40010')) then
         begin
           self.retornoXML.dados.codigoServico := '40010';
           self.retornoXML.dados.descricaoServico := 'Sedex Varejo';
         end;
         if (ChildNodes['Codigo'].Text.Equals('40045')) then
         begin
           self.retornoXML.dados.codigoServico := '40045';
           self.retornoXML.dados.descricaoServico := 'Sedex a Cobrar Varejo';
         end;
         if (ChildNodes['Codigo'].Text.Equals('40215')) then
         begin
           self.retornoXML.dados.codigoServico := '40215';
           self.retornoXML.dados.descricaoServico := 'Sedex 10 Varejo';
         end;
         if (ChildNodes['Codigo'].Text.Equals('40290')) then
         begin
           self.retornoXML.dados.codigoServico := '40290';
           self.retornoXML.dados.descricaoServico := 'Sedex Hoje Varejo';
         end;
         if (ChildNodes['Codigo'].Text.Equals('41106')) then
         begin
           self.retornoXML.dados.codigoServico := '41106';
           self.retornoXML.dados.descricaoServico := 'Pac Varejo';
         end;
         self.retornoXML.dados.valor := StrToFloat(ChildNodes['Valor'].Text);
         self.retornoXML.dados.valorMaoPropria := StrToFloat(ChildNodes['ValorMaoPropria'].Text);
         self.retornoXML.dados.valorAvisoRecebimento := StrToFloat(ChildNodes['ValorAvisoRecebimento'].Text);
         self.retornoXML.dados.valorDeclarado := StrToFloat(ChildNodes['valorDeclarado'].Text);
         self.retornoXML.dados.valorSemAdicionais := StrToFloat(ChildNodes['valorSemAdicionais'].Text);
         self.retornoXML.dados.prazoEntraga := ChildNodes['PrazoEntrega'].Text + ' dia(s)';
         self.retornoXML.dados.entregaDomiciliar := IfThen(ChildNodes['MaoPropria'].Text.Equals('S'),'SIM','N�O');
         self.retornoXML.dados.entregaSabado := Ifthen(ChildNodes['EntregaSabado'].Text.Equals('S'),'SIM','N�O');
       end;
    end;
  end;
end;

function TXMLEnvio.retornarDados: TRetorno;
begin
  if self.xmlCarregado then
  begin
    lerXml;
    result := self.retornoXML;
  end;
end;

end.
