unit Produtos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ExtCtrls, Vcl.Mask,
  Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, System.UITypes;

type
  TfrmProdutos = class(TForm)
    Label1: TLabel;
    edtBuscarNome: TEdit;
    DBGrid1: TDBGrid;
    btnNovo: TSpeedButton;
    btnSalvar: TSpeedButton;
    btnEditar: TSpeedButton;
    btnExcluir: TSpeedButton;
    edtNomeProduto: TEdit;
    edtDescricao: TMaskEdit;
    Label11: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    imgCodBarras: TImage;
    Label4: TLabel;
    edtValor: TMaskEdit;
    imgProduto: TImage;
    btnAddImagen: TSpeedButton;
    Panel1: TPanel;
    Label5: TLabel;
    edtUNMedida: TEdit;
    Label6: TLabel;
    edtFatorConversao: TEdit;
    Label7: TLabel;
    edtIdProduto: TEdit;
    btnImprimir: TSpeedButton;
    edtCodBarras: TMaskEdit;
    Panel2: TPanel;
    btnGerarCodigo: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure btnGerarCodigoClick(Sender: TObject);
  private
    { Private declarations }
    procedure limpar;
    procedure habilitarCampos;
    procedure desabilitarCampos;
    procedure associarCampos;
    procedure listar;
    procedure validaCampos;

    procedure GerarCodigo(codigo : String; Canvas : TCanvas);

  public
    { Public declarations }
  end;

var
  frmProdutos: TfrmProdutos;
  id : String;

implementation

{$R *.dfm}

uses Modulo, ImprimirBarras;

{ TfrmProdutos }

procedure TfrmProdutos.associarCampos;
begin
  dm.tbProdutos.FieldByName('nm_produto').AsString := edtNomeProduto.Text;
  dm.tbProdutos.FieldByName('codigo_barras').AsString := edtCodBarras.Text;
  dm.tbProdutos.FieldByName('descricao').AsString := edtDescricao.Text;
  dm.tbProdutos.FieldByName('valor').AsString := edtValor.Text;
  dm.tbProdutos.FieldByName('qtd_estoque').AsCurrency := 0;
  dm.tbProdutos.FieldByName('un_medida').AsString := edtUNMedida.Text;
  dm.tbProdutos.FieldByName('fator_conversao').AsString := edtFatorConversao.Text;
  dm.tbProdutos.FieldByName('data_cadastro').AsString := DateToStr(Date);
end;

procedure TfrmProdutos.btnGerarCodigoClick(Sender: TObject);
begin
  GerarCodigo(edtCodBarras.Text, imgCodBarras.Canvas);
  btnSalvar.Enabled := True;
end;

procedure TfrmProdutos.btnImprimirClick(Sender: TObject);
begin
  frmImprimirBarras := TfrmImprimirBarras.Create(Self);
  frmImprimirBarras.ShowModal;
end;

procedure TfrmProdutos.btnNovoClick(Sender: TObject);
begin
  habilitarCampos;
  limpar;
  dm.tbProdutos.Insert;
  btnGerarCodigo.Enabled := true;
end;

procedure TfrmProdutos.btnSalvarClick(Sender: TObject);
begin
  validaCampos;
  associarCampos;
  dm.tbProdutos.Post;
  MessageDlg('Salvo com Sucesso', mtInformation, mbOKCancel, 0);
  limpar;
  desabilitarCampos;
  btnSalvar.Enabled := false;
  listar;
end;

procedure TfrmProdutos.DBGrid1CellClick(Column: TColumn);
begin
  habilitarCampos;
  btnEditar.Enabled := True;
  btnExcluir.Enabled := True;
  btnImprimir.Enabled := True;

  dm.tbProdutos.Edit;

  edtNomeProduto.Text := dm.queryProdutos.FieldByName('nm_produto').AsString;
  edtCodBarras.Text := dm.queryProdutos.FieldByName('codigo_barras').AsString;
  edtDescricao.Text := dm.queryProdutos.FieldByName('descricao').AsString;
  edtUNMedida.Text := dm.queryProdutos.FieldByName('un_medida').AsString;
  edtFatorConversao.Text := dm.queryProdutos.FieldByName('fator_conversao').AsString;
  edtCodBarras.Text := dm.queryProdutos.FieldByName('codigo_barras').AsString;
  GerarCodigo(edtCodBarras.Text, imgCodBarras.Canvas);
  edtValor.Text := dm.queryProdutos.FieldByName('valor').AsString;
  edtIdProduto.Text := dm.queryProdutos.FieldByName('id_produto').Text;
  id := dm.queryProdutos.FieldByName('id_produto').AsString;
  codigoProduto := dm.queryProdutos.FieldByName('codigo_barras').AsString;
end;

procedure TfrmProdutos.desabilitarCampos;
begin
  edtNomeProduto.Enabled := false;
  edtDescricao.Enabled := false;
  edtCodBarras.Enabled := false;
  edtValor.Enabled := false;
  edtUNMedida.Enabled := false;
  edtFatorConversao.Enabled := false;
  btnAddImagen.Enabled := false;
end;

procedure TfrmProdutos.FormCreate(Sender: TObject);
begin
  desabilitarCampos;
  dm.tbProdutos.Active := True;
  listar;
end;

//gera ocódigo de barras
procedure TfrmProdutos.GerarCodigo(codigo : String; Canvas : TCanvas);
const
  digitos : array['0'..'9'] of string[5]= ('00110', '10001', '01001', '11000',
  '00101', '10100', '01100', '00011', '10010', '01010');
  var s : string;
  i, j, x, t : Integer;
begin
  // Gerar o valor para desenhar o código de barras
  // Caracter de início
  s := '0000';
  for i := 1 to length(codigo) div 2 do
    for j := 1 to 5 do
    s := s + Copy(Digitos[codigo[i * 2 - 1]], j, 1) + Copy(Digitos[codigo[i * 2]], j, 1);
    // Caracter de fim
    s := s + '100';
    // Desenhar em um objeto canvas
    // Configurar os parâmetros iniciais
    x := 0;
    // Pintar o fundo do código de branco
    Canvas.Brush.Color := clWhite;
    Canvas.Pen.Color := clWhite;
    Canvas.Rectangle(10,10, 500, 79);
    // Definir as cores da caneta
    Canvas.Brush.Color := clBlack;
    Canvas.Pen.Color := clBlack;
  // Escrever o código de barras no canvas
  for i := 1 to length(s) do
  begin
    // Definir a espessura da barra
    t := strToInt(s[i]) * 2 + 1;
    // Imprimir apenas barra sim barra não (preto/branco - intercalado);
    if i mod 2 = 1 then
    Canvas.Rectangle(x, 0, x + t, 79);
    // Passar para a próxima barra
    x := x + t;
  end;
end;

procedure TfrmProdutos.habilitarCampos;
begin
  edtNomeProduto.Enabled := true;
  edtCodBarras.Enabled := true;
  edtDescricao.Enabled := true;
  edtValor.Enabled := true;
  edtUNMedida.Enabled := true;
  edtFatorConversao.Enabled := true;
  btnAddImagen.Enabled := true;
end;

procedure TfrmProdutos.limpar;
begin
  edtIdProduto.Clear;
  edtNomeProduto.Clear;
  edtCodBarras.Clear;
  edtDescricao.Clear;
  edtValor.Clear;
  edtUNMedida.Clear;
  edtFatorConversao.Clear;
end;

procedure TfrmProdutos.listar;
begin
  dm.queryProdutos.Close;
  dm.queryProdutos.SQL.Clear;
  dm.queryProdutos.SQL.Add('select * from produtos order by nm_produto asc');
  dm.queryProdutos.Open();
end;

procedure TfrmProdutos.validaCampos;
begin
  if (Trim(edtNomeProduto.Text) = '') and (Trim(edtCodBarras.Text) = '') then
  begin
    MessageDlg('Os campos não podem ser vazios', mtInformation, mbOKCancel, 0);
    edtCodBarras.SetFocus;
    Exit;
  end;
end;

end.
