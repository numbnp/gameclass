object ToolsForm: TToolsForm
  Left = 0
  Top = 0
  Caption = 'MML'
  ClientHeight = 249
  ClientWidth = 564
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox4: TGroupBox
    Left = 8
    Top = 12
    Width = 542
    Height = 193
    Caption = ' Multi-language '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
    TabOrder = 0
    object mml_title: TLabel
      Left = 68
      Top = 20
      Width = 437
      Height = 33
      AutoSize = False
      Caption = 
        'TRxTranslator component translates string properties such as lab' +
        'el captions and list box items and allows to support multiple la' +
        'nguages within your application.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsUnderline]
      ParentFont = False
      WordWrap = True
    end
    object cmTvg2MultiLanguage: TSpeedButton
      Tag = 13
      Left = 16
      Top = 20
      Width = 28
      Height = 28
    end
    object FruitsLabel: TLabel
      Left = 16
      Top = 72
      Width = 25
      Height = 13
      Caption = '&Fruits'
      FocusControl = FruitList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object LanguageLabel: TLabel
      Left = 148
      Top = 72
      Width = 80
      Height = 13
      Caption = '&Select language:'
      FocusControl = LanguageCombo
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object mml_desctription: TLabel
      Left = 304
      Top = 76
      Width = 221
      Height = 101
      AutoSize = False
      Caption = 
        'This part of demo is based TLanguage '#13#10'demo application written ' +
        'by Serge Sushko'#13#10'TLanguage component and included .lng files '#13#10'a' +
        're copyright (c) bySerge Sushko, 1998'#13#10#13#10'E-mail: sushko@iname.co' +
        'm,'#13#10'WWW: http://members.tripod.com/~sushko/'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsUnderline]
      ParentFont = False
      WordWrap = True
    end
    object FruitList: TListBox
      Left = 16
      Top = 88
      Width = 121
      Height = 81
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      Items.Strings = (
        'Apple'
        'Strawberry'
        'Cherry')
      ParentFont = False
      TabOrder = 0
    end
    object LanguageCombo: TComboBox
      Left = 148
      Top = 88
      Width = 145
      Height = 21
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnChange = LanguageComboChange
      Items.Strings = (
        'Czech'
        'English'
        'Espanol'
        'Romana'
        'Russian'
        'Deutsch')
    end
    object MessageBtn: TButton
      Left = 164
      Top = 124
      Width = 105
      Height = 25
      Caption = 'Selected fruit'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = MessageBtnClick
    end
  end
  object tl: TRxTranslator
    Left = 424
  end
end
