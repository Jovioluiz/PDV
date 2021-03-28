program PDV;

uses
  Vcl.Forms,
  Login in 'Login.pas' {FrmLogin},
  Menu in 'Menu.pas' {FrmMenu},
  Usuarios in 'Cadastros\Usuarios.pas' {FrmUsuarios},
  Funcionarios in 'Cadastros\Funcionarios.pas' {FrmFuncionarios},
  Cargos in 'Cadastros\Cargos.pas' {FrmCargos},
  Modulo in 'Modulo.pas' {dm: TDataModule},
  Fornecedores in 'Cadastros\Fornecedores.pas' {frmFornecedor},
  uValidaDcto in 'uValidaDcto.pas',
  Produtos in 'Cadastros\Produtos.pas' {frmProdutos},
  ImprimirBarras in 'Cadastros\ImprimirBarras.pas' {frmImprimirBarras},
  EntradasProdutos in 'Estoque\EntradasProdutos.pas' {frmEntradaProdutos},
  SaidaProdutos in 'Estoque\SaidaProdutos.pas' {frmSaidaProdutos},
  EstoqueBaixo in 'Estoque\EstoqueBaixo.pas' {frmEstoqueBaixo},
  Vendas in 'Financeiro\Vendas.pas' {frmVendas},
  CancelarItem in 'Financeiro\CancelarItem.pas' {frmCancelarItem},
  Movimentacoes in 'Financeiro\Movimentacoes.pas' {frmMovimentacoes},
  Gastos in 'Financeiro\Gastos.pas' {frmGastos},
  ListaVendas in 'Financeiro\ListaVendas.pas' {frmListaVendas},
  CertificadoDigital in 'Financeiro\CertificadoDigital.pas' {frmCertificado},
  uclVendas in 'Financeiro\uclVendas.pas',
  dVendas in 'Financeiro\dVendas.pas' {dmVendas: TDataModule},
  uPadrao in 'uPadrao.pas',
  uUtil in 'Uteis\uUtil.pas',
  uclCargo in 'Cadastros\Persistencia\uclCargo.pas',
  System.UITypes,
  System.SysUtils,
  uclFornecedor in 'Cadastros\Persistencia\uclFornecedor.pas',
  dFornecedor in 'Cadastros\Data Modulos\dFornecedor.pas' {dmFornecedor: TDataModule},
  dmConexao in 'Conexao\dmConexao.pas' {dConexao: TDataModule},
  uclFuncionario in 'Cadastros\Persistencia\uclFuncionario.pas',
  dFuncionario in 'Cadastros\Data Modulos\dFuncionario.pas' {dmFuncionario: TDataModule},
  uclProduto in 'Cadastros\Persistencia\uclProduto.pas',
  dProdutos in 'Cadastros\Data Modulos\dProdutos.pas' {dmProdutos: TDataModule},
  uclProdutoCodBarras in 'Cadastros\Persistencia\uclProdutoCodBarras.pas';

{$R *.res}

begin
  Application.CreateForm(TdConexao, dConexao);
  FrmLogin := TFrmLogin.Create(nil);
  if FrmLogin.ShowModal = mrOK then
  begin
    FreeAndNil(frmLogin);
    Application.Initialize;
    Application.MainFormOnTaskbar := True;
    Application.CreateForm(TFrmMenu, FrmMenu);
    Application.Run;
  end;
end.
