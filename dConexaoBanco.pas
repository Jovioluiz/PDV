unit dConexaoBanco;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Comp.Client;

type
  TdmConexaoBanco = class(TDataModule)
  private
    FConexao: TFDConnection;
    procedure DataModuleCreate(Sender: TObject);
    procedure SetConexao(const Value: TFDConnection);

  public
    function getConexao: TFDConnection;

    property Conexao: TFDConnection read FConexao write SetConexao;
  end;

var
  dmConexaoBanco: TdmConexaoBanco;

implementation

uses
  System.IniFiles, Vcl.Dialogs;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmConexaoBanco.DataModuleCreate(Sender: TObject);
var
  conexaoIni: TIniFile;
begin
  conexaoIni := TIniFile.Create(GetCurrentDir + '\conexao\conexao.ini');
  Fconexao := TFDConnection.Create(nil);

  Fconexao.DriverName := 'MySQL';

  Fconexao.Params.Values['Server'] := conexaoIni.ReadString('configuracoes', 'servidor', Fconexao.Params.Values['Server']);
  Fconexao.Params.Database := conexaoIni.ReadString('configuracoes', 'banco', Fconexao.Params.Database);
  Fconexao.Params.UserName := conexaoIni.ReadString('configuracoes', 'usuario', Fconexao.Params.UserName);
  Fconexao.Params.Password := conexaoIni.ReadString('configuracoes', 'senha', Fconexao.Params.Password);
  Fconexao.Params.Values['Port'] := conexaoIni.ReadString('configuracoes', 'porta', Fconexao.Params.Values['Port']);

  try
    Fconexao.Open();
  except
    on e:Exception do
    begin
      ShowMessage('Não foi possível efetuar a conexão. Erro: ' + e.Message);
      Fconexao := nil;
    end;
  end;
end;


function TdmConexaoBanco.getConexao: TFDConnection;
begin
  Result := Fconexao;
end;

procedure TdmConexaoBanco.SetConexao(const Value: TFDConnection);
begin
  FConexao := Value;
end;

end.
