unit Produtos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ExtCtrls, Vcl.Mask,
  Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, System.UITypes, FireDAC.Stan.Param,
  Vcl.ExtDlgs, uclProduto;

type
  TfrmProdutos = class(TForm)
    dbGridProdutos: TDBGrid;
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
    edtCdProduto: TEdit;
    btnImprimir: TSpeedButton;
    edtCodBarras: TMaskEdit;
    Panel2: TPanel;
    btnGerarCodigo: TSpeedButton;
    Label1: TLabel;
    edtBuscarNome: TEdit;
    rbNome: TRadioButton;
    rbCpf: TRadioButton;
    edtBuscarCodigo: TMaskEdit;
    dialog: TOpenPictureDialog;
    procedure FormCreate(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure dbGridProdutosCellClick(Column: TColumn);
    procedure btnGerarCodigoClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure rbNomeClick(Sender: TObject);
    procedure rbCpfClick(Sender: TObject);
    procedure edtBuscarCodigoChange(Sender: TObject);
    procedure edtBuscarNomeChange(Sender: TObject);
    procedure btnAddImagenClick(Sender: TObject);
    procedure edtCodBarrasChange(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure dbGridProdutosDblClick(Sender: TObject);
    procedure edtCodBarrasEnter(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FRegras: TProduto;
    { Private declarations }
    procedure limpar;
    procedure HabilitarCampos;
    procedure desabilitarCampos;
    procedure listar;
    function ValidaCampos: Boolean;

    procedure GerarCodigo(codigo : String; Canvas : TCanvas);

    procedure buscarNome;
    procedure buscarCodigo;
    procedure SalvarFoto;
    procedure CarregarImagemPadrao;
    procedure ExibeFoto(DataSet : TDataSet; BlobFieldName : String; ImageExibicao : TImage);
  public
    { Public declarations }
    property Regras: TProduto read FRegras;
  end;

var
  frmProdutos: TfrmProdutos;
  id : String;
  img : TPicture;
  caminhoimg : String;
  alterou : Boolean;

implementation

{$R *.dfm}

uses Modulo, ImprimirBarras;

{ TfrmProdutos }

procedure TfrmProdutos.btnAddImagenClick(Sender: TObject);
begin
  dialog.Execute();
  imgProduto.Picture.LoadFromFile(dialog.FileName);
  alterou := True;
end;

procedure TfrmProdutos.btnEditarClick(Sender: TObject);
begin
  btnSalvar.Click;
  btnEditar.Enabled := false;
  btnExcluir.Enabled := false;
  limpar;
  desabilitarCampos;
end;

procedure TfrmProdutos.btnExcluirClick(Sender: TObject);
begin
  if MessageDlg('Deseja Excluir o registro?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    if FRegras.Excluir then
    begin
      MessageDlg('Excluido com Sucesso', mtInformation, mbOKCancel, 0);

      btnEditar.Enabled := False;
      btnExcluir.Enabled := False;
      limpar;
      listar;
    end;
  end;
end;

procedure TfrmProdutos.btnGerarCodigoClick(Sender: TObject);
begin
  if Trim(edtCodBarras.Text) = '' then
  begin
    ShowMessage('Preencha o código de barras!');
    Exit;
  end;

  //verifica se o código está cadastrado
  if not FRegras.VerificaCodigoBarras(edtCodBarras.Text) then
  begin
    ShowMessage('O Código de Barras ' + edtCodBarras.Text + ' já está cadastrado!');
    edtCodBarras.SetFocus;
    Exit;
  end;

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
  HabilitarCampos;
  limpar;
  edtCdProduto.SetFocus;
end;

procedure TfrmProdutos.btnSalvarClick(Sender: TObject);
var
  novo: Boolean;
begin
  try
    if not ValidaCampos then
    begin
      raise Exception.Create('Os campos não podem ser vazios');
      edtCodBarras.SetFocus;
    end;

    novo := FRegras.Pesquisar(StrToInt(edtCdProduto.Text));

    FRegras.cd_item := edtCdProduto.Text;
    FRegras.nm_produto := edtNomeProduto.Text;
    FRegras.descricao := edtDescricao.Text;
    FRegras.vl_unitario := StrToCurr(edtValor.Text);
    FRegras.un_medida := edtUNMedida.Text;
    FRegras.fator_conversao := StrToFloat(edtFatorConversao.Text);
    FRegras.data_cadastro := Now;

    //SalvarFoto;

    FRegras.Persistir(novo);
    ShowMessage('Salvo com Sucesso');
    limpar;
    desabilitarCampos;
    btnSalvar.Enabled := false;
    listar;
  except
    CarregarImagemPadrao;
    listar;
  end;

end;

procedure TfrmProdutos.buscarCodigo;
begin
  dm.queryProdutos.Close;
  dm.queryProdutos.SQL.Clear;
  dm.queryProdutos.SQL.Add('select * '+
                                  'from '+
                              'produtos '+
                                  'where '+
                              'codigo_barras like ' + QuotedStr('%'+edtBuscarCodigo.Text +'%'));
  dm.queryProdutos.Open();
end;

procedure TfrmProdutos.buscarNome;
begin
  dm.queryProdutos.Close;
  dm.queryProdutos.SQL.Clear;
  dm.queryProdutos.SQL.Add('select * '+
                                  'from '+
                              'produtos '+
                                  'where '+
                              'nm_produto like ' + QuotedStr('%'+edtBuscarNome.Text +'%'));
  dm.queryProdutos.Open();
end;

procedure TfrmProdutos.CarregarImagemPadrao;
begin
  caminhoimg := ExtractFileDir(GetCurrentDir) + '\Debug\img\sem-foto.jpg';
  imgProduto.Picture.LoadFromFile(caminhoimg);
end;

procedure TfrmProdutos.dbGridProdutosCellClick(Column: TColumn);
begin
  HabilitarCampos;
  btnEditar.Enabled := True;
  btnExcluir.Enabled := True;
  btnImprimir.Enabled := True;
  btnGerarCodigo.Enabled := True;

  dm.tbProdutos.Edit;

  edtNomeProduto.Text := dm.queryProdutos.FieldByName('nm_produto').AsString;
  edtCodBarras.Text := dm.queryProdutos.FieldByName('codigo_barras').AsString;
  edtDescricao.Text := dm.queryProdutos.FieldByName('descricao').AsString;
  edtUNMedida.Text := dm.queryProdutos.FieldByName('un_medida').AsString;
  edtFatorConversao.Text := dm.queryProdutos.FieldByName('fator_conversao').AsString;
  edtCodBarras.Text := dm.queryProdutos.FieldByName('codigo_barras').AsString;
  GerarCodigo(edtCodBarras.Text, imgCodBarras.Canvas);
  edtValor.Text := dm.queryProdutos.FieldByName('valor').AsString;
  edtCdProduto.Text := dm.queryProdutos.FieldByName('id_produto').Text;
  id := dm.queryProdutos.FieldByName('id_produto').AsString;
  codigoProduto := dm.queryProdutos.FieldByName('codigo_barras').AsString;

  if dm.queryProdutos.FieldByName('imagem').Value <> null then
    ExibeFoto(dm.queryProdutos, 'imagem', imgProduto);

end;

procedure TfrmProdutos.dbGridProdutosDblClick(Sender: TObject);
begin
  if chamada = 'Prod' then
  begin
    idproduto := dm.queryProdutos.FieldByName('id_produto').AsString;
    nomeProduto := dm.queryProdutos.FieldByName('nm_produto').AsString;
    estoqueProduto := dm.queryProdutos.FieldByName('qtd_estoque').AsFloat;
    unMedida := dm.queryProdutos.FieldByName('un_medida').AsString;
    Close;
    chamada := '';
  end;
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
  btnGerarCodigo.Enabled := false;
  imgProduto.Visible := false;
end;

procedure TfrmProdutos.edtBuscarCodigoChange(Sender: TObject);
begin
 buscarCodigo;
end;

procedure TfrmProdutos.edtBuscarNomeChange(Sender: TObject);
begin
  buscarNome;
end;

procedure TfrmProdutos.edtCodBarrasChange(Sender: TObject);
begin
  if Length(edtCodBarras.Text) <= 13 then
    btnGerarCodigo.Enabled := True
  else
   btnGerarCodigo.Enabled := False;
end;

procedure TfrmProdutos.edtCodBarrasEnter(Sender: TObject);
begin
  edtCodBarras.MaxLength := 13;

  if edtCodBarras.Text = '' then
    btnGerarCodigo.Enabled := False
  else
   btnGerarCodigo.Enabled := True;
end;

procedure TfrmProdutos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FRegras.Free;
end;

procedure TfrmProdutos.FormCreate(Sender: TObject);
begin
  FRegras := TProduto.Create;
  dbGridProdutos.DataSource := FRegras.Dados.dsProdutos;
  CarregarImagemPadrao;
  desabilitarCampos;

  listar;

  rbNome.Checked := True;
  edtBuscarCodigo.Visible := False;
  dialog.FileName := ExtractFileDir(GetCurrentDir) + '\Debug\img\sem-foto.jpg';
end;

procedure TfrmProdutos.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

//gera o código de barras
procedure TfrmProdutos.GerarCodigo(codigo : String; Canvas : TCanvas);
const
  digitos : array['0'..'9'] of string[5]= ('00110', '10001', '01001', '11000',
  '00101', '10100', '01100', '00011', '10010', '01010');
  var s : string;
  i, j, x, t : Integer;
begin
  try
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
      Canvas.Rectangle(0,0, 500, 50);
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
      Canvas.Rectangle(x, 0, x + t, 50);
      // Passar para a próxima barra
      x := x + t;
    end;
  except
    MessageDlg('Preencha todo o código de barras!', mtInformation, mbOKCancel, 0);
    dm.fd.Connected := True;
    dm.tbProdutos.Active := True;
    dm.tbProdutos.Insert;
    listar;
  end;
end;

procedure TfrmProdutos.HabilitarCampos;
begin
  edtNomeProduto.Enabled := True;
  edtCodBarras.Enabled := True;
  edtDescricao.Enabled := True;
  edtValor.Enabled := True;
  edtUNMedida.Enabled := True;
  edtFatorConversao.Enabled := True;
  btnAddImagen.Enabled := True;
  imgProduto.Visible := True;
  edtCdProduto.Enabled := True;
end;

procedure TfrmProdutos.limpar;
begin
  edtCdProduto.Clear;
  edtNomeProduto.Clear;
  edtCodBarras.Clear;
  edtDescricao.Clear;
  edtValor.Clear;
  edtUNMedida.Clear;
  edtFatorConversao.Clear;
  imgCodBarras.Picture := nil;
  CarregarImagemPadrao;
end;

procedure TfrmProdutos.listar;
begin
  FRegras.Listar;
end;

procedure TfrmProdutos.rbCpfClick(Sender: TObject);
begin
  listar;
  edtBuscarCodigo.Visible := True;
  edtBuscarNome.Visible := false;
  edtBuscarCodigo.SetFocus;
end;

procedure TfrmProdutos.rbNomeClick(Sender: TObject);
begin
  listar;
  edtBuscarCodigo.Visible := false;
  edtBuscarNome.Visible := True;
  edtBuscarNome.SetFocus;
end;

procedure TfrmProdutos.SalvarFoto;
begin
  if dialog.FileName <> '' then
  begin
    img := TPicture.Create;
    img.LoadFromFile(dialog.FileName);
    dm.tbProdutos.FieldByName('imagem').Assign(img);
    img.Free;
    dialog.FileName := ExtractFileDir(GetCurrentDir) + '\Debug\img\sem-foto.jpg';
    alterou := false;
  end
  else
  begin
    dm.tbProdutos.FieldByName('imagem').Value := ExtractFileDir(GetCurrentDir) + '\Debug\img\sem-foto.jpg';
  end;
end;

function TfrmProdutos.ValidaCampos: Boolean;
begin
  Result := True;

  if (Trim(edtCdProduto.Text) = '') then
    Exit(False);

  if (Trim(edtNomeProduto.Text) = '') then
    Exit(False);

  if (Trim(edtCodBarras.Text) = '') then
    Exit(False);

  if (Trim(edtUNMedida.Text) = '') then
    Exit(False);
end;

{PROCEDIMENTO PADRÃO PARA RECUPERAR FOTO DO BANCO}
procedure TfrmProdutos.ExibeFoto(DataSet : TDataSet; BlobFieldName : String; ImageExibicao :
TImage);

 var MemoryStream:TMemoryStream; jpg : TPicture;
 const
  OffsetMemoryStream : Int64 = 0;

begin
  if not(DataSet.IsEmpty)
    and not((DataSet.FieldByName(BlobFieldName) as TBlobField).IsNull) then
    try
      MemoryStream := TMemoryStream.Create;
      Jpg := TPicture.Create;
      (DataSet.FieldByName(BlobFieldName) as
          TBlobField).SaveToStream(MemoryStream);
      MemoryStream.Position := OffsetMemoryStream;
      Jpg.LoadFromStream(MemoryStream);
      ImageExibicao.Picture.Assign(Jpg);
    finally
     // Jpg.Free;
      MemoryStream.Free;
    end
  else
    ImageExibicao.Picture := Nil;
end;

end.
