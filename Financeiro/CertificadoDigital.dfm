object frmCertificado: TfrmCertificado
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Certificado Digital'
  ClientHeight = 360
  ClientWidth = 703
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
  object pnl1: TPanel
    Left = 0
    Top = 315
    Width = 703
    Height = 45
    Align = alBottom
    TabOrder = 0
    ExplicitTop = 192
    ExplicitWidth = 658
    DesignSize = (
      703
      45)
    object btn1: TBitBtn
      Left = 481
      Top = 5
      Width = 88
      Height = 30
      Anchors = [akTop, akRight]
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 0
      ExplicitLeft = 436
    end
    object btn2: TBitBtn
      Left = 593
      Top = 5
      Width = 88
      Height = 30
      Anchors = [akTop, akRight]
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 1
      ExplicitLeft = 548
    end
  end
  object stringrid: TStringGrid
    Left = 0
    Top = 0
    Width = 703
    Height = 315
    Align = alClient
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goColSizing]
    TabOrder = 1
    ExplicitWidth = 658
    ExplicitHeight = 192
  end
end
