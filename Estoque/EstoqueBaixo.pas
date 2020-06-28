unit EstoqueBaixo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Param,
  Vcl.Buttons, Vcl.StdCtrls;

type
  TfrmEstoqueBaixo = class(TForm)
    DBGrid1: TDBGrid;
    Label1: TLabel;
    edtQtdade: TEdit;
    btnBuscar: TSpeedButton;
    procedure btnBuscarClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure listar;
  public
    { Public declarations }
  end;

var
  frmEstoqueBaixo: TfrmEstoqueBaixo;

implementation

{$R *.dfm}

uses Modulo, EntradasProdutos;


procedure TfrmEstoqueBaixo.btnBuscarClick(Sender: TObject);
begin
  listar;
end;

procedure TfrmEstoqueBaixo.DBGrid1DblClick(Sender: TObject);
begin

  idproduto := dm.queryProdutos.FieldByName('id_produto').AsString;
  nomeProduto := dm.queryProdutos.FieldByName('nm_produto').AsString;
  estoqueProduto := dm.queryProdutos.FieldByName('qtd_estoque').AsFloat;
  unMedida := dm.queryProdutos.FieldByName('un_medida').AsString;

  chamada := 'Ent';
  frmEntradaProdutos := TfrmEntradaProdutos.Create(Self);
  frmEntradaProdutos.Show;
end;

procedure TfrmEstoqueBaixo.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    begin
      Key := #0;
      Perform(WM_NEXTDLGCTL, 0, 0);
    end;
end;

procedure TfrmEstoqueBaixo.listar;
begin
  dm.queryProdutos.Close;
  dm.queryProdutos.SQL.Clear;
  dm.queryProdutos.SQL.Add('select * from produtos where qtd_estoque <= :qtd_estoque order by nm_produto asc');
  dm.queryProdutos.ParamByName('qtd_estoque').AsFloat := StrToFloat(edtQtdade.Text);
  dm.queryProdutos.Open();
end;

end.
