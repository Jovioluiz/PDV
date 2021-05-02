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
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    FCaminhoimg: string;
    FTotalItem,
    FTotalVenda,
    FTotalComDesconto,
    FTotalTroco,
    FSubTotal,
    FTotalDesconto,
    FTotalRecebido: Currency;
    FQtEstoque: Double;
    FRegras: TVenda;
    FIDItem: Integer;
    FFinanceiro: TFinanceiro;
    FSeq: Integer;
    procedure limpar;
    procedure buscarProduto;
    procedure SalvarItens(Insere: Boolean);
    procedure SalvarVenda(Insere: Boolean);
    procedure limparFoto;
    procedure limparProdutos;

    procedure AssociarCamposDetalhes;
    procedure AssociarCamposVendas;
    procedure iniciarNfce;
    procedure AtualizaValores;

    procedure ValidaEstoque;
    procedure SetRegras(const Value: TVenda);
    procedure SetFinanceiro(const Value: TFinanceiro);
    procedure SetSeq(const Value: Integer);
  public
    { Public declarations }
    property Regras: TVenda read FRegras write SetRegras;
    property IDItem: Integer read FIDItem write FIDItem;
    property Financeiro: TFinanceiro read FFinanceiro write SetFinanceiro;
    property Seq: Integer read FSeq write SetSeq;
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

  if (FRegras.Dados.cdsDetalhesVendas.RecordCount > 0) and (edtCodBarras.Text = '') then
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
    FTotalItem := StrToFloat(edtQtdade.Text) * FRegras.Dados.cdsProdutos.FieldByName('vl_unitario').AsCurrency;
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

    //toca audio após inserir um item
    MediaPlayer1.FileName := ExtractFileDir(GetCurrentDir) + '\Debug\img\barCode.wav';
    MediaPlayer1.Open;
    MediaPlayer1.Play;

    limparProdutos;

    if FRegras.Dados.cdsDetalhesVendas.RecordCount = 1 then
      SalvarVenda(True)
    else
      SalvarVenda(False);
    SalvarItens(True);
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
var
  id: TUtil;
begin
  id := TUtil.Create;

  try
    FRegras.Dados.cdsDetalhesVendas.Append;
    FRegras.IDDetalhesVenda := id.GeraIdGeral;
    FRegras.Dados.cdsDetalhesVendas.FieldByName('id_geral').AsLargeInt := FRegras.IDDetalhesVenda;
    FRegras.Dados.cdsDetalhesVendas.FieldByName('seq').AsInteger := FSeq;
    FRegras.Dados.cdsDetalhesVendas.FieldByName('id_venda').AsLargeInt := FRegras.IDVenda;
    FRegras.Dados.cdsDetalhesVendas.FieldByName('id_item').AsInteger := FIDItem;
    FRegras.Dados.cdsDetalhesVendas.FieldByName('cd_item').AsString := FRegras.Dados.cdsProdutos.FieldByName('cd_item').AsString;
    FRegras.Dados.cdsDetalhesVendas.FieldByName('nm_produto').AsString := FRegras.Dados.cdsProdutos.FieldByName('nm_produto').AsString;
    FRegras.Dados.cdsDetalhesVendas.FieldByName('vl_unitario').AsCurrency := FRegras.Dados.cdsProdutos.FieldByName('vl_unitario').AsCurrency;;
    FRegras.Dados.cdsDetalhesVendas.FieldByName('qt_venda').AsFloat := StrToFloat(edtQtdade.Text);
    FRegras.Dados.cdsDetalhesVendas.FieldByName('vl_total').AsCurrency := FTotalItem;
    FRegras.Dados.cdsDetalhesVendas.FieldByName('id_funcionario').AsInteger := FCdUsuario;
    FRegras.Dados.cdsDetalhesVendas.FieldByName('fl_cancelado').AsString := 'N';
    FRegras.Dados.cdsDetalhesVendas.Post;
    Inc(FSeq);
  finally
    id.Free;
  end;
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
//  FRegras.Dados.cdsVendas.FieldByName('status').AsString := 'C';
  FRegras.Dados.cdsVendas.Post;
end;

procedure TfrmVendas.AtualizaValores;
begin
  FRegras.Dados.cdsDetalhesVendas.LoopSimples(
    procedure
    begin
      if FRegras.Dados.cdsDetalhesVendas.FieldByName('fl_cancelado').AsString = 'S' then
      begin
        FTotalVenda := FTotalVenda - FRegras.Dados.cdsDetalhesVendas.FieldByName('vl_total').AsCurrency;
        edtTotalVenda.Text := FormatCurr('R$ ###,##0.00', FTotalVenda);
        FTotalComDesconto := FTotalVenda;
      end;
    end
  );
end;

procedure TfrmVendas.buscarProduto;
var
  imagem: TUtil;
begin
  if not Regras.BuscarProdutos(edtCodBarras.Text) then
    Exit;

  imagem := TUtil.Create;

  try
    FIDItem := Regras.Dados.cdsProdutos.FieldByName('id_item').AsInteger;

    imagem.ExibeFoto(Regras.Dados.cdsProdutos, 'imagem', imgProduto);

  finally
    imagem.Free;
  end;
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
  FSeq := 1;
  FRegras.Free;
  FFinanceiro.Free;
end;

procedure TfrmVendas.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  qtdade: Double;
begin
  if FRegras.Dados.cdsDetalhesVendas.RecordCount > 0 then
  begin
    if MessageDlg('Deseja Cancelar a Venda?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      FRegras.CancelaVenda(FRegras.IDVenda);

      FRegras.Dados.cdsDetalhesVendas.LoopSimples(
      procedure
      begin
        //devolve ao estoque a qtdade do item
        qtdade := FRegras.TotalEstoque(FRegras.Dados.cdsDetalhesVendas.FieldByName('id_item').AsInteger) + FRegras.Dados.cdsDetalhesVendas.FieldByName('qt_venda').AsFloat;
        FRegras.AtualizaEstoque(qtdade, FRegras.Dados.cdsDetalhesVendas.FieldByName('id_item').AsInteger);
      end
      );
    end;
  end;
end;

procedure TfrmVendas.FormCreate(Sender: TObject);
begin
  Regras := TVenda.Create;
  FFinanceiro := TFinanceiro.Create;
  dbGridItens.DataSource := Regras.Dados.dsDetalhesVendas;
  FTotalTroco := 0;
  FTotalDesconto := 0;
  FTotalRecebido := 0;
  FSeq := 1;
  edtSubTotal.Text := FormatCurr('R$ ###,##0.00', FTotalVenda);
  edtTotalVenda.Text := FormatCurr('R$ ###,##0.00', FTotalVenda);
  edtTotalItem.Text := FormatCurr('R$ ###,##0.00', FTotalItem);
end;

procedure TfrmVendas.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  cancelaItem: TfrmCancelarItem;
  book: TBookmark;
begin
  //ao pressionar Ctrl + z, abre a tela para cancelar o item
  if (ssCtrl in Shift) then
  begin
    if key = 90 then
    begin
      FRegras.Dados.cdsDetalhesVendas.DisableControls;

      cancelaItem := TfrmCancelarItem.Create(Self);
      try
        cancelaItem.DetalhesVendas := FRegras.Dados.cdsDetalhesVendas;
        if cancelaItem.ShowModal <> mrOK then
        begin
          FRegras.Dados.cdsDetalhesVendas.Filtered := False;
          FRegras.Dados.cdsDetalhesVendas.Filter := 'seq = ' + cancelaItem.Sequencia.ToString;
          book := FRegras.Dados.cdsDetalhesVendas.GetBookmark;
          FRegras.Dados.cdsDetalhesVendas.Filtered := True;
          FRegras.Dados.cdsDetalhesVendas.Edit;
          FRegras.Dados.cdsDetalhesVendas.FieldByName('fl_cancelado').AsString := 'S';
          FRegras.Dados.cdsDetalhesVendas.Post;
        end;
      finally
        if FRegras.Dados.cdsDetalhesVendas.BookmarkValid(book) then
          FRegras.Dados.cdsDetalhesVendas.GotoBookmark(book);
        FRegras.Dados.cdsDetalhesVendas.EnableControls;
        FRegras.Dados.cdsDetalhesVendas.Filtered := False;
        FRegras.Dados.cdsDetalhesVendas.Filter := '';
        FRegras.Dados.cdsDetalhesVendas.Filtered := True;
        FRegras.Dados.cdsDetalhesVendas.FreeBookmark(book);
        cancelaItem.Free;
      end;
      AtualizaValores;
    end;
  end;

  //F4 - finaliza cupom
  if key = 115 then
  begin
    if edtValorRecebido.Text <= '0' then
    begin
      ShowMessage('Valor recebido deve ser maior que R$ 0.00');
      edtValorRecebido.SetFocus;
      Exit;
    end;

    if edtTotalVenda.Text = '0' then
    begin
      ShowMessage('Não foi vendido nenhum item!');
      edtCodBarras.SetFocus;
      Exit;
    end;

    if MessageDlg('Deseja Fechar a Venda?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin

      SalvarVenda(False);
      SalvarItens(False);

      //lançar o valor da venda nas movimentações
      Financeiro.InserirMovimentacoes('E', 'V', FTotalComDesconto, FCdUsuario, FRegras.IDVenda, 0);
      FRegras.Dados.cdsDetalhesVendas.EmptyDataSet;
      limpar;
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

  edtCodBarras.SetFocus;

  FTotalItem := 0;
  FTotalVenda := 0;
  estoqueProduto := 0;
  FTotalComDesconto := 0;
  FTotalTroco := 0;
end;

procedure TfrmVendas.iniciarNfce;
//var
//  caminhoNFCE: string;
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

procedure TfrmVendas.SalvarItens(Insere: Boolean);
begin
  FQtEstoque := 0;

  if not Insere then
  begin
    FRegras.Dados.cdsDetalhesVendas.LoopSimples(
    procedure
    begin
      ValidaEstoque;
      FRegras.SalvarDetalhesVendas(Insere);
      //devolve para o estoque a qtdade do item
      FQtEstoque := 0;

      if FRegras.Dados.cdsDetalhesVendas.FieldByName('fl_cancelado').AsString = 'S' then
      begin
        FQtEstoque := FRegras.TotalEstoque(FRegras.Dados.cdsDetalhesVendas.FieldByName('id_item').AsInteger)
                      + FRegras.Dados.cdsDetalhesVendas.FieldByName('qt_venda').AsFloat;
        FRegras.AtualizaEstoque(FQtEstoque, FRegras.Dados.cdsDetalhesVendas.FieldByName('id_item').AsInteger);
      end;
    end
    );
  end
  else
  begin
    ValidaEstoque;
    FRegras.SalvarDetalhesVendas(Insere);
    //diminui do estoque a qtdade do item
    FQtEstoque := FRegras.TotalEstoque(FRegras.Dados.cdsDetalhesVendas.FieldByName('id_item').AsInteger)
                  - FRegras.Dados.cdsDetalhesVendas.FieldByName('qt_venda').AsFloat;
    if FRegras.Dados.cdsDetalhesVendas.FieldByName('fl_cancelado').AsString = 'N' then
      FRegras.AtualizaEstoque(FQtEstoque, FRegras.Dados.cdsDetalhesVendas.FieldByName('id_item').AsInteger);
  end;

  edtCodBarras.Clear;
  edtCodBarras.SetFocus;
  edtQtdade.Text := '1';
  limparFoto;
  edtQtdade.Text := '1';
  FTotalItem := 0;
//  FTotalVenda := 0;
  FQtEstoque := 0;
//  FTotalComDesconto := 0;
  FTotalTroco := 0;
end;

procedure TfrmVendas.SalvarVenda(Insere: Boolean);
begin
  AssociarCamposVendas;

  Regras.SalvarVenda(Insere);

  //imprimir cupom fiscal
//  iniciarNfce;

  //imprimir cupom não fiscal

  //limpar;
//  limparFoto;
//  edtQtdade.Text := '1';
//  FTotalItem := 0;
//  FTotalVenda := 0;
//  FQtEstoque := 0;
//  FTotalComDesconto := 0;
//  FTotalTroco := 0;
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

procedure TfrmVendas.SetSeq(const Value: Integer);
begin
  FSeq := Value;
end;

procedure TfrmVendas.ValidaEstoque;
begin
  if FRegras.Dados.cdsProdutos.FieldByName('qt_estoque').AsFloat < StrToFloat(edtQtdade.Text) then
  begin
    edtCodBarras.SetFocus;
    raise Exception.Create('Quantidade Indisponível em estoque!');
  end;
end;

end.
