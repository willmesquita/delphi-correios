unit Recebido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,correios.xml;

type
  TFrmRecebido = class(TForm)
    Panel1: TPanel;
    BtnFechar: TButton;
    Label1: TLabel;
    edtCodigo: TEdit;
    Label2: TLabel;
    edtValor: TEdit;
    Label3: TLabel;
    edtValorRecebimento: TEdit;
    Label4: TLabel;
    edtValorMaoPropria: TEdit;
    Label5: TLabel;
    edtValorDeclarado: TEdit;
    Label6: TLabel;
    edtPrazoEntrega: TEdit;
    Label7: TLabel;
    edtEntregaDomiciliar: TEdit;
    Label8: TLabel;
    edtEntregaSabado: TEdit;
    Label9: TLabel;
    edtValorSemAdicionais: TEdit;
    Label10: TLabel;
    edtServico: TEdit;
    procedure BtnFecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    constructor CreateWithDetail(AOwner: TComponent; Retorno: TRetorno);
  end;

var
  FrmRecebido: TFrmRecebido;

implementation

{$R *.dfm}

{ TFrmRecebido }

procedure TFrmRecebido.BtnFecharClick(Sender: TObject);
begin
  Close;
end;

constructor TFrmRecebido.Create(AOwner: TComponent);
begin
  CreateWithDetail(Owner,DEF_RETURN);
end;

constructor TFrmRecebido.CreateWithDetail(AOwner: TComponent;
  Retorno: TRetorno);
begin
  inherited Create(AOwner);
  if Retorno.dadosErro.codigo <> 0 then
     MessageDLG(Retorno.dadosErro.mensagemErro,mtError,[mbOK],0)
  else
  begin
    edtCodigo.Text := Retorno.dados.codigoServico;
    edtValor.Text := Retorno.dados.valor.ToString;
    edtValorRecebimento.Text := Retorno.dados.valorMaoPropria.ToString;
    edtValorMaoPropria.Text := Retorno.dados.valorMaoPropria.ToString;
    edtValorDeclarado.Text := Retorno.dados.valorDeclarado.ToString;
    edtPrazoEntrega.Text := Retorno.dados.prazoEntraga + ' Dia(s)';
    edtEntregaDomiciliar.Text := Retorno.dados.entregaDomiciliar;
    edtEntregaSabado.Text  := Retorno.dados.entregaSabado;
    edtValorSemAdicionais.Text := Retorno.dados.valorSemAdicionais.ToString;
    edtServico.Text := Retorno.dados.descricaoServico;
  end;
end;

end.
