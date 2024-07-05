program ExemploSOAP;

uses
  Vcl.Forms,
  ntCorreios in 'ntCorreios.pas' {FrmExemploSOAP},
  AtendeCliente1 in 'AtendeCliente1.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmExemploSOAP, FrmExemploSOAP);
  Application.Run;
end.
