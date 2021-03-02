unit Gastos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls, FireDAC.Stan.Param, System.UITypes;

type
  TfrmGastos = class(TForm)
    Label2: TLabel;
    btnSalvar: TSpeedButton;
    btnNovo: TSpeedButton;
    btnExcluir: TSpeedButton;
    edtMotivo: TEdit;
    gridCargos: TDBGrid;
    Label1: TLabel;
    edtValor: TEdit;
    Label3: TLabel;
    edtDataBuscar: TDateTimePicker;
    procedure FormShow(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure gridCargosCellClick(Column: TColumn);
    procedure edtDataBuscarChange(Sender: TObject);
  private
    { Private declarations }
    procedure associarCampos;
    procedure listar;
    procedure buscarData;
  public
    { Public declarations }
  end;

var
  frmGastos: TfrmGastos;
  idGasto : String;

implementation

{$R *.dfm}

uses Modulo;

procedure TfrmGastos.associarCampos;
begin
  dm.tbGastos.FieldByName('motivo').Text := edtMotivo.Text;
  dm.tbGastos.FieldByName('valor').AsCurrency := StrToCurr(edtValor.Text);
  dm.tbGastos.FieldByName('id_funcionario').Text := IntToStr(FCdUsuario);
  dm.tbGastos.FieldByName('data').Text := DateToStr(Date);
end;


procedure TfrmGastos.btnExcluirClick(Sender: TObject);
begin
  if MessageDlg('Deseja Excluir o registro?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    try
      dm.queryCoringa.Close;
      dm.queryCoringa.SQL.Text := 'delete from gastos where id_gasto = :id_gasto';
      dm.queryCoringa.ParamByName('id_gasto').AsInteger := StrToInt(idGasto);
      dm.queryCoringa.ExecSQL;

      //delete na tabela movimentações
      dm.queryMovimentacoes.SQL.Text := 'delete from movimentacoes where id_movimento_gasto = :id_movimento_gasto';
      dm.queryMovimentacoes.ParamByName('id_movimento_gasto').AsInteger := StrToInt(idGasto);
      dm.queryMovimentacoes.ExecSQL;

      dm.fd.Commit;
      MessageDlg('Excluído com Sucesso', mtInformation, mbOKCancel, 0);
    except
    on E:exception do
      begin
        ShowMessage('Erro ao excluir os dados '+ E.Message);
        dm.fd.Rollback;
        Exit;
      end;
    end;

    listar;
    btnExcluir.Enabled := false;
    edtMotivo.Clear;
    edtValor.Clear;
  end;
end;

procedure TfrmGastos.btnNovoClick(Sender: TObject);
begin
  btnSalvar.Enabled := True;
  edtMotivo.Enabled := True;
  edtValor.Enabled := True;
  edtMotivo.Clear;
  edtValor.Clear;
  edtMotivo.SetFocus;
  dm.tbGastos.Insert;
end;

procedure TfrmGastos.btnSalvarClick(Sender: TObject);
begin
if (Trim(edtMotivo.Text) = '') or (Trim(edtValor.Text) = '') then
  begin
    MessageDlg('Preencha o Motivo e ou Valor!', mtInformation, mbOKCancel, 0);
    edtMotivo.SetFocus;
    Exit;
  end;

  try
    dm.fd.StartTransaction;
    associarCampos;
    dm.tbGastos.Post;

    //relacionar o id do ultimo gasto inserido
    dm.queryGastos.Close;
    dm.queryGastos.SQL.Clear;
    dm.queryGastos.SQL.Add('select * from gastos order by id_gasto desc');
    dm.queryGastos.Open();

    if not dm.queryGastos.IsEmpty then
    begin
      idGasto := dm.queryGastos['id_gasto'];
    end;

    //lançar o valor do gasto nas movimentações
    dm.queryMovimentacoes.Close;
    dm.queryMovimentacoes.SQL.Clear;
    dm.queryMovimentacoes.SQL.Add('insert '+
                                  '   into '+
                                  'movimentacoes '+
                                  '   (tipo, movimento, valor, id_funcionario, data, id_movimento_gasto) '+
                                  'values '+
                                  '   (:tipo, :movimento, :valor, :id_funcionario, curDate(), :id_movimento_gasto)');
    dm.queryMovimentacoes.ParamByName('tipo').AsString := 'S';
    dm.queryMovimentacoes.ParamByName('movimento').AsString := 'D';
    dm.queryMovimentacoes.ParamByName('valor').AsCurrency := StrToCurr(edtValor.Text);
    dm.queryMovimentacoes.ParamByName('id_funcionario').Value := FCdUsuario;
    dm.queryMovimentacoes.ParamByName('id_movimento_gasto').Value := idGasto;
    dm.queryMovimentacoes.ExecSQL;

    dm.fd.Commit;
    MessageDlg('Salvo com Sucesso', mtInformation, mbOKCancel, 0);
  except
    on E:exception do
      begin
        ShowMessage('Erro ao excluir os dados '+ E.Message);
        dm.fd.Rollback;
        Exit;
      end;
  end;

  edtMotivo.Clear;
  edtValor.Clear;
  edtValor.Enabled := false;
  edtValor.Enabled := false;
  btnSalvar.Enabled := false;
  listar;
end;

procedure TfrmGastos.buscarData;
begin
  dm.queryGastos.Close;
  dm.queryGastos.SQL.Clear;
  dm.queryGastos.SQL.Add('select * from gastos where data = :data order by data desc');
  dm.queryGastos.ParamByName('data').Value := FormatDateTime('yyyy/mm/dd', edtDataBuscar.Date);
  dm.queryGastos.Open();
end;

procedure TfrmGastos.edtDataBuscarChange(Sender: TObject);
begin
  buscarData;
end;

procedure TfrmGastos.FormShow(Sender: TObject);
begin
  dm.tbGastos.Active := True;
  edtDataBuscar.Date := Date;
  buscarData;
end;

procedure TfrmGastos.gridCargosCellClick(Column: TColumn);
begin
  btnExcluir.Enabled := True;
  idGasto := dm.queryGastos.FieldByName('id_gasto').Value;
end;

procedure TfrmGastos.listar;
begin
  dm.queryGastos.Close;
  dm.queryGastos.SQL.Clear;
  dm.queryGastos.SQL.Add('select * from gastos order by data desc');
  dm.queryGastos.Open();
end;

end.
