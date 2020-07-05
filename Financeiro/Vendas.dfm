object frmVendas: TfrmVendas
  Left = 0
  Top = 0
  Caption = 'Vendas'
  ClientHeight = 761
  ClientWidth = 1218
  Color = clMoneyGreen
  Enabled = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object painelTopo: TPanel
    Left = 0
    Top = 0
    Width = 1218
    Height = 41
    Align = alTop
    Color = clSkyBlue
    ParentBackground = False
    TabOrder = 0
  end
  object painelDetalhes: TPanel
    Left = 0
    Top = 41
    Width = 354
    Height = 720
    Align = alClient
    Color = clSkyBlue
    ParentBackground = False
    TabOrder = 1
    ExplicitHeight = 729
    object DBGrid1: TDBGrid
      Left = 1
      Top = 42
      Width = 352
      Height = 677
      Align = alClient
      DataSource = dm.dsProdutos
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
    object painelTituloDetalhes: TPanel
      Left = 1
      Top = 1
      Width = 352
      Height = 41
      Align = alTop
      Caption = 'ITENS ADICIONADOS'
      Color = clGreen
      ParentBackground = False
      TabOrder = 1
    end
  end
  object painelDireita: TPanel
    Left = 835
    Top = 41
    Width = 383
    Height = 720
    Align = alRight
    Color = clSkyBlue
    ParentBackground = False
    TabOrder = 2
    ExplicitHeight = 729
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 381
      Height = 41
      Align = alTop
      Caption = 'ITENS ADICIONADOS'
      Color = clGreen
      ParentBackground = False
      TabOrder = 0
    end
    object edtTotal: TEdit
      Left = 18
      Top = 72
      Width = 247
      Height = 48
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -33
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object edtSubTotal: TEdit
      Left = 18
      Top = 171
      Width = 247
      Height = 48
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -33
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object edtDesconto: TEdit
      Left = 18
      Top = 259
      Width = 247
      Height = 48
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -33
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object edtTotalCompra: TEdit
      Left = 18
      Top = 347
      Width = 247
      Height = 48
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -33
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object edtValorRecebido: TEdit
      Left = 18
      Top = 435
      Width = 247
      Height = 48
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -33
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
    end
    object edtTroco: TEdit
      Left = 18
      Top = 520
      Width = 247
      Height = 48
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -33
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
    end
  end
  object painelCentral: TPanel
    Left = 354
    Top = 41
    Width = 481
    Height = 720
    Align = alRight
    TabOrder = 3
    ExplicitHeight = 729
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
      Left = 268
      Top = 347
      Width = 197
      Height = 213
      Stretch = True
    end
    object edtCodBarras: TEdit
      Left = 6
      Top = 72
      Width = 438
      Height = 48
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -33
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object Panel1: TPanel
      Left = 1
      Top = 1
      Width = 479
      Height = 41
      Align = alTop
      Alignment = taLeftJustify
      Caption = 'C'#211'DIGO DE BARRAS'
      Color = clGreen
      ParentBackground = False
      TabOrder = 1
    end
    object edtCdProduto: TEdit
      Left = 16
      Top = 171
      Width = 356
      Height = 21
      Enabled = False
      TabOrder = 2
    end
    object edtDescricao: TEdit
      Left = 16
      Top = 259
      Width = 356
      Height = 21
      Enabled = False
      TabOrder = 3
    end
    object edtQtdade: TEdit
      Left = 16
      Top = 347
      Width = 230
      Height = 21
      TabOrder = 4
    end
    object edtPrecoUnitario: TEdit
      Left = 16
      Top = 435
      Width = 230
      Height = 21
      Enabled = False
      TabOrder = 5
    end
    object edtQtdadeEstoque: TEdit
      Left = 16
      Top = 539
      Width = 230
      Height = 21
      Enabled = False
      TabOrder = 6
    end
  end
end
