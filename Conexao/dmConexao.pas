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
    conexaoBanco: TFDConnection;
    procedure DataModuleCreate(Sender: TObject);
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
  conexaoBanco := TFDConnection.Create(nil);

  conexaoBanco.DriverName := 'PG';

  conexaoBanco.Params.Values['Server'] := conexaoIni.ReadString('configuracoes', 'servidor', conexaoBanco.Params.Values['Server']);
  conexaoBanco.Params.Database := conexaoIni.ReadString('configuracoes', 'banco', conexaoBanco.Params.Database);
  conexaoBanco.Params.UserName := conexaoIni.ReadString('configuracoes', 'usuario', conexaoBanco.Params.UserName);
  conexaoBanco.Params.Password := conexaoIni.ReadString('configuracoes', 'senha', conexaoBanco.Params.Password);
  conexaoBanco.Params.Values['Port'] := conexaoIni.ReadString('configuracoes', 'porta', conexaoBanco.Params.Values['Port']);

  driver.VendorLib := GetCurrentDir + '\lib\libpq.dll';

  try
//    conexaoBanco.Open();
    conexaoBanco.Connected := True;
  except
    on e:Exception do
    begin
      ShowMessage('Não foi possível efetuar a conexão. Erro: ' + e.Message);
      conexaoBanco := nil;
    end;
  end;
end;

end.
