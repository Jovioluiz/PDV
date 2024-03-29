unit uclFornecedor;

interface

uses
  uPadrao, dFornecedor, uUtil, FireDAC.Stan.Param, Data.DB;

type TFornecedor = class(TPadrao)
  private
    Flogradouro: string;
    Fcpf_cnpj: string;
    Fbairro: string;
    Frg_ie: string;
    Fuf: string;
    Fdata_cadastro: TDate;
    Fcep: string;
    Ftp_pessoa: string;
    Ftipo_produto: string;
    Fnumero: string;
    Fnm_fornecedor: string;
    Fcidade: string;
    Ftelefone: string;
    Fcd_fornecedor: Integer;
    FDados: TdmFornecedor;
    procedure Setbairro(const Value: string);
    procedure Setcd_fornecedor(const Value: Integer);
    procedure Setcep(const Value: string);
    procedure Setcidade(const Value: string);
    procedure Setcpf_cnpj(const Value: string);
    procedure Setdata_cadastro(const Value: TDate);
    procedure Setlogradouro(const Value: string);
    procedure Setnm_fornecedor(const Value: string);
    procedure Setnumero(const Value: string);
    procedure Setrg_ie(const Value: string);
    procedure Settelefone(const Value: string);
    procedure Settipo_produto(const Value: string);
    procedure Settp_pessoa(const Value: string);
    procedure Setuf(const Value: string);
    procedure Inserir;
    procedure Atualizar;

  public

    function Pesquisar(CodFornecedor: Integer): Boolean; override;
    procedure Persistir(Novo: Boolean); override;
    function GeraCodigoFornecedor: Integer;
    function Excluir: Boolean; override;
    procedure Listar;
    constructor Create;
    destructor Destroy; override;

    property cd_fornecedor: Integer read Fcd_fornecedor write Setcd_fornecedor;
    property tp_pessoa: string read Ftp_pessoa write Settp_pessoa;
    property nm_fornecedor: string read Fnm_fornecedor write Setnm_fornecedor;
    property cpf_cnpj: string read Fcpf_cnpj write Setcpf_cnpj;
    property rg_ie: string read Frg_ie write Setrg_ie;
    property telefone: string read Ftelefone write Settelefone;
    property logradouro: string read Flogradouro write Setlogradouro;
    property numero: string read Fnumero write Setnumero;
    property bairro: string read Fbairro write Setbairro;
    property cidade: string read Fcidade write Setcidade;
    property uf: string read Fuf write Setuf;
    property cep: string read Fcep write Setcep;
    property tipo_produto: string read Ftipo_produto write Settipo_produto;
    property data_cadastro: TDate read Fdata_cadastro write Setdata_cadastro;

    property Dados: TdmFornecedor read FDados;


end;

implementation

uses
  FireDAC.Comp.Client, System.SysUtils, dmConexao;

{ TFornecedor }

constructor TFornecedor.Create;
begin
  inherited;
  FDados := TdmFornecedor.Create(nil);
end;

destructor TFornecedor.Destroy;
begin
  FDados.Free;
  inherited;
end;

function TFornecedor.Excluir: Boolean;
const
  SQL = 'delete from fornecedor where cd_fornecedor = :cd_fornecedor';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dConexao.FConexaoBanco;
  qry.SQL.Add(SQL);

  try
    try
      qry.ParamByName('cd_fornecedor').AsInteger := Fcd_fornecedor;
      qry.ExecSQL;

      dConexao.FConexaoBanco.Commit;
    except
      on E:exception do
      begin
        dConexao.FConexaoBanco.Rollback;
        raise Exception.Create('Erro ao excluir os dados ' + E.Message);
      end;
    end;
    Result := True;
  finally
    dConexao.FConexaoBanco.Rollback;
    qry.Free;
  end;
end;

function TFornecedor.GeraCodigoFornecedor: Integer;
const
  SQL = 'select nextval(''cliente_seq'') as cod';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dConexao.FConexaoBanco;
  qry.SQL.Add(SQL);

  try
    qry.Open();

    Result := qry.FieldByName('cod').AsInteger;

  finally
    qry.Free;
  end;
end;

procedure TFornecedor.Atualizar;
{$REGION 'SQL_UPDATE'}
const
  SQL = 'update ' +
        'fornecedor ' +
        'set ' +
        'cd_fornecedor = :cd_fornecedor, ' +
        'tp_pessoa = :tp_pessoa, ' +
        'nm_fornecedor = :nm_fornecedor, ' +
        'cpf_cnpj = :cpf_cnpj, ' +
        'rg_ie = :rg_ie, ' +
        'telefone = :telefone, ' +
        'logradouro = :logradouro, ' +
        'numero = :numero, ' +
        'bairro = :bairro, ' +
        'cidade = :cidade, ' +
        'uf = :uf, ' +
        'cep = :cep, ' +
        'tipo_produto = :tipo_produto, ' +
        'data_cadastro = :data_cadastro';
{$ENDREGION}
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dConexao.FConexaoBanco;
  dConexao.FConexaoBanco.StartTransaction;

  try
    try
      qry.SQL.Add(SQL);
      qry.ParamByName('cd_fornecedor').AsInteger := Fcd_fornecedor;
      qry.ParamByName('tp_pessoa').AsString := Ftp_pessoa;
      qry.ParamByName('nm_fornecedor').AsString := Fnm_fornecedor;
      qry.ParamByName('cpf_cnpj').AsString := Fcpf_cnpj;
      qry.ParamByName('rg_ie').AsString := Frg_ie;
      qry.ParamByName('telefone').AsString := Ftelefone;
      qry.ParamByName('logradouro').AsString := Flogradouro;
      qry.ParamByName('numero').AsString := Fnumero;
      qry.ParamByName('bairro').AsString := Fbairro;
      qry.ParamByName('cidade').AsString := Fcidade;
      qry.ParamByName('uf').AsString := Fuf;
      qry.ParamByName('cep').AsString := Fcep;
      qry.ParamByName('tipo_produto').AsString := Ftipo_produto;
      qry.ParamByName('data_cadastro').AsDate := Fdata_cadastro;
      qry.ExecSQL;
      dConexao.FConexaoBanco.Commit;
    except
      on E:exception do
      begin
        dConexao.FConexaoBanco.Rollback;
        raise Exception.Create('Erro ao gravar os dados ' + E.Message);
      end;
    end;
  finally
    dConexao.FConexaoBanco.Rollback;
    qry.Free;
  end;
end;

procedure TFornecedor.Inserir;
{$REGION 'SQL_INSERT'}
const
  SQL = 'insert ' +
        'into ' +
        'fornecedor (cd_fornecedor, ' +
        'tp_pessoa, ' +
        'nm_fornecedor, ' +
        'cpf_cnpj, ' +
        'rg_ie, ' +
        'telefone, ' +
        'logradouro, ' +
        'numero, ' +
        'bairro, ' +
        'cidade, ' +
        'uf, ' +
        'cep, ' +
        'tipo_produto, ' +
        'data_cadastro) ' +
        'values (:cd_fornecedor, ' +
        ':tp_pessoa, ' +
        ':nm_fornecedor, ' +
        ':cpf_cnpj, ' +
        ':rg_ie, ' +
        ':telefone, ' +
        ':logradouro, ' +
        ':numero, ' +
        ':bairro, ' +
        ':cidade, ' +
        ':uf, ' +
        ':cep, ' +
        ':tipo_produto, ' +
        ':data_cadastro)';
{$ENDREGION}
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dConexao.FConexaoBanco;
  dConexao.FConexaoBanco.StartTransaction;

  try
    try
      qry.SQL.Add(SQL);
      qry.ParamByName('cd_fornecedor').AsInteger := Fcd_fornecedor;
      qry.ParamByName('tp_pessoa').AsString := Ftp_pessoa;
      qry.ParamByName('nm_fornecedor').AsString := Fnm_fornecedor;
      qry.ParamByName('cpf_cnpj').AsString := Fcpf_cnpj;
      qry.ParamByName('rg_ie').AsString := Frg_ie;
      qry.ParamByName('telefone').AsString := Ftelefone;
      qry.ParamByName('logradouro').AsString := Flogradouro;
      qry.ParamByName('numero').AsString := Fnumero;
      qry.ParamByName('bairro').AsString := Fbairro;
      qry.ParamByName('cidade').AsString := Fcidade;
      qry.ParamByName('uf').AsString := Fuf;
      qry.ParamByName('cep').AsString := Fcep;
      qry.ParamByName('tipo_produto').AsString := Ftipo_produto;
      qry.ParamByName('data_cadastro').AsDate := Fdata_cadastro;
      qry.ExecSQL;
      dConexao.FConexaoBanco.Commit;
    except
      on E:exception do
      begin
        dConexao.FConexaoBanco.Rollback;
        raise Exception.Create('Erro ao gravar os dados ' + E.Message);
      end;
    end;
  finally
    dConexao.FConexaoBanco.Rollback;
    qry.Free;
  end;
end;

procedure TFornecedor.Listar;
const
  SQL = 'select ' +
        '    cd_fornecedor, ' +
        '    tp_pessoa, ' +
        '    nm_fornecedor, ' +
        '    cpf_cnpj, ' +
        '    rg_ie, ' +
        '    telefone, ' +
        '    logradouro, ' +
        '    numero, ' +
        '    bairro, ' +
        '    cidade, ' +
        '    uf, ' +
        '    cep, ' +
        '    tipo_produto, ' +
        '    data_cadastro ' +
        'from ' +
        '    fornecedor  ';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dConexao.FConexaoBanco;

  try
    qry.SQL.Add(SQL);
    qry.Open();

    FDados.cdsFornecedor.EmptyDataSet;

    qry.loopSimples(
    procedure
    begin
      FDados.cdsFornecedor.Append;
      FDados.cdsFornecedor.FieldByName('cd_fornecedor').AsInteger := qry.FieldByName('cd_fornecedor').AsInteger;
      FDados.cdsFornecedor.FieldByName('tp_pessoa').AsString := qry.FieldByName('tp_pessoa').AsString;
      FDados.cdsFornecedor.FieldByName('nm_fornecedor').AsString := qry.FieldByName('nm_fornecedor').AsString;
      FDados.cdsFornecedor.FieldByName('cpf_cnpj').AsString := qry.FieldByName('cpf_cnpj').AsString;
      FDados.cdsFornecedor.FieldByName('rg_ie').AsString := qry.FieldByName('rg_ie').AsString;
      FDados.cdsFornecedor.FieldByName('telefone').AsString := qry.FieldByName('telefone').AsString;
      FDados.cdsFornecedor.FieldByName('logradouro').AsString := qry.FieldByName('logradouro').AsString;
      FDados.cdsFornecedor.FieldByName('numero').AsString := qry.FieldByName('numero').AsString;
      FDados.cdsFornecedor.FieldByName('bairro').AsString := qry.FieldByName('bairro').AsString;
      FDados.cdsFornecedor.FieldByName('cidade').AsString := qry.FieldByName('cidade').AsString;
      FDados.cdsFornecedor.FieldByName('uf').AsString := qry.FieldByName('uf').AsString;
      FDados.cdsFornecedor.FieldByName('cep').AsString := qry.FieldByName('cep').AsString;
      FDados.cdsFornecedor.FieldByName('tipo_produto').AsString := qry.FieldByName('tipo_produto').AsString;
      FDados.cdsFornecedor.FieldByName('data_cadastro').AsDateTime := qry.FieldByName('data_cadastro').AsDateTime;
      FDados.cdsFornecedor.Post;
    end
    );

  finally
    qry.Free;
  end;
end;

procedure TFornecedor.Persistir(Novo: Boolean);
begin
  if Novo then
    Inserir
  else
    Atualizar;
end;

function TFornecedor.Pesquisar(CodFornecedor: Integer): Boolean;
const
  SQL = 'select cd_fornecedor from fornecedor where cd_fornecedor = :cd_fornecedor';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dConexao.FConexaoBanco;

  try
    qry.SQL.Add(SQL);
    qry.ParamByName('cd_fornecedor').AsInteger := CodFornecedor;
    qry.Open();

    Result := qry.IsEmpty;

  finally
    qry.Free;
  end;
end;

procedure TFornecedor.Setbairro(const Value: string);
begin
  Fbairro := Value;
end;

procedure TFornecedor.Setcd_fornecedor(const Value: Integer);
begin
  Fcd_fornecedor := Value;
end;

procedure TFornecedor.Setcep(const Value: string);
begin
  Fcep := Value;
end;

procedure TFornecedor.Setcidade(const Value: string);
begin
  Fcidade := Value;
end;

procedure TFornecedor.Setcpf_cnpj(const Value: string);
begin
  Fcpf_cnpj := Value;
end;

procedure TFornecedor.Setdata_cadastro(const Value: TDate);
begin
  Fdata_cadastro := Value;
end;

procedure TFornecedor.Setlogradouro(const Value: string);
begin
  Flogradouro := Value;
end;

procedure TFornecedor.Setnm_fornecedor(const Value: string);
begin
  Fnm_fornecedor := Value;
end;

procedure TFornecedor.Setnumero(const Value: string);
begin
  Fnumero := Value;
end;

procedure TFornecedor.Setrg_ie(const Value: string);
begin
  Frg_ie := Value;
end;

procedure TFornecedor.Settelefone(const Value: string);
begin
  Ftelefone := Value;
end;

procedure TFornecedor.Settipo_produto(const Value: string);
begin
  Ftipo_produto := Value;
end;

procedure TFornecedor.Settp_pessoa(const Value: string);
begin
  Ftp_pessoa := Value;
end;

procedure TFornecedor.Setuf(const Value: string);
begin
  Fuf := Value;
end;

end.
