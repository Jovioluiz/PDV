object dm: Tdm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 408
  Width = 679
  object fd: TFDConnection
    Params.Strings = (
      'Server=localhost'
      'Database=PDV'
      'User_Name=root'
      'Password=jovio'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 64
    Top = 48
  end
  object tbCargos: TFDTable
    IndexFieldNames = 'id_cargo'
    Connection = fd
    UpdateOptions.UpdateTableName = 'PDV.cargos'
    TableName = 'PDV.cargos'
    Left = 64
    Top = 112
  end
  object queryCargos: TFDQuery
    Connection = fd
    SQL.Strings = (
      'select * from cargos')
    Left = 64
    Top = 176
    object queryCargosid_cargo: TIntegerField
      DisplayLabel = 'ID'
      FieldName = 'id_cargo'
      Origin = 'id_cargo'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object queryCargosnm_cargo: TStringField
      DisplayLabel = 'Cargo'
      FieldName = 'nm_cargo'
      Origin = 'nm_cargo'
      Size = 25
    end
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 'C:\Users\FlexSmart\Documents\Delphi\PDV\trunk\lib\libmySQL.dll'
    Left = 568
    Top = 48
  end
  object dsCargos: TDataSource
    DataSet = queryCargos
    Left = 128
    Top = 176
  end
end
