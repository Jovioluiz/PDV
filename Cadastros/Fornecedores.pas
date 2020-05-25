unit Fornecedores;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons;

type
  TfrmFornecedor = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    btnSalvar: TSpeedButton;
    btnNovo: TSpeedButton;
    btnEditar: TSpeedButton;
    btnExcluir: TSpeedButton;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    edtBuscarNome: TEdit;
    edtNome: TEdit;
    edtLogradouro: TEdit;
    edtCpf: TMaskEdit;
    edtTelefone: TMaskEdit;
    cbCargo: TComboBox;
    DBGrid1: TDBGrid;
    edtNum: TEdit;
    edtBairro: TEdit;
    edtCidade: TEdit;
    edtUf: TEdit;
    edtCEP: TMaskEdit;
    edtRg: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFornecedor: TfrmFornecedor;

implementation

{$R *.dfm}

end.
