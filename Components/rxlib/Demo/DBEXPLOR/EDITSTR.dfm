object StrEditDlg: TStrEditDlg
  Left = 208
  Top = 100
  Width = 479
  Height = 320
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  ShowHint = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 255
    Width = 471
    Height = 31
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object Panel2: TPanel
      Left = 296
      Top = 0
      Width = 175
      Height = 31
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object OkBtn: TBitBtn
        Left = 7
        Top = 0
        Width = 77
        Height = 25
        Caption = 'OK'
        TabOrder = 0
        OnClick = OkBtnClick
        Glyph.Data = {
          46010000424D460100000000000076000000280000001C0000000D0000000100
          040000000000D000000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          33333333333333330000333333333333333333F3333333330000333303333333
          33333F3F3333333300003330003333333333F333F33333330000330000033333
          333F33333F33333300003000300033333383333333F333330000300333000333
          338333F8333F33330000333333300033333888338333F3330000333333330003
          3333333338333F33000033333333300033333333338333F30000333333333300
          3333333333383383000033333333333333333333333388330000333333333333
          33333333333333330000}
        Margin = 4
        NumGlyphs = 2
        Spacing = -1
      end
      object CancelBtn: TBitBtn
        Left = 91
        Top = 0
        Width = 77
        Height = 25
        Cancel = True
        Caption = 'Cancel'
        ModalResult = 2
        TabOrder = 1
        Glyph.Data = {
          46010000424D460100000000000076000000280000001C0000000D0000000100
          040000000000D000000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333000033333333333333333FF33333FF330000333003333300
          3333833F333833F3000033300033300033338333F38333F30000333300030003
          3333383338333F330000333330000033333333833333F3330000333333000333
          33333338333F33330000333330000033333333833333F3330000333300030003
          3333383338333F33000033300033300033338333F38333F30000333003333300
          3333833F333833F3000033333333333333333883333388330000333333333333
          33333333333333330000}
        Margin = 4
        NumGlyphs = 2
        Spacing = -1
      end
    end
    object LoadBtn: TBitBtn
      Left = 9
      Top = 0
      Width = 77
      Height = 25
      Caption = '&Load...'
      TabOrder = 1
      OnClick = FileOpen
    end
    object SaveBtn: TBitBtn
      Left = 93
      Top = 0
      Width = 77
      Height = 25
      Caption = '&Save as...'
      TabOrder = 2
      OnClick = SaveBtnClick
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 471
    Height = 28
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object LineCount: TLabel
      Left = 14
      Top = 10
      Width = 169
      Height = 17
      AutoSize = False
      Caption = '0 lines'
    end
    object Panel4: TPanel
      Left = 359
      Top = 0
      Width = 112
      Height = 28
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object DBNavigator: TDBNavigator
        Left = 12
        Top = 6
        Width = 88
        Height = 21
        DataSource = DataSource
        VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
        TabOrder = 0
      end
    end
  end
  object Panel5: TPanel
    Left = 0
    Top = 28
    Width = 471
    Height = 227
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 10
    TabOrder = 2
    object Memo: TDBMemo
      Left = 10
      Top = 10
      Width = 451
      Height = 207
      Align = alClient
      DataSource = DataSource
      ScrollBars = ssBoth
      TabOrder = 0
      OnKeyDown = MemoKeyDown
    end
  end
  object OpenDialog: TOpenDialog
    DefaultExt = 'TXT'
    Filter = 'Text files (*.TXT)|*.TXT|All files (*.*)|*.*'
    Options = [ofHideReadOnly, ofShowHelp, ofPathMustExist, ofFileMustExist]
    Title = 'Load text file'
    Left = 236
    Top = 4
  end
  object FormPlacement: TFormPlacement
    MinMaxInfo.MinTrackHeight = 150
    MinMaxInfo.MinTrackWidth = 360
    Left = 208
    Top = 4
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'TXT'
    Filter = 'Text files (*.TXT)|*.TXT|All files (*.*)|*.*'
    Options = [ofOverwritePrompt, ofCreatePrompt]
    Title = 'Save as'
    Left = 264
    Top = 4
  end
  object DataSource: TDataSource
    OnDataChange = DataSourceDataChange
    Left = 180
    Top = 4
  end
end
