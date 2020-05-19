object FrmFuncionarios: TFrmFuncionarios
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Funcion'#225'rios'
  ClientHeight = 542
  ClientWidth = 972
  Color = clMoneyGreen
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object edtBuscarNome: TEdit
    Left = 816
    Top = 16
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object rbNome: TRadioButton
    Left = 648
    Top = 18
    Width = 57
    Height = 17
    Caption = 'Nome'
    TabOrder = 1
  end
  object rbCpf: TRadioButton
    Left = 736
    Top = 18
    Width = 57
    Height = 17
    Caption = 'CPF'
    TabOrder = 2
  end
end
