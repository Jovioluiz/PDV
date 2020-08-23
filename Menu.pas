unit Menu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, System.UITypes, ACBrUtil;

type
  TFrmMenu = class(TForm)
    MainMenu1: TMainMenu;
    Cadastros1: TMenuItem;
    Produtos1: TMenuItem;
    Fornecedores1: TMenuItem;
    Estoque1: TMenuItem;
    Movimentaes1: TMenuItem;
    Relatrios1: TMenuItem;
    Sair1: TMenuItem;
    Usurios1: TMenuItem;
    Funcionrios1: TMenuItem;
    Cargos1: TMenuItem;
    Sair2: TMenuItem;
    EntradasProdutos1: TMenuItem;
    SadasProdutos1: TMenuItem;
    Nvel1: TMenuItem;
    Vendas1: TMenuItem;
    Movimentaes2: TMenuItem;
    Gastos1: TMenuItem;
    Pagamentos1: TMenuItem;
    ConsultarVendas1: TMenuItem;
    CertificadoDigital1: TMenuItem;
    procedure Usurios1Click(Sender: TObject);
    procedure Funcionrios1Click(Sender: TObject);
    procedure Cargos1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Fornecedores1Click(Sender: TObject);
    procedure Sair2Click(Sender: TObject);
    procedure Produtos1Click(Sender: TObject);
    procedure EntradasProdutos1Click(Sender: TObject);
    procedure SadasProdutos1Click(Sender: TObject);
    procedure Nvel1Click(Sender: TObject);
    procedure Vendas1Click(Sender: TObject);
    procedure Movimentaes2Click(Sender: TObject);
    procedure Gastos1Click(Sender: TObject);
    procedure Pagamentos1Click(Sender: TObject);
    procedure ConsultarVendas1Click(Sender: TObject);
    procedure CertificadoDigital1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMenu: TFrmMenu;

implementation

{$R *.dfm}

uses Usuarios, Funcionarios, Cargos, Modulo, Fornecedores, Produtos,
  EntradasProdutos, SaidaProdutos, EstoqueBaixo, Vendas, Movimentacoes, Gastos,
  ListaVendas, CertificadoDigital;

procedure TFrmMenu.Cargos1Click(Sender: TObject);
begin
  FrmCargos := TFrmCargos.Create(Self);
  FrmCargos.ShowModal;
end;

procedure TFrmMenu.CertificadoDigital1Click(Sender: TObject);
var
  addLinha: boolean;
  i: integer;
  serie: string;
  certificadoDig: string;
  caminhoNFCE: string;
begin

  frmCertificado := TFrmCertificado.Create(self);
  frmVendas := TfrmVendas.Create(Self);

  try

    //APONTANDO PARA A PASTA ONDE ESTAO OS COMPONENTES NFCE
    caminhoNFCE := ExtractFilePath(Application.ExeName) + 'nfe\';
    frmVendas.nfce.Configuracoes.Arquivos.PathSchemas := caminhoNFCE;

    frmVendas.nfce.SSL.LerCertificadosStore;

    addLinha := true;

    with frmCertificado.stringrid do
    begin
      ColWidths[0] := 220;
      ColWidths[1] := 250;
      ColWidths[2] := 120;
      ColWidths[3] := 80;
      ColWidths[4] := 150;

      Cells[0,0] := 'Num Série';
      Cells[1,0] := 'Razão Social';
      Cells[2,0] := 'CNPJ';
      Cells[3,0] := 'Validade';
      Cells[4,0] := 'Certificadora';

    end;

    for i := 0 to frmVendas.nfce.SSL.ListaCertificados.Count -1 do
    begin
      with frmVendas.nfce.SSL.ListaCertificados[i] do
        begin
          serie := NumeroSerie;

          with frmCertificado.stringrid do
          begin

            if addLinha then
            begin
              RowCount := RowCount + 1;

              Cells[0, RowCount - 1] := NumeroSerie;
              Cells[1, RowCount - 1] := RazaoSocial;
              Cells[2, RowCount - 1] := CNPJ;
              Cells[3, RowCount - 1] := FormatDateBr(DataVenc);
              Cells[4, RowCount - 1] := Certificadora;
              addLinha := true;
            end;
          end;
        end;
    end;

    frmCertificado.ShowModal;

    if frmCertificado.ModalResult = mrOk then
    begin
      certificadoDig := frmCertificado.stringrid.Cells[0, frmCertificado.stringrid.Row];
    end;

    frmVendas.nfce.Configuracoes.Certificados.NumeroSerie := certificadoDig;

    frmVendas.nfce.WebServices.StatusServico.Executar;
    ShowMessage(certificadoDig);
    ShowMessage(frmVendas.nfce.WebServices.StatusServico.Msg);

  finally
    FrmCertificado.Free;
  end;
end;

procedure TFrmMenu.ConsultarVendas1Click(Sender: TObject);
begin
  frmListaVendas := TfrmListaVendas.Create(Self);
  frmListaVendas.ShowModal;
end;

procedure TFrmMenu.EntradasProdutos1Click(Sender: TObject);
begin
  frmEntradaProdutos := TfrmEntradaProdutos.Create(Self);
  frmEntradaProdutos.ShowModal;
end;

procedure TFrmMenu.FormShow(Sender: TObject);
begin
  if (cargoUsuario = 'Admin') or (cargoUsuario = 'Gerente') then
  begin
    Usurios1.Enabled := True;
  end;

end;

procedure TFrmMenu.Fornecedores1Click(Sender: TObject);
begin
  frmFornecedor := TfrmFornecedor.Create(Self);
  frmFornecedor.ShowModal;
end;

procedure TFrmMenu.Funcionrios1Click(Sender: TObject);
begin
  FrmFuncionarios := TFrmFuncionarios.Create(Self);
  FrmFuncionarios.ShowModal;
end;

procedure TFrmMenu.Gastos1Click(Sender: TObject);
begin
  frmGastos := TfrmGastos.Create(Self);
  frmGastos.ShowModal;
end;

procedure TFrmMenu.Movimentaes2Click(Sender: TObject);
begin
  frmMovimentacoes := TfrmMovimentacoes.Create(Self);
  frmMovimentacoes.ShowModal;
end;

procedure TFrmMenu.Nvel1Click(Sender: TObject);
begin
  frmEstoqueBaixo := TfrmEstoqueBaixo.Create(Self);
  frmEstoqueBaixo.ShowModal;
end;

procedure TFrmMenu.Pagamentos1Click(Sender: TObject);
begin
//implementar conforme a tela gastos, com o nome do funcionário, valor pago, data do pagamento
  MessageDlg('Falta implementar!!', mtInformation, mbOKCancel, 0);
end;

procedure TFrmMenu.Produtos1Click(Sender: TObject);
begin
  frmProdutos := TfrmProdutos.Create(Self);
  frmProdutos.ShowModal;
end;

procedure TFrmMenu.SadasProdutos1Click(Sender: TObject);
begin
  frmSaidaProdutos := TfrmSaidaProdutos.Create(Self);
  frmSaidaProdutos.ShowModal;
end;

procedure TFrmMenu.Sair2Click(Sender: TObject);
begin
  Close;
end;

procedure TFrmMenu.Usurios1Click(Sender: TObject);
begin
  FrmUsuarios := TFrmUsuarios.Create(Self);
  FrmUsuarios.ShowModal;
end;

procedure TFrmMenu.Vendas1Click(Sender: TObject);
begin
  frmVendas := TfrmVendas.Create(Self);
  frmVendas.ShowModal;
end;

end.
