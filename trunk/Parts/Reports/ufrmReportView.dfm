object frmReportView: TfrmReportView
  Left = 1777
  Top = 171
  BorderStyle = bsNone
  Caption = 'frmReportView'
  ClientHeight = 453
  ClientWidth = 688
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object grdReport: TDBGridEh
    Left = 0
    Top = 0
    Width = 688
    Height = 453
    Align = alClient
    DataSource = dsrcReport
    EditActions = [geaCopyEh, geaSelectAllEh]
    Flat = True
    FooterColor = clWindow
    FooterFont.Charset = DEFAULT_CHARSET
    FooterFont.Color = clWindowText
    FooterFont.Height = -11
    FooterFont.Name = 'MS Sans Serif'
    FooterFont.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
    OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghDialogFind]
    PopupMenu = pmnuReport
    SortLocal = True
    STFilter.Local = True
    SumList.Active = True
    SumList.VirtualRecords = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    UseMultiTitle = True
    FilterStringColor = clWindow
    OnSortMarkingChanged = grdReportSortMarkingChanged
  end
  object dsrcReport: TDataSource
    OnDataChange = dsrcReportDataChange
    Left = 112
    Top = 8
  end
  object pmnuReport: TPopupMenu
    Left = 152
    Top = 8
    object pmiColumnsVisibility: TMenuItem
      Caption = 'Columns Visibility'
      object pmiColumnsVisibilitySettings: TMenuItem
        Caption = 'Settings...'
        OnClick = OnSetColumnsVisibilityClick
      end
      object pmiSeparator1: TMenuItem
        Caption = '-'
      end
      object pmiShowAllColumns: TMenuItem
        Caption = 'Show All Columns'
        OnClick = OnAllVisibleClick
      end
      object pmiShowGeneralColumns: TMenuItem
        Caption = 'Show General Columns'
        OnClick = OnGeneralVisibleClick
      end
      object pmiSeparator2: TMenuItem
        Caption = '-'
      end
    end
  end
  object dlgSave: TSaveDialog
    DefaultExt = 'htm'
    Filter = 
      'HTML (*.htm)|*.htm|Rich Text Format (*.rtf)|*.rtf|Excel File (*.' +
      'xls)|*.xls|Text (*.txt)|*.txt|CSV (*.csv)|*.csv'
    Left = 200
    Top = 8
  end
  object prnGrid: TPrintDBGridEh
    DBGridEh = grdReport
    Options = []
    PageFooter.Font.Charset = DEFAULT_CHARSET
    PageFooter.Font.Color = clWindowText
    PageFooter.Font.Height = -11
    PageFooter.Font.Name = 'MS Sans Serif'
    PageFooter.Font.Style = []
    PageHeader.Font.Charset = DEFAULT_CHARSET
    PageHeader.Font.Color = clWindowText
    PageHeader.Font.Height = -11
    PageHeader.Font.Name = 'MS Sans Serif'
    PageHeader.Font.Style = []
    Units = MM
    Left = 240
    Top = 8
  end
end
