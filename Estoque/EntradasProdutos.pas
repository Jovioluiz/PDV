unit EntradasProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls;

type
  TfrmEntradaProdutos = class(TForm)
    Label2: TLabel;
    btnNovo: TSpeedButton;
    btnSalvar: TSpeedButton;
    btnEditar: TSpeedButton;
    btnExcluir: TSpeedButton;
    Label1: TLabel;
    btnBuscarProduto: TSpeedButton;
    Label3: TLabel;
    edtProduto: TEdit;
    DBGrid1: TDBGrid;
    edtQuantidade: TEdit;
    Label4: TLabel;
    edtValor: TEdit;
    Label5: TLabel;
    edtFornecedor: TEdit;
    btnBuscarFornecedor: TSpeedButton;
    edtDataBuscar: TDateTimePicker;
    Label6: TLabel;
    Edit1: TEdit;
    lblTotal: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEntradaProdutos: TfrmEntradaProdutos;

implementation

{$R *.dfm}

end.
