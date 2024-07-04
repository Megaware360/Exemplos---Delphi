program Project1;

uses
  Vcl.Forms,
  ntCarregaDados in 'ntCarregaDados.pas' {Form1},
  ntPessoa in 'ntPessoa.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
