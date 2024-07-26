inherited frmUsuario: TfrmUsuario
  Caption = 'Cadastro de Usu'#225'rios'
  ClientHeight = 342
  ExplicitHeight = 371
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    inherited btnPesquisar: TBitBtn
      OnClick = btnPesquisarClick
    end
  end
  inherited Panel2: TPanel
    Top = 285
    ExplicitTop = 285
    inherited DBNavigator1: TDBNavigator
      Hints.Strings = ()
    end
  end
  inherited qryPadrao: TFDQuery
    UpdateOptions.AssignedValues = [uvFetchGeneratorsPoint, uvGeneratorName]
    UpdateOptions.FetchGeneratorsPoint = gpImmediate
    UpdateOptions.GeneratorName = 'GEN_ID_TBLUSUARIO'
    UpdateOptions.AutoIncFields = 'ID_USUARIO'
    SQL.Strings = (
      'SELECT * FROM TBLUSUARIO'
      'ORDER BY ID_USUARIO')
    Left = 664
    Top = 72
    object qryPadraoID_USUARIO: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID_USUARIO'
      Origin = 'ID_USUARIO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qryPadraoNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Required = True
      Size = 100
    end
    object qryPadraoSENHA: TStringField
      FieldName = 'SENHA'
      Origin = 'SENHA'
      Required = True
      Size = 30
    end
    object qryPadraoTIPO: TStringField
      FieldName = 'TIPO'
      Origin = 'TIPO'
      Size = 30
    end
    object qryPadraoCADASTRO: TDateField
      FieldName = 'CADASTRO'
      Origin = 'CADASTRO'
      Required = True
    end
  end
  inherited dsPadrao: TDataSource
    Left = 728
    Top = 72
  end
end
