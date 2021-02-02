object FilterDropDownForm: TFilterDropDownForm
  Left = 393
  Top = 253
  BorderIcons = []
  Caption = 'FilterDropDownForm'
  ClientHeight = 320
  ClientWidth = 273
  Color = clBtnFace
  ParentFont = True
  KeyPreview = True
  OldCreateOrder = True
  OnCreate = CustomDropDownFormEhCreate
  OnDestroy = CustomDropDownFormEhDestroy
  OnKeyDown = CustomDropDownFormEhKeyDown
  FormElements = [ddfeLeftGripEh, ddfeRightGripEh]
  DropDownMode = True
  OnInitForm = CustomDropDownFormEhInitForm
  DesignSize = (
    273
    320)
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 279
    Width = 273
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      273
      41)
    object bOk: TButton
      Left = 101
      Top = 10
      Width = 75
      Height = 22
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
      OnClick = bOkClick
    end
    object bCancel: TButton
      Left = 182
      Top = 10
      Width = 75
      Height = 22
      Anchors = [akTop, akRight]
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
      OnClick = bCancelClick
    end
  end
end
