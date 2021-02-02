object fTestConn: TfTestConn
  Left = 1221
  Top = 322
  Width = 441
  Height = 221
  Caption = 'Test Connection'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  DesignSize = (
    425
    182)
  PixelsPerInch = 96
  TextHeight = 13
  object DBMemoEh1: TDBMemoEh
    Left = 8
    Top = 8
    Width = 412
    Height = 129
    Lines.Strings = (
      'DBMemoEh1')
    Anchors = [akLeft, akTop, akRight, akBottom]
    AutoSize = False
    DynProps = <>
    EditButtons = <>
    TabOrder = 0
    Visible = True
    WantReturns = True
  end
  object Button1: TButton
    Left = 8
    Top = 149
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Close'
    ModalResult = 2
    TabOrder = 1
  end
end
