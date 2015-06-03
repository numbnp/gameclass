object Form1: TForm1
  Left = 310
  Top = 124
  Width = 711
  Height = 467
  Caption = 'Search Filter Demo'
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 388
    Width = 695
    Height = 41
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      695
      41)
    object Button1: TButton
      Left = 8
      Top = 8
      Width = 193
      Height = 25
      Caption = 'Next Demo'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Edit1: TDBEditEh
      Left = 208
      Top = 5
      Width = 481
      Height = 32
      Anchors = [akLeft, akTop, akRight, akBottom]
      AutoSize = False
      BevelKind = bkSoft
      BorderStyle = bsNone
      DynProps = <>
      EditButtons = <>
      ParentColor = True
      ReadOnly = True
      TabOrder = 1
      Text = 'Edit1'
      Visible = True
      WordWrap = True
    end
  end
end
