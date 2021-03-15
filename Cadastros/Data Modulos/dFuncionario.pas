unit dFuncionario;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient;

type
  TdmFuncionario = class(TDataModule)
    dsFuncionario: TDataSource;
    cdsFuncionario: TClientDataSet;
    cdsFuncionariocd_funcionario: TIntegerField;
    cdsFuncionarionm_funcionario: TStringField;
    cdsFuncionariocpf: TStringField;
    cdsFuncionariorg: TStringField;
    cdsFuncionariotelefone: TStringField;
    cdsFuncionariologradouro: TStringField;
    cdsFuncionarionumero: TStringField;
    cdsFuncionariobairro: TStringField;
    cdsFuncionariocidade: TStringField;
    cdsFuncionariouf: TStringField;
    cdsFuncionariocep: TStringField;
    cdsFuncionariodata_cadastro: TDateField;
    cdsFuncionarionm_cargo: TStringField;
    cdsFuncionariocd_cargo: TIntegerField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmFuncionario: TdmFuncionario;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
