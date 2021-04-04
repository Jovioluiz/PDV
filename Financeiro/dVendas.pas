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
    cdsDetalhesVendasid_geral: TLargeintField;
    cdsDetalhesVendasid_venda: TLargeintField;
    cdsDetalhesVendasid_item: TIntegerField;
    cdsDetalhesVendasvl_unitario: TCurrencyField;
    cdsDetalhesVendasqt_venda: TFloatField;
    cdsDetalhesVendasvl_total: TCurrencyField;
    cdsDetalhesVendasid_funcionario: TIntegerField;
    cdsDetalhesVendasnm_produto: TStringField;
    cdsDetalhesVendascd_item: TStringField;
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
