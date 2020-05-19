unit Login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.jpeg,
  Vcl.Imaging.pngimage, Vcl.StdCtrls, Vcl.Buttons, System.UITypes;

type
  TFrmLogin = class(TForm)
    Panel1: TPanel;
    imgFundo: TImage;
    pnlLogin: TPanel;
    imgLogin: TImage;
    edtUsuario: TEdit;
    edtSenha: TEdit;
    btnLogin: TSpeedButton;
    procedure FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer;
      var Resize: Boolean);
    procedure btnLoginClick(Sender: TObject);
  private
    { Private declarations }
    procedure centralizarPainel;
    procedure Login;
  public
    { Public declarations }
  end;

var
  FrmLogin: TFrmLogin;

implementation

{$R *.dfm}

uses Menu;

procedure TFrmLogin.btnLoginClick(Sender: TObject);
begin
  if (Trim(edtUsuario.Text) = '') or (Trim(edtSenha.Text) = '') then    //Trim ignora os espaços
    begin
      MessageDlg('Usuário e Senha não podem ser vazios', mtInformation, mbOKCancel, 0);
      edtUsuario.SetFocus;
      Exit;
    end;
  Login;
end;

procedure TFrmLogin.centralizarPainel;
begin
  pnlLogin.Top := (Self.Height div 2) - (pnlLogin.Height div 2);
  pnlLogin.Left := (Self.Width div 2) - (pnlLogin.Width div 2);
end;

procedure TFrmLogin.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
  centralizarPainel;
end;

procedure TFrmLogin.Login;
begin
  //login
  FrmMenu := TFrmMenu.Create(Self);
  FrmMenu.ShowModal;
end;

end.
