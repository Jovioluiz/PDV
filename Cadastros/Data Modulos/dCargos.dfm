object dmCargos: TdmCargos
  Height = 120
  Width = 229
  object dsCargos: TDataSource
    DataSet = cdsCargos
    Left = 48
    Top = 16
  end
  object cdsCargos: TClientDataSet
    PersistDataPacket.Data = {
      480000009619E0BD01000000180000000200000000000300000048000863645F
      636172676F0400010000000000086E6D5F636172676F01004900000001000557
      494454480200020064000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'cd_cargo'
        DataType = ftInteger
      end
      item
        Name = 'nm_cargo'
        DataType = ftString
        Size = 100
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 136
    Top = 16
  end
end
