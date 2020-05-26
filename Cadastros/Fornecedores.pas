unit Fornecedores;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons, Vcl.ExtCtrls;

type
  TfrmFornecedor = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
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
    Label12: TLabel;
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
  private
    { Private declarations }

    procedure limpar;
    procedure habilitarCampos;
    procedure desabilitarCampos;
    procedure associarCampos;
    procedure listar;
    procedure buscarNome;
    procedure buscarCpf;
  public
    { Public declarations }
  end;

var
  frmFornecedor: TfrmFornecedor;

implementation

{$R *.dfm}

uses Modulo;

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

procedure TfrmFornecedor.buscarCpf;
begin

end;

procedure TfrmFornecedor.buscarNome;
begin
  dm.queryFornecedor.Close;
  dm.queryFornecedor.SQL.Clear;
  dm.queryFornecedor.SQL.Add('select * '+
                                  'from '+
                              'fornecedor '+
                                  'where '+
                              'nm_fornecedor like :nm_fornecedor '+
                                  'order by '+
                              'nm_fornecedor asc');
  dm.queryFornecedor.ParamByName('nm_fornecedor').AsString := edtBuscarNome.Text + '%';
  dm.queryFornecedor.Open();
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
end;

procedure TfrmFornecedor.limpar;
begin

end;

procedure TfrmFornecedor.listar;
begin
  dm.queryFuncionario.Close;
  dm.queryFuncionario.SQL.Clear;
  dm.queryFuncionario.SQL.Add('select * from funcionarios order by nm_funcionario asc');
  dm.queryFuncionario.Open();
end;

end.
