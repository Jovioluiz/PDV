unit EntradasProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls;

type
  TfrmEntradaProdutos = class(TForm)
    Label2: TLabel;
    btnNovo: TSpeedButton;
    btnSalvar: TSpeedButton;
    btnEditar: TSpeedButton;
    btnExcluir: TSpeedButton;
    Label1: TLabel;
    btnBuscarProduto: TSpeedButton;
    Label3: TLabel;
    edtProduto: TEdit;
    DBGrid1: TDBGrid;
    edtQuantidade: TEdit;
    Label4: TLabel;
    edtValor: TEdit;
    Label5: TLabel;
    edtFornecedor: TEdit;
    btnBuscarFornecedor: TSpeedButton;
    edtDataBuscar: TDateTimePicker;
    Label6: TLabel;
    edtUnMedida: TEdit;
    lblTotal: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnBuscarProdutoClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnBuscarFornecedorClick(Sender: TObject);
    procedure edtQuantidadeChange(Sender: TObject);
    procedure edtValorChange(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
  private
    { Private declarations }
    procedure limpar;
    procedure habilitarCampos;
    procedure desabilitarCampos;
    procedure associarCampos;
    procedure buscarData;
    procedure listar;
    procedure validaCampos;
  public
    { Public declarations }
  end;

var
  frmEntradaProdutos: TfrmEntradaProdutos;
  total : Double;

implementation

{$R *.dfm}

uses Modulo, Produtos, Fornecedores;

procedure TfrmEntradaProdutos.associarCampos;
begin
 dm.tbEntradaProdutos.FieldByName('id_produto').AsString := edtProduto.Text;
 dm.tbEntradaProdutos.FieldByName('qtdade').AsString := edtQuantidade.Text;
 dm.tbEntradaProdutos.FieldByName('id_fornecedor').AsString := idFornecedor;
 dm.tbEntradaProdutos.FieldByName('valor').AsString := edtValor.Text;
 dm.tbEntradaProdutos.FieldByName('total').AsCurrency := total;
 dm.tbEntradaProdutos.FieldByName('data_entrada').AsString := DateToStr(Date);
end;

procedure TfrmEntradaProdutos.btnBuscarFornecedorClick(Sender: TObject);
begin
  chamada := 'Forn';
  frmFornecedor := TfrmFornecedor.Create(Self);
  frmFornecedor.Show;
end;

procedure TfrmEntradaProdutos.btnBuscarProdutoClick(Sender: TObject);
begin
  chamada := 'Prod';
  frmProdutos := TfrmProdutos.Create(Self);
  frmProdutos.Show;
end;

procedure TfrmEntradaProdutos.btnNovoClick(Sender: TObject);
begin
  habilitarCampos;
  dm.tbEntradaProdutos.Insert;
  btnSalvar.Enabled := True;
end;

procedure TfrmEntradaProdutos.btnSalvarClick(Sender: TObject);
begin
  validaCampos;

  associarCampos;
  dm.tbEntradaProdutos.Post;
  MessageDlg('Salvo com Sucesso', mtInformation, mbOKCancel, 0);
  limpar;
  desabilitarCampos;
  btnSalvar.Enabled := false;
  listar;
end;

procedure TfrmEntradaProdutos.buscarData;
begin

end;

procedure TfrmEntradaProdutos.desabilitarCampos;
begin
  edtQuantidade.Enabled := false;
  edtValor.Enabled := false;
  edtUnMedida.Enabled := false;
  btnBuscarProduto.Enabled := false;
  btnBuscarFornecedor.Enabled := false;
end;

procedure TfrmEntradaProdutos.edtQuantidadeChange(Sender: TObject);
begin
  total := StrToFloat(edtQuantidade.Text) * StrToFloat(edtValor.Text);
  lblTotal.Caption := FloatToStr(total);
end;

procedure TfrmEntradaProdutos.edtValorChange(Sender: TObject);
begin
  total := StrToFloat(edtQuantidade.Text) * StrToFloat(edtValor.Text);
  lblTotal.Caption := FloatToStr(total);
end;

procedure TfrmEntradaProdutos.FormActivate(Sender: TObject);
begin
  edtProduto.Text := nomeProduto;
  edtFornecedor.Text := nomeFornecedor;
end;

procedure TfrmEntradaProdutos.FormCreate(Sender: TObject);
begin
  desabilitarCampos;
  dm.tbEntradaProdutos.Active := True;
  listar;
end;

procedure TfrmEntradaProdutos.habilitarCampos;
begin
  edtQuantidade.Enabled := true;
  edtValor.Enabled := true;
  edtUnMedida.Enabled := true;
  btnBuscarProduto.Enabled := true;
  btnBuscarFornecedor.Enabled := true;
  lblTotal.Visible := true;
end;

procedure TfrmEntradaProdutos.limpar;
begin
  edtQuantidade.Text := '1';
  edtValor.Text := '0';
  edtUnMedida.Clear;
  edtProduto.Clear;
  edtFornecedor.Clear;
  lblTotal.Caption := '';
  total := 0;
end;

procedure TfrmEntradaProdutos.listar;
begin
  dm.queryEntradaProdutos.Close;
  dm.queryEntradaProdutos.SQL.Clear;
  dm.queryEntradaProdutos.SQL.Add('select * from entrada_produtos order by data_entrada desc');
  dm.queryEntradaProdutos.Open();
end;

procedure TfrmEntradaProdutos.validaCampos;
begin
  if Trim(edtProduto.Text) = '' then
  begin
    MessageDlg('Escolha um produto!', mtInformation, mbOKCancel,0);
    Exit;
  end;

  if Trim(edtFornecedor.Text) = '' then
  begin
    MessageDlg('Escolha um Fornecedor!', mtInformation, mbOKCancel,0);
    Exit;
  end;
end;

end.
