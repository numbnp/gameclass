object frameDiscounts: TframeDiscounts
  Left = 0
  Top = 0
  Width = 461
  Height = 354
  TabOrder = 0
  object pcDiscounts: TPageControl
    Left = 0
    Top = 0
    Width = 461
    Height = 354
    ActivePage = tabRefers
    Align = alClient
    TabOrder = 0
    object tabDiscount: TTabSheet
      Caption = 'tabDiscount'
      object gbOptions: TGroupBox
        Left = 0
        Top = 0
        Width = 453
        Height = 73
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
        Top = 73
        Width = 453
        Height = 152
        Align = alTop
        Caption = #1058#1072#1073#1083#1080#1094#1072' '#1089#1082#1080#1076#1086#1082
        TabOrder = 1
        object lblDiscount: TLabel
          Left = 246
          Top = 72
          Width = 54
          Height = 13
          Caption = #1057#1082#1080#1076#1082#1072' (%)'
        end
        object lblSumma: TLabel
          Left = 247
          Top = 24
          Width = 49
          Height = 13
          Caption = #1057#1091#1084#1084#1072' ($)'
        end
        object editDiscount: TEdit
          Left = 245
          Top = 91
          Width = 92
          Height = 21
          TabOrder = 0
          OnChange = editDiscountChange
        end
        object grdDiscounts: TDBGridEh
          Left = 16
          Top = 23
          Width = 217
          Height = 114
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
              Width = 106
            end
            item
              EditButtons = <>
              FieldName = 'discount'
              Footers = <>
              Title.Caption = #1057#1082#1080#1076#1082#1072' %'
              Width = 105
            end>
        end
        object editSumma: TEdit
          Left = 245
          Top = 43
          Width = 92
          Height = 21
          TabOrder = 2
          OnChange = editSummaChange
        end
        object butDiscountAdd: TButton
          Left = 358
          Top = 29
          Width = 75
          Height = 25
          Caption = #1044#1086#1073#1072#1074#1080#1090#1100
          TabOrder = 3
          OnClick = butDiscountAddClick
        end
        object butDiscountUpdate: TButton
          Left = 358
          Top = 93
          Width = 75
          Height = 25
          Caption = #1054#1073#1085#1086#1074#1080#1090#1100
          TabOrder = 4
          OnClick = butDiscountUpdateClick
        end
        object butDiscountDel: TButton
          Left = 358
          Top = 61
          Width = 75
          Height = 25
          Caption = #1059#1076#1072#1083#1080#1090#1100
          TabOrder = 5
          OnClick = butDiscountDelClick
        end
      end
      object pnlDiscountsRecalc: TGroupBox
        Left = 0
        Top = 225
        Width = 453
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
          Left = 264
          Top = 16
          Width = 81
          Height = 21
          Date = 39731.700485381950000000
          Time = 39731.700485381950000000
          TabOrder = 0
        end
        object Button1: TButton
          Left = 360
          Top = 14
          Width = 75
          Height = 25
          Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
          TabOrder = 1
          OnClick = Button1Click
        end
      end
    end
    object tabRefers: TTabSheet
      Caption = 'tabRefers'
      ImageIndex = 1
      object gbRefers: TGroupBox
        Left = 0
        Top = 0
        Width = 453
        Height = 326
        Align = alClient
        Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1088#1077#1092#1077#1088#1089#1082#1086#1081' '#1089#1080#1089#1090#1077#1084#1099
        TabOrder = 0
        object lblBonus: TLabel
          Left = 244
          Top = 89
          Width = 47
          Height = 13
          Caption = #1041#1086#1085#1091#1089' (%)'
        end
        object lblLevel: TLabel
          Left = 241
          Top = 41
          Width = 44
          Height = 13
          Caption = #1059#1088#1086#1074#1077#1085#1100
        end
        object butReferalsUpdate: TButton
          Left = 352
          Top = 108
          Width = 75
          Height = 25
          Caption = #1054#1073#1085#1086#1074#1080#1090#1100
          TabOrder = 0
          OnClick = butReferalsUpdateClick
        end
        object butReferalsDel: TButton
          Left = 352
          Top = 76
          Width = 75
          Height = 25
          Caption = #1059#1076#1072#1083#1080#1090#1100
          TabOrder = 1
          OnClick = butReferalsDelClick
        end
        object editLevel: TEdit
          Left = 239
          Top = 58
          Width = 92
          Height = 21
          TabOrder = 2
          OnChange = editLevelChange
        end
        object editBonus: TEdit
          Left = 239
          Top = 106
          Width = 92
          Height = 21
          TabOrder = 3
          OnChange = editBonusChange
        end
        object butReferalsAdd: TButton
          Left = 352
          Top = 44
          Width = 75
          Height = 25
          Caption = #1044#1086#1073#1072#1074#1080#1090#1100
          TabOrder = 4
          OnClick = butReferalsAddClick
        end
        object grdReferals: TDBGridEh
          Left = 9
          Top = 38
          Width = 217
          Height = 114
          AutoFitColWidths = True
          DataSource = dsrcReferals
          FooterColor = clWindow
          FooterFont.Charset = DEFAULT_CHARSET
          FooterFont.Color = clWindowText
          FooterFont.Height = -11
          FooterFont.Name = 'MS Sans Serif'
          FooterFont.Style = []
          Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
          TabOrder = 5
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          VertScrollBar.VisibleMode = sbNeverShowEh
          FilterStringColor = clWindow
          OnCellClick = grdReferalsCellClick
          Columns = <
            item
              EditButtons = <>
              FieldName = 'id'
              Footers = <>
              Visible = False
            end
            item
              EditButtons = <>
              FieldName = 'level'
              Footers = <>
              Title.Caption = #1059#1088#1086#1074#1077#1085#1100
              Width = 106
            end
            item
              EditButtons = <>
              FieldName = 'percent'
              Footers = <>
              Title.Caption = #1041#1086#1085#1091#1089' %'
              Width = 105
            end>
        end
      end
      object cbxUseRefers: TCheckBox
        Left = 9
        Top = 14
        Width = 208
        Height = 17
        Caption = #1048#1089#1087#1086#1083#1100#1079#1086#1074#1072#1090#1100' '#1088#1077#1092#1077#1088#1089#1082#1091#1102' '#1089#1080#1089#1090#1077#1084#1091
        TabOrder = 1
        OnClick = cbxUseRefersClick
      end
    end
  end
  object dsrcDiscounts: TDataSource
    Left = 392
  end
  object dsrcReferals: TDataSource
    Left = 360
  end
end
