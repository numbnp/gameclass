inherited MemTableFieldsEditorEh: TMemTableFieldsEditorEh
  Left = 616
  Top = 268
  Width = 391
  Height = 400
  Caption = 'MemTableFieldsEditorh'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Splitter1: TSplitter
    Top = 327
    Width = 383
  end
  inherited Panel1: TPanel
    Width = 383
    inherited DBNavigator: TDBNavigator
      Width = 381
      Flat = True
      Hints.Strings = ()
    end
  end
  inherited FieldListBox: TListBox
    Width = 383
    Height = 306
  end
  inherited AggListBox: TListBox
    Top = 329
    Width = 383
  end
  object PageControl1: TPageControl [4]
    Left = 0
    Top = 21
    Width = 383
    Height = 306
    ActivePage = TabSheet4
    Align = alClient
    TabOrder = 3
    object TabSheet1: TTabSheet
      Caption = 'Edit fields'
    end
    object TabSheet4: TTabSheet
      Caption = 'Edit data structure'
      ImageIndex = 3
      object gridStructure: TDBGridEh
        Left = 0
        Top = 24
        Width = 375
        Height = 254
        Align = alClient
        ColumnDefValues.AlwaysShowEditButton = True
        ColumnDefValues.AutoDropDown = True
        ColumnDefValues.DblClickNextVal = True
        ColumnDefValues.DropDownShowTitles = True
        ColumnDefValues.DropDownSizing = True
        ColumnDefValues.Title.EndEllipsis = True
        ColumnDefValues.Title.ToolTips = True
        ColumnDefValues.ToolTips = True
        DataGrouping.GroupLevels = <>
        DataSource = dsStructure
        EditActions = [geaCutEh, geaCopyEh, geaPasteEh, geaDeleteEh, geaSelectAllEh]
        Flat = True
        FooterColor = clWindow
        FooterFont.Charset = DEFAULT_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -11
        FooterFont.Name = 'MS Sans Serif'
        FooterFont.Style = []
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
        OptionsEh = [dghFixed3D, dghClearSelection, dghFitRowHeightToText, dghTraceColSizing, dghIncSearch, dghRowHighlight, dghShowRecNo, dghColumnResize, dghColumnMove]
        RowDetailPanel.Color = clBtnFace
        RowHeight = 2
        RowLines = 1
        RowSizingAllowed = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnContextPopup = DBGridEh1ContextPopup
        OnEnter = gridStructureEnter
        OnExit = gridStructureExit
        Columns = <
          item
            EditButtons = <>
            FieldName = 'FName'
            Footers = <>
            Title.Caption = 'Data field name'
            Width = 163
            OnUpdateData = DBGridEh2Columns0UpdateData
          end
          item
            DropDownRows = 17
            EditButtons = <>
            FieldName = 'FType'
            Footers = <>
            KeyList.Strings = (
              'TMTBlobDataFieldEh'
              'TMTBooleanDataFieldEh'
              'TMTDateTimeDataFieldEh'
              'TMTInterfaceDataFieldEh'
              'TMTNumericDataFieldEh'
              'TMTRefObjectFieldEh'
              'TMTSQLTimeStampDataFieldEh'
              'TMTStringDataFieldEh'
              'TMTVariantDataFieldEh')
            PickList.Strings = (
              'TMTBlobDataFieldEh'
              'TMTBooleanDataFieldEh'
              'TMTDateTimeDataFieldEh'
              'TMTInterfaceDataFieldEh'
              'TMTNumericDataFieldEh'
              'TMTRefObjectFieldEh'
              'TMTSQLTimeStampDataFieldEh'
              'TMTStringDataFieldEh'
              'TMTVariantDataFieldEh')
            Title.Caption = 'Data field type'
            Width = 179
            OnUpdateData = DBGridEh2Columns0UpdateData
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 375
        Height = 24
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object sbCancel: TSpeedButton
          Left = 0
          Top = 0
          Width = 23
          Height = 22
          Hint = 'Cancel'
          Flat = True
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000130B0000130B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            3333333333FFFFF3333333333999993333333333F77777FFF333333999999999
            3333333777333777FF3333993333339993333377FF3333377FF3399993333339
            993337777FF3333377F3393999333333993337F777FF333337FF993399933333
            399377F3777FF333377F993339993333399377F33777FF33377F993333999333
            399377F333777FF3377F993333399933399377F3333777FF377F993333339993
            399377FF3333777FF7733993333339993933373FF3333777F7F3399933333399
            99333773FF3333777733339993333339933333773FFFFFF77333333999999999
            3333333777333777333333333999993333333333377777333333}
          NumGlyphs = 2
          OnClick = sbCancelClick
        end
        object sbApply: TSpeedButton
          Left = 23
          Top = 0
          Width = 23
          Height = 22
          Hint = 'Apply'
          Flat = True
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000120B0000120B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            333333FFFFFFFFFFFFF33000077777770033377777777777773F000007888888
            00037F3337F3FF37F37F00000780088800037F3337F77F37F37F000007800888
            00037F3337F77FF7F37F00000788888800037F3337777777337F000000000000
            00037F3FFFFFFFFFFF7F00000000000000037F77777777777F7F000FFFFFFFFF
            00037F7F333333337F7F000FFFFFFFFF00037F7F333333337F7F000FFFFFFFFF
            00037F7F333333337F7F000FFFFFFFFF00037F7F333333337F7F000FFFFFFFFF
            00037F7F333333337F7F000FFFFFFFFF07037F7F33333333777F000FFFFFFFFF
            0003737FFFFFFFFF7F7330099999999900333777777777777733}
          NumGlyphs = 2
          OnClick = sbApplyClick
        end
        object DBNavigator1: TDBNavigator
          Left = 48
          Top = 0
          Width = 72
          Height = 22
          DataSource = dsStructure
          VisibleButtons = [nbInsert, nbDelete, nbPost]
          Flat = True
          TabOrder = 0
        end
        object cbPersistentStructure: TCheckBox
          Left = 152
          Top = 4
          Width = 113
          Height = 17
          Caption = 'Persistent Structure'
          TabOrder = 1
          OnClick = cbPersistentStructureClick
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Edit data'
      ImageIndex = 1
      object DBGridEh1: TDBGridEh
        Left = 0
        Top = 0
        Width = 375
        Height = 278
        Align = alClient
        ColumnDefValues.AlwaysShowEditButton = True
        ColumnDefValues.AutoDropDown = True
        ColumnDefValues.DblClickNextVal = True
        ColumnDefValues.DropDownShowTitles = True
        ColumnDefValues.DropDownSizing = True
        ColumnDefValues.Title.EndEllipsis = True
        ColumnDefValues.Title.ToolTips = True
        ColumnDefValues.ToolTips = True
        DataGrouping.GroupLevels = <>
        DataSource = DataSource
        EditActions = [geaCutEh, geaCopyEh, geaPasteEh, geaDeleteEh, geaSelectAllEh]
        Flat = True
        FooterColor = clWindow
        FooterFont.Charset = DEFAULT_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -11
        FooterFont.Name = 'MS Sans Serif'
        FooterFont.Style = []
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
        OptionsEh = [dghFixed3D, dghClearSelection, dghFitRowHeightToText, dghTraceColSizing, dghIncSearch, dghRowHighlight, dghShowRecNo, dghColumnResize, dghColumnMove]
        RowDetailPanel.Color = clBtnFace
        RowHeight = 2
        RowLines = 1
        RowSizingAllowed = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnContextPopup = DBGridEh1ContextPopup
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Edit dataset'
      ImageIndex = 2
      DesignSize = (
        375
        278)
      object SpeedButton1: TSpeedButton
        Left = 0
        Top = 0
        Width = 375
        Height = 22
        Action = actFetchParams
        Anchors = [akLeft, akTop, akRight]
        Flat = True
        Transparent = False
      end
      object SpeedButton2: TSpeedButton
        Left = 0
        Top = 22
        Width = 375
        Height = 22
        Action = actAssignLocalData
        Anchors = [akLeft, akTop, akRight]
        Flat = True
        Transparent = False
      end
      object SpeedButton3: TSpeedButton
        Left = 0
        Top = 44
        Width = 375
        Height = 22
        Action = actLoadFromMyBaseTable
        Anchors = [akLeft, akTop, akRight]
        Flat = True
        Transparent = False
      end
      object SpeedButton4: TSpeedButton
        Left = 0
        Top = 88
        Width = 375
        Height = 22
        Action = actSaveToMyBaseXmlTable
        Anchors = [akLeft, akTop, akRight]
        Flat = True
        Transparent = False
      end
      object SpeedButton5: TSpeedButton
        Left = 0
        Top = 110
        Width = 375
        Height = 22
        Action = actSaveToMyBaseXmlUTF8Table
        Anchors = [akLeft, akTop, akRight]
        Flat = True
        Transparent = False
      end
      object SpeedButton6: TSpeedButton
        Left = 0
        Top = 132
        Width = 375
        Height = 22
        Action = actSaveToBinaryMyBaseTable
        Anchors = [akLeft, akTop, akRight]
        Flat = True
        Transparent = False
      end
      object SpeedButton7: TSpeedButton
        Left = 0
        Top = 154
        Width = 375
        Height = 22
        Action = actClearData
        Anchors = [akLeft, akTop, akRight]
        Flat = True
        Transparent = False
      end
      object SpeedButton8: TSpeedButton
        Left = 0
        Top = 66
        Width = 375
        Height = 22
        Action = actCreateDataSet
        Anchors = [akLeft, akTop, akRight]
        Flat = True
        Transparent = False
      end
      object SpeedButton9: TSpeedButton
        Left = 0
        Top = 176
        Width = 375
        Height = 22
        Action = actCreateDataDriver
        Anchors = [akLeft, akTop, akRight]
        Flat = True
        Transparent = False
      end
    end
  end
  inherited DataSource: TDataSource
    Top = 120
  end
  inherited LocalMenu: TPopupMenu
    Top = 120
  end
  object ActionList1: TActionList
    Left = 106
    Top = 120
    object actFetchParams: TAction
      Caption = 'Fetch Params'
      OnExecute = actFetchParamsExecute
    end
    object actAssignLocalData: TAction
      Caption = 'Assign Local Data...'
      OnExecute = actAssignLocalDataExecute
    end
    object actLoadFromMyBaseTable: TAction
      Caption = 'Load from MyBase table...'
      OnExecute = actLoadFromMyBaseTableExecute
    end
    object actCreateDataSet: TAction
      Caption = 'Create DataSet'
      OnExecute = actCreateDataSetExecute
      OnUpdate = actCreateDataSetUpdate
    end
    object actSaveToMyBaseXmlTable: TAction
      Caption = 'Save to MyBase Xml table...'
      OnExecute = actSaveToMyBaseXmlTableExecute
    end
    object actSaveToMyBaseXmlUTF8Table: TAction
      Caption = 'Save to MyBase Xml UTF8 table...'
      OnExecute = actSaveToMyBaseXmlUTF8TableExecute
    end
    object actSaveToBinaryMyBaseTable: TAction
      Caption = 'Save to binary MyBase table...'
      OnExecute = actSaveToBinaryMyBaseTableExecute
    end
    object actClearData: TAction
      Caption = 'Clear Data'
      OnExecute = actClearDataExecute
    end
    object actCreateDataDriver: TAction
      Caption = 'Create DataDriver'
      OnExecute = actCreateDataDriverExecute
    end
  end
  object GridMenu: TPopupMenu
    Left = 76
    Top = 120
    object GridCut: TMenuItem
      Caption = 'Cut'
      ShortCut = 16472
      OnClick = GridCutClick
    end
    object GridCopy: TMenuItem
      Caption = 'Copy'
      ShortCut = 16451
      OnClick = GridCopyClick
    end
    object GridPaste: TMenuItem
      Caption = 'Paste'
      ShortCut = 16470
      OnClick = GridPasteClick
    end
    object GridDelete: TMenuItem
      Caption = 'Delete'
      ShortCut = 16430
      OnClick = GridDeleteClick
    end
    object GridSelectAll: TMenuItem
      Caption = 'Select All'
      ShortCut = 16449
      OnClick = GridSelectAllClick
    end
  end
  object dsStructure: TDataSource
    DataSet = mtStructure
    OnDataChange = dsStructureDataChange
    Left = 10
    Top = 155
  end
  object mtStructure: TMemTableEh
    Active = True
    FieldDefs = <
      item
        Name = 'FName'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'FType'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'RefDataField'
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    BeforePost = mtStructureBeforePost
    AfterPost = mtStructureAfterPost
    BeforeDelete = mtStructureBeforeDelete
    OnNewRecord = mtStructureNewRecord
    Left = 41
    Top = 155
    object mtStructureFName: TStringField
      DisplayWidth = 255
      FieldName = 'FName'
      Size = 255
    end
    object mtStructureFType: TStringField
      DisplayWidth = 255
      FieldName = 'FType'
      Size = 255
    end
    object mtStructureRefDataField: TRefObjectField
      DisplayWidth = 10
      FieldName = 'RefDataField'
    end
    object MemTableData: TMemTableDataEh
      object DataStruct: TMTDataStructEh
        object FName: TMTStringDataFieldEh
          FieldName = 'FName'
          StringDataType = fdtStringEh
          Alignment = taLeftJustify
          Visible = False
          Size = 255
          Transliterate = False
        end
        object FType: TMTStringDataFieldEh
          FieldName = 'FType'
          StringDataType = fdtStringEh
          Alignment = taLeftJustify
          Visible = False
          Size = 255
          Transliterate = False
        end
        object RefDataField: TMTRefObjectFieldEh
          FieldName = 'RefDataField'
          Alignment = taLeftJustify
          Visible = False
        end
      end
      object RecordsList: TRecordsListEh
      end
    end
  end
end
