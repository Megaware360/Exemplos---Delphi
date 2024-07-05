program ExemploSOAP;

uses
  Vcl.Forms,
  ntCorreios in 'ntCorreios.pas' {FrmExemploSOAP},
  WSCliente in 'WSCliente.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmExemploSOAP, FrmExemploSOAP);
  Application.Run;
end.
