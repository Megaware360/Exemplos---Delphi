{*******************************************************************************}
{ Projeto: Exemplo POO                                                          }
{                                                                               }
{ O objetivo desta aplicação é exemplificar POO para mostrar como funciona a    }
{ programação orientada a objetos para novos desenvolvedores, facilitando a     }
{ criação de interfaces, modelos e controladores para operações                 }
{                                                                               }
{ Desenvolvido por David Willian Lopes Brito                                     }
{ Email: Lopes.willian@hotmail.com                                              }
{                                                                               }
{*******************************************************************************}



unit ntCarregaDados;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, ntPessoa,
  Vcl.StdCtrls, Vcl.Buttons;

type
  TFrmPOO = class(TForm)
    pnl1: TPanel;
    pnl2: TPanel;
    pnl3: TPanel;
    pnl4: TPanel;
    pnl5: TPanel;
    DBGrd1: TDBGrid;
    FdmCadPessoaAlun: TFDMemTable;
    dsCadPessoaAlun: TDataSource;
    FdmCadPessoaAlunA_NOME: TStringField;
    FdmCadPessoaAlunI_IDADE: TIntegerField;
    FdmCadPessoaAlunA_MATRICULA: TStringField;
    dt_Nome: TEdit;
    dt_idade: TEdit;
    dt_matricula: TEdit;
    lb1: TLabel;
    lb2: TLabel;
    lb3: TLabel;
    bt_gravar: TBitBtn;
    cbb1: TComboBox;
    lb4: TLabel;
    procedure bt_gravarClick(Sender: TObject);
    procedure cbb1Change(Sender: TObject);
    procedure bHabilitaCampo(bHab:boolean);
    procedure InserirDados(Dados: TStrings;Matricula: Boolean);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure dt_idadeExit(Sender: TObject);
    procedure LimparDados;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPOO: TFrmPOO;

implementation

{$R *.dfm}

procedure TFrmPOO.bHabilitaCampo(bHab: boolean);
begin
  dt_matricula.Enabled:=bHab;
  lb3.Enabled:=bHab;
end;

procedure TFrmPOO.bt_gravarClick(Sender: TObject);
var
  Pessoa: TPessoa;
  Aluno: TAluno;
  MsgErro: string;
begin
  if cbb1.ItemIndex = 0 then
  begin
    Pessoa := TPessoa.Create(Trim(dt_Nome.Text), StrToInt(dt_idade.Text), dt_Nome, dt_idade);
    try
      if not Pessoa.ValidarDados(MsgErro) then
      begin
        ShowMessage(MsgErro);
        Exit;
      end;
      InserirDados(Pessoa.GetDados, False);
    finally
      Pessoa.Free;
    end;
  end
  else
  begin
    Aluno := TAluno.Create(Trim(dt_Nome.Text), StrToInt(dt_idade.Text), Trim(dt_matricula.Text), dt_Nome, dt_idade, dt_matricula);
    try
      if not Aluno.ValidarDados(MsgErro) then
      begin
        ShowMessage(MsgErro);
        Exit;
      end;
      InserirDados(Aluno.GetDados, True);
    finally
      Aluno.Free;
    end;
  end;
end;

procedure TFrmPOO.cbb1Change(Sender: TObject);
begin
  if cbb1.ItemIndex > 0 then
    bHabilitaCampo(True)
  else
    bHabilitaCampo(False);
end;

procedure TFrmPOO.dt_idadeExit(Sender: TObject);
begin
  if dt_idade.Text = '' then
    dt_idade.Text:='0';
end;

procedure TFrmPOO.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 Then
    begin
      SelectNext(ActiveControl as tWinControl, True, True );
      Key := #0;
    end;

  if Key = #27 Then
    begin
      SelectNext(ActiveControl as tWinControl, False, True );
      Key := #0;
    end;
end;

procedure TFrmPOO.InserirDados(Dados: TStrings; Matricula: Boolean);
begin
  FdmCadPessoaAlun.Append;
  FdmCadPessoaAlun.FieldByName('A_NOME').AsString:=Dados.Values['Nome'];
  FdmCadPessoaAlun.FieldByName('I_IDADE').AsInteger:=StrToIntDef(Dados.Values['Idade'],0);
  if  Matricula then
    FdmCadPessoaAlun.FieldByName('A_MATRICULA').AsString:=Dados.Values['Matricula'];
  FdmCadPessoaAlun.Post;
  LimparDados;
  dt_Nome.SetFocus;
end;

procedure TFrmPOO.LimparDados;
begin
  dt_Nome.Clear;
  dt_idade.Text:='0';
  dt_matricula.Text:='';
end;

end.
