unit Fornecedores;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons, Vcl.ExtCtrls, System.UITypes, FireDAC.Stan.Param,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.StrUtils, Datasnap.DBClient,
  uclFornecedor;

type
  TfrmFornecedor = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lblCPFCNPJ: TLabel;
    Label5: TLabel;
    btnSalvar: TSpeedButton;
    btnNovo: TSpeedButton;
    btnEditar: TSpeedButton;
    btnExcluir: TSpeedButton;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    lblRGIE: TLabel;
    edtBuscarNome: TEdit;
    edtNome: TEdit;
    edtLogradouro: TEdit;
    edtCpfCnpj: TMaskEdit;
    edtTelefone: TMaskEdit;
    dbGridProduto: TDBGrid;
    edtNum: TEdit;
    edtBairro: TEdit;
    edtCidade: TEdit;
    edtUf: TEdit;
    edtCEP: TMaskEdit;
    edtRgIe: TEdit;
    edttipoProduto: TEdit;
    Label13: TLabel;
    rgTpPessoa: TRadioGroup;
    sqlendereco: TFDQuery;
    Label4: TLabel;
    edtCodFornecedor: TEdit;
    procedure btnNovoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure rgTpPessoaClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure dbGridProdutoCellClick(Column: TColumn);
    procedure btnExcluirClick(Sender: TObject);
    procedure edtBuscarNomeChange(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edtCEPExit(Sender: TObject);
    procedure dbGridProdutoDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FRegras: TFornecedor;
    { Private declarations }

    procedure Limpar;
    procedure HabilitarCampos;
    procedure DesabilitarCampos;
    procedure Listar;
    procedure BuscarNome;

    function ValidaCampos: Boolean;
    procedure pFormataCampos;
  public
    { Public declarations }
    property Regras: TFornecedor read FRegras;
  end;

var
  frmFornecedor: TfrmFornecedor;
  id : String;

implementation

{$R *.dfm}

uses Modulo, uValidaDcto;

{ TfrmFornecedor }

procedure TfrmFornecedor.btnEditarClick(Sender: TObject);
begin
  btnSalvar.Click;
  btnEditar.Enabled := False;
  btnExcluir.Enabled := False;
  Limpar;
  DesabilitarCampos;
  Listar;
end;

procedure TfrmFornecedor.btnExcluirClick(Sender: TObject);
begin
  if MessageDlg('Deseja Excluir o registro?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    FRegras.cd_fornecedor := StrToInt(edtCodFornecedor.Text);
    FRegras.Excluir;
    ShowMessage('Excluído com Sucesso');

    btnEditar.Enabled := False;
    btnExcluir.Enabled := False;
    Limpar;
    Listar;
  end;
end;

procedure TfrmFornecedor.btnNovoClick(Sender: TObject);
begin
  HabilitarCampos;
  rgTpPessoa.ItemIndex := 0;
  pFormataCampos;
  btnSalvar.Enabled := True;
  edtNome.SetFocus;
  edtCodFornecedor.Text := FRegras.GeraCodigoFornecedor.ToString;
end;

procedure TfrmFornecedor.btnSalvarClick(Sender: TObject);
var
  novo: Boolean;
begin
  if not validaCampos then
  begin
    edtNome.SetFocus;
    raise Exception.Create('Os campos não podem ser vazios');
  end;

  novo := FRegras.Pesquisar(StrToInt(edtCodFornecedor.Text));

  FRegras.cd_fornecedor := StrToInt(edtCodFornecedor.Text);
  FRegras.tp_pessoa := ifthen(rgTpPessoa.ItemIndex = 0, 'F', 'J');
  FRegras.nm_fornecedor := edtNome.Text;
  FRegras.cpf_cnpj := edtCpfCnpj.Text;
  FRegras.rg_ie := edtRgIe.Text;
  FRegras.telefone := edtTelefone.Text;
  FRegras.logradouro := edtLogradouro.Text;
  FRegras.numero := edtNum.Text;
  FRegras.bairro := edtBairro.Text;
  FRegras.cidade := edtCidade.Text;
  FRegras.uf := edtUf.Text;
  FRegras.cep := edtCEP.Text;
  FRegras.tipo_produto := edttipoProduto.Text;
  FRegras.data_cadastro := Now;

  FRegras.Persistir(novo);

  ShowMessage('Salvo com Sucesso');
  Limpar;
  DesabilitarCampos;
  btnSalvar.Enabled := False;
  Listar;
end;


procedure TfrmFornecedor.BuscarNome;
begin
  FRegras.Dados.cdsFornecedor.DisableControls;

  try
    FRegras.Dados.cdsFornecedor.Filtered := False;
    FRegras.Dados.cdsFornecedor.Filter := 'Upper(nm_fornecedor) like ' + QuotedStr('%' + edtBuscarNome.Text + '%');
    FRegras.Dados.cdsFornecedor.Filtered := True;

  finally
    FRegras.Dados.cdsFornecedor.EnableControls;
  end;
end;

procedure TfrmFornecedor.dbGridProdutoCellClick(Column: TColumn);
begin
  HabilitarCampos;
  btnEditar.Enabled := True;
  btnExcluir.Enabled := True;

  if FRegras.Dados.cdsFornecedor.FieldByName('tp_pessoa').AsString = 'F' then
    rgTpPessoa.ItemIndex := 0
  else
    rgTpPessoa.ItemIndex := 1;

  if FRegras.Dados.cdsFornecedor.FieldByName('nm_fornecedor').Text <> null then
    edtNome.Text := FRegras.Dados.cdsFornecedor.FieldByName('nm_fornecedor').AsString;

  edtCpfCnpj.Text := FRegras.Dados.cdsFornecedor.FieldByName('cpf_cnpj').AsString;
  edtRgIe.Text := FRegras.Dados.cdsFornecedor.FieldByName('rg_ie').AsString;

  if FRegras.Dados.cdsFornecedor.FieldByName('telefone').AsString <> null then
    edtTelefone.Text := FRegras.Dados.cdsFornecedor.FieldByName('telefone').AsString;

  edtLogradouro.Text := FRegras.Dados.cdsFornecedor.FieldByName('logradouro').AsString;
  edtNum.Text := FRegras.Dados.cdsFornecedor.FieldByName('numero').Text;
  edtBairro.Text := FRegras.Dados.cdsFornecedor.FieldByName('bairro').AsString;
  edtCidade.Text := FRegras.Dados.cdsFornecedor.FieldByName('cidade').AsString;
  edtUf.Text := FRegras.Dados.cdsFornecedor.FieldByName('uf').AsString;

  if FRegras.Dados.cdsFornecedor.FieldByName('cep').AsString <> null then
    edtCEP.Text := FRegras.Dados.cdsFornecedor.FieldByName('cep').AsString;

  edttipoProduto.Text := FRegras.Dados.cdsFornecedor.FieldByName('tipo_produto').AsString;
  edtCodFornecedor.Text := IntToStr(FRegras.Dados.cdsFornecedor.FieldByName('cd_fornecedor').AsInteger);
//  id := FRegras.Dados.cdsFornecedor.FieldByName('id_fornecedor').AsString;
  edtNome.SetFocus;
end;

procedure TfrmFornecedor.dbGridProdutoDblClick(Sender: TObject);
begin
  if chamada = 'Forn' then
  begin
    //idFornecedor := FRegras.Dados.cdsFornecedor.FieldByName('cd_fornecedor').AsInteger;
    nomeFornecedor := FRegras.Dados.cdsFornecedor.FieldByName('nm_fornecedor').AsString;
    Close;
    chamada := '';
  end;
end;

procedure TfrmFornecedor.DesabilitarCampos;
begin
  edtNome.Enabled := False;
  edtLogradouro.Enabled := False;
  edtCpfCnpj.Enabled := False;
  edtTelefone.Enabled := False;
  edtNum.Enabled := False;
  edtBairro.Enabled := False;
  edtCidade.Enabled := False;
  edtUf.Enabled := False;
  edtCEP.Enabled := False;
  edtRgIe.Enabled := False;
  edttipoProduto.Enabled := False;
end;

procedure TfrmFornecedor.edtBuscarNomeChange(Sender: TObject);
begin
  BuscarNome;
end;

procedure TfrmFornecedor.edtCEPExit(Sender: TObject);
begin
//  sqlEndereco.Close;
//  sqlEndereco.SQL.Text := 'select distinct  '+
//                          '    e.endereco_logradouro, '+
//                          '    b.bairro_descricao, '+
//                          '    c.nm_cidade, '+
//                          '    es.uf '+
//                          'from '+
//                          '    endereco e '+
//                          'join bairro b on '+
//                          '    e.bairro_codigo = b.bairro_codigo '+
//                          'join cidade c on '+
//                          '    b.cidade_codigo = c.cd_cidade '+
//                          'join estado es on '+
//                          '    c.uf = es.uf '+
//                          'where '+
//                          '    e.endereco_cep = :cep';
//  sqlEndereco.ParamByName('cep').AsString := edtCEP.Text;
//  sqlEndereco.Open();
//
//  if not sqlEndereco.IsEmpty then
//  begin
//    edtLogradouro.Text := sqlEndereco.FieldByName('endereco_logradouro').AsString;
//    edtBairro.Text := sqlEndereco.FieldByName('bairro_descricao').AsString;
//    edtCidade.Text := sqlEndereco.FieldByName('nm_cidade').AsString;
//    edtUf.Text := sqlEndereco.FieldByName('uf').AsString;
//  end
//  else
//  begin
//    ShowMessage('CEP não encontrado!');  //só mostra aviso que não foi encontrado
//    Exit;
//  end;
end;

procedure TfrmFornecedor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FRegras.Free;
end;

procedure TfrmFornecedor.FormCreate(Sender: TObject);
begin
  FRegras := TFornecedor.Create;
  DesabilitarCampos;
  dbGridProduto.DataSource := FRegras.Dados.dsFornecedor;
  Listar;
end;

procedure TfrmFornecedor.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TfrmFornecedor.HabilitarCampos;
begin
  edtNome.Enabled := True;
  edtLogradouro.Enabled := True;
  edtCpfCnpj.Enabled := True;
  edtTelefone.Enabled := True;
  edtNum.Enabled := True;
  edtBairro.Enabled := True;
  edtCidade.Enabled := True;
  edtUf.Enabled := True;
  edtCEP.Enabled := True;
  edtRgIe.Enabled := True;
  edttipoProduto.Enabled := True;
end;

procedure TfrmFornecedor.Limpar;
begin
  edtNome.Clear;
  edtLogradouro.Clear;
  edtCpfCnpj.Clear;
  edtTelefone.Clear;
  edtNum.Clear;
  edtBairro.Clear;
  edtCidade.Clear;
  edtUf.Clear;
  edtCEP.Clear;
  edtRgIe.Clear;
  edttipoProduto.Clear;
  rgTpPessoa.ItemIndex := -1;
  edtCodFornecedor.Clear;
end;

procedure TfrmFornecedor.Listar;
begin
  FRegras.Listar;
end;

procedure TfrmFornecedor.pFormataCampos;
begin
  if rgTpPessoa.ItemIndex = 0 then
  begin
    lblCPFCNPJ.Caption := 'CPF';
    edtCpfCnpj.Width := 90;
    edtCpfCnpj.EditMask := uValidaDcto.MASCARA_CPF;
    lblRGIE.Caption := 'RG';
  end
  else
  begin
    lblCPFCNPJ.Caption := 'CNPJ';
    edtCpfCnpj.Width := 110;
    edtCpfCnpj.EditMask := uValidaDcto.MASCARA_CNPJ;
    lblRGIE.Caption := 'IE';
  end;
end;

procedure TfrmFornecedor.rgTpPessoaClick(Sender: TObject);
begin
  pFormataCampos;
end;

function TfrmFornecedor.ValidaCampos: Boolean;
begin
  Result := True;

  if (Trim(edtNome.Text) = '') then
    Exit(False);

  if (Trim(edtCpfCnpj.Text) = '') then
    Exit(False);
end;

end.
