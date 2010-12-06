object frmTaskKill: TfrmTaskKill
  Left = 308
  Top = 177
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Kill tasks'
  ClientHeight = 326
  ClientWidth = 443
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object pnlButtons: TPanel
    Left = 0
    Top = 288
    Width = 443
    Height = 38
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object butHelp: TButton
      Left = 192
      Top = 5
      Width = 75
      Height = 25
      Caption = 'Help'
      TabOrder = 0
      OnClick = butHelpClick
    end
    object butKillSet: TButton
      Left = 307
      Top = 5
      Width = 110
      Height = 25
      Caption = 'kill set'
      ModalResult = 6
      TabOrder = 1
      OnClick = butKillSetClick
    end
    object butKillSelTasks: TButton
      Left = 16
      Top = 5
      Width = 169
      Height = 25
      Caption = 'Kill selected tasks'
      Default = True
      ModalResult = 1
      TabOrder = 2
      OnClick = butKillSelTasksClick
    end
  end
  object pnlTaskList: TPanel
    Left = 0
    Top = 0
    Width = 443
    Height = 288
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
  end
end
