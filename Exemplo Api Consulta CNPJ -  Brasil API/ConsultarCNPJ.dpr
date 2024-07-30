program ConsultarCNPJ;

uses
  Vcl.Forms,
  ntMain in 'ntMain.pas' {Form1},
  ntCNPJAPI in 'ntCNPJAPI.pas',
  ntCNPJAPIRetorno in 'ntCNPJAPIRetorno.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
