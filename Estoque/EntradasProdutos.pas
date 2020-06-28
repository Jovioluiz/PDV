unit EntradasProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls, System.UITypes, FireDAC.Stan.Param;

type
  TfrmEntradaProdutos = class(TForm)
    Label2: TLabel;
    btnNovo: TSpeedButton;
    btnSalvar: TSpeedButton;
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
    Label7: TLabel;
    edtIdEntrada: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnBuscarProdutoClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnBuscarFornecedorClick(Sender: TObject);
    procedure edtQuantidadeChange(Sender: TObject);
    procedure edtValorChange(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure btnExcluirClick(Sender: TObject);
    procedure edtDataBuscarChange(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
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
  qt_estoque : Double;
  id : String;
  idProdutoEstoque : String;

implementation

{$R *.dfm}

uses Modulo, Produtos, Fornecedores;

procedure TfrmEntradaProdutos.associarCampos;
begin
  dm.tbEntradaProdutos.Insert;
  dm.tbEntradaProdutos.FieldByName('id_produto').AsString := idproduto;
  dm.tbEntradaProdutos.FieldByName('qtdade').AsString := edtQuantidade.Text;
  dm.tbEntradaProdutos.FieldByName('id_fornecedor').AsString := idFornecedor;
  dm.tbEntradaProdutos.FieldByName('valor').AsString := edtValor.Text;
  dm.tbEntradaProdutos.FieldByName('total').AsCurrency := total;
  dm.tbEntradaProdutos.FieldByName('data_entrada').AsString := DateToStr(Date);
  dm.tbEntradaProdutos.FieldByName('un_compra').AsString := edtUnMedida.Text;
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

procedure TfrmEntradaProdutos.btnExcluirClick(Sender: TObject);
begin
  if MessageDlg('Deseja Excluir o registro?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    try
      dm.fd.StartTransaction;
      dm.queryCoringa.Close;
      dm.queryCoringa.SQL.Text := 'delete from entrada_produtos where id_entrada = :id_entrada';
      dm.queryCoringa.ParamByName('id_entrada').AsInteger := StrToInt(edtIdEntrada.Text);
      btnExcluir.Enabled := false;

      //recupera qtdade estoque

      dm.queryProdutos.Close;
      dm.queryProdutos.SQL.Clear;
      dm.queryProdutos.SQL.Add('select * from produtos where id_produto = :id_produto');
      dm.queryProdutos.ParamByName('id_produto').Value := idProdutoEstoque;
      dm.queryProdutos.Open();


      if not dm.queryProdutos.IsEmpty then
      begin
        estoqueProduto := dm.queryProdutos['qtd_estoque'];
      end;

      //atualiza estoque produto

      qt_estoque := estoqueProduto - StrToFloat(edtQuantidade.Text);
      dm.queryProdutos.Close;
      dm.queryProdutos.SQL.Clear;
      dm.queryProdutos.SQL.Add('update '+
                                'produtos set qtd_estoque = :qtd_estoque '+
                                    'where '+
                                'id_produto = :id_produto');
      dm.queryProdutos.ParamByName('qtd_estoque').Value := qt_estoque;
      dm.queryProdutos.ParamByName('id_produto').Value := idProdutoEstoque;

      dm.queryCoringa.ExecSQL;
      MessageDlg('Excluido com Sucesso', mtInformation, mbOKCancel, 0);
      dm.queryProdutos.ExecSQL;
      dm.fd.Commit;
    except
      on E:exception do
      begin
        ShowMessage('Erro ao excluir os dados '+ E.Message);
        dm.fd.Rollback;
        Exit;
      end;
    end;

  end;
  listar;
end;

procedure TfrmEntradaProdutos.btnNovoClick(Sender: TObject);
begin
  habilitarCampos;
  limpar;
  dm.tbEntradaProdutos.Insert;
  btnSalvar.Enabled := True;
  edtProduto.SetFocus;
end;

procedure TfrmEntradaProdutos.btnSalvarClick(Sender: TObject);
begin

  validaCampos;

  try
    associarCampos;
    dm.fd.StartTransaction;
    dm.tbEntradaProdutos.Post;

    //atualiza o estoque do produto
    qt_estoque := estoqueProduto + StrToFloat(edtQuantidade.Text);

    dm.queryProdutos.Close;
    dm.queryProdutos.SQL.Clear;
    dm.queryProdutos.SQL.Add('update '+
                                  'produtos set qtd_estoque = :qtd_estoque, '+
                                  'data_ult_compra = :data_ult_compra '+
                             'where '+
                                  'id_produto = :id_produto');
    dm.queryProdutos.ParamByName('qtd_estoque').Value := qt_estoque;
    dm.queryProdutos.ParamByName('id_produto').Value := idproduto;
    dm.queryProdutos.ParamByName('data_ult_compra').Value := Date;
    dm.queryProdutos.ExecSQL;

    dm.fd.Commit;
    MessageDlg('Salvo com Sucesso', mtInformation, mbOKCancel, 0);
    limpar;
    desabilitarCampos;
    btnSalvar.Enabled := false;
    listar;
  except
    on E:exception do
    begin
      ShowMessage('Erro ao Salvar os dados ' + E.Message);
      dm.fd.Rollback;
      Exit;
    end;
  end;

end;

procedure TfrmEntradaProdutos.buscarData;
begin
  dm.queryEntradaProdutos.Close;
  dm.queryEntradaProdutos.SQL.Clear;
  dm.queryEntradaProdutos.SQL.Add('select '+
                                  '   ep.id_entrada, '+
                                  '   ep.id_produto, '+
                                  '   p.nm_produto, '+
                                  '   ep.qtdade, '+
                                  '   ep.id_fornecedor, '+
                                  '   ep.valor, '+
                                  '   ep.total, '+
                                  '   ep.data_entrada, '+
                                  '   ep.un_compra, '+
                                  '   f.nm_fornecedor, '+
                                  '   f.telefone '+
                                  'from '+
                                  '   entrada_produtos ep '+
                                  'inner join fornecedor f on '+
                                  '   ep.id_fornecedor = f.id_fornecedor '+
                                  'join produtos p on '+
                                  '   ep.id_produto = p.id_produto '+
                                  'where data_entrada = :data '+
                                  '   order by data_entrada desc');
  dm.queryEntradaProdutos.ParamByName('data').AsDate := edtDataBuscar.Date;
  dm.queryEntradaProdutos.Open();
end;

procedure TfrmEntradaProdutos.DBGrid1CellClick(Column: TColumn);
begin
  edtQuantidade.Enabled := true;
  edtValor.Enabled := true;
  edtUnMedida.Enabled := true;
  lblTotal.Visible := true;
  edtIdEntrada.Enabled := False;
  btnExcluir.Enabled := True;
  edtProduto.Text := dm.queryEntradaProdutos.FieldByName('id_produto').Value;
  edtFornecedor.Text := dm.queryEntradaProdutos.FieldByName('id_fornecedor').Value;
  edtValor.Text := dm.queryEntradaProdutos.FieldByName('valor').Value;
  edtQuantidade.Text := dm.queryEntradaProdutos.FieldByName('qtdade').Value;
  edtUnMedida.Text := dm.queryEntradaProdutos.FieldByName('un_compra').Value;
  edtIdEntrada.Text := dm.queryEntradaProdutos.FieldByName('id_entrada').Text;
  id := dm.queryEntradaProdutos.FieldByName('id_entrada').Value;
  idProdutoEstoque := dm.queryEntradaProdutos.FieldByName('id_produto').Value;
  total := dm.queryEntradaProdutos.FieldByName('total').Value;
  lblTotal.Caption := FormatFloat('R$ #,,,,0.00', dm.queryEntradaProdutos.FieldByName('total').Value);
end;

procedure TfrmEntradaProdutos.desabilitarCampos;
begin
  edtQuantidade.Enabled := false;
  edtValor.Enabled := false;
  edtUnMedida.Enabled := false;
  btnBuscarProduto.Enabled := false;
  btnBuscarFornecedor.Enabled := false;
end;

procedure TfrmEntradaProdutos.edtDataBuscarChange(Sender: TObject);
begin
  buscarData;
end;

procedure TfrmEntradaProdutos.edtQuantidadeChange(Sender: TObject);
begin
  if edtQuantidade.Text <> '' then
  begin
    total := StrToFloat(edtQuantidade.Text) * StrToFloat(edtValor.Text);
    lblTotal.Caption := FloatToStr(total);
  end;
end;

procedure TfrmEntradaProdutos.edtValorChange(Sender: TObject);
begin
  if edtValor.Text <> '' then
  begin
    total := StrToFloat(edtQuantidade.Text) * StrToFloat(edtValor.Text);
    lblTotal.Caption := FormatFloat('R$ #,,,,0.00', total);
  end;
end;

procedure TfrmEntradaProdutos.FormActivate(Sender: TObject);
begin
  edtProduto.Text := nomeProduto;
  edtUnMedida.Text := unMedida;
  edtFornecedor.Text := nomeFornecedor;
end;

procedure TfrmEntradaProdutos.FormCreate(Sender: TObject);
begin
  if chamada = 'Ent' then
  begin
    habilitarCampos;
    dm.tbEntradaProdutos.Active := True;
    dm.tbEntradaProdutos.Insert;
    btnSalvar.Enabled := True;
  end
  else
  begin
   desabilitarCampos;
   dm.tbEntradaProdutos.Active := True;
  end;

  //listar;
  edtDataBuscar.Date := Date;
  buscarData;
end;

procedure TfrmEntradaProdutos.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    begin
      Key := #0;
      Perform(WM_NEXTDLGCTL, 0, 0);
    end;
end;

procedure TfrmEntradaProdutos.habilitarCampos;
begin
  edtQuantidade.Enabled := true;
  edtValor.Enabled := true;
  edtUnMedida.Enabled := true;
  btnBuscarProduto.Enabled := true;
  btnBuscarFornecedor.Enabled := true;
  lblTotal.Visible := true;
  edtIdEntrada.Enabled := False;
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
  qt_estoque := 0;
  idproduto := '';
  idFornecedor := '';
  nomeProduto := '';
end;

procedure TfrmEntradaProdutos.listar;
begin
  dm.queryEntradaProdutos.Close;
  dm.queryEntradaProdutos.SQL.Clear;
  dm.queryEntradaProdutos.SQL.Add('select '+
                                  '   ep.id_entrada, '+
                                  '   ep.id_produto, '+
                                  '   p.nm_produto, '+
                                  '   ep.qtdade, '+
                                  '   ep.id_fornecedor, '+
                                  '   ep.valor, '+
                                  '   ep.total, '+
                                  '   ep.data_entrada, '+
                                  '   ep.un_compra, '+
                                  '   f.nm_fornecedor, '+
                                  '   f.telefone '+
                                  'from '+
                                  '   entrada_produtos ep '+
                                  'inner join fornecedor f on '+
                                  '   ep.id_fornecedor = f.id_fornecedor '+
                                  'join produtos p on '+
                                  '   ep.id_produto = p.id_produto '+
                                  'order by data_entrada desc');
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

  if (Trim(edtValor.Text) <= '0') or (Trim(edtValor.Text) = '') then
  begin
    MessageDlg('Valor do Produto deve ser maior que zero!', mtInformation, mbOKCancel,0);
    edtValor.SetFocus;
    Exit;
  end;

end;

end.
