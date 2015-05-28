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
    ActivePage = tabComputers
    Align = alClient
    MultiLine = True
    TabOrder = 0
    object tabGroups: TTabSheet
      Caption = #1043#1088#1091#1087#1087#1099
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
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
        DataSource = dsComputers
        DynProps = <>
        Flat = True
        FooterParams.Color = clWindow
        IndicatorOptions = []
        Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        TabOrder = 0
        OnColExit = gridComputersColExit
        OnExit = gridComputersExit
        Columns = <
          item
            Checkboxes = True
            DynProps = <>
            EditButtons = <>
            FieldName = 'chek'
            Footers = <>
            Width = 16
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'number'
            Footers = <>
            Title.Caption = 'Number'
            Width = 45
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'group'
            Footers = <>
            Title.Caption = 'Group'
            Width = 88
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'client_type'
            Footers = <>
            PickList.Strings = (
              'GameClass'
              'SNMP')
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'ip'
            Footers = <>
            Title.Caption = 'IP'
            Width = 106
          end
          item
            ButtonStyle = cbsEllipsis
            DynProps = <>
            EditButton.Style = ebsEllipsisEh
            EditButton.Visible = True
            EditButtons = <>
            FieldName = 'mac'
            Footers = <>
            Title.Caption = 'MAC'
            Width = 104
            OnEditButtonClick = gridComputersColumns3EditButtonClick
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'snmp_password'
            Footers = <>
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'mib_port'
            Footers = <>
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'on_val'
            Footers = <>
            Width = 30
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'off_val'
            Footers = <>
          end
          item
            Checkboxes = True
            DynProps = <>
            EditButtons = <>
            FieldName = 'ignore_offline'
            Footers = <>
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
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
      end
      item
        Name = 'on_val'
        DataType = ftInteger
      end
      item
        Name = 'off_val'
        DataType = ftInteger
      end>
    Parameters = <>
    StoreDefs = True
    Left = 600
    Top = 168
  end
end
