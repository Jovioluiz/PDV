unit Funcionarios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Data.DB,
  Vcl.Buttons, Vcl.Grids, Vcl.DBGrids;

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
    //procedure FormShow(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure btnEditarClick(Sender: TObject);
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

implementation

{$R *.dfm}

uses Modulo;

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
  dm.queryFuncionario.Close;
  dm.queryFuncionario.SQL.Clear;
  dm.queryFuncionario.SQL.Add('update funcionarios set nm_funcionario, cpf, = :nm_cargo where id_cargo = :id_cargo');
  dm.queryFuncionario.ParamByName('nm_cargo').Text := edtNome.Text;
  dm.queryFuncionario.ParamByName('id_cargo').Text := id;
  dm.queryFuncionario.ExecSQL;

  listar;
  MessageDlg('Editado com Sucesso', mtInformation, mbOKCancel, 0);

  btnEditar.Enabled := false;
  btnExcluir.Enabled := false;
  limpar;
  desabilitarCampos;

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

end;

procedure TFrmFuncionarios.buscarNome;
begin

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

  if dm.queryFuncionario.FieldByName('nm_funcionario').Text <> null then
    edtNome.Text := dm.queryCargos.FieldByName('nm_funcionario').Text;

  edtCpf.Text := dm.queryCargos.FieldByName('cpf').Text;
  edtRg.Text := dm.queryCargos.FieldByName('rg').Text;

  if dm.queryFuncionario.FieldByName('telefone').Text <> null then
    edtNome.Text := dm.queryFuncionario.FieldByName('telefone').Text;

  edtLogradouro.Text := dm.queryFuncionario.FieldByName('logradouro').Text;
  edtNum.Text := dm.queryFuncionario.FieldByName('numero').Text;
  edtBairro.Text := dm.queryFuncionario.FieldByName('bairro').Text;
  edtCidade.Text := dm.queryFuncionario.FieldByName('cidade').Text;
  edtUf.Text := dm.queryFuncionario.FieldByName('uf').Text;
  cbCargo.Text := dm.queryFuncionario.FieldByName('cargo').Text;

  if dm.queryFuncionario.FieldByName('cep').Text <> null then
    edtCEP.Text := dm.queryFuncionario.FieldByName('cep').Text;

  id := dm.queryFuncionario.FieldByName('id_funcionario').Text;
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

procedure TFrmFuncionarios.FormCreate(Sender: TObject);
begin
  desabilitarCampos;
  dm.tbFuncionario.Active := True;
  listar;
  carregarComboBox;
  cbCargo.ItemIndex := 0;
end;

{
procedure TFrmFuncionarios.FormShow(Sender: TObject);
begin
  desabilitarCampos;
  dm.tbFuncionario.Active := True;
  carregarComboBox;
end;  }

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

procedure TFrmFuncionarios.validaCampos;
var
  sim : Boolean;
begin
  if (Trim(edtNome.Text) = '') and (Trim(edtCpf.Text) = '') and (Trim(edtRg.Text) = '') and
  (Trim(edtLogradouro.Text) = '') and (Trim(edtNum.Text) = '') and (Trim(edtBairro.Text) = '') and
  (Trim(edtCidade.Text) = '') and (Trim(edtUf.Text) = '') then
  begin
    MessageDlg('Os campos não podem ser vazios', mtInformation, mbOKCancel, 0);
    exit;
  end;
end;

end.
