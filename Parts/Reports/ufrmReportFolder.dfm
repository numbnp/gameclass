object frmReportFolder: TfrmReportFolder
  Left = 233
  Top = 178
  BorderStyle = bsNone
  Caption = 'frmReportFolder'
  ClientHeight = 365
  ClientWidth = 480
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object tvReportFolder: TVirtualStringTree
    Left = 0
    Top = 37
    Width = 480
    Height = 328
    Align = alClient
    Header.AutoSizeIndex = 0
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -11
    Header.Font.Name = 'MS Sans Serif'
    Header.Font.Style = []
    Header.MainColumn = -1
    Header.Options = [hoColumnResize, hoDrag]
    TabOrder = 0
    OnDblClick = tvReportFolderDblClick
    OnFreeNode = tvReportFolderFreeNode
    OnGetImageIndex = tvReportFolderGetImageIndex
    OnInitNode = tvReportFolderInitNode
    OnLoadNode = tvReportFolderLoadNode
    OnSaveNode = tvReportFolderSaveNode
    Columns = <>
  end
  object pnlFolderName: TPanel
    Left = 0
    Top = 0
    Width = 480
    Height = 37
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    DesignSize = (
      480
      37)
    object lblFolder: TLabel
      Left = 8
      Top = 11
      Width = 32
      Height = 13
      Caption = 'Folder:'
    end
    object edtFolderName: TEdit
      Left = 64
      Top = 8
      Width = 409
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnChange = edtFolderNameChange
    end
  end
end
