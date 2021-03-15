object dmFuncionario: TdmFuncionario
  OldCreateOrder = False
  Height = 150
  Width = 215
  object dsFuncionario: TDataSource
    DataSet = cdsFuncionario
    Left = 56
    Top = 56
  end
  object cdsFuncionario: TClientDataSet
    PersistDataPacket.Data = {
      830100009619E0BD01000000180000000E00000000000300000083010E63645F
      66756E63696F6E6172696F04000100000000000863645F636172676F04000100
      00000000086E6D5F636172676F01004900000001000557494454480200020014
      000E6E6D5F66756E63696F6E6172696F01004900000001000557494454480200
      02001E00036370660100490000000100055749445448020002000F0002726701
      004900000001000557494454480200020014000874656C65666F6E6501004900
      000001000557494454480200020014000A6C6F677261646F75726F0100490000
      000100055749445448020002001E00066E756D65726F01004900000001000557
      494454480200020005000662616972726F010049000000010005574944544802
      0002001400066369646164650100490000000100055749445448020002001400
      0275660100490000000100055749445448020002000200036365700100490000
      0001000557494454480200020014000D646174615F636164617374726F040006
      00000000000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'cd_funcionario'
        DataType = ftInteger
      end
      item
        Name = 'cd_cargo'
        DataType = ftInteger
      end
      item
        Name = 'nm_cargo'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'nm_funcionario'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'cpf'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'rg'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'telefone'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'logradouro'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'numero'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'bairro'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'cidade'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'uf'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'cep'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'data_cadastro'
        DataType = ftDate
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 128
    Top = 56
    object cdsFuncionariocd_funcionario: TIntegerField
      DisplayLabel = 'C'#243'd Funcion'#225'rio'
      FieldName = 'cd_funcionario'
    end
    object cdsFuncionariocd_cargo: TIntegerField
      FieldName = 'cd_cargo'
      Visible = False
    end
    object cdsFuncionarionm_cargo: TStringField
      FieldName = 'nm_cargo'
    end
    object cdsFuncionarionm_funcionario: TStringField
      DisplayLabel = 'Funcion'#225'rio'
      FieldName = 'nm_funcionario'
      Size = 30
    end
    object cdsFuncionariocpf: TStringField
      DisplayLabel = 'CPF'
      FieldName = 'cpf'
      Size = 15
    end
    object cdsFuncionariorg: TStringField
      DisplayLabel = 'RG'
      FieldName = 'rg'
    end
    object cdsFuncionariotelefone: TStringField
      FieldName = 'telefone'
      Visible = False
    end
    object cdsFuncionariologradouro: TStringField
      FieldName = 'logradouro'
      Visible = False
      Size = 30
    end
    object cdsFuncionarionumero: TStringField
      FieldName = 'numero'
      Visible = False
      Size = 5
    end
    object cdsFuncionariobairro: TStringField
      FieldName = 'bairro'
      Visible = False
    end
    object cdsFuncionariocidade: TStringField
      FieldName = 'cidade'
      Visible = False
    end
    object cdsFuncionariouf: TStringField
      FieldName = 'uf'
      Visible = False
      Size = 2
    end
    object cdsFuncionariocep: TStringField
      FieldName = 'cep'
      Visible = False
    end
    object cdsFuncionariodata_cadastro: TDateField
      DisplayLabel = 'Data Cadastro'
      FieldName = 'data_cadastro'
    end
  end
end
