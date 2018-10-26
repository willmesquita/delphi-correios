program ExampleProj;

uses
  Vcl.Forms,
  Example in 'Example.pas' {FormExample},
  correios.core in '..\src\correios.core.pas',
  correios.xml in '..\src\correios.xml.pas',
  Recebido in 'Recebido.pas' {FrmRecebido};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormExample, FormExample);
  Application.CreateForm(TFrmRecebido, FrmRecebido);
  Application.Run;
end.
