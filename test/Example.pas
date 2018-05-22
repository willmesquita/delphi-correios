unit Example;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, correios.core,
  Vcl.StdCtrls, Vcl.Mask;

type
  TFormExample = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    editEmpresa: TEdit;
    Label2: TLabel;
    editSenha: TEdit;
    Label3: TLabel;
    comboEntrega: TComboBox;
    Label4: TLabel;
    editCepOrigem: TMaskEdit;
    Label5: TLabel;
    editCepDestino: TMaskEdit;
    Label6: TLabel;
    Label7: TLabel;
    comboFormato: TComboBox;
    editPeso: TMaskEdit;
    btnEnviar: TButton;
    btnCancelar: TButton;
    Label8: TLabel;
    editAltura: TMaskEdit;
    Label9: TLabel;
    editLargura: TMaskEdit;
    editComprimento: TMaskEdit;
    Label10: TLabel;
    Label11: TLabel;
    editDiametro: TMaskEdit;
    Label12: TLabel;
    editValorDeclarado: TMaskEdit;
    checkMaoPropria: TCheckBox;
    checkAvisoRecebimento: TCheckBox;
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
    ValorAltura := '1323.0';
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
