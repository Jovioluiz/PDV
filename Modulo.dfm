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
    Connected = True
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
      'select * from cargos order by nm_cargo asc')
    Left = 56
    Top = 232
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
    Left = 136
    Top = 232
  end
  object tbFuncionario: TFDTable
    Connection = fd
    UpdateOptions.UpdateTableName = 'PDV.funcionarios'
    TableName = 'PDV.funcionarios'
    Left = 136
    Top = 112
  end
  object queryFuncionario: TFDQuery
    Connection = fd
    SQL.Strings = (
      'select *from funcionarios')
    Left = 232
    Top = 232
    object queryFuncionarioid_funcionario: TFDAutoIncField
      FieldName = 'id_funcionario'
      Origin = 'id_funcionario'
      ProviderFlags = [pfInWhere, pfInKey]
      Visible = False
      DisplayFormat = 'ID'
    end
    object queryFuncionariocargo: TStringField
      DisplayLabel = 'Cargo'
      FieldName = 'cargo'
      Origin = 'cargo'
      Required = True
      Size = 25
    end
    object queryFuncionarionm_funcionario: TStringField
      DisplayLabel = 'Funcion'#225'rio'
      FieldName = 'nm_funcionario'
      Origin = 'nm_funcionario'
      Required = True
      Size = 25
    end
    object queryFuncionariocpf: TStringField
      DisplayLabel = 'CPF'
      FieldName = 'cpf'
      Origin = 'cpf'
      Required = True
      Size = 15
    end
    object queryFuncionariorg: TStringField
      DisplayLabel = 'RG'
      FieldName = 'rg'
      Origin = 'rg'
      Required = True
    end
    object queryFuncionariotelefone: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Telefone'
      FieldName = 'telefone'
      Origin = 'telefone'
      Size = 10
    end
    object queryFuncionariologradouro: TStringField
      DisplayLabel = 'Logradouro'
      FieldName = 'logradouro'
      Origin = 'logradouro'
      Required = True
      Size = 30
    end
    object queryFuncionarionumero: TIntegerField
      DisplayLabel = 'Numero'
      FieldName = 'numero'
      Origin = 'numero'
      Required = True
    end
    object queryFuncionariobairro: TStringField
      DisplayLabel = 'Bairro'
      FieldName = 'bairro'
      Origin = 'bairro'
      Required = True
    end
    object queryFuncionariocidade: TStringField
      DisplayLabel = 'Cidade'
      FieldName = 'cidade'
      Origin = 'cidade'
      Required = True
    end
    object queryFuncionariouf: TStringField
      DisplayLabel = 'UF'
      FieldName = 'uf'
      Origin = 'uf'
      Required = True
      Size = 3
    end
    object queryFuncionariocep: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'CEP'
      FieldName = 'cep'
      Origin = 'cep'
      Size = 10
    end
    object queryFuncionariodata_cadastro: TDateField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Data Cadastro'
      FieldName = 'data_cadastro'
      Origin = 'data_cadastro'
    end
  end
  object dsFuncionario: TDataSource
    DataSet = queryFuncionario
    Left = 320
    Top = 232
  end
end
