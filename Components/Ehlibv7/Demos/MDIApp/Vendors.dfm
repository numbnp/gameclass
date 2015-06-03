object fVendors: TfVendors
  Left = 351
  Top = 301
  Width = 893
  Height = 575
  Caption = 'Vendors'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Default'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 877
    Height = 37
    Align = alTop
    TabOrder = 0
    object rgRowPanel: TRadioGroup
      Left = 4
      Top = -1
      Width = 233
      Height = 36
      Columns = 2
      ItemIndex = 1
      Items.Strings = (
        'Row panel'
        'Row line')
      TabOrder = 0
      OnClick = rgRowPanelClick
    end
    object DBNavigator1: TDBNavigator
      Left = 240
      Top = 6
      Width = 240
      Height = 25
      DataSource = dsVend
      Flat = True
      TabOrder = 1
    end
  end
  object DBGridEh1: TDBGridEh
    Left = 0
    Top = 37
    Width = 877
    Height = 500
    Align = alClient
    ColumnDefValues.AlwaysShowEditButton = True
    ColumnDefValues.Title.TitleButton = True
    ColumnDefValues.Title.ToolTips = True
    ColumnDefValues.ToolTips = True
    DataSource = dsVend
    DynProps = <>
    Flat = True
    FooterParams.Color = clWindow
    IndicatorOptions = [gioShowRowIndicatorEh, gioShowRecNoEh]
    IndicatorTitle.ShowDropDownSign = True
    IndicatorTitle.TitleButton = True
    OddRowColor = clInactiveBorder
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghIncSearch, dghRowHighlight, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghHotTrack, dghExtendVertLines]
    ParentShowHint = False
    RowDetailPanel.Active = True
    RowDetailPanel.Height = 300
    ShowHint = True
    SortLocal = True
    STFilter.InstantApply = True
    STFilter.Local = True
    STFilter.Location = stflInTitleFilterEh
    STFilter.Visible = True
    TabOrder = 1
    Columns = <
      item
        Color = clMenu
        DynProps = <>
        EditButtons = <>
        FieldName = 'VendorNo'
        Footers = <>
        ReadOnly = True
        Width = 67
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'VendorName'
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Address1'
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Address2'
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'City'
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'State'
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Zip'
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Country'
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Phone'
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'FAX'
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Preferred'
        Footers = <>
      end>
    object RowDetailData: TRowDetailPanelControlEh
      object PageControl1: TPageControl
        Left = 0
        Top = 0
        Width = 697
        Height = 298
        ActivePage = TabSheet1
        Align = alClient
        TabOrder = 0
        object TabSheet1: TTabSheet
          Caption = 'Parts'
          object DBGridEh2: TDBGridEh
            Left = 0
            Top = 0
            Width = 689
            Height = 270
            Align = alClient
            ColumnDefValues.Title.ToolTips = True
            ColumnDefValues.ToolTips = True
            DataSource = dsParts
            DynProps = <>
            EditActions = [geaCopyEh, geaSelectAllEh]
            Flat = True
            FooterParams.Color = clWindow
            IndicatorOptions = [gioShowRowIndicatorEh, gioShowRecNoEh]
            IndicatorTitle.ShowDropDownSign = True
            IndicatorTitle.TitleButton = True
            Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
            OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghRowHighlight, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
            RowPanel.Active = True
            STFilter.InstantApply = True
            STFilter.Local = True
            STFilter.Location = stflInTitleFilterEh
            STFilter.Visible = True
            TabOrder = 0
            VertScrollBar.SmoothStep = True
            Columns = <
              item
                DynProps = <>
                EditButtons = <>
                FieldName = 'PartNo'
                Footers = <>
                InRowLineHeight = 2
              end
              item
                DynProps = <>
                EditButtons = <>
                FieldName = 'OnHand'
                Footers = <>
                Width = 62
              end
              item
                DynProps = <>
                EditButtons = <>
                FieldName = 'Description'
                Footers = <>
                Width = 257
                InRowLinePos = 1
              end
              item
                DynProps = <>
                EditButtons = <>
                FieldName = 'OnOrder'
                Footers = <>
              end
              item
                DynProps = <>
                EditButtons = <>
                FieldName = 'Cost'
                Footers = <>
              end
              item
                DynProps = <>
                EditButtons = <>
                FieldName = 'ListPrice'
                Footers = <>
              end
              item
                DynProps = <>
                EditButtons = <>
                FieldName = 'VendorNo'
                Footers = <>
                Width = 60
                InRowLineHeight = 2
              end>
            object RowDetailData: TRowDetailPanelControlEh
            end
          end
        end
      end
    end
  end
  object mtVend: TMemTableEh
    FetchAllOnOpen = True
    Params = <>
    DataDriver = ddrVend
    Left = 1072
    Top = 88
  end
  object ddrVend: TADODataDriverEh
    ConnectionProvider = MainForm.ADOConnectionProviderEh1
    DynaSQLParams.Options = []
    MacroVars.SpecMacrosUsages = []
    MacroVars.Macros = <>
    SpecParams.Strings = (
      'AUTO_INCREMENT_FIELD=VendorNo')
    SelectCommand.CommandText.Strings = (
      'select'
      '  VendorNo'
      '  ,VendorName'
      '  ,Address1'
      '  ,Address2'
      '  ,City'
      '  ,State'
      '  ,Zip'
      '  ,Country'
      '  ,Phone'
      '  ,FAX'
      '  ,Preferred'
      'from'
      '  vendors')
    SelectCommand.Parameters = <>
    UpdateCommand.CommandText.Strings = (
      'update vendors'
      'set'
      '  VendorName = :VendorName,'
      '  Address1 = :Address1,'
      '  Address2 = :Address2,'
      '  City = :City,'
      '  State = :State,'
      '  Zip = :Zip,'
      '  Country = :Country,'
      '  Phone = :Phone,'
      '  FAX = :FAX,'
      '  Preferred = :Preferred'
      'where'
      '  VendorNo = :OLD_VendorNo')
    UpdateCommand.Parameters = <
      item
        Name = 'VendorName'
        DataType = ftString
        Size = -1
        Value = Null
      end
      item
        Name = 'Address1'
        DataType = ftString
        Size = -1
        Value = Null
      end
      item
        Name = 'Address2'
        DataType = ftString
        Size = -1
        Value = Null
      end
      item
        Name = 'City'
        DataType = ftString
        Size = -1
        Value = Null
      end
      item
        Name = 'State'
        DataType = ftString
        Size = -1
        Value = Null
      end
      item
        Name = 'Zip'
        DataType = ftString
        Size = -1
        Value = Null
      end
      item
        Name = 'Country'
        DataType = ftString
        Size = -1
        Value = Null
      end
      item
        Name = 'Phone'
        DataType = ftString
        Size = -1
        Value = Null
      end
      item
        Name = 'FAX'
        DataType = ftString
        Size = -1
        Value = Null
      end
      item
        Name = 'Preferred'
        DataType = ftString
        Size = -1
        Value = Null
      end
      item
        Name = 'OLD_VendorNo'
        DataType = ftString
        Size = -1
        Value = Null
      end>
    InsertCommand.CommandText.Strings = (
      'insert into vendors'
      '  (VendorName, Address1, Address2, City, State, Zip, Country, '
      'Phone, FAX, '
      '   Preferred)'
      'values'
      '  (:VendorName, :Address1, :Address2, :City, :State, :Zip, '
      ':Country, :Phone, '
      '   :FAX, :Preferred)')
    InsertCommand.Parameters = <
      item
        Name = 'VendorName'
        DataType = ftString
        Size = 1
        Value = Null
      end
      item
        Name = 'Address1'
        DataType = ftString
        Size = -1
        Value = Null
      end
      item
        Name = 'Address2'
        DataType = ftString
        Size = -1
        Value = Null
      end
      item
        Name = 'City'
        DataType = ftString
        Size = -1
        Value = Null
      end
      item
        Name = 'State'
        DataType = ftString
        Size = -1
        Value = Null
      end
      item
        Name = 'Zip'
        DataType = ftString
        Size = -1
        Value = Null
      end
      item
        Name = 'Country'
        DataType = ftString
        Size = -1
        Value = Null
      end
      item
        Name = 'Phone'
        DataType = ftString
        Size = -1
        Value = Null
      end
      item
        Name = 'FAX'
        DataType = ftString
        Size = -1
        Value = Null
      end
      item
        Name = 'Preferred'
        DataType = ftString
        Size = -1
        Value = Null
      end>
    DeleteCommand.CommandText.Strings = (
      'delete from vendors'
      'where'
      '  VendorNo = :OLD_VendorNo')
    DeleteCommand.Parameters = <
      item
        Name = 'OLD_VendorNo'
        DataType = ftString
        Size = -1
        Value = Null
      end>
    GetrecCommand.CommandText.Strings = (
      'select'
      '  VendorNo'
      '  ,VendorName'
      '  ,Address1'
      '  ,Address2'
      '  ,City'
      '  ,State'
      '  ,Zip'
      '  ,Country'
      '  ,Phone'
      '  ,FAX'
      '  ,Preferred'
      'from'
      '  vendors'
      'where'
      '  VendorNo = :OLD_VendorNo')
    GetrecCommand.Parameters = <
      item
        Name = 'OLD_VendorNo'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    Left = 1072
    Top = 120
  end
  object dsVend: TDataSource
    DataSet = mtVend
    Left = 1072
    Top = 56
  end
  object dsParts: TDataSource
    DataSet = mtParts
    Left = 1112
    Top = 56
  end
  object mtParts: TMemTableEh
    DetailFields = 'VendorNo'
    FetchAllOnOpen = True
    MasterDetailSide = mdsOnProviderEh
    MasterFields = 'VendorNo'
    MasterSource = dsVend
    Params = <>
    DataDriver = ddrParts
    Left = 1112
    Top = 88
  end
  object ddrParts: TADODataDriverEh
    ConnectionProvider = MainForm.ADOConnectionProviderEh1
    DynaSQLParams.Options = []
    MacroVars.SpecMacrosUsages = []
    MacroVars.Macros = <>
    SpecParams.Strings = (
      'AUTO_INCREMENT_FIELD=PartNo')
    SelectCommand.CommandText.Strings = (
      'select'
      '   PartNo'
      '  ,VendorNo'
      '  ,Description'
      '  ,OnHand'
      '  ,OnOrder'
      '  ,Cost'
      '  ,ListPrice'
      'from'
      '  parts'
      'where '
      '  VendorNo = :VendorNo')
    SelectCommand.Parameters = <
      item
        Name = 'VendorNo'
        DataType = ftInteger
        Size = 4
        Value = 1
      end>
    UpdateCommand.CommandText.Strings = (
      'update parts'
      'set'
      '  VendorNo = :VendorNo,'
      '  Description = :Description,'
      '  OnHand = :OnHand,'
      '  OnOrder = :OnOrder,'
      '  Cost = :Cost,'
      '  ListPrice = :ListPrice'
      'where'
      '  PartNo = :OLD_PartNo')
    UpdateCommand.Parameters = <
      item
        Name = 'VendorNo'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'Description'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'OnHand'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'OnOrder'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'Cost'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'ListPrice'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'OLD_PartNo'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    InsertCommand.CommandText.Strings = (
      'insert into parts'
      '  (VendorNo, Description, OnHand, OnOrder, Cost, ListPrice)'
      'values'
      '  (:VendorNo, :Description, :OnHand, :OnOrder, :Cost, '
      ':ListPrice)')
    InsertCommand.Parameters = <
      item
        Name = 'VendorNo'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'Description'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'OnHand'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'OnOrder'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'Cost'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'ListPrice'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    DeleteCommand.CommandText.Strings = (
      'delete from parts'
      'where'
      '  PartNo = :OLD_PartNo')
    DeleteCommand.Parameters = <
      item
        Name = 'OLD_PartNo'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    GetrecCommand.CommandText.Strings = (
      'select'
      '   PartNo'
      '  ,VendorNo'
      '  ,Description'
      '  ,OnHand'
      '  ,OnOrder'
      '  ,Cost'
      '  ,ListPrice'
      'from'
      '  parts'
      'where '
      '  PartNo = :OLD_PartNo')
    GetrecCommand.Parameters = <
      item
        Name = 'OLD_PartNo'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    Left = 1112
    Top = 120
  end
end
