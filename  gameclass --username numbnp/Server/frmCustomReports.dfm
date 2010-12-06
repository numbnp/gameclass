object formCustomReports: TformCustomReports
  Left = 247
  Top = 200
  BorderStyle = bsDialog
  Caption = 'formCustomReports'
  ClientHeight = 566
  ClientWidth = 792
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object lblReports: TLabel
    Left = 8
    Top = 8
    Width = 37
    Height = 13
    Caption = 'Reports'
  end
  object lblReportName: TLabel
    Left = 176
    Top = 8
    Width = 61
    Height = 13
    Caption = 'Report name'
  end
  object lblReportDescription: TLabel
    Left = 176
    Top = 56
    Width = 86
    Height = 13
    Caption = 'Report description'
  end
  object lblReportSqlCode: TLabel
    Left = 176
    Top = 176
    Width = 77
    Height = 13
    Caption = 'Report Sql code'
  end
  object lblVersion: TLabel
    Left = 344
    Top = 8
    Width = 35
    Height = 13
    Caption = 'Version'
  end
  object lblTabIndex: TLabel
    Left = 408
    Top = 8
    Width = 45
    Height = 13
    Caption = 'TabIndex'
  end
  object lvReports: TListView
    Left = 8
    Top = 24
    Width = 153
    Height = 505
    Columns = <
      item
        AutoSize = True
        Caption = 'Names'
        MinWidth = 149
      end>
    HideSelection = False
    ReadOnly = True
    ShowColumnHeaders = False
    TabOrder = 0
    ViewStyle = vsReport
    OnClick = lvReportsClick
  end
  object butCreate: TButton
    Left = 8
    Top = 536
    Width = 75
    Height = 25
    Caption = 'Create'
    TabOrder = 1
    OnClick = butCreateClick
  end
  object butDelete: TButton
    Left = 168
    Top = 536
    Width = 75
    Height = 25
    Caption = 'Delete'
    TabOrder = 2
    OnClick = butDeleteClick
  end
  object butImport: TButton
    Left = 296
    Top = 536
    Width = 75
    Height = 25
    Caption = 'Import'
    TabOrder = 3
    OnClick = butImportClick
  end
  object butExport: TButton
    Left = 376
    Top = 536
    Width = 75
    Height = 25
    Caption = 'Export'
    TabOrder = 4
    OnClick = butExportClick
  end
  object editName: TEdit
    Left = 176
    Top = 24
    Width = 153
    Height = 21
    TabOrder = 5
    OnChange = editNameChange
  end
  object memoDescription: TMemo
    Left = 176
    Top = 72
    Width = 609
    Height = 89
    ScrollBars = ssVertical
    TabOrder = 6
    OnChange = memoDescriptionChange
  end
  object butClose: TButton
    Left = 712
    Top = 536
    Width = 75
    Height = 25
    Caption = 'Close'
    TabOrder = 7
    OnClick = butCloseClick
  end
  object butSave: TButton
    Left = 88
    Top = 536
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 8
    OnClick = butSaveClick
  end
  object updownTabIndex: TUpDown
    Left = 464
    Top = 22
    Width = 17
    Height = 25
    Max = 1000
    Position = 500
    TabOrder = 9
    OnClick = updownTabIndexClick
  end
  object editVersion: TEdit
    Left = 344
    Top = 24
    Width = 49
    Height = 21
    TabOrder = 10
    OnChange = editVersionChange
  end
  object editTabIndex: TEdit
    Left = 408
    Top = 24
    Width = 49
    Height = 21
    TabOrder = 11
    OnChange = editTabIndexChange
  end
  object memoSQL: TSynMemo
    Left = 176
    Top = 192
    Width = 609
    Height = 337
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    TabOrder = 12
    Gutter.Font.Charset = DEFAULT_CHARSET
    Gutter.Font.Color = clWindowText
    Gutter.Font.Height = -11
    Gutter.Font.Name = 'Courier New'
    Gutter.Font.Style = []
    Gutter.ShowLineNumbers = True
    Highlighter = SynSQLSyn
    OnChange = memoSQLoldChange
  end
  object butHelp: TButton
    Left = 632
    Top = 536
    Width = 75
    Height = 25
    Caption = 'Help'
    TabOrder = 13
    OnClick = butHelpClick
  end
  object OpenDialog: TOpenDialog
    DefaultExt = 'xml'
    Filter = 'XML (*.xml)|*.xml|All files|*.*'
    Left = 488
    Top = 16
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'xml'
    Filter = 'XML (*.xml)|*.xml|All files|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 520
    Top = 16
  end
  object XMLDoc: TXMLDocument
    Left = 552
    Top = 16
    DOMVendorDesc = 'MSXML'
  end
  object SynSQLSyn: TSynSQLSyn
    DefaultFilter = 'SQL Files (*.sql)|*.sql'
    CommentAttri.Foreground = clGreen
    FunctionAttri.Foreground = clFuchsia
    FunctionAttri.Style = []
    KeyAttri.Foreground = clBlue
    KeyAttri.Style = []
    SQLPlusAttri.Foreground = clBlue
    SQLPlusAttri.Style = []
    StringAttri.Foreground = clRed
    SymbolAttri.Foreground = clBlack
    SQLDialect = sqlMSSQL2K
    Left = 584
    Top = 16
  end
end
