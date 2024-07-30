object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Consultar CNPJ - Brasil API'
  ClientHeight = 459
  ClientWidth = 648
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
    Width = 648
    Height = 459
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 638
    ExplicitHeight = 449
    object pnl1: TPanel
      Left = 441
      Top = 1
      Width = 206
      Height = 457
      Align = alClient
      TabOrder = 0
      ExplicitWidth = 196
      ExplicitHeight = 447
      object lb1: TLabel
        Left = 48
        Top = 24
        Width = 29
        Height = 13
        Caption = 'CNPJ:'
      end
      object btConsulta: TBitBtn
        Left = 40
        Top = 376
        Width = 129
        Height = 49
        Caption = 'Consultar'
        TabOrder = 0
        OnClick = btConsultaClick
      end
      object dt_CNPJ: TEdit
        Left = 48
        Top = 40
        Width = 121
        Height = 21
        TabOrder = 1
        Text = '12345678000195'
      end
    end
    object pnl2: TPanel
      Left = 1
      Top = 1
      Width = 440
      Height = 457
      Align = alLeft
      TabOrder = 1
      ExplicitHeight = 447
      object mmo1: TMemo
        Left = 1
        Top = 1
        Width = 438
        Height = 455
        Align = alClient
        ScrollBars = ssVertical
        TabOrder = 0
        ExplicitHeight = 445
      end
    end
  end
end
