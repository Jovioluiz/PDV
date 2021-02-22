object frmVendas: TfrmVendas
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Vendas'
  ClientHeight = 772
  ClientWidth = 1218
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
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object painelDetalhes: TPanel
    Left = 0
    Top = 0
    Width = 350
    Height = 688
    Align = alLeft
    Color = clSkyBlue
    ParentBackground = False
    TabOrder = 0
    object dbGridItens: TDBGrid
      Left = 1
      Top = 36
      Width = 348
      Height = 651
      Align = alClient
      Enabled = False
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
      Width = 348
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
    Left = 948
    Top = 0
    Width = 270
    Height = 688
    Align = alRight
    Color = clSkyBlue
    ParentBackground = False
    TabOrder = 1
    object edtTotal: TEdit
      Left = 6
      Top = 67
      Width = 259
      Height = 56
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -40
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = '0'
    end
    object edtSubTotal: TEdit
      Left = 6
      Top = 169
      Width = 259
      Height = 56
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -40
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Text = '0'
    end
    object edtDesconto: TEdit
      Left = 6
      Top = 267
      Width = 259
      Height = 56
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -40
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Text = '0'
      OnChange = edtDescontoChange
    end
    object edtTotalVenda: TEdit
      Left = 6
      Top = 367
      Width = 259
      Height = 56
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -40
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Text = '0'
    end
    object edtValorRecebido: TEdit
      Left = 6
      Top = 473
      Width = 259
      Height = 56
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -40
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      Text = '0'
      OnChange = edtValorRecebidoChange
    end
    object edtTroco: TEdit
      Left = 6
      Top = 575
      Width = 259
      Height = 56
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -40
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      Text = '0'
    end
    object Panel4: TPanel
      Left = 1
      Top = 1
      Width = 268
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
      TabOrder = 6
    end
    object Panel2: TPanel
      Left = 4
      Top = 40
      Width = 261
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
      TabOrder = 7
    end
    object Panel5: TPanel
      Left = 6
      Top = 142
      Width = 259
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
      TabOrder = 8
    end
    object Panel6: TPanel
      Left = 6
      Top = 241
      Width = 259
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
      TabOrder = 9
    end
    object Panel7: TPanel
      Left = 6
      Top = 340
      Width = 259
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
      TabOrder = 10
    end
    object Panel8: TPanel
      Left = 6
      Top = 445
      Width = 259
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
      TabOrder = 11
    end
    object Panel9: TPanel
      Left = 6
      Top = 552
      Width = 259
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
      TabOrder = 12
    end
  end
  object painelCentral: TPanel
    Left = 350
    Top = 0
    Width = 598
    Height = 688
    Align = alClient
    TabOrder = 2
    object Label1: TLabel
      Left = 16
      Top = 152
      Width = 49
      Height = 13
      Caption = 'PRODUTO'
    end
    object Label2: TLabel
      Left = 16
      Top = 232
      Width = 59
      Height = 13
      Caption = 'DESCRI'#199#195'O'
    end
    object Label3: TLabel
      Left = 16
      Top = 315
      Width = 66
      Height = 13
      Caption = 'QUANTIDADE'
    end
    object Label4: TLabel
      Left = 16
      Top = 400
      Width = 87
      Height = 13
      Caption = 'PRE'#199'O UNIT'#193'RIO'
    end
    object Label5: TLabel
      Left = 16
      Top = 496
      Width = 47
      Height = 13
      Caption = 'ESTOQUE'
    end
    object imgProduto: TImage
      Left = 332
      Top = 340
      Width = 237
      Height = 213
      Stretch = True
    end
    object edtCodBarras: TEdit
      Left = 6
      Top = 77
      Width = 563
      Height = 56
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -40
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnChange = edtCodBarrasChange
      OnClick = edtCodBarrasClick
    end
    object Panel1: TPanel
      Left = 1
      Top = 1
      Width = 596
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
      TabOrder = 6
    end
    object edtCdProduto: TEdit
      Left = 16
      Top = 171
      Width = 553
      Height = 32
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object edtDescricao: TEdit
      Left = 16
      Top = 259
      Width = 553
      Height = 32
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object edtQtdade: TEdit
      Left = 16
      Top = 347
      Width = 230
      Height = 32
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object edtPrecoUnitario: TEdit
      Left = 16
      Top = 435
      Width = 230
      Height = 32
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object edtQtdadeEstoque: TEdit
      Left = 16
      Top = 539
      Width = 230
      Height = 32
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
    end
    object MediaPlayer1: TMediaPlayer
      Left = 160
      Top = 608
      Width = 253
      Height = 30
      DoubleBuffered = True
      Visible = False
      ParentDoubleBuffered = False
      TabOrder = 7
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 688
    Width = 1218
    Height = 84
    Align = alBottom
    TabOrder = 3
    object Label12: TLabel
      Left = 8
      Top = 16
      Width = 111
      Height = 13
      Caption = 'Cancelar Item: Ctrl + X'
    end
    object Label13: TLabel
      Left = 8
      Top = 35
      Width = 88
      Height = 13
      Caption = 'Fechar Cupom: F4'
    end
    object Label6: TLabel
      Left = 8
      Top = 54
      Width = 122
      Height = 13
      Caption = 'Cancelar Cupom: Ctrl + Z'
    end
  end
end
