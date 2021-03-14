object dmFornecedor: TdmFornecedor
  OldCreateOrder = False
  Height = 102
  Width = 216
  object dsFornecedor: TDataSource
    DataSet = cdsFornecedor
    Left = 39
    Top = 22
  end
  object cdsFornecedor: TClientDataSet
    PersistDataPacket.Data = {
      9A0100009619E0BD01000000180000000E0000000000030000009A010D63645F
      666F726E656365646F7204000100000000000974705F706573736F6101004900
      000001000557494454480200020001000D6E6D5F666F726E656365646F720100
      490000000100055749445448020002001E00086370665F636E706A0100490000
      000100055749445448020002000F000572675F69650100490000000100055749
      445448020002000A000874656C65666F6E650100490000000100055749445448
      0200020014000A6C6F677261646F75726F010049000000010005574944544802
      0002003200066E756D65726F0100490000000100055749445448020002000500
      0662616972726F01004900000001000557494454480200020014000663696461
      6465010049000000010005574944544802000200140002756601004900000001
      0005574944544802000200140003636570010049000000010005574944544802
      00020014000C7469706F5F70726F6475746F0100490000000100055749445448
      0200020014000D646174615F636164617374726F04000600000000000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'cd_fornecedor'
        DataType = ftInteger
      end
      item
        Name = 'tp_pessoa'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'nm_fornecedor'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'cpf_cnpj'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'rg_ie'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'telefone'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'logradouro'
        DataType = ftString
        Size = 50
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
        Size = 20
      end
      item
        Name = 'cep'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'tipo_produto'
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
    Left = 119
    Top = 30
    object cdsFornecedorcd_fornecedor: TIntegerField
      DisplayLabel = 'C'#243'd Fornecedor'
      FieldName = 'cd_fornecedor'
    end
    object cdsFornecedortp_pessoa: TStringField
      FieldName = 'tp_pessoa'
      Visible = False
      Size = 1
    end
    object cdsFornecedornm_fornecedor: TStringField
      DisplayLabel = 'Nome Fornecedor'
      FieldName = 'nm_fornecedor'
      Size = 30
    end
    object cdsFornecedorcpf_cnpj: TStringField
      DisplayLabel = 'CPF/CNPJ'
      FieldName = 'cpf_cnpj'
      Size = 15
    end
    object cdsFornecedorrg_ie: TStringField
      DisplayLabel = 'RG/IE'
      FieldName = 'rg_ie'
      Size = 10
    end
    object cdsFornecedortelefone: TStringField
      DisplayLabel = 'Telefone'
      FieldName = 'telefone'
    end
    object cdsFornecedorlogradouro: TStringField
      FieldName = 'logradouro'
      Visible = False
      Size = 50
    end
    object cdsFornecedornumero: TStringField
      FieldName = 'numero'
      Visible = False
      Size = 5
    end
    object cdsFornecedorbairro: TStringField
      FieldName = 'bairro'
      Visible = False
    end
    object cdsFornecedorcidade: TStringField
      FieldName = 'cidade'
      Visible = False
    end
    object cdsFornecedoruf: TStringField
      FieldName = 'uf'
      Visible = False
    end
    object cdsFornecedorcep: TStringField
      FieldName = 'cep'
      Visible = False
    end
    object cdsFornecedortipo_produto: TStringField
      FieldName = 'tipo_produto'
      Visible = False
    end
    object cdsFornecedordata_cadastro: TDateField
      DisplayLabel = 'Data Cadastro'
      FieldName = 'data_cadastro'
    end
  end
end
