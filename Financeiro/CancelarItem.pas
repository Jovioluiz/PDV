unit CancelarItem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Stan.Param, System.UITypes, Data.DB,
  Datasnap.DBClient;

type
  TfrmCancelarItem = class(TForm)
    edtSeqItem: TEdit;
    Label1: TLabel;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    FIDItem: Integer;
    FDetalhesVendas: TClientDataSet;
    FSequencia: Integer;
    procedure SetIDItem(const Value: Integer);
    procedure SetDetalhesVendas(const Value: TClientDataSet);
    procedure SetSequencia(const Value: Integer);
    { Private declarations }
  public
    { Public declarations }
    property IDItem: Integer read FIDItem write SetIDItem;
    property DetalhesVendas: TClientDataSet read FDetalhesVendas write SetDetalhesVendas;
    property Sequencia: Integer read FSequencia write SetSequencia;
  end;

var
  frmCancelarItem: TfrmCancelarItem;
  qt_estoque : Double;
  quantidade : Double;


implementation

{$R *.dfm}

uses Modulo;


procedure TfrmCancelarItem.FormCreate(Sender: TObject);
begin
  FDetalhesVendas := TClientDataSet.Create(self);
end;

procedure TfrmCancelarItem.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  //não está validando corretamente quando digitado um código que não existe
begin
  if key = 13 then
  begin
    if (Trim(edtSeqItem.Text) = EmptyStr) then
    begin
      MessageDlg('Digite o código do Item!', mtInformation, mbOKCancel, 0);
      edtSeqItem.Clear;
      edtSeqItem.SetFocus;
      Exit;
    end
    else
    begin
      try
        FSequencia := StrToInt(edtSeqItem.Text);
      except
        MessageDlg('Código Inválido', mtInformation, mbOKCancel, 0);
        edtSeqItem.Clear;
        edtSeqItem.SetFocus;
        Exit;
      end;
    end;
    Close;
  end;
end;

procedure TfrmCancelarItem.SetDetalhesVendas(const Value: TClientDataSet);
begin
  FDetalhesVendas := Value;
end;

procedure TfrmCancelarItem.SetIDItem(const Value: Integer);
begin
  FIDItem := Value;
end;

procedure TfrmCancelarItem.SetSequencia(const Value: Integer);
begin
  FSequencia := Value;
end;

end.
