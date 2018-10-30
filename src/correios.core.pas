unit correios.core;

interface

uses Classes, IdHTTP, correios.xml, SysUtils;

type
  TServico = (Sedex = 40010,SedexCobrar = 40045,
             Sedex10 = 40215, SedexHoje = 40290, Pac = 41106);
type
  TFormatoPacote = (Caixa = 1, Rolo = 2, Envelope = 3);

type
  TData = packed record
     CodigoEmpresa: String[20];
     SenhaEmpresa: String[20];
     CodigoServico: TServico;
     CepOrigem: String[8];
     CepDestino: String[8];
     ValorPeso: String[10];
     CodigoFormato: TFormatoPacote;
     ValorAltura: String[10];
     ValorLargura: String[10];
     ValorDiamentro: String[10];
     ValorComprimento: String[10];
     CodigoMaoPropria: String[1];
     ValorDeclarado: string[10];
     AvisoRecebimento: String[1];
end;


type
  TDataController = class(TObject)
  private
    Data: TData;
    IdHttp: TIdHttp;
    XmlEnvio: TXMLEnvio;
    DadosEntrada: TStringList;
    RespostaServidor: TStringStream;
    xmlPath: String;
    Retorno: TRetorno;
    destructor destroy; override;
    procedure inicializarHttp;
    procedure SetDados(Dados: TData);
    procedure TratarDados(Var Dados: TData);
  public
    constructor Create(Data: TData; XmlPath: String = '');
    function Enviar: string;
    function DadosRecebidos: TRetorno;
end;

implementation

{ TDataSender }

constructor TDataController.Create(Data: TData; XmlPath: String = '');
begin
  Self.Data := Data;
  Self.IdHttp := TIdHTTP.Create(nil);
  Self.RespostaServidor := TStringStream.Create;
  Self.DadosEntrada := TStringList.Create;
  Self.RespostaServidor.Clear;
  Self.DadosEntrada.Clear;
  Self.DadosEntrada.TrailingLineBreak := False;
  if not (XmlPath.IsEmpty) then
     Self.xmlPath := XmlPath
  else
     Self.xmlPath :=  ExtractFilePath(ParamStr(0));
  inicializarHttp;
  TratarDados(Self.Data);
  SetDados(Self.Data);
end;

destructor TDataController.destroy;
begin
  Self.IdHttp.Free;
  Self.RespostaServidor.Free;
  Self.DadosEntrada.Free;
  inherited;
end;

procedure TDataController.inicializarHttp;
begin
  IdHttp.Request.CustomHeaders.Clear;
  IdHttp.Request.Clear;
  IdHttp.Request.ContentType := 'application/x-www-form-urlencoded';
  IdHttp.ProtocolVersion := pv1_1;
end;

function TDataController.DadosRecebidos: TRetorno;
begin
  Result := Retorno;
end;

function TDataController.Enviar: string;
const
  URL = 'http://ws.correios.com.br/calculador/CalcPrecoPrazo.asmx/CalcPrecoPrazo';
  XML_FILE = 'xml_resposta.xml';
var
  DadosResposta: TStringList;
  enviador: TXMLEnvio;
begin
  Result := '';
  if self.DadosEntrada.Text = '' then
    exit;
  try
     IdHttp.Post(URL, Self.DadosEntrada, Self.RespostaServidor);
     Result := '0';
     DadosResposta := TStringList.Create;
     try
        DadosResposta.Text := Self.RespostaServidor.DataString;
        DadosResposta.SaveToFile(Self.xmlPath+XML_FILE);
        enviador := TXMLEnvio.create(self.xmlPath+XML_FILE);
        try
           retorno := enviador.retornarDados;
        finally
           enviador.Free;
        end;
     finally
        DadosResposta.Free;
     end;
  except
    on E:EIdHttpProtocolException do
    begin
       result := E.Message + ' - ' + E.ErrorMessage;
       Exit;
    end;
  end;
end;

procedure TDataController.SetDados(Dados: TData);
begin
  Self.DadosEntrada.Values['nCdEmpresa'] :=(Dados.CodigoEmpresa);
  Self.DadosEntrada.Values['sDsSenha']:= (Dados.SenhaEmpresa);
  Self.DadosEntrada.Values['nCdServico'] := (Ord(Dados.CodigoServico).ToString);
  Self.DadosEntrada.Values['sCepOrigem'] := (Dados.CepOrigem);
  Self.DadosEntrada.Values['sCepDestino'] := (Dados.CepDestino);
  Self.DadosEntrada.Values['nVlPeso'] := (Dados.ValorPeso);
  Self.DadosEntrada.Values['nCdFormato'] :=(Ord(Dados.CodigoFormato).ToString);
  Self.DadosEntrada.Values['nVlComprimento'] := (Dados.ValorComprimento);
  Self.DadosEntrada.Values['nVlAltura'] := (Dados.ValorAltura);
  Self.DadosEntrada.Values['nVlLargura'] := (Dados.ValorLargura);
  Self.DadosEntrada.Values['nVlDiametro'] :=(Dados.ValorDiamentro);
  Self.DadosEntrada.Values['sCdMaoPropria'] :=(Dados.CodigoMaoPropria);
  Self.DadosEntrada.Values['nVlValorDeclarado'] :=(Dados.ValorDeclarado);
  Self.DadosEntrada.Values['sCdAvisoRecebimento'] := (Dados.AvisoRecebimento);
end;

procedure TDataController.TratarDados(Var  Dados: TData);
begin
  if Dados.CodigoEmpresa = '' then
     Dados.CodigoEmpresa := ' ';
  if Dados.SenhaEmpresa = '' then
     Dados.SenhaEmpresa := ' ';
  if Dados.CodigoMaoPropria = '' then
     Dados.CodigoMaoPropria := 'N';
  if Dados.ValorDeclarado = '' then
     Dados.ValorDeclarado := '0';
  if Dados.AvisoRecebimento = '' then
     Dados.AvisoRecebimento := 'N'
end;

end.
