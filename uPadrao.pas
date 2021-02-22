unit uPadrao;

interface

uses
  dConexaoBanco;

type TPadrao = class(TdmConexaoBanco)
  private
    FConexao: TdmConexaoBanco;
    procedure SetConexao(const Value: TdmConexaoBanco);

  public
    property Conexao: TdmConexaoBanco read FConexao write SetConexao;

  constructor Create;


end;

implementation

{ TPadrao }

constructor TPadrao.Create;
begin
  FConexao.Create(nil);
end;

procedure TPadrao.SetConexao(const Value: TdmConexaoBanco);
begin
  FConexao := Value;
end;

end.
