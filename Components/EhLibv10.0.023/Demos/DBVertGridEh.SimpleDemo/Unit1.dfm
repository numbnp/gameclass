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
    Left = 331
    Top = 41
    Width = 6
    Height = 621
    Align = alRight
  end
  object DBGridEh1: TDBGridEh
    Left = 0
    Top = 41
    Width = 331
    Height = 621
    Align = alClient
    DataSource = DataSource1
    DynProps = <>
    Flat = True
    IndicatorOptions = [gioShowRowIndicatorEh]
    TabOrder = 0
    Columns = <
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'SpeciesId'
        Footers = <>
        Width = 34
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Category'
        Footers = <>
        Width = 72
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Common_name'
        Footers = <>
        Width = 79
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Species_Name'
        Footers = <>
        Width = 67
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Length'
        Footers = <>
        Width = 31
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object DBVertGridEh1: TDBVertGridEh
    Left = 337
    Top = 41
    Width = 254
    Height = 621
    Align = alRight
    DataColParams.MaxRowHeight = 2
    DataColParams.MaxRowLines = 10
    DataSource = DataSource1
    DrawGraphicData = True
    DrawMemoText = True
    Flat = True
    RowsDefValues.FitRowHeightToData = True
    TabOrder = 1
    Rows = <
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'SpeciesId'
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Category'
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Common_name'
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Species_Name'
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Length'
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Notes'
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'Graphic'
        TextEditing = False
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 591
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object DBNavigator1: TDBNavigator
      Left = 6
      Top = 6
      Width = 200
      Height = 25
      DataSource = DataSource1
      Flat = True
      TabOrder = 0
    end
  end
  object ADOConnectionProviderEh1: TADOConnectionProviderEh
    InlineConnection.Connected = True
    InlineConnection.ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=%PROJECT_PATH%\..\D' +
      'ata\Biolife.mdb;Persist Security Info=False'
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
      '  Biolife')
    SelectCommand.Parameters = <>
    UpdateCommand.Parameters = <>
    InsertCommand.Parameters = <>
    DeleteCommand.Parameters = <>
    GetrecCommand.Parameters = <>
    OnBuildDataStruct = ADODataDriverEh1BuildDataStruct
    Left = 40
    Top = 328
  end
  object MemTableEh1: TMemTableEh
    Active = True
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
