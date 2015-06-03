object DBGridEhFindDlg: TDBGridEhFindDlg
  Left = 273
  Top = 305
  BorderStyle = bsDialog
  Caption = 'Rechercher texte'
  ClientHeight = 150
  ClientWidth = 535
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
    Width = 59
    Height = 13
    Caption = 'Re&chercher:'
  end
  object Label2: TLabel
    Left = 10
    Top = 35
    Width = 28
    Height = 13
    Caption = '&Dans:'
  end
  object cbMatchType: TLabel
    Left = 10
    Top = 58
    Width = 81
    Height = 13
    Caption = '&Correspondance:'
  end
  object Label3: TLabel
    Left = 10
    Top = 82
    Width = 83
    Height = 13
    Caption = 'Sens Recherche:'
  end
  object Label4: TLabel
    Left = 10
    Top = 128
    Width = 72
    Height = 13
    Caption = 'Chercher dans:'
  end
  object cbText: TDBComboBoxEh
    Left = 105
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
    Left = 444
    Top = 9
    Width = 82
    Height = 23
    Caption = 'Trouver &Suivant'
    TabOrder = 6
    OnClick = bFindClick
  end
  object bCancel: TButton
    Left = 444
    Top = 37
    Width = 82
    Height = 22
    Cancel = True
    Caption = '&Fermer'
    ModalResult = 2
    TabOrder = 7
    OnClick = bCancelClick
  end
  object cbFindIn: TDBComboBoxEh
    Left = 105
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
    Left = 105
    Top = 55
    Width = 163
    Height = 21
    EditButtons = <>
    Items.Strings = (
      'N'#39'importe o'#249' dans la zone'
      'Zone enti'#232're'
      'D'#233'but de la zone')
    KeyItems.Strings = (
      'N'#39'importe o'#249' dans la zone'
      'Zone enti'#232're'
      'D'#233'but de la zone'
      '')
    TabOrder = 2
    Text = 'N'#39'importe o'#249' dans la zone'
    Visible = True
  end
  object cbFindDirection: TDBComboBoxEh
    Left = 105
    Top = 79
    Width = 163
    Height = 21
    EditButtons = <>
    Items.Strings = (
      'Haut'
      'Bas'
      'Tous')
    KeyItems.Strings = (
      'Haut'
      'Bas'
      'Tous')
    TabOrder = 3
    Text = 'Tous'
    Visible = True
    OnChange = cbTextChange
  end
  object cbCharCase: TDBCheckBoxEh
    Left = 105
    Top = 105
    Width = 144
    Height = 14
    Caption = 'Respecter &MAJ/Min'
    TabOrder = 4
    ValueChecked = 'True'
    ValueUnchecked = 'False'
  end
  object cbUseFormat: TDBCheckBoxEh
    Left = 277
    Top = 105
    Width = 144
    Height = 14
    Caption = 'Correspondance Format'
    Checked = True
    State = cbChecked
    TabOrder = 5
    ValueChecked = 'True'
    ValueUnchecked = 'False'
  end
  object dbcTreeFindRange: TDBComboBoxEh
    Left = 105
    Top = 124
    Width = 164
    Height = 21
    EditButtons = <>
    Items.Strings = (
      'Dans toutes l'#39'arborescence'
      'Dans l'#39'arborescence ouverte'
      'Dans le niveau courant'
      'dans le noeud courant')
    KeyItems.Strings = (
      'Dans toutes l'#39'arborescence'
      'Dans l'#39'arborescence ouverte'
      'Dans le niveau courant'
      'dans le noeud courant')
    TabOrder = 8
    Text = 'Dans toutes l'#39'arborescence'
    Visible = True
    OnChange = cbTextChange
  end
end
