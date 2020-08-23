unit CertificadoDigital;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls;

type
  TfrmCertificado = class(TForm)
    pnl1: TPanel;
    btn1: TBitBtn;
    btn2: TBitBtn;
    stringrid: TStringGrid;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCertificado: TfrmCertificado;

implementation

{$R *.dfm}

end.
