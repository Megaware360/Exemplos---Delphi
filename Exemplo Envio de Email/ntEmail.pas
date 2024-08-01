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
    medtSenha: TMaskEdit;
    bt1: TBitBtn;
    lbSenha: TLabel;
    cbbSMTP: TComboBox;
    dtSmtp: TEdit;
    cbbSSL: TComboBox;
    dtPorta: TEdit;
    lbPorta: TLabel;
    lbSSL: TLabel;
    lb3: TLabel;
    lbsmtpman: TLabel;
    procedure bt1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbbSMTPChange(Sender: TObject);
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

procedure TForm1.cbbSMTPChange(Sender: TObject);
begin
  if cbbSMTP.ItemIndex = 3 then
    dtSmtp.Visible:=True
  else
    dtSmtp.Visible:=False;
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
  SMTPConfig: TStringList;
  Msg: TIdMessage;
  SSL: TIdSSLIOHandlerSocketOpenSSL;
  Attachment: TIdAttachmentFile;
  OpenDialog: TOpenDialog;
begin
  OpenDialog := TOpenDialog.Create(nil);
  try
    OpenDialog.Filter := 'Todos os Arquivos (*.*)|*.*';
    if OpenDialog.Execute then
    begin
      SMTP := TIdSMTP.Create(nil);
      Msg := TIdMessage.Create(nil);
      SSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
      try
        // Configure o SSL Handler (se necessário)
        SSL.SSLOptions.Method := sslvTLSv1;
        SSL.SSLOptions.Mode := sslmUnassigned;


        SMTPConfig := TStringList(cbbSMTP.Items.Objects[cbbSMTP.ItemIndex]);

        ShowMessage(SMTPConfig[0]);


        // Configure o componente SMTP
        SMTP.IOHandler := SSL;
        SMTP.Host := 'smtp-mail.outlook.com'; // Servidor SMTP
        SMTP.Port := 587; // Porta SMTP para TLS
        SMTP.Username := Trim(dt_Email.Text); // Seu e-mail
        SMTP.Password := Trim(medtSenha.Text); // Sua senha
        SMTP.UseTLS:=utUseExplicitTLS; // Definindo para usar TLS

        // Configure a mensagem de e-mail
        Msg.From.Address := Trim(dt_Email.Text);
        Msg.Recipients.EmailAddresses := Trim(dt_Email.Text);
        Msg.Subject := 'Assunto do e-mail';
        Msg.Body.Text := 'Email Teste';

        // Adicionar o anexo
        Attachment := TIdAttachmentFile.Create(Msg.MessageParts, OpenDialog.FileName);
        try
          // Você pode adicionar mais anexos, se necessário
        finally
          Attachment.Free;
        end;

        // Enviar o e-mail
        SMTP.Connect;
        try
          SMTP.Send(Msg);
          ShowMessage('E-mail com anexo enviado com sucesso!');
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
  finally
    OpenDialog.Free;
  end;
end;



end.
