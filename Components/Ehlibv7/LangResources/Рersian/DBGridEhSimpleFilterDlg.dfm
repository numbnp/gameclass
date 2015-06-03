object DBGridEhSimpleFilterDialog: TDBGridEhSimpleFilterDialog
  Left = 734
  Top = 312

  bidmode=bdrighttoleft
  BorderStyle = bsDialog
  Caption = 'فلیتر سفارشی'
  ClientHeight = 218
  ClientWidth = 410
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 6
    Top = 7
    Width = 100
    Height = 13
    Caption = 'نمایش رکورد هایی که'
  end
  object Bevel1: TBevel
    Left = 4
    Top = 27
    Width = 399
    Height = 8
    Shape = bsTopLine
  end
  object Label2: TLabel
    Left = 6
    Top = 131
    Width = 189
    Height = 13
    Caption = ' '#39'_'#39'  برای یک کارکتر مجهول '
  end
  object Label3: TLabel
    Left = 6
    Top = 151
    Width = 208
    Height = 13
    Caption = ' '#39'%'#39' برای یک سری کارکتر مجهول'
  end
  object ComboBox2: TComboBox
    Left = 8
    Top = 92
    Width = 191
    Height = 21
    Style = csDropDownList
    DropDownCount = 13
    ItemHeight = 13
    TabOrder = 4
    Items.Strings = (
      ''
      'برابر است با'
      'مخالف است با'
      'بزرگتر از'
      'بزرگتر مساوی از'
      'کوچکتر از'
      'کوچکتر مساوی از'
      'شبیه'
      'مخالف شبیه'
      'جزع'
      'مخالف جزع'
      'خالی '
      'مخالف خالی')
  end
  object ComboBox1: TComboBox
    Left = 8
    Top = 39
    Width = 191
    Height = 21
    Style = csDropDownList
    DropDownCount = 13
    ItemHeight = 13
    TabOrder = 0
    Items.Strings = (
      ''
      'برابر است با'
      'مخالف است با'
      'بزرگتر از'
      'بزرگتر مساوی از'
      'کوچکتر از'
      'کوچکتر مساوی از'
      'شبیه'
      'مخالف شبیه'
      'جزع'
      'مخالف جزع'
      'خالی '
      'مخالف خالی')
  end
  object Edit2: TEdit
    Left = 207
    Top = 92
    Width = 191
    Height = 21
    TabOrder = 5
    Visible = False
  end
  object Edit1: TEdit
    Left = 207
    Top = 39
    Width = 191
    Height = 21
    TabOrder = 1
    Visible = False
  end
  object rbOr: TRadioButton
    Left = 105
    Top = 69
    Width = 53
    Height = 17
    Caption = '&یا'
    TabOrder = 3
  end
  object rbAnd: TRadioButton
    Left = 38
    Top = 69
    Width = 47
    Height = 17
    Caption = '&و'
    Checked = True
    TabOrder = 2
    TabStop = True
  end
  object bOk: TButton
    Left = 237
    Top = 188
    Width = 78
    Height = 22
    Caption = 'تایید'
    Default = True
    ModalResult = 1
    TabOrder = 6
  end
  object bCancel: TButton
    Left = 323
    Top = 188
    Width = 78
    Height = 22
    Cancel = True
    Caption = 'انصراف'
    ModalResult = 2
    TabOrder = 7
  end
  object DBComboBoxEh1: TDBComboBoxEh
    Left = 215
    Top = 46
    Width = 190
    Height = 21
    DropDownBox.Rows = 17
    DropDownBox.Sizable = True
    EditButtons = <>
    TabOrder = 8
    Text = 'DBComboBoxEh1'
    Visible = False
    OnChange = DBComboBoxEh1Change
  end
  object DBComboBoxEh2: TDBComboBoxEh
    Left = 213
    Top = 98
    Width = 191
    Height = 21
    DropDownBox.Rows = 17
    DropDownBox.Sizable = True
    EditButtons = <>
    TabOrder = 9
    Text = 'DBComboBoxEh2'
    Visible = False
    OnChange = DBComboBoxEh1Change
  end
  object DBDateTimeEditEh1: TDBDateTimeEditEh
    Left = 221
    Top = 52
    Width = 191
    Height = 21
    EditButtons = <>
    Kind = dtkDateEh
    TabOrder = 10
    Visible = False
  end
  object DBDateTimeEditEh2: TDBDateTimeEditEh
    Left = 219
    Top = 106
    Width = 191
    Height = 21
    EditButtons = <>
    Kind = dtkDateEh
    TabOrder = 11
    Visible = False
  end
  object DBNumberEditEh1: TDBNumberEditEh
    Left = 228
    Top = 59
    Width = 190
    Height = 21
    EditButtons = <>
    TabOrder = 12
    Visible = False
  end
  object DBNumberEditEh2: TDBNumberEditEh
    Left = 226
    Top = 115
    Width = 191
    Height = 21
    EditButtons = <>
    TabOrder = 13
    Visible = False
  end
end
