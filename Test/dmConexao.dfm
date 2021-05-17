object dConexao: TdConexao
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 159
  Width = 341
  object driver: TFDPhysPgDriverLink
    Left = 152
    Top = 64
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 248
    Top = 64
  end
  object FConexaoBanco: TFDConnection
    Left = 56
    Top = 64
  end
end
