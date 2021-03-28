unit Funcionarios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Data.DB,
  Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, System.UITypes, Modulo,
  FireDAC.Stan.Param, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  uclFuncionario, uUtil;

type
  TFrmFuncionarios = class(TForm)
    edtBuscarNome: TEdit;
    rbNome: TRadioButton;
    rbCpf: TRadioButton;
    edtBuscarCpf: TMaskEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edtNome: TEdit;
    edtLogradouro: TEdit;
    edtCpf: TMaskEdit;
    edtTelefone: TMaskEdit;
    cbCargo: TComboBox;
    dbGridFuncionario: TDBGrid;
    btnSalvar: TSpeedButton;
    btnNovo: TSpeedButton;
    btnEditar: TSpeedButton;
    btnExcluir: TSpeedButton;
    Label7: TLabel;
    edtNum: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    edtBairro: TEdit;
    edtCidade: TEdit;
    Label10: TLabel;
    edtUf: TEdit;
    Label11: TLabel;
    edtCEP: TMaskEdit;
    Label12: TLabel;
    edtRg: TEdit;
    sqlEndereco: TFDQuery;
    Label13: TLabel;
    edtCdFuncionario: TEdit;
    procedure btnNovoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure dbGridFuncionarioCellClick(Column: TColumn);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure edtBuscarNomeChange(Sender: TObject);
    procedure edtBuscarCpfChange(Sender: TObject);
    procedure rbNomeClick(Sender: TObject);
    procedure rbCpfClick(Sender: TObject);
    procedure dbGridFuncionarioDblClick(Sender: TObject);
    procedure edtCEPExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FRegras: TFuncionario;
    { Private declarations }

    procedure limpar;
    procedure HabilitarCampos;
    procedure DesabilitarCampos;

    procedure CarregarComboBox;


    procedure Listar;
    procedure buscarNome;
    procedure buscarCpf;

    function ValidaCampos: Boolean;
  public
    { Public declarations }
    property Regras: TFuncionario read FRegras;
  end;

var
  FrmFuncionarios: TFrmFuncionarios;
  id : String;

implementation

uses
  dmConexao;

{$R *.dfm}

{ TFrmFuncionarios }

procedure TFrmFuncionarios.btnEditarClick(Sender: TObject);
begin
  btnSalvar.Click;
  btnEditar.Enabled := False;
  btnExcluir.Enabled := False;
  limpar;
  DesabilitarCampos;
end;

procedure TFrmFuncionarios.btnExcluirClick(Sender: TObject);
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(Self);
  qry.Connection := dConexao.conexaoBanco;

  try
    if MessageDlg('Deseja Excluir o registro?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      FRegras.cd_funcionario := StrToInt(edtCdFuncionario.Text);
      if FRegras.Excluir then
      begin
        ShowMessage('Excluído com Sucesso');

        Listar;
        btnEditar.Enabled := False;
        btnExcluir.Enabled := False;
        limpar;
        qry.SQL.Add('update usuarios set fl_ativo = False where cd_funcionario = :cd_funcionario');
        qry.ParamByName('cd_funcionario').AsInteger := FRegras.cd_funcionario;
        qry.ExecSQL;
        dConexao.conexaoBanco.Commit;
      end;
    end;

    Listar;
  finally
    qry.Free;
  end;
end;

procedure TFrmFuncionarios.btnNovoClick(Sender: TObject);
begin
  HabilitarCampos;
  edtCdFuncionario.Text := FRegras.GeraCodFuncionario.ToString;
  btnSalvar.Enabled := True;
  edtNome.SetFocus;
end;

procedure TFrmFuncionarios.btnSalvarClick(Sender: TObject);
const
  SQL = 'select cpf from funcionarios where cpf = :cpf';
var
  cpf : String;
  qry: TFDQuery;
  novo: Boolean;
begin
  qry := TFDQuery.Create(Self);
  qry.Connection := dConexao.conexaoBanco;

  if not ValidaCampos then
  begin
    raise Exception.Create('Os campos não podem ser vazios');
    edtNome.SetFocus;
  end;

  try
    //verifica se o cpf já está cadastrado
    qry.SQL.Add(SQL);
    qry.ParamByName('cpf').AsString := edtCpf.Text;
    qry.Open();

    if not qry.IsEmpty then
    begin
      cpf := qry.FieldByName('cpf').AsString;
      MessageDlg('O CPF ' + cpf + ' já está cadastrado!', mtInformation, mbOKCancel, 0);
      edtCpf.Clear;
      edtCpf.SetFocus;
      Exit;
    end;

    novo := FRegras.Pesquisar(StrToInt(edtCdFuncionario.Text));

    FRegras.cd_funcionario := StrToInt(edtCdFuncionario.Text);
    FRegras.cd_cargo := FRegras.GetCodCargo(Trim(cbCargo.Items.Text));
    FRegras.nm_funcionario := edtNome.Text;
    FRegras.cpf := edtCpf.Text;
    FRegras.rg := edtRg.Text;
    FRegras.telefone := edtTelefone.Text;
    FRegras.logradouro := edtLogradouro.Text;
    FRegras.numero := edtNum.Text;
    FRegras.bairro := edtBairro.Text;
    FRegras.cidade := edtCidade.Text;
    FRegras.uf := edtUf.Text;
    FRegras.cep := edtCEP.Text;
    FRegras.data_cadastro := Now;

    FRegras.Persistir(novo);

    ShowMessage('Salvo com Sucesso');
    limpar;
    DesabilitarCampos;
    btnSalvar.Enabled := False;
    Listar;
  finally
    qry.Free;
  end;
end;

procedure TFrmFuncionarios.buscarCpf;
begin
  FRegras.Dados.cdsFuncionario.DisableControls;

  try
    FRegras.Dados.cdsFuncionario.Filtered := False;
    FRegras.Dados.cdsFuncionario.Filter := 'cpf like ' + QuotedStr('%' + edtBuscarCpf.Text + '%');
    FRegras.Dados.cdsFuncionario.Filtered := True;

  finally
    FRegras.Dados.cdsFuncionario.EnableControls;
  end;
end;

procedure TFrmFuncionarios.buscarNome;
begin
  FRegras.Dados.cdsFuncionario.DisableControls;

  try
    FRegras.Dados.cdsFuncionario.Filtered := False;
    FRegras.Dados.cdsFuncionario.Filter := 'Upper(nm_funcionario) like ' + QuotedStr('%' + edtBuscarNome.Text + '%');
    FRegras.Dados.cdsFuncionario.Filtered := True;

  finally
    FRegras.Dados.cdsFuncionario.EnableControls;
  end;
end;

procedure TFrmFuncionarios.CarregarComboBox;
const
  SQL = 'select nm_cargo from cargos';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(Self);
  qry.Connection := dConexao.conexaoBanco;

  try
    qry.SQL.Add(SQL);
    qry.Open();

    qry.LoopSimples(
    procedure
    begin
      cbCargo.Items.Add(qry.FieldByName('nm_cargo').AsString);
    end
    );
  finally
    qry.Free;
  end;
end;

procedure TFrmFuncionarios.dbGridFuncionarioCellClick(Column: TColumn);
begin
  HabilitarCampos;
  btnEditar.Enabled := True;
  btnExcluir.Enabled := True;

  if FRegras.Dados.cdsFuncionario.FieldByName('nm_funcionario').Text <> null then
    edtNome.Text := FRegras.Dados.cdsFuncionario.FieldByName('nm_funcionario').AsString;

  edtCpf.Text := FRegras.Dados.cdsFuncionario.FieldByName('cpf').AsString;
  edtRg.Text := FRegras.Dados.cdsFuncionario.FieldByName('rg').AsString;

  if FRegras.Dados.cdsFuncionario.FieldByName('telefone').AsString <> null then
    edtTelefone.Text := FRegras.Dados.cdsFuncionario.FieldByName('telefone').AsString;

  edtLogradouro.Text := FRegras.Dados.cdsFuncionario.FieldByName('logradouro').AsString;
  edtNum.Text := FRegras.Dados.cdsFuncionario.FieldByName('numero').Text;
  edtBairro.Text := FRegras.Dados.cdsFuncionario.FieldByName('bairro').AsString;
  edtCidade.Text := FRegras.Dados.cdsFuncionario.FieldByName('cidade').AsString;
  edtUf.Text := FRegras.Dados.cdsFuncionario.FieldByName('uf').AsString;
  cbCargo.Text := FRegras.Dados.cdsFuncionario.FieldByName('nm_cargo').AsString;

  if FRegras.Dados.cdsFuncionario.FieldByName('cep').AsString <> null then
    edtCEP.Text := FRegras.Dados.cdsFuncionario.FieldByName('cep').AsString;

  edtCdFuncionario.Text := IntToStr(FRegras.Dados.cdsFuncionario.FieldByName('cd_funcionario').AsInteger);
  //id := FRegras.Dados.cdsFuncionario.FieldByName('cd_funcionario').AsInteger;
end;

procedure TFrmFuncionarios.dbGridFuncionarioDblClick(Sender: TObject);
begin
  if chamada = 'Func' then
  begin
    idFuncionario := FRegras.Dados.cdsFuncionario.FieldByName('id_funcionario').AsString;
    nomeFuncionario := FRegras.Dados.cdsFuncionario.FieldByName('nm_funcionario').AsString;
    cargoFuncionario := FRegras.Dados.cdsFuncionario.FieldByName('nm_cargo').AsString;
    Close;
    chamada := '';
  end;
end;

procedure TFrmFuncionarios.DesabilitarCampos;
begin
  edtNome.Enabled := False;
  edtLogradouro.Enabled := False;
  edtCpf.Enabled := False;
  edtTelefone.Enabled := False;
  edtNum.Enabled := False;
  edtBairro.Enabled := False;
  edtCidade.Enabled := False;
  edtUf.Enabled := False;
  edtCEP.Enabled := False;
  edtRg.Enabled := False;
  cbCargo.Enabled := False;
end;

procedure TFrmFuncionarios.edtBuscarCpfChange(Sender: TObject);
begin
  buscarCpf;
end;

procedure TFrmFuncionarios.edtBuscarNomeChange(Sender: TObject);
begin
  buscarNome;
end;

procedure TFrmFuncionarios.edtCEPExit(Sender: TObject);
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
//                          '    e.endereco_cep = :cep ';
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

procedure TFrmFuncionarios.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FRegras.Free;
end;

procedure TFrmFuncionarios.FormCreate(Sender: TObject);
begin
  FRegras := TFuncionario.Create;
  DesabilitarCampos;
  dbGridFuncionario.DataSource := FRegras.Dados.dsFuncionario;
  Listar;
  CarregarComboBox;
  cbCargo.ItemIndex := 0;
  edtBuscarCpf.Visible := false;
  rbNome.Checked := True;
end;

procedure TFrmFuncionarios.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TFrmFuncionarios.HabilitarCampos;
begin
  edtNome.Enabled := True;
  edtLogradouro.Enabled := True;
  edtCpf.Enabled := True;
  edtTelefone.Enabled := True;
  edtNum.Enabled := True;
  edtBairro.Enabled := True;
  edtCidade.Enabled := True;
  edtUf.Enabled := True;
  edtCEP.Enabled := True;
  edtRg.Enabled := True;
  cbCargo.Enabled := True;
end;

procedure TFrmFuncionarios.limpar;
begin
  edtNome.Clear;
  edtLogradouro.Clear;
  edtCpf.Clear;
  edtTelefone.Clear;
  edtNum.Clear;
  edtBairro.Clear;
  edtCidade.Clear;
  edtUf.Clear;
  edtCEP.Clear;
  edtRg.Clear;
  edtCdFuncionario.Clear;
end;

procedure TFrmFuncionarios.Listar;
begin
  FRegras.Listar;
end;

procedure TFrmFuncionarios.rbCpfClick(Sender: TObject);
begin
  Listar;
  edtBuscarCpf.Visible := True;
  edtBuscarNome.Visible := False;
end;

procedure TFrmFuncionarios.rbNomeClick(Sender: TObject);
begin
  Listar;
  edtBuscarCpf.Visible := False;
  edtBuscarNome.Visible := True;
end;

function TFrmFuncionarios.ValidaCampos: Boolean;
begin
  Result := True;

  if (Trim(edtNome.Text) = '') then
    Exit(False);


  if (Trim(edtCpf.Text) = '') then
    Exit(False);
end;

end.
