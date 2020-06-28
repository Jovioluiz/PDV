unit SaidaProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.Buttons, Vcl.ComCtrls, Vcl.StdCtrls, System.UITypes, FireDAC.Stan.Param;

type
  TfrmSaidaProdutos = class(TForm)
    Label7: TLabel;
    edtIdSaida: TEdit;
    Label1: TLabel;
    edtDataBuscar: TDateTimePicker;
    Label2: TLabel;
    edtProduto: TEdit;
    btnBuscarProduto: TSpeedButton;
    Label3: TLabel;
    edtQuantidade: TEdit;
    edtUnMedida: TEdit;
    Label6: TLabel;
    DBGrid1: TDBGrid;
    btnNovo: TSpeedButton;
    btnSalvar: TSpeedButton;
    btnExcluir: TSpeedButton;
    Label4: TLabel;
    cbMotivoSaida: TComboBox;
    procedure btnNovoClick(Sender: TObject);
    procedure btnBuscarProdutoClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtDataBuscarChange(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
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
  frmSaidaProdutos: TfrmSaidaProdutos;
  qt_estoque : Double;
  idrodutoEst : String;
  idProdutoEstoque : String;

implementation

{$R *.dfm}

uses Modulo, Produtos;

{ TfrmSaidaProdutos }

procedure TfrmSaidaProdutos.associarCampos;
begin
  dm.tbSaidaProdutos.Insert;
  dm.tbSaidaProdutos.FieldByName('id_produto').AsString := idproduto;
  dm.tbSaidaProdutos.FieldByName('qtdade').AsString := edtQuantidade.Text;
  dm.tbSaidaProdutos.FieldByName('motivo').AsString := cbMotivoSaida.Text;
  dm.tbSaidaProdutos.FieldByName('data_saida').AsDateTime := Date;
  dm.tbSaidaProdutos.FieldByName('un_saida').AsString := edtUnMedida.Text;
end;

procedure TfrmSaidaProdutos.btnBuscarProdutoClick(Sender: TObject);
begin
  chamada := 'Prod';
  frmProdutos := TfrmProdutos.Create(Self);
  frmProdutos.Show;
end;

procedure TfrmSaidaProdutos.btnExcluirClick(Sender: TObject);
begin
if MessageDlg('Deseja Excluir o registro?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    try
      dm.fd.StartTransaction;
      dm.queryCoringa.Close;
      dm.queryCoringa.SQL.Text := 'delete from saidas_produtos where id_saida = :id_saida';
      dm.queryCoringa.ParamByName('id_saida').AsInteger := StrToInt(edtIdSaida.Text);
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

      qt_estoque := estoqueProduto + StrToFloat(edtQuantidade.Text);
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

procedure TfrmSaidaProdutos.btnNovoClick(Sender: TObject);
begin
  habilitarCampos;
  limpar;
  dm.tbSaidaProdutos.Insert;
  btnSalvar.Enabled := True;
  edtProduto.SetFocus;
end;

procedure TfrmSaidaProdutos.btnSalvarClick(Sender: TObject);
begin
  validaCampos;
  try
    associarCampos;
    dm.fd.StartTransaction;
    dm.tbSaidaProdutos.Post;

    //atualiza o estoque do produto
    qt_estoque := estoqueProduto - StrToFloat(edtQuantidade.Text);

    dm.queryProdutos.Close;
    dm.queryProdutos.SQL.Clear;
    dm.queryProdutos.SQL.Add('update '+
                                  'produtos set qtd_estoque = :qtd_estoque '+
                             'where '+
                                  'id_produto = :id_produto');
    dm.queryProdutos.ParamByName('qtd_estoque').Value := qt_estoque;
    dm.queryProdutos.ParamByName('id_produto').Value := idproduto;
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
      ShowMessage('Erro ao Gravar os dados ' + E.Message);
      dm.fd.Rollback;
      Exit;
    end;
  end;
end;

procedure TfrmSaidaProdutos.buscarData;
begin
  dm.querySaidaProdutos.Close;
  dm.querySaidaProdutos.SQL.Clear;
  dm.querySaidaProdutos.SQL.Add('select '+
                                  '   * '+
                                  'from '+
                                  '   saidas_produtos '+
                                  'where data_saida = :data_saida '+
                                  '   order by data_saida desc');
  dm.querySaidaProdutos.ParamByName('data_saida').AsDate := edtDataBuscar.Date;
  dm.querySaidaProdutos.Open();
end;

procedure TfrmSaidaProdutos.DBGrid1CellClick(Column: TColumn);
begin
  edtProduto.Enabled := true;
  edtQuantidade.Enabled := true;
  edtUnMedida.Enabled := true;
  cbMotivoSaida.Enabled := true;
  btnExcluir.Enabled := True;
  edtProduto.Text := dm.querySaidaProdutos.FieldByName('id_produto').Value;
  edtQuantidade.Text := dm.querySaidaProdutos.FieldByName('qtdade').Value;
  edtUnMedida.Text := dm.querySaidaProdutos.FieldByName('un_saida').Value;
  edtIdSaida.Text := dm.querySaidaProdutos.FieldByName('id_saida').Value;
  cbMotivoSaida.Text := dm.querySaidaProdutos.FieldByName('motivo').Value;
  id := dm.querySaidaProdutos.FieldByName('id_saida').Value;
  idProdutoEstoque := dm.querySaidaProdutos.FieldByName('id_produto').Value;

end;

procedure TfrmSaidaProdutos.desabilitarCampos;
begin
  edtQuantidade.Enabled := false;
  edtProduto.Enabled := false;
  edtUnMedida.Enabled := false;
  btnBuscarProduto.Enabled := false;
  cbMotivoSaida.Enabled := false;
end;

procedure TfrmSaidaProdutos.edtDataBuscarChange(Sender: TObject);
begin
  buscarData;
end;

procedure TfrmSaidaProdutos.FormActivate(Sender: TObject);
begin
  edtProduto.Text := nomeProduto;
  edtUnMedida.Text := unMedida;
end;

procedure TfrmSaidaProdutos.FormCreate(Sender: TObject);
begin
  desabilitarCampos;
  dm.tbSaidaProdutos.Active := True;
  //listar;
  edtDataBuscar.Date := Date;
  buscarData;
end;

procedure TfrmSaidaProdutos.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    begin
      Key := #0;
      Perform(WM_NEXTDLGCTL, 0, 0);
    end;
end;

procedure TfrmSaidaProdutos.habilitarCampos;
begin
  edtQuantidade.Enabled := true;
  edtProduto.Enabled := true;
  edtUnMedida.Enabled := true;
  btnBuscarProduto.Enabled := true;
  cbMotivoSaida.Enabled := true;
end;

procedure TfrmSaidaProdutos.limpar;
begin
  edtQuantidade.Clear;
  edtProduto.Clear;
  edtUnMedida.Clear;
  cbMotivoSaida.ItemHeight := 0;
  idproduto := '';
  idFornecedor := '';
  nomeProduto := '';
end;

procedure TfrmSaidaProdutos.listar;
begin
  dm.querySaidaProdutos.Close;
  dm.querySaidaProdutos.SQL.Clear;
  dm.querySaidaProdutos.SQL.Add('select '+
                                  '   * '+
                                  'from '+
                                  '   saidas_produtos '+
                                  'order by data_saida desc');
  dm.querySaidaProdutos.Open();
end;

procedure TfrmSaidaProdutos.validaCampos;
begin
  if Trim(edtProduto.Text) = '' then
  begin
    MessageDlg('Escolha um produto!', mtInformation, mbOKCancel,0);
   Abort;
  end;

  if Trim(edtQuantidade.Text) = '' then
  begin
    MessageDlg('Digite uma quantidade!', mtInformation, mbOKCancel,0);
    Abort;
  end;

  if (Trim(edtUnMedida.Text) = '') then
  begin
    MessageDlg('Informe a unidade de medida do produto!', mtInformation, mbOKCancel,0);
    Abort;
  end;

  if cbMotivoSaida.ItemIndex = 0 then
  begin
    MessageDlg('Selecione um Motivo!', mtConfirmation, mbOKCancel, 0);
    Abort;
  end;

end;

end.
