unit uclVendas;

interface

uses
  dVendas, uPadrao, Data.DB, uUtil, FireDAC.Stan.Param;

type TVenda = class
  private
    FDados: TdmVendas;
    procedure SetFDados(const Value: TdmVendas);


  public
    function BuscarProdutos(CodBarras: string): Boolean;
    function RetornaValorTotal(dataset: TDataset): Currency;
    function SalvarVenda(): Boolean;

  constructor Create;

  property Dados: TdmVendas read FDados write SetFDados;
end;

implementation

uses
  FireDAC.Comp.Client, dmConexao;

{ TVenda }

function TVenda.BuscarProdutos(CodBarras: string): Boolean;
const
  SQL = 'select * '+
        '   from '+
        'produtos '+
        '   where '+
        'codigo_barras = :codigo_barras';
var
  qry: TFDquery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dConexao.conexaoBanco;
  Result := True;

  try
    qry.SQL.Add(SQL);
    qry.ParamByName('codigo_barras').AsString := CodBarras;
    qry.Open();

    if not qry.IsEmpty then
    begin
      Dados.cdsProdutos.Append;
      Dados.cdsProdutos.FieldByName('id_produto').AsInteger := qry.FieldByName('id_produto').AsInteger;
      Dados.cdsProdutos.FieldByName('codigo_barras').AsString := qry.FieldByName('codigo_barras').AsString;
      Dados.cdsProdutos.FieldByName('nm_produto').AsString := qry.FieldByName('nm_produto').AsString;
      Dados.cdsProdutos.FieldByName('descricao').AsString := qry.FieldByName('descricao').AsString;
      Dados.cdsProdutos.FieldByName('valor').AsCurrency := qry.FieldByName('valor').AsCurrency;
      Dados.cdsProdutos.FieldByName('qtd_estoque').AsFloat := qry.FieldByName('qtd_estoque').AsFloat;
      Dados.cdsProdutos.FieldByName('un_medida').AsString := qry.FieldByName('un_medida').AsString;
      Dados.cdsProdutos.FieldByName('fator_conversao').AsInteger := qry.FieldByName('fator_conversao').AsInteger;
      Dados.cdsProdutos.FieldByName('data_cadastro').AsDateTime := qry.FieldByName('data_cadastro').AsDateTime;
      Dados.cdsProdutos.FieldByName('imagem').AsBytes := qry.FieldByName('imagem').AsBytes;
      Dados.cdsProdutos.FieldByName('data_ult_compra').AsDateTime := qry.FieldByName('data_ult_compra').AsDateTime;
      Dados.cdsProdutos.Post;
    end
    else
      Exit(False);

  finally
    qry.Free;
  end;
end;

constructor TVenda.Create;
begin
  FDados := TdmVendas.Create(nil);
end;

function TVenda.RetornaValorTotal(dataset: TDataset): Currency;
var
  valorTotal: Currency;
begin
  if dataset.IsEmpty then
    Exit(0);

  valorTotal := 0;
  dataset.DisableControls;

  try
    dataset.First;
    while not dataset.Eof do
    begin
      valorTotal := valorTotal + dataset.FieldByName('valor_total').AsCurrency;
      dataset.Next;
    end;

    Result := valorTotal;
  finally
    dataset.EnableControls;
  end;
end;

function TVenda.SalvarVenda: Boolean;
begin
//
end;

procedure TVenda.SetFDados(const Value: TdmVendas);
begin
  FDados := Value;
end;

end.
