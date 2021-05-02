unit Login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.jpeg, Data.DB,
  Vcl.Imaging.pngimage, Vcl.StdCtrls, Vcl.Buttons, System.UITypes, Modulo, FireDAC.Stan.Param,
  uPadrao, dmConexao;

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
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure CentralizarPainel;
    procedure Login;
  public

  end;

var
  FrmLogin: TFrmLogin;

implementation

{$R *.dfm}

uses Menu, FireDAC.Comp.Client;

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

procedure TFrmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  imgLogin.Free;
  imgFundo.Free;
end;

procedure TFrmLogin.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;
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
const
  SQL = 'select cd_usuario, ' +
        '   nm_usuario, ' +
        '   senha ' +
        'from ' +
        '   usuarios ' +
        'where ' +
        '   nm_usuario = :nm_usuario ' +
        '   and senha = :senha';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(Self);
  qry.Connection := dConexao.FConexaoBanco;

  try
    qry.SQL.Add(SQL);
    qry.ParamByName('nm_usuario').AsString := edtUsuario.Text;
    qry.ParamByName('senha').AsString := edtSenha.Text;
    qry.Open();

    if not qry.IsEmpty then
    begin
      FCdUsuario := qry.FieldByName('cd_usuario').AsInteger;
      edtSenha.Clear;
      ModalResult := mrOk;
    end
    else
    begin
      ShowMessage('Os dados estão incorretos!');
      edtUsuario.Clear;
      edtSenha.Clear;
      edtUsuario.SetFocus;
    end;
  finally
    qry.Free;
  end;
end;

end.
