unit Vendas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.MPlayer, System.UITypes, FireDAC.Stan.Param, uclVendas,
  uFinanceiro;

type
  TfrmVendas = class(TForm)
    painelDetalhes: TPanel;
    painelDireita: TPanel;
    dbGridItens: TDBGrid;
    painelCentral: TPanel;
    edtCodBarras: TEdit;
    painelTituloDetalhes: TPanel;
    Panel1: TPanel;
    edtQtdade: TEdit;
    edtTotalItem: TEdit;
    edtSubTotal: TEdit;
    edtDesconto: TEdit;
    edtTotalVenda: TEdit;
    edtValorRecebido: TEdit;
    edtTroco: TEdit;
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
    pnlImagem: TPanel;
    imgProduto: TImage;
    procedure edtCodBarrasChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure edtDescontoChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtValorRecebidoChange(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure edtCodBarrasExit(Sender: TObject);
    procedure edtQtdadeExit(Sender: TObject);
    procedure edtQtdadeChange(Sender: TObject);
  private
    { Private declarations }
    FCaminhoimg: string;
    FTotalItem,
    FTotalVenda,
    FTotalComDesconto,
    FTotalTroco,
    FSubTotal,
    FTotalDesconto,
    FTotalRecebido,
    FTroco: Currency;
    FQtEstoque: Double;
    FRegras: TVenda;
    FIDItem: Integer;
    FFinanceiro: TFinanceiro;
    procedure limpar;
    procedure buscarProduto;
    procedure salvarItens;
    procedure SalvarVenda;
    procedure limparFoto;
    procedure limparProdutos;

    procedure AssociarCamposDetalhes;
    procedure AssociarCamposVendas;
    procedure listar;
    procedure atualizaQtdadeEstoque;
    procedure iniciarNfce;

    procedure ValidaEstoque;
    procedure SetRegras(const Value: TVenda);
    procedure SetFinanceiro(const Value: TFinanceiro);
  public
    { Public declarations }
    property Regras: TVenda read FRegras write SetRegras;
    property IDItem: Integer read FIDItem write FIDItem;
    property Financeiro: TFinanceiro read FFinanceiro write SetFinanceiro;
  end;

var
  frmVendas: TfrmVendas;
  idVenda : String;

implementation

{$R *.dfm}

uses Modulo, CancelarItem, Usuarios, uUtil;

{ TfrmVendas }


procedure TfrmVendas.edtCodBarrasChange(Sender: TObject);
begin
//
end;

procedure TfrmVendas.edtCodBarrasExit(Sender: TObject);
begin
  edtQtdade.Text := '1';
  if edtCodBarras.Text <> '' then
  begin
    buscarProduto;
    ValidaEstoque;
  end;

  if FRegras.Dados.cdsDetalhesVendas.RecordCount > 0 then
    edtValorRecebido.SetFocus;
end;

procedure TfrmVendas.edtDescontoChange(Sender: TObject);
begin
  FTotalComDesconto := FTotalVenda - StrToFloat(edtDesconto.Text);
  edtTotalVenda.Text := FormatFloat('R$ #,,,,0.00', FTotalComDesconto);
end;

procedure TfrmVendas.edtQtdadeChange(Sender: TObject);
begin
//  if edtQtdade.Text <> '' then
//  begin
//    FSubTotal := 0;
//    FTotalItem := StrToFloat(edtQtdade.Text) * StrToFloat(edtPrecoUnitario.Text);
//    FTotalVenda := FTotalVenda + FTotalItem;
//
//    edtTotalItem.Text := FormatCurr('R$ 0.####', FTotalItem);
//
//    edtTotalVenda.Text := FormatCurr('R$ 0.####', FTotalVenda);
//    FTotalComDesconto := FTotalVenda;
//    FSubTotal := FSubTotal + FTotalItem;
//    edtTotalItem.Text := CurrToStr(FTotalItem);
//    edtSubTotal.Text := FormatCurr('0.####', FSubTotal);
//    edtTotalVenda.Text := CurrToStr(FTotalVenda);
//  end;
end;

procedure TfrmVendas.edtQtdadeExit(Sender: TObject);
begin
  if (edtQtdade.Text <> '') and (edtCodBarras.Text <> '') then
  begin
    ValidaEstoque;
    FSubTotal := 0;
    FTotalItem := StrToFloat(edtQtdade.Text) * FRegras.Dados.cdsProdutos.FieldByName('vl_unitario').AsCurrency;// StrToFloat(edtPrecoUnitario.Text);
    FTotalVenda := FTotalVenda + FTotalItem;

    edtTotalItem.Text := FormatCurr('R$ 0.####', FTotalItem);

    edtTotalVenda.Text := FormatCurr('R$ 0.####', FTotalVenda);
    FTotalComDesconto := FTotalVenda;
    FSubTotal := FSubTotal + FTotalItem;
    edtTotalItem.Text := CurrToStr(FTotalItem);
    edtSubTotal.Text := FormatCurr('0.####', FSubTotal);
    edtTotalVenda.Text := CurrToStr(FTotalVenda);

    AssociarCamposDetalhes;
    edtTotalVenda.Text := CurrToStr(FRegras.RetornaValorTotal(FRegras.Dados.cdsDetalhesVendas));
//    SalvarVenda;
//    salvarItens;
    limparProdutos;
  end
  else
    raise Exception.Create('Informe uma quantidade');
end;

procedure TfrmVendas.edtValorRecebidoChange(Sender: TObject);
begin
  if edtValorRecebido.Text <> '' then
  begin
    FTotalTroco := StrToFloat(edtValorRecebido.Text) - FTotalComDesconto;
    edtTroco.Text := FormatFloat('R$ #,,,,0.00', FTotalTroco);
  end;
end;

procedure TfrmVendas.AssociarCamposDetalhes;
begin
  FRegras.Dados.cdsDetalhesVendas.Append;
  FRegras.Dados.cdsDetalhesVendas.FieldByName('id_venda').AsInteger := FRegras.IDVenda;
  FRegras.Dados.cdsDetalhesVendas.FieldByName('id_item').AsInteger := FIDItem;
  FRegras.Dados.cdsDetalhesVendas.FieldByName('cd_item').AsString := FRegras.Dados.cdsProdutos.FieldByName('cd_item').AsString;
  FRegras.Dados.cdsDetalhesVendas.FieldByName('nm_produto').AsString := FRegras.Dados.cdsProdutos.FieldByName('nm_produto').AsString;
  FRegras.Dados.cdsDetalhesVendas.FieldByName('vl_unitario').AsCurrency := FRegras.Dados.cdsProdutos.FieldByName('vl_unitario').AsCurrency;;
  FRegras.Dados.cdsDetalhesVendas.FieldByName('qt_venda').AsFloat := StrToFloat(edtQtdade.Text);
  FRegras.Dados.cdsDetalhesVendas.FieldByName('vl_total').AsCurrency := FTotalItem;
  FRegras.Dados.cdsDetalhesVendas.FieldByName('id_funcionario').AsInteger := FCdUsuario;
  FRegras.Dados.cdsDetalhesVendas.Post;
end;

procedure TfrmVendas.AssociarCamposVendas;
begin
  FRegras.Dados.cdsVendas.Append;
  FRegras.Dados.cdsVendas.FieldByName('valor_bruto').AsCurrency := FTotalVenda;
  FRegras.Dados.cdsVendas.FieldByName('valor_total').AsCurrency := FTotalComDesconto;
  FRegras.Dados.cdsVendas.FieldByName('data_venda').AsDateTime := Now;
  FRegras.Dados.cdsVendas.FieldByName('id_funcionario').AsInteger := FCdUsuario;
  FRegras.Dados.cdsVendas.FieldByName('valor_troco').AsCurrency := FTotalTroco;
  FRegras.Dados.cdsVendas.FieldByName('valor_desconto').AsCurrency := StrToCurr(edtDesconto.Text);
  FRegras.Dados.cdsVendas.FieldByName('valor_recebido').AsCurrency := StrToCurr(edtValorRecebido.Text);
  FRegras.Dados.cdsVendas.FieldByName('status').AsString := 'C';
  FRegras.Dados.cdsVendas.Post;
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

  //edtQtdadeEstoque.Text := dm.queryCoringa['qtd_estoque'];
end;

procedure TfrmVendas.buscarProduto;
var
  imagem: TUtil;
begin
  if not Regras.BuscarProdutos(edtCodBarras.Text) then
    Exit;

  imagem := TUtil.Create;

  try

//    edtCdProduto.Text := Regras.Dados.cdsProdutos.FieldByName('cd_item').AsString;
//    edtDescricao.Text := Regras.Dados.cdsProdutos.FieldByName('nm_produto').AsString;
//    edtQtdadeEstoque.Text := FloatToStr(Regras.Dados.cdsProdutos.FieldByName('qt_estoque').AsFloat);
//    edtPrecoUnitario.Text := CurrToStr(Regras.Dados.cdsProdutos.FieldByName('vl_unitario').AsCurrency);
    FIDItem := Regras.Dados.cdsProdutos.FieldByName('id_item').AsInteger;

//    imagem.ExibeFoto(Regras.Dados.cdsProdutos, 'imagem', imgProduto);

  finally
    imagem.Free;
  end;

  //AssociarCamposDetalhes;
  //limparProdutos;
end;

procedure TfrmVendas.FormActivate(Sender: TObject);
begin
//  listar;
//  FTotalVenda := FTotalVenda - totalProdutos;

  //ver uma maneira de atualizar a quantidade de estoque ao cancelar um item //atualizaQtdadeEstoque;
end;

procedure TfrmVendas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  edtTotalItem.Text := '0';
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
  FFinanceiro.Free;
end;

procedure TfrmVendas.FormCreate(Sender: TObject);
begin
  Regras := TVenda.Create;
  FFinanceiro := TFinanceiro.Create;
  dbGridItens.DataSource := Regras.Dados.dsDetalhesVendas;
  FTotalTroco := 0;
  FTotalDesconto := 0;
  FTotalRecebido := 0;
  edtSubTotal.Text := FormatCurr('R$ ###,##0.00', FTotalVenda);
  edtTotalVenda.Text := FormatCurr('R$ ###,##0.00', FTotalVenda);
  edtTotalItem.Text := FormatCurr('R$ ###,##0.00', FTotalItem);
//  edtDesconto.Text := FormatCurr('R$ ###,##0.00', FTotalDesconto);
//  edtValorRecebido.Text := FormatCurr('R$ ###,##0.00', FTotalRecebido);
//  edtTroco.Text := FormatCurr('R$ ###,##0.00', FTotalTroco);
end;

procedure TfrmVendas.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  cancelaItem: TfrmCancelarItem;
begin
  //ao pressionar Ctrl + z, abre a tela para cancelar o item
  if (ssCtrl in Shift) then
  begin
    if key = 90 then
    begin
      cancelaItem := TfrmCancelarItem.Create(Self);
      try
        cancelaItem.Show;
      finally
        cancelaItem.Free;
      end;
    end;
  end;

  //F4 - finaliza cupom
  if key = 115 then
  begin
    if edtValorRecebido.Text <= '0' then
    begin
      ShowMessage('Valor recebido deve ser maior que 0');
      edtValorRecebido.SetFocus;
      Exit;
    end;

    if MessageDlg('Deseja Fechar a Venda?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      SalvarVenda;
      salvarItens;
    end;
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
  //limparFoto;
  limpar;
//  dm.tbVendas.Active := True;
//  dm.tbDetalhesVendas.Active := True;
  //edtQtdade.Text := '1';

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
  //caminhoNFCE := ExtractFilePath(Application.ExeName) + 'nfe\';
  //nfce.Configuracoes.Arquivos.PathSchemas := caminhoNFCE;
end;

procedure TfrmVendas.limpar;
begin
  edtTotalItem.Text := '0';
  edtSubTotal.Text := '0';
  edtDesconto.Text := '0';
  edtTotalVenda.Text := '0';
  edtValorRecebido.Text := '0';
  edtTroco.Text := '0';
  edtCodBarras.SetFocus;
end;

procedure TfrmVendas.limparFoto;
begin
  FCaminhoimg := ExtractFileDir(GetCurrentDir) + '\Debug\img\sem-foto.jpg';
  //imgProduto.Picture.LoadFromFile(FCaminhoimg);
end;

procedure TfrmVendas.limparProdutos;
begin
  edtCodBarras.Clear;
  edtValorRecebido.Text := '0';
  edtCodBarras.SetFocus;
  //limparFoto;
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
  dm.queryDetalhesVendas.ParamByName('id_funcionario').AsInteger := FCdUsuario;
  dm.queryDetalhesVendas.Open();

  //alinhamneto do grid
  dbGridItens.Columns[0].Alignment := taCenter;
  dbGridItens.Columns[1].Alignment := taCenter;
  dbGridItens.Columns[2].Alignment := taCenter;
end;

procedure TfrmVendas.salvarItens;
begin
  ValidaEstoque;

//  AssociarCamposDetalhes;
//  listar;

  FRegras.Dados.cdsDetalhesVendas.LoopSimples(
  procedure
  begin
    FRegras.SalvarDetalhesVendas;
  end
  );

  //toca audio após inserir um item
  MediaPlayer1.FileName := ExtractFileDir(GetCurrentDir) + '\Debug\img\barCode.wav';
  MediaPlayer1.Open;
  MediaPlayer1.Play;

  //diminui do estoque a qtdade do item

  FQtEstoque := FRegras.Dados.cdsProdutos.FieldByName('qt_estoque').AsFloat - FRegras.Dados.cdsDetalhesVendas.FieldByName('qt_venda').AsFloat;
  FRegras.AtualizaEstoque(FQtEstoque, FRegras.Dados.cdsDetalhesVendas.FieldByName('id_item').AsInteger);
//  atualizaQtdadeEstoque;

  edtCodBarras.Clear;
  edtCodBarras.SetFocus;
  edtQtdade.Text := '1';
end;

procedure TfrmVendas.SalvarVenda;
begin
  AssociarCamposVendas;

  Regras.SalvarVenda;

  //lançar o valor da venda nas movimentações
  Financeiro.InserirMovimentacoes('E', 'V', FTotalComDesconto, FCdUsuario, FRegras.IDVenda, 0);

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
//  listar;
  //FRegras.Dados.cdsDetalhesVendas.EmptyDataSet;
end;

procedure TfrmVendas.SetFinanceiro(const Value: TFinanceiro);
begin
  FFinanceiro := Value;
end;

procedure TfrmVendas.SetRegras(const Value: TVenda);
begin
  FRegras := Value;
end;

procedure TfrmVendas.ValidaEstoque;
begin
  if FRegras.Dados.cdsProdutos.FieldByName('qt_estoque').AsFloat < StrToFloat(edtQtdade.Text) then
  begin
    ShowMessage('Quantidade Indisponível em estoque!');
    edtCodBarras.SetFocus;
    Exit;
  end;
end;

end.
