unit uclProduto;

interface

uses
  uPadrao, dProdutos, uUtil;

type TProduto = class(TPadrao)
  private
    Fdescricao: string;
    Fdata_cadastro: TDate;
    Fun_medida: string;
    Fdata_ult_compra: TDate;
    Fimagem: Byte;
    Fdt_atz: TDateTime;
    Ffator_conversao: Double;
    Fid_item: Integer;
    Fqt_estoque: Double;
    Fvl_unitario: Currency;
    Fcd_item: string;
    Fnm_produto: string;
    FDados: TdmProdutos;
    procedure Setcd_item(const Value: string);
    procedure Setdata_cadastro(const Value: TDate);
    procedure Setdata_ult_compra(const Value: TDate);
    procedure Setdescricao(const Value: string);
    procedure Setdt_atz(const Value: TDateTime);
    procedure Setfator_conversao(const Value: Double);
    procedure Setid_item(const Value: Integer);
    procedure Setimagem(const Value: Byte);
    procedure Setnm_produto(const Value: string);
    procedure Setqt_estoque(const Value: Double);
    procedure Setun_medida(const Value: string);
    procedure Setvl_unitario(const Value: Currency);

    procedure Inserir;
    procedure Atualizar;
    procedure SetDados(const Value: TdmProdutos);

  public
    function GeraIDItem: Integer;
    function VerificaCodigoBarras(CodBarras: string): Boolean;
    function Pesquisar(Codigo: Integer): Boolean; override;
    procedure Persistir(Novo: Boolean); override;
    function Excluir: Boolean; override;
    procedure Listar;
    function GetIdItem(CodItem: string): Integer;

    constructor Create;
    destructor Destroy; override;

    property id_item: Integer read Fid_item write Setid_item;
    property cd_item: string read Fcd_item write Setcd_item;
    property nm_produto: string read Fnm_produto write Setnm_produto;
    property descricao: string read Fdescricao write Setdescricao;
    property vl_unitario: Currency read Fvl_unitario write Setvl_unitario;
    property qt_estoque: Double read Fqt_estoque write Setqt_estoque;
    property un_medida: string read Fun_medida write Setun_medida;
    property fator_conversao: Double read Ffator_conversao write Setfator_conversao;
    property data_cadastro: TDate read Fdata_cadastro write Setdata_cadastro;
    property imagem: Byte read Fimagem write Setimagem;
    property data_ult_compra: TDate read Fdata_ult_compra write Setdata_ult_compra;
    property dt_atz: TDateTime read Fdt_atz write Setdt_atz;
    property Dados: TdmProdutos read FDados write SetDados;
end;

implementation

uses
  FireDAC.Comp.Client, dmConexao, FireDAC.Stan.Param, Data.DB, System.SysUtils;

{ TProduto }

procedure TProduto.Atualizar;
{$REGION 'update'}
const
  SQL_UPDATE = 'update ' +
              '    produtos ' +
              'set ' +
              '    cd_item = :cd_item, ' +
              '    nm_produto = :nm_produto, ' +
              '    descricao = :descricao, ' +
              '    vl_unitario = :vl_unitario, ' +
              '    un_medida = :un_medida, ' +
              '    fator_conversao = :fator_conversao ' +
              'where id_item = :id_item';
{$ENDREGION}
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dConexao.FConexaoBanco;

  try
    try
      qry.SQL.Add(SQL_UPDATE);
      qry.ParamByName('cd_item').AsString := cd_item;
      qry.ParamByName('nm_produto').AsString := nm_produto;
      qry.ParamByName('descricao').AsString := descricao;
      qry.ParamByName('vl_unitario').AsCurrency := vl_unitario;
      qry.ParamByName('un_medida').AsString := un_medida;
      qry.ParamByName('fator_conversao').AsFloat := fator_conversao;
      qry.ParamByName('id_item').AsInteger := id_item;
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

constructor TProduto.Create;
begin
  FDados := TdmProdutos.Create(nil);
end;

destructor TProduto.Destroy;
begin
  FDados.Free;
  inherited;
end;

function TProduto.Excluir: Boolean;
const
  SQL = 'delete from produtos where id_item = :id_item';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dConexao.FConexaoBanco;

  try
    try
      qry.SQL.Add(SQL);
      qry.ParamByName('id_item').AsInteger := Fid_item;
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
    qry.Free;
  end;
end;

function TProduto.GeraIDItem: Integer;
const
  SQL = 'select nextval(''seq_id_item'') as cod';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dconexao.FConexaoBanco;

  try
    qry.SQL.Add(SQL);
    qry.Open();

    Result := qry.FieldByName('cod').AsInteger;

  finally
    qry.Free;
  end;
end;

function TProduto.GetIdItem(CodItem: string): Integer;
const
  SQL = 'select id_item from produtos where cd_item = :cd_item';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dConexao.FConexaoBanco;

  try
    qry.Open(SQL, [CodItem]);

    Result := qry.FieldByName('id_item').AsInteger;

  finally
    qry.Free;
  end;
end;

procedure TProduto.Inserir;
{$REGION 'Insert'}
const
  SQL_INSERT =  'insert ' +
                '    into ' +
                '    produtos (id_item, ' +
                '    cd_item, ' +
                '    nm_produto, ' +
                '    descricao, ' +
                '    vl_unitario, ' +
                '    qt_estoque, ' +
                '    un_medida, ' +
                '    fator_conversao, ' +
                '    data_cadastro) ' +
                'values (:id_item, ' +
                ':cd_item, ' +
                ':nm_produto, ' +
                ':descricao, ' +
                ':vl_unitario, ' +
                ':qt_estoque, ' +
                ':un_medida, ' +
                ':fator_conversao, ' +
                ':data_cadastro) ';
{$ENDREGION}
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dConexao.FConexaoBanco;

  try
    try
      qry.SQL.Add(SQL_INSERT);
      qry.ParamByName('id_item').AsInteger := GeraIDItem;
      qry.ParamByName('cd_item').AsString := cd_item;
      qry.ParamByName('nm_produto').AsString := nm_produto;
      qry.ParamByName('descricao').AsString := descricao;
      qry.ParamByName('vl_unitario').AsCurrency := vl_unitario;
      qry.ParamByName('qt_estoque').AsFloat := qt_estoque;
      qry.ParamByName('un_medida').AsString := un_medida;
      qry.ParamByName('fator_conversao').AsFloat := fator_conversao;
      qry.ParamByName('data_cadastro').AsDate := data_cadastro;
      qry.ExecSQL;

    except
      on E:exception do
      begin
        dConexao.FConexaoBanco.Rollback;
        raise Exception.Create('Erro ao gravar os dados ' + E.Message);
      end;
    end;
    dConexao.FConexaoBanco.Commit;
  finally
    dConexao.FConexaoBanco.Rollback;
    qry.Free;
  end;
end;

procedure TProduto.Listar;
const
  SQL = 'select ' +
        '    p.id_item, ' +
        '    cd_item, ' +
        '    nm_produto, ' +
        '    descricao, ' +
        '    vl_unitario, ' +
        '    qt_estoque, ' +
        '    un_medida, ' +
        '    fator_conversao, ' +
        '    data_cadastro, ' +
        '    imagem, ' +
        '    data_ult_compra, ' +
        '    codigo_barras ' +
        'from ' +
        '    produtos p ' +
        'join produtos_cod_barras pcb on pcb.id_item = p.id_item ';

var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dConexao.FConexaoBanco;

  try
    qry.SQL.Add(SQL);
    qry.Open();

    FDados.cdsProdutos.EmptyDataSet;

    qry.loopSimples(
    procedure
    begin
      FDados.cdsProdutos.Append;
      FDados.cdsProdutos.FieldByName('id_item').AsInteger := qry.FieldByName('id_item').AsInteger;
      FDados.cdsProdutos.FieldByName('cd_item').AsString := qry.FieldByName('cd_item').AsString;
      FDados.cdsProdutos.FieldByName('nm_produto').AsString := qry.FieldByName('nm_produto').AsString;
      FDados.cdsProdutos.FieldByName('descricao').AsString := qry.FieldByName('descricao').AsString;
      FDados.cdsProdutos.FieldByName('vl_unitario').AsCurrency := qry.FieldByName('vl_unitario').AsCurrency;
      FDados.cdsProdutos.FieldByName('qt_estoque').AsFloat := qry.FieldByName('qt_estoque').AsFloat;
      FDados.cdsProdutos.FieldByName('un_medida').AsString := qry.FieldByName('un_medida').AsString;
      FDados.cdsProdutos.FieldByName('fator_conversao').AsFloat := qry.FieldByName('fator_conversao').AsFloat;
      FDados.cdsProdutos.FieldByName('data_cadastro').AsDateTime := qry.FieldByName('data_cadastro').AsDateTime;
      FDados.cdsProdutos.FieldByName('imagem').AsBytes := qry.FieldByName('imagem').AsBytes;
      if qry.FieldByName('data_ult_compra').AsDateTime > 0 then
        FDados.cdsProdutos.FieldByName('data_ult_compra').AsDateTime := qry.FieldByName('data_ult_compra').AsDateTime;
      FDados.cdsProdutos.FieldByName('codigo_barras').AsString := qry.FieldByName('codigo_barras').AsString;
      FDados.cdsProdutos.Post;
    end
    );

  finally
    qry.Free;
  end;
end;

procedure TProduto.Persistir(Novo: Boolean);
begin
  inherited;
  if Novo then
    Inserir
  else
    Atualizar;
end;

function TProduto.Pesquisar(Codigo: Integer): Boolean;
const
  SQL = 'select cd_item from produtos where id_item = :id_item';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dConexao.FConexaoBanco;

  try
    qry.Open(SQL, [Codigo]);

    Result := qry.IsEmpty;

  finally
    qry.Free;
  end;
end;

procedure TProduto.Setcd_item(const Value: string);
begin
  Fcd_item := Value;
end;

procedure TProduto.SetDados(const Value: TdmProdutos);
begin
  FDados := Value;
end;

procedure TProduto.Setdata_cadastro(const Value: TDate);
begin
  Fdata_cadastro := Value;
end;

procedure TProduto.Setdata_ult_compra(const Value: TDate);
begin
  Fdata_ult_compra := Value;
end;

procedure TProduto.Setdescricao(const Value: string);
begin
  Fdescricao := Value;
end;

procedure TProduto.Setdt_atz(const Value: TDateTime);
begin
  Fdt_atz := Value;
end;

procedure TProduto.Setfator_conversao(const Value: Double);
begin
  Ffator_conversao := Value;
end;

procedure TProduto.Setid_item(const Value: Integer);
begin
  Fid_item := Value;
end;

procedure TProduto.Setimagem(const Value: Byte);
begin
  Fimagem := Value;
end;

procedure TProduto.Setnm_produto(const Value: string);
begin
  Fnm_produto := Value;
end;

procedure TProduto.Setqt_estoque(const Value: Double);
begin
  Fqt_estoque := Value;
end;

procedure TProduto.Setun_medida(const Value: string);
begin
  Fun_medida := Value;
end;

procedure TProduto.Setvl_unitario(const Value: Currency);
begin
  Fvl_unitario := Value;
end;

function TProduto.VerificaCodigoBarras(CodBarras: string): Boolean;
const
  SQL = 'select codigo_barras from produtos_cod_barras where codigo_barras = :codigo_barras';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dconexao.FConexaoBanco;

  try
    qry.Open(SQL, [CodBarras]);

    Result := qry.IsEmpty;

  finally
    qry.Free;
  end;
end;

end.
