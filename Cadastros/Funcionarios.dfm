object FrmFuncionarios: TFrmFuncionarios
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Funcion'#225'rios'
  ClientHeight = 609
  ClientWidth = 883
  Color = clMoneyGreen
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 496
    Top = 27
    Width = 32
    Height = 13
    Caption = 'Buscar'
  end
  object Label2: TLabel
    Left = 72
    Top = 107
    Width = 31
    Height = 13
    Caption = 'Nome:'
  end
  object Label3: TLabel
    Left = 227
    Top = 152
    Width = 59
    Height = 13
    Caption = 'Logradouro:'
  end
  object Label4: TLabel
    Left = 354
    Top = 107
    Width = 23
    Height = 13
    Caption = 'CPF:'
  end
  object Label5: TLabel
    Left = 552
    Top = 194
    Width = 46
    Height = 13
    Caption = 'Telefone:'
  end
  object Label6: TLabel
    Left = 565
    Top = 234
    Width = 33
    Height = 13
    Caption = 'Cargo:'
  end
  object btnSalvar: TSpeedButton
    Left = 352
    Top = 544
    Width = 73
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
  object btnNovo: TSpeedButton
    Left = 265
    Top = 544
    Width = 73
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
  object btnEditar: TSpeedButton
    Left = 440
    Top = 544
    Width = 73
    Height = 42
    Cursor = crHandPoint
    Caption = 'Editar'
    Enabled = False
    Flat = True
    Glyph.Data = {
      FA090000424DFA09000000000000360000002800000019000000190000000100
      200000000000C4090000120B0000120B00000000000000000000FFFFFF00FDFD
      FD00F9F9F900FCF9FB00F0EEEF00EBE9EA00EBE9EA00EBEAEB00EBEAEB00EBEA
      EB00EBEAEB00EBEAEB00EBEAEB00EBEAEB00EBEAEB00EBEAEB00EBEAEB00EBEA
      EB00EBEAEB00EAE8E900EBEAEB00F6F9F800FFFFFF00FCFCFC00FFFFFF00FFFF
      FF00FBFAFA00D2D2D200112B1C00052111000622120006221200062212000622
      1200062212000622120006221200293E3200293E3200293E3200293E3200293E
      3200293E3200293E3200283E3200233A2D002A352D00A4A9A600FCFCFC00FFFF
      FF00FFFFFF00FFFFFF00C7CBCA00052111000521110005211100052111000521
      110005211100052111000521110005211100000B0000000D0000000D0000000D
      0000000D0000000D0000000D0000000D0000000C0000000000006D7A7300FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00F5F5F5000521110005211100052111000521
      1100052111000521110005211100062212000521110000070000001300000624
      120005211200052111000521110005211100052111000420100000030000919B
      9500FFFFFF00FFFFFF00FFFFFF00FFFFFF00F6F6F60005211100052111000521
      1100052111000521110005211100052111001F433F008CDCF500518E9F00142F
      2600000B000005210F0005211200052111000521110005211100042010000003
      000096A19B00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F4F4F400052111000521
      1100052111000521110005211100052111000521110005211100B0E5F200D7FF
      FF00228DC90003283200010F000005200D000522120005211100052111000420
      100000030000939E9800FFFFFF00FFFFFF00FFFFFF00FFFFFF00F8F8F8000521
      110005211100052111000521110005211100052111000521110005211100112E
      2200A0E7FF0040B5FB000A88CD00093A4500010E0000041D0800052213000521
      11000420100000030000939E9800FFFFFF00FFFFFF00FFFFFF00F9FAFA00F3F3
      F300052111000521110005211100052111000521110005211100052111000521
      11000521110009281D008BCFF50058C5FF000D8DD7000C4C6600021000000319
      0200052212000420100000030000939E9800FFFFFF00FFFFFF00E7E7E700CDCB
      CC00BEBFBE000521110005211100052111000521110005211100052111000521
      11000521110005211100052111000521120084C5E70069CFFF001498E5000C5B
      800004150200021600000421110000030000939E9800FFFFFF00FFFFFF00BDBD
      BD00E9E8E900CCC9CB000D271800052111000521110005211100052111000521
      110005211100052111000521110005211100052111000521110071ACC70078D3
      FF001C9FE9000C6D9F0008211800000E000000020000939E9900FFFFFF00FFFF
      FF00D3D3D300ACACAC008A8989006A726D001E37290005211100052111000521
      1100052111000521110005211100052111000521110005211100052111000521
      11005081900087DBFF0028A8F1000F7BB800012B320000000000A2A79800FFFF
      FF00FFFFFF00FFFFFF00C0C0C0009393930099949700818482002F4439000521
      1100052111000521110005211100052111000521110005211100052111000521
      1100052111000521110038656D0090DDFF0019A7F4003C92CE00414542007593
      8900FFFFFF00FFFFFF00FFFFFF00FFFFFF00D4D5D5008B918D0090919000797C
      7A002F453900354C4500A3ABA400C6B6A900ADA69B0073857F00092515000521
      1100052111000521110005211100052111001F4443008DD0FF00D3E5D0009A8D
      C10000117B00A3BEB300FFFFFF00FFFFFF00FFFFFF00FFFFFF000F2A1A003541
      3A00A4A6A800FFFFFF00F1D3BC00DAA78300CA966E00CF9B7200E0AD8900F8E6
      DD00264037000521110005211100052111000521110005211100172F2100F0E9
      E2006D67FF000000E90005298200F1FBE300FFFFFF00FFFFFF00FBFAFB001832
      230000000000B2C3C500F4D3BC00B5825700D2B79D00D4BAA000D8BA9D00C79D
      7700C6885900F0E2D8000A261800052111000521110005211100052111000521
      11000A271D0098A0FE002B2FFF001D429600F5FCE700FFFFFF00FFFFFF00FBFA
      FA000C26170015332A00DDCCC000C7987600EFE8E100DCCAB900CDB19500CBA6
      8400D7BBA000C79E7900E7B18D0063776F000521110005211100052111000521
      11000521110005211100052111002F4D4A00D6E3DC00FFFFFF00FFFFFF00FFFF
      FF00FCFBFB000017070056747100E9C4AC00CDAF9500F9F7F400EADED200E4D5
      C600D9BFA700CDA88700D9BCA100D6A178008C87780005211100052111000521
      11000521110005211100052111000521110073806C00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FDFBFC00001707005E797700E8C1A700D2B49A00F9F7F300EDE1
      D600ECDFD300EFE3D800DABFA700D6B79A00CE9A7100A2958400052111000521
      110005211100052111000521110005211100052111006A797000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFDFE00092315002C504700E6C6B200C99F7C00FFFF
      FF00F2E8DF00F0E6DB00EEE2D700E9DACC00D5B59800DCA47B00888D83000521
      110005211100052111000521110005211100052111000521110069797000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFEFF00243B2E0000050000C7D1CF00E1A8
      8100DABDA400FFFFFF00FDFDFB00FAF7F300F7F1E800B67C4C00F8CEB5003E5A
      5200052111000521110005211100052111000521110005211100052111006979
      7000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFEFF002E423600000000003248
      4500EEE7E200DEA57C00CFA68500DCC1AB00D3B29600C7906600F4C9AC008C9C
      9800052111000521110005211100052111000521110005211100052111000521
      110069797000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF002B403400000C
      00000000000030474400BDBDBA00D3B19800E2B79900E5BB9E00D8C1B0006679
      7500052111000521110005211100052111000521110005211100052111000521
      11000521110069797000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF001028
      1A0000000000000A0000000000000000000023463F004A6762004A696500082D
      2300052111000521110005211100052111000521110005211100052111000521
      1100052111000521110055675D00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00748179002F3A30003D5145003E534700374D40001F362900152D1F00132B
      1C00233B2D00354D3F000A2616000A2515000A25150009251500092515000924
      1500092415000824140008231300C7CCC900FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
    Transparent = False
    OnClick = btnEditarClick
  end
  object btnExcluir: TSpeedButton
    Left = 527
    Top = 544
    Width = 73
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
  object Label7: TLabel
    Left = 557
    Top = 152
    Width = 41
    Height = 13
    Caption = 'Numero:'
  end
  object Label8: TLabel
    Left = 71
    Top = 194
    Width = 32
    Height = 13
    Caption = 'Bairro:'
  end
  object Label9: TLabel
    Left = 66
    Top = 234
    Width = 37
    Height = 13
    Caption = 'Cidade:'
  end
  object Label10: TLabel
    Left = 360
    Top = 234
    Width = 17
    Height = 13
    Caption = 'UF:'
  end
  object Label11: TLabel
    Left = 80
    Top = 152
    Width = 23
    Height = 13
    Caption = 'CEP:'
  end
  object Label12: TLabel
    Left = 580
    Top = 107
    Width = 18
    Height = 13
    Caption = 'RG:'
  end
  object Label13: TLabel
    Left = 72
    Top = 11
    Width = 15
    Height = 13
    Caption = 'ID:'
  end
  object edtBuscarNome: TEdit
    Left = 720
    Top = 24
    Width = 121
    Height = 21
    CharCase = ecUpperCase
    TabOrder = 0
    OnChange = edtBuscarNomeChange
  end
  object rbNome: TRadioButton
    Left = 552
    Top = 26
    Width = 57
    Height = 17
    Caption = 'Nome'
    TabOrder = 15
    OnClick = rbNomeClick
  end
  object rbCpf: TRadioButton
    Left = 640
    Top = 26
    Width = 57
    Height = 17
    Caption = 'CPF'
    TabOrder = 14
    OnClick = rbCpfClick
  end
  object edtBuscarCpf: TMaskEdit
    Left = 720
    Top = 24
    Width = 97
    Height = 21
    TabOrder = 1
    Text = ''
    OnChange = edtBuscarCpfChange
  end
  object edtNome: TEdit
    Left = 109
    Top = 104
    Width = 220
    Height = 21
    CharCase = ecUpperCase
    TabOrder = 2
  end
  object edtLogradouro: TEdit
    Left = 292
    Top = 144
    Width = 220
    Height = 21
    CharCase = ecUpperCase
    TabOrder = 6
  end
  object edtCpf: TMaskEdit
    Left = 383
    Top = 104
    Width = 102
    Height = 21
    EditMask = '000.000.000-00;0;_'
    MaxLength = 14
    TabOrder = 3
    Text = ''
  end
  object edtTelefone: TMaskEdit
    Left = 604
    Top = 186
    Width = 93
    Height = 21
    EditMask = '!\(99\)00000-0000;0;_'
    MaxLength = 14
    TabOrder = 11
    Text = ''
  end
  object cbCargo: TComboBox
    Left = 604
    Top = 226
    Width = 93
    Height = 21
    TabOrder = 12
  end
  object DBGrid1: TDBGrid
    Left = 54
    Top = 272
    Width = 786
    Height = 249
    DataSource = dm.dsFuncionario
    TabOrder = 13
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnCellClick = DBGrid1CellClick
    OnDblClick = DBGrid1DblClick
  end
  object edtNum: TEdit
    Left = 604
    Top = 144
    Width = 58
    Height = 21
    TabOrder = 7
  end
  object edtBairro: TEdit
    Left = 109
    Top = 186
    Width = 220
    Height = 21
    CharCase = ecUpperCase
    TabOrder = 8
  end
  object edtCidade: TEdit
    Left = 109
    Top = 226
    Width = 220
    Height = 21
    CharCase = ecUpperCase
    TabOrder = 9
  end
  object edtUf: TEdit
    Left = 383
    Top = 226
    Width = 58
    Height = 21
    CharCase = ecUpperCase
    TabOrder = 10
  end
  object edtCEP: TMaskEdit
    Left = 109
    Top = 144
    Width = 84
    Height = 21
    TabOrder = 5
    Text = ''
    OnExit = edtCEPExit
  end
  object edtRg: TEdit
    Left = 604
    Top = 104
    Width = 93
    Height = 21
    TabOrder = 4
  end
  object edtIdFuncionario: TEdit
    Left = 109
    Top = 8
    Width = 36
    Height = 21
    CharCase = ecUpperCase
    Enabled = False
    TabOrder = 16
  end
  object sqlEndereco: TFDQuery
    Connection = dm.fd
    Left = 792
    Top = 96
  end
end
