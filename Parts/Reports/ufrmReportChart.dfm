object frmReportChart: TfrmReportChart
  Left = 307
  Top = 201
  BorderStyle = bsNone
  Caption = 'frmReportChart'
  ClientHeight = 391
  ClientWidth = 524
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pnlChartMain: TPanel
    Left = 0
    Top = 0
    Width = 524
    Height = 391
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object pnlHeader: TPanel
      Left = 2
      Top = 2
      Width = 520
      Height = 38
      Align = alTop
      BevelOuter = bvNone
      Color = clWindow
      TabOrder = 0
      object lblChartY: TLabel
        Left = 201
        Top = 12
        Width = 10
        Height = 13
        Caption = 'Y:'
      end
      object lblChartX: TLabel
        Left = 24
        Top = 12
        Width = 10
        Height = 13
        Caption = 'X:'
      end
      object cboChartX: TComboBox
        Left = 40
        Top = 9
        Width = 145
        Height = 21
        BevelKind = bkFlat
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 0
      end
      object cboChartY: TComboBox
        Left = 217
        Top = 9
        Width = 145
        Height = 21
        BevelKind = bkFlat
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 1
      end
      object btnApply: TButton
        Left = 383
        Top = 6
        Width = 75
        Height = 25
        Caption = 'Apply'
        TabOrder = 2
        OnClick = btnApplyClick
      end
    end
    object chartReport: TDBChart
      Left = 2
      Top = 40
      Width = 520
      Height = 349
      BackWall.Brush.Color = clWhite
      Title.Text.Strings = (
        'TDBChart')
      View3D = False
      View3DOptions.Elevation = 315
      View3DOptions.Orthogonal = False
      View3DOptions.Perspective = 0
      View3DOptions.Rotation = 360
      Align = alClient
      BevelOuter = bvNone
      Color = clWindow
      TabOrder = 1
      object Series1: TBarSeries
        Marks.ArrowLength = 20
        Marks.Visible = True
        SeriesColor = clRed
        XValues.DateTime = False
        XValues.Name = 'X'
        XValues.Multiplier = 1.000000000000000000
        XValues.Order = loAscending
        YValues.DateTime = False
        YValues.Name = 'Bar'
        YValues.Multiplier = 1.000000000000000000
        YValues.Order = loNone
      end
      object Series2: TAreaSeries
        Active = False
        Marks.ArrowLength = 8
        Marks.Visible = False
        SeriesColor = clGreen
        DrawArea = True
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        Pointer.Visible = False
        XValues.DateTime = False
        XValues.Name = 'X'
        XValues.Multiplier = 1.000000000000000000
        XValues.Order = loAscending
        YValues.DateTime = False
        YValues.Name = 'Y'
        YValues.Multiplier = 1.000000000000000000
        YValues.Order = loNone
      end
      object Series3: TPieSeries
        Active = False
        Marks.ArrowLength = 8
        Marks.Visible = True
        SeriesColor = clYellow
        Circled = True
        OtherSlice.Text = 'Other'
        PieValues.DateTime = False
        PieValues.Name = 'Pie'
        PieValues.Multiplier = 1.000000000000000000
        PieValues.Order = loNone
      end
      object Series4: TLineSeries
        Active = False
        Marks.ArrowLength = 8
        Marks.Visible = False
        SeriesColor = clBlue
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        Pointer.Visible = False
        XValues.DateTime = False
        XValues.Name = 'X'
        XValues.Multiplier = 1.000000000000000000
        XValues.Order = loAscending
        YValues.DateTime = False
        YValues.Name = 'Y'
        YValues.Multiplier = 1.000000000000000000
        YValues.Order = loNone
      end
      object Series5: TPointSeries
        Active = False
        Marks.ArrowLength = 0
        Marks.Visible = False
        SeriesColor = clWhite
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        Pointer.Visible = True
        XValues.DateTime = False
        XValues.Name = 'X'
        XValues.Multiplier = 1.000000000000000000
        XValues.Order = loAscending
        YValues.DateTime = False
        YValues.Name = 'Y'
        YValues.Multiplier = 1.000000000000000000
        YValues.Order = loNone
      end
    end
  end
  object dsrcReport: TDataSource
    Left = 16
    Top = 32
  end
  object dlgSave: TSaveDialog
    DefaultExt = 'bmp'
    FileName = 'chart.bmp'
    Filter = 'Bitmap (*.bmp)|*.bmp'
    Left = 50
    Top = 32
  end
end
