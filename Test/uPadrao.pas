unit uPadrao;

interface

uses
  dmConexao;

type TPadrao = class abstract

  private


  public
    function Pesquisar(Codigo: Integer): Boolean; virtual; abstract;
    procedure Persistir(Novo: Boolean); virtual; abstract;
    function Excluir: Boolean; virtual; abstract;
end;

implementation

{ TPadrao }


end.
