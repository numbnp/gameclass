object frameDiscounts: TframeDiscounts
  Left = 0
  Top = 0
  Width = 449
  Height = 409
  TabOrder = 0
  object gbOptions: TGroupBox
    Left = 0
    Top = 0
    Width = 449
    Height = 57
    Align = alTop
    Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
    TabOrder = 0
    object butGoAccounts: TButton
      Left = 94
      Top = 357
      Width = 115
      Height = 25
      Caption = #1059#1095#1077#1090#1085#1099#1077' '#1079#1072#1087#1080#1089#1080
      TabOrder = 0
      OnClick = butGoAccountsClick
    end
    object cbxDiscountAfterLimitDisabled: TCheckBox
      Left = 8
      Top = 17
      Width = 297
      Height = 17
      Caption = #1041#1083#1086#1082#1080#1088#1086#1074#1072#1090#1100' '#1089#1082#1080#1076#1082#1080', '#1077#1089#1083#1080' '#1073#1072#1083#1072#1085#1089' '#1086#1090#1088#1080#1094#1072#1090#1077#1083#1100#1085#1099#1081
      TabOrder = 1
      OnClick = cbxDiscountAfterLimitDisabledClick
    end
    object cbxDiscountForPacketsEnabled: TCheckBox
      Left = 8
      Top = 33
      Width = 297
      Height = 17
      Caption = #1055#1088#1080#1084#1077#1085#1103#1090#1100' '#1089#1082#1080#1076#1082#1080' '#1076#1083#1103' '#1087#1072#1082#1077#1090#1085#1099#1093' '#1090#1072#1088#1080#1092#1086#1074
      TabOrder = 2
      OnClick = cbxDiscountForPacketsEnabledClick
    end
  end
  object pnlDiscountsTable: TGroupBox
    Left = 0
    Top = 57
    Width = 449
    Height = 209
    Align = alTop
    Caption = #1058#1072#1073#1083#1080#1094#1072' '#1089#1082#1080#1076#1086#1082
    TabOrder = 1
    object lblDiscount: TLabel
      Left = 289
      Top = 66
      Width = 54
      Height = 13
      Caption = #1057#1082#1080#1076#1082#1072' (%)'
    end
    object lblSumma: TLabel
      Left = 289
      Top = 20
      Width = 49
      Height = 13
      Caption = #1057#1091#1084#1084#1072' ($)'
    end
    object editDiscount: TEdit
      Left = 289
      Top = 82
      Width = 96
      Height = 21
      TabOrder = 0
      OnChange = editDiscountChange
    end
    object grdDiscounts: TDBGridEh
      Left = 16
      Top = 23
      Width = 257
      Height = 138
      AutoFitColWidths = True
      DataSource = dsrcDiscounts
      FooterColor = clWindow
      FooterFont.Charset = DEFAULT_CHARSET
      FooterFont.Color = clWindowText
      FooterFont.Height = -11
      FooterFont.Name = 'MS Sans Serif'
      FooterFont.Style = []
      Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      VertScrollBar.VisibleMode = sbNeverShowEh
      FilterStringColor = clWindow
      OnCellClick = grdDiscountsCellClick
      Columns = <
        item
          EditButtons = <>
          FieldName = 'id'
          Footers = <>
          Visible = False
        end
        item
          EditButtons = <>
          FieldName = 'summary'
          Footers = <>
          Title.Caption = #1053#1072#1088#1072#1073#1086#1090#1072#1085#1086' ($)'
          Width = 125
        end
        item
          EditButtons = <>
          FieldName = 'discount'
          Footers = <>
          Title.Caption = #1057#1082#1080#1076#1082#1072' %'
          Width = 125
        end>
    end
    object editSumma: TEdit
      Left = 289
      Top = 36
      Width = 96
      Height = 21
      TabOrder = 2
      OnChange = editSummaChange
    end
    object butDiscountAdd: TButton
      Left = 190
      Top = 173
      Width = 75
      Height = 25
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      TabOrder = 3
      OnClick = butDiscountAddClick
    end
    object butDiscountUpdate: TButton
      Left = 270
      Top = 173
      Width = 75
      Height = 25
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      TabOrder = 4
      OnClick = butDiscountUpdateClick
    end
    object butDiscountDel: TButton
      Left = 350
      Top = 173
      Width = 75
      Height = 25
      Caption = #1059#1076#1072#1083#1080#1090#1100
      TabOrder = 5
      OnClick = butDiscountDelClick
    end
  end
  object pnlDiscountsRecalc: TGroupBox
    Left = 0
    Top = 266
    Width = 449
    Height = 47
    Align = alTop
    Caption = #1055#1077#1088#1077#1072#1089#1095#1077#1090' '#1085#1072#1088#1072#1073#1086#1090#1072#1085#1085#1099#1093' '#1091#1095#1077#1090#1085#1099#1084#1080' '#1079#1072#1087#1080#1089#1103#1084#1080' '#1089#1091#1084#1084
    TabOrder = 2
    object Label1: TLabel
      Left = 8
      Top = 20
      Width = 236
      Height = 13
      Caption = #1059#1095#1080#1090#1099#1074#1072#1090#1100' '#1090#1086#1083#1100#1082#1086' '#1076#1077#1085#1100#1075#1080', '#1087#1086#1090#1088#1072#1095#1077#1085#1085#1099#1077' '#1087#1086#1089#1083#1077
    end
    object dtpStart: TDateTimePicker
      Left = 256
      Top = 16
      Width = 81
      Height = 21
      Date = 39731.700485381950000000
      Time = 39731.700485381950000000
      TabOrder = 0
    end
    object Button1: TButton
      Left = 352
      Top = 14
      Width = 75
      Height = 25
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
      TabOrder = 1
      OnClick = Button1Click
    end
  end
  object dsrcDiscounts: TDataSource
    Left = 392
  end
end
