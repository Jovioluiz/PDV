object frmMovimentacoes: TfrmMovimentacoes
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Movimenta'#231#245'es'
  ClientHeight = 474
  ClientWidth = 877
  Color = clMoneyGreen
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 56
    Width = 68
    Height = 13
    Caption = 'Entrada/Sa'#237'da'
  end
  object Label2: TLabel
    Left = 320
    Top = 56
    Width = 53
    Height = 13
    Caption = 'Data Inicial'
  end
  object Label3: TLabel
    Left = 520
    Top = 56
    Width = 48
    Height = 13
    Caption = 'Data Final'
  end
  object Label4: TLabel
    Left = 8
    Top = 416
    Width = 50
    Height = 13
    Caption = 'Entradas: '
  end
  object Label5: TLabel
    Left = 159
    Top = 416
    Width = 38
    Height = 13
    Caption = 'Sa'#237'das: '
  end
  object Label6: TLabel
    Left = 720
    Top = 416
    Width = 31
    Height = 13
    Caption = 'Total: '
  end
  object lblVlEntrada: TLabel
    Left = 64
    Top = 416
    Width = 6
    Height = 13
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lblVlSaida: TLabel
    Left = 203
    Top = 416
    Width = 6
    Height = 13
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lblVlTotal: TLabel
    Left = 757
    Top = 416
    Width = 6
    Height = 13
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object dbGridVendas: TDBGrid
    Left = 8
    Top = 104
    Width = 861
    Height = 297
    DataSource = dm.dsMovimentacoes
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object cbEntradaSaida: TComboBox
    Left = 82
    Top = 53
    Width = 127
    Height = 21
    TabOrder = 1
    OnChange = cbEntradaSaidaChange
    Items.Strings = (
      'Tudo '
      'Entrada'
      'Saida')
  end
  object dtInicial: TDateTimePicker
    Left = 379
    Top = 53
    Width = 94
    Height = 21
    Date = 44031.000000000000000000
    Time = 0.776021226854936700
    TabOrder = 2
    OnChange = dtInicialChange
  end
  object dtFinal: TDateTimePicker
    Left = 574
    Top = 53
    Width = 94
    Height = 21
    Date = 44031.000000000000000000
    Time = 0.776021226854936700
    TabOrder = 3
    OnChange = dtFinalChange
  end
end
