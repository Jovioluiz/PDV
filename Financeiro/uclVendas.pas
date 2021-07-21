unit uclVendas;

interface

uses
  dVendas, uPadrao, Data.DB, uUtil, FireDAC.Stan.Param;

type TVenda = class
  private
    FDados: TdmVendas;
    FIDVenda: Int64;
    FIDDetalhesVenda: Int64;
    procedure SetFDados(const Value: TdmVendas);
    function GetNumeroVenda: Integer;
    procedure SetIDVenda(const Value: Int64);
    procedure SetIDDetalhesVenda(const Value: Int64);

  public
    function BuscarProdutos(CodBarras: string): Boolean;
    function RetornaValorTotal(dataset: TDataset): Currency;
    procedure SalvarVenda(Inserir: Boolean);
    procedure SalvarDetalhesVendas(Inserir: Boolean);
    procedure AtualizaEstoque(Qtdade: Double; IDItem: Integer);
    procedure CancelaVenda(IDVenda: Int64);
    function TotalEstoque(IDItem: Integer): Double;

    constructor Create;
    destructor Destroy; override;

  property Dados: TdmVendas read FDados write SetFDados;
  property IDVenda: Int64 read FIDVenda write SetIDVenda;
  property IDDetalhesVenda: Int64 read FIDDetalhesVenda write SetIDDetalhesVenda;
end;

implementation

uses
  FireDAC.Comp.Client, dmConexao, System.SysUtils;

{ TVenda }

procedure TVenda.AtualizaEstoque(Qtdade: Double; IDItem: Integer);
const
  SQL = 'update '+
        'produtos set qt_estoque = :qtdade '+
        'where '+
        'id_item = :id_item';
var
  qry: TFDquery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dConexao.FConexaoBanco;

  try
    try
      qry.SQL.Add(SQL);
      qry.ParamByName('qtdade').AsFloat := Qtdade;
      qry.ParamByName('id_item').AsInteger := IDItem;
      qry.ExecSQL;
      dConexao.FConexaoBanco.Commit;
    except on e:Exception do
      begin
        dConexao.FConexaoBanco.Rollback;
        raise Exception.Create('Erro ao atualizar o estoque do item ID Item: ' + IDItem.ToString + e.Message);
      end;
    end;
  finally
    dConexao.FConexaoBanco.Rollback;
    qry.Free;
  end;
end;

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
  qry.Connection := dConexao.FConexaoBanco;
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

procedure TVenda.CancelaVenda(IDVenda: Int64);
const
  SQL = 'update vendas set status = ''CA'' where id_geral = :id_geral';
var
  query: TFDQuery;
begin
  query := TFDQuery.Create(nil);
  query.Connection := dconexao.FConexaoBanco;

  try
    query.SQL.Add(SQL);
    query.ParamByName('id_geral').AsLargeInt := IDVenda;
    query.ExecSQL;

    dconexao.FConexaoBanco.Commit;

  finally
    dconexao.FConexaoBanco.Rollback;
    query.Free;
  end;
end;

constructor TVenda.Create;
begin
  FDados := TdmVendas.Create(nil);
  FIDVenda := 0;
  FIDDetalhesVenda := 0;
end;

destructor TVenda.Destroy;
begin
  FIDVenda := 0;
  FIDDetalhesVenda := 0;
  FDados.Free;
  inherited;
end;

function TVenda.GetNumeroVenda: Integer;
const
  SQL = 'select * from func_nr_pedido() as id_venda';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dconexao.FConexaoBanco;

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
      valorTotal := valorTotal + dataset.FieldByName('vl_total').AsCurrency;
      dataset.Next;
    end;

    Result := valorTotal;
  finally
    dataset.EnableControls;
  end;
end;

procedure TVenda.SalvarDetalhesVendas(Inserir: Boolean);
{$REGION 'SQL'}
const
  SQL = 'insert ' +
        '   into ' +
        '      detalhes_vendas (id_geral, ' +
        '      id_vendas, ' +
        '      id_item, ' +
        '      vl_unitario, ' +
        '      qt_venda, ' +
        '      vl_total,      ' +
        '      fl_cancelado) ' +
        'values (:id_geral, ' +
        '      :id_vendas, ' +
        '      :id_item, ' +
        '      :vl_unitario, ' +
        '      :qt_venda, ' +
        '      :vl_total, '+
        '      :fl_cancelado)';
  SQL_UPDATE =  'update ' +
                '    detalhes_vendas ' +
                'set ' +
                '    id_item = :id_item, ' +
                '    vl_unitario = :vl_unitario, ' +
                '    qt_venda = :qt_venda, ' +
                '    vl_total = :vl_total, ' +
                '    fl_cancelado = :fl_cancelado ' +
                'where ' +
                '    id_geral = :id_geral';
{$ENDREGION}
var
  qry: TFDQuery;
//  id: TUtil;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dConexao.FConexaoBanco;
//  id := TUtil.Create;

  try
    try
      if Inserir then
      begin
        qry.SQL.Add(SQL);
        qry.ParamByName('id_geral').AsLargeInt := FIDDetalhesVenda;
        qry.ParamByName('id_vendas').AsLargeInt := FIDVenda;
        qry.ParamByName('id_item').AsInteger := Dados.cdsDetalhesVendas.FieldByName('id_item').AsInteger;
        qry.ParamByName('vl_unitario').AsCurrency := Dados.cdsDetalhesVendas.FieldByName('vl_unitario').AsCurrency;
        qry.ParamByName('qt_venda').AsFloat := Dados.cdsDetalhesVendas.FieldByName('qt_venda').AsFloat;
        qry.ParamByName('vl_total').AsCurrency := Dados.cdsDetalhesVendas.FieldByName('vl_total').AsCurrency;
        qry.ParamByName('fl_cancelado').AsString := Dados.cdsDetalhesVendas.FieldByName('fl_cancelado').AsString;
        qry.ExecSQL;
      end
      else
      begin
        qry.SQL.Add(SQL_UPDATE);
        qry.ParamByName('id_geral').AsLargeInt := Dados.cdsDetalhesVendas.FieldByName('id_geral').AsLargeInt;//não tá passando o id certo
        qry.ParamByName('id_item').AsInteger := Dados.cdsDetalhesVendas.FieldByName('id_item').AsInteger;
        qry.ParamByName('vl_unitario').AsCurrency := Dados.cdsDetalhesVendas.FieldByName('vl_unitario').AsCurrency;
        qry.ParamByName('qt_venda').AsFloat := Dados.cdsDetalhesVendas.FieldByName('qt_venda').AsFloat;
        qry.ParamByName('vl_total').AsCurrency := Dados.cdsDetalhesVendas.FieldByName('vl_total').AsCurrency;
        qry.ParamByName('fl_cancelado').AsString := Dados.cdsDetalhesVendas.FieldByName('fl_cancelado').AsString;
        qry.ExecSQL;
      end;
      dConexao.FConexaoBanco.Commit;
    except on e:Exception do
      begin
        dConexao.FConexaoBanco.Rollback;
        raise Exception.Create('Erro ao gravar os dados dos itens!' + e.Message);
      end;
    end;
  finally
    dConexao.FConexaoBanco.Rollback;
//    id.Free;
    qry.Free;
  end;
end;

procedure TVenda.SalvarVenda(Inserir: Boolean);
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

  SQL_UPDATE =  'update ' +
                '    vendas ' +
                'set ' +
                '    vl_troco = :vl_troco, ' +
                '    vl_total = :vl_total, ' +
                '    vl_desconto = :vl_desconto, ' +
                '    vl_acrescimo = :vl_acrescimo, ' +
                '    vl_recebido = :vl_recebido, ' +
                '    status = :status ' +
                'where ' +
                '    id_geral = :id_geral ';


{$ENDREGION}
var
  qry: TFDQuery;
  id: TUtil;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dConexao.FConexaoBanco;
  id := TUtil.Create;

  try
    try
      if Inserir then
      begin
        qry.SQL.Add(SQL);
        qry.ParamByName('id_geral').AsLargeInt := id.GeraIdGeral;
        FIDVenda := qry.ParamByName('id_geral').AsLargeInt;
        qry.ParamByName('nr_venda').AsInteger := GetNumeroVenda;
        qry.ParamByName('cd_funcionario').AsInteger := Dados.cdsVendas.FieldByName('id_funcionario').AsInteger;
        qry.ParamByName('data_venda').AsDateTime := Dados.cdsVendas.FieldByName('data_venda').AsDateTime;
        qry.ParamByName('vl_troco').AsCurrency := Dados.cdsVendas.FieldByName('valor_troco').AsCurrency;
        qry.ParamByName('vl_total').AsCurrency := Dados.cdsVendas.FieldByName('valor_total').AsCurrency;
        qry.ParamByName('vl_desconto').AsCurrency := Dados.cdsVendas.FieldByName('valor_desconto').AsCurrency;
        qry.ParamByName('vl_acrescimo').AsCurrency := 0;
        qry.ParamByName('vl_recebido').AsCurrency := Dados.cdsVendas.FieldByName('valor_recebido').AsCurrency;
        qry.ParamByName('status').AsString := Dados.cdsVendas.FieldByName('status').AsString;
        qry.ExecSQL;
      end
      else
      begin
        qry.SQL.Add(SQL_UPDATE);
        qry.ParamByName('id_geral').AsLargeInt := FIDVenda;
        qry.ParamByName('vl_troco').AsCurrency := Dados.cdsVendas.FieldByName('valor_troco').AsCurrency;
        qry.ParamByName('vl_total').AsCurrency := Dados.cdsVendas.FieldByName('valor_total').AsCurrency;
        qry.ParamByName('vl_desconto').AsCurrency := Dados.cdsVendas.FieldByName('valor_desconto').AsCurrency;
        qry.ParamByName('vl_acrescimo').AsCurrency := 0;
        qry.ParamByName('vl_recebido').AsCurrency := Dados.cdsVendas.FieldByName('valor_recebido').AsCurrency;
        qry.ParamByName('status').AsString := 'C';
        qry.ExecSQL;
      end;
      dConexao.FConexaoBanco.Commit;
    except on e:Exception do
      begin
        dConexao.FConexaoBanco.Rollback;
        raise Exception.Create('Erro ao gravar os dados da venda!');
      end;
    end;
  finally
    dConexao.FConexaoBanco.Rollback;
    id.Free;
    qry.Free;
  end;
end;

procedure TVenda.SetFDados(const Value: TdmVendas);
begin
  FDados := Value;
end;

procedure TVenda.SetIDDetalhesVenda(const Value: Int64);
begin
  FIDDetalhesVenda := Value;
end;

procedure TVenda.SetIDVenda(const Value: Int64);
begin
  FIDVenda := Value;
end;

function TVenda.TotalEstoque(IDItem: Integer): Double;
const
  SQL = 'select qt_estoque from produtos where id_item = :id_item';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dConexao.FConexaoBanco;

  try
    qry.Open(SQL, [IDItem]);

    if qry.IsEmpty then
      Exit(0);

    Result := qry.FieldByName('qt_estoque').AsFloat;

  finally
    qry.Free;
  end;
end;

end.
