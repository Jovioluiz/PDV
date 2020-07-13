unit CancelarItem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmCancelarItem = class(TForm)
    edtCodItem: TEdit;
    Label1: TLabel;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCancelarItem: TfrmCancelarItem;
  qt_estoque : Double;
  quantidade : Double;


implementation

{$R *.dfm}

uses Modulo;


procedure TfrmCancelarItem.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  //não está validando corretamente quando digitado um código que não existe
begin
  if key = 13 then
  begin
    if (Trim(edtCodItem.Text) = EmptyStr) then
    begin
      MessageDlg('Digite o código do Item!', mtInformation, mbOKCancel, 0);
      edtCodItem.Clear;
      edtCodItem.SetFocus;
      Exit;
    end
    else
    begin
      try
        //recuperar a quantidade, valor e ID do item vendido
        dm.queryCoringa.Close;
        dm.queryCoringa.SQL.Clear;
        dm.queryCoringa.SQL.Add('select * '+
                                        'from '+
                                    'detalhes_vendas '+
                                        'where '+
                                    'id_detalhe_venda = :id_detalhe_venda');
        dm.queryCoringa.ParamByName('id_detalhe_venda').Value := edtCodItem.Text;
        dm.queryCoringa.Open();

        if not dm.queryCoringa.IsEmpty then
        begin
          quantidade := dm.queryCoringa['qtdade'];
          totalProdutos := dm.queryCoringa['valor_total'];
          idproduto := dm.queryCoringa['id_produto'];
        end;

        //deleta da tabela detalhes_vendas
        dm.queryCoringa.Close;
        dm.queryCoringa.SQL.Clear;
        dm.queryCoringa.SQL.Text := 'delete from detalhes_vendas where id_detalhe_venda = :id_detalhe_venda';
        dm.queryCoringa.ParamByName('id_detalhe_venda').AsInteger := StrToInt(edtCodItem.Text);
        dm.queryCoringa.ExecSQL;
        Close;
      except
        MessageDlg('Código do Produto Inválido', mtInformation, mbYesNoCancel, 0);
        edtCodItem.Clear;
        edtCodItem.SetFocus;
        Exit;
      end;
    end;

    //recuperar o estoque do item excluido
    dm.queryProdutos.Close;
    dm.queryProdutos.SQL.Clear;
    dm.queryProdutos.SQL.Add('select * '+
                                    'from '+
                                'produtos '+
                                    'where '+
                                'id_produto = :id_produto');
    dm.queryProdutos.ParamByName('id_produto').Value := idproduto;
    dm.queryProdutos.Open();

    if not dm.queryProdutos.IsEmpty then
    begin
      qt_estoque := dm.queryProdutos['qtd_estoque'];
    end;


    //devolver quantidade para o estoque
    qt_estoque := qt_estoque + quantidade;
    dm.queryProdutos.Close;
    dm.queryProdutos.SQL.Clear;
    dm.queryProdutos.SQL.Add('update '+
                              'produtos set qtd_estoque = :qtd_estoque '+
                                  'where '+
                              'id_produto = :id_produto');
    dm.queryProdutos.ParamByName('qtd_estoque').Value := qt_estoque;
    dm.queryProdutos.ParamByName('id_produto').Value := idproduto;
    dm.queryProdutos.ExecSQL;
  end;
end;

end.
