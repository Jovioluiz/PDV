unit uclCargo;

interface

uses
  uPadrao, uConexao;

type TCargo = class
  private
    Fcd_cargo: Integer;
    Fnm_cargo: string;
    FConexao: TConexao;
    procedure Setcd_cargo(const Value: Integer);
    procedure Setnm_cargo(const Value: string);
    procedure Inserir;
    procedure Atualizar;
    procedure SetConexao(const Value: TConexao);

  public

    function Pesquisar(CodCargo: Integer): Boolean;
    procedure Persistir(Novo: Boolean);
    function Excluir: Boolean;
    property cd_cargo: Integer read Fcd_cargo write Setcd_cargo;
    property nm_cargo: string read Fnm_cargo write Setnm_cargo;

    property Conexao: TConexao read FConexao write SetConexao;
    constructor Create;
    destructor Destroy; override;
end;

implementation

uses
  FireDAC.Comp.Client, System.SysUtils, FireDAC.Stan.Param, Data.DB;

{ TCargo }

procedure TCargo.Atualizar;
const
  SQL = 'update cargos set cd_cargo = :cd_cargo, nm_cargo = :nm_cargo)';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := Conexao.getConexao;
  Conexao.getConexao.StartTransaction;

  try
    try
      qry.ParamByName('cd_cargo').AsInteger := Fcd_cargo;
      qry.ParamByName('nm_cargo').AsString := Fnm_cargo;
      qry.ExecSQL;
      Conexao.getConexao.Commit;
    except
      on E:exception do
      begin
        Conexao.getConexao.Rollback;
        raise Exception.Create('Erro ao gravar os dados' + E.Message);
      end;
    end;
  finally
    Conexao.getConexao.Rollback;
    qry.Free;
  end;
end;

constructor TCargo.Create;
begin
  Conexao := TConexao.Create
end;

destructor TCargo.Destroy;
begin
  Conexao.Free;
  inherited;
end;

function TCargo.Excluir: Boolean;
const
  SQL = 'delete from cargos where cd_cargo = :cd_cargo';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := Conexao.getConexao;

  try
    try
      qry.SQL.Add(SQL);
      qry.ParamByName('cd_cargo').AsInteger := Fcd_cargo;
      qry.ExecSQL;
      Conexao.getConexao.Commit;

    except
      on E:exception do
      begin
        Conexao.getConexao.Rollback;
        raise Exception.Create('Erro ao excluir ' + E.Message);
      end;
    end;
    Result := True;
  finally
    Conexao.getConexao.Rollback;
    qry.Free;
  end;
end;

procedure TCargo.Inserir;
const
  SQL = 'insert into cargos(cd_cargo, nm_cargo) values (:cd_cargo, :nm_cargo)';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := Conexao.getConexao;
  Conexao.getConexao.StartTransaction;

  try
    try
      qry.SQL.Add(SQL);
      qry.ParamByName('cd_cargo').AsInteger := Fcd_cargo;
      qry.ParamByName('nm_cargo').AsString := Fnm_cargo;
      qry.ExecSQL;
      Conexao.getConexao.Commit;
    except
      on E:exception do
      begin
        Conexao.getConexao.Rollback;
        raise Exception.Create('Erro ao gravar os dados ' + E.Message);
      end;
    end;
  finally
    Conexao.getConexao.Rollback;
    qry.Free;
  end;
end;

function TCargo.Pesquisar(CodCargo: Integer): Boolean;
const
  SQL_CARGO = 'select cd_cargo from cargos where cd_cargo = :cd_cargo';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := Conexao.getConexao;

  try
    qry.SQL.Add(SQL_CARGO);
    qry.ParamByName('cd_cargo').AsInteger := CodCargo;
    qry.Open();

    Result := qry.IsEmpty;

  finally
    qry.Free;
  end;
end;

procedure TCargo.Persistir(Novo: Boolean);
begin
  if Novo then
    Inserir
  else
    Atualizar;
end;

procedure TCargo.Setcd_cargo(const Value: Integer);
begin
  Fcd_cargo := Value;
end;

procedure TCargo.SetConexao(const Value: TConexao);
begin
  FConexao := Value;
end;

procedure TCargo.Setnm_cargo(const Value: string);
begin
  Fnm_cargo := Value;
end;

end.
