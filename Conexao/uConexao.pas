unit uConexao;

interface

uses
  FireDAC.Comp.Client, System.SysUtils, Vcl.Dialogs, System.IniFiles;

type TConexao = class
  private
    conexao: TFDConnection;

  public
    // construtor da classe
    constructor Create;

    //fun��o que retorna a conex�o com o banco de dados
    function getConexao: TFDConnection;
end;

implementation

{ TConexao }

constructor TConexao.Create;
var
  conexaoIni: TIniFile;
begin
  conexaoIni := TIniFile.Create(GetCurrentDir + '\conexao\conexao.ini');
  conexao := TFDConnection.Create(nil);

  conexao.DriverName := 'PG';

  conexao.Params.Values['Server'] := conexaoIni.ReadString('configuracoes', 'servidor', conexao.Params.Values['Server']);
  conexao.Params.Database := conexaoIni.ReadString('configuracoes', 'banco', conexao.Params.Database);
  conexao.Params.UserName := conexaoIni.ReadString('configuracoes', 'usuario', conexao.Params.UserName);
  conexao.Params.Password := conexaoIni.ReadString('configuracoes', 'senha', conexao.Params.Password);
  conexao.Params.Values['Port'] := conexaoIni.ReadString('configuracoes', 'porta', conexao.Params.Values['Port']);

  try
    conexao.Open();
  except
    on e:Exception do
    begin
      ShowMessage('N�o foi poss�vel efetuar a conex�o. Erro: ' + e.Message);
      conexao := nil;
    end;
  end;
end;

function TConexao.getConexao: TFDConnection;
begin
  Result := conexao;
end;

end.
