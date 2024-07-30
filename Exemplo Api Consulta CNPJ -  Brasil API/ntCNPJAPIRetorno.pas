unit ntCNPJAPIRetorno;

interface

uses
  System.JSON, System.Generics.Collections, System.SysUtils;

type
  TCnaeSecundario = class
  private
    FCodigo: Integer;
    FDescricao: string;
  public
    property Codigo: Integer read FCodigo write FCodigo;
    property Descricao: string read FDescricao write FDescricao;
  end;

  TQsa = class
  private
    FIdentificadorDeSocio: Integer;
    FNomeSocio: string;
    FCnpjCpfDoSocio: string;
    FCodigoQualificacaoSocio: Integer;
    FPercentualCapitalSocial: Integer;
    FDataEntradaSociedade: string;
    FCpfRepresentanteLegal: string;
    FNomeRepresentanteLegal: string;
    FCodigoQualificacaoRepresentanteLegal: Integer;
  public
    property IdentificadorDeSocio: Integer read FIdentificadorDeSocio write FIdentificadorDeSocio;
    property NomeSocio: string read FNomeSocio write FNomeSocio;
    property CnpjCpfDoSocio: string read FCnpjCpfDoSocio write FCnpjCpfDoSocio;
    property CodigoQualificacaoSocio: Integer read FCodigoQualificacaoSocio write FCodigoQualificacaoSocio;
    property PercentualCapitalSocial: Integer read FPercentualCapitalSocial write FPercentualCapitalSocial;
    property DataEntradaSociedade: string read FDataEntradaSociedade write FDataEntradaSociedade;
    property CpfRepresentanteLegal: string read FCpfRepresentanteLegal write FCpfRepresentanteLegal;
    property NomeRepresentanteLegal: string read FNomeRepresentanteLegal write FNomeRepresentanteLegal;
    property CodigoQualificacaoRepresentanteLegal: Integer read FCodigoQualificacaoRepresentanteLegal write FCodigoQualificacaoRepresentanteLegal;
  end;

  TCNPJAPIRETORNO = class
  private
    FCnpj: string;
    FIdentificadorMatrizFilial: Integer;
    FDescricaoMatrizFilial: string;
    FRazaoSocial: string;
    FNomeFantasia: string;
    FSituacaoCadastral: Integer;
    FDescricaoSituacaoCadastral: string;
    FDataSituacaoCadastral: string;
    FMotivoSituacaoCadastral: Integer;
    FNomeCidadeExterior: string;
    FCodigoNaturezaJuridica: Integer;
    FDataInicioAtividade: string;
    FCnaeFiscal: Integer;
    FCnaeFiscalDescricao: string;
    FDescricaoTipoDeLogradouro: string;
    FLogradouro: string;
    FNumero: string;
    FComplemento: string;
    FBairro: string;
    FCep: Integer;
    FUF: string;
    FCodigoMunicipio: Integer;
    FMunicipio: string;
    FDDDTelefone1: string;
    FDDDTelefone2: string;
    FDDDFax: string;
    FQualificacaoDoResponsavel: Integer;
    FCapitalSocial: Integer;
    FPorte: string;
    FDescricaoPorte: string;
    FOpcaoPeloSimples: Boolean;
    FDataOpcaoPeloSimples: string;
    FDataExclusaoDoSimples: string;
    FOpcaoPeloMei: Boolean;
    FSituacaoEspecial: string;
    FDataSituacaoEspecial: string;
    FCnaesSecundarios: TObjectList<TCnaeSecundario>;
    FQsa: TObjectList<TQsa>;
  public
    constructor Create;
    destructor Destroy; override;

    property Cnpj: string read FCnpj write FCnpj;
    property IdentificadorMatrizFilial: Integer read FIdentificadorMatrizFilial write FIdentificadorMatrizFilial;
    property DescricaoMatrizFilial: string read FDescricaoMatrizFilial write FDescricaoMatrizFilial;
    property RazaoSocial: string read FRazaoSocial write FRazaoSocial;
    property NomeFantasia: string read FNomeFantasia write FNomeFantasia;
    property SituacaoCadastral: Integer read FSituacaoCadastral write FSituacaoCadastral;
    property DescricaoSituacaoCadastral: string read FDescricaoSituacaoCadastral write FDescricaoSituacaoCadastral;
    property DataSituacaoCadastral: string read FDataSituacaoCadastral write FDataSituacaoCadastral;
    property MotivoSituacaoCadastral: Integer read FMotivoSituacaoCadastral write FMotivoSituacaoCadastral;
    property NomeCidadeExterior: string read FNomeCidadeExterior write FNomeCidadeExterior;
    property CodigoNaturezaJuridica: Integer read FCodigoNaturezaJuridica write FCodigoNaturezaJuridica;
    property DataInicioAtividade: string read FDataInicioAtividade write FDataInicioAtividade;
    property CnaeFiscal: Integer read FCnaeFiscal write FCnaeFiscal;
    property CnaeFiscalDescricao: string read FCnaeFiscalDescricao write FCnaeFiscalDescricao;
    property DescricaoTipoDeLogradouro: string read FDescricaoTipoDeLogradouro write FDescricaoTipoDeLogradouro;
    property Logradouro: string read FLogradouro write FLogradouro;
    property Numero: string read FNumero write FNumero;
    property Complemento: string read FComplemento write FComplemento;
    property Bairro: string read FBairro write FBairro;
    property Cep: Integer read FCep write FCep;
    property UF: string read FUF write FUF;
    property CodigoMunicipio: Integer read FCodigoMunicipio write FCodigoMunicipio;
    property Municipio: string read FMunicipio write FMunicipio;
    property DDDTelefone1: string read FDDDTelefone1 write FDDDTelefone1;
    property DDDTelefone2: string read FDDDTelefone2 write FDDDTelefone2;
    property DDDFax: string read FDDDFax write FDDDFax;
    property QualificacaoDoResponsavel: Integer read FQualificacaoDoResponsavel write FQualificacaoDoResponsavel;
    property CapitalSocial: Integer read FCapitalSocial write FCapitalSocial;
    property Porte: string read FPorte write FPorte;
    property DescricaoPorte: string read FDescricaoPorte write FDescricaoPorte;
    property OpcaoPeloSimples: Boolean read FOpcaoPeloSimples write FOpcaoPeloSimples;
    property DataOpcaoPeloSimples: string read FDataOpcaoPeloSimples write FDataOpcaoPeloSimples;
    property DataExclusaoDoSimples: string read FDataExclusaoDoSimples write FDataExclusaoDoSimples;
    property OpcaoPeloMei: Boolean read FOpcaoPeloMei write FOpcaoPeloMei;
    property SituacaoEspecial: string read FSituacaoEspecial write FSituacaoEspecial;
    property DataSituacaoEspecial: string read FDataSituacaoEspecial write FDataSituacaoEspecial;
    property CnaesSecundarios: TObjectList<TCnaeSecundario> read FCnaesSecundarios write FCnaesSecundarios;
    property Qsa: TObjectList<TQsa> read FQsa write FQsa;
  end;

   procedure DesserializarJSON(const JSONStr: string; out Resultado: TCNPJAPIRETORNO);

implementation

constructor TCNPJAPIRETORNO.Create;
begin
  inherited Create;
  FCnaesSecundarios := TObjectList<TCnaeSecundario>.Create;
  FQsa := TObjectList<TQsa>.Create;
end;

destructor TCNPJAPIRETORNO.Destroy;
begin
  FCnaesSecundarios.Free;
  FQsa.Free;
  inherited Destroy;
end;

procedure DesserializarJSON(const JSONStr: string; out Resultado: TCNPJAPIRETORNO);
var
  JSONObject: TJSONObject;
  JSONArray: TJSONArray;
  i: Integer;
  CnaeSecundario: TCnaeSecundario;
  QsaItem: TQsa;
begin
  JSONObject := TJSONObject.ParseJSONValue(JSONStr) as TJSONObject;
  try
    if not Assigned(JSONObject) then
      raise Exception.Create('Erro ao parsear JSON.');

    Resultado := TCNPJAPIRETORNO.Create;
    try
      Resultado.Cnpj := JSONObject.GetValue<string>('cnpj');
      Resultado.IdentificadorMatrizFilial := JSONObject.GetValue<Integer>('identificador_matriz_filial');
      Resultado.DescricaoMatrizFilial := JSONObject.GetValue<string>('descricao_identificador_matriz_filial');
      Resultado.RazaoSocial := JSONObject.GetValue<string>('razao_social');
      Resultado.NomeFantasia := JSONObject.GetValue<string>('nome_fantasia');
      Resultado.SituacaoCadastral := JSONObject.GetValue<Integer>('situacao_cadastral');
      Resultado.DescricaoSituacaoCadastral := JSONObject.GetValue<string>('descricao_situacao_cadastral');
      Resultado.DataSituacaoCadastral := JSONObject.GetValue<string>('data_situacao_cadastral');
      Resultado.MotivoSituacaoCadastral := JSONObject.GetValue<Integer>('motivo_situacao_cadastral');
      Resultado.NomeCidadeExterior := JSONObject.GetValue<string>('nome_cidade_no_exterior');
      Resultado.CodigoNaturezaJuridica := JSONObject.GetValue<Integer>('codigo_natureza_juridica');
      Resultado.DataInicioAtividade := JSONObject.GetValue<string>('data_inicio_atividade');
      Resultado.CnaeFiscal := JSONObject.GetValue<Integer>('cnae_fiscal');
      Resultado.CnaeFiscalDescricao := JSONObject.GetValue<string>('cnae_fiscal_descricao');
      Resultado.DescricaoTipoDeLogradouro := JSONObject.GetValue<string>('descricao_tipo_de_logradouro');
      Resultado.Logradouro := JSONObject.GetValue<string>('logradouro');
      Resultado.Numero := JSONObject.GetValue<string>('numero');
      Resultado.Complemento := JSONObject.GetValue<string>('complemento');
      Resultado.Bairro := JSONObject.GetValue<string>('bairro');
      Resultado.Cep := JSONObject.GetValue<Integer>('cep');
      Resultado.UF := JSONObject.GetValue<string>('uf');
      Resultado.CodigoMunicipio := JSONObject.GetValue<Integer>('codigo_municipio');
      Resultado.Municipio := JSONObject.GetValue<string>('municipio');
      Resultado.DDDTelefone1 := JSONObject.GetValue<string>('ddd_telefone_1');
      Resultado.DDDTelefone2 := JSONObject.GetValue<string>('ddd_telefone_2');
      Resultado.DDDFax := JSONObject.GetValue<string>('ddd_fax');
      Resultado.QualificacaoDoResponsavel := JSONObject.GetValue<Integer>('qualificacao_do_responsavel');
      Resultado.CapitalSocial := JSONObject.GetValue<Integer>('capital_social');
      Resultado.Porte := JSONObject.GetValue<string>('porte');
      Resultado.DescricaoPorte := JSONObject.GetValue<string>('descricao_porte');
      Resultado.DataOpcaoPeloSimples := JSONObject.GetValue<string>('data_opcao_pelo_simples');
      Resultado.DataExclusaoDoSimples := JSONObject.GetValue<string>('data_exclusao_do_simples');

      Resultado.SituacaoEspecial := JSONObject.GetValue<string>('situacao_especial');
      Resultado.DataSituacaoEspecial := JSONObject.GetValue<string>('data_situacao_especial');

      // Verifica se o valor é nulo antes de atribuir
      if JSONObject.GetValue('opcao_pelo_simples') is TJSONBool then
        Resultado.OpcaoPeloSimples := JSONObject.GetValue<Boolean>('opcao_pelo_simples');

      // Verifica se o valor é nulo antes de atribuir
      if JSONObject.GetValue('opcao_pelo_mei') is TJSONBool then
        Resultado.OpcaoPeloMei := JSONObject.GetValue<Boolean>('opcao_pelo_mei');




      // Processar a lista de CNAEs Secundários
      JSONArray := JSONObject.GetValue<TJSONArray>('cnaes_secundarios');
      if Assigned(JSONArray) then
      begin
        for i := 0 to JSONArray.Count - 1 do
        begin
          CnaeSecundario := TCnaeSecundario.Create;
          CnaeSecundario.Codigo := JSONArray.Items[i].GetValue<Integer>('codigo');
          CnaeSecundario.Descricao := JSONArray.Items[i].GetValue<string>('descricao');
          Resultado.CnaesSecundarios.Add(CnaeSecundario);
        end;
      end;

      // Processar a lista de QSA
      JSONArray := JSONObject.GetValue<TJSONArray>('qsa');
      if Assigned(JSONArray) then
      begin
        for i := 0 to JSONArray.Count - 1 do
        begin
          QsaItem := TQsa.Create;
          QsaItem.IdentificadorDeSocio := JSONArray.Items[i].GetValue<Integer>('identificador_de_socio');
          QsaItem.NomeSocio := JSONArray.Items[i].GetValue<string>('nome_socio');
          QsaItem.CnpjCpfDoSocio := JSONArray.Items[i].GetValue<string>('cnpj_cpf_do_socio');
          QsaItem.CodigoQualificacaoSocio := JSONArray.Items[i].GetValue<Integer>('codigo_qualificacao_socio');
         // QsaItem.PercentualCapitalSocial := JSONArray.Items[i].GetValue<Integer>('percentual_capital_social');
          QsaItem.DataEntradaSociedade := JSONArray.Items[i].GetValue<string>('data_entrada_sociedade');
          QsaItem.CpfRepresentanteLegal := JSONArray.Items[i].GetValue<string>('cpf_representante_legal');
          QsaItem.NomeRepresentanteLegal := JSONArray.Items[i].GetValue<string>('nome_representante_legal');
          QsaItem.CodigoQualificacaoRepresentanteLegal := JSONArray.Items[i].GetValue<Integer>('codigo_qualificacao_representante_legal');
          Resultado.Qsa.Add(QsaItem);
        end;
      end;

    except
      on E: Exception do
      begin
        Resultado.Free;
        raise Exception.CreateFmt('Erro ao desserializar JSON: %s', [E.Message]);
      end;
    end;
  finally
    JSONObject.Free;
  end;
end;

end.

