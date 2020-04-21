program ExampleProj;

uses
  Vcl.Forms,
  correios.core in 'src\correios\correios.core.pas',
  correios.xml in 'src\correios\correios.xml.pas',
  Vcl.Themes,
  Vcl.Styles,
  Example in 'src\forms\Example.pas' {FormExample},
  Recebido in 'src\forms\Recebido.pas' {FrmRecebido};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Windows10');
  Application.CreateForm(TFormExample, FormExample);
  Application.Run;
end.
