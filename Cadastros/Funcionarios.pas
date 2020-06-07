unit Funcionarios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Data.DB,
  Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, System.UITypes, Modulo,
  FireDAC.Stan.Param, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

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
    DBGrid1: TDBGrid;
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
    edtIdFuncionario: TEdit;
    procedure btnNovoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure edtBuscarNomeChange(Sender: TObject);
    procedure edtBuscarCpfChange(Sender: TObject);
    procedure rbNomeClick(Sender: TObject);
    procedure rbCpfClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure edtCEPExit(Sender: TObject);
  private
    { Private declarations }

    procedure limpar;
    procedure habilitarCampos;
    procedure desabilitarCampos;

    procedure carregarComboBox;
    procedure associarCampos;


    procedure listar;
    procedure buscarNome;
    procedure buscarCpf;

    procedure validaCampos;
  public
    { Public declarations }
  end;

var
  FrmFuncionarios: TFrmFuncionarios;
  id : String;
  cpfAntigo : String;

implementation

{$R *.dfm}

{ TFrmFuncionarios }

procedure TFrmFuncionarios.associarCampos;
begin

 dm.tbFuncionario.FieldByName('nm_funcionario').AsString := edtNome.Text;
 dm.tbFuncionario.FieldByName('cpf').AsString := edtCpf.Text;
 dm.tbFuncionario.FieldByName('rg').AsString := edtRg.Text;
 dm.tbFuncionario.FieldByName('telefone').AsString := edtTelefone.Text;
 dm.tbFuncionario.FieldByName('logradouro').AsString := edtLogradouro.Text;
 dm.tbFuncionario.FieldByName('numero').AsInteger := StrToInt(edtNum.Text);
 dm.tbFuncionario.FieldByName('bairro').AsString := edtBairro.Text;
 dm.tbFuncionario.FieldByName('cidade').AsString := edtCidade.Text;
 dm.tbFuncionario.FieldByName('uf').AsString := edtUf.Text;
 dm.tbFuncionario.FieldByName('cep').AsString := edtCEP.Text;
 dm.tbFuncionario.FieldByName('cargo').AsString := cbCargo.Text;
 dm.tbFuncionario.FieldByName('data_cadastro').AsString := DateToStr(Date);
end;

procedure TFrmFuncionarios.btnEditarClick(Sender: TObject);
var
  cpf : String;
begin
validaCampos;

if cpfAntigo <> edtCpf.Text then
begin
  dm.queryFuncionario.Close;
  dm.queryFuncionario.SQL.Clear;
  dm.queryFuncionario.SQL.Add('select * from funcionarios where cpf = ' + QuotedStr(Trim(edtCpf.Text)));
  dm.queryFuncionario.Open();

  //verifica se o cpf já está cadastrado
if not dm.queryFuncionario.IsEmpty then
begin
  cpf := dm.queryFuncionario['cpf'];
  MessageDlg('O CPF ' + cpf + ' já está cadastrado!', mtInformation, mbOKCancel, 0);
  edtCpf.Clear;
  edtCpf.SetFocus;
  Exit;
end;
end;


  associarCampos;
  dm.queryFuncionario.Close;
  dm.queryFuncionario.SQL.Clear;
  dm.queryFuncionario.SQL.Add('update '+
                                    'funcionarios set '+
                                    'nm_funcionario = :nm_funcionario, '+
                                    'cpf = :cpf, '+
                                    'rg = :rg, '+
                                    'telefone = :telefone, '+
                                    'logradouro = :logradouro, '+
                                    'numero = :numero, '+
                                    'bairro = :bairro,'+
                                    'cidade = :cidade, '+
                                    'uf = :uf, '+
                                    'cep = :cep, '+
                                    'cargo = :cargo '+
                              'where id_funcionario = :id_funcionario');
  dm.queryFuncionario.ParamByName('nm_funcionario').AsString := edtNome.Text;
  dm.queryFuncionario.ParamByName('cpf').AsString := edtCpf.Text;
  dm.queryFuncionario.ParamByName('rg').AsString := edtRg.Text;
  dm.queryFuncionario.ParamByName('telefone').AsString := edtTelefone.Text;
  dm.queryFuncionario.ParamByName('logradouro').AsString := edtLogradouro.Text;
  dm.queryFuncionario.ParamByName('numero').AsInteger := StrToInt(edtNum.Text);
  dm.queryFuncionario.ParamByName('bairro').AsString := edtBairro.Text;
  dm.queryFuncionario.ParamByName('cidade').AsString := edtCidade.Text;
  dm.queryFuncionario.ParamByName('uf').AsString := edtUf.Text;
  dm.queryFuncionario.ParamByName('cep').AsString := edtCEP.Text;
  dm.queryFuncionario.ParamByName('cargo').AsString := cbCargo.Text;
  dm.queryFuncionario.ParamByName('id_funcionario').Value := id;
  dm.queryFuncionario.ExecSQL;

  //editar cargo usuario

  dm.queryUsuarios.Close;
  dm.queryUsuarios.SQL.Clear;
  dm.queryUsuarios.SQL.Add('update '+
                                    'usuarios set '+
                                    'cargo = :cargo '+
                              'where id_funcionario = :id_funcionario');
  dm.queryUsuarios.ParamByName('cargo').AsString := cbCargo.Text;
  dm.queryUsuarios.ParamByName('id_funcionario').Value := id;
  dm.queryUsuarios.ExecSQL;

  listar;
  MessageDlg('Editado com Sucesso', mtInformation, mbOKCancel, 0);

  btnEditar.Enabled := false;
  btnExcluir.Enabled := false;
  limpar;
  desabilitarCampos;

end;

procedure TFrmFuncionarios.btnExcluirClick(Sender: TObject);
begin
  if MessageDlg('Deseja Excluir o registro?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    dm.queryCoringa.Close;
    dm.queryCoringa.SQL.Text := 'delete from funcionarios where id_funcionario = :id_funcionario';
    dm.queryCoringa.ParamByName('id_funcionario').AsInteger := StrToInt(edtIdFuncionario.Text);
    dm.queryCoringa.ExecSQL;
    MessageDlg('Excluido com Sucesso', mtInformation, mbOKCancel, 0);

    listar;
    btnEditar.Enabled := false;
    btnExcluir.Enabled := false;
    limpar;
  end;

  //deletar também usuário associado

  dm.queryUsuarios.Close;
  dm.queryUsuarios.SQL.Clear;
  dm.queryUsuarios.SQL.Add('delete from usuarios where id_funcionario = :id_funcionario');
  dm.queryUsuarios.ParamByName('id_funcionario').Value := id;
  dm.queryUsuarios.Execute;

  listar;
end;

procedure TFrmFuncionarios.btnNovoClick(Sender: TObject);
begin
  habilitarCampos;
  dm.tbFuncionario.Insert;
  btnSalvar.Enabled := True;
  edtNome.SetFocus;
end;

procedure TFrmFuncionarios.btnSalvarClick(Sender: TObject);
var
  cpf : String;
begin
validaCampos;

//verifica se o cpf já está cadastrado

dm.queryFuncionario.Close;
dm.queryFuncionario.SQL.Clear;
dm.queryFuncionario.SQL.Add('select * from funcionarios where cpf = ' + QuotedStr(Trim(edtCpf.Text)));
dm.queryFuncionario.Open();

if not dm.queryFuncionario.IsEmpty then
begin
  cpf := dm.queryFuncionario['cpf'];
  MessageDlg('O CPF ' + cpf + ' já está cadastrado!', mtInformation, mbOKCancel, 0);
  edtCpf.Clear;
  edtCpf.SetFocus;
  Exit;
end;
  associarCampos;
  dm.tbFuncionario.Post;
  MessageDlg('Salvo com Sucesso', mtInformation, mbOKCancel, 0);
  limpar;
  desabilitarCampos;
  btnSalvar.Enabled := false;
  listar;
end;

procedure TFrmFuncionarios.buscarCpf;
begin
  dm.queryFuncionario.Close;
  dm.queryFuncionario.SQL.Clear;
  dm.queryFuncionario.SQL.Add('select * '+
                                  'from '+
                              'funcionarios '+
                                  'where '+
                              'cpf = :cpf '+
                                  'order by '+
                              'nm_funcionario asc');
  dm.queryFuncionario.ParamByName('cpf').AsString := edtBuscarCpf.Text;
  dm.queryFuncionario.Open();
end;

procedure TFrmFuncionarios.buscarNome;
begin
  dm.queryFuncionario.Close;
  dm.queryFuncionario.SQL.Clear;
  dm.queryFuncionario.SQL.Add('select * '+
                                  'from '+
                              'funcionarios '+
                                  'where '+
                              'nm_funcionario like ' + QuotedStr('%'+edtBuscarNome.Text +'%'));
  dm.queryFuncionario.Open();
end;

procedure TFrmFuncionarios.carregarComboBox;
begin
dm.queryCargos.Open();
if not dm.queryCargos.IsEmpty then
begin
  while not dm.queryCargos.Eof do
    begin
      cbCargo.Items.Add(dm.queryCargos.FieldByName('nm_cargo').AsString);
      dm.queryCargos.Next;
    end;
end;
dm.queryCargos.Close;
end;

procedure TFrmFuncionarios.DBGrid1CellClick(Column: TColumn);
begin
  habilitarCampos;
  btnEditar.Enabled := True;
  btnExcluir.Enabled := True;

  dm.tbFuncionario.Edit;

  if dm.queryFuncionario.FieldByName('nm_funcionario').Text <> null then
    edtNome.Text := dm.queryFuncionario.FieldByName('nm_funcionario').AsString;

  edtCpf.Text := dm.queryFuncionario.FieldByName('cpf').AsString;
  edtRg.Text := dm.queryFuncionario.FieldByName('rg').AsString;

  if dm.queryFuncionario.FieldByName('telefone').AsString <> null then
    edtTelefone.Text := dm.queryFuncionario.FieldByName('telefone').AsString;

  edtLogradouro.Text := dm.queryFuncionario.FieldByName('logradouro').AsString;
  edtNum.Text := dm.queryFuncionario.FieldByName('numero').Text;
  edtBairro.Text := dm.queryFuncionario.FieldByName('bairro').AsString;
  edtCidade.Text := dm.queryFuncionario.FieldByName('cidade').AsString;
  edtUf.Text := dm.queryFuncionario.FieldByName('uf').AsString;
  cbCargo.Text := dm.queryFuncionario.FieldByName('cargo').AsString;

  if dm.queryFuncionario.FieldByName('cep').AsString <> null then
    edtCEP.Text := dm.queryFuncionario.FieldByName('cep').AsString;

  edtIdFuncionario.Text := dm.queryFuncionario.FieldByName('id_funcionario').Text;
  id := dm.queryFuncionario.FieldByName('id_funcionario').AsString;

  cpfAntigo := dm.queryFuncionario.FieldByName('cpf').AsString;
end;

procedure TFrmFuncionarios.DBGrid1DblClick(Sender: TObject);
begin
if chamada = 'Func' then
begin
  idFuncionario := dm.queryFuncionario.FieldByName('id_funcionario').AsString;
  nomeFuncionario := dm.queryFuncionario.FieldByName('nm_funcionario').AsString;
  cargoFuncionario := dm.queryFuncionario.FieldByName('cargo').AsString;
  Close;
  chamada := '';
end;

end;

procedure TFrmFuncionarios.desabilitarCampos;
begin
  edtNome.Enabled := false;
  edtLogradouro.Enabled := false;
  edtCpf.Enabled := false;
  edtTelefone.Enabled := false;
  edtNum.Enabled := false;
  edtBairro.Enabled := false;
  edtCidade.Enabled := false;
  edtUf.Enabled := false;
  edtCEP.Enabled := false;
  edtRg.Enabled := false;
  cbCargo.Enabled := false;
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
  sqlEndereco.Close;
  sqlEndereco.SQL.Text := 'select distinct  '+
                          '    e.endereco_logradouro, '+
                          '    b.bairro_descricao, '+
                          '    c.nm_cidade, '+
                          '    es.uf '+
                          'from '+
                          '    endereco e '+
                          'join bairro b on '+
                          '    e.bairro_codigo = b.bairro_codigo '+
                          'join cidade c on '+
                          '    b.cidade_codigo = c.cd_cidade '+
                          'join estado es on '+
                          '    c.uf = es.uf '+
                          'where '+
                          '    e.endereco_cep = :cep ';
  sqlEndereco.ParamByName('cep').AsString := edtCEP.Text;
  sqlEndereco.Open();

  if not sqlEndereco.IsEmpty then
  begin
    edtLogradouro.Text := sqlEndereco.FieldByName('endereco_logradouro').AsString;
    edtBairro.Text := sqlEndereco.FieldByName('bairro_descricao').AsString;
    edtCidade.Text := sqlEndereco.FieldByName('nm_cidade').AsString;
    edtUf.Text := sqlEndereco.FieldByName('uf').AsString;
  end
  else
  begin
    ShowMessage('CEP não encontrado!');  //só mostra aviso que não foi encontrado
    Exit;
  end;

end;

procedure TFrmFuncionarios.FormCreate(Sender: TObject);
begin
  desabilitarCampos;
  dm.tbFuncionario.Active := True;
  listar;
  carregarComboBox;
  cbCargo.ItemIndex := 0;
  edtBuscarCpf.Visible := false;
  rbNome.Checked := True;
end;

procedure TFrmFuncionarios.habilitarCampos;
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
end;

procedure TFrmFuncionarios.listar;
begin
  dm.queryFuncionario.Close;
  dm.queryFuncionario.SQL.Clear;
  dm.queryFuncionario.SQL.Add('select * from funcionarios order by nm_funcionario asc');
  dm.queryFuncionario.Open();
end;

procedure TFrmFuncionarios.rbCpfClick(Sender: TObject);
begin
  listar;
  edtBuscarCpf.Visible := True;
  edtBuscarNome.Visible := False;
end;

procedure TFrmFuncionarios.rbNomeClick(Sender: TObject);
begin
  listar;
  edtBuscarCpf.Visible := false;
  edtBuscarNome.Visible := True;
end;

procedure TFrmFuncionarios.validaCampos;
begin
  if (Trim(edtNome.Text) = '') and (Trim(edtCpf.Text) = '') and (Trim(edtRg.Text) = '') and
  (Trim(edtLogradouro.Text) = '') and (Trim(edtNum.Text) = '') and (Trim(edtBairro.Text) = '') and
  (Trim(edtCidade.Text) = '') and (Trim(edtUf.Text) = '') then
  begin
    MessageDlg('Os campos não podem ser vazios', mtInformation, mbOKCancel, 0);
    edtNome.SetFocus;
    Abort;
  end;
end;

end.
