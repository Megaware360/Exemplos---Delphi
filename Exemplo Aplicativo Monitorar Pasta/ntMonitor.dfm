object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Monitor de Arquivos'
  ClientHeight = 158
  ClientWidth = 405
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object pgc1: TPageControl
    Left = 0
    Top = 0
    Width = 405
    Height = 158
    ActivePage = ts2
    Align = alClient
    TabOrder = 0
    object ts1: TTabSheet
      Caption = 'Historico de Arquivo'
      object mmo1: TMemo
        Left = 0
        Top = 0
        Width = 397
        Height = 130
        Align = alClient
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
    object ts2: TTabSheet
      Caption = 'Configura'#231#227'o'
      ImageIndex = 1
      object lb1: TLabel
        Left = 3
        Top = 5
        Width = 85
        Height = 13
        Caption = 'Localizar Diretorio'
      end
      object btnControl: TBitBtn
        Left = 117
        Top = 92
        Width = 145
        Height = 25
        Caption = 'btnControl'
        TabOrder = 0
        OnClick = btnControlClick
      end
      object dtDir: TEdit
        Left = 3
        Top = 24
        Width = 315
        Height = 21
        TabOrder = 1
        TextHint = 'Informe o Direitorio'
      end
      object btDir: TBitBtn
        Left = 324
        Top = 22
        Width = 29
        Height = 25
        Caption = '...'
        TabOrder = 2
      end
      object chkWindows: TCheckBox
        Left = 3
        Top = 51
        Width = 150
        Height = 17
        Caption = 'Iniciar com Windows ?'
        TabOrder = 3
        OnClick = chkWindowsClick
      end
    end
  end
  object Timer: TTimer
    Left = 560
    Top = 8
  end
  object TrayIcon: TTrayIcon
    OnDblClick = TrayIconDblClick
    Left = 377
    Top = 8
  end
end
