{*******************************************************************************}
{ Projeto: Exemplo POO                                                          }
{                                                                               }
{ O objetivo desta aplica��o � exemplificar POO para mostrar como funciona a    }
{ programa��o orientada a objetos para novos desenvolvedores, facilitando a     }
{ cria��o de interfaces, modelos e controladores para opera��es                 }
{                                                                               }
{ Desenvolvido por David Willian Lopes Brito                                     }
{ Email: Lopes.willian@hotmail.com                                              }
{                                                                               }
{*******************************************************************************}

unit ntPessoa;

interface
 uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons;


type
  TPessoa = class
  private
    FNome: string;
    FIdade: Integer;
    FEditNome: TEdit; // Refer�ncia ao controle visual
    FEditIdade: TEdit; // Refer�ncia ao controle visual

  public
  constructor Create(Nome: string; Idade: Integer; EditNome, EditIdade: TEdit);
    procedure SetNome(Nome: string);
    function GetNome: string;
    procedure SetIdade(Idade: Integer);
    function GetIdade: Integer;
    function GetDados: TStrings; virtual;
    function ValidarDados(out MsgErro: string): Boolean; virtual;
  end;

  TAluno = class(TPessoa)
  private
    FMatricula: string;
    FEditMatricula: TEdit;  // Refer�ncia ao controle visual
  public
    constructor Create(Nome: string; Idade: Integer; Matricula: string;
  EditNome, EditIdade, EditMatricula: TEdit);
    procedure SetMatricula(Matricula: string);
    function GetMatricula: string;
    function GetDados: TStrings; override;
    function ValidarDados(out MsgErro: string): Boolean; virtual;
  end;

implementation

{ TPessoa }

constructor TPessoa.Create(Nome: string; Idade: Integer; EditNome, EditIdade: TEdit);
begin
  FNome := Nome;
  FIdade := Idade;
  FEditNome := EditNome; // Refer�ncia ao controle visual
  FEditIdade := EditIdade; // Refer�ncia ao controle visual
end;

function TPessoa.ValidarDados(out MsgErro: string): Boolean;
begin
  Result := True;
  MsgErro := '';

  if Trim(FNome) = '' then
    begin
      MsgErro := 'O campo Nome est� vazio.';
      Result := False;
      if Assigned(FEditNome) then
        FEditNome.SetFocus; // SetFocus no campo Nome
    end
  else if FIdade <= 0 then
    begin
      MsgErro := 'O campo Idade deve ser maior que zero.';
      Result := False;
      if Assigned(FEditIdade) then
        FEditIdade.SetFocus; // SetFocus no campo Idade
    end;
end;


function TPessoa.GetDados: TStrings;
begin
  Result := TStringList.Create;
  Result.Values['Nome'] := FNome;
  Result.Values['Idade'] := IntToStr(FIdade);
end;

function TPessoa.GetIdade: Integer;
begin
  Result := FIdade;
end;

function TPessoa.GetNome: string;
begin
  Result := FNome;
end;


procedure TPessoa.SetIdade(Idade: Integer);
begin
  FIdade := Idade;
end;

procedure TPessoa.SetNome(Nome: string);
begin
  FNome := Nome;
end;

{ TAluno }

constructor TAluno.Create(Nome: string; Idade: Integer; Matricula: string;
  EditNome, EditIdade, EditMatricula: TEdit);
begin
  inherited Create(Nome, Idade, EditNome, EditIdade);
  FMatricula := Matricula;
  FEditMatricula := EditMatricula; // Refer�ncia ao controle visual
end;

function TAluno.GetDados: TStrings;
begin
  Result := inherited GetDados;
  Result.Values['Matricula'] := FMatricula;
end;

function TAluno.GetMatricula: string;
begin
   Result := FMatricula;
end;

function TAluno.ValidarDados(out MsgErro: string): Boolean;
begin
  Result := inherited ValidarDados(MsgErro);

  if not Result then // Se a valida��o herdada falhar, n�o prosseguir
    Exit;

  if Trim(FMatricula) = '' then
    begin
      MsgErro := 'O campo Matr�cula est� vazio.';
      Result := False;
      if Assigned(FEditMatricula) then
        FEditMatricula.SetFocus; // SetFocus no campo Matr�cula
    end;
end;

procedure TAluno.SetMatricula(Matricula: string);
begin
  FMatricula := Matricula;
end;

end.
