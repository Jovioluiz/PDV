unit Cargos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Buttons, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls;

type
  TFrmCargos = class(TForm)
    Label2: TLabel;
    edtNomeCargo: TEdit;
    DBGrid1: TDBGrid;
    btnSalvar: TSpeedButton;
    btnNovo: TSpeedButton;
    btnEditar: TSpeedButton;
    btnExcluir: TSpeedButton;
    procedure btnNovoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure associarCampos;
  public
    { Public declarations }
  end;

var
  FrmCargos: TFrmCargos;

implementation

{$R *.dfm}

uses Modulo;

procedure TFrmCargos.associarCampos;
begin
  dm.tbCargos.FieldByName('nm_cargo').Text := edtNomeCargo.Text;
end;

procedure TFrmCargos.btnNovoClick(Sender: TObject);
begin
  btnSalvar.Enabled := True;
  edtNomeCargo.Clear;
  edtNomeCargo.SetFocus;
  dm.tbCargos.Insert; //modo de inserção
end;

procedure TFrmCargos.btnSalvarClick(Sender: TObject);
begin
  if Trim(edtNomeCargo.Text) = '' then
    begin
      MessageDlg('Preencha o Cargo!', mtInformation, mbOKCancel, 0);
      edtNomeCargo.SetFocus;
      exit;
    end;
  associarCampos;
  dm.tbCargos.Post;
  MessageDlg('Salvo com Sucesso', mtInformation, mbOKCancel, 0);
end;

procedure TFrmCargos.FormCreate(Sender: TObject);
begin
  dm.tbCargos.Active := True;
end;

end.
