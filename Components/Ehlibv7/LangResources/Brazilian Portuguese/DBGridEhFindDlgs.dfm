object DBGridEhFindDlg: TDBGridEhFindDlg
  Left = 273
  Top = 305
  BorderStyle = bsDialog
  Caption = 'Procurar texto'
  ClientHeight = 150
  ClientWidth = 505
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
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
    Caption = 'Procurar &por:'
  end
  object Label2: TLabel
    Left = 10
    Top = 35
    Width = 34
    Height = 13
    Caption = 'Procurar &em:'
  end
  object cbMatchType: TLabel
    Left = 10
    Top = 58
    Width = 33
    Height = 13
    Caption = 'E&xatamente:'
  end
  object Label3: TLabel
    Left = 10
    Top = 82
    Width = 37
    Height = 13
    Caption = 'Bu&sca:'
  end
  object Label4: TLabel
    Left = 10
    Top = 128
    Width = 59
    Height = 13
    Caption = 'Procurar na '#225'r&vore:'
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
    Caption = 'Procurar pr'#243'xi&mo:'
    TabOrder = 6
    OnClick = bFindClick
  end
  object bCancel: TButton
    Left = 413
    Top = 37
    Width = 82
    Height = 22
    Cancel = True
    Caption = 'Fechar'
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
      'A partir de qualquer parte do campo'
      'Campo inteiro'
      'A partir do in'#237'cio do campo')
    KeyItems.Strings = (
      'A partir de qualquer parte do campo'
      'Campo inteiro'
      'A partir do in'#237'cio do campo')
    TabOrder = 2
    Text = 'A partir de qualquer parte do campo'
    Visible = True
  end
  object cbFindDirection: TDBComboBoxEh
    Left = 88
    Top = 79
    Width = 144
    Height = 21
    EditButtons = <>
    Items.Strings = (
      'Cima'
      'Baixo'
      'Tudo')
    KeyItems.Strings = (
      'Cima'
      'Baixo'
      'Tudo')
    TabOrder = 3
    Text = 'Tudo'
    Visible = True
    OnChange = cbTextChange
  end
  object cbCharCase: TDBCheckBoxEh
    Left = 88
    Top = 105
    Width = 144
    Height = 14
    Caption = 'Diferenciar &Mai'#250'sculas/Min'#250'sculas'
    TabOrder = 4
  end
  object cbUseFormat: TDBCheckBoxEh
    Left = 260
    Top = 105
    Width = 144
    Height = 14
    Caption = 'Diferenciar F&ormato'
    Checked = True
    State = cbChecked
    TabOrder = 5
  end
  object dbcTreeFindRange: TDBComboBoxEh
    Left = 88
    Top = 124
    Width = 145
    Height = 21
    EditButtons = <>
    Items.Strings = (
      'Em todos os n'#243's'
      'Em n'#243's expandidos'
      'No n'#237'vel atual'
      'No n'#243' atual')
    KeyItems.Strings = (
      'Em todos os n'#243's'
      'Em n'#243's expandidos'
      'No n'#237'vel atual'
      'No n'#243' atual')
    TabOrder = 8
    Text = 'Em todos os n'#243's'
    Visible = True
    OnChange = cbTextChange
  end
end
