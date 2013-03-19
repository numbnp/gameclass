object frameAditionalHardware: TframeAditionalHardware
  Left = 0
  Top = 0
  Width = 965
  Height = 685
  TabOrder = 0
  object pageCardReaders: TPageControl
    Left = 0
    Top = 0
    Width = 965
    Height = 685
    Align = alClient
    TabOrder = 0
  end
  object pnlCardReaders: TPanel
    Left = 0
    Top = 0
    Width = 965
    Height = 685
    Align = alClient
    TabOrder = 1
    object gbCardReaders: TGroupBox
      Left = 4
      Top = 8
      Width = 421
      Height = 129
      TabOrder = 0
      object lblPort: TLabel
        Left = 8
        Top = 21
        Width = 22
        Height = 13
        Caption = 'Port:'
      end
      object cbPort: TComboBox
        Left = 92
        Top = 17
        Width = 101
        Height = 21
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 0
        Text = 'COM1'
        OnChange = cbPortChange
        Items.Strings = (
          'COM1')
      end
      object butTest: TButton
        Left = 200
        Top = 16
        Width = 75
        Height = 21
        Caption = 'Test'
        TabOrder = 1
        OnClick = butTestClick
      end
    end
    object cbxEnableCardReaders: TCheckBox
      Left = 12
      Top = 4
      Width = 189
      Height = 17
      Caption = #1040#1082#1090#1080#1074#1080#1088#1086#1074#1072#1090#1100' '#1089#1095#1080#1090#1099#1074#1072#1090#1077#1083#1100' '#1082#1072#1088#1090
      TabOrder = 1
      OnClick = cbxEnableCardReadersClick
    end
  end
end
