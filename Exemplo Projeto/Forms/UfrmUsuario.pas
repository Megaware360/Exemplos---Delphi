unit UfrmUsuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UfrmPadrao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.DBCtrls, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Vcl.Mask, UfrmPesquisaUsuario;

type
  TfrmUsuario = class(TfrmPadrao)
    qryPadraoID_USUARIO: TIntegerField;
    qryPadraoNOME: TStringField;
    qryPadraoSENHA: TStringField;
    qryPadraoTIPO: TStringField;
    qryPadraoCADASTRO: TDateField;
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnAtualizarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmUsuario: TfrmUsuario;

implementation

{$R *.dfm}

procedure TfrmUsuario.btnAtualizarClick(Sender: TObject);
begin
  inherited;

end;

procedure TfrmUsuario.btnPesquisarClick(Sender: TObject);
var
  ObjFrmPesquisaUsuario : TfrmPesquisaUsuario;
begin
  inherited;
  ObjFrmPesquisaUsuario := TfrmPesquisaUsuario.Create(nil);

  try
   ObjFrmPesquisaUsuario.ShowModal;

   if objFrmPesquisaUsuario.Codigo > 0 then
    begin
     qryPadrao.Open;
     qryPadrao.Locate('ID_USUARIO', objFrmPesquisaUsuario.Codigo, []);
    end;
  finally
   ObjFrmPesquisaUsuario.Free;
  end;
end;


End.
