unit ntEmail;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls,IdSMTP, IdMessage, IdSSLOpenSSL, IdGlobal, IdAttachmentFile,
  IdExplicitTLSClientServerBase, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask,
  Vcl.Buttons;

type
  TForm1 = class(TForm)
    pgcEmail: TPageControl;
    ts1: TTabSheet;
    tsConf: TTabSheet;
    rg1: TRadioGroup;
    dt_Email: TEdit;
    lbEmail: TLabel;
    lbSenha: TLabel;
    cbbSMTP: TComboBox;
    dtSmtp: TEdit;
    cbbSSL: TComboBox;
    dtPorta: TEdit;
    lbPorta: TLabel;
    lbSSL: TLabel;
    lbSMTP: TLabel;
    lbsmtpman: TLabel;
    dtSenha: TEdit;
    rgDadosDest: TRadioGroup;
    lbEnviarPara: TLabel;
    dtEmailDest: TEdit;
    rgMensagem: TRadioGroup;
    lbAssunto: TLabel;
    dtAssunto: TEdit;
    mmoMSG: TMemo;
    mmoAnx: TMemo;
    lbMsg: TLabel;
    lbAnx: TLabel;
    btAnexarArquivo: TBitBtn;
    btEnviar: TBitBtn;
    procedure bt1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbbSMTPChange(Sender: TObject);
    procedure btAnexarArquivoClick(Sender: TObject);
    procedure btEnviarClick(Sender: TObject);
  private
    procedure SendEmail;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}



procedure TForm1.bt1Click(Sender: TObject);
begin
  SendEmail;
end;

procedure TForm1.btAnexarArquivoClick(Sender: TObject);
var
  OpenDialog: TOpenDialog;
  i: Integer;
begin
  OpenDialog := TOpenDialog.Create(nil);
  try
    OpenDialog.Filter := 'Todos os Arquivos (*.*)|*.*';
    OpenDialog.Options := [ofAllowMultiSelect];

    if OpenDialog.Execute then
    begin
      mmoAnx.Lines.Clear; // Limpa a lista de arquivos antes de adicionar novos
      for i := 0 to OpenDialog.Files.Count - 1 do
      begin
        mmoAnx.Lines.Add(OpenDialog.Files[i]); // Adiciona o caminho dos arquivos ao memo
      end;
    end;
  finally
    OpenDialog.Free;
  end;

end;

procedure TForm1.btEnviarClick(Sender: TObject);
begin
  SendEmail;
end;

procedure TForm1.cbbSMTPChange(Sender: TObject);
begin
  if cbbSMTP.ItemIndex = 3 then
    begin
      lbsmtpman.Visible:=True;
      dtSmtp.Visible:=True;
    end
  else
    begin
      lbsmtpman.Visible:=False;
      dtSmtp.Visible:=False;
    end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  SMTPConfig: TStringList;
begin
  // Configuração para o servidor SMTP do Outlook
  SMTPConfig := TStringList.Create;
  SMTPConfig.Add('smtp-mail.outlook.com');
  cbbSMTP.Items.AddObject('Outlook', SMTPConfig);

  // Configuração para o servidor SMTP do Gmail
  SMTPConfig := TStringList.Create;
  SMTPConfig.Add('smtp.gmail.com');
  cbbSMTP.Items.AddObject('Gmail', SMTPConfig);

  // Configuração para o servidor SMTP do Yahoo
  SMTPConfig := TStringList.Create;
  SMTPConfig.Add('smtp.mail.yahoo.com');
  cbbSMTP.Items.AddObject('Yahoo', SMTPConfig);


  // Configuração para o servidor Manual
  SMTPConfig := TStringList.Create;
  SMTPConfig.Add('Manual');
  cbbSMTP.Items.AddObject('Manual', SMTPConfig);

  //Configuração para SSL
  SMTPConfig := TStringList.Create;
  SMTPConfig.Add('sslvTLSv1');
  cbbSSL.Items.AddObject('sslvTLSv1', SMTPConfig);

  //Configuração para SSL
  SMTPConfig := TStringList.Create;
  SMTPConfig.Add('sslvTLSv1_1');
  cbbSSL.Items.AddObject('sslvTLSv1_1', SMTPConfig);

  //Configuração para SSL
  SMTPConfig := TStringList.Create;
  SMTPConfig.Add('sslvTLSv1_1');
  cbbSSL.Items.AddObject('sslvTLSv1_2', SMTPConfig);

  // Adicione outros servidores SMTP conforme necessário


  cbbSMTP.ItemIndex := 0; // Seleciona o primeiro item por padrão
  cbbSSL.ItemIndex := 2; // Seleciona o primeiro item por padrão

end;

procedure TForm1.SendEmail;
var
  SMTP: TIdSMTP;
  Msg: TIdMessage;
  SSL: TIdSSLIOHandlerSocketOpenSSL;
  i: Integer;
  Attachment: TIdAttachmentFile;
begin
  SMTP := TIdSMTP.Create(nil);
  Msg := TIdMessage.Create(nil);
  SSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  try
    // Configure o SSL Handler
    SSL.SSLOptions.Method := sslvTLSv1;
    SSL.SSLOptions.Mode := sslmUnassigned;

    // Configure o componente SMTP
    SMTP.IOHandler := SSL;
    SMTP.Host := 'smtp-mail.outlook.com'; // Servidor SMTP
    SMTP.Port := 587; // Porta SMTP para TLS
    SMTP.Username := Trim(dt_Email.Text); // Seu e-mail
    SMTP.Password := Trim(dtSenha.Text); // Sua senha
    SMTP.UseTLS := utUseExplicitTLS; // Definindo para usar TLS

    // Configure a mensagem de e-mail
    Msg.From.Address := Trim(dt_Email.Text);
    Msg.Recipients.EmailAddresses := Trim(dtEmailDest.Text); // Define o destinatário
    Msg.Subject := dtAssunto.Text;
    Msg.Body.Text := mmoMSG.Text;

    // Adicionar anexos
    for i := 0 to mmoAnx.Lines.Count - 1 do
    begin
      if FileExists(mmoAnx.Lines[i]) then
      begin
        Attachment := TIdAttachmentFile.Create(Msg.MessageParts, mmoAnx.Lines[i]);
        try
          // Anexo adicionado
        except
          on E: Exception do
          begin
            ShowMessage('Erro ao adicionar o anexo: ' + E.Message);
            Exit; // Saia se houver erro ao adicionar o anexo
          end;
        end;
      end
      else
      begin
        ShowMessage('O arquivo não existe: ' + mmoAnx.Lines[i]);
        Exit; // Saia se o arquivo não existir
      end;
    end;

    // Enviar o e-mail
    SMTP.Connect;
    try
      SMTP.Send(Msg);
      ShowMessage('E-mail com anexos enviado com sucesso!');
    except
      on E: Exception do
        ShowMessage('Erro ao enviar e-mail: ' + E.Message);
    end;
    SMTP.Disconnect;
  finally
    Msg.Free;
    SMTP.Free;
    SSL.Free;
  end;
end;




end.
