object frRowDetailPanel: TfrRowDetailPanel
  Left = 0
  Top = 0
  Width = 596
  Height = 404
  ParentBackground = False
  TabOrder = 0
  object DBGridEh7: TDBGridEh
    Left = 0
    Top = 33
    Width = 596
    Height = 371
    Align = alClient
    AllowedSelections = [gstRecordBookmarks, gstRectangle, gstAll]
    Border.EdgeBorders = [ebTop, ebBottom]
    ColumnDefValues.AlwaysShowEditButton = True
    ColumnDefValues.Title.TitleButton = True
    ColumnDefValues.ToolTips = True
    Ctl3D = True
    DataSource = dsCustomersRDP
    DynProps = <>
    EditActions = [geaCopyEh, geaSelectAllEh]
    Flat = True
    FooterRowCount = 1
    FooterParams.Color = clBtnFace
    IndicatorOptions = [gioShowRowIndicatorEh, gioShowRecNoEh]
    IndicatorParams.RecNoShowStep = 10
    IndicatorTitle.ShowDropDownSign = True
    IndicatorTitle.TitleButton = True
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
    OptionsEh = [dghFixed3D, dghFooter3D, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghTraceColSizing, dghIncSearch, dghPreferIncSearch, dghRowHighlight, dghDblClickOptimizeColWidth, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghHotTrack, dghExtendVertLines]
    ParentCtl3D = False
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
        Width = 549
        Height = 218
        ActivePage = TabSheet8
        Align = alClient
        TabOrder = 0
        object TabSheet8: TTabSheet
          Caption = 'Orders'
          object DBGridEh8: TDBGridEh
            Left = 0
            Top = 0
            Width = 541
            Height = 190
            Align = alClient
            ColumnDefValues.AlwaysShowEditButton = True
            Ctl3D = True
            DataSource = dsOrdersRDP
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
                FieldName = 'ShipToCountry'
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
                FieldName = 'ShipToContact'
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
                FieldName = 'ShipToAddr2'
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
                FieldName = 'ShipToAddr1'
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
                FieldName = 'ShipToZip'
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
              end>
            object RowDetailData: TRowDetailPanelControlEh
            end
          end
        end
        object TabSheet9: TTabSheet
          Caption = 'Customer details'
          ImageIndex = 1
          object ScrollBox1: TScrollBox
            Left = 0
            Top = 0
            Width = 541
            Height = 190
            HorzScrollBar.Tracking = True
            VertScrollBar.Tracking = True
            Align = alClient
            BorderStyle = bsNone
            TabOrder = 0
            object Label25: TStaticText
              Left = 7
              Top = 33
              Width = 40
              Height = 17
              Caption = 'Country'
              TabOrder = 8
            end
            object Label26: TStaticText
              Left = 7
              Top = 59
              Width = 39
              Height = 17
              Caption = 'CustNo'
              TabOrder = 9
            end
            object Label27: TStaticText
              Left = 7
              Top = 85
              Width = 24
              Height = 17
              Caption = 'FAX'
              TabOrder = 10
            end
            object Label28: TStaticText
              Left = 7
              Top = 111
              Width = 82
              Height = 17
              Caption = 'LastInvoiceDate'
              TabOrder = 11
            end
            object Label29: TStaticText
              Left = 7
              Top = 137
              Width = 35
              Height = 17
              Caption = 'Phone'
              TabOrder = 12
            end
            object Label30: TStaticText
              Left = 7
              Top = 163
              Width = 29
              Height = 17
              Caption = 'State'
              TabOrder = 13
            end
            object Label1: TStaticText
              Left = 7
              Top = 7
              Width = 21
              Height = 17
              Caption = 'City'
              TabOrder = 7
            end
            object DBEditEh3: TDBEditEh
              Left = 98
              Top = 7
              Width = 97
              Height = 21
              DataField = 'City'
              DataSource = dsCustomersRDP
              DynProps = <>
              EditButtons = <>
              ShowHint = True
              TabOrder = 0
              Visible = True
            end
            object DBEditEh4: TDBEditEh
              Left = 98
              Top = 33
              Width = 97
              Height = 21
              DataField = 'Country'
              DataSource = dsCustomersRDP
              DynProps = <>
              EditButtons = <>
              ShowHint = True
              TabOrder = 1
              Visible = True
            end
            object DBEditEh5: TDBEditEh
              Left = 98
              Top = 59
              Width = 97
              Height = 21
              DataField = 'CustNo'
              DataSource = dsCustomersRDP
              DynProps = <>
              EditButtons = <>
              ShowHint = True
              TabOrder = 2
              Visible = True
            end
            object DBEditEh6: TDBEditEh
              Left = 98
              Top = 85
              Width = 97
              Height = 21
              DataField = 'FAX'
              DataSource = dsCustomersRDP
              DynProps = <>
              EditButtons = <>
              ShowHint = True
              TabOrder = 3
              Visible = True
            end
            object DBEditEh7: TDBEditEh
              Left = 98
              Top = 137
              Width = 97
              Height = 21
              DataField = 'Phone'
              DataSource = dsCustomersRDP
              DynProps = <>
              EditButtons = <>
              ShowHint = True
              TabOrder = 4
              Visible = True
            end
            object DBEditEh8: TDBEditEh
              Left = 98
              Top = 163
              Width = 97
              Height = 21
              DataField = 'State'
              DataSource = dsCustomersRDP
              DynProps = <>
              EditButtons = <>
              ShowHint = True
              TabOrder = 5
              Visible = True
            end
            object DBDateTimeEditEh3: TDBDateTimeEditEh
              Left = 98
              Top = 110
              Width = 96
              Height = 21
              DataField = 'LastInvoiceDate'
              DataSource = dsCustomersRDP
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 596
    Height = 33
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object PaintBox1: TPaintBox
      Left = 0
      Top = 0
      Width = 596
      Height = 33
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      OnPaint = PaintBox1Paint
    end
    object Label2: TLabel
      Left = 22
      Top = 7
      Width = 163
      Height = 23
      Caption = 'Row Detail Panel'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object dsCustomersRDP: TDataSource
    DataSet = mtCustomersRDP
    Left = 206
    Top = 166
  end
  object mtCustomersRDP: TMemTableEh
    Active = True
    CachedUpdates = True
    FetchAllOnOpen = True
    Params = <>
    DataDriver = ADODataDriverEh1
    Left = 210
    Top = 215
  end
  object ADODataDriverEh1: TADODataDriverEh
    ConnectionProvider = Form1.ADOConnectionProviderEh1
    DynaSQLParams.Options = []
    MacroVars.Macros = <>
    SelectCommand.CommandText.Strings = (
      'select'
      '  *'
      'from'
      '  customer')
    SelectCommand.Parameters = <>
    UpdateCommand.Parameters = <>
    InsertCommand.Parameters = <>
    DeleteCommand.Parameters = <>
    GetrecCommand.Parameters = <>
    Left = 208
    Top = 264
  end
  object dsOrdersRDP: TDataSource
    DataSet = mtOrdersRDP
    Left = 302
    Top = 166
  end
  object mtOrdersRDP: TMemTableEh
    Active = True
    CachedUpdates = True
    DetailFields = 'CustNo'
    FetchAllOnOpen = True
    MasterFields = 'CustNo'
    MasterSource = dsCustomersRDP
    Params = <>
    DataDriver = ADODataDriverEh2
    Left = 300
    Top = 263
  end
  object ADODataDriverEh2: TADODataDriverEh
    ConnectionProvider = Form1.ADOConnectionProviderEh1
    DynaSQLParams.Options = []
    MacroVars.Macros = <>
    SelectCommand.CommandText.Strings = (
      'select'
      '  *'
      'from'
      '  orders')
    SelectCommand.Parameters = <>
    UpdateCommand.Parameters = <>
    InsertCommand.Parameters = <>
    DeleteCommand.Parameters = <>
    GetrecCommand.Parameters = <>
    Left = 296
    Top = 216
  end
end
