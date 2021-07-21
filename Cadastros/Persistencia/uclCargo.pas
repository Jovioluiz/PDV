unit uclCargo;

interface

uses
  uPadrao;

type TCargo = class(TPadrao)
  private
    Fcd_cargo: Integer;
    Fnm_cargo: string;
    procedure Setcd_cargo(const Value: Integer);
    procedure Setnm_cargo(const Value: string);


  public
    procedure Inserir;
    procedure Atualizar;
    function Pesquisar(CodCargo: Integer): Boolean; override;
    procedure Persistir(Novo: Boolean); override;
    function Excluir: Boolean; override;
    property cd_cargo: Integer read Fcd_cargo write Setcd_cargo;
    property nm_cargo: string read Fnm_cargo write Setnm_cargo;

    constructor Create;
    destructor Destroy; override;
end;

implementation

uses
  FireDAC.Comp.Client, System.SysUtils, FireDAC.Stan.Param, Data.DB, dmConexao;

{ TCargo }

procedure TCargo.Atualizar;
const
  SQL = 'update cargos set cd_cargo = :cd_cargo, nm_cargo = :nm_cargo)';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dConexao.FConexaoBanco;
  dConexao.FConexaoBanco.StartTransaction;

  try
    try
      qry.ParamByName('cd_cargo').AsInteger := Fcd_cargo;
      qry.ParamByName('nm_cargo').AsString := Fnm_cargo;
      qry.ExecSQL;
      dConexao.FConexaoBanco.Commit;
    except
      on E:exception do
      begin
        dConexao.FConexaoBanco.Rollback;
        raise Exception.Create('Erro ao gravar os dados' + E.Message);
      end;
    end;
  finally
    dConexao.FConexaoBanco.Rollback;
    qry.Free;
  end;
end;

constructor TCargo.Create;
begin
//
end;

destructor TCargo.Destroy;
begin
  inherited;
end;

function TCargo.Excluir: Boolean;
const
  SQL = 'delete from cargos where cd_cargo = :cd_cargo';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dConexao.FConexaoBanco;

  try
    try
      qry.SQL.Add(SQL);
      qry.ParamByName('cd_cargo').AsInteger := Fcd_cargo;
      qry.ExecSQL;
      dConexao.FConexaoBanco.Commit;

    except
      on E:exception do
      begin
        dConexao.FConexaoBanco.Rollback;
        raise Exception.Create('Erro ao excluir ' + E.Message);
      end;
    end;
    Result := True;
  finally
    dConexao.FConexaoBanco.Rollback;
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
  qry.Connection := dConexao.FConexaoBanco;
  dConexao.FConexaoBanco.StartTransaction;

  try
    try
      qry.SQL.Add(SQL);
      qry.ParamByName('cd_cargo').AsInteger := Fcd_cargo;
      qry.ParamByName('nm_cargo').AsString := Fnm_cargo;
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

function TCargo.Pesquisar(CodCargo: Integer): Boolean;
const
  SQL_CARGO = 'select cd_cargo from cargos where cd_cargo = :cd_cargo';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dConexao.FConexaoBanco;

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

procedure TCargo.Setnm_cargo(const Value: string);
begin
  Fnm_cargo := Value;
end;

end.
