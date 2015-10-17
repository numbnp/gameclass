object frmMain: TfrmMain
  Left = 192
  Top = 107
  Caption = 'frmMain'
  ClientHeight = 276
  ClientWidth = 230
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClick = FormClick
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object btnMouseHook: TButton
    Left = 8
    Top = 40
    Width = 105
    Height = 25
    Caption = 'btnMouseHook'
    TabOrder = 0
    OnClick = btnMouseHookClick
  end
  object btnMouseUnhook: TButton
    Left = 8
    Top = 104
    Width = 105
    Height = 25
    Caption = 'btnMouseUnhook'
    TabOrder = 1
    OnClick = btnMouseUnhookClick
  end
  object btnLoadHookDll: TButton
    Left = 72
    Top = 8
    Width = 97
    Height = 25
    Caption = 'btnLoadHookDll'
    TabOrder = 2
    OnClick = btnLoadHookDllClick
  end
  object btnUnloadHookDll: TButton
    Left = 72
    Top = 184
    Width = 97
    Height = 25
    Caption = 'btnUnloadHookDll'
    TabOrder = 3
    OnClick = btnUnloadHookDllClick
  end
  object btnKeyboardHook: TButton
    Left = 128
    Top = 41
    Width = 105
    Height = 25
    Caption = 'btnKeyboardHook'
    TabOrder = 4
    OnClick = btnKeyboardHookClick
  end
  object btnKeyboardUnhook: TButton
    Left = 128
    Top = 104
    Width = 105
    Height = 25
    Caption = 'btnKeyboardUnhook'
    TabOrder = 5
    OnClick = btnKeyboardUnhookClick
  end
  object btnTestKeyboard: TButton
    Left = 128
    Top = 72
    Width = 105
    Height = 25
    Caption = 'btnTestKeyboard'
    TabOrder = 6
    OnClick = btnTestKeyboardClick
  end
  object btnTestMouse: TButton
    Left = 8
    Top = 72
    Width = 105
    Height = 25
    Caption = 'btnTestMouse'
    TabOrder = 7
    OnClick = btnTestMouseClick
  end
  object Button1: TButton
    Left = 64
    Top = 144
    Width = 121
    Height = 25
    Caption = 'Delay Keyboard Hook'
    TabOrder = 8
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 8
    Top = 256
    Width = 217
    Height = 21
    TabOrder = 9
    Text = 'Edit1'
  end
  object Button2: TButton
    Left = 48
    Top = 224
    Width = 145
    Height = 25
    Caption = 'Button2'
    TabOrder = 10
    OnClick = Button2Click
  end
end
