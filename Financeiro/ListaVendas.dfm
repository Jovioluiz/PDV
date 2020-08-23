object frmListaVendas: TfrmListaVendas
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Lista de Vendas'
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
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 56
    Width = 110
    Height = 13
    Caption = 'Conclu'#237'das/Canceladas'
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
  object btnCancelar: TSpeedButton
    Left = 224
    Top = 408
    Width = 105
    Height = 42
    Cursor = crHandPoint
    Caption = 'Cancelar'
    Enabled = False
    Flat = True
    Glyph.Data = {
      FA090000424DFA09000000000000360000002800000019000000190000000100
      200000000000C4090000120B0000120B00000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B5B9
      B40067716A0030453900263E300028403200273F31002E4236005B655F00A7AA
      A700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00BFC6C1003A47
      3E00000100000000000000080000000B0000000B0000000B0000000900000000
      00000000000026372A009FA5A100FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008B9694000003
      000000000000001D0D0006221200052111000521110005211100052111000521
      11000522120001200F000005000000000000646D6A00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00738279000000
      0000001505000624130005211100052111000521110005211100052111000521
      110005211100052111000521110006231300001C0C000000000043544A00FCFC
      FC00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008E9D95000000
      0000001707000623130005211100052111000521110005211100052111000521
      110005211100052111000521110005211100052111000622120002200E000000
      00005D706500FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00DBDEDD00000C
      0200001003000623130005211100052111000521110005211100052111000521
      1100052111000521110005211100052111000521110005211100052111000622
      1200011B0B0000000000B0B7B300FFFFFF00FFFFFF00FFFFFF00FFFFFF004D62
      5700000000000524130005211100052111000521110005211100052111000521
      1100052111000521110005211100052111000521110005211100052111000521
      11000521110006231300000300001E382800FFFFFF00FFFFFF00FFFFFF00E5E7
      E600001608000015040005211100052111000521110005211100052111000521
      1100052111000521110005211100052111000521110005211100052111000521
      1100052111000521110005211100021F0C0000000000B1B8B400FFFFFF00FFFF
      FF007F8B85000000000003221100052111000521110005211100052111000521
      1100052111000521110005211100052111000521110005211100052111000521
      11000521110005211100052111000521110005221200000000005B6B6300FFFF
      FF00FFFFFF003E51470000030000062212000521110005221300021E0E000013
      0200001302000014030000140300001403000014030000140300001403000014
      03000014030000120100001C0B00052313000521110005211100000700003348
      3C00FFFFFF00FFFFFF00354A3E00000700000521110005211100041D0D00102A
      1B002C4537002741330027413300274133002741330027413300274133002741
      3300274133002540310030483B0018322300041B0D000521110005211100000B
      0000263E3000FFFFFF00FFFFFF00344A3D000007000005211100052111000012
      0400243B2E00BABBB800C7C5C300C0BFBD00C0BFBD00C0BFBD00C0BFBD00C0BF
      BD00C0BFBD00C0BFBD00C5C3C100C1C1BE0041564A00000C0400052111000521
      1100000C0000273F3100FFFFFF00FFFFFF00354A3E0000070000052111000521
      110004211200021F0E0013291B001E3124001B2F22001B2F22001B2F22001B2F
      22001B2F22001B2F22001B2F22001E32250012281A00021E0E00042111000521
      110005211100000B000029403200FFFFFF00FFFFFF0044564C00000100000622
      1200052111000521110005211100001A09000017060000180700001807000018
      0700001807000018070000180700001807000017060000190800042010000522
      12000521110005211100000500003A4E4300FFFFFF00FFFFFF00909B95000000
      000003210F000521110005211100052111000521110005211100052111000521
      1100052111000521110005211100052111000521110005211100052111000521
      11000521110005211100052212000000000064746C00FFFFFF00FFFFFF00EEEE
      EE00031D0D000011030005211200052111000521110005211100052111000521
      1100052111000521110005211100052111000521110005211100052111000521
      1100052111000521110005211100001B0A0000060000C3C8C500FFFFFF00FFFF
      FF00FFFFFF0067786E0000000000052412000521110005211100052111000521
      1100052111000521110005211100052111000521110005211100052111000521
      11000521110005211100052111000624130000000000344D3F00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00EBEDEC00092013000008000006241300052111000521
      1100052111000521110005211100052111000521110005211100052111000521
      1100052111000521110005211100062313000014050000030000CCD1CE00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00ABB5AF0000000000001001000624
      1300052111000521110005211100052111000521110005211100052111000521
      110005211100052111000521110006231300001809000000000083948A00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0095A29A000000
      0000000900000524130005221200052111000521110005211100052111000521
      110005211100052111000521110005241300001202000000000074827900FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00A5AEA900111E140000000000001201000422110005221200052111000521
      11000521110005221200052212000018070000000000000B000088928D00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00E8ECEA006C746C000A1B100000000000000300000007
      000000070000000700000004000000000000000F0200535C5600D0D5D200FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E4E5E400858D8800414F
      4500374C4000344A3D00374C40003B4C40007B857F00CFD2D000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
    Transparent = False
    OnClick = btnCancelarClick
  end
  object btnComprovante: TSpeedButton
    Left = 360
    Top = 408
    Width = 105
    Height = 42
    Cursor = crHandPoint
    Caption = 'Comprovante'
    Enabled = False
    Flat = True
    Glyph.Data = {
      A2070000424DA207000000000000360000002800000019000000190000000100
      1800000000006C070000120B0000120B00000000000000000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCED0CEC0C6C3C4CA
      C7C1C7C3C7CBC8F7F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDCDEDD7982
      7B324437001202000C00001000000D00000F001F36276A756BCDD0CDFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFAFDFC70797307180B000000000700001B0A011E0D001C0C011E0D001C0C00
      0D00000000000D005F675FE2E7E4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
      FFFFFFFFFFFFFFFFFFFFD0D7D32A372C000000000000000B00000B00000C0000
      0D00000D00000D00000D00000D00000E00000400000000101B13B8C2BCFFFFFF
      FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFD6DCD90D1B11000000011E0C26
      3C2E384D413C5347364B3E33483B34493C34493C34493C354A3D32483C283E2F
      032211000400000500B6C0BAFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFF7F7F624
      392B0000000017050D2717E5E6E6FFFFFFEDE2E0EBDAD5EADAD6EADAD6EADAD6
      EADAD6E8D8D4F9EAE7FCF2EF2B4134001103000700001106DADDDBFFFFFFFFFF
      FF00FFFFFFFFFFFF728278000000042210001302122D1EF3F6F7FCF9F9B6AAA4
      BEAFAABFB2ADBFB1ADBFB1ADBFB1ADB4A7A2E9D5D1FFFFFE394C400009000524
      130000003D5547FFFFFFFFFFFF00FFFFFFE4E6E5011808001104062212001403
      102A1BE9ECEBF3F0F0AEA49FB4A9A3B5AAA5B5AAA5B5AAA5B5AAA5AA9F9ADECE
      CAFEF6F333483A000B00052111011C0B000000BCC1BEFFFFFFFFFFFFFF7E8A82
      000000042311052111001403102A1BECF0EFEEEBEA9A8D86A1938CA3958EA397
      91A39892A39892948983D6C6C1FEF8F633473A000B000521110523130000004A
      5C51FFFFFFFFFAFAF92B4235000800062212052111001403102B1BE8ECECF2EE
      EEAFA7A2B4ADAAB7B3AFC0B3A6BDADA1B5A8A3AB9E98DFCEC9FEF6F433473B00
      0B000521110521110012020B2817F0F0EF00CCD0CD000F00001C090521110521
      11001403102B1BDEE0DFFFFFFFFCFEFFFFFFFFFFFFF8FFEEE7FFF6E6FFFFE6FF
      F6EAFDE8E9FEEDE933483B000B00052111052111001D0C000C00B9C0BBFFC0C6
      C2000C00001E0D052111052111001403102B1BE0E2E1FFFFFFFFFFF3DDE0ED64
      70E03249E43D54E68E97E2FAEEDBFCEDE1FEEDEB33483B000B00052111052111
      011F0F000800AAB4AF00C5CAC7001000001C0C052111052111001403102B1BDE
      E1E1FFFFFFD9DEF01A35E60021EB324FF32444F00003EB506AFDFFFEF6FEF1E7
      33483B000B00052111052111011E0E000B00B0B9B400C1C7C4000D00001D0D05
      2111052111001403102B1BE3E5E1FFFFFF576CEA0324E98D9AEFE2E1E5C4C3E8
      798CFFA6A3CAF5DFC1FFF4F1324739000B00052111052111011F0F000900ADB6
      B100C6CBC8000C00001D0A052111052111001403102B1BEFF0E2FBFBFF1331E6
      1E3CF1EDDDEAFFFFD2FFF2F1FFF2C1F2A704E6AF47FFFBFF344A3C000B000521
      11052111011F0E000900AFB7B300F3F3F21A3325000E00052111052111001403
      102B1BEDEEE2F9FAFF3B4DF19A99FFFEF5EFFFE5E2F4EBFBECCA7BD08100E8B5
      58FFFFFF394F43000900052111052111001503051F0FE4E5E4FFFFFFFF6C7B72
      000000042312052111001403102B1BE0E2E1FEFEFFC8E0DE62D0815CCB8CCCE2
      E5FCD7B2DAA016D18200F2DDBAFFFFFF384D4100090005211106221300010039
      4E42FFFFFF00FFFFFFD5D9D7000B00001807052111001403102B1BDFE1E1FFFF
      FFE5F8E115AC5600922236CBA0F4C16BD16E00E3C473FFFFFFFFFFFF41564A00
      060005211102200D000000A9B1ABFFFFFF00FFFFFFFFFFFF4E63560000000524
      12001403112D1CE3E4E3FFFFFFFFF7FEF6F4F779C89964CCA2E8D8ACECCC9BF9
      FFFFFFFFFFB5C9B415251A01160705251300000020392AFEFDFDFFFFFF00FFFF
      FFFFFFFFE9EBEA081B0F000500001604102819FBFBFBFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFB6C9B2001602000C00062716001103000400
      C0C6C3FFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFB9C2BD000500000500041F0F4E
      61566B7A716A7A716A7A706A7A716D7B726A7A716B7A706B7B72112A1C000700
      0627150011010000008B9991FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
      FFFFB5BFB807130B000000000000000000000000000000000000000000000000
      00000000000000160502241100000000060084928AFFFFFFFFFFFFFFFFFFFFFF
      FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD3DAD6444E45000000000000001200
      011E0E021F0E011E0E021E0E021F0F001504000000000000303C34BAC3BEFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFB3B7B34E595015281B000A00000800000B000009000007000A1F11424D
      45A8ABA8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFECEBEAB1B9B4ADB5B0B0B9
      B4ADB7B1AFB6B1E0E0DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFF00}
    Transparent = False
  end
  object btnNota: TSpeedButton
    Left = 496
    Top = 408
    Width = 105
    Height = 42
    Cursor = crHandPoint
    Caption = 'Nota Fiscal'
    Enabled = False
    Flat = True
    Glyph.Data = {
      A2070000424DA207000000000000360000002800000019000000190000000100
      1800000000006C070000120B0000120B00000000000000000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCED0CEC0C6C3C4CA
      C7C1C7C3C7CBC8F7F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDCDEDD7982
      7B324437001202000C00001000000D00000F001F36276A756BCDD0CDFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFAFDFC70797307180B000000000700001B0A011E0D001C0C011E0D001C0C00
      0D00000000000D005F675FE2E7E4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
      FFFFFFFFFFFFFFFFFFFFD0D7D32A372C000000000000000B00000B00000C0000
      0D00000D00000D00000D00000D00000E00000400000000101B13B8C2BCFFFFFF
      FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFD6DCD90D1B11000000011E0C26
      3C2E384D413C5347364B3E33483B34493C34493C34493C354A3D32483C283E2F
      032211000400000500B6C0BAFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFF7F7F624
      392B0000000017050D2717E5E6E6FFFFFFEDE2E0EBDAD5EADAD6EADAD6EADAD6
      EADAD6E8D8D4F9EAE7FCF2EF2B4134001103000700001106DADDDBFFFFFFFFFF
      FF00FFFFFFFFFFFF728278000000042210001302122D1EF3F6F7FCF9F9B6AAA4
      BEAFAABFB2ADBFB1ADBFB1ADBFB1ADB4A7A2E9D5D1FFFFFE394C400009000524
      130000003D5547FFFFFFFFFFFF00FFFFFFE4E6E5011808001104062212001403
      102A1BE9ECEBF3F0F0AEA49FB4A9A3B5AAA5B5AAA5B5AAA5B5AAA5AA9F9ADECE
      CAFEF6F333483A000B00052111011C0B000000BCC1BEFFFFFFFFFFFFFF7E8A82
      000000042311052111001403102A1BECF0EFEEEBEA9A8D86A1938CA3958EA397
      91A39892A39892948983D6C6C1FEF8F633473A000B000521110523130000004A
      5C51FFFFFFFFFAFAF92B4235000800062212052111001403102B1BE8ECECF2EE
      EEAFA7A2B4ADAAB7B3AFC0B3A6BDADA1B5A8A3AB9E98DFCEC9FEF6F433473B00
      0B000521110521110012020B2817F0F0EF00CCD0CD000F00001C090521110521
      11001403102B1BDEE0DFFFFFFFFCFEFFFFFFFFFFFFF8FFEEE7FFF6E6FFFFE6FF
      F6EAFDE8E9FEEDE933483B000B00052111052111001D0C000C00B9C0BBFFC0C6
      C2000C00001E0D052111052111001403102B1BE0E2E1FFFFFFFFFFF3DDE0ED64
      70E03249E43D54E68E97E2FAEEDBFCEDE1FEEDEB33483B000B00052111052111
      011F0F000800AAB4AF00C5CAC7001000001C0C052111052111001403102B1BDE
      E1E1FFFFFFD9DEF01A35E60021EB324FF32444F00003EB506AFDFFFEF6FEF1E7
      33483B000B00052111052111011E0E000B00B0B9B400C1C7C4000D00001D0D05
      2111052111001403102B1BE3E5E1FFFFFF576CEA0324E98D9AEFE2E1E5C4C3E8
      798CFFA6A3CAF5DFC1FFF4F1324739000B00052111052111011F0F000900ADB6
      B100C6CBC8000C00001D0A052111052111001403102B1BEFF0E2FBFBFF1331E6
      1E3CF1EDDDEAFFFFD2FFF2F1FFF2C1F2A704E6AF47FFFBFF344A3C000B000521
      11052111011F0E000900AFB7B300F3F3F21A3325000E00052111052111001403
      102B1BEDEEE2F9FAFF3B4DF19A99FFFEF5EFFFE5E2F4EBFBECCA7BD08100E8B5
      58FFFFFF394F43000900052111052111001503051F0FE4E5E4FFFFFFFF6C7B72
      000000042312052111001403102B1BE0E2E1FEFEFFC8E0DE62D0815CCB8CCCE2
      E5FCD7B2DAA016D18200F2DDBAFFFFFF384D4100090005211106221300010039
      4E42FFFFFF00FFFFFFD5D9D7000B00001807052111001403102B1BDFE1E1FFFF
      FFE5F8E115AC5600922236CBA0F4C16BD16E00E3C473FFFFFFFFFFFF41564A00
      060005211102200D000000A9B1ABFFFFFF00FFFFFFFFFFFF4E63560000000524
      12001403112D1CE3E4E3FFFFFFFFF7FEF6F4F779C89964CCA2E8D8ACECCC9BF9
      FFFFFFFFFFB5C9B415251A01160705251300000020392AFEFDFDFFFFFF00FFFF
      FFFFFFFFE9EBEA081B0F000500001604102819FBFBFBFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFB6C9B2001602000C00062716001103000400
      C0C6C3FFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFB9C2BD000500000500041F0F4E
      61566B7A716A7A716A7A706A7A716D7B726A7A716B7A706B7B72112A1C000700
      0627150011010000008B9991FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
      FFFFB5BFB807130B000000000000000000000000000000000000000000000000
      00000000000000160502241100000000060084928AFFFFFFFFFFFFFFFFFFFFFF
      FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD3DAD6444E45000000000000001200
      011E0E021F0E011E0E021E0E021F0F001504000000000000303C34BAC3BEFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFB3B7B34E595015281B000A00000800000B000009000007000A1F11424D
      45A8ABA8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFECEBEAB1B9B4ADB5B0B0B9
      B4ADB7B1AFB6B1E0E0DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFF00}
    Transparent = False
  end
  object cbConcluidaCancelado: TComboBox
    Left = 124
    Top = 53
    Width = 127
    Height = 21
    TabOrder = 0
    OnChange = cbConcluidaCanceladoChange
    Items.Strings = (
      'Conclu'#237'das'
      'Canceladas')
  end
  object dtInicial: TDateTimePicker
    Left = 379
    Top = 53
    Width = 94
    Height = 21
    Date = 44031.000000000000000000
    Time = 0.776021226854936700
    TabOrder = 1
    OnChange = dtInicialChange
  end
  object dtFinal: TDateTimePicker
    Left = 574
    Top = 53
    Width = 94
    Height = 21
    Date = 44031.000000000000000000
    Time = 0.776021226854936700
    TabOrder = 2
    OnChange = dtFinalChange
  end
  object dbGridVendas: TDBGrid
    Left = 8
    Top = 97
    Width = 861
    Height = 297
    DataSource = dm.dsVendas
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnCellClick = dbGridVendasCellClick
  end
end