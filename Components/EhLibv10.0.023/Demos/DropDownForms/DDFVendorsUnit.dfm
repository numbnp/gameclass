object DDFVendors: TDDFVendors
  Left = 516
  Top = 106
  ClientHeight = 435
  ClientWidth = 542
  Color = clBtnFace
  Constraints.MinHeight = 200
  Constraints.MinWidth = 200
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Microsoft Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  OnInitForm = CustomDropDownFormEhInitForm
  OnReturnParams = CustomDropDownFormEhReturnParams
  DesignSize = (
    542
    435)
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 535
    Top = 41
    Width = 6
    Height = 368
    Align = alRight
    ResizeStyle = rsUpdate
  end
  object Panel2: TPanel
    Left = 0
    Top = 41
    Width = 535
    Height = 368
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel2'
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 0
    object MainGrid: TDBGridEh
      Left = 0
      Top = 0
      Width = 535
      Height = 368
      Align = alClient
      AutoFitColWidths = True
      Border.ExtendedDraw = True
      Border.EdgeBorders = [ebTop, ebRight, ebBottom]
      DataSource = DataSource1
      DynProps = <>
      Flat = True
      FooterParams.Color = clWindow
      GridLineParams.VertEmptySpaceStyle = dessSolidEh
      IndicatorOptions = []
      Options = [dgTitles, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghTraceColSizing, dghColumnResize, dghColumnMove, dghExtendVertLines]
      SearchPanel.Enabled = True
      TabOrder = 0
      TitleParams.RowHeight = 4
      TitleParams.RowLines = 1
      TitleParams.HorzLines = True
      OnDblClick = MainGridDblClick
      Columns = <
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'VendorNo'
          Footers = <>
          Width = 46
        end
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'VendorName'
          Footers = <>
          Width = 117
        end
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'Address1'
          Footers = <>
          Width = 116
        end
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'City'
          Footers = <>
          Width = 95
        end
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'Country'
          Footers = <>
          Width = 48
        end>
      object RowDetailData: TRowDetailPanelControlEh
      end
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 542
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 1
    DesignSize = (
      542
      41)
    object SpeedButton3: TSpeedButton
      Left = 10
      Top = 8
      Width = 80
      Height = 26
      Caption = 'Append'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF84B094257341196B
        3725734184B094FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFF88B297288C5364BA8D95D2B264BA8D288C5381AE91C6A18CC38E68
        C08B66BE8864BB8561B9835FB47E5CB27C5AB17B58206C3A62BA8B60BA87FFFF
        FF60B98767BC8F20703DC8926CE6E5E5E5E5E5E5E5E6E5E5E5E5E5E5E6E5E5E5
        E5E5E6E5E5317B4C9CD4B6FFFFFFFFFFFFFFFFFF95D2B2196B37CA946EE7E7E7
        E8E7E7E7E7E7E7E7E7E7E7E7C3C3C3FFFFFFFFFFFF4A8B6290D3B192D6B1FFFF
        FF65BC8C67BC8F20703DCC976FE9E9E9D28358D28358D28358E9E9E9C3C3C3FF
        FFFFFFFFFFA8C7B361AB8195D4B4BAE6D06ABB8F2D8F5781AE91D19C73ECECEC
        ECECEBECECEBECECECECEBECC3C3C3C3C3C3C3C3C3C3C3C38FAC9A5D96724F8E
        66498960717951FFFFFFD49E75EFEEEEEFEFEFEFEEEEEFEEEEEEEFEEEEEEEEEE
        EFEFEEEEEEEEEEEEEEEEEEEFEEEEEEEEEEEEEEEFB27C5AFFFFFFD5A076F1F1F0
        F1F0F1F0F1F1F1F0F1F1F1F1C3C3C3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFF1F1F1B57E5CFFFFFFD8A279F2F2F2D28358D28358D28358F2F2F3C3C3C3FF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3F3F3B7815EFFFFFFD9A379F5F5F5
        F5F5F4F4F5F4F4F4F4F5F5F4C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3
        C3F4F4F5BA8560FFFFFFDBA47AF6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6
        F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6BD8763FFFFFFDCA77BDCA77B
        DCA77BDCA77BDCA77BDCA77BDCA77BDCA77BDCA77BDCA77BDCA77BDCA77BDCA7
        7BDCA77BC08B66FFFFFFDDAD86E8B992E8B992E8B992E8B992E8B992E8B992E8
        B992E8B992E8B992E8B992E8B992E8B992E8B992C19170FFFFFFDBC3B6DEB492
        DCA77BDCA67ADAA47AD8A279D5A076D49E75D29D73CF9A72CE9970CB966FC994
        6CC79E80DBC3B6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      OnClick = SpeedButton3Click
    end
    object SpeedButton4: TSpeedButton
      Left = 97
      Top = 8
      Width = 80
      Height = 26
      Caption = 'Change'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFF18435A2B62894C8ABE70A9CCE3EDF5FFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2E678594C7F991C9F941
        85C9276BAED8E6F2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC6A18CC38E68
        C08B66BE88644389AAE0F2FF549AD81A7ABE4998C54081B699796BAB7554A973
        53A97151C6A18CFFFFFFC8926CE6E5E5E5E5E5E5E5E697B5C97AB6D590B7D155
        C9E45BDFF578D0ED4F9BDBCFD9E3E5E6E6E6E5E6A97251FFFFFFCA946EE7E7E7
        E8E7E7E7E7E7E7E7E7A4C6D775B8D6C2F6FD63DFF75DE2F879D3F04A99DCE6F1
        FAE7E7E7AA7353FFFFFFCC976FE9E9E9D28358D28358D28358E9E9E989AEBF77
        CBE7C7F7FD5EDCF55AE1F77BD4F14C9ADEC4D7E7AC7554FFFFFFD19C73ECECEC
        ECECEBECECEBECECECECEBECC3C3C395BDCA79D3EEC7F7FD5FDCF55BE2F77AD6
        F250A0E09C7E6EFFFFFFD49E75EFEEEEEFEFEFEFEEEEEFEEEEEEEFEEEEEEEEEE
        EFEFB5DEEB7DD4EEC4F6FD6CDDF66DCAED63A3D76399C9E5EFF7D5A076F1F1F0
        F1F0F1F0F1F1F1F0F1F1F1F1C3C3C3FFFFFFFFFFFFB5E6F581D6EEB2E3F98BC0
        E7AED3F6C4E0FC6BA2D4D8A279F2F2F2D28358D28358D28358F2F2F3C3C3C3FF
        FFFFFFFFFFFFFFFFB1E6F577BEE7B4D2F0E5F3FFACD2EF5996CCD9A379F5F5F5
        F5F5F4F4F5F4F4F4F4F5F5F4C3C3C3C3C3C3C3C3C3C3C3C3C3C3C394BDCC58A5
        D885B1DB469DD0B1D8EEDBA47AF6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6
        F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6BD8763FFFFFFDCA77BDCA77B
        DCA77BDCA77BDCA77BDCA77BDCA77BDCA77BDCA77BDCA77BDCA77BDCA77BDCA7
        7BDCA77BC08B66FFFFFFDDAD86E8B992E8B992E8B992E8B992E8B992E8B992E8
        B992E8B992E8B992E8B992E8B992E8B992E8B992C19170FFFFFFDBC3B6DEB492
        DCA77BDCA67ADAA47AD8A279D5A076D49E75D29D73CF9A72CE9970CB966FC994
        6CC79E80DBC3B6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      OnClick = SpeedButton4Click
    end
    object SpeedButton5: TSpeedButton
      Left = 185
      Top = 8
      Width = 80
      Height = 26
      Caption = 'Delete'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF95B0E3235CC20543
        BC1F59C186A6DDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFF8CABE12866CA2177E60579EA0164DD074FBE86A6DDC6A18CC38E68
        C08B66BE8864BB8561B9835FB47E5CB27C5AB17B58164BAE639DF4187FFF0076
        F80076EE0368E11E59C0C8926CE6E5E5E5E5E5E5E5E6E5E5E5E5E5E5E6E5E5E5
        E5E5E6E5E50543BCAECDFEFFFFFFFFFFFFFFFFFF187FEF0543BCCA946EE7E7E7
        E8E7E7E7E7E7E7E7E7E7E7E7C3C3C3FFFFFFFFFFFF255DC28DB5F64D92FF1177
        FF2186FF408AEB245CC2CC976FE9E9E9D28358D28358D28358E9E9E9C3C3C3FF
        FFFFFFFFFF96B1E33D76D28DB5F7B8D6FE72A8F52E6BCA94AFE2D19C73ECECEC
        ECECEBECECEBECECECECEBECC3C3C3C3C3C3C3C3C3C3C3C37591C3235BC00543
        BC1D58BF5F6186FFFFFFD49E75EFEEEEEFEFEFEFEEEEEFEEEEEEEFEEEEEEEEEE
        EFEFEEEEEEEEEEEEEEEEEEEFEEEEEEEEEEEEEEEFB27C5AFFFFFFD5A076F1F1F0
        F1F0F1F0F1F1F1F0F1F1F1F1C3C3C3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFF1F1F1B57E5CFFFFFFD8A279F2F2F2D28358D28358D28358F2F2F3C3C3C3FF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3F3F3B7815EFFFFFFD9A379F5F5F5
        F5F5F4F4F5F4F4F4F4F5F5F4C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3
        C3F4F4F5BA8560FFFFFFDBA47AF6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6
        F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6BD8763FFFFFFDCA77BDCA77B
        DCA77BDCA77BDCA77BDCA77BDCA77BDCA77BDCA77BDCA77BDCA77BDCA77BDCA7
        7BDCA77BC08B66FFFFFFDDAD86E8B992E8B992E8B992E8B992E8B992E8B992E8
        B992E8B992E8B992E8B992E8B992E8B992E8B992C19170FFFFFFDBC3B6DEB492
        DCA77BDCA67ADAA47AD8A279D5A076D49E75D29D73CF9A72CE9970CB966FC994
        6CC79E80DBC3B6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      OnClick = SpeedButton5Click
    end
    object Image1: TImage
      Left = 505
      Top = 3
      Width = 18
      Height = 18
      Anchors = [akTop, akRight]
      Picture.Data = {
        07544269746D617076030000424D760300000000000036000000280000001100
        0000100000000100180000000000400300000000000000000000000000000000
        0000CAA241B1B1B1969696969696969696969696969696969696969696969696
        969696969696969696969696969696B1B1B1CAA24100B1B1B1E5E5E5EDECEBED
        EBEAEDEBEAEDEBEAEDEBEAEDEBEAEDEBEAEDEBEAEDEBEAEDEBEAEDEBEAEDEBEA
        EDECEBDADAD9B1B1B100969696FFFFFFE4E1E1E3E0E0E3E0E0E3E0E0E3E0E0E3
        E0E0E3E0E0E3E0E0E3E0E0E3E0E0E3E0E0E3E0E0E4E1E1EEECEC969696009696
        96FFFFFFE4E2E1E4E2E1E4E2E1E4E2E1E4E2E1E4E2E1E4E2E1E4E2E1E4E2E1E4
        E2E1E4E2E1E4E2E1E4E2E1EEEDEC96969600969696FFFFFFE6E4E3E6E4E33B3A
        B63B3AB63B3AB6E6E4E3E6E4E3E6E4E33B3AB63B3AB63B3AB6E6E4E3E6E4E3EF
        EEED96969600969696FFFFFFE8E6E6E8E6E6E8E6E63B3BB73B3BB73B3BB7E8E6
        E63B3BB73B3BB73B3BB7E8E6E6E8E6E6E8E6E6F0EFEF96969600969696FFFFFF
        EAE8E8EAE8E8EAE8E8EAE8E83C3BB73C3BB73C3BB73C3BB73C3BB7EAE8E8EAE8
        E8EAE8E8EAE8E8F2F0F096969600969696FFFFFFECEBEAECEBEAECEBEAECEBEA
        ECEBEA3C3CB83C3CB83C3CB8ECEBEAECEBEAECEBEAECEBEAECEBEAF3F2F29696
        9600969696FFFFFFEFEDEDEFEDEDEFEDEDEFEDEDEFEDED3D3CB83D3CB83D3CB8
        EFEDEDEFEDEDEFEDEDEFEDEDEFEDEDF5F4F496969600969696FFFFFFF1F0F0F1
        F0F0F1F0F0F1F0F03D3DB93D3DB93D3DB93D3DB93D3DB9F1F0F0F1F0F0F1F0F0
        F1F0F0F6F6F696969600969696FFFFFFF3F2F2F3F2F2F3F2F23D3DB93D3DB93D
        3DB9F3F2F23D3DB93D3DB93D3DB9F3F2F2F3F2F2F3F2F2F7F7F7969696009696
        96FFFFFFF5F4F4F5F4F43E3EBA3E3EBA3E3EBAF5F4F4F5F4F4F5F4F43E3EBA3E
        3EBA3E3EBAF5F4F4F5F4F4F9F8F896969600969696FFFFFFF6F6F6F6F6F6F6F6
        F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F6F9
        F9F996969600969696FFFFFFFAFAFAF8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8
        F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8F8FBFBFB96969600B1B1B1EAEAEA
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFEAEAEAB1B1B100C6A04AB1B1B1969696969696969696969696
        969696969696969696969696969696969696969696969696969696B1B1B1C6A0
        4A00}
      Visible = False
      OnClick = Image1Click
    end
  end
  object DBVertGridEh1: TDBVertGridEh
    Left = 541
    Top = 41
    Width = 1
    Height = 368
    Align = alRight
    Border.Color = clBtnShadow
    Border.EdgeBorders = [ebLeft, ebTop, ebBottom]
    RowCategories.CategoryProps = <>
    DataSource = DataSource1
    DrawGraphicData = True
    DrawMemoText = True
    Flat = True
    RowsDefValues.FitRowHeightToData = True
    TabOrder = 2
    LabelColWidth = 72
  end
  object Panel1: TPanel
    Left = 0
    Top = 409
    Width = 542
    Height = 26
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    DesignSize = (
      542
      26)
    object sbOk: TSpeedButton
      Left = 431
      Top = 2
      Width = 55
      Height = 22
      Anchors = [akTop, akRight]
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7FAF7F9FBF9FF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFF7FAF837833D347D3AF9FBF9FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8FBF8408E4754A35C4F9F5733
        7D39F8FBF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        F8FBF8499A515BAC6477CA8274C87E51A059347E3AF8FBF9FFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFF8FCF951A65A63B56D7ECE897BCC8776CA8176
        C98152A25A357F3BF9FBF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FCFA59B063
        6BBD7684D2907AC98560B26A63B46D78C98378CB8253A35C36803CF9FBF9FFFF
        FFFFFFFFFFFFFFFFFFFFD3ECD66CBD7679C98680CE8D53A75CB2D6B59CC9A05C
        AD677CCC8679CB8554A45D37813DF9FBF9FFFFFFFFFFFFFFFFFFFFFFFFD9EFDC
        6CBD756DC079B5DBB9FFFFFFFFFFFF98C79D5EAE687DCD897CCD8756A55F3882
        3EF9FBF9FFFFFFFFFFFFFFFFFFFFFFFFD5EDD8BEE2C3FFFFFFFFFFFFFFFFFFFF
        FFFF99C89D5FAF697FCE8A7ECE8957A66039833FF9FBF9FFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF99C89E60B06A81CF8D7FCF
        8B58A761398540F9FBF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFF99C99E62B26C82D18F7AC88557A6609FC4A2FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9ACA9F63B3
        6D5FAF69A5CBA9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF9ACA9FA5CEA9FFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      OnClick = sbOkClick
    end
    object SpeedButton2: TSpeedButton
      Left = 491
      Top = 2
      Width = 33
      Height = 22
      Anchors = [akTop, akRight]
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCECEFAF9F9FEFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFF8F8FEC6C5F8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        D1D0FB4F4CF24140EDF9F9FEFFFFFFFFFFFFFFFFFFFFFFFFF8F8FE2725E4312F
        EAC6C5F8FFFFFFFFFFFFFFFFFFD3D3FC5856F56361FA5855F64341EDF9F9FEFF
        FFFFFFFFFFF9F8FE2E2DE6413FF14C4AF6312FEAC6C5F8FFFFFFFFFFFFE3E3FD
        5B58F66562FA7170FF5956F64442EEF9F9FEF9F9FE3734E94745F26362FF4A48
        F42F2DE9DAD9FAFFFFFFFFFFFFFFFFFFE3E3FD5B59F66663FA7471FF5A58F645
        43EE403EEC504DF46867FF504EF53634EBDBDBFBFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFE3E3FD5C5AF66764FA7472FF7370FF706EFF6E6CFF5755F73F3DEEDCDC
        FBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE4E3FD5D5BF77976FF59
        56FF5754FF7270FF4846F0DEDEFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFAFAFF5E5BF67D79FF5E5BFF5B58FF7674FF4744EFF9F9FEFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAFAFF6865F9706DFB807EFF7E
        7BFF7C79FF7977FF5E5CF74946EFF9F9FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FBFAFF706DFC7774FD8682FF7673FC6462F8605DF76D6AFA7B79FF605DF74A47
        EFF9F9FEFFFFFFFFFFFFFFFFFFFBFBFF7572FE7D7AFE8A87FF7C79FD6C69FBE5
        E4FEE4E4FE615EF86E6CFA7D7AFF615FF74B48F0FBFBFFFFFFFFFFFFFFEEEEFF
        7A77FF817EFF817EFE7471FDE6E6FEFFFFFFFFFFFFE4E4FE625FF86F6DFB7E7C
        FF625FF8B0AFF8FEFEFFFFFFFFFFFFFFEEEEFF7A77FF7976FEE7E7FFFFFFFFFF
        FFFFFFFFFFFFFFFFE4E4FE6461F86A68F98E8CF7E3E2FDFFFFFFFFFFFFFFFFFF
        FFFFFFEEEEFFE8E8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE5E4FEB8B8
        FCD7D6FDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFF9F9FFFFFFFFFFFFFFFFFFFF}
      OnClick = SpeedButton2Click
    end
  end
  object DataSource1: TDataSource
    DataSet = MemTableEh1
    OnDataChange = DataSource1DataChange
    Left = 34
    Top = 84
  end
  object Table1: TADOTable
    CursorType = ctStatic
    TableName = 'vendors'
    Left = 32
    Top = 120
  end
  object MemTableEh1: TMemTableEh
    Active = True
    FetchAllOnOpen = True
    Params = <>
    Left = 72
    Top = 69
    object MemTableData: TMemTableDataEh
      object DataStruct: TMTDataStructEh
        object VendorNo: TMTNumericDataFieldEh
          FieldName = 'VendorNo'
          NumericDataType = fdtAutoIncEh
          AutoIncrement = False
          DisplayLabel = 'VendorNo'
          DisplayWidth = 10
          currency = False
          Precision = 15
        end
        object VendorName: TMTStringDataFieldEh
          FieldName = 'VendorName'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'VendorName'
          DisplayWidth = 30
          Size = 30
          Transliterate = True
        end
        object Address1: TMTStringDataFieldEh
          FieldName = 'Address1'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'Address1'
          DisplayWidth = 30
          Size = 30
          Transliterate = True
        end
        object Address2: TMTStringDataFieldEh
          FieldName = 'Address2'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'Address2'
          DisplayWidth = 30
          Size = 30
          Transliterate = True
        end
        object City: TMTStringDataFieldEh
          FieldName = 'City'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'City'
          DisplayWidth = 20
          Transliterate = True
        end
        object Country: TMTStringDataFieldEh
          FieldName = 'Country'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'Country'
          DisplayWidth = 15
          Size = 15
          Transliterate = True
        end
        object FAX: TMTStringDataFieldEh
          FieldName = 'FAX'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'FAX'
          DisplayWidth = 15
          Size = 15
          Transliterate = True
        end
        object Phone: TMTStringDataFieldEh
          FieldName = 'Phone'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'Phone'
          DisplayWidth = 15
          Size = 15
          Transliterate = True
        end
        object Preferred: TMTBooleanDataFieldEh
          FieldName = 'Preferred'
          DisplayLabel = 'Preferred'
          DisplayWidth = 5
        end
        object State: TMTStringDataFieldEh
          FieldName = 'State'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'State'
          DisplayWidth = 20
          Transliterate = True
        end
        object Zip: TMTStringDataFieldEh
          FieldName = 'Zip'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'Zip'
          DisplayWidth = 10
          Size = 10
          Transliterate = True
        end
      end
      object RecordsList: TRecordsListEh
        Data = (
          (
            36
            '2122'
            nil
            nil
            nil
            nil
            nil
            nil
            False
            nil
            nil)
          (
            1
            'Cacor Corporation'
            '161 Southfield Rd'
            nil
            'Southfield'
            'U.S.A.'
            '708-555-7547'
            '708-555-9555'
            True
            'OH'
            '60093')
          (
            2
            'Underwater'
            '50 N 3rd Street'
            nil
            'Indianapolis'
            'U.S.A.'
            nil
            '317-555-4523'
            True
            'IN'
            '46208')
          (
            3
            'J.W.  Luscher Mfg.'
            '65 Addams Street'
            nil
            'Berkely'
            'U.S.A.'
            '508-555-8949'
            '800-555-4744'
            False
            'MA'
            '02779')
          (
            4
            'Scuba Professionals'
            '3105 East Brace'
            nil
            'Rancho Dominguez'
            'U.S.A.'
            nil
            '213-555-7850'
            True
            'CA'
            '90221')
          (
            5
            'Divers'#39'  Supply Shop'
            '5208 University Dr'
            nil
            'Macon'
            'U.S.A.'
            '912-555-8474'
            '912-555-6790'
            False
            'GA'
            '20865')
          (
            6
            'Techniques'
            '52 Dolphin Drive'
            nil
            'Redwood City'
            'U.S.A.'
            '415-555-1276'
            '415-555-1410'
            False
            'CA'
            '94065-1086')
          (
            7
            'Perry Scuba'
            '3443 James Ave'
            nil
            'Hapeville'
            'U.S.A.'
            '404-555-8280'
            '800-555-6220'
            True
            'GA'
            '30354')
          (
            8
            'Beauchat, Inc.'
            '45900 SW 2nd Ave'
            nil
            'Ft Lauderdale'
            'U.S.A.'
            '305-555-6739'
            '305-555-7242'
            True
            'FL'
            '33315')
          (
            9
            'Amor Aqua'
            '42 West 29th Street'
            nil
            'New York'
            'U.S.A.'
            '212-555-7286'
            '800-555-6880'
            True
            'NY'
            '10011')
          (
            10
            'Aqua Research Corp.'
            'P.O. Box 998'
            nil
            'Cornish'
            'U.S.A.'
            nil
            '603-555-2254'
            True
            'NH'
            '03745')
          (
            11
            'B&K Undersea Photo'
            '116 W 7th Street'
            nil
            'New York'
            'U.S.A.'
            '212-555-7474'
            '800-555-5662'
            False
            'NY'
            '10011')
          (
            12
            'Diving International Unlimited'
            '1148 David Drive'
            nil
            'San Diego'
            'U.S.A.'
            nil
            '800-555-8439'
            True
            'DA'
            '92102')
          (
            13
            'Nautical Compressors'
            '65 NW 167 Street'
            nil
            'Miami'
            'U.S.A.'
            '305-555-0268'
            '305-555-5554'
            True
            'FL'
            '33015')
          (
            14
            'Glen Specialties, Inc.'
            '17663 Campbell Lane'
            nil
            'Huntington Beach'
            'U.S.A.'
            '714-555-6539'
            '714-555-5100'
            True
            'CA'
            '92647')
          (
            15
            'Dive Time'
            '20 Miramar Ave'
            nil
            'Long Beach'
            'U.S.A.'
            '213-555-1390'
            '213-555-3708'
            True
            'CA'
            '90815')
          (
            16
            'Undersea Systems, Inc.'
            '18112 Gotham Street'
            nil
            'Huntington Beach'
            'U.S.A.'
            nil
            '800-555-3483'
            True
            'CA'
            '92648')
          (
            17
            'Felix Diving'
            '310 S Michigan Ave'
            nil
            'Chicago'
            'U.S.A.'
            '312-555-1586'
            '800-555-3549'
            False
            'IL'
            '60607')
          (
            18
            'Central Valley Skin Divers'
            '160 Jameston Ave'
            nil
            'Jamaica'
            'U.S.A.'
            nil
            '718-555-5772'
            False
            'NY'
            '11432')
          (
            19
            'Parkway Dive Shop'
            '241 Kelly Street'
            nil
            'South Amboy'
            'U.S.A.'
            nil
            '908-555-5300'
            True
            'NJ'
            '08879')
          (
            20
            'Marine Camera & Dive'
            '117 South Valley Rd'
            nil
            'San Diego'
            'U.S.A.'
            '619-555-6499'
            '619-555-0604'
            True
            'CA'
            '92121')
          (
            21
            'Dive Canada'
            '275 W Ninth Ave'
            nil
            'Vancouver'
            'Canada'
            '604-555-3749'
            '604-555-2681'
            True
            'British Columbia'
            'V6K 1P9')
          (
            22
            'Dive & Surf'
            'P.O. Box 20210'
            nil
            'Indianapolis'
            'U.S.A.'
            nil
            '317-555-4523'
            False
            'IN'
            '46208')
          (
            23
            'Fish Research Labs'
            '29 Wilkins Rd Dept. SD'
            nil
            'Los Banos'
            'U.S.A.'
            '203-555-0416'
            '209-555-3292'
            True
            'CA'
            '93635')
          (
            26
            '322'
            nil
            nil
            nil
            nil
            nil
            nil
            False
            nil
            nil))
      end
    end
  end
  object ADODataDriverEh2: TADODataDriverEh
    ConnectionProvider = Form1.ADOConnectionProviderEh1
    DynaSQLParams.Options = []
    MacroVars.Macros = <>
    SelectCommand.CommandText.Strings = (
      'select'
      '  VendorNo'
      '  ,VendorName'
      '  ,Address1'
      '  ,Address2'
      '  ,City'
      '  ,Country'
      '  ,FAX'
      '  ,Phone'
      '  ,Preferred'
      '  ,State'
      '  ,Zip'
      'from'
      '  vendors')
    SelectCommand.Parameters = <>
    UpdateCommand.Parameters = <>
    InsertCommand.Parameters = <>
    DeleteCommand.Parameters = <>
    GetrecCommand.Parameters = <>
    Left = 72
    Top = 128
  end
end
