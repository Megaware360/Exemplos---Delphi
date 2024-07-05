object FrmExemploSOAP: TFrmExemploSOAP
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Exemplo SOAP Correios.'
  ClientHeight = 320
  ClientWidth = 642
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 345
    Height = 320
    Align = alLeft
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object pgc1: TPageControl
    Left = 345
    Top = 0
    Width = 297
    Height = 320
    ActivePage = Menu
    Align = alClient
    TabOrder = 1
    object Menu: TTabSheet
      Caption = 'Menu'
      object lbCep: TLabel
        Left = 3
        Top = 16
        Width = 19
        Height = 13
        Caption = 'Cep'
      end
      object lbCepori: TLabel
        Left = 3
        Top = 59
        Width = 56
        Height = 13
        Caption = 'Cep Origem'
      end
      object lbCepori1: TLabel
        Left = 3
        Top = 99
        Width = 58
        Height = 13
        Caption = 'Cep Destino'
      end
      object Edit1: TEdit
        Left = 3
        Top = 32
        Width = 121
        Height = 21
        Enabled = False
        TabOrder = 0
      end
      object bt1: TBitBtn
        Left = 207
        Top = 248
        Width = 75
        Height = 25
        Caption = 'Consultar'
        TabOrder = 1
        OnClick = bt1Click
      end
      object chkCep: TCheckBox
        Left = 190
        Top = 34
        Width = 97
        Height = 17
        Caption = 'Consulta Cep'
        TabOrder = 2
        OnClick = chkCepClick
      end
      object dtCepOrig: TEdit
        Left = 3
        Top = 72
        Width = 121
        Height = 21
        Enabled = False
        TabOrder = 3
        Text = '05110000'
      end
      object dtCepDest: TEdit
        Left = 3
        Top = 112
        Width = 121
        Height = 21
        Enabled = False
        TabOrder = 4
        Text = '76940000'
      end
      object chkDspServ: TCheckBox
        Left = 190
        Top = 65
        Width = 97
        Height = 17
        Caption = 'Disp Servi'#231'o'
        TabOrder = 5
        OnClick = chkDspServClick
      end
    end
    object Configuração: TTabSheet
      Caption = 'Configura'#231#227'o'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Usuario: TLabel
        Left = 3
        Top = 16
        Width = 36
        Height = 13
        Caption = 'Usuario'
      end
      object lbSenha: TLabel
        Left = 3
        Top = 59
        Width = 30
        Height = 13
        Caption = 'Senha'
      end
      object lbCodAdm: TLabel
        Left = 3
        Top = 102
        Width = 104
        Height = 13
        Caption = 'Codigo Administrativo'
      end
      object lbContrato: TLabel
        Left = 3
        Top = 140
        Width = 43
        Height = 13
        Caption = 'Contrato'
      end
      object lbCartao: TLabel
        Left = 3
        Top = 182
        Width = 33
        Height = 13
        Caption = 'Cartao'
      end
      object lbCNPJ: TLabel
        Left = 3
        Top = 224
        Width = 22
        Height = 13
        Caption = 'Cnpj'
      end
      object dtUsuario: TEdit
        Left = 3
        Top = 32
        Width = 121
        Height = 21
        TabOrder = 0
        Text = 'sigep'
      end
      object dtSenha: TEdit
        Left = 3
        Top = 75
        Width = 121
        Height = 21
        TabOrder = 1
        Text = 'n5f9t8'
      end
      object dtCodAdminis: TEdit
        Left = 3
        Top = 120
        Width = 121
        Height = 21
        TabOrder = 2
        Text = '17000190'
      end
      object dtContrato: TEdit
        Left = 3
        Top = 155
        Width = 121
        Height = 21
        TabOrder = 3
        Text = '9992157880'
      end
      object dtCartao: TEdit
        Left = 3
        Top = 197
        Width = 121
        Height = 21
        TabOrder = 4
        Text = '0067599079'
      end
      object dtCnpj: TEdit
        Left = 3
        Top = 239
        Width = 121
        Height = 21
        TabOrder = 5
        Text = '34028316000103'
      end
    end
  end
  object HTTPRIO1: THTTPRIO
    HTTPWebNode.UseUTF8InHeader = True
    HTTPWebNode.InvokeOptions = [soIgnoreInvalidCerts, soAutoCheckAccessPointViaUDDI]
    HTTPWebNode.WebNodeOptions = []
    Converter.Options = [soSendMultiRefObj, soTryAllSchema, soRootRefNodesToBody, soCacheMimeResponse, soUTF8EncodeXML]
    Left = 512
    Top = 136
  end
end
