object dmVendas: TdmVendas
  OldCreateOrder = False
  Height = 310
  Width = 282
  object dsProdutos: TDataSource
    DataSet = cdsProdutos
    Left = 40
    Top = 40
  end
  object cdsProdutos: TClientDataSet
    PersistDataPacket.Data = {
      3A0100009619E0BD01000000180000000A0000000000030000003A010769645F
      6974656D04000100000000000763645F6974656D010049000000010005574944
      54480200020014000A6E6D5F70726F6475746F01004900000001000557494454
      480200020014000964657363726963616F010049000000010005574944544802
      00020014000B766C5F756E69746172696F080004000000010007535542545950
      450200490006004D6F6E6579000A71745F6573746F7175650800040000000000
      09756E5F6D656469646101004900000001000557494454480200020014000F66
      61746F725F636F6E76657273616F040001000000000006696D6167656D04004B
      0000000100075355425459504502004900070042696E617279000D636F646967
      6F5F62617272617301004900000001000557494454480200020014000000}
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
        Size = 20
      end
      item
        Name = 'descricao'
        DataType = ftString
        Size = 20
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
        Size = 20
      end
      item
        Name = 'fator_conversao'
        DataType = ftInteger
      end
      item
        Name = 'imagem'
        DataType = ftBlob
      end
      item
        Name = 'codigo_barras'
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 144
    Top = 40
  end
  object dsDetalhesVendas: TDataSource
    DataSet = cdsDetalhesVendas
    Left = 40
    Top = 192
  end
  object cdsDetalhesVendas: TClientDataSet
    PersistDataPacket.Data = {
      E00000009619E0BD010000001800000008000000000003000000E0000869645F
      676572616C08000100000000000869645F76656E646108000100000000000769
      645F6974656D04000100000000000B766C5F756E69746172696F080004000000
      010007535542545950450200490006004D6F6E6579000871745F76656E646108
      0004000000000008766C5F746F74616C08000400000001000753554254595045
      0200490006004D6F6E6579000E69645F66756E63696F6E6172696F0400010000
      0000000A6E6D5F70726F6475746F010049000000010005574944544802000200
      14000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'id_geral'
        DataType = ftLargeint
      end
      item
        Name = 'id_venda'
        DataType = ftLargeint
      end
      item
        Name = 'id_item'
        DataType = ftInteger
      end
      item
        Name = 'vl_unitario'
        DataType = ftCurrency
      end
      item
        Name = 'qt_venda'
        DataType = ftFloat
      end
      item
        Name = 'vl_total'
        DataType = ftCurrency
      end
      item
        Name = 'id_funcionario'
        DataType = ftInteger
      end
      item
        Name = 'nm_produto'
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 136
    Top = 184
    object cdsDetalhesVendasid_geral: TLargeintField
      FieldName = 'id_geral'
      Visible = False
    end
    object cdsDetalhesVendasid_venda: TLargeintField
      FieldName = 'id_venda'
      Visible = False
    end
    object cdsDetalhesVendasid_item: TIntegerField
      FieldName = 'id_item'
      Visible = False
    end
    object cdsDetalhesVendasnm_produto: TStringField
      DisplayLabel = 'Produto'
      FieldName = 'nm_produto'
    end
    object cdsDetalhesVendasvl_unitario: TCurrencyField
      DisplayLabel = 'Valor Unit'#225'rio'
      FieldName = 'vl_unitario'
    end
    object cdsDetalhesVendasqt_venda: TFloatField
      DisplayLabel = 'Qtdade'
      FieldName = 'qt_venda'
    end
    object cdsDetalhesVendasvl_total: TCurrencyField
      DisplayLabel = 'Valor Total'
      FieldName = 'vl_total'
    end
    object cdsDetalhesVendasid_funcionario: TIntegerField
      FieldName = 'id_funcionario'
      Visible = False
    end
  end
  object dsVendas: TDataSource
    DataSet = cdsVendas
    Left = 32
    Top = 112
  end
  object cdsVendas: TClientDataSet
    PersistDataPacket.Data = {
      3E0100009619E0BD0100000018000000090000000000030000003E010869645F
      76656E646104000100000000000B76616C6F725F627275746F08000400000001
      0007535542545950450200490006004D6F6E6579000E69645F66756E63696F6E
      6172696F04000100000000000A646174615F76656E646108000800000000000B
      76616C6F725F74726F636F080004000000010007535542545950450200490006
      004D6F6E6579000B76616C6F725F746F74616C08000400000001000753554254
      5950450200490006004D6F6E6579000E76616C6F725F646573636F6E746F0800
      04000000010007535542545950450200490006004D6F6E6579000E76616C6F72
      5F726563656269646F080004000000010007535542545950450200490006004D
      6F6E657900067374617475730100490000000100055749445448020002001400
      0000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'id_venda'
        DataType = ftInteger
      end
      item
        Name = 'valor_bruto'
        DataType = ftCurrency
      end
      item
        Name = 'id_funcionario'
        DataType = ftInteger
      end
      item
        Name = 'data_venda'
        DataType = ftDateTime
      end
      item
        Name = 'valor_troco'
        DataType = ftCurrency
      end
      item
        Name = 'valor_total'
        DataType = ftCurrency
      end
      item
        Name = 'valor_desconto'
        DataType = ftCurrency
      end
      item
        Name = 'valor_recebido'
        DataType = ftCurrency
      end
      item
        Name = 'status'
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 120
    Top = 120
    object cdsVendasid_venda: TIntegerField
      FieldName = 'id_venda'
    end
    object cdsVendasvalor_bruto: TCurrencyField
      FieldName = 'valor_bruto'
    end
    object cdsVendasid_funcionario: TIntegerField
      FieldName = 'id_funcionario'
    end
    object cdsVendasdata_venda: TDateTimeField
      FieldName = 'data_venda'
    end
    object cdsVendasvalor_troco: TCurrencyField
      FieldName = 'valor_troco'
    end
    object cdsVendasvalor_total: TCurrencyField
      FieldName = 'valor_total'
    end
    object cdsVendasvalor_desconto: TCurrencyField
      FieldName = 'valor_desconto'
    end
    object cdsVendasvalor_recebido: TCurrencyField
      FieldName = 'valor_recebido'
    end
    object cdsVendasstatus: TStringField
      FieldName = 'status'
    end
  end
end
