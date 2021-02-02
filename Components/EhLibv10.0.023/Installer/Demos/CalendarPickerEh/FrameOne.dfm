object frFrameOne: TfrFrameOne
  Left = 0
  Top = 0
  Width = 551
  Height = 392
  TabOrder = 0
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 551
    Height = 36
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object PaintBox1: TPaintBox
      Left = 0
      Top = 0
      Width = 551
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
      Left = 11
      Top = 7
      Width = 254
      Height = 23
      Caption = 'DBDateTimeEditEh control'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object DBDateTimeEditEh1: TDBDateTimeEditEh
    Left = 310
    Top = 70
    Width = 158
    Height = 21
    ControlLabel.Width = 213
    ControlLabel.Height = 13
    ControlLabel.Caption = 'DBDateTimeEditEh (Full Date + Time Format)'
    ControlLabel.Transparent = True
    ControlLabel.Visible = True
    ControlLabelLocation.LabelSpacingBound = sbFarBoundEh
    ControlLabelLocation.Spacing = 300
    ControlLabelLocation.Position = lpLeftCenterEh
    DynProps = <>
    EditButtons = <>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Kind = dtkDateTimeEh
    ParentFont = False
    TabOrder = 1
    Value = 42379d
    Visible = True
  end
  object DBDateTimeEditEh2: TDBDateTimeEditEh
    Left = 310
    Top = 108
    Width = 158
    Height = 21
    ControlLabel.Width = 159
    ControlLabel.Height = 13
    ControlLabel.Caption = 'DBDateTimeEditEh (Date Format)'
    ControlLabel.Transparent = True
    ControlLabel.Visible = True
    ControlLabelLocation.LabelSpacingBound = sbFarBoundEh
    ControlLabelLocation.Spacing = 300
    ControlLabelLocation.Position = lpLeftCenterEh
    DynProps = <>
    EditButtons = <>
    Kind = dtkDateEh
    TabOrder = 2
    Value = 42379d
    Visible = True
  end
  object DBDateTimeEditEh6: TDBDateTimeEditEh
    Left = 310
    Top = 146
    Width = 158
    Height = 21
    ControlLabel.Width = 193
    ControlLabel.Height = 13
    ControlLabel.Caption = 'DBDateTimeEditEh (Year/Month Format)'
    ControlLabel.Transparent = True
    ControlLabel.Visible = True
    ControlLabelLocation.LabelSpacingBound = sbFarBoundEh
    ControlLabelLocation.Spacing = 300
    ControlLabelLocation.Position = lpLeftCenterEh
    DynProps = <>
    EditButtons = <>
    TabOrder = 3
    Value = 42391d
    Visible = True
    EditFormat = 'MM/YYYY'
  end
  object DBDateTimeEditEh3: TDBDateTimeEditEh
    Left = 310
    Top = 184
    Width = 158
    Height = 21
    ControlLabel.Width = 159
    ControlLabel.Height = 13
    ControlLabel.Caption = 'DBDateTimeEditEh (Time Format)'
    ControlLabel.Transparent = True
    ControlLabel.Visible = True
    ControlLabelLocation.LabelSpacingBound = sbFarBoundEh
    ControlLabelLocation.Spacing = 300
    ControlLabelLocation.Position = lpLeftCenterEh
    DynProps = <>
    EditButtons = <>
    Kind = dtkTimeEh
    TabOrder = 4
    Value = 2d
    Visible = True
  end
  object DBDateTimeEditEh4: TDBDateTimeEditEh
    Left = 310
    Top = 222
    Width = 158
    Height = 21
    ControlLabel.Width = 179
    ControlLabel.Height = 13
    ControlLabel.Caption = 'DBDateTimeEditEh (Hour:Min Format)'
    ControlLabel.Transparent = True
    ControlLabel.Visible = True
    ControlLabelLocation.LabelSpacingBound = sbFarBoundEh
    ControlLabelLocation.Spacing = 300
    ControlLabelLocation.Position = lpLeftCenterEh
    DynProps = <>
    EditButtons = <>
    TabOrder = 5
    Value = 2d
    Visible = True
    EditFormat = 'HH:NN'
  end
  object DBDateTimeEditEh5: TDBDateTimeEditEh
    Left = 310
    Top = 260
    Width = 158
    Height = 21
    ControlLabel.Width = 214
    ControlLabel.Height = 13
    ControlLabel.Caption = 'DBDateTimeEditEh (Date + Hour:Min Format)'
    ControlLabel.Transparent = True
    ControlLabel.Visible = True
    ControlLabelLocation.LabelSpacingBound = sbFarBoundEh
    ControlLabelLocation.Spacing = 300
    ControlLabelLocation.Position = lpLeftCenterEh
    DynProps = <>
    EditButtons = <>
    TabOrder = 6
    Value = 42379d
    Visible = True
    EditFormat = 'DD/MM/YYYY HH:NN'
  end
  object DBDateTimeEditEh7: TDBDateTimeEditEh
    Left = 310
    Top = 298
    Width = 158
    Height = 21
    ControlLabel.Width = 159
    ControlLabel.Height = 13
    ControlLabel.Caption = 'DBDateTimeEditEh (Date + Hour)'
    ControlLabel.Transparent = True
    ControlLabel.Visible = True
    ControlLabelLocation.LabelSpacingBound = sbFarBoundEh
    ControlLabelLocation.Spacing = 300
    ControlLabelLocation.Position = lpLeftCenterEh
    DynProps = <>
    EditButtons = <>
    TabOrder = 7
    Value = 42379d
    Visible = True
    EditFormat = 'DD/MM/YYYY HH'
  end
  object DBDateTimeEditEh8: TDBDateTimeEditEh
    Left = 310
    Top = 337
    Width = 224
    Height = 33
    ControlLabel.Width = 155
    ControlLabel.Height = 16
    ControlLabel.Caption = 'DBDateTimeEditEh Big Font'
    ControlLabel.Font.Charset = DEFAULT_CHARSET
    ControlLabel.Font.Color = clWindowText
    ControlLabel.Font.Height = -13
    ControlLabel.Font.Name = 'Tahoma'
    ControlLabel.Font.Style = []
    ControlLabel.ParentFont = False
    ControlLabel.Transparent = True
    ControlLabel.Visible = True
    ControlLabelLocation.LabelSpacingBound = sbFarBoundEh
    ControlLabelLocation.Spacing = 300
    ControlLabelLocation.Position = lpLeftCenterEh
    DynProps = <>
    EditButton.Width = 20
    EditButtons = <>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    Kind = dtkDateTimeEh
    ParentFont = False
    TabOrder = 8
    Value = 42379d
    Visible = True
  end
end
