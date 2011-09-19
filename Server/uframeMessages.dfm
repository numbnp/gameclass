object frameMessages: TframeMessages
  Left = 0
  Top = 0
  Width = 790
  Height = 534
  TabOrder = 0
  object Panel1: TPanel
    Left = 0
    Top = 493
    Width = 790
    Height = 41
    Align = alBottom
    Caption = 'Panel1'
    TabOrder = 0
    DesignSize = (
      790
      41)
    object edtMessage: TEdit
      Left = 8
      Top = 8
      Width = 684
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      MaxLength = 255
      TabOrder = 0
      OnKeyUp = edtMessageKeyUp
    end
    object btnSend: TButton
      Left = 704
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100
      TabOrder = 1
      OnClick = btnSendClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 790
    Height = 493
    Align = alClient
    Caption = 'Panel2'
    TabOrder = 1
    object memMessages: TMemo
      Left = 161
      Top = 1
      Width = 628
      Height = 491
      Align = alClient
      Lines.Strings = (
        'memMessages')
      ScrollBars = ssVertical
      TabOrder = 0
    end
    object Panel3: TPanel
      Left = 1
      Top = 1
      Width = 160
      Height = 491
      Align = alLeft
      Caption = 'Panel3'
      TabOrder = 1
      object lvUsers: TListView
        Left = 1
        Top = 1
        Width = 158
        Height = 489
        Align = alClient
        Columns = <
          item
            AutoSize = True
            Caption = #1048#1084#1103
          end
          item
            AutoSize = True
            Caption = #8470
          end
          item
            Caption = 'IP'
            MaxWidth = 20
            Width = 0
          end>
        GridLines = True
        HideSelection = False
        MultiSelect = True
        ReadOnly = True
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
      end
    end
  end
  object Timer1: TTimer
    Interval = 5000
    OnTimer = Timer1Timer
    Left = 520
    Top = 272
  end
end
