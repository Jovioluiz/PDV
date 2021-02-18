unit Vendas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.MPlayer, System.UITypes, FireDAC.Stan.Param;

type
  TfrmVendas = class(TForm)
    painelDetalhes: TPanel;
    painelDireita: TPanel;
    DBGrid1: TDBGrid;
    painelCentral: TPanel;
    edtCodBarras: TEdit;
    painelTituloDetalhes: TPanel;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edtCdProduto: TEdit;
    edtDescricao: TEdit;
    edtQtdade: TEdit;
    edtPrecoUnitario: TEdit;
    edtQtdadeEstoque: TEdit;
    edtTotal: TEdit;
    edtSubTotal: TEdit;
    edtDesconto: TEdit;
    edtTotalVenda: TEdit;
    edtValorRecebido: TEdit;
    edtTroco: TEdit;
    imgProduto: TImage;
    MediaPlayer1: TMediaPlayer;
    Panel3: TPanel;
    Label12: TLabel;
    Label13: TLabel;
    Panel4: TPanel;
    Panel2: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    Label6: TLabel;
    procedure edtCodBarrasChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure edtDescontoChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtValorRecebidoChange(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure limpar;
    procedure buscarProduto;
    procedure salvarItens;
    procedure salvarVenda;
    procedure limparFoto;
    procedure limparProdutos;

    procedure ExibeFoto(DataSet : TDataSet; BlobFieldName : String; ImageExibicao : TImage);
    procedure associarCamposDetalhes;
    procedure associarCamposVendas;
    procedure listar;
    procedure atualizaQtdadeEstoque;
    procedure iniciarNfce;

    function validaCampo : Boolean;
  public
    { Public declarations }
  end;

var
  frmVendas: TfrmVendas;
  caminhoimg : String;
  totalItem : Double;
  totalVenda : Double;
  qt_estoque : Double;
  totalComDesconto : Double;
  totalTroco : Double;
  idVenda : String;

implementation

{$R *.dfm}

uses Modulo, CancelarItem, Usuarios;

{ TfrmVendas }


procedure TfrmVendas.edtCodBarrasChange(Sender: TObject);
begin
  if edtCodBarras.Text <> '' then
    buscarProduto;
end;

procedure TfrmVendas.edtDescontoChange(Sender: TObject);
begin
  totalComDesconto := totalVenda - StrToFloat(edtDesconto.Text);
  edtTotalVenda.Text := FormatFloat('R$ #,,,,0.00', totalComDesconto);
end;

procedure TfrmVendas.edtValorRecebidoChange(Sender: TObject);
begin
  totalTroco := StrToFloat(edtValorRecebido.Text) - totalComDesconto;
  edtTroco.Text := FormatFloat('R$ #,,,,0.00', totalTroco);
end;

{PROCEDIMENTO PADRÃO PARA RECUPERAR FOTO DO BANCO}
procedure TfrmVendas.ExibeFoto(DataSet: TDataSet; BlobFieldName: String; ImageExibicao: TImage);
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


//colocar o nome do produto no grid
procedure TfrmVendas.associarCamposDetalhes;
begin
  dm.tbDetalhesVendas.FieldByName('id_venda').Text := '0';
  dm.tbDetalhesVendas.FieldByName('id_produto').Text := idproduto;
  dm.tbDetalhesVendas.FieldByName('valor_unitario').Text := edtPrecoUnitario.Text;
  dm.tbDetalhesVendas.FieldByName('qtdade').Text := edtQtdade.Text;
  dm.tbDetalhesVendas.FieldByName('valor_total').Text := edtTotal.Text;
  dm.tbDetalhesVendas.FieldByName('id_funcionario').AsInteger := idUsuario;
end;

procedure TfrmVendas.associarCamposVendas;
begin
  dm.tbVendas.FieldByName('valor_bruto').Value := totalVenda;
  dm.tbVendas.FieldByName('valor_total').Value := totalComDesconto;
  dm.tbVendas.FieldByName('data_venda').Value := now;
  dm.tbVendas.FieldByName('id_funcionario').Value := idUsuario;
  dm.tbVendas.FieldByName('valor_troco').Value := totalTroco;
  dm.tbVendas.FieldByName('valor_desconto').Value := edtDesconto.Text;
  dm.tbVendas.FieldByName('valor_recebido').Value := edtValorRecebido.Text;
  dm.tbVendas.FieldByName('status').Value := 'C';
end;

//atualiza o campo edtQtdadeEstoque com a quantidade em estoque do produto
procedure TfrmVendas.atualizaQtdadeEstoque;
begin
  dm.queryCoringa.Close;
  dm.queryCoringa.SQL.Clear;
  dm.queryCoringa.SQL.Add('select qtd_estoque '+
                                  'from '+
                              'produtos '+
                                  'where '+
                              'codigo_barras = :codigo_barras');
  dm.queryCoringa.ParamByName('codigo_barras').Value := edtCodBarras.Text;
  dm.queryCoringa.Open();

  edtQtdadeEstoque.Text := dm.queryCoringa['qtd_estoque'];
end;

procedure TfrmVendas.buscarProduto;
begin
  dm.queryProdutos.Close;
  dm.queryProdutos.SQL.Clear;
  dm.queryProdutos.SQL.Add('select * '+
                                  'from '+
                              'produtos '+
                                  'where '+
                              'codigo_barras = :codigo_barras');
  dm.queryProdutos.ParamByName('codigo_barras').Value := edtCodBarras.Text;
  dm.queryProdutos.Open();

  if not dm.queryProdutos.IsEmpty then
  begin
    edtCdProduto.Text := dm.queryProdutos['id_produto'];
    edtDescricao.Text := dm.queryProdutos['nm_produto'];
    edtQtdadeEstoque.Text := dm.queryProdutos['qtd_estoque'];
    edtPrecoUnitario.Text := dm.queryProdutos['valor'];
    idproduto := dm.queryProdutos['id_produto'];

    ExibeFoto(dm.queryProdutos, 'imagem', imgProduto);

    if validaCampo = True then
      Exit;

    totalItem := StrToFloat(edtQtdade.Text) * StrToFloat(edtPrecoUnitario.Text);
    totalVenda := totalVenda + totalItem;

    //da erro ao inserir um item
    //edtTotal.Text := FormatFloat('R$ #0.00', totalItem);
    //edtSubTotal.Text := FormatFloat('R$ #0.00', totalVenda);
    edtTotal.Text := FloatToStr(totalItem);
    edtSubTotal.Text := FloatToStr(totalVenda);

    edtTotalVenda.Text := FormatFloat('R$ #,,,,0.00', totalVenda);
    totalComDesconto := totalVenda;

    dm.tbDetalhesVendas.Insert;
    salvarItens;
  end
  else
    limparProdutos;
end;

procedure TfrmVendas.FormActivate(Sender: TObject);
begin
  listar;
  totalVenda := totalVenda - totalProdutos;
  edtSubTotal.Text := FormatFloat('R$ #,,,,0.00', totalVenda);
  edtTotalVenda.Text := FormatFloat('R$ #,,,,0.00', totalVenda);
  //ver uma maneira de atualizar a quantidade de estoque ao cancelar um item //atualizaQtdadeEstoque;
end;

procedure TfrmVendas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  edtTotal.Text := '0';
  edtSubTotal.Text := '0';
  edtDesconto.Text := '0';
  edtTotalVenda.Text := '0';
  edtValorRecebido.Text := '0';
  edtTroco.Text := '0';
  totalItem := 0;
  totalVenda := 0;
  totalComDesconto := 0;
  totalTroco := 0;
  totalProdutos := 0;
end;

procedure TfrmVendas.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  //ao pressionar Ctrl + x, abre a tela para cancelar o item
  if (ssCtrl in Shift) then
  if key = 88 then
  begin
    frmCancelarItem := TfrmCancelarItem.Create(Self);
    frmCancelarItem.Show;
  end;

  //F4 - finaliza cupom
  if key = 115 then
  begin
    dm.tbVendas.Insert;
    if edtValorRecebido.Text <= '0' then
    begin
      MessageDlg('Valor recebido deve ser maior que 0', mtWarning, mbOKCancel, 0);
      edtValorRecebido.SetFocus;
      Exit;
    end;

    if MessageDlg('Deseja Fechar a Venda?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      salvarVenda;
  end;
end;

procedure TfrmVendas.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0)
  end;
end;

procedure TfrmVendas.FormShow(Sender: TObject);
begin
  limparFoto;
  limpar;
  dm.tbVendas.Active := True;
  dm.tbDetalhesVendas.Active := True;
  edtQtdade.Text := '1';

  edtCodBarras.SetFocus;

  totalItem := 0;
  totalVenda := 0;
  estoqueProduto := 0;
  totalComDesconto := 0;
  totalTroco := 0;
end;

procedure TfrmVendas.iniciarNfce;
var
  caminhoNFCE: string;
begin
  caminhoNFCE := ExtractFilePath(Application.ExeName) + 'nfe\';
  //nfce.Configuracoes.Arquivos.PathSchemas := caminhoNFCE;
end;

procedure TfrmVendas.limpar;
begin
  edtTotal.Text := '0';
  edtSubTotal.Text := '0';
  edtDesconto.Text := '0';
  edtTotalVenda.Text := '0';
  edtValorRecebido.Text := '0';
  edtTroco.Text := '0';
  edtCdProduto.Clear;
  edtDescricao.Clear;
  edtPrecoUnitario.Clear;
  edtQtdadeEstoque.Clear;
  edtCodBarras.SetFocus;
end;

procedure TfrmVendas.limparFoto;
begin
  caminhoimg := ExtractFileDir(GetCurrentDir) + '\Debug\img\sem-foto.jpg';
  imgProduto.Picture.LoadFromFile(caminhoimg);
end;

procedure TfrmVendas.limparProdutos;
begin
  edtCdProduto.Clear;
  edtDescricao.Clear;
  edtValorRecebido.Text := '0';
  edtPrecoUnitario.Clear;
  edtQtdadeEstoque.Clear;
  limparFoto;
  totalItem := 0;
end;

procedure TfrmVendas.listar;
begin
  dm.queryDetalhesVendas.Close;
  dm.queryDetalhesVendas.SQL.Clear;
  dm.queryDetalhesVendas.SQL.Add('select '+
                                 '    * '+
                                 'from '+
                                 '  detalhes_vendas '+
                                 'where '+
                                 '  id_venda = 0 and '+
                                 '  id_funcionario = :id_funcionario '+
                                 'order by '+
                                 '  id_detalhe_venda asc');
  dm.queryDetalhesVendas.ParamByName('id_funcionario').AsInteger := idUsuario;
  dm.queryDetalhesVendas.Open();

  //alinhamneto do grid
  DBGrid1.Columns[0].Alignment := taCenter;
  DBGrid1.Columns[1].Alignment := taCenter;
  DBGrid1.Columns[2].Alignment := taCenter;
end;

procedure TfrmVendas.salvarItens;
begin
  if validaCampo = True then
    Exit;

  associarCamposDetalhes;
  dm.tbDetalhesVendas.Post;
  listar;

  //toca audio após inserir um item
  MediaPlayer1.FileName := ExtractFileDir(GetCurrentDir) + '\Debug\img\barCode.wav';
  MediaPlayer1.Open;
  MediaPlayer1.Play;

  //diminui do estoque a qtdade do item

  qt_estoque := StrToFloat(edtQtdadeEstoque.Text) - StrToFloat(edtQtdade.Text);
  dm.queryProdutos.Close;
  dm.queryProdutos.SQL.Clear;
  dm.queryProdutos.SQL.Add('update '+
                            'produtos set qtd_estoque = :qtd_estoque '+
                                'where '+
                            'id_produto = :id_produto');
  dm.queryProdutos.ParamByName('qtd_estoque').Value := qt_estoque;
  dm.queryProdutos.ParamByName('id_produto').Value := idproduto;
  dm.queryProdutos.ExecSQL;
  atualizaQtdadeEstoque;

  edtCodBarras.Clear;
  edtCodBarras.SetFocus;
  edtQtdade.Text := '1';
end;

procedure TfrmVendas.salvarVenda;
begin
  associarCamposVendas;
  dm.tbVendas.Post;

  //relacionar o id da venda com os id_venda dos itens
  dm.queryVendas.Close;
  dm.queryVendas.SQL.Clear;
  dm.queryVendas.SQL.Add('select * from vendas order by id_venda desc');
  dm.queryVendas.Open();

  if not dm.queryVendas.IsEmpty then
  begin
    idVenda := dm.queryVendas['id_venda'];
  end;

  dm.queryDetalhesVendas.Close;
  dm.queryDetalhesVendas.SQL.Clear;
  dm.queryDetalhesVendas.SQL.Add('update '+
                                 '  detalhes_vendas '+
                                 'set '+
                                 '  id_venda = :id_venda '+
                                 'where id_venda = 0 and '+
                                 '  id_funcionario = :id_funcionario');
  dm.queryDetalhesVendas.ParamByName('id_venda').AsString := idVenda;
  dm.queryDetalhesVendas.ParamByName('id_funcionario').AsInteger := idUsuario;
  dm.queryDetalhesVendas.ExecSQL;


  //lançar o valor da venda nas movimentações
  dm.queryMovimentacoes.Close;
  dm.queryMovimentacoes.SQL.Clear;
  dm.queryMovimentacoes.SQL.Add('insert '+
                                '   into '+
                                'movimentacoes '+
                                '   (tipo, movimento, valor, id_funcionario, data, id_movimento) '+
                                'values '+
                                '   (:tipo, :movimento, :valor, :id_funcionario, curDate(), :id_movimento)');
  dm.queryMovimentacoes.ParamByName('tipo').AsString := 'E';
  dm.queryMovimentacoes.ParamByName('movimento').AsString := 'V';
  dm.queryMovimentacoes.ParamByName('valor').Value := totalComDesconto;
  dm.queryMovimentacoes.ParamByName('id_funcionario').Value := idUsuario;
  dm.queryMovimentacoes.ParamByName('id_movimento').Value := idVenda;
  dm.queryMovimentacoes.ExecSQL;


  //imprimir cupom fiscal
  iniciarNfce;

  //imprimir cupom não fiscal

  limpar;
  limparFoto;
  edtQtdade.Text := '1';
  totalItem := 0;
  totalVenda := 0;
  qt_estoque := 0;
  totalComDesconto := 0;
  totalTroco := 0;
  listar;
end;

function TfrmVendas.validaCampo : Boolean;
var
  qtdEstoque, qtdVenda : Integer;
begin
  qtdEstoque := StrToInt(edtQtdadeEstoque.Text);
  qtdVenda := StrToInt(edtQtdade.Text);
  if qtdEstoque < qtdVenda then
  begin
    MessageDlg('Quantidade Indisponível em estoque!', mtInformation, mbOKCancel, 0);
    edtQtdade.Enabled := True;
    Result := True;
  end
  else
    Result := False;
end;

end.
