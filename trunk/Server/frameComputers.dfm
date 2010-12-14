object framComputers: TframComputers
  Left = 0
  Top = 0
  Width = 449
  Height = 430
  TabOrder = 0
  object lvComps: TListView
    Left = 0
    Top = 41
    Width = 449
    Height = 303
    Align = alClient
    Columns = <
      item
        Caption = 'Number'
        Width = 60
      end
      item
        Caption = 'IP addr'
        Width = 110
      end
      item
        Caption = 'Group'
        Width = 130
      end
      item
        Caption = 'MAC addr'
        Width = 130
      end>
    HideSelection = False
    ReadOnly = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
    OnClick = lvCompsClick
  end
  object gbEditor: TGroupBox
    Left = 0
    Top = 344
    Width = 449
    Height = 86
    Align = alBottom
    TabOrder = 1
    object lblIPaddr: TLabel
      Left = 61
      Top = 11
      Width = 50
      Height = 13
      Caption = 'IP address'
    end
    object lblNumber: TLabel
      Left = 8
      Top = 11
      Width = 37
      Height = 13
      Caption = 'Number'
    end
    object lblGroup: TLabel
      Left = 170
      Top = 11
      Width = 29
      Height = 13
      Caption = 'Group'
    end
    object lblMAC: TLabel
      Left = 292
      Top = 11
      Width = 63
      Height = 13
      Caption = 'MAC address'
    end
    object SpeedButton1: TSpeedButton
      Left = 408
      Top = 24
      Width = 33
      Height = 25
      Caption = '>>>'
      OnClick = SpeedButton1Click
    end
    object editIPaddr: TEdit
      Left = 61
      Top = 27
      Width = 100
      Height = 21
      TabOrder = 0
      OnChange = editNumberChange
    end
    object editNumber: TEdit
      Left = 8
      Top = 27
      Width = 49
      Height = 21
      TabOrder = 1
      OnChange = editNumberChange
    end
    object butAdd: TButton
      Left = 205
      Top = 54
      Width = 75
      Height = 25
      Caption = 'add'
      Enabled = False
      TabOrder = 2
      OnClick = butAddClick
    end
    object butUpdate: TButton
      Left = 286
      Top = 54
      Width = 75
      Height = 25
      Caption = 'update'
      Enabled = False
      TabOrder = 3
      OnClick = butUpdateClick
    end
    object butDelete: TButton
      Left = 367
      Top = 54
      Width = 75
      Height = 25
      Caption = 'delete'
      TabOrder = 4
      OnClick = butDeleteClick
    end
    object cbGroup: TComboBox
      Left = 166
      Top = 27
      Width = 117
      Height = 21
      AutoComplete = False
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 5
      OnSelect = editNumberChange
    end
    object editMAC: TEdit
      Left = 288
      Top = 27
      Width = 121
      Height = 21
      TabOrder = 6
    end
  end
  object pnGroups: TPanel
    Left = 0
    Top = 0
    Width = 449
    Height = 41
    Align = alTop
    TabOrder = 2
    object butGroupAdd: TButton
      Left = 201
      Top = 8
      Width = 75
      Height = 25
      Caption = 'add'
      TabOrder = 0
      OnClick = butGroupAddClick
    end
    object butGroupUpdate: TButton
      Left = 282
      Top = 8
      Width = 75
      Height = 25
      Caption = 'update'
      Enabled = False
      TabOrder = 1
      OnClick = butGroupUpdateClick
    end
    object butGroupDelete: TButton
      Left = 363
      Top = 8
      Width = 75
      Height = 25
      Caption = 'delete'
      TabOrder = 2
      OnClick = butGroupDeleteClick
    end
    object cbGroups: TComboBox
      Left = 11
      Top = 8
      Width = 150
      Height = 21
      AutoComplete = False
      ItemHeight = 13
      TabOrder = 3
      Text = 'ComputerGroups'
      OnChange = cbGroupsChange
      OnSelect = cbGroupsSelect
    end
  end
end
