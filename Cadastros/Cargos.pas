unit Cargos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Buttons, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, System.UITypes, Modulo, FireDAC.Stan.Param,
  Datasnap.DBClient, dCargos;

type
  TFrmCargos = class(TForm)
    Label2: TLabel;
    edtNomeCargo: TEdit;
    gridCargos: TDBGrid;
    btnSalvar: TSpeedButton;
    btnNovo: TSpeedButton;
    btnEditar: TSpeedButton;
    btnExcluir: TSpeedButton;
    edtCdCargo: TEdit;
    Label1: TLabel;
    procedure btnNovoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure gridCargosCellClick(Column: TColumn);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FCdCargo: Integer;
    FDados: TdmCargos;
    procedure CarregaEdicaoCargo;
    procedure ExcluirCargo;
    procedure Salvar;
    procedure Editar;
    procedure HabilitarDesabilitarBotoes(Habilitar: Boolean);

  public
    { Public declarations }
    procedure listar;
  end;

var
  FrmCargos: TFrmCargos;

implementation

uses
  uclCargo, FireDAC.Comp.Client, uUtil, dmConexao;

{$R *.dfm}

procedure TFrmCargos.btnEditarClick(Sender: TObject);
begin
  Editar;
end;

procedure TFrmCargos.btnExcluirClick(Sender: TObject);
begin
  ExcluirCargo;
end;

procedure TFrmCargos.btnNovoClick(Sender: TObject);
begin
  btnSalvar.Enabled := True;
  edtNomeCargo.Enabled := True;
  edtCdCargo.Enabled := True;
  edtNomeCargo.Clear;
  edtCdCargo.Clear;
  edtCdCargo.SetFocus;
end;

procedure TFrmCargos.btnSalvarClick(Sender: TObject);
begin
  Salvar;
end;

procedure TFrmCargos.FormCreate(Sender: TObject);
begin
  FDados := TdmCargos.Create(nil);
  gridCargos.DataSource := FDados.dsCargos;
  listar;
end;

procedure TFrmCargos.FormDestroy(Sender: TObject);
begin
  FDados.Free;
end;

procedure TFrmCargos.gridCargosCellClick(Column: TColumn);
begin
  CarregaEdicaoCargo;
end;

procedure TFrmCargos.listar;
const
  SQL = 'select cd_cargo, nm_cargo from cargos order by cd_cargo asc';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dConexao.FConexaoBanco;

  try
    FDados.cdsCargos.EmptyDataSet;
    qry.Open(SQL);

    if qry.IsEmpty then
      Exit;

    qry.loopSimples(
    procedure
    begin
      FDados.cdsCargos.Append;
      FDados.cdsCargos.FieldByName('cd_cargo').AsInteger := qry.FieldByName('cd_cargo').AsInteger;
      FDados.cdsCargos.FieldByName('nm_cargo').AsString := qry.FieldByName('nm_cargo').AsString;
      FDados.cdsCargos.Post;
    end
    );
  finally
    qry.Free;
  end;
end;

procedure TFrmCargos.HabilitarDesabilitarBotoes(Habilitar: Boolean);
begin
  btnEditar.Enabled := Habilitar;
  btnExcluir.Enabled := Habilitar;
end;

procedure TFrmCargos.Editar;
var
  persistencia: TCargo;
begin
  if (Trim(edtNomeCargo.Text) = '') or (Trim(edtCdCargo.Text) = '') then
  begin
    edtNomeCargo.SetFocus;
    raise Exception.Create('Preencha o Cargo!');
  end;

  persistencia := TCargo.Create;
  try
    if persistencia.Pesquisar(StrToInt(edtCdCargo.Text)) then
      raise Exception.Create('Cargo não encontrado');
    persistencia.cd_cargo := StrToInt(edtCdCargo.Text);
    persistencia.nm_cargo := edtNomeCargo.Text;
    persistencia.Persistir(False);
    listar;
    MessageDlg('Editado com Sucesso', mtInformation, mbOKCancel, 0);
    HabilitarDesabilitarBotoes(False);
    edtNomeCargo.Clear;
    edtCdCargo.Clear;
  finally
    persistencia.Free;
  end;
end;

procedure TFrmCargos.Salvar;
var
  persistencia: TCargo;
  novo: Boolean;
begin
  if (Trim(edtNomeCargo.Text) = '') or (Trim(edtCdCargo.Text) = '') then
  begin
    edtNomeCargo.SetFocus;
    raise Exception.Create('Preencha o Cargo!');
  end;
  persistencia := TCargo.Create;
  try
    novo := persistencia.Pesquisar(StrToInt(edtCdCargo.Text));
    persistencia.cd_cargo := StrToInt(edtCdCargo.Text);
    persistencia.nm_cargo := edtNomeCargo.Text;
    persistencia.Persistir(novo);
    edtCdCargo.Clear;
    edtCdCargo.SetFocus;
    edtNomeCargo.Clear;
    edtNomeCargo.Enabled := False;
    edtCdCargo.Enabled := False;
    btnSalvar.Enabled := False;
    listar;
  finally
    persistencia.Free;
  end;
end;

procedure TFrmCargos.ExcluirCargo;
var
  persistencia: TCargo;
begin
  persistencia := TCargo.Create;
  try
    if MessageDlg('Deseja Excluir o registro?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      persistencia.cd_cargo := StrToInt(edtCdCargo.Text);
      if persistencia.Excluir then
      begin
        FDados.cdsCargos.Delete;
        MessageDlg('Excluído com Sucesso', mtInformation, mbOKCancel, 0);
        listar;
        HabilitarDesabilitarBotoes(False);
        edtNomeCargo.Clear;
        edtCdCargo.Clear;
      end;
    end;
  finally
    persistencia.Free;
  end;
end;

procedure TFrmCargos.CarregaEdicaoCargo;
begin
  edtNomeCargo.Enabled := True;
  HabilitarDesabilitarBotoes(True);
  if FDados.cdsCargos.RecordCount > 0 then
  begin
    edtNomeCargo.Text := FDados.cdsCargos.FieldByName('nm_cargo').AsString;
    edtCdCargo.Text := IntToStr(FDados.cdsCargos.FieldByName('cd_cargo').AsInteger);
  end;
  FCdCargo := FDados.cdsCargos.FieldByName('cd_cargo').AsInteger;
end;

end.
