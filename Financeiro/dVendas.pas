unit dVendas;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient, uConexao;

type
  TdmVendas = class(TDataModule)
    dsProdutos: TDataSource;
    cdsProdutos: TClientDataSet;
    cdsProdutosid_produto: TIntegerField;
    cdsProdutoscodigo_barras: TStringField;
    cdsProdutosnm_produto: TStringField;
    cdsProdutosdescricao: TStringField;
    cdsProdutosvalor: TCurrencyField;
    cdsProdutosqtd_estoque: TFloatField;
    cdsProdutosun_medida: TStringField;
    cdsProdutosfator_conversao: TIntegerField;
    cdsProdutosdata_cadastro: TDateField;
    cdsProdutosimagem: TBlobField;
    cdsProdutosdata_ult_compra: TDateField;
    dsDetalhesVendas: TDataSource;
    cdsDetalhesVendas: TClientDataSet;
    cdsDetalhesVendasid_detalhe_venda: TIntegerField;
    cdsDetalhesVendasid_venda: TIntegerField;
    cdsDetalhesVendasid_produto: TIntegerField;
    cdsDetalhesVendasvalor_unitario: TCurrencyField;
    cdsDetalhesVendasqtdade: TFloatField;
    cdsDetalhesVendasvalor_total: TCurrencyField;
    cdsDetalhesVendasid_funcionario: TIntegerField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmVendas: TdmVendas;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}


end.
