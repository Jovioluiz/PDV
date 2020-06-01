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
  ImprimirBarras in 'Cadastros\ImprimirBarras.pas' {frmImprimirBarras};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmLogin, FrmLogin);
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TfrmFornecedor, frmFornecedor);
  Application.CreateForm(TfrmProdutos, frmProdutos);
  Application.CreateForm(TfrmImprimirBarras, frmImprimirBarras);
  Application.Run;
end.
