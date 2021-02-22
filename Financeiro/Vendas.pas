unit Vendas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.MPlayer, System.UITypes, FireDAC.Stan.Param, uclVendas;

type
  TfrmVendas = class(TForm)
    painelDetalhes: TPanel;
    painelDireita: TPanel;
    dbGridItens: TDBGrid;
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
    procedure edtCodBarrasClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FCaminhoimg: string;
    FTotalItem,
    FTotalVenda,
    FTotalComDesconto,
    FTotalTroco: Currency;
    FQtEstoque: Double;
    FRegras: TVenda;
    procedure limpar;
    procedure buscarProduto;
    procedure salvarItens;
    procedure salvarVenda;
    procedure limparFoto;
    procedure limparProdutos;

    procedure ExibeFoto(DataSet : TDataSet; BlobFieldName : String; ImageExibicao : TImage);
    procedure AssociarCamposDetalhes;
    procedure associarCamposVendas;
    procedure listar;
    procedure atualizaQtdadeEstoque;
    procedure iniciarNfce;

    function validaCampo : Boolean;
    procedure SetRegras(const Value: TVenda);
  public
    { Public declarations }
    property Regras: TVenda read FRegras write SetRegras;
  end;

var
  frmVendas: TfrmVendas;
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

procedure TfrmVendas.edtCodBarrasClick(Sender: TObject);
begin
  //validar se não encontrou o produto
end;

procedure TfrmVendas.edtDescontoChange(Sender: TObject);
begin
  FTotalComDesconto := FTotalVenda - StrToFloat(edtDesconto.Text);
  edtTotalVenda.Text := FormatFloat('R$ #,,,,0.00', FTotalComDesconto);
end;

procedure TfrmVendas.edtValorRecebidoChange(Sender: TObject);
begin
  FTotalTroco := StrToFloat(edtValorRecebido.Text) - FTotalComDesconto;
  edtTroco.Text := FormatFloat('R$ #,,,,0.00', FTotalTroco);
end;

{PROCEDIMENTO PADRÃO PARA RECUPERAR FOTO DO BANCO}
procedure TfrmVendas.ExibeFoto(DataSet: TDataSet; BlobFieldName: String; ImageExibicao: TImage);
 var
  MemoryStream: TMemoryStream;
  jpg : TPicture;
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
procedure TfrmVendas.AssociarCamposDetalhes;
begin
  FRegras.Dados.cdsDetalhesVendas.Append;
  FRegras.Dados.cdsDetalhesVendas.FieldByName('id_venda').AsInteger := 0;
  FRegras.Dados.cdsDetalhesVendas.FieldByName('id_produto').AsInteger := StrToInt(idproduto);
  FRegras.Dados.cdsDetalhesVendas.FieldByName('valor_unitario').AsCurrency := StrToCurr(edtPrecoUnitario.Text);
  FRegras.Dados.cdsDetalhesVendas.FieldByName('qtdade').AsFloat := StrToFloat(edtQtdade.Text);
  FRegras.Dados.cdsDetalhesVendas.FieldByName('valor_total').AsCurrency := FTotalItem;
  FRegras.Dados.cdsDetalhesVendas.FieldByName('id_funcionario').AsInteger := idUsuario;
  FRegras.Dados.cdsDetalhesVendas.Post;
end;

procedure TfrmVendas.associarCamposVendas;
begin
  dm.tbVendas.FieldByName('valor_bruto').Value := FTotalVenda;
  dm.tbVendas.FieldByName('valor_total').Value := FTotalComDesconto;
  dm.tbVendas.FieldByName('data_venda').Value := now;
  dm.tbVendas.FieldByName('id_funcionario').Value := idUsuario;
  dm.tbVendas.FieldByName('valor_troco').Value := FTotalTroco;
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
  if not Regras.BuscarProdutos(edtCodBarras.Text) then
    Exit;

  edtCdProduto.Text := IntToStr(Regras.Dados.cdsProdutos.FieldByName('id_produto').AsInteger);
  edtDescricao.Text := Regras.Dados.cdsProdutos.FieldByName('nm_produto').AsString;
  edtQtdadeEstoque.Text := FloatToStr(Regras.Dados.cdsProdutos.FieldByName('qtd_estoque').AsFloat);
  edtPrecoUnitario.Text := CurrToStr(Regras.Dados.cdsProdutos.FieldByName('valor').AsCurrency);
  idproduto := IntToStr(Regras.Dados.cdsProdutos.FieldByName('id_produto').AsInteger);

  ExibeFoto(Regras.Dados.cdsProdutos, 'imagem', imgProduto);

  if validaCampo then
    Exit;

  FTotalItem := StrToFloat(edtQtdade.Text) * StrToFloat(edtPrecoUnitario.Text);
  FTotalVenda := FTotalVenda + FTotalItem;

  //da erro ao inserir um item
  edtTotal.Text := FormatCurr('R$ 0.####', FTotalItem);
  edtSubTotal.Text := FormatCurr('R$ 0.####', FTotalVenda);
  //    edtTotal.Text := FloatToStr(FTotalItem);
  //    edtSubTotal.Text := FloatToStr(FTotalVenda);

  edtTotalVenda.Text := FormatCurr('R$ 0.####', FTotalVenda);
  FTotalComDesconto := FTotalVenda;

  salvarItens;

  limparProdutos;
end;

procedure TfrmVendas.FormActivate(Sender: TObject);
begin
  listar;
  FTotalVenda := FTotalVenda - totalProdutos;
  edtSubTotal.Text := FormatFloat('R$ #,,,,0.00', FTotalVenda);
  edtTotalVenda.Text := FormatFloat('R$ #,,,,0.00', FTotalVenda);
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
  FTotalItem := 0;
  FTotalVenda := 0;
  FTotalComDesconto := 0;
  FTotalTroco := 0;
  totalProdutos := 0;
  FRegras.Free;
end;

procedure TfrmVendas.FormCreate(Sender: TObject);
begin
  Regras := TVenda.Create;
  dbGridItens.DataSource := Regras.Dados.dsDetalhesVendas;
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

  FTotalItem := 0;
  FTotalVenda := 0;
  estoqueProduto := 0;
  FTotalComDesconto := 0;
  FTotalTroco := 0;
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
  FCaminhoimg := ExtractFileDir(GetCurrentDir) + '\Debug\img\sem-foto.jpg';
  imgProduto.Picture.LoadFromFile(FCaminhoimg);
end;

procedure TfrmVendas.limparProdutos;
begin
  edtCdProduto.Clear;
  edtDescricao.Clear;
  edtValorRecebido.Text := '0';
  edtPrecoUnitario.Clear;
  edtQtdadeEstoque.Clear;
  limparFoto;
  FTotalItem := 0;
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
  dbGridItens.Columns[0].Alignment := taCenter;
  dbGridItens.Columns[1].Alignment := taCenter;
  dbGridItens.Columns[2].Alignment := taCenter;
end;

procedure TfrmVendas.salvarItens;
begin
  if validaCampo = True then
    Exit;

  AssociarCamposDetalhes;
  //dm.tbDetalhesVendas.Post;
  listar;

  //toca audio após inserir um item
  MediaPlayer1.FileName := ExtractFileDir(GetCurrentDir) + '\Debug\img\barCode.wav';
  MediaPlayer1.Open;
  MediaPlayer1.Play;

  //diminui do estoque a qtdade do item

  FQtEstoque := StrToFloat(edtQtdadeEstoque.Text) - StrToFloat(edtQtdade.Text);
  dm.queryProdutos.Close;
  dm.queryProdutos.SQL.Clear;
  dm.queryProdutos.SQL.Add('update '+
                            'produtos set qtd_estoque = :qtd_estoque '+
                                'where '+
                            'id_produto = :id_produto');
  dm.queryProdutos.ParamByName('qtd_estoque').Value := FQtEstoque;
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
    idVenda := dm.queryVendas['id_venda'];

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
  dm.queryMovimentacoes.ParamByName('valor').Value := FTotalComDesconto;
  dm.queryMovimentacoes.ParamByName('id_funcionario').Value := idUsuario;
  dm.queryMovimentacoes.ParamByName('id_movimento').Value := idVenda;
  dm.queryMovimentacoes.ExecSQL;


  //imprimir cupom fiscal
  iniciarNfce;

  //imprimir cupom não fiscal

  limpar;
  limparFoto;
  edtQtdade.Text := '1';
  FTotalItem := 0;
  FTotalVenda := 0;
  FQtEstoque := 0;
  FTotalComDesconto := 0;
  FTotalTroco := 0;
  listar;
  FRegras.Dados.cdsDetalhesVendas.EmptyDataSet;
end;

procedure TfrmVendas.SetRegras(const Value: TVenda);
begin
  FRegras := Value;
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
