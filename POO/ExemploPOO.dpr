program ExemploPOO;

uses
  Vcl.Forms,
  ntCarregaDados in 'ntCarregaDados.pas' {FrmPOO},
  ntPessoa in 'ntPessoa.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPOO, FrmPOO);
  Application.Run;
end.
