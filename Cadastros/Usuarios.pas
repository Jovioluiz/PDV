unit Usuarios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Modulo, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.Buttons, Vcl.StdCtrls, Funcionarios, System.UITypes, FireDAC.Stan.Param;

type
  TFrmUsuarios = class(TForm)
    Label2: TLabel;
    edtNome: TEdit;
    btnNovo: TSpeedButton;
    btnSalvar: TSpeedButton;
    btnEditar: TSpeedButton;
    btnExcluir: TSpeedButton;
    Label1: TLabel;
    edtBuscarNome: TEdit;
    DBGrid1: TDBGrid;
    btnBuscar: TSpeedButton;
    Label3: TLabel;
    edtUsuario: TEdit;
    Label4: TLabel;
    edtSenha: TEdit;
    procedure btnBuscarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure edtBuscarNomeChange(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    procedure limpar;
    procedure habilitarCampos;
    procedure desabilitarCampos;
    procedure associarCampos;
    procedure buscarNome;
    procedure listar;
  public
    { Public declarations }
  end;

var
  FrmUsuarios: TFrmUsuarios;
  usuarioAntigo : String;

implementation

{$R *.dfm}

procedure TFrmUsuarios.associarCampos;
begin
 dm.tbUsuarios.FieldByName('nome').AsString := edtNome.Text;
 dm.tbUsuarios.FieldByName('usuario').AsString := edtUsuario.Text;
 dm.tbUsuarios.FieldByName('senha').AsString := edtSenha.Text;
 dm.tbUsuarios.FieldByName('cargo').AsString := cargoFuncionario;
 dm.tbUsuarios.FieldByName('id_funcionario').AsString := idFuncionario;
end;

procedure TFrmUsuarios.btnBuscarClick(Sender: TObject);
begin
  chamada := 'Func';
  FrmFuncionarios := TFrmFuncionarios.Create(Self);
  FrmFuncionarios.Show;
end;

procedure TFrmUsuarios.btnEditarClick(Sender: TObject);
var usuario : String;
begin
  if Trim(edtNome.Text) = '' then
  begin
    MessageDlg('Preencha o Nome!', mtInformation, mbOKCancel,0);
    edtNome.SetFocus;
    exit;
  end;

  if Trim(edtUsuario.Text) = '' then
  begin
    MessageDlg('Preencha o Usuário!', mtInformation, mbOKCancel,0);
    edtUsuario.SetFocus;
    exit;
  end;

    if Trim(edtSenha.Text) = '' then
  begin
    MessageDlg('Preencha a Senha!', mtInformation, mbOKCancel,0);
    edtSenha.SetFocus;
    exit;
  end;


  if usuarioAntigo <> edtUsuario.Text then
  begin
    //verifica se o usário já esta cadastrado
    dm.queryUsuarios.Close;
    dm.queryUsuarios.SQL.Clear;
    dm.queryUsuarios.SQL.Add('select * from usuarios where usuario = ' + QuotedStr(Trim(edtUsuario.Text)));
    dm.queryUsuarios.Open();

    if not dm.queryUsuarios.IsEmpty then
    begin
      usuario := dm.queryUsuarios['usuario'];
      MessageDlg('O Usuário ' + usuario + ' já está cadastrado!', mtInformation, mbOKCancel, 0);
      edtUsuario.Clear;
      edtUsuario.SetFocus;
      Exit;
    end;
  end;

  associarCampos;
  dm.queryUsuarios.Close;
  dm.queryUsuarios.SQL.Clear;
  dm.queryUsuarios.SQL.Add('update '+
                                    'usuarios set '+
                                    'nome = :nome, '+
                                    'usuario = :usuario, '+
                                    'senha = :senha '+
                              'where id_usuario = :id_usuario');
  dm.queryUsuarios.ParamByName('nome').AsString := edtNome.Text;
  dm.queryUsuarios.ParamByName('usuario').AsString := edtUsuario.Text;
  dm.queryUsuarios.ParamByName('senha').AsString := edtSenha.Text;
  dm.queryUsuarios.ParamByName('id_usuario').Value := id;
  dm.queryUsuarios.ExecSQL;

  listar;
  MessageDlg('Editado com Sucesso', mtInformation, mbOKCancel, 0);

  btnEditar.Enabled := false;
  btnExcluir.Enabled := false;
  limpar;
  desabilitarCampos;

end;

procedure TFrmUsuarios.btnExcluirClick(Sender: TObject);
begin
  if MessageDlg('Deseja Excluir o registro?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    dm.tbUsuarios.Delete;
    MessageDlg('Excluido com Sucesso', mtInformation, mbOKCancel, 0);

    listar;
    btnEditar.Enabled := false;
    btnExcluir.Enabled := false;
    limpar;
  end;
end;

procedure TFrmUsuarios.btnNovoClick(Sender: TObject);
begin
  habilitarCampos;
  dm.tbUsuarios.Insert;
  btnSalvar.Enabled := True;
end;

procedure TFrmUsuarios.btnSalvarClick(Sender: TObject);
var usuario : String;
begin
  if Trim(edtNome.Text) = '' then
  begin
    MessageDlg('Preencha o Nome!', mtInformation, mbOKCancel,0);
    edtNome.SetFocus;
    exit;
  end;

  if Trim(edtUsuario.Text) = '' then
  begin
    MessageDlg('Preencha o Usuário!', mtInformation, mbOKCancel,0);
    edtUsuario.SetFocus;
    exit;
  end;

    if Trim(edtSenha.Text) = '' then
  begin
    MessageDlg('Preencha a Senha!', mtInformation, mbOKCancel,0);
    edtSenha.SetFocus;
    exit;
  end;


  //verifica se o usário já esta cadastrado
  dm.queryUsuarios.Close;
  dm.queryUsuarios.SQL.Clear;
  dm.queryUsuarios.SQL.Add('select * from usuarios where usuario = ' + QuotedStr(Trim(edtUsuario.Text)));
  dm.queryUsuarios.Open();

  if not dm.queryUsuarios.IsEmpty then
  begin
    usuario := dm.queryUsuarios['usuario'];
    MessageDlg('O Usuário ' + usuario + ' já está cadastrado!', mtInformation, mbOKCancel, 0);
    edtUsuario.Clear;
    edtUsuario.SetFocus;
    Exit;
  end;
    associarCampos;
    dm.tbUsuarios.Post;
    MessageDlg('Salvo com Sucesso', mtInformation, mbOKCancel, 0);
    limpar;
    desabilitarCampos;
    btnSalvar.Enabled := false;
    listar;
end;

procedure TFrmUsuarios.buscarNome;
begin
  dm.queryUsuarios.Close;
  dm.queryUsuarios.SQL.Clear;
  dm.queryUsuarios.SQL.Add('select * '+
                                  'from '+
                            'usuarios '+
                                  'where '+
                            'cargo <> :cargo and '+
                            'nome like '+QuotedStr('%'+edtBuscarNome.Text +'%'));
  dm.queryUsuarios.ParamByName('cargo').AsString := 'Admin';
  dm.queryUsuarios.Open();
end;


procedure TFrmUsuarios.DBGrid1CellClick(Column: TColumn);
begin
  habilitarCampos;
  btnEditar.Enabled := True;
  btnExcluir.Enabled := True;
  dm.tbUsuarios.Edit;
  edtNome.Text := dm.queryUsuarios.FieldByName('nome').AsString;
  edtUsuario.Text := dm.queryUsuarios.FieldByName('nome').AsString;
  edtSenha.Text := dm.queryUsuarios.FieldByName('senha').AsString;
  id := dm.queryUsuarios.FieldByName('id_usuario').AsString;
  usuarioAntigo := dm.queryUsuarios.FieldByName('usuario').AsString;
end;

procedure TFrmUsuarios.desabilitarCampos;
begin
  edtNome.Enabled := false;
  edtUsuario.Enabled := false;
  edtSenha.Enabled := false;
  btnBuscar.Enabled := false;
end;

procedure TFrmUsuarios.edtBuscarNomeChange(Sender: TObject);
begin
  buscarNome;
end;

procedure TFrmUsuarios.FormActivate(Sender: TObject);
begin
edtNome.Text := nomeFuncionario;
end;

procedure TFrmUsuarios.FormShow(Sender: TObject);
begin
  desabilitarCampos;
  dm.tbUsuarios.Active := True;
  listar;
end;

procedure TFrmUsuarios.habilitarCampos;
begin
  btnBuscar.Enabled := true;
  edtUsuario.Enabled := true;
  edtSenha.Enabled := true;
end;

procedure TFrmUsuarios.limpar;
begin
  edtNome.Clear;
  edtUsuario.Clear;
  edtSenha.Clear;
end;

procedure TFrmUsuarios.listar;
begin
  dm.queryUsuarios.Close;
  dm.queryUsuarios.SQL.Clear;
  dm.queryUsuarios.SQL.Add('select * from usuarios where cargo <> :cargo order by nome asc');
  dm.queryUsuarios.ParamByName('cargo').AsString := 'Admin';
  dm.queryUsuarios.Open();
end;

end.
