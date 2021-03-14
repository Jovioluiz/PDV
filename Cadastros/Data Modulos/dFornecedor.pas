unit dFornecedor;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient;

type
  TdmFornecedor = class(TDataModule)
    dsFornecedor: TDataSource;
    cdsFornecedor: TClientDataSet;
    cdsFornecedorcd_fornecedor: TIntegerField;
    cdsFornecedortp_pessoa: TStringField;
    cdsFornecedornm_fornecedor: TStringField;
    cdsFornecedorcpf_cnpj: TStringField;
    cdsFornecedorrg_ie: TStringField;
    cdsFornecedortelefone: TStringField;
    cdsFornecedorlogradouro: TStringField;
    cdsFornecedornumero: TStringField;
    cdsFornecedorbairro: TStringField;
    cdsFornecedorcidade: TStringField;
    cdsFornecedoruf: TStringField;
    cdsFornecedorcep: TStringField;
    cdsFornecedortipo_produto: TStringField;
    cdsFornecedordata_cadastro: TDateField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmFornecedor: TdmFornecedor;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
