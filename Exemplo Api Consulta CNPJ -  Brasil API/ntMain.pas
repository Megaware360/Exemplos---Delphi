unit ntMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Net.HttpClient, System.Net.HttpClientComponent, System.JSON,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    pnlMenu: TPanel;
    pnl1: TPanel;
    pnl2: TPanel;
    mmo1: TMemo;
    btConsulta: TBitBtn;
    dt_CNPJ: TEdit;
    lb1: TLabel;
    procedure btConsultaClick(Sender: TObject);
  private

    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
uses
  ntCNPJAPI,ntCNPJAPIRetorno;



function FormatCNPJ(const CNPJ: string): string;
begin
  Result := Format('%s.%s.%s/%s-%s',
    [Copy(CNPJ, 1, 2), Copy(CNPJ, 3, 3), Copy(CNPJ, 6, 3), Copy(CNPJ, 9, 4), Copy(CNPJ, 13, 2)]);
end;


function RemoverFormatacaoCNPJ(const CNPJ: string): string;
var
  ApenasNumeros: string;
  I: Integer;
begin
  ApenasNumeros := '';
  for I := 1 to Length(CNPJ) do
  begin
    if CNPJ[I] in ['0'..'9'] then
      ApenasNumeros := ApenasNumeros + CNPJ[I];
  end;

  // Verifica se a string resultante tem 14 d�gitos
  if Length(ApenasNumeros) <> 14 then
    raise Exception.Create('CNPJ inv�lido.');

  Result := ApenasNumeros;
end;

procedure TForm1.btConsultaClick(Sender: TObject);
var
  CNPJAPI: TCNPJAPI;
  JSONResponse: TJSONObject;
  CNPJ: string;
  Resultado: TCNPJAPIRETORNO;
  i : Integer;
begin
  CNPJ := RemoverFormatacaoCNPJ(dt_CNPJ.Text); // Substitua pelo CNPJ desejado



  CNPJAPI := TCNPJAPI.Create;
  try
    JSONResponse := CNPJAPI.GetCompanyInfo(CNPJ);
    try
      mmo1.Clear;
      DesserializarJSON(JSONResponse.ToString,Resultado);
      mmo1.Clear;
      mmo1.Lines.Add('CNPJ: ' + FormatCNPJ(Resultado.Cnpj));
      mmo1.Lines.Add('Identificador Matriz/Filial: ' + Resultado.IdentificadorMatrizFilial.ToString);
      mmo1.Lines.Add('Descri��o Matriz/Filial: ' + Resultado.DescricaoMatrizFilial);
      mmo1.Lines.Add('Raz�o Social: ' + Resultado.RazaoSocial);
      mmo1.Lines.Add('Nome Fantasia: ' + Resultado.NomeFantasia);
      mmo1.Lines.Add('Situa��o Cadastral: ' + Resultado.SituacaoCadastral.ToString);
      mmo1.Lines.Add('Descri��o Situa��o Cadastral: ' + Resultado.DescricaoSituacaoCadastral);
      mmo1.Lines.Add('Data Situa��o Cadastral: ' + Resultado.DataSituacaoCadastral);
      mmo1.Lines.Add('Motivo Situa��o Cadastral: ' + Resultado.MotivoSituacaoCadastral.ToString);
      mmo1.Lines.Add('Nome Cidade Exterior: ' + Resultado.NomeCidadeExterior);
      mmo1.Lines.Add('C�digo Natureza Jur�dica: ' + Resultado.CodigoNaturezaJuridica.ToString);
      mmo1.Lines.Add('Data In�cio Atividade: ' + Resultado.DataInicioAtividade);
      mmo1.Lines.Add('CNAE Fiscal: ' + Resultado.CnaeFiscal.ToString);
      mmo1.Lines.Add('Descri��o CNAE Fiscal: ' + Resultado.CnaeFiscalDescricao);
      mmo1.Lines.Add('Descri��o Tipo de Logradouro: ' + Resultado.DescricaoTipoDeLogradouro);
      mmo1.Lines.Add('Logradouro: ' + Resultado.Logradouro);
      mmo1.Lines.Add('N�mero: ' + Resultado.Numero);
      mmo1.Lines.Add('Complemento: ' + Resultado.Complemento);
      mmo1.Lines.Add('Bairro: ' + Resultado.Bairro);
      mmo1.Lines.Add('CEP: ' + Resultado.Cep.ToString);
      mmo1.Lines.Add('UF: ' + Resultado.UF);
      mmo1.Lines.Add('C�digo Munic�pio: ' + Resultado.CodigoMunicipio.ToString);
      mmo1.Lines.Add('Munic�pio: ' + Resultado.Municipio);
      mmo1.Lines.Add('DDD Telefone 1: ' + Resultado.DDDTelefone1);
      mmo1.Lines.Add('DDD Telefone 2: ' + Resultado.DDDTelefone2);
      mmo1.Lines.Add('DDD Fax: ' + Resultado.DDDFax);
      mmo1.Lines.Add('Qualifica��o do Respons�vel: ' + Resultado.QualificacaoDoResponsavel.ToString);
      mmo1.Lines.Add('Capital Social: ' + Resultado.CapitalSocial.ToString);
      mmo1.Lines.Add('Porte: ' + Resultado.Porte);
      mmo1.Lines.Add('Descri��o Porte: ' + Resultado.DescricaoPorte);
      mmo1.Lines.Add('Op��o pelo Simples: ' + BoolToStr(Resultado.OpcaoPeloSimples, True));
      mmo1.Lines.Add('Data Op��o pelo Simples: ' + Resultado.DataOpcaoPeloSimples);
      mmo1.Lines.Add('Data Exclus�o do Simples: ' + Resultado.DataExclusaoDoSimples);
      mmo1.Lines.Add('Op��o pelo MEI: ' + BoolToStr(Resultado.OpcaoPeloMei, True));
      mmo1.Lines.Add('Situa��o Especial: ' + Resultado.SituacaoEspecial);
      mmo1.Lines.Add('Data Situa��o Especial: ' + Resultado.DataSituacaoEspecial);

      mmo1.Lines.Add('');
      mmo1.Lines.Add('CNAEs Secund�rios:');
      for i := 0 to Resultado.CnaesSecundarios.Count - 1 do
      begin
        mmo1.Lines.Add('  C�digo: ' + Resultado.CnaesSecundarios[i].Codigo.ToString + ' - Descri��o: ' + Resultado.CnaesSecundarios[i].Descricao);
      end;

      mmo1.Lines.Add('');
      mmo1.Lines.Add('QSA:');
      for i := 0 to Resultado.Qsa.Count - 1 do
      begin
        mmo1.Lines.Add('  Identificador de S�cio: ' + Resultado.Qsa[i].IdentificadorDeSocio.ToString);
        mmo1.Lines.Add('  Nome S�cio: ' + Resultado.Qsa[i].NomeSocio);
        mmo1.Lines.Add('  CNPJ/CPF do S�cio: ' + Resultado.Qsa[i].CnpjCpfDoSocio);
        mmo1.Lines.Add('  C�digo Qualifica��o S�cio: ' + Resultado.Qsa[i].CodigoQualificacaoSocio.ToString);
        mmo1.Lines.Add('  Percentual Capital Social: ' + Resultado.Qsa[i].PercentualCapitalSocial.ToString);
        mmo1.Lines.Add('  Data Entrada Sociedade: ' + Resultado.Qsa[i].DataEntradaSociedade);
        mmo1.Lines.Add('  CPF Representante Legal: ' + Resultado.Qsa[i].CpfRepresentanteLegal);
        mmo1.Lines.Add('  Nome Representante Legal: ' + Resultado.Qsa[i].NomeRepresentanteLegal);
        mmo1.Lines.Add('  C�digo Qualifica��o Representante Legal: ' + Resultado.Qsa[i].CodigoQualificacaoRepresentanteLegal.ToString);
        mmo1.Lines.Add('');
        mmo1.Top:=0;
      end;

    finally
      JSONResponse.Free;
    end;
  except
    on E: ECNPJAPIException do
      mmo1.Lines.Text := 'Erro: ' + E.Message;
  end;
  CNPJAPI.Free;
end;

end.
