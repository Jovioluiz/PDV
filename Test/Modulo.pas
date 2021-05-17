unit Modulo;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.PGDef, FireDAC.Phys.PG,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef;

type
  Tdm = class(TDataModule)
    fd: TFDConnection;
    tbCargos: TFDTable;
    queryCargos: TFDQuery;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    dsCargos: TDataSource;
    tbFuncionario: TFDTable;
    queryFuncionario: TFDQuery;
    dsFuncionario: TDataSource;
    queryCargosid_cargo: TFDAutoIncField;
    queryCargosnm_cargo: TStringField;
    tbUsuarios: TFDTable;
    queryUsuarios: TFDQuery;
    dsUsuarios: TDataSource;
    queryUsuariosid_usuario: TFDAutoIncField;
    queryUsuariosnome: TStringField;
    queryUsuariosusuario: TStringField;
    queryUsuariossenha: TStringField;
    queryUsuarioscargo: TStringField;
    queryUsuariosid_funcionario: TIntegerField;
    tbFornecedor: TFDTable;
    queryFornecedor: TFDQuery;
    dsFonecedor: TDataSource;
    queryFornecedorid_fornecedor: TFDAutoIncField;
    queryFornecedornm_fornecedor: TStringField;
    queryFornecedorcpf_cnpj: TStringField;
    queryFornecedorrg_ie: TStringField;
    queryFornecedortelefone: TStringField;
    queryFornecedorlogradouro: TStringField;
    queryFornecedornumero: TIntegerField;
    queryFornecedorbairro: TStringField;
    queryFornecedorcidade: TStringField;
    queryFornecedoruf: TStringField;
    queryFornecedorcep: TStringField;
    queryFornecedortipo_produto: TStringField;
    queryFornecedordata_cadastro: TDateField;
    queryFornecedortp_pessoa: TStringField;
    queryFuncionarioid_funcionario: TFDAutoIncField;
    queryFuncionariocargo: TStringField;
    queryFuncionarionm_funcionario: TStringField;
    queryFuncionariocpf: TStringField;
    queryFuncionariorg: TStringField;
    queryFuncionariotelefone: TStringField;
    queryFuncionariologradouro: TStringField;
    queryFuncionarionumero: TIntegerField;
    queryFuncionariobairro: TStringField;
    queryFuncionariocidade: TStringField;
    queryFuncionariouf: TStringField;
    queryFuncionariocep: TStringField;
    queryFuncionariodata_cadastro: TDateField;
    tbProdutos: TFDTable;
    queryProdutos: TFDQuery;
    dsProdutos: TDataSource;
    queryProdutosid_produto: TFDAutoIncField;
    queryProdutoscodigo_barras: TStringField;
    queryProdutosnm_produto: TStringField;
    queryProdutosdescricao: TStringField;
    queryProdutosvalor: TBCDField;
    queryProdutosqtd_estoque: TBCDField;
    queryProdutosun_medida: TStringField;
    queryProdutosfator_convesao: TIntegerField;
    queryProdutosdata_cadastro: TDateField;
    queryProdutosimagem: TBlobField;
    queryCoringa: TFDQuery;
    tbEntradaProdutos: TFDTable;
    queryEntradaProdutos: TFDQuery;
    dsEntradaProdutos: TDataSource;
    queryEntradaProdutosid_entrada: TFDAutoIncField;
    queryEntradaProdutosid_produto: TIntegerField;
    queryEntradaProdutosqtdade: TBCDField;
    queryEntradaProdutosid_fornecedor: TIntegerField;
    queryEntradaProdutosvalor: TBCDField;
    queryEntradaProdutostotal: TBCDField;
    queryEntradaProdutosdata_entrada: TDateField;
    queryEntradaProdutosun_compra: TStringField;
    queryEntradaProdutostelefone: TStringField;
    queryEntradaProdutosnm_fornecedor: TStringField;
    queryProdutosdata_ult_compra: TDateField;
    tbSaidaProdutos: TFDTable;
    querySaidaProdutos: TFDQuery;
    dsSaidaProdutos: TDataSource;
    querySaidaProdutosid_saida: TFDAutoIncField;
    querySaidaProdutosid_produto: TIntegerField;
    querySaidaProdutosqtdade: TBCDField;
    querySaidaProdutosmotivo: TStringField;
    querySaidaProdutosdata_saida: TDateField;
    querySaidaProdutosun_saida: TStringField;
    queryEntradaProdutosnm_produto: TStringField;
    tbVendas: TFDTable;
    queryVendas: TFDQuery;
    queryVendasid_venda: TFDAutoIncField;
    queryVendasvalor_bruto: TBCDField;
    queryVendasid_funcionario: TIntegerField;
    queryVendasdata_venda: TDateTimeField;
    queryVendasvalor_troco: TBCDField;
    queryVendasvalor_total: TBCDField;
    dsVendas: TDataSource;
    tbDetalhesVendas: TFDTable;
    queryDetalhesVendas: TFDQuery;
    queryDetalhesVendasid_detalhe_venda: TFDAutoIncField;
    queryDetalhesVendasid_venda: TIntegerField;
    queryDetalhesVendasid_produto: TIntegerField;
    queryDetalhesVendasvalor_unitario: TBCDField;
    queryDetalhesVendasqtdade: TBCDField;
    queryDetalhesVendasvalor_total: TBCDField;
    dsDetalhesVendas: TDataSource;
    queryDetalhesVendasid_funcionario: TIntegerField;
    queryVendasvalor_desconto: TBCDField;
    tbMovimentacoes: TFDTable;
    queryMovimentacoes: TFDQuery;
    dsMovimentacoes: TDataSource;
    queryVendasvalor_recebido: TBCDField;
    tbGastos: TFDTable;
    queryGastos: TFDQuery;
    queryGastosid_gasto: TFDAutoIncField;
    queryGastosmotivo: TStringField;
    queryGastosvalor: TBCDField;
    queryGastosid_funcionario: TIntegerField;
    queryGastosdata: TDateField;
    dsGastos: TDataSource;
    queryVendasstatus: TStringField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

  //declaração de variáveis globais

  idFuncionario : String;
  nomeFuncionario : String;
  cargoFuncionario : String;

  chamada : String;

  nomeUsuario : String;
  cargoUsuario : String;
  FCdUsuario : Integer;

  codigoBarrasProduto : String;

  idFornecedor : String;
  nomeFornecedor : String;

  nomeProduto : String;
  estoqueProduto : Double;
  idproduto : String;
  unMedida : String;

  totalProdutos : Double;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
  fd.Connected := True;
end;

end.
