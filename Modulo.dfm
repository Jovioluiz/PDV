object dm: Tdm
  OldCreateOrder = False
  Height = 408
  Width = 679
  object fd: TFDConnection
    Params.Strings = (
      'Server=localhost'
      'Database=PDV'
      'User_Name=root'
      'Password=jovio'
      'DriverID=MySQL')
    Connected = True
    LoginPrompt = False
    Left = 64
    Top = 48
  end
  object tbCargos: TFDTable
    Active = True
    IndexFieldNames = 'id_cargo'
    Connection = fd
    UpdateOptions.UpdateTableName = 'PDV.cargos'
    TableName = 'PDV.cargos'
    Left = 64
    Top = 112
    object tbCargosid_cargo: TIntegerField
      FieldName = 'id_cargo'
      Origin = 'id_cargo'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object tbCargosnm_cargo: TStringField
      FieldName = 'nm_cargo'
      Origin = 'nm_cargo'
      Size = 25
    end
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
end
