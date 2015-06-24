object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 640
  ClientWidth = 959
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
  object pnlWeb: TPanel
    Left = 0
    Top = 0
    Width = 774
    Height = 640
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 590
    ExplicitHeight = 545
  end
  object pnlControl: TPanel
    Left = 774
    Top = 0
    Width = 185
    Height = 640
    Align = alRight
    TabOrder = 1
    ExplicitLeft = 590
    ExplicitHeight = 545
    object Button1: TButton
      Left = 24
      Top = 40
      Width = 97
      Height = 25
      Caption = 'Show Dev Tools'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 24
      Top = 71
      Width = 97
      Height = 25
      Caption = 'Reload'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 24
      Top = 102
      Width = 97
      Height = 25
      Caption = 'Show Unblock'
      TabOrder = 2
      OnClick = Button3Click
    end
  end
end
