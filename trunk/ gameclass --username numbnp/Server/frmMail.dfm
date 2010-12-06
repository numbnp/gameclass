object formMail: TformMail
  Left = 286
  Top = 145
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'formMail'
  ClientHeight = 319
  ClientWidth = 470
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnActivate = FormActivate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object pnlRead: TPanel
    Left = 7
    Top = 7
    Width = 455
    Height = 275
    TabOrder = 0
    object lblNewMessages: TLabel
      Left = 16
      Top = 8
      Width = 72
      Height = 13
      Caption = 'New messages'
    end
    object lblMessage: TLabel
      Left = 192
      Top = 8
      Width = 88
      Height = 13
      Caption = 'Incoming message'
    end
    object lblAnswer: TLabel
      Left = 192
      Top = 136
      Width = 88
      Height = 13
      Caption = 'Outgoing message'
    end
    object Label1: TLabel
      Left = 192
      Top = 115
      Width = 37
      Height = 13
      Caption = 'Send to'
    end
    object lbMessaged: TListBox
      Left = 16
      Top = 24
      Width = 161
      Height = 221
      ItemHeight = 13
      TabOrder = 0
    end
    object memoMessage: TMemo
      Left = 192
      Top = 24
      Width = 247
      Height = 73
      TabOrder = 1
    end
    object memoAnswer: TMemo
      Left = 192
      Top = 152
      Width = 247
      Height = 73
      TabOrder = 2
    end
    object butMarkAsRead: TButton
      Left = 220
      Top = 237
      Width = 106
      Height = 25
      Caption = 'Mark as Read'
      TabOrder = 3
    end
    object butSend: TButton
      Left = 364
      Top = 237
      Width = 75
      Height = 25
      Caption = 'Send'
      TabOrder = 4
    end
    object cbOnlyUnread: TCheckBox
      Left = 16
      Top = 250
      Width = 113
      Height = 17
      Caption = 'show only unreaded'
      TabOrder = 5
    end
    object ComboBox1: TComboBox
      Left = 252
      Top = 111
      Width = 188
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 6
    end
  end
  object butClose: TButton
    Left = 387
    Top = 288
    Width = 75
    Height = 25
    Caption = 'Close'
    TabOrder = 1
  end
  object butHelp: TButton
    Left = 307
    Top = 288
    Width = 75
    Height = 25
    Caption = 'Help'
    TabOrder = 2
  end
end
