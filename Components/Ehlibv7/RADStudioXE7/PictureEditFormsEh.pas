{*******************************************************}
{                                                       }
{                       EhLib v6.4                      }
{                    PictureEdit Dialog                 }
{                     (Build 6.4.XX)                    }
{                                                       }
{     Copyright (c) 2013-2014 by Dmitry V. Bolshakov    }
{                                                       }
{*******************************************************}

unit PictureEditFormsEh;

interface

uses Windows, Classes, Graphics, Forms, Controls, Dialogs, Buttons,
  StdCtrls, ExtCtrls, ExtDlgs, DBCtrlsEh;

type

  TDialogAllowedEditOperationEh = (dealopCutEh, dealopCopyEh, dealopPasteEh,
    dealopLoadEh, dealopSaveEh, dealopClearEh, dealopZoomingEh, dealopShiftEh);

  TDialogAllowedEditOperationsEh = set of TDialogAllowedEditOperationEh;

const
  DialogAllowedEditOperationsAll = [dealopCutEh, dealopCopyEh, dealopPasteEh,
    dealopLoadEh, dealopSaveEh, dealopClearEh, dealopZoomingEh, dealopShiftEh];

type

{ TCustomPictureEditorDialog }

  TCustomPictureEditorDialog = class(TForm)
  public
    function Edit(Picture: TPicture; AllowsOperations: TDialogAllowedEditOperationsEh = DialogAllowedEditOperationsAll): Boolean; virtual;
  end;

  TCustomPictureEditorDialogClass = class of TCustomPictureEditorDialog;

{ TPictureEditorDialog }

  TPictureEditorDialog = class(TCustomPictureEditorDialog)
    OpenDialog: TOpenPictureDialog;
    SaveDialog: TSavePictureDialog;
    OKButton: TButton;
    CancelButton: TButton;
    GroupBox1: TGroupBox;
    Load: TButton;
    Save: TButton;
    Clear: TButton;
    bCut: TButton;
    bCopy: TButton;
    bPaste: TButton;
    bZoomIn: TButton;
    bZoomOut: TButton;
    bReset: TButton;
    ImageShape: TShape;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure LoadClick(Sender: TObject);
    procedure SaveClick(Sender: TObject);
    procedure ClearClick(Sender: TObject);
//    procedure HelpButtonClick(Sender: TObject);
    procedure ImagePaintBoxPaint(Sender: TObject);
    procedure bCutClick(Sender: TObject);
    procedure bCopyClick(Sender: TObject);
    procedure bPasteClick(Sender: TObject);
    procedure bResetClick(Sender: TObject);
    procedure bZoomOutClick(Sender: TObject);
    procedure bZoomInClick(Sender: TObject);
  private
    Image: TDBImageEh;
  public
    function Edit(Picture: TPicture; AllowsOperations: TDialogAllowedEditOperationsEh = DialogAllowedEditOperationsAll): Boolean; override;
  end;

//function ShowGraphicEditorEh(Graphic: TGraphic): Boolean;
function DefaultShowPictureEditDialogEh(Picture: TPicture): Boolean;

type
  TShowPictureEditDialogEhProg = function (Picture: TPicture): Boolean;

var
  PictureEditorDialog: TCustomPictureEditorDialog;
  DefaultDBImageEhEditDialogClass: TCustomPictureEditorDialogClass;
  ShowPictureEditDialogEhProg: TShowPictureEditDialogEhProg;

implementation

uses TypInfo, SysUtils;

{$R *.dfm}

{ TCustomPictureEditorDialog }

function TCustomPictureEditorDialog.Edit(Picture: TPicture;
  AllowsOperations: TDialogAllowedEditOperationsEh = DialogAllowedEditOperationsAll): Boolean;
begin
  Result := False;
end;

function DefaultShowPictureEditDialogEh(Picture: TPicture): Boolean;
begin
  if PictureEditorDialog = nil then
    PictureEditorDialog := DefaultDBImageEhEditDialogClass.Create(Application);

  Result := PictureEditorDialog.Edit(Picture);
end;

(*function ShowGraphicEditorEh(Graphic: TGraphic): Boolean;
begin
  Result := False;
  if PictureEditorDialog = nil then
    PictureEditorDialog := DefaultDBImageEhEditDialogFormClass.Create(Application);

  Result := PictureEditorDialog.Edit(Picture);
end;
*)

{ TPictureEditorDlg }

function TPictureEditorDialog.Edit(Picture: TPicture;
  AllowsOperations: TDialogAllowedEditOperationsEh): Boolean;
begin
  Result := False;
  Image.Picture.Assign(Picture);
  bCut.Enabled := (dealopCutEh in AllowsOperations);
  bCopy.Enabled := (dealopCopyEh in AllowsOperations);
  bPaste.Enabled := (dealopPasteEh in AllowsOperations);
  Load.Enabled := (dealopLoadEh in AllowsOperations);
  Save.Enabled := (dealopSaveEh in AllowsOperations);
  Clear.Enabled := (dealopClearEh in AllowsOperations);
  bZoomIn.Enabled := (dealopZoomingEh in AllowsOperations);
  bZoomOut.Enabled := (dealopZoomingEh in AllowsOperations);
  bReset.Enabled := (dealopShiftEh in AllowsOperations) or (dealopZoomingEh in AllowsOperations);

  if ShowModal = mrOk then
  begin
    Result := True;
    Picture.Assign(Image.Picture);
  end;
end;

procedure TPictureEditorDialog.FormCreate(Sender: TObject);
begin
//  HelpContext := hcDPictureEditor;
//  Pic := TPicture.Create;
  Save.Enabled := False;
  Image := TDBImageEh.Create(Self);
  Image.Parent := ImageShape.Parent;
  Image.SetBounds(ImageShape.Left, ImageShape.Top, ImageShape.Width, ImageShape.Height);
  Image.Anchors := ImageShape.Anchors;
  Image.Color := clMoneyGreen;
//  Image.EditButton.Visible := True;

end;

procedure TPictureEditorDialog.FormDestroy(Sender: TObject);
begin
//  FreeAndNil(Pic);
  FreeAndNil(Image);
end;

procedure TPictureEditorDialog.LoadClick(Sender: TObject);
begin
//  OpenDialog.Title := SLoadPictureTitle;
  if OpenDialog.Execute then
  begin
    Image.Picture.LoadFromFile(OpenDialog.Filename);
//    ImagePaintBox.Invalidate;
    Save.Enabled := (Image.Picture.Graphic <> nil) and not Image.Picture.Graphic.Empty;
    Clear.Enabled := (Image.Picture.Graphic <> nil) and not Image.Picture.Graphic.Empty;
  end;
end;

procedure TPictureEditorDialog.SaveClick(Sender: TObject);
begin
  if Image.Picture.Graphic <> nil then
  begin
//    SaveDialog.Title := SSavePictureTitle;
    with SaveDialog do
    begin
      DefaultExt := GraphicExtension(TGraphicClass(Image.Picture.Graphic.ClassType));
      Filter := GraphicFilter(TGraphicClass(Image.Picture.Graphic.ClassType));
      if Execute then Image.Picture.SaveToFile(Filename);
    end;
  end;
end;

procedure TPictureEditorDialog.ImagePaintBoxPaint(Sender: TObject);
var
  DrawRect: TRect;
  SNone: string;
begin
  with TPaintBox(Sender) do
  begin
    Canvas.Brush.Color := {Self.}Color;
    DrawRect := ClientRect;//Rect(Left, Top, Left + Width, Top + Height);
    if Image.Picture.Width > 0 then
    begin
      with DrawRect do
        if (Image.Picture.Width > Right - Left) or (Image.Picture.Height > Bottom - Top) then
        begin
          if Image.Picture.Width > Image.Picture.Height then
            Bottom := Top + MulDiv(Image.Picture.Height, Right - Left, Image.Picture.Width)
          else
            Right := Left + MulDiv(Image.Picture.Width, Bottom - Top, Image.Picture.Height);
          Canvas.StretchDraw(DrawRect, Image.Picture.Graphic);
        end
        else
          with DrawRect do
            Canvas.Draw(Left + (Right - Left - Image.Picture.Width) div 2, Top + (Bottom - Top -
              Image.Picture.Height) div 2, Image.Picture.Graphic);
    end
    else
      with DrawRect, Canvas do
      begin
        SNone := 'srNone';
        TextOut(Left + (Right - Left - TextWidth(SNone)) div 2, Top + (Bottom -
          Top - TextHeight(SNone)) div 2, SNone);
      end;
  end;
end;

procedure TPictureEditorDialog.bCopyClick(Sender: TObject);
begin
  Image.CopyToClipboard;
end;

procedure TPictureEditorDialog.bCutClick(Sender: TObject);
begin
  Image.CutToClipboard;
end;

procedure TPictureEditorDialog.bPasteClick(Sender: TObject);
begin
  Image.PasteFromClipboard;
end;

procedure TPictureEditorDialog.bZoomInClick(Sender: TObject);
begin
  Image.TemporaryZoomTo(Image.Zoom + 10);
end;

procedure TPictureEditorDialog.bZoomOutClick(Sender: TObject);
begin
  Image.TemporaryZoomTo(Image.Zoom - 10);
end;

procedure TPictureEditorDialog.bResetClick(Sender: TObject);
begin
  Image.ResetZoom;
  Image.ResetPos;
end;

procedure TPictureEditorDialog.ClearClick(Sender: TObject);
begin
  Image.Picture.Graphic := nil;
//  ImagePaintBox.Invalidate;
  Save.Enabled := False;
  Clear.Enabled := False;
end;

initialization
  DefaultDBImageEhEditDialogClass := TPictureEditorDialog;
  ShowPictureEditDialogEhProg := @DefaultShowPictureEditDialogEh;
end.
