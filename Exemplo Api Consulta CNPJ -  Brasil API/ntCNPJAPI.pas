unit ntCNPJAPI;

interface

uses
  System.SysUtils, System.Classes, System.Net.HttpClient, System.JSON;

type
  ECNPJAPIException = class(Exception);

  TCNPJAPI = class
  private
    FHttpClient: THTTPClient;
    FBaseURL: string;
    function GetCNPJInfo(const ACNPJ: string): string;
  public
    constructor Create;
    destructor Destroy; override;
    function GetCompanyInfo(const ACNPJ: string): TJSONObject;
  end;

implementation

constructor TCNPJAPI.Create;
begin
  inherited Create;
  FBaseURL := 'https://brasilapi.com.br/api/cnpj/v1/';
  FHttpClient := THTTPClient.Create;
end;

destructor TCNPJAPI.Destroy;
begin
  FHttpClient.Free;
  inherited Destroy;
end;

function TCNPJAPI.GetCNPJInfo(const ACNPJ: string): string;
var
  Response: IHTTPResponse;
begin
  try
    Response := FHttpClient.Get(FBaseURL + ACNPJ);
    if Response.StatusCode = 200 then
      Result := Response.ContentAsString
    else
      raise ECNPJAPIException.CreateFmt('Erro: %d - %s', [Response.StatusCode, Response.StatusText]);
  except
    on E: Exception do
      raise ECNPJAPIException.Create('Falha na comunicação com a API: ' + E.Message);
  end;
end;

function TCNPJAPI.GetCompanyInfo(const ACNPJ: string): TJSONObject;
var
  JSONResponse: string;
begin
  JSONResponse := GetCNPJInfo(ACNPJ);
  Result := TJSONObject.ParseJSONValue(JSONResponse) as TJSONObject;
  if not Assigned(Result) then
    raise ECNPJAPIException.Create('Falha ao parsear o JSON da resposta.');
end;

end.

