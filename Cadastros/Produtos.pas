unit Produtos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ExtCtrls, Vcl.Mask,
  Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, System.UITypes, FireDAC.Stan.Param,
  Vcl.ExtDlgs;

type
  TfrmProdutos = class(TForm)
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
    procedure DBGrid1CellClick(Column: TColumn);
    procedure btnGerarCodigoClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure rbNomeClick(Sender: TObject);
    procedure rbCpfClick(Sender: TObject);
    procedure edtBuscarCodigoChange(Sender: TObject);
    procedure edtBuscarNomeChange(Sender: TObject);
    procedure btnAddImagenClick(Sender: TObject);
    procedure edtCodBarrasChange(Sender: TObject);
  private
    { Private declarations }
    procedure limpar;
    procedure habilitarCampos;
    procedure desabilitarCampos;
    procedure associarCampos;
    procedure listar;
    procedure validaCampos;

    procedure GerarCodigo(codigo : String; Canvas : TCanvas);

    procedure buscarNome;
    procedure buscarCodigo;
    procedure SalvarFoto;
    procedure CarregarImagemPadrao;
    procedure ExibeFoto(DataSet : TDataSet; BlobFieldName : String; ImageExibicao : TImage);
  public
    { Public declarations }
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

procedure TfrmProdutos.btnAddImagenClick(Sender: TObject);
begin
 dialog.Execute();
 imgProduto.Picture.LoadFromFile(dialog.FileName);
 alterou := True;
end;

procedure TfrmProdutos.btnEditarClick(Sender: TObject);
begin
  validaCampos;
  associarCampos;
  dm.queryProdutos.Close;
  dm.queryProdutos.SQL.Clear;

  if alterou then
  begin
    dm.queryProdutos.SQL.Add('update '+
                                    'produtos set '+
                                    'codigo_barras = :codigo_barras, '+
                                    'nm_produto = :nm_produto, '+
                                    'descricao = :descricao, '+
                                    'valor = :valor, '+
                                    'un_medida = :un_medida, '+
                                    'fator_conversao = :fator_conversao, '+
                                    'imagem = :imagem '+
                              'where id_produto = :id_produto');
    img := TPicture.Create;
    img.LoadFromFile(dialog.FileName);
    dm.queryProdutos.ParamByName('imagem').Assign(img);
    img.Free;
    alterou := false;
  end
  else
  begin
   dm.queryProdutos.SQL.Add('update '+
                                  'produtos set '+
                                  'codigo_barras = :codigo_barras, '+
                                  'nm_produto = :nm_produto, '+
                                  'descricao = :descricao, '+
                                  'valor = :valor, '+
                                  'un_medida = :un_medida, '+
                                  'fator_conversao = :fator_conversao '+
                            'where id_produto = :id_produto');
  end;

  dm.queryProdutos.ParamByName('codigo_barras').AsString := edtCodBarras.Text;
  dm.queryProdutos.ParamByName('nm_produto').AsString := edtNomeProduto.Text;
  dm.queryProdutos.ParamByName('descricao').AsString := edtDescricao.Text;
  dm.queryProdutos.ParamByName('valor').AsCurrency := StrToCurr(edtValor.Text);
  dm.queryProdutos.ParamByName('un_medida').AsString := edtUNMedida.Text;
  dm.queryProdutos.ParamByName('fator_conversao').AsString := edtFatorConversao.Text;
  dm.queryProdutos.ParamByName('id_produto').Value := id;
  dm.queryProdutos.ExecSQL;

  listar;
  MessageDlg('Editado com Sucesso', mtInformation, mbOKCancel, 0);

  btnEditar.Enabled := false;
  btnExcluir.Enabled := false;
  limpar;
  desabilitarCampos;
end;

procedure TfrmProdutos.btnExcluirClick(Sender: TObject);
begin
  if MessageDlg('Deseja Excluir o registro?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    dm.queryCoringa.Close;
    dm.queryCoringa.SQL.Text := 'delete from produtos where id_produto = :id_produto';
    dm.queryCoringa.ParamByName('id_produto').AsInteger := StrToInt(edtIdProduto.Text);
    dm.queryCoringa.ExecSQL;

    MessageDlg('Excluido com Sucesso', mtInformation, mbOKCancel, 0);

    btnEditar.Enabled := false;
    btnExcluir.Enabled := false;
    limpar;
    listar;
  end;
end;

procedure TfrmProdutos.btnGerarCodigoClick(Sender: TObject);
var cod : String;
begin
  if Trim(edtCodBarras.Text) = '' then
  begin
    ShowMessage('Preencha o código de barras!');
    Exit;
  end;


  //verifica se o código está cadastrado
  dm.queryCoringa.Close;
  dm.queryCoringa.SQL.Clear;
  dm.queryCoringa.SQL.Add('select * from produtos where codigo_barras = ' + edtCodBarras.Text);
  dm.queryCoringa.Open();

  if not dm.queryCoringa.IsEmpty then
  begin
    cod := dm.queryCoringa['codigo_barras'];
    MessageDlg('O Código de Barras ' + cod + ' já está cadastrado!', mtInformation, mbOKCancel, 0);
    edtCodBarras.Clear;
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
  habilitarCampos;
  limpar;
  dm.tbProdutos.Insert;
  edtCodBarras.SetFocus;
end;

procedure TfrmProdutos.btnSalvarClick(Sender: TObject);
begin
  try
    validaCampos;
    associarCampos;
    SalvarFoto;
    dm.tbProdutos.Post;
    MessageDlg('Salvo com Sucesso', mtInformation, mbOKCancel, 0);
    limpar;
    desabilitarCampos;
    btnSalvar.Enabled := false;
    listar;
  except
    MessageDlg('Erro na Imagem', mtInformation, mbOKCancel, 0);
    dm.fd.Connected := True;
    dm.tbProdutos.Active := True;
    dm.tbProdutos.Insert;
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

procedure TfrmProdutos.DBGrid1CellClick(Column: TColumn);
begin
  habilitarCampos;
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
  edtIdProduto.Text := dm.queryProdutos.FieldByName('id_produto').Text;
  id := dm.queryProdutos.FieldByName('id_produto').AsString;
  codigoProduto := dm.queryProdutos.FieldByName('codigo_barras').AsString;

  if dm.queryProdutos.FieldByName('imagem').Value <> null then
    ExibeFoto(dm.queryProdutos, 'imagem', imgProduto);

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
if edtCodBarras.Text <> '_____________' then
  begin
    btnGerarCodigo.Enabled := true;
  end
else
  begin
   btnGerarCodigo.Enabled := false;
  end;
end;

procedure TfrmProdutos.FormCreate(Sender: TObject);
begin
  CarregarImagemPadrao;
  desabilitarCampos;
  dm.tbProdutos.Active := True;
  listar;

  rbNome.Checked := True;
  edtBuscarCodigo.Visible := False;
  dialog.FileName := ExtractFileDir(GetCurrentDir) + '\Debug\img\sem-foto.jpg';
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

procedure TfrmProdutos.habilitarCampos;
begin
  edtNomeProduto.Enabled := true;
  edtCodBarras.Enabled := true;
  edtDescricao.Enabled := true;
  edtValor.Enabled := true;
  edtUNMedida.Enabled := true;
  edtFatorConversao.Enabled := true;
  btnAddImagen.Enabled := true;
  imgProduto.Visible := true;
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
  imgCodBarras.Picture := nil;
  CarregarImagemPadrao;
end;

procedure TfrmProdutos.listar;
begin
  dm.queryProdutos.Close;
  dm.queryProdutos.SQL.Clear;
  dm.queryProdutos.SQL.Add('select * from produtos order by nm_produto asc');
  dm.queryProdutos.Open();
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

procedure TfrmProdutos.validaCampos;
begin
  if (Trim(edtNomeProduto.Text) = '') and (Trim(edtCodBarras.Text) = '') and
     (Trim(edtUNMedida.Text) = '') and (Trim(edtFatorConversao.Text) = '') then
  begin
    MessageDlg('Os campos não podem ser vazios', mtInformation, mbOKCancel, 0);
    edtCodBarras.SetFocus;
    Abort;
  end;
end;

{PROCEDIMENTO PADRÃO PARA RECUPERAR FOTO DO BANCO}
procedure TfrmProdutos.ExibeFoto(DataSet : TDataSet; BlobFieldName : String; ImageExibicao :
TImage);

 var MemoryStream:TMemoryStream; jpg : TPicture;
 const
  OffsetMemoryStream : Int64 = 0;

begin
  if not(DataSet.IsEmpty) and
  not((DataSet.FieldByName(BlobFieldName) as TBlobField).IsNull) then
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
