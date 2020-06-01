unit Login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.jpeg, Data.DB,
  Vcl.Imaging.pngimage, Vcl.StdCtrls, Vcl.Buttons, System.UITypes, Modulo, FireDAC.Stan.Param;

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
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

procedure TFrmLogin.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 13 then
  begin
    Login;
  end;

end;

procedure TFrmLogin.Login;
begin
  dm.queryUsuarios.Close;
  dm.queryUsuarios.SQL.Clear;
  dm.queryUsuarios.SQL.Add('select * from usuarios where usuario = :usuario and senha = :senha');
  dm.queryUsuarios.ParamByName('usuario').AsString := edtUsuario.Text;
  dm.queryUsuarios.ParamByName('senha').AsString := edtSenha.Text;
  dm.queryUsuarios.Open();

if not dm.queryUsuarios.IsEmpty then
  begin
    nomeUsuario := dm.queryUsuarios['usuario'];
    cargoUsuario := dm.queryUsuarios['cargo'];
    edtSenha.Clear;
    FrmMenu := TFrmMenu.Create(Self);
    FrmMenu.ShowModal;
  end
else
  begin
   MessageDlg('Os dados estão incorretos!', mtInformation, mbOKCancel, 0);
   edtUsuario.Clear;
   edtSenha.Clear;
   edtUsuario.SetFocus;
  end;
  end;

end.
