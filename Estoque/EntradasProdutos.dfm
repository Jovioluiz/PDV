object frmEntradaProdutos: TfrmEntradaProdutos
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Entrada Produtos'
  ClientHeight = 591
  ClientWidth = 822
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
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 30
    Top = 107
    Width = 42
    Height = 13
    Caption = 'Produto:'
  end
  object btnNovo: TSpeedButton
    Left = 236
    Top = 505
    Width = 72
    Height = 42
    Cursor = crHandPoint
    Caption = 'Novo'
    Flat = True
    Glyph.Data = {
      FA090000424DFA09000000000000360000002800000019000000190000000100
      200000000000C4090000120B0000120B00000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F5F8
      F700929893007B847D007B857D008D948F00EEF2F000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFEFF00FFFFFF00C7CC
      C9001C291E000000000000000000000000000000000016211700BAC3BE00FFFF
      FF00FFFFFF00FFFFFF00A0A8A3002E3630002D42350031463900314639003146
      390031463900314639003146390031463900314639002E433500314538009FA5
      A000193222000000000000110400485A4F00516257000011050000010000000C
      0200D3D6D400FFFFFF00FFFFFF001831230000000000000B0000000A0000000A
      0000000A0000000A0000000A0000000A0000000A0000000A000000000000394D
      410056655B000003000000120000000000006A776E007A857E00000000000010
      000000000000485B5000FFFFFF00FFFFFF0028413400000A0000052111000521
      1100052111000521110005211100052111000521110005211100052111000004
      00007E8882005A6960000004000046594E00515651009DA6A000A2AAA4005155
      51004B5E5300000E000016312100FFFFFF00FFFFFF002C443700000A00000521
      1100052111000521110005211100052111000521110005211100052111000521
      1100000500007B867F0059685E000006000075807900878F8800C3C7C400C5C9
      C600878E87007E898100001001001A352600FFFFFF00FFFFFF002C443700000A
      0000052111000521110005211100052111000521110005211100052111000521
      11000521110000060000707D75005E6D630000000000000F0000000000005F6D
      64006D7A710000000000000D000000030000253D2F00FFFFFF00FFFFFF002C44
      3700000A00000521110005211100052111000521110005211100052111000521
      110005211100052111000017060024382B0086908900071D0D00001303000009
      020067746C007480780000090100001B0A0000000000969F9900FFFFFF00FFFF
      FF002C443700000A000005211100052111000521110005211100052111000521
      110005211100052111000521110005231200000900005260560086948D000A1A
      0E0000000000001000000013020000030000000000005E6E6400FFFFFF00FFFF
      FF00FFFFFF002C443700000A0000052111000521110005211100052111000521
      110005211100052111000521110005211100052111000420100000090000505B
      5300818A8400616C630054635800505F540054645900999F9A00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF002C443700000A00000521110005211100052111000521
      1100052111000521110005211100052111000521110005211100052212000320
      0F00000B000022352800717F770089918B00828C850060656000D3D7D400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF002C443700000A000005211100052111000521
      1100052111000521110005211100052111000521110005211100052111000521
      1100052111000523120000180700000600000005000000020000000000009DA6
      A000FFFFFF00FFFFFF00FFFFFF00FFFFFF002C443700000A0000052111000521
      1100052111000521110005211100052111000521110005211100052111000521
      1100052111000521110005211100052111000521110005211100011D0D000008
      0000A7AEA900FFFFFF00FFFFFF00FFFFFF00FFFFFF002C443700000A00000521
      1100052111000521110005211100052111000521110005211100052111000521
      110005211100052111000521110005211100052111000521110005211100011D
      0D0000080000A7AEA900FFFFFF00FFFFFF00FFFFFF00FFFFFF002C443700000A
      0000052111000521110005211100052111000521110005211100052111000521
      1100052111000521110005211100052111000521110005211100052111000521
      1100011D0D0000080000A7AEA900FFFFFF00FFFFFF00FFFFFF00FFFFFF00112C
      1E00000000000005000000050000000500000005000000050000000500000005
      0000000500000005000000050000000500000005000000050000000500000005
      00000005000000010000000000009BA39E00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF008B958F00636E6700707D7500707D7500707D7500707D7500707D7500707D
      7500707D7500707D7500707D7500707D7500707D7500707D7500707D7500707D
      7500707D7500707D75006D7A720065706800CFD2D000FFFFFF00FFFFFF00FFFF
      FF00FCFCFC007F8C8400636D65006B7A71006B7A71006B7A71006B7A71006B7A
      71006B7A71006B7A71006B7A71006B7A71006B7A71006B7A71006B7A71006B7A
      71006B7A71006B7A71006B7A710069786F00636A6500C6CBC800FFFFFF00FFFF
      FF00FFFFFF00F7F8F80005221100000000000006000000060000000600000006
      0000000600000006000000060000000600000006000000060000000600000006
      0000000600000006000000060000000600000002000000000000939D9600FFFF
      FF00FFFFFF00FFFFFF00F7F8F8001C362700000E000005211100052111000521
      1100052111000521110005211100052111000521110005211100052111000521
      11000521110005211100052111000521110005211100011F0F000002000098A2
      9B00FFFFFF00FFFFFF00FFFFFF00F9FAFA00132C1D0000000000000500000004
      0000000400000004000000040000000400000004000000040000000400000004
      0000000400000004000000040000000400000004000000040000000000000000
      0000A5ADA700FFFFFF00FFFFFF00FFFFFF00FFFFFF00ADB5B0003C443D003D52
      4600405549004055490040554900405549004055490040554900405549004055
      49004055490040554900405549004055490040554900405549003F5549003946
      3B0069786E00F8F8F800FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
    Transparent = False
    OnClick = btnNovoClick
  end
  object btnSalvar: TSpeedButton
    Left = 323
    Top = 505
    Width = 72
    Height = 42
    Cursor = crHandPoint
    Caption = 'Salvar'
    Enabled = False
    Flat = True
    Glyph.Data = {
      FA090000424DFA09000000000000360000002800000019000000190000000100
      200000000000C4090000120B0000120B00000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00EFEFEF00838A86007A7D7A009CA59F00ECE9E800E2E0DE00E1E0
      DE00E1E0DE00E1E0DE00E1E0DE00E1E0DE00E1E0DE00E1E0DE00E1E0DE00E1E0
      DE00E1E0DE00EEEBEA00A4ACA7007B7E7B007B807A00D9E0DC00FFFFFF00FFFF
      FF00FFFFFF00F4F5F40031463900000000000000000021352500E1D6CC00CAC2
      B800C8C0B600C8C0B600C8C0B600C8C0B600C8C0B600C8C0B600C8C0B600C8C0
      B600C8C0B600C9C0B600E5DBD1003E4E3F0000000000000000000E1F1500D0D4
      D200FFFFFF00FFFFFF00D2D6D300000A0000001806000002000052635800FFFF
      FD00F8F4EF00F7F4EF00F7F4EF00F7F4EF00F7F4EF00F7F4EF00F7F4EF00F7F4
      EF00F7F4EF00F7F5EF00F6F3EE00FFFFFE007A877D0000010000042413000000
      0000838F8800FFFFFF00FFFFFF00D5D9D600001A090000180700000200005364
      5A00FFFFFF00F4F3EF00F3F3F000F3F3F000F3F3F000F3F3F000F3F3F000F3F3
      F000F3F3F000F3F3F000F3F3F000F2F2EF00FFFFFF0079877E00000100000421
      1100000000008F9A9300FFFFFF00FFFFFF00D6DAD700001B0A00001807000002
      000052635900FFFFFF00ECEBE600C5C0BA00C5C1BA00C7C2BC00C7C2BC00C7C2
      BC00C7C2BC00C7C2BC00C7C2BC00C1BCB500E4E1DD00FFFFFF0078857B000001
      00000421110000000000909B9400FFFFFF00FFFFFF00D6DAD700001B0A000018
      07000002000052635900FFFFFF00F1F0EB00E7E5E100E7E5E100E8E6E100E8E6
      E100E8E6E100E8E6E100E8E6E100E8E6E100E6E4E000EEEDE900FFFFFF007886
      7C00000100000421110000000000909B9400FFFFFF00FFFFFF00D6DAD700001B
      0A00001807000001000054655B00FFFFFF00EFEDE900D9D6D100D9D7D200DAD8
      D300DAD8D300DAD8D300DAD8D300DAD8D300DAD8D300D7D4CF00EAE8E400FFFF
      FF0079877C00000100000421110000000000909B9400FFFFFF00FFFFFF00D6DA
      D700001B0A000018070000000000596B6000FFFFFF00EDEBE600CCC8C200CCC8
      C200CDC9C400CDC9C400CDC9C400CDC9C400CDC9C400CDC9C400C9C4BE00E4E2
      DE00FFFFFF0084908700000000000421110000000000909B9400FFFFFF00FFFF
      FF00D6DAD700001B0A0000180700000E020023362A00FCFAF800FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0049594D00000600000421110000000000909B9400FFFF
      FF00FFFFFF00D6DAD700001B0A0000180700042210000009000041544700C1C6
      C200C9CCC700C7CBC600C7CBC600C7CBC600C7CBC600C7CBC600C7CBC600C7CB
      C600C8CBC600CBCFCB0067766B00000B0000031F0E000421110000000000909B
      9400FFFFFF00FFFFFF00D6DAD700001B0A00001807000622120005221100000A
      0000001000000018080000170700001707000017070000170700001707000017
      070000170700001808000014030000060000021E0E0006231300042111000000
      0000909B9400FFFFFF00FFFFFF00D6DAD700001B0A0000180700052111000521
      110005211100001C0C00001A0A00001B0A00001B0A00001B0A00001B0A00001B
      0A00001B0A00001B0A00001A0A00001B0B000420100005221100052111000421
      110000000000909B9400FFFFFF00FFFFFF00D6DAD700001B0A00001807000521
      1100052111000521110005211100052111000521110005211100052111000521
      1100052111000521110005211100052111000521110005211100052111000521
      11000421110000000000909B9400FFFFFF00FFFFFF00D6DAD700001B0A000018
      0700052111000521110005211100052111000521110005211100052111000521
      1100052111000521110005211100052111000521110005211100052111000521
      1100052111000421110000000000909B9400FFFFFF00FFFFFF00D6DAD700001B
      0A000018070005211100052111000521110005221200001C0C00001807000019
      08000019080000190800001908000019080000180700001B0A00052111000521
      110005211100052111000421110000000000909B9400FFFFFF00FFFFFF00D6DA
      D700001B0A0000180700052111000521110005241300000A0000001100000923
      140006201000041F0F00021C0C00021D0C00021D0C0006200F00001403000007
      00000421110006221200052111000421110000000000909B9400FFFFFF00FFFF
      FF00D6DAD700001B0A000018070005211100052312000008000036493C00CACE
      CA00D3D4CF00CED0CB00D4D6D200D5D7D300CBCDC700CDD0CA00D1D3CD00CACE
      CA00556559000009000003210F00052111000421110000000000909B9400FFFF
      FF00FFFFFF00D6DAD700001B0A0000180700052111000015060012241800E7E8
      E400F1EBE200C1BEB000C8C5B800C4C1B400F8F4EF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF002D3F3200000C0100052111000524140000000000808D
      8500FFFFFF00FFFFFF00D6DAD700001B0A000018070005211100000900003F56
      4A00FEF9F6009F9D8A009B9A88009F9E8D008C8B7700BFBDB100FFFFFF00F0EF
      EB00F1F0EC00F3F1ED00FFFFFF005D6E62000000000006241300000F00000000
      0000B3BAB500FFFFFF00FFFFFF00D1D5D20000130100001A080005211100000B
      00003C514500F1EEEA00A3A290009D9C8B00A1A18F0091917C00C1C1B300FFFF
      FD00F0EFEB00F1F0EC00F4F3EF00FFFFFF005466590000030000000E00000005
      0000A8B3AC00FFFFFF00FFFFFF00FFFFFF00E1E3E10000150400000100000017
      0600000000002C443600F3F0EC00B5B1A500ADAC9E00B1AFA200A3A09300CAC8
      BF00FCFBF800EFEEEA00F0EFEB00F3F2EE00FFFFFF004B5E5000000000000004
      0000A4AEA700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A9B0AC000D17
      0E00011C0C00000C0000394D4000FBF7F500D8D3CF00D1CCC800D2CECA00CBC6
      C200DEDBD800F8F8F400F2F1EE00F2F1EE00F5F4F100FFFFFF00506255000005
      0000A4AFA800FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00ECF0EE00E1E3E100E2E4E200EBEDEB00FFFFFF00FCFCFC00FCFCFB00FCFC
      FB00FCFBFB00FDFDFC00FFFFFE00FEFEFE00FEFEFE00FFFFFE00FFFFFF00EBEC
      EB00E2E6E200FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
    Transparent = False
    OnClick = btnSalvarClick
  end
  object btnExcluir: TSpeedButton
    Left = 414
    Top = 505
    Width = 72
    Height = 42
    Cursor = crHandPoint
    Caption = 'Excluir'
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
    OnClick = btnExcluirClick
  end
  object Label1: TLabel
    Left = 631
    Top = 35
    Width = 32
    Height = 13
    Caption = 'Buscar'
  end
  object btnBuscarProduto: TSpeedButton
    Left = 255
    Top = 100
    Width = 25
    Height = 25
    Cursor = crHandPoint
    Flat = True
    Glyph.Data = {
      A2070000424DA207000000000000360000002800000019000000190000000100
      1800000000006C070000120B0000120B00000000000000000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5FBF5BDE3C092D19779C6806AC07166BE
      6E69C07177C57E91D396B8E2BCEEF5EEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAEDDB268BF705EBB
      665EBB665EBB665EBB665EBB665EBA6661C06961C16950A1584F95559FC8A3F8
      FBF8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF31FFFFFFFFFFFFFFFFFFFFFFFFE0F2
      E277C57D5EBB665EBB665EBB665EBB665EBB665EBB665EBA6661C16960BE684E
      9C55478E4D4A95524B95525DA164D1E4D2FFFFFFFFFFFFFFFFFFFFFFFF00FFFF
      FFFFFFFFFFFFFFDCF0DE5FBB675EBB665EBB665EBB665EBB665EBB665EBB665D
      BA6661C2695FBE674D9A54478D4D4F985644924B2C84343085384B9551CAE1CC
      FFFFFFFFFFFFFFFFFF38FFFFFFFFFFFFE7F5E85FBC675EBB665EBB665EBB665E
      BB665EBB665EBB665EBA6662C36A5DBA654C9752478E4E4F9956388B3F408F47
      93C09782B7883B8C434A9451D5E7D7FFFFFFFFFFFF00FFFFFFFFFFFF72C3795E
      BB665EBB665EBB665EBB665EBB665EBB665EBB6662C36A5DB8654A9551488F4E
      4F995634893C32873ACBE1CDFFFFFFFFFFFF7EB4832F8537539B59FEFEFEFFFF
      FF38FFFFFFBBE2BE5EBB665EBB665EBB665EBB665EBB665EBB665EBB6662C46B
      5BB56349935048904F509957358A3D33883BCEE2D0FFFFFFFFFFFFFFFFFFA0C7
      A327812F4A94519DC7A1FFFFFF00FEFEFE64BE6C5EBB665EBB665EBB665EBB66
      5EBB665FBD6760C2684CAA543887403E8B454B975343914A3E8E45D2E5D4FFFF
      FFFFFFFFFFFFFFD1E4D33D8E4443924B4B96524B9652F3F8F438C8E8CB5EBB66
      5EBB665EBB665EBB6660BC685EBC6646B34F42A04A5D9C636BA670539B5A2D85
      350E72179DC6A1FFFFFFFFFFFFFFFFFFCEE2D0328739378B3F4F98564B96524B
      9652ADD0B00097D39C5EBB665EBB665EBB6660BC6857B85F3EAE488ECC93DFE9
      E0E9F0EAE3EFE4EBF4ECCCE1CE509957C7DFCAFFFFFFFFFFFFCDE2CF33883B34
      893C4F99564B96524B97524991507AB07F1C7CC8835EBB665EBB665EBB665BB9
      6340AE49BFE6C2FFFCFF9FC6A360A3665199586FAB74BDD8BFFFFFFFFFFFFFBB
      D7BE96C29A409048368A3D4F98564B96524B9752488F4E4A945170BC760067BF
      6E5EBB665EBB6660BC683DAD47ABE0B0FFFFFF4E96551E7C273B8D4342914A34
      883B1A792387B98CFFFFFF559C5B10731943914A4F98564B96524B9652478E4D
      4C97535DBA656BC7733862BD6A5EBB665EBB6656B85E5EBC66FFFFFF7FB08320
      7D294F98564B96524B96524C97534B9652187821C9DFCBD3E5D52A83324B9652
      4B97524A9552478E4D4F9D565FBD6761C16A64BC6B0068BF705EBB665EBB6646
      B14FA1DBA6EAEFEA378A3E46944E4B96524B96524B96524B96524C975333883B
      70AC75F6FAF6539B5A4190484A9351478D4D52A35961C26A61C0695EBA6567BF
      6F147EC9855EBB665EBB6642AF4BB8E6BCD4E2D62D85364B96524B96524B9652
      4B96524B96524B965243914A4D9754ECF4ED74AF7A36873D478F4E55AB5D62C2
      6A60BE685EBA665EBB6675C57C009BD5A05EBB665EBB6644B04DADE1B1E0E9E1
      32873A4A95514B96524B96524B96524B96524B96523B8D425FA265F2F8F3609D
      653A894259B16062C46B5FBD675EBA665EBB665EBB668CCE921CCEEAD15EBB66
      5EBB6650B55975C77CFFFFFF5B9D623187394E98554B96524B96524B96524F98
      551B7923ABCEAEECEFED31863959B56162C36A5EBB665EBB665EBB665EBB665E
      BB66BCE3BF00FFFFFF6AC0715EBB665EBB673DAD47D6F2D8E9EBEA237E2C3287
      3A4995504B965247944E237E2B519858FFFFFF8ABE8F41AB4A63C36B5EBB665E
      BB665EBB665EBB665EBB665FBC67F9FCF91CFFFFFFC2E5C55EBB665FBB6751B6
      5A53B75BF7FFF7E0E7E1579B5D34883C2F8537398B4175AC7AFFFFFFC1E3C43A
      A94461C1695EBA665EBB665EBB665EBB665EBB665EBB66B0DEB4FFFFFF00FFFF
      FFFFFFFF7CC8825EBB6661BD694AB25354B85DCAEDCDF2F9F2D9E6DACFE0D1E1
      EBE2F4FDF4A2DBA840AE4A58BA605FBB675EBB665EBB665EBB665EBB665EBB66
      6EC275FFFFFFFFFFFF1CFFFFFFFFFFFFF0F9F167BF6E5EBB6662BD6951B65A42
      AF4B75C77CA6DEABB3E4B79BD9A061BD6940AE495BBA6360BC685EBB665EBB66
      5EBB665EBB665EBB665FBB67E4F4E5FFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFE8
      F5E969C0705EBB665FBB675FBB6751B55946B14F44B04D48B25156B85E60BC68
      5EBB665EBB665EBB665EBB665EBB665EBB6660BC68DCF0DDFFFFFFFFFFFFFFFF
      FF1CFFFFFFFFFFFFFFFFFFFFFFFFECF7ED84CB8A5EBB665EBB665EBB665EBB66
      5EBB665EBB665EBB665EBB665EBB665EBB665EBB665EBB665EBB667AC781E3F3
      E4FFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      BDE3C175C57C5EBB665EBB665EBB665EBB665EBB665EBB665EBB665EBB665EBB
      6670C277B7E1BBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1CFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCCEACF9ED6A382CA886CC17366BE
      6E6BC0727FC9869BD5A0C7E8CAFBFDFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFF00}
    OnClick = btnBuscarProdutoClick
  end
  object Label3: TLabel
    Left = 323
    Top = 107
    Width = 60
    Height = 13
    Caption = 'Quantidade:'
  end
  object Label4: TLabel
    Left = 355
    Top = 147
    Width = 28
    Height = 13
    Caption = 'Valor:'
  end
  object Label5: TLabel
    Left = 13
    Top = 147
    Width = 59
    Height = 13
    Caption = 'Fornecedor:'
  end
  object btnBuscarFornecedor: TSpeedButton
    Left = 255
    Top = 144
    Width = 25
    Height = 25
    Cursor = crHandPoint
    Flat = True
    Glyph.Data = {
      A2070000424DA207000000000000360000002800000019000000190000000100
      1800000000006C070000120B0000120B00000000000000000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5FBF5BDE3C092D19779C6806AC07166BE
      6E69C07177C57E91D396B8E2BCEEF5EEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAEDDB268BF705EBB
      665EBB665EBB665EBB665EBB665EBA6661C06961C16950A1584F95559FC8A3F8
      FBF8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF31FFFFFFFFFFFFFFFFFFFFFFFFE0F2
      E277C57D5EBB665EBB665EBB665EBB665EBB665EBB665EBA6661C16960BE684E
      9C55478E4D4A95524B95525DA164D1E4D2FFFFFFFFFFFFFFFFFFFFFFFF00FFFF
      FFFFFFFFFFFFFFDCF0DE5FBB675EBB665EBB665EBB665EBB665EBB665EBB665D
      BA6661C2695FBE674D9A54478D4D4F985644924B2C84343085384B9551CAE1CC
      FFFFFFFFFFFFFFFFFF38FFFFFFFFFFFFE7F5E85FBC675EBB665EBB665EBB665E
      BB665EBB665EBB665EBA6662C36A5DBA654C9752478E4E4F9956388B3F408F47
      93C09782B7883B8C434A9451D5E7D7FFFFFFFFFFFF00FFFFFFFFFFFF72C3795E
      BB665EBB665EBB665EBB665EBB665EBB665EBB6662C36A5DB8654A9551488F4E
      4F995634893C32873ACBE1CDFFFFFFFFFFFF7EB4832F8537539B59FEFEFEFFFF
      FF38FFFFFFBBE2BE5EBB665EBB665EBB665EBB665EBB665EBB665EBB6662C46B
      5BB56349935048904F509957358A3D33883BCEE2D0FFFFFFFFFFFFFFFFFFA0C7
      A327812F4A94519DC7A1FFFFFF00FEFEFE64BE6C5EBB665EBB665EBB665EBB66
      5EBB665FBD6760C2684CAA543887403E8B454B975343914A3E8E45D2E5D4FFFF
      FFFFFFFFFFFFFFD1E4D33D8E4443924B4B96524B9652F3F8F438C8E8CB5EBB66
      5EBB665EBB665EBB6660BC685EBC6646B34F42A04A5D9C636BA670539B5A2D85
      350E72179DC6A1FFFFFFFFFFFFFFFFFFCEE2D0328739378B3F4F98564B96524B
      9652ADD0B00097D39C5EBB665EBB665EBB6660BC6857B85F3EAE488ECC93DFE9
      E0E9F0EAE3EFE4EBF4ECCCE1CE509957C7DFCAFFFFFFFFFFFFCDE2CF33883B34
      893C4F99564B96524B97524991507AB07F1C7CC8835EBB665EBB665EBB665BB9
      6340AE49BFE6C2FFFCFF9FC6A360A3665199586FAB74BDD8BFFFFFFFFFFFFFBB
      D7BE96C29A409048368A3D4F98564B96524B9752488F4E4A945170BC760067BF
      6E5EBB665EBB6660BC683DAD47ABE0B0FFFFFF4E96551E7C273B8D4342914A34
      883B1A792387B98CFFFFFF559C5B10731943914A4F98564B96524B9652478E4D
      4C97535DBA656BC7733862BD6A5EBB665EBB6656B85E5EBC66FFFFFF7FB08320
      7D294F98564B96524B96524C97534B9652187821C9DFCBD3E5D52A83324B9652
      4B97524A9552478E4D4F9D565FBD6761C16A64BC6B0068BF705EBB665EBB6646
      B14FA1DBA6EAEFEA378A3E46944E4B96524B96524B96524B96524C975333883B
      70AC75F6FAF6539B5A4190484A9351478D4D52A35961C26A61C0695EBA6567BF
      6F147EC9855EBB665EBB6642AF4BB8E6BCD4E2D62D85364B96524B96524B9652
      4B96524B96524B965243914A4D9754ECF4ED74AF7A36873D478F4E55AB5D62C2
      6A60BE685EBA665EBB6675C57C009BD5A05EBB665EBB6644B04DADE1B1E0E9E1
      32873A4A95514B96524B96524B96524B96524B96523B8D425FA265F2F8F3609D
      653A894259B16062C46B5FBD675EBA665EBB665EBB668CCE921CCEEAD15EBB66
      5EBB6650B55975C77CFFFFFF5B9D623187394E98554B96524B96524B96524F98
      551B7923ABCEAEECEFED31863959B56162C36A5EBB665EBB665EBB665EBB665E
      BB66BCE3BF00FFFFFF6AC0715EBB665EBB673DAD47D6F2D8E9EBEA237E2C3287
      3A4995504B965247944E237E2B519858FFFFFF8ABE8F41AB4A63C36B5EBB665E
      BB665EBB665EBB665EBB665FBC67F9FCF91CFFFFFFC2E5C55EBB665FBB6751B6
      5A53B75BF7FFF7E0E7E1579B5D34883C2F8537398B4175AC7AFFFFFFC1E3C43A
      A94461C1695EBA665EBB665EBB665EBB665EBB665EBB66B0DEB4FFFFFF00FFFF
      FFFFFFFF7CC8825EBB6661BD694AB25354B85DCAEDCDF2F9F2D9E6DACFE0D1E1
      EBE2F4FDF4A2DBA840AE4A58BA605FBB675EBB665EBB665EBB665EBB665EBB66
      6EC275FFFFFFFFFFFF1CFFFFFFFFFFFFF0F9F167BF6E5EBB6662BD6951B65A42
      AF4B75C77CA6DEABB3E4B79BD9A061BD6940AE495BBA6360BC685EBB665EBB66
      5EBB665EBB665EBB665FBB67E4F4E5FFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFE8
      F5E969C0705EBB665FBB675FBB6751B55946B14F44B04D48B25156B85E60BC68
      5EBB665EBB665EBB665EBB665EBB665EBB6660BC68DCF0DDFFFFFFFFFFFFFFFF
      FF1CFFFFFFFFFFFFFFFFFFFFFFFFECF7ED84CB8A5EBB665EBB665EBB665EBB66
      5EBB665EBB665EBB665EBB665EBB665EBB665EBB665EBB665EBB667AC781E3F3
      E4FFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      BDE3C175C57C5EBB665EBB665EBB665EBB665EBB665EBB665EBB665EBB665EBB
      6670C277B7E1BBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1CFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCCEACF9ED6A382CA886CC17366BE
      6E6BC0727FC9869BD5A0C7E8CAFBFDFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFF00}
    OnClick = btnBuscarFornecedorClick
  end
  object Label6: TLabel
    Left = 448
    Top = 107
    Width = 55
    Height = 13
    Caption = 'UN Medida:'
  end
  object lblTotal: TLabel
    Left = 773
    Top = 496
    Width = 3
    Height = 13
    Alignment = taRightJustify
  end
  object Label7: TLabel
    Left = 16
    Top = 24
    Width = 56
    Height = 13
    Caption = 'ID Entrada:'
  end
  object edtProduto: TEdit
    Left = 78
    Top = 104
    Width = 164
    Height = 21
    TabOrder = 0
  end
  object DBGrid1: TDBGrid
    Left = 30
    Top = 192
    Width = 755
    Height = 281
    DataSource = dm.dsEntradaProdutos
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnCellClick = DBGrid1CellClick
  end
  object edtQuantidade: TEdit
    Left = 389
    Top = 104
    Width = 52
    Height = 21
    TabOrder = 1
    Text = '1'
    OnChange = edtQuantidadeChange
  end
  object edtValor: TEdit
    Left = 389
    Top = 144
    Width = 52
    Height = 21
    TabOrder = 4
    Text = '0'
    OnChange = edtValorChange
  end
  object edtFornecedor: TEdit
    Left = 77
    Top = 144
    Width = 164
    Height = 21
    TabOrder = 3
  end
  object edtDataBuscar: TDateTimePicker
    Left = 685
    Top = 35
    Width = 100
    Height = 21
    Date = 43989.000000000000000000
    Time = 0.863238055557303600
    TabOrder = 6
    OnChange = edtDataBuscarChange
  end
  object edtUnMedida: TEdit
    Left = 514
    Top = 104
    Width = 52
    Height = 21
    TabOrder = 2
  end
  object edtIdEntrada: TEdit
    Left = 78
    Top = 21
    Width = 43
    Height = 21
    Enabled = False
    TabOrder = 7
  end
end
