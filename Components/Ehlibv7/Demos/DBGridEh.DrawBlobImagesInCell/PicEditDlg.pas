{*******************************************************}
{                Picture Editor Dialog                  }
{*******************************************************}

unit PicEditDlg;

interface

uses Windows, Classes, Graphics, Forms, Controls, Dialogs, Buttons,
  StdCtrls, ExtCtrls, ExtDlgs;

type
  TPictureEditorDlg = class(TForm)
    OpenDialog: TOpenPictureDialog;
    SaveDialog: TSavePictureDialog;
    OKButton: TButton;
    CancelButton: TButton;
    GroupBox1: TGroupBox;
    ImagePanel: TPanel;
    Load: TButton;
    Save: TButton;
    Clear: TButton;
    ImagePaintBox: TPaintBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure LoadClick(Sender: TObject);
    procedure SaveClick(Sender: TObject);
    procedure ClearClick(Sender: TObject);
    procedure ImagePaintBoxPaint(Sender: TObject);
  private
    Pic: TPicture;
  end;

  function EditPicture(APic: TPicture): Boolean;

implementation

{$R *.dfm}

const
  SLoadPictureTitle = 'Load Picture';
  SSavePictureTitle = 'Save Picture As';
  srNone = '(None)';

function EditPicture(APic: TPicture): Boolean;
var
  FPicDlg: TPictureEditorDlg;
  GraphicClass: TGraphicClass;
begin
  GraphicClass := TGraphic;
  FPicDlg := TPictureEditorDlg.Create(Application);
  FPicDlg.Pic.Assign(APic);
  with FPicDlg.OpenDialog do
  begin
    Options := [ofHideReadOnly, ofFileMustExist, ofShowHelp];
    DefaultExt := GraphicExtension(GraphicClass);
    Filter := GraphicFilter(GraphicClass);
  end;
  with FPicDlg.SaveDialog do
  begin
    Options := [ofHideReadOnly, ofFileMustExist, ofShowHelp];
    DefaultExt := GraphicExtension(GraphicClass);
    Filter := GraphicFilter(GraphicClass);
  end;
  FPicDlg.Save.Enabled := (APic.Graphic <> nil) and not APic.Graphic.Empty;
  FPicDlg.Clear.Enabled := (APic.Graphic <> nil) and not APic.Graphic.Empty;
  Result := FPicDlg.ShowModal = mrOK;
  if Result then
    APic.Assign(FPicDlg.Pic);
end;

{ TPictureEditorDlg }

procedure TPictureEditorDlg.FormCreate(Sender: TObject);
begin
  Pic := TPicture.Create;
  Save.Enabled := False;
end;

procedure TPictureEditorDlg.FormDestroy(Sender: TObject);
begin
  Pic.Free;
end;

procedure TPictureEditorDlg.LoadClick(Sender: TObject);
begin
  OpenDialog.Title := SLoadPictureTitle;
  if OpenDialog.Execute then
  begin
    Pic.LoadFromFile(OpenDialog.Filename);
    ImagePaintBox.Invalidate;
    Save.Enabled := (Pic.Graphic <> nil) and not Pic.Graphic.Empty;
    Clear.Enabled := (Pic.Graphic <> nil) and not Pic.Graphic.Empty;
  end;
end;

procedure TPictureEditorDlg.SaveClick(Sender: TObject);
begin
  if Pic.Graphic <> nil then
  begin
    SaveDialog.Title := SSavePictureTitle;
    with SaveDialog do
    begin
      DefaultExt := GraphicExtension(TGraphicClass(Pic.Graphic.ClassType));
      Filter := GraphicFilter(TGraphicClass(Pic.Graphic.ClassType));
      if Execute then Pic.SaveToFile(Filename);
    end;
  end;
end;

procedure TPictureEditorDlg.ImagePaintBoxPaint(Sender: TObject);
var
  DrawRect: TRect;
  SNone: string;
begin
  with TPaintBox(Sender) do
  begin
    Canvas.Brush.Color := {Self.}Color;
    DrawRect := ClientRect;//Rect(Left, Top, Left + Width, Top + Height);
    if Pic.Width > 0 then
    begin
      with DrawRect do
        if (Pic.Width > Right - Left) or (Pic.Height > Bottom - Top) then
        begin
          if Pic.Width > Pic.Height then
            Bottom := Top + MulDiv(Pic.Height, Right - Left, Pic.Width)
          else
            Right := Left + MulDiv(Pic.Width, Bottom - Top, Pic.Height);
          Canvas.StretchDraw(DrawRect, Pic.Graphic);
        end
        else
          with DrawRect do
            Canvas.Draw(Left + (Right - Left - Pic.Width) div 2, Top + (Bottom - Top -
              Pic.Height) div 2, Pic.Graphic);
    end
    else
      with DrawRect, Canvas do
      begin
        SNone := srNone;
        TextOut(Left + (Right - Left - TextWidth(SNone)) div 2, Top + (Bottom -
          Top - TextHeight(SNone)) div 2, SNone);
      end;
  end;
end;

procedure TPictureEditorDlg.ClearClick(Sender: TObject);
begin
  Pic.Graphic := nil;
  ImagePaintBox.Invalidate;
  Save.Enabled := False;
  Clear.Enabled := False;
end;

end.
