unit Fornecedores;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons, Vcl.ExtCtrls, System.UITypes, FireDAC.Stan.Param;

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
    DBGrid1: TDBGrid;
    edtNum: TEdit;
    edtBairro: TEdit;
    edtCidade: TEdit;
    edtUf: TEdit;
    edtCEP: TMaskEdit;
    edtRgIe: TEdit;
    edttipoProduto: TEdit;
    Label13: TLabel;
    rgTpPessoa: TRadioGroup;
    procedure btnNovoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure rgTpPessoaClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure btnExcluirClick(Sender: TObject);
    procedure edtBuscarNomeChange(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }

    procedure limpar;
    procedure habilitarCampos;
    procedure desabilitarCampos;
    procedure associarCampos;
    procedure listar;
    procedure buscarNome;

    procedure validaCampos;
    procedure pFormataCampos;
  public
    { Public declarations }
  end;

var
  frmFornecedor: TfrmFornecedor;
  id : String;

implementation

{$R *.dfm}

uses Modulo, uValidaDcto;

{ TfrmFornecedor }

procedure TfrmFornecedor.associarCampos;
begin
  case rgTpPessoa.ItemIndex of
  0:
  begin
    dm.tbFornecedor.FieldByName('tp_pessoa').AsString := 'F';
  end;
  1:
  dm.tbFornecedor.FieldByName('tp_pessoa').AsString := 'J';
  end;
  dm.tbFornecedor.FieldByName('nm_fornecedor').AsString := edtNome.Text;
  dm.tbFornecedor.FieldByName('cpf_cnpj').AsString := edtCpfCnpj.Text;
  dm.tbFornecedor.FieldByName('rg_ie').AsString := edtRgIe.Text;
  dm.tbFornecedor.FieldByName('telefone').AsString := edtTelefone.Text;
  dm.tbFornecedor.FieldByName('logradouro').AsString := edtLogradouro.Text;
  dm.tbFornecedor.FieldByName('numero').AsInteger := StrToInt(edtNum.Text);
  dm.tbFornecedor.FieldByName('bairro').AsString := edtBairro.Text;
  dm.tbFornecedor.FieldByName('cidade').AsString := edtCidade.Text;
  dm.tbFornecedor.FieldByName('uf').AsString := edtUf.Text;
  dm.tbFornecedor.FieldByName('cep').AsString := edtCEP.Text;
  dm.tbFornecedor.FieldByName('tipo_produto').AsString := edttipoProduto.Text;
  dm.tbFornecedor.FieldByName('data_cadastro').AsString := DateToStr(Date);
end;

procedure TfrmFornecedor.btnEditarClick(Sender: TObject);
begin
  associarCampos;
  dm.queryFornecedor.Close;
  dm.queryFornecedor.SQL.Clear;
  dm.queryFornecedor.SQL.Add('update '+
                                    'fornecedor set '+
                                    'nm_fornecedor = :nm_fornecedor, '+
                                    'cpf_cnpj = :cpf_cnpj, '+
                                    'rg_ie = :rg_ie, '+
                                    'telefone = :telefone, '+
                                    'logradouro = :logradouro, '+
                                    'numero = :numero, '+
                                    'bairro = :bairro,'+
                                    'cidade = :cidade, '+
                                    'uf = :uf, '+
                                    'cep = :cep, '+
                                    'tipo_produto = :tipo_produto, '+
                                    'tp_pessoa = :tp_pessoa '+
                              'where id_fornecedor = :id_fornecedor');
  dm.queryFornecedor.ParamByName('nm_fornecedor').AsString := edtNome.Text;
  dm.queryFornecedor.ParamByName('cpf_cnpj').AsString := edtCpfCnpj.Text;
  dm.queryFornecedor.ParamByName('rg_ie').AsString := edtRgIe.Text;
  dm.queryFornecedor.ParamByName('telefone').AsString := edtTelefone.Text;
  dm.queryFornecedor.ParamByName('logradouro').AsString := edtLogradouro.Text;
  dm.queryFornecedor.ParamByName('numero').AsInteger := StrToInt(edtNum.Text);
  dm.queryFornecedor.ParamByName('bairro').AsString := edtBairro.Text;
  dm.queryFornecedor.ParamByName('cidade').AsString := edtCidade.Text;
  dm.queryFornecedor.ParamByName('uf').AsString := edtUf.Text;
  dm.queryFornecedor.ParamByName('cep').AsString := edtCEP.Text;
  dm.queryFornecedor.ParamByName('tipo_produto').AsString := edttipoProduto.Text;
  case rgTpPessoa.ItemIndex of
  0:
  begin
    dm.queryFornecedor.ParamByName('tp_pessoa').AsString := 'F';
  end;
  1:
  dm.queryFornecedor.ParamByName('tp_pessoa').AsString := 'J';
  end;
  dm.queryFornecedor.ParamByName('id_fornecedor').Value := id;
  dm.queryFornecedor.ExecSQL;

  listar;
  MessageDlg('Editado com Sucesso', mtInformation, mbOKCancel, 0);

  btnEditar.Enabled := false;
  btnExcluir.Enabled := false;
  limpar;
  desabilitarCampos;
end;

procedure TfrmFornecedor.btnExcluirClick(Sender: TObject);
begin
  if MessageDlg('Deseja Excluir o registro?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    dm.tbFornecedor.Delete;
    MessageDlg('Excluido com Sucesso', mtInformation, mbOKCancel, 0);

    btnEditar.Enabled := false;
    btnExcluir.Enabled := false;
    limpar;
    listar;
  end;
end;

procedure TfrmFornecedor.btnNovoClick(Sender: TObject);
begin
  habilitarCampos;
  rgTpPessoa.ItemIndex := 0;
  pFormataCampos;
  dm.tbFornecedor.Insert;
  btnSalvar.Enabled := True;
  edtNome.SetFocus;
end;

procedure TfrmFornecedor.btnSalvarClick(Sender: TObject);
begin
  validaCampos;

  associarCampos;
  dm.tbFornecedor.Post;
  MessageDlg('Salvo com Sucesso', mtInformation, mbOKCancel, 0);
  limpar;
  desabilitarCampos;
  btnSalvar.Enabled := false;
  listar;
end;


procedure TfrmFornecedor.buscarNome;
begin
  dm.queryFornecedor.Close;
  dm.queryFornecedor.SQL.Clear;
  dm.queryFornecedor.SQL.Add('select * '+
                                  'from '+
                              'fornecedor '+
                                  'where '+
                              'nm_fornecedor like '+ QuotedStr('%'+edtBuscarNome.Text + '%'));
  dm.queryFornecedor.Open();
end;

procedure TfrmFornecedor.DBGrid1CellClick(Column: TColumn);
begin
  habilitarCampos;
  btnEditar.Enabled := True;
  btnExcluir.Enabled := True;

  dm.tbFornecedor.Edit;

  if dm.queryFornecedor.FieldByName('tp_pessoa').Text = 'F' then
    begin
      rgTpPessoa.ItemIndex := 0;
    end
  else
    begin
      rgTpPessoa.ItemIndex := 1;
    end;

  if dm.queryFornecedor.FieldByName('nm_fornecedor').Text <> null then
    edtNome.Text := dm.queryFornecedor.FieldByName('nm_fornecedor').AsString;

  edtCpfCnpj.Text := dm.queryFornecedor.FieldByName('cpf_cnpj').AsString;
  edtRgIe.Text := dm.queryFornecedor.FieldByName('rg_ie').AsString;

  if dm.queryFornecedor.FieldByName('telefone').AsString <> null then
    edtTelefone.Text := dm.queryFornecedor.FieldByName('telefone').AsString;

  edtLogradouro.Text := dm.queryFornecedor.FieldByName('logradouro').AsString;
  edtNum.Text := dm.queryFornecedor.FieldByName('numero').Text;
  edtBairro.Text := dm.queryFornecedor.FieldByName('bairro').AsString;
  edtCidade.Text := dm.queryFornecedor.FieldByName('cidade').AsString;
  edtUf.Text := dm.queryFornecedor.FieldByName('uf').AsString;

  if dm.queryFornecedor.FieldByName('cep').AsString <> null then
    edtCEP.Text := dm.queryFornecedor.FieldByName('cep').AsString;

  edttipoProduto.Text := dm.queryFornecedor.FieldByName('tipo_produto').AsString;

  id := dm.queryFornecedor.FieldByName('id_fornecedor').AsString;
end;

procedure TfrmFornecedor.desabilitarCampos;
begin
  edtNome.Enabled := false;
  edtLogradouro.Enabled := false;
  edtCpfCnpj.Enabled := false;
  edtTelefone.Enabled := false;
  edtNum.Enabled := false;
  edtBairro.Enabled := false;
  edtCidade.Enabled := false;
  edtUf.Enabled := false;
  edtCEP.Enabled := false;
  edtRgIe.Enabled := false;
  edttipoProduto.Enabled := false;
end;

procedure TfrmFornecedor.edtBuscarNomeChange(Sender: TObject);
begin
  buscarNome;
end;

procedure TfrmFornecedor.FormCreate(Sender: TObject);
begin
  desabilitarCampos;
  dm.tbFornecedor.Active := True;
  listar;
end;

procedure TfrmFornecedor.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    begin
      Key := #0;
      Perform(WM_NEXTDLGCTL,0,0)
    end;
end;

procedure TfrmFornecedor.habilitarCampos;
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

procedure TfrmFornecedor.limpar;
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
end;

procedure TfrmFornecedor.listar;
begin
  dm.queryFornecedor.Close;
  dm.queryFornecedor.SQL.Clear;
  dm.queryFornecedor.SQL.Add('select * from fornecedor order by nm_fornecedor asc');
  dm.queryFornecedor.Open();
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

procedure TfrmFornecedor.validaCampos;
begin
  if (Trim(edtNome.Text) = '') and (Trim(edtCpfCnpj.Text) = '') and (Trim(edtRgIe.Text) = '') and
  (Trim(edtLogradouro.Text) = '') and (Trim(edtNum.Text) = '') and (Trim(edtBairro.Text) = '') and
  (Trim(edtCidade.Text) = '') and (Trim(edtUf.Text) = '') then
  begin
    MessageDlg('Os campos não podem ser vazios', mtInformation, mbOKCancel, 0);
    edtNome.SetFocus;
    exit;
  end;
end;

end.
