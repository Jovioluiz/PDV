object frmVendas: TfrmVendas
  Left = 0
  Top = 0
  Caption = 'Vendas'
  ClientHeight = 785
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
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object painelDetalhes: TPanel
    Left = 0
    Top = 0
    Width = 1171
    Height = 570
    Align = alClient
    Color = clSkyBlue
    ParentBackground = False
    TabOrder = 0
    object dbGridItens: TDBGrid
      Left = 1
      Top = 36
      Width = 1169
      Height = 533
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
      Width = 1169
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
    object pnlImagem: TPanel
      Left = 990
      Top = 392
      Width = 180
      Height = 176
      Align = alCustom
      Anchors = [akRight, akBottom]
      TabOrder = 2
      object imgProduto: TImage
        Left = 1
        Top = 1
        Width = 178
        Height = 174
        Align = alClient
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 162
        ExplicitHeight = 172
      end
    end
  end
  object painelDireita: TPanel
    Left = 1171
    Top = 0
    Width = 271
    Height = 570
    Align = alRight
    AutoSize = True
    Color = clSkyBlue
    ParentBackground = False
    TabOrder = 1
    object edtTotalItem: TEdit
      Left = 1
      Top = 63
      Width = 265
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
      Left = 2
      Top = 149
      Width = 264
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
      Left = 2
      Top = 232
      Width = 264
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
      Left = 2
      Top = 316
      Width = 264
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
      Left = 2
      Top = 401
      Width = 264
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
      Left = 2
      Top = 482
      Width = 264
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
      Width = 269
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
      Left = 1
      Top = 36
      Width = 265
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
      Left = 2
      Top = 119
      Width = 264
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
      Left = 2
      Top = 206
      Width = 264
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
      Left = 2
      Top = 289
      Width = 264
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
    object Panel9: TPanel
      Left = 2
      Top = 457
      Width = 264
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
      TabOrder = 11
    end
    object Panel8: TPanel
      Left = 2
      Top = 372
      Width = 263
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
      TabOrder = 12
    end
  end
  object painelCentral: TPanel
    Left = 0
    Top = 570
    Width = 1442
    Height = 139
    Align = alBottom
    TabOrder = 2
    DesignSize = (
      1442
      139)
    object edtCodBarras: TEdit
      Left = 8
      Top = 54
      Width = 1019
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
      Width = 1440
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
      TabOrder = 2
    end
    object edtQtdade: TEdit
      Left = 1044
      Top = 53
      Width = 98
      Height = 56
      Anchors = [akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -40
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnChange = edtQtdadeChange
      OnExit = edtQtdadeExit
    end
    object MediaPlayer1: TMediaPlayer
      Left = 6
      Top = 652
      Width = 253
      Height = 30
      DoubleBuffered = True
      Visible = False
      ParentDoubleBuffered = False
      TabOrder = 3
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 709
    Width = 1442
    Height = 76
    Align = alBottom
    TabOrder = 3
    object Label12: TLabel
      Left = 8
      Top = 16
      Width = 111
      Height = 13
      Caption = 'Cancelar Item: Ctrl + Z'
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
