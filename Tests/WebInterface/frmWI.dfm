object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 775
  ClientWidth = 1098
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
    Width = 853
    Height = 624
    Align = alClient
    TabOrder = 0
  end
  object pnlControl: TPanel
    Left = 853
    Top = 0
    Width = 245
    Height = 624
    Align = alRight
    TabOrder = 1
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
    object edtCommand: TEdit
      Left = 14
      Top = 480
      Width = 147
      Height = 21
      TabOrder = 3
    end
    object Button4: TButton
      Left = 160
      Top = 478
      Width = 75
      Height = 25
      Caption = 'Do Command'
      TabOrder = 4
      OnClick = Button4Click
    end
    object Button5: TButton
      Left = 120
      Top = 102
      Width = 97
      Height = 25
      Caption = 'Hide Unblock'
      TabOrder = 5
      OnClick = Button5Click
    end
    object Button6: TButton
      Left = 24
      Top = 133
      Width = 97
      Height = 25
      Caption = 'ShowChangePwd'
      TabOrder = 6
      OnClick = Button6Click
    end
    object Button7: TButton
      Left = 120
      Top = 133
      Width = 97
      Height = 25
      Caption = 'HideChangePwd'
      TabOrder = 7
      OnClick = Button7Click
    end
    object Button8: TButton
      Left = 24
      Top = 164
      Width = 193
      Height = 25
      Caption = 'ShowTestMessage'
      TabOrder = 8
      OnClick = Button8Click
    end
    object ListBox1: TListBox
      Left = 24
      Top = 208
      Width = 193
      Height = 145
      ItemHeight = 13
      Items.Strings = (
        'ClientState_Blocked'
        'ClientState_Authentication'
        'ClientState_Order'
        'ClientState_Session'
        'ClientState_Agreement'
        'ClientState_OperatorSession'
        'ClientState_OperatorAgreement')
      TabOrder = 9
      OnDblClick = ListBox1Click
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 624
    Width = 1098
    Height = 151
    Align = alBottom
    Caption = 'Panel1'
    TabOrder = 2
    object memLog: TMemo
      Left = 1
      Top = 1
      Width = 1096
      Height = 149
      Align = alClient
      TabOrder = 0
    end
  end
end
