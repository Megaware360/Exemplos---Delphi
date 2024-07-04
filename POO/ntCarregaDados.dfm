object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Form1'
  ClientHeight = 425
  ClientWidth = 632
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object pnl1: TPanel
    Left = 0
    Top = 0
    Width = 1
    Height = 425
    Align = alLeft
    TabOrder = 0
  end
  object pnl2: TPanel
    Left = 513
    Top = 0
    Width = 119
    Height = 425
    Align = alRight
    TabOrder = 1
  end
  object pnl3: TPanel
    Left = 1
    Top = 0
    Width = 512
    Height = 425
    Align = alClient
    TabOrder = 2
    object pnl4: TPanel
      Left = 1
      Top = 137
      Width = 510
      Height = 287
      Align = alBottom
      TabOrder = 0
      object DBGrd1: TDBGrid
        Left = 1
        Top = 1
        Width = 508
        Height = 285
        Align = alClient
        DataSource = dsCadPessoaAlun
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
    end
    object pnl5: TPanel
      Left = 1
      Top = 1
      Width = 510
      Height = 136
      Align = alTop
      TabOrder = 1
      object lb1: TLabel
        Left = 5
        Top = 48
        Width = 27
        Height = 13
        Caption = 'Nome'
      end
      object lb2: TLabel
        Left = 207
        Top = 48
        Width = 28
        Height = 13
        Caption = 'Idade'
      end
      object lb3: TLabel
        Left = 279
        Top = 48
        Width = 43
        Height = 13
        Caption = 'Matricula'
        Enabled = False
      end
      object lb4: TLabel
        Left = 5
        Top = 2
        Width = 25
        Height = 13
        Caption = 'Tipo?'
      end
      object dt_Nome: TEdit
        Left = 5
        Top = 67
        Width = 196
        Height = 21
        TabOrder = 0
      end
      object dt_idade: TEdit
        Left = 207
        Top = 67
        Width = 66
        Height = 21
        NumbersOnly = True
        TabOrder = 1
        Text = '0'
        OnExit = dt_idadeExit
      end
      object dt_matricula: TEdit
        Left = 279
        Top = 67
        Width = 226
        Height = 21
        Enabled = False
        TabOrder = 2
      end
      object bt_gravar: TBitBtn
        Left = 430
        Top = 94
        Width = 75
        Height = 25
        Caption = 'Gravar'
        TabOrder = 3
        OnClick = bt_gravarClick
      end
      object cbb1: TComboBox
        Left = 5
        Top = 21
        Width = 73
        Height = 21
        BevelInner = bvNone
        BevelOuter = bvNone
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 4
        Text = 'Pessoa'
        OnChange = cbb1Change
        Items.Strings = (
          'Pessoa'
          'Aluno')
      end
    end
  end
  object FdmCadPessoaAlun: TFDMemTable
    Active = True
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 565
    Top = 160
    object FdmCadPessoaAlunA_NOME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'A_NOME'
      Size = 50
    end
    object FdmCadPessoaAlunI_IDADE: TIntegerField
      DisplayLabel = 'Idade'
      FieldName = 'I_IDADE'
    end
    object FdmCadPessoaAlunA_MATRICULA: TStringField
      DisplayLabel = 'Matricula'
      FieldName = 'A_MATRICULA'
    end
  end
  object dsCadPessoaAlun: TDataSource
    DataSet = FdmCadPessoaAlun
    Left = 565
    Top = 200
  end
end
