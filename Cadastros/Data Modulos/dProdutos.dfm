object dmProdutos: TdmProdutos
  OldCreateOrder = False
  Height = 150
  Width = 215
  object dsProdutos: TDataSource
    DataSet = cdsProdutos
    Left = 32
    Top = 48
  end
  object cdsProdutos: TClientDataSet
    PersistDataPacket.Data = {
      460100009619E0BD01000000180000000B00000000000300000046010769645F
      6974656D04000100000000000763645F6974656D010049000000010005574944
      54480200020014000A6E6D5F70726F6475746F01004900000001000557494454
      480200020032000964657363726963616F010049000000010005574944544802
      00020032000B766C5F756E69746172696F080004000000010007535542545950
      450200490006004D6F6E6579000A71745F6573746F7175650800040000000000
      09756E5F6D656469646101004900000001000557494454480200020005000F66
      61746F725F636F6E76657273616F08000400000000000D646174615F63616461
      7374726F040006000000000006696D6167656D04004B00000001000753554254
      59504502004900070042696E617279000F646174615F756C745F636F6D707261
      04000600000000000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'id_item'
        DataType = ftInteger
      end
      item
        Name = 'cd_item'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'nm_produto'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'descricao'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'vl_unitario'
        DataType = ftCurrency
      end
      item
        Name = 'qt_estoque'
        DataType = ftFloat
      end
      item
        Name = 'un_medida'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'fator_conversao'
        DataType = ftFloat
      end
      item
        Name = 'data_cadastro'
        DataType = ftDate
      end
      item
        Name = 'imagem'
        DataType = ftBlob
      end
      item
        Name = 'data_ult_compra'
        DataType = ftDate
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 96
    Top = 48
    object cdsProdutosid_item: TIntegerField
      FieldName = 'id_item'
      Visible = False
    end
    object cdsProdutoscd_item: TStringField
      DisplayLabel = 'C'#243'd Item'
      FieldName = 'cd_item'
    end
    object cdsProdutosnm_produto: TStringField
      DisplayLabel = 'Nome Produto'
      FieldName = 'nm_produto'
      Size = 50
    end
    object cdsProdutosdescricao: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'descricao'
      Size = 50
    end
    object cdsProdutosvl_unitario: TCurrencyField
      DisplayLabel = 'Valor Unit'#225'rio'
      FieldName = 'vl_unitario'
    end
    object cdsProdutosqt_estoque: TFloatField
      DisplayLabel = 'Quantidade Estoque'
      FieldName = 'qt_estoque'
    end
    object cdsProdutosun_medida: TStringField
      DisplayLabel = 'UN Medida'
      FieldName = 'un_medida'
      Size = 5
    end
    object cdsProdutosfator_conversao: TFloatField
      DisplayLabel = 'Fator Convers'#227'o'
      FieldName = 'fator_conversao'
    end
    object cdsProdutosdata_cadastro: TDateField
      DisplayLabel = 'Data Cadastro'
      FieldName = 'data_cadastro'
    end
    object cdsProdutosimagem: TBlobField
      FieldName = 'imagem'
      Visible = False
    end
    object cdsProdutosdata_ult_compra: TDateField
      DisplayLabel = 'Data '#218'ltima Compra'
      FieldName = 'data_ult_compra'
    end
  end
end
