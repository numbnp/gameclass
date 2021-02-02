object frFrame3_Options: TfrFrame3_Options
  Left = 0
  Top = 0
  Width = 614
  Height = 420
  TabOrder = 0
  object PaintBox2: TPaintBox
    Left = 112
    Top = 129
    Width = 146
    Height = 17
    OnPaint = PaintBox2Paint
  end
  object Label2: TLabel
    Left = 19
    Top = 128
    Width = 72
    Height = 13
    Caption = 'Holydays  color'
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 614
    Height = 36
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object PaintBox1: TPaintBox
      Left = 0
      Top = 0
      Width = 614
      Height = 36
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      OnPaint = PaintBox1Paint
    end
    object Label1: TLabel
      Left = 19
      Top = 7
      Width = 75
      Height = 23
      Caption = 'Options'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object DBCheckBoxEh1: TDBCheckBoxEh
    Left = 19
    Top = 56
    Width = 134
    Height = 17
    Caption = 'Highlight weekend'
    DynProps = <>
    TabOrder = 1
    OnClick = DBCheckBoxEh1Click
  end
  object DBCheckBoxEh2: TDBCheckBoxEh
    Left = 19
    Top = 88
    Width = 110
    Height = 17
    Caption = 'Highlight holidays'
    DynProps = <>
    TabOrder = 2
    OnClick = DBCheckBoxEh2Click
  end
  object cbxCountryCode: TDBComboBoxEh
    Left = 336
    Top = 86
    Width = 121
    Height = 21
    ControlLabel.Width = 78
    ControlLabel.Height = 13
    ControlLabel.Caption = 'Holidays country'
    ControlLabel.Visible = True
    ControlLabelLocation.Spacing = 10
    ControlLabelLocation.Position = lpLeftTextBaselineEh
    DynProps = <>
    EditButtons = <>
    Items.Strings = (
      'US'
      'FR')
    KeyItems.Strings = (
      'US'
      'FR')
    TabOrder = 3
    Text = 'US'
    Visible = True
    OnChange = cbxCountryCodeChange
  end
  object cbxXEStyle: TDBComboBoxEh
    Left = 119
    Top = 164
    Width = 139
    Height = 21
    ControlLabel.Width = 40
    ControlLabel.Height = 13
    ControlLabel.Caption = 'XE Style'
    ControlLabel.Visible = True
    ControlLabelLocation.LabelSpacingBound = sbFarBoundEh
    ControlLabelLocation.Spacing = 100
    ControlLabelLocation.Position = lpLeftTextBaselineEh
    DynProps = <>
    DropDownBox.Rows = 20
    EditButtons = <>
    TabOrder = 4
    Text = 'DBComboBoxEh1'
    Visible = True
    OnChange = cbxXEStyleChange
  end
  object Button1: TButton
    Left = 264
    Top = 126
    Width = 57
    Height = 20
    Caption = '...'
    TabOrder = 5
    OnClick = Button1Click
  end
  object ColorDialog1: TColorDialog
    Left = 344
    Top = 120
  end
end
