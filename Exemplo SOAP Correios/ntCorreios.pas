unit ntCorreios;


{*******************************************************************************}
{ Projeto: Correios                                                             }
{ Desenvolvido por David Willian Lopes Brito                                    }
{ Email: Lopes.willian@hotmail.com                                              }
{                                                                               }
{*******************************************************************************}


interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WSCliente, Vcl.StdCtrls,
  Vcl.Buttons, Soap.InvokeRegistry, Soap.Rio, Soap.SOAPHTTPClient, Vcl.ComCtrls;

type
  TFrmExemploSOAP = class(TForm)
    bt1: TBitBtn;
    HTTPRIO1: THTTPRIO;
    Memo1: TMemo;
    Edit1: TEdit;
    pgc1: TPageControl;
    Menu: TTabSheet;
    dtUsuario: TEdit;
    dtSenha: TEdit;
    dtCodAdminis: TEdit;
    dtContrato: TEdit;
    dtCartao: TEdit;
    dtCnpj: TEdit;
    lbSenha: TLabel;
    lbCodAdm: TLabel;
    lbContrato: TLabel;
    lbCartao: TLabel;
    lbCNPJ: TLabel;
    lbCep: TLabel;
    chkCep: TCheckBox;
    dtCepOrig: TEdit;
    dtCepDest: TEdit;
    lbCepOri: TLabel;
    chkDspServ: TCheckBox;
    procedure bt1Click(Sender: TObject);
    procedure chkCepClick(Sender: TObject);
    procedure chkDspServClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmExemploSOAP: TFrmExemploSOAP;

implementation

{$R *.dfm}

procedure TFrmExemploSOAP.bt1Click(Sender: TObject);
var
  cep,Servico: AtendeCliente;
  RetornoCep: enderecoERP;
  Retorno: String;
begin
  if chkCep.Checked then
  begin
    try
      RetornoCep := enderecoERP.Create;
      cep := GetAtendeCliente(False, '', HTTPRIO1);
      RetornoCep := cep.consultaCEP(Trim(Edit1.Text), dtUsuario.Text, dtSenha.Text);

      Memo1.Lines.Add(RetornoCep.cidade + '/' + RetornoCep.uf);
      Memo1.Lines.Add(RetornoCep.cep);
      Memo1.Lines.Add(RetornoCep.bairro);
      Memo1.Lines.Add(RetornoCep.end_);
      Memo1.Lines.Add(RetornoCep.complemento2);
      Memo1.Lines.Add('-------------------');
    except
      on E: ERemotableException do
      begin
        Memo1.Lines.Add('-----' + E.Message + '-----');
      end;
    end;
  end;

  if chkDspServ.Checked then
  begin
    try
      Servico := GetAtendeCliente(False, '', HTTPRIO1);
      Retorno := Servico.verificaDisponibilidadeServico(StrToInt(dtCodAdminis.Text),
        '4677 ', dtCepOrig.Text, dtCepDest.Text, dtUsuario.Text, dtSenha.Text);

      if Retorno = '0#' then
        Memo1.Lines.Add('Existe Disponibilidade de Servico para o trajeto informado!')
      else
        Memo1.Lines.Add(Retorno);
    except
      on E: ERemotableException do
      begin
        Memo1.Lines.Add('-----' + E.Message + '-----');
      end;
    end;
  end;
end;

procedure TFrmExemploSOAP.chkCepClick(Sender: TObject);
begin
  Edit1.Enabled := chkCep.Checked;
end;

procedure TFrmExemploSOAP.chkDspServClick(Sender: TObject);
begin
  dtCepOrig.Enabled := chkDspServ.Checked;
  dtCepDest.Enabled := chkDspServ.Checked;
end;

end.

