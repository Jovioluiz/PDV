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
    procedure FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer;
      var Resize: Boolean);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edtSenhaExit(Sender: TObject);
  private
    { Private declarations }
    procedure CentralizarPainel;
    procedure Login;
  public
    { Public declarations }
  end;

var
  FrmLogin: TFrmLogin;

implementation

{$R *.dfm}

uses Menu;

procedure TFrmLogin.CentralizarPainel;
begin
  pnlLogin.Top := (Self.Height div 2) - (pnlLogin.Height div 2);
  pnlLogin.Left := (Self.Width div 2) - (pnlLogin.Width div 2);
end;

procedure TFrmLogin.edtSenhaExit(Sender: TObject);
begin
  if (Trim(edtUsuario.Text) = '') or (Trim(edtSenha.Text) = '') then
  begin
    MessageDlg('Usuário e Senha não podem ser vazios', mtInformation, mbOKCancel, 0);
    edtUsuario.SetFocus;
    Exit;
  end;

  Login;
end;

procedure TFrmLogin.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
  CentralizarPainel;
end;

procedure TFrmLogin.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0)
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
    idUsuario := dm.queryUsuarios['id_funcionario'];
    edtSenha.Clear;
    FrmMenu := TFrmMenu.Create(Self);
    FrmMenu.ShowModal;
  end
  else
  begin
    ShowMessage('Os dados estão incorretos!');
    edtUsuario.Clear;
    edtSenha.Clear;
    edtUsuario.SetFocus;
  end;
end;

end.
