unit ImprimirBarras;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls;

type
  TfrmImprimirBarras = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    PrintDialog1: TPrintDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    procedure GerarCodigo(codigo : String; Canvas : TCanvas);
  public
    { Public declarations }
  end;

var
  frmImprimirBarras: TfrmImprimirBarras;

implementation

{$R *.dfm}

uses Modulo;


procedure TfrmImprimirBarras.FormCreate(Sender: TObject);
begin
  GerarCodigo(codigoProduto, Image1.Canvas);
  GerarCodigo(codigoProduto, Image2.Canvas);
  GerarCodigo(codigoProduto, Image3.Canvas);
  GerarCodigo(codigoProduto, Image4.Canvas);
  GerarCodigo(codigoProduto, Image5.Canvas);
end;

procedure TfrmImprimirBarras.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 13 then
    begin
      if (PrintDialog1.Execute) then
      begin
        Print;
      end;
    end;
end;

procedure TfrmImprimirBarras.GerarCodigo(codigo: String; Canvas: TCanvas);
const
  digitos : array['0'..'9'] of string[5]= ('00110', '10001', '01001', '11000',
  '00101', '10100', '01100', '00011', '10010', '01010');
  var s : string;
  i, j, x, t : Integer;
begin
  // Gerar o valor para desenhar o código de barras
  // Caracter de início
  s := '0000';
  for i := 1 to length(codigo) div 2 do
    for j := 1 to 5 do
    s := s + Copy(Digitos[codigo[i * 2 - 1]], j, 1) + Copy(Digitos[codigo[i * 2]], j, 1);
    // Caracter de fim
    s := s + '100';
    // Desenhar em um objeto canvas
    // Configurar os parâmetros iniciais
    x := 0;
    // Pintar o fundo do código de branco
    Canvas.Brush.Color := clWhite;
    Canvas.Pen.Color := clWhite;
    Canvas.Rectangle(10,10, 500, 79);
    // Definir as cores da caneta
    Canvas.Brush.Color := clBlack;
    Canvas.Pen.Color := clBlack;
  // Escrever o código de barras no canvas
  for i := 1 to length(s) do
    begin
      // Definir a espessura da barra
      t := strToInt(s[i]) * 2 + 1;
      // Imprimir apenas barra sim barra não (preto/branco - intercalado);
      if i mod 2 = 1 then
      Canvas.Rectangle(x, 0, x + t, 79);
      // Passar para a próxima barra
      x := x + t;
    end;
end;

end.
