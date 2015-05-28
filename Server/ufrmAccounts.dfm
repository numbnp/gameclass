object frmAccounts: TfrmAccounts
  Left = 346
  Top = 325
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #1059#1095#1077#1090#1085#1099#1077' '#1079#1072#1087#1080#1089#1080' ( '#1073#1072#1079#1072' '#1082#1083#1080#1077#1085#1090#1086#1074' )'
  ClientHeight = 575
  ClientWidth = 774
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object gbAccountInfo: TGroupBox
    Left = 264
    Top = 3
    Width = 506
    Height = 282
    Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086#1073' '#1091#1095#1077#1090#1085#1086#1081' '#1079#1072#1087#1080#1089#1080
    TabOrder = 2
    object lblAccountName: TLabel
      Left = 120
      Top = 46
      Width = 31
      Height = 13
      Caption = #1051#1086#1075#1080#1085
    end
    object lblAccountNumber: TLabel
      Left = 120
      Top = 18
      Width = 34
      Height = 13
      Caption = #1053#1086#1084#1077#1088
    end
    object lblAccountAddress: TLabel
      Left = 120
      Top = 131
      Width = 31
      Height = 13
      Caption = #1040#1076#1088#1077#1089
    end
    object lblAccountPhone: TLabel
      Left = 120
      Top = 74
      Width = 45
      Height = 13
      Caption = #1058#1077#1083#1077#1092#1086#1085
    end
    object lblAccountPhoto: TLabel
      Left = 14
      Top = 130
      Width = 28
      Height = 13
      Caption = #1060#1086#1090#1086
      Enabled = False
    end
    object lblAccountEmail: TLabel
      Left = 120
      Top = 105
      Width = 28
      Height = 13
      Caption = 'E-mail'
    end
    object lblAccountMemo: TLabel
      Left = 176
      Top = 153
      Width = 44
      Height = 13
      Caption = #1047#1072#1084#1077#1090#1082#1080
    end
    object lblSername: TLabel
      Left = 284
      Top = 18
      Width = 49
      Height = 13
      Caption = #1060#1072#1084#1080#1083#1080#1103
    end
    object lblName: TLabel
      Left = 284
      Top = 46
      Width = 22
      Height = 13
      Caption = #1048#1084#1103
    end
    object lblOt: TLabel
      Left = 284
      Top = 74
      Width = 47
      Height = 13
      Caption = #1054#1090#1095#1077#1089#1090#1074#1086
    end
    object lblReferal: TLabel
      Left = 8
      Top = 236
      Width = 33
      Height = 13
      Caption = #1056#1077#1092#1077#1088
    end
    object editAccountName: TDBEditEh
      Left = 176
      Top = 46
      Width = 100
      Height = 21
      DataField = 'name'
      DataSource = dsrcAccounts
      DynProps = <>
      EditButtons = <>
      TabOrder = 1
      Visible = True
      OnChange = editAccountNameChange
      OnEnter = editAccountNumberEnter
    end
    object editAccountNumber: TDBEditEh
      Left = 176
      Top = 18
      Width = 100
      Height = 21
      DataField = 'id'
      DataSource = dsrcAccounts
      DynProps = <>
      EditButtons = <>
      ReadOnly = True
      TabOrder = 0
      Visible = True
      OnEnter = editAccountNumberEnter
    end
    object editAccountAddress: TDBEditEh
      Left = 176
      Top = 126
      Width = 313
      Height = 21
      DataField = 'address'
      DataSource = dsrcAccounts
      DynProps = <>
      EditButtons = <>
      TabOrder = 4
      Visible = True
      OnChange = editAccountNameChange
      OnEnter = editAccountNumberEnter
    end
    object editAccountPhone: TDBEditEh
      Left = 176
      Top = 74
      Width = 100
      Height = 21
      DataField = 'phone'
      DataSource = dsrcAccounts
      DynProps = <>
      EditButtons = <>
      TabOrder = 2
      Visible = True
      OnChange = editAccountNameChange
      OnEnter = editAccountNumberEnter
    end
    object butPhoto: TButton
      Left = 82
      Top = 124
      Width = 32
      Height = 20
      Caption = '...'
      TabOrder = 9
      OnClick = butPhotoClick
    end
    object cbAccountDisabled: TDBCheckBoxEh
      Left = 8
      Top = 150
      Width = 85
      Height = 17
      Caption = #1054#1090#1082#1083#1102#1095#1077#1085#1072
      DataField = 'isenabled'
      DataSource = dsrcAccounts
      DynProps = <>
      TabOrder = 5
      OnClick = editAccountNameChange
      OnEnter = editAccountNumberEnter
      ValueChecked = '0'
      ValueUnchecked = '1;-1'
    end
    object cbAccountBlocked: TDBCheckBoxEh
      Left = 8
      Top = 170
      Width = 157
      Height = 17
      Caption = #1042#1088#1077#1084#1077#1085#1085#1086' '#1079#1072#1073#1083#1086#1082#1080#1088#1086#1074#1072#1085#1072
      DataField = 'isblocked'
      DataSource = dsrcAccounts
      DynProps = <>
      TabOrder = 6
      OnClick = cbAccountBlockedClick
      OnEnter = editAccountNumberEnter
      ValueChecked = '1;-1'
      ValueUnchecked = '0'
    end
    object editAccountEmail: TDBEditEh
      Left = 176
      Top = 100
      Width = 100
      Height = 21
      DataField = 'email'
      DataSource = dsrcAccounts
      DynProps = <>
      EditButtons = <>
      TabOrder = 3
      Visible = True
      OnChange = editAccountNameChange
      OnEnter = editAccountNumberEnter
    end
    object memoAccountMemo: TDBMemo
      Left = 176
      Top = 168
      Width = 313
      Height = 105
      DataField = 'memo'
      DataSource = dsrcAccounts
      ScrollBars = ssVertical
      TabOrder = 8
      OnChange = editAccountNameChange
      OnEnter = editAccountNumberEnter
    end
    object cbxPeriodOfValidity: TDBCheckBox
      Left = 8
      Top = 192
      Width = 115
      Height = 17
      Caption = #1044#1077#1081#1089#1090#1074#1080#1090#1077#1083#1100#1085#1072' '#1076#1086
      DataField = 'PeriodOfValidity'
      DataSource = dsrcAccounts
      TabOrder = 7
      ValueChecked = '1;-1'
      ValueUnchecked = '0'
      OnClick = cbxPeriodOfValidityClick
      OnEnter = editAccountNumberEnter
    end
    object dtpExpirationDate: TDBDateTimeEditEh
      Left = 8
      Top = 212
      Width = 113
      Height = 21
      DataField = 'ExpirationDate'
      DataSource = dsrcAccounts
      DynProps = <>
      EditButtons = <>
      Kind = dtkDateEh
      TabOrder = 10
      Visible = True
      OnEnter = editAccountNumberEnter
    end
    object editSername: TDBEditEh
      Left = 340
      Top = 18
      Width = 150
      Height = 21
      DataField = 'username'
      DataSource = dsrcAccounts
      DynProps = <>
      EditButtons = <>
      TabOrder = 11
      Visible = True
      OnChange = editSernameChange
      OnEnter = editAccountNumberEnter
    end
    object editName: TDBEditEh
      Left = 340
      Top = 46
      Width = 150
      Height = 21
      DataField = 'uname'
      DataSource = dsrcAccounts
      DynProps = <>
      EditButtons = <>
      TabOrder = 12
      Visible = True
      OnChange = editNameChange
      OnEnter = editAccountNumberEnter
    end
    object editOt: TDBEditEh
      Left = 340
      Top = 74
      Width = 150
      Height = 21
      DataField = 'uotch'
      DataSource = dsrcAccounts
      DynProps = <>
      EditButtons = <>
      TabOrder = 13
      Visible = True
      OnChange = editOtChange
      OnEnter = editAccountNumberEnter
    end
    object cbReferal: TComboBox
      Left = 8
      Top = 252
      Width = 157
      Height = 21
      ItemIndex = 0
      TabOrder = 15
      OnChange = cbReferalChange
      OnEnter = editAccountNumberEnter
      Items.Strings = (
        '')
    end
    object editReferal: TDBEditEh
      Left = 83
      Top = 248
      Width = 73
      Height = 21
      DataField = 'referal'
      DataSource = dsrcAccounts
      DynProps = <>
      EditButtons = <>
      TabOrder = 14
      Visible = False
      OnChange = editReferalChange
    end
    object imgAccountPhoto: TDBImage
      Left = 9
      Top = 19
      Width = 105
      Height = 105
      DataField = 'photo'
      DataSource = dsrcAccounts
      TabOrder = 16
    end
  end
  object gbBalanceInfo: TGroupBox
    Left = 264
    Top = 414
    Width = 501
    Height = 129
    Caption = #1041#1072#1083#1072#1085#1089' '#1091#1095#1077#1090#1085#1086#1081' '#1079#1072#1087#1080#1089#1080
    TabOrder = 3
    object lblOnBalance: TLabel
      Left = 8
      Top = 23
      Width = 44
      Height = 13
      Caption = #1053#1072' '#1089#1095#1077#1090#1091
    end
    object lblSummary: TLabel
      Left = 8
      Top = 49
      Width = 56
      Height = 13
      Caption = #1053#1072#1082#1086#1087#1083#1077#1085#1086
    end
    object lblSummaryDiscount: TLabel
      Left = 152
      Top = 101
      Width = 66
      Height = 13
      Caption = #1057#1082#1080#1076#1082#1072' = 0 %'
    end
    object lblZeroAccountBalance: TLabel
      Left = 8
      Top = 75
      Width = 82
      Height = 13
      Caption = #1053#1091#1083#1077#1074#1086#1081' '#1073#1072#1083#1072#1085#1089
    end
    object Label6: TLabel
      Left = 138
      Top = 101
      Width = 8
      Height = 13
      Caption = '%'
    end
    object editOnBalance: TDBEditEh
      Left = 82
      Top = 18
      Width = 98
      Height = 21
      DataField = 'balance'
      DataSource = dsrcAccounts
      DynProps = <>
      EditButtons = <>
      ReadOnly = True
      TabOrder = 6
      Visible = True
      OnEnter = editAccountNumberEnter
    end
    object editSummary: TDBEditEh
      Left = 82
      Top = 44
      Width = 98
      Height = 21
      DataField = 'summary'
      DataSource = dsrcAccounts
      DynProps = <>
      EditButtons = <>
      ReadOnly = True
      TabOrder = 2
      Visible = True
      OnChange = editSummaryChange
      OnEnter = editAccountNumberEnter
    end
    object butBalanceAdd: TButton
      Left = 218
      Top = 15
      Width = 158
      Height = 25
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1089#1091#1084#1084#1091' '#1085#1072' '#1089#1095#1077#1090
      TabOrder = 0
      OnClick = butBalanceAddClick
    end
    object butBalanceRemove: TButton
      Left = 218
      Top = 45
      Width = 158
      Height = 25
      Caption = #1057#1085#1103#1090#1100' '#1089#1091#1084#1084#1091' '#1089#1086' '#1089#1095#1077#1090#1072
      TabOrder = 1
      OnClick = butBalanceRemoveClick
    end
    object editAccountZeroBalance: TDBEditEh
      Left = 100
      Top = 70
      Width = 80
      Height = 21
      DataField = 'zeroBalance'
      DataSource = dsrcAccounts
      DynProps = <>
      EditButtons = <>
      TabOrder = 3
      Visible = True
      OnChange = editAccountNameChange
      OnEnter = editAccountNumberEnter
    end
    object editPrivelegedDiscount: TDBEditEh
      Left = 100
      Top = 96
      Width = 37
      Height = 21
      DataField = 'privilegedDiscount'
      DataSource = dsrcAccounts
      DynProps = <>
      EditButtons = <>
      TabOrder = 5
      Visible = True
      OnChange = editAccountNameChange
      OnEnter = editAccountNumberEnter
    end
    object cbAccountPrivileged: TDBCheckBoxEh
      Left = 8
      Top = 97
      Width = 89
      Height = 17
      Caption = #1057#1087#1077#1094'. '#1089#1082#1080#1076#1082#1072
      DataField = 'isprivileged'
      DataSource = dsrcAccounts
      DynProps = <>
      TabOrder = 4
      OnClick = editAccountNameChange
      OnEnter = editAccountNumberEnter
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
  end
  object butClose: TButton
    Left = 609
    Top = 546
    Width = 75
    Height = 25
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 4
    OnClick = butCloseClick
  end
  object butHelp: TButton
    Left = 689
    Top = 546
    Width = 75
    Height = 25
    Caption = #1055#1086#1084#1086#1097#1100
    TabOrder = 5
    OnClick = butHelpClick
  end
  object grdAccounts: TDBGridEh
    Left = 12
    Top = 56
    Width = 249
    Height = 485
    AutoFitColWidths = True
    DataSource = dsrcAccounts
    DynProps = <>
    FooterParams.Color = clWindow
    IndicatorOptions = []
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 1
    OnKeyDown = grdAccountsKeyDown
    Columns = <
      item
        Alignment = taCenter
        DynProps = <>
        EditButtons = <>
        FieldName = 'id'
        Footers = <>
        Title.Caption = #1053#1086#1084#1077#1088
        Width = 45
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'name'
        Footers = <>
        Title.Caption = #1048#1084#1103
        Width = 194
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object gbTarifsInfo: TGroupBox
    Left = 264
    Top = 287
    Width = 501
    Height = 126
    Caption = #1041#1077#1079#1086#1087#1072#1089#1085#1086#1089#1090#1100
    TabOrder = 6
    object lblUserLevel: TLabel
      Left = 7
      Top = 97
      Width = 90
      Height = 13
      Caption = #1059#1088#1086#1074#1077#1085#1100' '#1076#1086#1089#1090#1091#1087#1072':'
    end
    object lblForceTariff: TLabel
      Left = 196
      Top = 96
      Width = 123
      Height = 13
      Caption = #1055#1088#1080#1085#1091#1076#1080#1090#1077#1083#1100#1085#1099#1081' '#1090#1072#1088#1080#1092':'
    end
    object lblAccountPassword: TLabel
      Left = 8
      Top = 21
      Width = 38
      Height = 13
      Caption = #1055#1072#1088#1086#1083#1100
    end
    object lblHardCode: TLabel
      Left = 8
      Top = 49
      Width = 50
      Height = 13
      Caption = 'Hard code'
    end
    object editUserLevel: TDBEditEh
      Left = 104
      Top = 89
      Width = 73
      Height = 21
      DataField = 'userlevel'
      DataSource = dsrcAccounts
      DynProps = <>
      EditButtons = <>
      TabOrder = 2
      Visible = False
      OnChange = editUserLevelChange
    end
    object editForceTariff: TDBEditEh
      Left = 395
      Top = 72
      Width = 73
      Height = 21
      DataField = 'force_tariff'
      DataSource = dsrcAccounts
      DynProps = <>
      EditButtons = <>
      TabOrder = 4
      Visible = False
      OnChange = editForceTariffChange
    end
    object cbTarifsLimit: TDBCheckBoxEh
      Left = 8
      Top = 69
      Width = 153
      Height = 28
      Caption = #1054#1075#1088#1072#1085#1080#1095#1080#1090#1100' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
      DataField = 'assigntarif'
      DataSource = dsrcAccounts
      DynProps = <>
      TabOrder = 0
      OnClick = cbTarifsLimitClick
      OnEnter = editAccountNumberEnter
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
    object cbUserLevel: TComboBox
      Left = 100
      Top = 94
      Width = 73
      Height = 21
      ItemIndex = 1
      TabOrder = 1
      Text = '1'
      OnChange = cbUserLevelChange
      OnEnter = editAccountNumberEnter
      Items.Strings = (
        '0'
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
    object cbForceTariff: TComboBox
      Left = 320
      Top = 93
      Width = 169
      Height = 21
      TabOrder = 3
      OnChange = cbForceTariffChange
      OnEnter = editAccountNumberEnter
      Items.Strings = (
        '0'
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
    object butGenerateSecCodes: TButton
      Left = 420
      Top = 15
      Width = 70
      Height = 25
      Caption = #1053#1086#1074#1099#1077' '#1082#1086#1076#1099
      TabOrder = 5
      OnClick = butGenerateSecCodesClick
      OnEnter = editAccountNumberEnter
    end
    object butViewSecCodes: TButton
      Left = 345
      Top = 15
      Width = 70
      Height = 25
      Caption = #1044#1086#1087'. '#1082#1086#1076#1099
      TabOrder = 6
      OnClick = butViewSecCodesClick
      OnEnter = editAccountNumberEnter
    end
    object butClearPass: TButton
      Left = 240
      Top = 15
      Width = 100
      Height = 25
      Caption = #1057#1073#1088#1086#1089#1080#1090#1100' '#1087#1072#1088#1086#1083#1100
      TabOrder = 7
      OnClick = butClearPassClick
      OnEnter = editAccountNumberEnter
    end
    object editAccountPass: TDBEditEh
      Left = 60
      Top = 17
      Width = 173
      Height = 24
      DataField = 'password'
      DataSource = dsrcAccounts
      DynProps = <>
      EditButtons = <>
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      PasswordChar = '*'
      TabOrder = 8
      Visible = False
      OnChange = editAccountPassChange
    end
    object editAccountPassU: TEdit
      Left = 60
      Top = 16
      Width = 173
      Height = 24
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      PasswordChar = '*'
      TabOrder = 9
      Text = '1234567890'
      OnEnter = editAccountNumberEnter
    end
    object editHardCode: TDBEditEh
      Left = 60
      Top = 45
      Width = 141
      Height = 24
      DataField = 'hardcode'
      DataSource = dsrcAccounts
      DynProps = <>
      EditButtons = <>
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 10
      Visible = True
      OnChange = editAccountPassChange
      OnEnter = editAccountNumberEnter
    end
    object cbIgnoreHardCode: TDBCheckBoxEh
      Left = 240
      Top = 44
      Width = 105
      Height = 25
      Caption = 'Ignore hard code'
      DataField = 'ignorehardcode'
      DataSource = dsrcAccounts
      DynProps = <>
      TabOrder = 11
      OnClick = cbIgnoreHardCodeClick
      OnEnter = editAccountNumberEnter
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
    object butGetCode: TButton
      Left = 200
      Top = 44
      Width = 33
      Height = 25
      Caption = 'Get'
      TabOrder = 12
      OnClick = butGetCodeClick
    end
  end
  object gbFilter: TGroupBox
    Left = 8
    Top = 3
    Width = 249
    Height = 46
    Caption = #1060#1080#1083#1100#1090#1088
    TabOrder = 0
    object lblFilterNumber: TLabel
      Left = 12
      Top = 20
      Width = 70
      Height = 13
      Caption = #1053#1086#1084#1077#1088'/'#1051#1086#1075#1080#1085
    end
    object editFilter: TEdit
      Left = 88
      Top = 14
      Width = 153
      Height = 21
      TabOrder = 0
      OnChange = editFilterChange
      OnKeyDown = editFilterKeyDown
    end
  end
  object butAccountAdd: TButton
    Left = 8
    Top = 547
    Width = 80
    Height = 25
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    TabOrder = 7
    OnClick = butAccountAddClick
  end
  object butAccountSave: TButton
    Left = 176
    Top = 547
    Width = 80
    Height = 25
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    TabOrder = 8
    OnClick = butAccountSaveClick
  end
  object butAccountDelete: TButton
    Left = 92
    Top = 547
    Width = 80
    Height = 25
    Caption = #1059#1076#1072#1083#1080#1090#1100
    TabOrder = 9
    OnClick = butAccountDeleteClick
  end
  object dsrcAccounts: TDataSource
    Left = 448
    Top = 524
  end
  object OpenDialog1: TOpenDialog
    Left = 520
    Top = 508
  end
end
