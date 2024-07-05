unit ExemploRestAPI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.OleCtrls,
  SHDocVw, IPPeerClient, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, REST.Response.Adapter, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, Vcl.ExtCtrls, JSON, REST.HttpClient, MaskUtils;

type
  TForm1 = class(TForm)
    pnlMenu: TPanel;
    RESTClient: TRESTClient;
    RESTRequest: TRESTRequest;
    RESTResponse: TRESTResponse;
    TRESTResponseDataSet: TRESTResponseDataSetAdapter;
    bt1: TBitBtn;
    dtCNPJ: TEdit;
    dtSituacao: TEdit;
    lb11: TLabel;
    lb12: TLabel;
    dtTipo: TEdit;
    dtDatCad: TEdit;
    lb1: TLabel;
    dtEmpresa: TEdit;
    lb13: TLabel;
    dtTelefone: TEdit;
    lb111: TLabel;
    dtFantasia: TEdit;
    lb131: TLabel;
    dtCidade: TEdit;
    lb1111: TLabel;
    lb11111: TLabel;
    dtuf: TEdit;
    dtEnd: TEdit;
    lb11112: TLabel;
    dtBairro: TEdit;
    lb111121: TLabel;
    dtNumero: TEdit;
    lb1111211: TLabel;
    dtCep: TEdit;
    lb11112111: TLabel;
    mmo1: TMemo;
    procedure bt1Click(Sender: TObject);
  private
    procedure HandleAPIResponse;
    procedure ShowErrorMessage(const Msg: string);
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


function EliminaFormatacao(sTexto: string): string;
//
// Elimina os caracteres de formatacao da string
// (inclusive os espaзos entre as palavras)
//
var
  iPos: integer;
  iTamanho: integer;
  sTextoSemFormato: string;
  sCaractere: string;
  sCaracMascaras: string;
begin
  Result := sTexto;
  if sTexto = '' then
    begin
      exit;
    end;
  sTextoSemFormato := '';
  sCaracMascaras := './\><_+=[]{}()-$&@*№ІіЈў¬є°Є§,"';
  iTamanho := Length(sTexto);
  for iPos := 1 to iTamanho do
    begin
      sCaractere := Copy(sTexto, iPos, 1);
      if Pos(sCaractere, sCaracMascaras) = 0 then
        begin
          if sCaractere = ' ' then
            Delete(sCaractere, iPos, 1)
          else
            sTextoSemFormato := sTextoSemFormato + sCaractere;
        end;
    end;
  Result := sTextoSemFormato;
end;


procedure TForm1.bt1Click(Sender: TObject);
begin
  // Configura a URL base da API com o CNPJ formatado
  RESTClient.BaseURL := 'https://receitaws.com.br/v1/CNPJ/' + EliminaFormatacao(dtCNPJ.Text);

  try
    // Executa a requisiзгo
    RESTRequest.Execute;

    // Verifica o status da resposta
    if RESTRequest.Response.StatusText = 'Too Many Requests' then
      raise Exception.Create('Nъmero de consultas excedido, tente novamente em alguns instantes.')
    else if RESTRequest.Response.StatusText = 'Timeout' then
      raise Exception.Create('Sem conexгo com o servidor.');

    // Processa a resposta da API
    HandleAPIResponse;
  except
    on E: Exception do
      ShowErrorMessage('Atenзгo: ' + E.Message);
  end;
end;

procedure TForm1.HandleAPIResponse;
var
  jsonObject: TJsonObject;
begin
  jsonObject := TJsonObject.ParseJSONValue(RESTResponse.Content) as TJsonObject;
  try
    if jsonObject.GetValue('status').Value = 'ERROR' then
    begin
      ShowErrorMessage(FormatMaskText('99.999.999/9999-99;0', dtCNPJ.Text) + ' -- ' + jsonObject.GetValue('message').Value);
      Exit;
    end;

    // Preenche os campos com os dados recebidos da API
    dtSituacao.Text := jsonObject.GetValue('situacao').Value;
    dtDatCad.Text := jsonObject.GetValue('data_situacao').Value;
    dtTipo.Text := jsonObject.GetValue('tipo').Value;
    dtEmpresa.Text := jsonObject.GetValue('nome').Value;
    dtTelefone.Text := jsonObject.GetValue('telefone').Value;
    dtFantasia.Text := jsonObject.GetValue('fantasia').Value;
    dtCidade.Text := jsonObject.GetValue('municipio').Value;
    dtuf.Text := jsonObject.GetValue('uf').Value;
    dtEnd.Text := jsonObject.GetValue('logradouro').Value;
    dtBairro.Text := jsonObject.GetValue('bairro').Value;
    dtNumero.Text := jsonObject.GetValue('numero').Value;
    dtCep.Text := jsonObject.GetValue('cep').Value;
  finally
    // Desconecta o cliente REST
    RESTClient.Disconnect;
    jsonObject.Free;
  end;
end;

procedure TForm1.ShowErrorMessage(const Msg: string);
begin
  ShowMessage(Msg);
  mmo1.Lines.Add(Msg);
end;

end.

