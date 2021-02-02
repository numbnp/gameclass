object Form1: TForm1
  Left = 347
  Top = 124
  Width = 607
  Height = 700
  Caption = 'Form1'
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 585
    Top = 41
    Width = 6
    Height = 621
    Align = alRight
  end
  object DBGridEh1: TDBGridEh
    Left = 0
    Top = 41
    Width = 585
    Height = 621
    Align = alClient
    DataSource = DataSource1
    DynProps = <>
    Flat = True
    IndicatorOptions = [gioShowRowIndicatorEh, gioShowRecNoEh]
    OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
    TabOrder = 0
    Columns = <
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'geonameid'
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'gname'
        Footers = <>
        Width = 134
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'asciiname'
        Footers = <>
        Width = 158
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'latitude'
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'longitude'
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'feature_class'
        Footers = <>
        Width = 23
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'feature_code'
        Footers = <>
        Width = 80
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'country_code'
        Footers = <>
        Width = 81
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'cc2'
        Footers = <>
        Width = 40
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'admin1_code'
        Footers = <>
        Width = 58
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'admin2_code'
        Footers = <>
        Width = 50
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'admin3_code'
        Footers = <>
        Width = 68
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'admin4_code'
        Footers = <>
        Width = 77
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'population'
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'elevation'
        Footers = <>
        Width = 50
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'dem'
        Footers = <>
        Width = 62
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'timezone'
        Footers = <>
        Width = 115
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'modification_date'
        Footers = <>
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 591
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object Button1: TButton
      Left = 8
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Reopen'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
  object ADOConnectionProviderEh1: TADOConnectionProviderEh
    InlineConnection.Connected = True
    InlineConnection.ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=%PROJECT_PATH%\..\D' +
      'ata\cities10000.mdb;Persist Security Info=False'
    InlineConnection.Mode = cmShareDenyNone
    InlineConnection.Provider = 'Microsoft.Jet.OLEDB.4.0'
    ServerType = 'MSAccess'
    InlineConnectionBeforeConnect = ADOConnectionProviderEh1InlineConnectionBeforeConnect
    Left = 8
    Top = 328
  end
  object ADODataDriverEh1: TADODataDriverEh
    ConnectionProvider = ADOConnectionProviderEh1
    DynaSQLParams.Options = []
    MacroVars.Macros = <>
    SelectCommand.CommandText.Strings = (
      'select *'
      'from'
      '  Cities1000Small')
    SelectCommand.Parameters = <>
    UpdateCommand.Parameters = <>
    InsertCommand.Parameters = <>
    DeleteCommand.Parameters = <>
    GetrecCommand.Parameters = <>
    Left = 40
    Top = 328
  end
  object MemTableEh1: TMemTableEh
    FetchAllOnOpen = True
    Params = <>
    DataDriver = ADODataDriverEh1
    Left = 72
    Top = 328
  end
  object DataSource1: TDataSource
    DataSet = MemTableEh1
    Left = 104
    Top = 328
  end
end
