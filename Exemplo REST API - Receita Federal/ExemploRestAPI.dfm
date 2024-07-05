object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 337
  ClientWidth = 816
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pnlMenu: TPanel
    Left = 0
    Top = 0
    Width = 816
    Height = 337
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 8
    ExplicitTop = 8
    object lb11: TLabel
      Left = 16
      Top = 96
      Width = 41
      Height = 13
      Caption = 'Situa'#231#227'o'
    end
    object lb12: TLabel
      Left = 16
      Top = 53
      Width = 20
      Height = 13
      Caption = 'Tipo'
    end
    object lb1: TLabel
      Left = 216
      Top = 56
      Width = 70
      Height = 13
      Caption = 'Data Cadastro'
    end
    object lb13: TLabel
      Left = 216
      Top = 96
      Width = 71
      Height = 13
      Caption = 'Nome Empresa'
    end
    object lb111: TLabel
      Left = 16
      Top = 136
      Width = 42
      Height = 13
      Caption = 'Telefone'
    end
    object lb131: TLabel
      Left = 216
      Top = 136
      Width = 71
      Height = 13
      Caption = 'Nome Fantasia'
    end
    object lb1111: TLabel
      Left = 218
      Top = 179
      Width = 33
      Height = 13
      Caption = 'Cidade'
    end
    object lb11111: TLabel
      Left = 17
      Top = 179
      Width = 33
      Height = 13
      Caption = 'Estado'
    end
    object lb11112: TLabel
      Left = 17
      Top = 219
      Width = 45
      Height = 13
      Caption = 'Endere'#231'o'
    end
    object lb111121: TLabel
      Left = 307
      Top = 219
      Width = 28
      Height = 13
      Caption = 'Bairro'
    end
    object lb1111211: TLabel
      Left = 17
      Top = 261
      Width = 37
      Height = 13
      Caption = 'Numero'
    end
    object lb11112111: TLabel
      Left = 171
      Top = 261
      Width = 19
      Height = 13
      Caption = 'Cep'
    end
    object bt1: TBitBtn
      Left = 176
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Consulta'
      TabOrder = 0
      OnClick = bt1Click
    end
    object dtCNPJ: TEdit
      Left = 16
      Top = 10
      Width = 137
      Height = 21
      TabOrder = 1
      Text = '06081995000149'
    end
    object dtSituacao: TEdit
      Left = 16
      Top = 112
      Width = 121
      Height = 21
      TabOrder = 2
    end
    object dtTipo: TEdit
      Left = 16
      Top = 69
      Width = 121
      Height = 21
      TabOrder = 3
    end
    object dtDatCad: TEdit
      Left = 216
      Top = 72
      Width = 121
      Height = 21
      TabOrder = 4
    end
    object dtEmpresa: TEdit
      Left = 216
      Top = 112
      Width = 361
      Height = 21
      TabOrder = 5
    end
    object dtTelefone: TEdit
      Left = 16
      Top = 152
      Width = 121
      Height = 21
      TabOrder = 6
    end
    object dtFantasia: TEdit
      Left = 216
      Top = 152
      Width = 361
      Height = 21
      TabOrder = 7
    end
    object dtCidade: TEdit
      Left = 218
      Top = 195
      Width = 270
      Height = 21
      TabOrder = 8
    end
    object dtuf: TEdit
      Left = 16
      Top = 195
      Width = 42
      Height = 21
      TabOrder = 9
    end
    object dtEnd: TEdit
      Left = 17
      Top = 235
      Width = 270
      Height = 21
      TabOrder = 10
    end
    object dtBairro: TEdit
      Left = 307
      Top = 235
      Width = 270
      Height = 21
      TabOrder = 11
    end
    object dtNumero: TEdit
      Left = 16
      Top = 278
      Width = 81
      Height = 21
      TabOrder = 12
    end
    object dtCep: TEdit
      Left = 170
      Top = 278
      Width = 81
      Height = 21
      TabOrder = 13
    end
    object mmo1: TMemo
      Left = 648
      Top = 1
      Width = 167
      Height = 335
      Align = alRight
      ScrollBars = ssVertical
      TabOrder = 14
      ExplicitLeft = 649
    end
  end
  object RESTClient: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    Params = <>
    HandleRedirects = True
    RaiseExceptionOn500 = False
    Left = 704
    Top = 48
  end
  object RESTRequest: TRESTRequest
    Client = RESTClient
    Params = <>
    Response = RESTResponse
    SynchronizedEvents = False
    Left = 704
    Top = 96
  end
  object RESTResponse: TRESTResponse
    ContentType = 'application/json'
    Left = 704
  end
  object TRESTResponseDataSet: TRESTResponseDataSetAdapter
    FieldDefs = <>
    Response = RESTResponse
    Left = 704
    Top = 144
  end
end
