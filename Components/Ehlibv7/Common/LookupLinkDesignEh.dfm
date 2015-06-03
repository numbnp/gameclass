object LookupLinkFields: TLookupLinkFields
  Left = 407
  Top = 249
  ActiveControl = LookupDatasetList
  BorderStyle = bsDialog
  Caption = 'Lookup Link Designer'
  ClientHeight = 304
  ClientWidth = 352
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 4
    Top = 33
    Width = 343
    Height = 190
    Shape = bsFrame
  end
  object Label30: TLabel
    Left = 13
    Top = 40
    Width = 48
    Height = 13
    Caption = 'Key Fields'
    FocusControl = KeyFieldList
    IsControl = True
  end
  object Label31: TLabel
    Left = 222
    Top = 38
    Width = 66
    Height = 13
    Caption = 'Lookup Fields'
    FocusControl = LookupKeyList
    IsControl = True
  end
  object IndexLabel: TLabel
    Left = 4
    Top = 10
    Width = 78
    Height = 13
    Caption = 'Lookup DataSet'
    FocusControl = LookupDatasetList
  end
  object Label2: TLabel
    Left = 12
    Top = 142
    Width = 61
    Height = 13
    Caption = '&Joined Fields'
    FocusControl = BindList
  end
  object ResultFieldLabel: TLabel
    Left = 8
    Top = 239
    Width = 58
    Height = 13
    Caption = '&Result Field:'
    FocusControl = ResultFieldList
  end
  object KeyFieldList: TListBox
    Left = 13
    Top = 55
    Width = 117
    Height = 69
    IntegralHeight = True
    ItemHeight = 13
    TabOrder = 1
    OnClick = BindingListClick
    IsControl = True
  end
  object LookupKeyList: TListBox
    Left = 222
    Top = 54
    Width = 117
    Height = 69
    IntegralHeight = True
    ItemHeight = 13
    TabOrder = 2
    OnClick = BindingListClick
    IsControl = True
  end
  object BindList: TListBox
    Left = 12
    Top = 157
    Width = 242
    Height = 56
    IntegralHeight = True
    ItemHeight = 13
    MultiSelect = True
    TabOrder = 3
    OnClick = BindListClick
    IsControl = True
  end
  object LookupDatasetList: TComboBox
    Left = 109
    Top = 7
    Width = 236
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
    OnChange = LookupDatasetListChange
    OnClick = LookupDatasetListChange
  end
  object AddButton: TButton
    Left = 138
    Top = 74
    Width = 75
    Height = 25
    Caption = '&Add'
    TabOrder = 4
    OnClick = AddButtonClick
  end
  object DeleteButton: TButton
    Left = 263
    Top = 157
    Width = 75
    Height = 25
    Caption = '&Delete'
    TabOrder = 5
    OnClick = DeleteButtonClick
  end
  object ClearButton: TButton
    Left = 263
    Top = 188
    Width = 75
    Height = 25
    Caption = '&Clear'
    TabOrder = 6
    OnClick = ClearButtonClick
  end
  object Button1: TButton
    Left = 180
    Top = 271
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 7
    OnClick = BitBtn1Click
  end
  object Button2: TButton
    Left = 266
    Top = 271
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 8
  end
  object ResultFieldList: TComboBox
    Left = 72
    Top = 236
    Width = 273
    Height = 21
    ItemHeight = 13
    TabOrder = 9
  end
end
