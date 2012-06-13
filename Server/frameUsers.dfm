object framUsers: TframUsers
  Left = 0
  Top = 0
  Width = 460
  Height = 522
  TabOrder = 0
  object lvUsers: TListView
    Left = 0
    Top = 0
    Width = 460
    Height = 273
    Align = alTop
    Columns = <
      item
        Caption = 'Login'
        Width = 150
      end
      item
        AutoSize = True
        Caption = 'Group'
      end
      item
        Caption = 'SecLevel'
        Width = 120
      end>
    HideSelection = False
    ReadOnly = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
    OnClick = lvUsersClick
  end
  object gbEditor: TGroupBox
    Left = 0
    Top = 275
    Width = 450
    Height = 134
    TabOrder = 1
    object lblGroup: TLabel
      Left = 7
      Top = 49
      Width = 29
      Height = 13
      Caption = 'Group'
    end
    object lblLogin: TLabel
      Left = 8
      Top = 9
      Width = 26
      Height = 13
      Caption = 'Login'
    end
    object lblRepeatPassword: TLabel
      Left = 166
      Top = 51
      Width = 93
      Height = 13
      Caption = #1055#1086#1074#1090#1086#1088#1080#1090#1077' '#1087#1072#1088#1086#1083#1100
    end
    object lblPassword: TLabel
      Left = 166
      Top = 11
      Width = 38
      Height = 13
      Caption = #1055#1072#1088#1086#1083#1100
    end
    object lblSecLevel: TLabel
      Left = 7
      Top = 89
      Width = 45
      Height = 13
      Caption = 'SecLevel'
    end
    object editLogin: TEdit
      Left = 8
      Top = 26
      Width = 132
      Height = 21
      TabOrder = 0
      OnChange = editLoginChange
    end
    object cmbGroups: TComboBox
      Left = 7
      Top = 65
      Width = 136
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 1
    end
    object editPassRepeate: TEdit
      Left = 166
      Top = 66
      Width = 177
      Height = 20
      Font.Charset = SYMBOL_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Wingdings'
      Font.Style = []
      ParentFont = False
      PasswordChar = 'l'
      TabOrder = 3
      OnChange = editPassRepeateChange
    end
    object editPass: TEdit
      Left = 166
      Top = 26
      Width = 177
      Height = 20
      Font.Charset = SYMBOL_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Wingdings'
      Font.Style = []
      ParentFont = False
      PasswordChar = 'l'
      TabOrder = 2
      OnChange = editPassChange
    end
    object cmbSecLevel: TComboBox
      Left = 7
      Top = 105
      Width = 136
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 4
      Text = '1'
      OnChange = cmbSecLevelChange
      Items.Strings = (
        '1'
        '2'
        '3'
        '4'
        '5'
        '6'
        '7'
        '8'
        '9'
        '10')
    end
  end
  object butAdd: TButton
    Left = 293
    Top = 416
    Width = 75
    Height = 25
    Caption = 'add'
    TabOrder = 3
    OnClick = butAddClick
  end
  object butDelete: TButton
    Left = 375
    Top = 416
    Width = 75
    Height = 25
    Caption = 'delete'
    TabOrder = 4
    OnClick = butDeleteClick
  end
  object butChangePass: TButton
    Left = 166
    Top = 416
    Width = 121
    Height = 25
    Caption = 'change pass'
    TabOrder = 2
    OnClick = butChangePassClick
  end
end
