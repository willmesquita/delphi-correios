unit TesteEnvio;

interface
uses
  DUnitX.TestFramework, correios.core;

type

  [TestFixture]
  TMyTestObject = class(TObject)
  strict private
    Consulta: TDataController;
    DadosEnvio: TData;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    procedure TestaEnvioCaixa;
    [Test]
    procedure TestaEnvioRolo;
    [Test]
    procedure TestaEnvioEnvelope;
  end;

implementation

procedure TMyTestObject.Setup;
begin
//
end;

procedure TMyTestObject.TearDown;
begin
end;

procedure TMyTestObject.TestaEnvioCaixa;
begin
  with DadosEnvio do
  begin
    CodigoServico := TServico.Sedex;
    CepOrigem := '88906768';
    CepDestino := '88811525';
    ValorPeso := '3';
    CodigoFormato := TFormatoPacote.Caixa;
    ValorAltura := '10';
    ValorLargura := '11';
    ValorDiamentro := '3';
    ValorComprimento := '16';
  end;
  Consulta := TDataController.Create(DadosEnvio);
  try
    Assert.AreEqual(Consulta.Enviar, 0,'Ocorreu um erro ao enviar os dados');
  finally
    Consulta.Free;
  end;
end;

procedure TMyTestObject.TestaEnvioEnvelope;
begin
  with DadosEnvio do
  begin
    CodigoServico := TServico.Sedex;
    CepOrigem := '88906768';
    CepDestino := '88811525';
    ValorPeso := '1';
    CodigoFormato := TFormatoPacote.Rolo;
    ValorAltura := '0';
    ValorLargura := '25';
    ValorDiamentro := '10';
    ValorComprimento := '20';
  end;
  Consulta := TDataController.Create(DadosEnvio);
  try
    Assert.AreEqual(Consulta.Enviar, 0,'Ocorreu um erro ao enviar os dados');
  finally
    Consulta.Free;
  end;

end;

procedure TMyTestObject.TestaEnvioRolo;
begin
  with DadosEnvio do
  begin
    CodigoServico := TServico.Sedex;
    CepOrigem := '88906768';
    CepDestino := '88811525';
    ValorPeso := '3';
    CodigoFormato := TFormatoPacote.Envelope;
    ValorAltura := '16';
    ValorLargura := '85';
    ValorDiamentro := '1';
    ValorComprimento := '85';
  end;
  Consulta := TDataController.Create(DadosEnvio);
  try
    Assert.AreEqual(Consulta.Enviar, 0,'Ocorreu um erro ao enviar os dados');
  finally
    Consulta.Free;
  end;

end;

initialization
  TDUnitX.RegisterTestFixture(TMyTestObject);
end.

