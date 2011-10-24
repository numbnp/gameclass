object frmSettings: TfrmSettings
  Left = 376
  Top = 252
  BorderStyle = bsDialog
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
  ClientHeight = 450
  ClientWidth = 563
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBottom: TPanel
    Left = 0
    Top = 409
    Width = 563
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      563
      41)
    object btnApply: TButton
      Left = 479
      Top = 9
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #1055#1088#1080#1085#1103#1090#1100
      Enabled = False
      TabOrder = 0
      OnClick = btnApplyClick
    end
    object btnOk: TButton
      Left = 303
      Top = 9
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #1054#1082
      TabOrder = 1
      OnClick = btnOkClick
    end
    object btnCancel: TButton
      Left = 391
      Top = 9
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = #1054#1090#1084#1077#1085#1072
      TabOrder = 2
      OnClick = btnCancelClick
    end
  end
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 563
    Height = 350
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object pnlRight: TPanel
      Left = 312
      Top = 0
      Width = 251
      Height = 350
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object pnlFree: TGroupBox
        Left = 0
        Top = 0
        Width = 251
        Height = 350
        Align = alClient
        Caption = #1058#1072#1073#1083#1080#1094#1072' "'#1054#1089#1074#1086#1073#1086#1078#1076#1077#1085#1080#1077'"'
        TabOrder = 0
        object pnlOnlyOneTimeColumnVisible: TGroupBox
          Left = 2
          Top = 104
          Width = 247
          Height = 244
          Align = alClient
          Caption = #1055#1088#1080' '#1086#1076#1085#1086#1081' '#1074#1099#1073#1088#1072#1085#1085#1086#1081' '#1082#1086#1083#1086#1085#1082#1077
          TabOrder = 0
          object cbxTime: TCheckBox
            Left = 16
            Top = 24
            Width = 169
            Height = 17
            Caption = #1074#1088#1077#1084#1103' '#1086#1089#1074#1086#1073#1086#1078#1076#1077#1085#1080#1103
            TabOrder = 0
            OnClick = _ControlValueChange
          end
          object edtSecondColumnTitle: TEdit
            Left = 40
            Top = 128
            Width = 121
            Height = 21
            TabOrder = 1
            OnChange = _ControlValueChange
          end
          object edtFirstColumnTitle: TEdit
            Left = 40
            Top = 72
            Width = 121
            Height = 21
            TabOrder = 2
            OnChange = _ControlValueChange
          end
          object cbxCustomSecondColumnTitle: TCheckBox
            Left = 16
            Top = 104
            Width = 185
            Height = 17
            Caption = #1089#1084#1077#1085#1080#1090#1100' '#1085#1072#1079#1074#1072#1085#1080#1077' 2'#1081' '#1082#1086#1083#1086#1085#1082#1080
            TabOrder = 3
            OnClick = _ControlValueChange
          end
          object cbxCustomFirstColumnTitle: TCheckBox
            Left = 16
            Top = 48
            Width = 193
            Height = 17
            Caption = #1089#1084#1077#1085#1080#1090#1100' '#1085#1072#1079#1074#1072#1085#1080#1077' 1'#1081' '#1082#1086#1083#1086#1085#1082#1080
            TabOrder = 4
            OnClick = _ControlValueChange
          end
        end
        object pnlReleaseColumns: TGroupBox
          Left = 2
          Top = 15
          Width = 247
          Height = 89
          Align = alTop
          Caption = #1050#1086#1083#1086#1085#1082#1080
          TabOrder = 1
          object cbxTime05: TCheckBox
            Left = 16
            Top = 16
            Width = 81
            Height = 17
            Caption = #1085#1072' 30 '#1084#1080#1085'.'
            TabOrder = 0
            OnClick = _ControlValueChange
          end
          object cbxTime4: TCheckBox
            Left = 112
            Top = 64
            Width = 81
            Height = 17
            Caption = #1085#1072' 4 '#1095#1072#1089#1072
            TabOrder = 1
            OnClick = _ControlValueChange
          end
          object cbxTime3: TCheckBox
            Left = 16
            Top = 64
            Width = 81
            Height = 17
            Caption = #1085#1072' 3 '#1095#1072#1089#1072
            TabOrder = 2
            OnClick = _ControlValueChange
          end
          object cbxTime2: TCheckBox
            Left = 112
            Top = 40
            Width = 81
            Height = 17
            Caption = #1085#1072' 2 '#1095#1072#1089#1072
            TabOrder = 3
            OnClick = _ControlValueChange
          end
          object cbxTime15: TCheckBox
            Left = 16
            Top = 40
            Width = 81
            Height = 17
            Caption = #1085#1072' 1.5 '#1095#1072#1089#1072
            TabOrder = 4
            OnClick = _ControlValueChange
          end
          object cbxTime1: TCheckBox
            Left = 112
            Top = 16
            Width = 81
            Height = 17
            Caption = #1085#1072' 1 '#1095#1072#1089
            TabOrder = 5
            OnClick = _ControlValueChange
          end
        end
      end
    end
    object pnlLeft: TPanel
      Left = 0
      Top = 0
      Width = 312
      Height = 350
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object pnlTime: TGroupBox
        Left = 0
        Top = 121
        Width = 312
        Height = 167
        Align = alClient
        Caption = #1058#1072#1073#1083#1080#1094#1072' "'#1050#1086#1084#1087#1100#1102#1090#1077#1088#1099'"'
        TabOrder = 0
        object lblBusyLimitMin: TLabel
          Left = 16
          Top = 19
          Width = 208
          Height = 13
          Caption = #1042#1088#1077#1084#1103' '#1073#1083#1080#1078#1072#1081#1096#1077#1075#1086' '#1086#1089#1074#1086#1073#1086#1078#1076#1077#1085#1080#1103' ('#1084#1080#1085'.)'
        end
        object Label1: TLabel
          Left = 16
          Top = 112
          Width = 107
          Height = 13
          Caption = #1057#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100' '#1089#1087#1080#1089#1086#1082':'
        end
        object edtBusyLimitMin: TEdit
          Left = 240
          Top = 16
          Width = 33
          Height = 21
          TabOrder = 0
          Text = '10'
          OnChange = _ControlValueChange
        end
        object cbxMarkBusyLimited: TCheckBox
          Left = 16
          Top = 40
          Width = 249
          Height = 17
          Caption = #1042#1099#1076#1077#1083#1103#1090#1100' '#1086#1089#1074#1086#1073#1086#1078#1076#1072#1102#1097#1080#1077#1089#1103' '#1082#1086#1084#1087#1100#1090#1077#1088#1099
          TabOrder = 1
          OnClick = _ControlValueChange
        end
        object cbxMarkFreeLimited: TCheckBox
          Left = 16
          Top = 64
          Width = 249
          Height = 17
          Caption = #1042#1099#1076#1077#1083#1103#1090#1100' '#1079#1072#1073#1088#1086#1085#1080#1088#1086#1074#1072#1085#1085#1099#1077' '#1082#1086#1084#1087#1100#1102#1090#1077#1088#1099
          TabOrder = 2
          OnClick = _ControlValueChange
        end
        object cbxUseLargeIcons: TCheckBox
          Left = 16
          Top = 88
          Width = 249
          Height = 17
          Caption = #1048#1089#1087#1086#1083#1100#1079#1086#1074#1072#1090#1100' '#1080#1082#1086#1085#1082#1080' '#1082#1086#1084#1087#1100#1102#1090#1077#1088#1086#1074
          TabOrder = 3
          OnClick = _ControlValueChange
        end
        object rbtnSortByState: TRadioButton
          Left = 136
          Top = 128
          Width = 113
          Height = 17
          Caption = #1087#1086' '#1089#1086#1089#1090#1086#1103#1085#1080#1102
          TabOrder = 4
          OnClick = _ControlValueChange
        end
        object rbtnSortByNumber: TRadioButton
          Left = 136
          Top = 112
          Width = 113
          Height = 17
          Caption = #1087#1086' '#1085#1086#1084#1077#1088#1091
          TabOrder = 5
          OnClick = _ControlValueChange
        end
      end
      object pnlPassword: TGroupBox
        Left = 0
        Top = 0
        Width = 312
        Height = 72
        Align = alTop
        Caption = #1055#1072#1088#1086#1083#1100' '#1088#1072#1079#1073#1083#1086#1082#1080#1088#1086#1074#1072#1085#1080#1103
        TabOrder = 1
        object lblPassword: TLabel
          Left = 16
          Top = 17
          Width = 38
          Height = 13
          Caption = #1055#1072#1088#1086#1083#1100
        end
        object lblConfirmation: TLabel
          Left = 16
          Top = 41
          Width = 81
          Height = 13
          Caption = #1055#1086#1076#1090#1074#1077#1088#1078#1076#1077#1085#1080#1077
        end
        object edtPassword: TEdit
          Left = 120
          Top = 16
          Width = 153
          Height = 20
          Font.Charset = SYMBOL_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Wingdings'
          Font.Style = []
          ParentFont = False
          PasswordChar = 'l'
          TabOrder = 0
          Text = 'fgh'
          OnChange = _ControlValueChange
        end
        object edtConfirmation: TEdit
          Left = 120
          Top = 40
          Width = 153
          Height = 20
          Font.Charset = SYMBOL_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Wingdings'
          Font.Style = []
          ParentFont = False
          PasswordChar = 'l'
          TabOrder = 1
          Text = #1099#1074#1074
          OnChange = _ControlValueChange
        end
      end
      object pnlTimeSettings: TGroupBox
        Left = 0
        Top = 72
        Width = 312
        Height = 49
        Align = alTop
        Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1091#1095#1077#1090#1072' '#1089#1074#1086#1073#1086#1076#1085#1086#1075#1086' '#1074#1088#1077#1084#1077#1085#1080
        TabOrder = 2
        object lblSpaceLimitMin: TLabel
          Left = 16
          Top = 19
          Width = 138
          Height = 13
          Caption = #1052#1080#1085#1080#1084#1072#1083#1100#1085#1086#1077' '#1074#1088#1077#1084#1103' ('#1084#1080#1085'.)'
        end
        object edtSpaceLimitMin: TEdit
          Left = 240
          Top = 16
          Width = 33
          Height = 21
          TabOrder = 0
          Text = '10'
          OnChange = _ControlValueChange
        end
      end
      object pnlOther: TGroupBox
        Left = 0
        Top = 288
        Width = 312
        Height = 62
        Align = alBottom
        Caption = #1056#1072#1079#1085#1086#1077
        TabOrder = 3
        object cbxShowTime: TCheckBox
          Left = 16
          Top = 17
          Width = 201
          Height = 17
          Caption = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1074#1088#1077#1084#1103
          TabOrder = 0
          OnClick = _ControlValueChange
        end
        object cbxShowToolBar: TCheckBox
          Left = 16
          Top = 37
          Width = 201
          Height = 17
          Caption = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1087#1072#1085#1077#1083#1100' '#1080#1085#1089#1090#1088#1091#1084#1077#1085#1090#1086#1074
          TabOrder = 1
          OnClick = _ControlValueChange
        end
      end
    end
  end
  object pnlMiddle: TPanel
    Left = 0
    Top = 350
    Width = 563
    Height = 59
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object pnlTable: TGroupBox
      Left = 0
      Top = 0
      Width = 563
      Height = 59
      Align = alClient
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1090#1072#1073#1083#1080#1094
      TabOrder = 0
      object lblFont: TLabel
        Left = 16
        Top = 20
        Width = 34
        Height = 13
        Caption = #1064#1088#1080#1092#1090
      end
      object btnFontChange: TButton
        Left = 352
        Top = 16
        Width = 75
        Height = 25
        Caption = #1048#1079#1084#1077#1085#1080#1090#1100
        TabOrder = 0
        OnClick = btnFontChangeClick
      end
      object edtFont: TEdit
        Left = 64
        Top = 17
        Width = 273
        Height = 21
        ReadOnly = True
        TabOrder = 1
      end
    end
  end
  object FontDialog: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = []
    Left = 48
    Top = 16
  end
  object ColorDialog: TColorDialog
    Left = 16
    Top = 16
  end
end
