object framSideline: TframSideline
  Left = 0
  Top = 0
  Width = 449
  Height = 305
  TabOrder = 0
  object gbService: TGroupBox
    Left = 0
    Top = 0
    Width = 449
    Height = 230
    Align = alClient
    Caption = #1057#1087#1080#1089#1086#1082' '#1091#1089#1083#1091#1075
    TabOrder = 0
    object lvSideline: TListView
      Left = 2
      Top = 15
      Width = 445
      Height = 129
      Align = alClient
      Columns = <
        item
          Caption = 'Goods'
          Width = 240
        end
        item
          AutoSize = True
          Caption = 'Price'
        end
        item
          Caption = 'Code'
        end>
      HideSelection = False
      ReadOnly = True
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
      OnClick = lvSidelineClick
    end
    object panelBottom: TPanel
      Left = 2
      Top = 144
      Width = 445
      Height = 84
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      object lblPrice: TLabel
        Left = 329
        Top = 4
        Width = 24
        Height = 13
        Caption = 'Price'
      end
      object lblGoods: TLabel
        Left = 12
        Top = 4
        Width = 31
        Height = 13
        Caption = 'Goods'
      end
      object butAdd: TButton
        Left = 205
        Top = 52
        Width = 75
        Height = 25
        Caption = 'Add'
        TabOrder = 0
        OnClick = butAddClick
      end
      object butDelete: TButton
        Left = 366
        Top = 52
        Width = 75
        Height = 25
        Caption = 'Delete'
        TabOrder = 1
        OnClick = butDeleteClick
      end
      object butUpdate: TButton
        Left = 285
        Top = 52
        Width = 75
        Height = 25
        Caption = 'Update'
        TabOrder = 2
        OnClick = butUpdateClick
      end
      object editGoods: TEdit
        Left = 11
        Top = 20
        Width = 302
        Height = 21
        TabOrder = 3
        OnChange = editGoodsChange
      end
      object editPrice: TEdit
        Left = 324
        Top = 20
        Width = 109
        Height = 21
        TabOrder = 4
        OnChange = editPriceChange
      end
    end
  end
  object gbServiceOptions: TGroupBox
    Left = 0
    Top = 230
    Width = 449
    Height = 75
    Align = alBottom
    Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
    TabOrder = 1
    object cbxServiceByPrepay: TCheckBox
      Left = 8
      Top = 16
      Width = 281
      Height = 17
      Caption = #1056#1072#1079#1088#1077#1096#1072#1090#1100' '#1074#1082#1083#1102#1095#1072#1090#1100' '#1091#1089#1083#1091#1075#1080' '#1074' '#1089#1090#1086#1080#1084#1086#1089#1090#1100' '#1089#1077#1072#1085#1089#1072
      TabOrder = 0
      OnClick = cbxServiceByPrepayClick
    end
    object cbxServiceByPostpay: TCheckBox
      Left = 8
      Top = 32
      Width = 361
      Height = 17
      Caption = #1056#1072#1079#1088#1077#1096#1072#1090#1100' '#1074#1082#1083#1102#1095#1072#1090#1100' '#1091#1089#1083#1091#1075#1080' '#1074' '#1089#1090#1086#1080#1084#1086#1089#1090#1100' '#1089#1077#1072#1085#1089#1072' '#1087#1088#1080' '#1087#1086#1089#1090#1086#1087#1083#1072#1090#1077
      TabOrder = 1
      OnClick = cbxServiceByPostpayClick
    end
    object cbxServiceNoClose: TCheckBox
      Left = 8
      Top = 48
      Width = 361
      Height = 17
      Caption = #1053#1077' '#1079#1072#1082#1088#1099#1074#1072#1090#1100' '#1086#1082#1085#1086' '#1087#1088#1080' '#1087#1088#1086#1074#1077#1076#1077#1085#1080#1080' '#1076#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1093' '#1091#1089#1083#1091#1075
      TabOrder = 2
      OnClick = cbxServiceNoCloseClick
    end
  end
end
