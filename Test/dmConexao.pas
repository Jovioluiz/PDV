unit dmConexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.PGDef,
  FireDAC.VCLUI.Wait, FireDAC.Comp.UI, FireDAC.Phys.PG, Data.DB,
  FireDAC.Comp.Client;

type
  TdConexao = class(TDataModule)
    driver: TFDPhysPgDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FConexaoBanco: TFDConnection;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dConexao: TdConexao;

implementation

uses
  System.IniFiles, Vcl.Dialogs;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdConexao.DataModuleCreate(Sender: TObject);
var
  conexaoIni: TIniFile;
begin
  conexaoIni := TIniFile.Create(GetCurrentDir + '\conexao\conexao.ini');
  FConexaoBanco := TFDConnection.Create(nil);

  try

    FConexaoBanco.DriverName := 'PG';

    FConexaoBanco.Params.Values['Server'] := conexaoIni.ReadString('configuracoes', 'servidor', FConexaoBanco.Params.Values['Server']);
    FConexaoBanco.Params.Database := conexaoIni.ReadString('configuracoes', 'banco', FConexaoBanco.Params.Database);
    FConexaoBanco.Params.UserName := conexaoIni.ReadString('configuracoes', 'usuario', FConexaoBanco.Params.UserName);
    FConexaoBanco.Params.Password := conexaoIni.ReadString('configuracoes', 'senha', FConexaoBanco.Params.Password);
    FConexaoBanco.Params.Values['Port'] := conexaoIni.ReadString('configuracoes', 'porta', FConexaoBanco.Params.Values['Port']);

    driver.VendorLib := GetCurrentDir + '\lib\libpq.dll';

    try
  //    conexaoBanco.Open();
      FConexaoBanco.Connected := True;
    except
      on e:Exception do
      begin
        ShowMessage('Não foi possível efetuar a conexão. Erro: ' + e.Message);
        FConexaoBanco := nil;
      end;
    end;
  finally
    conexaoIni.Free;
  end;
end;

procedure TdConexao.DataModuleDestroy(Sender: TObject);
begin
  FConexaoBanco.Free;
end;

end.
