unit Cargos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Buttons, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, System.UITypes, Modulo, FireDAC.Stan.Param;

type
  TFrmCargos = class(TForm)
    Label2: TLabel;
    edtNomeCargo: TEdit;
    gridCargos: TDBGrid;
    btnSalvar: TSpeedButton;
    btnNovo: TSpeedButton;
    btnEditar: TSpeedButton;
    btnExcluir: TSpeedButton;
    procedure btnNovoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure gridCargosCellClick(Column: TColumn);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    procedure associarCampos;
    procedure listar;
  public
    { Public declarations }
  end;

var
  FrmCargos: TFrmCargos;
  id: String;

implementation

{$R *.dfm}

procedure TFrmCargos.associarCampos;
begin
  dm.tbCargos.FieldByName('nm_cargo').Text := edtNomeCargo.Text;
end;

procedure TFrmCargos.btnEditarClick(Sender: TObject);
var
  cargo: String;
begin
  if Trim(edtNomeCargo.Text) = '' then
  begin
    MessageDlg('Preencha o Cargo!', mtInformation, mbOKCancel, 0);
    edtNomeCargo.SetFocus;
    exit;
  end;

  // verifica se o cargo já está cadastrado
  dm.queryCargos.Close;
  dm.queryCargos.SQL.Clear;
  dm.queryCargos.SQL.Add('select * from cargos where nm_cargo = ' +
    QuotedStr(Trim(edtNomeCargo.Text)));
  dm.queryCargos.Open();

  if not dm.queryCargos.IsEmpty then
  begin
    cargo := dm.queryCargos['nm_cargo'];
    MessageDlg('O Cargo ' + cargo + ' já está cadastrado!', mtInformation,
      mbOKCancel, 0);
    edtNomeCargo.Clear;
    edtNomeCargo.SetFocus;
    exit;
  end;

  associarCampos;
  dm.queryCargos.Close;
  dm.queryCargos.SQL.Clear;
  dm.queryCargos.SQL.Add('update cargos set nm_cargo = :nm_cargo where id_cargo = :id_cargo');
  dm.queryCargos.ParamByName('nm_cargo').Text := edtNomeCargo.Text;
  dm.queryCargos.ParamByName('id_cargo').Text := id;
  dm.queryCargos.ExecSQL;

  listar;
  MessageDlg('Editado com Sucesso', mtInformation, mbOKCancel, 0);

  btnEditar.Enabled := false;
  btnExcluir.Enabled := false;
  edtNomeCargo.Clear;
end;

//não tá deletando corretamente
procedure TFrmCargos.btnExcluirClick(Sender: TObject);
begin
  if MessageDlg('Deseja Excluir o registro?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    dm.tbCargos.Delete;
    MessageDlg('Excluido com Sucesso', mtInformation, mbOKCancel, 0);

    listar;
    btnEditar.Enabled := false;
    btnExcluir.Enabled := false;
    edtNomeCargo.Clear;
  end;
end;

procedure TFrmCargos.btnNovoClick(Sender: TObject);
begin
  btnSalvar.Enabled := True;
  edtNomeCargo.Enabled := True;
  edtNomeCargo.Clear;
  edtNomeCargo.SetFocus;
  dm.tbCargos.Insert; // modo de inserção
end;

procedure TFrmCargos.btnSalvarClick(Sender: TObject);
var
  cargo: String;
begin
  if Trim(edtNomeCargo.Text) = '' then
  begin
    MessageDlg('Preencha o Cargo!', mtInformation, mbOKCancel, 0);
    edtNomeCargo.SetFocus;
    exit;
  end;

  // verifica se o cargo já está cadastrado
  dm.queryCargos.Close;
  dm.queryCargos.SQL.Clear;
  dm.queryCargos.SQL.Add('select * from cargos where nm_cargo = ' + QuotedStr(Trim(edtNomeCargo.Text)));
  dm.queryCargos.Open();

  if not dm.queryCargos.IsEmpty then
  begin
    cargo := dm.queryCargos['nm_cargo'];
    MessageDlg('O Cargo ' + cargo + ' já está cadastrado!', mtInformation,
      mbOKCancel, 0);
    edtNomeCargo.Clear;
    edtNomeCargo.SetFocus;
    exit;
  end;

  associarCampos;
  dm.tbCargos.Post;
  MessageDlg('Salvo com Sucesso', mtInformation, mbOKCancel, 0);
  edtNomeCargo.Clear;
  edtNomeCargo.Enabled := false;
  btnSalvar.Enabled := false;
  listar;
end;

procedure TFrmCargos.FormCreate(Sender: TObject);
begin
  dm.tbCargos.Active := True;
  listar;
end;

procedure TFrmCargos.gridCargosCellClick(Column: TColumn);
begin
  edtNomeCargo.Enabled := True;
  btnEditar.Enabled := True;
  btnExcluir.Enabled := True;

  dm.tbCargos.Edit; // modo de edição

  if dm.queryCargos.FieldByName('nm_cargo').Text <> null then
    edtNomeCargo.Text := dm.queryCargos.FieldByName('nm_cargo').Text;

  id := dm.queryCargos.FieldByName('id_cargo').Text;

end;

procedure TFrmCargos.listar;
begin
  dm.queryCargos.Close;
  dm.queryCargos.SQL.Clear;
  dm.queryCargos.SQL.Add('select * from cargos order by nm_cargo asc');
  dm.queryCargos.Open();
end;

end.
