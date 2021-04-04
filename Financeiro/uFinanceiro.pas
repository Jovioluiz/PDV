unit uFinanceiro;

interface

type TFinanceiro = class
  private

  public
    procedure InserirMovimentacoes(EntradaSaida, TipoMovimento: String; Valor: Currency; CodUsuario: Integer; IDVenda, IDGasto: Int64);
end;

implementation

uses
  FireDAC.Comp.Client, dmConexao, System.SysUtils, System.Math, uUtil;

{ TFinanceiro }

procedure TFinanceiro.InserirMovimentacoes(EntradaSaida, TipoMovimento: String; Valor: Currency; CodUsuario: Integer; IDVenda, IDGasto: Int64);
const
  SQL = 'insert '+
        '   into '+
        'movimentacoes '+
        '   (id_geral, fl_entrada_saida, tp_movimento, vl_movimento, cd_funcionario, data, id_venda, id_movimento_gasto) '+
        'values '+
        '   (:id_geral, :fl_entrada_saida, :tp_movimento, :vl_movimento, :cd_funcionario, :data, :id_venda, :id_movimento_gasto)';
var
  qry: TFDQuery;
  id: TUtil;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dConexao.ConexaoBanco;
  id := TUtil.Create;

  try
    try
      qry.SQL.Add(SQL);
      qry.ParamByName('id_geral').AsLargeInt := id.GeraIdGeral;
      qry.ParamByName('fl_entrada_saida').AsString := EntradaSaida;
      qry.ParamByName('tp_movimento').AsString := TipoMovimento;
      qry.ParamByName('vl_movimento').AsCurrency := Valor;
      qry.ParamByName('cd_funcionario').AsInteger := CodUsuario;
      qry.ParamByName('data').AsDate := Now;
      qry.ParamByName('id_venda').AsLargeInt := IDVenda;
      qry.ParamByName('id_movimento_gasto').AsLargeInt := ifthen(IDVenda > 0, 0, IDGasto);
      qry.ExecSQL;

      dConexao.ConexaoBanco.Commit;
    except on e:Exception do
      begin
        dConexao.conexaoBanco.Rollback;
        raise Exception.Create('Erro ao gravar os dados da movimentação!');
      end;
    end;

  finally
    qry.Free;
    id.Free;
  end;
end;

end.
