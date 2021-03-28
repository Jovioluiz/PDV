unit uclFuncionario;

interface

uses
  dFuncionario, uUtil, uPadrao, FireDAC.Stan.Param, Data.DB;

type TFuncionario = class(TPadrao)

  private
    Flogradouro: string;
    Fnm_funcionario: string;
    Fcd_cargo: Integer;
    Frg: string;
    Fbairro: string;
    Fuf: string;
    Fdata_cadastro: TDate;
    Fcpf: string;
    Fcd_funcionario: Integer;
    Fcep: string;
    Fnumero: string;
    Fcidade: string;
    Ftelefone: string;
    FDados: TdmFuncionario;
    procedure Setbairro(const Value: string);
    procedure Setcd_cargo(const Value: Integer);
    procedure Setcd_funcionario(const Value: Integer);
    procedure Setcep(const Value: string);
    procedure Setcidade(const Value: string);
    procedure Setcpf(const Value: string);
    procedure Setdata_cadastro(const Value: TDate);
    procedure Setlogradouro(const Value: string);
    procedure Setnm_funcionario(const Value: string);
    procedure Setnumero(const Value: string);
    procedure Setrg(const Value: string);
    procedure Settelefone(const Value: string);
    procedure Setuf(const Value: string);

    procedure Inserir;
    procedure Atualizar;

  public

    function Pesquisar(CodFuncionario: Integer): Boolean; override;
    procedure Persistir(Novo: Boolean); override;
    procedure Listar;
    function GeraCodFuncionario: Integer;
    function GetCodCargo(Cargo: string): Integer;
    function Excluir: Boolean; override;
    constructor Create;
    destructor Destroy; override;

    property cd_funcionario: Integer read Fcd_funcionario write Setcd_funcionario;
    property cd_cargo: Integer read Fcd_cargo write Setcd_cargo;
    property nm_funcionario: string read Fnm_funcionario write Setnm_funcionario;
    property cpf: string read Fcpf write Setcpf;
    property rg: string read Frg write Setrg;
    property telefone: string read Ftelefone write Settelefone;
    property logradouro: string read Flogradouro write Setlogradouro;
    property numero: string read Fnumero write Setnumero;
    property bairro: string read Fbairro write Setbairro;
    property cidade: string read Fcidade write Setcidade;
    property uf: string read Fuf write Setuf;
    property cep: string read Fcep write Setcep;
    property data_cadastro: TDate read Fdata_cadastro write Setdata_cadastro;
    property Dados: TdmFuncionario read FDados;

end;

implementation

uses
  FireDAC.Comp.Client, dmConexao, System.SysUtils;

{ TFuncionario }

procedure TFuncionario.Atualizar;
const
  SQL = 'update '+
        '    funcionarios set '+
        '    nm_funcionario = :nm_funcionario, '+
        '    cpf = :cpf, '+
        '    rg = :rg, '+
        '    telefone = :telefone, '+
        '    logradouro = :logradouro, '+
        '    numero = :numero, '+
        '    bairro = :bairro,'+
        '    cidade = :cidade, '+
        '    uf = :uf, '+
        '    cep = :cep, '+
        '    cargo = :cargo '+
        'where cd_funcionario = :cd_funcionario';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dConexao.conexaoBanco;
  qry.SQL.Add(SQL);

  try
    try
      qry.SQL.Add(SQL);
      qry.ParamByName('cd_funcionario').AsInteger := Fcd_funcionario;
      qry.ParamByName('cd_cargo').AsInteger := Fcd_cargo;
      qry.ParamByName('nm_funcionario').AsString := Fnm_funcionario;
      qry.ParamByName('cpf').AsString := Fcpf;
      qry.ParamByName('rg').AsString := Frg;
      qry.ParamByName('telefone').AsString := Ftelefone;
      qry.ParamByName('logradouro').AsString := Flogradouro;
      qry.ParamByName('numero').AsString := Fnumero;
      qry.ParamByName('bairro').AsString := Fbairro;
      qry.ParamByName('cidade').AsString := Fcidade;
      qry.ParamByName('uf').AsString := Fuf;
      qry.ParamByName('cep').AsString := Fcep;
      qry.ParamByName('data_cadastro').AsDate := Fdata_cadastro;
      qry.ExecSQL;
      dConexao.conexaoBanco.Commit;
    except
      on E:exception do
      begin
        dConexao.conexaoBanco.Rollback;
        raise Exception.Create('Erro ao gravar os dados ' + E.Message);
      end;
    end;

  finally
    dConexao.conexaoBanco.Rollback;
    qry.Free;
  end;
end;

constructor TFuncionario.Create;
begin
  FDados := TdmFuncionario.Create(nil);
end;

destructor TFuncionario.Destroy;
begin
  FDados.Free;
  inherited;
end;

function TFuncionario.Excluir: Boolean;
const
  SQL = 'delete from funcionarios where cd_funcionario = :cd_funcionario';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dConexao.conexaoBanco;
  qry.SQL.Add(SQL);

  try
    try
      qry.ParamByName('cd_funcionario').AsInteger := Fcd_funcionario;
      qry.ExecSQL;

      dConexao.conexaoBanco.Commit;
    except
      on E:exception do
      begin
        dConexao.conexaoBanco.Rollback;
        raise Exception.Create('Erro ao excluir os dados ' + E.Message);
      end;
    end;
    Result := True;
  finally
    dConexao.conexaoBanco.Rollback;
    qry.Free;
  end;
end;

function TFuncionario.GeraCodFuncionario: Integer;
const
  SQL = 'select max(cd_funcionario) + 1 as cod from funcionarios';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dConexao.conexaoBanco;

  try
    qry.SQL.Add(SQL);
    qry.Open();

    Result := qry.FieldByName('cod').AsInteger;

  finally
    qry.Free;
  end;
end;

function TFuncionario.GetCodCargo(Cargo: string): Integer;
const
  SQL = 'select cd_cargo from cargos where nm_cargo = Upper(:nm_cargo)';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dConexao.conexaoBanco;

  try
    qry.SQL.Add(SQL);
    qry.ParamByName('nm_cargo').AsString := Cargo;
    qry.Open();

    Result := qry.FieldByName('cd_cargo').AsInteger;

  finally
    qry.Free;
  end;
end;

procedure TFuncionario.Inserir;
{$REGION 'SQL_INSERT'}
const
  SQL = 'insert ' +
        'into ' +
        'funcionarios (cd_funcionario, ' +
        'cd_cargo, ' +
        'nm_funcionario, ' +
        'cpf, ' +
        'rg, ' +
        'telefone, ' +
        'logradouro, ' +
        'numero, ' +
        'bairro, ' +
        'cidade, ' +
        'uf, ' +
        'cep, ' +
        'data_cadastro) ' +
        'values (:cd_funcionario, ' +
        ':cd_cargo, ' +
        ':nm_funcionario, ' +
        ':cpf, ' +
        ':rg, ' +
        ':telefone, ' +
        ':logradouro, ' +
        ':numero, ' +
        ':bairro, ' +
        ':cidade, ' +
        ':uf, ' +
        ':cep, ' +
        ':data_cadastro)';
{$ENDREGION}
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dConexao.conexaoBanco;

  try
    try
      qry.SQL.Add(SQL);
      qry.ParamByName('cd_funcionario').AsInteger := Fcd_funcionario;
      qry.ParamByName('cd_cargo').AsInteger := Fcd_cargo;
      qry.ParamByName('nm_funcionario').AsString := Fnm_funcionario;
      qry.ParamByName('cpf').AsString := Fcpf;
      qry.ParamByName('rg').AsString := Frg;
      qry.ParamByName('telefone').AsString := Ftelefone;
      qry.ParamByName('logradouro').AsString := Flogradouro;
      qry.ParamByName('numero').AsString := Fnumero;
      qry.ParamByName('bairro').AsString := Fbairro;
      qry.ParamByName('cidade').AsString := Fcidade;
      qry.ParamByName('uf').AsString := Fuf;
      qry.ParamByName('cep').AsString := Fcep;
      qry.ParamByName('data_cadastro').AsDate := Fdata_cadastro;
      qry.ExecSQL;
      dConexao.conexaoBanco.Commit;
    except
      on E:exception do
      begin
        dConexao.conexaoBanco.Rollback;
        raise Exception.Create('Erro ao gravar os dados ' + E.Message);
      end;
    end;

  finally
    dConexao.conexaoBanco.Rollback;
    qry.Free;
  end;
end;

procedure TFuncionario.Listar;
const
  SQL = 'select ' +
        '    cd_funcionario, ' +
        '    c.cd_cargo, ' +
        '    c.nm_cargo, ' +
        '    nm_funcionario, ' +
        '    cpf, ' +
        '    rg, ' +
        '    telefone, ' +
        '    logradouro, ' +
        '    numero, ' +
        '    bairro, ' +
        '    cidade, ' +
        '    uf, ' +
        '    cep, ' +
        '    data_cadastro ' +
        'from ' +
        '    funcionarios f ' +
        'join cargos c on c.cd_cargo = f.cd_cargo ';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dConexao.conexaoBanco;

  try
    qry.SQL.Add(SQL);
    qry.Open();

    FDados.cdsFuncionario.EmptyDataSet;

    qry.loopSimples(
    procedure
    begin
      FDados.cdsFuncionario.Append;
      FDados.cdsFuncionario.FieldByName('cd_funcionario').AsInteger := qry.FieldByName('cd_funcionario').AsInteger;
      FDados.cdsFuncionario.FieldByName('cd_cargo').AsInteger := qry.FieldByName('cd_cargo').AsInteger;
      FDados.cdsFuncionario.FieldByName('nm_cargo').AsString := qry.FieldByName('nm_cargo').AsString;
      FDados.cdsFuncionario.FieldByName('nm_funcionario').AsString := qry.FieldByName('nm_funcionario').AsString;
      FDados.cdsFuncionario.FieldByName('cpf').AsString := qry.FieldByName('cpf').AsString;
      FDados.cdsFuncionario.FieldByName('rg').AsString := qry.FieldByName('rg').AsString;
      FDados.cdsFuncionario.FieldByName('telefone').AsString := qry.FieldByName('telefone').AsString;
      FDados.cdsFuncionario.FieldByName('logradouro').AsString := qry.FieldByName('logradouro').AsString;
      FDados.cdsFuncionario.FieldByName('numero').AsString := qry.FieldByName('numero').AsString;
      FDados.cdsFuncionario.FieldByName('bairro').AsString := qry.FieldByName('bairro').AsString;
      FDados.cdsFuncionario.FieldByName('cidade').AsString := qry.FieldByName('cidade').AsString;
      FDados.cdsFuncionario.FieldByName('uf').AsString := qry.FieldByName('uf').AsString;
      FDados.cdsFuncionario.FieldByName('cep').AsString := qry.FieldByName('cep').AsString;
      FDados.cdsFuncionario.FieldByName('data_cadastro').AsDateTime := qry.FieldByName('data_cadastro').AsDateTime;
      FDados.cdsFuncionario.Post;
    end
    );

  finally
    qry.Free;
  end;
end;

procedure TFuncionario.Persistir(Novo: Boolean);
begin
  if Novo then
    Inserir
  else
    Atualizar;
end;

function TFuncionario.Pesquisar(CodFuncionario: Integer): Boolean;
const
  SQL = 'select cd_funcionario from funcionarios where cd_funcionario = :cd_funcionario';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dConexao.conexaoBanco;

  try
    qry.SQL.Add(SQL);
    qry.ParamByName('cd_funcionario').AsInteger := CodFuncionario;
    qry.Open();

    Result := qry.IsEmpty;

  finally
    qry.Free;
  end;
end;

procedure TFuncionario.Setbairro(const Value: string);
begin
  Fbairro := Value;
end;

procedure TFuncionario.Setcd_cargo(const Value: Integer);
begin
  Fcd_cargo := Value;
end;

procedure TFuncionario.Setcd_funcionario(const Value: Integer);
begin
  Fcd_funcionario := Value;
end;

procedure TFuncionario.Setcep(const Value: string);
begin
  Fcep := Value;
end;

procedure TFuncionario.Setcidade(const Value: string);
begin
  Fcidade := Value;
end;

procedure TFuncionario.Setcpf(const Value: string);
begin
  Fcpf := Value;
end;

procedure TFuncionario.Setdata_cadastro(const Value: TDate);
begin
  Fdata_cadastro := Value;
end;

procedure TFuncionario.Setlogradouro(const Value: string);
begin
  Flogradouro := Value;
end;

procedure TFuncionario.Setnm_funcionario(const Value: string);
begin
  Fnm_funcionario := Value;
end;

procedure TFuncionario.Setnumero(const Value: string);
begin
  Fnumero := Value;
end;

procedure TFuncionario.Setrg(const Value: string);
begin
  Frg := Value;
end;

procedure TFuncionario.Settelefone(const Value: string);
begin
  Ftelefone := Value;
end;

procedure TFuncionario.Setuf(const Value: string);
begin
  Fuf := Value;
end;

end.
