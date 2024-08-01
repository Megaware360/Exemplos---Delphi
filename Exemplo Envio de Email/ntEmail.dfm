object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Enviar E-Mail.'
  ClientHeight = 436
  ClientWidth = 664
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pgcEmail: TPageControl
    Left = 0
    Top = 0
    Width = 664
    Height = 436
    ActivePage = tsConf
    Align = alClient
    TabOrder = 0
    object ts1: TTabSheet
      Caption = 'E-Mail'
    end
    object tsConf: TTabSheet
      Caption = 'Configura'#231#227'o Email'
      ImageIndex = 1
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
      object lb3: TLabel
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
      end
      object rg1: TRadioGroup
        Left = 0
        Top = 0
        Width = 656
        Height = 408
        Align = alClient
        Caption = 'Configura'#231#227'o de E-mail'
        TabOrder = 0
      end
      object dt_Email: TEdit
        Left = 8
        Top = 34
        Width = 345
        Height = 21
        TabOrder = 1
      end
      object medtSenha: TMaskEdit
        Left = 359
        Top = 34
        Width = 143
        Height = 21
        TabOrder = 2
        Text = ''
      end
      object bt1: TBitBtn
        Left = 248
        Top = 200
        Width = 75
        Height = 25
        Caption = 'bt1'
        TabOrder = 3
        OnClick = bt1Click
      end
      object cbbSMTP: TComboBox
        Left = 221
        Top = 81
        Width = 145
        Height = 21
        Style = csDropDownList
        TabOrder = 4
        OnChange = cbbSMTPChange
      end
      object dtSmtp: TEdit
        Left = 372
        Top = 81
        Width = 141
        Height = 21
        TabOrder = 5
        TextHint = 'Ex: smtp-mail.outlook.com'
        Visible = False
      end
      object cbbSSL: TComboBox
        Left = 71
        Top = 81
        Width = 145
        Height = 21
        Style = csDropDownList
        TabOrder = 6
        OnChange = cbbSMTPChange
      end
      object dtPorta: TEdit
        Left = 8
        Top = 81
        Width = 57
        Height = 21
        NumbersOnly = True
        TabOrder = 7
        Text = '587'
      end
    end
  end
end
