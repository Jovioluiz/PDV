unit uclProduto;

interface

type TProduto = class
  private



  public
    function GeraIDItem: Integer;
    function VerificaCodigoBarras(CodBarras: string): Boolean;

    constructor Create;
    destructor Destroy; override;
end;

implementation

uses
  FireDAC.Comp.Client, dmConexao;

{ TProduto }

constructor TProduto.Create;
begin

end;

destructor TProduto.Destroy;
begin

  inherited;
end;

function TProduto.GeraIDItem: Integer;
const
  SQL = 'select nextval(''seq_id_item'') as cod';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dconexao.conexaoBanco;



  try
    qry.SQL.Add(SQL);
    qry.Open();

    Result := qry.FieldByName('cod').AsInteger;

  finally
    qry.Free;
  end;
end;

function TProduto.VerificaCodigoBarras(CodBarras: string): Boolean;
const
  SQL = 'select codigo_barras from produtos_cod_barras where codigo_barras = :codigo_barras';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dconexao.conexaoBanco;

  try
    qry.SQL.Add(SQL);
    qry.ParamByName('codigo_barras').AsString := CodBarras;
    qry.Open();

    if not qry.IsEmpty then
      Result := False;

  finally
    qry.Free;
  end;

end;

end.
