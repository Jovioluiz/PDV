unit dProdutos;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient;

type
  TdmProdutos = class(TDataModule)
    dsProdutos: TDataSource;
    cdsProdutos: TClientDataSet;
    cdsProdutosid_item: TIntegerField;
    cdsProdutoscd_item: TStringField;
    cdsProdutosnm_produto: TStringField;
    cdsProdutosdescricao: TStringField;
    cdsProdutosvl_unitario: TCurrencyField;
    cdsProdutosqt_estoque: TFloatField;
    cdsProdutosun_medida: TStringField;
    cdsProdutosfator_conversao: TFloatField;
    cdsProdutosdata_cadastro: TDateField;
    cdsProdutosimagem: TBlobField;
    cdsProdutosdata_ult_compra: TDateField;
    cdsProdutoscodigo_barras: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmProdutos: TdmProdutos;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
