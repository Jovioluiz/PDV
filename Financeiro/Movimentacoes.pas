unit Movimentacoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Buttons, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Param;

type
  TfrmMovimentacoes = class(TForm)
    dbGridVendas: TDBGrid;
    Label1: TLabel;
    cbEntradaSaida: TComboBox;
    Label2: TLabel;
    Label3: TLabel;
    dtInicial: TDateTimePicker;
    dtFinal: TDateTimePicker;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    lblVlEntrada: TLabel;
    lblVlSaida: TLabel;
    lblVlTotal: TLabel;
    procedure FormShow(Sender: TObject);
    procedure cbEntradaSaidaChange(Sender: TObject);
    procedure dtInicialChange(Sender: TObject);
    procedure dtFinalChange(Sender: TObject);
  private
    { Private declarations }
    procedure buscarTudo;
    procedure buscarData;
    procedure totalizarEntrada;
    procedure totalizarSaidas;
    procedure totalizar;
    procedure formatarGrid;

  public
    { Public declarations }
  end;

var
  frmMovimentacoes: TfrmMovimentacoes;
  totalEntrada : real;
  totalSaida : real;

implementation

{$R *.dfm}

uses Modulo;

procedure TfrmMovimentacoes.buscarData;
begin
  totalizarEntrada;
  totalizarSaidas;
  totalizar;

  dm.queryMovimentacoes.Close;
  dm.queryMovimentacoes.SQL.Clear;

  if cbEntradaSaida.ItemIndex = 0 then
  begin
    dm.queryMovimentacoes.SQL.Add('select '+
                                  '    id_movimentacoes,                  '+
                                  '  case when tipo = ''E'' then          '+
                                  '      ''Entrada''                      '+
                                  '  when tipo = ''S'' then               '+
                                  '      ''Saida''                        '+
                                  '  end as tipo,                         '+
                                  '      case when movimento = ''V'' then '+
                                  '      ''Venda''                        '+
                                  '  when movimento = ''D'' then          '+
                                  '      ''Despesa''                      '+
                                  '  end as movimento,                    '+
                                  '  valor,                               '+
                                  '  id_funcionario,                      '+
                                  '  data,                                '+
                                  '  id_movimento,                        '+
                                  '  id_movimento_gasto                   '+
                                  'from                                   '+
                                  '   movimentacoes                       '+
                                  'where                                  '+
                                  '   data >= :datainicial and            '+
                                  '   data <= :datafinal                  '+
                                  'order by id_movimentacoes desc');
  end
  else
  begin
    dm.queryMovimentacoes.SQL.Add('select '+
                                  '    id_movimentacoes,                  '+
                                  '  case when tipo = ''E'' then          '+
                                  '      ''Entrada''                      '+
                                  '  when tipo = ''S'' then               '+
                                  '      ''Saida''                        '+
                                  '  end as tipo,                         '+
                                  '  case when movimento = ''V'' then '+
                                  '      ''Venda''                        '+
                                  '  when movimento = ''D'' then          '+
                                  '      ''Despesa''                      '+
                                  '  end as movimento,                    '+
                                  '  valor,                               '+
                                  '  id_funcionario,                      '+
                                  '  data,                                '+
                                  '  id_movimento,                        '+
                                  '  id_movimento_gasto                   '+
                                  'from '+
                                  '   movimentacoes '+
                                  'where '+
                                  '   data >= :datainicial and '+
                                  '   data <= :datafinal and '+
                                  '   tipo = :tipo '+
                                  'order by id_movimentacoes desc');
    if cbEntradaSaida.ItemIndex = 1 then
    begin
      dm.queryMovimentacoes.ParamByName('tipo').Value := 'E';
    end
    else
    begin
      dm.queryMovimentacoes.ParamByName('tipo').Value := 'S';
    end;
  end;

  dm.queryMovimentacoes.ParamByName('datainicial').Value := FormatDateTime('yyyy/mm/dd', dtInicial.Date);
  dm.queryMovimentacoes.ParamByName('datafinal').Value := FormatDateTime('yyyy/mm/dd', dtFinal.Date);
  dm.queryMovimentacoes.Open();
  formatarGrid;
end;

procedure TfrmMovimentacoes.buscarTudo;
begin
  totalizarEntrada;
  totalizarSaidas;
  totalizar;

  dm.queryMovimentacoes.Close;
  dm.queryMovimentacoes.SQL.Clear;
  dm.queryMovimentacoes.SQL.Add('select '+
                                  '    id_movimentacoes,                  '+
                                  '  case when tipo = ''E'' then          '+
                                  '      ''Entrada''                      '+
                                  '  when tipo = ''S'' then               '+
                                  '      ''Saida''                        '+
                                  '  end as tipo,                         '+
                                  '  case when movimento = ''V'' then '+
                                  '      ''Venda''                        '+
                                  '  when movimento = ''D'' then          '+
                                  '      ''Despesa''                      '+
                                  '  end as movimento,                    '+
                                  '  valor,                               '+
                                  '  id_funcionario,                      '+
                                  '  data,                                '+
                                  '  id_movimento,                        '+
                                  '  id_movimento_gasto                   '+
                              'from                                       '+
                              '   movimentacoes                           '+
                              'where                                      '+
                              '   data = curDate()                        '+
                              'order by id_movimentacoes desc');
  dm.queryMovimentacoes.Open();
  TFloatField(dm.queryMovimentacoes.FieldByName('valor')).DisplayFormat := 'R$ #,,,,0.00';
  formatarGrid;
end;

procedure TfrmMovimentacoes.cbEntradaSaidaChange(Sender: TObject);
begin
  buscarData;
end;

procedure TfrmMovimentacoes.dtFinalChange(Sender: TObject);
begin
  buscarData;
end;

procedure TfrmMovimentacoes.dtInicialChange(Sender: TObject);
begin
  buscarData;
end;

procedure TfrmMovimentacoes.formatarGrid;
begin
  dbGridVendas.Columns.Items[0].FieldName := 'Id';
  dbGridVendas.Columns.Items[0].Title.Caption := 'ID';
  dbGridVendas.Columns.Items[0].Visible := false;

  dbGridVendas.Columns.Items[1].FieldName := 'tipo';
  dbGridVendas.Columns.Items[1].Title.Caption := 'Tipo';

  dbGridVendas.Columns.Items[2].FieldName := 'movimento';
  dbGridVendas.Columns.Items[2].Title.Caption := 'Movimento';

  dbGridVendas.Columns.Items[3].FieldName := 'valor';
  dbGridVendas.Columns.Items[3].Title.Caption := 'Valor';

  dbGridVendas.Columns.Items[4].FieldName := 'id_funcionario';
  dbGridVendas.Columns.Items[4].Title.Caption := 'Funcionario';

  dbGridVendas.Columns.Items[5].FieldName := 'data';
  dbGridVendas.Columns.Items[5].Title.Caption := 'Data';

 dbGridVendas.Columns.Items[6].Visible := false;
 dbGridVendas.Columns.Items[7].Visible := false;
end;

procedure TfrmMovimentacoes.FormShow(Sender: TObject);
begin
  lblVlEntrada.Caption := FormatFloat('R$ #,,,,0.00', StrToFloat(lblVlEntrada.Caption));
  lblVlSaida.Caption := FormatFloat('R$ #,,,,0.00', StrToFloat(lblVlSaida.Caption));
  lblVlTotal.Caption := FormatFloat('R$ #,,,,0.00', StrToFloat(lblVlTotal.Caption));

  cbEntradaSaida.ItemIndex := 0;

  dm.tbMovimentacoes.Active := False;
  dm.tbMovimentacoes.Active := True;

  dtInicial.Date := Date;
  dtFinal.Date := Date;

  totalizarEntrada;
  totalizarSaidas;
  totalizar;
  buscarTudo;
end;

procedure TfrmMovimentacoes.totalizar;
var
  tot : Real;
begin
  tot := totalEntrada - totalSaida;
  if tot >= 0 then
  begin
    lblVlTotal.Font.Color := clGreen;
  end
  else
  begin
    lblVlTotal.Font.Color := clRed;
  end;

  lblVlTotal.Caption := FormatFloat('R$ #,,,,0.00', tot);
end;

procedure TfrmMovimentacoes.totalizarEntrada;
var
  tot : Real;
begin
  dm.queryMovimentacoes.Close;
  dm.queryMovimentacoes.SQL.Clear;
  dm.queryMovimentacoes.SQL.Add('select '+
                                '   sum(valor) as total '+
                                'from '+
                                '   movimentacoes '+
                                'where '+
                                '   data >= :datainicial and '+
                                '   data <= :datafinal and '+
                                '   tipo = "E" ');
  dm.queryMovimentacoes.ParamByName('datainicial').Value := FormatDateTime('yyyy/mm/dd', dtInicial.Date);
  dm.queryMovimentacoes.ParamByName('datafinal').Value := FormatDateTime('yyyy/mm/dd', dtFinal.Date);
  dm.queryMovimentacoes.Prepare;
  dm.queryMovimentacoes.Open;
  tot := dm.queryMovimentacoes.FieldByName('total').AsFloat;
  totalEntrada := tot;
  lblVlEntrada.Caption := FormatFloat('R$ #,,,,0.00', tot);
end;

procedure TfrmMovimentacoes.totalizarSaidas;
var
  tot : Real;
begin
  dm.queryMovimentacoes.Close;
  dm.queryMovimentacoes.SQL.Clear;
  dm.queryMovimentacoes.SQL.Add('select '+
                                '   sum(valor) as total '+
                                'from '+
                                '   movimentacoes '+
                                'where '+
                                '   data >= :datainicial and '+
                                '   data <= :datafinal and '+
                                '   tipo = "S" ');
  dm.queryMovimentacoes.ParamByName('datainicial').Value := FormatDateTime('yyyy/mm/dd', dtInicial.Date);
  dm.queryMovimentacoes.ParamByName('datafinal').Value := FormatDateTime('yyyy/mm/dd', dtFinal.Date);
  dm.queryMovimentacoes.Prepare;
  dm.queryMovimentacoes.Open;
  tot := dm.queryMovimentacoes.FieldByName('total').AsFloat;
  totalSaida := tot;
  lblVlSaida.Caption := FormatFloat('R$ #,,,,0.00', tot);
end;

end.
