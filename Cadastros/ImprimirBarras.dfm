object frmImprimirBarras: TfrmImprimirBarras
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Imprimir C'#243'digo Barras'
  ClientHeight = 193
  ClientWidth = 782
  Color = clCream
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 8
    Top = 16
    Width = 124
    Height = 50
    Stretch = True
  end
  object Image2: TImage
    Left = 148
    Top = 16
    Width = 124
    Height = 50
    Stretch = True
  end
  object Image3: TImage
    Left = 296
    Top = 16
    Width = 124
    Height = 50
    Stretch = True
  end
  object Image4: TImage
    Left = 436
    Top = 16
    Width = 124
    Height = 50
    Stretch = True
  end
  object Image5: TImage
    Left = 580
    Top = 16
    Width = 124
    Height = 50
    Stretch = True
  end
  object PrintDialog1: TPrintDialog
    Left = 680
    Top = 120
  end
end
