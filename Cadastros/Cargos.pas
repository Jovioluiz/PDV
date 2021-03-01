unit Cargos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Buttons, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, System.UITypes, Modulo, FireDAC.Stan.Param,
  Datasnap.DBClient, uConexao;

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
    dsCargos: TDataSource;
    cdsCargos: TClientDataSet;
    cdsCargoscd_cargo: TIntegerField;
    cdsCargosnm_cargo: TStringField;
    procedure btnNovoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure gridCargosCellClick(Column: TColumn);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    FConex: TConexao;
    FCdCargo: Integer;
    { Private declarations }
    procedure associarCampos;
    procedure listar;
    procedure SetConex(const Value: TConexao);
  public
    { Public declarations }
    property Conex: TConexao read FConex write SetConex;
  end;

var
  FrmCargos: TFrmCargos;

implementation

uses
  uclCargo, FireDAC.Comp.Client, uUtil;

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

  // verifica se o cargo j� est� cadastrado
  dm.queryCargos.Close;
  dm.queryCargos.SQL.Clear;
  dm.queryCargos.SQL.Add('select * from cargos where nm_cargo = ' +
    QuotedStr(Trim(edtNomeCargo.Text)));
  dm.queryCargos.Open();

  if not dm.queryCargos.IsEmpty then
  begin
    cargo := dm.queryCargos['nm_cargo'];
    MessageDlg('O Cargo ' + cargo + ' j� est� cadastrado!', mtInformation,
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
  dm.queryCargos.ParamByName('cd_cargo').AsInteger := FCdCargo;
  dm.queryCargos.ExecSQL;

  listar;
  MessageDlg('Editado com Sucesso', mtInformation, mbOKCancel, 0);

  btnEditar.Enabled := false;
  btnExcluir.Enabled := false;
  edtNomeCargo.Clear;
end;

procedure TFrmCargos.btnExcluirClick(Sender: TObject);
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
        cdsCargos.Delete;
        MessageDlg('Exclu�do com Sucesso', mtInformation, mbOKCancel, 0);
        listar;
        btnEditar.Enabled := False;
        btnExcluir.Enabled := False;
        edtNomeCargo.Clear;
        edtCdCargo.Clear;
      end;
    end;
  finally
    persistencia.Free;
  end;
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
var
  persistencia: TCargo;
  novo: Boolean;
begin
  if (Trim(edtNomeCargo.Text) = '') or (Trim(edtCdCargo.Text) = '') then
  begin
    MessageDlg('Preencha o Cargo!', mtInformation, mbOKCancel, 0);
    edtNomeCargo.SetFocus;
    exit;
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

procedure TFrmCargos.FormCreate(Sender: TObject);
begin
  Conex := TConexao.Create;
  listar;
end;

procedure TFrmCargos.gridCargosCellClick(Column: TColumn);
begin
  edtNomeCargo.Enabled := True;
  btnEditar.Enabled := True;
  btnExcluir.Enabled := True;

  if cdsCargos.RecordCount > 0 then
  begin
    edtNomeCargo.Text := cdsCargos.FieldByName('nm_cargo').AsString;
    edtCdCargo.Text := IntToStr(cdsCargos.FieldByName('cd_cargo').AsInteger);
  end;

  FCdCargo := cdsCargos.FieldByName('cd_cargo').AsInteger;

end;

procedure TFrmCargos.listar;
const
  SQL = 'select cd_cargo, nm_cargo from cargos order by cd_cargo asc';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := Conex.getConexao;

  try
    cdsCargos.EmptyDataSet;
    qry.SQL.Add(SQL);
    qry.Open();

    if qry.IsEmpty then
      Exit;

    qry.loopSimples(
    procedure
    begin
      cdsCargos.Append;
      cdsCargos.FieldByName('cd_cargo').AsInteger := qry.FieldByName('cd_cargo').AsInteger;
      cdsCargos.FieldByName('nm_cargo').AsString := qry.FieldByName('nm_cargo').AsString;
      cdsCargos.Post;
    end
    );
  finally
    qry.Free;
  end;
end;

procedure TFrmCargos.SetConex(const Value: TConexao);
begin
  FConex := Value;
end;

end.
