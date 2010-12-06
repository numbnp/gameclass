object frmSessionsChart: TfrmSessionsChart
  Left = 285
  Top = 399
  BorderStyle = bsNone
  ClientHeight = 250
  ClientWidth = 435
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object chartComps: TDBChart
    Left = 0
    Top = 0
    Width = 423
    Height = 250
    AllowZoom = False
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    MarginBottom = 0
    MarginLeft = 1
    MarginRight = 1
    MarginTop = 0
    Title.AdjustFrame = False
    Title.Text.Strings = (
      'TDBChart')
    Title.Visible = False
    OnClickSeries = chartCompsClickSeries
    OnClickBackground = chartCompsClickBackground
    BottomAxis.Automatic = False
    BottomAxis.AutomaticMaximum = False
    BottomAxis.AutomaticMinimum = False
    BottomAxis.DateTimeFormat = 'hh.mm'
    BottomAxis.Increment = 0.083333333333333300
    BottomAxis.Maximum = 38373.000000000000000000
    BottomAxis.Minimum = 38282.000000000000000000
    DepthAxis.Automatic = False
    DepthAxis.AutomaticMaximum = False
    DepthAxis.AutomaticMinimum = False
    DepthAxis.Maximum = 0.500000000000000000
    DepthAxis.Minimum = -0.500000000000000000
    LeftAxis.Automatic = False
    LeftAxis.AutomaticMaximum = False
    LeftAxis.AutomaticMinimum = False
    LeftAxis.ExactDateTime = False
    LeftAxis.Increment = 1.000000000000000000
    LeftAxis.Inverted = True
    LeftAxis.LabelsOnAxis = False
    LeftAxis.LabelStyle = talValue
    LeftAxis.Maximum = 9.000000000000000000
    LeftAxis.MinorTickCount = 0
    LeftAxis.MinorTickLength = 0
    LeftAxis.MinorTicks.Visible = False
    Legend.ResizeChart = False
    Legend.Visible = False
    RightAxis.Visible = False
    TopAxis.Visible = False
    View3D = False
    View3DOptions.Elevation = 340
    View3DOptions.Perspective = 62
    View3DWalls = False
    OnGetAxisLabel = chartCompsGetAxisLabel
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    OnMouseMove = chartCompsMouseMove
    OnMouseUp = chartCompsMouseUp
    object Series1: TGanttSeries
      ColorEachPoint = True
      Marks.ArrowLength = 0
      Marks.Visible = False
      SeriesColor = clRed
      Title = 'Series'
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = True
      XValues.DateTime = True
      XValues.Name = 'Start'
      XValues.Multiplier = 1.000000000000000000
      XValues.Order = loAscending
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1.000000000000000000
      YValues.Order = loNone
      StartValues.DateTime = True
      StartValues.Name = 'Start'
      StartValues.Multiplier = 1.000000000000000000
      StartValues.Order = loAscending
      EndValues.DateTime = True
      EndValues.Name = 'End'
      EndValues.Multiplier = 1.000000000000000000
      EndValues.Order = loNone
      NextTask.DateTime = False
      NextTask.Name = 'NextTask'
      NextTask.Multiplier = 1.000000000000000000
      NextTask.Order = loNone
    end
  end
  object sbarVertical: TScrollBar
    Left = 423
    Top = 0
    Width = 12
    Height = 250
    Align = alRight
    Kind = sbVertical
    PageSize = 0
    TabOrder = 1
    Visible = False
    OnChange = sbarVerticalChange
  end
  object popupSession: TPopupMenu
    Left = 32
    Top = 8
    object mnuCancel: TMenuItem
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      OnClick = mnuCancelClick
    end
  end
end
