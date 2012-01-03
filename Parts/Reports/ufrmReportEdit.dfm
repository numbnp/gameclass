object frmReportEdit: TfrmReportEdit
  Left = 817
  Top = 239
  BorderStyle = bsNone
  Caption = 'frmReportEdit'
  ClientHeight = 508
  ClientWidth = 705
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object splitEditor: TSplitter
    Left = 0
    Top = 317
    Width = 705
    Height = 3
    Cursor = crVSplit
    Align = alBottom
  end
  object pnlReportColumns: TPanel
    Left = 0
    Top = 320
    Width = 705
    Height = 188
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object splitReportColumns: TSplitter
      Left = 365
      Top = 0
      Height = 188
      Align = alRight
    end
    object ColumnsValueListEditor: TValueListEditor
      Left = 368
      Top = 0
      Width = 337
      Height = 188
      Align = alRight
      TabOrder = 0
      OnStringsChange = ColumnsValueListEditorStringsChange
      ColWidths = (
        150
        181)
    end
    object pnlColumnsList: TPanel
      Left = 0
      Top = 0
      Width = 365
      Height = 188
      Align = alClient
      BevelOuter = bvNone
      Caption = 'pnlColumnsList'
      TabOrder = 1
      object lbxColumnsNames: TListBox
        Left = 0
        Top = 17
        Width = 365
        Height = 171
        Style = lbOwnerDrawFixed
        Align = alClient
        DragMode = dmAutomatic
        ItemHeight = 17
        TabOrder = 0
        OnClick = lbxColumnsNamesClick
        OnDragDrop = lbxColumnsNamesDragDrop
        OnDragOver = lbxColumnsNamesDragOver
      end
      object lblColumns: TStaticText
        Left = 0
        Top = 0
        Width = 365
        Height = 17
        Align = alTop
        BevelInner = bvSpace
        BevelKind = bkFlat
        BevelOuter = bvSpace
        Caption = 'Columns:'
        TabOrder = 1
      end
    end
  end
  object pnlHeader: TPanel
    Left = 0
    Top = 0
    Width = 705
    Height = 65
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    DesignSize = (
      705
      65)
    object lblName: TLabel
      Left = 8
      Top = 13
      Width = 31
      Height = 13
      Caption = 'Name:'
    end
    object lblVersion: TLabel
      Left = 8
      Top = 37
      Width = 38
      Height = 13
      Caption = 'Version:'
    end
    object lblAuthor: TLabel
      Left = 216
      Top = 37
      Width = 34
      Height = 13
      Alignment = taRightJustify
      Caption = 'Author:'
    end
    object edtName: TEdit
      Left = 72
      Top = 10
      Width = 625
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnChange = edtNameChange
    end
    object edtAuthor: TEdit
      Left = 256
      Top = 33
      Width = 442
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
    end
    object edtVersion: TRxSpinEdit
      Left = 72
      Top = 33
      Width = 105
      Height = 21
      ButtonKind = bkStandard
      MaxValue = 1000000.000000000000000000
      MinValue = 1.000000000000000000
      Value = 1.000000000000000000
      TabOrder = 2
    end
  end
  object pgctrlReportCode: TPageControl
    Left = 0
    Top = 65
    Width = 705
    Height = 252
    ActivePage = tabCode
    Align = alClient
    TabOrder = 2
    object tabCode: TTabSheet
      Caption = 'Code'
      object edtReportCode: TSynEdit
        Left = 0
        Top = 0
        Width = 697
        Height = 224
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        PopupMenu = PopupMenuEdit
        TabOrder = 0
        Gutter.Font.Charset = DEFAULT_CHARSET
        Gutter.Font.Color = clWindowText
        Gutter.Font.Height = -11
        Gutter.Font.Name = 'Courier New'
        Gutter.Font.Style = []
        Highlighter = SynSQLSyn
        Lines.Strings = (
          'edtReportCode')
      end
    end
    object tabDescription: TTabSheet
      Caption = 'Description'
      ImageIndex = 1
      object redtDescription: TRichEdit
        Left = 0
        Top = 0
        Width = 697
        Height = 224
        Align = alClient
        TabOrder = 0
      end
    end
  end
  object SynSQLSyn: TSynSQLSyn
    DefaultFilter = 'SQL Files (*.sql)|*.sql'
    SQLDialect = sqlStandard
    Left = 296
    Top = 80
  end
  object PopupMenuEdit: TPopupMenu
    Left = 396
    Top = 73
    object mnuCut: TMenuItem
      Caption = 'Cut'
      ShortCut = 16472
      OnClick = mnuCutClick
    end
    object mnuCopy: TMenuItem
      Caption = 'Copy'
      ShortCut = 16451
      OnClick = mnuCopyClick
    end
    object mnuPaste: TMenuItem
      Caption = 'Paste'
      ShortCut = 16470
      OnClick = mnuPasteClick
    end
  end
end
