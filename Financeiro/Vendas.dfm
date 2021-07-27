object frmVendas: TfrmVendas
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Vendas'
  ClientHeight = 793
  ClientWidth = 1442
  Color = clMoneyGreen
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object painelDetalhes: TPanel
    Left = 0
    Top = 0
    Width = 1166
    Height = 793
    Align = alClient
    Color = clSkyBlue
    ParentBackground = False
    TabOrder = 0
    object dbGridItens: TDBGrid
      Left = 1
      Top = 36
      Width = 1164
      Height = 756
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ParentFont = False
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -16
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
    object painelTituloDetalhes: TPanel
      Left = 1
      Top = 1
      Width = 1164
      Height = 35
      Align = alTop
      Alignment = taLeftJustify
      Caption = ' ITENS ADICIONADOS'
      Color = clGreen
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHighlightText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 1
    end
  end
  object painelDireita: TPanel
    Left = 1166
    Top = 0
    Width = 276
    Height = 793
    Align = alRight
    AutoSize = True
    Color = clSkyBlue
    ParentBackground = False
    TabOrder = 1
    object Panel4: TPanel
      Left = 1
      Top = 1
      Width = 274
      Height = 35
      Align = alTop
      Alignment = taLeftJustify
      Caption = ' ITENS ADICIONADOS'
      Color = clGreen
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clInactiveBorder
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 0
    end
    object Panel2: TPanel
      Left = 2
      Top = 35
      Width = 271
      Height = 29
      Alignment = taLeftJustify
      Caption = 'Total do Item'
      Color = clGreen
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clInactiveBorder
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 1
    end
    object Panel5: TPanel
      Left = 4
      Top = 118
      Width = 269
      Height = 29
      Alignment = taLeftJustify
      Caption = 'Sub-Total'
      Color = clGreen
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clInactiveBorder
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 2
    end
    object Panel6: TPanel
      Left = 4
      Top = 203
      Width = 269
      Height = 29
      Alignment = taLeftJustify
      Caption = 'Desconto'
      Color = clGreen
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clInactiveBorder
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 3
    end
    object Panel7: TPanel
      Left = 4
      Top = 287
      Width = 269
      Height = 29
      Alignment = taLeftJustify
      Caption = 'Valor Total'
      Color = clGreen
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clInactiveBorder
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 4
    end
    object Panel9: TPanel
      Left = 4
      Top = 456
      Width = 269
      Height = 29
      Alignment = taLeftJustify
      Caption = 'Troco'
      Color = clGreen
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clInactiveBorder
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 5
    end
    object Panel8: TPanel
      Left = 4
      Top = 371
      Width = 269
      Height = 29
      Alignment = taLeftJustify
      Caption = 'Valor Recebido'
      Color = clGreen
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clInactiveBorder
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 6
    end
    object pnlImagem: TPanel
      Left = 3
      Top = 536
      Width = 269
      Height = 335
      Align = alCustom
      TabOrder = 7
      object imgProduto: TImage
        Left = 1
        Top = 1
        Width = 267
        Height = 333
        Align = alClient
        AutoSize = True
        ExplicitTop = 10
        ExplicitHeight = 324
      end
    end
    object edtTotalItem: TNumberBox
      Left = 4
      Top = 62
      Width = 269
      Height = 56
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -40
      Font.Name = 'Tahoma'
      Font.Style = []
      Mode = nbmCurrency
      ParentFont = False
      TabOrder = 8
    end
    object edtSubTotal: TNumberBox
      Left = 4
      Top = 147
      Width = 269
      Height = 56
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -40
      Font.Name = 'Tahoma'
      Font.Style = []
      Mode = nbmCurrency
      ParentFont = False
      TabOrder = 9
    end
    object edtDesconto: TNumberBox
      Left = 3
      Top = 231
      Width = 270
      Height = 56
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -40
      Font.Name = 'Tahoma'
      Font.Style = []
      Mode = nbmCurrency
      ParentFont = False
      TabOrder = 10
      OnChange = edtDescontoChange
      OnExit = edtDescontoExit
    end
    object edtTotalVenda: TNumberBox
      Left = 3
      Top = 316
      Width = 270
      Height = 56
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -40
      Font.Name = 'Tahoma'
      Font.Style = []
      Mode = nbmCurrency
      ParentFont = False
      TabOrder = 11
    end
    object edtValorRecebido: TNumberBox
      Left = 4
      Top = 400
      Width = 269
      Height = 56
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -40
      Font.Name = 'Tahoma'
      Font.Style = []
      Mode = nbmCurrency
      ParentFont = False
      TabOrder = 12
      OnChange = edtValorRecebidoChange
    end
    object edtTroco: TNumberBox
      Left = 4
      Top = 483
      Width = 269
      Height = 56
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -40
      Font.Name = 'Tahoma'
      Font.Style = []
      Mode = nbmCurrency
      ParentFont = False
      TabOrder = 13
    end
  end
  object painelCentral: TPanel
    Left = -4
    Top = 632
    Width = 1175
    Height = 161
    Align = alCustom
    Anchors = [akLeft, akTop, akRight, akBottom]
    AutoSize = True
    TabOrder = 2
    DesignSize = (
      1175
      161)
    object Label12: TLabel
      Left = 8
      Top = 104
      Width = 111
      Height = 13
      Caption = 'Cancelar Item: Ctrl + Z'
    end
    object Label13: TLabel
      Left = 8
      Top = 123
      Width = 88
      Height = 13
      Caption = 'Fechar Cupom: F4'
    end
    object Label6: TLabel
      Left = 8
      Top = 142
      Width = 122
      Height = 13
      Caption = 'Cancelar Cupom: Ctrl + X'
    end
    object edtCodBarras: TEdit
      Left = 4
      Top = 42
      Width = 1057
      Height = 56
      Anchors = [akLeft, akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -40
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnChange = edtCodBarrasChange
      OnExit = edtCodBarrasExit
    end
    object Panel1: TPanel
      Left = 1
      Top = 1
      Width = 1173
      Height = 35
      Align = alTop
      Alignment = taLeftJustify
      Caption = ' C'#211'DIGO DE BARRAS'
      Color = clGreen
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clInactiveBorder
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 1
    end
    object MediaPlayer1: TMediaPlayer
      Left = 6
      Top = 652
      Width = 253
      Height = 30
      DoubleBuffered = True
      Visible = False
      ParentDoubleBuffered = False
      TabOrder = 2
    end
    object edtQtdade: TNumberBox
      Left = 1067
      Top = 42
      Width = 97
      Height = 56
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -40
      Font.Name = 'Tahoma'
      Font.Style = []
      Mode = nbmFloat
      ParentFont = False
      TabOrder = 3
      OnChange = edtQtdadeChange
      OnExit = edtQtdadeExit
    end
  end
end
