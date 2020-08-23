unit ListaVendas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Buttons, Vcl.Grids,
  Vcl.DBGrids, Vcl.ComCtrls, Vcl.StdCtrls, FireDAC.Stan.Param, System.UITypes;

type
  TfrmListaVendas = class(TForm)
    Label1: TLabel;
    cbConcluidaCancelado: TComboBox;
    Label2: TLabel;
    dtInicial: TDateTimePicker;
    Label3: TLabel;
    dtFinal: TDateTimePicker;
    dbGridVendas: TDBGrid;
    btnCancelar: TSpeedButton;
    btnComprovante: TSpeedButton;
    btnNota: TSpeedButton;
    procedure cbConcluidaCanceladoChange(Sender: TObject);
    procedure dtInicialChange(Sender: TObject);
    procedure dtFinalChange(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure dbGridVendasCellClick(Column: TColumn);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure buscarData;
  public
    { Public declarations }
  end;

var
  frmListaVendas: TfrmListaVendas;
  idVenda : String;
  qtdadeItem, idProduto : Integer;
  qt_estoque: Double;


implementation

{$R *.dfm}

uses Modulo;

{ TfrmListaVendas }

procedure TfrmListaVendas.btnCancelarClick(Sender: TObject);
begin
  if MessageDlg('Deseja Cancelar a Venda?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    try
      dm.queryVendas.Close;
      dm.queryVendas.SQL.Clear;
      dm.queryVendas.SQL.Add('update                                '+
                                '   vendas                          '+
                                'set                                '+
                                '   status = ''CA''                 '+
                                'where                              '+
                                '   id_venda = :id_venda');
      dm.queryVendas.ParamByName('id_venda').Value := idVenda;
      dm.queryVendas.ExecSQL;

      //remover a venda das movimentações
      dm.queryMovimentacoes.SQL.Text := 'delete from movimentacoes where id_movimento = :id_movimento';
      dm.queryMovimentacoes.ParamByName('id_movimento').AsInteger := StrToInt(idVenda);
      dm.queryMovimentacoes.ExecSQL;

      //devolver os itens da venda para o estoque
      dm.queryDetalhesVendas.Close;
      dm.queryDetalhesVendas.SQL.Clear;
      dm.queryDetalhesVendas.SQL.Add('select *from detalhes_vendas where id_venda = :id_venda');
      dm.queryDetalhesVendas.ParamByName('id_venda').AsInteger := StrToInt(idVenda);
      dm.queryDetalhesVendas.Open();

      if not dm.queryDetalhesVendas.IsEmpty then
      begin
        dm.queryDetalhesVendas.First;
        while not dm.queryDetalhesVendas.Eof do
        begin
          idProduto := dm.queryDetalhesVendas['id_produto'];
          qtdadeItem := dm.queryDetalhesVendas['qtdade'];

          //recuperar o estoque do produto
          dm.queryProdutos.Close;
          dm.queryProdutos.SQL.Clear;
          dm.queryProdutos.SQL.Add('select * from produtos where id_produto = :id_produto');
          dm.queryProdutos.ParamByName('id_produto').Value := idProduto;
          dm.queryProdutos.Open();


          if not dm.queryProdutos.IsEmpty then
          begin
            estoqueProduto := dm.queryProdutos['qtd_estoque'];
          end;

          //atualiza estoque produto

          qt_estoque := estoqueProduto + qtdadeItem;
          dm.queryProdutos.Close;
          dm.queryProdutos.SQL.Clear;
          dm.queryProdutos.SQL.Add('update '+
                                    'produtos set qtd_estoque = :qtd_estoque '+
                                        'where '+
                                    'id_produto = :id_produto');
          dm.queryProdutos.ParamByName('qtd_estoque').Value := qt_estoque;
          dm.queryProdutos.ParamByName('id_produto').Value := idProduto;
          dm.queryProdutos.ExecSQL;

          dm.queryDetalhesVendas.Next;
        end;
      end;

      MessageDlg('Cancelado com Sucesso', mtInformation, mbOKCancel, 0);
    except
    on E:exception do
      begin
        ShowMessage('Erro ao excluir os dados: '+ E.Message);
        Exit;
      end;
    end;

    btnCancelar.Enabled := false;
    btnComprovante.Enabled := false;
    btnNota.Enabled := false;
    buscarData;
  end;
end;

procedure TfrmListaVendas.buscarData;
begin
  dm.queryVendas.Close;
  dm.queryVendas.SQL.Clear;
if cbConcluidaCancelado.ItemIndex = 0 then
  begin
    dm.queryVendas.SQL.Add('select                                                      '+
                                  ' *                                                   '+
                                  'from                                                 '+
                                  '   vendas                                            '+
                                  'where                                                '+
                                  '   cast(data_venda as date) >= :datainicial and      '+
                                  '   cast(data_venda as date) <= :datafinal and        '+
                                  '   status = ''C''                                    '+
                                  'order by id_venda desc');
  end
  else
  begin
    dm.queryVendas.SQL.Add('select '+
                                  ' *   '+
                                  'from '+
                                  '   vendas '+
                                  'where '+
                                  '   cast(data_venda as date) >= :datainicial and '+
                                  '   cast(data_venda as date) <= :datafinal and '+
                                  '   status = ''CA'' '+
                                  'order by id_venda desc');
  end;

  dm.queryVendas.ParamByName('datainicial').Value := FormatDateTime('yyyy/mm/dd', dtInicial.Date);
  dm.queryVendas.ParamByName('datafinal').Value := FormatDateTime('yyyy/mm/dd', dtFinal.Date);
  dm.queryVendas.Open();
end;

procedure TfrmListaVendas.cbConcluidaCanceladoChange(Sender: TObject);
begin
  buscarData;
end;

procedure TfrmListaVendas.dbGridVendasCellClick(Column: TColumn);
begin
  btnCancelar.Enabled := True;
  btnComprovante.Enabled := True;
  btnNota.Enabled := True;
  idVenda := dm.queryVendas.FieldByName('id_venda').Text;
end;

procedure TfrmListaVendas.dtFinalChange(Sender: TObject);
begin
  buscarData;
end;

procedure TfrmListaVendas.dtInicialChange(Sender: TObject);
begin
  buscarData;
end;

procedure TfrmListaVendas.FormCreate(Sender: TObject);
begin
  cbConcluidaCancelado.ItemIndex := 0;
  dm.tbVendas.Active := True;
  dtInicial.Date := Date;
  dtFinal.Date := Date;

  buscarData;
end;

end.
