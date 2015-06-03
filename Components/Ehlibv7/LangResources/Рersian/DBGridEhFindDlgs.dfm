object DBGridEhFindDlg: TDBGridEhFindDlg
  Left = 273
  Top = 305
  BorderStyle = bsDialog
  Caption = 'پیدا کردن بعدی'
  ClientHeight = 150
  ClientWidth = 505
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 10
    Top = 12
    Width = 52
    Height = 13
    Caption = 'پیدا کردن آنهایی که:'
  end
  object Label2: TLabel
    Left = 10
    Top = 35
    Width = 34
    Height = 13
    Caption = 'جستجو در:'
  end
  object cbMatchType: TLabel
    Left = 10
    Top = 58
    Width = 33
    Height = 13
    Caption = 'Matc&h:'
  end
  object Label3: TLabel
    Left = 10
    Top = 82
    Width = 37
    Height = 13
    Caption = 'جستجو:'
  end
  object Label4: TLabel
    Left = 10
    Top = 128
    Width = 59
    Height = 13
    Caption = 'جستجو در درخت:'
  end
  object cbText: TDBComboBoxEh
    Left = 88
    Top = 9
    Width = 316
    Height = 21
    DropDownBox.Rows = 17
    DropDownBox.Sizable = True
    EditButtons = <>
    TabOrder = 0
    Text = 'cbText'
    Visible = True
    OnChange = cbTextChange
  end
  object bFind: TButton
    Left = 413
    Top = 9
    Width = 82
    Height = 23
    Caption = '&پیدا کردن بعدی'
    TabOrder = 6
    OnClick = bFindClick
  end
  object bCancel: TButton
    Left = 413
    Top = 37
    Width = 82
    Height = 22
    Cancel = True
    Caption = 'بستن'
    ModalResult = 2
    TabOrder = 7
    OnClick = bCancelClick
  end
  object cbFindIn: TDBComboBoxEh
    Left = 88
    Top = 32
    Width = 192
    Height = 21
    DropDownBox.Rows = 17
    DropDownBox.Sizable = True
    EditButtons = <>
    TabOrder = 1
    Text = 'cbFindIn'
    Visible = True
    OnChange = cbFindInChange
  end
  object cbMatchinType: TDBComboBoxEh
    Left = 88
    Top = 55
    Width = 144
    Height = 21
    EditButtons = <>
    Items.Strings = (
        'در هر جایی از فیلد'
      'همان فیلد'
      'شروع فیلد')
    KeyItems.Strings = (
      'در هر جایی از فیلد'
      'همان فیلد'
      'شروع فیلد')
    TabOrder = 2
    Text = 'در هر جایی از فیلد'
    Visible = True
  end
  object cbFindDirection: TDBComboBoxEh
    Left = 88
    Top = 79
    Width = 144
    Height = 21
    EditButtons = <>
    Items.Strings = (
     'بالا'
      'پایین'
      'همه')
    KeyItems.Strings = (
      'بالا'
      'پایین'
      'همه')
    TabOrder = 3
    Text = 'همه'
    Visible = True
    OnChange = cbTextChange
  end
  object cbCharCase: TDBCheckBoxEh
    Left = 88
    Top = 105
    Width = 144
    Height = 14
    Caption = 'موضوع'
    TabOrder = 4
    ValueChecked = 'True'
    ValueUnchecked = 'False'
  end
  object cbUseFormat: TDBCheckBoxEh
    Left = 260
    Top = 105
    Width = 144
    Height = 14
    Caption = 'فرمت'
    Checked = True
    State = cbChecked
    TabOrder = 5
    ValueChecked = 'True'
    ValueUnchecked = 'False'
  end
  object dbcTreeFindRange: TDBComboBoxEh
    Left = 88
    Top = 124
    Width = 145
    Height = 21
    EditButtons = <>
    Items.Strings = (
     'در همه نود ها'
      'در نود های باز شده'
      'در سطح جاری'
      'در نود جاری')
    KeyItems.Strings = (
      'در همه نود ها'
      'در نود های باز شده'
      'در سطح جاری'
      'در نود جاری')
    TabOrder = 8
    Text = 'در همه نود ها'
    Visible = True
    OnChange = cbTextChange
  end
end
