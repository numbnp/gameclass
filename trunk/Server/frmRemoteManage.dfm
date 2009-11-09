object formRemoteManage: TformRemoteManage
  Left = 232
  Top = 225
  BorderStyle = bsDialog
  Caption = 'Remote manage GC3 Clients'
  ClientHeight = 431
  ClientWidth = 632
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object lvClients: TListView
    Left = 13
    Top = 16
    Width = 492
    Height = 357
    Columns = <
      item
        Caption = 'Computer'
        Width = 75
      end
      item
        Caption = 'GC3Client version'
        Width = 100
      end
      item
        Caption = 'Windows version'
        Width = 160
      end
      item
        AutoSize = True
        Caption = 'Comment'
      end>
    FlatScrollBars = True
    GridLines = True
    HideSelection = False
    MultiSelect = True
    ReadOnly = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
  end
  object butClientStop: TButton
    Left = 520
    Top = 80
    Width = 100
    Height = 25
    Caption = 'Stop client'
    TabOrder = 1
    OnClick = butClientStopClick
  end
  object butUninstall: TButton
    Left = 520
    Top = 48
    Width = 100
    Height = 25
    Caption = 'Uninstall'
    TabOrder = 2
    OnClick = butUninstallClick
  end
  object butReInstall: TButton
    Left = 520
    Top = 16
    Width = 100
    Height = 25
    Caption = 'ReInstall'
    TabOrder = 3
    OnClick = butReInstallClick
  end
  object Panel1: TPanel
    Left = 15
    Top = 381
    Width = 603
    Height = 3
    TabOrder = 4
  end
  object butOK: TButton
    Left = 544
    Top = 393
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 5
  end
  object butHelp: TButton
    Left = 460
    Top = 393
    Width = 75
    Height = 25
    Caption = 'Help'
    Enabled = False
    TabOrder = 6
    OnClick = butHelpClick
  end
  object butUpdate: TButton
    Left = 14
    Top = 393
    Width = 75
    Height = 25
    Caption = 'Update'
    TabOrder = 7
    OnClick = butUpdateClick
  end
  object pb: TProgressBar
    Left = 98
    Top = 397
    Width = 352
    Height = 17
    BorderWidth = 1
    Enabled = False
    ParentShowHint = False
    Smooth = True
    Step = 1
    ShowHint = True
    TabOrder = 8
  end
  object tmrUpdate: TTimer
    Interval = 700
    OnTimer = tmrUpdateTimer
    Left = 101
    Top = 400
  end
end
