object Form2: TForm2
  Left = 489
  Top = 127
  Width = 842
  Height = 654
  Caption = 'Export data to Xlsx / Import and modify Xlsx files.'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Visible = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 99
    Width = 826
    Height = 516
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'DBGrid'
      object DBGridEh1: TDBGridEh
        Left = 0
        Top = 47
        Width = 818
        Height = 441
        Align = alClient
        AutoFitColWidths = True
        Border.Color = clBtnShadow
        Border.EdgeBorders = []
        DataSource = DataSource1
        DynProps = <>
        EditActions = [geaCutEh, geaCopyEh, geaPasteEh, geaDeleteEh, geaSelectAllEh]
        EvenRowColor = clWindow
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        FooterRowCount = 1
        FooterParams.Font.Charset = DEFAULT_CHARSET
        FooterParams.Font.Color = clWindowText
        FooterParams.Font.Height = -11
        FooterParams.Font.Name = 'Microsoft Sans Serif'
        FooterParams.Font.Style = [fsBold]
        FooterParams.ParentFont = False
        FooterParams.RowHeight = 5
        FooterParams.RowLines = 1
        GridLineParams.ColorScheme = glcsThemedEh
        GridLineParams.GridBoundaries = True
        IndicatorOptions = [gioShowRecNoEh]
        IndicatorParams.FillStyle = cfstSolidEh
        IndicatorParams.RecNoShowStep = 5
        IndicatorTitle.ShowDropDownSign = True
        IndicatorTitle.TitleButton = True
        OddRowColor = 16772332
        Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
        OptionsEh = [dghFixed3D, dghResizeWholeRightPart, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghTraceColSizing, dghIncSearch, dghPreferIncSearch, dghRowHighlight, dghDblClickOptimizeColWidth, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghHotTrack, dghExtendVertLines]
        ParentFont = False
        ParentShowHint = False
        RowSizingAllowed = True
        SearchPanel.FilterEnabled = False
        ShowHint = True
        EditButtonsShowOptions = [sebShowOnlyForCurRowEh]
        SortLocal = True
        STFilter.FilterButtonDrawTime = fbdtWhenCellHotEh
        STFilter.Local = True
        STFilter.Location = stflInTitleFilterEh
        STFilter.Visible = True
        SumList.Active = True
        SumList.VirtualRecords = True
        TabOrder = 0
        TitleParams.FillStyle = cfstGradientEh
        TitleParams.MultiTitle = True
        TitleParams.SecondColor = 16382457
        TitleParams.SortMarkerStyle = smstFrameEh
        TitleParams.VTitleMargin = 5
        Columns = <
          item
            AlwaysShowEditButton = True
            CellButtons = <>
            Checkboxes = False
            DropDownSizing = True
            DynProps = <>
            EditButtons = <>
            FieldName = 'VNo'
            Footer.Value = 'Sum and count'
            Footer.ValueType = fvtStaticText
            Footers = <
              item
                Value = 'Sum of cost'
                ValueType = fvtStaticText
              end
              item
                Value = 'Record count'
                ValueType = fvtStaticText
              end>
            Title.Caption = 'Vendor of parts|Vendor Number|1 '
            Title.TitleButton = True
            ToolTips = True
            Width = 98
          end
          item
            AlwaysShowEditButton = True
            CellButtons = <>
            Checkboxes = False
            DropDownBox.ColumnDefValues.EndEllipsis = True
            DropDownBox.ColumnDefValues.Title.ToolTips = True
            DropDownBox.ColumnDefValues.ToolTips = True
            DropDownBox.Options = [dlgColumnResizeEh, dlgColLinesEh]
            DropDownBox.UseMultiTitle = True
            DropDownRows = 14
            DropDownShowTitles = True
            DropDownSizing = True
            DropDownSpecRow.CellsText = '( Empty ); -; -; -'
            DropDownSpecRow.Font.Charset = DEFAULT_CHARSET
            DropDownSpecRow.Font.Color = clWindowText
            DropDownSpecRow.Font.Height = -11
            DropDownSpecRow.Font.Name = 'Microsoft Sans Serif'
            DropDownSpecRow.Font.Style = []
            DropDownSpecRow.Visible = True
            DropDownWidth = -1
            DynProps = <>
            EditButtons = <>
            FieldName = 'VName1'
            Footer.Alignment = taCenter
            Footer.ValueType = fvtCount
            Footers = <
              item
                Alignment = taCenter
                FieldName = 'PCost'
                ValueType = fvtSum
              end>
            LookupDisplayFields = 'VendorName;City;State;FAX'
            STFilter.DataField = 'VNo'
            STFilter.KeyField = 'VendorNo'
            STFilter.ListField = 'VendorName'
            Title.Caption = 'Vendor of parts|Vendor Name|2'
            ToolTips = True
            Width = 121
          end
          item
            AlwaysShowEditButton = True
            CellButtons = <>
            Checkboxes = False
            DropDownSizing = True
            DynProps = <>
            EditButtons = <>
            FieldName = 'PNo'
            Footers = <>
            Title.Caption = 'Parts|PN|3 '
            Title.TitleButton = True
            ToolTips = True
            Width = 56
          end
          item
            AlwaysShowEditButton = True
            CellButtons = <>
            Checkboxes = False
            DropDownSizing = True
            DynProps = <>
            EditButtons = <>
            FieldName = 'PDescription'
            Footers = <
              item
                Value = 'Sum'
                ValueType = fvtStaticText
              end
              item
                Value = 'Vendor No'
                ValueType = fvtStaticText
              end>
            STFilter.DataField = 'PDescription'
            STFilter.KeyField = 'Description'
            STFilter.ListField = 'Description'
            Title.Caption = 'Parts|Description|4 '
            Title.TitleButton = True
            ToolTips = True
            Width = 133
          end
          item
            AlwaysShowEditButton = True
            ButtonStyle = cbsUpDown
            CellButtons = <>
            Checkboxes = False
            DropDownSizing = True
            DynProps = <>
            EditButton.Style = ebsUpDownEh
            EditButton.Visible = True
            EditButtons = <>
            FieldName = 'PCost'
            Footer.ValueType = fvtSum
            Footers = <
              item
                ValueType = fvtSum
              end
              item
                FieldName = 'VNo'
                ValueType = fvtFieldValue
              end>
            Increment = 0.100000000000000000
            Title.Caption = 'Parts|Cost|5 '
            Title.TitleButton = True
            Title.SortIndex = 1
            Title.SortMarker = smDownEh
            ToolTips = True
            Width = 89
          end
          item
            AlwaysShowEditButton = True
            CellButtons = <>
            Checkboxes = False
            DropDownSizing = True
            DynProps = <>
            EditButtons = <>
            FieldName = 'IQty'
            Footers = <>
            Title.Caption = 'Items|Qry|6 '
            Title.TitleButton = True
            Title.SortIndex = 2
            Title.SortMarker = smDownEh
            ToolTips = True
            Width = 33
          end
          item
            AlwaysShowEditButton = True
            CellButtons = <>
            Checkboxes = False
            DropDownSizing = True
            DynProps = <>
            EditButtons = <>
            FieldName = 'VPreferred'
            Footers = <>
            NotInKeyListIndex = 2
            Title.Caption = 'Pref|7'
            Title.Hint = 'Preferred'
            Title.ImageIndex = 0
            Title.TitleButton = True
            ToolTips = True
            Width = 36
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
      object DBEditEh1: TDBEditEh
        Left = 0
        Top = 0
        Width = 818
        Height = 47
        Align = alTop
        Alignment = taCenter
        DynProps = <>
        EditButtons = <>
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -32
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        Text = 'DBGridEh'
        Visible = True
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'DBVertGrid'
      ImageIndex = 1
      object DBVertGridEh1: TDBVertGridEh
        Left = 0
        Top = 47
        Width = 361
        Height = 441
        Align = alLeft
        AllowedSelections = []
        Border.EdgeBorders = [ebLeft, ebBottom]
        Border.ExtendedDraw = True
        RowCategories.CategoryProps = <>
        PrintService.ColorSchema = pcsFullColorEh
        DataSource = DataSource1
        DrawGraphicData = True
        DrawMemoText = True
        TabOrder = 0
        LabelColWidth = 172
        Rows = <
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'VNo'
            RowLabel.Caption = 'Vendor No'
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'VName'
            RowLabel.Caption = 'Vendor Name'
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'PNo'
            RowLabel.Caption = 'Part No'
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'PDescription'
            RowLabel.Caption = 'Part description'
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'PCost'
            RowLabel.Caption = 'Part cost'
          end
          item
            DynProps = <>
            EditButtons = <>
            FieldName = 'IQty'
            RowLabel.Caption = 'Items Quantity'
          end
          item
            Checkboxes = False
            DynProps = <>
            EditButtons = <>
            FieldName = 'VPreferred'
            RowLabel.Caption = 'Preferred'
          end>
      end
      object DBEditEh2: TDBEditEh
        Left = 0
        Top = 0
        Width = 818
        Height = 47
        Align = alTop
        Alignment = taCenter
        DynProps = <>
        EditButtons = <>
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -32
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        Text = 'Record View'
        Visible = True
      end
    end
    object tbSourceCode: TTabSheet
      Caption = 'Source code'
      ImageIndex = 2
      object DBRichEditEh1: TDBRichEditEh
        Left = 0
        Top = 0
        Width = 818
        Height = 488
        Align = alClient
        EditButtons = <>
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ScrollBars = ssBoth
        TabOrder = 0
        RtfText = 
          '{\rtf1\ansi\ansicpg1251\deff0\deflang1049{\fonttbl{\f0\fmodern\f' +
          'prq1\fcharset204{\*\fname Courier New;}Courier New CYR;}{\f1\fni' +
          'l\fcharset204 Tahoma;}}'#13#10'{\colortbl ;\red105\green105\blue105;\r' +
          'ed0\green0\blue0;\red128\green0\blue0;\red128\green0\blue128;\re' +
          'd0\green74\blue67;\red128\green128\blue48;\red187\green121\blue1' +
          '19;\red0\green140\blue0;\red0\green0\blue230;\red125\green0\blue' +
          '69;\red255\green255\blue255;}'#13#10'\viewkind4\uc1\pard\cbpat11\tx916' +
          '\tx1832\tx2748\tx3664\tx4580\tx5496\tx6412\tx7328\tx8244\tx9160\' +
          'tx10076\tx10992\tx11908\tx12824\tx13740\tx14656\cf1\lang1033\f0\' +
          'fs20\{*******************************************************\}\' +
          'cf2\par'#13#10'\cf1\{                                                 ' +
          '      \}\cf2\par'#13#10'\cf1\{  This Demo shows how to use TXlsMemFile' +
          'Eh class       \}\cf2\par'#13#10'\cf1\{  to create Xlsx files from scr' +
          'atch                    \}\cf2\par'#13#10'\cf1\lang1049\{             ' +
          '                                          \}\cf2\par'#13#10'\cf1\{****' +
          '***************************************************\}\cf2\par'#13#10'\' +
          'cf3\lang1033\b\par'#13#10'unit\cf2\b0  Unit2\cf4 ;\cf2\par'#13#10'\par'#13#10'\cf5' +
          '\{$I EhLib.Inc\}\cf2\par'#13#10'\par'#13#10'\cf3\b interface\cf2\b0\par'#13#10'\pa' +
          'r'#13#10'\cf3\b uses\cf2\b0\par'#13#10'  Windows\cf6 ,\cf2  Messages\cf6 ,\c' +
          'f2  SysUtils\cf6 ,\cf2  Variants\cf6 ,\cf2  Graphics\cf6 ,\cf2\p' +
          'ar'#13#10'\cf5\{$IFDEF EH_LIB_17\}\cf2  System\cf6 .\cf2 UITypes\cf6 ,' +
          '\cf2  \cf5\{$ENDIF\}\cf2\par'#13#10'  ShellAPI\cf6 ,\cf2  XlsMemFilesE' +
          'h\cf6 ,\cf2  DBGridEhImpExp\cf6 ,\cf2  DBVertGridEhImpExp\cf6 ,\' +
          'cf2\par'#13#10'  Forms\cf6 ,\cf2  Dialogs\cf6 ,\cf2  DBGridEhGrouping\' +
          'cf6 ,\cf2  ToolCtrlsEh\cf6 ,\cf2  EhLibMTE\cf6 ,\cf2\par'#13#10'  DBGr' +
          'idEhToolCtrls\cf6 ,\cf2  DynVarsEh\cf6 ,\cf2  MemTableDataEh\cf6' +
          ' ,\cf2  Db\cf6 ,\cf2  MemTableEh\cf6 ,\cf2\par'#13#10'  DBVertGridsEh\' +
          'cf6 ,\cf2  EhLibVCL\cf6 ,\cf2  GridsEh\cf6 ,\cf2  DBAxisGridsEh\' +
          'cf6 ,\cf2  DBGridEh\cf6 ,\cf2  ComCtrls\cf6 ,\cf2\par'#13#10'  StdCtrl' +
          's\cf6 ,\cf2  Controls\cf6 ,\cf2  ExtCtrls\cf6 ,\cf2  Classes\cf6' +
          ' ,\cf2  Vcl\cf6 .\cf2 Mask\cf6 ,\cf2  DBCtrlsEh\cf4 ;\cf2\par'#13#10'\' +
          'par'#13#10'\cf3\b type\cf2\b0\par'#13#10'  TForm2 \cf6 =\cf2  \cf3\b class\c' +
          'f6\b0 (\cf2 TForm\cf6 )\cf2\par'#13#10'    Panel2\cf6 :\cf2  TPanel\cf' +
          '4 ;\cf2\par'#13#10'    PaintBox1\cf6 :\cf2  TPaintBox\cf4 ;\cf2\par'#13#10' ' +
          '   Label1\cf6 :\cf2  TLabel\cf4 ;\cf2\par'#13#10'    qrVendors\cf6 :\c' +
          'f2  TMemTableEh\cf4 ;\cf2\par'#13#10'    DataSource1\cf6 :\cf2  TDataS' +
          'ource\cf4 ;\cf2\par'#13#10'    mtQuery1\cf6 :\cf2  TMemTableEh\cf4 ;\c' +
          'f2\par'#13#10'    mtQuery1VNo\cf6 :\cf2  TFloatField\cf4 ;\cf2\par'#13#10'  ' +
          '  mtQuery1VName\cf6 :\cf2  TStringField\cf4 ;\cf2\par'#13#10'    mtQue' +
          'ry1PNo\cf6 :\cf2  TFloatField\cf4 ;\cf2\par'#13#10'    mtQuery1PDescri' +
          'ption\cf6 :\cf2  TStringField\cf4 ;\cf2\par'#13#10'    mtQuery1PCost\c' +
          'f6 :\cf2  TCurrencyField\cf4 ;\cf2\par'#13#10'    mtQuery1IQty\cf6 :\c' +
          'f2  TIntegerField\cf4 ;\cf2\par'#13#10'    mtQuery1VName1\cf6 :\cf2  T' +
          'StringField\cf4 ;\cf2\par'#13#10'    mtQuery1VPreferred\cf6 :\cf2  TBo' +
          'oleanField\cf4 ;\cf2\par'#13#10'    SaveDialog1\cf6 :\cf2  TSaveDialog' +
          '\cf4 ;\cf2\par'#13#10'    OpenDialog1\cf6 :\cf2  TOpenDialog\cf4 ;\cf2' +
          '\par'#13#10'    PageControl1\cf6 :\cf2  TPageControl\cf4 ;\cf2\par'#13#10'  ' +
          '  TabSheet1\cf6 :\cf2  TTabSheet\cf4 ;\cf2\par'#13#10'    TabSheet2\cf' +
          '6 :\cf2  TTabSheet\cf4 ;\cf2\par'#13#10'    DBGridEh1\cf6 :\cf2  TDBGr' +
          'idEh\cf4 ;\cf2\par'#13#10'    DBVertGridEh1\cf6 :\cf2  TDBVertGridEh\c' +
          'f4 ;\cf2\par'#13#10'    btnExportAsXlsx\cf6 :\cf2  TButton\cf4 ;\cf2\p' +
          'ar'#13#10'    DBEditEh1\cf6 :\cf2  TDBEditEh\cf4 ;\cf2\par'#13#10'    DBEdit' +
          'Eh2\cf6 :\cf2  TDBEditEh\cf4 ;\cf2\par'#13#10'    tbSourceCode\cf6 :\c' +
          'f2  TTabSheet\cf4 ;\cf2\par'#13#10'    DBRichEditEh1\cf6 :\cf2  TDBRic' +
          'hEditEh\cf4 ;\cf2\par'#13#10'    \cf3\b procedure\cf2\b0  btnExportAsX' +
          'lsxClick\cf6 (\cf2 Sender\cf6 :\cf2  TObject\cf6 )\cf4 ;\cf2\par' +
          #13#10'  \cf3\b private\cf2\b0\par'#13#10'    \cf3\b procedure\cf2\b0  Expo' +
          'rtWorksheet1\cf6 (\cf2 Sheet\cf6 :\cf2  TXlsWorksheetEh\cf6 )\cf' +
          '4 ;\cf2\par'#13#10'    \cf3\b procedure\cf2\b0  ExportWorksheet2\cf6 (' +
          '\cf2 Sheet\cf6 :\cf2  TXlsWorksheetEh\cf6 )\cf4 ;\cf2\par'#13#10'    \' +
          'cf1\{ Private declarations \}\cf2\par'#13#10'  \cf3\b public\cf2\b0\pa' +
          'r'#13#10'    \cf1\{ Public declarations \}\cf2\par'#13#10'  \cf3\b end\cf4\b' +
          '0 ;\cf2\par'#13#10'\par'#13#10'\cf3\b var\cf2\b0\par'#13#10'  Form2\cf6 :\cf2  TFo' +
          'rm2\cf4 ;\cf2\par'#13#10'\par'#13#10'\cf3\b implementation\cf2\b0\par'#13#10'\par'#13 +
          #10'\cf5\{$R *.dfm\}\cf2\par'#13#10'\par'#13#10'\cf3\b procedure\cf2\b0  TForm2' +
          '\cf6 .\cf2 btnExportAsXlsxClick\cf6 (\cf2 Sender\cf6 :\cf2  TObj' +
          'ect\cf6 )\cf4 ;\cf2\par'#13#10'\cf3\b var\cf2\b0\par'#13#10'  xlsFile\cf6 :\' +
          'cf2  TXlsMemFileEh\cf4 ;\cf2\par'#13#10'  Path\cf6 :\cf2  \cf7 String\' +
          'cf4 ;\cf2\par'#13#10'\cf3\b begin\cf2\b0\par'#13#10'  GetDir\cf6 (\cf8 0\cf6' +
          ' ,\cf2  Path\cf6 )\cf4 ;\cf2\par'#13#10'  Path \cf6 :=\cf2  Path \cf6 ' +
          '+\cf2  \cf9 '#39'\\TestXlsFile.xlsx'#39'\cf4 ;\cf2\par'#13#10'  xlsFile \cf6 :' +
          '=\cf2  TXlsMemFileEh\cf6 .\cf2 Create\cf4 ;\cf2\par'#13#10'  xlsFile\c' +
          'f6 .\cf2 Workbook\cf6 .\cf2 Worksheets\cf6 [\cf8 0\cf6 ].\cf2 Na' +
          'me \cf6 :=\cf2  \cf9 '#39'DBGrid'#39'\cf4 ;\cf2\par'#13#10'  xlsFile\cf6 .\cf2' +
          ' Workbook\cf6 .\cf2 AddWorksheet\cf6 (\cf9 '#39'VertGrid'#39'\cf6 )\cf4 ' +
          ';\cf2\par'#13#10'\par'#13#10'  ExportWorksheet1\cf6 (\cf2 xlsFile\cf6 .\cf2 ' +
          'Workbook\cf6 .\cf2 Worksheets\cf6 [\cf8 0\cf6 ])\cf4 ;\cf2\par'#13#10 +
          '  ExportWorksheet2\cf6 (\cf2 xlsFile\cf6 .\cf2 Workbook\cf6 .\cf' +
          '2 Worksheets\cf6 [\cf8 1\cf6 ])\cf4 ;\cf2\par'#13#10'\par'#13#10'  xlsFile\c' +
          'f6 .\cf2 SaveToFile\cf6 (\cf2 Path\cf6 )\cf4 ;\cf2\par'#13#10'\par'#13#10'  ' +
          '\lang1049 xlsFile\cf6 .\cf2 Free\cf4 ;\cf2\par'#13#10'\par'#13#10'  ShellExe' +
          'cute\cf6 (\cf2 Application\cf6 .\cf2 Handle\cf6 ,\cf2  \cf9 '#39'Ope' +
          'n'#39'\cf6 ,\cf2  \cf7 PChar\cf6 (\cf2 Path\cf6 ),\cf2  \cf10 nil\cf' +
          '6 ,\cf2  \cf10 nil\cf6 ,\cf2  SW_SHOWNORMAL\cf6 )\cf2\par'#13#10'\par'#13 +
          #10'\cf3\b end\cf4\b0 ;\cf2\par'#13#10'\par'#13#10'\cf3\b procedure\cf2\b0  TFo' +
          'rm2\cf6 .\cf2 ExportWorksheet1\cf6 (\cf2 Sheet\cf6 :\cf2  TXlsWo' +
          'rksheetEh\cf6 )\cf4 ;\cf2\par'#13#10'\cf3\b var\cf2\b0\par'#13#10'  i\cf6 :\' +
          'cf2  \cf7 Integer\cf4 ;\cf2\par'#13#10'  cr\cf6 :\cf2  IXlsFileCellsRa' +
          'ngeEh\cf4 ;\cf2\par'#13#10'  TitleMarix\cf6 :\cf2  TDBGridMultiTitleEx' +
          'portNodeMatrixEh\cf4 ;\cf2\par'#13#10'  ci\cf6 ,\cf2  ri\cf6 :\cf2  \c' +
          'f7 Integer\cf4 ;\cf2\par'#13#10'  ti\cf6 :\cf2  TDBGridMultiTitleExpor' +
          'tNodeEh\cf4 ;\cf2\par'#13#10'\par'#13#10'\cf3\b begin\cf2\b0\par'#13#10'  Sheet\cf' +
          '6 .\cf2 Columns\cf6 [\cf8 0\cf6 ].\cf2 Width \cf6 :=\cf2  Sheet\' +
          'cf6 .\cf2 Columns\cf6 .\cf2 ScreenToXlsWidth\cf6 (\cf2 DBGridEh1' +
          '\cf6 .\cf2 Columns\cf6 [\cf8 0\cf6 ].\cf2 Width\cf6 )\cf4 ;\cf2\' +
          'par'#13#10'  Sheet\cf6 .\cf2 Columns\cf6 [\cf8 1\cf6 ].\cf2 Width \cf6' +
          ' :=\cf2  Sheet\cf6 .\cf2 Columns\cf6 .\cf2 ScreenToXlsWidth\cf6 ' +
          '(\cf2 DBGridEh1\cf6 .\cf2 Columns\cf6 [\cf8 1\cf6 ].\cf2 Width\c' +
          'f6 )\cf4 ;\cf2\par'#13#10'  Sheet\cf6 .\cf2 Columns\cf6 [\cf8 2\cf6 ].' +
          '\cf2 Width \cf6 :=\cf2  Sheet\cf6 .\cf2 Columns\cf6 .\cf2 Screen' +
          'ToXlsWidth\cf6 (\cf2 DBGridEh1\cf6 .\cf2 Columns\cf6 [\cf8 2\cf6' +
          ' ].\cf2 Width\cf6 )\cf4 ;\cf2\par'#13#10'  Sheet\cf6 .\cf2 Columns\cf6' +
          ' [\cf8 3\cf6 ].\cf2 Width \cf6 :=\cf2  Sheet\cf6 .\cf2 Columns\c' +
          'f6 .\cf2 ScreenToXlsWidth\cf6 (\cf2 DBGridEh1\cf6 .\cf2 Columns\' +
          'cf6 [\cf8 3\cf6 ].\cf2 Width\cf6 )\cf4 ;\cf2\par'#13#10'  Sheet\cf6 .\' +
          'cf2 Columns\cf6 [\cf8 4\cf6 ].\cf2 Width \cf6 :=\cf2  Sheet\cf6 ' +
          '.\cf2 Columns\cf6 .\cf2 ScreenToXlsWidth\cf6 (\cf2 DBGridEh1\cf6' +
          ' .\cf2 Columns\cf6 [\cf8 4\cf6 ].\cf2 Width\cf6 )\cf4 ;\cf2\par'#13 +
          #10'  Sheet\cf6 .\cf2 Columns\cf6 [\cf8 5\cf6 ].\cf2 Width \cf6 :=\' +
          'cf2  Sheet\cf6 .\cf2 Columns\cf6 .\cf2 ScreenToXlsWidth\cf6 (\cf' +
          '2 DBGridEh1\cf6 .\cf2 Columns\cf6 [\cf8 5\cf6 ].\cf2 Width\cf6 )' +
          '\cf4 ;\cf2\par'#13#10'\par'#13#10'  \cf3\b if\cf2\b0  \cf6 (\cf2 DBGridEh1\c' +
          'f6 .\cf2 TitleParams\cf6 .\cf2 MultiTitle\cf6 )\cf2  \cf3\b then' +
          '\cf2\b0\par'#13#10'  \cf3\b begin\cf2\b0\par'#13#10'    CalcMultiTitleMatrix' +
          '\cf6 (\cf2 DBGridEh1\cf6 ,\cf2  TitleMarix\cf6 )\cf4 ;\cf2\par'#13#10 +
          '    \cf3\b for\cf2\b0  ci \cf6 :=\cf2  \cf8 0\cf2  \cf3\b to\cf2' +
          '\b0  Length\cf6 (\cf2 TitleMarix\cf6 )-\cf8 1\cf2  \cf3\b do\cf2' +
          '\b0\par'#13#10'    \cf3\b begin\cf2\b0\par'#13#10'      \cf3\b for\cf2\b0  r' +
          'i \cf6 :=\cf2  \cf8 0\cf2  \cf3\b to\cf2\b0  Length\cf6 (\cf2 Ti' +
          'tleMarix\cf6 [\cf2 ci\cf6 ])-\cf8 1\cf2  \cf3\b do\cf2\b0\par'#13#10' ' +
          '     \cf3\b begin\cf2\b0\par'#13#10'        ti \cf6 :=\cf2  TitleMarix' +
          '\cf6 [\cf2 ci\cf6 ,\cf2  ri\cf6 ]\cf4 ;\cf2\par'#13#10'        \cf3\b ' +
          'if\cf2\b0  \cf6 (\cf2 ti \cf6 <>\cf2  \cf10 nil\cf6 )\cf2  \cf3\' +
          'b then\cf2\b0\par'#13#10'        \cf3\b begin\cf2\b0\par'#13#10'          Sh' +
          'eet\cf6 .\cf2 Cells\cf6 [\cf2 ci\cf6 ,\cf2  ri \cf6 +\cf2  \cf8 ' +
          '1\cf6 ].\cf2 Value \cf6 :=\cf2  TitleMarix\cf6 [\cf2 ci\cf6 ,\cf' +
          '2  ri\cf6 ].\cf7 Text\cf4 ;\cf2\par'#13#10'          \cf3\b if\cf2\b0 ' +
          ' \cf6 (\cf2 ti\cf6 .\cf2 MergeColCount \cf6 >\cf2  \cf8 0\cf6 )\' +
          'cf2  \cf3\b or\cf2\b0  \cf6 (\cf2 ti\cf6 .\cf2 MergeRowCount \cf' +
          '6 >\cf2  \cf8 0\cf6 )\cf2  \cf3\b then\cf2\b0\par'#13#10'          \cf' +
          '3\b begin\cf2\b0\par'#13#10'            Sheet\cf6 .\cf2 MergeCell\cf6 ' +
          '(\cf2 ci\cf6 ,\cf2  ri \cf6 +\cf2  \cf8 1\cf6 ,\cf2  ti\cf6 .\cf' +
          '2 MergeColCount\cf6 ,\cf2  ti\cf6 .\cf2 MergeRowCount\cf6 )\cf4 ' +
          ';\cf2\par'#13#10'          \cf3\b end\cf4\b0 ;\cf2\par'#13#10'        \cf3\b' +
          ' end\cf4\b0 ;\cf2\par'#13#10'      \cf3\b end\cf4\b0 ;\cf2\par'#13#10'    \c' +
          'f3\b end\cf4\b0 ;\cf2\par'#13#10'    FreeMultiTitleMatrix\cf6 (\cf2 Ti' +
          'tleMarix\cf6 )\cf4 ;\cf2\par'#13#10'  \cf3\b end\cf2\b0  \cf3\b else\c' +
          'f2\b0\par'#13#10'  \cf3\b begin\cf2\b0\par'#13#10'    Sheet\cf6 .\cf2 Cells\' +
          'cf6 [\cf8 0\cf6 ,\cf2  \cf8 3\cf6 ].\cf2 Value \cf6 :=\cf2  DBGr' +
          'idEh1\cf6 .\cf2 Columns\cf6 [\cf8 0\cf6 ].\cf2 Title\cf6 .\cf2 C' +
          'aption\cf4 ;\cf2\par'#13#10'    Sheet\cf6 .\cf2 Cells\cf6 [\cf8 1\cf6 ' +
          ',\cf2  \cf8 3\cf6 ].\cf2 Value \cf6 :=\cf2  DBGridEh1\cf6 .\cf2 ' +
          'Columns\cf6 [\cf8 1\cf6 ].\cf2 Title\cf6 .\cf2 Caption\cf4 ;\cf2' +
          '\par'#13#10'    Sheet\cf6 .\cf2 Cells\cf6 [\cf8 2\cf6 ,\cf2  \cf8 3\cf' +
          '6 ].\cf2 Value \cf6 :=\cf2  DBGridEh1\cf6 .\cf2 Columns\cf6 [\cf' +
          '8 2\cf6 ].\cf2 Title\cf6 .\cf2 Caption\cf4 ;\cf2\par'#13#10'    Sheet\' +
          'cf6 .\cf2 Cells\cf6 [\cf8 3\cf6 ,\cf2  \cf8 3\cf6 ].\cf2 Value \' +
          'cf6 :=\cf2  DBGridEh1\cf6 .\cf2 Columns\cf6 [\cf8 3\cf6 ].\cf2 T' +
          'itle\cf6 .\cf2 Caption\cf4 ;\cf2\par'#13#10'    Sheet\cf6 .\cf2 Cells\' +
          'cf6 [\cf8 4\cf6 ,\cf2  \cf8 3\cf6 ].\cf2 Value \cf6 :=\cf2  DBGr' +
          'idEh1\cf6 .\cf2 Columns\cf6 [\cf8 4\cf6 ].\cf2 Title\cf6 .\cf2 C' +
          'aption\cf4 ;\cf2\par'#13#10'    Sheet\cf6 .\cf2 Cells\cf6 [\cf8 5\cf6 ' +
          ',\cf2  \cf8 3\cf6 ].\cf2 Value \cf6 :=\cf2  DBGridEh1\cf6 .\cf2 ' +
          'Columns\cf6 [\cf8 5\cf6 ].\cf2 Title\cf6 .\cf2 Caption\cf4 ;\cf2' +
          '\par'#13#10'    Sheet\cf6 .\cf2 Cells\cf6 [\cf8 6\cf6 ,\cf2  \cf8 3\cf' +
          '6 ].\cf2 Value \cf6 :=\cf2  DBGridEh1\cf6 .\cf2 Columns\cf6 [\cf' +
          '8 6\cf6 ].\cf2 Title\cf6 .\cf2 Caption\cf4 ;\cf2\par'#13#10'  \cf3\b e' +
          'nd\cf4\b0 ;\cf2\par'#13#10'\par'#13#10'  \cf1 //Caption\cf2\par'#13#10'  Sheet\cf6' +
          ' .\cf2 Cells\cf6 [\cf8 0\cf6 ,\cf2  \cf8 0\cf6 ].\cf2 Value \cf6' +
          ' :=\cf2  DBEditEh1\cf6 .\cf7 Text\cf4 ;\cf2\par'#13#10'  cr \cf6 :=\cf' +
          '2  Sheet\cf6 .\cf2 GetCellsRange\cf6 (\cf8 0\cf6 ,\cf8 0\cf6 ,\c' +
          'f8 0\cf6 ,\cf8 0\cf6 )\cf4 ;\cf2\par'#13#10'  cr\cf6 .\cf2 Font\cf6 .\' +
          'cf2 Size \cf6 :=\cf2  \cf8 24\cf4 ;\cf2\par'#13#10'  cr\cf6 .\cf2 Horz' +
          'Align \cf6 :=\cf2  chaCenterEh\cf4 ;\cf2\par'#13#10'  cr\cf6 .\cf2 App' +
          'lyChages\cf4 ;\cf2\par'#13#10'  Sheet\cf6 .\cf2 MergeCell\cf6 (\cf8 0\' +
          'cf6 ,\cf8 0\cf6 ,\cf2  \cf8 6\cf6 ,\cf8 0\cf6 )\cf4 ;\cf2\par'#13#10'\' +
          'par'#13#10'  \cf1 //Export Data rows\cf2\par'#13#10'  i \cf6 :=\cf2  \cf8 0\' +
          'cf4 ;\cf2\par'#13#10'  mtQuery1\cf6 .\cf2 DisableControls\cf4 ;\cf2\pa' +
          'r'#13#10'  mtQuery1\cf6 .\cf2 First\cf4 ;\cf2\par'#13#10'  \cf3\b while\cf2\' +
          'b0  \cf3\b not\cf2\b0  mtQuery1\cf6 .\cf2 Eof \cf3\b do\cf2\b0\p' +
          'ar'#13#10'  \cf3\b begin\cf2\b0\par'#13#10'    Sheet\cf6 .\cf2 Cells\cf6 [\c' +
          'f8 0\cf6 ,\cf2  i \cf6 +\cf2  \cf8 4\cf6 ].\cf2 Value \cf6 :=\cf' +
          '2  DBGridEh1\cf6 .\cf2 Columns\cf6 [\cf8 0\cf6 ].\cf2 Field\cf6 ' +
          '.\cf2 Value\cf4 ;\cf2\par'#13#10'    Sheet\cf6 .\cf2 Cells\cf6 [\cf8 1' +
          '\cf6 ,\cf2  i \cf6 +\cf2  \cf8 4\cf6 ].\cf2 Value \cf6 :=\cf2  D' +
          'BGridEh1\cf6 .\cf2 Columns\cf6 [\cf8 1\cf6 ].\cf2 Field\cf6 .\cf' +
          '2 Value\cf4 ;\cf2\par'#13#10'    Sheet\cf6 .\cf2 Cells\cf6 [\cf8 2\cf6' +
          ' ,\cf2  i \cf6 +\cf2  \cf8 4\cf6 ].\cf2 Value \cf6 :=\cf2  DBGri' +
          'dEh1\cf6 .\cf2 Columns\cf6 [\cf8 2\cf6 ].\cf2 Field\cf6 .\cf2 Va' +
          'lue\cf4 ;\cf2\par'#13#10'\par'#13#10'    Sheet\cf6 .\cf2 Cells\cf6 [\cf8 3\c' +
          'f6 ,\cf2  i \cf6 +\cf2  \cf8 4\cf6 ].\cf2 Value \cf6 :=\cf2  DBG' +
          'ridEh1\cf6 .\cf2 Columns\cf6 [\cf8 3\cf6 ].\cf2 Field\cf6 .\cf2 ' +
          'Value\cf4 ;\cf2\par'#13#10'    Sheet\cf6 .\cf2 Cells\cf6 [\cf8 4\cf6 ,' +
          '\cf2  i \cf6 +\cf2  \cf8 4\cf6 ].\cf2 Value \cf6 :=\cf2  DBGridE' +
          'h1\cf6 .\cf2 Columns\cf6 [\cf8 4\cf6 ].\cf2 Field\cf6 .\cf2 Valu' +
          'e\cf4 ;\cf2\par'#13#10'    Sheet\cf6 .\cf2 Cells\cf6 [\cf8 5\cf6 ,\cf2' +
          '  i \cf6 +\cf2  \cf8 4\cf6 ].\cf2 Value \cf6 :=\cf2  DBGridEh1\c' +
          'f6 .\cf2 Columns\cf6 [\cf8 5\cf6 ].\cf2 Field\cf6 .\cf2 Value\cf' +
          '4 ;\cf2\par'#13#10'    Sheet\cf6 .\cf2 Cells\cf6 [\cf8 6\cf6 ,\cf2  i ' +
          '\cf6 +\cf2  \cf8 4\cf6 ].\cf2 Value \cf6 :=\cf2  DBGridEh1\cf6 .' +
          '\cf2 Columns\cf6 [\cf8 6\cf6 ].\cf2 Field\cf6 .\cf2 Value\cf4 ;\' +
          'cf2\par'#13#10'\par'#13#10'    i \cf6 :=\cf2  i \cf6 +\cf2  \cf8 1\cf4 ;\cf2' +
          '\par'#13#10'    mtQuery1\cf6 .\cf2 Next\cf4 ;\cf2\par'#13#10'  \cf3\b end\cf' +
          '4\b0 ;\cf2\par'#13#10'  mtQuery1\cf6 .\cf2 First\cf4 ;\cf2\par'#13#10'  mtQu' +
          'ery1\cf6 .\cf2 EnableControls\cf4 ;\cf2\par'#13#10'\par'#13#10'  \cf1 // Tit' +
          'le formats\cf2\par'#13#10'  cr \cf6 :=\cf2  Sheet\cf6 .\cf2 GetCellsRa' +
          'nge\cf6 (\cf8 0\cf6 ,\cf8 1\cf6 ,\cf8 6\cf6 ,\cf8 3\cf6 )\cf4 ;\' +
          'cf2\par'#13#10'  cr\cf6 .\cf2 Border\cf6 .\cf2 Top\cf6 .\cf2 Style \cf' +
          '6 :=\cf2  clsMediumEh\cf4 ;\cf2\par'#13#10'  cr\cf6 .\cf2 Border\cf6 .' +
          '\cf2 Bottom\cf6 .\cf2 Style \cf6 :=\cf2  clsMediumEh\cf4 ;\cf2\p' +
          'ar'#13#10'  cr\cf6 .\cf2 Border\cf6 .\cf2 Left\cf6 .\cf2 Style \cf6 :=' +
          '\cf2  clsMediumEh\cf4 ;\cf2\par'#13#10'  cr\cf6 .\cf2 Border\cf6 .\cf2' +
          ' Right\cf6 .\cf2 Style \cf6 :=\cf2  clsMediumEh\cf4 ;\cf2\par'#13#10'\' +
          'par'#13#10'  cr\cf6 .\cf2 InsideBorder\cf6 .\cf2 Top\cf6 .\cf2 Style \' +
          'cf6 :=\cf2  clsThinEh\cf4 ;\cf2\par'#13#10'  cr\cf6 .\cf2 InsideBorder' +
          '\cf6 .\cf2 Bottom\cf6 .\cf2 Style \cf6 :=\cf2  clsThinEh\cf4 ;\c' +
          'f2\par'#13#10'  cr\cf6 .\cf2 InsideBorder\cf6 .\cf2 Left\cf6 .\cf2 Sty' +
          'le \cf6 :=\cf2  clsThinEh\cf4 ;\cf2\par'#13#10'  cr\cf6 .\cf2 InsideBo' +
          'rder\cf6 .\cf2 Right\cf6 .\cf2 Style \cf6 :=\cf2  clsThinEh\cf4 ' +
          ';\cf2\par'#13#10'  cr\cf6 .\cf2 VertAlign \cf6 :=\cf2  cvaCenterEh\cf4' +
          ' ;\cf2\par'#13#10'  cr\cf6 .\cf2 HorzAlign \cf6 :=\cf2  chaCenterEh\cf' +
          '4 ;\cf2\par'#13#10'\par'#13#10'  cr\cf6 .\cf2 ApplyChages\cf4 ;\cf2\par'#13#10'\pa' +
          'r'#13#10'  cr \cf6 :=\cf2  Sheet\cf6 .\cf2 GetCellsRange\cf6 (\cf8 6\c' +
          'f6 ,\cf8 1\cf6 ,\cf8 6\cf6 ,\cf8 1\cf6 )\cf4 ;\cf2\par'#13#10'  cr\cf6' +
          ' .\cf2 Rotation \cf6 :=\cf2  \cf8 90\cf4 ;\cf2\par'#13#10'  cr\cf6 .\c' +
          'f2 ApplyChages\cf4 ;\cf2\par'#13#10'\par'#13#10'  \cf1 //Data formats\cf2\pa' +
          'r'#13#10'  cr \cf6 :=\cf2  Sheet\cf6 .\cf2 GetCellsRange\cf6 (\cf8 0\c' +
          'f6 ,\cf8 4\cf6 ,\cf8 6\cf6 ,\cf2 i\cf6 +\cf8 4\cf6 )\cf4 ;\cf2\p' +
          'ar'#13#10'  cr\cf6 .\cf2 Border\cf6 .\cf2 Top\cf6 .\cf2 Style \cf6 :=\' +
          'cf2  clsMediumEh\cf4 ;\cf2\par'#13#10'  cr\cf6 .\cf2 Border\cf6 .\cf2 ' +
          'Bottom\cf6 .\cf2 Style \cf6 :=\cf2  clsMediumEh\cf4 ;\cf2\par'#13#10' ' +
          ' cr\cf6 .\cf2 Border\cf6 .\cf2 Left\cf6 .\cf2 Style \cf6 :=\cf2 ' +
          ' clsMediumEh\cf4 ;\cf2\par'#13#10'  cr\cf6 .\cf2 Border\cf6 .\cf2 Righ' +
          't\cf6 .\cf2 Style \cf6 :=\cf2  clsMediumEh\cf4 ;\cf2\par'#13#10'\par'#13#10 +
          '  cr\cf6 .\cf2 InsideBorder\cf6 .\cf2 Top\cf6 .\cf2 Style \cf6 :' +
          '=\cf2  clsThinEh\cf4 ;\cf2\par'#13#10'  cr\cf6 .\cf2 InsideBorder\cf6 ' +
          '.\cf2 Bottom\cf6 .\cf2 Style \cf6 :=\cf2  clsThinEh\cf4 ;\cf2\pa' +
          'r'#13#10'  cr\cf6 .\cf2 InsideBorder\cf6 .\cf2 Left\cf6 .\cf2 Style \c' +
          'f6 :=\cf2  clsThinEh\cf4 ;\cf2\par'#13#10'  cr\cf6 .\cf2 InsideBorder\' +
          'cf6 .\cf2 Right\cf6 .\cf2 Style \cf6 :=\cf2  clsThinEh\cf4 ;\cf2' +
          '\par'#13#10'\par'#13#10'  cr\cf6 .\cf2 ApplyChages\cf4 ;\cf2\par'#13#10'\par'#13#10'  \c' +
          'f1 //Data Columns formats\cf2\par'#13#10'  cr \cf6 :=\cf2  Sheet\cf6 .' +
          '\cf2 GetCellsRange\cf6 (\cf8 0\cf6 ,\cf8 4\cf6 ,\cf8 0\cf6 ,\cf2' +
          ' i\cf6 +\cf8 4\cf6 )\cf4 ;\cf2\par'#13#10'  cr\cf6 .\cf2 NumberFormat ' +
          '\cf6 :=\cf2  \cf9 '#39'"VN "0000'#39'\cf4 ;\cf2\par'#13#10'  cr\cf6 .\cf2 Appl' +
          'yChages\cf4 ;\cf2\par'#13#10'\par'#13#10'  cr \cf6 :=\cf2  Sheet\cf6 .\cf2 G' +
          'etCellsRange\cf6 (\cf8 2\cf6 ,\cf8 4\cf6 ,\cf8 2\cf6 ,\cf2 i\cf6' +
          ' +\cf8 4\cf6 )\cf4 ;\cf2\par'#13#10'  cr\cf6 .\cf2 NumberFormat \cf6 :' +
          '=\cf2  \cf9 '#39'"PN-"00000'#39'\cf4 ;\cf2\par'#13#10'  cr\cf6 .\cf2 ApplyChag' +
          'es\cf4 ;\cf2\par'#13#10'\par'#13#10'  cr \cf6 :=\cf2  Sheet\cf6 .\cf2 GetCel' +
          'lsRange\cf6 (\cf8 4\cf6 ,\cf8 4\cf6 ,\cf8 4\cf6 ,\cf2 i\cf6 +\cf' +
          '8 4\cf6 )\cf4 ;\cf2\par'#13#10'  cr\cf6 .\cf2 NumberFormat \cf6 :=\cf2' +
          '  \cf9 '#39'#,##0.0000'#39'\cf4 ;\cf2\par'#13#10'  cr\cf6 .\cf2 ApplyChages\cf' +
          '4 ;\cf2\par'#13#10'\par'#13#10'  \cf1 //Footer values\cf2\par'#13#10'  Sheet\cf6 .' +
          '\cf2 Cells\cf6 [\cf8 0\cf6 ,\cf2  i\cf6 +\cf8 4\cf6 ].\cf2 Value' +
          ' \cf6 :=\cf2  \cf9 '#39'Sum of cost'#39'\cf4 ;\cf2\par'#13#10'  Sheet\cf6 .\cf' +
          '2 Cells\cf6 [\cf8 1\cf6 ,\cf2  i\cf6 +\cf8 4\cf6 ].\cf2 Formula ' +
          '\cf6 :=\cf2  \cf9 '#39'SUM(E5:'#39'\cf2  \cf6 +\cf2  \cf9 '#39'E'#39'\cf2  \cf6 ' +
          '+\cf2  IntToStr\cf6 (\cf2 i\cf6 +\cf8 3\cf6 )\cf2  \cf6 +\cf2  \' +
          'cf9 '#39')'#39'\cf4 ;\cf2\par'#13#10'  cr \cf6 :=\cf2  Sheet\cf6 .\cf2 GetCell' +
          'sRange\cf6 (\cf8 1\cf6 ,\cf2 i\cf6 +\cf8 4\cf6 ,\cf8 1\cf6 ,\cf2' +
          ' i\cf6 +\cf8 4\cf6 )\cf4 ;\cf2\par'#13#10'  cr\cf6 .\cf2 NumberFormat ' +
          '\cf6 :=\cf2  \cf9 '#39'#,##0.0000'#39'\cf4 ;\cf2\par'#13#10'  cr\cf6 .\cf2 App' +
          'lyChages\cf4 ;\cf2\par'#13#10'\par'#13#10'  Sheet\cf6 .\cf2 Cells\cf6 [\cf8 ' +
          '3\cf6 ,\cf2  i\cf6 +\cf8 4\cf6 ].\cf2 Value \cf6 :=\cf2  \cf9 '#39'S' +
          'um'#39'\cf4 ;\cf2\par'#13#10'  Sheet\cf6 .\cf2 Cells\cf6 [\cf8 4\cf6 ,\cf2' +
          '  i\cf6 +\cf8 4\cf6 ].\cf2 Formula \cf6 :=\cf2  \cf9 '#39'SUM(E5:'#39'\c' +
          'f2  \cf6 +\cf2  \cf9 '#39'E'#39'\cf2  \cf6 +\cf2  IntToStr\cf6 (\cf2 i\c' +
          'f6 +\cf8 3\cf6 )\cf2  \cf6 +\cf2  \cf9 '#39')'#39'\cf4 ;\cf2\par'#13#10'  cr \' +
          'cf6 :=\cf2  Sheet\cf6 .\cf2 GetCellsRange\cf6 (\cf8 4\cf6 ,\cf2 ' +
          'i\cf6 +\cf8 4\cf6 ,\cf8 4\cf6 ,\cf2 i\cf6 +\cf8 4\cf6 )\cf4 ;\cf' +
          '2\par'#13#10'  cr\cf6 .\cf2 NumberFormat \cf6 :=\cf2  \cf9 '#39'#,##0.0000' +
          #39'\cf4 ;\cf2\par'#13#10'  cr\cf6 .\cf2 ApplyChages\cf4 ;\cf2\par'#13#10'\par'#13 +
          #10'  \cf1 //Footer Format\cf2\par'#13#10'  cr \cf6 :=\cf2  Sheet\cf6 .\c' +
          'f2 GetCellsRange\cf6 (\cf8 0\cf6 ,\cf2 i\cf6 +\cf8 4\cf6 ,\cf8 6' +
          '\cf6 ,\cf2 i\cf6 +\cf8 4\cf6 )\cf4 ;\cf2\par'#13#10'  cr\cf6 .\cf2 Bor' +
          'der\cf6 .\cf2 Top\cf6 .\cf2 Style \cf6 :=\cf2  clsMediumEh\cf4 ;' +
          '\cf2\par'#13#10'  cr\cf6 .\cf2 Border\cf6 .\cf2 Bottom\cf6 .\cf2 Style' +
          ' \cf6 :=\cf2  clsMediumEh\cf4 ;\cf2\par'#13#10'  cr\cf6 .\cf2 Border\c' +
          'f6 .\cf2 Left\cf6 .\cf2 Style \cf6 :=\cf2  clsMediumEh\cf4 ;\cf2' +
          '\par'#13#10'  cr\cf6 .\cf2 Border\cf6 .\cf2 Right\cf6 .\cf2 Style \cf6' +
          ' :=\cf2  clsMediumEh\cf4 ;\cf2\par'#13#10'  cr\cf6 .\cf2 Font\cf6 .\cf' +
          '2 IsBold \cf6 :=\cf2  \cf10 True\cf4 ;\cf2\par'#13#10'  cr\cf6 .\cf2 A' +
          'pplyChages\cf4 ;\cf2\par'#13#10'\par'#13#10'  \cf1 //Final\cf2\par'#13#10'  Sheet\' +
          'cf6 .\cf2 FrozenRowCount \cf6 :=\cf2  \cf8 4\cf4 ;\cf2\par'#13#10'  Sh' +
          'eet\cf6 .\cf2 AutoFilterRange\cf6 .\cf2 FromCol \cf6 :=\cf2  \cf' +
          '8 0\cf4 ;\cf2\par'#13#10'  Sheet\cf6 .\cf2 AutoFilterRange\cf6 .\cf2 F' +
          'romRow \cf6 :=\cf2  \cf8 3\cf4 ;\cf2\par'#13#10'  Sheet\cf6 .\cf2 Auto' +
          'FilterRange\cf6 .\cf2 ToCol \cf6 :=\cf2  \cf8 6\cf4 ;\cf2\par'#13#10' ' +
          ' Sheet\cf6 .\cf2 AutoFilterRange\cf6 .\cf2 ToRow \cf6 :=\cf2  i\' +
          'cf6 +\cf8 4\cf6 -\cf8 1\cf4 ;\cf2\par'#13#10'\par'#13#10'\cf3\b end\cf4\b0 ;' +
          '\cf2\par'#13#10'\par'#13#10'\cf3\b procedure\cf2\b0  TForm2\cf6 .\cf2 Export' +
          'Worksheet2\cf6 (\cf2 Sheet\cf6 :\cf2  TXlsWorksheetEh\cf6 )\cf4 ' +
          ';\cf2\par'#13#10'\cf3\b var\cf2\b0\par'#13#10'  cr\cf6 :\cf2  IXlsFileCellsR' +
          'angeEh\cf4 ;\cf2\par'#13#10'  i\cf6 :\cf2  \cf7 Integer\cf4 ;\cf2\par'#13 +
          #10'  AFont\cf6 :\cf2  TFont\cf4 ;\cf2\par'#13#10'\cf3\b begin\cf2\b0\par' +
          #13#10'  Sheet\cf6 .\cf2 Columns\cf6 [\cf8 0\cf6 ].\cf2 Width \cf6 :=' +
          '\cf2  Sheet\cf6 .\cf2 Columns\cf6 .\cf2 ScreenToXlsWidth\cf6 (\c' +
          'f2 DBVertGridEh1\cf6 .\cf2 ColWidths\cf6 [\cf8 0\cf6 ])\cf4 ;\cf' +
          '2\par'#13#10'  Sheet\cf6 .\cf2 Columns\cf6 [\cf8 1\cf6 ].\cf2 Width \c' +
          'f6 :=\cf2  Sheet\cf6 .\cf2 Columns\cf6 .\cf2 ScreenToXlsWidth\cf' +
          '6 (\cf2 DBVertGridEh1\cf6 .\cf2 ColWidths\cf6 [\cf8 1\cf6 ])\cf4' +
          ' ;\cf2\par'#13#10'\par'#13#10'  Sheet\cf6 .\cf2 Cells\cf6 [\cf8 0\cf6 ,\cf2 ' +
          ' \cf8 0\cf6 ].\cf2 Value \cf6 :=\cf2  DBEditEh2\cf6 .\cf7 Text\c' +
          'f4 ;\cf2\par'#13#10'  cr \cf6 :=\cf2  Sheet\cf6 .\cf2 GetCellsRange\cf' +
          '6 (\cf8 0\cf6 ,\cf8 0\cf6 ,\cf8 0\cf6 ,\cf8 0\cf6 )\cf4 ;\cf2\pa' +
          'r'#13#10'  cr\cf6 .\cf2 Font\cf6 .\cf2 Size \cf6 :=\cf2  \cf8 24\cf4 ;' +
          '\cf2\par'#13#10'  cr\cf6 .\cf2 ApplyChages\cf4 ;\cf2\par'#13#10'\par'#13#10'  \cf3' +
          '\b for\cf2\b0  i \cf6 :=\cf2  \cf8 0\cf2  \cf3\b to\cf2\b0  DBVe' +
          'rtGridEh1\cf6 .\cf2 VisibleFieldRowCount \cf6 -\cf2  \cf8 1\cf2 ' +
          ' \cf3\b do\cf2\b0\par'#13#10'  \cf3\b begin\cf2\b0\par'#13#10'    \cf1 //Lab' +
          'el Cell\cf2\par'#13#10'    Sheet\cf6 .\cf2 Cells\cf6 [\cf8 0\cf6 ,\cf2' +
          '  i\cf6 +\cf8 1\cf6 ].\cf2 Value \cf6 :=\cf2  DBVertGridEh1\cf6 ' +
          '.\cf2 VisibleFieldRow\cf6 [\cf2 i\cf6 ].\cf2 RowLabel\cf6 .\cf2 ' +
          'Caption\cf4 ;\cf2\par'#13#10'    cr \cf6 :=\cf2  Sheet\cf6 .\cf2 GetCe' +
          'llsRange\cf6 (\cf8 0\cf6 ,\cf2  i\cf6 +\cf8 1\cf6 ,\cf2  \cf8 0\' +
          'cf6 ,\cf2  i\cf6 +\cf8 1\cf6 )\cf4 ;\cf2\par'#13#10'    cr\cf6 .\cf2 F' +
          'ill\cf6 .\cf2 Color \cf6 :=\cf2  DBVertGridEh1\cf6 .\cf2 Visible' +
          'FieldRow\cf6 [\cf2 i\cf6 ].\cf2 RowLabel\cf6 .\cf2 Color\cf4 ;\c' +
          'f2\par'#13#10'\par'#13#10'    AFont \cf6 :=\cf2  DBVertGridEh1\cf6 .\cf2 Vis' +
          'ibleFieldRow\cf6 [\cf2 i\cf6 ].\cf2 RowLabel\cf6 .\cf2 Font\cf4 ' +
          ';\cf2\par'#13#10'    cr\cf6 .\cf2 Font\cf6 .\cf2 Name \cf6 :=\cf2  AFo' +
          'nt\cf6 .\cf2 Name\cf4 ;\cf2\par'#13#10'    cr\cf6 .\cf2 Font\cf6 .\cf2' +
          ' Size \cf6 :=\cf2  AFont\cf6 .\cf2 Size\cf4 ;\cf2\par'#13#10'    cr\cf' +
          '6 .\cf2 Font\cf6 .\cf2 Color \cf6 :=\cf2  AFont\cf6 .\cf2 Color\' +
          'cf4 ;\cf2\par'#13#10'    cr\cf6 .\cf2 Font\cf6 .\cf2 IsBold \cf6 :=\cf' +
          '2  fsBold \cf3\b in\cf2\b0  AFont\cf6 .\cf2 Style\cf4 ;\cf2\par'#13 +
          #10'    cr\cf6 .\cf2 Font\cf6 .\cf2 IsItalic \cf6 :=\cf2  fsItalic ' +
          '\cf3\b in\cf2\b0  AFont\cf6 .\cf2 Style\cf4 ;\cf2\par'#13#10'    cr\cf' +
          '6 .\cf2 Font\cf6 .\cf2 IsUnderline \cf6 :=\cf2  fsUnderline \cf3' +
          '\b in\cf2\b0  AFont\cf6 .\cf2 Style\cf4 ;\cf2\par'#13#10'\par'#13#10'    cr\' +
          'cf6 .\cf2 ApplyChages\cf4 ;\cf2\par'#13#10'\par'#13#10'    \cf1 //Data Cell\' +
          'cf2\par'#13#10'    Sheet\cf6 .\cf2 Cells\cf6 [\cf8 1\cf6 ,\cf2  i\cf6 ' +
          '+\cf8 1\cf6 ].\cf2 Value \cf6 :=\cf2  DBVertGridEh1\cf6 .\cf2 Vi' +
          'sibleFieldRow\cf6 [\cf2 i\cf6 ].\cf2 Field\cf6 .\cf2 Value\cf4 ;' +
          '\cf2\par'#13#10'    cr \cf6 :=\cf2  Sheet\cf6 .\cf2 GetCellsRange\cf6 ' +
          '(\cf8 1\cf6 ,\cf2  i\cf6 +\cf8 1\cf6 ,\cf2  \cf8 1\cf6 ,\cf2  i\' +
          'cf6 +\cf8 1\cf6 )\cf4 ;\cf2\par'#13#10'    cr\cf6 .\cf2 Fill\cf6 .\cf2' +
          ' Color \cf6 :=\cf2  DBVertGridEh1\cf6 .\cf2 VisibleFieldRow\cf6 ' +
          '[\cf2 i\cf6 ].\cf2 Color\cf4 ;\cf2\par'#13#10'\par'#13#10'    AFont \cf6 :=\' +
          'cf2  DBVertGridEh1\cf6 .\cf2 VisibleFieldRow\cf6 [\cf2 i\cf6 ].\' +
          'cf2 Font\cf4 ;\cf2\par'#13#10'    cr\cf6 .\cf2 Font\cf6 .\cf2 Name \cf' +
          '6 :=\cf2  AFont\cf6 .\cf2 Name\cf4 ;\cf2\par'#13#10'    cr\cf6 .\cf2 F' +
          'ont\cf6 .\cf2 Size \cf6 :=\cf2  AFont\cf6 .\cf2 Size\cf4 ;\cf2\p' +
          'ar'#13#10'    cr\cf6 .\cf2 Font\cf6 .\cf2 Color \cf6 :=\cf2  AFont\cf6' +
          ' .\cf2 Color\cf4 ;\cf2\par'#13#10'    cr\cf6 .\cf2 Font\cf6 .\cf2 IsBo' +
          'ld \cf6 :=\cf2  fsBold \cf3\b in\cf2\b0  AFont\cf6 .\cf2 Style\c' +
          'f4 ;\cf2\par'#13#10'    cr\cf6 .\cf2 Font\cf6 .\cf2 IsItalic \cf6 :=\c' +
          'f2  fsItalic \cf3\b in\cf2\b0  AFont\cf6 .\cf2 Style\cf4 ;\cf2\p' +
          'ar'#13#10'    cr\cf6 .\cf2 Font\cf6 .\cf2 IsUnderline \cf6 :=\cf2  fsU' +
          'nderline \cf3\b in\cf2\b0  AFont\cf6 .\cf2 Style\cf4 ;\cf2\par'#13#10 +
          '\par'#13#10'    cr\cf6 .\cf2 HorzAlign \cf6 :=\cf2  AlignmentToXlsFile' +
          'CellHorzAlign\cf6 (\cf2 DBVertGridEh1\cf6 .\cf2 VisibleFieldRow\' +
          'cf6 [\cf2 i\cf6 ].\cf2 Alignment\cf6 )\cf4 ;\cf2\par'#13#10'\par'#13#10'\lan' +
          'g1033     cr\cf6 .\cf2 ApplyChages\cf4 ;\cf2\par'#13#10'  \cf3\b end\c' +
          'f4\b0 ;\cf2\par'#13#10'\par'#13#10'  cr \cf6 :=\cf2  Sheet\cf6 .\cf2 GetCell' +
          'sRange\cf6 (\cf8 0\cf6 ,\cf8 1\cf6 ,\cf8 1\cf6 ,\cf2 DBVertGridE' +
          'h1\cf6 .\cf2 VisibleFieldRowCount\cf6 )\cf4 ;\cf2\par'#13#10'  cr\cf6 ' +
          '.\cf2 Border\cf6 .\cf2 Top\cf6 .\cf2 Style \cf6 :=\cf2  clsMediu' +
          'mEh\cf4 ;\cf2\par'#13#10'  cr\cf6 .\cf2 Border\cf6 .\cf2 Bottom\cf6 .\' +
          'cf2 Style \cf6 :=\cf2  clsMediumEh\cf4 ;\cf2\par'#13#10'  cr\cf6 .\cf2' +
          ' Border\cf6 .\cf2 Left\cf6 .\cf2 Style \cf6 :=\cf2  clsMediumEh\' +
          'cf4 ;\cf2\par'#13#10'  cr\cf6 .\cf2 Border\cf6 .\cf2 Right\cf6 .\cf2 S' +
          'tyle \cf6 :=\cf2  clsMediumEh\cf4 ;\cf2\par'#13#10'\par'#13#10'  cr\cf6 .\cf' +
          '2 InsideBorder\cf6 .\cf2 Top\cf6 .\cf2 Style \cf6 :=\cf2  clsThi' +
          'nEh\cf4 ;\cf2\par'#13#10'  cr\cf6 .\cf2 InsideBorder\cf6 .\cf2 Bottom\' +
          'cf6 .\cf2 Style \cf6 :=\cf2  clsThinEh\cf4 ;\cf2\par'#13#10'  cr\cf6 .' +
          '\cf2 InsideBorder\cf6 .\cf2 Left\cf6 .\cf2 Style \cf6 :=\cf2  cl' +
          'sThinEh\cf4 ;\cf2\par'#13#10'  cr\cf6 .\cf2 InsideBorder\cf6 .\cf2 Rig' +
          'ht\cf6 .\cf2 Style \cf6 :=\cf2  clsThinEh\cf4 ;\cf2\par'#13#10'  cr\cf' +
          '6 .\cf2 ApplyChages\cf4 ;\cf2\par'#13#10'\par'#13#10'  cr \cf6 :=\cf2  Sheet' +
          '\cf6 .\cf2 GetCellsRange\cf6 (\cf8 1\cf6 ,\cf8 1\cf6 ,\cf8 1\cf6' +
          ' ,\cf2 DBVertGridEh1\cf6 .\cf2 VisibleFieldRowCount\cf6 )\cf4 ;\' +
          'cf2\par'#13#10'  cr\cf6 .\cf2 WrapText \cf6 :=\cf2  \cf10 True\cf4 ;\c' +
          'f2\par'#13#10'  cr\cf6 .\cf2 HorzAlign \cf6 :=\cf2  chaLeftEh\cf4 ;\cf' +
          '2\par'#13#10'  cr\cf6 .\cf2 ApplyChages\cf4 ;\cf2\par'#13#10'\par'#13#10'  cr\cf6 ' +
          '.\cf2 ApplyChages\cf4 ;\cf2\par'#13#10'\cf3\b end\cf4\b0 ;\cf2\par'#13#10'\p' +
          'ar'#13#10'\cf3\lang1049\b end\cf6\b0 .\cf2\par'#13#10'\pard\cf0\f1\fs16\par'#13 +
          #10'}'#13#10#0
      end
    end
  end
  object PageControl2: TPageControl
    Left = 0
    Top = 0
    Width = 826
    Height = 99
    ActivePage = TabSheet4
    Align = alTop
    TabOrder = 1
    object TabSheet3: TTabSheet
      Caption = 'Export'
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 818
        Height = 71
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        DesignSize = (
          818
          71)
        object PaintBox1: TPaintBox
          Left = 0
          Top = 0
          Width = 818
          Height = 71
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label1: TLabel
          Left = 22
          Top = 6
          Width = 293
          Height = 23
          Caption = 'Export tabular data to Xlsx file'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -19
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object btnExportAsXlsx: TButton
          Left = 574
          Top = 2
          Width = 235
          Height = 33
          Anchors = [akTop, akRight]
          Caption = 'Export to Xlsx file'
          TabOrder = 0
          OnClick = btnExportAsXlsxClick
        end
        object CheckBox1: TCheckBox
          Left = 574
          Top = 41
          Width = 235
          Height = 17
          Anchors = [akTop, akRight]
          Caption = 'Open file after export'
          Checked = True
          State = cbChecked
          TabOrder = 1
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Import and Modify'
      ImageIndex = 1
      DesignSize = (
        818
        71)
      object Label2: TLabel
        Left = 14
        Top = 4
        Width = 388
        Height = 23
        Caption = 'Import and modify '#39'TestXlsFile.Xlsx'#39' file.'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -19
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
      end
      object btnImportModifyExport: TButton
        Left = 580
        Top = 3
        Width = 235
        Height = 33
        Anchors = [akTop, akRight]
        Caption = 'Import / Add new Sheet / Export'
        TabOrder = 0
        OnClick = btnImportModifyExportClick
      end
      object CheckBox2: TCheckBox
        Left = 580
        Top = 42
        Width = 235
        Height = 17
        Anchors = [akTop, akRight]
        Caption = 'Open file after export'
        Checked = True
        State = cbChecked
        TabOrder = 1
      end
    end
  end
  object qrVendors: TMemTableEh
    Active = True
    Params = <>
    Left = 200
    Top = 304
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
        object Country: TMTStringDataFieldEh
          FieldName = 'Country'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'Country'
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
        object FAX: TMTStringDataFieldEh
          FieldName = 'FAX'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'FAX'
          DisplayWidth = 15
          Size = 15
          Transliterate = True
        end
        object Preferred: TMTBooleanDataFieldEh
          FieldName = 'Preferred'
          DisplayLabel = 'Preferred'
          DisplayWidth = 5
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
            nil
            nil
            False)
          (
            26
            '322'
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            nil
            False)
          (
            9
            'Amor Aqua'
            '42 West 29th Street'
            nil
            'New York'
            'NY'
            '10011'
            'U.S.A.'
            '800-555-6880'
            '212-555-7286'
            True)
          (
            10
            'Aqua Research Corp.'
            'P.O. Box 998'
            nil
            'Cornish'
            'NH'
            '03745'
            'U.S.A.'
            '603-555-2254'
            nil
            True)
          (
            11
            'B&K Undersea Photo'
            '116 W 7th Street'
            nil
            'New York'
            'NY'
            '10011'
            'U.S.A.'
            '800-555-5662'
            '212-555-7474'
            False)
          (
            8
            'Beauchat, Inc.'
            '45900 SW 2nd Ave'
            nil
            'Ft Lauderdale'
            'FL'
            '33315'
            'U.S.A.'
            '305-555-7242'
            '305-555-6739'
            True)
          (
            1
            'Cacor Corporation'
            '161 Southfield Rd'
            nil
            'Southfield'
            'OH'
            '60093'
            'U.S.A.'
            '708-555-9555'
            '708-555-7547'
            True)
          (
            18
            'Central Valley Skin Divers'
            '160 Jameston Ave'
            nil
            'Jamaica'
            'NY'
            '11432'
            'U.S.A.'
            '718-555-5772'
            nil
            False)
          (
            22
            'Dive & Surf'
            'P.O. Box 20210'
            nil
            'Indianapolis'
            'IN'
            '46208'
            'U.S.A.'
            '317-555-4523'
            nil
            False)
          (
            21
            'Dive Canada'
            '275 W Ninth Ave'
            nil
            'Vancouver'
            'British Columbia'
            'V6K 1P9'
            'Canada'
            '604-555-2681'
            '604-555-3749'
            True)
          (
            15
            'Dive Time'
            '20 Miramar Ave'
            nil
            'Long Beach'
            'CA'
            '90815'
            'U.S.A.'
            '213-555-3708'
            '213-555-1390'
            True)
          (
            5
            'Divers'#39'  Supply Shop'
            '5208 University Dr'
            nil
            'Macon'
            'GA'
            '20865'
            'U.S.A.'
            '912-555-6790'
            '912-555-8474'
            False)
          (
            12
            'Diving International Unlimited'
            '1148 David Drive'
            nil
            'San Diego'
            'DA'
            '92102'
            'U.S.A.'
            '800-555-8439'
            nil
            True)
          (
            17
            'Felix Diving'
            '310 S Michigan Ave'
            nil
            'Chicago'
            'IL'
            '60607'
            'U.S.A.'
            '800-555-3549'
            '312-555-1586'
            False)
          (
            23
            'Fish Research Labs'
            '29 Wilkins Rd Dept. SD'
            nil
            'Los Banos'
            'CA'
            '93635'
            'U.S.A.'
            '209-555-3292'
            '203-555-0416'
            True)
          (
            14
            'Glen Specialties, Inc.'
            '17663 Campbell Lane'
            nil
            'Huntington Beach'
            'CA'
            '92647'
            'U.S.A.'
            '714-555-5100'
            '714-555-6539'
            True)
          (
            3
            'J.W.  Luscher Mfg.'
            '65 Addams Street'
            nil
            'Berkely'
            'MA'
            '02779'
            'U.S.A.'
            '800-555-4744'
            '508-555-8949'
            False)
          (
            20
            'Marine Camera & Dive'
            '117 South Valley Rd'
            nil
            'San Diego'
            'CA'
            '92121'
            'U.S.A.'
            '619-555-0604'
            '619-555-6499'
            True)
          (
            13
            'Nautical Compressors'
            '65 NW 167 Street'
            nil
            'Miami'
            'FL'
            '33015'
            'U.S.A.'
            '305-555-5554'
            '305-555-0268'
            True)
          (
            19
            'Parkway Dive Shop'
            '241 Kelly Street'
            nil
            'South Amboy'
            'NJ'
            '08879'
            'U.S.A.'
            '908-555-5300'
            nil
            True)
          (
            7
            'Perry Scuba'
            '3443 James Ave'
            nil
            'Hapeville'
            'GA'
            '30354'
            'U.S.A.'
            '800-555-6220'
            '404-555-8280'
            True)
          (
            4
            'Scuba Professionals'
            '3105 East Brace'
            nil
            'Rancho Dominguez'
            'CA'
            '90221'
            'U.S.A.'
            '213-555-7850'
            nil
            True)
          (
            6
            'Techniques'
            '52 Dolphin Drive'
            nil
            'Redwood City'
            'CA'
            '94065-1086'
            'U.S.A.'
            '415-555-1410'
            '415-555-1276'
            False)
          (
            16
            'Undersea Systems, Inc.'
            '18112 Gotham Street'
            nil
            'Huntington Beach'
            'CA'
            '92648'
            'U.S.A.'
            '800-555-3483'
            nil
            True)
          (
            2
            'Underwater'
            '50 N 3rd Street'
            nil
            'Indianapolis'
            'IN'
            '46208'
            'U.S.A.'
            '317-555-4523'
            nil
            True))
      end
    end
  end
  object DataSource1: TDataSource
    DataSet = mtQuery1
    Left = 170
    Top = 348
  end
  object mtQuery1: TMemTableEh
    Active = True
    CachedUpdates = True
    Filtered = True
    FetchAllOnOpen = True
    Params = <>
    Left = 206
    Top = 340
    object mtQuery1VNo: TFloatField
      DisplayLabel = 'Vendor of parts|Vendor Number|1'
      DisplayWidth = 17
      FieldName = 'VNo'
      Origin = '"Vendors.DB".VendorNo'
      DisplayFormat = 'VN 0000'
    end
    object mtQuery1VName: TStringField
      DisplayLabel = 'Vendor of parts|Vendor Name|2'
      DisplayWidth = 24
      FieldName = 'VName'
      Origin = '"Vendors.DB".VendorName'
      Size = 30
    end
    object mtQuery1PNo: TFloatField
      Alignment = taLeftJustify
      DisplayLabel = 'Parts|PN|3'
      DisplayWidth = 15
      FieldName = 'PNo'
      Origin = '"PARTS.DB".PartNo'
      DisplayFormat = 'PN-00000'
    end
    object mtQuery1PDescription: TStringField
      DisplayLabel = 'Parts|Description|4'
      DisplayWidth = 18
      FieldName = 'PDescription'
      Origin = '"PARTS.DB".Description'
      Size = 30
    end
    object mtQuery1PCost: TCurrencyField
      DisplayLabel = 'Parts|Cost|5'
      DisplayWidth = 9
      FieldName = 'PCost'
      Origin = '"PARTS.DB".Cost'
      DisplayFormat = '#,##0.0000'
    end
    object mtQuery1IQty: TIntegerField
      DisplayLabel = 'Items|Qry|6'
      DisplayWidth = 21
      FieldName = 'IQty'
      Origin = '"ITEMS.DB".Qty'
    end
    object mtQuery1VName1: TStringField
      FieldKind = fkLookup
      FieldName = 'VName1'
      LookupDataSet = qrVendors
      LookupKeyFields = 'VendorNo'
      LookupResultField = 'VendorName'
      KeyFields = 'VNo'
      Lookup = True
    end
    object mtQuery1VPreferred: TBooleanField
      FieldName = 'VPreferred'
      Origin = '"vendors.DB".Preferred'
    end
    object MemTableData: TMemTableDataEh
      object DataStruct: TMTDataStructEh
        object VNo: TMTNumericDataFieldEh
          FieldName = 'VNo'
          NumericDataType = fdtFloatEh
          AutoIncrement = False
          DisplayLabel = 'Vendor of parts|Vendor Number|1'
          DisplayWidth = 17
          DisplayFormat = 'VN 0000'
          currency = False
          Precision = 15
        end
        object VName: TMTStringDataFieldEh
          FieldName = 'VName'
          StringDataType = fdtStringEh
          DisplayLabel = 'Vendor of parts|Vendor Name|2'
          DisplayWidth = 24
          Size = 30
          Transliterate = True
        end
        object PNo: TMTNumericDataFieldEh
          FieldName = 'PNo'
          NumericDataType = fdtFloatEh
          AutoIncrement = False
          Alignment = taLeftJustify
          DisplayLabel = 'Parts|PN|3'
          DisplayWidth = 15
          DisplayFormat = 'PN-00000'
          currency = False
          Precision = 15
        end
        object PDescription: TMTStringDataFieldEh
          FieldName = 'PDescription'
          StringDataType = fdtStringEh
          DisplayLabel = 'Parts|Description|4'
          DisplayWidth = 18
          Size = 30
          Transliterate = True
        end
        object PCost: TMTNumericDataFieldEh
          FieldName = 'PCost'
          NumericDataType = fdtCurrencyEh
          AutoIncrement = False
          DisplayLabel = 'Parts|Cost|5'
          DisplayWidth = 9
          DisplayFormat = '#,##0.0000'
          currency = True
          Precision = 15
        end
        object IQty: TMTNumericDataFieldEh
          FieldName = 'IQty'
          NumericDataType = fdtIntegerEh
          AutoIncrement = False
          DisplayLabel = 'Items|Qry|6'
          DisplayWidth = 21
          currency = False
          Precision = 15
        end
        object VPreferred: TMTBooleanDataFieldEh
          FieldName = 'VPreferred'
          DisplayLabel = 'VPreferred'
          DisplayWidth = 5
        end
      end
      object RecordsList: TRecordsListEh
        Data = (
          (
            1.000000000000000000
            'Cacor Corporation'
            26.000000000000000000
            'Wrist Band Thermometer (C)'
            64800c
            1
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            26.000000000000000000
            'Wrist Band Thermometer (C)'
            64800c
            1
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            23.000000000000000000
            'Wrist Band Thermometer (F)'
            79200c
            1
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            22.000000000000000000
            'Navigation Compass'
            91770c
            1
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            22.000000000000000000
            'Navigation Compass'
            91770c
            1
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            22.000000000000000000
            'Navigation Compass'
            91770c
            1
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            22.000000000000000000
            'Navigation Compass'
            91770c
            1
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            22.000000000000000000
            'Navigation Compass'
            91770c
            1
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            22.000000000000000000
            'Navigation Compass'
            91770c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            16.000000000000000000
            'Compass Console Mount'
            101500c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            16.000000000000000000
            'Compass Console Mount'
            101500c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            16.000000000000000000
            'Compass Console Mount'
            101500c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            16.000000000000000000
            'Compass Console Mount'
            101500c
            1
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            20.000000000000000000
            'Direct Sighting Compass'
            125820c
            1
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            20.000000000000000000
            'Direct Sighting Compass'
            125820c
            1
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            20.000000000000000000
            'Direct Sighting Compass'
            125820c
            1
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            20.000000000000000000
            'Direct Sighting Compass'
            125820c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            32.000000000000000000
            'Safety Knife'
            131200c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            32.000000000000000000
            'Safety Knife'
            131200c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            32.000000000000000000
            'Safety Knife'
            131200c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            32.000000000000000000
            'Safety Knife'
            131200c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            34.000000000000000000
            'Chisel Point Knife'
            143500c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            34.000000000000000000
            'Chisel Point Knife'
            143500c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            34.000000000000000000
            'Chisel Point Knife'
            143500c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            34.000000000000000000
            'Chisel Point Knife'
            143500c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            34.000000000000000000
            'Chisel Point Knife'
            143500c
            1
            True)
          (
            22.000000000000000000
            'Dive & Surf'
            41.000000000000000000
            'Halogen Flashlight'
            191840c
            1
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            41.000000000000000000
            'Halogen Flashlight'
            191840c
            1
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            39.000000000000000000
            'Krypton Flashlight'
            206770c
            1
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            39.000000000000000000
            'Krypton Flashlight'
            206770c
            1
            False)
          (
            4.000000000000000000
            'Scuba Professionals'
            17.000000000000000000
            'Compass (meter only)'
            249600c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            17.000000000000000000
            'Compass (meter only)'
            249600c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            17.000000000000000000
            'Compass (meter only)'
            249600c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            17.000000000000000000
            'Compass (meter only)'
            249600c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            17.000000000000000000
            'Compass (meter only)'
            249600c
            1
            True)
          (
            15.000000000000000000
            'Dive Time'
            33.000000000000000000
            'Medium Titanium Knife'
            267665c
            1
            True)
          (
            15.000000000000000000
            'Dive Time'
            33.000000000000000000
            'Medium Titanium Knife'
            267665c
            1
            True)
          (
            15.000000000000000000
            'Dive Time'
            33.000000000000000000
            'Medium Titanium Knife'
            267665c
            1
            True)
          (
            15.000000000000000000
            'Dive Time'
            33.000000000000000000
            'Medium Titanium Knife'
            267665c
            1
            True)
          (
            15.000000000000000000
            'Dive Time'
            33.000000000000000000
            'Medium Titanium Knife'
            267665c
            1
            True)
          (
            15.000000000000000000
            'Dive Time'
            33.000000000000000000
            'Medium Titanium Knife'
            267665c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            37.000000000000000000
            'Divers Knife and Sheath'
            273000c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            35.000000000000000000
            'Flashlight'
            292500c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            35.000000000000000000
            'Flashlight'
            292500c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            35.000000000000000000
            'Flashlight'
            292500c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            35.000000000000000000
            'Flashlight'
            292500c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            35.000000000000000000
            'Flashlight'
            292500c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            35.000000000000000000
            'Flashlight'
            292500c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            36.000000000000000000
            'Medium Stainless Steel Knife'
            343000c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            36.000000000000000000
            'Medium Stainless Steel Knife'
            343000c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            36.000000000000000000
            'Medium Stainless Steel Knife'
            343000c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            36.000000000000000000
            'Medium Stainless Steel Knife'
            343000c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            36.000000000000000000
            'Medium Stainless Steel Knife'
            343000c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            36.000000000000000000
            'Medium Stainless Steel Knife'
            343000c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            38.000000000000000000
            'Large Stainless Steel Knife'
            376000c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            38.000000000000000000
            'Large Stainless Steel Knife'
            376000c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            38.000000000000000000
            'Large Stainless Steel Knife'
            376000c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            38.000000000000000000
            'Large Stainless Steel Knife'
            376000c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            38.000000000000000000
            'Large Stainless Steel Knife'
            376000c
            1
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            25.000000000000000000
            'Depth/Pressure Gauge (Analog)'
            392700c
            1
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            25.000000000000000000
            'Depth/Pressure Gauge (Analog)'
            392700c
            1
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            25.000000000000000000
            'Depth/Pressure Gauge (Analog)'
            392700c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            14.000000000000000000
            'Depth/Pressure Gauge'
            483000c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            14.000000000000000000
            'Depth/Pressure Gauge'
            483000c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            14.000000000000000000
            'Depth/Pressure Gauge'
            483000c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            14.000000000000000000
            'Depth/Pressure Gauge'
            483000c
            1
            True)
          (
            22.000000000000000000
            'Dive & Surf'
            40.000000000000000000
            'Flashlight (Rechargeable)'
            509850c
            1
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            50.000000000000000000
            'Camera and Case'
            527780c
            1
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            50.000000000000000000
            'Camera and Case'
            527780c
            1
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            50.000000000000000000
            'Camera and Case'
            527780c
            1
            False)
          (
            1.000000000000000000
            'Cacor Corporation'
            24.000000000000000000
            'Depth/Pressure Gauge (Digital)'
            536400c
            1
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            24.000000000000000000
            'Depth/Pressure Gauge (Digital)'
            536400c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            42.000000000000000000
            '60.6 cu ft Tank'
            572800c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            42.000000000000000000
            '60.6 cu ft Tank'
            572800c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            42.000000000000000000
            '60.6 cu ft Tank'
            572800c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            42.000000000000000000
            '60.6 cu ft Tank'
            572800c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            42.000000000000000000
            '60.6 cu ft Tank'
            572800c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            44.000000000000000000
            '71.4 cu ft Tank'
            585000c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            44.000000000000000000
            '71.4 cu ft Tank'
            585000c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            44.000000000000000000
            '71.4 cu ft Tank'
            585000c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            44.000000000000000000
            '71.4 cu ft Tank'
            585000c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            44.000000000000000000
            '71.4 cu ft Tank'
            585000c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            10.000000000000000000
            'First Stage Regulator'
            646000c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            15.000000000000000000
            'Personal Dive Sonar'
            728500c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            15.000000000000000000
            'Personal Dive Sonar'
            728500c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            15.000000000000000000
            'Personal Dive Sonar'
            728500c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            15.000000000000000000
            'Personal Dive Sonar'
            728500c
            1
            True)
          (
            21.000000000000000000
            'Dive Canada'
            12.000000000000000000
            'Depth/Pressure Gauge Console'
            733200c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            6.000000000000000000
            'Second Stage Regulator'
            735300c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            6.000000000000000000
            'Second Stage Regulator'
            735300c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            6.000000000000000000
            'Second Stage Regulator'
            735300c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            18.000000000000000000
            'Depth/Pressure Gauge'
            762200c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            8.000000000000000000
            'Alternate Inflation Regulator'
            858000c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            8.000000000000000000
            'Alternate Inflation Regulator'
            858000c
            1
            True)
          (
            21.000000000000000000
            'Dive Canada'
            11.000000000000000000
            'Second Stage Regulator'
            957900c
            1
            True)
          (
            21.000000000000000000
            'Dive Canada'
            11.000000000000000000
            'Second Stage Regulator'
            957900c
            1
            True)
          (
            21.000000000000000000
            'Dive Canada'
            11.000000000000000000
            'Second Stage Regulator'
            957900c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            45.000000000000000000
            '75.8 cu ft Tank'
            963500c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            45.000000000000000000
            '75.8 cu ft Tank'
            963500c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            45.000000000000000000
            '75.8 cu ft Tank'
            963500c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            45.000000000000000000
            '75.8 cu ft Tank'
            963500c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            9.000000000000000000
            'Second Stage Regulator'
            999000c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            9.000000000000000000
            'Second Stage Regulator'
            999000c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            9.000000000000000000
            'Second Stage Regulator'
            999000c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            9.000000000000000000
            'Second Stage Regulator'
            999000c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            31.000000000000000000
            'Welded Seam Stabilizing Vest'
            1092000c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            31.000000000000000000
            'Welded Seam Stabilizing Vest'
            1092000c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            31.000000000000000000
            'Welded Seam Stabilizing Vest'
            1092000c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            3.000000000000000000
            'Regulator System'
            1175000c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            3.000000000000000000
            'Regulator System'
            1175000c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            3.000000000000000000
            'Regulator System'
            1175000c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            5.000000000000000000
            'Regulator System'
            1193500c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            5.000000000000000000
            'Regulator System'
            1193500c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            5.000000000000000000
            'Regulator System'
            1193500c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            5.000000000000000000
            'Regulator System'
            1193500c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            13.000000000000000000
            'Electronic Console'
            1209000c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            13.000000000000000000
            'Electronic Console'
            1209000c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            13.000000000000000000
            'Electronic Console'
            1209000c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            13.000000000000000000
            'Electronic Console'
            1209000c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            13.000000000000000000
            'Electronic Console'
            1209000c
            1
            True)
          (
            15.000000000000000000
            'Dive Time'
            4.000000000000000000
            'Second Stage Regulator'
            1241000c
            1
            True)
          (
            15.000000000000000000
            'Dive Time'
            4.000000000000000000
            'Second Stage Regulator'
            1241000c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            29.000000000000000000
            'Front Clip Stabilizing Vest'
            1288000c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            29.000000000000000000
            'Front Clip Stabilizing Vest'
            1288000c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            29.000000000000000000
            'Front Clip Stabilizing Vest'
            1288000c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            43.000000000000000000
            '95.1 cu ft Tank'
            1300000c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            43.000000000000000000
            '95.1 cu ft Tank'
            1300000c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            43.000000000000000000
            '95.1 cu ft Tank'
            1300000c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            30.000000000000000000
            'Trim Fit Stabilizing Vest'
            1382500c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            30.000000000000000000
            'Trim Fit Stabilizing Vest'
            1382500c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            30.000000000000000000
            'Trim Fit Stabilizing Vest'
            1382500c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            30.000000000000000000
            'Trim Fit Stabilizing Vest'
            1382500c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            28.000000000000000000
            'Stabilizing Vest'
            1462000c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            28.000000000000000000
            'Stabilizing Vest'
            1462000c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            28.000000000000000000
            'Stabilizing Vest'
            1462000c
            1
            True)
          (
            22.000000000000000000
            'Dive & Surf'
            51.000000000000000000
            'Video Light'
            1475795c
            1
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            51.000000000000000000
            'Video Light'
            1475795c
            1
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            51.000000000000000000
            'Video Light'
            1475795c
            1
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            51.000000000000000000
            'Video Light'
            1475795c
            1
            False)
          (
            4.000000000000000000
            'Scuba Professionals'
            7.000000000000000000
            'Regulator System'
            1548000c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            7.000000000000000000
            'Regulator System'
            1548000c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            7.000000000000000000
            'Regulator System'
            1548000c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            19.000000000000000000
            'Electronic Console w/ options'
            1890000c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            19.000000000000000000
            'Electronic Console w/ options'
            1890000c
            1
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            19.000000000000000000
            'Electronic Console w/ options'
            1890000c
            1
            True)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            52.000000000000000000
            'Boat Towable Metal Detector'
            2036600c
            1
            False)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            52.000000000000000000
            'Boat Towable Metal Detector'
            2036600c
            1
            False)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            52.000000000000000000
            'Boat Towable Metal Detector'
            2036600c
            1
            False)
          (
            21.000000000000000000
            'Dive Canada'
            27.000000000000000000
            'Dive Computer'
            2535000c
            1
            True)
          (
            21.000000000000000000
            'Dive Canada'
            27.000000000000000000
            'Dive Computer'
            2535000c
            1
            True)
          (
            21.000000000000000000
            'Dive Canada'
            27.000000000000000000
            'Dive Computer'
            2535000c
            1
            True)
          (
            21.000000000000000000
            'Dive Canada'
            27.000000000000000000
            'Dive Computer'
            2535000c
            1
            True)
          (
            21.000000000000000000
            'Dive Canada'
            27.000000000000000000
            'Dive Computer'
            2535000c
            1
            True)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            53.000000000000000000
            'Boat Towable Metal Detector'
            3160500c
            1
            False)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            53.000000000000000000
            'Boat Towable Metal Detector'
            3160500c
            1
            False)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            53.000000000000000000
            'Boat Towable Metal Detector'
            3160500c
            1
            False)
          (
            6.000000000000000000
            'Techniques'
            2.000000000000000000
            'Underwater Diver Vehicle'
            5040000c
            1
            False)
          (
            6.000000000000000000
            'Techniques'
            2.000000000000000000
            'Underwater Diver Vehicle'
            5040000c
            1
            False)
          (
            6.000000000000000000
            'Techniques'
            2.000000000000000000
            'Underwater Diver Vehicle'
            5040000c
            1
            False)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            46.000000000000000000
            'Remotely Operated Video System'
            7107000c
            1
            False)
          (
            10.000000000000000000
            'Aqua Research Corp.'
            48.000000000000000000
            'Towable Video Camera (B&W)'
            8595700c
            1
            True)
          (
            10.000000000000000000
            'Aqua Research Corp.'
            48.000000000000000000
            'Towable Video Camera (B&W)'
            8595700c
            1
            True)
          (
            10.000000000000000000
            'Aqua Research Corp.'
            48.000000000000000000
            'Towable Video Camera (B&W)'
            8595700c
            1
            True)
          (
            10.000000000000000000
            'Aqua Research Corp.'
            48.000000000000000000
            'Towable Video Camera (B&W)'
            8595700c
            1
            True)
          (
            22.000000000000000000
            'Dive & Surf'
            47.000000000000000000
            'Marine Super VHS Video Package'
            11241000c
            1
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            47.000000000000000000
            'Marine Super VHS Video Package'
            11241000c
            1
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            47.000000000000000000
            'Marine Super VHS Video Package'
            11241000c
            1
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            47.000000000000000000
            'Marine Super VHS Video Package'
            11241000c
            1
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            47.000000000000000000
            'Marine Super VHS Video Package'
            11241000c
            1
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            47.000000000000000000
            'Marine Super VHS Video Package'
            11241000c
            1
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            47.000000000000000000
            'Marine Super VHS Video Package'
            11241000c
            1
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            47.000000000000000000
            'Marine Super VHS Video Package'
            11241000c
            1
            False)
          (
            6.000000000000000000
            'Techniques'
            1.000000000000000000
            'Dive kayak'
            13567500c
            1
            False)
          (
            6.000000000000000000
            'Techniques'
            1.000000000000000000
            'Dive kayak'
            13567500c
            1
            False)
          (
            6.000000000000000000
            'Techniques'
            1.000000000000000000
            'Dive kayak'
            13567500c
            1
            False)
          (
            6.000000000000000000
            'Techniques'
            1.000000000000000000
            'Dive kayak'
            13567500c
            1
            False)
          (
            1.000000000000000000
            'Cacor Corporation'
            26.000000000000000000
            'Wrist Band Thermometer (C)'
            64800c
            2
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            23.000000000000000000
            'Wrist Band Thermometer (F)'
            79200c
            2
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            23.000000000000000000
            'Wrist Band Thermometer (F)'
            79200c
            2
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            23.000000000000000000
            'Wrist Band Thermometer (F)'
            79200c
            2
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            22.000000000000000000
            'Navigation Compass'
            91770c
            2
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            22.000000000000000000
            'Navigation Compass'
            91770c
            2
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            22.000000000000000000
            'Navigation Compass'
            91770c
            2
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            22.000000000000000000
            'Navigation Compass'
            91770c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            16.000000000000000000
            'Compass Console Mount'
            101500c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            16.000000000000000000
            'Compass Console Mount'
            101500c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            16.000000000000000000
            'Compass Console Mount'
            101500c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            16.000000000000000000
            'Compass Console Mount'
            101500c
            2
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            20.000000000000000000
            'Direct Sighting Compass'
            125820c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            32.000000000000000000
            'Safety Knife'
            131200c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            32.000000000000000000
            'Safety Knife'
            131200c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            32.000000000000000000
            'Safety Knife'
            131200c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            32.000000000000000000
            'Safety Knife'
            131200c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            32.000000000000000000
            'Safety Knife'
            131200c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            34.000000000000000000
            'Chisel Point Knife'
            143500c
            2
            True)
          (
            22.000000000000000000
            'Dive & Surf'
            41.000000000000000000
            'Halogen Flashlight'
            191840c
            2
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            41.000000000000000000
            'Halogen Flashlight'
            191840c
            2
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            41.000000000000000000
            'Halogen Flashlight'
            191840c
            2
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            41.000000000000000000
            'Halogen Flashlight'
            191840c
            2
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            41.000000000000000000
            'Halogen Flashlight'
            191840c
            2
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            39.000000000000000000
            'Krypton Flashlight'
            206770c
            2
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            39.000000000000000000
            'Krypton Flashlight'
            206770c
            2
            False)
          (
            4.000000000000000000
            'Scuba Professionals'
            17.000000000000000000
            'Compass (meter only)'
            249600c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            17.000000000000000000
            'Compass (meter only)'
            249600c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            17.000000000000000000
            'Compass (meter only)'
            249600c
            2
            True)
          (
            15.000000000000000000
            'Dive Time'
            33.000000000000000000
            'Medium Titanium Knife'
            267665c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            37.000000000000000000
            'Divers Knife and Sheath'
            273000c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            37.000000000000000000
            'Divers Knife and Sheath'
            273000c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            37.000000000000000000
            'Divers Knife and Sheath'
            273000c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            37.000000000000000000
            'Divers Knife and Sheath'
            273000c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            35.000000000000000000
            'Flashlight'
            292500c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            35.000000000000000000
            'Flashlight'
            292500c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            36.000000000000000000
            'Medium Stainless Steel Knife'
            343000c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            36.000000000000000000
            'Medium Stainless Steel Knife'
            343000c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            36.000000000000000000
            'Medium Stainless Steel Knife'
            343000c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            38.000000000000000000
            'Large Stainless Steel Knife'
            376000c
            2
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            25.000000000000000000
            'Depth/Pressure Gauge (Analog)'
            392700c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            14.000000000000000000
            'Depth/Pressure Gauge'
            483000c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            14.000000000000000000
            'Depth/Pressure Gauge'
            483000c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            14.000000000000000000
            'Depth/Pressure Gauge'
            483000c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            14.000000000000000000
            'Depth/Pressure Gauge'
            483000c
            2
            True)
          (
            22.000000000000000000
            'Dive & Surf'
            40.000000000000000000
            'Flashlight (Rechargeable)'
            509850c
            2
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            40.000000000000000000
            'Flashlight (Rechargeable)'
            509850c
            2
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            40.000000000000000000
            'Flashlight (Rechargeable)'
            509850c
            2
            False)
          (
            1.000000000000000000
            'Cacor Corporation'
            24.000000000000000000
            'Depth/Pressure Gauge (Digital)'
            536400c
            2
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            24.000000000000000000
            'Depth/Pressure Gauge (Digital)'
            536400c
            2
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            24.000000000000000000
            'Depth/Pressure Gauge (Digital)'
            536400c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            42.000000000000000000
            '60.6 cu ft Tank'
            572800c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            42.000000000000000000
            '60.6 cu ft Tank'
            572800c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            42.000000000000000000
            '60.6 cu ft Tank'
            572800c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            42.000000000000000000
            '60.6 cu ft Tank'
            572800c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            44.000000000000000000
            '71.4 cu ft Tank'
            585000c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            44.000000000000000000
            '71.4 cu ft Tank'
            585000c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            44.000000000000000000
            '71.4 cu ft Tank'
            585000c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            10.000000000000000000
            'First Stage Regulator'
            646000c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            10.000000000000000000
            'First Stage Regulator'
            646000c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            10.000000000000000000
            'First Stage Regulator'
            646000c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            10.000000000000000000
            'First Stage Regulator'
            646000c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            10.000000000000000000
            'First Stage Regulator'
            646000c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            10.000000000000000000
            'First Stage Regulator'
            646000c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            10.000000000000000000
            'First Stage Regulator'
            646000c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            15.000000000000000000
            'Personal Dive Sonar'
            728500c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            15.000000000000000000
            'Personal Dive Sonar'
            728500c
            2
            True)
          (
            21.000000000000000000
            'Dive Canada'
            12.000000000000000000
            'Depth/Pressure Gauge Console'
            733200c
            2
            True)
          (
            21.000000000000000000
            'Dive Canada'
            12.000000000000000000
            'Depth/Pressure Gauge Console'
            733200c
            2
            True)
          (
            21.000000000000000000
            'Dive Canada'
            12.000000000000000000
            'Depth/Pressure Gauge Console'
            733200c
            2
            True)
          (
            21.000000000000000000
            'Dive Canada'
            12.000000000000000000
            'Depth/Pressure Gauge Console'
            733200c
            2
            True)
          (
            21.000000000000000000
            'Dive Canada'
            12.000000000000000000
            'Depth/Pressure Gauge Console'
            733200c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            6.000000000000000000
            'Second Stage Regulator'
            735300c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            6.000000000000000000
            'Second Stage Regulator'
            735300c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            6.000000000000000000
            'Second Stage Regulator'
            735300c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            6.000000000000000000
            'Second Stage Regulator'
            735300c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            6.000000000000000000
            'Second Stage Regulator'
            735300c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            18.000000000000000000
            'Depth/Pressure Gauge'
            762200c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            18.000000000000000000
            'Depth/Pressure Gauge'
            762200c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            18.000000000000000000
            'Depth/Pressure Gauge'
            762200c
            2
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            21.000000000000000000
            'Dive Computer'
            769700c
            2
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            21.000000000000000000
            'Dive Computer'
            769700c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            8.000000000000000000
            'Alternate Inflation Regulator'
            858000c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            8.000000000000000000
            'Alternate Inflation Regulator'
            858000c
            2
            True)
          (
            21.000000000000000000
            'Dive Canada'
            11.000000000000000000
            'Second Stage Regulator'
            957900c
            2
            True)
          (
            21.000000000000000000
            'Dive Canada'
            11.000000000000000000
            'Second Stage Regulator'
            957900c
            2
            True)
          (
            21.000000000000000000
            'Dive Canada'
            11.000000000000000000
            'Second Stage Regulator'
            957900c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            45.000000000000000000
            '75.8 cu ft Tank'
            963500c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            9.000000000000000000
            'Second Stage Regulator'
            999000c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            31.000000000000000000
            'Welded Seam Stabilizing Vest'
            1092000c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            31.000000000000000000
            'Welded Seam Stabilizing Vest'
            1092000c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            31.000000000000000000
            'Welded Seam Stabilizing Vest'
            1092000c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            3.000000000000000000
            'Regulator System'
            1175000c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            3.000000000000000000
            'Regulator System'
            1175000c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            3.000000000000000000
            'Regulator System'
            1175000c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            3.000000000000000000
            'Regulator System'
            1175000c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            5.000000000000000000
            'Regulator System'
            1193500c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            13.000000000000000000
            'Electronic Console'
            1209000c
            2
            True)
          (
            15.000000000000000000
            'Dive Time'
            4.000000000000000000
            'Second Stage Regulator'
            1241000c
            2
            True)
          (
            15.000000000000000000
            'Dive Time'
            4.000000000000000000
            'Second Stage Regulator'
            1241000c
            2
            True)
          (
            15.000000000000000000
            'Dive Time'
            4.000000000000000000
            'Second Stage Regulator'
            1241000c
            2
            True)
          (
            15.000000000000000000
            'Dive Time'
            4.000000000000000000
            'Second Stage Regulator'
            1241000c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            29.000000000000000000
            'Front Clip Stabilizing Vest'
            1288000c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            29.000000000000000000
            'Front Clip Stabilizing Vest'
            1288000c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            29.000000000000000000
            'Front Clip Stabilizing Vest'
            1288000c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            29.000000000000000000
            'Front Clip Stabilizing Vest'
            1288000c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            43.000000000000000000
            '95.1 cu ft Tank'
            1300000c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            43.000000000000000000
            '95.1 cu ft Tank'
            1300000c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            43.000000000000000000
            '95.1 cu ft Tank'
            1300000c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            30.000000000000000000
            'Trim Fit Stabilizing Vest'
            1382500c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            30.000000000000000000
            'Trim Fit Stabilizing Vest'
            1382500c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            30.000000000000000000
            'Trim Fit Stabilizing Vest'
            1382500c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            28.000000000000000000
            'Stabilizing Vest'
            1462000c
            2
            True)
          (
            22.000000000000000000
            'Dive & Surf'
            51.000000000000000000
            'Video Light'
            1475795c
            2
            False)
          (
            4.000000000000000000
            'Scuba Professionals'
            7.000000000000000000
            'Regulator System'
            1548000c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            7.000000000000000000
            'Regulator System'
            1548000c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            7.000000000000000000
            'Regulator System'
            1548000c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            19.000000000000000000
            'Electronic Console w/ options'
            1890000c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            19.000000000000000000
            'Electronic Console w/ options'
            1890000c
            2
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            19.000000000000000000
            'Electronic Console w/ options'
            1890000c
            2
            True)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            52.000000000000000000
            'Boat Towable Metal Detector'
            2036600c
            2
            False)
          (
            21.000000000000000000
            'Dive Canada'
            27.000000000000000000
            'Dive Computer'
            2535000c
            2
            True)
          (
            21.000000000000000000
            'Dive Canada'
            27.000000000000000000
            'Dive Computer'
            2535000c
            2
            True)
          (
            21.000000000000000000
            'Dive Canada'
            27.000000000000000000
            'Dive Computer'
            2535000c
            2
            True)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            53.000000000000000000
            'Boat Towable Metal Detector'
            3160500c
            2
            False)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            53.000000000000000000
            'Boat Towable Metal Detector'
            3160500c
            2
            False)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            53.000000000000000000
            'Boat Towable Metal Detector'
            3160500c
            2
            False)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            53.000000000000000000
            'Boat Towable Metal Detector'
            3160500c
            2
            False)
          (
            6.000000000000000000
            'Techniques'
            2.000000000000000000
            'Underwater Diver Vehicle'
            5040000c
            2
            False)
          (
            6.000000000000000000
            'Techniques'
            2.000000000000000000
            'Underwater Diver Vehicle'
            5040000c
            2
            False)
          (
            6.000000000000000000
            'Techniques'
            2.000000000000000000
            'Underwater Diver Vehicle'
            5040000c
            2
            False)
          (
            6.000000000000000000
            'Techniques'
            2.000000000000000000
            'Underwater Diver Vehicle'
            5040000c
            2
            False)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            46.000000000000000000
            'Remotely Operated Video System'
            7107000c
            2
            False)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            46.000000000000000000
            'Remotely Operated Video System'
            7107000c
            2
            False)
          (
            10.000000000000000000
            'Aqua Research Corp.'
            48.000000000000000000
            'Towable Video Camera (B&W)'
            8595700c
            2
            True)
          (
            22.000000000000000000
            'Dive & Surf'
            47.000000000000000000
            'Marine Super VHS Video Package'
            11241000c
            2
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            47.000000000000000000
            'Marine Super VHS Video Package'
            11241000c
            2
            False)
          (
            6.000000000000000000
            'Techniques'
            1.000000000000000000
            'Dive kayak'
            13567500c
            2
            False)
          (
            6.000000000000000000
            'Techniques'
            1.000000000000000000
            'Dive kayak'
            13567500c
            2
            False)
          (
            6.000000000000000000
            'Techniques'
            1.000000000000000000
            'Dive kayak'
            13567500c
            2
            False)
          (
            10.000000000000000000
            'Aqua Research Corp.'
            49.000000000000000000
            'Towable Video Camera (Color)'
            14845500c
            2
            True)
          (
            10.000000000000000000
            'Aqua Research Corp.'
            49.000000000000000000
            'Towable Video Camera (Color)'
            14845500c
            2
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            26.000000000000000000
            'Wrist Band Thermometer (C)'
            64800c
            3
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            26.000000000000000000
            'Wrist Band Thermometer (C)'
            64800c
            3
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            23.000000000000000000
            'Wrist Band Thermometer (F)'
            79200c
            3
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            23.000000000000000000
            'Wrist Band Thermometer (F)'
            79200c
            3
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            22.000000000000000000
            'Navigation Compass'
            91770c
            3
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            22.000000000000000000
            'Navigation Compass'
            91770c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            16.000000000000000000
            'Compass Console Mount'
            101500c
            3
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            20.000000000000000000
            'Direct Sighting Compass'
            125820c
            3
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            20.000000000000000000
            'Direct Sighting Compass'
            125820c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            32.000000000000000000
            'Safety Knife'
            131200c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            34.000000000000000000
            'Chisel Point Knife'
            143500c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            34.000000000000000000
            'Chisel Point Knife'
            143500c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            34.000000000000000000
            'Chisel Point Knife'
            143500c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            34.000000000000000000
            'Chisel Point Knife'
            143500c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            34.000000000000000000
            'Chisel Point Knife'
            143500c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            34.000000000000000000
            'Chisel Point Knife'
            143500c
            3
            True)
          (
            22.000000000000000000
            'Dive & Surf'
            41.000000000000000000
            'Halogen Flashlight'
            191840c
            3
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            41.000000000000000000
            'Halogen Flashlight'
            191840c
            3
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            41.000000000000000000
            'Halogen Flashlight'
            191840c
            3
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            41.000000000000000000
            'Halogen Flashlight'
            191840c
            3
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            41.000000000000000000
            'Halogen Flashlight'
            191840c
            3
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            41.000000000000000000
            'Halogen Flashlight'
            191840c
            3
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            39.000000000000000000
            'Krypton Flashlight'
            206770c
            3
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            39.000000000000000000
            'Krypton Flashlight'
            206770c
            3
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            39.000000000000000000
            'Krypton Flashlight'
            206770c
            3
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            39.000000000000000000
            'Krypton Flashlight'
            206770c
            3
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            39.000000000000000000
            'Krypton Flashlight'
            206770c
            3
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            39.000000000000000000
            'Krypton Flashlight'
            206770c
            3
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            39.000000000000000000
            'Krypton Flashlight'
            206770c
            3
            False)
          (
            4.000000000000000000
            'Scuba Professionals'
            17.000000000000000000
            'Compass (meter only)'
            249600c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            17.000000000000000000
            'Compass (meter only)'
            249600c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            17.000000000000000000
            'Compass (meter only)'
            249600c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            17.000000000000000000
            'Compass (meter only)'
            249600c
            3
            True)
          (
            15.000000000000000000
            'Dive Time'
            33.000000000000000000
            'Medium Titanium Knife'
            267665c
            3
            True)
          (
            15.000000000000000000
            'Dive Time'
            33.000000000000000000
            'Medium Titanium Knife'
            267665c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            37.000000000000000000
            'Divers Knife and Sheath'
            273000c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            37.000000000000000000
            'Divers Knife and Sheath'
            273000c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            35.000000000000000000
            'Flashlight'
            292500c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            35.000000000000000000
            'Flashlight'
            292500c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            35.000000000000000000
            'Flashlight'
            292500c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            36.000000000000000000
            'Medium Stainless Steel Knife'
            343000c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            36.000000000000000000
            'Medium Stainless Steel Knife'
            343000c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            36.000000000000000000
            'Medium Stainless Steel Knife'
            343000c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            36.000000000000000000
            'Medium Stainless Steel Knife'
            343000c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            38.000000000000000000
            'Large Stainless Steel Knife'
            376000c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            38.000000000000000000
            'Large Stainless Steel Knife'
            376000c
            3
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            25.000000000000000000
            'Depth/Pressure Gauge (Analog)'
            392700c
            3
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            25.000000000000000000
            'Depth/Pressure Gauge (Analog)'
            392700c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            14.000000000000000000
            'Depth/Pressure Gauge'
            483000c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            14.000000000000000000
            'Depth/Pressure Gauge'
            483000c
            3
            True)
          (
            22.000000000000000000
            'Dive & Surf'
            40.000000000000000000
            'Flashlight (Rechargeable)'
            509850c
            3
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            40.000000000000000000
            'Flashlight (Rechargeable)'
            509850c
            3
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            40.000000000000000000
            'Flashlight (Rechargeable)'
            509850c
            3
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            40.000000000000000000
            'Flashlight (Rechargeable)'
            509850c
            3
            False)
          (
            1.000000000000000000
            'Cacor Corporation'
            24.000000000000000000
            'Depth/Pressure Gauge (Digital)'
            536400c
            3
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            24.000000000000000000
            'Depth/Pressure Gauge (Digital)'
            536400c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            42.000000000000000000
            '60.6 cu ft Tank'
            572800c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            42.000000000000000000
            '60.6 cu ft Tank'
            572800c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            42.000000000000000000
            '60.6 cu ft Tank'
            572800c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            42.000000000000000000
            '60.6 cu ft Tank'
            572800c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            44.000000000000000000
            '71.4 cu ft Tank'
            585000c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            10.000000000000000000
            'First Stage Regulator'
            646000c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            10.000000000000000000
            'First Stage Regulator'
            646000c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            10.000000000000000000
            'First Stage Regulator'
            646000c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            10.000000000000000000
            'First Stage Regulator'
            646000c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            15.000000000000000000
            'Personal Dive Sonar'
            728500c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            15.000000000000000000
            'Personal Dive Sonar'
            728500c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            15.000000000000000000
            'Personal Dive Sonar'
            728500c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            15.000000000000000000
            'Personal Dive Sonar'
            728500c
            3
            True)
          (
            21.000000000000000000
            'Dive Canada'
            12.000000000000000000
            'Depth/Pressure Gauge Console'
            733200c
            3
            True)
          (
            21.000000000000000000
            'Dive Canada'
            12.000000000000000000
            'Depth/Pressure Gauge Console'
            733200c
            3
            True)
          (
            21.000000000000000000
            'Dive Canada'
            12.000000000000000000
            'Depth/Pressure Gauge Console'
            733200c
            3
            True)
          (
            21.000000000000000000
            'Dive Canada'
            12.000000000000000000
            'Depth/Pressure Gauge Console'
            733200c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            6.000000000000000000
            'Second Stage Regulator'
            735300c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            6.000000000000000000
            'Second Stage Regulator'
            735300c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            6.000000000000000000
            'Second Stage Regulator'
            735300c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            18.000000000000000000
            'Depth/Pressure Gauge'
            762200c
            3
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            21.000000000000000000
            'Dive Computer'
            769700c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            8.000000000000000000
            'Alternate Inflation Regulator'
            858000c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            8.000000000000000000
            'Alternate Inflation Regulator'
            858000c
            3
            True)
          (
            21.000000000000000000
            'Dive Canada'
            11.000000000000000000
            'Second Stage Regulator'
            957900c
            3
            True)
          (
            21.000000000000000000
            'Dive Canada'
            11.000000000000000000
            'Second Stage Regulator'
            957900c
            3
            True)
          (
            21.000000000000000000
            'Dive Canada'
            11.000000000000000000
            'Second Stage Regulator'
            957900c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            45.000000000000000000
            '75.8 cu ft Tank'
            963500c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            45.000000000000000000
            '75.8 cu ft Tank'
            963500c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            45.000000000000000000
            '75.8 cu ft Tank'
            963500c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            9.000000000000000000
            'Second Stage Regulator'
            999000c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            9.000000000000000000
            'Second Stage Regulator'
            999000c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            9.000000000000000000
            'Second Stage Regulator'
            999000c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            9.000000000000000000
            'Second Stage Regulator'
            999000c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            9.000000000000000000
            'Second Stage Regulator'
            999000c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            9.000000000000000000
            'Second Stage Regulator'
            999000c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            9.000000000000000000
            'Second Stage Regulator'
            999000c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            31.000000000000000000
            'Welded Seam Stabilizing Vest'
            1092000c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            31.000000000000000000
            'Welded Seam Stabilizing Vest'
            1092000c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            31.000000000000000000
            'Welded Seam Stabilizing Vest'
            1092000c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            31.000000000000000000
            'Welded Seam Stabilizing Vest'
            1092000c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            5.000000000000000000
            'Regulator System'
            1193500c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            5.000000000000000000
            'Regulator System'
            1193500c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            5.000000000000000000
            'Regulator System'
            1193500c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            13.000000000000000000
            'Electronic Console'
            1209000c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            13.000000000000000000
            'Electronic Console'
            1209000c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            13.000000000000000000
            'Electronic Console'
            1209000c
            3
            True)
          (
            15.000000000000000000
            'Dive Time'
            4.000000000000000000
            'Second Stage Regulator'
            1241000c
            3
            True)
          (
            15.000000000000000000
            'Dive Time'
            4.000000000000000000
            'Second Stage Regulator'
            1241000c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            29.000000000000000000
            'Front Clip Stabilizing Vest'
            1288000c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            29.000000000000000000
            'Front Clip Stabilizing Vest'
            1288000c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            29.000000000000000000
            'Front Clip Stabilizing Vest'
            1288000c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            29.000000000000000000
            'Front Clip Stabilizing Vest'
            1288000c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            29.000000000000000000
            'Front Clip Stabilizing Vest'
            1288000c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            43.000000000000000000
            '95.1 cu ft Tank'
            1300000c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            30.000000000000000000
            'Trim Fit Stabilizing Vest'
            1382500c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            30.000000000000000000
            'Trim Fit Stabilizing Vest'
            1382500c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            30.000000000000000000
            'Trim Fit Stabilizing Vest'
            1382500c
            3
            True)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            54.000000000000000000
            'Underwater Altimeter'
            1435000c
            3
            False)
          (
            4.000000000000000000
            'Scuba Professionals'
            28.000000000000000000
            'Stabilizing Vest'
            1462000c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            28.000000000000000000
            'Stabilizing Vest'
            1462000c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            28.000000000000000000
            'Stabilizing Vest'
            1462000c
            3
            True)
          (
            22.000000000000000000
            'Dive & Surf'
            51.000000000000000000
            'Video Light'
            1475795c
            3
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            51.000000000000000000
            'Video Light'
            1475795c
            3
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            51.000000000000000000
            'Video Light'
            1475795c
            3
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            51.000000000000000000
            'Video Light'
            1475795c
            3
            False)
          (
            4.000000000000000000
            'Scuba Professionals'
            7.000000000000000000
            'Regulator System'
            1548000c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            7.000000000000000000
            'Regulator System'
            1548000c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            7.000000000000000000
            'Regulator System'
            1548000c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            7.000000000000000000
            'Regulator System'
            1548000c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            7.000000000000000000
            'Regulator System'
            1548000c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            7.000000000000000000
            'Regulator System'
            1548000c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            7.000000000000000000
            'Regulator System'
            1548000c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            7.000000000000000000
            'Regulator System'
            1548000c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            7.000000000000000000
            'Regulator System'
            1548000c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            7.000000000000000000
            'Regulator System'
            1548000c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            19.000000000000000000
            'Electronic Console w/ options'
            1890000c
            3
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            19.000000000000000000
            'Electronic Console w/ options'
            1890000c
            3
            True)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            52.000000000000000000
            'Boat Towable Metal Detector'
            2036600c
            3
            False)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            52.000000000000000000
            'Boat Towable Metal Detector'
            2036600c
            3
            False)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            52.000000000000000000
            'Boat Towable Metal Detector'
            2036600c
            3
            False)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            52.000000000000000000
            'Boat Towable Metal Detector'
            2036600c
            3
            False)
          (
            21.000000000000000000
            'Dive Canada'
            27.000000000000000000
            'Dive Computer'
            2535000c
            3
            True)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            53.000000000000000000
            'Boat Towable Metal Detector'
            3160500c
            3
            False)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            53.000000000000000000
            'Boat Towable Metal Detector'
            3160500c
            3
            False)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            53.000000000000000000
            'Boat Towable Metal Detector'
            3160500c
            3
            False)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            53.000000000000000000
            'Boat Towable Metal Detector'
            3160500c
            3
            False)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            53.000000000000000000
            'Boat Towable Metal Detector'
            3160500c
            3
            False)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            53.000000000000000000
            'Boat Towable Metal Detector'
            3160500c
            3
            False)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            53.000000000000000000
            'Boat Towable Metal Detector'
            3160500c
            3
            False)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            57.000000000000000000
            'Underwater Metal Detector'
            4405100c
            3
            False)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            57.000000000000000000
            'Underwater Metal Detector'
            4405100c
            3
            False)
          (
            6.000000000000000000
            'Techniques'
            2.000000000000000000
            'Underwater Diver Vehicle'
            5040000c
            3
            False)
          (
            6.000000000000000000
            'Techniques'
            2.000000000000000000
            'Underwater Diver Vehicle'
            5040000c
            3
            False)
          (
            6.000000000000000000
            'Techniques'
            2.000000000000000000
            'Underwater Diver Vehicle'
            5040000c
            3
            False)
          (
            6.000000000000000000
            'Techniques'
            2.000000000000000000
            'Underwater Diver Vehicle'
            5040000c
            3
            False)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            56.000000000000000000
            'Marine Magnetometer'
            5455800c
            3
            False)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            46.000000000000000000
            'Remotely Operated Video System'
            7107000c
            3
            False)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            46.000000000000000000
            'Remotely Operated Video System'
            7107000c
            3
            False)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            46.000000000000000000
            'Remotely Operated Video System'
            7107000c
            3
            False)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            46.000000000000000000
            'Remotely Operated Video System'
            7107000c
            3
            False)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            46.000000000000000000
            'Remotely Operated Video System'
            7107000c
            3
            False)
          (
            10.000000000000000000
            'Aqua Research Corp.'
            48.000000000000000000
            'Towable Video Camera (B&W)'
            8595700c
            3
            True)
          (
            10.000000000000000000
            'Aqua Research Corp.'
            48.000000000000000000
            'Towable Video Camera (B&W)'
            8595700c
            3
            True)
          (
            13.000000000000000000
            'Nautical Compressors'
            59.000000000000000000
            'Air Compressor'
            9868500c
            3
            True)
          (
            13.000000000000000000
            'Nautical Compressors'
            59.000000000000000000
            'Air Compressor'
            9868500c
            3
            True)
          (
            22.000000000000000000
            'Dive & Surf'
            47.000000000000000000
            'Marine Super VHS Video Package'
            11241000c
            3
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            47.000000000000000000
            'Marine Super VHS Video Package'
            11241000c
            3
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            47.000000000000000000
            'Marine Super VHS Video Package'
            11241000c
            3
            False)
          (
            6.000000000000000000
            'Techniques'
            1.000000000000000000
            'Dive kayak'
            13567500c
            3
            False)
          (
            10.000000000000000000
            'Aqua Research Corp.'
            49.000000000000000000
            'Towable Video Camera (Color)'
            14845500c
            3
            True)
          (
            10.000000000000000000
            'Aqua Research Corp.'
            49.000000000000000000
            'Towable Video Camera (Color)'
            14845500c
            3
            True)
          (
            10.000000000000000000
            'Aqua Research Corp.'
            49.000000000000000000
            'Towable Video Camera (Color)'
            14845500c
            3
            True)
          (
            10.000000000000000000
            'Aqua Research Corp.'
            49.000000000000000000
            'Towable Video Camera (Color)'
            14845500c
            3
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            26.000000000000000000
            'Wrist Band Thermometer (C)'
            64800c
            4
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            23.000000000000000000
            'Wrist Band Thermometer (F)'
            79200c
            4
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            23.000000000000000000
            'Wrist Band Thermometer (F)'
            79200c
            4
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            23.000000000000000000
            'Wrist Band Thermometer (F)'
            79200c
            4
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            23.000000000000000000
            'Wrist Band Thermometer (F)'
            79200c
            4
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            22.000000000000000000
            'Navigation Compass'
            91770c
            4
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            22.000000000000000000
            'Navigation Compass'
            91770c
            4
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            22.000000000000000000
            'Navigation Compass'
            91770c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            16.000000000000000000
            'Compass Console Mount'
            101500c
            4
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            20.000000000000000000
            'Direct Sighting Compass'
            125820c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            32.000000000000000000
            'Safety Knife'
            131200c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            32.000000000000000000
            'Safety Knife'
            131200c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            32.000000000000000000
            'Safety Knife'
            131200c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            32.000000000000000000
            'Safety Knife'
            131200c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            34.000000000000000000
            'Chisel Point Knife'
            143500c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            34.000000000000000000
            'Chisel Point Knife'
            143500c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            34.000000000000000000
            'Chisel Point Knife'
            143500c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            34.000000000000000000
            'Chisel Point Knife'
            143500c
            4
            True)
          (
            22.000000000000000000
            'Dive & Surf'
            41.000000000000000000
            'Halogen Flashlight'
            191840c
            4
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            41.000000000000000000
            'Halogen Flashlight'
            191840c
            4
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            39.000000000000000000
            'Krypton Flashlight'
            206770c
            4
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            39.000000000000000000
            'Krypton Flashlight'
            206770c
            4
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            39.000000000000000000
            'Krypton Flashlight'
            206770c
            4
            False)
          (
            4.000000000000000000
            'Scuba Professionals'
            17.000000000000000000
            'Compass (meter only)'
            249600c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            17.000000000000000000
            'Compass (meter only)'
            249600c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            17.000000000000000000
            'Compass (meter only)'
            249600c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            17.000000000000000000
            'Compass (meter only)'
            249600c
            4
            True)
          (
            15.000000000000000000
            'Dive Time'
            33.000000000000000000
            'Medium Titanium Knife'
            267665c
            4
            True)
          (
            15.000000000000000000
            'Dive Time'
            33.000000000000000000
            'Medium Titanium Knife'
            267665c
            4
            True)
          (
            15.000000000000000000
            'Dive Time'
            33.000000000000000000
            'Medium Titanium Knife'
            267665c
            4
            True)
          (
            15.000000000000000000
            'Dive Time'
            33.000000000000000000
            'Medium Titanium Knife'
            267665c
            4
            True)
          (
            15.000000000000000000
            'Dive Time'
            33.000000000000000000
            'Medium Titanium Knife'
            267665c
            4
            True)
          (
            15.000000000000000000
            'Dive Time'
            33.000000000000000000
            'Medium Titanium Knife'
            267665c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            37.000000000000000000
            'Divers Knife and Sheath'
            273000c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            37.000000000000000000
            'Divers Knife and Sheath'
            273000c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            37.000000000000000000
            'Divers Knife and Sheath'
            273000c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            35.000000000000000000
            'Flashlight'
            292500c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            35.000000000000000000
            'Flashlight'
            292500c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            35.000000000000000000
            'Flashlight'
            292500c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            36.000000000000000000
            'Medium Stainless Steel Knife'
            343000c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            36.000000000000000000
            'Medium Stainless Steel Knife'
            343000c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            36.000000000000000000
            'Medium Stainless Steel Knife'
            343000c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            36.000000000000000000
            'Medium Stainless Steel Knife'
            343000c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            38.000000000000000000
            'Large Stainless Steel Knife'
            376000c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            38.000000000000000000
            'Large Stainless Steel Knife'
            376000c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            38.000000000000000000
            'Large Stainless Steel Knife'
            376000c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            38.000000000000000000
            'Large Stainless Steel Knife'
            376000c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            38.000000000000000000
            'Large Stainless Steel Knife'
            376000c
            4
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            25.000000000000000000
            'Depth/Pressure Gauge (Analog)'
            392700c
            4
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            25.000000000000000000
            'Depth/Pressure Gauge (Analog)'
            392700c
            4
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            25.000000000000000000
            'Depth/Pressure Gauge (Analog)'
            392700c
            4
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            25.000000000000000000
            'Depth/Pressure Gauge (Analog)'
            392700c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            14.000000000000000000
            'Depth/Pressure Gauge'
            483000c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            14.000000000000000000
            'Depth/Pressure Gauge'
            483000c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            14.000000000000000000
            'Depth/Pressure Gauge'
            483000c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            14.000000000000000000
            'Depth/Pressure Gauge'
            483000c
            4
            True)
          (
            22.000000000000000000
            'Dive & Surf'
            40.000000000000000000
            'Flashlight (Rechargeable)'
            509850c
            4
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            40.000000000000000000
            'Flashlight (Rechargeable)'
            509850c
            4
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            40.000000000000000000
            'Flashlight (Rechargeable)'
            509850c
            4
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            50.000000000000000000
            'Camera and Case'
            527780c
            4
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            50.000000000000000000
            'Camera and Case'
            527780c
            4
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            50.000000000000000000
            'Camera and Case'
            527780c
            4
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            50.000000000000000000
            'Camera and Case'
            527780c
            4
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            50.000000000000000000
            'Camera and Case'
            527780c
            4
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            50.000000000000000000
            'Camera and Case'
            527780c
            4
            False)
          (
            1.000000000000000000
            'Cacor Corporation'
            24.000000000000000000
            'Depth/Pressure Gauge (Digital)'
            536400c
            4
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            24.000000000000000000
            'Depth/Pressure Gauge (Digital)'
            536400c
            4
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            24.000000000000000000
            'Depth/Pressure Gauge (Digital)'
            536400c
            4
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            24.000000000000000000
            'Depth/Pressure Gauge (Digital)'
            536400c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            42.000000000000000000
            '60.6 cu ft Tank'
            572800c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            42.000000000000000000
            '60.6 cu ft Tank'
            572800c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            42.000000000000000000
            '60.6 cu ft Tank'
            572800c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            42.000000000000000000
            '60.6 cu ft Tank'
            572800c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            42.000000000000000000
            '60.6 cu ft Tank'
            572800c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            42.000000000000000000
            '60.6 cu ft Tank'
            572800c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            42.000000000000000000
            '60.6 cu ft Tank'
            572800c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            44.000000000000000000
            '71.4 cu ft Tank'
            585000c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            44.000000000000000000
            '71.4 cu ft Tank'
            585000c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            44.000000000000000000
            '71.4 cu ft Tank'
            585000c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            10.000000000000000000
            'First Stage Regulator'
            646000c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            10.000000000000000000
            'First Stage Regulator'
            646000c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            10.000000000000000000
            'First Stage Regulator'
            646000c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            10.000000000000000000
            'First Stage Regulator'
            646000c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            10.000000000000000000
            'First Stage Regulator'
            646000c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            15.000000000000000000
            'Personal Dive Sonar'
            728500c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            15.000000000000000000
            'Personal Dive Sonar'
            728500c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            15.000000000000000000
            'Personal Dive Sonar'
            728500c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            15.000000000000000000
            'Personal Dive Sonar'
            728500c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            15.000000000000000000
            'Personal Dive Sonar'
            728500c
            4
            True)
          (
            21.000000000000000000
            'Dive Canada'
            12.000000000000000000
            'Depth/Pressure Gauge Console'
            733200c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            6.000000000000000000
            'Second Stage Regulator'
            735300c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            6.000000000000000000
            'Second Stage Regulator'
            735300c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            18.000000000000000000
            'Depth/Pressure Gauge'
            762200c
            4
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            21.000000000000000000
            'Dive Computer'
            769700c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            8.000000000000000000
            'Alternate Inflation Regulator'
            858000c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            8.000000000000000000
            'Alternate Inflation Regulator'
            858000c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            8.000000000000000000
            'Alternate Inflation Regulator'
            858000c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            8.000000000000000000
            'Alternate Inflation Regulator'
            858000c
            4
            True)
          (
            21.000000000000000000
            'Dive Canada'
            11.000000000000000000
            'Second Stage Regulator'
            957900c
            4
            True)
          (
            21.000000000000000000
            'Dive Canada'
            11.000000000000000000
            'Second Stage Regulator'
            957900c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            45.000000000000000000
            '75.8 cu ft Tank'
            963500c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            45.000000000000000000
            '75.8 cu ft Tank'
            963500c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            9.000000000000000000
            'Second Stage Regulator'
            999000c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            9.000000000000000000
            'Second Stage Regulator'
            999000c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            9.000000000000000000
            'Second Stage Regulator'
            999000c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            31.000000000000000000
            'Welded Seam Stabilizing Vest'
            1092000c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            31.000000000000000000
            'Welded Seam Stabilizing Vest'
            1092000c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            3.000000000000000000
            'Regulator System'
            1175000c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            3.000000000000000000
            'Regulator System'
            1175000c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            3.000000000000000000
            'Regulator System'
            1175000c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            5.000000000000000000
            'Regulator System'
            1193500c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            5.000000000000000000
            'Regulator System'
            1193500c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            5.000000000000000000
            'Regulator System'
            1193500c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            13.000000000000000000
            'Electronic Console'
            1209000c
            4
            True)
          (
            15.000000000000000000
            'Dive Time'
            4.000000000000000000
            'Second Stage Regulator'
            1241000c
            4
            True)
          (
            15.000000000000000000
            'Dive Time'
            4.000000000000000000
            'Second Stage Regulator'
            1241000c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            29.000000000000000000
            'Front Clip Stabilizing Vest'
            1288000c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            29.000000000000000000
            'Front Clip Stabilizing Vest'
            1288000c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            43.000000000000000000
            '95.1 cu ft Tank'
            1300000c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            43.000000000000000000
            '95.1 cu ft Tank'
            1300000c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            43.000000000000000000
            '95.1 cu ft Tank'
            1300000c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            30.000000000000000000
            'Trim Fit Stabilizing Vest'
            1382500c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            30.000000000000000000
            'Trim Fit Stabilizing Vest'
            1382500c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            30.000000000000000000
            'Trim Fit Stabilizing Vest'
            1382500c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            28.000000000000000000
            'Stabilizing Vest'
            1462000c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            28.000000000000000000
            'Stabilizing Vest'
            1462000c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            28.000000000000000000
            'Stabilizing Vest'
            1462000c
            4
            True)
          (
            22.000000000000000000
            'Dive & Surf'
            51.000000000000000000
            'Video Light'
            1475795c
            4
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            51.000000000000000000
            'Video Light'
            1475795c
            4
            False)
          (
            4.000000000000000000
            'Scuba Professionals'
            7.000000000000000000
            'Regulator System'
            1548000c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            7.000000000000000000
            'Regulator System'
            1548000c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            7.000000000000000000
            'Regulator System'
            1548000c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            7.000000000000000000
            'Regulator System'
            1548000c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            19.000000000000000000
            'Electronic Console w/ options'
            1890000c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            19.000000000000000000
            'Electronic Console w/ options'
            1890000c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            19.000000000000000000
            'Electronic Console w/ options'
            1890000c
            4
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            19.000000000000000000
            'Electronic Console w/ options'
            1890000c
            4
            True)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            52.000000000000000000
            'Boat Towable Metal Detector'
            2036600c
            4
            False)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            52.000000000000000000
            'Boat Towable Metal Detector'
            2036600c
            4
            False)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            52.000000000000000000
            'Boat Towable Metal Detector'
            2036600c
            4
            False)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            52.000000000000000000
            'Boat Towable Metal Detector'
            2036600c
            4
            False)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            52.000000000000000000
            'Boat Towable Metal Detector'
            2036600c
            4
            False)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            52.000000000000000000
            'Boat Towable Metal Detector'
            2036600c
            4
            False)
          (
            21.000000000000000000
            'Dive Canada'
            27.000000000000000000
            'Dive Computer'
            2535000c
            4
            True)
          (
            21.000000000000000000
            'Dive Canada'
            27.000000000000000000
            'Dive Computer'
            2535000c
            4
            True)
          (
            21.000000000000000000
            'Dive Canada'
            27.000000000000000000
            'Dive Computer'
            2535000c
            4
            True)
          (
            21.000000000000000000
            'Dive Canada'
            27.000000000000000000
            'Dive Computer'
            2535000c
            4
            True)
          (
            21.000000000000000000
            'Dive Canada'
            27.000000000000000000
            'Dive Computer'
            2535000c
            4
            True)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            53.000000000000000000
            'Boat Towable Metal Detector'
            3160500c
            4
            False)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            57.000000000000000000
            'Underwater Metal Detector'
            4405100c
            4
            False)
          (
            6.000000000000000000
            'Techniques'
            2.000000000000000000
            'Underwater Diver Vehicle'
            5040000c
            4
            False)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            56.000000000000000000
            'Marine Magnetometer'
            5455800c
            4
            False)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            46.000000000000000000
            'Remotely Operated Video System'
            7107000c
            4
            False)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            46.000000000000000000
            'Remotely Operated Video System'
            7107000c
            4
            False)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            46.000000000000000000
            'Remotely Operated Video System'
            7107000c
            4
            False)
          (
            10.000000000000000000
            'Aqua Research Corp.'
            48.000000000000000000
            'Towable Video Camera (B&W)'
            8595700c
            4
            True)
          (
            10.000000000000000000
            'Aqua Research Corp.'
            48.000000000000000000
            'Towable Video Camera (B&W)'
            8595700c
            4
            True)
          (
            22.000000000000000000
            'Dive & Surf'
            47.000000000000000000
            'Marine Super VHS Video Package'
            11241000c
            4
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            47.000000000000000000
            'Marine Super VHS Video Package'
            11241000c
            4
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            47.000000000000000000
            'Marine Super VHS Video Package'
            11241000c
            4
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            47.000000000000000000
            'Marine Super VHS Video Package'
            11241000c
            4
            False)
          (
            6.000000000000000000
            'Techniques'
            1.000000000000000000
            'Dive kayak'
            13567500c
            4
            False)
          (
            6.000000000000000000
            'Techniques'
            1.000000000000000000
            'Dive kayak'
            13567500c
            4
            False)
          (
            6.000000000000000000
            'Techniques'
            1.000000000000000000
            'Dive kayak'
            13567500c
            4
            False)
          (
            6.000000000000000000
            'Techniques'
            1.000000000000000000
            'Dive kayak'
            13567500c
            4
            False)
          (
            10.000000000000000000
            'Aqua Research Corp.'
            49.000000000000000000
            'Towable Video Camera (Color)'
            14845500c
            4
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            22.000000000000000000
            'Navigation Compass'
            91770c
            5
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            16.000000000000000000
            'Compass Console Mount'
            101500c
            5
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            16.000000000000000000
            'Compass Console Mount'
            101500c
            5
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            32.000000000000000000
            'Safety Knife'
            131200c
            5
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            34.000000000000000000
            'Chisel Point Knife'
            143500c
            5
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            34.000000000000000000
            'Chisel Point Knife'
            143500c
            5
            True)
          (
            15.000000000000000000
            'Dive Time'
            33.000000000000000000
            'Medium Titanium Knife'
            267665c
            5
            True)
          (
            15.000000000000000000
            'Dive Time'
            33.000000000000000000
            'Medium Titanium Knife'
            267665c
            5
            True)
          (
            15.000000000000000000
            'Dive Time'
            33.000000000000000000
            'Medium Titanium Knife'
            267665c
            5
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            35.000000000000000000
            'Flashlight'
            292500c
            5
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            45.000000000000000000
            '75.8 cu ft Tank'
            963500c
            5
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            31.000000000000000000
            'Welded Seam Stabilizing Vest'
            1092000c
            5
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            31.000000000000000000
            'Welded Seam Stabilizing Vest'
            1092000c
            5
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            3.000000000000000000
            'Regulator System'
            1175000c
            5
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            3.000000000000000000
            'Regulator System'
            1175000c
            5
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            30.000000000000000000
            'Trim Fit Stabilizing Vest'
            1382500c
            5
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            28.000000000000000000
            'Stabilizing Vest'
            1462000c
            5
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            28.000000000000000000
            'Stabilizing Vest'
            1462000c
            5
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            28.000000000000000000
            'Stabilizing Vest'
            1462000c
            5
            True)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            52.000000000000000000
            'Boat Towable Metal Detector'
            2036600c
            5
            False)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            55.000000000000000000
            'Sonar System'
            2151100c
            5
            False)
          (
            21.000000000000000000
            'Dive Canada'
            27.000000000000000000
            'Dive Computer'
            2535000c
            5
            True)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            57.000000000000000000
            'Underwater Metal Detector'
            4405100c
            5
            False)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            56.000000000000000000
            'Marine Magnetometer'
            5455800c
            5
            False)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            46.000000000000000000
            'Remotely Operated Video System'
            7107000c
            5
            False)
          (
            10.000000000000000000
            'Aqua Research Corp.'
            48.000000000000000000
            'Towable Video Camera (B&W)'
            8595700c
            5
            True)
          (
            10.000000000000000000
            'Aqua Research Corp.'
            48.000000000000000000
            'Towable Video Camera (B&W)'
            8595700c
            5
            True)
          (
            13.000000000000000000
            'Nautical Compressors'
            59.000000000000000000
            'Air Compressor'
            9868500c
            5
            True)
          (
            22.000000000000000000
            'Dive & Surf'
            47.000000000000000000
            'Marine Super VHS Video Package'
            11241000c
            5
            False)
          (
            10.000000000000000000
            'Aqua Research Corp.'
            49.000000000000000000
            'Towable Video Camera (Color)'
            14845500c
            5
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            32.000000000000000000
            'Safety Knife'
            131200c
            6
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            32.000000000000000000
            'Safety Knife'
            131200c
            6
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            34.000000000000000000
            'Chisel Point Knife'
            143500c
            6
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            34.000000000000000000
            'Chisel Point Knife'
            143500c
            6
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            17.000000000000000000
            'Compass (meter only)'
            249600c
            6
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            17.000000000000000000
            'Compass (meter only)'
            249600c
            6
            True)
          (
            15.000000000000000000
            'Dive Time'
            33.000000000000000000
            'Medium Titanium Knife'
            267665c
            6
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            37.000000000000000000
            'Divers Knife and Sheath'
            273000c
            6
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            36.000000000000000000
            'Medium Stainless Steel Knife'
            343000c
            6
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            25.000000000000000000
            'Depth/Pressure Gauge (Analog)'
            392700c
            6
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            14.000000000000000000
            'Depth/Pressure Gauge'
            483000c
            6
            True)
          (
            22.000000000000000000
            'Dive & Surf'
            50.000000000000000000
            'Camera and Case'
            527780c
            6
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            50.000000000000000000
            'Camera and Case'
            527780c
            6
            False)
          (
            1.000000000000000000
            'Cacor Corporation'
            24.000000000000000000
            'Depth/Pressure Gauge (Digital)'
            536400c
            6
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            44.000000000000000000
            '71.4 cu ft Tank'
            585000c
            6
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            18.000000000000000000
            'Depth/Pressure Gauge'
            762200c
            6
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            21.000000000000000000
            'Dive Computer'
            769700c
            6
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            9.000000000000000000
            'Second Stage Regulator'
            999000c
            6
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            31.000000000000000000
            'Welded Seam Stabilizing Vest'
            1092000c
            6
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            5.000000000000000000
            'Regulator System'
            1193500c
            6
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            30.000000000000000000
            'Trim Fit Stabilizing Vest'
            1382500c
            6
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            28.000000000000000000
            'Stabilizing Vest'
            1462000c
            6
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            28.000000000000000000
            'Stabilizing Vest'
            1462000c
            6
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            28.000000000000000000
            'Stabilizing Vest'
            1462000c
            6
            True)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            52.000000000000000000
            'Boat Towable Metal Detector'
            2036600c
            6
            False)
          (
            21.000000000000000000
            'Dive Canada'
            27.000000000000000000
            'Dive Computer'
            2535000c
            6
            True)
          (
            21.000000000000000000
            'Dive Canada'
            27.000000000000000000
            'Dive Computer'
            2535000c
            6
            True)
          (
            21.000000000000000000
            'Dive Canada'
            27.000000000000000000
            'Dive Computer'
            2535000c
            6
            True)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            58.000000000000000000
            'Underwater Metal Detector'
            3383000c
            6
            False)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            56.000000000000000000
            'Marine Magnetometer'
            5455800c
            6
            False)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            46.000000000000000000
            'Remotely Operated Video System'
            7107000c
            6
            False)
          (
            10.000000000000000000
            'Aqua Research Corp.'
            48.000000000000000000
            'Towable Video Camera (B&W)'
            8595700c
            6
            True)
          (
            13.000000000000000000
            'Nautical Compressors'
            59.000000000000000000
            'Air Compressor'
            9868500c
            6
            True)
          (
            13.000000000000000000
            'Nautical Compressors'
            59.000000000000000000
            'Air Compressor'
            9868500c
            6
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            32.000000000000000000
            'Safety Knife'
            131200c
            7
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            32.000000000000000000
            'Safety Knife'
            131200c
            7
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            32.000000000000000000
            'Safety Knife'
            131200c
            7
            True)
          (
            15.000000000000000000
            'Dive Time'
            33.000000000000000000
            'Medium Titanium Knife'
            267665c
            7
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            35.000000000000000000
            'Flashlight'
            292500c
            7
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            38.000000000000000000
            'Large Stainless Steel Knife'
            376000c
            7
            True)
          (
            22.000000000000000000
            'Dive & Surf'
            50.000000000000000000
            'Camera and Case'
            527780c
            7
            False)
          (
            4.000000000000000000
            'Scuba Professionals'
            6.000000000000000000
            'Second Stage Regulator'
            735300c
            7
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            31.000000000000000000
            'Welded Seam Stabilizing Vest'
            1092000c
            7
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            30.000000000000000000
            'Trim Fit Stabilizing Vest'
            1382500c
            7
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            30.000000000000000000
            'Trim Fit Stabilizing Vest'
            1382500c
            7
            True)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            52.000000000000000000
            'Boat Towable Metal Detector'
            2036600c
            7
            False)
          (
            21.000000000000000000
            'Dive Canada'
            27.000000000000000000
            'Dive Computer'
            2535000c
            7
            True)
          (
            21.000000000000000000
            'Dive Canada'
            27.000000000000000000
            'Dive Computer'
            2535000c
            7
            True)
          (
            21.000000000000000000
            'Dive Canada'
            27.000000000000000000
            'Dive Computer'
            2535000c
            7
            True)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            58.000000000000000000
            'Underwater Metal Detector'
            3383000c
            7
            False)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            46.000000000000000000
            'Remotely Operated Video System'
            7107000c
            7
            False)
          (
            10.000000000000000000
            'Aqua Research Corp.'
            48.000000000000000000
            'Towable Video Camera (B&W)'
            8595700c
            7
            True)
          (
            10.000000000000000000
            'Aqua Research Corp.'
            48.000000000000000000
            'Towable Video Camera (B&W)'
            8595700c
            7
            True)
          (
            22.000000000000000000
            'Dive & Surf'
            47.000000000000000000
            'Marine Super VHS Video Package'
            11241000c
            7
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            47.000000000000000000
            'Marine Super VHS Video Package'
            11241000c
            7
            False)
          (
            6.000000000000000000
            'Techniques'
            1.000000000000000000
            'Dive kayak'
            13567500c
            7
            False)
          (
            4.000000000000000000
            'Scuba Professionals'
            32.000000000000000000
            'Safety Knife'
            131200c
            8
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            34.000000000000000000
            'Chisel Point Knife'
            143500c
            8
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            17.000000000000000000
            'Compass (meter only)'
            249600c
            8
            True)
          (
            15.000000000000000000
            'Dive Time'
            33.000000000000000000
            'Medium Titanium Knife'
            267665c
            8
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            35.000000000000000000
            'Flashlight'
            292500c
            8
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            35.000000000000000000
            'Flashlight'
            292500c
            8
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            36.000000000000000000
            'Medium Stainless Steel Knife'
            343000c
            8
            True)
          (
            22.000000000000000000
            'Dive & Surf'
            40.000000000000000000
            'Flashlight (Rechargeable)'
            509850c
            8
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            50.000000000000000000
            'Camera and Case'
            527780c
            8
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            50.000000000000000000
            'Camera and Case'
            527780c
            8
            False)
          (
            4.000000000000000000
            'Scuba Professionals'
            31.000000000000000000
            'Welded Seam Stabilizing Vest'
            1092000c
            8
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            28.000000000000000000
            'Stabilizing Vest'
            1462000c
            8
            True)
          (
            22.000000000000000000
            'Dive & Surf'
            51.000000000000000000
            'Video Light'
            1475795c
            8
            False)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            52.000000000000000000
            'Boat Towable Metal Detector'
            2036600c
            8
            False)
          (
            21.000000000000000000
            'Dive Canada'
            27.000000000000000000
            'Dive Computer'
            2535000c
            8
            True)
          (
            21.000000000000000000
            'Dive Canada'
            27.000000000000000000
            'Dive Computer'
            2535000c
            8
            True)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            46.000000000000000000
            'Remotely Operated Video System'
            7107000c
            8
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            47.000000000000000000
            'Marine Super VHS Video Package'
            11241000c
            8
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            47.000000000000000000
            'Marine Super VHS Video Package'
            11241000c
            8
            False)
          (
            6.000000000000000000
            'Techniques'
            1.000000000000000000
            'Dive kayak'
            13567500c
            8
            False)
          (
            6.000000000000000000
            'Techniques'
            1.000000000000000000
            'Dive kayak'
            13567500c
            8
            False)
          (
            6.000000000000000000
            'Techniques'
            1.000000000000000000
            'Dive kayak'
            13567500c
            8
            False)
          (
            1.000000000000000000
            'Cacor Corporation'
            26.000000000000000000
            'Wrist Band Thermometer (C)'
            64800c
            9
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            23.000000000000000000
            'Wrist Band Thermometer (F)'
            79200c
            9
            True)
          (
            22.000000000000000000
            'Dive & Surf'
            39.000000000000000000
            'Krypton Flashlight'
            206770c
            9
            False)
          (
            4.000000000000000000
            'Scuba Professionals'
            14.000000000000000000
            'Depth/Pressure Gauge'
            483000c
            9
            True)
          (
            22.000000000000000000
            'Dive & Surf'
            50.000000000000000000
            'Camera and Case'
            527780c
            9
            False)
          (
            4.000000000000000000
            'Scuba Professionals'
            42.000000000000000000
            '60.6 cu ft Tank'
            572800c
            9
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            6.000000000000000000
            'Second Stage Regulator'
            735300c
            9
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            19.000000000000000000
            'Electronic Console w/ options'
            1890000c
            9
            True)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            46.000000000000000000
            'Remotely Operated Video System'
            7107000c
            9
            False)
          (
            10.000000000000000000
            'Aqua Research Corp.'
            48.000000000000000000
            'Towable Video Camera (B&W)'
            8595700c
            9
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            34.000000000000000000
            'Chisel Point Knife'
            143500c
            10
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            34.000000000000000000
            'Chisel Point Knife'
            143500c
            10
            True)
          (
            22.000000000000000000
            'Dive & Surf'
            40.000000000000000000
            'Flashlight (Rechargeable)'
            509850c
            10
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            50.000000000000000000
            'Camera and Case'
            527780c
            10
            False)
          (
            1.000000000000000000
            'Cacor Corporation'
            21.000000000000000000
            'Dive Computer'
            769700c
            10
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            8.000000000000000000
            'Alternate Inflation Regulator'
            858000c
            10
            True)
          (
            21.000000000000000000
            'Dive Canada'
            11.000000000000000000
            'Second Stage Regulator'
            957900c
            10
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            3.000000000000000000
            'Regulator System'
            1175000c
            10
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            3.000000000000000000
            'Regulator System'
            1175000c
            10
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            3.000000000000000000
            'Regulator System'
            1175000c
            10
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            5.000000000000000000
            'Regulator System'
            1193500c
            10
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            13.000000000000000000
            'Electronic Console'
            1209000c
            10
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            29.000000000000000000
            'Front Clip Stabilizing Vest'
            1288000c
            10
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            30.000000000000000000
            'Trim Fit Stabilizing Vest'
            1382500c
            10
            True)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            52.000000000000000000
            'Boat Towable Metal Detector'
            2036600c
            10
            False)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            55.000000000000000000
            'Sonar System'
            2151100c
            10
            False)
          (
            10.000000000000000000
            'Aqua Research Corp.'
            48.000000000000000000
            'Towable Video Camera (B&W)'
            8595700c
            10
            True)
          (
            6.000000000000000000
            'Techniques'
            1.000000000000000000
            'Dive kayak'
            13567500c
            10
            False)
          (
            4.000000000000000000
            'Scuba Professionals'
            32.000000000000000000
            'Safety Knife'
            131200c
            11
            True)
          (
            22.000000000000000000
            'Dive & Surf'
            39.000000000000000000
            'Krypton Flashlight'
            206770c
            11
            False)
          (
            1.000000000000000000
            'Cacor Corporation'
            21.000000000000000000
            'Dive Computer'
            769700c
            11
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            8.000000000000000000
            'Alternate Inflation Regulator'
            858000c
            11
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            9.000000000000000000
            'Second Stage Regulator'
            999000c
            11
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            9.000000000000000000
            'Second Stage Regulator'
            999000c
            11
            True)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            52.000000000000000000
            'Boat Towable Metal Detector'
            2036600c
            11
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            41.000000000000000000
            'Halogen Flashlight'
            191840c
            12
            False)
          (
            4.000000000000000000
            'Scuba Professionals'
            36.000000000000000000
            'Medium Stainless Steel Knife'
            343000c
            12
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            42.000000000000000000
            '60.6 cu ft Tank'
            572800c
            12
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            29.000000000000000000
            'Front Clip Stabilizing Vest'
            1288000c
            12
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            43.000000000000000000
            '95.1 cu ft Tank'
            1300000c
            12
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            43.000000000000000000
            '95.1 cu ft Tank'
            1300000c
            12
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            30.000000000000000000
            'Trim Fit Stabilizing Vest'
            1382500c
            12
            True)
          (
            22.000000000000000000
            'Dive & Surf'
            47.000000000000000000
            'Marine Super VHS Video Package'
            11241000c
            12
            False)
          (
            1.000000000000000000
            'Cacor Corporation'
            23.000000000000000000
            'Wrist Band Thermometer (F)'
            79200c
            13
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            38.000000000000000000
            'Large Stainless Steel Knife'
            376000c
            13
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            14.000000000000000000
            'Depth/Pressure Gauge'
            483000c
            13
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            44.000000000000000000
            '71.4 cu ft Tank'
            585000c
            13
            True)
          (
            22.000000000000000000
            'Dive & Surf'
            47.000000000000000000
            'Marine Super VHS Video Package'
            11241000c
            13
            False)
          (
            1.000000000000000000
            'Cacor Corporation'
            26.000000000000000000
            'Wrist Band Thermometer (C)'
            64800c
            14
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            26.000000000000000000
            'Wrist Band Thermometer (C)'
            64800c
            14
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            23.000000000000000000
            'Wrist Band Thermometer (F)'
            79200c
            14
            True)
          (
            15.000000000000000000
            'Dive Time'
            33.000000000000000000
            'Medium Titanium Knife'
            267665c
            14
            True)
          (
            15.000000000000000000
            'Dive Time'
            33.000000000000000000
            'Medium Titanium Knife'
            267665c
            14
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            25.000000000000000000
            'Depth/Pressure Gauge (Analog)'
            392700c
            14
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            8.000000000000000000
            'Alternate Inflation Regulator'
            858000c
            14
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            8.000000000000000000
            'Alternate Inflation Regulator'
            858000c
            14
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            8.000000000000000000
            'Alternate Inflation Regulator'
            858000c
            14
            True)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            54.000000000000000000
            'Underwater Altimeter'
            1435000c
            14
            False)
          (
            4.000000000000000000
            'Scuba Professionals'
            7.000000000000000000
            'Regulator System'
            1548000c
            14
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            23.000000000000000000
            'Wrist Band Thermometer (F)'
            79200c
            15
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            32.000000000000000000
            'Safety Knife'
            131200c
            15
            True)
          (
            22.000000000000000000
            'Dive & Surf'
            41.000000000000000000
            'Halogen Flashlight'
            191840c
            15
            False)
          (
            4.000000000000000000
            'Scuba Professionals'
            35.000000000000000000
            'Flashlight'
            292500c
            15
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            24.000000000000000000
            'Depth/Pressure Gauge (Digital)'
            536400c
            15
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            44.000000000000000000
            '71.4 cu ft Tank'
            585000c
            15
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            31.000000000000000000
            'Welded Seam Stabilizing Vest'
            1092000c
            15
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            43.000000000000000000
            '95.1 cu ft Tank'
            1300000c
            15
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            19.000000000000000000
            'Electronic Console w/ options'
            1890000c
            15
            True)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            52.000000000000000000
            'Boat Towable Metal Detector'
            2036600c
            15
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            41.000000000000000000
            'Halogen Flashlight'
            191840c
            16
            False)
          (
            4.000000000000000000
            'Scuba Professionals'
            17.000000000000000000
            'Compass (meter only)'
            249600c
            16
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            25.000000000000000000
            'Depth/Pressure Gauge (Analog)'
            392700c
            16
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            44.000000000000000000
            '71.4 cu ft Tank'
            585000c
            16
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            6.000000000000000000
            'Second Stage Regulator'
            735300c
            16
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            18.000000000000000000
            'Depth/Pressure Gauge'
            762200c
            16
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            18.000000000000000000
            'Depth/Pressure Gauge'
            762200c
            16
            True)
          (
            21.000000000000000000
            'Dive Canada'
            11.000000000000000000
            'Second Stage Regulator'
            957900c
            16
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            13.000000000000000000
            'Electronic Console'
            1209000c
            16
            True)
          (
            15.000000000000000000
            'Dive Time'
            4.000000000000000000
            'Second Stage Regulator'
            1241000c
            16
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            22.000000000000000000
            'Navigation Compass'
            91770c
            17
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            34.000000000000000000
            'Chisel Point Knife'
            143500c
            17
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            42.000000000000000000
            '60.6 cu ft Tank'
            572800c
            17
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            8.000000000000000000
            'Alternate Inflation Regulator'
            858000c
            17
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            5.000000000000000000
            'Regulator System'
            1193500c
            17
            True)
          (
            15.000000000000000000
            'Dive Time'
            33.000000000000000000
            'Medium Titanium Knife'
            267665c
            18
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            35.000000000000000000
            'Flashlight'
            292500c
            18
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            36.000000000000000000
            'Medium Stainless Steel Knife'
            343000c
            18
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            8.000000000000000000
            'Alternate Inflation Regulator'
            858000c
            18
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            3.000000000000000000
            'Regulator System'
            1175000c
            18
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            28.000000000000000000
            'Stabilizing Vest'
            1462000c
            18
            True)
          (
            6.000000000000000000
            'Techniques'
            1.000000000000000000
            'Dive kayak'
            13567500c
            18
            False)
          (
            1.000000000000000000
            'Cacor Corporation'
            20.000000000000000000
            'Direct Sighting Compass'
            125820c
            19
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            10.000000000000000000
            'First Stage Regulator'
            646000c
            19
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            10.000000000000000000
            'First Stage Regulator'
            646000c
            19
            True)
          (
            21.000000000000000000
            'Dive Canada'
            11.000000000000000000
            'Second Stage Regulator'
            957900c
            19
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            45.000000000000000000
            '75.8 cu ft Tank'
            963500c
            19
            True)
          (
            15.000000000000000000
            'Dive Time'
            4.000000000000000000
            'Second Stage Regulator'
            1241000c
            19
            True)
          (
            10.000000000000000000
            'Aqua Research Corp.'
            48.000000000000000000
            'Towable Video Camera (B&W)'
            8595700c
            19
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            37.000000000000000000
            'Divers Knife and Sheath'
            273000c
            20
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            38.000000000000000000
            'Large Stainless Steel Knife'
            376000c
            20
            True)
          (
            22.000000000000000000
            'Dive & Surf'
            50.000000000000000000
            'Camera and Case'
            527780c
            20
            False)
          (
            1.000000000000000000
            'Cacor Corporation'
            24.000000000000000000
            'Depth/Pressure Gauge (Digital)'
            536400c
            20
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            6.000000000000000000
            'Second Stage Regulator'
            735300c
            20
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            6.000000000000000000
            'Second Stage Regulator'
            735300c
            20
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            43.000000000000000000
            '95.1 cu ft Tank'
            1300000c
            20
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            30.000000000000000000
            'Trim Fit Stabilizing Vest'
            1382500c
            20
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            7.000000000000000000
            'Regulator System'
            1548000c
            20
            True)
          (
            21.000000000000000000
            'Dive Canada'
            27.000000000000000000
            'Dive Computer'
            2535000c
            20
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            26.000000000000000000
            'Wrist Band Thermometer (C)'
            64800c
            21
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            32.000000000000000000
            'Safety Knife'
            131200c
            21
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            38.000000000000000000
            'Large Stainless Steel Knife'
            376000c
            21
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            10.000000000000000000
            'First Stage Regulator'
            646000c
            21
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            18.000000000000000000
            'Depth/Pressure Gauge'
            762200c
            21
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            30.000000000000000000
            'Trim Fit Stabilizing Vest'
            1382500c
            21
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            19.000000000000000000
            'Electronic Console w/ options'
            1890000c
            21
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            16.000000000000000000
            'Compass Console Mount'
            101500c
            22
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            32.000000000000000000
            'Safety Knife'
            131200c
            22
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            37.000000000000000000
            'Divers Knife and Sheath'
            273000c
            22
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            14.000000000000000000
            'Depth/Pressure Gauge'
            483000c
            22
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            21.000000000000000000
            'Dive Computer'
            769700c
            22
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            28.000000000000000000
            'Stabilizing Vest'
            1462000c
            22
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            19.000000000000000000
            'Electronic Console w/ options'
            1890000c
            22
            True)
          (
            21.000000000000000000
            'Dive Canada'
            27.000000000000000000
            'Dive Computer'
            2535000c
            22
            True)
          (
            10.000000000000000000
            'Aqua Research Corp.'
            49.000000000000000000
            'Towable Video Camera (Color)'
            14845500c
            22
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            24.000000000000000000
            'Depth/Pressure Gauge (Digital)'
            536400c
            23
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            6.000000000000000000
            'Second Stage Regulator'
            735300c
            23
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            29.000000000000000000
            'Front Clip Stabilizing Vest'
            1288000c
            23
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            30.000000000000000000
            'Trim Fit Stabilizing Vest'
            1382500c
            23
            True)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            46.000000000000000000
            'Remotely Operated Video System'
            7107000c
            23
            False)
          (
            22.000000000000000000
            'Dive & Surf'
            47.000000000000000000
            'Marine Super VHS Video Package'
            11241000c
            23
            False)
          (
            4.000000000000000000
            'Scuba Professionals'
            32.000000000000000000
            'Safety Knife'
            131200c
            24
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            38.000000000000000000
            'Large Stainless Steel Knife'
            376000c
            24
            True)
          (
            22.000000000000000000
            'Dive & Surf'
            40.000000000000000000
            'Flashlight (Rechargeable)'
            509850c
            24
            False)
          (
            15.000000000000000000
            'Dive Time'
            4.000000000000000000
            'Second Stage Regulator'
            1241000c
            24
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            28.000000000000000000
            'Stabilizing Vest'
            1462000c
            24
            True)
          (
            10.000000000000000000
            'Aqua Research Corp.'
            48.000000000000000000
            'Towable Video Camera (B&W)'
            8595700c
            24
            True)
          (
            10.000000000000000000
            'Aqua Research Corp.'
            48.000000000000000000
            'Towable Video Camera (B&W)'
            8595700c
            24
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            22.000000000000000000
            'Navigation Compass'
            91770c
            25
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            16.000000000000000000
            'Compass Console Mount'
            101500c
            25
            True)
          (
            15.000000000000000000
            'Dive Time'
            33.000000000000000000
            'Medium Titanium Knife'
            267665c
            25
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            37.000000000000000000
            'Divers Knife and Sheath'
            273000c
            25
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            36.000000000000000000
            'Medium Stainless Steel Knife'
            343000c
            25
            True)
          (
            21.000000000000000000
            'Dive Canada'
            12.000000000000000000
            'Depth/Pressure Gauge Console'
            733200c
            25
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            6.000000000000000000
            'Second Stage Regulator'
            735300c
            25
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            18.000000000000000000
            'Depth/Pressure Gauge'
            762200c
            25
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            8.000000000000000000
            'Alternate Inflation Regulator'
            858000c
            25
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            5.000000000000000000
            'Regulator System'
            1193500c
            25
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            43.000000000000000000
            '95.1 cu ft Tank'
            1300000c
            25
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            19.000000000000000000
            'Electronic Console w/ options'
            1890000c
            25
            True)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            46.000000000000000000
            'Remotely Operated Video System'
            7107000c
            25
            False)
          (
            6.000000000000000000
            'Techniques'
            1.000000000000000000
            'Dive kayak'
            13567500c
            25
            False)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            54.000000000000000000
            'Underwater Altimeter'
            1435000c
            26
            False)
          (
            4.000000000000000000
            'Scuba Professionals'
            15.000000000000000000
            'Personal Dive Sonar'
            728500c
            32
            True)
          (
            10.000000000000000000
            'Aqua Research Corp.'
            48.000000000000000000
            'Towable Video Camera (B&W)'
            8595700c
            32
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            34.000000000000000000
            'Chisel Point Knife'
            143500c
            34
            True)
          (
            21.000000000000000000
            'Dive Canada'
            27.000000000000000000
            'Dive Computer'
            2535000c
            34
            True)
          (
            3.000000000000000000
            'J.W.  Luscher Mfg.'
            57.000000000000000000
            'Underwater Metal Detector'
            4405100c
            34
            False)
          (
            15.000000000000000000
            'Dive Time'
            33.000000000000000000
            'Medium Titanium Knife'
            267665c
            35
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            14.000000000000000000
            'Depth/Pressure Gauge'
            483000c
            35
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            37.000000000000000000
            'Divers Knife and Sheath'
            273000c
            42
            True)
          (
            21.000000000000000000
            'Dive Canada'
            27.000000000000000000
            'Dive Computer'
            2535000c
            43
            True)
          (
            13.000000000000000000
            'Nautical Compressors'
            59.000000000000000000
            'Air Compressor'
            9868500c
            43
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            34.000000000000000000
            'Chisel Point Knife'
            143500c
            45
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            17.000000000000000000
            'Compass (meter only)'
            249600c
            45
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            10.000000000000000000
            'First Stage Regulator'
            646000c
            45
            True)
          (
            21.000000000000000000
            'Dive Canada'
            12.000000000000000000
            'Depth/Pressure Gauge Console'
            733200c
            45
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            8.000000000000000000
            'Alternate Inflation Regulator'
            858000c
            45
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            31.000000000000000000
            'Welded Seam Stabilizing Vest'
            1092000c
            45
            True)
          (
            22.000000000000000000
            'Dive & Surf'
            47.000000000000000000
            'Marine Super VHS Video Package'
            11241000c
            45
            False)
          (
            4.000000000000000000
            'Scuba Professionals'
            7.000000000000000000
            'Regulator System'
            1548000c
            46
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            23.000000000000000000
            'Wrist Band Thermometer (F)'
            79200c
            54
            True)
          (
            22.000000000000000000
            'Dive & Surf'
            50.000000000000000000
            'Camera and Case'
            527780c
            54
            False)
          (
            4.000000000000000000
            'Scuba Professionals'
            42.000000000000000000
            '60.6 cu ft Tank'
            572800c
            54
            True)
          (
            21.000000000000000000
            'Dive Canada'
            12.000000000000000000
            'Depth/Pressure Gauge Console'
            733200c
            54
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            30.000000000000000000
            'Trim Fit Stabilizing Vest'
            1382500c
            54
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            28.000000000000000000
            'Stabilizing Vest'
            1462000c
            55
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            34.000000000000000000
            'Chisel Point Knife'
            143500c
            56
            True)
          (
            22.000000000000000000
            'Dive & Surf'
            39.000000000000000000
            'Krypton Flashlight'
            206770c
            65
            False)
          (
            4.000000000000000000
            'Scuba Professionals'
            31.000000000000000000
            'Welded Seam Stabilizing Vest'
            1092000c
            65
            True)
          (
            1.000000000000000000
            'Cacor Corporation'
            22.000000000000000000
            'Navigation Compass'
            91770c
            71
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            35.000000000000000000
            'Flashlight'
            292500c
            87
            True)
          (
            4.000000000000000000
            'Scuba Professionals'
            35.000000000000000000
            'Flashlight'
            292500c
            89
            True)
          (
            22.000000000000000000
            'Dive & Surf'
            40.000000000000000000
            'Flashlight (Rechargeable)'
            509850c
            120
            False))
      end
    end
  end
  object SaveDialog1: TSaveDialog
    Left = 384
    Top = 112
  end
  object OpenDialog1: TOpenDialog
    Left = 384
    Top = 168
  end
end
