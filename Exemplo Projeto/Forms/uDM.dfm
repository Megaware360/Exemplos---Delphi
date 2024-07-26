object DM: TDM
  OldCreateOrder = False
  Height = 318
  Width = 560
  object Conexao: TFDConnection
    Params.Strings = (
      
        'Database=C:\Aplicativos\Exemplos---Delphi\Exemplo Projeto\EXE\BA' +
        'NCO\ESTOQUE.FDB'
      'User_Name=SYSDBA'
      'Password=19621017'
      'DriverID=FB')
    LoginPrompt = False
    Left = 32
    Top = 24
  end
  object Transacao: TFDTransaction
    Connection = Conexao
    Left = 120
    Top = 24
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 232
    Top = 24
  end
end
