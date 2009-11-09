object formMain: TformMain
  Left = 215
  Top = 185
  BorderIcons = [biSystemMenu, biMinimize, biMaximize, biHelp]
  BorderStyle = bsDialog
  BorderWidth = 5
  Caption = 'GameClass Language Center'
  ClientHeight = 372
  ClientWidth = 630
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 168
    Top = 8
    Width = 34
    Height = 13
    Caption = 'English'
  end
  object Label2: TLabel
    Left = 0
    Top = 8
    Width = 33
    Height = 13
    Caption = 'Phrase'
  end
  object Label3: TLabel
    Left = 169
    Top = 96
    Width = 73
    Height = 13
    Caption = 'Other language'
  end
  object lbPhrases: TListBox
    Left = 0
    Top = 25
    Width = 161
    Height = 344
    ItemHeight = 13
    TabOrder = 0
    OnClick = lbPhrasesClick
    OnDblClick = lbPhrasesDblClick
  end
  object memoEnglish: TMemo
    Left = 168
    Top = 24
    Width = 457
    Height = 65
    TabOrder = 1
    OnKeyUp = memoEnglishKeyUp
  end
  object memoOther: TMemo
    Left = 169
    Top = 112
    Width = 457
    Height = 65
    TabOrder = 2
    OnKeyUp = memoOtherKeyUp
  end
  object butFileOpen: TButton
    Left = 551
    Top = 312
    Width = 75
    Height = 25
    Caption = 'File Open'
    TabOrder = 3
    OnClick = butFileOpenClick
  end
  object butApply: TButton
    Left = 551
    Top = 344
    Width = 75
    Height = 25
    Caption = 'Apply'
    TabOrder = 4
    OnClick = butApplyClick
  end
  object GroupBox1: TGroupBox
    Left = 168
    Top = 184
    Width = 265
    Height = 89
    Caption = ' Manage phrases '
    TabOrder = 5
    object editText: TEdit
      Left = 13
      Top = 20
      Width = 233
      Height = 21
      TabOrder = 0
      OnChange = editTextChange
    end
    object butPhraseAdd: TButton
      Left = 13
      Top = 48
      Width = 75
      Height = 25
      Caption = 'add'
      TabOrder = 1
      OnClick = butPhraseAddClick
    end
    object butPhraseDel: TButton
      Left = 93
      Top = 48
      Width = 75
      Height = 25
      Caption = 'delete'
      TabOrder = 2
      OnClick = butPhraseDelClick
    end
    object butPhraseRen: TButton
      Left = 173
      Top = 48
      Width = 75
      Height = 25
      Caption = 'rename'
      TabOrder = 3
      OnClick = butPhraseRenClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 168
    Top = 280
    Width = 265
    Height = 89
    Caption = ' Show options '
    TabOrder = 6
    object Label4: TLabel
      Left = 13
      Top = 19
      Width = 22
      Height = 13
      Caption = 'Filter'
    end
    object cbFilterEmpty: TCheckBox
      Left = 13
      Top = 64
      Width = 97
      Height = 17
      Caption = 'empty only'
      TabOrder = 0
      OnClick = cbFilterEmptyClick
    end
    object editFilter: TEdit
      Left = 13
      Top = 35
      Width = 228
      Height = 21
      TabOrder = 1
      OnChange = editFilterChange
    end
  end
  object Button1: TButton
    Left = 464
    Top = 344
    Width = 75
    Height = 25
    Caption = 'SaveAsText'
    TabOrder = 7
    OnClick = Button1Click
  end
  object OpenDialog: TOpenDialog
    DefaultExt = '*.lng'
    FileName = '*.lng'
    Filter = 'lang|*.lng'
    Title = 'Open GameClass Language'
    Left = 600
    Top = 272
  end
end
