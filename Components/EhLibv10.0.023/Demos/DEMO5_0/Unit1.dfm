object Form1: TForm1
  Left = 108
  Top = 189
  Width = 1143
  Height = 774
  Caption = 'Second Complex Demo Project'
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Microsoft Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    1127
    736)
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 1127
    Height = 736
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Customers'
      object DBGridEh1: TDBGridEh
        Left = 0
        Top = 0
        Width = 1119
        Height = 708
        Align = alClient
        AllowedSelections = [gstRecordBookmarks, gstRectangle, gstAll]
        ColumnDefValues.AlwaysShowEditButton = True
        ColumnDefValues.Title.TitleButton = True
        ColumnDefValues.ToolTips = True
        Ctl3D = True
        DataSource = DataSource1
        DynProps = <>
        EditActions = [geaCopyEh, geaSelectAllEh]
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        FooterRowCount = 1
        FooterParams.Color = clBtnFace
        IndicatorOptions = [gioShowRowIndicatorEh, gioShowRecNoEh]
        IndicatorTitle.ShowDropDownSign = True
        IndicatorTitle.TitleButton = True
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
        OptionsEh = [dghFixed3D, dghFooter3D, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghTraceColSizing, dghIncSearch, dghPreferIncSearch, dghRowHighlight, dghDblClickOptimizeColWidth, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghHotTrack, dghExtendVertLines]
        ParentCtl3D = False
        ParentFont = False
        ParentShowHint = False
        RowDetailPanel.Active = True
        RowDetailPanel.Height = 220
        RowSizingAllowed = True
        ShowHint = True
        SortLocal = True
        STFilter.Local = True
        STFilter.Location = stflInTitleFilterEh
        STFilter.Visible = True
        TabOrder = 0
        TitleParams.MultiTitle = True
        OnEnter = DBGridEh1Enter
        OnExit = DBGridEh1Exit
        OnRowDetailPanelShow = DBGridEh1RowDetailPanelShow
        Columns = <
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'CustNo'
            Footers = <>
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'Company'
            Footers = <>
            Width = 128
          end
          item
            ButtonStyle = cbsAltDropDown
            DynProps = <>
            EditButtons = <>
            FieldName = 'TaxRate'
            Footers = <>
          end
          item
            ButtonStyle = cbsAltDropDown
            DynProps = <>
            EditButtons = <
              item
                Style = ebsEllipsisEh
                OnClick = DBGridEh1Columns3EditButtons0Click
              end>
            FieldName = 'LastInvoiceDate'
            Footers = <>
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'Addr1'
            Footers = <>
            Width = 145
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'Addr2'
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
            FieldName = 'Contact'
            Footers = <>
          end>
        object TRowDetailPanelControlEh
          object PageControl2: TPageControl
            Left = 0
            Top = 0
            Width = 1072
            Height = 218
            ActivePage = TabSheet3
            Align = alClient
            TabOrder = 0
            object TabSheet3: TTabSheet
              Caption = 'Orders'
              object DBGridEh2: TDBGridEh
                Left = 0
                Top = 0
                Width = 1064
                Height = 190
                Align = alClient
                ColumnDefValues.AlwaysShowEditButton = True
                Ctl3D = True
                DataSource = DataSource2
                DynProps = <>
                Flat = True
                FooterParams.Color = clWindow
                IndicatorOptions = [gioShowRowIndicatorEh]
                OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghColumnResize, dghColumnMove, dghHotTrack, dghExtendVertLines]
                ParentCtl3D = False
                RowDetailPanel.Height = 50
                RowPanel.Active = True
                TabOrder = 0
                VertScrollBar.SmoothStep = True
                OnEnter = DBGridEh1Enter
                OnExit = DBGridEh1Exit
                Columns = <
                  item
                    DynProps = <>
                    EditButtons = <>
                    FieldName = 'OrderNo'
                    Footers = <>
                    Width = 62
                  end
                  item
                    DynProps = <>
                    EditButtons = <>
                    FieldName = 'CustNo'
                    Footers = <>
                    Width = 62
                    InRowLinePos = 1
                  end
                  item
                    DynProps = <>
                    EditButtons = <>
                    FieldName = 'SaleDate'
                    Footers = <>
                    Width = 127
                  end
                  item
                    DynProps = <>
                    EditButtons = <>
                    FieldName = 'ShipDate'
                    Footers = <>
                    Width = 127
                    InRowLinePos = 1
                  end
                  item
                    DynProps = <>
                    EditButtons = <>
                    FieldName = 'ShipVIA'
                    Footers = <>
                    Width = 119
                  end
                  item
                    DynProps = <>
                    EditButtons = <>
                    FieldName = 'PaymentMethod'
                    Footers = <>
                    Width = 119
                    InRowLinePos = 1
                  end
                  item
                    ButtonStyle = cbsDropDown
                    DynProps = <>
                    EditButtons = <>
                    FieldName = 'ItemsTotal'
                    Footers = <>
                    Width = 99
                  end
                  item
                    ButtonStyle = cbsDropDown
                    DynProps = <>
                    EditButtons = <>
                    FieldName = 'AmountPaid'
                    Footers = <>
                    Width = 99
                    InRowLinePos = 1
                  end
                  item
                    DynProps = <>
                    EditButtons = <>
                    FieldName = 'TaxRate'
                    Footers = <>
                    Width = 119
                  end
                  item
                    DynProps = <>
                    EditButtons = <>
                    FieldName = 'Freight'
                    Footers = <>
                    Width = 119
                    InRowLinePos = 1
                  end
                  item
                    DynProps = <>
                    EditButtons = <>
                    FieldName = 'ShipToAddr1'
                    Footers = <>
                    Visible = False
                    Width = 52
                  end
                  item
                    DynProps = <>
                    EditButtons = <>
                    FieldName = 'EmpNo'
                    Footers = <>
                    Visible = False
                    Width = 52
                  end
                  item
                    DynProps = <>
                    EditButtons = <>
                    FieldName = 'ShipToCity'
                    Footers = <>
                    Visible = False
                    Width = 52
                  end
                  item
                    DynProps = <>
                    EditButtons = <>
                    FieldName = 'ShipToPhone'
                    Footers = <>
                    Visible = False
                    Width = 52
                  end
                  item
                    DynProps = <>
                    EditButtons = <>
                    FieldName = 'ShipToZip'
                    Footers = <>
                    Visible = False
                    Width = 52
                  end
                  item
                    DynProps = <>
                    EditButtons = <>
                    FieldName = 'ShipToAddr2'
                    Footers = <>
                    Visible = False
                    Width = 52
                  end
                  item
                    DynProps = <>
                    EditButtons = <>
                    FieldName = 'Terms'
                    Footers = <>
                    Visible = False
                    Width = 52
                  end
                  item
                    DynProps = <>
                    EditButtons = <>
                    FieldName = 'ShipToCountry'
                    Footers = <>
                    Visible = False
                    Width = 52
                  end
                  item
                    DynProps = <>
                    EditButtons = <>
                    FieldName = 'ShipToContact'
                    Footers = <>
                    Visible = False
                    Width = 52
                  end
                  item
                    DynProps = <>
                    EditButtons = <>
                    FieldName = 'ShipToState'
                    Footers = <>
                    Visible = False
                    Width = 52
                  end
                  item
                    DynProps = <>
                    EditButtons = <>
                    FieldName = 'PO'
                    Footers = <>
                    Visible = False
                    Width = 52
                  end>
                object RowDetailData: TRowDetailPanelControlEh
                end
              end
            end
            object TabSheet4: TTabSheet
              Caption = 'Customer details'
              ImageIndex = 1
              object ScrollBox1: TScrollBox
                Left = 0
                Top = 0
                Width = 637
                Height = 190
                HorzScrollBar.Tracking = True
                VertScrollBar.Tracking = True
                Align = alClient
                BorderStyle = bsNone
                TabOrder = 0
                object Label1: TLabel
                  Left = 7
                  Top = 7
                  Width = 17
                  Height = 13
                  Caption = 'City'
                end
                object Label2: TLabel
                  Left = 7
                  Top = 33
                  Width = 36
                  Height = 13
                  Caption = 'Country'
                end
                object Label3: TLabel
                  Left = 7
                  Top = 59
                  Width = 35
                  Height = 13
                  Caption = 'CustNo'
                end
                object Label4: TLabel
                  Left = 7
                  Top = 85
                  Width = 20
                  Height = 13
                  Caption = 'FAX'
                end
                object Label5: TLabel
                  Left = 7
                  Top = 111
                  Width = 78
                  Height = 13
                  Caption = 'LastInvoiceDate'
                end
                object Label6: TLabel
                  Left = 7
                  Top = 137
                  Width = 31
                  Height = 13
                  Caption = 'Phone'
                end
                object Label7: TLabel
                  Left = 7
                  Top = 163
                  Width = 25
                  Height = 13
                  Caption = 'State'
                end
                object DBEditEh1: TDBEditEh
                  Left = 98
                  Top = 7
                  Width = 98
                  Height = 21
                  DataField = 'City'
                  DataSource = DataSource1
                  DynProps = <>
                  EditButtons = <>
                  ShowHint = True
                  TabOrder = 0
                  Visible = True
                end
                object DBEditEh2: TDBEditEh
                  Left = 98
                  Top = 33
                  Width = 98
                  Height = 21
                  DataField = 'Country'
                  DataSource = DataSource1
                  DynProps = <>
                  EditButtons = <>
                  ShowHint = True
                  TabOrder = 1
                  Visible = True
                end
                object DBEditEh3: TDBEditEh
                  Left = 98
                  Top = 59
                  Width = 98
                  Height = 21
                  DataField = 'CustNo'
                  DataSource = DataSource1
                  DynProps = <>
                  EditButtons = <>
                  ShowHint = True
                  TabOrder = 2
                  Visible = True
                end
                object DBEditEh4: TDBEditEh
                  Left = 98
                  Top = 85
                  Width = 98
                  Height = 21
                  DataField = 'FAX'
                  DataSource = DataSource1
                  DynProps = <>
                  EditButtons = <>
                  ShowHint = True
                  TabOrder = 3
                  Visible = True
                end
                object DBEditEh6: TDBEditEh
                  Left = 98
                  Top = 137
                  Width = 98
                  Height = 21
                  DataField = 'Phone'
                  DataSource = DataSource1
                  DynProps = <>
                  EditButtons = <>
                  ShowHint = True
                  TabOrder = 4
                  Visible = True
                end
                object DBEditEh7: TDBEditEh
                  Left = 98
                  Top = 163
                  Width = 98
                  Height = 21
                  DataField = 'State'
                  DataSource = DataSource1
                  DynProps = <>
                  EditButtons = <>
                  ShowHint = True
                  TabOrder = 5
                  Visible = True
                end
                object DBDateTimeEditEh1: TDBDateTimeEditEh
                  Left = 98
                  Top = 110
                  Width = 98
                  Height = 21
                  DataField = 'LastInvoiceDate'
                  DataSource = DataSource1
                  DynProps = <>
                  EditButton.Style = ebsAltDropDownEh
                  EditButtons = <
                    item
                      Style = ebsEllipsisEh
                    end>
                  Kind = dtkDateEh
                  ShowHint = True
                  TabOrder = 6
                  Visible = True
                end
              end
            end
          end
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'BioLife #1'
      ImageIndex = 1
      object DBGridEh3: TDBGridEh
        Left = 0
        Top = 0
        Width = 1119
        Height = 708
        Align = alClient
        DataSource = dsBioLife
        DynProps = <>
        Flat = True
        FooterParams.Color = clWindow
        IndicatorOptions = [gioShowRowIndicatorEh, gioShowRecNoEh]
        OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghRowHighlight, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghHotTrack, dghExtendVertLines]
        RowDetailPanel.Active = True
        RowDetailPanel.Height = 300
        TabOrder = 0
        OnEnter = DBGridEh1Enter
        OnExit = DBGridEh1Exit
        Columns = <
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'Species No'
            Footers = <>
            Width = 148
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'Category'
            Footers = <>
            Width = 110
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'Common_name'
            Footers = <>
            Width = 158
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'Species Name'
            Footers = <>
            Width = 170
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'Length (cm)'
            Footers = <>
            Width = 52
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'Length_In'
            Footers = <>
            Width = 52
          end>
        object RowDetailData: TRowDetailPanelControlEh
          object PageControl3: TPageControl
            Left = 0
            Top = 0
            Width = 675
            Height = 298
            ActivePage = TabSheet5
            Align = alClient
            TabOrder = 0
            object TabSheet5: TTabSheet
              Caption = 'Graphic'
              object DBImage1: TDBImage
                Left = 0
                Top = 0
                Width = 667
                Height = 270
                Align = alClient
                BorderStyle = bsNone
                DataField = 'Graphic'
                DataSource = dsBioLife
                TabOrder = 0
              end
            end
            object TabSheet6: TTabSheet
              Caption = 'Notes'
              ImageIndex = 1
              object DBMemo1: TDBMemo
                Left = 0
                Top = 0
                Width = 667
                Height = 270
                Align = alClient
                BorderStyle = bsNone
                DataField = 'Notes'
                DataSource = dsBioLife
                TabOrder = 0
              end
            end
          end
        end
      end
    end
    object TabSheet7: TTabSheet
      Caption = 'BioLife #2'
      ImageIndex = 2
      object DBGridEh4: TDBGridEh
        Left = 0
        Top = 0
        Width = 1119
        Height = 708
        Align = alClient
        AutoFitColWidths = True
        IncludeImageModules = [iimJpegImageModuleEh]
        DataSource = dsBioLife
        DrawGraphicData = True
        DrawMemoText = True
        DynProps = <>
        Flat = True
        FooterParams.Color = clWindow
        IndicatorOptions = [gioShowRowIndicatorEh, gioShowRecNoEh]
        OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghRowHighlight, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghAutoFitRowHeight, dghExtendVertLines]
        RowDetailPanel.Height = 300
        TabOrder = 0
        TitleParams.MultiTitle = True
        VertScrollBar.SmoothStep = True
        OnEnter = DBGridEh1Enter
        OnExit = DBGridEh1Exit
        Columns = <
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'Species No'
            Footers = <>
            Visible = False
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'Category'
            Footers = <>
            Visible = False
            Width = 56
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'Common_name'
            Footers = <>
            Width = 82
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'Species Name'
            Footers = <>
            Visible = False
            Width = 85
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'Length (cm)'
            Footers = <>
            Visible = False
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'Length_In'
            Footers = <>
            Visible = False
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'Notes'
            Footers = <>
            Width = 383
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'Graphic'
            Footers = <>
            Width = 195
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
    object TabSheet8: TTabSheet
      Caption = 'BioLife #3'
      ImageIndex = 3
      object DBGridEh5: TDBGridEh
        Left = 0
        Top = 0
        Width = 1119
        Height = 708
        Align = alClient
        AutoFitColWidths = True
        DataSource = dsBioLife
        DrawGraphicData = True
        DrawMemoText = True
        DynProps = <>
        Flat = True
        FooterParams.Color = clWindow
        IndicatorOptions = [gioShowRowIndicatorEh, gioShowRecNoEh]
        OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghRowHighlight, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghHotTrack, dghExtendVertLines]
        RowDetailPanel.Height = 300
        RowSizingAllowed = True
        RowPanel.Active = True
        TabOrder = 0
        VertScrollBar.SmoothStep = True
        OnEnter = DBGridEh1Enter
        OnExit = DBGridEh1Exit
        Columns = <
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'Species No'
            Footers = <>
            Width = 49
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'Notes'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -9
            Font.Name = 'Microsoft Sans Serif'
            Font.Style = []
            Footers = <>
            Width = 480
            InRowLinePos = 1
            InRowLineHeight = 4
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'Category'
            Footers = <>
            Width = 91
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'Common_name'
            Footers = <>
            Width = 115
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'Species Name'
            Footers = <>
            Width = 152
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'Length (cm)'
            Footers = <>
            Width = 69
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'Length_In'
            Footers = <>
            Visible = False
            Width = 47
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'Graphic'
            Footers = <>
            Title.Alignment = taCenter
            Width = 203
            InRowLineHeight = 5
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
  end
  object DBNavigator1: TDBNavigator
    Left = 824
    Top = 2
    Width = 200
    Height = 18
    Anchors = [akTop, akRight]
    Flat = True
    TabOrder = 1
  end
  object DataSource1: TDataSource
    DataSet = mtTable1
    Left = 974
    Top = 374
  end
  object mtTable1: TMemTableEh
    Active = True
    CachedUpdates = True
    FetchAllOnOpen = True
    Params = <>
    DataDriver = ADOdsdTable1
    Left = 1066
    Top = 375
  end
  object MemTableEh1: TMemTableEh
    Active = True
    CachedUpdates = True
    DetailFields = 'CustNo'
    FetchAllOnOpen = True
    MasterFields = 'CustNo'
    MasterSource = DataSource1
    Params = <>
    DataDriver = ADODataDriverEh1
    Left = 1066
    Top = 407
  end
  object DataSource2: TDataSource
    DataSet = MemTableEh1
    Left = 974
    Top = 406
  end
  object dsBioLife: TDataSource
    DataSet = mtBioLife
    Left = 974
    Top = 454
  end
  object mtBioLife: TMemTableEh
    Active = True
    CachedUpdates = True
    FetchAllOnOpen = True
    Params = <>
    DataDriver = ADOddrBioLife
    Left = 1066
    Top = 455
  end
  object ADOConnectionProviderEh1: TADOConnectionProviderEh
    InlineConnection.Connected = True
    InlineConnection.ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=%PROJECT_PATH%\..\D' +
      'ata\DBTest.mdb;Persist Security Info=False'
    InlineConnection.Mode = cmShareDenyNone
    InlineConnection.Provider = 'Microsoft.Jet.OLEDB.4.0'
    ServerType = 'MSAccess'
    InlineConnectionBeforeConnect = ADOConnectionProviderEh1InlineConnectionBeforeConnect
    Left = 1060
    Top = 272
  end
  object ADOdsdTable1: TADODataDriverEh
    ConnectionProvider = ADOConnectionProviderEh1
    DynaSQLParams.Options = []
    MacroVars.Macros = <>
    SelectCommand.CommandText.Strings = (
      'select *'
      'from'
      '  customer')
    SelectCommand.Parameters = <>
    UpdateCommand.Parameters = <>
    InsertCommand.Parameters = <>
    DeleteCommand.Parameters = <>
    GetrecCommand.Parameters = <>
    Left = 940
    Top = 376
  end
  object ADODataDriverEh1: TADODataDriverEh
    ConnectionProvider = ADOConnectionProviderEh1
    DynaSQLParams.Options = []
    MacroVars.Macros = <>
    SelectCommand.CommandText.Strings = (
      'select *'
      'from'
      '  orders')
    SelectCommand.Parameters = <>
    UpdateCommand.Parameters = <>
    InsertCommand.Parameters = <>
    DeleteCommand.Parameters = <>
    GetrecCommand.Parameters = <>
    Left = 940
    Top = 408
  end
  object ADOddrBioLife: TADODataDriverEh
    ConnectionProvider = ADOBioConnectionProviderEh
    DynaSQLParams.Options = []
    MacroVars.Macros = <>
    SelectCommand.CommandText.Strings = (
      'select *'
      'from'
      '  BioLife')
    SelectCommand.Parameters = <>
    UpdateCommand.Parameters = <>
    InsertCommand.Parameters = <>
    DeleteCommand.Parameters = <>
    GetrecCommand.Parameters = <>
    OnBuildDataStruct = ADOddrBioLifeBuildDataStruct
    Left = 940
    Top = 456
  end
  object ADOBioConnectionProviderEh: TADOConnectionProviderEh
    InlineConnection.Connected = True
    InlineConnection.ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=%PROJECT_PATH%\..\D' +
      'ata\BioLife.mdb;Persist Security Info=False'
    InlineConnection.Mode = cmShareDenyNone
    InlineConnection.Provider = 'Microsoft.Jet.OLEDB.4.0'
    ServerType = 'MSAccess'
    InlineConnectionBeforeConnect = ADOBioConnectionProviderEhInlineConnectionBeforeConnect
    Left = 1060
    Top = 312
  end
end
