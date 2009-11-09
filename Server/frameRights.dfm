object framRights: TframRights
  Left = 0
  Top = 0
  Width = 449
  Height = 409
  TabOrder = 0
  object lblDescription: TLabel
    Left = 4
    Top = 278
    Width = 53
    Height = 13
    Caption = 'Description'
  end
  object lvRights: TListView
    Left = 0
    Top = 0
    Width = 449
    Height = 273
    Align = alTop
    Columns = <
      item
        Caption = 'Function'
        Width = 300
      end
      item
        Alignment = taCenter
        Caption = 'Staff'
        Width = 61
      end
      item
        Alignment = taCenter
        Caption = 'Tech'
        Width = 61
      end
      item
        Alignment = taCenter
        Caption = 'Management'
        Width = 0
      end>
    HideSelection = False
    ReadOnly = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
    OnClick = lvRightsClick
    OnMouseDown = lvRightsMouseDown
    OnSelectItem = lvRightsSelectItem
  end
  object memoInfoFunction: TMemo
    Left = 0
    Top = 292
    Width = 449
    Height = 66
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object cbOperators: TCheckBox
    Left = 0
    Top = 362
    Width = 97
    Height = 17
    Caption = 'Staff'
    TabOrder = 2
    OnClick = cbOperatorsClick
  end
  object cbAdmins: TCheckBox
    Left = 0
    Top = 378
    Width = 97
    Height = 15
    Caption = 'Tech'
    TabOrder = 3
    OnClick = cbAdminsClick
  end
  object cbBosses: TCheckBox
    Left = 0
    Top = 392
    Width = 97
    Height = 17
    Caption = 'Management'
    Enabled = False
    TabOrder = 4
    OnClick = cbBossesClick
  end
end
