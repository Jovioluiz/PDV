unit uclProdutoCodBarras;

interface

uses
  uPadrao;

type TProdutoCodBarras = class(TPadrao)
  private
    Fcodigo_barras: string;
    Fid_geral: Int64;
    Fid_item: Integer;
    procedure Inserir;
    procedure Atualizar;
    procedure Setcodigo_barras(const Value: string);
    procedure Setid_geral(const Value: Int64);
    procedure Setid_item(const Value: Integer);

  public
    function Pesquisar(Codigo: Integer): Boolean; override;
    function PesquisarCodBarras(IDItem: Integer; CodigoBarras: string): Boolean;
    procedure Persistir(Novo: Boolean); override;
    function Excluir: Boolean; override;

    property id_geral: Int64 read Fid_geral write Setid_geral;
    property id_item: Integer read Fid_item write Setid_item;
    property codigo_barras: string read Fcodigo_barras write Setcodigo_barras;
end;

implementation

uses
  dmConexao, FireDAC.Comp.Client, System.SysUtils, uUtil;

{ TProdutoCodBarras }

procedure TProdutoCodBarras.Atualizar;
const
  SQL_UPDATE = 'update produtos_cod_barras set codigo_barras = :codigo_barras where id_geral = :id_geral';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dConexao.conexaoBanco;

  try
    try
      qry.SQL.Add(SQL_UPDATE);
      qry.ParamByName('codigo_barras').AsString := Fcodigo_barras;
      qry.ParamByName('id_geral').AsLargeInt := Fid_geral;
      qry.ExecSQL;

    except
      on E:exception do
      begin
        dConexao.conexaoBanco.Rollback;
        raise Exception.Create('Erro ao gravar os dados ' + E.Message);
      end;
    end;

    dConexao.conexaoBanco.Commit;

  finally
    dConexao.conexaoBanco.Rollback;
    qry.Free;
  end;
end;

function TProdutoCodBarras.Excluir: Boolean;
begin

end;

procedure TProdutoCodBarras.Persistir(Novo: Boolean);
begin
  if Novo then
    Inserir
  else
    Atualizar;
end;

function TProdutoCodBarras.PesquisarCodBarras(IDItem: Integer; CodigoBarras: string): Boolean;
const
  SQL = 'select id_geral from produtos_cod_barras where id_item = :id_item and codigo_barras = :codigo_barras';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dConexao.conexaoBanco;

  try
    qry.Open(SQL, [IDItem, CodigoBarras]);

    Result := qry.IsEmpty;

  finally
    qry.Free;
  end;
end;

function TProdutoCodBarras.Pesquisar(Codigo: Integer): Boolean;
begin
//
end;

procedure TProdutoCodBarras.Inserir;
const
  SQL_INSERT = 'insert into produtos_cod_barras (id_geral, id_item, codigo_barras) values(:id_geral, :id_item, :codigo_barras)';
var
  qry: TFDQuery;
  getIdGeral: TUtil;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dConexao.conexaoBanco;
  getIdGeral := TUtil.Create;

  try
    try
      qry.SQL.Add(SQL_INSERT);
      qry.ParamByName('id_geral').AsLargeInt := getIdGeral.GeraIdGeral;
      qry.ParamByName('id_item').AsInteger := Fid_item;
      qry.ParamByName('codigo_barras').AsString := Fcodigo_barras;
      qry.ExecSQL;
    except
      on E:exception do
      begin
        dConexao.conexaoBanco.Rollback;
        raise Exception.Create('Erro ao gravar os dados ' + E.Message);
      end;
    end;

    dConexao.conexaoBanco.Commit;
  finally
    qry.Free;
    getIdGeral.Free;
  end;
end;

procedure TProdutoCodBarras.Setcodigo_barras(const Value: string);
begin
  Fcodigo_barras := Value;
end;

procedure TProdutoCodBarras.Setid_geral(const Value: Int64);
begin
  Fid_geral := Value;
end;

procedure TProdutoCodBarras.Setid_item(const Value: Integer);
begin
  Fid_item := Value;
end;

end.
