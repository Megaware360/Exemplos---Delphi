object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Enviar E-Mail.'
  ClientHeight = 568
  ClientWidth = 580
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pgcEmail: TPageControl
    Left = 0
    Top = 0
    Width = 580
    Height = 568
    ActivePage = ts1
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 664
    ExplicitHeight = 436
    object ts1: TTabSheet
      Caption = 'E-Mail'
      ExplicitLeft = 8
      ExplicitTop = 28
      ExplicitWidth = 632
      ExplicitHeight = 530
      object lbEnviarPara: TLabel
        Left = 16
        Top = 24
        Width = 59
        Height = 13
        Caption = 'Enviar Para:'
      end
      object lbAssunto: TLabel
        Left = 16
        Top = 108
        Width = 43
        Height = 13
        Caption = 'Assunto:'
      end
      object lbMsg: TLabel
        Left = 16
        Top = 150
        Width = 55
        Height = 13
        Caption = 'Mensagem:'
      end
      object lbAnx: TLabel
        Left = 16
        Top = 413
        Width = 31
        Height = 13
        Caption = 'Anexo'
      end
      object rgDadosDest: TRadioGroup
        Left = 0
        Top = 0
        Width = 572
        Height = 81
        Align = alTop
        Caption = 'Dados Destinatario'
        TabOrder = 0
        ExplicitLeft = 3
        ExplicitTop = 21
        ExplicitWidth = 656
      end
      object dtEmailDest: TEdit
        Left = 16
        Top = 43
        Width = 353
        Height = 21
        TabOrder = 1
      end
      object rgMensagem: TRadioGroup
        Left = 0
        Top = 81
        Width = 572
        Height = 459
        Align = alClient
        Caption = 'Mensagem'
        TabOrder = 2
        ExplicitLeft = -3
        ExplicitTop = 87
        ExplicitWidth = 562
        ExplicitHeight = 449
      end
      object dtAssunto: TEdit
        Left = 16
        Top = 127
        Width = 465
        Height = 21
        TabOrder = 3
      end
      object mmoMSG: TMemo
        Left = 16
        Top = 165
        Width = 529
        Height = 236
        ScrollBars = ssVertical
        TabOrder = 4
      end
      object mmoAnx: TMemo
        Left = 16
        Top = 432
        Width = 529
        Height = 49
        ScrollBars = ssVertical
        TabOrder = 5
      end
      object btAnexarArquivo: TBitBtn
        Left = 80
        Top = 502
        Width = 147
        Height = 25
        Caption = 'Anexar Arquivos'
        TabOrder = 7
        OnClick = btAnexarArquivoClick
      end
      object btEnviar: TBitBtn
        Left = 392
        Top = 502
        Width = 75
        Height = 25
        Caption = 'Enviar'
        TabOrder = 6
        OnClick = btEnviarClick
      end
    end
    object tsConf: TTabSheet
      Caption = 'Configura'#231#227'o Email'
      ImageIndex = 1
      ExplicitWidth = 656
      ExplicitHeight = 408
      object lbEmail: TLabel
        Left = 8
        Top = 15
        Width = 28
        Height = 13
        Caption = 'E-mail'
      end
      object lbSenha: TLabel
        Left = 359
        Top = 17
        Width = 30
        Height = 13
        Caption = 'Senha'
      end
      object lbPorta: TLabel
        Left = 8
        Top = 62
        Width = 26
        Height = 13
        Caption = 'Porta'
      end
      object lbSSL: TLabel
        Left = 71
        Top = 62
        Width = 17
        Height = 13
        Caption = 'SSL'
      end
      object lbSMTP: TLabel
        Left = 221
        Top = 62
        Width = 26
        Height = 13
        Caption = 'SMTP'
      end
      object lbsmtpman: TLabel
        Left = 372
        Top = 62
        Width = 63
        Height = 13
        Caption = 'SMTP Manual'
        Visible = False
      end
      object rg1: TRadioGroup
        Left = 0
        Top = 0
        Width = 572
        Height = 540
        Align = alClient
        Caption = 'Configura'#231#227'o de E-mail'
        TabOrder = 0
        ExplicitWidth = 656
        ExplicitHeight = 408
      end
      object dt_Email: TEdit
        Left = 8
        Top = 35
        Width = 345
        Height = 21
        TabOrder = 1
      end
      object cbbSMTP: TComboBox
        Left = 221
        Top = 81
        Width = 145
        Height = 21
        Style = csDropDownList
        TabOrder = 5
        OnChange = cbbSMTPChange
      end
      object dtSmtp: TEdit
        Left = 372
        Top = 81
        Width = 141
        Height = 21
        TabOrder = 6
        TextHint = 'Ex: smtp-mail.outlook.com'
        Visible = False
      end
      object cbbSSL: TComboBox
        Left = 71
        Top = 81
        Width = 145
        Height = 21
        Style = csDropDownList
        TabOrder = 4
        OnChange = cbbSMTPChange
      end
      object dtPorta: TEdit
        Left = 8
        Top = 81
        Width = 57
        Height = 21
        NumbersOnly = True
        TabOrder = 3
        Text = '587'
      end
      object dtSenha: TEdit
        Left = 359
        Top = 34
        Width = 130
        Height = 21
        PasswordChar = '*'
        TabOrder = 2
      end
    end
  end
end
