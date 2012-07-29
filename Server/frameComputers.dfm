object framComputers: TframComputers
  Left = 0
  Top = 0
  Width = 561
  Height = 488
  TabOrder = 0
  object pgcComputers: TPageControl
    Left = 0
    Top = 0
    Width = 561
    Height = 488
    ActivePage = tabGroups
    Align = alClient
    MultiLine = True
    TabOrder = 0
    object tabGroups: TTabSheet
      Caption = #1043#1088#1091#1087#1087#1099
      object pnGroups: TPanel
        Left = 0
        Top = 0
        Width = 553
        Height = 460
        Align = alClient
        TabOrder = 0
        object butGroupAdd: TButton
          Left = 174
          Top = 12
          Width = 75
          Height = 25
          Caption = 'add'
          TabOrder = 0
          OnClick = butGroupAddClick
        end
        object butGroupUpdate: TButton
          Left = 174
          Top = 44
          Width = 75
          Height = 25
          Caption = 'update'
          Enabled = False
          TabOrder = 1
          OnClick = butGroupUpdateClick
        end
        object butGroupDelete: TButton
          Left = 174
          Top = 76
          Width = 75
          Height = 25
          Caption = 'delete'
          TabOrder = 2
          OnClick = butGroupDeleteClick
        end
        object lbGroups: TListBox
          Left = 11
          Top = 12
          Width = 149
          Height = 253
          ItemHeight = 13
          TabOrder = 3
          OnClick = lbGroupsClick
        end
        object editGroups: TEdit
          Left = 11
          Top = 272
          Width = 150
          Height = 21
          TabOrder = 4
          OnChange = editGroupsChange
        end
      end
    end
    object tabComputers: TTabSheet
      Caption = #1050#1086#1084#1087#1100#1102#1090#1077#1088#1099
      ImageIndex = 1
      object gridComputers: TDBGridEh
        Left = 0
        Top = 0
        Width = 553
        Height = 412
        Align = alClient
        AutoFitColWidths = True
        BiDiMode = bdRightToLeftNoAlign
        DataSource = dsComputers
        Flat = True
        FooterColor = clWindow
        FooterFont.Charset = DEFAULT_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -11
        FooterFont.Name = 'MS Sans Serif'
        FooterFont.Style = []
        Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        ParentBiDiMode = False
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        FilterStringColor = clWindow
        OnColExit = gridComputersColExit
        OnExit = gridComputersExit
        Columns = <
          item
            Checkboxes = True
            EditButtons = <>
            FieldName = 'chek'
            Footers = <>
            Width = 16
          end
          item
            EditButtons = <>
            FieldName = 'number'
            Footers = <>
            Title.Caption = 'Number'
            Width = 45
          end
          item
            EditButtons = <>
            FieldName = 'group'
            Footers = <>
            Title.Caption = 'Group'
            Width = 88
          end
          item
            EditButtons = <>
            FieldName = 'client_type'
            Footers = <>
            PickList.Strings = (
              'GameClass'
              'SNMP')
          end
          item
            EditButtons = <>
            FieldName = 'ip'
            Footers = <>
            Title.Caption = 'IP'
            Width = 106
          end
          item
            ButtonStyle = cbsEllipsis
            EditButtons = <>
            FieldName = 'mac'
            Footers = <>
            Title.Caption = 'MAC'
            Width = 104
            OnEditButtonClick = gridComputersColumns3EditButtonClick
          end
          item
            EditButtons = <>
            FieldName = 'snmp_password'
            Footers = <>
          end
          item
            EditButtons = <>
            FieldName = 'mib_port'
            Footers = <>
          end
          item
            Checkboxes = True
            EditButtons = <>
            FieldName = 'ignore_offline'
            Footers = <>
          end>
      end
      object GroupBox1: TGroupBox
        Left = 0
        Top = 412
        Width = 553
        Height = 48
        Align = alBottom
        TabOrder = 1
        object butAdd1: TButton
          Left = 5
          Top = 14
          Width = 75
          Height = 25
          Caption = 'add'
          TabOrder = 0
          OnClick = butAdd1Click
        end
        object butDelete1: TButton
          Left = 83
          Top = 14
          Width = 75
          Height = 25
          Caption = 'delete'
          TabOrder = 1
          OnClick = butDelete1Click
        end
      end
    end
  end
  object dsComputers: TDataSource
    DataSet = cdsComputers
    OnDataChange = dsComputersDataChange
    Left = 568
    Top = 168
  end
  object cdsComputers: TADODataSet
    FieldDefs = <
      item
        Name = 'chek'
        DataType = ftBoolean
      end
      item
        Name = 'id'
        DataType = ftInteger
      end
      item
        Name = 'number'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'group'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'client_type'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'ip'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'mac'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'snmp_password'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'mib_port'
        DataType = ftString
        Size = 80
      end
      item
        Name = 'ignore_offline'
        DataType = ftBoolean
      end>
    Parameters = <>
    StoreDefs = True
    Left = 600
    Top = 168
  end
end
