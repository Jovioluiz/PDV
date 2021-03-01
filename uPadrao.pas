unit uPadrao;

interface

uses
  dConexaoBanco, uConexao;

type TPadrao = class(TConexao)
  private
    FConexao: TConexao;
    procedure SetConexao(const Value: TConexao);


  public
    property Conexao: TConexao read FConexao write SetConexao;

  constructor Create;
  destructor Destroy; override;


end;

implementation

{ TPadrao }

constructor TPadrao.Create;
begin
  FConexao.Create;
end;

destructor TPadrao.Destroy;
begin
  FConexao.Free;
  inherited;
end;

procedure TPadrao.SetConexao(const Value: TConexao);
begin
  FConexao := Value;
end;

end.
