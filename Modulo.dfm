object dm: Tdm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 585
  Width = 941
  object fd: TFDConnection
    Params.Strings = (
      'Server=localhost'
      'Database=pdv'
      'User_Name=jovio'
      'Password=MaverickV8'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 24
    Top = 16
  end
  object tbCargos: TFDTable
    IndexFieldNames = 'id_cargo'
    Connection = fd
    UpdateOptions.UpdateTableName = 'cargos'
    TableName = 'cargos'
    Left = 16
    Top = 88
  end
  object queryCargos: TFDQuery
    Connection = fd
    SQL.Strings = (
      'select * from cargos order by nm_cargo asc')
    Left = 32
    Top = 192
    object queryCargosid_cargo: TFDAutoIncField
      FieldName = 'id_cargo'
      Origin = 'id_cargo'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object queryCargosnm_cargo: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'nm_cargo'
      Origin = 'nm_cargo'
      Size = 25
    end
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 'C:\Users\jovio\OneDrive\Documentos\PDV\trunk\lib\libmySQL.dll'
    Left = 544
    Top = 16
  end
  object dsCargos: TDataSource
    DataSet = queryCargos
    Left = 104
    Top = 192
  end
  object tbFuncionario: TFDTable
    IndexFieldNames = 'id_funcionario'
    Connection = fd
    UpdateOptions.UpdateTableName = 'funcionarios'
    TableName = 'funcionarios'
    Left = 72
    Top = 88
  end
  object queryFuncionario: TFDQuery
    Connection = fd
    SQL.Strings = (
      'select * from funcionarios')
    Left = 168
    Top = 192
    object queryFuncionarioid_funcionario: TFDAutoIncField
      FieldName = 'id_funcionario'
      Origin = 'id_funcionario'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object queryFuncionariocargo: TStringField
      DisplayLabel = 'Cargo'
      FieldName = 'cargo'
      Origin = 'cargo'
      Required = True
      Size = 25
    end
    object queryFuncionarionm_funcionario: TStringField
      DisplayLabel = 'Nome Funcionario'
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
      Size = 15
    end
    object queryFuncionariologradouro: TStringField
      DisplayLabel = 'Logradouro'
      FieldName = 'logradouro'
      Origin = 'logradouro'
      Required = True
      Size = 50
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
      Size = 50
    end
    object queryFuncionariocidade: TStringField
      DisplayLabel = 'Cidade'
      FieldName = 'cidade'
      Origin = 'cidade'
      Required = True
      Size = 50
    end
    object queryFuncionariouf: TStringField
      DisplayLabel = 'UF'
      FieldName = 'uf'
      Origin = 'uf'
      Required = True
      Size = 2
    end
    object queryFuncionariocep: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'cep'
      Origin = 'cep'
      Size = 10
    end
    object queryFuncionariodata_cadastro: TDateField
      AutoGenerateValue = arDefault
      FieldName = 'data_cadastro'
      Origin = 'data_cadastro'
      Visible = False
    end
  end
  object dsFuncionario: TDataSource
    DataSet = queryFuncionario
    Left = 248
    Top = 192
  end
  object tbUsuarios: TFDTable
    IndexFieldNames = 'id_usuario'
    Connection = fd
    UpdateOptions.UpdateTableName = 'pdv.usuarios'
    TableName = 'pdv.usuarios'
    Left = 136
    Top = 88
  end
  object queryUsuarios: TFDQuery
    Connection = fd
    SQL.Strings = (
      'select *from usuarios')
    Left = 328
    Top = 192
    object queryUsuariosid_usuario: TFDAutoIncField
      DisplayLabel = 'ID'
      FieldName = 'id_usuario'
      Origin = 'id_usuario'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
      Visible = False
    end
    object queryUsuariosnome: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Nome'
      FieldName = 'nome'
      Origin = 'nome'
      Size = 30
    end
    object queryUsuariosusuario: TStringField
      DisplayLabel = 'Usuario'
      FieldName = 'usuario'
      Origin = 'usuario'
      Required = True
      Size = 30
    end
    object queryUsuariossenha: TStringField
      DisplayLabel = 'Senha'
      FieldName = 'senha'
      Origin = 'senha'
      Required = True
      Size = 25
    end
    object queryUsuarioscargo: TStringField
      DisplayLabel = 'Cargo'
      FieldName = 'cargo'
      Origin = 'cargo'
      Required = True
      Size = 25
    end
    object queryUsuariosid_funcionario: TIntegerField
      DisplayLabel = 'ID'
      FieldName = 'id_funcionario'
      Origin = 'id_funcionario'
      Required = True
      Visible = False
    end
  end
  object dsUsuarios: TDataSource
    DataSet = queryUsuarios
    Left = 408
    Top = 192
  end
  object tbFornecedor: TFDTable
    Connection = fd
    UpdateOptions.UpdateTableName = 'pdv.fornecedor'
    TableName = 'pdv.fornecedor'
    Left = 208
    Top = 88
  end
  object queryFornecedor: TFDQuery
    Connection = fd
    SQL.Strings = (
      'select *from fornecedor')
    Left = 488
    Top = 192
    object queryFornecedorid_fornecedor: TFDAutoIncField
      DisplayLabel = 'ID'
      FieldName = 'id_fornecedor'
      Origin = 'id_fornecedor'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object queryFornecedornm_fornecedor: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'nm_fornecedor'
      Origin = 'nm_fornecedor'
      Required = True
      Size = 25
    end
    object queryFornecedorcpf_cnpj: TStringField
      DisplayLabel = 'CPF/CNPJ'
      FieldName = 'cpf_cnpj'
      Origin = 'cpf_cnpj'
      Required = True
      Size = 15
    end
    object queryFornecedorrg_ie: TStringField
      DisplayLabel = 'RG/IE'
      FieldName = 'rg_ie'
      Origin = 'rg_ie'
      Required = True
    end
    object queryFornecedortelefone: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Telefone'
      FieldName = 'telefone'
      Origin = 'telefone'
      Size = 15
    end
    object queryFornecedorlogradouro: TStringField
      DisplayLabel = 'Logradouro'
      FieldName = 'logradouro'
      Origin = 'logradouro'
      Required = True
      Size = 50
    end
    object queryFornecedornumero: TIntegerField
      DisplayLabel = 'Numero'
      FieldName = 'numero'
      Origin = 'numero'
      Required = True
    end
    object queryFornecedorbairro: TStringField
      DisplayLabel = 'Bairro'
      FieldName = 'bairro'
      Origin = 'bairro'
      Required = True
      Size = 50
    end
    object queryFornecedorcidade: TStringField
      DisplayLabel = 'Cidade'
      FieldName = 'cidade'
      Origin = 'cidade'
      Required = True
      Size = 50
    end
    object queryFornecedoruf: TStringField
      DisplayLabel = 'UF'
      FieldName = 'uf'
      Origin = 'uf'
      Required = True
      Size = 2
    end
    object queryFornecedorcep: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'CEP'
      FieldName = 'cep'
      Origin = 'cep'
      Size = 10
    end
    object queryFornecedortipo_produto: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Tipo Produto'
      FieldName = 'tipo_produto'
      Origin = 'tipo_produto'
      Size = 50
    end
    object queryFornecedordata_cadastro: TDateField
      AutoGenerateValue = arDefault
      FieldName = 'data_cadastro'
      Origin = 'data_cadastro'
      Visible = False
    end
    object queryFornecedortp_pessoa: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Pessoa'
      FieldName = 'tp_pessoa'
      Origin = 'tp_pessoa'
      Size = 1
    end
  end
  object dsFonecedor: TDataSource
    DataSet = queryFornecedor
    Left = 568
    Top = 192
  end
  object tbProdutos: TFDTable
    Connection = fd
    UpdateOptions.UpdateTableName = 'pdv.produtos'
    TableName = 'pdv.produtos'
    Left = 264
    Top = 88
  end
  object queryProdutos: TFDQuery
    Connection = fd
    SQL.Strings = (
      'select *from produtos')
    Left = 32
    Top = 272
    object queryProdutosid_produto: TFDAutoIncField
      DisplayLabel = 'ID'
      DisplayWidth = 5
      FieldName = 'id_produto'
      Origin = 'id_produto'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object queryProdutoscodigo_barras: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Codigo Barras'
      DisplayWidth = 15
      FieldName = 'codigo_barras'
      Origin = 'codigo_barras'
      Size = 15
    end
    object queryProdutosnm_produto: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Nome Produto'
      DisplayWidth = 25
      FieldName = 'nm_produto'
      Origin = 'nm_produto'
      Size = 50
    end
    object queryProdutosdescricao: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Descri'#231#227'o'
      DisplayWidth = 25
      FieldName = 'descricao'
      Origin = 'descricao'
      Size = 100
    end
    object queryProdutosvalor: TBCDField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Valor'
      DisplayWidth = 10
      FieldName = 'valor'
      Origin = 'valor'
      currency = True
      Precision = 15
    end
    object queryProdutosqtd_estoque: TBCDField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Estoque'
      DisplayWidth = 5
      FieldName = 'qtd_estoque'
      Origin = 'qtd_estoque'
      Precision = 15
    end
    object queryProdutosun_medida: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'UN Medida'
      FieldName = 'un_medida'
      Origin = 'un_medida'
      Size = 5
    end
    object queryProdutosfator_convesao: TIntegerField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Fator Conversao'
      DisplayWidth = 5
      FieldName = 'fator_conversao'
      Origin = 'fator_convesao'
    end
    object queryProdutosdata_cadastro: TDateField
      AutoGenerateValue = arDefault
      FieldName = 'data_cadastro'
      Origin = 'data_cadastro'
      Visible = False
    end
    object queryProdutosimagem: TBlobField
      AutoGenerateValue = arDefault
      FieldName = 'imagem'
      Origin = 'imagem'
      Visible = False
    end
    object queryProdutosdata_ult_compra: TDateField
      AutoGenerateValue = arDefault
      DisplayLabel = #218'ltima Compra'
      FieldName = 'data_ult_compra'
      Origin = 'data_ult_compra'
    end
  end
  object dsProdutos: TDataSource
    DataSet = queryProdutos
    Left = 104
    Top = 272
  end
  object queryCoringa: TFDQuery
    Connection = fd
    Left = 424
    Top = 16
  end
  object tbEntradaProdutos: TFDTable
    Connection = fd
    UpdateOptions.UpdateTableName = 'pdv.entrada_produtos'
    TableName = 'pdv.entrada_produtos'
    Left = 352
    Top = 88
  end
  object queryEntradaProdutos: TFDQuery
    Connection = fd
    SQL.Strings = (
      'select *from entrada_produtos')
    Left = 192
    Top = 272
    object queryEntradaProdutosid_entrada: TFDAutoIncField
      DisplayLabel = 'ID Entrada'
      FieldName = 'id_entrada'
      Origin = 'id_entrada'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object queryEntradaProdutosid_produto: TIntegerField
      DisplayLabel = 'ID Produto'
      FieldName = 'id_produto'
      Origin = 'id_produto'
      Required = True
    end
    object queryEntradaProdutosnm_produto: TStringField
      DisplayLabel = 'Produto'
      FieldName = 'nm_produto'
    end
    object queryEntradaProdutosqtdade: TBCDField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Qtdade'
      FieldName = 'qtdade'
      Origin = 'qtdade'
      Precision = 12
    end
    object queryEntradaProdutosid_fornecedor: TIntegerField
      DisplayLabel = 'ID Fornecedor'
      FieldName = 'id_fornecedor'
      Origin = 'id_fornecedor'
      Required = True
    end
    object queryEntradaProdutosvalor: TBCDField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Valor'
      DisplayWidth = 10
      FieldName = 'valor'
      Origin = 'valor'
      currency = True
      Precision = 12
    end
    object queryEntradaProdutostotal: TBCDField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Total'
      DisplayWidth = 10
      FieldName = 'total'
      Origin = 'total'
      currency = True
      Precision = 12
    end
    object queryEntradaProdutosdata_entrada: TDateField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Data Entrada'
      FieldName = 'data_entrada'
      Origin = 'data_entrada'
    end
    object queryEntradaProdutosun_compra: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'UN Compra'
      FieldName = 'un_compra'
      Origin = 'un_compra'
      Size = 5
    end
    object queryEntradaProdutosnm_fornecedor: TStringField
      DisplayLabel = 'Fornecedor'
      FieldName = 'nm_fornecedor'
      Size = 30
    end
    object queryEntradaProdutostelefone: TStringField
      DisplayLabel = 'Telefone'
      FieldName = 'telefone'
      Size = 15
    end
  end
  object dsEntradaProdutos: TDataSource
    DataSet = queryEntradaProdutos
    Left = 296
    Top = 272
  end
  object tbSaidaProdutos: TFDTable
    Connection = fd
    UpdateOptions.UpdateTableName = 'pdv.saidas_produtos'
    TableName = 'pdv.saidas_produtos'
    Left = 448
    Top = 88
  end
  object querySaidaProdutos: TFDQuery
    Connection = fd
    SQL.Strings = (
      'select * from saidas_produtos')
    Left = 416
    Top = 272
    object querySaidaProdutosid_saida: TFDAutoIncField
      FieldName = 'id_saida'
      Origin = 'id_saida'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object querySaidaProdutosid_produto: TIntegerField
      DisplayLabel = 'Produto'
      DisplayWidth = 15
      FieldName = 'id_produto'
      Origin = 'id_produto'
      Required = True
    end
    object querySaidaProdutosqtdade: TBCDField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Qtdade'
      FieldName = 'qtdade'
      Origin = 'qtdade'
      Precision = 12
    end
    object querySaidaProdutosmotivo: TStringField
      DisplayLabel = 'Motivo'
      FieldName = 'motivo'
      Origin = 'motivo'
      Required = True
      Size = 50
    end
    object querySaidaProdutosdata_saida: TDateField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Data Saida'
      FieldName = 'data_saida'
      Origin = 'data_saida'
    end
    object querySaidaProdutosun_saida: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'UN Saida'
      FieldName = 'un_saida'
      Origin = 'un_saida'
      Size = 5
    end
  end
  object dsSaidaProdutos: TDataSource
    DataSet = querySaidaProdutos
    Left = 528
    Top = 272
  end
  object tbVendas: TFDTable
    IndexFieldNames = 'id_venda'
    Connection = fd
    UpdateOptions.UpdateTableName = 'pdv.vendas'
    TableName = 'pdv.vendas'
    Left = 24
    Top = 344
  end
  object queryVendas: TFDQuery
    Connection = fd
    SQL.Strings = (
      'select *from vendas')
    Left = 96
    Top = 344
    object queryVendasid_venda: TFDAutoIncField
      DisplayLabel = 'ID'
      FieldName = 'id_venda'
      Origin = 'id_venda'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object queryVendasvalor_bruto: TBCDField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Valor Bruto'
      FieldName = 'valor_bruto'
      Origin = 'valor_bruto'
      ReadOnly = True
      currency = True
      Precision = 12
    end
    object queryVendasid_funcionario: TIntegerField
      DisplayLabel = 'ID Funcionario'
      FieldName = 'id_funcionario'
      Origin = 'id_funcionario'
      ReadOnly = True
      Required = True
    end
    object queryVendasdata_venda: TDateTimeField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Data'
      FieldName = 'data_venda'
      Origin = 'data_venda'
      ReadOnly = True
    end
    object queryVendasvalor_troco: TBCDField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Valor Troco'
      FieldName = 'valor_troco'
      Origin = 'valor_troco'
      ReadOnly = True
      currency = True
      Precision = 12
    end
    object queryVendasvalor_total: TBCDField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Valor Total'
      FieldName = 'valor_total'
      Origin = 'valor_total'
      ReadOnly = True
      currency = True
      Precision = 12
    end
    object queryVendasvalor_desconto: TBCDField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Desconto'
      FieldName = 'valor_desconto'
      Origin = 'valor_desconto'
      ReadOnly = True
      currency = True
      Precision = 12
    end
    object queryVendasvalor_recebido: TBCDField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Valor Recebido'
      FieldName = 'valor_recebido'
      Origin = 'valor_recebido'
      ReadOnly = True
      currency = True
      Precision = 12
    end
    object queryVendasstatus: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Status'
      FieldName = 'status'
      Origin = '`status`'
      ReadOnly = True
      Size = 5
    end
  end
  object dsVendas: TDataSource
    DataSet = queryVendas
    Left = 168
    Top = 344
  end
  object tbDetalhesVendas: TFDTable
    Connection = fd
    UpdateOptions.UpdateTableName = 'detalhes_vendas'
    TableName = 'detalhes_vendas'
    Left = 536
    Top = 88
  end
  object queryDetalhesVendas: TFDQuery
    Connection = fd
    SQL.Strings = (
      'select * from detalhes_vendas')
    Left = 248
    Top = 344
    object queryDetalhesVendasid_detalhe_venda: TFDAutoIncField
      DisplayLabel = 'ID Detalhe Venda'
      FieldName = 'id_detalhe_venda'
      Origin = 'id_detalhe_venda'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object queryDetalhesVendasid_venda: TIntegerField
      FieldName = 'id_venda'
      Origin = 'id_venda'
      Required = True
      Visible = False
    end
    object queryDetalhesVendasid_produto: TIntegerField
      FieldName = 'id_produto'
      Origin = 'id_produto'
      Required = True
      Visible = False
    end
    object queryDetalhesVendasvalor_unitario: TBCDField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Valor Unitario'
      FieldName = 'valor_unitario'
      Origin = 'valor_unitario'
      Visible = False
      currency = True
      Precision = 12
    end
    object queryDetalhesVendasqtdade: TBCDField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Quantidade'
      DisplayWidth = 8
      FieldName = 'qtdade'
      Origin = 'qtdade'
      Precision = 10
      Size = 2
    end
    object queryDetalhesVendasvalor_total: TBCDField
      DisplayLabel = 'Valor Total'
      DisplayWidth = 10
      FieldName = 'valor_total'
      Origin = 'valor_total'
      Required = True
      currency = True
      Precision = 12
    end
    object queryDetalhesVendasid_funcionario: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'id_funcionario'
      Origin = 'id_funcionario'
      Visible = False
    end
  end
  object dsDetalhesVendas: TDataSource
    DataSet = queryDetalhesVendas
    Left = 352
    Top = 344
  end
  object tbMovimentacoes: TFDTable
    Connection = fd
    UpdateOptions.UpdateTableName = 'pdv.movimentacoes'
    TableName = 'pdv.movimentacoes'
    Left = 624
    Top = 88
  end
  object queryMovimentacoes: TFDQuery
    Connection = fd
    Left = 464
    Top = 344
  end
  object dsMovimentacoes: TDataSource
    DataSet = queryMovimentacoes
    Left = 560
    Top = 344
  end
  object tbGastos: TFDTable
    Connection = fd
    UpdateOptions.UpdateTableName = 'pdv.gastos'
    TableName = 'pdv.gastos'
    Left = 696
    Top = 88
  end
  object queryGastos: TFDQuery
    Connection = fd
    SQL.Strings = (
      'select *from gastos')
    Left = 632
    Top = 344
    object queryGastosid_gasto: TFDAutoIncField
      DisplayLabel = 'ID'
      FieldName = 'id_gasto'
      Origin = 'id_gasto'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
      Visible = False
    end
    object queryGastosmotivo: TStringField
      DisplayLabel = 'Motivo'
      FieldName = 'motivo'
      Origin = 'motivo'
      Required = True
      Size = 25
    end
    object queryGastosvalor: TBCDField
      DisplayLabel = 'Valor'
      FieldName = 'valor'
      Origin = 'valor'
      Required = True
      currency = True
      Precision = 12
    end
    object queryGastosid_funcionario: TIntegerField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Funcionario'
      FieldName = 'id_funcionario'
      Origin = 'id_funcionario'
    end
    object queryGastosdata: TDateField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Data'
      FieldName = 'data'
      Origin = '`data`'
    end
  end
  object dsGastos: TDataSource
    DataSet = queryGastos
    Left = 688
    Top = 344
  end
end
