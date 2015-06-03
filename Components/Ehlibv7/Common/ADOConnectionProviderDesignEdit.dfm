object FormADOConnProviderEdit: TFormADOConnProviderEdit
  Left = 513
  Top = 79
  Width = 412
  Height = 521
  Caption = 'ADOConnectionProviderDesignEdit'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    396
    483)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 17
    Top = 435
    Width = 344
    Height = 2
    Anchors = [akLeft, akRight, akBottom]
  end
  object GroupBox2: TGroupBox
    Left = 17
    Top = 215
    Width = 344
    Height = 211
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'ADO Connection parameters'
    TabOrder = 0
    DesignSize = (
      344
      211)
    object DBGridEh2: TDBGridEh
      Left = 5
      Top = 27
      Width = 335
      Height = 180
      AllowedOperations = [alopUpdateEh]
      Anchors = [akLeft, akTop, akRight, akBottom]
      AutoFitColWidths = True
      DataSource = dsConnParams
      DynProps = <>
      FooterParams.Color = clWindow
      IndicatorOptions = [gioShowRowIndicatorEh]
      TabOrder = 0
      Columns = <
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'Name'
          Footers = <>
          ReadOnly = True
          Width = 111
        end
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'Value'
          Footers = <>
          Width = 182
          OnUpdateData = DBGridEh2Columns1UpdateData
        end>
      object RowDetailData: TRowDetailPanelControlEh
      end
    end
  end
  object rbUseMacros: TRadioButton
    Left = 8
    Top = 8
    Width = 113
    Height = 17
    Caption = 'Use macro variables'
    Checked = True
    TabOrder = 1
    TabStop = True
    OnClick = rbUseMacrosClick
  end
  object rbUseFile: TRadioButton
    Left = 152
    Top = 8
    Width = 217
    Height = 17
    Caption = 'Use file to keep Connection parameters'
    TabOrder = 2
    OnClick = rbUseFileClick
  end
  object PageControl1: TPageControl
    Left = 17
    Top = 31
    Width = 344
    Height = 178
    ActivePage = TabSheet1
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 3
    object TabSheet1: TTabSheet
      Caption = 'Available Macro Variables'
      object DBGridEh1: TDBGridEh
        Left = 0
        Top = 0
        Width = 336
        Height = 150
        Align = alClient
        AutoFitColWidths = True
        DataSource = dsMacros
        DynProps = <>
        FooterParams.Color = clWindow
        IndicatorOptions = [gioShowRowIndicatorEh]
        ReadOnly = True
        TabOrder = 0
        Columns = <
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'Name'
            Footers = <>
            Width = 112
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'Value'
            Footers = <>
            Width = 181
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'File to keep parameters'
      ImageIndex = 1
      TabVisible = False
      DesignSize = (
        336
        150)
      object Label1: TLabel
        Left = 3
        Top = 3
        Width = 45
        Height = 13
        Caption = 'File name'
      end
      object Label2: TLabel
        Left = 3
        Top = 53
        Width = 41
        Height = 13
        Caption = 'File path'
      end
      object DBEditEh1: TDBEditEh
        Left = 3
        Top = 22
        Width = 326
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        DynProps = <>
        EditButtons = <>
        TabOrder = 0
        Text = 'ConnectionParametersEh.ini'
        Visible = True
      end
      object DBEditEh2: TDBEditEh
        Left = 3
        Top = 72
        Width = 326
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        DynProps = <>
        EditButtons = <>
        TabOrder = 1
        Text = 'File path'
        Visible = True
      end
    end
  end
  object bEditConnection: TButton
    Left = 174
    Top = 211
    Width = 90
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Edit connection'
    TabOrder = 4
    OnClick = bEditConnectionClick
  end
  object Button2: TButton
    Left = 205
    Top = 447
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 5
  end
  object Button3: TButton
    Left = 286
    Top = 447
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 6
  end
  object bTestConn: TButton
    Left = 265
    Top = 211
    Width = 90
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Test connection'
    TabOrder = 7
    OnClick = bTestConnClick
  end
  object dsMacros: TDataSource
    DataSet = mtMacros
    Left = 65513
    Top = 32
  end
  object dsConnParams: TDataSource
    DataSet = mtConnParams
    Left = 65513
    Top = 232
  end
  object mtMacros: TMemTableEh
    Active = True
    Params = <>
    Left = 65516
    Top = 80
    object mtMacrosName: TStringField
      FieldName = 'Name'
      Size = 100
    end
    object mtMacrosValue: TStringField
      FieldName = 'Value'
      Size = 200
    end
    object MemTableData: TMemTableDataEh
      object DataStruct: TMTDataStructEh
        object Name: TMTStringDataFieldEh
          FieldName = 'Name'
          StringDataType = fdtStringEh
          Size = 100
        end
        object Value: TMTStringDataFieldEh
          FieldName = 'Value'
          StringDataType = fdtStringEh
          Size = 200
        end
      end
      object RecordsList: TRecordsListEh
      end
    end
  end
  object mtConnParams: TMemTableEh
    Active = True
    CachedUpdates = True
    Params = <>
    Left = 65518
    Top = 288
    object mtConnParamsName: TWideStringField
      FieldName = 'Name'
      Size = 200
    end
    object mtConnParamsValue: TWideStringField
      FieldName = 'Value'
      Size = 255
    end
    object MemTableData: TMemTableDataEh
      object DataStruct: TMTDataStructEh
        object Name: TMTStringDataFieldEh
          FieldName = 'Name'
          StringDataType = fdtWideStringEh
          Size = 200
        end
        object Value: TMTStringDataFieldEh
          FieldName = 'Value'
          StringDataType = fdtWideStringEh
          Size = 255
        end
      end
      object RecordsList: TRecordsListEh
      end
    end
  end
end
