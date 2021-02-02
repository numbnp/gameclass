object PictureEditorDialog: TPictureEditorDialog
  Left = 232
  Top = 143
  Anchors = [akLeft, akBottom]
  BorderIcons = [biSystemMenu]
  Caption = 'Picture Editor'
  ClientHeight = 321
  ClientWidth = 392
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    392
    321)
  PixelsPerInch = 96
  TextHeight = 13
  object OKButton: TButton
    Left = 308
    Top = 12
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object CancelButton: TButton
    Left = 308
    Top = 41
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object GroupBox1: TGroupBox
    Left = 10
    Top = 7
    Width = 289
    Height = 306
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 2
    DesignSize = (
      289
      306)
    object ImageShape: TShape
      Left = 8
      Top = 8
      Width = 274
      Height = 254
      Anchors = [akLeft, akTop, akRight, akBottom]
    end
    object Load: TButton
      Left = 10
      Top = 270
      Width = 75
      Height = 23
      Anchors = [akLeft, akBottom]
      Caption = '&Load...'
      TabOrder = 0
      OnClick = LoadClick
    end
    object Save: TButton
      Left = 90
      Top = 270
      Width = 75
      Height = 23
      Anchors = [akLeft, akBottom]
      Caption = '&Save...'
      TabOrder = 1
      OnClick = SaveClick
    end
    object Clear: TButton
      Left = 170
      Top = 270
      Width = 75
      Height = 23
      Anchors = [akLeft, akBottom]
      Caption = '&Clear'
      TabOrder = 2
      OnClick = ClearClick
    end
  end
  object bCut: TButton
    Left = 308
    Top = 86
    Width = 75
    Height = 23
    Anchors = [akTop, akRight]
    Caption = 'Cut'
    TabOrder = 3
    OnClick = bCutClick
  end
  object bCopy: TButton
    Left = 308
    Top = 113
    Width = 75
    Height = 23
    Anchors = [akTop, akRight]
    Caption = 'Copy'
    TabOrder = 4
    OnClick = bCopyClick
  end
  object bPaste: TButton
    Left = 308
    Top = 140
    Width = 75
    Height = 23
    Anchors = [akTop, akRight]
    Caption = 'Paste'
    TabOrder = 5
    OnClick = bPasteClick
  end
  object bZoomIn: TButton
    Left = 308
    Top = 182
    Width = 75
    Height = 23
    Anchors = [akTop, akRight]
    Caption = 'Zoom In'
    TabOrder = 6
    OnClick = bZoomInClick
  end
  object bZoomOut: TButton
    Left = 308
    Top = 209
    Width = 75
    Height = 23
    Anchors = [akTop, akRight]
    Caption = 'Zoom Out'
    TabOrder = 7
    OnClick = bZoomOutClick
  end
  object bReset: TButton
    Left = 308
    Top = 236
    Width = 75
    Height = 23
    Anchors = [akTop, akRight]
    Caption = 'Reset'
    TabOrder = 8
    OnClick = bResetClick
  end
  object OpenDialog: TOpenPictureDialog
    Left = 140
    Top = 20
  end
  object SaveDialog: TSavePictureDialog
    Filter = 
      'All (*.bmp;*.ico;*.emf;*.wmf)|*.bmp;*.ico;*.emf;*.wmf|Bitmaps (*' +
      '.bmp)|*.bmp|Icons (*.ico)|*.ico|Enhanced Metafiles (*.emf)|*.emf' +
      '|Metafiles (*.wmf)|*.wmf'
    Options = [ofOverwritePrompt, ofEnableSizing]
    Left = 140
    Top = 76
  end
end
