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
    procedure limparDados;
    function retornarDados: TRetorno;
  end;

const
  DEF_RETURN : TRetorno = (dados: (valor: 0;
                                   valorMaoPropria : 0;
                                   valorAvisoRecebimento: 0;
                                   valorDeclarado: 0;
                                   prazoEntraga: '';
                                   entregaDomiciliar: '';
                                   entregaSabado: '';
                                   valorSemAdicionais: 0;
                                   codigoServico: '';
                                   descricaoServico: '');
                           dadosErro: (codigo: 0; mensagemErro: ''));

implementation

constructor TXMLEnvio.create(xmlPath: string);
begin
  self.xmlDocumento := TXMLDocument.Create(nil);
  self.xmlCarregado := carregarXMLResposta(xmlPath);
end;

function TXMLEnvio.carregarXMLResposta(path: String): boolean;
begin
   result := true;
   try
      self.xmlDocumento.LoadFromFile(path);
      self.xmlDocumento.Active := true;
   except
      on E:Exception do
      begin
         result := false;
         E.Create('Erro ao carregar xml de resposta');
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
         self.retornoXML.dados.valor := StrToFloatDef(ChildNodes['Valor'].Text,0);
         self.retornoXML.dados.valorMaoPropria := StrToFloatDef(ChildNodes['ValorMaoPropria'].Text,0);
         self.retornoXML.dados.valorAvisoRecebimento := StrToFloatDef(ChildNodes['ValorAvisoRecebimento'].Text,0);
         self.retornoXML.dados.valorDeclarado := StrToFloatDef(ChildNodes['valorDeclarado'].Text.Replace(',','.'),0);
         self.retornoXML.dados.valorSemAdicionais := StrToFloatDef(ChildNodes['valorSemAdicionais'].Text.Replace(',','.'),0);
         self.retornoXML.dados.prazoEntraga := ChildNodes['PrazoEntrega'].Text + ' dia(s)';
         self.retornoXML.dados.entregaDomiciliar := IfThen(ChildNodes['MaoPropria'].Text.Equals('S'),'SIM','NÃO');
         self.retornoXML.dados.entregaSabado := Ifthen(ChildNodes['EntregaSabado'].Text.Equals('S'),'SIM','NÃO');
       end;
    end;
  end;
end;

procedure TXMLEnvio.limparDados;
begin
  Self.dadosRetorno.valor := 0;
  Self.dadosRetorno.valorMaoPropria := 0;
  Self.dadosRetorno.valorAvisoRecebimento := 0;
  Self.dadosRetorno.valorDeclarado := 0;
  Self.dadosRetorno.prazoEntraga := '';
  Self.dadosRetorno.entregaDomiciliar := '';
  Self.dadosRetorno.entregaSabado := '';
  Self.dadosRetorno.valorSemAdicionais := 0;
  Self.dadosRetorno.codigoServico := '';
  Self.dadosRetorno.descricaoServico := '';
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
