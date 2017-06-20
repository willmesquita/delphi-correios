unit Example;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, correios.core;

type
  TFormExample = class(TForm)
    Panel1: TPanel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormExample: TFormExample;

implementation

{$R *.dfm}

procedure TFormExample.FormCreate(Sender: TObject);
var
  Consulta: TDataController;
  Dados: TData;
  Retorno: String;
begin
  with Dados do
  begin
    CodigoEmpresa := '';
    SenhaEmpresa := '';
    CodigoServico := Sedex;
    CepOrigem := '88906768';
    CepDestino := '88905355';
    ValorPeso := '5.5';
    CodigoFormato := Caixa;
    ValorAltura := '20.0';
    ValorLargura := '17.0';
    ValorDiamentro := '10.0';
    ValorComprimento := '18.0';
    CodigoMaoPropria := 'N';
    ValorDeclarado := '0';
    AvisoRecebimento := 'N';
  end;
  Consulta := TDataController.Create(Dados);
  try
    retorno := Consulta.Send;
    if Retorno = '0' then
      ShowMessage('ok')
    else
      ShowMessage('error: '+Retorno);
  finally
  end;
end;

end.
