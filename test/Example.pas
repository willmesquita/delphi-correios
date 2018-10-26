unit Example;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, correios.core,
  Vcl.StdCtrls, Vcl.Mask, StrUtils;

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
    procedure btnCancelarClick(Sender: TObject);
    procedure btnEnviarClick(Sender: TObject);
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

uses Recebido;

procedure TFormExample.btnCancelarClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFormExample.btnEnviarClick(Sender: TObject);
var
  Consulta: TDataController;
  Dados: TData;
  Retorno: String;
begin
  with Dados do
  begin
    CodigoEmpresa := editEmpresa.Text;
    SenhaEmpresa := editSenha.Text;
    CodigoServico := TServico(comboEntrega.Items.IndexOfObject(TObject(comboEntrega.ItemIndex)));
    CepOrigem := editCepOrigem.Text;
    CepDestino := editCepDestino.Text;
    ValorPeso := editPeso.Text;
    CodigoFormato := TFormatoPacote(comboFormato.Items.IndexOfObject(TObject(comboFormato.ItemIndex)));
    ValorAltura := editAltura.Text;
    ValorLargura := editLargura.Text;
    ValorDiamentro := editDiametro.Text;
    ValorComprimento := editComprimento.Text;
    CodigoMaoPropria := ifThen(checkMaoPropria.Checked,'S','N');
    ValorDeclarado := editValorDeclarado.Text;
    AvisoRecebimento := ifThen(checkAvisoRecebimento.Checked,'S','N');
  end;

 Consulta := TDataController.Create(Dados);
  try
    retorno := Consulta.Send;
    if Retorno = '0' then
    begin
      FrmRecebido := TFrmRecebido.CreateWithDetail(nil,Consulta.Recieved);
      try
        Consulta.Recieved;
        FrmRecebido.ShowModal;
      finally
        FrmRecebido.Free;
      end;
    end
    else
      ShowMessage('error: '+Retorno);
  finally

  end;
end;

procedure TFormExample.FormCreate(Sender: TObject);
begin
  comboEntrega.AddItem('40010 - SEDEX',TObject(TServico.Sedex));
  comboEntrega.AddItem('40045 - SEDEX A COBRAR',TObject(TServico.SedexCobrar));
  comboEntrega.AddItem('40215 - SEDEX 10',TObject(TServico.Sedex10));
  comboEntrega.AddItem('40290 - SEDEX HOJE',TObject(TServico.SedexHoje));
  comboEntrega.AddItem('41106 - PAC',TObject(TServico.Pac));

  comboFormato.AddItem('CAIXA',TObject(TFormatoPacote.Caixa));
  comboFormato.AddItem('ROLO',TObject(TFormatoPacote.Rolo));
  comboFormato.AddItem('ENVELOPE',TObject(TFormatoPacote.Envelope));
end;

end.


