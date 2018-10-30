program ExampleProj;

uses
  Vcl.Forms,
  Example in 'Example.pas' {FormExample},
  correios.core in '..\src\correios.core.pas',
  correios.xml in '..\src\correios.xml.pas',
  Recebido in 'Recebido.pas' {FrmRecebido},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Windows10');
  Application.CreateForm(TFormExample, FormExample);
  Application.Run;
end.
