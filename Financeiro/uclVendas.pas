unit uclVendas;

interface

uses
  dVendas, uPadrao, Data.DB, uUtil, FireDAC.Stan.Param;

type TVenda = class
  private
    FDados: TdmVendas;
    procedure SetFDados(const Value: TdmVendas);
    function GetIDVenda: Integer;

  public
    function BuscarProdutos(CodBarras: string): Boolean;
    function RetornaValorTotal(dataset: TDataset): Currency;
    procedure SalvarVenda;

  constructor Create;

  property Dados: TdmVendas read FDados write SetFDados;
end;

implementation

uses
  FireDAC.Comp.Client, dmConexao, System.SysUtils;

{ TVenda }

function TVenda.BuscarProdutos(CodBarras: string): Boolean;
const
  SQL = 'select ' +
        '    p.id_item, ' +
        '    p.cd_item, ' +
        '    p.nm_produto, ' +
        '    p.descricao, ' +
        '    p.vl_unitario, ' +
        '    p.qt_estoque, ' +
        '    p.un_medida, ' +
        '    p.fator_conversao, ' +
        '    p.imagem, ' +
        '    pcb.codigo_barras ' +
        'from produtos p ' +
        '    join produtos_cod_barras pcb on ' +
        'pcb.id_item = p.id_item ' +
        '    where pcb.codigo_barras = :codigo_barras ';
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
      Dados.cdsProdutos.FieldByName('id_item').AsInteger := qry.FieldByName('id_item').AsInteger;
      Dados.cdsProdutos.FieldByName('cd_item').AsString := qry.FieldByName('cd_item').AsString;
      Dados.cdsProdutos.FieldByName('nm_produto').AsString := qry.FieldByName('nm_produto').AsString;
      Dados.cdsProdutos.FieldByName('descricao').AsString := qry.FieldByName('descricao').AsString;
      Dados.cdsProdutos.FieldByName('vl_unitario').AsCurrency := qry.FieldByName('vl_unitario').AsCurrency;
      Dados.cdsProdutos.FieldByName('qt_estoque').AsFloat := qry.FieldByName('qt_estoque').AsFloat;
      Dados.cdsProdutos.FieldByName('un_medida').AsString := qry.FieldByName('un_medida').AsString;
      Dados.cdsProdutos.FieldByName('fator_conversao').AsInteger := qry.FieldByName('fator_conversao').AsInteger;
      Dados.cdsProdutos.FieldByName('imagem').AsBytes := qry.FieldByName('imagem').AsBytes;
      Dados.cdsProdutos.FieldByName('codigo_barras').AsString := qry.FieldByName('codigo_barras').AsString;
      Dados.cdsProdutos.Post;
    end
    else
      raise Exception.Create('Produto não encontrado!');

  finally
    qry.Free;
  end;
end;

constructor TVenda.Create;
begin
  FDados := TdmVendas.Create(nil);
end;

function TVenda.GetIDVenda: Integer;
const
  SQL = 'select * from func_nr_pedido() as id_venda';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dconexao.conexaoBanco;

  try
    qry.SQL.Add(SQL);
    qry.Open();

    Result := qry.FieldByName('id_venda').AsInteger;

  finally
    qry.Free;
  end;
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

procedure TVenda.SalvarVenda;
{$REGION 'SQL'}
const
  SQL = 'insert ' +
        '   into ' +
        '      vendas (id_geral, ' +
        '      nr_venda, ' +
        '      cd_funcionario, ' +
        '      data_venda, ' +
        '      vl_troco, ' +
        '      vl_total, ' +
        '      vl_desconto, ' +
        '      vl_acrescimo, ' +
        '      vl_recebido, ' +
        '      status) ' +
        'values (:id_geral, ' +
        '      :nr_venda, ' +
        '      :cd_funcionario, ' +
        '      :data_venda, ' +
        '      :vl_troco, ' +
        '      :vl_total, ' +
        '      :vl_desconto, ' +
        '      :vl_acrescimo, ' +
        '      :vl_recebido, ' +
        '      :status)';
{$ENDREGION}
var
  qry: TFDQuery;
  id: TUtil;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dConexao.conexaoBanco;
  id := TUtil.Create;

  try
    try
      qry.SQL.Add(SQL);
      qry.ParamByName('id_geral').AsLargeInt := id.GeraIdGeral;
      qry.ParamByName('nr_venda').AsInteger := GetIDVenda;
      qry.ParamByName('cd_funcionario').AsInteger := Dados.cdsVendas.FieldByName('id_funcionario').AsInteger;
      qry.ParamByName('data_venda').AsDateTime := Dados.cdsVendas.FieldByName('data_venda').AsDateTime;
      qry.ParamByName('vl_troco').AsCurrency := Dados.cdsVendas.FieldByName('valor_troco').AsCurrency;
      qry.ParamByName('vl_total').AsCurrency := Dados.cdsVendas.FieldByName('valor_total').AsCurrency;
      qry.ParamByName('vl_desconto').AsCurrency := Dados.cdsVendas.FieldByName('valor_desconto').AsCurrency;
      //qry.ParamByName('vl_acrescimo').AsLargeInt;
      qry.ParamByName('vl_recebido').AsCurrency := Dados.cdsVendas.FieldByName('valor_recebido').AsCurrency;
      qry.ParamByName('status').AsString := Dados.cdsVendas.FieldByName('status').AsString;
      qry.ExecSQL;
      dConexao.conexaoBanco.Commit;
    except on e:Exception do
      begin
        dConexao.conexaoBanco.Rollback;
        raise Exception.Create('Erro ao gravar os dados da venda!');
      end;
    end;
  finally
    dConexao.conexaoBanco.Rollback;
    id.Free;
    qry.Free;
  end;
end;

procedure TVenda.SetFDados(const Value: TdmVendas);
begin
  FDados := Value;
end;

end.
