unit dVendas;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient;

type
  TdmVendas = class(TDataModule)
    dsProdutos: TDataSource;
    cdsProdutos: TClientDataSet;
    dsDetalhesVendas: TDataSource;
    cdsDetalhesVendas: TClientDataSet;
    cdsDetalhesVendasid_detalhe_venda: TIntegerField;
    cdsDetalhesVendasid_venda: TIntegerField;
    cdsDetalhesVendasid_produto: TIntegerField;
    cdsDetalhesVendasvalor_unitario: TCurrencyField;
    cdsDetalhesVendasqtdade: TFloatField;
    cdsDetalhesVendasvalor_total: TCurrencyField;
    cdsDetalhesVendasid_funcionario: TIntegerField;
    dsVendas: TDataSource;
    cdsVendas: TClientDataSet;
    cdsVendasid_venda: TIntegerField;
    cdsVendasvalor_bruto: TCurrencyField;
    cdsVendasid_funcionario: TIntegerField;
    cdsVendasdata_venda: TDateTimeField;
    cdsVendasvalor_troco: TCurrencyField;
    cdsVendasvalor_total: TCurrencyField;
    cdsVendasvalor_desconto: TCurrencyField;
    cdsVendasvalor_recebido: TCurrencyField;
    cdsVendasstatus: TStringField;
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
